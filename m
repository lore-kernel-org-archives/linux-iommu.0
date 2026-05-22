Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA2F314B63
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779433591; cv=none; b=qiOuEm8/aN8qu8EV8uPsfU/qnbphtQlguA8Xrn8d0fA4Ywx9QyW/bVJYvAnLshUzdpZzEWzCll1+y/yG+TuJq0wp/rJ3I+K4BS1EEgXseVMThi1sS4cGcgu260PnW/MrWtl1adA+KVunCCVotOprXNSbQ2SLvJqT6zsfVYmYSgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779433591; c=relaxed/simple;
	bh=H+t6azva6e4IIaU0OURy1pcbKTXpR8GdhnrSYVOnwoM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=SxXDF0eWGpE/u4n0g3YBS8Y7zSICuXjjVVB6Le36siHgOoVkR4iarQBObtYxR8JEfO0Hge6Nw0oVLGwE+e2NgXGFkO/2s+aKEkHT4AKdcYBIrXVMA4BTgK6cImm11l8SVTh5vOg+W96jcP2xhui7bJyC97X5lFJ8h4JSyp73LzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EP49OgNs; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EP49OgNs"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260522070626euoutp012c2b2db2ee0142617ef8dca34c30ee96~x0Ws0u2Cr1524015240euoutp01h
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 07:06:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260522070626euoutp012c2b2db2ee0142617ef8dca34c30ee96~x0Ws0u2Cr1524015240euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1779433586;
	bh=akU6aqAt8RLoUq6kBvjFCj/KbpKl/pHK5g9a8hFhYK0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=EP49OgNsUK1ny8sX5bvgPMjBr1sVPt1W8nioMYWoBVla7pJnz0Sme7kcCVXeZl1XZ
	 w8U9xGUKCVs6topgaFgg/fZXlnQoIQkDQH3d/XlTCGItA8RFkBt574P5bc6oxaHqNC
	 k4dHAQH5rj/4dnAnoGmkG4B5NppvaKeaUNz8byXk=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260522070625eucas1p26fa2143e0dfc4c3e630ee98f29e1d22c~x0WsmNlTs3200332003eucas1p2K;
	Fri, 22 May 2026 07:06:25 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260522070625eusmtip26fee62c0679589eae2c889f311d12da3~x0WsN8RFU1924119241eusmtip2Q;
	Fri, 22 May 2026 07:06:25 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Jianpeng
	Chang <jianpeng.chang.cn@windriver.com>, Petr Tesarik <ptesarik@suse.com>
Subject: [GIT PULL] dma-mapping fixes for Linux 7.1
Date: Fri, 22 May 2026 09:05:07 +0200
Message-Id: <20260522070507.3385533-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260522070625eucas1p26fa2143e0dfc4c3e630ee98f29e1d22c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260522070625eucas1p26fa2143e0dfc4c3e630ee98f29e1d22c
X-EPHeader: CA
X-CMS-RootMailID: 20260522070625eucas1p26fa2143e0dfc4c3e630ee98f29e1d22c
References: <CGME20260522070625eucas1p26fa2143e0dfc4c3e630ee98f29e1d22c@eucas1p2.samsung.com>

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.1-2026-05-22

for you to fetch changes up to af0c3f05866237f7592219bfe05387bc3bfc99b5:

  dma-mapping: move dma_map_resource() sanity check into debug code (2026-05-18 09:04:59 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 7.1

Two minor updates for the DMA-mapping code, mainly fixing some rare
corner cases (Petr Tesarik, Jianpeng Chang).

----------------------------------------------------------------
Jianpeng Chang (1):
      dma-mapping: move dma_map_resource() sanity check into debug code

Petr Tesarik (1):
      dma-direct: fix use of max_pfn

 kernel/dma/debug.c   | 9 ++++++++-
 kernel/dma/direct.c  | 4 ++--
 kernel/dma/mapping.c | 4 ----
 3 files changed, 10 insertions(+), 7 deletions(-)

----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland

