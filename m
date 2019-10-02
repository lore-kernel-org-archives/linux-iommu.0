Return-Path: <SRS0=9AUr=X3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7F3C35280
	for <iommu@archiver.kernel.org>; Wed,  2 Oct 2019 11:29:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5672621783
	for <iommu@archiver.kernel.org>; Wed,  2 Oct 2019 11:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5672621783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1274BDBB;
	Wed,  2 Oct 2019 11:29:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AC645DB4
	for <iommu@lists.linux-foundation.org>;
	Wed,  2 Oct 2019 11:29:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 2E949189
	for <iommu@lists.linux-foundation.org>;
	Wed,  2 Oct 2019 11:29:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DAFD28;
	Wed,  2 Oct 2019 04:29:49 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E25E63F71A;
	Wed,  2 Oct 2019 04:29:48 -0700 (PDT)
Subject: Re: [PATCH v4 4/7] iommu/qcom: Properly reset the IOMMU context
To: kholk11@gmail.com, linux-arm-msm@vger.kernel.org
References: <20191001220205.6423-1-kholk11@gmail.com>
	<20191001220205.6423-5-kholk11@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <968a89c4-7928-21be-e8cb-22c571c9cc29@arm.com>
Date: Wed, 2 Oct 2019 12:29:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191001220205.6423-5-kholk11@gmail.com>
Content-Language: en-GB
Cc: marijns95@gmail.com, agross@kernel.org, iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 01/10/2019 23:02, kholk11@gmail.com wrote:
> From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> 
> To avoid context faults reset the context entirely on detach and
> to ensure a fresh clean start also do a complete reset before
> programming the context for domain initialization.
> 
> Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
> ---
>   drivers/iommu/qcom_iommu.c | 23 +++++++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> index c8957ec83b92..b4a38ef129e3 100644
> --- a/drivers/iommu/qcom_iommu.c
> +++ b/drivers/iommu/qcom_iommu.c
> @@ -220,6 +220,23 @@ static irqreturn_t qcom_iommu_fault(int irq, void *dev)
>   	return IRQ_HANDLED;
>   }
>   
> +static void qcom_iommu_reset_ctx(struct qcom_iommu_ctx *ctx)
> +{
> +	iommu_writel(ctx, ARM_SMMU_CB_FAR, 0);
> +	iommu_writel(ctx, ARM_SMMU_CB_FSR, 0);
> +	iommu_writel(ctx, ARM_SMMU_CB_S1_MAIR1, 0);
> +	iommu_writel(ctx, ARM_SMMU_CB_PAR, 0);
> +	iommu_writel(ctx, ARM_SMMU_CB_S1_MAIR0, 0);
> +	iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
> +	iommu_writel(ctx, ARM_SMMU_CB_TCR2, 0);
> +	iommu_writel(ctx, ARM_SMMU_CB_TCR, 0);
> +	iommu_writeq(ctx, ARM_SMMU_CB_TTBR0, 0);
> +	iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
> +
> +	/* Should we issue a TLBSYNC there instead? */

Unless there are outstanding TLB invalidations, it wouldn't achieve 
much. That said, doing a TBLIALL as part of the reset sequence *would* 
generally be a good idea.

Also, since the write to SCTLR affects the overall enable state of the 
context bank, it would be best to do that before touching anything else.

Robin.

> +	mb();
> +}
> +
>   static int qcom_iommu_init_domain(struct iommu_domain *domain,
>   				  struct qcom_iommu_dev *qcom_iommu,
>   				  struct iommu_fwspec *fwspec)
> @@ -267,6 +284,8 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
>   			ctx->secure_init = true;
>   		}
>   
> +		qcom_iommu_reset_ctx(ctx);
> +
>   		/* TCR */
>   		iommu_writel(ctx, ARM_SMMU_CB_TCR2,
>   				(pgtbl_cfg.arm_lpae_s1_cfg.tcr >> 32) |
> @@ -412,8 +431,8 @@ static void qcom_iommu_detach_dev(struct iommu_domain *domain, struct device *de
>   	for (i = 0; i < fwspec->num_ids; i++) {
>   		struct qcom_iommu_ctx *ctx = to_ctx(fwspec, fwspec->ids[i]);
>   
> -		/* Disable the context bank: */
> -		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
> +		/* Disable and reset the context bank */
> +		qcom_iommu_reset_ctx(ctx);
>   
>   		ctx->domain = NULL;
>   	}
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
