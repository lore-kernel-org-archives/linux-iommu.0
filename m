Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D8874E37
	for <iommu@lists.linux.dev>; Mon,  6 May 2024 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715000413; cv=fail; b=Ben3Ay+tuRVW2m3cIxNYaYRc7HuAMmJXJCJ899UjgV4rc4M1JCk0Id8GRbo7a6AUSsz+cblA++HXxlEb1CRcGyobDp3ER/75yJR9nTVdWeYTAdXB91mcFhmOB/PYAg5ExUMmLY6x91JdPKO+qmGrDhGusHZZnPf4/cQ9MM95u48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715000413; c=relaxed/simple;
	bh=heC1igBTjKz46SC6mCkgssV9nkRBT0o8Gi6qAZaJ8og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EopztKw7nvL4Y16EDRjZ4EKyXWgyAZRyVSIz/SGOcmvW9pnnFe1hE3semcZMMnvkrzueg43Q9w5HPMU02f0KTvUVt9vBBzF3JK2gNmujXUsy1CA1yvQGpKhkugkVGj1DI7oruVJiQUUuJ4l975dH2A8kYhaRvsvrXvERNbCCGf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BLv4nt7h; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BLv4nt7h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdkOwlWiln06piYeyib/wc8iy9PvLPbPBGFPx6+QuIkJhQxMbYUvESWRIpC5tz7G2+W/CV1R8IvmLSt7/WQfX1Qu66XdqEXluyjnqTaoxoqWYPNE8x8C9FOxh5MNi1BbFJRf3Vwd0j32cskbTQSqMlvFx/4/UhlMhHrbKZIue30FwAz04fxU51IBq3VxaABSi7YO8/ihpv5nRe8k0eV5stMmo2/qvWtd5h3l08HTf+svKzhr3vnGxE8dkPF7H6jMGpMx37JZRR2fBuWS9R4I05GCRCyFihFY4d5kbmim/IsEXaU2tAHCcq2sEG7r2BAIS+fsKaeKvXDfjIcOqLTLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvQS5yWtW1d/JMFvzuvvylhTz+HyNzLExBq0x9/sekE=;
 b=Pt0uzvaOnUkBMT13wcwv2f3/voEKRyZJV389V/cGMKCsOAR8jbt3rj/+RZ3ojtg+Inwhu/IQLCC1QIASEM5Q9s1kHbSc72Ud+Kml0Ax87LIAiG1pdE6DGVFErGOPKp4cC7+lO5r0bveH6CxUlX1Csoq7zxD/dul1jOtQ169jMnbO8X+rxD2TxViEDSlFz4SKwJZsCqgOd9rrSfF5d/LLjteJr7eUyjq8dEk/GUOiCP30A1IzeTV/Qhc5IQTbNRFNMPRuTlVTOltE8Iy8fByDvrg26q76VfZZE/46/+UPg2OvR4MjJceVjBCQnFP8fitAWGytxg9oi9mODCk5pQYzNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvQS5yWtW1d/JMFvzuvvylhTz+HyNzLExBq0x9/sekE=;
 b=BLv4nt7hjTjA4j9bQx8rp4Te9UGsxgllHMJ85mLqSLG0jG6m91SyizO4Bbn6MVevN2KhOCoJ/+o2WDhfcMjnz3MPGyZ0BqtUbanVANQcsImy5zCJ41RysOklGBGXX1M6GNG3rra6ohJOn7pV3+gfV8CPVbobDgCKuy5OT0L9k0OM2bovCof3tYLyV0eqHjJfOATZjE4nIU5CPbAHbxydXevGi6iUK8KxWvmhJ4mSP7x8zXke12kgn8ewpQaDYVxwJkW/78OsTGlAxNOVrFvbyfKAYqQxyee/53IZf9JCbLFSUBdKuRWhaQcUXKgAlQawv31l+FC241cgPVH2e+q9wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ1PR12MB6076.namprd12.prod.outlook.com (2603:10b6:a03:45d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 13:00:08 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 13:00:08 +0000
Date: Mon, 6 May 2024 10:00:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 6/6] iommu/tegra241-cmdqv: Limit CMDs for guest owned
 VINTF
