Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AB8210F
	for <iommu@lists.linux.dev>; Mon, 19 Jun 2023 06:49:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrUz01a0g4sOcT3F214T22FoMuekFl7W6al/UksfA34tg1pYMuJaFL1X4qWHGhFb24din98isVQd5w7Uss0sOSVQPQnSrzl+1/+qFmQwnYw3OptH0mjppGBm5ySsVianm/R1UgAROia088Xca0ho9ljryRRzalw24rlGFqwsQ/wQahbgBvCYS6muoJrtwD3hETE59oNVqZCtPxwIik4d7dvcc3bYBRsP2UsG87/K9msVLCfNged3tPh/7LCUF0uQmC8VIevcfgqUgljlHASsr5I94Lht1Vr319AaISSrsGMgjebDtrMCfH2zWO8OIjDKCSHx2pz25ZDnGIBtjbW7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XD2IvrxquKE3xljlqhRNuXYujHKt6Ev9Z5+9EF686qg=;
 b=Tx+yrPw7h6h6CHazpZFq8zq7wO1l9g624c49hppJgSgnVDKAadru3fYk1BuRtiq1ta9OmxmzP9CY1S+47+DTrLEzMVeuCHBmg5cQy6CS6zJkItlk9kwr2FlEIOGT+DR+jTV5xarpGN3NLTv2+wRQ+kJ66YJa/zzGJgMqVwVLXsbDE3rlPtKPDEIpCc78/9POo90HGfT4/a1HXefoC1hzB9wN/esfuOOk5La7+JXxPdDsWOA/l9roIpwgbEMItF6RsSEft4ezg+JxXBU7vQE1QD0/eAsd/sXjUO0ofGW/0wMeaI/6b6LDC1WVISD7b58w6KNjgBjl7b2WugvaVOUw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XD2IvrxquKE3xljlqhRNuXYujHKt6Ev9Z5+9EF686qg=;
 b=0TnIQFT/pO027rDFwkwI3pRBWNoR4XgfZrC7VUPukfRdqc3MWb8dmxpug4k7Qe1+d/BDOS9vOdGD6ukbM3riHzXATpJkQs3enZ0fQK9QhuH6wBio01SSVG7rTxc+torlGAzPfPgBt48dabTlI5rX4TZTerVxCH8cERmsXLHNm/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.36; Mon, 19 Jun 2023 06:49:13 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99%4]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 06:49:13 +0000
Message-ID: <358def2d-163d-ea57-c0c7-6d4affc68d0d@amd.com>
Date: Mon, 19 Jun 2023 12:19:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH iommu/next] iommu: Fix default domain setup
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com,
 Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
References: <20230614055627.27286-1-vasant.hegde@amd.com>
 <851e7760-94e2-9691-f059-e48aac9d51ca@linux.intel.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <851e7760-94e2-9691-f059-e48aac9d51ca@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH2PR12MB4246:EE_
