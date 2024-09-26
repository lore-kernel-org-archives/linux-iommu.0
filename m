Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A151154C0A
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380704; cv=fail; b=unZko7mn+dsTXTkb20zA+1awr+v1AyhLssH0d8p8xOC6Tji15eDh2bIYwuvmTXhcuf7SwCT0fFlpiTYj3AAtSJgIzu07BmSdlKHlnVFL0ofMkxSOL7FFDuw0BY5avtp4dFJmL5CsTTeC9K8YsTgGIG7VTs0A0UIgkHMR5S9M/Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380704; c=relaxed/simple;
	bh=rgfUOBYZLwcwIcz3/YXC2Myme+euXfZzr7cjH1VZzhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PlksEXclA3mwF51V26qnoAdG180Nofw3ECaVFoAds0vW7UAdh0/1AeBry0cOsux2em+tdwtp8cdDETgFCsL3k6Ztc64Ni71Gzp/srm9EIqe4NiV1sqsDJbMIVM+On3K0BvlESjQwfD7K2DxqbmUV5ANnzHR9QF2qK23YZnVmn1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p9f3isMi; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p9f3isMi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeN5jQpb1OsgRs03JFVwxDMWbhhKqmvqCG9KLXZhRwDigEinBvhv4Uv3fhAHWRUNwE5AveNK4Rcxza/POZqKw6ftm43p/uPtvRPJI8DmFVX/rhL9jj6Unbps3xe/xiMyIhFezStGMhvjEenKHyWxMvge6uUs0WuCh+wkckhHDOS6RMFCR4a2nrFaAkFOQ4AlSjB//TSDVCEOBCfUCOowmA6Zv8knj3008Keu8lBE02Yx8Ldnw56YrNh32EXnpS1xWqTUzU0uGv+rBFmoBeFQBvXOEh8dC46Ooz2ic1392CGZxaceVa8xGV9e9iGUCQEkA8y32pilH4NivwEfxqrLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/Ci8Lv4IkdJcFALGFVCAKEBt1wjJCVW5LkAFR8KAic=;
 b=P0a+jN1A6w540mETyCXKKTyrfe1SIiRPuyTtOimbCk+abzcHwtcwKC9S4ns1viDWOk5pDwr/pWzhy8dyY6fkA7MfM15fQXQX5C0KeH3H79Bkis5FzaN6it3wEh2bO8YMV7fVDd82azYKZLXfbLHhtp0l2OnzF2RLxvVb81ELmYbyIeTbJjrVL813PdIhOLCklQ3HJW+4uW/p/H4x+Ko8Mjmpm9rwu1bPVfnYokf+SxDOchebpzr8lepO9HoTnkVvbMQcjrp8G3oEtaRqsS19sV4V4qv81OjUCxnh9btuBWmyv7FCMi0h68t2wNSek8U1zfaAzSzGKnIL2UyvagUqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/Ci8Lv4IkdJcFALGFVCAKEBt1wjJCVW5LkAFR8KAic=;
 b=p9f3isMinA43HCLsr3ZidhCZldWcS+atBMXx2k3X3GSr4JpDscIqQoFEzpAjmAnzsM3+dHIkmJUjHuo2kIPCGgXhob0G4AHp8fv+dBtvh88q/2CpJ81KC7k0qdYQ8LdaNOPfugnW7IFq0O8uTIbUBpnC+vfB18m02MniyfImgLI/aOramdyu3wmVpZTXlb9L4IeTpLkAZGLri5GfoEO5KaOgIZMB/DIwloJ76ZYX0WJkKG3CowLjNhRcxmYD5tIYpXl+uIZx3Cyr/IZSgoql6rEyExyDectWIcE0ykOZSBknnEJut9zyDAfQZHhCTOO1YnhH6sV1jFJzlNL6yH0Bjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 19:58:18 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 19:58:18 +0000
Date: Thu, 26 Sep 2024 16:58:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v4 6/6] iommu/amd: Lock DTE before updating the entry
 with WRITE_ONCE()
Message-ID: <20240926195813.GB229871@nvidia.com>
References: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
 <20240916171805.324292-7-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916171805.324292-7-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: LO4P123CA0295.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: d458636d-cde2-4798-d818-08dcde6590f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hnKSvxCtq6Swvt4rA/9OYbmythsG0UMHy1VYvVREnBoos+0S7rCs6J/yeOyT?=
 =?us-ascii?Q?idiJzqJMVeWDUNkluIq+HF3YHIinHFdWNBECa6bWdENptqGwo7Ms2aRfH7sC?=
 =?us-ascii?Q?gMgzIfFw7VwTLnceO8Tv+ca/AMAokiWJELLDIaViOY9bpi7t2sGRaiGd8Pte?=
 =?us-ascii?Q?AzJrE+6U3nLH25WBuL8jKa/G/jFcShrIUbizN9VwmMgj2/LOJLRnjLPkDoNL?=
 =?us-ascii?Q?dC3Ko62Yu++QpAX4QldlGkTb9voqf8vXY84FesfljXyG7L0LrgRfbOn5sFnS?=
 =?us-ascii?Q?WsyRPz1Rn4cNs39ryaPa87B8mwSWRX6ML4Wcu7ZPKxhL7k8gg2QH+towRNs/?=
 =?us-ascii?Q?M2/QUuugQu0rZHu834W2zQOuWThFXjcPvOCzfO2sc73O5+mRbz3SPWLAuVTr?=
 =?us-ascii?Q?kJJTxV0qiqel66vCr0hwKidhn8ue30jtTyGDe5poEYB0nqvnK7+Lp6isU5KF?=
 =?us-ascii?Q?5Kbwm7OktRQt8mnTWXo8gDEyKcd8zSDKAhWYA/Sa2ABJXpZ8hQWzP6+JksUA?=
 =?us-ascii?Q?KqpPLRXVSZkws+YCo+owX6AOwyopfpGjB79Y851DFVIUdwSWQaK8pmlGo6vs?=
 =?us-ascii?Q?NLB6kHd9/DRvSePiGc1C08VkQDvVcR7ZGog30VMOQv5F5FC8+zWDlm2xzBwg?=
 =?us-ascii?Q?I46AbPxaT/vM4wDgf9KHfBnoeM5kPLh0Um6U3qVrYYWb9nvBCqKgOI3kyhvm?=
 =?us-ascii?Q?aDaO5PYTL8lmh/TtXkU1Mn0cqn+H51tBAEAkfhLX6pyzaPhSdfys8mMSqjXl?=
 =?us-ascii?Q?xzaMpImLv7h/K7sAHKRBmiEl6uQoC+Rx+XnauCG25En49O1TUqZv7HooxyDf?=
 =?us-ascii?Q?WowGY6TujvqMX70v0KVqfMtdbErzglOomcW7i71MymhFBo+/F/BmHkh9KAmh?=
 =?us-ascii?Q?1bT/9RLiOk6NimmgM7cL9IM0feVoE+58g/0LBptjG8CZdHpxPzB7JKhAL5kA?=
 =?us-ascii?Q?/IDy42BXqjeKBffvvYOu4nuLiTNHcyou/XPV8eb9f3bMZ9mP0qk2C9+zrP1j?=
 =?us-ascii?Q?oy1zGDtXvdnpPcXLQBkbpF1pVz7fQfGHmEw3BoM53x+O6afAAkn3bvfGdRFF?=
 =?us-ascii?Q?suDcsuzv138GJo/EGTDrkcV3o067ZAjmrI74Ye1SaiuEXS3HJHaKsx0Vlg80?=
 =?us-ascii?Q?R9Awe9gA0DC3iH5n7AxQABY72y33Q/QwTZ+l1mQXT4HXs6vOre67rcNeigHm?=
 =?us-ascii?Q?vJD69HlwEg+n+r7i3XcFx/fTjVf8nPRUuGn1WeUx4cFY4oAqJyRsJ0yE6O/5?=
 =?us-ascii?Q?WmpPRldo8/iyC+GVvmuAFLUETdOg/X2PVgYvlf5T/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sep5v7BAX9pD1sgs0V128QNGpLu5f2ySK9Bt/oEAD2ZqYvo4w5D5afzZb2GN?=
 =?us-ascii?Q?WMjVZ804P2nbD0CHGQ7yuW5aCIEoH5d8VxWAp5BMTOoy0v1NaI758DYaJLak?=
 =?us-ascii?Q?WETUlGZHglyDQoH8eXdKTNQQjpXQ+qs6G4tJP5Duc7308OulQzKbMS2KBGsB?=
 =?us-ascii?Q?38ondFN4CDxjQQN7aBdy7XiPiRIVpDtb1VJ19DNpahFKSa9OtsOmPtNtIs95?=
 =?us-ascii?Q?sFAHlzd+a2aQLCN3jKEVXD4448yRy17hKA+p9zrj2eOMqd8ka6wr5btTGsgj?=
 =?us-ascii?Q?zqqnLRTSTSyvqzlwa6VkAtfTcvOy1NlrtDTPOiMSRfSCarm1dp8AoUmhjJxs?=
 =?us-ascii?Q?49cihJvdkZgxEn5ryDRdFhAzFYgQ7BBY4OmffCVXoSAcWMDYeArQgTm4RyjO?=
 =?us-ascii?Q?0fiQh2s+qwOUYy/DMj6od83mZhpp+kbb6Wh+0LS5phciNndZavLxGDhsNoQ+?=
 =?us-ascii?Q?a/z8ZWEgZRqafZIUj8xd5f9Fc+e6ibz5W+QyxheOqEmTsi057rfGVYS2f8yV?=
 =?us-ascii?Q?cDnOwcIiLoMVI0ib8xFV/9UEoGgrVFAQgtxJR3+s+2tH9TmvdtGr56aOm9X5?=
 =?us-ascii?Q?/kvGukFV5c0JQD1buMF5gNJ6m/4RjWovuipc5CzUbEXyq/gSQcSASOfYBQX3?=
 =?us-ascii?Q?FCNuMs8uoiNodEejupFtUI2i0jU0nLIgP+SvbX06/lh0SlV4qbFxq4ZHbQkJ?=
 =?us-ascii?Q?3EF5J1wWCUYPMLcq+y3IuONjmq0qMYrHZQkHj210G3P/V+PpBVDRDTb0WLPJ?=
 =?us-ascii?Q?RsByxVDnrL435YoNuiiHav3myTeLr8RppEx2H6VoVOdWM6OXBxP+ERR8Ik/k?=
 =?us-ascii?Q?4XqHs2UpmaB+X2ArcnuLPBeloxZsb1AZUmVmFfiSM7eZ0CFAeExjWm+gGDhi?=
 =?us-ascii?Q?FIW4nZ+91IpM+3m3gbxB4Q0pNgh2FB4+qcdgAVTq9TeMMqy0tKwoO+uzBrqm?=
 =?us-ascii?Q?JHatxdFw9ObrWekz8vka9P8iZK9MvZxq1e6AXt/riidLYj1kuCaSZdTlnV28?=
 =?us-ascii?Q?WYVJkimRQOuc/hskw396VRPhzFJ282ihL2Z83q3dz/aYSRccRhh8lR5t4jj5?=
 =?us-ascii?Q?ayqPW/5Ihk2hswjBsPNJWgSIMGdahFLDV/WHcJTiFJPcmCDHsJMIEPP/e8ln?=
 =?us-ascii?Q?hPoe8X/c4n/YTd57f+kyqu2QwhbBN8TQ+zsLuxbQKuuOiqswK7gUSDImqWQi?=
 =?us-ascii?Q?bJf5JMQHsjv6D+e9wVhlvWSJ8wrYEc88dxX0UVNofApoB8TFFG/gRyypy+6Y?=
 =?us-ascii?Q?Zm3Dh/+uMRWqbJkB/m2VIROHgQ//FszmBRF/tFESE0aCaBCJNvLzBMHQscDi?=
 =?us-ascii?Q?El/Xhvb8CsiTY+hT1WLCyWdoQooTvlLxF3ne9+jF5tJutPxb7KWoNpBQyvns?=
 =?us-ascii?Q?XFxhEku+4Bpov/Q9WyuYphoKQGtgZZrd8X1l35Mq4+frCfp+LmisESAHxIeu?=
 =?us-ascii?Q?o89xR1lsIs01xEl1ZwauYcPruQd2mcUwdb+nALAgTTLhd+8bQ7gEXxUfAyUw?=
 =?us-ascii?Q?eG4Bd36jbhL0ijlKRCVONeJfSK9NZ6WdOmGYIEiQgaEjnHLdvkOlaI+ifMMV?=
 =?us-ascii?Q?3tUcOculYFu68enO8xstB6OrQ4sd4eWzGCph958e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d458636d-cde2-4798-d818-08dcde6590f2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 19:58:18.5922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJi408e+91L7jsyp+2rw0X3IqhwQvyeVYQcG86tKXY+U9OKOw8ZUEGAwEGPPaVBp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967

On Mon, Sep 16, 2024 at 05:18:05PM +0000, Suravee Suthikulpanit wrote:
> When updating only within a 64-bit tuple of a DTE, just lock the DTE and
> use WRITE_ONCE() because it is writing to memory read back by HW.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 42 ++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 18 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
