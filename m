Return-Path: <SRS0=kdGy=CM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C01C433E7
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 06:57:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF022071B
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 06:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF022071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D982186B3A;
	Thu,  3 Sep 2020 06:57:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id et+tTF3HTeC6; Thu,  3 Sep 2020 06:57:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A594786A81;
	Thu,  3 Sep 2020 06:57:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8820CC07FF;
	Thu,  3 Sep 2020 06:57:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7468C0051
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 06:57:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B518286BCB
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 06:57:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KittGN2qvb1Y for <iommu@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 06:57:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C025586BC9
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 06:57:15 +0000 (UTC)
IronPort-SDR: 7xMzcAkQbCDlAf3dQvZT4MHVHYgX8SE65e3pOqjb6NgLNY4mg1+RZa8YxKXMJZ/I5cIw6g6MpC
 Pl/XUFftdN4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="175581014"
X-IronPort-AV: E=Sophos;i="5.76,385,1592895600"; d="scan'208";a="175581014"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 23:57:15 -0700
IronPort-SDR: 3rpoH/VVmKxA4JzDJ5fwhT9V2zm0Lj0UBEE7wr49q1DxwG9qHJ1uuS9o/WFSWbzEA+FYHQ4BgV
 v0R3a4M+QEXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,385,1592895600"; d="scan'208";a="405397696"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 02 Sep 2020 23:57:12 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/1] iommu/vt-d: Fix NULL pointer dereference in
 dev_iommu_priv_set()
Date: Thu,  3 Sep 2020 14:51:32 +0800
Message-Id: <20200903065132.16879-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Wendy Wang <wendy.wang@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Torsten Hilbrich <torsten.hilbrich@secunet.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The dev_iommu_priv_set() must be called after probe_device(). This fixes
a NULL pointer deference bug when booting a system with kernel cmdline
"intel_iommu=on,igfx_off", where the dev_iommu_priv_set() is abused.

The following stacktrace was produced:

[    0.000000] Command line: BOOT_IMAGE=/isolinux/bzImage console=tty1 intel_iommu=on,igfx_off
...
[    3.341682] DMAR: Host address width 39
[    3.341684] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    3.341702] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
[    3.341705] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    3.341711] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    3.341713] DMAR: RMRR base: 0x0000009aa9f000 end: 0x0000009aabefff
[    3.341716] DMAR: RMRR base: 0x0000009d000000 end: 0x0000009f7fffff
[    3.341726] DMAR: No ATSR found
[    3.341772] BUG: kernel NULL pointer dereference, address: 0000000000000038
[    3.341774] #PF: supervisor write access in kernel mode
[    3.341776] #PF: error_code(0x0002) - not-present page
[    3.341777] PGD 0 P4D 0
[    3.341780] Oops: 0002 [#1] SMP PTI
[    3.341783] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.9.0-devel+ #2
[    3.341785] Hardware name: LENOVO 20HGS0TW00/20HGS0TW00, BIOS N1WET46S (1.25s ) 03/30/2018
[    3.341790] RIP: 0010:intel_iommu_init+0xed0/0x1136
[    3.341792] Code: fe e9 61 02 00 00 bb f4 ff ff ff e9 57 02 00 00 48 63 d1 48 c1 e2 04 48
                     03 50 20 48 8b 12 48 85 d2 74 0b 48 8b 92 d0 02 00 00 48 89 7a 38 ff c1
                     e9 15 f5 ff ff 48 c7 c7 60 99 ac a7 49 c7 c7 a0
[    3.341796] RSP: 0000:ffff96d180073dd0 EFLAGS: 00010282
[    3.341798] RAX: ffff8c91037a7d20 RBX: 0000000000000000 RCX: 0000000000000000
[    3.341800] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffffffffff
[    3.341802] RBP: ffff96d180073e90 R08: 0000000000000001 R09: ffff8c91039fe3c0
[    3.341804] R10: 0000000000000226 R11: 0000000000000226 R12: 000000000000000b
[    3.341806] R13: ffff8c910367c650 R14: ffffffffa8426d60 R15: 0000000000000000
[    3.341808] FS:  0000000000000000(0000) GS:ffff8c9107480000(0000) knlGS:0000000000000000
[    3.341810] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.341812] CR2: 0000000000000038 CR3: 00000004b100a001 CR4: 00000000003706e0
[    3.341814] Call Trace:
[    3.341820]  ? _raw_spin_unlock_irqrestore+0x1f/0x30
[    3.341824]  ? call_rcu+0x10e/0x320
[    3.341828]  ? trace_hardirqs_on+0x2c/0xd0
[    3.341831]  ? rdinit_setup+0x2c/0x2c
[    3.341834]  ? e820__memblock_setup+0x8b/0x8b
[    3.341836]  pci_iommu_init+0x16/0x3f
[    3.341839]  do_one_initcall+0x46/0x1e4
[    3.341842]  kernel_init_freeable+0x169/0x1b2
[    3.341845]  ? rest_init+0x9f/0x9f
[    3.341847]  kernel_init+0xa/0x101
[    3.341849]  ret_from_fork+0x22/0x30
[    3.341851] Modules linked in:
[    3.341854] CR2: 0000000000000038
[    3.341860] ---[ end trace 3653722a6f936f18 ]---

