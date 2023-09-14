Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F47510A0B
	for <iommu@lists.linux.dev>; Thu, 14 Sep 2023 08:24:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEMBVYJqb1puhdMtvOFkkhRmmsX6xEGBXuPKLYu51b+paoontAuCHUWyHNRo1uu9MLSU/IFHlsalSw0eLWltV8vNh+d8QnjniJULKW1QBk6BReY3Z92p4sQ/5uGUk/qMhoKpjLAzGzQ+UDLcSrl6fwIs0zO8QnOAUmYdaHMPRn+dpUsHwRBDtYK/VqgYiBLvaerF74PFJ/pyUiQg2goGYx8S8A5mIFBpthEqCf9Vxe+H3l5yqrLtTvJ4JjxUBjP2bKdEV07VXu5t5FfRljbywrTS+EQyDk7KnLQqkdKqUYwUFw+SAF7APMh7Hkl6J6VapdToIpXCCjymWesP2JaPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zyunAwAezX2NoQvP/GPj/TMqGUgc7VtAB+2K76evCs=;
 b=kIzm+/GG4mMkhDeVHfaTwQO4KlFWoKDHUjN9oI9LDVTb6f29rUPmbyBfbJXyOkyAkXdJ7ZH0MHrCcU/1fs1wfPFONmV6MCzNiIQTWP63pJ7lsW0mqOlCajpFLzYJvbEEUWcSQC+u/fB77rj9LHvB7KQ0o4PcIy8J/bewJg6/MqNE/7F31D3+a9GDZmqsNrb5Y9g2rzyVPliV/UuH61LrcnQqxxTURqYMEW+LrlBKmB0dxEXFaqPuyJDxb0Z6QW7cItXiC+zPgoAXxihn0kn68Ru6euQJlyCq5F6flpORy/9FScGRJoizV52JEOCRrTy1RS0RfTmImHixmABOXjetRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zyunAwAezX2NoQvP/GPj/TMqGUgc7VtAB+2K76evCs=;
 b=yyBNrW/nmx/gVR3wyU97jHM2muRmlzFFXkraGvZNoVHNHO5OqorT5nruwI6NJlQsxYWTWi8hTxI25pAu454KFIFwD4T4LvIOvZdPorYHH+aCHP5KHAVHOoZZDVEzwQM0Nz+KjvbqHlqXG11KozhkMz/AR2GiSYs6wFTf6CP3YmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CO6PR12MB5410.namprd12.prod.outlook.com (2603:10b6:5:35b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20; Thu, 14 Sep 2023 08:24:38 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763%6]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 08:24:38 +0000
Message-ID: <786bc122-0828-479f-a41b-f6da264b3597@amd.com>
Date: Thu, 14 Sep 2023 13:54:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 04/10] iommu/amd: Introduce per-device GCR3 table
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230816174031.634453-1-vasant.hegde@amd.com>
 <20230816174031.634453-5-vasant.hegde@amd.com> <ZQHKmdp4QWK7ETlZ@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZQHKmdp4QWK7ETlZ@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CO6PR12MB5410:EE_
