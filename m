Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123579;
	b=goZcs+bt+ex6JCqdU4r847WrJUN//LUMmDxeOjhUy08GUyk3P3meUEbBSHJeiEV/LNCq
	 EC6AgUFxR3+fXL+dUA1f7BVqE11xYWTrWEmJZex82ehvK2SbSDFkX0yCflCKqpYnyJJiK
	 zC7dyT9cmmcso+cTwx32YozmhmT9F3/M6YJD4BYsQ807cRwiVHxDxkXhidGr0ZG/sBy/b
	 bVkCJSWM52LcC7Bs8QH8FbgHbvWrqTzx9SAmpYh7SzWzlodILbs27NSnXidJqa3AEbc1r
	 v1R1rk7gLG7Gd4pgRdmZL3O7Ns4L5fSy6SBsAivJrSN2AyTvEU2JByFuqZGQUV9GFqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123579;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vJ0QHCcipPb2AWZaDzcZqnVo6KqnFZDxJa1dLM/gdtQ=;
	b=XnH7DsfvtMUSCLIS279JMOmdZ+ehMyyRFsW0aLbq5vK7nn9O5myZGH8dj/SIyb0N09sD
	 FH1F82f1/y8q7fcZfJcOgZ454HUc3lV2NYNcJqVLyShuqURqtaGha1u7EtSX/x487OraJ
	 WeTRn2/AxrtyW+s+Od1m5FIo5Cw1vxHmmptQKa++KOF2XcavZQBnrigpBpOGDJkcfFw+l
	 c1BQDriHI6R79QTNuJjS3ARGcQkIl5HTwL6mK1OFm1dCHw69BFAASVMwXQ/iFHMlMUx3s
	 /tyDCFoqG9bxJIvcSx2rPviQtbHVkfzSqK5rXo00HOWNYzu5xih0I7dY+yX1/TuhEmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DE65Mu3m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589A6606A31A;
	Tue, 27 Oct 2026 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DE65Mu3m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B641F01825;
	Tue, 27 Oct 2026 17:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793123579;
	bh=vJ0QHCcipPb2AWZaDzcZqnVo6KqnFZDxJa1dLM/gdtQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DE65Mu3mW/CbPd78yfnb8Q16QMuYBkR5FvHdPR4XjPV/vjHUsBXDigZvZntx2+diG
	 zp+iITe+V+QGQAf1SEUEI/fyHmzF95wFfYb/U/IuB67qwlCwXsYKQ6LkGuwazRtCxt
	 vbXo41X21tXoBZp5/cI373ZOIzSGycgRLIhWTECii4+ETEX6IPyQIfHYAPYVvVI2kC
	 eykolA5kWOnPjUWrubXjUNnLoymDNaJEdSG83q4EyzHP2pH9hSPZ5ueZnKlG+KAiFm
	 e7p9P9WuUNXjr741jRzdGLKbc0NlTo0GlD8DAz3ajuiD5iuNnrD+tVgXXDxQ+VDo5g
	 IYwjFC7hifQMA==
Date: Tue, 27 Oct 2026 10:52:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: robin.murphy@arm.com, tglx@kernel.org, dave.hansen@linux.intel.com,
 x86@kernel.org, joro@8bytes.org, will@kernel.org, leon@kernel.org,
 mbloch@nvidia.com, iommu@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [RFC 04/11] dma-mapping: add dma_alloc_attrs_node() and
 dma_alloc_coherent_node()
Message-ID: <20261027105253.2c3d58a9@kernel.org>
In-Reply-To: <008d1317-223e-4265-a5a4-4d2a602a2661@samsung.com>
References: <20261027022528.633359-1-kuba@kernel.org>
	<CGME20261027022613eucas1p2ac05630160507ff3a887186416e98c30@eucas1p2.samsung.com>
	<20261027022528.633359-5-kuba@kernel.org>
	<008d1317-223e-4265-a5a4-4d2a602a2661@samsung.com>
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

On Tue, 27 Oct 2026 16:24:44 +0100 Marek Szyprowski wrote:
> > +EXPORT_SYMBOL_GPL(dma_alloc_attrs_node);
> > +
> > +void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma=
_handle,
> > +		gfp_t flag, unsigned long attrs)
> > +{
> > +	return dma_alloc_attrs_node(dev, size, dma_handle, flag, attrs,
> > +				    dev_to_node(dev));
> > +}
> >  EXPORT_SYMBOL(dma_alloc_attrs); =20
>=20
> Do we really need two exported symbols for dma_alloc_attrs()? I would pre=
fer
> to make dma_alloc_attrs() a static inline calling=C2=A0dma_alloc_attrs_no=
de().
>=20
> Did I missed something obvious against that?

License, I associate DMA API with hch so I thought we'd want to make
the new symbol GPL-only? LMK if I'm overthinking this.
