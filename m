Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084A110788
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 10:24:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y51oYaPWPHaHVnJ1+GdUw6MuD7ISBDh7vBLBn8JuuvGmfE2rZNj/svnTiPDYaVjdbK+0Kjj0TKj+CUb3eVLK61KKBS/tuNz9olqddXZR43CfBqj9UIlfxTZOMcMbNplW9+JlofX8q9NMOhEVkjsghxonx+4x9McvX9UoB+Bs5whRiDdWAqxlOfzyI8PMTEGmgde27MK1GeAg2vQqksFaPrg4pm4dRQ1MGhkSNjbGAW9xP5p+CoOca3nByb3dbWKt7gGYw3dTsuANWrtFilXeDc612iLipDjSRlxmHSuxLDhyWfN6spLl39BoKmzzkCWgmVZrX7H9ed/tC4JbG96ePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IP1w+jr3KpYTwe63+D3w/+I1rJjBdD2uSM4JQm8KP2I=;
 b=ADaS7epwci34wEqc5FetPeVpvMXAVna/l3lhyhoWNBtx/D8fpfkR/eRuoj2zaRXmfI9gNd/eamsMzPXeu04mKBSf39M3WDv5lFubRupT0exNRvKractEDbyvB+TL1IN/3yk1o53RTBXMZrzM3VNu8pMWKSy3MDUL3c16HApfZuOV+yAKfx69N67ztp/gLc93RqiCW3QEqlbgkhOD6AsvoJ+8AjmIZQNaA5/xUeubDFK54nXM6JbBIq843Q07Cbhvy7VSakR73t1YPPVNUoJHQR5cVYCYzJpUdvjCMYwRDSn5CWD/M8KzhdyVojJ/UICQneXucIY2FnlZNIrvVyoFNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IP1w+jr3KpYTwe63+D3w/+I1rJjBdD2uSM4JQm8KP2I=;
 b=o0jAUMjZ9NZE7bhn7FrqCSejkwCcRW5IzxD0UoLj8LOgPXlGeo327XzaeUMi+o9CAkx1CbSkEcAiapOQO57h6Of0Ds98EPFGS3a8nKSX11HNZ1iRnphIG7r50q0ODwFLH+TeOAs7/gZHcWMYlC+zvqa8cfAIhitjuBtE/LcojZc=
Received: from MW4PR03CA0125.namprd03.prod.outlook.com (2603:10b6:303:8c::10)
 by BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:24:13 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::17) by MW4PR03CA0125.outlook.office365.com
 (2603:10b6:303:8c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 10:24:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.3 via Frontend Transport; Tue, 15 Aug 2023 10:24:13 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 05:24:10 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 06/14] iommu/amd: Do not set amd_iommu_pgtable in pass-through mode
Date: Tue, 15 Aug 2023 10:21:54 +0000
Message-ID: <20230815102202.565012-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815102202.565012-1-vasant.hegde@amd.com>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|BL1PR12MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e34cba-c568-4851-c330-08db9d79c5a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kaVrX9XzFvBaEX2peeV+mhUJ21qYarGim5KtZ8K3WM62qJa72GwPPWEun3dP+6Tmg+n1Mw9C+xVo0q0dguxAVWfIPh0dXyzyGjzD/oKymh2oq6ofPic/1JqdKieHxSUqX0IQBn1dA/sf+oIMdnmk3SjvmK95T1iVn14vRADhlUeBqM4xbhqYDqVSyy3/XKIckkq/mOqPU38zO94sK1lOoRv19/Lol6KYifxF5Mannk49/zOwXyeL+StvVGcrtfiOsADq/z8rRvqqp8QLv8+OlveGWHl/RwcBazRuGJsviw4G/yG/+bj9GJv6YkRMW1WdBvlueaBrfpnJND46CKlf7C8BF2k+E2hGAcCSWGVeK9ASs+nf7K7laAQ5WaVIcfY6cS1VwDb8hp1WEJFqUpsMxF8MrAViYS3KHFIHJvNsSaSCeepeQ1yibPFiZQMaLr4mR2iDoaA2keFpcK6HWDXtUlKR2A8xr3VfY7XKDfjbhH/ISDGoNh7tdd2M4+XBm9rx0y/rqW+c2RU9S3+Y2gTtJAL0jmlb/9Fvfd0AWI144meEnhzonzkMZjGET4r/+g1KpymMVROsAHkslr0lqRKxEQd429GnfHuKJgsU6PM7idfpUPhjNTjwVyUUA24HBt26rT7ljMFleLmUP/XALwyG4IYbuzK7+4yRD+RCuX7wntenkT3l6687FvCI2/AEmEctpx18JKqvpjwEIyWu7cIUjsoJ/vFKhvIwj6ZVjIpZEI7VKjib9Nwm8L9Dv9q5NXJe0DN4dGEwXxhLdgesrjZLdg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(82310400008)(451199021)(186006)(1800799006)(46966006)(36840700001)(40470700004)(40480700001)(110136005)(54906003)(7696005)(40460700003)(478600001)(81166007)(356005)(82740400003)(2906002)(5660300002)(4744005)(36756003)(86362001)(44832011)(4326008)(70206006)(70586007)(47076005)(41300700001)(8936002)(8676002)(316002)(83380400001)(426003)(6666004)(336012)(16526019)(2616005)(26005)(1076003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:24:13.4229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e34cba-c568-4851-c330-08db9d79c5a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270

Since AMD IOMMU page table is not used in passthrough mode, switching to
v1 page table is not required.

Therefore, remove redundant amd_iommu_pgtable update and misleading
warning message.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 852e40b13d20..2b01dfde6cab 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2134,9 +2134,6 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 		    !iommu_feature(iommu, FEATURE_GT)) {
 			pr_warn("Cannot enable v2 page table for DMA-API. Fallback to v1.\n");
 			amd_iommu_pgtable = AMD_IOMMU_V1;
-		} else if (iommu_default_passthrough()) {
-			pr_warn("V2 page table doesn't support passthrough mode. Fallback to v1.\n");
-			amd_iommu_pgtable = AMD_IOMMU_V1;
 		}
 	}
 
-- 
2.31.1

