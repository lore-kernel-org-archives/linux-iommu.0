Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA381DB13A
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742240268; cv=fail; b=p09gtCbHLacPq/CA0Fx2jpKKMih8Rk6ftC4Y6vbLgDK8utdkR/11usMOwW8HpQcEFwCHN6cd6dXcsRZr96E1IwEDHQIAgXVLszUUyeLqiO6j41f2K+daIU3Yqr+WHxfkW3usY3rv/H7O+MvHymINpHule6Vg06ngpvyMjDvtwEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742240268; c=relaxed/simple;
	bh=hvHdJUO4eTt/s1VaQ+tmM4SPNekL2GSPJlaeVkZh648=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bJWjBXqkZxTu3NdIJVzx5P1UyTY96jW9x93odTWWgIhYXcq0dGZn203CeO/iJxaEezA/h7jjxxeHL4YZXButC6jZhjvcNQm8t78hnnp/43ZyoRCwIUhnQpNu0+TQfngpcrKpThUaCyKpDJg/WW59UXqTrn+cGgcfMV2gWsrEH/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=npPA43xe; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="npPA43xe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPBInWvK8Fci2HefB0sUItvvkvTBP+RjxmKReAGY2LckfqOCADDJwwC0K7qqNP2Z0/HSp99McXSSWB7Aq6gcqrzfpoVsq4YaiKu/pj8yK0lFA0DyUX2s+aPNcS2m4BQBeM54O5iX1e9yrzvX4RMkLHbSbxwhhVqGVLTnIMhCk61p5qxu0PuR1/J9HCnrDMZJCDz318eTmSwvwshGXQt4p4MnVxKX9ANgId9IIDzkjAfvevfxY4c/p4cHerkuUsLN4IfK8G/eLtvB01CPK/nso2/JixnjaXyeNfdi5tnwHrH66JmSwbGhGElR8NDQqYrpzcjmiVYrpxKXtPK6Xs93/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uy8Oe45p6VYhXmqFX3Fu1rQbRuaggpC5NzlZ3vgnIg=;
 b=Ho7Eau4Uo0JfbgIcHSbClBqM2NrGK0+zHOdZJA6BJmkRhCkKM5SJAnhMh4zm9oL6JG8BqEBA1R+WyHmI4C3vbWIIvZyr7KfnuzmFAZ4hXK/xhjkwp1vHc4zGRHm8ti5W4WwbU+RSkUBCEoxgETi6dToEYqxl9ibSbymJyRY/nE821IANF+JXI3v3RAJWkReVY3FlZ0drRST7D02gUzjGLCA8S8ciAUOV3FvwK0WzLJM1j9NIgqQaP4yx2IZherfhN508IxHhl8mfcVY8+cX/VxiGia63ck5wXuU/MVhqgm3mdB44wkfFXH3ZfgjEF31tqIJySEyonSayfxz8GSJsAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uy8Oe45p6VYhXmqFX3Fu1rQbRuaggpC5NzlZ3vgnIg=;
 b=npPA43xekaeo6ghZhXWHCOTUHaaZhOpkEdaycSqtsqG4ZkKM3QrPVyVN/gXe6XgW0H8GuNpF2CBoCFruZsYrJQDUnsvtMjCzmL1ef0RboKBcIxK1sdi9J+VFgHMuaxZeHagskNGtgaLZXp/GJiGPE3v55kom84/eDPuKQk6UCsyjwVcXk5x+KUmKNLcCuVvsCz/9TbKdsr9R0t8KllpHxzsaUEhZxe+OpfzouqDumI6DOtlgVYHp8vqT9lA9k/aAZGm/2CYZQ3Q9VpTLC4I7LTMKE7BQQTAheAUOIHpaxN8sBC1K0udhOuhD+wuL5hjsdUorLQ2yYbKO9w3G651veg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB7938.namprd12.prod.outlook.com (2603:10b6:510:276::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 19:37:43 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 19:37:43 +0000
Date: Mon, 17 Mar 2025 16:37:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iommu: Sort out domain user data
Message-ID: <20250317193742.GV9311@nvidia.com>
References: <cover.1741294235.git.nicolinc@nvidia.com>
 <da7cc6d365ec6a77f6e6007f898eb3de2e581f80.1741294235.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da7cc6d365ec6a77f6e6007f898eb3de2e581f80.1741294235.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:208:23a::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da0f1ec-c497-4f7c-f326-08dd658b2f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hbn0gm+F8BgZ2+2bkAzB/fgkp62JZbEm5LTyrNyMYuuRQYyqAajecdpYfhhJ?=
 =?us-ascii?Q?3o8W6uVqxAFArN4Ss4bPAv8MuUgrJUQ1teHKxWgerschi4hZsmhrAoMrpT3T?=
 =?us-ascii?Q?BwSLmQ/mvhKaqOiM4wcNnqS1lMMGjUjNg7kVjeTUuQaMPRsPs8zU90QbT5xc?=
 =?us-ascii?Q?G6VDaOiRMXDfbIU5sEXPhWf9sG5y+iv3FWNXkDXKyBphd1ilDYIGutKsSTDF?=
 =?us-ascii?Q?3o5QWGOEDD3KwGp08suw/AcKNdOIHBopqYHN24kn6HlzFQPcS+DCfF8bcPYY?=
 =?us-ascii?Q?Nc7y5fwkaLs4D0ShRXfOuTRQvIIwEx3bAJqbXA9E4O66lxMOBoFEVQW4vYz5?=
 =?us-ascii?Q?x1sD/lV4BtVkzUNsZgfwVroqWey4oB8m4cXOFG/5WognDGrakCwn6B8iPRTL?=
 =?us-ascii?Q?HPL4gGwFdLU2DFgi/EtvP0zlN9wi36Au6MYO7XbZfJmbrkWSzRHm2Q1CZs9Q?=
 =?us-ascii?Q?4opC94SZKBE617IzVVfbn5fDHLgm9CF8Omb5LXbQKY7PMgmyBDaSSp74vzCi?=
 =?us-ascii?Q?2HpLM1N9jgx8Hnc3ilsQfZZcBYPTN++9yiSu6D9yqhWpjsT2UxMRDcye8ghm?=
 =?us-ascii?Q?flwKXxyjFJms2jkosjbXPS1AFyeY3f5EzhvdQHEycOOZNBZGJdS8XdP0ESTY?=
 =?us-ascii?Q?DkUurE4uKPX7FG2n03OnPunFCXVEBq7M+xoJWGDlLr9NMU4UHYeVWDi7QxM4?=
 =?us-ascii?Q?3aYghdnnA2t2H/Sa/Ra8KxTpvRIYeuPRZ9Gg+VNxiMpQCeSDBeufbufLDgq1?=
 =?us-ascii?Q?aYMo7zmKRaa962M0ObT+iQbo/1CzwOJXjzYBqagGprTgRnRqOhC4pu2XBo8L?=
 =?us-ascii?Q?qW4pNCd+ewGZYrI4FpXZCS/kSBUzrvAGX5TiEHI3wJLfg27k+qO7fe2fxayQ?=
 =?us-ascii?Q?aAKV+2mC93CBF6WyQf2OXFPMHEmoOlF5+TWF2TawVmfh2FrXNVzi0f5fEWI+?=
 =?us-ascii?Q?twe11znxUqufHCe9gqIZHtwrCx47cJNKuXON/0+Ehh0phcER5+KVEOkMlV/S?=
 =?us-ascii?Q?ezZAwkHtFbH0YBwlf65m6GOPWiYrXO91rnIdbgZnZfMAoq/xL1G7xs/hrDg2?=
 =?us-ascii?Q?5h9m12oABP6i3SY+3sK/8tt+feSEPXV0pnP3qANylfenD9p5MeefZVyotMed?=
 =?us-ascii?Q?wZ+y+yDy0dt0FK4UWkbH+SIWKPgM8wRlecCNUQv5qrkvuUkshYqHlIukJv0x?=
 =?us-ascii?Q?WfBrCZwzHAcGGxNC/Yg5vGuIqlIU7nocb4Rq3m74V/glXZ9S8J8cxXnHmE3S?=
 =?us-ascii?Q?8XT3IGuO/72ugCa6DW4o3p2iHkOsxlibQyJ8J2KhuHcr8o/UagEB2YcxUFk9?=
 =?us-ascii?Q?3irKI+hx4VsBtPaPAl6mXYf+5V0F3KxGT94IKbCLWByzTvpRdZDxufRBoj+E?=
 =?us-ascii?Q?UtXG/XnThOUdl7zMjaEmP1STqeBi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ykbmR+kA5EzbJyhbDeB8jsA2AAsVHD7MViXfI8RxTqJtCAY+P5VO7MffkXeg?=
 =?us-ascii?Q?1BG86rMZnXjx/lSeNEb+t3eVklMh/V3yL7UI5husNJ/09DSHTlznwZKpfZus?=
 =?us-ascii?Q?N3Q2zggATdvUZhYecSSqOqGakEmNuf+Fl3cjvwDbbjsihrFOOHjUPKM/UHYR?=
 =?us-ascii?Q?jMZxU+gjxD2zCLvj4Nja8rqu3Sx3qIxtRZag9Tf4qxM5BapC++/97Tt6BtG2?=
 =?us-ascii?Q?tlAJ1U7h+GwVoo9ZJQ773gzPlTKT4ivXwbg4EsFhy9cGbxMDhcqzBP9eMhBV?=
 =?us-ascii?Q?f5hqCY5IgLttBDWAy0WfwkXul38gEZ+CzxtvJ4Q0DBkS7iEPlOJBpd4cjUhF?=
 =?us-ascii?Q?6ba7U06pYyp61ESKWul1IQxgjDy1+ASuHBZvR8086RytDnYJO6Pyk4xEbPoQ?=
 =?us-ascii?Q?lGzNWAUVDx3N22YEjAduKoOrcvsMIl5xsO8OS91zZS95wRjols8TdJAVm99p?=
 =?us-ascii?Q?WGw+1Qv6aedV9KUnwjJVvIpdeCCUefqjpylkyiIoLToevGFkvvhI0eehcMAz?=
 =?us-ascii?Q?uW/W+SFieggCsDqil8OCOEfBvX/MkEN0p/lE9tNBMwfI0j7x+1ZoXP2CZM33?=
 =?us-ascii?Q?vp5pjehWPs9Cp5ilu1/fxIQSH8opCgeP+3HgobP7/Q2hA7901z3hoMoUKgkV?=
 =?us-ascii?Q?KpUIeeFgJXGFmSAk5Spsdp8mSKFu6Udo1NP/IqbqA2kai8pNsO/vcH8tutv8?=
 =?us-ascii?Q?VizvPdORhJ5NodsMyryaEp9juEsEO+Myyim+F9a2FFg/OZVzB7d1MXwckTkq?=
 =?us-ascii?Q?K/w8c4LzF+uGGeYkPD2Hyq5vV84lgizhsrQkPb6TkwC91ALn52MrTAPf6XB7?=
 =?us-ascii?Q?yfXtU+8DJ1RHmKD/A3WsjFZ/bOv+aNrP3mJHHk9ppA2ssea7+y3RIBPvUSk5?=
 =?us-ascii?Q?c/25O2RHXU3a6SNxrBMiRqUe93WvXSHdMGcynB1pdyvI7seSLRSdasRBrUBE?=
 =?us-ascii?Q?VwVCiTWaACbYTrwZQEOe80yw5320EPluqcHBDazsSgZoS1ZH09bJoOi2CrUN?=
 =?us-ascii?Q?V34Qvs/gIxy/tT38A4BBYz/mBhuzS5I9Wj1/zwMX5N+pMP1qa8dF1b1JmBAd?=
 =?us-ascii?Q?xGDjI0ZMtFmEb7bIhxP7o5JQ3O/D+rPcixenVI3GkJQBITE4VGPQv3V7zM7i?=
 =?us-ascii?Q?tunV2LespiMRmVCouv362xw6TnTJspB2wCGHLTxcdeZ5BzOcMn6bCIwemCKJ?=
 =?us-ascii?Q?/+//XgduZ4bz4f8iL7wu0y0C3HeZrhlcFIQ1U64P0YjngURbI+P+ATS9fBq+?=
 =?us-ascii?Q?gbgDFNOBAHb1QQiV8GkOpH3MIHdPgUGsAAa218L96kAxmB1h4MTVjqYGIS+V?=
 =?us-ascii?Q?20oAJ0OrE+fXtRffIabGek6+6Gg/IDbhBNPPRZ3CiDvZnzL29HaF1Kivecyd?=
 =?us-ascii?Q?qHmK4n/XpqCAJAbfSeGhuojNNdvmnrNa2dZUyOhWUjks9uNtD4NzLtsVcxy5?=
 =?us-ascii?Q?p5h2QzMu3QNo+Ckfp9ktz26KBgHALBVBSoNLOLrSzB6M2G+vpCqT8HKdqHdT?=
 =?us-ascii?Q?0D1aC/CHZMHcFRNIiU8Q42aaWNMpplnbKzBaBfC55vk5Y2b4k+U5P+9oTOxG?=
 =?us-ascii?Q?LntJAZ0zs4wohLGA5A8sAdYcer7SPEZhI/Yakvfx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da0f1ec-c497-4f7c-f326-08dd658b2f96
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 19:37:43.1469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6f3RHIfyu4TuK51CdoarDlK2GxsoRKgdUbyJGFI6TtH9h2IgCxCtxHFD6zoPP7IJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7938

On Thu, Mar 06, 2025 at 01:00:47PM -0800, Nicolin Chen wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> When DMA/MSI cookies were made first-class citizens back in commit
> 46983fcd67ac ("iommu: Pull IOVA cookie management into the core"), there
> was no real need to further expose the two different cookie types.
> However, now that IOMMUFD wants to add a third type of MSI-mapping
> cookie, we do have a nicely compelling reason to properly dismabiguate
> things at the domain level beyond just vaguely guessing from the domain
> type.
> 
> Meanwhile, we also effectively have another "cookie" in the form of the
> anonymous union for other user data, which isn't much better in terms of
> being vague and unenforced. The fact is that all these cookie types are
> mutually exclusive, in the sense that combining them makes zero sense
> and/or would be catastrophic (iommu_set_fault_handler() on an SVA
> domain, anyone?) - the only combination which *might* be reasonable is
> perhaps a fault handler and an MSI cookie, but nobody's doing that at
> the moment, so let's rule it out as well for the sake of being clear and
> robust. To that end, we pull DMA and MSI cookies apart a little more,
> mostly to clear up the ambiguity at domain teardown, then for clarity
> (and to save a little space), move them into the union, whose ownership
> we can then properly describe and enforce entirely unambiguously.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> [nicolinc: rebase on latest tree; use prefix IOMMU_COOKIE_; merge unions
>            in iommu_domain; add IOMMU_COOKIE_IOMMUFD for iommufd_hwpt]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/dma-iommu.h            |   5 +
>  include/linux/iommu.h                |  20 ++-
>  drivers/iommu/dma-iommu.c            | 194 ++++++++++++++-------------
>  drivers/iommu/iommu-sva.c            |   1 +
>  drivers/iommu/iommu.c                |  18 ++-
>  drivers/iommu/iommufd/hw_pagetable.c |   3 +
>  6 files changed, 143 insertions(+), 98 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
