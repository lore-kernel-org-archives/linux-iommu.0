Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A27C23AE
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 05:38:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwqmhAuZ8YobaYMlkWvmAovumRax8ogEUxn/KJUrL2w65HcyweH5mD7QzdRGsVwdd0tim/Qn7NB5w6ezprttfurSni/GupaBQa41ax1If3ynFjrzOxZbYQsDYG6XKKLlHhx+ABtqnamkAFPRUWHJ3Oy/lVzewUEPx2brzt8pF1M0J2ltR31CWMgyH2/T507oSxOVSpPfoguvNAPNAAGN+EN6hsAQ0S+cGL9zvDJhyZ9BA3ekVXEaq/eCR9gRfyZqGoH0pB7yCZOnFgEn8yJgG82LQfImo7R5V2+94O8vCZAV5CQ1X6Ww6oVn3QND9oJO9UQVu49N1sG3Vee//Ypdow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R74BI+Ka/xTljjdKQBcHKwsmjn11XLCz3d84bBvl1hs=;
 b=BBrokKHWSewYh7yzvcXbL+qsuZsrjia4xocQPIOesyFx7tBQ3L93CCF1PqAuz9hrY5Mz0AWG7UGj64hufbM6QwSH7NhVc/hPhqwB1J0d4i0fa0mrqwjQVBistBew2ULCeWF4Y93pm57Qxhnh7FQ5ngcjmrfjW4lE7/K8LzorxRNLVcS9QBkT/eL3ABEXNl93OSPs9uOFWQhFGlq53yTxAja5AeHlHnBTGz0tCnv4Te6o18GU3g/RYWFISWTbofiWsqiZmaUKKFEOy9pdvI5AxRu8BrpOkqbgwDzIFVBvbHgVTuVp1JLNJ09DuEeUXoGMhcWL7552EHitfM9uZleO2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R74BI+Ka/xTljjdKQBcHKwsmjn11XLCz3d84bBvl1hs=;
 b=LXiT0xIK9OhEriDb3ku2Lub56sLiccsdZb3BfcwNg1XIdIGwqA1YNa60Num5wWu8RBRD+FKXOj+bEH7BJcq/xWfxOuVWpvP+nud57I1yVUU2heci6EKQlRyfY6sur3bef180Zy5501SOZ427p25wh6rwMcJhVu2ogwf9UzJ1D70=
Received: from MW2PR16CA0037.namprd16.prod.outlook.com (2603:10b6:907:1::14)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 05:38:54 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::c) by MW2PR16CA0037.outlook.office365.com
 (2603:10b6:907:1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 05:38:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 05:38:53 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 00:38:42 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 08/16] iommu/amd: Do not set amd_iommu_pgtable in pass-through mode
Date: Fri, 28 Jul 2023 05:36:01 +0000
Message-ID: <20230728053609.165183-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728053609.165183-1-vasant.hegde@amd.com>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|LV2PR12MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c2861d-1616-4e63-7ff8-08db8f2ceddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bnwz0wr+rC14YNOJ9XL/E3OmoQDWMdDWQdEufEi9LNYGkN1o4MVxoFY+GdafXbvKCDekBm5JWru5OzognUa4XDQzPeEWO4+kY7sfY3FaHeM86KgwbVXL9V6oLzQ3JSjR8H5DWuLHAMdvXYrCqRJDGsIdhf7gdAt3q/IIke103XnPtR5c4IQepCAYrLic6743NWcRvIasNWj4zT55a4KrX+nE6u8BpW7fLAY9hCPMkRDgEGYfSUxJ700OKDM11QIIh7GlJz8cLEYXnReq5+D7vwbZXbeZaf1DHnmqh1m7ivOxLmovb2eX40yQot+L0SJKu9Jw42yRZJvWaX4cwdZWRjTNKwWqkGkm1KkE8zjlEWhprbvUk7VTcirMlyhwtHIRfHnn7LiJBGqhUbyRopsHWrIXI/kb/FgSiLE+g9iPBmjLrZSP2fDzobDQr1LHvTcS+pc8Th9FCUCBkDGqtLDo5jAW8/zQCOXq9+Wu22D+CXOPz3SkKyJkoNMaSNxUpKHrvn9ghDxTIYOvoHXTLX/kLldn8USo6AHdVjBeIvPsw63RCTnBC9XbogdS+q/K1T6LXP/Hk3d/DVzEl6LaxQbttkk4NYjEAoSTt+m5E7ce+nkxq2u+ug7QHFt1PDdT6imBjPEcDwGtiE86OIRIJoW4T9hozRduXOiBPoE5dhLpCIplQDGPZijkDfiP7WS6ZwPu7R6BDPr01poTX23XpCITBAjdwbENay+V9vlhR4N70xUwV1IbsaV5yhdL1dkPpCLS2Qtkn7IqcY7AYKnVDj4J8A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(110136005)(6666004)(7696005)(54906003)(26005)(83380400001)(478600001)(36860700001)(40460700003)(356005)(36756003)(86362001)(40480700001)(2906002)(4744005)(2616005)(426003)(336012)(47076005)(1076003)(186003)(16526019)(8936002)(82740400003)(4326008)(81166007)(44832011)(8676002)(70206006)(70586007)(41300700001)(316002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:38:53.3569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c2861d-1616-4e63-7ff8-08db8f2ceddb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749

Since AMD IOMMU page table is not used in passthrough mode, switching to
v1 page table is not required.

Therefore, remove redundant amd_iommu_pgtable update and misleading
warning message.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
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

