Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D25A63B3
	for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 16:51:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksBve31e/k831qHrbDruwxGIUEAJJIRO7buaJ2oi5Zk2RVAZaoZUEu/YljEF9TBY/F5eTxSjnYZlNKayGbL+72bnsxuX8HUK7un22G7wHk6jwxIy5Hx40Z0Mso4+AiEErFgdgCtoAKE3epC279ykDGXSHndvKH8WA1mg/QTVbD9fyV3wTidMEt0dBbcysDMLES1ZgLYOy540ZgMh8d8oCI+YclrimM9i4c8gtD+pqDpR9bVjbO/IGi7KcfTOz2CUdaKuRwVKXQvliOya6xcAnOy0iAVi/9zRNxfe1YOM8Uvmv3t8a1Wvw2aAOlIt+bc2YlDreDNEXVnPiIX7okd0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bC2nv6wNKR1IvMGttq5npTTGMpz+NU7jsHf5Fciz9Y=;
 b=kHuEu6YmHhDxnKhQKCiMwiiaLq5/zunPevF50gy1CtTtr53pzGRwzOoxjTmtIaRbblsBCsmI6KAAAn0K09fr1nxkuQUZ0sQDy6r0Hc3UVHS7t3b2G1904e/l+27/5hPmP4FQ4JRTPCXRoKMqoBPvnETLuaCgidfVLOkDSRI7DHae6/yKFgLMkRniSwJxDJnVLQr2q+Vsnc0M5JyxZDZSUaDh85ghEy1+6flhD8C+pWwaYAsSlQcuclGJqIMHjVa3uCKBW2a9kjyx3ED1WpHMxLWZg9plX+Xxpug5LZvBtCas5YQHP7i3mKhkPRWc7czp/vC0PHH9bFR3r1dOlP35EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bC2nv6wNKR1IvMGttq5npTTGMpz+NU7jsHf5Fciz9Y=;
 b=CWh4VTXjmE1Ha1Zo5yJ/Hbt7YLHP7eKAnKTG1EtRvMFd8dIvMYPQN2NScP41ClTUiW6RwN158PuE7+1+4mFgbyI+Rk6/apREENDo7J8i/XLSxNoca+g8WC6JeFbce/r0KDwguiNX2veugEkl9ir1rbAf7Zifwni0EHHVPDpR5ug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MW3PR12MB4441.namprd12.prod.outlook.com (2603:10b6:303:59::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.20; Fri, 11 Aug 2023 16:51:07 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 16:51:07 +0000
Message-ID: <36a5f7ad-7d67-a818-2b0d-366722592887@amd.com>
Date: Fri, 11 Aug 2023 22:20:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 06/11] iommu/amd: Refactor helper function for attaching /
 detaching device
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-7-vasant.hegde@amd.com> <ZNJhw8RRvJZ+R61y@ziepe.ca>
 <f08fc678-0bff-1e3a-302d-f673c952462d@amd.com> <ZNY1ligeAdFmILoT@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZNY1ligeAdFmILoT@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0201.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::13) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MW3PR12MB4441:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef7311e-bbab-4035-6083-08db9a8b2868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A+3Uf+VyTnWdW4TUFfV40hZFAVDBu3hs5op2kzIcCiAWn92AW0TwyCiITS8c3QXxjvJWKXdfsn3uwo03ne/dbdVhH+NF4QaGJ/w9tGHJ2ofD044COzYvEZ9P8n4g0dEN4XIHCc5OodQWecfxnJGmLuXu4vk+P72AVHJI0Knc6TNy330eMf8cR1ZI8QKoCI6370XTMmlBW/gMh73Nll/LUUIt6aciQkR+Zv9dXps6YFp286GUGBblIrVrv8wrmuCGG1NtzU9WpS6NB7+nXVg+rAZ66ToLQmsbWOz3Iv0ynAisaLl+IjOTp8tZxgV17a22TP0+YFD8M118nP+AL2n7inNCMVOCK+IzRnG4rwGhYcmI3MLhXZaDAoKduRyEUKFz/zDEDw0uQyFh3C3jThBNFgOrDmxZ7TW5qGUwIZN70zcvIu8keKs9TKbNGEHWItw0IIMKABfJ6R6jxGklQV2W8CEamJpVf+eXcuWGeUvpOOfCsTeO2Uk4ZHtRGYPg+LwkDCr/tuyL7ItLWx835ze1+SZVXncIwCC2KhW6+k96rOs1sIomV4hCA1UpShqL2MsynekamcX0EV4phfZrwQkM3zZ6hhMI/padZVhLhyCG+bfcxEVhAOVuzErkjMZ3EdAA3HF+xJSJxfpMHK3mchf3Bg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(346002)(376002)(396003)(186006)(1800799006)(451199021)(31686004)(6512007)(36756003)(31696002)(86362001)(38100700002)(6506007)(53546011)(26005)(83380400001)(2616005)(478600001)(6666004)(6486002)(2906002)(41300700001)(4326008)(6916009)(316002)(8936002)(8676002)(66476007)(44832011)(66556008)(66946007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0VKdnZlZW13QW85SHFIbzZFelV6QTJzR2k1Nkw0cGE3OU1lZFh1WkFjNjdJ?=
 =?utf-8?B?QVZyZ1U0bEswMHU4WW5EUDN2QXh3RTVhM0x4TnhtTnpyN2hoNEU4QzFPd2lX?=
 =?utf-8?B?UjNEWUI4WGwwaDIzQnpOaTFzNlZybkJxQ05Mc01LT3JUMkIrM3NoaXErL1VI?=
 =?utf-8?B?TzNhZHdHNTZvdElISnY1cFAyMENnazhueitub2RSWVEvUWl6LzZZclA4MFdS?=
 =?utf-8?B?UndoUTlGQTFpazI2MXN4b3ZPbkgxdkhLWWNXbnY3MXdjK2xDa0VqY0NBTCtN?=
 =?utf-8?B?bmsvTHZUeEcxYnVqQWhPSVNGL3ZpV1dER21qNnZUUTJ3VHVZRU1ISlExdnpV?=
 =?utf-8?B?a0U5OWs2dWJrMTdxTEdGUGNjbVlKQ205NjVILzNFSE1QbnZJU3B2aUlBbGZk?=
 =?utf-8?B?TzdVdU9xcThIRFh4RTNLbStGNjNmVS9HbG5iZmtlUFo2V3pBRXVXUFIvQW4z?=
 =?utf-8?B?TjROWDNDaHcwVW5ESm5zdjlqNHF1bFZDU0J2NERFKy96UmFPZTQrdC94WWtI?=
 =?utf-8?B?V1d1NFV5Zko1TFVOaFRtSEorcmRLUWI0dllBRXM2L3huSEpPMDBUVnhQMzBH?=
 =?utf-8?B?TG5COVpXZTZjZGUzeS9vdklWWnhxdXBpSzZ0dDc5bEIvUURZNGEzMGJRdHo3?=
 =?utf-8?B?ZkFoa0o1aWZaSW9OYWpobzRFdm5LTjJTR2Z1Z0ppdy9ucWZwL3Z4dXdEYTBu?=
 =?utf-8?B?NDFaQWJURjFZT1RxbzROeGM2UTVYWjZ4VG93ZTMvTVNERlc4ODhuV0xRS0tr?=
 =?utf-8?B?UUFTeXlmcSs3UThaVTN6SElWZDhwWlBYRXlNdXhnU25jR1h0WkpMT2l1RlZv?=
 =?utf-8?B?SVh5Tzd5QmIxU1R5b3V5WGM3VzBESTZrQ3Ria1M4aVBMRlBGMVR3bzc0N0Fi?=
 =?utf-8?B?M1hab0JZOHpJaGtxQyt5UzMzU1ZLSUhuZmJuMDYrOFZ6R3llRU1kWHNHNlor?=
 =?utf-8?B?MGE0VDRsSE5Eb3llSXRNMzVKZ3JNb0QySnh6amloRUJ5NElNdTdqZEZodDh6?=
 =?utf-8?B?QjB4UnNuR0FFNFdyWUI5NFZ4WjQ0Uk81cW9sbzdLTHpQS05hNHFkeTZJWkhz?=
 =?utf-8?B?dkg5MXFEc09zc1h5SDR2aFNXWTk2ZUFJMGkvOGxZWVZKc1JCOEhRTlBOaWl2?=
 =?utf-8?B?UTlvV0RwNG5vbDhvOW9Fa1FENS8walczK1VTSFFEVk9LNk4zVU9LYWpvVHpI?=
 =?utf-8?B?OC9OTS9hbnkvMzlldDZDcTlkUUVBdWxGd0EwdlF3UUxjWUxwNjlNRFhiREZo?=
 =?utf-8?B?NisyRWtPenpUQmprWW42VlI5UW91dFpWZEdGQjNlTDNNbUNnQ3lVTDlrNk1h?=
 =?utf-8?B?dHJ4Q25xQyswTDlnUGV0RktYR1cxeU1NMHh2ekJoQS9pYkVQc0JKQU1XNHJn?=
 =?utf-8?B?bmQxSFE5WkhwUDBSdjV2S0l2K1oxMDl6UVhqclpXelFjNHlOT3haNUVRWWc0?=
 =?utf-8?B?SklKWTcwOFR3d3ZKR1lIVGw1NmFGeWJMWmJZalFzMEllZzU4VTJ3VVFHT0RU?=
 =?utf-8?B?NzhvSy9CWE9KZmpnNmw4R1Fmb0lBbGFFVTFlbndGMHNMVFUzQ3h1Y3IrejMy?=
 =?utf-8?B?NlB4YWt2VmJIRElBaC9WTURHTXRkTGMzazFXNmlKdmFZeTlYeGk1SmN5Tjlm?=
 =?utf-8?B?RUx2N1FSN0Q3TUMyYkVVQzZEMmlVVWVZaVFFVEdRb1VNUm1nRmlYRkxLYmgv?=
 =?utf-8?B?ZGFTZlBZWUpxWTF4V1ArWU8zdHNyWDhSK1hMZ083ZHVGME9HS0gyenBjRUNW?=
 =?utf-8?B?VlZQc3ozRDl5VlBkZTZINjVVd0lnUVZVT3JBajNCWXRUMjVxYjhqaUxqb1h1?=
 =?utf-8?B?dncyU0FNdGFPZEhIM3JSVzRkbmZnV1VMdUlWMjc0YW1LaUtPZ2hacjQxZW9K?=
 =?utf-8?B?UW9zZkVqdlFyTHhDZXRrdVVVVXJQc2pXMDdEaGZRVDllMmI1YTBjSThmczRh?=
 =?utf-8?B?N1NEcERMVmJMZnlLTGNvanA2YkY0NW5PRi8yZ1MrOVpNdVhPdnh1MTY3THFD?=
 =?utf-8?B?V2NoKzF5NFJIMFNHMlB6MEZ5VGViRHV6M2l6OThjUDc4SGYrYW1idE90TVU2?=
 =?utf-8?B?bmV1cTZnQ1VwR0w3dVNUdG9OYWFCTlhKb2JJQWJGU1hzNExhdEJaUUJiTE1q?=
 =?utf-8?Q?41w65JsSCrgfJq0MXcmbEBb+u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef7311e-bbab-4035-6083-08db9a8b2868
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 16:51:07.6430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2GC1dj+DMJbd+6nTT5CdwIscmd9sz1gayW2dbOZ/N1Slo9sV6n8d1Wo3ywuqxMVyP3cOGYGds6nQ3zN6FS/BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4441

Jason,


On 8/11/2023 6:50 PM, Jason Gunthorpe wrote:
> On Fri, Aug 11, 2023 at 03:37:25PM +0530, Vasant Hegde wrote:
>> Jason,
>>
>>
>> On 8/8/2023 9:09 PM, Jason Gunthorpe wrote:
>>> On Tue, Aug 08, 2023 at 10:02:27AM +0000, Vasant Hegde wrote:
>>>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>>>
>>>> To use the new helper function for setting up GCR3 table.
>>>>
>>>> If system is booted with V2 page table then setup default GCR3 with
>>>> domain GCR3 pointer. So that all devices in the domain uses same page
>>>> table for translation. Also return page table setup status from
>>>> do_attach() function.
>>>>
>>>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>>> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
>>>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>>>> ---
>>>>  drivers/iommu/amd/iommu.c | 54 ++++++++++++++++++++++++++++++++++++---
>>>>  1 file changed, 50 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>>>> index cc42732820dd..4fed3fbe069e 100644
>>>> --- a/drivers/iommu/amd/iommu.c
>>>> +++ b/drivers/iommu/amd/iommu.c
>>>> @@ -1821,15 +1821,41 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
>>>>  	amd_iommu_apply_erratum_63(iommu, devid);
>>>>  }
>>>>  
>>>> -static void do_attach(struct iommu_dev_data *dev_data,
>>>> -		      struct protection_domain *domain)
>>>> +/*
>>>> + * Note: This is currently used when booting w/ amd_iommu=pgtbl_v2
>>>> + */
>>>
>>> I would drop all this commentary about amd_iommu=pgtbl_v2. That
>>> command line option should be removed.
>>
>> AMD IOMMU can boot with PT, V1 page table and V2 page table. We need a way to
>> tell what page table we want to use. Hence we have these command line options.
>  
> No, you don't, it is wrong.
> 
> PT or not is controlled only by the core code using existing common
> mechanims. Not by iommu drivers.

Yes. We don't have 'pt' in amd_iommu.

> 
> For v1/v2 kernel needs to automatically select the best page table
> option, not try to make an admin figure it out with a command line option.

Our hardware is capable to boot with either V1 or V2 page table. By default
driver decides what is the best mode.
But if user wants he has a flexibility to choose V1 vs V2 page table. In that
mode we will adhere to user provided option and all devices will be put in that
mode.

-Vasant

