Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583C18498
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 23:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668470138; x=1700006138;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Ny43AZFyEgeS/FcRb4zDFJEaSCHe7waFyx/1bGxjtpE=;
  b=BH82akc8xQuKrxogrtAG4kg5vriDZ0bQVrpNV6pYgl4Xk7P+8o3qSQSr
   dc5eH4/4BCYrzTr1WzaP+Qx+UFP4cb/C+o9aGL7U3o4j50tqUj6F9nCLE
   kQOactxX1D2+v0CS51MFHryI3u2rr5oCkNPHXdsoxXlHJSvjlG4hLFfiS
   jFziwgLIZCHMBQzEEaO4OmrCLw2r5CHPcMZKUsBFvWouxUaxUX91bO+G1
   Yru7ZvNi27yZh+i+pAVKwrOGK3bRHbVhm/1fwF1UHO2l+RUop1w/6ZHY+
   beR4JWhZ9kgXcXp7vNd2qnVy2HYP2S9IQ26lmlQgZdPShDBi/rd7ys5GI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="398406209"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="398406209"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 15:55:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="781129203"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="781129203"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 14 Nov 2022 15:55:37 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 15:55:37 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 15:55:37 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 15:55:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2pu6+qa+o+fZHtrlVEf1E6BWqJQZ8WzCsHaLJCjtnVsuzz5s6vq9wzl/oop9nx+AkFPUad/dQOyXdqTGKN5nEYohk6bhzuiNZ4FJGfCSQ1gcayH9HkOtDiFK6Avl3l883v12eEBY1xBlBGWM7yiAkTmMuI4sWWF7HzAicBh292MneuCgalg73I8Ei3g6G1RMwR14z5ohl4XDXqGKSuDOV/j87NwZJOtQn2A8x+oJe4qQC0hBTi05TSAssInjoCtZRWSd/lGZppjxCjdz5RThDQgQGGpmr76ahkIMFVOaQ2LrNRiCcV/Qiaag3HhX+a9Hfv8vV53GZVIPR8Ct3OYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrGZTQYzUb1BeQ8no18jEFc/i935EHG16jW/zGlwYo4=;
 b=KD475MfIrTSln9sqN1ajTWZM5OeldtBfyRdnGBbFM1rYb2RSGZI8lkb10rTgyYvS5aHjGPrFMEL7cqF/xjE6YDb07EX+bjhAZxlMk72YyU8SAR6xKrkrcpL0yhyyQRSjN+vNdHjkLNrw/JrQH+caDkNyXl/1Bm4mGyHFaTTS16e2Tkp72z2/nFKKrpLjss5qHVu993lF8hWHSuODKBcR4mBjUI3n0isGWBD2xPx4aFkQpRfLi7gYqwJjzbaBB7NAaqRf6QSASZQQZgwDnk1rWyBDbTSsgG2AWZKoslApOrOwoxWVnJNCtJx808j9sFpCCqgtEC9P7uqNy74eejolcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by SN7PR11MB6921.namprd11.prod.outlook.com (2603:10b6:806:2a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 23:55:30 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::468f:5d8:f147:1cb8]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::468f:5d8:f147:1cb8%3]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 23:55:30 +0000
Message-ID: <adfe9835-2a05-95d8-5506-5fb6163bed43@intel.com>
Date: Tue, 15 Nov 2022 07:55:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] iommu/vt-d: Set SRE bit when hardware has SRS cap
To: Baolu Lu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20221114085514.1105039-1-tina.zhang@intel.com>
 <6a34aa78-17d2-bb44-1e50-76239cd1ffbb@linux.intel.com>
