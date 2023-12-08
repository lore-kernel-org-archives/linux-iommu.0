Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C945ABA2
	for <iommu@lists.linux.dev>; Fri,  8 Dec 2023 23:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="npwXHqnD"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-da3dd6a72a7so3468553276.0
        for <iommu@lists.linux.dev>; Fri, 08 Dec 2023 15:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702078911; x=1702683711; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k7GsY6GT/+tnbArErtPc1f6cs5/DzWiGNX1GnrooOm8=;
        b=npwXHqnDzOO2ax51hUYXAviBcd08UHhnwTfuakwu/mKO4g1AUuWMTaimTy9jNZjfvk
         R3P+TKgxEG37RkE7zAaNYvzT7C2P0HXLZhgex5/dyHkL8bCi6GyPT4UfGsUAPcu4A7HW
         kgtgxJAifE0lOpZh/cQmRv+KNcgEZBy1+XFiYKWisjY9+q/LhfTyGElfFFOpKczWAf4T
         pPccGvP7GpTAlzhK3O5beCTWuqYRWNWy7V4VckO6+DxX+qAABskjaavF1vv4nqqx3C1m
         cKr5q7Ydhv2hnlM9TA/Xf0g1Xf90k2dRKyc1KwTAqavW7wRATRRImL737FJPcCgdXwVe
         Rz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702078911; x=1702683711;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7GsY6GT/+tnbArErtPc1f6cs5/DzWiGNX1GnrooOm8=;
        b=jOuCBavvYVp5EXJwWjzeNDVXL3d3trcB3Zl9U47K8PjWOPvzRhWO+7rWeZ+kQxhcic
         3cUuABTKx+S0y2mGYlCvBRMm9uOescxXwfa4Jt167f3dBv/XSk5f/B5yrIa9KISRQyVE
         KLwgtHehEU2ZYBW8IubzGkKK4rtiDO9c//tDJzLfZtQwEinShc50A/XkmINcwF8nuVPn
         bz5VuDKVLRD+BXfQBzIUmWRo8N6L8hqtGWMdju8IdBKTr6TUKZUZkZafDSPMO/cdPStw
         nEAmi5/6KWx8JLY74WreiS5HTZ8laKgRA8tGALc7K6JauVTsGA4kMpfR3zR8S5oh35cc
         IYaw==
X-Gm-Message-State: AOJu0YyQb+UgeEDp7kpXphsosMA8wGJdHVTzKBESeChqoVB/HlKfjzL9
	0EkbIWeIykLLH7gY5BXUy3/6uvnG92wQToyCoNxCHg==
X-Google-Smtp-Source: AGHT+IHGOJeWukTVNuH3xvDlUiPgdeVPjjFBrpqw0bilGbylCV43u5Ik4f0j+Oum1gYfbgenTrdwcI2XwBEmlFpybrySNQ==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:4a64:6d71:c7b8:4fc3])
 (user=isaacmanjarres job=sendgmr) by 2002:a25:76c8:0:b0:db7:d315:6643 with
 SMTP id r191-20020a2576c8000000b00db7d3156643mr6416ybc.6.1702078911016; Fri,
 08 Dec 2023 15:41:51 -0800 (PST)
Date: Fri,  8 Dec 2023 15:41:40 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208234141.2356157-1-isaacmanjarres@google.com>
Subject: [PATCH v1] iommu/dma: Trace bounce buffer usage when mapping buffers
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Tom Murphy <murphyt7@tcd.ie>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: "Isaac J. Manjarres" <isaacmanjarres@google.com>, stable@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When commit 82612d66d51d ("iommu: Allow the dma-iommu api to
use bounce buffers") was introduced, it did not add the logic
for tracing the bounce buffer usage from iommu_dma_map_page().

All of the users of swiotlb_tbl_map_single() trace their bounce
buffer usage, except iommu_dma_map_page(). This makes it difficult
to track SWIOTLB usage from that function. Thus, trace bounce buffer
usage from iommu_dma_map_page().

Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
Cc: stable@vger.kernel.org # v5.15+
Cc: Tom Murphy <murphyt7@tcd.ie>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 drivers/iommu/dma-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 85163a83df2f..037fcf826407 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -29,6 +29,7 @@
 #include <linux/spinlock.h>
 #include <linux/swiotlb.h>
 #include <linux/vmalloc.h>
+#include <trace/events/swiotlb.h>
 
 #include "dma-iommu.h"
 
@@ -1156,6 +1157,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 			return DMA_MAPPING_ERROR;
 		}
 
+		trace_swiotlb_bounced(dev, phys, size);
+
 		aligned_size = iova_align(iovad, size);
 		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
 					      iova_mask(iovad), dir, attrs);
-- 
2.43.0.472.g3155946c3a-goog