Fixes: 01b9d4e21148c ("iommu/vt-d: Use dev_iommu_priv_get/set()")
Reported-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Reported-by: Wendy Wang <wendy.wang@intel.com>
Link: https://lore.kernel.org/linux-iommu/96717683-70be-7388-3d2f-61131070a96a@secunet.com/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 100 ++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 45 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 50431c7b2e71..777b9be60a0e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -366,7 +366,6 @@ static int iommu_skip_te_disable;
 int intel_iommu_gfx_mapped;
 EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
 
-#define DUMMY_DEVICE_DOMAIN_INFO ((struct device_domain_info *)(-1))
 #define DEFER_DEVICE_DOMAIN_INFO ((struct device_domain_info *)(-2))
 struct device_domain_info *get_domain_info(struct device *dev)
 {
@@ -376,8 +375,7 @@ struct device_domain_info *get_domain_info(struct device *dev)
 		return NULL;
 
 	info = dev_iommu_priv_get(dev);
-	if (unlikely(info == DUMMY_DEVICE_DOMAIN_INFO ||
-		     info == DEFER_DEVICE_DOMAIN_INFO))
+	if (unlikely(info == DEFER_DEVICE_DOMAIN_INFO))
 		return NULL;
 
 	return info;
@@ -773,11 +771,6 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 	return &context[devfn];
 }
 
-static int iommu_dummy(struct device *dev)
-{
-	return dev_iommu_priv_get(dev) == DUMMY_DEVICE_DOMAIN_INFO;
-}
-
 static bool attach_deferred(struct device *dev)
 {
 	return dev_iommu_priv_get(dev) == DEFER_DEVICE_DOMAIN_INFO;
@@ -810,6 +803,53 @@ is_downstream_to_pci_bridge(struct device *dev, struct device *bridge)
 	return false;
 }
 
