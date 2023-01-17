Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DC51851
	for <iommu@lists.linux.dev>; Tue, 17 Jan 2023 04:22:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwpBxYdmDy1ET6TZ31SkLQxsnRvA8bVDb6Ymm3++Ub3Nrgs8EVtKpxR6xek/LZUZqk3C+K9picr1p4Kbk9pB7RvNO5dS3RXpzYN+ZWnQ0Z1dw1fGgopf9n4/QRVRO8Wx4o0hTQ0nfcZ6JB1VPF/znbYEqsRwmhnp5jBLrDtOozLILJhF0SsNtpa//zLW4HoYGEtZfNdF01x9qoXpoEq7/ATTn+/m6Ef7Cqz0UsC9G7qeDJVo8C2qPwN/N46LQoXu6vIvDAqZ6sHecPmB508xv7VUnV0H7ZHdGUxB4hcvN5icSn8poa31d8jFI5g1XCS6x/zEzrANbqKV0giiuaeMCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZfdZdXnwxc4n5KMJQjlbmwMCVM6LC1kIfGyLXc46dc=;
 b=Gz/akcY4j7UZEuuV8BdYvXxsVeVvkA9j0puF4om0rJS+Qouypouhhmjq6xYqCchMsCksP7z5K1mGs8nPVcT9uEULAgbQSwPAH8BAxQc5ZgSxv6QGqw7E3M8KZXUcZJhR9aZTU02eVzvZgexwgYRCk6y8JAKRIXmLp2aE+AIRsTU3AaP4rjL7SKrY9aXVzkVFFnIet/rFPAHcvNfEGS1i229/P+AblKbRY7308FgJUp2NG5N1c+99bYpeXRXGZ42BtBGH2OHKbJj4ZJ2BLmXQ/z+xGLwwACLijzKlzjCmeeUJZEhXTxQi/mx9kJPcNJI0FiZXBY28Le9Lo/c1ouwS1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZfdZdXnwxc4n5KMJQjlbmwMCVM6LC1kIfGyLXc46dc=;
 b=wdGdxV0v8Jn8SVn1HmwDpN9nIOKG0i/l4gQcsebk5Yds66ESsozOsPCYV684U32rNL2PtMio/BMPhODkXPEA2WqnXZeVmkuyip+bC9ONhjM7rCrVQgeZjJMKSg8/N8uaNo26BaK+td+6zVaBGgo3eyvPOOdX+4w3EbeGXHFi0us=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Tue, 17 Jan 2023 04:22:30 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6%4]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 04:22:30 +0000
Message-ID: <adc21751-4241-8e41-d730-69921f84a2e8@amd.com>
Date: Tue, 17 Jan 2023 09:52:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu/amd: Do not clear event/ppr log buffer when snp is
 enabled
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
 Tom Lendacky <thomas.lendacky@amd.com>
