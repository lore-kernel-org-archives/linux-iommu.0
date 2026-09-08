Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6536B2620DE
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 04:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788840749; cv=fail; b=KgXj9atDKtFKLqTZML4oHR7RjoN4FBLo/9w/ua0kKPhUWvaCkXB+gtzAFBTfHu4w3IfzwnQ8vccNOrodV92b78737bTB8aMIolHMYt02nFRuwUvtKuHTQiFmNpWi0hRxZaEMjLd+fHpwzkyyj4TEVr8mnDhy1+RoWDU0TZ9YG+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788840749; c=relaxed/simple;
	bh=hehAx+jNXCC78nfXM3VO73Kuyab5VlQ9eiJb73QfjsQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPhIWTJIP37FWuaQtDfqErO7BxN0ThG1bOc8H+CmKIr2uprMp7l9NfYYnQnwNHLt0MEY5xtNyYoI9Z235PX+dp35RVk8lTxatklaUtiaO8ZZV7u+n4nn2ibWDgjc+Xxu+o+PnmtSw3dsAQuvgnfuQ3xMUTE7Xk4gVphgQpNmQaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KMDBRTdt; arc=fail smtp.client-ip=52.101.62.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KMDBRTdt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmYUVdXKJDxawoB/A8uWxx/KT1goiu8NC0S/lG/mTT84Z7AGqIGQzCEYWqva6yBpHi884fAT8q9a33aay4TS020l1Tz3X8rqmALeoh4elaYCNErGBoeaQyHMzRgGjQ/sG7CuBm3Nn1YDhWJ67uxVwZHvmo2trk7Wq9IkJUOCCZiypkV31aVdpr/Vsu4JdO6tT872Nq/nG8hqUun1qmqMCg/Ot/OdB0UTsVJDl6OHIVKVbofxZ9gxYvPduHDAK7KpuqZpOU63Q75kV0wuTNH8vxq3Kken+xy5IuzovGRPSA16T+nstkUSRas9uwL789hg3Zo1s2uouItM47bnUI35VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQD5xHfRIKuNhHs0QBWjT68I6FtcjwA5ArP9VqtzKxg=;
 b=SItFjy3QqtoYAL8COBz25FkcG1ftKC2AKEBnUJ9NX+Sw6C8FHz7E63rnFm3fDNdZKyuK9bAH4Wj51Uq7v6GNdVtFkg4kUt7xf4kEQXQZAUYpkh40iK0XjtDR4etFCFz3xEcPJbfZeVlj4z/km4ntQ61zG/IysUmd/Lx7v3Syq1EYoRiQtWEnzHyY38rpImKGV5kr7FXH7DVaz8TAc+6NhdASxO1Y4ib/7INkUoi/wYzchgW2H4uQ0VcCldrE5399Mk+DXrJWvTMyK6QBKsNxpbXCkG5SeUkmKOqJdfUmorW2k3vVitGVPoV70xOOlz3a4uo8Q+iXU3Tj9C6dIqGBPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQD5xHfRIKuNhHs0QBWjT68I6FtcjwA5ArP9VqtzKxg=;
 b=KMDBRTdtKkf7hYOGre/w5+uMDZcoMlBpT4ckh3oNCPjLmXuVMlo3DiUA/qL5BOqzoBubMkTpe1UqFdILWo6qDVrRajl5GJ/7XknxKUJaVAwBuUsQJOB9LPeTeH0wndyeEJyMQoUkkUYO79Aizh/yaDdIJqOAT13OxW4y4+Yn684=
