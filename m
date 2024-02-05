Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8DD1B806
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134392; cv=fail; b=Yv4kK7TxL8J+4fdVNeCqhHkNzpfKzCpPWRH+iLjlVRiGuBFb8xpP7PYSt/b9cbb5vkZDN401/BOPkTmm7ngrq9HWPGxEK6vyEPclbxP+IHyUvK4JBMbNPH6y6vQNRsB4pGnjNJvZCFXvfnCYzNeFfV7ZPAIsL+wgj1azyUp9JFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134392; c=relaxed/simple;
	bh=PzimpInnYmv7wPAPbOkk+fAkvTbqwnxbXPUjPAOI4qw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qluWeFGMTz4JgzZWFhxsaae/OEB3InTgRr+eTUnRtFlTYNjwpf+gOadEhh0s3gT4aiPw6DgiatubgrjYkugUBZ3vQW8S15Nlu9sk44/TdQs/5gL7W2ddzQjmxsdeCF/B/RkBf4zPUBJsMWm9zk4/IP9VvEZOqZLt2e2lvvE0Gp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y+N7yZep; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y+N7yZep"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQM4QsZ3kjKqB2zPfCwTpoBjw4gDMQraON9+df6qgOEcefONWFvoVwFYTnh/pzA1l2tQWT5m5KVMgJ0OQQ0uNoafy+iivnYR88E9IP50iFU5MndoaUoiSjWvVvra1uQ+gIOJVGjT5ZmSTS0Ap7kARH0YfrX7T3hE3mso8kwFe9XlzBSRp+9c5jtZLeOi3ipAjk3BZ6mWHcqHhNwMBWY8vuOVCtnZUdqis+YcOI0DkL6HzOn0DGyqnDuzHmQg+gKfX6+1iNTiZ0IQbmxuo/gag8g4aSzj2IgGICfl4ue0Bs9i+z94jo8pDiSVwGnYbVIqkaObMJ/afT/R4cmyQImmfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBDK6liH5rQyLTjSnRuf/8d/t4aoWCtN7/rtXoxXmPI=;
 b=ZfXVZtpBhGi+IflmUNi0q568vKWjZ8CN+emAyxn5zjeOlU72prxoo2S/NxbnGvLR6OF64Az9bmncdBxZjc6bR4yUCtpv8PC4M1wkYSKJr6uPY2tf5RWw4DjgiPBm7eprgl6u5wcH7mEpZvKJRXjM9r4MQ+hv3uhhL9UEmtuzBBdIM+5V4X4NyLah8UGcrzZnyw85tt6REhA78hl78zUDWwcP1wmkb2xHPbyJDOIRsEkMBrAqwe648DPlvzEIYFejsTRhSmKC6WLbK79Lv5F6xYrcc6vHwqL9Ksnlq5/u7CrIX/da/OkHDz2bEjWE4SNDJKoyZiyKwiRr7+IY1lAfog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBDK6liH5rQyLTjSnRuf/8d/t4aoWCtN7/rtXoxXmPI=;
 b=Y+N7yZepE5wbY2G+MhTrb+E7Bj4eaPMCCCDttzw2N6A+l3hry7GblJ1Oa6X/Zf5kojr7iiBcnykGIzPU1p6Rs9k1oc76zSyDNUZwcK/aYCXf3OKxvo8AFZjUmlJ5kbia8HcVd8hLLv2VH2C6L/jdWoxSE+IJllzkj84RSun3MZE=
Received: from BN9PR03CA0936.namprd03.prod.outlook.com (2603:10b6:408:108::11)
 by DM4PR12MB8498.namprd12.prod.outlook.com (2603:10b6:8:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Mon, 5 Feb
 2024 11:59:45 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:108:cafe::77) by BN9PR03CA0936.outlook.office365.com
 (2603:10b6:408:108::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34 via Frontend
 Transport; Mon, 5 Feb 2024 11:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 11:59:45 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 05:59:42 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 07/17] iommu/amd: Add support for device based TLB invalidation
Date: Mon, 5 Feb 2024 11:56:05 +0000
Message-ID: <20240205115615.6053-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205115615.6053-1-vasant.hegde@amd.com>
References: <20240205115615.6053-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|DM4PR12MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: ea0044dd-bbab-4738-bb1c-08dc2641f20b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eqfi4ACnBXGOn7W0hR6tjcIEF3hlqZeke7JUDD2Uz/1mowaSFaTcqC7dcH+yy4aSjpufRdlJmtCEe72ybL55XG1TN47nHl1x8ZYwTqFq5Q2MdT/waz+1oC/FpURomOiw3d2gIDmaLYWow5TArR2XryPHRB9xw3obeVojdPggnAZn+VFVYEzNhHrHSnV06P+zvWubDjLs9pRePwxGYbMPHhXg0xdF6fTM1ziDI1UWX+UvXEmQ+7dZ6zsbxiYxnPU6hVnPe65gn+SyzRjD+3ThH8aRld7VLSp6aDAjrgIi3lVxkn0MQ4P4cdU3oTOOnLEDCkvh0VFY885ZMJw5xmY9UJQcn5EO21Oj/WmnDKONcRyIEWxeTCs22yP2ubFVKtXtdci78MmqOjJKra1lUPB9nW4FJw4Uryf0Qn/gsNBMb2btTdFbOMUS4yqs92ULKXeBxf8a/Pkj8CaFUqItMf/k/VOPx0b+v9AAKTL3tIavJF7hvJ1a+pawE0HmWxThygqxYQcjdZ7mRPncR2c4sXdvY2XCe+S460k4e8vcyLKsC5dJdAuYdCaV33lt8Kh9EXI9Yr4gQfzdUUs9LEb1pnfsjtHMKuQLs8YZU96iUp3Ml9j6wOIwUb5mCb8DYlCDR2Y00A0qsAJ9VRYPrhYmMilRI0PvlSVyJUfaVAs/5vEGIjT+qqA5a4N04wLFC/EZYeEfkyUnPYzXyDCBGufgZCVn5JWgmb/mFPYCs/8N/AP47Mev7eauOIf0Ez1yakpgBM6iXxnH38/OO6/ZUiImz66D8g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(82310400011)(1800799012)(186009)(451199024)(36840700001)(46966006)(40470700004)(110136005)(316002)(54906003)(83380400001)(81166007)(82740400003)(356005)(2616005)(6666004)(26005)(70206006)(7696005)(4326008)(86362001)(2906002)(5660300002)(70586007)(478600001)(426003)(47076005)(16526019)(1076003)(336012)(44832011)(8676002)(8936002)(36756003)(40480700001)(40460700003)(36860700001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 11:59:45.4571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0044dd-bbab-4738-bb1c-08dc2641f20b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8498

Add support to invalidate TLB/IOTLB for the given device.

These functions will be used in subsequent patches where we will
introduce per device GCR3 table and SVA support.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h |  5 +++++
 drivers/iommu/amd/iommu.c     | 23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 31275bc6e9e4..5e4614dbd435 100644
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
index 915ff7ecf8ee..617942c9a97f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1542,6 +1542,29 @@ static void amd_iommu_domain_flush_all(struct protection_domain *domain)
 				     CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
 }
 
+void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
+				     ioasid_t pasid, u64 address, size_t size)
+{
+	struct iommu_cmd cmd;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
+
+	build_inv_iommu_pages(&cmd, address, size,
+			      dev_data->domain->id, pasid, true);
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

