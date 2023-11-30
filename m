Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60530524C;
	Thu, 30 Nov 2023 01:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bd99mn5b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5UlDiumIGYtexoWIsDMdTlUoeRIborfTnomVk2kEKEw8iD4Hlqkj2JeZxbjmdZOg2anP6Qh8+NTewPCbxQKc65GP9R5NGUH2C1uYMsI1Nbto4jfoarxR0v6/4Sl8DrDOk+0VkWM/0wT8i6HseKtHimHQvgEHyzFlhw11Afl0r7oNL2HeYybCCh01eJL45shsp/TofL7vtS5fqzh4Hd6DR8geLD040aPW7ejyEKred6b0MebGNvb0D7NABQ92z4WNLSqVFL8KtEisYnu9ML5K2rzzSN1xVW1eZV4QfV/Kx2zDkbxMqweN+iBhXyCDkT7oHJFhCx125Kp0E+408qn5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmT9sPIBC3zysKQfnRxRs9D8QedigHbyG5FAziwg6D8=;
 b=j7PId9ykZKEruzhBjVC3hf6dUV/XD0bTQm2wCcsMxkOwLmNpFCD4SFlO1byJJ65iHJfoKVsdQXUz04AfVqqCuZ7E3CLSig6Hxl8cknrcgeaT+BueHdNzYDTW9aiovdmd3bDT1LJcoY7ibcX8cHBv5ehYPD7FDw+w4LqRM8DfNJyECYlHqK8sOjk/RrrUgrRwS+DjzQmBB1IytssBMegke4sFq2npIPOex8GtYPWQ6jnz2d7eFcDTif8gicjSWTe+9wTS2kix+YpbIYtT4mbchS1ApwKpiJI803vcM/L615Uomh7zbKHdDXkjMJGQfnJBDbT/962L5KN4Z4ycoEI8lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmT9sPIBC3zysKQfnRxRs9D8QedigHbyG5FAziwg6D8=;
 b=bd99mn5b6MxfI1gFhMe9fnqJTxPJ0LyoUTyVlLNyZQR4MLKrw6kcyZhy3AI5m/QTAxxHISQ0IzsmHcZ/l8T6SEeHmgRwVK25WB7PqbsXLYOUfXjTzGwkePVrqPVTJ60GZ3Bde84AQSkNuvGhrq0WS74DexqZoDkuhFyvwNkTYgPuRLR46CoeiL+LSfYgLxku66+lOeCY7TXllHB3DFVzwlxQDpKgYeZZwSiVkj9pr2iByLdI46nFq0U6PnU1LBl/6aQ77FlFJU5wrgbauWLY58WbfiyxJ1I1ZQK8TBgSyqhSPM4QTsZbe1Ybkegj4DUykTykM7Z0bWlEDZTVuzpjnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 01:14:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:42 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 21/30] iommu/mtk_v1: Move to iommu_fw_alloc_per_device_ids()
Date: Wed, 29 Nov 2023 21:14:21 -0400
Message-ID: <21-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:806:20::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 215dbba5-29d9-4a71-aead-08dbf141b70e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LM292Wa3/DMbgktaeAxGDAZvYDk5ouYkXNyVl8YNQghVf4iJ/58mKPiOk5ccaGoDw+Q5HAgzZ5v5PD3+UQOxG1Mx6H6SXilZaEMFn5MCQ+UQANIJELrtwXJaxBYFgUxNUpLscmwurZ1Xmd2Utez7H0rPapj0HxU5Bb8/YBSqcRKlFesxNBKFs7h9bAaZe7RN6HP5wWGt4URy0qq2CI53fzLYAVW51quZU6x3kuEw8aZZIIPEzF9Fu6Gq+Z/SE0Ll1/SERuB/vWt0hmeNJKsjZfSfor+fijHdFjTUrgNFCw15jvm5FM8Yx9mjauwgoJSnhaGorcwQGUnzx9iRKxyMA2AKZZiB82daRjTLvhzAiL/c8ETiw+0dH2r1lzBaRwAMhqGa+bLwWJM43qeJArwWIBvyJt2G9uM0SoL4Ev0iIw1YsDJinepSrulx8cNTVh94yFlb6DwpSwOvuv/u9E6zsQI+LVCitirQ3e76Z52kEaxf3gEr+oy4jkmsoq/VWdQ91t45BuCAqxZuJkoLcTtYVjKL4wpneWYzYbFTBB3CbdRc7wiNPBIbhHChDUrlpsUXSyYihDqgzJjGVhJmT8/BVGGb8UPNwqueqHLHhs4vSew=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(109986022)(451199024)(6486002)(4326008)(478600001)(8676002)(86362001)(5660300002)(8936002)(54906003)(66476007)(66556008)(66946007)(6506007)(2906002)(316002)(6666004)(6512007)(36756003)(26005)(2616005)(83380400001)(41300700001)(38100700002)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eWL1CD8AEOs6G/VjKFJqK1d2Wd2FiTskEazK8BIiE9UBbIJJ3IxSW5ghJSzE?=
 =?us-ascii?Q?j4GmJVJ1CWTbE5mG9aqtrjxJ4vMuYFUz4P3ws4Bvn50LtCV2kIpv4ObLlu5l?=
 =?us-ascii?Q?RDw0iC5lM0/3n1UQbPMojwweT6TObg4+3pyABe6S/plVRGit/zv2Wi3p/KmB?=
 =?us-ascii?Q?A0fb7PBhpsHCsXtQMYiLR8pIcJxk5YDdvMzHN2aETdqmRCHWOQdqf4UGG6I5?=
 =?us-ascii?Q?FKBf3RMOFcoBWCRpnQqbT6QygvcM6qLeEyw/sQ82I+JbHFxlwQLRvJ60BaFv?=
 =?us-ascii?Q?qDkytqE8erjaIBJcvm3oVMG2oU4ECjCJayFOKZ/8Oj8G5mg6LWqz65tJFPo8?=
 =?us-ascii?Q?MdjjMTvAsCn/3QI2ZvzRlEl67TbPq5hUnj9RyGZU9ybUe/BSU45ZOS/fqGtZ?=
 =?us-ascii?Q?ie/nINXV0RjfrOgBtcXwNAS+PL5PhOTY+bfUq5fstHMEr+jKMMvJwjlemZ2k?=
 =?us-ascii?Q?E2rCFr0c7cmwITtlkQs/kGnkspVRhUa5pKDFJY6IodKaqQVd6EVrDqP4rrbi?=
 =?us-ascii?Q?XJofpyi/semcPG1xjBfY71V1QaHsyaRyJSwWWR1lknKXAZYv4rBlOxexN5o4?=
 =?us-ascii?Q?wTHSb6TLzrBk/HxxvUyLCg1YnPFWaWiOHbLjVLMDwTq4WGfDqIxawQbKBaiA?=
 =?us-ascii?Q?ER+PBU2PJrHIgYulNalvmm2Q1Pxl+UIVYnKKSNjH3055ZgopFYkpVY46OZNf?=
 =?us-ascii?Q?OIigePUPu/fgOq7ItA0H1+a8qtioKrrvYGlHi0QnSyZStHm2sTGqA1yv45AI?=
 =?us-ascii?Q?NNhcIBZ4wXBGmp+1B3Nv7SonTBUQHWbtvddRDQYsKGxk3becraF7bCcElcHA?=
 =?us-ascii?Q?dgDCHIYlrHStyx1/V/ZMaIfnL7+PRxctAkH5SMeDl0lvl28mh/wRxZ//3+KS?=
 =?us-ascii?Q?Jhqmi6rdfWkOvfnFBotC06K2uBpWT7LaobjNi5VfF5yukWB9brRZ4SG0eF/6?=
 =?us-ascii?Q?tOWW7cBwwX7YLkv2KjSd/k9KE4UTbNNUvfTlnd1GMqh8sIzJUjnv9rPazC1T?=
 =?us-ascii?Q?SxVb1Hl2vIvp1qrihI6w8kKPzYpYJ8WhIBje9h/7H3F1fan7QU5xEGCV6Asp?=
 =?us-ascii?Q?oynbSMs6yVJaXxXfUJVV/5al2u37B8mN7VTZePFaUitCq6fipyhWnqRRHC/w?=
 =?us-ascii?Q?dd8z1kwNj3dW6xvRQOs3MWY+ckdPmOAnrV5kuTTMEcW3oQi463uFfRGxe34O?=
 =?us-ascii?Q?AqqC1OJpOFjKcohYEzEHh4ZVuOF2xx+HJUArI3oqRZVEbR9TyuNIhnfGgKfb?=
 =?us-ascii?Q?qZWiY1JXBJUHn2IG2o8js2LJ6Gnmf2ljube81LtD4v1T3nvr/BpxVGRceXP9?=
 =?us-ascii?Q?77lZyV18U/9uE5vBBMMpz/lv3cwTWCl8tdxl0iwmahtWKyEHfyfgCvXMZXXL?=
 =?us-ascii?Q?H7x4vQd9MsbRVD9hOf/DlTjOnb6V3NAjbp7aGBJbGFvVClvF4JOj7yt9OGhO?=
 =?us-ascii?Q?oF4PryJ7dgfQd5FBcTheSBswJOwMKb+ZIxJcFrkhDjTE8AbIFaaWmIY883k8?=
 =?us-ascii?Q?UdBZficG5G6J4AmlEJCbWyWmm0JeeZF21nJjbpMFYSNGyZ+LSO0FTULINpdY?=
 =?us-ascii?Q?ryYdA5r5EPrO69O0qaknbGEABPFROi5uSwroighH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 215dbba5-29d9-4a71-aead-08dbf141b70e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:35.1170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RcJAVqaUKEFU0k/jKzuvrhC2Mq11Hb222p1bmYPZ7tLFBymwxROTYNV7Bbh+AHoU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

mtk_v1 supports a single iommu instance with multiple ids.

It open codes the fwspec parse inside the driver, remove all of this and
just call iommu_of_get_single_iommu() to do the same parsing. Using
iommu_of_allow_bus_probe() so this continues to work at bus probe time.

Introduce a per-device data to store the iommu and ids list. Allocate and
initialize it with iommu_fw_alloc_per_device_ids(). Fold
mtk_iommu_v1_create_mapping() into mtk_iommu_v1_probe_device() as it is
done only once per device.

Fix the error handling so we don't leak mappings on error paths.

Convert the rest of the funcs from calling dev_iommu_fwspec_get() to using
the per-device data and remove all use of fwspec.

Convert the places using dev_iommu_priv_get() to use the per-device data
not the iommu.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/mtk_iommu_v1.c | 162 +++++++++++++++--------------------
 1 file changed, 67 insertions(+), 95 deletions(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 25b41222abaec1..82f500a1ad74e9 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/iopoll.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -108,6 +109,12 @@ struct mtk_iommu_v1_data {
 	struct mtk_iommu_v1_suspend_reg	reg;
 };
 
+struct mtk_iommu_v1_device {
+	struct mtk_iommu_v1_data *iommu;
+	unsigned int num_ids;
+	u32 ids[] __counted_by(num_ids);
+};
+
 struct mtk_iommu_v1_domain {
 	spinlock_t			pgtlock; /* lock for page table */
 	struct iommu_domain		domain;
@@ -232,14 +239,14 @@ static irqreturn_t mtk_iommu_v1_isr(int irq, void *dev_id)
 static void mtk_iommu_v1_config(struct mtk_iommu_v1_data *data,
 				struct device *dev, bool enable)
 {
+	struct mtk_iommu_v1_device *mdev = dev_iommu_priv_get(dev);
 	struct mtk_smi_larb_iommu    *larb_mmu;
 	unsigned int                 larbid, portid;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	int i;
 
-	for (i = 0; i < fwspec->num_ids; ++i) {
-		larbid = mt2701_m4u_to_larb(fwspec->ids[i]);
-		portid = mt2701_m4u_to_port(fwspec->ids[i]);
+	for (i = 0; i < mdev->num_ids; ++i) {
+		larbid = mt2701_m4u_to_larb(mdev->ids[i]);
+		portid = mt2701_m4u_to_port(mdev->ids[i]);
 		larb_mmu = &data->larb_imu[larbid];
 
 		dev_dbg(dev, "%s iommu port: %d\n",
@@ -293,7 +300,8 @@ static void mtk_iommu_v1_domain_free(struct iommu_domain *domain)
 
 static int mtk_iommu_v1_attach_device(struct iommu_domain *domain, struct device *dev)
 {
-	struct mtk_iommu_v1_data *data = dev_iommu_priv_get(dev);
+	struct mtk_iommu_v1_device *mdev = dev_iommu_priv_get(dev);
+	struct mtk_iommu_v1_data *data = mdev->iommu;
 	struct mtk_iommu_v1_domain *dom = to_mtk_domain(domain);
 	struct dma_iommu_mapping *mtk_mapping;
 	int ret;
@@ -319,7 +327,8 @@ static int mtk_iommu_v1_attach_device(struct iommu_domain *domain, struct device
 static int mtk_iommu_v1_identity_attach(struct iommu_domain *identity_domain,
 					struct device *dev)
 {
-	struct mtk_iommu_v1_data *data = dev_iommu_priv_get(dev);
+	struct mtk_iommu_v1_device *mdev = dev_iommu_priv_get(dev);
+	struct mtk_iommu_v1_data *data = mdev->iommu;
 
 	mtk_iommu_v1_config(data, dev, false);
 	return 0;
@@ -394,128 +403,91 @@ static phys_addr_t mtk_iommu_v1_iova_to_phys(struct iommu_domain *domain, dma_ad
 
 static const struct iommu_ops mtk_iommu_v1_ops;
 
-/*
- * MTK generation one iommu HW only support one iommu domain, and all the client
- * sharing the same iova address space.
- */
-static int mtk_iommu_v1_create_mapping(struct device *dev, struct of_phandle_args *args)
+static struct iommu_device *
+mtk_iommu_v1_probe_device(struct iommu_probe_info *pinf)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct mtk_iommu_v1_data *data;
-	struct platform_device *m4updev;
 	struct dma_iommu_mapping *mtk_mapping;
+	struct mtk_iommu_v1_device *mdev;
+	struct device *dev = pinf->dev;
+	struct mtk_iommu_v1_data *data;
+	int idx, larbid, larbidx;
+	struct device_link *link;
+	struct device *larbdev;
 	int ret;
 
-	if (args->args_count != 1) {
-		dev_err(dev, "invalid #iommu-cells(%d) property for IOMMU\n",
-			args->args_count);
-		return -EINVAL;
-	}
+	iommu_of_allow_bus_probe(pinf);
+	data = iommu_of_get_single_iommu(pinf, &mtk_iommu_v1_ops, 1,
+					 struct mtk_iommu_v1_data, iommu);
+	if (IS_ERR(data))
+		return ERR_CAST(data);
 
-	if (!fwspec) {
-		ret = iommu_fwspec_init(dev, &args->np->fwnode, &mtk_iommu_v1_ops);
-		if (ret)
-			return ret;
-		fwspec = dev_iommu_fwspec_get(dev);
-	} else if (dev_iommu_fwspec_get(dev)->ops != &mtk_iommu_v1_ops) {
-		return -EINVAL;
-	}
+	mdev = iommu_fw_alloc_per_device_ids(pinf, mdev);
+	if (IS_ERR(mdev))
+		return ERR_CAST(mdev);
+	mdev->iommu = data;
 
-	if (!dev_iommu_priv_get(dev)) {
-		/* Get the m4u device */
-		m4updev = of_find_device_by_node(args->np);
-		if (WARN_ON(!m4updev))
-			return -EINVAL;
-
-		dev_iommu_priv_set(dev, platform_get_drvdata(m4updev));
-	}
-
-	ret = iommu_fwspec_add_ids(dev, args->args, 1);
-	if (ret)
-		return ret;
-
-	data = dev_iommu_priv_get(dev);
+	/*
+	 * MTK generation one iommu HW only support one iommu domain, and all
+	 * the client sharing the same iova address space.
+	 */
 	mtk_mapping = data->mapping;
 	if (!mtk_mapping) {
 		/* MTK iommu support 4GB iova address space. */
 		mtk_mapping = arm_iommu_create_mapping(&platform_bus_type,
 						0, 1ULL << 32);
-		if (IS_ERR(mtk_mapping))
-			return PTR_ERR(mtk_mapping);
+		if (IS_ERR(mtk_mapping)) {
+			ret = PTR_ERR(mtk_mapping);
+			goto err_free;
+		}
 
 		data->mapping = mtk_mapping;
 	}
 
-	return 0;
-}
-
-static struct iommu_device *mtk_iommu_v1_probe_device(struct device *dev)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct of_phandle_args iommu_spec;
-	struct mtk_iommu_v1_data *data;
-	int err, idx = 0, larbid, larbidx;
-	struct device_link *link;
-	struct device *larbdev;
-
-	/*
-	 * In the deferred case, free the existed fwspec.
-	 * Always initialize the fwspec internally.
-	 */
-	if (fwspec) {
-		iommu_fwspec_free(dev);
-		fwspec = dev_iommu_fwspec_get(dev);
-	}
-
-	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
-					   "#iommu-cells",
-					   idx, &iommu_spec)) {
-
-		err = mtk_iommu_v1_create_mapping(dev, &iommu_spec);
-		of_node_put(iommu_spec.np);
-		if (err)
-			return ERR_PTR(err);
-
-		/* dev->iommu_fwspec might have changed */
-		fwspec = dev_iommu_fwspec_get(dev);
-		idx++;
-	}
-
-	data = dev_iommu_priv_get(dev);
-
 	/* Link the consumer device with the smi-larb device(supplier) */
-	larbid = mt2701_m4u_to_larb(fwspec->ids[0]);
-	if (larbid >= MT2701_LARB_NR_MAX)
-		return ERR_PTR(-EINVAL);
+	larbid = mt2701_m4u_to_larb(mdev->ids[0]);
+	if (larbid >= MT2701_LARB_NR_MAX) {
+		ret = -EINVAL;
+		goto err_mapping;
+	}
 
-	for (idx = 1; idx < fwspec->num_ids; idx++) {
-		larbidx = mt2701_m4u_to_larb(fwspec->ids[idx]);
+	for (idx = 1; idx < mdev->num_ids; idx++) {
+		larbidx = mt2701_m4u_to_larb(mdev->ids[idx]);
 		if (larbid != larbidx) {
 			dev_err(dev, "Can only use one larb. Fail@larb%d-%d.\n",
 				larbid, larbidx);
-			return ERR_PTR(-EINVAL);
+			ret = -EINVAL;
+			goto err_mapping;
 		}
 	}
 
 	larbdev = data->larb_imu[larbid].dev;
-	if (!larbdev)
-		return ERR_PTR(-EINVAL);
+	if (!larbdev) {
+		ret = -EINVAL;
+		goto err_mapping;
+	}
 
 	link = device_link_add(dev, larbdev,
 			       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
 	if (!link)
 		dev_err(dev, "Unable to link %s\n", dev_name(larbdev));
 
+	dev_iommu_priv_set(pinf->dev, mdev);
 	return &data->iommu;
+
+err_mapping:
+	arm_iommu_release_mapping(mtk_mapping);
+err_free:
+	kfree(mdev);
+	return ERR_PTR(ret);
 }
 
 static void mtk_iommu_v1_probe_finalize(struct device *dev)
 {
+	struct mtk_iommu_v1_device *mdev = dev_iommu_priv_get(dev);
+	struct mtk_iommu_v1_data *data = mdev->iommu;
 	struct dma_iommu_mapping *mtk_mapping;
-	struct mtk_iommu_v1_data *data;
 	int err;
 
-	data        = dev_iommu_priv_get(dev);
 	mtk_mapping = data->mapping;
 
 	err = arm_iommu_attach_device(dev, mtk_mapping);
@@ -525,15 +497,15 @@ static void mtk_iommu_v1_probe_finalize(struct device *dev)
 
 static void mtk_iommu_v1_release_device(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct mtk_iommu_v1_data *data;
+	struct mtk_iommu_v1_device *mdev = dev_iommu_priv_get(dev);
+	struct mtk_iommu_v1_data *data = mdev->iommu;
 	struct device *larbdev;
 	unsigned int larbid;
 
-	data = dev_iommu_priv_get(dev);
-	larbid = mt2701_m4u_to_larb(fwspec->ids[0]);
+	larbid = mt2701_m4u_to_larb(mdev->ids[0]);
 	larbdev = data->larb_imu[larbid].dev;
 	device_link_remove(dev, larbdev);
+	kfree(mdev);
 }
 
 static int mtk_iommu_v1_hw_init(const struct mtk_iommu_v1_data *data)
@@ -580,7 +552,7 @@ static int mtk_iommu_v1_hw_init(const struct mtk_iommu_v1_data *data)
 static const struct iommu_ops mtk_iommu_v1_ops = {
 	.identity_domain = &mtk_iommu_v1_identity_domain,
 	.domain_alloc_paging = mtk_iommu_v1_domain_alloc_paging,
-	.probe_device	= mtk_iommu_v1_probe_device,
+	.probe_device_pinf = mtk_iommu_v1_probe_device,
 	.probe_finalize = mtk_iommu_v1_probe_finalize,
 	.release_device	= mtk_iommu_v1_release_device,
 	.device_group	= generic_device_group,
-- 
2.42.0

