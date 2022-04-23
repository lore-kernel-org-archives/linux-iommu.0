Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FD3C433FE
	for <iommu@archiver.kernel.org>; Sat, 23 Apr 2022 08:26:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10F394198F;
	Sat, 23 Apr 2022 08:26:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6W6W4W38qbnJ; Sat, 23 Apr 2022 08:26:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C6C214198A;
	Sat, 23 Apr 2022 08:26:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B7B9C0032;
	Sat, 23 Apr 2022 08:26:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E397AC002D
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 08:26:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C2E514198F
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 08:26:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D75fVIdNJUTq for <iommu@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 08:26:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DBA1F4198A
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 08:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650702374; x=1682238374;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dn3ekKp4SWnR66WLuK3pDJ60x9OTOTADkUJA31Kj0pk=;
 b=HKE2EAzp+kRQPec5TLBR0v2JuC+APIaejr1ZfImEvPYE30Uet8j70LhB
 ydWoEHyLeVR3NlHiVKXMO5MGIX6atZchXvbSDAyGlEqYQViR/Zw0QoIf5
 qrRWcZtblL8jL4zvZWahldBfHjZFQiAgAl3YulLpnFYbxLdfzfhcQNj1I
 cINtNIrOrJOkEduFw3Og4xQsD7Mw9hocsJBSn5Qhqyr0jPBEY8TWLu0S/
 Y2/jjFFtEuJAcbP0meLs7Z1cwM7r3GqcWLj+iqVsFxVhQb56Sfd9jW7yx
 EgLNiQcG2wf6ut0ig354TPXG7xDpX3+CHZ+q36jcyEQToy4vrba4HEkiL w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="244794799"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; d="scan'208";a="244794799"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2022 01:26:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; d="scan'208";a="703866205"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 23 Apr 2022 01:26:13 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/1] iommu/vt-d: Drop stop marker messages
Date: Sat, 23 Apr 2022 16:23:30 +0800
Message-Id: <20220423082330.3897867-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220423082330.3897867-1-baolu.lu@linux.intel.com>
References: <20220423082330.3897867-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux-foundation.org
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

The page fault handling framework in the IOMMU core explicitly states
that it doesn't handle PCI PASID Stop Marker and the IOMMU drivers must
discard them before reporting faults. This handles Stop Marker messages
in prq_event_thread() before reporting events to the core.

The VT-d driver explicitly drains the pending page requests when a CPU
page table (represented by a mm struct) is unbound from a PASID according
to the procedures defined in the VT-d spec. The Stop Marker messages do
not need a response. Hence, it is safe to drop the Stop Marker messages
silently if any of them is found in the page request queue.

Fixes: d5b9e4bfe0d88 ("iommu/vt-d: Report prq to io-pgfault framework")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20220421113558.3504874-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/svm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 23a38763c1d1..7ee37d996e15 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -757,6 +757,10 @@ static irqreturn_t prq_event_thread(int irq, void *d)
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
