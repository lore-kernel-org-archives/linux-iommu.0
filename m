Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793288878;
	b=WGSvGSofT3hNywWDV3Ad8e7o2geE/f5QbJw/xlNDy62wOBq9rXcOjBK9l53JTgrgWU/6
	 MdFA4BGnmpOSke+6taTSLbJgGSeF8ADZNRv/gCOHvEDCk6GQi4Q6k+CksqVsPltZ+Hg29
	 mAnMSoNUnWsHlhAp6rzV6TPIQL4+GCTxPdCNIiWEeldF1yYkvsw8GGi71mzoIBKOFXaXf
	 GjQzFpu5plVd2xU6hTa2Bd7bRZdf7t5Oxp+1/o4+4WzwOlsHjUpzzNnFbsyz07snlGB6S
	 1bBvewVMWjraHa41cm3QH8FyU5FQbiJgk2WYQEH+GA2y5UAQ5R2cjhzmXqhllQR3VYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288878;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zYUOhsZYVKoICLqfPzUowk6K3qSd3IEp/G51Twk/WFs=;
	b=UvV6nh5AYGGsXG7FUZowxka2iXpOYKqTvxc/kLieKbSN1H7Vm95g7Q9KPoPQmiCvZy9d
	 CrYexR3STzicFzPWE30mqD5ORkGtiWFhuqKGnza7bh9ciDPA9AwiA31RRe1LYTD+WCnID
	 /9+9wXtmz2291/h6gcNthuGGTgi8IXqZiZJar5ZCsIPPwyFwkVY5NBcUB03JCYyg2Gi+f
	 +dWEkdw3GE7L+0Uw7hbjMpYki52knUE2TCKlvM8HNCBNUtq8sJ+BmoXnm+oie4BExjQz6
	 uaUDh0XsYr1QOgJ+ctkzHNUBcVGU+Vd3c/K6bnRgLxZQOsrI7FbcbJzCvDVbiGRyaHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mx6fRP+u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E370606A322;
	Thu, 29 Oct 2026 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mx6fRP+u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714041F01816;
	Thu, 29 Oct 2026 15:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793288877;
	bh=zYUOhsZYVKoICLqfPzUowk6K3qSd3IEp/G51Twk/WFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mx6fRP+urFBI7/w3piKIXKdAEUQmlOCS+RelWOz8TbQwWt/+WQ1UMSJXClP1y7moY
	 N/Uga8qeP+eYzYxKOrxitAMjvDbVYNYj/7JpUPvKGmW+fU5+WnKY++k0u2pB0YOeZN
	 NwwJhZhc0kveUGrK+PikOxy5AAHM+BJ8CxErRlIijxHgw9JJK0ndrgpJIDxv7WKqiU
	 +Ode/0Am0XCEYucUH7snHCz3GMaJmk0+RhDc1h+Q3bkgw+NmPFPeIS+feasitQMH1B
	 tW91DEy1oslFxMKIX1NvQinPFwqcZNnxauLrtDbiOYmCiTRbYNXMzhMpXOyW/xqVDo
	 OK7/5JdNQjpGQ==
Date: Thu, 29 Oct 2026 08:47:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 robin.murphy@arm.com, tglx@kernel.org, dave.hansen@linux.intel.com,
 x86@kernel.org, joro@8bytes.org, will@kernel.org, leon@kernel.org,
 mbloch@nvidia.com, iommu@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [RFC 07/11] eth: ixgbe: use dma_alloc_coherent_node()
Message-ID: <20261029084756.06a2a827@kernel.org>
In-Reply-To: <abae1606-cc43-4ad4-b486-3a6e6aeed1b9@samsung.com>
References: <20261027022528.633359-1-kuba@kernel.org>
	<20261027022528.633359-8-kuba@kernel.org>
	<87ecdb5x8k.fsf@all.your.base.are.belong.to.us>
	<20261027085133.2832f2f5@kernel.org>
	<87wlr33z6z.fsf@all.your.base.are.belong.to.us>
	<20261027112003.330bbded@kernel.org>
	<CGME20261029084721eucas1p20638037770ab8e64e7c25196b49206e0@eucas1p2.samsung.com>
	<87se1o51wu.fsf@all.your.base.are.belong.to.us>
	<abae1606-cc43-4ad4-b486-3a6e6aeed1b9@samsung.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Oct 2026 10:17:07 +0100 Marek Szyprowski wrote:
> > Agree that it's odd that the caller need to know CMA internals, but I'm
> > not sure retrying the entire DMA allocation in the helper is the right
> > way. Can the fallback be handled in dma_alloc_contigous()? I would still
> > not do that in this series, but keep as is.  
> 
> Definitely, I would prefer to add such fallback to dma_alloc_contigous().

Alright, so to be clear the plan is to stick to the "may or may not,
good luck" semantics.
