Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B781BD035
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578905; cv=none; b=YpDvDuHpZ52wDKno41qfs53iEjT4ZzpbNiyRMLuRsQJc+HKJLX98FOppMcik+/X8ozMdXZAQFCNWMthvvL3oLa2/RqxTOIx2iSkF69oER7pQ2H7i53uIJpzylip+nVGfpO9Oob+0h7XrPPhBTgNi/8y9WUYkSN1c9xbKW9XJtK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578905; c=relaxed/simple;
	bh=fHICskeWw6YS2EHp0O4lIUmaV+xqePZh7nw5HErGQkU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tb7aiRjOP24TWNIGk3Tfm8T7gATZo4TaWdPb1KQZMxoPNeEuRWHqeT7DxsOPW7cttX+rF6pn1BmhM/yTa9qPNKG7mc1s/dufrAnS/6t+ydfV9SniFmZnh/f5NXIAApOkZI7y/ZqJEZ/pyAtk5sZiJPJy1a8BWfITM3L4hGGN+Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=I1gRl4dx; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="I1gRl4dx"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 543731C8A5B;
	Fri, 28 Jun 2024 14:48:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1719578902;
	bh=fHICskeWw6YS2EHp0O4lIUmaV+xqePZh7nw5HErGQkU=;
	h=Date:From:To:Subject:From;
	b=I1gRl4dxp0UrJ/BJ8Bi6IjRyOpMrTlPZEdXwsSzIF6nc0HCSGfEsWqwXq2SFP/S2X
	 QeBAamFZYkLeUUmFZ0ovpjnCDYROmf1VISFrODAE3pxJpGgwqJI6wTSw86Yyma3iPn
	 oZK7ufVwRexYWSF7/lGwxNEhKv+bBb7zPQJ+8MPH+GOqEFizmPtoWnMCYJK/Gk6s67
	 Ey4s5wBChBU9JxX5EElIISMSyY/QLAlluimSkDUBqH18Vzd7zPGlxT82TLfK820pgx
	 9Hz3GtIkP8e+u6dTV7z2OaXmhr2mU2tuR8Yzz2qraTsAGEMNCcDkdiEwJIF3d8Iu5B
	 9dKVCCXxKg7Fw==
Date: Fri, 28 Jun 2024 14:48:21 +0200
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: Off for the next two weeks
Message-ID: <Zn6xFZanlWhN5kw3@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i9VhOAkjRRgd1goW"
Content-Disposition: inline


--i9VhOAkjRRgd1goW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

here is just a short notice that I will be off for the next two weeks.
Will Deacon handles all IOMMU patches during my absence, using our new
joint IOMMU maintainers tree at

	git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git

Also note that with the new tree there are a few changes:

	* Many branches got renamed to the sheme <vendor>/<iommu-hw>
	* Removed some stale branches
	* Removed unnecessary iommu/ prefix from branches
	* The master branch is now always a merge of latest
	  'linus/master' with 'next'

See you all in July, have fun!

Regards,

	Joerg

--i9VhOAkjRRgd1goW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmZ+sRUACgkQK/BELZcB
GuN1+xAAwITYQCHSRPRKCV+cvpqzf+z4XVpTP6L+mOJZu9pXeAcsZRgh4KUHqNca
xXMSBHV1aG/KLXoUzPVIEB+ATmy65W0fGf2OA1oyBtXDkKnvs/FRsubRILWfKPVg
8DqCeVWH24oKmaDLUKQbHKu826418+PJT72MNzdFsXOGWr6/YqX8c1iwQtSpnN5c
eTwGj1coWWaauNLRARwaB0xD1VJc9vF4YWMCAOGoNlKeldEYo57oencsns3pJf0j
7R9cawoSZhi4AYgb19ETRAPkOWLAp1CYT2GJCHDlsQKQFb0yEIYzSeaJXSjpn28h
VybuCuWqznZl8nU/MafWRBbyN/4y+Iss5GgMpxa85oyRkj+nxhm33oyaZAsr4v13
3krniRqK+yiQ87/HXAshGZvOhjjZaj0JoBgKgVJIoN8fNfnAIldzd3ibPIC1bNa8
IxGaWTsdIS3Vgwq1NFCe/ZlRJxFPwD4ri51bRtgzDRj+RJS2PMGPvwjUi60w1aoq
gwjFYghRrAWpYVYnZDhh9mA1NlsmUpiawxHqO3Br041bNy98wurHqV+kqrm09zB6
5GTr2m+N9MvL6SxJ3HNM46rswRF4jbI/VDISfFpDTN9V8Tlx1Chzs687+A/IGTBP
kmBsC/6lPOp0LWYQnXVF/vuxDLO3c6UlNZNxjJq0ifFn7AsPi+o=
=B+0E
-----END PGP SIGNATURE-----

--i9VhOAkjRRgd1goW--
