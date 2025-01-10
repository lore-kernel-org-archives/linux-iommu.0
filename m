Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB5C1E25F4
	for <iommu@lists.linux.dev>; Fri, 10 Jan 2025 02:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736477084; cv=none; b=mBHL3ZTCHQRnFQbzcOM26SkDYwJT8Mxne7Ara46GRewih4AlZj3+HWBXjoq6MYisooP0b91U6FgJx7+cl3rpYB/iA8QkHzvG2aPEWRbGP4y6DtGC3lx4TnkAz4Oc6z0td/VJUXEAMCIbM2riF3yoonXrtfIow32tCPLOf27I42g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736477084; c=relaxed/simple;
	bh=eS7RPQ1wnvL/oz6gufh0aPl84/nlAfGY1bzJhG4z7+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTBdwOmaXPtTOnsJtK+oxoejopmuRJJ7mZ/uZefUeLQCTU5PzuJ+leW18zMMJRg9YtaJQp+058nnUMbKhsYUWXur7gk66obmXyRgIRuQdHhld0qoFUWZD3X6buRdJy58Xp3vKmvV+OZDOTomXMBPstUmR7odg4XAhE4t9YPp2GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mpLcGj2g; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mpLcGj2g"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21649a7bcdcso25020555ad.1
        for <iommu@lists.linux.dev>; Thu, 09 Jan 2025 18:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736477082; x=1737081882; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=caWTBlewbD0QAQDMzRt4/otJEJ5C2eutlx7bRA+hads=;
        b=mpLcGj2gmvOXbyFxgXHoU/r1LYkPqTToLrMjZQIixuWuzKi+wzy6t9D7lPX6uX0yDC
         fzqnCCKLGMU5D8ILTACAf0Avvk7VSsb7sIF19XRxEgZDOmEmriZfFYOVwcPRSH/FaihL
         f60JfKWpafXXdOwGkt4lg64CgLuTUThiaV0VFwlrcSGxwYpuYQbOeGVo/FFD6nPXViT3
         TEWXeInhSx2aDhTJjBml5Z77Uc5YT1iWwjqwbL1finxKvT1GrUNSvMW3CmT+ccX6lFtD
         AYSLkLmvFhC4/BT/y4/4rkcK8jCq6lso1yXthyjbc9V2myL5xiWkxOEqoIgjTf2k6ngJ
         J10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736477082; x=1737081882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caWTBlewbD0QAQDMzRt4/otJEJ5C2eutlx7bRA+hads=;
        b=qABbZ7pvTt9CN0mYOjX8CNmJHOt8O5jPezRXxhjNzxOafYW5ZTALxWWlCiqVF30TzT
         5loUjqwLLhRDNbsyPJ/I0a7AdNpM0m/fFXcpiKki/geukCc+wANBTMHd1jqk1vULCFDR
         Tk1ImUF5GmXvn6RrPe6kjDSHWsy9mUfLnRnQVPX6UVtIIUvPETjcAsevBwYBmSPSTuAc
         +hqn5kTfXSxsSuKI3op5S/rZvKwa2F7cM/KnHDvoDnMqEEedwbyOJVj/l8OBtjQS2uuj
         Tel6LGRL2TIfomas789T4uzGmHXUJM18Oikr1Jn9dIOFH4Em9XeT5PQuqb4L8ZKJyjrx
         ldFA==
X-Forwarded-Encrypted: i=1; AJvYcCU8IP4UQ6XB9I/POYTBTZeqjLi9zaLqM4b0h3NXv+LGE7m08JBNEP/bjS0xZXz0WyseDVYbjw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyaOUH/I4N9+rpl6l8aBhb4il/p8IByr1JXEPKse8jj6Z+4KNm5
	yVEDahi1eGevlsis0Ke5TOrdTflP101rWuQbNbZJieUu+XDjr16kFMDmdlZF0tw=
X-Gm-Gg: ASbGncuNiNZvgI/Ud0Np3C0oYs4X8JU0DtfmF1GkBp/q/0RxzvCz3GFlrNm/JnORBps
	sqAEM4ni5tzn06MEArwasj8CxCGznL+rB0UwSLs+ErBxpOSIXGHZNpt99K/pZPLKC5VxROF7igd
	joai77xn+CedpR/IAal/nrAGEvUvspjXZR3BEW7Cnyp4D4azsudRnqSvQ0DBc9sy6iKyRcY1DuN
	S2o7mqEW8dFWEcwXpOBD/qeowIGcwDdMiTKQdBYDSwdyxk75j85
X-Google-Smtp-Source: AGHT+IFlRtu6l5mEzMt1KG7rnqNGqfPFXArBqJ0XQuS/Gm9ftFlurHOHzbdJUCjSRTmC9tm9lxKH6Q==
X-Received: by 2002:a05:6a21:168e:b0:1e0:ce71:48e0 with SMTP id adf61e73a8af0-1e88d2f69d8mr13896318637.39.1736477081989;
        Thu, 09 Jan 2025 18:44:41 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:691c:638a:ff10:3765])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d405491b8sm535145b3a.9.2025.01.09.18.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 18:44:41 -0800 (PST)
Date: Thu, 9 Jan 2025 18:44:39 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: guoren@kernel.org
Cc: tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	baolu.lu@linux.intel.com, zong.li@sifive.com, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] iommu/riscv: Fixup compile warning
Message-ID: <Z4CJl264jMZAIogB@ghost>
References: <20250103024616.3359159-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103024616.3359159-1-guoren@kernel.org>

On Thu, Jan 02, 2025 at 09:46:16PM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> When __BITS_PER_LONG == 32, size_t is defined as unsigned int rather
> than unsigned long. Therefore, we should use size_t to avoid
> type-checking errors.
> 
> Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>  drivers/iommu/riscv/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 8a05def774bd..38d381164385 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1270,7 +1270,7 @@ static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
>  					    dma_addr_t iova)
>  {
>  	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
> -	unsigned long pte_size;
> +	size_t pte_size;

riscv_iommu_pte_fetch() expects size_t so even though ILP32 isn't
currently supported in the kernel, this change makes sense.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

>  	unsigned long *ptr;
>  
>  	ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
> -- 
> 2.40.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
