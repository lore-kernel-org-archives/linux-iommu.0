Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2E3FB36
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CuW3sSfx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvM5nHC+kuoGXvGpgwHQTza+KVRvdMkXhvuAzI6W6SZAqC2Loan+aTDiqbWEBt0F14RGmDFJ1N0Nehd6NEt/UjYPjGI0Mx+T4eqYIWV+UMgdpoTCzzMqSefmDRIU6AaeLyd7XfjgPVedeLprvlMoeuU5LeiuXMae7GHresjVmsgmTqf6BQ/BPGG2Ehrslzd0CajKf/bAQa974mkSpGauSI+q9PC/k+9qWmgVhDDX+oGoGKh/jZFhfzhKwnrvxVw1x1wO1BmxvVbK+pymqLnHsv8HNxl5sUns+ZVSp4fF264BvQyCZ4fqhv1mAIiFHnDFor4Bc4p0XW0SDLfNt13ALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHv7gIR+3eM/0/oDvChRMTjzFnDrzu5BM2X6taenbhk=;
 b=YwsUGCRWesstH/EEY/ZXcmfxeaa/nORi21Jn0G8zt8waKl/a0rjudwwGjEEn+WUAlB0arAM1bInyhafKQtuAjbxQsDiSUVUwbdt4eqlBjO961vowguMOvVB50gyAJdxEQcDLXo5oB6tyEZsl8DR4lTpVDghooFNLFMkwnbajJxsSdS+Iy1qVd9mHBc4h55aLvzIzxJ418GS3Xgd8FbrWQUV1UA6+r19lDz6rBVy0j7c/SqAHJlRXrCa+KQf3qaoMhUR7Jp+CZ8Ad30M4y4vsJo/b4bc6wUbYair8E8gEg45c6BcDTJZeM7Nw0xklHnV66HMZaWIjX/3kfDtpT7/29A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHv7gIR+3eM/0/oDvChRMTjzFnDrzu5BM2X6taenbhk=;
 b=CuW3sSfxplElktjpE39eSlA/B3L/IdoazUrkT1u87yxTjbqqCcZ+pIRdKkPVLhAERlSNiNRFLlg34lyvndxblr3yBdRf8Nl5QLvKQOpfccgIq+80YhOPLOJIHl/U2tgai96MSYcdyO/iEHulHhgQrmH7m+udifGow1On3hzGKEVBHqbCxlt93ChHdP1NVZTfZm2yUa3o8bPSC5VZ/kC/wF8MnaXq+Q7R8UgrZCo4bDXdOVIymIvV/XW2zHCOyn5sPdgAx+hc8tnnYDspH/qeHvuVQIL03N5s7dUufbVeft6r8rJpqIeRcEvY0FyRhAtMLpgp0paKH9ptYr7/KN2h7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Wed, 11 Oct
 2023 23:26:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:13 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 20/27] iommu: Add ops->domain_alloc_sva()
Date: Wed, 11 Oct 2023 20:25:56 -0300
Message-ID: <20-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0283.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2a5192-7f9e-4746-5c64-08dbcab170f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fdo8gtcn7WGyznN9urtGyvUTWDKyrqdd2qQQ0jKdCqSiwDo9VfGjw9Z/YrPQgTubl+eqhi34smYwH9paTCWo8/oB5D6P78P83C6vUrNcJDpNyJFmGmfegHktxrUc7QjpPwGUb2J0Ei1tUliyYdfsb05KCSCSqMUqMUEdaiuj1JYhZDuO1YHUqiiWHLuv8rv7RztOdO7QELvJ7uL8KKFZz5UKBShW5BzVJADmz5mIMydDV8HbKGX0Pn65dQLZe4JHwJI2COgl7HEcfVaO/ePaAVtnamyvZ60iXCBFeeovGJAQMB/uFd2eOQJh6gw5Bgp2RZqxk9qqg/+Vw1e/xr8Td2zPCMtPlKB1JAPwdAtUhFm2PuzM3TaSiMbm3Fbiho3uJaeCSGdW4ghi0aRgNv9NT7LuvNekMaLzMx8ttsO0CQsl5/cdnn6RQBsZCAT4e5xYNKYQxXG4zZuecT4Mp97AYl095VI59FmC2PTb3DrioNa9OdzRBmL8oJPXcuulbZ4n8/KelBXlzGF3HnOQ7g6LDkecJ23h4BtU6IqWy89F2gj0Wau4FkV+K7V9KoZGYzAC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(36756003)(6512007)(6506007)(8676002)(2616005)(83380400001)(26005)(107886003)(6486002)(6666004)(478600001)(38100700002)(4326008)(86362001)(41300700001)(66556008)(8936002)(316002)(2906002)(66476007)(110136005)(66946007)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lurZOhSHPVrpcoqMG7rUPtbRXnA3oLjixgJzoE2h7gRF/Vhar3F0uKdgFZ4d?=
 =?us-ascii?Q?VpJQrgpK4QZvCd+40NlHWa510Ptmem2E+GNDQ8F15d0bM+LPskFuh6ar1ut0?=
 =?us-ascii?Q?Oqai1BGSFFirJ/BrCxMMvfdd4ngKvH7oRPSaxJTLz/Tr06wByukt4qBrfn2K?=
 =?us-ascii?Q?yaDHzesQx7OYQYwbOmxfERLXQ7PZ16StEbohsytMbGceho6OeF0IquS7rQOz?=
 =?us-ascii?Q?2w3gvthD0QVoU2o+ykSPYslbJZDta3G0VBB/X+oMC8fsOoGYuFFuD9kr6LMd?=
 =?us-ascii?Q?KpyTH4oIwXM73ZPbaMwB6W+ELCEw+uqsqOqr5Fgl6z+ozcCOToy1mL/dQQ19?=
 =?us-ascii?Q?GhrVeWfLGDgFmB1NKtuP7hMgOptlYJNNx4xOAYU4YXeRzMEVVAJBTXMuvoj6?=
 =?us-ascii?Q?SPy6Ml6D1VqtyPqVc2xjQ04+nBAgqSwKiGrKCDIHzOwHQBrVQN0o5sWERWEP?=
 =?us-ascii?Q?JHwIWbQr7NmLxdv8p/8fQfmry/qCv3EVy0C/LRpP5CLLCgeefboklrffI7n5?=
 =?us-ascii?Q?LhAVQ2Add3QpTR7DDlDqZjyxAGMHvIfrH/HJdyF3J+ScbLCX/6r9+24SmFvv?=
 =?us-ascii?Q?yJOWoFj+gNDqXwmSMid2vvDG2/vIJDINc946XmTfXQnwJwcWDdwh/e4bQVUX?=
 =?us-ascii?Q?ev3GXA8NIjM7jioxUFhYXIrvWF1vCZ2D5Q+EBfF+TbTE5DKpz7W9nMGdca1W?=
 =?us-ascii?Q?WLqBeCpDaYlx0kRNdVjVwcU3oSboEFQCAA9iKRZfy6Tf9ZpYPDtB6G9LgIMf?=
 =?us-ascii?Q?JsULDjnysP+RXpqjtlHBC6D/zLhtogTiq/iryyG0xvz0P7xT49+58lexKPP+?=
 =?us-ascii?Q?05CjZOd7BkMBJuTce0eoAk3v7npzvrPvA7RpLhRtLBtzWVmg/OJ5qKPtIWaY?=
 =?us-ascii?Q?peeCGfRO6zjYDcyd5k2rjdrcJMuvCdrZLGly3P6UZiGvNaFu8tvFEhr94OH5?=
 =?us-ascii?Q?1lHLGymHYYR7/7SpBzkamDWiZZuGAUs/f8dt9a4jbjZ7QoStmgyn3OCXuGII?=
 =?us-ascii?Q?Lq/bun2CeIJt4DQR3WTGFJu9hnvceTWIJiaqHOIokOZIerL6z8dPwsHwKVI+?=
 =?us-ascii?Q?HcJ2VMxZETXTNZo1lOYVav0Ls+jiVjqcGX3fT+n3+QwWr6OE0t5E8qpKyNT/?=
 =?us-ascii?Q?6V2ioXepewxz5+3lIPu2sfm8E8lzXV6i0q5T2HmspPYgo210ag5LtuQkBK71?=
 =?us-ascii?Q?jm+q97Hl4nh8SjVkwNF0ThjkolOyry4cg+QVpajaajAQtLKFnDZoVwfhreE1?=
 =?us-ascii?Q?KmSBhiSWaTPSp5KSZvDCBpE9awRTiBE9Etu3gI1ec19yWaO7cs5c6/KuOY3l?=
 =?us-ascii?Q?JZ9fguoZ+b1BARDL+hMHTOv5dCi3kLvDpn+/r2XCMZP/WLjcr+Yi+P7aJZha?=
 =?us-ascii?Q?rYfibHUaTMTSegpNmyW+YeSA6IUiz2Xapjq6sBG5YqGfm8Mbn3mLUZaKLx0K?=
 =?us-ascii?Q?J9NUEOMjg/u5qAAr41VGkfITcO/0k+UCysqwjek4iBKxgUXK2EQyiP8dj06C?=
 =?us-ascii?Q?vS/UO7oZarbHzix8UEBpQ+oLVeJ+H3zsVzsBvwWLf5wBKe4DPIpc1UIFirRh?=
 =?us-ascii?Q?7AvCMdoBFdRAZW5Qw1o5DhlhBZiHcPTzwndFsFT6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2a5192-7f9e-4746-5c64-08dbcab170f0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:05.6729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tY9a1VFzprEgNHjw+Sg9uhmdlcQybqvPjBhpqNDgfld6pA9EBQgrApTCoP6u1nbo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380

Make a new op that receives the device and the mm_struct that the SVA
domain should be created for. Unlike domain_alloc_paging() the dev
argument is never NULL here.

This allows drivers to fully initialize the SVA domain and allocate the
mmu_notifier during allocation. It allows the notifier lifetime to follow
the lifetime of the iommu_domain.

Since we have only one call site, upgrade the new op to return ERR_PTR
instead of NULL.

Change SMMUv3 to use the new op.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 13 ++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     |  6 +++++-
 drivers/iommu/iommu-sva.c                       |  4 ++--
 drivers/iommu/iommu.c                           | 12 +++++++++---
 include/linux/iommu.h                           |  3 +++
 6 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index bc3cc51dffc2e7..3a9a83febec6ca 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -661,7 +661,7 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 
 static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
 {
-	kfree(domain);
+	kfree(to_smmu_domain(domain));
 }
 
 static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
@@ -669,13 +669,20 @@ static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
 	.free			= arm_smmu_sva_domain_free
 };
 
-struct iommu_domain *arm_smmu_sva_domain_alloc(unsigned type)
+struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
+					       struct mm_struct *mm)
 {
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_domain *smmu_domain;
 
 	smmu_domain = arm_smmu_domain_alloc();
 	if (!smmu_domain)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
+
+	smmu_domain->domain.type = IOMMU_DOMAIN_SVA;
+	smmu_domain->domain.ops = &arm_smmu_sva_domain_ops;
+	smmu_domain->smmu = smmu;
 
 	return &smmu_domain->domain;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 540666986a0a39..a249421a83a4fd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3227,8 +3227,8 @@ static struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
 	.blocked_domain		= &arm_smmu_blocked_domain,
 	.capable		= arm_smmu_capable,
-	.domain_alloc		= arm_smmu_sva_domain_alloc,
 	.domain_alloc_paging    = arm_smmu_domain_alloc_paging,
+	.domain_alloc_sva       = arm_smmu_sva_domain_alloc,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1f6d528d949fff..4d23aec227d492 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -808,7 +808,8 @@ int arm_smmu_master_enable_sva(struct arm_smmu_master *master);
 int arm_smmu_master_disable_sva(struct arm_smmu_master *master);
 bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master);
 void arm_smmu_sva_notifier_synchronize(void);
-struct iommu_domain *arm_smmu_sva_domain_alloc(unsigned int type);
+struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
+					       struct mm_struct *mm);
 void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 				   struct device *dev, ioasid_t id);
 #else /* CONFIG_ARM_SMMU_V3_SVA */
@@ -854,5 +855,8 @@ static inline void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 						 ioasid_t id)
 {
 }
+
+#define arm_smmu_sva_domain_alloc NULL
+
 #endif /* CONFIG_ARM_SMMU_V3_SVA */
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index b78671a8a9143f..a52b206793b420 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -87,8 +87,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 
 	/* Allocate a new domain and set it on device pasid. */
 	domain = iommu_sva_domain_alloc(dev, mm);
-	if (!domain) {
-		ret = -ENOMEM;
+	if (IS_ERR(domain)) {
+		ret = PTR_ERR(domain);
 		goto out_unlock;
 	}
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 89db35e2c21771..a048f30ca7c260 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3536,9 +3536,15 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
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
index e1a4c2c2c34d42..6cfe863aa72925 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -241,6 +241,7 @@ struct iommu_iotlb_gather {
  * @domain_alloc: allocate iommu domain
  * @domain_alloc_paging: Allocate an iommu_domain that can be used for
  *                       UNMANAGED, DMA, and DMA_FQ domain types.
+ * @domain_alloc_sva: Allocate an iommu_domain for Shared Virtual Addressing.
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
@@ -278,6 +279,8 @@ struct iommu_ops {
 	/* Domain allocation and freeing by the iommu driver */
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
 	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
+	struct iommu_domain *(*domain_alloc_sva)(struct device *dev,
+						 struct mm_struct *mm);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
-- 
2.42.0

