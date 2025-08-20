Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903C92EF643
	for <iommu@lists.linux.dev>; Wed, 20 Aug 2025 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689454; cv=fail; b=qbt9ivZ0Hvr2MRxT/zQvLv779swCVUrubq619NYAcNlGXqc5910CugORvI394myJzimhA+pYP9TJNElLBcw3K1s2ixRE1FlOQv64YP21m7bIdzSellrnQ7T25jIIBf8jFk0y1ZrPMJTA0/Z+NA0PIVys36WIzbwRruXoADZyWFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689454; c=relaxed/simple;
	bh=q5wh5FxCPW584OnPAT2eXy/sddCspMtnJNP5r8m4+WI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGp6xl0t3XuR4Y1D6RKEELGfT1SKgsfmqMQz8Dlf4ImePDivXCvvYNQPiEPUsJSpAwRIKOqQYgbGB4R0FX67sRTjqDtHo0gcWnqNT1HlWlX14n47F11TcrsxMceCHIL6hhTd09ymOAZ2N2ZGr8BZgVJ3p3xFXunr+/wrHdbTuHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Ho1syvB; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Ho1syvB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ti5UJfZjg5Acej5BWZaZkCZ/o+2oe4UDWS0Pur7TF2sxMs3sQ3Re6j5oszmFKJeJpH/nLuNRgmOrKQFCA000B1XT5t2pff5GZUUz/7TTXSpZOrgpDW4yOO7IkpjRFm1ZDBhQgenvLw9UE74Hk+h7qPXv+cRT+v5g+ZEi6IqcSKCn8kpdpJ9ON+0FVYRrByhlUf/NzJcLt/WNI7ZUISVJBAAzWMmeckDkn5h2DW6hpIc3yy/L43MfcR9pPXcgztFQpLxCCHuLIfaVJkVhXyRAwacXqfWcFHon0tZZisRTtJZyoCm38yNrus1AiyGfKzJ4vQoHscqSwCwkjjVPFGASMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fl+6VUXRW1R/Gv+EvG5wjZqPJUGk6rckhIKNDltwjx8=;
 b=mVratSQk5zySC7PBhfwJBZMEcjz1YjsVOU9NTfLgc8aSzpis526dart96q1CgK1IYF/sDpX47herQLTbgJYz4J/yTKVsoxtPt2vtP1usSeFBcZF9aXfQ/+2DMCOnwRABubNWiOQLvEWA7+FrPkKUIoF1MKGMu6vOB82GQR/Fb18f7sdPuTY6i8h/d0OPykDy5wF2zKtdsZ9C+Df4IhC43MsE8rrfZ1Cfsn+gW6C/LQFWSzWCVTK8NkrvDEX2C3WCYYZmE1eOSdut+4PFrvj30+3xxGJqI+d8KDSxkhizNalAWvelhe1BjBq65WY1zxklUtaJMan3ofVEd7SstuyO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fl+6VUXRW1R/Gv+EvG5wjZqPJUGk6rckhIKNDltwjx8=;
 b=5Ho1syvBKY1XY6evKzMfn1FP6/hmIiqxriDbIPfJsr1O7qZrwH1NFlmOaJu+NjvNa7EqHYVk5vYyvQk26ZMacvGXSL1Zm6CWVyjWTlDzWVXnXnELQPvgv32ck/Zmc9DLbAk1Ner/fWpiqW/rniocdmCt+diqUMWJ9LR8PygmXmE=
Received: from BLAPR03CA0080.namprd03.prod.outlook.com (2603:10b6:208:329::25)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 11:30:49 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:329:cafe::32) by BLAPR03CA0080.outlook.office365.com
 (2603:10b6:208:329::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 11:30:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Wed, 20 Aug 2025 11:30:49 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 06:30:44 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 4/8] iommu/amd: Introduce struct gcr3_tbl_info.giov
