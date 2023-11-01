Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230D1C6B9
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BI+XTBOL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcrAXaVNAgeL0QexnizWJriklwyBRWPRH8au+wT2PB3H7hrxnyBzZOuuLkiCLDUok0UlGMLugjQQwBJU+iUakAGD0PXTFwKAaXCkEMursznuImp2gOppZukuYPhzBK2dfeNACoXH4W0bV68zFrZMp7GxGRXtKuuf4vK704TMjavL5XRnHwlXm5g5W/Pho7zbSMcNcSKulctRSLivdvhY8KM+hWz+cvl4St3ZcrC5dwo+EHYS3VzDKDks7D11CRlgn7l6737P/u6e5wHzN5UHbqvaRBewqP3tQLj+mSZ0AWTp+irm/wd40cYIL5K0vHZZdZIlmWVh8dGnFGVy16N8jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHXnVeR7Hy04BXg+n8vuj9zFFEzEDyMuDosBTlpCPWo=;
 b=C+1hL6YqtZ63k1nM1w3sj8SK7Z0AhDbZ0xiUnPYgK0cU1uHmNQtNfo86dpfhGPg/DxyzeRAqnVY1a3X80sRpzx4cndf7jMle3G/OR9d8oi2DU2km/E5NSdEZp0bvPUFl54EL4JInTs034DJxNCz8gNkzWI2/OfP67dDSuFEblZiTX/d7kHrD0EJWSS8IHhG2CUBS4MgBqKn2HeyUqSgOUJC+gflbdKkKWIYXdGZOhmD3RprUrV0iJ0DPFLLvI0fDMHAcFXZxenQ8Eq3hDFuIYN9Vz5qCt2by/8ybC8RQjM9oy3y5Py/5AqNX4UFXmgoxS5PlKvhq939Dgw2Lc3Jqbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHXnVeR7Hy04BXg+n8vuj9zFFEzEDyMuDosBTlpCPWo=;
 b=BI+XTBOLNoDXL4uwse7DiS8bYtEEwYpnbTix/C6elVRZjvUoKqTauiyO3Hxn+PFkju0vmXA/lz0UHA1/K1Al78lZbdzDzqpYO6SGPuogo7pMhlV2a0i25feP/6AP+4dPFsQaZMz2huZ1PaAW4PKX861dxdk1raMBItQcYp6AzTaPSTAtpeE6l3T0La8rW4PJN+GT+yGmf/TM7kISTx0SDfthVgshuV9DanoOjegDQ5rWMtI8gBbXTQG0SIqC3jx9Qs/pE+mMg5P+ddHxyQlkvdUnn2rx5JlqIxAG+VMJc0z6F+5rN5oA+JgmYiZaRHe5IXmT72rR2Or+TkwxBK79TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Wed, 1 Nov
 2023 23:36:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:51 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 20/27] iommu: Add ops->domain_alloc_sva()
