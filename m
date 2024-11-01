Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74E81CBE82
	for <iommu@lists.linux.dev>; Fri,  1 Nov 2024 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478215; cv=fail; b=SjObcUK6vJiKgqt/o0F/4qDyjpuh75addX2rVAiqzp3+pqfHcRgruotlNo264+U73dFmX4Sn0hGnbJtgja7FVjrfNOK0oSTZD+A48i4X3Y3UiTbQY2szzud1G9oBU7OAK4AkFN/vaCi8NaYdtCi8WvMxGZ1FPCuqUeB83Iztv3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478215; c=relaxed/simple;
	bh=BsNnwUV2R/BfqocP4sWIcX7O5HMemYytLwFFbPlqykI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZieJti8YHCYR66gKpPm5y+LA8x58ysMHSFLVSgx2LalAlfS+GubKpMpOEF/kqNXYmpm5TWM70HU4V8GRfEaTKZoTXFrL3syNuDM7n3GOXi23RfrR6cNToHhIHX6vGxkGpS4DRdHU9vYtzSJhrx1E8MKBLbDz+x9LE4qObyyEcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KPbqvdZh; arc=fail smtp.client-ip=40.107.102.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KPbqvdZh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYDoaPdV8qv+vdQVMoPEcStzwfvQFaRPtkLjuv14t1jxjz2Sb0qBl8lFCDZB63i3S6n6JxILlZTXPMQp95wDtcmdyKI/q+07YrQhNc8e23i9Cf4Z4ePV7n6lY+9jbujuZcYL15Z6DHbPoWkmCHvnmdOGkqBtBQDAvhBsc0W58tatATMPEtbUZsvGVNHoTqRVvnEZ9Oum8hL/zA//dk0C6OSkZ23WEZ/xaiZPLZzuxiGWf5EEWK0Ly/7gQxBgFlUjJBqmwxl36YNo2Ky8htrpdAcyPlaMTvOLUoQCmSbS11KKbtQAxzGiRF2MZ8WW7faDkBhWYtMwMk7ihiBA2MEzew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryS1c9CjW32vCe1i9lmLhp+TuU+jW5Gxo4i6WTEQ7Bk=;
 b=Y9OUPcqlO8cbXsGTMNDnMWwYx1DQNRdsSgbn253F7XunVkHdp3mJXrtnF7YL5g9hDnVRf4Dr808EX/bSGip5XASnLmkKe2Sxy1K9X21M8JOPTznVM3s7sgTzFBrZSy+cL8UkkAfCtnC4twfHsbS5yEV2xcUp1ACFdlfKtqTpMOGvUAjIJjFmLpcAe/gYJ25GHqV+5AeVHPsSsceH4P0JOeAWSXN6dDdv+pjLggYjajr5WOaYxn4eCyVM3MPzYLHBUL78NsrPW7rmdSbehzIqXyEJJ3thnhGzK2Q+N5A1gE+5meKs7g5DtwB+m5R9sKcizu8QCZpRV3UF3TfAlyIXuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryS1c9CjW32vCe1i9lmLhp+TuU+jW5Gxo4i6WTEQ7Bk=;
 b=KPbqvdZhP+4KPmzFW5JdV0ECZkHywPxOiCaYKtelJ8a/sIaXdG0qu9mEwhgdm6Dtp0HoXTzBYolRDHLLjZUL+B0D4TzQwB7lxLktgr6tf3Owy1LnZm1E55VXkr5RPuOAkITpD270/gLfd8o/+L+CVoTQ7aIYgS+cYJ+I2JYaJwE=
Received: from SA1P222CA0043.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::17)
 by PH7PR12MB8178.namprd12.prod.outlook.com (2603:10b6:510:2b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 16:23:30 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::10) by SA1P222CA0043.outlook.office365.com
 (2603:10b6:806:2d0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26 via Frontend
 Transport; Fri, 1 Nov 2024 16:23:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 16:23:30 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 11:23:25 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v9 02/10] iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
