Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC100C433FE
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 11:38:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71EE6610D4;
	Thu, 21 Apr 2022 11:38:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xocsTLDBdWDV; Thu, 21 Apr 2022 11:38:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4E09E60E2A;
	Thu, 21 Apr 2022 11:38:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 384A1C0033;
	Thu, 21 Apr 2022 11:38:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11036C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 11:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E858F409D9
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 11:38:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SMn-o7Awq1_w for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 11:38:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E5FC405BE
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 11:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650541127; x=1682077127;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=t+FgniAGQmeXacymlT2gSb61V603jB6flixJAZie7ew=;
 b=TwO5jBljbgo9E3owdftDrSw5gssas9Ns+TMefH9sisdoTpIfieHCowNr
 TYkU2FsL1kUDB0x6UxxLELINZuyyhEACXv9Ifbs0fm5M6ivGc83xY5MU/
 3DxWb3gynKervYfAzetTGYvVTRtWEFOkJzxA+8g2S7w51LuCO0HCjGulN
 KMXaiy4wcKUE2ZjnC3ah/SZP59ODwhaPSWYEqhSsl6d7uOlFrx1QLtj5F
 2IIqAFhNHCCh/o79jFA9WJmQfIlM80BD9RafqU5ufdvty9ko9/KVU2FRQ
 7L3FVx+zX6mFXz2/nUbztGeDIjLFwss6y92kSyStMchEHzzR65ukoFjyQ g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263790105"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; d="scan'208";a="263790105"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2022 04:38:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; d="scan'208";a="703047926"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2022 04:38:45 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jacob jun Pan <jacob.jun.pan@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>
Subject: [PATCH v2 2/4] iommu/vt-d: Set PGSNP bit in pasid table entry for SVA
 binding
Date: Thu, 21 Apr 2022 19:35:56 +0800
Message-Id: <20220421113558.3504874-3-baolu.lu@linux.intel.com>
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

This field make the requests snoop processor caches irrespective of
other attributes in the request or other fields in paging structure
entries used to translate the request.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 23a38763c1d1..c720d1be992d 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -391,9 +391,12 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	}
 
 	/* Setup the pasid table: */
-	sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
-			PASID_FLAG_SUPERVISOR_MODE : 0;
-	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
+	sflags = PASID_FLAG_PAGE_SNOOP;
+	if (flags & SVM_FLAG_SUPERVISOR_MODE)
+		sflags |= PASID_FLAG_SUPERVISOR_MODE;
+	if (cpu_feature_enabled(X86_FEATURE_LA57))
+		sflags |= PASID_FLAG_FL5LP;
+
 	spin_lock_irqsave(&iommu->lock, iflags);
 	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
 					    FLPT_DEFAULT_DID, sflags);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
