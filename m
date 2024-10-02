Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735761D0F62
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888145; cv=fail; b=d/87MHl1mXeHe8nqYrUasK1xix+384NdNd5oAr3o59YRNX2cL4Ji2xvmGJw6ahGJ0pPXq9PiAeOQUepjsy1x9w7NvwuAJYr0n1IOGbKCd365CZqO2fLZMli8mu3pTBwIofIJ5eV6GQ/ZhypJVXCiZaa5VJvRKiecKDPCagvJo3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888145; c=relaxed/simple;
	bh=WJLCbua8Y5pphxSbpgFLsU0t3x7UwcEqkY8Jo1Y0xz8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpDt37cz18i64GOCe73pFbyjT+jMjtHfQXTJZjgf7/l8DmT/5x+H88DkgCNIBGOYNGwj1/o3VQCXJ7vL3pwuPYcitt5sEBxdHNHOjFmIGgo0VEsac5LZjEhDwJWZM6TiHtkw2LDC3ed+ziqV22/WvkDdB2ELCGQo7pz8Jqt9PS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eHrEJa0j; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eHrEJa0j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZu+qhiUpsyjb1EBmEqYb81sQyBI+VdmdtEBPhxLvZ/BdRGX6etxD1iIu/LZns1R5Jxfib87vj3FxRA8+FIuaS+rUW+aTGuAiCySw4PddzTiKqifxN+dyHJLWLQXyMbTVsF1/AhpcYAcCiFj2v4AwrZEwK9v+kczYzJDfVh+mVZhGPcTbTUnWtQaz26MFHrHiW21Cvl20JV3BA44/WA3oC+xFRUGDHAAt6++Y2v3cYJzkVvGNj/zRwcoPXxWvv77FiqzE7ADeNp812Dj7q8ZUT70mEiYPVk/1AAhZMEI3cxJJ4gDAHIVFRMvJdYT96uOxypeGU61EpwnjmxEZ6qwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sr51q7Ofk4GQgQuNlzaQ0gqHuks8rMFWzkrPWGVIF9M=;
 b=WcOgmbgASeWNrwyZ1uytveTUpc0E2rGr4UalD4T6aoyOBxqvfQ3S9T0bBM8FkfEh+l2HUisfUQN6ZG5Hvs/x8peebd38xzNRvZnJ8TayDSmAFRJBsihjPUCfweM0Yp6oXm3CSkTvhqp2tO3pm6MuXzJuIXDI0ZzGZRVdMMwd+RIwX7MAD6kV2jGpa/i2uncZp8rcVCh3kHfocc6u5Y4LzALVFmOBZ7NSctT75314BbBrgwPsC8nYDueJlvJSAyhtEWgBCRgmi02/DadySErqMviQ4EzZ9gc+jdORrd73plP7sPRcoR5H8Dfpc3T3I348qBcE7WJYc5Z3yYoRdRMrTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sr51q7Ofk4GQgQuNlzaQ0gqHuks8rMFWzkrPWGVIF9M=;
 b=eHrEJa0jhyTW/gsV/RunCgWfnOrHPHzc0D5iKrwroXFgZY5MNbWiiy/y6KNTeNbKAm+7EvEIX3xeJ64vbok04s9lmkTj5YMbAtMzv2QsMpIj5f13HfOGEg+4dNKnNkH7CK8ONNiEUKW41mGeN1QLoZXR1073WoVJcjBeuaYf66mmbyc90a6Acwbk5mM4SNNUH6xtGn4VJnGETmLljr2NfLCLDqpMMpJ/KrlteRDn1cNckyr90Ws0QS60zOJno68dU/zQFaSW8gz8MevePLhsSZu0AkxndBhEahnILjyGr1OJXEGZoTe1dm6ulgV/u3jJxL0PNOsgSDsIKiH77KF+Ww==
