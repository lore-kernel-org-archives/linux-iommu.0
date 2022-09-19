Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57227A48
	for <iommu@lists.linux.dev>; Mon, 19 Sep 2022 08:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663576168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F3xg0oZZ6d2RRIQotHdVIz60qRrzyRMeJDEgCiAZ0Mw=;
	b=hMHnj2w6IySPJ4yqwnmG69ReqeJKurSCJIUMEod8bgJ5N6ZykLTknADt9kumAYb18lHt0O
	UcnsYHYl/gv0ezIlLdMPTm5jkqNL4DAcOjHt7Ka0/gBDa9vfGonUaxmOvzBATq3w0r6r90
	pUHZ1bF/jTCsNT+HabXSzYu4zOz1CMg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-46-DZyiU5DBOl-vbQoUDSaqLA-1; Mon, 19 Sep 2022 04:29:22 -0400
X-MC-Unique: DZyiU5DBOl-vbQoUDSaqLA-1
Received: by mail-qv1-f72.google.com with SMTP id f9-20020ad442c9000000b004ac7f4fde18so18918616qvr.14
        for <iommu@lists.linux.dev>; Mon, 19 Sep 2022 01:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=F3xg0oZZ6d2RRIQotHdVIz60qRrzyRMeJDEgCiAZ0Mw=;
        b=jinPvYV997GdM2HKaVdXh9bfhCI264B6EQ6d+ZcLUfTQujlt4S3Xz+D4CUYnyslebR
         whePbrWUjotmhpoD7upBiCEK93ziAiTRWLJBVwcdlsuFRn/NSG7V/jcZY+XgWA+ZtrAk
         ojA41PBqh3aSJ4mJY7XaOq9FWS5eNX/ilibVvyVIHjqidx2VFl3xaS+MV0eaxAxPX7E4
         gSoypH6YAxjmEF8jDnDqpkA9wpnaDZyaKASFW7cY3YP7UrfZ6qqk68azzXU44b8TpGom
         Khyht2QYKut9Rjd64FR30SXQfxJodgX0aVGkFvFL9HkKsGhGVNjs6JQiGlBe5EGosgNu
         fdmw==
X-Gm-Message-State: ACrzQf2zopul4FufXCAWvLezJYB5Il0TGiaf1tCuTH/uO1GYTSenMZMY
	xN31QUWOogZ4fD+m5xNQeSSpXrF8saqfGqBpZaN1qOEpDse2o1ljIsBhGcU6Gv/DmnB6Cj8RqYc
	f3tBddxW/QBtFXcU=
X-Received: by 2002:a05:6214:e6f:b0:4ad:d5a:f09b with SMTP id jz15-20020a0562140e6f00b004ad0d5af09bmr12869553qvb.34.1663576161981;
        Mon, 19 Sep 2022 01:29:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7VS5dzoLRy04YcELRQ5ZPTfY+JNNMRe/H4swC5sEjj6xjJyMhB4a94m3imvsO8Jdb3Xu7zug==
X-Received: by 2002:a05:6214:e6f:b0:4ad:d5a:f09b with SMTP id jz15-20020a0562140e6f00b004ad0d5af09bmr12869543qvb.34.1663576161746;
        Mon, 19 Sep 2022 01:29:21 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id l14-20020ac84cce000000b0034355a352d1sm9779291qtv.92.2022.09.19.01.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 01:29:20 -0700 (PDT)
Date: Mon, 19 Sep 2022 01:29:19 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/vt-d: Avoid unnecessary global IRTE cache
 invalidation
Message-ID: <20220919082919.ekv6p47y2nnmpswk@cantor>
References: <20220919062523.3438951-1-baolu.lu@linux.intel.com>
 <20220919062523.3438951-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20220919062523.3438951-2-baolu.lu@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 19, 2022 at 02:25:22PM +0800, Lu Baolu wrote:
> Some VT-d hardware implementations invalidate all interrupt remapping
> hardware translation caches as part of SIRTP flow. The VT-d spec adds
> a ESIRTPS (Enhanced Set Interrupt Remap Table Pointer Support, section
> 11.4.2 in VT-d spec) capability bit to indicate this. With this bit set,
> software has no need to issue the global invalidation request.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com

> ---
>  drivers/iommu/intel/iommu.h         | 1 +
>  drivers/iommu/intel/irq_remapping.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index eef1a166b855..5407d82df4d1 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -146,6 +146,7 @@
>  /*
>   * Decoding Capability Register
>   */
> +#define cap_esirtps(c)		(((c) >> 62) & 1)
>  #define cap_fl5lp_support(c)	(((c) >> 60) & 1)
>  #define cap_pi_support(c)	(((c) >> 59) & 1)
>  #define cap_fl1gp_support(c)	(((c) >> 56) & 1)
> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
> index 2e9683e970f8..b4a91fbd1c2f 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -494,7 +494,8 @@ static void iommu_set_irq_remapping(struct intel_iommu *iommu, int mode)
>  	 * Global invalidation of interrupt entry cache to make sure the
>  	 * hardware uses the new irq remapping table.
>  	 */
> -	qi_global_iec(iommu);
> +	if (!cap_esirtps(iommu->cap))
> +		qi_global_iec(iommu);
>  }
>  
>  static void iommu_enable_irq_remapping(struct intel_iommu *iommu)
> -- 
> 2.34.1
> 

