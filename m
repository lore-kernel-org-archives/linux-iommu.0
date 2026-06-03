Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 8C2D7256C61
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490256; cv=none; b=pbfSQl1CkADZhQpR86A+JmiM+vxPDNpWZT4Qot7SkSfUo+dUDhoSYD3BVTaRaElJSWLu5e0zyg1whsUQhBCU7FgPk3XWzpAyL+X7bHnS7rWBW+LeDzxpSRJL0lQCKhVSrFXpIkEF2dBpkXyYCjg2wM8Y4MOV26I7wBpLe+RJ/Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490256; c=relaxed/simple;
	bh=0k5kDVvurdS1UKmVo+ocFhWYYqixsfFXZJP3H1tHw+E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c6yThmEDSu9ERbNVx1oGkNoM5S+Ty1sICvH1PfElBEX5n7qoPTwzVwXzxv6f087vzxi44BEZfwnlxs0SDF9DTM4MvANws6el3FUEHFNf4mE8R/P6Mt7KqoqlmRhRixlXb4bXJFNHElwGS9pbFi/aVlQvznOHYe2Rqu55bYL6H84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=Rc+LXHE3; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="Rc+LXHE3"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] dma-debug: fix physical address retrieval in debug_dma_sync_sg_for_device
Date: Wed, 3 Jun 2026 20:37:08 +0800
Message-ID: <20260603123708.1665-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc7.internal.baidu.com (172.31.50.51) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1780490241;
	bh=/QlEyzqlrCJcbiK9131mSLXFyLatpetDI9hu0ko7ZMM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=Rc+LXHE3JKL+VkErKY1D/0EJnt0Etz4TAPQSnje5o4bmrl2mhZuTa3Q97GxsYgdkl
	 3EWStgg9NYJ83KAS1rP+cWqN7i91eYyWKvc+Bp8YXES6Q46tjkt4oOPJbfxBZuTuDV
	 bDnWZvOD4vL0g65C07GPUH1qKijbQvdxg4r0KSGO2YtSso9HS6rKraF9kcLMOSgFJ9
	 U9l5v8EZivm+pX1IPG3WG6bR2ZIUSdVndRPRDfIBoUU8m5IhFAl2hlN+DkFY1qmobT
	 Ut8CtYTnax4AMk+LqWUJcXl0s+AQ23U7ihhlnaZCdgzTEet84WBgXbczeqWs4v/b4s
	 GZa5O/VjRyKtg==

From: Li RongQing <lirongqing@baidu.com>

In debug_dma_sync_sg_for_device(), when iterating over a scatterlist,
the debug entry population mistakenly uses the head of the scatterlist
'sg' to fetch the physical address via sg_phys(), instead of using the
current iterator variable 's'.

This causes dma-debug to track the physical address of the very first
scatterlist entry for all subsequent entries in the list.

Fix this by passing the correct loop iterator 's' to sg_phys()

Fixes: 9d4f645a1fd49ee ("dma-debug: store a phys_addr_t in struct dma_debug_entry")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 kernel/dma/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 3248f8b..2c0e2cd 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1556,7 +1556,7 @@ void debug_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 		struct dma_debug_entry ref = {
 			.type           = dma_debug_sg,
 			.dev            = dev,
-			.paddr		= sg_phys(sg),
+			.paddr		= sg_phys(s),
 			.dev_addr       = sg_dma_address(s),
 			.size           = sg_dma_len(s),
 			.direction      = direction,
-- 
2.9.4

