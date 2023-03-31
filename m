Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAD810E5
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 04:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680237002; x=1711773002;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=lHVE1E/P5t2U+xncc36PU1KTR+T19HEzEqCf+/m9Tuk=;
  b=EFfCbd8Zqf800v6Bf8FWs0RaqNR3ufzaU57NKLffbY/s+2e61f+DfQFd
   EJ1+JwpF29zImNrjWA86RkQWw9NIfpenMuf/ys0VMLFdChld6Z3JsKQW3
   ZrrZ1ITwTXczrO/6cQE867Be2vuAYQqNtZxLiNW/Fq27n2bc01gYHLMNd
   fBG3KfsgddyUsTvFXezxYm5VWYtAh62XKnd3euv8ThKTHZzX3UBCmsEzL
   NNSQI4O5NEfwSPeWsU2hXmI7/vL4zFXC3x5dz3VRzF2HGkJIXfDdFBvoY
   Rd5t6JgVtxPd0AjDEFW8Y4R5RG+wXdra8dGWTtwUfhhUmUr+qJk6NgiSR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="341367067"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="341367067"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 21:30:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="859153093"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="859153093"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 30 Mar 2023 21:30:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 21:30:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 30 Mar 2023 21:30:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 30 Mar 2023 21:30:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OC/K9pxh5k1trW5EAIQtaXXwgZ8qQTkCM0dxNdUzc/YoEkhM/KrIBe0cBJJuYx/a8MxhmE0HqIroZD7C2BM+2GdIz2pwXAdN0hnRrlI84VmyCvW3zuhGrgPWc5hwFEJtMWNb/oaWDsLCdvHuCxFikeidIj4eGgz7iwnvNDtqlUTxSwM9oIqtwjJDD29TDRVk9lDm0tXv3it17j5kUuYrVIbg25Oe4vImdL7AuropWwZ+yV6vvhjKJ3p3BGzc/DwCRZTuKcWC80c2rDs9o+9CM1o/BTWL1uMesoUlG8nWOfeRAnKrLvxIagk9SaORvHicwqgUHuxm1DqPJIA1S1154Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItU5PmubJwGXYXz+ZwH9vN8+Af9vjJ6x0V9tVrzQLNg=;
 b=gfwbrS86qSFc6N/Gv8S7r8xSI4KZBJgUBzdJlg/SN1n34mQ8xwVZf0yGbQ/JDB+OkIa5f1HNA3/+Y0S2Xs91sTXzB2KztfxgPiAuaIv7ltCk9BmDz2iqFUc1mr1zrUUUz+33qok1enrPSejANxDmQcedGSiiZ/sHDdtvxLTG387T99sWgJSxzQnR7HKztSCWWHJJxVXw4vaMQmeQNbFTPF+DrhkPn83OF1wvWcbNCZvti8DMYxLzjIeoaQyRP+jP/Ro8XkCDZHSupLvBrPcdRrX9oAlQazG39Y5SG4gERLS4o/dxeYZ1RXEU2G/T1WEoXl6MrXyYeCfx80rsTLZoMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by CH3PR11MB7896.namprd11.prod.outlook.com (2603:10b6:610:131::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Fri, 31 Mar
 2023 04:29:59 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6e3:782b:3976:5005]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6e3:782b:3976:5005%4]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 04:29:59 +0000
Message-ID: <0091d604-1e40-ba4e-4403-a3972ad813c5@intel.com>
Date: Fri, 31 Mar 2023 12:29:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2 7/7] iommu/vt-d: Remove BUG_ON in
 dmar_insert_dev_scope()
To: Baolu Lu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20230331024236.2716001-1-tina.zhang@intel.com>
 <20230331024236.2716001-8-tina.zhang@intel.com>
 <74239dba-34c7-e565-a293-16e022523f4c@linux.intel.com>
