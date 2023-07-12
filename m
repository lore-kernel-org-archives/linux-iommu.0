Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D33100AE
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 14:18:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrEqkwzRu/Mzqh2eu0W6gAYo1uP3lTn37M+DlTIN9gHJHOfxrUCRF1msKgb60gFiB7vXe4XTqwGkaWBdTHTpB3fHfJldD2AaudImDluOlcjEOHBPNVgjQgfdSO8YnomXeZsR78jYDZAGPjRwdyIHBrmI9VilwCCvQvWW3RgrzHaeurME1uy7gRYU3vbNRxdZPMWuZORTwRN7RXLwZtcBbwgGx79rM45FfUr92BT8JOLAxPVaOkL0g19hVysNBhfgZSU8MSNFRrGvlTh0WCYx3cu5xZMsUrwQCIzYw/mBlUWBhpKGIv8RC4+N1nrJBLGGrgLjJY38DPSlGQCq4/OhLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MMDeRCY1eBQnIn12MDfZESTgQFaUd2/IVG2i8cwqUo=;
 b=FJJCOCfpVlRQruNp4r8hWQ7mVihBNRfe633INMuTklV0nRtMKQU/ERNjBjBHboCiVMhL/FbzXkrnGnyWZU2Z7iQ7CzhcirC6m3PDWd4JLvUnImDDe8gMHhCQi4lswevlEFF5ObJR9in5EZ/J3bmRm47KCdmwY1BAhqWGE76AqFFcYjQkTaJk0Mu26mSVPQmLOzPb3+4FX0T86JnfTJQLsUNXLYbvh3NGDCBrjpCQ+/eh/lPP7j6Ky4FpaoI4EdnKdiN1slA28lrJ5dBo2+teba2s+3ZE3HM5xH2Kh2dV7VDKVnegX9XglFA3aXO36IQ2KMd0yz0OqpZWKt/S4C1A+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MMDeRCY1eBQnIn12MDfZESTgQFaUd2/IVG2i8cwqUo=;
 b=XiWZgJjrQSIS3jYfeuRckcCmuSRBx+zP+ZZHtj1WmMSKhqTqatP2v4n4Ql7EnVJZ1W/3eoaJ8IF1H1iLAyCSde79vj3K6Hg+V3p6DN7hZ2ECw7HRxyVEO/3LCBy4CB0s/+D75PWtMf2cFfBdxK51UOwIKGU9GLyXK13pA3c76KI=
Received: from DS7PR03CA0169.namprd03.prod.outlook.com (2603:10b6:5:3b2::24)
 by SA3PR12MB9107.namprd12.prod.outlook.com (2603:10b6:806:381::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 14:18:54 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::35) by DS7PR03CA0169.outlook.office365.com
 (2603:10b6:5:3b2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 14:18:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 14:18:54 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 09:18:52 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 12/21] iommu/amd: Use protection_domain.flags to check page table mode
Date: Wed, 12 Jul 2023 14:15:07 +0000
Message-ID: <20230712141516.154144-13-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712141516.154144-1-vasant.hegde@amd.com>
References: <20230712141516.154144-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|SA3PR12MB9107:EE_
X-MS-Office365-Filtering-Correlation-Id: 828978d4-7b27-4372-fdf4-08db82e2eca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GGU/J1YIh1jZ3DjxJVooTQHhUHaMcMmZffeX1yLOW3cpXmxkM+2Or5gcMv7OpmMVM40iowdlvoB8tWqD1Mu+foJ3Is5EZvzuD4RimQqthX+TOle9d9IHQBOKytT7hflM67KWkPbs3SadNpJAROxRCsp09ViF3xsL87xhDmM/7/aSMxU/xCK3Cl7gQeAK7gIMB1Ei7O6bVgw5C+3ngKV59DHDnmdDukE5CtQ2YQYw9FCGIi65grhtNadikb/eErasq7kFkZghprJzSScZcpBElJ0irpNeNduMVx6hvQnyA3dBHjHMDX5Heqy0FsAgfEwiT0Bi4WhzU6Gy2AZYcnULdEWulcBYd8Ko+wH1Da/otfBH6i53Bem8O7pFlqLBTcEm0A83tpZFjbTk3sVVuQUIVKp/27pDk+u9giiLUmS2S9GRLfk5XN9jKk4PCN69d8YSu7gg0u7iiaMClR+i5Y+DlDaTxDGnzwgZ/1ogxsp47xnfwzGJMqQoJ515arFP84o/hrgMr59L/R8TGk1Z3SzDHgdXnJyDwHPjsMHUAB57ezUVOmws7XF7CkNs5dwi7fNdtZwh8HaiL2losMW1gDARPELUVyrYTcYuHZYTrU2UUsFuKzSeSv4i07S5nEl7yO0f2LOWB9YqVcdWOYpri1IESI1oZgGeJGxQ3zzd5WXKKLvi8hvLBSYEBL0PubYReV42He76GI02K18NB3iPuA6MFCVZQX86Vu3i45xLcoUFN4G2dZjY1KUunW48pjy7JIblz/OWINMYtZCKJ5B0ppWzaQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(7696005)(40460700003)(6666004)(36860700001)(47076005)(186003)(1076003)(26005)(426003)(83380400001)(336012)(16526019)(36756003)(82310400005)(2616005)(86362001)(81166007)(356005)(82740400003)(40480700001)(70586007)(4326008)(70206006)(2906002)(41300700001)(316002)(44832011)(8676002)(8936002)(110136005)(54906003)(5660300002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:18:54.6928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 828978d4-7b27-4372-fdf4-08db82e2eca7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9107

Page table mode (v1, v2 or pt) is per domain property. Recently we have
enhanced protection_domain.flags to track per domain page table mode.
Use that variable to check the page table mode instead of global
'amd_iommu_pgtable' in {map/unmap}_pages path.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a138727b3176..685efe942ce0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2274,7 +2274,7 @@ static int amd_iommu_map_pages(struct iommu_domain *dom, unsigned long iova,
 	int prot = 0;
 	int ret = -EINVAL;
 
-	if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
+	if ((domain->flags == PD_FLAG_V1DMA) &&
 	    (domain->iop.mode == PAGE_MODE_NONE))
 		return -EINVAL;
 
@@ -2320,7 +2320,7 @@ static size_t amd_iommu_unmap_pages(struct iommu_domain *dom, unsigned long iova
 	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
 	size_t r;
 
-	if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
+	if ((domain->flags == PD_FLAG_V1DMA) &&
 	    (domain->iop.mode == PAGE_MODE_NONE))
 		return 0;
 
-- 
2.31.1

