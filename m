Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B00DC433E6
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 11:25:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A67CF20786
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 11:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67CF20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1CFDB86566;
	Wed, 27 Jan 2021 11:25:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m0IMmc9cluzm; Wed, 27 Jan 2021 11:25:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D2ACF862F4;
	Wed, 27 Jan 2021 11:25:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B878BC08A1;
	Wed, 27 Jan 2021 11:25:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D185C013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 11:25:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0A37F86439
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 11:25:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JFE1xjF+EmPZ for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 11:25:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1C235862F4
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 11:25:42 +0000 (UTC)
IronPort-SDR: Rz2hf6QCh7M9HP17j3IVTNMx28wjVfu8JUECmUrnk8wDD+iXAXLAFCzpsgmAK2NCa3KIG9F3FR
 Sw6IYZ9BubSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="167728097"
X-IronPort-AV: E=Sophos;i="5.79,379,1602572400"; d="scan'208";a="167728097"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2021 03:25:41 -0800
IronPort-SDR: hvjRdxd5h34oq8sWBSRRbZVDmfRlupl/AXYAo0HarVvgNWk5+D2LexuQBJxuY5h0D5mpElmMdm
 a1P93lIRoGfA==
X-IronPort-AV: E=Sophos;i="5.79,379,1602572400"; d="scan'208";a="388270712"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.31.249])
 ([10.255.31.249])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2021 03:25:39 -0800
To: Nadav Amit <nadav.amit@gmail.com>, iommu@lists.linux-foundation.org
References: <20210127061729.1596640-1-namit@vmware.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2] iommu/vt-d: do not use flush-queue when caching-mode
 is on
Message-ID: <15c974b1-b50d-9061-9d97-fef6f3804b22@linux.intel.com>
Date: Wed, 27 Jan 2021 19:25:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210127061729.1596640-1-namit@vmware.com>
Content-Language: en-US
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Nadav Amit <namit@vmware.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On 2021/1/27 14:17, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> When an Intel IOMMU is virtualized, and a physical device is
> passed-through to the VM, changes of the virtual IOMMU need to be
> propagated to the physical IOMMU. The hypervisor therefore needs to
> monitor PTE mappings in the IOMMU page-tables. Intel specifications
> provide "caching-mode" capability that a virtual IOMMU uses to report
> that the IOMMU is virtualized and a TLB flush is needed after mapping to
> allow the hypervisor to propagate virtual IOMMU mappings to the physical
> IOMMU. To the best of my knowledge no real physical IOMMU reports
> "caching-mode" as turned on.
> 
> Synchronizing the virtual and the physical IOMMU tables is expensive if
> the hypervisor is unaware which PTEs have changed, as the hypervisor is
> required to walk all the virtualized tables and look for changes.
> Consequently, domain flushes are much more expensive than page-specific
> flushes on virtualized IOMMUs with passthrough devices. The kernel
> therefore exploited the "caching-mode" indication to avoid domain
> flushing and use page-specific flushing in virtualized environments. See
> commit 78d5f0f500e6 ("intel-iommu: Avoid global flushes with caching
> mode.")
> 
> This behavior changed after commit 13cf01744608 ("iommu/vt-d: Make use
> of iova deferred flushing"). Now, when batched TLB flushing is used (the
> default), full TLB domain flushes are performed frequently, requiring
> the hypervisor to perform expensive synchronization between the virtual
> TLB and the physical one.
> 
> Getting batched TLB flushes to use in such circumstances page-specific
> invalidations again is not easy, since the TLB invalidation scheme
> assumes that "full" domain TLB flushes are performed for scalability.
> 
> Disable batched TLB flushes when caching-mode is on, as the performance
> benefit from using batched TLB invalidations is likely to be much
> smaller than the overhead of the virtual-to-physical IOMMU page-tables
> synchronization.
> 
> Fixes: 78d5f0f500e6 ("intel-iommu: Avoid global flushes with caching mode.")

Isn't it

Fixes: 13cf01744608 ("iommu/vt-d: Make use of iova deferred flushing")

?

Best regards,
baolu

> Signed-off-by: Nadav Amit <namit@vmware.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: stable@vger.kernel.org >
> ---
> v1->v2:
> 
> * disable flush queue for all domains if caching-mode is on for any
>    IOMMU (Lu).
> ---
>   drivers/iommu/intel/iommu.c | 32 +++++++++++++++++++++++++++++++-
>   1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 788119c5b021..de3dd617cf60 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5373,6 +5373,36 @@ intel_iommu_domain_set_attr(struct iommu_domain *domain,
>   	return ret;
>   }
>   
> +static bool domain_use_flush_queue(void)
> +{
> +	struct dmar_drhd_unit *drhd;
> +	struct intel_iommu *iommu;
> +	bool r = true;
> +
> +	if (intel_iommu_strict)
> +		return false;
> +
> +	/*
> +	 * The flush queue implementation does not perform page-selective
> +	 * invalidations that are required for efficient TLB flushes in virtual
> +	 * environments. The benefit of batching is likely to be much lower than
> +	 * the overhead of synchronizing the virtual and physical IOMMU
> +	 * page-tables.
> +	 */
> +	rcu_read_lock();
> +	for_each_active_iommu(iommu, drhd) {
> +		if (!cap_caching_mode(iommu->cap))
> +			continue;
> +
> +		pr_warn_once("IOMMU batching is disabled due to virtualization");
> +		r = false;
> +		break;
> +	}
> +	rcu_read_unlock();
> +
> +	return r;
> +}
> +
>   static int
>   intel_iommu_domain_get_attr(struct iommu_domain *domain,
>   			    enum iommu_attr attr, void *data)
> @@ -5383,7 +5413,7 @@ intel_iommu_domain_get_attr(struct iommu_domain *domain,
>   	case IOMMU_DOMAIN_DMA:
>   		switch (attr) {
>   		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
> -			*(int *)data = !intel_iommu_strict;
> +			*(int *)data = domain_use_flush_queue();
>   			return 0;
>   		default:
>   			return -ENODEV;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
