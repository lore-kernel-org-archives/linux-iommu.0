Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23C01339A4
	for <iommu@lists.linux.dev>; Fri,  6 Jun 2025 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749230129; cv=fail; b=ZT+ktwFg31q4f99vOphMKJA/Qr0zaz9XaKkEF6qsTuXw2INXxP0JdXiVbntAM9GWue6mfKWSuL69GrvTXqi4kZ8dDw1zY30aeyybLMj2h4Q2DtSUgaXgPjiQ9W64LX52Ep0zxNjAmMbWpidEg9Y4IqcL2BFh5wVmwD/Hw1jXX/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749230129; c=relaxed/simple;
	bh=iYrMdvdtQkX2tWUgEd8VB+QIXnd2shozY7pTaV/2sSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FO1qOUgWHj7CVEj4CR/M60CzrzlGNLu2I59cmDSbZn8EZnOXdC6NaDUI2i1DDiURuzDiNETTlUjt6JwiX/tQjHDg4MSO22EoYecEHKOIs0OX5ouUW1XqkcZZC5HGZDqUpiGWRVG36B5pa769uauPV1VqNLXUUyjCYETH6k6aDUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sa/G1Tkw; arc=fail smtp.client-ip=40.107.102.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sa/G1Tkw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjYT0+g7p1G6IiSINXqHqIk6YfEiIS5OKrxTqEWg1o7kLLefNAPAYOo0oraBKTRD2omo70POLILQ/HzA9hS20YMAHDa+dH3JDRGp79u9Gcq4NqJc2teTFt6WTePMbRl+LGJ7ssXKWneWvQrUsvVExOdNPxnKoZY7im4fpEiSnskZKU90QDwJMhmtX6GvR4xyvumQ3K7UNsl3gfJmHEqAEDH10cmyTT9ulgQ2fhhVtVdYOFsD010D4TDR2n18DM7Qtf5wZLbh9Nj63hgFj57Dr6stwT80sHxVRibA4bOmLSPMsxvgvz9W4SIPmnjLiJR5yEHfHy1H0K4YGv5MNdv5BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfB11Q4cDSp8B3Cb9kI47qEdHya9GyK47e5U0uD5qPs=;
 b=S6atnmzoYEQLEqwIl7FFDiDFHlB/9eW/ygnfyJ/axcWJyLIXGd3awpJ+raSLJuWJEtvTc+zPJPDyZ7I9JndntZ5Y8myh8uixP0dB+wa+qPSENho+tPPtjn13fvglRKoAqIdC9WWJaIjv8406tjKbIlcmQO6JfmZfgzKNcb3yPIXc0LwaaKYbTXAf6XfWJYOa7m8380sAulFaH3IIhbHdxpXyh7TajF1mnYRAEaYVnt0ax9VM/k3qXmUTWPOxCffu5NFQyGClOahYiTtEKkpGysYCSS0ytVWSMuthxObRoGb29Zx40GsbqOngoeGJ6Zx49LUoA6zHC4Zz7U9zEYsSeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfB11Q4cDSp8B3Cb9kI47qEdHya9GyK47e5U0uD5qPs=;
 b=sa/G1TkwhBdGl+kf2hv4YpIdvcTHFYKo+K5m++nAUdbyR+7eh5vBzzjRyrlII8G7vs6hbbj6i5eZeh0jFT4TGccMmowN/t5YHZbfyWakV+UwU6KuGFCHjD6lPWYOFpwYaZcwaVx/jQBO6v5YlmMsY6rub2EDkHMvCi6DjsNnkPitA/QQIUPBfDYFjmeotswUN2Qijy3sB1CY5JnsPuLVPCd9gZmBMnVKtgrJH4/ykDgParP+z6ZdI+z226QHmFR1PbdNlHZxhOfuI5mrbrxGe5TVMhjygQtaALg5NEozsu0f6v5jRVTwNqAwuKQk3MRVTU5vwaE+tYnz9UjXgt4LRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 17:15:24 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Fri, 6 Jun 2025
 17:15:24 +0000
Date: Fri, 6 Jun 2025 14:15:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: baolu.lu@linux.intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
	dwmw2@infradead.org, joro@8bytes.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v1] iommu/vt-d: Remove redundant SLTS cap check for
 nested and dirty tracking
