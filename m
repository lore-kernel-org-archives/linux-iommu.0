Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE94D51B
	for <iommu@lists.linux.dev>; Wed,  1 Mar 2023 23:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677714830; x=1709250830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YXcGy2lNR54ka+fDJ7zxybnMYPAsdHTpyfx4lUlp62A=;
  b=FO5PF2Rre87MAkyp6rUusolwdJPf7xPT4BK55sJ05o9fi+ysrrvy4H/0
   e+HtxSi4o3EOBvfPjqLFBehKqQk6ECPe8jXmEckoXTBNy3NfoRD2h3rvx
   vj0wCS5AXoSCsC4/KCLp0/4ABDSESLJeiZv77rByqb+sR3yndEqv19iZX
   jzrGU4C/tJ1XYQXXGGVNVITSbiyJahU4bidXBuVhHu4q+r02wULbXH+KK
   IJYOnPUQQuxdSHNnz1WlvHHStLyi5PX/gtfxCducCXtyK56QkKeGQCc9x
   kBkNNcnSfjZiLol+E0eGQW2TZYjcv+lSi3Z3T0/ZoXF8jJFQ0sfckIm0O
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="397127662"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="397127662"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:53:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="1003880336"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="1003880336"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga005.fm.intel.com with ESMTP; 01 Mar 2023 15:53:03 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	X86 Kernel <x86@kernel.org>,
	bp@alien8.de,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	corbet@lwn.net,
	vkoul@kernel.org,
	dmaengine@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: "Robin Murphy" <robin.murphy@arm.com>,
	"Will Deacon" <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 4/6] iommu/sva: Use GFP_KERNEL for pasid allocation
Date: Wed,  1 Mar 2023 15:56:44 -0800
Message-Id: <20230301235646.2692846-5-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We’re not using  spinlock-protected IOASID allocation anymore, there’s
no need for GFP_ATOMIC.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu-sva.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 297852ae5e7c..8c92a145e15d 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -29,7 +29,7 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma
 		goto out;
 	}
 
-	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_ATOMIC);
+	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
 	if (ret < min)
 		goto out;
 	mm->pasid = ret;
-- 
2.25.1

