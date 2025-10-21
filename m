Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CE1241114
	for <iommu@lists.linux.dev>; Tue, 21 Oct 2025 01:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011181; cv=fail; b=HExPk7a/o+b3xXsCjqXZvkNUBC15XQEcD/INKP1oYbNUYERMV0QlAXeuuC62LuVcws6w3Tisn8guo0fYnLpE4ZfdodWbkaQ4avVRO2OatutE/Gl48hhe/6KpytZatxXWht82w9ysqsi5Oz2jruHFSNOvbPcNNgVzOoRHgj1by7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011181; c=relaxed/simple;
	bh=sALhf//TfYwAFfAhyhFGMNvp7NF84JhyQVD1er2NHCE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Huzyk5t8XI84e7M2snrEGukBIFiSC2kHT8Tt4VdfkJEu0aGfpD+ai/fFBi4wFzK9sPSAILeA2svTHb4JK7tUAxS3g5GVJiEoCmRnpbEPXSotvp24Nps+dDGqupfN1p94T3b1A30gPdavOO+ZE7ONtt/dEGPGt1KJARgdrnCcpgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xR/Nq4a1; arc=fail smtp.client-ip=52.101.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xR/Nq4a1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zq6hHXEXZFIDLBXBY1QYS9Eh3ZI5SgG8S+kixzvK4eDxknxnIwUVeIvOCuxjBLot4OLnt01HglxFBxJEgCENJW/FTk6eIiJF5NOa5YepXTf76cKy402Hoz4hK1Go3a7XXQ3Uvnw3X2zJI8dYZMzZLiHw4HlVN1/wJwhHDquxDnQ1emnn0xA85fVy2xBP3LxaDP8HZCL4GC8E4OCPp03uMnQFIEkvSisU62Lx275Ean1tUx58arXmlf0J7ltPkWJNWwLq/IsssP0J42Iv/6fXK8o/YMNb9sqfa5NxAtxUpTQveb7Ox6Bf6qMFlGSHNM6+cqJ04Hb36YYfau8HVJgEYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16HP75giA0uC00BIN7NbDVbNHlFVvLYgQBdYfdo8t0A=;
 b=EF1BGWgoPYvVUcJ6yqrSuxBLa/U3qO3Sr6Hv8vSvZqUYzJ/0+m+a4fL2CCO6npt+Ta8pYUCDUWdqMcdKbAg6yydueCwQAa3ALdMQm0rwpCKE3qMjwiGHxhoIIiEq7D3x4Z/FcDaJgXi0+bFZE4NUp3wlQIzOfAejB++tLeyTuxHp/p25FN1Z4Qc/vTh2GyHjCbVa0bqJ6td5TQLOgesfP47iTCvRbmFrC1vfHgKM22K80NLNlyV9vmNdPkX10fhC+VrRV8BueAKYe1Wd9yc34DFH05fTUnk/plWJlJJj3syfFyunOoNroohNoa0VZwB7ziJFpk9le/+nB2l0EKjldQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16HP75giA0uC00BIN7NbDVbNHlFVvLYgQBdYfdo8t0A=;
 b=xR/Nq4a1t/W5Gnou0YhLUb3tMf8M5QdDez2E8q4cnzJVeMZvsYsONA/LjyILvwlDZ8JX1YEvbjLZD3hKvJHbSNlEsxfzjqQeJTZ56TsmnJIVCCC7yvtK2asgoUnLO2dcoHn49HbJjxZzQmYSrZomt6NAoXntxzhsv32kxmMCqW0=
