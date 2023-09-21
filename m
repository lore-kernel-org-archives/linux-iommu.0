Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B51567D
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 07:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695282750; x=1726818750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QCYSdfSXFxQ7WaALFaYm4jsUT2kSUGMBFqo7HP5RmjU=;
  b=Q041FPT45I2g/oGBBfzOJ6Ky3+Jun+lZXjXUK8LwBswn2WlaZIzP+07o
   W7TYgFetTofjehKdVLG1wMh1h02YsUOVWoueAz4G1VKB9Q0lIuGq36Kku
   WIvfa9tu+BEay4mFNML1mJP9UbjX6dLWr6aaVg8xzqoKWUavdSQY0FGCJ
   88YwTfzcIMy3jeNJtbWd4khX/Xef5ED/iUzRxvr5vCjzDI1fMG0Ii3P7n
   MVYb+WUidLyaXkyDPOY+rWoDDqtESKyGxDc3wgAp5/WuVNILQ9nYYlY0c
   MNJclNP9YKpGmWhdWePIyBNzeyWN+J/NyuJt2Rn8jJA6DBZr9DDMauPEt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359832887"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="359832887"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:52:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723649546"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="723649546"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2023 00:52:13 -0700
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
Subject: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on kernel-managed domains
Date: Thu, 21 Sep 2023 00:51:29 -0700
Message-Id: <20230921075138.124099-9-yi.l.liu@intel.com>
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

Now enforce_cache_coherency and msi_cookie are kernel-managed hwpt things.
So, they should be only setup on kernel-managed domains. If the attaching
domain is a user-managed domain, redirect the hwpt to hwpt->parent to do
it correctly.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c       | 4 ++++
 drivers/iommu/iommufd/hw_pagetable.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index eb120f70a3e3..104dd061a2a3 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -305,12 +305,16 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 	 * domain after request_irq(). If it is not done interrupts will not
 	 * work on this domain.
 	 *
+	 * Note: always set up a msi_cookie on a kernel-manage hw_pagetable.
+	 *
 	 * FIXME: This is conceptually broken for iommufd since we want to allow
 	 * userspace to change the domains, eg switch from an identity IOAS to a
 	 * DMA IOAS. There is currently no way to create a MSI window that
 	 * matches what the IRQ layer actually expects in a newly created
 	 * domain.
 	 */
+	if (hwpt->user_managed)
+		hwpt = hwpt->parent;
 	if (sw_msi_start != PHYS_ADDR_MAX && !hwpt->msi_cookie) {
 		rc = iommu_get_msi_cookie(hwpt->domain, sw_msi_start);
 		if (rc)
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index dc3e11a23acf..90fd65859e28 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -152,6 +152,10 @@ iommufd_user_managed_hwpt_alloc(struct iommufd_ctx *ictx,
 
 int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
 {
+	/* Always enforce cache coherency on a kernel-managed hw_pagetable */
+	if (hwpt->user_managed)
+		hwpt = hwpt->parent;
+
 	if (hwpt->enforce_cache_coherency)
 		return 0;
 
-- 
2.34.1

