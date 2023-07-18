Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B089168BC;
	Tue, 18 Jul 2023 19:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Frt5JINZ1pTmetuol7aUY7Y/pjre5CWFSghdQMUGommMNJ7RbSsq18O9aabIlk41yc2UAMP2f3otYQ7mKvoowfNPG+C+p2oQbpTVdsufGFcK5TNRZNpt82EZ+xWYk6PCiKramBJHZzfHnro+Fbf49rjGKGGVcszsYlUgTz/vFK4MoO5feDifldwjnkgl8kqNVP7nF35btaktqfQ99hiPhWFdXJM4GzfnrxKZnQ5T97AsLxsDAvL3JsqpYp1FcssPTcPdgBd0NipEdtJtDqaeFuDrcnxLZiTnLRVuWse3IyDd/BfahaVjVPLa0Oxa+DYLNhERbZMYbuYBj8eHSMuEiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lF20GgUKOoytttAX7Lh/dfU2iYeWLRAsCCkrvp7s/OM=;
 b=Zbe/BTPSA/Clz78ewCOmmaAU+qlmXww4c1ixwMNW/1hL/6+TxxhB5/1GNFttsimBUxm9kmd9XkYdVFEwho4ux3pEmpB+IzWwYbR6sL3Ji7l0Y3fFTXfqGSJUTVaS4W6WtosMl/pbw9XL5CWmpA5j2AVr4eLgajAq1giqZihZxELqAx2Qofoz7JRMdriR+HapLPMrdRPXyRYCyjhzyVlYS/Ll79F8ruMaac8LKAllMS6EJ9pvnohx7udaZJhrpnRwHwOFeC53h/MXVRZanL4n8N8mdeJroNCJwnHIgJpDOOx7iwaXyURYJvsXhIVGZ+0NeQcmeOjKDYblEToRk8y5/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lF20GgUKOoytttAX7Lh/dfU2iYeWLRAsCCkrvp7s/OM=;
 b=eM+Ul4qoWyjCDEv8f+R8Zx7Ey/sYCTZPbBxOLkLByJg5hjAlo7DUo4EQl1qcgOO3SfzHFt5JIgfgfiRRHzghQ+grHkLSC/XsjkrjRFWMDXyXqbZv98ZyxWm3RlmHMtlQ50gXyp/UJcY1R35vUE6/P/S+3N8VD/p+WKjAIsYUPoK+3upey9JZGrHQ1KWzJcbCUfdweaQYIinnwGawdoeuZqJif6MDzzVXDY74gCePiMjEPFgUTXiS8x368ZwKb+2sCTWSsoDhVU4Whou+UfaByHDVvzpuj9oKGpprJMcM2IMAgznngqUKg4yeri4fpqFGRAKnOVuZjCaH/BUGGTXuZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 19:06:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 19:06:02 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 06/10] iommu/rockchip: Convert to generic_single_device_group()
