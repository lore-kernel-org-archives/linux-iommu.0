Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFD881B
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 09:16:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQ7dGY4rqNdtpqN5Wu69Pirkh6Ld0qtTWUM3XvliduT3yFG1XQ60NGMNO4ZLe+1WQ8Qi6QmKcYc06UsmeEe8NCpFX6grY7//g2BVbkPmlnI5XbcEHvuarAyEf0sdiWrsAO2EHi1JpQwPC2aaih9ZjR/4UuksTgmEmxb/0mA9NHJX5wXLN0UysQY6tNSdhDFCsRRjCG63YpoKkSUGGbXxaAh+3lENYi3U91Snkie5fV3ulp2Ph49GLldAQ3hd5u3Ej4qHqqJrckBX/BKBkEQb9x5Iz1YLDUleX00uipe7P+OUESFJAFhxX5Apya+aZCrWk9daFhcGbLgW3PXLQtpfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWbnqtAwRV6xA+9yu8kXs+iHhpVMHtKwGIxdGUs0xYc=;
 b=CSI9hC5YDGt3bdRQoC2HfzmJKqpd/AlFiYkiQZ8nd6wycGFXUWwlyjh7Hl1AYb5faiLILyQ30rrdAMlRtbWV+ZYrOK2lmdPvZoe+C3OVtqsiFpwAOpq8LjXw2LSY5pOXcTxA0f8uRdj+b2q9mvWaYGyIjw9Dt/sDehm56VE64EvWWfziJUgtK+IubPMFSWOtAYpdtMC3zMaNzqsTUhtaWb5/TuiI7QXe+VV8TSUQP1XxZLNAOfoawhGwxR0l6+ZdW6TLI2kkaZO9F1rQriL9iLW1M2GzBCipCyetgmuGK3s20H6eGululCzMyoZVWZV95qdsln2Wo+iL3ZUhAMIfTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWbnqtAwRV6xA+9yu8kXs+iHhpVMHtKwGIxdGUs0xYc=;
 b=BjN4xopRgI7QwARU/ocuhakNqPKON76ahHyzsZJ37Qn/fA3S91tRE1oOmbrjEIEr3GuWCLn7C723LdIsAP7hF3KwrN52YqWqFKD+N+HpsTjtY93QA4R05x6tfIuG9PPGxrE2OUiCrSiqEJrSu+08SGWJcF8WjIpGhvtQvY7T1zY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ0PR12MB8616.namprd12.prod.outlook.com (2603:10b6:a03:485::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 09:16:01 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 09:16:00 +0000
Message-ID: <e7536a2c-1ea9-9ff7-8a5e-7a061429556c@amd.com>
Date: Mon, 31 Jul 2023 14:45:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 11/16] iommu/amd: Rename ats related variables
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-12-vasant.hegde@amd.com> <ZMPQR+Cx3q5jf04X@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZMPQR+Cx3q5jf04X@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::27) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ0PR12MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ffc560-cfaa-4a0c-1d73-08db91a6c15b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OusyhR3ylWtJDCPKXVDUj3dtZpUtjjz5X1xGwfgy52P1TyGduhqIo2tpq65ECadNZqSK5F5m6c/Q5kEhCxEWAzbEpMsEUZIQQoKC4kYMun56m3bjK45f0vXFw9Fvk1XMoY3JnAXnU/jvedcqq4drpGZpRwI/6+tPQDAZA88/1yg0yrlhXMe6qPtq3ocs64ycp+i/8Pegwl31slU7ARKWcddXb7JpkO9c8UrwePdc0V3vINYAJ5uKgl7bf0laYUtOn+5I5bQaXhpnFDrutkLkGyZV9n941Uy+ZeyJaxGLd3mPMGZ2bNHbDsKFeqROAHU1IrNQ8bGJ3lnnOz4/7ZbJA7FfIXYGZm00NL2pPof87GcjpFK3fXHo+dhqCmOdom8lBkz0AXPUtoqYl+cQ9LoYHKVGHhMP+CIzmMtt5zh1glsz7SbrLrfA5LbTNIclg8bnQmxgZUK399sKF4EYe8YF7f5qXhJ18bgPmJB9yAg1lfZj/NyONPIOtGqDJkpOCfFt/5K52GOtZpJa5doJ7aYizuiawBx60ylRx91xg0M3iQAR3nGXe8+fXfmuOikubAfeNQBIE6105/5VYCl55E8Zu6POaWhCeBf5Kt6KVsV+eYSbEP6Q7N9eFssBy56GbChUTgD6cFAX5+J8Ro1/CcneSA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199021)(31686004)(2616005)(5660300002)(38100700002)(2906002)(36756003)(26005)(44832011)(83380400001)(478600001)(316002)(8676002)(186003)(6506007)(53546011)(8936002)(41300700001)(6512007)(6666004)(6486002)(31696002)(86362001)(4326008)(6916009)(66476007)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3daeHY1NjVhbnUrMEQ5M3NPT3BkZkpCUjcyNFp6YmJvQXZnV1NCQW9QWUVv?=
 =?utf-8?B?bnRXWDZ2WFpHZzEvSzVkNWFDeVNDUkdSUkk1RkZteklhMkxSTEFmTjZWWkJB?=
 =?utf-8?B?ek15Q2NKWUkrZFVZQkN5SUgzUVVkcUdyV3NJK0pWaFVrYWFkOWpkSzFOeTFU?=
 =?utf-8?B?czB4THBSUTgxSG5hZWtSMytXQ1dtSFZlVDQ2cE1KZzZXVUxQa0VLQTJ2a3pU?=
 =?utf-8?B?NEhKY1VMZGc5dElRcmE5eStTZ3pJakk4R2ZlY0Vnd3c4UVBqUjRzSTU3Z3FZ?=
 =?utf-8?B?Y2hEK0lCcDlZakdMSk5va29hMk1yOVZpS1hhVXRpRk0rc2dlZ2V2ekZudEpP?=
 =?utf-8?B?cGtaUDNYY213UXhDTld4RjREMFZod3FNTkhBK3BBRGt2YXdIcXJRazJOR1g0?=
 =?utf-8?B?bENIbWMzWHpyYzlxbjUrUUFsQkdlUkl5WFFOcSsvNjVrTFg4Qkg2K2NwS1c0?=
 =?utf-8?B?NlVldzZqNEV6WjYyZnhLbWgzWVp3SkRuZ0VvMnlRTnViZEZTejEyZHAxK3pO?=
 =?utf-8?B?UjNmY0xIem9HYUpsYmEwRFA5TXVmVE90L2dyM2s1UWVNVHQ5VGRJSVJReXJR?=
 =?utf-8?B?ZmVNT0cvSm1ObUpOc2xaZVU3ZDk3WVZkKzJ4K2RWSlFmQk5GcjNFR1I0Zkcz?=
 =?utf-8?B?MGdHSEwvOWlIWDhJV3gwVHNUZmttTC9uVUh2M1FYMlQzZVdLUmVPV2lIRWRR?=
 =?utf-8?B?VU43aUh1bmxUajZwZGFUQTVQNVA0Z2VOLzNMV0xHeGVHZUtrc1ZGR2F4Q1Qy?=
 =?utf-8?B?NWZYRjNmaVAzWTVPaU41RzFIN1lFcVZJblRSU1FERENRV1hNRWFqWFdIb1BX?=
 =?utf-8?B?blVEYllJNEIxSjBLS3VCNXgrRWpCbEF5QzRTZnRzOHpBSjVIYnAvMzZJVm4r?=
 =?utf-8?B?VTVzaVhVV0JRN1ZHcTN6N0pYRXREZDdSOFlSR1lKM1ZSN3R6bmZyY3M4RFdH?=
 =?utf-8?B?bE83VFJVTUJaQTF1eHJrR0M3bjBubGEvZ25rVytZa3Q0Q0Fza0xwSVZwVmVL?=
 =?utf-8?B?S0ZsM0FBa1ZsTjJEemFkK2tUaVY4MkxXblBmYmV6UlppZVNFK2twQ0xVeGdK?=
 =?utf-8?B?QUh3OXBCUXNSRjBsNldLcmU0WndURWc1RmMwY0R1VmNGem1laDA3UXBrYk5m?=
 =?utf-8?B?bEt1dnVFKy9IM1pya05tTm5sbzhnWWdhRTdOc015bmhKajlVZ0lqQWc2Y2FQ?=
 =?utf-8?B?N1NVV2lOOTAzbEZOSGQvbks5NjhkNmZXMVZwKy8zWEg1bEppczlnaCtrdVFJ?=
 =?utf-8?B?UTd1MXBwV3pIWHcxU1ZidjNvQ3NxTm9HV0JNdk5ZK1JxQVhRRlBFTDRnc1VZ?=
 =?utf-8?B?T28wbzlmb25SdjkrdVJBMkRycitoQWEvNUx3NzF1RjVyTzNlZHZUM0pNZG1Q?=
 =?utf-8?B?em1OUVRxSTgyd2xGQ2xQYm56SSs4aVU1UGRyTGlDOTlEYUhWc01uM0JLcUNR?=
 =?utf-8?B?d0FPVndNUE1ETy94bGkwNlNRYmRMU2xHQ1F6eFNXV2t0Mm93RW9JSGN2WDc0?=
 =?utf-8?B?WWdCakZ6NFk4U0pRRU0zOFJEeG1vTmk4ZG04Rk83OHZPaGk4SHgvMEFXZE9r?=
 =?utf-8?B?QXpyQmJqaVBtd3FIb1pwVVBhbUtpWU03a1hYZzRvOGhmUUh3T203VkkvbGxB?=
 =?utf-8?B?TjY3NFFRRk94RHFhZStJaGwyN1V5WkM4dG93aTNEY3Ntc3RtQ3F1MW9OYjZ4?=
 =?utf-8?B?R2dJZ1hJTGdTMVUwSTNJTFRTa0xMcm5zNkhFL0tnVmFjL3Nzc1VUM0p3VzJC?=
 =?utf-8?B?NTZYajkzaHhZdThkbk1HSFVUM1VMWElERVp6RVNBQ2RUOTJoSm0xWTlCbm5K?=
 =?utf-8?B?UTNZVjBjVFZZVzU4VmRkdDlCeGk2VUVxQk9CemppK2tFQjRaVGxwS3NRc0o0?=
 =?utf-8?B?Y2ZPOUNPZ09qZHBJaFNUc1czbS85cTJPdDVBRGxIRUtTVUtuWUI1NGMzSXZK?=
 =?utf-8?B?eEVUSDJHNW9CQWJQVzZVQnZrK3Mwa2EwV0RpWC9MVnFzZllReHZXL1pXc005?=
 =?utf-8?B?ZlpLN3d2S1V2eW9UOSs0VUtVY3BtSXRKZmhXemNPZU5EN3F6QzBzSkhRMGFM?=
 =?utf-8?B?cXQvTWpicGlpais1N0pkUlZMa2JkN3Y4cFdKcktiYzgraWVHMGpnUElrdDIv?=
 =?utf-8?Q?hdofY/juZdEPr3uD7oVzNNBZx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ffc560-cfaa-4a0c-1d73-08db91a6c15b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:16:00.1534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbM9Vwi85yNEJ7X7FyB9wsbEC+UPuzvP8AKXYlhipSKbnGqdA2lAqPDL1SyDjLjaHYb+nnLdrVWEry8MYjBODw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8616