+static bool quirk_ioat_snb_local_iommu(struct pci_dev *pdev)
+{
+	struct dmar_drhd_unit *drhd;
+	u32 vtbar;
+	int rc;
+
+	/* We know that this device on this chipset has its own IOMMU.
+	 * If we find it under a different IOMMU, then the BIOS is lying
+	 * to us. Hope that the IOMMU for this device is actually
+	 * disabled, and it needs no translation...
+	 */
+	rc = pci_bus_read_config_dword(pdev->bus, PCI_DEVFN(0, 0), 0xb0, &vtbar);
+	if (rc) {
+		/* "can't" happen */
+		dev_info(&pdev->dev, "failed to run vt-d quirk\n");
+		return false;
+	}
+	vtbar &= 0xffff0000;
+
+	/* we know that the this iommu should be at offset 0xa000 from vtbar */
+	drhd = dmar_find_matched_drhd_unit(pdev);
+	if (!drhd || drhd->reg_base_addr - vtbar != 0xa000) {
+		pr_warn_once(FW_BUG "BIOS assigned incorrect VT-d unit for Intel(R) QuickData Technology device\n");
+		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+		return true;
+	}
+
+	return false;
+}
+
+static bool iommu_is_dummy(struct intel_iommu *iommu, struct device *dev)
+{
+	if (!iommu || iommu->drhd->ignored)
+		return true;
+
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
+		    pdev->device == PCI_DEVICE_ID_INTEL_IOAT_SNB &&
+		    quirk_ioat_snb_local_iommu(pdev))
+			return true;
+	}
+
+	return false;
+}
+
 struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
 {
 	struct dmar_drhd_unit *drhd = NULL;
@@ -819,7 +859,7 @@ struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
 	u16 segment = 0;
 	int i;
 
-	if (!dev || iommu_dummy(dev))
+	if (!dev)
 		return NULL;
 
 	if (dev_is_pci(dev)) {
@@ -836,7 +876,7 @@ struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
 		dev = &ACPI_COMPANION(dev)->dev;
 
 	rcu_read_lock();
-	for_each_active_iommu(iommu, drhd) {
+	for_each_iommu(iommu, drhd) {
 		if (pdev && segment != drhd->segment)
 			continue;
 
@@ -872,6 +912,9 @@ struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
 	}
 	iommu = NULL;
  out:
+	if (iommu_is_dummy(iommu, dev))
+		iommu = NULL;
+
 	rcu_read_unlock();
 
 	return iommu;
@@ -2479,7 +2522,7 @@ struct dmar_domain *find_domain(struct device *dev)
 {
 	struct device_domain_info *info;
 
-	if (unlikely(attach_deferred(dev) || iommu_dummy(dev)))
+	if (unlikely(attach_deferred(dev)))
 		return NULL;
 
 	/* No lock here, assumes no domain exit in normal case */
@@ -4021,35 +4064,6 @@ static void __init iommu_exit_mempool(void)
 	iova_cache_put();
 }
 
-static void quirk_ioat_snb_local_iommu(struct pci_dev *pdev)
-{
-	struct dmar_drhd_unit *drhd;
-	u32 vtbar;
-	int rc;
-
-	/* We know that this device on this chipset has its own IOMMU.
-	 * If we find it under a different IOMMU, then the BIOS is lying
-	 * to us. Hope that the IOMMU for this device is actually
-	 * disabled, and it needs no translation...
-	 */
-	rc = pci_bus_read_config_dword(pdev->bus, PCI_DEVFN(0, 0), 0xb0, &vtbar);
-	if (rc) {
-		/* "can't" happen */
-		dev_info(&pdev->dev, "failed to run vt-d quirk\n");
-		return;
-	}
-	vtbar &= 0xffff0000;
-
-	/* we know that the this iommu should be at offset 0xa000 from vtbar */
-	drhd = dmar_find_matched_drhd_unit(pdev);
-	if (!drhd || drhd->reg_base_addr - vtbar != 0xa000) {
-		pr_warn_once(FW_BUG "BIOS assigned incorrect VT-d unit for Intel(R) QuickData Technology device\n");
-		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
-		dev_iommu_priv_set(&pdev->dev, DUMMY_DEVICE_DOMAIN_INFO);
-	}
-}
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IOAT_SNB, quirk_ioat_snb_local_iommu);
-
 static void __init init_no_remapping_devices(void)
 {
 	struct dmar_drhd_unit *drhd;
@@ -4081,12 +4095,8 @@ static void __init init_no_remapping_devices(void)
 		/* This IOMMU has *only* gfx devices. Either bypass it or
 		   set the gfx_mapped flag, as appropriate */
 		drhd->gfx_dedicated = 1;
-		if (!dmar_map_gfx) {
+		if (!dmar_map_gfx)
 			drhd->ignored = 1;
-			for_each_active_dev_scope(drhd->devices,
-						  drhd->devices_cnt, i, dev)
-				dev_iommu_priv_set(dev, DUMMY_DEVICE_DOMAIN_INFO);
-		}
 	}
 }
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
