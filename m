Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C321D2E6;
	Tue, 22 Aug 2023 16:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lc221BsAWrElIWOL/K96cJF+db/94R0bFoHBFmVSY61liav2J5XpqMYY8548budEGD2oQv76F1vEb7ghAE+Vb21T/wRLPn75jfh5W8ocyt3Pkxb9jQChFlZkiA0p2zX9mOOSbjS424Z5QNNfwMAiqDuY1Z2BQhS5zkL1Ot1D72P1PTeygNwbIYJJxr3Vq8JVxbgOkTWlviAPurzt/nnMFmUS/xJKdpXSDGvcGUOd7dmME1ecE9V2CYcH2XbBRGqyuBh2HTW/HfKoXATD2iRYecJoRgtWlOejQhQDmIb6XJMR7BHTmaxwnxwlEZvd6l3w/ET9tV+OnI21mSx/I4pKjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrLde/OIC0cgtPmLWXIJF5U19mbUA+17Secmw/4gCag=;
 b=U6X8z79dF1yEo/+5COidMMxZfEgWR6yZvIknQTGanr65JaWhB/iMd+uwRtgP4HSL4ie/cxksPmiJIzk6FOVq7r232t/k1yP2YnMFdKbm43ZnNHx5xtlkOTTqvd8byZhIcKVm4D209/I4WtPMzOBAHmmby7DQnFajm12s9PXOw8g2iXh2xBCk9iBVqDSmPyr+Iyls2XwGHtpUfI0Jix/GHQWE+j/yLHjVkjQWU4VreidHoNkbTPx9qgzlKVaxPGPXDmdwlNADXzGAYCoWyFmyDatKUSrUWcN1Gwm92vBPOnYsNL1nlcIbn5HBy3+pKLEMvHaj2+qOz4TZbS5zKfEpag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrLde/OIC0cgtPmLWXIJF5U19mbUA+17Secmw/4gCag=;
 b=rK2Plpca5CFIL2IWkiClO5JRYE+hPAznABwbZHPV8dyHvYoHxzaVHQv+TWPGCHZt5T5eCIaGWrX8e4TEGa8Ag+rwpqVfUG6Nha7hZpSmfhBobDy6Rwno3ukv+5565KcBPs29bejV12l6IbsYU44wtFdzfGyAXRvu0nXhpdn/5dpGrruo7dnY2lVHCrOaKLX0v7cuF/v4Ce6OjgDHisOw32s9WjdSGS08ZGf5jhqboAN5rrZiNe+3Y2SAAEnwa+zwlQP+hSSGR4NBQZFz4r8QOI4IDooh0u2H7w/O+PbovlQOLVQj1omCASyEXD6tsUafx8e92pRgTIPn1Q9FILmH8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 16:16:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 16:16:04 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
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
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 3/7] iommu/sun50i: Convert to generic_single_device_group()
Date: Tue, 22 Aug 2023 13:15:58 -0300
Message-ID: <3-v1-c869a95191f2+5e8-iommu_single_grp_jgg@nvidia.com>
In-Reply-To: <0-v1-c869a95191f2+5e8-iommu_single_grp_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0008.namprd05.prod.outlook.com (2603:10b6:610::21)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b037d4-9d1d-4e61-0598-08dba32b14f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hSrItAsfCkYynEWChNBqw45UZjYHeelZCNcmr1pKCW9iIS25ekl/lV/EbBQbIz/9T3xs3/djO3cEqBbGrTL8zRho1KGMYTCPATXB7i5cwTQsHWKcoDk/GXPq3gO06XivdixygBQ7m4YR2MqeudTvU9vyLKyZ3Kr2BHAYSABYQ+94KHivsHG+0NiYgxJ5v4rvHOasNebwGvgfbEamuqoO8dZKcXKp/qOD1oMdkiqV5zJicmWRXoM/56NhB5lEH/TgFd9dUt5/tmGwGg9YfVncI4xgab1PQrgk5e6936nDaPjTsilbyyBuPUrZtsVBW1+KcKAHyfeJay3Ppt5ZtvM6WYIajZA6TpKZxEWf3w6bcGDO+Md9HYmRllk9nfYGSx34/rgbmFWZ48NndPDw89417HfQYqCXo+6j2LZ0IVYWGKkudLPGB+PSW2cWt1D/mJWw91WwpIKUfr7YdfzvbW55DsbL57Hv0r//l05t2ZHBZeqY3OwRg7rtQ2HDBwPJTxWB1rKJIuB553sdL8bvuMA71H9J8l57GEZEitYTOFMqAyvI3pq3vPCnpWAeh3Cs0p2PS8OqGDhFwVU8eJblpGBDgGlb7XOYLO6nDAPhZBB9wD1ZwL1q84VFEQATfEZ8IVansI0XIUnFK/A6MC37/6O4sw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(451199024)(1800799009)(186009)(2906002)(7416002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(66946007)(6512007)(54906003)(66556008)(66476007)(110136005)(498600001)(921005)(6666004)(36756003)(4216001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B7nlTSZfsSAXKxFu+4p0t4iweSklqeCuMHa/z8SpB5cw3Kx6Fq7N+ryeNqh1?=
 =?us-ascii?Q?cl8ZxaC+nsQFyFg4I3U17/f5n1VWkqZfWMgtzy0oYd52p8dxtHuADUf1NaaO?=
 =?us-ascii?Q?EW+yT4jzyXzUut0QbAK96oAMxRn7RKGJqhN8c2p4f/Ud4pVaRUnREsteApQF?=
 =?us-ascii?Q?zoqWFBFtOVUKUJuACgRRSq/W++dkFaYGoN/Bl8fzO9AJbGUmx5QUH08XhIGf?=
 =?us-ascii?Q?h59CEFHqgXrN3gCffFsEd6nZjYkWUGarpHkHeSV1x/AcUUNHDXbyOU6niy3F?=
 =?us-ascii?Q?WBU2P7BlfYAjiSmIlpnqxI4/Wlbnr6GlQStXiLrE7Ih6gy5IQ21XIPB1MdIR?=
 =?us-ascii?Q?Mp7NJsX3sjX2iGfMOlr75+xkIx6a7zromtMy4uirzyPgMZGxTM0cxya9YnAW?=
 =?us-ascii?Q?kq1/+Q4eEbGGZ09LJBZSL1rMfDOnU6JZJv7U+Fz6jJL9SuhtfutV9zU0BLg1?=
 =?us-ascii?Q?RqTNsTFmzNVVXqpxe713VA4PjXyZ79cFWHQF4WU5lVNzEfhoZPQWPixVpyTe?=
 =?us-ascii?Q?oKL7o4ZnVJpU6vmGs4r78Zn/egU5XnlVJ+3our9wS38tyuc89wDgjIu2nTWl?=
 =?us-ascii?Q?jxuTLFHjEF/cJZrzfreMyLpC1m97qzIhMiemJ3uvEC75tsDsUxLjQXejC/gN?=
 =?us-ascii?Q?nalaFQeS9OlIgOIROIsy5CXK7hB922/h77Owua3TTrt2F1dLQIwjbtPnP3x0?=
 =?us-ascii?Q?qjBj81BwpJEmWTxGDh6Q9G8wYPco37g5NO/QMYgvoiqyB0eL/H3lI1iXk6Il?=
 =?us-ascii?Q?NxuyiySOLUBNDho/KOI9VGHTZ5hCT6s5x64Xo6qfHmS0K5P3jyuv45L9ehfE?=
 =?us-ascii?Q?Bcmy8oOBqIng8/G5jmX2zojLoUhFjyTsEQfInC60rReRzheMkcBpYFiUkFkA?=
 =?us-ascii?Q?jaUR33CF2GQmopVfG07tIQdDkbb8VhGVJomx41aifAByXixxu/3tZ7VBbNlg?=
 =?us-ascii?Q?4LvwcIXfAml+dSeDcxoe//0TQVKVj3PGCO5pP1Q1giQv+xLWKFaCeH9M3SQB?=
 =?us-ascii?Q?xlFSlqzzPE8/CeezZ70likAwEo9g1P8AcVLHHYcIdZSwgxIZz5U+oXSMIJ5n?=
 =?us-ascii?Q?pOwiZrhuVcBKExDWKwD4cSMWgz7lSB4nJUXqhtjaMikzQor/mwCzrHrq3Wpy?=
 =?us-ascii?Q?QzcrcklFMs/GZ+iR7tWKR23fujXqqdrSAj+3B4gYV35+MXNDTssAts47kg/S?=
 =?us-ascii?Q?p8fAhWxZ9pp3D9Qnx27DvtJJ4eKBXZejtMF3iA4GgxyJ772DqWvTenjuPAWE?=
 =?us-ascii?Q?93rRq4hUtJ1hLTusRW9XOqow9/inz1cDcHjVvVaQwKzIXHR+PftmABQA3K9D?=
 =?us-ascii?Q?Ulg2uopTytgJxCAmGJ6yYLkjFKAJnaRN1b8dK71c316K2Q3lNSKtapB4/Fw4?=
 =?us-ascii?Q?8gmdfEHdOuXaGCyR2cY+dpikHIiODMLXuxKhm/in8pw4H9v0TKGtwJaDMncW?=
 =?us-ascii?Q?Nx817IItyfY9n87XmtWpclh7zHRLnOavnObl0PEf0ywYL5rt8nc7hY4pwPAt?=
 =?us-ascii?Q?qbx8e7c85BH/IKxcIZAiHD1ZsE/b+eDRFxs43IYxHj/+8CQG9oejZjpW7h5A?=
 =?us-ascii?Q?OMRr0b7Phwf4XHKI63ELM4DfHAlNn+qYz/AK/w+l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b037d4-9d1d-4e61-0598-08dba32b14f1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 16:16:03.5471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5N6oW9i7rwmSgMvCQerg/cjcNPZ8WwAp2lfpYcu0BAWP+iGcn/bbokAUslmGYMy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831

