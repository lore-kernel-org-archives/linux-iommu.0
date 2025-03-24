Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5432620C9
	for <iommu@lists.linux.dev>; Mon, 24 Mar 2025 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834430; cv=fail; b=dNTu9TOLX+f1wWYUV3wZJwRMpX2kV8MLfwrR5/1x58TI+rayjyy5E7oARYRxZ5ShnxhVv72bv5JUO98Toi4rLRusY9bxpc57Yl8ao6CKuhHhBD0hmY5n9AlAvlkkyKJPoKrraLF4eNfrdLIoLRQmuoChbv9pDhyZSksK7x6webY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834430; c=relaxed/simple;
	bh=Qon+lf+oliiRiaU7Dh3hHzGJGKEsmW0Gm1kv3T39onc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bSS4mMELLOH7eVnR2kGko60jDBWzqAqOtKIB6iT/cy5XZeBspyHCsKsbt69ESAgZflMkh4+A26Oqlk5PMO18EyW/ihTcQOJv/jVNc9uWQvTcmWgOctVbbzWMtJa2+t7lPhh9vEEZj/YcTPYqBKn9cKVJMXOcdz3SACcQW+Ilgas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OPwjbFVD; arc=fail smtp.client-ip=40.107.100.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OPwjbFVD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNp7wXTPdE48CopcYUDqMnBvjn4a0jtMxshKpV+5kTPrvSMkpX3xfv+s6ucUy1oslX+uSRiAhfGnTYNxDtn1efF3l6bweHWAyRaagQ0EKEd9rJcI3TuRCJySwrYBocIEPzwBPHhmnwtOCvWve6/Dp6sPCEMLkyeHtkWXIYzmem7GTJ7+u4NUfefUo9OupN5db4oUj5zf0tBndwz2M4KXAqp+0G1WCE1lCYw6cwSWurnsOildjZtg4ox3yNVeoOQhlXKb3G6fon/o69Qavvq5nDax/9UYAzm8q+3qWIpo9FZrcbjpuy1gYu79hGayHHpw81KRFihbYJvTJh1nxJaW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnsO/Fq4y/q3X9GZGLg7eJbRKqQHiDx3xtvy7owL5AQ=;
 b=WB+sWQTZ2l5iDHN1ZpnptANo/+KwjWYcTCypgGb0AU/Izph+GTwLc2s4T3JMq2tlLKIjomrawQ2NGRakw+chStNvNZ3UCgcvANyhVTxEo/kUfWzBTB3M0xJ1lTk/e5tiyzn/a0qKMuFAY8nkKUrLbeIWZzbeD8EDJRLsvOYS4dFWZMa3WrCs6GzjQR6ja7r5C/eHAKiswBrAxotVmKGX6P10iDO0lDtfB/K7ER32Dv2Cuaud88K902MF6AY+0HhCyQRrRPnYp6z3i0qAcrBDMJ+WGmY2ALJJ6ILlp13Y/8wQRqKwzTN+zr9vJeLEGnVSnCAczE2wBuZgKNNErZbaOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnsO/Fq4y/q3X9GZGLg7eJbRKqQHiDx3xtvy7owL5AQ=;
 b=OPwjbFVD9yUr7+jfKTdVprGZ3oMvseOO0oAHyXr+llrNJ5IryOznj8AHBsANv+pnJEmvCs5VJ7fnE2gzXwcg4meDOWh2qTxlNyunxaW5DLszFOFzUEMkJHIkuweQ4I9ml0FJvFT8VJFloOj/nXQAY6B/XzQmWpGacejIbK+juohsaLBAb6y17KB1BiEK5tw45I4ltqxAkzSbmx+IY+W/uiOC242R3j/LdOyHvKUq5vn7HH0pPZ+UlKoheJ5nowLW30+2mCegtK8quzfa53Df3jdgRW18TqsEf9ph13VDwN+w5MlX2DZUXM7POVGRuRQg/1uQNfqpw0p9Z38PI6Gxbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 16:40:25 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 16:40:25 +0000
