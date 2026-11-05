Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793852635;
	b=0bYIGv15J4bKEOmQqdxUqK6VuLZ30mBuXcqbmJlMJK+o3EfGOqj460MZMt/NG5zHfwHN
	 lVan4Rtd+2oSBR1CYBpvgFMog2uZnUZKaKsAhUZ9laIqrvBr3JCP7++7kHRsQ6BP3p1ht
	 iWZCTIAveVDPBjufisrerJO++hIkDLdW/bFhNUH1iLV9VJjk3OcXK/ufPtqS/pOE5M+VT
	 N2vYGUiwRvM5/2dFrI20SEJI79iCdUwFBq9qxYXN8SxxzD3u283QChgM4Fe6hm+04oeI+
	 /4O6VUBDV4BkRGRhaC0+/QE+yzeJs+S948TA1NXY60VIGInpynCugsN7URAjAyGJAcw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852635;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=66xrL0kO6bSTdQZvOUJrNDa/ZsnHLyOWpWbT3XDOmm8=;
	b=0V2Mg8keF3EIACYpav5f9cmij2JFaitUwIBvPlSbJnPhzRqx/JhmNtnuGIWXUgebTSpM
	 Qk5Qv34vD3HCSjSgZpJB0biQyWglcicnhvesc+gQsei8l4Nn6vmQBkcQMnoUz4N2B5Kvf
	 v7s51idhx4JKi5DTt9gnXjcstHjmh/acvgtm9136mVYV1jL2tmmV4ie3qDBiIPb26Vv5Y
	 ul7bf+goVX/lJEvXgd/NzyaUH4hNf194nv1vryTLQBccGgQgtOtoTcjuYYuIpFQROadDq
	 1zfz59KcxUHAqueuDycBQMtvUaZ/lwiCU2eswojddrBYzXFOZKqazLsdGi9UkhhAg3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="cpQg/gB8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.36
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E51606A328
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93E51606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cpQg/gB8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=walCeYFkCdjcpvVaIU+B/eihjR2fS7E68wUZfpfynQ0zD+8vOYaHmvlm75BrW0q0QK5rmjeIxENciQfVZ7hH8TKL6SoRq8WscX6H2jT8IRfA6LxJtdZvs4G0iRRtZMIRMMantR5nKOoNnh0JYzt3wowC49u1eYPVKwmcSE7epO/Nqz0KJzTFVX1H2vM8oFiSukHdPMDKvtWt71o9mtfvr9TWqzpSUwt/3J8pnFv+PJ43uFCL2+rJ0z6lBRXVjw4m67JVNMyKLvFpQXAPvgHQwahszNbqr51ACH2Vc9CPRhEJQ1uxQaW3QsAgopF8yzJg7kYdG1JaLz2wBI8Q7MBxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66xrL0kO6bSTdQZvOUJrNDa/ZsnHLyOWpWbT3XDOmm8=;
 b=MtYN5uxALemGIe7mpDhZjNQ/CN2b2YR8I5Swb0VFyDqOzLQES7EcOSmNQ10W0VOYVZEt5e144R53P7ZlWgqOIEu7G4cbxDyRWwQ8XMLYl+DcKR5zU5QzsM7K1nps80E2VNF5fTx9rbyzgGCdHALI1TAOIlr/ImcCR0moG7njyKT7UD+NrlMAT67B+fCYdM9mZf8+Ntn2D4opxw0HzFJgcIH+ZB1bYGLTeXGiwQxw2FxFO2x4MUHuvt5HRUJe4bt1By06E3f43B+Y9w/syJTZgG68RxPaOJruaKJe/5NweTqxtD/yo06U2WCv7NaN6uP0B8kjWraahkK612c/rPoT7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66xrL0kO6bSTdQZvOUJrNDa/ZsnHLyOWpWbT3XDOmm8=;
 b=cpQg/gB8g+dMk0VBIPHZdCWTrcYYdD1wVgA5FuYy9bWlUBycPRUR179FX3v1lvkFhmcbpYg2zEI55p9K4DQBgU/KNBVIBg3hQampbx9NU0+M69O0uErGBjrlffJ5lNKBAAik1O99nU9k4sPEMx1dslxMG747vPHeIZglngYy98o=
Received: from BN9PR03CA0649.namprd03.prod.outlook.com (2603:10b6:408:13b::24)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 04:23:49 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:13b:cafe::d) by BN9PR03CA0649.outlook.office365.com
 (2603:10b6:408:13b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 04:23:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Thu, 5 Nov 2026 04:23:49 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:23:46 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 2/7] iommu/amd: Fix page-counter drift in multi-level GCR3 table teardown
