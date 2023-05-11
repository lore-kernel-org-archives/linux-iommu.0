Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF53645;
	Thu, 11 May 2023 04:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JejBqTTcJAucCRdsgZUqsyZic5oxIyXoNO4hgy36DMKczESvF6lkua79orMhYrP+4XeQ6czUYIu6pIoL98FDBB2iK6IvjO9gQZ7kD13WdKvZ5iZejAYq+p77syofgo2c6NutYY6A7qnBD87jNx4rfLgHY+txZNoplWvqFBSawSnzIBuMl0fMYSXvT00mJWaL1APItD7FDWpZJd3NFeI/LxcVEYxrSx1heGieGFSMuKp+plxPWAjelzwiZY+CC8yVfRrk7sZPLl2/hNdR7i1Df1hjBBT0/ofZRVJtniRAFfgyf3Ily5ZOfb69okhq+Z7rrJgzCTFwi4mIpJoosvE7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hox48Oralyg6rPBlaPtYMHFJk5vo2OcJFNkFPQr0lUo=;
 b=cC/qOwJCUsENlMMeKeDhY5zdE2rL0lA0SSmcfgnGAnZXP6Y0hymS6PCWd5CbaxdlC/l6gd/gOPy8U74KzRQkrrO5IshtJltmHXxvrkN6cavg5Ccw3y0V9kZumYxdxVIeoUSVKRs+tPQ6ygz/XUO6YAr/JHnKUklhlghjm3RG0mdheXAgWvGPiWvAkZhYEQtufUOvdhAmgo9mwjKvjex+FK5BHJbOD36GWVJ1SH+fU3NN3inEcR/G4JNVsy2iqDuz2J7B4t/I75l7FrIS5p5nD8Y36HEnvhpUHng15XPipyU5Rhlcr/2G7jgaeRAdRvPPh311B+ULQ9OokFS3QG5sRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hox48Oralyg6rPBlaPtYMHFJk5vo2OcJFNkFPQr0lUo=;
 b=UqXNm4EO/9qzrVXsjGbAa+bpi5e6lt7OsglEWcMV3F40FWcP+0pB7AuY+yGKE4qU/CQRWSgU84L+PbtKXwA8TgDuD67OVoNk8x4yVuloEKMMBj/cV8h8fyYHjBRs6IGFAhp//DAWR+JgdZ5mSZZBDOumd5Un4sU9Gn8VdB+mzB7tULv5krJ7bkQ50j0gn9XZmWdtSHlXtFsmQpV4ehAueVCTcG9s8OJH61bynSimgoCEH50yAyrmeBsxsi1uk+AcCkfHs0J64uoGr/jPb/c8nw2ZNFnBqtJx9dRIfbsof3g7INJJKzsA4rUqLKUziU9MM848FRKRRLbfJvb7DPhyEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 04:42:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 04:42:25 +0000
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
Subject: [PATCH v5 15/17] iommu: Allow IOMMU_RESV_DIRECT to work on ARM
Date: Thu, 11 May 2023 01:42:13 -0300
Message-Id: <15-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: bc96aeed-9741-4964-a9c9-08db51da1af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DyBnt9zL8517RI6z7mUwWHjhJDrT52RtVB/6hXdgx5J76UTBUPInuRKpXdnlC9cOLtDYH6pjV/9JUqcXrxXy7yVhg3LEf7WxqmO/dts5BffA7LUsnILNHvrqK8TxUdB4FG/lbWZ9ir1+ZtgJyj3LaxFxpA8rVu8cvLVx6IUBfDe2XNaDLZPfOqvqyhpz8xsjbyNIZWO1RakX/lmJsU513JobmyU7tFqjTHq8sKrBPUsSGQzO+RKtcSQYEWHTFf4FzwwHZNvU3hSBZHy0FEE9VmLxvj2RUnr2yM9OxMgrVD6qLodufJLQlDn/2cHccrdKYHhA/vIxs3vID5o80TL7p08WXjf6KzQOHqA4N2kMNtMzUf5sWfkcVOSImTwXR2BVZeM2H5X6pI1NKdtyZFiFL9VTMZSg3roRH8WDJIHs2iWw60jtnAeaIYpvBO8NHuNKYSX5umriX10ISH9vFuv0FfvDoXkuM9JVI71zYydjxIRwPETWzN9L+BvY5ZliapzJnbKCgCaEhDcuX1/rBzfjxfZIl4tvQfTkJA8eAjSXydi1DWy4vh5rcvComMi7E89e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(26005)(186003)(6506007)(6512007)(2906002)(41300700001)(66556008)(66476007)(316002)(4326008)(38100700002)(83380400001)(8676002)(7416002)(86362001)(8936002)(36756003)(5660300002)(2616005)(54906003)(110136005)(478600001)(6486002)(6666004)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BPiyJHbRS3YR93m/fQ1gQfToSU23H1Xvt3fJfUgVmf+6kDU1KqE1hvsBbIst?=
 =?us-ascii?Q?Za8pOgEbIF+2FKKmEmIAyGbXHSRK/zGTee123isnAw7s+E9VEPB7FfjW5j/6?=
 =?us-ascii?Q?jqIggL0Eb7tRO9dQywr7NjXkWiKnbc00IR4zl2ZCJWFF94FvJjszePIwa1Cf?=
 =?us-ascii?Q?DH0vrkGeP0SCid/ftAel4gdqo19FpQCDeWG1Y7XrJnYLKCgkEqfIRApAJ30S?=
 =?us-ascii?Q?j3OFL9ydpLxFxgG0sRXE9M0qawsQfKJRrkEdQetGg4v8ltyjoOeOiXOCkNxz?=
 =?us-ascii?Q?uh9mCEUbbGq3iNuB7ebdkq4qo/ZtnCrN6qhxm0ATu9o/mpxGHlY1CHgXX9NS?=
 =?us-ascii?Q?kMnscb/qWJYJkCtKExMa5sXhQm2j3SNp9Tr2PGDL4scme6i7lL2f5CnjDC0L?=
 =?us-ascii?Q?kkCtE8Z5MAz8x8yduppVC7Q3K34CXsLlA2zeY4HGbKOED1MHm7Ncm0uusiUv?=
 =?us-ascii?Q?qZPU5b/5MekGlM8JJKk0MM6UqDf7uZsD+Ak2116/NHUv7SgUCTPZoCPlXI+6?=
 =?us-ascii?Q?U1LPz/IDWiuLDMq49Mlp+IS01THuPVdFxQUwr4ukL87Zijy7fETd4WEdSm9R?=
 =?us-ascii?Q?5cB6/KanPoMGQiRn8KMi6r9yBDoOr8vWMAQGdeZRdS+MBNJSTnthWRg0lSuK?=
 =?us-ascii?Q?L7m23CAKkfv1DwJcPudZIeqTNQpZJ0ci3o7XaxOliDHYOqMmNwgiqtdsZ/Qg?=
 =?us-ascii?Q?n9Vre1whJe7GJ1vRxOeeLamdrOXWA5AighQ//QoJyhrpCtRcUWuFwXMKtEiU?=
 =?us-ascii?Q?9kBRFi+UG7LPO3x1cSCM2VDz7tVDsffmzByBmCIMmOa9s1Sk4EFyYfU6dwMa?=
 =?us-ascii?Q?xFQElUCotIlnQMggpXcg2yAOZf2Dej3f3ztqPYqr6G/VM783GUbqPO9qfdj6?=
 =?us-ascii?Q?D2RK/CiMLkBIxMGajG9GzAOXxto8vPkX01KmcTALq+g6gD7WVq41wGiJRYCV?=
 =?us-ascii?Q?ESduVMY4tSN5VKBisU5NLRt7GTqwd/ad6jYqZSXzXWuWRouKLuamIJ30v/1J?=
 =?us-ascii?Q?nBf16Vt7qdJco8nHu4v4LXl1WvvNlpMYtKU7EuJ9xZTnpaedKVtWE7h7ZqyS?=
 =?us-ascii?Q?j0vC4uFevbbMHO42EcbPw8Kx9tkYbNQlI8QCU1XtO8j9r0FXrja9xme5LgMX?=
 =?us-ascii?Q?qJvda/7h7ygQE/h+G1Hd8Y92k1KTrjvkjXaqza4wCRhuexj0byEWr/Lv9gdg?=
 =?us-ascii?Q?9dSvt8gMlnTqIL12ar0Zvue8QTPPi1G/LvNME4zfcRfVabrCcDrwlxJg8Ibn?=
 =?us-ascii?Q?wpacgV1R0YLL4fIUnoArdsJne96Op8BxdC9rN6BF/YLeuIfnVQ+yxYR014gV?=
 =?us-ascii?Q?cD0OZcBCnxKUskNcnrsN+B9fhKaPj1Y7O+Lc5LHTaIVKK/1aokuqayt5gZSJ?=
 =?us-ascii?Q?vsQqftcdCYMGMD/hs1XeT4cvwnXL694HhQuFx8Sc4HDyD5ucwiYDs99xUaNs?=
 =?us-ascii?Q?Tk52p9LYNAwxcyuC3l1nRJMPFBu104123eZ/Yc/Da6qY2EBzNcFW7Cf9OFmw?=
 =?us-ascii?Q?nqUqEmbUdYyytssCKH6MomDqZ9MA6c0AOffPNf0QGxf6dDj1+xxCrHHvStz0?=
 =?us-ascii?Q?elt1C4XUJLG8Q4fZIvqx1aVvvui7cpxyEVUg3Ou1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc96aeed-9741-4964-a9c9-08db51da1af0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 04:42:20.1494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjqiisIojfuEbZAukKuWlkzkLTjQkxUl4nG10E7/KeHvsQ5MEGwUH5s21A+6Urb7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054

