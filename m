Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F6F313522
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945583; cv=fail; b=tAo9DSvhHeJzb2wzja82fX1hx6hCgMIYjrj+fGLoQcBmnXor9qVSRXsuTZtFa87wNxaIA14QfMYsOaJqVNlwcc05EsUC5+1RkJnHaNkAFRyEW6AXhBd71qOlEi1xc+IOzez+I9rgSMrYesd4Y3rcMWbzopt4l4T0glLQgLAbU4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945583; c=relaxed/simple;
	bh=DIP/qiPCf+p79x8ghzHjMscMZeXDdLmG/mjqQDlD1DU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1dSfq8P/6CrDuWH32mK32ZXbrEHJPiPB9PovTtEzSJvwOt8yAliQuh0hXlK5vvcF9HSp9mn3WXQM4NnqMnep06CScWbAtOlgtq7y89T2bF/0+nqZ3F0J9FX+roCRr3mLpILIi5REfvPQE9VvfekXQp6t6GszMwLNQ1ct0TmErg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rlQY93k/; arc=fail smtp.client-ip=52.101.52.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rlQY93k/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DN2k8kTEutvb2rsmknizmpjf4izeXR8FSdXlwTbwF6aTWCxtaBMwJTUR58DSyCfvVMtsP7rmep4PlH9AYr4MC2qXnb3PTj1djswWS22LLr3sz0UgbeV+ZUgQ6p3GASZKke2hWy2P0HPyrHzibI67XD3f71g93w//OVaLJ4z3X2BZyzr3P7/yzY7nUmUixHM+5O1x7gHxGBkNwyU8VXoBsbFu3iKhenuegA24tCxZdyIn2LuZO2h+kICbuNvaMxu0XDf1Y9vNNK5Ys7qNAGiAEyTjjXdXN9n0SMpT9y6b58gkT1u8TJiCkhtOxxtM92oOVGXvwTe0NvDUy1EIFk64kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dseA4dLyQyWo9i1aw8sZEb+1iHPWZohCzGb2+gs5MNg=;
 b=J4UhVtnWsRbtY9oC4v1YJrQZziumnVCTFmV6zn6NTDoNymXfg29rCq+V8EAUtqqy+i/SgLJIx99Mroom7zUP6VBkEjZEiR2IPp1QOV2IBz1qyYdIFheEdJDF7vTRktGCDeGj2sLkcl4ccEG+wUpG97I1au/wXB05UkTu5TKoPWym6bPe9KtksZylfjtiIEW2nJa7Ky6PPQjan95zdpIZzf7AR9phg2ST74NUZL5rUsIEQ7yYWlv3B95gK2uWD+d993y6m6dYmKddruaByiepi/RhqEt1BWQ/UeL7Uvxt6kFuOhZoXq2nZWoegJ783Rptw3foZwr5lrUe8zZnpyveqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dseA4dLyQyWo9i1aw8sZEb+1iHPWZohCzGb2+gs5MNg=;
 b=rlQY93k/ixVKEFTdfdcHqGrffH2mne8wVYz8BLUKoVgkvLsk6YlugXSysxrH7yLJUUi/Ul7QDKCn1IsvX4Z1XJq3hpELKOfpZpM0KqTZVPryORQHz9SWO0H4yEEdB5M2cv0ArIQV3TJvcre76uS6gWNdAZJwFaUoNiIcX7JicA0=
Received: from SN6PR05CA0016.namprd05.prod.outlook.com (2603:10b6:805:de::29)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 05:19:34 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::53) by SN6PR05CA0016.outlook.office365.com
 (2603:10b6:805:de::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Thu, 28
 May 2026 05:19:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:19:33 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:19:29 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 19/26] iommu/amd: Add per-segment translate device ID pool
