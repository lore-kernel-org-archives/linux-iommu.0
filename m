Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5471A58A
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eC82GAxO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KynefR5+niUnvszLiWPZa+tHFjq/mSXn01zYS8StRaBANarvgCVPf6TxBBBghLKtpQa4NpAqSKWpJC+uMsXHxBqfMH4XI8zP8KxvztnYNXTloV+g+m4ltoZXBbkZl1/AhgyNgd4PdHqO6qqPQ8MRQpHK5eWqo+qhWytqQd0lBT+nGILl7Z/Hic65VW6Uc2t/17brZNwQZI7UWJduHRMHgw0tHSUY7bjmF7jF9S9Q+//vEklWrxouj8cV8zQfvqVBePocASg1RRVoJWZORWv/e7qte/Tpo6SgX9kSznPk/+S/sG9NLvQWk0PIvePZuFKCzZdTdqnwoWYhAgEAYI8qoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9izQYUZqSlF2iGeOVPbI+E70T5jGPF7iRZakDjI5gsI=;
 b=lL4VFfLHHJX5oomcfHYsFR/buZ+9zamVGCOUMCQ1SaZpczobFbxV/XP+gBXYGvad2haGErJ7kOWUS9Non0QSDaWNAl99NBC+GeQySIKUTW7l8/TvSTUY30iOYuv+5fL20rd50vs5y4Mc29fnH7oT7syIjIVld3bqXZ5Di2OaJttxIVAdfp2h7LOlyKktcYjiw2HCoUqYAjATlLohM/XeL1ayH77oiZDrrT2s6nN3on2+7QRxeZ3t6/hwK6pJvPf3mg3dW6ch8XFKXVOk1+QEPv/5/1Wou70cKTYErdn59ke+AjofJzqko/qJJW4nb3ZlxKnEsHXWlnzwRPM+3yyBwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9izQYUZqSlF2iGeOVPbI+E70T5jGPF7iRZakDjI5gsI=;
 b=eC82GAxOsG9b2htvW5JECR+G94twyMHdz2JNbodgTJW6EJNcE/0zZDVWExMOz9SSaoYOKYOeVnWHaTlHN2AGTnQK8dUpMH+G8Xu7xT6NvcwvrgriwdeNN8DRj/W+g0Bnw8C9Diszjkk8rXdDZdxGLc7T31VLaj/TXhAc5WwTuwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.27; Mon, 6 Nov 2023 11:39:52 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 11:39:52 +0000
