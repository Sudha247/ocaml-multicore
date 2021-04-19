(* TEST *)

open Ephemeron

let test1 () =
  let k = K1.create () in
  K1.set_key k 100;
  K1.set_data k 1000;
  assert (K1.check_key k);
  assert (K1.check_data k);
  Gc.finalise (fun v -> ignore @@ K1.get_key v) k;
  Gc.finalise (fun v -> ignore @@ K1.get_data v) k;
  let k2 = K2.create () in
  K2.set_key1 k2 100;
  K2.set_key2 k2 200;
  K2.set_data k2 1000;
  assert (K2.check_key1 k2);
  assert (K2.check_key2 k2);
  assert (K2.check_data k2);
  Gc.finalise (fun v -> ignore @@ K2.get_key1 v) k2;
  Gc.finalise (fun v -> ignore @@ K2.get_key2 v) k2;
  Gc.finalise (fun v -> ignore @@ K2.get_data v) k2;
  let kn = Kn.create 16 in
  for i = 0 to 15 do
    Kn.set_key kn i (i * 100)
  done;
  Kn.set_data kn 1000;
  for i = 0 to 15 do
    assert (Kn.check_key kn i)
  done;
  assert (Kn.check_data kn);
  Gc.finalise(fun v ->
    for i = 0 to 15 do
      Kn.get_key v i |> ignore
    done) kn;
  Gc.finalise (fun v -> ignore @@ Kn.get_data v) kn


let _ =
  for _ = 1 to 5 do
    let d = Array.init 4 (fun _ -> Domain.spawn test1) in
    test1 ();
    Array.iter Domain.join d;
    Gc.full_major ()
  done