Content-Language: en-US
From: tina.zhang <tina.zhang@intel.com>
In-Reply-To: <74239dba-34c7-e565-a293-16e022523f4c@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0162.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::18) To MW5PR11MB5881.namprd11.prod.outlook.com
 (2603:10b6:303:19d::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5881:EE_|CH3PR11MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 87b73b93-95d6-40cf-b2b1-08db31a095d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWst7nInJFstYwWjgj+uU1veyCgli9q86XTDfktP8lQz+22qaohqIa8JXsp/ySULr4tnoSfHS6gle0BAU4c/TrUEJg1M0U8xzhI8UeTa12yf3aUgC2MnnvK2eCGG+CZiRMxnSJFBz8rvmRkkntl+RzTiJx6TI9F73Ja3N8XgUzcaCKTTs351TJyBgG1s8KpYm7u8oQIlgYqokgF1UUuBZXdDC7CXJWTc61HIafv6GX0vpMyQHyhX0jR/Pw5XQmZcFTV1fRQxFhd8UBKwco4YVH2qeHQAB52d5+u990YygR9amYUxxR2GHf0d45ApwM2LOJDixXim4FUACR0keTi7yBVuzvuwW1nb2FErqkH19Qx3dR1jktwO2yM0dlV12jnJwQWLUvjj20ty4W7fLE6hmemENdfQI5W8wp7VrvujE39cmYTZNG0KM+7JnP2AfPSXTGeZ3SbS0nvGRvSiLkPVmnZB9sBbtGWKrMs6017UPt/Jan0OYWrb9BAYtdRccqeIMUXwYT1hLKwrQuw8Xq2R/J6a1CBlyzx55QD0VR99JiMud8Oq2f0qBN4ZNGkxAS+TT9c6iNgzc9ziGzOpEL/WLIDvbjM7ZnEQhukA7gvuaXqgL841Vb8HwKq0Q5iTFKzg/cosZElmP8g+nYL8tUJe1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(2906002)(86362001)(82960400001)(41300700001)(5660300002)(8936002)(38100700002)(31696002)(36756003)(31686004)(53546011)(6512007)(186003)(26005)(478600001)(966005)(6666004)(6486002)(66556008)(83380400001)(8676002)(6506007)(66476007)(2616005)(66946007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGNCT0pmcG5Oa2g4NmFiM3BRTUxzOXpQM1FETWZHamhnRHQ1QTQ3dFhFOEIr?=
 =?utf-8?B?dFZpbURzSGw4aDAvSjEwK2ltR0pTY2Q3cHpaNWVjaStIQWJOL0paR3ExTS9L?=
 =?utf-8?B?UFJLYWo0SVJBWWsyVUVFOEtIM0g0Rnl0Mk5NZUxERms5TTVIVnFpRnM3TXJl?=
 =?utf-8?B?Y0pMM0Y5OXU3MlI2Wk5Oczlqa00zSXpoazlyVmxsbkpiRTFyZEdvbWNQWXpw?=
 =?utf-8?B?d3dHUk8zaEE4bEphRm4rS2FwRVlpcHEzd3VSNUp3UE9HZXkyQVE3RTFmOHpw?=
 =?utf-8?B?NkJ5ZnE2aXRZWEk2VFJXRG1JZlQ1bjZ0bGd0dzgwM29nQnhseHY0Y1JsNERh?=
 =?utf-8?B?T2VBWFE5UllITUM5UWprb1huT2hGSGhkUjNMTVF5MmM1REliU3Jhb0tZYjgv?=
 =?utf-8?B?eU5PUmdRY2FpRG1adzVTUkFZOGxjOHpmY0hYOWV2NURFRS8rZlJydVZ1MkNw?=
 =?utf-8?B?N25GYWFxM3ZtUytPbXpLYnBRbkRMRjJ5a3JPNWM2dGJ0Q29MTG9yYWw4RG1q?=
 =?utf-8?B?NVZpa2YrNGVOSzJsd3NPbWtmUU5RYnVWN2tYTEhSOHh4WFV5SVVEYmNlNGVu?=
 =?utf-8?B?bUdWS3VaTHdablg4a1lNOGpjdFJ5K2lhU2I2Q2c3MUpPVnpLdlovdi9tTHI4?=
 =?utf-8?B?R05TSW4vMTRCUWx2YVlMQm51M1FhOUgyWks0K2c1NEN4dEdwVFR0aFM1a2xK?=
 =?utf-8?B?b1RRL2t3QytFZHNyNDNFVzk4NVJPVTVpSFVTMlBLV0ZUL0wxS3c2eUhJSDhi?=
 =?utf-8?B?eFJ3K3czTnZWei9jcDd5YkRWZ0RjWVNnMG9zZHZSMmpsdTUwZTdVYlFPL0po?=
 =?utf-8?B?SHJmNWJYaXFVb0ZnbTFBR25ZRmtsL2w1OXc3cGR3WXdBcWRmUTZsL1orYXF2?=
 =?utf-8?B?NCtaK0YxRVZxbHJRbGhEUk8ycGZsQWRKNzNWWFdyTlBEMUd1OXVja1hUaEtm?=
 =?utf-8?B?MFFqQXQ3M3QxY1ZBSE1WVWU5NkFOSUwxRDdvemJrbXQ3WWNRWTZpZlRETWZK?=
 =?utf-8?B?WlQxQU8zSWRBeFkxYnB5OGNpRjVFQUZJSGVDbzB4S0EwRUJTbW1EbGIwcjFz?=
 =?utf-8?B?MmgzZ0V2S3pvODBPc2o4NVhOdVBzQ3VSbitKM3h4VE95c0p3NWpsVHE3Y0Ru?=
 =?utf-8?B?VGVqdUhVTzhqQU1Fek5PbVJXY1dEQ3YyNkpZenVPYzNJTXRWTy9kdVJTRG9m?=
 =?utf-8?B?TzlHU2RqSHNZU0xEdU1jM0k2Y2l1SmY1MGV1bjdrK3JwaEVPekZYSE8rVnJs?=
 =?utf-8?B?TUN4aEgyMTZxaG1vTWIvQ1lvb0NVVlVVUDl6c1lVczgyS3FKOHdPa3ZRTlh3?=
 =?utf-8?B?eWJ1V0VsUE15d25PVGpVUk9XMyt6TmcvVHB0aklQdWVzb3plc0VPdXk5TnFP?=
 =?utf-8?B?My93UHNiYzJZM2IyU0ErU291RDIyZEZ6SWtvQ09JLy9mdGdnMEEzUFAyeXhl?=
 =?utf-8?B?bGFmTWhOQ1U4SGVScUJUOS9NYTBjQ050eHAzdXM4MkNWUTJMUWFvbjVnYTNO?=
 =?utf-8?B?elptMEVOMENlc3lLalZBTDA1U3lkcmxkdTQreVA0STc5NS9kZzNLYlU3N3FC?=
 =?utf-8?B?NnJUZVNObTF4MXlCZ1NVc1NRc2JtcHpUeVJBRUNOQmI4NDJTTWd2SEZTMU5n?=
 =?utf-8?B?cG9NUEZhZG12eGEzYWZYbzdsdE43My9iczVEWWpNRC9MSlowRWpaYUw3eUo0?=
 =?utf-8?B?WFBBV3JSMTRWMS9FWFRGcjN6d053RzkrbkJrbXFoR1FRZjFydUtpMmVvV2Vp?=
 =?utf-8?B?TytEZC9hRm12TmtHQ3lHTWc0YjczSnJXWjlIK0twcTB3ZlJ4c0NrRFR6T3NU?=
 =?utf-8?B?YzZ5K3dTeVhKaFVsb2k3azBmUTFmUVpFTkVXaFgvVjlnSlFHeU1RM0xjeE4r?=
 =?utf-8?B?QVhiWFIzVFNvT0xZRHo0bGtUV0F2M2szeFRpQUdNR3RyTUJ3VEFSZnc0N0hr?=
 =?utf-8?B?N1ZWZUw3bDZmcFNWRDFwR0pUb0xmdVQxZlNkV203Qmw4Q0x4eXRzbGxlTG1D?=
 =?utf-8?B?NmZHZldSSkxNK2V5NG1VbTUyNnhYeVV3Z05BVlAwaU5Gdk1oSm9pUXBCdlRs?=
 =?utf-8?B?Z0JLc25VSmoyK0xIMXVYYldHbTlqRGZjS0hpcG9Fc3BHNUViWTByVWVJcG80?=
 =?utf-8?Q?vmoafr/J5X/h9v6ssjpZVsBt+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b73b93-95d6-40cf-b2b1-08db31a095d7
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 04:29:58.5160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akmBdTu6F05qVhJlJDtEu5xRdI+9J0WSRV3XWxxmyavEHzB1ysZzMfBPh1iuDdfAXsXB4KU/T+XP3h/int2crA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7896
X-OriginatorOrg: intel.com

Hi,

On 3/31/23 11:27, Baolu Lu wrote:
> On 3/31/23 10:42 AM, Tina Zhang wrote:
>> The dmar_insert_dev_scope() could fail if any unexpected condition is
>> encountered. However, in this situation, the kernel should attempt
>> recovery and proceed with execution. Remove BUG_ON with WARN_ON, so that
>> kernel can avoid being crashed when an unexpected condition occurs.
>>
>> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
>> ---
>>   drivers/iommu/intel/dmar.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index 9684c96247f8..7eceee081235 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -262,7 +262,8 @@ int dmar_insert_dev_scope(struct 
>> dmar_pci_notify_info *info,
>>                              get_device(dev));
>>                   return 1;
>>               }
>> -        BUG_ON(i >= devices_cnt);
>> +        if (WARN_ON(i >= devices_cnt))
>> +            return -EINVAL;
> 
> You have returned an error number. Do you still need a WARN_ON()?
I think we'd better keep WARN_ON() here. Because this situation isn't 
expected (i.e. this-should-never-happen) by the introduced mechanism[1].

[1]: 
https://github.com/torvalds/linux/commit/59ce0515cdaf3b7d47893d12f61e51d691863788

Regards,
-Tina

> 
>>       }
>>       return 0;
> 
> Best regards,
> baolu
