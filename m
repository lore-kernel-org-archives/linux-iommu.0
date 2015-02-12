From: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Subject: Kernel Oops: iommu related?
Date: Thu, 12 Feb 2015 12:53:42 -0500
Message-ID: <54DCE8A6.4000608@compro.net>
Reply-To: markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

This happens immediately after unloading one of our out of kernel GPL drivers.
The driver has done NOTHING other than load at bootup.  I'm running a 3.18.7
kernel (x86_64) on an AMD platform. I can't see anything obviously wrong in our
driver. It works fine when the iommu is disabled. This particular machine has 7 of
our cards in it. Four in one expansion rack and 3 in another. The 2 PCI expansion
racks use pci-e interface cards installed in the MB.

Feb 12 10:47:15 harley kernel: AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0000 address=0x00000000000ae640 flags=0x0070]
Feb 12 10:47:15 harley kernel: AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0000 address=0x00000000000ae660 flags=0x0070]
Feb 12 10:47:15 harley kernel: AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0000 address=0x00000000000ae670 flags=0x0070]
Feb 12 10:47:27 harley kernel: ------------[ cut here ]------------
Feb 12 10:47:27 harley kernel: WARNING: CPU: 3 PID: 0 at drivers/iommu/amd_iommu.c:2637 dma_ops_domain_unmap.part.13+0x65/0x70()
Feb 12 10:47:27 harley kernel: Modules linked in: bnep bluetooth rfkill iscsi_ibft iscsi_boot_sysfs af_packet nvidia(PO) drm kvm snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_controller 3c59x snd_hda_codec r8169 mii snd_hwdep snd_pcm snd_timer snd xhci_pci xhci_hcd pcspkr serio_raw soundcore crc32_pclmul crc32c_intel aesni_intel aes_x86_64 glue_helper lrw gf128mul ablk_helper cryptd k10temp fam15h_power dgap(C) i2c_piix4 shpchp 8250_fintek tpm_infineon tpm_tis tpm processor thermal_sys dm_mod sr_mod cdrom ata_generic mxm_wmi aic7xxx pata_atiixp ohci_pci aic79xx scsi_transport_spi wmi button sg autofs4 [last unloaded: gpiohsd]
Feb 12 10:47:27 harley kernel: CPU: 3 PID: 0 Comm: swapper/3 Tainted: P        WC O   3.18.7-lcrs #1
Feb 12 10:47:27 harley kernel: Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./990FXA-UD5, BIOS FB 01/23/2013
Feb 12 10:47:27 harley kernel:  0000000000000009 ffff88044fcc3cb8 ffffffff807bde4d 0000000000000000
Feb 12 10:47:27 harley kernel:  0000000000000000 ffff88044fcc3cf8 ffffffff8024cf7c ffff88044fcc3cf8
Feb 12 10:47:27 harley kernel:  ffff8800a62ea460 0000000000000000 0000000000000600 000000000008c940
Feb 12 10:47:27 harley kernel: Call Trace:
Feb 12 10:47:27 harley kernel:  <IRQ>  [<ffffffff807bde4d>] dump_stack+0x4e/0x71
Feb 12 10:47:27 harley kernel:  [<ffffffff8024cf7c>] warn_slowpath_common+0x7c/0xa0
Feb 12 10:47:27 harley kernel:  [<ffffffff8024d045>] warn_slowpath_null+0x15/0x20
Feb 12 10:47:27 harley kernel:  [<ffffffff806a47e5>] dma_ops_domain_unmap.part.13+0x65/0x70
Feb 12 10:47:27 harley kernel:  [<ffffffff806a675b>] __unmap_single.isra.16+0x9b/0x100
Feb 12 10:47:27 harley kernel:  [<ffffffff806a7198>] unmap_page+0x48/0x70
Feb 12 10:47:27 harley kernel:  [<ffffffffa026a373>] boomerang_rx+0x333/0x600 [3c59x]
Feb 12 10:47:27 harley kernel:  [<ffffffffa026a84a>] boomerang_interrupt+0x16a/0x4f0 [3c59x]
Feb 12 10:47:27 harley kernel:  [<ffffffff8029600e>] handle_irq_event_percpu+0x3e/0x1e0
Feb 12 10:47:27 harley kernel:  [<ffffffff802961ec>] handle_irq_event+0x3c/0x60
Feb 12 10:47:27 harley kernel:  [<ffffffff80298bfe>] handle_fasteoi_irq+0x7e/0x130
Feb 12 10:47:27 harley kernel:  [<ffffffff8020543d>] handle_irq+0x1d/0x30
Feb 12 10:47:27 harley kernel:  [<ffffffff80204cee>] do_IRQ+0x4e/0xf0
Feb 12 10:47:27 harley kernel:  [<ffffffff807c596a>] common_interrupt+0x6a/0x6a
Feb 12 10:47:27 harley kernel:  <EOI>  [<ffffffff802a6e23>] ? hrtimer_start+0x13/0x20
Feb 12 10:47:27 harley kernel:  [<ffffffff8020cad7>] ? default_idle+0x17/0x100
Feb 12 10:47:27 harley kernel:  [<ffffffff8020d4ca>] arch_cpu_idle+0xa/0x10
Feb 12 10:47:27 harley kernel:  [<ffffffff80281dda>] cpu_startup_entry+0x34a/0x380
Feb 12 10:47:27 harley kernel:  [<ffffffff802b2cb3>] ? clockevents_register_device+0xe3/0x150
Feb 12 10:47:27 harley kernel:  [<ffffffff80233857>] start_secondary+0x157/0x180
Feb 12 10:47:27 harley kernel: ---[ end trace cfff39a07b78311e ]---
Feb 12 10:47:32 harley kernel: ------------[ cut here ]------------
Feb 12 10:47:32 harley kernel: WARNING: CPU: 2 PID: 0 at drivers/iommu/amd_iommu.c:2637 dma_ops_domain_unmap.part.13+0x65/0x70()
Feb 12 10:47:32 harley kernel: Modules linked in: bnep bluetooth rfkill iscsi_ibft iscsi_boot_sysfs af_packet nvidia(PO) drm kvm snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_controller 3c59x snd_hda_codec r8169 mii snd_hwdep snd_pcm snd_timer snd xhci_pci xhci_hcd pcspkr serio_raw soundcore crc32_pclmul crc32c_intel aesni_intel aes_x86_64 glue_helper lrw gf128mul ablk_helper cryptd k10temp fam15h_power dgap(C) i2c_piix4 shpchp 8250_fintek tpm_infineon tpm_tis tpm processor thermal_sys dm_mod sr_mod cdrom ata_generic mxm_wmi aic7xxx pata_atiixp ohci_pci aic79xx scsi_transport_spi wmi button sg autofs4 [last unloaded: gpiohsd]
Feb 12 10:47:32 harley kernel: CPU: 2 PID: 0 Comm: swapper/2 Tainted: P        WC O   3.18.7-lcrs #1
Feb 12 10:47:32 harley kernel: Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./990FXA-UD5, BIOS FB 01/23/2013
Feb 12 10:47:32 harley kernel:  0000000000000009 ffff88044fc83cb8 ffffffff807bde4d 0000000000000000
Feb 12 10:47:32 harley kernel:  0000000000000000 ffff88044fc83cf8 ffffffff8024cf7c ffffffffa03d0f7b
Feb 12 10:47:32 harley kernel:  ffff8800a62ea478 0000000000000000 0000000000000600 000000000008f900
Feb 12 10:47:32 harley kernel: Call Trace:
Feb 12 10:47:32 harley kernel:  <IRQ>  [<ffffffff807bde4d>] dump_stack+0x4e/0x71
Feb 12 10:47:32 harley kernel:  [<ffffffff8024cf7c>] warn_slowpath_common+0x7c/0xa0
Feb 12 10:47:32 harley kernel:  [<ffffffffa03d0f7b>] ? _nv014745rm+0x9/0x21 [nvidia]
Feb 12 10:47:32 harley kernel:  [<ffffffff8024d045>] warn_slowpath_null+0x15/0x20
Feb 12 10:47:32 harley kernel:  [<ffffffff806a47e5>] dma_ops_domain_unmap.part.13+0x65/0x70
Feb 12 10:47:32 harley kernel:  [<ffffffff806a675b>] __unmap_single.isra.16+0x9b/0x100
Feb 12 10:47:32 harley kernel:  [<ffffffff806a7198>] unmap_page+0x48/0x70
Feb 12 10:47:32 harley kernel:  [<ffffffffa026a373>] boomerang_rx+0x333/0x600 [3c59x]
Feb 12 10:47:32 harley kernel:  [<ffffffffa026a84a>] boomerang_interrupt+0x16a/0x4f0 [3c59x]
Feb 12 10:47:32 harley kernel:  [<ffffffff8029600e>] handle_irq_event_percpu+0x3e/0x1e0
Feb 12 10:47:32 harley kernel:  [<ffffffff802961ec>] handle_irq_event+0x3c/0x60
Feb 12 10:47:32 harley kernel:  [<ffffffff80298bfe>] handle_fasteoi_irq+0x7e/0x130
Feb 12 10:47:32 harley kernel:  [<ffffffff8020543d>] handle_irq+0x1d/0x30
Feb 12 10:47:32 harley kernel:  [<ffffffff80204cee>] do_IRQ+0x4e/0xf0
Feb 12 10:47:32 harley kernel:  [<ffffffff807c596a>] common_interrupt+0x6a/0x6a
Feb 12 10:47:32 harley kernel:  <EOI>  [<ffffffff802a6e23>] ? hrtimer_start+0x13/0x20
Feb 12 10:47:32 harley kernel:  [<ffffffff8020cad7>] ? default_idle+0x17/0x100
Feb 12 10:47:32 harley kernel:  [<ffffffff8020d4ca>] arch_cpu_idle+0xa/0x10
Feb 12 10:47:32 harley kernel:  [<ffffffff80281dda>] cpu_startup_entry+0x34a/0x380
Feb 12 10:47:32 harley kernel:  [<ffffffff802b2cb3>] ? clockevents_register_device+0xe3/0x150
Feb 12 10:47:32 harley kernel:  [<ffffffff80233857>] start_secondary+0x157/0x180
Feb 12 10:47:32 harley kernel: ---[ end trace cfff39a07b78311f ]---
Feb 12 10:47:39 harley kernel: AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x00000000000b1640 flags=0x0020]
Feb 12 10:47:39 harley kernel: AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x00000000000b1660 flags=0x0020]
Feb 12 10:47:39 harley kernel: AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x00000000000b1670 flags=0x0020]