Message-ID: <20250606171523.GJ19710@nvidia.com>
References: <20250605101052.955174-1-wei.w.wang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605101052.955174-1-wei.w.wang@intel.com>
X-ClientProxiedBy: YT4PR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9f6a0b-146c-4b48-aede-08dda51db978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2TZqb81642Xg6C0uPYsauiRDvwpD37DY9uwtbFhc2yRSAy08Dj14PTWMXkyo?=
 =?us-ascii?Q?ZirHregPgxBpa4Q3ssqA0fbY1EHeNsK84e1jDXXFScsj8pp3Vkkoa//3TKTt?=
 =?us-ascii?Q?pjUS4X1glMSf1XdotbJHuIpJPVZsuDdsLKd6FiAYl0OKKdjFYylrjThp1Fdp?=
 =?us-ascii?Q?LSG1bVRrZMUiN8CjfPCxD0wkh3WZMaMtEriAYrf/U0X5DLNlXP0y5pCoCjor?=
 =?us-ascii?Q?ZvK0VCfrcfHkxk+qGqeHy6/p1cHr6AbH7wg5xuJy8IQLfwE5PJzNyspm84dd?=
 =?us-ascii?Q?uAIKgqt88YeVFpmc6pQoBBI/v/G9DGagrrYCOzZh7TwqM9lyFQe6QZedtJQY?=
 =?us-ascii?Q?YV3jDkfZhH8myx4CerDViPq1twrvfqetuFTIISolwPzZbjoepdFjcazsQ38m?=
 =?us-ascii?Q?s9vukkxHbMs1zZeVPzV9Z7eAiy8FNnpFDt7sr8GP1PyP2YSs+NSdi7ojSDr7?=
 =?us-ascii?Q?pWAsXELtb0BT7SU6QLslcDkwfdWKtyutkjdkUrGRda4UjOYMhizNbhZgcVvc?=
 =?us-ascii?Q?hCQ8x/rdwt0nXVf4WNzZv3J/yzam6OKja9HhdBbPJ4q0pQDB+myFGYWiCGfM?=
 =?us-ascii?Q?7qAsQ6jEUa9GRh8NxiMuAiV33da7PuecvixzlCE/lIIccR2iiyYD3m90lji+?=
 =?us-ascii?Q?gIex1NhugNWk8KrtrplKXeFEZ6+Ls5CFtLZ7R3AZsTMDTF52vWC7zHkkWn9P?=
 =?us-ascii?Q?ZR9Ti1zm3Cop3oPOjZOG4FTJL+ZQZ1Etonx27d9cauNgFu70w4HquX7DGbj/?=
 =?us-ascii?Q?lEkP32pI56z53DUhHJd2ZmDdjyazpFXrvfWVGIdmzRkjrMvnjwVm/dUHH1C9?=
 =?us-ascii?Q?Vb7w7oudPg9Twr8ms9llYQTDJr6QWMVXQ4BSkz2yxA5pXrSBRfvJPSFSNeX3?=
 =?us-ascii?Q?ZUY8hO5FHUS6OBEMXZgtdpQlT2/CKFTeSBkWfpHSM50Iq0jgNVe2WO1uoUoK?=
 =?us-ascii?Q?R8e/bawSdY5b3gqKEGxwSu8Q4WcJid/wx7wVLMICEv18mASrJrmCcgXhBptc?=
 =?us-ascii?Q?/cuslMcX9rlz+3VfNcFhA45CktaehoO17ClTEpGiL3OwaKlSmVo6OeL932Dn?=
 =?us-ascii?Q?jzAv1siWUfEYrwFIqE2c34N/N5BfzMaGjehIvE/PQuwZrhAttb56ChQRhZia?=
 =?us-ascii?Q?YkewS7uQi0+hcQI/3w7DosAJGsi02zBX8kejP2Rt0jjCJNwHnd2GwgOq9+Ip?=
 =?us-ascii?Q?r+mu8fFct+kvIeaVR4RbzaMCUcHbkvZfpbKXLK1gimpB97A39i8zEwIo4/Ec?=
 =?us-ascii?Q?CBxBbGLpjIIAlq7mto9yiu5WSWhIQ7vjvEuYa9ajPBhLx358K9ggh4CDaVhL?=
 =?us-ascii?Q?b1Q1X1FhCOu/osnue26hRN6BFqRONmP04sgxtvQrZ9ivkd+spVrK02cZavo9?=
 =?us-ascii?Q?1PoWnlT0+wEZecyFdl/L71q1WsXbQJrtxUaHlnbzobPuXVQ4kHdsaYL0HLZn?=
 =?us-ascii?Q?rs500+DqIQw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T6oHv4lcFotmfs9mXaUUZMVQ4OIuMD4eb9ij2eU7kO+XVNoR4NK/Wq9yVc62?=
 =?us-ascii?Q?W+n80Nzju3Su4ddEMl2SBZWYD0HbCbFWoxsWCFyH6l3NySfAYVYMXM4G1wKj?=
 =?us-ascii?Q?xjcoiaWDAsLLqUt05v7PdqNC/o1KFcfh+vxDgY1TyCUz2jBj/wjuIwfvk8pe?=
 =?us-ascii?Q?K+NnQ/sOFG6NPgzrRMl5GbRfnjAk46LNc/VaKP7l11M6EN6p+I2W4qk1143y?=
 =?us-ascii?Q?s9wkQaCsLfXDiyYZjs+UxY3qzcJrslLcuQlUvnK1xGJhPPGX/9kw+O/D2HVr?=
 =?us-ascii?Q?Y20WEC92j61Z7A0zO5wKSXA5V49i1nGXDtulJGrzjRrFSorjEKBHVh8Z26jS?=
 =?us-ascii?Q?8kKkNBYp5Xp5AYUYPihDqMD1Wn6WYjpzcM1RDihEjkEWCXi6kT86zcuEtlJa?=
 =?us-ascii?Q?wlR3bQfHAx8CZAc/Wd2oNgbU6/KFggxJL0f2nrzYuYOF3q4fGGs+8G4QOWtX?=
 =?us-ascii?Q?hh4vJy7G1K3BYPpTYuSIS7Evcw9EFWaMuNFiLpbHNQstHIOcgI0gHvIjaJ19?=
 =?us-ascii?Q?unUF5np4Vdn5RTu92tVUquNBwi+7Q+WrACv1w399ou0obH0LgY32IeeHwZR1?=
 =?us-ascii?Q?gHXD67tM0yDTsiZdwYyDekhAbPPmcFtqKPuxidsohDLuQZyOy8yBNv2Fg6IL?=
 =?us-ascii?Q?wXr2XCF9ovcUxa3TszXnXtnZ7CdmiB3AXb/EpfYqanFLGWPOhvrYNwyUtS0l?=
 =?us-ascii?Q?JAJsoAGYcbVn2k/N6IXd2kCYih86e+f7Qjgn4TSFs55U+TlNnj0Agrc9MVz9?=
 =?us-ascii?Q?659WENBT20u1jU/ms2afm3rJHssfdC/jP6NgqWemmT43Lr56cnlm2IepBiDF?=
 =?us-ascii?Q?B+c405l0FIoCeCqB7y/UGcY4P5ljAZ0iiETluJgZpLw2MNiKd2ZsZw/ID9Zm?=
 =?us-ascii?Q?cq0jk4GS3EW69t/iTu+dgTDJWu9EIRlQegeV8B6fQ4A6Fp0MyrQNbK6WZI5q?=
 =?us-ascii?Q?iYLoGe4kbglcWsnPPpjZyLFbmXhKG0ke2dDi7qW2+8RTS9do0dTefLUGX/iW?=
 =?us-ascii?Q?MNEiKHIpO1QduPY6g+hbWa99HpYtf7ZV2B8GJvbOZBSbtNEComxVu/VAZHNc?=
 =?us-ascii?Q?ApwATgS+baJ+1O30KGhRf6aNlMwGUTy5WOwdYWU4UHnMMTrjgVDlmg8WqPtY?=
 =?us-ascii?Q?jIzTnzaFxGfISwuEpx0jYo8CjdnC7MNgSLO4mcG38/SWcc5JYHtLcWD6w4Pi?=
 =?us-ascii?Q?agIE9Z4Smi+vgcL/gxK8UYUqWH+IaKrGF099L2WsiZjHTbxj/eVl8L+uHths?=
 =?us-ascii?Q?qkVqBIBl1w25kLHMgSvGiB5ClAcYYhI169MDvwRFXPR31FmqE79JLPEEp5Jg?=
 =?us-ascii?Q?yJP+5KHho05MMkvjkqmit57o8bik53rhGCZY1J/WJQAi2jaIQaIaH87fU7Lw?=
 =?us-ascii?Q?Gz9oIARYWaDifSAurSfzNvXOngVgR0BLfh45poPLHQ41+wfVZ3CZk5mDFroc?=
 =?us-ascii?Q?3qz1Iqw02wFnxpCFuLFYMVlZBvPHPOxDLyzb31J4qETMTl3SJg8KopK+9Y5c?=
 =?us-ascii?Q?b3bnqgT8wXfXLvZTHC40vxX0L31psiRmXlFpcLHG2sWaQ3HVlF5TqXORcnnY?=
 =?us-ascii?Q?FCKJl6zBklGi2IOdHXQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9f6a0b-146c-4b48-aede-08dda51db978
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 17:15:24.3138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEy1SzWi4hRkaoO/FjdSjaf3FTuWHmiYUmLDacsKNgpqgJoR/QvVrNq5zMyxje9D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232

On Thu, Jun 05, 2025 at 06:10:52PM +0800, Wei Wang wrote:
> In intel_iommu_domain_alloc_paging_flags():
> For the nested_parent case, nested_supported() has been check earlier,
> and for the dirty_tracking case, ssads_supported() has been check earlier.
> Both of these imply SLTS support, making the subsequent SLTS cap check
> redundant.
> Also, false-initialize the first_stage boolean to simplify the code.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

I'm going to post a patch that fixes this (and the other one you sent)
differently next week:

https://github.com/jgunthorpe/linux/commits/iommu_pt_vtd/

  iommu/vtd: Split intel_iommu_domain_alloc_paging_flags()

Jason