Received: from BN9PR03CA0440.namprd03.prod.outlook.com (2603:10b6:408:113::25)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 04:12:22 +0000
Received: from LV8PEPF0000005D.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::82) by BN9PR03CA0440.outlook.office365.com
 (2603:10b6:408:113::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 04:12:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005D.mail.protection.outlook.com (10.167.245.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 04:12:22 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:12:21 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>
CC: <amd-gfx@lists.freedesktop.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "open
 list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>, Jatin Kataria
	<jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>, Mario Limonciello
	<mario.limonciello@amd.com>, "Derek J . Clark" <derekjohn.clark@gmail.com>
Subject: [PATCH v2 2/2] drm/amdgpu: Enable PerfOpt IOMMU perf optimization when GPU in identity domain
Date: Mon, 7 Sep 2026 23:12:07 -0500
Message-ID: <20260908041207.38113-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908041207.38113-1-mario.limonciello@amd.com>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005D:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 236b6271-1132-4461-4049-08df0d5f620b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fE/l1dW1FOZQ6N307TVQzk6rmEY+la4+RGYIURZhudxJYHFs5t8FF/QGpXwFuELnr1TVluazdw0BNr7bR6TIx7O7w+uM3N2gN0WIigK3OwC81I67jlH8yjwnA+EIPOs/3sbLIsYVDScD6SVrs3PgOfZSaNdzdNgR0hGalqgKMpKLn56BMtj02ydtPMLBPON60/NGLprqc6pWL8L7UrKPSBfNTUukOvp5n8O/jtlIx5p7ExBDdT5/4H/wHi+Kxt/tk4BurfpwZP0zAHV79zEj4k+JUogaloJ/bppHLz2J0QnW9SN8AIEzUVgSJsqVQctmZSl2lhh6qSZMcoS90uZj4hls3+RK8Aurfln7aA+kVUVevZW0LMccYmv+tU+160Og4DBIshWbviQqONdOp+a2d6+t/XD8YLv+NB44gK3XdQBYsgmpSmOkTTfzPm0W0wopYJtakbAKudoKZOmJddhTaR6LCl9OCRE5hSQaQGxNTfIrYQltYLWxgDrUSByDI6AMa895hQv5om54MzD6jnnbLoKI781580/ci/JsBgRYQs5ftd0BL6L25YXSrFsMbUrFWEWukmmiaWvzQK+aF7iySsP2xYuqHKTdmb6Ot1yJlEOHrX9KV3Owkli4Q7x5TfLqh4ErdP6le+30Xl7VxSZha/t/X8Rp0HvNuDkH9QauYFnNdbYl3bJyO9oXWz22yDrSSuSkVUOjAEfPREYEwhWRrA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YBi0IHcR97gbiAHGe9cLtD4mxk2xUQMcxdKusK3eC2RJs/th+jTh70QJIixWEKY2AerCGaJqQ/PxdK7cz+scudB6vPU04GVGD7mFAdGP/KfPI35hSB3n/UA9dXT+uXl5cShACYAsXFlPmr5E73Dd+vICti3RcLl/xk2TPwjxq13zs4dcQyk5M9XTV0RLGMHOaxJGS/n6W5TrU2lIDWfM3NPEMwLPUhy3dj6uqyxlgoSpS5iQ5ZKbMJyJDhUcwKIwYZDpSf097gFY7IglXCSpVBcjsMRFrjyhGQurJQTDPjM8Fem5wExIe3iMUI/jMPtkRm8J52uvC/cwjBPC7+nlxNbTPmUPpD7pKq1kWABTkl7eqdKXg1e/qRN6LVRGaILbWckYGVmFZ0kYSzRGWNFN2J34kw9qQy/mX0Hc+vWM22McqlTfKMVqu4w4BfDW9fO4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 04:12:22.7439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 236b6271-1132-4461-4049-08df0d5f620b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775

Enable PerfOpt via amd_iommu_enable_perfopt() when the GPU's
iommu_perfopt module parameter is enabled (default 1) and the GPU
resides in the identity domain. The identity domain means the GPU is
already performing direct DMA with the IOMMU only enforcing IR/IW
permission bits -- no GPA->SPA translations.

amd_iommu_enable_perfopt() clears ATS, PRI, PASID and SVA for the
device. This is safe in identity domain because DTE[I]=0 means the
IOMMU already returns target abort for ATS requests from this
peripheral and the GPU manages its own TLB.

PerfOpt is a soft, optional latency optimization: failing to arm it (for
example on an IOMMU that does not implement the feature, which returns
-ENODEV) must not be fatal, so probe and resume warn and continue rather
than aborting.

PERF_OPT_EN is a per-IOMMU control shared by all devices behind that
IOMMU; the IOMMU driver reference counts it so that on systems where
multiple devices share one IOMMU, one GPU's teardown does not clear the
bit while a peer still requires it.

Arming PerfOpt trades IOMMU DMA containment for lower DMA latency. This
is enabled by default for GPUs in the identity domain as a deliberate,
documented policy and can be disabled with iommu_perfopt=0.

The AMD IOMMU spec indicates this is only supported on integrated GPUs
so check explicitly for AMD_IS_APU (which is set by
amdgpu_device_ip_early_init()).

PerfOpt is disabled during GPU init teardown and restored on resume.

Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Add tag (Derek)
 * Use -1 for default module option (Alex)
 * Add a function to check whether to use perf opt
   Allows one place to control all the places for policy.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 50 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 12 ++++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7974f9b7944f3..930a78db7132e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -156,6 +156,7 @@ struct amdgpu_watchdog_timer {
  * Modules parameters.
  */
 extern int amdgpu_modeset;
+extern int amdgpu_iommu_perfopt;
 extern unsigned int amdgpu_vram_limit;
 extern int amdgpu_vis_vram_limit;
 extern int amdgpu_gart_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 104d1d2cbad96..57dedf3cffdaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -33,6 +33,7 @@
 #include <linux/console.h>
 #include <linux/slab.h>
 #include <linux/iommu.h>
+#include <linux/amd-iommu.h>
 #include <linux/pci.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/apple-gmux.h>
@@ -3755,6 +3756,28 @@ amdgpu_device_should_register_switcheroo(struct amdgpu_device *adev, bool px)
 		       apple_gmux_detect(NULL, NULL)));
 }
 
