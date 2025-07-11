Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A88C1991C9
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752269610; cv=fail; b=hT7XkKicJK0WcG1eP1o2rTUgs2S+c1YcyuSSpGfesiClHb11OVvTzXZSePryYeLgj42y4P/J/ABX7NK/eKf7f4o01XMb1HbDKTYyGaokLF+gaXJBIu8XaXaNT4y+bP7xiezlL42ODBt8kgTY/TzvGOtpmZOe5YPGetreWSkH0r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752269610; c=relaxed/simple;
	bh=1ihbJ6T2EGyAw8ckvcILWBu4adlu7G4DU3xMatCCJlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WSt7lMdIi17YySTCViIwTjJInfz77jnpksmnftCxgsWoPYY5iP9RiC0KQJcA9gaaaOXPYYbUjRoA8pbZISDalOljyQe7/z7SoatGfMyhf/tZ76b7ctAfygsrAJOmzMeTOKlzth3Vtz/LOn71YbO0fJBkHVl0cs+X3SFnvQ4BHLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LgUtS2S0; arc=fail smtp.client-ip=40.107.96.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LgUtS2S0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUGA9mzafDoCijAknh+4nBXJPfrjPEAliOB43/JNBn4eWzUjPhJJBX/WUJIKKswVPuvoYsl6Po0rZzYjgwLZ2wrcjR+Axp5U0BH4o6fMwFdY5yydFbu8qYEGMyCcLyDEPe192iSryAHtTfJeh9hwz4o+JJbyEABUllcEvwNVDrlss2wZh69fZwC76KX2uPJND+T6EfTNqCQf0egq6RlR6JX1u89LPrc8METgiAp6Ji9StZYMlfjKQCliGyxn2DXsfmUpZvy867rOVNrzlOQfD3Up4CIpDQgdpPPxxIru92mFpWEkjgVmCLqCY6o0hiitQrRfqjsFqHBWNUxaVO7VdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHjMazZvPfH+y1y6YSHC1F3t2a0nEtLfdwUedNdUy9w=;
 b=tKzMyRRLnvnSbEUeVsrG65g1v6F0HiFrhSG62b1F+5e5x5MuimW/tHOzcMO5C9lf4zQT9PSQvOuscCTSWmCH7TYFeM580JLZqwb+x/oJVn60dTW0G8PeXCXp74hFOTxEifSU43P105K4H0EHEZjzhYzmFP+YDV4K9NQ8eDjew2+PqV8cUej40x7dZp/aWhz3ZnVAgngtzcBKy50Jv3vZ1WA9H7E9ETSD4fILEzKZgE0NkL4xwB2Vp0athbsFAWS2tptR0UAzEXB8C3GAa3k1ApnDt9+2NdiAUog09Am4PhFZaLnadQyhF8exMzMiUuS5I9iPqoQGPyZLDa63Tx/w+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHjMazZvPfH+y1y6YSHC1F3t2a0nEtLfdwUedNdUy9w=;
 b=LgUtS2S0WlouDBEGjZVfQlDLLYKMjzLIhfQfJTbUDohCCLOCiReaFj4eZN7tlJ+sf9avmQhp59/2CGgs0HI8/9BnbMnGzLTkGEPC8jQfM0k+M2LYS7E6UBba8704a1cs3yI6jJpDSn6Xho9OqYs6AO1To0D3q4zQ9bpjmBJTc9pu0Tx4avWBmqdMTNvfYiWxIfXTnppeyx25NTnT/y1R9ePI6Cyov40mS+AXbUopSqrxK064qqvRnYBqkDLZqUbdS9HdDxz31FW3eL4DMYuixswcQ9nSCt0dcCD56LsgGm45wUJdwGRUXTwd4/5lgIhQT7Nbx1ZJsDJNvjphMiq1WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 21:33:26 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 21:33:25 +0000
Date: Fri, 11 Jul 2025 18:33:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	will@kernel.org, aneesh.kumar@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	shuah@kernel.org, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v4 2/7] iommufd: Add iommufd_object_tombstone_user()
 helper
