Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D98C433EF
	for <iommu@archiver.kernel.org>; Fri, 27 May 2022 05:37:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57C3942792;
	Fri, 27 May 2022 05:37:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id goFhLtG5Bcv0; Fri, 27 May 2022 05:37:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F4173427AE;
	Fri, 27 May 2022 05:37:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B68B1C0032;
	Fri, 27 May 2022 05:37:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CCBCC002D
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 05:37:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2EE42427AE
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 05:37:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JGqEfL-ovV9C for <iommu@lists.linux-foundation.org>;
 Fri, 27 May 2022 05:37:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1373042792
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 05:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653629873; x=1685165873;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=B0StCX6RwQbyJoVE+z/qrjWGVToT35XUEx5CRooJFdQ=;
 b=i3p0i+F8fBhR8cohqE8S4cM6pBbqOnZoYkUBP85jrbge55DCsB5yU7vG
 Km7+e4h+SfXjcIfyja654ECRXSrcmC4vCYhv+qGY6dOLsv5NFE2fy1c+M
 73BWtTXqWfnKma+Mkn9TLdSQe1qT7+eBab8xM/AYA4o+/uizPX1x7mP69
 /7Dext9agrDMr0vi4re3FbazLxYf62bqa5lxghxmI6fxtF8L8DUSuJToA
 f7MNEIOyxSLD3bnBthRhOmN1iXnD72mhxKx9pmVUbm+jriQ0TWNGe5PgT
 ITyaOKriALj439snK8OiRes35pt/iX4Xo9oN7xGKjNC6iKNzxoOBlHRYF w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274111733"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; d="scan'208";a="274111733"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2022 22:37:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; d="scan'208";a="718604566"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 26 May 2022 22:37:51 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 1/1] iommu/vt-d: Remove unused iovad from dmar_domain
Date: Fri, 27 May 2022 13:34:24 +0800
Message-Id: <20220527053424.3111186-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org
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

Not used anywhere. Cleanup it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 0f9df5a19ef7..a22adfbdf870 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -543,7 +543,6 @@ struct dmar_domain {
 	u8 set_pte_snp:1;
 
 	struct list_head devices;	/* all devices' list */
-	struct iova_domain iovad;	/* iova's that belong to this domain */
 
 	struct dma_pte	*pgd;		/* virtual address */
 	int		gaw;		/* max guest address width */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
