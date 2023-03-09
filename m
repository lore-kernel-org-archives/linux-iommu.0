Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC482596
	for <iommu@lists.linux.dev>; Thu,  9 Mar 2023 08:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678349375; x=1709885375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ze+YqyOq2FcrfezTmpCROik4OQxGxrLylWyUGP+0lZs=;
  b=Q/yf2UoMj8mFIBZi3OLqPQ2Xm8Rx9W2ENxqn54Zz298hKS3nFP0EGLBd
   tvb7+kAUqXczLT4cIKf2V+RUE/Wjh4bY9QUTzp/M0d8/nxOe1aaPAysl6
   mf1Rq+57VURCk+x4bEbWTMiG7ZI4cOsoBrmALaVMTI0QTZrzGPyn22RDK
   xeYKTFGo7eo2Z7e4JUeNR22dNbpk8m3vVuQwvBwXEdxRXetipgYlH/ZOQ
   cDoTggkkIKMcqaK6XaKVtwrL20CE3SUII3DzD1WWzMEL6ddYFysS9bx2z
   QZqb5qvYVQ6bo/arduPjA1pF1cFEcoUdNCfoS2ZyU03HvLVf47wnb9pRH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364023073"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364023073"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787471382"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787471382"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2023 00:09:26 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com
Cc: cohuck@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	peterx@redhat.com,
	jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com,
	lulu@redhat.com,
	suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 05/12] iommufd/hw_pagetable: Do not populate user-managed hw_pagetables
Date: Thu,  9 Mar 2023 00:09:03 -0800
Message-Id: <20230309080910.607396-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309080910.607396-1-yi.l.liu@intel.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

A user-managed hw_pagetable does not need to get populated, since it is
managed by a guest OS. Move the iopt_table_add_domain and list_add_tail
calls into a helper, where the hwpt pointer will be redirected to its
hwpt->parent if it's available.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 16e92a1c150b..6e45ec0a66fa 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -43,6 +43,23 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
 	return 0;
 }
 
+static int iommufd_hw_pagetable_link_ioas(struct iommufd_hw_pagetable *hwpt)
+{
+	int rc;
+
+	if (hwpt->parent)
+		hwpt = hwpt->parent;
+
+	if (!list_empty(&hwpt->hwpt_item))
+		return 0;
+
+	rc = iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
+	if (rc)
+		return rc;
+	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
+	return 0;
+}
+
 /**
  * iommufd_hw_pagetable_alloc() - Get an iommu_domain for a device
  * @ictx: iommufd context
@@ -131,10 +148,9 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			goto out_unlock;
 	}
 
-	rc = iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
+	rc = iommufd_hw_pagetable_link_ioas(hwpt);
 	if (rc)
 		goto out_detach;
-	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
 
 	mutex_unlock(&idev->igroup->lock);
 	return hwpt;
-- 
2.34.1

