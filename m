Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263637;
	b=4CothBMQGL0H1wiFT37F133QUAIiF9vkx/x6nHnqL0644JVTGdOhWXHJAQT0oHYxKOIL
	 5bhK4DE6LHnN22M/NkzzyZ9MEFcjzmTDkmcUt2WW/7Of56brr00D5l4tRP3C7mPCDL/sj
	 aSmUDBPV47R4yqLC1KpctpfD+r/wFr9NnYhmVXaYW0PxHsGeY7ugmF0PVepIyaVy4NB1t
	 IjnFp8N/rqGf1Lmr5YTOCL8RJCCwqN/usOkyJzNFDQJ70qJw0VPS/tOqCRGk344HZtjTp
	 UjYPz8gRCgEx9j34AMaQ1Zau6BrNSzL3Wqq2o1WLlO27gIqqLk1AA9qLaGONTQIOyQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263637;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4tWzvPGDH9mvPXm1tzajzmTu6lw50GNdOEOJxyUN2/w=;
	b=V7eQbUNZ/d6ViM5nUnTXA5Ts6LT34O6vtcf5rdOlwW+wQ20Kd/lFF8X0gdJEkgt1pv7x
	 TYvJifga09eZKrHYXzZoQYS6UQBvcYYN3ZpWYJtz1P1yWYcJGGDUxCa+Z/QM8Aj2UI4Hg
	 E8+ZsjfpV+dNxZ1A5KGWN9X+eZ4Cy9IDK1pqNVPDW0w0sCN3cR9wfR8QABguDB7zdVIHd
	 NeUhDotlaC7s1vWYMs+zfeD43OaFzPgcbV1HucmCkR5ZKcQx0yfMv+0gN93pZtR/qSKF6
	 Wanmo42kNpdY3xQi5UKS63k/J3GTqsAjYh9sd1k5OHbXnK850mzMvivqhO3B4NT8UIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SM7NOAOb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8F8606A31D;
	Thu, 29 Oct 2026 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SM7NOAOb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421F01F01825;
	Thu, 29 Oct 2026 08:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793263636;
	bh=4tWzvPGDH9mvPXm1tzajzmTu6lw50GNdOEOJxyUN2/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=SM7NOAObV6yLm194Hre7ixIO0+FSyhfzVLoIro9v7Rs8xnvUm2SckEhJ4DY8bTToB
	 2FB9eGzlbxHfXkKyD4Q/1AwRFitcDwjhrnlXQ3KShQd1GrQYfMMNsErBangdFf38I9
	 ZXtru0fiN/5TQGOSyIRqpkag8vBTMsvvvWVfNAGtzXv5Z0jxwyz0px4UXAiRLlBRP5
	 GQVye6xLM+FpaMegTkUOMLqHBCPSrGLuxcFWag7XtvRTePeBscMLxM5+uTM2BHjyqT
	 gH3vcHwZz5a081iBSXYlOR/QAGUrOGdoLczribwEYBf6U2C7TtE6X4fIy+qzil1yi3
	 0djNSXaqBWm7A==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, tglx@kernel.org,
 dave.hansen@linux.intel.com, x86@kernel.org, joro@8bytes.org,
 will@kernel.org, leon@kernel.org, mbloch@nvidia.com,
 iommu@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [RFC 07/11] eth: ixgbe: use dma_alloc_coherent_node()
In-Reply-To: <20261027112003.330bbded@kernel.org>
References: <20261027022528.633359-1-kuba@kernel.org>
 <20261027022528.633359-8-kuba@kernel.org>
 <87ecdb5x8k.fsf@all.your.base.are.belong.to.us>
 <20261027085133.2832f2f5@kernel.org>
 <87wlr33z6z.fsf@all.your.base.are.belong.to.us>
 <20261027112003.330bbded@kernel.org>
Date: Thu, 29 Oct 2026 09:47:13 +0100
Message-ID: <87se1o51wu.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 27 Oct 2026 17:06:44 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
>> Jakub Kicinski <kuba@kernel.org> writes:
>> > On Tue, 27 Oct 2026 10:06:03 +0100 Bj=C3=B6rn T=C3=B6pel wrote:=20=20
>> >> Not really this series, but the fallback here is odd, no? I thought t=
he
>> >> allocator already did cross-zone fallback?=20=20
>> >
>> > Fair, I was too lazy to check. I'll remove the fallbacks in the same
>> > patch. Seems obvious enough. LMK if you prefer separate.=20=20
>>=20
>> Hmm. Seems like dma_alloc_contiguous() doesn't spill over to other
>> nodes. It only tries the per-NUMA CMA... so keeping it is bit more
>> robust. (Then again, I dunno...)
>>=20
>> I'd say keep it.
>
> Or we fold the retry into the helper? I tried to write the kdoc:
>
> /**
>  * dma_alloc_attrs_node - allocate coherent memory on a given NUMA node
>  * @dev: device to allocate the memory for
>  * @size: size of the allocation
>  * @dma_handle: returns the DMA address of the allocation
>  * @flag: GFP flags for the allocation
>  * @attrs: DMA_ATTR_* flags for the allocation
>  * @node: NUMA node to allocate the memory on, NUMA_NO_NODE for no prefer=
ence
>  *
>  * Same as dma_alloc_attrs() but places the memory on @node rather than o=
n the
>  * node of @dev. Like with kmalloc_node() the node is only a preference,
>  * the page allocator may fall back to other nodes if @node is out of mem=
ory.
>  * The contiguous memory allocator (CMA) does not: only the CMA area of @=
node
>  * and the global CMA area are tried. The allocation may fail even though=
 the
>  * CMA area of another node, e.g. that of @dev, still has free space.
>  *
>  * Allocations served from per-device coherent pools or CMA areas, restri=
cted
>  * or atomic pools, or by dma_map_ops implementations do not take @node i=
nto
>  * account.
>  *
>  * Return: the CPU address of the allocation, or NULL on failure.
>  */
>
> This feels like too much explaining of the internals for a commonly
> used APIs. If we retry in the helper all we have to say is basically
> "acts like kmalloc_node()".

Yeah, that's a lot.

> WDYT?

Agree that it's odd that the caller need to know CMA internals, but I'm
not sure retrying the entire DMA allocation in the helper is the right
way. Can the fallback be handled in dma_alloc_contigous()? I would still
not do that in this series, but keep as is.


Bj=C3=B6rn
