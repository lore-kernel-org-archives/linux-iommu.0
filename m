Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45C11E98E8
	for <iommu@lists.linux.dev>; Thu, 30 Jan 2025 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738252015; cv=fail; b=RL7UHPLdbM4iKTISHNtvfHAYgDU9nxzkopzAixPg7Xc2McyTsSjLz1xLKdDJLELl5I64qfxYZGP5S5ZN3ZtimjWEeTRZskgMvJED4ASjsvcXnwz0tGylOeKADNCGBvCP0jtccMOaIdqzMxwx20BCh+2E3gYtId4t4FfKMF0b4wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738252015; c=relaxed/simple;
	bh=xDZH9PM2XA6ixdIjGvoD+UqtNwqgTHvvXgju+lf3hKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IdbecVJaeHTw7H5C/jujzosVxaVzbWGtyMZlJpJ8NOBC1uPgI8fJXGH/+YNGxREeqVtrAwHVotRFkiAjjTyc+ztOm0ta5G+3gzlAGOplxFKunaMJkyzPIEX4qwoD6GfEaIe1OQv/uI0mzfpatqxN4WfAIKtnChm/B5sAHGrK5hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D04K8XxL; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D04K8XxL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrEjILb6tOogZxmGikFx6+zS4O1AVRtDhU7dRoyRSP383kJMnHeS0WRLVBHrqwsakE1YJY7ikU5Fcawv0GhO7MQxDJftsggB4XV7HZvTNqKqrBrnSL54Ck6V1QZfK2dK4NFtifrmWSN6Y8P99fFA44RteE+iw2b+q4Cia+n4bPL214a/aS1sYheMGPbEDICTO4clAhlSVWjmB529wYpww8CNgp/qCVSYkVmlR2hgPjb+h+jbq2rNOMLHQpiu7+NsX4RaqQ9+nItM8dPn6jIXFJANhqZEWEwZfNLDfsnZuKCxfCx4fv6nyhFJ33CDr2JvVrPZxJ1xlizliL5f4i3fHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDZH9PM2XA6ixdIjGvoD+UqtNwqgTHvvXgju+lf3hKQ=;
 b=robqh+MGKD1OekZBBD2I1X6cKk3/7WhIuqX3xmPW4J7KPgEVIaFJMH3d5+qe+jK7HmB50lhUtzpzmUZQPS3ri613eKMj3PoT/XdkXxaQ2hqOovqUYrClY30vfwQOPgYCYWVhD5UNC+wQwDrI1YvraBuuhlWF6OCSyEqNoFjRZECs/wkLcNTkCo553A4lv2naQWilrSFJ0ss8kSzq68Xx/tkuC9y5kQ+me8A/bl/cKuhLL+w/R1Dx85K9AN84FLJjTSYTTj7DSXSsfJMRsvYBiN7KU9dxWVJEmh0bxgXJN9M4IoH9gHLkkwRCgRMM+6itXN6Cln6tiCnoNgHwZC9xdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDZH9PM2XA6ixdIjGvoD+UqtNwqgTHvvXgju+lf3hKQ=;
 b=D04K8XxLclDA44cgydIaVNpinCPjp1uY8ozgw8V7HxnXqYgIAVCe9OcJOxaJvGqDsf88yIeDpK/cbWVS2c8Me2zDvHVuRNG0KP9piUdV+vdOh7p2BwCf37Hu2PaasCI5IpPUbjRBd4hHupPIWMI/ipv2JscLWmkwXzQNOf1THv6mw0LWS165oESiIXX7mRyi0KYG9Dtf2Vc6CxMuXgii+IazTrUjz5kwV+b//KqPVCn4zkFi6ablP61CMu+ja8+VDjOjiRW6lVvlYEO6x7sd8Ih7Yc7ICD+MEOzJPJPuSMVGkZT6YVEo/C2/vIhSgnVm9CngAVichg5WLXiw76x7Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Thu, 30 Jan
 2025 15:46:48 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8377.021; Thu, 30 Jan 2025
 15:46:47 +0000
