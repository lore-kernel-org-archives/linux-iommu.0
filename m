Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA1738F97
	for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4vmx7x9g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkfyKs3Pl+iJbIhs4O4Y/dAC39Lq7qlpqcDducl6jWn0xq5Bva3GVsl4pHg8Q2fUUACOecernMeJynQQjpJFoweMIIW7xJTyqHoL/H89r7o7hYORxMnZxYAWyvZY0uTlphGdXcHg4psc/yuGBF4r9hKMRZoajgUHFFWRtmadRyBAqM7IoVWBUQfEqGtuNnsSH1zDtYxuAdal0gfPBABha9Q5WMTE9QhD98gd377yoycdcTeQsa33FknJOBQ/VkGVKAjny7k0Hv3BYbnA6UCdLAnR0A97Ez/DR5TesXy3zdpHmy6iNOUAY+uyLBEhqBTad73jZsvugH8wc5V7j9TS0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ff0ZY5u4wl3r/s8ygeBeyvNGhEXi3jDYoW93tz5AH4=;
 b=Lq9vAPSb79sa79n5Q2VuxgTeAJ7qstwThYP1QnFuOanPpweuG8MSbUr/Mk5JRwdLkIV+1bqJGqk5io7Zwa4K3LeU49aPNG1wXY4g0h1tFAoV7GZtvOcxZhhOcEpck4py8Wqnp+0pbrxoXExoXtkXjmciwGpUbI2x1RviUukOMANDOndS+VkFQ39q11YaqHjm8pvkaXtMF7SL4dbLkcZhHDyhypw47HR679yIE75PZsrasNBsNchAIHQDCYyW+/Et8WDWj4iLnw35MSzgbvRGzM7qIEkgwdqG9NwRBfxwZLQVDC3AysxMDKcr578A7yHjtjkXc1A5uS2g80mRxaRl1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ff0ZY5u4wl3r/s8ygeBeyvNGhEXi3jDYoW93tz5AH4=;
 b=4vmx7x9glrsjtCPnmqnKrdNJFc56qYV3Nk7tvO6NXxv+mcUWNGqyJYLjvX7z0Iuq7fRhZM8p42endjnS4wEwgk6HXRUZ05EY8T4ogl81owLv8gC0FIze5K+GMNcP5kfOoRC15GcTStPxOF2GikZq5Y0u5XA3FuWZOqUM68R6rCM=
Received: from SA9PR03CA0010.namprd03.prod.outlook.com (2603:10b6:806:20::15)
 by IA1PR12MB9032.namprd12.prod.outlook.com (2603:10b6:208:3f3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 09:05:06 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:20:cafe::21) by SA9PR03CA0010.outlook.office365.com
 (2603:10b6:806:20::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 09:05:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 09:05:06 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 03:05:04 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 9/9] iommu/amd/pgtbl_v2: Invalidate updated page ranges only
Date: Wed, 22 Nov 2023 09:02:15 +0000
Message-ID: <20231122090215.6191-10-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|IA1PR12MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: d13c0f4c-3f0d-4ae7-5c7c-08dbeb3a1f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	avggzA+LXayaKVGRVzmLOVuw3dNrFC4aMoKftf4eNeU0W8tFf8G/VGxNbZNgp6BzccQDgQ/YXKkWC96yonJHWhItBv5p00ypshuOZhSPxKyRvBHoV/MKq8CWe1H3dNLD3OQbOKoRBStdUvFOS5aSN1kvgFuBYwpIDbh6V75kSZRDZptEgz0oem/5gZkyofmsc7Ac6GAwolRoKPzD5Pj/pdAAdzTCJi8SeTPDWGhgVVr56zWJ+nAmGcV5/ZvbGK39r6N1rNci7Bn/OshoGptMwlm7NvMo6y53d9+qg2O6Zi0E+ioFsU9bcW+vYHhFt8ZReGgpvptgl7fJ3uXolB6U/iA3c2vufEDeL07GlPC8//rp8H5TYIRlJ2IdYE0ZLcQEncuCl7cCB2scd3vL2Z6cqQKN2wqnvt5UP0mTOR/ANblwOeMtTx4EDLlJj28OpA9uPI6GnIu+ddJ59f1UIj+x7SiyoycxuficLfuZCWB1M8yO0Io8swmJ/mlteGe0w+CcEWXwWh690CFH9cQXrg35Tahc38H+OqZt2EtrUknGf640pHtiQnUtqxcGNXodAza26TcCAQRWAQPuU4qYpGYTr+JXJk9tEFJz5wtUb2a/KViKGxkOCxjlK+R0h4ZVtlWfvnbp/JR2UKpGts46Z1h3d8jhe0II4jcMBgiPDhXDO/JY6n+MIEe5F4DO0Nhcqa0tLPNYCrOPrHaA+9bkaYWKdKa88sbh8SAfe2kPN3v8elMj4Tw5gakOM6eUeltNMz06rqY8PcfLuCKJohCbiWBmBA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(186009)(1800799012)(64100799003)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(2616005)(82740400003)(356005)(40480700001)(86362001)(40460700003)(70206006)(6666004)(70586007)(54906003)(7696005)(110136005)(316002)(36756003)(81166007)(1076003)(83380400001)(26005)(426003)(336012)(2906002)(5660300002)(44832011)(41300700001)(15650500001)(8936002)(478600001)(36860700001)(16526019)(8676002)(4326008)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 09:05:06.3598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d13c0f4c-3f0d-4ae7-5c7c-08dbeb3a1f04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9032

