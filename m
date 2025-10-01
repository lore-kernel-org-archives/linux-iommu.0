Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010019.outbound.protection.outlook.com [52.101.46.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48752D949C
	for <iommu@lists.linux.dev>; Wed,  1 Oct 2025 06:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299085; cv=fail; b=OLlpOYTa1vgiTTKFacyHC0YPJ3hVGNnRWxSktT3YpNMfGmd8tZCF+5KYJVLeYq+zVZiP+YlXFwNVw9unWE4ZKB3MPyibDUEoZHQ8VJ2K2igRWE2XyMkIzN5dd4Z0dGz94hoVDqJsAreifqQm94ZN87dc7xJp001dHM7HTMtlnb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299085; c=relaxed/simple;
	bh=C8Lj8PcZeP5QTZvabVhMKs3zlwRwMIvgkPD2X3+X/b4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGWD1boX02x1ftOptLw06ovNgFVrbobqsPhVwQDqgrm4N/+592jTHb4hvVkBB0Dy8I6HVCh2I3yqNPQ688xKOQHvaN0xOzNTITuREZmnmeqi4yz/+2KzjgEq6HspbtaMJ63kkC4mXJBM0hqgJaF5Y3SCRu+IjEDdQkNKVKthQIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s8QiOvse; arc=fail smtp.client-ip=52.101.46.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s8QiOvse"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYMyiAF2FTOWifEDeL24XWv6cKgYKfk5SeLRXi2qCcb6gb8Fa4abKvz5Vrwgu5qdYhrEkYXiGee9mozj7mIeY6ErgobGGLCVCGx3tHHcpgm3Tkmii/RSp2SUm0FXgbDLD3+/DwJNDdO1RyEJGFd+Jsvc2TXFNYDYRTdIgAtqATxwpP3tEfaCMTiSg5FmFPeyX6z2w07v6u/+IRP3n9tTSsHLtf+T2G/EWgQfaSja9i6vFQJx7CfQcehYYMU9O9S2ugxhHE2x2PFrSxBeAosCrLgLKxatThQUrShN86yRsg+5zdauH5w0H8aRc0ArObrE2nh/wiD42rD9hmt8evGK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znuGgkCry32f+cDAsQ0NPs43PqRXzUQqw5Y0eZpWxG8=;
 b=MvU/kRd+n4tpLizergMgOtFGY6xJtasdB18uNc3pBXexFmlx63v2Fi7afvQ8lH0vTQyhrfsZ4AEz9orkjaBXZ0qIDEgDpJFolU+vms9b9MLmJzufdNpHSVztKpnb4lpjKuTgknMTIsLq6e/gkF6O/JDjeX8vYTXcSf3jXtEXJSWju0BUEo6duhTpj3Ds0CkkxcWQYhDnhHWDCsUHf4z5bGoHjp2zTmTSmCoETbR1scPM65kzTxwdOFl/KJ1U6kY9KiDLnqc6tfC18MG8+ZrFStEo/uCyjEBluphe2otHAKlo96ruZLDPjxPutnPsdUzv0YYlAPpDP+mzY+6MABFmDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znuGgkCry32f+cDAsQ0NPs43PqRXzUQqw5Y0eZpWxG8=;
 b=s8QiOvserQoZAUe6t1P8D5iqI3vrKfIbO96xtHtUEqkyvdPW3XVW/nNb4kYpfJk/k7u9PldiUAx9+DJPJlD/NlgQnlWiDgYKAZEbpWQPGrW6bAcSS9U81T1Oq8xbcUuGjNIwU2gajSa2EKKDCHB21IMXJoAszanCoJ52s8+vdoA=
Received: from SA1PR03CA0012.namprd03.prod.outlook.com (2603:10b6:806:2d3::15)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 06:11:17 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:2d3:cafe::c) by SA1PR03CA0012.outlook.office365.com
 (2603:10b6:806:2d3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 06:11:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 06:11:17 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 23:11:10 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 11/12] iommu/amd: Add support for nested domain attach/detach