Message-ID: <20250711213323.GH1951027@nvidia.com>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-3-yilun.xu@linux.intel.com>
 <aHAPqdZKfdeEMDs2@Asurada-Nvidia>
 <aHEnnesvLL5te5rf@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHEnnesvLL5te5rf@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: MN0PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:208:530::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL1PR12MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: c58fae97-898a-47b0-cb9f-08ddc0c29179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EIEHyq8XqR8mKNl2X0iSqebMckPlTX/Iu0RuiXM2/cg+ppuyYRwaDx9LUE0U?=
 =?us-ascii?Q?2+W2Sf3l0iLqDqy3BTYv/CArBeHMbiAXWuN+4JeDmJa3Q+lt7PSo1Kb6Ja7A?=
 =?us-ascii?Q?iLxOl6okplm6Bu5gew8T8ite7DQ+KUNHc6OJlAemy7RlC0NqK+X+ZgpQ3JaT?=
 =?us-ascii?Q?ANDK/6Mv8D+ATx3aS8aprEBxa2LIEZEPn+6SzNHn11fv1t3D68AnunK2/30S?=
 =?us-ascii?Q?NJhpYYmIad0gwncmFHnSKABgixeHJTHtAFj60OemQ0r05cGBG87XHKGqV5R0?=
 =?us-ascii?Q?hy9e7jlbcYWbA4eDqPozX+WabSyk3lxjXSJ5hthiG2Pklw6eWWSvp/spxtHk?=
 =?us-ascii?Q?Eih4tevYcf+rznPHBZsg27EgD2qcxblyT+CAIj/mRf7pr8bzEw7oe0wph4we?=
 =?us-ascii?Q?93jvfW6xfOsvYuXCjYqIq07c4s0E1fwMZZUYqGN7nUcc9Y4V3847NJRvfc2y?=
 =?us-ascii?Q?rfYTKF2YAzAaVFOgKXYZNKLUZmJo9Hv3FlcVwkoQK22vo0TjFnfrYZlufqET?=
 =?us-ascii?Q?xDh1ucIJHP1dDeeipet/qGuYK1w7WhXityS2TAFf+QBNutijpHEvJAnydmMu?=
 =?us-ascii?Q?ZgUl/FjkzuCF+akybXfT2hutUQ6rOkOrRNktlNFhQr2ohGNq4m6MELkaIACk?=
 =?us-ascii?Q?oHWRLX9eK8f5Zyl2NPqxOfCa7POWS1CFe37BgCgxsdQqtG5Zvnpb5GenSVrL?=
 =?us-ascii?Q?sW6TAO6HoyAG6GhqpW2GppkO3aUhoYYHS9Zb56kx/Wjed2z/2YvgSMdEzkVv?=
 =?us-ascii?Q?oboFQPHz7GX/tihjg9c3R8ltVbO75Cgm3OaxKGB1Ov5fyHZnwaNxgdmdFLyg?=
 =?us-ascii?Q?/RJPKSHl/8+G3gtbB85dM7M2hv9NBSwr4IJkCijdqmo650plxfdVyRzqflU8?=
 =?us-ascii?Q?vC+6k1op4KxB3iz5SNwyw+cVo4wSNdWts5PLvpcPgnwx0Jfada+/iZOnS7FX?=
 =?us-ascii?Q?MDFSCPedaG1vLzwjQCAzU75H7YggyVo4r1an5dR0sHMQZgcslehYwSvG0xGM?=
 =?us-ascii?Q?T+rqyflUld1ogSmg0gqLCqcbkwZKbUPxUlVmTnZfNzHGMqCCJIdyJeTsk/4g?=
 =?us-ascii?Q?3l1Ux8kElHXjfE2SBPrEu6moySsXLbnzojozd3h7HslhSGe3EoANruGc5SV8?=
 =?us-ascii?Q?WklodJvppVGOgXEJI2hRyYyO4Itu+EfIw/S4swQ//jIV2mMbE2eB0Rl+IuqM?=
 =?us-ascii?Q?TmIAu9DEZDBF/InQFzLu0AHch4o/ldtxXeBM9HC9MiiKb4uija61cb6dWJjO?=
 =?us-ascii?Q?AqWAyhY0t9TrJCBmB1M0ubSMMIUsU91T4NJZYsEBY/fOsJOj92W/EP7O20u4?=
 =?us-ascii?Q?bHQv28NnFJQuKKtieUAZR+XudVnJxwo9uX23vSdijSPplBapQY5gkTTf0cyo?=
 =?us-ascii?Q?Yd9hFjEoppkpVe9J79RSjRrwi4enYJSvYvtZ4LVcr90zS53MQ8/Y7tJvt4Tj?=
 =?us-ascii?Q?vswkw8B/hCc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K3FbpztisyXWJ1F66IEq8TA5CDBQUwnVfj3jouv9cnXEtlR4wPei92+16ASP?=
 =?us-ascii?Q?DPVyCyo7Ch8pN1g8Ajn1lO0M09sJjrYgw0lTevg/bZlultXo1fPzu3kzeiUd?=
 =?us-ascii?Q?9DbMYTXUYzXndUk5wh5sIkrjhRDlstQX20yA1YnesL1MppONmjztLZpcFFy2?=
 =?us-ascii?Q?RMMfhKKjNa6b4IXT9BwgVy2NCdl8aRGq/Dglhxzz4KnKjOTCC+J/bj/ydJkE?=
 =?us-ascii?Q?a34HJHjC3M8FotRYhfCTB+QuUX/moSCXS4jaIzbvZHLUGHxqDuWgHsFPEnr9?=
 =?us-ascii?Q?NtvkEPUIYsHJNtcHGLykYthvdXUbcu3PC5WqRrDp+VH/NO0sJ6jlwCUldgZT?=
 =?us-ascii?Q?Oy2alufrJA52mREywsUkNjUrI2KNHvlsqecBLpZ6ttrWgZ8VxT8M7kNfQyib?=
 =?us-ascii?Q?An5zsnlWf6zesFB0AzZzF85XdvH0D9L5e6c7/BKxX3eTlzXCODtdlUiDamW/?=
 =?us-ascii?Q?eQmE6QMv7iLMfbKqCbKULnJBzqsPlD9EmmSwJv3vBhRamYdtKk3OFRfdTcPb?=
 =?us-ascii?Q?Y3y0dTAp8b3NXNY6a/t2cVoolM0ahgRU4JOcQJw51dNgqyvY+BLHjwfJ14hK?=
 =?us-ascii?Q?iiG8DBFz+h0VEMXCOXOW5GHkbwxZeS4LYYT9BHfi/OpyNCQtOcPKcHQpJ1Dd?=
 =?us-ascii?Q?QWdvWJqenWpSISDwywbe4XssNTFdARsdALN599phyTYiuL7D7vBdP+fbcGPa?=
 =?us-ascii?Q?8MX4fJQjIPQjSYCWcP8ZJbLZ7uUKjZGU3tba4YPpkx5rlRPKZCYqYHBr1CU/?=
 =?us-ascii?Q?Ylanf02uRIBDoUunUQ3cdADpKpexvB9RicHc8BFR8ZTth1WSJiRtyq4HAj5O?=
 =?us-ascii?Q?ya+Wg+u8k7CI5QcRO6AzuT9mEWyb94WHcqIAWYdnfJgTMY26OHjCMpzrjVnJ?=
 =?us-ascii?Q?oZtvqzRHgBsHEtWs3jY04FGWgiMKmchNoaDFESn3WZ3EXDzrVyZUcA1F0Uqn?=
 =?us-ascii?Q?LucLVubWybzA0qQnKKnTReJYh58JMlv+Duiz9TB/xvt5WqffFBFkvnudk5hT?=
 =?us-ascii?Q?G7jgor1yR1lNVLk44m7X/s8lhK7Dzq3d4SgzFfrVL9WvUg7kB99xCs9zxZCQ?=
 =?us-ascii?Q?Uw79qvOJe6qUM9PhYTrNg1VH3EiVvCC97NGeDJ224pybf5v4I0lxRwwiD4eb?=
 =?us-ascii?Q?H57HzIwLeFv+8eTcSUwEpAHMjUpr9J+qPgGf/SdMtyjtSaq222MiNchXl6lA?=
 =?us-ascii?Q?vIeMzbo/fwviv6ijR/UTu+YlsvJP45WCo1f1YiLYEmb2YZ7O3a5HGuuaZMmx?=
 =?us-ascii?Q?TWln0RW4HT/kr2ffKQMf4cx8G0jc0b1NIPMbVUUkaKWGnAL0uWYkMyRbbJlW?=
 =?us-ascii?Q?GOdwJHx8m58BnsMa17qqBqnOSWYORKHxI8/X6bTQMuz/Tgoi/L00T6KDyw9m?=
 =?us-ascii?Q?6UpOUucB8r3oJ0cdyVgzeQFLoSWGylQHRmRbiDIKxhzaqO5R601eDNJgIFIW?=
 =?us-ascii?Q?ID86cuFqHBDxaTlnDxnHQU65MI5EI5JJgn9b/2Hqv9p5iUa0rjyDcoqr6pbe?=
 =?us-ascii?Q?AK3aJmPULW5oV1DO0On8l1Q/cgqMaRPIm97kcJSoVu//pk3daJxE1xYqxBs4?=
 =?us-ascii?Q?dHnZxEAKX0tCz35d7PJB1+DKqgl+SqJHWzsF5evW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c58fae97-898a-47b0-cb9f-08ddc0c29179
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 21:33:25.4899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17MlOPl9vyLLCdV1G6lmkoKbed3KGqhk7ixGCgTSMTMSyTFcAEIf+sfTz8QhD2dj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849

