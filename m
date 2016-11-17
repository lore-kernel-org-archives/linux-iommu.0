From: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Subject: BUG at drivers/iommu/amd_iommu.c:1436!
Date: Thu, 17 Nov 2016 14:13:59 -0500
Message-ID: <838275de-6cac-93d8-ca04-54b06a24b3d4@compro.net>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Kernel version is 4.8.0. No failure when the IOMMU is disabled. This is an out of tree GPL driver using pci_alloc_consistent/pci_free_consistent. The free causes this.

The commit is:

2d4c515bf06c9bce87b546279413621f847ef6a3 is the first bad commit
commit 2d4c515bf06c9bce87b546279413621f847ef6a3
Author: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Date:   Tue Jul 5 16:21:32 2016 +0200

    iommu/amd: Remove other remains of old address allocator

    There are other remains in the code from the old allocatore.
    Remove them all.

    Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

:040000 040000 87b020717cdd7dcab45e3574dfb6649d05dcc044 817e613acede15fafb70b046d831f558e6bffd93 M      drivers



Nov 16 08:39:15 harley kernel: kernel BUG at drivers/iommu/amd_iommu.c:1436!
Nov 16 08:39:15 harley kernel: invalid opcode: 0000 [#1] PREEMPT SMP
Nov 16 08:39:15 harley kernel: Modules linked in: gpiohsd(O) bnep bluetooth rfkill nvidia(PO) drm af_packet iscsi_ibft iscsi_boot_sysfs snd_hda_codec_realtek snd_hda_codec_generic kvm snd_hda_intel snd_hda_codec snd_hda_core xhci_pci snd_hwdep xhci_hcd snd_pcm synclink_gt osst 3c59x r8169 irqbypass crc32_pclmul dgap(C) snd_timer n_hdlc hdlc crc32c_intel snd tpm_infineon st joydev mii aesni_intel shpchp aes_x86_64 glue_helper tpm_tis tpm_tis_core input_leds lrw tpm k10temp fam15h_power soundcore gf128mul ablk_helper processor i2c_piix4 fjes serio_raw pcspkr cryptd dm_mod sr_mod cdrom ata_generic aic79xx pata_atiixp ohci_pci aic7xxx scsi_transport_spi mxm_wmi wmi button sg autofs4
Nov 16 08:39:15 harley kernel: CPU: 6 PID: 4750 Comm: trusim1a Tainted: P         C O    4.8.0 #1
Nov 16 08:39:15 harley kernel: Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./990FXA-UD5, BIOS FB 01/23/2013
Nov 16 08:39:15 harley kernel: task: ffff88042d849c00 task.stack: ffff880439910000
Nov 16 08:39:15 harley kernel: RIP: 0010:[<ffffffff8061ebf3>]  [<ffffffff8061ebf3>] iommu_unmap_page+0xd3/0xe0
Nov 16 08:39:15 harley kernel: RSP: 0018:ffff880439913b60  EFLAGS: 00010202
Nov 16 08:39:15 harley kernel: RAX: 000000000000122f RBX: 0000000000001000 RCX: 0000000000000027
Nov 16 08:39:15 harley kernel: RDX: fffffffffffffdba RSI: ffff88043b13a0a0 RDI: 0000000000000000
Nov 16 08:39:15 harley kernel: RBP: ffff880439913b90 R08: 0000000000000000 R09: 0000000000000000
Nov 16 08:39:15 harley kernel: R10: 0000000000000005 R11: 0000000000000002 R12: ffff88043b13a0a0
Nov 16 08:39:15 harley kernel: R13: ffff88043b13a000 R14: 0000000000001230 R15: ffffffffffec6260
Nov 16 08:39:15 harley kernel: FS:  00007fb360e6e700(0000) GS:ffff88044fd80000(0000) knlGS:0000000000000000
Nov 16 08:39:15 harley kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Nov 16 08:39:15 harley kernel: CR2: 00007fe345af58f0 CR3: 000000042d48a000 CR4: 00000000000406e0
Nov 16 08:39:15 harley kernel: Stack:
Nov 16 08:39:15 harley kernel:  0000000000000246 0000000000000001 ffffffffffec7000 0000000000000001
Nov 16 08:39:15 harley kernel:  ffff88043b13a000 ffffffffffec6000 ffff880439913bd0 ffffffff80620298
Nov 16 08:39:15 harley kernel:  ffff88043d2480a0 0000000000001000 ffff88043d2480a0 ffffffffffec6000
Nov 16 08:39:15 harley kernel: Call Trace:
Nov 16 08:39:15 harley kernel:  [<ffffffff80620298>] __unmap_single.isra.23+0x58/0x1b0
Nov 16 08:39:15 harley kernel:  [<ffffffff80620a66>] free_coherent+0x76/0xc0
Nov 16 08:39:15 harley kernel:  [<ffffffffa0f9fda5>] ehsd_set_signal+0x395/0x620 [gpiohsd]
Nov 16 08:39:15 harley kernel:  [<ffffffff8027c4f3>] ? finish_task_switch+0x73/0x1e0
Nov 16 08:39:15 harley kernel:  [<ffffffffa0fa4629>] ehsd_ioctl+0xdb9/0x17cb [gpiohsd]
Nov 16 08:39:15 harley kernel:  [<ffffffff8024ef40>] ? pat_enabled+0x20/0x20
Nov 16 08:39:15 harley kernel:  [<ffffffff80260750>] ? walk_system_ram_range+0x70/0xc0
Nov 16 08:39:15 harley kernel:  [<ffffffff80373f98>] ? unmap_page_range+0x698/0x8a0
Nov 16 08:39:15 harley kernel:  [<ffffffff80524da9>] ? find_next_bit+0x19/0x20
Nov 16 08:39:15 harley kernel:  [<ffffffff8050fcfc>] ? cpumask_any_but+0x2c/0x40
Nov 16 08:39:15 harley kernel:  [<ffffffff80251bac>] ? flush_tlb_mm_range+0x4c/0x1a0
Nov 16 08:39:15 harley kernel:  [<ffffffff80372947>] ? tlb_finish_mmu+0x17/0x50
Nov 16 08:39:15 harley kernel:  [<ffffffff8037a3f0>] ? unmap_region+0xe0/0x110
Nov 16 08:39:15 harley kernel:  [<ffffffff80516328>] ? __rb_erase_color+0x138/0x280
Nov 16 08:39:15 harley kernel:  [<ffffffff803d076f>] do_vfs_ioctl+0x8f/0x5a0
Nov 16 08:39:15 harley kernel:  [<ffffffff8037c76d>] ? do_munmap+0x27d/0x370
Nov 16 08:39:15 harley kernel:  [<ffffffff803d0cf4>] SyS_ioctl+0x74/0x80
Nov 16 08:39:15 harley kernel:  [<ffffffff80867f5f>] entry_SYSCALL_64_fastpath+0x17/0x93
Nov 16 08:39:15 harley kernel: Code: d7 49 01 c7 4c 39 f3 77 89 4d 85 f6 75 14 48 83 c4 08 4c 89 f0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b 49 8d 46 ff 4c 85 f0 74 e3 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 8b 57 7c 48 89 f0 85 d2
Nov 16 08:39:15 harley kernel: RIP  [<ffffffff8061ebf3>] iommu_unmap_page+0xd3/0xe0
Nov 16 08:39:15 harley kernel:  RSP <ffff880439913b60>
Nov 16 08:39:15 harley kernel: ---[ end trace 45a510d4d695b2d3 ]---


Regards
Mark
