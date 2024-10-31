Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D96195FD5
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366231; cv=fail; b=qARqS0kCNHYskKezbzc3Q/e181bCUYYmEHJTwYQu76Je+x+NFpcgwsCzxcfZxoUZfiTYvVeiMMsJg48cgYlvTUyXTRWXI5jCbb/+/boHX/OgHz1bXfYGt53zMgQ0Fj6IpzTczyjlLFbjDqB2YQL0IV2SrBnXBNkV/m7XAXI6Gkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366231; c=relaxed/simple;
	bh=8bUYpGhVK3ADENp1WbiluwNBS6WbZBd7LvgPT2OmEwI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Re2sPdYsB80dvDgpvqA8gkFkr1aP0ebmog8ax15v8UynnUdDkc1uawejdEoKO6djsAd5h0avwKb3jzg9HveaVxGnjvTyxDCeniV900afwnSKR4dDEcXhP+CJzYzO2h0hAU4zzRkbsY7pDIWJc0bNOaBIELww3IxEWkcvCfaWyZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IZjOKWtW; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IZjOKWtW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhvnGH2slu0XYVnoyd8xMVMeJ4IIF7qgbeeT+9lG2RckcVMPPtaBG3cvzQQELrUD6fNW0RnGjjeLTdKHvBdQBW0B6VdOVSpCpl/GZI7QGWGA0xwhZ6ne4Ydz1rzblmaNfHzwdt964Fav2Ec7MBqHeezh6E+Uy4v9ngrlXznASXenvilNSlBE6QZmYBvbemu3s4kyV/HJ1nEpJPos+pkXSWWJDvot3SgZiNhq3Ma7wwKSg/aSWs8UvGlmqA39cQaqrLP4ZxOp35si3985LPtvIapRFQoT7hXvWozIdfyV5V6be3vyJPR0jpdktW9GhNg6ygOuCB7yOW8K73/CuJyGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpmRnvibWLf5J48sQrEZXnFrmjwNuoaXHA+Nq+jv1Rg=;
 b=Vq037ny+kVINyrKUPCWIo2AMYGkruPHFx8Y1Ccys9U/fUc+yJd4lZA3KAir+v+HF5JUQUCHC/c/HDZeIRuk5C9xtcTlvogQUvMPJvaol+dA4EYMRUYkCRjl0gQtD8VDLESy/iaL3DGdQezrWSiOFOD0LlCrdic43HOXktExfk7M+auHX49cQ4qu+2d95DBI5c90VMJoW8NyN2DofbeoIrUQB5txR7H0Xffarop9VMpsORnxnV1O4OCRWO3raf/avFR+PScWKeSzDLRPALXy9JZL3BwclfHwvd2WVkY/vq/pWuRqHs4RI7JOdb3aah0VE758mEUuLayYewiKqwfAEPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpmRnvibWLf5J48sQrEZXnFrmjwNuoaXHA+Nq+jv1Rg=;
 b=IZjOKWtW8RAo/EFzCmobaAnz2rpMtf+P3/yjfvrVTQItFQuXVDER1ToBqpJxDD5kND4FK72moMsiW8BSSRcLI4jK6QrdqEhwvcnM/1qsB7o3mxNgOBqDIQpll28wLD+klwimLHkkh8PwLia1wwhvc+3yS5cBQwhicsB/CRXAzK0=
Received: from BY3PR05CA0019.namprd05.prod.outlook.com (2603:10b6:a03:254::24)
 by PH7PR12MB8794.namprd12.prod.outlook.com (2603:10b6:510:27d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 09:17:02 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::42) by BY3PR05CA0019.outlook.office365.com
 (2603:10b6:a03:254::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Thu, 31 Oct 2024 09:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 09:17:01 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 04:16:56 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v7 05/10] iommu/amd: Introduce helper function to update 256-bit DTE
