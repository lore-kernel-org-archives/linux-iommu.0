Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C90322A;
	Wed,  5 Apr 2023 23:38:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aexUg6lKgDU2mp/HoYIKG1BUT7P0Rvzl82HucdEmKiCQvY8oa88vPikik/ZLwnGbYtU55LVCxDO8Jp80NIBNXlgeGzgPhL8PlcovSwl46nen7Gna1zCs0uer52BJht5eKsPuONcsfkThxQCV4XKzsQh2TqZQ+7M9pma2K0Mo0Mk/x1oUESHzCXA6y/6UiHgn89If3Sf550lor96l0OSU5g1f005CdZED7wH1kckKeGRewuIN+ldA1yCIljT143lnGaVxihxkzXj4RBBtTuWxZMWzIZGw/3ILYmnWm9jxCFb54DV1/R1xykBHSxKfBwH36styfxfGNpRYB9B35oKh2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbhhZFNQ6eyp2+rQDZMKGCUH181zW4zo5JN/5hOXrpA=;
 b=ZvTaDFmhjK5mQ7xI9a1b6XW6XWp88euLyZ+dTZZvPp7Iiwd7ghdnQqY+leoKaVYgQeNGorNk6m/LYGNvS/Tw/CMei6wGyi6U21FxZErEEHXs88pFA+A7adCJjPXcwUSWp88ctFIm6Wgo/2fKrMCo550KMkl2vz/p8FcxbTktOtkyUWGE4eoJBfkkFRz3tTycwd7kcP0BOXhf9hH3G0SR87G+iQ5rd8bcFxt3g9ft2lZSa6OizUIKVoI8GilQsyWIJVbaJAo3Q02xQD/CF/mWmbxhM1sYuqk2w569eeebq3bE4QI6f+P4Dy7tGLwNXjDX5nSo1RfoAxJ8Oa0zNb9bQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbhhZFNQ6eyp2+rQDZMKGCUH181zW4zo5JN/5hOXrpA=;
 b=OcTroQOQvTdZZDuknsdzGt6jDT+G2yLp35xWvlZxJke5xbH6y82l6azNJVmQg4eLYA4fBnz4sFparm183/R4ounDuIF0nb+L2jd/+wU6li7o53tEX4P0UufbysRzQej3B41Nhr3QEmeTZWvF6FS52Zx8JvYq8oJ6p15dM2Vuw6GLo6sDvrJRbyvjLpQVZnecjlNPeMTbiptH+3N+olNPm6WScmIiQOyM0pH6Zw0JqZ41ZHwZ1L8X8g55TaFh3nLposTgTl2m2JtKgPns2j3r67mlW0VffZCPQxLGMakP13FYT/UrjsmKe/DSoJ4sXqCymcfG78dOfSGIJE3WZf41mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 23:38:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 23:38:39 +0000
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
Subject: [PATCH v3 04/17] iommu: Use __iommu_group_set_domain() for __iommu_attach_group()
Date: Wed,  5 Apr 2023 20:38:25 -0300
Message-Id: <4-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:208:d4::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: d8cf6e38-0227-46d9-ffd1-08db362ee217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SxMSAgNQlWPdUd4T08gKcl34G9DQg5Ats2mZ2IUv40JFeC1ubo/u/DmQQ/Ip87Ee3XgmjELg+DXob/9doFyuDX8sESmsa8v+ZGyhNQeMMgDzsYSoVVsZTJsL918MaKKAwk+68X8c+z/BEX9T0S+GL4bqyfJadLdim8phS+zOxhiGfjahl77pyqBC3RUn8uUzmuKGOvuja04MVywXh+NhU71j4oIjmvVXSthcwV6Nk4R24EPI1tIyyUh7CaEZHHIPIanO5SGKjubj2tdshZeGcFnyKkiqKc5dlUWSXouoGUBFFOtoCb0fCOtq6yJQ4/Ky5aXlSyziLFiFIXpuJlH4QzhEMTBTL576z5sic5wuCBoex6WGwfrj5tBQlWOx4PfoGSpvaWuEVLWBz2ld9O8yATSglfYacKN40l4nzYxy6U87gmM5IfHYTNI42ZtiMpb4Hg0jF0hO0Lb0x7jB8W5JxOFT8yDJ+9lHgvaEVt4qLXBKtVLMdfJ45FRK6iZ7+Bl7oXIntFYQBBaHH7Rpi0nBHJ6XghnRXj8bCmXMe3PdnMxRq4Lm3pF+9DdJn/uELJOsX+krdLOXKPQ0J/WrBJRuGoUOrbYvkPWuePoE+LPYgJk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(2906002)(38100700002)(5660300002)(8936002)(41300700001)(66899021)(4326008)(478600001)(66476007)(8676002)(66556008)(66946007)(7416002)(110136005)(83380400001)(316002)(6486002)(6512007)(6506007)(54906003)(36756003)(186003)(6666004)(86362001)(2616005)(26005)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BcJDQIU7IBYmz+/qAJklc+Hs+dTVxBQGjYFMA+PB9N/QK9fr+x7wGNL7NisB?=
 =?us-ascii?Q?CvFDwQ98nnP0j8f9jwuODm3brpq+OTX7NvV8xrPH9nAcuJQydS2pvq7pjnd2?=
 =?us-ascii?Q?NgIlisea3iy+Bp9IbNPJtvYOaBHCVWWvQQX8pRI2XhK7AAvHF9RX7Iwo6eFh?=
 =?us-ascii?Q?6FmOtzdyyfSzlpHkd3q1LQDMMvVLFdeciM4cfPo0L3Rd/4lImv/r9SQ4Pefv?=
 =?us-ascii?Q?xIoAeFF8KfWwZC0isIwwJLopuGYVNfT6ZzlI1A3fwqH3rTjGleKCM+BaOWXz?=
 =?us-ascii?Q?vvZEW1i6JavTxU1NJRqXBMFSGABuzgWRoAq+TbPVbUk25YMBMfsxVjbIPObJ?=
 =?us-ascii?Q?Py7e+cuLptKIh4KE8ty25cdBpkeLXzJIq5BBQRepZ7C1rHaljJPDVlzsvwxe?=
 =?us-ascii?Q?f7GE2Cs45XE/efgu78DQsDd+8aQU82MMzDVhEw2NUNNoYoEw0KO5Ww7dDHul?=
 =?us-ascii?Q?vapAzIh+sSiKEtFFK6GLj/m9jArdlz+geFKJMWUMUYKxE3kMkEfe894Iiort?=
 =?us-ascii?Q?mElBlIEKSzpt3WW6bpiqtj7c0fqlekcwP1fmHoUrnAYAsmykUhZofOMD/k+p?=
 =?us-ascii?Q?0H2nfx9oER+i3VMlcYPBt4zdlMfMxmNOJF7kn/kIJnk/da2vM1Y/HXVJHA9A?=
 =?us-ascii?Q?b8UhsODNnJyHCu099LMj4Y9YobMY/jO2/Jr/PwSX5rKs9tRmOXGvMbuTq/Le?=
 =?us-ascii?Q?YFwscV0RLO6zDYePF9J5KR6PxEdGipXOWI8bgip/5OaJduj+r1AfWw12o2lE?=
 =?us-ascii?Q?OChX7t3wBuZvTofJcj0ikRw8K5hC1LUKt5KVWcBSwRhh9MtlNA5K9FuPCpqr?=
 =?us-ascii?Q?27MvI1v2mqsyToGU2yUGlger2glfm+lE9MRstyRkuX+BptoP/NhnBXLwqlDd?=
 =?us-ascii?Q?OO0DD5owsxdLhvK389ixdgdWvDW63sZRPYBjRE7iXthsAiG7gEIRGvtpM2Eg?=
 =?us-ascii?Q?q9dbjNlgQuZ/vJF0t8g4xhZfDNYamUVY+4S0SUfRarmJCIEqnRcW4WD72gU/?=
 =?us-ascii?Q?BK4YjwkWYqz/My71qC+mZ5wNdBmCjZQJqL/HErT1tpnIQFHaHHFBukFHu+Jq?=
 =?us-ascii?Q?GUKj/PvUdeEBvdZaAKlEDE5qIHnDmvX5PaRJX6m15tPi0clOoCRu6W/Ca6x0?=
 =?us-ascii?Q?KQPItzM6u8/LEocRkXn//S/LU43walsXCMMSIxJ8kGv776zQ8VUGH503XnxR?=
 =?us-ascii?Q?aNz7dT7x8TQeC6sYG0RrhJ8YIQq+AlOzequ2tjjX8u3xqUlMzc96K0HURseE?=
 =?us-ascii?Q?QwdEWH8Lf435fiqZBBu5UKibmWxHfUCa0axk2rR5HOS/UhFdROH7CyrVw9wR?=
 =?us-ascii?Q?i6BZ2680eDRCA2utMrYFPkf2iNf58OXFxVOCsG4DTyilnpqGJnzvsYz3wmKW?=
 =?us-ascii?Q?1ZK1SSqxwUIyNAADQcfMonhq94D0Z2e26+k1K9Aji+0+14/+A2ZtR8r0xVNR?=
 =?us-ascii?Q?ruuNh805/nUv6ht+im2vXHA7/WQxFXg21rMOUlyxIYvG0qSb6NzG+MSDqFSb?=
 =?us-ascii?Q?ORz20dYtJl/2uJcz1cZctLGYvKjR81jzi8VXQ4kTuQEAcIkaOJMlqYU2Dvz5?=
 =?us-ascii?Q?GRvFLMXMbjCzkhRAIjXGV+qAWarIwjMQvZWsNwCS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cf6e38-0227-46d9-ffd1-08db362ee217
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 23:38:39.4192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpLh+boMgvvphb08wsKW9j7drqo9t0bLnLTpZ5OBMhutQzO97jBEU+LIIjq1Rc/L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879

