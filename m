Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81415660;
	Wed, 12 Apr 2023 13:51:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHN+iHI5QjGdUV27afetVjTYnaVKsqzQWH6kTCKsf2X9NAh65gWBWSqb14mhssU57FVP0PSK72+7APHJO2kJWHS61Z7SMO/X7N/Hr79K799QnEunZhiD5j6l4TnZKQjhiyp4juKvldgmjJulYHAnQ5/ldPheuC2shvT57R55+Ho3swxXjJd9TdEdYOXOhUDpaWPXIcJcTEhuj7RpAKetyVXKk23t1VKeK7xG1J08ZR7MqHDhXroO+RfcOTH5Wo0Cuyc/oegwtFmVfCzU7YPrZtcYOiVb2yF2f/L4roubln/pg9GRFmr/Kl4yCow2lbH5MUDjqAJBDVxCLNzthseLTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2F+QwtUC4oNPD7rAYuYh3MB0tWTL494b/90oveei2Q=;
 b=CdhswvMh5HeCAeiFd3jc1ACvYFTTitRV/qHj4igS4RQhwHZUiJOxKNVmveQLdkQxT+FsRfVGt4BaaGA9gdxwyFTxM+Xf95DWyRVkaLfzs2LFl7bxv5asYEMGh2IEiFxox3zmmdygFZMi2ZyC6v+FpA8mpLW3ittySHkBYWvgwOs3fsXNAQxOE4a7pTxIJgAlirmDn9Bf332ejBqJbYqIkt01y6ggukXTcot4pATNK1NQHg+n+qUaqGl/EXlrz9Ogbe+v2aLnzOuR9P7qTzyY6UXgFBo8ryQQBxO8ZX9JXNGCqyr8rLkkiQ8Cbtbk54Iaoekuxgub+1VBIYEs8oJZKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2F+QwtUC4oNPD7rAYuYh3MB0tWTL494b/90oveei2Q=;
 b=jk8rqxhz2hTnynlhJo4zlkWuy3cNJFu/zbAxO+PKN2aJl9a5bjjvlknUW5k3KGm4Rl9tU6ejozxpxD+OvGwYAuJm71T5Vg2/JM6o3FlyNj4wpO87ulngMKVsH+HNyBXgM8G2oniGoBxyl/Wgck5DmMWeIYcCvPnDPdjMaalc3shGq2NUezoEuEO9hcnnMyD9b9eyNpZdsnwBUg7MxzzSp6frDGIb99L9vmhYdWTgnAphGt0X42vDiJmfbWzznXWA6xS0n0ZzH7WOWDDAxQjQhfYHFKpVswpvc4g5gKDO+rnyCPKXTbr3f/mmbHNueB4aU6r/dnXcwmFz3Au6GDkzkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6957.namprd12.prod.outlook.com (2603:10b6:806:263::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Wed, 12 Apr
 2023 13:51:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 13:51:50 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v4 12/17] iommu: Consolidate the code to calculate the target default domain type
