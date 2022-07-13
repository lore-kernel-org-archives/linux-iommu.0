Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E283015A9
	for <iommu@lists.linux.dev>; Wed, 13 Jul 2022 05:31:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5Db2iMvOPGnPuRhIJKmZ7Aq1fMhhmrS4A4tU5bcTxL+auuTIaaHQRrVUfeT9HgYWlnMS6vv9TUiVD17C0WBrEfWfslUST3h1bDoHnJ/fqit9uRCxLyi0Gh/KdZwKoB0kzyXaT7XjaTaT5GCOSaCZIf+7RV1isGfHZnOCRiTFmprXynuccMgDk02WoXu/kRhBfrnCvv2P4E9D/ShWNDcvN3dMzHifNXitVpBiGtBtpH9fUEQrv7wFnYZhQmZLGQPsGaoo96nVRHkvuzcY7w6q9XJIl5gJ3j78ej0Z0UsIwoOhBn6KvUcbyOGc6VQZRPcHJPYfWpf0wRnSCtmsYb+aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LR8n1Oi5e2G9sA/bWX8MQnf3YwRNJTvi0t62Dh5wOrU=;
 b=OkGHUsd+UWEUC3U/IE2NA62xPvsk4bUSC5bcZ+uMfLwLsCAJMQftRDDWV9F3Webv5oeFQJLqoYAl8fI9QIC/WnP/3cfuXQ+FwOOqLJP15k8Ic/HojlWOzFin2JYW+Wmm2MMst2/XUnPOjOWEZFB793VTTD4MCWnLx3QWX3dos6T3XE58bA2LT/siAaSsnwMZQYdWzs+/JxFLlCKJOETAYMqvVSPNfp0S/G7hN6+64NrcXlKWh+xwPyfjRp9d5+AhXgYF/ZTZ/E8MU+Y1RW/53sWBRVup+qxPa4zsukBO1LpaMfD7mnKC/vFirgp/ttgt7lCE6tqLDWWSax/sJr5+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR8n1Oi5e2G9sA/bWX8MQnf3YwRNJTvi0t62Dh5wOrU=;
 b=LYROJ1QED1uvtJRIYLbY6KJHCusFZ48pI2WJXce95dkiNXZd+Y3TT6rMbbt9StJJidDykPnwTpAsKuSKHksWakgQCWTvzVQbH9s0XdMfGfmcbnZ/NP1H7ckhMir8l9Ma/yzVePMWoOvjSXZZm6VVf9kYj8Jqdd46mcUBe7ITJuE=
Received: from BN6PR19CA0118.namprd19.prod.outlook.com (2603:10b6:404:a0::32)
 by DM6PR12MB4974.namprd12.prod.outlook.com (2603:10b6:5:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 05:31:44 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::12) by BN6PR19CA0118.outlook.office365.com
 (2603:10b6:404:a0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Wed, 13 Jul 2022 05:31:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 05:31:43 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 13 Jul
 2022 00:31:41 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 2/6] iommu/amd: Update sanity check when enable PRI/ATS for IOMMU v1 table
Date: Wed, 13 Jul 2022 11:00:30 +0530
Message-ID: <20220713053034.12061-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713053034.12061-1-vasant.hegde@amd.com>
References: <20220713053034.12061-1-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f1f9bbe9-f65f-471f-a51b-08da6490f8b4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4974:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kAr58bWdnpYuosnRlz2u88ZO8WOMFQGebkKL+IEVFQ7W0w8QumGVCHjGFhOEnjv0kajd+xlp7rDfIsM9Feywa1WEHBqFchDvLMQaO7xrlZr1br26YrJU1jofTBqWCnFniO96P5fIzZHNGbEAnuMPnMjSLHCC2hpiVP/kOIQGzNGaxuarNLmTQcW8/jOiArFY5pGpYG6DjZMPTc8T9uK2g4afIK9MRHXwpAxmrihvWWxlGFsSwfjMzQWPxIs1YQAua2rgunML3uaDCNRB/US3RZj0bkwv8ObYu5D3q+WPS4FZqH3drjQVEC/czY7e3K/Wn5ykM4RzozFSTpWLAl6cqQBVqvnWK0j792eASqOEEXqeVIlsYWtQvERSR8K/qOMjbP5qxMEsawBsTSi8JK8uCSLcTttnPYm19Svdzax5x8ep3S/rYcqh86GbdDV1jGyy5TfLt0QM77n0Hyw0t8icjWJCe2eiWjBAJ8H9LEqA5PagT79jhyv53KD8kujP3F758hOj+FvaVOUV0aUAzZTmnMsruy0u/9NSU8C+q+lxUlegT5zcwtq1kXuZgB5hVTkpI/vN6sx1mrBn4I+I7BrCebqnVes4en6RqUPVjsRyvOlGRZM/YIfo32HPozexJzD39Y9BM0JwzHz+XNMmcqZhiif+SSgX3ry9ldJ+2OoHzofbEG38ewbd8Z7qjdJJ74G0gnqWcd3pM+U51guG/SXJXE1DnE7ZAwE/b8LT2nS4htBHnFxg6YeU46SVTH758FhTl5CexN+GioVWDGtaBe6W/sVNdgOAHNzXaSPwerZwbpxCMkFk+hz4EuUSxP/uiZHZ+zwauija88aASMxXHWnOglY3zjUZ8BV7oKp7q3C0fZU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(40470700004)(46966006)(36840700001)(44832011)(8936002)(1076003)(186003)(6666004)(86362001)(110136005)(54906003)(36860700001)(15650500001)(81166007)(16526019)(36756003)(82310400005)(2616005)(40460700003)(2906002)(478600001)(70206006)(7696005)(47076005)(356005)(5660300002)(426003)(26005)(336012)(70586007)(41300700001)(82740400003)(40480700001)(8676002)(4326008)(316002)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 05:31:43.6221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f9bbe9-f65f-471f-a51b-08da6490f8b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4974

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Currently, PPR/ATS can be enabled only if the domain is type
identity mapping. However, when allowing the IOMMU v2 page table
to be used for DMA-API, the check is no longer valid.

Update the sanity check to only apply for when using AMD_IOMMU_V1
page table mode.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fd5dc6541569..027ecd5fb4b2 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1682,7 +1682,7 @@ static void pdev_iommuv2_disable(struct pci_dev *pdev)
 	pci_disable_pasid(pdev);
 }
 
-static int pdev_iommuv2_enable(struct pci_dev *pdev)
+static int pdev_pri_ats_enable(struct pci_dev *pdev)
 {
 	int ret;
 
@@ -1745,11 +1745,19 @@ static int attach_device(struct device *dev,
 		struct iommu_domain *def_domain = iommu_get_dma_domain(dev);
 
 		ret = -EINVAL;
-		if (def_domain->type != IOMMU_DOMAIN_IDENTITY)
+
+		/*
+		 * In case of using AMD_IOMMU_V1 page table mode and the device
+		 * is enabling for PPR/ATS support (using v2 table),
+		 * we need to make sure that the domain type is identity map.
+		 */
+		if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
+		    def_domain->type != IOMMU_DOMAIN_IDENTITY) {
 			goto out;
+		}
 
 		if (dev_data->iommu_v2) {
-			if (pdev_iommuv2_enable(pdev) != 0)
+			if (pdev_pri_ats_enable(pdev) != 0)
 				goto out;
 
 			dev_data->ats.enabled = true;
-- 
2.31.1

