Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9AE14EC4A
	for <iommu@lists.linux.dev>; Fri, 12 Apr 2024 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712945061; cv=none; b=F67RjIeZ9Lyq+VKPDGAne/TTpID9nfP4L6IX7KTlQoZ8VrTPz+iBMIkoXd4fyign17PBq3Nfc1jhwJB07jk5OMpxS+AC6wxjYqX/hjsXSIRVEV64sS44Tcb9wwBlIkX5ALE52KMoc98uzcqPxiKuw9Tgs8ffDkKFp6r3oAI2V3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712945061; c=relaxed/simple;
	bh=qwf4iTktdZ3kogIsYGsuqikgoOEh6G/surgwrdWnqNA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LobjUuNX/xxYk5u4D67ivAUove5ApYBFYjCBzMzQ513e+YBgRHDWfYbZi073SE+sKLt7+i6lwe99+qGyALcrNzSzlQpzKgT91Lp6FpLePpXTpxNB5Ti7MXeuF+Q6LFrlcrK2KiaQfAMqNWQtJ9nbF80JB/tq4Zc1igCiG9AEL2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=4oI3tdmo; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="4oI3tdmo"
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5714D1C2BD5;
	Fri, 12 Apr 2024 20:04:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1712945056;
	bh=qwf4iTktdZ3kogIsYGsuqikgoOEh6G/surgwrdWnqNA=;
	h=Date:From:To:Cc:Subject:From;
	b=4oI3tdmol21X4wV3WCicN0mxhTEtT7kSQrM7BeKLpwzStS4i8pWBoptmauGdrvyYt
	 K60C59/VG7bzlUyABLug7WGIeOPxm7CmA2mjbLOYJIpIvWjBV4bZnS2V1F2ppAHrMc
	 hxARtbEBWW5ew2fCtaEn0zO6422bEvMjUfSa7V+0oQ9zx2hKHV7IZnrXuoHRsWnb91
	 LX5TFCI5V0IhA6QKOAoqFclsimLn9Cm7nUtd6k3rsqWX/mzJgLYoeX8A8ANohaiTio
	 REc4mGIk1U7Zab9oNX5ytskgMUmgiPGHkWDkAFIyvRsAIzXYBBFNHaEOFCgVOCF7So
	 WPPSTzkcksdEA==
Date: Fri, 12 Apr 2024 20:04:15 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.9-rc3
Message-ID: <Zhl3n4fWSWswqzpr@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.9-rc3

for you to fetch changes up to b8246a2ad80a810cafbeddb30525278f9d64bca3:

  iommu/amd: Change log message severity (2024-04-12 12:21:46 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.9-rc3

Including:

	- Intel VT-d Fixes:
	  - Allocate local memory for PRQ page
	  - Fix WARN_ON in iommu probe path
	  - Fix wrong use of pasid config

	- AMD IOMMU Fixes:
	  - Lock inversion fix
	  - Log message severity fix
	  - Disable SNP when v2 page-tables are used

	- Mediatek driver:
	  - Fix module autoloading

----------------------------------------------------------------
Jacob Pan (1):
      iommu/vt-d: Allocate local memory for page request queue

Krzysztof Kozlowski (1):
      iommu: mtk: fix module autoloading

Lu Baolu (1):
      iommu/vt-d: Fix WARN_ON in iommu probe path

Vasant Hegde (3):
      iommu/amd: Fix possible irq lock inversion dependency issue
      iommu/amd: Do not enable SNP when V2 page table is enabled
      iommu/amd: Change log message severity

Xuchun Shang (1):
      iommu/vt-d: Fix wrong use of pasid config

 drivers/iommu/amd/init.c      | 25 +++++++++++++------------
 drivers/iommu/amd/iommu.c     | 11 +++++++----
 drivers/iommu/intel/iommu.c   | 11 +++++++----
 drivers/iommu/intel/perfmon.c |  2 +-
 drivers/iommu/intel/svm.c     |  2 +-
 drivers/iommu/mtk_iommu.c     |  1 +
 drivers/iommu/mtk_iommu_v1.c  |  1 +
 7 files changed, 31 insertions(+), 22 deletions(-)

Please pull.

Thanks,

	Joerg
