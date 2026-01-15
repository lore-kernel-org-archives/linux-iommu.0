Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C11FC8
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 06:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768457394; cv=fail; b=GEBua7+UL6bhd+L3Py5N9aoTcu0HcOyvF4EstvcdALYsRVpI+Xa0fBp7BbSqd0aKXpItxAcJNyg7saUxKx5W4ewLWjyE5kGklfbAjgm1yNhLJ2pSAsrBQZM4a5Q8s8JcmJ85Gu61xEatNCMsmzji6iEvQnlFaWqn+jQbXE4Mv3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768457394; c=relaxed/simple;
	bh=Pp2vORKBaRYaqIi8KlzNL8VSV1Nd4FKsAppoxkjYMIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h2RuBWv6w1tAZf1NAZcnq747v/pgR+Ax8SBaxuF+1+xZRbxfvcD5gt1S8tPrd2ITNRsFGeobw5s6+CjD+7+N/d3qrUcRxvmJDxAc23JBbzQ9FPtGFoeHLe+bWzG6S2AF+/52F/rDU+NB3ziliy9819TbyrVhrEvwHkzQ1Lh5JSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EqPyAtPn; arc=fail smtp.client-ip=40.93.194.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EqPyAtPn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+xDu9fsIGm/qHyl62lfUGNT1IS+YDPkCpPhqN9WdqNhtEFTTI6Fy2tn7RSfamODhydyDAvwjFO2OEO5utonyBjkl/YP6R/tW1GJYeSvsfQyClzKoQO/j10nrQgWoRJDwV1NVmbsMQnmrLdwVgFYuyCoom48BXGq+WkCnVeOZPpVBSSffSk6zpAqio5TXmCRAJw4BcYPY/QTHkA/e1PnejaU540hS8OnuwpwY/5SFDaRBCnFY45/UnhmG5Sm+BC6kd+2O1Fz8TntAbCC1da62Gb3xjZkhD5GpU0/bafRJ/LO9WfiFCAYq42EmIJhMunW2TrWb4zTfX2cvx/vXEXrcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3ZaiU65hxMCXABkFG+PWjGOPKYSS7kt5PiP5jJ+Klo=;
 b=ggEXxCG5Rh8rD2jgmNuRke/7k8QPbxvNzE6ZtIFnLGwqTH1QputheRitwEPZeZGQ/I7WWNc+BU9aNGTx3K0C0WDg7vW00NZOyoIW4dHv6+kP/t+erpzV5c90inYKjLwdnKWu+sVfceHU7CrvZlXwmhOLpL4Nnp9JWIX+gaWOS8IvNiDIAPyi3gluYCTqXWWAic0+s8rusrFXAR+rXdPABT40lZfCJedqPZ6g/wzWd7lWjeY9h5mJBZ81NWUKZMCgvBv6Q9+NGOoGv0MkD1o8OF3xVLV9L+eesKOUMQt2wDb3b6tG7K6TWS1irePI7hqtNGUK43M9/r1st6dsMW5NZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3ZaiU65hxMCXABkFG+PWjGOPKYSS7kt5PiP5jJ+Klo=;
 b=EqPyAtPnxjOCcEqVV9iDCRjeVH8V9v4nLNh+YtRfED8K3GYP8MLjk41BzyP/P5Q8m5345gDHjoFra3abW+wkDZm8ix4a08PakbFMr3bTIQLlcivKJjsFyujMHlpEeUUK0QS2OOtE70JmHelSiFcYqJqVzQTATjI7cqXQYu/cJ+k=
