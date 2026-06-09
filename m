Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809112D47FF
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011608; cv=none; b=Rh3IbREGTneP6OemCA7PsOY//Omu7OFZcgZfMrIIdymjJxgVr39lvAjH9C7ORVDQkV6PVEKHt3GxLvuR770I47d4TiyALLkj2zW2l34SAGK52JEjfSQCXPGGlfOvXJgfwiW69Y7IYLK70w9CGWOh6hUvAY/SP8FU18Jde6CWVuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011608; c=relaxed/simple;
	bh=twwp9hFllxfAH5zTiaxs+mflqhqxD3N7oFJ/LghNab4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ol4RMTz5LXtt7A479T0xLHEdqrM75Z2pf4T0NEL4UIM3Z/ryuN02zVuWb1RXrmQ3fZApFm6wlgdfcK6PTaHrvS8T19mwpx339basbo95xHTdzRkMQpmxv/UifojiIEtSELZyG3AinF6PFZdci+sreVEzdu88hRvF2LXDYtJG6IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XuRXDZ7L; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XuRXDZ7L"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490791a3e92so7709295e9.0
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 06:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781011606; x=1781616406; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Mb3ECCQF4KDrnD1oEZunr+tebvyQKuHVVgCgeE/hK8=;
        b=XuRXDZ7LdWnvnkgIc3avGgSurHiOPkd4dwZnADgOVv1hF530K7EqIfzEQi7QCvEiH7
         XtNmjsxsfuJwJTxNxNuG8y+LuDQy65ZCEZggzt9TPcZCrR+u5uq3KjK7PDWZUj3IpzDg
         EbTfOAgBVGcTanP+lb5/As2jyoDFnQxC3Z+8QteNSYNupnHgL5Shddn/Yqb4hnS797p2
         A1NN76b+7S1oS/MOg8cnHoA91mXASkCFyQZNNQM81ukxqWl/vywztdeGMP57eZoM5Jpm
         wo4o+5WJqO3pwn4FJSPFislvZVxsCzxkP8MfTAKRdYGh4pAdyg8Ix+xzSYhzz32Y8bok
         VZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011606; x=1781616406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Mb3ECCQF4KDrnD1oEZunr+tebvyQKuHVVgCgeE/hK8=;
        b=hD++nJgbZLMzL0NRYTm/72EBUIQrV9i/pW0XhQQLyqA13fT22x6jR8QgFm93uFCEgJ
         NOcXNY4ctwjZhm9AhZsXWUb1Cot14JbbX6JgG3aTQAakL0oimS007T1zFWPVnoYc4SD8
         VyMsmeqDoIkDi6C+TyoNpMTSHVzyIcPYylaNemPuvL145Pz9a9EPMu8cV374GR5cRlXj
         Vp/MKBDSXhdT/9CGAVqEMIzL1ELry9oidFkxxpTniNhJFMoEZbx224k733qFFsLc8VYt
         pB0r0ubYcWXp9+qa/McqJte88h9p0Trc2YiTMHMs0ez46p6l3sJIa4ZV5nSNvHATJdtZ
         h1sQ==
X-Gm-Message-State: AOJu0Yy4Tj8tCUsNA/T+9jX3ES8yqM245j5fS/L8Y6ElPPqWsO4Mb1Pb
	Z9O2Rmf0hk/yD60yVrLetHOKSAv0VHNDUoxSnNJ2fDUu1QqtvTxJKXs1dCIAZJTpWK4=
X-Gm-Gg: Acq92OGZAypOrCBt5HwWxXkKbzD/gzXdEuKU1Qf/A+0DRfVioJs1YJy/Y9vWAGfP+Ay
	kOtN5rjs/2S/MvQvjBjt6aAAFO1S2S8lFOKZNUzjYUloljNPreDBtIJojzdgRig6Rdr1Vr9pgCC
	gCWlV6I+Vnr6xqM4aPaVuthJJcs8DH9me2jArLd1oTRitwfvzW0no69qgzGh94ubHcvd6xpfuEj
	r/WdbxCgKynNCGJpuHf1Rn544/GuP1nXavvyoaimU9b1Pi5nX4+QnA7cedHcAfTFJlaDYIWwhD7
	lpq7UwQ7vqMtyttPOP5f9vKYJAWTgOfsdBD0Hn04fnDYnkxN3UJL0cq3jK5PV7dp4iVYVte8ne+
	9RVR9iZDTnno/53c8KRpZKWJsUM9tq26NCmtRHmh8yHARlb3E1QJDc/8jA9SS9OkJqMDXQZCh0c
	t8du2jV6sU5jGT7uwQGSDVFf0=
X-Received: by 2002:a05:600c:8705:b0:490:3fdd:d344 with SMTP id 5b1f17b1804b1-490c25897eamr150306735e9.1.1781011605912;
        Tue, 09 Jun 2026 06:26:45 -0700 (PDT)
Received: from mordecai ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39def5sm469464095e9.5.2026.06.09.06.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:26:45 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:13:54 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, Robin Murphy
 <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Will
 Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price
 <steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Alexey
 Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
 Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, x86@kernel.org, Michael Kelley
 <mhklinux@outlook.com>
Subject: Re: [PATCH v6 15/20] iommu/dma: Check atomic pool allocation result
 directly
Message-ID: <20260609151354.534bb18d@mordecai>
In-Reply-To: <20260604083959.1265923-16-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-16-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 14:09:54 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> The non-blocking, non-coherent allocation path uses dma_alloc_from_pool(),
> which returns the allocated page and fills cpu_addr only on success.
> 
> Do not rely on cpu_addr to detect allocation failure in this path. Check
> the returned page directly before using it for the IOMMU mapping.
> 
> Fixes: 9420139f516d ("dma-pool: fix coherent pool allocations for IOMMU mappings")
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> ---
>  drivers/iommu/dma-iommu.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 725c7adb0a8d..52c599f4472c 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1671,13 +1671,16 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>  	}
>  
>  	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> -	    !gfpflags_allow_blocking(gfp) && !coherent)
> +	    !gfpflags_allow_blocking(gfp) && !coherent) {
>  		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
>  					   gfp, attrs, NULL);
> -	else
> +		if (!page)
> +			return NULL;
> +	} else {
>  		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
> -	if (!cpu_addr)
> -		return NULL;
> +		if (!cpu_addr)
> +			return NULL;
> +	}
>  
>  	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot,
>  			dev->coherent_dma_mask);

