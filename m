Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC3C20E03A
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277906; cv=fail; b=E2PVnLnEEWiXe0x0hvqEK5dkKg7F5fqHRZjfsJfZGw3Viycn0qXkxtcCAFR0GsRreRlkv1sz9MbDkfiSq2/uY4n9k2+ebikZsigG0RPkDezVj6KSYco3B2HgtLhkuwD0qNEJRRW3QY4VidUwxTcMgiLr+AB2GHWlrpXADaFn6gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277906; c=relaxed/simple;
	bh=WN7CdM7MP6ByV8K/1meMPxU6UjbG4QUHUIH6b1s1MdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lea1MmP5jj+Q4DXpsGndJv+KNKNHoGWhbHuwEEkbpgiLN47zo3l0ACpyRbsQOWhZMxmOSzzs4GoJ2ffrrqy+oAk8nF39llveJFBNe0BAWt1supEeOFu0+Fti/hek6iuCRSSB48z5Zi2YS9Rp0XM+bwUkuGVtncIhlNMGU6ORTCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MX2JNkal; arc=fail smtp.client-ip=40.107.95.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MX2JNkal"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1b6SD5aYssn9jrTAYqxn2/zM3WrOHCb5BUkHN5TBZL9BkV1od6j9+xE4gaI8b1AGUib+8v0vQdeFv5pAFLEr5hGXXwhJ1QbpUg54ZTL0PzGbGJrie2Mg9P+xiXAMrGWjVlLZVK7vd6qyQ0oyebHVJ8z2J+D6MzXi0Y6s10Opc79iN1um/Vn4vpEVJmQOePSyDN5SI2218f/IaN2YM8Nh4TNq57sj5aA5ct5DFyBbSipPxkAimhE1/UUZXR9z33tn7PfN46Qol/3CRafnzfFBQodjpO8FyKBz9bZLnk/x+k/eIMAQjHaNogUwCDPC/BSlnqoSRsDnRXOeQUUybAlYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aF88dwvp9myFJitMJeIDzJltio1YDoK8AlWKPI/Tpcc=;
 b=g17GUfJegE2Su6wqyLmyDH9+6hzFOAK1qqNIB4NkzDer3/idO/zHiyT5HJqKLc2hb/KRJWSBmQ7haEW9sw+tAtJ2UpYsGc5v0DUdOqW/aEgfm/dlbBqnQOiKZcAunRDe3YkVysfzIJhILPW0AZnOfaPGCABDIu5lcbOnaLh+IHccfwQINCZfqC3Gd2reWzadqYQftypDBWAMKRGj1zZ0zecztXIRyQ9fKEENMoe49BkFexOpwH+DPurHq5xi3/2DL7eiCYI6mjvbiPM7zIY3aHYV4jy79N7RcqNJw12XCOhxjW5eMu37Dkk3CibV9cmxYdX7g377ObEAlNGN3foY8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF88dwvp9myFJitMJeIDzJltio1YDoK8AlWKPI/Tpcc=;
 b=MX2JNkalvi+6JsX0BXkLTS9El4vpXKcwOrKTxZDIbNvg7U6F+mG/F9V2GyzocEWbiaPDppTabVIb+xxTlO4jUIpRZanyklkTI8NRDnTulcy3EkoYbw1Jxy8epm6dNU+YJhHDjjDhPNUUOobVC/ZWxeMg56hXp48oR+kYaqPYwJKjnnoZj7Z9E63WWQSqDSrOKld1DZr0YlPOc7DZ/EurY9Uj9lsylm67adgxIlY2acTyOqexMIkvksV/j1uB1VZNcb9nh1Dyfh9KZFJiDPOQQlkfDGUWpt3TzjFrRgAxKNgqNWxktiVWk+lpTcZaHgMDrRsvrP7xChISwhqOv3J9HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 16:18:19 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8511.019; Thu, 6 Mar 2025
 16:18:19 +0000
Date: Thu, 6 Mar 2025 12:18:18 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, aliceryhl@google.com,
	robin.murphy@arm.com, daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
Message-ID: <20250306161818.GG354511@nvidia.com>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <20250305174118.GA351188@nvidia.com>
 <Z8mlAxsszdOH-ow8@cassiopeiae>
 <Z8m9j3SwWHqaCTXo@phenom.ffwll.local>
 <Z8nFJjb30_Wm3cJJ@cassiopeiae>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8nFJjb30_Wm3cJJ@cassiopeiae>
