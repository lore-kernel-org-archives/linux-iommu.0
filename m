Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8958917FC;
	Thu, 30 Nov 2023 01:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="USmOgGVc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iF4V2LJ8UVVOm3I0MK9SVt6I5Mo295EGcepW5XhPVfo6+dXHgozUgNXBXFVdWOgPGErstVmwJxpQ0G5tHwzsSAG5XrjDKl0PZYiSxcEub/Y34V/owEIelFe4iA4mdV5ioei/RjgvOK3mFzBj1SJItmb4HIN5ZzmVHVrvbJfkxN2YigPQn6kPBQJaUl4+ZRq0BegmMdEA4Z7gJ6JLXSD8Mjo9DcZVXKZ6k4bSiw1wYzf0G0CGtO5TK+y2w7VNY35e2I5zYDpwwMJAGdxO2Qi3STOJhbnzHwkFU1PO8uCgsGlrAzdvYHC/XX16/1ZkE4URphLww32qxK3BOFIK4tRg+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVSr9+bQP69hK+Giq+u9FoxDlVZiQRDX7oYqcWOEYLw=;
 b=fGPOY5zvAYmBuGM09M8DBMNv33RJkUZTcSIaYCDUcmOn0XwKNWHHuINpYl4RIN55dC132Zd7upSHpo+EX3Kdy4Frgi03E60lFWLKJZp4GAEaPNI64lmfXmrgdfuNcynI6U8Oz7tgVSjPqz2jCw3M/NeP3ZtSjtf0/jEV161cJCpudBo+VgfjeGBm6kzn3QxPYYQteuT2IbtFC4IfNu0HUHP2SB6gnGFFWWj5M8oxVghl0tsbBSe3qifLLNOTboKQ4m060xIKPp3QEam9JFD9+hJg+AFBzCYrov26z++bl5ujMcRyKl0+laIPUGjWOaJkOa7Kx8H/pe34ijK0LehFYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVSr9+bQP69hK+Giq+u9FoxDlVZiQRDX7oYqcWOEYLw=;
 b=USmOgGVcFzJIgouWOAhF8uG6iLD+s1B2vy8nJkLy2RmuivHJANg4VL3sku9jVFdeJJx7z/GbaLerVKg8RlYC6AM/O6pXumjzTR0v2TOTjSsQJkdXYqFYoLCDz8jJYTYNjEGBP6/rh3S9jG+96OXKZAL0LxyJdEgbqJTH6lC4l8zvq5zWlUHE3sE4yKe0W5/5dfJh6utHYtxCXuvYbnR07dLD5njWH3tDdTfiN94c+tdp0VEI7/tvhhVgHJZ6IWJmjyp2LLIRYXpS5+cYnDkTAj9jyhSVuwSM9uTwWwlo4JGL4eGY87VTbLzqQN9vjxKLnTgs85fJERUr+M94zq6kFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 01:14:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:32 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 22/30] iommu/qcom: Move to iommu_fw_alloc_per_device_ids()
