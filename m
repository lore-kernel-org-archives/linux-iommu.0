From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4] iommu/arm-smmu: avoid calling request_irq in atomic
	context
Date: Thu, 31 Jul 2014 19:30:22 +0100
Message-ID: <20140731183021.GJ26853@arm.com>
References: <1406743093-17227-1-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406743093-17227-1-git-send-email-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 30, 2014 at 06:58:13PM +0100, Mitchel Humpherys wrote:
> request_irq shouldn't be called from atomic context since it might
> sleep, but we're calling it with a spinlock held, resulting in:

[...]

> @@ -900,22 +905,23 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  		cfg->irptndx = cfg->cbndx;
>  	}
>  
> +	ACCESS_ONCE(smmu_domain->smmu) = smmu;
> +	arm_smmu_init_context_bank(smmu_domain);
> +	spin_unlock_irqrestore(&smmu_domain->lock, flags);
> +
>  	irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
>  	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
> -			  "arm-smmu-context-fault", domain);
> +			  "arm-smmu-context-fault", smmu_domain);

This blew up in testing since we free_irq using the iommu_domain as the
token, so we should leave the domain parameter as it is (not actually
sure why this got changed). No need to resend anything, I'll fix it
locally.

Cheers,

Will
