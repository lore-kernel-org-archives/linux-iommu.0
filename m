Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012028.outbound.protection.outlook.com [40.107.200.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC3B21770A
	for <iommu@lists.linux.dev>; Fri, 28 Nov 2025 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764352982; cv=fail; b=HPfGakNI33eDAmqZgRjScP8EAcuNH7ZxKHofAiG+1+zmLPlCE1l23E9phhzM19fLsaPUOZPOeBKBZV7a8uI4GPQV/ntfKUk/rEALvx1inKzg/yY0zKQF2eIgdZA/yBsW6PnmsATKvhgCZuHLWBGNaukn64djEixwqvTqp8FhAYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764352982; c=relaxed/simple;
	bh=PxBh25GXW5p4AyGSxQ2HuIuBvszUtUO0pkdqeiD0t70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sH1sHh9aWbwQ0xTVlOshwlX+khvcmR/K+4L1gwkzHkY1NzXgPe07+bUA1uhT6GdOGbBsMiay1f0H+IcKoTjHnfyW7uKkJOrF9wP9GDZYhdhbf+SzekNV8ypHs0bXQqh30CPjEJ+Adk8GnEqKdUmm6q+OdNfbowaw46dCeCieYfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eYcwBYWE; arc=fail smtp.client-ip=40.107.200.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eYcwBYWE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HN3tAFOM1eqMHPHE2a04sVruuviR1ZWsFIdHz3fa/WMY9aPui7y5tlvWZGPsMFfTBVKYIYgb+UkVAf1X8oC8+2GaBF9l5Yol/EutoQTQJyn0uBWPo1pokLyWn2nmJvIwITs6xECgRKUwb7JeGUnRRKlbACirN5W00XqhSJbTSp6n8173rM7ezLmVhRwB2H5JO+G9G0ZTFjnn6UnWy2AE56RJNRf/mhbVW+zpVVLyq9vvBv+lg+ypZgP4ne54xysZT2aSGwN5yOT+MAGEkeDW8pGeIsNb5cpNGUxBxeClpipRaEpEidLP57xLgmex5lrC/2A/HszjNWsznh4HG1hujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Hs2NNbE1oe0+1cpWPKFalHgFyh/qkXaJn97F3/f8Yw=;
 b=Kmj1UWfMYS4v8tqrfjLQczRvsHskWRRX7Qn7DFjGR76w5WMC3pIqjwXi0cNBHd+9nrXGZK49rlmedVU0mtq2w7mBNa77RW4XriaB2rIfko206jc6uRxHjnSb3Cbm1Tyls18KIvRKhfXdMLgbQDgYdNSUQKyi3mXD2XNru42fUz+3tRqSZST0l7LP3PXw7/+DX505yDM2UisjGJILPJRq6TkcxCBfOwNsMO98JxJkm1oZmvffamnQHPqldzryHw4rPXXYFlEFEIY5p1Q/vPiPCwx7/wv1nZ16gttRklPIE5U7XVLYIGkBtCAZkntGo3JhD71o9Stvr5Erav9hJN+eaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Hs2NNbE1oe0+1cpWPKFalHgFyh/qkXaJn97F3/f8Yw=;
 b=eYcwBYWEuEBDTBxL4VjpsoiI9EmYNHXfkNdVUb+fYuKV08U5l6hhgyjVLJjDyo1l4Zp0KWxTrgLRMfHmEpwC2gvcKRWYCxJvWepz3N+vfiU/hjlRelPn2/3GrCDPjVZHpNHRgWsYllF4ryXTRtkf53xOTQo4J9QurwRa+Kw4bqcBShBFoNbxg7lOOZgf9pnyz5hixdWZIieLCvFWyRDRFixC8bgnpnBFYJhTELY4NQ0uU3bbdCipdgaJ8ukO1HYMSQgyxVMRXwvKWegUvC1VdAdGXi0vc22ba+oLm8DuF39HHxEYjLHqa4M6z20O+oDHCgCXK/O2x/g1rqkujyhsLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Fri, 28 Nov
 2025 18:02:56 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 18:02:56 +0000
Date: Fri, 28 Nov 2025 14:02:55 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Asahi Lina <lina+kernel@asahilina.net>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	iommu@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v3] io: add io_pgtable abstraction
Message-ID: <20251128180255.GA836877@nvidia.com>
References: <20251112-io-pgtable-v3-1-b00c2e6b951a@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112-io-pgtable-v3-1-b00c2e6b951a@google.com>
X-ClientProxiedBy: MN2PR11CA0030.namprd11.prod.outlook.com
 (2603:10b6:208:23b::35) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 11140b22-b33a-45c1-aa0c-08de2ea85ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c29vs0XkMZBbMbfkrAtndd9U3x/fQBJpXt2aGtMSYJJRIiCe95YFdYdcDlqj?=
 =?us-ascii?Q?iA+BamUdFyOnfaWAjok5fjP4qA9KOKBEnnkF+KFIUfOTF+Z47N+wPgKDYTi1?=
 =?us-ascii?Q?0n5ZJDcnVdFQTeo6ey6GET9pZPuz9AQSGuSptj4D1l4Dhlpf4c5ZypJfhx9P?=
 =?us-ascii?Q?8fMbJk6ZxNx30btUHt0xI6lDdR5EntIJeEfIJ66xUP567tnVjB7y0T+UG5rk?=
 =?us-ascii?Q?jFE5mka9i9QIB80/Xfz39Q343W/XPpz+WiMibjwn2Rtz7hKKNrQxBr11RNwh?=
 =?us-ascii?Q?IM/UV3Z0VF5afBoisZ0S1VoVp2NEFJY4He/egLbBXj9AuwSd0TD/8e+87vHv?=
 =?us-ascii?Q?3XV4NiRQwtfq7f0WsH8CFLg5EkNZK0zjX1eDFkFh0pM2xmds1WgodeQTlZAT?=
 =?us-ascii?Q?bRrHpr/jtPhxe92TE2eBpDBzyZJUX5Q9DQ0bonjsBd4/woxqUrnLsgya5fie?=
 =?us-ascii?Q?7gLyOo6uRe8gFI1XGVnaAtd5BLbCNYVbnFLSHi+f8oIF9pnPkNUAhbXfQvTF?=
 =?us-ascii?Q?Sc8E4dz8/vGEwg286lUvYnt11wBjgJzn5YWcGNWsHEXKznE+H4R91hgINy+8?=
 =?us-ascii?Q?gMHaxnuWWvYrCzC4QI1E4uWp4CN2S99rmbHh++pfa1kxgEdAhnLdBgjbpppQ?=
 =?us-ascii?Q?zBN1LzMpMwEplK+4zZqiqFnloh2vCqpW9kl3KOZb1Lly3u6GG1yluHoXWG3J?=
 =?us-ascii?Q?0FzvjjD+uafPSe/PGux1ZO714m1jijv09qwBLmmk+dds/qYyMJEpUxBFMvNY?=
 =?us-ascii?Q?MIPzSX2gSuO8ltMc4UnQEcQwNlZZfUzjcnCzdFoMTPmLF6Oq9KRo7vmu3HAn?=
 =?us-ascii?Q?inv9vyMUMM1mfUPc7XtweWCfOqsCR91skSGenyUbCQlFg1pSHlP28DFIiPFg?=
 =?us-ascii?Q?Lh+TozwV9NUE4P6j7ANQRndlyuc44xt3qTFNhL4MXb/OeFITlpwnLSw4Qh3k?=
 =?us-ascii?Q?4+JCFutknt6htkDJ5aRR43DrJ+hCqkDk2jdeKye3ByvkuVPsgjWsoQqFvWkc?=
 =?us-ascii?Q?Ev6NUL2kA3E2rdZQNitDw2gysADDiHOO7+gddHsW98qFoufzUMEQ+ZCMJqWF?=
 =?us-ascii?Q?EZqyoSsAfgKn0s2jjb7GX+KXk/4c/It1NJwUrXAIUfxWGKgKBSlX+Br1ouqn?=
 =?us-ascii?Q?M0+UfSSP9MDwDnkTooe2sby1BMWP8qesfZsKr+lnJvzeey+SIFE3keSagL54?=
 =?us-ascii?Q?PGkEpR9C4DmXpZ95dVwMD0uQZUauulK7naCFgfTU8I02eZD2xTlM+wB3S65i?=
 =?us-ascii?Q?jrsn848zk+aVuP6yQpLMm0ts8xwv60ppJoS3USbXOaEMaSpmmeCJu7iLLz3i?=
 =?us-ascii?Q?yCGFZDxPJ3OnJ7Qq59AKH98hHWLaZQdPi5ODhOLgo4eRk0SZtzobayO8ACrM?=
 =?us-ascii?Q?eIXl7rVWbiHTCJNmRICdBguzuJy7FJkOkusmdofGoLGvR+B1SMc9K8SRCDze?=
 =?us-ascii?Q?8I4ahjnMIO0BJys87BAoRDvKpzGCM81H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zw5edAE2VieZZKJyeuvhjEov47iJaOkpOrjGAn7dfvBnmv2C6X3y9U/87HTh?=
 =?us-ascii?Q?7XnoTQu83cLCE1MHs+TRFacsJG90iO58WrFO0VqQ3Drdz2Vem9KyxE8zd73e?=
 =?us-ascii?Q?x2Cu4C/QZcEgGlRx/g7BnRpW/BAOMsU7gSX+kdRCIX7Lg0jq9pPhVpU2tbL+?=
 =?us-ascii?Q?YArnwuvAPJG6jLqBEv9Y8kXPazil7l0mFn9M4bEaiOAIzCWtBgf5+u8JilRO?=
 =?us-ascii?Q?WEHxpqhn4PtD+b1aITZgGN2nQ+iwIG9eYimebl/TCRoBsbAlgoDS/J07m0oT?=
 =?us-ascii?Q?0iOA0334r6iTfjjOhIBF6SEy3PSaYbONVs/44x76MfW4EtrKYMxozKLa6B32?=
 =?us-ascii?Q?FnRCllkaN+/b18MPlId+jwGEk0PLjYaWJvhSzq6UdtXeSEPZe+46J2alV/qk?=
 =?us-ascii?Q?aQYwudbX0fzPTj9+RxC73Ue7mDvypIrwPEDYkae9fTRLgkdKp/uNl+G3X0hf?=
 =?us-ascii?Q?0v8bhKxpmYT5EumgFvy1gm93vtkl0YtooPbGI7lW+s6Oi76XmNTboz6dQ6Cr?=
 =?us-ascii?Q?23K92Ns9GSGmx+SctOmWKrkRnU8mK6UAI5/3f/sEkLpBDj5gJJ7+pXFlf5dR?=
 =?us-ascii?Q?tcBhJdSD/dFDt2lAupPidUctlqiBKgDHciX0q6jbZeLPGYMRHad5G6hEbdVm?=
 =?us-ascii?Q?ouhYQ5RVYWnVCc61B0og1wy9ovR59PdrRXPDc781R8Lxxp9NdriubvtBf/G3?=
 =?us-ascii?Q?qWqr2JTNiwQk8xQUHJVf4zguJOPTg7BIdDQnBW3q8f+NAy8yYwQdogmWKXMe?=
 =?us-ascii?Q?7XHgdDdOTxryveknRdY7iiRI+pO5yEvAOo/KnYbE9bVERuwAL7TGsbDTfZEz?=
 =?us-ascii?Q?S9Ze6ymfoli26OU+jvp8jwIgjujyKfnOi2q4bUf8YZ2PWrq5k/zvWeRO43Gz?=
 =?us-ascii?Q?xXetG/EPQGRzQ8olLtX5J8VgAXT/7ZzN44IoUiPub/SZkyAzPKCqxAc77edW?=
 =?us-ascii?Q?OzQZDnnbs5cubRbpN/AV/QEnRrJUi16hgW+CvIEy7OtsLHTYJ6lz1WmiEfzl?=
 =?us-ascii?Q?EniG7oxq7aekroZTQCrpPQvxO+MBiij2buj43mp3mDvcXcgzgBbgrb+iugyh?=
 =?us-ascii?Q?rh3OJ22bbS0PW5uIGxc8q6xEObr8bEhvk715toqV9MiGsNP6Q4N5/5YttFNj?=
 =?us-ascii?Q?slw6GWXt9g4rEilsoHJmVaCGREpWP4IZRVXRpXJkJVz001zDHptpbNEmEhXt?=
 =?us-ascii?Q?JEp4hRb/UXyjd5B0ScNlwzGX/5ea51vueSTEjgG2XLNH86DSZmtO4yAmpmAW?=
 =?us-ascii?Q?gCWcUUg/Ndtsbv3PmMbHBGQ3VjFFXav3dEU/Ij+zGd7A/h1JRM3J6sNGWEnX?=
 =?us-ascii?Q?F6JHQFDBZ5gA4fTlwug1w4ExSvPuqSq5eClnnQnWQDCCS/t60BlKzIQ+cpQh?=
 =?us-ascii?Q?R05FvExC6K4FE8WYIQLGSUSpQ+Qwt5OKHeIbiKjLKXyjfCzCA0w+CEB5ChTG?=
 =?us-ascii?Q?n41SJhOZ7yeFNtwkM9pjc/karTGXjKzYpiXKTJCF7lMPSRFBWAbXnBxfDhWL?=
 =?us-ascii?Q?sjFaML97tBI+xXwVCX7xolAf2yDoo5+jhGJFW2kue+2xmlcw6A3vi7uq+AQr?=
 =?us-ascii?Q?ehTWB3lm6+mNMuqttKM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11140b22-b33a-45c1-aa0c-08de2ea85ba4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 18:02:56.4890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rtJ1kEyW+RpXJTriUTiFAlK+F8ksGwsbKMl+wId+5XielW92B1qRs7JCPs8+vUZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753

