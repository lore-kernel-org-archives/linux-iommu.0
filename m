Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4C829827E
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778174344; cv=none; b=DWo7igG70876Y01a9e5RPAG9qEB421GW7kxljezrUbWpOceHWeHHUeb2OPtjE3PLPB5omD7S+AEWJaLg9yUMPKZjt+4cBHhYT6VUKQadAY3st5XG6pdEjGZj9d0bb1TLO0pPSyEu6Gg0OWCKvXz5Ofz+6NhLQ9/jI09DzUAvv9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778174344; c=relaxed/simple;
	bh=PUtyysda3XYtgOF+UUHhlUIdPIPNtXC3vJYjn4UVMCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAWmAHKIkGPkJW0o3e41Z22p15XW8RHIT2TnEVjPkuIonV6pbn4bEprWesQaxkRiKrH3C/RVxLDKOsW8HOmrbyTZWGKkId+aKJC2H95FuCpNZ7RCdb8fiT0cx/swMrpxThG09T+Bi+g58fCenxVMyR8DGafQ6aHDop/OOQwmVqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gQhZVQ/Q; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gQhZVQ/Q"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1648320E3;
	Thu,  7 May 2026 10:18:56 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7BCB3F836;
	Thu,  7 May 2026 10:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778174341; bh=PUtyysda3XYtgOF+UUHhlUIdPIPNtXC3vJYjn4UVMCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQhZVQ/QHQ48waSzAl5KvAa/rqxhGQSxZ3YubpSN0ZqunBMArzl/tnQr49SV7sG7U
	 8KZnLGjbDEARXFtomTWPvOYbYmq/7cG4pMaA6USbL8Xqeb/wir8p5vmxMw4Qd6cpNL
	 2QI+ThQAFuevStVOjnTHdvXgmrlX6YWsaNLP83oI=
Date: Thu, 7 May 2026 18:18:57 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	m.szyprowski@samsung.com, will@kernel.org, maz@kernel.org,
	suzuki.poulose@arm.com, jiri@resnulli.us, jgg@ziepe.ca
Subject: Re: [RFC PATCH v3 3/5] dma-mapping: Decrypt memory on remap
Message-ID: <afzJgQSN0ROM3lEb@arm.com>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-4-smostafa@google.com>
 <yq5atstdanx8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5atstdanx8.fsf@kernel.org>

On Tue, Apr 14, 2026 at 03:01:15PM +0530, Aneesh Kumar K.V wrote:
> Mostafa Saleh <smostafa@google.com> writes:
> > In case memory needs to be remapped on systems with
> > force_dma_unencrypted(), where this memory is not allocated
> > from a restricted-dma pool, this was currently ignored, while only
> > setting the decrypted pgprot in the remapped alias.
> >
> > The memory still needs to be decrypted in that case.
> 
> For ARM CCA, we cannot mark a vmap address as decrypted. I don’t expect
> non-coherent DMA devices to be used in an ARM CCA configuration, but we
> may need a way to document this in the code.

I think you clarified what you meant later. The vmap here is just fine,
we pass pgprot_decrypted(). The key is the dma_set_decrypted() on the
page address before being remapped.

On arm64 we probably don't care but if we want to enforce it for all
architectures, dma_direct_alloc() could return NULL if
force_dma_unencrypted() && remap (maybe together with a WARN_ON_ONCE).
However, the proposed patch is small enough to cover this case as well.

-- 
Catalin
