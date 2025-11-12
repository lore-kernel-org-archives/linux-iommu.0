Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1659D3590D3
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971998; cv=fail; b=uqyd/EUQCPzbF7a3LT0v3jbquGckEZVEg8X4KofoapcLtcVcezXgDKpgUqHuUwxP1lOxQa+D787YDfwgJsifQVNI9PhVu+4dEIBYd/3pczFI3hxugVJC3qs5VZ6SMfbq3CDPZ7sAYL2YLZcYai55q6uVFhLvsb+se3yDGTIH6jQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971998; c=relaxed/simple;
	bh=oKB7cp8+pVcbnn+7Xd255wxmz0ERPoqaRgN8Bw9p2Vk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rUKq8cT8yTxHxzmPAMd2rLTRAPfGbC271S7E+g2+ZXpfEHzhy2tH9RdvTUai9swKUqU2AhtmJlTeVeoz4PCcJ6pJgLFIXWoFBLQ/CfScMOmHvcLsIyMDI0OAbbCwWBkpJW1nv1Yud0C6SgVFG16Fzjhfrd6LGpjhJwer5ny+pGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zcAMbunW; arc=fail smtp.client-ip=52.101.62.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zcAMbunW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFmDtQWt6jihuv/vEcvXIu6BLD5nyqw7tr0Sl3q1ma1sQTUyw4FmqOilD+M4/qudaV85AGOf0ZFvL+a8AzLjxZQ2H4uM7D4TYWD2JiNoejzeoUMmQX6TB8J84pMBYkSlXjEodA5AshxMiP2Hj5VSieU7AGi7q17cFmH8jUTkft9xF3R6YIu+LlzaO+Jav/Aqfseeg3WEsLSPIJ9lKuG+wlSLGPw1Qkk/6dpXP3y/dTQpno5+e3VWRRotK3/Xo8mn0YL4BhveIAAI2KuBNuInpDM3qcjdnm5mVG+gFD9ai4zcLeAizXI9tp5O1Mhki14cR46u0mN+Ifkjg+XS6iRQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGs5e6E+F4WWAJnWrKJNsTB9azdd4mKeWBuPvV17XCI=;
 b=elWPRa2labyauOp5wktffLD3gvag2LLIcs9bRxgh4hKd22AnHr5rPbk+DcSbQJoNSojZs/2us4OwaLuVgBmmRwx1GejCpN12K36qTJz1QJjmHeP3BGg2TsAZmOgktMAi2fiJ+OPCHSR/jRj3AN4qXMd8+Egae142ro6pknYV9HAW78rsYi1X4JI7ykJp2VF7un6IpHUZpJwoeHrkv3jzBDwzQrwMyPf3ZKyvD4tuIEkwL00ovq4Rw6dJN9xrrgRlbltYAN0LfOw0q7b+6BYhrkMbkc0GcAt6dE2NGs8EkC0Gm8RZycCXVivwXR3mPAJ6TjTYqJf8f42TmR+u5vhtIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGs5e6E+F4WWAJnWrKJNsTB9azdd4mKeWBuPvV17XCI=;
 b=zcAMbunW29IebMvx2kT9Y0K5764DyoQZVOU8xkH6Ndio0ZU8A8iPfaXSjyUYflgLrbVhipTwnF85NK3fgWZWMICiDdk0ncGLi3tAfeEjwFMR0avUf3EIe2j5t2Flcw7/G89tT3pyy7v53qSphnGNRbYOFLUxRzzGGKRfjxjc/co=