Date: Thu, 28 May 2026 05:17:31 +0000
Message-ID: <20260528051738.596013-20-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: a997875f-3192-41b5-18fd-08debc78b44f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700016|18002099003|22082099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	7BtoRG454QiY6w7Rc9aTlH4pKilurFP2nlCfTYbTV36bE96lRkGddPQgXrY0numNs4rcUO8bE8wMuFZJN//Ztp0lz6UbnmQLsgeVpzK+U6cZCcVveixTKr8WtubpXLthYrkUPPHFv7u6MpgXcNYXySVzhW6qySXKnAFlWSOKYcY6KTPHyvbKWFJwyrXHH6LNLHU2rr4fLF5sYb+1T7vOyaCqlLwl2sFWp2ZmqRQS6hFWug5uxa50yZqyYX8qNJDIjs/ENriQw1ef4RvdThQOZOVq65jHSVuKqB8PDd8UT27qMN9h0+ueuKWw012lQNNu9rObfUHwnaSFhw+JPufjWJWkTsBLze9OuThVaACSCeZDem7vOG+1Wo7E/x+SV4uEvcxRkHKWiXUm6DzLdzwiNsei07TgLpAvnlAr3pbVCfVU4Bg6Iq8Qx2btVvnGemBrWoBBjVOmzxWWnTPcm7Hej4y5JasV46mCcKPblSu6Ocs62xsdXRvynTRLoTyZ5ivtfNzOWJTtrbxbss5vhwgR9V5OYVplihDkUelya9ltUtZyUR2NN2Hm9DV0ZW97A85hs+wcbLcbwtHxqMgnBCwSy3TDs+UC2/h2VtESjUAl+axhJxRycuudfxUITgiVHCo7U5MBmNiHlsUdw6FJRU4kT26LDTXh1ZCB2KwZYZUp1DB9sQ7HR/SDyydzyx9APVcoqto2ZEnU3wizNmflOZ2SN0K2cKt/7lCU2/K+/MKPMfA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1Rdl693ZP3kIWuWWWRdsXwc8bC0Vb89hUM4oFrbImcdL6MxNDz6/2/+ZXvicpedkM31hYwTaPz+9JvNwVULLkuuLayhV4rioHh7lHDIiCkcBeEoYiBv1Pf3xaKoiera/wvvADCQWBh86C92r0ky1+nnP2vp6SyOJ72FbeXavTgR0DsKooWEqYDNtFHp373Usd/pXQSBOjzppm75FCwG878Be2x92q7SsymNl8TFkae611NlInwPPGzHQqkeR8vjMmGJzGlPGz6cf5lz4n2AWSV5Pmv9b/MnLxhlRa9w+1BAVkSSgtd0EfsERWv1r3B3q1sFtNzD6h5QjeMZCkYvSPUoX4HTszQEiejo3zjv8TniLxDPE0kCumWyLtxv8dB4k4HIE3jNB2v0oc22JJJ+sZBC1S3VyMhducmUkKIB1lf2pWGEfwkgrjR5DFIhq6/LB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:19:33.9714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a997875f-3192-41b5-18fd-08debc78b44f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041

Track translate-device-id slots per PCI segment so real PCI device IDs can
be reserved for normal DTE programming and excluded from dynamic allocation
for vIOMMU translation DTEs.

Add amd_iommu_pci_seg_trans_devid_init/fini() during segment setup and
teardown, amd_iommu_trans_devid_reserve() for attach-time reservation, and
trans_devid.c implementing the xarray-backed state machine.

Call the reserve hook from amd_iommu_attach_device() before programming
the DTE.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/Makefile          |  2 +-
 drivers/iommu/amd/amd_iommu.h       | 12 +++++
 drivers/iommu/amd/amd_iommu_types.h | 17 ++++++
 drivers/iommu/amd/init.c            |  3 ++
 drivers/iommu/amd/iommu.c           | 12 +++++
 drivers/iommu/amd/trans_devid.c     | 80 +++++++++++++++++++++++++++++
 6 files changed, 125 insertions(+), 1 deletion(-)
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
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index d1640181b292..d411bc326241 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -216,6 +216,18 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
 			  struct dev_table_entry *new);
 int amd_iommu_completion_wait(struct amd_iommu *iommu);
 
+/* Per-segment translate-device-id pool (CONFIG_AMD_IOMMU_IOMMUFD) */
+#ifdef CONFIG_AMD_IOMMU_IOMMUFD
+void amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg);
+void amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg);
+int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id);
+#else
+static inline void
+amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg) { }
+static inline void
+amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg) { }
+#endif
+
 void amd_iommu_set_translate_dte(struct amd_iommu *iommu, u16 gid,
 				 struct protection_domain *pdom,
 				 u32 devid);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 2d7bc791dbd9..ffa338c8735f 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -615,6 +615,14 @@ PT_IOMMU_CHECK_DOMAIN(struct protection_domain, iommu, domain);
 PT_IOMMU_CHECK_DOMAIN(struct protection_domain, amdv1.iommu, domain);
 PT_IOMMU_CHECK_DOMAIN(struct protection_domain, amdv2.iommu, domain);
 
+#ifdef CONFIG_AMD_IOMMU_IOMMUFD
+enum trans_devid_state {
+	TRANS_DEVID_FREE = 0,
+	TRANS_DEVID_RESERVED,
+	TRANS_DEVID_ALLOCATED,
+};
+#endif
+
 /*
  * This structure contains information about one PCI segment in the system.
  */
