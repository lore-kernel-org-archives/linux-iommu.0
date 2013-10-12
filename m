From: Paul Menzel <paulepanter-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: IO_PAGE_FAULTS when enabling IOMMU in coreboot for ASUS F2A85-M
Date: Sat, 12 Oct 2013 21:06:42 +0200
Message-ID: <1381604802.12039.3.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4801160402668171201=="
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


--===============4801160402668171201==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-LV9bYTvtLgZfObSZRNGb"


--=-LV9bYTvtLgZfObSZRNGb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux folks,


Rudolf Marek pushed a patch for review to enable the IOMMU in coreboot
for the ASUS F2A85-M [1]. With this patch applied, Linux, I think
3.10-rc1, shows IO_PAGE_FAULT messages.

	$ dmesg
	[=E2=80=A6]
	[    0.000000] ACPI: IVRS 00000000bf144e10 00070 (v02  AMD   AMDIOMMU 0000=
0001 AMD  00000000)
	[    0.000000] ACPI: SSDT 00000000bf144e80 0051F (v02    AMD     ALIB 0000=
0001 MSFT 04000000)
	[    0.000000] ACPI: SSDT 00000000bf1453a0 006B2 (v01 AMD    POWERNOW 0000=
0001 AMD  00000001)
	[    0.000000] ACPI: SSDT 00000000bf145a52 00045 (v02 CORE   COREBOOT 0000=
002A CORE 0000002A)
	[=E2=80=A6]
	[    0.465114] [Firmware Bug]: ACPI: no secondary bus range in _CRS
	[=E2=80=A6]
	[    0.567330] pci 0000:00:00.0: >[1022:1410] type 00 class 0x060000
	[    0.567364] pci 0000:00:00.2: >[1022:1419] type 00 class 0x080600
	[    0.567427] pci 0000:00:01.0: >[1002:9993] type 00 class 0x03000
	[=E2=80=A6]
	[    0.597731] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
	[    0.597899] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PIBR._PRT]
	[    0.597933] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.SBR0._PRT]
	[    0.597972] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.SBR1._PRT]
	[    0.598073]  pci0000:00: >Requesting ACPI _OSC control (0x1d)
	[    0.603808]  pci0000:00: >ACPI _OSC request failed (AE_NOT_FOUND), retu=
rned control mask: 0x1d
	[    0.612397] ACPI _OSC control for PCIe not granted, disabling ASPM
	[    0.620508] Freeing initrd memory: 14876k freed
	[=E2=80=A6]
	[    0.882674] pci 0000:00:01.0: >Boot video device
	[    0.882876] PCI: CLS 64 bytes, default 64
	[    0.897088] AMD-Vi: Enabling IOMMU at 0000:00:00.2 cap 0x40 extended fe=
atures:  PreF PPR GT IA
	[    0.905816] pci 0000:00:00.2: >irq 40 for MSI/MSI-X
	[    0.917457] AMD-Vi: Lazy IO/TLB flushing enabled
	[    0.922076] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
	[    0.928500] software IO TLB [mem 0xbb13d000-0xbf13cfff] (64MB) mapped a=
t [ffff8800bb13d000-ffff8800bf13cfff]
	[    0.938535] LVT offset 0 assigned for vector 0x400
	[    0.943338] perf: AMD IBS detected (0x000000ff)
	[    0.948037] audit: initializing netlink socket (disabled)
	[    0.953432] type=3D2000 audit(1369659616.800:1): initialized
	[    0.977011] HugeTLB registered 2 MB page size, pre-allocated 0 pages
	[=E2=80=A6]
	[    7.881938] radeon 0000:00:01.0: >VRAM: 512M 0x0000000000000000 - 0x000=
000001FFFFFFF (512M used)
	[    7.881941] radeon 0000:00:01.0: >GTT: 512M 0x0000000020000000 - 0x0000=
