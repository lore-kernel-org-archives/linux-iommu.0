Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793721038;
	b=QjL20pFeNTzU/4xRaLZEKrmCr1Ph1Js9geCdxAGshRC0iMchjuLY7QoEArs/Ftl/bRGt
	 ZbVSxOzaYM30hgO55AW9WmwtWb8Xez3micOW20NaI5Twu4v/5Ti6Rsi15lEzhrcB9JlAB
	 LjTN91fS1CfEm6AC8JESV+nYF2zV1YFWY5wWQCAVlf9/tq9rRHlKdYyq6VzOFQ8iF/HWM
	 3/pTNI6oYxwxyBfXTqxm099Lia6iO+MTtYP+AfpwH8V+UTCrk25SzhI9ysVrxs487eny7
	 20q9yltnwsdxiGAfRI1A/uOixSoHA1qTXfbMIhMuWyrKepdnw1bznIm6t6tYvcYJDPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721038;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
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
	bh=Dj5XG0CGGVMBb61nMXfkA2HbLptGTDlPmBoqfkLRFt4=;
	b=yDum0cqKQQjFhDs+E/7UZX3WPDIM6hRxsFCbtL8xCR4BaLeKcWM9znFdMYiQ/oBgTvV4
	 7QJzOCZ8qc5b25BNu2tUtxrrfmDKwiCHfFSwF0BIxArn2yKXWE61phonZiODF+RxxT1tL
	 i5ManfJdn8VeaSoyWFgiImJhtkWBVo0CIgBuHmzUkN3BL0419i9wWG6k1UBwD3XnbduCE
	 Utv5zpb1XM6epQFqOUnnod8rQ9gDiITvgaxjknnX7pqCEt8GV3UpGX3JMduffczvOF00I
	 pAax24GV3rTZtMyOJjI0rUzA0/bRnM7QDNQTW8ZSDhM2rHw3BzqW39pmv/I9bzxiG5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=h20RmeBe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.35
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013035.outbound.protection.outlook.com [40.93.196.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71565606A33D
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 15:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71565606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=h20RmeBe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7V0SghG+Jc7Zyr9VzGvFkCowPCrT+iJ8xWGob7c5zEW7izsFUMfhZvX16Gal7Q8pmg4XfdrXbq2mIdvRCD8Z2IpXgXQM+oKVTVqcdP6Bzn2lcQ2R13ZjcNE7n0Re1ASdiq99TFRELH+pP/aqVsJIGXxGx3MQJ3FaNi9u3FoDn6BOWlN+3XkpWxrQr/hW+oGS69gN1Z0mojO2Ee1qxsjOfQmdFs2iAd75IxZawP9TVohRNLWWy6AYZrzGRfHZkHDfhsWwgcC03jQBxKCIC0kBMI1VhUoDaYrxYwjMvYpV4c0MM/sqzhoJv7jqydhcs97BCwVE3N7jx/LCukTRxdwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dj5XG0CGGVMBb61nMXfkA2HbLptGTDlPmBoqfkLRFt4=;
 b=WPcdQD7Vxm5A8QjuJZbRqXbxCwI96iFsHE8autnZPPDeMi0mE7BAlw7KrF9ytEpQ/xaQXJHsrMdnI4KiQg6ZI3usesbsVXef3T5DGqf5rI5b6ch2kN00KrZoYB2mB4jvKfV8kpgMrkOTCTeXuH0yW+QXmfEjmbTXp2dI82MuYRZD1dxdjwX+oDPwq7evM3M63mLKNnGpGbhEkPwaW0bQ1bHzILzRFPSy39zMT9/T+X1pRQplbec86dwd/7li6rMAZgLAFZR05tDSWTvu2Qv/HuzXwBKz6VjVzUC9RPxEavYbHt7M71uAnf4ETj9c3R0OdfENwa6SMODfcFnX0LjQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dj5XG0CGGVMBb61nMXfkA2HbLptGTDlPmBoqfkLRFt4=;
 b=h20RmeBeyJgBHklgTQOPimTnXkSazs8Hnw30alEZx2qa7Cex/tJ6zkaRRcM09kWX02aMJ1PZ+oAhcBijRocCqZdw0/LPp0KMXusdVhrqjA2LHigqNmlTa49QAHIJAZiz93HRKCp5mWiuC8qEK6QBKCSXEcLrRQ5fOHcDumVnNVY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by MW4PR12MB7360.namprd12.prod.outlook.com (2603:10b6:303:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 15:50:34 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 15:50:34 +0000
Message-ID: <4fe0604c-94c7-48d2-b187-914c5d97d62a@amd.com>
Date: Tue, 3 Nov 2026 09:50:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] AMD IOMMU NULL pointer dereference during boot with
 v7.4-rc1
Content-Language: en-US
To: Jean-Christophe Guillain <jean-christophe@guillain.net>,
 Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com
References: <97e7c46b2c3b8a0af2a458649349798c4ecc55ff.camel@guillain.net>
 <aa03a31a5d700da89d2d20ce92a16c9629d20702.camel@guillain.net>
 <6a3cf464-6c1b-460a-9ee5-5468ded48e0a@amd.com>
 <18bf71fb-df45-478b-a625-2f6dffef47e7@amd.com>
 <11464974726ebbb4b24c1c0ae0eae8d536f60b71.camel@guillain.net>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <11464974726ebbb4b24c1c0ae0eae8d536f60b71.camel@guillain.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0139.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::25) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|MW4PR12MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d07dc22-2fde-4867-4ccc-08df39c23233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|261026140227099003|261028144727099003|261102123227099003|261021121427099003|261021123027099003|261022075727099003|56012099006|4143699003|261022105027099003|3023799007|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CErg93vwGh69Xg7dbCdrJCncUrGTBAJQJwMHZXRMGn3Y2NNdZipGY7NE0PB/ZIStqqpKnD6/YjqcMQFquLf0TBWNqv9FdSz6SXcWvIvHsNoqeyhoGuE5RZmeBIWc6kYUjLWEl1wBAVzwEbMGOZMH5p4VXCpSBZAUNcw5mtXnMulbjQyift018ANqL8coRPGfq65KEnyX1q65SvnUV2vc0WFpbAWrg/KRqnG2ncyJrU5Ep0Y+DQ3PaJZW08X5CUu99wpn4Q0tOlTiVuXhnT+ftWAKHze/z5cYgYiBUaqc1CP3FOYm/RxRIrddI2GSgQu6B3DF4dw1+G9+gQq/SPIan7sLhd9zCQdlu5L6yq+EduMz2fvxjC+5Laa8E+e1dqPQNr+SAHRjRayyI7MTsdD9xyS1xi2YuUeyJjPpmWsCf8Vn9kEvcp7IkJ3KwjDBZMqrSRwCyDK+eWyQkipz6yIKrE6jq4PnhXdLtwJJZmP5150AXxgPwbTVf3Ur4Xc+2RHsniiO8TRhlpyhE8FEPKTaBoCJRD4egEY1+2a8hTuNeNtymx+sqjKN+uTd/9wi2ikVALHcHIU8uchkWmrLEpm0mNtYlPeXi+fmX7RY7GQl8lOm1yCy/SQbIULnN7TvT1zWVu8gvibPv3T02n0Kf+9wCLnXeY5Ka2c4YlEJkgYIpM8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261026140227099003)(261028144727099003)(261102123227099003)(261021121427099003)(261021123027099003)(261022075727099003)(56012099006)(4143699003)(261022105027099003)(3023799007)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUxlSnJzeGdmclNiU1NvTEpGanFla3RrVzlLcEZRNXNOSm1MNXd3RzRwN0dn?=
 =?utf-8?B?VTF1ZlhkSy9nUjNJUW15UmpUbVRWZjJyYWNHSGVFWUtPSThQNkhISWp0NEhH?=
 =?utf-8?B?V3ZRb015QUFIYVBVdkxjdVZTNkNJY3NCR2w0VUpqTWlxbnRXNjNkbnJENkxS?=
 =?utf-8?B?SjdwTUZ6bmdXSk43eXdMMm1NbE9qY1VDc1diU21waE8yZUhHcGRoQmc3OHRD?=
 =?utf-8?B?RGpiRlRDR0IrYTFOMEJTZnFhMUVjdkhaMm5MYUNLdjZaUkVCZjFzR3cxSFNw?=
 =?utf-8?B?NEhyVHNUWVpQVmxEbnpsczNqSVNkdkVTWGFrM1ZFZURCR0pNRHkzZXFEMUdr?=
 =?utf-8?B?WHNyZmkwKzhTb25yZkY0eE5sUVRIYjNuQkIvMlZicHV2KzhRckx5NWhuc2Nr?=
 =?utf-8?B?cW40aGo4VXFha2xaTExBK3c1YlV5UHgrK2F6L2d1b0p0NGVFQ0ZiLzN2aFZq?=
 =?utf-8?B?NjZkL3NLWVd4WWxQQkxhYWZNSXJBam1HV0JLRmhGWTY4SHNTbFB3M3dqdjVx?=
 =?utf-8?B?aTJlRzY5UTNubjMyMGpCaFZSY093bzV3Z3NqWVdRYVgyWmhHWmd3MU9DTmdG?=
 =?utf-8?B?a09DdVhKd05xVTEvTjdMTUxBUHczaGZaMW9maXpsN2pZZU5IUEozam5GYm8w?=
 =?utf-8?B?aGZuc1FSQTNSM0JqdzdWNGkvRm9IK1dkZ3VoNGFucmc5b2JpaXh4a0p5MGxk?=
 =?utf-8?B?d2pXSnpaYWtzYTRPRTlENlRIQTVtRWdsVGxFUmVrS1RsYjdnS1pVZXR5b3dO?=
 =?utf-8?B?NlIrQ1h5RnVOMG16K2hRMlJyN0UvY2tja2ZVbEJCR3hWbm9OODBsci9VTFlX?=
 =?utf-8?B?MlR6NnNhTi94UUUwK0lGL3ZiQ0NoWVEyUWVydmFKQTBPcVBwOXZMZGo2OWVG?=
 =?utf-8?B?NnAvRHc5b1F4b3ltY3VVRkZCR3NWUTFvRGJHMlpGT3o3UzZvc1Bidi96dVp6?=
 =?utf-8?B?UStPTVFaSnVXUGo2L1VqWDROV2I3TklxL0xSVEpGU0tyNTVTbjZyOSt6TVR4?=
 =?utf-8?B?dExUNngrS2duTTlTMG5GOWx1UzJqNmdjUFZEUkNPWFJCVk9vVmEwWThUeDZj?=
 =?utf-8?B?dVdDbW1EUmdQdC9LNXpWTnpXUW4wT29kWVBlQzZSZkc1OU9rUXlZMUQwbExS?=
 =?utf-8?B?Mjk5L1FFUXY4eUVYVVhZWXV6QVJBR3JsNjliUXRobWZlbG5IRUxHUVprb3lj?=
 =?utf-8?B?RUs0d2ZWaFVDZXVYdmo4SjlKRVRxQktVTVpzSU92TmduMW5PaEFPSEtIQmRY?=
 =?utf-8?B?M01QbnZxZE1zZ0lPOEx1emJLamhsU3FQdnRzOVpSOXF0V3RSbWozWmZ0UFRX?=
 =?utf-8?B?RDVucDZGTlorRWpvZ1ErVFEya3ordi9QN0RDOFJDZDluYkQwbDZzMUNqWDhZ?=
 =?utf-8?B?UXcyQ3o5MERLL0xMNlhjTjIzZ1hoQWhMTjk1a01WeWFaajYyRi9RdjVPYnRF?=
 =?utf-8?B?bUVxTHdGMm05RFJlS0EvdktMaENXOE1EamgrZnVZU1RyeFlJdmtlRGQ5bkJ3?=
 =?utf-8?B?dDFKUXFnbGJLVWNISnpyaC9iSm16blk4QlBPZ2h0cUkxWWZnRFhMb0JxM2RU?=
 =?utf-8?B?cUhqTkN1SmxCQm1XZEVaYnllalU2dWFtWGZtRk13TThvQ2dybThOVGFJajVo?=
 =?utf-8?B?MzhNeFdrRUtDR3B4aTJJNkZ6M2UvaEdKMmNXQXFEblUzQUN3ZFR2NDNBYnl0?=
 =?utf-8?B?eW9sRS9yRlZoOENKbUZ0NHBUVGVrU0tGc2F3TjFOM1RSWFloWjNYTDJFd09o?=
 =?utf-8?B?TWtNcDRjSHRQQVNpQzlnU1lIZEFjR0p5bVAvRUs4cXFHRmVvYUFCcGNIWDFa?=
 =?utf-8?B?QWJUalNKR0ZBbWZPQWNlMDM4YzEwb1ExNWxGNFp5dmhvSlR4NE1DUldWV2Zv?=
 =?utf-8?B?TWRHQ1B2aXMrSmsxWVE0RHVObE5peU10SkRMNWZ0eU9PZUFiNXc5U1ZCZ1VC?=
 =?utf-8?B?ZnFROSt5S0d0dm9mWEhSekFGMFY5RTB3SkduSitKRVdqTE5WeEZxSmkwcFZn?=
 =?utf-8?B?akhPSGFUc1VXVjBZRXdoUU9LK2VxYVQvaHEvclJydzdDZDVGZTVSMlRKdisy?=
 =?utf-8?B?UlJrZVhuQ2Z2TnpjeG5iWFJlbWVLVlNsRSs0MHNodTJBNGhZdzdnamFabVNz?=
 =?utf-8?B?NEp3MUJkSlErQ3NxczlISHNQbjR0NGRXakZwMFYwbGhWS3dzUVNqdEIyRWc5?=
 =?utf-8?B?QzBubmV4VG91Y28vMm52MmVnTCtjV3JHbjVvZnRYbGZxdnl2Vjh2cmMyNHhl?=
 =?utf-8?B?VUxiTVNzZDYvMGd1RnR0Vmt5ZHpnMnhvMWxNQjMxVUlXNDFMRlN2UzVyVFNB?=
 =?utf-8?B?aldsVHErN3kwMm9yV2Zld1dCRk96SVpOMHdGazRySTZLVExtV2swUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d07dc22-2fde-4867-4ccc-08df39c23233
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 15:50:34.0565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSkRVCIqQeJLLCpzV76MSkUYsCNHuvhT9Yf+LKPjrvkB2YkPqQdZ59z8miTHf8hvz7+1MdvmGQHhhVx7B8nsKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7360



