Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D1D485CF2
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787847219; cv=none; b=UKj4VjAM5wVG7b3mIIs1anxlKWMt7rO3HP6OSktiiTwp4GpD99Y1ovbtFmStWsYCdtHx5LP8JQDY1ry3JZ15K/pUMfCjlyosAD78DOLG+Bh5HhwqHUYw2x8Jwwm7dmwoHanHuJvh0x5bjmDfeHqdXdthtoZA/Nu4/D5JFByXQKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787847219; c=relaxed/simple;
	bh=bx+2naZFdnhjt6S+TMgqnenLDbHBUf/nrxWuetiOMy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWpPhIlUy/pQ4uceQmCsyafHFoZs40dvdBr0kA7SjRiyea8c786muXWXgcuPrXiZJNwWUshwP0W+12DWO3Cdhl8XogtNoabrSAGgProE2Vci0jy9j32nwWbHSJ/iBvt76hkTzdx7c44wE607R8w6SWUNAu6ZIyRcQHtLsAeiACI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jsx6v17l; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jsx6v17l"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-498012a61f6so65185e9.0
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 09:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787847214; x=1788452014; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OV8Y/HaLC8KyPS9TxMbjvJn1COqqS+9kygpPRaWTQ3s=;
        b=jsx6v17lkAqi3Cnvs26SAfmTnZZpFd38YebrUITJdKRbScq/uE72n683ZvE7oXaWQw
         0kdVzfhYELjH7nLGwNNsfvnbNP/bJKvoplug/iX+ogp2KYKN8JVOfxgrhrI/8UoPFYit
         CpQ1m/3u7/YMO/xoviyCLI9bg9dbrESQmMlx26D43s6vADCvSPMGsDrZrNzOD0yY3rgD
         VFuPeER+fnE6Gz4d25ITuAnl4GAe0amo9F5yVGpNxxODrr1JwILOA/D4L2WYSmx4R9VE
         ybbsjPkC1LG1tRmSH0FADwZ2baNRqb5UlGLrmE72/KHP4ZgkOGBkJFHgLb5Sy+Cdzx6X
         6bhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787847214; x=1788452014;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OV8Y/HaLC8KyPS9TxMbjvJn1COqqS+9kygpPRaWTQ3s=;
        b=GB8B7VzwQiJSaZYaYCCm/kIi5EWVxv5ot7gq1iSdoIF8Y7xCGI7UaMlz1xY1Fg5/ST
         8zOfmAA/AAemYXPgD9T0Rf9Pa4HMv+dnQN0DdATHrJ+QbmVT7mDiEP4hV+NKF9eEeP4C
         QzoOgNnCiZFlUGcY4NeLIxKjSlCOZS/tsWHg35kbssX5ZDKMe3QUxE1vPm6mDHhob2p+
         xYtki5oTHGHX76u4xUDlixPnUtTujhrRpaQYIuB7eQH/DLcBp/MRsmyF/PXdNyqmCc2Z
         3uxztrp0fB+Z96XD9n29KnIKytEr9mIGLIBpgWPVZBbvoILPoHc+O39D5ijgCeOEf6De
         R8IA==
X-Forwarded-Encrypted: i=1; AHgh+Ro20G2zkCMe0PwVvxvKqErjZ3kbh1F33W5OUSPxsYRXBe/u8CiXrqNiAMMjMGMYbaNLfrb1Gg==@lists.linux.dev
X-Gm-Message-State: AFuF++lt2CIaTKwjuEQ68WEry1hQaFsTyM7EsmpJmeVYG3R2iff3qEYI
	o3QupwdVc7obYEmqPzxlHsuSp5bWBoURtmpE5afwAqULUNVNcG8sD5eYaLBJr5/WTA==
