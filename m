Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EF663CC
	for <iommu@lists.linux.dev>; Mon, 18 Sep 2023 15:59:10 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-317c3ac7339so4214699f8f.0
        for <iommu@lists.linux.dev>; Mon, 18 Sep 2023 08:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695052748; x=1695657548; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3XBJAiGdnAah6NYpzFbKj5jrg8y8Zyfvfwd8mgzKL8c=;
        b=wGauVfGSqeerqccc4TEZAOqMs0yjsSYXyv68I8bp00F0g5xpL4o9N3TGNp+N/0imFg
         17Brxt0bpEdlgrn9vPAGNgC92ZlKQYBUVoiaUPO1Q6PaUbItpNN0WCQ4qYiUYQGqypEI
         VHMlg0uziVW5SYG9CYYxvW/gz2j70XmIdmwnLbBHP2Fb4l9L4nD3qDXXYGCcCTb8r4LH
         IlVrYkKSvzlhr/3g9X+W+nroap8jwC4FEyEXA471NjK0T4/Q30k4zaHJqjmx4onhMIBF
         HWiKNh1AEFbinrOwTSNqSVj+iDSQNTUWVywUdw+razaWpxRpgaJ2uI2OI9B4GIdCIbty
         fmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695052748; x=1695657548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XBJAiGdnAah6NYpzFbKj5jrg8y8Zyfvfwd8mgzKL8c=;
        b=hBzCQBEndIz8Tn8fyqE39lGRKJrLpmZM0UdDWJnOp7d32oQ9Q0f1NUCRAWj18NdePc
         8IabCsBKnLPFV8CZ2nl4CkoFBhXNMpIpzAE8ffpmCfLDsqYLh3MZhFmTEhO1CyAf3d1e
         /wGxj7x34PND9UKt5zKAALZZ/ANtuTXlOZw/oB10CM4xiDp81QOJYH/BMWV8t9V4mlCh
         1CM8XNyq0PlLwsSRB4TodM4TEVV8x5J1OS8ABRJG5f50Dv+ynOmXSz0S6M/a8Nz8pvkU
         Lx+zPjr2hGXLzb6Bj99OBg8zlmN/G65cOR6LTS+y+hZu9SH0IUMEZxMnWOLkjW0rd4TM
         NvYQ==
X-Gm-Message-State: AOJu0YwD2I1r5P9qM3tSx7dZLP1yKZDwSi2rwNJCDEkIeVAtvYHdfbLB
	pfe4jiDgbO0h4Io8a/uxUoSX/Q==
X-Google-Smtp-Source: AGHT+IGKCbH5H/HzgTN4rOlc0G7gV3sYCmmjllMp3MZ0mg9AwdHJzCYa0YtI/bnTzf2Hxk/+Rx6GTQ==
X-Received: by 2002:a5d:56ce:0:b0:314:1230:29b0 with SMTP id m14-20020a5d56ce000000b00314123029b0mr8616133wrw.52.1695052748670;
        Mon, 18 Sep 2023 08:59:08 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c028800b00402c0a8a084sm15481477wmk.17.2023.09.18.08.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:59:07 -0700 (PDT)
Date: Mon, 18 Sep 2023 16:59:11 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iommu/virtio: Add ops->flush_iotlb_all and enable
 deferred flush
Message-ID: <20230918155911.GB2751287@myrica>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-2-f33767f6cf7a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918-viommu-sync-map-v2-2-f33767f6cf7a@linux.ibm.com>

On Mon, Sep 18, 2023 at 01:51:44PM +0200, Niklas Schnelle wrote:
> Add ops->flush_iotlb_all operation to enable virtio-iommu for the
> dma-iommu deferred flush scheme. This results in a significant increase
> in performance in exchange for a window in which devices can still
> access previously IOMMU mapped memory when running with
> CONFIG_IOMMU_DEFAULT_DMA_LAZY. The previous strict behavior can be
> achieved with iommu.strict=1 on the kernel command line or
> CONFIG_IOMMU_DEFAULT_DMA_STRICT.
> 
> Link: https://lore.kernel.org/lkml/20230802123612.GA6142@myrica/
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/virtio-iommu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 3649586f0e5c..4dd330fbcbdd 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -926,6 +926,13 @@ static int viommu_iotlb_sync_map(struct iommu_domain *domain,
>  	return viommu_sync_req(vdomain->viommu);
>  }
>  
> +static void viommu_flush_iotlb_all(struct iommu_domain *domain)
> +{
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	viommu_sync_req(vdomain->viommu);
> +}
> +
>  static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
>  {
>  	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
> @@ -1051,6 +1058,8 @@ static bool viommu_capable(struct device *dev, enum iommu_cap cap)
>  	switch (cap) {
>  	case IOMMU_CAP_CACHE_COHERENCY:
>  		return true;
> +	case IOMMU_CAP_DEFERRED_FLUSH:
> +		return true;
>  	default:
>  		return false;
>  	}
> @@ -1071,6 +1080,7 @@ static struct iommu_ops viommu_ops = {
>  		.map_pages		= viommu_map_pages,
>  		.unmap_pages		= viommu_unmap_pages,
>  		.iova_to_phys		= viommu_iova_to_phys,
> +		.flush_iotlb_all	= viommu_flush_iotlb_all,
>  		.iotlb_sync		= viommu_iotlb_sync,
>  		.iotlb_sync_map		= viommu_iotlb_sync_map,
>  		.free			= viommu_domain_free,
> 
> -- 
> 2.39.2
> 