The error recovery here matches the recovery inside
__iommu_group_set_domain(), so just use it directly.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 40 +---------------------------------------
 1 file changed, 1 insertion(+), 39 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b7cb2a56ebfe8c..ba9e988293f23f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2177,52 +2177,14 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
 	return dev->iommu_group->default_domain;
 }
 
-/*
- * IOMMU groups are really the natural working unit of the IOMMU, but
- * the IOMMU API works on domains and devices.  Bridge that gap by
- * iterating over the devices in a group.  Ideally we'd have a single
- * device which represents the requestor ID of the group, but we also
- * allow IOMMU drivers to create policy defined minimum sets, where
- * the physical hardware may be able to distiguish members, but we
- * wish to group them at a higher level (ex. untrusted multi-function
- * PCI devices).  Thus we attach each device.
- */
-static int iommu_group_do_attach_device(struct device *dev, void *data)
-{
-	struct iommu_domain *domain = data;
-
-	return __iommu_attach_device(domain, dev);
-}
-
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group)
 {
-	int ret;
-
 	if (group->domain && group->domain != group->default_domain &&
 	    group->domain != group->blocking_domain)
 		return -EBUSY;
 
-	ret = __iommu_group_for_each_dev(group, domain,
-					 iommu_group_do_attach_device);
-	if (ret == 0) {
-		group->domain = domain;
-	} else {
-		/*
-		 * To recover from the case when certain device within the
-		 * group fails to attach to the new domain, we need force
-		 * attaching all devices back to the old domain. The old
-		 * domain is compatible for all devices in the group,
-		 * hence the iommu driver should always return success.
-		 */
-		struct iommu_domain *old_domain = group->domain;
-
-		group->domain = NULL;
-		WARN(__iommu_group_set_domain(group, old_domain),
-		     "iommu driver failed to attach a compatible domain");
-	}
-
-	return ret;
+	return __iommu_group_set_domain(group, domain);
 }
 
 /**
-- 
2.40.0

