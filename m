Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C5F2D12EE
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 05:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155496; cv=fail; b=bFNKZx+Mlf1zYWV2cpVEmHzZTGSFgqy7RFv6OrgXnRGW5OtvLqICy1eMJHmnbmNH/Uz3TrXzJ1N276fVv5ziiKWCdjSyW89C4C4FYApSa8FaCOrlXJLgesSBDRhpWMQb51jUerVOkaljGansmR3EDUf3ZcGDss6Ivz8BJxCUOEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155496; c=relaxed/simple;
	bh=X4H68P8Kwuo3YLt67NHNbQ/UxA0xjRvCgroISy7QXeA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7UVDTvntfFgDFUXSzCvQztpbqj6puWn+/P2E4o3hLXNFGBYCp+gT19f02hriOMMaAebEOw+2BOEo8YMFRQJ5pXVN2LLiy6nVgN+ZUwENVHNoL5Rhaiqfzow1s7mTGpVNj2e0Sb/53mRfU+dYuAa//x1h6pFSaj0/ytxH6s52uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UIZ/wErK; arc=fail smtp.client-ip=52.101.62.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UIZ/wErK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHqSsPzkxD69C2HgliMSfQnod1S4tVBnyI7BHkM6N+OQAtMm+MYESqj6IGpzxLNv0gR0tvxM4M4CIS9uWq8k6lH4Xn1aXPx7Inm5t9nKARc0LlPF6q1t44j71wgYBEWFIy2MaA0Kq+NEd7WZNRW1kpGkqZIBPd+wDWZ0gKInx8Vke9crZ4APzXa+Gfjk+cga52C/Cb5FnOmiCAkc9sLGSJs60ju4BLFjXAMXuzWGGFfBntr943zcnrYpmMK9JVlUQKxg9fkO2MBUINAS0fX0cDfF5p8hGIu7Y77lKwGyBXM7PoKc7Baw40BLZBUV91Ryws/08W4AKJ9BpP3c5ucCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erleQACyYzMFEL871geiFpkMbvUT3igJU5ixaux33sY=;
 b=wZd0hBAmXWPmTp5qz5s/bfZIM7KJAQuONEu+lm1FCGebtyFakgx2ZxUyqOf6Gea6lHvaMP/Z35DVVqMeJvPubUXKPYmWFoU/q2K1vq+w128awMfCW41/AMMHKl1rbxszu07dd8HOoPjmJ0BmH/GK1xtKFbrjITsyDPsmlxJwCs7qJrvw3HpwJGC4arLlyplrMMcPmYDcT0A1k9yM1sLqx5+Uu3WcQPp5rjfTVYpbIoQrx/QkbUUdp1Zp1qyp7/zg757Rn+VwuNHOxoUuYQmBwaMKnAvzHbDqHvyXBKYQ6q1eNEkkj4EqUBcmRuboAkcNRmKWPRqdF7wk0YVYduu0xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erleQACyYzMFEL871geiFpkMbvUT3igJU5ixaux33sY=;
 b=UIZ/wErKW108M5z6kBKqylIWeCYEKqNY8ypcURru+e273ofLSzDukr+X2tCNbcaOzictjEgQDaQg5iHfeMWJf5jXovz8/giNTOv0jBYxOBqNj8yDVQGPyJc9Z0W+Vw5bvY5JEa+gkKMnLx7kx7Wa1kJ5Ak6NzBLbRdJyByJ7uFg=
