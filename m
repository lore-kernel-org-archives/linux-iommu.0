Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1311C6BB
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nO8EXcIO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Un4x4XZHPw9wnWOs1uxVOqsC2d0/QTMaXe5g0y2IlLhlAGzOrH26vmQSD6JmBTpZHR4FVL5KOp61Isvi6aCA48/SD4QPmHyBIqMSH6VpJuW7cesY+lydn1EcpnQkMCrDM8jBe8kyDRaRAhipkYEReG2Owcdp08eIe212vo1ghBKqxU3f56LFN5xIf67X8Q/9ff/eDrdkNz61HmLMvbflYZIKaxCvVA4Mwd6GLl98Mjz00/d9T0r14OTwg7Yy1U/5aYHu8Ahm8J4wCXDlBz1iS1Tl5Doo4zGLI8Zx50Zv8Lw6br/yAjxdGHIYNfY1Mt6g5Sk7QghY6pQYxDSil5U3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2rGvlS7uQQ7F5aAd0yRm1SuJVSllHtgnoUVi++tSEg=;
 b=hVtTLLkIWyIu0Xs3WneLOEipTvLnHy/NfYr9elshf97SW2x25tnZracby8/9fXlGPIU6Com4xfcvJr1jR20oOlozZrFic+7+anVgmneQo0AG/MPzigYrdhWDlgqXjw0tUjzGPqNfEXq9rCv2+NElLCAqDoR879xcHGXBuTmYjmLF4WfZh/3SPL9UcqgYwIs+JC7/DUWOA3AOmEVXCUSkfRhifJxNQ6w5oon1OgizqKlbPxh618Qa6B6z0oYCLQZ77y0I/VB92Sqje0OIUfE5rGz46VHSXfTbyU05j+7HHDmxGNQnInWgtwWUOh8Y/7cuLkaz98GBolykI8zetF4/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2rGvlS7uQQ7F5aAd0yRm1SuJVSllHtgnoUVi++tSEg=;
 b=nO8EXcIOxgOwoaInbLzP+YHEsagt7Qo8vhHIE2I2uWYOSZyxS5i2xansvicBeef0jM1oT10Y7Lzru/MQoUah6327u5nfJYCS34BNORdelGrj51CYsX14Rb2t7w2uU0yXBLFini9FDgfTweHhMOFQIgiA0NwG2jESYpnjWwjoSyU=
Received: from DM6PR08CA0036.namprd08.prod.outlook.com (2603:10b6:5:80::49) by
 CY8PR12MB9036.namprd12.prod.outlook.com (2603:10b6:930:78::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.23; Tue, 16 Jan 2024 16:56:04 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::ae) by DM6PR08CA0036.outlook.office365.com
 (2603:10b6:5:80::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26 via Frontend
 Transport; Tue, 16 Jan 2024 16:56:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 16:56:04 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 10:56:00 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 08/17] iommu/amd: Add support for device based TLB invalidation
Date: Tue, 16 Jan 2024 16:53:26 +0000
Message-ID: <20240116165335.6043-9-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|CY8PR12MB9036:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b992dba-3fb6-42ab-3bbb-08dc16b406bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fzylyjpLvmSpyhvPsPwqPfEowg0fyM7ZGUlpjrwDT5kL2OPB+hu2RWVYUDJ87qh/84mIxIzW3Xz1Mo/DuZhafrDaoohQteKLlxE7c+fkMPLpc9hVZN57k76Gs+kcs7OGZlsZitPIWkes1cSD5rzcyf3fVzCHElOJ5wVK/sT7DBzP0Dv5cDFLmSnckF1eMtEyuqKFCwUSu8BOc78ld6kBd99wVkrVxDCSed1BvKwnekMBDA/S4bFNn636s181QwUt0sxR7fZTZjAQ1RKqoPuYJCF9xUFpHWy+ZxAIGOV0jGlN/gUAAtk5VMD8v9nTyimIEZJGEtdsWZu9wIEiOWf5ekgk8m6aKlfHLd0Ro8q4bgZKGn5covVbOwpGvaVnPwcdsIE8tC2t0L3zBcXByp+eGB1festv7b8S3QRDkuWHAb4qwUQ79ZNRTpS2Re3MybFVD/yBzP7/lEQfmwuCkurvHTG8SK9MNYsLTVEJFUcfjO94QQb1v0Ds6hpJqvhH7dByh1xbApGGbapl2uoyoDke6rHAY/tiNKM8f0F6odbxgVOsXaRjyDkwRaRF1B3zbP133Z9YC6Qym4PFf7fLBi3yLfwVIwrubI7MxwlQf2o/il1Rr4OJalKo1/Ud9T86CCxqpmg6gC2MMaepd1dWWJpEvP/dEtxn0YnMBwQSlnPXhjllrBC56FU9wjygTOsnVG1+icKhnUvlEpGe7O5ZdmphlEt/kTc+FLE9/bzlEDlSLaJIcHokS5mL9IB+dbcPFgLWgftR5J3q2T+fFY1Fv6814A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(40470700004)(36840700001)(46966006)(82740400003)(2906002)(5660300002)(41300700001)(36860700001)(36756003)(86362001)(81166007)(356005)(54906003)(2616005)(110136005)(70586007)(70206006)(478600001)(316002)(6666004)(7696005)(83380400001)(47076005)(44832011)(16526019)(1076003)(26005)(336012)(4326008)(8676002)(8936002)(426003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 16:56:04.1194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b992dba-3fb6-42ab-3bbb-08dc16b406bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9036

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
index 34004f0e90dc..f83e0521d9a6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1582,6 +1582,29 @@ static void amd_iommu_domain_flush_all(struct protection_domain *domain)
 				     CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
 }
 
+void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
+				     ioasid_t pasid, u64 address, size_t size)
+{
+	struct iommu_cmd cmd;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
+
+	build_inv_iommu_pages(&cmd, address, size,
+			      dev_data->gcr3_info.domid, pasid, true);
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

