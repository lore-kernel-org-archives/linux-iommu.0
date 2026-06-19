Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AD940D582;
	Fri, 19 Jun 2026 03:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781840867; cv=none; b=WL2dGgttf61lgpNxAQoJOIO53znPBK3szQDS6bzIxvVGdUSqSk6lSW7rK23a9SBaApOTqo6bXaF8gTBmpC68Q2/wfLSidBxU/m9RQ/XsgZ7TMY+7ZQkOFp5LZFtJucRmgUVD0Gf4ZlKPmle2V6P3hoN65U3UnwqEgzxxgiinZFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781840867; c=relaxed/simple;
	bh=PDGA5hslc6cQc/sRv0AKcNXy4AW8E1PmweZ4w4Olpp4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dlv7+xkjpKNlA4S8UDjxHuPKlh5ShMvOlXf5af7TSnXl2OehP2LsM8f9oIyasLlGH2zUqfusF0SXrgvsmkDOJOWkKSO5YiL+JzcYd1QIqsM8D9VH8G+VpXlVneJIN8yZODHX1AG56KJ2JUfeKO4jIezU3HBh/CMm2sutjHQbwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=Lx1oXaGA; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="Lx1oXaGA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=aa1NIqnvKKL1qjx/QAwcjOZUfJ6AwtN4tAIOF0TEJQQ=; b=Lx1oXaGAVEgeeTYWiX2GvDW2Xx
	aC54Kkn7/gjHlEDSvcUsoSbd5G3iuADHrrFp/F1Y2IhMFspt/mjX2GbOZPnGuc8PmP8DHpbnV6L36
	t5LA/93fyh73QqNz5iVGto9O4zMSnSvMpGJ88bzsMbCyDI770Jq2OAhvsgxSJtytO+WEjDr4hcKQI
	We7loKQlX6qiwrXppyjSDLLhExHmOI01HQopp5AmKg9ngc+ngnCRFQzCGAWxS0enyBwdFQxmMTopW
	sidjJnwBjapLYZnmnIocySGcvoaJweeEcT/KGEafg5c7Vrg8VblKFgge/BAE3Vjei9N3u55SeKXB2
	sMFBWVkw==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1waQCX-000000001Qg-45e5;
	Thu, 18 Jun 2026 23:47:29 -0400
Message-ID: <c0e6fede4c3af7adcfa207e4dbd2fffa88ff7d7c.camel@surriel.com>
Subject: Re: [PATCH v3 1/3] iova: convert from rbtree to maple tree
From: Rik van Riel <riel@surriel.com>
To: "Liam R. Howlett" <liam@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 robin.murphy@arm.com, 	joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev, jgg@ziepe.ca, 	kyle@mcmartin.ca, Rik van Riel
 <riel@meta.com>
Date: Thu, 18 Jun 2026 23:47:29 -0400
In-Reply-To: <3bdrfc244zzmutjfpfyw4nivb4w4mckfs3b3mqbxr4ffr27mkv@x3i4v335ozww>
References: <20260603033653.4144138-1-riel@surriel.com>
	 <20260603033653.4144138-2-riel@surriel.com>
	 <3bdrfc244zzmutjfpfyw4nivb4w4mckfs3b3mqbxr4ffr27mkv@x3i4v335ozww>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Wed, 2026-06-17 at 15:55 -0400, Liam R. Howlett wrote:
> On 26/06/02 11:35PM, Rik van Riel wrote:
> > From: Rik van Riel <riel@meta.com>
> >=20
> > =C2=A0 - struct iova_domain replaces rb_root + cached_node +
> > cached32_node
> > =C2=A0=C2=A0=C2=A0 + anchor with a single struct maple_tree. The iova_r=
btree_lock
> > =C2=A0=C2=A0=C2=A0 spinlock is renamed to iova_lock. The maple tree is =
initialized
> > =C2=A0=C2=A0=C2=A0 with MT_FLAGS_ALLOC_RANGE (enables gap tracking for
> > =C2=A0=C2=A0=C2=A0 mas_empty_area_rev) and MT_FLAGS_LOCK_EXTERN (uses t=
he existing
> > =C2=A0=C2=A0=C2=A0 iova_lock spinlock instead of the maple tree interna=
l
> > lock)there .
>=20
> If the spinlock is only used to protect the tree, why are you using
> an
> external lock?

