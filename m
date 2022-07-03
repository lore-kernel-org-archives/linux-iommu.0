Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDC723A4
	for <iommu@lists.linux.dev>; Sun,  3 Jul 2022 11:44:55 +0000 (UTC)
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
   nlqETD3P0SR0o1nm40Osn44JqgCB32r874UTupOKtUZsW4oCrV0VLUwW2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="280493811"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="280493811"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 04:44:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="566845111"
Received: from shbuild999.sh.intel.com ([10.239.146.138])
  by orsmga006.jf.intel.com with ESMTP; 03 Jul 2022 04:44:51 -0700
From: Feng Tang <feng.tang@intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	John Garry <john.garry@huawei.com>,
	iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@intel.com>
Subject: [PATCH v2] iommu/iova: change IOVA_MAG_SIZE to 127 to save memory
Date: Sun,  3 Jul 2022 19:44:50 +0800
Message-ID: <20220703114450.15184-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220703114450.RnWTfXQmLuXUYSUeYIP13G1yNyv36lk6_Fb-egPl0Hw@z>

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

