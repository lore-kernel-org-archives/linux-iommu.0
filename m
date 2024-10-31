Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E101CBE9C
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730400204; cv=fail; b=UPMDQLFQEOfrfIjFXpioS5pbOW7Q6BJxxW03V+OidoaevOI4Wkxn8f9ug6hLUXb1Ymn8vHG0rMoLJUC7riG7E1x+ES0fKWbWMC3bhcAxpOp1pCHd3WsigGVl3k754VC1BXWX3/KQL5ZOTj26VpSmUi94/9//5Nye2J9t3G3skzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730400204; c=relaxed/simple;
	bh=a3sj8X5hfcpNyAu8YM2wRW2RiqZJJLbttQ8PVvb64s0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Om1eJqvUfKSZcq5p9bpkQ1ADShVxRlzgrQCADf/T88QTWOHALPp+CpoyVKIQzjp7NDGlcGqMMK5pRvkH7b7MhSW0wXOlOjJs5xnWKaJHRNoimjZy7q9x4gbv6D5VkZSEDyrxifY6w3hjpvD1mXBrZuLrsb9f6y6PEAppa+QQYno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RznG6gyk; arc=fail smtp.client-ip=40.107.212.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RznG6gyk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KqTFs/z415A9nUwpYvyMD578a7W++5nCPo1uwZXQX8DCMshgcapD/vyD1w/RNC/zDgoP3Kw9xe7iDl21SZF2tTTy7cPoJUAQvQi7yp4HvOT3mo6cLTTyGT/At4G4sZmXOahjfjuvx6vLMF6j3EmQJELmAT8uN3BpTrlhL7MjOLZl8W8S0Fo8SlsRwLJvUAFq/bAAlcIShpw6+9p3YdjEtWekiquZS2KHOQVQ5t8DS2eSeQFegqkrE6jJJXpB7RWCDgCCjiJjzW9C4AMY7jD0XddLtAxSe9CHrfODFKfWGASqVwb/IzG2m1OQPyBbe79UujxYDyBgE4g2yVJ6xZMX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JuAdfzGtPWrDZfVfHVO/3jFp/BszvcNyFGfgwVruMQ=;
 b=KA0r9qffszNy+DszoWczmbb4oEYsgUlK1oQtFGZr4wpdqYIkD06lUSJ4eUZk6++0AE75Ki+ZCmSfW3MUg6wf7K0SJAqn6lvUq5xLtI0jfnJbHmE8XVOQEhdo61CP5UrxQwzfTCi9XZ79QZSRx/Eo/xQtPPt7YPptNq+Pxz0O0jI5zbjk6cHs4xcjIeAfYvdW8TGRvs7Js0yCgS2CHVxdjde6qazKMOj9EpU9Kes3zug7eQ9/5Td2NLimVtNlBkBDe4OG+qdLtWlyuNcDXiPLIuAqoClr6lfZ0fqUTBUvhldtMnN8qxEQ93yk0HWdoRhJqQrUJSCbJlu4wx37CFHi6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JuAdfzGtPWrDZfVfHVO/3jFp/BszvcNyFGfgwVruMQ=;
 b=RznG6gykrTcWNcIcaBK9sjy6JyfjG56ClNc8jUIiGQdVfhvirHrQKXLTZ54zcX3sGi2R5ptd1DLq/XPy9Dlk2+Q/r/FCy32UA2ANHieQijHMZpCRyXad68Zg2Kecs7/sI/IDcFZDGVxY1d5miRXSWfYbDvc63EA2Qy6gjk8ot+8=
Received: from CH2PR08CA0009.namprd08.prod.outlook.com (2603:10b6:610:5a::19)
 by BL4PR12MB9479.namprd12.prod.outlook.com (2603:10b6:208:58e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 18:43:17 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::ef) by CH2PR08CA0009.outlook.office365.com
 (2603:10b6:610:5a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 18:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 18:43:17 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 13:43:12 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v8 04/10] iommu/amd: Introduce struct ivhd_dte_flags to store persistent DTE flags
