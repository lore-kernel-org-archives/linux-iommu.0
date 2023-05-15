Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484B0C8CE
	for <iommu@lists.linux.dev>; Mon, 15 May 2023 15:44:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5+lh6eQwg4kxztDSQtjuM3CdNJJ6GIq3DiEO5Q3IlQwDyjkGRwOQ77lYl86EiLv6aYZspWfCqRRFrA0O1bnMyQqe0Qr4Nc514udTsffoiw222pgl2Rq3RMRM8XpbV0GczNAv0YiAw94mLx8sIiOqRKAgy1Da7CVS3274+b1qffP3epYma0QLZXtUagr4Didez8p2YSVE+IM43VX2aZQfZ9+fPJIXt1IMHjjwCO0MYKPJq6UhyKd7IE11REliLe5DUQv7uTtCL3Rl0FP1kVtIa/FTGZCzPS5lY5ZHc9LfSHwzgZJzro6jy42qBnWwmcrhOKPeAtlX/YgE3lmFZlVsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5byW41ReH/qh/AaZJGKGNlf+zGaI3Z8frCyeFm3Cgj0=;
 b=LOV8x+vOxvd3VmS5J2WlL6GnUtVgiUoe5tvfdiUL6OyiU7IdU+T027bGlpYtdSTlV1yZ0cngzdkok8UdyQQG6jrdg5cgewKxuR06vFW3IZGRmU9OCPVt7Sf9OlmlYUjAC4JEmsilbUtK+xFDcL6VUgh5K5zZCNysowWBuFYytMRCU6EaTn1Uh8MFbbC7cmfN5NSaDc+zpxaLjnJMeeLXdOKEIpLsMBuF3aZPTeftCRgwetDmte0JtlqwITxiDVXlb9Q8C96t14s+Dn7YvWIfcwmMnOhVklkyevtc9QKu6ZgFyDJ9YXz0+m91Z9iFTZGoo+0yehSJy4tgTwib5B4DIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5byW41ReH/qh/AaZJGKGNlf+zGaI3Z8frCyeFm3Cgj0=;
 b=MTgKmPVkt4BwOdtFkdwYe0k5SYZD7g4Dn50X7oTw+id+jyPqIYdCR6rVNLWk2oNwT/UiczHBJQhRMLH/cOKfaFSaTwyMu9KUatutmdKvR5mh5jqfoFL49+O4nEGVbNttpydX2d75kEVVmLp+bwbp3VKsZNWrhnjeikEyKIOn6gtJA+g+DLz1ATuO1xTKDCxI1nqN79B1Bm8E2Gw6Np6iDgqMXW2YGroVSFf3WkTSDvHG+OZdHY1tW1Ps2IUmWnYHIC3dGPwPKbqryR0fzn3rN7SxQB1dO2TKUOyZi1iA9RShfMQ17HIqyEvY1oksXMBvUolpmEWCOnIv6B3H141NHg==
