Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AB4E4DB
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 23:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FK8juJThW+RqCSu9JsC8BAFv0qgTcrIRl7h2aX63It2zXGh+WximaBWnnAFz9BY+3a8RY6yV6FZjiTv4ESwopt138C1jZmkaC1qVd3GumOu+N7J0HPdU+DD3kcRaDpduQIwG2bPUoPC/1cGACeiElHeTalIiC5OF3IUQTiFAcfpvjo0laN7vWSiUPYi+6/OnwXF5VWQRVb4SDXxq4VHugI0ClnUvlfgN2iF1CgjtD7o3WKQmVjownbTrcSAUGhAiN33n91jJOVbbgPQdjSynsn+ao313LjHl8c9xflIcVuilx9C1HX4FpUMsKHxNvYYDdt+DwabDULaLTzmExYB4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXduG5MWhKsdHp1knFAD5oYQTJOuSAsOUX/7Kw+uUW8=;
 b=RdKbYML7cse36F/pXtpChhrqEwsfMWR1V7Jjoxog4BzBzdM8uVcxINqtgpXlTmZ1qyFwtdb6OmJO99KDpoIpYFF6ieWCE+J7sr7q6cDWdLcGwlqHQ8547MsvmxBI7lh0Rre2o9FNQ3kKtcR6IQ7jn8DfPt7t7L/uOSXaZYzPbDLN0k6Akh9Na5j0qlIqy1IoGRNwLwd75CRshQWAl/BTtqn4kJPG64p1b7H0gqoC+2r5hleUXT+BYyTe7QSRmsm5lEr2RdC03UmktZJX7YU1vOariUPqE2pi466ADk23vYs8CXXPb3go8PsdINlyfZVK7ex1H78EMoojNoFnusnP0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXduG5MWhKsdHp1knFAD5oYQTJOuSAsOUX/7Kw+uUW8=;
 b=YsxPa4DHWN9QML+w+ifjMt/wxHHCjJPJpKUoYEEBTzGvE0UF0TWIRE0WIeZJWQQGzLwotOw0I/bZkYapk38FTkW39SiU3/6B8yApF3gP0dAtagh7cZaELTFW0CDAHSqV2n23cH5njdxg6xOFE5fWFKiTKOlE+tSRkhMy4Y044ye4RSn/PAFdSfswIneOne02Hx8XypPEnlsrKoI2mkopI+1McEszN3Cz+fwcDfXZ2GC/FJlHcWL/9bnm+TISfOXvOY4oiKar034ldL1ShSwc6eevggSggGQZWGsI5eWy6YyyIBC4sZcqp+CVOH4don8BqCujkIZAxX2zIwYjRTRpOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Thu, 6 Apr
 2023 23:42:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 23:42:58 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alim Akhtar <alim.akhtar@samsung.com>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH] iommu/exynos: Implement an IDENTITY domain
