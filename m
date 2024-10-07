Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8693B12B64
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 04:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728274554; cv=fail; b=MbFCUP5T8xn2ZzGHOHc+WQ8FDn9KBoKDLT3kx1gZgyu3MPkhwxb7gwHE5Czzd0IQqtGV5TsbIfowUL0AMQ5uAZjl4rIg4KccWxJv9/42Z4inwY+M1ZISEEHLPYyD/D/XJXLH8LbXQqOoFjbvvHIuLqER3AvBTIium/MyxvDlonA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728274554; c=relaxed/simple;
	bh=LMi2aVeZxgbh28yNgLl/hj2uQZH4XguvxcspQF964Lw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFPwvvwky+e1nqcXXeSDFDauEME3qihG84DBsVd21/RKCOYW24mp/KkOgq0qpPnXA40xZuIegguphT70vPrOFshjHAs2kYLGKO+usszvRkYXd0w6rFAtkyFHsNHgv4/3snSGfwgZxKE2Jox26tbFeYJjFwf2W1IIs+btstZPQ5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wBVHywBY; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wBVHywBY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNzFt5+pOa3mxCHFW9yDvCVbtxeu1DAh5JNrLludLkF8TEor6YaG09AUgZSWF1Xwa5Vzf2WopTYdJoQCSJ/d5tdRQ63M98Q9wi5A5xv4pVS0O2VM0/DxtB83KjCiABOU1r9RP4qKsot14bnSzdT55z2jFhrDMhCLzHh4RY9oV8Ec6Ab5G5ZD+MU2b50eIGy1/pG7ixmq5gVbezVCmc2I1/U/IiK0RglzRKdXHNWj2iAU1rAmVQD+7Mc0zYFIyFgF11W7ED6vPXsO4K/2Tq6j7Bpz5HJRELAkrNSoJW8vGrxx7Sz3R7jTxIazCc8Uz7nVcalSfWtWH4K/LyaanmpD/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6X5bBwbssLJ0ZwvNPA+Ww4UcGDIG3t1FLy05nP7/3Q=;
 b=JZbJz/alfwMqDzQi8QF5yeNSHErmS4cTIi0V3BvfZ8wS/nBWWj1KcT2Ob74MiKwRcJ//PwgSO7GR8nGVI5XPH/KTgYvB0Q9LAfAtJ7yi8RC71Z6ztBwqoYy8XUPC9CKRauMPiQKAy+bKOudeIC/HsIdisZu8EAse+Ddy73OaHalXsYnM/3fyx/BqAiWXM+j2p4YS1fLDzCy4LGtMFoxJ2Jczw3zKDjgRWjO4uq3TZXe8vfbnZbnagM1pMTGIDBLynIxPOIFzlfbW26929/csYuV+OcPkWrIj174c72jMYC5NBimcYdAFSFYbsyxGSHVIFM3eZofhsh4KvhZ7uz+NvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6X5bBwbssLJ0ZwvNPA+Ww4UcGDIG3t1FLy05nP7/3Q=;
 b=wBVHywBYbJJUEoB718yveHsuyZqtSXgYZe/EtDE9VuTZfLVMCTtam47+dXGubl7s1ENA4f/S1cYn9zr7vu1XcQuq3UkyE4AjsmTO88nMwaWp9IhEyJEqLQs1sKu2boKm7n6XreA8vgpu1ribnjG1vxtowWVX7mfKPOEZmo/uYjM=
Received: from SJ0PR03CA0299.namprd03.prod.outlook.com (2603:10b6:a03:39e::34)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 04:15:48 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::db) by SJ0PR03CA0299.outlook.office365.com
 (2603:10b6:a03:39e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Mon, 7 Oct 2024 04:15:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 04:15:47 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 23:15:04 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 5/6] iommu/amd: Modify clear_dte_entry() to avoid in-place update