Date: Wed, 12 Apr 2023 10:51:42 -0300
Message-Id: <12-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0028.namprd17.prod.outlook.com
 (2603:10b6:208:15e::41) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ad6d43-d8f9-486f-97e9-08db3b5d0f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/ZftkiKvFNLFO2YANEbUkEaGiN1nwl3Vv6saNESbWozDmYyJXN8PUdzhs3bBFEoWabt3jRbcuu7DIFUW0OuDqUMwGpuOS/n8RtztLUQ3PIxRC04J2C3aSxTkxaHIBRciw7mBolHsdo97vY4xN+XQU9GwLzct376rY0snfIN4ORyP4Ih26VJ30uhRB0mk/z3saR71W6tI1LlO6aUWKqUQdglRge1vi73s5oCVu8ApVRw6ULSnjdawqdlviVYogjrUP8ejvMHCAoL3WL9jSc7LDnNxEDQ/G/PlbFX/+mPVJM8XXYD63N2PgClLunsXlkauh229kdskoU4wlgfcfvbSdqSg7p0zgezd6xiQRZ9FEOgxxCbCoN/7T7aU04Wv35APYI085WqMiacaMIu9sqNKnsNWWLqo55S0g0j/fnzSWe08lGFLVTX/1DxRVjKz7p3It+CC4moaWiLeYDMO5Z4L3+O1Xq7czALwbWpAwuClBUMlWttaYeI81YijvIpVF4Lutf0c7+sZs7jfT/gdSBcGkWRJnczfW/yOsFsNewFOfa5uyrXXxKuCSkmmbuMPPhc2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(6486002)(4326008)(66476007)(54906003)(66946007)(66556008)(316002)(110136005)(6666004)(5660300002)(478600001)(41300700001)(8676002)(8936002)(7416002)(2906002)(86362001)(36756003)(2616005)(26005)(107886003)(83380400001)(38100700002)(6506007)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gozExTlJlH3McG22psbJc0i+rTeLkKd6GOK1go65LywVUMh3RpdD1psxoyiY?=
 =?us-ascii?Q?9Ur/RGsSBRzanLl0K+SJlXM443/KUTmC53NDcqeNnoy/Vol7WLsBzeZnK+WT?=
 =?us-ascii?Q?Jo6XL2OQtgZEn97dCfhXLYH2HJqOTnduTCOfWL3o5vrEAr+qZXaN1pbR0Iuy?=
 =?us-ascii?Q?ZayoDlsdxNWfxuzabnJKA74hdahXn0LSUOVHWNfPD1qtq0I1taxoinKcsLpB?=
 =?us-ascii?Q?g3CFDXLsk4ZxazEJkBwbBv4JLx3QcU/JwVuPU4XLwL1iNHLALMFhmyd+5VI+?=
 =?us-ascii?Q?acuSbagXq37/Zc5Pzxa1jKqeDHcKy3dY7uhvvs3L8oaLREGWTLh4Ps+QtG4s?=
 =?us-ascii?Q?n35TiujGfAvflGiafD1LgEzbRGF/hAoNujw0vTkpq6BNOCJCIqBHBH0u1TRh?=
 =?us-ascii?Q?mUDkRQvong8b9YG2DCab9Kb+SoCdmYeCS40jBBQJsGhQngN/f1tIX/N6caCU?=
 =?us-ascii?Q?PzVYh8x4CRYNItrNMcjI7cKsk3nFbEFgw1TKBLAAmLXL97ZerUHdGVQwyXcq?=
 =?us-ascii?Q?KkplhV4g41ZTKNvjesNhWtX/3AWD0l8a3tlZeaMUUju/MhnG2ZpXkbrmENBv?=
 =?us-ascii?Q?Blz5mDD4er3Pabtc0fa4yyyB43y1LOv1StjY4Urm6djXS9wHAWgUP60GGjXS?=
 =?us-ascii?Q?2ndIslaEVUvXyrdKXx5AiefMkSvZoUcUWnpuJQjcflF1GbfmQC7/pcP5qR0r?=
 =?us-ascii?Q?HqKcJFra0zj9X0lx15H+UA0Nx8QXSQe9JAmlDNSmVm/vjI6uCfPq3ONMXE5Q?=
 =?us-ascii?Q?Hv4WItV7Idwnp0HSrRoQtzLDv6oS+W7nMmHMr51aZ/FWoBn1gOGWi1yM/lIC?=
 =?us-ascii?Q?BDFF6bHhzyNy719605nV9xmpSHn0riLDNbUOzQX0eFbuiqiAaJuRPsQ4cynH?=
 =?us-ascii?Q?rAiDAoYPr9+/4cDHbto2SBGMXM4vGS3A8mXmxesa5necS1z8N+BGXzSrtqWH?=
 =?us-ascii?Q?jStawJEOriTGSaK52qlxiG0wcBG/5stqxsR2+aQuL7dHfFQPbLpV24wbQMWb?=
 =?us-ascii?Q?rbbTHrZ/cTc8KWHRU/UumNCj81Ho3/aah64rbp69gfPK7BQggGcuEC5Mzwq9?=
 =?us-ascii?Q?Li218hgv1vNqc9sv0iivRuEnBJekbIUpfp5VN/IgnhnDSUoeWofZaueNF+tm?=
 =?us-ascii?Q?scFUmZYbH2lce1yuqxZANy5yo0CXzrHCp9funEjSObQIGGQoblut4b/h08r1?=
 =?us-ascii?Q?MSCQMwf+hOm0Jgd8iSZGAJlm+yN7xEIDeM9R+J89uvAKZ3KuA6SKHEL6XoVI?=
 =?us-ascii?Q?Q9xzfPTrX/nsSMW73DSjKnoSRd3Zg9eEiIfdnniRf2coSD5Ahd5UXyxel6Hv?=
 =?us-ascii?Q?3VefIud0kNYBX8qusd6dn3zHsuzx+1tdzJBof/sIrqa1aSrjiMMXthZlM9oc?=
 =?us-ascii?Q?fSFaCILmTfB90cObqFGXe9ncAWZLaGISPimt1R5a8YQxpyPqv/rt76pwj35J?=
 =?us-ascii?Q?VPBR9nP0jPT6iWQ9bBh7bguA/n78tHPQmbVOJFMXOJQUDorg92MlXqaK+5Tu?=
 =?us-ascii?Q?e+EPG7oqmuVcOkc9CHbrGzlOVAQmd6trV+0eOQcfaP+gNCOVu2wAiOTWn3Hx?=
 =?us-ascii?Q?87JTGqn5HBnPuZ/2m+kS5ZZcg1l0ym0iN4+cYuMV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ad6d43-d8f9-486f-97e9-08db3b5d0f64
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 13:51:48.1672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJCPzZlPOpBTGuZCRspR761/NNvD3yOEWh+TsJ6dxx6rzjJTvPbmpDz53RnPIxvb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957

Put all the code to calculate the default domain type into one
function. Make the function able to handle the
iommu_change_dev_def_domain() by taking in the target domain type and
erroring out if the target type isn't reachable.

This makes it really clear that specifying a 0 type during
iommu_change_dev_def_domain() will have the same outcome as the normal
probe path.

Remove the obfuscating use of __iommu_group_for_each_dev() and related
struct __group_domain_type.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 88 +++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 57697cc877de2f..df82d81e92f24b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1782,50 +1782,43 @@ static int iommu_bus_notifier(struct notifier_block *nb,
 	return 0;
 }
 
-struct __group_domain_type {
-	struct device *dev;
-	unsigned int type;
-};
-
-static int probe_get_default_domain_type(struct device *dev, void *data)
+/* A target_type of 0 will select the best domain type and cannot fail */
+static int iommu_get_default_domain_type(struct iommu_group *group,
+					 int target_type)
 {
-	struct __group_domain_type *gtype = data;
-	unsigned int type = iommu_get_def_domain_type(dev);
+	int best_type = target_type;
+	struct group_device *gdev;
+	struct device *last_dev;
 
-	if (type) {
-		if (gtype->type && gtype->type != type) {
-			dev_warn(dev, "Device needs domain type %s, but device %s in the same iommu group requires type %s - using default\n",
-				 iommu_domain_type_str(type),
-				 dev_name(gtype->dev),
-				 iommu_domain_type_str(gtype->type));
-			gtype->type = 0;
-		}
+	lockdep_assert_held(&group->mutex);
 
-		if (!gtype->dev) {
-			gtype->dev  = dev;
-			gtype->type = type;
+	for_each_group_device(group, gdev) {
+		unsigned int type = iommu_get_def_domain_type(gdev->dev);
+
+		if (best_type && type && best_type != type) {
+			if (target_type) {
+				dev_err_ratelimited(
+					gdev->dev,
+					"Device cannot be in %s domain\n",
+					iommu_domain_type_str(target_type));
+				return -1;
+			}
+
+			dev_warn(
+				gdev->dev,
+				"Device needs domain type %s, but device %s in the same iommu group requires type %s - using default\n",
+				iommu_domain_type_str(type), dev_name(last_dev),
+				iommu_domain_type_str(best_type));
+			return iommu_def_domain_type;
 		}
+		if (!best_type)
+			best_type = type;
+		last_dev = gdev->dev;
 	}
 
-	return 0;
-}
-
-static void probe_alloc_default_domain(struct bus_type *bus,
-				       struct iommu_group *group)
-{
-	struct __group_domain_type gtype;
-
-	memset(&gtype, 0, sizeof(gtype));
-
-	/* Ask for default domain requirements of all devices in the group */
-	__iommu_group_for_each_dev(group, &gtype,
-				   probe_get_default_domain_type);
-
-	if (!gtype.type)
-		gtype.type = iommu_def_domain_type;
-
-	iommu_group_alloc_default_domain(bus, group, gtype.type);
-
+	if (!best_type)
+		return iommu_def_domain_type;
+	return best_type;
 }
 
 static int iommu_group_do_probe_finalize(struct device *dev, void *data)
@@ -1881,7 +1874,8 @@ int bus_iommu_probe(struct bus_type *bus)
 		list_del_init(&group->entry);
 
 		/* Try to allocate default domain */
-		probe_alloc_default_domain(bus, group);
+		iommu_group_alloc_default_domain(
+			bus, group, iommu_get_default_domain_type(group, 0));
 
 		if (!group->default_domain) {
 			mutex_unlock(&group->mutex);
@@ -2900,27 +2894,15 @@ EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
 static int iommu_change_dev_def_domain(struct iommu_group *group,
 				       struct device *dev, int type)
 {
-	struct __group_domain_type gtype = {NULL, 0};
 	struct iommu_domain *prev_dom;
 	int ret;
 
 	lockdep_assert_held(&group->mutex);
 
 	prev_dom = group->default_domain;
-	__iommu_group_for_each_dev(group, &gtype,
-				   probe_get_default_domain_type);
-	if (!type) {
-		/*
-		 * If the user hasn't requested any specific type of domain and
-		 * if the device supports both the domains, then default to the
-		 * domain the device was booted with
-		 */
-		type = gtype.type ? : iommu_def_domain_type;
-	} else if (gtype.type && type != gtype.type) {
-		dev_err_ratelimited(dev, "Device cannot be in %s domain\n",
-				    iommu_domain_type_str(type));
+	type = iommu_get_default_domain_type(group, type);
+	if (type < 0)
 		return -EINVAL;
-	}
 
 	/*
 	 * Switch to a new domain only if the requested domain type is different
-- 
2.40.0

