Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A0DC433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Dec 2021 15:41:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2948C81248;
	Wed, 29 Dec 2021 15:41:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vuVxnIZeyk-s; Wed, 29 Dec 2021 15:41:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5210D81242;
	Wed, 29 Dec 2021 15:41:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23B8DC002F;
	Wed, 29 Dec 2021 15:41:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FC85C0012
 for <iommu@lists.linux-foundation.org>; Wed, 29 Dec 2021 09:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 489678198A
 for <iommu@lists.linux-foundation.org>; Wed, 29 Dec 2021 09:05:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n52e03OV237D for <iommu@lists.linux-foundation.org>;
 Wed, 29 Dec 2021 09:05:31 +0000 (UTC)
X-Greylist: delayed 00:09:07 by SQLgrey-1.8.0
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 59AA4818EC
 for <iommu@lists.linux-foundation.org>; Wed, 29 Dec 2021 09:05:31 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1640768181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qht8XLVo4MWgnP4oFFOipreHGq2ULuzqVrETezRZ0jo=;
 b=vuOOxWO5ORpjnyAuKRejyZ0mWjdHLVcUEBMIOllkr54dFbe5ELSocb2uxLTsLpenxKo7XJ
 +yis651yF9bk0n1MSLn2u5TaoA/Ai7qqYY504I/gap9kNn2wvKFOehH5khj1NgLlBT/opQ
 fmRKwbCCfy03fQ6wtLfz3+tCP80FyQc=
From: Guoqing Jiang <guoqing.jiang@linux.dev>
To: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
 will@kernel.org
Subject: [PATCH] iommu/intel: Fix potential memory leak in
 intel_setup_irq_remapping
Date: Wed, 29 Dec 2021 16:56:08 +0800
Message-Id: <20211229085608.18307-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Mailman-Approved-At: Wed, 29 Dec 2021 15:41:29 +0000
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

Call irq_domain_free_fwnode to free 'fn' if dmar_enable_qi returns
failure, same as when irq_domain_create_hierarchy returns failure.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/iommu/intel/irq_remapping.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index f912fe45bea2..6e8362c21fc3 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -594,6 +594,7 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 		dmar_disable_qi(iommu);
 
 		if (dmar_enable_qi(iommu)) {
+			irq_domain_free_fwnode(fn);
 			pr_err("Failed to enable queued invalidation\n");
 			goto out_free_bitmap;
 		}
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
