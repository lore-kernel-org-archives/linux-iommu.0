Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2638927FB03
	for <iommu@lists.linux.dev>; Wed, 24 Sep 2025 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699857; cv=none; b=mItn9arCbG0e/wqE3r4fpoPIZEWSScHMcuqUj/iYJJIRrIeFwcbbe6bQoNx2/OLwzbtzTRyrFsrXZzHthUnyFUzFcX47WiR1wN9KOFh169eNsVvC1f46gswXLnCrw1Vj5NkDldri0BvDgySTfwEiOurc4dNP0K7rUO4GN18Nuqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699857; c=relaxed/simple;
	bh=6t5HLPn3Ol4H4k9imSxaXgzLpk0/0w5qEZFli8eIUhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VgkV/zrUHKFk3bYyWBnRDbaTjaGzrxb4E3cLSeMJJr5tjW2m2xtg9SFyAg5vB+9AiFgrGLn7y7H6AyfTOPj8/xaHPjs65XOna1d/UO88AAowPA6DK6UxYP4WGKDWSYeDxOBCA7fTDR4+QakThKPNnX0T8unAcQewT08DwxW4+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OtBS9i4S; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OtBS9i4S"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758699846; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vJ6OwI1egsr+qRN+aL3XWL0fhPfqdA2wF2Y9KB4Ntl4=;
	b=OtBS9i4SZRxLTkt4Mg7f1LzZ29HSSrlys/zx1EL2egbKYAnjtQ0d2kqJJZQvPiPqdgpeWhGsxDQyqTlYIvIYFwC9R7T/KWcp7K9BmkRh5bz9P5nDTDDe90TVgRHP8aZDDIwx+XhMWc2hhHFI9krqFYHKx3/ICEnFwYfomfPq78s=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0Woipfpi_1758699839 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Sep 2025 15:44:05 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev
Subject: [PATCH v3] iommu: Fix iommu selftest running test mock domain fail
Date: Wed, 24 Sep 2025 15:43:59 +0800
Message-ID: <20250924074359.41510-1-kanie@linux.alibaba.com>
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
---
Changes from v2 to v3:
- Add export symbol iommu_mock_device_init() and iommu_mock_device_abort()
in iommu.c instead of export iommu_probe_device_lock and iommu_fwspec_free().

Changes from v1 to v2:
- Remove print when iommu_fwspec_init() fail.
 drivers/iommu/iommu-priv.h       |  3 +++
 drivers/iommu/iommu.c            | 28 ++++++++++++++++++++++++++++
 drivers/iommu/iommufd/selftest.c |  5 +++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index e236b932e766..40c477db3cd9 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -37,6 +37,9 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
 				 const struct bus_type *bus,
 				 struct notifier_block *nb);
 
+int iommu_mock_device_init(struct device *dev, struct iommu_device *iommu);
+void iommu_mock_device_abort(struct device *dev);
+
 struct iommu_attach_handle *iommu_attach_handle_get(struct iommu_group *group,
 						    ioasid_t pasid,
 						    unsigned int type);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 060ebe330ee1..6e51cfbebd64 100644
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
@@ -326,6 +327,14 @@ int iommu_device_register_bus(struct iommu_device *iommu,
 	if (err)
 		return err;
 
+	iommu->fwnode = fwnode_create_software_node(NULL, NULL);
+	if (IS_ERR(iommu->fwnode)) {
+		iommu->fwnode = NULL;
+		dev_err(iommu->dev, "add property failed:%d\n", err);
+		bus_unregister_notifier(bus, nb);
+		return err;
+	}
+
 	spin_lock(&iommu_device_lock);
 	list_add_tail(&iommu->list, &iommu_device_list);
 	spin_unlock(&iommu_device_lock);
@@ -335,9 +344,28 @@ int iommu_device_register_bus(struct iommu_device *iommu,
 		iommu_device_unregister_bus(iommu, bus, nb);
 		return err;
 	}
+	WRITE_ONCE(iommu->ready, true);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_device_register_bus);
+
+int iommu_mock_device_init(struct device *dev, struct iommu_device *iommu)
+{
+	int rc;
+
+	mutex_lock(&iommu_probe_device_lock);
+	rc = iommu_fwspec_init(dev, iommu->fwnode);
+	mutex_unlock(&iommu_probe_device_lock);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(iommu_mock_device_init);
+
+void iommu_mock_device_abort(struct device *dev)
+{
+	iommu_fwspec_free(dev);
+}
+EXPORT_SYMBOL_GPL(iommu_mock_device_abort);
 #endif
 
 static struct dev_iommu *dev_iommu_get(struct device *dev)
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 61686603c769..38aaa2b02af4 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1077,6 +1077,7 @@ static void mock_dev_release(struct device *dev)
 {
 	struct mock_dev *mdev = to_mock_dev(dev);
 
+	iommu_mock_device_abort(&mdev->dev);
 	ida_free(&mock_dev_ida, mdev->id);
 	kfree(mdev);
 }
@@ -1126,6 +1127,10 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 		goto err_put;
 	}
 
+	rc = iommu_mock_device_init(&mdev->dev, &mock_iommu.iommu_dev);
+	if (rc)
+		goto err_put;
+
 	rc = device_add(&mdev->dev);
 	if (rc)
 		goto err_put;
-- 
2.43.0

