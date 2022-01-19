Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25E0C433EF
	for <iommu@archiver.kernel.org>; Wed, 19 Jan 2022 06:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 604274014A;
	Wed, 19 Jan 2022 06:37:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dmV_yBzLivAB; Wed, 19 Jan 2022 06:37:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 028DD4036A;
	Wed, 19 Jan 2022 06:37:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6347C0039;
	Wed, 19 Jan 2022 06:37:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56EC7C002F
 for <iommu@lists.linux-foundation.org>; Wed, 19 Jan 2022 06:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 370FE60ACC
 for <iommu@lists.linux-foundation.org>; Wed, 19 Jan 2022 06:36:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux.dev
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xf--kH-yDcjo for <iommu@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:36:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DA42E60AB5
 for <iommu@lists.linux-foundation.org>; Wed, 19 Jan 2022 06:36:57 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1642574213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LiQMcF1P1tMKFvY4FFGo/Qowuktip2b0bpZN3gCoyLc=;
 b=lOS6YWvYZ+Z30EnPnEVtdMD4fMJ0gfiC8PRo1YvaeTv3oDZXcrK8eudo3gKFq9p8/AmvmO
 /bEJZRRUiTnNEnM5FI3lWjMe+fDGuoWDspW6uThjh/FIPPQFlzHisniIoV83aOykqqui6X
 BOWxCZbKnCfxq705QNirhXClCBPxajA=
From: Guoqing Jiang <guoqing.jiang@linux.dev>
To: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
 will@kernel.org
Subject: [PATCH v2] iommu/intel: Fix potential memory leak in
 intel_setup_irq_remapping
Date: Wed, 19 Jan 2022 14:36:40 +0800
Message-Id: <20220119063640.16864-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
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
---
v2: add remove irq_domains in the error handling path

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
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
