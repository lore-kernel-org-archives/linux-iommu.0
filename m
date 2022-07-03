Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF20CCA473
	for <iommu@archiver.kernel.org>; Sun,  3 Jul 2022 11:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1174982E22;
	Sun,  3 Jul 2022 11:45:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1174982E22
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PhhfihVY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EKCB9UrqRc7L; Sun,  3 Jul 2022 11:44:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0487882E1A;
	Sun,  3 Jul 2022 11:44:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0487882E1A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C46CEC0032;
	Sun,  3 Jul 2022 11:44:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58FF8C002D
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 11:44:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1E55740494
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 11:44:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1E55740494
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=PhhfihVY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8pSBRCQ5_eVJ for <iommu@lists.linux-foundation.org>;
 Sun,  3 Jul 2022 11:44:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ACC1540017
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ACC1540017
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 11:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656848695; x=1688384695;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=07o60MGLxH61MHNXX684N0GNY74w8HhuBYdXzf7xTYI=;
 b=PhhfihVYafk3jnc3tpOKRAl5X+g0+yfTYKEygu/nXgmWZX7k+A1BPC1O
 6Xeyxt/veUl7Mnor0jBTnYJzn1+QGHh+ac3V11oU+armeJUeB1G0kgyz6
 K9Mpg8Lg/s3yOcaG6Tt2W2VrvpJN5XLuW1CFw6WbgTKLUDMSWQZGC0uUr
 orVSHnW0IpX9RCKBw+vySfDW8M0efRQp7WHgyRGj1CFyrppTsSVhJbVyx
 8f9rumgFywlCYDSMsqcLAWKK3LAt1l6LVDzCOlooZRoLemVFXcveRrScZ
 nlqETD3P0SR0o1nm40Osn44JqgCB32r874UTupOKtUZsW4oCrV0VLUwW2 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="344620056"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; d="scan'208";a="344620056"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2022 04:44:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; d="scan'208";a="566845111"
Received: from shbuild999.sh.intel.com ([10.239.146.138])
 by orsmga006.jf.intel.com with ESMTP; 03 Jul 2022 04:44:51 -0700
From: Feng Tang <feng.tang@intel.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, John Garry <john.garry@huawei.com>,
 iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@linux.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2] iommu/iova: change IOVA_MAG_SIZE to 127 to save memory
Date: Sun,  3 Jul 2022 19:44:50 +0800
Message-Id: <20220703114450.15184-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Cc: linux-mm@kvack.org, Feng Tang <feng.tang@intel.com>,
 linux-kernel@vger.kernel.org
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

kmalloc will round up the request size to power of 2, and current
iova_magazine's size is 1032 (1024+8) bytes, so each instance
allocated will get 2048 bytes from kmalloc, causing around 1KB
waste.

Change IOVA_MAG_SIZE from 128 to 127 to make size of 'iova_magazine'
1024 bytes so that no memory will be wasted.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
---
Changelog:
  
  since v1:
    * update commit log per the comments from Robin and John 

 drivers/iommu/iova.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index db77aa675145b..27634ddd9b904 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -614,7 +614,12 @@ EXPORT_SYMBOL_GPL(reserve_iova);
  * dynamic size tuning described in the paper.
  */
 
-#define IOVA_MAG_SIZE 128
+/*
+ * As kmalloc's buffer size is fixed to power of 2, 127 is chosen to
+ * assure size of 'iova_magazine' to be 1024 bytes, so that no memory
+ * will be wasted.
+ */
+#define IOVA_MAG_SIZE 127
 #define MAX_GLOBAL_MAGS 32	/* magazines per bin */
 
 struct iova_magazine {
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
