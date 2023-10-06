Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8C115C2
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aeZf/lQW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWLb587gY44xBdnc55WhLkEdlBoSmkmb85iSr2fCr/9iNUPm6fhWJOr4tvMWj1IYrvs56f6yObytRudmdfbSpSWg+jxEllGTwk5pZU6LCl+hPmCwN3hShRC/2OcupmbMlpTvS/Xyg1NfGw1sBk2R6NP1TKb5dP33Z3IxjDorMWLMWq4/8qK3zqx2iNJ9et0RfCS3USOkh4pKrEtXD28s+WrUPi2D+4hyn8AXFLyL9FsMQn2byiftTdYQjL6i1N2tLhywYdH679BuqW+GwAfhfdJuNxNjQISVTedPJBuJ8sqXRvM5bu01FzYBsxU05t/xOyERtn3gwhHtHaq7b5AW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAAzHd4T7gUiIj/11DwX47vY+3x/NEFnILKLBMZA27s=;
 b=FdHBcxGjG4RSjlEjdVhIcgMt4QoQDPPUn/YadD+KP9yYbOxk3Sq5BONSTF5PKyd2LUyFTBJPJuXeIx3rLajhwpace0ERYmcG/QzQpB5/P8snXBTz4OzajxQW2T84zDvzLJaf3PRQlZ91Wt+xxyfJus13+3BIDeMtRlnyZQxIjt38wK53aCcxrxQb2WL0HAeRh1Zuu0jx17+546h5AWRTnrSMF2c7NwiXO1cVCHJWdBZ83JTc4KWZORaK6TmkOLVC8dyN2wEGEVGYz5XxtCgKAQebW2xkAuL8Vu8bfX90igW22lKPY50r/fUHFlDYMyykTSdCc696wuxIjD2Bh8VzwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAAzHd4T7gUiIj/11DwX47vY+3x/NEFnILKLBMZA27s=;
 b=aeZf/lQWTKs4d6b5njMmp2QYbGMZQ4kxPYcC07Do3p52Jf75Qhaan00qO+qjtHwfD2TdcSVHxA622wHhJtlPsWrYUkhJmYPWUtPnIUz2ISSIDv57K+uOYAkuSXJW/IimlmeuuKIAksE+aacUrKgM1hJTnPx8jP9HpfWxvBz1X7E=
Received: from SJ0PR13CA0220.namprd13.prod.outlook.com (2603:10b6:a03:2c1::15)
 by DM4PR12MB8473.namprd12.prod.outlook.com (2603:10b6:8:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 6 Oct
 2023 10:19:51 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::b2) by SJ0PR13CA0220.outlook.office365.com
 (2603:10b6:a03:2c1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 10:19:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 10:19:50 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 05:19:48 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v1 11/13] iommu/amd/pgtbl_v2: Invalidate updated page ranges only
