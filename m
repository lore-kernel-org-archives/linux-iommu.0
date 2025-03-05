Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE25A2505A3
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196485; cv=fail; b=Wz9AdDJse4Cow+91GRkH1s5s/6URQ1EOZlG25iqwxzDj2KzsQgr09I797gd0Sbtmy85AzCT37/d2C83CRjnI75tZHbV8kznQ/3Dlczr8rD/FYdl4IGtCIBstM+687DTai21TG1iGE52+daoUlZqJLULW2Jd1Edd566eVxsKHeFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196485; c=relaxed/simple;
	bh=tl/kBQBn9XHg6NueHjV0vy1xXhJ0Ufvs687ur1SmwW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OPCLOl4URlFZ5LEasknOqth2h7dYqTyYc0uffUfvHtpwIBnc10S6kYJvbemCERENBNvJttRIWihKYKcp60hcXTbVYuDkvecnCtfSCeuzfVQiSnht90795TQ6EEj1r8t5whaj99tdGLs+susVhWLNB8m+I4AjZUOCrFzV+E/va/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n+zEhU6x; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n+zEhU6x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ug7cbtSI/Ec/hjOGYZqDUrqFJlVBYGbs7EaiPpMWha4mI94hSp03LoII48kcSmIgp1b/KJKgaL1kbFzhYDeApTXHEGF357padAkzQBMRCWeqB3GHTIQEwxQm9HVyHiSUaJeDa8Ruoxh1Hwl7GtnKg6clnu1VUVk4PvCj3kV+o1EcPxwCNbWw6olEQ3a6+ueield1a6LrZBusuMyQSVFwVUlYExaotPO5Btd7Dkv7hB7sfLVHUgwfXSmHOO97eUFYJPY5B8srWlUR0+XTwnHF53umEuD0/b/FPXYUTh6wtz2XYR4Pue0QFp0xF45BJj3ALyRq8QjWovWk+uycqQyNYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEpKK7OO7b5WrL6ySOcrliyw2DYavjGjYyDXpgvyDGI=;
 b=QgsWV0F3L6GMmQFqVLbNq+q4nmi0bRNuSmhmHUYcN3EjSHnKfiQWjmv2H2VSe7kyXWbNkOHsl49beLDeV4gR1b5xPpyaFj5in29oCx4aJs2imzbMXT1kE4XL4QgDBWkMRLHNFIbXWkxdp99rcoYhrdF1UFYY1NJFGaToJiWKPyOONOok5NvECSQhx87mcCr+Ihd9F9faRzeTNmQYldWrTGuddaWaLBUQ4c2uaLXPZ25PivJxRERP0Os3thutMzseyJBeJkeYvCzDwHzbkJci4Cgc2k6c7A9zuPkJnrhwzTLCbesaHQAF31qgjGGSucyBaf9QlBsEaXxMoOFpFwEh0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEpKK7OO7b5WrL6ySOcrliyw2DYavjGjYyDXpgvyDGI=;
 b=n+zEhU6xQNyF0mW39xZThnCL/dUXEBeyRQVSss7wxIakF8ScihfCSSPFRoLRD2ltO3vuf3+fQZy45gJZ3+a4V448IVswCtg4dz9sPnAjDaevucZ7FJEV2WLYYFhnYXHoSOUphPAC1cJHGI4vQavM4/tEX877ILALVnVtaxm+r4U8B+5PJfVZjc+UAnfb25A3lxhCwDhYc4HflgDLD2UA8ithrVeMhwfQDv2SDJVOlx8DXUHb/2d7+eRfP14nVMVneUcOlyfoE1EI+XQ8/wEZGYsAX4m23KFxQOxzsC8Rjy1prPbGKHNWRIGrnMf9ipoX7Tv+cqN/PZjpXJZ6Rl9Llg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 17:41:20 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 17:41:20 +0000