@@ -676,6 +684,15 @@ struct amd_iommu_pci_seg {
 	 * parsing time.
 	 */
 	struct list_head unity_map;
+
+#ifdef CONFIG_AMD_IOMMU_IOMMUFD
+	/*
+	 * Per-segment translate-device-id allocation. The xarray is indexed by
+	 * the translate-device-id. The value is the state (enum trans_devid_state).
+	 */
+	struct mutex trans_devid_mutex;
+	struct xarray trans_devid_xa;
+#endif
 };
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 6e69b3dd8b1e..622bc0337eda 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1737,6 +1737,8 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 	if (alloc_rlookup_table(pci_seg))
 		goto err_free_alias_table;
 
+	amd_iommu_pci_seg_trans_devid_init(pci_seg);
+
 	return pci_seg;
 
 err_free_alias_table:
@@ -1768,6 +1770,7 @@ static void __init free_pci_segments(void)
 
 	for_each_pci_segment_safe(pci_seg, next) {
 		list_del(&pci_seg->list);
+		amd_iommu_pci_seg_trans_devid_fini(pci_seg);
 		free_irq_lookup_table(pci_seg);
 		free_rlookup_table(pci_seg);
 		free_alias_table(pci_seg);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6c4c4f62ddde..2600af84c8ca 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3055,6 +3055,18 @@ static int amd_iommu_attach_device(struct iommu_domain *dom, struct device *dev,
 	if (dom->dirty_ops && !amd_iommu_hd_support(iommu))
 		return -EINVAL;
 
+#if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
+	/* Translate-device-id reservation must be done before setting up
+	 * the DTE for the device to make sure that the id has not been allocated
+	 * yet. (See amd_iommu_trans_devid_alloc().)
+	 */
+	ret = amd_iommu_trans_devid_reserve(iommu->pci_seg, dev_data->devid);
+	if (ret) {
+		pr_err("%s: Failed to reserve device id %#x\n", __func__, dev_data->devid);
+		return ret;
+	}
+#endif
+
 	if (dev_data->domain)
 		detach_device(dev);
 
diff --git a/drivers/iommu/amd/trans_devid.c b/drivers/iommu/amd/trans_devid.c
new file mode 100644
index 000000000000..f15cbaae9118
--- /dev/null
+++ b/drivers/iommu/amd/trans_devid.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ *
+ * AMD vIOMMU translate-device-id pool per PCI segment.
+ */
+
+#include <linux/kernel.h>
+#include <linux/xarray.h>
+
+#include "amd_iommu.h"
+
+static inline enum trans_devid_state trans_devid_xa_get_state(void *entry)
+{
+	if (!entry)
+		return TRANS_DEVID_FREE;
+	if (WARN_ON_ONCE(!xa_is_value(entry)))
+		return TRANS_DEVID_FREE;
+	return (enum trans_devid_state)xa_to_value(entry);
+}
+
+static inline void *trans_devid_xa_mk_state(enum trans_devid_state s)
+{
+	return xa_mk_value((unsigned long)s);
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
+}
+
+/**
+ * amd_iommu_trans_devid_reserve - occupy @id so it is never returned by alloc
+ *
+ * Reservation is done when attaching device to a domain (see amd_iommu_attach_device()).
+ *
+ * Note: Since PCI hot-plug devices are enumerated during runtime, they could clash
+ * with the translate-device-id allocation. In such case, amd_iommu_trans_devid_reserve()
+ * could fail with %-EBUSY. This can be avoided by reserving the hot-plug id range if it
+ * is known in advance.
+ *
+ * Return: 0 on success, %-EBUSY if @id is already allocated. A second reserve of
+ * an already-reserved @id succeeds.
+ */
+int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id)
+{
+	void *entry, *old;
+	int ret = 0;
+
+	mutex_lock(&pci_seg->trans_devid_mutex);
+	entry = xa_load(&pci_seg->trans_devid_xa, id);
+	switch (trans_devid_xa_get_state(entry)) {
+	case TRANS_DEVID_ALLOCATED:
+		ret = -EBUSY;
+		break;
+	case TRANS_DEVID_RESERVED:
+		break;
+	case TRANS_DEVID_FREE:
+		old = xa_store(&pci_seg->trans_devid_xa, id,
+			       trans_devid_xa_mk_state(TRANS_DEVID_RESERVED), GFP_KERNEL);
+		if (xa_is_err(old)) {
+			ret = xa_err(old);
+			break;
+		}
+		WARN_ON_ONCE(old);
+		break;
+	}
+	mutex_unlock(&pci_seg->trans_devid_mutex);
+
+	if (!ret)
+		pr_debug("%s: Reserved trans_devid %#x (seg %#x)\n", __func__, id,
+			 pci_seg->id);
+	return ret;
+}
-- 
2.34.1

