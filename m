Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C9A17A938
	for <iommu@lists.linux.dev>; Mon,  9 Sep 2024 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903033; cv=none; b=a+5a1dh70CGxGipnlXuVzKqRz/RNHTABmqVuDmmzvf6qc3TdKhUByIRZ4tWfRapGqExNf4s7rNpieirkQZWArrzOJsglysTVhrMdi7ONetT/uqr3ve2fpviD8Jl42lWE+aqPc32T6U53GedNs6T0nVK40NEwtrQ/bDwVsYKYPSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903033; c=relaxed/simple;
	bh=xyK+3dQGPCuRQG9dLlF6hty7g2wrGfAB7aDTvgl9weI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lpqvq2ZSamkoa8XhY0JgRTNFgaYveiTf294UToZnajWUoMTLKUmFoEDa2qwDb5iKryniUte9tnLzurspEodlpVgRW/ST2zBE941PXiQvf9Kb8NYl+chWSxZghFhpmlc3uB/Z4uK7Tz+73LBnJIygm8H3A+eGM5tt9h/RqyAB55w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VfpoRjla; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VfpoRjla"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20546b8e754so12225ad.1
        for <iommu@lists.linux.dev>; Mon, 09 Sep 2024 10:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725903031; x=1726507831; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cto5HZc4aEQsnwEmrBctjh6gcgskiASUd7J9YE2iY9Q=;
        b=VfpoRjla9XccRti5DX4DcMIb2CTsAiiSWfYubH+xvDvdnUiW3YV6HOEZ1DsaBAN9oO
         b7Yw5+Xqd4R50Gy0YYnGBjHRnaj8ai+S1HqarmLFBYQmyR6E1wO68zOuWOjWGfBH3CJo
         dPZ0Nvg47kLhvcIKZP0J1XpsszcK6nZYcTYZr5iE4O8161Vf8D6c+5DP1eCuObnFpZZt
         i9kV83VxehEiD83jf3mZEF+IBwSw3pyTTVGrFxjUTbLABaDcwpWBWpw2Zf03lgY5ppYE
         CXSOB39hXKToJWuLGwgf4duAwZfjecVxCAhrWF3Xj5J6MEmUvStGr1dkcW8oY63gkuSm
         s+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725903031; x=1726507831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cto5HZc4aEQsnwEmrBctjh6gcgskiASUd7J9YE2iY9Q=;
        b=UMNs/5nCeI6eTgyat2yhf2AqXuZfC4UWU6YerewzIwOQbC9/mzMcnyZyq1S8ZDRuOI
         ly3JU+eNu3p1jBrAsxjUKBHuB1Y4L7TRHZe+9XGrjomRmTt4I+WAxujdbRpjbY7M2k6L
         pwBzCSREEyFzZ8PUskOaMqB8g7R4qSIe/cXF0+qZx8mqou1XWU/EZ2ZX2uVApyqRxdz5
         +MlfG+O7XRJiOGIrB4bKN14AVGE6i4ve5QZr8mfwNSd6o1qW3aFKTk7VLr4j5FZWy/NJ
         UOGlOzLqJlBxvT39ODDetmMb1gswXbsbQR/OmWai6Opk8Rwbj4JQNTGoUbVlHCbIh6n+
         KA3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQ7Zt/6Ojtz/PbA/ZdUDYWUoO3DFUw27ciBvhF1bnW5QvfwDTGvGcMZTpwRgJZqemtRuIrxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIAKM6LSK/nNEKh9d+MXp+pb49K6yaWAtFaXfmItfvh1dbBP3B
	kjWGG6Nxuo7168DunVowpMw2E2VjOxN49sQjKSEGhte3OCkF3M5qrZUWoBFv7A==
X-Google-Smtp-Source: AGHT+IFpcDYnVim3kdPH2MxQYiHRb05SxHjhNVTnYuNDPp4bONVPAdgY41ze7WuTTjCf73NzyE4F9Q==
X-Received: by 2002:a17:902:c946:b0:207:6ea:de2b with SMTP id d9443c01a7336-2070de23b9bmr4788145ad.15.1725903030615;
        Mon, 09 Sep 2024 10:30:30 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e10ec1sm36219165ad.1.2024.09.09.10.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 10:30:30 -0700 (PDT)
Date: Mon, 9 Sep 2024 17:30:22 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Will Deacon <will@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <Zt8wrkj7Fg4W8lUf@google.com>
References: <ZtEKMknbGaD9q170@google.com>
 <ZtEkUQ7tI3Nb0NOc@Asurada-Nvidia>
 <ZtV1-IL8AZu--jGp@google.com>
 <ZtZEFKnKasX6433r@Asurada-Nvidia>
 <ZtnXADX3b6qdqVs0@google.com>
 <ZtphFYr1jUhHOSnC@nvidia.com>
 <20240906125524.GA16773@willie-the-truck>
 <392451a1-784c-4c35-9924-1a1f4cba9120@arm.com>
 <ZttNF5qcc+jH/3yE@nvidia.com>
 <20240909144506.GA19863@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909144506.GA19863@willie-the-truck>

