Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4673B27E2
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931443; cv=none; b=G5IO/fCk+5CHU9Ezuu1t4z2YIGEI8KbCwhAjfifuW73mFG3WhjwJ9pM54Tq6snpBsmrY93KDFcI/B6zJps9GLp55CAxQjCyDszz0HATvlWMSjQstwCWEwLsbqarlBeSMti8au3xrUM98Bi6nsw75FvYSamlbUxE1NORJDHGW02M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931443; c=relaxed/simple;
	bh=BhDaZ5ofqLj5EaXq+grO1RXiDvxV7NdoYqZjSJpr2FI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=knLxBXBfAMIKdPHEsaLuBW0mfG7kSLVJmGclIpi8DjTr8/167lzDXHisxBWd2YSFpuTKkGnGtRR6GqxyjHkNTZHuUlcEfH5wDNTEnElqstktu0+CVRNcoQPOIJ/ED36Cn6SW/6Bmav+X4ExR9qY3VoFm93J+kIk4JCjai2/P6UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rPf0W7Ge; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rPf0W7Ge"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260713083037euoutp01d19fec9c3a86ff3949b6985999e6c571~BzDDGbked1424914249euoutp01N
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 08:30:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260713083037euoutp01d19fec9c3a86ff3949b6985999e6c571~BzDDGbked1424914249euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783931437;
	bh=tSEnyoeZeCmm9rrNAJXZuLiMu3RK4kvQqjfvvBqS4sE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=rPf0W7GewGfvuVlUYSCVIlI/eY9KU4tOcGjCeGfbPSj2rJQtvDEKqygWcpgcjy2su
	 GwTrdaAn9u9KQNquNN145xGQLPn4pH+K5kXiXY3RrR0JE+FeKpcNYxMEv6UX2VXuQH
	 1ZD4UkvylRNBvo2npd9eGdh0ShiCOj/5z8xz1XB4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260713083036eucas1p12b33a500ff4fef0b5d8db94f694bdb24~BzDCtXpXs0739107391eucas1p1U;
	Mon, 13 Jul 2026 08:30:36 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260713083034eusmtip13f17e87195e6ef434acc0b043a2f8235~BzDApTpRY2440424404eusmtip1H;
	Mon, 13 Jul 2026 08:30:34 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Leon Romanovsky
	<leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Lu Baolu
	<baolu.lu@linux.intel.com>, Luis Chamberlain <mcgrof@kernel.org>, Bjorn
	Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
	Christoph Hellwig <hch@lst.de>, Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] dma-direct: Improve readability of the dma_direct_map_sg()
 for P2PDMA case
Date: Mon, 13 Jul 2026 10:30:22 +0200
Message-Id: <20260713083022.1110993-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260713083036eucas1p12b33a500ff4fef0b5d8db94f694bdb24
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260713083036eucas1p12b33a500ff4fef0b5d8db94f694bdb24
X-EPHeader: CA
X-CMS-RootMailID: 20260713083036eucas1p12b33a500ff4fef0b5d8db94f694bdb24
References: <CGME20260713083036eucas1p12b33a500ff4fef0b5d8db94f694bdb24@eucas1p1.samsung.com>

Improve readability of the sg_dma_len assignment in the P2PDMA cases by
removing duplicated code, which was a direct result of the d0d08f4bd7f6
("dma-direct: Fix missing sg_dma_len assignment in P2PDMA bus mappings")
fix. No functional change.

Suggested-by: Leon Romanovsky <leon@kernel.org>
Link: https://lore.kernel.org/all/20260604071856.GA245424@unreal/
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 kernel/dma/direct.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4391b797d4db..d8219efe3273 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -486,15 +486,14 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 				goto out_unmap;
 			}
 			break;
 		case PCI_P2PDMA_MAP_BUS_ADDR:
 			sg->dma_address = pci_p2pdma_bus_addr_map(
 				p2pdma_state.mem, sg_phys(sg));
-			sg_dma_len(sg) = sg->length;
 			sg_dma_mark_bus_address(sg);
-			continue;
+			break;
 		default:
 			ret = -EREMOTEIO;
 			goto out_unmap;
 		}
 		sg_dma_len(sg) = sg->length;
 	}
-- 
2.34.1