Hi Jason,

On 7/28/2023 7:57 PM, Jason Gunthorpe wrote:
> On Fri, Jul 28, 2023 at 05:36:04AM +0000, Vasant Hegde wrote:
>> Remove nested structure and make it as 'ats_{enable/qdep}'.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu_types.h |  6 ++----
>>  drivers/iommu/amd/iommu.c           | 26 +++++++++++++-------------
>>  2 files changed, 15 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index bbb5ac4f0d39..a066f375ba87 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -816,10 +816,8 @@ struct iommu_dev_data {
>>  	struct device *dev;
>>  	u16 devid;			  /* PCI Device ID */
>>  	bool iommu_v2;			  /* Device can make use of IOMMUv2 */
>> -	struct {
>> -		bool enabled;
>> -		int qdep;
>> -	} ats;				  /* ATS state */
>> +	int  ats_qdep;
>> +	bool ats_enabled;		  /* ATS state */
>>  	bool pri_tlp;			  /* PASID TLB required for
>>  					     PPR completions */
>>  	bool use_vapic;			  /* Enable device to use vapic mode */
> 
> Linus does not like lists of bools like this, you should try to write
> it as
> 
> u8 ats_enabled:1;
> u8 pri_tlp:1;\

Ack. Will fix it in next version.

Thanks
-Vasant

> 
> etc
> 
> Otherwise it looks good
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason

