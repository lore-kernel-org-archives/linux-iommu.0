Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074DE1F5E6
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 00:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736902452; cv=fail; b=DbotScy922bBiUUqh/M8Y/35t7rg4DWfrhRvdoM/pdDwl/dUsW1LZmlcdwAiOwHvQGPRdgKQskDze/aGGCh/inn+gAG0SRVfyno68/8f1S2o9f39CCpo6BtyogqUG17spzU5OuV8Ng5hjaTw86TdBvpqF97F9CU3xvsuyJENbw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736902452; c=relaxed/simple;
	bh=7Oi/3X6QM/tLMj3DxQF/IoYNd+sp6wIZ8Ff1RCTtokw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m+kY1YF4NFeouKrsDvTFxwOL+NhYipoLfAXDaLcv/ELCQHzIuiSeddp0D8JnBPB0XVlzHUCbZN0Rr/6Zn8R5cjE++VBYMlBB6zJTeHix4XfcIJq8vKqJO/6FKr6MCVBLTZS0hMdkavK87fwv3hCCwXTseecIdXqDrl5GnLd7eZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SK7quCAR; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SK7quCAR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZ+KoqcIcV9yYA3u4sj8ftofxDXTk89BMj5ROiPcLfz9Zyxl/pkxTtgklywwVEoe6gZvQOnZc8skEaJvIzwIFxms67LW7Bu7yJ5mCzWeClMR6/DEjpPoCMlh8PHcaBF59onAZYefPW2+j3kVUQKE5VDb8IZck/81CdzzK0VVxA6pRw7AyAVFUe56zsMdYRVJADGHGyG64AN7AaOj9oLcipKtgbJJimATbMvFeQW7pTMLt39AwUpKe24sQlxzrTnzxoXwi7MScbNiHPGjbqspgEQAcLK+kfhQHoF009aCvKMjTJ6J/B3I3ItTxMBZAiVLI+VXqA1Hxau2xCi66qnwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQFVz0PsIebkc+zUlOI8HBMeiGnJUM9SowUqyfUMnA4=;
 b=SXi06KjmDJpPAjxfmHDWysQSw+T7yLCoi6YrGTnACtwb2v5sLExFAi2QHxMz5VeCaZMTPUgkgzGmMv22kj0rgdE9PVY7K8lR+Tinpnc0ra5yCl2Spk2CBkcpfxfMU25wkgsXYRsTYLsjj3QZigK75Fcas1zw0Q2VKNB2s07LcjcWh0ULpkFrSiYrKINKnXposJTj4cRnFKZtVpMAfLRFUj1LUtc9mKj9cs8778sJwWF+QhbSK5NrKpqmeQtKqkSt/sdmZFDf11vfftBEWwYaDXAGEbpA1VFzryREu8MzUreH6D5URaRcMPej/NQew3CaGgnWE2pFp5V4FlSCx+Nk0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQFVz0PsIebkc+zUlOI8HBMeiGnJUM9SowUqyfUMnA4=;
 b=SK7quCARPtX3PxtGZ0Jh+ENgZHFkbdGjNGYLOWBCxoLp5jnBlFI3tFtiiYHNdK0XT7GGyd4+RZvb7P5St4xk2IODYMCiC4/e59EuoQkawTiW2J+p/kBXR6J+s1zWjDwoSFWm+LS48iVx41jvCB1MHWFX9TeScDMFZ3O2pX7VOGxYdda8onsVTRd/FHtLOkhENn4L2FzgrevTMhEYPDsrEQtCDD6QYxqsmI0Lb5rzQxhYe+Svsr1gYyaxFBs/99UgptnjEjZpkbIArnMo6qwkBezrqH5M+5xTjtnCAL/HDCT56ZCWVIlN6xeg6+9HaTOG5QI9YQnEkAng+LMxdn9O/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB6295.namprd12.prod.outlook.com (2603:10b6:208:3c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 00:54:08 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 00:54:08 +0000
Date: Tue, 14 Jan 2025 20:54:07 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com
Subject: Re: [PATCH rc 1/2] iommufd/fault: Destroy response and mutex in
 iommufd_fault_destroy()
Message-ID: <20250115005407.GK5556@nvidia.com>
References: <cover.1736894696.git.nicolinc@nvidia.com>
 <5e78ecaa3f731c782785de7b1aa5cc535f3cb0a1.1736894696.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e78ecaa3f731c782785de7b1aa5cc535f3cb0a1.1736894696.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:208:32e::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc7ec65-826f-45bd-2196-08dd34ff1deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ABjRTRLePRkEHkNk9S94mQX+8LyyJQsiKnbStvjILZUWmWKYHNkRFQ/1tc/L?=
 =?us-ascii?Q?Zd0pFsul3TN0TmprDvumYBf3b1jerLaIWqPeH/mc/dvTRBRfISJVfgvgHDTE?=
 =?us-ascii?Q?hn4SEe72Xk1FfNID8UbIm8UTLdbCX2zzaXNp1e+OmhPL7hPygXvKuvrjqoPR?=
 =?us-ascii?Q?c60YPENT8oZmZBgiJGIb+HoWMwQ2jHBnpzMw1xsT2OPEc2Sw3S03wNlukN33?=
 =?us-ascii?Q?nrhduZAnNprWFP+v35yCNcmGJmJXccVeR1+sVdt/dcjG+snFLbNrA4kHaItu?=
 =?us-ascii?Q?FP2DzGVzQbWHMYZHkMDnRQFXKbI7dXOWZVtHiVQ0zIvTm2sAxVJgYDtWgZFB?=
 =?us-ascii?Q?xjv6a4843Rk5Hd493DVbjvYCl5xQ7J8rbNUtMCCB3ddLf/7aTZx+dKiaVo3r?=
 =?us-ascii?Q?2iNG1WxsoAdjzuaPxMr6A5OnOnHMdciF4IgsdI4HQ9rMVJj/DBbnfuPiZVci?=
 =?us-ascii?Q?CKhohO+T9o2xXniSht/i4lYPqE/yaLozVgdqmmGy9fwrfWF4uV9QxdnSC9ol?=
 =?us-ascii?Q?SsjbjWfub6a1MF0P3evzeEvFZFe6arU5arYtc0BkjS+q24GwDilgYP8V0AK1?=
 =?us-ascii?Q?+xCkbZMB0N1POxm5+oXoDV4aUgoUnexqMZR/gMrrLSyiXXobco91oshh56Q8?=
 =?us-ascii?Q?/tXx8DAt7axhFWonDQ16zjq+yAix+fmTTubiAkz1ZwAmRKd/ASCuS/eXhx9F?=
 =?us-ascii?Q?abj8EtZM/FSb6iqZwpU1QRQ13ywqUqUmqz09Pvt8xloQLhMhzXxQybyinJTd?=
 =?us-ascii?Q?Av4plCAG4jPH6xsbYoJ/LD7V/+8jtTQDgvpTC6zHp80gecX+VMmmfZWKuxuc?=
 =?us-ascii?Q?nFoXlDdNKO67iSqKO1JbyvlnLAECYuWxYR34uQ2Lic1mudMyg2skLopEaLlZ?=
 =?us-ascii?Q?bYJYzdq6op5B1kbx0K1c7Y66b6UUupXGKSkULFauCfPKoCwECDCpxnxMXU1f?=
 =?us-ascii?Q?53w+7m4+Ni2B5LZCv3NNHe7wKjCbaHx6MxHj+dUxjAzpduE5Fb/WK2TsUILp?=
 =?us-ascii?Q?nVAuVnuNoieR4HUOCx4a1Vp2mmVaFpXKTsq03OC5YnniuEyGvGJYTFWVl80W?=
 =?us-ascii?Q?rl2vvHFL2DTh86XBtJee/NGmSie2ik57VM++FKUI/NClkdn+psAxCvZaHdYN?=
 =?us-ascii?Q?lcRLVQzRUkx5IAJJb+tOngkivCM4EW8Gn69hAlxBe391VJHB+s29St+3FyWj?=
 =?us-ascii?Q?i8C7QLTNOiMXkNuAQYULhv72nQjAIlW1UVLwvIBby5myagXA+o99CpaqViG8?=
 =?us-ascii?Q?LguUbch0ERVwI2clxEgc9ro9D1N1vpvgBsJX2L32IpPmupsIFmM4EfLw8roo?=
 =?us-ascii?Q?F2++kotVy7W7WK5VWUsQLPiCuLvPOxd9tAND8+9wsRBaYboWd4eY1oqx6AgG?=
 =?us-ascii?Q?6vC8+nuwg2Xxv8PQ2p7+jBVADw0I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eHh/CMh4O/3y3Rg7gWan82GPFniHtBN29/NLx9nVYUp+zcWusBaqlpQyJoZC?=
 =?us-ascii?Q?vezvubx5BdP5Dv3MZA5Jxl9gZ5KfJqVxpV0ljno7sSNlKyJRXMsQaouLULtD?=
 =?us-ascii?Q?eO+H5MNLInns6sTObp2h7pp0ikA15AjpGTBiJBVtDJmg1EH9C2hl/rluJ5db?=
 =?us-ascii?Q?ZNVGwPahITGNIxPKhgvcxDEYM4P9z50Ofs2J6nCCBkDnm6HX5H8Ye5sMSJPh?=
 =?us-ascii?Q?MsJDA1Vevc8AnVOQLvRlVNboBel2TCd/O+FplsX4XQ+M9wZ50OsLhAIXYoHs?=
 =?us-ascii?Q?j07z1AHbCVrc4CyGprbOA149C/sVeoUcCNhe1RRUXBBqd8G3SMLcg9xPhzen?=
 =?us-ascii?Q?EAilvtInpSIgD9lnGNCE2mVls6nZ1r71HjTju6PdLLowaSy6eAMNMpmGMJY6?=
 =?us-ascii?Q?C/Brjg6SW0Ngv7aXtHH01N58sNSrcGiGj0G80rKE+vF241iRmSSTKAQlV/X/?=
 =?us-ascii?Q?nNylc9E2pAiuurOf98B7R/dr1KxF95jMEdO52YJZzlL58TcyNg0QcN+RtS5Z?=
 =?us-ascii?Q?0HG++8bHSYTM1SIHrD/Plb4Sgfjp47IdnnV4ydMbt7iUsPGWQ2K1p+jbgf5x?=
 =?us-ascii?Q?bPlh/iVZuwijj/Lg0D8IXk1WHxh87wvI8zz4WRkpkeuUNUW5wCyhtr67Z/+V?=
 =?us-ascii?Q?vAS1ffruP0wCWktCsmG1SdbxwR8zn7gTd9E1sejEfcg5GsgE7cjvtrJnWTOH?=
 =?us-ascii?Q?AarbPgaHbOxOsBGO7IH7jjy+NwQtHenKzb7xIfGWcJKRQQc1qGMeRa7bHwx5?=
 =?us-ascii?Q?Wzk27OIMF54h1dRh9kR+3Q/CbgSBXNLzh6IunuBpFx9/YAXcdlCHxVOb6yU8?=
 =?us-ascii?Q?Hyao/Lt2t82OwNJzJrzvqNtxs5OOuiOCqqu6qQB+vew2AXOzMBfm8NEwJGMH?=
 =?us-ascii?Q?RbKirBPcJuBUABfT5qLj41SuaAzcHuQ9373zjDIIOlHVuXJuIMKnvVTXt0xz?=
 =?us-ascii?Q?E84MuR9PtqwnOe8oCU+CUL/mEf6IMryLcp7IJ2asIHNNKwXLxH4ndPCFKBDU?=
 =?us-ascii?Q?7jndThzpWXb7gTjN/KTvDMgTZU3uxbWi/vI37no9KopPtiIEB4lEDzOWbA8l?=
 =?us-ascii?Q?wQrXOBXu7b6ejB7MFqSBoSQzH2KjxxnBxDcVXVIMoHfgnzfeIHCyRllUbYWv?=
 =?us-ascii?Q?gK4oKh5YrKjyNYsRKc4mIvsEn6e/6QMY138ZO/r3lwjKUcK+BG6Pynw0juJj?=
 =?us-ascii?Q?Ii7EQP69QX1QKvPp1XDnijfB0Soeaam2upLmoCFMq8egmN4Zs1PU3xrFZuzz?=
 =?us-ascii?Q?GUH1EplKA4ygkykvoBg3l5LyYNQY6EonsCtPHcDA9t4P/rz7CncnvqRizqx/?=
 =?us-ascii?Q?vYW+aFwuZYxBcEWlZ5H1tqWCQwgFPj1l0bVYMBglm+77yJEexVe4CmUMMuyI?=
 =?us-ascii?Q?qjdirxPxOcO8WP3yReb7XpYX2PTY9fYc2sGQNMmaPqglgexfje+Ttwo01Az8?=
 =?us-ascii?Q?ceNpnrkgYDAt/DFXAoNkX9SFL9e9OaOMEoRJEG/dJYSUNBRC5utYFtY3eosg?=
 =?us-ascii?Q?kj4DobQuJvES0Vxqs/OU45uMW+l8khBbw6Eb3yrzZJpxQbFy/QvGkuxNMIRR?=
 =?us-ascii?Q?mDfdhLqCxkzds2mDUCPoABLb+sCZKasYJn4/UTDm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc7ec65-826f-45bd-2196-08dd34ff1deb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 00:54:08.0987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EQfil1Xa7iwACzPea0CIONMgAVX2W+KIPCqYMHVYYgZ2+EcK2FkLCK9Jnl1deBG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6295

On Tue, Jan 14, 2025 at 03:28:44PM -0800, Nicolin Chen wrote:
> Both were missing in the initial patch.
> 
> Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/fault.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
