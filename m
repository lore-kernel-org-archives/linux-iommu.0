Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFA5354717
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971940; cv=fail; b=Xm9RpY+yecfXtilvaEgKCVMPIr1IMS97WsWIch8fQsMAAwu7pRU3lwn8lKdyFPJfZMlS/JU8DjbPIh2TCM7YES86miYWVmag4vT9+pK9a4jxyNN9Ygd9oB4pZ43Jh51nxDcjbeODVK3gDzMW2USmHk+D6H2PZ3iR2oyee3fV6QQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971940; c=relaxed/simple;
	bh=R8Io8l8m+wR9jfAaX4tf2knIrJYmNuNmZKXkesNZAfk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OFHNKIbltGsWfn0/bS+PMcWhtkqS7HdqCJz8rXJ1wuByHK32T6SwcYNwVezN2Oefeh4PQGFoZ9tufSjtLS8WrF9m+UwhXp5G6Rsb6gflTCzKK+No01Dv7fE4d+d1Su/UN8w03WW/IoKveap/PwEzxZxYvmcggnSdS8T7biy/ap8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O3KUQoJf; arc=fail smtp.client-ip=52.101.52.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O3KUQoJf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6/19w6G+qWoPaScWYSgQKUsk4mVuQ0cyn2ZL2sWZxrXcMH9pkVxx7ajXka0tPhb34+lWa6rJkXngCc/lFeozD3LcYPMQ9lVSSSIc27lpENwX5k9rytG3ysjNazCoaD+I6CtD767MNuJ1kdkTj6lQx/VniY73z57hDom0r0AOc3gzYhgED6ndmXaVMMjT4E1UPabpzmr9bVAnIttpOnFV4ranJ+OJO5intz2jIQPWitg5/R31Pc8xfQ/6/1+Sdr3AM011b8S/lYHqSQKG3EwsYA31G9avNm0QI5WiauVbUSv+4JZZVy4c2G3rSaJYP4qpApLoqugDoVK3Z1MOv6UeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgrsTAh6nIKwgd/TDBQiluuUg5l3XPtHVtweGuGoAUc=;
 b=aXt5UA+K7nnhRPWYDGvGNFZs058skdlIAzYMt8IqCI/3b5W9koDaDNako46wH/vfMUphd52ynqEcHuUoRN1gHcilljTkYZLOt38l9ClIXdCYjcnDY1DuKPFzdBkFhAFCTZ2o26C9fA4BMKnINkOSQJYhB7aZDcma2NcGAgzcVHIkKJ84RB4dN9SUIZcHKSmr1MC2dWovocotufcaDZVzb15O8yxB2WG8yRpsTcsxbnKOuR3yVEYZIolcbHrHpYZSdV3n0v6G/dVWnbkPUIT2B1tj8Yu0DxuaI6LcpAgYNhD2wbVqVl/sK09oE8yVOpWmuQ2nwkktyq2YuKAoUQm9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgrsTAh6nIKwgd/TDBQiluuUg5l3XPtHVtweGuGoAUc=;
 b=O3KUQoJf6Cvj0wf6jYvoFSA0Ha1udHmVy1ldd2/+tT+oMMQ3DZd3IGt4qvSeF1KM5TB5dXbafdzc2kYJ7kDuTKEEVFt5rmlQpFPtTtDK/3N6/Z+gDNf01bAlXFS45CWYoSfsnSMLvenqcihkKSxs7tAPIRp6aOwYtwaDJq1fseQ=