Date: Thu, 31 Oct 2024 09:16:19 +0000
Message-ID: <20241031091624.4895-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
References: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|PH7PR12MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ab4266-e705-473b-93aa-08dcf98cc796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wIQnex7kyQJIKfFhX2hEBkQTxWLk1HuxmIuMogPSGtoTfw2SH1ZMjNJcvrkr?=
 =?us-ascii?Q?ZKOynZaI4JcdAkZXPx2AN+xuyXBjTmAwUh8EZ3zRQGe6y6AOq1Ifg1cCiLgV?=
 =?us-ascii?Q?GE7o/P+jD9oZ3FkhCJhos4+yxOZGAb0dVo2i0xIChCgaPOSwEdCVYsF0pya0?=
 =?us-ascii?Q?Ol19Uir9EwiTVdDiraagAWlpOV/FWXmY4upVcSx2o9xkqGkOYA/gXSS5XHRP?=
 =?us-ascii?Q?5ASRh59xsR5aUAPVzU24QujMhmomdZY47+spy1d/h6qnmkoBRvGAJIjGxmPd?=
 =?us-ascii?Q?sD1/PsTZw0+oFhYnx9cdgPHu3EzRyXLxIRqBrRqkZNaNVCLOcJZ6XLomTlkA?=
 =?us-ascii?Q?qKGb/YCp0Qb0WrhG01Ai5zn7ZhHr6I1J5BEAqtWgfsuGJSJ+tdeine8d2MWJ?=
 =?us-ascii?Q?/saRwh02Tf7+/hgsdS8CoTeybJ54pSRdLkEWc49ci/MHAEhOLN62ka0BSF7s?=
 =?us-ascii?Q?WttDYXpnsM42bw9Etsx8F8cggu8uSgDjiTPSw/uaqIhwp/h94uongTRerT8k?=
 =?us-ascii?Q?UdOuwyxXx13AfBOV1Zxxf9zNhyfKrDF5Glwzg8gq6sj/wTV4tFjINSv6iG04?=
 =?us-ascii?Q?v/8ViR66f6daj71JHzIO74XgZfHETSBTF3o+2dYvAjBnSIrnffr9GmA61uEz?=
 =?us-ascii?Q?rX/9+S+ZTScuP0RvAEhnemYh63dbda3kvBYR2N+sJyuvTafCSvjWCHx2fefk?=
 =?us-ascii?Q?PEKOuE3/YO/IB9vfOJSiWeAD0KTjB3MVCRDjkNM9Sliod/G7vHBz64tjHQWQ?=
 =?us-ascii?Q?oTbKrrEjmxuEmQRcN6D9goddY9ZbFquDolJTMatnVUwce9mJ1bBiqsX6YNj4?=
 =?us-ascii?Q?wVx6rd3wRS8W+R/WvJDY+zA4h88vF67c0qhvA+GMGghc2HVvspBrgEdGm9VB?=
 =?us-ascii?Q?B53X/2Y8V8nyaxl/krZ54ia2FCF6WqtL4iXUQ8zjUZSagi/z9zThyEsScfiq?=
 =?us-ascii?Q?SmghqEDjjUJYAjn3WbzH8MCQHfdk6vJNYMhJkVW0dD74wWHZNmeHUb4z2oNz?=
 =?us-ascii?Q?7OY9aO6fpdVi97fOAvUo+TCqU5WrdkMW+QmxJs7jsPs6kr5jBkRnoIhysmoH?=
 =?us-ascii?Q?9gzY0faguHn6fhxB/qa9rghgiyIEaDv4RexJ1g8PIdyYqZUm24daAlUDjt1D?=
 =?us-ascii?Q?iF+5tfT5j4PyO3Xj6CMdi6ayUmA+PxNj1/HmUZbFB8jT/NhHq0BM4uXN/8ZB?=
 =?us-ascii?Q?KB6CZIKNQos8Toxydcvu9GkqLDrFM6p/6EjM6cUJfg+DdQZH3ejjv7wYYmaI?=
 =?us-ascii?Q?a0h4qOyEb4R1eQIscwUjZLUA/+sxIw08VcRb6PjzAEA0+3zzAydfZHMYSQ/t?=
 =?us-ascii?Q?xhlJUF2RwBdQlRxfpabqL59FQBwkGuFRAPI2FT8xtEvufEMChkcrnBEda21Y?=
 =?us-ascii?Q?SV6bqcuVID4VwomdcRouEVqk/FcVkpIatvubJt7ts9Rpog/87g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 09:17:01.7320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ab4266-e705-473b-93aa-08dcf98cc796
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8794

