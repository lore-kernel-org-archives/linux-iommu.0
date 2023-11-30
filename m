Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BF51101;
	Thu, 30 Nov 2023 01:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bVN1lJaR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oR1u+ZG9rsmp/692aeRbysJfdDXSKbh+zF3fH6+tWIZBOK/POOgdAstoeVxqTKrFt0k1Yk93/0GxcfbL6GN0y43WE2O8ek9G2mgf9vCDNpeydW9j2WryLeRH/Ydaj9w0lDf0xgat0TMNQS1M0k32kv4C7u/uKA3J3gziaf/9W6GFdgdUNlVC6RJGGpK80cejKP3kYqnsMimcP48382uvss+xXc9u+mxYbl2Lx9W43dbZVZD0JNMdVxOKaKoMgglCYvm437OnWkjCvDf3Y4e94owXc0/fbaAff42zxTu8BhsrsL9drurRSoW2LYDERqNZvMU2D4NlcTEdE368qaPo/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqEzauI1AR2owm9HEl6HCb3Z9hfFMw5b5rv0EaUHXus=;
 b=WjZ4nsfSoiBbG7GgNLfBUM0VRK0J0CmvCjS2JEsgaGEc+NXBYe0N2BIerz4EOKRC1TdipZB2GqcXFlnQCAEXLPQg7A6KwClrnjVnd8Qub0I0ZK/Qqqn7juTGMzetdpQc27ORGtlHZXbuwLN6t8/b2IdZlI1iZ/Tq6j+AWIsk0zT8WRr2VXnPx/z+HqAEw5UsHvQhQJhSFwxaSql6/XTq8i8dBllg90Dh+SIAQg2RRSIEmM88xNhmEcBd41TqStUIhMLNNXPrdofjmHDoghgH5lhsEJhNUq+cfJbl+APkFesiEI0IpfRb9vTIxO2yvYft28SusZFcV1lzdothiZHkvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqEzauI1AR2owm9HEl6HCb3Z9hfFMw5b5rv0EaUHXus=;
 b=bVN1lJaRLILVGhbN2XvwMkVeLMONvk4sX5BQ1oAQ6p0JOVq4h6hz/K7m+vkxgWpAn04kMsP+E7Y5HnidWiSkmF6hVVt6F5zHBzWuhh2Cjli/nl8xs7sFE1zV58UytC3CZInavSwhGxfs9eZG6EUbJnrHJ3mbw2DS/o7sm+z0rIc5Nyv77645UHUtEZ09+dYyCRE6eSi0HxBA/k5J1e4QoYFd77r6j9lCtdID58LvHkN2gfMVgraZoPHNOweAcxhDtQx6xXKBYMRH0eCYlLhw2XS17mHxARK+fYlxKG6px80B8NEzE9jm1GAAS93lOlNLgFASsajIFGxxK5AKpgCvAQ==
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
Subject: [PATCH v2 11/30] iommu/sun50i: Move to iommu_of_get_single_iommu()
Date: Wed, 29 Nov 2023 21:14:11 -0400
Message-ID: <11-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 74199131-3ab1-491c-a24f-08dbf141b51e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Kx0EX4fLtc47yPrLjEfUfZJfXrqC/fA8jopHdStTZMSQ4uhySc1SDI5CpnhZ7MGMWZjgEYCJ/+wH/6coQ/Rr+fpFRXmXDQx6nCvo3Z9HtSE/38lvVsaOPU3Eb/EEbQF0aJV0UWwPd5fXyHzAG/461clwJGWgZHbie+pucOLWP8jujKaaaGmPAFOfUxsEHkIeHXhQxfdKB2t27hIKbbvAwLvcw0YXwvnEL9VndL4U9ZM9/fKv17AB7Kq6UEp9KpPA7M/ilZbpo3GFzcF0VPESvCUpO8rlRPNP6i1MpH3t8eTKTejgz6kS7lVO4txAFuORGEJCzT3wvXjRY4my0mFHAdzL9/SOIxDviokhnn8b+6QAluffMIXWRFCO6QfTDDtQXu9cWQpnrzr2cbrgONII6BZshk78MiWYWUb/c+gTfcplN31AmSqxl9wu+HetejifDzE/rPkLBN0jG31BZJpn4EE9xvTnmdk/MVgcYToGBdqSnGjjylw9pB6UnJQnvukdCe36LnotdYx7tzCes2SRFnYsxMO4NDzUmHpNKLBECOGO8Wu/IHr07oZuTYvj9r8KNKKrRwuGaqtYVJb2hRJLvsBAaEmlHkT8hvRwDO4dc8c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(109986022)(41300700001)(2616005)(4326008)(86362001)(38100700002)(8676002)(6666004)(8936002)(5660300002)(2906002)(26005)(6506007)(478600001)(316002)(66556008)(66946007)(66476007)(6486002)(54906003)(83380400001)(36756003)(6512007)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+G3jCxw8VAXNbOLiUsJ+mPtovLp6iUMb7Hh9DbL6LE3A61YxCZobDL8Uk331?=
 =?us-ascii?Q?5nxFLjBXm7REz1XpDQ//wQcooQJ7rqyC4KsS6+gczWIvXHHFXE63IWnSk+fr?=
 =?us-ascii?Q?aIkBrEFMiyX0wJIpr5OaoldpvO54sp4P1HtNIwadUEODUJSyEp56pvHNpe3S?=
 =?us-ascii?Q?RIjMIPgCuI+z3KVrpHWTUe8sQVDb2ZhIqi42l3+0GUklirtNjOaKsWCqnQRa?=
 =?us-ascii?Q?kdTB0kosyZM9eXJE1plto6mz/wgPnXLava2bsLvzRtzxJntqF2ZaM8vncUMW?=
 =?us-ascii?Q?n5//kDgdRVDiiXQ5l4Ce9cjCjLndCT6hv1oa2mNNYYF9cVMK8ULDoNaXb4Ug?=
 =?us-ascii?Q?64yBE/FJBoe8YQa6AkVxoyNVzHaLUDAvfIBgi/AchvjL3so0hoVvR/cSkqzL?=
 =?us-ascii?Q?YpWzJEO2A/UMFMglrOR45WdmNv7kalQaLaiSRipikyfm5hlp3rWwEPsVERYY?=
 =?us-ascii?Q?mP8Blk2enPbrKK4kWqbFvHnlg+u6+zh6pEcZONRXEhrqz0BV1VBEjpKQ3jXd?=
 =?us-ascii?Q?mwnnr2WTly/c6MrQQQOsU31jhqSaWVH5IU1tL+Y2bH2bYlWpCH3isCbEWmLC?=
 =?us-ascii?Q?18j/dmGPwu+9r2FUHzyvcQxs3oUDi1mOgoM6B0uyjh6p22GXuH6AroieuHqH?=
 =?us-ascii?Q?k38B+j/J9C0Xlf0rappwB1TkTyUR7u+OaAnj5FmMj8RD1i2XJcCbj+uxPv0U?=
 =?us-ascii?Q?vdEEZxU+Ch9okErHYuvWAgALi1ExrIOT6Zj8U/QxsvtHaK2FlggM9Ozvltav?=
 =?us-ascii?Q?ySRPHs+RhX6cBf/9dIyM2yESJSxu64c6YD7d9ALhjZhFw7RbDmc9fWvwFqtt?=
 =?us-ascii?Q?nEbC2z+BfhEjP1ZZ8fxjZPGsFbUYrvl2XBN/zvvVMojcRvC0oJY7DnwGOpl7?=
 =?us-ascii?Q?KMsHBQ6Pqpguu+fy10GRLu+VglC6BsMfJ+TNmuXo0g2lLhiNnyqTnjq2sYGX?=
 =?us-ascii?Q?DGkJ+igRqKOz85kjN9UhBWpYv+E1Ky5Czfc6b04SQa20paVrptMfNqPHLqnX?=
 =?us-ascii?Q?DuEqyZH1kRtmnqN28ozl96/FmsRXf+adwiNPdLPc4EV3WOsayo9yZ13kfBIH?=
 =?us-ascii?Q?aMCPb48EfOq1I4iI5mexPzAZ4ePARHX0uILt0XRVIuOKem/GCbiCRujzW5W7?=
 =?us-ascii?Q?to+vGmC7qMN2dHT4rsvRaouLkiEkqgNoO6PBn+Wm/+Ln++L+o8Q6j9vR0Bot?=
 =?us-ascii?Q?n28stYEjqLlyfeHvhFSNb3wCQYqM868GA0HvOoRZ+KYeDwf3W6Zt0icWeb29?=
 =?us-ascii?Q?luXBy0wfzkvpkC4ycj90WunYKHgctePlxk3WB2WrTuZ7zu3lwfTVYyDcvQol?=
 =?us-ascii?Q?62fLQYpUEZr46eOcsOcNquPz574J9ZoIKVMxcyf6ERvdBV6vadM95JmuYGW9?=
 =?us-ascii?Q?buyYS+Xr2ayEqAU/30kpJJ+MUA6m8mP4Swns2DDZaDYbd3z5IF10sn2468QY?=
 =?us-ascii?Q?V73C7Hb/1i1GZgQxezWQMM5f74egY2YeAlgI5HUZClHoUoWbH1iHr83aNCAK?=
 =?us-ascii?Q?sl3e+ikIw/+Fxo3Nno6l99cnAwCd2quNzCynFcYNDw3CQKL2EzjaA/ZmisTQ?=
 =?us-ascii?Q?LwfUixUYyzfhYOaUxJqkdFGaC3QtwgaeXkGsXA4u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74199131-3ab1-491c-a24f-08dbf141b51e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:31.8235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTloTpQTuntHBmgYNzMcq0s3UJYEhvGoLZoAbdEhJFAMZasuvh91eRcDsKf3vEIx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627

sun50i uses a simple binding where a the OF iommus's can describe a single
iommu instrance with a single ID, reflecting the master, on it.

The driver ignores the ID from the OF, it looks like the instance can only
do a single translation as the entire thing is managed with
generic_single_device_group(). Since there is a single translation the ID
presumably doesn't matter.

Allocate a sun50i_iommu_device struct during probe to be like all the
other drivers.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/sun50i-iommu.c | 60 +++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 41484a5a399bb1..84038705cf657d 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/iopoll.h>
 #include <linux/ioport.h>
 #include <linux/log2.h>
@@ -95,6 +96,8 @@
 
 #define SPAGE_SIZE			4096
 
+static const struct iommu_ops sun50i_iommu_ops;
+
 struct sun50i_iommu {
 	struct iommu_device iommu;
 
@@ -110,6 +113,10 @@ struct sun50i_iommu {
 	struct kmem_cache *pt_pool;
 };
 
+struct sun50i_iommu_device {
+	struct sun50i_iommu *iommu;
+};
+
 struct sun50i_iommu_domain {
 	struct iommu_domain domain;
 
@@ -128,11 +135,6 @@ static struct sun50i_iommu_domain *to_sun50i_domain(struct iommu_domain *domain)
 	return container_of(domain, struct sun50i_iommu_domain, domain);
 }
 
-static struct sun50i_iommu *sun50i_iommu_from_dev(struct device *dev)
-{
-	return dev_iommu_priv_get(dev);
-}
-
 static u32 iommu_read(struct sun50i_iommu *iommu, u32 offset)
 {
 	return readl(iommu->base + offset);
@@ -760,7 +762,8 @@ static void sun50i_iommu_detach_domain(struct sun50i_iommu *iommu,
 static int sun50i_iommu_identity_attach(struct iommu_domain *identity_domain,
 					struct device *dev)
 {
-	struct sun50i_iommu *iommu = dev_iommu_priv_get(dev);
+	struct sun50i_iommu_device *sdev = dev_iommu_priv_get(dev);
+	struct sun50i_iommu *iommu = sdev->iommu;
 	struct sun50i_iommu_domain *sun50i_domain;
 
 	dev_dbg(dev, "Detaching from IOMMU domain\n");
@@ -786,12 +789,9 @@ static struct iommu_domain sun50i_iommu_identity_domain = {
 static int sun50i_iommu_attach_device(struct iommu_domain *domain,
 				      struct device *dev)
 {
+	struct sun50i_iommu_device *sdev = dev_iommu_priv_get(dev);
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
-	struct sun50i_iommu *iommu;
-
-	iommu = sun50i_iommu_from_dev(dev);
-	if (!iommu)
-		return -ENODEV;
+	struct sun50i_iommu *iommu = sdev->iommu;
 
 	dev_dbg(dev, "Attaching to IOMMU domain\n");
 
@@ -807,26 +807,37 @@ static int sun50i_iommu_attach_device(struct iommu_domain *domain,
 	return 0;
 }
 
-static struct iommu_device *sun50i_iommu_probe_device(struct device *dev)
+static struct iommu_device *
+sun50i_iommu_probe_device(struct iommu_probe_info *pinf)
 {
+	struct sun50i_iommu_device *sdev;
 	struct sun50i_iommu *iommu;
 
-	iommu = sun50i_iommu_from_dev(dev);
-	if (!iommu)
-		return ERR_PTR(-ENODEV);
+	iommu = iommu_of_get_single_iommu(pinf, &sun50i_iommu_ops, 1,
+					 struct sun50i_iommu, iommu);
+	if (IS_ERR(iommu))
+		return ERR_CAST(iommu);
 
+	/*
+	 * The ids are ignored because the all the devices are placed in a
+	 * single group and the core code will enforce the same translation for
+	 * all ids.
+	 */
+
+	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
+	if (!sdev)
+		return ERR_PTR(-ENOMEM);
+	sdev->iommu = iommu;
+
+	dev_iommu_priv_set(pinf->dev, sdev);
 	return &iommu->iommu;
 }
 
-static int sun50i_iommu_of_xlate(struct device *dev,
-				 struct of_phandle_args *args)
+static void sun50i_iommu_release_device(struct device *dev)
 {
-	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
-	unsigned id = args->args[0];
+	struct sun50i_iommu_device *sdev = dev_iommu_priv_get(dev);
 
-	dev_iommu_priv_set(dev, platform_get_drvdata(iommu_pdev));
-
-	return iommu_fwspec_add_ids(dev, &id, 1);
+	kfree(sdev);
 }
 
 static const struct iommu_ops sun50i_iommu_ops = {
@@ -834,8 +845,9 @@ static const struct iommu_ops sun50i_iommu_ops = {
 	.pgsize_bitmap	= SZ_4K,
 	.device_group	= generic_single_device_group,
 	.domain_alloc_paging = sun50i_iommu_domain_alloc_paging,
-	.of_xlate	= sun50i_iommu_of_xlate,
-	.probe_device	= sun50i_iommu_probe_device,
+	.of_xlate = iommu_dummy_of_xlate,
+	.probe_device_pinf	= sun50i_iommu_probe_device,
+	.release_device = sun50i_iommu_release_device,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= sun50i_iommu_attach_device,
 		.flush_iotlb_all = sun50i_iommu_flush_iotlb_all,
-- 
2.42.0

