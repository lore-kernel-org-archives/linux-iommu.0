Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ACF1C460D
	for <iommu@lists.linux.dev>; Thu, 10 Oct 2024 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560303; cv=none; b=jgiLCzyYxIx86hnHL5ezqMzOF0OJ7LF1g7KctZR3ZD70iKbIDah88+fvWICFttGk+WrqNGYeKHKm9+huOy062AZgtCfW1OQRayw0Y5B++4E4HHth0pcMM/WwByWzRdz0PVtMyUAa0ILFgz7t/SUcmm3PEVhU8vfoLFx5rBOyYOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560303; c=relaxed/simple;
	bh=X157x1lEnmpK7zlE8AjdX+3AdHSZX+MExlIhqj/XVac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSQclp8J5ZnoxRHCuO2Q/10JzIlcEWW+fhwosreKS2ZGpaPuWSLlx/W0vVRCMa2h6ffM62WvN7hebZWhrPo8PTaKAgep3tpa2ZxU/FrlUlM0mVkRrnZ7nX7oZsCH4FIO5+avbDV5mF93Vlf5n25d36eOI7RGjYOJbGKyo2sc0fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UaW54hI0; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UaW54hI0"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46041d86566so3752281cf.3
        for <iommu@lists.linux.dev>; Thu, 10 Oct 2024 04:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728560300; x=1729165100; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JiodtxMOxBFQynayNIigQAsZeXWH8GXY8t4wa5yffJA=;
        b=UaW54hI0y8YPDbPiGVlDpXwHrdy8N1fostmy4JR6jBMRwhaYQOMOJYexKLEFEBmihP
         hEAYj0xGpOtN65C3kT0TOeJVYmvicLA8Oqau8BAA2KO93ZBbcjmEZN66mL1Y8u9sryw3
         eVhKV4RxabLT4BV+bmkAi3lUar/hhSZo9KmJiuy7TciRm5N9E9fM0DylfOhyeqDcuicN
         jDBflbm7aJO80AeaExVlJvIIMBlMhyLD8uAooghczVHayYIXHSWCTkz23ujEijWi86ga
         ATfXIufRhu7fBPq2qgFeg1dUfxNZEewVezO9uPAK0PGG6axkKCaHtP1tqFOpewpm5HR1
         xm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560300; x=1729165100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiodtxMOxBFQynayNIigQAsZeXWH8GXY8t4wa5yffJA=;
        b=PXBUy/n/ZM3kFqrN1OtasP0IfcZoB4kbpH1UkFD5aKuCcpQntWjcUnKJ8HpTwR26Nc
         tZY1uSchEEGF1efg8fyOArHFJ0k81al9tUNF+oWU/NEiAAdTJdWigeLsG0/zJ1ixD7f4
         a/h1BOKMjR+QvttNsVkq50sRrA639DCnYbN3UArz9r9X8nFUtNmvomxG6M7427+DZK8N
         RWu7mHruShtPhO+cPVHqSZsnipOI8fz6bJ75zTD9lvrWU8rlR3Y3TocE0OGiJTWy3Uf2
         Vb++6OVSLJ/VaOzqOu5AOxxjivb3jqbgR5mGDQhAsmC5bukAiTFYj+fFH76YRRNPcMEf
         3BBg==
X-Forwarded-Encrypted: i=1; AJvYcCWOxmjA8E5cIyfqCHITNeCfDUUZGXFmvEIiFwitshUsR0Q4Q+nU9Z4ZjLTnmrPsznMNNppzxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YySSI41OogY87CtsgvzBxzb6gW1jvVAym6Lx/nOjE80N6jFs+YP
	RqijbaJXvp3JvD1WXQZb1VfTWD0ZOqNTGVN+1t/huk9Q2ld5pEIl9we4xrRp3jU=
X-Google-Smtp-Source: AGHT+IEAjwIBMLHfdRUcX6KoW7C8lozeujfrNokB4axl/f43fp/uHhER7Uppj2S9oKARuTwkZK0Iog==
X-Received: by 2002:a05:622a:1e87:b0:45f:7eb7:c283 with SMTP id d75a77b69052e-45fa5f217admr86917801cf.29.1728560299604;
        Thu, 10 Oct 2024 04:38:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460427d4f62sm4619051cf.26.2024.10.10.04.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:38:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1syrUn-00HP88-8t;
	Thu, 10 Oct 2024 08:38:17 -0300
Date: Thu, 10 Oct 2024 08:38:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
	kevin.tian@intel.com, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 0/8] iommu: Domain allocation enhancements
