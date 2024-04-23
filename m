Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFBF13D638
	for <iommu@lists.linux.dev>; Tue, 23 Apr 2024 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891643; cv=none; b=rTY4mwEmXpB9GyqQT87lf6PlZpD1o6Gb4gBgIQfw7YiN02SeBUFVUv6AjVyOqWjmIIAsTTDU8MfZb42ACVjCKDOUr6DSHSc5hp7e7JBOgm2ze3/AJpMHv4R7NEEqMMLUOflOyFZuxOwvtWXiT1fYW2QXQDm/gwVwmEDmxhN57YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891643; c=relaxed/simple;
	bh=koJE8orB6Lr920KYY5A47CTkKeZrCUS3/cmdeXdfgCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeHfDym3G+ofELL7VzB2RDOOjojpB3BTJVnqp5kJMB4dj5bw7fqIyo7VtFDX2Zgz4QoURIisVtkRy7pDAk+l865qZL9pSSkdrh6WZ4KPFIrGLuWW5ejlIFoinHU9vg1IaWY9KPCEPpjsdsiGGi/StId/CCFiexHLDdVekycXB+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OJNft3a3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OJNft3a3"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a58872905b5so56881566b.2
        for <iommu@lists.linux.dev>; Tue, 23 Apr 2024 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713891641; x=1714496441; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7kpoRkSgmIbeAMxE5jSosiKeK58hdGccskOzXdueAwo=;
        b=OJNft3a3HhnE9Dz9ZzliW3y7ddZ6j5l8dveMGsCqY6KG0Kb8FcffrIyhQmvh7Ex3GI
         UTxJIuTfXLvt23k8Njr5KbfLJI1IxC2oF/M+byQcFVKHGWVgDpbbNXhx1pbdWaXpopo0
         8uCtInDb/L8Ae7UWYYEP9TZSb7Rrm/g4jtNqTKdxb1+IE27/gY6HTxNlT0x52okR52XA
         Xa2WGVdC9Y5YM4HgENg+ga4WrApQendiljf67pnlttFbYPDQe4QL7mS42ab6jBVVBhiB
         aaxwFL4oK0q3aD81St1+M9LzCmIAEgbyCQCHYEi6QFRtlN0ZEIVNtKLN3poolQcC9WAF
         QVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891641; x=1714496441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kpoRkSgmIbeAMxE5jSosiKeK58hdGccskOzXdueAwo=;
        b=pPX7WYiqJANgcJmsmuN7R3BAEwCO7Pky5tii+r3Q5ohHxL0p+PS7/z4DFzOEZpXeC6
         W/3t837Si4+WzbdcE2twR+by+BHowamDIAiPEvNLi/O4CXqCQdTea9iH54GNPGLsI+KZ
         FU1yEqdFr3fKm7pmc4bzauGpWtPG/Niq9JjnWP2yC4Ow12JIQc9eZYJVHTfLGCldPtsx
         D7ecvSDs3YGHPLgDKDE4obCCmrfmslkat5qMY6iwjpNXRJ/lGZj25mOw2hpcHE/ESfQH
         gJvgtJzOnHkDzgdvx6BXQpXjtOOoYJs59I3m7xbtj7spxtPFAuNYPI9cCAOyyYNbB+C+
         o3ow==
X-Forwarded-Encrypted: i=1; AJvYcCVIHBiKPtxlLnm8P+qHD23UVrD9VLOsj4AqIbgBrN7U2O+dcmO8jKNKMr0UqvAw8ZRTS2mJIvQdz9CfIbCCrqwlekE0DEQ=
X-Gm-Message-State: AOJu0YxdaremiZFcmiCIL3twbqhWSqxiwORQzXtfn5ECuUnDaT4P4xrW
	QkRJ+CbLKUBkjgRBOiLBIsm/OAaHyykNOa+JX4il1NVjmNr7pyFs2Ujs65U++Mc=
X-Google-Smtp-Source: AGHT+IGcGANkzjcqPRS58akjvbDATplTwj1qOXK/GFOuWc3MEiIWZm4cD/e4azAjA7fogSoeRMZxBA==
X-Received: by 2002:a17:906:5857:b0:a52:2772:b9cb with SMTP id h23-20020a170906585700b00a522772b9cbmr8740381ejs.24.1713891640539;
        Tue, 23 Apr 2024 10:00:40 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id z18-20020a170906435200b00a4e657a5f1asm7220478ejm.112.2024.04.23.10.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:00:40 -0700 (PDT)
Date: Tue, 23 Apr 2024 19:00:39 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Anup Patel <apatel@ventanamicro.com>, devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com, linux-kernel@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nick Kossifidis <mick@ics.forth.gr>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 7/7] iommu/riscv: Paging domain support
Message-ID: <20240423-64e0112d612ab1f011c4b26e@orel>
References: <cover.1713456597.git.tjeznach@rivosinc.com>
 <301244bc3ff5da484b46d3fecc931cdad7d2806f.1713456598.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <301244bc3ff5da484b46d3fecc931cdad7d2806f.1713456598.git.tjeznach@rivosinc.com>

On Thu, Apr 18, 2024 at 09:32:25AM -0700, Tomasz Jeznach wrote:
...
> +static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domain,
> +				      unsigned long iova, size_t pgsize, size_t pgcount,
> +				      struct iommu_iotlb_gather *gather)
> +{
> +	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
> +	size_t size = pgcount << __ffs(pgsize);
> +	unsigned long *ptr, old;
> +	size_t unmapped = 0;
> +	size_t pte_size;
> +
> +	while (unmapped < size) {
> +		ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
> +		if (!ptr)
> +			return unmapped;
> +
> +		/* partial unmap is not allowed, fail. */
> +		if (iova & ~(pte_size - 1))
                           ^ Shouldn't this ~ be removed?

> +			return unmapped;
> +
> +		old = READ_ONCE(*ptr);
> +		if (cmpxchg_relaxed(ptr, old, 0) != old)
> +			continue;
> +
> +		iommu_iotlb_gather_add_page(&domain->domain, gather, iova,
> +					    pte_size);
> +
> +		iova += pte_size;
> +		unmapped += pte_size;
> +	}
> +
> +	return unmapped;
> +}
> +

Thanks,
drew
