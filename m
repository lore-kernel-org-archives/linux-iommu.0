Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010026.outbound.protection.outlook.com [52.101.56.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716833FE37A
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760367; cv=fail; b=Bay5qv1qaOlN4++zomNKQIBD9QEAWZX2KmgytOiSOLUBH8rWmYpfjHYG733hPyUf97I32dpleRVJOx5L1LZk8KTY4fFJoq59vEVXNLpONmGircaRQQ1kUcKMPyPhy50Of7XP6bkQ8r0c4dDO+D/dicijjfkb/hk8y6/QGA2pIHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760367; c=relaxed/simple;
	bh=p6NP5WfsQTzzfSrdD8rBcv1B6LXurEgvBdLKAicJKUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRgrRSL3qPen5madaaNbkYY6cbI99tWJMvsq8qSCF4gDDiKeWNLy5rcaNGcPx5gIM0wETM9Lp2EM+FtFwjTjGvouzG34afbPI1jHxsqYKg8PO1SG4Lkl7U4kNt+R953rSKPozgJFSPsYSRaP6+VRfYgxlwox3rkIUnYDS0Z7PIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iGITotQm; arc=fail smtp.client-ip=52.101.56.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iGITotQm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2UyaGQamc7USQPkVBUu3ipPjO1EggqES3QUzG2aIIJqXkebwF449VKctF1KgGyGz5FzZRrFBnUVj9kRTucBWE0OfiNfSPf2FqbuMX5w0eiZ5goLas2I/545Y3PoMtEzNvQpHt4XtdkqhtGctjIekFpemqvbcPoZ7yl+AzTagwXAkRiQTrMZEwYe6YAv4zgDSk2atdBRyobBqgyZC765xIPmMS56/8yEFfT7mTr5QwWkKEfQhXvZ+N/6awsJ3ZbDStM1hvXbqL78QIxdWjE5l1EHT+aVoxtOzDxDiwQtxjlnSrAlzrQDbKEno+iIYAQjczcb4nCjDExy7JBYfnYX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wt/khbKEt8tqxfbudKhxsZ71PXIco0LY1gLBiPFn9Yg=;
 b=RY1TC92V+wxc9DSru9pQe/bOeezZXF0KmKurQoCF9t5L2JctAjmvv4VVcbzL1MMfhAIA3xBoBTrh+eHuf/z2K5gDl2Z8btMEaW096rLPsDMZHeaiekdWWKA6zzexe+HbgLzRayncXwvdfg+L9C5jqG6t4HBe6PrQlmPoIrJDUu76z4a9NGuow5cTYHk8tQWIDCZ5GVNHSXAHrRKlG0wxmrEs0mb76q3tGpDDVn5o+hiRc/a/vswP/9pPfko/spPKGDTcIlZMWpxXKj/LxH4IICry/xcJFXHHfyibuyrfFuRpW0U54yZ2QoCoyIRF3q8HS5ulB6uCxmS5xRAWv2dRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wt/khbKEt8tqxfbudKhxsZ71PXIco0LY1gLBiPFn9Yg=;
 b=iGITotQml4ygyNvQOZxmLctiuGBnhNFcJ31D12tWZ3xNwFFewi9e1u+c6DW3ZP5vi+ga8rUpoYghgmDV2IqNa/D9diAYKtsAQWgD6utNLAcPGVSFMJuZoi6qsZUk9wy0ZbsF1mvadL+SaEluJjhpc8rv+jFmGPxjTWcz1n6VK0g=
Received: from SN7P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::31)
 by CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 09:26:00 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:123:cafe::ad) by SN7P220CA0026.outlook.office365.com
 (2603:10b6:806:123::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 09:26:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:26:00 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:25:53 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <chrisl@kernel.org>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 19/24] iommu/amd: Add per-segment translate device ID pool
