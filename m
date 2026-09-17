Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DCB4A0EE8
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789637108; cv=none; b=Pmlz/HKWtw7RdqjjhWNn9JwPGBerC1DPnO5KoxmP5sryq9gd8KfutjLodTkoRhzaKlmLAndVzWVqcoIu55mDbgxPupVstsiKzubLSCpqY4GIvxWRcXXHi2w+4RYTEDxViLq5mfF/4PMefO2qpQo5mjuNHZ67mydgS3J/2CUdKY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789637108; c=relaxed/simple;
	bh=UjSFHajnMILZWxbmA5Zc/wuKB0wweyyY0bVfJnze0YU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=Yf0ez9GqD5qk2jeqgGh1WTphTQciXi2YNzL346t0hPgBGU8PcdG/l4coiP0Wis95USkxk1yrd1yiGMAlPvjl3YZT/UZbYiOOJ9GfZPUV+bGb4NK9VDMJk9zelQEl9l0AoqNSdTBNx0by1e/b1XCyGDuhTYq0WBw/bkEy1mn+1Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IRDofwK8; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IRDofwK8"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260917092456euoutp028601a095e90f8086755c3f65c6eb1449~WEXUvTW1q3122331223euoutp02l
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 09:24:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260917092456euoutp028601a095e90f8086755c3f65c6eb1449~WEXUvTW1q3122331223euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1789637096;
	bh=z7NFobjYfhJYbpAFEGtTimYkcpegeHRA1ijapWFH4zQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=IRDofwK8Y3UGSYQzYKV/RHkSmStHK8cg/tfU3Ju6AzVjBRdoSwByh+r/BPFEyAdMm
	 G+d7T19a2U3LsQb+aNHagX11JYPAX9TMuM8tvpedgMvOoeVWZQ2Zy2RQNjzqZ7uF3k
	 0biU/6MbYSQieV+coJFJaQvdpVBIPd+T2vX3cDNg=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260917092456eucas1p138229ed33c56428e9c0f2247245bad18~WEXUi_g3v2137821378eucas1p1z;
	Thu, 17 Sep 2026 09:24:56 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260917092455eusmtip1c7e28d52ddeab9ff3b1103116c3a2409~WEXTV1Ev_1342913429eusmtip1Y;
	Thu, 17 Sep 2026 09:24:55 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, "Aneesh
 Kumar K . V" <aneesh.kumar@kernel.org>, Donggeun Yoo
	<donggeunyoo.kernel@gmail.com>
Subject: [GIT PULL] dma-mapping fixes for Linux 7.3
Date: Thu, 17 Sep 2026 11:24:42 +0200
Message-ID: <20260917092443.342396-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260917092456eucas1p138229ed33c56428e9c0f2247245bad18
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260917092456eucas1p138229ed33c56428e9c0f2247245bad18
X-EPHeader: CA
X-CMS-RootMailID: 20260917092456eucas1p138229ed33c56428e9c0f2247245bad18
References: <CGME20260917092456eucas1p138229ed33c56428e9c0f2247245bad18@eucas1p1.samsung.com>

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.3-2026-09-17

for you to fetch changes up to 55a8e1451869233db837a97e8f3cbf9983bc8678:

  x86/mm: Don't force unencrypted DMA for IOMMU-backed devices (2026-09-11 10:30:50 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 7.3

A few fixes for the DMA-mapping code:
- resolved regression in accessing encrypted memory by IOMMU-backed
devices (Aneesh Kumar K.V),
- improved failure handling and removed rare bug in swiotlb/highmem
(Donggeun Yoo).

----------------------------------------------------------------
Aneesh Kumar K.V (Arm) (1):
      x86/mm: Don't force unencrypted DMA for IOMMU-backed devices

Donggeun Yoo (3):
      dma-coherent: report a failed reserved memory assignment
      swiotlb: use the adjusted address for the highmem page lookup
      dma-mapping: don't trace the DMA address when the allocation fails

 arch/x86/mm/mem_encrypt.c  | 3 ++-
 include/trace/events/dma.h | 2 +-
 kernel/dma/coherent.c      | 3 +--
 kernel/dma/swiotlb.c       | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland

