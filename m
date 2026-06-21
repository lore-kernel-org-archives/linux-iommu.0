Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E6439FD4;
	Sun, 21 Jun 2026 01:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782006819; cv=none; b=pqJHCuvEBmm0NJ1KTqmuFKOCJXGymedUzU+XjiywbmmkRdCx1KM2puUO3CzM+CKO0FC0e4kkUcauHtT3yCKwDHmeHoSrRaVCuyqAhIU/52gQs/W2WcwRRoxRjrDyi6y3AJxDuizEGKTw7aHmIsdjUfrQSEjnpu+jUcFJ+2Df0L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782006819; c=relaxed/simple;
	bh=Wkw+gTSghhW0kllSpEqKPRPGIFYpsLmVdDt9AhVNsCc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kfvat4bzdxtyR60VazRuIMCw+CKXSWABNSB8TH3mSiKy/JMuNw2dkFFKH+WGmgIAL+GGUQ1RkxaDMJByYReTzg8lYZdZEQjpJGnTojdzIgDduh+g+yTOZ8g9R+n4H8411Xdofi4ubgNAEhS+MPJliO7lZ5C7QbGt3yqAuve8YqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=BlW5fahG; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="BlW5fahG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Wkw+gTSghhW0kllSpEqKPRPGIFYpsLmVdDt9AhVNsCc=; b=BlW5fahG295vk4fOpUjwc5VPEu
	Ud2vqZyrDZTa7F5HdCEmB26QKixeqxJ8Q1J/z+ZS2Ak2FmFDmDeWsW7Vd0cPewvX+I4jCr/KMo1a8
	aYW5HOmnFHIp3hfAm3aNpKr33MLDMLkw3k0CgDapFkj7gDEv3xBlKF/9SCvWGLpBXC4wEnX63Y+O9
	GBptv+JKdWF1BDYoJaTN4YYGrSiJHfur8v4OtTb5dQu+PQkeFVU0hTwkqESm0IOGeMIRs9o6Ew03e
	iyf7+ni5xEyTauKXasJx1Hw7lDDtd9PrHwUK3t1otN76aY7/tqhWFmgg9FkFYaBp4o0T8w7uPal60
	5Ej8t5YQ==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wb7NF-000000007DA-0IHQ;
	Sat, 20 Jun 2026 21:53:25 -0400
Message-ID: <3a3854392b47181d3c64e1961d09b6465efbcb2b.camel@surriel.com>
Subject: Re: [PATCH v3 3/3] iova: defer maple tree erase on GFP_ATOMIC
 failure
From: Rik van Riel <riel@surriel.com>
To: Ashok Raj <ashok.raj@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 robin.murphy@arm.com, 	joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev, jgg@ziepe.ca, 	kyle@mcmartin.ca, Rik van Riel
 <riel@meta.com>
Date: Sat, 20 Jun 2026 21:53:24 -0400
In-Reply-To: <ajcreJrgM1iCSzxp@hu-ashoraj-lv.qualcomm.com>
References: <20260603033653.4144138-1-riel@surriel.com>
	 <20260603033653.4144138-4-riel@surriel.com>
	 <ajcreJrgM1iCSzxp@hu-ashoraj-lv.qualcomm.com>
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

On Sat, 2026-06-20 at 17:08 -0700, Ashok Raj wrote:
>=20
> =C2=A0 If remove_iova() keeps failing (mas_store_gfp(NULL, GFP_ATOMIC)
> still
> =C2=A0 can't get a maple tree node), the iova is pushed back onto
> deferred_frees
> =C2=A0 and the work reschedules itself at a flat 10ms =E2=80=94 forever.=
=C2=A0 There is
> no
> =C2=A0 retry counter or no backoff.
>=20
> =C2=A0 Under sustained memory pressure a device doing frequent unmap coul=
d
> =C2=A0 accumulate a growing deferred list, exhaust its IOVA space, and
> start
> =C2=A0 failing DMA map calls =E2=80=94 with nothing in dmesg pointing at =
the real
> cause.
>=20
To some extent, yes.

However, if we have GFP_ATOMIC allocations continue
to fail for several seconds, the system will be in
much larger trouble.

Making the condition visible seems like a good idea,
since I don't know if the other GFP_ATOMIC paths that
could cause system hangs output any warnings.

--=20
All Rights Reversed.
