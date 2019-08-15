Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D420C3A59C
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 20:10:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 297CF2086C
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 20:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297CF2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4A9441244;
	Thu, 15 Aug 2019 20:09:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B288E1201
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 20:09:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 423AB8A8
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 20:09:44 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	15 Aug 2019 13:09:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; d="scan'208";a="188596204"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
	by orsmga002.jf.intel.com with ESMTP; 15 Aug 2019 13:09:42 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v5 03/19] trace/iommu: Add sva trace events
Date: Thu, 15 Aug 2019 13:13:09 -0700
Message-Id: <1565900005-62508-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565900005-62508-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1565900005-62508-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Jonathan Cameron <jic23@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

For development only, trace I/O page faults and responses.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
[JPB: removed the invalidate trace event, that will be added later]
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/trace/events/iommu.h | 84 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/include/trace/events/iommu.h b/include/trace/events/iommu.h
index 72b4582..767b92c 100644
--- a/include/trace/events/iommu.h
+++ b/include/trace/events/iommu.h
@@ -12,6 +12,8 @@
 #define _TRACE_IOMMU_H
 
 #include <linux/tracepoint.h>
+#include <linux/iommu.h>
+#include <uapi/linux/iommu.h>
 
 struct device;
 
@@ -161,6 +163,88 @@ DEFINE_EVENT(iommu_error, io_page_fault,
 
 	TP_ARGS(dev, iova, flags)
 );
+
+TRACE_EVENT(dev_fault,
+
+	TP_PROTO(struct device *dev,  struct iommu_fault *evt),
+
+	TP_ARGS(dev, evt),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__field(int, type)
+		__field(int, reason)
+		__field(u64, addr)
+		__field(u64, fetch_addr)
+		__field(u32, pasid)
+		__field(u32, grpid)
+		__field(u32, flags)
+		__field(u32, prot)
+	),
+
+	TP_fast_assign(
+		__assign_str(device, dev_name(dev));
+		__entry->type = evt->type;
+		if (evt->type == IOMMU_FAULT_DMA_UNRECOV) {
+			__entry->reason		= evt->event.reason;
+			__entry->flags		= evt->event.flags;
+			__entry->pasid		= evt->event.pasid;
+			__entry->grpid		= 0;
+			__entry->prot		= evt->event.perm;
+			__entry->addr		= evt->event.addr;
+			__entry->fetch_addr	= evt->event.fetch_addr;
+		} else {
+			__entry->reason		= 0;
+			__entry->flags		= evt->prm.flags;
+			__entry->pasid		= evt->prm.pasid;
+			__entry->grpid		= evt->prm.grpid;
+			__entry->prot		= evt->prm.perm;
+			__entry->addr		= evt->prm.addr;
+			__entry->fetch_addr	= 0;
+		}
+	),
+
+	TP_printk("IOMMU:%s type=%d reason=%d addr=0x%016llx fetch=0x%016llx pasid=%d group=%d flags=%x prot=%d",
+		__get_str(device),
+		__entry->type,
+		__entry->reason,
+		__entry->addr,
+		__entry->fetch_addr,
+		__entry->pasid,
+		__entry->grpid,
+		__entry->flags,
+		__entry->prot
+	)
+);
+
+TRACE_EVENT(dev_page_response,
+
+	TP_PROTO(struct device *dev,  struct iommu_fault_page_response *msg),
+
+	TP_ARGS(dev, msg),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__field(int, code)
+		__field(u32, pasid)
+		__field(u32, grpid)
+	),
+
+	TP_fast_assign(
+		__assign_str(device, dev_name(dev));
+		__entry->code = msg->code;
+		__entry->pasid = msg->pasid;
+		__entry->grpid = msg->grpid;
+	),
+
+	TP_printk("IOMMU:%s code=%d pasid=%d group=%d",
+		__get_str(device),
+		__entry->code,
+		__entry->pasid,
+		__entry->grpid
+	)
+);
+
 #endif /* _TRACE_IOMMU_H */
 
 /* This part must be outside protection */
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
