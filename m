Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795630079;
	b=Tn0dZvLqpWICkVyHhnQft/MXJ7MUDOJ7vrBzux+FGmjtZtfXjvZkmpMQZyjrws2vWXCL
	 xc81ZG/3lWcg5rKok71+gnYEklL5TWsq6KYpKqaDsfj2VSB1R4e0AXsWx2IHpTKIxrX1L
	 OaRnhCZhPBcLe0AxCaCYaBwPijUOKACffgH99xNGeyG9cVtuKEx4iNw80G0TsLlWldVMm
	 zf73QadX+sFIkISEyvknJr88aJQlGI9Hv7p1H0oqCpQXb2LRoFrwU1LrN6fpCGTAdCMDz
	 rdDKh6iItMZL3UXMViWzdh+L2mh1o4Uq5EbfYbhGp9gWSGtshS4jQVPJd2sBRvhZaqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630079;
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
	bh=VWOicQ/uTiE1qgVJdY9zbfjkF1bgmuCg9vefkHhcAhw=;
	b=MC1bklbkw8SHAu4ShzL6owt5HdWZttQoM+1fa5GSxfa4LjO5/7LkDqUPUC2YYz93rEt6
	 HkllfkFj/an47N/YmA3iloZq6sjwapM2j4vQy7D/aoOEWEfFgpd+FZIVGMqU1qydaupkF
	 sWCLuT49MGIIiZGpscwCtYiksvHOB1i7dke3BMZFUfNFOJhHca+Br8eqYIBxU7K/y1smc
	 Pw9YkjdFmFvsCTF34CXgA4f0U2RQHVC4V90XqygTl2s02UzGHTU4VPHMszvbz2oVzd8Xh
	 FtojRLEeQe5njYM3oyiZNwfmnyFU9Ui+byDTGfkbhSu4s6+47hFv4daSLdTHB7hSDYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=a3jdvHxw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.29
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012029.outbound.protection.outlook.com [40.93.195.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AD3606A32A;
	Wed, 25 Nov 2026 18:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74AD3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=a3jdvHxw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYm48p9wsZiGONnf98g4+CZ3zX5sfkTdx8/+me7HKu+FrdCNxOfmTZZyG/VgPFHivEnkRdNJH29Q4qWYSy5y/ebe6earGGHqH0t4frucGyWsdmXgfZPI0YQrijVAPlORCynhJ39uUS/wncCgMI4NJtoKz2F4tIBSRPWm2qSkdojC9Wfniojt6Q5Fglu010+NgDKXUmEuawUK6awgRH0rxJBpCv8OL/+RnhVCptkia0UsxFKfB+MIRt+3wdyPOmzMkXWFuVnBRsAKfGuGBGMWwhrDwuQUSuESJQW2uGMgPGlseiCtwbGtG4xVhxd/3wYzOxxk9XCWNssWcw2vP0PBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWOicQ/uTiE1qgVJdY9zbfjkF1bgmuCg9vefkHhcAhw=;
 b=GuaSRsq3m/1hoiQRyLpDTUBQvpw0K0NX2PFul5qP/ApxPontIU9x+Z5ftIgHNDy7ISGK5yZicJpuhypJv4v+XStwHuE3fX4dNNTx4hv7RVffkvwoXeTOS6X04zZifIAVMwmMpR3iKAiRSCTt+vUUsiEwyfH3qNQSLbCKPAS73Og1zEb1YehtE8XJkYxQSnKWet1v/hCoHXysqDF7ZwQw2zhJsmeWMoN0CY03ErOgvR/1I11eS7mATQLszGWVSdjyQG6eoo03c/5d4RXPr7c60gcXJiLvQCflKKZrqtjEsw3azvv4S77XeBzLGl2up9je/CiaTeP5o7xCpbpA7T2bzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWOicQ/uTiE1qgVJdY9zbfjkF1bgmuCg9vefkHhcAhw=;
 b=a3jdvHxwOAOLOBzNxy5s755kCu2u3Oczi7yMVH/7Nf5LTRkQLMoD0u7A9FXDfO9T6FJww9WbikTBba0AxP9qbzVfScuwRl/KDyvG0hribGq5I0UmA+5iQLHTNImD7pIfB82H1Nk0QU82oI0Ij3IYHCIsTllOusr0F4zTgNqCSRBOEXvqevsf2cdXxZMHOonZ+jmu1mU2lfARTlyGFKzItxB7DtTseaNhEFoO5p+2FteOyLJkDYKckcjhq4QwZfJ0isA7LvB/fcgFw2PccwjRUS7ItRH6blHl6YKvxkUGrqrwQpk0wfyDfL7uJ4THludCfkRSBMXPUaHm+aG/F9QRzA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by DS7PR12MB5815.namprd12.prod.outlook.com
 (2603:10b6:8:77::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 18:07:52 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 18:07:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 2/7] dma-mapping: Let a device declare that it
 reaches private memory
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, joro@8bytes.org, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 driver-core@lists.linux.dev, Sonang Patel <sonangp@nvidia.com>, 
 Ankit Agrawal <ankita@nvidia.com>, shameerali.kolothum.thodi@huawei.com
In-Reply-To: <ffc1666b3d45b11511ac4d720b6aa77cf4fbcb76.1794343501.git.nicolinc@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
 <ffc1666b3d45b11511ac4d720b6aa77cf4fbcb76.1794343501.git.nicolinc@nvidia.com>
Date: Wed, 25 Nov 2026 14:07:45 -0400
Message-Id: <179563006501.253973.16959669935143193655.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0244.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::17) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|DS7PR12MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 23725974-8f37-41ef-4a41-08df4b1f02c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261021135927099003|261028144727099003|11063799006|5023799004|261102123227099003|56012099006|261021121427099003|4143699003|10067099003|18002099003|22082099003|6133799003|261009223027099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	QCNNLiN39JbTPfk0U30narhi9+rGLeROat4suyDFvefFvomv9pdknRM0Jw+NuQ5nM34GfJFC76yss1r9Tm/XcWsg36Pg3I5jWgX4kGMlrQ1atn1lnJEynNIZpFygAR7O9izWN19WCi+ZDQtB22cNG9Aj/qJuvRRoOVmmBByD2jkES/AzIUug2OcnOn12Kz/SQkdZjrehqaBKsNIm7qKNyr6/reIOUoHhqp2VurLNDhRVPgxWOsclqhl89681qczGfKQxDxCuN5MzlGbFbKS7s18JZxxyGrknrf6k/0kurvmYp0/We5hZF6cVtZ15H4GpPXUIzIvpHPm4UxpQr3gTkcVH6ITGFr6vHB+bO7mo6P3dsA/8S4ccCc876vuWtfzlU+kJ/Rhh+uErHrLb/TxBtCcumify9svPfQr+BzV7zdTJrBKEQya9uVYAQOVPBHfRvqD4kR1HRBB5I8ufaomJW8sOVm0ZUMY1vWTsq2Wfz5fo7RoocQJPJIZTDsNqzvDm0xn51j4S4iU8uKmmjbdT7mDLwlq85E6DAW+7J1JLBY/VA6Sgwhbmn8YQwvCGs14dyQlRkNrGrl9/TGMySUG98EUxHYNUgMJSn+Rj8IrNe9RvXBbuvJuCcksLV5CxohqKf6KSfL7nZTXOW2Nr3vpeTxNAJTE6Gvrz9aygstD1qig=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021135927099003)(261028144727099003)(11063799006)(5023799004)(261102123227099003)(56012099006)(261021121427099003)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW40RXJMb1lWTy8zR2c0QTIyalQvYzFiNmJTWFRvMWZ2YVJvbXBHeFZOeEZq?=
 =?utf-8?B?NSs3ZVYrb3JlekpjeHFLOHFzZkVTYXJEb1ZwQ0lxK2hXUjR6b2djK1lSS1Zk?=
 =?utf-8?B?VTZUZXNja3VXcXc4Nm9McG9tSEJaZUNmNnkrbTBMemwvOGFYa2hjMm8yTVJ2?=
 =?utf-8?B?V21NZHdYSlFIbU1oeEdxb0Nvc1l1Nk9jVjBUOWhJRE9oWTA1QjFSbzljMWQy?=
 =?utf-8?B?cnhrUUZURkZJRHhUckl3TC9RWmkyK3NJRUw4bUZWTElvSlI1djBBN0g2Y2FC?=
 =?utf-8?B?eERGcCs2akdxOVJIM05ENGJOblFCUWJXUG02a25JUXNWd054YStEbzBGM21t?=
 =?utf-8?B?N3kwOGZHa21JTXlielpLaU4wanVwdTN5WUlaK2Mxcmp0VEN1Wng1QnpPN0x3?=
 =?utf-8?B?SCtjSFJSaUxBdFZrYkhVM2NlZ1dDOS9HendvOHZhUmJJWUNONFpRZXNlbEk1?=
 =?utf-8?B?MVhxNXpVRTVTY2VYdWd5eWJqdHE5WmdMenRBcHZVYjZIbG9HaHRBZExud3oz?=
 =?utf-8?B?Y3FKb1NlK1k1emdSZ2sySmhRNFBMcjhNYnVJbUtlTUFiNDZ2S2I3eEFvOFNM?=
 =?utf-8?B?RnZYT05Nb0NvaStmQ1VsQnNGNUR5Y3BEL1ppWTIva1pnYTlGNU9uV0NRc0ZS?=
 =?utf-8?B?VytMK29rVGd5a2ZHanlmeUF6TUk2RVNMTkRRemxXTUdUendiM01HRGxaN3BJ?=
 =?utf-8?B?cHVTbzFaUDcwNVk3RjVXdW8xTTlnQTEzZkpVcUx6Y2MrU1ptNHNoS3ZyWlQy?=
 =?utf-8?B?TFkzRWdNbWh6RllPaFlZSzlETkQrY3ZZQkJidHVFalhGMTFqaEJZek90VjQ4?=
 =?utf-8?B?MHBjRHBsN1MvV3l4Z2U2YWNaUGpJNnVxbmJrNS9CU2VWV3czMm9pY1pnQXdo?=
 =?utf-8?B?bmhQMU5MRnU4MU43VmlSaGVEaU9ua09SdGZqMFpPZmhOVGNteFR6Ny8xWGxw?=
 =?utf-8?B?Nk9LWXdxbmZFc3duaTNjYXVZK0pjY2RLS1ZHQWFuOUVhV0crUzB3MEJVamVG?=
 =?utf-8?B?ZS81Y21EYkY5d3ZRSzA3N0UydVFVNFlnUjNiZytPZnpEemcrb0ZSZEpBaUVm?=
 =?utf-8?B?RDA2UFpibW14dVY2cVpQU0lCZytvMVZjZTRDY1ErRHcrVHNvTWRxUi9pNC96?=
 =?utf-8?B?QlJXb2Jmd2dSTFpwVU40clpweFVoYUI2SXhxdzJCUDUrTXpla25FckZ2cHJi?=
 =?utf-8?B?OEI0WG5qamxoMTdoVE9SSHlhaVFuZUduc3A3enZlRWxoM2NEN2ZOVXlaN09h?=
 =?utf-8?B?ZVIyT0VtdlcvQU96ZTFlOXBwOHFTeWFpdVJwOE9xOWNyQ3UzZ2dnYzlxcWs4?=
 =?utf-8?B?ejkxU3FIRGJGNm1KNENmaGNOb2pRSzdQYi95MDNOOThRVElkVnlsL1FEbVRk?=
 =?utf-8?B?S1p1WGhsOWl0dExDTzd5cVVieEJSck5mWnAxMXpFc1daV1o3alZOSzNIZFBq?=
 =?utf-8?B?VkVPYlBHS0ZnODAzWTFBQkh6c25RNE8rMk42T0xqUXBvaXN3REZWOHd3RFFo?=
 =?utf-8?B?SGh4YXdGRk5BUWJXaHFyUkg3bW9Xa0NHd1h5UFprS2VacTVIMEhkUUtxSVZj?=
 =?utf-8?B?R1E5d0lnQk9KYWJ6bHptMmt2U3g4b2Z2NVBuN3hlV21iNEoxN1pGMDE5aXo1?=
 =?utf-8?B?cjhBbllqWnVzaXh5allVb3pmN2JpdGZ5eXdPSnBvNjBKcEFUM1Bldi9xU0gz?=
 =?utf-8?B?anB2VVJudmpoeFg3eEdra2pMOFF6ZHlzK2d4Qi9BS2lJQWRWcXlNT3lNOEJr?=
 =?utf-8?B?MzlkS1RHaHFkVmVaQ2w5WGJsZTlpQVMvODJnZ09MTFV3b1VDbmNhRGFES3gz?=
 =?utf-8?B?VktpeGZVNjJSRU9pbmtFVXk5SHlweEdaYjIxT2tEZzNNcXVTQ0hvUTZLUzM3?=
 =?utf-8?B?dGlrZlRDSXFzN2JoWjBlQjkvNjMwT1ZXUy9LNWt4MnR3VHJUT0daN29WdlB3?=
 =?utf-8?B?VCthUnozZU5BdzJzUnRCaFBmYllTa0dIa051a3ZPb1lldytnMkFkbkFkVGFr?=
 =?utf-8?B?NWtEMzQ0d01Wd0FaS1YwMlBpcmd5L0k4ZFZwVmFQQitKTHg4WlhieDVJRzZG?=
 =?utf-8?B?MTdNUlNpajBTcDI5NVVIeVRISlVHbDZ4WFJINFUyZVZYT3N3cHJvdzNNd282?=
 =?utf-8?B?SHV4ZTk3eVdsR2xOU1F4M1JaVlZ6Q1FJOTBrVnBqQ3ZPUFNKMHdTMkdJUGcv?=
 =?utf-8?B?STVzMDRaZDB0SUNpaG5jSzRZMHd3L0VlS3FmWGovdGZKeDEyRjFiUWhXT1ps?=
 =?utf-8?B?TWgrRklaUzY3QWJEd1IybUlkSHp1ME9pK01iRzZXdi9TUkVsVVEyeTVBdjN3?=
 =?utf-8?Q?3fkRfKmhkkO3F17+p+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23725974-8f37-41ef-4a41-08df4b1f02c5
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 18:07:47.4457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNz/Km5Ncpw9qI93u7JaWvfEbec8xqhG+a88PMMeayOjDyN2YjJK/PeTSSrnAu27
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815