Received: from BLAPR03CA0028.namprd03.prod.outlook.com (2603:10b6:208:32b::33)
 by MW4PR12MB6849.namprd12.prod.outlook.com (2603:10b6:303:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 16:55:39 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::2b) by BLAPR03CA0028.outlook.office365.com
 (2603:10b6:208:32b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Wed, 2 Oct 2024 16:55:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 16:55:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 2 Oct 2024
 09:55:16 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 2 Oct 2024
 09:55:16 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 2 Oct 2024 09:55:15 -0700
Date: Wed, 2 Oct 2024 09:55:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Pranjal Shrivastava <praan@google.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Mostafa
 Saleh" <smostafa@google.com>, <iommu@lists.linux.dev>, Daniel Mentz
	<danielmentz@google.com>
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <Zv168jJMZpxGLFmR@Asurada-Nvidia>
References: <20240928005143.2378938-1-praan@google.com>
 <20240928005143.2378938-2-praan@google.com>
 <Zvr4vmU7u2BY3MLM@Asurada-Nvidia>
 <20241002135728.GD1369530@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241002135728.GD1369530@ziepe.ca>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|MW4PR12MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8c8da5-b5ed-4938-6e1a-08dce3030a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MMwHL7G7p6LPkNKO9kZFcSLWXdSKFaWzkGdVzms7+P8WYI+57739PZp2emEP?=
 =?us-ascii?Q?alFSItKgjHNgr22IChI+xJ8hF4eLV4dQkXxvL06VI52OTcn60Ys8oblKaBOM?=
 =?us-ascii?Q?lFLQBp8VPCpB+7kQb1DyT29BQDY4M84pO/cj4/siuKFzBrItQUZ3RYsIW/mS?=
 =?us-ascii?Q?ELtwpozh85nRaQpG+aUjsBwI4/GJpSlJWz6zSR+xlCkFrC89qjUDvJYw5BLs?=
 =?us-ascii?Q?QOt8stjVZxw7ZRGh6w8WXGSkA+IpleMoJ3GI9uo7G+bLsIuoMIVRTgxP5Xcl?=
 =?us-ascii?Q?YdEPBzDKwt/Msw0dPacf+HzpsCw5TkEkdzDRGfVa6rZsUNTuLzIkxkiEPOzF?=
 =?us-ascii?Q?O3+RBpqfMHTnu2zJUisqyLDz1cPmk10Vez4XVPvRINgWD6w9Ylinu/Hc2T7E?=
 =?us-ascii?Q?triwgQQgHr388wlotUaiaCD5Fj4mWyF+de65I37QpAw875K/kBRp7VWIVPB7?=
 =?us-ascii?Q?dg+nRl1SxqlC2aKOGYbhWJseK71nGod+NjBAgfn7lk470d+fR5rpD5GnhZmM?=
 =?us-ascii?Q?z0hanvo8r+jmmyWF6VQBVowwm/dygMa7c2hgnQlhspJ5GVZUWSQHdOfA0o8X?=
 =?us-ascii?Q?9HTdBxigl6tpwCvPIIztu2rLRuTZOi2dYU17ndBhb6SaLU6DUq3WpPxWXfmt?=
 =?us-ascii?Q?G/aWJwh0MvXLz9Gv4Q8YWQnmV71sPy2UwuWVguOiQlgmY/dDy87P6XqmIusk?=
 =?us-ascii?Q?WHiXP+NcJ/1j/9Je/S5UN8xjvP/E5iVcWJ+PyA0kXUGwoZ6xkg5e6HmXZzqJ?=
 =?us-ascii?Q?A+alWR2ApLaf+4czV8skCdYRbukU/MQfaEXO4/BXzapt+eCTqaklfJNFdFnw?=
 =?us-ascii?Q?9rwHYqpxM6eqTdTqHvXbom/gQ+Z7P+iH2CRooR6h4pxgNCl1N2NyOxZpGnOD?=
 =?us-ascii?Q?GOT5XVH8V2oOthTXts4UWH1T/ryXlqep1gOmJmiWIcpubikOvW8mnQ4vdEW/?=
 =?us-ascii?Q?c5tEk8ecGA0oEYdn/NFYaGjU3/P1bJ1UGZminnC+yXFiS32M7PTGSZl23krK?=
 =?us-ascii?Q?+kG/ni1uT9a2AlFGOKx9xlSdX+IxzMiCzvPtK35OSwehzoa1eoKvlHduGBzU?=
 =?us-ascii?Q?geEp6uAA/U6mnSX16vhJOe0+nETUjS0RwYwrA1f+ogoKEgEl71wYFb2q6P0g?=
 =?us-ascii?Q?Nwna6QDIKgdpyRAnlJPqo7s5TQwP836xOmFEDap5ik5GkF7zg2GDSicOGh+K?=
 =?us-ascii?Q?J2VcnJo9HzgGAxXM6oMJiCFgZUm1bZRPHQJEGndA3F9eGUFHrYt1RPubcjID?=
 =?us-ascii?Q?oIJIwSZa02BdsYGuMspqptuAACcmv8NSckx8Ze1NaSJsiD/+lx8XF30vOf7A?=
 =?us-ascii?Q?s1XZspfkq/Ekl0Ry6+0s1gdgBfGaEX+H1/76cr7INcILIWXKFJ8yOgv4554o?=
 =?us-ascii?Q?djVoD2I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 16:55:37.3679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8c8da5-b5ed-4938-6e1a-08dce3030a39
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6849

On Wed, Oct 02, 2024 at 10:57:28AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 30, 2024 at 12:15:10PM -0700, Nicolin Chen wrote:
> > > +static void arm_smmu_get_evt_info(struct arm_smmu_device *smmu, u64 *evt,
> > > +                                 struct arm_smmu_event *event)
> > > +{
> > > +       mutex_lock(&smmu->streams_mutex);
> > > +       event->master = arm_smmu_find_master(smmu, event->sid);
> > > +       mutex_unlock(&smmu->streams_mutex);
> > > +
> > > +       if (event->master)
> > > +               event->master_name = dev_name(event->master->dev);
> > > +       else
> > > +               event->master_name = "(unassigned sid)";
> >
> > Likely safer for dev_name to be in the mutex too.
> 
> The result of arm_smmu_find_master() should not leave the lock, and

Yea, "master_name = dev_name()" must be locked. Yet..

> dev_name()'s result can't leave the lock either, at least not with out
> some refcounting on the struct device.

I found dev_name returns "const char *" so the string source is
likely in the data section? If so, could the result of a locked
"master_name = dev_name()" get away from the lock?

Thanks
Nicolin
