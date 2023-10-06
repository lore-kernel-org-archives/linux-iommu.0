Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BAD15C2
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UEQKf+Fd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROb8OKIPt15Rzj9J3zvaEIBIF3cY7X0ZGTA/rh6Q9S2012KcKtTfpOPI+ld/0UKNzDr6ThQUho3GmHPIDv9bAxc2hJpGK9dz4ZIXsTY2GJlHZTySjySCMKfrS7pGKrv7vQNhCv2mmdRL0eDK2LHjaw6xzeNAEED1U9UkvL0FgI4nFvE4f+nCOFgHyiy1HKYV03GZEz+KH7xMkauacQhzB7uCLkotCebHLfwQqrnG/1ZKsK4Nvsr9RNIAC9JNxDoydBdMGPL6BcoGfz2SYAuWIO8MEkd7jw4nem3gEBQEuhG+4m2jBD1EBRyEaLpkhvr3LVfo3vIh5uVhJ43m+HtWtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2Y80AVT66+liZ8UzpHzi6+ch14DTe8vmRlt1hrOibk=;
 b=F6llt+mzCNbZqbMBGQrb8c9lOplrfBINssfx7nEGWPWa0vB5RNYjiIEgEan4K7FIEhsOZ7hCd6KF/yjxJgGcy7eiPQ7wvwSbqyPnY+FG2FeEZvoa0O1UTbLEarrKI+82Sw+0YJIJoPSxHRQtUkgvC2eAOXc3hF5cbVEpCyXRagJC4ezbuTdI1RXx5y+XVwMZR2Z7c3Y6GjeruG+GW8sQnISFzyUJq2MX94UWwtm71c4cOU02wv6YzxcVzPh+fUEPKNCGM61e/zPbRsG7rtQ1K6a5IM0RRMgC4fIuax+vjimz9WRSgHL/O8ab6oqO2BRE4zSmNUOI+C59p/7twBfWnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2Y80AVT66+liZ8UzpHzi6+ch14DTe8vmRlt1hrOibk=;
 b=UEQKf+FdzZiwHJ5BItaX8EZ7O4oweCIoFjhmmv8IroZPz2hV+jUL9DN5idkqYq979/yFP/oeJaT8B6kNSFgBADhllctdcGeXaTLLkNZHvXjDD2CRTXQx0Nhdr/ZeyDaWmquDvfq3xgAtayqiZ++S6V5vQWKRWYaubloPGQi8mRM=
Received: from BYAPR02CA0042.namprd02.prod.outlook.com (2603:10b6:a03:54::19)
 by SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Fri, 6 Oct
 2023 10:19:36 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:54:cafe::f7) by BYAPR02CA0042.outlook.office365.com
 (2603:10b6:a03:54::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 10:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 6 Oct 2023 10:19:35 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 05:19:33 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v1 10/13] iommu/amd: Consolidate domain flush logic
Date: Fri, 6 Oct 2023 10:16:21 +0000
Message-ID: <20231006101624.5912-11-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|SA0PR12MB4557:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f06e788-dad2-44ae-fa5a-08dbc655bd90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9UAh9oNRQZNYpDKQ8N1LgGjrjEuB07Y+DwY62nS2kRvLtivS1D56+y6vsWNFEjNLp+ducX4E1kyaP1s7wkYGPLyEVVlVoiRLMu9IgFzXIgf9KDB6ITo7cpvEm72xFawnXET3Bys+Z/CRR0qYIjmab7vXzAdkx8CFTdDVe691DIoR2fJYyiO+2ySOnpMEFDXBttXOJLo9Cckk9JN0vTtSckTT6Ch64ZmNfaxCpy9H2ytfKS7aEtb+ZF/lbxVwKvf/aMaxH0rlu+Q5MoFr32htLmvKzJflF6kA0tdnIWODetVk1jmEiN8KWCTLcskMQC8NdesPQ+p0f4XdjtRhiA6Zn6yTnnsCTAptrkPQoqmO6zWuvTSHMx/Mhm7WyK7LRbKgZHd3i8pJ10vLpOUs4UJqlNE3KlNN+VtSxB3m63F/m/oRQdbcjxNG4KFuFJmnNDgzmM4Iupyvuq6SXsxSSkUB4RdkI2Atzn3ZB6Qj5URSe8QBVLlpP49+DuP+gFMEOn9yTzpo84kI66cr+1bLvQUySnTFB87y7BXV9R+Mf9s/ALCrxFVsTNIg6l5S8mNXchIkFve/5q8REI3/h/oKI2RA0dO5Z5TymuiUeCkwPs3CRv7l3Z6z51icSE4A0Wyc6WG5mHd0MGIyEr0g4twhaxczmC76YsUyiJoiZcPpeoi3A826dN+wJtALs7wI6R2mdRFmdlzYjGzgALWrNymKdrfrcSfgC4W0CT3Uz+b0vko3jXClvbU0kQ1O/i0vKNRe3cIrBZGQ0Cu3Q6kssUErtyANSw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(7696005)(6666004)(478600001)(47076005)(86362001)(36860700001)(82740400003)(356005)(81166007)(2906002)(41300700001)(316002)(336012)(2616005)(83380400001)(426003)(1076003)(26005)(16526019)(36756003)(44832011)(5660300002)(54906003)(70206006)(70586007)(110136005)(8936002)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 10:19:35.6409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f06e788-dad2-44ae-fa5a-08dbc655bd90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4557

