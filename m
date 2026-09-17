Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F67568FDF;
	Thu, 17 Sep 2026 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653854; cv=none; b=HIjJYXdBZSGYoTBGuAFjxdeHuRn5nkzBHLmzqaLjqd/30/j6WbCYPeprdhHI6cZt/NCt//Rm4NtsaVVjudSbc7Mtf78cw4ueMIgNyZTBkKyJpY7rPPBdJWZ4mwlPUF/prWjRtQqFzPvQ1afbLtQom8PK1F+2lkU1hASnGDA2FpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653854; c=relaxed/simple;
	bh=SzIgcFRhyWUlki2oQ4DmqvreVRHTJiQakp+PL/CM+fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bd9jtalKZH9DTr8c77fhpmHLAU5YJQZM0Frz7hKN3M4/sjCZmWr+Uwjk1rwoIrZd7YP8exZYcYd9mpydVRty43+BcMh21aqPWinQsSAKfKClpCutSNdlkbH4/DQQ0mz2o0ILrE52qk59zNuTO0U+O9ZT5Rx00gBjznbr69cwYtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ln9ObrKm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ln9ObrKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258711F00899;
	Thu, 17 Sep 2026 14:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653851;
	bh=4XhfSeK1JjeSA886SLLVaYcAmqC3NXGARVDHJeIpbCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ln9ObrKm3c8ikidVqHgwmHwp5yIWIZ83DHhNVCAKR97CbaOGMwxWOt0wITS1hOKmg
	 GXHdyBOjXoGzayZo4vjQQPNE7+gUAThcvHE9G6KkYog5qBFr6kCat1mYNlDKk592kw
	 dtU/vY5fBI3TftDHtgKM6LTMcDZ7r6hOzBXSaEyzjai1Qp7JJdTkDtA7GB9kbVv3tk
	 jNUFRkKYwyB/ZV6Q/bndMQqeTHn6QvcrDOSxjavUczT3fi/Ca1+uyL+omIVQgpWXsW
	 ZdTdoJ9jzmDIkvYuyD96aUHn9e2UktbvCqCxUqjQ2QCHQiOTy95djWfJwXUGKkzdiq
	 H2x93I8X7pI7Q==
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
Subject: [RFC PATCH v6 11/11] PCI/TSM: Add reference-counted contexts for vdevice providers
Date: Thu, 17 Sep 2026 19:31:59 +0530
Message-ID: <20260917140159.1163281-12-aneesh.kumar@kernel.org>
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

Replace the PCI/TSM bind/unbind interface with reference-counted
contexts that retain the function, DSM device and Link TSM for a vdevice
provider. Reject disconnect while a context is live.

Keep the existing bound sysfs attribute and derive its status from
successful provider binding, with balanced per-function accounting on
context release. Update the ABI documentation and retire the obsolete
sample bind/unbind operations in the same patch.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-pci |  29 ++-
 drivers/pci/tsm/core.c                  | 256 +++++++++++++-----------
 include/linux/pci-tsm.h                 |  85 +++++---
 samples/devsec/link_tsm.c               |  96 ---------
 tools/testing/devsec/devsec.sh          |  27 +--
 5 files changed, 211 insertions(+), 282 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index c2a5c4fe9373..5288ea4ed343 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -657,6 +657,9 @@ Description:
 		to 'connect' to teardown the connection. This is a
 		"link" TSM attribute, see
 		Documentation/ABI/testing/sysfs-class-tsm.
+		The write fails with EBUSY while any vdevice depends on the
+		connection. Userspace must destroy those vdevices before
+		disconnecting the link.
 
 What:		/sys/bus/pci/devices/.../tsm/dsm
 Contact:	linux-coco@lists.linux.dev
@@ -676,17 +679,21 @@ Description:	(RO) Return PCI device name of this device's DSM (Device
 
 What:		/sys/bus/pci/devices/.../tsm/bound
 Contact:	linux-coco@lists.linux.dev
