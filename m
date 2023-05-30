Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135381F179
	for <iommu@lists.linux.dev>; Tue, 30 May 2023 17:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685466779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XA7kTwQFWkusxdUrUJ42PHbG7/6n1MWIHbwCRsAO7Gk=;
	b=HfVtWqhqwxRe6DMOVX6eNeEKSpuxhJsAgml00r5NAJpnvBiUjCj2idHs26ZqgSq7D5WM+G
	l75WV4JjGFFhCREld4Z96Kn3yeyApoCLsM2zcfoLibA8lieRg5NG0Agf7WCD1c+1SdDt48
	a43bTwwxHvgOp8a+Xxt+AVJuuuYwUik=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-5s7OaHYmM1SUuw2UQ5O4zw-1; Tue, 30 May 2023 13:12:58 -0400
X-MC-Unique: 5s7OaHYmM1SUuw2UQ5O4zw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f6b0c739adso30763231cf.3
        for <iommu@lists.linux.dev>; Tue, 30 May 2023 10:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685466777; x=1688058777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA7kTwQFWkusxdUrUJ42PHbG7/6n1MWIHbwCRsAO7Gk=;
        b=BORY6iCWwv2f6DEXur2x9j5K3nsGtZXXJhkr2ppCL4mybTnsf4XCypPk89Og+w3krU
         y/6Z0dAR68hPhhLZ+7LhiANI+ipA3zYR0EKB/mO5Hx93+hi7YSWVNr1p9Sv7iIclwFuV
         uBRigIwsdXTwxF/3HSeDf4IEPSGXtOZquv6GlOp52ECwgj7z/7zRWp1gwTeFYe+Ph3Km
         YiCGf3S2UbhVlEiv18YunBmXVAzVhfNXmiWLznhZdFApdOp2NvTkyX0AAi8t7HrRPDH8
         Ai25nvso5jFr7ibzEc+gS3l8+2+AFdVuzxHoI6oL9KnLY06MJZ3cZSwxtH4SeNnBkvie
         UVQQ==
X-Gm-Message-State: AC+VfDzAmBADZ4ssPyGRYdEVAjfG58RkqaBdrYoTiEchkhhiRznvR4Bm
	s5HSe2h0eWx62St4iIHAl3lxCvkrYmQfVIfSWCTiqQZ5GnviKjF8Q2bIGv9ysBeUn1NbCqSE5/e
	ROaKjj0m3ZRSXbCQ=
X-Received: by 2002:a05:622a:174d:b0:3f4:f1be:557 with SMTP id l13-20020a05622a174d00b003f4f1be0557mr3131660qtk.1.1685466777331;
        Tue, 30 May 2023 10:12:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7qwgDWrkXZfO0XXI4rNB+nmQ4QAL5V50cC0Yr+i5N2M5STCwfndfEKWLAKtvbQpD9izUPdKg==
X-Received: by 2002:a05:622a:174d:b0:3f4:f1be:557 with SMTP id l13-20020a05622a174d00b003f4f1be0557mr3131640qtk.1.1685466777094;
        Tue, 30 May 2023 10:12:57 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id p9-20020a05622a048900b003e1cf472b17sm4800652qtx.97.2023.05.30.10.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 10:12:56 -0700 (PDT)
Date: Tue, 30 May 2023 10:12:54 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@infradead.org, m.szyprowski@samsung.com, iommu@lists.linux.dev, 
	catalin.marinas@arm.com, linux-kernel@vger.kernel.org, logang@deltatee.com
