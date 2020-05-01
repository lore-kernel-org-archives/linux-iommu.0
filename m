Return-Path: <SRS0=bJ3n=6P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC72C4724C
	for <iommu@archiver.kernel.org>; Fri,  1 May 2020 07:27:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8125208C3
	for <iommu@archiver.kernel.org>; Fri,  1 May 2020 07:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8125208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id ADB4B89713;
	Fri,  1 May 2020 07:27:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F+N9uf3FLwtx; Fri,  1 May 2020 07:27:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 481288970A;
	Fri,  1 May 2020 07:27:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 294ABC0864;
	Fri,  1 May 2020 07:27:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F163BC016F
 for <iommu@lists.linux-foundation.org>; Fri,  1 May 2020 07:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DA2A688F1A
 for <iommu@lists.linux-foundation.org>; Fri,  1 May 2020 07:27:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tT1XmSpJLRsu for <iommu@lists.linux-foundation.org>;
 Fri,  1 May 2020 07:27:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 91E8D88F19
 for <iommu@lists.linux-foundation.org>; Fri,  1 May 2020 07:27:47 +0000 (UTC)
IronPort-SDR: WJP3mqwC1XrMy6C3HFwH8eHm7NdlahBZST0YUAfEg2FG62Rsfabg9VQvOogPsNiLZ5RRTJeug8
 VLWSuEAeU/2g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2020 00:27:46 -0700
IronPort-SDR: MCvdbRwGNZAWvyHFXjfw+ePOBcf5ziBKLyaH2TCz4XQbVkOSGOPuxhSxEIIj7J4cculzt7FoF3
 0MNW1ZuRllWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,338,1583222400"; d="scan'208";a="283117218"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 01 May 2020 00:27:45 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/1] iommu/vt-d: Use right Kconfig option name
Date: Fri,  1 May 2020 15:24:27 +0800
Message-Id: <20200501072427.14265-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: iommu@lists.linux-foundation.org, Ashok Raj <ashok.raj@intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The CONFIG_ prefix should be added in the code.

Fixes: 046182525db61 ("iommu/vt-d: Add Kconfig option to enable/disable scalable mode")
Reported-and-tested-by: Kumar, Sanjay K <sanjay.k.kumar@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ef0a5246700e..0182cff2c7ac 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -371,11 +371,11 @@ int dmar_disabled = 0;
 int dmar_disabled = 1;
 #endif /* CONFIG_INTEL_IOMMU_DEFAULT_ON */
 
-#ifdef INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
+#ifdef CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
 int intel_iommu_sm = 1;
 #else
 int intel_iommu_sm;
-#endif /* INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON */
+#endif /* CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON */
 
 int intel_iommu_enabled = 0;
 EXPORT_SYMBOL_GPL(intel_iommu_enabled);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