X-ClientProxiedBy: BL1P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BY5PR12MB4195:EE_
X-MS-Office365-Filtering-Correlation-Id: aa104ece-986f-409f-43f3-08dd5cca8207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uClv2LpwinHQ4Nxex+/QT1mqlNUelMQCpzbOuFDrR2qWOq/D+MSWXSY2hNlQ?=
 =?us-ascii?Q?N9eVD3/udFpHdCsfIDK819cVmkYxFvoTWJsh3uKfAvskVmDcXb1SlI5xci3Q?=
 =?us-ascii?Q?WSrrE3FTnwXqkVfA+2Ie/XS8EgQ0zlVFJ7/Hp4AhfvpSwDHO0genRV7DyPej?=
 =?us-ascii?Q?oZFblsR1MfXLo4g49XmCSk8nDnoxbUMAPaKaIxYauMLAdaIqiOGfjh5074vz?=
 =?us-ascii?Q?ybw6dVEqspMlLjDDXrgt0cDKAMKnlYmlvuDOlC3c8LpgQGuPtNilONqmkkKq?=
 =?us-ascii?Q?KG1aWswO1eI6uMWq+a4p0GapU4+PFL9KCgxJkCk7K+KlboTecDXvaicAkrvx?=
 =?us-ascii?Q?+54J8yr5/aMPgf3NRTbQsefa6wfOUli5PCMc+TC7vReC4eAISBdyabAteLyZ?=
 =?us-ascii?Q?k7rq+frUT9+TNJhUPRY32ph44HpKhFrryDMJhJ2RnNMyhhnGSGxuW8EbKgt1?=
 =?us-ascii?Q?8qE5LDf13RGK3JnS1acc94XpdB+h5286JnTaQ9459CKDi/HVKJVqbohy2zDW?=
 =?us-ascii?Q?qeHDnSBjemiVUNL7ff9QfFc75MnlV8EdSPYWYqajYy0PitErb+V6NoDdBMUD?=
 =?us-ascii?Q?kYyz3jAx0jC/lCrb9zO7XmuLNE3D64Z/X5SKp5ah0Doiep/h7UexGsOqwKbu?=
 =?us-ascii?Q?h0LMzzxG27F/zRLUuyXrgYClTndQ2GT8OKmTdusLw5iuxRrfOdmYtyqFAL7J?=
 =?us-ascii?Q?kSHo5evJQk8M8SffG8qPPji95aKwYqfN2XwvcfRnvmzBNPAYlieVgL9dMzrx?=
 =?us-ascii?Q?digzCu4XGs4QaSQ9qgniq3ofsuF1j9AnLJ8JThfHETHnv2pLP3GUoyYv9ALX?=
 =?us-ascii?Q?UIH73Jcke6V1QjUMMnHWL9TP/b7h6mK45M2Pk4ZSBaqGB7sOg1Q/3/ecQGId?=
 =?us-ascii?Q?4+3U2cHSou97ZgVE9A70IjFJYAsUchAESrz3WQwWjbav8zqVLLpn355gJqfk?=
 =?us-ascii?Q?lyztRbPRNIEsHLOTbp97DHIbfKDX6dCpWOjJwCjCrzH0q+YFSCISVp1n3+ZQ?=
 =?us-ascii?Q?HKg6Ljtd7RdEatjXVcNz2BF+EuvFPC2yW+DfBi85HZVfIbobpN/arUjdx8oI?=
 =?us-ascii?Q?DKWaQuY2DSvQUyvuA2eHMi4x+9NnvTDmDl9bCbaCFuhDFQxLP5GGFxZgr0bs?=
 =?us-ascii?Q?MKrx/10eM/ir8cyg2oLkLxnK7cKipwWmeK71AWAQKcH7fCnrlXQQ9xtGf2nV?=
 =?us-ascii?Q?gUj7IiFZG3RF2QWiYz7z3zy48XXdCcb29DtAIy57eeXkKLEyE3fVlItygarb?=
 =?us-ascii?Q?2QbarI3ywl5WOQDG/OqY37VL0CP88RXORqW6LEfDhGrpQZklzXNvp+xecaTD?=
 =?us-ascii?Q?fQaNVQJjWyfqYZ1WD/He1XSnVdkFqVRZuN6pn+kmxtthH+IOS+yByWHcx8FY?=
 =?us-ascii?Q?GBvRDLnNecjf225y0WPX9ObIAxAZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fyNemD8ztzj/+F2LXJwOTodjQTR1o0qXuAPsI8GU/eijcev1eV31Sc83N8d6?=
 =?us-ascii?Q?EISf3e4WQbhORHgeHssrqdbdPlPQyQ1kmsWd7J/yFU7r93Ix6EqGJJvD1e5t?=
 =?us-ascii?Q?pXvJGFu2AAZuOsIxdj4jeXyKq91TKXayg84YjxpENBoDAVVOEjJUM80xYjfi?=
 =?us-ascii?Q?bgGVnTmET5aDuzPMRGnGoJKyKMrcO/8sININsdDPlLYohrJUV3h6+0awNxWr?=
 =?us-ascii?Q?dIDEhHSsgyjP/HHUtMavZqLrG+Dau0px193w2m2LnZyF5OTxRVS/YxbHYGTK?=
 =?us-ascii?Q?wEq7+qCvK66UKIreaTcFG2bqt5H98avUzMJNtaYbskl5a0ShzBvuGWcLnWxs?=
 =?us-ascii?Q?ZpD/G3ll4mbp7r7v5TVcjgUl7xw0Z9zCZEXGsOP7mMCDFBdxrvvjaVKFCDJV?=
 =?us-ascii?Q?3Vo49SkaLG7lM31MXTyXgER0aCzuPoxye0yfMHtWSP01WOp74P02d4uZz4mw?=
 =?us-ascii?Q?oFY91aWsEQDFJGrgJj92NvWYqCtTCZJMLlqHOG17fzLs8dD0xTR3g8U8x3hX?=
 =?us-ascii?Q?HjT338pLu547mVRF8WIhZxtsHT+kcTJpDvuoIwxMn/XqFnPm1XB5ShVqEKCn?=
 =?us-ascii?Q?3mcGCewOZGP/eWd3CDQ2tZeDBV3M4GyrzQFyOpBxge40pyU55KxBotRd2wYR?=
 =?us-ascii?Q?cEXbJH+E3kU9FwQu2hWUuFYqaocAALWZcgTull9AtG/k/NJVQ29m98STy/mf?=
 =?us-ascii?Q?lCjIZsJWvB4aB7kAugwQKzJv2druROtE+zRtZuHWB/PH7OvhZ5gOGEBIL/uB?=
 =?us-ascii?Q?UhpecqYMd4jPBUhMlshzR8kiHPHS07ml1avRwiBpnG1bc5qR8J9TeKtk7EYz?=
 =?us-ascii?Q?czn1IGfLFl6YFhfSBAB8gPp5jnhJwoAolvRepWR7cVZajO/V6n5A34UP7ID7?=
 =?us-ascii?Q?buAxxtvyCedOhbddXGj1wQYLKWNu/4RwxoULIVvf2V2zNoj7AD9taxL8m6Gj?=
 =?us-ascii?Q?VMoN8L6Z4K7fStgUat7HInhh7u6YG5q8s4z9W/6gB6GVTLmlCCxI8EL4vtaa?=
 =?us-ascii?Q?HrFtU1dezN88ATnf21i1gPKGoM54w8+R9i6mpwZ4vkhmP4bnmANKTxPHvZDK?=
 =?us-ascii?Q?ZuHIlixjCLqxrC1gMyEXOG7YXSrjyW65N6rsFuCe6jpafXHpSw4TYIbWscCS?=
 =?us-ascii?Q?tiEdUKiK0u+vlJoKNhXafND/72hwt1u5HVMRLEi8ZrOiTzX/5Q9SFiEdBCNr?=
 =?us-ascii?Q?1flp8Zzy/dj/QRaQD2SGxWiVYG75Em358+J9jMxi1P8De7sKJ73azhMZK0cG?=
 =?us-ascii?Q?d6NUIKnt1vw0XBNTF9/EEwmnZK0AA2hINm21TV2Z7CxzDQY3ank6uIJHjBSm?=
 =?us-ascii?Q?UfHe0bixxZEBAHwTs1+hCGRVC6ZSVTPOXWg0F3DAMExY5QBXPW5gQOQ47HCI?=
 =?us-ascii?Q?q4KGJN+Wz6di5wjNFwjXplmcSXCkyvJDLM2aEox/MK4XFtbjWxv/zVYL5vf4?=
 =?us-ascii?Q?y7Xn+upeuHJ6BConQUcIQQLtphiqMnO23rlOsaTGKvMjiWa2v7h3xsu2uRHb?=
 =?us-ascii?Q?Nfra1eOg0SxRvlNvKVX8TwnDODAtHcf4KHf3zT6JOCzQL/0AzkqBPCGWysIi?=
 =?us-ascii?Q?ZWlVJGDoJPbH3Kx8NwTibltM10LbCdUASS3ZpruC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa104ece-986f-409f-43f3-08dd5cca8207
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:18:19.2613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTx7whJ9/RD0G6i4/+VMIi7fIQmvUxZhBtNc3kdFKg3jzfwFL1Er+e+IxiKGogAh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195

On Thu, Mar 06, 2025 at 04:54:14PM +0100, Danilo Krummrich wrote:
> (For some reason, when replying to this mail, mutt removed Sima from To: and
> instead switched Cc: to To:, hence resending.)

It is normal, Simona's mail client is setup to do that.

> > I think for basic driver allocations that you just need to run the device
> > stuffing it all into devres is ok.
> 
> What exactly do you mean with that? DMA memory allocations or "normal" memory
> allocations?

Simona means things like a coherent allocation backing something
allocated once like a global queue for talking to the device.

Ie DMA API usage that is not on the performance path.

> > But for dma mappings at runtime this will be too slow.
> 
> What exactly do you mean with "DMA mappings at runtime"? What to you think is
> is slow in this aspect?

Things like dma_map_sg(), dma_map_page(), etc, etc.

You cannot propose to add any runtime overhead to those paths and get
any support from the kernel community. They are performance paths
optimized to be fast.

For example: proposing to wrap their allocation in a devm container -
allocate a tracking structure, acquire the per-device spinlock and
thread the tracking into the devm linked list. For every single IO on
the performance path.

That idea would get a very hard NAK.

Jason
