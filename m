Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7D81EB48B
	for <iommu@lists.linux.dev>; Thu,  1 Aug 2024 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523561; cv=fail; b=UenK4t19dXMxCC4kS63FuoFplkfwP88M0TXWV2xh+9C8kd9JGqTBDFtRcKrL47Kf4pDXn9cKztv7kb+HNdTGV5SM9Qg93vsPh/idnryjVgMW51tE2/rUeXiHn1YXFT/00c+tDWw+sMS3kBD2gNk3BuiGi04dRW8sBfmj7voI8Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523561; c=relaxed/simple;
	bh=KPIEYnupfZ+PRARg/dzZ/ZSYqsRoVoXk333A6/DLkqY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z3aCO9fc9/f+VCsy4pMt3z7nqz3kte6jrfBWSeBv8m3xjZ+UQlrxc1IpQu2L7PD3QXtUYl81MjujVcUwqiuW90/bqqAGqKfE1DS/LfpW3mvv9MqsZspFC2D5CS2Iwq9cIdCfeEmotggYWT7AWhyTB3bQIK+uyAx0HWbJrpshjJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JIG//eNy; arc=fail smtp.client-ip=40.107.95.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JIG//eNy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s23fXge3xMpz8+gk6SY6IBs1ADfAHMhCx6+jYREUMHTp2Isgj6qBT+55aBnqBkCBKp3KhU3O9F/2b9o19qN7OkYYbRe5uNYVzxrajUUgLybTUtNBoTn3GqRUbHD+lwoyS9kCvx2HeACixIWo4Y8azKDi60yLSXUJGD1bjykryboD6I0I7IVFOL7T2tvVAuV69O46KAUyjnH1JU5RFu6KXVP19Qh2j5su6yOfYtZ+Wd3HAFLYssxB7akvodKOWN+/A7Ng6ne1noYOAXJz5Z7CZRcx9q+1TpOzyAF1b5vlgxpbjdxpGhy22xhJQDot92Y/6skseSY5ZHAcUoR9UlaGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZUqQRHMtrvvNzj3z5AE2AHlth849dbYLR90ldcW9ao=;
 b=leW6jc/BRELr7ti1cXGRUnNB0EPCjNIAedg++g7nhMiiBMxlXVbYq45VHv8V0zK1cbt/Yb2ZNTzi9qBL50QlVfGiZqktw2Na5Fb+3MdTHzRmhpmdkXHVGsNOF9Nr2tPCb6kmHGP58n8k6qy/GjPhYSv86nmANwUzKeq/ZfeCQBXbkdxeaUZA+ghsROQEQHVyKBbpN9Hz3opOCQ2CGjioyKui32PLjs60+brddESuOgiNHCSz5sq6zegpKcDo9xLlkP14Bwn/O0Lk2zGkTQtLm7LApimNesoaLxjXrhCCCgA9IqgIYzagBdNIw7gSTIS/ydL7Q6eIdUq/67pJ6MdJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZUqQRHMtrvvNzj3z5AE2AHlth849dbYLR90ldcW9ao=;
 b=JIG//eNyUhuLG2qOX5/84sBJLcucWOFpq2ZYVCHqWGwHBlkOq2fEf9/Ax6F1FvUAre7A+C8IcLQZ6Gs9y4qu47MI9x15+qxu3YuZIKypVl1oD22wXQJVXH9r+84F8WDK2UrXK0VbxuTt9S4DPSWWgSi9iQRJDBnMP1ovp7s2O7c=
Received: from MN2PR14CA0026.namprd14.prod.outlook.com (2603:10b6:208:23e::31)
 by PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.23; Thu, 1 Aug
 2024 14:45:54 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:23e:cafe::be) by MN2PR14CA0026.outlook.office365.com
 (2603:10b6:208:23e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Thu, 1 Aug 2024 14:45:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 14:45:54 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 09:45:51 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>
CC: <suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>,
	<baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH RFCv2] iommu: Add domain type and flag to domain_alloc_paging()
Date: Thu, 1 Aug 2024 14:45:23 +0000
Message-ID: <20240801144523.11803-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: c3dc90ba-d4fb-4fd5-1647-08dcb238a59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aZMB6mhPPatmc3btDE0r4OlFHpvxjJxm5sTLp7FWy5Nj30lyfW22GviN9UN0?=
 =?us-ascii?Q?RsVVFvxO/NuEs7hJ4QQG7lk7/ue7efgzNnWc7PIs0yqWZ5Q9xtMRMgevgJ6g?=
 =?us-ascii?Q?7TXx4VrW/YS3fshe9+otEokNHfl/u0RzOwII5SFPBBRj4Z2vsjCqwqMwFYzu?=
 =?us-ascii?Q?gTaIp9lXNMDiGLApIti2/nI35M1LQ4YApSYmgtY9Z9n5DhvjJsw0etUuozD3?=
 =?us-ascii?Q?wLG4CwP42S5ZSDs2p4p7JU0f7/HI21Py6iA4+AQLrwPfZl6+pXf0rdB7U1j4?=
 =?us-ascii?Q?JJs8R9vtamkVCgNNxn4fhsFA98IQr02JmJcBGDX1oAoujyy5a8ynpFIe9LcJ?=
 =?us-ascii?Q?zN6h8OVPFK+l3GwyRuC/Rl8JCkUXUspSHPmaS3JhL39I5nZXyk5iCFkj+qxS?=
 =?us-ascii?Q?Deue9acA2Rnm8j56T6BI+GV0e/TXJ2Rev8ldx2+6TcBh03TlHcVhao2s6hh2?=
 =?us-ascii?Q?MaV99lMRmh3lvHe8vLQ5/xV2+MSNLOC+OCCgzgQyZ23C2O/Su/N4ljSKTzIR?=
 =?us-ascii?Q?YaaGGQwkK4+E62OwUAZDAX7wC4RKdARIgJbBMmyEGFuDvW4r2xLEQlLMf92D?=
 =?us-ascii?Q?jSNKF76WOeEYALx3cOKOeiF5uHeMLw3uDVMFtYL8GHzzBKjojkUXGJtKOEu4?=
 =?us-ascii?Q?sSfVL5qEtK9MXMiq/Si0q1lmaDGKAf1RtUKADD7RmE3w+p7QKM6/KeUsMieK?=
 =?us-ascii?Q?UrAxCqx/H0xwnO0rwhRNhAnNHeDJrs//O7v2eMrodntHQIIOXTFie0bZ19ck?=
 =?us-ascii?Q?sevlHEIxr6ajf9KbmPZIu/mE997HQAzaIuYo+t68y05AnPTbAnhFGzyZ/ENR?=
 =?us-ascii?Q?C1eFyjUIIXtD6ScB7u0LuXY6FLi0Hlc0LAlyb+GzUtGaRaoQG43izO9ZU5E2?=
 =?us-ascii?Q?OTZrVR38QRkLrpSfgvfFsvG/JwSdDImvnXwmtk1Xdkq14GYZxf+JgsELhxkP?=
 =?us-ascii?Q?DUriWqhWT6eMPMGV+mG9yZD/J0QQxH+yrRAnWKWzQXTP2cJ1kY3rL8cgmGyO?=
 =?us-ascii?Q?xPNLzhyRCMe3Z+Q7krJq9pwGeSlT7ERY5IC4uV4FQ3s787/yygeshonlCBRu?=
 =?us-ascii?Q?YOFeDJK5iY1fJTiGvCtSu++dE86tdH6DxvkuDbzk1piN2wPd2Y3RdagAnbL9?=
 =?us-ascii?Q?AZ1ej4Ax/XVYNmPfKJGx3Jwn0NH5cNXHLQ5MuWzr2Juz74lajAneR7Wt6gBP?=
 =?us-ascii?Q?D+u7R6cQu7n39oUHpt6Q0ook/yPqHipvWN/jXvtX7yMZxzCn5rPRoPtmE9YO?=
 =?us-ascii?Q?0gpSGaou4Bidt1Wkk/scFx5OBVJyqOdZ9bBAhltghf4IWJ71Tz0vI43NlpMO?=
 =?us-ascii?Q?wk854sJ66xM/PgRd08fA2Q7EELrGDmWkQR/y6L0TDdqsx5WiNjSGB+OU+1jQ?=
 =?us-ascii?Q?/wQOm+YeFlyp62esu+yQYUDpICI82sv6/yoaZxzbzqFK2Pk6zA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 14:45:54.4769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3dc90ba-d4fb-4fd5-1647-08dcb238a59a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209

Currently domain_alloc_paging() passes device as param for domain
allocation. While this is sufficient for some HW vendor, its not
sufficent for others.

AMD IOMMU has two different page tables (v1 and v2). For DMA API mode it
wants to allocate page table based on device capability. V2 for PASID
capable device and v1 for rest of the devices. For UNMANAGED domain, it
wants to continue to enforce v1 page table as its cache efficient. Hence
include 'domain type' as parameter to domain_alloc_paging().

While at it also add 'flag' as additional parameter. So that any page
table specific quirks (like IO_PGTABLE_QUIRK_*) can be passed to vendor
driver. Once we have this we can remove ops->set_pgtable_quirks()
interface.

Note:
  Intent of this patch is to discuss/finalize the domain_alloc_paging()
  ops. Once we agree on interfaces I will fix other drivers and send proper
  patch series. That means with vendor driver config this doesn't
  compile.

@Robin,
  Once we have this patch and Baolu's series [1], we can enhance
  iommu_paging_domain_alloc() to include page table quirks and then we can
  remove ops->set_pgtable_quirks(). I hope this works for ARM driver
  (arm/arm-smmu/arm-smmu.c).

RFC v1 : https://lore.kernel.org/linux-iommu/7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com/

Thanks everyone for looking into RFC patch and giving valuable suggestions.

[1] https://lore.kernel.org/linux-iommu/20240610085555.88197-2-baolu.lu@linux.intel.com/

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 26 ++++++++++++++++++++++++++
 drivers/iommu/iommu.c     |  2 +-
 include/linux/iommu.h     |  3 ++-
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b19e8c0f48fa..240cca8bed21 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2429,6 +2429,31 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)
 	return domain;
 }
 
+static struct iommu_domain *amd_iommu_domain_alloc_paging(struct device *dev, u32 type, u32 flags)
+{
+	struct iommu_dev_data *dev_data;
+	int pgtable = amd_iommu_pgtable;
+
+	if (dev)
+		dev_data = dev_iommu_priv_get(dev);
+
+	/*
+	 * - Force V1 page table for UNMANAGED domain.
+	 * - Use V2 page table for PASID capable device except when :
+	 *   - SNP is enabled, because it prohibits DTE[Mode]=0
+	 *   - amd_iommu=pgtbl_v[1/2] kernel command line is passed
+	 */
+	if (type == IOMMU_DOMAIN_UNMANAGED) {
+		pgtable = AMD_IOMMU_V1;
+	} else if (dev && dev_is_pci(dev) && pdev_pasid_supported(dev_data) &&
+		   !amd_iommu_force_isolation && !amd_iommu_snp_en) {
+		pgtable = AMD_IOMMU_V2;
+	}
+
+	/* TODO: Pass pgtable as param */
+	return do_iommu_domain_alloc(IOMMU_DOMAIN_DMA, dev, 0);
+}
+
 static struct iommu_domain *
 amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			    struct iommu_domain *parent,
@@ -2860,6 +2885,7 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
+	.domain_alloc_paging = amd_iommu_domain_alloc_paging,
 	.domain_alloc_user = amd_iommu_domain_alloc_user,
 	.domain_alloc_sva = amd_iommu_domain_alloc_sva,
 	.probe_device = amd_iommu_probe_device,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ed6c5cb60c5a..d8a67b39a4cb 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1946,7 +1946,7 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 	else if (alloc_type == IOMMU_DOMAIN_BLOCKED && ops->blocked_domain)
 		return ops->blocked_domain;
 	else if (type & __IOMMU_DOMAIN_PAGING && ops->domain_alloc_paging)
-		domain = ops->domain_alloc_paging(dev);
+		domain = ops->domain_alloc_paging(dev, type, 0);
 	else if (ops->domain_alloc)
 		domain = ops->domain_alloc(alloc_type);
 	else
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4d47f2c33311..72383f6bdd9f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -565,7 +565,8 @@ struct iommu_ops {
 	struct iommu_domain *(*domain_alloc_user)(
 		struct device *dev, u32 flags, struct iommu_domain *parent,
 		const struct iommu_user_data *user_data);
-	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
+	struct iommu_domain *(*domain_alloc_paging)(struct device *dev,
+						    u32 iommu_domain_type, u32 flags);
 	struct iommu_domain *(*domain_alloc_sva)(struct device *dev,
 						 struct mm_struct *mm);
 
-- 
2.31.1

