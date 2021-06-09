Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7AAC48BD1
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 14:12:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3FD461354
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 14:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FD461354
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AE5A83CE0;
	Wed,  9 Jun 2021 14:12:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pyekVK_OeRbW; Wed,  9 Jun 2021 14:12:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5CD5083CCA;
	Wed,  9 Jun 2021 14:12:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2653CC000D;
	Wed,  9 Jun 2021 14:12:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BFCBC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 14:12:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 758084013C
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 14:12:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BQV_ANF_9Jqq for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 14:12:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id A7A9540137
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 14:12:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1121D6E;
 Wed,  9 Jun 2021 07:12:18 -0700 (PDT)
Received: from [10.57.6.115] (unknown [10.57.6.115])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D19A03F73D;
 Wed,  9 Jun 2021 07:12:16 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu: Fix arm_smmu_device refcount leak when
 arm_smmu_rpm_get fails
To: Xiyu Yang <xiyuyang19@fudan.edu.cn>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Krishna Reddy <vdumpa@nvidia.com>, Jordan Crouse <jordan@cosmicpenguin.net>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <1623245709-11123-1-git-send-email-xiyuyang19@fudan.edu.cn>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e5b8d7f6-862e-bca4-a1e9-35e0de47440e@arm.com>
Date: Wed, 9 Jun 2021 15:12:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1623245709-11123-1-git-send-email-xiyuyang19@fudan.edu.cn>
Content-Language: en-GB
Cc: Xin Tan <tanxin.ctf@gmail.com>, yuanxzhang@fudan.edu.cn
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

On 2021-06-09 14:35, Xiyu Yang wrote:
> arm_smmu_rpm_get() invokes pm_runtime_get_sync(), which increases the
> refcount of the "smmu" even though the return value is less than 0.
> 
> The reference counting issue happens in some error handling paths of
> arm_smmu_rpm_get() in its caller functions. When arm_smmu_rpm_get()
> fails, the caller functions forget to decrease the refcount of "smmu"
> increased by arm_smmu_rpm_get(), causing a refcount leak.
> 
> Fix this issue by calling arm_smmu_rpm_put() or jumping to the "rpm_put"
> label when arm_smmu_rpm_get() fails.

If only there was some kind of helper function which could encapsulate 
the correct expected behaviour in a single place...

In fact with the new pm_runtime_resume_and_get() API I think these two 
patches boil down to a one-line change.

Thanks,
Robin.

> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 6f72c4d208ca..177ee54c5534 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -840,7 +840,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>   
>   	ret = arm_smmu_rpm_get(smmu);
>   	if (ret < 0)
> -		return;
> +		goto rpm_put;
>   
>   	/*
>   	 * Disable the context bank and free the page tables before freeing
> @@ -857,6 +857,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>   	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
>   	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
>   
> +rpm_put:
>   	arm_smmu_rpm_put(smmu);
>   }
>   
> @@ -1153,7 +1154,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   
>   	ret = arm_smmu_rpm_get(smmu);
>   	if (ret < 0)
> -		return ret;
> +		goto rpm_put;
>   
>   	/* Ensure that the domain is finalised */
>   	ret = arm_smmu_init_domain_context(domain, smmu, dev);
> @@ -1404,7 +1405,7 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>   
>   	ret = arm_smmu_rpm_get(smmu);
>   	if (ret < 0)
> -		goto out_cfg_free;
> +		goto rpm_put;
>   
>   	ret = arm_smmu_master_alloc_smes(dev);
>   	arm_smmu_rpm_put(smmu);
> @@ -1417,6 +1418,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>   
>   	return &smmu->iommu;
>   
> +rpm_put:
> +	arm_smmu_rpm_put(smmu);
>   out_cfg_free:
>   	kfree(cfg);
>   out_free:
> @@ -1438,8 +1441,10 @@ static void arm_smmu_release_device(struct device *dev)
>   	smmu = cfg->smmu;
>   
>   	ret = arm_smmu_rpm_get(smmu);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		arm_smmu_rpm_put(smmu);
>   		return;
> +	}
>   
>   	arm_smmu_master_free_smes(cfg, fwspec);
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
