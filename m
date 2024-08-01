Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD619E7D0
	for <iommu@lists.linux.dev>; Thu,  1 Aug 2024 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722521449; cv=fail; b=hjtzGgYe/fnAG+WHywwM8k8Ul1fQ7H0LNXLMS9pPJuKbNMV9dzpeJwGsQiPvUK6Kkvife2nKKRn4zss7Cj4ZdnSUWMXr56H/UhX5/Sh/ypJRA9UfsbRkgz+KRDZp7/9iovPxBnEG3I7527tn1o2TrkW8RDN8Fe+mmAJwfgoytGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722521449; c=relaxed/simple;
	bh=5H/X0sOS4nbXJLaVXVipyf93O/w7WuZMNoNoe4R0hIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gVrrmlryauThqpf+nJqqGwmco6mXuD/2FKLzzzef5dEOwSFKeT8N8otxUDhZLGfS6phrJGH+GOQXQ03LEGVkIhIFr7GnDegmTTRiMIAWZsN9FRKxKXd5IcEHpwu1CzG9VlzbEhusCgRBblxARQtTdWswtRwQpz2wwVM9yP+FQ+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p9Kz+W49; arc=fail smtp.client-ip=40.107.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p9Kz+W49"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoNlR1mGGb0bQ7ndILHml6TKTl5Qsy9jscdJ3jgkSnN3lJFS28CDkiI/sVxPZn51muarQgZziLrSW2li5QKLf2McWgcRgDu5jCqBJeFchzLfMDcWxSbTAWZd9V4zoIlspTGBcYzUWx16bjxSLZqXSeROp9iEV41OFjsbMOaDnGy58FBIy5R8tYHPPYjNJaqc/QXi3pEuDfI6KHCLnRORct6T3Di3bmtk3pkz4aNsgmvpzaxm6uxaw2qKBtTscFpPlIH8sFx1IVWsw5lCc5iznTR5bEB47MyFP4I8fQnPXiMyDQiPuf7v7zwaxKhktWj3L60gjdLVvtyWQwNg6C9WDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1mG2vJj7q8BbW5FNjtzDHUo0XA4YaIeCyhUn8vFeVs=;
 b=WoRR9Ow78SA2oLTE3KL5uSBoNTIsUikGPmcG43g0ViUFsOfTlHXL8+HlMWqUZoNYNj+NiC1tkK4cpvII62fLNx8N9rdqpHvwaAffC2I0ilcwwwf/FrDHpQkl95KyYVCldcM18MJiBTs/08GWcHx7Pu+MwSVWl6xNFNGyAktzxto1IAieaRXPzGVp3peN+kDofWGCF6KI9WIgw54vGK0h6lJtRI6byo6hv4cQRpjSKp/NS5bSFD1CaskL8EqIYBC57dl8BszAT7kQMvhSBNcrLn9DMk9lZdZL+4VPzok4ty3r8BM1P9oX9YjzIAb13H4PhASzI2wpPLoO2UyQvNmzjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1mG2vJj7q8BbW5FNjtzDHUo0XA4YaIeCyhUn8vFeVs=;
 b=p9Kz+W49pQNoCBVQZCWcpo/Ocfl1Aeo7/Td39Ra6WT0USexu3f78sfpowAimmZykVycMqeLJ1W4GWMeC/G/KnFZQzcgud+vXbIRGVKLkpDUovwksF/RKtNJfrvrTVO+kGng/jiqirsEYa6pefkjSLoDv3bIEkJIuw2+Mw5JecuTGDlXJeAk7mOW+hNIVVfxQyPuxTDXkgK+BSqE17eUmqZuJJWuCvvfCVWq5zYz6chlVma+JV84wlICvO0arXvXGX+7b2jdt7huglB9yP5eHw+lSJtn2gI7x6WV6Rg5xQfrnDp0d+XcFa8PVDtAtv/e+IJ7KTfU/c9pIOWlBCvI6DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 14:10:39 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%4]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 14:10:39 +0000
