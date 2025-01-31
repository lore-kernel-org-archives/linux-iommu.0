Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DA31CACF3
	for <iommu@lists.linux.dev>; Fri, 31 Jan 2025 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738331667; cv=fail; b=EqgiU2RtSPLXMj75Fa99VyAe7OrOZrWIRpmRv8P7VfCrbkBYslZm+/Ryb2R48uAdM4bDFJW9LFFsR3SQ5VMF1vznZsi1UDwBi8f5atggQuJ6Geo8ckPatvmYQi1VdJ5iJhpItdCW4zKSXId90VMAPmiGw1eeNMuFwqgdSseQthM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738331667; c=relaxed/simple;
	bh=uSee49nXaQ1MUoT2ts4kTLwDWEz16bLKF+MmrlQiK5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GatDlENXK4x+dUuWmgO1iXqpBUWUswlFaUuOPxapgEVBuMH//zgQkVd/srl7EgCq9PbfnsC6fkB4H7eitYdtVezz5Bd/QqFrNnEldu8SSFIyNvXVu/Ze5V0Ln+JUQgXzfMMZSdqmtnDuemOwrG2yxVX6JKIO8UwJhaW0G3OqumI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RyOMQUA2; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RyOMQUA2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONHSYcCNIiGVAUviFhwRTFxd29Y/RYBdEpDJMMNMRg7+8A3Q7yfwXAzM2D1dCTcZp8VuKcHMzygAzHWEwfUkcqtYk8MvL0bo7jkqdfpifndf52yA+X/SbWpSu3bEb950Ruq7Mc5QVrJYUlVwmWF3eb5s1XahkzwtaMosiH1yUi7C3gfq3w3HSMAIBmjo1RvNL6coPsEshMSigeSO5Jc2VrrwCAxPocdNBi48ya0GjWBep99z6UEHFPO6w3B7nOIfcwIMIzTxsfFDNs/RXE4+byppUAvpEkqUj3rpvuqumkMNn1kiAVJsujNTKTP6whBAEVqps0VFrDNfFn21XEL1eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9s39LJmDFevWmeWOco3ElCIt6Hj7+nxdWdJCm5cmHCc=;
 b=xN63tUuHheiZzchjIl5BCzoSaT/Z1mxHkQhPWo52QB4Tw1+CTuJswQkv31Ya19xHk1ibP8ZpYmNoMElG1kZl2SR7UlrSWQPk4Ow0R5RP1T2k9ly8vivXnRNP69kOWGUrFj6q4vgUJ52Y8x46UW4CcHcOHsOVVSAQqo3pXJOmxgjcQBIW1IwTf9WDEPny/C7K1aDaRuEcwpyQGkHekznu01TBZPXkbXYc2fIPB0QWEpusHW2+ccLReO9nGl+MR1S7P78w6A8kkcHkzNdod5Wk3sLpK69Qi3X+WxD+FylEnin+XE+gc2HXqutsxo5+OMhp4fUBeYFQy9XZYgvkbqnYBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9s39LJmDFevWmeWOco3ElCIt6Hj7+nxdWdJCm5cmHCc=;
 b=RyOMQUA2FMWGzSiRihDAIu4DW3GG+5lmCOxmYBNhQ6vI4nsGNX10mGyZwBIa6eDiGRMCFsx2/ioCJDbtfeBYejXVLaR2dMtZ/0/yEDaRZxN/NMY9dj5NwQH1hfsmv1lSOIfK+onh/vOR9NFvafABX/XxlWfplDGl+nfAJEMzS1NTrYGS8wc9MJ9gSkNkGBw2ptuIIsFZ5b2nngXhWCQ3GGm4WuuHFCcGMSt1QkYnA2TfjWWtgFqyg5fPvqslXuPmFQkWTpBWXksl30rH729rkEiWDh7ldFT4I18tMc7R7d8qvLg8lOIYs6MXoM0hjmlq9IeN+PWjCbIOSZ/jE3G0mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7313.namprd12.prod.outlook.com (2603:10b6:930:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 13:54:22 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.018; Fri, 31 Jan 2025
 13:54:22 +0000
Date: Fri, 31 Jan 2025 09:54:21 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: phasta@kernel.org, Christoph Hellwig <hch@lst.de>,
	Danilo Krummrich <dakr@kernel.org>,
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
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
Message-ID: <20250131135421.GO5556@nvidia.com>
References: <Z3-NqwAG_96yq8VD@pollux>
 <20250110083955.GA5395@lst.de>
 <Z4D5a5NYrAbNxUL6@pollux>
 <Z4kG5AcVeQKegLnb@pollux>
 <20250128092334.GA28548@lst.de>
 <293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org>
 <20250130154646.GA2298732@nvidia.com>
 <2025013030-gummy-cosmic-7927@gregkh>
 <20250130172437.GN5556@nvidia.com>
 <2025013148-reversal-pessimism-1515@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025013148-reversal-pessimism-1515@gregkh>
X-ClientProxiedBy: BN9P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 68696994-81d7-44aa-cb0f-08dd41fec3dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?22lzIPs834ulMZHv4U6+/PY22VAwhGQCXWO7xLng++yjWE0S8SeBCPz6JlaT?=
 =?us-ascii?Q?IjIJUbQfNC5rbpQ7IQOCtAS/6/JeVgCxzt+ivioX0U/bAgGQ0lr2Bz1R/m4J?=
 =?us-ascii?Q?koR/yYR0epOaGg4J5qAGfcrHmrvLeYXFr+Ympz99/Vszuw/U2ZwaUQ4MhM5E?=
 =?us-ascii?Q?UTdCMoVod3EqxmgL7JB2N4wL+eKnxVI0a6Byu6+b7qbxpjeVmArEHAvERWBM?=
 =?us-ascii?Q?OQdIZTKLjXLblN2/bl9VG43LRwR1OuIGm5Hpz9uOFEh8gR4NZUt8+Dj4vmhO?=
 =?us-ascii?Q?gYWzzR04BVRUQqd9ArOExK9C3Cp6S9hHXgI8Chw9NYAagCWiNkmkdOS3BNGi?=
 =?us-ascii?Q?XBHBbSMNw2FXgMjUNINurs/QZ8e0KS1BOMZ4T4CDbPlq7Y57fiAn9WHukqzI?=
 =?us-ascii?Q?5AjICHapdLZVJRWJAkKSnWy6jOeo1oNfBchD4Ki4+oR2fn0rWaUltcsYe84M?=
 =?us-ascii?Q?R9VdYc9cN9nyuaqGe9czMkMMxgy2nMrWohHBrv61tG/ERTIMFvkH4PP9pXUL?=
 =?us-ascii?Q?+r2fql3nsH+NbQh30AP8JWGVihFA+TIcX4oAOkSHwHl387cd24ihHPggdOF+?=
 =?us-ascii?Q?+Ft1N6+ZE76E7O9VNXmnBPFHCLT7nTg0Q9ustwGcdsQs9INkuzW2QcRMaK0S?=
 =?us-ascii?Q?m4MFw9gKNVBcHfzU0YmNaGf4onWzPQW3a9CQZNpEvHkeSzr/wWmtDw/f9QCr?=
 =?us-ascii?Q?9u3cmTXkFZ/WI+H8LBXYA4wIPXmOuQ36Hciu9Lkbc3EPzK6VJGW50aX9CnSo?=
 =?us-ascii?Q?cHZ1R98W50hHwBRkHaoynfo4zS5oX2S9gZGubzGyz9n+5C9wqRYCFHQc3jNf?=
 =?us-ascii?Q?SAriZw1Y6HgozOhZit3mh1yJ+D/NbqXQ/aqWRwwwgHOJhoPRB7VQ/j7iVN1g?=
 =?us-ascii?Q?2Mmkx1LfwAU8pRiHqOTPh0OosZBxmdaWcWbtCUKQwppc9dqZ6eGuRdf3+2w2?=
 =?us-ascii?Q?SPQ8OVhuIBxUjwJ1eH4x5GxtYpDDbFqr2X3Z41Dh0SzOinE2i9OvMa3eLFdH?=
 =?us-ascii?Q?glWObfJBck1mcWxbjOCsndsCrI3C+iRGTskfUGeBfdaTCGtqE2Cdv9JUjMYK?=
 =?us-ascii?Q?cwR+pRhNTj7zYqNutxIGzq17wQGIoDNMDzWD8NHpcNkay7YOpg8XbM4JKLwM?=
 =?us-ascii?Q?TE6P4I0HDG8ArchN/hv+DKyhbTYdJMpghOxq2osvIzicsZaAm/w3XxcLqdMQ?=
 =?us-ascii?Q?RWOOXMbXgO5d/gQdzizPZ2MeTZkKHqsjUzDWFmn2DvirJdEI3ucZvpwY2Ep2?=
 =?us-ascii?Q?O6C9G2b43LFTB45KfbnGuH5gp9mOt9mjBekaqr7OnqvJPMYgXQQr6521vzrr?=
 =?us-ascii?Q?cP28vootw+XFXAF1hOGRXGLj3BDSX5BSvSZlQgJISugm4eHED9EXAqurAAdC?=
 =?us-ascii?Q?/yed1ICw/17DLsko/Dz8zFLOaMf3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dwraqrb5JeHzfxcTDwZ84X8biO3rbP1lspK1BBL5HErm1S3Nwl8e/g9G6kFn?=
 =?us-ascii?Q?21yeANtUjhBrGfdTjb4qtCawquAHwY/NnKP9U/oSSNRrwcs94b4OIARkEXbi?=
 =?us-ascii?Q?mR8vdMfUfW7f6/H65pFv5FYiCR2iieDXVF66O3iQ+wNAuT5ZjwezE+lPT7gP?=
 =?us-ascii?Q?SCu2K3dyo5BiXawASJq5SfaS8h5hxKeTTKBl6r7sb3KxSwYXkNtIThncq4p8?=
 =?us-ascii?Q?MqKW4zrBhXFuVjN04g9rk7EsJM+TIZKk4ssfUdCvE0FXAUqQ7wBNBb2haXBR?=
 =?us-ascii?Q?o709eDgoEDCBhcjL9swi6dzJkh0XwIuqqWr9YblNTaDkb+bF09gTkc5rr7gD?=
 =?us-ascii?Q?jmyOgJTzJEWkFglTgEYP9Eiz9i6YpeivPk5WdBlUqMYfjuMrkNzcvEN441KA?=
 =?us-ascii?Q?qXW6jNZM8+C+NbqMyJxPcw4m6Uwl83Maa86XClkBR1dfk8pOUTlgHR1HaEwW?=
 =?us-ascii?Q?qN1/82eJZ7ZxUFk1U7o0PrmMiFDBcSPaVjfbJYGc/OFFgNdfcNfqUxjDQTcw?=
 =?us-ascii?Q?1ZlwbVGTg74YWUIne0Px9f6Y3Kv13Lh2z/vZUVJKJnEup8LoY+4lDicMpO66?=
 =?us-ascii?Q?Vel7KiOVSaY+bP7h3D9C9wK8iCFhnL2TD+y+/K2bw/VCJzJ1/kRkZHl4pl5o?=
 =?us-ascii?Q?kKBKweHAHAe+ChHSxpQkirDfNzPfa1xEzVE/8x8w8AqJHLW2lV20vWErB54q?=
 =?us-ascii?Q?UIyNPAKVT4TE140WQ+cBLCCAuV1pQv0BGSQu3hQd0gvKywAuFTG+ammkDmLZ?=
 =?us-ascii?Q?SbW6jz8KNjca3jn/nQrjpjdR2oTbshMih3qVnjAJ7xDNkYkqfT/SAdlUYtMb?=
 =?us-ascii?Q?XBfQp2YEALrdB7HvpAuP8CI5wRJTVLPz+0PIxmyg3ccHxrF5c1jSo9AwoPL0?=
 =?us-ascii?Q?4xyocJIjt+H5p8vOExzNNm1A4ff1UxCy6c9Hrx3MrGL5hnc5aKDEEHscxw8T?=
 =?us-ascii?Q?2zDZc8BJC4GTtlNoXrLgUEReqqduEhlBfqFhVDLa7RdsWdyje0Uu455pUlmH?=
 =?us-ascii?Q?X1aeBAjdvdr2MvcMaAx5TlmCUhRdensorfl1aW9OZWP/lCxDzjOh/O+dwUF5?=
 =?us-ascii?Q?lo6QPAQjYNEcR4qyCPijXd28bxsBm7x0ZH5Epo9i+dJxj8CljpXOZnDLMJ5L?=
 =?us-ascii?Q?rcQiP55e23+avOC8/Go93MoxrA0os7a7KcHlrnOEcsWdrKZd2Le1sLLh+X8f?=
 =?us-ascii?Q?EvpbYJlu69vOh2IXnoCTDUuFhrvHhz6MqHbBY3NMYyvM/loV4vYlSbyj9nDo?=
 =?us-ascii?Q?UkZsm5OJAzDCScRRFkb55rkqB08f1MTQk10ebF9PPtzup2C3nL3FQXLpK2UH?=
 =?us-ascii?Q?i3GBrLORdE6PDJnP5SqkPIb16i/MUrDCn4NPCymnluxyyVxDO8E0R2IojfnH?=
 =?us-ascii?Q?pgDimTVSagAFAvzgwAY0kYjjZoK9YGrZd43NhHpa7ixGI5gTUMG3aMb9XX7B?=
 =?us-ascii?Q?jKtgjDyTqhWnQI25AoIgdxkrjVTIBrEcondplrlWjY+aogRGAVCIb5W7mi5b?=
 =?us-ascii?Q?IuXv+PoBZSHMNP5pNy61Wj1P8EuZEYNhQHV1gcGFxGRnEDbMSWiYpM9B83LF?=
 =?us-ascii?Q?l7ERods1J1qzkq93vvFEGPRXEjG5XQL+NHA+B5rT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68696994-81d7-44aa-cb0f-08dd41fec3dc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 13:54:22.2205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sLdGB9xy4pIBOP068EkpFeJK4GgainGcXlUYKEuanbGceNjN1Nw7D/fAXc6wGS2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7313

On Fri, Jan 31, 2025 at 08:47:54AM +0100, Greg KH wrote:
> On Thu, Jan 30, 2025 at 01:24:37PM -0400, Jason Gunthorpe wrote:
> > On Thu, Jan 30, 2025 at 05:11:43PM +0100, Greg KH wrote:
> > > On Thu, Jan 30, 2025 at 11:46:46AM -0400, Jason Gunthorpe wrote:
> > > > On Thu, Jan 30, 2025 at 02:19:16PM +0100, Philipp Stanner wrote:
> > > > > would some sort of official statement by the "entire community"
> > > > > reassure you that the burden of keeping Rust abstractions working with
> > > > > any changes on the C side rests entirely on the Rust side's
> > > > > shoulders?
> > > > 
> > > > You'd have to reconcile that with the recent event where Linus defered
> > > > the MM pull request and some C patches were dropped because of rust
> > > > kbuild bugs:
> > > > 
> > > > https://lore.kernel.org/linux-mm/CAHk-=whddBhfi5DUi370W3pYs+z3r2E7KYuHjwR=a1eRig5Gxg@mail.gmail.com/
> > > > 
> > > > It seems to me the message is now crystal clear, and the opposite of
> > > > what you claim.
> > > > 
> > > > All PRs to Linus must not break the rust build and the responsibilty
> > > > for that falls to all the maintainers. If the Rust team is not quick
> > > > enough to resolve any issues during the development window then
> > > > patches must be dropped before sending PRs, or Linus will refuse the
> > > > PR.
> > > > 
> > > > Effectively this seems to imply that patches changing some of the C
> > > > API cannot be merged by maintainers unless accompanied by matching
> > > > Rust hunks.
> > > > 
> > > > If there are different instructions to maintainers I would be
> > > > interested to know.
> > > 
> > > That's not the case, the one you point at above was a tooling issue that
> > > people missed due to the holidays.  Fixing it up was simple enough and
> > > people did so and moved on.
> > 
> > Regardless of holidays, you seem to be saying that Linus should have
> > accepted Andrew's PR and left rust with build failures?
> 
> I can't answer for Linus, sorry.  

Then I think we need a clear statement from Linus how he will be
working. If he is build testing rust or not.

Without that I don't think the Rust team should be saying "any changes
on the C side rests entirely on the Rust side's shoulders".

It is clearly not the process if Linus is build testing rust and
rejecting PRs that fail to build.

> But a generic "hey, this broke our
> working toolchain builds" is something that is much much much different

It broke some builds, it sounded like the typical rust build was not
effected because it used the same version of clang for C code and
bindgen. Linus was mixing gcc and clang in his build.

> than "an api changed so I now have to turn off this driver in my build"
> issue.

I tested this theory, allnoconfig x86 build, enable 64 bit, rust and
PCI only. *NO* Rust drivers enabled.

Make a hypothetical C API change:

       --- a/include/asm-generic/pci_iomap.h
       +++ b/include/asm-generic/pci_iomap.h
       @@ -18,7 +18,7 @@ extern void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
	extern void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
					       unsigned long offset,
					       unsigned long maxlen);
       -extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
       +extern void pci_iounmap(struct pci_dev *dev, void __iomem *, unsigned int flags);
	/* Create a virtual mapping cookie for a port on a given PCI device.
	 * Do not call this directly, it exists to make it easier for architectures
	 * to override */
       diff --git a/lib/iomap.c b/lib/iomap.c
       index 4f8b31baa5752a..5b63063a1a811f 100644
       --- a/lib/iomap.c
       +++ b/lib/iomap.c
       @@ -421,7 +421,7 @@ EXPORT_SYMBOL(ioport_unmap);
	#ifdef CONFIG_PCI
	/* Hide the details if this is a MMIO or PIO address space and just do what
	 * you expect in the correct way. */
       -void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
       +void pci_iounmap(struct pci_dev *dev, void __iomem * addr, unsigned int flags)
	{
	       IO_COND(addr, /* nothing */, iounmap(addr));
	}

And the result is..

       error[E0061]: this function takes 3 arguments but 2 arguments were supplied
	  --> ../rust/kernel/pci.rs:320:13
	   |
       320 |             bindings::pci_iounmap(pdev.as_raw(), ioptr as _);
	   |             ^^^^^^^^^^^^^^^^^^^^^--------------------------- an argument of type `u32` is missing
	   |
       note: function defined here
	  --> /tmp/x/build/rust/bindings/bindings_generated.rs:3:1444598
	   |
       3   | ...> * mut ffi :: c_void ; } extern "C" { pub fn pci_iounmap (dev : * mut pci_dev , arg1 : * mut ffi :: c_v...
	   |                                                  ^^^^^^^^^^^
       help: provide the argument
	   |
       320 |             bindings::pci_iounmap(pdev.as_raw(), ioptr as _, /* u32 */);
	   |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Build fails.

Can't seem to fix this using kconfig without turning off CONFIG_RUST,
exactly the same outcome as Uros's case.

Doesn't seem "much much much different" to me.

This shouldn't be surprising. It doesn't work like C. Rust builds the
PCI bindings always once CONFIG_PCI is turned on. It doesn't matter if
no rust driver is being built that consumes those bindings. It won't
work like staging does where you can just turn off one driver.

Jason