References: <20230105091804.42506-1-vasant.hegde@amd.com>
 <Y8F+Z6EIwkEsAk6P@8bytes.org>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <Y8F+Z6EIwkEsAk6P@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::13) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY8PR12MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: 9131a344-b558-4695-b48e-08daf8427221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bURHXGayNDomGbW2NgFo9nTyRVu0fbwDS7Zt7B26XuDfxQmRn7vXmgmUf0kV7Omu5yDnI/veQ6ndh0Tkb98MfxwqksMYxOadhhGqYkIUutIoBbVGieWc0g8jRt3lbGwz4JM2BAvNqMkRcJpACLaniJ6r1JQZMQLI5weMEbYLeAoqDTnMmE5BSUijLfrDy+67cD0nQCJJD2bMjb8yZVx8T3FQg/z7QIjkXSOOgiOe22+nRFP1FavIWHhi2d5ZEHrCQ8Zu71XxD5F2iIjqZge6HbUIx7HcyPD+BvYWj2Z7HtPqPTJ7CgA72naP41kC3AEk27D/a+dVpJBhnOqXyubyOOx9upeWMQQTDufRtMFpTnfxJcSUvccDgQk8oYBeZFMZ9DJbDcyH/7Gv5YaM/yhhRFt8X+cSo8Mcnklm1BD/NkcKvNm9OCBZsSJlSgGuS4U4k6SPLG/1MNwc8rrvykPnMLsMRdjgN6pSpSMpJpwx/foEHb26LCWohbHHIS/XpnTSQAjwnAc1iNVLQr/1koCwmBkIhmoHDPllwVm9P0OKfrnDC73Wp82/dNs1IK8N82M+WptNONgN3kD+aPcXXHHp5XOkvA5zBMuKh6uvdcnpR8nPXDX3viY+UH7+dec5Ot+gRzstJgP0fv8r2oPn/cgY5zfvm859N5z5t9X1cDIuy+wCGAyeaavQBVrJywdDU5q3hf4jU1K1GlS7rVuFtRgq8PM4fRk5eow7GWDF5pjZlxQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199015)(478600001)(38100700002)(6486002)(6666004)(6506007)(31686004)(316002)(8936002)(53546011)(6916009)(26005)(66476007)(186003)(66556008)(4326008)(66946007)(8676002)(6512007)(31696002)(36756003)(2616005)(83380400001)(2906002)(5660300002)(86362001)(41300700001)(44832011)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVlMY05QNDJxMkFiQzE5VUI0Q2Vqa3FHSTBOVEp0QUVINEFLMTlIV0lxd0Iv?=
 =?utf-8?B?eWFrdGZ1a1Jpdm53aTJjTHk2QmtlZ3NtSU83ME10bVRFaC82RmtzZUl1R0Y4?=
 =?utf-8?B?ZlFpd3RPb21Kb0RhRmx6ZStIRjBvVjlnWkhSQ1o5Y21HcWkzUk42MVBEOUtK?=
 =?utf-8?B?ZnRoMG91SzF5L0RwUGxZeVh5RGYzZTFTZjNxMmlLaEQxb2t2RUJxa0c3TGlw?=
 =?utf-8?B?YUZEYzlJOVFPRlRTOWFKaU0raDc4cEk1QUQzSWt0eGpNUmZKRjUxSnV2SVFh?=
 =?utf-8?B?cTRmaDlnMEJZK3M5NFNSSnBkaGZMekhhdmVaV3lHV0o0djZRR1g1VlpkVGdv?=
 =?utf-8?B?d2pkMldweHZHWFQ4cDB0Rkt5RFphVXNHaGlJOVoyUXhmdGcvT09jL0pBZXd0?=
 =?utf-8?B?M0loR0dibkRxVVNsdXhpQnRlYVpLdnRaTG1rMmVRdVN4V0F2NWxCZlRzU3V2?=
 =?utf-8?B?TTRHdVMrN05vNTcyNlpxY2xRanVxajQwTTZEWjZEL1ZBbkVBdUNnNGVwSXFm?=
 =?utf-8?B?UTlVWkF1SVVZWlJyQXFHazNoSmdHaEg4UEtGT0liWFhIc0FwbUxyVVdDSkFr?=
 =?utf-8?B?RExBRUJjNnVWNmtQYno1cExvdkZvVnVzdEg4bTJTSFJKZG1hMW1LZ1o0ejRp?=
 =?utf-8?B?cjNYblhBTjV5NUxEYUI5RVd5dXBVeUZXSEUyaXFyUk5JRG9LckJZb3ZibUI0?=
 =?utf-8?B?dzI0cTZJbHptaVNpRkNoZFJWdzRITCtmRFRmTWhTSXdMSjRoR1NmWGpMMVpJ?=
 =?utf-8?B?bmk2a1c2aGprMEI5Wmo4d1BObjdadmpPaTdkTWp3SzVCQ0t3NEhraSt2VHky?=
 =?utf-8?B?cERJSi9HRjhUdGlJYUU1OWd4R2hPb0x3Y0FPRDUxSGZzZ1RnZXFDNjJVeTRN?=
 =?utf-8?B?bnJreGlWQVJWR3JzbGZDcVhaU0pyOC8rdXY5c2hOQ2c0dE1xYThxRm9vZTMz?=
 =?utf-8?B?Y2gyeHc2S1RSMkZUbFVoM2sxVkw3VU1aL3JaRkh0a0pPV2Fub2ZqRTJxd2Uz?=
 =?utf-8?B?b21CcEIwWFVuTEQ0T1hqUmJCUWNqdDVjdmZIOXBCclBqWnFnTmdmd09hTVpi?=
 =?utf-8?B?bnA0R0lRNzJWUW9sMEJwOUNXbk82cE5BbU9oSmIzMUJYdGFPbGUvdlRaekY4?=
 =?utf-8?B?TTBLTFBxaGU1RkZVenRBZjBSak15d0t2V0luMlR0cWN3WmJoLzlTeXVNcGRT?=
 =?utf-8?B?NHNsTVRWMlNvVHc3aURrRmZWZVFYVmdxTEJzSWFaVGZVVi9zY2QxV2swMG9t?=
 =?utf-8?B?eU9nMlAyOERMNXpQbzZMNElPZWxGOXJDNWVlTDJSVEprRWFRRVhZUVllWXZ4?=
 =?utf-8?B?Y0N3MCtrb3hJZGx6MCtHYURwRXlQdWtSSGlDKzNUaUpRbW5Wa1MzRVV2OE9J?=
 =?utf-8?B?WXR3SWptcDhDdmxVWkN4VFAwb1ZmYXFQQ2hwdEZlVXlCM2JoU3NGT3F5ZTJj?=
 =?utf-8?B?MEtwZ2draXplZEl4RFROcFBTUHYwVE1ueGlEenU5MWtzVzRzNVdPMEk3aUhx?=
 =?utf-8?B?b1ZhN3ljNWg2eEhnYWNuZXpHeXg2b0wrakk1WnBZNWV5eXlyT21TdGR1T3l4?=
 =?utf-8?B?MGdCZWorRUl3bW1ZNDNoeTVYQTdlZnlMWUVxVlk3ZGJ4dGpWQ1BWblR1Sjdt?=
 =?utf-8?B?OGFtL2hrMk5WYTZ0M2Z3QVp2YWNmalFTT1RjdWhCQnIvckZmc1hiSTh0QTZv?=
 =?utf-8?B?VzEyb05jSXlVRXhMY052azkzblhvWUhLQStVNS9nYVk5TFFJNDVTSHBJcm9y?=
 =?utf-8?B?a2lVSlhmVDBVby9QY3Ewckt6eGJZT0wwYnZMN2hsYmlVdUUybEVVYkpMSjRY?=
 =?utf-8?B?bEY1YUliWW9jTEZJek94TUI4WTczZU9MbXFMQkF2NTR6dlQrb0wzQndCZ1pq?=
 =?utf-8?B?VVB1UGsxS0lidTJCb0NmL3RyNjI2UGZhZThPUUQ0NHZCZGFTMXVydkcvaExO?=
 =?utf-8?B?ODNVenk4RG9rc1hKR2FFNXZJK3g3ZmhheVlzdGRRb3R6emRKVk5kK29NemI1?=
 =?utf-8?B?bmFaSWJBMWpXNXpYQnBKT0tmRGVJT09zRTM4TjUxVll2N2gzTTdyUkJkeDMz?=
 =?utf-8?B?R3p1bEtEWjVhUzBhYmo5RWRtckxrZ0c1TVJkMnJDV2ZJRGRQN0RHYk9Yb05P?=
 =?utf-8?Q?bGZ01EqstME15FzOnbXBSzXX/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9131a344-b558-4695-b48e-08daf8427221
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 04:22:29.6282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5/nPLcp7p6COIBhojPQ0g+TpF5ucCTl7Y0N9Io7Mxg1fkXPz7R0YXERTfjN1TaxFzPK8Q09wF5mHh4NMo8ihw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244

