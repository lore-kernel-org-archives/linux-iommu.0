Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D988B137923
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099283; cv=none; b=qB09twt364p/HsCgHsJoznH0dPyb56HdjNB91UOpf8agXdefFvRo6cam0ULS3RXxaja/n0avLiN5coxZfyV+nQz777Ln5UgZ7AC+5AMh0beS6ny5+S3/PhAqDvyrtxWrhKjeZoNHN4x1BdU4ifX7BuscI8KRNKW5onHPMPi1FjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099283; c=relaxed/simple;
	bh=0eBDIifa3Rc6TUg2+YZCwKxp5YnAYLScAdvr1S5CfNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=nQM5d1fbGcrqk3LIs5FrTgy0aFVboLr090B1gEESrnkG6m8BbZo40U5LyKfd8zBczAVhXFmC+kH5iIeuRbaSWw0yamVNZaU3c9ncQKBus1E3Rwq0bfd2rzHiHL07bZTa6fvRfwOOqmxA9myvLRJv9NnS0v28jbHTS+ih+/re/uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=da9maXVF; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="da9maXVF"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260807104118euoutp0186cfecd5151b2d3789c77073c7087a73~Jf9S4kUZN0508505085euoutp01b
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 10:41:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260807104118euoutp0186cfecd5151b2d3789c77073c7087a73~Jf9S4kUZN0508505085euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1786099278;
	bh=WbAr4gIKQ8VFDTTx5dEU5bi/CezDv7xK4IXYPCGCOmY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=da9maXVFQgXXGWrHdbd+KkGztUvXGXkiNIXtvHLnJmq0oc2HeBzul6AAmYlWfd9F2
	 SHujjrbKz/0XPRx7Kpb69nq5LEsoc96zmUvketINaHqpUIBdv1fk/5aTAlaieR49gG
	 Xa8wHflT98MLz2+lzBQk2YunXHMnZNc556GyR+4Q=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260807104118eucas1p1e2cfd69c7957d6ae79c4bdd51545a064~Jf9SfrN1B2102421024eucas1p1Z;
	Fri,  7 Aug 2026 10:41:18 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260807104118eusmtip2e3185c128ff943055f8acac7bc0436ad~Jf9SPBa9n2847228472eusmtip2v;
	Fri,  7 Aug 2026 10:41:18 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>
Subject: [PATCH] MAINTAINERS: update tree for DMA MAPPING HELPERS
Date: Fri,  7 Aug 2026 12:41:00 +0200
Message-ID: <20260807104101.737116-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260807104118eucas1p1e2cfd69c7957d6ae79c4bdd51545a064
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260807104118eucas1p1e2cfd69c7957d6ae79c4bdd51545a064
X-EPHeader: CA
X-CMS-RootMailID: 20260807104118eucas1p1e2cfd69c7957d6ae79c4bdd51545a064
References: <CGME20260807104118eucas1p1e2cfd69c7957d6ae79c4bdd51545a064@eucas1p1.samsung.com>

Update the git tree address to the proper one.

Reported-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 806bd2d80d15..b4b543ddca7e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7664,8 +7664,7 @@ M:	Marek Szyprowski <m.szyprowski@samsung.com>
 R:	Robin Murphy <robin.murphy@arm.com>
 L:	iommu@lists.linux.dev
 S:	Supported
-W:	http://git.infradead.org/users/hch/dma-mapping.git
-T:	git git://git.infradead.org/users/hch/dma-mapping.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git
 F:	include/asm-generic/dma-mapping.h
 F:	include/linux/dma-direct.h
 F:	include/linux/dma-map-ops.h
-- 
2.43.0

