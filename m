Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A47C433EF
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 02:37:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2BA80402EB;
	Tue, 10 May 2022 02:37:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0JMtwayitnrX; Tue, 10 May 2022 02:37:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 22ACD402E8;
	Tue, 10 May 2022 02:37:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 095B5C0039;
	Tue, 10 May 2022 02:37:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33F30C0081
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 02:37:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 238DF812FC
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 02:37:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JRbQfGp3KmQS for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 02:37:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 743ED80DD1
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 02:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652150239; x=1683686239;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8CzBF8SrgZWZ8q2C6C6iTy1/Md5+wq3DdKH30T++t58=;
 b=MlCuhzyWrRcEaTJiHdvb0hjz2bwNTdTqVkLpwHpL5WQtL0c15scwh2Iz
 u6GO52jBfe1Q+R0uTBCu/GfADWZ3FQjTb0jK4yFJjqvMZCrY29qq7ENyr
 ugvFRzrWP697zl6anA0Y3fwGLK0pjRghC4fVfQilZKlmpoPhra9khGJ1y
 qss6JkLAgSoABfJfotKkiemnZ8x8VncPH6FNrskvMRRRCrYrnKTFjyyYz
 bmQ8bq7ekiVUy5jkc/60vEQzITNYdjUi90owc8TCl2CEsfCQMrd+TJT2g
 jZd2hen4NNIpDtZ81UZvzrMzb64EB8TFzxwXyB8EgotH6JOwDpvVZRcqD Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="266825971"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="266825971"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2022 19:37:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="519523448"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga003.jf.intel.com with ESMTP; 09 May 2022 19:37:17 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 4/8] iommu/vt-d: Size Page Request Queue to avoid overflow
 condition
Date: Tue, 10 May 2022 10:34:03 +0800
Message-Id: <20220510023407.2759143-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510023407.2759143-1-baolu.lu@linux.intel.com>
References: <20220510023407.2759143-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
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

PRQ overflow may cause I/O throughput congestion, resulting in unnecessary
degradation of I/O performance. Appropriately increasing the length of PRQ
can greatly reduce the occurrence of PRQ overflow. The count of maximum
page requests that can be generated in parallel by a PCIe device is
statically defined in the Outstanding Page Request Capacity field of the
PCIe ATS configure space.

The new length of PRQ is calculated by summing up the value of Outstanding
Page Request Capacity register across all devices where Page Requests are
supported on the real PR-capable platform (Intel Sapphire Rapids). The
result is round to the nearest higher power of 2.

The PRQ length is also double sized as the VT-d IOMMU driver only updates
the Page Request Queue Head Register (PQH_REG) after processing the entire
queue.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20220421113558.3504874-1-baolu.lu@linux.intel.com
---
 include/linux/intel-svm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index b3b125b332aa..207ef06ba3e1 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -9,7 +9,7 @@
 #define __INTEL_SVM_H__
 
 /* Page Request Queue depth */
-#define PRQ_ORDER	2
+#define PRQ_ORDER	4
 #define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
 #define PRQ_DEPTH	((0x1000 << PRQ_ORDER) >> 5)
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
