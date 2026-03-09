Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37B33B8D53
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773062134; cv=none; b=bQxCS+/8wYUM9REUrFTZv+4SXzCqhb43Vr8mFT/iK2xeBrV3TFEmgF5vaUQ9Uw+YjQZGr6IRBZJKvI3yF0uH8k21cQDhXBfQRkHQLNTFIcAkS7BtNcyZFiWuwk1hYPt4xRjrOKDbdEKAwKKMP//UGmaSC7Cwmxy1udfdh0oKGFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773062134; c=relaxed/simple;
	bh=UbKRPGurvkeEylighvGv7GG2XxMvDn6WSSd9/y7ODUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXt/6R/mmFSTlRIgaiPA4Jx1oJpziJUR/UBsS+Vu/CYZ0qlgdvjYiO90gRP7pptzcCU4qZ3JGTdo9MYVdpq5VmAeb7yaPL41UtSKA+yXDTiUBY0VDopZbxZnRX2hC0OU5iIuWVxCYNXM+NGp5KUZZcDimJvkc+3WzaiPKrL2qPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eUxvrxai; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eUxvrxai"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cd75abd09dso281899985a.0
        for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 06:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773062132; x=1773666932; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JEXl2Wcr1hEZjBx3v2qoobpIKwPw4w6oHEBSBd3/8YI=;
        b=eUxvrxaixDvqOKJhaLCAgIvKKDbhhNkB/MslbGMxri6TNeSnwt046Yds6HJSQLjTmo
         msOXlgmiHh8NuEkZLIXKOr4wpzRZ8PM72Q2IeN3uPCDTkaEEaKWPIA9QY1Ck98fCpkum
         OzKmXeEojC3I33tnEuXjZZLdKSOHU3ieZCxbOjHCWQqFzUB2eGxAqGOWUCc6ZgUyDh1r
         owWJxIuqfO+EKWSk0qxgrVfyufmA9SSqg4x77QFpy2TM4lMFZH0zdPxq8rI45lndNhxi
         HWEr5010jguOxKlXEMqPNRNgO/Tfdy4kkYRM+bcoGRebP4ZPVT1ppliZA9UInyg8bNUv
         Afqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773062132; x=1773666932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEXl2Wcr1hEZjBx3v2qoobpIKwPw4w6oHEBSBd3/8YI=;
        b=ipjDeOII25lX6sCo9zqMHweBtiERv4X6vG9amRPjWI7Gi77ZJbqXvAuA521e6iZzym
         WtnHaeZ36tHw3k01PrURYQ7RVnG/KBW4uuwb3GRu0MlKpMa/f+AFucUVMHZ7+6oNWuck
         dvZqcpFo8i8xwfGxmnKlxZXZGyXFGaLdX5Bm7t1KeKG35nWaKbywOHz/PWpMvUpvbLJV
         UrPeAlXLm4uO3Dwa8bFUlxjlVtRYdEluIB9rnxHncn9WNWOmZELLeHJgO2YB34FJk/th
         pC2z1BUklpus1xm1XR0taty+EpqSBEAnXAshni7gNjvhNVTJ2+PuQ/hvDd4F6xUGTlKI
         /cow==
X-Forwarded-Encrypted: i=1; AJvYcCVOxNG4S9kPfxnNY5VBitVvgRlszxNPXHo5e3HVQ/+7msftDNjl1ZBVP5Q8v2TMKj+mzLk0kQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywt+NWW5Nc9ameRuhwuI/+iKc0U1wHHtprWKd/EoaLXN7T8VdlP
	PSpsWic27wNVLdvxv2a5fz+1ksp+SBs2qY60OYmDSZqHCEERFhmf10pY4UuNJ1SjdYU=
X-Gm-Gg: ATEYQzxB68mjTCYVXBa0T/lfW+AnAHB1I8mBTFRy+BUiKOJis4d8xW94lcqLxCrNbXH
	1vT09NSqyH7vjbolOso9/Qhd7E8LLRlf2Uy/3+LRXqyCCObasdpNxVsNdG6mAW7sKzHoqmuBaUG
	q6qDhB8x4XP0GSwK1lyuttiENgAfi7OCFfCQf2BI+/J/lrpS31od21dZPFDKAMS/++/1Ydpg1qM
	KcUhIwyeM9S4SFm9nMpAHDpep42vu5nQHpR6RWp5AEH+ZSvvKgfTrM9HzphrleVHVbET/uqePD6
	0JMBgKOUi6ajjAG4hlLFrvU4umRg1oskokbB7EsPvMqjxdgVdpVn+xGmhnbkgQ21rz7wQpED6f2
	d/ZvDWpDXdXlptWM18SmjckC49RuiAD4CXf/1qUXGW/OJguMGGf+uB6nUPFz/KSpOYbO7dP00yz
	Ncw+0DuWjzv1m3lZDCcfCTJq1U/PHuj4yzFqjrf/Xeto9Lk8vMlmC4rZLMw06HvR4wJxMtKGENy
	+C9oWnA
X-Received: by 2002:a05:620a:4381:b0:8cd:76fa:1be1 with SMTP id af79cd13be357-8cd76fa1ff3mr1023224185a.14.1773062131558;
        Mon, 09 Mar 2026 06:15:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd7e857037sm378431585a.20.2026.03.09.06.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 06:15:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vzaSI-0000000G6JW-1RIq;
	Mon, 09 Mar 2026 10:15:30 -0300
Date: Mon, 9 Mar 2026 10:15:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com,
	sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com,
	aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/2] dma-mapping: introduce
 DMA_ATTR_CC_DECRYPTED for pre-decrypted memory
Message-ID: <20260309131530.GJ1687929@ziepe.ca>
References: <20260305123641.164164-1-jiri@resnulli.us>
 <20260305123641.164164-2-jiri@resnulli.us>
 <20260308101948.GO12611@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308101948.GO12611@unreal>

On Sun, Mar 08, 2026 at 12:19:48PM +0200, Leon Romanovsky wrote:

> > +/*
> > + * DMA_ATTR_CC_DECRYPTED: Indicates memory that has been explicitly decrypted
> > + * (shared) for confidential computing guests. The caller must have
> > + * called set_memory_decrypted(). A struct page is required.
> > + */
> > +#define DMA_ATTR_CC_DECRYPTED	(1UL << 12)
> 
> While adding the new attribute is fine, I would expect additional checks in
> dma_map_phys() to ensure the attribute cannot be misused. For example,
> WARN_ON(attrs & (DMA_ATTR_CC_DECRYPTED | DMA_ATTR_MMIO)), along with a check
> that we are taking the direct path only.

DECRYPYED and MMIO is something that needs to work, VFIO (inside a
TVM) should be using that combination.

Jason
