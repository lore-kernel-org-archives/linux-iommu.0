Return-Path: <SRS0=cOz4=6E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DDDC54FCB
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 15:58:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9CF2082E
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 15:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9CF2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BF07987456;
	Mon, 20 Apr 2020 15:58:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mDkh17swOJnw; Mon, 20 Apr 2020 15:58:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D648387117;
	Mon, 20 Apr 2020 15:58:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B85CAC07FF;
	Mon, 20 Apr 2020 15:58:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27A4FC07FF
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 15:58:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 23FA385F94
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 15:58:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BM23-VeHNHEx for <iommu@lists.linux-foundation.org>;
 Mon, 20 Apr 2020 15:58:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5F0E286008
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 15:58:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B36BD31B;
 Mon, 20 Apr 2020 08:58:00 -0700 (PDT)
Received: from [10.57.33.63] (unknown [10.57.33.63])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6403E3F73D;
 Mon, 20 Apr 2020 08:57:58 -0700 (PDT)
Subject: Re: [PATCHv2 2/6] iommu/arm-smmu: Allow client devices to select
 direct mapping
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Sibi Sankar <sibis@codeaurora.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Rob Clark <robdclark@gmail.com>
References: <cover.1587392905.git.saiprakash.ranjan@codeaurora.org>
 <14539e787e6d8b7bd0a6d8f8a001baae6f691988.1587392905.git.saiprakash.ranjan@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e35b10dc-8e58-f201-8485-9543dafbadfe@arm.com>
Date: Mon, 20 Apr 2020 16:57:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <14539e787e6d8b7bd0a6d8f8a001baae6f691988.1587392905.git.saiprakash.ranjan@codeaurora.org>
Content-Language: en-GB
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Stephen Boyd <swboyd@chromium.org>,
 iommu@lists.linux-foundation.org, Matthias Kaehlcke <mka@chromium.org>,
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

On 2020-04-20 3:37 pm, Sai Prakash Ranjan wrote:
> From: Jordan Crouse <jcrouse@codeaurora.org>
> 
> Some client devices want to directly map the IOMMU themselves instead
> of using the DMA domain. Allow those devices to opt in to direct
> mapping by way of a list of compatible strings.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> Co-developed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>   drivers/iommu/arm-smmu-qcom.c | 19 +++++++++++++++++++
>   drivers/iommu/arm-smmu.h      |  1 +
>   2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
> index 64a4ab270ab7..0b3f159065aa 100644
> --- a/drivers/iommu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm-smmu-qcom.c
> @@ -3,6 +3,7 @@
>    * Copyright (c) 2019, The Linux Foundation. All rights reserved.
>    */
>   
> +#include <linux/of_device.h>
>   #include <linux/qcom_scm.h>
>   
>   #include "arm-smmu.h"
> @@ -11,6 +12,23 @@ struct qcom_smmu {
>   	struct arm_smmu_device smmu;
>   };
>   
> +static const struct of_device_id qcom_smmu_client_of_match[] = {
> +	{ .compatible = "qcom,adreno" },
> +	{ .compatible = "qcom,mdp4" },
> +	{ .compatible = "qcom,mdss" },
> +	{ .compatible = "qcom,sc7180-mdss" },
> +	{ .compatible = "qcom,sdm845-mdss" },
> +	{ }
> +};
> +
> +static int qcom_smmu_request_domain(struct device *dev)
> +{
> +	const struct of_device_id *match =
> +		of_match_device(qcom_smmu_client_of_match, dev);
> +
> +	return match ? IOMMU_DOMAIN_IDENTITY : 0;
> +}
> +
>   static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
>   {
>   	int ret;
> @@ -41,6 +59,7 @@ static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
>   }
>   
>   static const struct arm_smmu_impl qcom_smmu_impl = {
> +	.req_domain = qcom_smmu_request_domain,
>   	.reset = qcom_smmu500_reset,
>   };
>   
> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> index 8d1cd54d82a6..662fdb4dccd2 100644
> --- a/drivers/iommu/arm-smmu.h
> +++ b/drivers/iommu/arm-smmu.h
> @@ -386,6 +386,7 @@ struct arm_smmu_impl {
>   	int (*init_context)(struct arm_smmu_domain *smmu_domain);
>   	void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
>   			 int status);
> +	int (*req_domain)(struct device *dev);

Nit: since the point is to implement the full iommu_ops::def_domain_type 
interface, can we call it def_domain_type please?

Robin.

>   };
>   
>   static inline void __iomem *arm_smmu_page(struct arm_smmu_device *smmu, int n)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
