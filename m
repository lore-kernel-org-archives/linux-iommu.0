Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E645C3630B7
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 06:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778222918; cv=none; b=fM1VSxVM1oqvZXt52FnQqYU1d2UbybK4Etyoe+X9EP9vFbgID9z6e85HWdSnzCcsirK1H+xFNGfsIAxafGCE9sd4D5uuilATQYxi/Z//qHOrIhwBWnGfYwb9kmoQJPNP3XucIGdUYiVvKNgFKyiN/g9L1B1PmrBBdu3nkhnDziU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778222918; c=relaxed/simple;
	bh=5RlyPK5vvXRwwanYyUQeS2uslwSfOuhbSIwW1dfBMTw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tXJ16Us413zT51Txid97HA+SGRK3F4PDh/D9NgPzGT/XMm549FOYQ8xMJyvuQrflJYP4URZVrk+liiyXq+ChWVmvj7SEmTuYQOCZLCpqWYwV3u1A8WXJ9cKTPVofJsOaZ9T5BG++ugqMhP7R3o5t3Xf31pFUn6yGqAcThEwV4wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=7c99ZZ1u; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="7c99ZZ1u"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8D8121C3CD1;
	Fri,  8 May 2026 08:48:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1778222908;
	bh=5RlyPK5vvXRwwanYyUQeS2uslwSfOuhbSIwW1dfBMTw=;
	h=Date:From:To:Cc:Subject:From;
	b=7c99ZZ1uAS47ocJmzmp5SDaZJ1n3NrspKIYdMvrdx7aGPYD7rCDZwpgfposzWgBuZ
	 wOBxCIlSNer/YTFSQR1C6/LgpWXvSyeO/NYsHS+zevQAOwQTcF8hKZ9T7WdP7KpVz3
	 2PYKHALxCB9RpSpnvG7i9ivkbv8OVcffESoHmUDToLM5eM8TMq6wZwXiweuOGQk8uV
	 0UDC2ywD53iucKq0/0Rp8fgpTHfcmC0H6jDdS9IMBskP5E579Vby19GMrYLVhzWojN
	 7+hjRzavoV37+AlkG4zq83uvtwSp+ZzM45v9StGPQTnRIpUFTWaXOWrbnRcwzYf5KJ
	 Iy6MxkDtmzfPQ==
Date: Fri, 8 May 2026 08:47:56 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v7.1-rc2
Message-ID: <hczz7n5onhjxyrwum2quka5braofmab7wstrzni7cvx36ti4c2@pddvq6ufemun>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mxecx5kdxi56uevv"
Content-Disposition: inline


--mxecx5kdxi56uevv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [git pull] IOMMU Fixes for Linux v7.1-rc2
MIME-Version: 1.0

Hi Linus,

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.1-rc2

for you to fetch changes up to 10161b4a791d5c4b7ea16512c1ddb133c3f8f953:

  iommu/amd: Fix precedence order in set_dte_passthrough() (2026-05-04 10:26:16 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux 7.1-rc2:

Including:

	- Core: Cache-flushing fix for non-x86 platforms.

	- AMD-Vi: Security fix when SEV-SNP is enabled.

	- AMD-Vi: Operator precedence fix in DTE setting.

----------------------------------------------------------------
Mostafa Saleh (1):
      iommu/pages: Fix iommu_pages_flush_incoherent() for non-x86

Vasant Hegde (2):
      iommu/amd: Use maximum Event log buffer size when SNP is enabled on Family 0x19
      iommu/amd: Use maximum PPR log buffer size when SNP is enabled on Family 0x19

Weinan Liu (1):
      iommu/amd: Fix precedence order in set_dte_passthrough()

 drivers/iommu/amd/amd_iommu.h       |   3 +
 drivers/iommu/amd/amd_iommu_types.h |  21 +++---
 drivers/iommu/amd/init.c            | 123 ++++++++++++++++++++++++++----------
 drivers/iommu/amd/iommu.c           |   5 +-
 drivers/iommu/amd/ppr.c             |   8 ++-
 drivers/iommu/iommu-pages.h         |   2 +-
 6 files changed, 113 insertions(+), 49 deletions(-)

Please pull.

Thanks,

	Joerg

--mxecx5kdxi56uevv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmn9hxwACgkQK/BELZcB
GuPVbg/+P3voH5/DlCfZ57ju+hiJHkOS31yTdUYNPRFu7wog+oD2WE4pPcs2CDlV
UmocW4ro60K2USjiMSb3X2eBU2xIwQzY5Vxgp3rkUJaFENGTDS4RPs+cG/X02LxO
aJXs/2Ljtzw/7PU8Ccm4TzpReKKcl/STAH3RDh2f3nUYw6F4BmVUo3cw0YUbyfgg
cJYGTVJov3/VUVt8GGdo/WAt8Gf6gAkiZNk3/ml9gu8Ta2wf5G4leK8AhIcJ3XM5
o5sfvr8EgtvKJUcGjOszT9vLzXI4l4ybAC7PP9Npby/39H/5S5UwBjV4W53rZNSr
mSLDwX3wiMewRStDJV7Btq9pCDRmV1Nphii3bZdXivkOG+AodbuUYztRcr/Xe/sp
mvx1FonpeJJ0xRpwQNVf8uutLp75yEjNoghxezJExqQf0BYxHlGyfQtJ/AkptQ8k
x0CFPMmY3gVvkHNhpAajIWksmYftDlnKQ6Kq5thOSq9fuNzasbwhtnT3Vrqm21Gy
VNMm5kONkzKF3YGbPIClNqjm/94rD6BqKG8L9GwlnnJnAqkt19irdTrY0aJqmZAA
T7qArQ0grlpdwrHQu3tR4eViHv3RItG/euLNEz9rstHYZnLphjUNExaC7HxBGzqJ
7kskYI5FxKHcFnL53N0lOVgl7agmxCpyDF3j3g/Y4ff5cTWRYt4=
=bmhW
-----END PGP SIGNATURE-----

--mxecx5kdxi56uevv--