Date: Wed, 5 Mar 2025 13:41:19 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: aliceryhl@google.com, dakr@kernel.org, robin.murphy@arm.com,
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
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
Message-ID: <20250305174118.GA351188@nvidia.com>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
X-ClientProxiedBy: YQBPR0101CA0196.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 9085e34b-748b-4cea-89af-08dd5c0cf07e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3mlogApHaeygcnmfTK3w0x4Fd/2uvdMWxw6ThwloZ6wQAvz/YgxQ6Sp7H2Sn?=
 =?us-ascii?Q?YU+YacVzyhSUckv5g8ff+LUaf0zFdXS93J/XzZQxVcJTBC4DlmRBwd21S+3i?=
 =?us-ascii?Q?Qw+mTsnTVzNpwZgVliGenxTklytPxAfOoRpUB1kU/7iLd9QGJe4kHICnIDbJ?=
 =?us-ascii?Q?/5p8mFuZJHeF+0fGqcgJR3o5f3VJ12fXvJ3bLaGGq+KfztP7vd1EzFzTZbCj?=
 =?us-ascii?Q?UnXnEF6Snrcb8MeewJzBUg03eo8mCXmUT9DjhhpmYGZfAjt/4CzgiOZCzXCZ?=
 =?us-ascii?Q?n9/tHbLn1WHg/2sJ4gpnTx617qdSPitcXmmH2AHckRsiZRMJH41k/LVYckuc?=
 =?us-ascii?Q?z0dAhucrSX/4RUggHYsYfpbb9tu2r8AeeJrcqKRiASM0dlch/pRlauT4VzAW?=
 =?us-ascii?Q?u8f6oBQ+0/r/wQnPPJ4u1u2aQonTTBWqVLctKSzQihA7x4zLnGblMpLSxE7v?=
 =?us-ascii?Q?3xtBapU0Hn30Dyv7LZQ8rKRoMtzzTCP8cYDj8Ud5LXi7pU3e88lrk2wCDUnN?=
 =?us-ascii?Q?kI4Y1CBUGYhMdy8g3ZsQhACVdwi9lxeIAWcOyfYv8vAEG8aOorQLLTeiyMSo?=
 =?us-ascii?Q?R4THNl7szbv6no082V/+NPqCHbfeR6VX3lDEU1bLtOvte2UAidK9Cz3wPBSj?=
 =?us-ascii?Q?k5wH9+Yn4d+DkPWvT6WChiil06cxJOP4ad3jgUtn7MG4V7IOXQLI3Qk4RADT?=
 =?us-ascii?Q?5Gpx0VZTTPCpjdXKfK1ADFsp+rwS/eOqc2aN9uT0xvsLbijhJoC03wSPXX6X?=
 =?us-ascii?Q?j4H+GBfTJj4bMts64Vs79RJ3rsEYYfYU0TyYWhz9xEtY03LYZjcPcz7vShxh?=
 =?us-ascii?Q?660t5DLa7mRDwKnXJRqTneikoAeJBi1dA+LYfO9mUPePmsg1EGlcOtIczIn8?=
 =?us-ascii?Q?t4lzF6LQ96JskiMYZoymhuZaHvuiMAWkcWo3gK/04kAQGYzOe5akiIV/O67Q?=
 =?us-ascii?Q?IhkJ5NYsP7pdpeOh/d24wKz6xljLadR5PMActqZ+CbXBM1AOTsntUJ/RX7cj?=
 =?us-ascii?Q?mnGy9RDSvZOX0ikUoHQyMI/6j5JrsjlRDar6ThYFqliFZqPyDLXLgEezPAYl?=
 =?us-ascii?Q?NDsG02mLpwOlPjWy8GH0ISLkOQS88wsoifM0CyDEoxWPTIQaZz+UvJqN/h8C?=
 =?us-ascii?Q?umw7bFyXxyi1/YxRbMWpGGb6zjnRNXLDuokQsNCeJzmOMSfzk+fRiFF86cQ6?=
 =?us-ascii?Q?VlWWxpZozoGXsonvxwFSRNYCiR6yzRMFx2NsHER3YS+3DXruMU4RaQh+uSJX?=
 =?us-ascii?Q?O1iKkRktr37I1siUEsqKLetcy9YDXPpdwZ5mHF9InchYwAQc3xxMK7lUsTgd?=
 =?us-ascii?Q?o/39IpBwWcXfe66B6gJlCrxeOs4AoXmF6y01iaKgxVvkFTSCTiG4X439NbNo?=
 =?us-ascii?Q?iSqxIMxUw/jERbBIRlgZjwkEeDGQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s9kjgC36NWtr6lIftfF1dBP8kR7W0w2CwsBDnyNtv8u308nbvYxTXw4VL+zj?=
 =?us-ascii?Q?6D2hiZDdZOsmVosg2ayh2wqASC2a93SOoRF/m2F2iPhATf5P3BQtEvSPj1+5?=
 =?us-ascii?Q?K0/tEjPTpXOIgez7RByLYUstIUhqdRzMPzKBdMhfntT/Ju/PZ0CFU4uq3L7s?=
 =?us-ascii?Q?hUP/0zDZg2VvJeEa1E4o1qOF75TnOcT1zR2OAfwcosHMiGfy7sJqQSvEkK5R?=
 =?us-ascii?Q?7JrlwpH3WKZgbOhjAoP2LizKz9POboItHI/1cffgxd/aYLk1JYilrx0MYiBW?=
 =?us-ascii?Q?zDg5y7V7d9kAriMwwKMzJM7Aew0d7LLcWtCED+N7dKa600fIkfXVfygDGOj6?=
 =?us-ascii?Q?mwxgTXHYGN0arJi2As8WY6LH4hZmzff8aSHuSGLt730j3F+8y8ow6OBoyqbH?=
 =?us-ascii?Q?1EfRp8Y2DtjjBfdw5qpcA66PNZETNSYg4rfcN6K0PJ/iH0EpL0AK3BELmMIl?=
 =?us-ascii?Q?Dnp1XwU9FPFBlnvdXLaxCa8RHZiXGaLUPMShw1tCTz0AstP06xm83UZ/dZwb?=
 =?us-ascii?Q?KYUYdFqQRzvrZv6tRmLnXNaGqXd0V4J+3kj1jHvmzAxwMrxFP25rsANUUld8?=
 =?us-ascii?Q?VIZHf7aaMv/KiyyggeBEZSaGqtPxtx5gRSK4kK5+1SZ0KGRpNKTFqUNER3vj?=
 =?us-ascii?Q?sbFZseMHn6ClW+9HiPsRjy2C47q8N9xGOgPjICAyDzE24H6TZnnuwmgYNUQL?=
 =?us-ascii?Q?KBQmLu3KDlgvNdvp/UDqxAxVQ4axhfqhFbPq+0irASIBE0A5fo+DCMccI2nw?=
 =?us-ascii?Q?+3DNcWF3cFt09phzetKqalW6ZQltzJI+VQ/Xm4J14XqhAWGV2gW7XBuJbC5r?=
 =?us-ascii?Q?BzA2gyQ07G3tQ8dsT3Y0UeV2+DP7HYssMBl/jNw6R4iA3HC3oZlaUcuFJ1sN?=
 =?us-ascii?Q?5T6ordUvS63IRJptHysOuPGktgD9ekQmGkhNSzfz3HwrzFdmUKILsp730iGv?=
 =?us-ascii?Q?ofA+0IazgokCB3I31UulgJUOU8GSWDyhj3ZzEal7JEEPHrjYm2haLASfOvoQ?=
 =?us-ascii?Q?xIlcTp7q9Sie+qux8F1AX6W3leG0W92rpERU4xpqiWa2MjFdSKznbwcRGqjX?=
 =?us-ascii?Q?J9K4IjNW6j3ZWxv/1EIwUm5baKygZQCl2Dl5ep5BYy4xpYOngPsa1rHw1jYP?=
 =?us-ascii?Q?r81yVzcZHcw6WuMGBom2E7ytSwWB9lQ1VW52/xbCGIxzYDIz1xlKEwLT9NIa?=
 =?us-ascii?Q?TH+hi2WSgi49KyfQ0niRjpucZexhNrczL5YAVyr2429vyz5Mvs/jWxoXMgxk?=
 =?us-ascii?Q?2D+g/e2PchaPhgkLX6SLpq0GIN3CfkzikNGfoptx94HJspZDlH4Qq3n5jHYS?=
 =?us-ascii?Q?iDahYlet2vtk3uM5je8VauEfvVafQAuUv25JIeXhjK2/fiQNGXLZk4kLXYzx?=
 =?us-ascii?Q?/yz2x3pjvlqzL0ZEyS404nIagxsk7lT05TGHhSCySrAFCYImtAoO02blpAe/?=
 =?us-ascii?Q?4HJBY+JnxItd00f9roEnsm9G5eAu6hIjbs5AHn1QyhuEbCzdJmgpPwkq59pd?=
 =?us-ascii?Q?LgplsjBtEoIEiHxJoAda1ia5MBCsyKI+HZeDuWhPt+Q4iPL4kRwq9MfKr23N?=
 =?us-ascii?Q?QOzFsvFnDWR2Fs3QTwoGXhB5TfVf6fr8Bm1I/ByQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9085e34b-748b-4cea-89af-08dd5c0cf07e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 17:41:20.4641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UH1WHKmbHPZSU8iLM36LekKZVzR2+qxR9JlYTdNwx1b69QfNm2q6ANWb2cpC4gyB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816

