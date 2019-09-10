Return-Path: <SRS0=BH3E=XF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D14C49ED6
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 13:26:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71ED6206CD
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 13:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71ED6206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 47681DAC;
	Tue, 10 Sep 2019 13:26:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 75D0BDA6
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 13:26:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 3B2F18A2
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 13:26:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A19B828;
	Tue, 10 Sep 2019 06:26:30 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 968663F59C;
	Tue, 10 Sep 2019 06:26:29 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] iommu: arm-smmu-impl: Add sdm845 implementation
	hook
To: Vivek Gautam <vivek.gautam@codeaurora.org>, joro@8bytes.org,
	agross@kernel.org, will.deacon@arm.com, iommu@lists.linux-foundation.org
References: <20190823063248.13295-1-vivek.gautam@codeaurora.org>
	<20190823063248.13295-4-vivek.gautam@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9fb7d18c-e292-cbc9-aa6d-d85465ea249e@arm.com>
Date: Tue, 10 Sep 2019 14:26:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190823063248.13295-4-vivek.gautam@codeaurora.org>
Content-Language: en-GB
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	bjorn.andersson@linaro.org
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

On 23/08/2019 07:32, Vivek Gautam wrote:
> Add reset hook for sdm845 based platforms to turn off
> the wait-for-safe sequence.
> 
> Understanding how wait-for-safe logic affects USB and UFS performance
> on MTP845 and DB845 boards:
> 
> Qcom's implementation of arm,mmu-500 adds a WAIT-FOR-SAFE logic
> to address under-performance issues in real-time clients, such as
> Display, and Camera.
> On receiving an invalidation requests, the SMMU forwards SAFE request
> to these clients and waits for SAFE ack signal from real-time clients.
> The SAFE signal from such clients is used to qualify the start of
> invalidation.
> This logic is controlled by chicken bits, one for each - MDP (display),
> IFE0, and IFE1 (camera), that can be accessed only from secure software
> on sdm845.
> 
> This configuration, however, degrades the performance of non-real time
> clients, such as USB, and UFS etc. This happens because, with wait-for-safe
> logic enabled the hardware tries to throttle non-real time clients while
> waiting for SAFE ack signals from real-time clients.
> 
> On mtp845 and db845 devices, with wait-for-safe logic enabled by the
> bootloaders we see degraded performance of USB and UFS when kernel
> enables the smmu stage-1 translations for these clients.
> Turn off this wait-for-safe logic from the kernel gets us back the perf
> of USB and UFS devices until we re-visit this when we start seeing perf
> issues on display/camera on upstream supported SDM845 platforms.
> The bootloaders on these boards implement secure monitor callbacks to
> handle a specific command - QCOM_SCM_SVC_SMMU_PROGRAM with which the
> logic can be toggled.
> 
> There are other boards such as cheza whose bootloaders don't enable this
> logic. Such boards don't implement callbacks to handle the specific SCM
> call so disabling this logic for such boards will be a no-op.
> 
> This change is inspired by the downstream change from Patrick Daly
> to address performance issues with display and camera by handling
> this wait-for-safe within separte io-pagetable ops to do TLB
> maintenance. So a big thanks to him for the change and for all the
> offline discussions.
> 
> Without this change the UFS reads are pretty slow:
> $ time dd if=/dev/sda of=/dev/zero bs=1048576 count=10 conv=sync
> 10+0 records in
> 10+0 records out
> 10485760 bytes (10.0MB) copied, 22.394903 seconds, 457.2KB/s
> real    0m 22.39s
> user    0m 0.00s
> sys     0m 0.01s
> 
> With this change they are back to rock!
> $ time dd if=/dev/sda of=/dev/zero bs=1048576 count=300 conv=sync
> 300+0 records in
> 300+0 records out
> 314572800 bytes (300.0MB) copied, 1.030541 seconds, 291.1MB/s
> real    0m 1.03s
> user    0m 0.00s
> sys     0m 0.54s
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>   drivers/iommu/arm-smmu-impl.c | 27 ++++++++++++++++++++++++++-

I'd be inclined to introduce the inevitable arm-smmu-qcom.c from the 
start, and save worrying about moving this out later. Other than that, 
though, the general self-contained shape of it all is every bit as 
beautiful as I'd hoped :D

Robin.

>   1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
> index 3f88cd078dd5..0aef87c41f9c 100644
> --- a/drivers/iommu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm-smmu-impl.c
> @@ -6,6 +6,7 @@
>   
>   #include <linux/bitfield.h>
>   #include <linux/of.h>
> +#include <linux/qcom_scm.h>
>   
>   #include "arm-smmu.h"
>   
> @@ -102,7 +103,6 @@ static struct arm_smmu_device *cavium_smmu_impl_init(struct arm_smmu_device *smm
>   	return &cs->smmu;
>   }
>   
> -
>   #define ARM_MMU500_ACTLR_CPRE		(1 << 1)
>   
>   #define ARM_MMU500_ACR_CACHE_LOCK	(1 << 26)
> @@ -147,6 +147,28 @@ static const struct arm_smmu_impl arm_mmu500_impl = {
>   	.reset = arm_mmu500_reset,
>   };
>   
> +static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
> +{
> +	int ret;
> +
> +	arm_mmu500_reset(smmu);
> +
> +	/*
> +	 * To address performance degradation in non-real time clients,
> +	 * such as USB and UFS, turn off wait-for-safe on sdm845 based boards,
> +	 * such as MTP and db845, whose firmwares implement secure monitor
> +	 * call handlers to turn on/off the wait-for-safe logic.
> +	 */
> +	ret = qcom_scm_qsmmu500_wait_safe_toggle(0);
> +	if (ret)
> +		dev_warn(smmu->dev, "Failed to turn off SAFE logic\n");
> +
> +	return 0;
> +}
> +
> +const struct arm_smmu_impl qcom_sdm845_smmu500_impl = {
> +	.reset = qcom_sdm845_smmu500_reset,
> +};
>   
>   struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>   {
> @@ -170,5 +192,8 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>   				  "calxeda,smmu-secure-config-access"))
>   		smmu->impl = &calxeda_impl;
>   
> +	if (of_device_is_compatible(smmu->dev->of_node, "qcom,sdm845-smmu-500"))
> +		smmu->impl = &qcom_sdm845_smmu500_impl;
> +
>   	return smmu;
>   }
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
