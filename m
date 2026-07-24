Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0C3320A00
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921790; cv=none; b=OQvfu6UgsJDCowf8dX3vVRbHB2o2Paj22e4xIYzfs7YHGr09h6Ra+fYFdwIsVRCcMMNGoEi5Qu/6Gj/rXePd+LzU5cjeVZs8oiAcF7GUQWza5niUDVxiACus3+rNVJYe8/q8nTw0iLs00iovQsf+srU1cEqFSDmT28R1RGPf3Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921790; c=relaxed/simple;
	bh=aMya5tQiN0F1uPgAuPCS0suQWAdKZjYIqdsg2smfte4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L90BYEaaG490HisCGO4GX0v7hhD3X0pqzsphx0mv9YkmlZrJ+DjPNS77y0Q2lPtbGI0zy9cGNfdfx5D44MgL09EMRnPDEDlwrgJXRe0csclszG1dg+iuwfj/HBOe+wcKbBE7LvODLxgzkmT1iTsExdBdfpNJ4Eptmrsj3Xo6zZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F21+5UUN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F21+5UUN"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-495509b08ebso755e9.1
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 12:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784921781; x=1785526581; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vvsKfAGO1/G1RkKRO+bqMq0Jxexy/5+6v+o5lfiDScQ=;
        b=F21+5UUNZ1UgBzk9tgUp+HC7fOjKMfaTlfqpaa2KqgX9aH2tI4lDwZEBH72YfNpylI
         qROW/1G5MQAU31t7wYNKs8ID1sH/UxPWhopQyNNQNzY+4TF84S2qiio3XKr6tys3CYIB
         3MEexcQL0n5djKXivawKyU0z4QyCHqLlkU4tEqdRgq+L7667faGV1F3CGqNFXC8Ql9WP
         EY/mix2AuugDorQPJ9jVTTuJTVPwGnfxM9BzZ0NVIddxSguyIrDxGUWd1+BLOce6SRic
         tAbgzjG0PtR2tVpPliMz0aGzagCP9qWRFXIVd10t85JPBrYy7M2kRtB73gDeh8IMsE4l
         aUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784921781; x=1785526581;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vvsKfAGO1/G1RkKRO+bqMq0Jxexy/5+6v+o5lfiDScQ=;
        b=HZ7PbxIckQfRDGxPmmcucZqkC7t4Ps20ix1cOWGPiASUUJ9CjkL+VUwq6sOm7Zr7gq
         coUO4I3Iwhx+ChWCJbdR1NnFrv9ErjCziTC/wVkxDenxNu5yHHymchu+heQAj9OfjU/C
         Fu3i2khcTrNsLnlZ3nPziy1BsSLUEqHgFV1LPrg7ZMkos1TRsCntGooKhhNo1JDmdDmL
         UvFg4Y9V/R0WTpfQMM5nbInLZzgE3OksVUy/edr0AQqGLGNTo2vMoz7kFg6ImTPDhty6
         3aCoPyTtvgzjtYpVRi6fInkNl7/IFc07MYFv+FqiwwazGZkCgh1WpBcMktExbBrPUwGl
         BQPw==
X-Gm-Message-State: AOJu0YzqsHNBhZdyZpFn7NUoy+BqI2kbzEWrnidomvn1o4eIzjmIkaVt
	QptWawzducQBoI/NHejXy+kCo3ON2efXNh8jeaJgONARqpdnkCQR9R+dAt5GCxeU+w==
X-Gm-Gg: AR+sD13n5SkV2mxKByUOte1xGsSVbC1PTqgIwkW4fTMJdNtEGIPX3Mw1lbo3zBnZbb1
	DbGsrPhh8mUB2ELG3lnUucXJFlBwUD3aw+06w2brrBILGfZYFZOJ656xh0GICXOFKhxhtmAVspm
	Y/dETLDwdVawwy9P44Ld3uCgpLNHrGezl4sTXj7LvAsEbfZ9gpzMQ+kvv8bkm2PjzBClTOSoFqa
	Y9fCxw8hCXztHfOmWBAoWpshBpfjkSTv1rKYqUa+EBlT+rbzjFHEHjtQye7vR0tpLnrt8YVL6UB
	oRrUc6QcexIOSVcPhSgnqliZcAwtpNykngEutzpep3XgEh+2CqZAxCs5rjiI1ZjV52/xp5zSk+U
	wdxJy4AXByOjixu2GaGkqbvakF5fnPfcCwXWci1OjsN8C7bv2rBjEgE/5+yQ6jg92NKnINXL4g5
	6aY59BYj4SA/ouESE/rV6opdXooi142CnwVbjSMs6xQgpkPFdT
