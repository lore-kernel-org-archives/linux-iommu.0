Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E6F21ABC6
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495324; cv=none; b=L4ULFux+HDcfUVGG6JX86I+cE2pbJpa5GHZfQVxS9uEfAZcEkAXxyKt27xPOOfNaq6gYnZePbwVCdG7uKps6LDztIcKaIgKRUDT5neh2YWLJ3FBkOqdotqvH1yRqRas/k3rJ2/Ne8J3gngAVx5j+1L7VEr4AXhOgCGg4vpqOp7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495324; c=relaxed/simple;
	bh=onjBfFA3vs+h8jsW1wHNipSTaY269JGX52paPqC84sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfSmYgaoA5Z+MIrvpzDdmOVyzMxepWhY6wSJUz/o+VLiUmc2CLOwkBWrRA3eKMf/lU/Rm0y+NP65IQipL4llNJ78A6Km6w0yUlfnB35kUZHIa6EzRrRLMfLcb2LpFa103TtqobA6ZJoUm/k0V/JNMYgPpU2SZ60eg1xm1bGnFyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pPWoqTm+; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pPWoqTm+"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-472242b0da5so44311221cf.1
        for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 06:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740495320; x=1741100120; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bosqxcSmmC4GveC7OEeUwI81FhDRyiKizzXCIKhl/mI=;
        b=pPWoqTm+9817a5lgMH07Ny4rD3O49AyEC/6bUQ2eh20Hb9CH29zJUgU/kGwRHNF9nU
         5R6EyX8CqTj7kHNEArElx7MGfqk2z4lrQaE3sEfVLVYFivJl/kvsnnt3PyOAs5Wfdn2q
         JmmhE/DGts33dX7eak8qHAoCLYHS4Sx0c25QM6DNq7L3aoIMihxGnYG0aCxh6B1s4zt5
         UWIIh856mKukzUU/psoNuVWuW++6Pt9Z2IYRtbGfZyt7bpdpz2DVwEw6cpXs8LxAVSDd
         nnh/ZCdMhHRbYIeqAffQH6R3eq12hqFHSsndYf8KpZkb6TDY/cTbabHvwaOaZ3gSLbuA
         jKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740495320; x=1741100120;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bosqxcSmmC4GveC7OEeUwI81FhDRyiKizzXCIKhl/mI=;
        b=qc5iHU/a10D/9bDzXLhcgkykV1WTBnmdxqfGZ4lLvmKXlYBHx7lgzjV4f/a4RGzphh
         05UhxgWGQyPwvBT1il+awAQa8BnyekRjHqn2Huvcdd2aM7SNecVCwXCq935Pek/TswH6
         NaFpiJzzKw1k5oGIFTZkBDuiLUIKp6K4dqw7YpXJCgbuGWrZnmR1mDyU1DqE0Mhhjxf4
         S8dEICoBKluTokduokQJAqYKvyc7w7olNFfVFaUWCZOer7yXrI7aXP4VlX3angAhXEyH
         ATaeCODo3lqiLukqUk+bdSwFDBFT9o8pwbGGUW/jKDxBIhdKtR/oJcEDHzC3X1LnatFh
         U6bw==
X-Forwarded-Encrypted: i=1; AJvYcCWJtby4/SpmJjWXMb2Iv2CgO2DchLV9s0tERMUpYRd7iHoWPJkvcuqbiUWpHVYUXKyEdXsp2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdFYjvixnxF2a58cZkGW/m0m3QGo4icpeF115Ixi+rvA/zCXaq
	NVQeF4KPKzsQ3Ratj+K/i4xbufqvz+6Azq7kza/6yEdM+p+shf0J52kQumXC0dY=
X-Gm-Gg: ASbGncvvA+mkSIINcGdPvkcAip1NBfXjtaXz97iApj2DLiUQgqKnwVpPIn3BkaBmTvj
	DVlVKDH5+FQ/EeifO6UwM5UU6EjCyNoPK7iLHnHQiK0+9bpQN2hcgZqMVEDpKcPjOjL5XgFKLU3
	YE4ATjRw0W8o70mh96b+jBlkZp/ze6b9F83bTls4UeZTMxOtuuvF7spX27d7kz1S+nPNxyv4dvA
	oPQgo6ZV0Y6CulG6cmYcOBpIWtmZkao/NsTCGQVRMhZTy2wSUqein2XYyb5RxT3cC7hIjZf2bpC
X-Google-Smtp-Source: AGHT+IHIL01W/2vYUVSHaOWdZoeBBiJZPt1GZrLObQLTJLcyGS+crik1zB/2wbSJS1MzmMrhNP650w==
X-Received: by 2002:a05:622a:a19:b0:471:fb5f:4393 with SMTP id d75a77b69052e-472228c8d61mr218303421cf.22.1740495320124;
        Tue, 25 Feb 2025 06:55:20 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47377e15431sm10832771cf.20.2025.02.25.06.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:55:19 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tmwL8-00000002TG6-3Ugj;
	Tue, 25 Feb 2025 10:55:18 -0400
Date: Tue, 25 Feb 2025 10:55:18 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Yi Liu <yi.l.liu@intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
	iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
Message-ID: <20250225145518.GJ545008@ziepe.ca>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>

On Tue, Feb 25, 2025 at 01:18:43PM +0000, Robin Murphy wrote:

> > My thought is to add a flag in iommufd_hw_capabilities to report the
> > capability, and add a flag in iommufd_hwpt_alloc_flags to let iommu driver
> > know if HPT is needed when allocating S2 domain. Userspace attaches the
> > un-trusted devices to the domains with HPT. While trusted devices can be
> > attached to 'normal' S2 domains.  Will to send it out soon.:)
> > 
> > > With Secure ATS, for ATS requests IOMMU return GPA to device instead
> > > of SPA.
> > 
> > I suppose AMD Secure ATS only works under nested translation configuration.
> > is it? I guess admin may want some flexibility to opt-in it. :)
> 
> Heh, and in SMMUv3 we have both options, with split-stage ATS for nested
> translation, and our Device Permission Table for full ATS, so it seems like
> there should be room for some kind of generalised capability.

Yes, lets not have another driver-only command line parameter but
somthing global managed by the core code.

What are the options here?
 1) Translated Address (TA) is a full physical address and IOMMU does
    do anything (today)

 2) IOMMU converts a S1 IOVA into a TA as a S2 IOVA address and the
    IOMMU runs it through the S2 to validate it. (ARM calls this
    split-stage). Requires nesting

 3) TA is an IOVA and the IOMMU runs it through the full translation
    to validate it. ATS is just used to signal non-present

 4) TA is an full physical address and the IOMMU validates the full
    physical using some kind of permission structure (ARM calls this
    Device Permission Table)

What are the three HWs doing? 

I see #2 and #4 clearly in the SMM spec. Is #3 a special case of #2 (a
STE with a S2 and S1DSS bypass)?

I think AMD is doing #3 from the docs.

What is Intel doing?

A domain alloc flag to put the domain into #3 mode seems like a good
start to me. The core code can decide to activate the flag for the
default domain. Suggest starting from pci->untrusted.

Also, #3 requires PCI topology support, the ACS flags need to be set
to route all TA's to the host. The core code should check and validate
this before turning it on.

I think #2 can be requested through the vSTE on ARM?

Not sure how to setup #4? The core code also needs to detect coherent
systems (ie CXL/etc) and refuse to do anything other than #1/#4..

Jason