X-MS-Office365-Filtering-Correlation-Id: d19961fa-7ace-41f0-025d-08dbb4fc0917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rjaPdLc4E3m4tOIG3INwW7bE6eUN3lKkFciIYuywQf9YGhVNKFnuBsJFQQa8Ws/uKS9IAdtW3oJrTVZwTEQkdmUroOrzQMyZWkqnP0U191U/t2V9D9X35O9EU9O9Ald2k6gmyBsY0mPJpemUsxbrt5iyrmq+f6jV27WI232gmmZOJcuA4j3eoUaQzyZXnyY4yMHZEkmywH0uiqCIseFYsLz/FTnFSM6iVdAjXthNLVsrHLwR74gUFvmwsIAoSlzSa09LTfk3b8yHUcJ+isVVn+wQYP/lJHXLuy0LTfpvRUfbc/4JAfa03xWdkPlLUkjpkxxWI7B5i8gjlWRVkEPuCUkdg0Nr7UI4+cJjhunJg4g9SHdej3/d1malnMpETX2OAE5jvmyCaYE72MmHmZ7ngOa7V8MSvuypfkW4l8DNOzqA6UpK35Ef/vATypqHg/T7wfvkg5NP1SDWdq+2kwoMDzDlgZQpHKnFBJmxT3QiDlz1cNCkxqKqJ/3pzaLflH/6BhCpgYm3+5JA1+gKe7RNfuQifAjzVivulWl9irkCHoNb0xj7PK/pj+YHiLsAZw55H2f1wlvMdnRYt6Lz75ptufE7zlUn/B9pAMXVX/Z1Q4vQJ5SnYWBeBFwi37Crzy7ivrXJmrRbY37mxHqBDB/cAA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199024)(186009)(1800799009)(41300700001)(8676002)(4326008)(8936002)(31686004)(66476007)(66946007)(66556008)(44832011)(5660300002)(316002)(6916009)(2906002)(38100700002)(36756003)(53546011)(31696002)(2616005)(26005)(86362001)(478600001)(6512007)(6666004)(6486002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFlndU5qdVNJaDFxSWkxTEFTc3RqMno5MkNNL1lJQVg0bWRjZVRSVWsrY1ZW?=
 =?utf-8?B?bFJmcFlxNXhpZVNaeFJxelZKTmRrd0ZteitWVWpoWmRIbWVxaE5ZNWVpaUFu?=
 =?utf-8?B?U1pveXNNWkdadk5oazkrT3NLOVM0U3Jpb29YemVFV0d0OWRjT0FBeG0zZUZN?=
 =?utf-8?B?REdCbEZBamQyT1U3SGxWczQ4azFhZ0lWc2w1c1pYV3lWZ0d4MXRpSkhnOHNv?=
 =?utf-8?B?cDVPYU1RUnJkVkRYODA2SDVUZER3QW1NQlM4Ym5hSXNWTE9BL1FIaVB1NGRO?=
 =?utf-8?B?ZU5xZVhqTUw5cU9Makk0dmhoY0pPY0R6WEdtVjM4ZVdwcmthcmdsMmYwejZS?=
 =?utf-8?B?SElzbFl3WHJqcmszWm5heFVCVG4wSE0xRWRXcERIeUR0cGs3ai8rd0haSmNn?=
 =?utf-8?B?YXo2bWcxT2thNFF5NTlHTmlnTkVSdVNLRmtkRXUyMlA0M3ZyZlV4NEdMdjVD?=
 =?utf-8?B?d25hWXpRMzhsY291RUxFQ2gzNVRXV3ZKSGVuYjRwZ05GUUpIb3NSZHpoYkZK?=
 =?utf-8?B?TkpnZmRzVEZYR3ZPUlcxTTlYd3JLZU1YdXk2cnpLQXNKb3hLQWJZWkg2YUVs?=
 =?utf-8?B?M1k1N0hqNkZ0V1dkUmM2UU1GMkxaOWxFYnduTzZVODM1NEd3SDlBZGRSaFo2?=
 =?utf-8?B?Z3VLS0VIQjdXUFVrQmVKT29SR1hNdzhBV01XdHpLYlFCbFNsb1NZVzUyaXV1?=
 =?utf-8?B?MmhFUUs1MkNZZmx4bU5ZZjlGTXJGTHZaS2R0cFExbUxOVStwa0dMc3pBaXk3?=
 =?utf-8?B?RldCOG80RDA0K3g0N094d1J3a25mY1lyZXMzZXJXOXJ1MVpSZFMrUDFFMHJo?=
 =?utf-8?B?WlZlNnQ2TDVxdE9LN2FmSk05LzVKSGZSN1plL2FxRjhYdVp2Yk5iZmFyYXpo?=
 =?utf-8?B?NFd5Mkk3ZVYyZWNUZDlJWVUwUmlITGM3MTA4dHRPZXkxZ284TWI5Tmplb0J0?=
 =?utf-8?B?dXJsS25mL0x2d3M4ajJ0Nk40d2FQajJQV3dFU1lKRFhlVHFoajZ1S3dPdTdQ?=
 =?utf-8?B?OXB2Nkx2Nk0vRXpMSVhWemdjcGswWmdrUWRNY1Z4YnNQRDFJRDgwZUZIblg1?=
 =?utf-8?B?TVhwZVhYUUJNdXRCdFJ2bjBodCsvSjB6Q2pBZzE0Z1NBdkd1VTdES3MrdE80?=
 =?utf-8?B?SEE4Ris4MzZQSWEzdFd1Q0c4Tm83SVlCWUhQTkh4blRocVdGTnVMeEhrWm9s?=
 =?utf-8?B?aS80YzJpM3dnZFRSV3I0aGgyODhZVkhUbGFrb2F3NTRlS2hSUlpEank1amxu?=
 =?utf-8?B?dUNFSUFxT3QxRzBrc1BCR3NNYTRoMzN2UTRJS2FxMUNYY0Q2cmhtV21aYVBt?=
 =?utf-8?B?RHE3V3RVRXRXWDVJbThXOHlMNkhLMEpISzNiY1p5Z2s0Z1pZRTJ5QXV1YWFn?=
 =?utf-8?B?MlN3WTU5NmNEZ2huVEsxOHQzYTl5MnpOZGtOYjhjN2FSRmplVFBTek5RUElE?=
 =?utf-8?B?NytzVWJkZ3hoVjNBYjF4enc3dU1HWjExRzdwSlNRR3dRMXJzS0FVV0dTbkJ6?=
 =?utf-8?B?Sk9PTlMrc3lEczNnMFdIWjhRaCsxUjBWUTB5K2dFdUtob2xvc09TUmRjRFRY?=
 =?utf-8?B?VFBIUlJNd3NYUlhpTXBNWVhyV3RpeGFQSjA0MXMyQjJ2RTE4cGVteHFKQkg4?=
 =?utf-8?B?dzVYWDUxenE2bnZvVHJza0hSNmsvK3NFU2IrYTY3MEFtRzFRTWlqa3FRNnBW?=
 =?utf-8?B?SW9mZjZBU3ZRQzRCNjRZT0pTemw1VHBhWmZ4aytKQ0FnRHlKb3FmNGNTTng3?=
 =?utf-8?B?VkRpcWVla1hwMTFIT0U2ZkdRZ2ZxcUdoTXVDRTdYSGQrOVZVdDdEaTFtaytF?=
 =?utf-8?B?ZUJPSlBwdy9TTUsxRzFFeVRIcXhDUVlRVDBKQy9lMWpHcHNZVU1ta3MybnpG?=
 =?utf-8?B?azRrSzlvRE1LZnRScXVtL3lvTm9OZ1ZXSnJKSkdVcyt5Q04yVTd0QlliMjFM?=
 =?utf-8?B?dVVlUkRZQ1l4VFFDSEJJeUlwamVsRWdJSUNHcnNnWVpWc1k1R3JMMUYvU2RK?=
 =?utf-8?B?NHh3bncrcVJGRkNuUnBqK0FGaE9WTjkvVlJZQkdOMk5RVWxtWkNYSTdIMUhM?=
 =?utf-8?B?ZElpZmg1T3I5NkthNDhyaGV2ckhFSXV2RE1qbEJibnhwVGJTSU9Kek9oQ3F2?=
 =?utf-8?Q?xHdWoh2cowT/+aLH8fqNs0Duv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19961fa-7ace-41f0-025d-08dbb4fc0917
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 08:24:38.4099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgPe2AUuMifqkhuw+PMz0PFKvYQ1qje7izlD/y27U4BfzkrqD7imM7FgsdRbyxgDkQdZ7H9ku7a5rCH79sYFVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5410



On 9/13/2023 8:13 PM, Jason Gunthorpe wrote:
> On Wed, Aug 16, 2023 at 05:40:25PM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> AMD IOMMU GCR3 table is indexed by PASID. Each entry stores guest CR3
>> register value, which is an address to the root of guest IO page table.
>> The GCR3 table can be programmed per-device. However, Linux AMD IOMMU
>> driver currently managing the table on a per-domain basis.
>>
>> PASID is a device feature. When SVA is enabled it will bind PASID to
>> device, not domain. Hence it makes sense to have per device GCR3 table.
>>
>> Introduce struct iommu_dev_data.gcr3_tbl_info to keep track of GCR3 table
>> configuration. This will eventually replaces gcr3 related variables in
>> protection_domain structure.
>>
>> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu_types.h | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index eb32df5371c4..1c4672ed90f4 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -530,6 +530,13 @@ struct amd_irte_ops;
>>  #define io_pgtable_cfg_to_data(x) \
>>  	container_of((x), struct amd_io_pgtable, pgtbl_cfg)
>>  
>> +struct gcr3_tbl_info {
>> +	u64	*gcr3_tbl;	/* Guest CR3 table */
>> +	int	glx;		/* Number of levels for GCR3 table */
>> +	int	pasid_cnt;	/* Track attached PASIDs */
> 
> These should be unsigned values since they can't be negative

Fixed.

Thanks
Vasant

> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason
