Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500265;
	b=HD3cBoGD74xqSz+RsHKvSDrtH2lhxE5atJ0safUEyHIPTqXUmqRp4hm4HBPgDE63HJhH
	 a1+g3tStS0cUvmU2L1+kFFrgKxO63bWGui7MN/BYJ73/yor5c2Xuo6wFt1ou3FLSrQ1jA
	 iSJqN4kk+HnUx/ndm+nxImQi80puuapkJItGcqmjDR/bci/oCEaB7dsaUQxbNJQQZ0Xsp
	 KS0r2bwti5dnv8lFMW0o8vrb/NeIZStG2QYnxcQBygKXIOamyjHeR0v85f10NpV4oaoqs
	 BXoBMXtqeVtGMlO1AN/VzPuWw5cxVpz42o9IUp2BRHOPT3Oqnqp6d/GPiDxKUahXWgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500265;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8l0HT/Ti+u8eRLgZezAEnobZ3Iu0FPfd7TRkU2hPmno=;
	b=wnMWTNO2xcIsP2D7creNgSLQ5PFWn8T6Vqs7NnSGNQj+9QxJUbC1xN4JHA6+TZPIlEFZ
	 7zGkUPXDVKIBYsR8m9X8eFD82JnHH8tHiKzsNRBez49MY8xVBV8eVVGapjoHfukv812UE
	 z7SgVvSJ73wfZ3O40TDETGbPFtve1vblpj6N8FTxRkUMDM0JFxPJvQt8L+zVLKrrtySCw
	 KDbYFn3XAYHisxav1OF6/dufFfuo4IiVBvQOFEVQ9pIVc8k6yerjzCU6IjsoNaOjz0q6q
	 spV1FS1+XHVKAegP8EKjGUBoRdXHbWnAWPmM4Mbh62c3I5hNjBH8LA4HR/oguES/HXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qc6hgnR2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D2A606A31C;
	Thu, 12 Nov 2026 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qc6hgnR2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EEE1F000C4;
	Thu, 12 Nov 2026 16:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794500265;
	bh=8l0HT/Ti+u8eRLgZezAEnobZ3Iu0FPfd7TRkU2hPmno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qc6hgnR2W4DJiPEIowjdv491mN7jlnpsbYKrfOoMSw3NqKSnRTilIWhx2gemPz4rR
	 7YQ10guacmkFz3VzfC3AyymD0tKwrz8aFcVe46pxTocfmQTiOmlYVQp8VPUZQ50Mxn
	 JgN8ZZAElDzhbozo5ODMOwtE+ABwsb5Qb51vcNAOAf93AnCLWke2RF0DhbSYEPMzbj
	 nwR9JEO6ChXDQI4eKXbgN/QwidkYXtZ0eSE9GblZRgBSE/wOZHAMaoJqFqYByOQkKn
	 3/YFAvxqBXBVZkQYlVyVE3qiz7A/hD3ahQivkGpkKclfvK85dajvB/zIk0QDaiSmUx
	 otTxmHWNl3YJQ==
Date: Thu, 12 Nov 2026 08:17:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com,
 netdev@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 will@kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH 04/11] dma-contiguous: pass the NUMA node to
 dma_alloc_contiguous()
Message-ID: <20261112081744.3ba9cd82@kernel.org>
In-Reply-To: <c014414f-fdd2-4a79-b133-44671c0e4475@redhat.com>
References: <20261106184433.761422-1-kuba@kernel.org>
	<20261106184433.761422-5-kuba@kernel.org>
	<c83426a5-d21c-4f0d-b13e-099b6f96df6f@redhat.com>
	<d00d3435-fcce-4c0f-8ed5-a672b5b85dfb@arm.com>
	<c014414f-fdd2-4a79-b133-44671c0e4475@redhat.com>
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

On Thu, 12 Nov 2026 16:43:51 +0100 Paolo Abeni wrote:
> >> I'm possibly over-thinking here, but AFAICS there are a bunch of dma_map_ops that
> >> are using dev_to_node():
> >>
> >> dma_iommu_alloc_coherent() in arch/powerpc/kernel/dma-iommu.c
> >> vio_dma_iommu_alloc_coherent() in arch/powerpc/platforms/pseries/vio.c
> >> gart_alloc_coherent() in arch/x86/kernel/amd_gart_64.c
> >>
> >> With this series they will stop using the driver provided numa node.
> >> Probably not a blocker but possibly worth to call out?  
> > 
> > Nothing "stops" - this series adds a *new* interface by which
> > drivers can now indicate a specific preferred node, but DMA API
> > backends are still free to ignore the caller-provided hint and
> > continue doing whatever they want. This is already called out all
> > over the series in commit messages, documentation and comments
> > including the one above.  
>
> I mean: the series also replaces the old hacks with the new APIs usage
> in a few drivers, and in the above cases there could be actual
> regressions.
> 
> But I guess we could handle them if and when they will surface.

I know AI helps people surface unlikely cases but we need to draw 
the line somewhere.
