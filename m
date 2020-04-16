Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B31FC2BB55
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 13:58:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 205DE21744
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 13:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205DE21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BFFFD8306B;
	Thu, 16 Apr 2020 13:58:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cJSFaKTF8K5F; Thu, 16 Apr 2020 13:58:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A2F2C820D3;
	Thu, 16 Apr 2020 13:58:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F9B0C089E;
	Thu, 16 Apr 2020 13:58:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A09DDC0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 13:58:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8F2D122264
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 13:58:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eaIwc8a7CwW7 for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 13:58:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 4E09B1FEB7
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 13:58:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95ABD1FB;
 Thu, 16 Apr 2020 06:58:30 -0700 (PDT)
Received: from [10.57.59.184] (unknown [10.57.59.184])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4786A3F237;
 Thu, 16 Apr 2020 06:58:27 -0700 (PDT)
Subject: Re: [PATCH 2/2] iommu/arm-smmu: Allow client devices to select direct
 mapping
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Rob Clark <robdclark@gmail.com>
References: <cover.1579692800.git.saiprakash.ranjan@codeaurora.org>
 <813cc5b2da10c27db982254b274bf26008a9e6da.1579692800.git.saiprakash.ranjan@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3f12cefb-3887-859c-ddf5-c7a0fc755152@arm.com>
Date: Thu, 16 Apr 2020 14:58:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <813cc5b2da10c27db982254b274bf26008a9e6da.1579692800.git.saiprakash.ranjan@codeaurora.org>
Content-Language: en-GB
Cc: Rajendra Nayak <rnayak@codeaurora.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stephen Boyd <swboyd@chromium.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Matthias Kaehlcke <mka@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On 2020-01-22 11:48 am, Sai Prakash Ranjan wrote:
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
>   drivers/iommu/arm-smmu-qcom.c | 39 +++++++++++++++++++++++++++++++++++
>   drivers/iommu/arm-smmu.c      |  3 +++
>   drivers/iommu/arm-smmu.h      |  5 +++++
>   3 files changed, 47 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
> index 64a4ab270ab7..ff746acd1c81 100644
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
> @@ -11,6 +12,43 @@ struct qcom_smmu {
>   	struct arm_smmu_device smmu;
>   };
>   
> +static const struct arm_smmu_client_match_data qcom_adreno = {
> +	.direct_mapping = true,
> +};
> +
> +static const struct arm_smmu_client_match_data qcom_mdss = {
> +	.direct_mapping = true,
> +};

Might it make sense to group these by the desired SMMU behaviour rather 
than (apparently) what kind of device the client happens to be, which 
seems like a completely arbitrary distinction from the SMMU driver's PoV?

> +
> +static const struct of_device_id qcom_smmu_client_of_match[] = {
> +	{ .compatible = "qcom,adreno", .data = &qcom_adreno },
> +	{ .compatible = "qcom,mdp4", .data = &qcom_mdss },
> +	{ .compatible = "qcom,mdss", .data = &qcom_mdss },
> +	{ .compatible = "qcom,sc7180-mdss", .data = &qcom_mdss },
> +	{ .compatible = "qcom,sdm845-mdss", .data = &qcom_mdss },
> +	{},
> +};
> +
> +static const struct arm_smmu_client_match_data *
> +qcom_smmu_client_data(struct device *dev)
> +{
> +	const struct of_device_id *match =
> +		of_match_device(qcom_smmu_client_of_match, dev);
> +
> +	return match ? match->data : NULL;

of_device_get_match_data() is your friend.

> +}
> +
> +static int qcom_smmu_request_domain(struct device *dev)
> +{
> +	const struct arm_smmu_client_match_data *client;
> +
> +	client = qcom_smmu_client_data(dev);
> +	if (client)
> +		iommu_request_dm_for_dev(dev);
> +
> +	return 0;
> +}
> +
>   static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
>   {
>   	int ret;
> @@ -41,6 +79,7 @@ static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
>   }
>   
>   static const struct arm_smmu_impl qcom_smmu_impl = {
> +	.req_domain = qcom_smmu_request_domain,
>   	.reset = qcom_smmu500_reset,
>   };
>   
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 16c4b87af42b..67dd9326247a 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1448,6 +1448,9 @@ static int arm_smmu_add_device(struct device *dev)
>   	device_link_add(dev, smmu->dev,
>   			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
>   
> +	if (smmu->impl && smmu->impl->req_domain)
> +		return smmu->impl->req_domain(dev);
> +

There are about 5 different patchsets flying around at the moment that 
all touch default domain allocation, so this is a fast-moving target, 
but I think where the dust should settle is with arm_smmu_ops forwarding 
.def_domain_type (or whatever it ends up as) calls to arm_smmu_impl as 
appropriate.

>   	return 0;
>   
>   out_cfg_free:
> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> index 8d1cd54d82a6..059dc9c39f64 100644
> --- a/drivers/iommu/arm-smmu.h
> +++ b/drivers/iommu/arm-smmu.h
> @@ -244,6 +244,10 @@ enum arm_smmu_arch_version {
>   	ARM_SMMU_V2,
>   };
>   
> +struct arm_smmu_client_match_data {
> +	bool direct_mapping;
> +};

Does this need to be public? I don't see the other users...

Robin.

> +
>   enum arm_smmu_implementation {
>   	GENERIC_SMMU,
>   	ARM_MMU500,
> @@ -386,6 +390,7 @@ struct arm_smmu_impl {
>   	int (*init_context)(struct arm_smmu_domain *smmu_domain);
>   	void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
>   			 int status);
> +	int (*req_domain)(struct device *dev);
>   };
>   
>   static inline void __iomem *arm_smmu_page(struct arm_smmu_device *smmu, int n)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
