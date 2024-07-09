Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C747F180050
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720552105; cv=none; b=jbHmoOjs2rkNpe2e/jWTKA9QDAPAhqJ1WFaf7Uh2e3AAMjD+yO85AcO2VImpmV5xuo3QwnWtDHxII/B2/kIgxUIg8aQr9vCWCarMO6egFAWqgd1L+s/0QpTykMMECQjc1AAzbGwGhSkGVOfduMrhRUylfxUOmx0lygisqlWuBjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720552105; c=relaxed/simple;
	bh=+FRYxpij7KrNXOurW6VCprxSAuGG/K0HE+tx2ZLbQIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KEcW/hYraNUVJqnGerFAJP5qqDCYYrZc7Fq+yTaVyg2+UAI3vkRoz12GyTvMXFCmO/yH0Mao74f9aPfJ3lC54EQ/FHzNqCKW7pl/yc0yA/+mSNzKMQyZ2kHo50qfGH8Xgm+6gSVltn/49SXlqubM5qWBMZ3Pg2pYIJcBBnzWYDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=ul2JCkoy; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="ul2JCkoy"
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 12AB71E0FE9;
	Tue,  9 Jul 2024 21:08:19 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1720552099; bh=HPcNlq4GbiFGcV0kx+F+Uo4jc+3/yYr06hN62dwcW68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ul2JCkoyadIyHntKSfaKg8VHAH9z8YOSRS24V+Aha9bH0JN3goesReVO/jPJrVsIn
	 v5724rcJcE1YGHX2rqTIXV4XUWFDdaDJrHRJsy+Jtjeii3qc2C8dYUMF9W4YaMv4ZV
	 nxFJ5PPko9SRYUjMFWOPVgiv8BWoIlOiz7rJDHhHE8GTKyCQVThm4uBmp4SE6JWOct
	 xi4lPs89V2KfPA4eEl+EXDK+Mp8GRyxcZfmVCUWo0gAnApIQf5LcoBsfzx9iAVqW81
	 Ed4RZ0NW8MSKmUJ8Rcgte9KAC9A7OOUwnlq8k4/G0AcjG8GLF9hsOC8WgLeTykIIYi
	 Uc9tdQ0Gl5gdw==
Date: Tue, 9 Jul 2024 21:08:18 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: mhkelley58@gmail.com, mhklinux@outlook.com, robin.murphy@arm.com,
 joro@8bytes.org, will@kernel.org, jgross@suse.com, sstabellini@kernel.org,
 oleksandr_tyshchenko@epam.com, m.szyprowski@samsung.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 1/1] swiotlb: Reduce swiotlb pool lookups
Message-ID: <20240709210818.28116c53@meshulam.tesarici.cz>
In-Reply-To: <20240709111812.GB4421@lst.de>
References: <20240708194100.1531-1-mhklinux@outlook.com>
	<20240709111013.6103d3f0@mordecai.tesarici.cz>
	<20240709111812.GB4421@lst.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Jul 2024 13:18:12 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Tue, Jul 09, 2024 at 11:10:13AM +0200, Petr Tesa=C5=99=C3=ADk wrote:
> > Reviewed-by: Petr Tesarik <petr@tesarici.cz> =20
>=20
> Thanks.
>=20
> >=20
> > OK, so __swiotlb_find_pool() is now always declared (so the code
> > compiles), but if CONFIG_SWIOTLB_DYNAMIC=3Dn, it is never defined. The
> > result still links, because the compiler optimizes away the whole
> > if-clause, so there are no references to an undefined symbol in the
> > object file.
> >=20
> > I think I've already seen similar constructs elsewhere in the kernel,
> > so relying on the optimization seems to be common practice. =20
>=20
> Yes, it's a pretty common patter.  It's gone here now, though to not
> add the struct device field unconditionally.
>=20
> > > +{
> > > +	struct io_tlb_pool *pool =3D swiotlb_find_pool(dev, addr);
> > > +
> > > +	if (unlikely(pool))
> > > +		__swiotlb_tbl_unmap_single(dev, addr, size, dir, attrs, pool);
> > > +}
> > > +
> > > +static inline void swiotlb_sync_single_for_device(struct device *dev,
> > > +		phys_addr_t addr, size_t size, enum dma_data_direction dir)
> > > +{
> > > +	struct io_tlb_pool *pool =3D swiotlb_find_pool(dev, addr);
> > > +
> > > +	if (unlikely(pool))
> > > +		__swiotlb_sync_single_for_device(dev, addr, size, dir, pool); =20
> >=20
> > We're adding an unlikely() here, which wasn't originally present in
> > iommu_dma_sync_single_for_device(). OTOH it should do no harm, and it
> > was most likely an omission.  =20
>=20
> I'm honestly not a big fan of the unlikely annotations unlike they
> are proven to make a difference.  Normally the runtime branch predictor
> should do a really good job here, and for some uses this will not
> just be likely but the only case.

I'm confused. If you're not a big fan, why are we effectively adding
them to more places now than before the patch?

FWIW on all architectures I've worked with (arm64, ia64, powerpc,
s390x, x86_64), the dynamic branch predictor takes precedence over
static prediction (yes, even ia64 held on to those mandatory .spnt.few
and .sptk.many hints only if there was no entry in the branch
predictor). But on every branch instruction, the compiler must decide
which code follows the branch instruction and which code is placed at
another place. The latter often needs another jump instruction to
continue executing instructions _after_ the whole conditional clause,
which is slightly less efficient. The compiler must make this decision
even if there is no likely() or unlikely() annotation, but in that case
it uses some (rather crude) heuristics of its own, e.g. whether the
condition covers the majority or minority of the value range.

Long story short, in this case "if (pool)" does pretty much the same
job as "if (likely(pool))". But we say "if (unlikely(pool)))"...

You needn't change the code, but I want this documented somewhere that
people can find it, i.e. in LKML archives.

Petr T
