Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28561F63EF
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482288; cv=fail; b=nU0LZGROHTE6E/IKFAUqaGTk6pRyFa81NIX0ZTisZICUvXmDSrRwKR95zEE2a9Kwa8wZHcCAtItL86zVAgOFjs+oh2kSwF2/i7qkj1A+R8mYDboFNeZNLCvm2qws2rgL1ZG33CPbmBcmp1eVp5h7YGiiz3Vip5qL/JbflZD5BL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482288; c=relaxed/simple;
	bh=Km8Sao/4zI4Y413VgZrTMlyMHv3HMxc6oe5z9LEtAnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ga2uVW/OLCb++H6Z6+4lxlsLagUOUdFOVeMkk3FpQjRU0ZH6uL02v2wGaO3n+vvO7eHC2l0/TwELuH3RENbmqcNP37+8rkILknwX0V+2s6XAauSTLZT3XziDxusCgXQcG7epkq2t8vTis5qQlfupUJQP4hMW0lyKum210h6iWpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gjIwaiJB; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gjIwaiJB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=toTEOYunCbrFNsISwhnkFaGdExFekwMTTUhjjnRgijuAbbsa2+JyGndJVGT59wAaPGebRsV/8270+TZbQeRmUauB9RengnvzORGJxqJGHgl0jZihL6ElHdn3I5UuwAQwkFEjeIWS0U07iZIL6QsBcIu1dfvCDfWpjmU/KURitgjCQ1jA/jRuOerZ4PTlQ09HWBwUy1k1HFHoRJvvMAHe8IAiz5qsKKWlJeNsG4UAySGFFXu+AN9pHsdDtXGw1wE4uwrtdIGvnpccCTX2/2mfqWnqak2TW57PZzosKNL2qmLjo54EmvTSYGwWL9AnScB1TUnAgs97rOQm4mjXJhnghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BR5Sfez7c/2cWFY5fiIZ7vbCID8Rh1HGUJdr0HPJEuc=;
 b=WRIzNDeCXIPflJ4G7ofJbKPs9eKN/VuGiRrsyghn8hZtTUOFeEBRhLGELcZeOenstuyaRrRdqV7jANxt5EBSH+q0J+PYgm9ZDjwpFSFVmebFAY5Q6I1yCiywAcIczARZXQQQ/bkTfLkoh5dXoteqYsU7rWJ15VmAstr/pBnY1VtInrXbxm1rcZMOZqAWB4aC2KU8fQD4fQf6SVz83KBu7nIkqZ4zFt6XW+SANm/RAYl8NW48IcKU3nmB/YlaalOiKzqTcSuI3Z28DK41SvX0b99cRTwh6yZeqxNA/+JuJVsRqh5qSOB/cyXbzO4di6LAgVslQ5ukDD0FXa7QriYJ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BR5Sfez7c/2cWFY5fiIZ7vbCID8Rh1HGUJdr0HPJEuc=;
 b=gjIwaiJBLTZ6pattvEOJpY8D8A/cvl3yZtk0p4mhilL58/oZVZIjKAOM6wLwxAC60YSEaDwavhkyVpf4dixUPtKihNOiDQTYhAGT4mTTOiwoJiHpcYRPAKMZ4Lbn5K6GQb4iuWU15aIfyChej/T2lkLliF6xnntT8Thj2OBYm22Pq09csTmX1JlpSwMT+pZO/Df9D6mFQhRyERfzRE2OVui0WX0/z/RGi10Xw7Dc04aRq2JcKtpsFEv2lxqrTB7uuZPUlPAgamnLcBz43Lg1Ks/2c3tLVhDwnVpsFsC/3Afo8H2hrbkxoyxqzUiJpTGLu400Pao4cOx1TEk+bvRtpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Tue, 21 Jan
 2025 17:58:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Tue, 21 Jan 2025
 17:58:02 +0000
Date: Tue, 21 Jan 2025 13:58:01 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc v3] iommufd: Fix struct iommu_hwpt_pgfault init and
 padding