X-Received: by 2002:a7b:c311:0:b0:48a:623c:8859 with SMTP id 5b1f17b1804b1-496b4d58803mr116215e9.7.1784921780558;
        Fri, 24 Jul 2026 12:36:20 -0700 (PDT)
Received: from google.com (220.60.76.34.bc.googleusercontent.com. [34.76.60.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b480fafasm17596165e9.0.2026.07.24.12.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:36:19 -0700 (PDT)
Date: Fri, 24 Jul 2026 19:36:16 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Pranjal Shrivastava <praan@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH 0/7] Use the generic iommu page table for SMMUv3
Message-ID: <amO-sGlWsmtcPsDZ@google.com>
References: <0-v1-807e2d1a5efb+e1-iommupt_armv8_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-807e2d1a5efb+e1-iommupt_armv8_jgg@nvidia.com>

On Mon, Jul 06, 2026 at 01:29:06PM -0300, Jason Gunthorpe wrote:
> [ This is the last patch to move SMMUv3 over to the generic page
>   table:
> 1) Organize the SMMUv3 invalidation flow so iommupt can use it
>   ..
> 2) Use the generic iommu page table for SMMUv3
> 
> It depends on #1
> 
> The whole branch is here:
>    https://github.com/jgunthorpe/linux/commits/iommu_pt_arm64/
> ]
> 
> Introduce the generic page table for what the ARM spec calls VMSAv8-64
> (ie the long 64 bit PTE page table, io-pgtable-arm.c) and use it for
> SMMUv3. ARM is by far the most complex page table of all the ones
> implemented, it has the most runtime behavior variations and a lot of
> features.
> 
> Like the othe architectures, the page table itself is supported by a kunit
> compare test that runs operations through both io-pgtable-arm.c and the
> new code then checks for identical PTEs. This is on the github link above
> but I don't intend to merge it.
> 
> The existing kunit tests for iommupt will automatically cover the new
> format as well.
> 
> This is the final series migrating the SMMUv3 driver over to use the new
> functions and remove io-pgtable-arm.c usage. In principle the other iommu
> drivers that use io-pgtable-arm could be converted someday as well.
> 
> Robin once mentioned there were errata about contiguous bits, I only found
> 3673557 and it is mitigated in this design by always using RIL. I'm
> assuming that RIL is always available in SMMUs that are effected by
> 3673557? I have a patch add a FEAT if for contiguous bits if that is
> required.
> 
> Jason Gunthorpe (7):
>   iommupt: Remove the sanity check for pt_num_items_lg2() at the top
>     level
>   iommupt/kunit: Skip test configs without supported features
>   iommupt: Add the 64 bit ARMv8 page table format
>   iommu/arm-smmu-v3: Remove io-pgtable-arm from sva.c
>   iommu/arm-smmu-v3: Move the DMA API comment to flush_iotlb_all
>   iommu/arm-smmu-v3: Use the generic iommu page table
>   iommu: Remove pgsize from iommu_iotlb_gather

I went through the series, it seems the arm work plug in nicely with
the iommupt stuff, I left some comments around, but I feel that
patches 1,2 and 5 can be sent separately.

And patch 8 it too large to review, it would be better to split into
3-6 patches, I was thinking: base support, dirty tracking, contig bit
aarch32 and kunit.

Thanks,
Mostafa

> 
>  drivers/iommu/arm/Kconfig                     |    4 +-
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   13 +-
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |   45 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  287 ++---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   18 +-
>  drivers/iommu/generic_pt/.kunitconfig         |    1 +
>  drivers/iommu/generic_pt/Kconfig              |   12 +
>  drivers/iommu/generic_pt/fmt/Makefile         |    2 +
>  drivers/iommu/generic_pt/fmt/armv8.h          | 1124 +++++++++++++++++
>  drivers/iommu/generic_pt/fmt/defs_armv8.h     |   23 +
>  drivers/iommu/generic_pt/fmt/iommu_armv8.c    |   13 +
>  drivers/iommu/generic_pt/iommu_pt.h           |   14 -
>  drivers/iommu/generic_pt/kunit_iommu.h        |   10 +
>  include/linux/generic_pt/common.h             |   42 +
>  include/linux/generic_pt/iommu.h              |   73 ++
>  include/linux/iommu.h                         |   62 +-
>  16 files changed, 1452 insertions(+), 291 deletions(-)
>  create mode 100644 drivers/iommu/generic_pt/fmt/armv8.h
>  create mode 100644 drivers/iommu/generic_pt/fmt/defs_armv8.h
>  create mode 100644 drivers/iommu/generic_pt/fmt/iommu_armv8.c
> 
> 
> base-commit: 8cd13c14dcc29762766ff9ca2f67e3bae7c7cb77
> -- 
> 2.43.0
> 
