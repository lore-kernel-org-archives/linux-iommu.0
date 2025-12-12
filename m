Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0D131B118
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553871; cv=none; b=UI+sC/g13jYHT+RN2ZkOgFb27oj+mYNFoHUfTUb2XW9PS+Sbgm0qiIxxnS4o3zrj15zi+N/bhCh9M5xoe1nXPGD9FiF5ORm9A7D9TTUx2NbiPzJMEq4jWUDHe0h+HqH5QK26dtYOe/FisBRr1v8uwKJX/9X3SzFQgg+jsWlGc14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553871; c=relaxed/simple;
	bh=vCxTVQ2cbqhlx8SAakkeafvVNMeYr9pSGx92r+SIXhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRe/DPpYGaq5/u8vckNJXGhJ/NyBngQ/KRPTs2T0ZX34BzMzUxPSN900TTTnuxVbi9unPJMiQlkFM84UboI97nHaBFLOMhfERgLdEX6oCupRK4JsH6cjw8kxzH2wOrpW7ENjJPGHJpkDBGQLZUzseISCedVKRfJ46Wmk6E121OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kLrlSeES; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kLrlSeES"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477a1c8cc47so168465e9.0
        for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 07:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765553868; x=1766158668; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t8RokAtosDkKW20ZPmF7jI+1D1J1h8RY8U91CVgDMOA=;
        b=kLrlSeESNt6y/x3tGfjOaaAp9Zoz0lKzcU6jY8SkC/emgn+Xzp5WRiHnpyQDvFgHZS
         Z09UJ0fOlpQABp2v6ZNfJkWoLojGQg7dfetmBImmGjmofYRGBLlonFZNsMwdInWmUSm0
         iCJkBvwV8erv7S15nn+yL1Fg7YHYPj5UEKuIxyeHNhITxMpPbboK8/LGObumzvfW+hnG
         wIi+8s+uBK6C0AsO7QgimRXGGJQtHDjoCseqCFsJsHld7+ge4Lw1kgybWiZ+HSHkLjWn
         ZjlQzAK7YbewghcWoLxIbuKo6Nk6Fhc0z1Qanu6v9p0XHcAE85/SDkPEbyMeZfrARb4I
         jqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765553868; x=1766158668;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8RokAtosDkKW20ZPmF7jI+1D1J1h8RY8U91CVgDMOA=;
        b=X+vUGmaFKmJ2mlsrol4C5OS93Qdx/HuphCP12Q8cYDhNFuYM0EQMD0f9qYejFKtgk6
         6QXukb8DxQwgYtfALT9EOMQySlre80Ijc04Txl8iYTyI0j0f9jC3Lqb95UqmLRl1e1g3
         z20MAnInVQAYI3qOx196a6PoILUrh0msRGlTVmshSNzLxLrGOzdzHbvUkshN36H7vipd
         pefMwlpdUjG8+brJ1320owaQIVXaOlevPg2mfSZ9X6TRXNRH+PGJwnYSWS/D1bjcK9Xo
         sF04tw1QABMqzXO/LJHQRVPgrQ29e59a8EqcSyzd+h84N0X8ZCGx/+UmzQwgPNLYeU81
         Eltg==
X-Forwarded-Encrypted: i=1; AJvYcCVL83qKpBEQ9lOIMzdB70GcQ1nwAv8sXhpwvRdL/dwy85lnC49JQNlhV8rGCET47xmjr3apZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOvNYHkeN/fIYbA9joC6X7sRAT/7xoj/1qStYdeBFOFZ/qbLec
	Yc7Dg7sXgxbSJsde5omV5q7suQ3N6dTre7KsbzaZAL8aHleFhK+FsqzdBDgzZewp6A==
X-Gm-Gg: AY/fxX7cB3EaB8o1Jr1BnA7yI+Bs1S1W9R/RUnWhqm4spQAUyBe4JDytA4MnIT/xDsn
	BeOx8H1bKyekismsGGtmgln2gvAj20WmUZeSOPIBw1Yt0C20nqYlg2CkjhcP9yEZXHeGnOFwe7x
	r7snuUYG3OnL0gVfuTEdYh7swyXSOISeraMYGOtdFW2+oegtbBLnQzIy/7Biq3c4/GP70IVb22J
	4VDTDhfuIv4sz94i6ZYRdQjTSogVLchB6CzCvzaMkaMeG44Xrrq3KRMSQoGfpwvDpftBMXqlAh2
	CMIPOCqaC02BRukbCDZztilOaZBczgwSaIkvcZFFpQlx7PC+Hh7zGEpuayTKwL2W6eChvd2fDrA
	rrmSL639MmKscHSg44x3XOX1+GQnAFGSNy7ITM6mQHCFU4+kQ41v9VhlYiurt0KydW2ngksckSf
	3RyjuqyUMNZ6KPgiZcnDDMHth6l7tBYlyd5hedYnRPPdTiAkEOyg==
X-Google-Smtp-Source: AGHT+IFXfc3AC76G1YFLQm1Se+be8N8XTO6jICn0jtn4xJXqL4zg2CykiJrG0pTcXZHbluGygYoeaA==
X-Received: by 2002:a05:600c:4f16:b0:477:974e:2b34 with SMTP id 5b1f17b1804b1-47a88c6d52amr1996775e9.16.1765553867672;
        Fri, 12 Dec 2025 07:37:47 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b8a97esm15306057f8f.31.2025.12.12.07.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:37:46 -0800 (PST)
Date: Fri, 12 Dec 2025 15:37:43 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	praan@google.com, danielmentz@google.com, mark.rutland@arm.com,
	qperret@google.com, tabba@google.com
Subject: Re: [PATCH v5 04/27] iommu/io-pgtable-arm: Factor kernel specific
 code out
Message-ID: <aTw2x1UlldJGVA4Y@google.com>
References: <20251117184815.1027271-1-smostafa@google.com>
 <20251117184815.1027271-5-smostafa@google.com>
 <20251128164541.GA812105@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251128164541.GA812105@ziepe.ca>

On Fri, Nov 28, 2025 at 12:45:41PM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 17, 2025 at 06:47:51PM +0000, Mostafa Saleh wrote:
> > Some of the used APIs are only part of the kernel and are not
> > available in the hypervisor, factor those out:
> > - alloc/free memory
> 
> Why not provide the iommu-pages API for the hypervisor environment?
> 
> Same for virt_to_phys, that could be moved into an iommu-pages wrapper
> too..

I guess that's possible, but then we would have to stub dma_map/unmap,
which might a bit ugly. I will look more into it.

> 
> I want to change other parts of the driver to use iommu-pages in the
> long run as well, so putting the abstraction there is probably more
> valuable than this.
> 
> Also the genericpt stuff is merged, should you (eventually?) be making
> a pKVM hypervisor specific set of page table functions? Eg if all you
> are doing is mirroring the host stage 2 I think you can build
> something much more efficient...

Most of the code is re-used from the io-pgtable-arm, so when that is
converted to genericpt, it should get to the hypervisor also.
The only hypervisor specific logic is the memory allocation, virt/phys
conversion and CMOs, I can look more into painting those, we don’t have
to change much.

I have some plans to add support for sharing the CPU stage-2 page table,
which is going to be complicated as it requires changes to the core
hypervisor hyp/pgtable.c code, which will be in a subsequent series.
However, I reckon that we would keep the shadowing logic as not all
SMMUv3/platforms are capable of sharing page tables.

Thanks,
Mostafa

> 
> Jason
> 