+static inline bool amdgpu_device_identity(struct amdgpu_device *adev)
+{
+	struct pci_dev *pdev = adev->pdev;
+	struct iommu_domain *domain = iommu_get_domain_for_dev(&pdev->dev);
+
+	if (!domain)
+		return false;
+
+	return domain->type == IOMMU_DOMAIN_IDENTITY;
+}
+
+static bool amdgpu_device_use_perfopt(struct amdgpu_device *adev)
+{
+	if (amdgpu_iommu_perfopt == 0)
+		return false;
+
+	if (!(adev->flags & AMD_IS_APU))
+		return false;
+
+	return amdgpu_device_identity(adev);
+}
+
 /**
  * amdgpu_device_init - initialize the driver
  *
@@ -3961,6 +3984,16 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
+	if (amdgpu_device_use_perfopt(adev)) {
+		int perfopt_ret = amd_iommu_enable_perfopt(pdev);
+
+		/* Optional optimization; a failure to arm it must not abort probe. */
+		if (perfopt_ret)
+			dev_warn(adev->dev,
+				 "Failed to enable IOMMU PerfOpt (%d); continuing without it\n",
+				 perfopt_ret);
+	}
+
 	/*
 	 * No need to remove conflicting FBs for non-display class devices.
 	 * This prevents the sysfb from being freed accidently.
@@ -4330,6 +4363,9 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	amdgpu_gart_dummy_page_fini(adev);
 
+	if (amdgpu_device_use_perfopt(adev))
+		amd_iommu_disable_perfopt(adev->pdev);
+
 	if (pci_dev_is_disconnected(adev->pdev))
 		amdgpu_device_unmap_mmio(adev);
 
@@ -4695,6 +4731,20 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
+	if (amdgpu_device_use_perfopt(adev)) {
+		int perfopt_ret = amd_iommu_enable_perfopt(adev->pdev);
+
+		/*
+		 * Must not return on failure: a bare return would leak the
+		 * SR-IOV VF exclusive-mode acquisition taken above (released
+		 * via the exit: path).
+		 */
+		if (perfopt_ret)
+			dev_warn(adev->dev,
+				 "Failed to enable IOMMU PerfOpt (%d); continuing without it\n",
+				 perfopt_ret);
+	}
+
 	if (adev->in_s0ix)
 		amdgpu_dpm_gfx_state_change(adev, sGpuChangeState_D0Entry);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5b08afde37baf..7b54ca8beeb4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -185,6 +185,7 @@ char *amdgpu_disable_cu;
 char *amdgpu_virtual_display;
 int amdgpu_enforce_isolation = -1;
 int amdgpu_modeset = -1;
+int amdgpu_iommu_perfopt = -1;
 
 /* Specifies the default granularity for SVM, used in buffer
  * migration and restoration of backing memory when handling
@@ -392,6 +393,17 @@ module_param_named(fw_load_type, amdgpu_fw_load_type, int, 0444);
 MODULE_PARM_DESC(aspm, "ASPM support (1 = enable, 0 = disable, -1 = auto)");
 module_param_named(aspm, amdgpu_aspm, int, 0444);
 
+/**
+ * DOC: iommu_perfopt (int)
+ * Control the AMD IOMMU PerfOpt DMA-latency optimization
+ * (0 = disable; -1 = enable on supported devices).
+ * This arms the IOMMU PerfOpt control (IOMMU spec, MMIO Offset 016Ch, EFR PerfOptSup / PerfOptEn)
+ * Arming it disables ATS, PRI, PASID and SVA for the GPU and removes IOMMU DMA containment for it,
+ * trading isolation for lower DMA latency.
+ */
+MODULE_PARM_DESC(iommu_perfopt, "Control IOMMU PerfOpt DMA-latency optimization (-1 = enable on supported devices, 0 = disable)");
+module_param_named(iommu_perfopt, amdgpu_iommu_perfopt, int, 0444);
+
 /**
  * DOC: runpm (int)
  * Override for runtime power management control for dGPUs. The amdgpu driver can dynamically power down
-- 
2.43.0

