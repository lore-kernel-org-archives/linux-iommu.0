Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9809C48BE5
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 11:25:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D4136145C
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 11:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4136145C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FDA06063D;
	Tue, 15 Jun 2021 11:25:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cfi1BIIg2_ZL; Tue, 15 Jun 2021 11:25:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D820E605EC;
	Tue, 15 Jun 2021 11:25:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9173EC000E;
	Tue, 15 Jun 2021 11:25:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 811A7C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 11:25:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6F63C401D7
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 11:25:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tn_B3NU0w1ki for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 11:25:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E44440025
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 11:25:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B511F31B;
 Tue, 15 Jun 2021 04:25:17 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B1E93F719;
 Tue, 15 Jun 2021 04:25:16 -0700 (PDT)
Subject: Re: [PATCH v3 6/6] iommu/amd: Sync once for scatter-gather operations
To: Nadav Amit <nadav.amit@gmail.com>, Joerg Roedel <joro@8bytes.org>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-7-namit@vmware.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <99671205-134d-7563-63e2-b65c13d5d074@arm.com>
Date: Tue, 15 Jun 2021 12:25:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210607182541.119756-7-namit@vmware.com>
Content-Language: en-GB
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 Nadav Amit <namit@vmware.com>, linux-kernel@vger.kernel.org,
 Jiajun Cao <caojiajun@vmware.com>
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

On 2021-06-07 19:25, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> On virtual machines, software must flush the IOTLB after each page table
> entry update.
> 
> The iommu_map_sg() code iterates through the given scatter-gather list
> and invokes iommu_map() for each element in the scatter-gather list,
> which calls into the vendor IOMMU driver through iommu_ops callback. As
> the result, a single sg mapping may lead to multiple IOTLB flushes.
> 
> Fix this by adding amd_iotlb_sync_map() callback and flushing at this
> point after all sg mappings we set.
> 
> This commit is followed and inspired by commit 933fcd01e97e2
> ("iommu/vt-d: Add iotlb_sync_map callback").
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jiajun Cao <caojiajun@vmware.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>   drivers/iommu/amd/iommu.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 128f2e889ced..dd23566f1db8 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2027,6 +2027,16 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
>   	return ret;
>   }
>   
> +static void amd_iommu_iotlb_sync_map(struct iommu_domain *dom,
> +				     unsigned long iova, size_t size)
> +{
> +	struct protection_domain *domain = to_pdomain(dom);
> +	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
> +
> +	if (ops->map)

Not too critical since you're only moving existing code around, but is 
ops->map ever not set? Either way the check ends up looking rather 
out-of-place here :/

It's not very clear what the original intent was - I do wonder whether 
it's supposed to be related to PAGE_MODE_NONE, but given that 
amd_iommu_map() has an explicit check and errors out early in that case, 
we'd never get here anyway. Possibly something to come back and clean up 
later?

Robin.

> +		domain_flush_np_cache(domain, iova, size);
> +}
> +
>   static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
>   			 phys_addr_t paddr, size_t page_size, int iommu_prot,
>   			 gfp_t gfp)
> @@ -2045,10 +2055,8 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
>   	if (iommu_prot & IOMMU_WRITE)
>   		prot |= IOMMU_PROT_IW;
>   
> -	if (ops->map) {
> +	if (ops->map)
>   		ret = ops->map(ops, iova, paddr, page_size, prot, gfp);
> -		domain_flush_np_cache(domain, iova, page_size);
> -	}
>   
>   	return ret;
>   }
> @@ -2249,6 +2257,7 @@ const struct iommu_ops amd_iommu_ops = {
>   	.attach_dev = amd_iommu_attach_device,
>   	.detach_dev = amd_iommu_detach_device,
>   	.map = amd_iommu_map,
> +	.iotlb_sync_map	= amd_iommu_iotlb_sync_map,
>   	.unmap = amd_iommu_unmap,
>   	.iova_to_phys = amd_iommu_iova_to_phys,
>   	.probe_device = amd_iommu_probe_device,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