Message-ID: <20240506130005.GH3341011@nvidia.com>
References: <cover.1714451595.git.nicolinc@nvidia.com>
 <4ee1f867e838b90a21de16b12cf2e39ba699eab4.1714451595.git.nicolinc@nvidia.com>
 <20240430170655.GU941030@nvidia.com>
 <ZjE/ZKX7okSkztpR@Asurada-Nvidia>
 <20240501001758.GZ941030@nvidia.com>
 <ZjhUAF07Co25F/qe@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjhUAF07Co25F/qe@Asurada-Nvidia>
X-ClientProxiedBy: SJ2PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:a03:505::26) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ1PR12MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d44cd75-6fc1-4dc8-2402-08dc6dcc74e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VNF9JNcUPgtibiBfpmpr6BHT1JVOOjs80i2spfnY6fL24UKNi4o2Fl6mxDPS?=
 =?us-ascii?Q?FyxFVnA51shRrWRQdkTWwFMM8VZXXktOkLZ70aXIHYjss8SW3+C6QM5T1/yI?=
 =?us-ascii?Q?Oe6WcfprX/0WoPCUziuVCrIkE+TKhf4m/YTBqIYq/MCpTk4RAEfa+XCnKu6q?=
 =?us-ascii?Q?LQk5cscJ9Z0o27lzc8h4IJ8QQZJm2bl1VBXX/DF53QFAiT88UAGrAvq9Lhwz?=
 =?us-ascii?Q?6+zkhRzLWPS9bd2yxjRxJUjLmL7rTH4uw3+3xjK+X+SZ1Au1ZVSEGo51OzQI?=
 =?us-ascii?Q?fNsjOlpTFJ+ldE133T4IfYAd4dcTCIqG3xSMckk+FVHAfZAmM8KwsPcmcPg0?=
 =?us-ascii?Q?vRiJzlP+CGpRqz/PlvKYwCNv3dcHjaqaVhSl8M+Cq1Oqi6thJugmobO3clrW?=
 =?us-ascii?Q?YdGp4aNN209esXcweLWw7wly2mnNVLPfLFvxU8CkvVQqlk0LBRNa3RFQNok+?=
 =?us-ascii?Q?uQLisbQa52rXWTydVqxRydqe4xv8F0TpG5dnRD9cf5IqMPsjdS2TAOlxcswe?=
 =?us-ascii?Q?r6pHUD7m4CLT+KeciGVMBqT3QJDgCO6VHOtZ0MBQyT4iW4ZnCDC/siEeKTmU?=
 =?us-ascii?Q?+zD6SIuaKYDoIkX5uZ62Dcou7WEgSK4+vN6dgd0FJG/WCKVre75/0bztLLAq?=
 =?us-ascii?Q?rnOC8+sGeVeKFZgVGps0DmSwKzyrzd3VQJQ4DMz7WCQx96hhuXTR7YV7y6LV?=
 =?us-ascii?Q?QvJ9CB1Sy7kE5yqGQJlPAdOQE0pjz7nFhbByD21IFc5tAHRyU/mmO+0b6ZbU?=
 =?us-ascii?Q?qREHjrzofaSCrTzPVz59c9D+Rg4Zyls5ED/oeb0+tQAyE21XPNm77TYmsnQR?=
 =?us-ascii?Q?YlJbQrTmhXB+UTYarS0LKVYLD3S7wqfnJw1y6tNgapr4zCCgPCHFGI4a3TyV?=
 =?us-ascii?Q?B74Ifrmb2cySZRBUsnZaYoid/LYHinba2PlnHTn+Wm25j688/Lcgssx2LHaA?=
 =?us-ascii?Q?vWFxqWiMyhNvH34DK2mfb+BxJDFMXQaF2E9y7rVlTbwAhlQE2BRVgmKsVyax?=
 =?us-ascii?Q?E8GQdQ/ZWuv+XUF5Ol02oWiRNjtkDgJKA4em3c/NAo8exuwQGHpEp405OlYx?=
 =?us-ascii?Q?mQywrM7dwip19EdG3pzB3VIswi7+sfwEnknvjBPGG+58T1y/5t3EC7HOfkbN?=
 =?us-ascii?Q?aLe+bFE9pCaY/4hH58fhEqpUBsx6TI1ALCeV2TnnTsUctZbLEawRHpYMDJfi?=
 =?us-ascii?Q?8it+mVPyY/8N0guwTLMvv7BfOjdcW6FErObWCHY087TwJDRlCiZ1PoGyj0qK?=
 =?us-ascii?Q?ye22fUQUQCJv6rU7NuSxIGtBlbhf3kkxUOj9o4W9ig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UfTFancoezYwJqGWaMyP5xyYi4ajBxPYHqXXXN2hYmRk/bJevuhnnpFNMgQ3?=
 =?us-ascii?Q?ugfeGBOQupC/6Txc+m5C6kdUdIKFb6cQlbvif8yM1tV1RRwPfoqCgIAaOdjL?=
 =?us-ascii?Q?zEjfbUZb6X33L+gI1juW+20WvinnInrbWz4LPVmKM2SpVm8YGNCLIEcCilVo?=
 =?us-ascii?Q?JrpKR9GrCRks+INeQ4mEC6qQ9rS/ets5Kd3Zr3kMTkZW+LxAe97nuw7EATnU?=
 =?us-ascii?Q?sckI/ZsQy8oCSprvnNY79VCAAc/SsJHjbWOdbXlcRss1jAYKBClnqR+qkeyY?=
 =?us-ascii?Q?ZgE3zgwRN718AwlHlW0bkQ50aU3J7y8gRmHSLVc28l81F+PMYG0T7wbc0/lJ?=
 =?us-ascii?Q?ugFIePOkJtOAqry28WdJW1XhIOY5F2UfwZk/yiuVgRLapqXnt2ZhQ56z3JQ4?=
 =?us-ascii?Q?fYuWErngtMpTqSnTEqqc4TAa7rfXWQPZAOZYh/6qBBgI45EH4TeC5nRtIxOZ?=
 =?us-ascii?Q?wmT0V4Cjn7Sy14SOaeWy0uZ3m1z6KWPQ0U9V15agcH6vcyYQesPFWl6+M4IW?=
 =?us-ascii?Q?nZbRiRvEZNHgvTZQHdCCRN+zVk+QiEi2+2dFMT32hM320tXxFzeESFNotVsE?=
 =?us-ascii?Q?CfyTIqDMvwjWvi6mFutuIAC+TeWlgCgTT6iEEAq7fmkdiICmE6DBPsfcwW9k?=
 =?us-ascii?Q?66t+i45sxmJx4gmLGXCXIqowlc98OdKKgyiN7uXqwFYftIJq7JoiIyI5RVdE?=
 =?us-ascii?Q?vhu+nmMYg5a3ZUuBcnfcvQXxVVGgdD9TH3c/F07qWCOWFmxYJdhM7iObumqJ?=
 =?us-ascii?Q?wgnZ9FiZ45mR7wCgzKchpybGSTU1fTjKFdZ/6oY4UVWxZg+cUvCKcqZ/QLMg?=
 =?us-ascii?Q?DbSTEvZKvKdaGtqENDq9cuZ3zER8h4czGMO52Mm49ytunlb6QXMrlKkUL/l4?=
 =?us-ascii?Q?oURNguRWx19piNuiTMAPxPSV8PNvkceoLKqU68eQdBoXZq35kRz159qL7bhY?=
 =?us-ascii?Q?SNCd/bo9c8xPL3H4KLKWcWip0qwN8m2sbUeUWzPWujxfiutWT0f8eFwKQeWp?=
 =?us-ascii?Q?OP7G0EI5gR6+Hs//fGeAfTeHiAC/UMvNGJm5BmJoRnFvSJK1YszRWOJWuEND?=
 =?us-ascii?Q?Y2Z1yYUWWFsn0lqFCao0EcPtZbNTDzR3QCihEoOFSBTTpiq9O43P9ZD9xjoy?=
 =?us-ascii?Q?tBss8/C/Nhx/XG4AW5Kw/08rw5gcf/2KT3r7dHF3J+RO2YgU7YiNJfnwKeEu?=
 =?us-ascii?Q?lKBZ4OsAoT3itb9CEbGAk/tCeicDWwal9Yvbxc2ZgM3mOfqecFd/CM+jMHr+?=
 =?us-ascii?Q?Xc+9EiNVXrLfOoc6rcvg7FKv4QxVzpfiqt4Qy65aPvdep5Ae596Ba/1Mi4M6?=
 =?us-ascii?Q?Wv96usFzKhx3BLempyp7CifYkFdu92Xkq7EIfb6Jh9X/dEQSTRaUaFgkqsZ5?=
 =?us-ascii?Q?NFhfQZlX+Y6cCr1++7omtfkHVgMtgagQ/MleauAx6dKXmGLhIJfWpYFniM2e?=
 =?us-ascii?Q?VlX976i8VxQH09KoAtYSAe6Nvc2efDJwRdvW/KSKK4EUEw1PSn4ngiV4Vcb3?=
 =?us-ascii?Q?eEm9s8gm5m8r3zv0RKLPwP9frBSthhKwkHr53chnw000NjWX11BGu81BFDeC?=
 =?us-ascii?Q?etZd0+UrApbJdbI0BN3GxdOIYmv6+Vm1wbldcDFj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d44cd75-6fc1-4dc8-2402-08dc6dcc74e3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 13:00:08.2767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pYi1rFBgS4OlpWvnaC7VkBhGtVl7tEcVhMdXE3CziZnyKPptbFPLBTSLAdRaGMf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6076

On Sun, May 05, 2024 at 08:52:32PM -0700, Nicolin Chen wrote:
> On Tue, Apr 30, 2024 at 09:17:58PM -0300, Jason Gunthorpe wrote:
> > On Tue, Apr 30, 2024 at 11:58:44AM -0700, Nicolin Chen wrote:
> > > Otherwise, there has to be a get_suported_cmdq callback so batch
> > > or its callers can avoid adding unsupported commands at the first
> > > place.
> > 
> > If you really feel strongly the invalidation could be split into
> > S1/S2/S1_VM groupings that align with the feature bits and that could
> > be passed down from one step above. But I don't think the complexity
> > is really needed. It is better to deal with it through the feature
> > mechanism.
> 
> Hmm, I tried following your design by passing in a CMD_TYPE_xxx
> to the tegra241_cmdqv_get_cmdq(), but I found a little painful
> to accommodate these two cases:
> 1. TLBI_NH_ASID is issued via arm_smmu_cmdq_issue_cmdlist(), so
>    we should not mark it as CMD_TYPE_ALL. Yet, this function is
>    used by other commands too. So, either we pass in a type from
>    higher callers, or simply check the opcode in that function.

Yes, you'd have to pass in the type there too, which makes it more
ugly.

> So, it feels to me that checking against the opcode is still a
> straightforward solution. And what I ended up with is somewhat
> similar to this v6, yet this time it only checks at batch init
> call as your design does.

Well, the only downside is that the commands have to be same in a
batch, but maybe that is OK anyhow.

Don't forget to take the hunks that fix the queue as well.

Jason
