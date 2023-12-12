Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E278218B0B
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XSxjmVKS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1q0RkraSklqVwBlgJx7WPHP12YB7MiBC8sSLegYGQiOCbhhd/vjQYyxz1LTVxk6/oQT/Ah4HLvHUUgP3vFhEesP/Ukl6ok7t2QJgQeWtKhiX++0gGoRGRzoQcdALAyEq7IyQ7KwWV1wjMLVlqf3s0bDxHU2ShCYhw2U1sAv6ILVNKUzzbDBc+EXCMfID3tVhOcHVGDWuw3n8LU0DWLMLRUw07ZdtwamueS5QCX2jIs3yAJ4IDpdAsfiqvMciwvxysFAlTGmELYeFcjIOYdnGMqFapDC4m2TLxY12SAE+BKvOkBXJReJjFOj+K/pRxmXaJBputHHCf1sJzGy1KF2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5pgoLWPv52+KgqfcHF16WMmwMP1BauC5xJkr8T51KI=;
 b=BlZs7kJ8HPvkyP/bR/2hwh089+iQM+0PCYviT00Rs3OovsxdJMpJoi/jt/zNUF8JeMCIiUqiekE5lWJiXTa1QqNjTEIXUOCGkWmwjAMCKIZdTdEEqcLHHWiNhOzYXwlCryykiLRPcWXgiISchbtJrocsCCK0Npt8pmGIWTHHyRJUnU/DPe23J7Waf2wFoV7Se3mRo7hYLAbP+gYqITA+408BAtxkR5s+6nakc8nOWuC2PV1M/4Kj9Oyf8YRj3iwubYF6TK/HhtfUfO4poiRykivzftym2mIBMZD99CINukX6t1WBEkHroca7KIGD28j2CcJ/BewwVKUFl1+mkeN04g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5pgoLWPv52+KgqfcHF16WMmwMP1BauC5xJkr8T51KI=;
 b=XSxjmVKS7Ab/HG10CH8V2OqWlPQqOTk9qGvqpvwoObXCYwEQvqNoJDQh09s1IcUIIzBLP7CfqrfPzYIM7R+p5Zb9hYXcr53tcVkeGZSJKmWC9Uhywu7W3PAifYLQFm0E24aWycS6Bn2fD6gQxkLWKrS7oUoXyUbAJzvmcIdBkPc=
Received: from SJ0PR13CA0181.namprd13.prod.outlook.com (2603:10b6:a03:2c3::6)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 08:55:32 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::1a) by SJ0PR13CA0181.outlook.office365.com
 (2603:10b6:a03:2c3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.25 via Frontend
 Transport; Tue, 12 Dec 2023 08:55:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 08:55:32 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 02:54:52 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 06/16] iommu/amd: Use protection_domain.flags to check page table mode
Date: Tue, 12 Dec 2023 08:52:14 +0000
Message-ID: <20231212085224.6985-7-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: 5abd9798-dfb5-4d23-37f5-08dbfaf0190e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NLUvhKF9M1By4TfPGkWfnJEOn6V+cCT7qHKO0zvxX5STQc9W1CEjDXuHZ7U2zo8UdxdfwMwQ79HJkpCownybSm73QfcAGQSfeaxMhx3RXYOR5ma8TrSwx8+pg3Tte5nptjaWE2MjBVESlrn77CYkKWmeb5fFUvLbcGUK6I6K4R5m3B67VKt97i5BnnlCgbjeh7Uo7kpj7ooj/pIrAItPrscFu4pCLq8ZNVWomdvYn/99LQxqUv39AAU64Jd1Sewtz408Kz2zR2x1Q2UrI5c03E2+S7SNcFMZkQAcEiI1ayNnQOba4gbD3tN6A8ewZO6TiNqiZmomr2BNASdXgjHLV8CdMXuPNSREfCWUiYvXZaAxt6A5EZlY4H6L3DlmPjA/1McB4D3e52g8IAkt88zxNdj7N59XshBbFYHHCoOiTwiou4y/7v+F+WF50zlFfGkkLxJ1iyZrWrbx7XsdlYoe4eUjbtEvlmzCjDKit6NiIGrOm/UCbIxOZkWpx5EGUK/SLdiFnhHQ99+kOKoJROreQ6PH4UVhLZxdjubVan/aPkBS9CqpR2bVASRciKDDysTzCMJ95cqsdawnzeU6T5mmssR7nJXTYT0RDhBN1V7BDm0bqnt+pKK7WeI2Rnf15hC5wCvqekKeRCPhWe6IhCgfqX6+u8+ZX6QnpxfW4zOnsOWV6XWZi2GHbz9A3CcWg7VNcsETE+XRAAttnpLWOCrlbh7MCgjkFFJ6XbIaSfW7PkJwxAw9jPn1+9HbS22/ghFE3IGTL3BYQuX8K0AVaCumzw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(47076005)(8936002)(4326008)(8676002)(83380400001)(36756003)(81166007)(82740400003)(356005)(41300700001)(86362001)(2906002)(44832011)(5660300002)(26005)(2616005)(1076003)(7696005)(40480700001)(16526019)(36860700001)(478600001)(6666004)(336012)(426003)(110136005)(70206006)(316002)(54906003)(40460700003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:55:32.0795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abd9798-dfb5-4d23-37f5-08dbfaf0190e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319

Page table mode (v1, v2 or pt) is per domain property. Recently we have
enhanced protection_domain.pd_mode to track per domain page table mode.
Use that variable to check the page table mode instead of global
'amd_iommu_pgtable' in {map/unmap}_pages path.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 9233f476d4a4..93d436bc3e8e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2326,7 +2326,7 @@ static int amd_iommu_map_pages(struct iommu_domain *dom, unsigned long iova,
 	int prot = 0;
 	int ret = -EINVAL;
 
-	if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
+	if ((domain->pd_mode == PD_MODE_V1) &&
 	    (domain->iop.mode == PAGE_MODE_NONE))
 		return -EINVAL;
 
@@ -2372,7 +2372,7 @@ static size_t amd_iommu_unmap_pages(struct iommu_domain *dom, unsigned long iova
 	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
 	size_t r;
 
-	if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
+	if ((domain->pd_mode == PD_MODE_V1) &&
 	    (domain->iop.mode == PAGE_MODE_NONE))
 		return 0;
 
-- 
2.31.1