Date: Mon, 24 Mar 2025 13:40:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iommu: Drop sw_msi from iommu_domain
Message-ID: <Z+GK98/VSvYl518j@nvidia.com>
References: <cover.1741294235.git.nicolinc@nvidia.com>
 <6d4b493d20926c8d14e29bc776639cdcf2095146.1741294235.git.nicolinc@nvidia.com>
 <20250324162558.GA198799@ax162>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324162558.GA198799@ax162>
X-ClientProxiedBy: BL1PR13CA0397.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 77d6bf38-6a35-4aa0-8a2d-08dd6af293ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/WC767FRmADKJqa2zl4oYP/wKRf+/oOlG8V45RtKHjvQTRqCkkb2tAW+YSsU?=
 =?us-ascii?Q?vxy+hGgBlSQCllLcquJ9Vt9PMbx1dx9QW05Bz1BUjuQK3FUnifQiYGY2r4+x?=
 =?us-ascii?Q?SPcZQNlVizOzCUrjMhr1TA6wXTzj7zGx8GziBGFBFhwk+NAfqNqmlnDG+UiT?=
 =?us-ascii?Q?kgGocpWm9yTKju5jqGzyCUHCHxb4HWFm7eRHSN9/KYjKtB8CytLaAmZm6ye/?=
 =?us-ascii?Q?//K48OPuiY6uWX9J1q1PnRD/kzBGGosC37s/mbmXDJ85zNmG6UUSXC3v6YUW?=
 =?us-ascii?Q?jqT/6wGDF2mkAMiJvZodrkFWk4yKi5IU4ajoI8/YCFvQeP8g7bUdDWQMDcpb?=
 =?us-ascii?Q?VMh5G2x5yvVbKfD6zcT6L0aPgz9zifpOkIryPDHg5GT6w0rcJPevfivm15DB?=
 =?us-ascii?Q?qiCDWnl+FPZRh79FomKy0fyxbBM3So6ghSsvzILL74fgCzP/4SF7nswh5a9m?=
 =?us-ascii?Q?zsHo9rn0VUWk5yUWFatFUpUOcAGKeLk8yrcy7XL13Dj7KPEcYzdj9Q8ZBde1?=
 =?us-ascii?Q?hk8bR6Q/PEAtQZ5CNvnIVuwT4X++PT5MSZZ6kG4InQ7mumOMbhLfFrGjcpw5?=
 =?us-ascii?Q?Pl8khCyVM7sp6jFqSdPaGKMHX744w5pZutcfn4qlJEdzrQ88XckFyu2d+k+J?=
 =?us-ascii?Q?MUa07i6O5qID+BAkgFmeHh8kWap+97mvAUwu7j6NXN/YCxwSXB/8KZ+a7uDh?=
 =?us-ascii?Q?GIhJi64UXLS0zO99Fj5xEn/ZWPSua0cpTwddfLgWdwK8bX1yeaao7Rsqv/Wc?=
 =?us-ascii?Q?fw4ZU0H+GKhRiRyzmEIVHSurPyCM+5En0IfTsEOWE4raTCuVyJnU1Bq3xToS?=
 =?us-ascii?Q?SHhOCMgXHZOBzSbf31hBYck1M30PIPm3NFHktlseUvYRvTV8+X4cxepgUqEJ?=
 =?us-ascii?Q?fqOo6ZysGLaIvVXjDRduny4L8hBYQiuMmJ2HeHn0ZT+vUzSlguIZ4IW6g1rP?=
 =?us-ascii?Q?MLtJnWaM8tMp22axoRsIigu7pogKJzR+9Xs04nLBndhPfO/3VTjjVsqR/fxD?=
 =?us-ascii?Q?wyO8Kofh8O6e8RRG1kqOrQRXN3xn+QbpEpmkEl4h0TJdZ/IsmAwFGAQlk2uT?=
 =?us-ascii?Q?fDsKfymZ8G4Nq4J030SgC/erWXOJj2Fm14yMg9BlC4NUXELnphf/7SkQwgCm?=
 =?us-ascii?Q?2VHRW6RzvZ+y833Xk+lQTzwUq8SXCwRvVIzSjcKdbthL4qgE8eq+sKnqK0LD?=
 =?us-ascii?Q?gW4wPBoOVm25BXB/xVqY8px2XthTedqE0j3rSZ7War/tYT3C4Uz0KEJNk0YR?=
 =?us-ascii?Q?s7oOzHvXpuYArksgLkMmR2fNDaY6xOBak9P5rMrWvWha7KyhnFLure3vkYja?=
 =?us-ascii?Q?4V1V4Wa95JBBT8pdRgq5tz2gMl8fGYESS/zyKBrIphpibRetPPGFGKDL0cip?=
 =?us-ascii?Q?pOIgWbCuVmIWA36QyIje5oLuFTpp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f1WNsmCokqg3HwFIo/jr1VmLYRikXNNDZWCDSRgaAx88MX+d1Bvt3bdHTK+n?=
 =?us-ascii?Q?+v4alQ7+Pr+f5scQyIg+6Itj0LH4adZPB+8vEI0cvLYDmVtMrvnXVzzbh+gI?=
 =?us-ascii?Q?Dehf6QRqxV1o2rMBe+t92XtXVmzs77EWxtwsuRApKCKtn+1Axa4DmB1W/odA?=
 =?us-ascii?Q?yvxgNfLTL8QWAWvF+0N3RJvb5hyD0t9D6Zb7mCQEXxcL68kaQI9T0PbEMU3/?=
 =?us-ascii?Q?hU8US8jqkqEcilFH8eYhr4EPj5qR/jQdb/VhaegSS0CdjP/ymTFJrnocePi7?=
 =?us-ascii?Q?5rpXwbcjlKeQk5s9Sxc1QplvC2J1NyeiwUCIC5ZVvtpJLO63clMQ6iwecpQM?=
 =?us-ascii?Q?FFdJRKcC+Xn8+ugGpSltzW4BOtWSK7W6D0VpUQVoB5YK5l4sCUkZaqQ49WWp?=
 =?us-ascii?Q?UuVRa9s7EthW7hAMlWKbkzrqWIJe7UVtGrHQURYvFWgNjvoVq/nC9UW4C6K4?=
 =?us-ascii?Q?3n6ODwoVoY0MOCIe4KSgvavA4PZFvQYbvSyL0ZKxVg5Fq6j3zb6GKcaAzMgH?=
 =?us-ascii?Q?ziL6mgHu94fXtqbwlZgtmM2sdn1yFIKbv6+OdFOOzp7vsb6iEdD4aRZvoaZQ?=
 =?us-ascii?Q?ZxYSbaXJhe8AefOtf5W1OozB3LyQ04Ko8ZAaGANUWrckeRrv17WLCpIemfPr?=
 =?us-ascii?Q?8MpzTI/jZyicJqfQqqp6ls2lIlBqAvYHaA6nIPOI/H1anA9gnTtUItORf5Cf?=
 =?us-ascii?Q?EJ3yy6blfUNm54M6RgrBj42J+xGuQt6a1K45VcbrEq6O06nIJiIkQlYq6Opy?=
 =?us-ascii?Q?Qvy2HMiZiNhcUolrCSwKiFzmltQXKXDBODtglE8i2QkGp1bR+0cnEvt5u6tJ?=
 =?us-ascii?Q?4z/suliNlSmP9cPAcGxtSbiAemdpLSGbBn9LeRVr22bBIxg/ep39KjfHwgwL?=
 =?us-ascii?Q?l//e2iEhAHCgk/jIGwfZZOojxLO/UHx8jWCuXoCeE23XPh7/ZHJKwwAA1s/M?=
 =?us-ascii?Q?dKkycWw1zxrqt30MVOUiruKScl+kehJ8cPc+fySH/OA2v1T+rdhzMjcKtp3X?=
 =?us-ascii?Q?EFsiRaiLd06Av3glYUiuDDn50zBQ+4CCpgv3c02XZtYTyjG/c1R+sUYNdgjc?=
 =?us-ascii?Q?7VfUGXDd6NvPLKUvNBWR5Zjnqs28AisQCrtgzVpytaVojfNR6bBLVvtj5KRI?=
 =?us-ascii?Q?Zj05eofJeloKqKBR9omeh2ieGl7zuAb0ws1ExxFzK8D52mVSevbFI/9ossJi?=
 =?us-ascii?Q?63b+WCzbg4yBI6GcoZKqTF0kwr35Tt/sOWtui9FuJlrxF4Jw8WQl98EsS6lX?=
 =?us-ascii?Q?lbctfGOYZKKbIsks96YlVeiaodNADcIgFKuQVYKnK+Mu5lUoZa0tJUbpuYg/?=
 =?us-ascii?Q?XJ8oZN6DFhMci8Kim/FoCNzDwArCh8c804nP7jIcEJuRdnbj1GQVVIJ/oJVO?=
 =?us-ascii?Q?/vjaIOgnqC2XIObJr1ZO6dUPRGiODOGaOWSMVdxtv6O3GzIOtpP6Eypqecd+?=
 =?us-ascii?Q?yWpZ3WT6pmm60Gewi6VIzowAMF6rasvz+FtFyRo5vK3X2NhloDUd9bEOt+dn?=
 =?us-ascii?Q?/2rTK2GiXlmspHxPZUn6r1luDvvunZnK1z6EA7lCjwHNqjv2WjMmSvnumzuG?=
 =?us-ascii?Q?Wg4wxkjUygFCp5ek9xo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d6bf38-6a35-4aa0-8a2d-08dd6af293ba
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 16:40:25.1421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUoihsQ0x7OpkGHZfTX52ZZcZV0YCISMCLYFnGRJNtZw92gekk6ujJuMof8ASD5p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842

