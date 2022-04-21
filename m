Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B8BC4332F
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 11:38:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B09F4610DC;
	Thu, 21 Apr 2022 11:38:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TJUhApJParld; Thu, 21 Apr 2022 11:38:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B09D460E2A;
	Thu, 21 Apr 2022 11:38:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 970F2C0033;
	Thu, 21 Apr 2022 11:38:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF671C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 11:38:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DDB0540B30
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 11:38:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ztshI7Az-R7L for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 11:38:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 503BE40B66
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 11:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650541131; x=1682077131;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TlJ1+MVmh4jBiR+OUjOQpWZePfw1j7kEuRwY1xJFAsk=;
 b=Jtf4JQyjLKDURaBJyxF1trWLqhaSkS8nWANhkEZygxiWJEcqlU3DnNOu
 wj8sgILxScmm43BnNUexyWxx4ARtXw2FE2PVSGH6SMcOyCplJtgrg8vfp
 C3m4LtSwqaLvop8RTxurTBjATrnEsbYsSbptdnUc83sW4lkWUjyugBQKU
 tk1Rw+wpJYYEL8Pd/q7frzsU0tQ5hf0FbsJp0eg9z7q4ulcZjdoYKjyXl
 +6JlIoVTqUgO9C5sYNS21X7dquuoQyiMMwDKs11Uk+YomvGwjXFjdPCbl
 9hEXQpwAUzbTpchsDQvtupaaEHg6AleY7GDqkeUo2UaUthFrg2+TsYL8v Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263790120"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; d="scan'208";a="263790120"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2022 04:38:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; d="scan'208";a="703047964"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2022 04:38:49 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jacob jun Pan <jacob.jun.pan@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>
Subject: [PATCH v2 4/4] iommu/vt-d: Size Page Request Queue to avoid overflow
 condition
Date: Thu, 21 Apr 2022 19:35:58 +0800
Message-Id: <20220421113558.3504874-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
References: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
