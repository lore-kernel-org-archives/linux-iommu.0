Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DEF15B151
	for <iommu@lists.linux.dev>; Fri,  7 Jun 2024 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717750283; cv=none; b=hFJI7d/HGT0/olOeLEnZ9Vg2wpMeqaixCWdD428bG/OAa+4xufnWnKSvhdQODiYANETykYYUvmVx7OOa8NpPSP7zm23itvmwt2wdXctzxkBtRa6ZfgqUkdYHzIraiTWZGV7ldXei+Huf0C9BglUXlo+mwMD45Xj3ghnEx2oMSzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717750283; c=relaxed/simple;
	bh=20qPAHxgHw2m0YF3MooU4EHuwN7JhQ7wiuoPVIhylLA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a2P2gFVXFTsB+K9Ttoe7atnI+D3Y9p+JsEJmCW8x2KnOxOD51ubG7lh+uT339q7tf7shWhZg9MLdD8f6wvKX76X5ZGXHWps7F1MuFExone6V5/8Vx3CgnKnBULAE/Y68OS1Mn4LBJ9MKH46HXhJLVI8OCSO1aPrR+bV96Wpd9HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=F2pzSoWj; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="F2pzSoWj"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 61B311C7D6A;
	Fri,  7 Jun 2024 10:51:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1717750275;
	bh=20qPAHxgHw2m0YF3MooU4EHuwN7JhQ7wiuoPVIhylLA=;
	h=Date:From:To:Cc:Subject:From;
	b=F2pzSoWjkIcu6FUPws3u9UC95Z9Ei8YVejgkOXIXsW6LWoxrUCgur/HVGLyduwNvu
	 CX53t/kYOoPHMKntfyPKA44ncpYdmXNFUQXoDgKiwAL+t4qHp3fbG8qP2PW/bDBaPz
	 PaUIR6ug+QjbcXOmVS9LvqFX/iBe4XmgLZzfaov+RCEAFdPH8rHRqcw8TC4yuVS+Bc
	 Ammy+F81XjFp4YkSL4OYNsZ0wyEklN9A/dJ+Zj6MpVPRLfEKrfDEeMaeAql11wW1Cb
	 bBI0K0xmQskX5lAnoA86kLTU26/cmarU+fSF3uvNqyPA4Xj4/Vdx6NPLUxndi3MkcK
	 NXOKYOIbKxUsg==
Date: Fri, 7 Jun 2024 10:51:14 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.10-rc2
Message-ID: <ZmLKAr7RYbL_wP3F@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.10-rc2

for you to fetch changes up to 526606b0a1998b0791b42c199d53550c3ba724b5:

  iommu/amd: Fix Invalid wait context issue (2024-06-04 14:00:59 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.10-rc2

Including:

	- Core:
	  - Make iommu-dma code recognize 'force_aperture' again
	  - Fix for potential NULL-ptr dereference from iommu_sva_bind_device()
	    return value

	- AMD IOMMU fixes:
	  - Fix lockdep splat for invalid wait context
	  - Add feature bit check before enabling PPR
	  - Make workqueue name fit into buffer
	  - Fix memory leak in sysfs code

----------------------------------------------------------------
Kun(llfl) (1):
      iommu/amd: Fix sysfs leak in iommu init

Lu Baolu (1):
      iommu: Return right value in iommu_sva_bind_device()

Robin Murphy (1):
      iommu/dma: Fix domain init

Vasant Hegde (3):
      iommu/amd: Fix workqueue name
      iommu/amd: Check EFR[EPHSup] bit before enabling PPR
      iommu/amd: Fix Invalid wait context issue

 drivers/iommu/amd/amd_iommu.h |  3 ++-
 drivers/iommu/amd/init.c      |  9 ++++++++
 drivers/iommu/amd/iommu.c     | 48 +++++++++++++++++++++----------------------
 drivers/iommu/amd/ppr.c       | 25 +++++-----------------
 drivers/iommu/dma-iommu.c     |  8 ++++----
 include/linux/iommu.h         |  2 +-
 6 files changed, 45 insertions(+), 50 deletions(-)

Please pull.

Thanks,

	Joerg
