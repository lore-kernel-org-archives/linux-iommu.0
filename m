Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010030.outbound.protection.outlook.com [40.93.198.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2EB357A5C
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971974; cv=fail; b=oAgrtfo7ZjuqQjkUm//rvNVwCbXMv3S5l9nj4GEqARvFN/2xIa1rkhdJkjNTIYbH/Mk9s7fhkspjjRAq4KB3AZO/Inx9F3657/Qc6iQ2tRb92o6eGD+ixnFeRA285LuTSEio9nR0qEA9bp+G1DwepiX50hAwACSaSiGMvWXwNz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971974; c=relaxed/simple;
	bh=c65gMbs1znME3uAzIh8oSwVYrmfhU1HhK/OAMiwprZ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orqzvIXySpAERlB1EAbdzN4/jS1GUZbTjLlC1sfHwE0mPUABaTJ1g27KWzqw9dR6+NBa240Xd21ALe1O8nCAGE44pCJxOYE+d8n3Gk9royFfMGnjloh7oT9AJuZENPa+4YSK7J8oxxJD/u1jbgR2ENy0meXarCZ9nXZhVzyR0V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bby0+pCm; arc=fail smtp.client-ip=40.93.198.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bby0+pCm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXmp4MEcgXvH1fgx4dwaoPRpRhk7KC7t+no9YYui+Rb2w4kXGtXyN8K+KvOezy1TY1lTgRjxNpTHbJ+IOpy99vNdKlkWafRu+5H06Yhw4NAEvYbzSZ882aknQJXqXjxfnyQMwQFdKeFqm7SckT2znphZ1GH+Tr2IQoJ3MszbfKpfPZQ3M/GZmA3Uq1bt4dtPibFFqjMgysOdkaV/Jjc2d505GACKedWqe8D5EC58Mn09o2Pm1vPcBHL2SsdzrOm2asT8RNNM5fWmVto52rftzzW5vRYqoWIrIg4zVX7Y/rn26EU//utCyxptSOTwjAugx5c04bFaHbF1KeCCHCPCVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CFNwmM5tVr97DreExdH6BfKdq1WYPyiocE3RbvvsCI=;
 b=YgOXACWpjGlJZlRzREDwVL6Ag0SXHmIKeioAswrAuw1xsupaQrw9OItGJl07FHmwR+IsIx7S+7LnVEFpkBXwMl3IEkMPOlHn3ke1GSUKrpIu+wp2PtMs9sqhv72UwzMfsKeZce2TDFfdKP2tcetueB8uqQOPuiW+PABpW7OUekRblJ6mgVPmjo2XmS5KVzoSpHyblntnqa7ZhIhHDWdXnqjQCDzFowWnwz0gD6eDc0XmI3F/lbkaMFDd65sNNlmbJYfVgWCYONevYpotF8KGaBCYlc+cVLb90OYUEj3F1SlYA5xwURWM3Krncf1Ay/QKpQTAaFGhqw0uKpziKVnJjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CFNwmM5tVr97DreExdH6BfKdq1WYPyiocE3RbvvsCI=;
 b=bby0+pCm93H2o+6+Xrxgx69H/ctnzkOlUz94VydO8oXb2475SpJK9ruRsbBbejLgTORWB5ROktd6rLdu+SAIz+eM7pQQtOWdmEI7S7a5no1lD6jI7ggXgRYh2Fxq6Ovv4CKkS/12cXoe0IjzRpeFnxDMyR8uL1HJQjteXoNaPzg=
Received: from BL1PR13CA0115.namprd13.prod.outlook.com (2603:10b6:208:2b9::30)
 by DS7PR12MB9475.namprd12.prod.outlook.com (2603:10b6:8:251::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 18:26:07 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::2d) by BL1PR13CA0115.outlook.office365.com
 (2603:10b6:208:2b9::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 18:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:26:06 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:26:01 -0800
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
Subject: [PATCH v5 07/14] iommu/amd: Always enable GCR3TRPMode when supported.
Date: Wed, 12 Nov 2025 18:24:59 +0000
Message-ID: <20251112182506.7165-8-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|DS7PR12MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: 60078cd7-be7a-4c96-fe88-08de2218f20e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kcJKfiA7//ntqKlNMwOTtkYuFPUBU2RvFgThcB4ut2i/TR6VZWa3bzXz74db?=
 =?us-ascii?Q?4kM5QkzdJ0yYTuIL5kM50uQ5ka6WbTWLURLVQHFjANjY0bT7c/SJEjk9CW9u?=
 =?us-ascii?Q?rq2zopSodCQcBl1ZloNFrAUXbkWC6bhPD8kOo5xgOh6F2cFDVuIet2sXaDTo?=
 =?us-ascii?Q?CHANsjDaWS76QrNsFAV19dCxejhuPop3RGNuR/N8ayG1TB78FRnpErtiJ+hO?=
 =?us-ascii?Q?/3V8MzDAeQuqSqov7FMhOiAiAGOEo6Zb92s3brjhiaKIE12ugqm43QiyPZih?=
 =?us-ascii?Q?bXV2btMnXNm9iN/zdTBQOOnOjEo4sG7s4Q7xfoEv2toVb5qRxzJpVueDbjvL?=
 =?us-ascii?Q?tF82vXbPdWWB37UjKoc6sfqRP/VGC8A8I0d2rrlVvHqsSyqvasbC3t2Gur2H?=
 =?us-ascii?Q?+glD4zmq02ng2jg8N3zeTS4h/Ww+XVQcBTqr/CGA13hK1OsYPyAPAVJx7xq8?=
 =?us-ascii?Q?cLYdnmgKXuAqanKqrKCjpcTB8wEMBuQLkkQF2Je+RhOnSj9W/opXG7PWjXEN?=
 =?us-ascii?Q?0N/lfSUdWr4fmWkCyUWWvhIps06ooQP55Wv3h3DqTRsCjzzWnAZJ56P+gy6D?=
 =?us-ascii?Q?XRIYEwobICwlDOyu0rtV8jESvzfJp2HbeooJZA3eDr7KaJDPi2kSV7bxeD72?=
 =?us-ascii?Q?cnS0OQ5gFCpbaYVxu0oj4gMm5homVJMhWKJQbS5yGW+SGPvoRk8kovX97esz?=
 =?us-ascii?Q?7ELHaKSeL7SvTtVkQVyicwrqJ5alO9xbp3/ZfZZ1KY+CiO1R30MOaLNePSVq?=
 =?us-ascii?Q?kPRau5qMBdtPcGdmQoXW7MV671Mb+vDkCTCX/Ndug0jH32wNcxuLP4MhcRsv?=
 =?us-ascii?Q?CtRZ6zdlitBVKd5RW/yKmbTjxlrQBQwaE5pBFaqLAwRUsaNyCdlmdIbXfO9X?=
 =?us-ascii?Q?snNbpna/qeP4E7hMMsqXTLhFm7OYQmBDSYZt2YfDEF4aWUGUgYNtmSzO7HNn?=
 =?us-ascii?Q?R2ybYK4/uXY1/WndPKWrcpOqfD2a5B+mGoW18E8VGLfMpop+Mo4lByZVgzbc?=
 =?us-ascii?Q?TjoZbmaqu1VXZjumWVmHMTMtGh74/XqeVgBF/rHxun5SPQD8s+sFsm51RL8x?=
 =?us-ascii?Q?y7iFffdgUXJ0nCtUEMlyY0Eof4+mNNSwkPserIoUUFFF9Mzj246e7Z51MrkS?=
 =?us-ascii?Q?HOMfV8WLidHowc/AOx/Y0BlHhUEgYAIkYQvusBRS+yuL4Gk23rWwVEXjgndo?=
 =?us-ascii?Q?KIwZF9aBeSv2Y5zASVKNmUambI6rGFfkPnduK9jzBRUHYoC6u+ZbTB7JkvzJ?=
 =?us-ascii?Q?aDeneYaQ/K5+n+HFNf9tYywOr1J8fQtIsVHwwCdVxJVwb1MbEcU88y+szfiF?=
 =?us-ascii?Q?y7C26A7kS6+RN/IJZm/e4jsjVmIKp7bEVsNXaq6/P01ZEyanuVidSFc8JEiM?=
 =?us-ascii?Q?DGKCKkpG40lax3ETMEKHImdpPs75KxfFbKXYTshupBmiBEb2swiMC+ZU5GTR?=
 =?us-ascii?Q?In+3EJWuU6LK1nYbNL43wXxSidxJvhcMhn0dLAPQWKF3EZMLUyfEULOsx6ff?=
 =?us-ascii?Q?g1fmxXO0EYZiPqWfaIggc4W4IFMPgxM3YW6AzHV90kv3yKu6+FDst+sRL8Li?=
 =?us-ascii?Q?ccSCN4PqOATnSRY6sUQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:26:06.8379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60078cd7-be7a-4c96-fe88-08de2218f20e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9475

The GCR3TRPMode feature allows the DTE[GCR3TRP] field to be configured
with GPA (instead of SPA). This simplifies the implementation, and is
a pre-requisite for nested translation support.

Therefore, always enable this feature if available.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 2 ++
 drivers/iommu/amd/init.c            | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index bdd7d5f3c4a6..d13a50fc209b 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -107,6 +107,7 @@
 
 
 /* Extended Feature 2 Bits */
+#define FEATURE_GCR3TRPMODE	BIT_ULL(3)
 #define FEATURE_SNPAVICSUP	GENMASK_ULL(7, 5)
 #define FEATURE_SNPAVICSUP_GAM(x) \
 	(FIELD_GET(FEATURE_SNPAVICSUP, x) == 0x1)
@@ -185,6 +186,7 @@
 #define CONTROL_EPH_EN		45
 #define CONTROL_XT_EN		50
 #define CONTROL_INTCAPXT_EN	51
+#define CONTROL_GCR3TRPMODE	58
 #define CONTROL_IRTCACHEDIS	59
 #define CONTROL_SNPAVIC_EN	61
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f2991c11867c..a61111c2aabf 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1122,6 +1122,14 @@ static void iommu_enable_gt(struct amd_iommu *iommu)
 		return;
 
 	iommu_feature_enable(iommu, CONTROL_GT_EN);
+
+	/*
+	 * This feature needs to be enabled prior to a call
+	 * to iommu_snp_enable(). Since this function is called
+	 * in early_enable_iommu(), it is safe to enable here.
+	 */
+	if (check_feature2(FEATURE_GCR3TRPMODE))
+		iommu_feature_enable(iommu, CONTROL_GCR3TRPMODE);
 }
 
 /* sets a specific bit in the device table entry. */
-- 
2.34.1

