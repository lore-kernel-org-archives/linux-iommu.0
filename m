Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E147C433F5
	for <iommu@archiver.kernel.org>; Mon, 23 May 2022 07:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4AC641710;
	Mon, 23 May 2022 07:13:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id scS1-HINyjef; Mon, 23 May 2022 07:13:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DE96C40947;
	Mon, 23 May 2022 07:13:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACC38C0032;
	Mon, 23 May 2022 07:13:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60BA6C002D
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 07:13:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 40BE283E24
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 07:13:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LLYxxRv3OYMd for <iommu@lists.linux-foundation.org>;
 Mon, 23 May 2022 07:13:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4E33083E1A
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 07:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653289983; x=1684825983;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=RkBnlh49x7+Hp8WBycVg2h1xf0cxa9S/tNTkHWNfXo8=;
 b=QLxgNyKp9rKo+Qw3bVQYsN18Pd/aCZGVwD7P+xZZqDOygOklar/ktslK
 SXeJdw/kFnyH+qngKJ9nNH4zVGm0+S61l74KwlN15Kn9ZAvDHJuntueGI
 UpILs2+RFmuibX8NDGsj+P19htMTV4grWZZwsM+JuXT51gQTkPXZ1Yora
 u6wi6EcuDuhSL0onaaXvs/a9mpVll7YlbubH5DKC52tJuJ2FT9rVcLVsu
 2/sPVhOAUldh+KhY5s45HaWRCbKPpsJv9NniLu2KSsNytLQZ4Rzjf2WuG
 nOjCoNwaKNsIVFszbuughGd+UDyjQNFcXhKpUZnV3ZjX0uRbJqKlQM8a4 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="273124334"
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; d="scan'208";a="273124334"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2022 00:13:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; d="scan'208";a="571941238"
Received: from jsun39-mobl.ccr.corp.intel.com (HELO [10.255.28.225])
 ([10.255.28.225])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2022 00:12:57 -0700
Message-ID: <316981d6-6b40-9e2a-09d3-b0d6f8687247@linux.intel.com>
Date: Mon, 23 May 2022 15:12:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220519072047.2996983-4-baolu.lu@linux.intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

On 2022/5/19 15:20, Lu Baolu wrote:
> The iommu_sva_domain represents a hardware pagetable that the IOMMU
> hardware could use for SVA translation. This adds some infrastructure
> to support SVA domain in the iommu common layer. It includes:
> 
> - Add a new struct iommu_sva_domain and new IOMMU_DOMAIN_SVA domain
>    type.
> - Add a new domain ops pointer in iommu_ops. The IOMMU drivers that
>    support SVA should provide the callbacks.
> - Add helpers to allocate and free an SVA domain.
> - Add helpers to set an SVA domain to a device and the reverse
>    operation.
> 
> Some buses, like PCI, route packets without considering the PASID value.
> Thus a DMA target address with PASID might be treated as P2P if the
> address falls into the MMIO BAR of other devices in the group. To make
> things simple, the attach/detach interfaces only apply to devices
> belonging to the singleton groups, and the singleton is immutable in
> fabric i.e. not affected by hotplug.
> 
> The iommu_set/block_device_pasid() can be used for other purposes,
> such as kernel DMA with pasid, mediation device, etc. Hence, it is put
> in the iommu.c.
> 
> Suggested-by: Jean-Philippe Brucker<jean-philippe@linaro.org>
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   include/linux/iommu.h         | 51 +++++++++++++++++++++++++
>   drivers/iommu/iommu-sva-lib.h | 15 ++++++++
>   drivers/iommu/iommu-sva-lib.c | 48 +++++++++++++++++++++++
>   drivers/iommu/iommu.c         | 71 +++++++++++++++++++++++++++++++++++
>   4 files changed, 185 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 0c358b7c583b..e8cf82d46ce1 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -64,6 +64,9 @@ struct iommu_domain_geometry {
>   #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
>   #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
>   
> +#define __IOMMU_DOMAIN_SHARED	(1U << 4)  /* Page table shared from CPU  */
> +#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual address */
> +
>   /*
>    * This are the possible domain-types
>    *
> @@ -86,6 +89,8 @@ struct iommu_domain_geometry {
>   #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
>   				 __IOMMU_DOMAIN_DMA_API |	\
>   				 __IOMMU_DOMAIN_DMA_FQ)
> +#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SHARED |	\
> +				 __IOMMU_DOMAIN_HOST_VA)
>   
>   struct iommu_domain {
>   	unsigned type;
> @@ -254,6 +259,7 @@ struct iommu_ops {
>   	int (*def_domain_type)(struct device *dev);
>   
>   	const struct iommu_domain_ops *default_domain_ops;
> +	const struct iommu_domain_ops *sva_domain_ops;

Per Joerg's comment in anther thread,

https://lore.kernel.org/linux-iommu/YodVJ7ervpIdWfg+@8bytes.org/

adding a sva_domain_ops here is not the right way to go.

If no objection, I will make the sva domain go through the
generic domain_alloc/free() callbacks in the next version.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
