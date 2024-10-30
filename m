Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E8EBE46
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247070; cv=fail; b=qRX8Ys7PWLnPoFpAxjXJwwrjFXiuNWR/vrFZLcMreyDdv+dznjH60QRR7Gci1/Bhv/A16kNWLg1KI3jQlqZEcyYYZ2Eh09V9qC0HOZJNbIgZEEt9G/5Rub4js5hJqUWn58EqOwHn2PwWED8Cc+sG8SqCIBfcS3flu9x6l9pvVvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247070; c=relaxed/simple;
	bh=uUuPEqyt4sJKCqI/8wr60rxhP7vu0VRASCsN+xwwbWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=siRbgjuOATjdUhw6X7Y4imn/oUAIEBNnC7Fv/HArbtoJMjArYRxb/KwSgWG9aHd7MqPEkVBVJPninIxXYFFSmHCbMMIyzCEuAGBn73Ajtwc3c4K9ivY7sknucbbMXiqJ/WVkL9G46iKAYlszhc8JwVwBcypxqdbgvgSKLBEsUKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bF5xIuw4; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bF5xIuw4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aet0ACVNdY1iQ2QscmMz0A7wQp5JH63q0pWyAJzr0A20srfr94d897eCxUSCkiH6NfM30PeBjPZ12BTOcVfTaQ0xIRy9qMMW9beQ6zILzCzA1+vYlHZ1//lRwmghx4to/Ajx8ajxEpTGTqM7UmmO/+76sUazwuTlrd1rcDVd4htaEzfYzMww4SEJ9tcW9PJx/dAX45phWRjKmos4uELYeKl+ZFMZPppj3/mIIG+8/jb+9Qz98mCLeDGAUfXu7Z81qEd6jPjxtl37dUFy6ruOnQ98vTbDqcC8cgLGKfI9Z90R7QG3qRE0cR/rmPCEfx/08gSVtuRwuqe4qFs/g5xC2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jx5FrhcTkJmHfrvl3SHomYuyzIhvRIFhASR15KziuNc=;
 b=vNl44C1noy4JFLcRIFB/IMUg7HjuN4hUJkM27m2Pmh8efhU+ZaArx2e9AijF9qyaZbFw0dVvDc9+OYLS5jfOetNkE71Mhuf+ZIX9dHGxs8FEU2douyBU+UZ9FDMn6JjSEStJFFvMBjfDuVsZsMkAE5Rmqy8kth+beYeMKzkgovHREGiRqskLw3KYWS8eE9TA13RaipDyKzJOPG47JJI0W6iMoh2ZYzNCKIG1FBuPDB7PRCu0ykl5XW0rlt6lMUZfRjvivl4Xl+Zu0eKDIG7ZS73ijX44G+fB6UpVO7Nvv+2XEezShPGehDvbtwT43tN7ywQfp8v0ylk/RS3jLm5wuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jx5FrhcTkJmHfrvl3SHomYuyzIhvRIFhASR15KziuNc=;
 b=bF5xIuw4AOVtnzeuDbPjjiYcsIA5l/DMY60VX0eadlvTzqd8r15Z0EaatGzO72bE9k+O7G7WyiZTTMBIJzKvNjOb20pqJOTkhuPRlwlq74U1z48EUukYWkXNkN3JfUY505u/7ogu/lnzFuNHssK3GQh39Fh5ibeNftBvjWnFfS+Xrj9t6nLP+0bXX0lOVeJI9WhKNcA30vR8EyyNpUmNDtPhiSww0LboyFwAGQPRsSJbqMWLjIbXqgbB/fuYGHL80UAtQAwJlKPgb9Z2cStafFZ/q8QmoBBlhvMriYMr4EkTwgFU0xkcaLSwiWxC8d24lZBJH5HxlW+n5cWketEdQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB8883.namprd12.prod.outlook.com (2603:10b6:a03:538::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 00:11:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Wed, 30 Oct 2024
 00:11:04 +0000
Date: Tue, 29 Oct 2024 21:11:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V7 0/9] iommu_ioas_map_file
Message-ID: <20241030001102.GA251312@nvidia.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: BLAPR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:208:335::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB8883:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eadf1a1-f68a-4542-2c58-08dcf87757ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U0Jnx9zPrBTv+nhFd2XMKIooAjSHd/9Rj00DREpnMxwJnVQas0VuSLuk0Ttt?=
 =?us-ascii?Q?KmCr/z2Kfw3rImL2Zfl9dOZZ5vQ98B1uFcT/wPvPmvJesRcd3vQ0TlXDIvoQ?=
 =?us-ascii?Q?F+8YG2vWz6WEbFbF1+QErv/Sp3C80MeiDCZkaSHa7hNcqeriJ83ghDOROsnX?=
 =?us-ascii?Q?ZT9zmIuMSvgFI/5iqXd3+SurwzM3Akz0BNwQ6zqPec6c9Zkw4nfIKjU9Mnwa?=
 =?us-ascii?Q?9W0EHaZ7M26ciT9jL20BHO1cJe92hGx6OHoH4XpiDvumyi6TvBsycwrFX7RF?=
 =?us-ascii?Q?j8YoClA3tSvSzCCIWPxesoEKPAx2CZnhIW5iTKMvhnARjVGwswp4pyh8GG4P?=
 =?us-ascii?Q?mo08wT4U727z+2gyKmp0gG37ITcD3VKvoU5+oqGjR5wHq7zg/A/qW/722Sjy?=
 =?us-ascii?Q?VxIciUNmp8tqEfRGAsK+JNCEFxhTGcS22XZmlix/Kr4KIk/2+RsbQjSIR8TW?=
 =?us-ascii?Q?055ftBH9+x1tO3hO12dzoSQ4vLFj/GD/omzfY50Gk6Cv3jT8D5L1W7iyvtic?=
 =?us-ascii?Q?lbGIe2sv8FzWb6nc4On1s5Pq1VlDkI7WRI2IDTMXasdIX6sPMkOoNq7A47Gs?=
 =?us-ascii?Q?wR3iJ1brvcWyXrGP/ESSNhdtfCzClbFwGbUKJJ7pNCe4zq9i4w1cpXIS2xVH?=
 =?us-ascii?Q?KCVKlGPUs56LZpGo483aPuApJIs3/57AW/tEI9CNu5XawYqKsr6J4QOo6phM?=
 =?us-ascii?Q?QVpicugq7tK7VL9OaYVOT8VhTp+NkLdPb+FzL8kGh8QhiONFMA8k0YReTCet?=
 =?us-ascii?Q?q44U56d2Ip8UoALsNHgvlkV/vEEH/nXJkiifA8CXy532bx1/b9MsSSrfeg2e?=
 =?us-ascii?Q?0tBT/d2lw44E5H5MbzHW+Mc/pMe4UbVb+vIfvZCtR7cEdTxDOYAaPfXBYMEZ?=
 =?us-ascii?Q?UtuYXsUONsZ0+xAi+A7XIngpSZKa+eZW5czN+mY6vlGYuI02YjFj8B+cEg/c?=
 =?us-ascii?Q?JRLe4oxG5WNvlWAGAhp3RffctmsUPBHUmsdYCPUl/QXNr8yYuI02Y9FJXFKz?=
 =?us-ascii?Q?IXOVrGhgZ/1kCF+Fq065Gqr0aGpzbdh9kIMGSHr9eMPZoHihC9C965eysGD/?=
 =?us-ascii?Q?8h8NjYfVtNRX76nFBNOlowQk2TDtvVPppfRq7A/jwW+kXGaE++Win+f1hdKO?=
 =?us-ascii?Q?CtD5ypC++jcwsOke8hfyWnR5MUqq7eIvfxyWguYHPPFXeb5c25lffAOZmSah?=
 =?us-ascii?Q?JLZHk1yXeJDNlJ1Z+IZl5pxac9KzWzLuoVpPxuKTiq+570idxEG4C5bUD3Jm?=
 =?us-ascii?Q?s1NbBviZGrmV+mF7Lq1FGDghSz2sUnOL1JhfRGnKtJ4Id5Ia7WduhCEnv358?=
 =?us-ascii?Q?065712BVwNtjq186R/ENApzr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dLg8+WOMi4qXAFJRrDEu8M4Q0ApiPcFg8t9HgEP9NAk3bTFJc1pMkfzM2w73?=
 =?us-ascii?Q?YteTfxDtp7XSIQ64nwdr2+hiJj7f7WRH68v17r2c4Ug6TWm3p10FGj6cxler?=
 =?us-ascii?Q?vlknx0TUjIfZ0icqftiy6N87dVVPsTjslh0RHRtVlQkMB1zN2Zn3+hQU4AyG?=
 =?us-ascii?Q?QojvoMrXt7hn9fNBrkaPtyVT0B+v/6b7ywr5lZ7yR8ERkYHbmd5XhKFaHohM?=
 =?us-ascii?Q?tSoZHKxDuZ4m/E7rkTgGyzEquW6p7accBMuhhG3PXYvQnICTVO+rN+kax8D7?=
 =?us-ascii?Q?lBw0Xazok5kEnaCKRyD0AwwrQ7qY8M4v5D7uEotLWdAhj0uhTF1oazT9D0j2?=
 =?us-ascii?Q?gApWkfpfksBP0FRGMBHG6MvKBln/OvpOyJVceW7jzWIooerMIZ5kwg6pWJkP?=
 =?us-ascii?Q?fOz6brW9jvEFfpLm+ctQRdIbrLk2D3HFFmnakITIKXNf+uFhUlPly2WQF1Hc?=
 =?us-ascii?Q?knFVR/lah7490ZUOMMToBChREhIovzV07QOkzqkC3KFfjKVzZRBKX6v6GOK0?=
 =?us-ascii?Q?oO4PsL3k0Aro9COpULSn/brnYJrEg5WFiS8mgRD1lOeWcXAYAjacb+8tTdD3?=
 =?us-ascii?Q?LWUFpd4Eg9bbprOBWySwOcjlhu+jFOzgyJlgt927kIOj9uWROubUwkICvAof?=
 =?us-ascii?Q?5jGkriRr7T2hPSbNn+ZMJXxTyQmZLMzzALZZOlrqxj7qozy5h/oPF6nOC6ne?=
 =?us-ascii?Q?XuWD3EH2Pk8o3uN9Cr8qXYMarm2BeFpjSWtmW181sphger5bA9FTrXp+cnu/?=
 =?us-ascii?Q?l2//EWmFEoaVMhb5hyN8kRoeqh74iPiC6v/fGYm7c9gUBdcsmtOjznZ2/5Mf?=
 =?us-ascii?Q?rpyYcg9rh4GD8bhEqqhXrNbqUBiKQD5fLNXcR/xW2v2J75+ytlSpv1k+kZr2?=
 =?us-ascii?Q?GLpb6rtjUtDVApTLLdD2tYaLveWurZ/uL4R+XsCyS8gX4gHgbu7nv1dyeTzF?=
 =?us-ascii?Q?ZnOMCqBIRci4b7zAqn4BGQiLpAqiXPO3g5WGMGRm0a7RAoWRqUId+tAi6vc0?=
 =?us-ascii?Q?Fp42TibLrPhQclw6iZGqew7TBHJvcmeVy97NudwLctgxbyUHJY08in/tjcsJ?=
 =?us-ascii?Q?VaOckdOHXHAfwJGss0RFRA1YjrR8VGGV3t46czXYj/g2P30iKRMtKxQR42jl?=
 =?us-ascii?Q?ubHmD/g02HRZAZje2Vh+QR/ybZLrIfGkIJo3O4gYuh9uZiP6JitW/8AbNb0H?=
 =?us-ascii?Q?iYDPD+2jqn49dYYj/6Xir3FdE1OXba9vAnKvdsYEbbLfgGFgDubUcup4iDEd?=
 =?us-ascii?Q?XaXehbeHl1GCeVlB7I5KvhUCytt0Z7YLEXO9Nsd/kONg4WWlNcS5gZrQFgwK?=
 =?us-ascii?Q?8NlW1wec8T3m7CTtzjGM6EKRYD2mlKpZ7Xf4cfXKzYI6GanKSJFsEWvSf5RQ?=
 =?us-ascii?Q?6N/VpQbRvqKJ0WWttku9QjqbGXqi1Rr6oefRMWzsnj+ksB01rKgkF+fMqMZn?=
 =?us-ascii?Q?C6sRXY70ikAgOMUCV8H65xwO7E7KjFZMHEAafr9BkHBgwAArInZs2SQ0+rpA?=
 =?us-ascii?Q?Bhb28uj5NeLfiTWo/XmwbKEEGGE7N1BU6+k82JhV9Qz3X7MGZpUJjvRzKZ5/?=
 =?us-ascii?Q?gO3l0f5SDvZQtanF6Lw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eadf1a1-f68a-4542-2c58-08dcf87757ed
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 00:11:04.1616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuZ+IU2kn3KNOqkWlfPf4xQEFbVr87ZhbeUZ+BhBsLCA8mt6xrE64vqmCH5Tr9pX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8883

On Fri, Oct 25, 2024 at 06:11:50AM -0700, Steve Sistare wrote:
> Provide the IOMMU_IOAS_MAP_FILE ioctl, which allows a user to register
> memory by passing a memfd plus offset and length.  Implement it using
> the memfd_map_folios KAPI, and the proposed folio_add_pins KAPI.
> See the individual patches for details.
> 
> Steve Sistare (9):
>   mm/gup: folio_add_pins
>   iommufd: rename uptr in iopt_alloc_iova
>   iommufd: generalize iopt_pages address
>   iommufd: pfn reader local variables
>   iommufd: folio subroutines
>   iommufd: pfn reader for file mappings
>   iommufd: IOMMU_IOAS_MAP_FILE
>   iommufd: file mappings for mdev
>   iommufd: map file selftest

Applied to iommufd for-next

Is v3 still the latest for "iommufd live update"?

Thanks,
Jason
