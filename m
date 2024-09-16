Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F3C15B561
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507140; cv=fail; b=Lg5Pyqc6P/UYRByncPJbxSUaXFlU81tk2OGFiR6fAESmgawRdxNMqIgtCEa9qDVzBLQ/0LvoU7LgNv3xYw864K6MHyf64msyTK/3cnQz9Yv76lEWPwuqtTyq8YgaB0zAaKb6OOToOr83s7jZtNqgNWTMgPShDGl+iHEzJYy1JNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507140; c=relaxed/simple;
	bh=jCym6XIl70oeG3zG2jzJ0kFb8+77CpGDycvBLtxJBG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijhLyne5iQYA5XHvrO1cmayo7gsYDYizZYBFaEF6ZLskquS9JTSAgHaHinwr9GN7/NuGKEfVYAJXWzAKemjQKTPBcPtfdovTSWfYfacpAodg8KQ8N1B35rMkzJ0TKtOzELPA3075W6v8rlQJK0CNaxJwFa6nktox2PM0zlnr+70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sQRKsr8+; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sQRKsr8+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyh1jttJGFYDy1uzL2zDIzDEJWaCVa5ZA2UJzdmf9sorfiWUEvycpAXFJZkNuGoCVN4RyWyIq8odna5U7ThFE0AnecjxrkBPnVtPMY9ueLuWzzkVUcWapbJVdEcO9rTwgo8052MGbZqCxR2qALLdZnymHKMQ8y7RUaHkJdI4+Vi5YCAh6v088IgfdnH2hedrOMdnhLAPEY9akU46nKur8QBfNTtGwuzABmnTwLyY935qgf+EBE7OFanwjc2/t/OcGoHATgPMdqV1NdqSQF04eI1C7jYRyPSYtKT32QOqSHL/jbMS1FWrLUnKlXk5OShq9uuYBJ61OrC4tO2QJxfVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jkk5/mSCoS8oC5kLklT101UQZIx71yL2BaNoEUV4cbQ=;
 b=X95fgBCHvahHz9dFGboq2qJBKNqcBnbgM8DJJbx2ylcw9HJvPp9Y4qyGKxyE8okXndHMf7UE/IhLam58xYeC4RXi9ZoORSEk4jqDBBbMjHA3++2B97hDZv7cXYk5/sV+4qRNFVI5tVchDa32nI1gwWyQfWxO+SvgaH2raflVdjgWXjllfX6T+uj4jWMlGY1V0bGPYsvwPXIVjUuyCfaIpskgmeJk3e4ctdVsHJPbQ8kxhfdTBWcWvNm8DEI7cAZX1i9z3eKOQ0QG5nQ0ne7y0kAyDOzJHxQHltEfU37q5Lxvl9EXvIcKvKmlrt9c7aR+141ngqBBZ4NXAota3C65PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jkk5/mSCoS8oC5kLklT101UQZIx71yL2BaNoEUV4cbQ=;
 b=sQRKsr8+o2/7MMiAjHuywggbX9J0vyqZZQikHEMYjKdQtSktHAhhCsf6YmRd6Rh03G8XVi5hL8TLSVYjMEy3hZAYHhn8TXRjrVnAD9f7bA4QfUMME2oQoGAUkmIt+4ILc8AY0SU+WwKEWUstcI62sOzOLkBPCZfZTvdyoPREedU=
Received: from CH5PR05CA0022.namprd05.prod.outlook.com (2603:10b6:610:1f0::14)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 17:18:50 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::aa) by CH5PR05CA0022.outlook.office365.com
 (2603:10b6:610:1f0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.15 via Frontend
 Transport; Mon, 16 Sep 2024 17:18:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 17:18:50 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 12:18:36 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 2/6] iommu/amd: Introduce helper function to update 256-bit DTE