Date: Thu, 5 Nov 2026 04:22:49 +0000
Message-ID: <20261105042254.399163-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105042254.399163-1-vasant.hegde@amd.com>
References: <20261105042254.399163-1-vasant.hegde@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c634ef-6aef-430e-c366-08df3af49743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|22082099003|56012099006|10067099003|18002099003|261009223027099003|261021121427099003|261021123027099003|261102123227099003|11063799006|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	XzP778ejY2h/z5uY++9x+GsKvchom8Jlmf5vK+4PKzlGJe6y9AzxemDdwWp5/rn11wA+zzRdxlTJn0aoG+mtlwgGceIfZ3BnZJ18+kYDGwCIqtmzgmuHXk49oUwUTQXVTV6yUhiHQcp3ILk6gPVCUH+ZrbJGzCCGOmxPCbpl2i2XaHy6lLnMFIRvsRzrNndFbvoZeFg+Lb3JO+dLQL08kyJQGV5tIm1c8XS83GtfaYBL/njq+G0Opm8JiiylgdJ0kyRN8wo2PpH0SMglzvMHs+vg6GTRuaiZkmi+SQA34SAz4+1x4QktlweAMnrtnSLviwWX+EjUiKWheIdBlP5Mos+YWZEcAJZx9fE+Rc6yYCW7Z+M8Hb6Xi8d2+0N2xCrDBSif+948w1e2G7TPsEMSJyHSdcMBxjTjTgHOlkpy7zHPfb5pLWbmTJiylBYdNB4kDMOIUY2hNdnoYu+4WDTD1lcTcnTXIb8CC9fe0DxXulu70qklBl+f/VVHHJwrkrhn7G8Y10ROWD8BuKpmzq0U4XJP4eFp+EzzWA9zUVvKayx5PwllcQDxOkzZnuj25rmmL6HcVcRoCygOb2ZFyTxw8qKQ901y/FsaQEBNk02Euc1y0rmU8emk4aGQ5U3pTRVIi/JJZYJlxNzzHPhAd6ONFzuE8czw92100WusF53XNqe97gTekNw5mjsYV3vgyt5GV9TLdEUk27dTPtcb/2F+0Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(22082099003)(56012099006)(10067099003)(18002099003)(261009223027099003)(261021121427099003)(261021123027099003)(261102123227099003)(11063799006)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TWVPRqR2SodmhcRTNEkyx8drHWspjQuNDIsNhh03q6v7qJztNxFbCUjmxnCk2gd6+BAfx0HntyJfvZIS+G5nzvsB37RnGYPwyU+3LnUS9LthigJb/aw8cvWA27oKcy1NNg3ZgbrQRRhAp7DsAvV30x0HW+Lt6Hhh0W9t6x1j5dBCbafDq5t5/Ps+D68mgtKngSKmU06L8NSsH5rIk1Kb5Ga2pc09BdTWqewUVWgFUGenzL/dz31FbVq0a1HcqqYHaUo6jpGSTz+HK9t9TQeCwaF6h8LTdYjM5R5ltanggi0sFkzlrJb8R04ma1MPAYqmS5dZY3T2fY0ttRdZtFBoveT09SH+CygDuQhidhk4fT5IkXc1T4OdhuIvTCbvvvb+vtKY3zvBBc4+chN25UiSkPeqI0QdxkwyyvGzEt2CEKVin4uK0lber5mCFDUvjMir
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:23:49.3692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c634ef-6aef-430e-c366-08df3af49743
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779

__get_gcr3_pte() allocates intermediate GCR3 tables with
get_zeroed_page(), but free_gcr3_tbl_level1() releases them with
iommu_free_pages(). iommu_free_pages() decrements NR_IOMMU_PAGES and
NR_SECONDARY_PAGETABLE, but get_zeroed_page() never incremented those
counters. So every teardown of a multi-level PASID (GCR3) table makes
both counters drift negative.

Allocate the sub tables with iommu_alloc_pages_node_sz() on the IOMMU
node. That matches the GCR3 root allocation, so the alloc and free
paths are symmetric and the page counters stay balanced.

Fixes: 75114cbaa136 ("iommu/amd: use page allocation function provided by iommu-pages.h")
Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 453a7a07621c..c88f6ae3753f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2002,7 +2002,7 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 }
 
 static u64 *__get_gcr3_pte(struct gcr3_tbl_info *gcr3_info,
-			   ioasid_t pasid, bool alloc)
+			   ioasid_t pasid, bool alloc, int nid)
 {
 	int index;
 	u64 *pte;
@@ -2021,7 +2021,7 @@ static u64 *__get_gcr3_pte(struct gcr3_tbl_info *gcr3_info,
 			if (!alloc)
 				return NULL;
 
-			root = (void *)get_zeroed_page(GFP_ATOMIC);
+			root = iommu_alloc_pages_node_sz(nid, GFP_ATOMIC, SZ_4K);
 			if (root == NULL)
 				return NULL;
 
@@ -2040,9 +2040,11 @@ static int update_gcr3(struct iommu_dev_data *dev_data,
 		       ioasid_t pasid, unsigned long gcr3, bool set)
 {
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	int nid = iommu ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
 	u64 *pte;
 
-	pte = __get_gcr3_pte(gcr3_info, pasid, true);
+	pte = __get_gcr3_pte(gcr3_info, pasid, true, nid);
 	if (pte == NULL)
 		return -ENOMEM;
 
-- 
2.31.1

