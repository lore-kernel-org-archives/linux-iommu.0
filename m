Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88B410942
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 17:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684516322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERQYZtyC8yrGAR4Lpp1idLfOrOHvWlcfV8KyOPQ1tKc=;
	b=Uyn7tA59hyiCszyrYIDRASeTtSqMah9eCUNeTR/V9hYS/Wj16dFKw4A0dbT0XUxCPEDCE7
	HKVOy7lCnJdW8KTqpYYoMKSG64y197H/p0Ax3WJnjzwXVRBaZyoGuWbPTgqX3ebeW8soIx
	PWVbeGHaHQatOslBvwrnHviHk0/fuwQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-6TcZEdWjOX22f6JLLzRPVQ-1; Fri, 19 May 2023 13:12:01 -0400
X-MC-Unique: 6TcZEdWjOX22f6JLLzRPVQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f697a64cc2so4566721cf.3
        for <iommu@lists.linux.dev>; Fri, 19 May 2023 10:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516320; x=1687108320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERQYZtyC8yrGAR4Lpp1idLfOrOHvWlcfV8KyOPQ1tKc=;
        b=NUJx6ZciGboYotYTWwRkDM/tMm3uTz496niErs6lMxxFvdR/yqT6Yeqifk8L+kmehZ
         imSWeYktI6qwTAYuEPAx5vBQV96V/QGDnwEk2pXgLACDJvsw6L2Z+GE22hrYxdgmmFSX
         3Bmdek5SfzrfjWntn5hCcJtPeE71jaUA63orHAcnz70XknteXaUWbsBDzU39StSJnDZv
         s4lqQOR7CviGNLdR+iRfoB6tFdKGGJDLBO1yqwGC0k1Ob1iIUp4LPcPyVs0KKJyUK7e7
         ackxSn9JRLPryHREBNhcj1NYZQxawnRzzbPWSNBAIsuYijibb0xq1eUbfJKko2pVi/UY
         u+PA==
X-Gm-Message-State: AC+VfDyxWV2DT31SAQeJa6r0+9P/eg9vx6kRxLqRR3DEIwG6kPVSR1hT
	Pf3Mcf45MrZ1pT2DrDBNHf6ei2CmfoSaJ/cAcvmFlHYBlbelHZl2Z/Bbud+CiWkSaju9rri3bN6
	omXlipABsE3E477Y=
X-Received: by 2002:a05:622a:1825:b0:3ef:57c1:ad7 with SMTP id t37-20020a05622a182500b003ef57c10ad7mr4366567qtc.30.1684516320716;
        Fri, 19 May 2023 10:12:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7X7UOP6hwcDTnkt/WJyzqcvnBaxy/NW3l8Evf1CMoFj8Fx9tS5A74/hQNR+L1ll2twROxXHA==
X-Received: by 2002:a05:622a:1825:b0:3ef:57c1:ad7 with SMTP id t37-20020a05622a182500b003ef57c10ad7mr4366425qtc.30.1684516319215;
        Fri, 19 May 2023 10:11:59 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id cm26-20020a05622a251a00b003f394decd08sm1421041qtb.62.2023.05.19.10.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:11:58 -0700 (PDT)
Date: Fri, 19 May 2023 10:11:56 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jon Pan-Doh <pandoh@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Gary Zibrat <gzibrat@google.com>, 
	Sudheer Dantuluri <dantuluris@google.com>, Nadav Amit <namit@vmware.com>, 
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH RESEND] iommu/amd: Fix domain flush size when syncing
 iotlb
Message-ID: <5vcww4kwofeftpqyfckyacystlw2g3eiwg47liul34yzyibclh@pas4sdd5j5fc>
References: <20230518015054.2223833-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230518015054.2223833-1-pandoh@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 17, 2023 at 06:50:54PM -0700, Jon Pan-Doh wrote:
> When running on an AMD vIOMMU, we observed multiple invalidations (of
> decreasing power of 2 aligned sizes) when unmapping a single page.
> 
> Domain flush takes gather bounds (end-start) as size param. However,
> gather->end is defined as the last inclusive address (start + size - 1).
> This leads to an off by 1 error.
> 
> With this patch, verified that 1 invalidation occurs when unmapping a
> single page.
> 
> Fixes: a270be1b3fdf ("iommu/amd: Use only natural aligned flushes in a VM")
> Cc: <stable@vger.kernel.org> # 5.15.x
> Suggested-by: Gary Zibrat <gzibrat@google.com>
> Tested-by: Sudheer Dantuluri <dantuluris@google.com>
> Acked-by: Nadav Amit <namit@vmware.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> ---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com

>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 5a505ba5467e..da45b1ab042d 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2378,7 +2378,7 @@ static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&dom->lock, flags);
> -	domain_flush_pages(dom, gather->start, gather->end - gather->start, 1);
> +	domain_flush_pages(dom, gather->start, gather->end - gather->start + 1, 1);
>  	amd_iommu_domain_flush_complete(dom);
>  	spin_unlock_irqrestore(&dom->lock, flags);
>  }
> -- 
> 2.40.0.634.g4ca3ef3211-goog
> 