Date: Wed, 20 Aug 2025 11:30:05 +0000
Message-ID: <20250820113009.5233-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f6c6f34-61e9-4db1-935b-08dddfdd0363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v7f/TFhUbZSbP+Z0rkyQZjVOOUSdCV3VZNAUVXedj3/cJENR0aZHAg86N1ko?=
 =?us-ascii?Q?mJfpVV5ojICIx70cOvnDABNhBiI0lZxmZZ37LX3gm5L9RxR0AuIjuLkytlpY?=
 =?us-ascii?Q?HjvhvOhmO6SxW7rJBqKqGxBqgp8ZvqTaNhccM13NU8LKAr7WTD90Zb45Xf/B?=
 =?us-ascii?Q?slSo8A/4oc95ckp/+inlZg8fLLskNe+vZ90yf7muD6k+sksCD1wuCzCvI1Vm?=
 =?us-ascii?Q?5WjP8BqNtl/UCctwwItrvg2j7Yfcx/x9ddS0mE6ZN0pnJzitb0LR6Auxjhk5?=
 =?us-ascii?Q?CMQtrTzb68RDWaYNoem9sXnC18i+kDCyUEcpoIZYgWsonGeRXDPXVxDBTmbZ?=
 =?us-ascii?Q?4zFJmw6sCqfmyLIcsTy6y05to3HWaFT2rx00ysHt9y0kKJYunt7Admo1OoG3?=
 =?us-ascii?Q?unk8/31P9BXf4rjoLOcN1OD216SEJhXOscdCBpJByyhPcpOBckBW50yYNoa3?=
 =?us-ascii?Q?/z8qONvYORcxny9EEbgD613XtMOjiURHlsXIogPuVbH4SaknNv/rNFCmblf6?=
 =?us-ascii?Q?gLSO+d8Xw+jMf3fsn5yCgR2zO9o4v2uTiNrR3M8xFeQLaYTGEi3r34Y7Bac/?=
 =?us-ascii?Q?ABl00oAfhaW80JCVxsQdY+yI7PMBcUUimrG3/mMVqzIzy/GtQC2E74R9cCea?=
 =?us-ascii?Q?f4fp+ykfJq0Z0jfBc1GARQwnzEr9sh15yiJMN1GGVjjWA2X5/YKbZ0HYte8E?=
 =?us-ascii?Q?tHuM0KcS7RS+ypdSMtCyuOiQUzFRLSOz3jj8wlmtxF53Fa/8j4INAZLoGrWG?=
 =?us-ascii?Q?oFjr6jaDM2CnWQ3qzWEez9dwI0kwnzQisHvbAkoChGAh6cOoXpxy94bvdVHc?=
 =?us-ascii?Q?yD/BWGBjWq47n/xuGYCIbTrXgxYjOiYcUOndRX1RyY3Tzpw7FgYAtXAVNIif?=
 =?us-ascii?Q?iylckh/duvWEg/l63+mufcjCakRDfAG7FBIIgsMQPF0toxUiMs3j6o0UdepU?=
 =?us-ascii?Q?/n2vZtUE42zvXupLlf4NCYla2j2bW5uzqQpMx5teahP8GEblGtj/dh1/bOmR?=
 =?us-ascii?Q?Llku2O8FoegIiv6BS4fWHk2m6J560v34aBYkMJB11gSrpN66p2e+sPKpBF81?=
 =?us-ascii?Q?eHk0nxZttPbGiXYhq22RNGtMVL2YjMigUqMXOIdNJH2vNpdwv8Fud4EolXFQ?=
 =?us-ascii?Q?mzkedqWkAUPgsINhn6wJB0lkntoVccCUkXUxPbA1TfD6SLQYfBcVkH6R9G/a?=
 =?us-ascii?Q?+NmrHGtBxy2T1r6apOz7JVWLYNYTFSVEo+h/BQTdtZap4gXL3vZCKTndM+qk?=
 =?us-ascii?Q?ezjD6Xc5ifd0yjONLROQwRkGOa0ajsJqyKJF/uHLSKFtEkP/Df7v9XnP8W2y?=
 =?us-ascii?Q?40hf7VlIRuBI2MJu7KABRkaJAkNn88VgzXHyEB1Bv+N4UnEqRrt1TB4crU5B?=
 =?us-ascii?Q?SIVsmyAFpC/JSBRtQIeBsRMEBxBzIusNxZlHGjOG7+VoR0AEF1qc5p75PJQR?=
 =?us-ascii?Q?rAphTGV/AIy9YCgv76f7/kfKRrKgeQ5zsWB1JihlKd4F6pyE4zA3AY3krnSo?=
 =?us-ascii?Q?g8PbMrTq2fmge0o=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:30:49.3677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6c6f34-61e9-4db1-935b-08dddfdd0363
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223

To track DTE[GIOV] programming during IOMMU domain attach, also add logic
to determine if the GIOV is required, and set the variable accordinglly.
Then check the variable before programming the DTE.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index efdd0cbda1df..44c44943802c 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -555,6 +555,7 @@ struct gcr3_tbl_info {
 	int	glx;		/* Number of levels for GCR3 table */
 	u32	pasid_cnt;	/* Track attached PASIDs */
 	u16	domid;		/* Per device domain ID */
+	bool	giov;		/* Track DTE[GIOV] */
 };
 
 struct amd_io_pgtable {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 44f9a8990d87..f463774e4b71 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1872,6 +1872,7 @@ static void free_gcr3_table(struct gcr3_tbl_info *gcr3_info)
 
 	iommu_free_pages(gcr3_info->gcr3_tbl);
 	gcr3_info->gcr3_tbl = NULL;
+	gcr3_info->giov = false;
 }
 
 /*
@@ -2027,8 +2028,8 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
 	if (!gcr3_info->gcr3_tbl)
 		return;
 
-	pr_debug("%s: devid=%#x, glx=%#x, gcr3_tbl=%#llx\n",
-		 __func__, dev_data->devid, gcr3_info->glx,
+	pr_debug("%s: devid=%#x, glx=%#x, giov=%#x, gcr3_tbl=%#llx\n",
+		 __func__, dev_data->devid, gcr3_info->glx, gcr3_info->giov,
 		 (unsigned long long)gcr3_info->gcr3_tbl);
 
 	gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
@@ -2036,7 +2037,7 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
 	target->data[0] |= DTE_FLAG_GV |
 			   FIELD_PREP(DTE_GLX, gcr3_info->glx) |
 			   FIELD_PREP(DTE_GCR3_14_12, gcr3 >> 12);
-	if (pdom_is_v2_pgtbl_mode(dev_data->domain))
+	if (gcr3_info->giov)
 		target->data[0] |= DTE_FLAG_GIOV;
 
 	target->data[1] |= FIELD_PREP(DTE_GCR3_30_15, gcr3 >> 15) |
@@ -2178,8 +2179,17 @@ static int init_gcr3_table(struct iommu_dev_data *dev_data,
 		return ret;
 
 	ret = update_gcr3(dev_data, 0, iommu_virt_to_phys(pdom->iop.pgd), true);
-	if (ret)
+	if (!ret) {
+		/*
+		 * GIOV is required for PD_MODE_V2 because we need
+		 * to support the case where the end-point device
+		 * does not have PASID in the TLP prefix when setting
+		 * up to use the v2 table.
+		 */
+		dev_data->gcr3_info.giov = true;
+	} else {
 		free_gcr3_table(&dev_data->gcr3_info);
+	}
 
 	return ret;
 }
-- 
2.34.1