Content-Language: en-US
From: tina.zhang <tina.zhang@intel.com>
In-Reply-To: <6a34aa78-17d2-bb44-1e50-76239cd1ffbb@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To MW5PR11MB5881.namprd11.prod.outlook.com
 (2603:10b6:303:19d::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5881:EE_|SN7PR11MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: 71310009-e3ea-4db4-ad30-08dac69bb626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7fGtFOHUdhavloabtiBGfX5aSXimRjB4TVcpEHhnKI6DF3Je42MgDHX3BQCQfHbY1UYcOBjYcxqFzO0tR9i/+r2O+B8pS01Sfq8BEjkYpE5fHy3q99oP7FS+GpMP4/D84C4ZGTR7IrXR2vAj3TMR889L2RqG43rEPeNpzVlzYtAo7i9CPgUQ6xymgvyJk0e6FNp6jVRKrCD3OBkUp0z+nIAWcyvya5QNwY89efCaUKJcQYEEBpkxi2MIpS9h0VOQ92CsQldeluO6eQIyXKQvN2nlPxUFd0stTxn+PFCWnZL7lc2DSO/vpXaddy4HZqJ+b3mO5O3UNBpzNaOh9pVhEuuLZKjuddLap7jKMrH1wCtP3zk5+Iq4So8eMY1DWTeOoR1DMdnk/pi5+X25KGvKsjmTQNlIV7XTQVj6DWtQsYLwZikfHHGbUbDDaKkg7gDhxxn8NlzBwhe/2Jw49PlCd5sMpfO7IuXByxnCrsic9IHw4uA8drnRIe1/WoUK3xp5J1tAPrUb9UUMFX/QJc6hG/pTkKz0aZFNoA/Y1YRV56MigGHprUcmN3lCEf1mo+w/3nbU7UmZOVFoP2zyYnfJ4FINxefSP6ifzsR3WhG16byidLLWr9NM8Sq9kbwoUazauc2bOBaXJDaJYoibALfpDpDbG2AZtQwLrfXKG67WWbQiLh5/q/bwWib9/Hx0tRGEmvOa810+AeqFHcBkbXqZvIdSadDb5B8kjeyUyh18dX8xoOjk9BL0ODIjV6KQqpkRTYx5CQgg/egg1rb55Q7+tsHkUl58ENj5ObDJ3dJusxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(26005)(2906002)(6512007)(66476007)(8676002)(66556008)(66946007)(5660300002)(316002)(53546011)(8936002)(2616005)(41300700001)(6506007)(36756003)(38100700002)(31696002)(82960400001)(86362001)(83380400001)(186003)(6666004)(478600001)(31686004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTdhcTBqQWFCb0FmeUdrbzlhaDY5aE1aL0tRVmFMT1N0NjZFLzlJZCs1cURa?=
 =?utf-8?B?NXRtVnpFaE04OXU0RFAwWWxqRWhKTEk0VlNXZ2liZlZ4MG9DTHF6cnA5bEY1?=
 =?utf-8?B?OVRTM2xFRG9Gd0JhN1FHeVFqaVN3Y1MwUUdYMkxCd0hoYlAwNnk5T250N1Vr?=
 =?utf-8?B?ODFEc3Q0cEhzaWdDV3lOeXlmNDVHbW9hb283eitiVFZmT3dDS3ZodmFjaDNq?=
 =?utf-8?B?cHBUdCtTS2s4SkZTVW96aDhrNHlsdXRkaHc3YTRTTWozSlFTZmNWaDVvN2ta?=
 =?utf-8?B?UEJiT2MvVVdqc2x0VXZRUWpjbW9ra3k4UDVZbUVleExXVWN0TjZrVzdQRG1z?=
 =?utf-8?B?aW4rQi9DeUo5eVFMK3NQOHFtckRvTXlGYmNBbkZVKzJEeHZDcjFKTmxJTnEv?=
 =?utf-8?B?eDJONzJuVnFHWkJ5bFVxazBGVW5PMFlCS0lVZ21PdlZFSHo1dS92b1ErZUhZ?=
 =?utf-8?B?MkloSU1Mc0p2Z1VLSkZoTzJPVTYza21mWkdXUER3NzNxR3hpcElHZThQb3g0?=
 =?utf-8?B?ZXRZZ1p5SWxndk5FakluRjdERHBKWHNBaEFEcGFLc1lmS0gwRm9jSWtmeDM0?=
 =?utf-8?B?SmJaenV1bXJYWVErZVFXeHpMRWVSOXBOU0RUdU5qME1Md0ludE5OQ0pGZExi?=
 =?utf-8?B?Ujd0VXVQMEprS0Zid01aamVvVzBGMjhzRnk4L1NvTnhOeEc1YUpXaWpLeURr?=
 =?utf-8?B?bEFjbEJTQmlManMzS1pRZXRiNzBQaTA5MjZpZjJJOUZnWGRGZG9aNVZOZ3Fw?=
 =?utf-8?B?YnJVUlhLWnZPV3VjeStCTnA4Y0t3anBYVi85RWl4V0I3UzRpQkZXT2hVZWI2?=
 =?utf-8?B?VDNzQjBydVV1c1A2Qy83WDg3QThHcFBSS2liTWhqa2x6NEQ1LysxcDB2K3FQ?=
 =?utf-8?B?WVlPRGIvMHE4TFRZRmVGcCtiSk1TN1RlaVAyN0JSRnpvVkNoY21xNHdRaVU0?=
 =?utf-8?B?Rlo2MXRpSFBUYk9VZHFENmUxcnFRSU90SG5UU0FUQjlDNE85bFhNa1dUa2RD?=
 =?utf-8?B?QnZQL3RHM0RteFNvNEdYSFA2NzNRaE5XNnBqdTNnbUUrWGhXSGtKNTBOR3JE?=
 =?utf-8?B?L1duZnQrLzhQQW1tV0tUSnovZm9tWTNMbGdseHZjbFBCcktsSmlhR2hETU0r?=
 =?utf-8?B?MkhiUU9jWGxFQUxkU29uMnQ0a3dTa3E0Z1ZTeWYyblZxUWJVeE9IaGplaVI4?=
 =?utf-8?B?TDZHUlVkVm5obThVWXlGTFAxUFVMNU5nUjZBN0RqOVl2RCtxSWRLQlF5eDVP?=
 =?utf-8?B?ZUd2VURZNDRyQW1ja0N0VTloTnhibzMvT0FQRUpwUHJWekMxd0JiL0pKYW53?=
 =?utf-8?B?YW5nbEJ2RXNON0dpQmt4eFJuUU5XaWMvVC9ONEVUUWd6UnRSZGlnaGI2L3Jp?=
 =?utf-8?B?bHJldUpUS3VZNWVDUmthbWRudDR1WHdZTFhVdlN5V3NIL1VnMUNTQlF1M3cr?=
 =?utf-8?B?NTJSOC9jekZiRkZwMGVWYXBOL2YwVGRqUkt5bXR4dlpmd0ZsR3VJOXluU2hF?=
 =?utf-8?B?NzRyNEVaeTU0OWQyblFrakpVTmEyTS84MHVlOUJKbGFvdVVURDRwWGk5aCtu?=
 =?utf-8?B?NDhVTUZyZTdBWUJhMzBTQ2lRYjNUb3BVWFlqaklLOWwvY3BnMkEwRlVxdUNL?=
 =?utf-8?B?Ymx5bjNUbXg0eUlsbU1naWNQUE5SS2U1SHNHcmI3WkxZc2pLSTFwZWt0TVRE?=
 =?utf-8?B?R3lnTnEwRGhTQnNVQkx0MGRsOXZnL2NBa2I2RWdpeis1eUZ1N1ZCc05HWnFH?=
 =?utf-8?B?a3Q3ZHpsZXJBNlVQa1JaNjhFVzhTR2FPaUNhZXFKYlBVeHp5V2J3RnBzUkZF?=
 =?utf-8?B?K24zQzA1dWh4elUybmtHTVRBQ3VLb3RVTnVEK05YNU1pbTlKVXdIaGt0YjV2?=
 =?utf-8?B?VnFpeFM5MVI5d2c3eC9rejI5NGFVRXNrTWw1bW9nVCs4R3dZZjFxK1diWnZD?=
 =?utf-8?B?ODNvK2lEQlJOWGk2cjhNT1NNOWVpdENvaEpyRXNKbzVDbnNtT2YvOGdTVnQx?=
 =?utf-8?B?REcwdFo4VWtlTm1wNEpLVlQ4ME96cHJoV2gydFlQdkkrc1NzSXhaTlk4YU15?=
 =?utf-8?B?RXJQbFg2VjdPTlo0aGwrUC9vdGNpOEo3NWdCZ1VTUFRtRnNSc3RyVXFoYjN1?=
 =?utf-8?Q?ofjkv52mgh4s3fvdUgGl06PzD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71310009-e3ea-4db4-ad30-08dac69bb626
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 23:55:30.5814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eO/5f6QXAb7iBRljaj0AK3vKEstO1AA0+aGdemnBYWoCrvHlySGW0LBS9tU2gpfNfIJ5xox1VoGDF3fm7CWVJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6921
X-OriginatorOrg: intel.com


On 11/14/22 20:00, Baolu Lu wrote:
> On 2022/11/14 16:55, Tina Zhang wrote:
>> SRS cap is the hardware cap telling if the hardware IOMMU can support
>> requests seeking supervisor privilege or not. SRE bit in scalable-mode
>> PASID table entry is treated as Reserved(0) for implementation not
>> supporting SRS cap.
>>
>> Checking SRS cap before setting SRE bit can avoid the non-recoverable
>> fault of "Non-zero reserved field set in PASID Table Entry" caused by
>> setting SRE bit while there is no SRS cap support.
>>
>> Currently, both intel_pasid_setup_first_level() and
>> intel_pasid_setup_second_level() implicitly take care about of it. The
>> only missing SRS cap checking is in intel_pasid_setup_pass_through().
>>
>> Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table interface")
>> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
> 
> Nice catch! Tina.
> 
> Can you please double check  intel_pasid_setup_second_level()? Its seems
> that we missed such check there as well.
Hi Baolu,

Yes, I thought about it.

In current kernel code, the intel_pasid_setup_second_level() is called 
only in one place and value of the pasid parameter is PASID_RID2PASID. 
In the body of intel_pasid_setup_second_level, the pasid_set_sre() won't 
be called if pasid == PASID_RID2PASID, see:

intel_pasid_setup_second_level(..., pasid) {
	...
	if (pasid != PASID_RID2PASID)
		pasid_set_sre(pte);
	...

}

IIUC, in the current kernel code we don't have the case which can test 
pasid_set_sre(pte) for second_level PASID_ENTRY_PGTT_SL_ONLY. But in 
feature, if we add more points to invoke 
intel_pasid_setup_second_level(), we may need to checkout this SRS cap.

So, do you think we should include the checking in 
intel_pasid_setup_second_level() as well in this patch?

Regards,
-Tina

> 
> Best regards,
> baolu