X-Gm-Gg: AR+sD119/S+W9PHtHzq7G+dpfTFshI/BFXTxp3x/tgcbTnhXMKROXyRx1OjnnouPt21
	yX4WSQa8m8d9gGO/vt62+C8Uf1yyv0DXLQ5Vt3hBvpyyRGaobq9ZNL2VTCeg7wYRGUVM6GBuZ4Z
	mLGv0VJ4wWAshY2CdhcRDHCu0RMIIt7QUhtAuFP8at0mvZiMGMxE6WDO76zpHgi4CFib7u1Cva4
	HB0waeE0RibTlk3xFbpxWq4S12HBsJZ3VbPqklSk07wKB+JT4pYJ+VkAv/i2oetIVSoLl3OubQT
	kvcLDgDNtkoktrgp0dB/lKgbhl5xQRYplHAcOGykoRI/GVz0MFOT6t3Ms+mtsCXKJVD7l+SL3e1
	7JOWT5dUgTbs715ycyFEJTQj2/Zh2brCfaRL8NJUMNDT6U0/rBooh/K3o1QWk2qOehTp0tuH+xB
	5qJyqE7sQuhJcbWmpRLdUR4nws2uZ15dmv/5KmRnxOxeHl8dqdc49Q45FmVph5Cfn5UgQ+CzNG4
	aOt/X9PkMSvEVbJUIFX5yEg+HLEVeQ=
X-Received: by 2002:a05:600c:1c10:b0:49b:8f5e:51f6 with SMTP id 5b1f17b1804b1-49b8f5e52bemr713255e9.3.1787847214097;
        Thu, 27 Aug 2026 09:13:34 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4af00fd2sm57749665e9.12.2026.08.27.09.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:13:33 -0700 (PDT)
Date: Thu, 27 Aug 2026 16:13:26 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Yuanhe Shu <xiangzao@linux.alibaba.com>
Cc: joro@8bytes.org, will@kernel.org, jgg@ziepe.ca, robin.murphy@arm.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com, praan@google.com,
	skhawaja@google.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu: Add __iommu_debug_unmap_phys() to drop refs
 by physical address
Message-ID: <apBiJk_zhaNjW0er@google.com>
References: <20260827145855.1616223-1-xiangzao@linux.alibaba.com>
 <20260827145855.1616223-2-xiangzao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827145855.1616223-2-xiangzao@linux.alibaba.com>

On Thu, Aug 27, 2026 at 10:58:54PM +0800, Yuanhe Shu wrote:
> The IOMMU_DEBUG_PAGEALLOC sanitizer takes a reference on each page at
> iommu_map() time, keyed by physical address, and the only way to drop
> them is the IOVA based iommu_debug_unmap_begin()/end().  A path that
> tears down a page table with mappings still installed has no IOVA to
> unmap with, so add a physical address based counterpart of
> __iommu_debug_map() for those paths, sharing the counting loop through
> __iommu_debug_update_phys().

But the IOVA can be calculated when walking the table from freeing
context or am I missing something?

Thanks,
Mostafa

