Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FC63FB0B
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MesXXz7F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mB6ZMKfevtz7FQifn9r0EmEmAHVkLAdaJDXbtAp5UOhzjVya/vykV8/0THUw/pVBhWemYgjspccvjsemJrB7SsOHAA7celWi7I7222GBIpuKGXcRTGzjkxKlk1AdBcwEGiHWlEUYg/FFwfEV2CpmRT4w/RN4x3Po7tHYFQ5h/NwT2hxOznFJNLhYk7aKQQfw7ErY94IMJceLalQ48IscNEaXpRVfMdo01e0Zot7/1aHF/u8JIGcAFpjrDIUKD6OB4xLvXBo/WCk4yUsyZ7tEtl4kRdV8ZAy6utczdwN5TYur9TjMVhp3D4pqg/l389m3bueDpkT9c6vZFNvWzPO6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygp85139qdJt2XxMDOIJDibCQlpOidTKmPnashWKx7M=;
 b=YZ4iGnhOCLSEqSWWLUMtHzGMd1bITLqQQEyPEnVu9d+OJLgKJ33ckbkyZTtHpbG58FSRznSlXDp1sPl4WoMfMpow+nzWTeQniMhakk1vJnEl/gVsOatCLxCd5So/Ao4iQtErERXE+7flyCeFmdoKhFtkq3gHFxqd0A43W5nhapyFcEKWwSM6H6OrtpLrwrIMiPyCUpfj2/BI7G4imJCxaysjXVjx2gTYMp8W8N580oui5lqu18ZpY/OS5lrGJK992oyfyWFkrEdsuSvXDcYN1ta0FQIN4aSCVMBOZkoBiGMXGpYF0hSIUX12HRLanTNlJGFtSUXhneX+zePTlVyv7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygp85139qdJt2XxMDOIJDibCQlpOidTKmPnashWKx7M=;
 b=MesXXz7FIWkcyquBGVppU3PlEIrUQFng2jMIAJRPv6M0nsFszez/BJ+bx/XmGXE9Pvkdy5lvk28E74m0sls9MmiMgRQocg2+84Rh79HyWhhluAiljtsry/+hQLiozm1O6atqbzGorM6EFnLZVUtGH2uekZ5gLYB0O+f9/vYGXHz1NlFcQYU/2WkvhKwoj7PSIYr19qTMK8VlId2tZjl66Z/4de/pbjAiQWIEoq/Uzgjx9xiy1k/RVQJtG2JJdk8hTcUcCF25kWOwDWMjfZQaWnK4NnroXIM731ShNSjsSOiPBOyl1z5kbsIYNysmHP3jemlxge+24+bjHdWzrJqEXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 18:28:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 18:28:22 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH 6/7] iommu: Compute dev_iommu->require_direct sooner
Date: Thu,  5 Oct 2023 15:28:17 -0300
Message-ID: <6-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
In-Reply-To: <0-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: b2cab881-03fb-46f9-bade-08dbc5d0da14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CUDEJH2xAXnI7rDzkFUbKlrFnkhy47fN62hKajkuWc/+ldrzv4x1lJgwYMQWnHt8YjRjiGxN/9wxMrOo9C4QlefsIKEVOgAN4XHlKkpRSw/e+fVooBX/V+hJGK6zGuSHC17/jeKa7EU0gTYj/WEvswfT2xjxgu0S/YFYNueDtdbbGGMw42cLyVSEkrFWOvinWr/Y+8B6MQuYv9WjtZ8nYG1XfNCkPVqIYl8Zmc57b1aPbqg60s1fB8EbbYI8w8lUOGfM0W+fVgXLETxsasIeEFN2DXiwn/zQM4mHshHAkKlfb9MUiBWZIMVK0wxnI9SCT00abTqkpdyBENsn4FVzy+tUvCW6I/ylku/IMSGRQJKkdWf0ypJrtFZGc91vk1inJhpAQkI2zdUlJ2sEmdG9ma4lsZokew0xiRG66h20uu8kGFc2WtHfigLBXd9pfsk+cqm3CUvI9DW7khF4toomsUdZ3ntWksA+Mpjn9X+G+9xoJTp7h4nTrxnnWrwJo6C/7AiIJ1uJlATWZtXs2oA+6KEflnzohYsl7LenTtEjaR6o2ygFlfdfo6zgv0gOIoFVYqP/KZprluF+YFkdSUoidWCIHA/R/koQPvfCAPou/aU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(7416002)(2906002)(36756003)(86362001)(38100700002)(2616005)(41300700001)(4326008)(8676002)(8936002)(26005)(6512007)(6486002)(6506007)(66556008)(316002)(66476007)(83380400001)(6666004)(54906003)(110136005)(66946007)(478600001)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zh0aTnGGWmhH96W2lpJOdz1NLUwq87D/4g+dvvjip9XZm2/5oiUpD7fRJJAL?=
 =?us-ascii?Q?XU4/Ihw2F8PuGjvlKLUkC1tIzp28ga8ayoU3I03pHCDguwfLr5lWAPvmIcsb?=
 =?us-ascii?Q?BCJGiATWNucqHY0X+goJErlyh7XrKBlDZ6jm+j7Xg8WPqJHPRtD3Pj5CBlMs?=
 =?us-ascii?Q?vLfCGd/KN6Vy5omNuiub5N71as49Qb1R6NWvcaWb6PsadbL2s9ZaGrwTCoRG?=
 =?us-ascii?Q?mYDgTszASu1LXsLsn/95qCEmiHHON8+n9RBCq9RcnIBfrmbn8C/vtbY6ePQ9?=
 =?us-ascii?Q?yDAAzT4YpCv9GLun5JOi/v+2PZyO/oZK45D2k++OSaB2B3WTL7H0eWX6LgFk?=
 =?us-ascii?Q?4bKVnE0WUbQ70HGytBuh7zk7N2xLLtWXj6B6oKpUhW75g7Nc5GlvOx3rpHLO?=
 =?us-ascii?Q?7YXU2PRajsB7OjygooPYfdO3LhKVxFgS/vGih6MqY3X2pS53SQJgxMPtapHS?=
 =?us-ascii?Q?kGXeVsWXu0nMTnWK/TMwa9s1fHNkhHnGa3GbBMC8EEB3/GOtrl0RWjsxK3bJ?=
 =?us-ascii?Q?Um6/r7JSVALihVFzOCFpqCIHGu8D46EnpNq1JZTpFIYixZ2b1FAQlMLt9jR4?=
 =?us-ascii?Q?D1/GJia20QYkFTNsL/RMHoHnJr2o6GQbU2JQWIo2SbMUehBn5SUx34zNsltq?=
 =?us-ascii?Q?eyO7XI6vSUNvT2O6OBauJp8BdwLGrkc6Ja3lVv20XCKSYXJL11DXwRFka5uH?=
 =?us-ascii?Q?ckRl2DaDInpu/2ucLVGrpIHGUdOOTQZqXx/zgAauSzACFNPGcOx0bx899WH8?=
 =?us-ascii?Q?aeGEgFmHP1vC1vvMdNcGAl5bNzhS1QV6K9ObpUM0EIraVYH/BxXLPx29o22O?=
 =?us-ascii?Q?LUJzq+rk7vWIE/O4oGFQ9XPNTF5HCypiVcPdPPR7x/DR3EtJpMXTUFqi1PKy?=
 =?us-ascii?Q?ZUdKXVPwsQZXUUnU0sYYUC4z7YUWHgH03PVl0EmWRV4IxHCxjF1mfVXE63lW?=
 =?us-ascii?Q?2nbLOI3QnSO6mrD1doqdr0NQvI4TMk8ygr3+GRfyfW1t/01Izcb7x73igYMX?=
 =?us-ascii?Q?YOS54YE4D0HZ1OlN203mBbIWETnHKdMbzNDMSf5Gcp28LOkxSEvRPQEMx92E?=
 =?us-ascii?Q?ozP9SZ6MajR71q9u9kUOnkvJjLgqMmaTjT9eQR/XExTafCFoRrZfzPrIlGUG?=
 =?us-ascii?Q?MgqpLFj6LpV7kKdIMHczDsVGZ8yA2BdUGVmo42vWZjGi5ZqIRJc73m0D4Rnr?=
 =?us-ascii?Q?SPIWwAqBgT4BY+6kVUlHhGdRxjsnKFEH20Bp672qE38wgin84IvdQ6qbeDAN?=
 =?us-ascii?Q?ZT9DbYp1xbS3w6Pvmdr43eruP6tHNHmnH+uBo7Ij9p096NpHlAhne5wanncq?=
 =?us-ascii?Q?hjZOCDMO//4PDmfcLlSJJIfH0EZ7pKwSZZL/UsyHzIOoYxMh243SVn3CCZ3K?=
 =?us-ascii?Q?IeYzGMS+TvBU1R5UWLaErIh/ui7yhFJptkeadHlCYdDvyYcB5O+0xEq0oZ5U?=
 =?us-ascii?Q?q+UYWV1ReFkwQer+vMpMMxYJR/qJlXB4WZBVAbvf+gAreAM4zam12ffWinno?=
 =?us-ascii?Q?d4rCSKNViXPfgXwzG7x8p/sFQG26sUH7gnP14nhmn7jXgYYsY2DHvqyj+vRx?=
 =?us-ascii?Q?dNc8XxmVbYv9ULlAyX85kNUjaZxaHu/4D0Gol0TK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cab881-03fb-46f9-bade-08dbc5d0da14
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:28:20.6631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FcLN2V83pZqv5q819xwgDv8drnqI9ysi78GbRGQnpMwk6RGZCvaPd994NoKnMUKC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364

