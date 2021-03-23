Return-Path: <SRS0=ZOt4=IV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4D7C433C1
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 01:15:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 242656196E
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 01:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242656196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFB0D4037F;
	Tue, 23 Mar 2021 01:15:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 33_XlIZ1FYcS; Tue, 23 Mar 2021 01:15:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F44F403D0;
	Tue, 23 Mar 2021 01:15:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E5B9C000B;
	Tue, 23 Mar 2021 01:15:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACBC4C0001
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 01:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E8D360804
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 01:15:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4e9GZJ0H7-Qg for <iommu@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 01:15:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E0D0760674
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 01:15:38 +0000 (UTC)
IronPort-SDR: gc9ZrD8QTfbcMPpOO2K/2UKiKKh/KwCS6goZ5hxjt1bpLYNSn5L0782l+3JohUqrMCQnoD2I2I
 YX0CDpl3CdTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="275480158"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; d="scan'208";a="275480158"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 18:15:38 -0700
IronPort-SDR: Q87OuAXkhgcdd+fU4mrN4tjPyLcaJKrF6KE0p00WKXTA1Vl+BNXWLOt7SrWhXIVbE3aX20PE4A
 xPe9UI3L5tMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; d="scan'208";a="435362436"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 22 Mar 2021 18:15:36 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/5] iommu/vt-d: Remove unused dma map/unmap trace events
Date: Tue, 23 Mar 2021 09:05:56 +0800
Message-Id: <20210323010600.678627-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210323010600.678627-1-baolu.lu@linux.intel.com>
References: <20210323010600.678627-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
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
more. Cleanup them to make the code neat.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/trace/events/intel_iommu.h | 120 -----------------------------
 1 file changed, 120 deletions(-)

diff --git a/include/trace/events/intel_iommu.h b/include/trace/events/intel_iommu.h
index e801f4910522..d233f2916584 100644
--- a/include/trace/events/intel_iommu.h
+++ b/include/trace/events/intel_iommu.h
@@ -15,126 +15,6 @@
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
-
 TRACE_EVENT(qi_submit,
 	TP_PROTO(struct intel_iommu *iommu, u64 qw0, u64 qw1, u64 qw2, u64 qw3),
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
