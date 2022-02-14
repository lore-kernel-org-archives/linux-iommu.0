Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D38C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 02:59:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3D3C04012A;
	Mon, 14 Feb 2022 02:59:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TLnGzfsBRubZ; Mon, 14 Feb 2022 02:59:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E061140498;
	Mon, 14 Feb 2022 02:59:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA3D1C001A;
	Mon, 14 Feb 2022 02:59:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 307DCC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 02:59:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 074DF40493
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 02:59:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id txV311ZVO8dl for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 02:59:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5A12140491
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 02:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644807541; x=1676343541;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WEno40C7jLT1PSOtcxME8RVxUTyrL0WdeC6F3m6ZqJM=;
 b=Id+zggKw6z+c9xh2UZBSdgYeHXPS1isgk0dq63jwMv/VTmETLVyDgpyT
 aRABAo9MLYbzHU/b33AfTjDQI+YWWp+R46jcPfHvIOYmQaiZVCyztdjRM
 ky7hURm5Yi18Lx6jg6+duupHygZzg/AdBt7i1Wfs3MX4T8VDA+zPCpYgQ
 7qOSOZR+U3JdCWqEstfY5BXEyeC4+2jlmfH0BQ7Ti41KrmEAq0vfHUs/q
 Z9uCt9KioFbAUpRiMsIwf7jipUEiiWWGgml9pGiA11A70ysMa3dxuDkPk
 7wVx36H/bQ82FgjoFpeyEHvCfb0IrEhGXuDUT0QywhDLj0Kg93nchCKZX Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="230637541"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; d="scan'208";a="230637541"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2022 18:59:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; d="scan'208";a="501515031"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga002.jf.intel.com with ESMTP; 13 Feb 2022 18:58:58 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 09/11] iommu/vt-d: Remove commented code
Date: Mon, 14 Feb 2022 10:57:02 +0800
Message-Id: <20220214025704.3184654-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

This removes unnecessary commented code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d7fac0a1761d..fb17ed8c08f3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1407,15 +1407,7 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
 	default:
 		BUG();
 	}
-	/* Note: set drain read/write */
-#if 0
-	/*
-	 * This is probably to be super secure.. Looks like we can
-	 * ignore it without any impact.
-	 */
-	if (cap_read_drain(iommu->cap))
-		val |= DMA_TLB_READ_DRAIN;
-#endif
+
 	if (cap_write_drain(iommu->cap))
 		val |= DMA_TLB_WRITE_DRAIN;
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
