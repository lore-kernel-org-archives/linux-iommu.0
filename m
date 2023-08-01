Received: from mgamail.intel.com (unknown [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854511110
	for <iommu@lists.linux.dev>; Tue,  1 Aug 2023 08:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690877857; x=1722413857;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W4gznZPwBuG+5KlRxuICY4/mdfWkIKoS+mVF+iOK6mA=;
  b=gaQpBq+R8kADVOed/7aNrt8zr3yL5QijkekKFEeDXCkKkEMRY+OFRxGX
   s4phxU2D1fKdf8imSSuFjk82Nofhz6BEMhbpZFJyNjuqyQKMrrkxUyoTZ
   be+4WplBE0ad9IgqAUcajpyJBW0Is9oN0bUS9uATquGzpi+SlUsA1qpNv
   jaU/jK/G79Ueg5LU+1SuWouV4fFpPzU3Gqx/hQFAMh6ELbYlejDa+KVL1
   6TgjSqUpiXTv5xL2jI6KKxEwPp0wj2bOWpShYxf56gUZAQlBfOsqc0/lo
   R2QpD1i6woMl0CV8du6+3QGMwhQ5/hnrwlI/l3ZdzU5l5+dotAg1lvYVi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="359279199"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="359279199"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 01:17:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="705752238"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="705752238"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 01 Aug 2023 01:16:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 01:16:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 01:16:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 01:16:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5Sf5LKA1c7tNM3Tfqb5U4Bm9DsQtiu9KNF4BGepmf1dNpzJTs/COizhARlBF9GALk7nUSIxJ5NC2axcmRDEF4mbiEjsnTCZ4ErN4kW4tL16rbWNpKrL18Z0t5oMBFrErVSPlvsuwrJUxSsVC0N6bwgoEPReQ3EU6kDqNJTrmbANTqwksli23afxV2yru0dLap0/wFt6RPTwPds4oUA90dtPNTxCe2wTtd5X0p9Nh5GAgwwKSL1EkvUc8TOD6Fu8T+K97iF6HAYmqI/V1xET/FtrCi7X3RPqC9mtEKsaPp+XnNN1NKTfwXnYvTWoa2jNEqDLuUPFT560Y7569ypn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXC6Y+BXkhRpY3DdAZNCLpxBN6r7ikRZ2lnRVobPAes=;
 b=ITWOM+8suDsN770KjlOQU08L+YtpSqKF0RXl8qe/slJDv0ceOqhLPJoUfq/Tl2sbAVavaNCKCvS+giDuP33JQpY2tMzxlJhzBKusm0MrctKx+MLXeErHRyRh7gQ6RHbEM7Hyk4DCnzZZ60GqeS91jUwq78u53MvMyuN5w6DNC+w7zhmU0Jaqdx1G6lpemUGp5efvvyo1xJ5f4gA0eVSBWj1nkcvGlhHaTlRY+vFdt2xFqdP0B1XwLjgdb2bNlAYOMGdwZ3XomQk1LkvZ1QvoMK22jBE/EYtrARIufQXr/K94a2d5MonhBLQEnRw8EKocvEMe0UAObwDKI05jh/7oLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by MW3PR11MB4698.namprd11.prod.outlook.com (2603:10b6:303:5a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 08:16:49 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::7189:7f8c:5b00:edf8]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::7189:7f8c:5b00:edf8%5]) with mapi id 15.20.6631.042; Tue, 1 Aug 2023
 08:16:49 +0000
Message-ID: <6eed84f9-50db-2a93-161f-5181c3b2393b@intel.com>
Date: Tue, 1 Aug 2023 16:16:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] iommu: Consolidate pasid dma ownership check
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230801063125.34995-1-baolu.lu@linux.intel.com>
 <20230801063125.34995-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276D196F9BFB06D0E59AEF28C0AA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <36fb3548-7206-878e-d095-195c2feb24f1@linux.intel.com>
