Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB9E2D8782
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767710416; cv=none; b=L/6XcNvGgpwdPAXY4JY4cEUMyiQF7xTwFVVPda4QHrORImhTbVB/mKgp6nwjRrCfYIDmLYZVKCfubfcDi3KX118yKeCBP8yjc51brF2M5rPmKCFpXXIcX2MMGC5m/6ZA4tWoG6qm0SQHZi73Dg3ADZ+KBtWcmC4caGtpQv/U7CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767710416; c=relaxed/simple;
	bh=jcUhERBvuJG4nm/yz48ww17FMRWLnYK5ZxzGkzH7o3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTZUaVlxD2q3JZy3C6FPkOCdJah0rD2qRZoMrQ0KCW9JUeUkEv6Pniz2ldvPVV21GvokALv+SSkTxFfTIqadcTL+1zPIqXVUqcH15rEanE4AcLZ4Fc/Rjfeb3k/NJG6NdXFgYr2m+nlJRHKRU2qdT9UgGzqpkHpm4536aJHjb9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hIPfnb3U; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hIPfnb3U"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b804646c718so153661066b.2
        for <iommu@lists.linux.dev>; Tue, 06 Jan 2026 06:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767710413; x=1768315213; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jcUhERBvuJG4nm/yz48ww17FMRWLnYK5ZxzGkzH7o3Q=;
        b=hIPfnb3Uj4szjLsbKRDTDbff0t8LT76tgyBc5cp364xAj4YHp41iOctYcRGxRVcd0p
         Ww0wW0eUUS4Ao7awAqTjnCMOeWhQFM2KHZVwJqGHM7EBDKRv+C76UTBdEGHomev00Zt5
         8q9xh4RwpcN6cv1UqvZtt4OUQW2N6wcCzbRRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767710413; x=1768315213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jcUhERBvuJG4nm/yz48ww17FMRWLnYK5ZxzGkzH7o3Q=;
        b=HAccbfY0EcMqZGjRmiCBYEKjq2o/RWr1v36Sowpv62l7Ap+HTy57nXacnLInGWf2pS
         ghT4CQSUfXgtcvliVYBcJKIw37iOcY0e7dz97/aG36tzoDkd1VMz8lXsbefklJb7DurY
         Ao6kV42izx5KrPumGXelqR8Ks+QzO7b5jzuhIhw0MQ65vew01ZkZu2AzWCvLQgnkCLFO
         HX5eNcAvf4gQz+B/18+guAuzV4DdSKmUgLyb4zWfaVl8P/yVLg0MiZNj0kpX/caBx9MX
         mUC+Q5/H+9ga5qWLssZvqeoORGSKlJngn7MO6+4AT8Squw6hNsVXPtwZkKpQZCtHeRhS
         kbqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT8LNwChBHlPtv5vUMEb7LGPgaOdp58fU6IO5S23nXXuEo80qqJ3nTrk1vBtSiabKNGak8AA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzux+FXOP2eZdSBl1yGi06oEd4yGfeJj40QumcPVGGVvfpR2OL/
	LG1MwwEoZNso1el+VJMJd1x8fJUn3MPhy8F4VG0/KoDZnFqkX55BZC1hQuy1NVKvZw==
X-Gm-Gg: AY/fxX4HB5JrZF60rc84UkJaWRxwrC2PnYLxWRPE46ExAtBtbiehs/FvY/CMfojiFne
	q80xc2i4r8kQ9+5VkeBl2xibhBWtUA+RCgmGsKg0oDWSHB7+QJOk0bSUgVRevRsIVHXx0gSW4cP
	2KpBTqJDR9ZNf4POW7XHVZIzeQhh89qjaIWUF2HH83ycWkavi9nGAJJu8dd1De1FKfwmmPpQleC
	Ga+i1oz1Ah8TvSCSLrhnf0upkxNhNPkUcC+v2c5/TBorQPrXevjn+dvT6vdcxQ/+Jtz6U+Uv0D3
	s20CcrzHRexMGZoWz8qHYQuVuG4+bC0UEqmytbwDTzHh4YnsmQx96QCUnqcFvhMOErbJGsJxll/
	ia1r4ybESRZl24CnVQVpCtX8xsGVCye+7udUUepUp7NJK1BAQqLVIXuh6dLhFQCZWYDj4hV72cy
	HkNnIr5+NGPN4htIuGNrk1ge/AG9SVqIE=
X-Google-Smtp-Source: AGHT+IHTtfwmpLFU19J6g/5nnpsRyu+AO5VZE4NL4Xu8n5k5e9vNbxKoYVvImrZ7+P0+4GequYshIw==
X-Received: by 2002:a17:907:a43:b0:b6d:5bc3:e158 with SMTP id a640c23a62f3a-b8426a677a2mr302223766b.17.1767710412552;
        Tue, 06 Jan 2026 06:40:12 -0800 (PST)
Received: from mitya-t14-2025 ([2a02:a31b:20c3:6680:43e9:5120:2208:3239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a51577bsm237468066b.56.2026.01.06.06.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 06:40:11 -0800 (PST)
Date: Tue, 6 Jan 2026 15:40:05 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	"Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: Re: [PATCH v2 0/5] iommu/vt-d: Ensure memory ordering in context &
 root entry updates
Message-ID: <aV0exRxVUoOaJtVj@mitya-t14-2025>
References: <20251227175728.4358-1-dmaluka@chromium.org>
 <20260105181200.GH125261@ziepe.ca>
 <aVwI_SHHGPl0xndu@google.com>
 <20260105191410.GJ125261@ziepe.ca>
 <aVwZkFQ-iQ7OHMi2@google.com>
 <20260106001418.GK125261@ziepe.ca>
 <BL1PR11MB5271B47577A94CE3780D8ABF8C87A@BL1PR11MB5271.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB5271B47577A94CE3780D8ABF8C87A@BL1PR11MB5271.namprd11.prod.outlook.com>

On Tue, Jan 06, 2026 at 07:48:50AM +0000, Tian, Kevin wrote:
> yeah WRITE_ONCE() is not by definition to guarantee the ordering between
> CPU and device.

Yes, WRITE_ONCE is not about HW guarantess at all, it is about compiler
guarantess. And it is not about ordering, it is about compiler's
guarantee to store the given 64-bit value once, with one instruction.
But this compiler guarantee is exactly my point (see my last reply to
Jason).

> lots of READ_ONCE()/WRITE_ONCE() in existing code are meaningless,
> as 1) between CPUs there is already lock protection; 2) between CPU and
> device it requires dma_wmb() to guarantee the order.

As I see it, those WRITE_ONCEs (maybe not READ_ONCEs) haven't been
meaningless (I mean, they have been actually useful) so long as we
haven't been using any barriers. Again, on x86, store ordering requires
just compiler ordering, and dma_wmb() is just a compiler barrier. So,
assuming this driver is only used on x86 (which is, well, true :)),
we are lacking even compiler barriers, but at least we have those
WRITE_ONCEs, which provide compiler ordering too (although only between
each other, not with any other memory accesses, but that seems enough
for our case).

And again, I agree it is not pretty to rely on arch-specific ordering
assumptions, and doing in-place updates via those context_xxx() and
pasid_xxx() helpers all over the place instead of updating whole entries
seems a strange choice. But that is how it was implemented 10 or so
years ago, and overhauling that hasn't been my goal.
