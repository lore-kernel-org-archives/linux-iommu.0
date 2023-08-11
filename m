Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FCF7F1
	for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 01:34:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDlOcJa25Nzw1M4Glu3qLFFq4dFn3Fu6KFtbl5fQ2NO812QayZlAHBRaRX63Lv34ewk4E2IshNpO6WJyIr8N+c6USYGJ+AWuhOPDWONifOPoB96HGtpuPNrlOY88UZdgB338CS6ZWDN2a7DlOdSfCuD6dZpEWwanzgSXSwixzrL4dwWEzyX7cRBYdILyP5DQadAf9gQL1lIs6L0dMk9aEj6RbH7XtEYuy+y/xOyEl9siCnReyiNUc92HmL4tDxOSm0DiDLj0GY1xk+T9ZVNzYsu124jgZlg2FgSR40jrpIuCGZiRdZA7k2C8pEA9nDWrLJk3YIqNW1WoiY/Pj/y0xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYU1+95j58MUC9OgXS8pgheLeToURINGDLUw+0DNjno=;
 b=nO57aafitvop5Ea8Q4GVfskcA8zOlmAyU6zwirHMP3W1bm7TQCNilHQ4EWb9dCKPZZhPuGVILmNy1dKhrul0oI4BeROXmGrtWHkg5mp66weE/MqNU9GaGfRh0GflEgZt3N2E8RllB3GfqQ6A2b9bUGM08wUWomOQZ+q8wRBnj3kWWgsHqA965D/7hx84ZyZsDlVtqhxIOpzfdTG3swY0UJC8Czzh3+pnTCRWuqxnC6K4ViktZ6icTL2bCXwGxIUPLMnrtez5Vb4yxH2WLoKZE/2rJXQ+9tCXYV1AYCQyqKTfxtOP8RIhB4wjc+fS8n54T55iIIhLskYnMQCWbjabbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYU1+95j58MUC9OgXS8pgheLeToURINGDLUw+0DNjno=;
 b=BI8mnsTTKbZiVRuz7avhBicloiLbfxgxf5jsmvb2pEtRhrK0H+fjgVZ43GjEfVE1eh8wX8rNseyxKpTrbnwkB4zWeMF/gnK6M6Uw/a9DXcsKs5lVdHXKZQEaNFcJLuVUfBtMCtmN6yBbnISorI6+gLEGkYxSxm3xISjxB1XVFKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Fri, 11 Aug 2023 01:34:49 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::12ec:a62b:b286:d309]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::12ec:a62b:b286:d309%7]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 01:34:49 +0000
