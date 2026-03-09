Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FBE3A9608;
	Mon,  9 Mar 2026 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773064958; cv=none; b=D8rnRkzkE37URX3glo+96eJjDKtNbFETpteBCNXDN90YJiIxX5JJm6DPe+LXrgNSgy09ZolMqmo+NARUhEsB5i05Vvk85nWUBmULyawzWAfIwUdLGs1syjMQRithMOfe4+AFslHlOpPyMcGNH/ZchFQAswLAZmaf3IpQ31/7GVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773064958; c=relaxed/simple;
	bh=SEe9AcDd4ntguFWkVF0XZ6xYXFWlhPkDwFkvUnAI4tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVwUmQsJ24fAO9bVpKoNSrvZwD/1DtqfoCTxRwXFilUzKyyQs0aCTDbgrZJCLE9Ob7SD/tkl1oYEmLdfODY7yqdKjOJnGCJKjpi8jbBWF2+GHq0swwczF3gJS7aiYIr+nHMQhNZ097Hz/nuNW5dEB8uqxCsQl5EfXu4Xt7LlyUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFE88Eji; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFE88Eji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEADFC4CEF7;
	Mon,  9 Mar 2026 14:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773064957;
	bh=SEe9AcDd4ntguFWkVF0XZ6xYXFWlhPkDwFkvUnAI4tU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFE88EjioB4ri1nLF+1vx5qcRcBgb8j7Ub/WVDb/xg8T8f2cI8Ax0E3o+G+RwlVkg
	 lZRrk5z5Yhuh4u2NSq7wgOAO86myJk/UwehUGeblGzJJOzUbQ119fKgDrqVFeWnQvr
	 3/bxDqQiy0rlrUkca4bCzmOmm3TiwngjHQiGqMoxgueIzf9DCR6fadme74JHmRE5/U
	 4wMPDfhG5xMHmahG4jrEfAKexnlSrVk7eMJTs3WPOuGA8CSr88NHVa802tpk63JWfP
	 NdPcWZN9UPkoqVNcCarjN37V24lOjTkISEalk9fmTXwCcsM9lC7w2vMLo0hdykgyLu
	 JdjmgJt/KmuhQ==
Date: Mon, 9 Mar 2026 16:02:33 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <20260309140233.GW12611@unreal>
References: <20260305123641.164164-1-jiri@resnulli.us>
 <20260305123641.164164-2-jiri@resnulli.us>
 <20260308101948.GO12611@unreal>
 <20260309131530.GJ1687929@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309131530.GJ1687929@ziepe.ca>

On Mon, Mar 09, 2026 at 10:15:30AM -0300, Jason Gunthorpe wrote:
> On Sun, Mar 08, 2026 at 12:19:48PM +0200, Leon Romanovsky wrote:
> 
> > > +/*
> > > + * DMA_ATTR_CC_DECRYPTED: Indicates memory that has been explicitly decrypted
> > > + * (shared) for confidential computing guests. The caller must have
> > > + * called set_memory_decrypted(). A struct page is required.
> > > + */
> > > +#define DMA_ATTR_CC_DECRYPTED	(1UL << 12)
> > 
> > While adding the new attribute is fine, I would expect additional checks in
> > dma_map_phys() to ensure the attribute cannot be misused. For example,
> > WARN_ON(attrs & (DMA_ATTR_CC_DECRYPTED | DMA_ATTR_MMIO)), along with a check
> > that we are taking the direct path only.
> 
> DECRYPYED and MMIO is something that needs to work, VFIO (inside a
> TVM) should be using that combination.

So this sentence "A struct page is required" from the comment above is
not accurate.

Thanks

> 
> Jason