From: tina.zhang <tina.zhang@intel.com>
In-Reply-To: <36fb3548-7206-878e-d095-195c2feb24f1@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0219.apcprd06.prod.outlook.com
 (2603:1096:4:68::27) To MW5PR11MB5881.namprd11.prod.outlook.com
 (2603:10b6:303:19d::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5881:EE_|MW3PR11MB4698:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f9eb4d8-d532-405c-57e1-08db9267a795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BLdqsGGZWRJ6h6JUBnmccEdGBjBW71v9XobA8Atx1f2IvIDVeFEe8gr507uyStGBHZ9QaElyyCdd+BTzKKOI+c6esspBklnfvralVrSUzA8I3JvMz9SulbyIIFni3ZWPDM+SIGpO5Z+bYNBYR80s2CmLqRs3LGD9InwITI73vsISOEgoTRwm9K6KRnnEZ+IwuISoLNAKeI5pTrKmLMMcvF9FFNpBoagZ3w0N3RWXt0Y9gG3N2+0S0WPUfHhQctpDrjPeZxBnSTrnKrrVXt4jgdGL6rWGzJmSWsv2rTJbS4tiDNlnjyOvRJYAofA559ZPOG9ORd95aWAfd1MdCLFFj+kn1AsjsVoKx7g6Kx1rE8ofQoLElAtGpJ4qV0Db60CjfgN9XHqQCdriJ4apCKTsn6u3xOPt1Tfiawb8IlSrq0sYzBwMaqUBRw+4M2Ru26KG8nP7nn+Ckw2rdwFPLE8j0cfBjxtQTkkIAfXI250Fam5ETRZ09PgbiV07akMwqBLnLM3SP1SoOyoVNXTS58nks2/zJrdhR4yvMJSvOH8kaAHb2l9F7GjQ5Eoyejk6rKfIkqyJXzDT2k9C+vJeSi+sUKGpH8wIFd/MA8Px+46IIBW6yT9NvLa7pLTvQ/Min9konyy27lEuJLdEntsuxN+opA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(6666004)(6486002)(53546011)(6512007)(2906002)(26005)(186003)(6506007)(38100700002)(82960400001)(54906003)(478600001)(110136005)(2616005)(83380400001)(31686004)(316002)(66946007)(66556008)(66476007)(4326008)(41300700001)(8676002)(8936002)(7416002)(31696002)(36756003)(86362001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGF2MkVYWjlMdkp2QnR4c0xyekU2OEttaUkvMmxXVEsyYkZzbzBVS3ozMG92?=
 =?utf-8?B?QW8yaDFIQjAyREkxM21jcFIyQURVMHFWSUR1aUxYUmF4UFhjUDQ5dWlzelFC?=
 =?utf-8?B?WnozZkFxYkkwYUVuRFFNZm5oUTNxVHQ0UGliQVpScTY2cVBYT3haR3NOWXcv?=
 =?utf-8?B?SlZCa3hETnRUVVZLV3hCM1I1OGZYWFIzS25CSkpMNWMxWDhMNFdXekhhdUR1?=
 =?utf-8?B?MUcwNlVBbUJETFpBbTdlRDdwUkx1UXNVR0NVZGJtQmtjMGVPdkxDWmlqZ05E?=
 =?utf-8?B?Q3BVR2Z6U3lrZGhpZUtKTzVNaGhQU283cTdqcDJmd3ZyQmJaNzFRS1ZaOVU2?=
 =?utf-8?B?YU14dnNxeWVVWnIwc2RGaUxOZGhkYVVOSGM2ejgzelVYSDNHQ0V0YkpSQTBH?=
 =?utf-8?B?NEdCVG1ScVRFZWpVb3RPYzFKTVBZaXQzb2FINFNSMVZmUWtHY2xqRE1scSt6?=
 =?utf-8?B?SjdCc3hXeDMyNm1lM1FWMGEwdG8vaERJVDVvb2trZU11N2ttaHlPY3pKcHp5?=
 =?utf-8?B?QWk1OWhZN3BncExXandzbXlLMEkzS3pDbUtlZVZ0L3A3aXFPK0p3RlBUa2RW?=
 =?utf-8?B?SVFJdnQ5NzVCdTRwcG1yY2ZsUXptbHRMV2Q0NWRKM1doZVlyeHBySTdsVktv?=
 =?utf-8?B?QWwzcXN5cFdwK1ZBSisycnpNU1Vmc3huRFhMeDlaNHU4KzZjaGtrSEtiTGYz?=
 =?utf-8?B?aGRzNnc0OGkvYU5hOXNRMHNEWUU1d0ttOFhxTkptUCtWcDJKTkJlZElENTRC?=
 =?utf-8?B?L1dVdHc3Um53a3A0SXArdkhvdG9rT29Ya1NtU0oydWZxZnVRSWZVeDltMC9p?=
 =?utf-8?B?TEcvazdDTmlUZnBWWEowZm9YN255UWRvbDVHWHJXbXU2Z1ZFTmNiaExwWldO?=
 =?utf-8?B?VmZPRU0raThka3JuMFR0eFk5TCtTSW51OHRjZ1R1c1VPalVaMkpXcjBCRVJn?=
 =?utf-8?B?bHFDUVBWT3pHWmhOeGoxSXJYcGNnd2FLc0twSXMzUXVnUXYxQkcyL0VCdkxQ?=
 =?utf-8?B?ZC83U3BuN3BIcGY0aUJBbXIzZjBCYU1hdEJmTlpMMktBNU14ZVJHcXRPcjkv?=
 =?utf-8?B?VkhmNUdwSGpIY2RZNm15QTc4UlFjRWgySFMvL1gvUksxeEZaVWJQRDk2d043?=
 =?utf-8?B?UllJamxPNlJ0V3pXZ3gvTUJ4OGFPVktUaklISWdCYUsyZmhDVG0vTHNQUXh1?=
 =?utf-8?B?VkZxTDRKdVFIYlYrQnMrak11a3B1WldxOWszZ1lXTG82QnYvSFNvSGNpSWww?=
 =?utf-8?B?RWl3cjRjS2NyYkZ6R1BjQVpBb3UzQWZ2MVNlTU5zUXI1V0VjWWRNOVI4azJS?=
 =?utf-8?B?Z1h0TElKUk5OK08wMlVwNC82aG5oWFJQT0FPbTFyVHcyNHNSY3llL0FqQ3dR?=
 =?utf-8?B?MjI3V2lnayt2bmk0aytKRnZ1WVpIalFNbmJIZkRnSzBNSHpFS2NTWFdoRUNh?=
 =?utf-8?B?WWRob2o0UUYzNGEzSGZuNXZzUlN5N0N6aXdteVlRUld0c2E0OXFOY01LQkNr?=
 =?utf-8?B?UDlIMmo1U29JYkNPbGhWRHROcS9FWGJOR0l2M3ZQUTlDcHBLVDNHZ1FoQ004?=
 =?utf-8?B?Q2d4dzhGbkpZQ1JxNzBqRW5JT0pqbEUwT0tPckQvWkowbHFHSlprcWRDT1ZM?=
 =?utf-8?B?dHBTVkhQQW5LNHdrWXNhdTBGTWpDa3ZZa2d1bVJ0S3ZPTWcvblZDRVZWV21t?=
 =?utf-8?B?NzAwa2cxTVVLMlFqRC84M29JSVV1MmxVdVlOM0phMmhyejFCSmI2cHZKU3pj?=
 =?utf-8?B?Nk9acGF1Z0phSjJTTHo5UENOUHczN1ZtQk54c1RkMnBRYjBpT2lVL054WC93?=
 =?utf-8?B?ZnNxN3MxL2tFT2REWnBJR1p1cjNYM0oxM2VJUHpXa0gzYmdZd3piQUttdnUv?=
 =?utf-8?B?NFJVbmhMaHFYbkVVY2JFV21RTlhRN1poMEMxT3kyN3RlQ09VcmtlVm1hNUZF?=
 =?utf-8?B?OXovdTBPUlU0bnJOVG52VVB2MWVEVU9pK0prNzdUTk1tdW1jVjA4UnN3U0dh?=
 =?utf-8?B?SWFuTzU1RlRXSlV4RHMyc0RFL3NIQ3FzTmhELzVzS0hUdjl1K2hicWNGRVNE?=
 =?utf-8?B?cHExMFFkQ1g1enRoUVp2cGl3ODhFMWhZN1NwZmJTMjJEWGpiR0krTDdDa21l?=
 =?utf-8?Q?YPumapVz2q4pMuaCfHqaj138K?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9eb4d8-d532-405c-57e1-08db9267a795
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 08:16:49.6694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkQ3LRzLgwqUjb2BsNVVCCgSyvnRE43iTm/MxD4gModgmwR5hJoMasoNY9MRH+U95AoI5LwfwCt1ijUHXSqcFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4698
X-OriginatorOrg: intel.com

Hi,

On 8/1/23 15:43, Baolu Lu wrote:
> On 2023/8/1 15:03, Tian, Kevin wrote:
>>>   /**
>>>    * iommu_device_use_default_domain() - Device driver wants to handle
>>> device
>>>    *                                     DMA through the kernel DMA API.
>>> @@ -3052,14 +3063,14 @@ int iommu_device_use_default_domain(struct
>>> device *dev)
>>>
>>>       mutex_lock(&group->mutex);
>>>       if (group->owner_cnt) {
>>> -        if (group->owner || !iommu_is_default_domain(group) ||
>>> -            !xa_empty(&group->pasid_array)) {
>>> +        if (group->owner || !iommu_is_default_domain(group)) {
>>>               ret = -EBUSY;
>>>               goto unlock_out;
>>>           }
>>>       }
>>>
>>>       group->owner_cnt++;
>>> +    assert_pasid_dma_ownership(group);
>> Old code returns error if pasid_xrrary is not empty.
>>
>> New code continues to take ownership with a warning.
>>
>> this is a functional change. Is it intended or not?
> 
> If iommu_device_use_default_domain() is called with pasid_array not
> empty, there must be a bug somewhere in the device driver. We should
> WARN it instead of returning an error. Probably this is a functional
> change? If so, I can add this in the commit message.
I think in case of a bug, returning error is still expected by callers. 
Otherwise, the callers might think everything is just fine, as the 
return value tells success.

Regards,
-Tina
> 
> Best regards,
> baolu
> 