Date: Wed, 1 Oct 2025 06:09:53 +0000
Message-ID: <20251001060954.5030-12-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ffb062-3e2c-4190-941c-08de00b1553e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VjVIcbzhI9WsFySZBIZnTD6VsqfeDQmlsEMSWhteAG7KWfowYyoaDwEqTqd+?=
 =?us-ascii?Q?Urhet78tdMKImSO2/gfba1CFdWyjwbLIb9YRPq67pvC8CuSztmzYFg8RoFjo?=
 =?us-ascii?Q?ixmYbUjmlZxjnnZme9winGStMPr0bzDEDIgbga1qk8348ZpHbakEtaA1TGQZ?=
 =?us-ascii?Q?oFP3HmYXniaAeqaBR8TCYqKkBxowjM/l/B/2jhJy0/l0shiu63LXl4j5iHCB?=
 =?us-ascii?Q?V6VPz61MAjbP4mPnWMA0dUlonF9qSJYpCZSTlTUH7oOtwFSp+JdAMC9lZKEu?=
 =?us-ascii?Q?kshnd/rfvLT5y7ruJxJZ6j0jPP7mNcMezyuXiyGMSqhP0dsuuj7x6DWnmEYc?=
 =?us-ascii?Q?APLT9ZL54hLvvfUdESfdbRoLEs6nqJFrzgCPW+JZebOiURfPsBpI18uUQn7H?=
 =?us-ascii?Q?mobufTSVGHSU9r6wYstHkfGQGVnoVda67lEDcyjnc5QHcnaYj0EmIJ/zqXs+?=
 =?us-ascii?Q?g0igcQI7HxYpVmHfAb0F1uhJbQxSUnuCUiuOJhhFP6WndLlAxtuGnKcXjviN?=
 =?us-ascii?Q?y4/lC1KyI4p4eBzJWQFeTb13CQslkCpONLHbouk/5AEHKtrQefi1CY1agyCR?=
 =?us-ascii?Q?bXVeb1tDVk7lHT+HcdewFFaoDGidip4jcAKiWuwUkzFv3PeDu5wrjkRAw9n3?=
 =?us-ascii?Q?pylAr4XAJZ6H2ltP+gNtEur6jLZjRdzDKK2MIBaHctP6jTjJij+I2+gsxy5z?=
 =?us-ascii?Q?6DcdyUQce6uu+iQEHgtt24+c91GF+o9wYReCUV5CnQVPo4b+j938Mb1JtBq+?=
 =?us-ascii?Q?iXSHakY9+78CS7XkdboeSySV3ErxlFb/SYN5fv8oc+ISNUWrlCglXftJ2jF5?=
 =?us-ascii?Q?nOxlLnckEWeJyJXw0+AETxth59DVJWCRIdu/8xBmDn+J4ywl/R9+UEx6EYUi?=
 =?us-ascii?Q?09i0zYHVc0tZAh6H04GUmD2S222eXGQagF3YHsourdY7dkRyTCeuX+QYyQnd?=
 =?us-ascii?Q?HZMAq+10b6frSSyL3OlKXGYQbbZJ0mItQK3H1M1xXrrNGHskoAlK+TVz0X/N?=
 =?us-ascii?Q?Op+dfBsKRuxjki4aLk7qQqR5yXyQnPii6eP0fgzJrOLEuwjWmJ1pU2gJTkmz?=
 =?us-ascii?Q?hQvPlT4KdjlnB5ZAAztLG5+2y+BAE5Xi+nGGZaOddEwWMugXPzZy1dRDVi77?=
 =?us-ascii?Q?+6vwaatVeKOP21k81z7AtZHZEECPLJtufGiQTBHDdpFNSHI3jew12cIP7YCV?=
 =?us-ascii?Q?xA4NKSp2/4tGssDI8tgq23QMubDSCAHel8TE/k+3hDyyBazQ5lgAWEE6Fmci?=
 =?us-ascii?Q?J6hftRkp7oyuwLDmSLuoamo7mEIJhjcvyt0vw/dc8lRPk8zs35b7aG/mQj77?=
 =?us-ascii?Q?Q69RMuFeSJ/PGnOojjnJtkqbhZt6szkQRdtQ0eQKhuJPR36K3wctNC7SYSB0?=
 =?us-ascii?Q?+XQNb6yxZ/Lz7iiPxAW801G714jh3j9s7freG1Q7CSD2BXybWQ9/efbSy866?=
 =?us-ascii?Q?CCKwch67+K4FcrwUOYjpUknkoIPcwRtEYI4E6vZW7fHDQMEcz5o9PM+/wi1a?=
 =?us-ascii?Q?HNQ0K6FJlzSIM1E9IzR647woJ+Wz2zu3VhLVHiuGEoZvQ94ICeRKiBpPgKeE?=
 =?us-ascii?Q?NxfaDYZHWZCKT78Nx+w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 06:11:17.1936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ffb062-3e2c-4190-941c-08de00b1553e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906