Date: Thu,  6 Apr 2023 20:42:57 -0300
Message-Id: <0-v1-9bede1ab3a9b+15-exynos-identity_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:208:fc::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d438122-1237-40fe-564b-08db36f8a725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HILONCsB9X9DpO3yZ6EZ/VJ8IHhKluZ9TiAc36QzxzjObxrFY23zAaxBmeq67zyZXwuDqmTuUJscx9M1/Gi4jbRx/Pld7tSP9cKGwFJ2ICi2LjXOPMLFsVg+B/wZUX+emH1biuSM8fSwyUZUwsyWti/2bDFNTCBCFSjqjlpg2CcQWt0aNpM3X3fqNzRyTukGNAOFeGCE+YDMssUoaV0bHkwW6cxRF4yTRuAOEigZD+Oi3axfFCop4h2x7bUuNY0h3c7GUhYqThxjfFqwQi4sQkDn4Jtg/8EFfZP6yh60EmsToBgK4kXXOzOuB/Xb43/Ehriqk6ymk0QhmHirIEWJXONtt5G0B7XNI4cj4JOFXoAKUolU1u4O1FYJXduV5luQL2BoMmsX2XuEB5wpcuemoU6kCVM38agp7fgPb3MTp8J7T6JwW9Fo6KKDj+LIWuwJR1ugAPfTrqpXtZpyHtlxTXVrplWcjLaPTUh8f2qoJwbnHV0qEIO3dWGHg9YRdeHGVL8O2dWP2y+6rE0HSjKs4YZEcZVjKEcCC3VvZVhgugDyziHbvQiAzDrHdaXnd0pEswHonVC4ENsUvECIb1ZIi2+L6BocESxcD0NQ5RYD2Xw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(2906002)(186003)(26005)(8936002)(6512007)(5660300002)(6506007)(2616005)(8676002)(83380400001)(66946007)(66476007)(66556008)(41300700001)(478600001)(6486002)(110136005)(36756003)(316002)(38100700002)(86362001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HoBDiKBxC1ChiajLmh1TiXesAtzn6Hv0ktBStlwQ2VEoCX7AqXwYLrY4EiJf?=
 =?us-ascii?Q?YXIIfEyNULaPY+sDBsFUYAabsG/b6aS47mFNXU/QM1ZIHmtwo9Wcb8KFGhXL?=
 =?us-ascii?Q?Kh9DEp6DYZiEOz25u1g4vJGtQxprX8RIFYmhfb9nGpcZ+jmUFwHohfOWHJJI?=
 =?us-ascii?Q?1PehKCVZRFmimwnEWaBlzxNxq3uiui/CCRfwAuEDfzRKmiIYNLSKMqNg1SL3?=
 =?us-ascii?Q?GLdbOcQSp4d1PnmKVUbsO3vWtOqOVjf6hwpL3d+6ZSD5L9T87fZ5+xzcu5bS?=
 =?us-ascii?Q?/Iccjff6OpF+uGhabxUyWF9dyGV0ZkopLB3boewH+F0kv95o/GtZhFBZnVn+?=
 =?us-ascii?Q?IWXpmjh9ay9Hwr2Eg2TzVgjdyUuvvG4G90dWd542fJh+S8DV6DCAQEX8s3bc?=
 =?us-ascii?Q?UfAZa3Gym/AiSXjBy6saLWxg2e/mjCD+5jdYdo0NJ8JiOoMWYFARhG5YjsLR?=
 =?us-ascii?Q?hNF51ZgVvcZupFqabUbFYwbXc7H2IQTHVy/EeuI+4N5gWS/z0++X51crKXwx?=
 =?us-ascii?Q?IoS3X79Vcpm030yRwqwYN6Ivlza7kbazctYlDyz8xNDheZJsFXlOoBFHvvGC?=
 =?us-ascii?Q?D3PQuPerFP24l3IO/ufPhw2OrQWsaH00H3BlXv95uNYZBgJ5K3Z55NcqmgCJ?=
 =?us-ascii?Q?QkJ3Lvtcmda/35HBPYqhl0A65y8NbmrgB1z4fGNxIP/DFV23scYAeQx4LXLJ?=
 =?us-ascii?Q?RE2kJlnBs3TzmvU4h5mI4VwDXba0feV23mIxaA0gzNGD9VvUPaW9aNSGR4Ct?=
 =?us-ascii?Q?mlt4ogbPgEeslH2I51FIK+aQEEwa3oU+EOg6ra1RwybAe6EfYNYJz+Wa1XnR?=
 =?us-ascii?Q?q7NGtPWXs0VHJMRluE1EY4Dy/8RTMosjBBhT43t/OGM7ELNMHFbXW4CWg5/A?=
 =?us-ascii?Q?1onoAwYaXCTscEviBKJPPcIbeJo0g7X6SaHxKnfwNXVzxaublIDPUXGHQ/KE?=
 =?us-ascii?Q?jmTYWaw4A7IUDFJ7S6HpTTprDxpnlWKeABtVvVSyD0zyKam4C9/nWZ3TFrGP?=
 =?us-ascii?Q?9Byak2KMn3PnYG4AfhqhbbXPZC743VXMqxE0ay/HrwxX77OUqmQ7ywnJd1BN?=
 =?us-ascii?Q?AN03DrRO6XK88GVuikUrCQ8jJmItzAPzLI35Pktc3ycE310nZSy4vfJkhx1g?=
 =?us-ascii?Q?obRh1MeUNV1HFSMoBWhqfX/2GQoBfiHHxUdxdtWrwzFhV1lUqCXRThJhN5VP?=
 =?us-ascii?Q?qh9exVtxQoE7JEbcHpCqf83fzyrxIXzpGj96YmAeSjYsy0PECHwqupZox/YU?=
 =?us-ascii?Q?MPIrjv7F1hxyx75Q8U3wT9V2wm2Diw/bRbgNH6UojvJ7n1CL69hw8U2XTZ9C?=
 =?us-ascii?Q?2bgVhd7tuK74/jgz1DZSIsRdGRrCkiIzwqzfDiqYyVAbzULfQZ1hb5MC3m6U?=
 =?us-ascii?Q?iGm7W2/DUzzbG0b2YFpdgB6zFN9wOZHGfft6Qs6uhiiqthFUzAT13k/bgw2G?=
 =?us-ascii?Q?bbBzMHT9XZh6hppFC4p7FEsojf/xCLvBONdASkwdRDzzAc+mI03fDpvVyRTD?=
 =?us-ascii?Q?xWe+XT9cNe+NzEfDcYkMtGs9l6Xelj7QNe8m3gNRv+YHtbDF/W4sSwiyv+3v?=
 =?us-ascii?Q?efKjh6TM3M7A1/K95NeUm+iTXxnqaiilSWK0z0UN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d438122-1237-40fe-564b-08db36f8a725
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 23:42:58.8129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Emcw0PhhfHex81DnhBJUSGHQw0PHjvjoKWZ8Z2EqdWPc3RKcyF/naUQXPQFtyP79
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160

What exynos calls exynos_iommu_detach_device is actually putting the iommu
into identity mode. Instead of having a translation mode that is invisible
to the core code implement it as an actual IDENTITY domain.

On ARM64 this will allow the IDENTITIY dma iommu mode to work, and on
ARM32 this clarifies what set_platform_dma_ops is actually doing.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/exynos-iommu.c | 67 ++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 25 deletions(-)

Marek, as requested here is that patch on top of your stuff that went to rc

I picked all the notes from Steve from the rockchip version into here as well

Thanks,
Jason

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 1abd187c6075e4..acdb8aeeed48b4 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -24,6 +24,7 @@
 
 typedef u32 sysmmu_iova_t;
 typedef u32 sysmmu_pte_t;
+static struct iommu_domain exynos_identity_domain;
 
 /* We do not consider super section mapping (16MB) */
 #define SECT_ORDER 20
@@ -837,7 +838,7 @@ static int __maybe_unused exynos_sysmmu_suspend(struct device *dev)
 		struct exynos_iommu_owner *owner = dev_iommu_priv_get(master);
 
 		mutex_lock(&owner->rpm_lock);
-		if (data->domain) {
+		if (&data->domain->domain != &exynos_identity_domain) {
 			dev_dbg(data->sysmmu, "saving state\n");
 			__sysmmu_disable(data);
 		}
@@ -855,7 +856,7 @@ static int __maybe_unused exynos_sysmmu_resume(struct device *dev)
 		struct exynos_iommu_owner *owner = dev_iommu_priv_get(master);
 
 		mutex_lock(&owner->rpm_lock);
-		if (data->domain) {
+		if (&data->domain->domain != &exynos_identity_domain) {
 			dev_dbg(data->sysmmu, "restoring state\n");
 			__sysmmu_enable(data);
 		}
@@ -900,6 +901,9 @@ static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
 	dma_addr_t handle;
 	int i;
 
+	if (type == IOMMU_DOMAIN_IDENTITY)
+		return &exynos_identity_domain;
+
 	/* Check if correct PTE offsets are initialized */
 	BUG_ON(PG_ENT_SHIFT < 0 || !dma_dev);
 
@@ -988,17 +992,22 @@ static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
 	kfree(domain);
 }
 
-static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
-				    struct device *dev)
+static int exynos_iommu_identity_attach(struct iommu_domain *identity_domain,
+					struct device *dev)
 {
-	struct exynos_iommu_domain *domain = to_exynos_domain(iommu_domain);
 	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
-	phys_addr_t pagetable = virt_to_phys(domain->pgtable);
+	struct exynos_iommu_domain *domain;
+	phys_addr_t pagetable;
 	struct sysmmu_drvdata *data, *next;
 	unsigned long flags;
 
-	if (!has_sysmmu(dev) || owner->domain != iommu_domain)
-		return;
+	if (!owner)
+		return -ENODEV;
+	if (owner->domain == identity_domain)
+		return 0;
+
+	domain = to_exynos_domain(owner->domain);
+	pagetable = virt_to_phys(domain->pgtable);
 
 	mutex_lock(&owner->rpm_lock);
 
@@ -1017,15 +1026,30 @@ static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
 		list_del_init(&data->domain_node);
 		spin_unlock(&data->lock);
 	}
-	owner->domain = NULL;
+	owner->domain = identity_domain;
 	spin_unlock_irqrestore(&domain->lock, flags);
 
 	mutex_unlock(&owner->rpm_lock);
 
 	dev_dbg(dev, "%s: Detached IOMMU with pgtable %pa\n", __func__,
 		&pagetable);
+	return 0;
+}
+
+static void exynos_iommu_identity_free(struct iommu_domain *domain)
+{
 }
 
+static struct iommu_domain_ops exynos_identity_ops = {
+	.attach_dev = exynos_iommu_identity_attach,
+	.free = exynos_iommu_identity_free,
+};
+
+static struct iommu_domain exynos_identity_domain = {
+	.type = IOMMU_DOMAIN_IDENTITY,
+	.ops = &exynos_identity_ops,
+};
+
 static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 				   struct device *dev)
 {
@@ -1034,12 +1058,11 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 	struct sysmmu_drvdata *data;
 	phys_addr_t pagetable = virt_to_phys(domain->pgtable);
 	unsigned long flags;
+	int err;
 
-	if (!has_sysmmu(dev))
-		return -ENODEV;
-
-	if (owner->domain)
-		exynos_iommu_detach_device(owner->domain, dev);
+	err = exynos_iommu_identity_attach(&exynos_identity_domain, dev);
+	if (err)
+		return err;
 
 	mutex_lock(&owner->rpm_lock);
 
@@ -1415,26 +1438,19 @@ static struct iommu_device *exynos_iommu_probe_device(struct device *dev)
 	return &data->iommu;
 }
 
+#ifdef CONFIG_ARM
 static void exynos_iommu_set_platform_dma(struct device *dev)
 {
-	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
-
-	if (owner->domain) {
-		struct iommu_group *group = iommu_group_get(dev);
-
-		if (group) {
-			exynos_iommu_detach_device(owner->domain, dev);
-			iommu_group_put(group);
-		}
-	}
+	WARN_ON(exynos_iommu_identity_attach(&exynos_identity_domain, dev));
 }
+#endif
 
 static void exynos_iommu_release_device(struct device *dev)
 {
 	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
 	struct sysmmu_drvdata *data;
 
-	exynos_iommu_set_platform_dma(dev);
+	WARN_ON(exynos_iommu_identity_attach(&exynos_identity_domain, dev));
 
 	list_for_each_entry(data, &owner->controllers, owner_node)
 		device_link_del(data->link);
@@ -1465,6 +1481,7 @@ static int exynos_iommu_of_xlate(struct device *dev,
 
 		INIT_LIST_HEAD(&owner->controllers);
 		mutex_init(&owner->rpm_lock);
+		owner->domain = &exynos_identity_domain;
 		dev_iommu_priv_set(dev, owner);
 	}
 

base-commit: 13a0d1ae7ee6b438f5537711a8c60cba00554943
-- 
2.40.0

