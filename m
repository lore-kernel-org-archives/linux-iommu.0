Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116426;
	b=MkMFlp1wUkt6l02lXaXop5b7HfgpMsKx8DCHqryRFgmdrasbyT7XkdD2cZ6ycfQPh7UJ
	 SqcQPIdLnLO5nZ8jcgGrgesGEgxXdBrMpRkn02ghk9QZEGQEiJderIa509+7RIK9LUJNZ
	 5L1/mdO+k9rEJyQB1nyxQbULNhoXw+y34uAKz0A5E+go1SJ34Nj67o2eOcMDaaLEQrGhg
	 WW3fGxELYPh3Baky/3Uagqt/MQ0Nt2ZeeeWxVU7S1tJKU2iDB1+PvPXZkQVjC5oOiUvBX
	 i39I45Momxt1EYYRYO9/xYqHr4Zd2HhmTp0eN/YUAUTjB0NgWlnTkHBnYSNmo6Me7KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116426;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+0hZiKgcZsHFq0w/7lZGv1c9XJqhADo8OLnx86Afq6I=;
	b=zgp3UxIzO8EjCcbtwnNEIHTNtQaxWWUvHjnY1uiGnWpSuzstLz5SJ7PZcbfB7ps6pgRd
	 uU2zsi2oghd4SS7Xvx8YaVCdIIhE7Iyyr7q/4zbRnhcHeu+1YCGR/INeaFHHzAAu4Z35L
	 36Rz/L3VYomIqCRSBCHLpvRYy6aTGMcsF9u9GpK8QTqlVdlh9cgC29R/0ilslAMkvVcXD
	 qZDZ18Yd2h2yeZzayu2pj3bzP0RIUaXVVCKby9NlNJ8CrxgF7VA/VVAdCgB7JD5mkhqOx
	 dJcnarzog8uGlUCa0kisH7nJDe3yipGvqIL5ylUIfYk6NSKV+F9uHe6sq0ZMcuj28IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fKjfHe/2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998F5606A320;
	Tue, 27 Oct 2026 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fKjfHe/2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26CC1F012C1;
	Tue, 27 Oct 2026 15:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793116426;
	bh=+0hZiKgcZsHFq0w/7lZGv1c9XJqhADo8OLnx86Afq6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fKjfHe/22YcSPbPgSxjYdC1lHhVznvaZHKwfQ+YP2ZkaDSDIRU4TAFoy3A2VOsCIg
	 smvoxGhABUMLOaoUfsTSEMSB8I96UNiFyD80bM+u+25n8amgQqgNSSn7SbGYI6tCaI
	 eQ3I8T8Hwn0KJx/lk+W0vQ7yn1UzCDBkR7IDqN9TBEvgwD3mGn/y5NY440DMCHrxfW
	 L2nMIPaSBPhmDDiRoZrYFY3sPV5d2ILr/1HnoE5ERXQkZXugYeDb/YDMHYpowN6Ghz
	 M8KBWnNfbqy2Ew56ut0YoLaq4p24nfUJZ3fK4520VGZq6aEz+0ROrnlhQKv3387MO8
	 tX0rXnCaSq0wg==
Date: Tue, 27 Oct 2026 08:53:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, tglx@kernel.org,
 dave.hansen@linux.intel.com, x86@kernel.org, joro@8bytes.org,
 will@kernel.org, leon@kernel.org, mbloch@nvidia.com, iommu@lists.linux.dev,
 netdev@vger.kernel.org
Subject: Re: [RFC 04/11] dma-mapping: add dma_alloc_attrs_node() and
 dma_alloc_coherent_node()
Message-ID: <20261027085345.2a99169e@kernel.org>
In-Reply-To: <87ik2n5xcg.fsf@all.your.base.are.belong.to.us>
References: <20261027022528.633359-1-kuba@kernel.org>
	<20261027022528.633359-5-kuba@kernel.org>
	<87ik2n5xcg.fsf@all.your.base.are.belong.to.us>
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

On Tue, 27 Oct 2026 10:03:43 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> > +::
> > +
> > +	void *
> > +	dma_alloc_coherent_node(struct device *dev, size_t size,
> > +				dma_addr_t *dma_handle, gfp_t flag, int node)
> > +
> > +Same as dma_alloc_coherent(), but places the memory on the given NUMA =
node
> > +rather than on the node of the device. This is useful for memory acces=
sed
> > +frequently by both the device and a CPU on a different node, for examp=
le
> > +descriptor rings serviced by that CPU. Pass NUMA_NO_NODE for no prefer=
ence. =20
>=20
> nit: maybe mention that callers that want the device-node semantics need
> to pass dev_to_node(dev) themselves?

Let me just remove the NUMA_NO_NODE suggestion.