Subject: Re: [PATCH] dma-mapping: Name SG DMA flag helpers consistently
Message-ID: <jsgp55bzui7af7hvaa2hvbhgvqqe3qe7qtaiqu4xdndmgw5zpm@yt3bspzckv4t>
References: <fa2eca2862c7ffc41b50337abffb2dfd2864d3ea.1685036694.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <fa2eca2862c7ffc41b50337abffb2dfd2864d3ea.1685036694.git.robin.murphy@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 25, 2023 at 06:46:31PM +0100, Robin Murphy wrote:
> sg_is_dma_bus_address() is inconsistent with the naming pattern of its
> corresponding setters and its own kerneldoc, so take the majority vote
> and rename it sg_dma_is_bus_address() (and fix up the missing
> underscores in the kerneldoc too). This gives us a nice clear pattern
> where SG DMA flags are SG_DMA_<NAME>, and the helpers for acting on them
> are sg_dma_<action>_<name>().
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/dma-iommu.c   | 8 ++++----
>  drivers/iommu/iommu.c       | 2 +-
>  include/linux/scatterlist.h | 8 ++++----
>  kernel/dma/direct.c         | 2 +-
>  4 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 7a9f0b0bddbd..b8bba4aa196f 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1080,7 +1080,7 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
>  		sg_dma_address(s) = DMA_MAPPING_ERROR;
>  		sg_dma_len(s) = 0;
>  
> -		if (sg_is_dma_bus_address(s)) {
> +		if (sg_dma_is_bus_address(s)) {
>  			if (i > 0)
>  				cur = sg_next(cur);
>  
> @@ -1136,7 +1136,7 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
>  	int i;
>  
>  	for_each_sg(sg, s, nents, i) {
> -		if (sg_is_dma_bus_address(s)) {
> +		if (sg_dma_is_bus_address(s)) {
>  			sg_dma_unmark_bus_address(s);
>  		} else {
>  			if (sg_dma_address(s) != DMA_MAPPING_ERROR)
> @@ -1329,7 +1329,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>  	 * just have to be determined.
>  	 */
>  	for_each_sg(sg, tmp, nents, i) {
> -		if (sg_is_dma_bus_address(tmp)) {
> +		if (sg_dma_is_bus_address(tmp)) {
>  			sg_dma_unmark_bus_address(tmp);
>  			continue;
>  		}
> @@ -1343,7 +1343,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>  
>  	nents -= i;
>  	for_each_sg(tmp, tmp, nents, i) {
> -		if (sg_is_dma_bus_address(tmp)) {
> +		if (sg_dma_is_bus_address(tmp)) {
>  			sg_dma_unmark_bus_address(tmp);
>  			continue;
>  		}
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f1dcfa3f1a1b..eb620552967b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2567,7 +2567,7 @@ ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>  			len = 0;
>  		}
>  
> -		if (sg_is_dma_bus_address(sg))
> +		if (sg_dma_is_bus_address(sg))
>  			goto next;
>  
>  		if (len) {
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 375a5e90d86a..d1ed52d083da 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -259,7 +259,7 @@ static inline void sg_unmark_end(struct scatterlist *sg)
>  #define SG_DMA_BUS_ADDRESS (1 << 0)
>  
>  /**
> - * sg_dma_is_bus address - Return whether a given segment was marked
> + * sg_dma_is_bus_address - Return whether a given segment was marked
>   *			   as a bus address
>   * @sg:		 SG entry
>   *
> @@ -267,13 +267,13 @@ static inline void sg_unmark_end(struct scatterlist *sg)
>   *   Returns true if sg_dma_mark_bus_address() has been called on
>   *   this segment.
>   **/
> -static inline bool sg_is_dma_bus_address(struct scatterlist *sg)
> +static inline bool sg_dma_is_bus_address(struct scatterlist *sg)
>  {
>  	return sg->dma_flags & SG_DMA_BUS_ADDRESS;
>  }
>  
>  /**
> - * sg_dma_mark_bus address - Mark the scatterlist entry as a bus address
> + * sg_dma_mark_bus_address - Mark the scatterlist entry as a bus address
>   * @sg:		 SG entry
>   *
>   * Description:
> @@ -301,7 +301,7 @@ static inline void sg_dma_unmark_bus_address(struct scatterlist *sg)
>  
>  #else
>  
> -static inline bool sg_is_dma_bus_address(struct scatterlist *sg)
> +static inline bool sg_dma_is_bus_address(struct scatterlist *sg)
>  {
>  	return false;
>  }
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 5595d1d5cdcc..d29cade048db 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -463,7 +463,7 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>  	int i;
>  
>  	for_each_sg(sgl,  sg, nents, i) {
> -		if (sg_is_dma_bus_address(sg))
> +		if (sg_dma_is_bus_address(sg))
>  			sg_dma_unmark_bus_address(sg);
>  		else
>  			dma_direct_unmap_page(dev, sg->dma_address,
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 

