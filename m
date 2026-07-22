Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010018.outbound.protection.outlook.com [40.93.198.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15B5385509
	for <iommu@lists.linux.dev>; Wed, 22 Jul 2026 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711897; cv=fail; b=FhbL0vdXnQVwRsaIlRmbhif1FNo6vOi0+0Ffe84so/rEuHXw4Lwbny1U5OJ/Rx3qS0nyMfEPNfgs/rXjrc3GmP0L26Oh0RuKxFyKAggnzz392OZPNKgkDne+TCnA3cM62paBQSJTV554mUzcJeuQrQ+Kb5BCDllVbuP1QuYpEgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711897; c=relaxed/simple;
	bh=tzKpX0XJuJtOO9HEPXILZzjZ5+zqxzBxfABjq2xMEUg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i5Go7C5a6S+xWoTYzKN0IKYxCMIYou+NA0ahaPnd9WQELbL0yQBy94QAdvdvtCeKwEiFbS8XWWZtqFlgyNN/7hbhwLoY8LZ5EOn9vnr/FEG1mOOaKepm/4wzUqWJdkzK9v2K/OmTFg1wc/QlNE+EkhwGIvsdnuC9UIM9l/dTotk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a6NNjWDQ; arc=fail smtp.client-ip=40.93.198.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a6NNjWDQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZm4bMPycPeAEPL887jbeRYB+4mLridaNifeVutDP030f66Z531dvEOnEHOIwfOif8QqU1aaHfHmATHuM0RDh3mFHuDqkcB7E5Kl7/0nrGu08pQ9SYfaSn32G4VRhzJvKqshbC4+REAQjtFmb9KGOReaZRId8Du9p2F0UdZ/y2ZE4S4tqj0rJjH38t5qGxUOBKD9nrNieZi53Kx9XO6i3LHHpGR93tOn3Aeq1jQcF5G+dNUkZJRdpLd+JH1uW1VcrmZi845NcXLcnHJJC5VMBeQDDH7Swu73IebcTq5rlKjTCjnBmnqOhivm7/9YLH1Pdyeq74NG6pIMn8IyHYPKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=getyTihLNPxCpwGeRLn5Tr/nocJFCUyLOXjr2RMPKGs=;
 b=naEDCCkxRCBbhKxCmdNKSCY6BthRcuecDOhms5/+joAHADrvI7pFnMLOpLUhQcQ6xYwLhMBK32vVrGCd/MW1YEqaF4sLFhPz5rpQJPCErdAX38ydJQNtygGxDnb/fQJoZz7DDxRi9nAIx7LM6JLxpR4rvvdju2ac/GAYAPWAxTr5xmm4/H5T42KJRANi1AAVRmu1jKrJZAaMgmtJrGWRC9MsL/je39syqvDBPbVAywonxW2ygY9Jg6IgErSKBSIxjmllqjhlAdYjvqURY9LMvlThAeCM2F+9ozukteIwH6J39fFwC0PkKGontlpfd1EDiF7ByIN/H2IstBEdm02bow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=getyTihLNPxCpwGeRLn5Tr/nocJFCUyLOXjr2RMPKGs=;
 b=a6NNjWDQmJhSgftXfzDzRk8oi9c6dvwDqALIhnkbq1lTR7TYlZaZ7LlBtqlv85TdomwXCHbPWbKPEKFO1MNzcpCgCHMu5ofRj65pUe23VROy3TLTbzc1H5LhjhmifrX0sRuT27RHSRMSe9WqvpWiK/7ynSSjZlsnVwvFDubhIPh7azLygZGnZkVDy7JHHOlMwb28XNcs9u1eZACNtcaWMwKTcRy7ud66dGi+DGY4/0LSTUEF+WS/wenb70OoOF//HfANSttHLi+EHtoiEf//PAt4ad86eOopMSwLg21zU8QQIR8sGSdBKy2/9hCn3HqL5V5xcVvnYZvgWBiR6Q9UUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by DS0PR12MB7557.namprd12.prod.outlook.com (2603:10b6:8:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 09:18:11 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 09:18:11 +0000
Message-ID: <f7cff418-0849-4c58-8d3e-1ce8e1ca1134@nvidia.com>
Date: Wed, 22 Jul 2026 14:48:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] iommu/arm-smmu-v3: Introduce CFGI/TLBI-repeat
 workaround infrastructure
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, robin.murphy@arm.com, joro@8bytes.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-tegra@vger.kernel.org
References: <20260714104202.1664187-1-amhetre@nvidia.com>
 <20260714104202.1664187-3-amhetre@nvidia.com>
 <20260717201841.GC701389@ziepe.ca> <alqbxaKVYFX1BZR5@nvidia.com>
 <20260718164548.GI701389@ziepe.ca> <al01gEzqzCO8KqTO@nvidia.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <al01gEzqzCO8KqTO@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:a03:331::18) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|DS0PR12MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b8f259-3c54-4009-b448-08dee7d2269b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|18002099003|22082099003|3023799007|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	sfmG6rJURq7KpvsLMFtL1N91PRcvd9upuqIsXXi95GH/V7mwr/1c5DvKon+Eq+m/QMm7BZ2ij6y+Y+mnrnc8p3/y5cbwgd+o0uONhDB/z3ycJS2RFZt3EkxAdYsObkoeIXpssTAgqed4vWhxJtyv2azluSNSd9QXOadOXqyQ/SasA1yv1OJ4zOnWMl/iGnlAObdv4QDIBgZqHabto4K8WEh6/E8IkyPHzyt0Mp0yJdvGIFil6uu0+XTOxrKKSuQQJbj6gm+XdhlywSXHAO+lXFz8Ad7ma76MzbqoxJfmjTwj33zKJrvoDlc2xjduFJD9lZSFRnorZAK5EEeAKi6TzplEW3Oxi8I18N42piy1X48cm3pbiKP0Fad/uTb42jrPk7nzRfG/e/Qd8ekiYCi+BBSsrGgO233556xjYc0HQJuaEZvW9q8wUI90rcQ9QSo33Fkb58xMEuZ2Jx98mP8nozeKeQLEVm4QsT94rQdPqbAGuY0QnyqIkzSaVCI7NOjsyRFMTkqmpZ2X/XdvCQNQbeoXdbzdjXlAcxigitK8EHe7UYfBkzYdtZd7PGfAalgNmBarv/hEPehdyPPP1B8DSmbdZMkNqf0W+cL67KU1l9x10o+KVQBn7jQA4/zR0ku4nyiNGC2qpNNio6H9kJYiYg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(18002099003)(22082099003)(3023799007)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDI1SHdkeHVPUWdNZGxnYVpNT2NLdW80K3RnL0hMd3J5QTMyNWN6OXoyWVdV?=
 =?utf-8?B?R2xqcDRTRGdPWlh5UklhM0YvWE8zNTUvZm5FZnNja1B1RXlNN081QkJwdUlY?=
 =?utf-8?B?aDZBYXJReS9aNGNmcjZGVnBJcS9QZGUvOXUwblBKR0pHS3VJR3FRVFgvWW04?=
 =?utf-8?B?eXRtZU92YnZuRkkrMTIzRUM2S2REcFltdUgzM1ZVbWpaSG5RVEZnYUN5VjhZ?=
 =?utf-8?B?a2ZjMUQ3cjZjZDUxUHR2eE90Mlg1amxtODhCZU5LWitNemg1Q2V2MmtTbEww?=
 =?utf-8?B?SHBROXpHS3NNYzk0cklxVFBKSEM4dlFENzJ1V084Uk83Vk5BTW9VYWlqY0NX?=
 =?utf-8?B?ejd5VGRPZ0VNaUZaT0NEeUJpYTA3ZTRVUnA5WVdmY1ZhSGlLM3lQa1JsNkdM?=
 =?utf-8?B?cnVxcDRUMVJWOWxLQTcwK3VnVld2cnlWYXJtdFhKMmJzQlRYN21Gb3ZwR01r?=
 =?utf-8?B?a090ay9WbXlpdXpsblJYWTB5a2RWT3prQkJEd1pXMkhkd2hBUzAvZXhHclFn?=
 =?utf-8?B?NUVlY2hYOWZBWnByNy9QM1IzS1IwQWxFTlh3bGc3VUtLTFlnQkorTW5sTDRE?=
 =?utf-8?B?V0lmVC9VVlA5NWo4TDdkcmk5TkZLRzRyd2JLc3VORUI5UVorUW5nTVU3NjZs?=
 =?utf-8?B?bktYdVJTNnZ0NUhmaFkvMHlLaVhoQ1JZR094TWtIbWZlVWUvYkxERnJ5V0Zw?=
 =?utf-8?B?cWFVZ2VLMzNrWmcwWXMyTXptMW9XdklMUm11Y29NVUZoWXd2WWVIdVo5RlFD?=
 =?utf-8?B?cjh5UFJVWHo2bkZpK0k4Z2ppNGl6UnhweU1GWFpDZ2pDSk16STlHZDQ4N1pU?=
 =?utf-8?B?MVVjUEdIeERZWHRoOWMvbHFqTWMvNzJCdDFFZmxLaURpQ1Z3VHUzTGtoYUY0?=
 =?utf-8?B?OHNQQ3FJQ2pTZVUzU25zeVpYQlNJZUc5ZmVibHdlcGxQRnNIaHl0REI4MGxT?=
 =?utf-8?B?cnhJWDVhQzZQVXBhQWVrZmtNTEM4Q1VVaDkralEyZ0hOd0NleWo3RU5CVVc2?=
 =?utf-8?B?Q295VmM5WFhPYk13dExzQjBMYTN1cGpScVo5QWlnUHo1Zkc5a3hwWEMyckRK?=
 =?utf-8?B?aWNxVGNSWHpGcHhwV2UvQTdrOFhFcGtkQnhmZGkxTmlET01aWTFheUpBTlM1?=
 =?utf-8?B?UE1ZSVN3SEprcjZHOWtxWnhOZVBlYlUySUFaRVorUFdjNHZxczFRZ0lwanVj?=
 =?utf-8?B?TXpWWFNnRndSV1Bmck1saTN0Q2M2bFU4S3lGR0ExTXdRL2szV2YzMVhIV2Nh?=
 =?utf-8?B?ZEtQdlB4NUlpUDBhSGFPWmRBbGNSa1ZSU0JhSWNMM3QwQVk0M2ZBalJLS3dW?=
 =?utf-8?B?NktqaFFhcGRqQ1B2LzkxOVdlVllDN3lNVDc0S1RPakdrc2pzd0NldHovSDBm?=
 =?utf-8?B?cFNGajJoL3NpRVBnbE0rcHFSc1cyTmpqN3JRd0Q2a0MwNjNIOXdIMVhIVlky?=
 =?utf-8?B?OWRXcUY4VUJqblV2MG1MTEFuT1kxdXBraHJHUk83VFFtT2hGL2o2VDhJb2Nu?=
 =?utf-8?B?QkRybkJSVVhwMkgrVzh3UTdhUjdJYzlMWmx6eDAwWXVtcVhUeGVjM2F5NUxW?=
 =?utf-8?B?TVh4akpLV0lna2RZWGxlQmtjQ25MVVJ6R3dwN3pVNCt5M21NNzN6cWZJTkM2?=
 =?utf-8?B?YW55ckQrRStrT3Z4L3NFcTJBNXBVTU9kL1VaM3lYMDlRMUlvZ2x0eUEvWjAw?=
 =?utf-8?B?SWVORi8wQmlQd0JadEExYzBRMWxLUk52NmxLUHB6YWFDcjJ5OUwrYW9mM2hw?=
 =?utf-8?B?dlIvaGhibTNOdTZZR2xTdWRya1BvZnVPZ0lkTktqNlFXdGx1TXB1QjRFTlVx?=
 =?utf-8?B?ckw4MWt4Vkg1eWNaQzMxMU1ZQlRiZTQ1Qmtub2I0aFNXb3BSd2pKZ0Y2VW1q?=
 =?utf-8?B?WUlNRSs5L3V2UGF3ZkRPRytYYnhZS01PYUVlbjJpaEloN1pBUUp4d1RRci8v?=
 =?utf-8?B?QzJ2UVVua0lGQjR3QmNBY3pGbDdPdnpQODh4TCtwMVNSUzlpY0l0MVZHazd1?=
 =?utf-8?B?eUNENGc5Z0xpNEZ3MnB5YVVJTWVVTzdhMEkvK25neW03VGQvdlhyWEJIZWsy?=
 =?utf-8?B?YXNRc3pBVTFTc0Q5SmJ2VHQyTXFzcjJ5OCs4eVBUVzdPNldoQWU3Mll3NWxW?=
 =?utf-8?B?aGp3V2pJK2hIMFRNbmQ1QVlscEkzOUlXRFVWWXBYSEFHZzMzTjVvc1FmUTht?=
 =?utf-8?B?b3JJMG9FUFdCbklmczIwM3R3TXZZaEdLNlNWalVjWWZKdWozRGlRdGVPRnhG?=
 =?utf-8?B?OEN0eGcrYkUvWnkvYkEwYTdPRzVpRXFoS2U4OWg1UXNBTDNFRmc1MFhpL2ZM?=
 =?utf-8?B?Q29sVjlUc1lKYW5JK3hWeXJ4R1d3RytTZHd2Tk1zT2xOeWxBbUxrUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b8f259-3c54-4009-b448-08dee7d2269b
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 09:18:11.1112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ks5N8FpBfMHkN+hL3a5syFIoklH6VAHZc/z55R5bXQWLUtSfWaRfKuhoznN9yNTueKrk9NqXI0+bykTuVIleDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7557



