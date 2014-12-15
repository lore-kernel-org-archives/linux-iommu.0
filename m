From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 0/5] Fix Intel IRQ remapping initialization order
Date: Mon, 15 Dec 2014 23:30:16 +0800
Message-ID: <548EFE88.3000307@linux.intel.com>
References: <1418656404-28575-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1418656404-28575-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2014/12/15 23:13, Joerg Roedel wrote:
> Hi,
> 
> here is a patch-set against tip/x86/apic to fix an initialization order
> problem with the IRQ remapping code.  The problem is in the ordering of
> the irq_remapping_prepare and irq_remapping_supported functions.
> 
> Currently the call-order is irq_remapping_prepare ->
> irq_remapping_supported, so that 'prepare' can succeed but 'supported'
> fails, so that interrupt remapping gets initialized but not enabled.
> This causes a broken interrupt setup on affected systems (machines with
> an Intel IOMMU without, or broken, IRQ remapping support). The result
> are lost interrupts and a non-bootable system.
> 
> Both functions do checks whether IRQ remapping can be enabled on the
> machine.  The reason for this is that some checks rely on
> dmar_table_init() and thus have to be done in irq_remapping_prepare().
> 
> This patch-set moves all these checks into the irq_remapping_prepare()
> path with the right ordering and removes the irq_remapping_supported()
> function and its call-backs. This fixes the initializion order problem
> and simplifies the exported API from the IOMMU code.
> 
> Please review.
Hi Joerg,
	I have posted a patch set for the same purpose at:
https://lkml.org/lkml/2014/12/10/20
	Seems we need to combine these two patch sets:)
Regards!
Gerry


> 
> Thanks,
> 
> 	Joerg
> 
> Joerg Roedel (5):
>   iommu/vt-d: Allocate IRQ remapping data structures only for all IOMMUs
>   iommu/vt-d: Don't check for ecap_ir_support in
>     intel_irq_remapping_supported
>   iommu/vt-d: Move supported-checks to intel_prepare_irq_remapping()
>   iommu/amd: Check for irq-remap support amd_iommu_prepare()
>   iommu, x86, apic: Remove irq_remapping_supported()
> 
>  arch/x86/kernel/apic/apic.c         |  5 ---
>  drivers/iommu/amd_iommu.c           |  1 -
>  drivers/iommu/amd_iommu_init.c      |  8 ++---
>  drivers/iommu/amd_iommu_proto.h     |  1 -
>  drivers/iommu/intel_irq_remapping.c | 62 +++++++++++++++++--------------------
>  drivers/iommu/irq_remapping.c       | 11 -------
>  drivers/iommu/irq_remapping.h       |  3 --
>  7 files changed, 31 insertions(+), 60 deletions(-)
> 
