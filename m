Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BAE23C9
	for <iommu@lists.linux.dev>; Sat, 18 Jan 2025 02:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737167832; cv=fail; b=H1DgqWFHbZqds+Yq1o+0yp7SGMsjyKSmX0m7x9dzrick1l77VBe3bT/wv0AMRohACEXz2W460HZNSw+lEmznN7Myjc8ujcLcOWE0ZEAcgqVKZ4xcl1bBUaZJP2hihYtjWKa2A6LyhZdqtyEOscEqjc9xxBDaKbZVsMBzoQYudXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737167832; c=relaxed/simple;
	bh=IhMm3p8vmMcHLWQTLUZF0jp7ztHpgoenAD1/NBKKM8U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rdM9v9Rx/0hKV0wTLx4u5Z1GIDx9BMsiX8K8ixY4VVZyy0tR4PVl+lAX8kvQ6DJeSaeCkp+q6MdxpmFrQzb3lu4JQa1LNjpHQihWQvtdAg8KFW0dMCMFNgQYps4R2p6Dj/zysmxKmaJhSHuage9ZsjZGN7ROdwRi25FebXTdrp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mT9Jt8jE; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mT9Jt8jE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCJWd2f49dxYznM3kbpO4PP3DXCoY9i4FUl5EG1MrH3dvs79a/P9OW4YwnNTvhZ5M/muLXYJUFeu+3NMCoTGpTDHaG4WaTJaDBMUITz1fQnVkBNsdvQs+unz4HC48eGoeG04kJyjG/9MpF+kf922FKSEmkEal57LyRnZMoTAA24ZTwygVsdt1sX6wdUk+5BU4nqv4syrzj/wXd6PSAje6LxpXH3xxQg8FA7J/4yltLDg8KZ4p5WdICZ+rpKgRApKbISqpbOf8cucWQYJJ8YPW0MERYc0ghdmcGodMbPXV3HkHqOGvNrCZBwFCmdvJtqQFGuZxSxAze83obiB89ArtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Po5vWRfpJPjhY0/iNvy12eCyMbHLaH3exgyLNft0PFM=;
 b=SL4+fgM6kxr2QUo8pJJ0va5BlSp04Gg+6gpf+r32My0XaEgLk787gDLLZav7wvlFtb45Q7WT6btZeiq4qexihxC24AhGJwqPkMe5rjHKFhLQ+jt2ET+XJsd8j9lbPpP0ID12xjKbC3KjbTAKJ0d/+OXqTcd2mWSWLMxuqsz3BnmvPDsa6O1iiXmWkxEkxji71jeWVUW3+57puQY4zvsTZCNvf5EyXAbmtyh/oRzAzOIjw+GEfVZ2aZCv+kvFxZwaH96I7FvwjYgpKqy9mswLF6MGzT2SAmmFPe3zyVP+eJ1kPaIM5TDbT/djxexwcE4d8jQ8PX8lno/UZLpSRCazhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po5vWRfpJPjhY0/iNvy12eCyMbHLaH3exgyLNft0PFM=;
 b=mT9Jt8jEapXls5kY7iMuVFjOaBScj55hKwd/rdC0/kM8Jk0VGIo1cnWSRzqAGF7IcMw6hZXnw/TZEz0V2fuhkbLWiAatylSPn846gtAZZ3L7DF9qE0SQNUVBIcvLrTbVDo3pEIDajEMS+xePOTls4lCezK5OY8q9oP1BJHQzqizeAW+KYnXwiXUigO+Y4LLe87AN2F5Kbno9Ypw+gCYh/9qTZ4BVXKXCyATEeFi2phG5cdP620p8p4iSAtRwg4a2cCWscQxrd60p7OVIUbTgzQ5ObHTyZgVYe6xzIuXFBgrHJ6jLtfbo4xYLfdKYE+QHC8Kprx7ED0knVZn9NT9lNQ==
