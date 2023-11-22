Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA2C3B2BE
	for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yOmAeht4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOMiu2pwitzGUnUY/FS4Yi60ZT0D9QBPejkiYq3djJ6dCjh2qkwvEzazEpkLsW0AZw2K2560S38PW/A+vvb1+lGrHbZxHgXAvJRDorMsM9vaymujYYV6o4rsZ+aLxGa8C536qPhZyyDkZm2QJVpFda7+Lg2BbBSmervr5ebO0GeJPkEGi/0TcgkcyiYhVCgyRIuLh4nSRzK/CVuwCZGr6ZV9T3Bj3Pphm2MJvb88E4+h+xVe87vVduhMtBusx0q34hYHc8M66kEcyF92BmZkmoxxYxYNPHNWughr6MX5D0zr/zk5JDgiSwXd3mEGlNupR5Giy+ZIqhIrGKihiDVwMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jTw4MdCjlw2SEB8sSrGhOfTJwIqaLFHrfQ6OAgJKqU=;
 b=kvr9yNJGMy6NYZESJrSBZM/BoSnjIXVoVzVgu1EALS+O1/M11g5gVKK/Ky5KaXkxQDik5Xk8jV14IsVuCK1QW1UhlV4U13y4iXLvhMQCTIQ0V5vG52ruQzWrPawwZYgCBED4PQMwIyjuZNQmJV6SIk1ooLpFT/jMBrSiZsFFIoRTPiOFP4DW64z0ACbaO8kG6UH38sN1MiWbOM9MlA2TqPj0GdyiT6K+mEp6PXlmJWJOIk7ijcha3Dhkr4UC0+k+lFGpB6xz3PRV7GlDdhw1t3ciVJYCumNWofCpSBIehvN+re1K7jyMvfUuQ55jfOSAVMFm5DbGSNmGc5ooME+Xbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jTw4MdCjlw2SEB8sSrGhOfTJwIqaLFHrfQ6OAgJKqU=;
 b=yOmAeht4BNeQr+LpoLN01rIEuhOO8BFqf1QEtMpfEpb+F15umJlKt+kh08+kYPncie/YTtg1OpMMAPo1QialtYfkL2VA6cfjMPStwdk/l8DFj+ULZZuzpEMndYJqDJqkO3FKEnp0Q5EmfXKbV98l7fnNqVal2rBVwupU+GT8IHo=
Received: from CH0PR13CA0030.namprd13.prod.outlook.com (2603:10b6:610:b1::35)
 by BL3PR12MB6401.namprd12.prod.outlook.com (2603:10b6:208:3b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 09:04:48 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:610:b1:cafe::a7) by CH0PR13CA0030.outlook.office365.com
 (2603:10b6:610:b1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 09:04:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 09:04:48 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 03:04:46 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 8/9] iommu/amd: Make domain_flush_pages as global function
Date: Wed, 22 Nov 2023 09:02:14 +0000
Message-ID: <20231122090215.6191-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122090215.6191-1-vasant.hegde@amd.com>
References: <20231122090215.6191-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|BL3PR12MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea1a283-f067-4d6b-d4e4-08dbeb3a1456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+VRMRuK/gAsjfqY/7ZDDc7QlStGTMzCeHdD8k3D+h0OWUQwkGOaCrTpoCzkyugbbQvLiFU4ZVhVdFGnIFw3O4AfPP0cqruHwC1rNsDQCdiqaHOfZGFqH64rKq721PpS9Ql5UmId2WQehRUhD9OxHwj2FerIEpoV5hMEIj55nbAFtwRtE8WEMK9fDYDGpTFwC3TYJecs4Ol+C+bfGaw8j67ejZtMtGJzOz7Z3sGXT9l/2V65tpEgvWuR8KSza6LFKMM4+79ZHXFYQ7ya+1umwHMp8SvIHewYCUHA7Xq/rfSbeKwQIT6KGE9vAQCfkdFHtE/spkfA4RAtQT2Pt1F2kOz6GSKR/IGQYRI1OPwSHlxowZWXLNhP5BN1psTcv3RNury4Kb5OlGH0Q8X2MITYfA1dI32YdOtOuhmKWo60FIkSEu0ru7JLEBw9uWd/jRxDO2Mk+5ZcQDq9DUopIhhwlVjr1M4vTUNfKSgiJS9AluKmm5wax0gEWmzT+d5mGM/Aze0rYwa5dDAPl20awSIOrJl92o8lLa5KMsbSxKrOqiTuwyrbQPUNHsqjaLXHbMjS8Yd5y4mDS2UHj7otCHfZ2th5ZPaN1NbotJ1vp6Chmt4o2ZZHajsK+bNgjH3OzK4roYCQnpMoYTdI5v04wd3HnhOtT6UZDU+yg5AvAZVFT/RmgzHVTwPMUac0NXJh4KbL43bgGHgvx94rAMck3zSba2i79oYqEOQnsIOjKWgGVOQVSQUsAcY21vrWMt9QO4QRRb3+Foqp25bH75U6BL43TTQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(44832011)(5660300002)(2906002)(8936002)(4326008)(316002)(41300700001)(8676002)(54906003)(70206006)(70586007)(110136005)(6666004)(40480700001)(478600001)(7696005)(26005)(2616005)(1076003)(83380400001)(16526019)(426003)(336012)(40460700003)(36860700001)(81166007)(86362001)(356005)(36756003)(47076005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 09:04:48.4297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea1a283-f067-4d6b-d4e4-08dbeb3a1456
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6401

- Rename domain_flush_pages() -> amd_iommu_domain_flush_pages() and make
  it as global function.

- Rename amd_iommu_domain_flush_tlb_pde() -> amd_iommu_domain_flush_all()
  and make it as static.

- Convert v1 page table (io_pgtble.c) to use amd_iommu_domain_flush_pages().

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h  |  3 ++-
 drivers/iommu/amd/io_pgtable.c |  4 +++-
 drivers/iommu/amd/iommu.c      | 22 ++++++++++++----------
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 234db57cd320..8b3601f285fd 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -61,7 +61,8 @@ void amd_iommu_flush_all_caches(struct amd_iommu *iommu);
 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_update(struct protection_domain *domain);
 void amd_iommu_domain_flush_complete(struct protection_domain *domain);
-void amd_iommu_domain_flush_tlb_pde(struct protection_domain *domain);
+void amd_iommu_domain_flush_pages(struct protection_domain *domain,
+				  u64 address, size_t size);
 int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid);
 int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
 			      unsigned long cr3);
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index ca22546e4d1a..2a0d1e97e52f 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -369,6 +369,8 @@ static int iommu_v1_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 	bool updated = false;
 	u64 __pte, *pte;
 	int ret, i, count;