Date: Thu, 31 Oct 2024 18:42:37 +0000
Message-ID: <20241031184243.4184-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031184243.4184-1-suravee.suthikulpanit@amd.com>
References: <20241031184243.4184-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|BL4PR12MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: f825a7ea-9f82-43bc-f079-08dcf9dbe26d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9yYUDJ/cR78lPHXKvg/3F/aAPBeLXIl+0Hxe07JgUPSkMVapR0SMOWNZ4F5a?=
 =?us-ascii?Q?Twm51r6uZ2yCZGgUVAWpVe4u1zdAnisGewKxNnNGLaf10SQ6K5qnu9+BxgUK?=
 =?us-ascii?Q?mjeUmB753uO0cZs3AQPjyoQZbpUlPPlOIl4e7I+fkUq3VsRfeSoNwTdV/+Df?=
 =?us-ascii?Q?HzdYSIGidtcjYmuTgRXa1vAx+bi//24bBMF03J5ojHzluwbLepYdegLzfgr/?=
 =?us-ascii?Q?yqwHZHCB6NHmDSacCL8tllrf/4FXQXeGcYDGNVFlmOO5FR74zgpn32Vo8dkO?=
 =?us-ascii?Q?IdV3H4C9T59jllluF4HZzCgi/u/1L/jHQMNYMuIkdtW2uWfv42JRfi1RDWOt?=
 =?us-ascii?Q?JoSeAY6me4Dq3/oBBMlE61WXBBSSjUL8HJfzuVjNKDfMrcLgODIz7Gx6seZN?=
 =?us-ascii?Q?JUu7iuEQNNVnAjD+8ExtrSC/y4p2VYHMp0Qc44NZ8M8JKAv0E7c2HjXDf4e2?=
 =?us-ascii?Q?4+IS6rdag5g1tb+n7X2W23639Gu6Fj7+lNQow6L/gKClVVFAzk2ztML7ziYb?=
 =?us-ascii?Q?NINMBiRX2aI6aH8RBEMNhtgwt6nu0DAQaZzI73MCIWtpE7kIwrZL3150iIHl?=
 =?us-ascii?Q?/iD6TEElto5KRLng3xIxIiYZhYDIPHaGTeAUL2lpyUjcQKCko9PJRMjyakMO?=
 =?us-ascii?Q?fqeNv1O+Geyf7sbWX5M8FAIY0gNAHm3o4wSsdqxGLcG7QK2nmJG6UF7LeQyW?=
 =?us-ascii?Q?6asOL0fYMnvJlXiM8qfqV3xXEHySdHAh3xoRj9vRtzXPom2QqJJDxkxICxwY?=
 =?us-ascii?Q?zFyITSn3b+opH7WVDyPElTKczqxXV8uudeIsryjMLZ8urpdKR2Fm0ctQrwr0?=
 =?us-ascii?Q?YwD0U+o/dIDV1A7+WD+AGmsSHl0lYX2+ZwSRyYnnkG/RMBHVAMbFoUjE+b8J?=
 =?us-ascii?Q?L4zPbqgIM2bkhsU3pA7UJcUYw+kzrzFzm4EcZUOJzQEnHpSydOK0Y8QjRGMu?=
 =?us-ascii?Q?HBFQjAeuIMso50UHC7oEyEw6nuj77pnPDZNXEE4v1+nUwm2/L9RMk2vEmVDB?=
 =?us-ascii?Q?wm7a5L0OsAIb0DpJ7axiTy3sy0uGPQFDarDPUMj0l54uzr//69Z1RlQlJ1wo?=
 =?us-ascii?Q?9SySyC3T/GAwkSeZsrTDyCRshHKCGyvm8yd3G4xISIMlFX8LIFu3VbBoNgGd?=
 =?us-ascii?Q?S0riFZca8NvJZJW/DY3bGvgu9gE9C7p+af8jvPaPQHCHLr1GyUnWv6lMfi0i?=
 =?us-ascii?Q?rUWl6nFbd3kPlPIJpcSHrpIBr33iNugGVmw7EC5xhdenx7n87sy06vYYQANl?=
 =?us-ascii?Q?b+LP8d1nbNM7gESURPRbdIbaqJgyE17rQzoEfOVSKOfxXfm94SRLF9mLpkem?=
 =?us-ascii?Q?0CBCQ8djp/K+SbiQgkbC6mTu2fhLEv3Jol9xf4lF4ivOC0+kNku0W9isVsD/?=
 =?us-ascii?Q?LoGt/qNU56xxHW+b7z50pTE37fVfZMrq34D0hMz7pIfRR8LHWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 18:43:17.0996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f825a7ea-9f82-43bc-f079-08dcf9dbe26d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9479

