Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB909374E3
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AFZ81NZh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nu1Wbk+vf3seemiIJKAxUPWj6FHTxxeFxOI2TJ3K/Y9QeoslQVSvWwdw9qf8aNcV2eI8of4Jl0X1D/qyCylCmN4zwtvj9z1SVwcIPknaZKHxbAI9wztEaYqZYQUMuNSk9a2qOgEUrXPGeFtnmpR0HrTCtFFoULyLvsmMSimvJBucMip/lLXVVfEB4DxPSGSKO1R6xW1keuhnJnwRZA225Y4LBQ0vnFo8nxemdcxhQ4iNTjx9i+xOujKKa1S6KBLftv0kSVNWt9X+PTcSNmP1IoVQDbqtKecavZ8jdj/WIOWVV6JLIN9tf2RitjJysIkHfwBIfnYe8iXFSqhU9kkcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcEbgOuUDAgc9g8SWVwSfqsz2Bz135SV8CUpVC5n3YI=;
 b=GnHBvgGXNyZZ6WLsrDRCAae2yi2WH4MRsuhC6TZE41KqNsPGEHm+6haSMmXH57T2Fu/Mz5PuAffk5Noz1e2Gk08gTdFvtLKTEMXgsdQUSvmm3qaDy8o8Vk4behzo/Z6o5LmOk3MBOSDcRAjuJOzRVDW+W9G8+sVW3CuxT3n30FtWhWIw5PIXmYXBxeGXB2UKbrKLTn9qg+FQmCwtoBwb4SRdqSUSaLNiPLH8PlAy4FbcG+BDWNLySypUp/d+pIsEbTs8NKM377zBaPQdOSAum7paZLhftUCSX480CjPslAJ1EDqZ0FY1BU4un4zcoXTvU7zYf02PI79fpyyDTjmI6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcEbgOuUDAgc9g8SWVwSfqsz2Bz135SV8CUpVC5n3YI=;
 b=AFZ81NZhLto9QLYbksLq10A2omaIlP9SBrCj7SxrzBGtzkjPuEeeP6czuSa85mr2cv4eC7OpxlQtk16WRWLFyUy0dS//r4RHYfOIc94bcO/kcVxDRSA0FjB8YsMTOd+a5k/x/82uE/EY+qRvoVPa/R2MeA+5NX7lh2yoo7vFKg8=
Received: from BYAPR01CA0019.prod.exchangelabs.com (2603:10b6:a02:80::32) by
 CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26; Tue, 12 Dec 2023 08:53:51 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::96) by BYAPR01CA0019.outlook.office365.com
 (2603:10b6:a02:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Tue, 12 Dec 2023 08:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 08:53:50 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 02:53:46 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 02/16] iommu/amd: Enable Guest Translation before registering devices
Date: Tue, 12 Dec 2023 08:52:10 +0000
Message-ID: <20231212085224.6985-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212085224.6985-1-vasant.hegde@amd.com>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: 324263f4-2acc-48a1-520f-08dbfaefdc9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ivYdYbPnpGHuol0z3WBi+1Z13mdr162Uj+fRzKexxHsaUhyO/6M8hcLg4jZ+/X/RyqsrNMUxFAZzqfHplwSxlgnLJJVEYiqKJ/6Obkg6LDERLD1Vn7CLADFSp/dOLCyyQMYV16QZh5vq7Te7rYa4iltZSnmqx80BwO4k3T9WzcCx8+2qby5RLDvq5ALuFm4sAdlDZOdUuXcu5MMRJ6dpmIsZdZqDmULYXpOZkQK/pYOAXwR92v5Zw+acJcCKLjkPDMFHjHKnfZugwX7SJtl0MELoIrZIZep1Qv/CpmfPS6Ht7ZEwck9eZhLa13s+4r1Gxlng4C5TMvbBlK8xyd5u6JoWFnn7Mt6A8ud/k26FFWBxlcOLs2hyu3W24T7B4mH3ewnxdA5w2H3fBvkcu4EAgBDjLG1bHS8BgqFyh2ROvTBgy0JRbTMJ5nR6tLNtwFwRulNNlxoQY2mlv0jiiZ1tdnEBc/So3LXPgeu3JIWjuOOaMHwXsQfye0mbkICuSFkdi+Nh7wPkVkLtPFt4aPpIarsxMUdX042RbmvYEiz6TSDkrkB33IbJjDcKzNKTLFvoNeiJYpe1sf6QNxGW0xMWDfBaMsrnvmZ9XPU71STsoC1R2cF33i2OJHCfdTZ3dLvFaQrBhrrtakFoVqvKLBsEEpAFzN7wZTsSMNKQ6hS57DOLVmia8eeh3UUL1TbngCHldy/wjpDr22ME+OSSWX/gnfFtGTtIHMAEwaF6nj+fA/dbvfFdbhCrjtu2SV7f99w+b1yYIv1mBcXZ10EB9RFDyg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(40470700004)(46966006)(36840700001)(40460700003)(426003)(336012)(26005)(16526019)(83380400001)(7696005)(1076003)(2616005)(47076005)(36860700001)(44832011)(5660300002)(4326008)(8676002)(8936002)(41300700001)(2906002)(6666004)(478600001)(316002)(54906003)(70206006)(70586007)(110136005)(36756003)(86362001)(356005)(81166007)(82740400003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:53:50.7010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 324263f4-2acc-48a1-520f-08dbfaefdc9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198

IOMMU Guest Translation (GT) feature needs to be enabled before
invalidating guest translations (CMD_INV_IOMMU_PAGES with GN=1).

Currently GT feature is enabled after setting up interrupt handler.
So far it was fine as we were not invalidating guest page table
before this point.

Upcoming series will introduce per device GCR3 table and it will
invalidate guest pages after configuring. Hence move GT feature
enablement to early_enable_iommu().

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c83bd0c2a1c9..959820ccfbcc 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2769,6 +2769,7 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 	iommu_enable_command_buffer(iommu);
 	iommu_enable_event_buffer(iommu);
 	iommu_set_exclusion_range(iommu);
+	iommu_enable_gt(iommu);
 	iommu_enable_ga(iommu);
 	iommu_enable_xt(iommu);
 	iommu_enable_irtcachedis(iommu);
@@ -2825,6 +2826,7 @@ static void early_enable_iommus(void)
 			iommu_disable_irtcachedis(iommu);
 			iommu_enable_command_buffer(iommu);
 			iommu_enable_event_buffer(iommu);
+			iommu_enable_gt(iommu);
 			iommu_enable_ga(iommu);
 			iommu_enable_xt(iommu);
 			iommu_enable_irtcachedis(iommu);
@@ -2838,10 +2840,8 @@ static void enable_iommus_v2(void)
 {
 	struct amd_iommu *iommu;
 
-	for_each_iommu(iommu) {
+	for_each_iommu(iommu)
 		iommu_enable_ppr_log(iommu);
-		iommu_enable_gt(iommu);
-	}
 }
 
 static void enable_iommus_vapic(void)
-- 
2.31.1

