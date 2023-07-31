Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EA91D304;
	Mon, 31 Jul 2023 17:50:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRwV+ux3ZTHWH4U8dJW+KLmNaNB0VjcVgDzXPkexPW7kyzg45498uCZgeMUgxINxp1B9TBAbAIAQvGfnybl1D22cRin8qfNM6lYBq4lrxb5ygFeX3+dlMGFodOuROAbBDYwBDMLRXP2WJZf6zq6Yz3Qm+UiIE0+Sf1zQyp5o0SXZ0lM1328NA3yGXJqotk7PnDpCDUdQCoxPIuT24iucyJWFWHptXlqP6EgkmG7SKpFnGh9XOqz2iaX0V1ZqV6rItDaJJffgXh5IpdfbtAB88LfDEZNoLQ3KaonO9SEl35+FJqCMI8oIVRDVPi8MjPlOCVGhmVwXf1eiDjajemYILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lF20GgUKOoytttAX7Lh/dfU2iYeWLRAsCCkrvp7s/OM=;
 b=GA8E44QRGw4D1VgDRxNvrOKZKkkNYmiQ8iVze25Y9E16svTVn102L2WZWGYqTETg2iYTFBIWY+xIXBdUv5W43WI2cmg7XNQQr/cirXQAm3O8SWNyfB9dtIwXVYDgcNzrjdB7jC4vn3iAcY6z0cK+X/3LLFVCksy3WHQmFFHAj+0xZk6R4/kJqoImZY0tdHYX/Go8mnbw2tOErbP3FyB2t6DrtRCtC8ZrJs45WsQRr9DPDpri8Ypr8ScLdxIcmvC1Mdx4ermbd0V5anmIQW4YvnldqToUEKBtWmyfwTDqgcOdWCYSiaxdAUsoeCNC/z7kaxjsB2kMehxWsmwfnIDwgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lF20GgUKOoytttAX7Lh/dfU2iYeWLRAsCCkrvp7s/OM=;
 b=JDMempPnYJc5LHO0+eCUSurKVuBRTTVc4+12fqoZXVKIOqqwrbVuuvsEcipjZQlk1H0Dofq7961I1MXaZL9PkOWr1XsShVZS9KoGgqxrsr9Xq37upx6ch+rf85aNbGwKekmIy8tOrYgSLcuAQl5Oi4sFwvGMtwfM3r+mLYtks57C+V5WF7/Kv93bnaFww0M4EUODH+MwfKYs69+JnXrkESmLSeAiECuczVuqAmJ3RryMbUENHYDolmXfIJ0SmzJmrkkWlarzQ41X2CriBDY2njDEOOKaKnI1qdcqY/s0nZu/zfD9pny9Q4cWn0wMRSdqYjnzYhQIxBDC8pQasPb8Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 17:50:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 17:50:39 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 06/10] iommu/rockchip: Convert to generic_single_device_group()
