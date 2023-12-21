Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8FD6ABB9
	for <iommu@lists.linux.dev>; Thu, 21 Dec 2023 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gfNBzVIe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDDohJ11JZ8riVKrimlDYRHp+PeF2HMSZmJ/DF3Koe7AGHKpFVZDcNjE1bUAlYXv9C/W0WW0bPwwXGZtSNXCduauNRpNQ9XQ06bJ+LTAgdm92vs2uQZzED2oNB/Ou3e1bOLtSzkwKpve3+j7Z7HeoMRucGx8on95pgaoasitr+O763QY9wiZ7sIDTgk6Xc+GV9fPkHX6YwMbO98DV/hTyZTbUxbPlxDwIJZIbI9Tor9TlBq0zOnfWzsbdbyJVMdarlcUTh1cjOcHzbF8MqI0V4kEm7BkK3zxXuhzQDbYET33zMn/2PzW1bvHsJCn9F5xHwLq0i+2t8h55IWoNtdqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPuXxHaNxnL0//ufrMcRhqfyjD/xBItk4fK8JN8ywVE=;
 b=kGpXoGdkXoiQp9PwHMsuFDnkxSfR5Pz+inGG+st9hWbTthSIjEyDWkz3C+C6PGCK61qTOgwuj8a1GhmVyuwcsjO+oXaT3jlHxfi2E02UVH9ckoJkBct8NCWrlnKDRKOzAPwVeekd0E0yCYH/fNhpP57CqQDPs1l3ajxEC12+N9xoa58flNRl1rBkSenlWQfAgfE9f3qQW/+xKoTET8D3hSd04wzp0mDnUV3/pzS+8XXPOOFFGl9hk8KFLChYSdPv8riuCIx309VVTJwA9DDBhXRC/cxRqk6pogs+vKAopQ1dGbCIE6hBhYx3GpeC93k/UljJH7cKWEyt1otJlEMPZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPuXxHaNxnL0//ufrMcRhqfyjD/xBItk4fK8JN8ywVE=;
 b=gfNBzVIehs7bxvA80IpIJxeCgr4WzWPg+SMVYnkFWZVgTP5cg1PdGszcLuydLaZwbQvXtZSsXfmDCvrgPHY1vEtxPBvrVGvzLtympCPybjK3QY3/AKSz7vN/YabtaDhfUmvy8ZzIKccYdYBr2sasegcmTt2hWQf22p9TWdZLAXE=
Received: from BY5PR16CA0003.namprd16.prod.outlook.com (2603:10b6:a03:1a0::16)
 by PH7PR12MB8779.namprd12.prod.outlook.com (2603:10b6:510:26b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 11:20:10 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::b5) by BY5PR16CA0003.outlook.office365.com
 (2603:10b6:a03:1a0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Thu, 21 Dec 2023 11:20:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 11:20:10 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 05:20:05 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Jason Gunthorpe <jgg@nvidia.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 13/14] iommu: Add ops->domain_alloc_sva()
Date: Thu, 21 Dec 2023 11:15:57 +0000
Message-ID: <20231221111558.64652-14-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221111558.64652-1-vasant.hegde@amd.com>
References: <20231221111558.64652-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|PH7PR12MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: 744ef49f-00e3-4c9f-175b-08dc0216cb4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m5gP+UysJ0nhEvrE87dhABJUIxtwC457f56kzNBNzfzbtxklkzSiGP8/3SfqACEOJtfws2ytrH/cN85u3JlnZs1B9vcJA2+PX83UI4NOPM9s/m53kkT7FtrIS5zhpAtDkfE0SBalGNSZlwsSiY4Mre5nbV+ta04R422zxOYliCqwu//Yv5ittk6GDh+Wes9pjVSCqGgGePjPTCbFAIASD0bMOrxpbruAczQcC6Bj46vjLA3znTdyszjeJn+D3RBs0Fdu/X7iXY7/XHxhYFR5muFcw92CWfQ524clPWT5H7wKYCOeRfmoTOf48rAYOkwH0WoY66KydRGZg83J5ta18ttwDJG6iw93Sp3BDACf5MKUGAb7foEcElo4G+L7Gp+kySxSR01oXjtTE6DlbdkDUjAltIFPdGGk3+6ymqdwwMqknapTuUzAPfdxCodnMKuwvvXii663pVUZZwIXXRGDy9IKxMailYOF//TOhi7Lauz4VBDjflZn8fuo2qcSXzMX6NsFbEOhE82b6FvgEiCVIP18uhKfAeoXEUZBPAPQ0YsemYCjxMbECxX2byLQry+D9Zq8pCFHDP3kRus0WBaDEXT3rTaIQp9LBY/fW8KL1gnO/yLj2qY+SerLINgWdXvYMktxyV78Gyva3yYDbNXA2ML96+dyMaY81rrjqp2jRgVSvARjuGP3FseO7scIJt0hfZu0blximLMGdW2v6k5tTg/xjTd41XMNyW3pSNnt+4StVbQGVzOUswhunOSuC9tz7k/heckwjYlWb5Iesr964g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(5660300002)(8676002)(8936002)(478600001)(26005)(1076003)(336012)(426003)(16526019)(81166007)(4326008)(2616005)(40480700001)(44832011)(83380400001)(40460700003)(2906002)(70206006)(70586007)(316002)(110136005)(54906003)(36756003)(7696005)(6666004)(47076005)(36860700001)(86362001)(41300700001)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 11:20:10.1528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 744ef49f-00e3-4c9f-175b-08dc0216cb4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8779

From: Jason Gunthorpe <jgg@nvidia.com>

Make a new op that receives the device and the mm_struct that the SVA
domain should be created for. Unlike domain_alloc_paging() the dev
argument is never NULL here.

This allows drivers to fully initialize the SVA domain and allocate the
mmu_notifier during allocation. It allows the notifier lifetime to follow
the lifetime of the iommu_domain.

Since we have only one call site, upgrade the new op to return ERR_PTR
instead of NULL.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
[Updated domain owner and removed smmu3 related changes - Vasant]
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/iommu-sva.c | 17 ++++++++++++-----
 include/linux/iommu.h     |  3 +++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index b0e069562bb8..0d78d7c92d79 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -99,8 +99,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 
 	/* Allocate a new domain and set it on device pasid. */
 	domain = iommu_sva_domain_alloc(dev, mm);
-	if (!domain) {
-		ret = -ENOMEM;
+	if (IS_ERR(domain)) {
+		ret = PTR_ERR(domain);
 		goto out_free_handle;
 	}
 
@@ -270,11 +270,18 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_domain *domain;
 
-	domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
-	if (!domain)
-		return NULL;
+	if (ops->domain_alloc_sva) {
+		domain = ops->domain_alloc_sva(dev, mm);
+		if (IS_ERR(domain))
+			return domain;
+	} else {
+		domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
+		if (!domain)
+			return ERR_PTR(-ENOMEM);
+	}
 
 	domain->type = IOMMU_DOMAIN_SVA;
+	domain->owner = ops;
 	mmgrab(mm);
 	domain->mm = mm;
 	domain->iopf_handler = iommu_sva_iopf_handler;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b3b48e347c3d..0b18f1bd8b8a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -450,6 +450,7 @@ static inline int __iommu_copy_struct_from_user(
  *                     Upon failure, ERR_PTR must be returned.
  * @domain_alloc_paging: Allocate an iommu_domain that can be used for
  *                       UNMANAGED, DMA, and DMA_FQ domain types.
+ * @domain_alloc_sva: Allocate an iommu_domain for Shared Virtual Addressing.
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
@@ -490,6 +491,8 @@ struct iommu_ops {
 		struct device *dev, u32 flags, struct iommu_domain *parent,
 		const struct iommu_user_data *user_data);
 	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
+	struct iommu_domain *(*domain_alloc_sva)(struct device *dev,
+						 struct mm_struct *mm);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
-- 
2.31.1

