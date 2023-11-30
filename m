Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCF6185C;
	Thu, 30 Nov 2023 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WiVmB3lU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bq7HNX+VpTQCkLKbBiO3TraUE/zmFbeRlXbwQidxYfQcKlo4I9BQZjnUNWa4igZaUqK1zI7V/qxDRDlKUUpTmFNpClZEXdUd5KHErnNG2BQHVAmgfmtlq4ZA9rJ9SV2gnFpyTD95HERzfGioxDlOABZP4PgGFYFsnQgypYdQJuOt+69p5sNDoubQtOKoLm0AHKtwbXHk8Ap9HiZKQFalbV9kj0UwayipIVIZHAQmX1ssBtbkKEI7qJWM8Wo3rmCcbozGDJFpxVLLDq1w0AoNE05Dm7VuCHWOXvTHlY3wT9rmuI9EghUcRTY7MOdzsr/OHklfHBeBbQ4nw87bHEkpEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVfjFiF2fSnhxlRRXNND7TRJRH/U77+j8K1B2oK4udg=;
 b=OaxfKjXcvp4QqzTBnC9WgR3ly0oP8RehY6z/byAJGgbuqZc0NueFFacwGnCLr6kH261bAnHk1YkPElyml5Mv/1yma1sOxLdxzkz9e8iSb/lWNkUaXrU4v1k9+XbwKikUT7ilC1MSKaaq3zt9JRADSBu0875IzKUnmQCerlF7d0a8zL4qH+dyLddiMIKOB/N/x2MMKTN1DBJKA4/7xOkJOtu31KpA1kNlcbZX7EkSLbx5VeDc8PQwRzP9hBRz7Di8hc03OzuyMsoVwFUGAm1qQ3axJnGvmGgMBdWlcHIIf+hodIAuGhq+0Ak7cHGOjtQcBf30otqLlnwd4wEwNpYJ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVfjFiF2fSnhxlRRXNND7TRJRH/U77+j8K1B2oK4udg=;
 b=WiVmB3lUbb6LR4R5DdKCqTY7Pv1vckTvEDELmdyEXgRLMnFjJQb+HINaGl/3gSpX6JlvOlS9zTQ3Cac60quC9lJX2w55sLFOexl+yMrB7MfEyOGwsuDw8dkBhJT+tLViViv8y5nDCu1NgjKvnEisRPtryKh62rWZi/Ce53tcSjfwQwEH73/NjUoO3YzUNSCTX7erzxaoYStI/2ZBHIzYA4D8aG7dX7sn7IGH0uP/j41n3Ss2/AzjpaPoaqpcjWQaD2KdsNkDJG6r2r+7m4V71ScN97tvieYAMZV9XfoGi4722o+8fScqCk4m4IDVbwa/dd62EA5c5uUbKWvLCSFjNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 01:14:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:35 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 27/30] iommu/arm-smmu: Move to iommu_of_xlate()
