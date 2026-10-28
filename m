Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793201308;
	b=Jz3e4gPFXyfum0Oz1UO9xtErLti1gyVvFoT4uQrU+fx7uh9wiaxzVxcMlTu+FFdbKmlG
	 xhfWMe3sso9rHcc1kBo1MKEJ0XrXnIXoz7TFwUcOkoNBofsbBJpcEjzMwNxaa2L5zmxj5
	 JcfJj7Qsae4XIlLT7Mez1kdq2twDpKYI1k7xLtTR31P2KlEo5tUgh/0eivavxJu/n75hk
	 vDlzsqBD0xEUB4OoinLN3MHsAhioIDd4uSIivzYD6AyWZuyNNnjR3Ng6RXwlhOrg46mNf
	 /07RhzgReBtvStgEm20TYrTCh5NfvN9moIsnZbhlIihgD3AvZE931eWEm6Xibr1L5xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201308;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=uRVLUfrtux9b5N+fTGgvZYj/CiATWiMymTgXk1OYWA4=;
	b=jFJ3uT3PmORIG1RumaD7yGSiiDIcNHppNZj/S/2YXxff+WJR8finanC9UB4J2bNQa7x0
	 p9yCBT4JOmNbrwhSARQwBn8aTOfqeGE41RZSCwdW5lZOP3AzpBk70bx5TAlABHo+smw54
	 ab2xqknsElW+hsyrx7ruerttmPuGnoIPx6NZznUYwDO0ZlmBr4s+Z032W4XtLLxqsZh5N
	 6gAA1jV5HjVSFWFgQ5xozajNc7WFeTtDzsjB1nzkCBcf5xe+Yc5oQQcnnScZZjP1uLeMJ
	 SZTqmAG0owbeqDlD/k5Kh0eLF9uNg8Jo4Vt37OOlGvVHHGLjmYeGnUjrI/pxhA+uxJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RAGPzBd4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.35
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013035.outbound.protection.outlook.com [40.107.201.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707C0606A32D
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 15:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 707C0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RAGPzBd4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzlyNMeLIceVJcKtNOnrfGGRs5CTyxQM6gSlYK4lxKHD5yiddJlA3nD3PMFgLdqEPikgo6BVMx/dUhTi24S2yiWzZ/g/y5SBXr7VUOyf6N8vxhw18Ao50iPaF+rmvIPj11EDY6GKJRJWpTKrLj/LE7xsoPi+cwIl/2n1htPoz/yuDJAUX6kfzd68AfZ3pWGGCp1e17ibX2PWoVFiKbe8rXxyMYdGooAffKheoJjpqq7rfUwUXh7eNj4Uy1O29pBKb35g7OyFwsFMWdanAdVyQXlxqbdTJIpPjnUPzPVbdt80hcTK0fVUVZX9otD3el+gulOSX80/1sOfqw2CbCOycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRVLUfrtux9b5N+fTGgvZYj/CiATWiMymTgXk1OYWA4=;
 b=fQjpfbqMz/UNTLI1T7gLvI23aML18pgERpt62khTv9W/nsClfzCA087JM+piihbJW7SBKdha9bD0VNh91Q/xIaE/MGaTgCtFeJn9tJfGVyKF8iWJiMrpDnGXTPqrpUJSas9S6houdOYBSmBFfnNJs6tsXQ5TYTLRWZPVff+PS6s7Wb6folj010p1HoExLxQvyzYlyrnb0VaGGaGnYdW3jl4pHbrxL9FO+iiTDhFsnMmydcot0Z3J65wV1FgI9enARW57bscrHGftW2Zww0Vo2ekI30oA+KrHqQKSXqUj2QHoQqj09/BuUSyr2INFjYd2Vyaxhx4s897eXDAqgdpsoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRVLUfrtux9b5N+fTGgvZYj/CiATWiMymTgXk1OYWA4=;
 b=RAGPzBd4LsyWEhXOCgMktDEuYEruk4Op5ZPRD3ZY84Gzeh2k6MeY3ipYcI3j12X+jPc24OaaHgmaOINASsC0jxXIOc3m8PusjvZs/oZbir8ixcthjA0J7DVjrb5CeVHeKSgXHybWD3bOZ51oe3NV5zHFvQVxT9nOZcQY9mDyUFyLcnyipISd4gmGVUYlRPvLm1S+rx+zm3bPOM00RPgui0EhTobS92C3A8efpXRk4MMHqvfuQeKA4plSM4iRrhjH6eqz0a+AtsdwCYqVZYKeYUy6qyCpMwRrPyuc3jkuF9j6r6BjbkALfO7NnOT0W6aIp6renpYVmrukCphzh/BWyg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SJ2PR12MB9189.namprd12.prod.outlook.com
 (2603:10b6:a03:55b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 15:28:16 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 15:28:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH v5 04/10] iommu/riscv: use data structure instead
 of individual values
From: Jason Gunthorpe <jgg@nvidia.com>
To: fangyu.yu@linux.alibaba.com
Cc: tomasz.jeznach@linux.dev, joro@8bytes.org, will@kernel.org, 
 robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
 aou@eecs.berkeley.edu, alex@ghiti.fr, baolu.lu@linux.intel.com, 
 jroedel@suse.de, zong.li@sifive.com, andrew.jones@linux.dev, 
 anup@brainfault.org, jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com, 
 atish.patra@linux.dev, skhawaja@google.com, vasant.hegde@amd.com, 
 joerg.roedel@amd.com, tanchi25@mails.ucas.ac.cn, 
 gong.shuai@sanechips.com.cn, guoren@kernel.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 kvm-riscv@lists.infradead.org, Nutty Liu <nutty.liu@hotmail.com>
In-Reply-To: <20261020094106.92722-5-fangyu.yu@linux.alibaba.com>
References: <20261020094106.92722-1-fangyu.yu@linux.alibaba.com>
 <20261020094106.92722-5-fangyu.yu@linux.alibaba.com>
Date: Wed, 28 Oct 2026 12:28:08 -0300
Message-Id: <179320128834.2412245.5700988922771904541.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: CP5P284CA0242.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:22e::15) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SJ2PR12MB9189:EE_
X-MS-Office365-Filtering-Correlation-Id: ae3d5fe7-bd51-4a6c-30f7-08df350815fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|1800799024|376014|10067099003|56012099006|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	j/vnFJESxEmL9yHumqRCYVlXpvyhr9uy364/pjgKXnFjLPkFnllY13VXUEp1aExCAJ+/5fOP8cgXjcmFb1vXNzgrV1D2tET4X4poenNsHtzRIaptomkr0i6q9Sm4zcz13/HWuaZ4++kzPEDfduPjzt/edqu+vZsYYx+IAr7xcg3dZg9Vf9D7IdoJgSI7DN/mVeeoXJHuAwBkt/a44gyeV4yGsPRNLOsJVbXdyk3Eq++OuW76/myZfUcu/QLPX3C3WLYRXfPD2q20Q1cyH4lA6HtwluI95YI/nI+fyL4+I98lnE4hrc6bCNtaOSg0Jtcgsc9l/R1Yo+4GS+cYhkKR1ODoUo+eEH5OQtDQhN0B6r3ZQwd83Y4ZImI0CdRbZ4qT70zfPySbiXuKCpiRBsWtuiIjtn25NWmYDSXSMumc1t8XhRsuhTJSQZzseAe1q2PPvhu/mhWJd6aw7hMP2TeElN3wUB+cRPtJB6zCxdZ9/YwocsNDMDpkR03RGgEmVurnzOIWn3hB9mLNM3qrwakDE2lUgzadGNbyuVercW+uY1tF8NuNVzgnvBBvJd0n1eu5/QDFTFnug3PhoN+cs1ccaEzBJTeyNpYBy7wJyDBgla+iZDxGvhdFqcZOPU12HTxa0fJYP6cmDBEHbtPX581GlHs9P8q5TcCzWdkZJeR3esk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjNZRHdEbnhQNDdRbzFXR2t6V1Q1SE1lVTQ2bWgwd1VNT3lOMUMvQ0FtK3hi?=
 =?utf-8?B?Q2QxRjVFRkMyVDhsRS9rTWl1UHltalhhV2xXaFkySENKSDBnaDRFbXA1Q1hH?=
 =?utf-8?B?bS9xT2I3UDduTU5kRHdJVlZxcWdmTDlPL3B3VWNzdHplL1dmcmVMMy94QzJF?=
 =?utf-8?B?L2x2bDYrL3MwWHA1Zkp0V2c1eC8xQ1hiNE1JODFTNlY5bjNQOWZmWDNkVk5u?=
 =?utf-8?B?dGI3cXBiaGZVTDdRVjlsV3djWUFXL0NJQW1SM1B6b0lmTHp3Q2xDUVFKaG5j?=
 =?utf-8?B?ZFI3SkdaY0pUUURqV1hndXFGVnRtM2xJRU5hZ3lHL21HdWI5dk50cklTdmdE?=
 =?utf-8?B?ejZvNXlvRkl1TUt3QUdjM21yc0VBWTJvbFh2TUwvbHM4NEFITFoyZjAwSHNj?=
 =?utf-8?B?UHVlMlAxeEx6bGZlK1g2amZFSDdwM0ljbFZZZ0NVcTBtVUpXbFRsYTNlNzh2?=
 =?utf-8?B?MXVqeExGc3Z0cWljNWJZQzcwZ3l2Q1hhYTQ4SWl2endzRCtKa3FCMm5SWDlo?=
 =?utf-8?B?bDhSSTg3Q1FzRkJzWjNMOEVtdW9tRmMvQ1haYVYvc1A4bkNQMkF4NlRpQlNr?=
 =?utf-8?B?QlZyNUhtWmdJdGwxdVBtZi95S1J3bWo4VWpxc1l2dlYxVkN1ZG9Dd1I3bjZw?=
 =?utf-8?B?aGtNdXhKakhKY0hRc2lNL2k5Y1pKRCsyWFcvbnVrakMxaklCRWhhYUFwd0s2?=
 =?utf-8?B?UzVpZitiVENRQUpWa3lzaXNoL0xyMTl5OGk0YU5IcHBBa2QzU0JEZ3hCT0g5?=
 =?utf-8?B?Sm9YYTFYbFphQ0pzcXpuOVBiNTFnZzVHeDJwWGJGTnpFdzdnWktHTDZMOFE4?=
 =?utf-8?B?T1FkRWhReVVGL09vRWFPN2dEOWhyZ2pjempnN1lCakd4TjAxdEpSTkM3K2Jm?=
 =?utf-8?B?V1BISXNUQ2YzditJbDBXNktYTFNTd1FzQlNPNDQ3bklYb2tjY3lOWm5jcUw1?=
 =?utf-8?B?aU05L3RzYWwvTWdkSDUreUhoekk2NW9KaDJpVEF1cVJEMGdpVG1DOFlGRFQw?=
 =?utf-8?B?THlvbW5PVVlCdVpsUXpHaEtRVTlVWlB6M3U1NjNMYjQ2ZEwzWWJtRUtOMVFQ?=
 =?utf-8?B?cEk1cmZ5VHVXc0c2VUl1K3JjY0FzUFBVcGRzNFRISTlDdXJBTUV3WGEyV0JB?=
 =?utf-8?B?N0hpSlVya1RCTTI3ZEtjdE1IbGdzZmJNWjZXSldFVUpoZ3dsMVRCQ0NNZ1Jr?=
 =?utf-8?B?YnZQUGxUV3kwdnEwN3BRWk0vYVVub1IvNHpRUEYwTkZPWmUzNjdpWWRoOFNX?=
 =?utf-8?B?TTFjWUVSMEVrZzh5K1NqWlNSYTlCdkhQeDljbG94cGw1RFEvZHpqdlZPSklv?=
 =?utf-8?B?VW1xYk4zam9Bc0xvU25rbkRGSU94dHE3cWNRcndaSjhab2hlSm1Wa1E2YTRE?=
 =?utf-8?B?cUFhNG1IcUZIY2s1bC9hNjdNTFBlUFpiRVUwMnB3TzZSbTVqREcvOHMwa0Iv?=
 =?utf-8?B?alc3UHNGMU4rZktMZ1VsUFIvcTJmOUNWM0NHeFJsbWdMcWxFMFJmZlpNUVBx?=
 =?utf-8?B?L0pNQUJkWGlNVTd1SUVyaWZZNXpDVUhzMlMzVGZsL0ptaWh6VktZaGc5MWVr?=
 =?utf-8?B?U24zVTNzTUhZd0NmdWZNaDJtVm1UVWRzSmZrdDYzaHR6NkNYT3ZrT28ydFUw?=
 =?utf-8?B?Z1V2Rk1VVlFZbEJiL2JOOEFwT3dDQnBvSCtBT2k4SWFPZW1CKzQ2UEZ6N0Qw?=
 =?utf-8?B?c3R5eE5Uek50d2w2d3B6cHZYVS9tYXBMUW83S0Q3TzdtSExoSklKNlpDbFIy?=
 =?utf-8?B?TXdUVklPbktibDhxN2d5MEpmY1NIcDVwWkFyNmVpN0xXZThYUzEzTEJaN0o2?=
 =?utf-8?B?WWwwR2RjUGtoUko3S3dMSGp6Q1BrOHpMSXJaR2ZJZjFjdUlDRmxCN21LNmFu?=
 =?utf-8?B?ZkwxNUU3QmFzb1N1RVZ0MW82cUg4MTlxTm04K3loeUd4TUVYcThrN1ZJTEYr?=
 =?utf-8?B?RXVSZU9YZGQzRDFHUy85Q0J1UzdCVWYvQ0gvR0ZCMFI3VjJ4VzRHKzRHa3d0?=
 =?utf-8?B?dUR0eEwxaXBvUG5Ob0pkaDNPb3ExUEk0SGRoaTAxT3ByMEtreVQ2SVpPNmoz?=
 =?utf-8?B?U2FDS2kvcmtPa1lYV0VhSFphZUtTbXRwaURvbUMyeE5JTmZ5T1J0dFBWTEtm?=
 =?utf-8?B?Nkx3WXk1RVRyWlZnVmhPRVpJMFVndHJLdVNVZ2J6Z2ZBRHl5UG0yZGNtc3Ux?=
 =?utf-8?B?U3hUWCtweEhVL25qY3dZcGwxTEpBdnh2YW4yaGJjdTBHNXF4TFU2ZjZNZ09Y?=
 =?utf-8?B?WUpXdDVsKzNSd2ZJTXZFMmp3NHBGcEpWRnZlcm9ySFpsOE5GdU9xR1FwMWZS?=
 =?utf-8?Q?kmZwc7Zec8f7qMo71o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3d5fe7-bd51-4a6c-30f7-08df350815fb
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 15:28:15.5911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrZ9zmAlV3MIOpo1BX1vGMD2ewGV3PAXdmrPg4frQK8HxRDR+X4yjpHsjv/mt6P4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9189

On Tue, 20 Oct 2026 17:41:00 +0800, fangyu.yu@linux.alibaba.com <fangyu.yu@linux.alibaba.com> wrote:
> The parameter will be increased when we need to set up more
> bit fields in the device context. Use a data structure to
> wrap them up.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
