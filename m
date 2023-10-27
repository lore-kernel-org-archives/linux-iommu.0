Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BF811734
	for <iommu@lists.linux.dev>; Fri, 27 Oct 2023 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="z7zS86gC"
Received: from 8bytes.org (p4ffe149c.dip0.t-ipconnect.de [79.254.20.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id EE0E01A6E6D;
	Fri, 27 Oct 2023 10:09:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1698394167;
	bh=mpfFYjRK6XwO09uwATLMFuOqZdAObOn/Ob6OtK6JIKE=;
	h=Date:From:To:Cc:Subject:From;
	b=z7zS86gCF6Ua5NqmNM4Fp3Xa8LwlcFZLZ3HAlNxTxpZNSlt/kKVndNZ2nuB9jJU6O
	 cuNEA6cyP2YJfFdjAj+Fd0GBXKCPqGyZruR567GSTuzxv/OJgns1jCHvFv/21nK/1O
	 ocnd/OEJS9QIq2GG2zhHTqACq4eDUOMxtZ/+ALp+KC+6a4bpl06o/V06EYEL3eU/9j
	 uqZRp0s4p1G8eLCbIh+GdL5Aw4TNVhh53q0YdU3WyUQok0mitg1nDm4gpRYw3ezSTz
	 5bOJyxTwZYKvotIoWHBh9AtKrS6mIi3W5CzPfQH2sl68Z5azPp48wP42S2JahyA+Yr
	 HaMH9V5Cq6Pxw==
Date: Fri, 27 Oct 2023 10:09:25 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fix for Linux v6.6-rc7
Message-ID: <ZTtwNUIIenr5xRPO@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="56LkrRDh9Ji1CIrW"
Content-Disposition: inline


--56LkrRDh9Ji1CIrW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1:

  Linux 6.6-rc7 (2023-10-22 12:11:21 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v6.6-rc7

for you to fetch changes up to 6e6c6d6bc6c96c2477ddfea24a121eb5ee12b7a3:

  iommu: Avoid unnecessary cache invalidations (2023-10-27 08:57:09 +0200)

----------------------------------------------------------------
IOMMU Fix for Linux v6.6-rc7

	- Fix boot regression for Sapphire Rapids with Intel VT-d driver

----------------------------------------------------------------
Lu Baolu (1):
      iommu: Avoid unnecessary cache invalidations

 drivers/iommu/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Please pull.

Thanks,

	Joerg

--56LkrRDh9Ji1CIrW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmU7cDIACgkQK/BELZcB
GuMz6A/6AxXZb/w8NgyD1GNwsiWkrLIoGZ4aQWagZd5qWoLA25slYgGnNSvlhZCj
BEjZf/5ejMUMsndDm6Ane18QbxO8a4lxunUBUc0H8nBjZ6JkXPrMO0r7wO7oSgse
UMwoIM+OOeF/vso+lITYwbaswTJr2oS+3wMaQebZX/QRZ1qUU833lO71solqbjMT
9nRqZiNpB52fPK/sY5JQ9HknZL9hMctbylzs7SIsJ2p8CWBbkMF+0UycQY6h5aFb
2+Az5T7hea+h86cs/utFEwKhcY4iK07xQgFV5MtX7vBJio8zVBBdoNtWBVh27q5u
czXAnN8HCJBOmDuNjAvlKzWoQ5goNx6yRgRyIymBzmPW+yAXKMi+/ryQgqVRm2tZ
04RZovXOUahJJStAhQDvB/WtVPv8m4yadWvU1quPrkH8vISveGVGe449qBCOW4C8
dq+0t3K/jtC18egZKFPIFt4lP1D2WWPMQ4NFiv7Hwh/tohriBTC/OfNDsZf9qlrf
hAXOH3fhyTy8mkWVoJOvUs1WcE3BytPlDUoUaasq19RZVoorgE2sx06n2s4g8t6b
WsGOJn1x4XpaoSzwX+SomkX/FKuvgCDV9LzzP4hZ3z7MzZF6DTJTiaQG5yN685cI
OKJDB9OTfDICaVM0FbDhwYAqdJc/TfyVtZvLpLE6MmPTMof6YV8=
=Kyox
-----END PGP SIGNATURE-----

--56LkrRDh9Ji1CIrW--
