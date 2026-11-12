Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458653;
	b=0DdqeyoyliIGZpZeQpvBHe3MsactzyRs5XhjnlTUUYdCsP532js8s3z8C0FQ7utrXqSg
	 jMDVQqHWiw2/744NQJ3wH3lScvjjxfK7A7KIp+GxDagGJE7ATAePJIu2zu1ep99ulJ6+9
	 ztEekiArtgibnCAsg9jxSTFpYsmjDvWoei7AJJYmLd9wfvRqjsE5WBzHkgsVoM1wdBHJb
	 Um6sKy95k346P4tNGTNtky3YdrJOvM6FNpfrF68dI+Gr4MjOAxvSrFZamdvF7s0ZrrIU3
	 q/aLI6luFtOJ6jvzTS2pABu1zFwDsau92cf4Drm4OQYfd/lKjj2T7yfU40Y3WVmXg/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458653;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OJZB/KWGVqc2T1AsmUrF/xg+bbNeF2TYlPgy84jekk8=;
	b=nPp9Z/Z9011mqNVWHzIG3cqSYTyLIWWFbYMINnI4Pvpca8KGI5+xK60HWx1Kv7WsXR2B
	 OIL5oodV9yFYagA/8+2wS0h6ZiXy7ZRLidbmB5Xh3HmD1pbTSES8tnjNFaPa3+sIfHwjA
	 feaoA8AjuzFtiVo27ZDHWDohSICUS+GauUvyAxUMTmWYvkE1ziZo9hiJFH6U8qix9m7sE
	 +/CvfPLrUp7qzdACIo8dbqY5aSbzVBOj85iRJuoVGdfI2u2Rgl0txi3rkFOFuL8o+Q6Oy
	 saxIxfATfAC+BtQvHya2t1N+6w96NOHrj1cfPWWlB7fRUVwG5fgX1XiL3KMIzC9ULZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D1kuSpqc;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C13E606A89C;
	Thu, 12 Nov 2026 04:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C13E606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D1kuSpqc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794458652; x=1825994652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hcsXVEn81AeXzJnd7PHsl4rkkzcb2igGpk9RZpo0Rdg=;
  b=D1kuSpqcnl+0Doe4U3dDCNzP1HpeDC42i9scqm3MklNBNsDMoqTzuBrc
   DOG2IqiUO+kjhK7iecowRcxaBzcpOGy8Sk0JjcHp/CucNH/gCS7XGWLUz
   IKWknayCS1Rzi/g4YvHYQEAYv/NNVeunT/8fT9Ez0pDuznBe4C/sLt/AR
   DtPoGLQ8aJ0sqpfp49mjRWyt/cqEphDakfLlvD+15gF2PfMSOh2lX/UFJ
   jnKYpZ1wQurpbxGHkuz70VVEUMufSmccfpXlxqAPPwifmeed7nItNBcXg
   kJY9SzXnL4oNd39pOcGAVhO89xNRBSqnvmackSUzZ2o0+V032ndCgtTHV
   Q==;
X-CSE-ConnectionGUID: iHlLuY+mQjOim8KBSTWg/w==
X-CSE-MsgGUID: XYoQBNM5R5WWBYCPpkLxiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3318371"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3318371"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 20:44:12 -0800
X-CSE-ConnectionGUID: 2EU4aIJTRKSLsU32oCEL5g==
X-CSE-MsgGUID: AermUxDiTtO68FmVorFxJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8728667"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa002.fm.intel.com with ESMTP; 11 Nov 2026 20:44:08 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 7/9] coco/tdx-host: Add skeleton to support PCI link encryption
Date: Thu, 12 Nov 2026 12:30:52 +0800
Message-ID: <20261112043054.2664857-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register a Link TSM instance to support host side TSM operations for
TDISP, when the TDX Connect support bit is set by TDX Module in
tdx_feature0.

This is the main purpose of an independent tdx-host module out of TDX
core. Recall that a TEE Security Manager (TSM) is a platform agent that
speaks the TEE Device Interface Security Protocol (TDISP) to PCIe
devices and manages private memory resources for the platform. An
independent tdx-host module allows for device-security enumeration and
initialization flows to be deferred from other TDX Module initialization
requirements. Crucially, when / if TDX Module init moves earlier in x86
initialization flow this driver is still guaranteed to run after IOMMU
and PCI init (i.e. subsys_initcall() vs device_initcall()).

The ability to unload the module, or unbind the driver is also useful
for debug and coarse grained transitioning between PCI TSM operation and
PCI CMA operation (native kernel PCI device authentication).

For now only check for TDX Connect support in the TDX Module and
register the Link TSM. The TSM support is basic boilerplate with
operation flows to be added later.

Based on work by Yilun and Dan.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/virt/coco/tdx-host/Kconfig    |   2 +
 arch/x86/include/asm/tdx.h            |   8 ++
 drivers/virt/coco/tdx-host/tdx-host.c | 118 +++++++++++++++++++++++++-
 3 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/coco/tdx-host/Kconfig b/drivers/virt/coco/tdx-host/Kconfig
index 57d0c01a4357..f8c8cc29d46c 100644
--- a/drivers/virt/coco/tdx-host/Kconfig
+++ b/drivers/virt/coco/tdx-host/Kconfig
@@ -1,6 +1,8 @@
 config TDX_HOST_SERVICES
 	tristate
 	depends on INTEL_TDX_HOST
+	depends on PCI
 	select FW_LOADER
 	select FW_UPLOAD
