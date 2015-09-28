From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v9 00/18] Add VT-d Posted-Interrupts support - including
	prerequisite series
Date: Mon, 28 Sep 2015 10:22:58 +0000
Message-ID: <E959C4978C3B6342920538CF579893F009A5641C@SHSMSX104.ccr.corp.intel.com>
References: <1442586596-5920-1-git-send-email-feng.wu@intel.com>
	<E959C4978C3B6342920538CF579893F009A46D3D@SHSMSX152.ccr.corp.intel.com>
	<56052C96.7070805@redhat.com>
	<E959C4978C3B6342920538CF579893F009A56378@SHSMSX104.ccr.corp.intel.com>
	<560913FB.1070107@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <560913FB.1070107-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Paolo Bonzini [mailto:pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> Sent: Monday, September 28, 2015 6:19 PM
> To: Wu, Feng; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org;
> mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> Cc: eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH v9 00/18] Add VT-d Posted-Interrupts support - including
> prerequisite series
> 
> 
> 
> On 28/09/2015 12:14, Wu, Feng wrote:
> > Thanks a lot for creating branch for vt-d pi. However, I cannot launch guests
> > with this tree. I encountered the following kernel dump, and I find that the
> > problematic commit is " 2260b1cde0b5472ab70ad0764b10095372e41913 "
> >
> >     KVM: x86: put vcpu_create under kvm->srcu critical section
> >
> >     This is needed in case vcpu_create wants to access the memslots array.
> >     Fixes this lockdep splat:
> >
> > After removing this commit from the tree, my VT-d patch-set works fine.
> 
> Great, thanks.  The above commit had already been reverted.
> 
> I'm sorting out the kbuild reports, and then will merge VT-d PI.

Thanks a lot for make this happen!

Thanks,
Feng

