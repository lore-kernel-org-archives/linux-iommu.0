Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E7F42052
	for <iommu@lists.linux.dev>; Thu, 28 Mar 2024 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613905; cv=none; b=h7FIDSQOG9+8dxAead+pxYA2sJA5SmDLB4i6ZcJK+xy7LddyYB7abJKHOw1O+P3t7ncPcRcGhY+6mnKDgpdotNHPvZglMgGIXqjSVdPMszgno/Y5JULhSPIYV9k7P6+EHqsAvYZwheJ2pFpvErVUZ0V1h3vuQhJ9rOMGG0XgUCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613905; c=relaxed/simple;
	bh=E4W+r8TfulGjSmOA1LdOpEM8S3uPAlvCQu3lib2TuNg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WOZXCBUtHZ4xTzCgf909wH4CeW9r2I7bzSoj0kkWFHv3oJMfYiacWNxeS5JbZFcjvmNEb/weSaWx1FVfIdDSD1dO4Yoj+VpCMD4yA/bMtXUsEZvZuFUlM5sXx6nh9lV5n8IpPkERSgCXoqKDIQlRBwXvUXDNXzQ3BmA17q0okkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=IG34/QgP; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="IG34/QgP"
Received: from 8bytes.org (p4ffe1eea.dip0.t-ipconnect.de [79.254.30.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 72C052810A1;
	Thu, 28 Mar 2024 09:18:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1711613900;
	bh=E4W+r8TfulGjSmOA1LdOpEM8S3uPAlvCQu3lib2TuNg=;
	h=Date:From:To:Cc:Subject:From;
	b=IG34/QgPa0IP27cm2dZWuDmVArq8mQEmiYfzGlXQSoE7lXXjo0DbqMEt6I7ehsHTD
	 OGFwyrG/zwdXb0hjZF7LaiAVJ8wnJt+hMHF4bx4zGuUwWL33m/3Rg9e48Put9IMxXA
	 wsuSJyr3lxUfFX/gLJ5njoD7FlvvBkqZslYCH1CI1HkKyWJdubvX8egmW4UhAPl+mY
	 kHuhb/A08lp61uK69qzR/WNwyd0vt3HEqivK07uS8C3pE3w0PuDvZFPbXsQuIHWXSS
	 x+IWE9E5d45p/BVid6sq+C1vMTEsINWLuWl/xzvn7mfsfcHLI+TbUtoRPDi6n+ZXWt
	 TbvONu6RgVXdQ==
Date: Thu, 28 Mar 2024 09:18:18 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.9-rc1
Message-ID: <ZgUnyqosVrEtULhz@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.9-rc1

for you to fetch changes up to c404f55c26fc23c70a9f2262f3f36a69fc46289b:

  iommu: Validate the PASID in iommu_attach_device_pasid() (2024-03-28 06:38:40 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.9-rc1:

Including:

	- ARM SMMU fixes:

	  - Fix swabbing of the STE fields in the unlikely event of
	    running on a big-endian machine.
	  - Fix setting of STE.SHCFG on hardware that doesn't implement
	    support for attribute overrides.

	- IOMMU core:

	  - PASID validation fix in device attach path

----------------------------------------------------------------
Jason Gunthorpe (2):
      iommu/arm-smmu-v3: Add cpu_to_le64() around STRTAB_STE_0_V
      iommu: Validate the PASID in iommu_attach_device_pasid()

Joerg Roedel (1):
      Merge tag 'arm-smmu-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into iommu/fixes

Mostafa Saleh (1):
      iommu/arm-smmu-v3: Fix access for STE.SHCFG

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 38 +++++++++++++++++++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
 drivers/iommu/iommu.c                       | 11 ++++++++-
 3 files changed, 37 insertions(+), 14 deletions(-)

Please pull.

Thanks,

	Joerg