Received: from SJ0PR13CA0229.namprd13.prod.outlook.com (2603:10b6:a03:2c1::24)
 by DS0PR12MB8501.namprd12.prod.outlook.com (2603:10b6:8:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:51:29 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::6e) by SJ0PR13CA0229.outlook.office365.com
 (2603:10b6:a03:2c1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Mon,
 31 Aug 2026 05:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 05:51:28 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 00:51:26 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>
CC: <amd-gfx@lists.freedesktop.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "open
 list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>, Jatin Kataria
	<jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Enable PerfOpt IOMMU perf optimization when GPU in identity domain
Date: Mon, 31 Aug 2026 00:51:08 -0500
Message-ID: <20260831055108.1893285-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831055108.1893285-1-mario.limonciello@amd.com>
References: <20260831055108.1893285-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|DS0PR12MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: 769194f0-62dd-47b4-4ee3-08df0723e6e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	3q3Qzc5Jkbr8x+bjJXA7DgCyYKFZ/MayPaDTAdxs5fpDbaLUjB9Gs11sz6ZztzuFVFC3lU6XAkDC+M9JaujRoD6I7U05d9yrvLo+eHU0XkEV0izBUMGyCXBtS+0X9okJZ8yg/wB6FbifFjmNWvrBufshD/HQJBUrdxe6qwPrTopD20RA0oytW74jUrYvb7/Zt9tdWK7UfKr0WQwXDWXMB0Ic6thCdL8hB1M50TWV9ZeBAOO28UHbctSteYsMnYX+VV4ezhokdY3x2lLjzjE3shgCdFpvo2F5SGXqN8MhqVO8MH8LgIRhWCNjDqxk+KhoIj5dlZXTT0V7ZjEbsR1s5ZuXoiE+/YDKbYgOx9fXvK5ubV23gFZLddNM8n66Ialh28igdz5kS4xZndZungXgQY0FtKEgEkdw/BGNnnCYTIvxmGKBES1Bn8cbKVqbO1HAMZKPQoc0EQHRm4wiLXjDC+MWMcGP0D6BguZmBQjSmnD7R1reG7foX4Rzj0fiAPRR48UXYHcJNpGPBkzXKc+XA+79VHO1rfDcLFZcCrT3L/sBSgQSq4rmzhgrINPANayCw8YDtKjAjP9UqT3z994kMK5nq+qKumxqF8rzP7zixIWeRFes/HbkaRHvwOIjvvrL5R740tYB/FHeZ8j/Dcnwxfdv8YsQJd2heLWFdaYPmmEAcrrvQfo2SKaWOSnVloMH/6NEq/SkCh6JpHJTIiP9/Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pMfPv9TBITNRTQ1jHTJPVc6u1i0QqcwEvOjQ48PFt7fPTmWnaRhARxux5ncVWZBMo9kol5YMgioouuA7BZZ30SQEAmLej5SFfY+VHgH1WxOBYwuhZL3HSuim4ZRLL7iZYyhMx/KQ2vzfhIszSZkAcIbxcD3Gq3blaTn8eEfdujzslYq+8mfe+XYwskT+Lk6uYbU5vfb2KgXBOlUu/NXZX/dTHShWe/i/Uf1GzWL+NUvH0JP30PYFzOpo7KGomXbpuQB6w97Wsa4xWYrgXLnBX+smE2bom9Z/DRPuKr3VQ4dYIVI/1d1TZLFQrXciksu1PW2kGO2TxVoH1Eweq6oZzE0xxOY/+9h6tJwJaFw5rL5IeN8W0y0njt9eFABF0+CGfrJbPVBEXqkxg9aMWWBtZz/W4dUZnxTHGSCRnBRLTaDqV9kgrCZk0SaVx/AHkko+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:51:28.7410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 769194f0-62dd-47b4-4ee3-08df0723e6e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8501

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

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 41 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 12 +++++++
 3 files changed, 54 insertions(+)

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
index 44bed0ba64a37..75c74c72a52ea 100644
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
@@ -3752,6 +3753,17 @@ amdgpu_device_should_register_switcheroo(struct amdgpu_device *adev, bool px)
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
 /**
  * amdgpu_device_init - initialize the driver
  *
@@ -3958,6 +3970,18 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
+	if (amdgpu_iommu_perfopt != 0 &&
+	    amdgpu_device_identity(adev) &&
+	    adev->flags & AMD_IS_APU) {
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
@@ -4327,6 +4351,9 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	amdgpu_gart_dummy_page_fini(adev);
 
+	if (amdgpu_iommu_perfopt != 0)
+		amd_iommu_disable_perfopt(adev->pdev);
+
 	if (pci_dev_is_disconnected(adev->pdev))
 		amdgpu_device_unmap_mmio(adev);
 
@@ -4692,6 +4719,20 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
+	if (amdgpu_iommu_perfopt != 0 && amdgpu_device_identity(adev)) {
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
index 5b08afde37baf..26ba7852e1ceb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -185,6 +185,7 @@ char *amdgpu_disable_cu;
 char *amdgpu_virtual_display;
 int amdgpu_enforce_isolation = -1;
 int amdgpu_modeset = -1;
+int amdgpu_iommu_perfopt = 1;
 
 /* Specifies the default granularity for SVM, used in buffer
  * migration and restoration of backing memory when handling
@@ -392,6 +393,17 @@ module_param_named(fw_load_type, amdgpu_fw_load_type, int, 0444);
 MODULE_PARM_DESC(aspm, "ASPM support (1 = enable, 0 = disable, -1 = auto)");
 module_param_named(aspm, amdgpu_aspm, int, 0444);
 
+/**
+ * DOC: iommu_perfopt (int)
+ * Control the AMD IOMMU PerfOpt DMA-latency optimization
+ * (0 = disable; 1 = enable on APU devices in identity domain).
+ * This arms the IOMMU PerfOpt control (IOMMU spec, MMIO Offset 016Ch, EFR PerfOptSup / PerfOptEn)
+ * Arming it disables ATS, PRI, PASID and SVA for the GPU and removes IOMMU DMA containment for it,
+ * trading isolation for lower DMA latency.
+ */
+MODULE_PARM_DESC(iommu_perfopt, "Control IOMMU PerfOpt DMA-latency optimization (1 = enable on APU devices in identity domain, 0 = disable)");
+module_param_named(iommu_perfopt, amdgpu_iommu_perfopt, int, 0444);
+
 /**
  * DOC: runpm (int)
  * Override for runtime power management control for dGPUs. The amdgpu driver can dynamically power down
-- 
2.43.0

