Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277BE5660;
	Wed, 12 Apr 2023 13:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BepFpPPNKpmmxRIW0Yt8z4MFPLsStC1g5q7smJ8BNlezYLobuT73U9zIIvl8xHCckk9V1kL9rf37eKqlt92aiD0/mv3ab/PF0qTK3G5HCAQ+ixPDFZayK2y/oDUCefXg1HaWmwG3kDZT0/pkzXfY1FO5d/0utHY3ytRjAywIudyih1Hbx4iDE24j0LzMH28QLSLppBfLz6uPBFrhNGB0TCvhCxoxvtNAESTekqfl0Hfc3enj2q2OxVd9Dwu+vxpSEJp5XfuLQVPDWvisxJN1EfoQWldI9wGCkNnC765R1aEI9YZyPoBsviZ/NRmfWDqr4pKFn5BfH0QIyxPRw92Vag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lp34i3tev9imjKrfMuFNochsmojzdt0I73HNLeWEmv0=;
 b=YetyOzoYAPKEdmr6GQozfqysjUX2qrX9ihBMTLrlvmRUcbQMuOdkHUbVN0ilRkThXamq1ems8vWSg51eRWDWqytNqY4B12COWJdXV1FWHtSTNVbzKtnCp9oe0YL3aPkTDO0TmhDaBlf8WvE+/xvsJ9byZJWaxBrLxuBaNn656JEPiPKuoUdgO1ydi9qKzUW8hetYtutF0Zmz+QCl13jwxvLBiX/PcBV67lgYZVUaz6nVjRYD3BhOccD8C9MpuWm6N0fzhu5UBMwutJtzSeQI/EnU2ghHt/aVtaTh5eg7sfUzK/y5PFZdRSK2NI2FjKZbX8ACWlZ19g5PlfpbeY7HjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lp34i3tev9imjKrfMuFNochsmojzdt0I73HNLeWEmv0=;
 b=muFaTZ3PWm5DK5zDpYxsb/tRp4M0ALlZ0BGo8LywTq+2qNlMs3Si4PccR2LOsWvTYFERI9A7NjyspugRhk4Q1+cMW89zRETtQqYAxmexsJDEdL870IjmCEV3g51Jlsy5oElIn1slZN7yYGeWfIY7FAgiU8EkMOVJhT1qDsV/DcO5+8phylEgc7AUsb53jEzllzbVbEVlcoMYlNOXMXwf5MB6yqMndnggGR5O7iOFTm8LYVL00Thi+y8NHA7jujRfuwna4ld5B6XXNK2DgYoI7JQXisj9E2irkxzv6oHD9P66mEhCcducxfVe107zuB2mD+Qz6ubKAndxFOWXxc+cFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6957.namprd12.prod.outlook.com (2603:10b6:806:263::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Wed, 12 Apr
 2023 13:51:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 13:51:52 +0000
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
Subject: [PATCH v4 05/17] iommu: Use __iommu_group_set_domain() in iommu_change_dev_def_domain()
Date: Wed, 12 Apr 2023 10:51:35 -0300
Message-Id: <5-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:208:19b::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa8a10f-7dd5-4eb6-8ef3-08db3b5d0fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qWeCy0aanqa2fb5+btiedGog/I20FNDeyVKviMmlZTF2brVPZf45eejXrHH4i0utusBTJSB2Lp39UI6bK7Kdl+NvGYHOhej4B1QsSxU8pQkpQ3ydvYbLqa+cP/SOg5knap3UOERRpiaWIzFVdLJE/5MhxEhHXm7jlf8adGj+xLxrxtS+EqUP6jZ5K7TKsiPrmfvV4EYn3Py+FkOVqkGtZpDmL68eSFcmX2Y3NTSLcK4AZlCi4CJTIAjIZGxt+Kw6+VyDVLCvRRI2FOaxcaNYF2JK7zzwpSLLzcSCBQtuK8a8Kartpq1zC7pAv71LCdgNmw+J1+n00NAkNr4d0mtMcwbyuEwb2MzzxMYmlSLrBaUDFN5xj3uCngrGTegttqxZ0sXoKZOPuvrNVjnarZiyTC/nhz9l7Fgz9SoCg03xxAiaJB2CNKSL+iU/+kdY3WomXHxJFbafSI+f3mlfTDOC2GGK7ksqfWGMQfc9FR2D/PtE2ZRYeibehH0L+utyNXZOK/SkzJxOIwMkG29m9+/gU1wstOAuzhSz8yDAW8AJPdmxQyyQZGC3SdMWZfUN+wZSnIjOl8Sy50ydx3vFW/QQpBCH9BxohPzVK1yXA/9U9EY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(6486002)(4326008)(66476007)(54906003)(66946007)(66556008)(316002)(110136005)(6666004)(5660300002)(478600001)(41300700001)(8676002)(8936002)(7416002)(2906002)(86362001)(36756003)(2616005)(26005)(107886003)(83380400001)(38100700002)(6506007)(6512007)(186003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TwOugJsyMA2nrmu19vPo2DYDZrmBrp9EAsDJ1II5Aho/ZXfeOwJmdtpr5Hxb?=
 =?us-ascii?Q?63AxEKpHWeovgG3D/KRPZhfPHb6Qk3MooQTkYCQJ7egbz2f9s31eUHU6WxuW?=
 =?us-ascii?Q?WkGYnMpfC1vVhjmxk7lRzmeFt4ylV0HOEer7tgxtWUhDeBKxwJZnAmJC9PyP?=
 =?us-ascii?Q?S8VxTrpc/yDt6Cio52B3ex16p4HwastU6kpTwT/zcQltys17kujhGAApB9a7?=
 =?us-ascii?Q?cx0Hrtx9OoUq3HB3Gh+fzDDDKNHPltsplXPxoD4DoHS8TWp46LwlL7a72UvW?=
 =?us-ascii?Q?eSUWKkY9MIKkpVUkXg4gH/qqLCyEDNluy5kmLz+1R5qcw144TR0pOWVdNgSE?=
 =?us-ascii?Q?gl55Vk3dX7c5df7Kk5p64NT3hPUnc+M4jglzXOsc0q/NoTwQ267L9G6VyL3R?=
 =?us-ascii?Q?woXfhqUjXXRWrdTBwMS1xh6H4bo1IsgeLV0VXNelFlSkMKiPbdvj6mhREWDX?=
 =?us-ascii?Q?pcXSgPDTYqkTyuXHycPsmDpCLKuqa44FzBEefEg4j21kRnhYyMw8DU+j5K4n?=
 =?us-ascii?Q?TIqdb239wjQio2dK8LUtJLG39Sg6mdrYUtnc6KLXiak0MjYbXMRjKo18Syow?=
 =?us-ascii?Q?lN+6spzbm/0xdyia/oudsUUsHaHaU1XIM+cDfeHLaiqoWKCz6f7vsOlDmyOJ?=
 =?us-ascii?Q?ejSNMdaV7Egf2m/u8WcFY6lBasbVEEx75foVvoYT8xppOguKecszxCyqoC5J?=
 =?us-ascii?Q?4HG3SEDOXo5oMIJVbx7BzCxSRS8A66Ebjp5KtgJeGm/4L5yH2NJ+1OaERWFM?=
 =?us-ascii?Q?WCTedK7IGCLsnEmCBOLwkRfQFuaSUPPGDmNfKa7RXoPazuBrsG9WXkqQbUfx?=
 =?us-ascii?Q?HXkEgtLTBa0PATXvYtpLP348LKd12JmrYHtrWdTLxTM8uZOj5wVQReOW2uwi?=
 =?us-ascii?Q?551rfOTh4ouZ74aBarVOkz8daUaHWwap2he//oT03av4fje98W3A9Y/Du/aZ?=
 =?us-ascii?Q?RSV0mwfeW/Zok2xXebIFnGy3Iow3uXzsRgOBEuYbyraF36FJgvjVXb6rg7ah?=
 =?us-ascii?Q?Ex3P3y0lyF2ubgCSHEE7HMEs0PtNadqloEEcY16XsYv8/orfoaKVoBGxoid5?=
 =?us-ascii?Q?pWj+UOpKCbm/Ay9c/2J+qRWVeRCBeip0NID/aMyjJk82bKiBKLk0NfE7CVx6?=
 =?us-ascii?Q?Sq1AHo3hMaLFEwzMT+VQpFUG1yeKMkxZ5Wyq254zuMLLySZwWBAL/ksvZOQN?=
 =?us-ascii?Q?0qzi82s4c55+RzMRsAd4P6IyJrAUkNASPmieGzHIGmyGiEwora2C43TK7pRK?=
 =?us-ascii?Q?G8x940N3D3JQZ72m10xLYzN9isWIqWqmvcYurq9HKi28iC4FWpJYwzXf86k3?=
 =?us-ascii?Q?JzOeA9Ijf7iT/HG+0BK5CapMvikk9SzOdH+wcReyNz3kFQh3KsED1AcvKH8w?=
 =?us-ascii?Q?Q5MLj6unIwICi/VO4jIyOfSpJOwY7oqzG62bCdMar3zIZLnNf6YaPt0C39kp?=
 =?us-ascii?Q?aD3VNvlMHkJeZ58xeuAYzD6ZTkCw3wVzgcjjW13boenCuKKRLLshtpVfj/Pn?=
 =?us-ascii?Q?xffTXKq+dGqlYY1EL9QwxVt2d4OZoObTdU/2vv5YigoH5DJK6F6q2xOUaStt?=
 =?us-ascii?Q?AG+Vd3MtS2BO7zZ0yKnZt1llWx4AZNPyq7ddDufG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa8a10f-7dd5-4eb6-8ef3-08db3b5d0fc1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 13:51:48.6797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxlIqZReLE0O81y5b7gfwuLmRhWt5VfOWGb5Yz5lIrEOg1/FDQqQp9hZoOLUXZC2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957

This is missing re-attach error handling if the attach fails, use the
common code.

The ugly "group->domain = prev_domain" will be cleaned in a later patch.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2b1fc060305ce6..817d90081b4db7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2964,11 +2964,12 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	if (ret)
 		goto restore_old_domain;
 
-	ret = iommu_group_create_direct_mappings(group);
+	group->domain = prev_dom;
+	ret = iommu_create_device_direct_mappings(group, dev);
 	if (ret)
 		goto free_new_domain;
 
-	ret = __iommu_attach_group(group->default_domain, group);
+	ret = __iommu_group_set_domain(group, group->default_domain);
 	if (ret)
 		goto free_new_domain;
 
@@ -2980,7 +2981,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	iommu_domain_free(group->default_domain);
 restore_old_domain:
 	group->default_domain = prev_dom;
-	group->domain = prev_dom;
 
 	return ret;
 }
-- 
2.40.0

