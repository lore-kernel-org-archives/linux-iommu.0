Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68121208970
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082568; cv=fail; b=sR/nIZrrPCLH9+G0QUS/cLa5ngCH+dneW5OEW5j8Us5Rbvcq/8Hx9VUvZbB2a3+w75GRN60UEOchayMUTs9vcSwNyhEedhSN/abEHJ8elFDSks3R9TBz//EMBqoxivKs2f77qrwpR0xC1scx+8mMHQu5lG65QDvw21KB3oNtNAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082568; c=relaxed/simple;
	bh=X8/2YO203XMmRIuXpR/mMwew+Lvs+AMUjjMnG4L4xZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f46ImCLNlsZxgqJf83/W5dOnIs/tS+Ov57cCq6r5T/XWz158+8CwDqr38q0aeUaTy+/Kc9JdXudZt3JbW6lM7pgkMUXUS2bBXYxAuYMoCdsRvddoZYFFBFoFzJqnG3hHtVjpenYAnQgqXEZ2T/nAc/Duyf0Nvzug0XT73jVbjEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JBW/lxPb; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JBW/lxPb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHac4rzqPxYn1LxJwQ78/uIONM5ymnWzbV6j01AUDB0KQEIeVSYA6x3E657f/UoIjaFJH2ZXhNteBfbbjWu1sM81D3S0NL9eCs2TLK1B/qjLjdiZXZx4+H/wyBx4G6nY3GC/lpsA58kTSl39Ryh/f+Q7kiIOYN39gVjyFIs5KnG3ich+rL9s/x0WFf6LJEAdUunNI6L817AEgbn4ZwggiMEiGVDYB3hcrfoM4Cl9wbduSFWaJxVGEZwBQFnWUNb1dk8tf//vQjWqA/EVnCfHl+0SlTqgHIS55A5uVtebjnnBpsN3FaWldcNmU4YIyMXDKg5KEaKuvk1EAY5OBFAplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBlDKkJ+1ITC9zQH9UhdAtaqBcmi45r35YffhJzaY3E=;
 b=gOo3h4TR2EQ1DzG8SpH3p5rEpq8UTxQuIdBMoEMNOXrt867RT+zLysilZOrSlbyspILNld+U7AynUPGZffzAJpOrCJLH4C5FEDbpMzSaYy5D1dKzDUU1BirkdlFP+5EmgIRFl8yFg1GDFqlsUD+phsfYEahsCQX4PsEwLLVHTUb2kiSoiFIq24rt9AoOzo4yNp3vbmPVvvrwOIxAr73Ng5a0wcZXZip6SD8g9HuuGiPJEqUA6VVvhmaaaAaBjUq2rRwxERZsew6/RimnU4xkdg9Ayg83KrwTZJdQ9T5Vxaeuqb5zyCDgBV2eD1zzVPISUC0F9sxMteeVIg1sY9ry6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBlDKkJ+1ITC9zQH9UhdAtaqBcmi45r35YffhJzaY3E=;
 b=JBW/lxPbCqtlk7lQzkw77+wEWwMNkkVn9G1FRfsP3INykAsJ6R4xF5ZbOqbVeq2eo1HBrtAtZT0cL9afTxOviI1wk5FwowNEnq0N3uAGxg9yq7GRRY2tHKDwj/MzcI0BPh+ZuNJFex/nVR2nNl/55zILKguiLEetvsCbhzC50Ol5fowl0q50gfyFTIbglc3KgkFWVxqUso0tYyEtmof4cn6DZMq/LoLxgC/TFu3FYmefhWYHGArRI2wulHMh/KqSsV7hwPgK0SqCMLpSKXrOvKvuLTQVmyIoUBiRfNcqznsGidjLQrD1gznhDArCEMvVnQfdZC98dEtFvabqqPqIXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB6682.namprd12.prod.outlook.com (2603:10b6:303:1e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 12:42:43 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 12:42:43 +0000
Date: Wed, 16 Oct 2024 09:42:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V3 7/9] iommufd: pfn reader local variables
Message-ID: <20241016124242.GH3559746@nvidia.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
 <1728067700-32092-8-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728067700-32092-8-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: MN2PR19CA0051.namprd19.prod.outlook.com
 (2603:10b6:208:19b::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: 74cac946-7e69-4c54-10a2-08dcede0077b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oFj0j9IVSF44H+xOi+VY0gmLGzW/GhCuYPgvnEAxT8MIl6p6rLb+UcaWOHjO?=
 =?us-ascii?Q?SV2HJxTVh3R5ouaVLgRlS7wI5FSwgRNc30mDC06f6oSo/LWpiancDc8a+zr0?=
 =?us-ascii?Q?ckwLQWgVGI9QidrTSm2ypz+37JdfyBjvwMy+A9vzqI80rDurkdPmvfm5sFK5?=
 =?us-ascii?Q?jwS+gL0RX1W+uthcTnSGRSd9HBrtSkzbNMSEUNPZPyIyeZZIk+5Bt6cHTdXp?=
 =?us-ascii?Q?q0faj50uscrx3fh7WqTjRHN8OlBUz+fkYvfSVypzTyokR17/VoYjDfcAmFgr?=
 =?us-ascii?Q?lX/WgeTEKUW6z3/Zg8b5rJmHzV/iQKMFQPLcuCEuEfoASucYzOgXwEMRH3Vp?=
 =?us-ascii?Q?uBsHOOiosyG4pWM6BKTbBLyW5NGZu3l1wWrFUAOBCInZBRt0yVrvumBYLx2y?=
 =?us-ascii?Q?VccdOu00UMSfgl0DZ4+BL1wqOrm8sBAFkYDMKR/tK6vufY4Sd99Oz3fDIgGx?=
 =?us-ascii?Q?NPQlB/BsLEwu0myBInvp2ZQAplxZkL35VE+khtLJ8O2wW5LDTWF/qJxz7S+p?=
 =?us-ascii?Q?dRF/GuE2jT1D1+24fLVHWR9VITcJGQxKo49zQ85DT/bdkKHDpViHGvazb6Yg?=
 =?us-ascii?Q?y8QbQWrSQmzuV6PgvZrrx4PiaMbKX3YP1owz4TIumMEF3F9M7fd9daJ0e/3a?=
 =?us-ascii?Q?tey7ZonffQJ+Gh/f0DbEALVc1aDbsX3je3B+WjFGiNM766qmjvMbKDVCjVnW?=
 =?us-ascii?Q?BNmnhL7z0UoPDs367Pfbsm99uhE367Nnib4pGZMJGOVqhYQRSfpS5D37yncV?=
 =?us-ascii?Q?jk+1mYPaqMMJcrHzS2Qt99K49iSPhmS6uJlz8ib6mTopZSGAUMoMitbLM7Y3?=
 =?us-ascii?Q?FGnqymkkzBE7EOCew5EP+Mx/aSULXd8S4Jem/mtkxoHWGPfifwWd5P64PHr1?=
 =?us-ascii?Q?/4Nxn4IU8RabL2aGOOQiXm0Jy2hlUoLR7XUnOMB2a2JaYBvGX8QBmssLApm4?=
 =?us-ascii?Q?CPR0tXowNz8A18N2sW8dXbJqXmhhGg3e2NtAz+XtnP7z7TUx1to2j2wEDmqv?=
 =?us-ascii?Q?KYlqLQ0sfB5ixmzIBrStWk9U2odd2PTLemHtUz0feWUiOzP7bicFYc3PRWBm?=
 =?us-ascii?Q?jFK+nQYgMmKXBoCcLVrLa2WVYdkwCT2vljGF5mVEal2/JFFC6MWmLjAUy3CL?=
 =?us-ascii?Q?oyrYCHmLknVOwh01eKELPnHrd8R4UiqOl8AdUADxnmlRom+3BfJ17mMd5P5m?=
 =?us-ascii?Q?Sr/M5o16R2bvgpH4NWgzOn/riKt+En7v5vp9NvJjolX2AUJlGQVtLfQ7wtZH?=
 =?us-ascii?Q?hSRi/inwcAwNPYoxej/0M0qruijsso1WY0vRNNhktA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JuoqJSTJQlRiGyJav8IVcs3pe4kzG/sQ2WQ2wD5FuWdWYlUx/h+gfbIf2sKz?=
 =?us-ascii?Q?Ci5jwyA/wA5Xjcpbe9S0SMF6uaiDbqvOmu9FCYF/HA77+ju8U/PBsK4kt0Ya?=
 =?us-ascii?Q?NQDQKo6H+J8NnEZ4srKW2utejdeP428mrm9DfeNnhjNMMInX/AE+cQ1N7ztr?=
 =?us-ascii?Q?X0OR/LunLCJDuAhf9DzQq3w0danBRA2RaXvSedwiPqEv0zniYz9Y0rdtQLqp?=
 =?us-ascii?Q?MhGi2aC90BPA3rmIC0WLuMRmloheJVpKnIzhX+O8vdopF5xHDoNoGxe9SCAQ?=
 =?us-ascii?Q?ImFMf69EfKTyFF5FzdD2aAxGlypIZ1nOf1GJq8YUHfCdqHlIVx8faAmHHIcI?=
 =?us-ascii?Q?BbLh9kNK6uwFqwbwA4ekLR7WMy9jxPUw0EmSycWXpP0qhkLFuncQlUeSErmz?=
 =?us-ascii?Q?9kfy8zdpSUpDT3u1fu8aIXPrspcnyhm04Qye7qpwzrUcyeWY5hegIka1LiMU?=
 =?us-ascii?Q?9IJqCRZncFENWJeQm/xzVvpuH3nijMDytNvZWkLOS/Z2j7H3Xnn2+6K+1Wwb?=
 =?us-ascii?Q?X5bzflm04lWfEqIxrJf3o1sEZ7eYl5YpVspyHbM9/DfcziAFtq7umTZaieCT?=
 =?us-ascii?Q?5L55v8m+AtWWrMS/HbteyWSj2kyBDM2q6ColTez+VzKTlaodQqB/f8K4RJHL?=
 =?us-ascii?Q?d3A+hlWJrDpNsX9VYKNMb/RkrqaFUma2Dsj29KFnxv3nUU9saArdEmnXMwHt?=
 =?us-ascii?Q?Gu3Np6K9R+mAZy1Eo3zdu2jKfNAJXVhYwv3yqPBfbOqVm8EPK9h8+6sJHJw7?=
 =?us-ascii?Q?5jy9q3otABSFyUC2HTAHGRxb9VQc3MvwcAimH2PacgUb4UmGn3qA/xf22Ddy?=
 =?us-ascii?Q?DSuGNEVIQ/NL1sCBK5FXWfAcnAIr/T+mi0DP38nDQN337aJd4p4PAFmavlJy?=
 =?us-ascii?Q?LXANnpbiK7CKFBw8i/N2syd1g0TKEMGcTOMAw7b/Obu7jUxRwcP+JRUNPCZo?=
 =?us-ascii?Q?NZmIDCVR7mRq+HcGvTFoO8/z6cjuux0gCyYPxDu4hFpm0K0+09VO1C+6yo0u?=
 =?us-ascii?Q?+dM3vy/y0Q9imkTWZkXnZQaKOX3GtYjLO0GmD8aYV1OqThTWfxo4A5CyShej?=
 =?us-ascii?Q?+cnKaN4ArPbsnhB0rR/jSPYbl0Gqkys9ZnzgpUUGqEDkq1N0f6lv6CVJaCeG?=
 =?us-ascii?Q?EjAKOGWDLDIlon0r4CIyVGdGttExKAU70WXQkCMu0Q/DMzUk9THxh9f1hIEn?=
 =?us-ascii?Q?XdwvRZXORTmgi96yLZt+yVoxDK2AHWu+32qi39xV3D4jA++yOj8XVqXFYOGS?=
 =?us-ascii?Q?5LRgCzCCLenfvCFDKvroboHLFy7Fv7Xf10XowrSDS2JA3zL9h2qc0Mr6YD+U?=
 =?us-ascii?Q?HGtPxasekltFM5RZj6ERQz5AmqZpTfNUfhe3RQfAocJ4PJByGWby8NXJMJx/?=
 =?us-ascii?Q?uEeYExDed6/o4UIE5+F//oWZck6iWqOAJMuBJpAJg2IulztGX/B3AQoe5lne?=
 =?us-ascii?Q?sif27ntr1pScGx47x2hBiz1YEK0ezIj3c0du7K7qefssFXe2h7EUNXpp/7br?=
 =?us-ascii?Q?okXFj5/OmI0KE8f1oO+OcIUwZ5fE8nKwEO6p9LuE/Pszh2ZoJD8inq1NyfxD?=
 =?us-ascii?Q?yITl9v/WjknuQp0zbDQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74cac946-7e69-4c54-10a2-08dcede0077b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 12:42:43.5102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0R+rs6+8/e1nO3L4/SOR3928AM5nWJZMZZvAsBPMcSnsVVmp0mhyY2tgLDhkBtft
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682

On Fri, Oct 04, 2024 at 11:48:18AM -0700, Steve Sistare wrote:
> Add local variables for common sub-expressions needed by a subsequent
> patch.  No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/iommu/iommufd/pages.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
