Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9B051A743
	for <iommu@lists.linux.dev>; Fri,  4 Sep 2026 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560673; cv=none; b=YKct4JNjd9sZCV0pGC15AsGcErc6lt6yXTgsQEk7iaWIMdYT8KMh8aF3/mvVXj5w7IwqggS5/V+rit5DUM6BIuqB+5QQxFatVIlRJBISMCnKmwMSsqiSMotTbDjGbYcrluv0aka06wtLEpPoDKzlFZIxtZydtPwU7gUjTG70rLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560673; c=relaxed/simple;
	bh=3yfBn1WOKGcBed81Nlc6oSVXKJPNrdGjHRd+VzAbRwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKZp86e5XdzvLGBNrYK0EgGV+xg5QzXu8BPMJpokkQCfY3fgAf20HSFjZk3H+JqWhuDvO5k+9rVkXlOC4bk53SIEPIC9rVldr0VGSlJYuhh7i8/yvg2PGraKjIRYNMHYuxTmy1L55l1B+Q1ZS3dEO7p29laEsCDeaMHxtz6h/qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CQ/TTvJ2; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CQ/TTvJ2"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso1001765a12.0
        for <iommu@lists.linux.dev>; Fri, 04 Sep 2026 15:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788560667; x=1789165467; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eSoy4tzP5/vZd/n79Ub53Qw/sODynJmx2A4LOY3bVO0=;
        b=CQ/TTvJ2Q4WMwTy4uIxIY0OaVGbv4RtlzpI3b+y79OIKqubRTYhnCg09g/BJUZLvMI
         YN8/hLNPWBHgZNf5I0r5DqCMd0OwfwJuyoIPxCNcetSbKBLeoJBp66PNhdOUtHFM3SNn
         y15NYOpSP3H4BO4Axw5b7Gmtic/l6nrdWuaw2X9prWKsgWo/eD8fdxCggZ9cjJok2c9H
         meQPbrpxNbcVk+4w2B00MImQYL50k79dxXwnbFr21NPpIarXQWLTWXCRaOpVynhYFq/h
         26DXqe7u8FkEbIEc/lJYpUWtw2PvDRH4y3GVUeeIDwQmX34kIfYC+ISse3T3og5QjKfx
         4Xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788560667; x=1789165467;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eSoy4tzP5/vZd/n79Ub53Qw/sODynJmx2A4LOY3bVO0=;
        b=ofyL8CmOovENuU/ekSpajYrbfgmTvYl0DMtBbPjaEkk55ceZ6TpWay/sqoU3o2z5z9
         6RBwWZbcOqMotSpYHAk3q3VbWVLaTOkoXa5yIyyEUYIa6zCqSmm/lwSdbqPm59bp5wCV
         Za6CYPudTpd85SoWIweKEhdrN5nbHCGxNB4KjAHe/dzdQDhjxdErIkbO1yAU34gdpEoE
         A4y/fbiXHeRHWcswxogjwaKar5LrGHbT7HlBP0TgNZpjzySZ4IRctaI9XQQIjzo7wxKq
         KomS4nHnTpD91AbltjuQpteffYjQkl6C/rihV9t1i/JlUFwTBRFNOeWANtP1G+W0sTi1
         wvAg==
X-Forwarded-Encrypted: i=1; AKwUvBwSZ91/NzO02lLKHvcI3BtRzJ4kuB6VVPGLJevge4Ii3qNFTO/Zhh/0ic0JWVoVsV1bbk4/1Q==@lists.linux.dev
X-Gm-Message-State: AFuF++nNLJs3X1W8gzrU5A/Y6JXXIgdxMQ6niOe+LT+ZJZvxYbudi5Rj
	HVQ2nAV53OjEw8XXJTM8nCyT09B9NciVox6yBik4ehvnNQH8d0wmw5hqh/d93GMZJQ==