Use the new helper.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/sun50i-iommu.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 74c5cb93e90027..b8df655185ab2a 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -107,7 +107,6 @@ struct sun50i_iommu {
 	struct clk *clk;
 
 	struct iommu_domain *domain;
-	struct iommu_group *group;
 	struct kmem_cache *pt_pool;
 };
 
@@ -808,13 +807,6 @@ static struct iommu_device *sun50i_iommu_probe_device(struct device *dev)
 	return &iommu->iommu;
 }
 
-static struct iommu_group *sun50i_iommu_device_group(struct device *dev)
-{
-	struct sun50i_iommu *iommu = sun50i_iommu_from_dev(dev);
-
-	return iommu_group_ref_get(iommu->group);
-}
-
 static int sun50i_iommu_of_xlate(struct device *dev,
 				 struct of_phandle_args *args)
 {
@@ -828,7 +820,7 @@ static int sun50i_iommu_of_xlate(struct device *dev,
 
 static const struct iommu_ops sun50i_iommu_ops = {
 	.pgsize_bitmap	= SZ_4K,
-	.device_group	= sun50i_iommu_device_group,
+	.device_group	= generic_single_device_group,
 	.domain_alloc	= sun50i_iommu_domain_alloc,
 	.of_xlate	= sun50i_iommu_of_xlate,
 	.probe_device	= sun50i_iommu_probe_device,
@@ -995,42 +987,36 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
 	if (!iommu->pt_pool)
 		return -ENOMEM;
 
-	iommu->group = iommu_group_alloc();
-	if (IS_ERR(iommu->group)) {
-		ret = PTR_ERR(iommu->group);
-		goto err_free_cache;
-	}
-
 	iommu->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(iommu->base)) {
 		ret = PTR_ERR(iommu->base);
-		goto err_free_group;
+		goto err_free_cache;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
-		goto err_free_group;
+		goto err_free_cache;
 	}
 
 	iommu->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(iommu->clk)) {
 		dev_err(&pdev->dev, "Couldn't get our clock.\n");
 		ret = PTR_ERR(iommu->clk);
-		goto err_free_group;
+		goto err_free_cache;
 	}
 
 	iommu->reset = devm_reset_control_get(&pdev->dev, NULL);
 	if (IS_ERR(iommu->reset)) {
 		dev_err(&pdev->dev, "Couldn't get our reset line.\n");
 		ret = PTR_ERR(iommu->reset);
-		goto err_free_group;
+		goto err_free_cache;
 	}
 
 	ret = iommu_device_sysfs_add(&iommu->iommu, &pdev->dev,
 				     NULL, dev_name(&pdev->dev));
 	if (ret)
-		goto err_free_group;
+		goto err_free_cache;
 
 	ret = iommu_device_register(&iommu->iommu, &sun50i_iommu_ops, &pdev->dev);
 	if (ret)
@@ -1049,9 +1035,6 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
 
-err_free_group:
-	iommu_group_put(iommu->group);
-
 err_free_cache:
 	kmem_cache_destroy(iommu->pt_pool);
 
-- 
2.41.0

