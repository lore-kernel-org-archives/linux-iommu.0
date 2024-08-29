Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70D21B86C9
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724954882; cv=fail; b=ArEd98cNtVjGUDivZ4YaJPqsPivwGfgN5kggq56P+sNxVaJXQ7cGXLSuKzQ7wSF98ZB1KZExaxeIBw/jEOszGGeGzvKoseJT5MreMI5L6h503B/O2hfONvMdFrnC4lsmmuBCK3VU478l8Kuc9OOx+V+fveU6bshI85ysOa/2CxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724954882; c=relaxed/simple;
	bh=S2LUwt6UGv1a6AlQ3kRHKYdK1o7NAATuCp+6UNEOS/w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKy8rAyyhOO62zm9ZaWJNcFQ8Gx5LccIc6HvaUpOr9x2DUV/dye4T0B66pY9kITSRgqJiqwhUN2YbAcH+evTSJ0fW3zS7SmiQTqJQ2GZIJ6AJZrEhQLV9vQTwyYFP2FHDDkaEh/kyTyvnHZpjLQpOMB+ZltF+20+B4Ds6ZulgYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A9kLsIF7; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A9kLsIF7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UohUBrsjSUisLEnBWzWtxPpui4LoVIL8b7tC51a+uQZ7W4q2FMXW4HvvrPCq/Bj1Meal2KzAPbUasf3LGsXN9ztB1y2QlTzySDMPjDtaMfEgTCeuVoG9UUcJSZfQ6fRwb7fLh5EsKqTTT/MoG4N17rljxdcjUe9bfDaERW9cSR6uG3jgNCfUwv2TYqhFyLFJv7odJjUoLyR0dY10WLi4vgfB7XvTP/qPgH/+KMJ/t0jN3t5h6cbem7nsowe9rOHs8ZoNHynDqDKWGgDFpvw6GZMAiYrmuxls1kuU2HvxyxPP08jtgMfPkW/xSjzBczgog4TyLnaffxX+L7UwG2FR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPfkLVtLTG1Rf4ODxQr9nOI8kueJ45RiMXm2Z4g0fVY=;
 b=MKYOINWSoUdvZt7DA0hV0vTIF+Mho3hykHTbJci93wGaepFALROqBncKVT/diF5VlRwnV80iMf8RuQei/13K0ow46ef7XjdrRaoI4zfmJKIXAX+GtxDAoDf41GIVwD4cPyyg9ieM/uzChRVps7L40zH93dMDW7vDGxXMa1/nzT4RUSqqrv59sZuGIo3Pjkvnpyk8+E5xgSPh6n1S/DM6D1W9yhkTNfciGVkwEPk4rZji9A8D1W4UR9MXLszEZgIqfH/Jsduo03JezUkUJjDJdvnI0DiKqKuIO6yxx3Z2Vahx7A0vdOzI7D4eEWnlSxuLXU9j3YfUGP50jIeR+dJisg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPfkLVtLTG1Rf4ODxQr9nOI8kueJ45RiMXm2Z4g0fVY=;
 b=A9kLsIF7aEfvyaoo403jPQG3hc2Us4feOGsq8QAeiHFjtInv5RHNXPKVh/Y6OL4bcB3vfQUO47efj7JmLiNsg7l9Dxrth4ziRjL8SJR+GXyjQtK33X2hNe/vapTfDy+7Dj0SKBHn2IIHTdXfmHZrS+vwbw+fcGKI0iOBCqfNWvQ=
Received: from CH0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::27)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 18:07:57 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::c7) by CH0P220CA0006.outlook.office365.com
 (2603:10b6:610:ef::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29 via Frontend
 Transport; Thu, 29 Aug 2024 18:07:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 18:07:57 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 Aug
 2024 13:07:52 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<ubizjak@gmail.com>, <jgg@nvidia.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 1/5] iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
