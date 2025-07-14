Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3407248883
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499165; cv=none; b=i9LXNGn1zGfK6GDK/g+MB/aUBXtnfBtSXovCVmWgnxIfx5lTNO0pYkSzByhVztFiISBGGzWQjIJ6rIxRQ4ZKio1kH05T6eVv2nfUYnKO6XkRL6UQ38ZOnxtBPjLeXSsWPI5I2N1w7ZOjKWOpTyyn7HUiwS/ZTtqMMFu4GGb6xIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499165; c=relaxed/simple;
	bh=MEiZe9dT3AcI47jjSXnxopISrbtPuAcEGPjwBbo8RXM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwIf3MVcUA9zX4VCUdW9gOlE4Xqi18C4uoVLwgRId6Ym2paXrsypDs5up4x5aO5xJBPYzwcId8ULd0QAkpV0yrYSlGZOtP29qJr79cV1iHDV7AvtfobyT7LEb2dxXk0Evt5bbF1QR9Xe8VY8MFX90rvNUo7IplFiplfGVjRKV0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akTh0JOt; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akTh0JOt"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-555163cd09aso3354376e87.3
        for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 06:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752499162; x=1753103962; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=78IVLypB20S33j4pHBE/zVDOjkBG6gwwlw+HOaWrG1k=;
        b=akTh0JOtwn10wpLHtI8CczvpGT9k50QkS6DuQ9LGOZPb1Rt6EuH2FrSyaU8fQAadFu
         ZusfY10BhyoGkSJtQ4GOU6ocddUSU/eerOjQrriTkgwpbWMD2jsbKeUaBw2Hmp0UWAf/
         IPB53qf7MfngKFAgEqcKKwTxsFifrv5G1rDgx2/yFVEftC84cKh995GXjCHVvvqQ4WZY
         /29p0tmhBJrPwQwoaJjmrJZGTylZoIZlAxzbuJuYF6O2qssBHLBXvuhR2lVkBfwCcGlz
         6FhmiLu/sHKaKyvqNT9vIc1AWKRTvO0E10dvJ2hMZh+ldUEweJRwY0+QrSRxoEfvKmi8
         463A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752499162; x=1753103962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78IVLypB20S33j4pHBE/zVDOjkBG6gwwlw+HOaWrG1k=;
        b=khIW/itabyadTmt2mu8Rp9eJ4k+/6L+gMWWCVcB4UQmpFhmqCwM8BoiiludULvcYg+
         gNYRwT12mV8Al24FVEGv87ZWHE++a3iUOPLhPYzDiHP3hOoDdXLM2M10CfKYKqdMhKjm
         sSLNh3N+BxmrnBX61Tuo6I9SRDpJyU5yQ6DBJTIzX2GAoWUtdx6gmBPSr2IFVGQKrgHT
         NN3OBn5LhhGWSKwenBEyq3Y7LfFqWeYLV++7YVn+k0gTlJCbKxXJsXbGOEunS1nKu/Uv
         yVIJXt92VvcU7VFrlKtH9AF8vmND+xHGcDQDu0ZLnstC0NC6Iy3l/zeybj114zAF87/G
         RQVA==
X-Forwarded-Encrypted: i=1; AJvYcCXYTU2tc4mJYJbrBZu3ReEK86w/r1/g4hCAo9R3jsmsPUhd4BHWUQ1n1VmMZtl9KEmeGZQkQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywx07n/50PXwpKZ7YVhkSL8+RgEGFHZQJfeVKZC+WzgpB00LFyA
	SRVCK6onOChWyztw7VrXlNQZofHEDllly3cfqB1QcUD19fYJYOhitHHH
X-Gm-Gg: ASbGncs6kl8BYQJCKFutH9syLJaIYJDDr+lwUec5mzHsnvmiPt78BeKMQwSvJ3ixIpw
	FgK+y1Mo2zoEWiQzZsh2vQzlvRMfm3qbpHR+WJj2vusyaPOnGOIb1ow3MVWLQ31GYcNhnyPxNWT
	FPsDhXjd9ok7fu2Ie0JXneeIF0BoQmbwA7O15E2QyHhQCeaVNir61Jw6dT8XpGd/fAFzTePrnW8
	TCWsUpicNInrm2fTfEXkhgFVxM0nptNXlrVkUcB2DleTW8Zeojrpf//p6VX0U1LJX2eQal0aMI+
	nGJPqsjzzPuhnqj2Vv4mYbGbSD/L7TVXgnekL2DJq+o8z0BGhl1wAKRr8padIUcMm/o6xn74RnC
	adRpB50VXwpGmt2geJvjimWIDX48COzdVtLo/I6s3uQm/TrrkBY8Bt0L8PA==
X-Google-Smtp-Source: AGHT+IEMCGGGprcbXRR1yMw//2aiZLM5Ci4pXvi2khlJ9ETOkX78f4aDe8DT5j9DDWK3UG+TrKW9ew==
X-Received: by 2002:a05:6512:a89:b0:553:addb:ef5c with SMTP id 2adb3069b0e04-55a046538fbmr3898999e87.54.1752499161600;
        Mon, 14 Jul 2025 06:19:21 -0700 (PDT)
Received: from pc636 (host-95-203-19-28.mobileonline.telia.com. [95.203.19.28])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b77c64sm1956468e87.219.2025.07.14.06.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:19:20 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 14 Jul 2025 15:19:17 +0200
To: David Laight <david.laight.linux@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, jacob.pan@linux.microsoft.com,
	Jason Gunthorpe <jgg@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, iommu@lists.linux.dev,
	security@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
Message-ID: <aHUD1cklhydR-gE5@pc636>
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
 <20250709085158.0f050630@DESKTOP-0403QTC.>
 <20250709162724.GE1599700@nvidia.com>
 <20250709111527.5ba9bc31@DESKTOP-0403QTC.>
 <42c500b8-6ffb-4793-85c0-d3fbae0116f1@intel.com>
 <20250714133920.55fde0f5@pumpkin>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714133920.55fde0f5@pumpkin>

On Mon, Jul 14, 2025 at 01:39:20PM +0100, David Laight wrote:
> On Wed, 9 Jul 2025 11:22:34 -0700
> Dave Hansen <dave.hansen@intel.com> wrote:
> 
> > On 7/9/25 11:15, Jacob Pan wrote:
> > >>> Is there a use case where a SVA user can access kernel memory in the
> > >>> first place?    
> > >> No. It should be fully blocked.
> > >>  
> > > Then I don't understand what is the "vulnerability condition" being
> > > addressed here. We are talking about KVA range here.  
> > 
> > SVA users can't access kernel memory, but they can compel walks of
> > kernel page tables, which the IOMMU caches. The trouble starts if the
> > kernel happens to free that page table page and the IOMMU is using the
> > cache after the page is freed.
> > 
> > That was covered in the changelog, but I guess it could be made a bit
> > more succinct.
> > 
> 
> Is it worth just never freeing the page tables used for vmalloc() memory?
> After all they are likely to be reallocated again.
> 
>
Do we free? Maybe on some arches? According to my tests(AMD x86-64) i did
once upon a time, the PTE entries were not freed after vfree(). It could be
expensive if we did it, due to a global "page_table_lock" lock.

I see one place though, it is in the vmap_try_huge_pud()

	if (pud_present(*pud) && !pud_free_pmd_page(pud, addr))
		return 0;

it is when replace a pud by a huge-page.

--
Uladzislau Rezki
