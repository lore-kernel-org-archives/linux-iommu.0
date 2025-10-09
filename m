Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4E128D8F1
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 23:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054338; cv=fail; b=kRWMX6e05J4BzkaWav7vPrJQO9N+yMFdSa/3wouLSQApHNMubd+o/+R63cilgHQkl/4uXwGp/Yb0M3aK9cw0Vp3Ai9zGQGwuBzTw9y94qJzj8YyBk5tqfTKvpiHBst8hc4aqXw1LCEwYTjU5ESpzYlyw7gY3FlnjVTD5Wg4WDqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054338; c=relaxed/simple;
	bh=dK78iuNw1GU0LUpbCsuLchi9/xmz8emrp0kXFd1benA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CvLxgIG5CeUCY5sU8pq2A4FCtC+xaSvf7YwaN9LBtSqzqB3YU7VFGYvrpCuQI+ciQ74StR5QAq4mbRxRcCzdy0hUDjimdrJuIY/u9iCZiyTbHDuq44aOAnLr7slHTgWi3Rh+UOdmXCu1PljxQMYhfy8cD3FBE8APxdcP+hB0BQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C9glYGK9; arc=fail smtp.client-ip=52.101.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C9glYGK9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5aX5ALTGpCWE5qWKxYTzdsa2LIu5CIOLDZGZYk3qWFEvHhX/rvZoRWNVy2zM4eXB8Ld/Y37qWWfTKZ178GgmmxAmzGzxlEvPX5X9mUFJRcNH5iK5/l5f/u0CUfJq2rOHRk6F8qPJQgYtwCJzPbf6Fw+GjfsWcs+1ZVUpVod0DdVIUAjdKJbCEmHtVVl2IRl7HzmHj5XKzE5LOChdbr3xByGtiAcLP966+AGfm42qDyLlZqKnnp09iFHiXTa4p4o7YOHmdKE96QR2d/n6AV8+KksToV6C+2jFm0fDTVv3d2cT19kGhLiP5G12jhGerh1e5FowQFj8GqQJe4RoN1svg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1rp0LwEkQtGMRq0olWXngTjy+D5DA/0En9iQJ/qp6c=;
 b=ElpthjWBsfWBMLgtZ6ajLFUUZmD4zbl2RbmCODqi1LO1ALr2JbSJA+6UlbXVOYzJM6zpXbJ/Aqqdyig8+cQfeX2C74jj0nZwvPKu4A5GVz/gSDNNIbvx20p0SSoyBMiMiWcbTnO/WV4tZhocIaHKxNAiWc7yqtPi52cD3okbwwLFvefLUsY3jAM1GTFJ9pShZ4akT2rY7ID7/TxHgDRBMQIhK+ZZZ8oRJ/pKZTF008KeVBwhWOrz4c0M9nkmiqcfMmpn6G73Y9onbOXE15KNAKNsREbfBVS0OJy0c5qEZj9aNKGaCOxjQwrLtLyAM/aAF29Z6ZmUz6F9NwMBPhQ2jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1rp0LwEkQtGMRq0olWXngTjy+D5DA/0En9iQJ/qp6c=;
 b=C9glYGK9/UrNgRpdwVLUnQ/GP7Lq+4XZNxiId1JgWPbwuyeOPmsD9NYXRfoXPWm7zxCl0ThnzB4LrCe+6LytpAzdbCkfdGkQodGX8p20u1DT/Bi8nDnpZuAS0nAc/eo1LgWqOzuKwuqt3UZF76HMI+pcrvBnVcC5230zoqvu/eY=
Received: from CH5P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::20)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 23:58:50 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::e9) by CH5P220CA0023.outlook.office365.com
 (2603:10b6:610:1ef::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 9 Oct 2025 23:58:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 23:58:49 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 16:58:41 -0700
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
Subject: [PATCH v3 06/15] iommu/amd: Make amd_iommu_make_clear_dte() non-static inline
Date: Thu, 9 Oct 2025 23:57:46 +0000
Message-ID: <20251009235755.4497-7-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: f8962dc8-42f6-4311-dc59-08de078fcad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E4VkAo5egPJUwLtH4qosmVcf2WFwFJ4Vh8f9K1k3zpYVOQUjKd3RDy7iBmMS?=
 =?us-ascii?Q?ZqVmmQreqfSCiHId8A1SYYkgot9oAtn/eM5grrwu+evmBRrMJkqDHDVB+b/y?=
 =?us-ascii?Q?dt2bPnCsTeoQ+AXO3oLq2hj84C3UcyQuXX5g9kkSMhkg+pwCnByFgG7mBOaO?=
 =?us-ascii?Q?jRPGLaCQaj/P3E8CpcH3umOCcO8QUlbgXbfHMQSv2opjKSuoiQIvtHzpJop5?=
 =?us-ascii?Q?aTv2eWDBsdfW5oCMVz1/mOjj+0hnmAYD43vf7L4ND16S2KcyeF7kCRHTq6hT?=
 =?us-ascii?Q?gR+K4z7xBAhhV9YQe+Zo3vVfFeRrGCN8W9l3588yEW4eJAJmY0LhSTNQHaEI?=
 =?us-ascii?Q?bn0iTLIa2YGf1pNIlvAi2sBJyOp8vXtZRqkCjuSl/UTxC98FxUG8l8PGoV1u?=
 =?us-ascii?Q?6PnWatPlxDQek9qWrIzo9jWbqE5Id7wC3Vz2Zd3og7XYbJtnOZ9+QYvAM42P?=
 =?us-ascii?Q?LSve/BhDzbH3MAv101vLioQLbZ3YLeKejzGP3uV+Ue+MSpzRNCUNJIJt4NOO?=
 =?us-ascii?Q?bLnj7YA1s9OmoYQJmsWWe9DH3OmnMWZQmwgYw9ssoytZZy0PG6ZjtuH3sNvx?=
 =?us-ascii?Q?qtvmxrTfB5Ookvz68RttJuJpWQV4a+/B3cLTw/RXa2l9XL8eGlkJDk2NlwJf?=
 =?us-ascii?Q?QB64HccrmUjvwOPkdZS+DLMpvXlR17oGyCRe6RCMMGas+s/FlBVcpVXSyxwb?=
 =?us-ascii?Q?iBhRwE+kegumTfAeCs1azvr9iQMGTiFj6aVh26QmOAOD9j384SbpfOi6vEXz?=
 =?us-ascii?Q?PXn9UFkKZvgz4tw2Qhn6al4VSTwMV7sYg09wotxVE4fESAWiolif3QHGGhUd?=
 =?us-ascii?Q?YWfYx8l7P4TGNBGzDE/ZMYBZfJt5sfurVqftS+0Bic9UOBq7WbRx5+wqhibJ?=
 =?us-ascii?Q?BL9Q+s8c4HK9trxeUJtTAStH6/jJnnk7hADihEBOOUMmWfjV8vOhzrRv9SOx?=
 =?us-ascii?Q?dFFNybu0xJdEshHCWPhnRQ8y07A0Ie/4QbvpJHfH2aTd1z7+rwEURHkk2HDL?=
 =?us-ascii?Q?+7cFBrmxHrwH60oPMj6mwl7WOYrddXiLzf8yhmVcCOVaCq0c0tobhCSquYm6?=
 =?us-ascii?Q?VfVO1n2QlpoGS/QKTnpeAO6Ps//RQ+78F7syCemQRHG93Jq6Mm6SsbuE+3/1?=
 =?us-ascii?Q?iMgFImufVHSmYWD/BJTbycWH2IdUIgXbBYDmHIFBqd60r5D5XaDePX0zwAL1?=
 =?us-ascii?Q?duQIowoz94ZZmASQPi1iWu1LtLYKSBO3NtOWwDOhBoZOAVXiK3BhHrWx3zIc?=
 =?us-ascii?Q?yqtcqjKnHZpnzg7975zZl/jm8IJYSaBz/AySqn6kPt2ThLBnd4dmY9qW6dvD?=
 =?us-ascii?Q?AhUwiUjh8Cok+20+Jkbg8IcGS3nF9j5hL+5oPpAQS27BYHBpoaf5CFOCxuFZ?=
 =?us-ascii?Q?UaoYq5m87Cp20gkr+v54A3aKgFd+VbQOqo4hfL4hlNDg3JOtfiLwG9m3zieC?=
 =?us-ascii?Q?OsTQ1rpIepDYMgLYKpXO3HWpl7CDDneGderO/36+6JT6SAHFiLmEEV6tkEK/?=
 =?us-ascii?Q?tilWf385knxvsvnfZEfjAQlLB2er/gwogjsJosKan4DcBUNXrLyxqTP2BZI2?=
 =?us-ascii?Q?x9k3+S1JQ6Ecjsoq3QM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 23:58:49.7002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8962dc8-42f6-4311-dc59-08de078fcad3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755

This will be reused in a new iommufd.c file for nested translation.

Also, remove unused function parameter ptr.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  7 +++++++
 drivers/iommu/amd/iommu.c     | 13 ++-----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index eb46e8914eaf..c7cb4a80d44a 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -193,5 +193,12 @@ int amd_iommu_device_flush_dte(struct iommu_dev_data *dev_data);
 void amd_iommu_update_dte256(struct amd_iommu *iommu,
 			     struct iommu_dev_data *dev_data,
 			     struct dev_table_entry *new);
+static inline void
+amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *new)
+{
+	/* All existing DTE must have V bit set */
+	new->data128[0] = DTE_FLAG_V;
+	new->data128[1] = 0;
+}
 
 #endif /* AMD_IOMMU_H */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3f2c61509b60..386ac96b2c02 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2008,14 +2008,6 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 	return ret;
 }
 
-static void make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *ptr,
-			   struct dev_table_entry *new)
-{
-	/* All existing DTE must have V bit set */
-	new->data128[0] = DTE_FLAG_V;
-	new->data128[1] = 0;
-}
-
 /*
  * Note:
  * The old value for GCR3 table and GPT have been cleared from caller.
@@ -2068,7 +2060,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	else
 		domid = domain->id;
 
-	make_clear_dte(dev_data, dte, &new);
+	amd_iommu_make_clear_dte(dev_data, &new);
 
 	if (domain->iop.mode != PAGE_MODE_NONE)
 		new.data[0] |= iommu_virt_to_phys(domain->iop.root);
@@ -2128,9 +2120,8 @@ static void set_dte_entry(struct amd_iommu *iommu,
 static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_data)
 {
 	struct dev_table_entry new = {};
-	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
-	make_clear_dte(dev_data, dte, &new);
+	amd_iommu_make_clear_dte(dev_data, &new);
 	amd_iommu_update_dte256(iommu, dev_data, &new);
 }
 
-- 
2.34.1

