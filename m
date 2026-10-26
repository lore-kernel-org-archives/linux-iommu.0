Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008479;
	b=wXgicjcZ38kx+Y3P/YL/5G1UiDLk+2+j7jj/07E5pJ2sevSXIZEVB9Nut+oQWVCwAcqp
	 9TVJ0K5rDF2FU0+AAdK0cOeXbUldZE2RfM+kQ95EMeRVg9wTBOX2r+GpGV2xeoBtcBtu4
	 RgHXzM/P9SxgP1cnSQbtBTfgJv75H2/4CW5I6AoRuFhaoD2k/ZTKjH7nxMCNKjomwzLNu
	 mxNy1rt1j20pXaRT8izkbSQ0GhAlDxSIkYKnCp1xZ6gym5SbY8wCtvAuJusLlvTz+nK/B
	 sXA1zOn3oy0TaVNikCe+3dZMHY9TFBBeksZKB4kQzK1ypfGWJYb/6JwdrU675VjfrMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008479;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=O9ZW72vGNIXpuYB+A7o7sjHW3/ldWrvVKixSt1FU3Go=;
	b=o0jZ7vt3/sgYBW2amgjwgF9c28r7XEt0PtG8XC5IQcHKfyVMCCvHG08POFKZ1QizSlCU
	 litWgtuAtBZllAOvq08qaWQpIdzB6F6a3014glHMwbT2VvURZEemXHvd6WGGVA35q6KIl
	 XRyKZ3bauVvlyDZymhPF/4iTJiOhvQLSGtKv48fxl9xLIMckAD4DdhYACyaa/NeSP3zcZ
	 dSLEALRJO/BP4lh2H02kmiQAK9i2eZnKx8udkl5+2gFgDZpcERI5lloU195kO0FKG8p4p
	 h5dwNIaoDQoZsgWukv6cmFErUZVPW5w4oWJ7brAu2WgJSfgaYDcpqemzP/S8hR+aD9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Smvre56S;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B5E606A333
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 09:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6B5E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Smvre56S
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261026095435euoutp029c9aa78afbe9457f2c494d3927f8b373~iC7VkYd3d0960309603euoutp021
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 09:54:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261026095435euoutp029c9aa78afbe9457f2c494d3927f8b373~iC7VkYd3d0960309603euoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793008475;
	bh=O9ZW72vGNIXpuYB+A7o7sjHW3/ldWrvVKixSt1FU3Go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Smvre56SQAoyPDsig0nJhtBl+QEw8gSA80Ej1RF0m4urSG6lW4gmf6H8xPn11fKxP
	 4HGkSZn2v+OetzJ05KLu7UKTZwR7S/CtdsBkr1ZPeUFSRJJB0x+pO2Yc8d6nOGGGO/
	 tY9RVb75U8vhBfZ6+LBrOJGGLneeO8XyEdfEqdbY=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261026095434eucas1p1bb0ac7f1e94bcac196fdc97a0f2c9e9f~iC7VMknpd1650516505eucas1p1i;
	Mon, 26 Oct 2026 09:54:34 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261026095434eusmtip20edbf2321e17be51c7de2200921a3515~iC7U408zR1096710967eusmtip2P;
	Mon, 26 Oct 2026 09:54:34 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] dma-coherent: serialize reserved memory pool
 initialization
Date: Mon, 26 Oct 2026 10:54:12 +0100
Message-ID: <20261026095423.966856-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026095423.966856-1-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261026095434eucas1p1bb0ac7f1e94bcac196fdc97a0f2c9e9f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261026095434eucas1p1bb0ac7f1e94bcac196fdc97a0f2c9e9f
X-EPHeader: CA
X-CMS-RootMailID: 20261026095434eucas1p1bb0ac7f1e94bcac196fdc97a0f2c9e9f
References: <20261026095423.966856-1-m.szyprowski@samsung.com>
	<CGME20261026095434eucas1p1bb0ac7f1e94bcac196fdc97a0f2c9e9f@eucas1p1.samsung.com>

Multiple devices can share the same "shared-dma-pool" reserved memory
region, in which case the dma_coherent_mem structure is created by the
first device attached to it and stored in rmem->priv. To avoid the
potential race, serialize the check and initialization of rmem->priv
with a mutex.

Fixes: 7bfa5ab6fa1b ("drivers: dma-coherent: add initialization from device tree")
Cc: stable@vger.kernel.org
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 kernel/dma/coherent.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 4d0266893bcc..ac62b6bd3d0d 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/dma-direct.h>
 #include <linux/dma-map-ops.h>
 
@@ -335,10 +336,18 @@ static phys_addr_t dma_reserved_default_memory_base __initdata;
 static phys_addr_t dma_reserved_default_memory_size __initdata;
 #endif
 
+static DEFINE_MUTEX(rmem_dma_mutex);
+
 static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 {
-	struct dma_coherent_mem *mem = rmem->priv;
+	struct dma_coherent_mem *mem;
 
+	/*
+	 * Multiple devices can share the same pool and may be probed
+	 * concurrently, so serialize the initialization of rmem->priv.
+	 */
+	guard(mutex)(&rmem_dma_mutex);
+	mem = rmem->priv;
 	if (!mem) {
 		mem = dma_init_coherent_memory(rmem->base, rmem->base,
 					       rmem->size, true);
-- 
2.43.0

