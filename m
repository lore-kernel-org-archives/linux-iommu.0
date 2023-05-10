Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5C836F
	for <iommu@lists.linux.dev>; Wed, 10 May 2023 18:31:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzviT38fbBYgbC061rDmcGVoil++Vt4vv6/9ZD2+pAnDHhWiSAc4UVp2pLoY+tMV5pvrnAlOqnG6laOka9HtZnY5i9X4TwGJJmfQrm9adly05Qgx5ZW6GzWPI2fRfv4Vxqfs367BjUIYeGEU+leixl56teLshBgDVDfXw1HWst9E5X9Tzm20qmqaK4R8K6kqt6VBVGm7UnzXFvisqeeC9TZpiT4tUplse7AdD1581mPoicrBBCQ0xmRNLbxnlNQBI5UDSUv8NJJKyvEZ048G8IpUpo194BFiDbfHMkVWMjGZk98JdsJx3o65gGgSsp08s3PVHK9E86rfqUYoLWv3Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0jb9n+Io+Z/tfcOnGFrZHTS8oOAw7JBUjNi4aXg1hs=;
 b=TrYJrTEWOi2nxGUT41AdfOJeeX5wPDugzTxaz8JdiYjCOPdHBGQlC9n9755kb3Tm1iGIX8R8156fXJT0jhpBdKv9cQ1a+HBEa9oVgiFvWQmPh9XPQleoAy97Xa8YtRNvliBN9W0O9xULef6o/aqo1y0p5SAxy4XjY84xjA1lA2UCnNbrsbtqVVRR9eRTSRyrY3LZLHSqtohBWaIhiLxQx2SVnwOx+3KFvVbp83xX+RWgwIouXLBpI8h7+lcKxenWHPm0ZnhBn2LTWIa8+LvOjJKDWLbsUM91VFG+8OTVzCj8ENwZHittzjbQv5aIMg5zb7emmTYwbP1RFv6/+leVhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0jb9n+Io+Z/tfcOnGFrZHTS8oOAw7JBUjNi4aXg1hs=;
 b=j1gf0iSKCLmAaLmZdj8fqNSX7Ww0MA61iym6j0ubrXOhtwovycZe1DSrgAmFcUGh86ajEwDIOVEH26pzy7qPYGUf1ITsyLAfG4qlM9/Nzlir4oTujQwEkDPA/sodyBdv1ddhxoKsIogCoKsg/L+9WqeXiRWN0042mWNh5LqHXavhAL7mKpI4WftJD7aVkWSPgXY8kIvIwpbq2p7a2KWo7Qc+iWdWnBPwpOi6cpEYsM26FqdtOa34yGEVEzDWFF/sBVcltIaUdGxHzICmRUuA4NE/4rXwJqvIB7fyfa3kfo6dL01b+oFIShNjX5896kgGJesZnotR9iZlIpjeCxtrrw==
Received: from DM6PR05CA0047.namprd05.prod.outlook.com (2603:10b6:5:335::16)
 by SA1PR12MB7246.namprd12.prod.outlook.com (2603:10b6:806:2bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 18:31:41 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::7d) by DM6PR05CA0047.outlook.office365.com
 (2603:10b6:5:335::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 18:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 18:31:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 11:31:28 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 10 May
 2023 11:31:27 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 11:31:27 -0700
Date: Wed, 10 May 2023 11:31:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: <will@kernel.org>, <joro@8bytes.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <jean-philippe@linaro.org>
Subject: Re: [PATCH 2/4] iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
Message-ID: <ZFvi/WEksryM0cin@Asurada-Nvidia>
References: <cover.1683731256.git.robin.murphy@arm.com>
 <330221cdfd0003cd51b6c04e7ff3566741ad8374.1683731256.git.robin.murphy@arm.com>
 <ZFvec0JGfbaYHie2@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZFvec0JGfbaYHie2@Asurada-Nvidia>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT059:EE_|SA1PR12MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aae599c-cc78-458d-35db-08db5184cca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xHTu99FjD1eseT+HScPs9MvGSpYpAPVmqBg6kJpwG6kg/L1aHt7JVss/jM0FyuYh8JoNIJVqovobSn7zCKdicPZnxHIDZ2gTKz7wDfwZFd0WfwJQW5/KwQQQK3rMV6t9Mwvaoz/indcblEWZLrOceSwlPdYSru5hc8hdwhvjj4cFw7ZRWHv9ldKzhjEb6KeOp1s8UfSsze3PLRFC2cnTVHsP3qa7lD1+JOsvCRtg40Xf0DgFTtowVUSRLS4jrMyn7kor7bkSlA1BEZxrVVvduqutBdjPb1K7a4zDUsssCIKk734pXDGFP1f6bts85bolnEH7nP3H1KDEPoKd8axXeabrqZ7nuGnlad/X/iIftgSYzvPaadZr3aFvz8pSdLIT7fwMcgx1nLs6GqwHy/lbBYwPq7Bn+dxrkDws7YKOt+ksx3LRI+cUgAVHsctSZsgEkXOLEJDpX16vwCabAAwU+Es4Fe1OYx3AZBRuFS7CbkeVPQs/ySqF8Me2L5uh59u9ofz/0pJudig4MqhS13hZ+ysY2afN/BkImg0ulWWTwEooAqXuGV6FtpBspfbmh8Rjr0L8nxouLBvaBHvkAQlQEyx8Qh/h1VpH013leuTJ9B4fC6rxg8XQ5MMM/6JhDmRqFlgsRaMgYTQ/ZNNZhw/IwY0YOG1vRm8QnR513Nq4QgDTk7ROFySv/nMeqyIOx2v4/USEj5BUnGrppfvTCEHbHw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(36840700001)(40470700004)(46966006)(8676002)(82310400005)(316002)(33716001)(8936002)(5660300002)(41300700001)(6916009)(4326008)(4744005)(36860700001)(40460700003)(9686003)(2906002)(86362001)(70586007)(70206006)(478600001)(186003)(26005)(47076005)(55016003)(40480700001)(426003)(356005)(336012)(82740400003)(7636003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 18:31:41.2366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aae599c-cc78-458d-35db-08db5184cca2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7246

On Wed, May 10, 2023 at 11:12:05AM -0700, Nicolin Chen wrote:
> On Wed, May 10, 2023 at 04:38:44PM +0100, Robin Murphy wrote:
> 
> > To work around MMU-700 erratum 2812531 we need to ensure that certain
> > sequences of commands cannot be issued without an intervening sync. In
> > practice this falls out of our current command-batching machinery
> > anyway - each batch only contains a single type of invalidation command,
> 
> Hmm. This doesn't apply to the user cache invalidation solution
> in my v2. A user cmdq could possibly mix different commands in
> a single batch if the driver isn't aware of such an errata. So,
> I think I'd need some twist when the host has a FORCE_SYNC flag
> in my v3.

Just found that you unset the NESTING feature flag in PATCH-4
for this errata too. So, the solution in my v2 should be safe.

Thanks
Nicolin
