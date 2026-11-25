Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795630083;
	b=kenbT/m3R7EIjN1Zc8rLGXFjg605HJUt7DaMvaNpGJSdJbCphDscU0WiIdh+UuEwxuH+
	 xlDBzQ1DiRzL9Tr3S74BfJSj0k8urvFdhks+k+V7Fj/DzvB/o/prDy73AzSzWi5Zpy5ts
	 bvZ9o864jbObv2SNz2MYAls5Mi0AzT9NJj9C5TxYlVtEkNCVPhkvcgL2CPm453AQT2+Tf
	 JVx2/SRtppqYs95fwETWwEQ8hoO4+lRA+DP/6uPLaheGpJI1chDji67HOhGlw32BvEnkG
	 Kc5xvCX59L6qsZY7/un5hJjotp3gQyIYSl/gvt+l2Sv5ZOkNdbJXGSGBGHhb8osMA5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630083;
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
	bh=Y0Zny7+1eJLdeNOO0Y8QPhJnLurT34Iq0Rx00R8mXDg=;
	b=4Pyhb2uum3Iyj5I6YA6jL0KpQGfHJhh0js8JA10qPH/cWRVooYIv9zgV27JO3VY2d9SP
	 5+rc07XH1FTN541ISPPRDejO3U4ineMfzMffRFQPYf+bYxfH628bydl2XQ6Dooy/LLrvL
	 bdor33ECRHWLVVAGOvGt9LjCAhZ3p6Q66ajIH236x72+GmmkeF4fbYRQ7BgHuDTSCKUF9
	 8vWKpmfKgfWMcETfPbKisJTYk1q80IB6alnD9ogf2o+ArDfrVtLMXPI+OcnQiubIp89Wr
	 vndekR6+ZtNd8KCMsVR1D2fDGuCNYDrH5p7hCySbfxMPMWp9AXiAL7HfIyF2sMMQMdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RTMG8Nnh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.29
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012029.outbound.protection.outlook.com [40.93.195.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DD6606A6B1;
	Wed, 25 Nov 2026 18:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96DD6606A6B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RTMG8Nnh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VecAqDp2Wi1BrMr0AsYRbxcmwSWVbLCZECqoTgHHkpy4dP7S+lpRMmgRiNcQoEEAq5b+cSRck93/sUdp1p+X6ZTnv4luQE6mF2OHsBiDfc0qfYWGYzS8819wGGzMGaXmBLqrV/ERzv2Kj0Ye4v/kMCtZwerlM8Pg0ZGDcsDvzDTeyNkhdjBfMYoegJREzTQshEx1rrBdaJJivVEG/Ri86XB47ykNOX6q+57g2KPLfRADfDeXdRnj7OFPIUN5+XYMqM+GOXUKGoERr2V53HudmWfZ6HAmfu1xMqXqOo1DsUTp7+n4kV28CvwA0A7uMXwPHQZFDME86ILiTUWU2HxJYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0Zny7+1eJLdeNOO0Y8QPhJnLurT34Iq0Rx00R8mXDg=;
 b=FUBfn4T9XBAOwumFYXUay+vOVsv3zYc9T30DDXaiPBXcMPEqpcaehj/5EwFd71NZHsXugOZNPy6V4SZUoTRGFKsZgp9Y0goidkpnae0yuZ/70Vgb/J7ccbhqBT4oMsb7fEYXwkrNDeJFuU/pPaGSZlTSsCDigGeVf6UxjwJRwnk3WeK57+c4c9INJ7UUnMgVZK4gLKKJdfIjk5PryApJvxmzCXG/AmMIYZz5oJat7KMTXPQgsuyfh3akDJLkLImq139K7EGj8CdX9uGU790rq6T+fUJp0qisQJUTqETzEEEZMbTbrg2EnCTkrFuPabnkPBjenOZCIMP8/0jFWlgBvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0Zny7+1eJLdeNOO0Y8QPhJnLurT34Iq0Rx00R8mXDg=;
 b=RTMG8Nnh3InTMI3alZAobAkq1yd4TRYmgSYmicAp8Ej9ctyve8BVvOsoAeJQJqW26iRxxt+A3m1dj86uK3ZepcDC9pjeR7/ACHippGUHzHlD5wKCcwTAT9r9/TQ5NnHpNyOkhwE5xOr/4505XRAStn34CJJQ+DBnsctnLUVU1XC2laQYZfhCxuUTLFpo8mRW4KWzIu95BKc1YN7XkepiNuM2qhel1kSFbaKUPdpZxB2k8tsZW0CK/C55c0pL+tCswgPph76NcgxjL9vejsumtqlDP8r7SlZtCeD52Knl1LBxdcAl5mcutxIfz+EtAE3Q11lhRidKCfTEJ5ScTlW0sg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by DS7PR12MB5815.namprd12.prod.outlook.com
 (2603:10b6:8:77::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 18:07:55 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 18:07:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 7/7] iommu/arm-smmu-v3: Probe a guest-level Realm
 VSMMU via RSI commands
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
In-Reply-To: <6872b2febdeda2990731fa6946cb4e00c7899185.1794343501.git.nicolinc@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
 <6872b2febdeda2990731fa6946cb4e00c7899185.1794343501.git.nicolinc@nvidia.com>
Date: Wed, 25 Nov 2026 14:07:45 -0400
Message-Id: <179563006503.253973.1333208494920198413.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::28) To LY0PR12MB325698.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 7477fa2c-321e-4cf4-1973-08df4b1f0387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|261026121527099003|261026140227099003|261022075727099003|261021123027099003|261022105027099003|261028144727099003|11063799006|261102123227099003|56012099006|261021121427099003|4143699003|10067099003|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	KgPuaxEDqrfkd0trCi4bMAW04t/noK/xxOeFGVxTjXK7EgC8RvxsCklO2FV0xCv6okOfb8VtJ6g0QM62PRcK/JcbLInEEiRxzjNKf/QKUtkAtxO6V+nkOk0FRNGS2VJ14DXRG2OQXWoZxl53FkwbptrH9tzi0R77ZgyTifUwJF+WREH7twgJXYCEh49InAy4NyPaCeTNAmWwCMaUKyKnOxvVc3Q5pMy+6uQGh0LMy6hhOytEgKyKLB3MvIBrJ8b5tPtfKvWWohVymkY2Jgl3gTaH/jcPz7TVVv7lBBj6q9nzpM8bdRRRHW/hKvXseSlnVHYeUQ9uRb3wmL7qmJVboNPNi16xIs+e9b+2b6fFDNpY1KKWMmjf3udotVbU5NaTJ+t5hgaIdzZ5sn3fXuDixUyShXie/poKq416jHdvKJILxTriP7pYmEOG9obVrdz8zNsqTfx/86h3LYzsFGnj2S89ecUudlymsgwNT5D8XhNIdorCnxqmGwf50p9+ULJgin9jWncmez5Ou5DGFRAOpT3F9SlOoO+j11sLGkBrTPnvShVTGEn8ipvGobNU6PgSKbIq+JOhQDh4baSKap7UwqfHY0wDMlV2revG1A44OQ4FUc08ChliRgCr/dPYJHVa9BAEcwX626v/8DM6riwYiwfdZqrMQRpcTdTKtIHCLek=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(261026121527099003)(261026140227099003)(261022075727099003)(261021123027099003)(261022105027099003)(261028144727099003)(11063799006)(261102123227099003)(56012099006)(261021121427099003)(4143699003)(10067099003)(18002099003)(22082099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDFXTWJlb0RxWXFMK3FTaGxpSnhlZlFUWjZnTjcxNHVBaDF6d3VLWVF4cC9S?=
 =?utf-8?B?cGlsV0NYbTBsUU9Vdm9nUTBFRlVlVFU2WmJ0TkhLNStNaUVQM0RzRC9OOWl1?=
 =?utf-8?B?aCt5cUxqYW0wWjVqV0gwQ2FzTklNOU1iZ2FNTGR2QTBaaVk5T21uVTN4ZEx5?=
 =?utf-8?B?SnRpaXNkcVZLRk9nM2s3YmdEakhCWWxqbWpoUmhPOG8xYVhkdkJSK2M2SXcw?=
 =?utf-8?B?UjRpeUlON2dZY0drWTdSQjJxaWdBbHE2dy9DNFVRV1VSRTJIN0RZa1ZMVGNF?=
 =?utf-8?B?MEE4MHg0QkUvYnh6VFB1TFQ2WGpGcU9rVVNONXB2ZzdnTDZ6WTlBajJ1UEpO?=
 =?utf-8?B?enVNQUpMWXNLQmllb003K3hFc1lyZGpXQTBzdzVKb3NNYndhKzYwTXhwa1dL?=
 =?utf-8?B?TnNDdURvOW5JU0dWbTFhUTVhd0NXU0VsTVdCdlVHdVlnYlZMNVkzOEF3cFlO?=
 =?utf-8?B?TnJvNXZFaGFkUnozbzFoejBIOWp3bk4xTUNlM1FKRGpnMC9sM1Q4TVJGeWpo?=
 =?utf-8?B?Vkpsbnc3Z240SmlzOEhaOTJ3dXd2M0dOMS9vVTZGWktoTjZjWmNDaEYybnIx?=
 =?utf-8?B?WHQ1RmtLQ0QwSkE3VXhBeEJiaVZUekQ3UHBaU3NycWdRdlJ5WSttaVZlZWRp?=
 =?utf-8?B?U2R6S2plcGNScUdBL1JBT1JOOU96TmdqWk1ZSVZzYndlTEE3MGs5WFZMUEdp?=
 =?utf-8?B?NnZlMHpFMHRISjVsdlFPTkF1M2xDTUVpTmxsNWtQRFFjbk9HY0xmcXY5WkNi?=
 =?utf-8?B?R2I0TE5hNmIvc09qMHhMOXRNSmtMQU5JZFJ3OWg1SzViR0YzSUhCeWpZUWRN?=
 =?utf-8?B?dmp2SDhjcTJjbFBTSm1VOWEvcFFPdzdSREtnTXBnWjJzelNaNnVDVThQS3do?=
 =?utf-8?B?a0xlWVlUbmRBQUcyUFFRcjdxVmVMSDhiTmhXTW9GaTN2bkdrNlAyTUduTHpy?=
 =?utf-8?B?aTNiUDNvK1BXMnoyRzlHY3ZicEx4T2lValovSFdCMWpnV3p2S3BSaUtLdjNH?=
 =?utf-8?B?ZzF2RzlKSkVZbHdhQnhjT05rTDlpU2RyZVVOVVEwRUlXalJwcHVjQkFBejI1?=
 =?utf-8?B?cGJKZU92T1ZYL0tJdnhjSDF2RWNCSXVQWFo0WWszNzRpMGlhODNveHM2TGl1?=
 =?utf-8?B?cGhvQ3VUd1p4RTBPaEFkSGw2ZkhNb1NIdVhpcmZGU1E0WjNRTnE1a1A2NXhk?=
 =?utf-8?B?MGNXKzZVK1ROa2JWeEI2RmY3L2RFME42T09kOFlWbjk2OHNUaG9KVUp1cUVK?=
 =?utf-8?B?Wm1FdkFSZ1hWSjdWZGFOeTFLZnAxeHZ4STQvM1Q4a2lUdTNEb3pVVE8rODZw?=
 =?utf-8?B?ZFFrRVFMZFZXU0YrU01adTMwdG1hQmQ2b2NRTitnM0ovcHNMUGUySkFlNEd4?=
 =?utf-8?B?TVVFblZGN1JUZjYyOTJvUjd4di96bUhVdlczUTZnSXY1RTRDMk1QZUZad2hh?=
 =?utf-8?B?bGQ0K29zSjB5RXR5WnRJb25QWVpIUFUxd0lIditIOGVpOUZHZG5xb3JsQXd5?=
 =?utf-8?B?NlY0eERyVEhoNE1EZ2RHeTMyUW5WYVIwOGxPdkZ1Z2NtSWtiYmIyQkdKZ2tu?=
 =?utf-8?B?MkRKaENEei9NQWZXSUJySTB5VlJhYk1kVTZLd3laWklxdEVLNUtZZzVYZ3Uw?=
 =?utf-8?B?M3VNMkRPcFdQdU9oYmYzMy9VVXg2YXRyRWFZbG0zUSt3TGNjMWNBZERMbzZJ?=
 =?utf-8?B?MllKRHlsTUNrb2FHbGcwdTIxZ1IySG13ZVJkbGRzZDMxK3hHMG9EL0Zwci9m?=
 =?utf-8?B?bXhBS0tMRTY3MUJQWG5mcFpWVXVqTytuUS9GZms2NEFjUitwYWZBWmc2UVlW?=
 =?utf-8?B?b05lRVZlR21tMGRRNTlkUDF6SjNzMlNvYnBycER5OWQwTDc2QkczQkJ1bXhl?=
 =?utf-8?B?MG5xcGc5VThxaUtBaUc2dTNPRFFCM1VrNElCMlpxeGNRZE5KRzN4WmU4NWwv?=
 =?utf-8?B?MEhMYUFnWndlWkhtREhPQkhmbzg4TlFyMGFLQklwUWM0V0c0WEVDRGcwQVJ1?=
 =?utf-8?B?dkVCL0NUSG14aDdpSkpYL1lUeldEekVVRTZ6aWlCblRmQ29HZVZwZnE4aVgr?=
 =?utf-8?B?ZC9NRlY2d0t5Tm0wT3d4UlVVMWJlYUZZQVJpRlZaY0FJZ0FlcGJETklzbTdu?=
 =?utf-8?B?TWdIQkxPeGNBWEQ3UlRiZXN6TjE0akJPZGY4MlJtVUlRK3JncDE1S01lOGV3?=
 =?utf-8?B?R1BxUWtCOERZakpOMFp0RHpKV1RRbE0rSXV0TDl4LzEzVGxMZWt4eFJjQmpB?=
 =?utf-8?B?THgyOWV5bmN6ajFvZFFOUEc2dU90eFppTkxNMDhVRytBTEhTVTJ6bG5pU3k5?=
 =?utf-8?Q?9VtjbA7abBEGEzCJQQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7477fa2c-321e-4cf4-1973-08df4b1f0387
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 18:07:48.6851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hgjozvy1aL+Jp4zkCP8jSUceNv7byqdXoS9LNlFnoAf9SyX2CPQSZKpKLc8qQoC4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815

> In CCA, the ACPI/etc doesn't tell the OS whether the SMMU is a confidential
> T=1 instance or a normal T=0 one. Instead, it has to be learned by issuing
> a trusted RSI. Before the kernel can operate the trusted T=1 IOMMU, it also
> has to validate all the information that it gets from ACPI against the true
> information that it gets from the RSI call, to ensure the ACPI is correct
> and prevent substitution attacks.
> 
> Use RSI_VSMMU_GET_INFO during probe and require the returned register range
> to match firmware. Then use RSI_ARCH_DEV_ACTIVATE before mapping registers.
> 
> Currently the driver doesn't support a T=0 SMMU inside a realm. For example
> it doesn't make the page table allocations into shared memory. If we are in
> a realm reject any SMMU that is not T=1.
> 
> Once the SMMU is activated, its DMA will follow the DEV_FLAG_DMA_CC_PRIVATE
> rules. It must set that flag to ensure its coherent allocations for its own
> structures are allocated from private memory, not the SWIOTLB shared pool.
> 
> Also skip Tegra241 CMDQV implementation in the realm world, since realm has
> the support only for a standard SMMU for now.

Maybe clarify that from a guest perspective there is no way to verify
the information with the RMM in the NVDA200C ACPI device so that MMIO
space cannot be used.

> [ ... 21 lines skipped ... ]
> @@ -5611,8 +5613,11 @@ static int acpi_smmu_iort_probe_model(struct acpi_iort_node *node,
>  		/*
>  		 * Tegra241 implementation stores its SMMU options and impl_dev
>  		 * in DSDT. Thus, go through the ACPI tables unconditionally.
> +		 *
> +		 * Realm doesn't support Tegra CMDQV yet.
>  		 */
> -		acpi_smmu_dsdt_probe_tegra241_cmdqv(node, smmu);
> +		if (!is_realm_world())
> +			acpi_smmu_dsdt_probe_tegra241_cmdqv(node, smmu);

I think I wolud put this check inside
acpi_smmu_dsdt_probe_tegra241_cmdqv() with a comment including the
above note.

>  		break;
>  	}
>  
> @@ -5676,7 +5681,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>  		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
>  
>  	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu")) {
> -		tegra_cmdqv_dt_probe(dev->of_node, smmu);
> +		/* Realm doesn't support Tegra CMDQV yet */
> +		if (!is_realm_world())
> +			tegra_cmdqv_dt_probe(dev->of_node, smmu);
>  		static_branch_enable(&arm_smmu_erratum_repeat_tlbi_cfgi_key);
>  	}

Ditto

> [ ... 55 lines skipped ... ]
> @@ -5814,6 +5868,12 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	}
>  	ioaddr = res->start;
>  
> +	if (is_realm_world()) {

same here

But the logic looks sound otherwise

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

There will be more to do when we get to TDISP devices of course, but
this is good enough to for upstream to boot on a VM offering them
without using them.

-- 
Jason
