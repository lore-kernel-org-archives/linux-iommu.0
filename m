From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: use a threaded handler for context
	interrupts
Date: Fri, 23 Jan 2015 11:24:15 +0000
Message-ID: <20150123112415.GD23058@arm.com>
References: <1421970482-11722-1-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421970482-11722-1-git-send-email-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Mitch,

On Thu, Jan 22, 2015 at 11:48:02PM +0000, Mitchel Humpherys wrote:
> Context interrupts can call domain-specific handlers which might sleep.
> Currently we register our handler with request_irq, so our handler is
> called in atomic context, so domain handlers that sleep result in an
> invalid context BUG.  Fix this by using request_threaded_irq.
> 
> This also prepares the way for doing things like enabling clocks within
> our interrupt handler.
> 
> Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 6cd47b75286f..81f6b54d94b1 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -973,8 +973,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  	spin_unlock_irqrestore(&smmu_domain->lock, flags);
>  
>  	irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
> -	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
> -			  "arm-smmu-context-fault", domain);
> +	ret = request_threaded_irq(irq, NULL, arm_smmu_context_fault,
> +				IRQF_ONESHOT | IRQF_SHARED,
> +				"arm-smmu-context-fault", domain);
>  	if (IS_ERR_VALUE(ret)) {
>  		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
>  			cfg->irptndx, irq);

I think I'd rather keep a simple atomic handler, then have a threaded
handler for actually issuing the report_iommu_fault. i.e. we only wake
the thread when it looks like there's some work to do. That also works
much better for shared interrupts.

Will