Received: from SJ0PR05CA0129.namprd05.prod.outlook.com (2603:10b6:a03:33d::14)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 18:25:34 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:33d:cafe::ce) by SJ0PR05CA0129.outlook.office365.com
 (2603:10b6:a03:33d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.6 via Frontend Transport; Wed,
 12 Nov 2025 18:25:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:25:33 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:25:28 -0800
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
Subject: [PATCH v5 01/14] iommu/amd: Rename DEV_DOMID_MASK to DTE_DOMID_MASK
Date: Wed, 12 Nov 2025 18:24:53 +0000
Message-ID: <20251112182506.7165-2-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|CY5PR12MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: 71101563-49e3-490b-c6d7-08de2218de7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j8cbwpVH7c/iQMHk7yRzvPGUfk7TIQnM6PUP31Oeyx4+fsh8EJyISKDWDM5t?=
 =?us-ascii?Q?9FlqlDE0JK3WKmc8Luk3R614be2ev3wiWpqDyjT69He/B89SY/UKyaHYxD7f?=
 =?us-ascii?Q?3Ss+aL1rJtsrOwGvYcZGkoaeDnmBQ6hwAQxDWWaTx0gRGbwqynUKbUEZWLWE?=
 =?us-ascii?Q?qCTsD8bkLbzz04WynB1W8A72rtsRBDafNRYUe4Jp3x3ais6WwoW+Bu6WMR2K?=
 =?us-ascii?Q?4JgUD8de3LD1b9PdRUbVeBoPBocRT6+QeRKlCsc2AREiTMENcKJYHyMgpoEy?=
 =?us-ascii?Q?N8blYp0e/sC+jniWIZG7gzFngzdr2LIcnLtPWnBrJQQGmX/gRwz+MiAP0smm?=
 =?us-ascii?Q?KfyUtjXybKt79ug+Fbt3Z+LuF/cN2NsNCuv8Yj3JPmf7jdLuRyZOBMyzE1x0?=
 =?us-ascii?Q?02AUmCWVvx/fYrariMazYI/FfZY2P1NBELutY7VtfSifwbBYX0NhXoFOZPNv?=
 =?us-ascii?Q?4bXsjKnpoVyeaYf2b7woTGkUKQRMOUI+ZDnSAKS/At/w2qZz394THpdOrcDI?=
 =?us-ascii?Q?Pvh5k01vPRBCEaM8FQGkHwnKmgQ38g1J2HOJbURiuTkLoC+aldR04vnfYDHX?=
 =?us-ascii?Q?12oi9mKm8cVyHHkCzmYdPTsTVGNtDdCBmIwEvfGLTykt52zcdRIuk0hAceDs?=
 =?us-ascii?Q?af8WpC9bMDCOZtZKQcZLn8F+cUhsj4fA9MIKiaeAjcQf/IPrykHYd+mOJcmg?=
 =?us-ascii?Q?oNhdj4efWNCCrgP3ffDw278OvlsY0DqGOMGxBuHO27OYStSpC83snIZjGx6I?=
 =?us-ascii?Q?kuxbb6g7vGe/6krpYF/f35jxRQFhzcRvDD4+VfUMi8Z2tZtVyS8QB8TXqyUD?=
 =?us-ascii?Q?YVKWt4zzximAfo847tk4NMQNl0z2HksceLg4dfRb1lFhla72SI2pfVnj5Jws?=
 =?us-ascii?Q?xW82b0h7qSDYfRo+rCAFPExiyGpeOHkFgeCMclFKygiKUmdPi936aLltBiVK?=
 =?us-ascii?Q?CnmN5IWiKb7ZYacKP9pApQXZcw5Ldd/5xH3IWUQ8ROoNlp/OqiWamy3IdEKF?=
 =?us-ascii?Q?27JHeJnpJY3BMb2TzwJfYeq2IAToL0Tt4YwJB2FvvOPU2RfqWJFKDqJ638IL?=
 =?us-ascii?Q?mwc2crMBh0pKCuPYHfdjBoNAVsANsyn5bb9JMWFTzFbMquK4UyJ/I7iS/YOQ?=
 =?us-ascii?Q?o2bchrf5x6zXNsdPRj8XIxxclIQ+RLcToF3kyFGtGZadD1ksjnvgJ/CNOcYU?=
 =?us-ascii?Q?xC0w36njm66HJFGMQe51RGPbUGs+HkoLt1H3CHD8/lnwCaZHGx8grFueoCRc?=
 =?us-ascii?Q?12P4ICDqMkL277Evp3D89pkVjef9TNzO5FxgSlWfDJmNxeVD5MwKxc6bCkvs?=
 =?us-ascii?Q?UsOu2X8hlr3ogvs6y/g+keE9hzAV0jHvVE7X5LYlqs5fuCWOu9cnquX3CLXQ?=
 =?us-ascii?Q?Qvyk15+cQwHZXlJwwphrUC4EcdlZArBGTDrCr8sX3w5Zh41UsIJKxsKf1JE6?=
 =?us-ascii?Q?UbH4wtryb2Das0BpjAZBJnNRTdZ8YrMjinhjBFLox0aBxyJR9mImp37/lFnx?=
 =?us-ascii?Q?gDrgGVxuHKvofUdEOesdF0iAczKSp10NzOZ8N9RnlyCqePX2shKwZStbnaIN?=
 =?us-ascii?Q?Yb2qzOnhOy1yqQRnHO4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:25:33.9251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71101563-49e3-490b-c6d7-08de2218de7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059

Also change the define to use GENMASK_ULL instead.
There is no functional change.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 2 +-
 drivers/iommu/amd/iommu.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 4b4a37fad70e..bdd7d5f3c4a6 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -353,7 +353,7 @@
 
 #define DTE_FLAG_IOTLB	BIT_ULL(32)
 #define DTE_FLAG_MASK	(0x3ffULL << 32)
-#define DEV_DOMID_MASK	0xffffULL
+#define DTE_DOMID_MASK	GENMASK_ULL(15, 0)
 
 #define DTE_GCR3_14_12	GENMASK_ULL(60, 58)
 #define DTE_GCR3_30_15	GENMASK_ULL(31, 16)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3505a14a4d2c..02cbe82ffcf1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2081,7 +2081,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	if (dev_data->ats_enabled)
 		new.data[1] |= DTE_FLAG_IOTLB;
 
-	old_domid = READ_ONCE(dte->data[1]) & DEV_DOMID_MASK;
+	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
 	new.data[1] |= domid;
 
 	/*
-- 
2.34.1

