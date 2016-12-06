From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] iommu/arm-smmu: Disable stalling faults for all
	endpoints
Date: Tue, 6 Dec 2016 18:30:21 -0500
Message-ID: <CAF6AEGujUb37qagBZK1T13eAh=50zy0z5HpFF9FsuvkZZ7c5qw@mail.gmail.com>
References: <1471525542-14969-1-git-send-email-will.deacon@arm.com>
	<1471525542-14969-4-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1471525542-14969-4-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 18, 2016 at 9:05 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> Enabling stalling faults can result in hardware deadlock on poorly
> designed systems, particularly those with a PCI root complex upstream of
> the SMMU.
>
> Although it's not really Linux's job to save hardware integrators from
> their own misfortune, it *is* our job to stop userspace (e.g. VFIO
> clients) from hosing the system for everybody else, even if they might
> already be required to have elevated privileges.
>
> Given that the fault handling code currently executes entirely in IRQ
> context, there is nothing that can sensibly be done to recover from
> things like page faults anyway, so let's rip this code out for now and
> avoid the potential for deadlock.

Hi Will,

so, I'd like to re-introduce this feature, I *guess* as some sort of
opt-in quirk (ie. disabled by default unless something in DT tells you
otherwise??  But I'm open to suggestions.  I'm not entirely sure what
hw was having problems due to this feature.)

On newer snapdragon devices we are using arm-smmu for the GPU, and
halting the GPU so the driver's fault handler can dump some GPU state
on faults is enormously helpful for debugging and tracking down where
in the gpu cmdstream the fault was triggered.  In addition, we will
eventually want the ability to update pagetables from fault handler
and resuming the faulting transition.

Some additional comments below..

> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Reported-by: Matt Evans <matt.evans-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 34 +++++++---------------------------
>  1 file changed, 7 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 4f49fe29f202..2db74ebc3240 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -686,8 +686,7 @@ static struct iommu_gather_ops arm_smmu_gather_ops = {
>
>  static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>  {
> -       int flags, ret;
> -       u32 fsr, fsynr, resume;
> +       u32 fsr, fsynr;
>         unsigned long iova;
>         struct iommu_domain *domain = dev;
>         struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> @@ -701,34 +700,15 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>         if (!(fsr & FSR_FAULT))
>                 return IRQ_NONE;
>
> -       if (fsr & FSR_IGN)
> -               dev_err_ratelimited(smmu->dev,
> -                                   "Unexpected context fault (fsr 0x%x)\n",
> -                                   fsr);
> -
>         fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
> -       flags = fsynr & FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ;
> -
>         iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
> -       if (!report_iommu_fault(domain, smmu->dev, iova, flags)) {
> -               ret = IRQ_HANDLED;
> -               resume = RESUME_RETRY;
> -       } else {
> -               dev_err_ratelimited(smmu->dev,
> -                   "Unhandled context fault: iova=0x%08lx, fsynr=0x%x, cb=%d\n",
> -                   iova, fsynr, cfg->cbndx);

I would like to decouple this dev_err_ratelimit() print from the
RESUME_RETRY vs RESUME_TERMINATE behaviour.  I need the ability to
indicate by return from my fault handler whether to resume or
terminate.  But I already have my own ratelimted prints and would
prefer not to spam dmesg twice.

I'm thinking about report_iommu_fault() returning:

  0 => RESUME_RETRY
  -EFAULT => RESUME_TERMINATE but don't print
  anything else (or specifically -ENOSYS?) => RESUME_TERMINATE and print

thoughts?

> -               ret = IRQ_NONE;
> -               resume = RESUME_TERMINATE;
> -       }
> -
> -       /* Clear the faulting FSR */
> -       writel(fsr, cb_base + ARM_SMMU_CB_FSR);
>
> -       /* Retry or terminate any stalled transactions */
> -       if (fsr & FSR_SS)
> -               writel_relaxed(resume, cb_base + ARM_SMMU_CB_RESUME);

This might be a bug in qcom's implementation of the smmu spec, but
seems like we don't have SS bit set, yet we still require RESUME reg
to be written, otherwise gpu is perma-wedged.  Maybe topic for a
separate quirk?  I'm not sure if writing RESUME reg on other hw when
SS bit is not set is likely to cause problems?  If not I suppose we
could just unconditionally write it.

Anyways, I'm not super-familiar w/ arm-smmu so suggestions welcome..
in between debugging freedreno I'll try to put together some patches.

BR,
-R

> +       dev_err_ratelimited(smmu->dev,
> +       "Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
> +                           fsr, iova, fsynr, cfg->cbndx);
>
> -       return ret;
> +       writel(fsr, cb_base + ARM_SMMU_CB_FSR);
> +       return IRQ_HANDLED;
>  }
>
>  static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
> @@ -837,7 +817,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>         }
>
>         /* SCTLR */
> -       reg = SCTLR_CFCFG | SCTLR_CFIE | SCTLR_CFRE | SCTLR_M | SCTLR_EAE_SBOP;
> +       reg = SCTLR_CFIE | SCTLR_CFRE | SCTLR_M | SCTLR_EAE_SBOP;
>         if (stage1)
>                 reg |= SCTLR_S1_ASIDPNE;
>  #ifdef __BIG_ENDIAN
> --
> 2.1.4
>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