Message-ID: <c5572a08-42b4-c778-b6ce-21fe44190ec6@amd.com>
Date: Thu, 10 Aug 2023 18:34:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 09/11] iommu/amd: Introduce helper functions for AMD IOMMU
 v2 driver
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, wei.huang2@amd.com,
 jsnitsel@redhat.com
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-10-vasant.hegde@amd.com> <ZNJj9ljbIM842lEh@ziepe.ca>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <ZNJj9ljbIM842lEh@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::25) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DS7PR12MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc36e4d-355d-469e-4378-08db9a0b26ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A2358fc8qAY6izSEGg6pijuJssZbmyKiyXbBKQXeklRnDnxxd6hjqjp0QV7hy8uTWMrN3l4NtTrUWrPZaqsWQ5SjB6p8hI8FqO7K3IEFADSQaXXRbBFikqTzD76BD6op+K6cuTNc/q59MhSD4D0tMItJuDsJU6fTu580BJ2EK+SZ62DWt98EZwvNoRia78RiqKKX0S6FUYgUJwI6wHGO8q2n2/OxPCZEIpiFECuSQ5yc+TgKvNJJnN5Hg+4WFcwzj81qi0F98kCCsqeL0f9Qqv0uIyM9vJHocbzOmheizPWzJXZVLF2Ka/7DBKLPSrJ5mzr5V6ROs6ZMmqavMBKT8azonoGkd00xJvGNvX3G8MvoJ/rqC1yRaWddy0S+myujEgSecVnf5tJAKc+2S87zquo7yzBtvBkkb83GzYkOGWT5C0GWpwJ5NgN1MK56Ol+4cJ+1ArgJjmn+D6jfnPjwlXpi5Bc7HIx54fl23xcib+V6YpNl4QvmrwTT2c6AQqsm4TCkBAt8/Lvmt8qTkxAfDwu1E7baJ2uUWU1O+T20vgYKdxO6gMJk3XfQywmXt8z3kIv4jcZjmiX/ZONSWmMb6udmzDz34RUYuqXzgoZvbEYAsRaCKnvPl1S/b0C0ueP7uJd4znCxfr0+JYdmiY2jVg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(186006)(451199021)(1800799006)(110136005)(83380400001)(26005)(6506007)(6636002)(4326008)(86362001)(66476007)(31696002)(66556008)(316002)(41300700001)(53546011)(66946007)(6512007)(38100700002)(6486002)(2906002)(6666004)(31686004)(5660300002)(36756003)(478600001)(8936002)(8676002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnhZM2Rrem9MMkNSSlBHMm85ZmtCaHg4UTc4MndFdU9qMkxmWlBxNkNCNGtq?=
 =?utf-8?B?UWpoZ2F1WXl4OFVDcEVQMDJlRlVsY0laMkMrTGJyeWtJTTE1Y1BuNXlhMGFk?=
 =?utf-8?B?aXFNdXBtN0FRTis3b3JpaitqYm9QTTN5Y1A4Q0hFV2pNdk5BeVFZbW5lTHZt?=
 =?utf-8?B?VFM3Tmx3WENCQWhxeGtuM1VqMTYxdURvcGVUSzR1bUl0ZWttVHZqWUozZDE5?=
 =?utf-8?B?S1JDTGtCSWc1cTNDTWNuS1prd3d2M3lEejJZNW5XRGwwMkNlNWNQYTYzQmdC?=
 =?utf-8?B?U1VoRDVmaWh3VFRueVFnY2N1UXNnbGtNY2xRTFJEdmU0SFFNSWJRZ3c1djYv?=
 =?utf-8?B?ODJRRnBkYk5tU3ViODUxVThYSHNDZUtLTmdTa1FDNDhJbDFJR0VQZmR4RkQ0?=
 =?utf-8?B?MVZKR0VHYUt0aU52NHNWZlVaZXJTTzRyTE8wMXpyYUM5OVAzelRrTjRyUGIz?=
 =?utf-8?B?NHBRb1p2OVczSWtTVUFvbi8xbms4WWZsMkdDMzJaVUNPRjRRTm5VV2NvOGhh?=
 =?utf-8?B?RER0N1RDRUl5ZEhTZHI3M3I1NHZ3MU1UeHVyWVhpUTlLMzVyemFLM0JOcHZQ?=
 =?utf-8?B?ckViQ3JZQWVxQk5kOVRxcW44cERPTlpoaXB3bStFZUJzd2pxWnVSMUdUK1VP?=
 =?utf-8?B?Zk05bzM1S1RkbE5LRmNGUndhNEtVQVY1QTNrdWloNEpXMzJ1STJFaWFub05F?=
 =?utf-8?B?SWFiZ1RGUk11SUNialdzUEdqbnJkUnlnejQzSDEyemtVVDJ3ZTZNdElyTFo4?=
 =?utf-8?B?MTZQQllVWDl0WFZRem1CY3Y5aS82Y1orek1qTG44L2c3MlNTS0R2S2tObm9Q?=
 =?utf-8?B?bVlDWXNSeHRKV2REODFCcUc5WGh6NDZqUWxNcTVKR1gvVkdJQkZWbUozendZ?=
 =?utf-8?B?RDVldW81ZVZGdnVscVhIc2hocitPdTVMVHZPUUlJY0wyU3Z4Qk8xVmc4K2Rm?=
 =?utf-8?B?SE5FYlI3blZSYndQUVhCcGtVWmtzRnc5a1hFek1JTFpoWnNXOXk5c3ZUWU5z?=
 =?utf-8?B?c1RDUnBVODh6NVdZK1NjdmxzNXAzWWMvVDBpWFNQdjY5dnNWTGVmQzhtUTFw?=
 =?utf-8?B?ZVllRWNGb084d1BzaDBSMkRHV1VJc1ozOGl4b0ZEanh6a3p1eFBXM252bXNj?=
 =?utf-8?B?d01Ia0thTmhGZXZLR3dMNVdGeXRkUVJ3TStlZDFnZmNidHh5MmIwSDlvcGxy?=
 =?utf-8?B?VXUrOTFSdXljWFc1SkZReFlPL0U2eGR2NjMwNWUzbVZTcUErb29hNHdYUkk5?=
 =?utf-8?B?cm55Yi9BRm1va2VlQXV2VDVtYUgzei96bWFNdnduQVhvRDFZODFPeVNsZUNr?=
 =?utf-8?B?NWJKUnZVaFdwRzJ4QUtJaEJ0TWtUcHF6QUNQWC9IVXpnZFBlZ0V5c2NNRWpK?=
 =?utf-8?B?SFBhRHpobmNBdjdSV3psU3J1eU1qd1JwOTNLcm9uNzgwMnF6ZHpoQUozcmdp?=
 =?utf-8?B?RDh4RE80Qm5Zc0N6M0xUUnQrWE1PdHZzdHU2Z0FlYU1mTEFUYkYySkJDR0Vw?=
 =?utf-8?B?NlZtaW4rL09vQm85bUVVTzMrMC9ibVhKRXFtQVNtUm5id2tHVGNrQXpNSndq?=
 =?utf-8?B?MndkSGZwVDRYVUpIZW9LUlBJVHN5NXRNK0VJcVI2bmczWXRxbDJ3MlEvdkFt?=
 =?utf-8?B?MGNQL3ZMazV4R3FzbS96UEhKc0FQdW9YMjBSU3FtNm1uNUw1cG5rdTVreUFM?=
 =?utf-8?B?amFEQld2RWppTnRwWFhrN2VleFFJMlZySkFkUkJxTktWMDB5VitpT1doSUtW?=
 =?utf-8?B?ZmpqNUpvbGpoekt4Zm1mM3NlOEkrSTZva1RaM0c3QnBmM0FzaHByN0NDcEp1?=
 =?utf-8?B?R0xLR1ZWUmFCMk1idkZmOGFRS0FBZ0Y0T1JWWHVEVmE3QWg3TWpsZ2IxbFYz?=
 =?utf-8?B?VVpETzhMVFNmMm1UbGFTYnY2QXZjS3NaV0luNEk0eENTeTE3YXl1OXhzUlFO?=
 =?utf-8?B?VmhEMVg0UXFUUm1xOWZkcWplSHQzMmg0UFgvcHRERGhrSVVyNjVlK2h0V245?=
 =?utf-8?B?NG00ZmJoQjBlU2V6R3hTclU0c3hTY0UvaWIwNC96c0NSOFU4OHNVOU05YzlK?=
 =?utf-8?B?SjUzL0sxQk5CMGxvdW5DblN3Y0NZOGViYkp5WjFKaHhjVXdHTXg5V0NSRk1o?=
 =?utf-8?Q?ivTRrjKWDCDcqfxQ7hwoPAqVh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc36e4d-355d-469e-4378-08db9a0b26ca
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 01:34:49.1341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqEKVCB9mbpluECvwdMI5mZJ/333az6VM7U7bTApXQyFOhzeoBoVobWsIRC7/GWJSNdrUzPjanL31WZOHBfVfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718

Jason,

On 8/8/2023 8:49 AM, Jason Gunthorpe wrote:
> On Tue, Aug 08, 2023 at 10:02:30AM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> Introducing new functions to init and uninit v2 domain. Also setup /
>> clear GCR3 table. These functions will make necessary changes to
>> existing domain to switch to SVA mode.
> 
> Huh? "necessary changes to existing domains" ? That shouldn't be
> something a driver ever does.
> 
>> +/*******************************
>> + * V2API-related helper functions
>> + * Note: Separate these out for now. It will be removed when
>> + *       deprecate the AMD IOMMU v2 API support.
>> + */
>> +int amd_iommu_v2api_domain_init(struct protection_domain *pdom)
>> +{
>> +	unsigned long flags;
>> +	int ret = 0;
>> +
>> +	spin_lock_irqsave(&pdom->lock, flags);
>> +
>> +	/* Only allow v2API support on pass-through domain. */
>> +	if (pdom->pd_mode != PD_MODE_PT) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	pdom->pd_mode = PD_MODE_V2;
> 
> Wah?? You change a PT domain to a V2 domain? That seems totally
> nonsensical.
> 
> This is continuing the wrong direction of the old code.
> 
> When you first create the GCR3 table you have to inspect which domain
> is attached to the RID and setup the DTE/GCR3 accordingly.
> 
> You don't *change* the domain that is attached to the RID (other
> things might be using it!) You just note that it is IDENTITY and do
> the right things.
> 
> This should all be part of generic code that is working with the GCR3
> object, not here in the v2api section.
> 
> Keep in mind that the API flow is to get a 'ref' on the GCR3 (eg
> because the caller wants to put a domain in it) and a pairing 'unref'.
> 
> eg if it was already a v2 PT when you want to attach a PASID then
> great, the device already has a gcr3 and so it just keeps
> going. Having a PASID will block the GCR3 from being freed and it will
> block V1 domains from being attached to the RID.
> 
> When the GCR3 becomes fully unrefed then all the PASIDs must be
> removed, the RID must be an IDENTIY and then the driver can free the
> GCR3 and reconfigure the DTE back to IDENTITY. Otherwise the DTE
> points to the kernel owned GCR3.
> 
> Jason

Supporting the IOMMU v2API adds complication on how IOMMU domain for v2 
page table is managed due to several restrictions, and it is conflicting 
with the upcoming SVA support.

Since this patch targeting v6.6 is dropping IOMMUv2 support:

[PATCH V2 4/5] drm/amdkfd: drop IOMMUv2 support
(https://www.spinics.net/lists/amd-gfx/msg96082.html)

Subsequently, we will go ahead and remove the AMD IOMMU v2 driver since 
there is no in-kernel dependencies. This should simplify the domain 
management, and should be easier to introduce the SVA support afterward.

We will rework this series and send out v2 shortly.

Thanks,
Suravee
