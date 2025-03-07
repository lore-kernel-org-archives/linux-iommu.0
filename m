Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020B184E
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741351696; cv=fail; b=K2EmHaA7rbwKSN5knmWLB98yB6+7WpO9YqLMVENSRKy4cYOtBoQuGqtj6p2XsQXgohaJJimJLrMFCQ77UKxjRMeSRKaKVmZYPvynxiTfbPeZFddVsgQX0AGaD5D4PzvxNq3h3wCJdKvk2cJoLiXuzv784hgm+QKKgASAgxrOx+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741351696; c=relaxed/simple;
	bh=nAR9Q9FMcaM82LhtcdEkk9/IWMQ6KZ1NKdhq/DdaqZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YHJwmgq0v0lLjVNoKdSdvmNDXnrWrnpWHdAvhsGZcV6CtQEhm6//JQty3O/wJP0DfJ9Ps+8ehFVRyFbWXRJZNF0vdpAqVj8L0gRIKEjkZ3pYyHOIDxpx20bctI8H0uwO6OUKil060446cKpSvvczrc8/QF97N5f+q5Fu14FsbJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DN7ogYq+; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DN7ogYq+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0Rsho/jNjDTn2Jy6lM/qVYuqpXCwIZElOf57uW2LOskhwtV1Csb3tjLSLYgioGLzMrrijPa/ElNcQgz28gwfTVvXz7QuPDFTIVJkcdR3NxzT0TN/BoSoufmC0mu+EuJ194P+cFu8LD/QlOshj4e3bmLV0KUXHFJSio5ZnHSlNE/OifJ8aDNAVZhECtn8YhCpW2Y49Vox0jlcn3qCCjOun8BBhx1+RMpNMBLbi44Dx/GxryF3LVETi34ERUuBoj+f3OGc3pSLnblls81CK4/xugkOCN3Y5pRVCwuUuSiOv7P21FW16yafx6wX0fLX8xbakn0MU8sIvVS09+8ETPq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijf9FthY0tu44dlF+6ettKEQht4zOpQu6I54Tj3Y/PI=;
 b=t7bqdNZItK0+QwBF7Qkx/+qX6GiWJQFIm8MSPd6lWjv/knDVjZ1YwRQEF2EqdkXileVfRPRVGjffoj+zGbHvSuJk+Uj6tN/ktKBVgMUADvvoFXYNwewIYyqeydOyKazLxqDCoBZwN+MlLof5vGHm8HvXQV1lup3mVXT2k2kKbcG4vkAhSHMlyhe6QKyuPq9TqVynkg7iRQFV6dl6LVX0CFe/5FRJVOMYSdS23luS6IWuY7B3niikLL+yoK1i/ePzC8VHq+Vq53CNB7Bedt7Q6AdFPdD2vaYjLftWT6GM9qwsvUIhEYJRoaDtvQB0tam37DbtMIKNvvl36N6l0FG56g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijf9FthY0tu44dlF+6ettKEQht4zOpQu6I54Tj3Y/PI=;
 b=DN7ogYq+SfTLMDOREI0KD1meX6UAMKDKvTKRsmrrI64XAYL7ZiCR3mRsse5IYZkgIgap6Lpf9P1Nz65xcwIfN4dBPPL95TI2x8IFuGzp80IJtTN/frW0sWo3erxEy0uOUtqx0ClGTYsUYKZcgM9Qt2M+uSe2AWJuz6xFGNnLDChNZDCKxU7m+rsU8SywdHn/zTn2ryYKL/ob2ixDGJ2pb1VOjnC+6RFCf19E7GXk1KqeKoIVZi22yaGgpe7QzIZGpJPK5EvryLVxN1rRNkmQ8wH2KCYZmGfkkCF9aosxz9rK2Gcb+yDLTzT3w11893OJr6eu08ulSlM3uxD0QY7Wbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 12:48:10 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 12:48:10 +0000
