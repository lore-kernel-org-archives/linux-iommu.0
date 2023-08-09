Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0EF17754;
	Wed,  9 Aug 2023 13:51:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HV3IxPYK5SyQeA+nd5NDD5JfXtMYYyPg3VAwk/vHQ5GTO5VHHiUnGiNl5PNBXFX2d8pj6vK15jKxCLwqX3SxEc20wLX7Osb1NTczdoq95MsTg46To4B/Khs+hzFmVQXXLLAj4Gs3VE9wbJKCwYs4ALRl/1U76tC087R9FQkfVMu8BRxgOjhEzKK7r3s8oQzdXICY1ZKM8ptI88Nvjz39r2jXMYzqaXLwkGX3DWgw+Eikpau7gDvuHg+QyLLwUtvk1uELCE3Fwjvd2R7OeiqSqGahN++O43PLAH/BnnAXACbR9/RuC07DBxZG9eOjjPFTe3FBstkOfOUJtJL9FDIU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJXrsYZhN1Lb8IIYujCCrG/1+n9/7NC7B9lubXj2SR0=;
 b=JYdDDu6Bjr0TnJo72KjC/gu/tkGkC3Iy5Apx9zHRzIHbUX0TrT/FhbsRwGByu4PGCHU3w4MlzgBTiuil+nXjmQYoLNFVQOaFv1JzlxZmMRKYCKKBaAW/iHs3EYUr+bmnzlvM0y4IhIAM3B7vXx85jaNOldsq4EZzFZ1qj97+yso8IfxuHW8Mp7slCe/h9JLi9LeDSeksD+R2YmZ6EqzngR2UFwWXyE1ITehgBjB17arohMCpBA4IQrAfrafZELpCv+kc4Hvthw1/E7t0djH99FEHIvpkCl0Z/cljpXQxybSOXmKW+BlwAaIcmQyEyQ83zgh//iwXhdn1/SUWQVkukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJXrsYZhN1Lb8IIYujCCrG/1+n9/7NC7B9lubXj2SR0=;
 b=IGaItC1V81zp16ahHULOqQMb4HHgBlWScc2qTwpnyJ/ppjn3u8U4JP8yFWZaJxyd/iAPrm7sHw2byHNeZ5SMPrjKvCNq0DnoreItmfU68EkmF+6Ewv/6G8D8eSPRQUbWQ54IvE+Dbnnz2gXRPD+wKq1YwE/jBoOLqVbQ/PJq+VTzAdhSr0YqB+g17hbxAO/U70N6U+vvu7y20Pk8IrkvHCYmRvstiaGlHTYps5A02o4iVF3F/p+66SLtDkbhFH6ib9hS3QHr1PXkA7jX9ThxY5Sclk2WErLpo6aNkyq6xHT7hLtzIGnKMMDE2QxTLLHq0bCkXqICrC62eCldnvwcTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4050.namprd12.prod.outlook.com (2603:10b6:a03:207::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 13:51:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 13:51:13 +0000
Date: Wed, 9 Aug 2023 10:51:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 06/10] iommu/rockchip: Convert to
 generic_single_device_group()
Message-ID: <ZNOZ0M48+DAhDBWZ@nvidia.com>
References: <6-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
 <CGME20230809131935eucas1p247866f51cde0952d764c92f10a41c90c@eucas1p2.samsung.com>
 <e5e75222-13a9-ee01-0c25-8311b622fe0d@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5e75222-13a9-ee01-0c25-8311b622fe0d@samsung.com>
