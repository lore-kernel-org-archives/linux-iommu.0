Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250392CCC5
	for <iommu@lists.linux.dev>; Fri, 13 Feb 2026 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770993084; cv=none; b=Cz92tYRw/bAB5egDFly8DMBIyE67/hOpbEixcITYMxxdnIzc8+vw1REhIkZJXCdkXpV07I6RXC5nc6h68h5wYge1+ZLiJJBi32BSc42UjuaqHqtlJAYMNmEhn+eTwGB3xqF4awkfzG6QkyTffro0Xr3iIGoybfq3AV5xzlEizC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770993084; c=relaxed/simple;
	bh=wRPssIXONvZXJ6tu7oZTpx1Q0/DO4fZ1Pu5lzLEs7/M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=D/OPQMcu9JLDXsr0+qVj6mvQnVAhxnEH4HLeZg+fSPHxP3mlAKUORxpctvkhzJJ6Zzc3rAKug86dYi1yZ9poSl/faBtz0NQ+ArkktdFNSsVZ82+THxSiSDfAijdjYyaySuQIJu0lBmqBIDCK1AATfXLNrXLmAEdaWqSidWjK2oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ojawHcDN; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ojawHcDN"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260213143113euoutp014cae6007da574214486c012f0b90782b~T1NEbYwe_0563705637euoutp01Q
	for <iommu@lists.linux.dev>; Fri, 13 Feb 2026 14:31:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260213143113euoutp014cae6007da574214486c012f0b90782b~T1NEbYwe_0563705637euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770993073;
	bh=0S86NtJ4OSB5qhTsZGKxX+PwVhCZycm2aB8PbQOP/Lc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ojawHcDNjnREW5X80OvyhQASnQMkQHICRMDxaKM6Z2yvnvGWy/MGYdpt0XIUjPi73
	 jEJ9m7iDvlXG3Ta0ntXwImPkC8HLyp+7GUVVzBF5oeQBMhdrtxHKM8n0DVPeucPYEY
	 j/C3T3Sz2FjwpLfWsyxRgoj4dsa1Ou91g5LlZsZ8=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260213143112eucas1p150d4777d55a1e013b0e21d5ea7bae16c~T1ND-iSFz2592925929eucas1p1j;
	Fri, 13 Feb 2026 14:31:12 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260213143112eusmtip21084b9025670abe81075060493d5f8b7~T1NDtuEXo0047400474eusmtip2U;
	Fri, 13 Feb 2026 14:31:12 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
Subject: [GIT PULL] dma-mapping update for Linux 7.0
Date: Fri, 13 Feb 2026 15:31:04 +0100
Message-Id: <20260213143104.473529-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260213143112eucas1p150d4777d55a1e013b0e21d5ea7bae16c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260213143112eucas1p150d4777d55a1e013b0e21d5ea7bae16c
X-EPHeader: CA
X-CMS-RootMailID: 20260213143112eucas1p150d4777d55a1e013b0e21d5ea7bae16c
References: <CGME20260213143112eucas1p150d4777d55a1e013b0e21d5ea7bae16c@eucas1p1.samsung.com>

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.0-2026-02-13

for you to fetch changes up to 8a840ab0567ff2b7d382694ba24a58a893d2c7af:

  dma-mapping: Remove dma_mark_clean (again) (2026-01-08 00:19:08 +0100)

----------------------------------------------------------------
dma-mapping update for Linux 7.0

A small code cleanup for DMA-mapping subsystem:
- removal of unused hooks (Robin Murphy)

----------------------------------------------------------------
Robin Murphy (1):
      dma-mapping: Remove dma_mark_clean (again)

 include/linux/dma-map-ops.h | 8 --------
 kernel/dma/Kconfig          | 6 ------
 kernel/dma/direct.c         | 3 ---
 kernel/dma/direct.h         | 3 ---
 4 files changed, 20 deletions(-)

----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland


