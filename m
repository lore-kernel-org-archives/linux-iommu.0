Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38CB322A;
	Wed,  5 Apr 2023 23:38:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrJXlPyY0L3LOL76yivhUpyy1L5fTGI3It+a/aRSX0KzlW9D26JG1d1j0EPqV4RrzN1Cq2GyA6HJ44zhqiHEvB6oXqTG5Yz0kHdEnRCmzoZk9j67dOJXP2oAYzdISVoW1iHfclmJIIPum7D0eYmuqVgYIdVP7RSdSQ/+9PWbkpZ8xKRoPVEBmd6E65rXkan60YXE9SOlOx4sgkroOz5du3DXqlULbXp3Ubx7Wa6/fwEyZkqFo5ptpqX2jzNpIimaLANm3VIdw9O7XdI2Cp7JH3tjUSHYySuaOVT22C/oVAQtRtqMbOyDZuwPTtICR6RnBWAH22oA2QPtEkT0xzM0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UJzyMMbQuOzm0N7GujXSmxKePQxYLjzZZPTqDtxIps=;
 b=dGSHdUGEXi7UGfV5vef4j5HoCSUj5CfmAgGAdQgcwZxLuhbkmpDELTSGy4mQRL82Iy39uG7k3m7Jq4AQDbE8suD0aww2iqcG1JZveGYBtOJ7zM1muvldCvyC03pEnWmt8ay1JvjaK6/rf9aDJvRDODNGiDdg0NsAcBPB9/njgbhQxiInIT9wxO3Gj/ShCO8pYpmu4Pe7/mFmShEIvsWyDpPWIuSCUgCWZNhn3XIlY9TDeARFrHrXzQf1ZAdsdYpekLnlygM9PZydZE0Q1+uDRDJ3Wb4q4JL2acKY7mO9iQ36FTH5QyUunaDE2xH2mSmcYtsCKinEXq6ZtrITu+FBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UJzyMMbQuOzm0N7GujXSmxKePQxYLjzZZPTqDtxIps=;
 b=JUsJwNSa1bfeT2aLzRlObYuVT3oheXuT935GdX3xtVHHVDd9yRcYm2xPbQI06Kz6fZgF8z2g6GBVDmQrot4gbcdJz8PLOVFuf9IWaw/CYMzs0BuW1aJGVHy9E1b55++CMl/sSnSMC5Xc48dZ3ZWQP0vnaOwoHqCy58o+VOuakpex3KJ9zs//V5AM4zova50Pxmchx5bQedHteLNw8Y+sY34fKQMUT81jXW+WNSQkHmdef4p5PIQhbz5NhFzGBu+2tnZcJCuTtaEfH0mVlNIEyPH1xDY77Fgktz6Y4lw9Bu+NzAm5qWT59E97HUeiRh6PKaXCTnxJ57CSoTWzEsHI8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 23:38:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 23:38:44 +0000
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
Subject: [PATCH v3 12/17] iommu: Consolidate the code to calculate the target default domain type
Date: Wed,  5 Apr 2023 20:38:33 -0300
Message-Id: <12-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:208:d4::45) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a2171f-ff98-4167-d8bc-08db362ee2a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vRfu7PLrlybgkilZ5wnOsN5WZ4AztjdujDroJdF0bROyr1ritkXylEWtYl081ihKnINHdulxmVD5GY2AW2IOGbE3VWcA6cTOvcbrx1oL3qtoevbj/EoI5+kzz31p1L8vqCzyXwv4Smg6VZAhvOixkzqo68vbOKeGwmNoUqYZPi/dx0NFqw8n3UWyom38e324khVcHsyJFA3eEMts+nZGURcvfc7aCbxmjwlGVBf4/8Q2DisV+S4eJhyY7l5RCmkV7k4HIITF1U4dI7Z9PQyBcm+LHHkwJmY3sz/+Ycig/MfiW82tQ7wLTmM5zbd4odpLLWj9i5x9fxVNi9RnfPGGfrRPyj6NdPhDP5mtC9rqoniXBex+mPe8mcZMra9yyX0urazKDt8vCGSxlRc3XLG8BU1OljkgbYBNBUV2qW4v3Tub1tuPPqbwx5H7C9fNGFGTre/TfdErC/cEYhpr0rp1OKygWQLskhAzmZOoF6GUg27Q3UBHw4IqVI4ULq4O3ySs9U+yo9RNJRNOeCcUzsFb6ChC14vW4oprDicRe2IBvFZz/d2xoSCL6MOxdlK66odW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(2906002)(38100700002)(5660300002)(8936002)(41300700001)(4326008)(478600001)(66476007)(8676002)(66556008)(66946007)(7416002)(110136005)(83380400001)(316002)(6486002)(6512007)(6506007)(54906003)(36756003)(186003)(6666004)(86362001)(2616005)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RSHt7ub1IV21Hg3TJqYIr7Dcwiu8uJLlNfHeBNma4Rdb9TWzOB4/1YWxr463?=
 =?us-ascii?Q?/3tpec3J8RInyKEj+HlNre/oNjdXDGdW/9sz98Hc2oYKsnTm+B1PfgiYN8Hv?=
 =?us-ascii?Q?M2XOCp6DN3ZQaB5ppgZF6EMaF67kNW2r83SbDYwRsQyWk0kZn8O1ltLdm30t?=
 =?us-ascii?Q?PpK4RHGuXMnpO7hX7Txq4RYyLppC66t2ba5iyri4TTX8DO6On0WQ8VZvA4yD?=
 =?us-ascii?Q?FUd11OyIZ9vrgKG1hTJDYNn5vgbr3yj/l/rIyfNmin9pCMcTnpns3og1OpIc?=
 =?us-ascii?Q?cJY8Gq7ICJ6/L72Q31RITmeprykBwGYcgcMCn0kdcjuw7uDkyk1SXUu7j/ry?=
 =?us-ascii?Q?Xd6A7R8J/8lE4opJX60bBu/RFyT+qUycPhiXmcxnVwJl618VnJknXqY5Z2j4?=
 =?us-ascii?Q?bC3VO+ecyOkx5fiSbfecnxWP321KNPcqBoAkmT7bbMVK5ezcPz3O1vIul8Ev?=
 =?us-ascii?Q?pvYmrWSsXZdxGV//zuQ+OQ0xxOfe1Q/w1AFItVSRtmJsSJaCLcSYTftZHayZ?=
 =?us-ascii?Q?lR7j/7yOfIevYGJ/LdQAMjusl7JhbS05LRzM+3UZyf7DwEXLIkrj0EXEpb/x?=
 =?us-ascii?Q?MyAXt/pnQEy1c2QsByndr9sody4lHu9nA8DGarEpCBLUJHrtbCbYUjethNQN?=
 =?us-ascii?Q?xYnTULT/+gWDNu7pkuaHsTu+wQbM4Z3IKn2JDC7AhTUyqkz2q70QmTmm3AzM?=
 =?us-ascii?Q?RRbdLiDHfKU4+hclqbtU1omqYt3l/FOW0E6OmQ1PU1EWfmfzjTFNGKhbflra?=
 =?us-ascii?Q?y3wJbx5xpQaQRIm7AujKVqEXi0ZRRWJJDNDilxUT9egzxLcInQ4ufmtLwaVi?=
 =?us-ascii?Q?4T2nVvyc9yyiwLkEnpmmtCRBVr5HjAVxOIhoIsEMdYWyYj4aipaxFNsJBI+Z?=
 =?us-ascii?Q?Vdkhpmk5UpLyCWLkYWKIGe3+vIpInK8LoGNz6oUZx4GFTqV+Dl00TZcYdozK?=
 =?us-ascii?Q?+gLqwiOEk3S1AcHgbkWJdfyPrF1lBz8wA5/xKTAhE1RBIIOMCKt3AWKGE5Fu?=
 =?us-ascii?Q?muBvWe5oLRhuPygJY3ooDxi4EHfPK/vh2oJNvcd1CNuWpnI9NQYv+hpsRODP?=
 =?us-ascii?Q?BlYCeTfmexaYOymtFyxncaOrcl/v2Fl5L4UJ2TkRmHUCqKvWHLn1RVlaaNlS?=
 =?us-ascii?Q?2oHpjXRjJXCqVK56KtITUDo/zY8VawtsbbWOdR1cvn7iCRB+JYq1i+OR4IHX?=
 =?us-ascii?Q?+Wdw1U0YwbQ7782/32JTKNDyzpMwRwJT3lmmjo2EJ7IxTLad438rou3nN7Lf?=
 =?us-ascii?Q?poC8ZpSb/uhaI6xXvSvW7gRKsP4b0oQC1DHzaou3gygJyW6m2H2yABOh49fu?=
 =?us-ascii?Q?tpLPpJvpuyqmbDYExnRC8aExjSVpfdAhNiWF/vuXgP0QkM+BHgukyGPmtjgd?=
 =?us-ascii?Q?onCsnjCQCfWPOf0cRO/jhFtK+impoooPdJXq+c68/fMAahHX1FV1tzR5wSUd?=
 =?us-ascii?Q?rTQ0p8zZnWIjwLz15LenX5cbLR9BNlow6OQnACqQGrAS1bm9rIzQJHnCV46O?=
 =?us-ascii?Q?0N/ZZjk6FMSQ3E9ngMx9+dpNDhz/0q0hhSUz4ZzTeY+wrZRfw3E4dLqCyYRx?=
 =?us-ascii?Q?plpQp8+/HK/NiUNS4/j4QP7/5tI2x6ODXRv3JahQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a2171f-ff98-4167-d8bc-08db362ee2a4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 23:38:40.3607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTAXkEOP6Ovl2PvyBpJgBIhHl5HK8g/MoN7EGzrdGOU3VQUFwNikqngQnE5v7s3/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879

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
index efa6f193dc9da0..8623d3edc61014 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1810,50 +1810,43 @@ static int iommu_bus_notifier(struct notifier_block *nb,
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
+
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
 
-		if (!gtype->dev) {
-			gtype->dev  = dev;
-			gtype->type = type;
+			dev_warn(
+				gdev->dev,
+				"Device needs domain type %s, but device %s in the same iommu group requires type %s - using default\n",
+				iommu_domain_type_str(type), dev_name(last_dev),
+				iommu_domain_type_str(best_type));
+			return 0;
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
@@ -1909,7 +1902,8 @@ int bus_iommu_probe(struct bus_type *bus)
 		list_del_init(&group->entry);
 
 		/* Try to allocate default domain */
-		probe_alloc_default_domain(bus, group);
+		iommu_group_alloc_default_domain(
+			bus, group, iommu_get_default_domain_type(group, 0));
 
 		if (!group->default_domain) {
 			mutex_unlock(&group->mutex);
@@ -2929,27 +2923,15 @@ EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
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

