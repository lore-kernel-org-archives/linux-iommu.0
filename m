Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A0620E0
	for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 07:45:39 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id f24-20020a1cc918000000b003a30178c022so2349650wmb.3
        for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 00:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QLJiktrEilDB1/hIf5fHDfJOlTTyhe24aoMbiCDEM4w=;
        b=clDj6D38E9mz3PMpdS18AD1Q31aQ+R5zcaM/7d0Ad6F2R755XdKuDzQYeUJru7gRPy
         mDoOuJ1TtKMQ9qmLOzQM0rZ+hr3on9A8PZhy+Ajn57tDhF4PvtsUKTOpDB2QJQ2VAKv0
         WRzehLDhaeZ37BN/fv6e3RmL2QLddu0yW34BFb15KJzWA5+PzeppO5WN4TtjOdMZPX1G
         kYK4UWOI1zMWbwWEzIn8uN+SjCul0nd0/+RcPcmlI3J8BxFmtXTx0vkxzxwynZVc3hcS
         uaOVRqypMae5mu338q3Xhb3NAyrwVZFOCrxzbgwmhDIinufyPzVQCWkfjpwydwUxjuMp
         te4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QLJiktrEilDB1/hIf5fHDfJOlTTyhe24aoMbiCDEM4w=;
        b=rStGNfC/CNe/dJs5QTVMKjt1wS/TMbUAmlXZdPk1zGLwOLVyN/2MdyC3hoVXChKtc/
         vDA5Ylwzhi7mlIMZVPR/uRG9FBwBIjrbtt4dsbK1yVJlzdabjQdHeW/3uS4XNWDaa422
         YucEtsdpcsFzmjrdEF0TdcaM/+53MQu/Ctd1NSEBNwtbEnEiHJ6szBltCiECRAAmG+ik
         f3K8TSH4cHH8iLRlTKlRijf/TuQK/4BBWxpBxtjyQUyRqeXdng50G4HTqCB9GFnSfb5y
         vAY4wTzEezcAdXGkBwOYCGBD3SNkxvZLSQApGxGXg7Wg/bPx7bjRK0k288UYDqsgym3H
         6sqw==
X-Gm-Message-State: AJIora+2fr8F1HRb3MZFBepzisfN+jud+8SUkYktZdw7/u1/uXGBZ6Wi
	VJfOHb0EicGTm0PGX1DiEmA6cA==
X-Google-Smtp-Source: AGRyM1uWwK7afVlSQIxxkl1hM2T1yXBJykFy+iSa7zOdcRdez8qjG7j9VD1M7Bcq+BdQWNIHN8RrWQ==
X-Received: by 2002:a05:600c:5110:b0:3a3:125:b3a6 with SMTP id o16-20020a05600c511000b003a30125b3a6mr7276745wms.155.1657871138162;
        Fri, 15 Jul 2022 00:45:38 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id t64-20020a1c4643000000b003a30c3d0c9csm1388722wma.8.2022.07.15.00.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 00:45:37 -0700 (PDT)
Date: Fri, 15 Jul 2022 08:45:13 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Tina Zhang <tina.zhang@intel.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	kevin.tian@intel.com, baolu.lu@linux.intel.com
Subject: Re: [PATCH v2] iommu/virtio: Add map/unmap_pages() callbacks
 implementation
Message-ID: <YtEbCYzOQ8TN9idm@myrica>
References: <20220605161152.3171-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605161152.3171-1-tina.zhang@intel.com>

On Mon, Jun 06, 2022 at 12:11:52AM +0800, Tina Zhang wrote:
> Map/unmap_pags() allows map and unmap multiple pages of the same size
> in one call, which can improve performance by reducing the numbers of
> vmexits. With map/unmap_pages() implemented, the prior map/unmap()
> callbacks are deprecated.
> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/virtio-iommu.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 25be4b822aa0..3c943dbd9fd0 100644
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
> +	else if (mapped)
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
