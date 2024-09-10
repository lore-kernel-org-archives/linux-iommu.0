Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74740184555
	for <iommu@lists.linux.dev>; Tue, 10 Sep 2024 11:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725966749; cv=none; b=NUGDZd4XFqBY0S8q8V745rNqPV6gENuzfXtaLnJNyd1M+t6Prjg/aj2HtwFxVOBwC0KGNxU5gc06LDVbk9oPjtMXFI9W+a6owxONcqx/HIBEbcoUNiPzewNSq8TsGiN4d8RMy78UCetyuAxLV4vHRLR0Qwewurktr+B0ayPI0qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725966749; c=relaxed/simple;
	bh=UYj7aweKY056oMs7GM5XXWBsu2TkMRaSALM5bW7LDJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6rYbneS9FjOrVYPy1a7o2cfpARYZiT+r1DcjDVEJDk5ywA53FRrDzydk+decI5YZy3TNe/A5reht772onJ4+1mVN6YC3gsPJN/KYx0iI6wmAGoli5Gu1oeQo4LA+nDnzbPq3fGsZBRrNXds/RcsxFZV/fz99XZO/Sgbd2i2IOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R+XesfXh; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R+XesfXh"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c2460e885dso11996a12.0
        for <iommu@lists.linux.dev>; Tue, 10 Sep 2024 04:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725966746; x=1726571546; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UYy4DmMGHFHCTGKn7bORTP8d4lFk3R5EHaNq4YeXwzM=;
        b=R+XesfXh8B4AVb3ykIwSvW4kepJ4WfPCcVg3bUsVdhp9I1jcK6Hue/dc62GR4MABJM
         sTEKzOIj+5V5u7uFEDonSYDIzYQwX035AcOMZG6Yi/YG36lPEoPvLGmyJ1Ml87wd+3xf
         4vZiwLkkIzQcNn9L0Hikbny7CSTW727jElP1JZO8b9GjcQ3OgKL37DQ48MavVWVQfNkc
         zjSnAsn/RoNtIlWK8ajUvfzGeN/GRLBgXDwHkzLwNwn9E006dxthaC3t5LQ1+8DLZL/E
         47J0HYbpG2OLyYOkCjUusBiF0yOrpeYn0LvplfwV/MGvxRUBmh77iXCKZ7Y7tGON4M0M
         NL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725966746; x=1726571546;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYy4DmMGHFHCTGKn7bORTP8d4lFk3R5EHaNq4YeXwzM=;
        b=FXclw0WvLdA/bKX+pWh+dN1Nt8fFqiQ1o3mqRbcFoXbus8fEDL+J23wAKFbggoRrpO
         /VXYJGpDy2u7FoXFrNnZZyAQTZJqyeJ8LVs19F7anlJhyv/9XutRv4CgH/qvkiEpY7kJ
         WrJ2Ao5bKH/J8FlT/y7R2xz44SuF8jkBcOo5uZTwhnmH6bnRbcHdh/l9iDHqquRqpSEF
         19G3e20875r5oszon+OCjA9n2ZTiNcK+eYrYygo8Df1UAnT/84jllypSrc8XpPrQhhF+
         s0y6QelvdVQhHsYLhPHAonBKJVWJ0VISpRYktGzYbdF/P+K9J0dDQ5UVEa2LIegVCv7C
         yCjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO6W5o01ZdeskFvSCFiRqx35w6emf+gNiKNge9guZUqQ5+wo4dhzBM/3/xt97GuzqcbhS8mw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBTiICM/WWoqIv5532QbINUhQjrGcVSjBACaDLbzXEKpSieSa3
	WxO6YC5wzs1aQxITcagKBU+uzruOtHtOyHUg5II/YU4LAmvTTh86kq+GFQp6TA==
X-Google-Smtp-Source: AGHT+IFie5nPTW6D5tNlRl7qFWvNiI/ySCh0zgRrb+aBAPhZhb7eVrcOK1eXSiw1bugwbN+BJ9aSog==
X-Received: by 2002:a05:6402:1ec4:b0:59f:9f59:9b07 with SMTP id 4fb4d7f45d1cf-5c4029ef54amr158266a12.4.1725966745263;
        Tue, 10 Sep 2024 04:12:25 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb8120asm107512605e9.37.2024.09.10.04.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 04:12:24 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:12:20 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linux.dev, Hanjun Guo <guohanjun@huawei.com>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 8/8] iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED
Message-ID: <ZuAplEO7wyFahr6Z@google.com>
References: <0-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
 <8-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
 <ZtHuoDWbe54H1nhZ@google.com>
 <20240830170426.GV3773488@nvidia.com>
 <ZtWMGQAdR6sjBmer@google.com>
 <20240903003022.GF3773488@nvidia.com>
 <ZtbQMDxKZUZCGfrR@google.com>
 <20240903235532.GJ3773488@nvidia.com>
 <Ztrigx4LmpbFiMba@google.com>
 <20240906133444.GE1358970@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240906133444.GE1358970@nvidia.com>

On Fri, Sep 06, 2024 at 10:34:44AM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 06, 2024 at 11:07:47AM +0000, Mostafa Saleh wrote:
> 
> > However, I believe the UAPI can be more clear and solid in terms of
> > what is supported (maybe a typical struct with the CD, and some
> > extra configs?) I will give it a think.
> 
> I don't think breaking up the STE into fields in another struct is
> going to be a big improvement, it adds more code and corner cases to
> break up and reassemble it.
> 
> #define STRTAB_STE_0_NESTING_ALLOWED                                         \
> 	cpu_to_le64(STRTAB_STE_0_V | STRTAB_STE_0_CFG | STRTAB_STE_0_S1FMT | \
> 		    STRTAB_STE_0_S1CTXPTR_MASK | STRTAB_STE_0_S1CDMAX)
> #define STRTAB_STE_1_NESTING_ALLOWED                            \
> 	cpu_to_le64(STRTAB_STE_1_S1DSS | STRTAB_STE_1_S1CIR |   \
> 		    STRTAB_STE_1_S1COR | STRTAB_STE_1_S1CSH |   \
> 		    STRTAB_STE_1_S1STALLD | STRTAB_STE_1_EATS)
> 
> It is 11 fields that would need to be recoded, that's alot.. Even if
> you say the 3 cache ones are not needed it is still alot.

I was thinking of providing a higher level semantics
(no need for caching, valid...), something like:

struct smmu_user_table {
	u64 cd_table;
	u32 smmu_cd_cfg;  /* linear or 2lvl,.... */
	u32 smmu_trans_cfg; /* Translate, bypass, abort */
	u32 dev_feat; /*ATS, STALL, …*/
};

I feel that is a bit more clear for user space? Instead of
partially setting the STE, and it should be easier to extend than
masking the STE.

I’am not opposed to the vSTE, I just feel it's loosely defined,
that's why I was asking for the docs.

> 
> > > Reporting a static kernel capability through GET_INFO output is
> > > easier/saner than providing some kind of policy flags in the GET_INFO
> > > input to specify how the sanitization should work.
> > 
> > I don’t think it’s “policy”, it’s just giving userspace the minimum
> > knowledge it needs to create the vSMMU, but again no really strong
> > opinion about that.
> 
> There is no single "minimum knowledge" though, it depends on what the
> VMM is able to support. IMHO once you go over to the "VMM has to
> ignore bits it doesn't understand" you may as well just show
> everything. Then the kernel side can't be wrong.
> 
> If the kernel side can be wrong, then you are back to handshaking
> policy because the kernel can't assume that all existing VMMs wil not
> rely on the kernel to do the masking.
>

I agree it’s tricky, again no strong opinion on that, although I doubt
that a VMM would care about all the SMMU features.

> > > > But this is a UAPI. How can userspace implement that if it has no
> > > > documentation, and how can it be maintained if there is no clear
> > > > interface with userspace with what is expected/returned...
> > > 
> > > I'm not sure what you are looking for here? I don't think an entire
> > > tutorial on how to build a paravirtualized vSMMU is appropriate to
> > > put in comments?
> > 
> > Sorry, I don’t think I was clear, I meant actual documentation for
> > the UAPI, as in RST files for example. If I want to support that
> > in kvmtool how can I implement it? 
> 
> Well, you need thousands of lines of code in kvtool to build a vIOMMU :)
> 
> Nicolin is looking at writing something, lets see.
> 
> I think for here we should focus on the comments being succinct but
> sufficient to understand what the uAPI does itself.
> 
Actually I think the opposite, I think UAPI docs is more important
here, especially for the vSTE, that's how we can compare the code to
what is expected from user-space.

> > > I would *really* like everyone to sit down and figure out how to
> > > manage virtual device lifecycle in a single language!
> > 
> > Yes, just like the guest_memfd work. There has been also
> > some work to unify some of the guest HVC bits:
> > https://lore.kernel.org/all/20240830130150.8568-1-will@kernel.org/
> 
> I think Dan Williams is being ringleader for the PCI side effort on CC

Thanks, I will try to spend some time on the secure VFIO work.

Thanks,
Mostafa

> 
> Jason