On Mon, Sep 09, 2024 at 03:45:06PM +0100, Will Deacon wrote:
> On Fri, Sep 06, 2024 at 11:42:31AM -0700, Nicolin Chen wrote:
> > On Fri, Sep 06, 2024 at 05:39:03PM +0100, Robin Murphy wrote:
> > > On 06/09/2024 1:55 pm, Will Deacon wrote:
> > > > > > > > +struct arm_smmu_event {
> > > > > > > > +       union {
> > > > > > > > +       u64 raw_evt[4];
> > > > > > > > +       struct {
> > > > > > > > +               /* "Good stuff" fields */
> > > > > > > > +       };
> > > > > > > > +};
> > > > > > > > 
> > > > > > > > and then based on the fault type we can use the "good stuff" or raw_evt?
> > > > > > > > So, basically just add a union between raw_evt and the other fields to
> > > > > > > > improve struct arm_smmu_event present in v2?
> > > > > > > 
> > > > > > > Yea, I attached a test code at the EOM for your reference. Please
> > > > > > > feel free to drop fields if they aren't common enough, and confirm
> > > > > > > those bits are correctly written too.
> > > > > > > 
> > > > > > 
> > > > > > Hmm, so you're suggesting to make the event a union instead of a struct
> > > > > > thus, making reading event fields easy.
> > > > > > 
> > > > > > The only thing I'm slightly worried about is if the bitfields don't
> > > > > > remain constant if more events are added in the future.
> > > > > > 
> > > > > > For example, the "IPA" field is in dword[3] for now, but if it changes
> > > > > > in the future, it may get difficult to scale the union for future events
> > > > > > If we can guarantee that it doesn't happen then I think union is better.
> > > > > 
> > > > > I believe HW has its own reason to put those fields constantly
> > > > > following the same pattern, and must have its tendency to keep
> > > > > in that way.
> > > > > 
> > > > > The "union { u64 raw; struct {} }" way isn't that uncommon in
> > > > > the kernel, here are a few existing examples:
> > > > >      drivers/crypto/marvell/octeontx2/otx2_cpt_hw_types.h
> > > > >      drivers/crypto/cavium/nitrox/nitrox_req.h
> > > > >      include/asm-generic/hyperv-tlfs.h
> > > > > 
> > > > > Taking a step back, if one field in a new event in the future
> > > > > happens to be odd, we could still fetch field in its own way:
> > > > > event->evt[4] is still available to extract via FIELD_GET; or
> > > > > just define another union exclusively for that event, neither
> > > > > of which sounds like the end of world.
> > > > > 
> > > > > Having said that, I'd defer to Will. So, here is just my two
> > > > > cents.
> > > > 
> > > > My only real concern is the fragility of using bitfields. I don't _think_
> > > > the compiler is obliged to lay them out in the obvious way and I can't
> > > > think of anything worse than being given a bad pretty-print when debugging
> > > > a real driver issue!
> > 
> > Well, if compiler is going to be an issue, I can't disagree with
> > your point.
> > 
> > Any reference to some existing issue with compiler failing to lay
> > out properly? I wonder how other headers could define their unions
> > using bitfields and stay safe..
> 
> It's not so much about buggy compilers, but more that I don't think the
> C standard defines the order and so relying on it can be fragile. If you
> fancy going to the effort of ensuring that LLVM and GCC will agree on
> the "obvious" layout forever more, then don't let me stop you ;)
> 

Hmmm.. +1
I had some time, so.. I dived into the C specification[1] (free draft)
to look for bitfield layouts, under section 6.7.2.1, point 11 
(page 101 of the pdf), and I see the following paragraph:

"An implementation may allocate any addressable storage unit large
enough to hold a bit-field. If enough space remains, a bit-field that
immediately follows another bit-field in a structure shall be packed
into adjacent bits of the same unit. If insufficient space remains,
whether a bit-field that does not fit is put into the next unit or
overlaps adjacent units is implementation-defined. The order of 
allocation of bit-fields within a unit (high-order to low-order or 
low-order to high-order) is implementation-defined. The alignment
of the addressable storage unit is unspecified."

However, I'm not sure how these "implementations" comprehend the spec.

> Will

> > I am trying to learn here: apart from what Will mentioned above,
> > is there any other reason to stay away from bitfield?

One more thing I can think of is Alignment faults on certain archs.
Accessing individual bitfields within the struct could lead to unaligned
memory accesses. I have run into alignment faults on $ARCH=arm64 couple
of times while using packed structs in the kernel code.

[1]
 https://web.archive.org/web/20181230041359if_/http://www.open-std.org/jtc1/sc22/wg14/www/abq/c17_updated_proposed_fdis.pdf

Thanks,
Pranjal
