Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED594AA570;
	Mon,  5 Oct 2026 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212088; cv=none; b=SnDv1JTiMpjVyo9P+Ve27oXQjctPDunrA1NGOyTUOiUkgUszV6rkdel8v2E6fM3+Tmdkd79GPRAD7cmr99Pms/QU3xbqCU96ytyMAIlMV90mOjwqzCD0/Ym2xdbTQsE1bShxhxKaMASgESmzFi+DUz1rUs2pF+5iIJXEfMN3nbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212088; c=relaxed/simple;
	bh=VsTJJB41GS/oEuh50jcs4f6VcQ97jSHKQZk+Hp0RYX0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e8OWMI4MHIJ35W4TnozdE6TCq0r3SCMzneIHya3F2odCAo2HgT8zCpGdlCoMwqBVkBtrFA27FUrVdwCU6iOYH3qQr3KFnL4BPK0UR5PH2HVi0ZzsVljqdghMXFnmrM0lS8I3+C/9AEs1iMHeMjzuVx9THAsewNaaeTS5U6UB5Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=ncLEgYdm; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="ncLEgYdm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=cdA0MPXlmrMW8qmDhZYakrLXupIVdlGbkvA5AhosPlI=; b=ncLEgY
	dm2mFssTazTR36s95ABc/6pMw+lm7+78Rvn2A/By4S77fOr+aEqmC1NbPRmG0TlxY1FsSLDv6Lrnh
	XfsL2awyxVQIySmECox9pqUTQpMNAeaZPBFojdkMbONz/NvGgHI6zV+S7elK/72OAxPGb22p6rQxS
	sOhtj4Z05vTlTRsxXCbMjDNkt5hIw92ZLpDsg6xnp6Qlx6wLHfOjr4fXBxRpsx9Qj0XCUhKw4Jju5
	9rppAfBevSgyfz8eRhcOYHVLM1ikmb4kpUGveU9hR3v0VZGusE7sNdYb0qwYyeakSSbVaEHaf8ZSn
	BPEr8uubFap0CpC0fSRHWJy0fp7Q==;
Received: from [2601:18c:8100:a0e0:2541:b86e:2586:d219]
	by shelob.surriel.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <riel@surriel.com>)
	id 1xDk5D-00000006JUt-3Ld4;
	Mon, 05 Oct 2026 14:54:27 +0000
Message-ID: <6a5f92b4c152be946c3a8f238197d389b9e87f54.camel@surriel.com>
Subject: Re: [RFC PATCH 1/3] iommu/iova: convert from rbtree to maple tree
From: Rik van Riel <riel@surriel.com>
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com, joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev, 	liam@infradead.org, maple-tree@lists.infradead.org,
 linux-mm@kvack.org, 	ashok.raj@oss.qualcomm.com, jgg@ziepe.ca,
 kyle@mcmartin.ca
Date: Mon, 05 Oct 2026 10:54:27 -0400
In-Reply-To: <9547761f-7688-4351-b172-9e9d5fa28b15@arm.com>
References: <20260818152505.1057922-1-riel@surriel.com>
	 <20260818152505.1057922-2-riel@surriel.com>
	 <9547761f-7688-4351-b172-9e9d5fa28b15@arm.com>
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
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Thu, 2026-09-24 at 16:26 +0100, Robin Murphy wrote:
> On 18/08/2026 4:25 pm, Rik van Riel wrote:
> > alloc_iova() looks for free space by walking the rbtree linearly.
> > On production workloads at Meta, enough CPUs have ended up in that
> > walk
> > at the same time to trigger soft lockups.
> >=20
> > Index the iova ranges in a maple tree instead. Its gap search makes
> > alloc_iova() O(log n).
> >=20
> > __alloc_and_insert_iova_range() asks mas_empty_area_rev() for the
> > highest free range below limit_pfn. Alignment is handled by
> > rounding
> > up the allocation size, prioritizing speed over address space
> > waste,
> > with the thought that many iova requests on a system will be
> > similar
> > in size, and reuse the same holes.
> [...]
> > =C2=A0 static int __alloc_and_insert_iova_range(struct iova_domain
> > *iovad,
> > =C2=A0=C2=A0		unsigned long size, unsigned long limit_pfn,
> > =C2=A0=C2=A0			struct iova *new, bool size_aligned)
> > =C2=A0 {
> > -	struct rb_node *curr, *prev;
> > -	struct iova *curr_iova;
> > =C2=A0=C2=A0	unsigned long flags;
> > -	unsigned long new_pfn, retry_pfn;
> > +	unsigned long new_pfn;
> > =C2=A0=C2=A0	unsigned long align_mask =3D ~0UL;
> > -	unsigned long high_pfn =3D limit_pfn, low_pfn =3D iovad-
> > >start_pfn;
> > +	unsigned long search_size =3D size;
> > +	MA_STATE(mas, &iovad->mtree, 0, 0);
> > +
> > +	if (size_aligned) {
> > +		unsigned long align =3D 1UL << fls_long(size - 1);
> > =C2=A0=20
> > -	if (size_aligned)
> > =C2=A0=C2=A0		align_mask <<=3D fls_long(size - 1);
> > +		search_size =3D size + align - 1;
> > +	}
>=20
> Perhaps it's a bit too much of a cool trick, but I think technically
> we=20
> could just do "search_size =3D size + ~align_mask" unconditionally.
>=20
> However, either way I do worry somewhat about the increase in=20
> fragmentation and premature failures once the space starts to fill
> up.=20
>=20
For that use case, I am guessing what we really
want to propagate up the tree is not the maximum
size of a gap, but the maximum power of two size
gap that is also aligned to its own size.

In other words, if we have something like this,
aligned 8, we propagate up a gap size 4:

used used used used gap gap gap gap

But if the usage looks like this, at the same
alignment to the start, we propagate a gap size 2:

used used used gap gap gap gap used

That would allow us to easily find gaps aligned
to their own size. Once the size 2 gap is filled
in, we propagate up the remaining size 1 gaps.

That makes me wonder if we need to go back to
the augmented rbtree, instead of using the
maple tree?


Just let me know your preference.
>=20
> > -	/* Walk the tree backwards */
> > -	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
>=20
> FWIW I'm not much of a fan of the implicit scoped-cleanup stuff in=20
> general, but this seems like an instance where using guard() to
> simplify=20
> all the early returns might be worthwhile.

I'm happy to do that.

Are there any other changes I should be making
to get this code ready for merging?

--=20
All Rights Reversed.
