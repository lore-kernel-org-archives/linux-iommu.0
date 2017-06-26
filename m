From: Christian Kauhaus <kc-4ImjS3E6Ur3YxmODkEiZ1Q@public.gmane.org>
Subject: Kernel crashes in iommu_flush_iotlb_psi()
Date: Mon, 26 Jun 2017 17:15:05 +0200
Message-ID: <349d94bb-d51c-f2dc-da4a-779ae85b50e0@flyingcircus.io>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0431657711748704034=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0431657711748704034==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="uwHL4H3x40uTmxoHJAuqPWA71P4oDmLJK"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uwHL4H3x40uTmxoHJAuqPWA71P4oDmLJK
Content-Type: multipart/mixed; boundary="EIXHpNdASimFAhS73qM8e65D2k3RucqbU";
 protected-headers="v1"
From: Christian Kauhaus <kc-4ImjS3E6Ur3YxmODkEiZ1Q@public.gmane.org>
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Message-ID: <349d94bb-d51c-f2dc-da4a-779ae85b50e0-4ImjS3E6Ur3YxmODkEiZ1Q@public.gmane.org>
Subject: Kernel crashes in iommu_flush_iotlb_psi()

--EIXHpNdASimFAhS73qM8e65D2k3RucqbU
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi everyone,

after updating our storage servers to kernel 4.9.33 we experience repeate=
d crashes on some machines.

A typical kernel stacktrace looks like this:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000304=