X-MS-Office365-Filtering-Correlation-Id: dea5ae2e-9d26-48d8-55e0-08db70914abb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fecztXf6b9l70gHtOhiUfhrp552ZVPxv+8IPlAFnHjRfPt9DqfrAxmalBbJ9KaCMDy9uZpo8aiy+acyD8oxqgne1yYcaISPK6czKgFl9sio7c94jBaneLb/zEWvpg7lg63xkLP6EDAkdCd0bGosEwoNNeAsb3ElIt1jgNtgN+zvDe6FgHK3EyZPAjbzjcjJouO4F5ifYbbt7n2flKd6vrFqICztYfeTpuzjCWUdSne+E4iFH4Cb5SWa5Bf13zBMXUZIEs2v5J9LSRwk/yk/AontzFq+Je4ogF/xvEXlmLMTLQRN0cSDXqnRVHZTgjai82yQnSLNk3XMYGzO4NIy7VUoW2uMen/lfyFnxe3fe0kX61N1A7COApxP1pGFTWhRvemk1BShKpcfcP5SjjOP3CdjMxtpbi4zUbv8jrMuowUGxkKR+8dt4dfaTNjZ5UexjnMxbvu3n3tbowIhd47eJg/xK1qnSgDv/XeVeAjeA5gMKEfw1rJMGvpLbI+BuPf7S4bWHrzjIVkSIfcZ5Gw93CRGuOvLZhtn43MNJpKPSLoYoaUW9Xyk3SIFodNty96AjueqDICPPE6qSwz7XlAGJ7ZPW35uPXaGaF2SK6+Ja99703f0/n6FnZUSETon9GzbwrjIxbD6nP9HDm5pNZssbjw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199021)(186003)(6512007)(26005)(53546011)(6506007)(2616005)(83380400001)(38100700002)(478600001)(4326008)(41300700001)(66556008)(66476007)(66946007)(31686004)(36756003)(8676002)(316002)(8936002)(6486002)(31696002)(44832011)(86362001)(6666004)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NU1zbTl6dlZ2RFJ4YnBiTmpYT3dhK0UzdEt1Vzd0cVRQejR6QmY5emlLRFIz?=
 =?utf-8?B?NnZzc1NCNFdKSjA0dWw2eVpUZkk3ait3cE5Qc2lHTkdwdDVYOXJadVl2ZXVh?=
 =?utf-8?B?WmkvaXptR2ZKMitQSWxhYWN5c0RFNmp4MXFkYXNUM3YxOXlxK1NIOFVZaUky?=
 =?utf-8?B?YXQ1OG4rMEFwTDZYWko5TEs3aVhRenlSZ2RiRFhmTE1UK3Y2S0RwVkx5aHVR?=
 =?utf-8?B?Y2hJM0p2S24vL01SbDFBUzJ3NTcwM3NzeldtQ0J3akhqK3l2TzRob1VObVA0?=
 =?utf-8?B?aWpPSkUzVGRzeHNVSHFSZUxmMHVUWUluMHVzS2ZrelpFbklOSU1vSE1tZ25y?=
 =?utf-8?B?Qm4ydDNTVXNDTHZLS3JtUEUvV3ZFUW0wZG1uZUlGZklMRjljeFFaUEVwV3pR?=
 =?utf-8?B?cmNWYUNMRVptVk5qeGFRZkI3VjVDWStwOTN0eUEyMUdaaytYYXhFMXdnaXFG?=
 =?utf-8?B?Z1BsVzdrUlYvbW1NRlJNK05RM0hjaW1mWVBkdHVDbHlXamE2ZXZUcDZ3ODBR?=
 =?utf-8?B?YVdUVkoyWWZTeHBvajNNeFdDZFBCNnpQMjJQbFlId1dwWVlLbzhPbGR0NFpD?=
 =?utf-8?B?NTA0MXRMOERGY3NwemVzbjV6MVJwMFBRSXRtdVd1Nk9CcGFUNUZzZzlONmoy?=
 =?utf-8?B?SjRoVzlRaEpHd3BsaTVMVzNZTk9UMXJpaVRSUWxDSWxPbG50TFZQandtOEpW?=
 =?utf-8?B?aTcyWDd6Q3c5d01zS3EwRGJzUmxoVzJKVnhkWGMyQlljWE5CQTg0cWw5M09B?=
 =?utf-8?B?V3p0Tlk0VERjVmxqMUl6Y1YrMWxYUGFheEJ1dmxoUHM0TVAxdkovcEYvSUdC?=
 =?utf-8?B?aEp3WmVra1BxQW4yNno0L00rSnYzeTI0ZTZVdHBrN1pNUlFleUh3NTZXNzR5?=
 =?utf-8?B?bk92K2ttZnVtamtSZEhRc3BNcXhuNTlaTkxkcFFSSDFzQlZtL3o0VVFXdm9p?=
 =?utf-8?B?VXlVcjRXL1VCU1lacGlHWHUyTGQ1dnZVRTNTZU1mRS9ZNHpSdC8yWVd5M3RN?=
 =?utf-8?B?MS9KWERMYmQyN0xYTHlPdnozdUZ5bDNRQldPejFKdnJoRzREeVRKNzNEWm1l?=
 =?utf-8?B?bExLeGw2QlkyenUvZmc4TmJIVEowMlQ2dTJuQWl3bEpNVnhVRUFzZnYxdjJU?=
 =?utf-8?B?UE8wWGMzY3V3T0xLS2dtZVNDT0d6enVKMytjZ0ZTaXROd2JjczEyRjdmV1VB?=
 =?utf-8?B?ZFM4M2NEK20ySGxxaDFZQnhReXFjNEo1elhnSEJjM2lvQzcxcFBDbCtwT2xk?=
 =?utf-8?B?OEJLM3dtZGNYN1I2bnpSa2RjdHF5bEJqcGVUSmRIU3ozYUZFWkMrVU1zTWE1?=
 =?utf-8?B?cC90azZHWTBxSHgzQWtpQkh2QVdBWXliL0hoTE1McGlPRVB3Y0xMdkVSb1F1?=
 =?utf-8?B?TFlDcHNwVzJhejJNYnRka1A1eUVJQjhkNDNpRFptWGlHSVRJL0MvRGc5clV2?=
 =?utf-8?B?S3RKaUwwZk4wcDlCOTNyRmUzbHM1Wmx3K1BtclRvSVNkeHZIN0pTWGtWWStt?=
 =?utf-8?B?VHRQRjVOR2w2Ti9tRU1DeXpRMy9HOHRNeE15alJ5eklHRHE1UGV4QXJzTG5H?=
 =?utf-8?B?dEhLbmFWTVNlVjBWTm9pTGV1dnkzMElVckhrNU9MMElEZFdaL2UyalRDZGcr?=
 =?utf-8?B?bk0xU2RZRkpWVWJDUDV6RWhYOTdlOUxnamtOckxXaWxhMzdhdUc2Y0ZESUNB?=
 =?utf-8?B?bUxHbUF6QzhEUkt0RDFxbU5oRkRQTHlSNkNoQUhqMkZ4eS9tc0Jjem9adDRL?=
 =?utf-8?B?bVNRYnozUUpuQlpYeTRxUnVJbjVwWW05Zk05amdKaWN4STJjYWlGaTFET2R3?=
 =?utf-8?B?cXVJNjdQemM2TEx2cDM3T0JqbURJaThqbkhQeDVhUXBzdzRJUUtBZ0hnQ0RQ?=
 =?utf-8?B?QWZlSFptbjIxbXh4RE8xQ2VPSjNlRWZ3WW4rWk5yS0lZRnhRMlFqcUFqM25a?=
 =?utf-8?B?N3dUYVBUcTg0QzNpMS9xS3ZBellVZnlJRGF6ZjhLK2lBd3l1bmo3MW1hWGtF?=
 =?utf-8?B?K1djR25UZVdYN1BVcUMvMU9mT1lVRld4TjhGa0dKRXBoQnFrUkhITTNWVDIw?=
 =?utf-8?B?WDVOWVd1UkZ4SkNuMWg3MFpNUmZuMlhscnBoUldJaWJNQVFHWTludHNOVW1S?=
 =?utf-8?Q?W+yPewcRFiPiuoFJrkEYch2x4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea5ae2e-9d26-48d8-55e0-08db70914abb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 06:49:13.3149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaTTkSnGw4vGaeBO8leCdOqxhk8uklbSJ1+i+6Td0607MBrCprkdjwlnZuMmRZbYAoP2+CnVR0AcPzt/PJ+ejg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246

