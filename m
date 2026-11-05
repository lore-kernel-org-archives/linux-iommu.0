Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793896383;
	b=Fbh8xjBUWVsoVPzZ3OZA0+NOajYGvlj7V2jHvesQSUJr7r9jIMLa9P0aQOz0OduObeAp
	 54NAiKsFp4WGnbe+dpQvOkd3vxR+HajnTVsi8gE8RynFjuBASg53PDR3Z5cxIuAI5fuR/
	 6WIIEBHxlC7ofpDA6U8tTp421hUS3jCxvSRfcFNKGGbndFIyA6A5xIQdIW9kKgz2VQAgl
	 Hv40I7ZCuNJhArKITThL8ush6VTY2qcLZDmXCRnv3BiqiwPLaeWXOerAaklPieBTvlnAd
	 4ha487xHGKd50TLCklnoSPaVQe7UWphkO67EmceNyPOWHMLJbKR+b2WHGacNlDPaYMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896383;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=BiZuDDjPz10nnLKu5f783Oau3AE2G6Y8NKPEBrkbWZI=;
	b=3Ek3aCSbjzF4jpmskreKfxgDp/7W6E1AsaZJ+vZAEkflMCXgpEUfrkT4sx/p7dd+bFCp
	 NTgdRxcXmkpLF1YSoM0TeSLOkbO4LUf0D9Bb+X7J7ft5F0LXoOsZJRC0XxZSsQMvPo5dx
	 EqI/jEiY4vGVZtJthxhk7H71Qaf2Ek306zFzpuwevGYVlvY4ysmqGa3KQcbs9Y/KsGFXB
	 mVMzoyZXu1hWNX4rF5xagYs9pdsfvF2D03Tm4OV2fbytWEn0s+0x2/o3VvXzJ12OriaKn
	 EqoBnYJp/M3CBIdIDK+S7CQfOX2bEiyWgVx7ATdGM2Ceqw6+yPQYDn+HtQoAw27eG6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aPqbpxiy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.42
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013042.outbound.protection.outlook.com [40.93.196.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7A6606F90D
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 16:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B7A6606F90D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aPqbpxiy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltZri9GZZcS9NqlDo8w8XITtce1L9gbV6W/5WjTYOZXFXECLliYjZPHAO9J6m18r4mIYTs88yEGq4LXJS0UTb52d/DO/dsSt+MDLXEci+/vPGuA+qeBQxmchFOy3i3ytRlwHmBOVgyPFHOE+MQPypROnRQOVhg/RnVdGkfNwz39CIJitBH2K1RzvIyku85LZuuIuNGHXcVX3/wf6Q7mzyGVPW8mNtDE6F40spoBt0oYPCih9MM9x6pqha3x0kNmByauHRWkDYye/roNJbfKoCMQqX2rhK/G+Dt35cz276B4i3FZZgo+mF8QJRWDoaSkTgt91M4JtOf9Sd06s4SWcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiZuDDjPz10nnLKu5f783Oau3AE2G6Y8NKPEBrkbWZI=;
 b=T0SawIDEwf3pxPQtOoN+ZHd1iPQTeNWyq0teHC7nZqr9/+7LLod0VJEfYjC1UxYD9uzl9D00jJ2X9XgyDniKDHoO0uh0ADpZxGOhzMIaoEtIl2i4jqNPrymuJAj+/dOBzJMjONe3XPppyfivRfZXqMk0ohhisU0WiE668IYIJrJIz8Oh1KqhhyDEFrKJdwFbUo/WeEUVXIFahxxeTMNhoIPpgOQ33QMy6wQlLJkqXDzsViTpeZV6dFlrf3QKNwfe18cl4/4ZZVKKiki7vUFeruIq5VwOe5jywHxG/HiD1ZYBKo9GZJLJbKJcRMMgKFycGjeYyuIbJz5SCbBkONrzeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiZuDDjPz10nnLKu5f783Oau3AE2G6Y8NKPEBrkbWZI=;
 b=aPqbpxiy8P9pS0oR5TaPO9FOtH4Y72UsONUnWoeIRkDlgt0adjlQbPP+8hUXluXHZIMYNsf6IDo+vNorfQkzmVr2+MWZ85dS7oQCacK89mBUlQXdOdY/42mtVALw9iRCKCHSV8k83ohVNNquqJvq1TqwONrV3a2lKora2z03L9k=
Received: from PH3PEPF000040A9.namprd05.prod.outlook.com (2603:10b6:518:1::4b)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 16:32:53 +0000
Received: from PH5PEPF0000002A.namprd04.prod.outlook.com
 (2a01:111:f403:c95d::b) by PH3PEPF000040A9.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Thu, 5
 Nov 2026 16:32:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF0000002A.mail.protection.outlook.com (10.167.243.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 16:32:53 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 10:32:51 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>
CC: <iommu@lists.linux.dev>
Subject: [PATCH 1/5] iommu/amd: Enable PerfOpt automatically for integrated GPUs
Date: Thu, 5 Nov 2026 16:32:15 +0000
Message-ID: <20261105163219.601561-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105163219.601561-1-vasant.hegde@amd.com>
References: <20261105163219.601561-1-vasant.hegde@amd.com>
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
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002A:EE_|DM4PR12MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: d04b65b5-0c16-4821-007e-08df3b5a70a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|5023799004|56012099006|261009223027099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261102123227099003|261102130727099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	4huHQems4zJK4suxeDJCzFGOcy7DC26H3NFj3ebp4ebTMd1H0X9OMoBIXxECiiz1bLnjV4qe0w/NZo4/pY6ij/69W4yJsTcyb4fB8JZXi4WMIo1u762UGShRQfokjJ4zsgnv+wwXHsCePJEDIgWkVrtfwRtjomEfEVN2UmRBsGSU8vVWS927wY+42e+WzVrtgADVLpF2mhkaWigvKZYyDnFNyF+niKn3w7Kl2eto3zc6JUgePrOFfQT6/7Uqk/gySZLulkCGn2x1kBPLYwdVs0aPBx7IMTCCTVWQg0zswKeM78IENOXzKqJE6iq16/LBNRp2cp5VNiaHosW5GKzrExumoxIKpagernnUpHyqABj3C8CJRwXZgZ9yJdne+4Jo8An6k990tT7lgZgqpEx/VHuQlbKq7aMgG7H9n/a3FAOq4jkDkDL7n3vynMFYRY0sR1ZFJXvcbPVGpzs1M9edsQOdwiwxsAeKGkkt06WWUfhs/KU3gpSJwpLODR82fsuWI0YY9puvxBQQV22WAg4bXk8vm5Ml9bKbuVPkhzn7OQrvBVRkesG/ZT8wxbQvBn4f2Nx2W1sGlyHkD6TLbYUxKfzbjcGiKaCMuLFMnR9Owp0n1Ox9FSUwLlcFpNtGb6vP/VGVuGumGT8+PIlJj0eHE0F6AJg0NrIW+0Xl0dn88rQINwSjJXjXbL+Lczdp2+tkBPgZJtWbuMq/0LhRpJHpMA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(5023799004)(56012099006)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261102123227099003)(261102130727099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	baA16sIVKg8TQRUcHTlvwegvmwaka7QZsEnnYt1T04i3EsI87Pp3xNzKiADLjRxktFSWdii8k4yNfKLbUDG6pmcOSYAUZY9mEoRBQcGKF0cZGrcMrAx3/5QmThXhIkVnJSasBAWhmWKmpB/arn6rxXXV0RQaeID4G4mw0Yb4t1nCTBCBkupiaLTvj0nxA4GUS44xCqJ8RumnDrzWzqUZSDQaLbAFoulDe0xvGPNoHDIeZUcFnBXkCpFEOVq/grh5qwdNOXgln6umLD/sHMbLUC4bCx8TQDMlKzU5NLLVi+fsFvTrR41GBpzvNqBLOD2dWnIiiXWHE1UlaIwkCc2TnUNLY/eN0aEtlOLoMVwv8bE3SID16sE0nZuQK0CGWmFRaIWXfABLbQhrs/+Leg33lgxRrh8waRNQG6tbcdEXlHMtLGCzu/a7mt9zcGnrQDAQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:32:53.1885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d04b65b5-0c16-4821-007e-08df3b5a70a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH5PEPF0000002A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

PerfOpt is usable by integrated GPUs in identity mode. Enable it from
the IOMMU driver's domain attachment paths instead of requiring an
amdgpu policy knob and exported enable/disable interfaces.

Mark supported integrated GPUs as PerfOpt-eligible when selecting their
default identity domain. Skip GCR3 setup and ATS/PRI/PASID enablement for
these identity attachments, then enable PerfOpt after installing the DTE.
Clear PerfOpt before attaching an eligible GPU to a translated or blocked
domain, including unmanaged domains used by VFIO. Propagate failures to
clear bypass, but keep a completed identity attachment successful if the
optional PerfOpt enable fails.

Clear inherited PerfOpt state during initialization, including when a crash
kernel reuses device tables. Read feature support directly from hardware
because cached features may not be available yet, and stop initialization
if the initial clear fails.

Each IOMMU has at most one PerfOpt-eligible GPU, so track activation with a
boolean under the IOMMU lock. Preserve this state while clearing hardware
at suspend and shutdown, and restore the bit on resume only where it was
active. Do not enable PerfOpt unconditionally during early IOMMU
initialization.

Remove the amdgpu parameter, driver callbacks, and exported interfaces.
Translated attachments retain their normal device capability setup.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  50 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  12 -
 drivers/iommu/amd/amd_iommu.h              |   3 +-
 drivers/iommu/amd/amd_iommu_types.h        |   6 +-
 drivers/iommu/amd/init.c                   |  91 ++++----
 drivers/iommu/amd/iommu.c                  | 252 ++++-----------------
 include/linux/amd-iommu.h                  |  11 -
 8 files changed, 95 insertions(+), 331 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 78a6f743137e..c7577b608f3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -157,7 +157,6 @@ struct amdgpu_watchdog_timer {
  * Modules parameters.
  */
 extern int amdgpu_modeset;
-extern int amdgpu_iommu_perfopt;
 extern unsigned int amdgpu_vram_limit;
 extern int amdgpu_vis_vram_limit;
 extern int amdgpu_gart_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 53f05ee7193f..c65bc575a57a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -33,7 +33,6 @@
 #include <linux/console.h>
 #include <linux/slab.h>
 #include <linux/iommu.h>
-#include <linux/amd-iommu.h>
 #include <linux/pci.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/apple-gmux.h>
@@ -3770,28 +3769,6 @@ amdgpu_device_should_register_switcheroo(struct amdgpu_device *adev, bool px)
 		       apple_gmux_detect(NULL, NULL)));
 }
 
