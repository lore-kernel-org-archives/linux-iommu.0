Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539938BE7
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 03:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYd9GTkw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697512886; x=1729048886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZhmxoShuHLiM8DBi/fzm6G4kHK6SDXHp234E7569BMQ=;
  b=VYd9GTkwakgTet/PqtlaCUawQ9FLonUV23Us/ZTUMO8PyQh16q6YO2V5
   C1VV9OoUORl8Dz8Yi7WMzJETfDK86anDJzzs17SALkmK9/YHlq7e9M2sF
   Uglyq0bwH0hCeM0j6mI/LcwrG1dgZicRh3X9ECVLTnKAXGY0aGixUob59
   D9BseVgCn08L2fTl/qSJUqkRq3MCYIK/5f+zq8dYTfthKRXzAZrNynGpx
   HCeuE1inmbt96OkaoTxUqpKBTqkDnIJ67G7SzDLRS+UVlOrQ/1eXWKs3d
   k7aZ2SgWGjg1D4qaSb0biZiZeKW2YTFISnhzJxIIMjkyfK63/xODjZAMT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="389560853"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="389560853"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 20:21:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="826270060"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="826270060"
Received: from sqa-gate.sh.intel.com (HELO spr-2s5.tsp.org) ([10.239.48.212])
  by fmsmga004.fm.intel.com with ESMTP; 16 Oct 2023 20:21:23 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [RFC PATCH 06/12] iommu: Add mmu_notifier to sva domain
Date: Tue, 17 Oct 2023 11:20:39 +0800
Message-Id: <20231017032045.114868-8-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231017032045.114868-1-tina.zhang@intel.com>
References: <20231017032045.114868-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices attached to shared virtual addressing (SVA) domain are allowed to
use the same virtual addresses with processor, and this functionality is
called shared virtual memory. When shared virtual memory is being used,
it's the sva domain's responsibility to keep device TLB cache and the CPU
cache in sync. Hence add mmu_notifier to sva domain.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/linux/iommu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 19b5ae2303ff..afb566230427 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -7,6 +7,7 @@
 #ifndef __LINUX_IOMMU_H
 #define __LINUX_IOMMU_H
 
+#include <linux/mmu_notifier.h>
 #include <linux/scatterlist.h>
 #include <linux/device.h>
 #include <linux/types.h>
@@ -114,6 +115,7 @@ struct iommu_domain {
 			 * protected by iommu_sva_lock.
 			 */
 			struct list_head next;
+			struct mmu_notifier notifier;
 		};
 	};
 };
-- 
2.39.3

