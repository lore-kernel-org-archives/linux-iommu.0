Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013055.outbound.protection.outlook.com [40.93.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA79330D29
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764170449; cv=fail; b=OfVtM4COoLEud+XWgemBSBWay7kja+5cc1Q/TBpUdy8Xa+pf2/oGyiW6J8jGS0EFcSHn43C7pZtguIJ4CQQdl8XAxuKtBFG+CdIcAQ/hNYPLLkZBeQktT3rkMoy3bJ8WOdTRoqEmDHDMILeEio6fqKOT6apD13ZLHZcfkvPboBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764170449; c=relaxed/simple;
	bh=MYCNjoo9FFylA2fJfu0cng5Gs7VfVT9Y/p5vxiQAnNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cI94SZ0oI1R5NpdqfQjXl5WhxYcZsk8kGmyMWeuw3q0VPfbz98ETYsUphchmna13oAJfKbwjj0Kr+HiWYiT6UMaTt40REupG0FJQcvNJibUatvZx9t/bmy/KJO0994soiQZyyCGEX+ojgjADXerjANg315rRM+t/gpXiLge8ZYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lwi7LjTJ; arc=fail smtp.client-ip=40.93.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lwi7LjTJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4CtCP8o18AdK/w92cUwN0/ANOpQqcV6r1KwX3Bh7BOUBOPnCeYL4Pp1ZvRRkSX3AqSq/QrrKSPtgbr8Qr8BydVYgQU92uwdEvrf4WCz9a2dW0uGaxG2RucmDyhADK+lhpR+RbPpWqlVuuveuqJJBiU2ibVAPmZ66Wh25no90Ki2EpYcjOWb7qlNGUwt6GQz4jNv/mehvaEW3W5tEoSH4R7RqlmeO7cPkULnG4VSoRSgf1QKbegx3dsVNIeocAWGb5CVC78ZL6I41cHiXzoYNfhgad5ZXXlqXI/2lu6yV9/YSHyV6yYcMHGIk3Tfi2LPLRB0vrqnK9hYuwvFb5Xb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYCNjoo9FFylA2fJfu0cng5Gs7VfVT9Y/p5vxiQAnNE=;
 b=TMej727JAez/l2MUnlGuPzKR3GDA03vwEuFVuDTm1TrvWr7Fz2GH+jwZO0BJSHPeVpVsv8XR2VgKSw2IcR9iw+3PfmX4BPNRVjxljXat5BWnNysByuc5a7l53bknPpZRYe/b61ui9/H597ztGwE8kIyVLeR24V/LitSf2/RD0jpnTEWKpNbSe1YetFn3feMBTrdA94r+bqPMbfpJnj7JtbT/KkY7JUQqJs37oBurMsEflqRceuQYPdFagN4dfhCA8eQPKJAFW+06G4DE0ObbvIOoXAgkbFBp2sUYxpNPX9ut3w13BvvGel3LZsPekr2RxrLfM+gSccxkUQFCeMldzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYCNjoo9FFylA2fJfu0cng5Gs7VfVT9Y/p5vxiQAnNE=;
 b=lwi7LjTJNmIXX6dObb3A4oNd8Q78IrpWtYzsNvaSBELHNe8oaTIIFNxXZ1roNTUHySq2HllIko+XJUTmLWyaCACztGN8PicSsF3xgC0X5Apt5rewYFRolA8fcHNkOwbMLLQUpSMw0RTU2TN846CJloCRf7QArv/r6Hp6dk83xLxATwiD+13t5RY/eiUCgbbHL5ywmANOoB7M9QSZZ1y+ZIFxIF32CxidF4fpEPiOBCzAvifFOmcjZDRFdj3gVccjxKc4JZlEZQuttjNpTiMpPmJmW6CMfnmu9oDfSK7ZSBCA63tbmPkbvsgM6lLRmeFgVDlLKM7kNotdfEqKC0AW/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 15:20:41 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Wed, 26 Nov 2025
 15:20:41 +0000
Date: Wed, 26 Nov 2025 11:20:40 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Sairaj Kodilkar <sarunkod@amd.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	ashish.kalra@amd.com, will@kernel.org
Subject: Re: [PATCH v2 1/2] amd/iommu: Preserve domain ids inside the kdump
 kernel
Message-ID: <20251126152040.GH520526@nvidia.com>
References: <20251121091116.25663-1-sarunkod@amd.com>
 <20251121091116.25663-2-sarunkod@amd.com>
 <20251124144458.GH153257@nvidia.com>
 <b15c4495-3765-4af4-8cf1-38c64e8fa69e@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b15c4495-3765-4af4-8cf1-38c64e8fa69e@amd.com>
X-ClientProxiedBy: BN9PR03CA0473.namprd03.prod.outlook.com
 (2603:10b6:408:139::28) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM6PR12MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6e2ac6-2240-435f-b2cf-08de2cff5c5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vN95eAxnDatY55IYE6n0MtlfGAK56IM3QORe7LeiX2eR7dmrO8or4d85+Y62?=
 =?us-ascii?Q?BOjzlpR7e55Wd3Y0Zeu9rqoGH2iYVUiQ222gwugXll17jcu5QuNcYmg86oLh?=
 =?us-ascii?Q?G8ME3ZMOShRdopcjzX/fMcNVOSGyekrcpBl+Yp3isjywgFUA4hX7I/xO2urA?=
 =?us-ascii?Q?uEoM94LN/WluEuOP1ek1u3h+Pp0AMzAsRgO7wqoHA9JjRNEZsTbpso66Q35H?=
 =?us-ascii?Q?DqOLLf+ax+J7q4Er2FOE+2ZNKCJBvhdmzzX7J2lN6cyNMmhltmQk1dexYdnD?=
 =?us-ascii?Q?gxTz6O+tTI926zGk+RALq7IVkal0frESw5LeduWvwByYW9oC4ADEH4Sq7oO5?=
 =?us-ascii?Q?MxQxbGC+raZInN1rIoK/kH6kybF3ixFTXyYv5ujTjZ9uynWT5j6IrDsAaG3K?=
 =?us-ascii?Q?Nmek4qwNeUASlGRlOBRhD3qbdjQB4D/glZ6Auv1zwjTkz6CBFveYnyTkuZou?=
 =?us-ascii?Q?khGiWYWtd4x79xG8YHRkqHF6ghGSTPbc6t1TVJAv4EMwwC6yZHCAFr+Q9rXF?=
 =?us-ascii?Q?ZqOPPP8IiWQOHDXZUVamKbBeGhzqJ1Cepy8eovb5hnlqW7dvWiZvFgq6taTs?=
 =?us-ascii?Q?Q8o9wJ5YVJMZLaVZz1L0BF7wQdFNWIRbVNk3dm/YQx7WjBlEU/7x4L+YPWko?=
 =?us-ascii?Q?cv7j453jrWHp+7S8kN3hyJa/uLz856Xjc7ns0unL2pq+wV1BcpM6AdTtJT+w?=
 =?us-ascii?Q?ZIhZ02BF97saIuIh3gGUIcc/NbD8iLtvJVq7RnUlasrtSvlsSY2NeAma4v/z?=
 =?us-ascii?Q?S47dsn8JlQa/WLfc78UFqDN4XhUIAox+PG0p+5fupS5HnuP9CanBl8pVsYzM?=
 =?us-ascii?Q?sFGUmWu6vP40FZFzWsxevH+ykepROkRMijnhND+us7Ma/ej0UhkT0g/A9YZX?=
 =?us-ascii?Q?KwAE3TCmIBJxck6ZMhns3grxCvqp2dcw9SmYuhpR5cHKrMeABdMg8gry3aMU?=
 =?us-ascii?Q?NAqf4rjo2DGdpnmz/qNiZszOdeTMDBGMoCE3xt3tFUhhYxD8eYJCH5Me80Zy?=
 =?us-ascii?Q?RUVX08KIi/28le+ze1t8Gdnro8RtlZDjXWUo5SAONluBLaKE21Zm9Acpy+D6?=
 =?us-ascii?Q?ICd9bnx76JBBMwcY1VcPG4Eaq9CAwO1BN/x62dr746oAqF65jFxNCGjJUJS3?=
 =?us-ascii?Q?voFn6XFoaqIlA7qWmEwiDaKsZQ5VGhAwKAAywOptwfObHc0gvwwuWvUdn5cl?=
 =?us-ascii?Q?JlLpKpkq7R1yN4HMkkpgc5A4zVKoh5Wf7lhZlKa1s/6Tsqfga5tluRz5aSzX?=
 =?us-ascii?Q?+WJo8osQ1QYeT1v+RZcpdEIgsxJdLaEa6PmBRLMSI3JghQIk7C3U4IOPtu+v?=
 =?us-ascii?Q?ZtBrRpKdkvW/jnIyPA1zKwczd94t4oQsLF6aszvsMvAiHsqLKMisHNl4lOgF?=
 =?us-ascii?Q?JuQ8Ew1gA28FMTLzs9tYVXmDfPdTDYNHNSnL70JHCUszTbNbuYd6duk5krHn?=
 =?us-ascii?Q?FJSEtj3c6nsM5FWTltivJA+yMrdLIAgv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+fry4nYZ+tKbou8lh3oK0+tj4pZ5QvJHWbWCZxKVG3UF1MldLWPxVN0G6Pog?=
 =?us-ascii?Q?lVMij2wmn+8Sbxissa8hnBIEuK1MysyuVYZdpQdD7hNd8Uhr146ioUf90JRp?=
 =?us-ascii?Q?npn5R+C/vw+8YwfFoSYmKoqsvcWok9B/x6mKV0ObMyxEP95XzSeU7UX9V6TH?=
 =?us-ascii?Q?N+uhwhjgOSFbG19v0Ih4i6n2RONWq8r5u63jcOaIw8AvvC1k8uJ88UNkcDi0?=
 =?us-ascii?Q?+f5Hcc9+Z+bsx0X25sBeHuZ3eXwHC8jvk9n4tVvs8XAH7rwdER+t983PKcPM?=
 =?us-ascii?Q?/6xGGAcxolDXit9CDeZReCo0vXkP1m9X/RaqlZWVuy0qALvtrKPed99PBM2v?=
 =?us-ascii?Q?Jft9LOzvNrd4FAx1nnsTHAN6jSQMc7WMPIo7ElHQKzdSXqTjUFT7C5AoiPq5?=
 =?us-ascii?Q?BYfZEwsCLkNRD4v9emx5FsJJYalEWlYqD7mG2Ls+6uFSAAufBm5WL4QipbsR?=
 =?us-ascii?Q?2DNyTR9cw+6H19dGqgKEaTjYI7MbzyUvUCUYs5XAJG+kGcad3iBTXaD+leQO?=
 =?us-ascii?Q?Av2lJ1Gdf3DrRtP084Isy27CYfOmUF0ZsMIgGVxO7iJNDlTyjP7+Dm29O988?=
 =?us-ascii?Q?hHmFpzKOYDq7h7OUhIJPXM6KKD7RDX2umXn8fcaaaZmXKT2nZjitzpsQnhbD?=
 =?us-ascii?Q?Ij8mak2XVWmRl2KFKqV2Y/luV0R2i6EvcJk+HtSi5+GU0Sh0YwVirHmllePX?=
 =?us-ascii?Q?93agSxLejlzoEYgYCMEXrOeYqiJqPw2+NzAHolAXMvESZsw/gJnWAFWsmkmJ?=
 =?us-ascii?Q?mD23AvyJq2ycyxVMVOrocfzrSE2Dw32VGcjUDuyEv1xmbeBc0QO2N4Kn3jeL?=
 =?us-ascii?Q?67XHyP4jh+6i9ztbDIgsVmpnNYB2p9Cm91Au7k702dnQsZ9KdsmE7NV9T0yl?=
 =?us-ascii?Q?uYt16C/W9hexs6l9sfYxbaRQrak6G06hXNX9rh8YXTnQsk3GFS9Mjj/NbX5J?=
 =?us-ascii?Q?SDTCVTrRFaLtmj3rj3jScVvcVqguRlgJ2miSlTwjYyMLXeqNhdXLOFXkwL2K?=
 =?us-ascii?Q?gRxmjLZTb88VtOyTO2LS07k5bTQJx8t655aGhzYmABkaFRhpurH+AltkvELK?=
 =?us-ascii?Q?zai1BTef0kqsvOEpsJTJFUIL8SC0gWYCYH2cYV7RJD/Oe62141I0gjEHaijb?=
 =?us-ascii?Q?Ojqgy5aTenlRA9Ppm56w0C3mRFObSQWzUgUUsrRB01s1wI2oPxMM4t+LYAxb?=
 =?us-ascii?Q?GA1GaoSE8SwwcXYMYZk8ZL7juOPPt614KmE+PfeIkxRgVidBVdzLPqIjNrGg?=
 =?us-ascii?Q?91dPI2Ud1bwc8BzxbtZt8Uk8ijIPbvdzyIv0lejsrPpwb1YXQEVijoaGFD3O?=
 =?us-ascii?Q?QQ7+2UV9XJ14SbH4UZyojD9YOSC5NqEDckHzk5n8mWUM88S66fJvAj/62SPu?=
 =?us-ascii?Q?gB6YaBM5N3oel+k1uhfN7j6KjBwc6YDBVjYwXw9M0lv9GK6dmGCghkp11JKG?=
 =?us-ascii?Q?WM63JMWJSw7ydxEDMVpEcRC3ACFFEwHuUBbbDPRaQPk4fJOOjgtghYAq5qlk?=
 =?us-ascii?Q?6BQ6dyxPUR+vFjpjQ8SBWjQKST1pccvQy8dz2NZ8mQ065oN+Itdde53Tv90g?=
 =?us-ascii?Q?sevGZ0VNrjcgCbX41oE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6e2ac6-2240-435f-b2cf-08de2cff5c5e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 15:20:41.3179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2fYiqIci0e3bsjzvs66HR9IWFPbZ3DDvhrYigi9vejYv8DAzU5QJg512ZmqYozz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300

On Wed, Nov 26, 2025 at 01:51:27PM +0530, Vasant Hegde wrote:
> It looks like on non-SNP system in kdump path, if it fails to reserve old DTE
> table, it tries to allocate new one! Looking into code again, it may be OK to
> fail in that path as well.. so that we will have common flow.

If it allocates a new (empty) one and does a full flush of the iommu
that would be OK?

Jason
