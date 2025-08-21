Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013004.outbound.protection.outlook.com [40.107.44.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D36B285CB5
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769651; cv=fail; b=MKD77mqMWY8KyNlmj8XLo3CqWNP5WVFQVgGBheF+0UMIEeK4rmI6I5tsS4lqAf6+NOLMlI5J8dk44pPiNadnAjd88v2SUVW6gQHamGRoP/a7QaG6ukpi18m9FWG9H5kS3yV/19TGuryRwFKT0dug4QKLyVdcSCyhf/9WACThQew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769651; c=relaxed/simple;
	bh=LFT7+yeGEanemKdJmZIum7mdFNEhghb8GXHzc3oNraE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UjcZGEajV9LeMjZI50wEDwzExwWTVwTURUCE12Z8PwyoAnXqxUnFl+iy2+t38ZyFUC8aw+HQot7qpCJEp4hPB8j4IwpL54tqqb9I01uPLrIEUXOytENpHcGQBCJeN5jf3aLjnX0CrvleKQur1m+XoqsMKXDjW24NYGhtHD6Cp0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=R+oRKrWo; arc=fail smtp.client-ip=40.107.44.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="R+oRKrWo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1X3TPuNuRAx7VXiNff6HXOg/RdALo/chLaVxc74eYRJS0lsWsv09LOJrijBvSCehiWv4VuoLlERZ7romJpBLxGWRw1cvTHYr3RCh9+OLpsWYy7mNt1PsQWjNlOEx0y3WYXGD/egJ5q9G7bhzJZCuO4cgLoC/6PaZEhhiQWe//n8lKYts3UQHJwYCtBZuCeEqFqMdsDV1wn0bKXuj6QMeC1Krtw0pOYSlWhQuOc+MWbAUSRjL5wYmNsgr8FMKWHsvrRN7Ply0yjkIkcnprBeFto6w6APvOscUpZGEyx5G56a7dLWU/A23J9rIe6X8OMN6cCbcQ9gF6vNdREbe86xVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3qO4dN1p+/PrakekbMeW0kNjjNTzXx1dGZHwhtJcZE=;
 b=Y8HHm7KKoC1tBVHCsSg1cQVAK5Ec0/NLYI6LPwDES+9zo2jJd2ZnuDzmCxSArgWl8biVf5nAwy2GKLEcTJswR6sIv2dJfQrQiifebK1lAsNBuvkCIlQGCLXb7AN/LApQBqaglzQYHF+Zb1dKgoR7L7CvS5DGI7Eiwpn5l/d9VbI4ZIg4KNcQ71HHUGPZqullcsDsm9hz0JIBwABCav2CehS9iPn6GzO6J1hcpxL7IbUNdAIq8htCGvIVPpo/WJKJ4ctZbX7zhEOWmt60j1P4F6AVPs9SBGjf+8qiC1ujoqMNIzl/whlxi9rgjXgkmashmAxIMnJP5XvR2pIUyXloVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3qO4dN1p+/PrakekbMeW0kNjjNTzXx1dGZHwhtJcZE=;
 b=R+oRKrWohDY2nVMdICq1Yu93sNtwhzFqYCtCGznKgDkx7JwZHqREcDLyv3UkOJfzPCXGMKbIURYInuXUhw6afDTujQkEFOQ2Z94oeWB20eUg45Z8vTlpzlqOGFm27sS2u9uUAQj87ggtvu/b0J9pegQMkEc2lOiNxH06KBdhVjQgqWun6MscM5Q/N3JoPLPZzBPmGNeDZEhvI3aQW4rIRh5cpicpBeRAvf5Edi1d8Ncgfg2epuB4vxwXFfOxGVlSesN/FhhnUKrM0fF6byMDEG+ejB6RTX7Tcn3akOiPzdThnC7yCq35dqMN/bCBtTkWGj+5J3eu+eQkx4owoap6rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SEYPR06MB5695.apcprd06.prod.outlook.com (2603:1096:101:bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 09:47:26 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 09:47:25 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: will@kernel.org,
	joro@8bytes.org
Cc: robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] iommu/arm-smmu: Remove dev_err_probe() if error is -ENOMEM
Date: Thu, 21 Aug 2025 17:47:17 +0800
Message-Id: <20250821094717.573232-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0194.apcprd04.prod.outlook.com
 (2603:1096:4:14::32) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SEYPR06MB5695:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f77b2c-9d44-4e6c-ee71-08dde097bc1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6BzGFpRKnIIZpWAF5IF05Uwey5Vh/G0W4iSMbYQ7j2BQNF8gFMte0paxwOAd?=
 =?us-ascii?Q?ObiSVldVReWwqyuCcG3MklmlraONDb9qGIFhYh4+BoQwKgpKz/CgYR8m2gUq?=
 =?us-ascii?Q?AHvNrBpb/qcW7crYcyI3yWzesvB4X+adO09/88o9Qn8RYLmElCjVmQIB9Jm2?=
 =?us-ascii?Q?ynHNY3iEvj4mKld8x8tAq0JGnCxoclOoaP6ncbdwVPr18Thf51Y6Zr2wEZ/C?=
 =?us-ascii?Q?FuJVFaZ5dztNNimktCiqXyd5NEP+/ds7pnad+3WqFyh95waIU7XO8XR/FfUm?=
 =?us-ascii?Q?qS57MBPQDuWysyDRDYuPXQxZjyISxTgE6NaGOYd+2pgYokAZT2zexMxz8j3w?=
 =?us-ascii?Q?GbDVd256kxUBvY22411zisRA+Bi54sge7lftQxTVmYsSD51kllhrA2VUvi+y?=
 =?us-ascii?Q?Hl8RlIpo2uS9zOcjaQv2aRWmdJZGPihqE7wFmXWAK9MQeTWAPESh0ZhFRbfv?=
 =?us-ascii?Q?9qzCFA36komu6l0fyeSBK/W82ImCk9OxnD2sD9JLDtikUbfYqXbTSGrCKBXr?=
 =?us-ascii?Q?5pTsd+l3mL0lMPK1fvSNZQjEn8z+364/ySmeC/VXkgPCjtGo4XYCrT2riC8F?=
 =?us-ascii?Q?z5q9bKLs9E8vdmNwkoml+qzxxJdW3OwCCaDf3wqn40/U7wRO1bVUzxg9Q5OZ?=
 =?us-ascii?Q?LVichucgO6FUMSWjLvsDteP9wpMDG7q8o7Aes+gb2hTZlWOFiTD9/4ffBq5/?=
 =?us-ascii?Q?wkl7nyupT9Nxj9AmcncYlaqFoeDLMSXFZ/WIQ1mcy5YEQBQYGpTLgguosMLn?=
 =?us-ascii?Q?tMIr+2lX11Oz3ffu55o7SDcCiHBUlFcLti42PtqH2agVcQHf/POyYW/cxwhH?=
 =?us-ascii?Q?MFB+4Fal5nnTh+aAiWkcjvQsjceNpk7Q09x/V1deXefi66MiBy3IHZqb6wOK?=
 =?us-ascii?Q?rCrRuuPfw2Za0WsosBJz2tAF0PZ4HP0tunJaeU/9zrYas3twODxVCQYahFLm?=
 =?us-ascii?Q?iZoycmHdvuzkAefbYD6Pb/v1THimIgWdoA1rVTEklObUmnw92RJYRlrcLDWa?=
 =?us-ascii?Q?AHTnhxTLt90gMDC6mtfB07cj1AZ1CSLDeBL7fPP8+UyOfuKlyUaSzqNH4Ith?=
 =?us-ascii?Q?rxNw5vuPrOfUHnF0HBKkewGdWoCM82v86vXSOImerSa355D0NBc1Jp+NsEam?=
 =?us-ascii?Q?N8HYmLtSEBovJuirohP4bUhveDx/SU1l7+sDPt0LTPXcLCowNzUy2dt8zDzs?=
 =?us-ascii?Q?nkglYopvzNGtvB1h3Tbywld/r4ftb/ya7HGK1cwMn9P2iYJOcBmqXYz5KR2G?=
 =?us-ascii?Q?LBWWdLPTZFE7Cx5GuwfRXJokF4FD3qSgBeaXexDPsoqKQsBLAVc1kVSYNQ8Q?=
 =?us-ascii?Q?L5JOTYv1IOxWeUIBEd7ugXaalivMRE60OWov6GqcWlxFw+v6P+z9kvy7LSvR?=
 =?us-ascii?Q?PPi86/XfDUmH63PJy9Z06RO4QnMeEhE16r6cuAUb/gZRIKdaOVJeSIOz7KSq?=
 =?us-ascii?Q?bfJZAeRjw6CJgmUgUSxhT48R6JjFCyzddr1EwlIVA4jB5rMcw1hETw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cd/Bryp7s/lE9gprAMjHBDF2niXlkaS4JjA8uzvz1NocbeymPvtCFU8sIFmi?=
 =?us-ascii?Q?+bRsvJOwsTCkcVWSe01JRF3wTp/luaL+iJ4blhqflOmCjz6RYF/iQ/KNNh2v?=
 =?us-ascii?Q?r6bdxL4VvVFQ5gEYTkUP7Gwwb5Dj2T6kZIyGP7XQCZVQYp88RdHokBxvKIKF?=
 =?us-ascii?Q?o/qcGLDVYiMLjJiXdncFlImFCuMvMSZbNS5BLgaGBasv/R1NV1qLVDr3NNk4?=
 =?us-ascii?Q?hrtPWhxArd5crpWHP9MwSm1eSlY19r1uI//+Q5COLDbQPsvjxHJi/lEyODQM?=
 =?us-ascii?Q?p+GJ7fD09bEZhtx/CVZjf3al59xKC3L+pYwPXRakBLWqy3KamB1IQrtGpqbQ?=
 =?us-ascii?Q?NAVKZ4cDZYyecJWRppzY88AybPjfIB3JTBWsGSLS39dfvlTRYUleMu8SUCWL?=
 =?us-ascii?Q?Y019LoGCUnPi3iR+fIBU7M2+FmcZoG4qqmEtGZomA216qWvvBUf27+LhWSwh?=
 =?us-ascii?Q?hZc9h4XBy6XQ71Q/yeHm32BDVEtWDtnbJFzTIW+BNRUHJtjgW6QDGUxTinWg?=
 =?us-ascii?Q?Smvz2oGypDAPcTsM/BHkQ16DjBUJAlVc5wF8yiVPf5kDgsTChswQEuBCKnTL?=
 =?us-ascii?Q?cWo7Qy09RbvLede1JDOff8QMAGKdMT5L4Lw3bWcgxlBUIl6WuTB4pCYlVL+k?=
 =?us-ascii?Q?+5q1l5ywLGgoTH8wKxVI4GWFqgD39tuqONzco71YH2GoAeIgyQDj8KfFESpC?=
 =?us-ascii?Q?Gzo5qm9cXuDBhb6yijKBQQbguht5+KqccA1vSk1SGMABOEGaYB3blFg/DN2f?=
 =?us-ascii?Q?VkLHiXVJn8Rw/4waZDFTv/8GJ9sc0Qewgm/BEpJ0CpobRM5Dk7WGxKUsvdOa?=
 =?us-ascii?Q?ZXSVd1N1htUSh3N+eXzzOb+aykuM9HzkOGE09yfIkOcVTUYbTbLYF4/92lFh?=
 =?us-ascii?Q?vekNG/jcJ4R3ykEAhIRKL102PDkGpGrfytOKFDkkDfjnn3n1Qm69wqvFlyPK?=
 =?us-ascii?Q?Z5IghyXRbwUj7Zk7c/jSStsB6OCHzPp41hxqhyS445XUrz1l/RZu3yix4Fsq?=
 =?us-ascii?Q?0d9h3S7IQNZrqLy91yNoVbWRVh7DSsFy6l1wFjilbR/JmgHMz/GQYss0xSLy?=
 =?us-ascii?Q?Ga5/DKKPOn9+/xovUycLILe7u5vpJhly/pT4oqWJwN35vo1tL7GfP8E9NieG?=
 =?us-ascii?Q?grzMMXyiGIt2nJ3lJHXh8f4WMiXiqPqowaRA1rroFKAS97mSUyzbK9aW4HcP?=
 =?us-ascii?Q?uO4emtA374Zbe40SaY+0h9mMfFpW1KemmFwNP6hktwJOwtIHBwRN8voEEZwt?=
 =?us-ascii?Q?fIZzpt3ulao95n6Rd/yvgbWvb+kKWYZhDWQBcGV4y7uB0lhL6yzPpMAH2rMO?=
 =?us-ascii?Q?hoI18TUg86LotGSzLUIA6SJk3w1O+W298wo/XaY1OKtfUbKsGEzU+IAYp3Sg?=
 =?us-ascii?Q?4XLEaPhISQdTevE7ZNOtv2l/0GrIrSLOGDDw3JlQln9nFi22jbykY8HhzDUj?=
 =?us-ascii?Q?Kck6fqreP81WAia4f4exgWhnMs7EgVnSJQOn/o9tNnEKnVZl7UG+1OqsHOMw?=
 =?us-ascii?Q?QxgoEzIS78+CxlReVGrJsk0w0W79SBvNqB1KpsCYqEerntIJW8T7xMDvg8qx?=
 =?us-ascii?Q?wCd5mVqE/S5CYG5rPSdljkWytUN1gr8LJ+FsRTTO?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f77b2c-9d44-4e6c-ee71-08dde097bc1f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 09:47:25.9067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9mEdlq0SJz34ZFlyDjyoU6qZjsAF6ij0fpyPP7qkPNXBxuqGaMbDYilc+mTzXh/Y0uPYcD9vBk5okqrewkhbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5695

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 4ced4b5bee4d..9e441f3a75d5 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2164,8 +2164,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	smmu->irqs = devm_kcalloc(dev, smmu->num_context_irqs,
 				  sizeof(*smmu->irqs), GFP_KERNEL);
 	if (!smmu->irqs)
-		return dev_err_probe(dev, -ENOMEM, "failed to allocate %d irqs\n",
-				     smmu->num_context_irqs);
+		return -ENOMEM;
 
 	for (i = 0; i < smmu->num_context_irqs; i++) {
 		int irq = platform_get_irq(pdev, global_irqs + pmu_irqs + i);
-- 
2.34.1

