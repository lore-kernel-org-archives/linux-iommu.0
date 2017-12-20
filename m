From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: clean up pr_irq if request_threaded_irq fails
Date: Wed, 20 Dec 2017 12:02:39 -0700
Message-ID: <20171220120239.77d62a1a@t450s.home>
References: <20171206164959.23794-1-jsnitsel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171206164959.23794-1-jsnitsel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jerry Snitselaar <jsnitsel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed,  6 Dec 2017 09:49:59 -0700
Jerry Snitselaar <jsnitsel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> It is unlikely request_threaded_irq will fail, but if it does for some
> reason we should clear iommu->pr_irq in the error path. Also
> intel_svm_finish_prq shouldn't try to clean up the page request
> interrupt if pr_irq is 0. Without these, if request_threaded_irq were
> to fail the following occurs:
> 
> fail with no fixes:
> 
> [    0.683147] ------------[ cut here ]------------
> [    0.683148] NULL pointer, cannot free irq
> [    0.683158] WARNING: CPU: 1 PID: 1 at kernel/irq/irqdomain.c:1632 irq_domain_free_irqs+0x126/0x140
> [    0.683160] Modules linked in:
> [    0.683163] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc2 #3
> [    0.683165] Hardware name:                  /NUC7i3BNB, BIOS BNKBL357.86A.0036.2017.0105.1112 01/05/2017
> [    0.683168] RIP: 0010:irq_domain_free_irqs+0x126/0x140
> [    0.683169] RSP: 0000:ffffc90000037ce8 EFLAGS: 00010292
> [    0.683171] RAX: 000000000000001d RBX: ffff880276283c00 RCX: ffffffff81c5e5e8
> [    0.683172] RDX: 0000000000000001 RSI: 0000000000000096 RDI: 0000000000000246
> [    0.683174] RBP: ffff880276283c00 R08: 0000000000000000 R09: 000000000000023c
> [    0.683175] R10: 0000000000000007 R11: 0000000000000000 R12: 000000000000007a
> [    0.683176] R13: 0000000000000001 R14: 0000000000000000 R15: 0000010010000000
> [    0.683178] FS:  0000000000000000(0000) GS:ffff88027ec80000(0000) knlGS:0000000000000000
> [    0.683180] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.683181] CR2: 0000000000000000 CR3: 0000000001c09001 CR4: 00000000003606e0
> [    0.683182] Call Trace:
> [    0.683189]  intel_svm_finish_prq+0x3c/0x60
> [    0.683191]  free_dmar_iommu+0x1ac/0x1b0
> [    0.683195]  init_dmars+0xaaa/0xaea
> [    0.683200]  ? klist_next+0x19/0xc0
> [    0.683203]  ? pci_do_find_bus+0x50/0x50
> [    0.683205]  ? pci_get_dev_by_id+0x52/0x70
> [    0.683208]  intel_iommu_init+0x498/0x5c7
> [    0.683211]  pci_iommu_init+0x13/0x3c
> [    0.683214]  ? e820__memblock_setup+0x61/0x61
> [    0.683217]  do_one_initcall+0x4d/0x1a0
> [    0.683220]  kernel_init_freeable+0x186/0x20e
> [    0.683222]  ? set_debug_rodata+0x11/0x11
> [    0.683225]  ? rest_init+0xb0/0xb0
> [    0.683226]  kernel_init+0xa/0xff
> [    0.683229]  ret_from_fork+0x1f/0x30
> [    0.683259] Code: 89 ee 44 89 e7 e8 3b e8 ff ff 5b 5d 44 89 e7 44 89 ee 41 5c 41 5d 41 5e e9 a8 84 ff ff 48 c7 c7 a8 71 a7 81 31 c0 e8 6a d3 f9 ff <0f> ff 5b 5d 41 5c 41 5d 41 5
> e c3 0f 1f 44 00 00 66 2e 0f 1f 84
> [    0.683285] ---[ end trace f7650e42792627ca ]---
> 
> with iommu->pr_irq = 0, but no check in intel_svm_finish_prq:
> 
> [    0.669561] ------------[ cut here ]------------
> [    0.669563] Trying to free already-free IRQ 0
> [    0.669573] WARNING: CPU: 3 PID: 1 at kernel/irq/manage.c:1546 __free_irq+0xa4/0x2c0
> [    0.669574] Modules linked in:
> [    0.669577] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc2 #4
> [    0.669579] Hardware name:                  /NUC7i3BNB, BIOS BNKBL357.86A.0036.2017.0105.1112 01/05/2017
> [    0.669581] RIP: 0010:__free_irq+0xa4/0x2c0
> [    0.669582] RSP: 0000:ffffc90000037cc0 EFLAGS: 00010082
> [    0.669584] RAX: 0000000000000021 RBX: 0000000000000000 RCX: ffffffff81c5e5e8
> [    0.669585] RDX: 0000000000000001 RSI: 0000000000000086 RDI: 0000000000000046
> [    0.669587] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000023c
> [    0.669588] R10: 0000000000000007 R11: 0000000000000000 R12: ffff880276253960
> [    0.669589] R13: ffff8802762538a4 R14: ffff880276253800 R15: ffff880276283600
> [    0.669593] FS:  0000000000000000(0000) GS:ffff88027ed80000(0000) knlGS:0000000000000000
> [    0.669594] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.669596] CR2: 0000000000000000 CR3: 0000000001c09001 CR4: 00000000003606e0
> [    0.669602] Call Trace:
> [    0.669616]  free_irq+0x30/0x60
> [    0.669620]  intel_svm_finish_prq+0x34/0x60
> [    0.669623]  free_dmar_iommu+0x1ac/0x1b0
> [    0.669627]  init_dmars+0xaaa/0xaea
> [    0.669631]  ? klist_next+0x19/0xc0
> [    0.669634]  ? pci_do_find_bus+0x50/0x50
> [    0.669637]  ? pci_get_dev_by_id+0x52/0x70
> [    0.669639]  intel_iommu_init+0x498/0x5c7
> [    0.669642]  pci_iommu_init+0x13/0x3c
> [    0.669645]  ? e820__memblock_setup+0x61/0x61
> [    0.669648]  do_one_initcall+0x4d/0x1a0
> [    0.669651]  kernel_init_freeable+0x186/0x20e
> [    0.669653]  ? set_debug_rodata+0x11/0x11
> [    0.669656]  ? rest_init+0xb0/0xb0
> [    0.669658]  kernel_init+0xa/0xff
> [    0.669661]  ret_from_fork+0x1f/0x30
> [    0.669662] Code: 7a 08 75 0e e9 c3 01 00 00 4c 39 7b 08 74 57 48 89 da 48 8b 5a 18 48 85 db 75 ee 89 ee 48 c7 c7 78 67 a7 81 31 c0 e8 4c 37 fa ff <0f> ff 48 8b 34 24 4c 89 ef e
> 8 0e 4c 68 00 49 8b 46 40 48 8b 80
> [    0.669688] ---[ end trace 58a470248700f2fc ]---
> 
> Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Jerry Snitselaar <jsnitsel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/intel-svm.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Applied to v4.16-iommu/vt-d.  Thanks,

Alex
