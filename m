Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82060C433F5
	for <iommu@archiver.kernel.org>; Thu, 19 May 2022 06:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 317AE8433D;
	Thu, 19 May 2022 06:50:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A89cIw-WBnPF; Thu, 19 May 2022 06:50:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 36FAF8433C;
	Thu, 19 May 2022 06:50:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD669C0039;
	Thu, 19 May 2022 06:50:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B9A3C002D
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 06:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9920B8433D
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 06:50:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w46n8ZgL-dAW for <iommu@lists.linux-foundation.org>;
 Thu, 19 May 2022 06:50:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 18E058433C
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 06:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652943050; x=1684479050;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=rjhxdtU/rJ1XS+TF9ytej5Qm9UaG/+F24zp9IID0CGw=;
 b=RGTHfzyaMUZdQ+dXhcpq/0s9jpE8iqrmu/wIEpI12WAMVjh3VsS3RgKX
 PxQBSU2TOt/AccbiZ4fhnxJfdmSisDMN0xW/cDgqKZBXF1W+x/sBbnoeI
 x2VPcRnlaOqWFH+RcGTlI+FV77ySaahcqGiCmVVf3E9QocH9QzYtL49gE
 JYxSJkSVEDdnreGzM61A5oZZcM/GYgi0GvZxDGNadkoSNACgq1SQ+RnlH
 QoLEZenUM+nntx0pGrOUZx7eBjOHXHtzT2xnCauk4uhyKC5vR9GfmR5tF
 0exejEzvV2Ei7anzC/f9byirBGBKPnxEwM/5VD92uKwf8CyUvyQx7bLZ6 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="251949876"
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; d="scan'208";a="251949876"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2022 23:50:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; d="scan'208";a="742755243"
Received: from zhongz9x-mobl.ccr.corp.intel.com (HELO [10.255.28.182])
 ([10.255.28.182])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2022 23:50:44 -0700
Message-ID: <6e5079d1-1bdb-1b36-3884-0112f2557271@linux.intel.com>
Date: Thu, 19 May 2022 14:50:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/6] iommu: Add a per domain PASID for DMA API
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 dmaengine@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 vkoul@kernel.org, robin.murphy@arm.com, will@kernel.org
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>
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

On 2022/5/19 02:21, Jacob Pan wrote:
> DMA requests tagged with PASID can target individual IOMMU domains.
> Introduce a domain-wide PASID for DMA API, it will be used on the same
> mapping as legacy DMA without PASID. Let it be IOVA or PA in case of
> identity domain.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   include/linux/iommu.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 9405034e3013..36ad007084cc 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -106,6 +106,8 @@ struct iommu_domain {
>   	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
>   						      void *data);
>   	void *fault_data;
> +	ioasid_t dma_pasid;		/* Used for DMA requests with PASID */

This looks more suitable for iommu_dma_cookie?

> +	atomic_t dma_pasid_users;
>   };
>   
>   static inline bool iommu_is_dma_domain(struct iommu_domain *domain)

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