On Mon, Mar 24, 2025 at 09:25:58AM -0700, Nathan Chancellor wrote:

> I bisected a loss of networking on one of my machines to this change as
> commit e009e088d88e ("iommu: Drop sw_msi from iommu_domain") in -next.

Okay wow, I will drop this series from the tree if I don't see a
resolution in a few days. We can try again next cycle, thank you for
testing and bisect!

> At this change, I see:
> 
>   [  +0.000000] Linux version 6.14.0-rc2-00033-ge009e088d88e (nathan@ax162) (aarch64-linux-gcc (GCC) 14.2.0, GNU ld (GNU Binutils) 2.42) #1 SMP PREEMPT_DYNAMIC Mon Mar 24 08:57:49 MST 2025
>   ...
>   [  +0.002355] fsl_mc_bus NXP0008:00: Adding to iommu group 0
>   [  +0.000533] fsl_mc_bus NXP0008:00: MC firmware version: 10.28.1
>   [  +0.002565] fsl_mc_dprc dprc.1: DMA mask not set
>   [  +0.019255] fsl_mc_dprc dprc.1: Adding to iommu group 1
>   [  +0.046820] fsl_mc_dprc dprc.1: Failed to allocate IRQs

I guess it is tripping up going through iommu_dma_prepare_msi()
somehow?

Maybe fsl bus is special and doesn't manage to set
IOMMU_COOKIE_DMA_IOVA for some reason?

I wonder if this is not right:

+               default:
+                       ret = -EOPNOTSUPP;
+                       break;

And it should be just break instead (return 0) which is what was
happening before?

Jason
