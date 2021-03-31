Return-Path: <SRS0=WBHG=I5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D56FC433C1
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 04:56:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D160E6187E
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 04:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D160E6187E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8964C405E9;
	Wed, 31 Mar 2021 04:56:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LaNqVt3sVbvP; Wed, 31 Mar 2021 04:56:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45D88405ED;
	Wed, 31 Mar 2021 04:56:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D68EC000B;
	Wed, 31 Mar 2021 04:56:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6268C000A
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 04:56:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD06B608A3
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 04:56:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YB-ZK7qM4o-H for <iommu@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 04:56:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0084060899
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 04:56:38 +0000 (UTC)
IronPort-SDR: GTji9C2tt0JXGYMamzdoo3qpkbw3G4iAOYkhmGLcyvJOZ4k10mxRDVVqu3nNXk1PlQ3Z7eyNdt
 NAnPh3IprH3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="192019732"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; d="scan'208";a="192019732"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2021 21:56:37 -0700
IronPort-SDR: uLcKWl+OPmimChUHu2iDn9E6spXPUzdArHCR11+AXenDQM1J0zi4SS4Z00CB2ZoGfnjh0bEYvQ
 Hwn3fIaK712A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; d="scan'208";a="438607873"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 30 Mar 2021 21:56:35 -0700
Subject: Re: [RFC PATCH 2/5] iommu: Add an unmap_pages() op for IOMMU drivers
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
References: <20210331030042.13348-1-isaacm@codeaurora.org>
 <20210331030042.13348-3-isaacm@codeaurora.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e1cadb9e-2ffa-8506-6790-2dab4733af25@linux.intel.com>
Date: Wed, 31 Mar 2021 12:47:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210331030042.13348-3-isaacm@codeaurora.org>
Content-Language: en-US
Cc: robin.murphy@arm.com, will@kernel.org, pratikp@codeaurora.org
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

On 3/31/21 11:00 AM, Isaac J. Manjarres wrote:
> Add a callback for IOMMU drivers to provide a path for the
> IOMMU framework to call into an IOMMU driver, which can call
> into the io-pgtable code, to unmap a virtually contiguous
> range of pages of the same size.
> 
> For IOMMU drivers that do not specify an unmap_pages() callback,
> the existing logic of unmapping memory one page block at a time
> will be used.
> 
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> Suggested-by: Will Deacon <will@kernel.org>
> ---
>   include/linux/iommu.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 5e7fe519430a..9cf81242581a 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -193,6 +193,7 @@ struct iommu_iotlb_gather {
>    * @detach_dev: detach device from an iommu domain
>    * @map: map a physically contiguous memory region to an iommu domain
>    * @unmap: unmap a physically contiguous memory region from an iommu domain
> + * @unmap_pages: unmap a number of pages of the same size from an iommu domain
>    * @flush_iotlb_all: Synchronously flush all hardware TLBs for this domain
>    * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
>    * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
> @@ -245,6 +246,9 @@ struct iommu_ops {
>   		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
>   	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
>   		     size_t size, struct iommu_iotlb_gather *iotlb_gather);
> +	size_t (*unmap_pages)(struct iommu_domain *domain, unsigned long iova,
> +			      size_t pgsize, size_t pgcount,
> +			      struct iommu_iotlb_gather *iotlb_gather);

Is it possible to add an equivalent map_pages() callback?

>   	void (*flush_iotlb_all)(struct iommu_domain *domain);
>   	void (*iotlb_sync_map)(struct iommu_domain *domain, unsigned long iova,
>   			       size_t size);
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
