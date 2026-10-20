Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792463791;
	b=t55FuaCrvSt6vxzPCbR3fKXG79eZyafE1auY1Ek0a4cJyG6YJ7t9eZKFXZvyNAraepOQ
	 TNXCZv8UVFdMePIje8fibspnkvG96S6rm9dBvT6EipRORf/bV+Vc+KEPkTFvZCOtQN36C
	 QEmjsf9W715onjrUt8rduMCjoVC/0a3vDFRSBi3iMlkiWfQ/7b37AfJ2xSShHTvCEmyK8
	 ngDOd2+VzpJWw4QgLNgBWZIfW0SIdmszK1L6nql4KoBYXqGwSiaOrYwyzGZ9eFf2zCNFd
	 SCWCQWVEpqSXCFKm2l+C9fPg93w+Rpyo74/cK1yUV2Gcl/ElcvnBdY3ghHX7myHlzVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792463791;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:Content-Language:From:Cc:In-Reply-To:
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
	bh=taR3WdY/X0IrrsjgQ9gMVQ96JpoUNFHa/Bj2bKCdPDY=;
	b=nx+COo5JPyRN+kBJOx8QT4UiaZ8q96j7hyH1Sc/u9gewAqopqZnY2nsAXq5EOHfj2QUU
	 6Opx0QpkQ0wPBvh6cPLHbOOgyi5IVqQcfVnlhCUiFrKsw1ECuIkFa8Q+HN9qPBoSsDwfN
	 Y0sz3+sAlU4e+Ze5G21FAEE4rJ6lGj4ZHFinPVXddMDt5ksgdeJKlhleAaTPzjNgvFHB5
	 KHpYIiHcybI0dbcPGtJ+Icze8sBIa0ByChTt8Xj30X/rJAV+JBPnBufn+D3GFTXppYt+r
	 Cl3T7d4OqZQRyeCzCvMtyTo3f1KEbwsvEM4UBiDYSSjfbuBehi7i0X3J2Pg9cTnz2qg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Z8WEcnCQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.10
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559C8606A31B
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 02:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 559C8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Z8WEcnCQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekeRKQfwqlrvbBDxDdP/MZHgJaBs3tJKBbWwDpBfdltqSK0m5bkqhHUQJeHJN1H1CtirGxLc62HaZWD37puccNw384xhjK72Sl1WtuudqU1FQN52ho0Muh67AvM74Cs8IoZ/VOJEyQrNSehWWYlM8TLTAi+DCg3p7xdYQhQVkC2wMKV950PhvH5D3AY57bAiw6PgTwNoixui5lLg3QdIEeAMH6CGVH3kc5TTA/09OSq86FefmgP0QHpobu1KsLs78jckv1D9HwcxdNgdbDy8Rif0z8BxdPv1UGZiT4bZG2AlJyg8H1rJQnN0V49v1+QpS4GWABqCqU1W7SPX7PzygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taR3WdY/X0IrrsjgQ9gMVQ96JpoUNFHa/Bj2bKCdPDY=;
 b=KD8lJI4aBTs3K64GJtKxSpbZRJQNMgWw1syMIUKqRVHRelyGWzUyDCrPCY72Ypq0RhJiO74rulK+4v86i/iu0oeMjKCMYIaV7Kd1acGcCXh3vJxxArk9+agQQ+wp8g0IQULwn6KfE5EtfhpOrtKvtCUM9Fn0+CObP5EB7FBa8+qJyeoz7w8CvJAVcQf3s4PkxIBtn9+FXAePQ0JQ9N48XlWwVK0L2UeVrxbrAeo/hPpSpVzxuXneifmB07kkwplTJKRYd5XNakCQufKtQ4Lb/xkIdiQ3JhHgmGTIjfp/o9vwm1D+oDSSXCx6Zo7oSa5VDz1Be3U3HpOzqtfu3frI5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taR3WdY/X0IrrsjgQ9gMVQ96JpoUNFHa/Bj2bKCdPDY=;
 b=Z8WEcnCQ8QyjNGSVBfT/36BtwOWdNmue+0pDLqs6L6CkQr8PFlw67MyHAyF9WDQpySwSpjmC/+3vJ8RxPvGImBIdaiPcbULgFS6hw4bbqg0ue8Px2boXNjprxrbFo888LNAwPw8rVQv663WXvTTOrDKw1oQfk4M/1xRiVWnbBQE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from EAYPR12MB999181.namprd12.prod.outlook.com
 (2603:10b6:303:2be::15) by DS2PR12MB432622.namprd12.prod.outlook.com
 (2603:10b6:8:70b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Tue, 20 Oct
 2026 02:36:25 +0000
Received: from EAYPR12MB999181.namprd12.prod.outlook.com
 ([fe80::34f9:80b7:5167:9d43]) by EAYPR12MB999181.namprd12.prod.outlook.com
 ([fe80::34f9:80b7:5167:9d43%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 02:36:25 +0000
Message-ID: <54db5f22-ba63-433d-b98d-d6dc6b17b27f@amd.com>
Date: Tue, 20 Oct 2026 09:36:19 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Restore three-stage vector cleanup for IR
 affinity migration
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, joro@8bytes.org,
 vasant.hegde@amd.com, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261015042347.1823813-1-guanghuifeng@linux.alibaba.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: "Shu, Ming" <Ming.Shu@amd.com>, "Shukla, Santosh" <Santosh.Shukla@amd.com>
In-Reply-To: <20261015042347.1823813-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To EAYPR12MB999181.namprd12.prod.outlook.com
 (2603:10b6:303:2be::15)
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
X-MS-TrafficTypeDiagnostic: EAYPR12MB999181:EE_|DS2PR12MB432622:EE_
X-MS-Office365-Filtering-Correlation-Id: 70775ccc-1627-4620-8948-08df2e52efc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|22082099003|18002099003|10067099003|3023799007|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	v0n8sYnqT18M1gZhBsX3gQCE4dCbhs9eyMAmZCvc1NpCadTPjvMzTevjYdFzSHMXazEMUyXalSh4RgGGfrGakkGGnLls8D9XRILMVsPQh1GiNMZkiVhkLj2kj5WeWa80/HAeubguseN0U0COCKEThSgxzbaSsW4ZF3sn2pIuxFwSSdsMWiodxQKQX9hj59TT6XNkvkUhm4eOLj9SsOmZZn+pCUZm3dT++gZeW+CgNfGl2UMwS/FYgngStFCULcfxodBRD8wzpHNoyr+Vypck6LS3wjNqGbDbsgUMbAE5OCVD8G79pLvZTgmJyB2yHNKuQt/xUM3DCjE0FVfhhd5y13wt9iJLtZk7hJQBLoFAQLjRyxEXpWOTKsgnTlKTKoXIv+YwQ1R+udYMOKqr8dJUlKwrqn2pNMBcSspbLWgpCrOgA5QySvGMDL6aIR9Es6eLI2akIE3QkoO+73V1hFpUmoSm12rIzU0Rh0IR0fqnLvpfpzfEFJrHWT3gKTIJiXQ/bffgWHmCoy24qoMgPZgeCbIY2D7O65Jtn4exlC10H0pzaki28ccOpwEnR/dJAq53sNEIsXW74NPh8R1ARtZVS3U0BEU5VCgAeBUinMGfRj3x1qK0Ki2913gCgMPpPmNDDDEfgNM3lkzCsmrLV39vXXLtYiUAfGRcIhKaIH3PEYk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:EAYPR12MB999181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnpqWmVmS2FzNmo0Yk1RWDN0S2pGWWhWYXVZMkEvMFJnYWVFVGd5RklwZVBR?=
 =?utf-8?B?MmZHb21TRFBobk9vM3FyWnlwVUFoVklObktKYmJERzhXYytpTWMyOHBkNVNl?=
 =?utf-8?B?ejhQL25jTEIrRk1sbGgrMmc0Q0tNRnRhMWpPVkRNdlNTdGxzV0JpbWF0azlZ?=
 =?utf-8?B?VkU3SUZEVGVBaHBFUXFJTXVvRVZZem4xZDMzZDZSK0JSVHk4aXJKS0tFYXU0?=
 =?utf-8?B?cklacUtIMTl4Y0V3QXdlVFh2cE96RVlKOHlsckdiMWpyaXRpWmtwY09ST0c1?=
 =?utf-8?B?UmZIY3NoWjlJbWR6Z3hCdjRZMkxhUUl2ejhza2FGdHcrTFpseS9FQjNWSStS?=
 =?utf-8?B?cVRoc2dRdTh3bFR5dHMvZU5MdVRIamZXUXM1dys4Uko1WWVIeTIyRUdIWVdh?=
 =?utf-8?B?UXhPaGpsN1RLV0xQRjNlV1piRWhRWDZrUVZnbEdwRzNmYkpjV25yUkZ0Tlpo?=
 =?utf-8?B?T3V1bmM2YURPVFRUOExxWHpkU0xIUE1nbmFWK3RqdURGQVR4U2F4aXZ5Q2tp?=
 =?utf-8?B?bldWUnNDdXFUZWpTSjVQZWlhejVJdjhkOStVeUovZ1dwelpuakZJWWRac2s1?=
 =?utf-8?B?RlR0QVRLek9FMEtjOTltRnVqd3pQZ2cyNmUrMFYrT0wwT3BibG5keDRxK0Q5?=
 =?utf-8?B?OWo3eDBxMEJnNzNkN0hoUk1kVVI0b1UzekxBU0RnMUJYMktZbGJ1dkpJdnlH?=
 =?utf-8?B?b1Z5TjF0T0d3dFEyeDFXWVhyMWtGekZDZ2xLakV1dnE5Tlk3RG5QWEhONTF2?=
 =?utf-8?B?a0Qzb3NlaDRKalFnLzVaQ2VoSkRRUnRhN3RlY1hzbm1GK3hCS3Flb2h0N1M1?=
 =?utf-8?B?WWVSRENoK0ZsVnpwbEdsMm1ybmN2UFdmZDIvSWovK0RmUS84SVpobTNoUHJU?=
 =?utf-8?B?TlNGaC9DWXRyYVlRWncrNnlOcUllcm80MlVpSkFTeFMvaVJEK3pSZFNucnJj?=
 =?utf-8?B?RjN3aWtua0JDRWhvL29TekFsQWk1WnA0QXh5RDBKRnY1djVtUiszWEN2UWRi?=
 =?utf-8?B?TFczWXZIVTFxVjdpR1Zybjd1N3dYSWxTdGJlODZVZmQxZXBLUEFHVDlocnVp?=
 =?utf-8?B?c2x0ckVpbG9HSGxjbjd6YnhsY1VnOGNhclpINnQ5Qm5uWHJWNkszS2Uxdks2?=
 =?utf-8?B?bzR3MFNMbzcrVVNPRHQyRmRjRUEyKzc2SFlyT0tONUtzMWF2cnU2R1NlblFv?=
 =?utf-8?B?dlY0RnFna1loR0NmcHZrQW82NVhIRmpVMnljZ1BlNDlPYVpvZ1p5WDcvdENF?=
 =?utf-8?B?enBpUFlGSTR5N1haTjY2emFLdENkakt2NXpyMEcrRjQ1eTJpVEF1V0dzK3h2?=
 =?utf-8?B?VmpWUHk2NW1YNzlpRTVGeVNDMTFFdzRHSzdZbUEzeTJNVnk1UWtqamY0dTRp?=
 =?utf-8?B?MGE0RmtZVkJuWTYvZ1RzRnZmdkE5VU1ITTRDOWkwQTQyODUvRGs2aythVTk4?=
 =?utf-8?B?VCtONkw5a1FOeHZFUUxzaDIycTJXNXZFeUJWd2VxR0w0SCtFWE0rUHc2SFNy?=
 =?utf-8?B?d1NybXQvTVRsdFN4UzBIS2c0S0czWEJodVArem1JN2Juek9MNnZUcWZHVVJk?=
 =?utf-8?B?OFh0aVVSMXJ6WSs1anBQR2xiKzk3MkRWYUpCT3Q0VnJzTnVjaWx2bHRjcEVw?=
 =?utf-8?B?b1V6cXFVcHoxQmZ5RWNKUkFmVFRlV0NmMXdSVG9McmJoL29RZXpFZ1B4QmQy?=
 =?utf-8?B?eG1ZdElsRlNuMlNQMDNpYU9tZ0cxMmxEanRreE5kYTZReXR0NzN3RDV5REJZ?=
 =?utf-8?B?Q0VqTlloWlZKWHdhYkJlTk54Tk55UEtmSUIwTktIOFl4dFhMRWkxdnUwRitQ?=
 =?utf-8?B?YnRvV1VnN1ZyKzdPc2pmb21QL2s3TVMvaXFaTi9jY3Vsb0xtakJjVDFwQk1U?=
 =?utf-8?B?aUdXaUg1TDhvWkNqc2dqblBoYS83Y2dLeU8zRGxnYlhjdE9peUdyMXFVL2VI?=
 =?utf-8?B?K1JVRXpXMVQyMFhiVW9HWVRlNU5JaENqQ3RINU50ODBKMHBzbTltaG5BN2Jz?=
 =?utf-8?B?K0dGRDJKRTZCWG13dVhaODFMRXc3SVJHb0lmMHpOQkZGQW1OcmMxUnY2QVJC?=
 =?utf-8?B?ZEh0YmQ5K1dqbWQ5bGxxZVJraEJZR29BUGtLSE1tRkdiemczTmNaQnNrcllr?=
 =?utf-8?B?dElKQmcrTzVjcGx6azhqUTlaNDQzRFR5dmViaDZydTBuVkVGazBaS2JxU1N0?=
 =?utf-8?B?Uit3Z3pJV0xSMkhKNmYwbHpVbkFXNDFLM3FialBPZEE1KzZTV2hqeXFDS0RD?=
 =?utf-8?B?a3UwOSsya1lEbkhid0VYSTd3SEJKQ1RHZDhsblFoWmQ4MURnMkVpUUVVNEZX?=
 =?utf-8?Q?CAYmud9UgaZjJXh06s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70775ccc-1627-4620-8948-08df2e52efc8
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB999181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 02:36:25.6286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCDOd7QBAb8przywdauTa9vK5ZCJE0F3M+n0+KV+7CRbHQLMHOa+Tp+WeZ/kBcSv6vs0GEiWtF8lWh7TrMFaTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB432622

Hi Guanghui,

On 10/15/2026 11:23 AM, Guanghui Feng wrote:
> From: Guanghui Feng <guanghui.fgh@linux.alibaba.com>
> 
> AMD IOMMU specification (Rev 3.10) does not define interrupt message
> draining semantics for INVALIDATE_INTERRUPT_TABLE + COMPLETION_WAIT.
> This creates a race between vector_schedule_cleanup() and in-flight MSI
> messages still transiting the Data Fabric after IRTE modification.
> 
> Intel VT-d is architecturally safe due to explicit interrupt draining
> guarantees.  VT-d spec Section 6.5.5 states:
> 
>    "An interrupt request is considered drained when the interrupt is
>     accepted by the processor Local xAPIC (for fixed and lowest priority
>     delivery mode interrupts this means the interrupt is at least
>     recorded in the Local xAPIC Interrupt Request Register (IRR))."
> 
>    "Interrupt draining is performed by remapping hardware after Interrupt
>     Entry Cache (IEC) invalidation requests.  For IEC invalidations
>     submitted through the queued invalidation interface, interrupt
>     draining must be completed before the next Invalidation Wait
>     Descriptor is completed by hardware."
> 
>    "For index-selective IEC invalidation requests, hardware only
>     guarantees draining of non-committed interrupt requests referencing
>     interrupt indexes specified in the invalidation request."
> 
> Additionally, Section 6.5.2.8 (IEC Invalidate Descriptor) mandates:
> 
>    "As part of IEC invalidation, hardware must drain interrupt requests
>     that are already processed by the remapping hardware, but queued
>     within the Root-Complex to be delivered to the processor."
> 
> Therefore when qi_flush_iec() + qi_submit_sync() returns (Wait Descriptor
> reports QI_DONE), all non-committed interrupt messages referencing the
> invalidated IRTE index are guaranteed to have been delivered to the
> target LAPIC IRR.  The subsequent vector_schedule_cleanup() is safe
> because is_vector_pending(prev_vector) will always observe the drained
> message in IRR, causing the cleanup timer to rearm until the interrupt
> is properly serviced.
> 
> In contrast, AMD IOMMU spec Section 2.4.5 defines
> INVALIDATE_INTERRUPT_TABLE only as:
> 
>    "instructs the IOMMU to invalidate all cached interrupt information
>     for the device"
> 
> with no completion condition, no drain semantics, and no ordering
> guarantee for previously-remapped interrupt messages.  Section 2.4.11.2
> ("Invalidation Commands Interaction Requirements") limits the completion
> guarantee exclusively to DMA transactions:
> 
>    "Invalidation commands are considered complete only when the IOMMU can
>     ensure there are no DMA transactions in flight anywhere in the system
>     fabric that relied on translation cache contents prior to
>     invalidation."
> 
> The words "drain", "drained", or "draining" appear zero times in the
> entire AMD IOMMU specification (Rev 3.10, 48882-PUB, Feb 2025) in
> connection with interrupt messages.
> 
> Consequently, iommu_flush_irt_and_complete() returning does NOT guarantee
> that old (vector, destination) interrupt messages have been delivered to
> the previous CPU's LAPIC IRR.  The immediate vector_schedule_cleanup()
> after IRTE modification races with in-flight messages on the Data Fabric:
> the cleanup timer reads IRR clear (message still in transit), calls
> free_moved_vector(), then the message arrives at the old CPU hitting
> VECTOR_UNUSED -- producing "No irq handler for vector" and permanently
> losing an edge-triggered MSI.

Please describe the scenario you encountered to reproduce this issue.

> Fix by restoring three-stage cleanup semantics for the normal
> (guest_mode=0) path:
> 
>   1. Change amd_ir_chip.irq_ack from apic_ack_irq to apic_ack_edge,
>      which calls irq_complete_move().  This ensures cleanup is only
>      scheduled when the new vector first arrives at the new CPU --
>      providing a natural delay (device interrupt period + PCIe transit +
>      IOMMU translation + Data Fabric delivery) that far exceeds any
>      residual in-flight message transit time.
> 
>   2. Remove the unconditional vector_schedule_cleanup() from
>      amd_ir_set_affinity() for the IRTE-modified path.
> 
>   3. For guest_mode=1 (AVIC/guest interrupt virtualization), the IRTE
>      is not modified and no host-vector interrupt will arrive (interrupts
>      are delivered to the vAPIC backing page instead).  Retain direct
>      vector_schedule_cleanup() in this case to prevent move_in_progress
>      from permanently blocking future affinity changes.

Please describe the permanently blocking scenario.

> The combination of stage-2 natural delay and stage-3 IRR gating
> (is_vector_pending + timer rearm) provides robust protection against
> the AMD-specific lack of interrupt drain guarantee.

Adding some arbitary delay does not necessary guarantee the delivery 
before clearing the old vector.

> Intel VT-d, Hyper-V, and UV platforms are not modified as Intel is
> architecturally safe per the spec guarantees cited above.
> 
> Fixes: 5478844b12d3 ("iommu/amd: Move interrupt remapping to its own file")

Is this the correct commit? I could not find this commit. Could you 
please provide link to the commit?

> Signed-off-by: Guanghui Feng <guanghui.fgh@linux.alibaba.com>
> ---
>   drivers/iommu/amd/amd_iommu_types.h |  2 +-
>   drivers/iommu/amd/iommu.c           | 46 +++++++++++++++++++++--------
>   2 files changed, 34 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 8241ef922519..35024e3f5b90 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -1037,7 +1037,7 @@ struct amd_irte_ops {
>   	void (*prepare)(void *, u32, bool, u8, u32, int);
>   	void (*activate)(struct amd_iommu *iommu, void *, u16, u16);
>   	void (*deactivate)(struct amd_iommu *iommu, void *, u16, u16);
> -	void (*set_affinity)(struct amd_iommu *iommu, void *, u16, u16, u8, u32);
> +	bool (*set_affinity)(struct amd_iommu *iommu, void *, u16, u16, u8, u32);
>   	void *(*get)(struct irq_remap_table *, int);
>   	void (*set_allocated)(struct irq_remap_table *, int);
>   	bool (*is_allocated)(struct irq_remap_table *, int);
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 56262f6b1f70..60e769384e8b 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3634,7 +3634,7 @@ static void irte_ga_deactivate(struct amd_iommu *iommu, void *entry, u16 devid,
>   	modify_irte_ga(iommu, devid, index, irte);
>   }
>   
> -static void irte_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
> +static bool irte_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
>   			      u8 vector, u32 dest_apicid)
>   {
>   	union irte *irte = (union irte *) entry;
> @@ -3642,9 +3642,11 @@ static void irte_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u
>   	irte->fields.vector = vector;
>   	irte->fields.destination = dest_apicid;
>   	modify_irte(iommu, devid, index, irte);
> +
> +	return true;

This blindly return true regardless of the return value from modify_irte_ga.

>   }
>   
> -static void irte_ga_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
> +static bool irte_ga_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
>   				 u8 vector, u32 dest_apicid)
>   {
>   	struct irte_ga *irte = (struct irte_ga *) entry;
> @@ -3656,7 +3658,11 @@ static void irte_ga_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid
>   		irte->hi.fields.destination =
>   					APICID_TO_IRTE_DEST_HI(dest_apicid);
>   		modify_irte_ga(iommu, devid, index, irte);
> +
> +		return true;
>   	}
> +
> +	return false;

This blindly return true regardless of the return value from modify_irte_ga.

>   }
>   
>   #define IRTE_ALLOCATED (~1U)
> @@ -3933,7 +3939,7 @@ static void irq_remapping_free(struct irq_domain *domain, unsigned int virq,
>   	irq_domain_free_irqs_common(domain, virq, nr_irqs);
>   }
>   
> -static void amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
> +static bool amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
>   			       struct amd_ir_data *ir_data,
>   			       struct irq_2_irte *irte_info,
>   			       struct irq_cfg *cfg);
> @@ -4153,7 +4159,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
>   }
>   
>   
> -static void amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
> +static bool amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
>   			       struct amd_ir_data *ir_data,
>   			       struct irq_2_irte *irte_info,
>   			       struct irq_cfg *cfg)
> @@ -4163,9 +4169,9 @@ static void amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
>   	 * Atomically updates the IRTE with the new destination, vector
>   	 * and flushes the interrupt entry cache.
>   	 */
> -	iommu->irte_ops->set_affinity(iommu, ir_data->entry, irte_info->devid,
> -				      irte_info->index, cfg->vector,
> -				      cfg->dest_apicid);
> +	return iommu->irte_ops->set_affinity(iommu, ir_data->entry, irte_info->devid,
> +					     irte_info->index, cfg->vector,
> +					     cfg->dest_apicid);
>   }
>   
>   static int amd_ir_set_affinity(struct irq_data *data,
> @@ -4176,6 +4182,7 @@ static int amd_ir_set_affinity(struct irq_data *data,
>   	struct irq_cfg *cfg = irqd_cfg(data);
>   	struct irq_data *parent = data->parent_data;
>   	struct amd_iommu *iommu = ir_data->iommu;
> +	bool irte_modified;
>   	int ret;
>   
>   	if (!iommu)
> @@ -4185,13 +4192,26 @@ static int amd_ir_set_affinity(struct irq_data *data,
>   	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
>   		return ret;
>   
> -	amd_ir_update_irte(data, iommu, ir_data, irte_info, cfg);
> +	irte_modified = amd_ir_update_irte(data, iommu, ir_data, irte_info, cfg);
> +
>   	/*
> -	 * After this point, all the interrupts will start arriving
> -	 * at the new destination. So, time to cleanup the previous
> -	 * vector allocation.
> +	 * If the IRTE was actually modified (guest_mode == 0), rely on the
> +	 * three-stage cleanup: apic_ack_edge() calls irq_complete_move() when
> +	 * the new vector first arrives at the new CPU, which then schedules
> +	 * the cleanup of the previous vector allocation.  This avoids a race
> +	 * where in-flight MSI messages, still on the Data Fabric after the
> +	 * IRT invalidation because the AMD-Vi specification provides no
> +	 * interrupt drain guarantee, arrive after the old vector has been
> +	 * freed.
> +	 *
> +	 * If the IRTE was NOT modified (guest_mode == 1), no in-flight
> +	 * messages exist for the host vector and the new host vector will
> +	 * never receive an interrupt (those go to the vAPIC backing page
> +	 * instead).  Schedule the cleanup directly to prevent
> +	 * move_in_progress from getting permanently stuck.
>   	 */
> -	vector_schedule_cleanup(cfg);
> +	if (!irte_modified)
> +		vector_schedule_cleanup(cfg);

The !irte_modified is really checking guest_mode == 0 before calling 
vector_schedule_cleanup(). The name is misleading. I also do not see how 
this resolves the issue instead of calling vector_schedule_cleanup() 
unconditionally.

>   
>   	return IRQ_SET_MASK_OK_DONE;
>   }
> @@ -4205,7 +4225,7 @@ static void ir_compose_msi_msg(struct irq_data *irq_data, struct msi_msg *msg)
>   
>   static struct irq_chip amd_ir_chip = {
>   	.name			= "AMD-IR",
> -	.irq_ack		= apic_ack_irq,
> +	.irq_ack		= apic_ack_edge,

The apic_ack_edge() basically calls __vector_schedule_cleanup() before 
apic_ack_irq() on the new cpu, which should have already been called 
during irq_set_affinity() and clears the move_in_progress. So, the 
apic_ack_edge() would not be calling __vector_schedule_cleanup(). I do 
not see how this would make a different.

 From AMD IOMMU hardware standpoint,

1. The IOMMU considers the interrupt "done" at the point the write 
completes at the fabric level (i.e. when the upstream posted write is 
accepted). There is no round-trip back from the CPU APIC.

2. When SW issues an interrupt table invalidation followed by 
COMPLETION_WAIT, the IOMMU must drain all in-flight interrupt before 
acknowledging the COMPLETION_WAIT. This ensures any stale IRTE data has 
been flushed before the invalidation is considered complete from the 
software's perspective.

3. The time to drainthe data fabric should be much less than the 
1-jiffie during the vector_schedule_cleanup().

Regards,

Suravee

>   	.irq_set_affinity	= amd_ir_set_affinity,
>   	.irq_set_vcpu_affinity	= amd_ir_set_vcpu_affinity,
>   	.irq_compose_msi_msg	= ir_compose_msi_msg,

