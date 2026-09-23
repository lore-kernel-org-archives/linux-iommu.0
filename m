Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127CE47FAF3
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158556; cv=none; b=FhKjqQQQM1RpGDoVfUXOVNj8accBt0R1WQcy44TiO2GJ8b8Npw+8Un47rv2zZwpHKvfNYo+CasJAQnqNvhdFaTnDu+RTwKRsUdPiyda31/QuJbC72YFznsL0iyNWFnB1A+aSsvaYeBxZyJPBXrEDRDM0N0kB//wEdZDdC6vz9QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158556; c=relaxed/simple;
	bh=EIUUzLZaMLycy3iJsghOslrbsHk9RROoG95frX8jYxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auTpktRgElCBmK3KKul13X0naOIh6vz48cpfCs2AHxJpztR99VAg/I+rWAnUMLsdrelbGH21vn2lk/4e6WtiRzfDhVBcmvf188C4+zrsNNGpTXSgXarMfDiXJAfLW1OpJHsvA6QTIS76AJAwcF8mqumrznnKLk9ATRGPhein3i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=umivEjJA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="umivEjJA"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49e65a8f70eso30995e9.0
        for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 03:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790158543; x=1790763343; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yZHQHfq1ph65L7qxzKlrPBl8SiUbUAuTYjQIuazmnA4=;
        b=umivEjJAnhnqbgxild7Z2GEz2mRFzjkU0qjw9B+uUclS8jt+IaovCEoh0ZNFMRAFdw
         PMcbPqfKkxZHy0dsY+ZicXl+MKOWkOWK/iO1tTmzp3WP38D6Wzj8TduQd5pnqIomQTJl
         2Ad82Wt3sNg+Zsc5w7ZwtE6rKiPRZIGMMndojscj79QZG+RYa9FpY+i4OAEVT/WRJwxW
         ZG7J9ZDJ5N/407mAm/v7j2TBaztxB8ffnkCcn9VqcqzDODQyqvCpGpLC/GR+2yi3Wga3
         fAi7kjSDuRd7n8cJEwUAhPxXMTKC3/PNkmJgaPMEHwDIVvK5o32s9niVTYxiO/7kGIne
         vIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790158543; x=1790763343;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yZHQHfq1ph65L7qxzKlrPBl8SiUbUAuTYjQIuazmnA4=;
        b=CseqO8xixptKJwTUvbuHdkbKmR7+gJvRuVz/nQTp67jY/1yMfD7NBXJY7+ts812CNo
         bNIKB1vrkbZgu+6W0X013y5S/EwmkcxapVIlAs8EspctJmqyOmSnk0bjtsrhu0PYa+VZ
         6O+IesWlzNEV5OkQS3dNDAmS6XZG/clC8+Huf/pqexe4R9vc+7N1m8bijgWZCU00gmwf
         /Jr6HeBd+hvad1NGAefxTvt01dG2GNsrRs49DiZQfYJACi+2nJXghPBTbaWqf+cdaTII
         Zq1MPcacAJ9Vy0kJAugig1TJr3BsJQbciRjb6V0XAmZBzSCbh8qyz5wLl0PmmhJOu4qZ
         QYOQ==
X-Forwarded-Encrypted: i=1; AKwUvBwoFELlvxF1Kln5LelB4sqQsy9srZFvb6R/J/f5USTZWPZ1G5JktEaVS4QJtI4eamnWvdLM4A==@lists.linux.dev
X-Gm-Message-State: AFuF++kEUHMvPZ4j5cz3rhVkbM1wBWlJuSfv/aZymsvNsV5EZZIOrXl9
	zRR67tzF8iQDMY4su4frMxn/b1XRP/C1/euxx5aQNw51VJvfV9jBBuP8QfALXQ/Se2yFE4x2n6d
	lazCM7g==
X-Gm-Gg: AYBFou3pZ1Oykmv9IrmWGlRRTjTjxjIu9ejX7O2l/Y0RGuscrE1KrxLdCxk/U7q62ET
	Q5GAwK9r7kdjiELjGUimKL1VRpjPDq0mI+VWMNnnxBEaJgf6FMeBhDKfumBT/BpfyC4qxQeZnDS
	RWTN/eOOIHB9N9Okkl/j5qGG4ypfrezr/qew+2lHw6DxubjEpxs1b8abAI9ykAZMUdwzTRcPbT4
	LKypH43KgKCMMKUZWtu0+njM6Zfju/YH0dJr/3nItk6xZxGo46d/zRh2nLS+fAjoW3JYcRaMHFV
	MrS4J4IEMcT7TMuatDO3SgXShP70OK4X8GuKUMPZxL6UtfkgT3ZSqBIW3R+cIfJi7F3NCh6O3RY
	ou9ALSyOgWSteMHHEaZSUA8eqBt+w9iTPPWtGHG2N078T8QGzmUEPaXfNmT+L++crKx3WrogCY2
	Xh/+e18HBpusX0NUj+bY6D2fYO5tXDGNAK5ZtVKN44V48WKSeEopqVtyBcVi/IJqU35mn1N5+SF
	Tf4JlGVnX54RBpfFKidnzpc9YcF8CtZtcC9OQHK
X-Received: by 2002:a05:600c:379a:b0:49f:c6ca:42d2 with SMTP id 5b1f17b1804b1-49fe0c0bad5mr679925e9.1.1790158543084;
        Wed, 23 Sep 2026 03:15:43 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1e975asm71831925e9.14.2026.09.23.03.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:15:42 -0700 (PDT)
Date: Wed, 23 Sep 2026 10:15:38 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v8 05/25] iommu/arm-smmu-v3: Move hitless machinery to
 common code
Message-ID: <arOmyuQwuWkynORS@google.com>
References: <20260922131259.2975334-1-smostafa@google.com>
 <20260922131259.2975334-6-smostafa@google.com>
 <arLeIO20VQZD80nr@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arLeIO20VQZD80nr@nvidia.com>

On Tue, Sep 22, 2026 at 12:59:28PM -0700, Nicolin Chen wrote:
> On Tue, Sep 22, 2026 at 01:12:38PM +0000, Mostafa Saleh wrote:
> > Move the hitless STE functions to the common file so it can be
> > reused by the hypervisor.
> 
> s/it/they

Will do.

> 
> > No functional change.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> With some nits:
> 
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -59,10 +59,8 @@ enum arm_smmu_msi_index {
> >  	ARM_SMMU_MAX_MSIS,
> >  };
> >  
> > -#define NUM_ENTRY_QWORDS 8
> >  static_assert(sizeof(struct arm_smmu_ste) == NUM_ENTRY_QWORDS * sizeof(u64));
> >  static_assert(sizeof(struct arm_smmu_cd) == NUM_ENTRY_QWORDS * sizeof(u64));
> > -
> >  static phys_addr_t arm_smmu_msi_cfg[ARM_SMMU_MAX_MSIS][3] = {
> 
> This line removal seems unnecessary.

Yes, I will fix it.

> 
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > @@ -1321,6 +1316,8 @@ static inline u64 arm_smmu_tlb_inv_range_enc(u8 num, u8 scale)
> >  		FIELD_PREP(CMDQ_TLBI_0_SCALE, scale & 0x1f);
> >  }
> >  
> > +#define NUM_ENTRY_QWORDS 8
> > +
> 
> Maybe we should drop the duplicated define in arm-smmu-v3-test.c?

Makes sense, will do.

Thanks,
Mostafa

> 
> Nicolin
