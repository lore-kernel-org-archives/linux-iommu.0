Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125205;
	b=wCklMLZwNTsajZzFfLi9FV54CmsgRAtN1E1PE4ZkOXzXMnsid9xGWuvK2SCawbohSft8
	 HM8UtkTGlooFFQ5Gy30n6QNNxG0RzwzaIoK+YHveUtOKlvwigKN44ulqS0pvKZ4o0nQVs
	 3e6iwkD4WW/N57W+fG8YvwyXXhqLuaF3w4xveHXyEJ5yyAtFvc5vi/12mbkhgyEdtnlyh
	 f1KuCEsaMx626+PWYW3HVlHrAH2QTxiOONYC3yXA4cocn63e84cBEkg8ZvKUSz37VCgUw
	 KhrtOJqU2nvvCDoacZPMt6LDEIAeWdk8Cs8MUxrs9TiJ3V68RBn2T4FCNrE3jJfxSRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125205;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gAl89fyJdbv1sAJU0zLFzuIBO7vcKyX3qqqs2bLWiPM=;
	b=E8rnzcH3aYBJ7/awY38yquffP8avvxIpBfLR5q7BG7oXtzrYgJxAzS29VleQAHmnTCrA
	 OhikKkWurl9bp61qBcerBMcK9WJDXI/nxILbCtsO56Mjfmcr9y02c2ov6hz3oNwuHm9UM
	 SLCBlLhUY9v1toZ2/syqluiaTiCXuggFp0X95RHFNbNKhHpDiUsitPPOlLcM4iItyxAkt
	 C+K1VpzqoA5L7IL5YRgu7DRLQOGRLYKC7aKD4OUuhuLrlH+ToWhKiUUlr9GX+1e86nNFm
	 en1qvF/N3sh4o1wlxcMRiwwaUTXGcgdLl/uLYZLJrHzbJvAJEYx4mRwxIDy0UJ4Zsmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjPcTOJd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EAB606A31A;
	Tue, 27 Oct 2026 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjPcTOJd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046441F01828;
	Tue, 27 Oct 2026 18:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793125204;
	bh=gAl89fyJdbv1sAJU0zLFzuIBO7vcKyX3qqqs2bLWiPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gjPcTOJdnz/kwIbD7O08J5pbG/jBpJ1E5nKawunXt/p8zb/KyS1c44NWDYKrWstgW
	 15MZ5ceFNZJL+S0yGkmhIw9v2IvWfmj9OzUMX/nBWBuaEBNGI+RqeQPmspGZvaWRL0
	 vlTzc52BL5WtDqwnLBro55rrNFU16U9auxIUUYZplS1G+6H94hy+nRYxvaS3xSdnYH
	 bBRD1xHiZWb9IQO045KnZY68e3YYQ0Y7Uuwep0sBfXya8SQUkVhwgdt/an1fTX4JTs
	 UkxIJDr55VMRMcMOBVVEdPRc74LZK4xcAsuX0WtoPXVnqCZ8oJ42Nz9WksF7ZaADV9
	 PSAgm0nITmhIQ==
Date: Tue, 27 Oct 2026 11:20:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, tglx@kernel.org,
 dave.hansen@linux.intel.com, x86@kernel.org, joro@8bytes.org,
 will@kernel.org, leon@kernel.org, mbloch@nvidia.com, iommu@lists.linux.dev,
 netdev@vger.kernel.org
Subject: Re: [RFC 07/11] eth: ixgbe: use dma_alloc_coherent_node()
Message-ID: <20261027112003.330bbded@kernel.org>
In-Reply-To: <87wlr33z6z.fsf@all.your.base.are.belong.to.us>
References: <20261027022528.633359-1-kuba@kernel.org>
	<20261027022528.633359-8-kuba@kernel.org>
	<87ecdb5x8k.fsf@all.your.base.are.belong.to.us>
	<20261027085133.2832f2f5@kernel.org>
	<87wlr33z6z.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2026 17:06:44 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> > On Tue, 27 Oct 2026 10:06:03 +0100 Bj=C3=B6rn T=C3=B6pel wrote: =20
> >> Not really this series, but the fallback here is odd, no? I thought the
> >> allocator already did cross-zone fallback? =20
> >
> > Fair, I was too lazy to check. I'll remove the fallbacks in the same
> > patch. Seems obvious enough. LMK if you prefer separate. =20
>=20
> Hmm. Seems like dma_alloc_contiguous() doesn't spill over to other
> nodes. It only tries the per-NUMA CMA... so keeping it is bit more
> robust. (Then again, I dunno...)
>=20
> I'd say keep it.

Or we fold the retry into the helper? I tried to write the kdoc:

/**
 * dma_alloc_attrs_node - allocate coherent memory on a given NUMA node
 * @dev: device to allocate the memory for
 * @size: size of the allocation
 * @dma_handle: returns the DMA address of the allocation
 * @flag: GFP flags for the allocation
 * @attrs: DMA_ATTR_* flags for the allocation
 * @node: NUMA node to allocate the memory on, NUMA_NO_NODE for no preferen=
ce
 *
 * Same as dma_alloc_attrs() but places the memory on @node rather than on =
the
 * node of @dev. Like with kmalloc_node() the node is only a preference,
 * the page allocator may fall back to other nodes if @node is out of memor=
y.
 * The contiguous memory allocator (CMA) does not: only the CMA area of @no=
de
 * and the global CMA area are tried. The allocation may fail even though t=
he
 * CMA area of another node, e.g. that of @dev, still has free space.
 *
 * Allocations served from per-device coherent pools or CMA areas, restrict=
ed
 * or atomic pools, or by dma_map_ops implementations do not take @node into
 * account.
 *
 * Return: the CPU address of the allocation, or NULL on failure.
 */

This feels like too much explaining of the internals for a commonly
used APIs. If we retry in the helper all we have to say is basically
"acts like kmalloc_node()".

WDYT?
