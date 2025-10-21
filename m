Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C6C26A1AF
	for <iommu@lists.linux.dev>; Tue, 21 Oct 2025 01:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011089; cv=fail; b=Le0LYXUPthjuelsApUkXHwLZ142HMQ0ztSNobBxD7n2+tMKNSe03x6gwRbX3Z+omwNQE44xaMd5if+74Nx7MTRuCX4syXizBm++BRbXa8efYMhkv14FJoPckKPIKVLRoSjruX7QY6mgHdZChWZBPa5h8JZIccOP7Waqb2jfDvDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011089; c=relaxed/simple;
	bh=+D0Urak2/zcMD8VDUmb+pJYtaQDIISnAAo2k/9kjH/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UtkNadCmiurGbJP/ymzQmu2RbM2B72weQfi1UaT2K1QBlKolbAsOKcB+Q/0U+cvhMRNmOgjNfVgOfYg5+/d/dUvqgnb6SuiXZjYU9XDTNBilkzqtXUKCORHdzrqpcIDKZozJd3W3CT3U3RRVo9Qebf63SqiFq5/rfhBfnLSvomQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=amjwlMpP; arc=fail smtp.client-ip=52.101.48.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="amjwlMpP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgUkTAJ2w+EJw+bJQn32zv8mXoTTHPbV0bguPgl5VST/3xGv5eXGBQ9BCM/BCd4zxd3Rt/x9Tg/0id8MetgIQPT/K+KGLfJvVU/yFLAulUPhLi1di51BfUKVq1MOhIgJ6hOmuqCD22JRWxB8SR6CE1xx4lXGvwQjmIt1rcrofq+Wz8wCxy38XtwFqi+NhmQ5DuVsqtA+3czwHxolWnSMINLHXTjNeROHa7PMWsVahMDpWg9E18E6C846wm3StxVtSRkW3livWWsz/937FYV0cSu2H8+fZDcfawTG+9X3uJBOi/eWPZamCPPs/noXkQoeN7ChPaIPaZbJMkmoRT5ukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQkED1yVrFu6Yt55AMyu79lb2BiaWIyntOj5bGxbMbA=;
 b=jTcfESatolLMikOP2/TUOJbdd1Bw/dSrbTN5OeKys+y8nXGu9W6og9PApwQTvSWc9k1QwMgtfeZP4zJCXJWfEsH1J3cDKmFhEu/iElMd2oqCOb/2mGGHOWrR/rF+VV3B4Bv+qQfVjwVNS+2zfGNUCblg6OkGCdAz7nMgke9/08mYud8qWV8yq+mJdbSpHvobh5DNJ+mD+lIAyDkB1ElLdiOuQngixai54qinSHj7F035tHW8p4RSbH8Od0krl/4QoQFOldVQ0HsDqsqMcrKps8X766xGo9eCBdsRnlcJTNH8hPlcruGU7rJNAUP44jFGQ8khX4LeFz4PHXUv6Ka3CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQkED1yVrFu6Yt55AMyu79lb2BiaWIyntOj5bGxbMbA=;
 b=amjwlMpPcHft80unkqBW1PTgnkQ/udoSpBx0aUWzEpnip7Af+BDZUwiQuOvcMy8wKteAWlFSh1PtuGUlh5JgKiZYPFHw5gOlFp6otxURC1nUmq0weH6ddNfQ7J9mfznywJFkswOs5t0KjrHJPSb1BZWMWDW0Ld9bWx06/ynVQYY=
