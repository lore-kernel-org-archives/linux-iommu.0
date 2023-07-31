Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E935C8C0D
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 08:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=la3OxVaNmaDFB+Gl/sxByEUCYStYi2J1sDKzCSVq2LExtDZFTlXo3CtmVw6DF2JRXeu5PqzBq5QNA2omaBsigUDiwabIRz0hrkkkVWM4NDU+GDHaVNYLbxeuKnwDY8m4Cu6drPioafBGXDVten2HSL7gBUMhxlJj2705KIrvJNwp0z0sZXhKUej/kNOvKOw46MSpXepimsCo2Fr1Rtsq7Gbyy9U35HpNWXaVYYxp90lTEPwYR1Cj3hCw80cmNbTVu/Qp3r7Sy3cQQDkqNymkHd5DGhHA0/VYpu10LFDUsVSJfSGh9pHgcWQlRSMJYQ83BnpCRDXk5Y+jiJikhgHuBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gc9C8F/bN/LRSGwYP7m0EXNSVf03Z0MaekEs4QQS3D0=;
 b=g+pYcxgziyVnL58W1Ds6EgUnB9uC68e8R0QLdSGZ6IZ42MxFSJ0CnorL/hdJ6ZGapfZaICLlvZQNs+VFtFLKvMX9QGv4Uf8C8D7fnB8nmg6fwmWaWqFa6UxsTQkI6w+lDVxgEelei1k60CGEGmp16qfZ+vMASenzi+7hFPblHG+IakMfosDDpnvDwa8TH34i4DH3cipqGruOaDwoUfi1tnBcidfb/u/NAWWqHApmIregaq3zByUw0nf+iGFnCqfA5jUkqyR4bltEkOo+bl+1+BL0UGTFbvQQl20X2311KvAxaL5tC1f+ieCBnJABO0MAyZexMe9GWcR4M8DxB5Xpdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc9C8F/bN/LRSGwYP7m0EXNSVf03Z0MaekEs4QQS3D0=;
 b=CJrbeVmA1bR4DYfj6AaaVqI+9XwWmaIvJPLON86YKCH/4d1Uz/qhGUvQe+NEWurVSaoeWjevf/uHMggq1i5tvtfCxsxc546B3a0EvV6U15sU7vdnpoty+Q4fftuYqdN8k0nkyXCsVALFhhmz9YGBE3vTtFFEozkMreQn9pF+GBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 08:02:19 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 08:02:19 +0000
