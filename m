Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E7718DF6A
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729055933; cv=fail; b=U3jV5xgsR+3tVYKiHNxH3SCIo8qAqMft+eIksBv+Ag8BP3U5An3dxNU2q6fHOTnNxCyUXDeOD4187SqsV99CfKJhNcVrIyXn7aVlNWow4MHJ80ivYnV0Hu8OmJjQEHbH/jbSxBKmtyY6D4v9Bx3obvbAJGGbkoJJro9OFQ1UIgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729055933; c=relaxed/simple;
	bh=02fAY5m6AqBUMSF4l3o0k/vpsAkiemL+Y3VKDqCH4oM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sy1dsYR0BtLzi5ZyePT8nYzn0dLeuFG1pZIMHs4FE8SN2L9izfXncq8CTXBUZyuCx3ZQLIdul+tNgjme++C3w1lnvUQHQpwvWMWYhxJT+TJwnJ0yTKtzTs4rFmd6E23hOGmH0DP/dlnitVDPtUfn2QSWMtuFL611QsiPkkmyUSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KNtR3E4W; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KNtR3E4W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kz3zGzVJIewsCgRYDPRYBsvwEa2a0Dn7v+51cw7VXDFk7eFleScSVIpDoIVXpj7D+NKrGT0K+gds2lh9/Hb1H7hN71YmerP6GkhAdBUakz4Qmbq22o9K/V7TdwQkEf8hAxLLUqvJa7gfTM9a+s1bw4gJULPwGghSlZuaDWBBOYPRtNCMdcNbkemH1dPqtW3S9Px94FvEo9iYShlAQGUwc6Tteo11XFzeTSbA+uIN+ar8oODRAn4EdM/CHUH7eFVrL80MnmTdTTpFK1UZn0AVhsXVml5wHOENb4IFVRTJgdExvcsRQ3Gy/128Ie4NB9qpHlpBg1+eg6NdttoD6mYqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbW5q2lwQp3r6p/1SXYhokhF1i4ixSHIZRPYkEJfy2k=;
 b=j2M/QvNDUxyDPC3qwMar7wzNUZroE9pxdnfYf+/pg9VEzBDdjsAa5rlKICm/+eOlogOi/lvZ8zPNl5yA68XLpC9BqqLAjUunip6/K0W/+azS6jZszutRZ2JCLAmZeiQRhlLDVuejFyC6Z9qY/n9TqlmCxC5UgsC8J8rBQrt1YOiVW72WAvIFx8QtZuSvidHJf0QDwvW2hlbZvbhy+ggpsvvrVRxvT/gAF9MW3evA1uG8r/obIhlTXxl5XIp2WgbCA96KczQb/VWWtLh9ZSQR0BlDZdp8/Gx5NjKCd7gOmTB9csA6PDkOv2A0PBDC1VZPumZGIpBvtzFC1phe3yBmqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbW5q2lwQp3r6p/1SXYhokhF1i4ixSHIZRPYkEJfy2k=;
 b=KNtR3E4W8TbGEFcOH+bu8Uj5skK9dOqDgCxPxzMQ6S4bBwD40Su8qK8zCnWF9uH6dpgRk0XgM0/pXv5Qa4cZxwxhgWKTDvSO+A5CjErllyBiIp7EGcIIT4+6B0eDwq9hEHLZ8D4rfjVYHTSv0ADP2dQBFX5/UYRius5ctGVWJG0=
Received: from SA1PR02CA0024.namprd02.prod.outlook.com (2603:10b6:806:2cf::24)
 by SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 05:18:47 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::37) by SA1PR02CA0024.outlook.office365.com
 (2603:10b6:806:2cf::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 05:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:18:47 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 00:18:42 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 8/9] iommu/amd: Modify clear_dte_entry() to avoid in-place update
