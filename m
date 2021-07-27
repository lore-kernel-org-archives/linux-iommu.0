Return-Path: <SRS0=amFV=MT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98381C4338F
	for <iommu@archiver.kernel.org>; Tue, 27 Jul 2021 13:44:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4508E61A8E
	for <iommu@archiver.kernel.org>; Tue, 27 Jul 2021 13:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4508E61A8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1482F6072F;
	Tue, 27 Jul 2021 13:44:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JbxTVkjiVTX7; Tue, 27 Jul 2021 13:44:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 929006003C;
	Tue, 27 Jul 2021 13:44:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BEC1C0010;
	Tue, 27 Jul 2021 13:44:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 412C9C000E
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 13:44:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 206CC4030A
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 13:44:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HRs_arJ2mXJN for <iommu@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 13:44:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 702B1402F2
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 13:44:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 145041FB;
 Tue, 27 Jul 2021 06:44:43 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 969BE3F66F;
 Tue, 27 Jul 2021 06:44:40 -0700 (PDT)
Subject: Re: [PATCH -next v2] iommu/arm-smmu-v3: Add suspend and resume support
To: Bixuan Cui <cuibixuan@huawei.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, will@kernel.org
References: <20210727121408.81883-1-cuibixuan@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <6b959d09-936a-cee2-02f4-376d74efa417@arm.com>
Date: Tue, 27 Jul 2021 14:44:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210727121408.81883-1-cuibixuan@huawei.com>
Content-Language: en-GB
Cc: jean-philippe@linaro.org, maz@kernel.org, john.wanghui@huawei.com,
 weiyongjun1@huawei.com, dingtianhong@huawei.com, guohanjun@huawei.com,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-07-27 13:14, Bixuan Cui wrote:
> Add suspend and resume support for arm-smmu-v3 by low-power mode.
> 
> When the smmu is suspended, it is powered off and the registers are
> cleared. So saves the msi_msg context during msi interrupt initialization
> of smmu. When resume happens it calls arm_smmu_device_reset() to restore
> the registers.
> 
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> Reviewed-by: Wei Yongjun <weiyongjun1@huawei.com>
> Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
> Reviewed-by: Ding Tianhong <dingtianhong@huawei.com>
> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
> ---
> Changes in v2:
> * Using get_cached_msi_msg() instead of the descriptor to resume msi_msg
>    in arm_smmu_resume_msis();
> 
> * Move arm_smmu_resume_msis() from arm_smmu_setup_unique_irqs() into
>    arm_smmu_setup_irqs() and rename it to arm_smmu_resume_unique_irqs();
> 
>    Call arm_smmu_setup_unique_irqs() to configure the IRQ during probe and
>    call arm_smmu_resume_unique_irqs() in resume mode to restore the IRQ
>    registers to make the code more reasonable.
> 
> * Call arm_smmu_device_disable() to disable smmu and clear CR0_SMMUEN on
>    suspend. Then the warning about CR0_SMMUEN being enabled can be cleared
>    on resume.
> 
> * Using SET_SYSTEM_SLEEP_PM_OPS();
> 
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 69 ++++++++++++++++++---
>   1 file changed, 62 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 235f9bdaeaf2..66f35d5c7a70 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -40,6 +40,7 @@ MODULE_PARM_DESC(disable_bypass,
>   
>   static bool disable_msipolling;
>   module_param(disable_msipolling, bool, 0444);
> +static bool bypass;

This is still broken.

>   MODULE_PARM_DESC(disable_msipolling,
>   	"Disable MSI-based polling for CMD_SYNC completion.");
>   
> @@ -3129,11 +3130,38 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>   	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
>   	doorbell &= MSI_CFG0_ADDR_MASK;
>   
> +	/* Saves the msg context for resume if desc->msg is empty */
> +	if (desc->msg.address_lo == 0x0 && desc->msg.address_hi == 0x0) {
> +		desc->msg.address_lo = msg->address_lo;
> +		desc->msg.address_hi = msg->address_hi;
> +		desc->msg.data = msg->data;
> +	}
> +
>   	writeq_relaxed(doorbell, smmu->base + cfg[0]);
>   	writel_relaxed(msg->data, smmu->base + cfg[1]);
>   	writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
>   }
>   
> +static void arm_smmu_resume_unique_irqs(struct arm_smmu_device *smmu)
> +{
> +	struct msi_desc *desc;
> +	struct msi_msg msg;
> +
> +	desc = irq_get_msi_desc(smmu->evtq.q.irq);
> +	get_cached_msi_msg(smmu->evtq.q.irq, &msg);
> +	arm_smmu_write_msi_msg(desc, &msg);

OK, now I think you actually *have* broken wired interrupts. What if 
desc is NULL here?

> +	desc = irq_get_msi_desc(smmu->gerr_irq);
> +	get_cached_msi_msg(smmu->gerr_irq, &msg);
> +	arm_smmu_write_msi_msg(desc, &msg);
> +
> +	if (smmu->features & ARM_SMMU_FEAT_PRI) {
> +		desc = irq_get_msi_desc(smmu->priq.q.irq);
> +		get_cached_msi_msg(smmu->priq.q.irq, &msg);
> +		arm_smmu_write_msi_msg(desc, &msg);
> +	}
> +}
> +
>   static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>   {
>   	struct msi_desc *desc;
> @@ -3230,7 +3258,7 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
>   	}
>   }
>   
> -static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> +static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu, bool resume_mode)
>   {
>   	int ret, irq;
>   	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
> @@ -3256,8 +3284,12 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>   					"arm-smmu-v3-combined-irq", smmu);
>   		if (ret < 0)
>   			dev_warn(smmu->dev, "failed to enable combined irq\n");
> -	} else
> -		arm_smmu_setup_unique_irqs(smmu);
> +	} else {
> +		if (!resume_mode)
> +			arm_smmu_setup_unique_irqs(smmu);
> +		else
> +			arm_smmu_resume_unique_irqs(smmu);
> +	}

