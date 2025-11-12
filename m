Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012015.outbound.protection.outlook.com [40.93.195.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E63357733
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971967; cv=fail; b=qg3lebRZo6MtM932d2QnG2VOUoERVv+XM/FkJRcMS/DGWdD3GLO60CCLNkHoGTmM0R/0xjUEOozC0uJS2nOEXe9aHE15xW3lkawUefE5XVq/S6jM90XqTAQwVHELQAEh/aivaVk8f4Lz5QzYteUxrfPVpgNq4BKUsA3N77lh/RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971967; c=relaxed/simple;
	bh=29zwzi3qeYlJD0rxDE0X8rnIQy0WUrMkqt2gLLf8VR4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHoyLouejpxPGDZhmRE2f2+wsBC+DWQ7857L2kjuy06KvweAwdmokPow9Ii2cGpMx8ILZaS9f/qSEzlrpkm+OKVMTgKATmlj0ZLUf9n3qWWLUyern4GPYZzCVndGv5glgld673/SGKWfoSSCJrt+5nj/607Q68VeV4YkmuWoPdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fAofcBbc; arc=fail smtp.client-ip=40.93.195.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fAofcBbc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxsYqRt5mmqL+rdm/BfMJgR2etWegcnb8ksW6r0dj78s4J2AO7SFe9jc2Ru226/kFTXDH20Wf8STi2/ahHmzqcnQC+vCEJOzc3TM8awicSX5KZbK1xMYjNjFxMNmzexoyD1Aq9qpqNSRxgCh+np5zHvSlMfRcl57NVNT67gW6yH8ymHwYBg9DjioNF3GojxsBvEoFGuS2YghxB8TT2mnl0wup22yzmPh72F/ZTnw9/Yxy6KFCGNQPmyB6zCLsuZC0YmmGS5xT1PDGiBWrrTiHWPNAyQP5qwEow2Fuw7uf3ZHuWuxColsy2UH6SKww+dbil0FnaFBVtS7DjlN6Jlnlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIPTP+CKtXjFk9i6vC3qH4yW42R5m1r5+JH4vpiVJRU=;
 b=AzUvFC+HwIN9mW4X9+TLV++7XNFsxM5lRztACjBNUSTfumimo6G2gYRqlCpXyMje9RmfQDd8mibBGOBJB2Joi53YUtiFaHLmA7cYAGRXpZpsvTDfQRcXjvqnCBVXhoNUsEWdcW8x2E3DJC5dlhCSwYBPcn7d1FhmppGTgcnmQWe3wuYts94QO9igeRVvFVhmbbrGoe9ljZbpZjOjUJs3uZGPBUd1CZywMk9hMrwKed6WM3kOXSdh8fzHML/f5Tp7b8OpUjNxvUigx+gdrF8TVX0PQQ0Cg4Kq9lHc7Y0SvneeHkM8sUzSICLR6opoAK8GHsJo7bjlqrhpPlPunYjpAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIPTP+CKtXjFk9i6vC3qH4yW42R5m1r5+JH4vpiVJRU=;
 b=fAofcBbcN/6hdzBmoMwf329WrUY7W6u2EU/vuLYITBUfpw6AXUvmbudrB3zFsPDsCFNXKHoxogqb8s4HA/HZ0Z1reGWbCsaQP4N1W2x4HiMb6uRMOC8xwPoWnsWHSEYgNrzk/XO2hV0rST1lxM6J7p5ReH8FZ+5Un0IKy5ock64=
Received: from IA4P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::11)
 by DS5PPFB8FBD73EA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 18:25:56 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:558:cafe::10) by IA4P220CA0011.outlook.office365.com
 (2603:10b6:208:558::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 12 Nov 2025 18:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:25:55 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:25:50 -0800
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
Subject: [PATCH v5 05/14] iommu/amd: Introduce helper function amd_iommu_update_dte()
Date: Wed, 12 Nov 2025 18:24:57 +0000
Message-ID: <20251112182506.7165-6-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|DS5PPFB8FBD73EA:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d326bc-80e5-41fe-8fb9-08de2218eb58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gvKNknIRKrk2A+2dhLuQfqtGXX7zLX0MaXiVYweRIR9MWkUdubqhQ/MXvCHT?=
 =?us-ascii?Q?eRYkCyx0TObrETlA5OT3tt1MhjPtnhWZ33UR3UmL9V0pYvlAiKflc1CFDEdJ?=
 =?us-ascii?Q?keGQbaW20Q3vY9pRkpCI2BfcfNZ8HJXvDHAaPwM8d+X2ui97NuyVklCjcMBl?=
 =?us-ascii?Q?vQlQwBTIAKI/t+ki+6qPLYz6r9EP3gdZmgfrGJbIKQ4JzWNzf0YrnG31+c23?=
 =?us-ascii?Q?vh1c8z+zAq93ss1tFe9XRAdchab/ZGV2AMLjvQxKqlz0Yk4Z/KspEDIrJGjg?=
 =?us-ascii?Q?QyvMshEdH95y5IY6DBZyfvjfLqXdy6PwO+Xll3XQ4Or4PebkCF/uBEIG42rg?=
 =?us-ascii?Q?VegyEgk1SW18ervPN0gAp0i0p0YXXnV8h79DS4bAfBRh6ExwN47yWgOd6SaK?=
 =?us-ascii?Q?ir4IkQxSPTOueSiHamsBDCj+xuHFLVtljW3Dxc8K3TXtFARQo0Jjhp8Truxy?=
 =?us-ascii?Q?oE0ClCBr3Eo8xDBGHE1aGVFCvlhp6XPKkAyBnEuy8MNzhXzb416Kz+hSFL7g?=
 =?us-ascii?Q?lJK8z9OhC7UkthOSKdO/fY3XoxHUCVWkWzH4+imDEk2KeMWV/Ob7C68oJC1m?=
 =?us-ascii?Q?El1awXgcFNIvSe0weE99Ba7flhg/xB+ys9ZJUsmOTBrjTHRIuFMVCSH8/faj?=
 =?us-ascii?Q?Dtts7x8kpA67A2oxYVYlLp9BxI98+58Adzy18Boammew9i5AhbXMVRKKS9wr?=
 =?us-ascii?Q?NqPD3cPoREOE8xOCrzUyPIbfxgOzX1f+0ANKAcaI24PHDgZWBIrW5lC9QuqA?=
 =?us-ascii?Q?0DS4Mj8iPBZe7rEepfiO4L9gvO3MuPyi1kicCLVyqb2keFHa8s0KV9/LUpn8?=
 =?us-ascii?Q?Gd+uvphlHYih13Clbm0cB2s2DZW42JyUPyDGdDKT3CQSJWooAU0S7Q8kD3W+?=
 =?us-ascii?Q?bFmzAU5b8Qayvnb41TECCij2zr7KzsRyF+yi+akTwEL5Av5A3o6w6BeII33Y?=
 =?us-ascii?Q?wJsS///Yeit0ATvPGMVopK+jjjZJpJMY4KVAfvVKuqkc13RxfjJH5d3jPAyz?=
 =?us-ascii?Q?cFonz8AMXF6FCM87jhcBmS98jx/IWwqtyd4iBpjy5PBbBisTTi+fnqjQt4br?=
 =?us-ascii?Q?dR7BywHT05bWH9Euf/lenL+fDQeoWL45AIG2/nGVkyxd+J5HDfmuS7Rvlyix?=
 =?us-ascii?Q?UWTqMw2FtQsKNIkNllJxaOnBO9Z4hWpvhos3XaO+aDeEPef2miO8voaldiyp?=
 =?us-ascii?Q?Fk7XNTpv/vQxg+0+8GiiGMWIEKsTOo9x2YPb1G9KK2BMWPdcJ+54cdJ+/DI7?=
 =?us-ascii?Q?6TsJv+TB+B7f3GahaG0ry3VCM4w0SlRaWN8k43hb4+LXxuAb4EY648L3FYVp?=
 =?us-ascii?Q?vzSATFNk5adA3o04EBFGua7ecVcEdbK+TvH9TqdDXaZLoBFkiHboXkeoeLXQ?=
 =?us-ascii?Q?ucSugIlZqb2e6+62LdGTGOkHZPmhHrEGkm+hG/nC8t1uo/5p/yVdEOtHeKBv?=
 =?us-ascii?Q?m+Bea70KR2rJAo7Cg2MGdJVTFEJwzhvMlRvFSP2Xg5f7bqB18sdRsT7+KhNp?=
 =?us-ascii?Q?n8FH1jI4bmHJkHc4dxP4bb80/NDEuy5N7U6DmKrzJ6HWADZ+t1HsfBafsLxT?=
 =?us-ascii?Q?vJ12UJqfXC7Lt7i7XIg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:25:55.5769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d326bc-80e5-41fe-8fb9-08de2218eb58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFB8FBD73EA

Which includes DTE update, clone_aliases, DTE flush and completion-wait
commands to avoid code duplication when reuse to setup DTE for nested
translation.

Also, make amd_iommu_update_dte() non-static to reuse in
in a new nested.c file for nested translation.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  4 ++++
 drivers/iommu/amd/iommu.c     | 24 ++++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index a6ffb1ece2f9..3ad8b5e65a82 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -187,6 +187,10 @@ void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
 
+void amd_iommu_update_dte(struct amd_iommu *iommu,
+			  struct iommu_dev_data *dev_data,
+			  struct dev_table_entry *new);
+
 static inline void
 amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *new)
 {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0be2c818504c..a36426f096d2 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -76,6 +76,8 @@ static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data,
 			  phys_addr_t top_paddr, unsigned int top_level);
 
