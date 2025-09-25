Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA577C8CE
	for <iommu@lists.linux.dev>; Thu, 25 Sep 2025 05:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758779265; cv=none; b=nZ+NMo78jnwS4c51VEBFf3mQrgXH4IghMRpf65F+SHPW6Pc3UVHGj5AsnthF2V1W3/np6o+FI26CJd0n4BjG1DpzTrzHvNxS1l8bDO5aTMnuq3kGrnAGor/NZnmP6h3ZCJc0fCxasv0A1ufht8Ivva5hCr3J9JOfDcuMhMFhwdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758779265; c=relaxed/simple;
	bh=zTSi3i9BL2mP6mHZXPYtuptLSyCzxbzbfUPN1mJKiBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yr2raYURV0GUqxlcU0FVgjIprsv9SWmC1BKCsL6kGrpBjYW+PdgdfY1Ndi/+QqFdWaS5ZHhlXI+GXYIT6w0Bk9rNaDFq2q+SiTV4xK3JLJqQrzOzcbXp/YG24efLw/H7ZcU+F6tJ/Bec3JeCHhlayna2zgYHvgKqpuA/31qTdzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kjmKvCHU; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kjmKvCHU"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758779255; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=NuKe++4ZjnkWtf1qE2uUfxHMxozkigg7GRqvsNT8q5Q=;
	b=kjmKvCHUhgdY9VsEyraz0nDNmMMSkuU7dYSh0gpJ2z5V4BBigCvXq9smbpQP0qlUBLl3M1c0/sJEwZUe4E27bnAggaqXTZBD9mDXQq5bDwAZod1Yp5VUoyaF66mAlR88wxJzS24Ee6qBftd/i2a6IQmfOusc7RN/jwqQAKmRwUY=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WomRLH8_1758779250 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 13:47:34 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev
Subject: [PATCH v5] iommu: Fix iommu selftest running test mock domain fail
Date: Thu, 25 Sep 2025 13:47:30 +0800
Message-ID: <20250925054730.3877-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When intel_iommu=on is enabled and the iommu selftests are executed,
we observed multiple test case failures. Our investigation revealed
that both the Intel iommu driver and the mock iommu driver registered
iommu_device instances with fwnode=NULL, and both were added to the
iommu_device_list. Later, when the mock iommu driver attempted to
create a device, iommu_init_device attempted to retrieve the iommu_ops
by searching the iommu_device_list using the provided fwnode
(which was NULL).
Since the iommu_device registered by the Intel iommu driver appeared
earlier in the list, it was matched first instead of the mock iommu
driver's iommu_device. This ultimately caused probe_device to fail.

Fix this by alloc a software fwnode for mock iommu driver's iommu_device,
and set it to the device which mock iommu driver created.

Test by "make -C toosl/testing/selftests TARGETS=iommu run_tests":
PASSED: 229 / 229 tests passed.

In addition, this issue is also can be found on amd platform, and
also tested on a amd machine.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Tested-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
Changes from v4 to v5:
- Remove error print and set iommu_fwnode NULL when fwnode_create_software_node()
return fail.
- Add the rb tag from Lu Baolu, thanks.

Changes from v3 to v4:
- Remove iommu_mock_device_abort(), rename iommu_mock_device_init() to
iommu_mock_device_add(), and fold device_add() into iommu_mock_device_add().

Changes from v2 to v3:
- Add export symbol iommu_mock_device_init() and iommu_mock_device_abort()
in iommu.c instead of export iommu_probe_device_lock and iommu_fwspec_free().

Changes from v1 to v2:
- Remove print when iommu_fwspec_init() fail.
 drivers/iommu/iommu-priv.h       |  2 ++
 drivers/iommu/iommu.c            | 26 ++++++++++++++++++++++++++
 drivers/iommu/iommufd/selftest.c |  2 +-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index e236b932e766..c95394cd03a7 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -37,6 +37,8 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
 				 const struct bus_type *bus,
 				 struct notifier_block *nb);
 
+int iommu_mock_device_add(struct device *dev, struct iommu_device *iommu);
+
 struct iommu_attach_handle *iommu_attach_handle_get(struct iommu_group *group,
 						    ioasid_t pasid,
 						    unsigned int type);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 060ebe330ee1..ddf398d8bcf9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -304,6 +304,7 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
 				 struct notifier_block *nb)
 {
 	bus_unregister_notifier(bus, nb);
+	fwnode_remove_software_node(iommu->fwnode);
 	iommu_device_unregister(iommu);
 }
 EXPORT_SYMBOL_GPL(iommu_device_unregister_bus);
@@ -326,6 +327,12 @@ int iommu_device_register_bus(struct iommu_device *iommu,
 	if (err)
 		return err;
 
+	iommu->fwnode = fwnode_create_software_node(NULL, NULL);
+	if (IS_ERR(iommu->fwnode)) {
+		bus_unregister_notifier(bus, nb);
+		return err;
+	}
+
 	spin_lock(&iommu_device_lock);
 	list_add_tail(&iommu->list, &iommu_device_list);
 	spin_unlock(&iommu_device_lock);
@@ -335,9 +342,28 @@ int iommu_device_register_bus(struct iommu_device *iommu,
 		iommu_device_unregister_bus(iommu, bus, nb);
 		return err;
 	}
+	WRITE_ONCE(iommu->ready, true);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_device_register_bus);
+
+int iommu_mock_device_add(struct device *dev, struct iommu_device *iommu)
+{
+	int rc;
+
+	mutex_lock(&iommu_probe_device_lock);
+	rc = iommu_fwspec_init(dev, iommu->fwnode);
+	mutex_unlock(&iommu_probe_device_lock);
+
+	if (rc)
+		return rc;
+
+	rc = device_add(dev);
+	if (rc)
+		iommu_fwspec_free(dev);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(iommu_mock_device_add);
 #endif
 
 static struct dev_iommu *dev_iommu_get(struct device *dev)
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 61686603c769..de178827a078 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1126,7 +1126,7 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 		goto err_put;
 	}
 
-	rc = device_add(&mdev->dev);
+	rc = iommu_mock_device_add(&mdev->dev, &mock_iommu.iommu_dev);
 	if (rc)
 		goto err_put;
 	return mdev;
-- 
2.43.0

