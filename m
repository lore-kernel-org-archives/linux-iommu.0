Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135372AE68
	for <iommu@lists.linux.dev>; Sun, 30 Jun 2024 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719785972; cv=none; b=RtX0lSQJ2LE++73NKOIRYnblGCGIAgvU8GzZ7JwFsQ+AvL8JU9ZcePov1jbJOnwTpxGY1Owt0HJ/mxVigMPwnfyyPQrb9R4EaeJGYpumuBxKIb8dxYjG5MJ64UMywUiTejpuWnE08eKNcoSzl25UNmOhbABhej0WYxSmQpiwDtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719785972; c=relaxed/simple;
	bh=xCp4ano/3VNrGhMSu4iDUA3AD8obFu1cgLIQwCIWzJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jy9PIGU2MMVzJEcOrspm8plfnYbfX0vFEH4bY2D917dQswf7zGm/AbtdssZ5Djl3HDnMWTc4APFW6qD/ToVJROXCoUJ4MHHpUuXBkztew3YuJVr/u/EgJ6DkddJU/LVZ2NQ+36hlEkJCIwPP4/fUNBsn7qdyD6ddYdFKBZaR7LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=GeA1emrw; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GeA1emrw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1719785957;
	bh=vX6SewIUsmFIoZFLZJck3ZPyN5gSqkjpImgu0SnMlHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GeA1emrwNc2M5ZDQbjw2szapixrzsOJxS4BKf1JjmrzpYuEmtvYFRvR9Ss8nqq4B5
	 Efnbvz66yzyG4O0xu3b6LIABl6Tw1Z9YbHlaB2fqcXc8IAt6fXstfasiJlv8+MZKhf
	 5HkI+jD48qfzNJs8tZ+R73W78biE7j4nPapEfkDnU/60xzGOq3fjzkwdSNr1CLD7bz
	 gMX1/qUKeK5V+Bt2GQbK18V9i0i3gncbt1bIc5Z2COVaPbWilcD600cQunDBsX6GlT
	 1qimrfJAHvmowO0hky/x14wkCRvXSKERVsLHGXF+UqOOo9L4uNmrOvCHim7VPDKFwJ
	 ugIDHzt3QZCag==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WC3Vr6ZRQz4wxs;
	Mon,  1 Jul 2024 08:19:16 +1000 (AEST)
Date: Mon, 1 Jul 2024 08:19:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev
Subject: Re: New location of iommu tree for linux-next
Message-ID: <20240701081914.559f728e@canb.auug.org.au>
In-Reply-To: <Zn6xzkJk95d74Cpu@8bytes.org>
References: <Zn6xzkJk95d74Cpu@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/E+BZm4KEifg9x45ss21USKR";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/E+BZm4KEifg9x45ss21USKR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi J=C3=B6rg,

On Fri, 28 Jun 2024 14:51:26 +0200 J=C3=B6rg R=C3=B6del <joro@8bytes.org> w=
rote:
>
> Just a heads-up that the location of the iommu next branch is now in a
> new tree:
>=20
> 	git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git next
>=20
> Please use that branch from now on for linux-next.

Updated from today.

--=20
Cheers,
Stephen Rothwell

--Sig_/E+BZm4KEifg9x45ss21USKR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmaB2eIACgkQAVBC80lX
0GyBgAf8CCvoqR3lGGwZWYp8T7HR+a+mdfLhd2Pa/5OcjEn4K4th2juM7GjtrO3c
Ct3PqAW3DAt7Rpz83QPeXob4wFl4g4bpnENYPCCMwAcVigJ/L78OPpOLNLJMJwsJ
ZkSDjJFbZ9TeY+JlYLTFXBq9JdNLEVpsugYx2PYlxrHeBPewqqD9/QbKox+QDYVa
LrNGmlgcE0AcbINNuLUg5/DnRyNHuODIG/Ul+lkzQM6diZs4uruKrYoLfiF/j02S
z8lSy+VnCPnx13EgbOXNqhMcvmLAgBoC+4m5KV4CYXkKaQURzQg8QWvFoEv3gAr+
7ca2F9GeBk8nVMD5RGX8rOzXl/Rfkw==
=p8B7
-----END PGP SIGNATURE-----

--Sig_/E+BZm4KEifg9x45ss21USKR--
