Return-Path: <SRS0=amFV=MT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B9CC4338F
	for <iommu@archiver.kernel.org>; Tue, 27 Jul 2021 10:26:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202C0611C4
	for <iommu@archiver.kernel.org>; Tue, 27 Jul 2021 10:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 202C0611C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF5EF402F1;
	Tue, 27 Jul 2021 10:26:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UFsEN2DdAaxA; Tue, 27 Jul 2021 10:26:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A9C49402FA;
	Tue, 27 Jul 2021 10:26:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7ABA8C001A;
	Tue, 27 Jul 2021 10:26:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 711CBC000E
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 10:26:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 585E860798
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 10:26:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M7L1MgG2q6hC for <iommu@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 10:25:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F02A605A7
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 10:25:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0245E1FB;
 Tue, 27 Jul 2021 03:25:58 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 513083F73D;
 Tue, 27 Jul 2021 03:25:56 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu: Add clk_bulk_{prepare/unprepare} to
 system pm callbacks
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, Taniya Das <tdas@codeaurora.org>,
 srimuc <srimuc@codeaurora.org>
References: <20210727093322.13202-1-saiprakash.ranjan@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <955a3034-f7e7-f8f9-4abd-b65efbfbb404@arm.com>
Date: Tue, 27 Jul 2021 11:25:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210727093322.13202-1-saiprakash.ranjan@codeaurora.org>
Content-Language: en-GB
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On 2021-07-27 10:33, Sai Prakash Ranjan wrote:
> Some clocks for SMMU can have parent as XO such as gpu_cc_hub_cx_int_clk
> of GPU SMMU in QTI SC7280 SoC and in order to enter deep sleep states in
> such cases, we would need to drop the XO clock vote in unprepare call and
> this unprepare callback for XO is in RPMh (Resource Power Manager-Hardened)
> clock driver which controls RPMh managed clock resources for new QTI SoCs
> and is a blocking call.
> 
> Given we cannot have a sleeping calls such as clk_bulk_prepare() and
> clk_bulk_unprepare() in arm-smmu runtime pm callbacks since the iommu
> operations like map and unmap can be in atomic context and are in fast
> path, add this prepare and unprepare call to drop the XO vote only for
> system pm callbacks since it is not a fast path and we expect the system
> to enter deep sleep states with system pm as opposed to runtime pm.
> 
> This is a similar sequence of clock requests (prepare,enable and
> disable,unprepare) in arm-smmu probe and remove.

Nope. We call arm_smmu_rpm_get(), which may resume the device, from 
atomic contexts. clk_prepare() may sleep. This doesn't work.

Robin.

> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Co-developed-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index d3c6f54110a5..9561ba4c5d39 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -2277,6 +2277,13 @@ static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
>   
>   static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>   {
> +	int ret;
> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +
> +	ret = clk_bulk_prepare(smmu->num_clks, smmu->clks);
> +	if (ret)
> +		return ret;
> +
>   	if (pm_runtime_suspended(dev))
>   		return 0;
>   
> @@ -2285,10 +2292,19 @@ static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>   
>   static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
>   {
> +	int ret = 0;
> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +
>   	if (pm_runtime_suspended(dev))
> -		return 0;
> +		goto clk_unprepare;
>   
> -	return arm_smmu_runtime_suspend(dev);
> +	ret = arm_smmu_runtime_suspend(dev);
> +	if (ret)
> +		return ret;
> +
> +clk_unprepare:
> +	clk_bulk_unprepare(smmu->num_clks, smmu->clks);
> +	return ret;
>   }
>   
>   static const struct dev_pm_ops arm_smmu_pm_ops = {
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
