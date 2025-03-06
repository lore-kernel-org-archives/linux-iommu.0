Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860E621019C
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277354; cv=fail; b=BmVOQx7WhG4vWMSSOjV8opODTjkYuWArV521O3Jcm993yP+8f1NWtHwLRViOcjOHfTIC644OEM2y+MozXDHxz9T/jGcDPGJK9KXe8md4ZEI3ZeLXtWB7E+XaOVx4Op6+nTJxTnSRgSgamRbFsWfGSasc68iWhwcgf4lU6HkFF08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277354; c=relaxed/simple;
	bh=L9c3YHzKDB/PDP0Z8RS9Xbe+WB138FH9HsR59b69V5s=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rfv974Evvi+DkuQZ9BYy26bO3ze5MvQG4H6keMkA/0LD8T610q4k5lEe4nlMwf0m09SBRGjq/AJzSZXSGOIoMrQxxCwPTK/7aaW8oU9zAa6pFzAaerC83J8pco14b5MxgaZYMRmA5bKIn/saDkYlbYCUAydKwEiQFZ1roHQvKjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mscfyTn7; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mscfyTn7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKirP34wE0ge8f6+bN9zPd/BHkRF/fKe4/spnLE32yJFzQbdLUTRGWwq2AMPqibTtST9U9Im0er1eMOEihkk9kLllgWjQ4GNegUlNxgcTdFhl63T1/bUMU4Fk0w/LiFxX0CkdW0vNBDDWlAhliwOH1gb4JlTnsnN/+4ABOpUWhws2WX8qqgKp1pFeVf2PdP3ghE/JiT4cn+A9wNen0VO3/1GMq9M2aFD+HHQakcHrZF9GibUI4DoNqNxulgvTqsVY55RMSTzzoAcdzE4VjagTPyk0edd9iRbz9+L18UT78MGMjkh1g7WnfUzDFHWUkU4rnSjbn1vPQCM5oe3mzWAbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqSEyEl4iEtM9u/oPZYEXiIRdJDZiTOIhK1/A32IKtg=;
 b=FSCb4vYFhDM4n7jzoSxsYgHv2GYP66qOOA+evGwkqFhI/Odqy8jhlBFBAHgBpPGSSBvQPP6wcefPGsmktwGfsK/CjDbNXjjjB6A0Abs9mFMAFONLzTPQ+KYf5TRqGLC9+J4IJHeaQSNz9s32zwm8z8ex0SUJ/9ljBVXOoU3+k8wL9mOoGQID5EHapeLQUELYyJT6mvGozt0zQsBTbw9OBjOxrRBdbNi6skwxA6UgF6igndKZBV/28mrG6OxNZ0YX4Km4CGDsGMY+ZsBw4XjjM8wm+1oon1mlDYFmZcrhLD7KnpXHWhKex9dWKMn6nJEK0CFUGHlRBhaqoM33n10C1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqSEyEl4iEtM9u/oPZYEXiIRdJDZiTOIhK1/A32IKtg=;
 b=mscfyTn7bYOyArCZnVIZN3wLx84wsTiSJySE5Pg+apO+qmxU6kMJ+pOYoHrnXGmyRbIzHMxVtjyZ13l0nRpRe4xJYcAACHLEvUZ8ZvgCVzyXBth5Iq3KnWbtywDgAaBJMfFceHx8WXDtnIaxlvxrmRlQ7lZjPt3iNQ/Qbf04ryEmv7Cia4KkS+BkJCY8M5SVLxO1Y53/2XppLgpmWCS2WR6yD/rA7+x97p2oAOKqlO+q2fqUOfg4DntCB7GkEURZLcfwLnayLArKohBXNXiDHXQQ3/ZDfg2nARMONNVx2H9l/iww1pyMuWHS08sazottV2uUX5KbZa1W9U8o8GauuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 16:09:08 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8511.019; Thu, 6 Mar 2025
 16:09:08 +0000
Date: Thu, 6 Mar 2025 12:09:07 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>,
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
Message-ID: <20250306160907.GF354511@nvidia.com>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <20250305174118.GA351188@nvidia.com>
 <Z8mlAxsszdOH-ow8@cassiopeiae>
 <Z8m9j3SwWHqaCTXo@phenom.ffwll.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8m9j3SwWHqaCTXo@phenom.ffwll.local>