The next patch will need it. To reduce the cost cache if there are
any direct mappings at all and exit iommu_create_device_direct_mappings()
early.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 26 +++++++++++++++++++-------
 include/linux/iommu.h |  1 +
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 89db35e2c21771..efa65b3d1bd405 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -392,7 +392,9 @@ static u32 dev_iommu_get_max_pasids(struct device *dev)
  */
 static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 {
+	struct iommu_resv_region *entry;
 	struct iommu_device *iommu_dev;
+	LIST_HEAD(mappings);
 	struct iommu_group *group;
 	int ret;
 
@@ -427,6 +429,17 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
 	if (ops->is_attach_deferred)
 		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
+
+	iommu_get_resv_regions(dev, &mappings);
+	list_for_each_entry(entry, &mappings, list) {
+		if (entry->type == IOMMU_RESV_DIRECT)
+			dev->iommu->require_direct = 1;
+		if (entry->type != IOMMU_RESV_DIRECT &&
+		    entry->type != IOMMU_RESV_DIRECT_RELAXABLE)
+			dev->iommu->has_direct = 1;
+	}
+	iommu_put_resv_regions(dev, &mappings);
+
 	return 0;
 
 err_unlink:
@@ -1068,7 +1081,10 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 	pg_size = domain->pgsize_bitmap ? 1UL << __ffs(domain->pgsize_bitmap) : 0;
 	INIT_LIST_HEAD(&mappings);
 
-	if (WARN_ON_ONCE(iommu_is_dma_domain(domain) && !pg_size))
+	if (!iommu_is_dma_domain(domain) || !dev->iommu->has_direct)
+		return 0;
+
+	if (WARN_ON_ONCE(!pg_size))
 		return -EINVAL;
 
 	iommu_get_resv_regions(dev, &mappings);
@@ -1078,12 +1094,8 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 		dma_addr_t start, end, addr;
 		size_t map_size = 0;
 
-		if (entry->type == IOMMU_RESV_DIRECT)
-			dev->iommu->require_direct = 1;
-
-		if ((entry->type != IOMMU_RESV_DIRECT &&
-		     entry->type != IOMMU_RESV_DIRECT_RELAXABLE) ||
-		    !iommu_is_dma_domain(domain))
+		if (entry->type != IOMMU_RESV_DIRECT &&
+		    entry->type != IOMMU_RESV_DIRECT_RELAXABLE)
 			continue;
 
 		start = ALIGN(entry->start, pg_size);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e1a4c2c2c34d42..e27d2e67e48ef7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -442,6 +442,7 @@ struct dev_iommu {
 	u32				attach_deferred:1;
 	u32				pci_32bit_workaround:1;
 	u32				require_direct:1;
+	u32				has_direct:1;
 };
 
 int iommu_device_register(struct iommu_device *iommu,
-- 
2.42.0