Date: Wed, 29 Nov 2023 21:14:27 -0400
Message-ID: <27-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0072.namprd16.prod.outlook.com
 (2603:10b6:805:ca::49) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b11901-292a-435c-2dba-08dbf141b567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zF1DsizpqYh1ZPr39hGZwelWpwH+RzOaQ7pcRYOi+2jkrotX5eZOfgkpH1CSwEIrb3VaR+24d3duu7G6c5oHunmSD3x6TumLOT+1ewFoHzsJNqAXiyE2sSzV7Dyy6OdyzyUM369LiS7bTMkMM0FJBNKB+ACXfxIiKMwDsdqjD41ADRVSq/kdsVynCcVmd6r3iBRqCZZo5T6czmvUjbUufpmvQlXDIpbvU8dFDLAKKffwA6ZQPnlZrTLRB/Ext2ga65fwhStDkRFNfm90yXAO6FmIVoUTPoKHG3K2ow1TRFUwnfm9LplORnnZBtZ+Gau1ou6x7NnFoDXvSxU+ep6ExQ0pU5mM7gWjy253IjLlT2HlH7xNjO9hTanuFFRVLVfV7T29FVmYRprYAbwthoEDsQpUzXHCg38TiOnSZTzJpC6g/XzejrJKMS2aLZ8DW6l0gfW5SehhCxcookuetIPAmKYcKdVpvhs+ljfrAWSYOPqGXPXiYZZBvG1S0yGzm05zvM51RM6SN5x4QFkAq+8fnEfryuDrW2+3Erhrt4eWx2F/Q3wj8lTVvFbHcWm40sQ/GthFKQqyPgFqyqw3+FyQjwBlgiwHWInRJ8zOorDpDGQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(109986022)(1800799012)(451199024)(186009)(64100799003)(83380400001)(2616005)(26005)(66476007)(66946007)(54906003)(66556008)(30864003)(2906002)(8676002)(4326008)(8936002)(86362001)(5660300002)(41300700001)(6506007)(6666004)(6512007)(36756003)(316002)(478600001)(6486002)(38100700002)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7QMPrttcfUa6ua+fZkM38pdoZqb2YL8jyi2L799zBA9TGAxChIKJjr8e7DTo?=
 =?us-ascii?Q?0/A3XE0KXdbqDpvI6nR97qcuN4VItyV1ChivKPH1wvgiyWLmeDuttbO1+DKX?=
 =?us-ascii?Q?Fvpoim2Ek9pD90JSViFNujR0VfpH0gVNpT/46q1KOag7biOKylUQZgv+CnSk?=
 =?us-ascii?Q?Mr4JIfl0PK8/jXMDcfKsaJbdcbjga3Bxep4KC2zWSI9j0+o980tVhIWLBF/X?=
 =?us-ascii?Q?lbSXU+Z4ftnz7ZccyGUxQFY+xfBC1a3SdQFm8xPxvPjwkB1Y8q+DJG3fpBd7?=
 =?us-ascii?Q?EVBQ4+GuKgGBfNBwXTIX+yMVrCm+HFFhQbb4kmIWwZ/NNf2NTI+VaygfB/3m?=
 =?us-ascii?Q?FGszJCL1xngYSDMXljeRr/qrHnX5dYsjzKQ84w4LG/YUbcP0Gkp7atY7CJ/C?=
 =?us-ascii?Q?zE6Co5VurCMKOB/JNe5niu4dIE91XSwToAErxn148Kaeh8CiVE8CzfeF/6ts?=
 =?us-ascii?Q?hXJqLcyhhDStvcRTO4f4j+DeitWKBwsXIn+5kwBkZd7cxN+cQ08gM7mWIHmC?=
 =?us-ascii?Q?zsDM9kRGhU202+ANQO6b6WL5kypU7LO+pGpUmSYV70/u0yfukTpXd4v+xyXq?=
 =?us-ascii?Q?YrNSulNQ8pmUH/mxkKHqArP5V1RHgteYgHZ+kl+M3p5YNxe4oSP+cryiNDVj?=
 =?us-ascii?Q?gtOPvsKAPcK3MgGtlfMFbfxUoOEjiLVlUufrBB/AVFUnoZCbgj8+W3ksv8G3?=
 =?us-ascii?Q?0j3X+3brt945ctpUGsMzEd3eYbEAAtLM0fzV22jrPuL9vAZNuxJLTA9kgEAf?=
 =?us-ascii?Q?FtinuoLWJp+QN0r+Ov+c//CLM384fy4ggnQdhT+1lOlBhFl2jslr7d7vgLtI?=
 =?us-ascii?Q?+yOWMzbG9UQwcCi4Put1EKlVimN5QTW5Xr4OYL8/XmdUf4YK04s1AAb6I4tn?=
 =?us-ascii?Q?ghosIssTz6vWNcMS3VO2L5JdZ1qSbfftAPSXaGuiAvSD0DM8qwNekrc5n0y6?=
 =?us-ascii?Q?kV6flCygDDO3yGItEfjjPJhB1tp5sXaX1Fb+GYQQRGvtYoe0WPcdpDTZwPUG?=
 =?us-ascii?Q?o7uywMiOrc+WrNxnrN0p1ZX5176CDltPYjpZNPBPD8wtXaDHhqDtknv3Y9tg?=
 =?us-ascii?Q?WBExawyb6IgijEoDd/noKGT4qhYzJNjzn4KkXKASoawGlO+78kHbe76gwX/w?=
 =?us-ascii?Q?8BX8AL3g1AxtyiRvj9gAPsx2yCJfbR687epDqgwkhm/pGY0t0dQZuMts/QRh?=
 =?us-ascii?Q?OMdTHGVqgr56u2icDFiNbMxYzsmM+Clwj0sf19KJCjuHcGiiK4VScVbaGgFa?=
 =?us-ascii?Q?VFEw5/5+zcQtim7/kPJaq39tbjj6HKYslJWSEtrBkO+PjqPoQBU4EtjWE03r?=
 =?us-ascii?Q?YLzS948PJkfggKNcARMz0xCkFrMyXw6Lqg7kwb6AotZrT72Bog3hhjJc/DaQ?=
 =?us-ascii?Q?gAWhoo+Jo1qwgsAVjzRgvuhGNv6T2iwtQbMsSHDo5P7k+E59CfZu4g8ARJK8?=
 =?us-ascii?Q?vx7All2jtNtt5Z0PJXeDvzi67v2ZgW0KlZNGaQIZIsKogLGUYp2Dfe/+Sd3h?=
 =?us-ascii?Q?FGX/SuOLD68RVs4WzDmrqPgZJeLIieztjJHGVMe4dIyvFVp8XceIWVaDTxhB?=
 =?us-ascii?Q?3LFzydn1xm/GWL/QIIMx/KFLdwOzP5LxP5Ksbruo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b11901-292a-435c-2dba-08dbf141b567
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:32.3844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpfQjeQZDPEQ/Qg4LWfRMbgNtQysjyQcA3MV539jf2MjpE7SD0fOM5O6N047p3XX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484

Compared to every other driver SMMU supports a lot of different formats
for it's firmware description:

 - The legacy OF mmu-masters with a 1 cell id
 - The OF iommus with a 1 cell id
 - The OF iommus with a 2 cell id
 - The OF iommus with a 1 cell id and stream-match-mask
 - ACPI with a 1 cell id

They all get reduced down to a single array of u32 ids in the driver.

Store the id array as a flex array in the arm_smmu_master_cfg, and change
the smendx to an allocated array. This allows using the
iommu_fw_alloc_per_device_ids() path for ACPI.

Have the legacy flow just allocate the cfg of the proper size and copy the
cells into the ids.

The OF and ACPI flows all call iommu_iort_get_single_iommu(). ACPI will
use iommu_fw_alloc_per_device_ids().

The remaining OF flows will make another pass using iommu_of_xlate() to
parse the complex details and format the IDs list.

Remove fwspec from the other places in the driver.

Directly call iort_iommu_get_resv_regions() and pass in the internal id
array instead of getting it from the fwspec.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c |   6 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 205 +++++++++++----------
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  13 +-
 3 files changed, 118 insertions(+), 106 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 549ae4dba3a681..95199de33ca865 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -101,15 +101,15 @@ static void qcom_adreno_smmu_resume_translation(const void *cookie, bool termina
 
 static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
 	int i;
 
 	/*
 	 * The GPU will always use SID 0 so that is a handy way to uniquely
 	 * identify it and configure it for per-instance pagetables
 	 */
-	for (i = 0; i < fwspec->num_ids; i++) {
-		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, fwspec->ids[i]);
+	for (i = 0; i < cfg->num_ids; i++) {
+		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, cfg->ids[i]);
 
 		if (sid == QCOM_ADRENO_SMMU_GPU_SID)
 			return true;
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 02b8dc4f366aa9..f18d40532af433 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -34,11 +34,11 @@
 #include <linux/pm_runtime.h>
 #include <linux/ratelimit.h>
 #include <linux/slab.h>
+#include <linux/iommu-driver.h>
 
 #include <linux/fsl/mc.h>
 
 #include "arm-smmu.h"
-#include "../../dma-iommu.h"
 
 /*
  * Apparently, some Qualcomm arm64 platforms which appear to expose their SMMU
@@ -89,6 +89,8 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 
 static struct platform_driver arm_smmu_driver;
 static struct iommu_ops arm_smmu_ops;
+static int arm_smmu_of_xlate(struct iommu_device *iommu,
+			     struct of_phandle_args *args, void *priv);
 
 #ifdef CONFIG_ARM_SMMU_LEGACY_DT_BINDINGS
 static struct device_node *dev_get_dev_node(struct device *dev)
@@ -126,21 +128,21 @@ static int __find_legacy_master_phandle(struct device *dev, void *data)
 	return err == -ENOENT ? 0 : err;
 }
 
-static int arm_smmu_register_legacy_master(struct device *dev,
-					   struct arm_smmu_device **smmu)
+static struct arm_smmu_master_cfg *
+arm_smmu_register_legacy_master(struct device *dev)
 {
+	struct arm_smmu_master_cfg *cfg;
 	struct device *smmu_dev;
 	struct device_node *np;
 	struct of_phandle_iterator it;
 	void *data = &it;
-	u32 *sids;
 	__be32 pci_sid;
 	int err;
 
 	np = dev_get_dev_node(dev);
 	if (!np || !of_property_present(np, "#stream-id-cells")) {
 		of_node_put(np);
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 	}
 
 	it.node = np;
@@ -149,9 +151,9 @@ static int arm_smmu_register_legacy_master(struct device *dev,
 	smmu_dev = data;
 	of_node_put(np);
 	if (err == 0)
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 	if (err < 0)
-		return err;
+		return ERR_PTR(err);
 
 	if (dev_is_pci(dev)) {
 		/* "mmu-masters" assumes Stream ID == Requester ID */
@@ -161,26 +163,20 @@ static int arm_smmu_register_legacy_master(struct device *dev,
 		it.cur_count = 1;
 	}
 
-	err = iommu_fwspec_init(dev, &smmu_dev->of_node->fwnode,
-				&arm_smmu_ops);
-	if (err)
-		return err;
+	cfg = kzalloc(struct_size(cfg, ids, it.cur_count), GFP_KERNEL);
+	if (!cfg)
+		return ERR_PTR(-ENOMEM);
 
-	sids = kcalloc(it.cur_count, sizeof(*sids), GFP_KERNEL);
-	if (!sids)
-		return -ENOMEM;
-
-	*smmu = dev_get_drvdata(smmu_dev);
-	of_phandle_iterator_args(&it, sids, it.cur_count);
-	err = iommu_fwspec_add_ids(dev, sids, it.cur_count);
-	kfree(sids);
-	return err;
+	cfg->num_ids = it.cur_count;
+	cfg->smmu = dev_get_drvdata(smmu_dev);
+	of_phandle_iterator_args(&it, cfg->ids, it.cur_count);
+	return 0;
 }
 #else
-static int arm_smmu_register_legacy_master(struct device *dev,
-					   struct arm_smmu_device **smmu)
+static struct arm_smmu_master_cfg *
+arm_smmu_register_legacy_master(struct device *dev)
 {
-	return -ENODEV;
+	return ERR_PTR(-ENODEV);
 }
 #endif /* CONFIG_ARM_SMMU_LEGACY_DT_BINDINGS */
 
@@ -1019,7 +1015,6 @@ static bool arm_smmu_free_sme(struct arm_smmu_device *smmu, int idx)
 
 static int arm_smmu_master_alloc_smes(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
 	struct arm_smmu_device *smmu = cfg->smmu;
 	struct arm_smmu_smr *smrs = smmu->smrs;
@@ -1027,9 +1022,9 @@ static int arm_smmu_master_alloc_smes(struct device *dev)
 
 	mutex_lock(&smmu->stream_map_mutex);
 	/* Figure out a viable stream map entry allocation */
-	for_each_cfg_sme(cfg, fwspec, i, idx) {
-		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, fwspec->ids[i]);
-		u16 mask = FIELD_GET(ARM_SMMU_SMR_MASK, fwspec->ids[i]);
+	for_each_cfg_sme(cfg, i, idx) {
+		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, cfg->ids[i]);
+		u16 mask = FIELD_GET(ARM_SMMU_SMR_MASK, cfg->ids[i]);
 
 		if (idx != INVALID_SMENDX) {
 			ret = -EEXIST;
@@ -1051,7 +1046,7 @@ static int arm_smmu_master_alloc_smes(struct device *dev)
 	}
 
 	/* It worked! Now, poke the actual hardware */
-	for_each_cfg_sme(cfg, fwspec, i, idx)
+	for_each_cfg_sme(cfg, i, idx)
 		arm_smmu_write_sme(smmu, idx);
 
 	mutex_unlock(&smmu->stream_map_mutex);
@@ -1066,14 +1061,13 @@ static int arm_smmu_master_alloc_smes(struct device *dev)
 	return ret;
 }
 