Date: Wed,  1 Nov 2023 20:36:38 -0300
Message-ID: <20-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:208:160::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: e63f6c56-7ff4-4bb9-2910-08dbdb336a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8ddvqcmtjtB7EBOlDNVvApM+KsBcQPE4TkpaVj0Hfe+XB4kwjDvM2Fxvnl8sfFdWCiQ6y5CPUoli9fOm+SHVvINbjCM0gMBP9ai1maFDx+7ET0bUG5e2JpSH/nSQhLORxDBugmJLwK61HdLPNoSz0sXTXupSepcDUu0D4n3RZ7iZVYTX1NsXb2F6pxyWwLy19BvdfZfplfJy+pjrSbmrjeWA06CF5KEhL+BQNGd7Pzh/rKzl71BbeF9kNUGUR2Cvj8nOpfZxfWP5ca70BEkvPrCob9CQphkOu8cKVGIMK1K3G75H//JI7pw8pKe/HPPzTD2V2CisL/twXpeS8KEslMlbuYCfT//PmLvGBd4e+0EuLQdFYCIEBBQbZ3ZkCKwyiZ7BrtaD7HWydEW2dPeAmqXwo/K96BiyV6VFVyWmbbhlGoPJ4i6Ac0YSQ+glomIHku9fitMGdHdZP7yIrNR0w4+DB41SMKbvajPnwcfEdip57THbmvK2aZrvu1cBPqPum9CkAXQowKiQugAVbG6B3sfiT6GioUtanQ9Z0ctU8NVMiIbTBSxNAfhfqJAw8J1J
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(2906002)(478600001)(36756003)(54906003)(66476007)(86362001)(110136005)(66556008)(66946007)(5660300002)(41300700001)(26005)(107886003)(2616005)(38100700002)(83380400001)(8936002)(8676002)(4326008)(6506007)(316002)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZJ6y4+uYKbsIzquKHME2ER2G3iie6nZuFNQTG3E6YIhnQArYdeyIggHdUic5?=
 =?us-ascii?Q?wegAwKaYKN2+4fNOPukasef22XsUnVBg17xVbwKrO6QTBYTFZtw7kOAQmaQC?=
 =?us-ascii?Q?4I2rhFzY6XOTE5RQlmZAn2b8fhdB6jDq+wRysxYx82Rr3foM6yzx4mp9UBqm?=
 =?us-ascii?Q?XwwMN8bbY5wDcJ+c/BlhOHTDrFhuR+t0Gpy+wA1r5XxhLqLfKgIeTdGf8kN9?=
 =?us-ascii?Q?MwWIdpsdDgwXMQ3ENNGXDe5JBMt/QZivWd5JBMblLXRgXO+hzmRENqhvC7gh?=
 =?us-ascii?Q?30yYXAqPNSPwiN+4PJP41nI80XaBW8wj2q46cPBsarL2jlU62XNPUIb4rVzp?=
 =?us-ascii?Q?CpO4dK9N6P8wkk3EpMdR2s+bWobJE2f922Hu5nTvEmWSoWIrl4AFt1VGiO3B?=
 =?us-ascii?Q?X2O+zdD+1R8563z8SKE4CBJv4uKe2mrV1Ihsy00gLyy+CZQP6sbiyXONm9dQ?=
 =?us-ascii?Q?hAYAdtyyC3hZUOTGR3qxRjKSNFd+9VYh1Zo9gwA8pmsgwNCT6n53xEfPnA4R?=
 =?us-ascii?Q?IX0DwMyJl0YgMyeyMx9ydSftS4+JOjpQZaSNOryTw+VW59XsW7MpBnaEY4HV?=
 =?us-ascii?Q?ZM7q+Pw+LnXGyrpUW3K6+jkQzzyOn3XBoHqTu1fvfXs2jkWfbx5NcfXvCszb?=
 =?us-ascii?Q?ISVXvgsTVv7GixN/WKA0ubDYoiRCF3HbyLOEZVUgDHnoOeJWE9vWxMBmOVCV?=
 =?us-ascii?Q?t9KvXLIVxGUZx4aBIaAtXOgtzv748Rfo+vrJqSEdPrC0QmSVb3qu8f67DUmZ?=
 =?us-ascii?Q?KwRDjUCW6uux3PqfaUMlpDgqNPbemEG5t/HiEbKQyKfH9ctBfv2lwmHggDHN?=
 =?us-ascii?Q?Tvo+DL1IhNK/ojoG6V16Pwc/ZWkhXteFdH4VnSwz6P63/BghZwS20MedPhtp?=
 =?us-ascii?Q?diYcHBUR9Buh6yatHoam5t3GcytgYTR6laRt+hKRKfnKqhKMt+YQV/fm/ON+?=
 =?us-ascii?Q?pex9AyyuzNWPSXW1rlypKIBETbBIMXwJ+P0cpeKzDRB4jP3oWI+LeppcL8k0?=
 =?us-ascii?Q?9jE9JvLHLicMlJDScol6fIk6iSqeM4yqUjmtcsYV9/rHVvV0guGvqfpMjL7Q?=
 =?us-ascii?Q?on8gMiDuYdp4EZauwKjwtn0OoY/Ez87qLHpN9ATQ8x4XeOiIMqo2LdLI5jqI?=
 =?us-ascii?Q?w5KulIOgvaSoG65kauYHZtBCtfpa32t5nqjon5eUzSh749Ll5Uun/ODlncux?=
 =?us-ascii?Q?8dhtF6OqNntX/Ktrxbj85iS0reIRPFwv6xeaHdUTd2AnkPaRgoaODamjw6DK?=
 =?us-ascii?Q?KWruBm+J7iQbe6lzflnPXKMT9xivoRXC6S8x6IS05b0CDPc8fFPSxMmYSxdS?=
 =?us-ascii?Q?jfzz1p0V+M802U1Zq4WLn6TF9x1hw9YerXcB82TsTnhcoVv3j6ME88WKAO0n?=
 =?us-ascii?Q?seKB7/B+YhUmISMuHKDTCi9ql/ZLio8cxBRlA7gPh21U2gjsSyKlTEcV/KZP?=
 =?us-ascii?Q?JYF1BXhEWdqhPywULC5/2L3UnoKHTaAUS63Jl0NqTLUzus61/yMjcrmQnu08?=
 =?us-ascii?Q?pceAxnY6hUoMLjkHfTNHm5Wvg/817PZOwuiwZAMdY1H3JBRt1bmJze9UGG9j?=
 =?us-ascii?Q?DGenh46ZRCR74fJOKgpBaFV6f3TCZANBxwLrfM7k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63f6c56-7ff4-4bb9-2910-08dbdb336a58
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:47.8427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lR02FF3+BdwtgiDCiKkTod6kcNaIOTsk18JHRNhkFjJAJ84BCWTxZ0ezP/kavc93
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 12 +++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     |  6 +++++-
 drivers/iommu/iommu-sva.c                       |  4 ++--
 drivers/iommu/iommu.c                           | 12 +++++++++---
 include/linux/iommu.h                           |  3 +++
 6 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 5894785aa901e8..991daffbee31aa 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -638,7 +638,7 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 
 static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
 {
-	kfree(domain);
+	kfree(to_smmu_domain(domain));
 }
 
 static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
@@ -646,14 +646,20 @@ static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
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
 	smmu_domain->domain.ops = &arm_smmu_sva_domain_ops;
+	smmu_domain->smmu = smmu;
 
 	return &smmu_domain->domain;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 23bcdf1630c23e..85fc3064675931 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3229,8 +3229,8 @@ static struct iommu_ops arm_smmu_ops = {
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
index c1181e456b7d5f..48871c8ee8c88c 100644
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
index f17a1113f3d6a3..899d73062f6e67 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3543,9 +3543,15 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
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
index 6925866ba247b8..87965454d7de57 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -346,6 +346,7 @@ static inline int __iommu_copy_struct_from_user(
  *                     Upon failure, ERR_PTR must be returned.
  * @domain_alloc_paging: Allocate an iommu_domain that can be used for
  *                       UNMANAGED, DMA, and DMA_FQ domain types.
+ * @domain_alloc_sva: Allocate an iommu_domain for Shared Virtual Addressing.
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
@@ -386,6 +387,8 @@ struct iommu_ops {
 		struct device *dev, u32 flags, struct iommu_domain *parent,
 		const struct iommu_user_data *user_data);
 	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
+	struct iommu_domain *(*domain_alloc_sva)(struct device *dev,
+						 struct mm_struct *mm);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
-- 
2.42.0