-static inline bool amdgpu_device_identity(struct amdgpu_device *adev)
-{
-	struct pci_dev *pdev = adev->pdev;
-	struct iommu_domain *domain = iommu_get_domain_for_dev(&pdev->dev);
-
-	if (!domain)
-		return false;
-
-	return domain->type == IOMMU_DOMAIN_IDENTITY;
-}
-
-static bool amdgpu_device_use_perfopt(struct amdgpu_device *adev)
-{
-	if (amdgpu_iommu_perfopt == 0)
-		return false;
-
-	if (!(adev->flags & AMD_IS_APU))
-		return false;
-
-	return amdgpu_device_identity(adev);
-}
-
 /**
  * amdgpu_device_init - initialize the driver
  *
@@ -4001,16 +3978,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
-	if (amdgpu_device_use_perfopt(adev)) {
-		int perfopt_ret = amd_iommu_enable_perfopt(pdev);
-
-		/* Optional optimization; a failure to arm it must not abort probe. */
-		if (perfopt_ret)
-			dev_warn(adev->dev,
-				 "Failed to enable IOMMU PerfOpt (%d); continuing without it\n",
-				 perfopt_ret);
-	}
-
 	/*
 	 * No need to remove conflicting FBs for non-display class devices.
 	 * This prevents the sysfb from being freed accidently.
@@ -4380,9 +4347,6 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	amdgpu_gart_dummy_page_fini(adev);
 
-	if (amdgpu_device_use_perfopt(adev))
-		amd_iommu_disable_perfopt(adev->pdev);
-
 	if (pci_dev_is_disconnected(adev->pdev))
 		amdgpu_device_unmap_mmio(adev);
 
@@ -4746,20 +4710,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
-	if (amdgpu_device_use_perfopt(adev)) {
-		int perfopt_ret = amd_iommu_enable_perfopt(adev->pdev);
-
-		/*
-		 * Must not return on failure: a bare return would leak the
-		 * SR-IOV VF exclusive-mode acquisition taken above (released
-		 * via the exit: path).
-		 */
-		if (perfopt_ret)
-			dev_warn(adev->dev,
-				 "Failed to enable IOMMU PerfOpt (%d); continuing without it\n",
-				 perfopt_ret);
-	}
-
 	if (adev->in_s0ix)
 		amdgpu_dpm_gfx_state_change(adev, sGpuChangeState_D0Entry);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 731fe8f9e922..3e5634de077f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -188,7 +188,6 @@ char *amdgpu_disable_cu;
 char *amdgpu_virtual_display;
 int amdgpu_enforce_isolation = -1;
 int amdgpu_modeset = -1;
