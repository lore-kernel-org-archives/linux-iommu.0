Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AD5C954
	for <iommu@lists.linux.dev>; Thu,  9 Mar 2023 22:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678400293; x=1709936293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jgqfl9dl4fu6uMtJqZ6F6+dnX8IYDV3LSFTgul9NRy4=;
  b=OzSPsgzH0Sf9VW23R2sMXLUaP99ai5TyILSi80e7JguuEXA0reSbZXLP
   2eg/fdiQ7SlT5dlnpJmhApRrbFg1OgC2odKwGuFayijkKhVQj0dtb3ttw
   DyRO0GnLEsRGSx+QVrldnyS4tf/d/6EqzOADZqCOtkWNJAZFdQxwBNS5C
   silisUkBw39peYzYHV/om907rYaWL4oPNCzhqgFqIy8ljU7YQeLsfqH9e
   kp760l2rbFL5v3oK+NrW1XVFdt4++VUt+ofJjv/FCFSccwzUt7nIOHWFL
   Dj9c/ad4LqI1O35ortVxDNGdEthhztEiP1OZaPqKwD1MEAOzAo5QNH4V+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="364235247"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="364235247"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 14:18:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="707788852"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="707788852"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by orsmga008.jf.intel.com with ESMTP; 09 Mar 2023 14:18:09 -0800
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
	Tony Luck <tony.luck@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v5 5/7] iommu/sva: Use GFP_KERNEL for pasid allocation
Date: Thu,  9 Mar 2023 14:21:57 -0800
Message-Id: <20230309222159.487826-7-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309222159.487826-1-jacob.jun.pan@linux.intel.com>
References: <20230309222159.487826-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We’re not using spinlock-protected IOASID allocation anymore, there’s
no need for GFP_ATOMIC.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu-sva.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index b75711bdbe97..bd6fb2a6df23 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -27,8 +27,8 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma
 		goto out;
 	}
 
-	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_ATOMIC);
-	if (ret < 0)
+	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
+	if (ret < min)
 		goto out;
 	mm->pasid = ret;
 	ret = 0;
-- 
2.25.1

