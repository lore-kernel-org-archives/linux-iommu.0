Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F130F60B8A
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 04:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728274486; cv=fail; b=Osrhq/KQuFhg4tnj+HiqnhjkGdcR9pWk5hXRQs8sHps/3SCxOgP0bwnsHzaqWU2BpoO8umnNzyCKmMYEKP5LNkaMEgAfjHE7HaEjW9v/9Mt6b+3IWXay5kc2PhcCqRLZq7i1MPzn2V1XxNFZ2ZDbadVZPCT2IPF6BpttK2LujTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728274486; c=relaxed/simple;
	bh=pGrLOTxeFfFR2fjty59gpiijJCuJzMPtba93B78LXFI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPwmW9ng+ZMIR6y2dTgW/9isJVTXCBeEWBcMVF0lKM8fQvCVf0ze6aGhyH/BLSg+mTaHqXtI85cVYPB+n+guGOhpV+fMDThpnIx6fxv/5CaXLTE16L7mGTKy8puvjSIJhMhtIqATqOo7/nj1pkX+rr8brV2zSVQW/CAybOL9lQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z5AYgt3H; arc=fail smtp.client-ip=40.107.96.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z5AYgt3H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzeYWcWZyh2bhXBULlOCmF887J7AMZIYibiA/PtqZIqeWbsObVc4lVlyLftJsNUsF4Ynf1IsA9ucEly6vMlKEjkgjNmDYLD+jWx9PiR/I0xR1tsy/wNOcNcpo0PIwoKEtxMlG8NpHYbmaagpaeVY46Q/pmHDyvyMRWFdGUoaerPmD4OrgAXhz+CgUrOoO0m/Epzkyouwvv9Nmf+qDisRHcJvBAsFQ+GU950SmRXtRCAhUE/a6eIYVPQU+nytCLiiwWuaOqpaKIJZIMv9OAkVeAeRf5SK/8/OhLyqYhZKYiLi0siJe0RVNyNM4aqikN2lj0c41qwxLkzIaX75XuFOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpbWI1xzF6L38oGp9dj+MXXb5pGLq+T1sJiZdbCd1Cc=;
 b=lbSlQk8jL5uIYcHa2jvc1wy0y5sHXQ0p8h+6cuSsWTN5LPCmUSAGEJSNAch1/OI5zYvoq2t6biKiZK2RVICAo7M+XYINsEJ6/acxAujvXEuAzosxfH2dgNY40CTwjHYsftbkKpVVx/Gxbm6Khy1QfuTkwLf+EzAd+KxSlwMQE4svCW2TXRJr3rbFshOUai/n/IKTODYiJupNr2qLtUmXPDvwWzy6CaoJRnoaFAFti1s/RhjFUSe4QVPXMpSMz4lDCctO+9HN9xxspl0GQ0xN1n5jIvCkfNMEIPaz6TGm8XvRtN72y5iL+ENRpD2g1itKwA0hHwcVyIBiB0zrcaIU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpbWI1xzF6L38oGp9dj+MXXb5pGLq+T1sJiZdbCd1Cc=;
 b=z5AYgt3HBD3aWXYN7m0Z9J452mQzm3fGbLmLFHaWMYn4oQO51nVHfpQrwx4YVguvVEaFZObznWBxL6joHdrSUEeisvDCCK/+k+EIxw+MJDwrLDhFSSwo0cO/mSTB3dh69xFETDg+cYwOPBYrGpOM3kszCY1PFsx0TrWqHtYBHzQ=
Received: from SJ0PR13CA0081.namprd13.prod.outlook.com (2603:10b6:a03:2c4::26)
 by PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 04:14:41 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::a0) by SJ0PR13CA0081.outlook.office365.com
 (2603:10b6:a03:2c4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.13 via Frontend
 Transport; Mon, 7 Oct 2024 04:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 04:14:40 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 23:14:37 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 1/6] iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