-int amdgpu_iommu_perfopt = -1;
 
 /* Specifies the default granularity for SVM, used in buffer
  * migration and restoration of backing memory when handling
@@ -399,17 +398,6 @@ module_param_named(fw_load_type, amdgpu_fw_load_type, int, 0444);
 MODULE_PARM_DESC(aspm, "ASPM support (1 = enable, 0 = disable, -1 = auto)");
 module_param_named(aspm, amdgpu_aspm, int, 0444);
 
-/**
- * DOC: iommu_perfopt (int)
- * Control the AMD IOMMU PerfOpt DMA-latency optimization
- * (0 = disable; -1 = enable on supported devices).
- * This arms the IOMMU PerfOpt control (IOMMU spec, MMIO Offset 016Ch, EFR PerfOptSup / PerfOptEn)
- * Arming it disables ATS, PRI, PASID and SVA for the GPU and removes IOMMU DMA containment for it,
- * trading isolation for lower DMA latency.
- */
-MODULE_PARM_DESC(iommu_perfopt, "Control IOMMU PerfOpt DMA-latency optimization (-1 = enable on supported devices, 0 = disable)");
-module_param_named(iommu_perfopt, amdgpu_iommu_perfopt, int, 0444);
-
 /**
  * DOC: runpm (int)
  * Override for runtime power management control for dGPUs. The amdgpu driver can dynamically power down
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 93845b3c3fbf..29355810db7c 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -48,8 +48,7 @@ extern u8 amd_iommu_hpt_vasize;
 extern unsigned long amd_iommu_pgsize_bitmap;
 extern bool amd_iommu_hatdis;
 
-int amd_iommu_perfopt_clear(struct amd_iommu *iommu);
-int amd_iommu_perfopt_restore(struct amd_iommu *iommu);
+int amd_iommu_perfopt_set(struct amd_iommu *iommu, bool enable);
 
 /* Protection domain ops */
 void amd_iommu_init_identity_domain(void);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 0e79c43be001..f98770db0090 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -660,8 +660,8 @@ struct amd_iommu {
 	/* Extended features 2 */
 	u64 features2;
 
-	/* Devices requesting PerfOpt; the shared PERF_OPT_EN bit is on while >0. Protected by @lock. */
-	int perfopt_refcount;
+	/* Saved PerfOpt activation state, protected by @lock. */
+	bool perfopt_enabled;
 
 	/* PCI device id of the IOMMU device */
 	u16 devid;
@@ -824,7 +824,7 @@ struct iommu_dev_data {
 	u8 ppr          :1;		  /* Enable device PPR support */
 	bool use_vapic;			  /* Enable device to use vapic mode */
 	bool defer_attach;
-	bool perfopt;
+	bool perfopt;			  /* Device is eligible for PerfOpt */
 
 	struct ratelimit_state rs;        /* Ratelimit IOPF messages */
 };
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index de6db5621194..0cb9aeb0597b 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -432,8 +432,41 @@ static void iommu_enable(struct amd_iommu *iommu)
 	iommu_feature_enable(iommu, CONTROL_IOMMU_EN);
 }
 
