Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031A88483
	for <iommu@lists.linux.dev>; Tue,  3 Jan 2023 16:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672763369; x=1704299369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YGmCRw23hc83hc1Hm9zD3o3OuJY1E8OGzBfqIp9cLms=;
  b=K1S6kvauGfXvyq9j/AEUpOdxQL27xEqZ+E3Pcq0UDHzAY357P4ZmBqVp
   zlJHLQxmOWJF5FINAgu/VP0Ee5vFwNaj8JTT+gW93DKBuhrukeifWXWN7
   qBptZuG/5C33lRqo/EUkvSFOh6Q/VbI1W0PDiwupL4LTnoJ1pwDAPeScr
   xqw9F9xmVpKZ+snW4OBNB/rtZe9jUazQZwzRBydMoKA4ez+K3YreDC7y2
   CZ+cZf65E+e8Z3GG0lhOmwwxr+BB/Yx24mdaTNRjw2zR19QGK5RgSKmOs
   5296gVFHVxNIahhQhyXiA1jYcXjzBIr4rWKKjN+/bKOP7lsrTT8hgqJF9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="320406127"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="320406127"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 08:29:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="983608221"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="983608221"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jan 2023 08:29:25 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	devejiang
Cc: "Fenghua Yu" <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Tony Zhu <tony.zhu@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Subject: [PATCH 08/17] iommu: expose iommu_sva_find() to common header
Date: Tue,  3 Jan 2023 08:29:11 -0800
Message-Id: <20230103162920.1569002-9-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230103162920.1569002-1-fenghua.yu@intel.com>
References: <20230103162920.1569002-1-fenghua.yu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Jiang <dave.jiang@intel.com>

Move iommu_sva_find() prototype to global header from local header in order
to allow drivers to call the function. Used by idxd driver to find the mm
from device reported PASID. The symbol is already exported.

Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev
---
 drivers/iommu/iommu-sva.h | 1 -
 include/linux/iommu.h     | 7 +++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-sva.h b/drivers/iommu/iommu-sva.h
index 7215a761b962..102eae1817a2 100644
--- a/drivers/iommu/iommu-sva.h
+++ b/drivers/iommu/iommu-sva.h
@@ -9,7 +9,6 @@
 #include <linux/mm_types.h>
 
 int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
-struct mm_struct *iommu_sva_find(ioasid_t pasid);
 
 /* I/O Page fault */
 struct device;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 46e1347bfa22..7db16ca3f519 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -704,6 +704,8 @@ void iommu_release_device(struct device *dev);
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
 
+struct mm_struct *iommu_sva_find(ioasid_t pasid);
+
 int iommu_device_use_default_domain(struct device *dev);
 void iommu_device_unuse_default_domain(struct device *dev);
 
@@ -1042,6 +1044,11 @@ iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 	return -ENODEV;
 }
 
+static inline struct mm_struct *iommu_sva_find(ioasid_t pasid)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
 {
 	return NULL;
-- 
2.32.0

