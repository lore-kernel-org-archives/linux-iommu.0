Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EB517722
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 18:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687285330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qMppbORYsoJ4mNBfjmtAxVeIMKMC7cMCgnMzK9NJ+rI=;
	b=XZI/HEKkvZYb2XqLobX2nxiZ11LtYucLbuy8pQQTGW6CL1dLtbPYwEys9dgAYJtVkSeLs9
	YlbHbrtG0TwV10Dv2U4LN1sU/4mw7jjAC12fOHCGrE0Vue90Hf5x+IV/epqQ9/19VLI/zV
	+4B3lOkmhXktjYKZoMgBer+To4nHtdA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-d5CKK15yPqGEw09TLInsPA-1; Tue, 20 Jun 2023 14:22:03 -0400
X-MC-Unique: d5CKK15yPqGEw09TLInsPA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-62fe611af5bso51117096d6.0
        for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 11:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687285322; x=1689877322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMppbORYsoJ4mNBfjmtAxVeIMKMC7cMCgnMzK9NJ+rI=;
        b=Ig9pRoWfk9ezSMnatVKFYKzIPC8PVJtqksLYqV5gQdp4P+UJqrEvb1qFEaAkXDWbje
         GIgWFawfr9zvMvxWvoOi4GyFmTtXr4pTcFce2/pJ8iWk9tNnZNocPQug+sa94vzpNBP2
         GPPM1VVtO4iw6mWefcVLUBBwvEBGcnqbBzyHLQgavnt3OpUwiIq6T4iPLJhKrY4/75nQ
         m8qDelJDgu+wvusozv9ZaKmGZaGjO08vW7fIN98IlZLkiF+jmDSlyjCzZhgg43MtcXFZ
         Ssx2sZyXQBU5C0y0UlyS+zNccG7zOFuaKCAjVZbgrZge0HyPVIGKZIM1d0YxuObehEDS
         NXSg==
X-Gm-Message-State: AC+VfDyjj9cRIiVQQtdvNpf62VNkiq8m2odU1sSFJabxdh3PPLlvZpTF
	b92ZsZS8NXvV4y0JFZ7YH2tTLe02ga2Xc4wSlP+rRHmq2VNNdFEnX6I8h2du0i9G1F7s8khK+7e
	mcpBH0DaSEZRq8DomPlhlyYA=
X-Received: by 2002:a05:6214:2302:b0:626:3375:6fea with SMTP id gc2-20020a056214230200b0062633756feamr14462130qvb.22.1687285322775;
        Tue, 20 Jun 2023 11:22:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7WXmkFqPLCrxRSMmj/VO7EarYYPgsQ1ofB7UbCv6V7DJlgyvU95pRra7oRroasmPnEyCC32A==
X-Received: by 2002:a05:6214:2302:b0:626:3375:6fea with SMTP id gc2-20020a056214230200b0062633756feamr14462118qvb.22.1687285322557;
        Tue, 20 Jun 2023 11:22:02 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id z12-20020a0cf24c000000b006300ff90e71sm1490543qvl.122.2023.06.20.11.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 11:22:01 -0700 (PDT)
Date: Tue, 20 Jun 2023 11:21:59 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH trivial] iommu/amd: Rearrange DTE bit definations
Message-ID: <wb6rm3om3ocge67brjdr33lltvc7xl3iablueho3yewm7bnpje@2rfzfuq5vmw2>
References: <20230619131908.5887-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230619131908.5887-1-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 19, 2023 at 01:19:08PM +0000, Vasant Hegde wrote:
> Rearrage according to 64bit word they are in.
> 
> Note that I have not rearranged gcr3 related macros even though
> they belong to different 64bit word as its easy to read it in
> current format.
> 
> No functional changes intended.
> 
> Suggested-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 53443d6f7b13..082c57b8c2d6 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -381,15 +381,15 @@
>   */
>  #define DTE_FLAG_V	BIT_ULL(0)
>  #define DTE_FLAG_TV	BIT_ULL(1)
> +#define DTE_FLAG_GIOV	BIT_ULL(54)
> +#define DTE_FLAG_GV	BIT_ULL(55)
> +#define DTE_GLX_SHIFT	(56)
> +#define DTE_GLX_MASK	(3)
>  #define DTE_FLAG_IR	BIT_ULL(61)
>  #define DTE_FLAG_IW	BIT_ULL(62)
>  
>  #define DTE_FLAG_IOTLB	BIT_ULL(32)
> -#define DTE_FLAG_GIOV	BIT_ULL(54)
> -#define DTE_FLAG_GV	BIT_ULL(55)
>  #define DTE_FLAG_MASK	(0x3ffULL << 32)
> -#define DTE_GLX_SHIFT	(56)
> -#define DTE_GLX_MASK	(3)
>  #define DEV_DOMID_MASK	0xffffULL
>  
>  #define DTE_GCR3_VAL_A(x)	(((x) >> 12) & 0x00007ULL)
> -- 
> 2.31.1
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