+/*
+ * Program or clear the per-IOMMU PerfOpt enable bit.
+ * Gate on this IOMMU's own EFR, not the global AND-mask.
+ * Caller serializes access using iommu->lock or during init/suspend/resume.
+ */
+int amd_iommu_perfopt_set(struct amd_iommu *iommu, bool enable)
+{
+	u32 old, val, readback;
+
+	if (!(readq(iommu->mmio_base + MMIO_EXT_FEATURES) & FEATURE_PERF_OPT))
+		return enable ? -ENODEV : 0;
+
+	old = readl(iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
+	if (old == U32_MAX)
+		goto fail;
+
+	val = enable ? old | PERF_OPT_EN : old & ~PERF_OPT_EN;
+	if (val != old)
+		writel(val, iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
+	readback = readl(iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
+	if (readback == U32_MAX ||
+	    (readback & PERF_OPT_EN) != (val & PERF_OPT_EN))
+		goto fail;
+
+	iommu->perfopt_enabled = enable;
+	return 0;
+fail:
+	pr_err("IOMMU%d: failed to set PerfOpt to %d\n", iommu->index, enable);
+	return -EIO;
+}
+
 static void iommu_disable(struct amd_iommu *iommu)
 {
+	bool perfopt_enabled = iommu->perfopt_enabled;
+
 	if (!iommu->mmio_base)
 		return;
 
@@ -457,6 +490,10 @@ static void iommu_disable(struct amd_iommu *iommu)
 
 	/* Clear IRTE cache disabling bit */
 	iommu_feature_disable(iommu, CONTROL_IRTCACHEDIS);
+
+	/* Clear hardware while preserving the activation state for resume. */
+	amd_iommu_perfopt_set(iommu, false);
+	iommu->perfopt_enabled = perfopt_enabled;
 }
 
 /*
@@ -1888,6 +1925,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 				 struct acpi_table_header *ivrs_base)
 {
 	struct amd_iommu_pci_seg *pci_seg;
+	int ret;
 
 	pci_seg = get_pci_segment(h->pci_seg, ivrs_base);
 	if (pci_seg == NULL)
@@ -1960,8 +1998,10 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 	if (!iommu->mmio_base)
 		return -ENOMEM;
 
-	if (amd_iommu_perfopt_clear(iommu))
-		pr_err("IOMMU%d: failed to clear PerfOpt\n", iommu->index);
+	/* A crash kernel may reuse device tables with PerfOpt still enabled. */
+	ret = amd_iommu_perfopt_set(iommu, false);
+	if (ret)
+		return ret;
 
 	return init_iommu_from_acpi(iommu, h);
 }
@@ -2331,6 +2371,9 @@ static void print_iommu_info(void)
 		if (check_feature2(FEATURE_SEVSNPIO_SUP))
 			pr_cont(" SEV-TIO");
 
+		if (check_feature(FEATURE_PERF_OPT))
+			pr_cont(" PerfOpt");
+
 		pr_cont("\n");
 	}
 
@@ -3067,46 +3110,10 @@ static void enable_iommus_vapic(void)
 #endif
 }
 