Date: Thu, 1 Aug 2024 11:10:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommufd: Enforce IOMMU_RESV_SW_MSI upon hwpt_paging
 allocation
Message-ID: <20240801141038.GL3371438@nvidia.com>
References: <20240728235106.2435208-1-nicolinc@nvidia.com>
 <BN9PR11MB5276497781C96415272E6FED8CB12@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Zqp+sssdo80B7MaB@Asurada-Nvidia>
 <Zqqq5JYFswS49z2L@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqqq5JYFswS49z2L@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:208:329::19) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b773979-18cc-446b-18da-08dcb233b8cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iM+fxf4bO1Z+e/2BF9JJjMS/5LrIBaYtdy50h0OYRwSixEVfrigbZzgtLvQw?=
 =?us-ascii?Q?21yC60L4F+U0xKJvsrEXtVjhwYRVoeYn7HfUMfUmRcl4l4KvlEKRbVibn1d/?=
 =?us-ascii?Q?gsL1oWKJUtPtEvmTTEqCK8pvnzFzO9fNF+vEtAhyhQlYiHBr5ax/rO1OByxQ?=
 =?us-ascii?Q?gGHATkkhguDHsGYwo9dI3zj2jiLOfJ5rhSLLq0TCS9jnqCBbBNj2Q2/cl0XS?=
 =?us-ascii?Q?H9vbIMkky9RP5jHRX79jZ2n+N/Xd2R71e6MFkExHNI37xheGO3IaNXT/Ecvf?=
 =?us-ascii?Q?YxkTXzC2d6/3the58CgcQ1gPaMvshaM1bfI1Yme0xHm3P1HCUyklI6C+1nvG?=
 =?us-ascii?Q?zTTglFwln72WMT9DyBz4VETgAIZVGWAH5k1Pk5kbloTzDJuCbYzpGUfo0nTc?=
 =?us-ascii?Q?Rx2RUu289iOtVOebUo8yI8+hzoUOCrt9dxGj4ZmEk1xbBxlmcjzFdQ6Bh0c+?=
 =?us-ascii?Q?PS8Sc0Xt61Y2AMT9g/GlZ2Um+G1AEzJ9aszQwNzmLLhR5z2T0kN0hdlQm8uA?=
 =?us-ascii?Q?gl4MoA5A/bpHosIukb2P2O2txuHMWtwNP/p9EiTrl5SHSyqPlLTo352xqgBq?=
 =?us-ascii?Q?YA1rm/WrByA+eB1MQCwcZQoi3NiqIUWXw5RqJTMcSUUGaedyOJrENHw5O7Wl?=
 =?us-ascii?Q?rUQ2um2TURXEu4lycqyTjkwewMpTHDL5ferOps1nsYuZy8B7Wag4fLcak/lA?=
 =?us-ascii?Q?xfWZ21VVk1DarDWjnaDJ4ofEoltGOK2hyVj5oQrgr4UjZx5PxSpWc5BoWBFf?=
 =?us-ascii?Q?YN7grDPherVo8ydDlzRW/cyDw3QtyPk173ZotKbK3EPL8KW8yocb6G3LJsHV?=
 =?us-ascii?Q?L/cYT87i7KzoCvBQhVO34zaI632lwSlYVER6/i4n95We2VsMco2CeDP3XjuK?=
 =?us-ascii?Q?hOTlLkfoXPgqVhSORC1xRcUwJ77BJa68SaUO3qcQ9+u/8gW4gtXZQXYuP5Wr?=
 =?us-ascii?Q?EZJH6SHmSqVZEUwl7YSgbAHgyCHjVGKXKGY3fSvH4JwXST3b/YXYPNnWilHo?=
 =?us-ascii?Q?cpPwAzUk91MObbaKtTW9B0l7dI5hBeKplALZSmmLdmnq19LZt5H4ZhOlZ+/6?=
 =?us-ascii?Q?xI3c6zU81QWRDgo+vQBcR/xji3gxgUgNGH2v29H18xkrkOStSrR6F2l6LSUR?=
 =?us-ascii?Q?Tmr1p2AqQ4TJXc7oCVtrPStWKEzZ95rjVCybdkBgcQ9mKzbLn/mLghuv4FVJ?=
 =?us-ascii?Q?Nt5O/WnA9HVT7KB+OML4WSNrAl5Qzs2VBDuUlxhjbgCk+mBqt9zdQxWNrtqi?=
 =?us-ascii?Q?PFN4hnARndVPofSAzNfMW96sps0jKmMyYG87cD/rpZaAmny/RD7L9ibhf7iN?=
 =?us-ascii?Q?IW4KpHNaBiLMzkLPtotcJtE7EU7Jl/RUaRouQwsSkXmQUA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xa0v4wjCHKhdSSgB3ZJ6P4kJtp8aF4/wpiBW0O+07elJXCwAfDpUBty5ZKv6?=
 =?us-ascii?Q?QyPbr7h/ATluDWcy0PJv19XRGVT/fPjp6Gcg907UpTAyP6Hytn54FmaoA0Kn?=
 =?us-ascii?Q?gEImR1dracvegkMuwChTGLfV2yCOMx0uE2Lf+mjUho52YlWRjXvvvRZ01eda?=
 =?us-ascii?Q?vqDrCqhHbdjYpM+XFt7d8SUKF+V1fZ+ymlOmgtrnmmViMDGNNrdKWdtvTtGn?=
 =?us-ascii?Q?luia9+oxs/XKgvMDsO8H9FdFYIL8ZvuBgq07T0IFeUC8lSIoXm7ujN1B84Z9?=
 =?us-ascii?Q?eiwuTyiH2pVav7P606inlPBeTlnWQRu4AiBNBpnbZBwXMMeYBX0LdxkxHFLt?=
 =?us-ascii?Q?b50l4KZa+ExZ0/1j32ygdu6rEdM89LdtOhGs8hsPPHzZZ6EYeJtSOXna0k7g?=
 =?us-ascii?Q?qV6fIShymSj0AOLo8uxgS/u6lH7kg7eN8i/SUxyDLYW/mLk9HU21da9McCcC?=
 =?us-ascii?Q?pve0jy9gLSJg+q8HiqZsFsq2NVBdkx3uJq2+D5kSkWiq9CZK4f+SWWJ18Dvu?=
 =?us-ascii?Q?Pk6fooUlSdV+xiha9nIPhIY1mnDy6+V7pAG3+AH//ZOOuBeGCfyvx6NMN1V8?=
 =?us-ascii?Q?9O8deevSs02eEx1hbA7XDNJCYFXp1y99QDv59vkMSk368Pqep+Gc2Z3M6hDV?=
 =?us-ascii?Q?jdwOKKhjvNBUO7iRnOUDub8W2vWRSPgx+ST90tImpdWRrvsxdAfvj0mNSdQI?=
 =?us-ascii?Q?M+t38+elVa0SYjYikrPqlShKmpWFTQQOMjMOQJjfXfTx3KrERbEV5JL3jflK?=
 =?us-ascii?Q?DMAPlKpiMt+1S7iPM7b8SvTCwdtDhrFgBfaFMsevnwAQLBNTyJenV8GFB0Ue?=
 =?us-ascii?Q?aRhYEQEqylVQo/n7SA0dEiQYcpwnpP1j4QlXLGmFhe0RVBn8xJ3X7Sp6B5rS?=
 =?us-ascii?Q?+/+YGvXjr83qRSFNTQgIfvfQ93Ybi7oSPEPzu/HqLOQgYO7v78r9rZRZkcL0?=
 =?us-ascii?Q?UHqrbkaDOk2M2IsdBxohCOXlI5ncZVPnd+OA9fmN3l0gBdZ9t3Iu+RyK9dG/?=
 =?us-ascii?Q?OVNf+0g7aWGUd8n/AeTsF5Rj8qXImn+qbEaykcj4FV2mnNXbMyYPmY5rIfzy?=
 =?us-ascii?Q?wE4ZD7rpevRMKFeXZCdbuPmiHumt65T7896dbuJPLdg/ubK2eOelPMrvK6kh?=
 =?us-ascii?Q?FucunBAsVa2Ieb4CLDug4pLCJGAdFBTJou8uuMsCcXcplMU/VBSYqs2mVsO3?=
 =?us-ascii?Q?BSqUTHFFd9I8O37tKjUFI6YGt2J4NdQGj8tNQ87DsLti03wyyiwI3xevqPjH?=
 =?us-ascii?Q?+D9vv9GO6tASmbyrHdvpnfU/PgJDudjyXRSDIRGqbyyQ6FrEMkBD3MVXcvIa?=
 =?us-ascii?Q?/KVuz9CvEUQgGtmEzZbCu4flKKPuQnzODF/i9bRl6K/zh55UihLvvjtCBNOd?=
 =?us-ascii?Q?7BFYMSQ4ni7X3GI2WWUhTTsQbLplYinPWNDROxxSlBp8yz3wb7jzLe2BiZA7?=
 =?us-ascii?Q?mSWTcRgdV+SM3ySf7JkhobVN8cIQy+PZsn2x0lF52qvUBxcvqlrjFbtanGcN?=
 =?us-ascii?Q?lV5MKdMIFVUmX+iezG3DATVaN2FKhlQmpzQAr4fLDgGAEAQG5CneaaU4q8+A?=
 =?us-ascii?Q?sY7to/2obTgzMRq9cOxtzMHaf+gk4Es9Ytckqjf8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b773979-18cc-446b-18da-08dcb233b8cb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 14:10:39.4716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TP5WiQVkWJjepwFLYgZjYbeoLvR1tMCHMzfmxAJr+h3tkspTwPS3nAsK6J/g6det
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718