Joerg,


On 1/13/2023 9:23 PM, Joerg Roedel wrote:
> On Thu, Jan 05, 2023 at 09:18:04AM +0000, Vasant Hegde wrote:
>> -	memset(__evt, 0, 4 * sizeof(u32));
>> +	if (!amd_iommu_snp_en) {
>> +		/*
>> +		 * To detect the hardware errata 732 we need to clear the
>> +		 * entry back to zero.
>> +		 */
>> +		memset(__evt, 0, 4 * sizeof(u32));
>> +	}
> 
> This needs a comment that the buffers are not writeable with SNP
> enabled.

Sure. I will expand above comment and will post v2.


> 
>>  }
>>  
>>  static void iommu_poll_events(struct amd_iommu *iommu)
>> @@ -736,10 +742,11 @@ static void iommu_poll_ppr_log(struct amd_iommu *iommu)
>>  		entry[1] = raw[1];
>>  
>>  		/*
>> -		 * To detect the hardware bug we need to clear the entry
>> -		 * back to zero.
>> +		 * To detect the hardware errata 733 we need to clear the
>> +		 * entry back to zero.
>>  		 */
>> -		raw[0] = raw[1] = 0UL;
>> +		if (!amd_iommu_snp_en)
>> +			raw[0] = raw[1] = 0UL;
> 
> Same here.

Sure.

-Vasant
