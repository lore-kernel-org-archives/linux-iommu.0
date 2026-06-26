Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281F53B47D9;
	Fri, 26 Jun 2026 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782498786; cv=none; b=r8+3iJPa4g+uEnqrQOnN94fcNAuK316X/axWYx80rAMqH9y60xQ/Jjq0ZGB9EnGgfpL75emqEo1vr7VYGYbEghNy7R3PcDchXJI5mKeOeJypS7DqpIm75hwWmcA5iVL8VvmtULzcMWY0h41YPaJ5m2c88EtzTHo2CTmvmbetxSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782498786; c=relaxed/simple;
	bh=wHQpCqG95XlFFHAMSIKHDU4GU4mYH/iJHk1Y0uBOMQw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rokF3oa8K1GG+e6QNk8UbLbnBVKz2jKhCuRidIvbB/lFW083AfImPp9ZiyEIyXCsZzPkf6bZcY8ObrnqEdjxnv5kCLxb5wqafzU4QoAlh1ieTKKGlIxt2XTFne+52VCHhD0cKn8P3pVav5J0Fs/X2BwVC/duQVX99LUcF4pnLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=THuKbE3J; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="THuKbE3J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=iyjE6Dhm0bhwSWIdqUH4ZmDX2rlKaOGTcuORxxwf6Hg=; b=THuKbE3J2F7te35y7B2FdbDIio
	w2OgM01S9opETnlwGP/NDE1GxAH9BiPJrWxvmAr+kZIPK9ngZ8Jm7+oWYvD8GFoHDmgZhGC6bvOH+
	Srw9DZa35jiLcuZpm+/4UwnIvjNP/knRRYoetiVt+BKum3zInn4veET0C4djHAhyOZczm4A0Ujt51
	Dnwe/nJpglKpqpdgeHSSZ4P8cLK/4UPvENYc3vsixwMakc0xkkLpYVF5oJ11UnqiHyT9OtqLOU1ZV
	C2Li0+Ecugj0BujuPHRFGFBlM3dq+di/dCDgYEDc6yG8jW2f4OCNspgrIz7tYFI3lamE4P4n4/h2g
	p5zyQQtQ==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wdBMD-000000001l4-06aO;
	Fri, 26 Jun 2026 14:32:53 -0400
Message-ID: <ab7b21eba098ec85e8977b03208639873f43e071.camel@surriel.com>
Subject: Re: [PATCH 3/3] iova: defer maple tree erase on GFP_ATOMIC failure
From: Rik van Riel <riel@surriel.com>
To: Ashok Raj <ashok.raj@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 robin.murphy@arm.com, 	joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev, jgg@ziepe.ca, 	kyle@mcmartin.ca
Date: Fri, 26 Jun 2026 14:32:52 -0400
In-Reply-To: <aj1OlqBtTOUSFm-h@hu-ashoraj-lv.qualcomm.com>
References: <20260624030853.2340880-1-riel@surriel.com>
	 <20260624030853.2340880-4-riel@surriel.com>
	 <aj1OlqBtTOUSFm-h@hu-ashoraj-lv.qualcomm.com>
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

On Thu, 2026-06-25 at 08:51 -0700, Ashok Raj wrote:
> On Tue, Jun 23, 2026 at 11:07:36PM -0400, Rik van Riel wrote:
>=20
> Hi Rik,
>=20
> =C2=A0 Thanks for the v4 redesign =E2=80=94 the in-place marker approach =
is much
> cleaner than
> =C2=A0 the delayed_work/llist scheme from v3, and it directly addresses
> the
> =C2=A0 retry-forever concern I raised earlier.
>=20
> [snip]
>=20
> > +/*
> > + * Remove an IOVA entry from the maple tree and free it.
> > + *
> > + * This runs in atomic context (DMA map/unmap can be called from
> > hardirq,
> > + * softirq, or with spinlocks held) and must not fail. Erasing an
> > entry can
> > + * require a maple tree node for rebalancing, and
> > mas_store_gfp(NULL,
> > + * GFP_ATOMIC) can fail under memory pressure. When it does,
> > overwrite the slot
> > + * in place with IOVA_DEFERRED -- an in-place store needs no node
> > allocation and
> > + * so cannot fail -- which keeps the address range reserved (the
> > allocator's gap
> > + * search treats the non-NULL slot as occupied) and lets the
> > struct iova be
> > + * freed now. The marker is erased later by iova_drain_deferred().
> > + */
> > =C2=A0static void remove_iova(struct iova_domain *iovad, struct iova
> > *iova)
> > =C2=A0{
> > -	MA_STATE(mas, &iovad->mtree, iova->pfn_lo, iova->pfn_hi);
> > +	unsigned long pfn_lo =3D iova->pfn_lo, pfn_hi =3D iova-
> > >pfn_hi;
> > +
> > +	MA_STATE(mas, &iovad->mtree, pfn_lo, pfn_hi);
> > =C2=A0
> > =C2=A0	assert_spin_locked(&iovad->iova_lock);
> > =C2=A0
> > -	if (iova->pfn_lo < iovad->dma_32bit_pfn)
> > +	if (pfn_lo < iovad->dma_32bit_pfn)
> > =C2=A0		iovad->max32_alloc_size =3D iovad->dma_32bit_pfn;
> > =C2=A0
> > -	mas_store_gfp(&mas, NULL, GFP_ATOMIC);
> > +	if (iova_kunit_defer_erase || mas_store_gfp(&mas, NULL,
> > GFP_ATOMIC)) {
> > +		/* Erase failed: mark the slot in place and defer
> > removal. */
> > +		mas_set_range(&mas, pfn_lo, pfn_hi);
> > +		if (WARN_ON_ONCE(mas_store_gfp(&mas,
> > IOVA_DEFERRED, GFP_ATOMIC)))
> > +			return;	/* in-place store cannot
> > fail; entry stays put */
> 		/*=20
> 		 * <-- deferred_lo/hi not updated and range stays
> 		 * occupied for ever?
> 		 */

If the in-place store fails, then updating
deferred_lo / hi won't help, since the
sweep later on will be unable to identify
this area.

Freeing the iova at that point would leave
the maple tree with a pointer into memory
that could be re-used for something else.

We need to either return early and warn,
or panic.

I'm fine with either.

Robin, do you have a preference here?

> > +		if (pfn_lo < iovad->deferred_lo)
> > +			iovad->deferred_lo =3D pfn_lo;
> > +		if (pfn_hi > iovad->deferred_hi)
> > +			iovad->deferred_hi =3D pfn_hi;
> > +		free_iova_mem(iova);=C2=A0=20
> 			<--- only reached if second store succeeds?
> > +		return;
> > +	}
> >=20

--=20
All Rights Reversed.
