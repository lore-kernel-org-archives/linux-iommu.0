Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0058EEA2;
	Sat, 12 Aug 2023 01:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691804526; x=1723340526;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5GY/e8XTSIPzCfiJLnCpeo3J53rYLGWoWboZiWN0iEY=;
  b=CE/zCoHL9V6lhsza/mBWJ24YPScDAmUtlvz4yXXMwRCSJQGmhkbQkDRN
   UMwu1MjYN+dTjgjORv240i2Wz74zL2VVbSGzlxYlKLtmRTzT1w7a93oGK
   7xLnwHGGVipA3ttZiw8s6AVUhOFHdXT6sgTQtA2+xjQDREKavytbKNqjB
   jmUxrqk7IpGGLpAQXRqNxx6wRkvnfcVuSEmXAJsuE4gYpIskGbjddA/N5
   KS4iVj3mHQBJWyIFn+pEGEh7otkAIR16DoHqCBF5uXuzNkTWDc72mwetM
   RUKfHk/MZbLuMYiqkpbiNQmhOhGle5dTb321TWfkUin+1zCEhv1U64MsG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="402773651"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="402773651"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 18:42:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="682718124"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="682718124"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.79]) ([10.254.215.79])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 18:41:52 -0700
Message-ID: <b772c318-80b0-944a-dfe9-beb70127dc88@linux.intel.com>
Date: Sat, 12 Aug 2023 09:41:50 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc: baolu.lu@linux.intel.com, Dmitry Osipenko <digetx@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Steven Price <steven.price@arm.com>,
 Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v6 02/25] iommu: Add IOMMU_DOMAIN_PLATFORM
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Andy Gross <agross@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Bjorn Andersson
 <andersson@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Kevin Tian <kevin.tian@intel.com>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linuxppc-dev@lists.ozlabs.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Orson Zhai <orsonzhai@gmail.com>, Rob Clark <robdclark@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Samuel Holland <samuel@sholland.org>,
 Thierry Reding <thierry.reding@gmail.com>, Krishna Reddy
 <vdumpa@nvidia.com>, Chen-Yu Tsai <wens@csie.org>,
 Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
References: <2-v6-e8114faedade+425-iommu_all_defdom_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <2-v6-e8114faedade+425-iommu_all_defdom_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/3 8:07, Jason Gunthorpe wrote:
> @@ -1967,7 +1978,8 @@ void iommu_domain_free(struct iommu_domain *domain)
>   	if (domain->type == IOMMU_DOMAIN_SVA)
>   		mmdrop(domain->mm);
>   	iommu_put_dma_cookie(domain);
> -	domain->ops->free(domain);
> +	if (domain->ops->free)
> +		domain->ops->free(domain);
>   }
>   EXPORT_SYMBOL_GPL(iommu_domain_free);
>   
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index e05c93b6c37fba..87aebba474e093 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -64,6 +64,7 @@ struct iommu_domain_geometry {
>   #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
>   
>   #define __IOMMU_DOMAIN_SVA	(1U << 4)  /* Shared process address space */
> +#define __IOMMU_DOMAIN_PLATFORM	(1U << 5)
>   
>   #define IOMMU_DOMAIN_ALLOC_FLAGS ~__IOMMU_DOMAIN_DMA_FQ
>   /*
> @@ -81,6 +82,8 @@ struct iommu_domain_geometry {
>    *				  invalidation.
>    *	IOMMU_DOMAIN_SVA	- DMA addresses are shared process addresses
>    *				  represented by mm_struct's.
> + *	IOMMU_DOMAIN_PLATFORM	- Legacy domain for drivers that do their own
> + *				  dma_api stuff. Do not use in new drivers.
>    */
>   #define IOMMU_DOMAIN_BLOCKED	(0U)
>   #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
> @@ -91,6 +94,7 @@ struct iommu_domain_geometry {
>   				 __IOMMU_DOMAIN_DMA_API |	\
>   				 __IOMMU_DOMAIN_DMA_FQ)
>   #define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
> +#define IOMMU_DOMAIN_PLATFORM	(__IOMMU_DOMAIN_PLATFORM)

Nit: As a default domain could be the type of IOMMU_DOMAIN_PLATFORM,

static const char *iommu_domain_type_str(unsigned int t)

needs to be updated, so that users can get a right string when reading 
/sys/.../[group_id]/type.

Best regards,
baolu