Date: Tue, 18 Jul 2023 16:05:54 -0300
Message-ID: <6-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <0-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f8454f-c42f-4f5c-8f59-08db87c20737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O5ysfGhkHCM/O9WIyaA+ZlzwuKQyEPWbi60Plh3yLgXL6zZDt6J6suL9olq96s8LRFBpukclsUwBMmne7e0zoP+t/4v6OBN3NPGyXJw8n07Erd0ZLz0OXE3CRZ8gft7PmlxmCBuBdXZRNh9qmXWc1DYnaSxcwjU0HBT3tRHbwn6tSZUg3P4F1M3TMV6cIFEF4nOt1XpiBsMILD/Emia2sqfHu0nr9NTqf7J87CZMCFvKToCoxFmQaYGih7cBsad0t9WYMmnMpgOnMV+H2Zxc6v1cKksm5qC+mO9GF9h4ofeuMJFEtnA8M+vpWl6lp0utJbh/EQ4Vpd5YrGFQ+0T1gtx8a7zzPAZl/YQxlYWfOMMpgVXJFt8m8gZesheaKMiYfFg8PkoYVDAslB4aQTRqjCjUFmVEDiI1jX0gzu9hAEE9seSehxoXC/14iXjF4syS2yxF40MIxF49E9JcgiAE0YF6itgVFiI5e5C2d6C0T0NSO34PasfEhFFSbrNKqStNGPaQM0aXq4Vqak9eRQkeOWmNob1eF7i95FqlGENK4rWnsxeuPODeN2vdExU2zmZAWmc6Wd/kQPntHrmuybIMmlRMfZ7eMjW9H+D+32ihnleeQayH/uE93+lhS+SHGKvX25vXSuy68f4gGskWxUDu9Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(2906002)(110136005)(6512007)(38100700002)(921005)(2616005)(83380400001)(186003)(6506007)(26005)(5660300002)(86362001)(36756003)(8676002)(7416002)(4326008)(478600001)(6666004)(6486002)(316002)(66946007)(8936002)(66476007)(41300700001)(66556008)(4216001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yul6aPNttOTZMOdaGf5Lw5CH//iSVa9x3D3RcJ1SKbWH+hM5jSFn/SS2CFkh?=
 =?us-ascii?Q?874lUY9Jk4zqO526KJEL/11FCcGcQcFXrEH7TzHfBEk0ViYmI2kVHAXAz9h5?=
 =?us-ascii?Q?2o/uWfJ5XDAg5KRfCAJLzC+bHfCKpb9VxxqzIycz/V2+gHUSwbcyOzrhWlnn?=
 =?us-ascii?Q?HgdnAeb0ViYbn/SUnNsdWDY9V79bZT65LbeTkL9FNy9Woq1GnW1MPCZiV0zd?=
 =?us-ascii?Q?JPw04eWP2bW3lAWjhTBE48LcTf/U+grTTH6bLnqAKoAD19jI+FdayNPRMDyb?=
 =?us-ascii?Q?L1HcAWxokfJezTyowWIC3K/2U+keVhq1hxrsg7pFuybUKvzvo4JcSnIhbF1h?=
 =?us-ascii?Q?m40kYWxMtzP4vb3EChVvs90HqmAf8o+9O/nmcb6D1LC7VssLQNwdCS//9F3J?=
 =?us-ascii?Q?KXOhuaz5B+32aXiXX+s/q9MFLMSdqsgLgKLN2+lXsW4ZXF5rXHZDa4+eaVxV?=
 =?us-ascii?Q?yH4/fG9eoBXbJp9/KFvyOItFAewEqGlR43XEfdk3TyuDLufa0jNur7BVY7+t?=
 =?us-ascii?Q?lknZfwK5ElEL5T60TIuG46lcyV9t0fKHOKKFPrqyK8USExnKuTox1HfPgnNJ?=
 =?us-ascii?Q?6EfEh69+ddAMZh/cUYCLOZu2tEaWebw9Nyu60wwf1TJbBC0BRys5rlAL/rff?=
 =?us-ascii?Q?OZzPxwaVpqaxSyTa/Xp3XqwspfNxTg3eNfjeqmHKDpe/vVIrHTutSh7kCbsd?=
 =?us-ascii?Q?bxmWt+Z4rmznhRF7nD797L7n1nYlOdmGOtStvNrLFioI/5O2KftqkMv26vJG?=
 =?us-ascii?Q?5dUL7tdD73m8tdvjazWLcjFAUUFinfng3qzOekJOwkHaw/haxqKi7UDaLcvu?=
 =?us-ascii?Q?oRp/IAMmNByw85tKyEmymywlGoQEbJUb/jfOZrBMCvgzWKozqaSTYm1sUxyr?=
 =?us-ascii?Q?A9TrlQjBHwht/RLipIYstrDv4Z6UITSmGK3TJqQF1KcDd2VsS6mYC8KLpB0F?=
 =?us-ascii?Q?SjHKZZp8My4p342UOsmfZrvVF418ahPzgEn+R3c/sFVE6Ha8AFK+JvsTVBv0?=
 =?us-ascii?Q?UBnh6IS6bqFQp8q345Sh1kt8Wfmpvikim17G10sYHj6HMJnvd2AtT8LxKODO?=
 =?us-ascii?Q?2muS8ndol4J1ldyD8G0IGNbm7lPfrFv74U3azx9DDf5+LFhgdlHwHEuCRgi6?=
 =?us-ascii?Q?CeaSJPWVjUz9Y9JUCtdBUaaBjWbpZRUag6MZkRvsWjsnsbx0l/4A/E9YbPGC?=
 =?us-ascii?Q?fnBww1xMcfxCD0gtrjExcflvAM9ISFRBRDzNtBp71daJ6wSl2QukoggFqTBO?=
 =?us-ascii?Q?IMLR3rxgZ9sP9gWNTSqfZlhPWgJvOdvJlcNpjnTURl9kIMtAHcQkVQMHwJ62?=
 =?us-ascii?Q?zSbaNb/whcly4TO7kFOOmiDiKM0jbHDGqLC7fiqI9niBDMr6biFXEt6cXp9Y?=
 =?us-ascii?Q?VpShvcU44yKrgVZB80uQ9VI+s1cAT6GZbS1wEiIlwtYcvqWiYaaMKEM182cn?=
 =?us-ascii?Q?IFptYeQKNySU6EYLp+BVyfDYxIrpYqanaRDT0hgpxkFdfR+l9jOZCfDN0VAw?=
 =?us-ascii?Q?rgffXP39ssTkMJpOEk/HFyjhg8U2tfsOBii7S6XW4pDVsHj1yCD+bFZthC5a?=
 =?us-ascii?Q?oNuJ2sIN1bnZSJmG86ZaqML/fSZGsPPwzZJByHPE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f8454f-c42f-4f5c-8f59-08db87c20737
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 19:06:01.9392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEb4wJHAXWn7mVDHrmgS8YSj+MUT5f/ue49MwQTcgs32KM7C+qEOmebWwWY8NAgJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329

Use the new helper.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/rockchip-iommu.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 8ff69fbf9f65db..91f13cc9411548 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -113,7 +113,6 @@ struct rk_iommu {
 	struct iommu_device iommu;
 	struct list_head node; /* entry in rk_iommu_domain.iommus */
 	struct iommu_domain *domain; /* domain to which iommu is attached */
-	struct iommu_group *group;
 };
 
 struct rk_iommudata {
@@ -1155,15 +1154,6 @@ static void rk_iommu_release_device(struct device *dev)
 	device_link_del(data->link);
 }
 
-static struct iommu_group *rk_iommu_device_group(struct device *dev)
-{
-	struct rk_iommu *iommu;
-
-	iommu = rk_iommu_from_dev(dev);
-
-	return iommu_group_ref_get(iommu->group);
-}
-
 static int rk_iommu_of_xlate(struct device *dev,
 			     struct of_phandle_args *args)
 {
@@ -1189,7 +1179,7 @@ static const struct iommu_ops rk_iommu_ops = {
 	.domain_alloc = rk_iommu_domain_alloc,
 	.probe_device = rk_iommu_probe_device,
 	.release_device = rk_iommu_release_device,
-	.device_group = rk_iommu_device_group,
+	.device_group = generic_single_device_group,
 #ifdef CONFIG_ARM
 	.set_platform_dma_ops = rk_iommu_set_platform_dma,
 #endif
@@ -1280,15 +1270,9 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	iommu->group = iommu_group_alloc();
-	if (IS_ERR(iommu->group)) {
-		err = PTR_ERR(iommu->group);
-		goto err_unprepare_clocks;
-	}
-
 	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
 	if (err)
-		goto err_put_group;
+		goto err_unprepare_clocks;
 
 	err = iommu_device_register(&iommu->iommu, &rk_iommu_ops, dev);
 	if (err)
@@ -1325,8 +1309,6 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
-err_put_group:
-	iommu_group_put(iommu->group);
 err_unprepare_clocks:
 	clk_bulk_unprepare(iommu->num_clocks, iommu->clocks);
 	return err;
-- 
2.41.0