+static int device_flush_dte(struct iommu_dev_data *dev_data);
+
 static void amd_iommu_change_top(struct pt_iommu *iommu_table,
 				 phys_addr_t top_paddr, unsigned int top_level);
 
@@ -86,6 +88,10 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain);
 static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 					bool enable);
 
+static void clone_aliases(struct amd_iommu *iommu, struct device *dev);
+
+static int iommu_completion_wait(struct amd_iommu *iommu);
+
 /****************************************************************************
  *
  * Helper functions
@@ -203,6 +209,16 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 	spin_unlock_irqrestore(&dev_data->dte_lock, flags);
 }
 
+void amd_iommu_update_dte(struct amd_iommu *iommu,
+			     struct iommu_dev_data *dev_data,
+			     struct dev_table_entry *new)
+{
+	update_dte256(iommu, dev_data, new);
+	clone_aliases(iommu, dev_data->dev);
+	device_flush_dte(dev_data);
+	iommu_completion_wait(iommu);
+}
+
 static void get_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
 		      struct dev_table_entry *dte)
 {
@@ -2088,7 +2104,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 
 	set_dte_gcr3_table(iommu, dev_data, &new);
 
-	update_dte256(iommu, dev_data, &new);
+	amd_iommu_update_dte(iommu, dev_data, &new);
 
 	/*
 	 * A kdump kernel might be replacing a domain ID that was copied from
@@ -2108,7 +2124,7 @@ static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_
 	struct dev_table_entry new = {};
 
 	amd_iommu_make_clear_dte(dev_data, &new);
-	update_dte256(iommu, dev_data, &new);
+	amd_iommu_update_dte(iommu, dev_data, &new);
 }
 
 /* Update and flush DTE for the given device */
@@ -2120,10 +2136,6 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 		set_dte_entry(iommu, dev_data, 0, 0);
 	else
 		clear_dte_entry(iommu, dev_data);
-
-	clone_aliases(iommu, dev_data->dev);
-	device_flush_dte(dev_data);
-	iommu_completion_wait(iommu);
 }
 
 /*
-- 
2.34.1

