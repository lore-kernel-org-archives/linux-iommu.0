From: Joerg Roedel <joro@8bytes.org>
Subject: Re: IO_PAGE_FAULTs on unity mapped regions during amd_iommu_init()
 in Linux 3.4
Date: Wed, 6 Feb 2013 13:12:23 +0100
Message-ID: <20130206121223.GT25591@8bytes.org>
References: <1359657210.6061.3.camel@lorien2>
 <20130201130035.GE25591@8bytes.org>
 <1359743519.2759.38.camel@lorien2>
 <20130205133104.GC2532@8bytes.org>
 <CAKocOOO6Z2LyLYiuQMWf4iv4PAP8h5jbNWxRcSXKgXD1es6GYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKocOOO6Z2LyLYiuQMWf4iv4PAP8h5jbNWxRcSXKgXD1es6GYg@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Shuah Khan <shuahkhan@gmail.com>
Cc: Shuah Khan <shuah.khan@hp.com>, LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 05, 2013 at 06:57:21AM -0700, Shuah Khan wrote:
> Thanks much. I will hang on to this test system for testing your fix.

Okay, here is the simple fix for v3.8-rc6. I guess it is not
straighforward to port it to v3.4, but it should be doable.

>From 2ecf57c85e67e0243b36b787d0490c0b47202ba8 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <joro@8bytes.org>
Date: Wed, 6 Feb 2013 12:55:23 +0100
Subject: [PATCH] iommu/amd: Initialize device table after dma_ops

When dma_ops are initialized the unity mappings are
created. The init_device_table_dma() function makes sure DMA
from all devices is blocked by default. This opens a short
window in time where DMA to unity mapped regions is blocked
by the IOMMU. Make sure this does not happen by initializing
the device table after dma_ops.

Signed-off-by: Joerg Roedel <joro@8bytes.org>
---
 drivers/iommu/amd_iommu_init.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index faf10ba..b6ecddb 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1876,11 +1876,6 @@ static int amd_iommu_init_dma(void)
 	struct amd_iommu *iommu;
 	int ret;
 
-	init_device_table_dma();
-
-	for_each_iommu(iommu)
-		iommu_flush_all_caches(iommu);
-
 	if (iommu_pass_through)
 		ret = amd_iommu_init_passthrough();
 	else
@@ -1889,6 +1884,11 @@ static int amd_iommu_init_dma(void)
 	if (ret)
 		return ret;
 
+	init_device_table_dma();
+
+	for_each_iommu(iommu)
+		iommu_flush_all_caches(iommu);
+
 	amd_iommu_init_api();
 
 	amd_iommu_init_notifier();
-- 
1.7.9.5
