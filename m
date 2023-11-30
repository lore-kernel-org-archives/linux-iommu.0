Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A803C64E;
	Thu, 30 Nov 2023 01:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AQ7AXsVb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agm/UeGKbgE1X25aohfwiONqVh1pxxaiK4DiHXEC919tN0Buuzo62mokhdOWBbXMFNwjA6Wad/3MuBEy6JIpzcbtCfyD6eGZK0wMN8Crp4C/zATmnStSVg/T1HMVhyQL8yEgJEyaAEpg397i8mExMmeoQr3uirsd9fkcMld4xi3tAOxqzOf1+9x7Cce717g9xuGkywf27hcLHzS012fIgyWBqo2HEXTbsDMPZI+C1sZzsXjpjLKjLSZT+5quKr4ZOKO7awANiS7LXjuni4JOat6YI1ATCwe1yYDJLj3TcvIyTcpCJ5NscnkP8D4vQqPP5A0ER1kqFOMarRB8sO+veQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNc0i8b19f67qGg7jaCMO7gIkmzVDan6cC8FlSSYH2o=;
 b=IZCpYaNNaOQKx6nLRaLHU1Ut3IdsYppIm1ieCBUbiyovY96xb7v0WtlppSmmf3yzRClRhp/cheqw9Dep/drnfcuXSKe5hbapoakEJdmUAJiu1GHqNXlhCcV6Bk4XnjXH+6jWHdJ8TBj/8QTIszpRF9RBJKjE69kQw1q8ozCwCKGuF72URlTs2JcrV/H4jpJAm0igxQ8/zk38EPPJEiDIu7j2SbFdW5xd0icnHV3AU78ZlZNy+NRhLK/w2M2Xvhsv9zNlJ2C5pBmJxuD0ohZL+ekBx5LcTaQVvHIL/8HolCllVmSWKRwoOWggs9JOYE4SOYRQWZh6Q/7twRAcxBT6IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNc0i8b19f67qGg7jaCMO7gIkmzVDan6cC8FlSSYH2o=;
 b=AQ7AXsVbQSxaSE3hVDFmh9GeEmPsT0uA+XpCuYGrIpkOBe6FeQRldlO4UM3MFCivr0VBc+s13vesTVOQp4OkGxiVZh17EE7chdN+6R/9cUbLCD3EtV1xaaYohpdPzUpyndgHpEQkH5Nr8+1ca97ETixexOD5EvInb097OSZh8pDBHPU246izf+fcxG9pSShfPAOLuk1ConbkAVSyua8SRzXgwOI2xQkv/5xiaxmL8pWQ3ACXtsI5jAMw1+M4qxkPgU9Bc7/5dqfsC2LMj6elpoDpYEdaW+8Gfxs4yrov4yNjxfudnrryG55jyUOMuq/vd4xn+XEo6oWP9mmvG7Tn+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 01:15:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:15:13 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 19/30] iommu/mtk: Move to iommu_fw_alloc_per_device_ids()
Date: Wed, 29 Nov 2023 21:14:19 -0400
Message-ID: <19-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:806:20::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: 71afc6c5-c3e7-4e56-f984-08dbf141b76d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/NjCxi3nAmKErZLZDZILhNu02oegscxQ7f8H9oq9OplNttq5mfd17lbWlnXZPl6FjXJsIlYMeWuGbjuzIQP+XWPKJk2U8TcOHYX5jmjaKOqvnLztfzYoVZaiLAERChIrtjQF/K3v/Lau6cYRiZ5F4u2rNsY3ZGZ3YGaSVdkR2Q2URWPwD0ECOxCDG6ti/JXpBdf4hWvQwTVAa/2f5U3Gr6r05eeTfx48TZQY3NXR00EQTE2d+9yXR0m1lrr48ILZbvo7btIbCX7sHWlm8UWt76qzg/h77udJVPtkuRhli2ClVHJhnwN+KgUkZwJRqBCrjsjfsHNVow4+ObgjkXFB9j4swrzEPJTXRuv3ZPYlEsw0fTiUmddSS2T+tWfHFuuJOX13kI2ujvUpDT596y2BvAQj5V8AOiwnQ6bEZTEaus/6OxUOcXnxOWmD1dGB/amWnJyWV324yIobjyObqn2hm04Gc2nSj4e4tsX8aHU6GDpfqiI7XnnMEGEnk2cn9nSIKOy3BC1pXUoI5Q4zJh8sv7/bWKfUrFFTNIUHv1tk7w3APRnIycpILckxYep9yTAPfLBTYF+YLhJ8/IEKnl+OKVisJhRn4zbVfFxT7CKaNGU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(109986022)(26005)(83380400001)(6506007)(2616005)(6512007)(5660300002)(4326008)(8676002)(8936002)(41300700001)(30864003)(2906002)(6486002)(478600001)(316002)(54906003)(66476007)(66556008)(66946007)(86362001)(36756003)(38100700002)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Rd+txvqRU0Gz1eeGtnqNf8ojjeGtwAEg5CEsoD6zPxcY1js96HwV1SeSnFp?=
 =?us-ascii?Q?hRDZgDDDczR2JHoUB1A2qisHZdux+G8IDdK2eeQx4zFh2q20h6kbA1TMqLpl?=
 =?us-ascii?Q?VuuOclF7BVct3cMbqSwRkeqyghHWonqc1a3wPP1biuWOabKPO3ZbWQBNPOFP?=
 =?us-ascii?Q?DaAe0VLXuhuiUqPeG+sOYscSOsTQ/TiRafPBxjGj064A1L3hl1+sfgMLY18U?=
 =?us-ascii?Q?aJfSi5b+H7Q3jh+U2K8sAHePFc9IBICB+N7MdNwQjRP+/Qu3ZIS7EHNMzSoF?=
 =?us-ascii?Q?ajFNPg3m4MOQL4IyxMEducP8VU/O+ggHWv/d3+Wnd2Bvo3TjxRX0hwduB6mE?=
 =?us-ascii?Q?mp6RU8D0JqPuNXltLL3PWDb1zurIZHqAuiENgz/Qdn+AZwyfHiFOsEBFnuiQ?=
 =?us-ascii?Q?sar84KUFrF8pHAh7H3hN/n4TwY6Eo5+1Ot+QkF3Lv4hG65ONMgOPEJXZV7vn?=
 =?us-ascii?Q?ruW0Nl9ItIOoCrKhKZm0TXddQS4Fd9zqOkno57toKd/9DTpnuDJJOovqGfiC?=
 =?us-ascii?Q?c2VHQUZKNLfmpZfRM10h6h2T1L4B42pO3IDuZ5d3PP/qIiyA1RwD6tvWFFOt?=
 =?us-ascii?Q?DMu3+hF6vT+nnqqYMlxZlZSSzEDwG3yA+RYSXjClhFys4rJTSjT1vxsBPAcW?=
 =?us-ascii?Q?AVVw0DyxkFv058WSdxj54ZgciHmeAE8j6fLXlJcE4pNzNkNFKXzWxrrYczC8?=
 =?us-ascii?Q?+8ecsSHM8aoozGQKnFQGVqOW7pVnFYvuRnonR3VspdVw6nU2sZrnY8NsLibT?=
 =?us-ascii?Q?xt//mNPpzTxguf2sG/xoADIFrrF80m938cPdcOXsDzsPdX4iLwufQwaOinTh?=
 =?us-ascii?Q?RUS/sVk7T6p9wERJihAvQk2DMHnw2l+ol0azA6Y8ShxOMX2ndLVl7UvrWSHr?=
 =?us-ascii?Q?1kE0rMsTHkCqtYaxZf2eYpJGLrYJV7fPck9ohtdV8UbDaA2KmcurWe7AVA9e?=
 =?us-ascii?Q?Tth3ZieOsO5P1uSkU2SrkLfT59RX2cI3AYo8jlOW26saBGwKsKd400hjAfyV?=
 =?us-ascii?Q?aCmdFyme50XwZi9y1xe9tz0jnZ64x0/SjRDUMt9mHfwonjZhiOcD8KL2SivY?=
 =?us-ascii?Q?oEeYaytrFRLm9UTM97yw54LbsSm5QRU0eFsIVi3mBAbYojtOS9o4Kur4DNrf?=
 =?us-ascii?Q?hU5g+kNq1rmHX+Ual+C0RST6nH25QszoL0/ecHMCW0B0/vdyZDZJQXHtvIly?=
 =?us-ascii?Q?oc8LqgD44HSvXTkdC1XDdSYKnmPQ8YnA23buCdWNkKiOebZ5pC61I/TM+2OW?=
 =?us-ascii?Q?qPeYYXkwyfF/W5aBB/wPMbXPvEWeipdkZ5UVsDZZga0l2uNxGihUBj4blaJp?=
 =?us-ascii?Q?JLXLBQyi7fM1/UgiKa5teyckmVp10L5/FxOlRauriAvWJo5DkbKi+z281Apk?=
 =?us-ascii?Q?jXTZgOMIABfA3Hy87jexIIhOPkY3SjCORB3ahg5Nt7h8aEYX6XFanY7oK/CR?=
 =?us-ascii?Q?lP0kQ7MhwlE73ib0F6S7YtHLlCdxCvUFYn8Kw6P39r9WgGVxr2FJylE4oqLZ?=
 =?us-ascii?Q?85TM7OS2cDJVFhg+6VFrKLlcSJbPnogetymjhSnHnNQamAyRlaMxgdr0a6gv?=
 =?us-ascii?Q?SJ2JsnJ8BNz35decnr2PQPeccMDq0cg0Ti1/yjo2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71afc6c5-c3e7-4e56-f984-08dbf141b76d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:35.7165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmHrZezDST04Q2KJAVy5DDb5usMJXj3laorvn+U7Ht2qNKSUui/H1ZBCfO3StLZS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189

mtk was doing a lot of stuff under of_xlate, and it looked kind of like it
might support multi-instances. But the dt files don't do that, and the
driver has no way to keep track of which instance the ids are for.

Enforce single instance with iommu_of_get_single_iommu().

Introduce a per-device data to store the iommu and ids list. Allocate and
initialize it with iommu_fw_alloc_per_device_ids(). Remove
mtk_iommu_of_xlate().

Convert the rest of the funcs from calling dev_iommu_fwspec_get() to using
the per-device data and remove all use of fwspec.

Covnert the places using dev_iommu_priv_get() to use the per-device data
not the iommu.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/mtk_iommu.c | 116 ++++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 54 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 7abe9e85a57063..477171e83eaa6e 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/iopoll.h>
 #include <linux/io-pgtable.h>
 #include <linux/list.h>
@@ -277,6 +278,12 @@ struct mtk_iommu_data {
 	struct mtk_smi_larb_iommu	larb_imu[MTK_LARB_NR_MAX];
 };
 
+struct mtk_iommu_device {
+	struct mtk_iommu_data *iommu;
+	unsigned int num_ids;
+	u32 ids[] __counted_by(num_ids);
+};
+
 struct mtk_iommu_domain {
 	struct io_pgtable_cfg		cfg;
 	struct io_pgtable_ops		*iop;
@@ -526,14 +533,14 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 static unsigned int mtk_iommu_get_bank_id(struct device *dev,
 					  const struct mtk_iommu_plat_data *plat_data)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct mtk_iommu_device *mtkdev = dev_iommu_priv_get(dev);
 	unsigned int i, portmsk = 0, bankid = 0;
 
 	if (plat_data->banks_num == 1)
 		return bankid;
 
-	for (i = 0; i < fwspec->num_ids; i++)
-		portmsk |= BIT(MTK_M4U_TO_PORT(fwspec->ids[i]));
+	for (i = 0; i < mtkdev->num_ids; i++)
+		portmsk |= BIT(MTK_M4U_TO_PORT(mtkdev->ids[i]));
 
 	for (i = 0; i < plat_data->banks_num && i < MTK_IOMMU_BANK_MAX; i++) {
 		if (!plat_data->banks_enable[i])
@@ -550,7 +557,7 @@ static unsigned int mtk_iommu_get_bank_id(struct device *dev,
 static int mtk_iommu_get_iova_region_id(struct device *dev,
 					const struct mtk_iommu_plat_data *plat_data)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct mtk_iommu_device *mtkdev = dev_iommu_priv_get(dev);
 	unsigned int portidmsk = 0, larbid;
 	const u32 *rgn_larb_msk;
 	int i;
@@ -558,9 +565,9 @@ static int mtk_iommu_get_iova_region_id(struct device *dev,
 	if (plat_data->iova_region_nr == 1)
 		return 0;
 
-	larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
-	for (i = 0; i < fwspec->num_ids; i++)
-		portidmsk |= BIT(MTK_M4U_TO_PORT(fwspec->ids[i]));
+	larbid = MTK_M4U_TO_LARB(mtkdev->ids[0]);
+	for (i = 0; i < mtkdev->num_ids; i++)
+		portidmsk |= BIT(MTK_M4U_TO_PORT(mtkdev->ids[i]));
 
 	for (i = 0; i < plat_data->iova_region_nr; i++) {
 		rgn_larb_msk = plat_data->iova_region_larb_msk[i];
@@ -579,22 +586,22 @@ static int mtk_iommu_get_iova_region_id(struct device *dev,
 static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
 			    bool enable, unsigned int regionid)
 {
+	struct mtk_iommu_device *mtkdev = dev_iommu_priv_get(dev);
 	struct mtk_smi_larb_iommu    *larb_mmu;
 	unsigned int                 larbid, portid;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	const struct mtk_iommu_iova_region *region;
 	unsigned long portid_msk = 0;
 	struct arm_smccc_res res;
 	int i, ret = 0;
 
-	for (i = 0; i < fwspec->num_ids; ++i) {
-		portid = MTK_M4U_TO_PORT(fwspec->ids[i]);
+	for (i = 0; i < mtkdev->num_ids; ++i) {
+		portid = MTK_M4U_TO_PORT(mtkdev->ids[i]);
 		portid_msk |= BIT(portid);
 	}
 
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
 		/* All ports should be in the same larb. just use 0 here */
-		larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
+		larbid = MTK_M4U_TO_LARB(mtkdev->ids[0]);
 		larb_mmu = &data->larb_imu[larbid];
 		region = data->plat_data->iova_region + regionid;
 
@@ -618,7 +625,7 @@ static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
 		} else {
 			/* PCI dev has only one output id, enable the next writing bit for PCIe */
 			if (dev_is_pci(dev)) {
-				if (fwspec->num_ids != 1) {
+				if (mtkdev->num_ids != 1) {
 					dev_err(dev, "PCI dev can only have one port.\n");
 					return -ENODEV;
 				}
@@ -708,7 +715,9 @@ static void mtk_iommu_domain_free(struct iommu_domain *domain)
 static int mtk_iommu_attach_device(struct iommu_domain *domain,
 				   struct device *dev)
 {
-	struct mtk_iommu_data *data = dev_iommu_priv_get(dev), *frstdata;
+	struct mtk_iommu_device *mtkdev = dev_iommu_priv_get(dev);
+	struct mtk_iommu_data *data = mtkdev->iommu;
+	struct mtk_iommu_data *frstdata;
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 	struct list_head *hw_list = data->hw_list;
 	struct device *m4udev = data->dev;
@@ -777,12 +786,12 @@ static int mtk_iommu_identity_attach(struct iommu_domain *identity_domain,
 				     struct device *dev)
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
+	struct mtk_iommu_device *mtkdev = dev_iommu_priv_get(dev);
 
 	if (domain == identity_domain || !domain)
 		return 0;
 
-	mtk_iommu_config(data, dev, false, 0);
+	mtk_iommu_config(mtkdev->iommu, dev, false, 0);
 	return 0;
 }
 
@@ -860,14 +869,28 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 	return pa;
 }
 
-static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
+static struct iommu_device *
+mtk_iommu_probe_device(struct iommu_probe_info *pinf)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
+	struct mtk_iommu_device *mtkdev;
+	struct device *dev = pinf->dev;
+	struct mtk_iommu_data *data;
 	struct device_link *link;
 	struct device *larbdev;
 	unsigned int larbid, larbidx, i;
 
+	data = iommu_of_get_single_iommu(pinf, &mtk_iommu_ops, 1,
+					 struct mtk_iommu_data, iommu);
+	if (IS_ERR(data))
+		return ERR_CAST(data);
+
+	mtkdev = iommu_fw_alloc_per_device_ids(pinf, mtkdev);
+	if (IS_ERR(mtkdev))
+		return ERR_CAST(mtkdev);
+	mtkdev->iommu = data;
+
+	dev_iommu_priv_set(dev, mtkdev);
+
 	if (!MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM))
 		return &data->iommu;
 
@@ -876,42 +899,46 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
 	 * The device that connects with each a larb is a independent HW.
 	 * All the ports in each a device should be in the same larbs.
 	 */
-	larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
+	larbid = MTK_M4U_TO_LARB(mtkdev->ids[0]);
 	if (larbid >= MTK_LARB_NR_MAX)
-		return ERR_PTR(-EINVAL);
+		goto err_out;
 
-	for (i = 1; i < fwspec->num_ids; i++) {
-		larbidx = MTK_M4U_TO_LARB(fwspec->ids[i]);
+	for (i = 1; i < mtkdev->num_ids; i++) {
+		larbidx = MTK_M4U_TO_LARB(mtkdev->ids[i]);
 		if (larbid != larbidx) {
 			dev_err(dev, "Can only use one larb. Fail@larb%d-%d.\n",
 				larbid, larbidx);
-			return ERR_PTR(-EINVAL);
+			goto err_out;
 		}
 	}
 	larbdev = data->larb_imu[larbid].dev;
 	if (!larbdev)
-		return ERR_PTR(-EINVAL);
+		goto err_out;
 
 	link = device_link_add(dev, larbdev,
 			       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
 	if (!link)
 		dev_err(dev, "Unable to link %s\n", dev_name(larbdev));
 	return &data->iommu;
+
+err_out:
+	kfree(mtkdev);
+	return ERR_PTR(-EINVAL);
 }
 
 static void mtk_iommu_release_device(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct mtk_iommu_data *data;
+	struct mtk_iommu_device *mtkdev = dev_iommu_priv_get(dev);
+	struct mtk_iommu_data *data = mtkdev->iommu;
 	struct device *larbdev;
 	unsigned int larbid;
 
-	data = dev_iommu_priv_get(dev);
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
-		larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
+		larbid = MTK_M4U_TO_LARB(mtkdev->ids[0]);
 		larbdev = data->larb_imu[larbid].dev;
 		device_link_remove(dev, larbdev);
 	}
+	kfree(mtkdev);
 }
 
 static int mtk_iommu_get_group_id(struct device *dev, const struct mtk_iommu_plat_data *plat_data)
@@ -931,7 +958,9 @@ static int mtk_iommu_get_group_id(struct device *dev, const struct mtk_iommu_pla
 
 static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 {
-	struct mtk_iommu_data *c_data = dev_iommu_priv_get(dev), *data;
+	struct mtk_iommu_device *mtkdev = dev_iommu_priv_get(dev);
+	struct mtk_iommu_data *c_data = mtkdev->iommu;
+	struct mtk_iommu_data *data;
 	struct list_head *hw_list = c_data->hw_list;
 	struct iommu_group *group;
 	int groupid;
@@ -957,32 +986,11 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 	return group;
 }
 
-static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
-{
-	struct platform_device *m4updev;
-
-	if (args->args_count != 1) {
-		dev_err(dev, "invalid #iommu-cells(%d) property for IOMMU\n",
-			args->args_count);
-		return -EINVAL;
-	}
-
-	if (!dev_iommu_priv_get(dev)) {
-		/* Get the m4u device */
-		m4updev = of_find_device_by_node(args->np);
-		if (WARN_ON(!m4updev))
-			return -EINVAL;
-
-		dev_iommu_priv_set(dev, platform_get_drvdata(m4updev));
-	}
-
-	return iommu_fwspec_add_ids(dev, args->args, 1);
-}
-
 static void mtk_iommu_get_resv_regions(struct device *dev,
 				       struct list_head *head)
 {
-	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
+	struct mtk_iommu_device *mtkdev = dev_iommu_priv_get(dev);
+	struct mtk_iommu_data *data = mtkdev->iommu;
 	unsigned int regionid = mtk_iommu_get_iova_region_id(dev, data->plat_data), i;
 	const struct mtk_iommu_iova_region *resv, *curdom;
 	struct iommu_resv_region *region;
@@ -1012,10 +1020,10 @@ static void mtk_iommu_get_resv_regions(struct device *dev,
 static const struct iommu_ops mtk_iommu_ops = {
 	.identity_domain = &mtk_iommu_identity_domain,
 	.domain_alloc_paging = mtk_iommu_domain_alloc_paging,
-	.probe_device	= mtk_iommu_probe_device,
+	.probe_device_pinf = mtk_iommu_probe_device,
 	.release_device	= mtk_iommu_release_device,
 	.device_group	= mtk_iommu_device_group,
-	.of_xlate	= mtk_iommu_of_xlate,
+	.of_xlate = iommu_dummy_of_xlate,
 	.get_resv_regions = mtk_iommu_get_resv_regions,
 	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
 	.owner		= THIS_MODULE,
-- 
2.42.0

