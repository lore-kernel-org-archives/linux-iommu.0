Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116295;
	b=1l6gAxzTUkvBJcApAjhZg3rlINeXntSg12lb4T/slKmMyaAOoD475XGfGlzUydW0JX8r
	 C5ze7WC/8EiJlwerdiRCohQ+oTW1e/qSifr/LZdMObiECai3Qa5zvrL4X2VNeEVD6jt6T
	 ovXyygN3y8diyYCy1Nf7AayHaJ0fIcVN4drHL+v94KNIFusUycYpsw58gmUC2pfzLe+jS
	 H5fyDxmH8+qpuaadvJlmk48MEGOMwx86cf/VmcK0/AfazayRHnxyQvXDMynkdYg7rzmCC
	 pVFP08LMrkX/l453esxiXXDujFp4KpNZFnqnWDCyQSNRHdVCs5RKosOFi6OGRkhZn2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116295;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lO5Rp2t+dTuB8JE8FllV16gIsig003KkmZkMHvip2Tk=;
	b=DBdvZK6SSLL8AF2vENb+bEW8yZfzWHGBFGzKSq8D8yE6lmFg29K9CWiPoeIOQ6fxbFMv
	 4C8iKZMIaXL/1WRzT3K0QOTCUP0CgJL8O1yvF77/WfyYQeJ97atwcubgRiXTPpQ/0N5z4
	 nroZAxfc8XKic7ssQEqT3PYcojC+W4zPIgTrLqkaKQK+DRhQqPdOOPjvVHTNYP+0XLCWG
	 UWf9oO5dhGIDX8dARlE2Vhvsw3AglNpAwMw2XOqedN5WjacgfhbSkd6YmsHvGnIH111BC
	 KMN8uz0Jkg/J/8HjBIP0jNf08GCz8Wg8zRa2WnNorDgHa/zHgHnUaSjj7BiQCVPr9gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wgho3nCd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E76D606A33B;
	Tue, 27 Oct 2026 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wgho3nCd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8C61F01825;
	Tue, 27 Oct 2026 15:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793116294;
	bh=lO5Rp2t+dTuB8JE8FllV16gIsig003KkmZkMHvip2Tk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Wgho3nCd/0PS8fT1crmmrTXwxc8jlVcZ3ePrfMtpDPzDJsGo8Kfc/6wVTaqqvQ6ZZ
	 JfoXwQiUpbwrbYmdYzZK816WAgqdztoFPK03PkAvB+sKDiS01wjKVZGzsE6A/e8wo1
	 e2CP5IhervhxoS9Bxe1uXwRy2c62jn6KuFvNilM2FwZIWlvVYBO6o2K8y4t7OaG6do
	 ACgpLf215SFNVcMnGwHmbDYFsxCwGdsVIHMjdsBmy9dSOimTxsKjDP40ETNpjWczTv
	 kNBfmIZIGPh0cIdhd1wX0RJtvML4FNmqHZl3Cnl9+psk+gd3ohWJTTnH38GIYOpSO5
	 xkk4X9+qLPyvg==
Date: Tue, 27 Oct 2026 08:51:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, tglx@kernel.org,
 dave.hansen@linux.intel.com, x86@kernel.org, joro@8bytes.org,
 will@kernel.org, leon@kernel.org, mbloch@nvidia.com, iommu@lists.linux.dev,
 netdev@vger.kernel.org
Subject: Re: [RFC 07/11] eth: ixgbe: use dma_alloc_coherent_node()
Message-ID: <20261027085133.2832f2f5@kernel.org>
In-Reply-To: <87ecdb5x8k.fsf@all.your.base.are.belong.to.us>
References: <20261027022528.633359-1-kuba@kernel.org>
	<20261027022528.633359-8-kuba@kernel.org>
	<87ecdb5x8k.fsf@all.your.base.are.belong.to.us>
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

On Tue, 27 Oct 2026 10:06:03 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> > -	set_dev_node(dev, orig_node);
> > +	tx_ring->desc =3D dma_alloc_coherent_node(dev, tx_ring->size,
> > +						&tx_ring->dma, GFP_KERNEL,
> > +						ring_node);
> >  	if (!tx_ring->desc)
> >  		tx_ring->desc =3D dma_alloc_coherent(dev, tx_ring->size,
> >  						   &tx_ring->dma, GFP_KERNEL); =20
>=20
> Not really this series, but the fallback here is odd, no? I thought the
> allocator already did cross-zone fallback?

Fair, I was too lazy to check. I'll remove the fallbacks in the same
patch. Seems obvious enough. LMK if you prefer separate.
