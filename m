Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1601C6B8
	for <iommu@lists.linux.dev>; Thu,  4 Apr 2024 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227093; cv=fail; b=je7UyW4DiEiroexkZatcQz/627FOGV3cZ7iY4qbHiUjI5LAdcndvXqQh3lILmoAQGyvSWzk/Baex7mPivQMOMW3LcRatoVGX/D+HPcpDsRUKxU/FlSM9BOSzzQ2iylyYm/HYtZCNLxZ9/TgI7eViHvLiztcQIhZz0athaTEoyPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227093; c=relaxed/simple;
	bh=MbmhngUyLKELEzRo1/uma+EKpxVXgI+dXFfCz5padwA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PEhHYYH1cSyYG7wOVd2QGJSHj7NVBQVbWv7/a7QQRshH30N66CBpIwobZMTHAUxBg7abAibI5ffkLbGORmVSIW+yWEqCLmalkuEFhXkvOE1902cIQstm1Hofo7k5SExKtCIDVhApHfxFA+efCMrz3qxJK4KA6GvNG7LK4HmZ/uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zzJ9ufQv; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zzJ9ufQv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgLqMMXhgfJkDNE2lhVKzS62xAnIkf74x3szjrSggY73Ee8xlkwxQ5q5vp0mtODhg243xrV8XJox+tSJ3Xz1FD/SDMSa++Aq3OX2L80/X/xYg1nqulCYw7j4g05y5xq+qxERvRJbk8ToBf+j4QhyePVWkZXZ+78Ug6hR1jMqKX7WsoksxYvbwwR+0dn3lCJVRYkYAGaL0qANlkVoFxeaDqsrh2H3WrwHfJxa5Wg7/10CXrjAQF7CiDLEATdRKYzbUlW8qQpaep3Z2/qSYyc91vnGt4ZmHLa++b5dIceAUOPn0Su/NbXOZlRshJNyCyYfJbnfTZ/weSo4LcmHcSy7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iV23NlT/6o/ZAlULkqWGUg9EnVo4WTm/hsNvoXwwU6w=;
 b=kuTn4caaendctmxrtbpRz6epLj+mBqpz0J38ZHyzjidLkdJPgh8EQ6vG3B/Asn2NA1i8Hz3UjaVy8OqEQ3P4SzU55O9sOLVVzk7TXtCsapAY8xKtGfvW76WZ+jU5RdrfohKqp+hgUJ2s7/9WtSJWQPqAJvx4b/bI5oUcL1PyODybuc+jchox6rybswJMIfATeBMjtPkvv7LHazf7DNBCS6z7EYJaCDTV/WMtr//J0U6/nKEs5l+YsYHVVof1wIbhrXeNnuBj9hvn/YDlYMjV87iYNGi+mK8WcqxIN8QhBcRBASzl83Zt3+Wnqp5sncdfjoX+Ep5eD22tNCiRrurrqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iV23NlT/6o/ZAlULkqWGUg9EnVo4WTm/hsNvoXwwU6w=;
 b=zzJ9ufQvPQWwHfupmVCe7cr8ndrI9SzwoYJV68D+HvwS5Ig58d+vUxY4vMS8Y6q/AuocLfyTII4pf7cSyDyPJSScC6Ar6YUcDlcdBmAKqMFzSDcSg3gb0tfshMiJxYlgAgXytdI1JPbwIjwE5E8XfdI3EG3XjNSKeCcQQSOW5b0=
