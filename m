Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D54C433FE
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 02:03:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2FA5A4051A;
	Tue,  1 Mar 2022 02:03:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JQbkyQQasY39; Tue,  1 Mar 2022 02:03:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B03434060E;
	Tue,  1 Mar 2022 02:03:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98E7EC0077;
	Tue,  1 Mar 2022 02:03:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17C11C001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:03:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0755680CC8
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:03:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dBpm0C-mK23K for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 02:03:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3621A80C36
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646100234; x=1677636234;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gL3oQDwtBLRmRwl0QSjLUO7tI+N802MRFLIzNfSikss=;
 b=jv4D+ACIRe7beV6VHe2GEaeYfRwpTOYuw54bgYF1cX/K77FCal0+DLTB
 rcSMPcdBX7hwot1JkdGwPhAHlY/Eb9mIhkAbwSy+GJ+jnBx1T4ZfUb8Fx
 kSUwDVHnSO6jNPFvQwG7Gt0Q0iGR5gqNk6Zui2+JMRDVaHXyd6KDkRpnY
 vZVQDtkuG7JlsQO1R2W8xe0ioWscF0jufi/w20tyOFiEdPrgmKfCgZHWx
 zEFRN1IMNpwkdq7cu1g6Aze15ZgwAvNflhAQzrQIvZHbU0S+H4rNEpGNz
 JUP7MP8xaYE4r79depprvFgRGcgfInMY1aw5VKHvokJ90vLs50C8xvXbp g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="339468464"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; d="scan'208";a="339468464"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2022 18:03:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; d="scan'208";a="685551179"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2022 18:03:52 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 06/12] iommu/vt-d: Remove unnecessary includes
Date: Tue,  1 Mar 2022 10:01:53 +0800
Message-Id: <20220301020159.633356-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301020159.633356-1-baolu.lu@linux.intel.com>
References: <20220301020159.633356-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: YueHaibing <yuehaibing@huawei.com>, Marco Bonelli <marco@mebeim.net>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Remove unnecessary include files and sort the remaining alphabetically.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20220214025704.3184654-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c109d12cab0d..be3dbc89df06 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -13,38 +13,18 @@
 #define pr_fmt(fmt)     "DMAR: " fmt
 #define dev_fmt(fmt)    pr_fmt(fmt)
 
-#include <linux/init.h>
-#include <linux/bitmap.h>
-#include <linux/debugfs.h>
-#include <linux/export.h>
-#include <linux/slab.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <linux/spinlock.h>
-#include <linux/pci.h>
-#include <linux/dmar.h>
-#include <linux/dma-map-ops.h>
-#include <linux/mempool.h>
-#include <linux/memory.h>
-#include <linux/cpu.h>
-#include <linux/timer.h>
-#include <linux/io.h>
-#include <linux/iova.h>
-#include <linux/iommu.h>
+#include <linux/crash_dump.h>
+#include <linux/dma-direct.h>
 #include <linux/dma-iommu.h>
+#include <linux/dmi.h>
 #include <linux/intel-iommu.h>
 #include <linux/intel-svm.h>
+#include <linux/memory.h>
+#include <linux/pci.h>
+#include <linux/pci-ats.h>
+#include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
 #include <linux/tboot.h>
-#include <linux/dmi.h>
-#include <linux/pci-ats.h>
-#include <linux/memblock.h>
-#include <linux/dma-direct.h>
-#include <linux/crash_dump.h>
-#include <linux/numa.h>
-#include <asm/irq_remapping.h>
-#include <asm/cacheflush.h>
-#include <asm/iommu.h>
 
 #include "../irq_remapping.h"
 #include "../iommu-sva-lib.h"
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