+	size_t size = pgcount << __ffs(pgsize);
+	unsigned long o_iova = iova;
 
 	BUG_ON(!IS_ALIGNED(iova, pgsize));
 	BUG_ON(!IS_ALIGNED(paddr, pgsize));
@@ -424,7 +426,7 @@ static int iommu_v1_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 		 * Updates and flushing already happened in
 		 * increase_address_space().
 		 */
-		amd_iommu_domain_flush_tlb_pde(dom);
+		amd_iommu_domain_flush_pages(dom, o_iova, size);
 		spin_unlock_irqrestore(&dom->lock, flags);
 	}
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 279f0da896d0..a52e795c4cfa 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1484,8 +1484,8 @@ static void __domain_flush_pages(struct protection_domain *domain,
 	WARN_ON(ret);
 }
 
-static void domain_flush_pages(struct protection_domain *domain,
-			       u64 address, size_t size)
+void amd_iommu_domain_flush_pages(struct protection_domain *domain,
+				  u64 address, size_t size)
 {
 	if (likely(!amd_iommu_np_cache)) {
 		__domain_flush_pages(domain, address, size);
@@ -1535,9 +1535,10 @@ static void domain_flush_pages(struct protection_domain *domain,
 }
 
 /* Flush the whole IO/TLB for a given protection domain - including PDE */
-void amd_iommu_domain_flush_tlb_pde(struct protection_domain *domain)
+static void amd_iommu_domain_flush_all(struct protection_domain *domain)
 {
-	domain_flush_pages(domain, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
+	amd_iommu_domain_flush_pages(domain, 0,
+				     CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
 }
 
 void amd_iommu_domain_flush_complete(struct protection_domain *domain)
@@ -1564,7 +1565,7 @@ static void domain_flush_np_cache(struct protection_domain *domain,
 		unsigned long flags;
 
 		spin_lock_irqsave(&domain->lock, flags);
-		domain_flush_pages(domain, iova, size);
+		amd_iommu_domain_flush_pages(domain, iova, size);
 		spin_unlock_irqrestore(&domain->lock, flags);
 	}
 }
@@ -1843,7 +1844,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	device_flush_dte(dev_data);
 
 	/* Flush IOTLB and wait for the flushes to finish */
-	amd_iommu_domain_flush_tlb_pde(domain);
+	amd_iommu_domain_flush_all(domain);
 
 	/* decrease reference counters - needs to happen after the flushes */
 	domain->dev_iommu[iommu->index] -= 1;
@@ -2020,7 +2021,7 @@ void amd_iommu_domain_update(struct protection_domain *domain)
 	amd_iommu_update_and_flush_device_table(domain);
 
 	/* Flush domain TLB(s) and wait for completion */
-	amd_iommu_domain_flush_tlb_pde(domain);
+	amd_iommu_domain_flush_all(domain);
 }
 
 /*****************************************************************************
@@ -2454,7 +2455,7 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 
 	/* Flush IOTLB to mark IOPTE dirty on the next translation(s) */
 	if (domain_flush)
-		amd_iommu_domain_flush_tlb_pde(pdomain);
+		amd_iommu_domain_flush_all(pdomain);
 
 	pdomain->dirty_tracking = enable;
 	spin_unlock_irqrestore(&pdomain->lock, flags);
@@ -2558,7 +2559,7 @@ static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
 	unsigned long flags;
 
 	spin_lock_irqsave(&dom->lock, flags);
-	amd_iommu_domain_flush_tlb_pde(dom);
+	amd_iommu_domain_flush_all(dom);
 	spin_unlock_irqrestore(&dom->lock, flags);
 }
 
@@ -2569,7 +2570,8 @@ static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
 	unsigned long flags;
 
 	spin_lock_irqsave(&dom->lock, flags);
-	domain_flush_pages(dom, gather->start, gather->end - gather->start + 1);
+	amd_iommu_domain_flush_pages(dom, gather->start,
+				     gather->end - gather->start + 1);
 	spin_unlock_irqrestore(&dom->lock, flags);
 }
 
-- 
2.31.1