On Fri, Jul 11, 2025 at 11:02:53PM +0800, Xu Yilun wrote:
> > With one nit:
> > 
> > > -	while (!xa_empty(&ictx->objects)) {
> > > +	for (;;) {

Actually just leave this, if xa_empty does work out then the loop
exits quickly, otherwise the break will deal with the tombstones
 it.

> > >  		unsigned int destroyed = 0;
> > >  		unsigned long index;
> > > +		bool empty = true;
> > >  
> > > +		/*
> > > +		 * xa_for_each() will not return tomestones (zeroed entries),
> > > +		 * which prevent the xarray being empty. So use an empty flags
> > 
> > Since the first "empty" and the second "empty" are different things,
> > 
> > > +		 * instead of xa_empty() to indicate all entries are either
> > > +		 * NULLed or tomestoned.
> > > +		 */
> > 
> > let's write something like this (correcting typos too):
> > 
> > 		/*
> > 		 * We can't use xa_empty(), as a tombstone (NULLed entry) would
>                                                             ^
> > 		 * prevent it returning true, unlike xa_for_each() ignoring the
> > 		 * NULLed entries. So use an empty flag instead of xa_empty() to
>                    ^
> s/NULLed/zeroed, are they?

Maybe:

 We can't use xa_empty() to end the loop as the tombstones are stored
 as XA_ZERO_ENTRY in the xarray. However xa_for_each() automatically
 converts them to NULL and skips them causing xa_empty() to be kept
 false. Thus once xa_for_each() finds no further !NULL entries the
 loop is done.

?

Jason