Date: Mon, 7 Oct 2024 04:13:48 +0000
Message-ID: <20241007041353.4756-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
References: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|PH7PR12MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9968ee-db59-42ce-234e-08dce68690e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7ngriZtJ5oRVNOcYMNSOAwNrUR4pA+iVCUybdLclZPXngaB29q2UKQ0CHSNH?=
 =?us-ascii?Q?TiYOytANOWA21LxCfIIBTnznmAnrJCaMzj7x82vR4KRX7dqht45JhH7sn24G?=
 =?us-ascii?Q?diZpAjfBYmUMeGxhZhCYHXjlIsUMnEvUsOj5XD5CAptDbUnehsWVcq6TlN8H?=
 =?us-ascii?Q?3bBU627lFFU2YHj6tOO9btsPzUp6Ie4gV8pMGkkYFt1Bq5Sa/ux57+CpUR34?=
 =?us-ascii?Q?AXxvt6+EcRsgoQPTgAWO9ss41oJ+cMt6x+vFuSJDNSO6kwaGPCxOzzrHFBf6?=
 =?us-ascii?Q?G8iANJCevIl26f4vvVkxPxzPhc+j867AbVX1cWbCSrb9m6oDyjjMgpJVZAmn?=
 =?us-ascii?Q?Nt6c2Rzfcs4CEMmkNeuSFeX8sn+TtWOhW8ZLmasnJcWVGDQAC5rFwrVIRne/?=
 =?us-ascii?Q?PY2Y9Opcv1jVG4d7KQHbQI5pnID67Ir/C2ukD+9N7Da+bHQ29Lvtp0ZT5U+O?=
 =?us-ascii?Q?+Zvi/u8djkzsQ1dILqvs8ENzd2OjpgH4Yn3BXBvoZxXRGk1uYxCnO8YxzKrG?=
 =?us-ascii?Q?q40NprmwWaOg311s96SD9Et7b+fdaQCqqQ6ld5SgDZitKTpKEDx9kec+ZC1a?=
 =?us-ascii?Q?iLSoeYE9lPBA4D96aheofCXDNGbWDXDkTBchDeNGNZS9WasSXWnV8vZNeaSb?=
 =?us-ascii?Q?PNRJmKeERDC/nUfwRTniKckyP5Vd3xHfi/K9L5N5fyyAdnh4pPGQE3h3fveC?=
 =?us-ascii?Q?7A4HX8jJds0j1QQQAWVcny3Zc2HFVCp6LyBYOzWGGpHzEA7Lo40g25OQDAgw?=
 =?us-ascii?Q?96s1T11jFdZD3L2tdG6aZ4aInHG9WDcfgWOIY5EU7i42QAWpbYk5gAL69Eqd?=
 =?us-ascii?Q?hL5uW9N3L0mRv/jCYwashdwLpE/894vTQoH+BwSrJUASfD4Q7vei2K7RL+07?=
 =?us-ascii?Q?EkgBiKemqkvMSq36dDV7Y8ZguImSzSMAoYFDYy9N8uAgGT+r54vB6Xcd0l3f?=
 =?us-ascii?Q?Kff2dMwtHNWn5VYMay/Joni2kBJqQkgyUbPER7NfYf1PVB37ZxbFC7a6RwKj?=
 =?us-ascii?Q?hLJrvIm/deXZRA2C+UYw9YJk2EEdyq9nqOg/uOp4uD5NAmagczvF1pfiGdLj?=
 =?us-ascii?Q?liOr6aU3rUjpAyBVhE76lUoWOJWIF8Pn43+VkhVpmDTghJo75hs0ydne7mVd?=
 =?us-ascii?Q?H21Hr7u3v0D6ZKwDkl8UqUVkMw6IJoDB8P35etP1UUwFKoN1Yovzihjz/tkf?=
 =?us-ascii?Q?Hwi4/MqLPPev0w71utqJ1RHsfz5QbpC5cbu8qOQAUmhNkk+0ulz06S5bwGKl?=
 =?us-ascii?Q?hljOvaMlzhiM2fQWQgBf8s24b48LGNVVbds+X0JfTSf+GyofnSzSx+lWYZJM?=
 =?us-ascii?Q?p0jxBiuoqFsD5Lwz5IxHXInA+NbAGF/fjHfdeoUySEnxTB6aCcCtQfuz00HN?=
 =?us-ascii?Q?MQy0kGeVNlW/AjAHXJqjMFt6CfxL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 04:14:40.9106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9968ee-db59-42ce-234e-08dce68690e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967

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

