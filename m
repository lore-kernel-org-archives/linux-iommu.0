Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F8E33E5
	for <iommu@lists.linux.dev>; Tue, 25 Apr 2023 19:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKOi80FvKS83OR7VtOPtZRuiP+D/7XwlVRMIhuf2bz2opGKa5Zt6pNkFH3kJffm4I4+g0BGC373g6ugwd5mJjVvQYCfTL3B0hUhzwCfM7XKRjSoLTdDcg3DPAV9M0RcUv4CiQUz/a5obVntyIyny20av/ENHRmZBTIrj1GOnfb8qNf3c13VzFypjBXv0CU8mNbONk+D6t+bOGl+tlHRvnIgGCyp3GrXoDPZ2eWlsl37ml4x6+1+JjWCuW+04RuHddeNjBBaxBGsoReP0cDxlu/KNhcQVG3JQPneA5MTCR7grn7c1x6j9EgpaYi2aKKaYcD7N+nM2b0tulxjYYeEkQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBUFZTjNqvE64a0Fl+mo5OuvgoItrCVh1uXi2jUXo2U=;
 b=j9569tNT5To/IeXsH4KAkjkf9DQVMFZrVtBA0uDaaSGs3RqZfC1tfccQBOrTHnNdX4XboQT+DxqqI2zKHtJW1JSnyTZ3VLIxdhxVSALR7kY0HE6CuDfq+k+Wa0P5Yh8pEvPX2os5ZwPue3iHf4sgdpJYJAROz1C6ziupI7gFDYU9j7904yCp9D+cB6R2YAdLuZ1T5Y1wcmUscBTfm0/4KOjsQ+tWYOMmxzuStx12qhsDSK/zkEoFH3jH8AVlE89WCTRetSNIhGgjSNmZ/9Ob1LcEB6q+AAhIAAv4SdVNn0Qu8BFCzGa0Fl/LXomzaAUhB/MMq5nrBY3CMZbJMbvaaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBUFZTjNqvE64a0Fl+mo5OuvgoItrCVh1uXi2jUXo2U=;
 b=N8E+iSHf4FeGbs7pES7jgSyNCZvYVbCKalpl6J9wRTxCsRfUO319Cq2SEo1Q5z998M9t0A1bFZeKOEGnbsNxr4CX/CnHIRq1VbCYyUIZrqo7om6gF74DZEAueYKo9G4tRwl3mOYwxxNqKdbejTmEnwqltnozzZE1vuoRiNoK8O62zrMD9uxjcTovh0kUzHN1Yccuu5kDbG43Dg6mWNHP6+zKAQSmTO8PMkJ7EQjpMlM+BZnJ+gu7u0yg1Gi/FIHb08j7PDmTVJk6WEX8yaGiCDW5i7ymtodnh1ZFUyk4sEnEsh6OY0D80tETfo0W84X3FeJDZlAI9mcbctIUgL2agw==
Received: from CY8PR12MB7314.namprd12.prod.outlook.com (2603:10b6:930:52::19)
 by DS0PR12MB8814.namprd12.prod.outlook.com (2603:10b6:8:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 19:04:20 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7314.namprd12.prod.outlook.com (2603:10b6:930:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 19:04:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%5]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 19:04:18 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Joerg Roedel <jroedel@suse.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Tony Zhu <tony.zhu@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH for-rc] iommu/amd: Add missing domain type checks
