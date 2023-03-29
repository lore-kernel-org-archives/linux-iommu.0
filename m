Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DB4AD30;
	Wed, 29 Mar 2023 23:40:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQsAXVB4xBwSM01kkXqQgd+gFRig6aw5Wjb6JasWe4eiBqNPhWY/RlXITMYz8hEqCJ771BOEckxlgGKzNXM62vsOP91B1/HaF2I+Vp4fG24fIvgryVry3EsWvDM1scXuu2SNJFPSXYxay117lE69Pjq/kOcIoEKY+zbGINxZ4E2q+ZwIQjF5cSg5iTt7yPCxJaW/c2x+W8EoIXU6fqrV4VFPl1ipJIKVAS3DgUNNguLNXUqMP1Ei4teQw3QOhDrNKJHe424WJvZOJkQjhZDNwWcqhhJRV5+2zjJeEXk1bjboA1LOGNxX/n1X6uVe5OAOnSxnfM87ubvsrIjR7BEy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDzMn5gz9lkM4fsmHLwseLFdrB6ZcparknPFKf/9fJU=;
 b=Fodrkjg6417GYmsPV89L21T6gOmTMIdiesSnNPr2suTDZRXXuwAQIn3u+PcpZgn0MPcXtC2izfYzSUfIYRp4TcvCcEYmGTTkpWpzHqOgbmM1+TsT/k/JUa1Md2aUi2RWnTgK83t5YGMl5nFlMf/LqG9bvtsTYUXvuUizznEar63k55Jag75xDjdhHkLmLLDXhIKhAoUqzTrlEr+sNgIEtjFoa+rGtM/lSG5F/B5vEx7T3HHce8eMEnBB8PH+H4mhxsQDaseHW+Axwv0ld5o9vNu3Gt6tOaj6R/5P9id+Q6DuG6YpRkPpeTVEMFaRqWdVyVW0plPf/ng3zNSj7Puggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDzMn5gz9lkM4fsmHLwseLFdrB6ZcparknPFKf/9fJU=;
 b=BlC41YPn5m08xujqmfSCD4WLrJ2nzSWeg49YUuPpL9KEeMHMuKA45IanieUsyz/JsWW5cxSb9uLg7nhGMKUES5oXqD0QiLOr6VLN2elF7twCOq05l+rXBQD8v7sXXi3fFhk2B4ieBP6odfnvrBAbSKPl6lD78xQ/jOjwllzMP4m5C+f8U6YTi2ZoorkWpn5vWlkvr+R2uX0HgtJcvT14R8qpqSFd5fam948Pj3UkDEqTd34pmvepc7Y0TcD5EzWxppagf/GaCUEXTHv4oRVP1dmmTLcGSUAYUxvhb794I3VUMRFOiDHNcLihjEEis6IlyzBWSNgoHc9ipN4grjqubg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4515.namprd12.prod.outlook.com (2603:10b6:5:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 23:40:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 29 Mar 2023
 23:40:39 +0000
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
Subject: [PATCH v2 11/14] iommu: Consolidate the code to calculate the target default domain type
Date: Wed, 29 Mar 2023 20:40:35 -0300
Message-Id: <11-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0274.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4515:EE_
X-MS-Office365-Filtering-Correlation-Id: 15d156af-f194-4658-0655-08db30af0085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bla3/DjaTLkD9pEMZAE0USnVVXwLUOyP96wakIJy+E4jhREcmaqBibZzJqB8/zCHOyNHTYoGXRVEKAzb/xq0WScwrsHBU6nAb7g9eYYd/tWoNBvvzxUEJdBqdfG21XuMeRUOq1VAf5lMTODUogfFGQlnS2UNkQjSpA4ahnQqHC3P/sZyBJHAIpaadG0Yrlr1K5qBpLV5izAQeVsAt/8yUnlL6qKQDZzuhrVxtffRPkkHV7lQs9QK1a+ePV/bvXK0zVzZ/beS4ifnL0Z8nTi0MhrDsrcGlTh/eKk6UfQ/EToCj0zUq+ZDkB3S6yAiw7y0xRmt4fdCI4bkk760xOrKwqRV2GTj1YJamTGTQWepkjU2KVmHl7f75sWh9M/T/mqSQiy++rYnHQvnh/ch3sWaU0AMRsO9wV9rwQQeoJErhlvNT2KmqK/muXnAK7mgLV9GS9EjkJ82rHIRGjoJxOW05LpA3kUXjNbuMc7oapqUz/hm8hxUD8ja5Anp7ZqtPsEOKE45mmdmfsT0aIyUSHSifBDipWTVc9x0Ff0pQ/U8HVwJKuvEuuqejkrmi+hq29yj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(83380400001)(8676002)(4326008)(7416002)(36756003)(5660300002)(86362001)(41300700001)(8936002)(38100700002)(6486002)(6512007)(6506007)(26005)(6666004)(107886003)(316002)(478600001)(2906002)(2616005)(66946007)(54906003)(110136005)(66476007)(66556008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kGt/KE+agoqh+xLd1bD/iAyf9wBt9Qxm6IovfZqZKeaJ21PyuXkE/ZJZ9447?=
 =?us-ascii?Q?M/qjuV213COGPQ3cKs6mKd8URF9g6KCEsV/o8Hgt6VWJjkH5sTq+otPODbsP?=
 =?us-ascii?Q?d8KWaQ8fETtDxhDtZB1+Z5VMsp2ffd+yin7XYrfkOSjIu1rAdT4OQp/2VIm9?=
 =?us-ascii?Q?8NevDxcyUDPIgixvMw47VocIDAPlYwzzxa2HMUcPk8XgUBTsqxOmpbQBFzo9?=
 =?us-ascii?Q?iT7+9zzuqKwu4+54TcGAUOqXheha5jrzQg0LY2DhOZReZuRZeuRpjEW42QMY?=
 =?us-ascii?Q?7aCKzs291rJoiSYZ6uDgsCALcFxg0F05V2A+YsAHJLS6ysaFeVJQ4cdhoc9o?=
 =?us-ascii?Q?+DhAEXe87VZJWWKg2cLWXFf7K+iq5JgeH1MPh4APVrY4Kv2KpRxkxL18FbAr?=
 =?us-ascii?Q?SzM/PdsBgJmgRg8af7xDDkRMZ04ZaR6TuhEqsq7u4V/0O0sxtL0sBBvr5+TR?=
 =?us-ascii?Q?OfjU2dOGoztleJfvpbDvKiXvnMzuI5NEBQe+gNnok6MqKlvrurqK/0McVue3?=
 =?us-ascii?Q?CbIlDzoq3bcTojK+MdazfNycrnplNpzTZhdrtJ2ccXtsZKA55C4KSu/qT3B/?=
 =?us-ascii?Q?xVR+h0ADVvx07zV2LoM9XgK8q9ayn1gsVhF5A82rQOXQjVg5wlbQJ9AfyiVD?=
 =?us-ascii?Q?eAfOEeXUaM/WN0fcUcKwdUppaBnMNwdEGA6CYpeAL4pAgipr0Dvp2rPgiqQ8?=
 =?us-ascii?Q?sFE0VroDFmFyvcTBp8Z8aPmYhTdNToJ9MrX9IJpSY4YfO+txCn4vbhP63Qp3?=
 =?us-ascii?Q?D9HFi/qBAddzT6njT66ldgpV3Hft4YMggHy8I89Xb8rY1wCaJ10X/eL2fDSy?=
 =?us-ascii?Q?D/0u8mA9GpxsgZAiIwALREQNRA6CpaEvH7Yfq9aumZshpxE9fK/2NhWGc0Uq?=
 =?us-ascii?Q?QuIzKbFWAsN+ABHabzWuS9T6erSWRsStUnnCDNYtGrOTZhqjWKB6xMgiQo+W?=
 =?us-ascii?Q?ywuuQhcXqVG8uYQffP7HDh7B6drtaKJRBhdvIZCRETD17EjnUJU0akNu/8Gt?=
 =?us-ascii?Q?tvUSvGqNDWsCPqoto3oygIhqDcwRh/GW3zPKnDge0iwLbAZ+sFltl2xwhCfv?=
 =?us-ascii?Q?jCWawWSMRKEkd5Bht5t80yyX3gNZsBSM5KYuG5ZyEmwYKzuBlTw3mtNyJJjg?=
 =?us-ascii?Q?kzuzdoueDYh9xFVWHzLA3oOOqbvalW6poQV2JixTLJzYq5g2xImlNWIwhX6R?=
 =?us-ascii?Q?jAFsxx1CWeZXZSOoQKdN9qdQXMFsQRpKewhEhyjzYhUJwr9TuBdQZ91zBbNH?=
 =?us-ascii?Q?33UW9v7QBDXyYsHzY0uDZLaLsTYwTHlVMNCaLbsH4br3Sq217m1md8fXqYeN?=
 =?us-ascii?Q?qY9WFkp8FFz6hMhUJTztECvO+XArr+M1ipCDoqXhrEjMFdXVo/Das2/ltuHY?=
 =?us-ascii?Q?FDqQfjcefeY7T6PxydpEeZnmWXumCvTgtJe2osn8lJFFBXyc1dBB3S5hoIks?=
 =?us-ascii?Q?z8RyW4csQuMJ4v0y4hKr0ku0fhbd/YKp+5k5SjJ0Amy476Msyucoduc3F5Gw?=
 =?us-ascii?Q?Pt7S2D+k88piV8lrgHSHvYIMxMMXBVMEvUtOK1IjlnSec/opSceZshte89Qa?=
 =?us-ascii?Q?dgbic9jNEP+8OI8WZkU78Z4yVW9LRKOKT0ff35iw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d156af-f194-4658-0655-08db30af0085
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 23:40:39.1059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nKNk7DFiHZQtup3NZwtaXRnBI5jJpgRRSJ3R+lR/LmwWUJYDoGzlLFLUDEekErI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4515

Put all the code to calculate the default domain type into one
function. Make the function able to handle the
iommu_change_dev_def_domain() by taking in the target domain type and
erroring out if the target type isn't reachable.

This makes it really clear that specifying a 0 type during
iommu_change_dev_def_domain() will have the same outcome as the normal
probe path.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 88 +++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0eee54d47757d2..79e3fa80d0f6cc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1809,50 +1809,43 @@ static int iommu_bus_notifier(struct notifier_block *nb,
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
+			best_type = 0;
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
@@ -1908,7 +1901,8 @@ int bus_iommu_probe(struct bus_type *bus)
 		list_del_init(&group->entry);
 
 		/* Try to allocate default domain */
-		probe_alloc_default_domain(bus, group);
+		iommu_group_alloc_default_domain(
+			bus, group, iommu_get_default_domain_type(group, 0));
 
 		if (!group->default_domain) {
 			mutex_unlock(&group->mutex);
@@ -2928,27 +2922,15 @@ EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
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

