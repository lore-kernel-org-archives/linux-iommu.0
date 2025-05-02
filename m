Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677E0267387
	for <iommu@lists.linux.dev>; Fri,  2 May 2025 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746169694; cv=none; b=ULipcse8kg1ptYbVusPDQBlZQtUM0TjK4jxDUqK1aT39/qAqjXaCEePN8etv/99NEmnUNuLOwekGYj80eDLtT/fXvrSXwJNxo4iS8Xo+wwClikLg6z07xQFdtABFJ4adkA1kwZX3TNV0B4oOC8OJ+1Fgrby8mht97ESISkyFowQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746169694; c=relaxed/simple;
	bh=dVPtd0HJC42Ctt+/s1RrBttzRbeTmnHlGTKCx1r7qaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E9amgajXp3xJFS8QHOv+XX2wOsjE5hTRLJMr5hT7DeDMDpo2Q8SRGbh4OqKjEh4JTgiQI/POzB9efFkCYejYqaPBpWX3j+dqynZOxCzsHP1d+RzezckKLHKUOuSKQN0icK6pEC6cTiYuy1VFb97YJoROXgORlZSjIN7OOLqkvIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=N2VnUMaa; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="N2VnUMaa"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 214A447B79;
	Fri,  2 May 2025 09:08:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1746169690;
	bh=dVPtd0HJC42Ctt+/s1RrBttzRbeTmnHlGTKCx1r7qaQ=;
	h=Date:From:To:Cc:Subject:From;
	b=N2VnUMaaGLqNorC9HtA4E23zhSl8BcuavR4zYOkrtQm4LD6cRQ4R01ttltqwDAud/
	 IVbSp8Yo20uc0673yFNPMUJIlAgVoeP6Czl5MODboGUb1wdpQMuWkjfJcyhAeH4EnH
	 42WhJjFLh3tgwRpQCUNFJvBsVG5xLBoiqbkWutiZgspSydqFAV4x7ruXoPXJfMaWxc
	 aUtkfGnfUNfJLwr45+lXqEivYgn+BLGyFJErIdSZuV7VBPMtANxYRrMOZVWzpHKLoC
	 /F7pRPvtt6jHNCPp9HApzFLDe0smyLgl3bag8zlKcXpYuOxiFS6qCxf6iSyKfukTIR
	 k3NDA4bgaCgCw==
Date: Fri, 2 May 2025 09:08:08 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.15-rc2
Message-ID: <aBRvWCTS7c_j6CCa@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 8ffd015db85fea3e15a77027fda6c02ced4d2444:

  Linux 6.15-rc2 (2025-04-13 11:54:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.15-rc4

for you to fetch changes up to 2c8a7c66c90832432496616a9a3c07293f1364f3:

  iommu/vt-d: Apply quirk_iommu_igfx for 8086:0044 (QM57/QS57) (2025-04-28 13:00:58 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.15-rc4:

Including:

	* ARM-SMMU fixes:
	  - Fix broken detection of the S2FWB feature
	  - Ensure page-size bitmap is initialised for SVA domains
	  - Fix handling of SMMU client devices with duplicate Stream IDs
	  - Don't fail SMMU probe if Stream IDs are aliased across clients

	* Intel VT-d fixes:
	  - Add quirk for IGFX device
	  - Revert an ATS change to fix a boot failure

	* AMD IOMMU:
          - Fix potential buffer overflow

	* Core:
	  - Fix for iommu_copy_struct_from_user()

----------------------------------------------------------------
Aneesh Kumar K.V (Arm) (1):
      iommu/arm-smmu-v3: Add missing S2FWB feature detection

Balbir Singh (1):
      iommu/arm-smmu-v3: Fix pgsize_bit for sva domains

Lu Baolu (1):
      iommu/vt-d: Revert ATS timing change to fix boot failure

Mingcong Bai (1):
      iommu/vt-d: Apply quirk_iommu_igfx for 8086:0044 (QM57/QS57)

Nicolin Chen (2):
      iommu/arm-smmu-v3: Fix iommu_device_probe bug due to duplicated stream ids
      iommu: Fix two issues in iommu_copy_struct_from_user()

Pavel Paklov (1):
      iommu/amd: Fix potential buffer overflow in parse_ivrs_acpihid

Robin Murphy (1):
      iommu/arm-smmu-v3: Fail aliasing StreamIDs more gracefully

 drivers/iommu/amd/init.c                        |  8 ++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c |  6 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 23 ++++++++++++----
 drivers/iommu/intel/iommu.c                     | 35 ++++++++++++++++---------
 include/linux/iommu.h                           |  8 +++---
 5 files changed, 58 insertions(+), 22 deletions(-)

Please pull.

Thanks,

	Joerg
