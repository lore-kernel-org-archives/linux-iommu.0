Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091966;
	b=0VBNe/K+v2lQMwiPkOlTnMxFqR+1kuU6yHHR9smCvfsQQIwUzmlRf7K9GgtVWiDYALn/
	 k7s6bI3xLWkR7eSpa85MEh4s3V5fyIsCJmiRPsXFBOh5itRIc4SNkK929d8deldn0RuVT
	 ANSvkxtP+JN9mkBULyA7P9k8XIbvD5jtQSCk/I4pZOeaHmGGQs3PSAlt7yjdTPKDin1jG
	 0KFXE/zd6PM/Axo2cy8apBH7bO7Vxmu7EOTB595NIPUcuRP75dWY4qtYOO1aG3keXSPc5
	 ByFraxXJo/J7uUix9wyX8f2fVBAuR7MuPoy5aDpB4O9LSKuMijb2gtcAsLyyh0AQUAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091966;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pyEe/eXg2lF+YHQ/u+R8IymwLlx7HQBrkI+BOr2lGrw=;
	b=pODaMqLWrnkHzmW2ykPBI0cwKXWyrknnxv10w3c4kqmRt3daHF7QwiM9VMhA/DnVW7rr
	 MOtSMmyPHr+rsKW8GQ8RVhqml09TWzM++SA/K5RMl3gRGSCbHxjQkSrdniTQVoOonLoNE
	 iTN6Osmbhcs70kZwXbKySqWCBoUUSVpPza3ohC4X0jkqgHskvpIqGSL0Zvnvn41Rohd4E
	 rSyulHxqbz5wqqjvI8BC1xbjcgn/URtYvHQF9yuytiW3tA/urTLFaAh6Or/0e2QnX83dg
	 CR9jbeZ13484Wvfhl/1D1w2OXP7+vHth+mJnHW07K9sJRgVuKOfr+54Q5zl4l+j3I7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fyQHghmi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97922606A31A;
	Tue, 27 Oct 2026 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fyQHghmi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57F81F01825;
	Tue, 27 Oct 2026 09:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793091966;
	bh=pyEe/eXg2lF+YHQ/u+R8IymwLlx7HQBrkI+BOr2lGrw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=fyQHghmimMXB2qx7l1xQUoS64yUwpvIab2CJapiz3I29D6ttz1fD1kAKVxpVwcxEJ
	 e6wgrt3tX2xbiDZrI+4w5DJt5CjRL1lUkCjguey8stX1zbSSZfPMNSxaCyix2W9Im2
	 hT2bxq01q87kcfOfveSSZRjJTlLkdQAutaxlxDSW+hfryVQuu/9ZswEY7TskLsGygk
	 ZuqrVclAeJ4FdReCj2hEDb13pTVRl6zeLu1hQKxCnsjf/fj90E7JAv9jKH//xj2bBi
	 IdazR9Y63go7OsrBsA9rCWAHkx36aStm+TLD0Al9on3C/CQFVfZe0xDMl3I3ITBgbd
	 oqlVVIIV9ZBoA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, robin.murphy@arm.com,
 m.szyprowski@samsung.com
Cc: tglx@kernel.org, dave.hansen@linux.intel.com, x86@kernel.org,
 joro@8bytes.org, will@kernel.org, leon@kernel.org, mbloch@nvidia.com,
 iommu@lists.linux.dev, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>
Subject: Re: [RFC 07/11] eth: ixgbe: use dma_alloc_coherent_node()
In-Reply-To: <20261027022528.633359-8-kuba@kernel.org>
References: <20261027022528.633359-1-kuba@kernel.org>
 <20261027022528.633359-8-kuba@kernel.org>
Date: Tue, 27 Oct 2026 10:06:03 +0100
Message-ID: <87ecdb5x8k.fsf@all.your.base.are.belong.to.us>
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

> Use dma_alloc_coherent_node() to place the descriptor rings on the
> node of the ring's q_vector, instead of temporarily changing the node
> of the device. NUMA_NO_NODE (ring without a q_vector) means no
> preference, same as what set_dev_node(dev, NUMA_NO_NODE) resulted in.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 20 ++++++-------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/=
ethernet/intel/ixgbe/ixgbe_main.c
> index f91856498eb2..770648f8ab89 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -7083,7 +7083,6 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adap=
ter,
>  int ixgbe_setup_tx_resources(struct ixgbe_ring *tx_ring)
>  {
>  	struct device *dev =3D tx_ring->dev;
> -	int orig_node =3D dev_to_node(dev);
>  	int ring_node =3D NUMA_NO_NODE;
>  	int size;
>=20=20
> @@ -7102,12 +7101,9 @@ int ixgbe_setup_tx_resources(struct ixgbe_ring *tx=
_ring)
>  	tx_ring->size =3D tx_ring->count * sizeof(union ixgbe_adv_tx_desc);
>  	tx_ring->size =3D ALIGN(tx_ring->size, 4096);
>=20=20
> -	set_dev_node(dev, ring_node);
> -	tx_ring->desc =3D dma_alloc_coherent(dev,
> -					   tx_ring->size,
> -					   &tx_ring->dma,
> -					   GFP_KERNEL);
> -	set_dev_node(dev, orig_node);
> +	tx_ring->desc =3D dma_alloc_coherent_node(dev, tx_ring->size,
> +						&tx_ring->dma, GFP_KERNEL,
> +						ring_node);
>  	if (!tx_ring->desc)
>  		tx_ring->desc =3D dma_alloc_coherent(dev, tx_ring->size,
>  						   &tx_ring->dma, GFP_KERNEL);

Not really this series, but the fallback here is odd, no? I thought the
allocator already did cross-zone fallback?


Bj=C3=B6rn