Hi Baolu,


On 6/14/2023 11:57 AM, Baolu Lu wrote:
> On 6/14/23 1:56 PM, Vasant Hegde wrote:
>> Commit 1000dccd5d13 ("iommu: Allow IOMMU_RESV_DIRECT to work on ARM")
>> accidently restored "group->domain" to "old_domain" while keeping
>> "group->default_domain" to new domain. Also freed new domain.
>>
>> This works fine during boot as 'old_domain' is NULL. But if we try
>> change domain via sysfs using below command then kernel crashes with
>> "kernel NULL pointer dereference".
>>
>> Change domain command :
>>    - Assumed we have single device in the IOMMU group
> 
> Nit: The requirement for singleton group has been removed.

Yeah. I have seen those changes but forgot while writing commit message. Will
fix it.


> 
>>    - unbind device driver
>>    - echo "<dom type>" > /sys/kernel/iommu_groups/<group id>/type
>>
>> Fix above described issue by handling error path properly.
>>
>> Reported-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
>> Fixes: 1000dccd5d13 ("iommu: Allow IOMMU_RESV_DIRECT to work on ARM")
>> Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
>> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>> Hi Joerg,
>>    This patch is on top of iommu/next branch.
>>
>> -Vasant
>>
>>   drivers/iommu/iommu.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 9e0228ef612b..d21d0a217bdf 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2880,7 +2880,6 @@ static int iommu_setup_default_domain(struct iommu_group
>> *group,
>>       }
>>         /* We must set default_domain early for __iommu_device_set_domain */
> 
> Is the above comment still relevant? If yes, this fix seems to be
> problematic. Or no?

I think we should keep below change.


> 
>> -    group->default_domain = dom;
>>       if (!group->domain) {
>>           /*
>>            * Drivers are not allowed to fail the first domain attach.
>> @@ -2896,7 +2895,6 @@ static int iommu_setup_default_domain(struct iommu_group
>> *group,
>>           ret = __iommu_group_set_domain(group, dom);
>>           if (ret) {
>>               iommu_domain_free(dom);
>> -            group->default_domain = old_dom;
>>               return ret;
>>           }
>>       }
>> @@ -2915,16 +2913,20 @@ static int iommu_setup_default_domain(struct
>> iommu_group *group,
>>           }
>>       }
>>   +out_free:
>> +    group->default_domain = dom;
>> +
>> +    if (old_dom) {
>> +        iommu_domain_free(old_dom);
>> +        old_dom = NULL;
>> +    }
>> +
>>   err_restore:
>>       if (old_dom) {
>>           __iommu_group_set_domain_internal(
>>               group, old_dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
>>           iommu_domain_free(dom);
>> -        old_dom = NULL;
>>       }
>> -out_free:
>> -    if (old_dom)
>> -        iommu_domain_free(old_dom);
>>       return ret;
>>   }
>>   
> 
> It's better to split the error path from the successful one.

Sure. Will fix it.

Thanks
-Vasant


