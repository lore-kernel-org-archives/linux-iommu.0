Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE721C9ED3
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730400206; cv=fail; b=ULjoYtRARaX+X3I6Dj3IgXzL+7jgD4kOf4HKcbX/u8Vr/Rz679SayHEh35TEsS/Fiy8JEGvjsiBAxZadedGvtCA9TqBA0Da1HYJ7kbINbN/6VtUlEriy7g7IWVSzRadoQvOpR0f+sa0X0Ex0hGJbX/40D3qiuHYx+2nn50zEEIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730400206; c=relaxed/simple;
	bh=F/iuQ55OyxMe/l+1A87Vhv0AOXM5daGnPXR5iOaqkvs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SzkpWUoixQHFWxV7t1+dZyoDBpi01A5B1fiA8TEQO7MqXX+ipR2xAAizsa8YtbU/NpOcQHPeZZP5QgIuK4h8jc4U5RhDN+xdHIOuA0D724FCs+iqHCHvuqHYL+hIDKWuAEduNef4jpx0GpspmTFt3PfByoF+wWAWs2WrVW8BVng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=abigtI3w; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="abigtI3w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcyRdAq53B9Ptkno1gjzLPLgtb70007WlZY0Jchb1Y/KcqEkeSvClMiCxCoifCeT0+u+g+UuCE1ZpJcovd1eijC4kavIEMHTwhAWCvT2gF/ZHq7s/3m1N1R7P0xVDtQZvd+l6IE0dPZZo8DVg41nBER7ts6D7SFxdOWcZp8xv5BT0Z6uv8SqN7fvPS25/oDULbFZ+j6iz5//dmo+3DupD2YAD7oaVoT03yO8LW7F+bJTuHKIhdsucbsGH1eFRmI0cQMOaSVGcJD8LfMhq4YdfbxtLKDo4JkSWihuPkOwRe2PJTAmWo361lVmvgfkUlgi1S47eeqVG2ZrV7GJLuqqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xESYBP3trcMz5CCrmRiENQ+VhBIg4XbgGHGA6wvtWTY=;
 b=oBFCRPCkcZ/3q8xLWmdhNjxbPSY4VgfCvBX9PH8QZvbIWIQR+BmVyrxT6OtLEs/E8zqb2DUHUkP5dcDMSlfMWEqjFiLSdE73en8rvOow6e7FOn/khf6zLMHvm/XdLHZ6CEBO7G4trJgk7QSPiODwqHabr2nRf2p6NzOL0+17fysawiI2q0SgkD4ZdVSaImonB/LOxemkVOOARawyVjIoHZtdin7gHrkTcCakt89QQgIXckdigzgLr/37KSlcfHuamfsOSZhtZ+9/Qa0ziDdM/tAc2/x1Dn023WGWDUv3n9X6ZOcf+/hjnA+cklnyXOTppxESYVT7Y0YgrXd1WJnfUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xESYBP3trcMz5CCrmRiENQ+VhBIg4XbgGHGA6wvtWTY=;
 b=abigtI3w+TAKuYZPuFv1HNuzympcFORLKLE4rr+7rzrtyUVlz7DT1+jtx9nAxA9PycnGygX3+NR2BDfFVzTkCFGLk2qZIfE83qrpttfWkZehzf2JuAMTFOHw4AXDmunWg3pRfo5NT8RIpLw1psGoNOFqHOpyBKOuh6JXn1HU4NM=
Received: from CH0PR07CA0015.namprd07.prod.outlook.com (2603:10b6:610:32::20)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 18:43:20 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::90) by CH0PR07CA0015.outlook.office365.com
 (2603:10b6:610:32::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 18:43:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 18:43:19 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 13:43:16 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v8 05/10] iommu/amd: Introduce helper function to update 256-bit DTE
