Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDE92C1B1
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478549; cv=fail; b=V+lau4+qSQaNXxDzgB8vAMd2bc2QH9aDAgiPxT+sNyUlP4QzR4aP1vBAnpamTwm4VyA6FCprCod2VbFDz0tl0yMqOtB4uXftoDfw9Spclgru6B9A6Hsh88Q8bnILKNjMpuLRQo9DqCnRXQavlV3Gwwq4hb54hEKuffGoa+wZ8+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478549; c=relaxed/simple;
	bh=FuvSC03OHauXvRQkcgQ3UrE8dYuUOTlm8SexRGhANGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+GkJa2gsn1DECablRLlYM0OUNGGr5gM8/b1dgTIxjnjNGzwGPql5DgMG8kmKeHeKk4wM3wNzzYeIYgTWr7eU3XOoPzLP91Xc28yidQHnSyllq3XEfVfS187anrxY0YoQIFoAwLmLf//Z4yS1XAN/t81Na7ofwcDDbWSxdKymgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cc1LrM/M; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cc1LrM/M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtaM/c73msGRFKX75uwxVukq1m4XgWTzMBru8z+UCxkk7O3Y9k+dPohTZo2lr5FJIyuQTgVEh90Aiw85plGNIenbky/vcjgJBhCgM14B1tCxtNJMlTewIdx2PsRSFiIJ3uf2CYcfpGGidJvc2AoGi4hnFw0gjAfFPk+zzaADU7zRr3I/DHbHBvX7KxEESnLRpmYB7f6aNE4hfxC1ljE8sA0eh2ceE7/w82ckcl1FYUnV98k7xqsqvC7fKwid3fJenzNeuQLtQHzEKO2Ky8/k/qCupaG8hThpfI1Yz11b9tZo9rKm04kPDATXfOmpz+Nnjqo/DWNRXuOhJ/qup/kODw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oc3JABOD6j+DXNx37M0cbHJPrzGq003Ud7gGEhWnLeI=;
 b=IN3P8ytxYzU0+9NX+JvJxev3ZnMtdKzrroS7pWrfqWEEVjQ49t36KccmzDfihzhWT5DhWCbTbJsr92uylAhIQpvnmURIY0dOf19wXRYnt14o2g3lDWmSXAy7UWRfLpTWZdlmK5Qu1b/i652x6tVMdYy3t3BfGrDrn4keYfdSwxIYt1vH9rHlon/CO9TPqGrpOJLC6voSU30nRUByA9kHSz3Ib4vDEEEFY3mAueGKHZ6X/OeQxmksobt0/pKcQiFL03OtziUbYRx+ukhLswErYhPpGVDs9WeHZL7qV39eX/rfUtSxtSRuAQLREpXJEDCSYox6au9UvTwjXAs2A1f8cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oc3JABOD6j+DXNx37M0cbHJPrzGq003Ud7gGEhWnLeI=;
 b=cc1LrM/MiBlJTToN1g3oiNJD3sY8foP2gWpXPCnl75SL7/wvMf2YBViby5PANiDM+KjH40n+9M1w6njAcc4z6W59mu89p18MBtZj1jE1BbWP5aSqOmgw9WuAA7scXV9Kj9vZhv1abFM+2gUgul/53jk0m74oF7n37YIdNIzkt/Y=
Received: from CH2PR14CA0028.namprd14.prod.outlook.com (2603:10b6:610:60::38)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Fri, 9 Feb
 2024 11:35:43 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::56) by CH2PR14CA0028.outlook.office365.com
 (2603:10b6:610:60::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Fri, 9 Feb 2024 11:35:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 11:35:43 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 05:35:17 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Jason Gunthorpe <jgg@nvidia.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v6 14/15] iommu: Add ops->domain_alloc_sva()
Date: Fri, 9 Feb 2024 11:29:29 +0000
Message-ID: <20240209112930.63663-15-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209112930.63663-1-vasant.hegde@amd.com>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: d3ceb137-112c-45bf-a8f7-08dc29634057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pJsx+C5Yll3vH3+RdOP6mbjPR68FJVPBeBO9lby/KnWR59RMWasaycKy42m541Z26hbxBJxxboDVmYRepU3EAn3BER728tj0XiZ3zsH5EQXVn1jgUACsTJfjEafyQSQWtPsw+Cos8SviTdtW8ghyTQPAWBxAV2pgn83xoi3h/Y7kJDB9cLV+s//GBpSL3F/Py30qZ4S7WXvih4iCaL/DPk/Z6zyCejiBaCpCjdsPoRWJahqZLEu0uQJxDzvKKgjMIBcPPj24aBo0l2lIWjLoo5v+8uwDG90Dx1ldN6nz5ez0dYmOY+gpTD9seSZEpovQ4fAn46TTD3ekrarhfY23/ssE7cBbnhic351MOayZw0hrPABTOGoPHoWCKE8qO3Sf65ASHP0HQSCeYMKE9LRTmA7XLk8IuhjT1y83Zf0HkSyu1aVFEL0F9VRtkquhm6AVKjEVc5W49lws2m1ealOA+X+TEYCosKYswZdL744RzidvntsbDExaWFiFJbyNSxjL1edhl53qd0Sm+NJUZ+z+i+rMPTYNDKCkSjE0v3xeyMdG7ArueYtml7wpDYxCS/JIWfudR43Q/uxDoELWPG7da+HRnQYcgVGE6HrK9k2+w9Q=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(36756003)(2616005)(82740400003)(426003)(336012)(1076003)(26005)(16526019)(81166007)(86362001)(356005)(4326008)(83380400001)(41300700001)(7696005)(70206006)(44832011)(478600001)(110136005)(5660300002)(316002)(8936002)(70586007)(54906003)(8676002)(2906002)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 11:35:43.7130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ceb137-112c-45bf-a8f7-08dc29634057
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176

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
[Removed smmu3 related changes - Vasant]
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/iommu-sva.c | 16 +++++++++++-----
 include/linux/iommu.h     |  3 +++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index b51995b4fe90..c2e3a083ea43 100644
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
 
@@ -266,9 +266,15 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
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
 	mmgrab(mm);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index de839fd01bb8..d76ffd4701c9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -518,6 +518,7 @@ static inline int __iommu_copy_struct_from_user_array(
  *                     Upon failure, ERR_PTR must be returned.
  * @domain_alloc_paging: Allocate an iommu_domain that can be used for
  *                       UNMANAGED, DMA, and DMA_FQ domain types.
+ * @domain_alloc_sva: Allocate an iommu_domain for Shared Virtual Addressing.
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
@@ -558,6 +559,8 @@ struct iommu_ops {
 		struct device *dev, u32 flags, struct iommu_domain *parent,
 		const struct iommu_user_data *user_data);
 	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
+	struct iommu_domain *(*domain_alloc_sva)(struct device *dev,
+						 struct mm_struct *mm);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
-- 
2.31.1

