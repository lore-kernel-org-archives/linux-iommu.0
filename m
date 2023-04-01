Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C53232
	for <iommu@lists.linux.dev>; Sat,  1 Apr 2023 13:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680355690; x=1711891690;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sSjm2R/ZERWrLvuTMJ4+1cTW3tasqNODXsINXDA4T4w=;
  b=R1G+4oOi++7Y9KYGlo6jFhIpf9jdtHjier0xXvpH1ZeHNLosa43uKkYe
   iScFTRJaGhcuXUnjcfqsijYarXkwfl7t1ExcIx0ICSUDMQmJU1iMcyORa
   7T0J1upRx2PoVdc8i2U0TVArxFi0KAkpRENIqsw3qM7AWvrlYFmoH7ekk
   Dfz7BkHTbEas3EXPHDw2A4cKFfOnc2dw4Ibp7TgS2ZMjP1e9nBY5FsE4b
   gW9SCbpC9JeH+SXSulrnvcAIjE6RKApttpxK6A2P8OgEPcV1dlx5G9K+n
   5uddjs857W3fN/wcGnBy7hH5FXUoTKVVQGsmPBXTjmv3FSVhXv6EHE+xW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="321307544"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="321307544"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 06:28:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="774661731"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="774661731"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.241]) ([10.254.211.241])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 06:28:04 -0700
Message-ID: <81fddd3e-bf6c-966a-b44b-b8a7c9c00591@linux.intel.com>
Date: Sat, 1 Apr 2023 21:28:02 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Tony Luck <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v3 3/7] iommu/sva: Support allocation of global PASIDs
 outside SVA
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org, vkoul@kernel.org
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
 <20230331231137.1947675-4-jacob.jun.pan@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230331231137.1947675-4-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/4/1 7:11, Jacob Pan wrote:
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 54f535ff9868..f70478a11a5f 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1187,6 +1187,9 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>   					struct mm_struct *mm);
>   void iommu_sva_unbind_device(struct iommu_sva *handle);
>   u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> +ioasid_t iommu_alloc_global_pasid(ioasid_t min, ioasid_t max);
> +void iommu_free_global_pasid(ioasid_t pasid);
> +
>   #else
>   static inline struct iommu_sva *
>   iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> @@ -1202,6 +1205,13 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>   {
>   	return IOMMU_PASID_INVALID;
>   }
> +
> +static inline ioasid_t iommu_alloc_global_pasid(ioasid_t min, ioasid_t max)
> +{
> +	return IOMMU_PASID_INVALID;
> +}
> +
> +static inline void iommu_free_global_pasid(ioasid_t pasid) {}
>   static inline void mm_pasid_init(struct mm_struct *mm) {}
>   static inline void mm_pasid_drop(struct mm_struct *mm) {}
>   #endif /* CONFIG_IOMMU_SVA */

I don't think the function prototypes of
iommu_[alloc|free]_global_pasid() should be impacted by
CONFIG_IOMMU_SVA. Or I may overlooked something?

Best regards,
baolu
