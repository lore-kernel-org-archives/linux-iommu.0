Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40473C433FE
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 11:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8BA441B87;
	Thu, 21 Apr 2022 11:38:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wrsNNrrPZaZe; Thu, 21 Apr 2022 11:38:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9117C41B4A;
	Thu, 21 Apr 2022 11:38:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68EBEC0033;
	Thu, 21 Apr 2022 11:38:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07BFAC002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 11:38:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DB9A540B66
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 11:38:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XDfPwveiFTkc for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 11:38:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4783640AF2
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 11:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650541129; x=1682077129;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m643EXK7yOsfDONzYaJXtxPMlW05HUDqdqLxYq7AN30=;
 b=DE70bKoUYKqTBBTcb3S6BC4hsjAdEkhvGpGfSX//Cy7ZuBQFvLiyjqaX
 bAmoil/oLG2IHriQDUazNgIgUZk0G3SITGRz3cWcaLSRUHF2q3wdIBlbj
 7no7oXDFky7frOh7Cy9pueZhhqOIne7S+XRX7MUrwhckCvQBlhdXytRx3
 YPXeEyJ8ZSLdHIsu9VUk3lgRA6P5Xyuph61Once3G/G6KzaqUfnnnfHXe
 eTe4Sm+FNmLpqtJ1XTcxbfFGfXQR0YGbRfUNLe0dlvAVkK43xuP7Y1Dtg
 bBOO9DBTRLwiimc7xkpv58w/sWgvknuiI0dLuK6rRKXO0w8xaE8hPx8Vq Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263790110"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; d="scan'208";a="263790110"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2022 04:38:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; d="scan'208";a="703047933"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2022 04:38:47 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jacob jun Pan <jacob.jun.pan@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>
Subject: [PATCH v2 3/4] iommu/vt-d: Drop stop marker messages
Date: Thu, 21 Apr 2022 19:35:57 +0800
Message-Id: <20220421113558.3504874-4-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/svm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index c720d1be992d..0741ec165673 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -760,6 +760,10 @@ static irqreturn_t prq_event_thread(int irq, void *d)
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
