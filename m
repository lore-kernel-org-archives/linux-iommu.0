Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D462F44
	for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 10:18:38 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id l68so730693wml.3
        for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 03:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PthiWPy+l0Xrh64fUU18fSibNpG6O79rHwC6/GkzFBM=;
        b=uA/mQ0SkAvscLVjhkqOizC/KMkRqhuO7+Im5Bqk0HdEcTFg4pm5NguimF8LAftg2vF
         epABaTj9arugizJUgOXt0W3eqtL2zo6aRTDKpaVXcbLDS6OBMrFfSHwO4J2SkGtXtVkc
         WmxBOouIEhn1E9q9Ui1L4Iybeik7NiO4ZYuZv4Jfjkj56DNRv/AuoSX0FMJy31TuySy9
         Uj7lT27bwvPMKNgKbh8yI3EVP5vx5X78j54LFZ4strmEC1Dwyd7NZD0M+YIOJoK8jozg
         YkRY3nB9w/H2molP8H4AxXuvNY7ggh/Nz2MVZyC+RevARe8emuwLCTne/1HLzGT6QNCo
         ggHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PthiWPy+l0Xrh64fUU18fSibNpG6O79rHwC6/GkzFBM=;
        b=RIeB4jCFKQiqQk6GBHonyoGw2kAMuVh8EuHQXVw1WdqWYoCG5T1Bt9mLr6lH816nJY
         HEcSRawL0iseXHIXWccAXT2O8pX+iHUnc2z+fSnaUe2d5HGqkwcYBbQI6U75HmEfto63
         kY+NunfRjp5hk/Hd+yP23vdScvpl4YINJZdix+XTxleOK+TdRYfptiDZKhnv5z1Hcz9l
         BvNPmu4g1f0R6lkrErWCY3v8AfTyYI6u5xW6IJcjMTuV6qt4ty6eyg0SusTEADTQ+QQv
         nAuxfUJ5S6IV2kuuIUnMlAkX0CBU4x5eNXS1hnchzeaI+LKJ31+Iysosy+2WgBo5lVqS
         nXRA==
X-Gm-Message-State: AJIora8Op+Eq2MIbVoKvFrQfU8JqMQW6gim0vpkMokEciM941v87Mjfz
	kuAvoT5pe8Ih+a35I1/7pHjRGg==
X-Google-Smtp-Source: AGRyM1trRmqFUKhd4ulqmTcqHwF+Ckzn+5rAqAAQU5pBIPyHymVXJzYzTOrQP/jDdU2CtQYMJhl0jw==
X-Received: by 2002:a7b:c354:0:b0:39c:6753:21f8 with SMTP id l20-20020a7bc354000000b0039c675321f8mr8408424wmj.113.1657793916777;
        Thu, 14 Jul 2022 03:18:36 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b0039c5ab7167dsm4880824wmq.48.2022.07.14.03.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 03:18:36 -0700 (PDT)
Date: Thu, 14 Jul 2022 11:18:11 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Tina Zhang <tina.zhang@intel.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	kevin.tian@intel.com, baolu.lu@linux.intel.com,
	eric.auger@redhat.com
Subject: Re: [PATCH] iommu/virtio: Add map/unmap_pages() callbacks
 implementation
Message-ID: <Ys/tY7+S948LjILZ@myrica>
References: <20220713001838.17298-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713001838.17298-1-tina.zhang@intel.com>

Hi Tina,

Thanks for the patch, looks good with a small comment below

I sent the fix for the QEMU issue this brought up
https://lore.kernel.org/qemu-devel/20220714095418.261387-1-jean-philippe@linaro.org/

On Tue, Jul 12, 2022 at 08:18:38PM -0400, Tina Zhang wrote:
> Map/unmap_pags() allows map and unmap multiple pages of the same size
> in one call, which can improve performance by reducing the numbers of
> vmexits. With map/unmap_pages() implemented, the prior map/unmap()
> callbacks are deprecated.
> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  drivers/iommu/virtio-iommu.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 25be4b822aa0..d1626e3de7f8 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -788,11 +788,13 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	return 0;
>  }
>  
> -static int viommu_map(struct iommu_domain *domain, unsigned long iova,
> -		      phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> +static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
> +			    phys_addr_t paddr, size_t pgsize, size_t pgcount,
> +			    int prot, gfp_t gfp, size_t *mapped)
>  {
>  	int ret;
>  	u32 flags;
> +	size_t size = pgsize * pgcount;
>  	u64 end = iova + size - 1;
>  	struct virtio_iommu_req_map map;
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> @@ -823,17 +825,21 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
>  	ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
>  	if (ret)
>  		viommu_del_mappings(vdomain, iova, end);
> +	else if (!ret && mapped)

else if (mapped)

Thanks,
Jean

> +		*mapped = size;
>  
>  	return ret;
>  }
>  
> -static size_t viommu_unmap(struct iommu_domain *domain, unsigned long iova,
> -			   size_t size, struct iommu_iotlb_gather *gather)
> +static size_t viommu_unmap_pages(struct iommu_domain *domain, unsigned long iova,
> +				 size_t pgsize, size_t pgcount,
> +				 struct iommu_iotlb_gather *gather)
>  {
>  	int ret = 0;
>  	size_t unmapped;
>  	struct virtio_iommu_req_unmap unmap;
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +	size_t size = pgsize * pgcount;
>  
>  	unmapped = viommu_del_mappings(vdomain, iova, iova + size - 1);
>  	if (unmapped < size)
> @@ -1018,8 +1024,8 @@ static struct iommu_ops viommu_ops = {
>  	.owner			= THIS_MODULE,
>  	.default_domain_ops = &(const struct iommu_domain_ops) {
>  		.attach_dev		= viommu_attach_dev,
> -		.map			= viommu_map,
> -		.unmap			= viommu_unmap,
> +		.map_pages		= viommu_map_pages,
> +		.unmap_pages		= viommu_unmap_pages,
>  		.iova_to_phys		= viommu_iova_to_phys,
>  		.iotlb_sync		= viommu_iotlb_sync,
>  		.free			= viommu_domain_free,
> -- 
> 2.34.1
> 