Date: Thu, 29 Aug 2024 18:07:22 +0000
Message-ID: <20240829180726.5022-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829180726.5022-1-suravee.suthikulpanit@amd.com>
References: <20240829180726.5022-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|DM4PR12MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1b8f37-83ce-4b67-574e-08dcc85582de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bb1JQW6lVRgjQDvozzP2VT8i4Rq/BSeJHkxfjqTZwXja2XeCeaIplCE9sZ+M?=
 =?us-ascii?Q?/3ksiwD6D57cmeQnJWoUowKx2/2mgkFSRX1/TMtl+L1m2RxFMHUhQvBI5qw6?=
 =?us-ascii?Q?vmXxRHTWeR7rDiFtdZURLnzPhARlXNaj2h8gY3/N4D1QKlfKtXTuUC9AX85Y?=
 =?us-ascii?Q?wBwMKusljqnaJNlfBNydNm1DgNrentGQD65ZwEvb9//AOLKgtc/EjyxaJi1r?=
 =?us-ascii?Q?kynmEw+gMtneTj904h4ShOQh/aj9G9kYtVOZkPYQLrojDU0oUquTZ1wqYAxT?=
 =?us-ascii?Q?ThywZuvzRAIyZ4wMQ/EjDsMdl3imY7W91mPAYAkuRGVz+eceMaYu/Qy1PjTC?=
 =?us-ascii?Q?30HKzuarg4NXW9qBPvTU9fXk2reGnJekI/6WnfPyu6w/v3ivOPaIOMm+xGOs?=
 =?us-ascii?Q?OSx4DdV6ww+hUfFSMwtMQQ75kppWzSfxMK+ck1TYjjNfwgbaqc7AT2nt4AOR?=
 =?us-ascii?Q?WFE/1F+hSAaUJvNv9Xx/XxY8Sh3xb1DejQPTbpb76HkYIjXUcemkjHz0R4oi?=
 =?us-ascii?Q?2b+t8FetF0AC3C07vFZ70WvcU+TNTC23i/u9IjFMSveMvOGjbsBJqYLuOHxq?=
 =?us-ascii?Q?PLmCCTYq43H4VIz3KrUHOPHVaRLuPQgNWJC6w8aUBs5M1uHpMPQ6+tpC2trO?=
 =?us-ascii?Q?++jGY47ax+yNzccuSpALX+GPwoCyBHP2pKoGG11HaswFFBRKFp4Jjs2kGEpo?=
 =?us-ascii?Q?e+zlzJ7dBfZNZ5P1hRmPdWSM9gXu6wTfEFW7C9U4TAfRIDVFUQfYwkEPJRiy?=
 =?us-ascii?Q?CGUVv8LwRAYktiMvjmYBR9Qo0dafhPJky3L50PdPE57kHDNXNLNKCWuWf7mz?=
 =?us-ascii?Q?KoqhAiKpFzbXN5HdglTa/XUSKpBmwu7wIu0qcUmc3+5BoH0AgqnCLWomWHpC?=
 =?us-ascii?Q?cl857ij4PescSHnjBH+y1H36xjnJW/4MBLobDmzgbvj3WGuQ0OnjleAMEv8p?=
 =?us-ascii?Q?g2mYbfny7f+DSBjNgN/bFf3pADGbr16FKoZehW/L60NbvK9FmEVcQVA/C+EB?=
 =?us-ascii?Q?7eMNfGsAZBTpgBVtlx6Dlj+A84mvLZl4mBrBr3HV4qD4D4ww196EfriibMq5?=
 =?us-ascii?Q?MZpMIHvqhTJeQm1hX/TYNaORcR4VaNcpsqGiiSwmg1/wRjfKbROnrYwMm/aW?=
 =?us-ascii?Q?7PrHHzXHXHW9nkKMmB6d5kPB2gga4VZ4Wr05+bczf1izVa0Mi4wJbR6muUMG?=
 =?us-ascii?Q?WSV2vfGvZIwXvMOcb5a73OJr9nZ0lUeY3skR1gRo7HHH7Z3OaiEHkY33Y1Qh?=
 =?us-ascii?Q?1xWHe7w6kvRe07rXgvDA620P5Ou5WNHhxq/L1dn1x3r2nY4XIZEwkAw224ME?=
 =?us-ascii?Q?UVDaJ8K3KTUcRNPbtcZshDkZd/aQ9W+4F6/Gr19v/pt1N2L0AGbZf9yOzzbW?=
 =?us-ascii?Q?HzXS7TTA/tzebYhEuPM4j4Di7zUK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 18:07:57.0340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1b8f37-83ce-4b67-574e-08dcc85582de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503

According to the AMD IOMMU spec, the IOMMU reads the entire DTE either
in two 128-bit transactions or a single 256-bit transaction. It is
recommended to update DTE using 128-bit operation followed by an
INVALIDATE_DEVTAB_ENTYRY command when the IV=1b or V=1b.

According to the AMD BIOS and Kernel Developer's Guide (BDKG) dated back
to family 10h Processor [1], which is the first introduction of AMD IOMMU,
AMD processor always has CPUID Fn0000_0001_ECX[CMPXCHG16B]=1.
Therefore, it is safe to assume cmpxchg128 is available with all AMD
processor w/ IOMMU.

In addition, the CMPXCHG16B feature has already been checked separately
before enabling the GA, XT, and GAM modes. Consolidate the detection logic,
and fail the IOMMU initialization if the feature is not supported.

[1] https://www.amd.com/content/dam/amd/en/documents/archived-tech-docs/programmer-references/31116.pdf

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 6b15ce09e78d..983c09898a10 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1762,13 +1762,8 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
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
@@ -1778,13 +1773,8 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
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
@@ -3049,6 +3039,11 @@ static int __init early_amd_iommu_init(void)
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

