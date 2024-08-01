Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BDC1A4879
	for <iommu@lists.linux.dev>; Thu,  1 Aug 2024 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722533976; cv=fail; b=MveV0j5oiWt/PIesejSQYZ9VEho2HNEwcLgMIc68wOA9xL1/so2p3/cPz5gCJgANU+M54I3ltZP7X/dCzfplmhVZXJmHPvGuQZQV6/IjX5x2tZbBesgWLyVqDjCbKvajYxGyZzZI1y+2Hvon+k5JDQqBTNfPYTISYtxQ8AAULUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722533976; c=relaxed/simple;
	bh=r5QldzcQTDuSJqbbQD/IfSq7d19bW9S2u4CwyJ8WbOQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YanSe4notuubjP4ktmohsTj3h60Wh0f1lLUSFsCX/LW7WJxCCjcr5rmjgjlzaK1MGcfJgTrAkAxdYpfyDQeid58G5ZN42jd2FfOOJG4nGHYL5/gIus4APOtvyzV9k9Y+Tbjs9O0flMrynFeYk07OzzzzQEIJy+RPeopEZHOC37w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C4c+QS51; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C4c+QS51"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lN6dRzHKZ2WZY08z3VNYbTPovzbUyxp0bxfcu3KvN1ykqyMKO6DIhu3zDNv3BAi5u1dukCUmIeILoG97BYGBPl3BNoHPWHp9k3id5b12oYrHZ1sfinOne9i2odork0Qi4vYXEvVLKkgYZ2iIc7fUGOryxsZ1GQojQcttDaIIEOo4578hr+wiX4nriPN6nI5AvBjgN9LrHR1DqeqvZT+sTu4dnN7oZbBmCaWEFYyLkTDuYQi3mQjNWSKYK/50+HnzL9fHvroNM3IDWFMFA53P6+bbvyhJkq4cmMStVlA0JUDmB/BNjF/pVp9lGQZQPZIDf7uTnxtsD+YBmMMstwB6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vowPd/TbdfsMi3QnWdyVj+5UqfXqs2trqvbSbUr4Vw=;
 b=btXt5hWbqmK3fKEDHppisBbKmSxd64AKUShBN0yTGS/fuZVlNC6VCBO00IjOMJ/LMS402fx2CdvonrXUIeo+VXaJVcYz1VdF96Q6wxRcU8+DBctmjASJ1UF/iMdsDzafy10b+Frv4pdhYRknjKnE6G1pjq3uPtuVOZhRI5RsoJEOshB3SOf/fAFSZN8on19OH9vPxnJxSK3rVYvAfPnW98ZtxZ+Zud0A9r00Fvf857QKQICVBR/3ZJZb9HmkhG5fDJ/ZlRBfscDCqrX/VKMOQa88JbgSvoOhrlJyadeSwM4G6kMTg6PshRr+fUJ8IASOfuogiwb6vjKLIAwxHdBx3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vowPd/TbdfsMi3QnWdyVj+5UqfXqs2trqvbSbUr4Vw=;
 b=C4c+QS51ElQcKA9CjYnKgQaGBn+Ok1qq68FN4+03OUuzCoNuKhkmsA+XQyv4TE7mfAz0kFKHV5ksiLnw+rIIDjms0DbqPip9U70nHl4tapqQE6q7poYD/LwCzxlwuVcLq+VuqDiULuLeFDyW1F0c6drds+DxGho7TVFU3nkZDej+QLFzK5YUmjoSLu7J+E234SZ4xf6UJT3mORaTFSkubEkCNjcLiC5A/I9SugCUEmRDTf0cs5N+gUh7jGfM9TInXV5V59ff31BMjQbcuwdGW6o8s0fupr+SV8cejs8G8/JGD9VpiiofSl6PAe6lBdmnttQ2nDIC3AnuKTfD9oZg1Q==