[136234.369489] IP: [<ffffffff814f1717>] flush_unmaps_timeout+0xa7/0x1c0
[136234.382388] PGD 0 [136234.386238]
[136234.389393] Oops: 0000 [#1] SMP
[136234.395844] Modules linked in: rbd libceph deadline_iosched nf_log_ip=
v4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_log=
_ipv6 nf_log_common xt_LOG xt_limit nf_conntrack_ipv6 nf_defrag_ipv6 xt_c=
onntrack x86_pkg_temp_thermal kvm_intel kvm irqbypass crc32c_intel acpi_c=
pufreq nf_conntrack_ftp nf_conntrack dm_zero dm_thin_pool dm_persistent_d=
ata dm_bio_prison dm_round_robin dm_multipath xts aesni_intel glue_helper=
 lrw ablk_helper cryptd aes_x86_64 fuse dm_snapshot dm_bufio dm_crypt dm_=
mirror dm_region_hash dm_log
[136234.491272] CPU: 6 PID: 40 Comm: ksoftirqd/6 Not tainted 4.9.33 #1
[136234.503785] Hardware name: Thomas-Krenn.AG X9DR3-F/X9DR3-F, BIOS 3.0a=
 07/31/2013
[136234.518733] task: ffff88105b86b900 task.stack: ffffc90006518000
[136234.530735] RIP: 0010:[<ffffffff814f1717>]  [<ffffffff814f1717>] flus=
h_unmaps_timeout+0xa7/0x1c0
[136234.548498] RSP: 0018:ffffc9000651bd18  EFLAGS: 00010006
[136234.559283] RAX: ffff880858a01f48 RBX: 0000000000000000 RCX: ffff8808=
5c246000
[136234.573708] RDX: 000000000000003f RSI: 0000000000000086 RDI: ffff8808=
5d12c5c0
[136234.588133] RBP: ffffc9000651bd68 R08: 0000000000000000 R09: ffff8808=
5d12c5c0
[136234.602558] R10: 0000000000000001 R11: 0000000000000000 R12: ffff8808=
4f8e8a80
[136234.616986] R13: ffff880858a01f48 R14: ffff88085c25a3c0 R15: 00000000=
000fddc9
[136234.631410] FS:  0000000000000000(0000) GS:ffff88107fa00000(0000) knl=
GS:0000000000000000
[136234.647743] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[136234.659393] CR2: 0000000000000304 CR3: 000000073a8a1000 CR4: 00000000=
000406e0
[136234.673815] Stack:
[136234.678013]  0000000000000286 ffff88107fa137c0 000000018108f5c4 ffffc=
9000651bd88
[136234.693095]  ffffffff8108ed23 0000000000000001 ffff88107fa137c8 00000=
00000000100
[136234.708178]  ffffffff814f1670 0000000000000006 ffffc9000651bda0 fffff=
fff810c0915
[136234.723263] Call Trace:
[136234.728337]  [<ffffffff8108ed23>] ? put_prev_entity+0x83/0x850
[136234.740197]  [<ffffffff814f1670>] ? iommu_flush_iotlb_psi+0x120/0x120=

[136234.753243]  [<ffffffff810c0915>] call_timer_fn+0x35/0x120
[136234.764378]  [<ffffffff810c189e>] run_timer_softirq+0x1fe/0x460
[136234.776397]  [<ffffffff818865d7>] __do_softirq+0xe7/0x256
[136234.787369]  [<ffffffff8107ec80>] ? sort_range+0x30/0x30
[136234.798152]  [<ffffffff810635bc>] run_ksoftirqd+0x1c/0x30
[136234.809111]  [<ffffffff8107ed8a>] smpboot_thread_fn+0x10a/0x160
[136234.821117]  [<ffffffff8107b377>] kthread+0xd7/0xf0
[136234.831044]  [<ffffffff8107b2a0>] ? kthread_park+0x60/0x60
[136234.842183]  [<ffffffff81884112>] ret_from_fork+0x22/0x30
[136234.853141] Code: 8b 45 00 85 c0 0f 84 d3 00 00 00 41 f6 46 18 80 0f =
84 02 01 00 00 85 c0 0f 8e b8 00 00 00 31 db eb 3b ba ff ff ff ff 49 0f b=
d d4 <41> 80 bb 04 03 00 00 00 75 7d 49 8d bb 18 03 00 00 4c 89 e2 4c
[136234.893223] RIP  [<ffffffff814f1717>] flush_unmaps_timeout+0xa7/0x1c0=

[136234.906296]  RSP <ffffc9000651bd18>
[136234.913446] CR2: 0000000000000304
[136234.920624] ---[ end trace c3bd71ceb3b717b2 ]---
[136234.930021] Kernel panic - not syncing: Fatal exception in interrupt

As far as I can see, this bug occurs only on machines with a Xeon E5-2620=
=2E

$ lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                24
On-line CPU(s) list:   0-23
Thread(s) per core:    2
Core(s) per socket:    6
Socket(s):             2
NUMA node(s):          2
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 45
Model name:            Intel(R) Xeon(R) CPU E5-2620 0 @ 2.00GHz
Stepping:              7
CPU MHz:               1200.000
CPU max MHz:           2001.0000
CPU min MHz:           1200.0000
BogoMIPS:              4007.87
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              15360K
NUMA node0 CPU(s):     0-5,12-17
NUMA node1 CPU(s):     6-11,18-23

Has anyone an idea how to work around this problem? The crashes are frequ=
ent enough to affect production in our data centers.

Many thanks in advance!

Best regards

Christian

--=20
Dipl-Inf. Christian Kauhaus <>< =C2=B7 kc-4ImjS3E6Ur3YxmODkEiZ1Q@public.gmane.org =C2=B7 +49 345 =
219401-0
Flying Circus Internet Operations GmbH =C2=B7 http://flyingcircus.io
Forsterstra=C3=9Fe 29 =C2=B7 06112 Halle (Saale) =C2=B7 Deutschland
HR Stendal 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, Chri=
stian Zagrodnick


--EIXHpNdASimFAhS73qM8e65D2k3RucqbU--

--uwHL4H3x40uTmxoHJAuqPWA71P4oDmLJK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCgAGBQJZUST5AAoJEDxNM5Hh8d3of/MH/16r1L0qw0m1iD6JSGd9JOr3
OoUEHc0tlwHUkTL0JIRG4ThU4buYuW+Ok4dknZw7RApe2+1yN/rc4VQqFpf2nXJv
OLgRWUMyK6gniWPYbbr+bo7A6rIsXpTfX9Mply1bhPT+czUhWFo67GdmDnRvWnTL
HTKmafFm6D0HjscKXiYaXDjuYIm1yX4jBxseyk/Kut0ocyDbCOPAhhZv8R2ynqGE
Ld4P2HKMF/1wNomLYSQOUfjmwwsmJs+B7fB1xpp71bz2bLXQb0qCr0TXqyjTdv1q
aSfPc7RDh3GvvYuY0pwLl62FF4BWosjYmyQqtUBsuLVHEnCBgPnHdXJq8rIg/Qo=
=ftBs
-----END PGP SIGNATURE-----

--uwHL4H3x40uTmxoHJAuqPWA71P4oDmLJK--

--===============0431657711748704034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0431657711748704034==--
