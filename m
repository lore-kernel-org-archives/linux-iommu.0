Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7A6C433FE
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 17:43:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24FFA61152
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 17:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 24FFA61152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89F0A607BA;
	Thu, 23 Sep 2021 17:43:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GBBLmdHJNwMx; Thu, 23 Sep 2021 17:43:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 527DF60C23;
	Thu, 23 Sep 2021 17:43:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 268C2C0025;
	Thu, 23 Sep 2021 17:43:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1647C0022
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 17:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBA7B4041D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 17:26:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VT80LW9xXC83 for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 17:26:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4415D400B5
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 17:26:56 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="223933672"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="223933672"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 10:26:56 -0700
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="704832566"
Received: from unknown (HELO bad-guy.kumite) ([10.252.132.140])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 10:26:56 -0700
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH v2 7/9] cxl/pci: Use pci core's DVSEC functionality
Date: Thu, 23 Sep 2021 10:26:45 -0700
Message-Id: <20210923172647.72738-8-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923172647.72738-1-ben.widawsky@intel.com>
References: <20210923172647.72738-1-ben.widawsky@intel.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 23 Sep 2021 17:43:10 +0000
Cc: Ben Widawsky <ben.widawsky@intel.com>, Andrew Donnellan <ajd@linux.ibm.com>,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 "David E. Box" <david.e.box@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Kan Liang <kan.liang@linux.intel.com>
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

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/pci.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 5eaf2736f779..79d4d9b16d83 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -340,25 +340,7 @@ static void cxl_pci_unmap_regblock(struct cxl_mem *cxlm, struct cxl_register_map
 
 static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
 {
-	int pos;
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
-	if (!pos)
-		return 0;
-
-	while (pos) {
-		u16 vendor, id;
-
-		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vendor);
-		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER2, &id);
-		if (vendor == PCI_DVSEC_VENDOR_ID_CXL && dvsec == id)
-			return pos;
-
-		pos = pci_find_next_ext_capability(pdev, pos,
-						   PCI_EXT_CAP_ID_DVSEC);
-	}
-
-	return 0;
+	return pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL, dvsec);
 }
 
 static int cxl_probe_regs(struct cxl_mem *cxlm, struct cxl_register_map *map)
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