The current implementation does not follow 128-bit write requirement
to update DTE as specified in the AMD I/O Virtualization Techonology
(IOMMU) Specification.

Therefore, modify the struct dev_table_entry to contain union of u128 data
array, and introduce a helper functions update_dte256() to update DTE using
two 128-bit cmpxchg operations to update 256-bit DTE with the modified
structure, and take into account the DTE[V, GV] bits when programming
the DTE to ensure proper order of DTE programming and flushing.

In addition, introduce a per-DTE spin_lock struct dev_data.dte_lock to
provide synchronization when updating the DTE to prevent cmpxchg128
failure.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  10 ++-
 drivers/iommu/amd/iommu.c           | 116 ++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 7e055a226794..e11a77c0f592 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -427,9 +427,13 @@
 #define DTE_GCR3_SHIFT_C	43
 
 #define DTE_GPT_LEVEL_SHIFT	54
+#define DTE_GPT_LEVEL_MASK	GENMASK_ULL(55, 54)
 
 #define GCR3_VALID		0x01ULL
 
+/* DTE[128:179] | DTE[184:191] */
+#define DTE_DATA2_INTR_MASK	~GENMASK_ULL(55, 52)
+
 #define IOMMU_PAGE_MASK (((1ULL << 52) - 1) & ~0xfffULL)
 #define IOMMU_PTE_PRESENT(pte) ((pte) & IOMMU_PTE_PR)
 #define IOMMU_PTE_DIRTY(pte) ((pte) & IOMMU_PTE_HD)