+	select PCI_TSM
 	default m
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 0ed0062c9b0a..fc284a555984 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -142,6 +142,14 @@ int tdx_topup_pamt_cache(struct tdx_pamt_cache *cache, unsigned long npages);
 int tdx_pamt_get(kvm_pfn_t pfn, struct tdx_pamt_cache *cache);
 void tdx_pamt_put(kvm_pfn_t pfn);
 
+static inline bool tdx_supports_tdisp(const struct tdx_sys_info *sysinfo)
+{
+	if (!(sysinfo->features.tdx_features0 & TDX_FEATURES0_TDXCONNECT))
+		return false;
+
+	return false; /* To be enabled when kernel is ready */
+}
+
 int tdx_guest_keyid_alloc(void);
 u32 tdx_get_nr_guest_keyids(void);
 void tdx_guest_keyid_free(unsigned int keyid);
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index e8ed8dfa526e..0908aaaa28ac 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -9,10 +9,14 @@
 #include <linux/firmware.h>
 #include <linux/module.h>
 #include <linux/sysfs.h>
+#include <linux/pci.h>
+#include <linux/pci-tsm.h>
+#include <linux/tsm.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/seamldr.h>
 #include <asm/tdx.h>
+#include <asm/tdx_global_metadata.h>
 
 static const struct x86_cpu_id tdx_host_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_TDX_HOST_PLATFORM, NULL),
@@ -20,6 +24,112 @@ static const struct x86_cpu_id tdx_host_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, tdx_host_ids);
 
+struct tdx_tsm_link {
+	struct pci_tsm_pf0 pci;
+};
+
+static struct tdx_tsm_link *to_tdx_tsm_link(struct pci_tsm *tsm)
+{
+	return container_of(tsm, struct tdx_tsm_link, pci.base_tsm);
+}
+
+static int tdx_tsm_link_connect(struct pci_dev *pdev)
+{
+	return -ENXIO;
+}
+
+static void tdx_tsm_link_disconnect(struct pci_dev *pdev)
+{
+}
+
+static struct pci_tsm *tdx_tsm_link_pf0_probe(struct tsm_dev *tsm_dev,
+					      struct pci_dev *pdev)
+{
+	int rc;
+
+	struct tdx_tsm_link *tlink __free(kfree) = kzalloc_obj(*tlink);
+	if (!tlink)
+		return NULL;
+
+	rc = pci_tsm_pf0_constructor(pdev, &tlink->pci, tsm_dev);
+	if (rc)
+		return NULL;
+
+	return &no_free_ptr(tlink)->pci.base_tsm;
+}
+
+static void tdx_tsm_link_pf0_remove(struct pci_tsm *tsm)
+{
+	struct tdx_tsm_link *tlink = to_tdx_tsm_link(tsm);
+
+	pci_tsm_pf0_destructor(&tlink->pci);
+	kfree(tlink);
+}
+
+static struct pci_tsm *tdx_tsm_link_fn_probe(struct tsm_dev *tsm_dev,
+					     struct pci_dev *pdev)
+{
+	int rc;
+
+	struct pci_tsm *pci_tsm __free(kfree) = kzalloc_obj(*pci_tsm);
+	if (!pci_tsm)
+		return NULL;
+
+	rc = pci_tsm_link_constructor(pdev, pci_tsm, tsm_dev);
+	if (rc)
+		return NULL;
+
+	return no_free_ptr(pci_tsm);
+}
+
+static struct pci_tsm *tdx_tsm_link_probe(struct tsm_dev *tsm_dev,
+					  struct pci_dev *pdev)
+{
+	if (is_pci_tsm_pf0(pdev))
+		return tdx_tsm_link_pf0_probe(tsm_dev, pdev);
+
+	return tdx_tsm_link_fn_probe(tsm_dev, pdev);
+}
+
+static void tdx_tsm_link_remove(struct pci_tsm *tsm)
+{
+	if (is_pci_tsm_pf0(tsm->pdev)) {
+		tdx_tsm_link_pf0_remove(tsm);
+		return;
+	}
+
+	/* for sub-functions */
+	kfree(tsm);
+}
+
+static struct pci_tsm_ops tdx_tsm_link_ops = {
+	.probe = tdx_tsm_link_probe,
+	.remove = tdx_tsm_link_remove,
+	.connect = tdx_tsm_link_connect,
+	.disconnect = tdx_tsm_link_disconnect,
+};
+
+static void unregister_link_tsm(void *link)
+{
+	tsm_unregister(link);
+}
+
+static int tdx_tdisp_init(struct device *dev)
+{
+	const struct tdx_sys_info *sysinfo = tdx_get_sysinfo();
+	struct tsm_dev *link;
+
+	if (!sysinfo || !tdx_supports_tdisp(sysinfo))
+		return 0;
+
+	link = tsm_register(dev, &tdx_tsm_link_ops);
+	if (IS_ERR(link))
+		return dev_err_probe(dev, PTR_ERR(link),
+				     "failed to register TSM\n");
+
+	return devm_add_action_or_reset(dev, unregister_link_tsm, link);
+}
+
 static ssize_t version_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
@@ -204,7 +314,13 @@ static int seamldr_init(struct device *dev)
 
 static int tdx_host_probe(struct faux_device *fdev)
 {
-	return seamldr_init(&fdev->dev);
+	int ret;
+
+	ret = seamldr_init(&fdev->dev);
+	if (ret)
+		return ret;
+
+	return tdx_tdisp_init(&fdev->dev);
 }
 
 static const struct faux_device_ops tdx_host_ops = {
-- 
2.43.0