Received: from MN2PR16CA0052.namprd16.prod.outlook.com (2603:10b6:208:234::21)
 by SJ1PR12MB6361.namprd12.prod.outlook.com (2603:10b6:a03:455::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Thu, 1 Aug
 2024 17:39:31 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::e0) by MN2PR16CA0052.outlook.office365.com
 (2603:10b6:208:234::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Thu, 1 Aug 2024 17:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 17:39:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 10:39:15 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 1 Aug 2024 10:39:14 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 1 Aug 2024 10:39:14 -0700
Date: Thu, 1 Aug 2024 10:39:12 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommufd: Enforce IOMMU_RESV_SW_MSI upon hwpt_paging
 allocation
Message-ID: <ZqvIQFsgUGjqqjmF@Asurada-Nvidia>
References: <20240728235106.2435208-1-nicolinc@nvidia.com>
 <20240729182446.GH3371438@nvidia.com>
 <Zqf2HFUf/75hRcUU@Asurada-Nvidia>
 <BN9PR11MB5276B125671FEC70EDAFF50C8CB12@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZqqBHKEJCm4XXFq5@Asurada-Nvidia>
 <20240801132848.GE2809814@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240801132848.GE2809814@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|SJ1PR12MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: de6f4b34-ec39-440c-71a7-08dcb250e656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ryx/rqkqj3l8tAlZpWdEk3/9FheWWm/mDBKrZ52YylogtpEHwINHokPUsHTh?=
 =?us-ascii?Q?t/PdVlAeQhor26ftNpgRldl0A2rXy1EuqAFjL1YG7QuLmsxtFYr5/cpAiNSw?=
 =?us-ascii?Q?S9SgKUQljdcXsKLFha8rPj9hTW9Xn93NTGJWwqT1xUosX1TZDFwLvuk0/kSH?=
 =?us-ascii?Q?8B15mYuiWC/a+lbeQBTgcdwbKYE2TC2D4On+9AazgaPUqavWwvv9Hi3UZ7jv?=
 =?us-ascii?Q?eNEBP+4XDMw193ZSTx8KcmELzVxigLPNitkJqwmZbIhWLMXb9WCsoLZCjzaT?=
 =?us-ascii?Q?VsGPBpt9r5DcG6PztUeld5v6EzxdppgeQHDrda5zhuphxm2JrAR1421kalkE?=
 =?us-ascii?Q?Dk3iqFq5c30rvfUNYiF1Md9PUX0t19s33ixrIyrHKMAUT0Bxq2SvT1wK5Y6F?=
 =?us-ascii?Q?CNue3T6N/Z7A8YtmucedADIAZ5LZ8w4DIn4ISbvatZderuSrpMYD2qM01OK+?=
 =?us-ascii?Q?kLFpAYsdM5mb5MOsVEK/j3v/b/yjokEBX8Si6/TjXUF+IDYWjNQNLIvICze4?=
 =?us-ascii?Q?Qu8ggDO209Nhn9bbspA0Q2CQ26JtJvrp7KFvpa1+Rbur48tR3kQdf/lcFVjG?=
 =?us-ascii?Q?SZXW1cPP6O7res8tVNNaA5X2dcYNQbmTlIuGeeucBR/7qICHO6z7bHLS71WO?=
 =?us-ascii?Q?XKL+/xICWsNJksTT52/RGyL93yzKe1Q482A87ip5W3qPFn494GNxbP5ggHsY?=
 =?us-ascii?Q?aAUJsD6YizpaSe1UTrnDI6LpU+vMtqPRIOuYpAu5O12WT8sOZWbul8NHtQH6?=
 =?us-ascii?Q?j+kRWOwJpa3Fa2qB/oR4NGI1skAGI3zWgFYoGnyANT8f43Ua/Qs6iPNufhi7?=
 =?us-ascii?Q?/MCrMJxynW5BbIVo4dmp/c1cY230SZn+EDM0DiiXlXcbNlPhzmvVzfGT6bUq?=
 =?us-ascii?Q?ppzy8Csvoik39hwep3LGD0oFphHIxdc4U0chMdTqTLON6Yq+QyA0E35omTb7?=
 =?us-ascii?Q?+ZJZdnOI+tU9vPQ5BZbqOAxw9Xti56ZTYTUNDp0OIF2qR06wEI06E4mjOuSC?=
 =?us-ascii?Q?D/8LM0l1MMTDwyxTtdY4QYwwvoRm5be3v37zV50GLVlJin1m3K1JeNO1YGz+?=
 =?us-ascii?Q?zfq0M6+2P2Fl2pdoabHr3u+BTKI5Ctn19QbKn3QN9q1DyE7we3v1N6CyTvcS?=
 =?us-ascii?Q?nP/3knGsEwczhaDo0tYAB67/XGkESkjULI8lxBZrqdBrXA4cCKoeUs3qSvws?=
 =?us-ascii?Q?LXOkZP1hccKVrGzbG9104X4McYwhJoaO+ana2BGgCDl6QINP275jZDNle6is?=
 =?us-ascii?Q?HSrH9+uXn1PqZbfG2eV9beMJBmslji3ypAWjM1FTbeHvoeYDRIqVRaY3JBOU?=
 =?us-ascii?Q?AF1c9aTy+MRaACh76pYmQ4TGZK1Co20QaePJcKYO7V9b1Y1SSnIGKlLH7fUW?=
 =?us-ascii?Q?YbfY8GaUpkoqc7iEo4bMEyvC1gddx1WsUzFrhoni/DNfyZiHkDEnBtoNSile?=
 =?us-ascii?Q?eKkRug3vCgYPsH6etOLRhjdE7590g7Vg?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 17:39:30.9132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de6f4b34-ec39-440c-71a7-08dcb250e656
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6361

On Thu, Aug 01, 2024 at 10:28:48AM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 31, 2024 at 11:23:24AM -0700, Nicolin Chen wrote:
> > > If we really want to go this route I wonder whether a per-IOMMU
> > > get_resv_regions() API should first exist then there is a clear definition
> > > what types are per-IOMMU and what are not.
> > 
> > Probably it'd be necessary.
> 
> But domains can cross IOMMU's as well, it is not per-iommu you are
> after but hardwired per-IOMMU driver type.
> 
> What was the issue with trying to fix this on the nesting attach side?

No, seems that we all agreed on enforcing IOVAs to the parent 
HWPT, so we will Just go on the nesting attach side.

Thanks
Nicolin