00003FFFFFFF
	[=E2=80=A6]
	[    7.885516] radeon 0000:00:01.0: >irq 48 for MSI/MSI-X
	[    7.885525] radeon 0000:00:01.0: >radeon: using MSI.
	[=E2=80=A6]
	[    8.276775] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae000 flags=3D0x0010]
	[    8.287363] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001acc00 flags=3D0x0010]
	[    8.297945] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae200 flags=3D0x0010]
	[    8.308527] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae080 flags=3D0x0010]
	[    8.319109] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae240 flags=3D0x0010]
	[    8.329694] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001accc0 flags=3D0x0010]
	[    8.340276] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ace80 flags=3D0x0010]
	[    8.350858] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001acd80 flags=3D0x0010]
	[    8.361441] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae280 flags=3D0x0010]
	[    8.372022] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae180 flags=3D0x0010]
	[    8.382605] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ace00 flags=3D0x0010]
	[    8.393188] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001acdc0 flags=3D0x0010]
	[    8.403770] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ace40 flags=3D0x0010]
	[    8.414353] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae1c0 flags=3D0x0010]
	[    8.424936] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001acc40 flags=3D0x0010]
	[    8.435518] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001acc80 flags=3D0x0010]
	[    8.446100] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae2c0 flags=3D0x0010]
	[    8.456684] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae300 flags=3D0x0010]
	[    8.467265] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae340 flags=3D0x0010]
	[    8.477849] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae380 flags=3D0x0010]
	[    8.488431] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae3c0 flags=3D0x0010]
	[    8.499013] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae0c0 flags=3D0x0010]
	[    8.509596] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001acec0 flags=3D0x0010]
	[    8.520179] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001acd00 flags=3D0x0010]
	[    8.530761] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ad000 flags=3D0x0010]
	[    8.541343] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae400 flags=3D0x0010]
	[    8.551925] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae440 flags=3D0x0010]
	[    8.562509] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001acf00 flags=3D0x0010]
	[    8.573090] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae480 flags=3D0x0010]
	[    8.583675] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae100 flags=3D0x0010]
	[    8.594257] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae4c0 flags=3D0x0010]
	[=E2=80=A6]
	[    8.604840] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001acf40 flags=3D0x0010]
	[    8.615421] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001acd40 flags=3D0x0010]
	[    8.626004] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ad140 flags=3D0x0010]
	[    8.636587] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ad040 flags=3D0x0010]
	[    8.647169] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ad080 flags=3D0x0010]
	[    8.657751] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae500 flags=3D0x0010]
	[    8.668335] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ad100 flags=3D0x0010]
	[    8.678917] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ad0c0 flags=3D0x0010]
	[    8.689499] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001acf80 flags=3D0x0010]
	[    8.700080] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001acfc0 flags=3D0x0010]
	[    8.710664] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae140 flags=3D0x0010]
	[    8.721246] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae040 flags=3D0x0010]
	[    8.731828] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ad180 flags=3D0x0010]
	[    8.742412] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae540 flags=3D0x0010]
	[    8.752995] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ad280 flags=3D0x0010]
	[    8.763577] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ad340 flags=3D0x0010]
	[    8.774160] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ad200 flags=3D0x0010]
	[    8.784741] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ad300 flags=3D0x0010]
	[    8.795324] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae5c0 flags=3D0x0010]
	[    8.805906] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae640 flags=3D0x0010]
	[    8.816490] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ad2c0 flags=3D0x0010]
	[    8.827072] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ad1c0 flags=3D0x0010]
	[    8.837655] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ad240 flags=3D0x0010]
	[    8.848238] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae580 flags=3D0x0010]
	[    8.858819] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae600 flags=3D0x0010]
	[    8.869402] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ad3c0 flags=3D0x0010]
	[    8.879985] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ad380 flags=3D0x0010]
	[    8.890568] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae7c0 flags=3D0x0010]
	[    8.901151] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae740 flags=3D0x0010]
	[    8.911732] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae6c0 flags=3D0x0010]
	[    8.922316] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae780 flags=3D0x0010]
	[    8.932897] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae700 flags=3D0x0010]
	[    8.943480] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:01.0 domain=
=3D0x0003 address=3D0x0000000f001ae680 flags=3D0x0010]
	[    8.963011] [drm] PCIE GART of 512M enabled (table at 0x000000000004000=
0).
	[    8.963165] radeon 0000:00:01.0: >WB enabled
	[=E2=80=A6]

Is this these expected? Does coreboot need to do more setup? As you can
see in the review comments, we do not know [1].

With Linux Mint (Linux 3.8.x) the following messages are in the kernel
ring buffer.

	$ dmesg | egrep -i 'f2a85-m|iommu' # with the patch enabling the IOMMU
	[ 0.000000] DMI: ASUS F2A85-M, BIOS 4.0-4719-g8bb81bb 10/03/2013
	[ 0.000000] ACPI: IVRS 00000000bf134328 00070 (v02 AMD AMDIOMMU 00000001 A=
MD 00000000)
	[ 0.000000] Please enable the IOMMU option in the BIOS setup
	[ 0.874389] AMD-Vi: Applying erratum 746 workaround for IOMMU at 0000:00:0=
0.2
	[ 0.874525] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
	$ dmesg | egrep -i 'f2a85-m|iommu' # without the patch enabling the IOMMU
	[ 0.000000] DMI: ASUS F2A85-M, BIOS 4.0-4717-gb142a51 10/03/2013
	[ 0.000000] Please enable the IOMMU option in the BIOS setup
	[ 0.786948] PCI-DMA: More than 4GB of RAM and no IOMMU
	[ 0.786948] falling back to iommu=3Dsoft.
	[ 0.786955] More than 4GB of memory but GART IOMMU not available.
	[ 0.786959] falling back to iommu=3Dsoft.

So the message =C2=BBPlease enable the IOMMU option in the BIOS setup=C2=AB=
 is
still confusing as it is enabled afterward.

For the record, here are the messages with FreeBSD -current (r255939).

	(freebsd -current, ) $ dmesg | grep -i iommu
	ACPI: IVRS 0xbf134328 00070 (v02 AMD AMDIOMMU 00000001 AMD 00000000)


Thanks,

Paul


[1] http://review.coreboot.org/#/c/3517/

--=-LV9bYTvtLgZfObSZRNGb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iEYEABECAAYFAlJZncIACgkQPX1aK2wOHVivAwCfYj+tLUe6iEGxP4JoKRlOalI8
x2IAnAw2g/os/6z1DLa7EaJeXayobmBt
=8VQm
-----END PGP SIGNATURE-----

--=-LV9bYTvtLgZfObSZRNGb--


--===============4801160402668171201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4801160402668171201==--
