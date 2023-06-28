Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7E433D7
	for <iommu@lists.linux.dev>; Wed, 28 Jun 2023 05:47:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEf7odPsUbimhDfpJaTA8f5E8AhFbRKcuV/g0lj5ktNlAKWCvbZqgm6JITy98qJ7U2ROcQcLS1iwAT4a0JXMml3AYzJ2NzbHGOzhyIi9DTEs6yczo2bOwWLt0ln2CinAjtAVCKkPN7D1tUFKwx2Gun4X/NO6Exi2RkBA5lnOgcIIhMrKcS0BTiercYzPkpHRAdbqxJ01CPFUY8EsG2r0BedV/rJBAAxBvrUja1HjxtAskJl+RMq9HNPrRyziyd7gHem61vuy1p9qAFd5HcJei0sO0/OpwGGj/Uv5eyxD61QqJ/SSqjZHDGEeQBLavE0MPp/J5n1Fbmm3KnUYy63o5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJ7JUDdyQBaJT6mT8qdDXun9qzirUHt91FD2zYRiDM4=;
 b=YyWCL7pyelja3f5/4kOTyD8SOQll99T+i52pesrDXF/eiwQBkVSpLPmF3FGp/ZsN8YxNnx4e5gyaCfWK/E+IP3XZkO9VS4TOhah6RL7ly4cjD8ExXN4BP+i8Q/EORuJIWzcruxNv1g5qKs3Y7AeuOPqkHFNbl/8BP1Om4MBoFVlu/ss3j6WkVGTxEZM+pdAbmXIkUxNTKnQ5yp9ZehhByELkT3dLc6M6tGBz9gfDtVB68su5Ujdmmb+pIEqdPogpJVxCCZNdHmJp0JCD+HQx6pEQUdw8oXxGaftoXAdTAiGZ93fStCGb8NFIj8kLrJhl88rhIHokit39k24C68QyHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJ7JUDdyQBaJT6mT8qdDXun9qzirUHt91FD2zYRiDM4=;
 b=Ll4/DCYkl1Riwp5dt0xtjLzgNet8gc5ml2DKg77wksOSLgXaIeZgwOd0Rmjpab+3aIFPeAClwjYYgZxFqEzrTPpllnNFhjftvxZXbal7Cqo0YYNxJ6bomEE122xAKOOt2H+proEOtcSl+JsfWYbB8HvwQEcf/Cr/Oy97rp2c/CU=
Received: from SJ0PR03CA0031.namprd03.prod.outlook.com (2603:10b6:a03:33e::6)
 by MW4PR12MB8609.namprd12.prod.outlook.com (2603:10b6:303:1e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 05:47:01 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33e:cafe::d3) by SJ0PR03CA0031.outlook.office365.com
 (2603:10b6:a03:33e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19 via Frontend
 Transport; Wed, 28 Jun 2023 05:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Wed, 28 Jun 2023 05:47:00 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 00:46:55 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 3/3] iommu/amd: Enable PPR/GA interrupt after interrupt handler setup
Date: Wed, 28 Jun 2023 05:45:54 +0000
Message-ID: <20230628054554.6131-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628054554.6131-1-vasant.hegde@amd.com>
References: <20230628054554.6131-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT021:EE_|MW4PR12MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e4488e-4057-4f0c-83c5-08db779b1807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bGRPi8aYM0GJ8qu8lUzOvgmlnpmAL+2F6pCtwLGSQqD+5FPNuF3UeBRx4+BUusp1yai6k5afCQpSBq/aKD0Gh58XJ3PfSFIB/BVSCGl51soZ7hP3wImgRikPB1Tb28exi3YOpmVDvaT/YRvJ1XfV+ipd8P//gb6RU9JMb+l/UJ/OsDWvZXjv1e5zzT4tmaYeeQ7QQaANTxZj39KGettCT+BeMtXD28rk8aXhOp11T1khmj7jlYGC4nPtdTAkw7CswjwSIRsbNlIsxvFbcu+DRNujwLniS5zYG6upLNI7si9salwMjE8K1M7lViN9uc0c2YWpkgL3ti1m604rz1q9wGDHht/5EBWTqfpaY8X1UJQCIAzx4XsuXy0VkpCTQy/b9gTIH4PRzNmXF+FqoIC00x9t/soFGb+slw2kr4T9y5Q2OXR9epBr8tDY0f4X7mQbLh9yoEkgi2YUhoatCNz3Zv59n2InhXwpNdykFnnCyc+8/s1O6/X3MjYh6T2ZcwvESL71zHmZgXRqd16MjYWDT1R6+wvciz/LkISJE8pnkcXWl2C6NDHSwXXxNZ+QqVxafUufJana7r3E699glQR/3A4gqwb/NU7nMobQ9OPl360LmxGrh4UI5qqfd1Z82M9xlC/iVynHvSuhUtVuGEPEhUvz7Zqw0s5gOgPG/GFpLnVuLvsSeMSvUIso1QubBwCun+FdX3PsJANHQ6K1UEm63blP3eANsIcDy2dgF7bEoPtoQVW9qhWITJpbiQeBL8geLyRpj4ph6OSIs7qYKvmpAQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(36860700001)(26005)(356005)(44832011)(5660300002)(70206006)(86362001)(40460700003)(8936002)(41300700001)(4326008)(316002)(8676002)(81166007)(82740400003)(36756003)(70586007)(40480700001)(110136005)(47076005)(16526019)(186003)(2906002)(83380400001)(1076003)(54906003)(7696005)(426003)(336012)(2616005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 05:47:00.8120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e4488e-4057-4f0c-83c5-08db779b1807
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8609

Current code enables PPR and GA interrupts before setting up the
interrupt handler (in state_next()). Make sure interrupt handler
is in place before enabling these interrupt.

amd_iommu_enable_interrupts() gets called in normal boot, kdump as well
as in suspend/resume path. Hence moving interrupt enablement to this
function works fine.

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f26c077eb9ea..45efb7e5d725 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2943,8 +2943,6 @@ static void enable_iommus_vapic(void)
 static void enable_iommus(void)
 {
 	early_enable_iommus();
-	enable_iommus_vapic();
-	enable_iommus_v2();
 }
 
 static void disable_iommus(void)
@@ -3208,6 +3206,13 @@ static int amd_iommu_enable_interrupts(void)
 			goto out;
 	}
 
+	/*
+	 * Interrupt handler is ready to process interrupts. Enable
+	 * PPR and GA log interrupt for all IOMMUs.
+	 */
+	enable_iommus_vapic();
+	enable_iommus_v2();
+
 out:
 	return ret;
 }
@@ -3287,8 +3292,6 @@ static int __init state_next(void)
 		register_syscore_ops(&amd_iommu_syscore_ops);
 		ret = amd_iommu_init_pci();
 		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_PCI_INIT;
-		enable_iommus_vapic();
-		enable_iommus_v2();
 		break;
 	case IOMMU_PCI_INIT:
 		ret = amd_iommu_enable_interrupts();
-- 
2.31.1