Date: Fri, 1 Nov 2024 16:22:56 +0000
Message-ID: <20241101162304.4688-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
References: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|PH7PR12MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed80360-4b68-4869-ff26-08dcfa9185dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j13MmazrSh+4GzHx+bwMD6ka71rYCovNw/EvJX1YlR1jh/3ToQJRh307c6Id?=
 =?us-ascii?Q?DgjMud7Gtec98dMX64YYTXMl4zdG5BfnX5VIxOysQsxBvrJ//SKkVULkCJhz?=
 =?us-ascii?Q?asqySCGggyLwuKIN3iYojVUx/vij0P5vaRVkZDcAWzmvnVOQPYOBFVrGURXN?=
 =?us-ascii?Q?0b3fNWoEIBQqerGZRTk9CxhpsxqjlVNPaMx0YB15rRw30o+p6we1Z8/TzHy+?=
 =?us-ascii?Q?NSYrNgwiMnSsQuhdt882GmbmBAqfM7q59lKh7UehqXvzr/k6oqEh4mTz5rVp?=
 =?us-ascii?Q?Tz+rsLjiWsLhvSFPGCzoVm3tdxU95zJLYifNb0ND43cNbPm/3z1YEqOWNW+Y?=
 =?us-ascii?Q?9Dg3CDnrW5Ay6UVH9eBkXYSoMt0/mMFSOMiG1Y2Gh6WipeWsuvaYS9fdJfQr?=
 =?us-ascii?Q?3bsXDBgzbg3znevl3BNGU3weXPr0ws8BT5GNMXvsk0ozRefNy5Z9Mq1WvELX?=
 =?us-ascii?Q?SjEQhbOoENAw0H8unLmNlLRJZCKUSqxdxktn2bMAza6V4MAb+jvDH2s6sGkl?=
 =?us-ascii?Q?R6K6hVe7M9kTaODjJUn4mLukohkzFZL9QpUcWbEYbJsneyUxLcPMNSP7L6kN?=
 =?us-ascii?Q?+cnb18C1eoIKSCTi7+qPv8oVugcL+KkKCw9gxqujGsKuAg0ikPYqeBS7tMUu?=
 =?us-ascii?Q?+NzcwJ77Pa+4U0JreqYiCb6WrrY0odrIL7lVnsR7zJEi8nwQAdQlVjOCwZBf?=
 =?us-ascii?Q?Zj1vJPvaeHk8T1ZC1Pwr2tI3wea1D40band6mryTehx7csk5ERfeloTfDTgX?=
 =?us-ascii?Q?skToQ60MZ8VPbxL9lGYYMQ5doAxLfxw+NsZyqPvcKQp/A7L/p2DCERkrxkot?=
 =?us-ascii?Q?wtSVOOqv7HYzL8fkhILP6VNcKWbaDpbSFJ5Z6QE/3EFeb2cYXN5zFhAqoM7Y?=
 =?us-ascii?Q?7AF4DO9mrzXQYSc651XvZMwVNSmxlgiGFXrNnGQuaXyxuq2TcHtXS1oTr50D?=
 =?us-ascii?Q?Y+C/EqLlQ3ZRRqATAee0ArxrFlY2Txk/YsAiXHCrx1z4hkUm+rtF2Y+6FlIj?=
 =?us-ascii?Q?d001ZjdJS1tHYV9QUtl9UOxBE/oXMMEjoSA6pgWIZBkxDwScAqo/dh+/UhU7?=
 =?us-ascii?Q?MnGd7IWedd+NbCgr6EKxp4QHUwWG0oxn3WtHWuSjC3t4Zu+8PQs67nJCg44G?=
 =?us-ascii?Q?vy8isYxZIaRqzOe4lqhGDzlqjGfjb9pPZanAF5TsW1Y73tPi1mRUaZUGZ+Jb?=
 =?us-ascii?Q?y/x9WXlB+1q2mtW8dqBtaTOVGCHT8q4J1jh/iygn9X9nSAWl3kQ+wdhEtQfn?=
 =?us-ascii?Q?U5qmnQd/jMxUOyFy2ul0oNLvSeXYbEfEgJlAn1l2UYzElfoikmlepYaAYkha?=
 =?us-ascii?Q?j3sMoOfHl74M7Qo4MiDR/hG5bLmfhrrqhOOiV/mFh7vmKCCI4XDegMJyGwo4?=
 =?us-ascii?Q?mzzujuXK39YNtLWvCPZi/RDyKi4Hg/BK/EveOsyc2kNfGFULVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 16:23:30.1416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed80360-4b68-4869-ff26-08dcfa9185dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8178

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
index 3a7b2b0472fa..c1607b29ebf4 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1752,13 +1752,8 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
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
@@ -1768,13 +1763,8 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
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
@@ -3028,6 +3018,11 @@ static int __init early_amd_iommu_init(void)
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