Message-ID: <d231040e-c657-35aa-c6bb-9705c23afa82@amd.com>
Date: Mon, 31 Jul 2023 13:32:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 12/16] iommu/amd: Add support for different types of
 PPR handler
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-13-vasant.hegde@amd.com> <ZMPRN6Gz/dsbBnqe@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZMPRN6Gz/dsbBnqe@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0188.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB8879:EE_
X-MS-Office365-Filtering-Correlation-Id: c98d0213-55a1-4101-f954-08db919c764d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z2ehr3zphKhCs2+cs9TsVnD8DFN5OCAClx6h/pACG4ZDMy8pgrAg5tZk6oKdCgwI5xqYemLF9QmMGc+tVGZ4qTTZKSjIEMlyOKfJ/znqK/5lyIeOv06vRdgkqrjF3Y08dhGKpgeWPTodMPDTb12m7civiY1XL6OEbe20Mr0zGPR+PacwPvGPdIgv6UQJlf+IU3o+Epzue+r4bgQ7w/mGyfBjeSU4KCvm4R+rDBQz0fPD9lUoFCdtBFnRepXXOFApS6l7auNrJkR/7XwEoyWmu31JQobH4UxAkJUXNCYF/sUn6UlUp/g8H8rszRXuzRtV7wAKTXn1Dhrjqub8BwJyDGTNtJSUHKsCODdIinzThUsPwAelBA87UH6b+ccNgOxDtdGebFt97C36x88ehPNoTSq1rBLajxb9ycwZXJL77eHU6Opt2YaiP7v//M2066+/gdgkFAFw/Jx9dr0m/Hxy4xJ54F7ph1MUVxBloyu3k6uJKcD8ayS2xqObbquP9EOtrSCPDlCHSgRSvwcHUGK9OEg0ReIMX1nN5R/lON7pyyHI7xBlH1CwTEkNjdBOa1xzvUEZ/7OhyZEUbZtne5WjcIqtZKARjr1ylthLRSw43N00OfMyVdSO0fnKCtrrM7aIaNhBGGHh5+QZn1WGYlHhmA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199021)(38100700002)(31696002)(86362001)(36756003)(6512007)(478600001)(6486002)(6666004)(2616005)(53546011)(186003)(6506007)(26005)(8676002)(8936002)(44832011)(5660300002)(4326008)(6916009)(2906002)(66476007)(66556008)(66946007)(31686004)(41300700001)(316002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWJJNkpIVStsYzc2ektqaHlkNHFyYUpGWU90RTF1b3hRbVpQK095ZjNGZkZi?=
 =?utf-8?B?MkpWRTM2QXVGNDd0aE54OXEwMERTVEpPeUVBallZd1kzRUwyTnJhN01CNTFu?=
 =?utf-8?B?SFl0QUZHNVJCeGZpQnJsSGRtazRFSExHK0l6SlMrNDJ6TzdFYnJBRFA2MllY?=
 =?utf-8?B?ck9Jb0JEbmRjb0t3SjV3QlE4MUxrTFEyU1Y4RmN6VGl0bGt2eHkvcmhpY3FS?=
 =?utf-8?B?c09Mcm9Ldjgxd2V5YWRrM0l6cCtpdVV5WWM0dlJZbTQ2MjJwQjYwVmd4TDdE?=
 =?utf-8?B?OVpBa0tXYXdTcmM3TWVPd1FKcGhieGJnWTJFZjNneGFSTmk4UU13Mm8vTDlk?=
 =?utf-8?B?d3oyOHFyamtBdGRoTnhyK3lEcGtUYnBLZkZ3VitHMmppUThEdnQ3RDQ4MHh2?=
 =?utf-8?B?RitkRGxPcFBQUEdWRG5ySkRNam5uQU1XSVpmUmZBc1RVSXZ5MTJ2V2FUck5B?=
 =?utf-8?B?TUMrcGpxQ0FUamF5bVpjaGN2Yk9Sc3ZiR2lGc3hkMzBwQmlhRzd6a1FPcXRu?=
 =?utf-8?B?cVpuZ2E1SDZMR3FadFJUOHhPdWRnVU1SMEg3aXU4VmxRWjJXMkJrZ2s0TTRt?=
 =?utf-8?B?Z2s4M1lSV0hTMTVIL2poU01pRWxKQk5vTzVZcXhDRU9tSkNFMTlDT1g0WEw5?=
 =?utf-8?B?YkRHSElhNStpdmMyOGZFbmVkL3VYU2t3TVFJMkFkUmhRZG5kZHRhNjRXUHlF?=
 =?utf-8?B?cUtucU12NmRFOFg3MlVwbXBDRWIxN1RVUjBRazZmdzEzTW0zdEdUNE9ZSTRX?=
 =?utf-8?B?ZmYyOHVaL01GYUNxZDJFY08vUHZ3WE5USkoxbmpkZkV0di9oYmFVbFlCQURM?=
 =?utf-8?B?SGNBT3dYZnN4QWV1cHQxbnJYRnNLMldTNHlJOU8zNDBWYVIvOWRTNkJIVEFY?=
 =?utf-8?B?UU9iSEh0OFBYalhKZlJsS3UxSkNZR3lLLyswSnpvcmVjaGY1cTFNUDlkcDZU?=
 =?utf-8?B?ZS9sbnQrQndrMnVwd3hYcVBWVGhRakZ1VzZJaXBnSEpHaEIvNVZvdy9yOUtO?=
 =?utf-8?B?bEk4NDcyTlJnUVVpNk1CZktucVNjTEV6a0lGU2wwSGIvOE1qWDE1b3Z0VTVw?=
 =?utf-8?B?MkVUaTJPOGdqQjQ5eGtza01xbE1MVnJVNnF5VmxSeWE2Njl2c2Y1VHhpSGZz?=
 =?utf-8?B?QURNVk1JNllpUTVqbFd4NDV5STZta0d1S1RpTmZPdGptekVUT05GSnIybDRZ?=
 =?utf-8?B?UXRuYkgwVmFzMUFlVWlxSFdpTzR5Y3dnMm5TMXNTT2xJVnI5YzdtZmhUVnlW?=
 =?utf-8?B?OGJheStKYytaMHBRU3ZON2hQQ1RUOGVuM3c0UnFBNjV1ZitOWkJUMnhhRGxQ?=
 =?utf-8?B?S1NySW5zL2FLei83M091Zm9WQ21aQUV4N050M3Z6ZWJ0djNpYm02UWlUYXdZ?=
 =?utf-8?B?M1dDc3RSNUNKdUZ4eE5HaUlEQlRGODhtL2pnVHVRZHlEakZabzVvZThuYWMr?=
 =?utf-8?B?WkJuVUN2UHdOMkZ0a0VscjBWN3VmMW9JZ1B3VEk2b0hha2ZSU0VsNkdzWCtI?=
 =?utf-8?B?YzFyVlBZVFBjVVVUS1F3YVQxN0RQNmpSYkZqSk56U3ZWTFdRdEtoY0k1YVJh?=
 =?utf-8?B?THI2Tko4MEhTbDJwSnNpYmRTN0FVZkhpdEtnWXBnVEJQZmFyUFJzRmRZSFU2?=
 =?utf-8?B?SzduV1ZoSnhNRFFXR2QvaDNOZER6Qk1xeWFNMWppYjFJOXhFZVdnWDcrcEdn?=
 =?utf-8?B?bkRCZEc1bmJKWTJhN29MdWgweTVWL0tPNnM4Skpxd1Y3SVBSdjg2RnJxR1JI?=
 =?utf-8?B?K1h4N215NWNlKzRqbVBxc3Fnd0FEeUdBV3l1MU5jdHVzZGJCREN2eHhZcWND?=
 =?utf-8?B?TEZlTlpMak1MWnpvNnRnT3ZoOW5FbHFwa3o5REh4ZjV6SCtxd3RRQXV3S3hx?=
 =?utf-8?B?RVY3cmpUek1aZ2szZzRqTnpaU2JtNE5nSVNTT2FNZ3JzOG1Va0V0L3ZHdEY2?=
 =?utf-8?B?aU15MmE1dFk2RGJ6RVkveHlVWUVDaDBVRGhqMENKdXRFNzVsUlNQcFZFcHBr?=
 =?utf-8?B?UGNpM3RuMGs0NzVrTnpSOUNGNGZTNjQwWjY4QkcvaTlXR1BZSk9tamN5UUc1?=
 =?utf-8?B?RzFQam85Zi9FRVk4UUJBYmNZckFoQ0dHdEtkU0Nyb012UDJBcWRoakRsN2JT?=
 =?utf-8?Q?FHEhHuBEJe5zeg6FKHJNkL36f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98d0213-55a1-4101-f954-08db919c764d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 08:02:19.2426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rnS7HObJ6CSOKTbInmCl5A/KOTdTUjVKrHeAt1KmID39MSRw7spkDzagX0Lc/q1DCcbVuUzTNN0YgrZtKupEMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879