Received: from CY5PR19CA0064.namprd19.prod.outlook.com (2603:10b6:930:69::10)
 by CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 10:38:08 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::8a) by CY5PR19CA0064.outlook.office365.com
 (2603:10b6:930:69::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Thu, 4 Apr 2024 10:38:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 10:38:08 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 05:38:04 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>,
	"Tom Lendacky" <thomas.lendacky@amd.com>
Subject: [PATCH rc] iommu/amd: Do not enable SNP when V2 page table is enabled
Date: Thu, 4 Apr 2024 10:37:29 +0000
Message-ID: <20240404103729.6752-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a68007-d0d6-4660-443f-08dc54935179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NgSc8u08TcZlKE6eK+7I8jD+aCw07E7eVmw58OKKD0oO2gR9wMmJLVVrz2XkXJ26QoP/FaetT0PnfrFqwfpBZtQKagrDV0tBEkoMaGiKE1+Er+t5RAxjN5O43ryV+WQgXlSxOeAgQxgFb/uFzYge3/E30b7ZCh+D1e6e/D+Ag9xacpWCjBFWR/jgXxLyOyk4D5d3rV/73ozfP6QAT5VaCreMIQy2+y/i/VkgjPPiv1lFFh1VVcn3oiH9xFcXFdYkGKC7WbmvlSgevlu7jbPTae8OK3p2VNadhn+K4Q9lVNkgWY7LnoFMLyQJ4Z62nMKqpwP3JuTF9Un6Zrnx99wUwncu+EtbKVtU76sZoiiQoOyjFP3EPU/jPoDfDSqKNCXbunb+vJ+HyiATxn6jHUea3IOY/3IieRMd3W4OqNWqn0onGk3Idh3mWuGdCMJd26ERdrMMC6LFJx4X+8aGiHMQ+q4tBA+3FDF3VrCeQMw5FxEMnwRiyQQAEsNrmR02TYVYOV3alKLoTJGiC0/4/yJVSX8PBAum7nf07rOFtGzigBFuuutsIj9uRXhRu5vzP+62Pykuo0FZPoWCHRRg7DmjVoKBvch0fR8l/b5zIDJJWWnmipq5Gmt+s9AcTHCODswKsAp+4R/5s8/dixyFCiQJhJBzSkzS+1x32q0hneS1zKBjOAmd+WGieoWQWCHvqnrmh5HSoBKgfBAvp8de3pZMwJz5eN/E0Efyk2Y5tOGPACRUGKduUY70hfPD5Xcb7ZoR
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 10:38:08.0782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a68007-d0d6-4660-443f-08dc54935179
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454

DTE[Mode]=0 is not supported when SNP is enabled in the host. That means
to support SNP, IOMMU must be configued with V1 page table (See IOMMU
spec [1] for the details). If user passes kernel command line to configure
IOMMU domains with v2 page table (amd_iommu=pgtbl_v2) then disable SNP.

[1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf

Cc: Ashish Kalra <ashish.kalra@amd.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index e7a44929f0da..e643949b697a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3232,13 +3232,18 @@ static void iommu_snp_enable(void)
 		return;
 	/*
 	 * The SNP support requires that IOMMU must be enabled, and is
-	 * not configured in the passthrough mode.
+	 * configured with V1 page table (DTE[Mode] = 0 is not supported).
 	 */
 	if (no_iommu || iommu_default_passthrough()) {
 		pr_err("SNP: IOMMU disabled or configured in passthrough mode, SNP cannot be supported.\n");
 		return;
 	}
 
+	if (amd_iommu_pgtable != AMD_IOMMU_V1) {
+		pr_warn("SNP: IOMMU is configured with V2 page table mode, SNP cannot be supported.\n");
+		return;
+	}
+
 	amd_iommu_snp_en = check_feature(FEATURE_SNP);
 	if (!amd_iommu_snp_en) {
 		pr_err("SNP: IOMMU SNP feature not enabled, SNP cannot be supported.\n");
@@ -3246,12 +3251,6 @@ static void iommu_snp_enable(void)
 	}
 
 	pr_info("IOMMU SNP support enabled.\n");
-
-	/* Enforce IOMMU v1 pagetable when SNP is enabled. */
-	if (amd_iommu_pgtable != AMD_IOMMU_V1) {
-		pr_warn("Forcing use of AMD IOMMU v1 page table due to SNP.\n");
-		amd_iommu_pgtable = AMD_IOMMU_V1;
-	}
 #endif
 }
 
-- 
2.31.1

