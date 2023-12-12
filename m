Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D250F55797
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5U+M4Aht"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfcT2ivogrRIoI4R11rS5/JmsJ5TcyX+c7RtoG6GnnCRpUDIYQgLYqI0bKqTCxpsoAiRVyK6HWcoNUIPFbnUnHSPCz19T5cj+QIrIjVMlanhWigdrrEBjR1P81QF/oQaXOLFHWhyFBp8stnfgwn9nhDqlxBshb4DpmKNa5Yd7AO4xUE0SUEu2pM6pxScGmUqLXaa1XT4TFj0bR2HDS/F+QUedZtvyTyrBLz+Lm+kKTdGUvDxsLShKA1D7w6tf/4XjOuBDOz/FVSYuBrvC+2LDdFfxwKRdRfidPHeZOqWC+Hob2ptMGeVwxRq2986aSz8mRUVLmSFTfHlCL8BRp6Stg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeQ/c59oPefyA42ReYRxIhFuvghPwrFn+0P1/SXBgC4=;
 b=YsY6L6j7nvsahH34DG/mbc9bEbZDAC0L+bRW0FMbx1k4yD+bEl4SMMawanY+pKBByqTPHpWdzyaDpV+VGgxHHPCk2yvxxGL9F2vAWefk7a4JW5FmlEpSdem32ACzjFcScTZxYgVTP1QZA4QyNncSjsVt1I8wjDzcUkaiV9IWvUETcr0Q7yEs3TbUSwCLX/1ZJicRpR1KeLVM8TG8UlDemOUyChIRyL0uUyQAnfSWSeq9YoaVHrBS6jELnd1mFsN32i4k4NdFYb0HJ7J94gvJPmZ7Lfs/OnuoEkUM1LmNjux8YjdKeaduAeYN7t273cBkVtDT14bylsY379DqA6nktQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeQ/c59oPefyA42ReYRxIhFuvghPwrFn+0P1/SXBgC4=;
 b=5U+M4AhtsGDhb+rZ8ebY0MiBUYPZ3FbsWAVyThMoNPkUVs4abdO1hXq9HkGSBXweg6L5fXOpRYMR7dtkzueWsgbfmAU76wb60AnCkc+zTvFoHmYSKceBd7CxntP1PrHCYC3TAGo7C+Xv7Xuw+990egpYWAfe8BkHEC4HKoToTcM=
Received: from MW4PR04CA0352.namprd04.prod.outlook.com (2603:10b6:303:8a::27)
 by DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 08:56:24 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::43) by MW4PR04CA0352.outlook.office365.com
 (2603:10b6:303:8a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Tue, 12 Dec 2023 08:56:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 08:56:23 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 02:56:16 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 08/16] iommu/amd: Add support for device based TLB invalidation
Date: Tue, 12 Dec 2023 08:52:16 +0000
Message-ID: <20231212085224.6985-9-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|DM4PR12MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e0a6118-2f8c-4190-887a-08dbfaf037ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vq3wGRLpEUs7nh2OWZ9XvqIvzxxIkPrxm7Sy/zl893FzcqRhsheoYioedwZP1bueQBIrFIQIRJXvsJndLWHrr2g7YrTA6Ksa+nRmPXYnzZb/jknvz8OLYJ22UqQTRydmndPaQ3dX/jN3/O2I6IOsz4J97IC5acQVTcL5qnZMxI5tpg0yAAOQqnrE6ru40ljKti5WOe0c1JlVF0ht5ILSH6n75h6LHmngRdFD0voIDtFPrxeFq3Hy4DPKTdZ6QPAI67f5FkqDBJRTMeF3qixrgNGDpymi4bI8KAboI47A8I2IYEnDBsvHb5hBaU5cWv6jlILvi3pz0pa74YzY1g2romaYIzVQULN2LTaVdKWLXEQBTvo5IcckT6cXRH+EGSffySB6eY+uWf7jlWZlmpW+miz+TqkLAyAmpdMDgPftt0FzHNE2Z6v4uJP+NjQP9a1znMW3a1m0G+us9EuMxOwKm/w/jMj3eHc9YOI49/5QIBLSRIP9Y8QsGBXWjX5BXSl62aA9K91Ezp9nyp3wk//x/7VjNCmiGMIV9KgXuPaMIxA3LXiLAr1O2/FnDVa5QuwKiN1HO08LXEQl0MIohrd2IyoLth8vVuxqyRg+fFtt7l7YMVoed56kfOUWQ5Wu/2k7p19qVQhZjnJ6vwOFS9ODunTdPvkoadRB0PVfxLPLOZF7j4Wgz0vnwEB8xg2EjPLsqJJPoeUVwEBafg158ZMuJVAnb9ChqU57M+fZsW6vXFJC5SIPUjlG/RWO2f5veVlrnVsY+CRzmhYu67npuSxv1Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(36840700001)(46966006)(40470700004)(8936002)(8676002)(41300700001)(4326008)(2906002)(44832011)(5660300002)(478600001)(36860700001)(1076003)(2616005)(16526019)(426003)(83380400001)(26005)(336012)(40480700001)(47076005)(7696005)(82740400003)(110136005)(54906003)(316002)(70586007)(70206006)(86362001)(36756003)(81166007)(356005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:56:23.9059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0a6118-2f8c-4190-887a-08dbfaf037ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397

Add support to invalidate TLB/IOTLB for the given device.

These functions will be used in subsequent patches where we will
introduce per device GCR3 table and SVA support.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  5 +++++
 drivers/iommu/amd/iommu.c     | 23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 4edadace486a..ac95481f2339 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -63,6 +63,11 @@ void amd_iommu_domain_update(struct protection_domain *domain);
 void amd_iommu_domain_flush_complete(struct protection_domain *domain);
 void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 				  u64 address, size_t size);
+void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
+				     ioasid_t pasid, u64 address, size_t size);
+void amd_iommu_dev_flush_pasid_all(struct iommu_dev_data *dev_data,
+				   ioasid_t pasid);
+
 int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid);
 int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
 			      unsigned long cr3);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e497ce58b24a..578462a2325b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1588,6 +1588,29 @@ static void amd_iommu_domain_flush_all(struct protection_domain *domain)
 				     CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
 }
 
+void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
+				     ioasid_t pasid, u64 address, size_t size)
+{
+	struct iommu_cmd cmd;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
+
+	build_inv_iommu_pages(&cmd, address, size,
+			      dev_data->domid, pasid, true);
+	iommu_queue_command(iommu, &cmd);
+
+	if (dev_data->ats_enabled)
+		device_flush_iotlb(dev_data, address, size, pasid, true);
+
+	iommu_completion_wait(iommu);
+}
+
+void amd_iommu_dev_flush_pasid_all(struct iommu_dev_data *dev_data,
+				   ioasid_t pasid)
+{
+	amd_iommu_dev_flush_pasid_pages(dev_data, 0,
+					CMD_INV_IOMMU_ALL_PAGES_ADDRESS, pasid);
+}
+
 void amd_iommu_domain_flush_complete(struct protection_domain *domain)
 {
 	int i;
-- 
2.31.1