Date: Mon, 7 Oct 2024 04:13:52 +0000
Message-ID: <20241007041353.4756-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
References: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 022aa93c-950b-46d1-3bcb-08dce686b8b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yfJQdOCOfFvK/+nRys810BvGdnra+RqRiUM6Sv6joxnAJsWcjU32iY5iY2lm?=
 =?us-ascii?Q?AxH73b/QMp6PHVbnL2V2xd2xK+0nczKN9KE7kN1S68inZodmLQluUvNwaJYt?=
 =?us-ascii?Q?eA4Nd2Ihe6588Im7I+pgJSqr0f4/QCglshR0EFhyjcpALFsFrenP2E5Lhj91?=
 =?us-ascii?Q?RHln4WMeQEancOL1Pkq9Y8MXb0X7V/OUe59jePdqjFstvJe3P8rqzbW5VvQ4?=
 =?us-ascii?Q?U6A2bdr9ySqI8qMK69HnWUIcKTjomL7gFciIeuU+JRZlNnFTPNgoOy6whr2p?=
 =?us-ascii?Q?BIh2hFQ1V1G7+45xncoJZXDtAneVOrwKWyPQqpxVyDwGiJOtTvqLaepCLROd?=
 =?us-ascii?Q?1V2Q9GrSa6q81CCVOWv4HgcWXeCendERvKrgi5b8jLJfd1G3hD5ZzCyVzd80?=
 =?us-ascii?Q?1lXY7ZHhN4fji1jqTHJo/WAMnAgJLaj/epjOIPnlVAdGLXHhg06TBzaVTsOW?=
 =?us-ascii?Q?WkTIeV06SBRGrcY4vTEcF/af9tMwMLtRO3AshB6XQaIaypS/AE46wYglFbVx?=
 =?us-ascii?Q?M/jVdkvqALMpbQZx+cSNLnkKELuTTkJxd0k90vTMVz1CYlWK5DKTzYq7ncle?=
 =?us-ascii?Q?n23vYhMzPL0AjBuonBeQV+7fte/m5jG5t47UCT8P4qcdkaXqhtu5CUU9HgsC?=
 =?us-ascii?Q?839PUQa50rX0+fOaLzXbcW4wb5jEj1FyOsvPfm9WNNJWuSOxi5JgS0JfYvGt?=
 =?us-ascii?Q?gCNV5rnP+HK8gW76CA/GR8hsFdo0ZrhCXHuyv2DIsjs9b2EuiUA+E6zC0/nw?=
 =?us-ascii?Q?xJOjJ8xzxVXkVmV5m6K+s1NoHaDgvOHlKG4P32HlnS4R+wP4ybDGffBs/eA/?=
 =?us-ascii?Q?x6/OGUnF8GjUQHy+DQPONHz2S5xtt73rd4ACW8gZBKefed9pp9CRQA/hdCiD?=
 =?us-ascii?Q?0XEbL5OarPwFcqM/DBAbmJzhYRLuREvGUsVCWdGLdwh1R7bYjlih5GYDLEaU?=
 =?us-ascii?Q?BVqOGmN3jH2bS4y0bkN8Lo6r1AeAUeg+dngPQHLi3eTCsS1aqUicbDNPXzhV?=
 =?us-ascii?Q?VXDUxU7ZGscrKh3NZ9WxRo67DKkimG/Bv5tzdvmfhnM1nSuunyFXqF8/+iLG?=
 =?us-ascii?Q?Tv+LLIrGlNDKcmV698R1eLcMfJRlWkx0j97AqTHdcMfoy8Fi6+NqCY7kdSDE?=
 =?us-ascii?Q?pMEECnsTMZ506B2BanfAAiSDX6EED6AmCXuZ4H1/uq2wbjtAjM6z9N7ZysSS?=
 =?us-ascii?Q?NlyVYrX+wQv98FuTZh86T26ZI6paSk0PYbFOjW7PvfWbP2qi4x1vL0qO0n2u?=
 =?us-ascii?Q?XHgKRf78BVZjRKY0JJsGqnlzQSa4Ed/rdbxR/ShzxqISNoxZVcZ0K8rkogi5?=
 =?us-ascii?Q?VwQAHV1lgOboDK5liexDRRMN28joJyWR8DbC1BzMn2N0QoDmRzdpGHDwKcUX?=
 =?us-ascii?Q?HRcDN6A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 04:15:47.6693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 022aa93c-950b-46d1-3bcb-08dce686b8b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202

Lock DTE and copy value to a temporary storage before update using
cmpxchg128.

Also, refactor the function to simplify logic for applying erratum 63.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 87a7c9dd86d9..dd7b02b00be6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2106,19 +2106,13 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	}
 }
 
-static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
+static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_data)
 {
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
-
-	/* remove entry from the device table seen by the hardware */
-	dev_table[devid].data[0]  = DTE_FLAG_V;
-
-	if (!amd_iommu_snp_en)
-		dev_table[devid].data[0] |= DTE_FLAG_TV;
-
-	dev_table[devid].data[1] &= DTE_FLAG_MASK;
+	struct dev_table_entry new = {};
+	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
-	amd_iommu_apply_erratum_63(iommu, devid);
+	make_clear_dte(iommu, dte, &new);
+	update_dte256(iommu, dev_data, &new);
 }
 
 /* Update and flush DTE for the given device */
@@ -2129,7 +2123,7 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 	if (set)
 		set_dte_entry(iommu, dev_data);
 	else
-		clear_dte_entry(iommu, dev_data->devid);
+		clear_dte_entry(iommu, dev_data);
 
 	clone_aliases(iommu, dev_data->dev);
 	device_flush_dte(dev_data);
-- 
2.34.1

