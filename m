Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FBA11CBC
	for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DpXjFFo8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsKbzuvhK057IB5Zy0qVrsZwdhpIAmNjRoSfFpUboi4hdWVX2u0WgR7pxkovqc4XDNcPVpfjfbYndinidG5SvaNDL2y2Y6o0ed2Ze6IAM39SG97GzbSRtJ/ATTr9NkIVIKavLz0cjY/FKnwi3NbMhtSoURZOPMWWfaw/Cz+cnivHLPyAV/LSeg7yRMJxZZX7S2aHNREPjJdEf0DVTLzny6g6MVkcC+fOQLPHILyXvrI4Xaq9dkXwPVSFWkhJxHjhMPxq4a1fJtjRY5V1rQ19KK+omq6mxGJek+Otal6g3beD7DaFHKVL7oalyMjQLWH13jZstVqAk59axbyVYg/jAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7Oiw0uLWJGxHKmK9Xr3xzjo9/jo1B2aMqCPHZOU+DA=;
 b=RVmRAXZh/BeR4W+AFOu1e6J+lVK2gTi/dIMSBpwZk7GEreeBaA8N09Rg+X0+rvlaMHo8CSwdwe5CzwwTm7NGEBH283yGMpSHERR6Ug/6A/X9tv/I/y6PpMVjE3PhhdUpFXvj1+M64egapsR/GwywRVG3wg8jc3M0RXBpvot46d9jq0CLrtqwZlD+KDSfx4eJuLfyrQ0rrEjXN3g13VdsYhFLxgcm9Q2abs7B7UBOch7002HJG+PvgLyynLRroSwBg+ho/iIjWek3o5aWxh+CNnvR/ibJRAU/7rhmUFZZra+7tC4W+W5qkXWMf3BsXARGCqaE/0Ek5xcrOO+U/dzRfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7Oiw0uLWJGxHKmK9Xr3xzjo9/jo1B2aMqCPHZOU+DA=;
 b=DpXjFFo8eVe7jUDwgyRwwnQQL6Ri6brbVPmtd+O8fXMuq/BaWF9QNeY0m2JdCC5RHtbb1J2XBX2p6gvLQY/LByzhTm+ftn450I37Fo1XNxVFHTuqDtBvNgwsZnh8Y0VVO86AVTM/AaWMrJwTrwiyX+fiVXOAcw9SKB3DS5R9Wvk=
Received: from BL0PR01CA0024.prod.exchangelabs.com (2603:10b6:208:71::37) by
 SJ0PR12MB7035.namprd12.prod.outlook.com (2603:10b6:a03:47c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Fri, 13 Oct
 2023 15:19:36 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:71:cafe::eb) by BL0PR01CA0024.outlook.office365.com
 (2603:10b6:208:71::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Fri, 13 Oct 2023 15:19:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 15:19:35 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 10:19:32 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 07/13] iommu/amd: Add support for device based flush TLB
Date: Fri, 13 Oct 2023 15:16:46 +0000
Message-ID: <20231013151652.6008-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013151652.6008-1-vasant.hegde@amd.com>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|SJ0PR12MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: b3993e34-0a62-441b-9e45-08dbcbffcf6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hGoNWkokcBtTcfJebgrbqILpo2zb7rqXwKwR3fdla9tIPZoaSdXSmMraizDjdt2DkZOQVH55vBk7jyRN4zqteEmAfZ94q9PObY+S9mWzNPjfUqq0mY9IUfNT+cJpJOeL3EvhFyIY6fKU0iceBmBlGXUPRfJt8MJSccc1sUh35IngORMQCPwIKnSGWiLufX15kaHlw8+BgdJ6N+gg21uoueoBjmiUl+CFZ46anlcviGYpqxonk/y2BWdTewK7KB/yrZlSf90uL/BUpbBHsHHLBb4/SmbfT5swOrCw2cbFMkH2qrKZ3UpG1/GikQSmXI5eTelQaPaY/0NsOWBROWhysJ5oVyeG/j/EfbVOXtzElpskhHoqq47N0nbR3PlHntDPMNQjVXDqrM56g6tUKToSpK9IhMLBaiCm37XagArdeH67yJa+tmQywKlH3AWIESQvth5qVhlXULeb/tJkiRnAmV0z9S34zVeI8P/XdkhpwdfyU0K8MBDou0u1CkO3aqmq/Z4lBSLt6SO6e03d5mFpkI+Lhrr/B4EvWgEmlwN4oK0IHRDx64unNCX8h6xG3Yso8c/rYJRCSF4/tntDRxgPd62YAcJsVF/STr/DkurRkSJRtZXfCHAaxrt0vpuRpO2CuAskmp3gpHCEx9WQ3lHHQaHnZm0mBii8jpNNLbtu0EiWQP85I3LCYAxc/WdNTdcJh3kxQbADfLpfdejIiodN66VetpskCATG5jzbf8zq6vBOgAdLk6FD5qzMV0y5WgTCr9z+shBlMvcLoBIA4B+SVQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(41300700001)(336012)(426003)(1076003)(81166007)(26005)(16526019)(40460700003)(7696005)(2906002)(47076005)(4326008)(36860700001)(70206006)(70586007)(44832011)(110136005)(83380400001)(478600001)(5660300002)(316002)(6666004)(8936002)(86362001)(36756003)(54906003)(356005)(82740400003)(2616005)(8676002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:19:35.9976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3993e34-0a62-441b-9e45-08dbcbffcf6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7035

Add support to flush TLB/IOTLB for the given device.

These functions will be used in subsequent patches where we will
introduce per device GCR3 table and SVA support.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  4 ++++
 drivers/iommu/amd/iommu.c     | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index b2071ebc73b5..1f8dde87a287 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -63,6 +63,10 @@ void amd_iommu_domain_update(struct protection_domain *domain);
 void amd_iommu_domain_flush_complete(struct protection_domain *domain);
 void amd_iommu_domain_flush_pages(struct protection_domain *pdom,
 				  u64 address, size_t size);
+void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
+				     ioasid_t pasid, u64 address, size_t size);
+void amd_iommu_dev_flush_pasid_all(struct iommu_dev_data *dev_data,
+				   ioasid_t pasid);
 
 int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
 			      unsigned long cr3);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 09762332f681..0c44f3ed0c92 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1633,6 +1633,22 @@ static void amd_iommu_domain_flush_all(struct protection_domain *pdom)
 					    CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
 }
 
+void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
+				     ioasid_t pasid, u64 address, size_t size)
+{
+	device_flush_tlb_range(dev_data, pasid, address, size);
+
+	if (dev_data->ats_enabled)
+		device_flush_iotlb_range(dev_data, pasid, address, size);
+}
+
+void amd_iommu_dev_flush_pasid_all(struct iommu_dev_data *dev_data,
+				   ioasid_t pasid)
+{
+	amd_iommu_dev_flush_pasid_pages(dev_data, pasid, 0,
+					CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
+}
+
 void amd_iommu_domain_flush_complete(struct protection_domain *domain)
 {
 	int i;
-- 
2.31.1

