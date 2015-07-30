From: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/5] AMD IOMMU Fixes for v4.2-rc4
Date: Thu, 30 Jul 2015 12:13:33 +0300
Message-ID: <CAFCwf13eY4mQi_mL_CNhcHZwW+-ZZAB_yHxmD_sGQZqDH6KV=w@mail.gmail.com>
References: <1438095531-26777-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438095531-26777-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

I tested your patches on Kaveri, and while they do fix the initial
setup between amdkfd and IOMMU, the kernel crashes when an HSA process
tries to do any simple action that involves the kernel, such as to
create a compute queue.

So while I suppose the above patches should be included, the new IOMMU
feature as a whole is still broken for amdkfd.

This is the log I get from dmesg:

<snip>
[  116.592829] systemd-logind[2221]: New session 1 of user ogabbay.
[  136.933560] ------------[ cut here ]------------
[  136.933845] kernel BUG at drivers/iommu/amd_iommu.c:3321!
[  136.934168] invalid opcode: 0000 [#1] SMP
[  136.934424] Modules linked in: amdkfd amd_iommu_v2 radeon
drm_kms_helper ttm fuse
[  136.934919] CPU: 1 PID: 3894 Comm: kfdtest Not tainted 4.2.0-rc3-kfd+ #9
[  136.935319] Hardware name: AMD BALLINA/Ballina, BIOS
WBL3B20N_Weekly_13_11_2 11/20/2013
[  136.935796] task: ffff8800a0c48000 ti: ffff880095f28000 task.ti:
ffff880095f28000
[  136.936242] RIP: 0010:[<ffffffff81424220>]  [<ffffffff81424220>]
__flush_pasid+0xd0/0x153
[  136.936740] RSP: 0018:ffff880095f2bb98  EFLAGS: 00010046
[  136.937055] RAX: 0000000000000000 RBX: ffff8800bd89b138 RCX: 000000004712e4da
[  136.937480] RDX: ffff8800ba7c4d40 RSI: 0000000000000001 RDI: 0000000000000a88
[  136.937906] RBP: ffff880095f2bbf8 R08: 000000004712f017 R09: 0000000000000b40
[  136.938331] R10: ffff8800a0c48000 R11: ffff8800a0c48688 R12: 00000000fffff000
[  136.938755] R13: ffff8800bd89b148 R14: 000000007fffffff R15: ffff8800bd89b101
[  136.939180] FS:  00007f2dbbb14780(0000) GS:ffff88011ec80000(0000)
knlGS:0000000000000000
[  136.939662] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  136.940003] CR2: 0000000000b77000 CR3: 0000000095e15000 CR4: 00000000000406e0
[  136.940427] Stack:
[  136.940544]  ffff880095f2bc18 00000000bd89b190 ffff880000010000
ffff8800bd89b190
[  136.941009]  3000000e00000001 7ffffffffffff007 ffff880095f2bc08
0000000095e15001
[  136.941474]  ffff8800bd89b190 0000000000000001 0000000000000296
ffff8800bd89b138
[  136.941937] Call Trace:
[  136.942084]  [<ffffffff81424327>] __amd_iommu_flush_tlb+0x24/0x26
[  136.942447]  [<ffffffff814243fd>] amd_iommu_domain_set_gcr3+0x85/0xa5
[  136.942833]  [<ffffffff8175a844>] ? _raw_spin_unlock_irqrestore+0x41/0x46
[  136.943241]  [<ffffffffa01c4a9d>] amd_iommu_bind_pasid+0x197/0x20c
[amd_iommu_v2]
[  136.943695]  [<ffffffffa01cfbb3>]
kfd_bind_process_to_device+0x59/0x74 [amdkfd]
[  136.944144]  [<ffffffffa01cc406>] ?
kfd_ioctl_create_queue+0x375/0x4e8 [amdkfd]
[  136.944583]  [<ffffffffa01cc43f>] kfd_ioctl_create_queue+0x3ae/0x4e8 [amdkfd]
[  136.945013]  [<ffffffffa01cc091>] ?
kfd_ioctl_destroy_queue+0x73/0x73 [amdkfd]
[  136.945448]  [<ffffffffa01cc737>] kfd_ioctl+0x1be/0x2b5 [amdkfd]
[  136.945808]  [<ffffffff81325860>] ? inode_has_perm+0x2b/0x30
[  136.946146]  [<ffffffff8115a4bf>] do_vfs_ioctl+0x455/0x4dd
[  136.946474]  [<ffffffff81329122>] ? selinux_file_ioctl+0xaf/0xb4
[  136.946835]  [<ffffffff81323001>] ? security_file_ioctl+0x35/0x49
[  136.947198]  [<ffffffff8115a5a1>] SyS_ioctl+0x5a/0x7f
[  136.947499]  [<ffffffff8175ae57>] entry_SYSCALL_64_fastpath+0x12/0x6f
[  136.947881] Code: b6 6d b0 48 8b 45 b0 48 8b 53 10 0f b6 c4 41 c1
e5 10 c1 e0 10 44 89 6d b0 4c 8d 6b 10 89 45 ac 4c 39 ea 74 68 80 7a
44 00 75 02 <0f> 0b 0f b7 72 40 48 8b 0d a3 57 76 01 48 8b 3c f1 8b 4a
48 48
[  136.949408] RIP  [<ffffffff81424220>] __flush_pasid+0xd0/0x153
[  136.949762]  RSP <ffff880095f2bb98>
[  137.116301] ---[ end trace 2b10f64971a81bd2 ]---

Oded

On Tue, Jul 28, 2015 at 5:58 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> Hi,
>
> here are a couple of fixes for the AMD IOMMU driver for
> issues found recently. The issues were introduced by the
> default-domain conversion in this development cycle. I plan
> to send these fixes upstream by the end of the week.
>
> Please review!
>
> Thanks,
>
>         Joerg
>
> Joerg Roedel (5):
>   iommu/amd: Use iommu_attach_group()
>   iommu/amd: Use iommu core for passthrough mode
>   iommu/amd: Allow non-IOMMUv2 devices in IOMMUv2 domains
>   iommu/amd: Use swiotlb in passthrough mode
>   iommu/amd: Set global dma_ops if swiotlb is disabled
>
>  drivers/iommu/amd_iommu.c      | 91 +++++++++++-------------------------------
>  drivers/iommu/amd_iommu_init.c | 10 +----
>  drivers/iommu/amd_iommu_v2.c   | 24 +++++++++--
>  3 files changed, 45 insertions(+), 80 deletions(-)
>
> --
> 1.9.1
>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
