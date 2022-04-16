Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F89C433EF
	for <iommu@archiver.kernel.org>; Sat, 16 Apr 2022 12:33:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9BDA760F94;
	Sat, 16 Apr 2022 12:33:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id euK_Crx7VAgg; Sat, 16 Apr 2022 12:33:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9257F607F6;
	Sat, 16 Apr 2022 12:33:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65417C0084;
	Sat, 16 Apr 2022 12:33:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CE1EC002C
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 12:33:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D2A760E74
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 12:33:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fu8Apt1n0G10 for <iommu@lists.linux-foundation.org>;
 Sat, 16 Apr 2022 12:33:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C51EC607F6
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 12:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650112415; x=1681648415;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=s/nEvl/+FxcEwkLWfzrwaMLflIe37RdxIWhxas3awd4=;
 b=gMgABO3sWFlcsHehJ2wVh301+E2HKhX5Q9PDOKPOVQwS6x9YN4Omc5JU
 DTjvX/gf8UjUMW5mM7w93Z/SuIj7uy3QQJBmX520m0ERyuEO3Wz03fbLy
 eXlVzdbDJbplwgyCFmE1ZBTixf23hitqtkmefCs3DrDfUosq2sTCKJvsz
 zKPe6rLzuzgSAq8GlBv/mol2D4hA2Yx7XRH51309sv+RsvneV0WUdOvmF
 RSqWiMkQAYl321tCkaqGu3QNihzY7q/k36sQTt/YnlnBBPPDaEkGq2+FE
 etM0qF3VM/iO6H99Adcr2JAcuEyOuUj199QdWj60v5ob69XB/zfGmyyHI w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="263045795"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; d="scan'208";a="263045795"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2022 05:33:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; d="scan'208";a="701332474"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2022 05:33:33 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jacob jun Pan <jacob.jun.pan@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>
Subject: [PATCH 2/3] iommu/vt-d: Drop stop marker messages
Date: Sat, 16 Apr 2022 20:30:48 +0800
Message-Id: <20220416123049.879969-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416123049.879969-1-baolu.lu@linux.intel.com>
References: <20220416123049.879969-1-baolu.lu@linux.intel.com>
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

The VT-d driver explicitly drains the pending page requests when a CPU
page table (represented by a mm struct) is unbound from a PASID according
to the procedures defined in the VT-d spec. Hence, there's no need to
report the stop-marker message in prq_event_thread(). The stop marker
messages do not need a response. This drops stop marker messages silently
if any of them is found in the page request queue.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index d88af37c20ef..d1c42dfae6ca 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -758,6 +758,10 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			goto bad_req;
 		}
 
+		/* Drop Stop Marker message. No need for a response. */
+		if (unlikely(req->lpig && !req->rd_req && !req->wr_req))
+			goto prq_advance;
+
 		if (!svm || svm->pasid != req->pasid) {
 			/*
 			 * It can't go away, because the driver is not permitted
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
