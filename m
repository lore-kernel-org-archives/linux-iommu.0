Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793201307;
	b=Byb9V1BWvyt717v0YN2ebpjMOPYEy9qO2Ao+6SDhGQxoBoPFrg4D3Qv2FATSZO1zt4TV
	 6Yt+FfM//uEnco4rlwUmTAYjA03QCkvDwS624HE4WM+3eBGh0EX1mcStp2WQl66NffaN0
	 6MJQV/mk+toHbgjI1qkTlgmDWcs0vXBZFgF/WjpjKenCvWF9vWIQ+yBRiWTt1yKzPWTCd
	 MSUgzT+6DWHDWlII6T6A+OWhL4ovpV8KnzDpLsMHf2OgryQGaDwpgjNYXK4C3cdvsjU+f
	 11Oj5wb2PaMOqjis8IEqGJ3mTZLfLOsi2NA5ef0pnfyguXtYHy6I0BE/RavYQ/weetQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201307;
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
	bh=+57ZPWknnMxCPtw12pLAHjFp/nH2zxmfZ4ngPUekyQk=;
	b=X+PvwWaynNnLqR2Uf+pe4pP6lFezXfWEona6NF32FjHCqrg6Hjf7PS6X/74RBEi5vQYY
	 DNrNs32TtDOLklLufiz3O/F54d0H4VmQDTnWPbzRCtivngbjnYKIRcG/vQT2r5CEEU+vH
	 0QsqkGTALJTSXC4mqqi5HbdqSNBxMc5RKboPvG3amB4vLJQe8l61a6jbdj2xs3knoDohR
	 SiJA48YfaQLn/hFYlSmD81FUFzXSbP4D4/Rb8auR1oRubfTAh/P/GMWCyCymyqWS4x1cJ
	 rLpfXIu8UQqBRyEBurnVeL40hSy5tipeVOLnp9RAiLeBVYyHimO1+6XT7lNdPDYWlmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ftmLYgc7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.35
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013035.outbound.protection.outlook.com [40.107.201.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A2060A261C
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 15:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8A2060A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ftmLYgc7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+mBAT0HceaL+smhW4sMqUjYORM7pZM8JYzvfebxvIOeuU5MkqmNIU6o1G7c5fbtsLmeJWaZxdb/WqPMU0r14BRMHDzQ7LlKzGmaE+3gBlZXevjRETlyhQBmv3LDQLgVBGJbmlmLZ6YtgwDnkqV4SZQhnmbXtmKfQkQAW+bARZjL/zVV/OTay9Mwn5DRlcH8toUcH7wuBWZthJGZuNl4RQ1kEWMtYDodholrzucXUxT5J5vgzBJbFJsEPh7SpafO7VXiuKBI2ozLLZIGZOehAuKEDOgEdD+5hKCgW9eKe55Ik6ZOy2ZrpgjjHZzulkhE7j/dmB40xXdjbf3eysFc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+57ZPWknnMxCPtw12pLAHjFp/nH2zxmfZ4ngPUekyQk=;
 b=vePsWThKaToKi/YCKt9bMLAQIPMIYZnHP1AfFUGAhADg/0l66I0p5ESzhT33uYkD7UpVmoXl6KLNmBOKeEnN9yuKVIMRomkzB4SCPdh+PZGYwvn1jM65uWqo7+J9HnMl0uUVP4StFBK0q2abPbm9ZlwdkQpdN4cVee9hiJYxA4Stoq+ZUtBuX2LJy3iRPhLEbsFpW/7bNllEe37c+4CuqUoq5tfxEMvhnikiYttggcbguO2e5QEB3SovV6fmcH0HwH+qBoWAz31Wgrq4p4jqRdguOw89zWUMX5khfJ37vOi6XyMvS89FpdMexAT3he5GwO4NvWQMY+oPRnXB3yB/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+57ZPWknnMxCPtw12pLAHjFp/nH2zxmfZ4ngPUekyQk=;
 b=ftmLYgc7NnFbiXBsihL2jEXge8ESdZCCL8uJzAFO1PcSZ3CjRL8Dw5t1pfgNVhmU7SrzqQOy+pdx4xWjd6Ws81fW2EH+Xh9c2g+Oo0hrnR+IkBNVogbivqG2jkfUVAv5W1GPwzPNqdk3z9DF0rzmuKiCP3FYHl6sFGIkkG9bYTbmggaCFcq1fG+uzA6tIgCKbbiLTI1LwMNmJnGUeTdroMAwPoalXa39Y831TUMUg6qIRKgoFEHg6YAseG4mYuEjdEqc/98gmV7RbSipf9sjUO5yM7Sn/qiPRa5dVgjimAbJkbH98CGxCq8XM4o4UbcErLkY7BRkfgfhaHzM2bUCVw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SJ2PR12MB9189.namprd12.prod.outlook.com
 (2603:10b6:a03:55b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 15:28:15 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 15:28:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH v5 03/10] iommu/riscv: report iommu capabilities
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
 kvm-riscv@lists.infradead.org, Tomasz Jeznach <tjeznach@rivosinc.com>, 
 Nutty Liu <nutty.liu@hotmail.com>
In-Reply-To: <20261020094106.92722-4-fangyu.yu@linux.alibaba.com>
References: <20261020094106.92722-1-fangyu.yu@linux.alibaba.com>
 <20261020094106.92722-4-fangyu.yu@linux.alibaba.com>
Date: Wed, 28 Oct 2026 12:28:08 -0300
Message-Id: <179320128833.2412245.13619812691469135794.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: CP5P284CA0239.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:22e::18) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 6bc87792-c76d-4139-1340-08df350815f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|1800799024|376014|261021121427099003|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	iyQrGTt76pW6dP5jUSKZCmf1CrBwkLDl2yTUQAfjcF/39cVzYMBwyY6XB50lz0Kyovg0EHtlMIo/ZwxA6HyYVCjFRpOt1l8HWLcGi+0ki1K2Ev/iiJuloFeOthbR+Bt+AQW25zyJ4LJQbgD/13kY/xsBgphYgGnbO6xpLboJ70iJr8tYwiY9EEFjuynq+t/RibozK4vDeoC8q3enR5pw59HkjFw+VmLUf15Nj22+JlK/hY9TJKu6c1Nq7vVJYKHwhC0XHPCdfs+5loW/9dMvMbWBsoPFE4Z9tUpj2Cd9lRaKt8OZWfSlQxeIDWbTRgwPtOOjY32OP1X1p3uI864c4VmlQWO20IZgeC6mhmu0Wociw/CxjMcOKTa1Wt+AgZoVpcahUjOkmpnXTCVOlHHrbHstlSSdHVkx1iUQFnXc9qtfBoT4dUDzxJ/0PeICHtmCiJzhoDhKqA3oD+Fj23gDbmG9/CM1P+bRn6U80pzK3VlBToMkvu/X/JnUHMuQKcLsiLsldOXMPELu7l9VOYr3ugb6SVDT5DkvEERv0xakowCFVU8C+hn4euTxkOw6RhkhW4a8viLPxHEVduHtK/IyGVUUAYAm9wRjkq8DoNnIQw8XQinxTETRKLyDujbU/eiydAlo1BveZR9YsRff4MA7sg+PyXMK/mu8rxkuXWSMrm8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(376014)(261021121427099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2tBUVNhbmNPZ3BUMGpDVXRIaTZKOE1RTEpXTGI2WVhHWUMwVDFWRnV2NUJ2?=
 =?utf-8?B?aEVPdm5tRVN6THo4YStLSWRHUVpaYWxrSUwxMVlWdHg5MldDa0tmMFdCYlpE?=
 =?utf-8?B?enM1SWJtTGg4SUhYbUtnaFdWYmlOOEwzdmUvZDQ4dEZrZ1U4N3ZDRko5amNR?=
 =?utf-8?B?Z29oRERDSGM2M2xDODFhcXhlMWRlYnRPeG94d29TVHhEZ2IxVXAza3F3ZGZR?=
 =?utf-8?B?REZnUjRiUTZTTkgxTnNhT2kwLzhzM1ZxUjJscGhSbE5FQ2FQZjQrUnZMOHc4?=
 =?utf-8?B?NUt5S29OeUZsZGUxeGl0Vzhuc0pqd3UzSVdxQmNIWU9yYlV0bGtaNk9IclRH?=
 =?utf-8?B?L0lZQ1NkM21rdnRGT1FsN2RCYU5oRHZUNkJqWEZvd3dWQUtGdkNmTXJuUTN2?=
 =?utf-8?B?azl1T3J2NzZvMFZ1aS9vVXh6NDRtc09BOXhXM1k1ZWNab0FLQlZSNmJDUkx2?=
 =?utf-8?B?dmoyZlFnaWZpUnBwM2NBeWdMaUZYR2lTaVBYRGlsMnBOeWMvT0JNc1BHdTZH?=
 =?utf-8?B?bG1CcC81TFNnTzBxK1ExdzBMb3NJblJwWVRybUxjL1lOUWEzdkpkM1dMWjVJ?=
 =?utf-8?B?QkQzYVpOTkVTd0NIbUxWMnU4bmROWFJPa0xPZnpoQW01dVVvRStMcWRDTi9I?=
 =?utf-8?B?d0ZjRGxnck1rR3NHOTdQNC9HV1VuL3lkeHIyaDFGa2l5K2JXY0M1T0E2TUp4?=
 =?utf-8?B?K290ZzFWU01GdHFNUVV0d25yR1J1TWxPL2tNc2tVZXVsQmkrcXFVSVJiTEZF?=
 =?utf-8?B?bktJZWJKNDJ0L2tuSEZIdUlCdlMvSG5pdEsvOGE2bHo4SEMzcFl2UVZJaTEx?=
 =?utf-8?B?MkpvNjQ4RTN4cXBVMU5mT3l5cEVuUzVWYlZpRWdxaFhJMkhOQWF1dGdTL2E3?=
 =?utf-8?B?OVQrNi9NaGpvMC9BbVJRdG02QlIwQ0VHQ2U2eHRFRUVHWFVsaE5vcWJrTzJn?=
 =?utf-8?B?dW5STENYZ05DQjF0U3F1bmJqNDkxN0ZOeFExbC9YQkR4dWRmWCtBNlZZZDJD?=
 =?utf-8?B?MlU3YnRhNTd2WFlKRVZjSEVQREV0TTV0NDFzWms4bmZLQURmRDkvakp2WHk2?=
 =?utf-8?B?eG5YdTJ0OCtYQXJzQlRUTStoMFVrdUFnQ0NwWGh2R1U1VjB2TFJ4TzVXekU1?=
 =?utf-8?B?TWhaOTdwa2JheC9MZjJucS9oK0twMy9ESm1rNktydTYzMENQa3VvZjhmTnJp?=
 =?utf-8?B?T1BsdytVU3ExbVpiUDRMdFZpaGVOMm5OY2lTSzNPY0d5TzB6ZnMrTy9UbkFs?=
 =?utf-8?B?Y3ZNU0I5Uzc4Z0k1c3R6Nk5QNVA4Y2l5eUFhdHA3QUJtbTlPaWhGVGRDbEZq?=
 =?utf-8?B?ZWxnMy8xMFNwcWY0WHE2Vm5Xc0pMeHZyZDgvcitnNnVrL0daREY1K2Vrb0xY?=
 =?utf-8?B?TS9Xd01BZ0NSK1BNTGRGd1doZHhWSFROMDFJNUVuVFNINnUrblAvQWc5Q0hI?=
 =?utf-8?B?eHNaa2ZsRHVkdnltbzdINVVvTVNJNERoaTMxdi9EeTlibk1VUitXcjd6Ulht?=
 =?utf-8?B?RTVTQ3FjTzYvcTBaNUZQMThGekVTdmYxZnFZV1VwU1MzMGZ4S2VGMUpoNEVH?=
 =?utf-8?B?NlRocEw4NGZIRUs3bnBhT2NxYlBtYVZaZTZZK2RXWVQwUTlyZ01aV01PNDMr?=
 =?utf-8?B?aUY4OUpGY1ZmcVBNWFpTaFhUakRWZDJCOFpaUEx3MXVRdm11dXFpcytMeEJJ?=
 =?utf-8?B?UVZueWxONHhXdEdTQmJEb0RtSXcxVHU2V0x2ekc4NVVXZktNNk83UUxkSEpR?=
 =?utf-8?B?azZnNzZUcm9DV0VINDFwL2hYaHRGTGRGRTJ2NlRGUEtEWmVwSWIzZ2NRcHQz?=
 =?utf-8?B?b0ZxMW9mZ2lFeU5kRDlMNFBKM0dKWHMrYUw4UzZ3VE56cFdjN1ZBMmZSZlBm?=
 =?utf-8?B?YXBURWE5dTBHME9VYWNsWFN3YStMQlJ5eUNZM1EzTlBIOEpaSTFuOEVueDFo?=
 =?utf-8?B?Z0pyZEhIemt2cG0rZG4rUmRHa2VuaVhqKzNGY1JpZTVoQjBMNGQ0d0ZnOXZ1?=
 =?utf-8?B?cXpaRk9ES3p5djRtbHc0ak5SNUo5WnRHTU9kOVVwVFpjSFlwS05BUjI4S1ZT?=
 =?utf-8?B?RHpvWU9VNU5DakMvS01VbXJHQmdFVlM1dzdYSFBsaXdhSXE0clpMQ1BCSUhR?=
 =?utf-8?B?TC9kVXIxSXJaakYwdFRaVzAyb053L1dqTSsrbldlR3JBZkFGZ0xCQUowbXNn?=
 =?utf-8?B?N2pBcWg1dTBXN3dHOXJBYUJxekJOZVJZampVNlR3UGprZmFrWkNaZ2pzYVJQ?=
 =?utf-8?B?NUNnSnRVR0ZJeDBIR0kra0NKQmNOb1VZMFNmNDVUazJIOEdrRFhLaVllaTlp?=
 =?utf-8?Q?NLYVBTbTQkCNg6VTeN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc87792-c76d-4139-1340-08df350815f5
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 15:28:15.5362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NeXadHdxRhTkROil/A/YJ6YUls8nWAkWkc423QSL9zme+cGJHFkHn97RYZhb+z/0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9189

On Tue, 20 Oct 2026 17:40:59 +0800, fangyu.yu@linux.alibaba.com <fangyu.yu@linux.alibaba.com> wrote:
> Report RISC-V IOMMU capabilities required by VFIO subsystem
> to enable PCIe device assignment.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