On Wed, Nov 12, 2025 at 10:15:00AM +0000, Alice Ryhl wrote:
> +    /// Map a physically contiguous range of pages of the same size.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * This page table must not contain any mapping that overlaps with the mapping created by
> +    ///   this call.
> +    /// * If this page table is live, then the caller must ensure that it's okay to access the
> +    ///   physical address being mapped for the duration in which it is mapped.

All the iommu page table code runs with a caller provided locking
regime.

The caller must effectively hold a range lock over the IOVA it is
mapping/unmapping/iova_to_phys'ing and it is illegal to race those
three functions with overlapping IOVA.

For example the caller cannot map to IOVA A-B while unmapping C-B or
iova_to_physing(A).

This locking detail should be a safety statement.

> +// These bindings are currently designed for use by GPU drivers, which use this page table together
> +// with GPUVM. When using GPUVM, a single mapping operation may be translated into many operations

Now that we have the generic pt stuff I wonder if GPUVM should be
providing its own version of the page table implementation that
matches its semantics better.

> +// on the page table, and in that case you generally want to flush the TLB only once per GPUVM
> +// operation. Thus, do not use these callbacks as they would flush more often than needed.

This doesn't sound quite right to me, the flushing requirements are a
consequence of what flushing HW is available in the xTLB that is
caching this. The flushes generated by the common arm code match the
ARM64 architecture semantics. If the GPU has different semantics then
it can do something else, but one must be careful not to match a GPU
that is expecting ARM semantics with "do not use these callbacks"

IOW it doesn't seem right that common code would be making decisions
like this, the nature and requirements of the flushing are entirely up
to the driver binding to HW.

Jason