Date: Wed, 30 Sep 2026 09:23:39 +0000
Message-ID: <20260930092344.5616-20-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|CY8PR12MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: c371e577-d003-4749-eda0-08df1ed4d753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|82310400026|36860700016|376014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8PiyoJtbuO2W1Zl6IGyec9XoNnC0B3YACeDvy0y55TS8VW3dhHYumsUmEmcm6zwmHaCedOiwl/YQwCwzQWRxmhvRLgdeA4DviLaX5qgIxEIn1zUFya3u38K9aXLVSgyQZG37vkdbO3dJgWz2ArAp7UPxQkgotsdSa+zrZXTOdTdMiGnJdDLzyAjENidqLT9d9V1nFteiWGFE650ZSx9ORpEG+p0G5oRWGJvwdhZMcGrcvZWVNy9Il3Gpmrx6YfdYrDQWLbDq6fk6fueegpx8brxhA6xWPyUPqKwRBYo4qfrKnafvrD+nUjrc4Kxg1ypFcL7Ll1wLQgI15HThFkUMokkRvbTL3NrpF4AKeaZCjpY+FEX16O/3m741/5fj+kOE1Lo/5mHQd1D/SAoHLj9NVo/9qS4a6TglaPQ7arGYi2IyTIAmTUdlvuh1TVa1kNKywjUUL1HaWgoE9t4JKCW7J5lo70RNnQ5r7pR4AYEi/+nEW4g/MFcfT3ARV+4EBsgjkeXq6Z8Kpeu6g4zODQg793We/fZJFeu2+W2ml0n7tz8HVXyZ9MHGkkdMuTgPQHIfrgnGtLoMYYRRBSfQEBs5GVadiKMqfgtizt2EuA6xm1cIYhLwhzdYvBFX+kl4rCwAKa3DS8QTVkY00IUUlpitGVJTzhx1T1e6ZqRg6NgTeBuczkLn75R6uUByontUoA6RS1FRw2sBabEVz+h4X4tQ5g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(82310400026)(36860700016)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jD81SxQK3o5r0EwWTnOdDiFuPTjTPTQbg51+J2P31oPqE3ctO3hCuriywZY3RS/+jM9l6VYh+o8q7GQOSjtgxw99aZluaZ3ss5QzaYEoZmpfU7LOUMhT0c75KpiIAPkCESWhp3+f5QMCE7VL8vXUQ11T2tBh/7iS45G9U4tL0UQtuwcTXQ8Q5bhWyGEnDPz1TOpy5uHq/+XTyb1l84VVboFtIrHrMIT1q1jHQYsn7BRwF39PUBozOax1xFBeJfo3Rthto0TTYUd3X1xW0NKW/vLdFBUcF13q6Gz32lNEjrqM3i+KdPfywmz17GWwR53Anl5yfbTfVU2M2xVt7l41GcrEv3zVK2nGjyZB0SlnpceNHZJRj5hs6FWmwiaR3svkK0YhVSisOFK/J/ALXIzHyKYXKU2tjkBgf1nFj0bXfGeqiSgge2ZcFwAiCr11+JQX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:26:00.3781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c371e577-d003-4749-eda0-08df1ed4d753
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290

A translate device ID (TransDevID) is a host device-table index used
by hardware vIOMMU. VFCTRL guest-misc names the slot; that DTE holds
the nest-parent v1 table for GPA->SPA walks of guest IOMMU traffic.

Reserve PCI requestor IDs in a per-segment pool so they are not
used as vIOMMU translation DTEs. The device table is per-segment,
so the pool is too.

Add trans_devid.c with pci_seg init/fini and
amd_iommu_trans_devid_reserve() from probe_device(). Keep
reservations for the pci_seg lifetime, including after
amd_iommu_release_device().

The IOMMU function never reaches probe_device(): rlookup is cleared
at iommu->devid, while the self DTE still occupies that slot. Reserve
it in init_iommu_one_late() for the same pci_seg lifetime.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/Makefile          |  2 +-
 drivers/iommu/amd/amd_iommu_types.h | 10 ++++
 drivers/iommu/amd/amd_viommu.h      | 20 +++++++
 drivers/iommu/amd/init.c            | 13 +++++
 drivers/iommu/amd/iommu.c           | 22 +++++++
 drivers/iommu/amd/trans_devid.c     | 90 +++++++++++++++++++++++++++++
 drivers/iommu/amd/viommu.c          |  3 +
 7 files changed, 159 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/amd/trans_devid.c

diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index e1e824b9c7b0..12c3fe83e4ce 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += iommu.o init.o quirks.o ppr.o pasid.o
-obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o nested.o viommu.o
+obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o nested.o viommu.o trans_devid.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index b5d1b23791da..6b3a43952797 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -681,6 +681,16 @@ struct amd_iommu_pci_seg {
 	 * parsing time.
 	 */
 	struct list_head unity_map;
+
+#ifdef CONFIG_AMD_IOMMU_IOMMUFD
+	/*
+	 * Per-segment translate-device-id pool indexed by id.  Entries are:
+	 * absent (FREE), xa value TRANS_DEVID_RESERVED, or a pointer to the
+	 * owning struct amd_iommu_viommu (ALLOCATED).
+	 */
+	struct mutex trans_devid_mutex;
+	struct xarray trans_devid_xa;
+#endif
 };
 
 /*
diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index 30227a5e4bfa..772d99391b6c 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -28,6 +28,10 @@ void amd_viommu_domain_id_update_locked(struct amd_iommu_viommu *aviommu,
 
 void amd_viommu_set_device_mapping(struct amd_iommu_viommu *aviommu,
 				   u16 hdev_id, u16 gdev_id);
+
+void amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg);
+void amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg);
+int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id);
 #else
 
 /*
@@ -59,6 +63,22 @@ static inline void amd_viommu_domain_id_update_locked(struct amd_iommu_viommu *a
 {
 }
 
+static inline void
+amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg)
+{
+}
+
+static inline int
+amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id)
+{
+	return 0;
+}
+
+static inline void
+amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg)
+{
+}
+
 #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
 
 #endif /* AMD_VIOMMU_H */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 96299f10b2e8..59a06c3014fe 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1747,6 +1747,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 	xa_init(&pci_seg->dev_data_xa);
 	INIT_LIST_HEAD(&pci_seg->unity_map);
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
+	amd_iommu_pci_seg_trans_devid_init(pci_seg);
 
 	if (alloc_dev_table(pci_seg))
 		goto err_free_pci_seg;
@@ -1763,6 +1764,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 	free_dev_table(pci_seg);
 err_free_pci_seg:
 	list_del(&pci_seg->list);
+	amd_iommu_pci_seg_trans_devid_fini(pci_seg);
 	xa_destroy(&pci_seg->dev_data_xa);
 	kfree(pci_seg);
 	return NULL;
@@ -1787,6 +1789,7 @@ static void __init free_pci_segments(void)
 
 	for_each_pci_segment_safe(pci_seg, next) {
 		list_del(&pci_seg->list);
+		amd_iommu_pci_seg_trans_devid_fini(pci_seg);
 		xa_destroy(&pci_seg->dev_data_xa);
 		free_irq_lookup_table(pci_seg);
 		free_rlookup_table(pci_seg);
@@ -2006,8 +2009,18 @@ static int __init init_iommu_one_late(struct amd_iommu *iommu)
 	/*
 	 * Make sure IOMMU is not considered to translate itself. The IVRS
 	 * table tells us so, but this is a lie!
+	 *
+	 * Clearing rlookup keeps this function off amd_iommu_probe_device(),
+	 * so its devid is never reserved there. The vIOMMU self DTE is
+	 * still programmed at iommu->devid. Reserve it here so translate-id
+	 * alloc does not treat the empty xarray slot as free.
 	 */
 	iommu->pci_seg->rlookup_table[iommu->devid] = NULL;
+	ret = amd_iommu_trans_devid_reserve(iommu->pci_seg, iommu->devid);
+	if (ret) {
+		pr_err("Failed to reserve IOMMU devid %#x\n", iommu->devid);
+		return ret;
+	}
 
 	return 0;
 }
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b7073b0ca8b0..17716a506f93 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2738,6 +2738,25 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	if (dev_is_pci(dev))
 		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
 
+#if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
+	/*
+	 * Occupy this RID in the per-segment translate-device-id pool
+	 * so vIOMMU alloc cannot reuse it. Probe is the RID lifetime
+	 * for devices that reach it. The IOMMU function is reserved
+	 * from init_iommu_one_late() instead: rlookup is cleared, so
+	 * probe never runs, while the self DTE still uses iommu->devid.
+	 * The reservation is not released on unplug. If reserve fails,
+	 * the IOMMU core frees dev->iommu and a later re-probe retries.
+	 */
+	ret = amd_iommu_trans_devid_reserve(iommu->pci_seg, dev_data->devid);
+	if (ret) {
+		pr_err("%s: Failed to reserve device id %#x\n", __func__,
+		       dev_data->devid);
+		iommu_dev = ERR_PTR(ret);
+		goto out_err;
+	}
+#endif
+
 out_err:
 	return iommu_dev;
 }
