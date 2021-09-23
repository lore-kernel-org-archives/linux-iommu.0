Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ED6C4332F
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 17:43:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE1360F4C
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 17:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DAE1360F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2694C4041D;
	Thu, 23 Sep 2021 17:43:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zyx9CaAzxcwr; Thu, 23 Sep 2021 17:43:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 98B9640117;
	Thu, 23 Sep 2021 17:43:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6768FC0035;
	Thu, 23 Sep 2021 17:43:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A647C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 17:27:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 70E6A401B2
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 17:26:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id glMj8Zdnce2m for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 17:26:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 96CF540201
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 17:26:57 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="223933675"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="223933675"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 10:26:57 -0700
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="704832575"
Received: from unknown (HELO bad-guy.kumite) ([10.252.132.140])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 10:26:56 -0700
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH v2 8/9] ocxl: Use pci core's DVSEC functionality
Date: Thu, 23 Sep 2021 10:26:46 -0700
Message-Id: <20210923172647.72738-9-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923172647.72738-1-ben.widawsky@intel.com>
References: <20210923172647.72738-1-ben.widawsky@intel.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 23 Sep 2021 17:43:10 +0000
Cc: Ben Widawsky <ben.widawsky@intel.com>, Andrew Donnellan <ajd@linux.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
 Bjorn Helgaas <helgaas@kernel.org>,
 "David E. Box" <david.e.box@linux.intel.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Kan Liang <kan.liang@linux.intel.com>
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

Reduce maintenance burden of DVSEC query implementation by using the
centralized PCI core implementation.

There are two obvious places to simply drop in the new core
implementation. There remains find_dvsec_from_pos() which would benefit
from using a core implementation. As that change is less trivial it is
reserved for later.

Cc: linuxppc-dev@lists.ozlabs.org
Cc: Andrew Donnellan <ajd@linux.ibm.com>
Acked-by: Frederic Barrat <fbarrat@linux.ibm.com> (v1)
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 arch/powerpc/platforms/powernv/ocxl.c |  3 ++-
 drivers/misc/ocxl/config.c            | 13 +------------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
index 9105efcf242a..28b009b46464 100644
--- a/arch/powerpc/platforms/powernv/ocxl.c
+++ b/arch/powerpc/platforms/powernv/ocxl.c
@@ -107,7 +107,8 @@ static int get_max_afu_index(struct pci_dev *dev, int *afu_idx)
 	int pos;
 	u32 val;
 
-	pos = find_dvsec_from_pos(dev, OCXL_DVSEC_FUNC_ID, 0);
+	pos = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_IBM,
+					OCXL_DVSEC_FUNC_ID);
 	if (!pos)
 		return -ESRCH;
 
diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
index a68738f38252..e401a51596b9 100644
--- a/drivers/misc/ocxl/config.c
+++ b/drivers/misc/ocxl/config.c
@@ -33,18 +33,7 @@
 
 static int find_dvsec(struct pci_dev *dev, int dvsec_id)
 {
-	int vsec = 0;
-	u16 vendor, id;
-
-	while ((vsec = pci_find_next_ext_capability(dev, vsec,
-						    OCXL_EXT_CAP_ID_DVSEC))) {
-		pci_read_config_word(dev, vsec + OCXL_DVSEC_VENDOR_OFFSET,
-				&vendor);
-		pci_read_config_word(dev, vsec + OCXL_DVSEC_ID_OFFSET, &id);
-		if (vendor == PCI_VENDOR_ID_IBM && id == dvsec_id)
-			return vsec;
-	}
-	return 0;
+	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_IBM, dvsec_id);
 }
 
 static int find_dvsec_afu_ctrl(struct pci_dev *dev, u8 afu_idx)
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