Message-ID: <20250121175801.GW5556@nvidia.com>
References: <20250120195051.2450-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120195051.2450-1-nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:208:d4::49) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: a94ef930-a4c8-475f-34b6-08dd3a452621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n3qywNwC45nfvocAkBiT4ypmvGRU2bVzVMLiiDtFHVOQyaLUmGBgLQlMSt/A?=
 =?us-ascii?Q?Tn9rRjdXt4n64kE7GCX1iL6xMhUBXmQshGBo+aUV0XbwCYKWETW1FXffBAOx?=
 =?us-ascii?Q?0UsmXLkZN/TtiZYGkqNR6L3fyu87bdPukKS5jKr4DR3+swGquRHMBfyIu+t7?=
 =?us-ascii?Q?WKabKeGfsmVbF373oFPPQpn+PXfUb9BMgEFYLZQEMFS/TkyL37q5NuYlr6js?=
 =?us-ascii?Q?FWfC9C2auZetVfWcvdZ6uncFNwmKgVSVjfm6JmLOFsrMQR2xH/g8gcTmpWwk?=
 =?us-ascii?Q?6MEONL1OCDjvxJyAZ6XqaFPjKwx6NXJPvG/Q3lrzKKnfNZnjSjKRTMo4Ozu5?=
 =?us-ascii?Q?rklyAjU49XduMdEp/cY1Z6ywdxr6bwwLR4bauZwCtYqyMDF1dkgECiWSLnUV?=
 =?us-ascii?Q?Boo3q3hj7BNPW/soIW+2ZpKcbx7AlEUTPbWdomlTS+rqvH91p1a5fFIZchY9?=
 =?us-ascii?Q?ZSRy07Sw1kicOj35WtfgkPNL/hPNgMavkWkH2ir+1Cqb7g3EmdHJ/Hr/IXfy?=
 =?us-ascii?Q?IKnqrqEWSFyo4rMzniht2dWsyZ2JCMg1bhorI0Q0CVBqWNBXc+Zx/aad2zED?=
 =?us-ascii?Q?sJKcG8+rKYYG9uzfSEO3mtxCWIkBVSTswE60+TwJudo9AoamMrMPaeXE/Lx5?=
 =?us-ascii?Q?ySaFthEFg7FotOoDmwa/pcoPNmUB1t4/DpgrDOqTN+EnJ1on9GBra4Ik4u7h?=
 =?us-ascii?Q?t8tWT2IKMjmqDJcqC2zkNFPEDNPQT8KYlYCLi816gnm2CbMHbeWkIq0DA4X4?=
 =?us-ascii?Q?Z497ZcxngdY8ahp8u2OS1zfeRpiqndjbKNo7VucEZ7NQ2na0Dsh9XWtMQgAF?=
 =?us-ascii?Q?YzaGCw+GN4ONUOSOSzMbVCrACpxKpEoCPYK7NmySO7zNOCaa98y3MMxv/S9O?=
 =?us-ascii?Q?kFj6oUGseBVes0mMmub30pgiKVL/8D+zyDl4EjeCzFC3THUsZ3mWk72qAMCG?=
 =?us-ascii?Q?al730zX42gargecSLOTdtd8CnRqCfJ2YsFHJzqy0nptt/nBNlHPNp4i2RP8e?=
 =?us-ascii?Q?mAbuW5wY3q9muIBYz/qXYWHEKmPftvR+2A6+/nSyDsgJp2WzfoJKihvaK2TA?=
 =?us-ascii?Q?r9Xfik8ai3s8h67ind7w14RcT/ZvsAmHW5uZFX+WtVR4sxMcJYN4KWSxepqu?=
 =?us-ascii?Q?GXzXsiqiwQm7MJnhsVJ7D4sz16bTymnlAcmn4e5n1t1u5GVjOwhrAoA+bGnx?=
 =?us-ascii?Q?vlz4oaBnpKK6qQttrmGX20Lt/e0jlk+zc/6OxB4N9Q1u4VT1kMajoUtQ1NcN?=
 =?us-ascii?Q?RCZGAo26jsQOBYFSVCgmwMcRR8iSuIkRmm/l+W2GOcwRQiAG9ow8XZUJHRaJ?=
 =?us-ascii?Q?Y9Q+qyxM7xst1PYcmijR5WprOikaO7idqHIKdehwwDWtwB5ca+tzcZNqqvHS?=
 =?us-ascii?Q?1lnWXpjIhWrvrdntU5nPOQ2vd+m+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ld2CcpHj4Z1mzGEXf87SrhmJap1yeQaUO6oDEkSDEFOYMLgEXtf88PInJf2K?=
 =?us-ascii?Q?pDAGNyyUagcft2sVDwSkT0KDGwIh1/vdRKtVQSbPVcUOMM3G64gD2AF7JnrP?=
 =?us-ascii?Q?gxKSR5lYJMDdzED4uFRFqcD19LYPEDGvYI878V+X4PPaeYoIfKvbYPZVVF3H?=
 =?us-ascii?Q?RCpRYUxWhcMSratei28E+uxPBEgNZT9J0iB+9j74vQLU8ancUfANkDd+237w?=
 =?us-ascii?Q?4NI/SlB6CeHK1OfR9OBB2ICas1pZ3zZWxPMnYLoXzeSWl5R77COp3dfQa5H8?=
 =?us-ascii?Q?3hZS/eJyXvY2U+ZsEnal8XOEUYWvaRmp06yjNxoCR9mbzZgs/5WRchVcXeDb?=
 =?us-ascii?Q?ZreKi8DrhiKPlwfAkqv22Q5NvIgjISIAC7hHCCLifYer3hMMZ9hTBJ6Wmd7X?=
 =?us-ascii?Q?tR9SJBpq40LoUjIh1d+0tn+i6/TP+tcIkTCLIMnfjQzlCTkRZuJog2wjGkmH?=
 =?us-ascii?Q?+S8vOgM0PYTADeNlOzGIiU64AgY3p3xrA5ivu9NDN7kupnRs+MbioE+oPw50?=
 =?us-ascii?Q?lsXMVkDA2hx/L0fwxfrXMPJaLzPMQUJhJr2YUctlC5nMn1afSZHOHtyODlr9?=
 =?us-ascii?Q?3NPGCsY4Rejl2uzdtlQc84ySGsg8QHImyuNCq22eAreOZWFfcDi2HOi2yUPo?=
 =?us-ascii?Q?/RaUz9RFRhtMbNiqnH32IJ14b5Uv+hxOivC3fB1dcDOEBRckjCp3TJsLzCJL?=
 =?us-ascii?Q?H+9Sh+GVRNny0/IzYfkUSjsiZw8ChTIEB8mOOeQVVW2JIf/AQfHKezAZ47gD?=
 =?us-ascii?Q?fPxhrj5TdDGNPZcFmYTos2KBeR2SuU93txTlhhmpwCm1pjL1sD9DECwcZVQv?=
 =?us-ascii?Q?1tzoP7vvneZ0GQR6zDuNZjll6p+b/7yyEV7cpnOfkKD6GJDFRM2TtFZig4Pu?=
 =?us-ascii?Q?S8A1bgNPjrwSjA4pmtMSbE7TFfnp4hc6zrQ4jtdaSmagZhM0o8GZyVUjkfl0?=
 =?us-ascii?Q?FN/VfrIrOjoULbTrI+6r2IDPTh8FE4RnRY30BMAUxf01wdULBKzmAYscNnTH?=
 =?us-ascii?Q?qlgGWypyrcmwlXXOCQSmAoQwYbQIFm9llkmOlzgxKmT38aM4qZ3THdJsIX/N?=
 =?us-ascii?Q?wISHyLpQ83vp+b2Ph5K0AhU1xzob6DyWQOeg/95/tPFonPiqWc0Cjc6mkQ89?=
 =?us-ascii?Q?4uTWjau1gM5k8J9udkOKVdczwknlnJynYwbHzW5d2AHfidhpfFEbdZ2QiqEk?=
 =?us-ascii?Q?L7RcXAEEeHBwxud1dfa8u+zyIWoIy873BhNoAeniHfasrSLlWpAMRa4yFyAp?=
 =?us-ascii?Q?OpZ52fee7+BeZ/EGHcpGOw39OvfodAGdUAGwknM8F8zh3FEfXdlTqlkiORg5?=
 =?us-ascii?Q?bA07s1et8Zjq7dDaUwUaNABl7Q5DsF41mZ6owXftafuGALsdqAWa7VJjXWJa?=
 =?us-ascii?Q?3dNTdVklwdsk6Yf4OksyVi2oheWrRflt+lNm/kaACL24Xx8NnW4pWd0lqruD?=
 =?us-ascii?Q?nk9QxoEbZ9Uv/Tde8UfmMxoMJO1DWCkUv+cW6lvo7zJz3/r9E1ST6M44ynZB?=
 =?us-ascii?Q?i/aK9mcwshskW49EsPzu4mf8C+IiVY5RcA6Fpjn+SSSTdGFKuJhutTqINIfA?=
 =?us-ascii?Q?x091GEMYl2pU+fgHurhar2H4wVNoIdM1ZXcOo5Xh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94ef930-a4c8-475f-34b6-08dd3a452621
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 17:58:02.5355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yn9xc+pslIPHaIvvdTV20Ae5d4ZfJMxyXY29nsuNYAwTfTFo4B4qZiDyzN9Br/aF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8770

On Mon, Jan 20, 2025 at 11:50:51AM -0800, Nicolin Chen wrote:
> The iommu_hwpt_pgfault is used to report IO page fault data to userspace,
> but iommufd_fault_fops_read was never zeroing its padding. This leaks the
> content of the kernel stack memory to userspace.

>  drivers/iommu/iommufd/fault.c | 2 +-
>  include/uapi/linux/iommufd.h  | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Applied

Thanks,
Jason
