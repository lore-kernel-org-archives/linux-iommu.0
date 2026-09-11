Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB284A99B2;
	Fri, 11 Sep 2026 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147661; cv=none; b=HrxXVsAsWa1U3wbAoOnagYAiBhFR2ScU8gdMgBCIE/RPCEQ4OqBs5jvbx4BH7q2wm6OjogCCvyZVHzbrv7AjQGSp/zmANPlNSx2S0+KyHEJkvGGHt9Of57QdOtCYsjXNuBj+p4S2RWu2Dp/IQU54mextisW+7HK1YM/O55dTl6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147661; c=relaxed/simple;
	bh=B4aEx9TiL+yJCtdnf7L1fkdsEwBRjE1oa43sDYAmTPA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cba14hWMFd7dtjbOPzst6ERdGPPwtfu2heZQcZdWxeXG6l/1BSNURXY5OPIv1uXJ6L/RpKwnpGdUFBOM9lggnBJY90VWAj1REux82+o02JdxMGAcyVCYtvNQQlWwxxiRoGOh/hAXrCHGZLFEr4ZLoKZLEI1v1OFGv764o8TtYPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=BS+G/orQ; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="BS+G/orQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=B4aEx9TiL+yJCtdnf7L1fkdsEwBRjE1oa43sDYAmTPA=; b=BS+G/o
	rQOrwG7xj/97spFHkKba3uYLrwyroT3GsWfVqISVOObPzf01DlqXBGJuUUKNZQKbouNad8MfdYGty
	dTOFK4zjGsbUXjCcXlOtfP1eD6Tm7W/PADXr3v/JoPJJIkJdZMpfECPwfLv+ljjFidW0DN7yAL34d
	SVWteweLwuZEVlWZ8jjIQ7oEPichFhniJOl+LlaetaEPX7nARcyIZCbwHGrcnakpZBmOHGbwzeuww
	Bgg0/GYoAld/rmq1YIBMl1Na3Qv+9Yjo2pfPb9VLz6zcCocjHC4MF0sofiQqJjvZeUT/WXz2Ly6zm
	qJGYYP82Nb6USGoLpkGlIr3HQrtw==;
Received: from [2601:18c:8100:a0e0:5a47:caff:fe78:8708]
	by shelob.surriel.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <riel@surriel.com>)
	id 1x552A-000000082Ib-0d0s;
	Fri, 11 Sep 2026 17:27:30 +0000
Message-ID: <d2f5889660e97f03fae2cd43ae32d8bf8edf3446.camel@surriel.com>
Subject: Re: [PATCH v5 0/3] iommu/iova: convert from rbtree to maple tree
From: Rik van Riel <riel@surriel.com>
To: Ashok Raj <ashok.raj@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
 liam@infradead.org, 	maple-tree@lists.infradead.org, linux-mm@kvack.org,
 jgg@ziepe.ca, kyle@mcmartin.ca
Date: Fri, 11 Sep 2026 13:27:29 -0400
In-Reply-To: <aqQ2E68lmU3Fbjsk@hu-ashoraj-lv.qualcomm.com>
References: <20260818152505.1057922-1-riel@surriel.com>
	 <aqQ2E68lmU3Fbjsk@hu-ashoraj-lv.qualcomm.com>
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

On Fri, 2026-09-11 at 10:10 -0700, Ashok Raj wrote:
> On Tue, Aug 18, 2026 at 11:25:00AM -0400, Rik van Riel wrote:
> > Occasionally production workloads at Meta run into the linear
> > search in
> > alloc_iova() in ways that cause real issues. For example, when
> > enough
> > CPUs at a time fall into the linear search trap, systems have been
> > known
> > to get stuck for so long that it causes soft lockups.
> >=20
>=20
> Something odd, except your cover letter rest of the patches are
> missing
> v5 prefix in your patch?=20

Ugh, indeed.

The content of the patches matches what I wanted
to send, though.

Do you want an identical v6-marked series, or
should I wait for feedback on the code?

kind regards,

Rik
--=20
All Rights Reversed.
