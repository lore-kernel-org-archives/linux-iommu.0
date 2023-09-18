Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A912D63CC
	for <iommu@lists.linux.dev>; Mon, 18 Sep 2023 15:58:05 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-402d0eda361so51138085e9.0
        for <iommu@lists.linux.dev>; Mon, 18 Sep 2023 08:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695052684; x=1695657484; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BuWLNVcWzC6ASPZz9GEuSYcaG6pqUJBDXR7IC05cfLo=;
        b=GguGeBII4mnLRFRAG+HUuUry0B5UDvLx4VbrfvoqAnyYoCmZyZnK4s5ZnwhWgo6Qa7
         amcmSlR3XHaVtUG7zXCPl8jGP/D+iFY34EALm9A5YSfgFW81NpK8IDu26rWN/OYq6cjt
         f8kFFFt25OBIicPi2+rSm26esqok6v+vbTxD6xmQOEBgfJK4+j7d/Ba2X2JNsC6uvZfA
         MPFY9/Y4JJeBDDN5F8jMyAa2PFkfIM675xxmG+5+hj0+yY7awdBknP+2N20yXDZvATYL
         XlGfChIhg9KlUVptzJePPdt14+i17tWp4+jWboJ+a4cwyZ81VFNM6O1+UHzzuo+BEdEK
         ghKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695052684; x=1695657484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuWLNVcWzC6ASPZz9GEuSYcaG6pqUJBDXR7IC05cfLo=;
        b=gqdtvIgRB6kcFbxvqdJHfXxkZFaayn/WqW1WUPXMcVdp142jJ5cPoLPjaUe7GMm+Cs
         JmXregBRDYYeDJQr7Oddsbn2HYVD3MxbXe3Dldx7wsyPIMEv/bxeJ85w38QHZPdj/ENP
         B4+ZbnCqLSiugsePpjx5sP34UcsaRkIwb48+l5k23oq22XbFB0R5j5iyZkfDXPHnTMiB
         VdC1cV/5LW35HYqaEqc+Gw7ws+tC+1vyIBjjtItNNCeK6CeVmRvhPNZPlQUm7kzIcAQR
         fTEOuKOi2LSOCkpEAVUeOJ0yYnQbmjfe3D5gvghUiKfL91ZWha5005XEFKTZBFQgAK14
         djnA==
X-Gm-Message-State: AOJu0YyW2Th4Gijb4tt7V0eMkrQzOWWJE/mSbnCMHCWpmTXHVt1rSL50
	cOGd9pqmSTojS/TLHlxxdK4SwQ==
X-Google-Smtp-Source: AGHT+IFkwjfPBd2yc8mJTKncE3vqTaKfj1taiCNjhQjrYNC7gDR/8luatOeD/+/M95Nq3Fi20OUQWg==
X-Received: by 2002:a05:600c:3784:b0:3fb:4055:1ddd with SMTP id o4-20020a05600c378400b003fb40551dddmr7641400wmr.28.1695052683796;
        Mon, 18 Sep 2023 08:58:03 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
        by smtp.gmail.com with ESMTPSA id ay18-20020a05600c1e1200b003fef5e76f2csm3022438wmb.0.2023.09.18.08.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:57:59 -0700 (PDT)
Date: Mon, 18 Sep 2023 16:58:00 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230918155800.GA2751287@myrica>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>

On Mon, Sep 18, 2023 at 01:51:43PM +0200, Niklas Schnelle wrote:
> Pull out the sync operation from viommu_map_pages() by implementing
> ops->iotlb_sync_map. This allows the common IOMMU code to map multiple
> elements of an sg with a single sync (see iommu_map_sg()). Furthermore,
> it is also a requirement for IOMMU_CAP_DEFERRED_FLUSH.
> 
> Link: https://lore.kernel.org/lkml/20230726111433.1105665-1-schnelle@linux.ibm.com/
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

This must be merged after "iommu/dma: s390 DMA API conversion and
optimized IOTLB flushing" because of the updated iotlb_sync_map()
prototype.

Thanks,
Jean

> ---
>  drivers/iommu/virtio-iommu.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 17dcd826f5c2..3649586f0e5c 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -189,6 +189,12 @@ static int viommu_sync_req(struct viommu_dev *viommu)
>  	int ret;
>  	unsigned long flags;
>  
> +	/*
> +	 * .iotlb_sync_map and .flush_iotlb_all may be called before the viommu
> +	 * is initialized e.g. via iommu_create_device_direct_mappings()
> +	 */
> +	if (!viommu)
> +		return 0;
>  	spin_lock_irqsave(&viommu->request_lock, flags);
>  	ret = __viommu_sync_req(viommu);
>  	if (ret)
> @@ -843,7 +849,7 @@ static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
>  			.flags		= cpu_to_le32(flags),
>  		};
>  
> -		ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
> +		ret = viommu_add_req(vdomain->viommu, &map, sizeof(map));
>  		if (ret) {
>  			viommu_del_mappings(vdomain, iova, end);
>  			return ret;
> @@ -912,6 +918,14 @@ static void viommu_iotlb_sync(struct iommu_domain *domain,
>  	viommu_sync_req(vdomain->viommu);
>  }
>  
> +static int viommu_iotlb_sync_map(struct iommu_domain *domain,
> +				 unsigned long iova, size_t size)
> +{
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	return viommu_sync_req(vdomain->viommu);
> +}
> +
>  static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
>  {
>  	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
> @@ -1058,6 +1072,7 @@ static struct iommu_ops viommu_ops = {
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
