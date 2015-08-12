From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 3/5] iommu/msm: Add support for generic master bindings
Date: Wed, 12 Aug 2015 12:11:57 -0700
Message-ID: <55CB9A7D.7080206@codeaurora.org>
References: <1439390869-6347-1-git-send-email-sricharan@codeaurora.org> <1439390869-6347-4-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1439390869-6347-4-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, robin.murphy@arm.com, robdclark@gmail.com, joro@8bytes.org, srinivas.kandagatla@linaro.org, laurent.pinchart@ideasonboard.com, Will.Deacon@arm.com, stepanm@codeaurora.org, treding@nvidia.com
List-Id: iommu@lists.linux-foundation.org

On 08/12/2015 07:47 AM, Sricharan R wrote:
> @@ -702,6 +703,44 @@ static void print_ctx_regs(void __iomem *base, int ctx)
>   	       GET_PRRR(base, ctx), GET_NMRR(base, ctx));
>   }
>   
> +static void insert_iommu_master(struct device *dev,
> +				struct msm_iommu_dev *iommu,
> +				struct of_phandle_args *spec)
> +{
> +	struct msm_iommu_ctx_dev *master;
> +	int sid;
> +
> +	master = kzalloc(sizeof(*master), GFP_KERNEL);

This is called with irqs disabled, but it's not GFP_ATOMIC. Please test 
with DEBUG_ATOMIC_SLEEP=y.

> +	master->of_node = dev->of_node;
> +	list_add(&master->list, &iommu->ctx_list);
> +
> +	for (sid = 0; sid < spec->args_count; sid++)
> +		master->mids[sid] = spec->args[sid];
> +
> +	master->num_mids = spec->args_count;
> +}
> +
> +static int qcom_iommu_of_xlate(struct device *dev,
> +			       struct of_phandle_args *spec)
> +{
> +	struct msm_iommu_dev *iommu;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&msm_iommu_lock, flags);
> +	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node) {
> +		if (iommu->dev->of_node == spec->np)
> +			break;
> +	}

The braces are unnecessary here.

> +
> +	if (!iommu || (iommu->dev->of_node != spec->np))

Please remove extraneous parentheses.

> +		return -ENODEV;
> +
> +	insert_iommu_master(dev, iommu, spec);
> +	spin_unlock_irqrestore(&msm_iommu_lock, flags);
> +
> +	return 0;
> +}
> +
>   irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
>   {
>   	struct msm_iommu_dev *iommu = dev_id;
> @@ -737,7 +776,7 @@ fail:
>   	return 0;
>   }
>   
> -static const struct iommu_ops msm_iommu_ops = {
> +static struct iommu_ops msm_iommu_ops = {

Is there a reason why we can't make of_iommu_set_ops() take a const ops 
pointer?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