-Description:	(RO) Return the device name of the TSM when the device is in a
-		TDISP (TEE Device Interface Security Protocol) operational state
-		(LOCKED, RUN, or ERROR, not UNLOCKED). Bound devices consume
-		platform TSM resources and depend on the device's configuration
-		(e.g. BME (Bus Master Enable) and MSE (Memory Space Enable)
-		among other settings) to remain stable for the duration of the
-		bound state. This attribute is only visible for devices that
-		support TDISP operation, and it is only populated after
-		successful connect and TSM bind. The TSM bind operation is
-		initiated by VFIO/IOMMUFD. This is a "link" TSM attribute, see
-		Documentation/ABI/testing/sysfs-class-tsm.
+Description:	(RO) Return the device name of the TSM when this PCI function
+		has a successfully initialized TSM-backed vdevice binding, or
+		an empty line when no such binding exists. The binding is
+		established through VFIO/IOMMUFD and remains visible until
+		the provider releases its context during vdevice teardown.
+		Merely connecting the device to a TSM or acquiring a context
+		does not establish a binding. Bindings of other functions
+		managed by the same DSM do not affect this attribute.
+
+		This reports the binding lifetime, not the current TDISP
+		(TEE Device Interface Security Protocol) state. A bound vdevice
+		may be UNLOCKED, and TDISP lock/unlock transitions do not
+		change this attribute. This attribute is only visible for
+		devices that support TDISP operation. This is a "link" TSM
+		attribute, see Documentation/ABI/testing/sysfs-class-tsm.
 
 What:		/sys/bus/pci/devices/.../authenticated
 Contact:	linux-pci@vger.kernel.org
diff --git a/drivers/pci/tsm/core.c b/drivers/pci/tsm/core.c
index c7e0d241e55d..667328d1c686 100644
--- a/drivers/pci/tsm/core.c
+++ b/drivers/pci/tsm/core.c
@@ -67,11 +67,10 @@ static struct pci_tsm_pf0 *to_pci_tsm_pf0(struct pci_tsm *tsm)
 
 static inline bool is_devsec(struct pci_dev *pdev)
 {
-	return pdev->tsm && pdev->tsm->dsm_dev == NULL &&
-	       pdev->tsm->tdi == NULL;
+	return pdev->tsm && !pdev->tsm->dsm_dev;
 }
 
-/* 'struct pci_tsm_devsec' wraps 'struct pci_tsm' when ->tdi == ->dsm == NULL */
+/* 'struct pci_tsm_devsec' wraps 'struct pci_tsm' when ->dsm_dev == NULL */
 struct pci_tsm_devsec *to_pci_tsm_devsec(struct pci_tsm *tsm)
 {
 	struct pci_dev *pdev = tsm->pdev;
@@ -315,96 +314,118 @@ static int remove_fn(struct pci_dev *pdev, void *data)
 	return 0;
 }
 
-/*
- * Note, this helper only returns an error code and takes an argument for
- * compatibility with the pci_walk_bus() callback prototype. pci_tsm_unbind()
- * always succeeds.
- */
-static int __pci_tsm_unbind(struct pci_dev *pdev, void *data)
+bool pci_tsm_is_configured(struct pci_dev *pdev)
 {
-	struct pci_tdi *tdi;
-	struct pci_tsm_pf0 *tsm_pf0;
-
-	lockdep_assert_held(&pci_tsm_rwsem);
+	guard(rwsem_read)(&pci_tsm_rwsem);
 
-	if (!pdev->tsm)
-		return 0;
+	return !!pdev->tsm;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_is_configured);
 
-	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
-	guard(mutex)(&tsm_pf0->lock);
+struct pci_tsm_context {
+	struct pci_tsm_pf0 *pf0;
+	struct pci_dev *pdev;
+	struct pci_dev *dsm_dev;
+	struct tsm_dev *tsm_dev;
+	struct list_head bound_node;
+};
 
-	tdi = pdev->tsm->tdi;
-	if (!tdi)
-		return 0;
+struct pci_tsm_context *pci_tsm_context_get(struct pci_dev *pdev)
+{
+	struct pci_tsm_context *context;
+	struct pci_tsm_pf0 *pf0;
+	struct device *tsm_device;
 
-	to_pci_tsm_ops(pdev->tsm)->unbind(tdi);
-	pdev->tsm->tdi = NULL;
+	guard(rwsem_read)(&pci_tsm_rwsem);
+	if (!pdev->tsm || !is_link_tsm(pdev->tsm->tsm_dev))
+		return ERR_PTR(-EOPNOTSUPP);
 
-	return 0;
+	pf0 = to_pci_tsm_pf0(pdev->tsm);
+	if (!pf0)
+		return ERR_PTR(-ENXIO);
+
+	context = kzalloc_obj(*context);
+	if (!context)
+		return ERR_PTR(-ENOMEM);
+
+	guard(mutex)(&pf0->lock);
+	pf0->context_users++;
+	context->pf0 = pf0;
+	context->pdev = pci_dev_get(pdev);
+	INIT_LIST_HEAD(&context->bound_node);
+	context->dsm_dev = pci_dev_get(pf0->base_tsm.pdev);
+	tsm_device = get_device(&pdev->tsm->tsm_dev->dev);
+	context->tsm_dev = container_of(tsm_device, struct tsm_dev, dev);
+	return context;
 }
