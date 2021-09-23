Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3486C433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 17:43:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4381A6109E
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 17:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4381A6109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 08AFE40201;
	Thu, 23 Sep 2021 17:43:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uHsFz4uHDson; Thu, 23 Sep 2021 17:43:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A17144000B;
	Thu, 23 Sep 2021 17:43:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70BFFC0011;
	Thu, 23 Sep 2021 17:43:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 027C7C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 17:26:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D760E40201
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 17:26:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kbqBavf_pv7D for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 17:26:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3FB224040C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 17:26:54 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="223933657"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="223933657"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 10:26:53 -0700
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="704832523"
Received: from unknown (HELO bad-guy.kumite) ([10.252.132.140])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 10:26:52 -0700
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH v2 2/9] cxl/pci: Remove dev_dbg for unknown register blocks
Date: Thu, 23 Sep 2021 10:26:40 -0700
Message-Id: <20210923172647.72738-3-ben.widawsky@intel.com>
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

While interesting to driver developers, the dev_dbg message doesn't do
much except clutter up logs. This information should be attainable
through sysfs, and someday lspci like utilities. This change
additionally helps reduce the LOC in a subsequent patch to refactor some
of cxl_pci register mapping.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 64180f46c895..ccc7c2573ddc 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -475,9 +475,6 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
 		cxl_decode_register_block(reg_lo, reg_hi, &bar, &offset,
 					  &reg_type);
 
-		dev_dbg(dev, "Found register block in bar %u @ 0x%llx of type %u\n",
-			bar, offset, reg_type);
-
 		/* Ignore unknown register block types */
 		if (reg_type > CXL_REGLOC_RBI_MEMDEV)
 			continue;
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