Hi Jason,

On 7/28/2023 8:01 PM, Jason Gunthorpe wrote:
> On Fri, Jul 28, 2023 at 05:36:05AM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> For AMD IOMMU, the PPR feature is needed to support IO page fault (IOPF).
>> PPR is enabled per PCI end-point device, and is configured by the PPR bit
>> in the IOMMU device table entry (i.e DTE[PPR]).
>>
>> Currently, PPR is enabled for a device when it is initialized for AMD
>> IOMMU v2API. To support paging for IOPF, the DTE[PPR] bit needs to be
>> updated when enable/disable IOPF feature.
>>
>> Introducing struct iommu_dev_data.ppr and enum ppr_handlers to track PPR
>> setting for each device.
>>
>> Finally iommu_dev_data.ppr is set only when IOMMU supports PPR. Hence
>> remove redundant feature support check in set_dte_entry().
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu_types.h |  7 +++++++
>>  drivers/iommu/amd/iommu.c           | 10 ++++------
>>  drivers/iommu/amd/iommu_v2.c        | 14 +++++++++++++-
>>  3 files changed, 24 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index a066f375ba87..321d361dfb60 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -803,6 +803,12 @@ struct devid_map {
>>  	bool cmd_line;
>>  };
>>  
>> +enum ppr_handlers {
>> +	PPR_HANDLER_NONE,	/* No handler specified */
>> +	PPR_HANDLER_V2API,	/* IOMMU v2 API ppr handler */
>> +	PPR_HANDLER_IOPF,	/* IOPF ppr handler */
> 
> This constant is never used, move it to the patch that uses it.

Sure. I will move IOPF macro to later patch series.

> 
> Why are you doing this? It would be much better to hook the GPU driver
> into the standard API, what prevents that?

Because once we implement IOPF support we will have two different path. Hence
adding variable to track PPR.

For GPUs, yes. We will look into the option of converting them to use generic
SVA interfaces.

-Vasant
