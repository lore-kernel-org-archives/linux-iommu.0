Return-Path: <SRS0=jB4a=WS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A5AC3A5A1
	for <iommu@archiver.kernel.org>; Thu, 22 Aug 2019 12:36:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A27233FE
	for <iommu@archiver.kernel.org>; Thu, 22 Aug 2019 12:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A27233FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2CA78D9B;
	Thu, 22 Aug 2019 12:36:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4CCC5C90
	for <iommu@lists.linux-foundation.org>;
	Thu, 22 Aug 2019 12:36:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 8B95F67F
	for <iommu@lists.linux-foundation.org>;
	Thu, 22 Aug 2019 12:36:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB14228;
	Thu, 22 Aug 2019 05:36:15 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43D823F706;
	Thu, 22 Aug 2019 05:36:15 -0700 (PDT)
Subject: Re: [PATCH v2 7/8] iommu/arm-smmu-v3: Avoid locking on invalidation
	path when not using ATS
To: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org
References: <20190821151749.23743-1-will@kernel.org>
	<20190821151749.23743-8-will@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <45a2699a-bc38-16de-a90f-e92424495c2c@arm.com>
Date: Thu, 22 Aug 2019 13:36:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190821151749.23743-8-will@kernel.org>
Content-Language: en-GB
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
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

On 21/08/2019 16:17, Will Deacon wrote:
> When ATS is not in use, we can avoid taking the 'devices_lock' for the
> domain on the invalidation path by simply caching the number of ATS
> masters currently attached. The fiddly part is handling a concurrent
> ->attach() of an ATS-enabled master to a domain that is being
> invalidated, but we can handle this using an 'smp_mb()' to ensure that
> our check of the count is ordered after completion of our prior TLB
> invalidation.
> 
> This also makes our ->attach() and ->detach() flows symmetric wrt ATS
> interactions.

I don't have the bandwidth just now for a deep dive into the ordering 
subtleties, but on the surface I think this looks sound - provided that 
we don't forget and start calling arm_smmu_atc_inv_master() directly 
from anywhere other than detach.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   drivers/iommu/arm-smmu-v3.c | 37 ++++++++++++++++++++++++++++++++-----
>   1 file changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index ca504a60312d..0e43529d55fe 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -654,6 +654,7 @@ struct arm_smmu_domain {
>   
>   	struct io_pgtable_ops		*pgtbl_ops;
>   	bool				non_strict;
> +	atomic_t			nr_ats_masters;
>   
>   	enum arm_smmu_domain_stage	stage;
>   	union {
> @@ -1926,6 +1927,23 @@ static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
>   	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
>   		return 0;
>   
> +	/*
> +	 * Ensure that we've completed prior invalidation of the main TLBs
> +	 * before we read 'nr_ats_masters' in case of a concurrent call to
> +	 * arm_smmu_enable_ats():
> +	 *
> +	 *	// unmap()			// arm_smmu_enable_ats()
> +	 *	TLBI+SYNC			atomic_inc(&nr_ats_masters);
> +	 *	smp_mb();			[...]
> +	 *	atomic_read(&nr_ats_masters);	pci_enable_ats() // writel()
> +	 *
> +	 * Ensures that we always see the incremented 'nr_ats_masters' count if
> +	 * ATS was enabled at the PCI device before completion of the TLBI.
> +	 */
> +	smp_mb();
> +	if (!atomic_read(&smmu_domain->nr_ats_masters))
> +		return 0;
> +
>   	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
>   
>   	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> @@ -2312,6 +2330,7 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
>   	size_t stu;
>   	struct pci_dev *pdev;
>   	struct arm_smmu_device *smmu = master->smmu;
> +	struct arm_smmu_domain *smmu_domain = master->domain;
>   
>   	/* Don't enable ATS at the endpoint if it's not enabled in the STE */
>   	if (!master->ats_enabled)
> @@ -2320,6 +2339,9 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
>   	/* Smallest Translation Unit: log2 of the smallest supported granule */
>   	stu = __ffs(smmu->pgsize_bitmap);
>   	pdev = to_pci_dev(master->dev);
> +
> +	atomic_inc(&smmu_domain->nr_ats_masters);
> +	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
>   	if (pci_enable_ats(pdev, stu))
>   		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
>   }
> @@ -2327,6 +2349,7 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
>   static void arm_smmu_disable_ats(struct arm_smmu_master *master)
>   {
>   	struct arm_smmu_cmdq_ent cmd;
> +	struct arm_smmu_domain *smmu_domain = master->domain;
>   
>   	if (!master->ats_enabled)
>   		return;
> @@ -2339,6 +2362,7 @@ static void arm_smmu_disable_ats(struct arm_smmu_master *master)
>   	wmb();
>   	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
>   	arm_smmu_atc_inv_master(master, &cmd);
> +	atomic_dec(&smmu_domain->nr_ats_masters);
>   }
>   
>   static void arm_smmu_detach_dev(struct arm_smmu_master *master)
> @@ -2349,11 +2373,12 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
>   	if (!smmu_domain)
>   		return;
>   
> +	arm_smmu_disable_ats(master);
> +
>   	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
>   	list_del(&master->domain_head);
>   	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>   
> -	arm_smmu_disable_ats(master);
>   	master->domain = NULL;
>   	master->ats_enabled = false;
>   	arm_smmu_install_ste_for_dev(master);
> @@ -2396,10 +2421,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   
>   	master->domain = smmu_domain;
>   
> -	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> -	list_add(&master->domain_head, &smmu_domain->devices);
> -	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> -
>   	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
>   		master->ats_enabled = arm_smmu_ats_supported(master);
>   
> @@ -2407,7 +2428,13 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   		arm_smmu_write_ctx_desc(smmu, &smmu_domain->s1_cfg);
>   
>   	arm_smmu_install_ste_for_dev(master);
> +
> +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +	list_add(&master->domain_head, &smmu_domain->devices);
> +	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> +
>   	arm_smmu_enable_ats(master);
> +
>   out_unlock:
>   	mutex_unlock(&smmu_domain->init_mutex);
>   	return ret;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