Enhance __domain_flush_pages() to detect domain page table mode and use
that info to build invalidation commands. So that we can use
amd_iommu_domain_flush_pages() to invalidate v2 page table.

Also pass PASID, gn variable to device_flush_iotlb() so that it can build
IOTLB invalidation command for both v1 and v2 page table.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/io_pgtable_v2.c | 10 ++--------
 drivers/iommu/amd/iommu.c         | 28 ++++++++++++++++++++--------
 2 files changed, 22 insertions(+), 16 deletions(-)

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
index a52e795c4cfa..849935ac9372 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -85,6 +85,11 @@ static void detach_device(struct device *dev);
  *
  ****************************************************************************/
 
+static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
+{
+	return (pdom && (pdom->flags & PD_IOMMUV2_MASK));
+}
+
 static inline int get_acpihid_device_id(struct device *dev,
 					struct acpihid_map_entry **entry)
 {
@@ -1382,8 +1387,8 @@ void amd_iommu_flush_all_caches(struct amd_iommu *iommu)
 /*
  * Command send function for flushing on-device TLB
  */
-static int device_flush_iotlb(struct iommu_dev_data *dev_data,
-			      u64 address, size_t size)
+static int device_flush_iotlb(struct iommu_dev_data *dev_data, u64 address,
+			      size_t size, ioasid_t pasid, bool gn)
 {
 	struct amd_iommu *iommu;
 	struct iommu_cmd cmd;
@@ -1395,7 +1400,7 @@ static int device_flush_iotlb(struct iommu_dev_data *dev_data,
 		return -EINVAL;
 
 	build_inv_iotlb_pages(&cmd, dev_data->devid, qdep, address,
-			      size, IOMMU_NO_PASID, false);
+			      size, pasid, gn);
 
 	return iommu_queue_command(iommu, &cmd);
 }
@@ -1441,8 +1446,11 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 			return ret;
 	}
 
-	if (dev_data->ats_enabled)
-		ret = device_flush_iotlb(dev_data, 0, ~0UL);
+	if (dev_data->ats_enabled) {
+		/* Invalidate the entire contents of an IOTLB */
+		ret = device_flush_iotlb(dev_data, 0, ~0UL,
+					 IOMMU_NO_PASID, false);
+	}
 
 	return ret;
 }
@@ -1458,9 +1466,13 @@ static void __domain_flush_pages(struct protection_domain *domain,
 	struct iommu_dev_data *dev_data;
 	struct iommu_cmd cmd;
 	int ret = 0, i;
+	ioasid_t pasid = IOMMU_NO_PASID;
+	bool gn = false;
+
+	if (pdom_is_v2_pgtbl_mode(domain))
+		gn = true;
 
-	build_inv_iommu_pages(&cmd, address, size, domain->id,
-			      IOMMU_NO_PASID, false);
+	build_inv_iommu_pages(&cmd, address, size, domain->id, pasid, gn);
 
 	for (i = 0; i < amd_iommu_get_num_iommus(); ++i) {
 		if (!domain->dev_iommu[i])
@@ -1478,7 +1490,7 @@ static void __domain_flush_pages(struct protection_domain *domain,
 		if (!dev_data->ats_enabled)
 			continue;
 
-		ret |= device_flush_iotlb(dev_data, address, size);
+		ret |= device_flush_iotlb(dev_data, address, size, pasid, gn);
 	}
 
 	WARN_ON(ret);
-- 
2.31.1

