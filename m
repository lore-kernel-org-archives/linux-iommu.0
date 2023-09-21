Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DD78F55
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 09:24:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fy6xOms7CpoJUUepuTYEV6Bus1pZsJPvfmapZCfNA9IRAMQwRtL8iu6FayTw94MvgbJc/jnZKqksu6aDlMIvhVgqaD12ptwF6DSMvhSJ/L2wBh7Xx4LROf3/yEaoXp6zbi4mbdrByCDZlAoUILQ+99BI4EjfEn+9MaFg58hpyTaZ97X4hjPul9qU8ugzK9/SGnjStMLszRDq+PR/5vOOcN7I5N2FtBl2vA0A0rUV00SxlfjDVfm4A+YrP0InAEbQLgRfwclHsXFOgkjJ9jJ2/QzxMKPlzgjU2MzFbQkFTcsPOO1WTEnrbl3Kl07AmEgeNwDiVsONb9um4Y+wV70ZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8n/TrukGJyyy+IE52uMyhF7M+mgDNmxxiUDMgRXCtA=;
 b=FTACI+kO56wM/H8FwbBA2JTivlouZpYOyu4Zsvam6JOr8Nxt+rg2+gTwgMQZEobI7ChbZyO7B7pZUa1Ww2RQkU4h6DpPiXfSphljxvxq/MVLe0y1Xv991czpj6eubcYPEyeqDQI5gA8DxaeWIqXp1g5R78u/kLMfcp32YvmZNZ9GoqnD/QLLvJ8p4wJSW34yu/nL71B4Uq607f3MD4PgiozaESwEMPPZX/2PwkfQj+r7yLlM1AK8cBeUi1TwGe2dPqifelJVMVvjOOHzsRjle9/a3CPjlutd0/Er14+cFEpAHbsiXZ7QGyRExZ3C8EST55z0Lv7UDg9vaQZNsmVdkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8n/TrukGJyyy+IE52uMyhF7M+mgDNmxxiUDMgRXCtA=;
 b=WK/5zaMt63DvNQHSsWw4pMWZM92kwYWtlEtns5lzpyw7ywywyXbta1K1XWSH+ZZbIJAbn11tqPVw8E1BUNuvT7YvNZ9s3dUt3WGC+4BPHPDC+8yOXns/+f0jIg8kF8A7kX9sJmQvLSqKtEvF6IgKhsxNqytr14jl+Q+TnjJTqRM=
Received: from DM6PR17CA0010.namprd17.prod.outlook.com (2603:10b6:5:1b3::23)
 by DS7PR12MB5814.namprd12.prod.outlook.com (2603:10b6:8:76::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.30; Thu, 21 Sep 2023 09:24:36 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:1b3:cafe::5d) by DM6PR17CA0010.outlook.office365.com
 (2603:10b6:5:1b3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Thu, 21 Sep 2023 09:24:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 09:24:36 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 04:24:31 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 06/14] iommu/amd: Do not set amd_iommu_pgtable in pass-through mode
Date: Thu, 21 Sep 2023 09:21:39 +0000
Message-ID: <20230921092147.5930-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921092147.5930-1-vasant.hegde@amd.com>
References: <20230921092147.5930-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|DS7PR12MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eee81d3-800b-4516-5716-08dbba8492b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WwXN9TR6o4DzInN0Gq/gkQYH4lvJN3XkLn1quh6ECenijc6a4Aj8Ido7keMQ3TRxdK4rOmddEu1ZihKFKi/7OvCUD74+2FfTSvhZHatMO21UvqyXAU2y93pdTDeyjM6z2WSs41frWNZpwNv2qAR6aD+cVYrJ9R010eilfIPUCJXJaNbTulA/aNX4HdQ03bN2nnR/d13FwHXGT2l7hLN4ZS/cL6Az8xkmuUvZA28A/h+SdiFpTQst8a1iyUcKt1+ROGEBwUWOIrS+1cgh0oBmz6HXs9/R/avpueWschynT/jYNVXwjPP3EQGJn5/KoMbt+qRtkFPtLkp7zB4BqQaV/Rc9mDNY97K/6h/Rreb9q+gIFer3G9EkSEWlvsuObRqtvJVd/Bv64ii9nr9DRKuC7A9yMIw3J244zeL1mFdVnMwb61OghMeHgsikGVDHEiVMX3gLNtda6u4HT7/S5NSp9uJ5rYVWZXmMwvyEVrXGLV80snhD/dQ+9TrsI0WTSzvRwZZUoawgVmJf3gplSHj6lX3vQCeZ5Zx/b2WxVgut71eEsTeiAARTKo8WGgCneAzEe9N0QM+F7nyD61AaJceOMDZVTzmcMUC5sGNVjEEW3X+draa953FhW5s0CQAOHRw6JLiKXAjf0mwj5DnfNsl2O9mFJdZx7oVh+nuj61+woCPJ8e7LDyFdNYbzSdQ/juwXsBrIi8UepfwdL1XbcupJ3sQWnGL4rIFhxRpiaojr6L7QA4y8/UOZbHP9YUPEymBV8KYZgmOoVd90rU4kpVWVEQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(82310400011)(451199024)(1800799009)(186009)(46966006)(40470700004)(36840700001)(478600001)(7696005)(83380400001)(1076003)(336012)(2906002)(426003)(26005)(4744005)(16526019)(47076005)(5660300002)(54906003)(4326008)(70206006)(70586007)(316002)(8936002)(8676002)(110136005)(41300700001)(44832011)(40460700003)(36756003)(36860700001)(40480700001)(2616005)(356005)(86362001)(81166007)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:24:36.2123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eee81d3-800b-4516-5716-08dbba8492b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5814

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