@@ -2751,6 +2770,9 @@ static void amd_iommu_release_device(struct device *dev)
 	/*
 	 * We keep dev_data around for unplugged devices and reuse it when the
 	 * device is re-plugged - not doing so would introduce a ton of races.
+	 * Translate-device-id reservations stay as well: the RID remains
+	 * occupied for the pci_seg lifetime so later alloc cannot reuse a
+	 * DTE index that still belongs to this function.
 	 */
 }
 
diff --git a/drivers/iommu/amd/trans_devid.c b/drivers/iommu/amd/trans_devid.c
new file mode 100644
index 000000000000..e0b637138260
--- /dev/null
+++ b/drivers/iommu/amd/trans_devid.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ *
+ * AMD vIOMMU translate-device-id management.
+ *
+ * The pool is per PCI segment because the AMD IOMMU device table is
+ * per-segment.  Each id must be allocated from unused slots in that
+ * segment.  It is used to program the vIOMMU VF Control register to
+ * specify the DTE used to contain the GPA->SPA mapping (v1 page table).
+ */
+
+#include <linux/kernel.h>
+#include <linux/xarray.h>
+
+#include "amd_iommu.h"
+#include "amd_viommu.h"
+
+enum trans_devid_state {
+	TRANS_DEVID_FREE = 0,
+	TRANS_DEVID_RESERVED,
+};
+
+static inline bool trans_devid_xa_is_reserved(void *entry)
+{
+	return entry && xa_is_value(entry) &&
+	       xa_to_value(entry) == TRANS_DEVID_RESERVED;
+}
+
+static inline void *trans_devid_xa_mk_reserved(void)
+{
+	return xa_mk_value(TRANS_DEVID_RESERVED);
+}
+
+static int trans_devid_xa_install_reserved_locked(struct amd_iommu_pci_seg *pci_seg,
+						  u16 id)
+{
+	void *old;
+
+	old = xa_store(&pci_seg->trans_devid_xa, id,
+		       trans_devid_xa_mk_reserved(), GFP_KERNEL);
+	if (xa_is_err(old))
+		return xa_err(old);
+	WARN_ON_ONCE(old);
+	return 0;
+}
+
+void amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg)
+{
+	mutex_init(&pci_seg->trans_devid_mutex);
+	xa_init(&pci_seg->trans_devid_xa);
+}
+
+void amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg)
+{
+	xa_destroy(&pci_seg->trans_devid_xa);
+	mutex_destroy(&pci_seg->trans_devid_mutex);
+}
+
+/*
+ * amd_iommu_trans_devid_reserve - occupy @id so it is never returned by alloc
+ *
+ * Reservation is done when probing the device (see amd_iommu_probe_device())
+ * and for the IOMMU function in init_iommu_one_late(). That function never
+ * probes: rlookup_table[iommu->devid] is cleared, but the vIOMMU self DTE
+ * still occupies the slot.
+ * It is not released from amd_iommu_release_device(); the slot stays
+ * reserved for the pci_seg lifetime so replug cannot race later alloc.
+ *
+ * Return: 0 on success.  A second reserve of an already-reserved @id succeeds.
+ */
+int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id)
+{
+	void *entry;
+	int ret = 0;
+
+	mutex_lock(&pci_seg->trans_devid_mutex);
+	entry = xa_load(&pci_seg->trans_devid_xa, id);
+	if (trans_devid_xa_is_reserved(entry))
+		goto unlock;
+
+	ret = trans_devid_xa_install_reserved_locked(pci_seg, id);
+unlock:
+	mutex_unlock(&pci_seg->trans_devid_mutex);
+
+	if (!ret)
+		pr_debug("%s: Reserved trans_devid %#x (seg %#x)\n", __func__, id,
+			 pci_seg->id);
+	return ret;
+}
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 2f299a16d113..ff5394e6a4c7 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -110,6 +110,9 @@ static int viommu_alloc_self_dev_data(struct amd_iommu *iommu)
 	 * Synthetic DTE for iommu->devid only: no struct device, so
 	 * amd_iommu_update_dte() skips clone_aliases(), and not on
 	 * pdom->dev_list (not an IOMMU-API attach).
+	 *
+	 * init_iommu_one_late() reserves this devid. rlookup is NULL, so
+	 * probe never runs, and alloc must not reuse the self DTE slot.
 	 */
 	dev_data->dev = NULL;
 	dev_data->domain = pdom;
-- 
2.34.1

