Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C582561
	for <iommu@lists.linux.dev>; Mon,  5 Sep 2022 15:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662390370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=baWRHv65JoZKVmoERU+nz7rnlnje9QiEDNwQTaeNASE=;
	b=gq0zg8ZJ72VzEzBbfK6Cp55m7GjLQ9eZUrYhSZhB5XaD7BF5sG85v6lv0k4qvgvDc5O+3o
	Sre4spmL2/JPeaKxgMZftl9qAAiLudbiNt9ZBCXg9zAPeUw5NsnYL/dZPuXdhoGGCog2eE
	jiCRiX9cJP7KY5TamS3F4IbTFuc2HXM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-21-Xlqf1MSFNH-Nw95qYuPBcQ-1; Mon, 05 Sep 2022 11:06:07 -0400
X-MC-Unique: Xlqf1MSFNH-Nw95qYuPBcQ-1
Received: by mail-qt1-f200.google.com with SMTP id o22-20020ac85a56000000b0034481129ce6so7054261qta.19
        for <iommu@lists.linux.dev>; Mon, 05 Sep 2022 08:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=baWRHv65JoZKVmoERU+nz7rnlnje9QiEDNwQTaeNASE=;
        b=6nNTDK+FYrRnCLxpmPncLEduEzgMei66A8/yigJ2YpsFmY78yXac2xMajrRe47TJtP
         b8chjg92T9XNbnckRDl2jH6Fkw/7LJjKJhmp1XKfw6ZKQxagLvhXVRi5KhVWNK4maQSI
         KA55TnvoRd/CFtZ9VbheGKS8KVHD59EwEVJw3ACoZUe/jRCKBPE7atlzVl5Hf4HPktB6
         b95M7ekgVjPAs84pWUQEuOzYiz8x/0J1OyqdKmBsw/Mt8QIz34kODX4XtI/a0jb/+QHw
         BeY6MFOJVKw2ufGuKBzvSfuLlhCbff3V2NHuyjb8ppQZVFFdjKdjI587MuXXFy+Ic1lb
         UokQ==
X-Gm-Message-State: ACgBeo3JdTn6x7z/HNraJuyDyv2i5B0XHlozjPZtljVwk+jFIMx2BUMc
	F/JYtz5cNeJ6HNXP4RSfAVEjsXAQWNEUjBsJN2ASDUQEvFRgA4uixDc4B9e361c3mgviFR3BhWX
	9Giuqj5JfAGB/Fzo=
X-Received: by 2002:a05:622a:104c:b0:343:587c:1bc8 with SMTP id f12-20020a05622a104c00b00343587c1bc8mr39900912qte.484.1662390366689;
        Mon, 05 Sep 2022 08:06:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR41Ha0F7IAhih0139Y0sukA7FAGbI5WVrHQG6qV3+58gFOIj4YCcPxlSN/QaIfa4iG1ozbROw==
X-Received: by 2002:a05:622a:104c:b0:343:587c:1bc8 with SMTP id f12-20020a05622a104c00b00343587c1bc8mr39900876qte.484.1662390366391;
        Mon, 05 Sep 2022 08:06:06 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id i1-20020a05620a248100b006b8e63dfffbsm8588663qkn.58.2022.09.05.08.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 08:06:06 -0700 (PDT)
Date: Mon, 5 Sep 2022 08:06:04 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: John Garry <john.garry@huawei.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com
Subject: Re: [PATCH v2 1/2] iova: Remove some magazine pointer NULL checks
Message-ID: <20220905150604.7bijcbeuuyw44rkl@cantor>
References: <1662369083-238529-1-git-send-email-john.garry@huawei.com>
 <1662369083-238529-2-git-send-email-john.garry@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1662369083-238529-2-git-send-email-john.garry@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 05, 2022 at 05:11:22PM +0800, John Garry wrote:
> Since commit 32e92d9f6f87 ("iommu/iova: Separate out rcache init") it
> has not been possible to have NULL CPU rcache "loaded" or "prev" magazine
> pointers. As such, the checks in iova_magazine_full(),
> iova_magazine_empty(), and iova_magazine_free_pfns() may be dropped.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com

> ---
>  drivers/iommu/iova.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 47d1983dfa2a..580fdf669922 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -661,9 +661,6 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>  	unsigned long flags;
>  	int i;
>  
> -	if (!mag)
> -		return;
> -
>  	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
>  
>  	for (i = 0 ; i < mag->size; ++i) {
> @@ -683,12 +680,12 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>  
>  static bool iova_magazine_full(struct iova_magazine *mag)
>  {
> -	return (mag && mag->size == IOVA_MAG_SIZE);
> +	return mag->size == IOVA_MAG_SIZE;
>  }
>  
>  static bool iova_magazine_empty(struct iova_magazine *mag)
>  {
> -	return (!mag || mag->size == 0);
> +	return mag->size == 0;
>  }
>  
>  static unsigned long iova_magazine_pop(struct iova_magazine *mag,
> -- 
> 2.35.3
> 