During early initialization, the driver parses IVRS IVHD block to get list
of downstream devices along with their DTE flags (i.e INITPass, EIntPass,
NMIPass, SysMgt, Lint0Pass, Lint1Pass). This information is currently
store in the device DTE, and needs to be preserved when clearing
and configuring each DTE, which makes it difficult to manage.

Introduce struct ivhd_dte_flags to store IVHD DTE settings for a device or
range of devices, which are stored in the amd_ivhd_dev_flags_list during
initial IVHD parsing.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  16 ++++
 drivers/iommu/amd/init.c            | 113 +++++++++++++++++++++-------
 2 files changed, 100 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index dadc65808951..1e4ad1b247f5 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -220,6 +220,8 @@
 #define DEV_ENTRY_EX            0x67
 #define DEV_ENTRY_SYSMGT1       0x68
 #define DEV_ENTRY_SYSMGT2       0x69
+#define DTE_DATA1_SYSMGT_MASK	GENMASK_ULL(41, 40)
+
 #define DEV_ENTRY_IRQ_TBL_EN	0x80
 #define DEV_ENTRY_INIT_PASS     0xb8
 #define DEV_ENTRY_EINT_PASS     0xb9
@@ -516,6 +518,9 @@ extern struct kmem_cache *amd_iommu_irq_cache;
 #define for_each_pdom_dev_data_safe(pdom_dev_data, next, pdom) \
 	list_for_each_entry_safe((pdom_dev_data), (next), &pdom->dev_data_list, list)
 
+#define for_each_ivhd_dte_flags(entry) \
+	list_for_each_entry((entry), &amd_ivhd_dev_flags_list, list)
+
 struct amd_iommu;
 struct iommu_domain;
 struct irq_domain;
@@ -885,6 +890,17 @@ struct dev_table_entry {
 	u64 data[4];
 };
 
+/*
+ * Structure to sture persistent DTE flags from IVHD
+ */
+struct ivhd_dte_flags {
+	struct list_head list;
+	u16 segid;
+	u16 devid_first;
+	u16 devid_last;
+	struct dev_table_entry dte;
+};
+
 /*
  * One entry for unity mappings parsed out of the ACPI table.
  */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 8868838139df..dd98229fbf68 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -174,8 +174,8 @@ bool amd_iommu_snp_en;
 EXPORT_SYMBOL(amd_iommu_snp_en);
 
 LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
-LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
-					   system */
+LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the system */
+LIST_HEAD(amd_ivhd_dev_flags_list);	/* list of all IVHD device entry settings */
 
 /* Array to assign indices to IOMMUs*/
 struct amd_iommu *amd_iommus[MAX_IOMMUS];
@@ -993,6 +993,14 @@ static void iommu_enable_gt(struct amd_iommu *iommu)
 }
 
 /* sets a specific bit in the device table entry. */
+static void set_dte_bit(struct dev_table_entry *dte, u8 bit)
+{
+	int i = (bit >> 6) & 0x03;
+	int _bit = bit & 0x3f;
+
+	dte->data[i] |= (1UL << _bit);
+}
+
 static void __set_dev_entry_bit(struct dev_table_entry *dev_table,
 				u16 devid, u8 bit)
 {
@@ -1140,6 +1148,19 @@ static bool copy_device_table(void)
 	return true;
 }
 
+static bool search_ivhd_dte_flags(u16 segid, u16 first, u16 last)
+{
+	struct ivhd_dte_flags *e;
+
+	for_each_ivhd_dte_flags(e) {
+		if ((e->segid == segid) &&
+		    (e->devid_first == first) &&
+		    (e->devid_last == last))
+			return true;
+	}
+	return false;
+}
+
 void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid)
 {
 	int sysmgt;
@@ -1155,27 +1176,66 @@ void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid)
  * This function takes the device specific flags read from the ACPI
  * table and sets up the device table entry with that information
  */
