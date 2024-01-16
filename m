Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603171C6BB
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PrKT4Zum"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y60ScdObSdQ4I2P1QUjW3tSae+K9t5lKyyqxh6K41B9iUuRCGGMGEgFSi8ajs8y1pNEVBCnChFiP/D9FhcTVLSVsWgSKRMDqV2StbqUrIVQY9S6NCBz1Z8Vi+fQHUAt2s/k7gFd5619U3ZAgwsWxAPAjF8jXIZCH3urRMU8lbhqvLnG7BfnjXc2Kg0zsOIV58wblT2cR8bWWxR9qR6E9EKaGl+syKmeh1JcQP5hCv04OKXpvnGeO2qwAdwu1gPZcR8HydglfQ5SiEbmN/urOriZrNVz8paXrg7ULB2k9/JyMR+8nz+LzwfZrSPE+PrDTRjKmK5ijBCwnvWVh/p1LNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeSp0UZdFYdS39+t3sdTDl3Sveczy/lCkR0obyr0gEY=;
 b=noJicQZZQVKnT2R8FVEQz0mtukigOqOKeOOiFZBHastmK+DBpI2e5fmwHwgk1IqDvULIdVsELa7Inl1BH2kIZ2Vlgil4fWNI9wWHxN+CDmW9qUWvgQ7sBC1QZ5calhO/VoXLx+LzHlsqyGaBdnSX2At2hvScGIBftmO60w5INL07qVarvlnJP1xG3ZL3OQa6YJShkPV2hpIg50odeuJE4jiuRxaMfzuAKDQJbeyJiDHiEQ9mcKb5WM0BrwGa4JtxSr93vq7JrXrTl8t6GYDh5FbwifpJSljYuCfZN4gteFdzbiSKcVF3D8BNaO1vMGOiczLlIvcKI7y7V9O9Fe7Isw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeSp0UZdFYdS39+t3sdTDl3Sveczy/lCkR0obyr0gEY=;
 b=PrKT4Zumu7KYxArH19deWR9QCAiVHxzdqU8RSOSmxD9cvLrU6mANU72LVRknPKaQO3TH+h7aVJgmutesI2gnuq/8OAin5/QY/BQOwcha49GaYq1OCYCKhosKtqWqZChJuTZoXRYxInp/xx/2O1DwPI5vqsDclEEewhowjA7katc=
Received: from MW2PR16CA0007.namprd16.prod.outlook.com (2603:10b6:907::20) by
 CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.24; Tue, 16 Jan 2024 16:56:20 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:907:0:cafe::73) by MW2PR16CA0007.outlook.office365.com
 (2603:10b6:907::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28 via Frontend
 Transport; Tue, 16 Jan 2024 16:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 16:56:20 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 10:56:16 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 09/17] iommu/amd: Rearrange GCR3 table setup code
Date: Tue, 16 Jan 2024 16:53:27 +0000
Message-ID: <20240116165335.6043-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116165335.6043-1-vasant.hegde@amd.com>
References: <20240116165335.6043-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|CYYPR12MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: c7861f97-a3b7-4173-1a46-08dc16b41048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wa3DB68VsZPeev8e11oysq16CJ49FDd4GpHgjxbcQl+CpVV+LdpLguujbXgdGjJScOqTXs1yNcrZFOwFX9G7v28MhiIdC2473DaHreIcAFgsqAluE3y8A47GNQY+MjZDQwJph/BBZ1c4Wx/XkqwbPj1WAAWbahTfm2p08ZEKhuvXPV9DdkGYmUFp+BVRvC6WA/3vXmAIDGZ3BKF+Ebd8E8JzMOFW/bnI5/0kOAn0WDKETs3G43mFKzZK3qW98UC4O/mO5VwDaPRjM17l16+Yz4TPlfjzGRdZ7PnVqkp0qNaUUPX0UZ7v26kUxo/iGVgDilKLk4kXmtSgTDDhcKU7XjyoVppvaTxj3jDU6Mq9qlRuK7QyVcXqdlb6x/gPRoCLghjd3fMMCYba4tmc3XSk/IpcuSfTt5I6sWwJDLu2pGWBfzQDL+b0IIsuzzDhTsRIA3k2chNet/FHj/eWVxALtG46WVHJJp3nDfZ+EqymIm+pIGiRLGb6Rv9TXU8Lx4JY9eBTxl7K9lJMLY8DTPJpYOSo6R6iOgUQpMiqM7AHZPI6klYDxWFSakAHaOBwjHaefnk7G/tAekNqdEEIoZ/0ZyGcG4Tc5lXS5VmKwQdFEew9rh6medn9t528XI9akvp4hlQQnLJoKeP5dArV7P4rq6fLIWkBxlqRAqKGbzMrwd7jsqCcGMnr8uz5tdJbuKGzW/9cRJzdBMOt7xgRJCrl6fvZS7uGuganbuwcsOuUmjF46p1ck1BPLc13pfJrQiID84+idDfiWY58NG51+o/kjw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(46966006)(36840700001)(40470700004)(6666004)(7696005)(16526019)(1076003)(2616005)(26005)(426003)(336012)(36860700001)(5660300002)(83380400001)(47076005)(2906002)(4326008)(44832011)(41300700001)(8676002)(478600001)(54906003)(70586007)(110136005)(316002)(70206006)(8936002)(81166007)(86362001)(82740400003)(356005)(36756003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 16:56:20.1446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7861f97-a3b7-4173-1a46-08dc16b41048
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924

Consolidate GCR3 table related code in one place so that its easy
to maintain.

Note that this patch doesn't move __set_gcr3/__clear_gcr3. We are moving
GCR3 table from per domain to per device. Following series will rework
these functions. During that time I will move these functions as well.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 64 +++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f83e0521d9a6..22092e741121 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1758,6 +1758,38 @@ static int setup_gcr3_table(struct protection_domain *domain, int pasids)
 	return 0;
 }
 
+static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
+{
+	int index;
+	u64 *pte;
+
+	while (true) {
+
+		index = (pasid >> (9 * level)) & 0x1ff;
+		pte   = &root[index];
+
+		if (level == 0)
+			break;
+
+		if (!(*pte & GCR3_VALID)) {
+			if (!alloc)
+				return NULL;
+
+			root = (void *)get_zeroed_page(GFP_ATOMIC);
+			if (root == NULL)
+				return NULL;
+
+			*pte = iommu_virt_to_phys(root) | GCR3_VALID;
+		}
+
+		root = iommu_phys_to_virt(*pte & PAGE_MASK);
+
+		level -= 1;
+	}
+
+	return pte;
+}
+
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data)
 {
@@ -2796,38 +2828,6 @@ int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
 	return ret;
 }
 
-static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
-{
-	int index;
-	u64 *pte;
-
-	while (true) {
-
-		index = (pasid >> (9 * level)) & 0x1ff;
-		pte   = &root[index];
-
-		if (level == 0)
-			break;
-
-		if (!(*pte & GCR3_VALID)) {
-			if (!alloc)
-				return NULL;
-
-			root = (void *)get_zeroed_page(GFP_ATOMIC);
-			if (root == NULL)
-				return NULL;
-
-			*pte = iommu_virt_to_phys(root) | GCR3_VALID;
-		}
-
-		root = iommu_phys_to_virt(*pte & PAGE_MASK);
-
-		level -= 1;
-	}
-
-	return pte;
-}
-
 static int __set_gcr3(struct protection_domain *domain, u32 pasid,
 		      unsigned long cr3)
 {
-- 
2.31.1