Received: from SA9P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::31)
 by SA5PPF8DEAB7A29.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 06:09:45 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:25:cafe::4e) by SA9P221CA0026.outlook.office365.com
 (2603:10b6:806:25::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Thu,
 15 Jan 2026 06:09:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 06:09:45 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 00:09:39 -0600
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
Subject: [PATCH v6 12/13] iommu/amd: Refactor logic to program the host page table in DTE
Date: Thu, 15 Jan 2026 06:08:13 +0000
Message-ID: <20260115060814.10692-13-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
References: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|SA5PPF8DEAB7A29:EE_
X-MS-Office365-Filtering-Correlation-Id: d6de8a85-f920-4877-d128-08de53fcae2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rTVWEJwxn5oDVDPnXm5ick7thXJxqf2o5YSdilqK42EWYBcIx6N8Bian6dAX?=
 =?us-ascii?Q?uxnodCJ6BWLA1FbAhIkO5RxjypjObZY/9d+dXhp9Qm3DlfuPu/RwBRpfL/Bm?=
 =?us-ascii?Q?GSZX72Ogg1N5oJ3ipDCH+80gC1Xsi1Uu1gkp74g8SRTQ2fDFOYsnGk9htI1k?=
 =?us-ascii?Q?suq+BqvUsSwmhN7ovD1OdMNMynnz2yXfZ6l147TTJrDMykD4ZV2Q4OZ3XvN9?=
 =?us-ascii?Q?8iT+W8A3UxxXAgYwQoDbvLgViYn/t6ZOzGoiwA7TEn4h0pbo0Ujx7ByUGpgg?=
 =?us-ascii?Q?+O10d02skfTDaKymwmQw5vO2WnARcaZOjINX4Suwnamd1lYY/IYin+pU4LhX?=
 =?us-ascii?Q?fX3pn7WDXnneng3TwnODJ5GQWBkf6Pc3GECPgVWytjpOer851p5EIaOxSlyv?=
 =?us-ascii?Q?l5PHl0kxk+oZ9SnJf52EO7oM3Qp5a6X2BUKXy8cLE3V7cOFPwic0MkSAMdX9?=
 =?us-ascii?Q?MLAjqEeha01PomvI9r4vbVItpRtJ4vLbo4qUguWZsV66w0lJooOraX5MNR4S?=
 =?us-ascii?Q?a1tVc5uCDDtRnPw9sY40eiStSnvsq5yN4VfVHViq/m47bRkj3QybCAfGy3uN?=
 =?us-ascii?Q?D/II5I/fV6i0wdi7IomKVQgom+m2LoUWOa+7N7g2uaO8670MC7PbJv5+GDjw?=
 =?us-ascii?Q?LHoz7Oq/kWd5PuLzASOE7VSHLs2PmPPeu2SFPH66DX39T9z5EjySQ5RinN0c?=
 =?us-ascii?Q?hv5naTWuHjW16d0cP+o7v05nihecBdFrkneYDkBXm54UeuiApLKSaPcCUJUS?=
 =?us-ascii?Q?wC1acjp07qCfjxWujyS9iMWxJCyX68O16ULevgir+zgLcckS26N28bdvAGZX?=
 =?us-ascii?Q?7mSO72AaBTwwsiUqhxzLSsTVjRubhiIrtuZzrA0/XUheUYMmJTYReiNts0QQ?=
 =?us-ascii?Q?FdOiMZ5rSZQOJjsWa0U8w/hD5ccatX2s0s4fuK/VemnckrBlBLseIjgV3Yfb?=
 =?us-ascii?Q?LPu5U8kbtza0SWnsdY1Tav+R4+dZRcLXXezOpU0G4gWAt0DCIvwnBj3EgpSW?=
 =?us-ascii?Q?c/5sHFN5Rx4IgJsQkiJaBVPbxVC9Y/kf6QIt2XqXSRwkaKzwQytw1uUdhRBv?=
 =?us-ascii?Q?HgU+/XtDOOzoUG922XAn/ySsGyLlnNWtuHConsIBdSfHcgg3nf/ayOVBDuNC?=
 =?us-ascii?Q?3l/VuxLBCZ8mG0Y+a3KrORoyXvv4oiSu3H3Pa84x1NCcxbKuPIDkGhPdB7jD?=
 =?us-ascii?Q?nmqzWje9dsancZNEScPb06ew6FOnEkQB8ikeerafUG1DT4X8hnU9QadKKhON?=
 =?us-ascii?Q?Z2qD1E6XVwHgYFEgAVdR7OUkF8fCClb2dhF0BmK1CJo09ecJxByk9vn7+ocK?=
 =?us-ascii?Q?kH4IIRTHzmLbsSHFYiGWdFbyu5IoK1J1j9V6iLN+fNQVhyhpufLFUgWvZFsy?=
 =?us-ascii?Q?jpW1k4T2p6Q9sUSme8DV1o8ZMnPr80DmGvX1sbMhCOxVMgP2UoPxMIyjCtIH?=
 =?us-ascii?Q?8rrskhdyVsSPO1qvAlNtitpPRZAXmKvAl606hMeS2bT/uxs3n/8hh1WRQnbp?=
 =?us-ascii?Q?vNR148dko6uxEj2mMxxc0Fcp+d7z6WNkKbEdU52a59OJut4VKs3YWCa9R64w?=
 =?us-ascii?Q?aKQ9+JncbfDLHgD6vCHssloTsqsV21Qn0UYi9aCaLzzjPvfThXh85ASvr7fy?=
 =?us-ascii?Q?HsidMjP6jZTAddSEDN5sgF/5TaC3rIfdA8OObOgbtNewqYeLJMwsHVTMSMez?=
 =?us-ascii?Q?syBAJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 06:09:45.1957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6de8a85-f920-4877-d128-08de53fcae2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8DEAB7A29

Introduce the amd_iommu_set_dte_v1() helper function to configure
IOMMU host (v1) page table into DTE. This will be used later
when attaching nested doamin.

Also, remove obsolete warning when SNP is enabled and domain id
is zero since this check is no longer applicable.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |   4 +
 drivers/iommu/amd/amd_iommu_types.h |   1 +
 drivers/iommu/amd/iommu.c           | 150 ++++++++++++++--------------
 3 files changed, 82 insertions(+), 73 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 00fc9c6073de..02f10922f70b 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -190,6 +190,10 @@ void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
 
+void amd_iommu_set_dte_v1(struct iommu_dev_data *dev_data,
+			  struct protection_domain *domain, u16 domid,
+			  struct pt_iommu_amdv1_hw_info *pt_info,
+			  struct dev_table_entry *new);
 void amd_iommu_update_dte(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data,
 			  struct dev_table_entry *new);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 4a98ac7dca0f..cfcbad6c28ff 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -357,6 +357,7 @@
 #define DTE_FLAG_HAD	(3ULL << 7)
 #define DTE_MODE_MASK	GENMASK_ULL(11, 9)
 #define DTE_HOST_TRP	GENMASK_ULL(51, 12)
+#define DTE_FLAG_PPR	BIT_ULL(52)
 #define DTE_FLAG_GIOV	BIT_ULL(54)
 #define DTE_FLAG_GV	BIT_ULL(55)
 #define DTE_GLX		GENMASK_ULL(57, 56)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index dafd34465fc0..17b0f48f1721 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2068,102 +2068,106 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
  * Note:
  * The old value for GCR3 table and GPT have been cleared from caller.
  */
-static void set_dte_gcr3_table(struct amd_iommu *iommu,
-			       struct iommu_dev_data *dev_data,
-			       struct dev_table_entry *target)
+static void set_dte_gcr3_table(struct iommu_dev_data *dev_data,
+			       struct dev_table_entry *new)
 {
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
-	u64 gcr3;
+	u64 gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
 
-	if (!gcr3_info->gcr3_tbl)
-		return;
-
-	pr_debug("%s: devid=%#x, glx=%#x, gcr3_tbl=%#llx\n",
-		 __func__, dev_data->devid, gcr3_info->glx,
-		 (unsigned long long)gcr3_info->gcr3_tbl);
-
-	gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
+	new->data[0] |= DTE_FLAG_TV |
+			(dev_data->ppr ? DTE_FLAG_PPR : 0) |
+			(pdom_is_v2_pgtbl_mode(dev_data->domain) ?  DTE_FLAG_GIOV : 0) |
+			DTE_FLAG_GV |
+			FIELD_PREP(DTE_GLX, gcr3_info->glx) |
+			FIELD_PREP(DTE_GCR3_14_12, gcr3 >> 12) |
+			DTE_FLAG_IR | DTE_FLAG_IW;
 
-	target->data[0] |= DTE_FLAG_GV |
-			   FIELD_PREP(DTE_GLX, gcr3_info->glx) |
-			   FIELD_PREP(DTE_GCR3_14_12, gcr3 >> 12);
-	if (pdom_is_v2_pgtbl_mode(dev_data->domain))
-		target->data[0] |= DTE_FLAG_GIOV;
-
-	target->data[1] |= FIELD_PREP(DTE_GCR3_30_15, gcr3 >> 15) |
-			   FIELD_PREP(DTE_GCR3_51_31, gcr3 >> 31);
+	new->data[1] |= FIELD_PREP(DTE_DOMID_MASK, dev_data->gcr3_info.domid) |
+			FIELD_PREP(DTE_GCR3_30_15, gcr3 >> 15) |
+			(dev_data->ats_enabled ? DTE_FLAG_IOTLB : 0) |
+			FIELD_PREP(DTE_GCR3_51_31, gcr3 >> 31);
 
 	/* Guest page table can only support 4 and 5 levels  */
 	if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL)
-		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_5_LEVEL);
+		new->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_5_LEVEL);
 	else
