Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3D0C433FE
	for <iommu@archiver.kernel.org>; Fri, 28 Jan 2022 03:11:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7435140B45;
	Fri, 28 Jan 2022 03:11:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q_lXPPRwaTH3; Fri, 28 Jan 2022 03:11:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0C8FF40104;
	Fri, 28 Jan 2022 03:11:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9B8AC0011;
	Fri, 28 Jan 2022 03:11:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71DD8C000B
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 03:11:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6194760AA7
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 03:11:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bNZju45GRdGn for <iommu@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 03:11:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5CFC760AD1
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 03:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643339476; x=1674875476;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zoU1omRJv6N1DpT5EOTUNpXjGL7yIqo540I11V+/7eo=;
 b=fk/Hq1lQJ84mWKAPM/X+KNVioLAjzCTbtqov7vGw4tEhiOMYuk+RgNKG
 h48EO7hefv10MdQmMaL4zKPwYsQ1gxIG54+ffgSKvejvzrc6NF0ZOxJaU
 5kKEAjToSavbKq2k7iBdov/JHmRMHxXXkFdEdr2KmHB3VSaywg5pcdcAa
 Rarlzfz5Kwd8WNlQaJh4nSc0U2nYT5gNwpgunDJBiU37xO4lZe7Kw0TBR
 E1Arvi6G0tOzDSak4YGNqNNHKgMBjnLYadbW3EBgRbRc1UVTqkCJlZXKB
 ZqezxN993roTVZPp1HJC1yCTLWtn6WCXKkfiCFEVyaRN7WPEfniW/2acM w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="245873437"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; d="scan'208";a="245873437"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2022 19:11:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; d="scan'208";a="521513434"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 27 Jan 2022 19:11:14 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/2] iommu/vt-d: Fix potential memory leak in
 intel_setup_irq_remapping()
Date: Fri, 28 Jan 2022 11:10:02 +0800
Message-Id: <20220128031002.2219155-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128031002.2219155-1-baolu.lu@linux.intel.com>
References: <20220128031002.2219155-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Guoqing Jiang <guoqing.jiang@linux.dev>
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

From: Guoqing Jiang <guoqing.jiang@linux.dev>

After commit e3beca48a45b ("irqdomain/treewide: Keep firmware node
unconditionally allocated"). For tear down scenario, fn is only freed
after fail to allocate ir_domain, though it also should be freed in case
dmar_enable_qi returns error.

Besides free fn, irq_domain and ir_msi_domain need to be removed as well
if intel_setup_irq_remapping fails to enable queued invalidation.

Improve the rewinding path by add out_free_ir_domain and out_free_fwnode
lables per Baolu's suggestion.

Fixes: e3beca48a45b ("irqdomain/treewide: Keep firmware node unconditionally allocated")
Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Link: https://lore.kernel.org/r/20220119063640.16864-1-guoqing.jiang@linux.dev
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/irq_remapping.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index f912fe45bea2..a67319597884 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -569,9 +569,8 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 					    fn, &intel_ir_domain_ops,
 					    iommu);
 	if (!iommu->ir_domain) {
-		irq_domain_free_fwnode(fn);
 		pr_err("IR%d: failed to allocate irqdomain\n", iommu->seq_id);
-		goto out_free_bitmap;
+		goto out_free_fwnode;
 	}
 	iommu->ir_msi_domain =
 		arch_create_remap_msi_irq_domain(iommu->ir_domain,
@@ -595,7 +594,7 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 
 		if (dmar_enable_qi(iommu)) {
 			pr_err("Failed to enable queued invalidation\n");
-			goto out_free_bitmap;
+			goto out_free_ir_domain;
 		}
 	}
 
@@ -619,6 +618,14 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 
 	return 0;
 
+out_free_ir_domain:
+	if (iommu->ir_msi_domain)
+		irq_domain_remove(iommu->ir_msi_domain);
+	iommu->ir_msi_domain = NULL;
+	irq_domain_remove(iommu->ir_domain);
+	iommu->ir_domain = NULL;
+out_free_fwnode:
+	irq_domain_free_fwnode(fn);
 out_free_bitmap:
 	bitmap_free(bitmap);
 out_free_pages:
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
