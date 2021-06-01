Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E01DC4708F
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 15:59:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 894AF613AE
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 15:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894AF613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5935260805;
	Tue,  1 Jun 2021 15:59:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WO0a9gEBVFY2; Tue,  1 Jun 2021 15:59:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7ED86600C9;
	Tue,  1 Jun 2021 15:59:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 640E1C000E;
	Tue,  1 Jun 2021 15:59:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1807C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 15:59:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 97D8140435
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 15:59:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I6v7bSQxD3sq for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 15:59:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3F20E40410
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 15:59:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53C1C101E;
 Tue,  1 Jun 2021 08:59:35 -0700 (PDT)
Received: from [10.57.73.64] (unknown [10.57.73.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 356943F719;
 Tue,  1 Jun 2021 08:59:34 -0700 (PDT)
Subject: Re: [PATCH 3/4] iommu/amd: Do not sync on page size changes
To: Nadav Amit <nadav.amit@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <20210502070001.1559127-1-namit@vmware.com>
 <20210502070001.1559127-5-namit@vmware.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f00bd0ce-e4a7-93c6-39ae-db19779b9331@arm.com>
Date: Tue, 1 Jun 2021 16:59:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210502070001.1559127-5-namit@vmware.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, Nadav Amit <namit@vmware.com>,
 Jiajun Cao <caojiajun@vmware.com>, linux-kernel@vger.kernel.org
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

On 2021-05-02 07:59, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Some IOMMU architectures perform invalidations regardless of the page
> size. In such architectures there is no need to sync when the page size
> changes or to regard pgsize when making interim flush in
> iommu_iotlb_gather_add_page().
> 
> Add a "ignore_gather_pgsize" property for each IOMMU-ops to decide
> whether gather's pgsize is tracked and triggers a flush.

I've objected before[1], and I'll readily object again ;)

I still think it's very silly to add a bunch of indirection all over the 
place to make a helper function not do the main thing it's intended to 
help with. If you only need trivial address gathering then it's far 
simpler to just implement trivial address gathering. I suppose if you 
really want to you could factor out another helper to share the 5 lines 
of code which ended up in mtk-iommu (see commit f21ae3b10084).

Robin.

[1] 
https://lore.kernel.org/linux-iommu/49bae447-d662-e6cf-7500-ab78e3b75dc4@arm.com/

> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jiajun Cao <caojiajun@vmware.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>   drivers/iommu/amd/iommu.c | 1 +
>   include/linux/iommu.h     | 3 ++-
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index b8cabbbeed71..1849b53f2149 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2215,6 +2215,7 @@ const struct iommu_ops amd_iommu_ops = {
>   	.put_resv_regions = generic_iommu_put_resv_regions,
>   	.is_attach_deferred = amd_iommu_is_attach_deferred,
>   	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
> +	.ignore_gather_pgsize = true,
>   	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
>   	.iotlb_sync = amd_iommu_iotlb_sync,
>   	.def_domain_type = amd_iommu_def_domain_type,
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 32d448050bf7..1fb2695418e9 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -284,6 +284,7 @@ struct iommu_ops {
>   	int (*def_domain_type)(struct device *dev);
>   
>   	unsigned long pgsize_bitmap;
> +	bool ignore_gather_pgsize;
>   	struct module *owner;
>   };
>   
> @@ -508,7 +509,7 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
>   	 * a different granularity, then sync the TLB so that the gather
>   	 * structure can be rewritten.
>   	 */
> -	if (gather->pgsize != size ||
> +	if ((gather->pgsize != size && !domain->ops->ignore_gather_pgsize) ||
>   	    end + 1 < gather->start || start > gather->end + 1) {
>   		if (gather->pgsize)
>   			iommu_iotlb_sync(domain, gather);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
