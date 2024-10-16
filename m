Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C333218BB9F
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729055904; cv=fail; b=iFkz6InAFdZLOd7XAxDtuTIuC/wsMnXKSAPzFyhS/yKxJ6xGqB+DkBi/cZMxjYN5386z7OpmMm+n94HbYecCkMEuZ9uotyNTh6IZaTVDgTW/ewIyMX+1lpjUs/4oQBfrSNBp6SNdirD/xI+6Nvrkpgeyf2YuYY1QYxq7cy+w/yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729055904; c=relaxed/simple;
	bh=pGrLOTxeFfFR2fjty59gpiijJCuJzMPtba93B78LXFI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1Nh57ogfej65XJpg5B50D8leoKleThk/fAMVprJS10bUDJZbAQ4wCv7anyd5PNsPI58e5Yo577FRNv7x7ibvrLxzobGyqeDaTC2N8MUUM3ioQCwT/XW02VW4poP0LktbwUOWw0IRCjdCavi0tJ7GEetIrWIi7QrRBXmwx1RGC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GZZbEwfu; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GZZbEwfu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptE+TEF5rVHn7EwB5XFhJCRlMglrtqwnrV57kJ4pZ9osLtMBZkdB+nhlfqHOjdTQ1b/sYvKYb6jIfrLiFNaoYCsmaidhwSqzoiBF3aBSVdlPCPCYu7waaIqAQKOv++SnqTZ0oJLf+hs2fTk59jIIW5v9wJ85RbVt5OcF3i06CdR8PaCnLvVbyyuSquHbuMg/oES4lJ8XYSvGwc+etsbdNDjbRxSRqM+SBUtXnTJMEuZGFbrML/wOkpJjUVJmblButEna8ULVy7yxqMXLkYRxj8T/Zrhw0dyk8LVp0UywKJYaUEPMsbKVanhGXn96ibZW+jwhhQNTVqzCnKuZhKOLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpbWI1xzF6L38oGp9dj+MXXb5pGLq+T1sJiZdbCd1Cc=;
 b=sNldTSDiFLUUcThXLKeK1Sus5mVnj/B8+iHlhCdXUCjVvC7emlIlUL9oSdNBiSrUKuE3dji1q3Hw//f0sw+MelvyHJlQusW45ltwSAJL/wuxrTPyvM0AeHPDRS4qkNu++CFQ4KQ7j3vkeXyYde1D2BuM/XNX6JlSYDR0Uvuw9REVNvcXJJCJGULB18/ZRWiOxj9Paw98VMfsn90Oalf6hm/y354kJ0iqyVHo9PnJIgKdaYPYvopuTEGbGNjpoJ7ADvRqHH+/hcav668+KBLoVXd53AaBRvUyrtLJ1cXXUYjd7elNUzsp6KJQMxm8Tk5hmb+45oRGQJ+FEir85iR7Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpbWI1xzF6L38oGp9dj+MXXb5pGLq+T1sJiZdbCd1Cc=;
 b=GZZbEwfulw8ynCg6I5dqzD4gpNW5ACRJjOySTFGQ9LljsVPwLcjNe5NIJtD/FdrtftlSgabcAfmpTaCXb3Jp3wjV3yw4etIyKnSxG9wNC83f51pX5YK0GOXx3+4vpa3b7Op0H7KZ3mZvtKqOAd/USaRFRHpjiMQI4qVeL6kMiOk=
Received: from SN7PR04CA0055.namprd04.prod.outlook.com (2603:10b6:806:120::30)
 by MW6PR12MB8958.namprd12.prod.outlook.com (2603:10b6:303:240::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 05:18:19 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:120::4) by SN7PR04CA0055.outlook.office365.com
 (2603:10b6:806:120::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 05:18:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:18:18 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 00:18:14 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 1/9] iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
