Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007DDBD2B
	for <iommu@lists.linux.dev>; Tue,  7 Feb 2023 09:18:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5kXWLvvaL6/2KVnHQFABA/mJnFYhoj/tAL04clhSO6+qDslwzyt7YHCOsTLZEAB2r/yPhH/UNKdRSKbOvtckRW2HJVPcWSmIB9K0zWO/41wNmlXZSb2rOcxBswSehoJqdasUZuOazkTOG1SRzuWUur1pt/qmouTZ4AqCN1ULPVchaAD48mPfW8oC2INexFJvMVSHKMNli63ZXtBV2sLm9Sih5N8AoVMEe9VKExCGQrlM/+nM3ZrQ2dD21vbHCsdR9UcH4fDgYXEs088UHOOYBI6QrFFjPE2+1zyrWdUOkAds8/6wKGspXF/hy9jIYzHXNcK3La6yYLe4mIWw9AGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URuaLdJPnW2XahQW3TaKzmTNue3C/8WwHaklFsCRGnw=;
 b=ILujo9lGOxw5W9SHT94RRGYEiHVIpjLZF04vcDZ7x63NxC2mF2MCI9wXhoKeNCMmph3Gj6OkwD9PiO4mvc4APdnUeOrIgBPgKTi62QmHIolIKx/ByRTiFYyEXov6EI2emxxkbxcg6XLaOYg7gkIggd5ACvEDAlXrkEQG73aaEDA5Zwoy3ORoMdiN25SRx1CytO84OPQqusPlWzz4hWf4X21Odu9w/iel6I7I234CwRULR5djV4XRQmKTxV9Jo6Fkp3N5RRqFtJhXSkSMJMZemLgBxMBudcfPmcboSTzu+sIswFCooj1iwwiBfD/90lJV4hXCpiDciyHrvORkMwfoXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URuaLdJPnW2XahQW3TaKzmTNue3C/8WwHaklFsCRGnw=;
 b=QFGRC6Wy8g/2y9nqKpLEr+dWhMsAkxET51UARTZIqbDnN7cqoiWaFoNKiI64TdDfiLDydT/GWj4H6KE734SlI9YJTUdU47cEbNeFzl868iIIxH4LShI6Xyl90f2Zl4EWMhZ0KFE+NTcjPx0xlFgYlMyUQAqbFlGqkl4o3ii9Wqs=
Received: from BN9PR03CA0315.namprd03.prod.outlook.com (2603:10b6:408:112::20)
 by CH0PR12MB5153.namprd12.prod.outlook.com (2603:10b6:610:b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 09:18:42 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::58) by BN9PR03CA0315.outlook.office365.com
 (2603:10b6:408:112::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35 via Frontend
 Transport; Tue, 7 Feb 2023 09:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.36 via Frontend Transport; Tue, 7 Feb 2023 09:18:42 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Feb
 2023 03:18:20 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH] iommu/amd: Do not identity map v2 capable device when snp is enabled
Date: Tue, 7 Feb 2023 09:17:52 +0000
Message-ID: <20230207091752.7656-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|CH0PR12MB5153:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aac4733-2d7d-432a-a94a-08db08ec4e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LcEZFZWpkbwtqMgiAai2UZN6AsWwIC4UH2ydwww/qtCCg8aCr/xPbt9Pc//xMzVDmFZg5ALe+MK4ywIqT5E2NVVZNjcIdpexu5nA4NCAPv5ok4OkrBGgQk+pasZNh64KwuBr5M0Dw2HXkIZTa2rAT+Y9LakF/JEmLYxBUQ6bO4lFIwp8nx8r1ZVN3M6CQ3GtMGFbCGUW0JFilyr/eudY7ifDXvBuwShpgyrBmeTgRYkyWvdOYtPbqcgnVw+gultAo/Fpc+rVKm0OZNsWERJ+9+Ei4rB2Xm7NJfgP6q/pkxEu9XEcWwpYY1kxEhrhkMKEp5c4SJfEb2M8XjX/HaeykS4CpRZsrhQMwGtDl3uS9fHTUoELlUJeZ7otMXYxMCgfY+RZ36VuWnNvv2blyP895lR0TVAlfMSiR2p1Q8BDM2jvBlb/WFvcoIWdw+3DFeT3a3pK1zLqe6FUHF5gnyVRwA37YOciA0MMd1+u3HeSsk3iY5rsXeTyjQ5lnmGE2oFga7jX1ngeeasxsQZsLzRON6sSyrWseg9C4P/kpHV1iMdLXOyq81Ue/gFGRWRUaIfGNaWBkQ+Q78UvswI3eqhGo4q4h+rDCHqigqf/z0mAvMI6FvIa3bJlF1CwNl1E9jNjuoR3TpSOvR7NtbL1PUIIdgWAa+6KRjJPQzApV4xd9YKsKZqJ4JfSsn9AbbGichKcKIerF2ER3RGFXSVqmGwyob3uM11wUuh2p4QQA9kGB+0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199018)(36840700001)(46966006)(40470700004)(36756003)(40460700003)(7696005)(41300700001)(316002)(54906003)(1076003)(6666004)(478600001)(110136005)(5660300002)(2906002)(44832011)(8936002)(4326008)(70586007)(70206006)(8676002)(36860700001)(26005)(356005)(82740400003)(83380400001)(40480700001)(86362001)(426003)(16526019)(186003)(2616005)(336012)(47076005)(81166007)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 09:18:42.0752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aac4733-2d7d-432a-a94a-08db08ec4e40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5153

Flow:
  - Booted system with SNP enabled, memory encryption off and
    IOMMU DMA translation mode
  - AMD driver detects v2 capable device and amd_iommu_def_domain_type()
    returns identity mode
  - amd_iommu_domain_alloc() returns NULL an SNP is enabled
  - System will fail to register device

On SNP enabled system, passthrough mode is not supported. IOMMU default
domain is set to translation mode. We need to return zero from
amd_iommu_def_domain_type() so that it allocates translation domain.

Fixes: fb2accadaa942 (iommu/amd: Introduce function to check and enable SNP)
CC: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0b011a97e20d..3186e0dd8b2b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2401,12 +2401,17 @@ static int amd_iommu_def_domain_type(struct device *dev)
 		return 0;
 
 	/*
-	 * Do not identity map IOMMUv2 capable devices when memory encryption is
-	 * active, because some of those devices (AMD GPUs) don't have the
-	 * encryption bit in their DMA-mask and require remapping.
+	 * Do not identity map IOMMUv2 capable devices when:
+	 *  - memory encryption is active, because some of those devices
+	 *    (AMD GPUs) don't have the encryption bit in their DMA-mask
+	 *    and require remapping.
+	 *  - SNP is enabled, because it prohibits DTE[Mode]=0.
 	 */
-	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT) && dev_data->iommu_v2)
+	if (dev_data->iommu_v2 &&
+	    !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
+	    !amd_iommu_snp_en) {
 		return IOMMU_DOMAIN_IDENTITY;
+	}
 
 	return 0;
 }
-- 
2.31.1