On 7/20/2026 2:07 AM, Nicolin Chen wrote:
> On Sat, Jul 18, 2026 at 01:45:48PM -0300, Jason Gunthorpe wrote:
>> On Fri, Jul 17, 2026 at 02:16:53PM -0700, Nicolin Chen wrote:
>>> Given the use cases on Tegra264, instead of patching the iommufd
>>> path as this patch does, perhaps we should simply spit a WARN in
>>> arm_vsmmu_init():
>> Nope, in this case you need to make the errata discoverable through
>> the viommu info so the VMM can validate the right DT is used, or apply
>> the WAR itself before submitting commands to the kernel.
> OK.
>
>> Some kind of new flag in the viommu struct I guess
> struct iommu_hw_info_arm_smmuv3 has an unused "flags" field:
>
> /**
>   * enum iommu_hw_info_smmuv3_flags - Flags for ARM SMMUv3 hw_info
>   * @IOMMU_HW_INFO_SMMUV3_ERRATA_REPEAT_TLBI_CFGI: If set, user space must issue
>   *                                                TLBI/CFGI+SYNC commands twice
>   *                                                due to a hardware erratum:
>   *                                                <link-to-erratum>
>   */
> enum iommu_hw_info_smmuv3_flags {
> 	IOMMU_HW_INFO_SMMUV3_ERRATA_REPEAT_TLBI_CFGI = 1 << 0,
> };
>
> Thanks
> Nicolin

Ack, I am sending v8 addressing this.

Thanks,
Ashish Mhetre