Received: from BL1PR13CA0440.namprd13.prod.outlook.com (2603:10b6:208:2c3::25)
 by CH3PR12MB9314.namprd12.prod.outlook.com (2603:10b6:610:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 01:44:41 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::6e) by BL1PR13CA0440.outlook.office365.com
 (2603:10b6:208:2c3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.9 via Frontend Transport; Tue,
 21 Oct 2025 01:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 01:44:40 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 18:44:34 -0700
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
Subject: [PATCH v4 09/16] iommu/amd: Always enable GCR3TRPMode when supported.
Date: Tue, 21 Oct 2025 01:43:17 +0000
Message-ID: <20251021014324.5837-10-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|CH3PR12MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: cd94c45f-ee9e-45d8-cb3d-08de104366c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ed2xkVgBH6liVmZ/M92YiXqAPBdPlk1Ir4bHjDolixVLwQdQ6aKZBrEQl5Vq?=
 =?us-ascii?Q?tFTDnE1nTSyN1nl+1nhbACmVKvrgUG+QTM6onH1SH1rZtD+J0cAnqNIQ9lMO?=
 =?us-ascii?Q?zrYreUl7bEUkzbKe7BnyCmrLyGsbPCWmGjqPDgj4gWd7agy0R2VldHLf52se?=
 =?us-ascii?Q?dv7ejM/TYWFKWMiKbJmw+RY758JtwTVnHeb4kkuiK4c39+1WOh6/G9+eBu/O?=
 =?us-ascii?Q?6bNXqkyErzQ78i5SzHNySlOa9Od4U1DV11DMEa8dTXv4mZx73jvggJe+oXvr?=
 =?us-ascii?Q?A/qZMdvUzrq3/izdNt52p3Sq3I+Td2CTzkM/CiLq8hSaygVQgEzufapanL7i?=
 =?us-ascii?Q?wI/xTq/dfM6awA+avfIz4BlKeZTo6+QxMLFv4aVYHKdbKStqiAqz1RPBBRdn?=
 =?us-ascii?Q?iD3H72AZX+SXvOpQm3CFqjpJKc9SD2sBLNOy/iIOQ8afJfckFruv+GVrILH/?=
 =?us-ascii?Q?FIsWLyrW5j5vkZO6ew48Y95XG02YE4HKeoZeOLVmPAhKBVPCd+ra45G0RwHd?=
 =?us-ascii?Q?H+PPKTozRK2oef7CnzVzq7zj9KgZ9eYFBaChQNF+AGvlosIMLXKCWw30wBAi?=
 =?us-ascii?Q?nIp7YnxrDnZ1i2LrctBDB8BMzPaRqRNZxBwFRn0vchHEJ50J6ecSSViidm9x?=
 =?us-ascii?Q?4KQrKqRMsVD7FaelaMtUMGVf1gAPlYI16LC+XuP5xzY1I2dglr75b4mfxnkN?=
 =?us-ascii?Q?ShY1KBuJ60hiPrjXE6kdk1hSlDlpJj38zdv4sPzwEv3pauAXAVcFq303RGcF?=
 =?us-ascii?Q?YvnXuvs0l64pBdRvaMYGdKytIe+u6cz0/XBEmq+GjJm6W25Lg1ReqwVrO3uw?=
 =?us-ascii?Q?PAxHn3C5UzPEKFXSDG8c2ovnvBpFQ/JdWg5Lq3TQlDllLvx/kxcCEVR3jd6m?=
 =?us-ascii?Q?2oLd7Cwu3EjMFnaDWZOlVAJ7S00I39K5WoqXydoUHt4vlJuh3zhIUEW+M5ZH?=
 =?us-ascii?Q?r/9yGzcT3emDJfz8byc6l4Bxrt9enIWpsthhVEjI7kBvAqjelZ8cjxfydDRt?=
 =?us-ascii?Q?GdV+rZpHADUrWA4ue9zlJiibZ4lFnRTLlAlPocjWVctuZD8tzrwD/NgJQtrn?=
 =?us-ascii?Q?p7q3zqzx/yZIhenXrM4xCTcqEW2NQuax55C2wQHOGkHTWc/jmZOxWFkMNIWX?=
 =?us-ascii?Q?VlerTQsy8Y+uh8WuG+DUaZSEb12+8NdUq2Yt1QjbfY7ipygBbzCn0kZCmI0O?=
 =?us-ascii?Q?bsLfL7mXqFH+ChMy36FeGEV3JxsCaIREgjITuG4saMKKnG3dCeu0S4S1lYKL?=
 =?us-ascii?Q?pymsPSkv0Nt1a5JaWpvByWhlv8HMFYDDnuiHQ75EmCJmh6yaeGXMX+PeF41T?=
 =?us-ascii?Q?4wtV5qfYObOBwkdKP0VxcwMvflphV38ENcVTrmPLMYHKKzxFlqvvgGuctY5O?=
 =?us-ascii?Q?GBMT78wet/mBljkwUqUQMVeSIxf89GgWfI1TU3t1VYuGZgKhwiaeoN3vdM+O?=
 =?us-ascii?Q?zGEl0SOh2wMzQRsXu6BQ6cGoE/UMtf0bmQuMQshOjrtXN3z72K/SFLQ3pll9?=
 =?us-ascii?Q?RdRxB/IlUOeqSLPM017qjf5EPTXUXKrq85ZACFJ5fiT3/wjsbMfnvQaup8J3?=
 =?us-ascii?Q?DadqMG9TR0+s2YeEGRg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 01:44:40.5989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd94c45f-ee9e-45d8-cb3d-08de104366c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9314

The GCR3TRPMode feature allows the DTE[GCR3TRP] field to be configured
with GPA (instead of SPA). This simplifies the implementation, and is
a pre-requisite for nested translation support.

Therefore, always enable this feature if available.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 1 +
 drivers/iommu/amd/init.c            | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 556f1df32d53..9226edd8af69 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -185,6 +185,7 @@
 #define CONTROL_EPH_EN		45
 #define CONTROL_XT_EN		50
 #define CONTROL_INTCAPXT_EN	51
+#define CONTROL_GCR3TRPMODE	58
 #define CONTROL_IRTCACHEDIS	59
 #define CONTROL_SNPAVIC_EN	61
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f2991c11867c..c45a4bd89569 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1122,6 +1122,9 @@ static void iommu_enable_gt(struct amd_iommu *iommu)
 		return;
 
 	iommu_feature_enable(iommu, CONTROL_GT_EN);
+
+	if (check_feature2(FEATURE_GCR3TRPMODE))
+		iommu_feature_enable(iommu, CONTROL_GCR3TRPMODE);
 }
 
 /* sets a specific bit in the device table entry. */
-- 
2.34.1