Message-ID: <1a19fcb3-d45a-64b3-de4d-363ebd8ef238@amd.com>
Date: Mon, 6 Nov 2023 17:09:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 07/13] iommu/amd: Consolidate device IOTLB flush code
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-8-vasant.hegde@amd.com>
 <20231103184427.GG223197@nvidia.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231103184427.GG223197@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY8PR12MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e18a51b-38fd-4a70-2a9f-08dbdebd170d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vY76+S9xckQRmajowO5HDargz74tWA0/kJb+v5OqONVDYIe+6HJmd9KUvcqM8hTujkvYoIf80mfuXs6JtRfVxDCvigVmVF41bG01cGJbonfrgF5D3UzCfTLbza+axNTELUCnmKgcWKZzrmLxnl4yIgwc4VDdygR+toaHwdBG4b1rLDjlKyAJa03SZ5hyOH6geE2BVzE0XuCN2v40upFTTF9CFcUHQipcY5Y/d2yGFicxwNNcyHZcXUUaSOJwH6IraIhBobersbexO5KLWZU4nzq3u/J9aNRfowO60E4JlnuVoh/amUhvPljh7Aw8djwWekMXoIyBOnXkQ8U6M9sLZ8RDLoOf+w8naQI+w0jprgnKxMB8KPDSoXhiz8qrrkrRhk6oysz1kfYFDsDJU7wZIVDxA1epz4yQB98N7IbZ6O0D2GbdDpGpRKJ43L0LYkK/grCQjfZiKznP4meHJZyGQbs0UtsY5Muecbtdann9EsUh0fc4Hr+myiBWVUCMz+uC0MOzto3Fo/cT40nWaz9Ag8y85zVK27uSfkFxBss/T9tbcoCUgf4eBABQW1e/qL5JGH3ESw8hQQA12i8PCAKUBGLN6nqj71UYm2G6KZZjOh9NLfzlze/Cc0oMBPUKo2xNfFhZZ0/itJaSgl+CbCtsPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(136003)(376002)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2906002)(478600001)(6512007)(41300700001)(44832011)(53546011)(6506007)(2616005)(6486002)(6666004)(316002)(83380400001)(8676002)(8936002)(4326008)(5660300002)(66556008)(26005)(66476007)(6916009)(66946007)(86362001)(38100700002)(31686004)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QldzUVFVdWVWRE1RWnh0NTV4eU5KazFla0xwRFpNc2ZVakU1UnFVRVhGTE1J?=
 =?utf-8?B?YWZacFlnMlJEYTBvaWpwTGY4TllUdDhudUVaR25pSjhKNnQ5cFJnZDBldkRQ?=
 =?utf-8?B?T1E3djVxbVMwaGZiK25FSXJPNlVhU3hvQ1JvNjRFcmtVd21RQjlkRnFUcEFQ?=
 =?utf-8?B?NmM2SC9XS0VoQkw4MlkrRGtRWC9PWGFLaUxGOVNlVkhiNEdwUEhramhuRWE0?=
 =?utf-8?B?OFZ6QlJrL3pnRHhWekFPbEZYNllhd0NVWmpVRkxZQ0ZQakQzSHc1Qmpjb2Z2?=
 =?utf-8?B?UlVtcGsxOFhjTU5rQWlQSjVUa1h3QTRnQ1pBOC9UU3JoQ0JTQTJCWEdPc1I2?=
 =?utf-8?B?UVRVT1crWS9pVFlaTDlqclJEQjMrbFZud0FFeEJWQ3JOV3BaQ3ZvUHN4OVRt?=
 =?utf-8?B?MmM4ekhqNGFyQlVBd1lSdzVRYkJ0UjhNL1pDeEIwRmZ2Z28ydE9UZ1hibVFJ?=
 =?utf-8?B?SkYwV2t1cXlYb0g3WkF6RTFCeGlsdnV3N1N5VkhxeUxnMTEvSnRDcU1OSEEy?=
 =?utf-8?B?d3JraDR0Vi85T25IWHFBbnBpMm1mdnFEeFpQODJOYjVqQXExTjN5MnZTT21D?=
 =?utf-8?B?Z1pjc05mUjdjcmZ1K0lWdXYrMGh2UXE2OTU0dnozM1dDRnlRUzA1Syt2Yzho?=
 =?utf-8?B?QkY3ekYwWjBISjR1U0JqOXVNQWh3RlRXY2ptSm9aTHBOSUhENk5HbGRvYWgv?=
 =?utf-8?B?d0pHT3dpYjJNOXpvTGRLaGszM0VtYnFBbEMvOVpmN1ZPQ3lwdmJSaWc2TkVL?=
 =?utf-8?B?dXJyVXh5SHJWdkR0NEZMMktCYzZZb0FFM2tkZHVKRjB6VFo3d0dYeGxZNzNV?=
 =?utf-8?B?OUtIVGVodUdSQXdoOC9obk52SEMwVURtTTVQa1ZrVDZWSWRBdGZLdUxWamtP?=
 =?utf-8?B?U1RWeENBeU8xdDRJSFRYUkFzQkFaeTZ5THlPaHhTMlZDRm1BRkVaMjJPakh6?=
 =?utf-8?B?OHNDZS9qTzFUY2EzQUt3MWYzcmhIVTVnRFVjdmNzMmxmcGwwTUNBeXVQdHB4?=
 =?utf-8?B?ZVAya29IQ3F5ZkdEQ3JsUEtjRGwxZ1g4VmtTc3FVdTNWU1VieW5FUDhlM1pC?=
 =?utf-8?B?bVlOaGhRSWtIT3ZVdVYyVGNGb3VMa1BuSkVtQ2VxY0VybnpLV1cvNGluSG1H?=
 =?utf-8?B?NnAwR3F1anExbys5V2NpSHFWaFI2RUVTYWg3WFlybDlkRXI0VGRzbHJWcnI4?=
 =?utf-8?B?UUwvRExJN3hvSVdoTytMRUw3dE0zclRLVVpIRVZqdnpHbVpkSWZ1YWE3Sy9p?=
 =?utf-8?B?dFZORVZyeFp1TitmdWdvZE1ablQ4QzNvZkliTDlHdmdzaDIyV3ZhUTBabTJx?=
 =?utf-8?B?dlpwNXNXdmRYVndjdU1KZm1HWjZzUUNUM1ZrRWZMZFlKRkc5S1AyQ0t5SWlu?=
 =?utf-8?B?Q1djbHJNYUJOUHMvOXoxV085aTFUQU9CYTVjay9iVmZvdDd2S1B0eS8wTDZ0?=
 =?utf-8?B?SWdneUx6VHpmUldiTXVNMjh4dGNDK3htODRad21HZmxpOVZlY1JqbzdPZVRH?=
 =?utf-8?B?aWdLbE45TnBsdm40VnpMaTg4dlExNmw4cHNFWmU2QjFrczZrQ2h2cFBDWG1I?=
 =?utf-8?B?V3Nvd2VsVHJmQWtMZWRtbWQ3alFZZWo1aEVYZ0tGS2RFWkhLTnZscWRiMXVi?=
 =?utf-8?B?VzZDd1NEbklDVElnVEg0c2tzbEF4VGQ3eUxtalQxWm9lSzEvUCtobUNSWW9z?=
 =?utf-8?B?UjlFTFZqeEdLenl6M3JnVHhDTlU3SWpuYzVJQ3B2alVlMG4rUTZwUkVVMldI?=
 =?utf-8?B?ZHhCNTNvT3JvRlZtY1E2SzNSOTRVaEJCMDlWQmZ6a1hId0NqZEp6L2N1R2RO?=
 =?utf-8?B?WE5GSFEvNk9LNzZiMzZPRkp6LzN3RldhUXFDWmQ4S3lWbkh4dUhqZlVUczdv?=
 =?utf-8?B?d2w3THp1RFJJT1hkQ05xdWNma3kwenkxR3BoRlJ5Q0VYS01WMkwvNWFuU0pO?=
 =?utf-8?B?N0h5UFVCSWFNZk1CNVRTZlF1K2VhTytWMmc3VFFEVVBrRFhScGZZcGcrZm5T?=
 =?utf-8?B?WmZ1Zll4REdubVZhWDdNUmFrM2NiSTlOUVFGaGRVdVgwd1k5WUxXc1MxM3hy?=
 =?utf-8?B?U3NhKzJzZHRJbkxlaHI0L3FEanI4M21Xc2dYeGdmUnBNcUIzNkxkcnAzZWFk?=
 =?utf-8?Q?gfYEbczSFLKLjpJl4bey5Rd4H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e18a51b-38fd-4a70-2a9f-08dbdebd170d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 11:39:52.4127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9E5E1VukCMfIPurk9FnsY9+3HZ8gq3h6PWMOzurbmVtY2kJ1kLUSJ+oN9/C4AYCRos8QTNfFpgx/REpIingV6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8300



