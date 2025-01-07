Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68D1158520
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 05:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736227690; cv=fail; b=Gjk9vY93AFQMDLafgRmXWYSdKEBiCfOEn4oGEgEr8q75V3eOHXc1VlOwJccO+PRhHI+SG1yTW+O1zemaAn9EA8ECxCXjdN39x5xAE8Xbh48+4Zs1K0uSA/Fr8by9fmdlCj7rQHvZNAkQKC5A0P6inTTWx2c4tmF573AjCTFD4Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736227690; c=relaxed/simple;
	bh=hzZN8Hv7tqMqG1coYDZpnizqwjSaTyy3Wr9QfuKtPvM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O3E50MNguvHd3ultFR/YLgQtGXrgYBklmZtakYG1yVjk7u8cca9EvPfJyZGMGV6zYQyZNteko0i0NpwPxD3dP8b/W0T+xgOLLRF3ms5lFfMsQMoTonDQ3qq9cF7bBv3Ykw07NnO9iHsYF/0Tbn/4RHITQT6g76qVN0LSuAcjkyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ecBqbV7b; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ecBqbV7b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5c5bTJUwUN7sO4rANxXCZeCKCcvzEHkEGzhNk10fC/L32SWzoMbLaGgBdptUKSdD0Rb+KCrc7JIRoXeMlk21JNjiRSdH4K4VpZSlC41Cuoqw3DMIlXhoMSIFiofVua/bMWtNFY0VzHHqnw8uf/UOnGPdS54W4HD7N8vGEmJue5/t89yf3Xonva+IpXkm8fJpyoCopQxYR3h3BVJIElaF6yrWYn77Fr3VOzuOdqWBRywXbN3QTwAIq6FsNw69wzpe6xBYQl8erWwENYbjTHAtaDldfFB1eHA5s59PnvyCBPquHJ1oThjNpvZV4OU21Ao5DX7CgtGvOrDt38N1FActA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bder2U4KhPlI2nz/KoS5ZxxbvyvYX44zuSxfljf33hU=;
 b=iHDpJX3dMlm5AugojJTfYLWlxp17DSRcuRapRO4Y/87I+bU/5nNV4o5n41vT3Dddh4nAC+ukRc5xD13U1oQLh+CUy+NPtgQftqMTuNR4prRhZdmovR8cIt9Zhqz7wn1+aMeApor0w0dBuml0TrX/InMqa8C/vJe3g1BxCLC0ZYYmnJ4m13We056sRd+9RI5YTFHztddoAWw97YjfQfV1+uyzzsn0oL8936KFfUQgH3QB4Z5IwmQAP26NbhATpL+XGUa12aN86Ftmn1O31thBwrOsZBY+L7HpuFUF2VDJaOSPKzowZAfdOJpnFOnhbEKcRwIJ+CdUMvBTPYNAztA2mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bder2U4KhPlI2nz/KoS5ZxxbvyvYX44zuSxfljf33hU=;
 b=ecBqbV7b+hSjt3vQMvqp6cgQsKalXdRjg0qACAFwbtIjt1IbWFBpBiQEjQ6fgV0QKUep2NNtyoFXeqGR23auCiIoQoWWOXoR9wq4o2e/lN0+9LpwBc2J6BCPqlbdTCz9YWVKvaJez0Gv9QbNjuQul1VCi5rAqmygfSIbV0pp7fw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 by MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 05:28:01 +0000
Received: from BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f]) by BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f%6]) with mapi id 15.20.8314.013; Tue, 7 Jan 2025
 05:28:01 +0000
Message-ID: <7f2cc502-3ceb-4265-a6e3-53186afbcd7f@amd.com>
Date: Tue, 7 Jan 2025 10:57:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] iommu/amd: Add debugfs support to dump IOMMU MMIO
 registers
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 vasant.hegde@amd.com
References: <20241126205834.GA2651046@bhelgaas>
Content-Language: en-US
From: "Srivastava, Dheeraj Kumar" <dheerajkumar.srivastava@amd.com>
In-Reply-To: <20241126205834.GA2651046@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::22) To BN9PR12MB5163.namprd12.prod.outlook.com
 (2603:10b6:408:11c::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:EE_|MW4PR12MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dcbacf5-36d4-4a1b-b7d9-08dd2edc0d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDdIY1ZZN0xBRXNMVHg1a2JnV3BzWStrSUF3MGcvczB0ZHpuMVNoSXhZTHlF?=
 =?utf-8?B?VXNTZzI2MHVFLzJvSmZOQ1JDQlFZNGp5MHUxKzg2bkREV204U3pGMzhnMktR?=
 =?utf-8?B?Vm5VWFRHK0c5S2ZXU3VJa3N1emp4dFoxQW41bW1ZL1RYRlZOUHBiNTRMaGVz?=
 =?utf-8?B?ajRmM1hIU3VFTHN0UFI1ZjQyQmNpUmgvcnVvODhEczNVemZNWnJjREkrV2Zz?=
 =?utf-8?B?RWxFUGZzSzZWR09IUzJMQkdXMVM3MC9nMkNwbElzYVNqMHprQ05Yakg0UWdW?=
 =?utf-8?B?Z0JlYW95d2M1Q2FHMGRrUEErcUN3NGlGa2VKenZoMjRLR0g5YXQvNVZjemp4?=
 =?utf-8?B?c1I1N21FSkdvaXFJTG9WRmdvQXcycy9rUWNkemIxbkZPMnJ2cVo5YjB6eVBY?=
 =?utf-8?B?clNka1NVcnN2V2ZQdCsvTzdJdCtBUCtGZ1BkaWh0Z1NibkZHNkZYbkt5aXU3?=
 =?utf-8?B?UGZmN1UwNldkRDNKUTl1SEtRQjlBczRvYlNHeitNdmk1YmdHaWhocHJEM25l?=
 =?utf-8?B?SVZNUkUwZEVMenF2SDFQamxlaE42eGRJMlN6TGFMc0tsVk5idDdNSGFyU0l1?=
 =?utf-8?B?VE1PZFcwemVUTVNNTGpxblRPV3NIVUlMMTRYeVB4YWNKV3hPQVVjTmo4Wld2?=
 =?utf-8?B?UUIzS1NTNURabEd2aVdEc3BuaVpyUkpmQXBtVmh4dTk1YmRCd01YL2NoUEVT?=
 =?utf-8?B?UjB4WGdwTTIwdUZDTkJzVnNSTUdUM3JSNGJ1S3A0cUg0RHh3WEZyNTRoeHlW?=
 =?utf-8?B?cWsrbGdKaEhHazhYbFh2V3RmTTdVcXRrS1p3TkY3MUtrQ0didndUWVlRZEpR?=
 =?utf-8?B?Rzc5MDlwYjluZTlpazNiVTVnaldwQ0dHam9rQ04yZ2x2K21oeUpubFdoSWVG?=
 =?utf-8?B?dCt1MTFkT0Y5VzJJWTR1QnRRaHBYK1pJNmlXMjJOZVpUUWFwaENJRnU2Q0Ru?=
 =?utf-8?B?Y1A5b2ZNV3l5QVJqOFA0QkJRR3RtOTdYN3BJajZRZ3prK0ZnK0JJaEY0dWJE?=
 =?utf-8?B?TktTenpzQkd4aHo4ek1LTTFRWlBKa2RqTzZQcXYrL0Q4a2laT0NNYStLTGxa?=
 =?utf-8?B?MU56UWJlWlpXTFBJb1JNK2RCVGtHWnRIdnRMMzFzL2RZbWhVRHFtMmxZRzls?=
 =?utf-8?B?ZHNqL1Z0WDhQSENlWnc0RkhMeW1RMkFvazBWb1J5cVNBbUw0Rk83cS80eVVa?=
 =?utf-8?B?bTBVMUYwTVRDU0lib00vSStNYmRRQmIwZC9sV0hqZm9DV2YwYjNyaFNJM1NN?=
 =?utf-8?B?bE9VMldzQzVYUVVtb1I1SUlMWktibHNrdHU2UHZDL3JVT3l5WVcveTlOZ2Ri?=
 =?utf-8?B?MS9hckJaLzlZRjNxeDBTeEVYM2UwS1pUSnI4cGtWblZwSDE5KzR5eW14Qmtj?=
 =?utf-8?B?LzUwOFROY1ZBSXltajFOSkF0aHBmWEl5d2JsK1JwV0VpTWJpWmtKalUwaXNZ?=
 =?utf-8?B?R1hkMXZoRE8vSXh6R1hFNjVJUFJ4bFNWY1FEdExXNmxuRHN0U3FtcVUwRFh5?=
 =?utf-8?B?QVl3RzkwQ2d1N04xY2dwaWRkNGszd2FjeFRZRFFISTAvUTlxMitZOExtbzlo?=
 =?utf-8?B?OWZma1huQVpJRk8wZENxVUNvRG1YbW4xVlhESno4ajNyL3dhcWRtOThrd0hr?=
 =?utf-8?B?bnhOdUQ5dUh6WFBXbHFCZGpDSHhudXlzK1FRd1k1ejlUeHAvNG0rOEFUZXFF?=
 =?utf-8?B?bm9OMjl0WXB0OTNzZ0MyMzNCamRSWmV0TnZCUWY2djl0WUlzUmU1b3FEQitz?=
 =?utf-8?B?Q0RTQmJsNzhMdVRVcHZuRDRuUS9lWTBDaVpmUW12MWE1Q3JaVXp1RmJmNmV4?=
 =?utf-8?B?by9WS1g4OVFNSkJ2VzVqZmVya1JzYUNiTVZMbnBIWGRPcGxEYUIzM0lid0xX?=
 =?utf-8?Q?Nu6ylcrCPhUXo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXg4MkVuZlhKL2dGcXRhcnduVU1WdDdZbGNnQzUyZE56R0hCSVlWYVhoZThK?=
 =?utf-8?B?K2xYeFZFMFAvWGxiK3dtdmtuK1BHNW1MU3lpWHdtbDQxVmltb291K1hGZFdD?=
 =?utf-8?B?TFZja3l2Z2MzcFZrVEw5bzZDaDNtWUdrSlhWOU8xM09GT2hra0p2MXBCRGp0?=
 =?utf-8?B?NGJPOFhuSVhuYXpDaVhRS0J2QnM1cXQvU1prRjRZc1hmbDZ4SUFMb0RFZU50?=
 =?utf-8?B?T0tUNlVFQUNveXRUZTNvbXcyRGFXSFpzM2pXdnBSUWhrN0pwOVIyMThpdTFQ?=
 =?utf-8?B?S0V1OEtKeWxFMUxqUGtyd3pQZUQ5Rno3aDdXeG4zTDdzQkpjVVFLQ01Jalpj?=
 =?utf-8?B?S3Q3eXFIdGlGT1NXQjQ2bStWMVg0cGZONHB0Z3hWNDdJd1gvb1pXUC9vWGpH?=
 =?utf-8?B?SVpTYjJXV29TQjFCQlpwUEhSSGJuUWI5djVLVXIxZ1ZiZmNRNEs0NktlQkVV?=
 =?utf-8?B?TDZDU3pvWm1mRDh4OStKUEhpUlMrTzVpL2JESUFhUkl1amRYSlRFVCtRbnZZ?=
 =?utf-8?B?UnNabXZpeUN0ZXErYW1CdXcyQ3FxRXRjaDZ4VGFzVzVPQmU3VXllN2JDdWVk?=
 =?utf-8?B?Um1WVjdQTDhWTHprMWZ0V1lTTzBJeXc0YlBFUUs3UG5QSHdDREhRbWxJSzRF?=
 =?utf-8?B?b0lwQTNqdWhOWWtGd1FvcDBiRzZQVGVHTXVKZHRVN053TnNlUVg5N0F2b3lv?=
 =?utf-8?B?OG01cDFWdzNRQnpBdjJ1RVNqRjlpSWdEZEU4MkhiNzZGalRyMit3TldqdW9r?=
 =?utf-8?B?ZVBwNlNIc0FzbVNqUjlxYjRWc0pZK28ydVplVzN1ZzdjRnEyZmRLWWs3NjVk?=
 =?utf-8?B?c3BhbDNHMzZ5eTVYa3R0SXN0T1RIL2JQd3BRNjEwQnhrZXRFSUkxclRuZWZ6?=
 =?utf-8?B?N1RtREV6YzduOS8rcFovL0pZWmN0TnJVemNxU1o2dldDbVF5MjhjZW9JMWEr?=
 =?utf-8?B?Q0FmWTdqWEl3QXF3LzBKK1hnUGJObWMyZ3YyZ0pxVG9iR0w4cTI3MXJUQWts?=
 =?utf-8?B?YStHQ2M0SWFBd3owbkVDR1ZjOUtyTFlFU04yUWpXcVJWOUhtWVN3T1NqZzFX?=
 =?utf-8?B?SXdiME1OeitjSTJjaDNaT3Z1bmQyV0s1ZlFDWkhaUWhDZ1RDQmdSd1dnOXlu?=
 =?utf-8?B?R0hVTy80azR6TUZiUnZwRWxVem5PdmNNb3pQczBaVnRqdDVjM3VmWHArMkRv?=
 =?utf-8?B?ditZanFhazFoSmZIOHk4SzE1eGJ0R0srb1B5cWFsbzZVSlREVEhkQjZqdG41?=
 =?utf-8?B?enRiTURlMi8zczhlbW1waUNuYTJockpHSUhzMitjVHlSRXh2aUxZcjdqNy84?=
 =?utf-8?B?cFpyMkR0L0NaUldIdzhtdDlRYmtxR1RYL3NSWlJOQWZiMTNQWUtiNmJoUExH?=
 =?utf-8?B?ellweEZRc3dJL00rUENoTWtmTkxmZjVSSkw4dHRSZ3NqUGgwUmZTVHh3b05G?=
 =?utf-8?B?QlJ2UlpMemJSVGR1Wll5NDRjKzI3WnpmekRpMjd3Yml6N0RUOFQvUURtcWRu?=
 =?utf-8?B?VnUwbDRNUGhBQ2RQU0lFcnk4djZZa0QxUXVhVU5QazBXaURqL2MvYUczaWpL?=
 =?utf-8?B?VzNHbjlqdmRkYk9zTTk5dmh4Z1ppTDVObXFWdVNZSUkxWXRhakRSeE1sbE5o?=
 =?utf-8?B?djRiMC9qekdXTnRFOFVxMTNBN2plZ21wNXhmMHFzSXN5RjVGUStxajU5bWNT?=
 =?utf-8?B?Tk5UdnpIVzE4YmVNVnZOYjNlam1CMDhBV1MxSkRkSEw1TmRyaEZiY240b1lk?=
 =?utf-8?B?MmJOSHE4blVOMGxwemIxT0poUmpzcDhGVHVYL3AxbVpId3RFVGZseGcycS9K?=
 =?utf-8?B?Ukc0WXFXNVhXQ1p0OWE0MnNpQXpEUThtL1Nxd28xWXVxZjV1SjdZVDZsbSty?=
 =?utf-8?B?OTVQWC9oeEk1NVAzTFAycDZOclFvREJ1a2dPalhGb2ZBUllGa2kyZ29zWnpX?=
 =?utf-8?B?SnZNMDlsY2JnWElKTFZHeWprOXNaa09lQndNSElEd0F4MUFNbHQ0QktlTjBi?=
 =?utf-8?B?cUN3M0xFVFArbEhzTDFEbEtmc21XazhBb2JMd1ljdE03VC9FWkU1dkh1UkVU?=
 =?utf-8?B?b2xvL0x6YlRhM01waUk2YlA5N082MzJ1eHZ0Q1ZOdENMQ3pQNDZLcUg2ZTFT?=
 =?utf-8?Q?fhhGEQZkSzaUMidhKDDEsYsTv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dcbacf5-36d4-4a1b-b7d9-08dd2edc0d70
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 05:28:01.2456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mV+PeF8bSb/HoyiCKAxI1tr50E/gIgTndsA+6LfseF7CaCgelrVR2IDVf0FUBABQhJZoucIW0Iwn1SqbI0tzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7141

Hi,

On 11/27/2024 2:28 AM, Bjorn Helgaas wrote:
> On Wed, Nov 06, 2024 at 01:16:33PM +0530, Dheeraj Kumar Srivastava wrote:
>> Analyzing IOMMU MMIO registers gives a view of what IOMMU is
>> configured with on the system and is helpful to debug issues
>> with IOMMU.
>>
>> eg.
>> 1. To get mmio registers value for iommu<x>
> 
> s/mmio/MMIO/ to match usage above.
> 

Sure.

>>     # echo "0x18" > /sys/kernel/debug/iommu/amd/iommu00/mmio
>>     # cat /sys/kernel/debug/iommu/amd/iommu00/mmio_dump
>>
>> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
>> ---
>>   drivers/iommu/amd/debugfs.c | 58 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>
>> diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
>> index ff9520e002be..e56c050eb7c8 100644
>> --- a/drivers/iommu/amd/debugfs.c
>> +++ b/drivers/iommu/amd/debugfs.c
>> @@ -15,6 +15,59 @@
>>   static struct dentry *amd_iommu_debugfs;
>>   
>>   #define	MAX_NAME_LEN	20
>> +#define	OFS_IN_SZ	8
>> +
>> +static int mmio_offset = -1;
>> +
>> +static ssize_t iommu_mmio_write(struct file *filp, const char __user *ubuf,
>> +				size_t cnt, loff_t *ppos)
>> +{
>> +	struct seq_file *m = filp->private_data;
>> +	struct amd_iommu *iommu = m->private;
>> +	int ret;
>> +
>> +	if (cnt > OFS_IN_SZ)
>> +		return -EINVAL;
>> +
>> +	ret = kstrtou32_from_user(ubuf, cnt, 0, &mmio_offset);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (mmio_offset > iommu->mmio_phys_end - 4) {
>> +		mmio_offset = -1;
>> +		return  -EINVAL;
>> +	}
>> +
>> +	return cnt;
>> +}
>> +
>> +static int iommu_mmio_show(struct seq_file *m, void *unused)
>> +{
>> +	if (mmio_offset >= 0)
>> +		seq_printf(m, "0x%x\n", mmio_offset);
>> +	else
>> +		seq_puts(m, "No or invalid input provided\n");
>> +
>> +	return 0;
>> +}
>> +DEFINE_SHOW_STORE_ATTRIBUTE(iommu_mmio);
>> +
>> +static int iommu_mmio_dump_show(struct seq_file *m, void *unused)
>> +{
>> +	struct amd_iommu *iommu = m->private;
>> +	u32 value;
>> +
>> +	if (mmio_offset < 0) {
>> +		seq_puts(m, "Please provide mmio register's offset\n");
>> +		return 0;
>> +	}
>> +
>> +	value = readl(iommu->mmio_base + mmio_offset);
>> +	seq_printf(m, "0x%08x\n", value);
>> +
>> +	return 0;
>> +}
>> +DEFINE_SHOW_ATTRIBUTE(iommu_mmio_dump);
> 
> I think this would be much simpler and more user-friendly if you made
> this a single read-only file to dump all the registers, as
> /sys/kernel/debug/iommu/intel/iommu_regset does.  Having to write
> "mmio" and then read "mmio_dump" makes it hard to use, and it means
> that two users can race with each other and confuse things.
> 
> This is part of the AMD IOMMU driver, which should know what registers
> are of interest and how to dump and possibly even decode them.
> 

In my opinion,
1. Dumping register/s only of interest is more useful then dumping 
everything we have or defined to be dumped.
2. If we want to dump set of registers (not all in the mmio space), we 
need to maintain list of register's offset we want to dump. In this 
approach, if more registers are required to be dumped in a later point 
of time, then we have to extend the list each time with a separate patch 
whenever we want to do so.
3. With the implemented approach, we can dump any register/s extensively
without maintaining register's offset of user's interest. Also it reduce 
user side of extra code to extract the required register/s from the 
dumped data.
4. Writing offset in different file and getting corresponding registers 
dump in a different file is useful for the same reason.

Debugging issues internally we found that this implemented approach is 
more useful.

Please do let me know what you think.

Thanks
Dheeraj

>>   void amd_iommu_debugfs_setup(void)
>>   {
>> @@ -26,5 +79,10 @@ void amd_iommu_debugfs_setup(void)
>>   	for_each_iommu(iommu) {
>>   		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
>>   		iommu->debugfs = debugfs_create_dir(name, amd_iommu_debugfs);
>> +
>> +		debugfs_create_file("mmio", 0644, iommu->debugfs, iommu,
>> +				    &iommu_mmio_fops);
>> +		debugfs_create_file("mmio_dump", 0444, iommu->debugfs, iommu,
>> +				    &iommu_mmio_dump_fops);
>>   	}
>>   }
>> -- 
>> 2.25.1
>>