+EXPORT_SYMBOL_GPL(pci_tsm_context_get);
 
-void pci_tsm_unbind(struct pci_dev *pdev)
+void pci_tsm_context_put(struct pci_tsm_context *context)
 {
-	guard(rwsem_read)(&pci_tsm_rwsem);
-	__pci_tsm_unbind(pdev, NULL);
+	struct pci_tsm_pf0 *pf0 = context->pf0;
+
+	down_read(&pci_tsm_rwsem);
+	mutex_lock(&pf0->lock);
+	list_del(&context->bound_node);
+	if (!WARN_ON(!pf0->context_users))
+		pf0->context_users--;
+	mutex_unlock(&pf0->lock);
+	up_read(&pci_tsm_rwsem);
+
+	put_device(&context->tsm_dev->dev);
+	pci_dev_put(context->pdev);
+	pci_dev_put(context->dsm_dev);
+	kfree(context);
 }
-EXPORT_SYMBOL_GPL(pci_tsm_unbind);
+EXPORT_SYMBOL_GPL(pci_tsm_context_put);
 
 /**
- * pci_tsm_bind() - Bind @pdev as a TDI for @kvm
- * @pdev: PCI device function to bind
- * @kvm: Private memory attach context
- * @tdi_id: Identifier (virtual BDF) for the TDI as referenced by the TSM and DSM
+ * pci_tsm_context_mark_bound() - Publish a successful per-function binding
+ * @context: context acquired for the bound PCI function
  *
- * Returns 0 on success, or a negative error code on failure.
+ * Call once after the provider has successfully initialized the vdevice.
+ * The binding remains visible in tsm/bound until pci_tsm_context_put(),
+ * independently of the device's TDISP state. Acquiring a context alone
+ * does not establish a binding.
  *
- * Context: Caller is responsible for constraining the bind lifetime to the
- * registered state of the device. For example, pci_tsm_bind() /
- * pci_tsm_unbind() limited to the VFIO driver bound state of the device.
+ * Context: Caller holds the context's pci_tsm_pf0::lock.
  */
-int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
+void pci_tsm_context_mark_bound(struct pci_tsm_context *context)
 {
-	struct pci_tsm_pf0 *tsm_pf0;
-	struct pci_tdi *tdi;
-
-	if (!kvm)
-		return -EINVAL;
-
-	guard(rwsem_read)(&pci_tsm_rwsem);
-
-	if (!pdev->tsm)
-		return -EINVAL;
-
-	if (!is_link_tsm(pdev->tsm->tsm_dev))
-		return -ENXIO;
-
-	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
-	guard(mutex)(&tsm_pf0->lock);
-
-	/* Resolve races to bind a TDI */
-	if (pdev->tsm->tdi) {
-		if (pdev->tsm->tdi->kvm != kvm)
-			return -EBUSY;
-		return 0;
-	}
+	lockdep_assert_held(&context->pf0->lock);
+	list_add_tail(&context->bound_node, &context->pf0->bound_contexts);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_context_mark_bound);
 
-	tdi = to_pci_tsm_ops(pdev->tsm)->bind(pdev, kvm, tdi_id);
-	if (IS_ERR(tdi))
-		return PTR_ERR(tdi);
+struct tsm_dev *pci_tsm_context_tsm_dev(struct pci_tsm_context *context)
+{
+	return context->tsm_dev;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_context_tsm_dev);
 
-	pdev->tsm->tdi = tdi;
+struct pci_tsm_pf0 *pci_tsm_context_pf0(struct pci_tsm_context *context)
+{
+	return context->pf0;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_context_pf0);
 
-	return 0;
+struct pci_dev *pci_tsm_context_dsm_dev(struct pci_tsm_context *context)
+{
+	return context->dsm_dev;
 }
-EXPORT_SYMBOL_GPL(pci_tsm_bind);
+EXPORT_SYMBOL_GPL(pci_tsm_context_dsm_dev);
 
