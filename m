Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A3C645;
	Thu, 11 May 2023 04:42:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvX/myrXbXnuSi1kXtU9K7hOfWCWa2LAdHjsZwZ9PFh57deLxnV0X6K0zLrCY2gCWiVtkgecKBEKmg8vlBF3Xv63RCaP0nCQ/Vsqry0T8wldimoH0WJw75L3LRnw5zdxvFu66VoG8qzP4ZNFy/FGYHZc4nS9PUfI6xl7UVfifd21BForUvoLbE8SmCVTGn/PxJXi6io6vkMzQ1raf1fgLYlVItjcI7bOdjjxiVIHVbtCOYRuf9ah2tKkIiJ/p3EP+dYpHwNQ4nMXcfKtLrq1yrLkO2pTyKCkCUiPBbk5XuE5hjVD4+vAIkGdGn8BVtevRAfCertB9DuxMXss3VL+XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85c/BTO/W6EZiYVJKt89btIEClbMZevh85VksioSIf4=;
 b=aBWNG3gJB2q7HgzVr9oZYv1SgIgeZmV+DDaf9wAlmuj9Epwt92ODhl21Gy7yDTfDXxtXDviMouO1wgElxt1UacTJ38m9Vh0giYg1hiCUBMfnQn1WY8YLj24wpMNCHRuvONJgBwYMdQGyjTwvy0RXeKQEG/xm6BoWZBZv/ekBrcSYKEs/gWZ7GQO9JMuvkmS4bSwDahNf2aefbZ6blOmLHS2sxrKhSd1DcNywQUgqQraEgi7IXpfDEcCTwtSOL7IiBE5zALOgyM0BtiPJuJEgB81wg1xzXXXmUBlboYNmPe/StlnzUP02rk2HVmcHsXCmr7qZUk70BV870iMpSeAJAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85c/BTO/W6EZiYVJKt89btIEClbMZevh85VksioSIf4=;
 b=dOxj0pOh4cxLlllppvR/CLe65bBllOGZDnVv1ufDQd1MLi+X+U2dOmgmmaTcPMIhle3Jk3QsN6oxn4kDFyaRb7Yq5LE3pabdTAeynaVOTb6o+mpl1SqmAnSuC33jz1hhl3DJvbNDSyYdCqnzUPfzZHukf66kaDhkv4W6rbyZPaddQDWMz3McB963oHlLCCYptO+D+Cnv3Y+Rv7zLNYfYVh6vNS8Ug12eGr2mTg8ur/GtDvYbwFy9/ctOEohF7qTW/9jW/Mtfw1e90uk6t+cBHFXfUsuZIl+Tf8heiIX2eeg/Xs+mRG27j0mCgpy6IawH1uvwignJHzR7YftiP+3e0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 04:42:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 04:42:20 +0000
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
Subject: [PATCH v5 11/17] iommu: Remove the assignment of group->domain during default domain alloc
Date: Thu, 11 May 2023 01:42:09 -0300
Message-Id: <11-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0030.prod.exchangelabs.com (2603:10b6:a02:80::43)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: 5610b028-45c8-4f1d-02d9-08db51da19b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RaHu0/9I8+QxvoKbpt6ViI9cz6wUzgTeC3nezfG3bbh/25nEFMLOlqz5tOW/Rfg7pVjD9t+9bU3cqSSHdBKA0WNirD3AGshBLuCIc9YDCFc6P5WktvZbrKLfGiTRSnV74NRZBK/yV7IeGjb3oG/tZLVOfcjkywXsFIg5ZAIXQoCUabdrJbXU8+hdw5BTKXr5irXpZqXE07b+5q1npMb2rLfoljTBdtlbqOK4fRzuLDQ84Kt2Tcluty66VMEfQj0NJ62roV7hPwxUEn6qTpScpi3w9CSiv77eLiRpVMoK5SPdGeOCkzBAN3Ni4HF1wTVEwQlTh/lghT6umfteAxb975mYYh7L7+fBDc4NdgVHN3SS9EalPjbtrGWBqN2gnzSH+6ARCGyH8hY9lLu3yhdu0y1xV6GAOJGMN4Mq5VRX5qKhmFkLZbtFcEE1vEVkjOYJcgz2BYYi4BRhABvE1obyhqtHEMoZ6PsM56RDKtRV2SPD0JXfT+O/w2n7rOTcYSXrX1TtuZydtc8IJ3l+3mEPu32jEDQ8WISC0BCiZxGk1M7lWCClGfWD/fnUymIpnyoU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(26005)(186003)(6506007)(6512007)(2906002)(41300700001)(66556008)(66476007)(316002)(4326008)(38100700002)(83380400001)(8676002)(7416002)(86362001)(8936002)(36756003)(5660300002)(2616005)(54906003)(110136005)(478600001)(6486002)(6666004)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rqu3BayFVgdTU+7fqqmaJI+7eh/QcbgaS9Yk/1Z6RzCWolTFi7qyjZgLHb2a?=
 =?us-ascii?Q?ix97MKRqkxG17g7Xem0CynrR8IyhCKDUWuYdK5SHAUSkmktr9E/+WfN0kiHE?=
 =?us-ascii?Q?/kno0XDQyA3W51XAp2TJRs8y3vmkx0S5bm2GrrAajC2ku20PPCbUb4O2641/?=
 =?us-ascii?Q?s7F5IPyc0vn9fD3SDSwHVdGSWlKfzRvs2EQblZNbmQ1pXRr0WyQRHQbR9kOT?=
 =?us-ascii?Q?FaAo+Ip/968PnSFumWz7uZ+N7aYBHo/EDQMCMe5PED3n8meAqPNi1I7NHtwQ?=
 =?us-ascii?Q?e8zs6BskEXYc7Ct18ktflfZhnNAol+HXXCsD6Sltx1LCl4mr2D2ZWOnqNHXy?=
 =?us-ascii?Q?Tge6byHBcEb9/Pi28R5AJHRFASFGws/JdgpbZeZR2D+q4/4NDlH5i/w+yHik?=
 =?us-ascii?Q?MJVRKRlX+wAlTVHajUeh3mMva8lq5AGA7lWrudNGt1hoEq1lgMeAGfO2O88t?=
 =?us-ascii?Q?sUPCkmsgIlrLwXAlqm1RJGAtUNXHUcuJ+GSwSKWCnsFY9le88zt+bce8mUB2?=
 =?us-ascii?Q?9rypHAdvEJ4bHltXJbwd1CrKnA3EpGEjNxz+kWJ7yfYzlqVFsHQApSmsTJLn?=
 =?us-ascii?Q?FQBvzC6Zy70wuww2949ieoB4Ie3dnovGfcSA4Ys2PVuTEcVsMmPojmVsOwEe?=
 =?us-ascii?Q?mFPBDrqHtyj+7236PMJQp60dH525bSJ7F/u2hw6lx9JbfqD6TLZTSf5AxmFM?=
 =?us-ascii?Q?d4Rl/CbwxZeIv76skSU+7Alc9JPcKWyRmr1KyUvTe3Z8ttq8Ie3j2zlOUaND?=
 =?us-ascii?Q?2YqwcFapWr4aoFZKR+yIBUjprM12N5dgVIqAbs6t7x4d6h3pF8rEiq3/AX49?=
 =?us-ascii?Q?PjltcqtebkjPxAtg/jG5ZovvbO9zEV6bS62AwqyZdV6BCrGjXLpDG4VIC0Jf?=
 =?us-ascii?Q?o6WfjlI++jYok+CpH8mje/huwq39kBRrpDVBHAqdLXmEq0LWoaTngmkhDz+O?=
 =?us-ascii?Q?mQGW0LIdfxdPQd6/Yg87fjN/riO7xYqo0qajoo2V4mcZKU7d0su82VTZW2uv?=
 =?us-ascii?Q?l5w3DehNuagbsNQMMM3oytx9YLynMTLUO4RHLXvN1Nb9TCJmMNXvkauQJuRi?=
 =?us-ascii?Q?qwnVQ4M4cEqmR1CZ2Eff6jTzdvSAKydbt32swY1A8YizsWl8EUTbepsyc5qI?=
 =?us-ascii?Q?1TaVbU5+KMCC0wLknJS3mrGSL1TeFsOPZQ5h6MrmeRw9q+ruQdU4R5aLF2PK?=
 =?us-ascii?Q?6VWSxhwM1D+r/SdvL5l8/WpIxHARTCREhTS5YedoJCq93jQvjsEtDA2+deIg?=
 =?us-ascii?Q?fi8ZnljVYyPMFfudrtY3uK6LlmU7hoNopt+fjLOkp9N8GBQAAjkxd8eeYDqv?=
 =?us-ascii?Q?qYKhUBOjAjG7EYYoLXgntDNg8rkGdkYWG8Hg7CORMc8bfCSRnZKisBFnBxsW?=
 =?us-ascii?Q?FEEMI05AuEmMfdKFi1j3d/KqGB9E9WDE7zyDFhnAdt8Q08Tp4nvvHVqlJ6X/?=
 =?us-ascii?Q?8u/b3v37K6SGaiNruRcbKiCijTm7iHf9Hpsba5A4e0t1VJpP4mc2QMEwGpfw?=
 =?us-ascii?Q?sLMjPWJsfKkM0XegFg7S+4wYpbpK6YLVYvlNN0OXH5/WhI+hsfnbisBzxKzF?=
 =?us-ascii?Q?Hwa1+BGWpTSAO4BEyTEyNJ9lGjbCijd56AWfDvXF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5610b028-45c8-4f1d-02d9-08db51da19b6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 04:42:18.0340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4WMc2EPJJmoQ5RxkC7dQyuIJuOKOnIsHH0GTSlqbvxZQrfnnDNdx/g2ZBkcFyAH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054

