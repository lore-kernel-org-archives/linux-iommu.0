Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091826;
	b=u7XQtIosImkm5nBoxYOPX+TbX+KUw0tile6BcF5vF09C2DUruP5J20ZrHAyZY1CAqf5J
	 h5P4OcNNB9SegdEa0T4CmvdmXGCgxxltAj5RXHTIjs4DPW0J90ZY91WqfZtJoHxXUDCOX
	 KCaCzHbQlQjWACkpuxBu5h71AUUO9PGEnMfD3AUV+ngqmA7S8sfAh9rjViQ85ln3KIUTA
	 ZOMK9oZbQx0VQaRXXbSpM/E++FXqVEKHAYF/YSREiT+OcxWUE4LIQhB2igv/aGP67J6YY
	 rHilfqLD6Vhw187ydTLapDl/ABPo/XyfgVQDdoExi1t8tLmu3Jp1jmU14g2FEy36G3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091826;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Oq/NLq0hF0YNbjoxEYrSRua4DzcQtn2MtQoJ/wISxKs=;
	b=LIzw167C5fDnbOanWSBc0EN/vBwF0cVrj6BIxd0pgbI3x56/3PToamf9WHHjuI1dUPd0
	 fu3htOD4lpKYB8Kpnpf5HhLHgzGqfec3juWwswb7hLDvzAeWPuovPVfJ8766K9ZpaPPTt
	 JpzW3RSyYtDyZJU0O1sqdRJb9AyjyerpDztepIU8RnE47ztDdc5OudAieB2vLb4ALIXBc
	 N+R1+GnSvSxBSN/tg8HijU+la+rQjP6AtQwK0pRcXnjw/o+RCC9bpdkIngDja5kk/hyMf
	 zWf60Sx1J8KvIAURu1DDUldlp0GMTGO1JWsPO+X5g5cFUUsyPdnzrmHBQ5+P7mH67lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PUjbFXxi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219A3606A31A;
	Tue, 27 Oct 2026 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PUjbFXxi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC441F01828;
	Tue, 27 Oct 2026 09:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793091825;
	bh=Oq/NLq0hF0YNbjoxEYrSRua4DzcQtn2MtQoJ/wISxKs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=PUjbFXximrgiOdbmR5Cjl83J0obwP/45C15xDJy56g/3Tdqv4LTHbPbMFHGoYGQt0
	 9bdyJZzNhRnnV5MZ6KFgIn6BwIz94Wj/CF9fauDgpnCDPEHkK6V6r0ZLFS02AgZTgo
	 tsd77CFb+OVNW6nz9mXuR7QhlBDNczNUJqsvu3KwFffmjrnnfhI0LN3L9Ip0B2iEMq
	 x2s2R44DqmYgGTMOTuVPKhsMQHQzWsg+ufQPc377+DV2p+gobOG9EgkXmDbsqvb9fI
	 G5py3vHYZmA5zecmFyEiKXf3vVuW752jZkcFxOH9ch9cNdm5JHZTJbqwo0jS34kIB4
	 ieB0Q9IozveCQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, robin.murphy@arm.com,
 m.szyprowski@samsung.com
Cc: tglx@kernel.org, dave.hansen@linux.intel.com, x86@kernel.org,
 joro@8bytes.org, will@kernel.org, leon@kernel.org, mbloch@nvidia.com,
 iommu@lists.linux.dev, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>
Subject: Re: [RFC 04/11] dma-mapping: add dma_alloc_attrs_node() and
 dma_alloc_coherent_node()
In-Reply-To: <20261027022528.633359-5-kuba@kernel.org>
References: <20261027022528.633359-1-kuba@kernel.org>
 <20261027022528.633359-5-kuba@kernel.org>
Date: Tue, 27 Oct 2026 10:03:43 +0100
Message-ID: <87ik2n5xcg.fsf@all.your.base.are.belong.to.us>
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

> Coherent DMA memory is always allocated on the NUMA node of the device.
> That's the right choice for memory mostly accessed by the device, but
> some coherent allocations are accessed by the CPU on every operation.
> For example a NIC's descriptor and completion rings are written and
> read by the CPU servicing the queue, which may well be on a different
> node than the device. Placing such rings on the device's node means
> the CPU accesses remote memory in the fast path.
>
> Drivers work around this today by temporarily changing the node
> of the device with set_dev_node() around dma_alloc_coherent()
> (mlx4, mlx5, ixgbe, xgbe). This is racy against anything else
> looking at the device's node at the same time.
>
> Add dma_alloc_attrs_node() which takes the node explicitly, and
> a dma_alloc_coherent_node() wrapper. dma_alloc_attrs() now passes
> dev_to_node(). The node is only a preference, the same as for
> kmalloc_node(). It is honored by dma-direct and iommu-dma, for both
> the page allocator and the per-numa CMA areas. Allocations from fixed
> pools and from dma_map_ops->alloc implementations ignore it.
>
> The memory is freed with the existing dma_free_attrs() /
> dma_free_coherent(), freeing does not depend on the node.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/core-api/dma-api.rst | 15 ++++++++++++++
>  include/linux/dma-mapping.h        | 14 +++++++++++++
>  kernel/dma/mapping.c               | 32 ++++++++++++++++++++++++++----
>  3 files changed, 57 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/=
dma-api.rst
> index ba23a472f794..f9a32b8c338f 100644
> --- a/Documentation/core-api/dma-api.rst
> +++ b/Documentation/core-api/dma-api.rst
> @@ -57,6 +57,21 @@ The flag parameter allows the caller to specify the ``=
GFP_`` flags (see
>  kmalloc()) for the allocation (the implementation may ignore flags that =
affect
>  the location of the returned memory, like GFP_DMA).
>=20=20
> +::
> +
> +	void *
> +	dma_alloc_coherent_node(struct device *dev, size_t size,
> +				dma_addr_t *dma_handle, gfp_t flag, int node)
> +
> +Same as dma_alloc_coherent(), but places the memory on the given NUMA no=
de
> +rather than on the node of the device. This is useful for memory accessed
> +frequently by both the device and a CPU on a different node, for example
> +descriptor rings serviced by that CPU. Pass NUMA_NO_NODE for no preferen=
ce.

nit: maybe mention that callers that want the device-node semantics need
to pass dev_to_node(dev) themselves?


Bj=C3=B6rn