Introduce set_dte_nested() to program guest translation settings in
the host DTE when attaches the nested domain to a device.

Also, enable the GCR3TRPMode feature when supported.

Note that nested translation is only supported with the GCR3TRP mode.
When it is enabled, the AMD IOMMU driver programs the GCR3 Table Root
Pointer field of the device table entry with the GPA provided by the guest.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |   2 +
 drivers/iommu/amd/amd_iommu_types.h |   3 +
 drivers/iommu/amd/init.c            |   3 +
 drivers/iommu/amd/nested.c          | 111 +++++++++++++++++++++++++++-
 4 files changed, 116 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index cc1f14899dfe..924152973d11 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -190,6 +190,8 @@ struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
 int amd_iommu_completion_wait(struct amd_iommu *iommu);
 
+extern bool amd_iommu_snp_en;
+
 /* DTE */
 int amd_iommu_device_flush_dte(struct iommu_dev_data *dev_data);
 void amd_iommu_update_dte256(struct amd_iommu *iommu,
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index ba27fad77b57..9bc2e0e18978 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -188,6 +188,7 @@
 #define CONTROL_EPH_EN		45
 #define CONTROL_XT_EN		50
 #define CONTROL_INTCAPXT_EN	51
+#define CONTROL_GCR3TRPMODE	58
 #define CONTROL_IRTCACHEDIS	59
 #define CONTROL_SNPAVIC_EN	61
 
@@ -417,6 +418,8 @@
 #define DTE_FLAG_V	BIT_ULL(0)
 #define DTE_FLAG_TV	BIT_ULL(1)
 #define DTE_FLAG_HAD	(3ULL << 7)
+#define DTE_MODE_MASK	GENMASK_ULL(11, 9)
+#define DTE_FLAG_PPR	BIT_ULL(52)
 #define DTE_FLAG_GIOV	BIT_ULL(54)
 #define DTE_FLAG_GV	BIT_ULL(55)
 #define DTE_GLX		GENMASK_ULL(57, 56)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f2991c11867c..c45a4bd89569 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1122,6 +1122,9 @@ static void iommu_enable_gt(struct amd_iommu *iommu)
 		return;
 
 	iommu_feature_enable(iommu, CONTROL_GT_EN);
+
+	if (check_feature2(FEATURE_GCR3TRPMODE))
+		iommu_feature_enable(iommu, CONTROL_GCR3TRPMODE);
 }
 
 /* sets a specific bit in the device table entry. */
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index 11a0237174bb..5a0c369ba283 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -11,9 +11,7 @@
 #include "amd_iommu.h"
 #include "amd_iommu_types.h"
 
-static const struct iommu_domain_ops nested_domain_ops = {
-	.free = amd_iommu_domain_free,
-};
+static const struct iommu_domain_ops nested_domain_ops;
 
 static inline struct nested_domain *to_ndomain(struct iommu_domain *dom)
 {
@@ -65,3 +63,110 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 	kfree(ndom);
 	return ERR_PTR(ret);
 }