Date: Mon, 31 Jul 2023 14:50:29 -0300
Message-ID: <6-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 745bcb3a-2833-43f1-86c3-08db91eea5d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SOZfZ11q/pG8HXVho72Co31TBrkL+9hq+CSR8jS0EY0w4pYG919iosIXQv6IoYMP3jnlDV06ejq4dR8xW+VI5tUYOeJZAVGNK5Fu51c4H3huvaOkb7mtHCO8M09M0lsfHM6pnxweya+ANNsU5GM/xCuT4wlAxDsQQy+nsdE1phAP99hRHIVZUVmLptYXT+sRAT8S25sqvyUJTOGj3oHjSAFEiTOGaH9jpnHgPu3Xy73++DNm0qnNcV1801O91CjOK2p1vktnE8jK/376a9y0r3436TpJMEQk0qKrryAhS1Nv4gkxsO+GEQJQlJCRPEoxmk084Lx4TvNWQ3rUxXOK90kQFbPef1AeUSNNXihejQU8uwXWZIN4YFw87j4t9SYv6sT9QQUJb28TtVL9C7tt/j5UdDuo8rs+IxOinV9sGGLV0UTTZHM/P9ocxWXCwDrWHkkf7f/WKR9HhOpSDiM+GZdtqd8M2E9p7VuEvTaMiUNgqwGynG5Go9FrPXeMp8uIfRIL+CgsiNu34cdKiU8EH0tCqqS4oRwii09D8U/ND+Bkt2qlk83luNBhpUZL9xTNEmPkLnS3hTcHHfH6/ECqOv1QO1AOvmMaC5aNlvAVZOhjDEQx8auMeY/7M0hAXtxn852MW5i+rTx7SgJG5Y9yuw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(478600001)(38100700002)(921005)(86362001)(6512007)(36756003)(6486002)(6666004)(2616005)(186003)(8676002)(26005)(8936002)(6506007)(5660300002)(4326008)(2906002)(66476007)(66946007)(66556008)(41300700001)(54906003)(110136005)(316002)(7416002)(83380400001)(4216001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SlMRSOqnqQ1IO7YhYhw13Xg/dMhEjITfXrcrwChhGbYjK0ai+tioN7ASndMw?=
 =?us-ascii?Q?dv2/MBErX4Xvi6xtemUxL+BLBUgtSDTujxcc9ia2Xa7XNFSJX78FBAaG/mFy?=
 =?us-ascii?Q?7R+3bT0NzzmSYTM/LdSc6G9/qlMNGr9+JCiJxoV22RGaHFTLBdYH/h61tAiQ?=
 =?us-ascii?Q?7pwwNAUX7xD/2NqQyvMjg/yF921uVtzHD2evUemogiH96EJmzKODYMsmNYKI?=
 =?us-ascii?Q?HyzM5n9mzGuKqvtTHzlnPcbHMVbQSxIUB7lu3ZvuyqW+gk2CNwZls55Megr2?=
 =?us-ascii?Q?+QwzNqTu8GgsqgmOkKylw0q3vm77vWVzQj0rzMC8eFM1tobE/CMVOMdbhSX4?=
 =?us-ascii?Q?eUcbUh1tq2X60rPQ2eUDlJqsRHE/S9F4UfF1fwOBEPBto9sswPuI21DaFP2U?=
 =?us-ascii?Q?RChxW57d4H4hW1ieODG46SxYPmuYkCDDDTaYmwEll2Hxj9ll6k2nQwiUOtb1?=
 =?us-ascii?Q?wlAFMLVQYTIqHDbgYAP57Vl/94Oklh3fqUj1dE5yjvFpoSnpBrwPAm5iLrk7?=
 =?us-ascii?Q?AnsRhro7nf+siYs6jpLzJ+TEPaXkVbVVrjXeXu6+tP/nyAd/YZQOPT5HQd+l?=
 =?us-ascii?Q?+53hLiYhX5SqjuZTSQw9qc6eQd1x4PkObJstrwgppYrfTix0jNtLYk3cEBQX?=
 =?us-ascii?Q?7sM2L/wBPLzWMuOp44n703dn++IWWWsSlR9N+e1K+lLpkKnOgkOFAWAB2o+9?=
 =?us-ascii?Q?tVqck+t7xbuJIsHKyaRs3Af2wmcQrFeHHZL1p3QiCKCiA6YZDgN4DHNosXcb?=
 =?us-ascii?Q?9tuWHIvgK+2IQfFG3QCMlv2OZVyrGAC+hCZyKMcRh82O4tOlsxyLI0rLn9nW?=
 =?us-ascii?Q?qZQCItER+Nz1JKhpXj8FVKLoDBOb9hprP4D9JyawxEoOUYe03G7FBrXbJ3bj?=
 =?us-ascii?Q?xbqMgjGcv0RTVVwGSxjagFAzuDKCJZ/fH2OSbZSEDA/fd4qmXxWK+x3Svphv?=
 =?us-ascii?Q?EN0GsXq7FH8Ptom4ub6IHJg1kxwE4pDsMebSeVuC5SNEvff9tkQyJn6M08SZ?=
 =?us-ascii?Q?7JCX6NTZjoUHtN8gPLvfqr4qa8HhZLgjToFkZ8M0u1/haNrCLufF7uIANem2?=
 =?us-ascii?Q?R73mG0U+bKFeA9eRa8LFQJS2PyuvMeyPpl0tgUUHVDkVENL/g/aqkxz8tnCi?=
 =?us-ascii?Q?6pkvBqOzZxkimyTT9Sr8dm7Zxgg6aQyXhbze33r1AsWZkK1AY3JKhNdeKkLg?=
 =?us-ascii?Q?oDGd+FucqyAY3dQE4VW8lI6hfmk50Qd0CqOZ9cYxVthwBhIdzfti0kiJ5wPM?=
 =?us-ascii?Q?nrJEWkst+C64itX+BhbSyfEYf1RQeL1DzCaRbSaXKuEF/kSSfIWFl+Ef5Hlh?=
 =?us-ascii?Q?mclagVBzl/rhFKINw88Eg7WU/ApsfhVLjRUNGH2BHZrgjEodesJZ8E/hc9PW?=
 =?us-ascii?Q?F2sw/jCTSBzZx77ZvU6fXSvWm+dM2EeedKGKkPYDYxrGekzsVR49vW2E2AYf?=
 =?us-ascii?Q?UUe93hoTH+oeA0H0xWHwq59vlh+/KHDl6Pa6axjv7vvof39XAHBuBGhOyVGZ?=
 =?us-ascii?Q?8SXDGHFvVCuQx7GcjISPCpONNZXSqHLAF97FIHUdJpYxvCgv6GmX5lBoEMMC?=
 =?us-ascii?Q?MiqeHuJoLe1qcTRCp0TbjH4wa9X6+JFt/dBgGUah?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745bcb3a-2833-43f1-86c3-08db91eea5d8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 17:50:37.5274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pu7FQ1dVHes6exME9Tzmxj/GxPcZIKf1YL2w9eE2+HZe/bcxA16Iu0I4j0KNVgAd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320

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