> DMA devices in a confidential guest can access only shared memory, or both
> private and shared memory. Some method outside the DMA API will confirm the
> device is able to access private memory through DMA.
> 
> Add DEV_FLAG_DMA_CC_PRIVATE and dma_set_cc_private(dev, bool).
> 
> The flag must be stable while any DMA mapping exists.

From the thread with Greg lets frame this to what it does:

Inside a confidential VM the HW controls how the DMA translation
works. This boils down to a single bit, either the vIOMMU is ignored
and only a bit of shared/decrypted address space is reachable or the
vIOMMU is used and all address space is reachable. The state of this
HW control varies per device and is an input to the DMA API, just like
all the other DMA parameters, and defines the rules for how the DMA
API builds dma_addr_t.

Only one bit is needed so add a DEV_FLAG_DMA_CC_PRIVATE. The bit only
has meaning inside a CC VM and is to only be consumed by the DMA API.
It reflects the current HW configuration and is true if the HW permits
access to the full address space via DMA'd it, false keep the current
CC VM behavior of the DMA API unchanged.

Like other DMA API parameters this must not change once the DMA API is
used, basically it should not change while a driver is bound.

However, some SOC embedded devices, like the SMMU, are hardwired to be
able to access all memory. In this case the driver itself will have
some way to confirm if the device has full DMA access and can call
dma_set_cc_private() very early, before using the DMA API, to set it
up. This flow is similar to dma_set_mask_and_coherent().

The next patch teaches the DMA API to use this bit when making
decisions within a CC VM.

A future series will teach TDSIP capable PCIe devices to control this
bit as well using the TSM subsystem.

> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