Date: Thu, 30 Jan 2025 11:46:46 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: phasta@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	daniel.almeida@collabora.com, aliceryhl@google.com,
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
Message-ID: <20250130154646.GA2298732@nvidia.com>
References: <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com>
 <20250108151858.GB24499@lst.de>
 <Z36X_ZnCmBQBMoZ6@pollux>
 <20250109080812.GA20431@lst.de>
 <Z3-NqwAG_96yq8VD@pollux>
 <20250110083955.GA5395@lst.de>
 <Z4D5a5NYrAbNxUL6@pollux>
 <Z4kG5AcVeQKegLnb@pollux>
 <20250128092334.GA28548@lst.de>
 <293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org>
X-ClientProxiedBy: BN9PR03CA0767.namprd03.prod.outlook.com
 (2603:10b6:408:13a::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ0PR12MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cdab4ea-713c-4c33-611a-08dd41454e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q+WfBoxZlunD2a4bNGGatP54gb6XPYwMU6vExGmxud4p4YDZ5mymB6vs2bba?=
 =?us-ascii?Q?Og9PX3hI+Dd008DI2zEy3L0fCrvhWMEDIgV2ZT8siNWuFwJJ/ss7OMe43S2G?=
 =?us-ascii?Q?SR6D1duqULcKlAPspWA8RRRvES6w6DWJJrmugpyM2vPMWW1mSagATN5H0hct?=
 =?us-ascii?Q?5DWUuwSVS8VMNEqIQtID8twSzMnD1V0KdWRh52ATjJERgDZN6wWSUDfhKQpr?=
 =?us-ascii?Q?BPcaEEAfP2znTpJr1Sgndj5VSwu4YQBIbTHjkZ8biCLh2JgIGyCzHD2sE8ue?=
 =?us-ascii?Q?o2AWk3uozaglEZzkOoDqGwGLuEJ8q2C94EzYtGmdp8QtKNIfqYIMA/otPXaH?=
 =?us-ascii?Q?4FK6sjVw5EEXwRO5Bk7G739hDPtN1l5IboIHlaqM1zzbpHRqQePkKSYfxPvm?=
 =?us-ascii?Q?9ixj/x7ehyfxdHZJ6WT0pT4h2WqxFVO+KPkOYI0tl0cNEUMa82RKCGSczSJR?=
 =?us-ascii?Q?QOcY3FYZGWfaSLhFT221pSSS00ov2QbOJDVRK9qhWXvN3MqUqDUmiA9de9J+?=
 =?us-ascii?Q?F+SBSoQ85nPJU7efeRkQeMaGa5vuwFIPmexZyeih3gmZuAh48bqfJYtJ49sf?=
 =?us-ascii?Q?nrsC5hrzvEBCbIXjHgjT1HBfDLhUyfkvZ5c+DaMwJQiR2N28RBevKwG9UcCk?=
 =?us-ascii?Q?lSgfHH0+lmpuwsw4SrAuautIuk46yFudGChRwYOLj26N4GqApeZWMd2uhzab?=
 =?us-ascii?Q?8ea0+rEeg7IssCxWiev7pZTvK2jXGnB9Skxx2KtHTUkZBP+Y6EF9JigzTkvs?=
 =?us-ascii?Q?aNZmceWhmim6+sEXNkL61G48pFDUjL34oQLS3vKs0IFOD/gbHbBoKBw6i91e?=
 =?us-ascii?Q?wPMM6Ca4vHSy2/T1yZUpG6OzKNd4nOOojQN9yuKDSpHwkFSv8cH+S2Br/zRO?=
 =?us-ascii?Q?DvuajL4hAhHvipqhRhIRZ3JhbiQl2D+OLCCY2TyU1pbCsVzT0X7kKnFY+FqF?=
 =?us-ascii?Q?QazFJ32ekc5K2/4tAtnisiOJqVGI7PAMVGLBgMQymaF3h6QSGUapBuDEI5FV?=
 =?us-ascii?Q?ABHQBa4G27yMl914wEi1WA5J7UqQ6hgJlUjYjPskUTlM9Nmzba7PvD8jxHTf?=
 =?us-ascii?Q?0xZM/4F+yMVQlZhHtYZVrmCSaqp2G66k2W3phmYvqgokWsqbOCUgyAoEVpoh?=
 =?us-ascii?Q?gImf1i8C/xR8rkmkV0xuUY/K0HDbKbVrJvIsc8PhIs9tXVpS7+yTp9Da/oE2?=
 =?us-ascii?Q?h/e915Pv4JKcSMI1xYdBVDKGl7syDwB0O0C8T7SQBNvX/YEyIxqJyoEsS0yy?=
 =?us-ascii?Q?PmASEbYYpYxanRaYUPEfSY+bxDyzaUCKCMnDvb5iGnx9Tee/M2oVulBk/jrQ?=
 =?us-ascii?Q?uE9/wiGzZiBAgtgswgPQSQZgt2dK8VvCoGXFNWKb9QTKFMkRiHp/tHzi+XBB?=
 =?us-ascii?Q?nnBZALgs4d+EJQrLW/VWN+AtH1/L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?COjD9x6yim2b1/VkKGlBE9VBAxHmjUNdW3e9Y1Wp6605givEweD2I3N3VWAL?=
 =?us-ascii?Q?0JHn7+ztWz2MLOwQ58IvsttqwUCHqDMgn33/WUQ8/WXsxoJS/GwuKW70TGfN?=
 =?us-ascii?Q?qh1x/T15DGypL7QlPDVFuHzHaDPpVTymBru+hlkZpWweYXgxBuu1A0RQRW1J?=
 =?us-ascii?Q?MuUAYun8GpjE2wY29f71JBrcigKHvaMzhDbwMhf0y/UldZF8qibOfr+nch80?=
 =?us-ascii?Q?i6r/E8yZ+Eb4V75cKoLXHJz+8wquIzbsuJ4p4P+MduPwokxtL3mrF+kGv11t?=
 =?us-ascii?Q?vBZoD6Wwh0CRjE3rwu6hvi5Xod1XZZhwv2UfuzivkESF+yXuB6/LEcFw62Mu?=
 =?us-ascii?Q?z3MwVJuqxldiC4ahd3IIc4W8/BPgQhkOO4w43aPS2hajpxlEugqZLiqv8DBn?=
 =?us-ascii?Q?wx5LU50UKSp5xuEvbJ3VcC3wAZvqVSdUaq1I3/aBB76pca2zTrtFhdH4+U5m?=
 =?us-ascii?Q?GBf1PI0NPzP1VX/BwyqMhezrzpRV7JEo2lujdZFG5aU6KvhC+DiVD5sbIi3r?=
 =?us-ascii?Q?FeCl16IsEvc1QoPIGCB2r90mOZShFZaX8P9RZXxrTKzCVHIZBzOi08VEMBUb?=
 =?us-ascii?Q?Y8ekryMAvzT8jOXinQnNyTjaSYQxlq0BCVNqCQgPHcHgimvJlPBdCBph4Bgs?=
 =?us-ascii?Q?a0WNsuXnDAXUXGJK2R9e4X+6suVfbvVTSqFl7+vn41Li3ysIOOM92yChu+/Y?=
 =?us-ascii?Q?owutNdMSrSku6ZonC4BSNiEoC2ANc/K9Gm+NI3BXrodEJryRK8vLMTvPIPDV?=
 =?us-ascii?Q?mI1VecVzR5tQ/IkvlDmsO7AFQEsw1EnGiz08zwLBknoK7iy26FVA/vNdtot0?=
 =?us-ascii?Q?TEsu0Rbo5VxSNJ8MDuIIHjfrlb1oRPiQ61Y6NdZbMhNJQBI4Tq3Y3rU088M4?=
 =?us-ascii?Q?NRCshEpvHiauqOBHBVbm5XOSB3hBPNeExJOkgk1dUIUdK7rQkxBcO5AqS5C6?=
 =?us-ascii?Q?r00SJStPTkTeBdTJ45XY5kvH2cVrYXwnW3u6PLpFLxceO2sEdOGJKr0EzttU?=
 =?us-ascii?Q?9BaER1tRaX8iyBd9C2RIK/O/9tIKOCGiROvW+cnBoVcReflYd+Z76upE5v4a?=
 =?us-ascii?Q?gegy7ixvu7vq/452c99cCqYIYt49RUYrx54shBFYrQ2X1ZgDCcfPmpRUfczU?=
 =?us-ascii?Q?9DtXsdUIn9GbFuZ2tJLN6rQNbGMtz52jcUJfvNW+/R17cykRyvetvxi2/vga?=
 =?us-ascii?Q?FeH8c2xKhKKWVP15LmZFfPeOOv7Zm+rSjr4gCV8dd8UnCbcbNVnWlAv+ND2Q?=
 =?us-ascii?Q?GLE8qzFy19gs7cDHFWlPekS82vzWazBTmTFDqLl77fDW3Kdb7SBVplRkno1P?=
 =?us-ascii?Q?eXJGYhRBeQTMMGmEx6ak5MPaOo9KTqU9sRd6e77AWIMgpd0Ey1DrRjcyogbH?=
 =?us-ascii?Q?HixPOV8vlc5KRG2LCNc0WPn2E/piIY4selTF0cJG7OswcFXwI9BLRM6JTvDo?=
 =?us-ascii?Q?jQMF9CAG8qCGr9RUPu+iXO/Q0rfwLe0owHd56NoDle6qpgM2Wb6VSDHyUvZ7?=
 =?us-ascii?Q?xRFcTdYsf8XWj2D9obmkXLXgEWCU6PZDOVQqcE0uPpOe7ERMEzBfykeAbpJL?=
 =?us-ascii?Q?r7JmVlnZw3YGu77fMu0QK0m+vV1NPl9x6Arb/0Sy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdab4ea-713c-4c33-611a-08dd41454e00
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 15:46:47.7827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwM3tJzzOVSmbs6nQiHnW7YFN90QJI6NZb1VFrqe5c3XEQN14UABxoVSl0Th50/o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942

On Thu, Jan 30, 2025 at 02:19:16PM +0100, Philipp Stanner wrote:
> would some sort of official statement by the "entire community"
> reassure you that the burden of keeping Rust abstractions working with
> any changes on the C side rests entirely on the Rust side's
> shoulders?

You'd have to reconcile that with the recent event where Linus defered
the MM pull request and some C patches were dropped because of rust
kbuild bugs:

https://lore.kernel.org/linux-mm/CAHk-=whddBhfi5DUi370W3pYs+z3r2E7KYuHjwR=a1eRig5Gxg@mail.gmail.com/

It seems to me the message is now crystal clear, and the opposite of
what you claim.

All PRs to Linus must not break the rust build and the responsibilty
for that falls to all the maintainers. If the Rust team is not quick
enough to resolve any issues during the development window then
patches must be dropped before sending PRs, or Linus will refuse the
PR.

Effectively this seems to imply that patches changing some of the C
API cannot be merged by maintainers unless accompanied by matching
Rust hunks.

If there are different instructions to maintainers I would be
interested to know.

Thus, I would not describe this situation as "rests entirely on the
Rust side's shoulders".

Regardless, it seem to be where we are now, and I have it on my list
to follow Andrew and get a rust compiler setup..

Jason
