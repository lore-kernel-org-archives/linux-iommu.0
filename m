Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4746345CD3;
	Thu, 18 Jun 2026 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781803880; cv=none; b=aWZDsV9xnfcOPuPMFR0Efi5DcnJwQp1enKb1ySBNVNbpqlHg7s83LGeHZHZ4DCz+qjesg4HEDKzCSnVzHOtgG1dfutAk88d7Of/i09tianVv634dCAHCtL8g4R1LVlqz1wnQmS5DnWXUX9qLdLgGtvno3CraGBzC5Mr/GChXUGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781803880; c=relaxed/simple;
	bh=U/oijo7ClvaXIVAiqpI3ziqQOcJaiLEUx7KQDx1PYTM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rr0frTcFh0+yUcL+71QHn1vkLvVWE/sQ2j3y215a2yLJ97OQDp1MioOSCZqAVexUpbduLaotgzpwHSHiME59m7oTX4iJhaZwTm8tvhD1+gLD3fn9DdFULVk7eCuy6H48DuJAWBytIjMZp+euaVOFy2jXGOtsPq9b5dgSGUisw+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=a//IhpBP; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="a//IhpBP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=U/oijo7ClvaXIVAiqpI3ziqQOcJaiLEUx7KQDx1PYTM=; b=a//IhpBPoymxI394THQOf2TA7e
	FNxvxldYHIwLFeHXsaBu7LdYSvphVf2MkQBSo/H2XOy3eLF9uxXKhGz/QCUmpQ3N5JGpcAX8Pt5zx
	z3rK1r1rB7sYcbfFvCo3eFuzD5NRaXgXSeJL636n8IYtQ5QLWfCOSrjxVepO5nHvxkl1TU04sD/Oc
	xOPEP5hNK0NmWS3hB1TBDPncWOM+Wc7HiiKX+42seB/hd6Ufhj6EIcPgVWs8iZg3QHH32SXTZTl9K
	x64+ANmws43oD8DmjLmY7raAdqpQ/aQKY5qr/3kLQpZdZ7SjueaAN8290bODHdJW2ymq+0igelHUM
	MAqGcr6w==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1waGZo-000000003gN-1pSm;
	Thu, 18 Jun 2026 13:30:52 -0400
Message-ID: <fc0bdfd6e0ddcbde208dff785ea0ce7f41d1f875.camel@surriel.com>
Subject: Re: [PATCH v3 3/3] iova: defer maple tree erase on GFP_ATOMIC
 failure
From: Rik van Riel <riel@surriel.com>
To: "Liam R. Howlett" <liam@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 robin.murphy@arm.com, 	joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev, kyle@mcmartin.ca, Rik van Riel <riel@meta.com>,
 maple-tree@lists.infradead.org
Date: Thu, 18 Jun 2026 13:30:52 -0400
In-Reply-To: <r4jlbi3hbtvv6vrenarz6i7n6cu3vfqqdz2jfenkwsuv3fkadi@nq5u5txbtso6>
References: <61d51d4b5779d80145ceb38e9632a7cc8a79dbec.camel@surriel.com>
	 <20260612164852.GL1066031@ziepe.ca>
	 <ff5f9e09edbcb9c87feac6af00a1d835c783be4f.camel@surriel.com>
	 <20260612180303.GO1066031@ziepe.ca>
	 <iv7sxqezzz42xieytbf3lskutricz7ltkr3wii3w4jbnbzto7f@2tz5hwa43l37>
	 <20260615115633.GQ1066031@ziepe.ca>
	 <vbtql77uf65vyxl4smefpol75x3opa7vnixdbzwg7ylxgre6j4@emvlfmdus4kj>
	 <20260617180419.GA231643@ziepe.ca>
	 <hsojwfbi5e6mpgtzd6rupod4xkviaehj4uo4xo7k2qmmswrc3v@odf2osyjxehw>
	 <20260618152451.GE231643@ziepe.ca>
	 <r4jlbi3hbtvv6vrenarz6i7n6cu3vfqqdz2jfenkwsuv3fkadi@nq5u5txbtso6>
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

On Thu, 2026-06-18 at 13:27 -0400, Liam R. Howlett wrote:
> On 26/06/18 12:24PM, Jason Gunthorpe wrote:
> >=20
> >=20
> > - I like your idea for Rik to try to store NULL to erase, on
> > failure
> > =C2=A0 store ZERO_ENTRY, and then set a note on the next alloc to clean
> > the
> > =C2=A0 ZERO_ENTRYs?
>=20
> The ZERO_ENTRY can be found by mas_* functions and will cause issues
> with the gap searching.=C2=A0 You also have to be careful to handle these
> entries in mas_for_each() loops - you don't want to treat them as
> valid
> entries.
>=20
Could it make sense for the maple tree to have
something similar to ZERO_ENTRY that is treated
like a gap, so the gap search can find it, and
get rid of those entries when the gap gets re-used?

--=20
All Rights Reversed.
