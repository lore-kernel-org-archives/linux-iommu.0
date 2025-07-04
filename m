Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBB743AA9
	for <iommu@lists.linux.dev>; Fri,  4 Jul 2025 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751638927; cv=none; b=qXYrWTgnz9vELJ/mDp+VqOGwE8Jm5R22eNfzs+k2ysVrT8/um1ta5w+PkTe4qWM0QiYVhqQJ9KEJNXEb6i/TnCeGotMp1tis14YrxrY1o9Uk6rkqJwLqoOvzqMMLfLIgJFpX5KO0gHtwdyDy94qUBVpSNd010kozvi7+U/78lTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751638927; c=relaxed/simple;
	bh=jrtPScFWrwuboc2zm+SeYv1viUAf7nzAIjYc4lhCf4k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ei+18zcbV11RcFpuO7H1k8Rq8xasxU3g5ZrSY1T7DyFlnDZUz1WaV8qS22fl4yiTJEHrraX9o0846zFE7L00jRymrYnsi8AM3ivAi2ifp6Ns5z7LS6XnrBy03gCBQlDEkpDEtxG2SEOZY4rpr7rm6l0qVMdUlOZ/aOSC2r61jbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=VIC53C+B; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="VIC53C+B"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3FD184FB67;
	Fri,  4 Jul 2025 16:22:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1751638924;
	bh=jrtPScFWrwuboc2zm+SeYv1viUAf7nzAIjYc4lhCf4k=;
	h=Date:From:To:Cc:Subject:From;
	b=VIC53C+BIDzZofbtj49beTWBfoDypTN2Ds35boibzZyDQZKlF8s9RhM+P+FbmR6Ih
	 57rlWe986Bh9wuH6+OlkOnkcqmmS82e5SfDgUjNwb8puQMV2eZgFD1ohSkwByNExTt
	 crr8hcJURW/KzYypJHgdEPPl97+fVg5br+QP3M2bnvFb/FhooyCFeL+cdELB43SfLV
	 Ra06nhbAkktx/kgDbE0ouJKkEFU9Qj79hXfTCp91QbhC0Vy8VrsJbTSOzlT99YFR11
	 vkZ157lBTcoW9cE/mU42+SBwH9pQhoS0JjaxDs+Qyax4yZhjD1XD9NiAqN41zIpgce
	 VM9gjYNU79KgQ==
Date: Fri, 4 Jul 2025 16:22:03 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.16-rc3
Message-ID: <aGfji8aafXu3hTQl@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 86731a2a651e58953fc949573895f2fa6d456841:

  Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.16-rc4

for you to fetch changes up to 25b1b75bbaf96331750fb01302825069657b2ff8:

  iommu/vt-d: Assign devtlb cache tag on ATS enablement (2025-07-04 10:33:56 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.16-rc4

Including:

	- Rockchip driver: Fix infinite loop caused by probing race condition.

	- Intel VT-d: Assign devtlb cache tag on ATS enablement

----------------------------------------------------------------
Lu Baolu (1):
      iommu/vt-d: Assign devtlb cache tag on ATS enablement

Simon Xue (1):
      iommu/rockchip: prevent iommus dead loop when two masters share one IOMMU

 drivers/iommu/intel/cache.c    |  5 ++---
 drivers/iommu/intel/iommu.c    | 11 ++++++++++-
 drivers/iommu/intel/iommu.h    |  2 ++
 drivers/iommu/rockchip-iommu.c |  3 ++-
 4 files changed, 16 insertions(+), 5 deletions(-)

Please pull.

Thanks,

	Joerg