Date: Wed, 16 Oct 2024 05:17:55 +0000
Message-ID: <20241016051756.4317-9-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
References: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|SA1PR12MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: f51f484a-94a9-4b74-2a0b-08dceda20328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6A22KZW+6bVjVyHmu9cqLPbbe58teXmJ1RtBwUraouWL7gwgATbnf/Reg3gF?=
 =?us-ascii?Q?5jxqPDbs3zh1XMVjpsO0eW//t3WA/JaQs1l0yCp7ET6Pqu4ehoZsJIRJ9d0s?=
 =?us-ascii?Q?LwmjLNqSIujuz73ZwXsAazjO5UO/0A+ECzK0X5nirfO9XzufvSsDOSU1v16L?=
 =?us-ascii?Q?nyAc68BRrv/pgLDD7YwuPFvOYo3gJmGfmRytXWRmmTWUbE5pvIzPcE58mtQr?=
 =?us-ascii?Q?Wmzmsr53cMad0l8Y+FT98LUpP5WcC8WZ6fjRsjRrl5NqOfDMGqLlWanxYkzL?=
 =?us-ascii?Q?EyN0L6vzImEAz5Qpx1qEacxQeJ5lciDnTaD4z613k7C68UScWe8GQzPZAeCn?=
 =?us-ascii?Q?ZJCvDALRkB5v1dHWC1dc9omqGk0Zbyw11G4GLKXMAS82hYzA1GTieQdI2p6g?=
 =?us-ascii?Q?Lkvaefm6EcDpxNXH+sCSwgFk+x0kfjw4kw1gJBZV6V1dGbEDa4lGEmQ/u8T1?=
 =?us-ascii?Q?1eGvydfGZNW8plO6BoxaB5ai5Rm3Ui1wlusW8j/ys0npN8KrH7QUr+eETAeP?=
 =?us-ascii?Q?kKBZuzkiAziwM5EdnXBJC9Sq8JusYWBhgD7a0iBUdT15MhTJO5Tt11Bxnfni?=
 =?us-ascii?Q?gXfJ0j+U0onRux+2liQOXTSSSe7ert1Yxj+i2qS44ud5vI9lcb84A47rLlJj?=
 =?us-ascii?Q?5cLqQJML9oGWsrVTgPPjfBsiW+heL0Dzeq3tnzfcEWOq5CrGM6ERskIXCOs0?=
 =?us-ascii?Q?+dlCOrDekAmajqEVOxoisT1H2nbaOSAZUJZKJnqe4O4UXQrp1RzSld7Y9Hml?=
 =?us-ascii?Q?Ut4Ym6KQICt3+7QchE5Q/SvMj4akCjPxYR8JiOwJFOjVRz7d+5CzO6dQMd2S?=
 =?us-ascii?Q?7+jRAlKaqj+bJkusD8k/c0I2dCLnGSRknxmEkgDtaVryFTUgIxNVZaWOd4AL?=
 =?us-ascii?Q?yUpqBb2+rV+7HbVv/N18lEOYMiwJm/V8EQEh5qCZLZycKYYuGcjocxXBdR2p?=
 =?us-ascii?Q?YxtFcVJ/a5BtQANtmK4PERj1PuEPaf8EFdbLUx0TwUb7uUZpvEU8xZpaV8V9?=
 =?us-ascii?Q?sw1S9KDe10BPHyoAWKZnf9FMRXQPoWCEE38hPEsLEGO+tpBr/odwHhAqC6xc?=
 =?us-ascii?Q?V/d1Wbj7/ANWUj/emqBaNOCJ83IF3u6cMumfUoF9ezhUhicQNjN2mPeOfqZ3?=
 =?us-ascii?Q?yWXNcD68ZhjtojVUmp1tbdJbDapOEpUvXVXAVZX0aqL1V67s26d/EJzf2OZA?=
 =?us-ascii?Q?GDVoAdjVvNsJ8aAHLE4xURaOc9tjq+MN78rcfQtl8krXg0Q9VMMbLID3+TwO?=
 =?us-ascii?Q?7s4ht7FrNk/rUtD/J1nzS0bCyG2ejHxpmZ2xoettj0+Iz1r76UbH+e329isQ?=
 =?us-ascii?Q?97ErNX17zTbt1p4ScHEGhZrIZRGVYxrZqZOqIM4yjOLJH0BSOVsf0aM+mNZt?=
 =?us-ascii?Q?eONrZWqQX6yd98KLYUH/EGPEZw65?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:18:47.2122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f51f484a-94a9-4b74-2a0b-08dceda20328
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270

By reusing the make_clear_dte() and update_dte256().

Also, there is no need to set TV bit for non-SNP system when clearing DTE
for blocked domain.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a8c0a57003a8..9ef6ddae3b66 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2110,17 +2110,13 @@ static void set_dte_entry(struct amd_iommu *iommu,
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
+	struct dev_table_entry new = {};
+	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
-	dev_table[devid].data[1] &= DTE_FLAG_MASK;
+	make_clear_dte(dev_data, dte, &new);
+	update_dte256(iommu, dev_data, &new);
 }
 
 /* Update and flush DTE for the given device */
@@ -2131,7 +2127,7 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 	if (set)
 		set_dte_entry(iommu, dev_data);
 	else
-		clear_dte_entry(iommu, dev_data->devid);
+		clear_dte_entry(iommu, dev_data);
 
 	clone_aliases(iommu, dev_data->dev);
 	device_flush_dte(dev_data);
-- 
2.34.1

