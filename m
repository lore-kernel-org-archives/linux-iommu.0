Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C21C433F5
	for <iommu@archiver.kernel.org>; Wed,  2 Mar 2022 04:46:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34187827DD;
	Wed,  2 Mar 2022 04:46:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uRXu9hKz1z1q; Wed,  2 Mar 2022 04:46:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E7E8881426;
	Wed,  2 Mar 2022 04:46:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE4F9C0082;
	Wed,  2 Mar 2022 04:46:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBC1FC000B
 for <iommu@lists.linux-foundation.org>; Wed,  2 Mar 2022 04:46:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E4E6E4010C
 for <iommu@lists.linux-foundation.org>; Wed,  2 Mar 2022 04:46:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xQ63oc5CJScD for <iommu@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 04:46:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E135D400A4
 for <iommu@lists.linux-foundation.org>; Wed,  2 Mar 2022 04:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646196386; x=1677732386;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VieNnhN0rOTRySts1AK/9zNkaXZXXmCyvQbVecMx2V8=;
 b=fWW5kwvRl+G3rTVqUULvS11bf8pKApkzcNog1XmZQV+U8pL+FXXJPVWG
 isb5WCp6t/85bUSJ0KTpgt42PUnoYdoX20jMaJgd01W7UeZYywt8f14ZN
 8iBURmgCHf/U/vVER8seJDcxOAM6zPOSV63baGq1uCWchkYXjKW6RODkZ
 teQVxhaQBNmxfhmLV5D/uZ1ZkApF3sXw46xPL1PnniqANmRchFLmfEKg7
 t4hrnHMGrCbkz0lZA0PgZavvSe6vqko36lTH8LaV7uxhJ94ajP7OXkzxB
 WKNVLp8i4mVl2nVAWL2Ak+l21XQ4Mv1LxxdLP5NN9i04hFj2TxEif7cNV w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="316525080"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; d="scan'208";a="316525080"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2022 20:46:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; d="scan'208";a="535234284"
Received: from tejas-system-product-name.iind.intel.com ([10.145.162.130])
 by orsmga007.jf.intel.com with ESMTP; 01 Mar 2022 20:46:21 -0800
From: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
To: intel-gfx@lists.freedesktop.org
Subject: [PATCH] iommu/vt-d: Add RPLS to quirk list to skip TE disabling
Date: Wed,  2 Mar 2022 10:02:56 +0530
Message-Id: <20220302043256.191529-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org,
 Raviteja Goud Talla <ravitejax.goud.talla@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
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

Link: https://gitlab.freedesktop.org/drm/intel/-/issues/4898
Tested-by: Raviteja Goud Talla <ravitejax.goud.talla@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 639e4438827e..bd6dac90a948 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5741,7 +5741,7 @@ static void quirk_igfx_skip_te_disable(struct pci_dev *dev)
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
