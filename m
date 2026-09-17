Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99DF566C40;
	Thu, 17 Sep 2026 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653844; cv=none; b=kP0c2U6t5SaKJa73NJWeX2hDtyXHJaGtv/a246UbV4Hddn7oeyxDCwAoMDdcwnN2u1Kctpw/hAPkraY9XDHmXOfLicI8keRTSUnGiVSMgcdmC8S/UTfoNF5+6jOZKEK276UlmrALYvEmGH5uSolN297MYlm5Zgfkf0lRDlS55KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653844; c=relaxed/simple;
	bh=yvUMMkSRoCMKaKn2zHf8uDHRZg8lkxjil26LEGrpDIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyzR6c/dHlofZgkJYGcHrUrDyuHAK4OEtZf4ZJFvEB5UYNYc5KsOqCWUAtegMDk/F46ssaw86odRTbQuFbdu8ACmOZUmHZi2JsFW21Uulhmv/4mgr4aqgigjyUQlD05GMKslf4sRHdONzYojExRC4L8tb8LTNaFXp4eiohVDZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMYecRa0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMYecRa0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC0B1F000FF;
	Thu, 17 Sep 2026 14:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653842;
	bh=67r4HCWaQOw8qMLQBBDGdE/J7UFL22QGlqlmf12e/L4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZMYecRa0o5bxpDoaXTzLvcEcgzo7m0466sU4Z+OYCjd+JnOlfMmDvQmImRgw+Gbha
	 LLqDr1cH0/0JtMDzC9ydDm/7jiMUaEBkci8SsksGnZZt3sTvTXoKdKdcWwKedFSvAE
	 774CbFZOD2cNIR660EevUARvUzl1fTZF4q7SmYdAJGivJJEwLgsZIT56kJlDD8lf7F
	 H6H8+ZRFDWwUul8ojUvNRvNDjLIT11QDNkaqKU76fvMM6amApAlEzRsrs4WadAr68+
	 LS1pl4W4BkAm0l8v9fSRvfBS6bfljjWT335OPYLcuDs5Cq1T0Wqpi0cEBUNZP6kBcx
	 kVWMGLPQn6VVg==
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
Subject: [RFC PATCH v6 10/11] PCI/TSM: Remove the legacy guest request interface
Date: Thu, 17 Sep 2026 19:31:58 +0530
Message-ID: <20260917140159.1163281-11-aneesh.kumar@kernel.org>
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

Guest TSM requests can now be dispatched through the IOMMUFD vdevice
operation. Remove the PCI-device-based guest request entry point, its
scope enum and the corresponding PCI/TSM driver callback.

Remove the sample guest request callback and tsm_request attribute along
with the API.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/pci/tsm/core.c    | 60 --------------------------------------
 include/linux/pci-tsm.h   | 61 +--------------------------------------
 samples/devsec/link_tsm.c | 52 +--------------------------------
 3 files changed, 2 insertions(+), 171 deletions(-)

diff --git a/drivers/pci/tsm/core.c b/drivers/pci/tsm/core.c
index 7082fdbe8c7e..c7e0d241e55d 100644
--- a/drivers/pci/tsm/core.c
+++ b/drivers/pci/tsm/core.c
@@ -398,66 +398,6 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
 }
 EXPORT_SYMBOL_GPL(pci_tsm_bind);
 
