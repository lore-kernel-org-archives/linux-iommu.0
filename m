Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CCB7E9
	for <iommu@lists.linux.dev>; Mon, 19 Sep 2022 08:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663576233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h70RRnLGDocRCdId1Q3AvZ9oOdszso8M7BsFXb0vm98=;
	b=DxaS0WL/qt5z377z5qHdAEhAvKl4VvluoEGAYK7QaoYI7v/xVHB1gh8cZbeE1KIpbOqCiy
	p5OOlW85XIovdk2EQxQdf0+qcQojLj8Eisfc9j8ogIFAtedFxTzK/yRIFRDyjTMYvqjqSq
	C389BWC5PnYGXqMM4quF6SOCI3hprMs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-190-2hWH1lu-Mhe6pNfgqo9CAA-1; Mon, 19 Sep 2022 04:30:32 -0400
X-MC-Unique: 2hWH1lu-Mhe6pNfgqo9CAA-1
Received: by mail-qk1-f199.google.com with SMTP id f12-20020a05620a408c00b006ced53b80e5so5786826qko.17
        for <iommu@lists.linux.dev>; Mon, 19 Sep 2022 01:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=h70RRnLGDocRCdId1Q3AvZ9oOdszso8M7BsFXb0vm98=;
        b=DBSLdqR4CokHWOZ1fJkdQP5mg6s5Vqp0oxaYwjdDyZ3HURUpuOckGgyJ0kF05Jn+7D
         FnFRbMNJvC8ub4FyOdKksnxAESqJgG+gD0uIQ5bS9uvaOhb7ac/GUtEWg4oynnqtbDwt
         5WlZ9IeJNpzgE1tdbCSexM8gUOV51jAASMQ2/Q8CjFUaslk12HaLBYzfyb1xCFDViYuf
         u6lFfVmtCGqvalMcWAglbYoBRxS27WFGUjn+GmSFZ8yFNC6lyoBdAwYPvJliF+4FzwwS
         8VbhCmDUQVLGv08t4XX0r2PNDb5xnpIbIFI00ulCY/6rjozigRKXBycxoJsHcPmpTF9S
         UoGA==
X-Gm-Message-State: ACrzQf1IA7pB6sLt+U8igBSbaj9VxF30EKU+GRpzlViI7hVKl81ScYtK
	zRNOS9JXAj8Lmy4mOklrFAPhkEZTVwW0cUAW8McNkUhtFy+53gP7ZBsQEo4Tn2riFrI9W3+khs6
	U3mHiRlkhZGBmz00=
X-Received: by 2002:a0c:9d46:0:b0:476:ff07:3fe7 with SMTP id n6-20020a0c9d46000000b00476ff073fe7mr13987405qvf.15.1663576231853;
        Mon, 19 Sep 2022 01:30:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4XbGFJVZrlxcnOG4Tqc8u7gYjO9AunLzgZXMoLWaP7MnGq098SrMu+vtT5BdoTxvmAzpO8Og==
X-Received: by 2002:a0c:9d46:0:b0:476:ff07:3fe7 with SMTP id n6-20020a0c9d46000000b00476ff073fe7mr13987387qvf.15.1663576231669;
        Mon, 19 Sep 2022 01:30:31 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id c4-20020a05620a268400b006b633dc839esm12587073qkp.66.2022.09.19.01.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 01:30:31 -0700 (PDT)
Date: Mon, 19 Sep 2022 01:30:29 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Avoid unnecessary global DMA cache
 invalidation
Message-ID: <20220919083029.vwwxkm5kuyylgbew@cantor>
References: <20220919062523.3438951-1-baolu.lu@linux.intel.com>
 <20220919062523.3438951-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20220919062523.3438951-3-baolu.lu@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 19, 2022 at 02:25:23PM +0800, Lu Baolu wrote:
> Some VT-d hardware implementations invalidate all DMA remapping hardware
> translation caches as part of SRTP flow. The VT-d spec adds a ESRTPS
> (Enhanced Set Root Table Pointer Support, section 11.4.2 in VT-d spec)
> capability bit to indicate this. With this bit set, software has no need
> to issue the global invalidation request.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com

> ---
>  drivers/iommu/intel/iommu.h | 1 +
>  drivers/iommu/intel/iommu.c | 7 +++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 5407d82df4d1..251a609fdce3 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -146,6 +146,7 @@
>  /*
>   * Decoding Capability Register
>   */
> +#define cap_esrtps(c)		(((c) >> 63) & 1)
>  #define cap_esirtps(c)		(((c) >> 62) & 1)
>  #define cap_fl5lp_support(c)	(((c) >> 60) & 1)
>  #define cap_pi_support(c)	(((c) >> 59) & 1)
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 8e5d99197d39..c20f3e060bac 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1239,6 +1239,13 @@ static void iommu_set_root_entry(struct intel_iommu *iommu)
>  
>  	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
>  
> +	/*
> +	 * Hardware invalidates all DMA remapping hardware translation
> +	 * caches as part of SRTP flow.
> +	 */
> +	if (cap_esrtps(iommu->cap))
> +		return;
> +
>  	iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
>  	if (sm_supported(iommu))
>  		qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
> -- 
> 2.34.1
> 

