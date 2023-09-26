Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2287E12B97
	for <iommu@lists.linux.dev>; Tue, 26 Sep 2023 09:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695720417; x=1727256417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZZ706XgBqFXI4No2/MKm+Way87feEQ56EhlqdiEeakk=;
  b=X6Ti0+Kipc6RkfDLzUteTSeBez6dvfgMpf/tMfgXxjLL/UawwCuOECC1
   yibAVTogmuTcR0qLYet+m260HCkbjgIaIKUfqoHYW/z8ylZxztfmLTSBY
   ai0aXjRHsLpk+nWoUrNZtKI7cUmES6C4GQG/bOTKCfZO1OUzhZfL1+aUd
   2SFRVIzqw4y87CDbOz8mAAh/NY/oBx8sYFaYtPNnsOllcn8lB3Y5AFgzR
   W+hSPZczQ0+L9gfpnWcAs2t7PdUuGVFmmvWxkeT+MIePL76qVz1E4v1WT
   6b7AueYYaA4ZdesXuvdIfTH4tm9j+MQRGxDIzji+THx6+D62gWS+uMwdW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360905339"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="360905339"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 02:26:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1079642520"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="1079642520"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga005.fm.intel.com with ESMTP; 26 Sep 2023 02:26:54 -0700
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
Subject: [RFC 1/8] iommu: Introduce a replace API for device pasid
Date: Tue, 26 Sep 2023 02:26:44 -0700
Message-Id: <20230926092651.17041-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926092651.17041-1-yi.l.liu@intel.com>
References: <20230926092651.17041-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

Provide a high-level API to allow replacements of one domain with
another for specific pasid of a device. This is similar to
iommu_group_replace_domain() and it is also expected to be used
only by IOMMUFD.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu-priv.h |  2 ++
 drivers/iommu/iommu.c      | 73 ++++++++++++++++++++++++++++++--------
 2 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index 2024a2313348..5c32637f6325 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -19,6 +19,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 
 int iommu_group_replace_domain(struct iommu_group *group,
 			       struct iommu_domain *new_domain);
+int iommu_replace_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid);
 
 int iommu_device_register_bus(struct iommu_device *iommu,
 			      const struct iommu_ops *ops, struct bus_type *bus,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e53c9e659ae6..b47581c7b1c6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3382,6 +3382,27 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
 	}
 }
 
+static int __iommu_group_attach_pasid(struct iommu_domain *domain,
+				      struct iommu_group *group, ioasid_t pasid)
+{
+	void *curr;
+	int ret;
+
+	lockdep_assert_held(&group->mutex);
+
+	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
+	if (curr)
+		return xa_err(curr) ? : -EBUSY;
+
+	ret = __iommu_set_group_pasid(domain, group, pasid);
+	if (ret) {
+		__iommu_remove_group_pasid(group, pasid);
+		xa_erase(&group->pasid_array, pasid);
+	}
+
+	return ret;
+}
+
 /*
  * iommu_attach_device_pasid() - Attach a domain to pasid of device
  * @domain: the iommu domain.
@@ -3394,7 +3415,6 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 			      struct device *dev, ioasid_t pasid)
 {
 	struct iommu_group *group;
-	void *curr;
 	int ret;
 
 	if (!domain->ops->set_dev_pasid)
@@ -3405,19 +3425,9 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 		return -ENODEV;
 
 	mutex_lock(&group->mutex);
-	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
-	if (curr) {
-		ret = xa_err(curr) ? : -EBUSY;
-		goto out_unlock;
-	}
-
-	ret = __iommu_set_group_pasid(domain, group, pasid);
-	if (ret) {
-		__iommu_remove_group_pasid(group, pasid);
-		xa_erase(&group->pasid_array, pasid);
-	}
-out_unlock:
+	ret = __iommu_group_attach_pasid(domain, group, pasid);
 	mutex_unlock(&group->mutex);
+
 	iommu_group_put(group);
 
 	return ret;
@@ -3433,8 +3443,8 @@ EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
  * The @domain must have been attached to @pasid of the @dev with
  * iommu_attach_device_pasid().
  */
-void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
-			       ioasid_t pasid)
+void iommu_detach_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid)
 {
 	struct iommu_group *group = iommu_group_get(dev);
 
@@ -3447,6 +3457,39 @@ void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(iommu_detach_device_pasid);
 
+/**
+ * iommu_replace_device_pasid - replace the domain that a pasid is attached to
+ * @domain: new IOMMU domain to replace with
+ * @dev: the physical device
+ * @pasid: pasid that will be attached to the new domain
+ *
+ * This API allows the pasid to switch domains. Return 0 on success, or an
+ * error. The pasid will roll back to use the old domain if failure. The
+ * caller could call iommu_detach_device_pasid() before free the old domain
+ * in order to avoid use-after-free case.
+ */
+int iommu_replace_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid)
+{
+	struct iommu_group *group = dev->iommu_group;
+	int ret;
+
+	if (!domain)
+		return -EINVAL;
+
+	if (!group)
+		return -ENODEV;
+
+	mutex_lock(&group->mutex);
+	__iommu_remove_group_pasid(group, pasid);
+	xa_erase(&group->pasid_array, pasid);
+	ret = __iommu_group_attach_pasid(domain, group, pasid);
+	mutex_unlock(&group->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(iommu_replace_device_pasid, IOMMUFD_INTERNAL);
+
 /*
  * iommu_get_domain_for_dev_pasid() - Retrieve domain for @pasid of @dev
  * @dev: the queried device
-- 
2.34.1

