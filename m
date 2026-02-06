Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4A332ED3A
	for <iommu@lists.linux.dev>; Fri,  6 Feb 2026 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770378814; cv=none; b=KxWmdTWHY9khsbcvroEzP0kVbAMVe9OKhx4Qi//iFLRP+Y0o/nJP1c2muXa2tZrwlfKq2SBUxg0G2F2V5YdvnfzOm9kYL3GTCoskRub2SxttO2WwBv/nO86TslmP4Gag9IScZnAh1mhivgjmNfL4n1XbMd19Br5sn+VK4co0YZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770378814; c=relaxed/simple;
	bh=1GQAloioJH5GHKYZMm3wH6x/zPBThuZb8H5FzCo+RG8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=pKZnF7xaLFRqFzy257/EEpVLgiim0PR9zsQt2rHQwfS5jVMU4VLnUFy8qaz1pyuQaKjvF0XnWutg/UfZebIwmuWk2CqwyItryD51IlLEow84B7j+2Y1ZA1NrhwKlPh3ZNCsLckyVxvy7ZjyMyGiWr5LPORlGxTZiI/k1Gk9lMiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KrTzfUN+; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KrTzfUN+"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260206115325euoutp016148b7661535f0bbad517db4f4ed98b4~RpiTomiwq1454214542euoutp01Q
	for <iommu@lists.linux.dev>; Fri,  6 Feb 2026 11:53:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260206115325euoutp016148b7661535f0bbad517db4f4ed98b4~RpiTomiwq1454214542euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770378806;
	bh=NDi2MT8eDCq6+gCmNsV9BLUErb1OUeengVwmvhQ9FaY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=KrTzfUN+WiigFx8tca9OYz3pHgsDFYjUjiRt8nBdQ3L/EmfZpHr1h+jusOps9tlkR
	 Sc78w8EFnrJH07UQak+jShEZs6a8LGQrj/LTIaSamOro9yWhzB10cy7QgVlYXlrokz
	 krJAmohGsCOmdWkZVFF8Gzwt682o5YRY04FkfOQQ=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260206115325eucas1p10b41056830dfac249ffc9e1603de43da~RpiTUptEq0146401464eucas1p1R;
	Fri,  6 Feb 2026 11:53:25 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260206115325eusmtip29826b16d22fe9f60de23e8e32d33fd0a~RpiS5Ry4I1272112721eusmtip2R;
	Fri,  6 Feb 2026 11:53:25 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy
	<robin.murphy@arm.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [GIT PULL] more last minute dma-mapping fixes for Linux 6.19
Date: Fri,  6 Feb 2026 12:53:13 +0100
Message-Id: <20260206115313.3169749-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260206115325eucas1p10b41056830dfac249ffc9e1603de43da
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260206115325eucas1p10b41056830dfac249ffc9e1603de43da
X-EPHeader: CA
X-CMS-RootMailID: 20260206115325eucas1p10b41056830dfac249ffc9e1603de43da
References: <CGME20260206115325eucas1p10b41056830dfac249ffc9e1603de43da@eucas1p1.samsung.com>

The following changes since commit 56c430c7f06d838fe3b2077dbbc4cc0bf992312b:

  dma/pool: distinguish between missing and exhausted atomic pools (2026-01-29 10:23:45 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.19-2026-02-06

for you to fetch changes up to c33efdfcfa6f80e05ce1ee33694c1bad4994cd78:

  dma: contiguous: Check return value of dma_contiguous_reserve_area() (2026-02-02 09:20:32 +0100)

----------------------------------------------------------------
dma-mapping fixes for Linux 6.19

Two minor fixes for DMA-mapping subsystem:
- check for the rare case of the allocation failure of the global CMA pool
  (Shanker Donthineni)
- avoid perf buffer overflow when tracing large scatter-gather lists
  (Deepanshu Kartikey)

----------------------------------------------------------------
Deepanshu Kartikey (1):
      tracing/dma: Cap dma_map_sg tracepoint arrays to prevent buffer overflow

Shanker Donthineni (1):
      dma: contiguous: Check return value of dma_contiguous_reserve_area()

 include/trace/events/dma.h | 25 +++++++++++++++++++------
 kernel/dma/contiguous.c    | 10 ++++++----
 2 files changed, 25 insertions(+), 10 deletions(-)

----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
