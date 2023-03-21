Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648AED516
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 19:53:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CR0TvwWfU464LeqkaMlv/1hAHxBaJTR8o7ELUr5wtYEuH8Que6tAQMcAUUa677vDO9SqaeL2TUMaRVYxGXTaRwAFz2YH/hQ3SPioDTnDta02khR934osav7zK2W3BUWasGP+eCXhaVTu/JrTaCN+rvvwMmICoH3NcLr/p+Jregj5gD7xoLRWdx8Cd+0EDX29JPE28cIm+EWy69X5H1XIHak/cQhqyNkGIRApucSxTlznDPABo4qEaRmSIJgR64zlj71auAKxABd2Mhc5VIlaF4o2G4mL1/73uztwhS6rUFQMfUsynLoLcFoFPH/oo4es3fL9bh4eFnMyj5mUCZedXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/mYG3+4cTHeutBvxnRJDxDgADr+Dv2WxDsm6GkKCPo=;
 b=fGWb3OZipJeO5BqtXdrJ2h49WVNEswF8Vxb0rX5eHMa5l4VYLqYbi5X8kH7TnITG/JB/a0WW0ZJhnfl6ICY7MfXnOXmAKtjHJ67+Mr4oQqLVD2icyCfs540vde5TAtuzlLFH8trDQ/7gP4UykHRV/50NvtcZCShv1PvgsKA/kqCk0fksVy73asnoX8d9cgvwBhepncorrY+BSiyKzlPVZtPDFO2xwUkL/syzz4f8ubZefdYxrvcRK1vfKd35I044Tt8/HcVB/TPmt0b4AVHzJO48AYHLNM+QlTl5qfN1JMuOp44e14RFhoaf+sIriIjCYHgZoamKalH+tFqNo22AwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/mYG3+4cTHeutBvxnRJDxDgADr+Dv2WxDsm6GkKCPo=;
 b=jlpIo7oLL7xGs/q07tDach1o2qmJRq4PPJGjvTmcju+leXk7keuFUQA5gQ227afkofsP7cPXPC3BMzEZ4ObywjlnGHJp8liNsS9PQw2nbEJZ4luKEvmdjU1kXdmVPHmvbbPGFWwTLTiAnL/S1DZdX1M+Oswye0IiSSPLo9X8SEjVmW0UA+v5uhqSgG51Ld4UF+gScpOhOKVdzFsrgaWpKYzZsW6sf4thtLXNEu/X/pvPQjPvU4n07jKIB18x4WCzuCvRRvQ6bn+7kQC5z84ssy37VhEsHfZyM2KwLIX0P05aNRmn4wrSAOx9MeZUR4rurtu99xiBWDj1rZDgHqOZrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:53:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:53:29 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 8/9] iommu: Consolidate the default_domain setup to one function
Date: Tue, 21 Mar 2023 16:53:20 -0300
Message-Id: <8-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 30dab64f-bb58-406d-19fc-08db2a45ee00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9IYJRR/E4DupRzE/GohOwTsakauCkcZLlzBV/sW6j/LSy4u/mfWR46VyiSPMYSaIDwPdVN6IvR9p2g+P8Z1/qdr6jQRyq/1Som0CQxepQdn6eWYpmZ4+u/5I3xZLc7s5wFN9Tv/dzH5Nqzmct7ktpJdSlEMyEKH1bdiUreC3fYvuktznx5DDodP/X3X0AdShhnpb7u/i/H04AIKC+rY0o2pjoUFDGrGCSnptUB0e73YIVpdmf/f96HNVzma/hwNp1iaqbKl/ilaGm/Fw4jc2dq1jUP9AJ/8uW3wERAzxQUTcdx4AK/bXnIDJJXkiJeYcmv3smm+XUsPfSqT7V3SF3D4rDEFyNWt3pfIMlU6fhZU/micqP2fKncthwqxH6qxl4q1pYbNopu6tF6MPJfrUB2yvmwBtZp2CCJLYcONEvUb546HxaO8U5GkclrASTngtSr6k+YY8qtxDqwoXgG04qdoL0UmfBPHA71OnkLr+IVCQFBzWw2q4HGqHQJ8esP8Pzb+aEBec6OVMpB9c5V3meXRi0Szi2j5GF+Ozki+t+GSfB+cSBNnG+yd4cZLPNQwjM/fvXpIpDX/FQerHbo2Aj75Fw7xsUOGB2pEPSuiBzZZK0jfNnq6yWMSuqL5nrCOn15SEKYRZJ6tMBauM9e5ftL2o19cjjXJjlvsinH1apdOazSv95w3+R+AKZr8GL1eE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199018)(66556008)(66476007)(66946007)(8676002)(4326008)(6486002)(2616005)(8936002)(186003)(5660300002)(2906002)(86362001)(110136005)(83380400001)(41300700001)(26005)(316002)(54906003)(6506007)(6512007)(478600001)(36756003)(38100700002)(6666004)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o2CqdYtn1h0hDhUR2XL3Dy9qmgp+yBPHW88dOGHboFaUJ2/8cZ+n7l6A54Ip?=
 =?us-ascii?Q?HoPLBw89m7t216jK3sZaWEZ60SjyTfTLRqWzXz1J2hTar9UuUymbnHb9fPIp?=
 =?us-ascii?Q?rK0uyoU/bu+jZ5zcLNclePDtp+ZLiQTM20TGAgWmn7rHmyig+bGpNOt3SYjQ?=
 =?us-ascii?Q?dH7er8+6GRQHOLJraUchAyQnpVebzf5mAOh8fi1bx+T5SWDUnLHt1LXY/wmT?=
 =?us-ascii?Q?tBkawWxiUp1MCaLnv0w0ZmYAH/usuKkqQlCti7Z0pONEl5gdFLWI8LEHJPVf?=
 =?us-ascii?Q?bLJI6IfGIblI3Mbv8KHgy7Ssena1zlC3Tp2owt3rrIiaVaJ1mENRlg2Y9EC1?=
 =?us-ascii?Q?nxk/xeONm7kFHeeGBzoYjZ92C1G7L5ISNe8NYoSrcKv8QZH/zQK4AwSOlllg?=
 =?us-ascii?Q?M4FRcWXIYT9ADAB4iuSBUBSEf9+kn1j4xUK9wde7DXC2wkMhaK2eNCSEle3Z?=
 =?us-ascii?Q?Rv8E8cnsbmbg1kmvM1WlEyxwZAsrTeQqBySIOr08TIPXW3q9FpTs6htxHmhL?=
 =?us-ascii?Q?oP5Yi5H3kHUPkfHoRo8mWfmP3VWBOoLfre+6NIFxG8hQ/flgw4y/XPPa44Zo?=
 =?us-ascii?Q?yfsr6PIZZvREf8GZSvlPlL42kl6+HVJzY43p8WBQ4fJYvhT4BTBZO2bZFSKH?=
 =?us-ascii?Q?yrCK2jPtpDx7Rmpc308iZRlhMEAixEx1WUw5JDE+dZJ2u6PoXNn+qngUF9jP?=
 =?us-ascii?Q?nMST9BoMnO08SSMphkRMeSR/n2S1j85bEBrVTEBTwsndbqLFdYrLJSK5Flgy?=
 =?us-ascii?Q?kSvap3PF32EuOzA0R1yu4oN36xQXHROJ2mmE9WOR3R4npQBoSIRtUduZuo2X?=
 =?us-ascii?Q?rR3ek3qX11VOoDLyI4YTS3hr1sfqHXNDXTC62qYhZj8cO6eb/p7ncfs2YwEL?=
 =?us-ascii?Q?wsh92BOxIijeq3/tE5pVanzGTCeCZYsIALN73/t8Id1hFp/L6HMD1BraGAZ3?=
 =?us-ascii?Q?/adwBJvbAESyiG1bBVu1PdoTqVcjEYgsUWhR+obe2fNmOJPUZD9wJJn0Aupg?=
 =?us-ascii?Q?9l05dsg3JJok8/le8Ji3Usx37s+hGjslJYlhtPoP5BRZYwwfqo02LcJhArD1?=
 =?us-ascii?Q?bu8weZRqHEFZ30tAy7jbNqlwuzbqEJTHIjtgaAru1shbon/j5yGXB5mQBeL0?=
 =?us-ascii?Q?AokRnud6J3O6s3ltz8bohRThMlB6vgqKIrdnWuZVZsCnhc+bjV0uozndTgFs?=
 =?us-ascii?Q?qCWlUeHbUlNxEFAP0MjPl64HwfkUhOEYKxvVhp+iY9RL0qxRkK0TwDP6SBuF?=
 =?us-ascii?Q?K8qSLL/7O7SIfvPDQ3lX6lTcQDtJ9hreTjnG+KiJqpLff4+C6aMZmtT9I5GU?=
 =?us-ascii?Q?DeqcDR1r36Li3boXEU2R7iHDisKNcFBIl9TBm+npJEhYNx18px5GShB+hE8R?=
 =?us-ascii?Q?eaet+/S3CihKKG5RNhvQ6vggGQEfEWB+Rr3piv1wdqjy/CzX2Fsmtm3FYoDx?=
 =?us-ascii?Q?uMWVPJC5D4kUt1G3RqAVYadE+pM56Av+u5w9fb8zLoFyPbCfg5GxuGYVtU9l?=
 =?us-ascii?Q?buyMoOK51WFpZqil9Ar1Nz6kU37KGEmgr4HLuXIPrU0ieztVY2XDrhwv0ERH?=
 =?us-ascii?Q?Znxeo2EQB4vreCH0G+E1S0BlTcPtWASZSvBqMTaC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30dab64f-bb58-406d-19fc-08db2a45ee00
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:53:23.9182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPWLcmP8vrEhm+RvcJa+GPZCwdsWnStbNDMmxBttJIwXhL2E3InkeoZulYDnZDEd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909

The default_domain setup flow requires
 - Determining the default type
 - Allocating a default_domain
 - Attaching it to devices
 - Doing iommu_create_device_direct_mappings()

This is sprinkled around three places written in two different ways. Make
it all the same in one function.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 179 +++++++++++++++++-------------------------
 1 file changed, 71 insertions(+), 108 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9973d1eac18cc9..e129f55587def2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -88,8 +88,6 @@ static const char * const iommu_group_resv_type_string[] = {
 
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data);
-static int iommu_alloc_default_domain(struct iommu_group *group,
-				      struct device *dev);
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 						 unsigned type);
 static int __iommu_attach_device(struct iommu_domain *domain,
@@ -121,6 +119,7 @@ static void __iommu_group_set_domain_nofail(struct iommu_group *group,
 		group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED));
 }
 
+static int iommu_setup_default_domain(struct iommu_group *group);
 static int iommu_create_device_direct_mappings(struct iommu_group *group,
 					       struct device *dev);
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
@@ -433,29 +432,14 @@ int iommu_probe_device(struct device *dev)
 
 	if (group->domain) {
 		ret = iommu_group_do_dma_first_attach(group, dev);
+		if (ret)
+			goto err_unlock;
+		iommu_create_device_direct_mappings(group, dev);
 	} else if (!group->default_domain) {
-		/*
-		 * Try to allocate a default domain - needs support from the
-		 * IOMMU driver. There are still some drivers which don't
-		 * support default domains, so the return value is not yet
-		 * checked.
-		 */
-		iommu_alloc_default_domain(group, dev);
-		if (group->default_domain)
-			ret = __iommu_group_set_domain_internal(
-				group, group->default_domain,
-				IOMMU_SET_DOMAIN_WITH_DEFERRED);
-
-		/*
-		 * We assume that the iommu driver starts up the device in
-		 * 'set_platform_dma_ops' mode if it does not support default
-		 * domains.
-		 */
+		ret = iommu_setup_default_domain(group);
+		if (ret)
+			goto err_unlock;
 	}
-	if (ret)
-		goto err_unlock;
-
-	iommu_create_device_direct_mappings(group, dev);
 
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
@@ -1655,37 +1639,6 @@ static int iommu_get_def_domain_type(struct device *dev)
 	return 0;
 }
 
-static int iommu_group_alloc_default_domain(struct bus_type *bus,
-					    struct iommu_group *group,
-					    unsigned int type)
-{
-	struct iommu_domain *dom;
-
-	dom = __iommu_domain_alloc(bus, type);
-	if (!dom && type != IOMMU_DOMAIN_DMA) {
-		dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
-		if (dom)
-			pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
-				type, group->name);
-	}
-
-	if (!dom)
-		return -ENOMEM;
-
-	group->default_domain = dom;
-	return 0;
-}
-
-static int iommu_alloc_default_domain(struct iommu_group *group,
-				      struct device *dev)
-{
-	unsigned int type;
-
-	type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;
-
-	return iommu_group_alloc_default_domain(dev->bus, group, type);
-}
-
 /**
  * iommu_group_get_for_dev - Find or create the IOMMU group for a device
  * @dev: target device
@@ -1771,6 +1724,7 @@ static int iommu_bus_notifier(struct notifier_block *nb,
 struct __group_domain_type {
 	struct device *dev;
 	unsigned int type;
+	unsigned int count;
 };
 
 static int probe_get_default_domain_type(struct device *dev, void *data)
@@ -1778,6 +1732,10 @@ static int probe_get_default_domain_type(struct device *dev, void *data)
 	struct __group_domain_type *gtype = data;
 	unsigned int type = iommu_get_def_domain_type(dev);
 
+	gtype->count++;
+	if (!gtype->dev)
+		gtype->dev = dev;
+
 	if (type) {
 		if (gtype->type && gtype->type != type) {
 			dev_warn(dev, "Device needs domain type %s, but device %s in the same iommu group requires type %s - using default\n",
@@ -1796,12 +1754,18 @@ static int probe_get_default_domain_type(struct device *dev, void *data)
 	return 0;
 }
 
-static void probe_alloc_default_domain(struct bus_type *bus,
-				       struct iommu_group *group)
+static int iommu_setup_default_domain(struct iommu_group *group)
 {
-	struct __group_domain_type gtype;
+	struct __group_domain_type gtype = {};
+	struct group_device *gdev;
+	struct iommu_domain *dom;
+	struct bus_type *bus;
+	int ret;
+
+	lockdep_assert_held(&group->mutex);
 
-	memset(&gtype, 0, sizeof(gtype));
+	if (group->default_domain)
+		return 0;
 
 	/* Ask for default domain requirements of all devices in the group */
 	__iommu_group_for_each_dev(group, &gtype,
@@ -1810,8 +1774,48 @@ static void probe_alloc_default_domain(struct bus_type *bus,
 	if (!gtype.type)
 		gtype.type = iommu_def_domain_type;
 
-	iommu_group_alloc_default_domain(bus, group, gtype.type);
+	bus = gtype.dev->bus;
+	dom = __iommu_domain_alloc(bus, gtype.type);
+	if (!dom && gtype.type != IOMMU_DOMAIN_DMA) {
+		dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
+		if (dom)
+			pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
+				gtype.type, group->name);
+	}
 
+	/*
+	 * There are still some drivers which don't support default domains, so
+	 * we ignore the failure and leave group->default_domain NULL.
+	 *
+	 * We assume that the iommu driver starts up the device in
+	 * 'set_platform_dma_ops' mode if it does not support default domains.
+	 */
+	if (!dom)
+		return 0;
+
+	ret = __iommu_group_set_domain_internal(group, dom,
+						IOMMU_SET_DOMAIN_WITH_DEFERRED);
+	if (ret) {
+		/*
+		 * An attach_dev failure may result in some devices being left
+		 * attached to dom. This is not cleaned up until release_device
+		 * is called. Thus we can't always free dom on failure, we have
+		 * no choice but to stick the broken domain into
+		 * group->default_domain to defer the free and try to continue.
+		 */
+		if (gtype.count > 1)
+			group->default_domain = dom;
+		else
+			iommu_domain_free(dom);
+		return ret;
+	}
+
+	group->default_domain = dom;
+
+	/* The domain must be attached before we can establish any mappings */
+	list_for_each_entry(gdev, &group->devices, list)
+		iommu_create_device_direct_mappings(group, gdev->dev);
+	return 0;
 }
 
 static int iommu_group_do_probe_finalize(struct device *dev, void *data)
@@ -1830,21 +1834,6 @@ static void __iommu_group_dma_finalize(struct iommu_group *group)
 				   iommu_group_do_probe_finalize);
 }
 
-static int iommu_do_create_direct_mappings(struct device *dev, void *data)
-{
-	struct iommu_group *group = data;
-
-	iommu_create_device_direct_mappings(group, dev);
-
-	return 0;
-}
-
-static int iommu_group_create_direct_mappings(struct iommu_group *group)
-{
-	return __iommu_group_for_each_dev(group, group,
-					  iommu_do_create_direct_mappings);
-}
-
 int bus_iommu_probe(struct bus_type *bus)
 {
 	struct iommu_group *group, *next;
@@ -1866,29 +1855,14 @@ int bus_iommu_probe(struct bus_type *bus)
 		/* Remove item from the list */
 		list_del_init(&group->entry);
 
-		/* Try to allocate default domain */
-		probe_alloc_default_domain(bus, group);
-
-		if (!group->default_domain) {
-			mutex_unlock(&group->mutex);
-			continue;
-		}
-
-		iommu_group_create_direct_mappings(group);
-
-		ret = __iommu_group_set_domain_internal(
-			group, group->default_domain,
-			IOMMU_SET_DOMAIN_WITH_DEFERRED);
-
+		ret = iommu_setup_default_domain(group);
 		mutex_unlock(&group->mutex);
-
 		if (ret)
-			break;
-
+			return ret;
 		__iommu_group_dma_finalize(group);
 	}
 
-	return ret;
+	return 0;
 }
 
 bool iommu_present(struct bus_type *bus)
@@ -3002,19 +2976,12 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 		goto out;
 	}
 
-	/* Sets group->default_domain to the newly allocated domain */
-	ret = iommu_group_alloc_default_domain(dev->bus, group, type);
-	if (ret)
+	group->default_domain = NULL;
+	ret = iommu_setup_default_domain(group);
+	if (ret) {
+		group->default_domain = prev_dom;
 		goto out;
-
-	group->domain = prev_dom;
-	ret = iommu_create_device_direct_mappings(group, dev);
-	if (ret)
-		goto free_new_domain;
-
-	ret = __iommu_group_set_domain(group, group->default_domain);
-	if (ret)
-		goto free_new_domain;
+	}
 
 	/*
 	 * Release the mutex here because ops->probe_finalize() call-back of
@@ -3029,10 +2996,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	iommu_domain_free(prev_dom);
 	return 0;
 
-free_new_domain:
-	iommu_domain_free(group->default_domain);
-	group->default_domain = prev_dom;
-
 out:
 	mutex_unlock(&group->mutex);
 
-- 
2.40.0

