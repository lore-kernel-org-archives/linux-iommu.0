Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397321DF980;
	Fri, 19 Jun 2026 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781895323; cv=none; b=eS8DLDUdL8zIc+8P+Xra0GLDLZemmmMW+qmUhRtLCT8xxluFODZwCiBvlyn6c4/CrAe2ETI+U5M/vjuyYvxMb9wZGOy8WzfZfVAJDkRYOVEaNtwJu76RowZ8Ybn4e2RpQpVkLVjE4TAkm0S6r7mfa1cqzfnrimyLj5p+4EuLaIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781895323; c=relaxed/simple;
	bh=lWGmWLHBkxB+j0p3dxSqyRjenJ6errj2YxoYMUe4EFM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kkce9VxNvJFi7HzvrmE/v6P77zfVW404ZIuvz45NXHQPf1N/shefNNONYDsJB7/Ok9ZObdchg8XaQm8s5GbHOe/feS/F7ZkeIrqjQpgsF1ITAZ3dXoDIw14lW0ErZb0eVlrrOnVdSVZV+plY2DSr8DScpUTr90AaeP8yKVRRNsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=JxZIrA69; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="JxZIrA69"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lWGmWLHBkxB+j0p3dxSqyRjenJ6errj2YxoYMUe4EFM=; b=JxZIrA69mCqmFaUlRfDsiTz+2Q
	RsJUVizMo5yCkGs9tcei9Ax+CAltcDESIPm5f0emvrT3pmE2+08sY7UZLLRw7osnziH/7i2iLuhhq
	RkxuDnmsjjk65XXoqcFeuz6k9cEShpE4aqfFpjzCYBfCSFDuCt1hBYl0yrLLSv/s4jH3a4IDb2Zq8
	yu58g7U1DOiYIHYYJwlPlr44NbWOXP/Vy0KwvSbK6Gk5efUoDShb/A0rJT5LzxCTtiOCf9dWKAKab
	CSJ4Ypf6b3HJDxLt2RyqIDeQdWTVa7uIExOiNqJL9Qq8eyAWh5eVdg1AVIhiELpPsHHgr2xh3qt3Y
	ejG9favg==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1waeMf-000000001cy-3JKu;
	Fri, 19 Jun 2026 14:54:53 -0400
Message-ID: <be52916d7cedb991b1d0cff338064639e1da1f92.camel@surriel.com>
Subject: Re: [PATCH v3 3/3] iova: defer maple tree erase on GFP_ATOMIC
 failure
From: Rik van Riel <riel@surriel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, "Liam R. Howlett" <liam@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 robin.murphy@arm.com, 	joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev, kyle@mcmartin.ca, Rik van Riel <riel@meta.com>,
 maple-tree@lists.infradead.org
Date: Fri, 19 Jun 2026 14:54:53 -0400
In-Reply-To: <20260619121319.GK231643@ziepe.ca>
References: <ff5f9e09edbcb9c87feac6af00a1d835c783be4f.camel@surriel.com>
	 <20260612180303.GO1066031@ziepe.ca>
	 <iv7sxqezzz42xieytbf3lskutricz7ltkr3wii3w4jbnbzto7f@2tz5hwa43l37>
	 <20260615115633.GQ1066031@ziepe.ca>
	 <vbtql77uf65vyxl4smefpol75x3opa7vnixdbzwg7ylxgre6j4@emvlfmdus4kj>
	 <20260617180419.GA231643@ziepe.ca>
	 <hsojwfbi5e6mpgtzd6rupod4xkviaehj4uo4xo7k2qmmswrc3v@odf2osyjxehw>
	 <20260618152451.GE231643@ziepe.ca>
	 <ea36fdc51f710d01f0e9bc389334e0b8be96eaea.camel@surriel.com>
	 <76xtcbn5hxv3z2w6zbbudr5exjqdgjan4dkcsvrpgagdfpc45x@7prb5j6ivh4w>
	 <20260619121319.GK231643@ziepe.ca>
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

On Fri, 2026-06-19 at 09:13 -0300, Jason Gunthorpe wrote:
> On Fri, Jun 19, 2026 at 12:54:13AM -0400, Liam R. Howlett wrote:
> >=20
> > no, but how often is there a failure?=C2=A0 Would walking the list and
> > writing NULLs be out of the question (I really don't know, sorry if
> > it's
> > a dumb one)?
>=20
> Yeah, this is what I was thinking. Should never happen? I wouldn't
> burn memory in each node to make an emergency recovery run faster.
>=20
> The idea of keeping track of the high/low along with the flag makes
> sense, it will narrow the IOVA range to search.
>=20
I've got this in v4 of the tree now.

One open question is whether cleanup should happen
from the next allocation, or whether we should
move that into a work item that runs in a sleepable
context.

--=20
All Rights Reversed.