+
+static void set_dte_nested(struct amd_iommu *iommu,
+			   struct dev_table_entry *gdte,
+			   struct nested_domain *ndom,
+			   struct iommu_dev_data *dev_data)
+{
+	struct dev_table_entry *initial_dte;
+	struct dev_table_entry new = {0};
+	struct protection_domain *pdom = dev_data->parent;
+
+	if (WARN_ON(!ndom || !pdom || (pdom->iop.mode == PAGE_MODE_NONE)))
+		return;
+
+	amd_iommu_make_clear_dte(dev_data, &new);
+
+	new.data[0] |= iommu_virt_to_phys(pdom->iop.root);
+	new.data[0] |= FIELD_PREP(DTE_MODE_MASK, pdom->iop.mode);
+	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV;
+	new.data[0] |= (DTE_FLAG_PPR & gdte->data[0]);
+
+	if (pdom->dirty_tracking)
+		new.data[0] |= DTE_FLAG_HAD;
+
+	if (dev_data->ats_enabled)
+		new.data[1] |= DTE_FLAG_IOTLB;
+
+	/*
+	 * Use nested domain ID to program DTE.
+	 * See amd_iommu_alloc_domain_nested().
+	 */
+	new.data[1] |= ndom->id;
+
+	/*
+	 * Restore cached persistent DTE bits, which can be set by information
+	 * in IVRS table. See set_dev_entry_from_acpi().
+	 */
+	initial_dte = amd_iommu_get_ivhd_dte_flags(iommu->pci_seg->id, dev_data->devid);
+	if (initial_dte) {
+		new.data128[0] |= initial_dte->data128[0];
+		new.data128[1] |= initial_dte->data128[1];
+	}
+
+	/* Guest translation stuff */
+	new.data[0] |= (gdte->data[0] &
+		       (DTE_GLX | DTE_FLAG_GV | DTE_FLAG_GIOV));
+
+	/* GCR3 table */
+	new.data[0] |= (gdte->data[0] & DTE_GCR3_14_12);
+	new.data[1] |= (gdte->data[1] & (DTE_GCR3_30_15 | DTE_GCR3_51_31));
+
+	/* Guest paging mode */
+	new.data[2] |= (gdte->data[2] & DTE_GPT_LEVEL_MASK);
+
+	amd_iommu_update_dte256(iommu, dev_data, &new);
+}
+
+static int nested_attach_device(struct iommu_domain *dom, struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	struct nested_domain *ndom = to_ndomain(dom);
+	struct dev_table_entry *gdte = &ndom->guest_dte;
+	int ret = 0;
+
+	if (dev_data->ndom == ndom)
+		return ret;
+
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	/* Currently only support GCR3TRPMode with nested translation */
+	if (!check_feature2(FEATURE_GCR3TRPMODE))
+		return -EOPNOTSUPP;
+
+	/* We need to check host capability before setting the mode */
+	if ((FIELD_GET(DTE_GPT_LEVEL_MASK, gdte->data[2]) == GUEST_PGTABLE_5_LEVEL) &&
+	    (amd_iommu_gpt_level < PAGE_MODE_5_LEVEL))
+		return -EOPNOTSUPP;
+
+	WARN_ON(dev_data->ndom);
+
+	dev_data->ndom = ndom;
+
+	mutex_lock(&dev_data->mutex);
+
+	/* Update device table entry */
+	set_dte_nested(iommu, gdte, ndom, dev_data);
+	amd_iommu_device_flush_dte(dev_data);
+	amd_iommu_completion_wait(iommu);
+
+	mutex_unlock(&dev_data->mutex);
+
+	return ret;
+}
+
+static void nested_domain_free(struct iommu_domain *dom)
+{
+	struct nested_domain *ndom = to_ndomain(dom);
+
+	amd_iommu_pdom_id_free(ndom->id);
+	kfree(ndom);
+}
+
+static const struct iommu_domain_ops nested_domain_ops = {
+	.attach_dev = nested_attach_device,
+	.free = nested_domain_free,
+};
-- 
2.34.1

