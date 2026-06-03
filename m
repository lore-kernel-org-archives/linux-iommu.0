Received: from outbound.baidu.com (mx20.baidu.com [111.202.115.85])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 64EBE375F82
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 01:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780450670; cv=none; b=TriAZ4ggUcexJy2KfwCw5iJWGc/RL9nMuU4QnE8cOENqRIqhTrMsx18yyrvsCExGY8Y0mnYKU0DSrPflV+wQmzfpR6oy6F3L8fMIGhbc76YWqHOSbx/Hxjzr5HUhN7HEzjdSMlFGJvjOcuGenDoiIEDGPM87shbp/dJdZluPQMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780450670; c=relaxed/simple;
	bh=GlKSaNALoJniaO9z1TGvbDDoEpejm6dNppIoxw6vPjE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ocanR5Cp4ATL3Z+TAKeYRlAn+Wp9VVstwXUcyNi9SwKcNgmYfs0z4ZfI4IV+ZVki5vdMcZ8Bf+6rLWQ5mB3g77d0KbrrQfNv9cNBwYzBv8gukKLYiPKolyjFGA6RI3buN49jUDx9lgJ6il4qJRRNqm8sQbnjzq0Do88qb3k+nFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=iZTVfIoR; arc=none smtp.client-ip=111.202.115.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="iZTVfIoR"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Lu Baolu <baolu.lu@linux.intel.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe
	<logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <hch@lst.de>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] dma-mapping: direct: fix missing mapping for THRU_HOST_BRIDGE segments
Date: Wed, 3 Jun 2026 09:37:23 +0800
Message-ID: <20260603013723.2439-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc4.internal.baidu.com (172.31.3.14) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1780450655;
	bh=ZGT8wnI3bkA2YrrA6V5djWcDogcM9eQrQorZGg40Tvk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=iZTVfIoRABgW3arzisjQeUuz4awiZ9PvyUL91wvdDo+/uxJyMB6Rw+f85e9vZe2g6
	 BfjVtz+Vc/1oX84RlRXZ8fYdw+ecSFmXt2n5Z1Gqni8WmKvwH9obn3LpnpUH7R3gbE
	 RR1ySVqdf93T3GMpR4pmDeBVjow8cFld/Vy73LI6HTENarT+qDoPVgag7FZgWWIjKj
	 +g5oai1kmRcM4A3HTf3bjXPS6O5zH4T23/ugPZzJLhnqNCk5DsBXP/75B3Ad0Rw0o1
	 aGB+jG/mpujZuZdXuvZkQeBVv3hpZxedrZLKe3TO7N9e9AyCx9A+a8vrzxO5LvDLg5
	 xgcXIoF8wumYg==

From: Li RongQing <lirongqing@baidu.com>

In dma_direct_map_sg(), the case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE
incorrectly used 'break' instead of falling through to MAP_NONE.
As a result, segments traversing the host bridge skipped the required
dma_direct_map_phys() call entirely, leaving sg->dma_address
uninitialized and leading to DMA failures. Fix this by using
'fallthrough;'.

Fixes: a25e7962db0d79 ("PCI/P2PDMA: Refactor the p2pdma mapping helpers")
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 kernel/dma/direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 583c592..4391b79 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -476,7 +476,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 			 * must be mapped with CPU physical address and not PCI
 			 * bus addresses.
 			 */
-			break;
+			fallthrough;
 		case PCI_P2PDMA_MAP_NONE:
 			need_sync = true;
 			sg->dma_address = dma_direct_map_phys(dev, sg_phys(sg),
-- 
2.9.4