X-ClientProxiedBy: MN2PR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:208:239::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4050:EE_
X-MS-Office365-Filtering-Correlation-Id: 4882b764-eae0-4940-ec1d-08db98dfb20e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MIfByjyfNkdS+RUH3IC6aqHzno1q1FGnAs+BXTid8P6kU+CIfeyIQX09U0oHX7sictcWFsnbi5IberPNrG1Majfmjr0VnP5xWL1BBpclUSC0fMfJPNKQIIvwkfzONqYcaOkumYQ0UTxBhP8iVSMWs8a7NB+A1YtnBOFSxLBmLRnCqtW2fFy6uuwNijgkvMIl2uEof5MmBY+jCnkS/x4svtNMEi4gkAUhxbkE+UfDBPkXrKPH+dacn+vZgC0ShZslFxM0BLFkSni2z3y3HgwX6zvmaF4kOl7YHDBrKb4C83YpZ/a157ULouUQK8iMyQPLR7xN3npYqk6OPrThIuIvpRaUI6GQzxfA2YHV3cSPmbT5EwRm5jo7qQsc/XiH8sZ4aZiDkyNh3yEtFc6mY9ABalZrtKwaqkp04pLW8b18cOjzbRo3HLv2Mv8THVp0nzeuVdQ679g3vRMruPdP03RqjjAhCbD16B0GUBT667cLfGQdtwxCp+/38ya1uObwosDqFRr0SBJxzWzNgsXEYeEHoxTQUi3I4FcMzRQVpOz2Dxm+W7X70KiFmsDEnUkWbpUoJNy7kMW6rCtZhs3ZEDbYnS7i8Kl7vX1gU8DwnQzQttDqRDkdaUtb1srs69u9t+7A5V46AzAZD5GrkrjD1dWImg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(186006)(1800799006)(451199021)(83380400001)(478600001)(2616005)(6512007)(26005)(53546011)(6506007)(8936002)(41300700001)(66556008)(66476007)(66946007)(316002)(8676002)(4326008)(2906002)(6916009)(6486002)(36756003)(54906003)(38100700002)(86362001)(7416002)(5660300002)(41533002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MZrXelAcRtRbo04aIhMwdYH2ynMy72+sSDdoXaRX/bztnwrk/N8PzQH/8bQW?=
 =?us-ascii?Q?n2f7J15F0hMLGrKBtIKd10ajj7LVIkdEdZlm92sfwxBoADJ8HnA7oZV68uLC?=
 =?us-ascii?Q?6ruT5D2+X87UmCobVZnyxJQZjzu92v0ZLa9qPVFl5GsYwzfAMU1xsI00VFBF?=
 =?us-ascii?Q?rgYyiGbvBusPvXEtzNGSvg4NE2edUkS/rHkN9rl3TBVtUOz93W+g11wnyq1x?=
 =?us-ascii?Q?XGdqlgqJ0q5ySghA3KOD0Qr7bhT7m05argyILO0hAWHjdzad9+7LdzPfB5wd?=
 =?us-ascii?Q?zgqdmRAtSybsEClZ8XjqIYd75zFxDuPhiyUrTrRQuaXjd17ITmowULGD4Kki?=
 =?us-ascii?Q?DZEBzd7i0VkWahz0gpZxttjtmA/AtHBstZa1t2vBkhKPJl5mptuZ9kSahK+3?=
 =?us-ascii?Q?cpPB/lblohGw9FFaQUMduFFH3MS9YU1vdQO38EY8ZpufxhLlRhv5v4S8CDV+?=
 =?us-ascii?Q?XbqAoGjEIViayP5i31wnbqeHK+HqDTRSG6xco4P6ag9f/aGglydNZYSbNyw6?=
 =?us-ascii?Q?Je9st3XFobifruxrw+hCggIXKzyXgQRbJAGH3vGTb5Eald5CPU/UuuxuulZ2?=
 =?us-ascii?Q?y6ZiJELlkvdtcsU8X2hWFUN8UIl09P18VsWC8tKUeBOQ/E/acIUO+5YeatBD?=
 =?us-ascii?Q?V2k/AXwqr3mkDORisghwlg9U0flZTmdMSKSYGaowGWDqcwVPBNxzD/Itkyjd?=
 =?us-ascii?Q?fi5ZRKcBxw/BSemr6vANs9f0d710D1H6S615toZ5EbkfiEfsavdIOOhbFlCR?=
 =?us-ascii?Q?Gb57S5FlovPy36Y/S2IknVauWyiirHZDA+E4cL+pIesFdanQxQhyrZChWRJ1?=
 =?us-ascii?Q?ZMZMwgwKjSc8vBW98CJwzpm66mbwwzZr/7l1wfjJFFhz6dqcL+SOVPthZbmj?=
 =?us-ascii?Q?SUjjUJqBn9Pj6aH+sE0+QIS6IiQSSX9dfMa0FEmBnD1Dt6bQbvq3Le8QGkUp?=
 =?us-ascii?Q?kVq1/bFU1ooTLL0yaFZsTJIsqGoPM6M2SJwgqC56pEC5UyCjl4WqLUeGTBZI?=
 =?us-ascii?Q?L7mXxbnQAII9lhV2TnO8vSBx/lU6tc9fOLdk0GtfAlPTAKL3uuBGHd7Hyj0W?=
 =?us-ascii?Q?QPBNqrWcxog3VUl+5D8GFzz37weUxeKVFDnOlP4c2Yi7UYGBZlS4GXqZWQ5W?=
 =?us-ascii?Q?VRt7ZWjbSMl3f4I8hpYOxrY9JZMIYtcKJGLQA1R8YjMC+jJQUng6+XaKef+9?=
 =?us-ascii?Q?P8LWHVnUOHKL8Vh2V880aN4QgHw+OVPqGAYMQ6FiMmizi/QMQ1G7NuBlOzRx?=
 =?us-ascii?Q?LCL8O4pJCFISEUXzUosi6W87XVJgd+araqGVddVrmK38kGfAro5p0Q6kETir?=
 =?us-ascii?Q?z8nDU66D4ErMj8zBvJDbOZ4cu68mqnx0XeD4LLpYAhhb6TZqnxw1eNqY0feX?=
 =?us-ascii?Q?XDMXnmYJ2G3KKpnVV9jQucVvthhZ6ChtagGSznVKeiXtJJ2mOEPBELqZlzG8?=
 =?us-ascii?Q?XaUsNhO8RDiC4WA6yHgNkMQiLFoHB8UKnGHCS0XrMUdNS/Ma/J1r154euOvn?=
 =?us-ascii?Q?mytBDOOEdv1pcaK0ocbCeKZ287glpd+3PYPCxhqPLEBmnCZOmGcGIkDmj5tI?=
 =?us-ascii?Q?wV+Rm6ZN4PqFppLVBjZdfmt8NULgLB5MIuMTNaUQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4882b764-eae0-4940-ec1d-08db98dfb20e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 13:51:13.7427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SBKCW6dG3yynz8JVNEeEgKHj6IBjm8I1mES3v8OjO5x1Uu/UkeOrVjfuuhmM/ao
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4050

On Wed, Aug 09, 2023 at 03:19:34PM +0200, Marek Szyprowski wrote:
> Hi Jason,
> 
> On 31.07.2023 19:50, Jason Gunthorpe wrote:
> > Use the new helper.
> >
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >   drivers/iommu/rockchip-iommu.c | 22 ++--------------------
> >   1 file changed, 2 insertions(+), 20 deletions(-)
> 
> After applying your recent fixes from "[PATCH 0/3] Fix device_lock 
> deadlock on two probe() paths" thread I've decided to run more tests on 
> all boards I have. This way I found that this patch breaks booting of 
> Odroid-M1 board, which is ARM64 system based on Rockchip RK3568 
> (arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts). Here is the log:

Is this why?

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8842f4975ec4a8..8677d3ace47bbe 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -366,6 +366,7 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 		ret = PTR_ERR(iommu_dev);
 		goto err_module_put;
 	}
+	dev->iommu->iommu_dev = iommu_dev;
 
 	ret = iommu_device_link(iommu_dev, dev);
 	if (ret)
@@ -383,7 +384,6 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 	dev->iommu_group = group;
 	mutex_unlock(&dev_iommu_group_lock);
 
-	dev->iommu->iommu_dev = iommu_dev;
 	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
 	if (ops->is_attach_deferred)
 		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
@@ -397,6 +397,7 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 err_module_put:
 	module_put(ops->owner);
 err_free:
+	dev->iommu->iommu_dev = NULL;
 	dev_iommu_free(dev);
 	return ret;
 }

Thanks,
Jason
