Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B62AD2D
	for <iommu@lists.linux.dev>; Mon,  8 Jul 2024 04:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720412939; cv=none; b=dLmjx3jau2nlllp4ax7dYv+uqwvdSKhHl48DBzz7DSZ+KD1gQCQnkC9MRPwhW2vpzuMgmzMSV+WtTeHwSRxRIDN54Ozs06houiVF/ehiFtacoLY5QeYWDYoYS+iR1wsnfma6OM5Zo51KUbxzSPf04izUzyR0NuxuIydrStN5gqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720412939; c=relaxed/simple;
	bh=UO3JORI2UOnt/4q3O0io81GEdlOXjO/zMH+DQBTTuwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSN1LKU1HlQ64xvKPzshp285S5vWoVX/bKB+S+7ojvyAomsVmZGPd8QUp8zSbYY+7x+JvnrbjyinO1nNfYGqu327ImrOFrnN+mZ8p6IjUYct7YnxR03pg25R/4vSOo1YpdKfYG7aEu0QlWdSxKS3a3iaWMAW43kpYcAj7u1DMK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=bGYZm3GJ; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="bGYZm3GJ"
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-b985-910f-39e1-703f.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:b985:910f:39e1:703f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id C9E381E1B09;
	Mon,  8 Jul 2024 06:28:46 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1720412928; bh=1pPgaaAUuuvdjbvYPtznmd4G2eWylFU6nvLlq3caKLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bGYZm3GJbhcqN6KWJO6/rE2w8EeV+lF3OIJ8bEMkcrtNulH0q61e0gZgIJhwCG4Kn
	 kNhOjURA3dbzNo3tTDH+HAugNR2yRSIeytI52xUtesIyclt6L9F3RUWSpkhVlk+qob
	 YlqHN7lp8V13++PYy+Y5VZbYx/4ggIKzj2L23SZB93IxpeOFA772wfxgmUWIdUY+qY
	 rQEbyBptSnAZRgHlHeKNpZeGNfIp8Z9JOlQPyruAIZJQAhliyNc7E8xpmANTmQyjKF
	 wiWZ8BYwYKKTKVj2dSd8+bPK8xFV9h7ViNLOK6Qwx9cZbBXk/ZrxcPDZFWjfcwzwhN
	 gGK6uuFMvPhfQ==
Date: Mon, 8 Jul 2024 06:28:45 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Christoph Hellwig <hch@lst.de>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "will@kernel.org" <will@kernel.org>, "jgross@suse.com" <jgross@suse.com>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "oleksandr_tyshchenko@epam.com" <oleksandr_tyshchenko@epam.com>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 1/1] swiotlb: Reduce swiotlb pool lookups
Message-ID: <20240708062845.10e379b3@meshulam.tesarici.cz>
In-Reply-To: <SN6PR02MB4157141FBF8252BDEAD831C1D4D92@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240701165746.1358-1-mhklinux@outlook.com>
	<20240706055019.GA13280@lst.de>
	<SN6PR02MB4157141FBF8252BDEAD831C1D4D92@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 7 Jul 2024 02:11:48 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Christoph Hellwig <hch@lst.de> Sent: Friday, July 5, 2024 10:50 PM
> >=20
> > Hi Michael,
> >=20
> > I like the idea behind this, but can you respin it to avoid some of
> > the added code duplication.  We have a lot of this pattern:
> >=20
> > 	pool =3D swiotlb_find_pool(dev, paddr);
> > 	if (pool)
> > 		swiotlb_foo(dev, ...
> >=20
> > duplicated in all three swiotlb users.  If we rename the original
> > swiotlb_foo to __swiotlb_foo and add a little inline wrapper this is
> > de-duplicated and also avoids exposing swiotlb_find_pool to the
> > callers. =20
>=20
> This works pretty well. It certainly avoids the messiness of declaring
> a "pool" local variable and needing a separate assignment before the
> "if" statement, in each of the 9 call sites. The small downside is that
> it looks like a swiotlb function is called every time, even though
> there's usually an inline bailout. But that pattern occurs throughout
> the kernel, so not a big deal.
>=20
> I initially coded this change as a separate patch that goes first. But
> the second patch ends up changing about 20 lines that are changed
> by the first patch. It's hard to cleanly tease them apart. So I've gone
> back to a single unified patch. But let me know if you think it's worth
> the extra churn to break them apart.
>=20
> >=20
> > If we then stub out swiotlb_find_pool to return NULL for !CONFIG_SWIOTL=
B,
> > we also don't need extra stubs for all the __swiotlb_ helpers as the
> > compiler will eliminate the calls as dead code. =20
>=20
> Yes, this works as long as the declarations for the __swiotlb_foo
> functions are *not* under CONFIG_SWIOTLB. But when compiling with
> !CONFIG_SWIOTLB on arm64 with gcc-8.5.0, two tangentially related
> compile errors occur. iommu_dma_map_page() references
> swiotlb_tlb_map_single(). The declaration for the latter is under
> CONFIG_SWIOTLB. A similar problem occurs with dma_direct_map_page()
> and swiotlb_map(). Do later versions of gcc not complain when the
> reference is in dead code? Or are these just bugs that occurred because
> !CONFIG_SWIOTLB is rare? If the latter, I can submit a separate patch to
> move the declarations out from under CONFIG_SWIOTLB.
>=20
> >=20
> > I might be missing something, but what is the reason for using the
> > lower-level __swiotlb_find_pool in swiotlb_map and xen_swiotlb_map_page?
> > I can't see a reason why the simple checks in swiotlb_find_pool itself
> > are either wrong or a performance problem there.   =20
>=20
> Yes, swiotlb_find_pool() could be used instead of __swiotlb_find_pool().
>=20
> > Because if we don't
> > need these separate calls we can do away with __swiotlb_find_pool
> > for !CONFIG_SWIOTLB_DYNAMIC and simplify swiotlb_find_pool quite
> > a bit like this:
> >=20
> > 	...
> >=20
> > 	if (!mem)
> > 		return NULL;
> >=20
> > 	if (IS_ENABLED(CONFIG_SWIOTLB_DYNAMIC)) { =20
>=20
> The "IS_ENABLED" doesn't work because the dma_uses_io_tlb
> field in struct dev is under CONFIG_SWIOTLB_DYNAMIC. I guess
> it could be moved out, but that's going further afield. So I'm back
> to using #ifdef.
>=20
> > 		smp_rmb();
> > 		if (!READ_ONCE(dev->dma_uses_io_tlb))
> > 			return NULL;
> > 		return __swiotlb_find_pool(dev, paddr);
> > 	}
> >=20
> > 	if (paddr < mem->defpool.start || paddr >=3D mem->defpool.end)
> > 		return NULL;
> > 	return &dev->dma_io_tlb_mem->defpool; =20
>=20
> Petr Tesa=C5=99=C3=ADk had commented [1] on my original RFC suggesting th=
at
> __swiotlb_find_pool() be used here instead of open coding it. With
> the changes you suggest, __swiotlb_find_pool() is needed only in
> the CONFIG_SWIOTLB_DYNAMIC case, and I would be fine with just
> open coding the address of defpool here. Petr -- are you OK with
> removing __swiotlb_find_pool when !CONFIG_SWIOTLB_DYNAMIC,
> since this is the only place it would be used?

Yes. I have never had strong opinion about it, I merely saw the
opportunity when it was low-hanging fruit, but it's definitely not
worth adding complexity.

Petr T
