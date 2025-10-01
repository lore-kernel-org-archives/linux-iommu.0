Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010069.outbound.protection.outlook.com [52.101.193.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF292C3251
	for <iommu@lists.linux.dev>; Wed,  1 Oct 2025 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299026; cv=fail; b=BcLSioMnVY+vvwpSKhqLU6xEEIc/uYRlD64L60/tvQLRTi1E0XvOMJOSH59cyIDdELYl1Vc+lu0bhinYYXPtcTYgI6Gb5SL3I9WdiCK2KbCoMvMLJY4BopzvYgZc3HvOVjHbrKuS5a/ZVqLWctzeqGVgx/3zcV29d7gVYbLJ9lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299026; c=relaxed/simple;
	bh=4MAtmWM1xdi9cYc8o6ooSRP0BUQzoAOT66VrfCeweOc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FK8i0GLpOL03yYCJdIeVgKioDnUTP9AISJ1EHM7QX/jcxdOVxt+kgEXLVehhnxCS2G+jMscVKLZNgV9mENRaUiSm+5ELgFoQ1iGY/DzJfK6oIiDNiihOs8RccVme2S5FPFjoLCYGk6lMLVrPydJlqBYEh7+lKf+3Kl24w8eOsQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OwStMM/k; arc=fail smtp.client-ip=52.101.193.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OwStMM/k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWSlit1uMK5vR44oQFqBTv9Yyda0HtrSuXwvzrM4HTSMXn9l6c6YpiFwJ7Dug703DP7pBkpSlqAAFSXPqiZTXbFDORRibCdwj2TrW5e07tMm64l/XWXaSCc+CctLq/LiYAH0EX/WKIVo5FmdeJvWSUeTgL3Xg4HaA+NnqBp85ZYkZ+zy0X8vCcXI/oSjDsPd9dA0RKEJ5h0am+5e/Ciw3YS97gTMgulslgG58QhG6TBz+Xw9N4+MRWugXOv2sZrt9GAcfKbi66iVG6m9BNSg5S918nWuV7ck8o5BwgFvZF25FcQdOKY6BDMu9lfKGSmF9bnGSs5d08hk7VasdTvNVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2CLg3jTy517Rf/fw5SrYyKBJHK5nyb1Dzqza8jNbCM=;
 b=unttBuKs7g5S3kp/L5SbXG7luuwzvNPuIBqUtnXpivkSllTsBzIqzVeIgPXWcO4kefUf/za5dd6DAC0RWTv6woHn01ixQK/Xxh4BIts1EppiNDhfOGI7VhvOvxH3QjVAHp3N25y+a2M83L5b9kUKGHoOxz2dWq873eSaOrb8sVAgGFhjgO0m3NZyxKV8LImOKbc2F2pXdtsvUAQ0Q0fM9LYBsTyeuLI/VXcLLdcWs4UH2EWufalbyYC0ET+LT3Qe6Bg5siZckJklM2rYDYmmB7X8bqWMn3I6Msys9jRAM5t9raSv8HoSr5YuKeaAkoIdgXAOcT+qBCSM6znHZOzH1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2CLg3jTy517Rf/fw5SrYyKBJHK5nyb1Dzqza8jNbCM=;
 b=OwStMM/kj7H80hr6vlPzRu8UVRseX7AG71K+fgxSYWdJlmvylRprbdVIiTu2RT+iFPmmSbCeyBYBE8sA45UhTe+fT9j+UvEkQLY+NTwFAL9dFoLXij7abFUgHOiZZzCfgoJH2nuVb+/tEbZf1yIAf+NA+t6EEMUr3l6mjAI/FJM=
Received: from SA1P222CA0117.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::23)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 06:10:20 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::60) by SA1P222CA0117.outlook.office365.com
 (2603:10b6:806:3c5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 06:10:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 1 Oct 2025 06:10:19 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 23:10:14 -0700
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
Subject: [PATCH v2 01/12] iommu/amd: Rename DEV_DOMID_MASK to DTE_DOMID_MASK
Date: Wed, 1 Oct 2025 06:09:43 +0000
Message-ID: <20251001060954.5030-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e5b334-ce3f-4cbe-2524-08de00b13309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?07P6wx1t/Y+/8h+bdxsrLZSfRodX2WKTxI0zOZL8S/G41eG8nirN5CXFie6W?=
 =?us-ascii?Q?0/vimySLz7R+oJrdN5OU/DQaLHTqXY3tC3ngh+kyJ2WFjQkHmZX6e0vZktn9?=
 =?us-ascii?Q?/NX02y0BXzSBM5lvSWTT8PCdJjqC75jQi5DCyMySWX3/HqSBBTzY0tpkAVOF?=
 =?us-ascii?Q?52gK2i/qSGyTHV0ByjftjgDCC61GnM8TZzRWQF1iRe8w+JwYZpP0d3CycV0k?=
 =?us-ascii?Q?ZkREdDFwPLusy9/cXVbrPQKvjs3NzVhV6kgGLges9oxRa5mGYZR0MmKwyrct?=
 =?us-ascii?Q?um1c4YuvdxgDAAV1N+lUPScL7J9dBRTNS1j7F8bWqaR8zQPtcgBHvMBUklr6?=
 =?us-ascii?Q?ghoCYHFhUwn1aB5EixTNefwTdyTc/HYcuYW0UdRCy2ijgwfvk1AGI3L9J9HM?=
 =?us-ascii?Q?JY3KGfPETFPG3qAmIfOk/QT6ozPjf+tlxZnHsm+2BWDjBh6sZrzbf1HsK7GN?=
 =?us-ascii?Q?6HK1ehp0MkrdxFm/JYx6FEDhCtfUbDxXCdmWqYJSQudalOGMdfHgfe/lNLwr?=
 =?us-ascii?Q?X+5ze7+7BryVfuT6WKUujwiZLgCCjInlm23Vz13E7KzT8ORsdDWZntL4f4W0?=
 =?us-ascii?Q?GngKAT8QhzteqkCgnN5ooiVmSm7QzUIVIjSTSqejddVZCBUSzQfRggQ+cP/t?=
 =?us-ascii?Q?wfSbwzLvVvFp8pcCz9yZjPqnmyPevtapajq/DO1x/cc9A6FiEXZ5OSNOW1rw?=
 =?us-ascii?Q?UxbEtlkerkz6+OMpn5dbY53WloXwjSm7C79AbQj4erRm2mktjqkiXlN1hF1u?=
 =?us-ascii?Q?31hud8E/d8ZXNVsXkRTIPDkCMNnacVdi1vbN+yeDPgQsQyQ3lV5LX2Ky4QsP?=
 =?us-ascii?Q?2H+9FJLnMiNkjrVAwy7QLoC5AFqOpFnyG+/u/6PvevBwHRo8tumma2Bh12Js?=
 =?us-ascii?Q?b4fajRb9VgSXezQf8UNjT/29lthhENJ5Ya4w28Rmxyy2580GLcUYsJNOH/ua?=
 =?us-ascii?Q?TJxIOunjPpHHmedYAlOYV9YTLL+TVzpgTSjvAWS3+ezxeelldALJNIk4rSmu?=
 =?us-ascii?Q?RqU4B2AlUJ390+wsNOiPZhGKXyfphLhQTrm0g3BMjS9pZFW2/vx2WlwxSaKD?=
 =?us-ascii?Q?jx90Mh6gf0Zyqkats874UQEYnwA0rJACb72z7BqZxRI0VtsdZzBRiAYYQ+0Z?=
 =?us-ascii?Q?lt3zp0Nsbm37RdWpVgb7s8hQr+H8JzOkKOfGWk7opbY9PZh8qLFnYmJgzG83?=
 =?us-ascii?Q?H7tP45pLLhfcPuKKIUtAC0340IoQtMDlDNHWiXFmc32Fj+6qZX7H+HXwfq7J?=
 =?us-ascii?Q?KFXGqtqBHow+8sMc4W23XzZqT9XYFbrIe0x8TEENifW0Xfrwwg37V1FJVnXf?=
 =?us-ascii?Q?f9fsBk+5xKtYoSfPlJGkQoFSWw0drnegyzgRxvQ8O+LPXvmpi5ITiIL/g3bJ?=
 =?us-ascii?Q?Lg1sDMtpvJcFSSg1/QcZE5FEuGcjBYWqkCt/4h/APMYgYfL823Td7lg8Ad1L?=
 =?us-ascii?Q?c3XBrgIO3SHSc6rO0XmQHsj/A5fX14Cm6hfx3UQ9J7WLXtdcKSv+ThpSJ0dJ?=
 =?us-ascii?Q?e6gODo2d+WG6mTfGb1UTQwIswkWQ5wuNcAjueNo0CmHKj6ULl4BXeX5FEbSj?=
 =?us-ascii?Q?AP73yqCDvLugtXxxbfQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 06:10:19.8022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e5b334-ce3f-4cbe-2524-08de00b13309
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288

Also change the define to use GENMASK_ULL instead.
There is no functional change.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 2 +-
 drivers/iommu/amd/iommu.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a698a2e7ce2a..556f1df32d53 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -422,7 +422,7 @@
 
 #define DTE_FLAG_IOTLB	BIT_ULL(32)
 #define DTE_FLAG_MASK	(0x3ffULL << 32)
-#define DEV_DOMID_MASK	0xffffULL
+#define DTE_DOMID_MASK	GENMASK_ULL(15, 0)
 
 #define DTE_GCR3_14_12	GENMASK_ULL(60, 58)
 #define DTE_GCR3_30_15	GENMASK_ULL(31, 16)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b57a6993179d..a9b17d31a969 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2094,7 +2094,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	if (dev_data->ats_enabled)
 		new.data[1] |= DTE_FLAG_IOTLB;
 
-	old_domid = READ_ONCE(dte->data[1]) & DEV_DOMID_MASK;
+	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
 	new.data[1] |= domid;
 
 	/*
-- 
2.34.1

