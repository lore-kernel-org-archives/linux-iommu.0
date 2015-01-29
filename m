From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: intel-iommu/vfio-pci: crash in dmar_insert_dev_info
Date: Thu, 29 Jan 2015 12:06:58 -0700
Message-ID: <1422558418.22865.244.camel@redhat.com>
References: <54CA7A42.8050909@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54CA7A42.8050909-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kvm <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 2015-01-29 at 19:21 +0100, Jan Kiszka wrote:
> Hi Alex,
> 
> starting to play with Intel IGD pass-through in KVM, I managed to
> trigger this with linux git head:
> 
> [  232.317043] BUG: unable to handle kernel NULL pointer dereference at 0000000000000037
> [  232.325249] IP: [<ffffffff8142ed36>] dmar_insert_dev_info+0x86/0x220
> [  232.331905] PGD 0 
> [  232.334007] Oops: 0000 [#1] PREEMPT SMP 
> [  232.338118] Modules linked in: vfio_iommu_type1 vfio_pci vfio af_packet x86_pkg_temp_thermal coretemp kvm_intel kvm crc32_pclmul eeepc_wmi crc32c_intel e1000e asus_wmi sparse_keymap ghash_clmulni_intel i2c_i801 video aesni_intel xhci_x
> [  232.384673] CPU: 1 PID: 3770 Comm: qemu-system-x86 Not tainted 3.19.0-rc6+ #23
> [  232.392234] Hardware name: ASUS All Series/H87I-PLUS, BIOS 0306 04/15/2013
> [  232.399431] task: ffff8800c7fda350 ti: ffff8800c562c000 task.ti: ffff8800c562c000
> [  232.407265] RIP: 0010:[<ffffffff8142ed36>]  [<ffffffff8142ed36>] dmar_insert_dev_info+0x86/0x220
> [  232.416470] RSP: 0018:ffff8800c562fc48  EFLAGS: 00010086
> [  232.422027] RAX: 0000000000000286 RBX: ffff8800cc4ea0c0 RCX: 0000000000000286
> [  232.429498] RDX: ffffffffffffffff RSI: ffff88011fa5a748 RDI: ffffffff81f917ac
> [  232.436977] RBP: ffff8800c562fc88 R08: ffff88011a5c0140 R09: 0000000000000001
> [  232.444447] R10: ffff88011abfa400 R11: ffffea0003dab4c0 R12: ffff88011a5c0140
> [  232.451918] R13: 0000000000000000 R14: 0000000000000010 R15: ffff88011a405098
> [  232.459389] FS:  00007f4d4093d900(0000) GS:ffff88011fa40000(0000) knlGS:0000000000000000
> [  232.467860] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  232.473874] CR2: 0000000000000037 CR3: 00000000c8281000 CR4: 00000000001427e0
> [  232.481344] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  232.488813] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  232.496282] Stack:
> [  232.498380]  ffff88011a405000 ffff88011b317100 ffff88011b317100 ffff88011a405098
> [  232.506137]  ffff88011a405098 ffff88011a5c0140 0000000000000000 ffff8800c7f48c58
> [  232.513893]  ffff8800c562fcd8 ffffffff8143061c ffffffff81420cd0 ffff88011f0db4c0
> [  232.521650] Call Trace:
> [  232.524207]  [<ffffffff8143061c>] domain_add_dev_info+0x4c/0xa0
> [  232.530404]  [<ffffffff81420cd0>] ? iommu_attach_device+0xb0/0xb0
> [  232.536783]  [<ffffffff81430bb4>] intel_iommu_attach_device+0x144/0x1e0
> [  232.543710]  [<ffffffff81420cd0>] ? iommu_attach_device+0xb0/0xb0
> [  232.550089]  [<ffffffff81420c40>] iommu_attach_device+0x20/0xb0
> [  232.556285]  [<ffffffff81420ce2>] iommu_group_do_attach_device+0x12/0x20
> [  232.563301]  [<ffffffff81420f5a>] iommu_group_for_each_dev+0x4a/0x80
> [  232.569952]  [<ffffffff81420fc9>] iommu_attach_group+0x19/0x20
> [  232.576058]  [<ffffffffa0271a74>] vfio_iommu_type1_attach_group+0x184/0x470 [vfio_iommu_type1]
> [  232.585077]  [<ffffffff811a2410>] ? kmem_cache_alloc_trace+0x1b0/0x1c0
> [  232.591912]  [<ffffffffa01d8750>] vfio_fops_unl_ioctl+0x1e0/0x2b0 [vfio]
> [  232.598930]  [<ffffffff811c7a4e>] do_vfs_ioctl+0x7e/0x550
> [  232.604580]  [<ffffffff811d1984>] ? __fget+0x74/0xb0
> [  232.609776]  [<ffffffff811c7fb1>] SyS_ioctl+0x91/0xb0
> [  232.615062]  [<ffffffff816512ad>] system_call_fastpath+0x16/0x1b
> [  232.621348] Code: 28 4c 89 60 38 48 8b 45 c8 48 89 43 30 e8 b3 21 22 00 4d 85 ff 0f 84 fa 00 00 00 49 8b 97 30 02 00 00 48 85 d2 0f 84 aa 00 00 00 <4c> 8b 6a 38 4d 85 ed 74 41 48 89 c6 48 c7 c7 ac 17 f9 81 e8 62 
> [  232.641335] RIP  [<ffffffff8142ed36>] dmar_insert_dev_info+0x86/0x220
> [  232.648082]  RSP <ffff8800c562fc48>
> [  232.651728] CR2: 0000000000000037
> [  232.655193] ---[ end trace 31cafba6f4a5aab8 ]---
> 
> 
> What I did was to apply [1] to overrule the RMRR check, prepared the
> qemu and seabios versions as suggested in [2], and then gave the
> chipset's igd of a H87I-PLUS board to qemu:
> 
> qemu-system-x86_64 -machine q35,accel=kvm -cpu host -acpitable \
>   file=qemu/pc-bios/q35-acpi-dsdt.aml -m 2G \
>   -device vfio-pci,host=00:02.0,id=vga1,x-vga=on,addr=2.0,romfile=vbios.dump \
>   -vga none -net none...
> 
> But even if userspace is totally broken, that oops should not happen, I
> guess...

Yep, I'd agree.  vfio is operating on the IOMMU group level here,
creating an IOMMU domain and then asking the IOMMU code to enumerate the
devices in the group and attach each to the domain.  So if there are
issues, I'd verify the IOMMU group set looks sane.  Being a single
function root complex device, the IGD at 00:02.0 should be a singleton
IOMMU group.  It's then a matter of what special handling might
intel-iommu be doing on that device that's causing it to fall over.  For
that I'd probably rely on instrumenting the code path.  Thanks,

Alex
