Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454FC1CDFA3
	for <iommu@lists.linux.dev>; Fri,  1 Nov 2024 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478228; cv=fail; b=fi7sZ2dqWe99FMQMPLQqsaZbLa3/hg8jbBHgkGYo2iZFCjSuEfVD5PVM05TYzOyEPP1Gw8OOitNwRdfo1fZiaR7IB/UmmwEf40+fYpCqdVrKhAvCom/+sAi9pcJne6PDU3HTIbf/3/r6t6gVAK71Ru8MuBpqu/Q57TJTRjaOCUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478228; c=relaxed/simple;
	bh=/mFjHimGdP4XkKktzu70OAi/aiI9nut7aHD3GE7T7OQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SFURhv67lGiOPjVPac5j5067qOJct244foP7UeNSpL9RhMUp0WuuPidc/xkLYEaUS70nhGGGHW717xcxfMRxeE7JqGAD8WmnrFKwQjJJ9xoT+HVUpotikh2xrAlN4ggI2oPRO4xnyTgPpWUR+9vuwADdzG4hUAAaUeR3W1mOr2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=peUUk06K; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="peUUk06K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qx2453CZHb31Jecb9A6upNpjbGLAPo1IRCrSMYhJXjU7DtgHmX3icUgaKoJacCgjXIbEe3TX+lnewBX8F8g7bzI2wR92B7IvX/u3jzppI/Z9KrgsrMStkbPE06oSnm6SEu9TI8GrJRV31OAm6VjJK+X5oLMHJqJ/9TN96beNdpwM5yJ58UNnmmyWB4bhVg2ESfFaKcAahXsF8xzV5/L90LoyylvdhhXCOCd8sZyKf5bKGm49KHEERfHtXty3yLKXwlG6PRqTzZzbe2heHGQ2mbB4Ma4Fpy9nrbJJHuWYwL7VrDKl/Svfx/RWVk0tTx5CW3ArPol5x5qc24VmJScfKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNQftm6NnawzT1lxhZ9Sqomg27slmZLwmsxL81yuA7s=;
 b=Qi055oudWAP0Wneto5MYQUumtN8DDJu7Y2v9r8Ugy+qSedLPml/BuJALnSQA+MX9HGRl427YeUJ0Hu1kNAwgsQXb2copBObDixhzA7DkETyONUclOH5W32UvEVLrQ/sGBI+jjnQH8IV4jQv2Dnj1FvZZkVfKJZstqDAF2Wr8OGw8roqF2Xg/bsUWZfCflEDGT5RS1qXU215fBfxjjj6Xzk5OwUTl2UfOQkNfMXHFktIVix6dIFrEu0Zi3E72Nl6N8+2LUjIPVZJUGK1CgTMVUnnysaVK/YA8sX5QIrPSmzd4mHLuHmyisFSrJvMb34//nhNvjPUeKQBZymUybmOffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNQftm6NnawzT1lxhZ9Sqomg27slmZLwmsxL81yuA7s=;
 b=peUUk06KWSfdoxnhtQcYfT6nuv7IGTEaVIqvO4lKsIB2Ga/dyFo1gXsDds337VNl8S5/t2cMEbcmuXuV8b1aUQ1Q3YLQRuKc3rnbGsZBVVe6hDf5lZEvq41NDOMGdgnhvLepxgxyTVZ18NNA8xPplivgA4kfHRVg3ZjQYQeD+Bg=
Received: from SA0PR12CA0009.namprd12.prod.outlook.com (2603:10b6:806:6f::14)
 by SA1PR12MB9513.namprd12.prod.outlook.com (2603:10b6:806:45c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Fri, 1 Nov
 2024 16:23:40 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::ee) by SA0PR12CA0009.outlook.office365.com
 (2603:10b6:806:6f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Fri, 1 Nov 2024 16:23:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 16:23:40 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 11:23:36 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v9 05/10] iommu/amd: Introduce helper function to update 256-bit DTE
