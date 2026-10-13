Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011047.outbound.protection.outlook.com [40.107.130.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DAA51A155
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902539; cv=fail; b=jXs89j6q9WQmEFY/idXzp46fwNMG3A4lhnW0Zfz/mVTtcTUBbk0DBnp0jdstd7VUPqWr6ZVf/vE3vLSOaHPDomFFSoH4I6HjzvIfIfFeuk+TcteNjC5bKnpaBqW83EBLDoQAEw3k5Cdk6+M6Ydkqa8a69hbK7taPEn6eR8ZLmTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902539; c=relaxed/simple;
	bh=R5jLNo7i1OSaeMjZWQNcyczmX7OgLGiaw3X+TzCwLcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pNSJ97kaL516eYP4jqsAgfhmyTB49aG0dXT4aaZbyMXTonXMtA01kQdso33ekcI+koqKvn4z4mSxK5X2bkPEaBUVpdLCi6/RPC7M1P4UKtk4UsMLGtiG/7pI85QIAOVId9vlvoS35c3xl3uaThOSymztWA96AqrFChTq3j6kxkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DzwjwxKq; arc=fail smtp.client-ip=40.107.130.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DzwjwxKq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikpENghz5S0twcCcDkQPIq8ay+QbFXaHsZt2y3O6Lg6+SF696o1LYdHEMm713k3XmHrZsQjwetKsJ5MmdAmyL/NfBRQy+SumoSWj5PGjCDJGIQMWwa9Vq2czr0fTSFFZ5iciZJmJzbhAreM8orBkmlZcKnh2n83eCdYIiugIPDbD8BGOHVb8NlAQ6SKwbm2AzXdCVYHC5chSlfotmAPvfrpPF+Bb0nldt7SdgWbZ0WvmuaEbzHX8zsA8+rD9OqGRhRekJAPbKYpGgl93Pz98iMeErHyonNBL3JGGIcouA9TUacWXirfd+n2sbJTed446PibagM1c2NjIo2KXs8ZV8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vq7wUf1WNpA6fJb7BPvA4JafCZuJwSBobGRzAX6tisc=;
 b=U5zfil82A6vS29R+pixArIPQso+56Q5CbgsQInpXp4jpm3jCC3FVFtwgEXPS3+nJI8Rzpe0j1qwp7SBo8VQ2RVhw79e7dg4E9wffm37mFAPY9pCFQpJB71Tp9+qMsonydq4Bik/HDeDyPtlVKS8QYf3BMNrVdCGW9lkb3/KeyN9TeKtk3MKb//t8D4tF5psCuDgYNDQB6T4ZDUDH5yhW5CEeKwdnhORaTx9AgMNWqdkb5gPvqkZwUYYLXFRjO3ulHP5dR0W7l/hN2F41B+IOLpVXdQJKhYZsx5zjSc8hbjGYO1IRnEh+rMw33TCcBKO8ujLFuFWuuy1bsMR7PiDfFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vq7wUf1WNpA6fJb7BPvA4JafCZuJwSBobGRzAX6tisc=;
 b=DzwjwxKq3geJFktzQxpw/7pBgx3T+XDNlnDlyW7MYSg/2eEDf4cQ8BN0cEpIl72sPhpIlqpb2Janu3Vo0o8lmq8+w74rAaCseOONfYCwnumktK30ot9HTAMQJxDo/TJqC9ku8xBfwxLPzwXfcoFeKRSifhjjyy9X/VwlvF+YsC4I6x4k0/MdH5OwEsw4yUW8uOitTp2IOc5S9yn3ORWei+6zDH/GDvRvfkDhXxtgAzrh+GzH9emkbKag4gyYVngKqO/cfrmL3NKqh4Hdkq8W6sE6CfF8MUp+0wjhPcBs9ALFpcOp5cH+GiPH5mJwJWt4kDC+33sMIeRYshn2IJt9jg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DU2PR04MB8983.eurprd04.prod.outlook.com (2603:10a6:10:2e2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 14:42:11 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 14:42:11 +0000
Date: Tue, 13 Oct 2026 22:46:28 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>,
	Will Deacon <will@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v6 5/5] iommu/arm-smmu-v3: Wire up shared-SID STE
 ordering and feature gating
Message-ID: <as5ERENDfgC6FB0b@shlinux89>
References: <20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com>
 <20261011-smmu-shared-sid-v6-5-cb76b89dc612@nxp.com>
 <aszfVNP6DGzWYdK0@shlinux89>
 <as1zR1wc7ERxvR1F@nvidia.com>
 <e8c22eb2-ed1f-47c7-b2ac-c56ead1cba8b@arm.com>
 <20261013124400.GI14213@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013124400.GI14213@ziepe.ca>
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DU2PR04MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a5c974-685d-461a-eaff-08df29382a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|23010399003|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EkAEKXUtB3NmDtT9IibWtno6ZwBB6l5lAwdfHB4jE2pBccpxQGlkD6jODzxpqZGO1hWf1HFY+Iy25l14inupobTSTiJufycP/6D2WPeZwZ3BhU36Yj9kUo+ZWDLlKgztiZe3ZfQBBUz0fjeHqWhMkysM8Ksr7TAr/o7vAyfR8QmRvsIfuobEacm8BIeO7wusZsIonUZ1vKvLpN3DlNRZbscltyQ5KSLYb/Z/gXqJHgrJfPl/gMStXukLRVogI13lony35Y9hTa4qA1wjIjwzhnk5zc4450Qsk8ZMS6X42Smshw1AyjB8PJijtg/Ubim6Sr/BSWprNietppdK+gt16/geuILyal6Mgw56HfeE1fbvVj92NrJPtmf6wYIchdGbJeDYptK1jsFaS3ysYg2LTpD6n6ihak/X8n2QRxLq3bpo3QF18liOAeLr12rRnF4inq0NfNd7OBJ2/tyXK4bWCKwlmy0zPF6Kpv9Jy+TYY5R8UuBFQVdd+y/HIU3CeJsFR2Z4+kpELpnH7DkBKXN5BAwOFpYvTZOR8uV2kHJRpu/F0rAX6ZWg4rFGf1Uo2e5AIp8wvoaDXDc+VdT0FS/1navAHjsnjVPODKMUXsujFQ6vAE0tH7D+BvZbjEY5L2sYn7E922PjFl60hI360Y7IYR9MXCfT2//6QVdVk8dCFp4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m9vNcx7GP96BYF0R0Kynt4UiIsRwN/RPPLYDh8iDIT6fPGo3N6d7aM9Sm+MZ?=
 =?us-ascii?Q?yMDqO9k1VtTrMqauOAu/n2H5WKHwmKX+sT3RjOBsxVoNBTcAMu4PhK9iC3w4?=
 =?us-ascii?Q?+0vP34yaGsMed5FHrtA1WfIXbnwVv/ek+n4kUMQ+b25C/pA8zjJEBIXb+knA?=
 =?us-ascii?Q?XoPzgbJuUEvJhvm+6WJ9+24TOMF/qiPRjhp6oJW/wGMZqHiFx4040zxbWxgA?=
 =?us-ascii?Q?niNPQ62b896GzzVCdyetCrSOl87k8ylNjJQy2A/wCEJ2/WDKVvmSZelfiRXh?=
 =?us-ascii?Q?sJdsWepBvvIMHGEXGWH2VjNe0HkmpZzXLIH208KdlgTc79Kvzr+rHRwUcYgw?=
 =?us-ascii?Q?UQa5UFGDM9MGFfbW3XTYJi7jpxojyAfj2f56NWTvmkgMSokFlOW/cBcUReqk?=
 =?us-ascii?Q?BXwxHRAp7suzZWwvsTfAyz7LRz43Tk/JNoXLUb7R5Ghm9tBKA/+RhpNArms2?=
 =?us-ascii?Q?scSLmg+4/K6x/HD//5F9bGippg+7Jo8YD2RaaXMDpVMLCYhtWi7Cgx+oVrD8?=
 =?us-ascii?Q?f3aCbU5GthNlR54nZ3VIHpiiSs3VXLgA2UdBwuqZxWJJDxqmMg5r/A8sqavd?=
 =?us-ascii?Q?k8iEhSrjqUEPhF1nQcxw4ReVCT+cPihh8GbbipYdhIln8LJFJ/4f6XfJR4kV?=
 =?us-ascii?Q?8KSV0KGw7Ykq7DannRykY8QnZMah7+SpVpS5Px6XNf81PkW0UtwP7OkEd9uL?=
 =?us-ascii?Q?iAWr7bHBaVtQ+h3t2wJrOMqPjZMpVIVWPNDMLPUJJdH3jSXbqBskxcmO3j+0?=
 =?us-ascii?Q?cNBS2DR4XxMM0UwJm2/uAxBAEC20Mo9FnPO7+2gXnCRMFF4zk3g6X709W5r7?=
 =?us-ascii?Q?xrWm1LCXC1ohc+iqX/y5mKY9vXgmU/BWrsPaqiJYCcz599sVc1H8vhtNBByD?=
 =?us-ascii?Q?uGiP6KpfQql0+dP5RvSi/iID7mdZk7ySh6rMRe3mOT6gWflK3mHtM1CJtp0c?=
 =?us-ascii?Q?yooICYxOK763s6mw9HEfXItyOgTfzD8V1h4jwaARKsuntii4Eugu4rmbKqzs?=
 =?us-ascii?Q?lfFaIqK6DKk+7Fv0Ujk8CfnBc/r9VyVU1DLmQzApzK7dydUsiIqIzGhmO/b2?=
 =?us-ascii?Q?T0Z9jbA8am2JJs5H6ZOHuz+IGyN7I2QFDFAm7LNpJX6Tk1h+W4J5DrKp/rMi?=
 =?us-ascii?Q?uvnMXyw4Z294lNYGXPETUK2T7HMrI8xUd0SU75XvZTOjLCGWcHJwUGYjkHMg?=
 =?us-ascii?Q?VSh+8sVNqeKjk9odtxQl3uEZy1fTam8wm6piEiOGrGfToqV3r/wsXebo/bix?=
 =?us-ascii?Q?5jBHoBH50I8/VhqyBKQXWJoYGbdlWsFsd8CZWG6QxQ+1LUtGX2OzoUSWtc5t?=
 =?us-ascii?Q?jm+J0zf0q4CjC2QGhnN4t95PCDEkCQn2xaKe+Ie5bdZkKEJcOeEjagj4VRcg?=
 =?us-ascii?Q?O0RLKzX8MSHj8p0WzXNOecOICp9Xkl+8pBVauY943I3UfL7Ab6m5DoxNqIST?=
 =?us-ascii?Q?tFI9nuZqfxmfL6EJ3kMmimNUlAIQXhDgKe8qEdMaOR9+lkwBPc7vkwqdjjWR?=
 =?us-ascii?Q?S78PpygGe1wY8csMhRD1TK+oODp1GptuhS8d9BQsNPkdlepE/yVvAeiOJ4A6?=
 =?us-ascii?Q?u6F+i2APlLpc8ZPtTWrsA65xqni4XGCJ2IZg80kc2VJpTEu+MtS560Rz8T3l?=
 =?us-ascii?Q?QxOnThigCgK0S+O3Osp3kG36lYW/VvXDy54bYf+gN5X1oVoOomm5PXXgHvks?=
 =?us-ascii?Q?ecvgUInWcaY9Y7rkHpaJYfWWGkyDNb0tJEQhwZAyTZiVUQVzeT+heyZEdwxQ?=
 =?us-ascii?Q?U2d1rveNi5x9Vkl6OvHRqJ3/XjwnDqC5KV754Ce0hFpGC+aa0slX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a5c974-685d-461a-eaff-08df29382a71
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 14:42:11.8352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qEFUo6yYmQqZ/Lpd7Fgdmgc0B35DrejmWdmEkH/8lUu81YqUdQYXbTlUbCBmh3IFIhF8oXsbHp5MSDU20zRfxWyB9uC174RJ8+AME/I/FewtPGOW1zrunZ8qy2rqKGt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8983

Hi Nicolin, Robin, Jason

On Tue, Oct 13, 2026 at 09:44:00AM -0300, Jason Gunthorpe wrote:
>On Tue, Oct 13, 2026 at 12:22:06PM +0100, Robin Murphy wrote:
>> If we're not going to support PASID for shared streams (which I suggest we
>> don't...) than we shouldn't strictly need to worry about CD tables anyway.
>> So rather than having to special-case CD table sharing for shared streams,
>> perhaps it might make sense to generalise back to a "default" per-domain CD
>> for non-PASID use, which can then get switched for the private per-stream
>> cd_table if and when a device does enable PASID?
>
>If we have stared STEs then the group becomes the per-STE data
>structure not the master.. We don't have any way right now to do that,
>but it would make some sense for the group to store the shared CD

Thanks for the detailed feedback, reply you all here.

For the CD table question: since shared-SID masters are in the same
group and always use the same domain, the CD content is identical.
With skip_shared_ste(), only stream->master's STE (and thus its
cd_table) is active in hardware.  The other masters' cd_tables are
allocated but never referenced by the STE.

I see two options:

A) Keep skip_shared_ste() and add arm_smmu_cd_owner() to redirect
   all cd_table operations to stream->master. This is a minimal
   change that works for our use case (platform devices, no PASID,
   no domain switching).

B) Drop skip_shared_ste() entirely and share the CD table at the
   group or domain level. This is cleaner but a larger change.

I'm leaning towards (A) for now to keep the series focused on the
simple shared-SID case.  Would that be acceptable, or do you prefer
we go with (B) from the start?

Thanks,
Peng
>
>Jason
>
>