Date: Mon, 16 Sep 2024 17:18:01 +0000
Message-ID: <20240916171805.324292-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
References: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|SJ2PR12MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 078c0cab-7ef3-471c-a6b3-08dcd673a1b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x4U2IWH5+MxhDFeeVi70k5i2r8GqxchbNTCH5dC9Tx+b5a72y208/bhtJIOT?=
 =?us-ascii?Q?0sPm6uKVh8aIhAV405G+bsrh1hQk5EfT1kNDS+UIoAkRp8ZpJVZiCcyRqcBQ?=
 =?us-ascii?Q?9YsQ1MeyBkwyi2uxUkKGzEoHw8WIbAbrzfp6sA4bEWC2FC6WKuorXVxhAqu2?=
 =?us-ascii?Q?tfSRipf37vCaLwZLl3p8sDYs9VbToMwke/G3honBNq8IqvvXrv43FwOm6hdd?=
 =?us-ascii?Q?1wyw8jlIb+sCsS3RYeP4OJNTmSuErTxRJrpwPZXjdfbKYN8b/AOGUBer0xmd?=
 =?us-ascii?Q?OrhPt8ctFpJ0joQO0lAN789rWpe604BESt8Tsdu69UxPw5FuWnJE5l2Op8NT?=
 =?us-ascii?Q?AatLKIK6/XRirQ8QkmWYTL7C+tmli0ZloJZr+iHKos+TRQAW+jrSjUhi3sDg?=
 =?us-ascii?Q?RkUt7nCwtYKQhW26XPc/U4gLLgSjR1zK1aS++O1oCiDkfhLfMVOcC2Xb06Wk?=
 =?us-ascii?Q?hcG98LmogCC+Q518KtIs1oAzML067n8WNvUOuhZROvJpf18Cg9WDiMRoG5dv?=
 =?us-ascii?Q?XmJbCgUtxAapsK3LXgEjGu9PcUOdg4cifdlAin2UkfXRDePFc0IhmbE+LlGf?=
 =?us-ascii?Q?/Krba32U5vt7uw0W4mbv6q63xRwHAGIsqumt/ZHne5TwjMqpPJ8Bin8HJ6Yw?=
 =?us-ascii?Q?Hphsj6ae0U/lKyp4r6oVlPs8p+HRuoIMAUM5kGvhdvGOV6HBC13ntoExFe67?=
 =?us-ascii?Q?T66HdwSPfrwI7xrEq1ukP8YJu8T5nxUw8zfVPSKV2FqGTZsPzlhwPxr0tJ3J?=
 =?us-ascii?Q?sRbK3/idCuGyTf/orAvEvzNDEA5JRNfig4UQhJNvzqq6YSv21t1/wqBkeGh3?=
 =?us-ascii?Q?08WxCw/AL12l0Bv4pZ2w10T/odYs5zGw3pM8za5Fp6xXDSNsJhoH/aGUPA8j?=
 =?us-ascii?Q?VmPhPyFs/rfXgQPmPRB4JBahJlmzPo9g6b1hmhwdT1fuAAeof+bumgFc29aw?=
 =?us-ascii?Q?/LXSlK4hJvvjg+FQ3Mz0pM83MmPmk0NFJNngIUp+GJR3feWKrO0B7ZigHl2m?=
 =?us-ascii?Q?p9BOhzraBL8jYNMaRJcL869Rvap78MVommM2NdG8yLWFXNvZrPhfaSvXDNHt?=
 =?us-ascii?Q?flyELSB0kRX58I/EMJXQgOwC2e3PDOaDeHupfs51/eGxXYT8rNEtDkJLby4r?=
 =?us-ascii?Q?pX5EoXi30il158d3xfBp38Rf7qeZs7AU1eHfS3OiA1uIldJfKBGKmK3mVA/a?=
 =?us-ascii?Q?+SRNkTZexdxuxEwhydEelMj03YK/m9YTfJGWkGIrV0MFPZ5OQmCNGh8MT3Lr?=
 =?us-ascii?Q?CBpN2raqe0o3ZkICTLgAzu0yYECtXq17HuOilSeqQpyDEH3wYnXGI7v1EbTq?=
 =?us-ascii?Q?Jx1gMgy9XimG/QD36bmVoEpyshoVj5poZjXfE+QqMGzF9c8Eo2c0cUKgZ9XS?=
 =?us-ascii?Q?18WJF8mv2pQliLsYqYvf20k2dhdTE8MyY1vwIqOIV3jgm79vKyH1+iUF6tVO?=
 =?us-ascii?Q?iBAAo4psjBjfSvNLd2rgx8/PeyMrdhNT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 17:18:50.1802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 078c0cab-7ef3-471c-a6b3-08dcd673a1b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823

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
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  2 +
 drivers/iommu/amd/amd_iommu_types.h |  8 ++-
 drivers/iommu/amd/iommu.c           | 96 +++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 52e18b5f99fd..14a153c7bc12 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -28,6 +28,8 @@ void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
 void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 				  gfp_t gfp, size_t size);
 
