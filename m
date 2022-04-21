Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8917DC433EF
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 11:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56E46610C3;
	Thu, 21 Apr 2022 11:38:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mmb7r3_2EPVd; Thu, 21 Apr 2022 11:38:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2F40960E2A;
	Thu, 21 Apr 2022 11:38:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04387C0033;
	Thu, 21 Apr 2022 11:38:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C4A1C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 11:38:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A7C540592
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 11:38:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R06c0Y0mxx56 for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 11:38:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8210440272
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 11:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650541125; x=1682077125;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=osVQwJV/ZujaTApdG5eicPwbXUjaErfT37EPkI8Lc0g=;
 b=bWs+UoAx6K2+ayqtJoBqIGIU+US9H5/45d4wjJ1InKlRZeLO1Mldyh6H
 M7Wz2xKrwqYicaUd0WoFxSQdksQiXsZRtkNvMiBwhxxS/86YqobcLJlHm
 wrmx3KVtXeFEzlL9OPeqimci3r0/neh/0KAd+Rpz2l0tJdRFjN/xqXDCy
 mZRgA36kKim/j0BEXJnFgXqozM68Ne7icG+8PmkFDnoVF8gzU7CwtVp8S
 8R5gVfKRepztWyqyeli4UHveAI61kqN6qYX6Qu9iR3MFemHP3M2gHjBHb
 zvz/kG7PD/5MDcS1wsN8FTf6t4ETVcXLfL+F3YYn38Q1pqmZY6KlKWE1y Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263790096"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; d="scan'208";a="263790096"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2022 04:38:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; d="scan'208";a="703047918"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2022 04:38:43 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jacob jun Pan <jacob.jun.pan@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>
Subject: [PATCH v2 1/4] iommu/vt-d: Check before setting PGSNP bit in pasid
 table entry
Date: Thu, 21 Apr 2022 19:35:55 +0800
Message-Id: <20220421113558.3504874-2-baolu.lu@linux.intel.com>
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

The latest VT-d specification states that the PGSNP field in the pasid
table entry should be treated as Reserved(0) for implementations not
supporting Snoop Control (SC=0 in the Extended Capability Register).
This adds a check before setting the field.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index f8d215d85695..5cb2daa2b8cb 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -625,8 +625,14 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 		}
 	}
 
-	if (flags & PASID_FLAG_PAGE_SNOOP)
-		pasid_set_pgsnp(pte);
+	if (flags & PASID_FLAG_PAGE_SNOOP) {
+		if (ecap_sc_support(iommu->ecap)) {
+			pasid_set_pgsnp(pte);
+		} else {
+			pasid_clear_entry(pte);
+			return -EINVAL;
+		}
+	}
 
 	pasid_set_domain_id(pte, did);
 	pasid_set_address_width(pte, iommu->agaw);
@@ -710,7 +716,8 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	pasid_set_fault_enable(pte);
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
 
-	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
+	if (ecap_sc_support(iommu->ecap) &&
+	    domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
 		pasid_set_pgsnp(pte);
 
 	/*
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