This is still pretty much unreadable. As I said, a clear refactoring to 
logically separate requesting the IRQs from programming the registers 
would be the preferred way forward.

>   
>   	if (smmu->features & ARM_SMMU_FEAT_PRI)
>   		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
> @@ -3282,7 +3314,7 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
>   	return ret;
>   }
>   
> -static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
> +static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool resume_mode)
>   {
>   	int ret;
>   	u32 reg, enables;
> @@ -3392,7 +3424,7 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>   		}
>   	}
>   
> -	ret = arm_smmu_setup_irqs(smmu);
> +	ret = arm_smmu_setup_irqs(smmu, resume_mode);
>   	if (ret) {
>   		dev_err(smmu->dev, "failed to setup irqs\n");
>   		return ret;
> @@ -3749,6 +3781,25 @@ static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
>   	return devm_ioremap_resource(dev, &res);
>   }
>   
> +static int __maybe_unused arm_smmu_suspend(struct device *dev)
> +{
> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +
> +	/* disable smmu to clear CR0 */
> +	arm_smmu_device_disable(smmu);

Why? At worst this might actually cause more problems if there are any 
client devices which have not been quiesced due to non-PM-aware drivers. 
AFAICS this is just doing unnecessary work in the wrong place in an 
attempt to avoid refactoring the reset routine. Don't do that, do it 
properly.

It is the nature of kernel development that small changes build up over 
time to a point where code starts to become unwieldy and deserves 
refactoring. This code happens to be at that point - if making a small 
logical change ends up needing a large invasive patch, that's usually a 
sign that the code no longer has the best design for what it needs to 
do, and *should* have the large invasive refactor for the sake of future 
maintenance and development. Wanting to make the existing mess even more 
convoluted because it's already enough of a mess that you're scared to 
touch it too much is a self-defeating argument.

I ended up rewriting half of the SMMUv2 driver in the name of adding 
suspend/resume support, precisely because doing so was also beneficial 
in several other ways - what looks to want doing in this case is nowhere 
near as involved as that was.

Robin.

> +	return 0;
> +}
> +
> +static int __maybe_unused arm_smmu_resume(struct device *dev)
> +{
> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +
> +	arm_smmu_device_reset(smmu, true);
> +
> +	return 0;
> +}
> +
>   static int arm_smmu_device_probe(struct platform_device *pdev)
>   {
>   	int irq, ret;
> @@ -3756,7 +3807,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	resource_size_t ioaddr;
>   	struct arm_smmu_device *smmu;
>   	struct device *dev = &pdev->dev;
> -	bool bypass;
>   
>   	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
>   	if (!smmu)
> @@ -3831,7 +3881,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, smmu);
>   
>   	/* Reset the device */
> -	ret = arm_smmu_device_reset(smmu, bypass);
> +	ret = arm_smmu_device_reset(smmu, false);
>   	if (ret)
>   		return ret;
>   
> @@ -3884,6 +3934,10 @@ static const struct of_device_id arm_smmu_of_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>   
> +static const struct dev_pm_ops arm_smmu_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(arm_smmu_suspend, arm_smmu_resume)
> +};
> +
>   static void arm_smmu_driver_unregister(struct platform_driver *drv)
>   {
>   	arm_smmu_sva_notifier_synchronize();
> @@ -3895,6 +3949,7 @@ static struct platform_driver arm_smmu_driver = {
>   		.name			= "arm-smmu-v3",
>   		.of_match_table		= arm_smmu_of_match,
>   		.suppress_bind_attrs	= true,
> +		.pm			= &arm_smmu_pm_ops,
>   	},
>   	.probe	= arm_smmu_device_probe,
>   	.remove	= arm_smmu_device_remove,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