-static void arm_smmu_master_free_smes(struct arm_smmu_master_cfg *cfg,
-				      struct iommu_fwspec *fwspec)
+static void arm_smmu_master_free_smes(struct arm_smmu_master_cfg *cfg)
 {
 	struct arm_smmu_device *smmu = cfg->smmu;
 	int i, idx;
 
 	mutex_lock(&smmu->stream_map_mutex);
-	for_each_cfg_sme(cfg, fwspec, i, idx) {
+	for_each_cfg_sme(cfg, i, idx) {
 		if (arm_smmu_free_sme(smmu, idx))
 			arm_smmu_write_sme(smmu, idx);
 		cfg->smendx[i] = INVALID_SMENDX;
@@ -1082,8 +1076,7 @@ static void arm_smmu_master_free_smes(struct arm_smmu_master_cfg *cfg,
 }
 
 static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
-				      struct arm_smmu_master_cfg *cfg,
-				      struct iommu_fwspec *fwspec)
+				      struct arm_smmu_master_cfg *cfg)
 {
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s2cr *s2cr = smmu->s2crs;
@@ -1096,7 +1089,7 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 	else
 		type = S2CR_TYPE_TRANS;
 
-	for_each_cfg_sme(cfg, fwspec, i, idx) {
+	for_each_cfg_sme(cfg, i, idx) {
 		if (type == s2cr[idx].type && cbndx == s2cr[idx].cbndx)
 			continue;
 
@@ -1111,24 +1104,10 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct arm_smmu_master_cfg *cfg;
-	struct arm_smmu_device *smmu;
+	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = cfg->smmu;
 	int ret;
 
-	/*
-	 * FIXME: The arch/arm DMA API code tries to attach devices to its own
-	 * domains between of_xlate() and probe_device() - we have no way to cope
-	 * with that, so until ARM gets converted to rely on groups and default
-	 * domains, just say no (but more politely than by dereferencing NULL).
-	 * This should be at least a WARN_ON once that's sorted.
-	 */
-	cfg = dev_iommu_priv_get(dev);
-	if (!cfg)
-		return -ENODEV;
-
-	smmu = cfg->smmu;
-
 	ret = arm_smmu_rpm_get(smmu);
 	if (ret < 0)
 		return ret;
@@ -1148,7 +1127,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	}
 
 	/* Looks ok, so add the device to the domain */
-	ret = arm_smmu_domain_add_master(smmu_domain, cfg, fwspec);
+	ret = arm_smmu_domain_add_master(smmu_domain, cfg);
 
 	/*
 	 * Setup an autosuspend delay to avoid bouncing runpm state.
@@ -1325,59 +1304,85 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 	}
 }
 
-static
-struct arm_smmu_device *arm_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
+static struct arm_smmu_master_cfg *
+arm_smmu_probe_new_master(struct iommu_probe_info *pinf)
 {
-	struct device *dev = driver_find_device_by_fwnode(&arm_smmu_driver.driver,
-							  fwnode);
-	put_device(dev);
-	return dev ? dev_get_drvdata(dev) : NULL;
-}
-
-static struct iommu_device *arm_smmu_probe_device(struct device *dev)
-{
-	struct arm_smmu_device *smmu = NULL;
 	struct arm_smmu_master_cfg *cfg;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	int i, ret;
+	struct arm_smmu_device *smmu;
 
-	if (using_legacy_binding) {
-		ret = arm_smmu_register_legacy_master(dev, &smmu);
+	smmu = iommu_iort_get_single_iommu(pinf, &arm_smmu_ops, NULL,
+					   struct arm_smmu_device, iommu);
+	if (IS_ERR(smmu))
+		return ERR_CAST(smmu);
+
+	if (!pinf->of_master_np) {
+		/* In ACPI mode the smmu uses the usual u32 format */
+		cfg = iommu_fw_alloc_per_device_ids(pinf, cfg);
+		if (IS_ERR(cfg))
+			return cfg;
+		cfg->acpi_fwnode = iommu_fw_acpi_fwnode(pinf);
+	} else {
+		unsigned int num_ids;
+		int ret;
 
 		/*
-		 * If dev->iommu_fwspec is initally NULL, arm_smmu_register_legacy_master()
-		 * will allocate/initialise a new one. Thus we need to update fwspec for
-		 * later use.
+		 * In OF mode it supports several different formats for the arg,
+		 * pass through arm_smmu_of_xlate to extract it.
 		 */
-		fwspec = dev_iommu_fwspec_get(dev);
-		if (ret)
-			goto out_free;
-	} else {
-		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
+		num_ids = iommu_of_num_ids(pinf);
+		cfg = kzalloc(struct_size(cfg, ids, num_ids), GFP_KERNEL);
+		if (!cfg)
+			return ERR_PTR(-ENOMEM);
+
+		ret = iommu_of_xlate(pinf, &arm_smmu_ops, -1,
+				     &arm_smmu_of_xlate, cfg);
+		if (ret) {
+			kfree(cfg);
+			return ERR_PTR(ret);
+		}
 	}
 
+	cfg->smmu = smmu;
+	return cfg;
+}
+
+static struct iommu_device *arm_smmu_probe_device(struct iommu_probe_info *pinf)
+{
+	struct arm_smmu_master_cfg *cfg;
+	struct device *dev = pinf->dev;
+	struct arm_smmu_device *smmu;
+	int i, ret;
+
+	if (using_legacy_binding)
+		cfg = arm_smmu_register_legacy_master(dev);
+	else
+		cfg = arm_smmu_probe_new_master(pinf);
+	if (IS_ERR(cfg))
+		return ERR_CAST(cfg);
+	smmu = cfg->smmu;
+
 	ret = -EINVAL;
-	for (i = 0; i < fwspec->num_ids; i++) {
-		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, fwspec->ids[i]);
-		u16 mask = FIELD_GET(ARM_SMMU_SMR_MASK, fwspec->ids[i]);
+	for (i = 0; i < cfg->num_ids; i++) {
+		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, cfg->ids[i]);
+		u16 mask = FIELD_GET(ARM_SMMU_SMR_MASK, cfg->ids[i]);
 
 		if (sid & ~smmu->streamid_mask) {
 			dev_err(dev, "stream ID 0x%x out of range for SMMU (0x%x)\n",
 				sid, smmu->streamid_mask);
-			goto out_free;
+			goto out_cfg_free;
 		}
 		if (mask & ~smmu->smr_mask_mask) {
 			dev_err(dev, "SMR mask 0x%x out of range for SMMU (0x%x)\n",
 				mask, smmu->smr_mask_mask);
-			goto out_free;
+			goto out_cfg_free;
 		}
 	}
 
 	ret = -ENOMEM;
-	cfg = kzalloc(offsetof(struct arm_smmu_master_cfg, smendx[i]),
-		      GFP_KERNEL);
+	cfg->smendx = kzalloc(array_size(sizeof(*cfg->smendx), cfg->num_ids),
+			      GFP_KERNEL);
 	if (!cfg)
-		goto out_free;
+		goto out_cfg_free;
 
 	cfg->smmu = smmu;
 	dev_iommu_priv_set(dev, cfg);
@@ -1400,15 +1405,13 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	return &smmu->iommu;
 
 out_cfg_free:
+	kfree(cfg->smendx);
 	kfree(cfg);
-out_free:
-	iommu_fwspec_free(dev);
 	return ERR_PTR(ret);
 }
 
 static void arm_smmu_release_device(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
 	int ret;
 
@@ -1416,10 +1419,11 @@ static void arm_smmu_release_device(struct device *dev)
 	if (ret < 0)
 		return;
 
-	arm_smmu_master_free_smes(cfg, fwspec);
+	arm_smmu_master_free_smes(cfg);
 
 	arm_smmu_rpm_put(cfg->smmu);
 
+	kfree(cfg->smendx);
 	kfree(cfg);
 }
 
@@ -1438,13 +1442,12 @@ static void arm_smmu_probe_finalize(struct device *dev)
 static struct iommu_group *arm_smmu_device_group(struct device *dev)
 {
 	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_device *smmu = cfg->smmu;
 	struct iommu_group *group = NULL;
 	int i, idx;
 
 	mutex_lock(&smmu->stream_map_mutex);
-	for_each_cfg_sme(cfg, fwspec, i, idx) {
+	for_each_cfg_sme(cfg, i, idx) {
 		if (group && smmu->s2crs[idx].group &&
 		    group != smmu->s2crs[idx].group) {
 			mutex_unlock(&smmu->stream_map_mutex);
@@ -1468,7 +1471,7 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 
 	/* Remember group for faster lookups */
 	if (!IS_ERR(group))
-		for_each_cfg_sme(cfg, fwspec, i, idx)
+		for_each_cfg_sme(cfg, i, idx)
 			smmu->s2crs[idx].group = group;
 
 	mutex_unlock(&smmu->stream_map_mutex);
@@ -1506,8 +1509,10 @@ static int arm_smmu_set_pgtable_quirks(struct iommu_domain *domain,
 	return ret;
 }
 
-static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
+static int arm_smmu_of_xlate(struct iommu_device *iommu,
+			     struct of_phandle_args *args, void *priv)
 {
+	struct arm_smmu_master_cfg *cfg = priv;
 	u32 mask, fwid = 0;
 
 	if (args->args_count > 0)
@@ -1517,13 +1522,14 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 		fwid |= FIELD_PREP(ARM_SMMU_SMR_MASK, args->args[1]);
 	else if (!of_property_read_u32(args->np, "stream-match-mask", &mask))
 		fwid |= FIELD_PREP(ARM_SMMU_SMR_MASK, mask);
-
-	return iommu_fwspec_add_ids(dev, &fwid, 1);
+	cfg->ids[cfg->num_ids++] = fwid;
+	return 0;
 }
 
 static void arm_smmu_get_resv_regions(struct device *dev,
 				      struct list_head *head)
 {
+	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
 	struct iommu_resv_region *region;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
@@ -1534,7 +1540,10 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 
 	list_add_tail(&region->list, head);
 
-	iommu_dma_get_resv_regions(dev, head);
+	if (cfg->acpi_fwnode)
+		iort_iommu_get_resv_regions(dev, head, cfg->acpi_fwnode,
+					    cfg->ids, cfg->num_ids);
+	of_iommu_get_resv_regions(dev, head);
 }
 
 static int arm_smmu_def_domain_type(struct device *dev)
@@ -1553,22 +1562,22 @@ static int arm_smmu_def_domain_type(struct device *dev)
 
 static bool arm_smmu_get_stream_id(struct device *dev, u32 *stream_id)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
 
-	if (fwspec->num_ids != 1)
+	if (cfg->num_ids != 1)
 		return false;
-	*stream_id = fwspec->ids[0] & 0xffff;
+	*stream_id = cfg->ids[0] & 0xffff;
 	return true;
 }
 
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
-	.probe_device		= arm_smmu_probe_device,
+	.probe_device_pinf	= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.probe_finalize		= arm_smmu_probe_finalize,
 	.device_group		= arm_smmu_device_group,
-	.of_xlate		= arm_smmu_of_xlate,
+	.of_xlate		= iommu_dummy_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.def_domain_type	= arm_smmu_def_domain_type,
 	.tegra_dev_iommu_get_stream_id = arm_smmu_get_stream_id,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 703fd5817ec11f..ba8224751fdcdc 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -378,7 +378,10 @@ struct arm_smmu_domain {
 
 struct arm_smmu_master_cfg {
 	struct arm_smmu_device		*smmu;
-	s16				smendx[];
+	struct fwnode_handle		*acpi_fwnode;
+	s16				*smendx;
+	unsigned int			num_ids;
+	u32				ids[] __counted_by(num_ids);
 };
 
 static inline u32 arm_smmu_lpae_tcr(const struct io_pgtable_cfg *cfg)
@@ -446,10 +449,10 @@ struct arm_smmu_impl {
 };
 
 #define INVALID_SMENDX			-1
-#define cfg_smendx(cfg, fw, i) \
-	(i >= fw->num_ids ? INVALID_SMENDX : cfg->smendx[i])
-#define for_each_cfg_sme(cfg, fw, i, idx) \
-	for (i = 0; idx = cfg_smendx(cfg, fw, i), i < fw->num_ids; ++i)
+#define cfg_smendx(cfg, i) \
+	(i >= cfg->num_ids ? INVALID_SMENDX : cfg->smendx[i])
+#define for_each_cfg_sme(cfg, i, idx) \
+	for (i = 0; idx = cfg_smendx(cfg, i), i < cfg->num_ids; ++i)
 
 static inline int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end)
 {
-- 
2.42.0