Date: Tue, 25 Apr 2023 16:04:15 -0300
Message-Id: <0-v1-2ac37b893728+da-amd_check_types_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0161.namprd05.prod.outlook.com
 (2603:10b6:a03:339::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	LV2PR12MB5869:EE_|CY8PR12MB7314:EE_|DS0PR12MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac48c17-8485-4cf7-7017-08db45bfdf01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kvqOgG482iWPbBD73oeQ9sIMH0zlTjE1CX8WCcQQayMx8dNaUd7UM2j6gNS4oT5AcsbZp1Iu63MHfu770TvGmy5gubdoyMmgKITtur30swrqDaKJWnTOIkt74zZpb9hDY8zaG6ba3fhBdGqJO8nOIwQbSCOxVZlhq1ai3qMYLE378ilDQWdg68hUw3MF2DGncGOwnQxh1dEHvZIFfZhF/+GqUbECppyJjo/v4Rdv79NU/E/bxxX7X9Fgy14rGQ+0e80J2vgHEHftyZoQ3vArz1rNTTy6hxrrrugUcv2BMWaNjPkKn78e1hgJd5X2Op9BwQ5PbdDCetHNCZuJk2WM15tKCEIdFNdqhzZiec+Q05WWk8qR5XkP0yPxWGac4zvl7P3l2plIED7kLZv0vVHhFuWBTCCUaJNX7Miol4ytvK6cv2bkd9tNdC1sxA5+aKR7nemw3ZVcbd7Us+snOFik3efKgUrdoY3xSRx6vW6S7cNrsBgsR83d3/7VYE6DhN35OOkjPfKomh8weKx3O4f7EgXDOphArTzwBbpPRscgtyX38rhX1pSSczd/TNoEdPsteZiIyikyH8tqQrnvPG+6qmiR0sGHeBwYJkjG9L1/ifc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7314.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199021)(7416002)(66556008)(86362001)(83380400001)(26005)(186003)(6506007)(6512007)(2616005)(38100700002)(316002)(8936002)(5660300002)(8676002)(4326008)(41300700001)(36756003)(6486002)(6666004)(66476007)(110136005)(66946007)(478600001)(54906003)(2906002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4FPR9CMfgBPvhGzW2LeIuEdKqBNAPBW09KOx10Ge8MV2tOdRWW6GPfT1keZ2?=
 =?us-ascii?Q?EM7BuToxnEcFYuD1CrpCg/3NBLZilMT650PY1zd2cVK87g2uDMdh4Q1xVa1t?=
 =?us-ascii?Q?j26VdnYGwMHTgogk26KGbb6yyQLvZrEJX7VO6gIF+/+SKsvgwUtY4cTjjok4?=
 =?us-ascii?Q?/IxKVDdLmYWoPjNuOmcblL1wUCFrivgFem4rAZ5xrzyvwzGNRyrMTl06N8ha?=
 =?us-ascii?Q?XZNwAMMp2WHl7nyE6ySu74WGrt/IzZJbtAylzkQeh/RKFh13csxPY9TwqAzV?=
 =?us-ascii?Q?m6b1CyE7GxtmGzgjh2lgTXujbgZZZdCIojKwG1PUgRqnUar2bRa+g8SRx85z?=
 =?us-ascii?Q?Qt6Z+275hxLq8mk/ZlVHaOPHOFQJKP9wRVolVFE/4//e8PsfV6dbkxfs88ih?=
 =?us-ascii?Q?ajSYmATrtS/NVD2vpl5EeeaathCrtasD/E928SYGj/Cz449/cFz3F6bPILZD?=
 =?us-ascii?Q?RImyXcbuA6XFADOULvmHrN745uVvbtgspXQkKmp9fvhc1KByUretk3Xn9LVp?=
 =?us-ascii?Q?vbxHSi1mqTMs7kITo+nb+dV9uRkuHCTz4PwE8fzH0IYdY+tISEFYkz8KoXAN?=
 =?us-ascii?Q?2pa7u54XMO4f8VbOdNA+SlQIMitgje4dGaH4uf1omyfm7x7eUKeG2RJTVvfu?=
 =?us-ascii?Q?ycOHRnNCwk2TX/HbsgvsrasYO6FkM5hECRmRWJBIpFvaSIivD/ZP2lOh7wz9?=
 =?us-ascii?Q?Vdid5Zzh3S2qS5/PF/SeMVi4vMtAtBmhbLVq76FfY+VCHZAZruoVnyh03kSK?=
 =?us-ascii?Q?1ggqI3Gy3D1mHOVk5yGDmi3KCCTFjlki+GMiXdt66I4KkAuz3MEKgRewtzjA?=
 =?us-ascii?Q?RptDhGUKsMGRh3ktH+sCySfQjvbT5N9W7FzuHXrodIlIkMcfndXOJ5iRG/ud?=
 =?us-ascii?Q?erzN1zNSpgAaEwn7+VRDaD7MHNMD14ohpMu5q4AkZes3+0b2RMcYsGi2T+9u?=
 =?us-ascii?Q?9vwDS3jS0mV+Czqds7zIoEPP+88Bv8ywzARmn46LyLkD0FBDoN4VwstcdQ0A?=
 =?us-ascii?Q?wUs00Q9xoXFXpx71BP59cqsFqWsLjVzK1SMNfPdxIyVrgPhkj5Nsl2H21WM/?=
 =?us-ascii?Q?p13ykCU0a5fjRZL3Cyw3YrI3CfT/aAQuh87y5GZUv7WGh5q7C9wxvRBX3Fs3?=
 =?us-ascii?Q?NSRwpMaHNY6JRC9opHvDkLm5CqzHlge3dOi7r0giJCDU1sFO5QuRp9SuXZMK?=
 =?us-ascii?Q?29lWU/KLDN/z9dFQk+fXWPEoDRr/wbrONKmRkTUqO8Qf9AkLvsErCFfyeupI?=
 =?us-ascii?Q?/IEKrtrsb8SqPHrkKVZilsFpuJ1Gg3pTaDRwEB0XzDLx274V3xDZjw0NodjA?=
 =?us-ascii?Q?QzqXP833oql+rpcWJgjnqWs0GGjSGXn74ZPk8KuFdaXvx9CMIg7xPNIbI08c?=
 =?us-ascii?Q?/8WP0O4cPYP2NyPWjM9Jfok0Jpo6TzMbzVCU9Fu3rsScFgxLznBC0Qb9qWR7?=
 =?us-ascii?Q?Mx/pycd7Uqhc9LHI2IALdEFZrMcQ7RjW4rAzo+SpWYk6ernuun7aoP0EPXB1?=
 =?us-ascii?Q?oYF3MvJEthH43WqfJfRoiCkP5x/juhEH02hXsGfZc6dSHe4SB4371utZ1L7m?=
 =?us-ascii?Q?QvYfWKEaN4h4AhuX9ikKLxGvCYA3D5MxvyQbNXXK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac48c17-8485-4cf7-7017-08db45bfdf01
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 19:04:18.6991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9Ql05GnsNxDI2osT+C213wJ9W3dV8wjLWaWPhEIBbQelpp4zVUB8NBVjMguar8t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8814

Drivers are supposed to list the domain types they support in their
domain_alloc() ops so when we add new domain types, like BLOCKING or SVA,
they don't start breaking.

This ended up providing an empty UNMANAGED domain when the core code asked
for a BLOCKING domain, which happens to be the fallback for drivers that
don't support it, but this is completely wrong for SVA.

Check for the DMA types AMD supports and reject every other kind.

Fixes: 136467962e49 ("iommu: Add IOMMU SVA domain support")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c72a0173db2029..17ea44a79c7af9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2067,7 +2067,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 {
 	struct io_pgtable_ops *pgtbl_ops;
 	struct protection_domain *domain;
-	int pgtable = amd_iommu_pgtable;
+	int pgtable;
 	int mode = DEFAULT_PGTABLE_LEVEL;
 	int ret;
 
@@ -2084,6 +2084,10 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 		mode = PAGE_MODE_NONE;
 	} else if (type == IOMMU_DOMAIN_UNMANAGED) {
 		pgtable = AMD_IOMMU_V1;
+	} else if (type == IOMMU_DOMAIN_DMA || type == IOMMU_DOMAIN_DMA_FQ) {
+		pgtable = amd_iommu_pgtable;
+	} else {
+		return NULL;
 	}
 
 	switch (pgtable) {

base-commit: 4f933b868392945c9b0e32b499b0bb39beab8a28
-- 
2.40.0

