Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D210253B1;
	Thu, 30 Nov 2023 01:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SzkwUFka"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g00zmXrm1rAc1uaNVkPwe1F5TGPPJ71G2MC1qTwOvS83Bj4F9sBrKgph6yZ2MSMAFs2hXCmyn65YuYjsBML51sqcYpIQmc5XVQZQt4Mha5f9Ie7YDqT/IGdegp/dftz80dMtch7UWaHQTHul0JNuMqGLJASRUwkylr5HMS/ipSQAiEOMpLmGwlpixiTPP7xQsHRNgJGiFEFHsBh58viSKeaifdeldS/JPA/rwGdxpgHMgUljsRJ/Qq2ET1S8K1nwDM+waAb1YqRpDeey0NVyZQgo6sRvELV4QPK8dxkRCNRQe2+uj14Z1t4O2lSBOX3HZHAgiU1KBFT6hoxe93sqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjJdDHI+AITYfSvxiqF0GgwRht7dfBc7a3uv3e45GaI=;
 b=eNHZpDqbBYlHt3pp33ZyX1AxAxxIgx92wxaYG9Gxkgoms3bqNkayisZf2jRXBlW320t4OdoK5tof/AV/Cl1+VZtbyahXIYXryCu+LBVVI+AcR+tmjKX51VJnd1Kegu71ANzScHoEmH5z3Mi6Ov/UtKl1tWvqutT0mbLXAShQawW2ZyoHt/E4TJY7nU5pfTqGyVFXxCDWhHTD0jxlElgVgeP+w7dMK2SjNPWxhEUtH1qvyg2nufZ3H+7JbXUk8JRkl8sYa/H9s8sL+z2bk3X0VOTqwV8KgfUoumacA9GIL2Apco7F3omF1gC/uWV5Icr79tKJcLlKw/agqWqx/9W8RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjJdDHI+AITYfSvxiqF0GgwRht7dfBc7a3uv3e45GaI=;
 b=SzkwUFkaHxUe2W0oxyn4jE/DP3R0npSlsAvTYjUJ8+K/j5x08qIxuZUFX9y9wpo9IGbCW4qzw2aDXnvCvEKbHI/dUoZlD8jVdHDxpIwoTQXLywTqRDd0JnbLbLoFBZc/NGduDHkfTgnJr/A4OZZkVSnfmhLcTdsb6RNVOP/VVFaMjm+sPtGNa0rrZQF3iDmXtsPKxctG6idoGBY4WHvSu3zp7sn4MoUWTXFLgg6g/ydwDivHBN+TBanDtLIqEVnsKeLUd8ZqHRQ9w9shvtfsd+OPE/5DfLubiisiA1LAS5eaPc4p8qRjebIEv0Pw82yutdf0mE5fZPCGMTS9CVIpyA==
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
Subject: [PATCH v2 20/30] iommu/ipmmu-vmsa: Move to iommu_fw_alloc_per_device_ids()
Date: Wed, 29 Nov 2023 21:14:20 -0400
Message-ID: <20-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0095.namprd13.prod.outlook.com
 (2603:10b6:806:24::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: aaf9ac01-0cd2-4f6d-ac64-08dbf141b742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w76Dbi4o9XEiCM650QR+nJAm523U9F7mH+vLcMjkF9QgSt3Z3UQcce0kgUFeS+lL/kQmEormwJ+QN7UbsNFCuO3UbnabjS8MpT7R+wF5lyBcMBwyD044RkGtFJceHhsWrUcCsQASaCaArm8eruF21PC4XxCS5Pr95Uqgv+r2AD4f9BJMttW+DDUdCfUQ/Z7LB4vlApeU22UtJUlmxGPySxIvhU47GmYQ/QdqzMIngXxy9yfnYGLe0FIplgZIYbKxydSE7VMXs8oRxNpg0KBcQDqEgtIByYXmJQdbeQXNm7oNuQOEAe85TD6scCTWdCk3GRPBui0s1LKQ8oewjRI30RVFBjBbDln3+jDR0kGFAlt+zn2Wg4oJWD3Y/UDotTvIKHo/UiNrXRb7SQJUVV72InQGuJI7idBr9kknaLx8PVGuorwnQuEcWGyZ2amxgSr2N8sDJEQDPG0xzMt8/WGUchp/NMrHpWZe4QXZYIM82BxkWFffe2EGXtVUAkUFG98P/4Pg/gM2/6ZzUSdE4b510tacWhFFkIlRN5JIZa2w/k97xW7PfTFvofdY0VgkyXUSxtvUSyoxnzP/niGmKbaRQhoPg+6s4A+SKY96yPqCJ+g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(109986022)(451199024)(6486002)(4326008)(478600001)(8676002)(86362001)(5660300002)(8936002)(54906003)(66476007)(66556008)(66946007)(6506007)(2906002)(316002)(6666004)(6512007)(36756003)(26005)(2616005)(83380400001)(41300700001)(38100700002)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zhKb+0eFlxQuLX24P4Pb5ougRfnexml1Y6ndIWALVykv/NjRR6DuzkN+N3wO?=
 =?us-ascii?Q?+bIl5AKOIbykBgQkNgYFWafMcQAndrCZFKL5ZcOXHxo3nFGZRCxkQbQQBIdr?=
 =?us-ascii?Q?cdqMy07W08gu8kvziCIxf4RDloDO4k5QLhlEedu4r3gp6GJuyZb6IJfp6sRD?=
 =?us-ascii?Q?SZkrT763HwPciXkh3hd4gFfDLXd4ygOf4qiobNcCpWlDbpBZywd4jX6QMw+M?=
 =?us-ascii?Q?ppADgIPrVIfs0FAhhqKbUuDBEzhrdDYaWZa0arG/UD0IbtmJmppDJ0krsZIc?=
 =?us-ascii?Q?rVJavZmeUTnPe81U7cgHiosDLgDCGujyzvDjRtgU51vE8CI1KSQkcDv/UEGG?=
 =?us-ascii?Q?etewbV+/ALPZxUpv6cwrymJErlsyXBEgNfqeOSwszu0Gqje5VoVX8UaYRd8y?=
 =?us-ascii?Q?Ye3KJvzgQVX0C92VMSt53cnSD9QmyIcCF+v+cSLUnK7mTRS0BNdv7riA4S3C?=
 =?us-ascii?Q?bJRQyGIyzolNpXARXlV/Zpq9wIvy9ofma+uyHeapLGTI+f+EyGjqSR26KNkQ?=
 =?us-ascii?Q?m5biV/g9+4MYnRdyXaqLkMmqUvqSh5pCJpqjhApK4qHHHSZBe371yB82XZ2k?=
 =?us-ascii?Q?hAJGsZpJLDy8tJQypXE7UMAjrOKjGF/oBWEpycXbOA/oL2/VcKzPQo8WTolT?=
 =?us-ascii?Q?CRGNgAU0VlxSPdWsKisH3WcKu/3smhwqpnsN5I80P/YRnkuetItp6UXBNrAV?=
 =?us-ascii?Q?TKcqTygA0GrnTOIol2clqqegJm0WqULn8fapZN+0A9q1eQA2ImO7+PDH/eZc?=
 =?us-ascii?Q?GV3nuq47VVxayfOtX01n4Hc29JYQs66fY3yfKOc6CQoERJGKmKV9nimPKzS9?=
 =?us-ascii?Q?YoLcFCl+C3+SqtEvC/rSMmj91kKc/DjWZvB4b9Op72pIu1Us6kPcqxkeBucR?=
 =?us-ascii?Q?BDfUmuiOYYB72kRz4poEBQH8hG06At7aa4oEteN9YsfjjUOodlQ1FhU755O9?=
 =?us-ascii?Q?49Nd7RBL3zB72wzD7HFDuu+Wt7qIhFijlrl2Mkc4Yxq4A8em5kYUiZpmpwXd?=
 =?us-ascii?Q?jkDof8kn64Qhsk6cE1ACNEKEjYH4OEmuUCmM2lllheuji62Xky5c8jhcBdaa?=
 =?us-ascii?Q?4JDR06a6rWCSo2X9ohp9UZ07EAV/uC5STjuFcxf+Lli+IHMyG9bDX5+H8uwd?=
 =?us-ascii?Q?OjAQlKEr77netiiZ37OH4DfxqALBjcR7voHezrtuvKp250SuRG2bXNcCos6K?=
 =?us-ascii?Q?ByMXz32dYfVVCqB9bmVLL+AXp5qLlez8hpTTXGl1STuOHpwfWv5btMuFdFDe?=
 =?us-ascii?Q?kDQZi1jEnYgAUW5mhuQPB1RIT61krEX2V3VFoTJjNG8R+y5H7MnOQpgLuGtc?=
 =?us-ascii?Q?b9NBN4fnBrJGgDNFNH7sR/6uAMznPKAyJbSuhVI9wNbl7uefQXvHzpGw3m0p?=
 =?us-ascii?Q?kEHYpdHoHNJHNRQCm1EktFJ9LR+tiW3a4N2t+HjFkF3N9T/YEP49K75wt6SY?=
 =?us-ascii?Q?hb5acnBLv6JxQVh3TkDjPeMA25PEoDqoGR4vXZ7II91yNe474csVQj3VKPMk?=
 =?us-ascii?Q?0MQmwH2wzfZZGeVluz9YHjaH/CybTSDME96z5YMCGr/gvRbXeKYfkz/hFjJH?=
 =?us-ascii?Q?FIHZcj/7Njhwbj1tsWnr2q+/Vf+k7s6BfYRghIbn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf9ac01-0cd2-4f6d-ac64-08dbf141b742
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:35.4492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BMdQEdp7QIQYOPWpwVCy3FwU4mVr0Po+lplRz3JD4+/q0jSgZOOf4zaa3mhjShp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

ipmmmu-vmsa supports a single instance with multiple ids. It has a special
check if the device is permitted, move that to the top of probe. Use
iommu_of_get_single_iommu() to check and obtain the iommu device.

Introduce a per-device data to store the iommu and ids list. Allocate and
initialize it with iommu_fw_alloc_per_device_ids(). Remove
ipmmu_of_xlate(), ipmmu_init_platform_device(), and to_ipmmu().

Convert the rest of the funcs from calling dev_iommu_fwspec_get() to using
the per-device data and remove all use of fwspec.

Convert the places using dev_iommu_priv_get() to use the per-device data
not the iommu.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/ipmmu-vmsa.c | 96 +++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 54 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ace1fc4bd34b0f..ba984017065f98 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -17,6 +17,7 @@
 #include <linux/iopoll.h>
 #include <linux/io-pgtable.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
@@ -38,6 +39,8 @@
 
 #define IPMMU_UTLB_MAX		64U
 
+static const struct iommu_ops ipmmu_ops;
+
 struct ipmmu_features {
 	bool use_ns_alias_offset;
 	bool has_cache_leaf_nodes;
@@ -67,6 +70,12 @@ struct ipmmu_vmsa_device {
 	struct dma_iommu_mapping *mapping;
 };
 
+struct ipmmu_vmsa_master {
+	struct ipmmu_vmsa_device *iommu;
+	unsigned int num_ids;
+	u32 ids[] __counted_by(num_ids);
+};
+
 struct ipmmu_vmsa_domain {
 	struct ipmmu_vmsa_device *mmu;
 	struct iommu_domain io_domain;
@@ -83,11 +92,6 @@ static struct ipmmu_vmsa_domain *to_vmsa_domain(struct iommu_domain *dom)
 	return container_of(dom, struct ipmmu_vmsa_domain, io_domain);
 }
 
-static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
-{
-	return dev_iommu_priv_get(dev);
-}
-
 #define TLB_LOOP_TIMEOUT		100	/* 100us */
 
 /* -----------------------------------------------------------------------------
@@ -591,9 +595,9 @@ static void ipmmu_domain_free(struct iommu_domain *io_domain)
 static int ipmmu_attach_device(struct iommu_domain *io_domain,
 			       struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
+	struct ipmmu_vmsa_master *master = dev_iommu_priv_get(dev);
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
+	struct ipmmu_vmsa_device *mmu = master->iommu;
 	unsigned int i;
 	int ret = 0;
 
@@ -629,8 +633,8 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < fwspec->num_ids; ++i)
-		ipmmu_utlb_enable(domain, fwspec->ids[i]);
+	for (i = 0; i < master->num_ids; ++i)
+		ipmmu_utlb_enable(domain, master->ids[i]);
 
 	return 0;
 }
@@ -639,7 +643,7 @@ static int ipmmu_iommu_identity_attach(struct iommu_domain *identity_domain,
 				       struct device *dev)
 {
 	struct iommu_domain *io_domain = iommu_get_domain_for_dev(dev);
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct ipmmu_vmsa_master *master = dev_iommu_priv_get(dev);
 	struct ipmmu_vmsa_domain *domain;
 	unsigned int i;
 
@@ -647,8 +651,8 @@ static int ipmmu_iommu_identity_attach(struct iommu_domain *identity_domain,
 		return 0;
 
 	domain = to_vmsa_domain(io_domain);
-	for (i = 0; i < fwspec->num_ids; ++i)
-		ipmmu_utlb_disable(domain, fwspec->ids[i]);
+	for (i = 0; i < master->num_ids; ++i)
+		ipmmu_utlb_disable(domain, master->ids[i]);
 
 	/*
 	 * TODO: Optimize by disabling the context when no device is attached.
@@ -708,20 +712,6 @@ static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
 	return domain->iop->iova_to_phys(domain->iop, iova);
 }
 
-static int ipmmu_init_platform_device(struct device *dev,
-				      struct of_phandle_args *args)
-{
-	struct platform_device *ipmmu_pdev;
-
-	ipmmu_pdev = of_find_device_by_node(args->np);
-	if (!ipmmu_pdev)
-		return -ENODEV;
-
-	dev_iommu_priv_set(dev, platform_get_drvdata(ipmmu_pdev));
-
-	return 0;
-}
-
 static const struct soc_device_attribute soc_needs_opt_in[] = {
 	{ .family = "R-Car Gen3", },
 	{ .family = "R-Car Gen4", },
@@ -772,24 +762,10 @@ static bool ipmmu_device_is_allowed(struct device *dev)
 	return false;
 }
 
-static int ipmmu_of_xlate(struct device *dev,
-			  struct of_phandle_args *spec)
-{
-	if (!ipmmu_device_is_allowed(dev))
-		return -ENODEV;
-
-	iommu_fwspec_add_ids(dev, spec->args, 1);
-
-	/* Initialize once - xlate() will call multiple times */
-	if (to_ipmmu(dev))
-		return 0;
-
-	return ipmmu_init_platform_device(dev, spec);
-}
-
 static int ipmmu_init_arm_mapping(struct device *dev)
 {
-	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
+	struct ipmmu_vmsa_master *master = dev_iommu_priv_get(dev);
+	struct ipmmu_vmsa_device *mmu = master->iommu;
 	int ret;
 
 	/*
@@ -831,16 +807,27 @@ static int ipmmu_init_arm_mapping(struct device *dev)
 	return ret;
 }
 
-static struct iommu_device *ipmmu_probe_device(struct device *dev)
+static struct iommu_device *ipmmu_probe_device(struct iommu_probe_info *pinf)
 {
-	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
+	struct device *dev = pinf->dev;
+	struct ipmmu_vmsa_master *master;
+	struct ipmmu_vmsa_device *mmu;
 
-	/*
-	 * Only let through devices that have been verified in xlate()
-	 */
-	if (!mmu)
+	if (!ipmmu_device_is_allowed(dev))
 		return ERR_PTR(-ENODEV);
 
+	mmu = iommu_of_get_single_iommu(pinf, &ipmmu_ops, -1,
+					struct ipmmu_vmsa_device, iommu);
+	if (IS_ERR(mmu))
+		return ERR_CAST(mmu);
+
+	master = iommu_fw_alloc_per_device_ids(pinf, master);
+	if (IS_ERR(master))
+		return ERR_CAST(master);
+	master->iommu = mmu;
+
+	dev_iommu_priv_set(dev, master);
+
 	return &mmu->iommu;
 }
 
@@ -857,24 +844,25 @@ static void ipmmu_probe_finalize(struct device *dev)
 
 static void ipmmu_release_device(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
+	struct ipmmu_vmsa_master *master = dev_iommu_priv_get(dev);
+	struct ipmmu_vmsa_device *mmu = master->iommu;
 	unsigned int i;
 
-	for (i = 0; i < fwspec->num_ids; ++i) {
-		unsigned int utlb = fwspec->ids[i];
+	for (i = 0; i < master->num_ids; ++i) {
+		unsigned int utlb = master->ids[i];
 
 		ipmmu_imuctr_write(mmu, utlb, 0);
 		mmu->utlb_ctx[utlb] = IPMMU_CTX_INVALID;
 	}
 
 	arm_iommu_release_mapping(mmu->mapping);
+	kfree(master);
 }
 
 static const struct iommu_ops ipmmu_ops = {
 	.identity_domain = &ipmmu_iommu_identity_domain,
 	.domain_alloc_paging = ipmmu_domain_alloc_paging,
-	.probe_device = ipmmu_probe_device,
+	.probe_device_pinf = ipmmu_probe_device,
 	.release_device = ipmmu_release_device,
 	.probe_finalize = ipmmu_probe_finalize,
 	/*
@@ -884,7 +872,7 @@ static const struct iommu_ops ipmmu_ops = {
 	.device_group = IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)
 			? generic_device_group : generic_single_device_group,
 	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
-	.of_xlate = ipmmu_of_xlate,
+	.of_xlate = iommu_dummy_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= ipmmu_attach_device,
 		.map_pages	= ipmmu_map,
-- 
2.42.0

