Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C094179652
	for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022139; cv=none; b=GAJFPK0rXPf8qhQjPWuQe5StQ1BSEpJdzdrytLbvY7eUH/12HisOZGx5JL56c5B22hXQ9uBvaoSkDdZ4d2XMg5mjOilMdQH8sXG+DahL4aU7LY39gzPEeZ6jd373rYlapM8RJZlo2jjfgdAZkmDXVlaEMeXKh2TQoVK9cn+lsWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022139; c=relaxed/simple;
	bh=jUhwG5R0qWnWJOpTzFrDht5qN55ooWMDoFdCvpBkkkg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L+Sj18lpvDA9V1ooOHY3plm0JDlzfoZyLD8G9SQ0v77owz0JqYsqqSjLKjWcBcENePfSkoGE0G98xgFjseRM1huqzaS9gtFH+N0S4CIWDge5YO10a4lELJUwZJ16UoeBBO8lBil3TEuWTqjWGZTs1Gk1G68qOpGKAabdzmzATMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=R/C2yv+l; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="R/C2yv+l"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6ECD628719D;
	Fri, 30 Aug 2024 14:48:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1725022130;
	bh=jUhwG5R0qWnWJOpTzFrDht5qN55ooWMDoFdCvpBkkkg=;
	h=Date:From:To:Cc:Subject:From;
	b=R/C2yv+lXYWup8HEUUBUXbkonNWKHCIVBwAR1uLB9PLpjeicjEfzKisceowgQoNy1
	 VDZm+7P9WIi37ihBxdmPMMj2RwSxJv2olWzWfNefq+zEhwOaKC3IQQS/iZCvJpCJdt
	 crLPW5tQecE3cvkZV/K7gnfcU17qkKkYAB85Ozwwa2kTDhqABO9JvoeYr//egnaehK
	 uF38XzMoXs5LPoY7WH9hkPjvrKedEfsDdDqDkyXUvkSfmcwnmOaIWPi4+uj0PjHgZC
	 ALvn/Ns6RKO8Npsz/V1r/DP7JMbzF1pWSqY9X9U9PAvCnx4iZs1CJkz00Xl9XasrWm
	 9oW+jSAqkoSkA==
Date: Fri, 30 Aug 2024 14:48:49 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.11-rc5
Message-ID: <ZtG_sa5UUrAoYkKd@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7GN+MAVE67h3RWRK"
Content-Disposition: inline


--7GN+MAVE67h3RWRK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.11-rc5

for you to fetch changes up to 51eeef9a482bcb00f6f75eda4de9bd013092b76f:

  MAINTAINERS: Add Jean-Philippe as SMMUv3 SVA reviewer (2024-08-26 09:17:36 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.11-rc5

Including:

	- Fix a device-stall problem in bad io-page-fault setups (faults
	  received from devices with no supporting domain attached).

	- Context flush fix for Intel VT-d.

	- Do not allow non-read+non-write mapping through iommufd as most
	  implementations can not handle that.

	- Fix a possible infinite-loop issue in map_pages() path.

	- Add Jean-Philippe as reviewer for SMMUv3 SVA support

----------------------------------------------------------------
Jason Gunthorpe (2):
      iommufd: Do not allow creating areas without READ or WRITE
      iommu: Do not return 0 from map_pages if it doesn't do anything

Lu Baolu (1):
      iommu/vt-d: Fix incorrect domain ID in context flush helper

Pranjal Shrivastava (1):
      iommu: Handle iommu faults for a bad iopf setup

Will Deacon (1):
      MAINTAINERS: Add Jean-Philippe as SMMUv3 SVA reviewer

 MAINTAINERS                                 |   4 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   2 +-
 drivers/iommu/intel/iommu.c                 |   8 +-
 drivers/iommu/intel/iommu.h                 |   2 +-
 drivers/iommu/intel/pasid.c                 |   7 +-
 drivers/iommu/io-pgfault.c                  | 121 +++++++++++++++++++---------
 drivers/iommu/io-pgtable-arm-v7s.c          |   3 +-
 drivers/iommu/io-pgtable-arm.c              |   3 +-
 drivers/iommu/io-pgtable-dart.c             |   3 +-
 drivers/iommu/iommufd/ioas.c                |   8 ++
 include/linux/iommu.h                       |   5 +-
 tools/testing/selftests/iommu/iommufd.c     |   6 +-
 12 files changed, 116 insertions(+), 56 deletions(-)

Please pull.

Thanks,

	Joerg

--7GN+MAVE67h3RWRK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmbRv7EACgkQK/BELZcB
GuN4fg/+NoQ1blmYcWF59PAblVXqjulH33l7FjZERNVrLa0X5IBj7VC5HRebFm3O
8iiSrTs3zkYB4axrJWi6NzNpR+Yfiw29Rrvfjtha8b/zqRdF4YXAQYWcjKCu5EOa
NhFIMoFDTYW5pnQKS6fWXZZsroud0oCf6p63kfH/qcrTI4CK2Rxt7pxHWVX1JAxp
xNz9j1jcJ7NVZjGnrAbGOLAjrEJzvWUmnHCSpyANaArSWPPmCYXhkXI+qghGPKrx
KPGpT6u6p6LH60aENcs24Mw7vTi/3wf5MTbGaCM1y8Wxvsb/OiycnNb/hu55uZIY
uRb+TijEgycKvyaqkhqET7V96ku5loIcQPn7zzNwxQROR36KNfqrRz4Q7HU2ilQU
VNlqHLZ390PJqCcxvIvnaqB0A3JDoVqCTGvK199CLJLjyi3YqzwT00+4Tf++kcwj
NLrOPZphXXZpJ+lFi+x6PH9anKS07szY2lEsTqySqJG+GVreOOcMLtl/QbcbECFS
wQa9DYWVqZWKZfNfb5xthDsIFNm/W7YMVlcPUvkQ+EqSlUmWvwa8qYdSy9D4E36q
NEerK9rNyQFgyHaOjZmRnyRLlQylRUAHa64Iho4tktx/I6TOZpETzYnTkM6noI46
E+DYLkG6SjfSpcN4ZlqqyyrDhNIO+aJrG2dGi6UaZ/bbM2vk8D8=
=kdPw
-----END PGP SIGNATURE-----

--7GN+MAVE67h3RWRK--
