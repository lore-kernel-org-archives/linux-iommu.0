Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB77F
	for <iommu@lists.linux.dev>; Fri,  7 Jul 2023 01:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688693712; x=1720229712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eBd7C5+K4RvrvJS52RC+bdvbj/BI96OctjrNMXfnImA=;
  b=nGBR/EbTzL/yTpcBukdROfD2zoHTn/wUCgYJkjQnggTkE820TsLdBEYm
   n22giaZIetQb3TVEs6Ln+gTWZK7GKAQmgPuqhnDaF7i4Hp/MlFozv62K1
   kb7/nGvJ2FR+0LVoNhc+9kA74ufvmgUUb/dNtYFBpqrfiUsIoZn57rwuO
   ZodWQUY4ZEcRxxJfP72E5gg7IUZXNC3cKVq3HnJbebmofsoGH8rIjE0cx
   WpvCmjdzaP0YJYcPnw5bkiZZV2kGqqrY1XzgEbPS83jEc7SfM5X3IL2bG
   sjzhdJFLw47ZcHYuXeC+noTXCSH5axoSEEamm+stI6wiTKRU0gxeIybBY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="429832289"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="429832289"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 18:35:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="893791346"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="893791346"
Received: from fengj-mobl.ccr.corp.intel.com (HELO tinazhan-desk1.www.tendawifi.com) ([10.254.210.124])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 18:35:08 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [RFC PATCH 4/6] mm: Add iommu_mm field to mm_struct
Date: Fri,  7 Jul 2023 09:34:39 +0800
Message-Id: <20230707013441.365583-5-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707013441.365583-1-tina.zhang@intel.com>
References: <20230707013441.365583-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iommu_mm field has all the information needed for managing sva domain
1:1 with mm pasid. Add it to the mm_struct as the sva-related field and
use default_iommu_mm to initialize init_mm pasid.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/linux/mm_types.h | 2 ++
 mm/init-mm.c             | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 306a3d1a0fa65..bb00caa078335 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -581,6 +581,7 @@ struct mm_cid {
 #endif
 
 struct kioctx_table;
+struct iommu_mm_data;
 struct mm_struct {
 	struct {
 		struct maple_tree mm_mt;
@@ -773,6 +774,7 @@ struct mm_struct {
 
 #ifdef CONFIG_IOMMU_SVA
 		u32 pasid;
+		struct iommu_mm_data *iommu_mm;
 #endif
 #ifdef CONFIG_KSM
 		/*
diff --git a/mm/init-mm.c b/mm/init-mm.c
index efa97b57acfd8..c43b7d0347312 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -44,6 +44,7 @@ struct mm_struct init_mm = {
 	.cpu_bitmap	= CPU_BITS_NONE,
 #ifdef CONFIG_IOMMU_SVA
 	.pasid		= IOMMU_PASID_INVALID,
+	.iommu_mm       = &default_iommu_mm,
 #endif
 	INIT_MM_CONTEXT(init_mm)
 };
-- 
2.34.1

