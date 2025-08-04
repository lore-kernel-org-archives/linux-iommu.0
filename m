Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D363E25CC6C
	for <iommu@lists.linux.dev>; Mon,  4 Aug 2025 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754329509; cv=fail; b=i804AdNAYvDrw5K7p+feCGX0fz1ZsSx1wmuI/+W7P5oePc7Jgzw9ZLAW8EhNAyW/dryG7OJhKZE2HvbiI0SZ//YQpzPlL32bUVaVap9b9b2GIdnwC21Lzh1u9c9fB/ZdzCL+x2tsDQMvDa5L0wouJ6suOx6q7smPRA8Y6fXleZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754329509; c=relaxed/simple;
	bh=iDvYV5wvAbvivYZQGJ1aReepRV7Q3tKFBK1BimxzAcY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPT9v7VjhQ5/HFD5uQ6j1IAlvXyVCDDz1xnslaXEcCcu2Ta5btQrA3oAz8eMD9KJbn+gwQP/dwvN8SHnXxUO4lieuvfjYgY28r49Iv/DWGH+hFUrPVJi5QAwjJyCnxCIyqy3nrjjL64EanG8P20OmEcSPLZkrKqus8/wIQmL9Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AnMg2/Dc; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AnMg2/Dc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kX6s1Fo/mCxapXyLHSLVJ5Ysjh61zVOGte8Pqi2kdWnDuivtgcbuRo/BLf8FM5Zt84AbLmhfNzmmJzzaZccgrQH7YFkv6agwUyzOGeMrA2n9iQw5zp0KD5n7Rh3EjtgG4JM6oDmmN0cODFsRgzLRLp1PIxQFA4CXNrC0KuXE7NxdRw2AC+nVT6S6P9aLJqE1F0Dl/UJoiIUAZdG74oJrA30wPRpQ/qBmQZ+8rDc9pNn7SPhcuQYUgvlIebUwUjQ46UK+N6OWw8KG6qsx5mYTVgAocLQJUrX+ag5FrQMvrf7PJhMcYsT7md6Oh+76MFBJzNHUXXFgTGQ7jZDD8eraRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEkeMQw2aH7L9sLpK9nRhwnsG4MQdS/kPLrTlFgDSNo=;
 b=YGGbkijGrwVnjss+QZeWix2Lk+luaKWf0dCON6dDxQlKPSTJLLMPdNmO4M5FqpzFxYxnnQFojg5Gm+SnOFBT26eIkNrpTnScLXJDCQDizPKsxLkaDbzNG3b7SOHg0vYo17B29mD6egBidf/Jtccu2udB4aN0MJHmWJsWYge4Y3Rj3CSYCh+5InBHYrPNLtSP33LW16D/yu1548XkbCGs9PcI2Q5Fl3nITulAehXKsoPau3ykUhZDmkgwCjcUC4f/d3nxVOFZOko0NhpWJJu3hpwYWZfWFvAGOpnE6EUZ/86dKw6DQwMJzQaxjxlLqHfIisTcqBQ0meZDYlStK12Ozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEkeMQw2aH7L9sLpK9nRhwnsG4MQdS/kPLrTlFgDSNo=;
 b=AnMg2/DcXI4UnWtnWddPeM8bYjSLw5VbpA7kG4wK9qD+ugOue/EJnb6u1QuYvm8XFXNUpFMEPeTJB5AniWekf8mRAlaWvqGRM7FpJq6Mjh4nD17TG0LOKadCNEgYuGawMoj7sdi/jmS92rTTA9Xm6AP/PrZUIL37Ldp+5WPH2hkRZ9WQzh73KPNq8ZHF/HjvcDVq2n2p0SrQxu4LmUKIuZ99I7v1Eik6jhP+2pI3LmNJIHWOZA3wiDKRohknFVGr7dK9bxrH+jR8S88lxl7BvTlHM5k0UyyzRYgnD/SFQYkT9HSur6f5q1hVhElnJ6uk6xJxqFEj5Z1cxUa2Q3RvpQ==