The IOVA code needs an irqsafe lock, but the lock also
protects some other things like iovad->max32_alloc_size,
and the failed-to-rebalance-deferred free list from patch 3.

Implementing something behind the MT_FLAGS_LOCK_IRQ
would address the first thing, but not the second.

>=20
> > =C2=A0
> > -	/* Walk the tree backwards */
> > -	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> > +	spin_lock_irqsave(&iovad->iova_lock, flags);
> > =C2=A0	if (limit_pfn <=3D iovad->dma_32bit_pfn &&
> > =C2=A0			size >=3D iovad->max32_alloc_size)
> > =C2=A0		goto iova32_full;
>=20
> This check seems to ensure the request is either both 32bit safe or
> it's
> fine to pass.=C2=A0 If a 64bit allocation uses a larger size and we fail
> later, aren't we overwriting the 32bit size safety in your alloc_fail
> label?=C2=A0 It seems wrong to be changing the max32_alloc_size in the
> error
> recovery.
>=20
> This also could happen outside the spinlock?=C2=A0 I'm not sure why it wa=
s
> inside to begin with.

Good eyes. There's a bug here. While the iova32_full
code already has a limit_pfn check, we could also end
up there because the GFP_ATOMIC allocation failed,
turning a temporary failure into a permanent one.

This will be fixed for v4.

>=20
> > +	new_pfn =3D (mas.last - size + 1) & align_mask;
> > +	if (new_pfn < mas.index || new_pfn < iovad->start_pfn)
> > +		goto alloc_fail;
>=20
> Neither of these can ever happen..?=C2=A0 You've searched for a gap that'=
s
> the worst case alignment and now you're ensuring the offset off the
> end
> aligned isn't smaller than the start of the gap or the end of your
> search.=C2=A0 I'm no LLM, I don't think this is possible.

I'll drop these for v4.

> > +	spin_lock_irqsave(&iovad->iova_lock, flags);
> > +	{
> > +		MA_STATE(mas, &iovad->mtree, pfn_lo, pfn_hi);
>=20
> You might want to look at mas_init() instead of the extra tab block.
>=20

That is nicer. Thank you.

> > -	/* We are here either because this is the first reserver
> > node
> > -	 * or need to insert remaining non overlap addr range
> > -	 */
> > -	iova =3D __insert_new_range(iovad, pfn_lo, pfn_hi);
> > -finish:
> > +	iova =3D alloc_and_init_iova(merged_lo, merged_hi);
> > +	if (!iova) {
> > +		spin_unlock_irqrestore(&iovad->iova_lock, flags);
> > +		return NULL;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 A goto the same repeated block below might be in
> order?
>=20
Fixed for v4.

> > +	}
> > +
> > +	{
> > +		MA_STATE(mas, &iovad->mtree, merged_lo,
> > merged_hi);
> > =C2=A0
> > -	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
>=20
> The maple state keeps track of where things are, so if you have a
> maple
> state pointing at the correct slot, then you can avoid rewalking the
> tree.=C2=A0 This is rather complicated, but it will save you a hand full
> of
> dereferences if you need them.

This code is for the overlap case, where a new
iova mapping is explicitly set to overlap already
existing mappings.

This makes the maple tree logic even more complex,
and I'm not sure whether this case is common enough
to justify that.

>=20
> > @@ -956,8 +808,8 @@ int iova_cache_get(void)
> > =C2=A0
> > =C2=A0	mutex_lock(&iova_cache_mutex);
> > =C2=A0	if (!iova_cache_users) {
> > -		iova_cache =3D kmem_cache_create("iommu_iova",
> > sizeof(struct iova), 0,
> > -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SLAB_HWCACHE_ALIGN,
> > NULL);
> > +		iova_cache =3D kmem_cache_create("iommu_iova",
> > sizeof(struct iova),
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, 0, NULL);
>=20
> Was this in the patch notes or expected to change?

This change is what reduces the allocated size of the
iova struct from 64 bytes to 16 bytes.

That seems desired, and potentially important for
some users.

I believe I also covered it in the changelog.

--=20
All Rights Reversed.
