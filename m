Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBF11854
	for <iommu@lists.linux.dev>; Tue, 12 Jul 2022 00:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584825; x=1689120825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b1VeSJDIT9XeF1FzLfvrql3G8Neer6XxZf/wBpgqjdM=;
  b=PxAfizZL0RehlnxEvZPcsTKsQADYPi2gMnRfEuQCUo0SPbD8R/Wnf9Dz
   P6ViITFciGkIWFEw6WWnf94bc8EGlwMKXFHmMD0U8aSUgLwLOezT3aQqL
   Cuylr7XJPn5bGM7WhOLZHKqTM2/glmV/rU0dN9BIzrGQybsruAvlHLChK
   P/5D0b8/YzTq1TiLEcy5Wa+4FBNKXiO1efg22eUZY45wA4xrAnElYamDl
   rJw5TSXZQfJpiirJNCC7Ad6vU13e1Hr4lgthe+gVO+KgvgEfK5jPw7Ikm
   tpYlGDGttYVGVUgHryZY8jMOScrgz9oW7kr25a9VuBhSMxDRzlqmytkJO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="264589882"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="264589882"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445694"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:13:43 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/25] drm/i915: Remove unnecessary include
Date: Tue, 12 Jul 2022 08:08:47 +0800
Message-Id: <20220712000908.3431936-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
References: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel-iommu.h is not needed in drm/i915 anymore. Remove its include.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Link: https://lore.kernel.org/r/20220514014322.2927339-5-baolu.lu@linux.intel.com
---
 drivers/gpu/drm/i915/display/intel_display.c   | 1 -
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 806d50b302ab..493421759afa 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -27,7 +27,6 @@
 #include <acpi/video.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
-#include <linux/intel-iommu.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/dma-resv.h>
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 30fe847c6664..193c7c83c70f 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -6,7 +6,6 @@
 
 #include <linux/dma-resv.h>
 #include <linux/highmem.h>
-#include <linux/intel-iommu.h>
 #include <linux/sync_file.h>
 #include <linux/uaccess.h>
 
-- 
2.25.1