Those are just the first few messages. After they start, syslog is swamped. I have to hit the reset button. An lcpsi follows.

00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI to PCI bridge (external gfx0 port B) (rev 02)
00:02.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI to PCI bridge (PCI express gpp port B)
00:09.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI to PCI bridge (PCI express gpp port H)
00:0a.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI to PCI bridge (external gfx1 port A)
00:0d.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI to PCI bridge (external gfx1 port B)
00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 SATA Controller [IDE mode] (rev 40)
00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
00:12.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
00:13.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
00:13.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 SMBus Controller (rev 42)
00:14.1 IDE interface: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 IDE Controller (rev 40)
00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 Azalia (Intel HDA) (rev 40)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 LPC host controller (rev 40)
00:14.4 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 PCI to PCI Bridge (rev 40)
00:14.5 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI2 Controller
00:15.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] SB700/SB800/SB900 PCI to PCI bridge (PCIE port 0)
00:15.1 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] SB700/SB800/SB900 PCI to PCI bridge (PCIE port 1)
00:15.2 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] SB900 PCI to PCI bridge (PCIE port 2)
00:15.3 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] SB900 PCI to PCI bridge (PCIE port 3)
00:16.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
00:16.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 3
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 5
01:00.0 VGA compatible controller: NVIDIA Corporation G70 [GeForce 7800 GT] (rev a1)
02:00.0 USB controller: Etron Technology, Inc. EJ168 USB 3.0 Host Controller (rev 01)
03:00.0 IDE interface: Marvell Technology Group Ltd. 88SE9172 SATA III 6Gb/s RAID Controller (rev 11)
04:00.0 PCI bridge: PLX Technology, Inc. PEX 8114 PCI Express-to-PCI/PCI-X Bridge (rev bc)
05:04.0 SCSI storage controller: Adaptec ASC-29320ALP U320 (rev 10)
06:06.0 Unassigned class [ff00]: Compro Computer Services, Inc. PCI RTOM (rev 02)
07:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 06)
08:00.0 USB controller: Etron Technology, Inc. EJ168 USB 3.0 Host Controller (rev 01)
09:00.0 IDE interface: Marvell Technology Group Ltd. 88SE9172 SATA III 6Gb/s RAID Controller (rev 11)
0a:00.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200A PCI Express-to-PCI Bridge (rev 03)
0b:04.0 PCI bridge: Pericom Semiconductor PCI to PCI Bridge (rev 02)
0c:04.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
0c:05.0 Intelligent controller [0e80]: PLX Technology, Inc. Device 0480 (rev 54)
0c:06.0 Intelligent controller [0e80]: PLX Technology, Inc. Device 0480 (rev 54)
0c:07.0 Intelligent controller [0e80]: PLX Technology, Inc. Device 0480 (rev 54)
0c:08.0 Intelligent controller [0e80]: PLX Technology, Inc. Device 0480 (rev 54)
0c:09.0 Memory controller: Compro Computer Services, Inc. Device 4360 (rev 4d)
0c:0c.0 PCI bridge: Pericom Semiconductor PCI to PCI Bridge (rev 02)
0d:04.0 Communication controller: Digi International AccelePort Xr 920 (rev 01)
0d:05.0 Communication controller: Digi International AccelePort Xr 920 (rev 01)
0d:06.0 Serial controller: PLX Technology, Inc. PCI9030 32-bit 33MHz PCI <-> IOBus Bridge
0d:07.0 Network controller: VMIC GE-IP PCI5565,PMC5565 Reflective Memory Node (rev 01)
0d:09.0 PCI bridge: Hint Corp HiNT HB4 PCI-PCI Bridge (PCI6150) (rev 04)
0d:0a.0 SCSI storage controller: Adaptec AHA-2930CU (rev 03)
0e:00.0 Unassigned class [ff00]: Compro Computer Services, Inc. Device 4710 (rev 41)
0f:04.0 PCI bridge: Pericom Semiconductor PCI to PCI Bridge (rev 02)
10:04.0 Network controller: VMIC GE-IP PCI5565,PMC5565 Reflective Memory Node (rev 01)
10:05.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
10:07.0 PCI bridge: Hint Corp HiNT HB4 PCI-PCI Bridge (PCI6150) (rev 04)
10:08.0 PCI bridge: Hint Corp HiNT HB4 PCI-PCI Bridge (PCI6150) (rev 04)
10:09.0 Communication controller: Digi International AccelePort Xr 920 (rev 01)
10:0a.0 SCSI storage controller: Adaptec AHA-2930CU (rev 03)
11:00.0 Unassigned class [ff00]: Compro Computer Services, Inc. Device 4710 (rev 41)
12:00.0 Unassigned class [ff00]: Compro Computer Services, Inc. Device 4710 (rev 41)

The devices associated with the kernel module that is unloaded prior to these kernel messages
are the 4 "Device 0480" and the 2 "Device 4710" devices. User land has not accessed the boards,
no DMA functions have been called, the  boards and driver have been functional for years and all
work fine when the IOMMU is disabled in the BIOS. 

This doesn't look like my driver but I do have others that do not cause this. None of them have
7 boards associated with them though?

Thanks and Regards
Mark 