Received: from BN9PR03CA0933.namprd03.prod.outlook.com (2603:10b6:408:108::8)
 by IA1PR12MB9521.namprd12.prod.outlook.com (2603:10b6:208:593::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 18:26:34 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:408:108:cafe::db) by BN9PR03CA0933.outlook.office365.com
 (2603:10b6:408:108::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Wed,
 12 Nov 2025 18:26:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:26:34 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:26:28 -0800
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
Subject: [PATCH v5 12/14] iommu/amd: Refactor persistent DTE bits programming into amd_iommu_make_clear_dte()
Date: Wed, 12 Nov 2025 18:25:04 +0000
Message-ID: <20251112182506.7165-13-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|IA1PR12MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: 66524d80-cb06-4356-b383-08de22190271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6GQtg52BkADGYCl+AEpbpRjR47CTZy1v5k2RinTZ9YDcUU5egiRagH508dSx?=
 =?us-ascii?Q?+q7cFwPzmsz1xdnjxs4hcPl9FgOQRmMsEkkCF07sabcU890x+hBtlnayOc5v?=
 =?us-ascii?Q?wRPHdYCAlQUzCnTKfpFAlFb6l5BPZKYO+Y3ln5pmIGXQN+Kyrt7TtlcJoUPa?=
 =?us-ascii?Q?nX8ZEE3pw/z7HM2HK1Sm+6UW+29xRq4OZ1GtKf/V8K21LV8VfnYGL5+v0ERa?=
 =?us-ascii?Q?02eIL03fFDXXfzvI6HOlU09YxjviBTlPVo5oQVwRbNcdxaTQBVOu1rU9OAs4?=
 =?us-ascii?Q?xVRPxx+EBrveMLGpkhy4BuAAwcp2Xrb1EknVXwl4cNSORbzyFtoA+zhwcb2J?=
 =?us-ascii?Q?xHDQrx+XE1Q+hRIJ3EhfezbICy+AICXzglHlXnrUU7L+L5pbkcpDuLqlk+PQ?=
 =?us-ascii?Q?CmoZb50BTY3hQYcnFLmM8qzM3WJsmOm2DnPrYHRlXa5AEyURxZbtbfYAaRng?=
 =?us-ascii?Q?cbn/wofSpMX3fiWN0scOaMDH9GkmggQyRHmNnItQLwZXiSG1s97h1kby7wnN?=
 =?us-ascii?Q?nM5M9Yt9PlZBpbvTp760JBDWgzHmfAxs6bc5OolQ3k29sxrIzF5k0xD+q2UB?=
 =?us-ascii?Q?soVYECxEioKmBV6bSM1Wp2AKFN75q1yZ1KoXRQKo60lidcMSHXQMgJN0h+Zu?=
 =?us-ascii?Q?Lw+zPRwEzAZSonZRDmVcpVLwoT2GHYrjCQp42d7AK7zWs4FHXKgE8B0E99EI?=
 =?us-ascii?Q?74Bvq9xcoF5bves37pmGk+wFuTg+YaYrmQlkFaZWGLYcypxNUZC0/XbfvdPU?=
 =?us-ascii?Q?6ePnZU999a886KmXF7OzYeTCTdzNYAC47PpZw56vKX9D3DJncZS6eS+S2PVx?=
 =?us-ascii?Q?lVAcl8I61eA7n0O9QT0XUKKK7h7oqqCR0bPlnlnuBIxs7mK2pTJYiOwBLtOW?=
 =?us-ascii?Q?WqXG8xnmstMa4HnJ2QDjTm3b1r0fOSTSnSTg9SCUL1UObtS7/SUUY87AIEBJ?=
 =?us-ascii?Q?vHqDkHFWur4qsbOvQKcPnmtNhs32xrCERax2h2ipUMesfpUDxeOdsmTJpjnq?=
 =?us-ascii?Q?4BkzO2faRv4eNvSVLNujaLn2YrPZAsvaFiSbuNa6cB//bDeNjys3JhYWDnox?=
 =?us-ascii?Q?4bIwFqr1FhnmRMrrvb2J0cC3pkX/lcTbMJzN61FoXq1yOJrLntusgqiuFlDQ?=
 =?us-ascii?Q?6MCKvhMAIHpUCttRJfXKUHowOLkC0sw+9IHYqGCWp9k3B9fLodC6oiO8OOho?=
 =?us-ascii?Q?TXwmqiSvE7QCqQY1kI2Boh0zsUQ/tw1zqZil+ky8haM6db4ojPmzWviBeQdT?=
 =?us-ascii?Q?WbrFMBzSP/rzPyJiJlMhoLv7qyW9g8ZUqqauY61X5zoVS+1sfU8p3o5H/V2W?=
 =?us-ascii?Q?ikhy0aXPF7P6qN/gXP1ezsgKwWKnAxUl9grUVQ8jtAyx0e7rnU9U9KiAHdmI?=
 =?us-ascii?Q?boj4vUCG4VKNzeXLdTBirjb8N/8HBShwXdYExMXBpgz6vl2W5zSqhJ9I3YCB?=
 =?us-ascii?Q?9LpV7r/uHdCSwzvRJ+6jaThDjueB1CBweboPwV1V2JDHiLRy5ASQzFYY3V5b?=
 =?us-ascii?Q?i+2y02S5XI4EwZF7nJkC2sTHBGdZ64xr4+Xal53XBxImVdeRfvdDXgp79qMp?=
 =?us-ascii?Q?ZJNmfi7w6exx2q0Wdjg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:26:34.3285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66524d80-cb06-4356-b383-08de22190271
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9521

To help avoid duplicate logic when programing DTE for nested translation.

Note that this commit changes behavior of when the IOMMU driver is
switching domain during attach and the blocking domain, where DTE bit
fields for interrupt pass-through (i.e. Lint0, Lint1, NMI, INIT, ExtInt)
and System management message could be affected. These DTE bits are
specified in the IVRS table for specific devices, and should be persistent.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 13 +++++++++++++
 drivers/iommu/amd/iommu.c     | 11 -----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 57f9f4fb8a4b..ebedb49c28cf 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -194,9 +194,22 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
 static inline void
 amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *new)
 {
+	struct dev_table_entry *initial_dte;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
+
 	/* All existing DTE must have V bit set */
 	new->data128[0] = DTE_FLAG_V;
 	new->data128[1] = 0;
+
+	/*
+	 * Restore cached persistent DTE bits, which can be set by information
+	 * in IVRS table. See set_dev_entry_from_acpi().
+	 */
+	initial_dte = amd_iommu_get_ivhd_dte_flags(iommu->pci_seg->id, dev_data->devid);
+	if (initial_dte) {
+		new->data128[0] |= initial_dte->data128[0];
+		new->data128[1] |= initial_dte->data128[1];
+	}
 }
 
 /* NESTED */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6a26e7a28141..24bab275e8c0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2068,7 +2068,6 @@ static void set_dte_entry(struct amd_iommu *iommu,
 {
 	u16 domid;
 	u32 old_domid;
-	struct dev_table_entry *initial_dte;
 	struct dev_table_entry new = {};
 	struct protection_domain *domain = dev_data->domain;
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
@@ -2126,16 +2125,6 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
 	new.data[1] |= domid;
 
-	/*
-	 * Restore cached persistent DTE bits, which can be set by information
-	 * in IVRS table. See set_dev_entry_from_acpi().
-	 */
-	initial_dte = amd_iommu_get_ivhd_dte_flags(iommu->pci_seg->id, dev_data->devid);
-	if (initial_dte) {
-		new.data128[0] |= initial_dte->data128[0];
-		new.data128[1] |= initial_dte->data128[1];
-	}
-
 	set_dte_gcr3_table(iommu, dev_data, &new);
 
 	amd_iommu_update_dte(iommu, dev_data, &new);
-- 
2.34.1