Date: Thu, 31 Oct 2024 18:42:38 +0000
Message-ID: <20241031184243.4184-6-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f7a45f-f53c-4051-df78-08dcf9dbe412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?69sOQ5n8T48HPVINXfWydfbrO+NAha1y9JKeNjJRlE7Su8wdY58KOT50yVmm?=
 =?us-ascii?Q?rYQFwvs+iOleuqNstlvwx9m4RVWfrwVeklyPg4iaVtYcYHr+uYtCwF6u28AQ?=
 =?us-ascii?Q?SwxxMX85hd6Suc8Adi94LYvwQL4bIkCMY5hIyAw6zHOIHwmee7O7brjB9JEH?=
 =?us-ascii?Q?h/aw+g8Y2MIoJhnDE63QX7kF1wsZmqzqXa2+Sw6uyVTxumisaIozM11AVLde?=
 =?us-ascii?Q?+aT8166SmjCfzb8HqdK76l53OgY20HED0p42surAXuhplZAy92xTHDkmqNKq?=
 =?us-ascii?Q?T24MU2LjER2x2KWJGkLMd66vejaQHBD0ljHNqDEm5djXO1inX6TteTC6dcsH?=
 =?us-ascii?Q?t0HLWObN4APpOzs3ugxvICjvAfw7CUhcH34HGzjF3iinh4GfxeqX19Wwb8s8?=
 =?us-ascii?Q?L6OafJSxdCY43l2OgBsTsjGoHpJRqnrvVnJh8PhKiqZqIWbjUjFHK6ypjzJH?=
 =?us-ascii?Q?bofb0xo96yP38Iw6Z8Rp9jADQUqx4lsIUJyQv9gfrrR/7DXK8Sji6w9P+zi1?=
 =?us-ascii?Q?bPgCw1dDJQxwoblBX7VkA85vmCAh0pVw3wIlDP+1V2uJYpwu35j55eltiOcn?=
 =?us-ascii?Q?013jUcz8E7mMXnuor1uXBsnUr9bFJoRmMVq1HFJaFH5/eEIyDLJ6Pz/UqLN2?=
 =?us-ascii?Q?ZdNHAY+JKJaPGIRfaRQ4gtg0+Uv5dWfRaZlpnK4nrkLtUs0JDKZX7mUMzkY3?=
 =?us-ascii?Q?qrlA+toNK1kgWFLrCgu52qaYmaSeK6Gec8+BGTHMDSOdKjTWenI59LTf3XVj?=
 =?us-ascii?Q?AVkX99HZp6yNL0y937YamiHBCG6lyk2dBhLsYOl8uutnRgRSg42tANHvqKsh?=
 =?us-ascii?Q?CfCWjW5acm0bXA2fs64a/tco5Mjd7KHp4OZp/twxiZj2ivCKX2m2OBEpPi5c?=
 =?us-ascii?Q?7OF3DDBGBk0tl+JmWBCkt7EnBEhlFsEVPWi1+VGHnHMOV4bSVaQcRgWWxfsy?=
 =?us-ascii?Q?s+49LqHCaR86hcAr+teN+xQ8J+rU8sUk6lxeEsfbxOf60vDVtJO3uCoWnkWO?=
 =?us-ascii?Q?0XLGo5tR2Su2GFU14k6SPOwVgh2zH4d9SQdB4QMyGcTMyIjHhQscqoFAfwtn?=
 =?us-ascii?Q?domvVR3/dmKABok4cRU+fvasD2Y5jjtAu0mfi1KChuUdqhBbbSLXPK/8lV8M?=
 =?us-ascii?Q?5NvNTq6gJjV2Boj17Ij95UDmMnoKhA0LlhhSkQfp/+fVBx6A/Jf9B2Rx0UpL?=
 =?us-ascii?Q?Gday1l26+49e2omtJa2e4qAlvBmE4AvMQ02CT7XBrzpIqEi5MRutpNt6BkxX?=
 =?us-ascii?Q?bSjg7Hje1d2ABGQO70hP1hv/SXJvUeecAtDrQWoPkw/oCpfl5XMOF3c6Ob0i?=
 =?us-ascii?Q?Omspcbcxne4ycDwznsndDvk2Uzbs6s/1rqcx/alYNQ+siHGZ915INfPJctbo?=
 =?us-ascii?Q?HGPnAy2W1VFT1OOVwrBohxKJKYdT3G0lBP7gNpFBhhS8exaGdQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 18:43:19.8582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f7a45f-f53c-4051-df78-08dcf9dbe412
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131

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
index 1e4ad1b247f5..8e5fbd78c302 100644
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

