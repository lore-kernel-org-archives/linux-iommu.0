Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091790;
	b=0Qa3kfnVO74EB0VbYQo6f+zAfUsjOc6qUUAVSE3aPLFahj+XGja7+Nhqr0+0oSrIqrgE
	 aJaVqtucITxR/Ggfa3aA2lglpOgnbXW1Ca2BK8H4BRndG72/Hm08pNYMGz0WHVs+tNRSz
	 GuvFJiQWmuMvRcRImOrlx7m/oKxucNMZviYN1rvGV0S0pidkvrr4v0sOiRPjp9ErHktsI
	 t2Vd9TlEt8AE9hEqqB9SnXxXb0kLxjOZqTLydsF9gUdDMKCHTVHDH9QTfyQoAsRw58vWg
	 t/AJuAqRT7cy+ndIqaFaW9C8KlOhdJtbsAtowMHaGlMnPliVf4hvaHXMomPRcPGSoPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091790;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=iqtlHRoEM0vvXdiN1pSChQEoJkPogWICgssyXwrbAuY=;
	b=0Vt4tZoDg9QlunNQa8hIbV7SuY9hW6B7Ou6amMPcu1NyR7oB5w5VFQsu8quZfkxSZLmr
	 /+lbhA3o3Kcn79g2Ahd8HVW1h82UVYouHpPCVdXa1CQM782O3mVWc1KaQrYfdOC3/NyDx
	 8YcJ4uOzQUnGCVFbIE13WpcZlJF3P3vuX7FnfuR0hViFk70/+TRr+dvsEYKs9VlEen7K7
	 FuBMMnvJUxZkyvdn8jwWoXusJfacph+nqf1Qs8l5UpQkis/Ou74ZfSMT6HYL9ySyeuTru
	 acFZOFwlcDoS5Ph9dM4coLJlYh9CMrXQR51LYCW44vrLLRTOmkE4Q4agg1HZffCV0tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kmxod7cL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54365606A31B;
	Tue, 27 Oct 2026 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kmxod7cL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5104E1F01825;
	Tue, 27 Oct 2026 09:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793091789;
	bh=iqtlHRoEM0vvXdiN1pSChQEoJkPogWICgssyXwrbAuY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Kmxod7cL73elr6Mi/EzJm1COPARU19GsRzhJvGFXU2mKmaB29AJi21VM7hnSBk3eX
	 +94VXqgU6n3Z0GO3PqdafD+Q1IVq4LlT6TABQaORBYaDBmGwT+dxCD3KQftUw2z0+v
	 u8eOJsEipZNPnIJg5dJX0dh12gKT80223EUJi3UVOGEqUGZMEw+xpFx7CgKO2bj1DY
	 jU9GYAk7TindClTNltb3YSovFcHNZkivaW2fYQX/Hj8AO0nrKwta8gncCK3HiQGxIi
	 FNwCkgOpT161jXTQNSdKsNp5TiZxp+H0jvSsp3pyzXVFx+Mv2YjrB5xSry5wJzjYRm
	 +hPAYTK+gF7Jw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, robin.murphy@arm.com,
 m.szyprowski@samsung.com
Cc: tglx@kernel.org, dave.hansen@linux.intel.com, x86@kernel.org,
 joro@8bytes.org, will@kernel.org, leon@kernel.org, mbloch@nvidia.com,
 iommu@lists.linux.dev, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>
Subject: Re: [RFC 00/11] dma-mapping: add dma_alloc_attrs_node() and
 dma_alloc_coherent_node()
In-Reply-To: <20261027022528.633359-1-kuba@kernel.org>
References: <20261027022528.633359-1-kuba@kernel.org>
Date: Tue, 27 Oct 2026 10:03:06 +0100
Message-ID: <87ld7j5xdh.fsf@all.your.base.are.belong.to.us>
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

> Hi!
>
> I want to add NUMA-awareness to a networking driver (bnxt) and
> I run into the inexistence of dma_alloc_coherent_node().
>
> On NUMA systems networking drivers want to allocate rings
> and buffers close to the NAPI-handling core rather than
> allocating all from where the device is connected.
>
> Looks like we have accumulated 6 drivers which do:
>
>        set_dev_node(dma_dev, numa_node);
>        va =3D dma_alloc_coherent(...);
>        set_dev_node(dma_dev, old_node);
>
> IMHO this looks like an ugly hack. Can we add an API
> with the Node ID explicitly passed in?
>
>
> In the unlikely case anyone feels the urgent need to merge
> this please pull (so that we can also pull this into net-next):
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git tags/dma_a=
lloc_coherent_node
>
> Jakub Kicinski (11):
>   dma-contiguous: pass the NUMA node to dma_alloc_contiguous()
>   dma-direct: pass the NUMA node to dma_direct_alloc()
>   iommu/dma: pass the NUMA node to iommu_dma_alloc()
>   dma-mapping: add dma_alloc_attrs_node() and dma_alloc_coherent_node()
>   eth: libwx: restore the device's NUMA node after ring allocation
>   eth: libwx: use dma_alloc_coherent_node()
>   eth: ixgbe: use dma_alloc_coherent_node()
>   eth: xgbe: use dma_alloc_coherent_node()
>   eth: fungible: use dma_alloc_coherent_node()
>   eth: mlx5: use dma_alloc_coherent_node()
>   eth: mlx4: use dma_alloc_coherent_node()

Nice clean up on the driver side! I have some questions/nits for some
patches. Regardless, for the series:

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