On Wed, Jul 31, 2024 at 02:21:40PM -0700, Nicolin Chen wrote:
> On Wed, Jul 31, 2024 at 11:13:11AM -0700, Nicolin Chen wrote:
> > On Wed, Jul 31, 2024 at 07:45:46AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Monday, July 29, 2024 7:51 AM
> > > > @@ -364,7 +305,8 @@ int iommufd_hw_pagetable_attach(struct
> > > > iommufd_hw_pagetable *hwpt,
> > > >       }
> > > >
> > > >       if (hwpt_is_paging(hwpt)) {
> > > > -             rc = iommufd_hwpt_paging_attach(to_hwpt_paging(hwpt),
> > > > idev);
> > > > +             rc = iopt_table_enforce_dev_resv_regions(
> > > > +                             &to_hwpt_paging(hwpt)->ioas->iopt, idev-
> > > > >dev);
> > > 
> > > Is it simpler to extend the original operation to the parent S2 when
> > > it's hwpt_nested?
> > 
> > Likely. I recall that was what one of our WIP versions did.
> > 
> > > The name iommufd_hwpt_paging_attach() is a bit misleading. The
> > > actual work there is all about reservations. It doesn't change any
> > > tracking structure about attachment between device and hwpt.
> > 
> > How about iommufd_hwpt_enforce/remove_rr() taking hwpt v.s.
> > hwpt_paging.
>  
> > > With that I think continuing this per-device reservation scheme is
> > > easier than adding specific reservation for SW_MSI at hwpt creation
> > > time and then further requiring check at attach time to verify
> > > the attached device is allocated with the same address as the one
> > > during allocation.
> > 
> > Jason, do you agree?
> 
> I came up with something plus a bit of naming alignment:
>     iommufd_device_attach_reserved_iova()
>     iommufd_group_remove_reserved_iova()
>     iommufd_group_do_replace_reserved_iova()
> 
> If it looks good to both of you, I will send a formal patch.

This seems like a more consistent direction, let's try to make

Jason