group->domain should only be set once all the device's drivers have
had their ops->attach_dev() called. iommu_group_alloc_default_domain()
doesn't do this, so it shouldn't set the value.

The previous patches organized things so that each caller of
iommu_group_alloc_default_domain() follows up with calling
__iommu_group_set_domain_internal() that does set the group->domain.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 690025e26413f1..7cafd830d2067e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -435,7 +435,6 @@ int iommu_probe_device(struct device *dev)
 		 * checked.
 		 */
 		iommu_alloc_default_domain(group, dev);
-		group->domain = NULL;
 		if (group->default_domain) {
 			iommu_create_device_direct_mappings(group, dev);
 			ret = __iommu_group_set_domain(group,
@@ -1664,8 +1663,6 @@ static int iommu_group_alloc_default_domain(const struct bus_type *bus,
 		return -ENOMEM;
 
 	group->default_domain = dom;
-	if (!group->domain)
-		group->domain = dom;
 	return 0;
 }
 
@@ -1869,7 +1866,6 @@ int bus_iommu_probe(const struct bus_type *bus)
 
 		iommu_group_create_direct_mappings(group);
 
-		group->domain = NULL;
 		ret = __iommu_group_set_domain(group, group->default_domain);
 
 		mutex_unlock(&group->mutex);
-- 
2.40.1

