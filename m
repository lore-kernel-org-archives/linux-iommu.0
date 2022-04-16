Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECD9C433EF
	for <iommu@archiver.kernel.org>; Sat, 16 Apr 2022 12:33:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA88683FAE;
	Sat, 16 Apr 2022 12:33:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V7vRCqDcX59F; Sat, 16 Apr 2022 12:33:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 90B178408F;
	Sat, 16 Apr 2022 12:33:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1149FC002C;
	Sat, 16 Apr 2022 12:33:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22568C002C
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 12:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1FB4060E74
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 12:33:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y0nDZtezgPVh for <iommu@lists.linux-foundation.org>;
 Sat, 16 Apr 2022 12:33:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 85378607F6
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 12:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650112413; x=1681648413;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tCjF1I4YjEgxSy7zR9vWw2QROF8JK1qkQd4b3h+ujew=;
 b=Gnfuz0w0/RFifaqu8RBqzCjaxKrQ5nj+8f/vg+ttI+1vVmaUg/wEsuSM
 SFcsY7MTbHZVN1IFn6sGJxRKC3yLwQCYdgcURz0ztpavqcTUycOSm4Be+
 w88tloGp3usGZSjejW5J2JhIPWHDSfZeyGTpvehkly56lHCIeTr5qwuXO
 3mcjzNsp5OTr5WcTAUIcuYcy30oRN9MfD3NxNgMwnT/a7vH/Ys5i4TBg2
 MZhWtkiv/KSS6M4v+fbTUUlR/+JNJcVAKyv/NIP+hHGB7o7JrmMj4a2K3
 s7K/8r8QW9TaM3Ur8d4urexX8jGH9Zls02d8hlx6viVzUmgM3Mg4flmJD w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="263045792"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; d="scan'208";a="263045792"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2022 05:33:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; d="scan'208";a="701332465"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2022 05:33:31 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jacob jun Pan <jacob.jun.pan@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>
Subject: [PATCH 1/3] iommu/vt-d: Set PGSNP bit in pasid table entry for sva
 binding
Date: Sat, 16 Apr 2022 20:30:47 +0800
Message-Id: <20220416123049.879969-2-baolu.lu@linux.intel.com>
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

This field make the requests snoop processor caches irrespective of other
attributes in the request or other fields in paging structure entries
used to translate the request. The latest VT-d specification states that
this field is treated as Reserved(0) for implementations not supporting
Snoop Control (SC=0 in the Extended Capability Register). Hence add a
check in the code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 2 +-
 drivers/iommu/intel/svm.c   | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index f8d215d85695..9ca3c67a2058 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -625,7 +625,7 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 		}
 	}
 
-	if (flags & PASID_FLAG_PAGE_SNOOP)
+	if ((flags & PASID_FLAG_PAGE_SNOOP) && ecap_sc_support(iommu->ecap))
 		pasid_set_pgsnp(pte);
 
 	pasid_set_domain_id(pte, did);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 23a38763c1d1..d88af37c20ef 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -394,6 +394,7 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
 			PASID_FLAG_SUPERVISOR_MODE : 0;
 	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
+	sflags |= PASID_FLAG_PAGE_SNOOP;
 	spin_lock_irqsave(&iommu->lock, iflags);
 	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
 					    FLPT_DEFAULT_DID, sflags);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