Received: from DS7PR03CA0135.namprd03.prod.outlook.com (2603:10b6:5:3b4::20)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 15:44:15 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::ee) by DS7PR03CA0135.outlook.office365.com
 (2603:10b6:5:3b4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 15:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.15 via Frontend Transport; Mon, 15 May 2023 15:44:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 15 May 2023
 08:44:07 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 15 May 2023 08:44:07 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 15 May 2023 08:44:07 -0700
Date: Mon, 15 May 2023 08:44:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: <will@kernel.org>, <joro@8bytes.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <jean-philippe@linaro.org>
Subject: Re: [PATCH 2/4] iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
Message-ID: <ZGJTRc+LYFFX9Sw0@Asurada-Nvidia>
References: <cover.1683731256.git.robin.murphy@arm.com>
 <330221cdfd0003cd51b6c04e7ff3566741ad8374.1683731256.git.robin.murphy@arm.com>
 <ZFvec0JGfbaYHie2@Asurada-Nvidia>
 <ZFvi/WEksryM0cin@Asurada-Nvidia>
 <a45be5e3-c605-f93a-f523-1bb1f6150986@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a45be5e3-c605-f93a-f523-1bb1f6150986@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT028:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: f9d8fcb2-499e-45db-11e4-08db555b3c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bBpdF77tKXJluQNmwnMQHNa/03oRNx6olUbJTaVh70tjtTWMKMmHxZp7/9ZTUbPpF9WsJAk0tJSTdYJjHPctS/mGGZgwNqe8WERk7woSb8tcvOZIpjs+XXdBjYmPZXgZAwkuGuwQ5RIrc2iFi33cASt6MyYZ5fvrsm8eib74bR9ZNSaoHet3wDWGOUInlkbaZMWNeG9SPiyU6vTlGNKwlg/BuhVijCsGdIo0IqaMhMtonZRwyJago/ftY7BthCe1ykaNgxm1tm5YyhtiMq3Iyc/dscC8MSuUhPBMvywpdatq0QOwKZr5wjsTyZqyIETENdrIg8+paEZTJt9XjZE+MXoyQTUXQ5Q/IvhhQ4Taa5ypAK2q54ZD+2KfZTuNPk9k0VqVuFGDmQVroiy0SJZ9wq7Ch6WQqcfIzQ+DA4wZr5gryXEAxb6loV8JPcEsjPPe2bAZvLs0CYJXfR85KPCF3iIi4WwOtRZ4ozCxwLO6wELrZDjj+3FCqCRSmDT3NLiI7LorI1EzbE5dZ+eR9o+6udcrJE8bgqY8GJhoouP4EViNaIJpONVJL/dcP0wfAcBIl5S54ezm9iWtpehH19Ug4o+kdbDGfr7DpqOAkhSCxt5hBONIUKKNvkYokQ88CEahQeDhreJfEnj6HcqD0yXG/Vnn9NzljRYdNprJ0vMwFtaDAulD23wqx5Zxw/Nx86awRpRgBk2GN4ANuMD6db1fReazuKX/xTyWMoOI03DpVqBjS7I2uYlqV2mDPRfq5Z/5IXLrNLF8HtVeRB4lIEuW8Q==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(5660300002)(33716001)(8936002)(8676002)(7636003)(356005)(36860700001)(316002)(86362001)(47076005)(2906002)(426003)(336012)(54906003)(186003)(53546011)(9686003)(40460700003)(478600001)(26005)(55016003)(6916009)(70206006)(70586007)(41300700001)(4326008)(82740400003)(40480700001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:44:14.5579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d8fcb2-499e-45db-11e4-08db555b3c67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709

On Fri, May 12, 2023 at 08:23:54PM +0100, Robin Murphy wrote:
 
> On 2023-05-10 19:31, Nicolin Chen wrote:
> > On Wed, May 10, 2023 at 11:12:05AM -0700, Nicolin Chen wrote:
> > > On Wed, May 10, 2023 at 04:38:44PM +0100, Robin Murphy wrote:
> > > 
> > > > To work around MMU-700 erratum 2812531 we need to ensure that certain
> > > > sequences of commands cannot be issued without an intervening sync. In
> > > > practice this falls out of our current command-batching machinery
> > > > anyway - each batch only contains a single type of invalidation command,
> > > 
> > > Hmm. This doesn't apply to the user cache invalidation solution
> > > in my v2. A user cmdq could possibly mix different commands in
> > > a single batch if the driver isn't aware of such an errata. So,
> > > I think I'd need some twist when the host has a FORCE_SYNC flag
> > > in my v3.
> > 
> > Just found that you unset the NESTING feature flag in PATCH-4
> > for this errata too. So, the solution in my v2 should be safe.
> 
> For the short term at least - we will still need to come up with a more
> practical active mitigation sooner rather than later, since I imagine
> people are likely to be a bit miffed if nesting support lands in distros
> but still refuses to play at all on the newest shiniest hardware.
> Unfortunately all current versions of MMU-700 are affected (hence the
> unconditional nature of this patch), and some of those are going to
> found in production SoCs.

Okay. I will try adding a WAR function following the doc:

1. A Stage 1 Invalidation that is followed by a Stage 2 invalidation
2. A Configuration Invalidation that is followed by any TLB Invalidation
3. A Leaf invalidation that is followed by a Non-leaf invalidation

We don't need anything for (1) as a user CMDQ only has stage-1
invalidations. Adding a SYNC after every CFIG_CD(_ALL) should
work for (2). Then for (3), need to check the leaf bit between
two adjacent NH_VA/NH_VAA commands.

Thanks
Nic
