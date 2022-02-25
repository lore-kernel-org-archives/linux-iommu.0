Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CD1C433F5
	for <iommu@archiver.kernel.org>; Fri, 25 Feb 2022 05:26:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C7116068B;
	Fri, 25 Feb 2022 05:26:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NgoNTJBwGbBp; Fri, 25 Feb 2022 05:26:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5315560AE2;
	Fri, 25 Feb 2022 05:26:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07CB5C0033;
	Fri, 25 Feb 2022 05:26:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F170C001A
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 05:26:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 582E640270
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 05:26:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q1Hp49n7hgV9 for <iommu@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 05:26:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1431E400F4
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 05:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645766811; x=1677302811;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=emEj9f2p+/wpD1xkSTpzgY4vdBL3m1sDZweir9nvenM=;
 b=ZHDindqWlaSk8bfiSPdMYeyZzv3bUQLv3chjD36SgPwim2rOip1w4Udr
 h96GNpAsnx+EhYajxh40fO3CWpMwPShbLfBXNYrLXLiMkTg+84qDaeold
 rNCJmypPhLVwL9Jch41TBsIXxCJ/3JIEzCkT6sCunzT5wrhctZXbscZv4
 ccnsAN64rJq3UYMfW6poz2tXUVxgcydWc2ljnL0t4eSg8U0XO87xOzsKs
 Ow2Bste29/7hlTKOwqVrj2wsmEaSYJnn5XLJ9D3UHQK88JDvKd30h3LDP
 yqdriuEzIdcNj977g8fHFOwQahrTZubiGC9lacR9nAsnvGow1pzxxwoOD g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="239827442"
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; d="scan'208";a="239827442"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2022 21:26:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; d="scan'208";a="491869943"
Received: from tejas-system-product-name.iind.intel.com ([10.145.162.130])
 by orsmga003.jf.intel.com with ESMTP; 24 Feb 2022 21:26:48 -0800
From: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH V2] iommu/vt-d: Add RPLS to quirk list to skip TE disabling
Date: Fri, 25 Feb 2022 10:43:17 +0530
Message-Id: <20220225051317.152960-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Cc: Raviteja Goud Talla <ravitejax.goud.talla@intel.com>,
 stable@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>
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

The VT-d spec requires (10.4.4 Global Command Register, TE
field) that:

Hardware implementations supporting DMA draining must drain
any in-flight DMA read/write requests queued within the
Root-Complex before completing the translation enable
command and reflecting the status of the command through
the TES field in the Global Status register.

Unfortunately, some integrated graphic devices fail to do
so after some kind of power state transition. As the
result, the system might stuck in iommu_disable_translati
on(), waiting for the completion of TE transition.

This adds RPLS to a quirk list for those devices and skips
TE disabling if the qurik hits.

Fixes: b1012ca8dc4f9 "iommu/vt-d: Skip TE disabling on quirky gfx dedicated iommu"
Tested-by: Raviteja Goud Talla <ravitejax.goud.talla@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 92fea3fbbb11..be9487516617 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5743,7 +5743,7 @@ static void quirk_igfx_skip_te_disable(struct pci_dev *dev)
 	ver = (dev->device >> 8) & 0xff;
 	if (ver != 0x45 && ver != 0x46 && ver != 0x4c &&
 	    ver != 0x4e && ver != 0x8a && ver != 0x98 &&
-	    ver != 0x9a)
+	    ver != 0x9a && ver != 0xa7)
 		return;
 
 	if (risky_device(dev))
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