@@ -837,6 +841,7 @@ struct devid_map {
 struct iommu_dev_data {
 	/*Protect against attach/detach races */
 	spinlock_t lock;
+	spinlock_t dte_lock;              /* DTE lock for 256-bit access */
 
 	struct list_head list;		  /* For domain->dev_list */
 	struct llist_node dev_data_list;  /* For global dev_data_list */
@@ -887,7 +892,10 @@ extern struct amd_iommu *amd_iommus[MAX_IOMMUS];
  * Structure defining one entry in the device table
  */
 struct dev_table_entry {
-	u64 data[4];
+	union {
+		u64 data[4];
+		u128 data128[2];
+	};
 };
 
 /*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8364cd6fa47d..eb22ed1a219c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -77,12 +77,118 @@ static void detach_device(struct device *dev);
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data);
 
+static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid);
+
 /****************************************************************************
  *
  * Helper functions
  *
  ****************************************************************************/
 
+static void write_dte_upper128(struct dev_table_entry *ptr, struct dev_table_entry *new)
+{
+	struct dev_table_entry old = {};
+
+	old.data128[1] = READ_ONCE(ptr->data128[1]);
+	do {
+		/*
+		 * Preserve DTE_DATA2_INTR_MASK. This needs to be
+		 * done here since it requires to be inside
+		 * spin_lock(&dev_data->dte_lock) context.
+		 */
+		new->data[2] &= ~DTE_DATA2_INTR_MASK;
+		new->data[2] |= old.data[2] & DTE_DATA2_INTR_MASK;
+
+	/* Note: try_cmpxchg inherently update &old.data128[1] on failure */
+	} while (!try_cmpxchg128(&ptr->data128[1], &old.data128[1], new->data128[1]));
+}
+
+static void write_dte_lower128(struct dev_table_entry *ptr, struct dev_table_entry *new)
+{
+	struct dev_table_entry old = {};
+
+	old.data128[0] = READ_ONCE(ptr->data128[0]);
+	do {
+	/* Note: try_cmpxchg inherently update &old.data128[0] on failure */
+	} while (!try_cmpxchg128(&ptr->data128[0], &old.data128[0], new->data128[0]));
+}
+
+/*
+ * Note:
+ * IOMMU reads the entire Device Table entry in a single 256-bit transaction
+ * but the driver is programming DTE using 2 128-bit cmpxchg. So, the driver
+ * need to ensure the following:
+ *   - DTE[V|GV] bit is being written last when setting.
+ *   - DTE[V|GV] bit is being written first when clearing.
+ *
+ * This function is used only by code, which updates DMA translation part of the DTE.
+ * So, only consider control bits related to DMA when updating the entry.
+ */
+static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
+			  struct dev_table_entry *new)
+{
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	struct dev_table_entry *ptr = &dev_table[dev_data->devid];
+
+	spin_lock(&dev_data->dte_lock);
+
+	if (!(ptr->data[0] & DTE_FLAG_V)) {
+		/* Existing DTE is not valid. */
+		write_dte_upper128(ptr, new);
+		write_dte_lower128(ptr, new);
+		iommu_flush_dte_sync(iommu, dev_data->devid);
+	} else if (!(new->data[0] & DTE_FLAG_V)) {
+		/* Existing DTE is valid. New DTE is not valid.  */
+		write_dte_lower128(ptr, new);
+		write_dte_upper128(ptr, new);
+		iommu_flush_dte_sync(iommu, dev_data->devid);
+	} else if (!FIELD_GET(DTE_FLAG_GV, ptr->data[0])) {
+		/*
+		 * Both DTEs are valid.
+		 * Existing DTE has no guest page table.
+		 */
+		write_dte_upper128(ptr, new);
+		write_dte_lower128(ptr, new);
+		iommu_flush_dte_sync(iommu, dev_data->devid);
+	} else if (!FIELD_GET(DTE_FLAG_GV, new->data[0])) {
+		/*
+		 * Both DTEs are valid.
+		 * Existing DTE has guest page table,
+		 * new DTE has no guest page table,
+		 */
+		write_dte_lower128(ptr, new);
+		write_dte_upper128(ptr, new);
+		iommu_flush_dte_sync(iommu, dev_data->devid);
+	} else if (FIELD_GET(DTE_GPT_LEVEL_MASK, ptr->data[2]) !=
+		   FIELD_GET(DTE_GPT_LEVEL_MASK, new->data[2])) {
+		/*
+		 * Both DTEs are valid and have guest page table,
+		 * but have different number of levels. So, we need
+		 * to upadte both upper and lower 128-bit value, which
+		 * require disabling and flushing.
+		 */
+		struct dev_table_entry clear = {};
+
+		/* First disable DTE */
+		write_dte_lower128(ptr, &clear);
+		iommu_flush_dte_sync(iommu, dev_data->devid);
+
+		/* Then update DTE */
+		write_dte_upper128(ptr, new);
+		write_dte_lower128(ptr, new);
+		iommu_flush_dte_sync(iommu, dev_data->devid);
+	} else {
+		/*
+		 * Both DTEs are valid and have guest page table,
+		 * and same number of levels. We just need to only
+		 * update the lower 128-bit. So no need to disable DTE.
+		 */
+		write_dte_lower128(ptr, new);
+	}
+
+	spin_unlock(&dev_data->dte_lock);
+}
+
 static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
 {
 	return (pdom && (pdom->pd_mode == PD_MODE_V2));
@@ -203,6 +309,7 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 		return NULL;
 
 	spin_lock_init(&dev_data->lock);
+	spin_lock_init(&dev_data->dte_lock);
 	dev_data->devid = devid;
 	ratelimit_default_init(&dev_data->rs);
 
@@ -1272,6 +1379,15 @@ static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
 	return iommu_queue_command(iommu, &cmd);
 }
 
+static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid)
+{
+	int ret;
+
+	ret = iommu_flush_dte(iommu, devid);
+	if (!ret)
+		iommu_completion_wait(iommu);
+}
+
 static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
 {
 	u32 devid;
-- 
2.34.1

