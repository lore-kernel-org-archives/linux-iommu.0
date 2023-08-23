Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B98C131
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 14:05:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhjf6Tw+y2LWKVr6jv6kvDdhSmOV94SQuori9y7GNV5Z2tKsA49pzmEfTtGl0iHihHMJJbU6soQZQODLx5NTdqC8QwyVmZVNsJpRemhxTqjwoNNFHfaNZz6qibI4uzjjdDZh2wcQefepAwHKsrGY/mGBTO8m+I6IHfAXsG0+CQvXuKTZO2sJIMLCDC/UUVKbivyWd/2xxDHDlpIXZFHYBebYQmu9A9oDxTeWL4B7PxS7xb4lpZtxeJQ3oZXEZ+TH4BZ7/I5PdtDhq64g1OMQy600eFrEH7k5u8oPzxI8E+/E4NltKnK3lAwQzWpL8T7T/SRxEKZ8YQZSDVWfkKgd9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=du03hBn1uzOEAShWoNNufYeUTe/TcvJHO6c2uGueHwM=;
 b=PpNqVXsWV0JddcQOnzeoudueN/J4jl5SiOtlfNg6KqonhPWpPij/POy/miZrA7mIUbhXw9om/l3xaZ95r937ljRyxL1rhQ1L78N+B7uj6oAq0XI570/VaMPDlINnFC2uwVDG73Cepzicc2eKSpCXilE5aEYsVV+VukGyebZJ/w4snecu80QcGzfk8VMjkcsikTpc09FBGM0Q2D8tX94n2SeEGs3XVNpU3DZpsubf87UJITJLz0IGAbInLZQUDXX30PrhsPF08rrwAchq7wrOLZ7MjSHqJvCB9bgU/zs3JuhI8/tTZvaOS08wvM9r1m6VnFMsV5zwWGwKLws/xAy9zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=du03hBn1uzOEAShWoNNufYeUTe/TcvJHO6c2uGueHwM=;
 b=Xfxpai4FJi2mab4huyYnOoqVxbEh+Pr/df8NIUdsirRXY4GQJvww/YnASyl6/t3P84xmfU71w6LM7lopaOMRqV2K1DoomgGVVxQR2W/xSZk9UAzkSc0d1ssXLRHBOhP/8SxfWTINN8EkOx+rx/0NsWNIKgBBNtG2Z0BDXktKt3o=
Received: from SJ0PR05CA0034.namprd05.prod.outlook.com (2603:10b6:a03:33f::9)
 by LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 14:05:14 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::56) by SJ0PR05CA0034.outlook.office365.com
 (2603:10b6:a03:33f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.15 via Frontend
 Transport; Wed, 23 Aug 2023 14:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 14:05:12 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 09:05:03 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH RESEND 01/10] iommu/amd: Rename amd_iommu_v2_supported() as amd_iommu_sva_supported()
Date: Wed, 23 Aug 2023 14:04:06 +0000
Message-ID: <20230823140415.729050-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823140415.729050-1-vasant.hegde@amd.com>
References: <20230823140415.729050-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|LV3PR12MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 4169420f-9187-447c-b95f-08dba3e1f813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CGrmV66eoJSZCdEMjTsM3NEwoZLe9J8Qb99JYsSn5LcWS7qGPTIXM56yvS9KHp770/rXqHxIql2VF+Le0K4NF7eURyRXbOkJRuM9YIfCprao4nP43ThwBmSK0hD6Nwmz1+4hWAjbB8tOKBu8BsPgkM9cQeJZHJ9wVbnsFIw3rll/eoqOu7igSAHMZ1vL8i3E1Q0ufvEnvRs/3xIknMyI4St/Y2Lh7bUIi4X6wJqED1iQgqm1CaH8sLREKcYcqjc+m1pIsUDh66y85j3ALQxBbCF8Z5aGOYlxYRzOBvaeCcdMozipzw8C/MUuTAb60lyZ1CcZypH1DK+a99rM4Vv0o9pVzDn1nmDZrGIf18W6SlkTuvqe9e55eS2GCEiWE5QJTD1Beha1xH+w5am7dFKlVhh184aMOcuhjp9kdzbWIpadgEaoOe5ycsIGLdST2YGjbDA7ar2cOR/8c21V4RhBGX8FaXohqYsotN4lWJQU6L15klZs9R9b8yYKeH7GKoKhUSaXXkMtuphcc+LZpVVfL7FqLfqphQZC67HJp8euMitiOiVYd79hu5U5Aemonq5h++wSsw6Kkq2JGqL6P7QyDmaT9sXhqvdVlymyp24KKa+fBVL1XM7y4FJoxDhJ5Ac64GqledsV19bSalCfC6l92dsN7qjHUw+v6Wsk9ucgzgGy+cEhcUEZ/Tq2bDS1OdLvOX3rWfqXGn5MEdsOxfPULBWijNBQqeLHrZG5yazZewxU6xrrM5zeqcQ2jugIUYY1WcEkZ2DhCQd+OlurWMQ6qQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(70586007)(70206006)(54906003)(110136005)(44832011)(5660300002)(2616005)(41300700001)(316002)(2906002)(478600001)(86362001)(8676002)(4326008)(8936002)(81166007)(40460700003)(82740400003)(356005)(7696005)(336012)(426003)(1076003)(36756003)(83380400001)(36860700001)(16526019)(26005)(40480700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:05:12.6662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4169420f-9187-447c-b95f-08dba3e1f813
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216

To reflect its usage. No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 2 +-
 drivers/iommu/amd/init.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 92fba9bda3d2..f236d540c917 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -41,7 +41,7 @@ extern int amd_iommu_guest_ir;
 extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 
-bool amd_iommu_v2_supported(void);
+bool amd_iommu_sva_supported(void);
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
 bool amd_iommu_pc_supported(void);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 64bcf3df37ee..3820ae738088 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3652,7 +3652,7 @@ __setup("ivrs_ioapic",		parse_ivrs_ioapic);
 __setup("ivrs_hpet",		parse_ivrs_hpet);
 __setup("ivrs_acpihid",		parse_ivrs_acpihid);
 
-bool amd_iommu_v2_supported(void)
+bool amd_iommu_sva_supported(void)
 {
 	/* CPU page table size should match IOMMU guest page table size */
 	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
-- 
2.31.1