+int iommu_flush_sync_dte(struct amd_iommu *iommu, u16 devid);
+
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
 #else
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c9f9a598eb82..fea7544f8c55 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -427,6 +427,8 @@
 
 #define GCR3_VALID		0x01ULL
 
+#define DTE_INTR_MASK		(~GENMASK_ULL(55, 52))
+
 #define IOMMU_PAGE_MASK (((1ULL << 52) - 1) & ~0xfffULL)
 #define IOMMU_PTE_PRESENT(pte) ((pte) & IOMMU_PTE_PR)
 #define IOMMU_PTE_DIRTY(pte) ((pte) & IOMMU_PTE_HD)
@@ -833,6 +835,7 @@ struct devid_map {
 struct iommu_dev_data {
 	/*Protect against attach/detach races */
 	spinlock_t lock;
+	spinlock_t dte_lock;              /* DTE lock for 256-bit access */
 
 	struct list_head list;		  /* For domain->dev_list */
 	struct llist_node dev_data_list;  /* For global dev_data_list */
@@ -883,7 +886,10 @@ extern struct amd_iommu *amd_iommus[MAX_IOMMUS];
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
index 87c5385ce3f2..48a721d10f06 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -85,6 +85,91 @@ static void set_dte_entry(struct amd_iommu *iommu,
  *
  ****************************************************************************/
 
+static void write_upper(struct dev_table_entry *ptr, struct dev_table_entry *new)
+{
+	struct dev_table_entry old = {};
+
+	do {
+		old.data128[1] = ptr->data128[1];
+		new->data[2] &= ~DTE_INTR_MASK;
+		new->data[2] |= (old.data[2] & DTE_INTR_MASK);
+	} while (!try_cmpxchg128(&ptr->data128[1], &old.data128[1], new->data128[1]));
+}
+
+static void write_lower(struct dev_table_entry *ptr, struct dev_table_entry *new)
+{
+	struct dev_table_entry old = {};
+
+	do {
+		old.data128[0] = ptr->data128[0];
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
+		write_upper(ptr, new);
+		write_lower(ptr, new);
+		iommu_flush_sync_dte(iommu, dev_data->devid);
+	} else if (!(new->data[0] & DTE_FLAG_V)) {
+		/* Existing DTE is valid. New DTE is not valid.  */
+		write_lower(ptr, new);
+		write_upper(ptr, new);
+		iommu_flush_sync_dte(iommu, dev_data->devid);
+	} else {
+		/* Existing & new DTEs are valid. */
+		if (!FIELD_GET(DTE_FLAG_GV, ptr->data[0])) {
+			/* Existing DTE has no guest page table. */
+			write_upper(ptr, new);
+			write_lower(ptr, new);
+			iommu_flush_sync_dte(iommu, dev_data->devid);
+		} else if (!FIELD_GET(DTE_FLAG_GV, new->data[0])) {
+			/*
+			 * Existing DTE has guest page table,
+			 * new DTE has no guest page table,
+			 */
+			write_lower(ptr, new);
+			write_upper(ptr, new);
+			iommu_flush_sync_dte(iommu, dev_data->devid);
+		} else {
+			/*
+			 * Existing DTE has guest page table,
+			 * new DTE has guest page table.
+			 */
+			struct dev_table_entry clear = {};
+
+			/* First disable DTE */
+			write_lower(ptr, &clear);
+			iommu_flush_sync_dte(iommu, dev_data->devid);
+
+			/* Then update DTE */
+			write_upper(ptr, new);
+			write_lower(ptr, new);
+			iommu_flush_sync_dte(iommu, dev_data->devid);
+		}
+	}
+
+	spin_unlock(&dev_data->dte_lock);
+}
+
 static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
 {
 	return (pdom && (pdom->pd_mode == PD_MODE_V2));
@@ -205,6 +290,7 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 		return NULL;
 
 	spin_lock_init(&dev_data->lock);
+	spin_lock_init(&dev_data->dte_lock);
 	dev_data->devid = devid;
 	ratelimit_default_init(&dev_data->rs);
 
@@ -1256,6 +1342,16 @@ static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
 	return iommu_queue_command(iommu, &cmd);
 }
 
+int iommu_flush_sync_dte(struct amd_iommu *iommu, u16 devid)
+{
+	int ret;
+
+	ret = iommu_flush_dte(iommu, devid);
+	if (!ret)
+		iommu_completion_wait(iommu);
+	return ret;
+}
+
 static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
 {
 	u32 devid;
-- 
2.34.1