-static void pci_tsm_unbind_all(struct pci_dev *pdev)
+bool pci_tsm_context_match_device(struct pci_tsm_context *context,
+				  struct pci_dev *pdev)
 {
-	pci_tsm_walk_fns_reverse(pdev, __pci_tsm_unbind, NULL);
-	__pci_tsm_unbind(pdev, NULL);
+	guard(rwsem_read)(&pci_tsm_rwsem);
+
+	return pdev->tsm && is_link_tsm(pdev->tsm->tsm_dev) &&
+	       to_pci_tsm_pf0(pdev->tsm) == context->pf0;
 }
+EXPORT_SYMBOL_GPL(pci_tsm_context_match_device);
 
-static void __pci_tsm_disconnect(struct pci_dev *pdev)
+static int __pci_tsm_disconnect(struct pci_dev *pdev)
 {
 	struct pci_tsm_pf0 *tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
 	const struct pci_tsm_ops *ops = to_pci_tsm_ops(pdev->tsm);
@@ -412,21 +433,29 @@ static void __pci_tsm_disconnect(struct pci_dev *pdev)
 	/* disconnect() mutually exclusive with subfunction pci_tsm_init() */
 	lockdep_assert_held_write(&pci_tsm_rwsem);
 
-	pci_tsm_unbind_all(pdev);
-
 	/*
-	 * disconnect() is uninterruptible as it may be called for device
-	 * teardown
+	 * A vdevice holds a context for its lifetime. Refuse to tear down the
+	 * link until userspace destroys all dependent vdevices.
+	 *
+	 * disconnect() is uninterruptible as it may also be called for device
+	 * teardown.
 	 */
-	guard(mutex)(&tsm_pf0->lock);
+	scoped_guard(mutex, &tsm_pf0->lock)
+		if (tsm_pf0->context_users)
+			return -EBUSY;
 	pci_tsm_walk_fns_reverse(pdev, remove_fn, NULL);
 	ops->disconnect(pdev);
+	return 0;
 }
 
-static void pci_tsm_disconnect(struct pci_dev *pdev)
+static int pci_tsm_disconnect(struct pci_dev *pdev)
 {
-	__pci_tsm_disconnect(pdev);
+	int ret = __pci_tsm_disconnect(pdev);
+
+	if (ret)
+		return ret;
 	tsm_remove(pdev->tsm);
+	return 0;
 }
 
 static ssize_t disconnect_store(struct device *dev,
@@ -448,35 +477,43 @@ static ssize_t disconnect_store(struct device *dev,
 	if (!sysfs_streq(buf, dev_name(&tsm_dev->dev)))
 		return -EINVAL;
 
-	pci_tsm_disconnect(pdev);
+	rc = pci_tsm_disconnect(pdev);
+	if (rc)
+		return rc;
 	return len;
 }
 static DEVICE_ATTR_WO(disconnect);
 
-static ssize_t bound_show(struct device *dev,
-			  struct device_attribute *attr, char *buf)
+static ssize_t bound_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct pci_tsm_pf0 *tsm_pf0;
-	struct pci_tsm *tsm;
+	struct pci_tsm_context *context;
+	struct pci_tsm_pf0 *pf0;
 	int rc;
 
 	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
-	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
+	rc = ACQUIRE_ERR(rwsem_read_intr, &lock);
+	if (rc)
 		return rc;
 
-	tsm = pdev->tsm;
-	if (!tsm)
+	if (!pdev->tsm || !is_link_tsm(pdev->tsm->tsm_dev))
 		return sysfs_emit(buf, "\n");
-	tsm_pf0 = to_pci_tsm_pf0(tsm);
+	pf0 = to_pci_tsm_pf0(pdev->tsm);
+	if (!pf0)
+		return -ENXIO;
 
-	ACQUIRE(mutex_intr, ops_lock)(&tsm_pf0->lock);
-	if ((rc = ACQUIRE_ERR(mutex_intr, &ops_lock)))
+	ACQUIRE(mutex_intr, ops_lock)(&pf0->lock);
+	rc = ACQUIRE_ERR(mutex_intr, &ops_lock);
+	if (rc)
 		return rc;
 
-	if (!tsm->tdi)
-		return sysfs_emit(buf, "\n");
-	return sysfs_emit(buf, "%s\n", dev_name(&tsm->tsm_dev->dev));
+	list_for_each_entry(context, &pf0->bound_contexts, bound_node)
+		if (context->pdev == pdev)
+			return sysfs_emit(buf, "%s\n",
+					  dev_name(&context->tsm_dev->dev));
+
+	return sysfs_emit(buf, "\n");
 }
 static DEVICE_ATTR_RO(bound);
 