Received: from SA1P222CA0142.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::24)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Sat, 18 Jan
 2025 02:37:07 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:3c2:cafe::f7) by SA1P222CA0142.outlook.office365.com
 (2603:10b6:806:3c2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.17 via Frontend Transport; Sat,
 18 Jan 2025 02:37:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sat, 18 Jan 2025 02:37:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 17 Jan
 2025 18:37:01 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 17 Jan
 2025 18:37:01 -0800
Received: from Asurada-9440.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 17 Jan 2025 18:36:59 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH rc] iommufd: Explicitize struct iommu_hwpt_pgfault padding
Date: Fri, 17 Jan 2025 18:36:57 -0800
Message-ID: <20250118023657.142517-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: b23937b2-6c7d-4535-dd4c-08dd37690080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cqdpTOb/d8K9Rm6MCJZ9a4gV1tikDSDIxLu0PjI3FuGP5Rdmd3KEMgEMH+Z3?=
 =?us-ascii?Q?N7nvS/zuJm9QEh6pMekZzZCsPIt3Qt8XsnN8INgrvhjfmHdYL4863O4tU5Rc?=
 =?us-ascii?Q?AD/uheLKrVxphG5fLtpnLEhyw3GT7Lr341NGMUYs8E9p7SJKwoYySzNGVeel?=
 =?us-ascii?Q?+8OnPEQRs8mhPUQwmUmScO9olArOJYG/osshcAI7D1Kx9xMd+LAXetqcGbT5?=
 =?us-ascii?Q?ylo1dEJRjDFJpPBo1YAN/tpqupjp50ievKuQ/YekIT26EK2ODr944f33yH7a?=
 =?us-ascii?Q?hmZQHNGjEZr4vMGN85Nwc7evQqGkV5CqvQECADYEylSN9wXQe3Pzl6HWZ+wI?=
 =?us-ascii?Q?FqlMW8h0inuJErh8/HsEnW2NBGgbwV2F5MFJ98h7OxLDzse5KrDGaFsi6p4h?=
 =?us-ascii?Q?xMrcnTN+duDhvuqR4QwQUDne5DQvJNxVR4+12rulCGGfId6MgR4SwhOHAJ6s?=
 =?us-ascii?Q?//Wa6WYC2YMqJxRZhZV/EElq3gmZhlQAu3O0P26M8kAgwFaf3J3GvMxPA0kM?=
 =?us-ascii?Q?PhCj6rYHyg+i+0F8CHQOl3x5+QLR12L0WDp0tQwjc00Dq92Kk7c9p5AaTjAw?=
 =?us-ascii?Q?RaRokbF/x5UFKDpF3a0lxG6o+hmGEo1ZP8729VYjhp4np4CoEp8YXDIbxWo4?=
 =?us-ascii?Q?se0JtZbV+pAMdmWq49vdDF66Wg5nwLRtb6uN+5Bkurv8K9R8XGtAsCEENXZy?=
 =?us-ascii?Q?mtNk98tKeK+Vz0M8fQnjJ/5d4CwVQdX50zjevz4wF2vsFozABsYxThcCnHEw?=
 =?us-ascii?Q?9UmewrpTK3ggIUISlTkbRbrnqMN4by9NDPXB8DwgHUARE7fZtAF3Hkxm1+/n?=
 =?us-ascii?Q?FxZn0nGWnTzBrdUdDCGeRvcfuGA+BXk3v6zQYTX4td2KRZBwklzo8fTUErbg?=
 =?us-ascii?Q?Voq0Pi2KTiH0j2CW17hAVs4ArKp25VofSUI9bZ/kB0PuAbzwk96mTvXx+iKs?=
 =?us-ascii?Q?z2xvaUJuqX9sZOVBr9TXoHGsoOyBcJUsSlaAlPF0SeukPkIsBBy/uZ1ws16s?=
 =?us-ascii?Q?ytvMcq2B9Qo/12izKjbui73dX1PYk5YSXqFJvHRUzY7vkddTZKIzd3ZKurT9?=
 =?us-ascii?Q?cpFbk9n9aeCf6d1woRBeG2iVCZs0jqwPseGSP1T0zu7tl2/pv8O3xiXNNYBs?=
 =?us-ascii?Q?VI4DTRTZ2Expnv6vluru4tyjK5OACka6tMjMqvX/ZAJ1vUa9wrBk6ezNGCSG?=
 =?us-ascii?Q?9PGR3+zAIDi7tO7dVdal0FfgU4f7csPGzAlj2vlNymQrIe6Z+Q5FoxkyGYR7?=
 =?us-ascii?Q?JNdIG53zNiIVuUx8JBIhlSO5UrGzZ+yqxKGoTtyPMjTdufZjWT8P607TSoWy?=
 =?us-ascii?Q?utO6CpiXcR/O6+CdiQj37xH73Dt5Hu7Qe6aiSlHC+MEBGgYHCJT0sARZej/3?=
 =?us-ascii?Q?Xu4UR2RajnJ20rTCVwW+JY3y0esZsA3EHBtllTHBE48yznsWAMKC4L3dVgFI?=
 =?us-ascii?Q?546PvXAWLd9OhQfYF+fWTwuEiwU1BqLKQtENJ83n1P1ijfuToU8a5gIdFrv+?=
 =?us-ascii?Q?YaUMspBooiqYGOk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 02:37:07.4924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b23937b2-6c7d-4535-dd4c-08dd37690080
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393

