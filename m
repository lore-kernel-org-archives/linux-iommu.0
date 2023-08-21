Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2D2186D
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:45:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=et9rMeiHHsk9HHn/FKLT7vCA1NK55PEkXJquXBdYie2Ybgqw1De31zk0xotyn2ULkrNbP1mBhbsW/WIfQWCQtQ/p8+DHKs/4p6JmssNYYj6qmyxzIUAvK03KpSUN09LK2V5y7xD3ALP79SdGt62an2+Iyl+z+ddwl8egNESWoXEKOTfVGSmb/kXyhSY/VCdxK1xoQdF3HRbp/rCkBHafNnoU0Ly55DPm6POpn6aUaw8ruGnBFz0Naa7IQ5GjTYWdxBnY2qen+L2b5L7nu1KnwxDBnfhvwUwIrwpait80uFGPXYSJbhO/M/XBeyu72RccD6olQPmRE9mDQ5IiTtii2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8n/TrukGJyyy+IE52uMyhF7M+mgDNmxxiUDMgRXCtA=;
 b=Bvun4/SejjeFlLr3dtfVVoberXTbLX82duJKAfQB+kaHaVry66nTOz2lRO1lER9jOSQqu8TdhQdvQWONL2GzZ/usHz7DvQK2MBjaz3lnx/jStor4TPFsa0K7z9YIrKDidCXw4LacbIIlXtdd/9+8VqOmvLN2Rkcw7keM3K3014MQ/kHMZ9u3miQAGG65KTGy/yYdS4ZFcUPjMkU9Ai87CNlZal4dh+tU4REg3Eo+HPksMv3m5wqBzKEPtWrvkHw8FgPPefW7oojWY8N/pL9Z9+dqbUBbE7Ywp6qY9yu8CdZYCMAxFZtd+4POhyc21kFQPrg6b7EE5/inl9zleIU2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8n/TrukGJyyy+IE52uMyhF7M+mgDNmxxiUDMgRXCtA=;
 b=boxQSYb8TR3EO7Jpu3wyh2nb4uDE92csTqQe6bS+FVU1f6Xt/x74e+dpsJLur7wce2XwKKSXVjyiJsoIbcHH8pg1mHFT4Ix1WrNpyoqj0Q0LZjiKjcmupTuQi7vNJkTnedZa/huV2VoXbtV49zDENpSv68prP19BLYy7+mfzSdY=
Received: from SA1PR04CA0018.namprd04.prod.outlook.com (2603:10b6:806:2ce::23)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 10:45:36 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::46) by SA1PR04CA0018.outlook.office365.com
 (2603:10b6:806:2ce::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Mon, 21 Aug 2023 10:45:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 10:45:36 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 05:45:01 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 06/14] iommu/amd: Do not set amd_iommu_pgtable in pass-through mode
Date: Mon, 21 Aug 2023 10:42:19 +0000
Message-ID: <20230821104227.706997-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821104227.706997-1-vasant.hegde@amd.com>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e9f353-1f57-423e-a6da-08dba233c0f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/g+omqOWu1D3J7C0pxcPJrRZIN6TWWZiH1e8SDvVvyVMxt2PAocdSXMKeOw40Oat7vaA1ZqTLsATYa0f9oWaMTF9QpwfuoxjzLEBHl9q1dWhyCrzyzL0NO6FCcqQuJjkKxYfrLGLeGhRys1sTM29//DFV27ekzsYOd5xW+RVqNKx2SpnVVZ37RpRxVPerg+RzEj9AoVCbPZhdRNnj307QkzPcyvkTM3Buhw/TajzPLn+2/WACGAL+6qWO+9+EFNWUE4Jt8r3Gh4u4b4o2XsTHKb0f9i7uBOGs6SVXSpgUnfKoUhqPpbAWM3nmUreR0i3PcA6NLu363OHxTdnQc4dPw4YB5XhQ74qAKoyJPCsXVUjJEOBe3ege3CtguhNJOPWeZu72H3TwL83aMs0SWob5qW5v503O7BZVbUN+7ArT7Bh/YvkH/BWiLeY55wB79Z9i3zH5JGe+I4XwhtMc4Y5r6OSuQHaN8BF44esXN5urDiPPU4iVObUEAgXaYlvbkvoeo88uk3DcvnK34QeHXXBkOZLMh3Ne2KATC7SNhC29wlLiFpGPlz6DkglnwP9rwkJKr6/AZDMLMhsg93omXOxPAbBmaXdbMxAQF+myH2m6Bxq7CmktUp3SPYiSs5bSp++S+Ts+tQYJVr79WM66EOAlAXsyePUuOjKB8IwOwSNw19cCSRWOlbAH7NKSptJpa8Teu4Ur3fk5T5/W0i/R6q55uEYwTpwKUu3Za1x8LcyhUwETe1nsT4N7AB3kLjjZ/CijC1h3NZ/DpEKLHofjfFGDA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(4744005)(83380400001)(7696005)(40480700001)(5660300002)(44832011)(336012)(426003)(16526019)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(54906003)(70586007)(110136005)(478600001)(82740400003)(356005)(81166007)(6666004)(40460700003)(41300700001)(36756003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 10:45:36.6566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e9f353-1f57-423e-a6da-08dba233c0f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570

Since AMD IOMMU page table is not used in passthrough mode, switching to
v1 page table is not required.

Therefore, remove redundant amd_iommu_pgtable update and misleading
warning message.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
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

