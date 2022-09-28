Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29C0A31
	for <iommu@lists.linux.dev>; Wed, 28 Sep 2022 05:40:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVcNoI4e0Ebo6hqW7Da4+jt4yXW8RofsnV1GJMoakxPoqWv8PgxaQoWKghlpIrGB9SS5koaAi0pxRTCG3ewZ3Q4G3adp0BN/K8gZAtLN8JCWQHwDC2WTAdoo2WC0ZR9OR7BOi6EWTWDu0jKv90oqAWhFy3sSiziaEFYFm/xcCvYt6bSA7VQw+39lGGjocMe0u3HVoOOs4YSH8BNvGU/9bVT7lUHAiqjZNRF0s1V+1NxDnmhBfoAflxGxlXrXT79GbSaR1ctyt1sqv4Ly+DEaqzyzTt/cnVQ7l9On7Ja5L97lhwXwDwSJUbTnCy7cj7Bb7clk3izAbelFbZBjgWi49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PutjLaUsl8iRlcjn6EL/CHsoqYEmWcxJYaPQ30FoAXU=;
 b=UNEsoFP6RocJja+pKdVQuTkFblTZ3nv+vtjc+w3DM7iS3il/7ZgGjHWeCRmXNUoZ1Gb9LRHITzKun+2MePxWiekbk31E0kvN6e8jM8Wv6ZdyBncRXcmTeVLr12C3mNpkTYviOcBmrGdECpeiUXzcCCZelu9rT99xNpS879VEr5LkmI2379IpO3JTzTDULwbrsTnmM5KM7BZRbwX9ri80sISV+Kd6/ikQ3enLkVAQU1aGjss85AxVrUMZDX0IDQ6pCBBUk1sIZRIVfyd8xiwZyandM9a6OhZqPmfaS59cF2URRBrYFz4HFy6ab6EamuMq4Aws2CiqUiVso8PvQDah+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PutjLaUsl8iRlcjn6EL/CHsoqYEmWcxJYaPQ30FoAXU=;
 b=hoWa0ODSWC90sxk1EqOMCx9s9XDo+R/NXu5+LlX9PEzhr7QttA0FF00wqbgPzK2gKOY0h1zwM4ikcNQT+DbhNozOanKasjaDvtyN7LGNg6/ijt5oGK5zqFhuwyz/jvmJNKt6aG6L7SgZqGipLax3o9oCTLt+OEdxWXbkB/DivJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 05:40:05 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::9491:5873:8c89:496e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::9491:5873:8c89:496e%7]) with mapi id 15.20.5654.026; Wed, 28 Sep 2022
 05:40:05 +0000
