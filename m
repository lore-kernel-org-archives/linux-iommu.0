Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11E4C433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 02:58:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B20E40323;
	Mon, 14 Feb 2022 02:58:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uhL6RgD1RBSj; Mon, 14 Feb 2022 02:58:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 69900402B8;
	Mon, 14 Feb 2022 02:58:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 451A6C001A;
	Mon, 14 Feb 2022 02:58:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C54FC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 02:58:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7BAA840469
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 02:58:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K-OKdH6z9XJs for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 02:58:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF2384048F
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 02:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644807532; x=1676343532;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VfnNiH0iyPcpYrZNt/OHwIGhAD5IQG518T5a6b0/BPU=;
 b=E2+KSTbfs/+lFim55V7AgqbZjgGzROcoLVxxycGZY7eD0I7rd9qai8cE
 NrXslQTgmV/cPaMrwS3VjIzJjvqEVXAV4+hIHVjT2aVIHcgv4z23wTMDJ
 QsaH9POzMpc+B45NTDO1s3VLdjh8PbHi105e7gGsv+ZFYxln+9VZw3EIA
 ilLTalEGtA5FdD+5Oujg5Lw6+k+imm3bLwBrcLiAbsywbEbYqI/Zubdki
 RfcbMyiNYpHncRWgZZ52mX9463JZm3lQYnbg09slUTaN89wT1SokoGVrA
 tzyW25VsV4CAFE4exPYQTMeyiJJZSAfpxMCUZi3iq8jSZ9tfjN4/rY3j8 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="230637530"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; d="scan'208";a="230637530"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2022 18:58:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; d="scan'208";a="501514991"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga002.jf.intel.com with ESMTP; 13 Feb 2022 18:58:49 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 06/11] iommu/vt-d: Remove unnecessary includes
Date: Mon, 14 Feb 2022 10:56:59 +0800
Message-Id: <20220214025704.3184654-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
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
---
 drivers/iommu/intel/iommu.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d9965e72d9a8..b6a6fea8525d 100644
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