Received: from BN0PR08CA0017.namprd08.prod.outlook.com (2603:10b6:408:142::24)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Tue, 21 Oct
 2025 01:44:54 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::bb) by BN0PR08CA0017.outlook.office365.com
 (2603:10b6:408:142::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Tue,
 21 Oct 2025 01:44:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 01:44:53 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 18:44:46 -0700
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
Subject: [PATCH v4 11/16] iommu/amd: Introduce struct amd_iommu_viommu
Date: Tue, 21 Oct 2025 01:43:19 +0000
Message-ID: <20251021014324.5837-12-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: f45fc38f-66bd-411c-abd3-08de10436eb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LvUeVYEj4agvXxtP2kgPKPK1HkvsFXi0raY6GMFkMmCmd0ys0uR3oTrcsPyH?=
 =?us-ascii?Q?5SZ+356NtmunOE/rtDf6U0o9+bRH2NnSzqW46lQtXntZ+zJDrWUKUlX00Ur+?=
 =?us-ascii?Q?Sz6H++YSH8H4VCGfCrPi4sMXd4e0ZYXvkjVqoZ4xZ5wS0GAOJSqeeQQGWsRb?=
 =?us-ascii?Q?B7WcjaJsh8p+CI6CiC9GMbtB4iYwBahXVF2XZi/SNYCYKjJz7XsS1aaYajx+?=
 =?us-ascii?Q?OXvDezBzc9ty84QDCcqeqNlmbRu/uSJnCDxDVWxxmv4NbgudkmXmkS4MCLw6?=
 =?us-ascii?Q?0xA6lcO9akWwdzlLsvoXvRmjE+JymmRaskxaMvPlx06O6orggqITX+6Q6EUH?=
 =?us-ascii?Q?98IAaHxinvQlSZ4m4V+0AS68yw8kONJZFxeGXr/wUF68scoLfIZueWJZpTqe?=
 =?us-ascii?Q?vSV9DlBKv4pklB3HERJG6U7tA2yEE0uWvA5cCXLzoxlaJzYrhk/l4q/lUclJ?=
 =?us-ascii?Q?Tj1bFN4H0Vge3TGoy3dwqTj+RJiuvHBchr5H/DBfKCb1l1ZKKwYg1hZ3m+ES?=
 =?us-ascii?Q?LkS8EuzWMNnNqBqVMrf6WYVat4wvbd8+wLcBFdRJkQpY2QndDZIv2YbYu88b?=
 =?us-ascii?Q?BgUHzd9ukdfyt2HEuvGIaqX/ttUZs0WI+0GzCgubW7pyBH9mkmMWdZvgQ3qk?=
 =?us-ascii?Q?dFwOqdOJwW6I9aUU+9oyGii1XBS03oDWL1iQwgrMAqUlJwnVCP5CRrPn8Rcq?=
 =?us-ascii?Q?y7ZCHVqg2nXglvmCEE5kJEJyrsrgWXmBIcDJT3m/RVPrlTEbx5v8bL8i9vPv?=
 =?us-ascii?Q?tMglrY/0oA+5p4llHy9bEiQptR2IZ6cDMsoz8kCX6/9vVLFWyb17Vi6q9v0T?=
 =?us-ascii?Q?0KkE9cyFaus8mE3an9fHJ8/Im3YSgOvK2Pt69d4i0GKxhC+IXf52282D1Sjl?=
 =?us-ascii?Q?HhL1wfj1onMz3L6hwItiPWWcL+RnWLZSguyWXtvVPJmn0+Y6vDylRlRYVctA?=
 =?us-ascii?Q?b1uOc+IxeyQV+M1ryrSN9CwbIw41ce0daSeEaopMCMvTUkC21QRw39A/+szF?=
 =?us-ascii?Q?M1bW7SXBMZkjEFgjqwXsLgtEMzBkE/tcGZ8PMrIGHMoSbz003qiic1QVTibg?=
 =?us-ascii?Q?1bE36Xji/25soh8STbkEdQMlu8GhuDn89M9ZcXjEQrxOlttOR4xuxpPneNKa?=
 =?us-ascii?Q?7LhrB1sOldFJLVJ7QKMsEjToMI1g7URWDOXZFx3+FZqSiZ1APTBOIxre46uB?=
 =?us-ascii?Q?V1wv95huc5OAOqMcrZ6jNmHRnJIOzgvaxNlMIQg95uJ/Etzq9MnGr2pP/ixg?=
 =?us-ascii?Q?dSdaFbfEjjv6Xsn88b/S4cyDPf/2PJVR4byTCFwmKuhCt1M+RY1hARqxFGuh?=
 =?us-ascii?Q?0scbEeQiBogpqQn51h6pypTBZ8hM869y1QfdZtBnhmImKckh99Qoa33RSvnT?=
 =?us-ascii?Q?M7p7n8AtGKCy7RzoDu2vLYxh4iBBqztPQ8twPBmRaGhYRqMsHDCeJrNDjhTr?=
 =?us-ascii?Q?Gp4mzwgByTkcZSeu6xSqVq1UacsiMF1n5UNgAsAVl9lynFZsEJ7WfaeWG4I6?=
 =?us-ascii?Q?aN8h/lTdMyMTlOX7iMdhM8KiQtvgbgZRPpj6HWrbPHUrBoPdIzTdvPOsT0uB?=
 =?us-ascii?Q?/DeXNP+/At05r0+e6MU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 01:44:53.9216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f45fc38f-66bd-411c-abd3-08de10436eb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112

Which stores reference to nested parent domain assigned during the call to
struct iommu_ops.viommu_init(). Information in the nest parent is needed
when setting up the nested translation.

Note that the viommu initialization will be introduced in subsequent
commit.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  6 ++++++
 drivers/iommu/amd/iommu.c           |  4 +++-
 drivers/iommu/amd/iommufd.c         | 17 +++++++++++++++++
 drivers/iommu/amd/iommufd.h         |  5 +++++
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c34604cf1811..a0c7e7329233 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -17,6 +17,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/pci.h>
+#include <linux/iommufd.h>
 #include <linux/irqreturn.h>
 #include <linux/io-pgtable.h>
 
@@ -586,6 +587,11 @@ struct pdom_iommu_info {
 	u32 refcnt;	/* Count of attached dev/pasid per domain/IOMMU */
 };
 
+struct amd_iommu_viommu {
+	struct iommufd_viommu core;
+	struct protection_domain *parent; /* nest parent domain for this viommu */
+};
+
 /*
  * This structure contains generic data for  IOMMU protection domains
  * independent of their use.
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e489e360bb77..c4ff18adcf03 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3077,7 +3077,9 @@ const struct iommu_ops amd_iommu_ops = {
 		.iotlb_sync	= amd_iommu_iotlb_sync,
 		.free		= amd_iommu_domain_free,
 		.enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
-	}
+	},
+	.get_viommu_size = amd_iommufd_get_viommu_size,
+	.viommu_init = amd_iommufd_viommu_init,
 };
 
 #ifdef CONFIG_IRQ_REMAP
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 72eaaa923d04..5ba50799a6fa 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -29,3 +29,20 @@ void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type)
 
 	return hwinfo;
 }
+
+size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type viommu_type)
+{
+	return VIOMMU_STRUCT_SIZE(struct amd_iommu_viommu, core);
+}
+
+int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
+			    const struct iommu_user_data *user_data)
+{
+	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
+
+	/*
+	 */
+	aviommu->parent = to_pdomain(parent);
+
+	return 0;
+}
diff --git a/drivers/iommu/amd/iommufd.h b/drivers/iommu/amd/iommufd.h
index f880be80a30d..f05aad495b5b 100644
--- a/drivers/iommu/amd/iommufd.h
+++ b/drivers/iommu/amd/iommufd.h
@@ -8,8 +8,13 @@
 
 #if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
 void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type);
+size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type viommu_type);
+int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
+			    const struct iommu_user_data *user_data);
 #else
 #define amd_iommufd_hw_info NULL
+#define amd_iommufd_viommu_init NULL
+#define amd_iommufd_get_viommu_size NULL
 #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
 
 #endif /* AMD_IOMMUFD_H */
-- 
2.34.1