@@ -955,7 +992,8 @@ static umode_t pci_tsm_attr_visible(struct kobject *kobj,
 		if (attr == &dev_attr_bound.attr) {
 			if (is_pci_tsm_pf0(pdev) && has_tee(pdev))
 				return attr->mode;
-			if (pdev->tsm && has_tee(pdev->tsm->dsm_dev))
+			if (pdev->tsm && pdev->tsm->dsm_dev &&
+			    has_tee(pdev->tsm->dsm_dev))
 				return attr->mode;
 		}
 
@@ -1086,22 +1124,6 @@ static struct pci_dev *find_dsm_dev(struct pci_dev *pdev)
 	return NULL;
 }
 
-/**
- * pci_tsm_tdi_constructor() - base 'struct pci_tdi' initialization for link TSMs
- * @pdev: PCI device function representing the TDI
- * @tdi: context to initialize
- * @kvm: Private memory attach context
- * @tdi_id: Identifier (virtual BDF) for the TDI as referenced by the TSM and DSM
- */
-void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
-			     struct kvm *kvm, u32 tdi_id)
-{
-	tdi->pdev = pdev;
-	tdi->kvm = kvm;
-	tdi->tdi_id = tdi_id;
-}
-EXPORT_SYMBOL_GPL(pci_tsm_tdi_constructor);
-
 void pci_tsm_init_evidence(struct pci_tsm_evidence *evidence, int slot,
 			   enum hash_algo digest_algo)
 {
@@ -1151,7 +1173,6 @@ int pci_tsm_devsec_constructor(struct pci_dev *pdev, struct pci_tsm_devsec *tsm,
 		return -EINVAL;
 
 	pci_tsm->dsm_dev = NULL;
-	pci_tsm->tdi = NULL;
 	pci_tsm->pdev = pdev;
 	pci_tsm->tsm_dev = tsm_dev;
 
@@ -1169,6 +1190,7 @@ int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
 			    struct tsm_dev *tsm_dev)
 {
 	mutex_init(&tsm->lock);
+	INIT_LIST_HEAD(&tsm->bound_contexts);
 	/*
 	 * Note, low-level TSM driver responsible for determining if it wants to
 	 * proceed with a device that has no DOE mailbox. TSM may have an
@@ -1224,12 +1246,6 @@ int pci_tsm_register(struct tsm_dev *tsm_dev)
 	return 0;
 }
 
-static void pci_tsm_fn_exit(struct pci_dev *pdev)
-{
-	__pci_tsm_unbind(pdev, NULL);
-	tsm_remove(pdev->tsm);
-}
-
 /**
  * __pci_tsm_destroy() - destroy the TSM context for @pdev
  * @pdev: device to cleanup
@@ -1266,12 +1282,14 @@ static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
 	else if (tsm_dev != tsm->tsm_dev)
 		return;
 
-	/* Disconnect DSMs, unlock assigned TDIs, or cleanup DSM subfunctions */
+	/* Disconnect DSMs, unlock assigned TDIs, or clean up DSM subfunctions. */
 	if (is_link_tsm(tsm_dev)) {
-		if (is_pci_tsm_pf0(pdev))
-			pci_tsm_disconnect(pdev);
-		else
-			pci_tsm_fn_exit(pdev);
+		if (is_pci_tsm_pf0(pdev)) {
+			if (pci_tsm_disconnect(pdev))
+				pci_warn(pdev, "TSM connection is still in use\n");
+		} else {
+			tsm_remove(pdev->tsm);
+		}
 	}
 
 	if (is_devsec_tsm(tsm_dev) && has_tee(pdev)) {
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 15907bad47b7..e351e1490fd0 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __PCI_TSM_H
 #define __PCI_TSM_H
+#include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/rwsem.h>
@@ -8,8 +9,8 @@
 #include <uapi/linux/pci-tsm-netlink.h>
 
 struct pci_tsm;
+struct pci_tsm_context;
 struct tsm_dev;
-struct kvm;
 
 /*
  * struct pci_tsm_ops - manage confidential links and security state
@@ -33,16 +34,11 @@ struct pci_tsm_ops {
 	 * @connect: establish / validate a secure connection (e.g. IDE)
 	 *	     with the device
 	 * @disconnect: teardown the secure link
-	 * @bind: bind a TDI in preparation for it to be accepted by a TVM
-	 * @unbind: remove a TDI from secure operation with a TVM
-	 *
 	 * Context: @probe, @remove, @connect, and @disconnect run under
 	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
 	 * mutual exclusion of @connect and @disconnect. @connect and
 	 * @disconnect additionally run under the DSM lock (struct
 	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
-	 * @bind and @unbind run under pci_tsm_rwsem held for read
-	 * and the DSM lock.
 	 */
 	struct_group_tagged(pci_tsm_link_ops, link_ops,
 		struct pci_tsm *(*probe)(struct tsm_dev *tsm_dev,
@@ -50,9 +46,6 @@ struct pci_tsm_ops {
 		void (*remove)(struct pci_tsm *tsm);
 		int (*connect)(struct pci_dev *pdev);
 		void (*disconnect)(struct pci_dev *pdev);
-		struct pci_tdi *(*bind)(struct pci_dev *pdev,
-					struct kvm *kvm, u32 tdi_id);
-		void (*unbind)(struct pci_tdi *tdi);
 	);
 
 	/*
@@ -81,18 +74,6 @@ struct pci_tsm_ops {
 				size_t nonce_len);
 };
 
-/**
- * struct pci_tdi - Core TEE I/O Device Interface (TDI) context
- * @pdev: host side representation of guest-side TDI
- * @kvm: TEE VM context of bound TDI
- * @tdi_id: Identifier (virtual BDF) for the TDI as referenced by the TSM and DSM
- */
-struct pci_tdi {
-	struct pci_dev *pdev;
-	struct kvm *kvm;
-	u32 tdi_id;
-};
-
 /**
  * struct pci_tsm_evidence_object - General PCI/TSM blob descriptor
  * @data: pointer to the evidence data blob
@@ -145,7 +126,6 @@ struct pci_tsm_evidence {
  * @dsm_dev: PCI Device Security Manager for link operations on @pdev
  * @tsm_dev: PCI TEE Security Manager device for Link Confidentiality or Device
  *	     Function Security operations
- * @tdi: TDI context established by the @bind link operation
  * @evidence: cached evidence from SPDM session establishment (connect), or
  *	      TDISP bind (lock)
  *
@@ -170,7 +150,6 @@ struct pci_tsm {
 	struct pci_dev *pdev;
 	struct pci_dev *dsm_dev;
 	struct tsm_dev *tsm_dev;
-	struct pci_tdi *tdi;
 	struct pci_tsm_evidence evidence;
 };
 
@@ -178,11 +157,17 @@ struct pci_tsm {
  * struct pci_tsm_pf0 - Physical Function 0 TDISP link context
  * @base_tsm: generic core "tsm" context
  * @lock: mutual exclustion for pci_tsm_ops invocation
+ * @context_users: live per-function contexts on this PF0, including contexts
+ *	being initialized and not yet in @bound_contexts; a nonzero count blocks
+ *	link disconnect and is independent of TSM and vIOMMU provider lifetimes
+ * @bound_contexts: bound per-function contexts, protected by @lock
  * @doe_mb: PCIe Data Object Exchange mailbox
  */
 struct pci_tsm_pf0 {
 	struct pci_tsm base_tsm;
 	struct mutex lock;
+	unsigned int context_users;
+	struct list_head bound_contexts;
 	struct pci_doe_mb *doe_mb;
 };
 
@@ -269,10 +254,15 @@ int pci_tsm_devsec_constructor(struct pci_dev *pdev, struct pci_tsm_devsec *tsm,
 void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *tsm);
 int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
 			 size_t req_sz, void *resp, size_t resp_sz);
-int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id);
-void pci_tsm_unbind(struct pci_dev *pdev);
-void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
-			     struct kvm *kvm, u32 tdi_id);
+bool pci_tsm_is_configured(struct pci_dev *pdev);
+struct pci_tsm_context *pci_tsm_context_get(struct pci_dev *pdev);
+void pci_tsm_context_put(struct pci_tsm_context *context);
+void pci_tsm_context_mark_bound(struct pci_tsm_context *context);
+struct tsm_dev *pci_tsm_context_tsm_dev(struct pci_tsm_context *context);
+struct pci_tsm_pf0 *pci_tsm_context_pf0(struct pci_tsm_context *context);
+struct pci_dev *pci_tsm_context_dsm_dev(struct pci_tsm_context *context);
+bool pci_tsm_context_match_device(struct pci_tsm_context *context,
+				  struct pci_dev *pdev);
 struct pci_tsm_devsec *to_pci_tsm_devsec(struct pci_tsm *tsm);
 void pci_tsm_init_evidence(struct pci_tsm_evidence *evidence, int slot,
 			   enum hash_algo digest_algo);
@@ -288,12 +278,47 @@ static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
 static inline void pci_tsm_unregister(struct tsm_dev *tsm_dev)
 {
 }
-static inline int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
+static inline bool pci_tsm_is_configured(struct pci_dev *pdev)
 {
-	return -ENXIO;
+	return false;
 }
-static inline void pci_tsm_unbind(struct pci_dev *pdev)
+
+static inline struct pci_tsm_context *
+pci_tsm_context_get(struct pci_dev *pdev)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline void pci_tsm_context_put(struct pci_tsm_context *context)
+{
+}
+
+static inline void pci_tsm_context_mark_bound(struct pci_tsm_context *context)
+{
+}
+
+static inline struct tsm_dev *
+pci_tsm_context_tsm_dev(struct pci_tsm_context *context)
+{
+	return NULL;
+}
+
+static inline struct pci_tsm_pf0 *
+pci_tsm_context_pf0(struct pci_tsm_context *context)
+{
+	return NULL;
+}
+
+static inline struct pci_dev *
+pci_tsm_context_dsm_dev(struct pci_tsm_context *context)
+{
+	return NULL;
+}
+
+static inline bool
+pci_tsm_context_match_device(struct pci_tsm_context *context, struct pci_dev *pdev)
 {
+	return false;
 }
 #endif
 
diff --git a/samples/devsec/link_tsm.c b/samples/devsec/link_tsm.c
index 1d102dd9590a..7fee075d7ab3 100644
--- a/samples/devsec/link_tsm.c
+++ b/samples/devsec/link_tsm.c
@@ -20,10 +20,6 @@ struct devsec_tsm_fn {
 	struct pci_tsm pci;
 };
 
-struct devsec_tsm_tdi {
-	struct pci_tdi pci;
-};
-
 static struct devsec_tsm_pf0 *to_devsec_tsm_pf0(struct pci_tsm *tsm)
 {
 	return container_of(tsm, struct devsec_tsm_pf0, pci.base_tsm);
@@ -234,39 +230,11 @@ static void devsec_link_tsm_disconnect(struct pci_dev *pdev)
 	clear_bit(i, devsec_stream_ids);
 }
 
-static struct pci_tdi *devsec_link_tsm_bind(struct pci_dev *pdev,
-					    struct kvm *kvm, u32 tdi_id)
-{
-	struct devsec_tsm_tdi *devsec_tdi =
-		kzalloc(sizeof(struct devsec_tsm_tdi), GFP_KERNEL);
-
-	dev_dbg(pci_tsm_host(pdev), "%s\n", pci_name(pdev));
-
-	if (!devsec_tdi)
-		return ERR_PTR(-ENOMEM);
-
-	pci_tsm_tdi_constructor(pdev, &devsec_tdi->pci, kvm, tdi_id);
-
-	return &devsec_tdi->pci;
-}
-
-static void devsec_link_tsm_unbind(struct pci_tdi *tdi)
-{
-	struct devsec_tsm_tdi *devsec_tdi =
-		container_of(tdi, struct devsec_tsm_tdi, pci);
-
-	dev_dbg(pci_tsm_host(tdi->pdev), "%s\n", pci_name(tdi->pdev));
-
-	kfree(devsec_tdi);
-}
-
 static struct pci_tsm_ops devsec_link_pci_ops = {
 	.probe = devsec_link_tsm_pci_probe,
 	.remove = devsec_link_tsm_pci_remove,
 	.connect = devsec_link_tsm_connect,
 	.disconnect = devsec_link_tsm_disconnect,
-	.bind = devsec_link_tsm_bind,
-	.unbind = devsec_link_tsm_unbind,
 };
 
 static void devsec_link_tsm_remove(void *tsm_dev)
@@ -292,71 +260,7 @@ static const struct faux_device_ops devsec_link_device_ops = {
 	.probe = devsec_link_tsm_probe,
 };
 
-static struct pci_dev *pci_find_device(const char *name)
-{
-	struct device *dev = bus_find_device_by_name(&pci_bus_type, NULL, name);
-
-	if (dev)
-		return to_pci_dev(dev);
-	return NULL;
-}
-
-static ssize_t tsm_bind_store(struct device *dev, struct device_attribute *attr,
-			      const char *buf, size_t count)
-{
-	struct device *host;
-	int rc;
-
-	struct pci_dev *pdev __free(pci_dev_put) = pci_find_device(buf);
-	if (!pdev)
-		return -ENODEV;
-
-	host = pci_tsm_host(pdev);
-	if (!host || host != &devsec_link_tsm->dev)
-		return -ENXIO;
-
-	rc = pci_tsm_bind(pdev, (struct kvm *)1, pci_dev_id(pdev));
-	if (rc)
-		return rc;
-	return count;
-}
-static DEVICE_ATTR_WO(tsm_bind);
-
-static ssize_t tsm_unbind_store(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf, size_t count)
-{
-	struct device *host;
-
-	struct pci_dev *pdev __free(pci_dev_put) = pci_find_device(buf);
-	if (!pdev)
-		return -ENODEV;
-
-	host = pci_tsm_host(pdev);
-	if (!host || host != &devsec_link_tsm->dev)
-		return -ENXIO;
-
-	pci_tsm_unbind(pdev);
-	return count;
-}
-static DEVICE_ATTR_WO(tsm_unbind);
-
-/*
- * Facilitate testing of the bind flows in lieu of VFIO/IOMMUFD
- * support to exercise these paths.
- */
-static struct attribute *devsec_link_attrs[] = {
-	&dev_attr_tsm_bind.attr,
-	&dev_attr_tsm_unbind.attr,
-	NULL,
-};
-
-static const struct attribute_group devsec_link_group = {
-	.attrs = devsec_link_attrs,
-};
-
 static const struct attribute_group *devsec_link_groups[] = {
-	&devsec_link_group,
 	&devsec_evidence_group,
 	NULL,
 };
diff --git a/tools/testing/devsec/devsec.sh b/tools/testing/devsec/devsec.sh
index 6a9313e7104f..159b1a6fb133 100755
--- a/tools/testing/devsec/devsec.sh
+++ b/tools/testing/devsec/devsec.sh
@@ -94,14 +94,10 @@ validate_disconnected() {
 	fn_dev=${FN_DEVS[$1]}
 	host_bridge=$(dirname $(dirname $(readlink -f $pci_dev)))
 
-	# validate that the dsm is not yet detected and that the sub-function
-	# is aware of any TSM capabilities
+	# validate that the dsm is not yet detected
 	dsm=$(cat $pci_dev/tsm/dsm) || err "$LINENO from $2"
-	bound=$(cat $pci_dev/tsm/bound) || err "$LINENO from $2"
 	[[ -z $dsm ]] || err "$LINENO from $2"
-	[[ -z $bound ]] || err "$LINENO from $2"
 	[[ ! -e $fn_dev/tsm/dsm ]] || err "$LINENO from $2"
-	[[ ! -e $fn_dev/tsm/bound ]] || err "$LINENO from $2"
 	[[ ! -e $fn_dev/tsm/connect ]] || err "$LINENO from $2"
 	[[ ! -e $fn_dev/tsm/disconnect ]] || err "$LINENO from $2"
 }
@@ -197,27 +193,6 @@ ide_test() {
 
 	check_evidence $pci_dev
 
-	# bind both functions and validate that they display bound to
-	# the TSM device
-	echo $(basename $pci_dev) > $tsm_link/device/tsm_bind
-	bound=$(cat $pci_dev/tsm/bound)
-	[[ $bound == $(basename $tsm_link) ]] || err "$LINENO"
-	echo $(basename $fn_dev) > $tsm_link/device/tsm_bind
-	bound=$(cat $fn_dev/tsm/bound)
-	[[ $bound == $(basename $tsm_link) ]] || err "$LINENO"
-
-	# test manual unbind
-	echo $(basename $pci_dev) > $tsm_link/device/tsm_unbind
-	bound=$(cat $pci_dev/tsm/bound)
-	[[ -z $bound ]] || err "$LINENO"
-	echo $(basename $fn_dev) > $tsm_link/device/tsm_unbind
-	bound=$(cat $fn_dev/tsm/bound)
-	[[ -z $bound ]] || err "$LINENO"
-
-	# rebind to test automatic unbind at disconnect
-	echo $(basename $pci_dev) > $tsm_link/device/tsm_bind
-	echo $(basename $fn_dev) > $tsm_link/device/tsm_bind
-
 	# check that the links disappear at disconnect and the stream
 	# pool is refilled
 	echo $(basename $tsm_link) > $pci_dev/tsm/disconnect
-- 
2.43.0

