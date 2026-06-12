Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA1E2F28FC;
	Fri, 12 Jun 2026 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280183; cv=none; b=sGjfp9ByCYEsbDEpbt3RFdy7IHsxOSYA3oUK5bnoaxqnEjSQv3Qaa3PzbIBlUg6WoWpN0W4+A8oNgqaxtscQfe3dsfbcbM04RI3urxfGeUNTcH9SKfch8PtcyMuNrsoELmvUvGgMPBl0NI+HRmZCnN3+KrB9xG4VfhB4gx2U038=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280183; c=relaxed/simple;
	bh=o2Mb3U5iJ+gab+LMPM9bwoop7DarHyItelrKJnVtPco=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WgUICBdONK2mhSW7Dfp9hTyAxV6kXOBLuFoeb3+/eHQeWlrGCILa84KiM76BgjH+/d8nGCl9ye0TlE3+lwszMIq/8M1mbZ2oG0BBJJ1EO1jj7Ccv9xDnsdDp7bcS6avQvUOd6VKPy5vqRUQU3nL9z4CDGfP66RK2fl0lHP96I+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=NfpFtrmg; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="NfpFtrmg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0R9XO6B8XInWgdVPDHra7e0deMWtmEYsAlDeHSEisVo=; b=NfpFtrmggPUvwFjk4lydPwKswn
	QnnbJArr+KIjImC2xYOJeK350lA/edfVZNLpfRKX8CRMF6ZSkriAkrwkE6912rAVP+NMXUlI5rD/i
	jXTGM2S9+Jn2Z7Qs5nX8rNRsP6JK0bBWhkK6cAiJRScSg66qFFF18aSoNrMLlSIHz0nL6yYTvVXID
	7iA3OaZxJiv+qgs++xOHpI9dmvdWGOQZVcQJjj8tVAfRluy15u4E6PjpRCYvu68flIouWbw9qFcVj
	c1RghbhSr+Zr6y+MtXISRdmeDYGambXgW/VSOag/o7Fz0qpeqvy9jt/2XNBG+/xOEhRrb2G5nL1W6
	ptMNYdmA==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wY4LP-0000000043b-30vL;
	Fri, 12 Jun 2026 12:02:55 -0400
Message-ID: <61d51d4b5779d80145ceb38e9632a7cc8a79dbec.camel@surriel.com>
Subject: Re: [PATCH v3 3/3] iova: defer maple tree erase on GFP_ATOMIC
 failure
From: Rik van Riel <riel@surriel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 robin.murphy@arm.com, 	joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev, kyle@mcmartin.ca, Rik van Riel <riel@meta.com>
Date: Fri, 12 Jun 2026 12:02:55 -0400
In-Reply-To: <20260609130418.GI2764304@ziepe.ca>
References: <20260603033653.4144138-1-riel@surriel.com>
	 <20260603033653.4144138-4-riel@surriel.com>
	 <20260609130418.GI2764304@ziepe.ca>
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

On Tue, 2026-06-09 at 10:04 -0300, Jason Gunthorpe wrote:
> On Tue, Jun 02, 2026 at 11:35:48PM -0400, Rik van Riel wrote:
> > +/*
> > + * Remove an IOVA entry from the maple tree. Returns true on
> > success.
> > + * On failure (maple tree node allocation under GFP_ATOMIC
> > failed),
> > + * returns false =E2=80=94 the entry remains in the tree and the calle=
r
> > must
> > + * not free the struct iova.
> > + */
> > +static bool remove_iova(struct iova_domain *iovad, struct iova
> > *iova)
> > =C2=A0{
> > =C2=A0	MA_STATE(mas, &iovad->mtree, iova->pfn_lo, iova->pfn_hi);
> > =C2=A0
> > @@ -165,7 +175,36 @@ static void remove_iova(struct iova_domain
> > *iovad, struct iova *iova)
> > =C2=A0	if (iova->pfn_lo < iovad->dma_32bit_pfn)
> > =C2=A0		iovad->max32_alloc_size =3D iovad->dma_32bit_pfn;
> > =C2=A0
> > -	mas_store_gfp(&mas, NULL, GFP_ATOMIC);
> > +	if (mas_store_gfp(&mas, NULL, GFP_ATOMIC))
> > +		return false;
>=20
> But why does it use mas_store(NULL) instead of mas_erase()? I thought
> the iova alloc/free has to be pair wise, we don't split allocations?
>=20
I just looked into this some more, and I was
confused earlier this week.

The mas_erase() function calls mas_nomem(mas, GFP_KERNEL),
which is not safe to call while holding a spinlock.

The remove_iova() function holds a spinlock, with
interrupts blocked, and needs to run like that because
it could be called from places like IO completion
handlers.

That leaves the option of either having slightly
uglier maple tree code, or going back to the
augmented rbtree (but cleaning that up a little).

Just let me know what you prefer, I'm happy to do
either.

--=20
All Rights Reversed.