Received: from CH0PR04CA0079.namprd04.prod.outlook.com (2603:10b6:610:74::24)
 by SJ2PR12MB9240.namprd12.prod.outlook.com (2603:10b6:a03:563::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 17:44:59 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::db) by CH0PR04CA0079.outlook.office365.com
 (2603:10b6:610:74::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 4 Aug 2025 17:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 17:44:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 4 Aug
 2025 10:44:32 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 4 Aug
 2025 10:44:30 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 4 Aug 2025 10:44:30 -0700
Date: Mon, 4 Aug 2025 10:44:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Richard Gemego <richardgemego@gmail.com>, Pranjal Shrivastava
	<praan@google.com>
CC: <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>, <jgg@ziepe.ca>,
	<iommu@lists.linux.dev>, Quan Zhou <zhouquan@iscas.ac.cn>
Subject: Re: [PATCH] iommufd: fix returns ENOENT in
 iommufd_viommu_get_vdev_id()
Message-ID: <aJDxfiP8n3YLye1Z@Asurada-Nvidia>
References: <20250804100859.3462571-1-richardgemego@gmail.com>
 <aJCYtnyBjvTxULbE@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aJCYtnyBjvTxULbE@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|SJ2PR12MB9240:EE_
X-MS-Office365-Filtering-Correlation-Id: 027ab62c-b9aa-41d3-d815-08ddd37ea1ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mus1C9qM9gvCLsq0Z9gv3gPezXkI3+8fnuK+EgNlRzhtxMOddbgVAK197oPA?=
 =?us-ascii?Q?KqNI067/Ldz+rGrB4JILF7uPNVk6uqpxg9CdB/B7sBl7cCxD4wNk0eug/1H4?=
 =?us-ascii?Q?tv5b+9Jh0BuW+DyB9OsRw1swRBYZPVylMTswuwxa5+TQS6ZiEzbbO/0WXsNF?=
 =?us-ascii?Q?5DVMyOBKiMyGM8k8kcMv8K5s079ycYLs5cnrhCTMxNMoP92Z34oEtIKr2Nrh?=
 =?us-ascii?Q?X10vT39da4FbvBVXHdR+DSg4NGHyxGDGS0LzYzuYIARMikmJXYE9sdOVNByi?=
 =?us-ascii?Q?g4L+pMA/X/QLnqVBLiO1MQv4HyXUSOmqfgeftO8MtvWg2ZS302F6lCmnr78K?=
 =?us-ascii?Q?UK1gLEA98H7IVaDXEKGBI+O+cOKj6VMNVohYEzTR8gRu9OaE0koBCGpZGKA+?=
 =?us-ascii?Q?87VUzpb4ibm9ndWIKLhgMtMaIOtfh140XrsimZdcRbPX6DP62R27+r2vftWU?=
 =?us-ascii?Q?X/Oq98OxLK1Mywg9FU7JtMh0hxreqnnMbMqm7C3oFkb0TYuEfyOkA+4KemA9?=
 =?us-ascii?Q?sKOnxTeZBdNA2zHPyfK9HBXvHyJJHBpeeJh0c+PvE/9yRphBXcu3cx/k3iT2?=
 =?us-ascii?Q?o1p41V0d4UWepRnNCL3/OzLn/tB2vj28WS2+s99y+pNpZbggFraoZA2Tn8aQ?=
 =?us-ascii?Q?xn6z6m/7DGEYoRE8HTNpojqKsJi6Py1ZP7Gck47UXH5R9lH/KaBL8elR+tZm?=
 =?us-ascii?Q?PDufytUAw2MZE4821sJa5IKgrGj3Lp/DLWqnFDR9d+Io2wDb/mvsKxGXTgMy?=
 =?us-ascii?Q?DRoPeAijnjieiyAGDcPzxhkTg9O5+i7hKSHChwnrKfqT8jY1Kb/Awct09fbg?=
 =?us-ascii?Q?n7rlzSQCszlVZgBw4u08F9PfJioCTrQgVIEq3YFbPvV0msPU6Pc4nq7ujtxv?=
 =?us-ascii?Q?HaeFjoQmalWjw4NGMNsnhpY6bX5MM6tveGfGBZ4Sj/44MAm8SoSdLMnE4jvN?=
 =?us-ascii?Q?E0lMZautH2KAv4ojhdEMxMn7jWyH0N+FfdtmyPuVPyrUM6AV32ismr3MHjOJ?=
 =?us-ascii?Q?yyEfBrrQIST/M/gOY3wsDT/KJhEBukN/TxmCNNl21+lgUzYUzIGIqqwrxZmG?=
 =?us-ascii?Q?Zkw7LVl45PkOa1SUShuzo5rZXQJ3DF6QlVw38AwT2SMDV5GEYDxoYByVNS/j?=
 =?us-ascii?Q?XeamCXyhTNrUoJkko7HQrBy32EwF2OtSrDQgBqTY0OMgLnIt47PTXs+IOosA?=
 =?us-ascii?Q?/BreQRZ/UwWI2bryp75RCZaTmNwSNgmnsDqEDlEU2D5FOOu7XmVgdM2WzNo/?=
 =?us-ascii?Q?JZosW06pCL08GTSUtytv2/kyns6xhMnnOjXUbiY2UsOhnUMr0mcUGH1qXLln?=
 =?us-ascii?Q?EhrwMr2XCb5WqDRWkDmWvf8DdDBVL3oAkSgPDnvuKmCDPsh/l2iKH00v5a4Z?=
 =?us-ascii?Q?PQ41/Pvmg1ZckT7Mn/dHJ819zJuijyHWDkl2vt7ffqs0iVkiEyGqm+X412Zo?=
 =?us-ascii?Q?GjElwCgaWy+XY6YWmG/gv2QWU5dxyO9CQ+1eb01ux2ojHQquj78WIGtumvIK?=
 =?us-ascii?Q?rc4QDoYJDHywt0F/X+7WID8+o+cw7i/0vxxR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 17:44:59.1443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 027ab62c-b9aa-41d3-d815-08ddd37ea1ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9240

On Mon, Aug 04, 2025 at 11:25:42AM +0000, Pranjal Shrivastava wrote:
> On Mon, Aug 04, 2025 at 06:08:59PM +0800, Richard Gemego wrote:
> > In iommufd_viommu_get_vdev_id(), if viommu does not have any vdevs, fix
> > this func to return 0 instead of ENOENT.

I think this is missing some justification explaining why this is
a fix.

> > Fixes: ea94b211c548 ("iommufd/viommu: Add iommufd_viommu_get_vdev_id helper")
> > Signed-off-by: Richard Gemego <richardgemego@gmail.com>
> > Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> > ---
> >  drivers/iommu/iommufd/driver.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
> > index 922cd1fe7ec2..ad635af8555b 100644
> > --- a/drivers/iommu/iommufd/driver.c
> > +++ b/drivers/iommu/iommufd/driver.c
> > @@ -68,6 +68,7 @@ int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
> >  			break;
> >  		}
> >  	}
> > +	if (!index) 
> > +		rc = 0;
> >  	xa_unlock(&viommu->vdevs);
> >  	return rc;
> >  }
> 
> I'm afraid, I don't understand the motivation behind this? IIUC, if a 
> dev is not associated to the vIOMMU -ENOENT is returned. This patch
> seems to be returning 0 when the xarray is empty. The issue is that
> returning 0, would indicate the caller that `*vdev_id` holds a valid 
> value which doesn't seem to be the case here?

The function is designed to return -ENOENT for an empty xarray:

/* Return -ENOENT if device is not associated to the vIOMMU */

And 0 would be a valid vdev ID in the xarray.

Nicolin
