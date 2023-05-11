Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D57645;
	Thu, 11 May 2023 04:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1WREGouBthaU+2zumwTU/xvq/giTUoQjPdPmmLawt12HAyq3IQkjdlwZVWBrH5zIM17pr7SnGHLk0mM6XH5yC2Cs12NyLPvOolPCZ/kLPFqDIS5UPyOEX336lqwvL5aKGcZJFd3RSbzU+vtxVNWDkkMcBeGPvQuEOUDy2KDK25631PLIpxBe+RWUVV2T45qhwGH9DuM/UkkPaf7r59+If9MneLF5mVfp35We4JlzvDKBNnKlYl6MUNXgX9Ilgz2DJ0ksp4vLAm+JIXNSbtjJswg5iM9TbWncSOtL6CQ2O1kyRZqv+CTblbn6hKqWUvTCepKYBAxB7XMcC0QYBoMqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4Yy8ZTeUnfe9xrdshNPxa5lf2qy1jcvGqE41P3jNdA=;
 b=k5Dd39MrA4TlpVVCtI79vducdf5Uz8/jUQTeWzVwYUVHlbyMw2Ef5flvLz/BbIRI0lYg+FQnC+7NKEsgM4G47c0mWHJFK19QSUXd0FCI2ncqZ/zoxKVDGbqrm0Dux+HhCCSpXcKF+c9fm/QIktsfdcm1z7Km9OT0IT+NG+a7Micady1lkP9ElG1UtIhvSrThw/j/mEOKAkN/D+J2qAgpKYtKdxIGNkZECHKcE4wOogsoTmgHGSBW79l236vaifUAuIdALIpzV785GOLb5BM0ItOqM26Y1+SQ1luhCYwtuIw5Q4tW0Bc2UN5KmavTqdeuczeCS8AY7hZpQ4Zcj7VmOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4Yy8ZTeUnfe9xrdshNPxa5lf2qy1jcvGqE41P3jNdA=;
 b=f/1VrzcDOwrHoPn1Hn9OZHNlizg5Hfmuli0bwz2W39t7c6P3L1MWinmc+bNPIJJxczVq0TL54VDWvDbYdNDKG0l4BJUGEefhuYf7QqMxg8Nnx8ymnuXi134ixjnw2fDXpRzf+xQIFV9P698Pek5oIclA0oLfDwOFlUFCyD09jQSJh1Q2+R3T/D/tkGRPgvn7qy5rVWCMCpz/xj9cbloteag2RWJIOOZk8KKyrQkCPEV7DGD0ZiUIJkDartNInKeKRYuPuJEPlwqyJqDV96aftBXv8chfIFbjGR363/7I8GMjWoTHtaQBDJ8NsVk+vd3DOkHAwsx5YKqZpOQdZL98/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 04:42:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 04:42:21 +0000
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
Subject: [PATCH v5 13/17] iommu: Revise iommu_group_alloc_default_domain()
Date: Thu, 11 May 2023 01:42:11 -0300
Message-Id: <13-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e7c26f-e668-4a5a-d935-08db51da19cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bpcNtpRL5wGoZ+qhzRoKImjx51YfNBHiIyy5IiLpcvCaeF7qTRDFZkp7TgvGZorO8XrICbGtObUFGs92favDGdrWjXixTHkge8fKezEUzeqE1be7pgEefO3pkbHHLOD0cyEZicFnuPqE3RVE22kXuWwrhBzPmyIojpxurYmfJanvydcDPbL32F/kHZICc1fw9mBEHFMWal/zbnOmY+9LWxxBpM0y/EGyjGEdE9+bWsDokzaS/Z/r6+e4Pe72DFJK+Bys5Drr1hNhlB+80vVPpbBx7ojSe3t+4RwNXho8DEfHqRlaxk4+X3WYWoVt1JY4HfxtNcWHNM1DhD63S2vmXsWmRxoNFO1BoxQiB8INUg2fFjFEtXNL1TaAn+6sdi17UxPWDVF+WgRyUoSZS2661zkfyobkLHvhSZSVk48/Wx/PWTm20ebR6wCXqCtyFmdS2YSjsrd5zgBJXdZhwOQvbRSSrX7ZFBhLdAJOr08/OOcpnmZ5ht3nxm2XxemsefDekuSrC0idW1lhINntQeUt+lSp0WTU9NIdW6fSnysiXr7tspTy9Eu3rUeTbQ940S77
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(26005)(186003)(6506007)(6512007)(2906002)(41300700001)(66556008)(66476007)(316002)(4326008)(38100700002)(83380400001)(8676002)(7416002)(86362001)(8936002)(36756003)(5660300002)(2616005)(54906003)(110136005)(478600001)(6486002)(6666004)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XtTlSMOcU9GAGAju/qpoyGGItZ1OTfzn/aGfCEgcUfyjp1pbdPR3it0lRtyU?=
 =?us-ascii?Q?lCdduCcLR5P2wdkhEwqZVChN6EBpLpTpFdvYVd4JO5jA6oD8BYILdLyLTtiM?=
 =?us-ascii?Q?v0V4w0i1XO8KTU+924oWmLpAVObLy5INIwZttklC/4dnTtCXNU75EekjFapW?=
 =?us-ascii?Q?13g+7TVJ9caVTdXiUVWXqMv2jDYHLg7DEE+hR5iJbjIDlGGsn8shBYGvD8SS?=
 =?us-ascii?Q?nCwLSggTplkvskRxTMVSBag1bhP6UF0hblL9/4wueVPrT937JyvZ4jA2aHXz?=
 =?us-ascii?Q?SzD3YmnKbuGkl2PRCODTY/6IXG538XDxrmJolX3MbwTpK8P6U0RGgUWUFJhm?=
 =?us-ascii?Q?0aWxsGPNOn68AKROztYurF6MY9rXxGm+sbgMPASwd42hJ4LKQPKXX0VLiIZh?=
 =?us-ascii?Q?+iXtE7A/oWJ4Q8WV121+d+IZ8V9Gl5vO6Be8vFtooo9EmG/893TGskJ9k9YO?=
 =?us-ascii?Q?br7qChJgNP/0oo5ndX/I1EzmtT6WeJZOyTLowtDM4USYO1iP5Zbzg9uQSClh?=
 =?us-ascii?Q?MqRkxoJ6jnBSOkgqBCiQ7GK/GXTSnUDnq1GQFS7TbnpdCdeuFCqj0lp9BSjV?=
 =?us-ascii?Q?STHuwWlFWQuiX1WbLmKNO5GewqK/KNiJX8OiCsfkBgCPPIsd+uFr4ZcudzD2?=
 =?us-ascii?Q?brMu7UuAs8Ffv5iG9mVtiSzaTodI2/febaDIcKfGMR+ME7iAmIBUQJuauxTw?=
 =?us-ascii?Q?eQNj8ImOVf8TOh6bUeAJgBVZ48qVAlnepDsy3b8UhBcLM8AfX7ndAMk6Oyp/?=
 =?us-ascii?Q?DeUAfM1HGkbZuRSvEUGrXJFVtn+xnlPQ07LF/X2q7C7xgFnmHghoc55DiiSD?=
 =?us-ascii?Q?N3T8nwvWwIrFomOB2lzP+iVkpSPsZavK9Zhnyhh8RCkBogInqPiCT1I+1wCm?=
 =?us-ascii?Q?LRWAJtbnbCuAbpX+O4A6LFLWryGIKmAI5EanNpklf1ULXpddNUdcqF7THHSb?=
 =?us-ascii?Q?lOQsSJtIm8xy7z2LyiIBUPpNndm9VfEwkYO/RDXlE4ljg8SkpuPh8u1nyuRz?=
 =?us-ascii?Q?D91T23ADb/5Lb3gVGPoDUQV8kDRLibbK8b57UghYuormIzWEh0DwQDG2Hqjd?=
 =?us-ascii?Q?YUPA/LxWxF/iQJQSIw52kbmm9UufE9G+Is0Fa8NiWBoMFKjmB3JDhy8y8wrV?=
 =?us-ascii?Q?oXSSY//rnyuvAJfe+rIpk9p/jHUJMvf0ZqPDwzfF4nQHOCTg6Ugl+jFHCjcL?=
 =?us-ascii?Q?kPsH0vA3dtVq1Dv+wCvPz2YuUkeZB2S9YKVmVuYBDkIbo7l8y7eOSWdGZFTn?=
 =?us-ascii?Q?wsuP6VxFN8XtX3jRDwQUiD8HieJ49PbssS8hAPhHPOKj7B25Q0FadOGR/nCW?=
 =?us-ascii?Q?XXOLWCcZQwA30VjEuf7uKLC3j0ml3M5mdpSdTN7olDANXcW+vce0kOyy2uQf?=
 =?us-ascii?Q?DhMtWIgBcA55IaUWzx4m7j6IjHp22eXP+1hs67VsLbd9H41X2jflaYlNlvIz?=
 =?us-ascii?Q?aWQBkNP3yopUzk6gZV+uHnrTYxWL0HVUsPXYPtm+F/uG8mL/nRt73nri4JfO?=
 =?us-ascii?Q?2N6M1pqamwk74uBtLr9Yf/VOPWDNuRJt3dKNRXql3ZkjV0fRPgcKBwJ3Hr9v?=
 =?us-ascii?Q?AUm8xqqO9G74JSG7Z7a4GtgE1L89SVMxSBd5zmNv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e7c26f-e668-4a5a-d935-08db51da19cd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 04:42:18.1563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQz27jKqcEdQBtsWNN12Ho3HbvDfhwihQJqYWlQ9jxrTv+XCyRuQI5RcpM2SNwvT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054

Robin points out that the fallback to guessing what domains the driver
supports should only happen if the driver doesn't return a preference from
its ops->def_domain_type().

Re-organize iommu_group_alloc_default_domain() so it internally uses
iommu_def_domain_type only during the fallback and makes it clearer how
the fallback sequence works.

Make iommu_group_alloc_default_domain() return the domain so the return
based logic is cleaner and to prepare for the next patch.

Remove the iommu_alloc_default_domain() function as it is now trivially
just calling iommu_group_alloc_default_domain().

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 71 ++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8242ac609089ea..b1dc5e203eca0b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -93,8 +93,9 @@ static const char * const iommu_group_resv_type_string[] = {
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data);
 static void iommu_release_device(struct device *dev);
-static int iommu_alloc_default_domain(struct iommu_group *group,
-				      struct device *dev);
+static struct iommu_domain *
+iommu_group_alloc_default_domain(struct iommu_group *group, int req_type);
+static int iommu_get_def_domain_type(struct device *dev);
 static struct iommu_domain *__iommu_domain_alloc(const struct bus_type *bus,
 						 unsigned type);
 static int __iommu_attach_device(struct iommu_domain *domain,
@@ -434,7 +435,8 @@ int iommu_probe_device(struct device *dev)
 		 * support default domains, so the return value is not yet
 		 * checked.
 		 */
-		iommu_alloc_default_domain(group, dev);
+		group->default_domain = iommu_group_alloc_default_domain(
+			group, iommu_get_def_domain_type(dev));
 		if (group->default_domain) {
 			iommu_create_device_direct_mappings(group, dev);
 			ret = __iommu_group_set_domain(group,
@@ -1645,35 +1647,38 @@ static int iommu_get_def_domain_type(struct device *dev)
 	return 0;
 }
 
-static int iommu_group_alloc_default_domain(const struct bus_type *bus,
-					    struct iommu_group *group,
-					    unsigned int type)
+/*
+ * req_type of 0 means "auto" which means to select a domain based on
+ * iommu_def_domain_type or what the driver actually supports.
+ */
+static struct iommu_domain *
+iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 {
+	const struct bus_type *bus =
+		list_first_entry(&group->devices, struct group_device, list)
+			->dev->bus;
 	struct iommu_domain *dom;
 
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
+	lockdep_assert_held(&group->mutex);
 
-	group->default_domain = dom;
-	return 0;
-}
+	if (req_type)
+		return __iommu_domain_alloc(bus, req_type);
 
-static int iommu_alloc_default_domain(struct iommu_group *group,
-				      struct device *dev)
-{
-	unsigned int type;
+	/* The driver gave no guidance on what type to use, try the default */
+	dom = __iommu_domain_alloc(bus, iommu_def_domain_type);
+	if (dom)
+		return dom;
 
-	type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;
+	/* Otherwise IDENTITY and DMA_FQ defaults will try DMA */
+	if (iommu_def_domain_type == IOMMU_DOMAIN_DMA)
+		return NULL;
+	dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
+	if (!dom)
+		return NULL;
 
-	return iommu_group_alloc_default_domain(dev->bus, group, type);
+	pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
+		iommu_def_domain_type, group->name);
+	return dom;
 }
 
 /**
@@ -1785,15 +1790,12 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
 				"Device needs domain type %s, but device %s in the same iommu group requires type %s - using default\n",
 				iommu_domain_type_str(type), dev_name(last_dev),
 				iommu_domain_type_str(best_type));
-			return iommu_def_domain_type;
+			return 0;
 		}
 		if (!best_type)
 			best_type = type;
 		last_dev = gdev->dev;
 	}
-
-	if (!best_type)
-		return iommu_def_domain_type;
 	return best_type;
 }
 
@@ -1850,9 +1852,8 @@ int bus_iommu_probe(const struct bus_type *bus)
 		list_del_init(&group->entry);
 
 		/* Try to allocate default domain */
-		iommu_group_alloc_default_domain(
-			bus, group, iommu_get_default_domain_type(group, 0));
-
+		group->default_domain = iommu_group_alloc_default_domain(
+			group, iommu_get_default_domain_type(group, 0));
 		if (!group->default_domain) {
 			mutex_unlock(&group->mutex);
 			continue;
@@ -2896,9 +2897,11 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	group->domain = NULL;
 
 	/* Sets group->default_domain to the newly allocated domain */
-	ret = iommu_group_alloc_default_domain(dev->bus, group, type);
-	if (ret)
+	group->default_domain = iommu_group_alloc_default_domain(group, type);
+	if (!group->default_domain) {
+		ret = -EINVAL;
 		goto restore_old_domain;
+	}
 
 	group->domain = prev_dom;
 	ret = iommu_create_device_direct_mappings(group, dev);
-- 
2.40.1