X-Gm-Gg: AYBFou339EYk2SAro4PL3OtDB9CWbfffKPUxoNxo9HJrcSM7Hk+be4NSDOh5JqBcgMi
	XkY29dwgPsRzdWYCRwnpF4DOqhQpvkhuJ36vmpQBCx8VPxr9i6zfC6btqzlAkPlB4N76eD14ef3
	q5mNOHJtAhL46k22DOuB5jI7XBwCYLtFT6W7XVZBAqdJcuSMGzgrJhsee2XRi3fNETzJjU40Qmn
	gxmPGvgHViUh40el3ABqUcuO8bwYCGyqX/6rUatmskAh9FJZZb0QUtOEIcyVrnMJCX2oxTpdYV8
	9KXdzZ1UzkVytuaFRkhVYid0GvOrywkwHPdioeKFZ7qEq3Jg/fmf/RaDGCW798jWWx468ChtT/3
	FdaJWF7cW/UmolqiYUHpJka9aReGsRdejCYNA3Gkpi6es6G4fsPn579K/y2Fv+6eP0ktWhpvCza
	o6beu3rpOVvQTxVseemOUSLBqa7EIn6rLE9U/Ypv/AUDcR27CqzzEyO4XHvMO15JEUmhWDHFtNM
	GsNaNWE9/HvHL69ACAvvg70R4oHsQ==
X-Received: by 2002:a05:6a00:2e99:b0:84c:4b58:2cec with SMTP id d2e1a72fcca58-8616b26f6bfmr12056954b3a.15.1788560666130;
        Fri, 04 Sep 2026 15:24:26 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86153a1c1basm1621740b3a.52.2026.09.04.15.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 15:24:25 -0700 (PDT)
Date: Fri, 4 Sep 2026 22:24:21 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Logan Odell <loganodell@google.com>, arnd@arndb.de,
	pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, pbonzini@redhat.com,
	maz@kernel.org, oupton@kernel.org, seanjc@google.com,
	bhelgaas@google.com, alex@shazbot.org, kevin.tian@intel.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/3] liveupdate: Move to feature flags for LUO and
 memfd ABI compatibility
Message-ID: <aptFFYqcSiBdMLE8@google.com>
References: <20260903023452.721732-1-loganodell@google.com>
 <20260904160009.GV4157646@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904160009.GV4157646@nvidia.com>

On 2026-09-04 01:00 PM, Jason Gunthorpe wrote:
> On Wed, Sep 02, 2026 at 07:34:49PM -0700, Logan Odell wrote:
> > We're including maintainers from all subsystems that currently is or
> > will be expected to participate in live update to ensure alignment on
> > the path forward for compatibility.
> > 
> > Currently, Live Update Orchestrator (LUO) and its file handlers rely on
> > monolithic compatibility strings (such as "luo-v5" and "memfd-v1") to
> > validate ABI compatibility across kexec live updates. Any modification
> > to serialized structures requires bumping the version string, which
> > strictly breaks compatibility between adjacent kernels even when changes
> > are additive, backwards-compatible, or optional.
> 
> That was the intention, I aruged strongly that upstream does not want
> to maintain a CSP matrix of endless kernel version combinations. That
> is far too much work to push on maintainers. Upstream would do much
> less, maybe only same-version, depending.

We received basically the opposite stance from Sean regarding the KVM
LUO ABI:

  https://lore.kernel.org/kvm/aoSCCTTBn9D5hqzk@google.com/

So we're trying to use this series to get some alignment across LUO
ABIs.

> > This RFC series transitions LUO and subsystem file handlers to use
> > granular feature bitmasks instead of compatibility strings. We replace
> > the compatibility string with a header structure that includes some
> > reserved space to define the features that are included after the
> > feature.
> 
> The compatability string is only a small part of it, you also need a
> serializing ABI that can handle some random mixmash of these
> features. Ie the various TLV schemes that were all proposed. What is
> the plan here?

The proposal here (which is inspired by the KVM UAPI) is to ensure every
LUO ABI struct has 2 properties:

 1. A field to encode options/features (e.g. u64 flags).
 2. A way way to grow without breaking backward compatibility (e.g. so
    we can add new fields).

Each flag can mean whatever it needs to. e.g. It can indicate the
precence of one or more fields (i.e. new fields in the struct), or it
can mean a field now has a different meaning (i.e. union in the struct).

This would enable adding support for new features without breaking
backward compatibility. Downstream users would have to ensure their
kernel does not start using a new feature while it can still rollback to
a version that does not support the new feature.