-static int clear_perfopt_all(void)
-{
-	struct amd_iommu *iommu;
-	int err, ret = 0;
-
-	for_each_iommu(iommu) {
-		err = amd_iommu_perfopt_clear(iommu);
-		if (err)
-			ret = err;
-	}
-
-	return ret;
-}
-
-static int restore_perfopt_all(void)
-{
-	struct amd_iommu *iommu;
-	int err, ret = 0;
-
-	for_each_iommu(iommu) {
-		err = amd_iommu_perfopt_restore(iommu);
-		if (err)
-			ret = err;
-	}
-
-	return ret;
-}
-
 static void disable_iommus(void)
 {
 	struct amd_iommu *iommu;
 
-	/*
-	 * PerfOpt is an optional performance bit, so a failure to clear it must
-	 * not skip the mandatory disable below. This also runs from the void
-	 * amd_iommu_disable() shutdown/kexec path, which cannot report an error.
-	 */
-	if (clear_perfopt_all())
-		pr_err("Failed to clear PerfOpt while disabling IOMMUs\n");
-
 	for_each_iommu(iommu)
 		iommu_disable(iommu);
 
@@ -3132,9 +3139,11 @@ static void amd_iommu_resume(void *data)
 	for_each_iommu(iommu)
 		early_enable_iommu(iommu);
 
-	/* early_enable_iommu() cleared PERF_OPT_EN; re-assert it from the refcount. */
-	if (restore_perfopt_all())
-		pr_err("Failed to restore PerfOpt after IOMMU resume\n");
+	/* Restore the activation state saved at suspend. */
+	for_each_iommu(iommu) {
+		if (iommu->perfopt_enabled)
+			amd_iommu_perfopt_set(iommu, true);
+	}
 
 	iommu_enable_event_buffer();
 	amd_iommu_enable_interrupts();
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 960e1dc05ec6..54465e041155 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -11,6 +11,7 @@
 #include <linux/ratelimit.h>
 #include <linux/pci.h>
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 #include <linux/pci-ats.h>
 #include <linux/bitmap.h>
 #include <linux/slab.h>
@@ -2368,7 +2369,7 @@ static int attach_device(struct device *dev,
 	if (ret)
 		goto out;
 
-	if (dev_data->perfopt)
+	if (dev_data->perfopt && pdom_is_in_pt_mode(domain))
 		goto skip_caps;
 
 	/* Setup GCR3 table */
@@ -2510,192 +2511,6 @@ static int iommu_init_device_caps(struct iommu_dev_data *dev_data,
 	return 0;
 }
 
-/* Program the per-IOMMU PerfOpt enable bit. Caller must hold iommu->lock. */
-static int __perfopt_write(struct amd_iommu *iommu, bool enable)
-{
-	u32 old, val, readback;
-
-	if (!(readq(iommu->mmio_base + MMIO_EXT_FEATURES) & FEATURE_PERF_OPT))
-		return enable ? -ENODEV : 0;
-
-	old = readl(iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
-	if (old == U32_MAX)
-		return -EIO;
-
-	val = enable ? old | PERF_OPT_EN : old & ~PERF_OPT_EN;
-	if (val != old)
-		writel(val, iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
-	readback = readl(iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
-	if (readback == U32_MAX ||
-	    (readback & PERF_OPT_EN) != (val & PERF_OPT_EN))
-		return -EIO;
-	return 0;
-}
-
-/*
- * PERF_OPT_EN is a single bit shared by every device behind @iommu, so it is
- * reference counted: armed on the first requesting device, cleared on the last.
- */
-static int perfopt_get(struct amd_iommu *iommu)
-{
-	unsigned long flags;
-	int ret = 0;
-
-	if (!iommu->mmio_base)
-		return 0;
-
-	raw_spin_lock_irqsave(&iommu->lock, flags);
-	if (iommu->perfopt_refcount == 0) {
-		ret = __perfopt_write(iommu, true);
-		if (ret)
-			goto out;
-	}
-	iommu->perfopt_refcount++;
-out:
-	raw_spin_unlock_irqrestore(&iommu->lock, flags);
-	return ret;
-}
-
-static int perfopt_put(struct amd_iommu *iommu)
-{
-	unsigned long flags;
-	int ret = 0;
-
-	if (!iommu->mmio_base)
-		return 0;
-
-	raw_spin_lock_irqsave(&iommu->lock, flags);
-	if (iommu->perfopt_refcount > 0 && --iommu->perfopt_refcount == 0)
-		ret = __perfopt_write(iommu, false);
-	raw_spin_unlock_irqrestore(&iommu->lock, flags);
-	return ret;
-}
-
-/*
- * Force PERF_OPT_EN off without touching the refcount (used on init, shutdown,
- * and suspend). The count is preserved so amd_iommu_perfopt_restore() can
- * re-arm on resume.
- */
-int amd_iommu_perfopt_clear(struct amd_iommu *iommu)
-{
-	unsigned long flags;
-	int ret;
-
-	if (!iommu->mmio_base)
-		return 0;
-
-	raw_spin_lock_irqsave(&iommu->lock, flags);
-	ret = __perfopt_write(iommu, false);
-	raw_spin_unlock_irqrestore(&iommu->lock, flags);
-	return ret;
-}
-
-/*
- * Re-assert PERF_OPT_EN from the refcount after the hardware was reprogrammed on
- * resume, so devices armed before suspend keep the optimization without each
- * consumer driver re-arming.
- */
-int amd_iommu_perfopt_restore(struct amd_iommu *iommu)
-{
-	unsigned long flags;
-	int ret;
-
-	if (!iommu->mmio_base)
-		return 0;
-
-	raw_spin_lock_irqsave(&iommu->lock, flags);
-	ret = __perfopt_write(iommu, iommu->perfopt_refcount > 0);
-	raw_spin_unlock_irqrestore(&iommu->lock, flags);
-	return ret;
-}
-
-int amd_iommu_enable_perfopt(struct pci_dev *pdev)
-{
-	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
-	struct amd_iommu *iommu = rlookup_amd_iommu(&pdev->dev);
-	struct protection_domain *domain;
-	int ret;
-
-	if (!iommu || !dev_data)
-		return -ENODEV;
-
-	if (!(iommu->features & FEATURE_PERF_OPT))
-		return -ENODEV;
-
-	domain = dev_data->domain;
-	if (!domain)
-		return -ENODEV;
-
-	/* Already armed for this device (e.g. re-entry on resume). */
-	if (dev_data->perfopt)
-		return 0;
-
-	/*
-	 * The bit is only architecturally valid while the device is untranslated:
-	 * identity domain with ATS/PRI/PASID off. The identity domain is
-	 * SVA-capable so attach_device() enabled ATS/PRI/PASID and built a GCR3
-	 * table. Re-home the device onto the same identity domain with
-	 * perfopt set, so the attach_device() skip_caps path leaves
-	 * ATS/PRI/PASID off and no GCR3 table. This follows the detach/attach
-	 * pattern used by amd_iommu_attach_device().
-	 *
-	 * Locking: this and amd_iommu_disable_perfopt() run only from the
-	 * consumer driver's bind/unbind path. group->mutex is not exposed to
-	 * drivers, but a device bound to its native driver cannot have its domain
-	 * changed concurrently by the core (VFIO ownership is mutually exclusive;
-	 * sysfs domain changes require an unused group), so the detach/attach pair
-	 * is serialized without it.
-	 */
-	dev_data->perfopt = true;
-	detach_device(&pdev->dev);
-	ret = attach_device(&pdev->dev, domain);
-	if (ret)
-		goto err_restore;
-
-	ret = perfopt_get(iommu);
-	if (ret)
-		goto err_rearm;
-
-	dev_info_once(&pdev->dev, "PerfOpt armed on IOMMU%d\n", iommu->index);
-	return 0;
-
-err_rearm:
-	detach_device(&pdev->dev);
-err_restore:
-	dev_data->perfopt = false;
-	if (attach_device(&pdev->dev, domain))
-		pci_err(pdev, "failed to restore state after PerfOpt setup; device left detached\n");
-	dev_err_once(&pdev->dev, "PerfOpt failed to arm on IOMMU%d (%d)\n",
-		     iommu->index, ret);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(amd_iommu_enable_perfopt);
-
-void amd_iommu_disable_perfopt(struct pci_dev *pdev)
-{
-	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
-	struct amd_iommu *iommu = rlookup_amd_iommu(&pdev->dev);
-	struct protection_domain *domain;
-
-	if (!iommu || !dev_data || !dev_data->perfopt || !dev_data->domain)
-		return;
-
-	if (WARN_ON(perfopt_put(iommu)))
-		pci_err(pdev, "failed to clear PerfOpt\n");
-
-	/*
-	 * Restore ATS/PRI/PASID (and thus SVA) by re-homing the device onto its
-	 * identity domain with the flag cleared, so a later bind without PerfOpt
-	 * sees a normally-capable device. See the locking note in
-	 * amd_iommu_enable_perfopt().
-	 */
-	domain = dev_data->domain;
-	dev_data->perfopt = false;
-	detach_device(&pdev->dev);
-	if (attach_device(&pdev->dev, domain))
-		pci_err(pdev, "failed to restore caps after PerfOpt disable\n");
-}
-EXPORT_SYMBOL_GPL(amd_iommu_disable_perfopt);
 static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 {
 	struct iommu_device *iommu_dev;
@@ -2739,14 +2554,6 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 static void amd_iommu_release_device(struct device *dev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
-	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
-
-	if (dev_data->perfopt) {
-		if (WARN_ON(perfopt_put(iommu)))
-			dev_err(dev, "IOMMU%d: failed to clear PerfOpt on release\n",
-				iommu->index);
-		dev_data->perfopt = false;
-	}
 
 	WARN_ON(dev_data->domain);
 
@@ -3116,24 +2923,32 @@ void amd_iommu_domain_free(struct iommu_domain *dom)
 	kfree(domain);
 }
 
+/* Each IOMMU has at most one PerfOpt-eligible GPU. */
+static int set_device_perfopt(struct iommu_dev_data *dev_data, bool enable)
+{
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+
+	if (!dev_data->perfopt)
+		return 0;
+
+	guard(raw_spinlock_irqsave)(&iommu->lock);
+	if (iommu->perfopt_enabled == enable)
+		return 0;
+
+	return amd_iommu_perfopt_set(iommu, enable);
+}
+
 static int blocked_domain_attach_device(struct iommu_domain *domain,
 					struct device *dev,
 					struct iommu_domain *old)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
-	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	int ret;
 
-	/*
-	 * blocked_domain is also the .release_domain, so this is the normal
-	 * teardown path: drop the reference and clear the flag here too, and
-	 * don't fail teardown if the WARN-guarded write doesn't stick.
-	 */
-	if (dev_data->perfopt) {
-		if (WARN_ON(perfopt_put(iommu)))
-			dev_err(dev, "IOMMU%d: failed to clear PerfOpt for blocked domain\n",
-				iommu->index);
-		dev_data->perfopt = false;
-	}
+	/* Clearing the DTE cannot block DMA while PerfOpt bypasses it. */
+	ret = set_device_perfopt(dev_data, false);
+	if (ret)
+		return ret;
 
 	if (dev_data->domain)
 		detach_device(dev);
@@ -3167,6 +2982,9 @@ static struct protection_domain identity_domain;
 static int amd_iommu_identity_attach(struct iommu_domain *dom, struct device *dev,
 				     struct iommu_domain *old)
 {
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	int ret;
+
 	/*
 	 * Don't allow attaching a device to the identity domain if SNP is
 	 * enabled and SNP Mode0 support is not present.
@@ -3174,7 +2992,13 @@ static int amd_iommu_identity_attach(struct iommu_domain *dom, struct device *de
 	if (amd_iommu_snp_en && !amd_iommu_snp_mode0_sup)
 		return -EINVAL;
 
-	return amd_iommu_attach_device(dom, dev, old);
+	ret = amd_iommu_attach_device(dom, dev, old);
+	if (ret)
+		return ret;
+
+	/* PerfOpt is optional; the identity attachment is already complete. */
+	set_device_perfopt(dev_data, true);
+	return 0;
 }
 
 static const struct iommu_domain_ops identity_domain_ops = {
@@ -3202,9 +3026,6 @@ static int amd_iommu_attach_device(struct iommu_domain *dom, struct device *dev,
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
 	int ret;
 
-	if (dev_data->perfopt && !pdom_is_in_pt_mode(domain))
-		return -EBUSY;
-
 	/*
 	 * Skip attach device to domain if new domain is same as
 	 * devices current domain
@@ -3221,6 +3042,12 @@ static int amd_iommu_attach_device(struct iommu_domain *dom, struct device *dev,
 	if (dom->dirty_ops && !amd_iommu_hd_support(iommu))
 		return -EINVAL;
 
+	if (!pdom_is_in_pt_mode(domain)) {
+		ret = set_device_perfopt(dev_data, false);
+		if (ret)
+			return ret;
+	}
+
 	if (dev_data->domain)
 		detach_device(dev);
 
@@ -3415,6 +3242,9 @@ static int amd_iommu_def_domain_type(struct device *dev)
 		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 			return 0;
 
+		dev_data->perfopt = get_amd_iommu_from_dev_data(dev_data)->features &
+				    FEATURE_PERF_OPT;
+
 		return IOMMU_DOMAIN_IDENTITY;
 	}
 
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 104817e8d897..5c9dcf720f84 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -76,15 +76,4 @@ static inline int amd_iommu_snp_disable(void) { return 0; }
 static inline bool amd_iommu_sev_tio_supported(void) { return false; }
 #endif
 
-#ifdef CONFIG_AMD_IOMMU
-int amd_iommu_enable_perfopt(struct pci_dev *pdev);
-void amd_iommu_disable_perfopt(struct pci_dev *pdev);
-#else
-static inline int amd_iommu_enable_perfopt(struct pci_dev *pdev)
-{
-	return 0;
-}
-static inline void amd_iommu_disable_perfopt(struct pci_dev *pdev) { }
-#endif
-
 #endif /* _ASM_X86_AMD_IOMMU_H */
-- 
2.31.1

