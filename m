Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201B9DDBF
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 10:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVf6+md5s66ZOvDQtJVD9S4xQlTN4cMkhtIgai6iiPMfZ+oLbP2BGLYt1iud/z+pdYqwpojS4hG/wcXFZHqTd3yN0KBDHaemLt0iL9cU5Abdo7Qlx8eoA9vCO4S0wKSApaKUwXlZrF8AON57kqmw0ttk+w2q5sb+l1m2Rx3cBecr5afjOFajdyGu6rsnSFPh5xyxcjuIb31aYCG0sVm9sj+Gbt36tSYVgcPZ3elGNKvka/fcSDzpq7iytbeRj0KFw19h6F95+p7GEu5onyymA+49iRXn8/W86xqLQ+w7cQCWQW+zIkL85O0o5shTKJw4oWGvvx9Q1Z32Wbu/OyftDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRlsl/s9ZPPLdLEPzzXTo4aT2TfOENFDUxA4xO+2A6g=;
 b=aEtuwxJEPV8glw3kpr8jUHH3PaWIPp4Pj+TaRq9HTi5m5BOPCQOJIToWe6VUytgY8xUP6fjpMeU8QPteWDZK6mDkQsK8nQNMzKTgEswhy8VlogGFZIvQuZCREMxkzswTWzQzOH2fAHovMb2JdoFUnBaMhjjHBGfhUU5H0BAq5Dka9NPBlhSJjXrmCdU2tmwUK+KrY0uJEguj6tH+yi2hmKBuJg8MEpchGEmN7s3GYtnrUGsgYbS19jOA1Cpx6QLD1Un6JIE11moEcB+pHJSiegmj7PiSEykiJcBZYUoGp/xMV4R0PpPJ+X8q8uL0WxtxSkf75ApeZir1WAO34CUNUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRlsl/s9ZPPLdLEPzzXTo4aT2TfOENFDUxA4xO+2A6g=;
 b=ciERPa/dFg/7BwHJ7CRyNm6MRmCqZzOKW3C9/xLd/b694uQnwcYjUkKFEhCt/k1spyGjoxZINgFYvdXV15VfVeUdrqBUV2GgpPATeP9NlfIv7J9vTSiCnrYHxZuD0q1/167eQjHNCrLLyTsmsF4BpS0FRUunJEV0spqOiRkGEKw=
Received: from SA9P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::29)
 by SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Tue, 8 Aug
 2023 10:06:07 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::6b) by SA9P221CA0024.outlook.office365.com
 (2603:10b6:806:25::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Tue, 8 Aug 2023 10:06:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 10:06:08 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 05:06:02 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 04/11] iommu/amd: Use protection_domain.flags to check page table mode
Date: Tue, 8 Aug 2023 10:02:25 +0000
Message-ID: <20230808100232.5977-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808100232.5977-1-vasant.hegde@amd.com>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|SA1PR12MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 05febaed-fbff-42da-03c6-08db97f71650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MddZ8lStug8/GcixxukP1jIpYDxEaLmjL/IkzToJi5tCAn4d7nXA5UKCm1gb23nXXqDc5TZ6FO44lRd0qJ98Qq0GnQQtwSjS9Ml8YTmB17R8IW19aIqsd05kqujllneeqFSMOpxfpY03EnwNRZuC0+BLLIaaj2AwfS6FeEHahHsyX9fk3CpwZQZurvn2J6Z+O0HOaTpDpTlr0QQ1hvZ4lLD6sVRdLTKifjJ1QggkaDTvNr9XzhOVkXWsjV4UNDkuoOyPY2YmnCFGIS1NkN5AesXYteknYzWxBxuUfnnlSZm4aZ2rfJKnsm9kn4kqOfxDsBZORPu7GTJIgRMkGFP7I1Mu6ANGx4YzXV5QHKfixnLM9b2Hg2/2iOLlMKoLwwD+VdLaAdHYKidK9QsT1s6cm03gcJAVsu0q/vyIVyXPvWq+RoaIKcs7nHA4T7Rz4WWDi/07cKDfG954TrhAVcpswipSp0loOEn48/iJxjo9fdnJHf9TxVRZ8uDIEQDMfYCVcw9xV9zmtYd+Q7pHVOvl6rBLo9pCBQdEMQWZfrNndaSo9VC9gH4gLqzqXvWK3+mXBBgAj6m/iRzfIycVwbsGGDRJpGEC4N1a8JODwG7lUk3a9ke+vVgJXbvQUVj6UoaHfHssFXXLmONJW61Zibu8tCVDF4VbQRuAXeyTu7V1DYoBv6gMP+Ozb5bjON4xZPH8brUWmFkdnS7OvxILUFTUPK8lYCTMmmwnxu6V3F+qU9Bef+tmx/HHAIBCz44oFS8gint67HUV5+qc50kypZHAfQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(82310400008)(1800799003)(186006)(40470700004)(36840700001)(46966006)(41300700001)(40460700003)(110136005)(7696005)(316002)(2616005)(1076003)(356005)(82740400003)(6666004)(426003)(83380400001)(47076005)(336012)(16526019)(40480700001)(26005)(54906003)(36860700001)(2906002)(478600001)(70586007)(4326008)(36756003)(70206006)(81166007)(8676002)(8936002)(44832011)(5660300002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:06:08.9491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05febaed-fbff-42da-03c6-08db97f71650
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293

Page table mode (v1, v2 or pt) is per domain property. Recently we have
enhanced protection_domain.pd_mode to track per domain page table mode.
Use that variable to check the page table mode instead of global
'amd_iommu_pgtable' in {map/unmap}_pages path.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 28b2e93926b5..6f6311e8b004 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2307,7 +2307,7 @@ static int amd_iommu_map_pages(struct iommu_domain *dom, unsigned long iova,
 	int prot = 0;
 	int ret = -EINVAL;
 
-	if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
+	if ((domain->pd_mode == PD_MODE_V1) &&
 	    (domain->iop.mode == PAGE_MODE_NONE))
 		return -EINVAL;
 
@@ -2353,7 +2353,7 @@ static size_t amd_iommu_unmap_pages(struct iommu_domain *dom, unsigned long iova
 	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
 	size_t r;
 
-	if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
+	if ((domain->pd_mode == PD_MODE_V1) &&
 	    (domain->iop.mode == PAGE_MODE_NONE))
 		return 0;
 
-- 
2.31.1

