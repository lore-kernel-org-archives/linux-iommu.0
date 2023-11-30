Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC774C7E;
	Thu, 30 Nov 2023 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CBdpRT14"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUcb0o8TK/CWwxv6vMj02zueutQE2PBAf/S1Vrcb6/eeU5VEQolus0VkD0tHCW6hvIZpaqtVpjDJ8Ck6bghtksJu9ItLoxjP1sU3v4PKc34XAnzL0EJMvTEpqNWvO2uRqCaLvhOsm9/K4UbgaA3ZpatxqVIZKA5BQf+rK0KjkPdq5NI9rP69DU1oo9vCIIOoCG0yCehMOl1SAzwGZwKQuTqvgNRPclVbjaqn9QG9eEqCRg8t+UKmopEDBx+iKapfWoi91uf1uayY2AhFrhjTdbSHbONMtM5LJBfwCJm/D2J538B1DQh2WZaAUx56KFSwsX8EXmPN2UETpPuTCQFauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Em3umxu+TrgBsDrHGwW96pPsBzA9rtgyJQRI8gBte78=;
 b=k711LhND/q1ix3PAlfT6IXTodfOKpAAi4YqMeoAee1gggguqrkZr68KJ+zfMqY84Ebb1SbRsUtojR3HgGfMasDKcnagB8e5Y2F/Y0HaOG2UcgIzdHMupjkgbhWafR8R1JQkdK0oHtqkGRGATqOqSnt7mbHSld1oieIsDr8mMrGr6rRmPB1VSHB0jbMXxI4f+7icQ8YfizHv9kWVKilvjtpzyTKxI6r8UgIfjcy4QEEmee255LNGazxUcwP5ozfJW+KYCyxNylT+dMpvgPkLNdSdfymDKaHCCim8i9Vrk0ckEEmi01GoL0IUAKbuH2NxE851/FrwitPEscnV5Sa3ysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Em3umxu+TrgBsDrHGwW96pPsBzA9rtgyJQRI8gBte78=;
 b=CBdpRT14OgRAgvpCUb3KlEuTAfqT5s471kBpVIArqx9q6bhQb9Fda/4N+eZpYCUso27QtjTSrA+F2B/v2Bw6wtnUKaTNBMCW2XJINX4LkDE4hZ7pekWsqVtqJug/T09t4RsPFzX925xkHJa5Tl8CQBXDNq+wtytKuL6zna2MECiKv+tYG1P6cZze8+AZNYq8jBI3trXLA9km80SljsHgvQKt3+cK47aQFqIgDsxMljdL/r54rqpozyEN7kGTtmZvz6mx7v2ZGhSqLfjbv6d+jhM+2BQ9P2zE20PHhDWhHQmIARhYcrBJwNZFZLuJdSQciHPNt5OIvvnfuTHsfIzCrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 01:14:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:37 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 15/30] iommu/msm: Move to iommu_of_xlate()
Date: Wed, 29 Nov 2023 21:14:15 -0400
Message-ID: <15-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:806:24::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 5694f3a1-0477-404a-9cf3-08dbf141b62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3QHDdzhm6lfokjcqmczS7tjd58xHGo9bUskZu7SVSqQcKtM/5y41Nsa0cLhGvtb5iJgOEOi4rINQNJmQW3raIKrBavRyMyukCjMAgRr31n5hLwpHeNX0VjMabACI26bioLHSm621Ajehm9bppeue46odTk/Lrt4xrVnCtEzxAApQGA4SxSCIYyi19Buin8CG1P5KN+7IqBXya0Mea23ZgO3ebmo+RslNWi3YhIt1i/I13PBOAtPE1N2DOT/EP373aaKhaVhdGx3LW7svHB2wNjAdMXAfuWrMrWBZllqhJPgkdZfujiHkt65jWs6O46U0znuPin3l8uW0NzeWUPtP1bziiSpVVzrbf1Qq7YdFIAK7crGXcOZSNG7XyUmFtqaVi3luqxLlDznK8ReCUOc10oH0qpPR7OQW6Z0cUuDZq+SSXVmuIf4fAVApxmBzIAS4N4Oy0fDE5LtPiAeXo+uoeA+qO/EkHzLAeln1y90iuvuZj8aOt6IwUOiZ878O3tZJ/kOq5+YLIeDdHhyl9uIQlsHt/OJx3yin3dP4Q+OsGMR5R+eIffenUj/EVNlapNGKVJhqnOM4IUVc/3vqzE5OUTtCUxxQrTKwg89qxLv6Qgo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(109986022)(1800799012)(451199024)(186009)(64100799003)(83380400001)(66899024)(2616005)(26005)(66476007)(66946007)(54906003)(66556008)(2906002)(8676002)(4326008)(8936002)(86362001)(5660300002)(41300700001)(6506007)(6666004)(6512007)(36756003)(316002)(478600001)(6486002)(38100700002)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a8zuT56N0VPqUpZtO/l1P1LhLLzWhea1/4gCxDTW01EDvMnKfclLPAbwAKrU?=
 =?us-ascii?Q?+4BnMnAH21Lt4teaFYvhAzpXOT9j9pTqjXbgxiP5xCEgfy1OcwJVfe4oF4RZ?=
 =?us-ascii?Q?8oV9uEm4w4k1q9YwolXSPRA/1fAkrdL8d10YMZMar5ZXCiAZuTnp31qUvu+z?=
 =?us-ascii?Q?91zM5nyRaLVRH0MUPb7Qk4hluvcK9uXZZWIpAyjo5EYS/zWRCJugm2NPJ5Fs?=
 =?us-ascii?Q?xINtDyrNqVzoy7aI2ItB3vfKo36pT/+uEyjbmtx7hbdNxYmmMAMrfkQumkZ/?=
 =?us-ascii?Q?7OesCbh5Ly9G59Hlk2Os5E7JHkPs9p9WZi2Huwn18OdYbywmKdAYLjydMfEa?=
 =?us-ascii?Q?y+bv52p1ko7asIYs4eM3xAXDG5GmEHzZD5sujLAQ05oBZWp5eIOe0XwG7yx2?=
 =?us-ascii?Q?JtZhdT5zNb5onmkJcrIFX28xsJTjLoKOG39OK3nT0l/N8BPjLq5OPFPwmD5t?=
 =?us-ascii?Q?UsnDTO59mVRUx1T+j3h4HKTmfyf0oraRFMRzeTgPHgeqdyD9A69r8NKeuKpH?=
 =?us-ascii?Q?L0TQqt9/KbqbkfPmqR878NXxMm961tA1ZEZ6W2aDSJBdoGr7EKv8yWHzYgN7?=
 =?us-ascii?Q?Aq0sCqN4tso+BmgcPgtbHp9GZlJ5T5CI+CNosZSa3b+JCbTtaM/itdrZTEWf?=
 =?us-ascii?Q?Zx8eZUq9iTCJgePVx8C0m28jl6ELzwFj/HYzclyingtjR2YdXNQ2cfuMX2Yv?=
 =?us-ascii?Q?ikyDVJzDnVJp8GSbvbZF82viIwhwu7xJXRdLydiEglCkHjL9AO49DyFO3bXX?=
 =?us-ascii?Q?/rbdDtZtIThsp2EChW2fVGPqqe+iFf1yNKZJq9rVGX/KCtvefkh4Bxj/s53w?=
 =?us-ascii?Q?fBSPohxxW4qXRjpQpPwYYcJv12naqXLH9gla7oqv5yJRiBRcTGqx6bLC1tvh?=
 =?us-ascii?Q?DuSRsoflaEQJOLMdL4j09PC2H3Xxd/bMC3VjyzkQl3YbT+/hLhSASzDJmC3o?=
 =?us-ascii?Q?obJ2kVRvusX4HVhm0FepcPKys0G2A/NdhEa71AjZRvfKSVvNgISmqSMDiWF3?=
 =?us-ascii?Q?CRurLCgjGtffe2oVu1rPQD7nNE38Qr9FpXFI+HeOzE1cM+wI3XPN1bVAIXz3?=
 =?us-ascii?Q?IsuCIS3xNqEVnUZa6/sPTVMUpLZYr9KmGkcwO7kIHPfRxiVBXRBKWA5Y1f4n?=
 =?us-ascii?Q?BcwM2WhhXZ7o07m6/d0WmpvANNob+Xt/a9b5l58Ho3M07gXgDgukSPyzW/hP?=
 =?us-ascii?Q?0DBl2WDCEavdqcJ6vwRfUEEfV2Uh6k9ECyRDowQMhr7g/5nb3n1Oba2yGVQ+?=
 =?us-ascii?Q?ci4XpiSb46PWN7IwtRHhs1TEL8qGzxplk1vL5GjgKITuJOx0r9zqq3FwgSBC?=
 =?us-ascii?Q?gDvcEyzgaVqnjerHtAbszsDq9WIJ3GbmyQpF+kL5nqMzC+eigZxIXl2nHgSG?=
 =?us-ascii?Q?j7lkdafudDye5JuWkEJFFC8yoJKdXaCGNsDN5eHK3KWhAaUlqSXSAavVwcI8?=
 =?us-ascii?Q?un15U7fGv+sEhPuXV8kdq2HL51d0WfvuPlkE2r4zfkl0Kv9Q8LbJRx1m7jeA?=
 =?us-ascii?Q?Dne8f2BjUohKSLdDW4AyitjihC+qSNYvkJjFrghGukMMEjJL4aTmaDWsVZkt?=
 =?us-ascii?Q?eh1OFzh8xMRWCuolPpFTk1d3b7fD6GOxjQiKI3ix?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5694f3a1-0477-404a-9cf3-08dbf141b62f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:33.5588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CK2pe5k6a6PxPFUiJOJZQdEzoDz2PfmiDnQ5HN21PIqeyOVzQdHqy7I8cE8ERB3n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484

