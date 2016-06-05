From: Marius Vlad <marius.c.vlad@intel.com>
Subject: iommu/vt-d: Use per-cpu IOVA caching,
 suspend-to-ram causes machine hang
Date: Sun, 5 Jun 2016 21:13:45 +0300
Message-ID: <20160605181344.GA6258@mcvlad-wk.rb.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1633363886=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: omer@cs.technion.ac.il
Cc: David.Woodhouse@intel.com, intel-gfx@lists.freedesktop.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org


--===============1633363886==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Omer the following commit introduced a regression when doing
suspend-to-ram. The machine never wakes up. We have more than
a few machines that hang: SNB-i7-2620m, IVB-3370, HSW-4470r, BDW-5600u,
BDW-525u.

You can easily replicate by doing a rtcwake -s 10 -m mem.

22e2f9fa63b092923873fc8a52955151f4d83274 is the first bad commit
commit 22e2f9fa63b092923873fc8a52955151f4d83274
Author: Omer Peleg <omer@cs.technion.ac.il>
Date:   Wed Apr 20 11:34:11 2016 +0300

    iommu/vt-d: Use per-cpu IOVA caching
   =20
    Commit 9257b4a2 ('iommu/iova: introduce per-cpu caching to iova allocat=
ion')
    introduced per-CPU IOVA caches to massively improve scalability. Use th=
em.
   =20
    Signed-off-by: Omer Peleg <omer@cs.technion.ac.il>
    [mad@cs.technion.ac.il: rebased, cleaned up and reworded the commit mes=
sage]
    Signed-off-by: Adam Morrison <mad@cs.technion.ac.il>
    Reviewed-by: Shaohua Li <shli@fb.com>
    Reviewed-by: Ben Serebrin <serebrin@google.com>
    [dwmw2: split out VT-d part into a separate patch]
    Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>

Here's the full bisect log:

git bisect start
# bad: [d1f27215f780b81b5a0151ae5a830669b7d2e2de] drm-intel-nightly: 2016y-=
06m-03d-19h-00m-28s UTC integration manifest
git bisect bad d1f27215f780b81b5a0151ae5a830669b7d2e2de
# good: [2dcd0af568b0cf583645c8a317dd12e344b1c72a] Linux 4.6
git bisect good 2dcd0af568b0cf583645c8a317dd12e344b1c72a
# good: [e0fb1b36398487475e0d2c50264e4ec1eaed3e11] Merge tag 'iommu-updates=
-v4.7' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
git bisect good e0fb1b36398487475e0d2c50264e4ec1eaed3e11
# good: [b1503934a5e51e74b2f4c72ad77b33231e7b6953] scripts/gdb: add cpu ite=
rators
git bisect good b1503934a5e51e74b2f4c72ad77b33231e7b6953
# good: [0e01df100b6bf22a1de61b66657502a6454153c5] Merge tag 'ext4_for_linu=
s' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
git bisect good 0e01df100b6bf22a1de61b66657502a6454153c5
# bad: [aa00edc1287a693eadc7bc67a3d73555d969b35d] make IS_ERR_VALUE() compl=
ain about non-pointer-sized arguments
git bisect bad aa00edc1287a693eadc7bc67a3d73555d969b35d
# good: [ea8ea737c46cffa5d0ee74309f81e55a7e5e9c2a] Merge tag 'nfs-for-4.7-1=
' of git://git.linux-nfs.org/projects/anna/linux-nfs
git bisect good ea8ea737c46cffa5d0ee74309f81e55a7e5e9c2a
# good: [e2fe14564d3316d1625ed20bf1083995f4960893] oom_reaper: close race w=
ith exiting task
git bisect good e2fe14564d3316d1625ed20bf1083995f4960893
# bad: [2566278551d3db875bc3bbfc41b42f2e80392108] Merge git://git.infradead=
=2Eorg/intel-iommu
git bisect bad 2566278551d3db875bc3bbfc41b42f2e80392108
# good: [621ecd8d2123bc13e140b519e01a18200aeb614c] KVM: arm/arm64: vgic-new=
: Add GICv3 SGI system register trap handler
git bisect good 621ecd8d2123bc13e140b519e01a18200aeb614c
# good: [44bcc922381e24c4f38dc5dfd8d34d60b2ede898] Merge tag 'kvm-arm-for-4=
-7-take2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm in=
to kvm-next
git bisect good 44bcc922381e24c4f38dc5dfd8d34d60b2ede898
# good: [f0cf040f842242d55744c2606e8b7177507fbbb0] tools: kvm_stat: Introdu=
ce pid monitoring
git bisect good f0cf040f842242d55744c2606e8b7177507fbbb0
# good: [0824c5920b16fe11034f3b5d2d48456d282d83f9] iommu/vt-d: avoid dev io=
tlb logic for domains with no dev iotlbs
git bisect good 0824c5920b16fe11034f3b5d2d48456d282d83f9
# bad: [22e2f9fa63b092923873fc8a52955151f4d83274] iommu/vt-d: Use per-cpu I=
OVA caching
git bisect bad 22e2f9fa63b092923873fc8a52955151f4d83274
# good: [9257b4a206fc0229dd5f84b78e4d1ebf3f91d270] iommu/iova: introduce pe=
r-cpu caching to iova allocation
git bisect good 9257b4a206fc0229dd5f84b78e4d1ebf3f91d270
# first bad commit: [22e2f9fa63b092923873fc8a52955151f4d83274] iommu/vt-d: =
Use per-cpu IOVA caching

Some info about the machine:

System Information
        Manufacturer: Dell Inc.
        Product Name: Latitude E7450

$ lspci
00:00.0 Host bridge: Intel Corporation Broadwell-U Host Bridge -OPI (rev 09)
00:02.0 VGA compatible controller: Intel Corporation Broadwell-U Integrated=
 Graphics (rev 09)
00:03.0 Audio device: Intel Corporation Broadwell-U Audio Controller (rev 0=
9)
00:04.0 Signal processing controller: Intel Corporation Broadwell-U Camaril=
lo Device (rev 09)
00:14.0 USB controller: Intel Corporation Wildcat Point-LP USB xHCI Control=
ler (rev 03)
00:16.0 Communication controller: Intel Corporation Wildcat Point-LP MEI Co=
ntroller #1 (rev 03)
00:19.0 Ethernet controller: Intel Corporation Ethernet Connection (3) I218=
-LM (rev 03)
00:1b.0 Audio device: Intel Corporation Wildcat Point-LP High Definition Au=
dio Controller (rev 03)
00:1c.0 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express Root Por=
t #1 (rev e3)
00:1c.3 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express Root Por=
t #4 (rev e3)
00:1c.4 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express Root Por=
t #5 (rev e3)
00:1d.0 USB controller: Intel Corporation Wildcat Point-LP USB EHCI Control=
ler (rev 03)
00:1f.0 ISA bridge: Intel Corporation Wildcat Point-LP LPC Controller (rev =
03)
00:1f.2 RAID bus controller: Intel Corporation 82801 Mobile SATA Controller=
 [RAID mode] (rev 03)
00:1f.3 SMBus: Intel Corporation Wildcat Point-LP SMBus Controller (rev 03)
01:00.0 SD Host controller: O2 Micro, Inc. SD/MMC Card Reader Controller (r=
ev 01)
02:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59)

CPU:
model name      : Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJXVGvYAAoJELmLWIAQzyE+XS4H/1Mowf3EsdF4/RH5jMarU2u4
mwrSOl0SAPhT4o3d9kqeGiOedy/CfuExIZP6oxlOHZ4xw+7v3gG4aUHRtmHoSjPR
IEAAWXXfy8Jjd9xaIbJ17EVyPcQE3E8RXLUNhMClDuF35jXQnPx716dGrJzsbVxv
f1iiiY3uZmmopJ+56V3h3GmuWtvBvEd4mgoT/9YOzCwh5xCPjMnT96WJ6rOKkWAd
8YOMw7/ikZaGcS9+GXduw1p87QVOYCAo206sEmuHNybbYP8CXQyw9wATbqHa/V2z
U22yhOR86p/a5lx83KyyJzwNU3STOpZbMN3Qj4pCPBUbH1Z9pu/tW8Fs9E1LkcA=
=DQP4
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--

--===============1633363886==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============1633363886==--
