Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736FC49625
	for <iommu@lists.linux.dev>; Thu, 31 Jul 2025 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971445; cv=none; b=P6IuZJsni0JIxn205LgUWNtUUqrNkHrIqf3KHbtxu/fzE6GMv7F/G0eKkNr2Bq0ACcIH6/PFbzrpb4yvHbvTaRsyNVVvDJYYPeD9s5enoGgcWOMYg8nfBjSwYqx6RQo610ew0PvkR1xiUZdPv7m5sRwIXkR9qnpKTlILGq+i4f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971445; c=relaxed/simple;
	bh=E1Mr78SFe7OCoQAaZ7NNFqP+kLbmSKTZ7SjbzvGIat0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHctSTa3q6IbttjJ2rQ+xDaw2rphJ5pAbWbNOkw1LRStdyECeC0EiLY2hL/MQx+IH7MiBTA4HNrjoZt5qn5JLPJPQnm4pkTKli9FEXi4iieF9Z/EoKG43LVxfhc5mSmpyMHe6Zln8/91vflp+ucTHxZL8Rz3BHp4mCmTaauoB6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CkPfiION; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CkPfiION"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-456007cfcd7so83235e9.1
        for <iommu@lists.linux.dev>; Thu, 31 Jul 2025 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753971442; x=1754576242; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pcWB14Cn8mezh693QdjehHNThSsfRoWZAjW9od9JFCc=;
        b=CkPfiIONuqu8eVo25uaN/sEpMOP9D6QC0DuGMA6HbQXvFgZTOk9I5tF1fH3lIGOAdB
         R23kkCwulbT0uBJqnybj6bfgz46SYQD6gppA4bE/0HRKHFb1I5Jy5tHc3tS3CS+ENEVc
         eHaDnp7WDWLsOmDjAY49Q2NrOfgh4M2PBz5o1GFaCVFO2kdnAc2ADdv7SaaJyYOZKRvk
         yrVumXZuyY9ru46iCWYF9Eg0v1ySZ+frUUothh9/D/h6INBxbM2VybIvyWyJPEgs8Vs3
         YvoI0rF+HjtJl33k1sUeJeI0MGJKbPovXc6YFoNEAilQoKSE3zWB3+Y/rRRVQN3sf2F8
         RrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753971442; x=1754576242;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcWB14Cn8mezh693QdjehHNThSsfRoWZAjW9od9JFCc=;
        b=kla+xtguIGoRAjHRRhQOoom0Nf+6GX5o/1yDqazof2e7ZoTmY9RkXx851+upmImQvh
         dmdHUvXfFopwBJN+1M1R/EHAYbasagFAbB9O2gxZGvq6ndKBY1NPffdac5jWhTLfhirZ
         xMO0symdeidKZevjtm072bq/zHZwRQKGpmYuUrfSlfTC1Y3vj8IvfAQGpWno4fDCjspB
         +ovU/JJNiNe11bAnticYyydlL2BbreKkkDvfg93eBYhYfb22JSImI6DYD05U8kqdLRPn
         uLzNbnjLsITpHr7hNsEXyixBu0zMqXRsZqqyN7sGEa5fZ3BRIbl5s/WXkdkXhdzUf5FD
         H7Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWCQ4nOONaq63YV1zdWlztDiRSdJYLz4eWN5W4hMDzNMuyIPthcHSebpxtdLOA9J2HJc2urGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyu2VmrnWYqY3zJfIEk+HxwsZKOzQGNzU8XkroNH+LiZvFHc5lx
	N2o9jmXtOTgPmvRKP6ja7ltdF8utgCTrNbuF5q/jn23qMsuwJBe/gYaU04trhTCAkQ==
X-Gm-Gg: ASbGncvYE6GKAZDRiWvu+m/prAQIJuUly4a/cY78JpBCqoMFXgrbKe8JgTIbLjN4Khi
	JcvDrVgV6pqOZ5B/W4YrWO4MGWg4VMBY4/+2N9EdBxUYzZLwapl3uIaGq9PHzOfkxKx2otuYcpp
	8As0JUBNQ6iU8CsEv1MiHtNKIUnXNue8j4kEaLV6N95WjtpVygjY14NH+3+0wDsxs93+BsthvvD
	O4nA1Afeq46XJpBkqMdFqbXe7pHFL3G8GFS1I6P+umSI3C2wOAayC4DYxAvgUymbJH0vjYYyKxH
	6RBKIts11IS8GP+wRVX7FQBXtOhstiGCHdIbDSpOv/W7YfSc9Ghr+yKzIUhPGYBTyp0xkfkZWBJ
	JNhPrqLTiIQownOhnE4RfEwhAXEcWnxjKH6Ic7eacarMrfLlvXVeEOGlsBiCv7aGBfg==
X-Google-Smtp-Source: AGHT+IHQna8PBH+0rnLeEfLwPLu5VSthuOinGeMrMZmAiA37gK//dxUBEvZYVDk/z0ZzOGHZAGlqMw==
X-Received: by 2002:a05:600d:108:10b0:455:fd3e:4e12 with SMTP id 5b1f17b1804b1-4589f38f199mr1003195e9.4.1753971441527;
        Thu, 31 Jul 2025 07:17:21 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee4f0d2sm28100345e9.18.2025.07.31.07.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 07:17:20 -0700 (PDT)