-/**
- * pci_tsm_guest_req() - helper to marshal guest requests to the TSM driver
- * @pdev: @pdev representing a bound tdi
- * @scope: caller asserts this passthrough request is limited to TDISP operations
- * @req_in: Input payload forwarded from the guest
- * @in_len: Length of @req_in
- * @req_out: Output payload buffer response to the guest
- * @out_len: Length of @req_out on input, bytes filled in @req_out on output
- * @tsm_code: Optional TSM arch specific result code for the guest TSM
- *
- * This is a common entry point for requests triggered by userspace KVM-exit
- * service handlers responding to TDI information or state change requests. The
- * scope parameter limits requests to TDISP state management, or limited debug.
- * This path is only suitable for commands and results that are the host kernel
- * has no use, the host is only facilitating guest to TSM communication.
- *
- * Returns 0 on success and -error on failure and positive "residue" on success
- * but @req_out is filled with less then @out_len, or @req_out is NULL and a
- * residue number of bytes were not consumed from @req_in.  On success or
- * failure @tsm_code may be populated with a TSM implementation specific result
- * code for the guest to consume.
- *
- * Context: Caller is responsible for calling this within the pci_tsm_bind()
- * state of the TDI.
- */
-ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
-			  sockptr_t req_in, size_t in_len, sockptr_t req_out,
-			  size_t out_len, u64 *tsm_code)
-{
-	struct pci_tsm_pf0 *tsm_pf0;
-	struct pci_tdi *tdi;
-	int rc;
-
-	/* Forbid requests that are not directly related to TDISP operations */
-	if (scope > PCI_TSM_REQ_STATE_CHANGE)
-		return -EINVAL;
-
-	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
-	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
-		return rc;
-
-	if (!pdev->tsm)
-		return -ENXIO;
-
-	if (!is_link_tsm(pdev->tsm->tsm_dev))
-		return -ENXIO;
-
-	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
-	ACQUIRE(mutex_intr, ops_lock)(&tsm_pf0->lock);
-	if ((rc = ACQUIRE_ERR(mutex_intr, &ops_lock)))
-		return rc;
-
-	tdi = pdev->tsm->tdi;
-	if (!tdi)
-		return -ENXIO;
-	return to_pci_tsm_ops(pdev->tsm)->guest_req(tdi, scope, req_in, in_len,
-						    req_out, out_len, tsm_code);
-}
-EXPORT_SYMBOL_GPL(pci_tsm_guest_req);
-
 static void pci_tsm_unbind_all(struct pci_dev *pdev)
 {
 	pci_tsm_walk_fns_reverse(pdev, __pci_tsm_unbind, NULL);
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 8869585230a3..15907bad47b7 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -4,14 +4,12 @@
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/rwsem.h>
-#include <linux/sockptr.h>
 #include <uapi/linux/hash_info.h>
 #include <uapi/linux/pci-tsm-netlink.h>
 
 struct pci_tsm;
 struct tsm_dev;
 struct kvm;
-enum pci_tsm_req_scope;
 
 /*
  * struct pci_tsm_ops - manage confidential links and security state
@@ -37,14 +35,13 @@ struct pci_tsm_ops {
 	 * @disconnect: teardown the secure link
 	 * @bind: bind a TDI in preparation for it to be accepted by a TVM
 	 * @unbind: remove a TDI from secure operation with a TVM
-	 * @guest_req: marshal TVM information and state change requests
 	 *
 	 * Context: @probe, @remove, @connect, and @disconnect run under
 	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
 	 * mutual exclusion of @connect and @disconnect. @connect and
 	 * @disconnect additionally run under the DSM lock (struct
 	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
-	 * @bind, @unbind, and @guest_req run under pci_tsm_rwsem held for read
+	 * @bind and @unbind run under pci_tsm_rwsem held for read
 	 * and the DSM lock.
 	 */
 	struct_group_tagged(pci_tsm_link_ops, link_ops,
@@ -56,11 +53,6 @@ struct pci_tsm_ops {
 		struct pci_tdi *(*bind)(struct pci_dev *pdev,
 					struct kvm *kvm, u32 tdi_id);
 		void (*unbind)(struct pci_tdi *tdi);
-		ssize_t (*guest_req)(struct pci_tdi *tdi,
-				     enum pci_tsm_req_scope scope,
-				     sockptr_t req_in, size_t in_len,
-				     sockptr_t req_out, size_t out_len,
-				     u64 *tsm_code);
 	);
 
 	/*
@@ -265,46 +257,6 @@ static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
 	return PCI_FUNC(pdev->devfn) == 0;
 }
 
-/**
- * enum pci_tsm_req_scope - Scope of guest requests to be validated by TSM
- *
- * Guest requests are a transport for a TVM to communicate with a TSM + DSM for
- * a given TDI. A TSM driver is responsible for maintaining the kernel security
- * model and limit commands that may affect the host, or are otherwise outside
- * the typical TDISP operational model.
- */
-enum pci_tsm_req_scope {
-	/**
-	 * @PCI_TSM_REQ_INFO: Read-only, without side effects, request for
-	 * typical TDISP collateral information like Device Interface Reports.
-	 * No device secrets are permitted, and no device state is changed.
-	 */
-	PCI_TSM_REQ_INFO = 0,
-	/**
-	 * @PCI_TSM_REQ_STATE_CHANGE: Request to change the TDISP state from
-	 * UNLOCKED->LOCKED, LOCKED->RUN, or other architecture specific state
-	 * changes to support those transitions for a TDI. No other (unrelated
-	 * to TDISP) device / host state, configuration, or data change is
-	 * permitted.
-	 */
-	PCI_TSM_REQ_STATE_CHANGE = 1,
-	/**
-	 * @PCI_TSM_REQ_DEBUG_READ: Read-only request for debug information
-	 *
-	 * A method to facilitate TVM information retrieval outside of typical
-	 * TDISP operational requirements. No device secrets are permitted.
-	 */
-	PCI_TSM_REQ_DEBUG_READ = 2,
-	/**
-	 * @PCI_TSM_REQ_DEBUG_WRITE: Device state changes for debug purposes
-	 *
-	 * The request may affect the operational state of the device outside of
-	 * the TDISP operational model. If allowed, requires CAP_SYS_RAW_IO, and
-	 * will taint the kernel.
-	 */
-	PCI_TSM_REQ_DEBUG_WRITE = 3,
-};
-
 #ifdef CONFIG_PCI_TSM
 int pci_tsm_register(struct tsm_dev *tsm_dev);
 void pci_tsm_unregister(struct tsm_dev *tsm_dev);
@@ -321,9 +273,6 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id);
 void pci_tsm_unbind(struct pci_dev *pdev);
 void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
 			     struct kvm *kvm, u32 tdi_id);
-ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
-			  sockptr_t req_in, size_t in_len, sockptr_t req_out,
-			  size_t out_len, u64 *tsm_code);
 struct pci_tsm_devsec *to_pci_tsm_devsec(struct pci_tsm *tsm);
 void pci_tsm_init_evidence(struct pci_tsm_evidence *evidence, int slot,
 			   enum hash_algo digest_algo);
@@ -346,14 +295,6 @@ static inline int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id
 static inline void pci_tsm_unbind(struct pci_dev *pdev)
 {
 }
-static inline ssize_t pci_tsm_guest_req(struct pci_dev *pdev,
-					enum pci_tsm_req_scope scope,
-					sockptr_t req_in, size_t in_len,
-					sockptr_t req_out, size_t out_len,
-					u64 *tsm_code)
-{
-	return -ENXIO;
-}
 #endif
 
 /* private: */
diff --git a/samples/devsec/link_tsm.c b/samples/devsec/link_tsm.c
index 21b6c3c7ea52..1d102dd9590a 100644
--- a/samples/devsec/link_tsm.c
+++ b/samples/devsec/link_tsm.c
@@ -260,22 +260,6 @@ static void devsec_link_tsm_unbind(struct pci_tdi *tdi)
 	kfree(devsec_tdi);
 }
 
-static ssize_t devsec_link_tsm_guest_req(struct pci_tdi *tdi,
-					 enum pci_tsm_req_scope scope,
-					 sockptr_t req_in, size_t in_len,
-					 sockptr_t req_out, size_t out_len,
-					 u64 *tsm_code)
-{
-	if (!sockptr_is_kernel(req_in))
-		return -ENXIO;
-
-	dev_dbg(pci_tsm_host(tdi->pdev), "%s\n", pci_name(tdi->pdev));
-	print_hex_dump_debug("devsec req_in  ", DUMP_PREFIX_OFFSET, 16, 4,
-			     req_in.kernel, min(in_len, 256u), true);
-
-	return 0;
-}
-
 static struct pci_tsm_ops devsec_link_pci_ops = {
 	.probe = devsec_link_tsm_pci_probe,
 	.remove = devsec_link_tsm_pci_remove,
@@ -283,7 +267,6 @@ static struct pci_tsm_ops devsec_link_pci_ops = {
 	.disconnect = devsec_link_tsm_disconnect,
 	.bind = devsec_link_tsm_bind,
 	.unbind = devsec_link_tsm_unbind,
-	.guest_req = devsec_link_tsm_guest_req,
 };
 
 static void devsec_link_tsm_remove(void *tsm_dev)
@@ -358,46 +341,13 @@ static ssize_t tsm_unbind_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(tsm_unbind);
 
-static ssize_t tsm_request_store(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *__buf, size_t count)
-{
-	ssize_t rc;
-	u64 tsm_code = 0;
-	struct device *host;
-	char req_out[16] = {0};
-	size_t out_len = sizeof(req_out);
-
-	struct pci_dev *pdev __free(pci_dev_put) = pci_find_device(__buf);
-	if (!pdev)
-		return -ENODEV;
-
-	char *buf __free(kvfree) = kvmemdup(__buf, count, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	host = pci_tsm_host(pdev);
-	if (!host || host != &devsec_link_tsm->dev)
-		return -ENXIO;
-
-	rc = pci_tsm_guest_req(pdev, PCI_TSM_REQ_INFO, KERNEL_SOCKPTR(buf),
-			       count, KERNEL_SOCKPTR(req_out), out_len,
-			       &tsm_code);
-	if (rc)
-		return rc;
-
-	return count;
-}
-static DEVICE_ATTR_WO(tsm_request);
-
 /*
- * Facilitate testing of the bind and request flows in lieu of VFIO/IOMMUFD
+ * Facilitate testing of the bind flows in lieu of VFIO/IOMMUFD
  * support to exercise these paths.
  */
 static struct attribute *devsec_link_attrs[] = {
 	&dev_attr_tsm_bind.attr,
 	&dev_attr_tsm_unbind.attr,
-	&dev_attr_tsm_request.attr,
 	NULL,
 };
 
-- 
2.43.0

