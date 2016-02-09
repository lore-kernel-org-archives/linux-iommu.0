From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Subject: DMAR error messages after 'shutdown -r'.
Date: Tue, 09 Feb 2016 14:59:00 -0500
Message-ID: <38172.1455047940@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1455047940_2220P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

--==_Exmh_1455047940_2220P
Content-Type: text/plain; charset=us-ascii

Am seeing some DMAR error messages on reboot after a 'shutdown -r now'.
(Finally got annoyed enough to track it down while doing a git bisect)

Hardware: Dell Latitude E6530 laptop.

Working (booting from power-off state):

[    0.027673] Freeing SMP alternatives memory: 28K (ffffffffb5111000 - ffffffffb5118000)
[    0.048239] ftrace: allocating 31090 entries in 122 pages
[    0.061910] DMAR: Host address width 36
[    0.061913] DMAR: DRHD base: 0x000000fed90000 flags: 0x1
[    0.061966] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap c9008020660262 ecap f0105a
[    0.061968] DMAR: RMRR base: 0x000000cdb11000 end: 0x000000cdb30fff
[    0.061972] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed90000 IOMMU 0
[    0.061974] DMAR-IR: HPET id 0 under DRHD base 0xfed90000
[    0.061975] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.062187] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.062189] x2apic enabled

Failure mode (rebooting after a shutdown -r)

[    0.027629] Freeing SMP alternatives memory: 28K (ffffffff8e111000 - ffffffff8e118000)
[    0.048199] ftrace: allocating 31090 entries in 122 pages
[    0.061837] DMAR: Host address width 36
[    0.061841] DMAR: DRHD base: 0x000000fed90000 flags: 0x1
[    0.061894] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap c9008020660262 ecap f0105a
[    0.061896] DMAR: RMRR base: 0x000000cdb11000 end: 0x000000cdb30fff
[    0.061899] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed90000 IOMMU 0
[    0.061901] DMAR-IR: HPET id 0 under DRHD base 0xfed90000
[    0.061903] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
---- Error here....
[    0.062027] DMAR: DRHD: handling fault status reg 2
[    0.062034] DMAR: DMAR:[DMA Read] Request device [00:1f.2] fault addr cdacd000
               DMAR:[fault reason 06] PTE Read access is not set
----
[    0.062132] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.062134] x2apic enabled

CPU: Intel(R) Core(TM) i5-3340M CPU @ 2.70GH

lspci:
00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM Controller (rev 09)
00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v2/3rd Gen Core processor PCI Express Root Port (rev 09)
00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family USB xHCI Host Controller (rev 04)
00:16.0 Communication controller: Intel Corporation 7 Series/C210 Series Chipset Family MEI Controller #1 (rev 04)
00:19.0 Ethernet controller: Intel Corporation 82579LM Gigabit Network Connection (rev 04)
00:1a.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family USB Enhanced Host Controller #2 (rev 04)
00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset Family High Definition Audio Controller (rev 04)
00:1c.0 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI Express Root Port 1 (rev c4)
00:1c.1 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI Express Root Port 2 (rev c4)
00:1c.2 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI Express Root Port 3 (rev c4)
00:1c.3 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI Express Root Port 4 (rev c4)
00:1c.5 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI Express Root Port 6 (rev c4)
00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family USB Enhanced Host Controller #1 (rev 04)
00:1f.0 ISA bridge: Intel Corporation QM77 Express Chipset LPC Controller (rev 04)
00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family 6-port SATA Controller [AHCI mode] (rev 04)
00:1f.3 SMBus: Intel Corporation 7 Series/C210 Series Chipset Family SMBus Controller (rev 04)
01:00.0 VGA compatible controller: NVIDIA Corporation GF108GLM [NVS 5200M] (rev a1)
01:00.1 Audio device: NVIDIA Corporation GF108 High Definition Audio Controller (rev a1)
03:00.0 Network controller: Broadcom Corporation BCM4313 802.11bgn Wireless Network Adapter (rev 01)
0c:00.0 SD Host controller: O2 Micro, Inc. OZ600FJ0/OZ900FJ0/OZ600FJS SD/MMC Card Reader Controller (rev 05)


--==_Exmh_1455047940_2220P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBVrpFBAdmEQWDXROgAQIYuBAAjqhzZ478IxvKjJ9GoujZr8S/uhMjzwQc
MNwg7Db5J9uTyx87Rgz8LPuXNfjdV877VlKt9k0lkrB4uReugwrOWFKPsAo4xBmI
AB4+lQU0bcPohPjXOZls+j9t4FcetcjfmRA+cFDNxMCGq1W+LmEUgzhjep4cbNDY
KqFt9Qr+2jX4UFeSPEoCBuPvHw5LyPoAPllrIiVMzXl3YZcNwO+QOhBJul2DtgVv
bSckH6OW9T8B1TS9BN/1Q4JMpVZ63agfWBICo412dUvonhuvwqD57MwP8s+PQFDV
8YMXBUKsUr1iTnR0vvZ5DNw0nA9Xq/CuFqNvhfBpWgrhfCF/gEhty+CF9j++yb/w
X5HHv12qwjAL5o3qX/H9SqgyVqTg6ybWzymiaPbiMHtnS8UhyS1WmGcUgxtHvZkr
Qp3tOAMsbo/DaEsx/cX6uByqcziiluv1SmPugmeAYRwCcxOFR0XXLP28iG2jPq8l
T4YiMD+GQfTA9/cFvkp0vhQerxgyl5zblJt+UiXtbrklwRmHaEIR0ymdsfi5OWur
FE1Gu+qzmjXMKJbbLjjCtzjyKgCgpFK+Spw7sixRvOQ/BHXqyePSCQtqneI1tNpb
ZUuMzlBadOo5m+M08BiJauN884kCVM3gTnFulsTRmXULDUrTDppfbKd1Mht0081G
b6iqmQ2Od8o=
=8ML7
-----END PGP SIGNATURE-----

--==_Exmh_1455047940_2220P--
