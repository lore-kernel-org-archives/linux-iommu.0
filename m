Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793849824;
	b=qfyv7bmXjtToLrsUjoe0pR6sYhW3MJU7Wj5xw1Q7g/lLi0C63JOJ8XCyH8Abqgbo5D8U
	 /0rc/iQIATsIB8qVvs7L3q2me4q/haKt7RnmYfLG06UljsfaOV32amYjQERTgyDWMLMAV
	 n3C1GciOq99sur37coQs3QFCQ7GQWG3/W2ieh25DJd6GxZYsXZOCeeNSYCPEbCRVpsIex
	 hnLrfmOssdtWdVbtRSh0VElTxGZ5A7oiMHGt2Iqz+3TV9zI8Y0FSlh5U59v3JTm4bX/X/
	 I62nzlgnR6XVq9cHterV1mqAPssoZd88oegMHp/AExW0oUFW//GJKX64YDSmsJcbUqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793849824;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=DOsgPz31pRiboqLRLufo106aX1jAaEqJBkal3x7NHqM=;
	b=lhnr0hPf5cdaPcheh4POF88VIp/zgctWbubbx1926d/vqbavvdNyU/iEEZ1edUhKkLKM
	 /U5oQnpOyT9e2LDNDNlc0wB9VmEh2xUDL5rtmdPSnwyH5iksYeVCM0vSOaFTtrHQaeCIo
	 luUgi7kSllnCnTC6/9Kgl24nPymP2OP25KmFZKH0pWIu/WF4hMNlp6uYYOf8N7eROgsej
	 d/ez9b4N/8/9fzCdNSgNVbhSBhBa4SgPNrmLdfqjhYm1eU0uNqL1eqwsuVJJ7WgVTybcC
	 X48sFTKunwtBf7roEWEU3l3sy4dMzJZ/78DndWIk0TqPsmF15nd1IuG1DgzHfVtxBxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4jT1xASn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.31
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010031.outbound.protection.outlook.com [40.93.198.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFC2606A31B
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 03:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DFC2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4jT1xASn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuHevvOHXcBfEjOI4MSomIeiA1BXs7j3Cx/XUCsiUoq2v3z8IJ2h1V6jSD/HqRjM+9N+mZFOXMkjzCn1/gOrrgRGQpcrYix+eU0xbL++S7O18naByl2WmDDXnCakwWpj59Tn3/0zSnqKgVBvWMklbsVuDcx8nKW/Va28Jo7uqFYJ5jdd8lTbcJh9KKJfCDwsfPoRIBXvP04bdchXEqO9jb8AL4dfO/HPA7P1y35X1SkrV8q0v//BtabZNtP0umkUuzuC9SrWIvEv/yr3idxrff3Vm4R8baFoUli1vZ2c4Lgvb9iOBlw/szxJHQDZNVxWKwLNYa1ZoZctghquk/cirg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOsgPz31pRiboqLRLufo106aX1jAaEqJBkal3x7NHqM=;
 b=kjSRacfLKMZ50Ot+U3l+UogjySg4D72o6c9CHGd9MiY/c8eUeb4PDCOZX8j4ntbpAVr8+52Hyx5MNBbbzTAPutjLmVztb3ypAQUSIq6puPZSh75VuZZJwyRkG/Lo5xVP9K5z5/DA2D4kSc/t1+MdBH3lVkfGeA6OHF5Rh/GnNPGhr9BNs1TJvH+HzxVYgdH1ncgVN+yipy9soqDSoPP+yHJ+RbDNruovLFTgxqd042O8gLzSR46SmR8yfF2/k1UNkiFGmDefUG++ut+N9j+CfaWd0xEP2yiP0OWYzjStTPdqx0rr0fWTkQOEuCP104HOqgcLiua0iItCmt2iinY0tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOsgPz31pRiboqLRLufo106aX1jAaEqJBkal3x7NHqM=;
 b=4jT1xASnCZPRi3nMF9uqkEwHezKZMAwErQV/FlJxRMFvkE+S+vcBmbjtKQciBFPnLLe/lBzQT8DSpu+mJNBIBR0gSfnum1+xxxo7ZbH+Nb+nqmxTUnTYAAvQcKGslI/8VkIT31V6NGjONc9BK1cBPwGOLrFu9ywCffzZOxYaewQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SA1PR12MB8644.namprd12.prod.outlook.com (2603:10b6:806:384::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 03:36:59 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 03:36:59 +0000
Message-ID: <1640e445-de18-4ace-b84e-75589ff69727@amd.com>
Date: Thu, 5 Nov 2026 09:06:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Fix NULL pointer dereference for GPUs without
 upstream bridge
To: Jean-Christophe Guillain <jean-christophe@guillain.net>, joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <6a3cf464-6c1b-460a-9ee5-5468ded48e0a@amd.com>
 <20261103151607.435642-1-jean-christophe@guillain.net>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261103151607.435642-1-jean-christophe@guillain.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::11) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SA1PR12MB8644:EE_
X-MS-Office365-Filtering-Correlation-Id: cc190383-a734-48f7-9c90-08df3aee0bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|18002099003|22082099003|4143699003|261022105027099003|56012099006|11063799006|261028144727099003|261022075727099003|261026140227099003|261026121527099003|261021135927099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	liL8YWpEFI15+EKyQGwqH0N9Otq2hVYwFnIz8NJU9veLLGGMfNRJbBJYmCTmIhekwclPgkgXgVhagwSHsn3lrbf08Ew+kiSgoCzkNWV+sA56RxGzJvEvQr24DcPdonu8f9jnH/saao3YZdLuT0JpDo5dXvyKZFgehvg3H9u7V+uyeaP95JmqaIRvGGYeu7aRmAob5G54/Kcij0y4MzmUrq6JfA8F9dfibzV6Od50gp+1/IqwZSe0BfxoZhS3M/qaOUACu1AKan33amQo2gzA0NG+jhexttuTi4P4Beir2AHuxwa57jEmj4MC2kmUstH3Xmzw0VjxWPuU9JoMN1PbL9ZybnJrjHjJxZmLorrUzyNKpjODRq3e+A1VD4Y/HLt94wJEs/Wsuox78z1MMaNELfvwUHUOJ1G1bn/pvbM0lFoMxCeAcQ59GGb19szMzlyUaIA2hLTocshTXWu/RMOXm/ad2SAJ1UzX/DMuymVVznjEpvzx7Bk/9RRmj3TeqhkSxTGEnSboetSpk2ABbN6CRHfkt9jPk7W6WmTDo6gUXcGMYW7PS9eqGEy8bVOJUFX8+8W/KiB8uN/7pTnQOnBqcEounAfyXosAvyIS4Q4PM8im1xYQ9X56ZERIFMdbga98htQPKUVmv0PbkGnuenklTXd+/ST4fHtTOYU2xBFx4Uk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(4143699003)(261022105027099003)(56012099006)(11063799006)(261028144727099003)(261022075727099003)(261026140227099003)(261026121527099003)(261021135927099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enE5VkpYaWFTUXBJTEVkVG1sL1g2b05kOXRqRjRGZWh4UEdGaG5VTWdvOGZ0?=
 =?utf-8?B?TVd5dW5WZytEa2MvRWdHc3FsRkt6ZkJwcDQzWjh0TVdwbFlTT0I1STEyMGZj?=
 =?utf-8?B?NER6WEFqWFNvSk5NdlN2aXV2TjFoNWk5MW5OTTFNN0tKN1QzeDVVUGpzZ25m?=
 =?utf-8?B?WnRJWU8wVUp5S0RrczcxMzVyYW1Db2pWcURnajlqc2ZkVzhuVlpscnF0ckxB?=
 =?utf-8?B?VnZvQVB3czNHZjMzanJBbENsbW0zMnEzZUtFdWlyV28vQzdtaU9wc24vWU1P?=
 =?utf-8?B?eU1UZlBwWEZEY0tZcGhqT3ZyWTJKM01OaVRDZmE1VlhtaHlRd0cyMnc2Tysr?=
 =?utf-8?B?NzJ3b1N5K0RFYUdCaUZtMUh1OFZ2RDgxODEyMytoNGZ6VDc0R2xNLytJTlp4?=
 =?utf-8?B?ekh6L1VMaUo0czdDUHR6dXJHRTB3ZGQrN3ZGZzZJdnRETzZ1eGdIWko0YUhY?=
 =?utf-8?B?SiswZ2lYUWk0Z1IvcnlHSE9Cam9tSlBWM1BGWHBXU1JVTzV6Sm9PU1NTdWlu?=
 =?utf-8?B?MW82RGdXWG5kUmlhRk5rQ3JFVEx1dkE2UVp2Nndaa2xrU0RqSFRDZm1yU09o?=
 =?utf-8?B?Vy9NUmJ3eVUvN21sdEFRRjFnWWZzSXFyZCtQSlVVRW1kYWpzRURsci8xU2NY?=
 =?utf-8?B?citpR3E0NTlRNUl0SktFaGlUMFpkNHlodVhiYkc4b1Bwajl2WlJ2d20wZGJV?=
 =?utf-8?B?UFUwaTRuR3NyRUUzMUhDYWoySFFrTWR2aTRrWjlDS0hKNnBqWm50K25ZcGtZ?=
 =?utf-8?B?d3ZhVkgvYktaTDdTN0graktEdjhPb0U2cUpHZmYyRnk1L0FTN0xubWJrSzdi?=
 =?utf-8?B?anJHZ0swZWNZRjIvY1RBUEtpQ1dWTUVPQ1hOblkxc252K1JUUmgybnAvQzdk?=
 =?utf-8?B?YlNzSGlDek92ZGMzcFl1WGUrQlVmL01pS20wNjQ0Qmp6eERxK2hFTmR3KzJR?=
 =?utf-8?B?emwzaW1lby9pRGpRekdPUXA4b1RxdUJIZGFzVmtjc1c1WG5WTDJCYUp4Wi8x?=
 =?utf-8?B?WXlJQXVZN3RDV0tiL08zOVlKV1VCL0d2N0srVVIrUnN5WjBzSFlCNlpaWGJI?=
 =?utf-8?B?b2ZnM1lEMGtNTFFqVDd4ZmtjZXZvL05idi9pR052SmcwTHVkZVBtVnF4ZExn?=
 =?utf-8?B?OHNCZ0xXTDZuVjB3UnBEUWQrbUxlLzJzTVZQRVUyMDZsN1pUbkcyOUNleXVu?=
 =?utf-8?B?SFE3OG90TzRMQm05UHFlS0VZSjlSSlVaTit3ZmVoM0FWN1RYYytMbGt2SEZX?=
 =?utf-8?B?OVp6Y201UWs5UUpEa3pkeEwzNEcxS3A4Tm5rNVA1aFNnVXg1UEo2L2xZc00r?=
 =?utf-8?B?VDJzWWp2MTlJbjJTcW9BZjM5bEljZG9mSi9ZQ2kxU0gyR1NZVHNXa3NCaVIw?=
 =?utf-8?B?WjRjVkRQaVRkSThXUnRaUlhpaDJaQldoWTU4Qi9wZlFnUzg4NTRDNW9sN3BJ?=
 =?utf-8?B?Rm9QSTliczBWSHZPY1ZBZUNZSWhIT3ZaMGR2WVpWUHNDRnAxNkZYYmNBWFZU?=
 =?utf-8?B?L0NHeDc0U2ZZL2pKMVVFMmk5U2FiSGtqcW1hTUZ0SVpiZ1FDRjFBVzBJTmJV?=
 =?utf-8?B?aVY0eWdLR1E4bGdDenFmNDlzKzNLYVdCNFpib0ZYMFkzNzAzalVnUElaTG9p?=
 =?utf-8?B?QTNLeEg3SW9OZ2ZDRTJyUEd1LzY2R2hVQWwvQU41NGR5bGlEbU9xMElOV1lT?=
 =?utf-8?B?MitUUUVOSGpEUkErd0RGVVFOQlFjNzhnbW4yZ0Z4bFQrcmhWTjM1QWNlUEhm?=
 =?utf-8?B?S1RHeSt5ZXI5MlFLSE9oUVYvZW1xMjZrTXFFY1VnMU5HdXJWVWZGL3JkWXpK?=
 =?utf-8?B?QjVDTnRITFozcmxVbDFHM2FMRVNhMEppek9id2dpT1BnNktORm5WeElkaDVF?=
 =?utf-8?B?d3g0dDNrNFZNalRBUTBJZFJlVmZ1ZXpjR2ZxWVpzVG9tWG01ZGk4bWJBZG52?=
 =?utf-8?B?QTFKVEpmL05vM1lpUDFORHBGYWJEdGFzTTVzWGh4Tmk3N0pvMWpLUE04b3NN?=
 =?utf-8?B?c21PR3RzSnI3dHNidEtJNEYvY2J4MGpsRGJHbldvK1VIT25rbEx0V3hNbDFp?=
 =?utf-8?B?Z2FTeTJpQ1pFOFhHdVp6Z3NNcVJUakFBeFhNd3V3dSs3bWptOWpiUDR6ckJD?=
 =?utf-8?B?WkhMUDdRc1ZVRHdYaDMzYkk5VXNoZUY4SlhWV2laZmxoTWVSUDhaMU96TUVO?=
 =?utf-8?B?N3pTb3ZwUUx3QTQ3czE3bTdKN2dkaVhFUXd3QnliL0lzVUdVUktIWGppRVlm?=
 =?utf-8?B?TG8xZ3VzRnduU3ZUbkNMUU8zSFZlV3NmcUNyb2M3Z1dnRVlLN1lFMnB5WU5J?=
 =?utf-8?Q?DtT+iMFCUJZgNN1B8J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc190383-a734-48f7-9c90-08df3aee0bf8
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 03:36:59.0091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAozQEtxKy5RlGTBfEUzqCd6nKdWuJwgrt5J2E3RyIICiZ8vYfv2QGdx5a6LEGePWgkFuazs9nLNhvI1xyqN2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8644



On 11/3/2026 8:46 PM, Jean-Christophe Guillain wrote:
> [You don't often get email from jean-christophe@guillain.net. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> pci_upstream_bridge() can return NULL for devices without an upstream
> bridge. The AMD GPU identity mapping quirk dereferences the returned
> pointer unconditionally, causing a kernel panic during boot.
> 
> Check the pointer before accessing the bridge vendor ID.
> 
> This fixes a boot regression on a Lenovo system with an AMD PRO
> A10-9700E APU. The system now boots with AMD IOMMU enabled.
> 
> Fixes: bf5bdfd1f8d4 ("iommu/amd: Force identity mode for selected GPUs only")
> 
> Signed-off-by: Jean-Christophe Guillain <jean-christophe@guillain.net>

Thanks Jean! Queued for rc.

-Vasant

