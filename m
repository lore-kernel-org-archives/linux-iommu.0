Return-Path: <SRS0=RzN/=OQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8545EC433F5
	for <iommu@archiver.kernel.org>; Sun, 26 Sep 2021 11:49:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CEBE61038
	for <iommu@archiver.kernel.org>; Sun, 26 Sep 2021 11:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2CEBE61038
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09B2080E4D;
	Sun, 26 Sep 2021 11:49:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1eSQaY096iDi; Sun, 26 Sep 2021 11:49:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D861E80E3F;
	Sun, 26 Sep 2021 11:49:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C424BC000F;
	Sun, 26 Sep 2021 11:49:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3E11C000D
 for <iommu@lists.linux-foundation.org>; Sun, 26 Sep 2021 11:49:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EFA9A402EF
 for <iommu@lists.linux-foundation.org>; Sun, 26 Sep 2021 11:49:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YTBA3H3sLjQa for <iommu@lists.linux-foundation.org>;
 Sun, 26 Sep 2021 11:49:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 10CD5402FD
 for <iommu@lists.linux-foundation.org>; Sun, 26 Sep 2021 11:49:17 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10118"; a="222450220"
X-IronPort-AV: E=Sophos;i="5.85,323,1624345200"; d="scan'208";a="222450220"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2021 04:49:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,323,1624345200"; d="scan'208";a="475640108"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 26 Sep 2021 04:49:15 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 2/3] iommu/vt-d: Check FL and SL capability sanity in
 scalable mode
Date: Sun, 26 Sep 2021 19:45:34 +0800
Message-Id: <20210926114535.923263-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210926114535.923263-1-baolu.lu@linux.intel.com>
References: <20210926114535.923263-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
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

An iommu domain could be allocated and mapped before it's attached to any
device. This requires that in scalable mode, when the domain is allocated,
the format (FL or SL) of the page table must be determined. In order to
achieve this, the platform should support consistent SL or FL capabilities
on all IOMMU's. This adds a check for this and aborts IOMMU probing if it
doesn't meet this requirement.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/cap_audit.h |  1 +
 drivers/iommu/intel/cap_audit.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/iommu/intel/cap_audit.h b/drivers/iommu/intel/cap_audit.h
index 74cfccae0e81..d07b75938961 100644
--- a/drivers/iommu/intel/cap_audit.h
+++ b/drivers/iommu/intel/cap_audit.h
@@ -111,6 +111,7 @@ bool intel_cap_smts_sanity(void);
 bool intel_cap_pasid_sanity(void);
 bool intel_cap_nest_sanity(void);
 bool intel_cap_flts_sanity(void);
+bool intel_cap_slts_sanity(void);
 
 static inline bool scalable_mode_support(void)
 {
diff --git a/drivers/iommu/intel/cap_audit.c b/drivers/iommu/intel/cap_audit.c
index b12e421a2f1a..040e4ae0e42b 100644
--- a/drivers/iommu/intel/cap_audit.c
+++ b/drivers/iommu/intel/cap_audit.c
@@ -163,6 +163,14 @@ static int cap_audit_static(struct intel_iommu *iommu, enum cap_audit_type type)
 			check_irq_capabilities(iommu, i);
 	}
 
+	/*
+	 * If the system is sane to support scalable mode, either SL or FL
+	 * should be sane.
+	 */
+	if (intel_cap_smts_sanity() &&
+	    !intel_cap_flts_sanity() && !intel_cap_slts_sanity())
+		return -EFAULT;
+
 out:
 	rcu_read_unlock();
 	return 0;
@@ -203,3 +211,8 @@ bool intel_cap_flts_sanity(void)
 {
 	return ecap_flts(intel_iommu_ecap_sanity);
 }
+
+bool intel_cap_slts_sanity(void)
+{
+	return ecap_slts(intel_iommu_ecap_sanity);
+}
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