Date: Fri, 7 Mar 2025 08:48:09 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, aliceryhl@google.com,
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
Message-ID: <20250307124809.GL354511@nvidia.com>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <20250305174118.GA351188@nvidia.com>
 <Z8mlAxsszdOH-ow8@cassiopeiae>
 <Z8m9j3SwWHqaCTXo@phenom.ffwll.local>
 <20250306160907.GF354511@nvidia.com>
 <Z8qzP3CR8Quhp87Z@pollux>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8qzP3CR8Quhp87Z@pollux>
X-ClientProxiedBy: MN2PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:23a::14) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 64661b37-f62f-43f8-b9c9-08dd5d765129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BtxGtfMKjRyEwq5tZg53YOIFyZpp837w8rN768Ekco6WnT8tSqn7+w1z4xVk?=
 =?us-ascii?Q?XxEr54cNbUhtKoaIcDCGMnnIPfya/5LQ2ff67/+Gid98ttAIv4FsuZ0nnJDX?=
 =?us-ascii?Q?fu5UJbUKPE4eRbG8s0Z8zsPz8nDx3ckzOJjQFEL4dKSXfYoyCABNeCe32Hri?=
 =?us-ascii?Q?op1bu98jaxkrmAwyazyOWenswjT5DcNYKSYr+ruLY1unQ4LMpMBfkDxSvOBF?=
 =?us-ascii?Q?oQs+S85iIMbXGZeGbxrYguEqLlWwIbevBbgshkYWf9FcEORImyWaabpC+vv0?=
 =?us-ascii?Q?Uvyw2S1k/2sVNqU/GZ6PyYsfN5s4AMZR7h7ynFRLxzJgNdJIiGMtmpBC6mj0?=
 =?us-ascii?Q?H/FX7uD0KFrl9Gi5tG3C8Jgw3rUfKWMU7Fyl9BpsTHv3swk7DBrHDuaQ5lqj?=
 =?us-ascii?Q?2lZRaa5KYgOtz7acupkb9/0ph428gf+280W/H9fdB45JR+EJ6fbacX3uptdr?=
 =?us-ascii?Q?nKlat+vsWsBH8UpsjvrbkIepIe08dlXcWAgTGLihAmmrkBkI98Mhwano1cli?=
 =?us-ascii?Q?ZlcsrbYWnsoP0JFSnSckDALIBYYQ7mw7c+Xv2Js4LNAJYfgw2OLZidmAgzjv?=
 =?us-ascii?Q?u2C/0MksjZXvv7LIMmJtMY7d+9ApVF5Q9c0oxAK2UVBbQKiagycXnnNnxuHO?=
 =?us-ascii?Q?MovI1LP6aSyjaQHEkyquL8KfJfdKPZYb2cz9S1ML4ogDw9MbgvBAv8FVAkhx?=
 =?us-ascii?Q?InjsioFSYYCPWL95E6joh/p7QE0aXMRxqm5EhGEsL41v2xob1N7UWKc2jPPR?=
 =?us-ascii?Q?iocJIos+3o7SLWFGb6GUsh44pjJqgrsyywqT5sJtX6EN4zNNgmU/rU3Y8otT?=
 =?us-ascii?Q?YdwFD7UUg5dPVm5wKejGCcSKMbofaFGhaqlV18xYSH3IsDndt6rFuUR2rCnZ?=
 =?us-ascii?Q?KwJqBs0suCLT278c5MfASoRp2EgQOKFrwWek+d/GxJtX0U1OATwYhJmPyolC?=
 =?us-ascii?Q?5C2r18XhwJYG0MCzA+TD8VQzhOHmrgtC7BAfQ3aeP1zJnISJbzGewFbOZ+zy?=
 =?us-ascii?Q?57VRmyrNXJoJIKX1mrl3sqJpyILCgjn3/HoHVvxMgtYzEzISCs4tbV9LRuDv?=
 =?us-ascii?Q?We2MI8gvx0Eyomi8TyC/4cah7GkfYs8MjjvZJ9uKZWnc+/Ex3b+fBYLc29t3?=
 =?us-ascii?Q?XDsr1VRnjNoDkveUgUq8Ib6TcSLg02HGfMFlFB+p9VzS/YT6P8X5Iock/yYh?=
 =?us-ascii?Q?k/TV507UfCcTFqNsNo1Uo7KQrvIctWioA3kDMp3zaI104LxoPpjyla8CxIrA?=
 =?us-ascii?Q?TOW5XsdhcWAmHxCENDksmpSNUh2OBz/o9kGXT6b8Qh63NjjigtBnn0Ke5kj4?=
 =?us-ascii?Q?572tXG1Nn1WnDJxOOaKxsEmbBBrZ4MMSdoBNl52k6VUSsHFziUinOsOmKxSN?=
 =?us-ascii?Q?Ns6lQv9cSoosPO2UK9izLtPYCWdh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LUe1G4Z/0pvkyxkoEC85mIrBOlUn3EJozONUIPe6LPVrMdkvytB4NUKai7AK?=
 =?us-ascii?Q?DWYdT5qv3OY/3eu8Gg1hLD54I0m7bVn6RuipkozpMT5kR26xVP/aZriraMDp?=
 =?us-ascii?Q?u3bQNNpEgd7I4x3uYDX0fcMoCFckJ91VhPMtUT8UBU0VhgvVgKPbAbPgRj3e?=
 =?us-ascii?Q?y6PuQU8ppTTJJdMttuTXRD5L+6cGD9pdG7U9s4lERhxnGFGZD7S+U2tsU/Ok?=
 =?us-ascii?Q?xFTUmtdag6wiKrRH1M6flrleGyIdBooclYAtrdD+UiUhjuYgDUktW81O2azO?=
 =?us-ascii?Q?vx5EzVtKLkSWecvMz/tUG8BEkd0uNUeVYKN39hPo2xGptM5HpZCtbtjwux/w?=
 =?us-ascii?Q?F/WZXYuhvUiuquFX2zSsrK6Tc/d/pA4tqItr2rR7pfs/vatFaszv5/2lutd1?=
 =?us-ascii?Q?jPIuiFIkiXDH4FH3VBh0U/wcsl8634/L/XeisN/FIqK28CbwwqbzxKbEYKgz?=
 =?us-ascii?Q?Q/DK5lQk5nZO+vR2xQ2eBcDlBDOENAn49OrDKYmzuPwy0JvDthD+6YAjVJat?=
 =?us-ascii?Q?Srrq82Y1fM8OhJGfvOp1Jjj4eOMRLf6Bd/Oj777vXK0RSR8QkO/+cmdnW/7f?=
 =?us-ascii?Q?HuzTe2l32EPrbhuTCo+750XftbS45ccZlXgtiPaZri1f6jCOW9weotcgVH4D?=
 =?us-ascii?Q?xKi7lpDCFq7grOq0CCSDnVbUpZXEbZX1L9lTmSXnYcy3NdB72cn+y8IPbWoP?=
 =?us-ascii?Q?K5j2hSaeVYAMbSaeWitQD7VrHMmu3dpr+mtyS+yNQ3BnspRbMzzvHTJ8N/LC?=
 =?us-ascii?Q?boBThLoXjMke79oE6kBsaUgoqkntX0xP2LwC7TvZqd7k0c6xD/qIfUnPlZLa?=
 =?us-ascii?Q?sjB7gb5Lc8KdZZa4byHBWtD9bKHonatWnbdprzzBmr3ILsVOuk8ZuEBqCGc1?=
 =?us-ascii?Q?6ZS0JndlfINKKUO95dWPqf0uDKV1NLwZKbY+pGFObk3JuPijy9vxrdDTo1tE?=
 =?us-ascii?Q?rgdyZpa+zsrkB00mSfe0o7A/7ILJHalZWDZ3Mpd3NXGrq0ifcoJQJx3siiNd?=
 =?us-ascii?Q?eUSmpH4t44M+Gf9qG/ZSftn5NFCgbHW+MX2lMTZRGcTU/yQYsN6aHcCNCAQ7?=
 =?us-ascii?Q?gQS5pmRrUPLs1LSH+2sPV9cEeV2p8NLMerj2F2VtUatYDIxwUjTT94iR/NXB?=
 =?us-ascii?Q?INVGJ8OEAu5Dv/Y8VJUWjJ97CQQzUjsD+mMPbkbc/dQWd/c1ZlBW2vf7QKU8?=
 =?us-ascii?Q?CRmZ1yToc8Kmq1GZ3LEaMJjudNyipg/6Zm0baGGykQBTm6DURA4CQdnVyaYq?=
 =?us-ascii?Q?+G2UCJfSXoWutTP5a/xcsDGCBSSKDZ270vR1U+YWf0MlRbf5BiY1DkksOIl1?=
 =?us-ascii?Q?jPV+xcoDAZRtf5edEqC12NgjfZYABj7fHFDYC9lVm3QQwjCi5HOVvFLTzzUW?=
 =?us-ascii?Q?g/tnn90A0wbQmiWUc20+d2vzkbYLla4+GAtecubY+VhdZk0QG+rtM6qfQyPB?=
 =?us-ascii?Q?gfPyV0uGie8XaRT9iEMhGAnhhrGeMYPn1xL9kfn5pDNUm7GSJL+VT/Q/4Pfe?=
 =?us-ascii?Q?4xit2InaLpK+51SbG3L8idsXAG6uBatSPF1U00/sDDuppBnVopbuFoJI0Q56?=
 =?us-ascii?Q?R0B1vYl4qkzttrXWgS2kNgnJ6KMH+6tmN1SQWAvZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64661b37-f62f-43f8-b9c9-08dd5d765129
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 12:48:10.7405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJQoxRx3q551whCGPl+FnlQqeiWlJbIo7169UaU7e5Paj20XdEfSf6i+T6tFq7Sb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739

On Fri, Mar 07, 2025 at 09:50:07AM +0100, Danilo Krummrich wrote:
> > Technically it is unsafe and oopsable to call the allocation API as
> > well on a device that has no driver. This issue is also ignored in
> > these bindings and cannot be solved with revoke.
> 
> This is correct, and I am well aware of it. I brought this up once when working
> on the initial device / driver, devres and I/O abstractions.

Yes it is also incorrect to call any devm function on an unprobed
driver.

> It's on my list to make the creation of the Devres container fallible in this
> aspect, which would prevent this issue.

I expect that will require new locking.

> > The actual critical region extends into the HW itself, it is not
> > simple to model this with a pure SW construct of bracketing some
> > allocation. You need to bracket the *entire lifecycle* of the
> > dma_addr_t that has been returned and passed into HW, until the
> > dma_addr_t is removed from HW.
> 
> Devres callbacks run after remove(). It's the drivers job to stop operating the
> device latest in remove(). Which means that the design is correct.

It could be the drivers job to unmap the dma as well if you take that
logic.

You still didn't answer the question, what is the critical region of
the DevRes for a dma_alloc_coherent() actually going to protect?

You also have to urgently fix the synchronize_rcu() repitition of you
plan to do this.

> Now, you ask for a step further, i.e. make it that we can enforce that a driver
> actually stopped the device in remove().

So where do you draw the line on bugs Rust should prevent and bugs
Rust requires the programmer to fix?

Allow UAF from forgetting to shutdown DMA, but try to mitigate UAF
from failing to call a dma unmap function. It is the *very same*
driver bug: incorrect shutdown of DMA activity.

I said this for MMIO, and I say it more strongly here. The correct
thing is to throw a warning if the driver has malfunctioned and leaked
a DMA Mapping. This indicates a driver bug. Silently fixing the issue
does nothing to help driver writers make correct drivers. It may even
confuse authors as to what their responsiblities are since so much is
handled "magically".

> Having that said, it doesn't need to be an "all or nothing", let's catch the
> ones we can actually catch.

Well, that's refreshing. Maybe it would be nice to have an agreed
binding design policy on what is wortwhile to catch with runtime
overhead and what is not.

Jason
