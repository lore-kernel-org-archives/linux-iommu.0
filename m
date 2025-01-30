Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858BA1EEA44
	for <iommu@lists.linux.dev>; Thu, 30 Jan 2025 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738257887; cv=fail; b=IzDOaL9O2vIc2rjlXnjv1nFGScQqcSOBb76Q+JrHVWpQ1gWcm5JzyELLzv7Wig7BamOMP4gRPagjxCvZsUrrN7JH1vieCIEQX+tXy9aToz589RF+IOB+NGzh9dufvFdKOb9+juOQ2+5+EBbJcxDfxUILYgMNF0BkXzt99aq27VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738257887; c=relaxed/simple;
	bh=HxBmdCwzU0V7m7MtY+P6d4utm0e4RbRi52aFMxCaJdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s5g97WmV0+zJRv8/5AKD2Ebe6VfU2Jk/yVhjX5meywt1kVgPgota0TxJkxwV7WPR4VzYSyAS0pvU20xkPtXVkc9u1KFqck471E5UYOsLnVHvmX+HJzvxmVWHsfWFs38LZjtSM3hG4K29TANI/QCl2pUHaD9If5DZaSVltWV9SNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hYQ+IxFx; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hYQ+IxFx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktKIxRG5CjX8CfkndTSCkRakfnDfFvZ0hzStWBX59F/4Y4Uq3Hc4bxc6kRUzBk1OOMXNVIFKJzCXoPS2EcT7WwukEZaLQ7aYbBlpfURc72lF1x99NYnGQOSP0bp3hMW4XmEcV0D5+WKCVrV59jvrzp/EeuFutqiDeJ/WSdE6ZQYJQi/gyIdMztWBFTgRzqKUf/VAV5W8kQ5c/9Rn4SunqAD2KbaKvDqse3xZtvTooChBZ77SOQDioPsx3DZpakBgvcRUwHgNBu1deF8TGdtRS9Rep9n9eW3xvMUMH65vJ1jLLQ0isl/+iEdFXT7ldugKAQ5duwdZ9onIiKGcPw9NSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7kPCqJoOS5Av/thofqzB2T4kcjVdJOUKcUas7o+wJ4=;
 b=YgkSkGGbdvtElrXmPrcZHgfeo226V9sIAVeFK6xAkHZ1DFDADBWUm+pPSROsDHvlCG8n7+iKgEG3/w4+cmxAwqAjIEJ9UvpHr/K0qTFTFD6PGlPo3aQeKsL2uiXLpMTj4jxp87FUkZJ3MhHFWhzat0WDBJOz80PeaQTXR256iFYYIj8SnpINjJSnxDYDJgbgT6FQBR/EeypxlyNSOTtCZitSJxZU7XqzVeirwF+0KqcWA/9Q5W9u3s0QOVdRByW3UAwFVe6dULl2kUcjK2CB2eSSnmvcKHpt4R2t7chYf4fa4sMDO26bV6q33lNYME1jhxGoc8lAXRXwO1I43/1hWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7kPCqJoOS5Av/thofqzB2T4kcjVdJOUKcUas7o+wJ4=;
 b=hYQ+IxFxcHqAOfN9DKiMXez8J/eLTC9O0CL9DGgcmh+VmTi0awdsfrxz3FieU+28GFfcWZVNYK4kC6S5+6bkj2Cpw+YVXZrMkcEUmYN9F2dJBVqCM0p+6mQLiSiaXSYf9qVcTeUt1gt91qw5RO5Mp7vK4CbmbRLI6F8JYE0tKDAze1WPd2WIu9dsVZfUn16WEBN8Xow2gu4aj4KZ48ymFd3wINJ376jHs+ZyhXATkHsrrYMRLVKxpdrR7ugDBsXJTlpMAFYQp1VB2dIiALBtvRUk8sjVxXc+fpRxrG/3fP55mm0vN7knfkNffuGUDmYnvrUwpLbqfNXr3aMuYEqUFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6553.namprd12.prod.outlook.com (2603:10b6:208:3a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 17:24:38 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8377.021; Thu, 30 Jan 2025
 17:24:38 +0000
Date: Thu, 30 Jan 2025 13:24:37 -0400
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
Message-ID: <20250130172437.GN5556@nvidia.com>
References: <Z36X_ZnCmBQBMoZ6@pollux>
 <20250109080812.GA20431@lst.de>
 <Z3-NqwAG_96yq8VD@pollux>
 <20250110083955.GA5395@lst.de>
 <Z4D5a5NYrAbNxUL6@pollux>
 <Z4kG5AcVeQKegLnb@pollux>
 <20250128092334.GA28548@lst.de>
 <293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org>
 <20250130154646.GA2298732@nvidia.com>
 <2025013030-gummy-cosmic-7927@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025013030-gummy-cosmic-7927@gregkh>
X-ClientProxiedBy: BL1PR13CA0236.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 41fcffcd-bd4f-4b80-188f-08dd4152f91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HCDGWpxrFDJCgFH6Vu+R0zX+K51dFJZs1x449xVr6lYBiUa2gQ7XlmAtCgAB?=
 =?us-ascii?Q?yY0UhOPly/LF5SXShtmECBZx4tSpZ4P9T7zUI6dhIlnvZLWuou4gY1aCjyXz?=
 =?us-ascii?Q?xJqx7D6eVhDSe9i/A7BOseRD1ZPZbp+pHa5nuLewsTiuZ2fnX4mZh+ojH65q?=
 =?us-ascii?Q?H/auJ9V4IALU1S7/LgZH9gADw1TVgFJPoSFYFo/ud0YQNDbJJ6b9CnyQ+TF6?=
 =?us-ascii?Q?XmXMvC2OA6VUv9y+thPJlxu0kTm7b5Gf1SEyoNtzixD7cOx6Z50ehzPTqW7a?=
 =?us-ascii?Q?Y6S36kP11FXFs5D6i+yONbl0o/1i35LVfd+HE62U3dz9VfuRmJsYYTJKGtiY?=
 =?us-ascii?Q?jg7ngQGnrbtg9DpXEtDNpYJUw++lphi3XnPz1+eKs+8m0d14moxgOP/o9rQm?=
 =?us-ascii?Q?yYkvSNcXjEe6qk6q6cFblcYz0Nd5dKQRQcGhH9Ocnz7JYq59+7NLGjkOND0B?=
 =?us-ascii?Q?yWXCeaPUe9rWWAxpbxj2XQs2kAwo9U0nSFZsZJqAlw8/yQwWg1bAL6BL0sf7?=
 =?us-ascii?Q?asBQ5CuNT6KrPQUo9cfAaqEKdltlIiGj5foo1Tw/gVn0lM44qcKft7G05AE2?=
 =?us-ascii?Q?+Bp1Q2GKIHsn15BjgtZg1A+EuV8p/dtkzby5CZwrZqY52ZVH7DWTaizD9BeR?=
 =?us-ascii?Q?gEzYhDOJxV6Vo7rJcgcyBk9+V94HfC9raZL5epme1NluTEWJrTKZE7upWT+j?=
 =?us-ascii?Q?T7PAjM3t9ivG5ggS7QSNTMryy55ng8Xuah1tKwKvDQwbxkvphujpXc48yTDq?=
 =?us-ascii?Q?wDehJ0jr8oQzrNZ+VwdnCQTuauBG6kgEm08fYT+EsUmbJ1xmecjVMb0AP485?=
 =?us-ascii?Q?tOBBycwE7S5Y6RhwVQehbjMVLM+Yn7DnVMhNJIrv7lhKLKW3wwMHHoeTpKwn?=
 =?us-ascii?Q?r6o66BNl4cwn0zB/jCtTDUOEAE2c/kz+/J15znd/3TOVVQZeXP5XsEg4gNUa?=
 =?us-ascii?Q?dD0WXVjmZkn/4u1Fxiulr+Gfb1UIDfvXjfgRxQV3ymmJqm88VLofOStgVEf6?=
 =?us-ascii?Q?P/M1pQd24b0V+feYmvcgc+cqctzWTxDXE3ZL8M3diEazRwB2sb099DIwebaJ?=
 =?us-ascii?Q?Gb1e3c4Mw01bcCX04AWBYmQJG4KK8QKpWeQvslT/6b8BrtnRISd8IrKILhij?=
 =?us-ascii?Q?w1TyxrhfpwClBvsO3kf/jG7vDJLOO0MunH7WYx2ry+Tbb4geB/Mokv3kUMyy?=
 =?us-ascii?Q?4QKAVo0IOerowLHsq6OYNvxYNRucMeopQPuOpndvWY8gc0fIYhEXWS7DknfJ?=
 =?us-ascii?Q?QhNCt7Oq4l6LR4/v2xxkxIz+MD4OYbCtH4PfKKlvMox3wqw+4oWxjeT0fzgM?=
 =?us-ascii?Q?IbWRbeOYLKyEMRvX3A9jwHzVeq/ECIUxx8SixIZM43lhDYXYyCUe7qXUc078?=
 =?us-ascii?Q?LSYgq74JL6p/hdm5bRCH6kHknsW1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3uHNppUM5lx3C5mkuzsQgW0rHuvtsN1S6xpaWzhnO/FrUDMbjy+NjYNnvKua?=
 =?us-ascii?Q?vcEB4r4txhOIuMggMxpxPlGmUKmVJhyu2eyPfmd4l7mu6LUQ3zv6XPADfJkp?=
 =?us-ascii?Q?wVjOsviZ4Lut7hANJx+mhWC1xr1a0DwY5Jr9/iY2ABtNnECkytQlsBZj3I0a?=
 =?us-ascii?Q?uPaUhhdnXVgCBj/R4yckF45HDgknoASm5I/qvuO1wWUIlcU9gVJxt+vVlFYa?=
 =?us-ascii?Q?QqMA9k7P+GMcuCPYrTrlgWEqOGw1UfkvZoB+Z5atEZqxKPiKfNiTw6xDA2ev?=
 =?us-ascii?Q?SZjD/JRu9n37d6gP8Z3jEfSjgywZkU2Kz6DbrizMnpw3tuiKkHIlEGjCHSzS?=
 =?us-ascii?Q?v1Ae+NdNpR10HiFh5OWYI5lOfpt5MLrw/bbNQayRAtP455RqZkR5TazV+tAc?=
 =?us-ascii?Q?+k8ze/jfFdWNxd0Zt4Oih9IDQzdKG2AOQCnImbekDi0JwdnhqetGZPxA5tMn?=
 =?us-ascii?Q?354FDQUNE1BIbXkTB27PLyxg6mUw0yiyNCnf+y4PKtEAczxz08MpTfqlQMu7?=
 =?us-ascii?Q?XK/1rBlQ5NW8bXDa8vbWJsZDLTbUmyWjIlNG9MX3UtNiQzv6m7vtLAtzMqvZ?=
 =?us-ascii?Q?6AXcHSpix3/2Ihh6bH9zqAC+V535caH9GtgrxuUN1ytDXfZ5RsP6ZfRlxJpl?=
 =?us-ascii?Q?ZmMnqDk5wvQD9W0fLeJlk0XtCNy6C0MtkR6T1lWkgiwFkscd1o6VEmKVO4M+?=
 =?us-ascii?Q?7cQmrfOp5tiLOVIWQOmznsRmc25l5odu2doYcQlx/1m5JvGbE53ZawxIU3Rl?=
 =?us-ascii?Q?XTCVwZyM7g7SheGsaNnOyt8MPYSoOU3O+HUBjBWYOqDs9hEN1wFnNpQsaBch?=
 =?us-ascii?Q?jCdalTsZbli6eXM8olYbfj1uG4BO2CHESk5Td7KeIgnRgOPtar1o2Tq239w3?=
 =?us-ascii?Q?HxQ3lLVCKVQTCDnyzECpwFzMQkPJ60becubKe+RrCdOnbAW5vJpy6L7so0RL?=
 =?us-ascii?Q?ueTPz7FZKGT/wOopE2U/9sfB0LzKBQ2/iNQgLCS7VB5+vfH02rbO1oPkNJvy?=
 =?us-ascii?Q?eASyoes1wCZ+wlwg1a+vPAHU0eAjdMQ/cyFTuaAnZUmJNroxgUHzT2zW+Q1a?=
 =?us-ascii?Q?z1VnixxPVmodAb6UEzQ6Nyp8CvurJr7Tgyjt1BKBmDgJQbPIjvMc9Pcwd6DA?=
 =?us-ascii?Q?1Dng6NXTBC+FUtAdjAdRFgjMJC4j9y1+V9VhzgVVL6tjXWMiM9BUeI5liodh?=
 =?us-ascii?Q?EIZSdL1BRpnGBAQaC864E1aj52/cFak31+mzlBplU1AQliShpeRrJOU6gpNu?=
 =?us-ascii?Q?edpNf56pceITMcKoVmRdNDHiasPO7IemHoQJCVNrwxDPaBlLkZKtz0V2llB9?=
 =?us-ascii?Q?6nQa50k7RA4OMXUt/UaRSyTHM8Fwrl420kFsm6AjkOoO2sWZdzBWT3Pb0oNU?=
 =?us-ascii?Q?g5D3yF7T6HIm8SQDaKrRhh5AjVY8B0qjSdCb9+VZrfpPGj3dbbQhHwfH/mP2?=
 =?us-ascii?Q?jza8qpJdv9bbZv65KBa9Czj9x4Xg0fLQwK0i+D2Rn/qhaR9CoxJWB4qkEY36?=
 =?us-ascii?Q?0ccK9xaO099JYmnhnT/EMhl+WAswulePUxGUVanfMC1incUNmXKJtYtzQGi1?=
 =?us-ascii?Q?mS7ZkO8GNlydw3TElm0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fcffcd-bd4f-4b80-188f-08dd4152f91a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 17:24:38.1436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hq6V6p5LesheCNhfWGqCXbRQT0/cVZ98fc5kvv+YVTmDt0o/qG2Fae4DMCLzh5mq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6553

On Thu, Jan 30, 2025 at 05:11:43PM +0100, Greg KH wrote:
> On Thu, Jan 30, 2025 at 11:46:46AM -0400, Jason Gunthorpe wrote:
> > On Thu, Jan 30, 2025 at 02:19:16PM +0100, Philipp Stanner wrote:
> > > would some sort of official statement by the "entire community"
> > > reassure you that the burden of keeping Rust abstractions working with
> > > any changes on the C side rests entirely on the Rust side's
> > > shoulders?
> > 
> > You'd have to reconcile that with the recent event where Linus defered
> > the MM pull request and some C patches were dropped because of rust
> > kbuild bugs:
> > 
> > https://lore.kernel.org/linux-mm/CAHk-=whddBhfi5DUi370W3pYs+z3r2E7KYuHjwR=a1eRig5Gxg@mail.gmail.com/
> > 
> > It seems to me the message is now crystal clear, and the opposite of
> > what you claim.
> > 
> > All PRs to Linus must not break the rust build and the responsibilty
> > for that falls to all the maintainers. If the Rust team is not quick
> > enough to resolve any issues during the development window then
> > patches must be dropped before sending PRs, or Linus will refuse the
> > PR.
> > 
> > Effectively this seems to imply that patches changing some of the C
> > API cannot be merged by maintainers unless accompanied by matching
> > Rust hunks.
> > 
> > If there are different instructions to maintainers I would be
> > interested to know.
> 
> That's not the case, the one you point at above was a tooling issue that
> people missed due to the holidays.  Fixing it up was simple enough and
> people did so and moved on.

Regardless of holidays, you seem to be saying that Linus should have
accepted Andrew's PR and left rust with build failures?

I'm also not sure about moved on, Uros's previously accepted patches
are still unmerged:

Uros Bizjak (6):
      x86/kgdb: use IS_ERR_PCPU() macro
      compiler.h: introduce TYPEOF_UNQUAL() macro
      percpu: use TYPEOF_UNQUAL() in variable declarations
      percpu: use TYPEOF_UNQUAL() in *_cpu_ptr() accessors
      percpu: repurpose __percpu tag as a named address space qualifier
      percpu/x86: enable strict percpu checks via named AS qualifiers

Uros has now respun a v4 without a CONFIG_CC_HAS_TYPEOF_UNQUAL that
triggered the rust issue. The underlying Rust issue of mismatched
compilers messing up kconfig probes looks to still be open.

> So the claim remains the same here.  It's just like staging, api changes
> to subsystems are allowed to break staging, and rust code, and
> maintainers do NOT have to fix them up there, that's up to the staging
> and rust maintainers/developers to do so.

My reading of this paragraph makes me think you expect Linus to have
merged Andrew's PR and left the rust build broken so that the rust
maintainer/developers could fix it later?

Jason
