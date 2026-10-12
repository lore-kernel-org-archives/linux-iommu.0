Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980DC3A1E81;
	Mon, 12 Oct 2026 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791835569; cv=none; b=XYsbZSv+ouYNGkKzZjiWGFrc2Kw5d3f0V9Y86Z2g5T26MVaYy+q5h38uRxiEM3b9HIUyvCJEB91Ai1mqlS18y9fPlfvK/WEIHpl5MPQTg5D5l0+aGyN+GANFQjmVCjtvd4Lf9ZxFJkbrL8bsa/MI5EqO9gt2tg9G7sKWD4nmJTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791835569; c=relaxed/simple;
	bh=4ReBJ2E+TJExN2d1iI7yALePqkF8bg/z0h6TsPrzkMs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jo1d5LGWBY0BVJyzxIIY577fJUdaqX6tnR/uv7rN5r/De2aPtdyXZ7Z7TQgLp/OIWHAJJ4aiBB1V5fPw9O23uOwV9Y+QvWsCfT5C5usHVDBGFPp3PL0+ZP8Wx4NGK74FGxSjuKNwNGKkwV2Zq+wyUkus89Aa0CdD2Cbwu1ANJio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=HlY1KLuX; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="HlY1KLuX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=4ReBJ2E+TJExN2d1iI7yALePqkF8bg/z0h6TsPrzkMs=; b=HlY1KL
	uXtzmJOuBli6lpNiRYHWIuTY3zDbshZ58S4WipPA31Dqd72oEaeVToCTvQoqihuMIakJQvlEXnxHY
	VvA5XHQ29URH+pkUptGCz6scIF+akFIYptVlz4zp73xj7kaX4O0SASaf/i630tZCfjetCxxABfpC7
	J5wTjZhSYuArvazb8m9gPbacPSBS6717bd+MiDwtQo/XpnJRp0So32GpoufsdJNguI4eRYuWzZzO6
	Hlr8MeqhXK70YOl6Xnc9433WV62j34roGyNNc9ADrW5P1Wiukd/rPlF3AxQT1yU5JbeHYgc+e4wBI
	3r6Kgef+EvrsheKn2EyhIUyyxVeA==;
Received: from [2601:18c:8100:a0e0:2541:b86e:2586:d219]
	by shelob.surriel.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <riel@surriel.com>)
	id 1xGMHO-00000003WRB-1D3K;
	Mon, 12 Oct 2026 20:05:50 +0000
Message-ID: <a27117bd826de3cb1e6c791e384d3291a040d8c6.camel@surriel.com>
Subject: Re: [RFC PATCH 1/3] iommu/iova: convert from rbtree to maple tree
From: Rik van Riel <riel@surriel.com>
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com, joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev, 	liam@infradead.org, maple-tree@lists.infradead.org,
 linux-mm@kvack.org, 	ashok.raj@oss.qualcomm.com, jgg@ziepe.ca,
 kyle@mcmartin.ca
Date: Mon, 12 Oct 2026 16:05:50 -0400
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
>=20
> However, either way I do worry somewhat about the increase in=20
> fragmentation and premature failures once the space starts to fill
> up.=20

Now that we have AMD's test results, how do you
prefer we move forward with making the iova
allocation O(log n) ?

Do you want to pursue the maple tree approach,
and live with the fragmentation worry?

In that case, I'll apply your suggested cleanups.

Do you want me to code up an augmented rbtree
that propagates up (power of 2) aligned gap size,
so we can do an exact hole fit without having
to walk through the tree?

Do you have some other preference?

--=20
All Rights Reversed.