For now several ARM drivers do not allow mappings to be created until a
domain is attached. This means they do not technically support
IOMMU_RESV_DIRECT as it requires the 1:1 maps to work continuously.

Currently if the platform requests these maps on ARM systems they are
silently ignored.

Work around this by trying again to establish the direct mappings after
the domain is attached if the pre-attach attempt failed.

In the long run the drivers will be fixed to fully setup domains when they
are created without waiting for attachment.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cb1287d4d5dec7..a710e3b5d1e6ba 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2841,6 +2841,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	struct iommu_domain *old_dom = group->default_domain;
 	struct group_device *gdev;
 	struct iommu_domain *dom;
+	bool direct_failed;
 	int req_type;
 	int ret;
 
@@ -2874,8 +2875,15 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	 * mapped before their device is attached, in order to guarantee
 	 * continuity with any FW activity
 	 */
-	for_each_group_device(group, gdev)
-		iommu_create_device_direct_mappings(dom, gdev->dev);
+	direct_failed = false;
+	for_each_group_device(group, gdev) {
+		if (iommu_create_device_direct_mappings(dom, gdev->dev)) {
+			direct_failed = true;
+			dev_warn_once(
+				gdev->dev->iommu->iommu_dev->dev,
+				"IOMMU driver was not able to establish FW requested direct mapping.");
+		}
+	}
 
 	/* We must set default_domain early for __iommu_device_set_domain */
 	group->default_domain = dom;
@@ -2899,6 +2907,27 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 		}
 	}
 
+	/*
+	 * Drivers are supposed to allow mappings to be installed in a domain
+	 * before device attachment, but some don't. Hack around this defect by
+	 * trying again after attaching. If this happens it means the device
+	 * will not continuously have the IOMMU_RESV_DIRECT map.
+	 */
+	if (direct_failed) {
+		for_each_group_device(group, gdev) {
+			ret = iommu_create_device_direct_mappings(dom, gdev->dev);
+			if (ret)
+				goto err_restore;
+		}
+	}
+
+err_restore:
+	if (old_dom) {
+		__iommu_group_set_domain_internal(
+			group, old_dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
+		iommu_domain_free(dom);
+		old_dom = NULL;
+	}
 out_free:
 	if (old_dom)
 		iommu_domain_free(old_dom);
-- 
2.40.1

