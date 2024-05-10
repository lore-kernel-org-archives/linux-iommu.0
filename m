Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61914168AF6
	for <iommu@lists.linux.dev>; Fri, 10 May 2024 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715338238; cv=none; b=E2udX7sbI5CGW1b38rVO3ttOR/pqWob+oeHsMnXA9xxF5HFozhl8Q1PnMOqgIpaIr4iOGgthsxrJlIhs1YeMt45ij9OohU+VeuxpX6eYyNRYF1evRTpIjh2i6Gi1a7/AW8O5oUb4A9b0YFbaMGWV5wLxGbtyA8lkY6OQRCgSzKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715338238; c=relaxed/simple;
	bh=r97e7uhR/Kfrrnx7lqzxjaL+lDzyA1QpoWxvjKLPYF0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CMFTrTLdz0Me2xZSVhNg3z/oYg5ivnUG5qrn98YWeej4H4RrPdjUvfhy0U3QbySo2chLNdwka7tFO8/KvZAy2QoeLjiyHpo348jW0EJcKsHbrSdX7S/UZIq5R84Z9TXGOyIIreNBYzTWVXTFAv/VYPN1Zra9CbUUdeL7OionwQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=aAjLnxGq; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="aAjLnxGq"
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 06AB01C45FB;
	Fri, 10 May 2024 12:50:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1715338235;
	bh=r97e7uhR/Kfrrnx7lqzxjaL+lDzyA1QpoWxvjKLPYF0=;
	h=Date:From:To:Cc:Subject:From;
	b=aAjLnxGq+JXzDWHlJB9shqiehp03uSY9q3D8F8gK4B5p2ahV4D7Z5DZeOwwtD5OYI
	 0gsc8bXrPkhUnvJr35U2HHmsV9Br2P2KJ82yVcJcgJcGFQjc1UGXp30++FD+PFfI8V
	 PzSdQQLvuU6Tr9RnqJiKuTdmGrSz3JprQH1Ozp/tj7YAqQml7pU1krbiu7FvcQI3kU
	 29bJefUbzE8TVp0nRKh5pGm4eKFYUMecD2J/Kx0DRwqhGpUl5kjw6sFd6HTLB+qYR/
	 Il3q6sR7CjDkjv2WH79bIrBebVEHLy5OWrGQmAftUDW4Qkszp1+YX2ONssyp+K9wJ9
	 JTFnMKon274Yg==
Date: Fri, 10 May 2024 12:50:33 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.9-rc5
Message-ID: <Zj37-X8iMR81fNZa@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit ed30a4a51bb196781c8058073ea720133a65596f:

  Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.9-rc7

for you to fetch changes up to 65ade5653f5ab5a21635e51d0c65e95f490f5b6f:

  iommu/arm-smmu: Use the correct type in nvidia_smmu_context_fault() (2024-05-10 09:09:55 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.9-rc7:

Including:

	- Fix offset miscalculation on ARM-SMMU driver

	- AMD IOMMU fix for initializing state of untrusted devices

----------------------------------------------------------------
Jason Gunthorpe (1):
      iommu/arm-smmu: Use the correct type in nvidia_smmu_context_fault()

Vasant Hegde (1):
      iommu/amd: Enhance def_domain_type to handle untrusted device

 drivers/iommu/amd/iommu.c                    | 4 ++++
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 4 +---
 2 files changed, 5 insertions(+), 3 deletions(-)

Please pull.

Thanks,

	Joerg
