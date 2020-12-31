Return-Path: <SRS0=YAC4=GD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B847BC433E0
	for <iommu@archiver.kernel.org>; Thu, 31 Dec 2020 01:01:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B8D21973
	for <iommu@archiver.kernel.org>; Thu, 31 Dec 2020 01:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B8D21973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0A17E86A01;
	Thu, 31 Dec 2020 01:01:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xr6p0MNZvRte; Thu, 31 Dec 2020 01:01:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 06E9A86A00;
	Thu, 31 Dec 2020 01:01:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCACAC088B;
	Thu, 31 Dec 2020 01:01:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B746C013A
 for <iommu@lists.linux-foundation.org>; Thu, 31 Dec 2020 01:01:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5AD7A2E0EC
 for <iommu@lists.linux-foundation.org>; Thu, 31 Dec 2020 01:01:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p+PzvpSr7hkv for <iommu@lists.linux-foundation.org>;
 Thu, 31 Dec 2020 01:01:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 0810C2036B
 for <iommu@lists.linux-foundation.org>; Thu, 31 Dec 2020 01:01:27 +0000 (UTC)
IronPort-SDR: VrhWXqFzCwzvc/SuPUI7dTTAqQtaKIRDiYtoMLhauJMxl8An2s4460nikrkFOgWCg3vV+x9Uqw
 oKCy2jQNn9ug==
X-IronPort-AV: E=McAfee;i="6000,8403,9850"; a="176754121"
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; d="scan'208";a="176754121"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Dec 2020 17:01:27 -0800
IronPort-SDR: V+LVHnOUFLusyl8gaHp7GxPAxgaZpx2PmwWTBWOwirBWJCXIaRMiWplzxvvzZbOXFCV0ASI7YL
 /rSlwEg5v4Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; d="scan'208";a="460676233"
Received: from allen-box.sh.intel.com ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 30 Dec 2020 17:01:25 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 3/5] iommu/vt-d: Remove unused dma map/unmap trace events
Date: Thu, 31 Dec 2020 08:53:21 +0800
Message-Id: <20201231005323.2178523-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
References: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Guo Kaijie <Kaijie.Guo@intel.com>
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

With commit c588072bba6b5 ("iommu/vt-d: Convert intel iommu driver to
the iommu ops"), the trace events for dma map/unmap have no users any
more. Remove them so that they don't show up under
/sys/kernel/debug/tracing/events/intel_iommu. The users should use the
map/unmap traces defined in the iommu core from now on.

Fixes: c588072bba6b5 ("iommu/vt-d: Convert intel iommu driver to the iommu ops")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/trace/events/intel_iommu.h | 119 -----------------------------
 1 file changed, 119 deletions(-)

diff --git a/include/trace/events/intel_iommu.h b/include/trace/events/intel_iommu.h
index 112bd06487bf..31c74202d8c3 100644
--- a/include/trace/events/intel_iommu.h
+++ b/include/trace/events/intel_iommu.h
@@ -16,125 +16,6 @@
 #include <linux/tracepoint.h>
 #include <linux/intel-iommu.h>
 
-DECLARE_EVENT_CLASS(dma_map,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, phys_addr_t phys_addr,
-		 size_t size),
-
-	TP_ARGS(dev, dev_addr, phys_addr, size),
-
-	TP_STRUCT__entry(
-		__string(dev_name, dev_name(dev))
-		__field(dma_addr_t, dev_addr)
-		__field(phys_addr_t, phys_addr)
-		__field(size_t,	size)
-	),
-
-	TP_fast_assign(
-		__assign_str(dev_name, dev_name(dev));
-		__entry->dev_addr = dev_addr;
-		__entry->phys_addr = phys_addr;
-		__entry->size = size;
-	),
-
-	TP_printk("dev=%s dev_addr=0x%llx phys_addr=0x%llx size=%zu",
-		  __get_str(dev_name),
-		  (unsigned long long)__entry->dev_addr,
-		  (unsigned long long)__entry->phys_addr,
-		  __entry->size)
-);
-
-DEFINE_EVENT(dma_map, map_single,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, phys_addr_t phys_addr,
-		 size_t size),
-	TP_ARGS(dev, dev_addr, phys_addr, size)
-);
-
-DEFINE_EVENT(dma_map, bounce_map_single,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, phys_addr_t phys_addr,
-		 size_t size),
-	TP_ARGS(dev, dev_addr, phys_addr, size)
-);
-
-DECLARE_EVENT_CLASS(dma_unmap,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, size_t size),
-
-	TP_ARGS(dev, dev_addr, size),
-
-	TP_STRUCT__entry(
-		__string(dev_name, dev_name(dev))
-		__field(dma_addr_t, dev_addr)
-		__field(size_t,	size)
-	),
-
-	TP_fast_assign(
-		__assign_str(dev_name, dev_name(dev));
-		__entry->dev_addr = dev_addr;
-		__entry->size = size;
-	),
-
-	TP_printk("dev=%s dev_addr=0x%llx size=%zu",
-		  __get_str(dev_name),
-		  (unsigned long long)__entry->dev_addr,
-		  __entry->size)
-);
-
-DEFINE_EVENT(dma_unmap, unmap_single,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, size_t size),
-	TP_ARGS(dev, dev_addr, size)
-);
-
-DEFINE_EVENT(dma_unmap, unmap_sg,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, size_t size),
-	TP_ARGS(dev, dev_addr, size)
-);
-
-DEFINE_EVENT(dma_unmap, bounce_unmap_single,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, size_t size),
-	TP_ARGS(dev, dev_addr, size)
-);
-
-DECLARE_EVENT_CLASS(dma_map_sg,
-	TP_PROTO(struct device *dev, int index, int total,
-		 struct scatterlist *sg),
-
-	TP_ARGS(dev, index, total, sg),
-
-	TP_STRUCT__entry(
-		__string(dev_name, dev_name(dev))
-		__field(dma_addr_t, dev_addr)
-		__field(phys_addr_t, phys_addr)
-		__field(size_t,	size)
-		__field(int, index)
-		__field(int, total)
-	),
-
-	TP_fast_assign(
-		__assign_str(dev_name, dev_name(dev));
-		__entry->dev_addr = sg->dma_address;
-		__entry->phys_addr = sg_phys(sg);
-		__entry->size = sg->dma_length;
-		__entry->index = index;
-		__entry->total = total;
-	),
-
-	TP_printk("dev=%s [%d/%d] dev_addr=0x%llx phys_addr=0x%llx size=%zu",
-		  __get_str(dev_name), __entry->index, __entry->total,
-		  (unsigned long long)__entry->dev_addr,
-		  (unsigned long long)__entry->phys_addr,
-		  __entry->size)
-);
-
-DEFINE_EVENT(dma_map_sg, map_sg,
-	TP_PROTO(struct device *dev, int index, int total,
-		 struct scatterlist *sg),
-	TP_ARGS(dev, index, total, sg)
-);
-
-DEFINE_EVENT(dma_map_sg, bounce_map_sg,
-	TP_PROTO(struct device *dev, int index, int total,
-		 struct scatterlist *sg),
-	TP_ARGS(dev, index, total, sg)
-);
 #endif /* _TRACE_INTEL_IOMMU_H */
 
 /* This part must be outside protection */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
