From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: BUG: unable to handle kernel paging request with v4.3-rc4
Date: Fri, 09 Oct 2015 09:30:40 -0600
Message-ID: <1444404640.4059.219.camel@redhat.com>
References: <20151009145827.GB27420@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151009145827.GB27420-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 2015-10-09 at 16:58 +0200, Joerg Roedel wrote:
> Hi Alex,
> 
> while playing around with attaching a 32bit PCI device to a guest via
> VFIO I triggered this oops:
> 
> [  192.289917] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
> [  192.298245] BUG: unable to handle kernel paging request at ffff880224582608
> [  192.306195] IP: [<ffff880224582608>] 0xffff880224582608
> [  192.312302] PGD 2026067 PUD 2029067 PMD 80000002244001e3 
> [  192.318589] Oops: 0011 [#1] PREEMPT SMP 
> [  192.323363] Modules linked in: kvm_amd kvm vfio_pci vfio_iommu_type1 vfio_virqfd vfio bnep bluetooth rfkill iscsi_ibft iscsi_boot_sysfs af_packet snd_hda_codec_via snd_hda_codec_generic snd_hda_codec_hdmi raid1 snd_hda_intel crct10dif_pclmul crc32_pclmul snd_hda_codec crc32c_intel ghash_clmulni_intel snd_hwdep snd_hda_core snd_pcm snd_timer aesni_intel aes_x86_64 md_mod glue_helper lrw gf128mul ablk_helper be2net snd serio_raw cryptd sp5100_tco pcspkr xhci_pci vxlan ip6_udp_tunnel fam15h_power sky2 udp_tunnel xhci_hcd soundcore dm_mod k10temp i2c_piix4 shpchp wmi acpi_cpufreq asus_atk0110 button processor ata_generic firewire_ohci firewire_core ohci_pci crc_itu_t radeon i2c_algo_bit drm_kms_helper pata_jmicron syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm sg [last unloaded: kv
 m]
> [  192.399986] CPU: 4 PID: 2037 Comm: qemu-system-x86 Not tainted 4.3.0-rc4+ #4
> [  192.408260] Hardware name: System manufacturer System Product Name/Crosshair IV Formula, BIOS 3027    10/28/2011
> [  192.419746] task: ffff880223e24040 ti: ffff8800cae5c000 task.ti: ffff8800cae5c000
> [  192.428506] RIP: 0010:[<ffff880224582608>]  [<ffff880224582608>] 0xffff880224582608
> [  192.437376] RSP: 0018:ffff8800cae5fe58  EFLAGS: 00010286
> [  192.443940] RAX: ffff8800cb3c8800 RBX: ffff8800cba55800 RCX: 0000000000000004
> [  192.452370] RDX: 0000000000000004 RSI: ffff8802233e7887 RDI: 0000000000000001
> [  192.460796] RBP: ffff8800cae5fe98 R08: 0000000000000ff8 R09: 0000000000000008
> [  192.469145] R10: 000000000001d300 R11: 0000000000000000 R12: ffff8800cba55800
> [  192.477584] R13: ffff8802233e7880 R14: ffff8800cba55830 R15: 00007fff43b30b50
> [  192.486025] FS:  00007f94375b2c00(0000) GS:ffff88022ed00000(0000) knlGS:0000000000000000
> [  192.495445] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  192.502481] CR2: ffff880224582608 CR3: 00000000cb9d9000 CR4: 00000000000406e0
> [  192.510850] Stack:
> [  192.514094]  ffffffffa03f9733 0000000100000000 0000000000000001 ffff880223c74600
> [  192.522876]  ffff8800ca4f6d88 00007fff43b30b50 0000000000003b6a 00007fff43b30b50
> [  192.531582]  ffff8800cae5ff08 ffffffff811efc7d ffff8800cae5fec8 ffff880223c74600
> [  192.540439] Call Trace:
> [  192.544145]  [<ffffffffa03f9733>] ? vfio_group_fops_unl_ioctl+0x253/0x410 [vfio]
> [  192.552898]  [<ffffffff811efc7d>] do_vfs_ioctl+0x2cd/0x4c0
> [  192.559713]  [<ffffffff811f9687>] ? __fget+0x77/0xb0
> [  192.565998]  [<ffffffff811efee9>] SyS_ioctl+0x79/0x90
> [  192.572373]  [<ffffffff81001bb0>] ? syscall_return_slowpath+0x50/0x130
> [  192.580258]  [<ffffffff8167f776>] entry_SYSCALL_64_fastpath+0x16/0x75
> [  192.588049] Code: 88 ff ff d8 25 58 24 02 88 ff ff e8 25 58 24 02 88 ff ff e8 25 58 24 02 88 ff ff 58 a2 70 21 02 88 ff ff c0 65 39 cb 00 88 ff ff <08> 2d 58 24 02 88 ff ff 08 88 3c cb 00 88 ff ff d8 58 c1 24 02 
> [  192.610309] RIP  [<ffff880224582608>] 0xffff880224582608
> [  192.616940]  RSP <ffff8800cae5fe58>
> [  192.621805] CR2: ffff880224582608
> [  192.632826] ---[ end trace ce135ef0c9b1869f ]---
> 
> I am not sure whether this is an IOMMU or VFIO bug, have you seen
> something like this before?

Hey Joerg,

I have not seen this one yet.  There literally have been no changes for
vfio in 4.3, so if this is new, it may be collateral from changes
elsewhere.  32bit devices really shouldn't make any difference to vfio,
I'll see if I can reproduce it myself though.  Thanks,

Alex