On Mon, Feb 24, 2025 at 01:49:06PM +0200, Abdiel Janulgue wrote:

> +impl<T: AsBytes + FromBytes> Drop for CoherentAllocation<T> {
> +    fn drop(&mut self) {
> +        let size = self.count * core::mem::size_of::<T>();
> +        // SAFETY: the device, cpu address, and the dma handle is valid due to the
> +        // type invariants on `CoherentAllocation`.
> +        unsafe {
> +            bindings::dma_free_attrs(
> +                self.dev.as_raw(),
> +                size,
> +                self.cpu_addr as _,
> +                self.dma_handle,
> +                self.dma_attrs.as_raw(),
> +            )

I mentioned this in another thread..

There is an additional C API restriction here that the DMA API
functions may only be called by a driver after probe() starts and
before remove() completes. This applies to dma_free_attrs().

It is not enough that a refcount is held on device.

Otherwise the kernel may crash as the driver core allows resources
used by the DMA API to be changed once the driver is removed.

See the related discussion here, with an example of what the crash can
look like:

https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/#m0c7dda0fb5981240879c5ca489176987d688844c

 > a device with no driver bound should not be passed to the DMA API,
 > much less a dead device that's already been removed from its parent
 > bus.

My rust is non-existent, but I did not see anything about this
point.

Also note that any HW configured to do DMA must be halted before the
free is allowed otherwise it is a UAF bug. It is worth mentioning that
in the documentation.

Jason
