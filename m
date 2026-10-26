Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008483;
	b=KGbGeIJsu/teRYMR7cqm54lZxLmx9savb2CcungCKr1+0me4dT5MKDVzFm1YwdXdm8Xm
	 KyOcHzOSmZpQhiJ1xTHQSZfqFCdNlySG6/rL/HmCxzRSau3ef1gKvi/fjsTUkEbam7yzR
	 ZUf2wbNqzC88DKkUQIZYPWGTw6c/s3j/wIdhxkTmJr7lQBlcSbe2ec2GOJsRvS2aip9sG
	 d1bgaq6xpXuX2r9apqDDr/IYJ419XHqMfuGJmYeZ8M2YeV/fpJwR10SBda8dvD3pHuD2g
	 TODH2TsFgZEPs6exysjG9e8A6gRzyRNbysDNJQ7Sd+yyIXElrpuSDMRh0tgIDSmSNRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008483;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=Tn3WPWRDtplxSPLBkF+EHw8TVMrWKj86jyrvVJfM21s=;
	b=2M0MTC0a6t04fupfh1aW040jQhap70rUgFW29tmRPvI8yiouJhEbo0tXOisFui8/ghHV
	 roZ4220W/KBEnAs2MUm9TbbAUM//HSv0eVoCPrmQgeBwL3drY5S081VDMoIfyCCo3Qc20
	 +RIkE30ys8Rl+cwO/HL0NOxe5enm2pWYA9qmYwzZgWkm7ONhVz6B0RYZ/oxmbMcA+kwn6
	 KB3gvzvKq5XPK42Cpr8pjLBXWO+0t9Z2Kbia5CtRw0I9RSM4hx2vdZNVG0TQyTYTMALut
	 qcrzuDZitDsiCD7RQ8S02K8HkcoD/OIxCIL/PHsVlaNoNvbuQyHgMPKbjZcjsjuY4kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=OT6hWMA0;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD5460A263C
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 09:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CD5460A263C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=OT6hWMA0
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261026095435euoutp0150d3b842057e48bce28a62d6b7e7a156~iC7VbB6o80332303323euoutp01C
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 09:54:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261026095435euoutp0150d3b842057e48bce28a62d6b7e7a156~iC7VbB6o80332303323euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793008475;
	bh=Tn3WPWRDtplxSPLBkF+EHw8TVMrWKj86jyrvVJfM21s=;
	h=From:To:Cc:Subject:Date:References:From;
	b=OT6hWMA0PR+hYodPYaTZm1bOeXXaHVOEKyNP+bqOzxyqP2/l0qsu5h5HbdqUlPVgV
	 Wns79yyo2k09hhOo0s5SVhFxupDD8bxEgAbRVbo5u1CwVpP87eVWJw8eD0wlTDwUGk
	 fxPdGXZ6j2A2VGwMAFEuO7R5f63+ipgNWAeGCThs=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261026095434eucas1p29408e916eda327a5e9c83f64b0df4e66~iC7Uzd3642924429244eucas1p2T;
	Mon, 26 Oct 2026 09:54:34 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261026095433eusmtip28961b4577144cb7ec6d636562a432549~iC7USR5f_1096710967eusmtip2O;
	Mon, 26 Oct 2026 09:54:33 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Konrad
	Rzeszutek Wilk <konrad.wilk@oracle.com>, Claire Chang
	<tientzu@chromium.org>, Petr Tesarik <petr.tesarik.ext@huawei.com>, Nicolas
	Saenz Julienne <nsaenz@kernel.org>, Christoph Hellwig <hch@lst.de>, Lucas
	Stach <l.stach@pengutronix.de>
Subject: [PATCH 0/5] dma-mapping: assorted sashiko.dev fixes
Date: Mon, 26 Oct 2026 10:54:11 +0100
Message-ID: <20261026095423.966856-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261026095434eucas1p29408e916eda327a5e9c83f64b0df4e66
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261026095434eucas1p29408e916eda327a5e9c83f64b0df4e66
X-EPHeader: CA
X-CMS-RootMailID: 20261026095434eucas1p29408e916eda327a5e9c83f64b0df4e66
References: <CGME20261026095434eucas1p29408e916eda327a5e9c83f64b0df4e66@eucas1p2.samsung.com>

Hi,

This series collects fixes for the DMA-mapping code, developed while
analyzing issues reported by the sashiko.dev automated review. All
patches were prepared with LLM assistance and then reviewed manually.

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland


Marek Szyprowski (5):
  dma-coherent: serialize reserved memory pool initialization
  dma: swiotlb: Serialize restricted DMA pool initialization
  dma: swiotlb: Remove default pool from the pools list on exit
  dma-pool: release CMA pages on atomic_pool_expand() error path
  dma-direct: zero memory allocated with DMA_ATTR_NO_KERNEL_MAPPING

 kernel/dma/coherent.c | 11 ++++++++++-
 kernel/dma/direct.c   |  3 ++-
 kernel/dma/pool.c     |  3 ++-
 kernel/dma/swiotlb.c  | 15 +++++++++++++--
 4 files changed, 27 insertions(+), 5 deletions(-)

-- 
2.43.0