Date: Wed, 29 Nov 2023 21:14:22 -0400
Message-ID: <22-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ccca84-6b13-4875-2628-08dbf141b539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yeZvjdqgZftlnRquYOD7pwx314fSEv4bbfQcSBAMhGMpnKr/7V+Sv48T88VaNByR6w3KQ/wijn1mdATU8ewT+s1iBLrBH9rGnzR3c4Kx+6MYB/qFNrmje28ilVcEBFd2b/NIad8k1pVpRXcJRUcb9ky4olYAcHXxQWM/aD67gieR5ORy/uSTGVA45FIEEZbh1C+V/y4cWwelV/q+7HedZ07SME93KwvBjIGWLg4Yg4tGYyv8Rsfv6Tqf5xyBU2/k/W475gRb9K1Omxeoee1w9gBpHU/On7J1dWF9wCc9cG9US/YmDqypP1WjpN5e4W7dlyXu8sAYiqJem1VKlUrcAJLr9xhyOXHySKdm3vlLtTIBRA5udTYqzGk5v2YCb8EAOWrjEbjmDUzdyVxz0L7oDxdqP++09LNe1ChhZbXSq7D1lgNDi9+aZO6cx4qyxeBEztji5USQWa1v6rJl0u5AQ+kZqHGiFx/mIHnmUsNQsa06TT9buRmtOkH/8rMwH2bJkEdfgmwZqQ2yU8nysJyuJvHpJdP5VjbOpnjTF0cP5+oGU3M39tIa2rA+TJxiqVYzENGjqi26rHzPAr3yeCymwysBQCPUVg6l0am52RU5NFY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(109986022)(41300700001)(2616005)(4326008)(86362001)(38100700002)(8676002)(6666004)(8936002)(5660300002)(2906002)(30864003)(26005)(6506007)(478600001)(316002)(66556008)(66946007)(66476007)(6486002)(54906003)(83380400001)(36756003)(6512007)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WTTAyqsY+fsr7ZHIQS2fd/obYZ8DKkc8SifJm1vveg4N5f28lp2cHGNGhNqq?=
 =?us-ascii?Q?H7HdpMvX0ZI7E41QBJz5Bqj7fHIXIlIAhuhtGCS49akgbEJLTg94ic81aAPc?=
 =?us-ascii?Q?HUh/0Nb6tIoSaLdusT0mO+FezMWQl9nzQRYDQS85T4Jng+6A+CkiH0N3jF+V?=
 =?us-ascii?Q?ejF17ZHvlNrxpG6Ozp6AwwDHxFcEVxuanE74ZvwEfVRWfnlOXQuzpJJpOJyB?=
 =?us-ascii?Q?MqwxWxUpBlKAeR/fboPhLUDmeUWF68z0GrO5V2KdloL0n8Bno8YTTOFQFTl4?=
 =?us-ascii?Q?1PxDQ+O1d/vWpZ7hwxwCSVL/+Xa0Ie8mr8rtXTXdr6HsNc7Ta+2+xhUlTthy?=
 =?us-ascii?Q?XmNOt/9jdRWmTfovsEBVYgQAz0rI2KiuOCPLlqm/HbapZ9/VMgxq8DErpJnA?=
 =?us-ascii?Q?A+2Vmv+gSdgJqCzCimgaFEYcHCpSyXfmJS4+4UlGyg3gIXFw1HzJWIIoUarI?=
 =?us-ascii?Q?JFV5RkzaNY/ki6Ujr1lVplY4Aw+BvEFQj1xn3xHlzxCBVuCWcgrMgxf09pZq?=
 =?us-ascii?Q?HLfw/xX5zLNhr+mZ2Ftw5uqY6KlAU0jpB38ML7OMkTXkkjaHExFv5+eN5raK?=
 =?us-ascii?Q?GoLoFLXp37GKj2Fe5M6kfmKRxm7mMW0v9szUI3Iug+hIg6trEx1VpU0weFeY?=
 =?us-ascii?Q?VD3zQusUp3Q/+/LEEGpmQkB5ZwyJXq4Ft0NTxZPxqCJHgwE5BB6DrwXhtwqI?=
 =?us-ascii?Q?CqDuZArjDkzkpcAlDsXbSqB+HemS7Nriia63iE34ZJ3rRpEXI8p0Tfemm8Yu?=
 =?us-ascii?Q?jXEQq+eGigOBEfAUXS6wzi2LU6nIzY3aSsjyip2KmtJuSh5c92jX/Zp3ZiA5?=
 =?us-ascii?Q?GQG17ARaIaqNy2Lu7ZC+DIa4DPp+S+5/vteE2Iltl5J632HhdB7exPJLBqQp?=
 =?us-ascii?Q?uEnUNUd+5AqYEJVSki2VEVoObSWe0ipKBN75DjdunnJAL8kQZboYXmT+Fo1/?=
 =?us-ascii?Q?eprVbqPrKuF3IaD6ube9soTnOjU0uLRcYY/7lVvmf0uweFjVGr6liudf4aZR?=
 =?us-ascii?Q?laV8gxQsg3cy1fR8db7ypo6CuXMDxLbKzzDVRFHWRqzpmjJr5YE8vgjmNK4a?=
 =?us-ascii?Q?dZDJhtsaSgGkNXbfRortVYkxEn8onjMWWkgA1eHl2ok1YD5Wfr1WfrcgrGwl?=
 =?us-ascii?Q?hLokC7agYqBI2gyTUBaLH2x+pcXiBFx4cl58MraqwhbZV7EtFos4pHWkFSN/?=
 =?us-ascii?Q?wFZ/7r0YpBe+Y9c9YKvxvQtMiCfuSJ+81bnqScx+rsG8My973xB+XHpqMtAY?=
 =?us-ascii?Q?kTt7OPan8rF2KzJ+IY7yBulRSI+pH4wdPfC8FmaS8XAj/VQbgNT3rt0EVN5+?=
 =?us-ascii?Q?zKrdwSdlmhgqdcD3CLHsu5Va87Bl7pJaSmxIZVvPgyEik0/e+ELQk4jkD16G?=
 =?us-ascii?Q?6WKdP+OS5YVCyil45O/Qf2HBt6IjIjNfvxMR8xOY9nrN39ppJWNeq1+5nV1L?=
 =?us-ascii?Q?WJy2MkC7xtzyndWYFqC887sEHosV2mJRf3ORVw29bQPptCMYyVPMyfxdz/XA?=
 =?us-ascii?Q?38ee9Ec5Wz51UoYKncN852PRrxrd7rFLsA0nsn24Ebe66QdEGoa7CoDsmoPg?=
 =?us-ascii?Q?mmtQKS9ZbWemo9cVcEc/2AC5GFkpv/s1PyuQAQbE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ccca84-6b13-4875-2628-08dbf141b539
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:32.0152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WiNUKz2IUlh2rRGkRHSMwCouaFuW4j5dPFxVdRyth0libpEfsLqtUj8sNf5gCvZA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627

