Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6D530DD2C
	for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769780689; cv=none; b=tA3rXJ12NwuIaRbnaV61jFmqNpjEHjgZFl9oYVquivBssVLJ8w2/q4zIV+EpWHtXazxzgTd/P2uvR/gEvHvSD/N8QOI7utKW3F6rub2soEeZtlhnWx+ga3yrKMoQQW+LWICs06uN+CT4ZwBw1Air2Vd4lNjOkivm/o7IaJP6WOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769780689; c=relaxed/simple;
	bh=zq0enudfxYyZO8ReGjAlm3eJCI6Ktkd2wS+QbgkoBU8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=uoVeG4C9AJKpJVdymvVAID8xzv2coECttdF3SSPZRcp8zZ5uKu/91ZiodErEKy0qfrOc/IrYW5IzHMw3S3uXocGam00WgpOSlbmNGqwINE+PWj5NY2jxOnMPBujj/wxfRr+nbD5yPPIDwnAToHWr32AarAEUbsruAoXsWdhMVyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GSKZCtcI; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GSKZCtcI"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260130134440euoutp017b34f8868754127550d0f1db1682508a~Phib4FwAb0748807488euoutp01K
	for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 13:44:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260130134440euoutp017b34f8868754127550d0f1db1682508a~Phib4FwAb0748807488euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769780680;
	bh=vx9SJEm9ZQavuNcFk5P+ricBJ9M19+QPA1hZKRLrRao=;
	h=From:To:Cc:Subject:Date:References:From;
	b=GSKZCtcIFzgxKPEp11l/6/h5vtG844OQW0kknUidAIHNgIMW4Vo2hRbLS9ZjB6+gl
	 mh5o8SD6fmeWuJ9ad9NlvxCYfR4wlcDpOCpkCNBNZ19gIIPJO4RHqNx5ghvocd/Hf8
	 0bM9jT9O4EAsSq8z6aPdAZP0+qTTPDDMflMmadss=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260130134440eucas1p1e639225c498d3f6668f2f198860a9900~PhibqW5AR1914819148eucas1p1U;
	Fri, 30 Jan 2026 13:44:40 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260130134439eusmtip163f762a4ea7d513896c9ef08c930b4f3~PhibR0BUb0817008170eusmtip1R;
	Fri, 30 Jan 2026 13:44:39 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy
	<robin.murphy@arm.com>, Sai Sree Kartheek Adivi <s-adivi@ti.com>, Oreoluwa
	Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
Subject: [GIT PULL] last minute dma-mapping fixes for Linux 6.19
Date: Fri, 30 Jan 2026 14:34:45 +0100
Message-Id: <20260130133445.2069751-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260130134440eucas1p1e639225c498d3f6668f2f198860a9900
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260130134440eucas1p1e639225c498d3f6668f2f198860a9900
X-EPHeader: CA
X-CMS-RootMailID: 20260130134440eucas1p1e639225c498d3f6668f2f198860a9900
References: <CGME20260130134440eucas1p1e639225c498d3f6668f2f198860a9900@eucas1p1.samsung.com>

The following changes since commit c6ccd098807483762ccd726e1498bac5a71d0005:

  dma/pool: Avoid allocating redundant pools (2026-01-14 11:00:00 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.19-2026-01-30

for you to fetch changes up to 56c430c7f06d838fe3b2077dbbc4cc0bf992312b:

  dma/pool: distinguish between missing and exhausted atomic pools (2026-01-29 10:23:45 +0100)

----------------------------------------------------------------
dma-mapping fixes for Linux 6.19

- important fix for ARM 32-bit based systems using cma= kernel parameter
  (Oreoluwa Babatunde)
- a fix for the corner case of the DMA atomic pool based allocations
  (Sai Sree Kartheek Adivi)

----------------------------------------------------------------
Oreoluwa Babatunde (1):
      of: reserved_mem: Allow reserved_mem framework detect "cma=" kernel param

Sai Sree Kartheek Adivi (1):
      dma/pool: distinguish between missing and exhausted atomic pools

 drivers/of/of_reserved_mem.c | 19 +++++++++++++++++--
 include/linux/cma.h          |  9 +++++++++
 kernel/dma/contiguous.c      | 16 ++++++++++------
 kernel/dma/pool.c            |  7 ++++++-
 4 files changed, 42 insertions(+), 9 deletions(-)

----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland


