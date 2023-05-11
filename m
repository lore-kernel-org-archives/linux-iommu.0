Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB85B645;
	Thu, 11 May 2023 04:42:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjxDGY+zsIa7UQNGBY80vu7LL1A3vvLpxwiwaOO230o10rkQ/0zYQa8b0+wMkGjAGMWoKRZ/yyYY2H8zuZPob9ZZHnxHcyGJg9mnL6vEb21HIJZxVUs0LOJvoRpqpBAOm5DShzRGdDxU2xKXfJGR3JRTNxAtQbjp9dCzF06EmGuaVhTnM7qFCHeLTV+xFDr7tlrPRdXl22GMmM3gPnKm96qlTZNqdIinYBSnoclI7YEs+rN6abigaNHr5jjRE4hupoUjbyr+MDAW3sNpJgKC9BUi/j7ONA978AJJYqgVzU44AFediQFx0p+H4KYpmwCZ8v+vTa9L5yLAEXx1Xujo8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMmNn9HgLH1bkgiy43d1NXQF1mhcrhULalYx8TBKbEk=;
 b=kiL24iETiUGPGZ12g2oJWcpYJhClBQrdQEZit0m4e6VX7qUp5BrvW2HQ1vpFXB+WVE/CJ3nB88Q988Su0Ipntvt8YrBjzfHHnKAQP7zyLGIn4QUks9ovVaiLSEuE68SakYfnagfko5YUFutz2sRLIlZhIWbURLz9ho8L07OYENTZPYQJ/+ZfxTKyRMhxD1Hx7+g5w6I2bk3VJTnYgL55PwUBZgPceV7wV51AhrJP1QKmzYr3S0idMj5+248weNDsSEexLDKAN/EORcrRuNHcatkY2PE2p7ZimUf9EYnaP1qav616T1PQbLWaOTH7N4kQ6q7BLoPu0DlvYGcWGlGfMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMmNn9HgLH1bkgiy43d1NXQF1mhcrhULalYx8TBKbEk=;
 b=UjC5n7uNgwbHmRaj3pHQflBswwXQeyxFAv7LsUi3ccfvrP93KfuIo2XutcscmsfdJqvclEq7rqSS3Ziw9pUgmkXFpwit15H0s22OeFO8NXTniZzchF5vFGq2bAjoQV8qB6HPcTYvNYMcDWizcO5H2+mkBO4LNIKBXTUf16nNGgUk7f7ksFy8Yntc0d1wixU5742DYXn6iWMluPREzDzhH9IRfAlo0RwACLp+Tj1EWRfCLvmoMawy+nWBDXaI1q1BgXXkVtcOZK4AetHygAMFsE7HzNWRkjtrvlHljmiJoPKF5jORtnAPJqGofsNHSZgMUek+uNK0zqWhQKcZwXfc7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 04:42:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 04:42:24 +0000
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
	Heiko Stuebner <heiko@sntech.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v5 12/17] iommu: Consolidate the code to calculate the target default domain type
Date: Thu, 11 May 2023 01:42:10 -0300
Message-Id: <12-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: d90a9b83-f3ca-4c99-5927-08db51da1a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	plHDVcmQJ65aFAHXtvk1lcCyFjSfoaes1bPqpOyYZEg9h7WZ6JTTlO3MuV3tlG4MagnQA9IuJ1TlG6ztf4Ncvjmq0DpHHusj0pbJwsJ+hcDo75ajgO/5KsU1E4dOLOLdOrHexaL6bJDMXJKN+OeUjXZyFTk2/IOud9FM4gm2/MXuxK34wXMhChZ5uwN6EILDGeOEjUG3io1fywuyjx2mtJL8YevbVwoJlmobKk+RhN4wO2fA7179WtGKwjnG+ru6Zh3igX6Dz8Qz/LmpkPnKzd8HRbzTkanmY0SkoP2yGVBIrLvDBt56LccpbqKg4DhHcjJUjyHTkBFLip+9wqhWHKQ5ovamW66fpzxX5yqNyE87RsjXqqkpvBR1ylhHqBlQJ7bT6RAKR45bKAVqQNCoLJBAqmh1km77tPke/FwCVb9a2Uf86o2CXm0Ul3YwDP1ckFUB1IZCSR/ke3WRKbP34bgMOZfL741Lb6eF2hlFmOelPj760JQRwCfZeiF82OstnbIMg6rSlsPUtgT/xaV9gQeYp4XHzPyhWPASJGQAJRY78iV8DtvD4AzjHa04qlqM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(26005)(186003)(6506007)(6512007)(2906002)(41300700001)(66556008)(66476007)(316002)(4326008)(38100700002)(83380400001)(8676002)(7416002)(86362001)(8936002)(36756003)(5660300002)(2616005)(54906003)(110136005)(478600001)(6486002)(6666004)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rj1cQBraKp2xBEwnVfPjNzPi5POwtgPmPXdNnOx299FPX6aK74z+DDAp0/NU?=
 =?us-ascii?Q?tFfv2Kat3kXWRKHvI9+tUqJeSOzxrNR0QQU4l4qQ7KGEoL7mpM/D/6yUnDq7?=
 =?us-ascii?Q?wFfNQOIbtCNZGv/JiWK4rEhw/YltgqSFyeRyHQnHmNGVxWFNUKJ6fUd2MrgI?=
 =?us-ascii?Q?ARkrzSvtWxIS9+KfXhETDrdxhBTOxEokZLlYxTgiPNfj3ULWzLVTepRDg6WS?=
 =?us-ascii?Q?dQBgM5mVnoUZI59Gg8/hF3Kbs7jW4xvZOUMs4LwYQKVpDlEYH/3e940jmO9C?=
 =?us-ascii?Q?1sg01RSDs2bEAqqNO6fQLYy3lUD3btgmxGantZKu0BExKr0ZG6Qlecfiuqbo?=
 =?us-ascii?Q?JDLbIRlpUAshAWcQOv7ygdJC5zd08ZaOERBaW1TuKPrkycft2ZS/Tfwz9sEA?=
 =?us-ascii?Q?nZ8flg0s9/AfiqPIXsTNcfzIDfrDS/OPQS3cIAaMa90VCcfFdmS8OOq0DoDX?=
 =?us-ascii?Q?GKs82ZLE+FIUipRQ/wbQhBCYPRmLNCTrT8KGhzLjF8Cr7BMEiKqMDrKDkmgu?=
 =?us-ascii?Q?he474jcwoayWtuyQ1eSfxBOWhEe88cuvVAk/n7X2uimZnZhsQ3TkQcJTeJqw?=
 =?us-ascii?Q?6o7DWzKj1Lwh+W75RG7MaPrmZNku3Kx6hW8t0CMvz2oqWJcJemcea6s2xnx6?=
 =?us-ascii?Q?d2owo0pcE22d9F31DsW+IWaA12HNyYxBBtqwHd3+NfIPJ298eGHwZ7Ozw+uB?=
 =?us-ascii?Q?BXnH8NZnZtaMwTYinOhr0M7Riv+CUDLN8FN+je3MZeho9PlepU6ZUX+X+SIJ?=
 =?us-ascii?Q?u8263fu4KLngouru835UckxYC3hK8aYW4q0c8F4OZGmmo0GDaaS6sRGbdI/K?=
 =?us-ascii?Q?YL2X1YtuUaQKlYaNhu+tF/LUGmHg/ACmfqEiLRkbck47wF7IMTYK2WfxlK32?=
 =?us-ascii?Q?dR2H+4Vn2kS7F8rZRBNerqygY2egm9HkeKMkU63yIUkKDA40QGR/2Bj2+Di3?=
 =?us-ascii?Q?xUK8a1gKE/l1gEannZdex37PMS99HOhXPbLg2o2ZUdaqxURYDmd+739SwMOc?=
 =?us-ascii?Q?oKGRPk/UiNbQJ9Nu8V0ZufD4SCp3O4qelx3vGCMuZkz/jBNj07KmnJqINfUP?=
 =?us-ascii?Q?P0tdx5usEvGc63U0TTQ/NQwJREo92X/WNlbQJLgUm2F6w9dBbfKG2vHKQI0A?=
 =?us-ascii?Q?aOpegVx4YnYA1VLP3NP4fgzNR0bFy6n403Yefge8QMNgzqSkiGBzed0dluf8?=
 =?us-ascii?Q?pwNUW6ZaM+0bC5/PfhqN7LPdYP3CNiVa7mLJGt25GVgYFlt9SGSkiZllCBZK?=
 =?us-ascii?Q?7+mS0zWAWLmgJrckOUx5mocxqifPH21Ob/wJC05puZa0SPk/ODx4Srrqo/la?=
 =?us-ascii?Q?MgNUssjH7Noa6hCpccmRR588CXOpP8kV/gqu0oEOx6+90I/h/h3xnru8DeCN?=
 =?us-ascii?Q?RX/yILvAPf6qYqdx1MyyGG2770Wm1W+VBFfwolYRjjJFFdfXajLbzBv3wDJv?=
 =?us-ascii?Q?I7nMPjrWiBtLDnXSfGC7laRfhGxcKyAHXEk7+pyoO/SzWwV4hJsfggs+uBb9?=
 =?us-ascii?Q?xoCwSytsz1ZwveeS/azEGEvZRqueGn9Hfr+no2ydmMdQQ8uE2cZK4TXb7cOJ?=
 =?us-ascii?Q?RIjqtfMVcsIVHh+wsTRO9MA8GptLMtmHfy4zsM/V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d90a9b83-f3ca-4c99-5927-08db51da1a34
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 04:42:18.9695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hv026Nuppj+SSgHLi1TKW2BH+xWYAyN4rI2XRJrMU4I99YJ8qXqPGNS5h4WNkEdE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054

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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 88 +++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7cafd830d2067e..8242ac609089ea 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1758,50 +1758,43 @@ static int iommu_bus_notifier(struct notifier_block *nb,
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
-static void probe_alloc_default_domain(const struct bus_type *bus,
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
@@ -1857,7 +1850,8 @@ int bus_iommu_probe(const struct bus_type *bus)
 		list_del_init(&group->entry);
 
 		/* Try to allocate default domain */
-		probe_alloc_default_domain(bus, group);
+		iommu_group_alloc_default_domain(
+			bus, group, iommu_get_default_domain_type(group, 0));
 
 		if (!group->default_domain) {
 			mutex_unlock(&group->mutex);
@@ -2881,27 +2875,15 @@ EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
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
2.40.1