Enhance domain_flush_pages() to flush guest page table as well. So that
we have single function to flush TLB/IOTLB. Also move IOMMU TLB and device
IOTLB invalidation to separate functions. This is useful when we introduce
PASID invalidation support.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 68 +++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c30b08e2a939..8da445e51251 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1465,23 +1465,42 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 	return ret;
 }
 
+/* Invalidate device IOTLB for all devices in the protection domain */
+static int domain_flush_dev_iotlb_range(struct protection_domain *pdom,
+					ioasid_t pasid, u64 address, size_t size)
+{
+	struct iommu_dev_data *dev_data;
+	int ret = 0;
+
+	list_for_each_entry(dev_data, &pdom->dev_list, list) {
+		/*
+		 * There might be non-ATS capable devices in the same
+		 * protection domain.
+		 */
+		if (!dev_data->ats_enabled)
+			continue;
+
+		ret |= device_flush_iotlb_range(dev_data, pasid, address, size);
+	}
+
+	return ret;
+}
+
 /*
- * TLB invalidation function which is called from the mapping functions.
- * It invalidates a single PTE if the range to flush is within a single
- * page. Otherwise it flushes the whole TLB of the IOMMU.
+ * IOMMU TLB needs to be flushed before Device TLB to prevent device
+ * TLB refill from IOMMU TLB
  */
-static void __domain_flush_pages(struct protection_domain *domain,
-				 u64 address, size_t size)
+static int domain_flush_tlb_range(struct protection_domain *pdom,
+				  ioasid_t pasid, u64 address, size_t size)
 {
-	struct iommu_dev_data *dev_data;
 	struct iommu_cmd cmd;
-	int ret = 0, i;
+	int i, ret = 0;
+	bool gn = is_pasid_valid(pasid);
 
-	build_inv_iommu_pages(&cmd, address, size, domain->id,
-			      IOMMU_NO_PASID, false);
+	build_inv_iommu_pages(&cmd, address, size, pdom->id, pasid, gn);
 
 	for (i = 0; i < amd_iommu_get_num_iommus(); ++i) {
-		if (!domain->dev_iommu[i])
+		if (!pdom->dev_iommu[i])
 			continue;
 
 		/*
@@ -1491,23 +1510,30 @@ static void __domain_flush_pages(struct protection_domain *domain,
 		ret |= iommu_queue_command(amd_iommus[i], &cmd);
 	}
 
-	list_for_each_entry(dev_data, &domain->dev_list, list) {
+	return ret;
+}
 
-		if (!dev_data->ats_enabled)
-			continue;
+/*
+ * TLB invalidation function which is called from the mapping functions.
+ * It flushes range of PTEs of the domain.
+ */
+static void __domain_flush_pages(struct protection_domain *pdom,
+				 ioasid_t pasid, u64 address, size_t size)
+{
+	int ret;
 
-		ret |= device_flush_iotlb_range(dev_data, IOMMU_PASID_INVALID,
-						address, size);
-	}
+	ret = domain_flush_tlb_range(pdom, pasid, address, size);
+
+	ret |= domain_flush_dev_iotlb_range(pdom, pasid, address, size);
 
 	WARN_ON(ret);
 }
 
 static void domain_flush_pages(struct protection_domain *domain,
-			       u64 address, size_t size)
+			       ioasid_t pasid, u64 address, size_t size)
 {
 	if (likely(!amd_iommu_np_cache)) {
-		__domain_flush_pages(domain, address, size);
+		__domain_flush_pages(domain, pasid, address, size);
 
 		/* Wait until IOMMU TLB and all device IOTLB flushes are complete */
 		amd_iommu_domain_flush_complete(domain);
@@ -1544,7 +1570,7 @@ static void domain_flush_pages(struct protection_domain *domain,
 
 		flush_size = 1ul << min_alignment;
 
-		__domain_flush_pages(domain, address, flush_size);
+		__domain_flush_pages(domain, pasid, address, flush_size);
 		address += flush_size;
 		size -= flush_size;
 	}
@@ -1557,7 +1583,9 @@ static void domain_flush_pages(struct protection_domain *domain,
 void amd_iommu_domain_flush_pages(struct protection_domain *pdom,
 				  u64 address, size_t size)
 {
-	return domain_flush_pages(pdom, address, size);
+	ioasid_t pasid = pdom_get_default_pasid(pdom);
+
+	return domain_flush_pages(pdom, pasid, address, size);
 }
 
 /* Flush the whole IO/TLB for a given protection domain - including PDE */
-- 
2.31.1