-		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_4_LEVEL);
+		new->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_4_LEVEL);
+}
+
+void amd_iommu_set_dte_v1(struct iommu_dev_data *dev_data,
+			  struct protection_domain *domain, u16 domid,
+			  struct pt_iommu_amdv1_hw_info *pt_info,
+			  struct dev_table_entry *new)
+{
+	u64 host_pt_root = __sme_set(pt_info->host_pt_root);
+
+	/* Note Dirty tracking is used for v1 table only for now */
+	new->data[0] |= DTE_FLAG_TV |
+			FIELD_PREP(DTE_MODE_MASK, pt_info->mode) |
+			(domain->dirty_tracking ? DTE_FLAG_HAD : 0) |
+			FIELD_PREP(DTE_HOST_TRP, host_pt_root >> 12) |
+			DTE_FLAG_IR | DTE_FLAG_IW;
+
+	new->data[1] |= FIELD_PREP(DTE_DOMID_MASK, domid) |
+			(dev_data->ats_enabled ? DTE_FLAG_IOTLB : 0);
+}
+
+static void set_dte_v1(struct iommu_dev_data *dev_data,
+		       struct protection_domain *domain, u16 domid,
+		       phys_addr_t top_paddr, unsigned int top_level,
+		       struct dev_table_entry *new)
+{
+	struct pt_iommu_amdv1_hw_info pt_info;
+
+	/*
+	 * When updating the IO pagetable, the new top and level
+	 * are provided as parameters. For other operations i.e.
+	 * device attach, retrieve the current pagetable info
+	 * via the IOMMU PT API.
+	 */
+	if (top_paddr) {
+		pt_info.host_pt_root = top_paddr;
+		pt_info.mode = top_level + 1;
+	} else {
+		WARN_ON(top_paddr || top_level);
+		pt_iommu_amdv1_hw_info(&domain->amdv1, &pt_info);
+	}
+
+	amd_iommu_set_dte_v1(dev_data, domain, domid, &pt_info, new);
+}
+
+static void set_dte_passthrough(struct iommu_dev_data *dev_data,
+				struct protection_domain *domain,
+				struct dev_table_entry *new)
+{
+	new->data[0] |= DTE_FLAG_TV | DTE_FLAG_IR | DTE_FLAG_IW;
+
+	new->data[1] |= FIELD_PREP(DTE_DOMID_MASK, domain->id) |
+			(dev_data->ats_enabled) ? DTE_FLAG_IOTLB : 0;
 }
 
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data,
 			  phys_addr_t top_paddr, unsigned int top_level)
 {
-	u16 domid;
 	u32 old_domid;
 	struct dev_table_entry new = {};
 	struct protection_domain *domain = dev_data->domain;
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
-	struct pt_iommu_amdv1_hw_info pt_info;
 
 	amd_iommu_make_clear_dte(dev_data, &new);
 
-	if (gcr3_info && gcr3_info->gcr3_tbl)
-		domid = dev_data->gcr3_info.domid;
-	else {
-		domid = domain->id;
-
-		if (domain->domain.type & __IOMMU_DOMAIN_PAGING) {
-			/*
-			 * When updating the IO pagetable, the new top and level
-			 * are provided as parameters. For other operations i.e.
-			 * device attach, retrieve the current pagetable info
-			 * via the IOMMU PT API.
-			 */
-			if (top_paddr) {
-				pt_info.host_pt_root = top_paddr;
-				pt_info.mode = top_level + 1;
-			} else {
-				WARN_ON(top_paddr || top_level);
-				pt_iommu_amdv1_hw_info(&domain->amdv1,
-						       &pt_info);
-			}
-
-			new.data[0] |= __sme_set(pt_info.host_pt_root) |
-				       (pt_info.mode & DEV_ENTRY_MODE_MASK)
-					       << DEV_ENTRY_MODE_SHIFT;
-		}
-	}
-
-	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW;
-
-	/*
-	 * When SNP is enabled, we can only support TV=1 with non-zero domain ID.
-	 * This is prevented by the SNP-enable and IOMMU_DOMAIN_IDENTITY check in
-	 * do_iommu_domain_alloc().
-	 */
-	WARN_ON(amd_iommu_snp_en && (domid == 0));
-	new.data[0] |= DTE_FLAG_TV;
-
-	if (dev_data->ppr)
-		new.data[0] |= 1ULL << DEV_ENTRY_PPR;
-
-	if (domain->dirty_tracking)
-		new.data[0] |= DTE_FLAG_HAD;
-
-	if (dev_data->ats_enabled)
-		new.data[1] |= DTE_FLAG_IOTLB;
-
 	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
-	new.data[1] |= domid;
-
-	set_dte_gcr3_table(iommu, dev_data, &new);
+	if (gcr3_info->gcr3_tbl)
+		set_dte_gcr3_table(dev_data, &new);
+	else if (domain->domain.type == IOMMU_DOMAIN_IDENTITY)
+		set_dte_passthrough(dev_data, domain, &new);
+	else if ((domain->domain.type & __IOMMU_DOMAIN_PAGING) &&
+		 domain->pd_mode == PD_MODE_V1)
+		set_dte_v1(dev_data, domain, domain->id, top_paddr, top_level, &new);
+	else
+		WARN_ON(true);
 
 	amd_iommu_update_dte(iommu, dev_data, &new);
 
-- 
2.34.1

