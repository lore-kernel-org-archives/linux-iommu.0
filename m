Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989E0225771
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496765; cv=none; b=jgKTqHWQ+rqFdF1gQx6a5OVm9qE03OBm8RFgedZyi/lOPKvGNTYYOjf8TbDAkhMWvFW1EusxkMSwGuGBd47Isd3LIOW43FhgPl7FVXt6hN6QtNdnWqAlB6AVVMDdIE45kKOfnk+A5jj1NQ/0VXN97+yKcXVurVi2eSLafdoV1ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496765; c=relaxed/simple;
	bh=TnP+vFs7IXRlmpvE3Fk2ALLQD/fNY7FOCcgBNk0jD4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUmA2+bkKDEzOId1QGcd2yf5fub+QQOLRWv56zAiot5clXmHfI3OlEUYzlkGBIsn/PPo3rvq177sI3HRtMHiii0bopi/c3+fw+cLqUBMmXuYeD2sbLaOgAfPxByzr6DWRFfQT6+bcrP10/NX3w89DBZT8XixzGQj4OM8xbAlXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daHGGvxi; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daHGGvxi"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45617887276so8644035e9.2
        for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 05:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752496762; x=1753101562; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hu7d6TzejWOVv1PWLxvsbY8Bo8x9azrAfli/oRpw5r0=;
        b=daHGGvxiTAlpcIyPRrN/w3xvfrF46vSuqdWHcS8Bus8weMYh+x6B+A5XUfKDPODREO
         TW9it2CGZxgD/ZGkBBCqsxSaImBhoKAlTExUnDN04xvbu2rSPCil028tJaEMrbOw65+G
         OofAV6Lkf07TZWNYk3xTIj53L4KtGRwbiJT14TpszOslWNSgqzTB9Xi1eTWFOLhiCOKZ
         8sxi7LbMBMK/pSjxQcrqb5zRyrqQKJWv8AuPy4nreNyUfq5iuU8YCfKhld7QRR7bAmUg
         k+sLQM06furjmRs14l4Tjt0GhGlIOGzM1KvcZ8PvhkTyLLlwpwevTARTUkNDZeXzvcr+
         hLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752496762; x=1753101562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hu7d6TzejWOVv1PWLxvsbY8Bo8x9azrAfli/oRpw5r0=;
        b=azNOP3U0nBsH0oL2jvtQQ3CzzcJhO9VpwLpHUO9e0DT4HhIDHyNygiiRcRymE6gZn9
         PTgWnJ9I84ibsHSNXOZyzCCWB60PxcHAFoeThjT7HRUWkIPUZI+SnRoZBkVtLnuay8G1
         WCG+l7BUC3IYTFoLhkrId1Msf7EBgHj2bWVcvqVvCiyaALBqm92u54em8DZCbzEVugBM
         NoCfpc41G3iZnCtxlH8YIgdUhS4tWB7FZGdLLgAKcbk53I8oH8U1mUTCjTMJ1xsmgGkD
         PJ7PFVuY9h3HH2w7yrpj1VQWjiojQoCulgTX95Jdv+XI4vkOH8bJtqvmHeKtjrVSLEIS
         iOwg==
X-Forwarded-Encrypted: i=1; AJvYcCXR2GppZ7XNZRjqFckhOwYKN0Y/JhzvSri+Rg0u9Jh0gu3nJG2BiLmQkaGQV9Rrdqg6cb3kGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxY9TDI6vLm5Gnc27QTITSfRni8ajkQfgQyLd3RGgHsc7Tco1bd
	qnxalCmgiTk0G2yd+hiswlec/Tq6G0oMMsqXbpvVRdL+LwKcxzX3iJ+w
X-Gm-Gg: ASbGncuwPdM2UJ0Oc4feDaNtsLHiUtMZLXMagW3vR2XfoAFQTSZQ+/lx0ThH5lGbuFB
	kWo9T2pDOajk15QM9di825P2Y3ub13Y43HYUVKSaHGcGcFJkzxy3F3cs3ebCOcDAM65MMG0Fgso
	tfXdAWT0Akf74o+K3dlgj3F2cmQGbucXkcLYpNu0X1EENJQxYrAyYWkD9QguTyf3nPPdK6EKrye
	pPmvBMSqZ7C2ALKV2M7xyWpQIWKaX3Q5yyNdfyzzcUO6g+diyAajyZvSkI3O/FIbGnG2vjkKqVN
	QZztQzKlgjbz6TrrNUw/TWSZ8ppCTs1TIfbOi/1J6HDTjdIL9dALlnrwpMwL3eyrGUEyDbV7qkK
	KvMt/61yzHaGkYvaeAaZXOQZgXI5FOxeaW/YF0SdKPmYmPOOPKyJ0L62ELJaVVtFLlWSJkZM=
X-Google-Smtp-Source: AGHT+IGYYRHzkc0tCtHZgZ1HBPkUbfByAJiZ46m1oEz+lW6gbL5TanX3NgxDe/beQeMjz+LASAM6nw==
X-Received: by 2002:a05:6000:5c2:b0:3a5:2b1d:7889 with SMTP id ffacd0b85a97d-3b5f2e26c9cmr9474793f8f.43.1752496761755;
        Mon, 14 Jul 2025 05:39:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e2710bsm12288225f8f.99.2025.07.14.05.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 05:39:21 -0700 (PDT)
Date: Mon, 14 Jul 2025 13:39:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: jacob.pan@linux.microsoft.com, Jason Gunthorpe <jgg@nvidia.com>, Lu
 Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kevin Tian
 <kevin.tian@intel.com>, Jann Horn <jannh@google.com>, Vasant Hegde
 <vasant.hegde@amd.com>, Alistair Popple <apopple@nvidia.com>, Peter
 Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Andy Lutomirski
 <luto@kernel.org>, iommu@lists.linux.dev, security@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
Message-ID: <20250714133920.55fde0f5@pumpkin>
In-Reply-To: <42c500b8-6ffb-4793-85c0-d3fbae0116f1@intel.com>
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
	<20250709085158.0f050630@DESKTOP-0403QTC.>
	<20250709162724.GE1599700@nvidia.com>
	<20250709111527.5ba9bc31@DESKTOP-0403QTC.>
	<42c500b8-6ffb-4793-85c0-d3fbae0116f1@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Jul 2025 11:22:34 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 7/9/25 11:15, Jacob Pan wrote:
> >>> Is there a use case where a SVA user can access kernel memory in the
> >>> first place?    
> >> No. It should be fully blocked.
> >>  
> > Then I don't understand what is the "vulnerability condition" being
> > addressed here. We are talking about KVA range here.  
> 
> SVA users can't access kernel memory, but they can compel walks of
> kernel page tables, which the IOMMU caches. The trouble starts if the
> kernel happens to free that page table page and the IOMMU is using the
> cache after the page is freed.
> 
> That was covered in the changelog, but I guess it could be made a bit
> more succinct.
> 

Is it worth just never freeing the page tables used for vmalloc() memory?
After all they are likely to be reallocated again.

That (should) only require IOMMU invalidate for pages that are actually
used for io.

	David