Date: Fri, 6 Oct 2023 10:16:22 +0000
Message-ID: <20231006101624.5912-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006101624.5912-1-vasant.hegde@amd.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|DM4PR12MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: 9530a012-9449-403a-beea-08dbc655c6a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aKv/U3lPxdKwZ5fLK/r9yfGIXppzBbCMylXYEVrW548jxf3YFrRpHbFJ6V6Crr8mLOyOJc5/oVuyd/EOz+eJjOhD7kbEoVXSmPjTL5qt2MoKznWLxcYHfFunDuvaMA3Bmjc3mHOJR+Jz8cuZD0nTbjADGk1Qv788BHPXJbkDvGta1i3lmuBFwVEpPsNjc/gGJktGz/bLcOuXd2P+OXPcgC5Hm1S6BN5ul0EhGdiMJVArLX92etENDCu+zS9CL6NGYEYG/NNhqsC5eWL1IJs3cdnnFZPAx7HN8RCEWz3XGF6e2P8zO+pNHSbTuVlGd3Eoh3vqE+u5ozlywmMtk7RUvTLCGvN9CoVJbjirX/j+Hk34eJuWp98bOifL6eGcOE3xx7lz+7ukfu8i8rnnOSbUKGAVecrVpEqAgQyQd5a4O16nAvKgS8X5IGvWd/m+LbjiSX33t9FNGolOgaTlbLtv0drT2Nxua5MvM43kXP/NBdyWqHt536XYYGEVyLNgaPugKo2v91lr6dILI70ytXYA2mIZM6gxjn9pDlvBVdm4S7jmrk9Td+Z95LGSKgX3r2cCf0dwH+EZg4ea13VDu6EFGtLZQBi9RWB3zfOPOG+08ji1pJYqdLeGuB7TWO2nhnlCDnQhwylWP4zJE0z4GDMyiQKUr2xmjJFdy4SGfpU+6kvz+WoAfvJp7OiTAZ6HBpdf+9qCp1u7Df83fze/6zXs/XBhEdbjmitBzpYfwIp3EsDsSGL6OU+Rtn5/BGOdAgbeVTuhICpyEcmDRal2/+H3Uw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799009)(82310400011)(64100799003)(451199024)(186009)(40470700004)(36840700001)(46966006)(16526019)(70586007)(2616005)(478600001)(54906003)(8676002)(40480700001)(4326008)(41300700001)(26005)(36756003)(316002)(1076003)(336012)(70206006)(82740400003)(426003)(7696005)(356005)(81166007)(86362001)(6666004)(36860700001)(47076005)(83380400001)(110136005)(40460700003)(15650500001)(2906002)(8936002)(5660300002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 10:19:50.8831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9530a012-9449-403a-beea-08dbc655c6a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8473

amd_iommu_domain_flush_pages() uses protection domain page table mode
to detect/get default PASID. Hence we can use this function to
invalidate v2 page table as well.

Also in __set_gcr3()/__clear_gcr3() path call domain_flush_pages()
directly. So that we can remove __amd_iommu_flush_tlb() and related
functions. This works fine as we have GCR3 table per domain.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/io_pgtable_v2.c | 10 ++--------
 drivers/iommu/amd/iommu.c         |  6 ++++--
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index f818a7e254d4..6d69ba60744f 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -244,7 +244,6 @@ static int iommu_v2_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 	unsigned long mapped_size = 0;
 	unsigned long o_iova = iova;
 	size_t size = pgcount << __ffs(pgsize);
-	int count = 0;
 	int ret = 0;
 	bool updated = false;
 
@@ -265,19 +264,14 @@ static int iommu_v2_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 
 		*pte = set_pte_attr(paddr, map_size, prot);
 
-		count++;
 		iova += map_size;
 		paddr += map_size;
 		mapped_size += map_size;
 	}
 
 out:
-	if (updated) {
-		if (count > 1)
-			amd_iommu_flush_tlb(&pdom->domain, 0);
-		else
-			amd_iommu_flush_page(&pdom->domain, 0, o_iova);
-	}
+	if (updated)
+		amd_iommu_domain_flush_pages(pdom, o_iova, size);
 
 	if (mapped)
 		*mapped += mapped_size;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8da445e51251..764a5656b56b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2698,7 +2698,8 @@ static int __set_gcr3(struct protection_domain *domain, u32 pasid,
 
 	*pte = (cr3 & PAGE_MASK) | GCR3_VALID;
 
-	return __amd_iommu_flush_tlb(domain, pasid);
+	domain_flush_pages(domain, pasid, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
+	return 0;
 }
 
 static int __clear_gcr3(struct protection_domain *domain, u32 pasid)
@@ -2714,7 +2715,8 @@ static int __clear_gcr3(struct protection_domain *domain, u32 pasid)
 
 	*pte = 0;
 
-	return __amd_iommu_flush_tlb(domain, pasid);
+	domain_flush_pages(domain, pasid, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
+	return 0;
 }
 
 int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
-- 
2.31.1

