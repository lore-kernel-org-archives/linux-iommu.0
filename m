Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2D5221D9B
	for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521414; cv=none; b=mVoGggbLieTx3+k4xHRaIQmGTqKMzTJ3Q8d8qUSbn91bG069G52X+fgu+nzDiOpPrN3haXw3QmEwdnoWC976DXBJmdbl2YwyBafaz8fRlPnm2lFUXRKiQ1APnofskQwWPO8T4aWxX/sInX31u7NI4TCKQXo1YCiGSJ57CqsVxHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521414; c=relaxed/simple;
	bh=qvFBY/ul/T4cd0niS8APL8lRg56RjBde+ysVevfbY1s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X++SzTn80Jxav/RAqgB2jz5Vyxni5cO/6fxEYU97SJAzB9uV+I6L0C4siq+UTJnDAZMq6VZgn6d/b+jxTHlb4RkX/cpotL5wi+rvs/5ord78YUETbmXhOle9h2cSXFDs/IPtvypWFIPirnAA1EMzQlfDECX0ZflMyGOTJOTB+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=QEbj09st; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="QEbj09st"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 56414407D5;
	Fri, 14 Feb 2025 09:23:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1739521410;
	bh=qvFBY/ul/T4cd0niS8APL8lRg56RjBde+ysVevfbY1s=;
	h=Date:From:To:Cc:Subject:From;
	b=QEbj09sth7FN247L1gMpMmpgM05lJVqNEywWPiC7ssDawtxnvYRP7VJiTPEq99ujP
	 U0n29rGnVKHTw7sB8ShJSdAyM+do+S/n743vtTwqG57/OBPH7T+l/f7oUm4RmFpZr7
	 JlSiyJ92iZPqP/gOR82AzKP//gwE/q88iD4vhX2DQ92nO49nPhHjBD1gzyHyaMCvvF
	 hh7xp4pgHrn7m2/ZXYwp1yToo9lUmeFMlQeuRCCrRQl0Vcrd6nxAnPDjFQY/MUY5H2
	 9eNZwHvzX9JXGGdch8Jtj4J0D5pszEMp0W40lp8/3xQ8ps8B4pvqZVxVeYw6c+VpOk
	 KtIdDq5Dz6orQ==
Date: Fri, 14 Feb 2025 09:23:29 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.14-rc2
Message-ID: <Z679gV-O0JsPQNOb@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.14-rc2

for you to fetch changes up to add43c4fbc92f8b48c1acd64e953af3b1be4cd9c:

  iommu/vt-d: Make intel_iommu_drain_pasid_prq() cover faults for RID (2025-02-14 09:12:47 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.14-rc2

Including:

	- Core: Fix potential memory leak in iopf_queue_remove_device().

	- Intel VT-d: Handle faults correctly in
	  intel_iommu_drain_pasid_prq().

	- AMD-Vi: Fix faults happening in resume path.

	- Typo and spelling fixes.

----------------------------------------------------------------
Andrew Kreimer (1):
      iommu/exynos: Fix typos

Easwar Hariharan (1):
      iommu: Fix a spelling error

Lu Baolu (2):
      iommu: Fix potential memory leak in iopf_queue_remove_device()
      iommu/vt-d: Make intel_iommu_drain_pasid_prq() cover faults for RID

Vasant Hegde (1):
      iommu/amd: Expicitly enable CNTRL.EPHEn bit in resume path

 drivers/iommu/amd/amd_iommu_types.h | 1 +
 drivers/iommu/amd/init.c            | 4 ++++
 drivers/iommu/exynos-iommu.c        | 6 +++---
 drivers/iommu/intel/prq.c           | 4 +++-
 drivers/iommu/io-pgfault.c          | 1 +
 drivers/iommu/iommu.c               | 2 +-
 6 files changed, 13 insertions(+), 5 deletions(-)

Please pull.

Thanks,

	Joerg
