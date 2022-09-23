Received: from condef-04.nifty.com (condef-04.nifty.com [202.248.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D38433DC
	for <iommu@lists.linux.dev>; Fri, 23 Sep 2022 11:45:00 +0000 (UTC)
Received: from conuserg-11.nifty.com ([10.126.8.74])by condef-04.nifty.com with ESMTP id 28NBe5kk017336
	for <iommu@lists.linux.dev>; Fri, 23 Sep 2022 20:40:05 +0900
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
	by conuserg-11.nifty.com with ESMTP id 28NBcwoP004226;
	Fri, 23 Sep 2022 20:38:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 28NBcwoP004226
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
	s=dec2015msa; t=1663933139;
	bh=Yt8Aby4ly36BVNEWPbk9WBI59IV85gBnORw+4W2rqVo=;
	h=From:To:Cc:Subject:Date:From;
	b=NcT6g9KTYqYPootKtKfWve+R8Z3Zqj2PRUIuKx45H0ocXWxpxLV7aBZ1DXVxZvbmU
	 bXbRyfkaYFQ/ji2tAY0U8CN4jVhRN8mtxcEeLwB54QOLztoFLB3KpfMkobNWLc8K8+
	 gAFKw9NIG4c2vwLL58CHXqPkXjikyZv8q0Zkl2zaVChlcG/WXLKoXn3jliVnrHYhES
	 vW9SH+ubMZj/pSGRxmqCABoPnYn/vfT748gAGr15ae2QKO3YzDDsCBGHK3IwuOm/RM
	 pBXK+mZv2STHaS5aNsFqW8bVv7n5FXkjfEb52hRdr9DnjR5v/lRXS0h72bFXrC5oH5
	 oQBbbmfElbC4g==
X-Nifty-SrcIP: [133.32.182.133]
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lin <ming.l@ssi.samsung.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] lib/sg_pool: change module_init(sg_pool_init) to subsys_initcall
Date: Fri, 23 Sep 2022 20:38:35 +0900
Message-Id: <20220923113835.21544-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sg_alloc_table_chained() is called by several drivers, but if it is
called before sg_pool_init(), it results in a NULL pointer dereference
in sg_pool_alloc().

Since commit 9b1d6c895002 ("lib: scatterlist: move SG pool code from
SCSI driver to lib/sg_pool.c"), we rely on module_init(sg_pool_init)
is invoked before other module_init calls but this assumption is
fragile.

I slightly changed the link order while Kbuild refactoring Kbuild,
then uncovered this issue. I should keep the current link order, but
depending on a specific call order among module_init is so fragine.

We usually define the init order by specifying *_initcall correctly,
or delay the driver probing by returning -EPROBE_DEFER.

Change module_initcall() to subsys_initcall(), and also delete the
pointless module_exit() because lib/sg_pool.c is always compiled as
built-in. (CONFIG_SG_POOL is bool)

Link: https://lore.kernel.org/all/20220921043946.GA1355561@roeck-us.net/
Link: https://lore.kernel.org/all/8e70837d-d859-dfb2-bf7f-83f8b31467bc@samsung.com/
Fixes: 9b1d6c895002 ("lib: scatterlist: move SG pool code from SCSI driver to lib/sg_pool.c")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

I am sending this to DMA subsystem because I did not find
a corresponding one for lib/sg_pool.c

 lib/sg_pool.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/lib/sg_pool.c b/lib/sg_pool.c
index a0b1a52cd6f7..9bfe60ca3f37 100644
--- a/lib/sg_pool.c
+++ b/lib/sg_pool.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/scatterlist.h>
 #include <linux/mempool.h>
 #include <linux/slab.h>
@@ -177,16 +177,4 @@ static __init int sg_pool_init(void)
 	return -ENOMEM;
 }
 
-static __exit void sg_pool_exit(void)
-{
-	int i;
-
-	for (i = 0; i < SG_MEMPOOL_NR; i++) {
-		struct sg_pool *sgp = sg_pools + i;
-		mempool_destroy(sgp->pool);
-		kmem_cache_destroy(sgp->slab);
-	}
-}
-
-module_init(sg_pool_init);
-module_exit(sg_pool_exit);
+subsys_initcall(sg_pool_init);
-- 
2.34.1