Date: Fri, 1 Nov 2024 16:22:59 +0000
Message-ID: <20241101162304.4688-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
References: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|SA1PR12MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3a575c-0bad-4c27-3e7c-08dcfa918c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f8ap+COvVNJLPH9eIJS1VtPjH6o/lHS2VKTwpSAqB4usV19h741DFlzLm3Uo?=
 =?us-ascii?Q?t43wyXsPtOE/DLu1JRztVaeBxYyOKMSVV4cEaQJWAsiMvonRlmcVlUx0RFga?=
 =?us-ascii?Q?cIr2cEXymBzaMxuGfmq1xUcEWfyOGydMuEcFYg19uqrmikWSviBDp3dR60QA?=
 =?us-ascii?Q?n+Gj4BWCDIk5nCaB2tMT0nyQWISLTpGs72lmEfQySZFlFJR3v4r0Flfyiye4?=
 =?us-ascii?Q?g5j82wwab7+tBVj1zSabbW5DD6v6P/b4kxbZfGObpHAc5Gz+UWVvBxCF9zNa?=
 =?us-ascii?Q?14HWnUtTxxMsk8zZvLsdWovRaqlZvjDwIA/omptk0ca3QGi5b2thO92L96HT?=
 =?us-ascii?Q?ndf1nLyMKemHKVeaNXfVgfciNdBX/zq/6GTodweg5+CJMQ93o7Z/lrCIkViw?=
 =?us-ascii?Q?0VdapX1xwR9G7TxmQeFIELbURl+ZKYnLV2gs2kMC3siARX+vbrVKek+MoOiw?=
 =?us-ascii?Q?wQaZMYS6zBFbwpClZ02Rao+2tfBF0dRVYLpfzVkOe4LukqD3MYCLlhoFiKYt?=
 =?us-ascii?Q?xHsRDUdqq4rZbc3OGSveEnrKoLL1s6aS8FLHCPJ1NepKM3I6ZeOdDEwX9zAU?=
 =?us-ascii?Q?WNH1A5mOsjL4DR2f2pNMc4eyIZZ2f3Zp0qLQfFLoJv/W7do09ARFWT94hAC/?=
 =?us-ascii?Q?ra28AMKrFWr7HrWGl+ntyFq3wDaM0wJy1DDIt5P4S245nbcnmqE48qygqI0L?=
 =?us-ascii?Q?kgaxS3SXY8ciG2cCPHC8REaMd7kd/Ud1xubh3lE52Thsqfl/DlpsxyJzEiId?=
 =?us-ascii?Q?Bh2kbd9KaqokkRn3u4CfMmx6oX5/uQe8MWC+PTUOryn6f8HjubM53SMHDsyq?=
 =?us-ascii?Q?iPqb0MBr/W+QqlUeyFyvVJbdFmN5D4rHfnwJ8ekGEn9QdmyvO96ZWzM7oIgO?=
 =?us-ascii?Q?+wJ9geu/AWlqTLyCPy2RTf7uDsJoUWYHp+H6NWrrF4umb9B8+AQA5QoWrHRi?=
 =?us-ascii?Q?MZS4WLh3/DjvOItOd31GIFlkDPGH3WMulrK0h7iaDvi/bFXUyV+XgaAmcxiW?=
 =?us-ascii?Q?XFIkI2Axs/c539QVHLrLk+ZGLbU7NfUxA3MlRFhlH7AjpsupFlFbsm1t1Ptt?=
 =?us-ascii?Q?fEm1UhLfXEOliuTkSa0XDSUAH/jMiob9cbVZSeM/dDJYeK/v+YUdH+NCo89i?=
 =?us-ascii?Q?caQtgusA+nmNBAu4YYBHGxoWQbJUCTG0OLLPOQfCKlzIXzA+UggnmsEmJ6df?=
 =?us-ascii?Q?4xyoTw7hp2CDmQhq+bka1eNe0KBmuskq8kf9K/tWmgOHqABndBQ05qZO2REn?=
 =?us-ascii?Q?uwHyiBZ3RalnOLDhgK0bW6/EbPXhdJM5FmI1gbB9XMy18Cf5pVNcME/I7nG8?=
 =?us-ascii?Q?/Z/xsoHA1tunv4l8BMNfzxmh8f5ZKwSD+ucu+99CiczRu8Y7kWuLF1dLnGjk?=
 =?us-ascii?Q?v1Uo4IPttVlXe+ZduINvDyKuqLyGrmuuYmDZGUjY2N/UNaqYxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 16:23:40.8291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3a575c-0bad-4c27-3e7c-08dcfa918c32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9513

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
index ae5f1e031722..ea7922b06325 100644
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
@@ -842,6 +846,7 @@ struct devid_map {
 struct iommu_dev_data {
 	/*Protect against attach/detach races */
 	struct mutex mutex;
+	spinlock_t dte_lock;              /* DTE lock for 256-bit access */
 
 	struct list_head list;		  /* For domain->dev_list */
 	struct llist_node dev_data_list;  /* For global dev_data_list */
@@ -886,7 +891,10 @@ extern struct list_head amd_iommu_list;
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
index 5ce8e6504ba7..267bd78c6eaa 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -83,12 +83,118 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
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
@@ -209,6 +315,7 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 		return NULL;
 
 	mutex_init(&dev_data->mutex);
+	spin_lock_init(&dev_data->dte_lock);
 	dev_data->devid = devid;
 	ratelimit_default_init(&dev_data->rs);
 
@@ -1261,6 +1368,15 @@ static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
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

