From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Warn about missing IRQs
Date: Fri, 27 Oct 2017 17:52:16 +0100
Message-ID: <20171027165215.GA28642@arm.com>
References: <f03a7c9f0be2f0af461b61d18fff3c931da77ebb.1509109598.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f03a7c9f0be2f0af461b61d18fff3c931da77ebb.1509109598.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Oct 27, 2017 at 02:08:16PM +0100, Robin Murphy wrote:
> It is annoyingly non-obvious when DMA transactions silently go missing
> due to undetected SMMU faults. Help skip the first few debugging steps
> in those situations by making it clear when we have neither wired IRQs
> nor MSIs with which to raise error conditions.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index e67ba6c40faf..1a374c5c9507 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2263,6 +2263,8 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
>  						"arm-smmu-v3-evtq", smmu);
>  		if (ret < 0)
>  			dev_warn(smmu->dev, "failed to enable evtq irq\n");
> +	} else {
> +		dev_warn(smmu->dev, "no evtq irq - events will not be reported!\n");
>  	}
>  
>  	irq = smmu->cmdq.q.irq;
> @@ -2280,6 +2282,8 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
>  				       0, "arm-smmu-v3-gerror", smmu);
>  		if (ret < 0)
>  			dev_warn(smmu->dev, "failed to enable gerror irq\n");
> +	} else {
> +		dev_warn(smmu->dev, "no gerr irq - errors will not be reported!\n");
>  	}
>  
>  	if (smmu->features & ARM_SMMU_FEAT_PRI) {

Can we also print something similar for the PRIQ when we detect that PRI is
supported, please? Whilst I agree that event and gerror are the critical
ones, I'm not sure how a PCIe device behaves if its PRI requests are
ignored, but this might help to debug it.

Will
