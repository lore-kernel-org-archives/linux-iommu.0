Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380AEC433F5
	for <iommu@archiver.kernel.org>; Fri, 18 Mar 2022 11:52:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C974E60E8A;
	Fri, 18 Mar 2022 11:52:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OrTgt8Qh8LVK; Fri, 18 Mar 2022 11:52:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B3DEA60768;
	Fri, 18 Mar 2022 11:52:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E008C0033;
	Fri, 18 Mar 2022 11:52:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EA35C0012
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 11:52:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 34AB940114
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 11:52:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rcQNOGlOLKHz for <iommu@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 11:52:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 60D6E400FE
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 11:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647604360; x=1679140360;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=IlizNx0D23msIMfflP/Hpjfck4g6+/Khnila9FP+qGo=;
 b=BUIs1R1zYCCrONgA3lr/U1I70+Z6USnQX+6w6B7XdILAx9mKqIkco7vQ
 fct6E034d/1QN3K24q6cnWQYKjNsjckWo2slKcgeYVU+JbWjP7JJKpg+I
 N9w/K5fSpvUlfLuiZz6dxY+yUFrRR2EY8yzrftZ8jZ2/sVc8Vx9ZP2QzU
 nPwbJnQVSLktKiFxnyNGE+HqqMx/jzffMt1gFqIjxxp2194oxXEJq/RtD
 3CsfiMQzkAArDDRKs2wImZVHy3nX/dp1gBmr+/Trc9CNEblN8p5Bfgf7s
 V1RBxytuYCpXvtx/94IurZomqVDzMlGab9S+1OIb1f64+ythL2i/5UTcz A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="317837466"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; d="scan'208";a="317837466"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2022 04:52:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; d="scan'208";a="558400164"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.248])
 ([10.254.215.248])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2022 04:52:35 -0700
Message-ID: <51f6a64a-194b-0aca-bd2b-64737bd2140e@linux.intel.com>
Date: Fri, 18 Mar 2022 19:52:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/8] iommu: Add attach/detach_dev_pasid domain ops
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-3-jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220315050713.2000518-3-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 Jacob Pan <jacob.jun.pan@intel.com>, Dan Williams <dan.j.williams@intel.com>
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

On 2022/3/15 13:07, Jacob Pan wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> An IOMMU domain represents an address space which can be attached by
> devices that perform DMA within a domain. However, for platforms with
> PASID capability the domain attachment needs be handled at device+PASID
> level. There can be multiple PASIDs within a device and multiple devices
> attached to a given domain.
> This patch introduces a new IOMMU op which support device, PASID, and
> IOMMU domain attachment. The immediate use case is for PASID capable
> devices to perform DMA under DMA APIs.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   include/linux/iommu.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 369f05c2a4e2..fde5b933dbe3 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -227,6 +227,8 @@ struct iommu_iotlb_gather {
>    * @aux_get_pasid: get the pasid given an aux-domain
>    * @sva_bind: Bind process address space to device
>    * @sva_unbind: Unbind process address space from device
> + * @attach_dev_pasid: attach an iommu domain to a pasid of device
> + * @detach_dev_pasid: detach an iommu domain from a pasid of device
>    * @sva_get_pasid: Get PASID associated to a SVA handle
>    * @page_response: handle page request response
>    * @cache_invalidate: invalidate translation caches
> @@ -296,6 +298,10 @@ struct iommu_ops {
>   	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
>   				      void *drvdata);
>   	void (*sva_unbind)(struct iommu_sva *handle);
> +	int (*attach_dev_pasid)(struct iommu_domain *domain,
> +				struct device *dev, ioasid_t id);
> +	void (*detach_dev_pasid)(struct iommu_domain *domain,
> +				 struct device *dev, ioasid_t id);

As we have introduced iommu_domain_ops, these callbacks should be part
of the domain ops.

>   	u32 (*sva_get_pasid)(struct iommu_sva *handle);
>   
>   	int (*page_response)(struct device *dev,

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