On 11/3/26 09:24, Jean-Christophe Guillain wrote:
> Hi Mario
> 
>> Can you please also share output for:
>>
>> ╰─❯ lspci -nnttv
>>
>> This is a surprising combination to me too.
> 
> Sure !
> 
> $ lspci -nnttv
> -[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Processor Root Complex [1022:1576]
>             +-00.2  Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) I/O Memory Management Unit [1022:1577]
>             +-01.0  Advanced Micro Devices, Inc. [AMD/ATI] Wani [Radeon
> R5/R6/R7 Graphics] [1002:9874]
>             +-01.1  Advanced Micro Devices, Inc. [AMD/ATI] Kabini
> HDMI/DP Audio [1002:9840]
>             +-02.0  Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Host Bridge [1022:157b]
>             +-02.1-[01]----00.0  Shenzhen Unionmemory Information System
> Ltd. NVMe 256G SSD device [1cc4:17ab]
>             +-02.2-[02]----00.0  Realtek Semiconductor Co., Ltd.
> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168]
>             +-03.0  Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Host Bridge [1022:157b]
>             +-08.0  Advanced Micro Devices, Inc. [AMD] Carrizo Platform
> Security Processor [1022:1578]
>             +-09.0  Advanced Micro Devices, Inc. [AMD] Carrizo Audio
> Dummy Host Bridge [1022:157d]
>             +-09.2  Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Audio Controller [1022:157a]
>             +-10.0  Advanced Micro Devices, Inc. [AMD] FCH USB XHCI
> Controller [1022:7914]
>             +-11.0  Advanced Micro Devices, Inc. [AMD] FCH SATA
> Controller [AHCI mode] [1022:7901]
>             +-12.0  Advanced Micro Devices, Inc. [AMD] FCH USB EHCI
> Controller [1022:7908]
>             +-14.0  Advanced Micro Devices, Inc. [AMD] FCH SMBus
> Controller [1022:790b]
>             +-14.3  Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge
> [1022:790e]
>             +-18.0  Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Processor Function 0 [1022:1570]
>             +-18.1  Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Processor Function 1 [1022:1571]
>             +-18.2  Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Processor Function 2 [1022:1572]
>             +-18.3  Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Processor Function 3 [1022:1573]
>             +-18.4  Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Processor Function 4 [1022:1574]
>             \-18.5  Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Processor Function 5 [1022:1575]
> 
> Cheers !
> Jean-Christophe Guillain

Thanks for sharing.  I think your patch makes sense.  I didn't realize 
this was how older hardware was laid out.