qcom supports a single iommu instance with multiple ids.

Introduce a per-device data to store the iommu and ids list. Allocate and
initialize it with iommu_fw_alloc_per_device_ids(). Remove
qcom_iommu_of_xlate().

This already was checking that all instances are the same, it is now done
in common code.

Convert the rest of the funcs from calling dev_iommu_fwspec_get() to using
the per-device data and remove all use of fwspec. Store the per-dev data
in the qcom_iommu_domain instead of the iommu and fwspec pointers.

Convert the places using dev_iommu_priv_get() to use the per-device data
not the iommu.

Remove to_iommu().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 161 ++++++++++++------------
 1 file changed, 81 insertions(+), 80 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 33f3c870086cea..4baca45df99971 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -17,6 +17,7 @@
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/io-pgtable.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/iopoll.h>
 #include <linux/kconfig.h>
 #include <linux/init.h>
@@ -54,6 +55,12 @@ struct qcom_iommu_dev {
 	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid */
 };
 
+struct qcom_iommu_master {
+	struct qcom_iommu_dev *iommu;
+	unsigned int num_ids;
+	u32 ids[] __counted_by(num_ids);
+};
+
 struct qcom_iommu_ctx {
 	struct device		*dev;
 	void __iomem		*base;
@@ -68,8 +75,7 @@ struct qcom_iommu_domain {
 	spinlock_t		 pgtbl_lock;
 	struct mutex		 init_mutex; /* Protects iommu pointer */
 	struct iommu_domain	 domain;
-	struct qcom_iommu_dev	*iommu;
-	struct iommu_fwspec	*fwspec;
+	struct qcom_iommu_master *master;
 };
 
 static struct qcom_iommu_domain *to_qcom_iommu_domain(struct iommu_domain *dom)
@@ -81,7 +87,7 @@ static const struct iommu_ops qcom_iommu_ops;
 
 static struct qcom_iommu_ctx * to_ctx(struct qcom_iommu_domain *d, unsigned asid)
 {
-	struct qcom_iommu_dev *qcom_iommu = d->iommu;
+	struct qcom_iommu_dev *qcom_iommu = d->master->iommu;
 	if (!qcom_iommu)
 		return NULL;
 	return qcom_iommu->ctxs[asid];
@@ -114,11 +120,11 @@ iommu_readq(struct qcom_iommu_ctx *ctx, unsigned reg)
 static void qcom_iommu_tlb_sync(void *cookie)
 {
 	struct qcom_iommu_domain *qcom_domain = cookie;
-	struct iommu_fwspec *fwspec = qcom_domain->fwspec;
+	struct qcom_iommu_master *master = qcom_domain->master;
 	unsigned i;
 
-	for (i = 0; i < fwspec->num_ids; i++) {
-		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
+	for (i = 0; i < master->num_ids; i++) {
+		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, master->ids[i]);
 		unsigned int val, ret;
 
 		iommu_writel(ctx, ARM_SMMU_CB_TLBSYNC, 0);
@@ -133,11 +139,11 @@ static void qcom_iommu_tlb_sync(void *cookie)
 static void qcom_iommu_tlb_inv_context(void *cookie)
 {
 	struct qcom_iommu_domain *qcom_domain = cookie;
-	struct iommu_fwspec *fwspec = qcom_domain->fwspec;
+	struct qcom_iommu_master *master = qcom_domain->master;
 	unsigned i;
 
-	for (i = 0; i < fwspec->num_ids; i++) {
-		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
+	for (i = 0; i < master->num_ids; i++) {
+		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, master->ids[i]);
 		iommu_writel(ctx, ARM_SMMU_CB_S1_TLBIASID, ctx->asid);
 	}
 
@@ -148,13 +154,13 @@ static void qcom_iommu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 					    size_t granule, bool leaf, void *cookie)
 {
 	struct qcom_iommu_domain *qcom_domain = cookie;
-	struct iommu_fwspec *fwspec = qcom_domain->fwspec;
+	struct qcom_iommu_master *master = qcom_domain->master;
 	unsigned i, reg;
 
 	reg = leaf ? ARM_SMMU_CB_S1_TLBIVAL : ARM_SMMU_CB_S1_TLBIVA;
 
-	for (i = 0; i < fwspec->num_ids; i++) {
-		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
+	for (i = 0; i < master->num_ids; i++) {
+		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, master->ids[i]);
 		size_t s = size;
 
 		iova = (iova >> 12) << 12;
@@ -218,14 +224,14 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 				  struct device *dev)
 {
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct qcom_iommu_master *master = dev_iommu_priv_get(dev);
 	struct io_pgtable_ops *pgtbl_ops;
 	struct io_pgtable_cfg pgtbl_cfg;
 	int i, ret = 0;
 	u32 reg;
 
 	mutex_lock(&qcom_domain->init_mutex);
-	if (qcom_domain->iommu)
+	if (qcom_domain->master)
 		goto out_unlock;
 
 	pgtbl_cfg = (struct io_pgtable_cfg) {
@@ -236,8 +242,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 		.iommu_dev	= qcom_iommu->dev,
 	};
 
-	qcom_domain->iommu = qcom_iommu;
-	qcom_domain->fwspec = fwspec;
+	qcom_domain->master = master;
 
 	pgtbl_ops = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &pgtbl_cfg, qcom_domain);
 	if (!pgtbl_ops) {
@@ -251,8 +256,8 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	domain->geometry.aperture_end = (1ULL << pgtbl_cfg.ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	for (i = 0; i < fwspec->num_ids; i++) {
-		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
+	for (i = 0; i < master->num_ids; i++) {
+		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, master->ids[i]);
 
 		if (!ctx->secure_init) {
 			ret = qcom_scm_restore_sec_cfg(qcom_iommu->sec_id, ctx->asid);
@@ -316,7 +321,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	return 0;
 
 out_clear_iommu:
-	qcom_domain->iommu = NULL;
+	qcom_domain->master = NULL;
 out_unlock:
 	mutex_unlock(&qcom_domain->init_mutex);
 	return ret;
@@ -345,16 +350,16 @@ static void qcom_iommu_domain_free(struct iommu_domain *domain)
 {
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 
-	if (qcom_domain->iommu) {
+	if (qcom_domain->master) {
 		/*
 		 * NOTE: unmap can be called after client device is powered
 		 * off, for example, with GPUs or anything involving dma-buf.
 		 * So we cannot rely on the device_link.  Make sure the IOMMU
 		 * is on to avoid unclocked accesses in the TLB inv path:
 		 */
-		pm_runtime_get_sync(qcom_domain->iommu->dev);
+		pm_runtime_get_sync(qcom_domain->master->iommu->dev);
 		free_io_pgtable_ops(qcom_domain->pgtbl_ops);
-		pm_runtime_put_sync(qcom_domain->iommu->dev);
+		pm_runtime_put_sync(qcom_domain->master->iommu->dev);
 	}
 
 	kfree(qcom_domain);
@@ -362,7 +367,8 @@ static void qcom_iommu_domain_free(struct iommu_domain *domain)
 
 static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
-	struct qcom_iommu_dev *qcom_iommu = dev_iommu_priv_get(dev);
+	struct qcom_iommu_master *master = dev_iommu_priv_get(dev);
+	struct qcom_iommu_dev *qcom_iommu = master->iommu;
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 	int ret;
 
@@ -382,7 +388,7 @@ static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev
 	 * Sanity check the domain. We don't support domains across
 	 * different IOMMUs.
 	 */
-	if (qcom_domain->iommu != qcom_iommu)
+	if (qcom_domain->master->iommu != qcom_iommu)
 		return -EINVAL;
 
 	return 0;
@@ -393,20 +399,20 @@ static int qcom_iommu_identity_attach(struct iommu_domain *identity_domain,
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct qcom_iommu_domain *qcom_domain;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct qcom_iommu_dev *qcom_iommu = dev_iommu_priv_get(dev);
+	struct qcom_iommu_master *master = dev_iommu_priv_get(dev);
+	struct qcom_iommu_dev *qcom_iommu = master->iommu;
 	unsigned int i;
 
 	if (domain == identity_domain || !domain)
 		return 0;
 
 	qcom_domain = to_qcom_iommu_domain(domain);
-	if (WARN_ON(!qcom_domain->iommu))
+	if (WARN_ON(!qcom_domain->master))
 		return -EINVAL;
 
 	pm_runtime_get_sync(qcom_iommu->dev);
-	for (i = 0; i < fwspec->num_ids; i++) {
-		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
+	for (i = 0; i < master->num_ids; i++) {
+		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, master->ids[i]);
 
 		/* Disable the context bank: */
 		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
@@ -461,11 +467,11 @@ static size_t qcom_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	 * cannot rely on the device_link.  Make sure the IOMMU is on to
 	 * avoid unclocked accesses in the TLB inv path:
 	 */
-	pm_runtime_get_sync(qcom_domain->iommu->dev);
+	pm_runtime_get_sync(qcom_domain->master->iommu->dev);
 	spin_lock_irqsave(&qcom_domain->pgtbl_lock, flags);
 	ret = ops->unmap_pages(ops, iova, pgsize, pgcount, gather);
 	spin_unlock_irqrestore(&qcom_domain->pgtbl_lock, flags);
-	pm_runtime_put_sync(qcom_domain->iommu->dev);
+	pm_runtime_put_sync(qcom_domain->master->iommu->dev);
 
 	return ret;
 }
@@ -478,9 +484,9 @@ static void qcom_iommu_flush_iotlb_all(struct iommu_domain *domain)
 	if (!qcom_domain->pgtbl_ops)
 		return;
 
-	pm_runtime_get_sync(qcom_domain->iommu->dev);
+	pm_runtime_get_sync(qcom_domain->master->iommu->dev);
 	qcom_iommu_tlb_sync(pgtable->cookie);
-	pm_runtime_put_sync(qcom_domain->iommu->dev);
+	pm_runtime_put_sync(qcom_domain->master->iommu->dev);
 }
 
 static void qcom_iommu_iotlb_sync(struct iommu_domain *domain,
@@ -523,13 +529,38 @@ static bool qcom_iommu_capable(struct device *dev, enum iommu_cap cap)
 	}
 }
 
-static struct iommu_device *qcom_iommu_probe_device(struct device *dev)
+static struct iommu_device *
+qcom_iommu_probe_device(struct iommu_probe_info *pinf)
 {
-	struct qcom_iommu_dev *qcom_iommu = dev_iommu_priv_get(dev);
+	struct qcom_iommu_dev *qcom_iommu;
+	struct qcom_iommu_master *master;
+	struct device *dev = pinf->dev;
 	struct device_link *link;
+	int ret;
+	int i;
 
-	if (!qcom_iommu)
-		return ERR_PTR(-ENODEV);
+	qcom_iommu = iommu_of_get_single_iommu(pinf, &qcom_iommu_ops, 1,
+					       struct qcom_iommu_dev, iommu);
+	if (IS_ERR(qcom_iommu))
+		return ERR_CAST(qcom_iommu);
+
+	master = iommu_fw_alloc_per_device_ids(pinf, master);
+	if (IS_ERR(master))
+		return ERR_CAST(master);
+
+	for (i = 0; i != master->num_ids; i++) {
+		u32 asid = master->ids[i];
+
+		/*
+		 * Make sure the asid specified in dt is valid, so we don't have
+		 * to sanity check this elsewhere:
+		 */
+		if (WARN_ON(asid > qcom_iommu->max_asid) ||
+		    WARN_ON(qcom_iommu->ctxs[asid] == NULL)) {
+			ret = -EINVAL;
+			goto err_free;
+		}
+	}
 
 	/*
 	 * Establish the link between iommu and master, so that the
@@ -540,63 +571,33 @@ static struct iommu_device *qcom_iommu_probe_device(struct device *dev)
 	if (!link) {
 		dev_err(qcom_iommu->dev, "Unable to create device link between %s and %s\n",
 			dev_name(qcom_iommu->dev), dev_name(dev));
-		return ERR_PTR(-ENODEV);
+		ret = -ENODEV;
+		goto err_free;
 	}
 
+	dev_iommu_priv_set(dev, master);
 	return &qcom_iommu->iommu;
+
+err_free:
+	kfree(master);
+	return ERR_PTR(ret);
 }
 
-static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
+static void qcom_iommu_release_device(struct device *dev)
 {
-	struct qcom_iommu_dev *qcom_iommu;
-	struct platform_device *iommu_pdev;
-	unsigned asid = args->args[0];
+	struct qcom_iommu_master *master = dev_iommu_priv_get(dev);
 
-	if (args->args_count != 1) {
-		dev_err(dev, "incorrect number of iommu params found for %s "
-			"(found %d, expected 1)\n",
-			args->np->full_name, args->args_count);
-		return -EINVAL;
-	}
-
-	iommu_pdev = of_find_device_by_node(args->np);
-	if (WARN_ON(!iommu_pdev))
-		return -EINVAL;
-
-	qcom_iommu = platform_get_drvdata(iommu_pdev);
-
-	/* make sure the asid specified in dt is valid, so we don't have
-	 * to sanity check this elsewhere:
-	 */
-	if (WARN_ON(asid > qcom_iommu->max_asid) ||
-	    WARN_ON(qcom_iommu->ctxs[asid] == NULL)) {
-		put_device(&iommu_pdev->dev);
-		return -EINVAL;
-	}
-
-	if (!dev_iommu_priv_get(dev)) {
-		dev_iommu_priv_set(dev, qcom_iommu);
-	} else {
-		/* make sure devices iommus dt node isn't referring to
-		 * multiple different iommu devices.  Multiple context
-		 * banks are ok, but multiple devices are not:
-		 */
-		if (WARN_ON(qcom_iommu != dev_iommu_priv_get(dev))) {
-			put_device(&iommu_pdev->dev);
-			return -EINVAL;
-		}
-	}
-
-	return iommu_fwspec_add_ids(dev, &asid, 1);
+	kfree(master);
 }
 
 static const struct iommu_ops qcom_iommu_ops = {
 	.identity_domain = &qcom_iommu_identity_domain,
 	.capable	= qcom_iommu_capable,
 	.domain_alloc_paging = qcom_iommu_domain_alloc_paging,
-	.probe_device	= qcom_iommu_probe_device,
+	.probe_device_pinf = qcom_iommu_probe_device,
+	.release_device = qcom_iommu_release_device,
 	.device_group	= generic_device_group,
-	.of_xlate	= qcom_iommu_of_xlate,
+	.of_xlate	= iommu_dummy_of_xlate,
 	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= qcom_iommu_attach_dev,
-- 
2.42.0