> 
> Export the iommu_debug_initialized static key, as the generic_pt format
> code using these helpers can be built as a module.
> 
> Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
> ---
> Build tested as built-in and as a module (AMD_IOMMU=n,
> CONFIG_IOMMU_PT_AMDV1=m).
> 
>  drivers/iommu/iommu-debug-pagealloc.c | 30 ++++++++++++++++++++++++---
>  drivers/iommu/iommu-priv.h            | 24 +++++++++++++++++++++
>  2 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
> index 80164df5bab1..a2e55164e6a4 100644
> --- a/drivers/iommu/iommu-debug-pagealloc.c
> +++ b/drivers/iommu/iommu-debug-pagealloc.c
> @@ -15,6 +15,8 @@
>  
>  static bool needed;
>  DEFINE_STATIC_KEY_FALSE(iommu_debug_initialized);
> +/* The generic_pt format code using the key can be built as a module */
> +EXPORT_SYMBOL_GPL(iommu_debug_initialized);
>  
>  struct iommu_debug_metadata {
>  	atomic_t ref;
> @@ -96,7 +98,8 @@ void __iommu_debug_check_unmapped(const struct page *page, int numpages)
>  	}
>  }
>  
> -void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
> +static void __iommu_debug_update_phys(struct iommu_domain *domain,
> +				      phys_addr_t phys, size_t size, bool inc)
>  {
>  	size_t off, end;
>  	size_t page_size = iommu_debug_page_size(domain);
> @@ -104,9 +107,30 @@ void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t siz
>  	if (WARN_ON(!phys || check_add_overflow(phys, size, &end)))
>  		return;
>  
> -	for (off = 0 ; off < size ; off += page_size)
> -		iommu_debug_inc_page(phys + off);
> +	for (off = 0 ; off < size ; off += page_size) {
> +		if (inc)
> +			iommu_debug_inc_page(phys + off);
> +		else
> +			iommu_debug_dec_page(phys + off);
> +	}
> +}
> +
> +void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
> +{
> +	__iommu_debug_update_phys(domain, phys, size, true);
> +}
> +
> +/*
> + * Physical address counterpart of __iommu_debug_map(), for teardown paths
> + * that destroy mapped entries without an IOVA.  The OAs must have been
> + * accounted by a prior iommu_map().
> + */
> +void __iommu_debug_unmap_phys(struct iommu_domain *domain, phys_addr_t phys,
> +			      size_t size)
> +{
> +	__iommu_debug_update_phys(domain, phys, size, false);
>  }
> +EXPORT_SYMBOL_GPL(__iommu_debug_unmap_phys);
>  
>  static void __iommu_debug_update_iova(struct iommu_domain *domain,
>  				      unsigned long iova, size_t size, bool inc)
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index aaffad5854fc..12528a40bcd8 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -71,11 +71,18 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
>  
>  void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys,
>  		       size_t size);
> +void __iommu_debug_unmap_phys(struct iommu_domain *domain, phys_addr_t phys,
> +			      size_t size);
>  void __iommu_debug_unmap_begin(struct iommu_domain *domain,
>  			       unsigned long iova, size_t size);
>  void __iommu_debug_unmap_end(struct iommu_domain *domain,
>  			     unsigned long iova, size_t size, size_t unmapped);
>  
> +static inline bool iommu_debug_pagealloc_enabled(void)
> +{
> +	return static_branch_unlikely(&iommu_debug_initialized);
> +}
> +
>  static inline void iommu_debug_map(struct iommu_domain *domain,
>  				   phys_addr_t phys, size_t size)
>  {
> @@ -83,6 +90,13 @@ static inline void iommu_debug_map(struct iommu_domain *domain,
>  		__iommu_debug_map(domain, phys, size);
>  }
>  
> +static inline void iommu_debug_unmap_phys(struct iommu_domain *domain,
> +					  phys_addr_t phys, size_t size)
> +{
> +	if (static_branch_unlikely(&iommu_debug_initialized))
> +		__iommu_debug_unmap_phys(domain, phys, size);
> +}
> +
>  static inline void iommu_debug_unmap_begin(struct iommu_domain *domain,
>  					   unsigned long iova, size_t size)
>  {
> @@ -101,11 +115,21 @@ static inline void iommu_debug_unmap_end(struct iommu_domain *domain,
>  void iommu_debug_init(void);
>  
>  #else
> +static inline bool iommu_debug_pagealloc_enabled(void)
> +{
> +	return false;
> +}
> +
>  static inline void iommu_debug_map(struct iommu_domain *domain,
>  				   phys_addr_t phys, size_t size)
>  {
>  }
>  
> +static inline void iommu_debug_unmap_phys(struct iommu_domain *domain,
> +					  phys_addr_t phys, size_t size)
> +{
> +}
> +
>  static inline void iommu_debug_unmap_begin(struct iommu_domain *domain,
>  					   unsigned long iova, size_t size)
>  {
> -- 
> 2.43.5
> 
