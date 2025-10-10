Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010039.outbound.protection.outlook.com [52.101.61.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0492765ED
	for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760135876; cv=fail; b=HCut7KS3LXQOf/IY31NmUBRdSXMYlOJIBWdGyiPVtdVnF+4ErFOHqeK2+Lh3iiRHjouQQ/r6npJJnbFWRXxdUY+shsFVHMnmWNt6auCEklVZP51bn9L+wUyFIVA0Dcc2O7fpJDJBCCF3y/eJrOydUG0QNqlyCc91H1jeLuuLdtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760135876; c=relaxed/simple;
	bh=+ogHahvGGmMUi5eixgmmPcbXsGdzWc4fIEyo1bx4Umg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RXLvApg36Ju6Sq3/M2o8FFZvPwvc7cg780vXE6AqeyD+dy8R6R2/X1HVNrUYVWjreqo/jWURBQqsejxEIomhzhDD3dcY4zZAvXl7rVppbynsKsk53pSNGYJ889cp/Nwzbx34GRPQREbu6UYeZPYfhwkOsVN7BfB+YuhJVn2EIvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Shg9IsQC; arc=fail smtp.client-ip=52.101.61.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Shg9IsQC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMDOMLd3vYkqf3vj7djR5H6hCnonNPT1AWZoWmotAPeMk8wb9oDo4gTCFFQJIoKLc3PHlwd7U3yK1QwWGHPyPOKVO+tfTWignLXdbcXHs4w2cg8yIxqugD1FkakMbYGxX87CE0ymew1DHW2RuQEs6Zn5QQL/O/Mj4PoCU4tzB3s5nFIUEIuL7+sKf7jCp7bUCBoMw8ghMWyylZUVmbMUhEqkH+6Omo9fDKOtQEpGPCUtu+c38QkqOPc2gVLX+CJTtMAWN84NgPX7k1SRtS1RoiEsMMydWhzpZzPPYZBGY9RtEasa3bvg2mUYsasyuPGj8vioR3B6DdRtLSO9x8GEzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zwi55iR0I5Y/pR3yGFJDZc0HXcvDrwE7H/HcWUYgYZk=;
 b=t23PrFSEF1MJKyOy+U3nDeqC/MjMIcq8L4mP/XBwezo/LR2xb8BRui8Xi5CfoAIKs43IFKvTQRADTWMS3duTK0Q53MFMP9mj3jQHh1zKcw89e7BlXnETBfKQUrNlx+bSxxvSeaL3G85YW9ttNuKytRB5A9R+S0aD4LNtqyVkydq6rRDOS6WbSFl0QYtI+V9wbXkGQBS4KkBlbPPhHVsolx9isRkVMN33wAbIn+wEAsK6X9fFXzKrKIt7QeXfHIBTF2EZNONaiGs19Zxb3lZBSYCmnhfxy7lFSGR+hOYIGfS/kh8dsMufpdkLMRX6jnFjmmw5EPnFpA3N5XuEiyJLPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zwi55iR0I5Y/pR3yGFJDZc0HXcvDrwE7H/HcWUYgYZk=;
 b=Shg9IsQC4KtFs+JdnBvZlYIb6iA8jOjolRn5gY+ZILpKsSmXMCb9NnU9W2rPJrtNGHd9WgpnkgIjOZxj2MLQeeaI2XWbs80qXE4zYRPouQ79EfTvvQpJFiLKIIwb+Z5wNienMSHP7AQWehPb8KtN4AgmnJ2B9hDfc37Qfa0UtPj3hQ8B5WAhlp8DFYh71jH0r7IFipSaJN1USQ4+pzNqcffTC/hot9DgTgSTmkUZtPAhdi13AxZSfl20xJM0yrNdJDqa8XQ5s4MyzHy/ur9LGIoKtfHXbL+LM2sk7qPhpWsxV9SylOq6nR6KxyfrQHRQLeM8ovw8/kJDMJvocQkoXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by PH0PR12MB7887.namprd12.prod.outlook.com (2603:10b6:510:26d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 22:37:51 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 22:37:50 +0000
Date: Fri, 10 Oct 2025 19:37:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v3 09/15] iommu/amd: Always enable GCR3TRPMode when
 supported.
Message-ID: <20251010223749.GJ3901471@nvidia.com>
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
 <20251009235755.4497-10-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009235755.4497-10-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: IA4P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::13) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|PH0PR12MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: 4354aaef-07de-4eea-a83d-08de084da4da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bUtQz0XZkSXdjCI2GYWPMpxwCYswqQjuThQyyxIzRjZ5A2LWE/iOTq6QHO4U?=
 =?us-ascii?Q?RPNvXReUbjnkjgckFIGtliMchaoIR9qk705Usu42VRwyD804XMUbXZILDxB1?=
 =?us-ascii?Q?om4dNVj41w26xdB2dkRFLv9wC92bDdpKu5mV/PMc0bE0UkUUCZ2kUj0VmXZm?=
 =?us-ascii?Q?61wISICpyUJ76wVOs8y+LN+Ihsw+QK0ycsroXZDuA8x2jzaOdjO/Co16bPXr?=
 =?us-ascii?Q?OWZQY8HRgR/eCfWpmfaJ3ix3PwoKce/bbTBqyv4kold48zC4zOdopxJ0VkRY?=
 =?us-ascii?Q?H1cFoKJtdoE+0fDdVKSok9T8hHuq1wbx+/5ZMLRIEjFfNNbYjA8DBXMQ/OkM?=
 =?us-ascii?Q?x2Lj//jly+dS04ZAkDCzYlrYID/H0Ce54aNSz2mR5j3Zv5GfZ+g4xQt8ogSx?=
 =?us-ascii?Q?2xhBfOzru7WWaQyx8M1AfxLg9HMORNhEbxPv66Kl8ASX6KhOTkEd3hpBTkRx?=
 =?us-ascii?Q?Cy8kfVODn8VFyD1DOE7rTuDGa47j+cXzAMKy7AXHPoq8HDJYapfac4lffCMN?=
 =?us-ascii?Q?F5yV/QpBWddSoZ6e6PH29SmAySfUHH686nmb76MVdTEO6S3CZiG0oBKwpDU4?=
 =?us-ascii?Q?Lz3D3RZ8Y/DLQG1Rc96FlwgKdH2M6SSkLiDCFjBrBLteBPE45MfUYcfjcTBV?=
 =?us-ascii?Q?kKfDBm2B3MZkte5ohLbRXtlzBFowy+lmt2muQrKieZfZuLcuciJ6KyPGNepp?=
 =?us-ascii?Q?ykUJC5ctFG7OQs935UT75gC5Zf0hdNhlQw0pEfqjozqjeEcY6rxoqXPAQEkz?=
 =?us-ascii?Q?j77qUr8GSYv7Ic1tc/b0BTo9k2ITKN52Y+VxEECeu/mtCP8FWvs8ndURdm7O?=
 =?us-ascii?Q?x3FjPhqHkBu047+8218MmSEVrQwEhPrVyarpc0gLGzjdAZr8TM4KpSkn7Urv?=
 =?us-ascii?Q?9w5c5lPZqeLVMBIfapDpzGIJFtRN4v4p0uUPaYdENIfti3tQghHfSJzoY++z?=
 =?us-ascii?Q?Klnc/rRQ0cZtw9t4VuGW6wOgj3n/9rcnPEVjhZQVFlSkvts6/xz4XQa4zjUR?=
 =?us-ascii?Q?49LXI3iNidBg6WTMHCWpf3fb/PnAltfk7og5tsmqNlORa30yPE1BWz7Pqgjs?=
 =?us-ascii?Q?BAfopfk5FIt7lYHO0VT3pjSSQPCpzMTq6BUw8e11vzi24cmz7kBOPe1EMbJJ?=
 =?us-ascii?Q?ht695pPXVX52JYwayV/B3hh1ukl0paiMmHiRYnFZcYbdAa+jXYBrsRcLYTjy?=
 =?us-ascii?Q?JJ3kVe6dasrc816lrfqGGQMrMCjupXXq/ObHHjiTDO0NMzOCrMmlvHi/cqWG?=
 =?us-ascii?Q?LuHX9ovOhNPhsCNQ4NMjJyxB5s22KJOthwG9Dfe6fMxl5EkxRQT3//MeHyL2?=
 =?us-ascii?Q?6T1+RDJGuhga6x89E8V9EQwjabRoLvaJ2JvsPGw2UYZF1IPDEJDTa69jLOYX?=
 =?us-ascii?Q?FpiQjLltBY7nanbUCUTThfLCYlb6s+KIjrscLyMbzsWeOH5B5l86mq1LprCv?=
 =?us-ascii?Q?ZpHx59PT5PAnD0AxNB9+ZchTKfaX6vEK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?99JrmOtg1IFHijksBnvpGhQ2GbmpxccHrWu+S1GRUEhhpqM9Ts1iJyjr9jdi?=
 =?us-ascii?Q?e2+Q2Zly5T9tDXt+ubC1w4AyDmOUe6ZKic64wnAqs+AhhcUiaCCfdVgWb9dK?=
 =?us-ascii?Q?MYVVS/QD0JJ3KhZcy82H872e7IEsUCPf36nyMTw8fOaFOJyNuwPISYJ74wUA?=
 =?us-ascii?Q?vPENco8kLZSChZizgPDcdGcJGI6wm7OU96bCfolzFtj+Bcm0iBcT5FH2UWWF?=
 =?us-ascii?Q?HL8f1A1gD+NcI9jHBeGqik+7nKZU7aCjPlEoxg9ZKbJ27HkN2ehJ1Zv9UqvV?=
 =?us-ascii?Q?P47yMiTbmcmDm7evrtJnmR/st20UR8I3nbovc7ZN64fF6jqVhK8nlPJLb5ip?=
 =?us-ascii?Q?Y7SbQtq2MdTsJu/e0K0/nUg3CPpRIIGt31naStcnre2qYvMym3/oaTIZpxzn?=
 =?us-ascii?Q?6fNi/FnvWLeeQX/rk3qkNkkcpG29OvQPLyYkDDWwu9Ud4oZVcMy4bxvWb8Pt?=
 =?us-ascii?Q?L3H24gJ/PvBfOVa4rcL1eg13E1a4Fuu63uI0aLTy9n4JRtKY8TOu7Omv6WJj?=
 =?us-ascii?Q?XqiB7n9h2tfsCA5BYcS/4RTvVfp1u+lhafJhhQaqQAblPmpFAGpVMXYmyc75?=
 =?us-ascii?Q?bzYiBh60QgK5PJXkNJOa+RY1bA1ZoNWVmmb/9Xf7oB8/T3rpoetYaS2NwGvR?=
 =?us-ascii?Q?wR6BPTopbJPyOrUHuDkCj9Fdidscx1jpQwT6iOYXGKz9NLxqS6yMLjXawSRr?=
 =?us-ascii?Q?P7iyKwpjaCpqblquim3w+HIOOZGWsTt5sxTaDrbDshNgI+n1tAaA90+UZgf9?=
 =?us-ascii?Q?9fAcC3IrFeB6PMj6tl22Oi42L1lRBoUjBJdSpSAWYMhNR7n1w6x8pzbQGzgb?=
 =?us-ascii?Q?FDsh6fnpN4xBcgefTSLTO+plVc5UvCLVCVRvolBFx0mw+mTPmagL9mN6gfXj?=
 =?us-ascii?Q?SlVEKSoqhhWLYSu4IvTrios6ms6NXUslBdWDtE97HNpXMI9F7lHHFgHAPDmw?=
 =?us-ascii?Q?ASIrzQbwfNNLa90vMRuXY9JM30hJBn2cVNjGFvIuPxdJ59gifXHVmHAdVE65?=
 =?us-ascii?Q?7IFFa85hOoJDE+LDsW9cm/GC13noDqF5ZJ9KjxYNhoUwYv9W2SEI5W4SucBX?=
 =?us-ascii?Q?8Wbd95RAk4Ty0H3tEcoralxP84uoNcfQn11n6kE1MpgC3yz2b1xmG/7hfm8h?=
 =?us-ascii?Q?bCquXZKcFl+6+2PJPY1BhMka/3o9EeUcdkxSplKbQtova2phWgDpVWO3oApf?=
 =?us-ascii?Q?XeG8i0HfZRD43KAazkqIsbc3K71DOMtJB7XxoSAf8CdSJWgByt7qxiyV6wNq?=
 =?us-ascii?Q?z9Ms0NlE/CFfrDNeqef4BbC+0TN8zGv2ZHwMqhthlb1Gy+w0vJD6pXp4QR2/?=
 =?us-ascii?Q?G9s7NFdvD7VFXAyXgRYbC9WXeEbjPakf8h6Ptk7cQ5vRoaIe1S4vTFCGY4wi?=
 =?us-ascii?Q?mbqdpncXuvzS3UKfAxST2O6Js2UFz9vMdQCMB9R6ZO6AQSC93A6YvzjDqCRn?=
 =?us-ascii?Q?wMRnHzfB85CWhHOByA/msH6NLxBV4tJ6p0Ctrwx5g6nTwFeT03EbSu0LP/0G?=
 =?us-ascii?Q?Om41wQr7YH6IC1H2hh2lkNiXo07PvbB1pnCHaOudEaghDxx7XdEw345dUei3?=
 =?us-ascii?Q?iUVEEKKd/2nR4bjD4SQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4354aaef-07de-4eea-a83d-08de084da4da
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 22:37:50.6721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxjbZzq+DR9q1wWv4szmlokyLwWnRix0rDmBGStu1A7QsI6mwTB3su7ok9xiK8hs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7887

On Thu, Oct 09, 2025 at 11:57:49PM +0000, Suravee Suthikulpanit wrote:
> The GCR3TRPMode feature allows the DTE[GCR3TRP] field to be configured
> with GPA (instead of SPA). This simplifies the implementation, and is
> a pre-requisite for nested translation support.
> 
> Therefore, always enable this feature if available.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 1 +
>  drivers/iommu/amd/init.c            | 3 +++
>  2 files changed, 4 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