It is confusing what this driver is doing. The insert_iommu_master(),
especially the list_empty(), doesn't make a lot of sense.

Based on the dtsi this supports an iommu instance that has exactly one
device attached it. However each device may be connected to multiple
instances with multiple stream ids. The iommus list must be sorted by
instance or it will not parse correctly.

Ideally this driver would work more like dart where each master allocates
memory for dev_iommu_priv and records a list of the all the iommus and
stream ids in that struct. That is too big of a change for this patch.

Keep things basically the same, but rely on the core code to discover the
iommu_device and stop confusingly using dev_iommu_priv to join SIDs into
the same master when processing the assumed-to-be-sorted iommus list.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/msm_iommu.c | 93 ++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 56 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index f86af9815d6f98..6f21eec857c7d7 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -16,6 +16,7 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 
@@ -37,6 +38,15 @@ static DEFINE_SPINLOCK(msm_iommu_lock);
 static LIST_HEAD(qcom_iommu_devices);
 static struct iommu_ops msm_iommu_ops;
 
+struct msm_xlate_args {
+	struct device *dev;
+	struct msm_iommu_ctx_dev *master;
+	struct msm_iommu_dev *iommu;
+};
+
+static int msm_iommu_of_xlate(struct iommu_device *core_iommu,
+			      struct of_phandle_args *args, void *priv);
+
 struct msm_priv {
 	struct list_head list_attached;
 	struct iommu_domain domain;
@@ -357,38 +367,17 @@ static int msm_iommu_domain_config(struct msm_priv *priv)
 	return 0;
 }
 
-/* Must be called under msm_iommu_lock */
-static struct msm_iommu_dev *find_iommu_for_dev(struct device *dev)
+static struct iommu_device *
+msm_iommu_probe_device(struct iommu_probe_info *pinf)
 {
-	struct msm_iommu_dev *iommu, *ret = NULL;
-	struct msm_iommu_ctx_dev *master;
+	struct msm_xlate_args args = { .dev = pinf->dev };
+	int ret;
 
-	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node) {
-		master = list_first_entry(&iommu->ctx_list,
-					  struct msm_iommu_ctx_dev,
-					  list);
-		if (master->of_node == dev->of_node) {
-			ret = iommu;
-			break;
-		}
-	}
-
-	return ret;
-}
-
-static struct iommu_device *msm_iommu_probe_device(struct device *dev)
-{
-	struct msm_iommu_dev *iommu;
-	unsigned long flags;
-
-	spin_lock_irqsave(&msm_iommu_lock, flags);
-	iommu = find_iommu_for_dev(dev);
-	spin_unlock_irqrestore(&msm_iommu_lock, flags);
-
-	if (!iommu)
-		return ERR_PTR(-ENODEV);
-
-	return &iommu->iommu;
+	ret = iommu_of_xlate(pinf, &msm_iommu_ops, -1, &msm_iommu_of_xlate,
+			     &args);
+	if (ret)
+		return ERR_PTR(ret);
+	return &args.iommu->iommu;
 }
 
 static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
@@ -596,22 +585,26 @@ static void print_ctx_regs(void __iomem *base, int ctx)
 	       GET_SCTLR(base, ctx), GET_ACTLR(base, ctx));
 }
 
-static int insert_iommu_master(struct device *dev,
-				struct msm_iommu_dev **iommu,
-				struct of_phandle_args *spec)
+static int insert_iommu_master(struct msm_xlate_args *args,
+			       struct msm_iommu_dev *iommu,
+			       struct of_phandle_args *spec)
 {
-	struct msm_iommu_ctx_dev *master = dev_iommu_priv_get(dev);
+	struct msm_iommu_ctx_dev *master = args->master;
+	struct device *dev = args->dev;
 	int sid;
 
-	if (list_empty(&(*iommu)->ctx_list)) {
+	if (!args->iommu)
+		args->iommu = iommu;
+
+	if (list_empty(&iommu->ctx_list)) {
 		master = kzalloc(sizeof(*master), GFP_ATOMIC);
 		if (!master) {
 			dev_err(dev, "Failed to allocate iommu_master\n");
 			return -ENOMEM;
 		}
 		master->of_node = dev->of_node;
-		list_add(&master->list, &(*iommu)->ctx_list);
-		dev_iommu_priv_set(dev, master);
+		list_add(&master->list, &iommu->ctx_list);
+		args->master = master;
 	}
 
 	for (sid = 0; sid < master->num_mids; sid++)
@@ -625,28 +618,16 @@ static int insert_iommu_master(struct device *dev,
 	return 0;
 }
 
-static int qcom_iommu_of_xlate(struct device *dev,
-			       struct of_phandle_args *spec)
+static int msm_iommu_of_xlate(struct iommu_device *core_iommu,
+			      struct of_phandle_args *args, void *priv)
 {
-	struct msm_iommu_dev *iommu = NULL, *iter;
+	struct msm_iommu_dev *iommu =
+		container_of(core_iommu, struct msm_iommu_dev, iommu);
 	unsigned long flags;
 	int ret = 0;
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
-	list_for_each_entry(iter, &qcom_iommu_devices, dev_node) {
-		if (iter->dev->of_node == spec->np) {
-			iommu = iter;
-			break;
-		}
-	}
-
-	if (!iommu) {
-		ret = -ENODEV;
-		goto fail;
-	}
-
-	ret = insert_iommu_master(dev, &iommu, spec);
-fail:
+	ret = insert_iommu_master(priv, iommu, args);
 	spin_unlock_irqrestore(&msm_iommu_lock, flags);
 
 	return ret;
@@ -690,10 +671,10 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
 static struct iommu_ops msm_iommu_ops = {
 	.identity_domain = &msm_iommu_identity_domain,
 	.domain_alloc_paging = msm_iommu_domain_alloc_paging,
-	.probe_device = msm_iommu_probe_device,
+	.probe_device_pinf = msm_iommu_probe_device,
 	.device_group = generic_device_group,
 	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
-	.of_xlate = qcom_iommu_of_xlate,
+	.of_xlate = iommu_dummy_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= msm_iommu_attach_dev,
 		.map_pages	= msm_iommu_map,
-- 
2.42.0