X-ClientProxiedBy: BN1PR14CA0022.namprd14.prod.outlook.com
 (2603:10b6:408:e3::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cfbdf89-ab48-4381-4ec1-08dd5cc939dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wtoASsgkhsc4Hu6YywI2PKGfOG8EotI0iXcZxzjsepplDc6hDgO9RSuCMkee?=
 =?us-ascii?Q?Ye3DFooBUHxvaxJJ05TQo1MYAAEkR+JIfdZ+HJkfnaB6eLPClLScvhfl8Z8F?=
 =?us-ascii?Q?twRyF39A30JvINq5VM8GomoAjeY6+PR7j8aWTStIVO/RyO0A71yFH9GfHO9G?=
 =?us-ascii?Q?oPWz7eyWhhaIoAenBzyTq7DOgFGrp0nW7bDrjRY5Q4CrzzW3AIwvOqK0+hmy?=
 =?us-ascii?Q?qoY7QNO2k+9KWTdgnOEeYr/Vkx0X2ohboilRuGbdheNOYM0/hL65+TE3ydop?=
 =?us-ascii?Q?RMIjXVKA4RVswa3k0iJHGJpQvaXN+A1SOMVyaHS6lFxthzi2mYPTEbErMtGV?=
 =?us-ascii?Q?ZqJPA9T0HGKYY80JYnIMWz1uf4PD9LHCpzm5UX3W9Pp+Tx+61TQUfSz9RV2a?=
 =?us-ascii?Q?l2bj6Gxc+samJOICkEIUIjR5Vkm3J+FmM8fKpTNSiGMz+98x/ShEMXUp+jRH?=
 =?us-ascii?Q?tzinnTUU/iKtE+sIeHycvnQTlND9TOJz4AJ4MmLmh7ad1QtbxGO21Ndpf9dR?=
 =?us-ascii?Q?MDiWo/mbly2xTTEFcF0Mbx2UCJZj9MY2GSIK1dT+KvcEZdXP/Vug4E7M72Cp?=
 =?us-ascii?Q?tZt2DEKlBMR9S0uTTv2KZ5rh++Q/8TGExpWhHI6iKGJKV39ZUz/IAn1nrT2H?=
 =?us-ascii?Q?uLRXi55RB060NddozxOZLCPp1tYjWkq9quUhKnsMJWN3RUCJbv9Mx5XUCGUr?=
 =?us-ascii?Q?Fu02+8ch+3kgfTr07Ekezt8JH9yRwwOh8Z+bqes/IrjmF4WoC7G4bXkVyqvV?=
 =?us-ascii?Q?q9FRjgWcf77taVd9zPDrX/aKfndDqt+jXwjGLKFU5d93GQk1g2/RYn6Bdo7g?=
 =?us-ascii?Q?+vSALx/zlJ2HxRmruQYL2sDcoYkVuL+mEV5v2EC2tsid6aQMuKtMff+BZbJ9?=
 =?us-ascii?Q?ic2vXEgOzl70rI75SIdedgqNOfUSgy+5KlW5iGdOBdyoCnyXlGVMmKyrC6aO?=
 =?us-ascii?Q?sbTG/VDH62A6n93AkWdoz4yZ8qgjP5Skh/ZAhG9M169dDtfYw03d9FVsuVAQ?=
 =?us-ascii?Q?Ysv57B5Oya/sjWO2qXcXwLMRs+DchOSJf717aWfsOKwdSSYlXJkMBAqb+iO/?=
 =?us-ascii?Q?M1SzcsogIN+foMMTHGVU1U0oKTxJ8RfPiyuWWRbTWQrVOw/4iH14wJAXccSv?=
 =?us-ascii?Q?QD4gJ2zQ6rdBKDFzdRHXJJc6uLIozaNp6lirxxVFBT1BkfZHKIttCcMN6ECq?=
 =?us-ascii?Q?ItvZ9102v1fpLQBBCkSsEwDgN3IqLnRSNqPuI+YIk3SWfWuhIZr856kOHzv/?=
 =?us-ascii?Q?bV1Grn1+TLeQ4J1dAU63CJqRYwejR+AX6heORc/9MPqxhNcUyL59/tsazqZD?=
 =?us-ascii?Q?erQWn+QSaAou54+WOvNFxDbzjL/Ol36j+MvQWxbZnw7DWvZ9xDtH2yNdG65q?=
 =?us-ascii?Q?g0USGEF/DXPiQ/eWAdur/qxpnXaH0FPAbLauVJMyNf4ToFswTCBpauLWuMz8?=
 =?us-ascii?Q?z4wc8ufOIvE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VAsxwLtwmdzXFMmhUCZFYZyyGh2B9ZQf3UdDhnESfEbmkz9MstIzlCcahovK?=
 =?us-ascii?Q?f9LJGvn0Y8Ty7eNMibnfnr8TdzTC8fpuvVVofvhbp0qRezRnMxML+B1XAiQq?=
 =?us-ascii?Q?SiAZLIbHURLeib95rqSF0zhsVLHbeeXgh9Uzb+SDg8Xyi4oRbSItOpmZjWRI?=
 =?us-ascii?Q?nDXNGux6Z+tCRjVhEfMSjDW/nzz2fLhVv7IbVHVDrdlmfPgKG3jAx0a40MiR?=
 =?us-ascii?Q?hhALHbzyxwXYTXscXCUNtlpk0CxKlrHu6DgiOeEQ7RU1Y/mZfW1rd/msaPtY?=
 =?us-ascii?Q?LFiPQDoHpgLJhQsxCIn7qOA03ud42VrXePiaIBtp8AJjOA1o0qVNEJgSrISA?=
 =?us-ascii?Q?fiYOcA/8euK/WvBLr/BX+1WS/DjDSLDzp5rV9h7Xa8nGUE7rDQO4V9a0f2Kh?=
 =?us-ascii?Q?4Ko/ksPHRKdSI3xThSd/tkJk00Wu6G8Lv+VvreUj3yfhYhY5FVkUe/T/3pdl?=
 =?us-ascii?Q?tbxurK60vhHGhEIHYBvp7m0BsikTmR8gbLwlAYS+czRN1OD61B8EV2/U/7cB?=
 =?us-ascii?Q?TNFMCFkPNDdkffd7ncL4L9z7MRQhrVX6nLfhjdKHEUN+1J0Y7pTPURZZsYbE?=
 =?us-ascii?Q?jKp8Yp5wlxSoCFiOh1SbPbjpNnSCqXBqHm2Z3gXh4eQbZ61q5+kyZWLULLcZ?=
 =?us-ascii?Q?RhL5WnlBXh+N/mH+k5all1PbOMZFPTq/BeN+aZScMEzw0HXZiO+c0LxMSxmR?=
 =?us-ascii?Q?Ql94I61Y+6GKgvqBh6/7HWMtCeGap+kbj7ormK3wc3oAmaZ58oPQC0bc+oPC?=
 =?us-ascii?Q?VFwN8k10zaPVPbF+nTDWfWzW3VMERtvQTv0d+AOk70MJsqA4MJATR3BDaUK9?=
 =?us-ascii?Q?3siH2C8kiyI/RWNFP/APT3YZ9FMuRG7GPSXp84JkpJANQpQmOEY7LGrI+5A9?=
 =?us-ascii?Q?v/6YcPLHeNwSsR/LzDY1jkaZyRy7Up2jujJh0ybe5SX7g40CgWgR3ccHxZZf?=
 =?us-ascii?Q?kD7RNFoqZ/6GZ1j99mYHZsA9xOmDF29z9amrr7QXl4lPj1ElVcISt0txUe2K?=
 =?us-ascii?Q?KJ2i89ZfuPg5zJytPwabS1CbNfagJAXUcAJCq//ygBrksiFHATaIWnsFs2nB?=
 =?us-ascii?Q?tK1Vn1M1e86/QqT2w+71CrBhC0MYG4+WnIcfU6ULCoU1T+7gAYoAmf+pyUEl?=
 =?us-ascii?Q?kbFzhi/Um6O1IcKCfsivgWeAseOULkgvHcOCbPLL/6b0sYwBM/1fJqqAUr5s?=
 =?us-ascii?Q?FJDiQSOFfwYVex/Pqod0R7QXtNaW63Wg9c3WRvRGZ2+GSwHJl7e2WoTPOejE?=
 =?us-ascii?Q?uYDXl8Gh2o1H92MCztXRL+lRXtK5YweJRaNAo1TBlxlRtu9rxJ9gVI/zcbva?=
 =?us-ascii?Q?qWv0dvUSoqbzdsxMefiHyf2m6fmWKylnozBoSbZ0ZBkKclZEtnXutgFQ6OCH?=
 =?us-ascii?Q?ot3hQca98IJm5pO89IAV8G6H2fde27R7p9ldiPBX6ogsL/edUFK0knHA5AYu?=
 =?us-ascii?Q?bZ/5juxjTXUvb7UwrJlbskDou9OYFMd0jE6oGAkXtQZUD3wDLPvG5V9QjL/I?=
 =?us-ascii?Q?oT2PETK6f8f2pAAVRkjJOgDmZsMK5YCR2pwH6xPtkWy9mRXfr7vj7/0yx5qF?=
 =?us-ascii?Q?Dmjkiu6avG0u4Dfb8pCz7KDNi5CX+W3hUFWQSaHJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfbdf89-ab48-4381-4ec1-08dd5cc939dc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:09:08.7697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nWparcFo0NlCU1jMxBrt0cDh8MnPrgMTNVCfS8uH8CnK3hfaByjVpF/28FcoRsX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996

On Thu, Mar 06, 2025 at 04:21:51PM +0100, Simona Vetter wrote:
> > >  > a device with no driver bound should not be passed to the DMA API,
> > >  > much less a dead device that's already been removed from its parent
> > >  > bus.
> > 
> > Thanks for bringing this up!
> > 
> > I assume that's because of potential iommu mappings, the memory itself should
> > not be critical.

There is a lot of state tied to the struct device lifecycle that the
DMA API and iommu implicitly manages. It is not just iommu mappings.

It is incorrect to view the struct device as a simple refcount object
where holding the refcount means it is alive and safe to use. There
are three broad substates (No Driver, Driver Attached, Zombie) that
the struct device can be in that are relevant.

Technically it is unsafe and oopsable to call the allocation API as
well on a device that has no driver. This issue is also ignored in
these bindings and cannot be solved with revoke.

IOW I do not belive you can create bindings here that are truely safe
without also teaching rust to understand the concept of a scope
guaranteed to be within a probed driver's lifetime.

> > > Also note that any HW configured to do DMA must be halted before the
> > > free is allowed otherwise it is a UAF bug. It is worth mentioning that
> > > in the documentation.
> > 
> > Agreed, makes sense to document. For embedding the CoherentAllocation into
> > Devres this shouldn't be an issue, since a driver must stop operating the device
> > in remove() by definition.
>
> I think for basic driver allocations that you just need to run the device
> stuffing it all into devres is ok. 

What exactly will this revokable critical region protect?

The actual critical region extends into the HW itself, it is not
simple to model this with a pure SW construct of bracketing some
allocation. You need to bracket the *entire lifecycle* of the
dma_addr_t that has been returned and passed into HW, until the
dma_addr_t is removed from HW.

You cannot exit your critical region until the HW has ended it's DMA.

Is that possible? I think not, as least not as you imagine it with a
non-sleepable RCU.

Further forcing driver writers to make critical regions that do not
bracket the lifetime of the actual thing being protected (the
dma_addr_t) is a complete farce, IMHO.

All this does is confuse people about what is actually required to
write a correct driver and increases the chance of incorrect removal
sequencing.

My dislike of revoke has only increased as this discussion has gone
on, I think it should not be part of the generic Rust bidings at
all.

> But for dma mappings at runtime this will be too slow, so I guess
> we'll need subsystem specific abstractions which guarantee that all
> dma-api mappings have disappared when device removal finishes.

Yes, it will be way too slow.

I don't know about "subsystem level abstractions". That seems to be a
very big and invasive ask.

> sections. Similar for any other subsytem that shovely substantial amounts
> of data around. For some this might already be solved entirely at the C
> level, if the subsystem already tracks all buffers allocated to a device
> (media might work like that at least if you use videobuf helpers, but not
> sure).
> 
> So lots of good fun here, but I not unsurmountable.

I disagree. I think this is unsurmountable. The idea of fine grained
revoke is dead in my mind. If DRM really wants to attempt it, I think
that should be DRM's mess to figure out alone.

Revoke should not be part of the generic rust bindings and this idea
should not be exported to other subsystems.

We should be encouring drivers and subsystems to follow the RDMA model
for lifecycle which is proven to work.

Jason