Date: Thu, 31 Jul 2025 14:17:17 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v3 29/29] iommu/arm-smmu-v3-kvm: Add IOMMU ops
Message-ID: <aIt67bOzp6XS_yO-@google.com>
References: <20250728175316.3706196-1-smostafa@google.com>
 <20250728175316.3706196-30-smostafa@google.com>
 <20250730144253.GM26511@ziepe.ca>
 <aIo1ImP7R7VhRpVE@google.com>
 <20250730164752.GO26511@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250730164752.GO26511@ziepe.ca>

On Wed, Jul 30, 2025 at 01:47:52PM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 30, 2025 at 03:07:14PM +0000, Mostafa Saleh wrote:
> > On Wed, Jul 30, 2025 at 11:42:53AM -0300, Jason Gunthorpe wrote:
> > > On Mon, Jul 28, 2025 at 05:53:16PM +0000, Mostafa Saleh wrote:
> > > > Register the SMMUv3 through IOMMU ops, that only support identity
> > > > domains. This allows the driver to know which device are currently used
> > > > to properly enable/disable then.
> > > > 
> > > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > > ---
> > > >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 92 ++++++++++++++++++-
> > > >  1 file changed, 91 insertions(+), 1 deletion(-)
> > > 
> > > Can you split the new iommu subysstem driver out please? I think I
> > > asked this before.
> > 
> > Sorry, maybe I misunderstood, do you mean split this patch into multiple
> > patches or split all KVM SMMUv3 driver out of this series?
> 
> Yes the latter, the iommu driver introduction is best as its own
> series

I thought about that but I was worried the maintainers wouldn't like
introducing the infrastructure first in the hypervisor without a user.
I am open to split this, but let’s see what they think.

> 
> > >  - Domain attachment looks questionable. Please do not have
> > >    attach/detach language at all in the hypervisor facing API.
> > 
> > I am not sure I understand this one, the hypervisor API has no
> > attach/detach APIs?
> > We only notify the hypervisor via “enable/disable” hypercalls when
> > devices are attached or released (as only IDENTITY DOMAIN is supported)
> > so it can enable or disable translation.
> 
> Same difference, different words.. We've had trouble with this kind of
> ambiguous language.
> 
> attach identity
> attach blocking
> 
> Keep it clean and simple

Makes sense, from the kernel point of view it will be attached to
identity/blocking domains, but the hypervisor api is just enable/disable HVC
as it doesn’t know what is a domain. If terminology is really a problem,
I can make it one hypercall as “set_state” with on/off or identity/blocking

> 
> > >  - Get the ordering and APIs right so replace works. You need this to support RMRs
> > 
> > I see, we can’t support bypass for security reasons, but we can enable
> > the identity map for such devices.
> 
> You will have a small issue if the bootup has the pkvm side put the
> device into a blocking translation then later switches to an
> "identity".
> 
> As far as I understand it display scan out buffers have to be
> continuously hitlessly mapped. So you want all the transitions from
> bootup bypass, pkvm isolation, "identity", etc to continuously
> hitlessly map the RMRs containing the buffers.
> 
> I think :)

I think that would be hard with pKVM, maybe it’s possible to achieve
that seamingless, we would need to export such devices to pKVM at
boot before de-privilege.

TBH, I am not sure what hardware does that. So, another option is to fail
gracefully if RMR exists (which falls back to the current driver) and then
pKVM would run with DMA isolation, which is the status quo.

And then RMR support for pKVM can be added later if there is interset.

> 
> > >  - Use a blocking domain not some unclear detatch idea
> > 
> > There is not a single detach in this driver, we only support attach and release
> > operation, which just goes to the hypervisor as enable/disable
> > identity.
> 
> 'disable' then.
> 
> > >  - Use a blocking domain for release
> > 
> > I see, I can add “blocked_domain” similar to “arm_smmu_blocked_domain”
> > which just disables the device translation, I will look into, I am just
> > concerned it's more code as this driver only supports a single domain
> > type.
> 
> Yes, this is the right thing. There should not be operations in the
> driver that change the underyling translation that are anything other
> than attaching domains. It becomes too hard to maintain.

Will do as mentioned above.

> 
>  
> > >  - Use the smmu-v3 approach for the fwspec, don't store things in the drvdata.
> > 
> > This is using “dev_iommu_fwspec_get” similar to the SMMUv3 driver,
> > am I missing something?
> 
> Oh I got it confused, you are just calling 
> 
> +       .device_group           = arm_smmu_device_group,
> +       .of_xlate               = arm_smmu_of_xlate,
> +       .get_resv_regions       = arm_smmu_get_resv_regions,
> 
> Which is also weird, why does an entirely new driver call 4 random functions
> in arm smmu?
> 
> Maybe don't, they are all trivial functions, or you don't need
> them. For example you don't need MSI_IOVA_BASE if the driver doesn't
> support paging.
> 

They are not random, as part of this series the SMMUv3 driver is split
where some of the code goes to “arm-smmu-v3-common.c” which is used by
both drivers, this reduces a lot of duplication.

I am not sure if we need get_resv_regions, maybe it's useful for sysfs
"/sys/kernel/iommu_groups/reserved_regions"? I will double check.

Thanks,
Mostafa

> Jason
