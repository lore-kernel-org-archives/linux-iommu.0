Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C2315FD0E
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093702; cv=none; b=ieZFCwzGPMLUxuTLLVSSdWvNeXHl0wqQCiITYlYSypeImuPHKeXasrzXPl8iVlA/o9kOQw/pl0pbOWSWC57NbOK+6Ama7jlAPUTetFvzQ85gZhBc+9lTuqKSJABnvNdbDFFbcWlSwKWNqAO6iCUCvdrMrBGQMRYnxh4OydBXHWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093702; c=relaxed/simple;
	bh=aJBG7fQrQyWTcB7pmO14FhgdBgyrVV0OZ6xe6YRLkUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjgbprtrHwkX0vCfGMY5NlP/zD0cJqESsHA8AM3IX3430F1u+0nKuGhtY2kE6wqwlnqO2C3V8jLS6ldCh3SM6KevSgqsYseAEHvCD3YCy/hmgdVBcGZUEgJhrt/qMvZd028hzWCFF5zkP1j4Rfxl9upY0BbpK2PzXF8zdLH1NPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OY8uhZi2; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OY8uhZi2"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c70d8bb618so1585711b6e.2
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715093698; x=1715698498; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=khya5nPWsz8iIm1AQ53Aurao/H+Jj1OPdGrhqcoxtig=;
        b=OY8uhZi2YeSflpd08051Oblwf9NGhcnuRupi2HTJpxr54rzDfxq8faxHADKl+Hzwhl
         2OT1tqltwItVvxuGZUdO9GuzhioN+a5c/PO8vF52ifODYBibJmt1/j36xPJYXB2PeOua
         /1UrBo9kKgjZSBfp8FbGYHixoGOEK/sIEkyp01NhUd2UoQmMIfE0odCcGAsb6bKjB46J
         kcooGld7puYcVlN3T7xSCPde0if6Tfkn8RAy6PGX1oisH0OwKvGvtj0yWlvYgZw3D6aZ
         CYd20sb19o2TWQV+uEHP+7zwuRg+2rTd+fjMdZdOwtv2VzefqOt3dRwr3WiYHMWY7Nvx
         9NHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715093698; x=1715698498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khya5nPWsz8iIm1AQ53Aurao/H+Jj1OPdGrhqcoxtig=;
        b=RFCg+jxB1wqfXKQITiE3EojZQOU+c2F4A9a1anh7qTSrrariHui87/kPHJ9qjOLCsf
         JvKQx4Qc1pD5oFCzlvM7Vt59kCDVTPI/cCnfE+MS1odQyFrHG+Nls3kycUhR8gTBeLih
         /pGO4fxCdAySBSkkHIZ8KFuz9pPOVKfsIzMpeIpF5mk4zKgnJjB2Mm9oSNwhCfitml4T
         j+zCNh6TivbTj0SzVGre6LwcNapQoYf5xo3MzSCy67+41Dw0JmHSMzaJKhhrLlpNZHbb
         9wmYJ6EmOZafaycFhtC6aa0/cdJ6ubETr470krCqtZ6hdrcXHclDmaHqrViVFU4F1ZKT
         rVYA==
X-Forwarded-Encrypted: i=1; AJvYcCVUQomImAny5QaNAXnY3v4qcESov5JjOQelTRCGKHpGgqdmgaDjE7VWn4rFKLWz4xU0wGZyJeeNxdk6cEen6nHzs77MBd0=
X-Gm-Message-State: AOJu0YzNolopxRtfVeHS0txpvCdzVK9QkQk/cHNab3xcs4KQuJRaUUJ6
	5ipomsALPiMCDPmedNBNI9vPLOvlQ6//0atibF4andPp91gCZ1aSepADp9OTY/I=
X-Google-Smtp-Source: AGHT+IH06U/MvUqSaZ8CzKk8w5FX8P/20f3bpgKLuBxThf4yEkosHT9oMIC/YgbQ5imbHRsONRdCTA==
X-Received: by 2002:a05:6808:16a9:b0:3c7:79c:72c9 with SMTP id bb41-20020a05680816a900b003c7079c72c9mr19634594oib.54.1715093698542;
        Tue, 07 May 2024 07:54:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id v16-20020a056808005000b003c96907bd58sm981178oic.50.2024.05.07.07.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:54:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4MDY-00825J-2j;
	Tue, 07 May 2024 11:54:56 -0300
Date: Tue, 7 May 2024 11:54:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC RESEND 4/6] iommu/riscv: support nested iommu for
 getting iommu hardware information
Message-ID: <20240507145456.GH901876@ziepe.ca>
References: <20240507142600.23844-1-zong.li@sifive.com>
 <20240507142600.23844-5-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507142600.23844-5-zong.li@sifive.com>

On Tue, May 07, 2024 at 10:25:58PM +0800, Zong Li wrote:
> +{
> +	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> +	struct iommu_hw_info_riscv_iommu *info;
> +
> +	if (!iommu)
> +		return ERR_PTR(-ENODEV);

This is not possible, don't include impossible checks like this.

> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return ERR_PTR(-ENOMEM);
> +
> +	info->capability = iommu->caps;
> +	info->fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
> +
> +	*length = sizeof(*info);
> +	*type = IOMMU_HW_INFO_TYPE_RISCV_IOMMU;
> +
> +	return info;
> +}
> +
>  static int riscv_iommu_device_domain_type(struct device *dev)
>  {
>  	return 0;
> @@ -1560,6 +1582,7 @@ static void riscv_iommu_release_device(struct device *dev)
>  static const struct iommu_ops riscv_iommu_ops = {
>  	.pgsize_bitmap = SZ_4K,
>  	.of_xlate = riscv_iommu_of_xlate,
> +	.hw_info = riscv_iommu_hw_info,
>  	.identity_domain = &riscv_iommu_identity_domain,
>  	.blocked_domain = &riscv_iommu_blocking_domain,
>  	.release_domain = &riscv_iommu_blocking_domain,
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 1dfeaa2e649e..ec9aafd7d373 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -475,15 +475,28 @@ struct iommu_hw_info_vtd {
>  	__aligned_u64 ecap_reg;
>  };
>  
> +/**
> + * struct iommu_hw_info_riscv_iommu - RISCV IOMMU hardware information
> + *
> + * @capability: Value of RISC-V IOMMU capability register
> + * @fctl: Value of RISC-V IOMMU feature control register
> + */

Please call out explictly what spec these values come from.

> +struct iommu_hw_info_riscv_iommu {
> +	__aligned_u64 capability;
> +	__u32 fctl;
> +};

Add explicit padding here

Jason