> 
> Paolo
> 
> >
> > Kernel dump:
> > [  221.978182] BUG: unable to handle kernel NULL pointer dereference at
> (null)
> > [  221.986085] IP: [<ffffffffc0368ab0>] kvm_arch_vcpu_create+0x30/0x90
> [kvm]
> > [  221.993102] PGD 0
> > [  221.995148] Oops: 0000 [#1] SMP
> > [  221.998440] Modules linked in: bnep rfcomm bluetooth ax88179_178a
> usbnet intel_rapl mii snd_hda_codec_hdmi iosf_mbi x86_pkg_temp_thermal
> nouveau intel_powerclamp snd_hda_intel snd_hda_codec coretemp kvm_intel
> snd_hda_core kvm snd_hwdep snd_pcm crct10dif_pclmul crc32_pclmul
> snd_seq_midi ghash_clmulni_intel mxm_wmi snd_seq_midi_event snd_rawmidi
> video snd_seq ttm aesni_intel aes_x86_64 lrw gf128mul drm_kms_helper
> snd_seq_device binfmt_misc snd_timer glue_helper ablk_helper drm cryptd
> fb_sys_fops snd syscopyarea sysfillrect sb_edac soundcore sysimgblt mei_me
> parport_pc edac_core ppdev mei shpchp lp lpc_ich mac_hid parport
> acpi_power_meter wmi ixgbe igb i2c_algo_bit hid_generic usbhid ptp ahci hid
> libahci pps_core mdio
> > [  222.063533] CPU: 4 PID: 3384 Comm: qemu-system-x86 Not tainted
> 4.3.0-rc1+ #6
> > [  222.070612] Hardware name: Intel Corp. GRANGEVILLE/GRANTLEY, BIOS
> GNVDCRB1.86B.0020.V07.1409241147 09/24/2014
> > [  222.080764] task: ffff88006e7c8000 ti: ffff8800714a8000 task.ti:
> ffff8800714a8000
> > [  222.088283] RIP: 0010:[<ffffffffc0368ab0>]  [<ffffffffc0368ab0>]
> kvm_arch_vcpu_create+0x30/0x90 [kvm]
> > [  222.097680] RSP: 0018:ffff8800714abde0  EFLAGS: 00010246
> > [  222.103153] RAX: 0000000000000000 RBX: ffff88016f28c000 RCX:
> 0000000000000000
> > [  222.110407] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffff88016f28c000
> > [  222.117659] RBP: ffff8800714abdf8 R08: 0000000000000001 R09:
> 0000000000000040
> > [  222.124824] R10: ffff880077e86438 R11: ffff880163e06880 R12:
> ffff88016f28c000
> > [  222.132150] R13: 0000000000000000 R14: 000000000000ae41 R15:
> 0000000000000000
> > [  222.139405] FS:  00007f43fd7ec700(0000) GS:ffff880178700000(0000)
> knlGS:0000000000000000
> > [  222.147629] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  222.153471] CR2: 0000000000000000 CR3: 000000017074b000 CR4:
> 00000000003426e0
> > [  222.160726] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> > [  222.167979] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> > [  222.175231] Stack:
> > [  222.177277]  0000000000000000 ffff88016f28c000 0000000000000000
> ffff8800714abea0
> > [  222.184870]  ffffffffc0355b17 0000000000000008 ffff8800714abe28
> ffffffff810aba32
> > [  222.192444]  ffff880178816e40 ffff8800714abe40 ffffffff810a4f44
> ffff880178816e40
> > [  222.200017] Call Trace:
> > [  222.202522]  [<ffffffffc0355b17>] kvm_vm_ioctl+0x277/0x6e0 [kvm]
> > [  222.208633]  [<ffffffff810aba32>] ? put_prev_task_fair+0x22/0x40
> > [  222.214741]  [<ffffffff810a4f44>] ? pick_next_task_idle+0x14/0x30
> > [  222.220942]  [<ffffffff811fb53a>] do_vfs_ioctl+0x2ba/0x490
> > [  222.226523]  [<ffffffff8106274a>] ? __do_page_fault+0x1ba/0x410
> > [  222.232546]  [<ffffffff811fb789>] SyS_ioctl+0x79/0x90
> > [  222.237684]  [<ffffffff81003ba5>] ? syscall_return_slowpath+0x55/0x150
> > [  222.244323]  [<ffffffff81791d36>]
> entry_SYSCALL_64_fastpath+0x16/0x75
> > [  222.250869] Code: 55 48 89 e5 41 55 41 54 53 41 89 f5 48 89 fb e8 27 61
> cb c0 85 c0 74 13 8b 83 f0 09 00 00 85 c0 74 09 80 3d 53 2e 04 00 00 74 40 <48>
> 8b 04 25 00 00 00 00 48 8d 78 48 e8 7f c4 d6 c0 41 89 c4 48
> > [  222.270790] RIP  [<ffffffffc0368ab0>] kvm_arch_vcpu_create+0x30/0x90
> [kvm]
> > [  222.277813]  RSP <ffff8800714abde0>
> > [  222.281359] CR2: 0000000000000000
> > [  222.290421] ---[ end trace 957f5a39692fe6c7 ]---
> > root@feng-bdw-de-pi:~/workspace/tools# dmesg > ~/dmesg.log
> > root@feng-bdw-de-pi:~/workspace/tools# vim ~/dmesg.log
> > [  221.998440] Modules linked in: bnep rfcomm bluetooth ax88179_178a
> usbnet intel_rapl mii snd_hda_codec_hdmi iosf_mbi x86_pkg_temp_thermal
> nouveau intel_powerclamp snd_hda_intel snd_hda_codec coretemp kvm_intel
> snd_hda_core kvm snd_hwdep snd_pcm crct10dif_pclmul crc32_pclmul
> snd_seq_midi ghash_clmulni_intel mxm_wmi snd_seq_midi_event snd_rawmidi
> video snd_seq ttm aesni_intel aes_x86_64 lrw gf128mul drm_kms_helper
> snd_seq_device binfmt_misc snd_timer glue_helper ablk_helper drm cryptd
> fb_sys_fops snd syscopyarea sysfillrect sb_edac soundcore sysimgblt mei_me
> parport_pc edac_core ppdev mei shpchp lp lpc_ich mac_hid parport
> acpi_power_meter wmi ixgbe igb i2c_algo_bit hid_generic usbhid ptp ahci hid
> libahci pps_core mdio
> > [  222.063533] CPU: 4 PID: 3384 Comm: qemu-system-x86 Not tainted
> 4.3.0-rc1+ #6
> > [  222.070612] Hardware name: Intel Corp. GRANGEVILLE/GRANTLEY, BIOS
> GNVDCRB1.86B.0020.V07.1409241147 09/24/2014
> > [  222.080764] task: ffff88006e7c8000 ti: ffff8800714a8000 task.ti:
> ffff8800714a8000
> > [  222.088283] RIP: 0010:[<ffffffffc0368ab0>]  [<ffffffffc0368ab0>]
> kvm_arch_vcpu_create+0x30/0x90 [kvm]
> > [  222.097680] RSP: 0018:ffff8800714abde0  EFLAGS: 00010246
> > [  222.103153] RAX: 0000000000000000 RBX: ffff88016f28c000 RCX:
> 0000000000000000
> > [  222.110407] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffff88016f28c000
> > [  222.117659] RBP: ffff8800714abdf8 R08: 0000000000000001 R09:
> 0000000000000040
> > [  222.124824] R10: ffff880077e86438 R11: ffff880163e06880 R12:
> ffff88016f28c000
> > [  222.132150] R13: 0000000000000000 R14: 000000000000ae41 R15:
> 0000000000000000
> > [  222.139405] FS:  00007f43fd7ec700(0000) GS:ffff880178700000(0000)
> knlGS:0000000000000000
> > [  222.147629] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  222.153471] CR2: 0000000000000000 CR3: 000000017074b000 CR4:
> 00000000003426e0
> > [  222.160726] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> > [  222.167979] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> > [  222.175231] Stack:
> > [  222.177277]  0000000000000000 ffff88016f28c000 0000000000000000
> ffff8800714abea0
> > [  222.184870]  ffffffffc0355b17 0000000000000008 ffff8800714abe28
> ffffffff810aba32
> > [  222.192444]  ffff880178816e40 ffff8800714abe40 ffffffff810a4f44
> ffff880178816e40
> > [  222.200017] Call Trace:
> > [  222.202522]  [<ffffffffc0355b17>] kvm_vm_ioctl+0x277/0x6e0 [kvm]
> > [  222.208633]  [<ffffffff810aba32>] ? put_prev_task_fair+0x22/0x40
> > [  222.214741]  [<ffffffff810a4f44>] ? pick_next_task_idle+0x14/0x30
> > [  222.220942]  [<ffffffff811fb53a>] do_vfs_ioctl+0x2ba/0x490
> > [  222.226523]  [<ffffffff8106274a>] ? __do_page_fault+0x1ba/0x410
> > [  222.232546]  [<ffffffff811fb789>] SyS_ioctl+0x79/0x90
> > [  222.237684]  [<ffffffff81003ba5>] ? syscall_return_slowpath+0x55/0x150
> > [  222.244323]  [<ffffffff81791d36>]
> entry_SYSCALL_64_fastpath+0x16/0x75
> > [  222.250869] Code: 55 48 89 e5 41 55 41 54 53 41 89 f5 48 89 fb e8 27 61
> cb c0 85 c0 74 13 8b 83 f0 09 00 00 85 c0 74 09 80 3d 53 2e 04 00 00 74 40 <48>
> 8b 04 25 00 00 00 00 48 8d 78 48 e8 7f c4 d6 c0 41 89 c4 48
> > [  222.270790] RIP  [<ffffffffc0368ab0>] kvm_arch_vcpu_create+0x30/0x90
> [kvm]
> > [  222.277813]  RSP <ffff8800714abde0>
> > [  222.281359] CR2: 0000000000000000
> > [  222.290421] ---[ end trace 957f5a39692fe6c7 ]---
