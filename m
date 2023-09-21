Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184C85229
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 07:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695282731; x=1726818731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fZEXWeTeOBrejODuS6erDuW9xhi+ilN63E3t7GSB+Dc=;
  b=N/2YQ5HpmqkcYPnTlNr64k1bWmzUuWlrvyJbzqYEreAFM+rTq1gyOIYG
   w1I1VnRTsRcRJkb3XQYyuFoKDgr6CsP1OZ0C7ZSrEJjTsNyx1QvNtqomY
   h/73s9zgBUjphBLfHNz5HIKR23/pDv2UmKtQBIrHsv7BWFfe3/Ygm45wf
   Y0LX0OoRHHcXUDhFyaJ5Vlk+WZcOnbD0uoWpLCkU7INTBjUhbhUYWZWbB
   SoISNIKESc9HVvK9+lEJkg5L22S7U3h6u8WidgNTLPLNNijfStSd/Beqr
   s5aLrEAhK3Xlj4KuIsfYVGvvlTkME/iztaNfwRujXNSc+9qOTr0qq3v2M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359832826"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="359832826"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:52:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723649502"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="723649502"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2023 00:52:09 -0700
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
	linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com
Subject: [PATCH v4 03/17] iommufd: Unite all kernel-managed members into a struct
Date: Thu, 21 Sep 2023 00:51:24 -0700
Message-Id: <20230921075138.124099-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075138.124099-1-yi.l.liu@intel.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

The struct iommufd_hw_pagetable has been representing a kernel-managed
HWPT, yet soon will be reused to represent a user-managed HWPT. These
two types of HWPTs has the same IOMMUFD object type and an iommu_domain
object, but have quite different attributes/members.

Add a union in struct iommufd_hw_pagetable and group all the existing
kernel-managed members. One of the following patches will add another
struct for user-managed members.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 3064997a0181..947a797536e3 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -231,13 +231,18 @@ int iommufd_vfio_ioas(struct iommufd_ucmd *ucmd);
  */
 struct iommufd_hw_pagetable {
 	struct iommufd_object obj;
-	struct iommufd_ioas *ioas;
 	struct iommu_domain *domain;
-	bool auto_domain : 1;
-	bool enforce_cache_coherency : 1;
-	bool msi_cookie : 1;
-	/* Head at iommufd_ioas::hwpt_list */
-	struct list_head hwpt_item;
+
+	union {
+		struct { /* kernel-managed */
+			struct iommufd_ioas *ioas;
+			bool auto_domain : 1;
+			bool enforce_cache_coherency : 1;
+			bool msi_cookie : 1;
+			/* Head at iommufd_ioas::hwpt_list */
+			struct list_head hwpt_item;
+		};
+	};
 };
 
 struct iommufd_hw_pagetable *
-- 
2.34.1

