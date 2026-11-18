Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795028621;
	b=sjVBf3aFJz6zHU54AHStnjT+kg5baJXrMw3HI3h8dKdE6fQsYmxBIJ1H0FbmO4Qy8TFV
	 6dXRXUJE1lab36llkS2KFYf+HxirXUnFjhjwcB7O9Y6N7KgGJj39I+RiV8owF+s+bVoZ6
	 CO7jMZv9quHgTThaoK9zfos+uTkLHi9CNKfm5gQihYiCb8jiWQoKyQaeymW68P/C30u3n
	 7w09XDFfZHGlS9PioVC/SuHp2LaciZQwfBR50nT/pnojF2bidV2pWkseL8GiSbheiZD4k
	 WCuvTGJklc35nvJAl35e3JcS3jztVHpl0bcDdGT49dL7Kf2NTcgmW4gcCc0S6GREoAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795028621;
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
	bh=UC6hFb+CEvjvUGUmqq+/31uAtKEyJKQNjuPG19DA5wA=;
	b=AK6q3I8PzDR0A7dBBM/uHprPuvWybBhUlsNhcDFMEAITJeVcQ0FP1L9XwOh+oMjlnebc
	 NYOoBGOtM1K98Ac1xVFPPOzuG3q6cNj55Njkni2Q7H+FI62FkYzLWBONCuGc2dAmhCyWO
	 NghhxnDfb5nRszh6JoXgml73Et8A3K4TrEJs0CT5aeehgCokDEzkPCvtc8sTueCZGdWm4
	 ohJcLj+HiR1pF1YggRwBTAE58o9ySHKx7jXJxB7uOzMoHdl8AMu2Y37SgWa/brSDytXq+
	 FkualNls4ZZnfGHSisL0olhgvhICF8YINK9//6Bh9ncBIExrkkjbiuN5elxDgn9ZJuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=F1XM+VEL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.37
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011037.outbound.protection.outlook.com [52.101.57.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF3A606A332
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 19:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AF3A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=F1XM+VEL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcBw4pNEVJMh4Kh73K2CIITr7uclmQVG7NRlb1MCctOu4gr6bHoa6maQaLbfIDBRNSipFhnClQbJoDgac7Z+Z1yVmu+kLUZmcavLlJxq8JaDOQHLcFL7UPkkgM2vHkajcX0Bjxf71FPBVxrbAx+Radkett4w7Fq42zXvim1BybMPPLOVhLsylgkfvnhrxx0Hx/iWALyvV109jIjYIrZeB6xhxhLACMB2zY/8m+0nRgQrqLKMHuZmHsRNaU2ShfDJ/AVxFt3ba7F/X96qbkBdxzmjR6yD7oX0mZImt63pk73CpvaisxcCHmPEn1VDl3uXAugIyFH6LvsWjz87StsPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UC6hFb+CEvjvUGUmqq+/31uAtKEyJKQNjuPG19DA5wA=;
 b=Ftblml4t4K1nZtbNMjwAQQTWhNr2aSTC4NJUvcgNSKtGA2+eHUFg/Z4WTUNN3anbNxpgVerxK16Tu/SNSDuFPvVUxHPfj0BWIzQD+zmuL0aCQORRpxNHkoSKaUupLEGhvval0LQkAapBTCGFyzjd1VLC6FJavvq2YUUB6rIlLwZiAuIwZsmwadcc0Th3c4XOJ3RUChj+LoY6cmE7LP+aoE+ZbwulA30PfVM92z2GJY5ajIZxp7g9by/af91D3X6MB8psraKcNxgRt52B9qVMFNEdHJ4DJE+xIi8gmpy0ODDqqgDhVRxrAlOlyTdBu1h6pO784B+ytLDUlPb0kXdEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC6hFb+CEvjvUGUmqq+/31uAtKEyJKQNjuPG19DA5wA=;
 b=F1XM+VEL4cS7Jmp3/RxVF0Kwo/6IW+l7uZaYljWcaJVg+M3b1HUh1iK+gnzggRCZIoyrIiTXqk59mqzB8zMObgyAQR0pci/XaR702Q+QMRpA0GKGefj9FzYEwBDXQ1DyGXI/HvSzBE7c8asKnCPvGYZqIPmdsN9RUG2yzMxo7kERZPn1NnhJ9CB7Bl5lryurIL5xF9GgLG2HNwKtKCzfXXm4IB/YSfEf1nqQKcjX9s9ina5KQ3u9QZ7qG/ja0JJM5Z3ys0u1r7+5RxJYtEtk6lEsxO0XIx6+psEj+P3XsQgDyqWDU4nRlwlVqWvnDX4MCdBiF+1CRjBQUoqOyZjv9A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CH4PR12MB795688.namprd12.prod.outlook.com
 (2603:10b6:610:518::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:03:36 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 19:03:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] iommufd: only hold references to files
 memfd_pin_folios() can pin
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jiahao Xu <xujiahao@cmss.chinamobile.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
 syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com
In-Reply-To: <20261117093244.652569-1-xujiahao@cmss.chinamobile.com>
References: <20261117093244.652569-1-xujiahao@cmss.chinamobile.com>
Date: Wed, 18 Nov 2026 15:03:33 -0400
Message-Id: <179502861354.3851267.14368035424137707509.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BL1PR13CA0447.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::32) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CH4PR12MB795688:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d820cb0-acc1-4f1b-9f40-08df45a6a618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|261102130727099003|56012099006|11063799006|261026121527099003|261028144727099003|261026140227099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	uOPuv47LnYE51JO4S+/MUndGMjnjz4noPdtwy8Wye3uWue/gWslVv4/BhSzHd50MhLZlEOwebF8SdJwhajMiy0ryOA0yPm1/H1DCuxT1m6L4Y2GNTF7NTE6eA7qqCHCMgbRlphl/4VnPJfk0TomuLP0y4OAZi2dKvey0Wc0h1J5qtl/S6iE5iNxC2Az/GgDJwrQxjKBHP/9dY4HeQE1wyefw+IDGiUX4NSlgAAxnhcJ4bkpOBfMyNGOWTUXvmN0oK+iCAkDTU3tyIZXdhGw+e0d32zAvaNsqoIC3J67fJpUUScIpv+56R0nRi4JANiAGS6oTYo6y1x1wM/etlVf/7OlqmZ+Reyen80znJXhRIJz4TlOLN+ya+0+UjVOOeU/yi+reUQjL0gAtLSmth98x+Zz1daD8Ni0cLMQuLF6KW9KT26OdpDIIcEgVMi1Yyun1VGlU9xWXpKM5h34erRJZzivvEWHuWV1YtyghxKPxHS8Oh9kl1U0bow0shSi2V7s/P4A2FVJ5FbHd3FFg80Fk/lKvr7P8G16LjuaIkeanV+U/+7uL87DSDp9Q/l8xXY6TLBBiWlUcd8pTlSVGZEPTrldVRYeen7jW/4tC25Yd/zWBPNCdOiK64OZDUvZ2czJcIHfJWfbhQ9gsa73SLoCcYDAVoj8tanubrnhFAaIWcP4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(261102130727099003)(56012099006)(11063799006)(261026121527099003)(261028144727099003)(261026140227099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUMvNDYzLy9BQk5nZm9TQlFVTUhBR0JLUkdTQitGODZWOVpvb1RSSklJNTRy?=
 =?utf-8?B?UkQ3L3pNRm9VMGFiZWdmV2Z0L1BjWXJZWDhFSXp4aERob1hBekVJeHlrUjd5?=
 =?utf-8?B?d2t0bTNNZm50RDJtWlcwTXQ3ZlhYb2tXWTRvYVRIMVEwN3RqWkhYVzgyanRt?=
 =?utf-8?B?WS9CZW1qSHIzU1BYdEIyaEJIR2FzOEVXR3ZXd0U4enViL2lCZENPNFNTTVJ6?=
 =?utf-8?B?UHBuMUZEUEhYSThVSFdEMlJ5NXpmRWY3SUw1YWl1ZEluRWQ1UjNYL2xaVkFx?=
 =?utf-8?B?RDJMbUNXMmx5K1R2Q1VLajUzOE56ZlVEUitYdHZiY0I1L1I2cjNNaUhUbEZV?=
 =?utf-8?B?L243bEFFaEVxODRoMmhFOGVDQWFHL0dNdXZ2VWc4aVA0cFg0Y2Nqb1lGbENv?=
 =?utf-8?B?cThoaEx6VldOOGJwODNCemFOcUZzd3EzOHkzN01Zcnk3UCt3TitkQkZJT0hM?=
 =?utf-8?B?MEtObEJJQUliNUFHTU1vUVdleWxJTWJBRmhMK1BIeWw0ak9VSnJ0UzhiSjgv?=
 =?utf-8?B?L0JDSFljTTZodmVrQVRoNEtLYUFHeXg3bVBKU3RyQ1M2eHo2NEZ2djhWZDhi?=
 =?utf-8?B?QWpwbzYvQWxxWmxxNUw4VVExbU1MdVEzRzlpYStnSW9qKzZzcVYxWGFidDFW?=
 =?utf-8?B?dG9aWVNhS3BMdXkrS2w5QVFwM1Jva2ZqVERKTnE2Ry82MnEzc2ZkUTBkb1di?=
 =?utf-8?B?QnF1dzUvbWYzTExOY01ZbjNON0lTU1Z6QTUxTHpUWStVNXlKZDhCOG5DODhF?=
 =?utf-8?B?SnRGWmJ6NUJNY3ZnYnZIOGhPb2xMcFVBaHlSQWRMR204My80MmU0bytQSEl2?=
 =?utf-8?B?Yk1iZU9ZNTJGYVFkQ0R3a1RnVnpKclc3OENBSGtyNnJGVGlGalFpTmJoNDBY?=
 =?utf-8?B?YjBUemVTcm5MbTVhREk5RVQ3UnZlTndzSEs1T2kwbHFyeDlIalFhQitwOW9o?=
 =?utf-8?B?cnJUYzBYVkg4YUEwcnJjMGZkTGw3OG5Md2dYR1R2a2hEL203TzJaaHZTRkRv?=
 =?utf-8?B?NjhEZGtVdEtnaXRtU3VHRnd0VWE1aktOYmdnYWUvMVdxaEhtRXk1Y2RZcTFr?=
 =?utf-8?B?cGRLVklFNXQ4QmVYbS9MdHlyN0M4NDlWRkRBc1ZMcTNITG5Jekd0aVNQM3NX?=
 =?utf-8?B?dC9iSXMrc2Z2c1djbTU5cDZmelR3ajdaTjVyQmdyUGZweFREVFl6ZUphQThy?=
 =?utf-8?B?TXZSOHdrR1E3ejdIaVFMTUJKWldkK21UQ205Vk9zeEVWSk1IMkdHbzJsUFFD?=
 =?utf-8?B?aWV4Mm9TempUUitMU1FhQVo2emI0Wk5yOU8rcEg5MHQvNHY0emllNUYzY2dK?=
 =?utf-8?B?OGN6R1NFcTNOL2M4TEswN2ZUQTA4MytrZXB0QzJDMENjekh0ODlYYmVpaU5n?=
 =?utf-8?B?VmwzOWt3REIvclh1WElLMGtRcjRJM3lRZ3NWb3RyMXJsYXY3UGlzUjZIL1VY?=
 =?utf-8?B?aEtramlUYy94MG92SkZYZ2N1aUZBK0tHRlZxQnNnaFRXRUxaSVdwMDN2dFZQ?=
 =?utf-8?B?NjBHNDdjQm9mdXZzN2Z1VzdCZGY5RkxPcEFpSk5XaFd1ekVmZ1pweDU5SzNY?=
 =?utf-8?B?dzg2QVp6dFd5UEppMkVVK0VZRnJHT25VUEF3UXkwc0ZzbFU1WWk3NEpQbGtV?=
 =?utf-8?B?MWJpRGNPL1ZrZGR6cmlPd21oTU41ZTdJakVRclU5b0UxV09jSittdUpuRmJ6?=
 =?utf-8?B?MGpUU3NwekwxVThXenZxL1M5eW5LczY1M0g4VmcwYmsvWWtVRFBDZlF4TGJq?=
 =?utf-8?B?cm44ZjlmMExFZXl1ak9RZi9hQkUydTJwSmZSdTVBb2xOaFcyMVQ0UFlqaVBI?=
 =?utf-8?B?dEZWVkwraXhoY2VXaVkzN2FVbXl0UDBXSmNFT21TS0tJVlFuUzIxbVQ5UTRQ?=
 =?utf-8?B?QzRFMURRMHhPL1RwdStwZWhNRy9kaUxpY1E4cGhOaUJEZGppQVNwaGNVVmFt?=
 =?utf-8?B?c283SkFWcUZydk1scEdvSy9ITVpTcG9FKy9QbUZaRVYwdllqekkvamF5aStB?=
 =?utf-8?B?cG43cm1WS3hOazJ6RG4za0ErcjJEd3htdWdkK1ZKVHZnU203RVdXODh5TlpL?=
 =?utf-8?B?R29tRjVRdk5WREY5WWkzNXpTVVBZOHB6MGwrZUY5YUJpOTgwYjZjTXRyTldZ?=
 =?utf-8?B?c0xGdHNobzhIUGN1bGkwc1RkdW1Ba2grcStTazd5UmxEYW1UOVZUdUNDcktD?=
 =?utf-8?B?aTlLMExhTWoxS05mM0xCN0JmNjNuczZ0cW9hRTRFUGFqY3FENkhXWnVWb1cv?=
 =?utf-8?B?VlJNbnl2VWtTTHl1MExLVllaU0Y0QzQrNm1GM042MGpVS2srODc1K1dLRS9I?=
 =?utf-8?Q?DzPP/ROKlIeCUZqRx8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d820cb0-acc1-4f1b-9f40-08df45a6a618
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 19:03:36.5537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbHeUrhwBH/stdsyAv1cMo1n1gbJiTIus1DlZuTH8tSLUHUg7xy3A+3WKEIIBqzc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB795688

> [ ... 61 lines skipped ... ]
> @@ -515,6 +517,18 @@ int iopt_map_file_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
>  		if (!file)
>  			return -EBADF;
>  
> +		/*
> +		 * iopt_pages keeps a reference to the file until the mapping is
> +		 * destroyed, so only accept the files memfd_pin_folios() is able
> +		 * to pin.  Any other fd, in particular one that itself owns an
> +		 * iommufd_ctx (iommufd, vfio, ...), would put the file into a
> +		 * reference cycle with this iommufd and never be released.
> +		 */
> +		if (!shmem_file(file) && !is_file_hugepages(file)) {
> +			fput(file);
> +			return -EINVAL;
> +		}
 [Severity: High]
 Does calling shmem_file() here break the build when CONFIG_IOMMUFD=m and
 CONFIG_SHMEM=y?

 shmem_file() is only an inline stub when CONFIG_SHMEM is disabled; when
 CONFIG_SHMEM=y it is defined out-of-line in mm/shmem.c without an
 EXPORT_SYMBOL_GPL(), so linking iommufd.ko fails at modpost with an undefined
 symbol error.

Please send another version fixing this.. I guess we need to export
it, but maybe that says the mm should instead provide a helper along
side the pin helper that is "is file compatible with
memfd_pin_folios()" ?

Two patches and CC the mm list too.

-- 
Jason
