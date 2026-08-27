Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DCB486B8C
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787847549; cv=none; b=Ej3FM8NKWeWfGQ0K4eF/hSoE0UpCHr+BoDC/r6Tf+Z6aCP1NodHxqzB2jXtrX0IXCIIQ4ccl8D46tPgZuKKtisAGmTlIAzhhG9uPHkBCfK5YtT95hyl0qo2efuUJQ6GS3mDHNphWoqTa2zMn8i5Y/FyiUM8aeyWmnSrhkfECgvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787847549; c=relaxed/simple;
	bh=DiUjG0T0zuWI7L/yvvGgeVYz8NadRp7w7Ygor662/N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Suro/HtlVsfMmsjUCmUnLU/YblKfmdbu1jwMD689xscXNotell37R7xFqoMk2rQPjGJAvQROJBAkGrAUaILQB2xRvps94flYC49RLrG0+G+Z0SdGAX2Wfj1TT7YdCUTOPFOH9mF58f9PkiDiMfKZMGV0Doe0u1KFaCOcjZRmasU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jtxqf4tP; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jtxqf4tP"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso808366d6.3
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 09:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1787847547; x=1788452347; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PHNKzqddJq8qH4vR69ILQzFreGWmgpWijEaEyQN0PLk=;
        b=jtxqf4tP0VLf/xeb1Hm5xD5408HQWQk/WN1FZS91fa44chSk2IdiX9VkK1u6rqblyc
         o88wrK96aeW4iYYmh/hbM1J4XOFWD4zdey8qRDrZsO1oTxLxHqrmvT8lNdadIBW4rLUd
         l8ZAoc3pE8BFSIkFBWWv7QCIuTJah34AHDKtXBepAoNBnUxuEXYnjgLBoFEZBwOa34SD
         /TSlPqW2pV7qxRN4t2TrQ9tmbtIEuC56NxNkRS1Q5w2DX+3iMpgGTpT/wSUlcyIvtEu/
         l8GLRS488vGz+QLIXXFy0hhN+AnT3f2MwIu2GCPixEEcLmktCgQ+O2iajbWuIf4nid11
         ECZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787847547; x=1788452347;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PHNKzqddJq8qH4vR69ILQzFreGWmgpWijEaEyQN0PLk=;
        b=fs+W6HWhyihf02N2/SqIvw0ax2Sbs9g4+Wv9P6VqlxE81J3nKd4WTioocAAXcRm7Du
         iEUqV+YSP1YH0p56rRPko8ZdibqPMySVUYI+VhKACkVQ/fG13L/+aZbU7qCHWSzAZgit
         VMdZnNS7065u0E1mD0SyglAIfd28+160BB66rKaFXqTqzH9tB751iSSYwC3XuGSFBezJ
         8pweymrpBE0WtH0LnDbcUFDZHeJOinZqS/OsH8dQu6pWW61C4Zu/nBnwrmArQ70LETiP
         NpD7N5e2NTGbXjxYXIZubTabkln+mlsm/ofiDjSQdiBsFdtx6WDIoTgojd2snAEG+NOd
         sKPw==
X-Forwarded-Encrypted: i=1; AHgh+Rpqs2VQe2pNDXPY9bZPLuR4K/hB3WJwN4LZSRrDvcO6Y5k421+Yre//a12YGmNOBtSf07YR9Q==@lists.linux.dev
X-Gm-Message-State: AFuF++n4kq2tCbPKiO8uTxd7kogMBCZFFFjrcvmGnkDcAVwdLctQ6Vwx
	PbeJMr/mBU9yptdSw9zJrmQ0IFFfbzdaendHgxjkIJtIbU3YJeSnBnyDUowmzAUXXc0=
X-Gm-Gg: AR+sD120XYJnIDSSqhcNKo3F2EJZS6w5Nhy5NBsfFnFtIeSzZVt5S95UN232MFWOh6w
	RmXUsSjQhSWWGZ7fBNT4D9SPNAt1XFnruUoItcxAA3nmoZG8upRp0/tp2NnQEXnZLzeZ8RtCwGQ
	2ExlGUOeSC1AhqTZNwCBgE2rC5250kRugJXXRY76kWeXpijSYmOrocUDa8xAZicBY0zZIpRC7RD
	eDr6mS44sbbRxcXX7IOFudOJdkmU12B3MCNLui4sR/Ol6URHGgU79yCV7trzlQ1H7iOqU0n9MkZ
	WJBtUtc0HR+8jDhlnc5+Koj8usfCBhHP1ZKGVlszRsRgrwoV8lDLceMZ/wQgCwWncGgRaVL3JC4
	MMoGVbWStg6zfBfS4kgIV5/T0Zonx5AXTSSU36gLar3jvjgo99gJsdisBLIMhruJvNmu7sEeEjU
	pQE1RTboGSXX4UjeXw6tAJ3++nbwCBsjaMGbn5vF+xWwJSKGDErmqt5rrsyxxri3oZVq1q5WXh2
	Bjry1XDcyDEeMntU+mb1Dav650515KwNwjC+WFu6tnEFg==
X-Received: by 2002:a05:6214:5b0f:b0:90c:5947:7e60 with SMTP id 6a1803df08f44-90ce0c3d7bemr5926226d6.4.1787847510292;
        Thu, 27 Aug 2026 09:18:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cd73fc2c9sm19944946d6.35.2026.08.27.09.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:18:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wzco8-0000000G4Wr-2czS;
	Thu, 27 Aug 2026 13:18:28 -0300
Date: Thu, 27 Aug 2026 13:18:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yuanhe Shu <xiangzao@linux.alibaba.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com, smostafa@google.com,
	praan@google.com, skhawaja@google.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommupt: Drop pagealloc references during domain
 deinit
Message-ID: <20260827161828.GA3769797@ziepe.ca>
References: <20260827145855.1616223-1-xiangzao@linux.alibaba.com>
 <20260827145855.1616223-3-xiangzao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827145855.1616223-3-xiangzao@linux.alibaba.com>

On Thu, Aug 27, 2026 at 10:58:55PM +0800, Yuanhe Shu wrote:
> Since commit b948a8722848 ("iommu: Fix up map/unmap debugging for
> iommupt domains") iommu_map() takes an IOMMU_DEBUG_PAGEALLOC reference
> for every page it maps into a generic_pt domain, and those references
> are only dropped by the IOVA based unmap path.  When a domain is freed
> while mappings are still installed, pt_iommu_deinit() releases the page
> table memory without dropping them, so every mapped page stays counted
> as IOMMU-mapped after it returns to the buddy allocator and each later
> allocation or free of it reports:
> 
>     WARNING: drivers/iommu/iommu-debug-pagealloc.c:91 at __iommu_debug_check_unmapped+0x4e/0x70, CPU#0: init/1
>     iommu: Detected page leak!
> 
> Freeing a domain with mappings still installed is not driver misuse:
> the deinit contract in include/linux/generic_pt/iommu.h only requires
> the table to be removed from HW access and caches, with no requirement
> to unmap first, and the kunit suite itself frees domains with live
> mappings in pt_kunit_iommu_exit().

It is not misusing iommupt, but it is definitely misusing any iommu
API built on top of it. How did you trigger this?

> Verified with the generic_pt kunit suite as an in-tree reproducer:
> running the x86_64 format's test_pgsize_boundary() with

If this is the only trigger, then it is different testing things
interacting badly and I don't think it should be fixed like this.

Probably have the kunits directly unmap as they were being lazy

Jason