-static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
-					   u16 devid, u32 flags, u32 ext_flags)
+static void __init
+set_dev_entry_from_acpi_range(struct amd_iommu *iommu, u16 first, u16 last,
+			      u32 flags, u32 ext_flags)
 {
-	if (flags & ACPI_DEVFLAG_INITPASS)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_INIT_PASS);
-	if (flags & ACPI_DEVFLAG_EXTINT)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_EINT_PASS);
-	if (flags & ACPI_DEVFLAG_NMI)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_NMI_PASS);
-	if (flags & ACPI_DEVFLAG_SYSMGT1)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT1);
-	if (flags & ACPI_DEVFLAG_SYSMGT2)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT2);
-	if (flags & ACPI_DEVFLAG_LINT0)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_LINT0_PASS);
-	if (flags & ACPI_DEVFLAG_LINT1)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_LINT1_PASS);
+	int i;
+	struct dev_table_entry dte = {};
+
+	/* Parse IVHD DTE setting flags and store information */
+	if (flags) {
+		struct ivhd_dte_flags *d;
 
-	amd_iommu_apply_erratum_63(iommu, devid);
+		if (search_ivhd_dte_flags(iommu->pci_seg->id, first, last))
+			return;
 
-	amd_iommu_set_rlookup_table(iommu, devid);
+		d = kzalloc(sizeof(struct ivhd_dte_flags), GFP_KERNEL);
+		if (!d)
+			return;
+
+		pr_debug("%s: devid range %#x:%#x\n", __func__, first, last);
+
+		if (flags & ACPI_DEVFLAG_INITPASS)
+			set_dte_bit(&dte, DEV_ENTRY_INIT_PASS);
+		if (flags & ACPI_DEVFLAG_EXTINT)
+			set_dte_bit(&dte, DEV_ENTRY_EINT_PASS);
+		if (flags & ACPI_DEVFLAG_NMI)
+			set_dte_bit(&dte, DEV_ENTRY_NMI_PASS);
+		if (flags & ACPI_DEVFLAG_SYSMGT1)
+			set_dte_bit(&dte, DEV_ENTRY_SYSMGT1);
+		if (flags & ACPI_DEVFLAG_SYSMGT2)
+			set_dte_bit(&dte, DEV_ENTRY_SYSMGT2);
+		if (flags & ACPI_DEVFLAG_LINT0)
+			set_dte_bit(&dte, DEV_ENTRY_LINT0_PASS);
+		if (flags & ACPI_DEVFLAG_LINT1)
+			set_dte_bit(&dte, DEV_ENTRY_LINT1_PASS);
+
+		/* Apply erratum 63, which needs info in initial_dte */
+		if (FIELD_GET(DTE_DATA1_SYSMGT_MASK, dte.data[1]) == 0x1)
+			dte.data[0] |= DTE_FLAG_IW;
+
+		memcpy(&d->dte, &dte, sizeof(dte));
+		d->segid = iommu->pci_seg->id;
+		d->devid_first = first;
+		d->devid_last = last;
+		list_add_tail(&d->list, &amd_ivhd_dev_flags_list);
+	}
+
+	for (i = first; i <= last; i++)  {
+		if (flags) {
+			struct dev_table_entry *dev_table = get_dev_table(iommu);
+
+			memcpy(&dev_table[i], &dte, sizeof(dte));
+		}
+		amd_iommu_set_rlookup_table(iommu, i);
+	}
+}
+
+static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
+					   u16 devid, u32 flags, u32 ext_flags)
+{
+	set_dev_entry_from_acpi_range(iommu, devid, devid, flags, ext_flags);
 }
 
 int __init add_special_device(u8 type, u8 id, u32 *devid, bool cmd_line)
@@ -1336,9 +1396,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 		case IVHD_DEV_ALL:
 
 			DUMP_printk("  DEV_ALL\t\t\tsetting: %#02x\n", e->flags);
-
-			for (dev_i = 0; dev_i <= pci_seg->last_bdf; ++dev_i)
-				set_dev_entry_from_acpi(iommu, dev_i, e->flags, 0);
+			set_dev_entry_from_acpi_range(iommu, 0, pci_seg->last_bdf, e->flags, 0);
 			break;
 		case IVHD_DEV_SELECT:
 
@@ -1432,14 +1490,11 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 
 			devid = e->devid;
 			for (dev_i = devid_start; dev_i <= devid; ++dev_i) {
-				if (alias) {
+				if (alias)
 					pci_seg->alias_table[dev_i] = devid_to;
-					set_dev_entry_from_acpi(iommu,
-						devid_to, flags, ext_flags);
-				}
-				set_dev_entry_from_acpi(iommu, dev_i,
-							flags, ext_flags);
 			}
+			set_dev_entry_from_acpi_range(iommu, devid_start, devid, flags, ext_flags);
+			set_dev_entry_from_acpi(iommu, devid_to, flags, ext_flags);
 			break;
 		case IVHD_DEV_SPECIAL: {
 			u8 handle, type;
-- 
2.34.1

