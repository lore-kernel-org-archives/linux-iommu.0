Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDC8C14C
	for <iommu@lists.linux.dev>; Mon,  4 Sep 2023 15:26:29 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-31f4950333cso754413f8f.3
        for <iommu@lists.linux.dev>; Mon, 04 Sep 2023 08:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693841187; x=1694445987; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fDf3q7+EQu7w2zbw3JsPePbQVuqHBAlzwY6aMD3wySI=;
        b=pDzt7uQIBs7EkH6xFL4uR0+nLrihodiR1sCz9u0g93r9CVDts+kOvBJjtB29qRrZev
         50ulY0VHqDmj/fKxzY79YC7MUumEnEo10DxFu17XB88hShBoDWeHRdCSYjF4/h5A+VB5
         Nb71rGf741VDi4L4grLkKFnH150B0myPKBTqsFA+SfjOG8EloOgaiGbpltYG5hu+idTf
         K6+E9ewhqYCpTG4JoquE/mTCvnF/r1PLkkvYqMivL4T6TdfJ1E1d96Mp7UVMeH0dVDS5
         1WpBlJZ+LA9EEwXmzolfCNBaEgs2rWdd1TUGK4c1qeJnGX376Rc9cdcbgqJ1zPgxEi6w
         6urQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693841187; x=1694445987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDf3q7+EQu7w2zbw3JsPePbQVuqHBAlzwY6aMD3wySI=;
        b=aKgu3RqBw9xDjXDTPyzu6cFeiPjMmZhDeZODwW3eSajsDxiBNi6r0zS6T09tbrTKaU
         aNFjXKmddtsEVcdN5tF/joyTIbiIRO8lgM2VDmaL7X8wlTnJ2sPhMOXIDsALmKIEA42b
         ChbW5i59MUEUtZX+aFkZmMdnjbocE6g44EynNE+H3qiwSZWfsjkB1GC4yVAzMSPDVi58
         GBazttBz/JfLvXFIHkPdrL5uLPvBuUZqzrcNVrVLOoi07xK4fJGXaqdBFURK+hCIe6zd
         8ynZfrktdSNxG+PpzdU+HBIzCuXNLsztALlUFrFIoIoeAoc6AsVU439wyHXxKA21+bIK
         VNMQ==
X-Gm-Message-State: AOJu0YxpQKqZFEKc54V8OLAp06vOBNre2qQvmxfbGAF3UZ9uTUhs9Psx
	GsXbd7VnT+DkUw0YfngaHTLkptWynESVgY+k6MU=
X-Google-Smtp-Source: AGHT+IHWxHR1EFAYshcTB7RB95vh4F3SsbWMVSXXFSxXBH5grbtimj3wW7/bF5tK15QkRFCPr/KWYg==
X-Received: by 2002:a5d:66ce:0:b0:317:d048:8d87 with SMTP id k14-20020a5d66ce000000b00317d0488d87mr6659141wrw.61.1693841187508;
        Mon, 04 Sep 2023 08:26:27 -0700 (PDT)
Received: from myrica ([2.220.83.24])
        by smtp.gmail.com with ESMTPSA id z23-20020a1c4c17000000b00401d8181f8bsm17377650wmf.25.2023.09.04.08.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 08:26:27 -0700 (PDT)
Date: Mon, 4 Sep 2023 16:26:32 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230904152632.GA815284@myrica>
References: <20230825-viommu-sync-map-v1-0-56bdcfaa29ec@linux.ibm.com>
 <20230825-viommu-sync-map-v1-1-56bdcfaa29ec@linux.ibm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825-viommu-sync-map-v1-1-56bdcfaa29ec@linux.ibm.com>

Hi Niklas,

Thanks for following up with these patches

On Fri, Aug 25, 2023 at 05:21:25PM +0200, Niklas Schnelle wrote:
> Pull out the sync operation from viommu_map_pages() by implementing
> ops->iotlb_sync_map. This allows the common IOMMU code to map multiple
> elements of an sg with a single sync (see iommu_map_sg()). Furthermore,
> it is also a requirement for IOMMU_CAP_DEFERRED_FLUSH.
> 
> Link: https://lore.kernel.org/lkml/20230726111433.1105665-1-schnelle@linux.ibm.com/
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/iommu/virtio-iommu.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 3551ed057774..fb73dec5b953 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -843,7 +843,7 @@ static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
>  			.flags		= cpu_to_le32(flags),
>  		};
>  
> -		ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
> +		ret = viommu_add_req(vdomain->viommu, &map, sizeof(map));
>  		if (ret) {
>  			viommu_del_mappings(vdomain, iova, end);
>  			return ret;
> @@ -909,9 +909,21 @@ static void viommu_iotlb_sync(struct iommu_domain *domain,
>  {
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
>  
> +	if (!vdomain->nr_endpoints)
> +		return;

I was wondering about these nr_endpoints checks, which seemed unnecessary:
if map()/unmap() were called with no attached endpoints, then no requests
were added to the queue, and viommu_sync_req() below is a nop.

But at least viommu_iotlb_sync_map() and viommu_flush_iotlb_all() need to
handle being called before the domain is finalized (for example by
iommu_create_device_direct_mappings()). In that case vdomain->viommu is
NULL so if you add a NULL check in viommu_sync_req() then you should be
able to drop the nr_endpoints checks in both patches.

Thanks,
Jean

>  	viommu_sync_req(vdomain->viommu);
>  }
>  
> +static int viommu_iotlb_sync_map(struct iommu_domain *domain,
> +				 unsigned long iova, size_t size)
> +{
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	if (!vdomain->nr_endpoints)
> +		return 0;
> +	return viommu_sync_req(vdomain->viommu);
> +}
> +
>  static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
>  {
>  	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
> @@ -1058,6 +1070,7 @@ static struct iommu_ops viommu_ops = {
>  		.unmap_pages		= viommu_unmap_pages,
>  		.iova_to_phys		= viommu_iova_to_phys,
>  		.iotlb_sync		= viommu_iotlb_sync,
> +		.iotlb_sync_map		= viommu_iotlb_sync_map,
>  		.free			= viommu_domain_free,
>  	}
>  };
> 
> -- 
> 2.39.2
> 