Date: Wed, 16 Oct 2024 05:17:48 +0000
Message-ID: <20241016051756.4317-2-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|MW6PR12MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: e13ef077-0d9b-4739-1fb5-08dceda1f247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ML5CbpapJp8EBV1s8jzyhkhpC/guK78k5M/u36phZiaiJJkniiZdto0YAbhe?=
 =?us-ascii?Q?EWOZmhic5HUDHluPJpGoD+PB1ecd2PoeXH2kbmbdbO1HWoDBq5oUQl3NhGWm?=
 =?us-ascii?Q?G5eVORQGcvqL6A9NGjGB/mi0XZ6PejKduQWRIPwEuEM59dmwJQi176cVziDz?=
 =?us-ascii?Q?VgUUSdDBSZ9i5sfmEe1gLEdlap5qNoAscfpjr6x9t+7ruwmSwnys990JNzVV?=
 =?us-ascii?Q?ez9PbxbZg4+S19WPtoNr7FVy8QwZbF/gnaHtAd3qBQMKRreuHJ81Hr3fEo0O?=
 =?us-ascii?Q?nrQW9jayDA9JF/djL4WJPhRVZwwJDxcggNKHsryfU9tmRn6Gtm09tX6POl0k?=
 =?us-ascii?Q?GZCdkkVyxpJJCoVhHzlla8RC1ltnmpcq47cNcjr0sIakV69IG8e6KM/60xkr?=
 =?us-ascii?Q?bUtjUpUKSf/ENw/YphGmfZ7y8gFUpVLw9++ilc063ohpzZerwLIkFh27esXX?=
 =?us-ascii?Q?DkPXKnnjPa/K63zwgz/78q7nL3XdOT2fncHUDpW0UUA0dg+tX7FZda0vy1aF?=
 =?us-ascii?Q?9XGsDBCEhtHEV4DRYNvK7gI+8NHlOPSbSDyyxiiOFxH+Ddyxv7emcHVdM/NF?=
 =?us-ascii?Q?R7Deb4PrRz+w9owHuWEUXWLJUnFs0N2uVgaNu2VaRfEMwIDDZbIAq9ZG68rh?=
 =?us-ascii?Q?BhtS9h41WZruHV/o0FOJUqoob0KT2msymb7Z/P/0zNbjob+N4Pir8PsqzHVz?=
 =?us-ascii?Q?RTz/XQtdePdrOutsfLo+YKkwz4dhU6Yq6Qfw/5scRRzi9vi8kl/5HZOeueZl?=
 =?us-ascii?Q?aAPOOlp6DNbEaEM5BuXATgK0L5Dt6+N7Sf6hyNhDlFPH9a9OunMdcBCaD6eG?=
 =?us-ascii?Q?1c3nhDg5lNx+S3oliarjsAe6EY7tw4Hx74+juQfLfc01yqNH1A43xNz8Nf7U?=
 =?us-ascii?Q?QEZ7PzagGpUR+Zxyw9kAfkCuTnQrHHg/0NPtE6PVVYyi6jQjmuqf0WfXTWuJ?=
 =?us-ascii?Q?yuSnnD7w23TWRHwcjAlLqARNRHyBkvPwG72sTtBK8cOvobeDcJB1VG7DyX7q?=
 =?us-ascii?Q?WVEc31fnhKpUn93cvsYAbnX7j6UO8TfIqN4M0qJcA/xuDmL3OcUy0r3T3TIc?=
 =?us-ascii?Q?iNK6jqiXcl0rj3YwBx65G36UBex7V2tbv3O36QxXUdIxIABvafbPnLVbdXc7?=
 =?us-ascii?Q?1KBdzxof4ysKh8QgOdAfw8iIaRDaOTMBv8zzxyDoutWkbXPOdbQSmqQHr7BY?=
 =?us-ascii?Q?bjfBqnuXeelei4ULtJnFCn3aAkL5fOfXzKhuyWW97dlqSKnuiUsuj1E1Clzy?=
 =?us-ascii?Q?f717eZ6wMYdL1cYSBt+DqnuRAksWkXXugChUoUrGY3Nf7OZqTapGScUduGY3?=
 =?us-ascii?Q?i5Ynij6Mof29yY/tPVwzUiiLgfZ02skYS/hjHngJcidRXsSclV1s9xWhc9Kc?=
 =?us-ascii?Q?YbpfSnuqJ1ZogzysF08AJHAI7OQJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:18:18.9095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e13ef077-0d9b-4739-1fb5-08dceda1f247
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8958

According to the AMD IOMMU spec, IOMMU hardware reads the entire DTE
in a single 256-bit transaction. It is recommended to update DTE using
128-bit operation followed by an INVALIDATE_DEVTAB_ENTYRY command when
the IV=1b or V=1b before the change.

According to the AMD BIOS and Kernel Developer's Guide (BDKG) dated back
to family 10h Processor [1], which is the first introduction of AMD IOMMU,
AMD processor always has CPUID Fn0000_0001_ECX[CMPXCHG16B]=1.
Therefore, it is safe to assume cmpxchg128 is available with all AMD
processor w/ IOMMU.

In addition, the CMPXCHG16B feature has already been checked separately
before enabling the GA, XT, and GAM modes. Consolidate the detection logic,
and fail the IOMMU initialization if the feature is not supported.

[1] https://www.amd.com/content/dam/amd/en/documents/archived-tech-docs/programmer-references/31116.pdf

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 43131c3a2172..a1a0bd398c14 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1764,13 +1764,8 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 		else
 			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
 
-		/*
-		 * Note: GA (128-bit IRTE) mode requires cmpxchg16b supports.
-		 * GAM also requires GA mode. Therefore, we need to
-		 * check cmpxchg16b support before enabling it.
-		 */
-		if (!boot_cpu_has(X86_FEATURE_CX16) ||
-		    ((h->efr_attr & (0x1 << IOMMU_FEAT_GASUP_SHIFT)) == 0))
+		/* GAM requires GA mode. */
+		if ((h->efr_attr & (0x1 << IOMMU_FEAT_GASUP_SHIFT)) == 0)
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
 		break;
 	case 0x11:
@@ -1780,13 +1775,8 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 		else
 			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
 
-		/*
-		 * Note: GA (128-bit IRTE) mode requires cmpxchg16b supports.
-		 * XT, GAM also requires GA mode. Therefore, we need to
-		 * check cmpxchg16b support before enabling them.
-		 */
-		if (!boot_cpu_has(X86_FEATURE_CX16) ||
-		    ((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0)) {
+		/* XT and GAM require GA mode. */
+		if ((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0) {
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
 			break;
 		}
@@ -3051,6 +3041,11 @@ static int __init early_amd_iommu_init(void)
 		return -EINVAL;
 	}
 
+	if (!boot_cpu_has(X86_FEATURE_CX16)) {
+		pr_err("Failed to initialize. The CMPXCHG16B feature is required.\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * Validate checksum here so we don't need to do it when
 	 * we actually parse the table
-- 
2.34.1