On 11/4/2023 12:14 AM, Jason Gunthorpe wrote:
> On Fri, Oct 06, 2023 at 10:16:18AM +0000, Vasant Hegde wrote:
> 
>> @@ -1380,12 +1396,13 @@ void amd_iommu_flush_all_caches(struct amd_iommu *iommu)
>>  /*
>>   * Command send function for flushing on-device TLB
>>   */
>> -static int device_flush_iotlb(struct iommu_dev_data *dev_data,
>> -			      u64 address, size_t size)
>> +static int device_flush_iotlb_range(struct iommu_dev_data *dev_data,
>> +				    ioasid_t pasid, u64 address, size_t size)
>>  {
>>  	struct amd_iommu *iommu;
>>  	struct iommu_cmd cmd;
>>  	int qdep;
>> +	bool gn = is_pasid_valid(pasid);
> 
> I've read this a few times, and this just looks really ugly..
> 
> Something has gone off if you have to encode the type of invalidation
> to do inside the PASID.

I wanted to push all these checks to low level functions rather than caller side
adding checks. Also I wanted to avoid passing protection domain IOTLB flush
functions.

> 
> I don't have a good advice for you, but I suspect this is a
> consequence of not having robust datastructures. There is not a single
> handle you can use here to refer to the thing that needs to be
> invalidated.
> 
> I'm not sure unifying the v1/v2 flows is actually an improvement in
> clarity. In all cases the caller should already know if it is a v1/v2
> object, calling a specific function is not such a burden.

Yeah. I can introduce few more functions and few extra checks in caller side if
that makes it easy.

-Vasant
