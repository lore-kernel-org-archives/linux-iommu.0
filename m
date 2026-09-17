Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6667057D23B;
	Thu, 17 Sep 2026 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653818; cv=none; b=fVKepAH1o1FnJgmXpwVyABjlZzFEDBwqjlrR4iB7CgpHOw/j/U5ig9GkfAe3dFLA5xh1xhXNLVAUfySU7Ul4Kbr5/wapjxPRPCGn2quJlOdh/yAxMlImOyo0EVCSTTzuHTSsBfGoA9zkLZRuSKhPnTtsSihHrnqRZNfovlF2OWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653818; c=relaxed/simple;
	bh=IpHMT6b+XPPyXbR/Ayv8VIzPvMbSuBfwmaINon0duNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvEK39Ad+2JCiKq53l538GVzf8xH87iBFsFTKzrfGO4ZudTin1HmOoTyKCwQkOwBAd8BZalQ67AaKi/EWv1x2AJALwV+o5MWv+SgC+q07zBsX1jTR+Nn7xwX2BT9qY+0IJKfSzDwZkt8CKmQLKuRHMN/+EdRZEy61Fd7YlNL3ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD2sMs+z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD2sMs+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207461F00899;
	Thu, 17 Sep 2026 14:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653815;
	bh=y17eDcxnxNk5lpH1HWpqAW8JDmaAMUUrW6aPIX1kJNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kD2sMs+z2pkAdSh1HbXZZTmxIP+0Z+7pQ7of47WOAzkGrmonmMo7KAg7uWUspMAK+
	 Z1+pahX2OBVm5iJ2nl8+QQlUHOadWmq7JMuJTxT06kY+jCHnVB6RndfrvwToLwSM6C
	 qkQ2Lo9XUuZTxYPSq1ugsKfNuDd65jXATEWmnJESZ+VinvXJZ8nhDUgWau3vKdGsL8
	 T99xro347erdAojeWilx1l7NJRmx8HOX1ubiI5Xj1byByvXQ7D2Tn9P1BQ30cyIYFw
	 L+OpWmqsXlCCtlkr9DCWcj22DVhczGymdQuIHKUeoo9LccCtlG9vYqTb5ZyD5whgYT
	 Etd3YWpsNMyOw==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v6 07/11] coco: tsm: Expose active-user lifetime references
Date: Thu, 17 Sep 2026 19:31:55 +0530
Message-ID: <20260917140159.1163281-8-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add separate active-user references for consumers that require both the
TSM device and its PCI/TSM resources.

Initialize the users count to one when allocating the TSM device. This
initial reference represents the registration and keeps the PCI/TSM
resources registered until tsm_unregister() drops it.

tsm_get() takes both an active-user reference and a device reference.
tsm_put() drops the active-user reference first, allowing the last
active user to tear down PCI/TSM resources while struct tsm_dev and the
driver operations remain valid, and then drops the device reference.

tsm_unregister() drops the initial registration reference and
unregisters the device. Existing active users retain the PCI/TSM
resources, while their device references keep struct tsm_dev alive. The
final active-user reference tears down the PCI/TSM resources,
independently of the final device reference releasing struct tsm_dev.

Restructure PCI/TSM registration error handling so tsm_register()
removes the device and lets its scoped device reference perform the
final release.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/virt/coco/tsm-core.c | 55 ++++++++++++++++++++++++++++++------
 include/linux/tsm.h          | 13 +++++++++
 2 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index 0843b77c6549..90d304d55b59 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -57,6 +57,39 @@ static const struct class tsm_class = {
 	.dev_groups	= tsm_pci_groups,
 };
 static DEFINE_IDA(tsm_ida);
+static void tsm_put_active(struct tsm_dev *tsm_dev)
+{
+	if (!refcount_dec_and_test(&tsm_dev->users))
+		return;
+	if (tsm_dev->pci_ops)
+		pci_tsm_unregister(tsm_dev);
+}
+
+/**
+ * tsm_get() - Take an active reference to a TSM
+ * @tsm_dev: registered TSM or TSM already held by an active reference
+ *
+ * Keeps both the device and its PCI/TSM resources alive.
+ */
+void tsm_get(struct tsm_dev *tsm_dev)
+{
+	get_device(&tsm_dev->dev);
+	refcount_inc(&tsm_dev->users);
+}
+EXPORT_SYMBOL_GPL(tsm_get);
+
+/**
+ * tsm_put() - Release an active TSM reference
+ * @tsm_dev: TSM acquired with tsm_get()
+ *
+ * The last active reference tears down PCI/TSM resources after unregister.
+ */
+void tsm_put(struct tsm_dev *tsm_dev)
+{
+	tsm_put_active(tsm_dev);
+	put_device(&tsm_dev->dev);
+}
+EXPORT_SYMBOL_GPL(tsm_put);
 
 static int match_id(struct device *dev, const void *data)
 {
@@ -90,6 +123,7 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent)
 		return ERR_PTR(id);
 
 	tsm_dev->id = id;
+	refcount_set(&tsm_dev->users, 1);
 	dev = &tsm_dev->dev;
 	dev->parent = parent;
 	dev->class = &tsm_class;
@@ -98,27 +132,26 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent)
 	return no_free_ptr(tsm_dev);
 }
 
-static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
-						 struct pci_tsm_ops *pci_ops)
+static int tsm_register_pci(struct tsm_dev *tsm_dev, struct pci_tsm_ops *pci_ops)
 {
 	int rc;
 
 	if (!pci_ops)
-		return tsm_dev;
+		return 0;
 
 	tsm_dev->pci_ops = pci_ops;
 	rc = pci_tsm_register(tsm_dev);
 	if (rc) {
+		tsm_dev->pci_ops = NULL;
 		dev_err(tsm_dev->dev.parent,
 			"PCI/TSM registration failure: %d\n", rc);
-		device_unregister(&tsm_dev->dev);
-		return ERR_PTR(rc);
+		return rc;
 	}
 	sysfs_update_group(&tsm_dev->dev.kobj, &tsm_pci_group);
 
 	/* Notify TSM userspace that PCI/TSM operations are now possible */
 	kobject_uevent(&tsm_dev->dev.kobj, KOBJ_CHANGE);
-	return tsm_dev;
+	return 0;
 }
 
 struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
@@ -139,14 +172,18 @@ struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
 	if (rc)
 		return ERR_PTR(rc);
 
-	return tsm_register_pci_or_reset(no_free_ptr(tsm_dev), pci_ops);
+	rc = tsm_register_pci(tsm_dev, pci_ops);
+	if (rc) {
+		device_del(dev);
+		return ERR_PTR(rc);
+	}
+	return no_free_ptr(tsm_dev);
 }
 EXPORT_SYMBOL_GPL(tsm_register);
 
 void tsm_unregister(struct tsm_dev *tsm_dev)
 {
-	if (tsm_dev->pci_ops)
-		pci_tsm_unregister(tsm_dev);
+	tsm_put_active(tsm_dev);
 	device_unregister(&tsm_dev->dev);
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 7f72a154b6b2..f38d6fcf9cc9 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -2,6 +2,7 @@
 #ifndef __TSM_H
 #define __TSM_H
 
+#include <linux/refcount.h>
 #include <linux/sizes.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
@@ -109,8 +110,18 @@ struct tsm_report_ops {
 };
 
 struct pci_tsm_ops;
+
+/**
+ * struct tsm_dev - TEE Security Manager device
+ * @dev: device-model representation of the TSM
+ * @users: registration reference plus active references that retain the
+ *	PCI/TSM resources; reaching zero tears down those resources
+ * @id: instance identifier
+ * @pci_ops: PCI/TSM operations, or %NULL when PCI/TSM is unsupported
+ */
 struct tsm_dev {
 	struct device dev;
+	refcount_t users;
 	int id;
 	const struct pci_tsm_ops *pci_ops;
 };
@@ -122,6 +133,8 @@ int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
 int tsm_report_unregister(const struct tsm_report_ops *ops);
 struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *ops);
 void tsm_unregister(struct tsm_dev *tsm_dev);
+void tsm_get(struct tsm_dev *tsm_dev);
+void tsm_put(struct tsm_dev *tsm_dev);
 struct tsm_dev *find_tsm_dev(int id);
 struct pci_ide;
 int tsm_ide_stream_register(struct pci_ide *ide);
-- 
2.43.0