Though the padding could be done by the compiler, add a 32-bit padding
explicitly. Also, change the __u64 to __aligned_u64.

pahole result, before:
struct iommu_hwpt_pgfault {
        __u32     flags;                /*     0     4 */
        __u32     dev_id;               /*     4     4 */
        __u32     pasid;                /*     8     4 */
        __u32     grpid;                /*    12     4 */
        __u32     perm;                 /*    16     4 */

        /* XXX 4 bytes hole, try to pack */

        __u64     addr;                 /*    24     8 */
        __u32     length;               /*    32     4 */
        __u32     cookie;               /*    36     4 */

        /* size: 40, cachelines: 1, members: 8 */
        /* sum members: 36, holes: 1, sum holes: 4 */
        /* last cacheline: 40 bytes */
};

pahole result, after:
struct iommu_hwpt_pgfault {
        __u32      flags;                /*     0     4 */
        __u32      dev_id;               /*     4     4 */
        __u32      pasid;                /*     8     4 */
        __u32      grpid;                /*    12     4 */
        __u32      perm;                 /*    16     4 */
        __u32      __reserved;           /*    20     4 */
        __u64      addr __attribute__((__aligned__(8))); /*    24     8 */
        __u32      length;               /*    32     4 */
        __u32      cookie;               /*    36     4 */

        /* size: 40, cachelines: 1, members: 9 */
        /* forced alignments: 1 */
        /* last cacheline: 40 bytes */
} __attribute__((__aligned__(8)));

Fixes: c714f15860fc ("iommufd: Add fault and response message definitions")
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 34810f6ae2b5..78747b24bd0f 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -868,6 +868,7 @@ enum iommu_hwpt_pgfault_perm {
  * @pasid: Process Address Space ID
  * @grpid: Page Request Group Index
  * @perm: Combination of enum iommu_hwpt_pgfault_perm
+ * @__reserved: Must be 0.
  * @addr: Fault address
  * @length: a hint of how much data the requestor is expecting to fetch. For
  *          example, if the PRI initiator knows it is going to do a 10MB
@@ -883,7 +884,8 @@ struct iommu_hwpt_pgfault {
 	__u32 pasid;
 	__u32 grpid;
 	__u32 perm;
-	__u64 addr;
+	__u32 __reserved;
+	__aligned_u64 addr;
 	__u32 length;
 	__u32 cookie;
 };
-- 
2.34.1

