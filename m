Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803A3253B51
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731743; cv=fail; b=kNCOYWMmUbE8PzHzKGIDZInX753UgfAtCYo+fGQU/UoEjUgSlWE+z08MZzk0o7k19OYo9uug7//tDoVdQSCD1QTXMzMzEj32sA2MiBr7cIy+5ANiwF0jnL97COX/rkSsLzru8nKsJI1At3tC+hHMFPRstBSJf/3ISn65PGPRq9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731743; c=relaxed/simple;
	bh=AxPGy1+GFjBMdaett32pIw3dVvIRi7IBb10XdZAZx7c=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=GgL6CkrKM6U/Wh0WQ/U6lmELoVkNBsjQ7v7cLypKaZmvTeJ8DET7lDgsGnlIu3fsEOsNbMg27xrelDcPFANo3wWrQkREzLAGNuOqBmig4Y1myRd2Nf+CfA697B0qeu9W60StkZLD6HFRSszuE6b2dG314TnfrllGn8X8/PVGeK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BED4uGIV; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BED4uGIV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QK4i5prhKRa3qucOlEpitMz0R4w07pZzvxDnZY9B5v8BzEu0HTBpKGkiGEdjLXUqFjNk0cCb1CRTieDF6RXEW6/+tRvrjh5AltH8bp5sZTMWOwixWCwh9Xts0xrILqNJHOfF2kAtzUDjh2XDMaGybj6HVJfu3Te+1MtG8YTEVmXZpXoDFcHwIoNyOAL+6DvYrM+uFVt79qmenzma1/oYgmSZkLtyZ9OUcU7xwfDdbFu6xkwsNCf7jHpEbeSYi64kK1gGPEkGzhUd6CM8Z2q6qztlwinwkH7bjW+XumrNPMO3KgnTmu8th/NYKxJdX5rCYAKFixLoldE1wFeBOqmpXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvyeYFfnwkz2TB0BDQjVZYCiif7ityAcF0kagij18YM=;
 b=SYNcUuNIgiOuXE8KykiRaTpKE84m/6bHDCYlDsQ1FSWST48+CW2RxpCyhwILV09m/HK8P96DN00qOEb6UQxmaDpS6uBS4vN7YOyVid7ZA5ECP+dSTbCjRc2abqP9lB6NdYPbaHgqRbal1B1+AmW1PIk33kLnYNJxsD/nuQrk4WytCiFigObVR0HQDv++j3ALlhWa7pKCgx4ggu/0Nw936DedxPbd7RDb16UBnnuRPvLS4En6WfhugAzZGEu1dhiDKxmbpJCKhnkWFsbjF0LMqKQBm1ugrzL1QFKck2C1AleiOqtYthAlnPoI4jD4sZ5FwTHIm3EsoKmNBEtKXxp/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvyeYFfnwkz2TB0BDQjVZYCiif7ityAcF0kagij18YM=;
 b=BED4uGIVua+lJTTS7jPUpdQNogf2d9mmZQelb63cSplin1spWR/t318klYHaymNo9EcJmvmJXNl4qeXnmjWHPv3nz5d4XjNO3PhuaDzTg51i9YBz96/wlCxtTEiuCm2GrIBx9UlE9hgfyjE7ejGMLnNiCwt0D0Rxxj41L8zMz+H4xP3oxcvmjrzlF6YoLH9w9n4vjcLwrJDRKQGYH0JzXVvqWRgHnBMxJXsoO1eei4GtQKRub0TcB2Lj9/RrC7O5nPjzvaBSXSIQ4JJUiIf7juEPZ6PqHkWaPxgyh9TaSdi+SOLE6DKrTpQgwTEvZ6v0N1VklVfy2aIS7yKMMoascg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 08:35:30 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 08:35:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Feb 2025 17:35:26 +0900
Message-Id: <D83XWBJ9U50G.1BIIYOMMFUIAJ@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Andreas Hindborg"
 <a.hindborg@kernel.org>
Cc: <aliceryhl@google.com>, <dakr@kernel.org>, <robin.murphy@arm.com>,
 <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Trevor Gross" <tmgross@umich.edu>, "Valentin
 Obst" <kernel@valentinobst.de>, <linux-kernel@vger.kernel.org>, "Christoph
 Hellwig" <hch@lst.de>, "Marek Szyprowski" <m.szyprowski@samsung.com>,
 <airlied@redhat.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <k3GMnfXzzvUVOgSnuMlEq3eVRyq1qjcf_tDtILRbOwj08EIQpwQ4bGtGhwWufr8lUn-VlHnNjP8FxIA48Jv-Ug==@protonmail.internalid> <20250224115007.2072043-3-abdiel.janulgue@gmail.com> <87seo3z9qr.fsf@kernel.org> <6f154af8-6379-4b1f-9e30-2b99f7f736dd@gmail.com>
In-Reply-To: <6f154af8-6379-4b1f-9e30-2b99f7f736dd@gmail.com>
X-ClientProxiedBy: TYAPR03CA0002.apcprd03.prod.outlook.com
 (2603:1096:404:14::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a36ead-1389-4dbc-c6e5-08dd57d2dba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3lkVXo4a1FaSUNRNE96Q0pMRUhtY0RyVnJtWXZWaG5iRW9HdDZVQ2xJa1cz?=
 =?utf-8?B?YWFHY0R0SDZnYVowNGUrb1RFYkgxanRRV1h1L2txazlCQm8vS3lqSU9qR3No?=
 =?utf-8?B?dWZCTDMvQ2pYZk5CZG1ZQXU0dHZ4clNYRnpybDZPY2I1T2ZvRnVWZjJuQ0xi?=
 =?utf-8?B?RGx6QjlQSjNFamxCNXA4NEIzMi9IamFIbzV0QUZLZ2NYd3ZsNzZMN2IraXR4?=
 =?utf-8?B?VFU4ZE8rUnMxRHhPMHF5cTY1NjhFWUloOGdqdFN2cHpMOEE4UERyTnZCaTU1?=
 =?utf-8?B?OTd0Qlo0WW9MbitkU0g3T3owcE5yZFc3RGFlNFJ2aGpOMlVMZEI2Tm1WRitZ?=
 =?utf-8?B?YXlLdDZOU3BBbWdzTnk5N0huZ2xVRGdNbEFDdVlCdFlKQ1JZVHd4dG1EQ0Ez?=
 =?utf-8?B?SytiNG01RVJ1N2trd3BuZ1dxYVltYVBhNHdDQXVWUHNYbnJySUs1b3R0bkFj?=
 =?utf-8?B?NEZIbEpCRllTelo3Q0lPbjdQakNmbWY1Z01DWEU5bnU3SVZjRGVmMGhWWmVq?=
 =?utf-8?B?ZWJIQjdkRkp3ck0vdmErZDF1cEJVd0pzSXIyNC9FSzV5dHJST1UxYUNkNFlY?=
 =?utf-8?B?R2RMdGR6T1dZeDNMVEpFclpUSkRXMm5LZlhUbGVYTzNhVmhSUXpPNnh1QnRm?=
 =?utf-8?B?dmRxWllJYnkzL3NrcjFvbGRnVWxXSVlOMmxSajZ4ZHlxMElZbWtTdlV3eTlq?=
 =?utf-8?B?bWVhOGhVV0JOeGl2UzYybTBmS2xBeG5KREllQjRvNGxGMjRXTU1rbGhFdS9w?=
 =?utf-8?B?Q2lBOXU4QUY5bnJxNTJ4L0lUbnBkV3BGRDJtdzQwdWh2RmZXSmhOUGZmbHhM?=
 =?utf-8?B?c0craWpQT2w5R0dmbUF3cTlYZ0JhM3FuN1lFU1BiQTVzN1phU2oyanVUT011?=
 =?utf-8?B?UXU1cERuQkFldGFIVThoMUtkR1Ric0dQWndzaEttYnZBQjE2YUhPZWlNb1lT?=
 =?utf-8?B?aHlrbVdzRmpvK05rYlFCVkIzL21pR2JxbC84Tm1EdFU1U0x4VlE4aWJSSmJG?=
 =?utf-8?B?UEUvYWtaYkxDbW93Y29jTFBHdTFsY3lWa2gwdWNwN1MwQmdZM1BFakhUUG1H?=
 =?utf-8?B?QVpyT1J5M0FUSWVGTU9NUVZmMkhOYXhwUis5MHkvVVVEbHVBdDhSY3lHNmta?=
 =?utf-8?B?MDFTSy9QWHAraG1pZERuWitrVHpyd2ZlYXhvVDh6U1VWNHpKU2tTZC9pUmIz?=
 =?utf-8?B?cElkYUhYQ0lwUE8yKzZmUWgrUk1DdTJUNlBCU2wvL21LcmN5YjRycytWcGRY?=
 =?utf-8?B?RDZwM1gxS2hwTTA1QkFHeXhyUUN1aWxFeEYyYkxvWVBOa1dKelpSeElFR3hP?=
 =?utf-8?B?TDdiSFd0WTJtcVlwQTZ1aFBPSzFqaXlFOE9CUmJXd1h1aUNEb2ZmemJTdkxr?=
 =?utf-8?B?WUsydGVKVERjSmZnNGtXR3MydTFLdkpia2VkQWQ2c0lOc2lYMDl4YUdiMGhE?=
 =?utf-8?B?ZFJwV0ZNNk5hVVFvZEIwazY2S1RCbkI1ZXgyTXFpa2kvcDkvYWI4MTl5dXND?=
 =?utf-8?B?Z01xSCtlV0NQRWtVL3pCNHVhWUowd0pYa1dMdEhXT1FnNFhBZ3VFcGxzUkZy?=
 =?utf-8?B?NXVBT2dSN2pLMXlhLzU3ak9BNmJtOXVFQVArYzVUTkRJRDZrSnhpWms1WGQ5?=
 =?utf-8?B?T1JVL3k4Y3ByYVkyUEEwSlF5SUVIWTVQcnhZZVR0QlF2bW9hWDBMVHFTK1Iy?=
 =?utf-8?B?SDYvSERVdkU0NG1lUWN2L1JJOHc5N2I4V1phT1hCcHhzZjJVRGFENzZuZmNX?=
 =?utf-8?B?Y1dDV2k2MWJlbGUvMElMcHBVZElTd1E0M1F0OGVXclp4ZkNpc2N4VWhYM1Uz?=
 =?utf-8?B?UVpWMG1PaUtlSHRMZlJnQXJSOUYyUE4xR1AxbVZZZG9JbEFBQmZ3SEFYZUVi?=
 =?utf-8?Q?T1AiVunor2Fjt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1ZrWFJIcWlUekR5Y2tZOGRIVnZkZ2tlV0dXU0UySWYxcm4raWM4bmJhMUJq?=
 =?utf-8?B?eFoxbUM2dStjaDhFa2VsNjIvTWJRU2U2aWtUOUVqd2dFVWJsVVpTdHBRUXFj?=
 =?utf-8?B?eGxITldldlAxOUFURkV5Z0M5cHE0N3grak0vM1JncThRL1pYY2x0UXJDU2ZY?=
 =?utf-8?B?VHN6RnFsalpXR0prbUJNM2FDU2NhQkVubmxVL2tvaUJ1WG1qK210S1hQekcw?=
 =?utf-8?B?VmQrNXMraEMxZ00vd0JENURDQm5URUQySmpPYUlETGxjcWY1MVhDOE14eGIr?=
 =?utf-8?B?YUVpVmRiZ3ljMmZmVWxEWnh3ejZwSlFPZEkzNUFubjhBSlBmcHBIdmxXNklN?=
 =?utf-8?B?SlN0aXgyN2xHRlFqaG5oZ093bXRJWldpYWE1R2VwRzJqQVA5VXNWR0tYM0Rx?=
 =?utf-8?B?RFl6TkkvRlFDaTlNaHIwVTBLSFpXckN1Z21BSnpzOGdiSW8wRG5hems5RzZU?=
 =?utf-8?B?S1VYKzRsNlZVZ1BLdUt5Q1hSaGJmSTE2T1ZCRDdBa2ZVZlJyOC80NnIwNjdh?=
 =?utf-8?B?bDNDVWpCK1lkL1JYWURZZUJ6dTVFODlhcDJNMWkwaTRsajZIaVh1TW8yRTFN?=
 =?utf-8?B?aWtpY05EU0ZKdnpMeFBWM2lMaXRoNUM4VmczbkdBQzluSWZ5NTF5RnlNeXZq?=
 =?utf-8?B?NGc2SWVwTTVzaWRVY1E5eEFoc3RHVVRtaE1EeVNPaDJaZmhGbXFpSm81Z200?=
 =?utf-8?B?YVhFbG1IVEs2dDhFR3MrbWhhYzEyREFwK3NTcUloaTVhUXUrZm5iYmdzVk9L?=
 =?utf-8?B?UzlqaUNpaHo2NHdYZWgvMkVBSHl3YmlZSWQ4dzNxQ2lIMk9ib1ptc1NYcTEv?=
 =?utf-8?B?OVpKeExSVGE4aHB4RTA0ekhpQ0ZBUWIwL2FjR3hVWFNiaEtTVGdhMXhNT2k0?=
 =?utf-8?B?SUtKZXhIaEEzeHFNVndKd1hYQkFuUUN1L2xEWmxIU2ovMDg3VzlUSUZ0N0Fa?=
 =?utf-8?B?UXQxOGtLMkZsSXNwaW1QV1BTcGJDY3ZHWUQxeWZzeUJ6b25vUk9JdllxQzlH?=
 =?utf-8?B?aUJXSzVMd0YrNXI4UzJnTXRXVTU4NHYwVGxVOWJQQ2J6Y3Yxa0cza1UzVmMx?=
 =?utf-8?B?ZEN2ak82bU9ncjlyUHRma3JtMUt5dm0ycmRWMTcyUi9uZU1Cem5ndjV3cXhl?=
 =?utf-8?B?bityNUhNdzRQTFJVcmdnak8rV3I1VWZzdzZiZFkvc0JHZ01DYlA4TkdwQUor?=
 =?utf-8?B?RzVTQWlqNkZaVHpQLzRNSTFUVzNqS1YxRHd3cDlDaVNsSXd1Q2dZeXplMTV0?=
 =?utf-8?B?NkNwOWoxaHhnVU9EaGExd0QvNGFlajRjeWxFcDdmVlJmWU5nRGpBc3lzMmtV?=
 =?utf-8?B?TmJjMUg4WDlaSkhJTS8rb1psWDUxUmZucElzMkFlSWRkVUVDUTVtK01SQ2li?=
 =?utf-8?B?dHorY0lVQWtkaXJOMlhONnBXU0xCKzZyNEhKTmdxZXNjZGlXQWhZZURRYjVV?=
 =?utf-8?B?ekhPMm5pMkNFUFR1cFBoV2JPNGhTd2poU25Dbk5pMjFSc0ZDeVlVK2FPZkRw?=
 =?utf-8?B?Vml0NUVhTFZHYlBIZG5xeDZaY1B4QlI0cU1Bdi9yZ1BRSTd5YTYyV2Z2MmZr?=
 =?utf-8?B?MzF4dzJJZEZlTGZmUVY5NHVtTlYrQzlhYytSRjlZY0E5azlOY3lZOTZrdURw?=
 =?utf-8?B?V1preVBuU1lXb0psaStnVmc1WnlhbDhwVGNnNHNvVGc5bEZ2UDE4UzRnbHJk?=
 =?utf-8?B?cGZUWElmR2htS3BaMzJlZC9NaFdrc0hsMVpjcXZPWDdmZ0MvVWJ1RzFKeGZX?=
 =?utf-8?B?YS9ZU1RzdFdvN1lqWlJyeTRzcitzaEdsbXpFSDFnVGhESm5hNmYxblNrZXBJ?=
 =?utf-8?B?MHU1bDg4WldtazJ0QkVBcXFFUXlHMU5oRnI2Vm40RlRNRjJVWitRWG9GaS94?=
 =?utf-8?B?SWplMTltNnd2VHo2YVErYS92WitjT2doWWVCbmljeXl4WTZDUnNvWmZ6YnFZ?=
 =?utf-8?B?bE5tc0s1ZlMzd1Fla1g4ZVdLVnp2eEFDZS9wN0lZeVlWZVlJdzZ5bVMzdlJV?=
 =?utf-8?B?Vk5BbSs4UDNIQU5WZG5xalhaZTcrUUFnczRzeXlhR1ZTdUY1OVhNNVB5djNE?=
 =?utf-8?B?Y1VwZDFTOGpBV01UQ3VHcURiZnIzTmcxdHRZYVVnM0xSRnpXY2dXK1k5S3ZE?=
 =?utf-8?B?TmZENHYwU3JwWmdvRWpXWXlDenFHNEFzcCtscFQxSHNXbkQ0VHBTdkxJM0FU?=
 =?utf-8?Q?2zKgKTAfKpHpGbfubu0DOOCF8e8/ulil9FNFfSZvCpLK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a36ead-1389-4dbc-c6e5-08dd57d2dba4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 08:35:29.8686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsEarCcvc4d4iFwic6OG6/2dZSY8QkyA5DMQ4sX7RD3cqvvYLKxCcrXNNaEwJXi4YbIhZQhSRUIiPDud9Eh6MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555

On Tue Feb 25, 2025 at 1:27 AM JST, Abdiel Janulgue wrote:
>
> On 24/02/2025 16:40, Andreas Hindborg wrote:
>> "Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:
>>=20
>> [...]
>>=20
>>> +/// Inform the kernel about the device's DMA addressing capabilities. =
This will set the mask for
>>> +/// both streaming and coherent APIs together.
>>> +pub fn dma_set_mask_and_coherent(dev: &Device, mask: u64) -> i32 {
>>> +    // SAFETY: device pointer is guaranteed as valid by invariant on `=
Device`.
>>> +    unsafe { bindings::dma_set_mask_and_coherent(dev.as_raw(), mask) }
>>> +}
>>> +
>>> +/// Same as `dma_set_mask_and_coherent`, but set the mask only for str=
eaming mappings.
>>> +pub fn dma_set_mask(dev: &Device, mask: u64) -> i32 {
>>> +    // SAFETY: device pointer is guaranteed as valid by invariant on `=
Device`.
>>> +    unsafe { bindings::dma_set_mask(dev.as_raw(), mask) }
>>> +}
>>=20
>> Sorry if it was asked before, I am late to the party. But would it make
>> sense to put these to functions on `Device` and make them take `&self`.
>
> Thanks for checking this. The API is about the dma addressing=20
> capabalities of the device, my thoughts would be to group them with the=20
> rest of the dma API? But either way, I don't have a strong preference.=20
> I'll let others comment.

FWIW I was about to make the same comment as Andreas. The mask is set on
a Device, it should thus be part of its implementation. You can still
keep them with the rest of the DMA API in this file by just adding an
`impl Device` block here - since Device resides in the same crate, it is
allowed.