Message-ID: <20241010113817.GG762027@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <970c6058-9e02-4cf6-bcb9-cfb8afb4eac1@amd.com>
 <71d20ff3-0a85-4670-8559-70ca5e6543c0@linux.intel.com>
 <9d0101b4-af13-4bf6-94a5-43a79f4d9989@amd.com>
 <20241009121548.GE762027@ziepe.ca>
 <f8cf4532-3bfe-4b0a-9399-0760ab6a4612@linux.intel.com>
 <2ba53bb0-b84a-4eae-91da-4ff7d13b582b@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ba53bb0-b84a-4eae-91da-4ff7d13b582b@linux.intel.com>

On Thu, Oct 10, 2024 at 02:48:09PM +0800, Baolu Lu wrote:
> On 2024/10/10 14:40, Baolu Lu wrote:
> > On 2024/10/9 20:15, Jason Gunthorpe wrote:
> > > On Wed, Oct 09, 2024 at 03:23:16PM +0530, Vasant Hegde wrote:
> > > 
> > > > > This change might cause a functional regression when it comes to nested
> > > > > translation. In nested translation mode, the user page table (e.g.,
> > > > > created and managed by a guest VM for guest kernel DMA) must be in the
> > > > > first-stage page table format. Then, it can be nested on a second-stage
> > > > > page table managed by the host kernel.
> > > > > 
> > > > > Currently, the kernel automatically selects the page table formats. For
> > > > > example, the Intel IOMMU driver always uses the first-stage page table
> > > > > for guest kernel DMA. After this change, this assumption no
> > > > > longer holds
> > > > > true. This means the kernel might use a second-stage page table for
> > > > > guest kernel DMA, breaking nested translation.
> > > > Hmmm. I assumed after discussion in v1 series you are fine.
> > > > Looks like I misread it?
> > > It is a bug in the implementation in the intel driver.
> > > 
> > > intel_iommu_domain_alloc_user() should always allocate a page table
> > > that works, if you are in a guest context it must allocate a first
> > > level/guest page table otherwise nested VFIO will be broken.
> > > 
> > > For this reason Intel driver should always allocate the guest
> > > compatible page table unless IOMMU_HWPT_ALLOC_NEST_PARENT is
> > > specified.
> > > 
> > > Something like this:
> > 
> > This will break the existing dirty page tracking functionality. Intel
> > IOMMU only supports enabling or disabling dirty page tracking at the
> > second-stage page table.
> 
> So, perhaps something like below?
> 
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 1497f3112b12..e11dde259afa 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -544,6 +544,8 @@ enum {
>                                 ecap_slads((iommu)->ecap))
>  #define nested_supported(iommu)        (sm_supported(iommu) &&         \
>                                  ecap_nest((iommu)->ecap))
> +#define flts_supported(iommu)  (sm_supported(iommu) &&                 \
> +                                ecap_flts((iommu)->ecap))
> 
>  struct pasid_entry;
>  struct pasid_state_entry;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9f6b0780f2ef..d1a7378489a4 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3530,6 +3530,7 @@ intel_iommu_domain_alloc_user(struct device *dev, u32
> flags,
>         struct intel_iommu *iommu = info->iommu;
>         struct dmar_domain *dmar_domain;
>         struct iommu_domain *domain;
> +       bool first_stage;
> 
>         /* Must be NESTING domain */
>         if (parent) {
> @@ -3546,8 +3547,14 @@ intel_iommu_domain_alloc_user(struct device *dev, u32
> flags,
>         if (user_data || (dirty_tracking && !ssads_supported(iommu)))
>                 return ERR_PTR(-EOPNOTSUPP);
> 
> -       /* Do not use first stage for user domain translation. */
> -       dmar_domain = paging_domain_alloc(dev, false);
> +       /*
> +        * Always allocate the guest compatible page table unless
> +        * IOMMU_HWPT_ALLOC_NEST_PARENT or IOMMU_HWPT_ALLOC_DIRTY_TRACKING
> +        * is specified.
> +        */
> +       first_stage = (nested_parent || dirty_tracking) ?
> +                       false : flts_supported(iommu);

That makes sense, but these flags still need to be rejected if the
second level is not supported in the HW.

+	if ((flags & (IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)) && !intel_cap_slts_sanity())
+		return ERR_PTR(-EOPNOTSUPP);

I also think my version was cleaner as we should be using
first_level_by_default() consistently to make that decision.

Also don't care for ternary expressions :)

Jason
