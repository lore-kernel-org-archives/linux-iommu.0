From: Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [PATCH] intel-iommu: Synchronize gcmd value with global command
	register
Date: Wed, 27 Mar 2013 14:02:44 +0900
Message-ID: <51527D74.9080209@jp.fujitsu.com>
References: <1363829556-2128-1-git-send-email-indou.takao@jp.fujitsu.com>
	<20130326144629.GB2727@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130326144629.GB2727-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

(2013/03/26 23:46), Joerg Roedel wrote:
> On Thu, Mar 21, 2013 at 10:32:36AM +0900, Takao Indoh wrote:
>> In this function, clearing IRE bit in iommu->gcmd and writing it to
>> global command register. But initial value of iommu->gcmd is zero, so
>> this writel means clearing all bits in global command register.
> 
> Seems weird. Why is the value of gcmd zero in your case? The usage of
> this register is well encapsulated by the different parts of the VT-d
> driver. There are other places which enable/disable translation and qpi
> the same way it is done with interrupt remapping. So it looks to me that
> it is unlikely that gcmd is really zero in your case.
> 
> Can you explain that more and also describe what the actual misbehavior
> is you are trying to fix here?

Sure.
At first, please see the debug patch below.

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index af8904d..3ffb029 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -484,12 +484,15 @@ static void iommu_disable_irq_remapping(struct intel_iommu *iommu)
 	if (!(sts & DMA_GSTS_IRES))
 		goto end;
 
+	printk("DEBUG1: %08x\n", sts);
+
 	iommu->gcmd &= ~DMA_GCMD_IRE;
 	writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
 
 	IOMMU_WAIT_OP(iommu, DMAR_GSTS_REG,
 		      readl, !(sts & DMA_GSTS_IRES), sts);
 
+	printk("DEBUG2: %08x\n", sts);
 end:
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
 }


This is the result in *kdump* kernel(second kernel).

DEBUG1: c7000000
DEBUG2: 41000000

After writel, TES/QIES/IRES is disabled. I think only IRES should be
disabled here because this function is "iommu_disable_irq_remapping".
TES and QIES should be disabled by iommu_disable_translation() and
dmar_disable_qi() respectively.

This is what I found and what I am trying to fix. Next, let's see what
happened at boot time. Again, I'm talking about *kdump* kernel boot
time.

1. dmar_table_init() is called, and intel_iommu structure is allocated in
   alloc_iommu().

int alloc_iommu(struct dmar_drhd_unit *drhd)
{
        struct intel_iommu *iommu;
(snip)
        iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);

iommu->gcmd is zero here.


2. intel_enable_irq_remapping() is called, and interrupt remapping is
   initialized.

static int __init intel_enable_irq_remapping(void)
{
(snip)
        for_each_drhd_unit(drhd) {
                struct intel_iommu *iommu = drhd->iommu;
(snip)
                iommu_disable_irq_remapping(iommu);


iommu_disable_irq_remapping is called here. Note that iommu->gcmd is
still zero because anyone doesn't touch it yet.


static void iommu_disable_irq_remapping(struct intel_iommu *iommu)
{
(snip)
        sts = dmar_readq(iommu->reg + DMAR_GSTS_REG);
        if (!(sts & DMA_GSTS_IRES))
                goto end;

        iommu->gcmd &= ~DMA_GCMD_IRE;
        writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);

The purpose of this code is clearing IRE bit of global command
register to disable interrupt remapping, right?

But as I wrote above, iommu->gcmd is always zero here at boot time. So
this code means claring *all* bit of global command register. As the
result of this, both of TE and QIE are also disabled.

The root cause of this problem is mismatch between iommu->gcmd and
global command register in the case of kdump. At boot time, initial
value of iommu->gcmd is zero as I wrote above, but actual global command
register is *not* zero because some bits like IRE/TE/QIE are already set
in *first* kernel. Therefore this patch synchronize them to fix this
problem.

Did I answer your question?

Thanks,
Takao Indoh
