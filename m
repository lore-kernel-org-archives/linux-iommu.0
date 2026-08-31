Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010031.outbound.protection.outlook.com [40.93.198.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C57D2D12EE
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 05:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155498; cv=fail; b=QUqpq4aVOnqHenMTT1cdBEKrOON/XY1u8obOr031exYb/GJkJA4lCK7lxUFFanaZoNyTLYcfZmdOqFJHrix1JOI7TefSBPmw7FXMuB1x5h/ikoRGe6W8BByRbDVRilccFwU7yJs+AIaB5fc4HxrNJtSRTveulHQM+YhCp/HgzYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155498; c=relaxed/simple;
	bh=Ux9dgarSvbgHZWpK2woocFac435fV6vWyy6W8rbWHHM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHW/2KbQe6IcJHlwvWPxQ9M7c961FJM4RhGV44NX7PZMT40AGmlX8bUlEQEY72T0YQxEt4pof4Nf4E8nF44lPUSilOlDuRru0VkaIKrLOw+NiUJS3xXy1AH61Ek8z3ppQmduI5eDT8wVfB7O4Odep7dw6fuDGZcMAFY3NI0qG8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pzG9KikF; arc=fail smtp.client-ip=40.93.198.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pzG9KikF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhSmqDTgx4EQGTeCZZ5POyzB5ZynnaeFzzkZ7iUSpMYgt7tt9PWXmaUTLlYLXjw4Judt+oOO9BTE3uQ+V2Z8IyJoMVKG0iL7BbJXeytHnGVXqZ2d5W5KfBp7osCM0azb5qQR4DbEn9DXGyY/scOYYcF8JD7w81/23NfeU42/zXiRsmSgKQwKUpORgEgdiVmADQF+GJYPUQ4cpQneEXVqRIJ4J9H0t1sb/omX6nYPH7P2tKUyhvmrTFwpqqJc4i+MCH0gM0ixMBG1XALHAIahH1gUHHtCmVOFsHn8Xmh3wCesDj4sLm3ZQgtt9exMEq6v86Dtz21pnPb71Oagktuvbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cecA0B0jBBhW3i2aSabDeyVm/L3u3VImvvwsUVn7iz8=;
 b=axXuMjqbyh8W0jhF41ycowrzb3CNYiryW6PrxLQdjR9bPCoNLJ3M1rp4O9fzbO7iSG6PGdYWR5t79HUl1LoYD8cQuEPFNc6M6i8G6rXMMkrXOWtlRrljXJhcdq3yqMHVlbHWgfHTnRg8A1g/FeN93MqyqbXt1hpwx7PEv/h1XxkXyF7PAXhHHdZsvpOOK+VI62DON6TgNtevfXdAhZceTbBdzzZezALTS2y7/Tzb+RHwmhgQFf058jvYHQkQpF8RuM6Roe48+BtL0+7r4Q1ejHyl+pdsDJQDCjaAes/3RMxbTrg1viioJQrq3XlXGwoEOgwTOC/9M1PodiiOkzmKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cecA0B0jBBhW3i2aSabDeyVm/L3u3VImvvwsUVn7iz8=;
 b=pzG9KikF0kDX7CkOypIe2eutcWHXyJI6X6ZuZhoO3UDRp182snmemToS0kxzP1z7IxgbY5cqbhe5iL64kjgn0Tu2eO/XpaQTAbnesJuOSos23O5pzNcEKULK64qagbGMpRsqJxyYBRdUWgGtTiYqi1l9H7OxfmzOCK3f4Z6YKtE=
Received: from SJ0PR13CA0215.namprd13.prod.outlook.com (2603:10b6:a03:2c1::10)
 by PH7PR12MB9256.namprd12.prod.outlook.com (2603:10b6:510:2fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:51:28 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::86) by SJ0PR13CA0215.outlook.office365.com
 (2603:10b6:a03:2c1::10) with Microsoft SMTP Server (version=TLS1_3,
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
 15.2.2562.46; Mon, 31 Aug 2026 00:51:25 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>
CC: <amd-gfx@lists.freedesktop.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "open
 list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>, Jatin Kataria
	<jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH 1/2] iommu/amd: Add PerfOpt IOMMU performance optimization support
Date: Mon, 31 Aug 2026 00:51:07 -0500
Message-ID: <20260831055108.1893285-2-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|PH7PR12MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a8524c7-d108-46b5-7f4c-08df0723e681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|6133799003|10067099003|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qU1gvFEggO+jDWBvjduLOz17oUX+mkokg7DenUSjtdujnPcQPGnH2KkJWxQlNQMWBXGMLvqv6ybJOG3XUzFSFeA6GdjJDFdxn/9Pfn6WZRYqi5HsOZRA1L1Rlh2FNMrKv/9+yY3MnWBAIUuE7j0h05S5ONEkfF4dqX1BmpINR+7rx4EQX53GcgNF+BKtdrOnzdlku+gciRcpFmfZ6MIFkN9Ibh2UGUbde8m7QmF9wdgUuKFk0mjyRXEW8WzDObjH+T2LLwMCOHUzFcIy9603WI0W0O+KmAJa+fTHHSowUtUoRDFVaG84mLWr3YrN44x7GSLVuF9qgT9dqRB/gTMYSsFDjx9CjA8cVZGXPMpFY+Pcu1GAf7bV4nfVB473tM1OmfhYmnarmsF0rMCkgvCXsN78SCgB/sQkpF5aFaNXBaK1oG8+4k6kNL+K5VH7eKPaN5i/8rM2dKVDXIeKm4o4KX2xiWqkB090/5doieUlIBrRTYeKBTk0881h6c2m88H9yuYpn0bJ1ZD+oKThqrz1fBnj+NQ977n4n3dp9zmvIaF7gGimDmt3uiyMuFiQeNH8S4b3s+Zv24YlkDOsNNn0VUoe7r9NI14ts3fEzsxlobDAImJZcovKcplEprDLEKlJSwziBR9X51AkGe51TFPUyl9PP5QzGSa020jDy/b9WCgAIhAAcObzgRZ16SL4DwXkk73SW/ea/XFM9bB/gKmrRg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(6133799003)(10067099003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eFufbJUlrJmJN/Eun3lGwzXaBLtNCp85g9ijuSQXGmpd2usZmcvxg1Il++t74C/VH66p6Z0hCeYc8/zdnS0XM3i/tlkqwYDRGcKhh5yivSAeRFXLtKbpp3j9bZ12rN2bmgww4wOTiakrLGTP6j5eB1QTIEZBVhWJbPnvTFvC/lM1cedIgQczLF0xJpNW90pXFRQ3jI5qOG7/mvklg2nY5GPwjk67RA3utlca4L0zs6I9ywF5dsM5z9E4ggpbPa9oIis/SugqenL1mLKHkSWWEcPbc4MrJ237CWgCLKZvuRNfiQNzS5TRttX4XI/NzTBgx08vnGJXcd/+tGnGVPBc29yR2J8/iABRvZWRWQuhQWL2n32aHbbDpEdq4xwQ9yWWLJF+zTfKgNAt7CYv1x3FArYrFieF4m4wtjyEEHQbCnwQB0OCENttf6+XqsBd0Cvq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:51:28.1130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8524c7-d108-46b5-7f4c-08df0723e681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9256

Add support for the AMD IOMMU Performance Optimization (PerfOpt)
feature as defined in the AMD I/O Virtualization Technology (IOMMU)
Specification, Section 3.4.9 (MMIO Offset 016Ch).

This feature allows privileged integrated I/O devices (GPUs) to bypass
the IOMMU when directly accessing system memory.  The IOMMU only
enforces the IR/IW permission bits without GPA->SPA translations.

amd_iommu_enable_perfopt() performs a detach/reattach cycle to rehome
devices already on the identity domain with ATS/PRI/PASID/GCR3
disabled (skip_caps path).  amd_iommu_disable_perfopt() restores those
capabilities.  The per-device dev_data->perfopt flag tracks state.

PERF_OPT_EN is a single control bit per IOMMU, shared by every device
behind that IOMMU, while enablement is requested per device.  It is
therefore reference counted (amd_iommu->perfopt_refcount): armed on the
first requesting device and cleared on the last, so one device's
teardown never clears the bit while a peer behind the same IOMMU still
needs it.

The per-device flag is cleared on every teardown path
(blocked_domain_attach, release_device, and amd_iommu_disable_perfopt),
dropping the reference with it, so a reused dev_data never carries stale
PerfOpt state onto its next bind.

On suspend/resume the hardware is reprogrammed from scratch:
amd_iommu_perfopt_clear() forces the bit off without touching the
reference count, and amd_iommu_perfopt_restore() re-asserts it from the
count after early_enable_iommu(), so armed devices keep the optimization
across resume without relying on each consumer driver to re-arm.

The exported amd_iommu_enable_perfopt()/amd_iommu_disable_perfopt() run
only from a consumer driver's bind/unbind path.  group->mutex is not
exposed to drivers, but a device bound to its native driver cannot have
its IOMMU domain changed concurrently by the core, which serializes the
detach/attach pair against core-driven attach.

PerfOpt is opt-in -- only enabled when explicitly requested by a driver.

Co-developed-by: Jatin Kataria <jkataria@netflix.com>
Signed-off-by: Jatin Kataria <jkataria@netflix.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |   3 +
 drivers/iommu/amd/amd_iommu_types.h |   7 +
 drivers/iommu/amd/init.c            |  43 ++++++
 drivers/iommu/amd/iommu.c           | 214 ++++++++++++++++++++++++++++
 include/linux/amd-iommu.h           |  11 ++
 5 files changed, 278 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index a2fe804b038b6..1f8f9df8e6c24 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -48,6 +48,9 @@ extern u8 amd_iommu_hpt_vasize;
 extern unsigned long amd_iommu_pgsize_bitmap;
 extern bool amd_iommu_hatdis;
 
+int amd_iommu_perfopt_clear(struct amd_iommu *iommu);
+int amd_iommu_perfopt_restore(struct amd_iommu *iommu);
+
 /* Protection domain ops */
 void amd_iommu_init_identity_domain(void);
 struct protection_domain *protection_domain_alloc(void);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 3dbe20023456b..755421e5cd757 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -65,6 +65,7 @@
 #define MMIO_MSI_ADDR_LO_OFFSET	0x015C
 #define MMIO_MSI_ADDR_HI_OFFSET	0x0160
 #define MMIO_MSI_DATA_OFFSET	0x0164
+#define MMIO_PERF_OPT_OFFSET	0x016C
 #define MMIO_INTCAPXT_EVT_OFFSET	0x0170
 #define MMIO_INTCAPXT_PPR_OFFSET	0x0178
 #define MMIO_INTCAPXT_GALOG_OFFSET	0x0180
@@ -99,6 +100,8 @@
 #define FEATURE_GLX		GENMASK_ULL(15, 14)
 #define FEATURE_GAM_VAPIC	BIT_ULL(21)
 #define FEATURE_PASMAX		GENMASK_ULL(36, 32)
+#define FEATURE_PERF_OPT	BIT_ULL(45)
+#define PERF_OPT_EN		BIT(13)
 #define FEATURE_GIOSUP		BIT_ULL(48)
 #define FEATURE_HASUP		BIT_ULL(49)
 #define FEATURE_EPHSUP		BIT_ULL(50)
@@ -670,6 +673,9 @@ struct amd_iommu {
 	/* Extended features 2 */
 	u64 features2;
 
+	/* Devices requesting PerfOpt; the shared PERF_OPT_EN bit is on while >0. Protected by @lock. */
+	int perfopt_refcount;
+
 	/* PCI device id of the IOMMU device */
 	u16 devid;
 
@@ -831,6 +837,7 @@ struct iommu_dev_data {
 	u8 ppr          :1;		  /* Enable device PPR support */
 	bool use_vapic;			  /* Enable device to use vapic mode */
 	bool defer_attach;
+	bool perfopt;
 
 	struct ratelimit_state rs;        /* Ratelimit IOPF messages */
 };
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 40726dfef2733..ddcf56f101675 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1942,6 +1942,9 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 	if (!iommu->mmio_base)
 		return -ENOMEM;
 
+	if (amd_iommu_perfopt_clear(iommu))
+		pr_err("IOMMU%d: failed to clear PerfOpt\n", iommu->index);
+
 	return init_iommu_from_acpi(iommu, h);
 }
 
@@ -3032,10 +3035,46 @@ static void enable_iommus_vapic(void)
 #endif
 }
 
+static int clear_perfopt_all(void)
+{
+	struct amd_iommu *iommu;
+	int err, ret = 0;
+
+	for_each_iommu(iommu) {
+		err = amd_iommu_perfopt_clear(iommu);
+		if (err)
+			ret = err;
+	}
+
+	return ret;
+}
+
+static int restore_perfopt_all(void)
+{
+	struct amd_iommu *iommu;
+	int err, ret = 0;
+
+	for_each_iommu(iommu) {
+		err = amd_iommu_perfopt_restore(iommu);
+		if (err)
+			ret = err;
+	}
+
+	return ret;
+}
+
 static void disable_iommus(void)
 {
 	struct amd_iommu *iommu;
 
+	/*
+	 * PerfOpt is an optional performance bit, so a failure to clear it must
+	 * not skip the mandatory disable below. This also runs from the void
+	 * amd_iommu_disable() shutdown/kexec path, which cannot report an error.
+	 */
+	if (clear_perfopt_all())
+		pr_err("Failed to clear PerfOpt while disabling IOMMUs\n");
+
 	for_each_iommu(iommu)
 		iommu_disable(iommu);
 
@@ -3061,6 +3100,10 @@ static void amd_iommu_resume(void *data)
 	for_each_iommu(iommu)
 		early_enable_iommu(iommu);
 
+	/* early_enable_iommu() cleared PERF_OPT_EN; re-assert it from the refcount. */
+	if (restore_perfopt_all())
+		pr_err("Failed to restore PerfOpt after IOMMU resume\n");
+
 	iommu_enable_event_buffer();
 	amd_iommu_enable_interrupts();
 }
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4dc306a4b5c62..fa60affdfc035 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2395,6 +2395,9 @@ static int attach_device(struct device *dev,
 	if (ret)
 		goto out;
 
+	if (dev_data->perfopt)
+		goto skip_caps;
+
 	/* Setup GCR3 table */
 	if (pdom_is_sva_capable(domain)) {
 		ret = init_gcr3_table(dev_data, domain);
@@ -2419,6 +2422,7 @@ static int attach_device(struct device *dev,
 		pdev_enable_cap_ats(pdev);
 	}
 
+skip_caps:
 	/* Update data structures */
 	dev_data->domain = domain;
 	spin_lock_irqsave(&domain->lock, flags);
@@ -2487,6 +2491,192 @@ static void detach_device(struct device *dev)
 	mutex_unlock(&dev_data->mutex);
 }
 
+/* Program the per-IOMMU PerfOpt enable bit. Caller must hold iommu->lock. */
+static int __perfopt_write(struct amd_iommu *iommu, bool enable)
+{
+	u32 old, val, readback;
+
+	if (!(readq(iommu->mmio_base + MMIO_EXT_FEATURES) & FEATURE_PERF_OPT))
+		return enable ? -ENODEV : 0;
+
+	old = readl(iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
+	if (old == U32_MAX)
+		return -EIO;
+
+	val = enable ? old | PERF_OPT_EN : old & ~PERF_OPT_EN;
+	if (val != old)
+		writel(val, iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
+	readback = readl(iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
+	if (readback == U32_MAX ||
+	    (readback & PERF_OPT_EN) != (val & PERF_OPT_EN))
+		return -EIO;
+	return 0;
+}
+
+/*
+ * PERF_OPT_EN is a single bit shared by every device behind @iommu, so it is
+ * reference counted: armed on the first requesting device, cleared on the last.
+ */
+static int perfopt_get(struct amd_iommu *iommu)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	if (!iommu->mmio_base)
+		return 0;
+
+	raw_spin_lock_irqsave(&iommu->lock, flags);
+	if (iommu->perfopt_refcount == 0) {
+		ret = __perfopt_write(iommu, true);
+		if (ret)
+			goto out;
+	}
+	iommu->perfopt_refcount++;
+out:
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+	return ret;
+}
+
+static int perfopt_put(struct amd_iommu *iommu)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	if (!iommu->mmio_base)
+		return 0;
+
+	raw_spin_lock_irqsave(&iommu->lock, flags);
+	if (iommu->perfopt_refcount > 0 && --iommu->perfopt_refcount == 0)
+		ret = __perfopt_write(iommu, false);
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+	return ret;
+}
+
+/*
+ * Force PERF_OPT_EN off without touching the refcount (used on init, shutdown,
+ * and suspend). The count is preserved so amd_iommu_perfopt_restore() can
+ * re-arm on resume.
+ */
+int amd_iommu_perfopt_clear(struct amd_iommu *iommu)
+{
+	unsigned long flags;
+	int ret;
+
+	if (!iommu->mmio_base)
+		return 0;
+
+	raw_spin_lock_irqsave(&iommu->lock, flags);
+	ret = __perfopt_write(iommu, false);
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+	return ret;
+}
+
+/*
+ * Re-assert PERF_OPT_EN from the refcount after the hardware was reprogrammed on
+ * resume, so devices armed before suspend keep the optimization without each
+ * consumer driver re-arming.
+ */
+int amd_iommu_perfopt_restore(struct amd_iommu *iommu)
+{
+	unsigned long flags;
+	int ret;
+
+	if (!iommu->mmio_base)
+		return 0;
+
+	raw_spin_lock_irqsave(&iommu->lock, flags);
+	ret = __perfopt_write(iommu, iommu->perfopt_refcount > 0);
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+	return ret;
+}
+
+int amd_iommu_enable_perfopt(struct pci_dev *pdev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
+	struct amd_iommu *iommu = rlookup_amd_iommu(&pdev->dev);
+	struct protection_domain *domain;
+	int ret;
+
+	if (!iommu || !dev_data)
+		return -ENODEV;
+
+	if (!(iommu->features & FEATURE_PERF_OPT))
+		return -ENODEV;
+
+	domain = dev_data->domain;
+	if (!domain)
+		return -ENODEV;
+
+	/* Already armed for this device (e.g. re-entry on resume). */
+	if (dev_data->perfopt)
+		return 0;
+
+	/*
+	 * The bit is only architecturally valid while the device is untranslated:
+	 * identity domain with ATS/PRI/PASID off. The identity domain is
+	 * SVA-capable so attach_device() enabled ATS/PRI/PASID and built a GCR3
+	 * table. Re-home the device onto the same identity domain with
+	 * perfopt set, so the attach_device() skip_caps path leaves
+	 * ATS/PRI/PASID off and no GCR3 table. This follows the detach/attach
+	 * pattern used by amd_iommu_attach_device().
+	 *
+	 * Locking: this and amd_iommu_disable_perfopt() run only from the
+	 * consumer driver's bind/unbind path. group->mutex is not exposed to
+	 * drivers, but a device bound to its native driver cannot have its domain
+	 * changed concurrently by the core (VFIO ownership is mutually exclusive;
+	 * sysfs domain changes require an unused group), so the detach/attach pair
+	 * is serialized without it.
+	 */
+	dev_data->perfopt = true;
+	detach_device(&pdev->dev);
+	ret = attach_device(&pdev->dev, domain);
+	if (ret)
+		goto err_restore;
+
+	ret = perfopt_get(iommu);
+	if (ret)
+		goto err_rearm;
+
+	dev_info_once(&pdev->dev, "PerfOpt armed on IOMMU%d\n", iommu->index);
+	return 0;
+
+err_rearm:
+	detach_device(&pdev->dev);
+err_restore:
+	dev_data->perfopt = false;
+	if (attach_device(&pdev->dev, domain))
+		pci_err(pdev, "failed to restore state after PerfOpt setup; device left detached\n");
+	dev_err_once(&pdev->dev, "PerfOpt failed to arm on IOMMU%d (%d)\n",
+		     iommu->index, ret);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(amd_iommu_enable_perfopt);
+
+void amd_iommu_disable_perfopt(struct pci_dev *pdev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
+	struct amd_iommu *iommu = rlookup_amd_iommu(&pdev->dev);
+	struct protection_domain *domain;
+
+	if (!iommu || !dev_data || !dev_data->perfopt || !dev_data->domain)
+		return;
+
+	if (WARN_ON(perfopt_put(iommu)))
+		pci_err(pdev, "failed to clear PerfOpt\n");
+
+	/*
+	 * Restore ATS/PRI/PASID (and thus SVA) by re-homing the device onto its
+	 * identity domain with the flag cleared, so a later bind without PerfOpt
+	 * sees a normally-capable device. See the locking note in
+	 * amd_iommu_enable_perfopt().
+	 */
+	domain = dev_data->domain;
+	dev_data->perfopt = false;
+	detach_device(&pdev->dev);
+	if (attach_device(&pdev->dev, domain))
+		pci_err(pdev, "failed to restore caps after PerfOpt disable\n");
+}
+EXPORT_SYMBOL_GPL(amd_iommu_disable_perfopt);
 static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 {
 	struct iommu_device *iommu_dev;
@@ -2554,6 +2744,14 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 static void amd_iommu_release_device(struct device *dev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+
+	if (dev_data->perfopt) {
+		if (WARN_ON(perfopt_put(iommu)))
+			dev_err(dev, "IOMMU%d: failed to clear PerfOpt on release\n",
+				iommu->index);
+		dev_data->perfopt = false;
+	}
 
 	WARN_ON(dev_data->domain);
 
@@ -2928,6 +3126,19 @@ static int blocked_domain_attach_device(struct iommu_domain *domain,
 					struct iommu_domain *old)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+
+	/*
+	 * blocked_domain is also the .release_domain, so this is the normal
+	 * teardown path: drop the reference and clear the flag here too, and
+	 * don't fail teardown if the WARN-guarded write doesn't stick.
+	 */
+	if (dev_data->perfopt) {
+		if (WARN_ON(perfopt_put(iommu)))
+			dev_err(dev, "IOMMU%d: failed to clear PerfOpt for blocked domain\n",
+				iommu->index);
+		dev_data->perfopt = false;
+	}
 
 	if (dev_data->domain)
 		detach_device(dev);
@@ -2996,6 +3207,9 @@ static int amd_iommu_attach_device(struct iommu_domain *dom, struct device *dev,
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
 	int ret;
 
+	if (dev_data->perfopt && !pdom_is_in_pt_mode(domain))
+		return -EBUSY;
+
 	/*
 	 * Skip attach device to domain if new domain is same as
 	 * devices current domain
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index edcee9f5335a6..e03575cbc08c6 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -76,4 +76,15 @@ static inline int amd_iommu_snp_disable(void) { return 0; }
 static inline bool amd_iommu_sev_tio_supported(void) { return false; }
 #endif
 
+#ifdef CONFIG_AMD_IOMMU
+int amd_iommu_enable_perfopt(struct pci_dev *pdev);
+void amd_iommu_disable_perfopt(struct pci_dev *pdev);
+#else
+static inline int amd_iommu_enable_perfopt(struct pci_dev *pdev)
+{
+	return 0;
+}
+static inline void amd_iommu_disable_perfopt(struct pci_dev *pdev) { }
+#endif
+
 #endif /* _ASM_X86_AMD_IOMMU_H */
-- 
2.43.0