Message-ID: <3f72a477-7913-39f6-40a7-152975c1a733@amd.com>
Date: Wed, 28 Sep 2022 11:09:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/5] iommu/amd: Protect domain update with domain_lock
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, robin.murphy@arm.com, suravee.suthikulpanit@amd.com
References: <20220912063248.7909-1-vasant.hegde@amd.com>
 <20220912063248.7909-3-vasant.hegde@amd.com> <YzGLimZhwwt6qIVB@8bytes.org>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <YzGLimZhwwt6qIVB@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BL1PR12MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: 361f8065-27db-43c8-55d6-08daa113e52c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CsuzhDBF1+5TwmFXqaHTYC2Rh15aYHtXW+rDKIzLCxXFzjo0J3W5zjSKebZgZ1vCSFjrEQbFQg6EyO1/cqZnMZ8NP8vUJIoN1J3o8MTMFk5ja/Oi74ywEJRYQCG1+j28wUzxh0ljWk+4166rHlYvKcULma373GmzFGWrmrX/CFCMQ+T8Ryn1usnguUgu5+ueZFGy63NIgZM6zdIZfN1qzlHyJ5aEBRmtU3a0CnfAb3E/e6KLNwCz1CwCrw7HgweFs5CoIlyEFsInpYmYVWfJyXU6oRbHvAVyj5Oe3fDlXl28SgDgqQC/+Nbs55m21P0pGle2xrcUWf7soCJIjtONNPbiCFIdb5rsYdsRsIPT5k2oQWA6fv9OSqgBiZDtITDvybzzFPPTd5WAImTaZupmVSlSl8TqKQdPchwmaRiOLy7KrMtK8qj9Kx61klcgNHoQ1wyKvIrNalwh2Pce+GqXBxhup7k9hRq8gJWDV3xVVSx0ua9iiCcZh85DqbCkoBZFV1tJ3VcgZ7HchA0ShN3Gk2d47AGXuCbNeRj3XzgR4ve8kE89qxkt2yU0Zxb92UtvM5DZDPwcLeeUua9ZAHs4u6Gg6IbZftfPoL3EOT+kMkG8gNVY3xOTRCr/14COKWnO81yWelgv43Mbdyy6VQlgSj2cJqX3nyQefasb4JIkqCV+eVOf4RM819MghTZOD2PXa9gSktpsrmvMfXxUbysGed/vEa93VqwE7q7eIuft1GZ1hG4FrpJe9rMsHw5NIxGBvmCdCpf+joe5KwP6X6Dtq5i19Fb2It2LnPRBXaJhsQw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199015)(86362001)(8676002)(66476007)(66556008)(38100700002)(53546011)(6506007)(6486002)(478600001)(8936002)(66946007)(41300700001)(5660300002)(36756003)(44832011)(15650500001)(6916009)(83380400001)(316002)(31696002)(26005)(4744005)(6512007)(31686004)(186003)(2906002)(4326008)(6666004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUNsK1V1NnFVVTRMbm85Sk5PL1hPVFdjZmZQa3BJcUFHdm5xNXUva3hPMjkr?=
 =?utf-8?B?RXBacUZuYjk2YXN4RTV5U2NNV0NJQ2RMV00xM2xuWVdhek5nVmJuOUtRWXNO?=
 =?utf-8?B?b05WR080NDJabVlFbFMrbTNDb3lSV2xhLzBqZ0laY2xHdHd2d2tRRG1JMytG?=
 =?utf-8?B?a2kxeGFnc0tXVVJQMm44SGd6VXFwbmlYN3Nhb2w2VXlCVjE0cjRNSDNyRXJq?=
 =?utf-8?B?a2dOVFdONDBtL1pvcGx4bXVUUExwTVVLV2lWMHB6bmRKRjFnWGcrWHVmYlhH?=
 =?utf-8?B?bkJhYUlBdFQrU3pPRDFnVlNxQngrVk5Xb3VMRDQ2cTZTZG9UV3RqVWE0enBT?=
 =?utf-8?B?VDl4K3lLeUhoa0JiN1FOa0FwbHk4NXR0cGplaWFDTjI1bmFUS0NsZ2NJY0o2?=
 =?utf-8?B?WTJkeXhTOVdPUkdsQllvc0ZEaUg1L2ljaEJZNDBMQ0NmeGwrRWM4dlBJUEMw?=
 =?utf-8?B?dTNMR3NNQ2hiSXpNOS9KY0NlNU56bFRFbDBobDZWU3drUUJIaUNOVE53dkoy?=
 =?utf-8?B?NFI2Qm0zcGNJdWFEZEdHYWRGZ3JSN1RnZXIvQjJzZExQRjNtZGxmUGJGYURo?=
 =?utf-8?B?NXI0K3B1Y1d4ZEpxS3lYYmNyUkdOcklEamVnNFV2ektaYnRiL1ByVmJMTEVr?=
 =?utf-8?B?UzJkRTZCaVNkVm0xK2FUYmpKakptTTVGb3BjcmhodHF4ODdlL0tTU2llNDZ1?=
 =?utf-8?B?V0dJNkdGWE1lYmlUK3JIWEhoK3pLVzJyN3FjUlZnemRjWmhub1JvS1B4Wlgx?=
 =?utf-8?B?TnNPdGdTcExIVitSbDFyTlhacVduL1JEV0F3NnZBaW9GWjN5T096ZGVYb3dw?=
 =?utf-8?B?RGljV0U1WU9ab05zbzBjTjBaaWpLMHlFclhUWm50Y0tFNk82TjM2aDhucjAy?=
 =?utf-8?B?NjBiVHo1cXZjUXRrTWJHRjFnTmpoSlhYeUYvUGNORkpyOXlvSWtSS0dLV3NT?=
 =?utf-8?B?QWgvWnJNcko5L280aTBzM1FUalg2MHZYK2tuRnUrZ1dnRlVGa1dlVEZRR1Br?=
 =?utf-8?B?WGd4YVBHcWtidDZpSG5sVFQ0OTNjdzNOUkFuc0YrRExscmVWbTgxdFFLN25x?=
 =?utf-8?B?cE1nS0pULzBvT1NtbTFMbW15WjdMak94UXcrM0d3d3VoT3hpYmJ1bENIUHFK?=
 =?utf-8?B?YURuelZtNUhVYzlQQ2F0U3dCL2w0Tm9LWkJMK1drdkp2dGhqRG5tRk5KbzJI?=
 =?utf-8?B?YTFQeVl0Qlg1bFovZDd3VFlKWWIwVjdLeVg3L1l1alBNUlp2MVJ6Y2VicmdL?=
 =?utf-8?B?U2xhK294VUt0ZE1pVHArYmsrbWl4OVFFUG95dk5MVTV0LytVVWMrczR2bCtP?=
 =?utf-8?B?WXpYcVBHaCt6MVVybGUzZWZhdHk2dUZ3dmdCTzJWeHJmaHFzeU5wZHNVTW9F?=
 =?utf-8?B?RlF2WWJmL2FWdzBubGRaZFZJc0Q4UmtVdUY5MkRid01rcy9hOTIwTVFOaDJN?=
 =?utf-8?B?ejczWkZ5K0hEdnpCZVdURE1ubERnL01MMVpJRm9pVFRjcUd2K0xPdkZwOW5X?=
 =?utf-8?B?OFYrRDI2Z2JuZ2ZMYWxVdW1BWGVrNjdwOFlsQjd2cnBXSHU4QXZCeTdmSUVC?=
 =?utf-8?B?NkxZWVJPWDZydWRUMlFOV3BVRjFTdGRoSnBGemNRZkJEZitZdFRBM0gvUWdY?=
 =?utf-8?B?cnlDQ0ZRQ0FZOFlHM01vK3NyQWE3MHhLZmo2REN5eHBNWUoyRWJHZXl3Ri9R?=
 =?utf-8?B?WU15bFNxL1ZwTEdXWHQxakhTaTFncytmVFZRN2hMWnV4UVI0ditpRlBIZ1pL?=
 =?utf-8?B?OTFseUxJejdiMVBybEtGVHlJNlhPY09xYXZCVFFZWTRmMWc1eVVDdjF4Zmd3?=
 =?utf-8?B?d3V4TWY0a3REVENqZnhyMWtjclRHaUJ0UUh3cWdlV0N2Um90eVVSUHJBSVd5?=
 =?utf-8?B?Um9qblhPcm5QL1ZsWUc1dEUwbS9pU0dDWitVbk9ONmo2UkVtOUZvNDV5Vjh2?=
 =?utf-8?B?d0tTQ1UyR204ZThSdXR3UmNrd2REV3F6L2xrOS8zVnE2amdtOUZTUERKVDNC?=
 =?utf-8?B?SENJUDRqV1RtME5idStxclkvTHIzK2QrUlcwUzd2T1R4RDlWcWhtS0wrZlZO?=
 =?utf-8?B?RlNrK0lOSFMvVDJOdjlyVUd0NEFBakI4eEx0Skk3TndEV09HU1l3Uk45SEpa?=
 =?utf-8?Q?Yx8rwFiqKLUHlg0VXcrS9wn7L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361f8065-27db-43c8-55d6-08daa113e52c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 05:40:05.1278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGWvuqUUOaFvkhLj4eBpAYY7DWUh49CcioBEr0QwzFMAdBrgUyYaAwSU+y6EZEKp2sOVWXfKQ8OLx7U2Z+pq9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078

Hello Joerg,


On 9/26/2022 4:52 PM, Joerg Roedel wrote:
> Hi Vasant,
> 
> On Mon, Sep 12, 2022 at 06:32:45AM +0000, Vasant Hegde wrote:
>> In protection_domain_free() path it calls amd_iommu_domain_update() to
>> update IOMMU.
>>   protection_domain_free -> free_io_pgtable_ops ->
>>     v1_free_pgtable -> amd_iommu_domain_update
>>
>> Make sure its protected using domain->lock.
> 
> A concurrent access to the domain at this point would be a bug in
> itself, and the locking wouldn't help here either because the domain
> including the lock is freed right after release.
> 
> Do you see and concurrent accesses to the domain at this point?

I didn't see any concurrent access. I was going through code and
thought lock is required here.

What you said is makes sense. We can drop this patch.

-Vasant

