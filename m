Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D38E1DDC14
	for <iommu@lists.linux.dev>; Tue, 11 Feb 2025 19:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301664; cv=none; b=NNADEwk2bbu+avbDqVMsJfExT7a/NuY/uxjmmhthjz5jxvHlPUpyHFtD1G1A4GZXKRiADC9bGIMzmY4QCze5LIoTiLRIbxjHcmbH9FwNZyEPTJxcFQ2gly24JxI/cqgKzLAFT0ohk+WQGxsgpdaAAdf21aY9uhWvMlGFdfJqMmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301664; c=relaxed/simple;
	bh=9f8NwOeHOHhxcpJKA8SlKQgQxAg5JH1bD2pn51uqAzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHeZzOK3KdeZU7sVihciSnKDkfw4KaAACHQcY8O6B+daVgi0zvJYS6BP65w1J8Uj+aBuvBNefbJ2f5+fuD8KZSBeIeJF8fSWckcxgOB2/ZoWKq/wXHr77nOwSvv+WaZysJ0DGPT7xflGRJ9j45x9yelYkrpguqyyogZmUymukNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=NIg+s4yJ; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="NIg+s4yJ"
Date: Tue, 11 Feb 2025 14:20:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739301658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8mNRV1XLqXF4FA7V0dC+d4pFd/k0iKqQgScUbDF9pVA=;
	b=NIg+s4yJTADX9Ou20CmtLuX/odZ6Ag8iohjaieOJUj6ZkCBp3PFYrg+T2VljxOmdMHRaY7
	6eEciAukGKMdz1PnOgkbW07M8pDAOUQjkihPCUqm8GO2/VLUgXCfv8wAg0RSBHMmH1kVDW
	ft4zRgQCEr5BI5npQfzpyFnJAmGKqUYoCH1C9UCAwGVd3+8xU8qVEPOKK2UGN10WKogzd7
	w5iuP37wgfaOr9FaRNcWUYblzMMiaLP8nfH5HyBktcwNa5HFjrRY26x6GjaxHD4B3Wz2gL
	gXtyBUw0LO6jqOppiMSlbm4/yeXYv2hzARkPnFRWag6uuwQtb1nqzLvmk6LOCg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] iommu/dart: Assert !locked when configuring
Message-ID: <Z6ujFKvD7hCYzymO@blossom>
References: <20250210-locked-dart-v1-0-5d97fe247f35@rosenzweig.io>
 <20250210-locked-dart-v1-5-5d97fe247f35@rosenzweig.io>
 <756ba6d7-b18e-4139-851b-496b1820117a@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <756ba6d7-b18e-4139-851b-496b1820117a@arm.com>
X-Migadu-Flow: FLOW_OUT

> > Configuration is only possible and needed for non-locked DARTs and will
> > fail for locked DARTs. We cannot try -- assert that we do not.
> 
> Except now we absolutely will - if a locked DART and its client device are
> advertised to Linux, instead of gracefully refusing to touch it, we'll now
> attach the client to a DMA domain, firing a barrage of multiple WARNs in the
> process, and give it DMA ops which still cannot work. I'm not really
> convinced this series on its own leaves us in a better position than we're
> already in now... :/

Fair point, thanks for raising that. "Fortunately" the upstream DTs
don't describe any locked DARTs yet.

> How hideous is the rest of what's required to actually make this usable?

It isn't... pretty, and it's going to be ugly no matter how we slice it.
Unfortunately the display controller DARTs really are locked so our
hands are tied here.

When I originally wrote these patches I had some hideous hack in the
shared page table code. I'm thrilled to see that Janne rewrote that code
to be local to apple-dart.c, at least:
https://github.com/AsahiLinux/linux/commit/d90cc3590ea460e1c574b4b7c47fdafb2794af6a

I'll include that patch with v2, which makes the locked DARTs actually
usable, and restructure the series so we only probe after that commit is
there.
