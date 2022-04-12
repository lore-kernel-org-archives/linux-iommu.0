Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9B5C433FE
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 06:34:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CBD360F30;
	Tue, 12 Apr 2022 06:34:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3dwpCRRsArje; Tue, 12 Apr 2022 06:34:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DBBCE60E43;
	Tue, 12 Apr 2022 06:34:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE461C0082;
	Tue, 12 Apr 2022 06:34:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75787C002F
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 06:34:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4922240926
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 06:34:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MxqEv-ZXYutd for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:34:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD1D3408DE
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 06:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649745270; x=1681281270;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7M3kKUs72tG046yRZ9OLvVwPmVXypLhxX0AzfBgWmEs=;
 b=i4V54t9DN49yrzVsuJXxNYRHOjosx4G3BYIoB+SAPUmfRWjlACTv1B8X
 Z2FuY/kq6K6yJhvhbTuvvzsZDfipgZRIKpEZE7fTzQjLljToP3K+VU//c
 NM4QXFrl1+78xEH/+0aBewe+3BYdy3qiIpgYjfW+shoOJM2y+YVmIrTLY
 rmGuNVwwT9f9asVYImrq7jMms4JDkIXY7ZkxUua+inzixHDqrfmac41P8
 0tXaK6BwenR8jOikPUyK0FMLBPi3GNCV1CQPAc2SsYkG611BWEWgHScod
 scTBpfJVCJ3cp78IVyCXj323QLOrdOVv0cVIXNxdIsHF+JGsQjJImWAl+ g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="242228782"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="242228782"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2022 23:34:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="644585773"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by FMSMGA003.fm.intel.com with ESMTP; 11 Apr 2022 23:34:29 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Apr 2022 23:34:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 11 Apr 2022 23:34:28 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 11 Apr 2022 23:34:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A44WTcGu5BX6dINkvABXEdpLvjOZ6TeaPtgaHy3I5Z2ch5bXhaRe8RmgwIdCrZ4cXn3ooJWNB5flWL9Zsu/HIJk6XHKTA1NE90oR5C0iSctXtn3x8Nf8GKi4XPIOxbr1hnx3JDN5SBzRUIaCr7Cepxwf3yGcuDJMSyfBRWcmIwjPFF/M6UkfsPuHEDHu/aU4yx4g71fplIFk1HO8f4jho7W1jm5nYG7F53vhMNcCPreiLbR8nu7hOqwd3SNEalA5azN0IwLyEFDRQPXoxS4zAQtfiCYrwNzEhsrlsiBC6tMB59oMp4IsCo5gsjWQAZ2Bg5jgsLQFpCFx4jygEtjmEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aU82L1XEIfnAj8DC2y4mb2kWClWBlvtm8pTLB32tG1g=;
 b=h9KKBG1SQwB5NHZnkYda98gkVpDI+fElxsTj3sG0Tg2aNWKoLAR3ERQRMvO9O/pmH4ZzlvBDqIjZao8gg6bUQrnponY44RbPPm5RjsNr1aCYWv3obkfCp6xIUQJQXzB+7ND3UkTec2XKFStGk/xODs6EfGjgy6OY9KUpVVQiYsu8DUQ6VOIEMgMPLyexyyro1Cdkord3if5XvNu8ibTkbb0G8sXUQpFAjK+Lf+0375OpZ2rJU2r7eZC2Mzzq8WSilM9qRQvG5vNFO9hkfA27V2uvZM13qLMG6APvTxqO+y7L451JSRn8KwXxI2t+k52FC35B9X3KPZmJ2o9KvSjORA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23)
 by MN2PR11MB4397.namprd11.prod.outlook.com (2603:10b6:208:190::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 06:34:26 +0000
Received: from PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::71d2:84f6:64e1:4024]) by PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::71d2:84f6:64e1:4024%6]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 06:34:26 +0000
Message-ID: <e8d8d08c-8327-b0ad-6bdd-ef10cd34e212@intel.com>
Date: Tue, 12 Apr 2022 14:34:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v3 02/12] iommu: Add a flag to indicate immutable
 singleton group
Content-Language: en-US
To: Lu Baolu <baolu.lu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, 
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "Christoph
 Hellwig" <hch@infradead.org>, "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
 <20220410102443.294128-3-baolu.lu@linux.intel.com>
 <BN9PR11MB527679E5CE0516B2786F57518CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7c70a136-6871-b48c-8e46-852bb1b62958@linux.intel.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <7c70a136-6871-b48c-8e46-852bb1b62958@linux.intel.com>
X-ClientProxiedBy: HK2PR02CA0184.apcprd02.prod.outlook.com
 (2603:1096:201:21::20) To PH0PR11MB5658.namprd11.prod.outlook.com
 (2603:10b6:510:e2::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd3e1351-0e05-4d98-7cc7-08da1c4e7d3a
X-MS-TrafficTypeDiagnostic: MN2PR11MB4397:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MN2PR11MB439783ACC95BC6DB5B317B12C3ED9@MN2PR11MB4397.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /OntLA+MRjjb4+iQ54GCmbzaqkT3V1EjBE/jX9LrFNImMmsoXvizKmH48NcoLBTy/IypVQxdPpDqu0nSOq0HFB87QRy24rzGS4zeDU/HLp+G4AcFJrjJAwyT2X1rTSCLC3LXdYJFSbrCsz4XbeRIChzfivpCq6n652Xje6op6lur3hptcnoyvvOflc6wjo2DnkCZ8JAn43cH1ywRQxwsOLRaJ5MlBJtayQFocNKVs6RXY4MLLgVAoOyruTZK5VJ2FRKzUglmvvbLw9L7ePUTj4s6CFPurBaLGkTc5l0OndbGZ4FBdx0AckD/s9vASQya9N5reN23mEWKk190jHgzoEw7jMODpggZuNf14NKqAwjWioHzV38gZmkiKEiFA5T4lFVJ6VOTZm7JSL6Ej42iO11NDZKA1UkfmNoV+TAEr4irwvb8RoPFhGlDvap81cRNgC7e7tSx4ACpGSImjAnX+WXHXIzVJxJuF9zIA9MJBau2OI0JLV2a6RvBjtmNsUTMnWzhpXs0hLaRm8d8V6QIJKY+aCfFY0MrXGAKRqAjEbCcJL4fObUwOf84/u+yrZawsZbtPtsz6sEtHloVyg39KIkjtrv+NKvgRQ5JA/UZua1I33m+r0Dl0DiY8vUGXiqXquIUa+ZQ0fgKEfXxdlEkkcrsdVZxrDgLQK9jOtUmzwvodJ/vRhKI+48kW0vWX3hpYVOXiUWYBfmAAMg49VQ4CRC1nMTdLjimf5vyNfTVX3aGfIUfoUGs+Y9luussvF/99ZNRPLyFoJFuJT2C/flKJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5658.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(53546011)(36756003)(508600001)(86362001)(6486002)(8676002)(66556008)(66476007)(316002)(6506007)(6512007)(6666004)(83380400001)(66946007)(8936002)(2616005)(31686004)(26005)(7416002)(5660300002)(2906002)(186003)(82960400001)(921005)(4326008)(54906003)(31696002)(110136005)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmFSZk1uQm9wWnVnNFVpQXlIMDFpTnM3THhSazEvalVsMllZd1dxY3lsMW04?=
 =?utf-8?B?c1VGNDV6WmhhR3hDbjVIWTZMejhyNzBKUU1YNTdHelhtbmY2UThyQ0dFYjJG?=
 =?utf-8?B?bkwyYll2Nit3aWNzOGJrVXExSzcxZjlCMVNIQjRLRlk4RHhqUkFiR0hvd2dN?=
 =?utf-8?B?L3E5R3BPcXBmd29Qb0lVS2NkTHc1NWhTTDFVVjBmcHFpcjFGOExYb1pWajdH?=
 =?utf-8?B?YkR5RUFPM0FmQ2VXQUFQaFlpWFhhOXFGTWhvck5XWDh5SGQyQVVxbEhvRUpv?=
 =?utf-8?B?NmMxQ24xa2FFRXBtQzk5OEZlbElpRHo4a1NKbi96Qk82Nis4eHRrYVQwN096?=
 =?utf-8?B?WjRxWCtkUXY0TGtEdVBzb3I5SmhuanZkWFZSZUgzdXViQjA2cE5EbkcvbERE?=
 =?utf-8?B?V2h6K0oxcUk2aVBCR2U0QVpObVpyR2lic3hENXNhTzE4YzFyYzdBMTZLY2Jk?=
 =?utf-8?B?RHFyYXFMeDZ1bXNIQTVwR1JuNmxITFl0QXJxaTdZNFVrcG8zZGs0QXdxL2VZ?=
 =?utf-8?B?OHZ5SE1PUzNqcmQzQkJaNStrYVNFNGFSL1F0NWl2ZnZhaXdkQkw0Q0tKRXhE?=
 =?utf-8?B?czlYQ0JRQ2JzaEVMSmlJL3hGendQNUhTaWRXVUJHNHpTRjk5TmRXd0VGYkN2?=
 =?utf-8?B?WnZqK3pzT1lxL1pYTWk4OG5OZExKUWxNYVpValc0U2dUNXNOWDY5MlVsc2cr?=
 =?utf-8?B?VVRXQ3Y1U2N5VVhROEk1M3RZTUJ3d291S1I4VjM3dFdURGJsSnNwejVlRzhJ?=
 =?utf-8?B?WkVmZXlNcXNTYUxsTHBEVGVud2JCWExNRTRRL09kaWJNczJWeUcxTjJTVUsx?=
 =?utf-8?B?THk0V1QzRThFa3VJWTF4SHhtelJVSnR4TVFNa2h0U01jNU9zMEIzZUpvVVFm?=
 =?utf-8?B?dnZ4ajFXRmluSHVvZWIxMjEvUTBGODAxNnFRWndmeWtLOWUzQWFpeU55Tld4?=
 =?utf-8?B?ZTN2UmNCaTBpZWFLSjFxWWFDa1pac0tWMmdsNXh1Nm5aWi9nN0c4K0llNG9M?=
 =?utf-8?B?bENWUHUvSUpBa3g3N2M3SXI0SnhzNkp2WE53OGkzZTgvTWVjWWFxb09RMnFU?=
 =?utf-8?B?M3BDVGhaSitqVHZzRjQyYkZvT29MYUcxRTZpLzFOeHZhblRielRlUlIxcFh3?=
 =?utf-8?B?ekhYaTFtTEdlazZmNnJ0and2QnVEL3NUaEgxTG1WRHVURUhmSHdVWTFZZzRv?=
 =?utf-8?B?NXhTSkt2TXBmRHRFR01sU2I5QVRzd0k3VHBNWVpIK0xITHR6MkV2Rm9XQ21p?=
 =?utf-8?B?Z1lYejY1c3ZaMnQvVXlYM01FS2JleWtoSnlkc2F3azJsWUVHSDRNL3dLNGV1?=
 =?utf-8?B?b09acXlYMUFidWZDb0dkY3VHcTZUNlZpWEt3WXptR1hYRVdBZFkzeENjOFE1?=
 =?utf-8?B?cVFzSkpKVHg3TEVMRmxBVTRSYjQ3bmtPL0ZqUWZWZnB4QnIwaU5Bc0xJaTVq?=
 =?utf-8?B?RHdENW5jc3pxMTNJQW9VQ2kzKzZMNGlNS1pUL2dzTmN6Ny9CY3pOQVpKR1NU?=
 =?utf-8?B?UVQzay9IMnlOT1ZpeFIySnI1RFByT1E5RXJXWnd6a0l1eElzWndDZHA1RHNj?=
 =?utf-8?B?QTdjc1k2YjF6bUJvUllZSmxEK0tuTlhvNW16QUZCMDVSSlU3REpGZEhGcktZ?=
 =?utf-8?B?NlBNRndIZS9VZEJablN3eUZQWlZvRGpRdkpBanR2TEtrTndvaUxXV0xnSG9x?=
 =?utf-8?B?MFkrSjJaUWNJYnExSE1tSmFuT2VMaHdkNmVscWNZbGpQeFJGTkJOZU5RRGps?=
 =?utf-8?B?NlJGSXRwOVluYWtzYStHaDFDeTdTaDFYNkF1b25qK2NxTnJXbjlzc1pZelQz?=
 =?utf-8?B?Zjh0WW9lY2JwL3RYdkx4OXZoK2hrdjNhd0lzZWJyWk12YXlZd1ZNUE9aTW9j?=
 =?utf-8?B?WjZ5c0U3VjhjMzFna0gyZjZ6aVVoVXExYXJsckt1eGJsd1gzL25ucGxVSGFU?=
 =?utf-8?B?NjJSbGlhWXBLU0doNUtXOUhOeDJmYVdNampjTlUxZU8xclFWQy91eFFvd2pL?=
 =?utf-8?B?WEIybloyWVdyTDBINEwzOVFMK1VNOUwwcFU5KzN3UnRETTZEV3lvQUdleGVX?=
 =?utf-8?B?OTJaWTFBTi84Z2JXWmt6S3FGRHpwalV4QzFHS21ybEtnMUtSdXpkaVcrZzAv?=
 =?utf-8?B?dm0wV1dEcG85ZDZsblRhNXlTVjUvL0R3SE1xdDBmZlZhWU80Y2pjaHJSL1gz?=
 =?utf-8?B?VmVOYnBQQUE0RklUcERtMXJIK2R4Q3JTR1llWlVnVlVjc3prNDhjRElLL3Z1?=
 =?utf-8?B?SnZyZ05PUGpSbWdJamRMWXNwNWllL3hKVjJsZ0RCcDBJcmhBZzFyZEFpSUw4?=
 =?utf-8?B?dWpqMi8vRGp3bGg2RWZoTm13UElkY1pRNGwvOFV4dEQvSDFXSFFSU0gwNkRV?=
 =?utf-8?Q?MuWL522UkHGZhh64=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3e1351-0e05-4d98-7cc7-08da1c4e7d3a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 06:34:26.3326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THX5n9FKp6D0y2kW0AD7k8bxHKHDpJLpEeBT2zLt5vUNmd35y0M68ZoLzxceW7WMGq8XTh/EXLtHa8N8dZmHsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4397
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgQmFvbHUsCgpPbiAyMDIyLzQvMTIgMTM6MDgsIEx1IEJhb2x1IHdyb3RlOgo+IEhpIEtldmlu
LAo+IAo+IFRoYW5rcyBmb3IgeW91ciB0aW1lLgo+IAo+IE9uIDIwMjIvNC8xMiAxMToxNSwgVGlh
biwgS2V2aW4gd3JvdGU6Cj4+PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwu
Y29tPgo+Pj4gU2VudDogU3VuZGF5LCBBcHJpbCAxMCwgMjAyMiA2OjI1IFBNCj4+Pgo+Pj4gU29t
ZSBmZWF0dXJlcyByZXF1aXJlIHRoYXQgYSBzaW5nbGUgZGV2aWNlIG11c3QgYmUgaW1tdXRhYmx5
IGlzb2xhdGVkLAo+Pj4gZXZlbiB3aGVuIGhvdCBwbHVnIGlzIHN1cHBvcnRlZC4KPj4KPj4gVGhp
cyByZWFkcyBjb25mdXNpbmcsIGFzIGhvdHBsdWcgY2Fubm90IGJlIGFsbG93ZWQgaW4gYSBzaW5n
bGV0b24gZ3JvdXAuCj4+IFdoYXQgeW91IGFjdHVhbGx5IG1lYW50IHN1cHBvc2UgdG8gYmU6Cj4+
Cj4+ICJFbmFibGluZyBjZXJ0YWluIGRldmljZSBmZWF0dXJlcyByZXF1aXJlIHRoZSBkZXZpY2Ug
aW4gYSBzaW5nbGV0b24gaW9tbXUKPj4gZ3JvdXAgd2hpY2ggaXMgaW1tdXRhYmxlIGluIGZhYnJp
YyBpLmUuIG5vdCBhZmZlY3RlZCBieSBob3RwbHVnIgo+IAo+IFlvdXJzIGlzIGJldHRlci4gVGhh
bmsgeW91Lgo+IAo+Pgo+Pj4gRm9yIGV4YW1wbGUsIHRoZSBTVkEgYmluZCgpL3VuYmluZCgpCj4+
PiBpbnRlcmZhY2VzIHJlcXVpcmUgdGhhdCB0aGUgZGV2aWNlIGV4aXN0cyBpbiBhIHNpbmdsZXRv
biBncm91cC4gSWYgd2UKPj4+IGhhdmUgYSBzaW5nbGV0b24gZ3JvdXAgdGhhdCBkb2Vzbid0IGhh
dmUgQUNTIChvciBzaW1pbGFyIHRlY2hub2xvZ2llcykKPj4+IGFuZCBzb21lb25lIGhvdHBsdWdz
IGluIGFub3RoZXIgZGV2aWNlIG9uIGEgYnJpZGdlLCB0aGVuIG91ciBTVkEgaXMKPj4+IGNvbXBs
ZXRlbHkgYnJva2VuIGFuZCB3ZSBnZXQgZGF0YSBjb3JydXB0aW9uLgo+Pgo+PiB0aGlzIG5lZWRz
IHRoZSBiYWNrZ3JvdW5kIHRoYXQgUEFTSUQgZG9lc24ndCBqb2luIFBDSSBwYWNrZXQgcm91dGlu
Zwo+PiB0aHVzIHRoZSBkbWEgYWRkcmVzcyAoQ1BVIFZBKSBtYXkgaGl0IGEgcDJwIHJhbmdlLgo+
IAo+IFN1cmUuCj4gCj4+Cj4+Pgo+Pj4gVGhpcyBhZGRzIGEgZmxhZyBpbiB0aGUgaW9tbXVfZ3Jv
dXAgc3RydWN0IHRvIGluZGljYXRlIGFuIGltbXV0YWJsZQo+Pj4gc2luZ2xldG9uIGdyb3VwLCBh
bmQgdXNlcyBzdGFuZGFyZCBQQ0kgYnVzIHRvcG9sb2d5LCBpc29sYXRpb24gZmVhdHVyZXMsCj4+
PiBhbmQgRE1BIGFsaWFzIHF1aXJrcyB0byBzZXQgdGhlIGZsYWcuIElmIHRoZSBkZXZpY2UgY2Ft
ZSBmcm9tIERULCBhc3N1bWUKPj4+IGl0IGlzIHN0YXRpYyBhbmQgdGhlbiB0aGUgc2luZ2xldG9u
IGF0dHJpYnV0ZSBjYW4ga25vdyBmcm9tIHRoZSBkZXZpY2UKPj4+IGNvdW50IGluIHRoZSBncm91
cC4KPj4KPj4gd2hlcmUgZG9lcyB0aGUgYXNzdW1wdGlvbiBjb21lIGZyb20/Cj4gCj4gSG90cGx1
ZyBpcyB0aGUgb25seSBmYWN0b3IgdGhhdCBjYW4gZHluYW1pY2FsbHkgYWZmZWN0IHRoZQo+IGNo
YXJhY3RlcmlzdGljcyBvZiBJT01NVSBncm91cCBzaW5nbGV0b24gYXMgZmFyIGFzIEkgY2FuIHNl
ZS4gSWYgYQo+IGRldmljZSBub2RlIHdhcyBjcmVhdGVkIGZyb20gdGhlIERULCBpdCBjb3VsZCBi
ZSB0cmVhdGVkIGFzIHN0YXRpYywKPiBoZW5jZSB3ZSBjYW4ganVkZ2UgdGhlIHNpbmdsZXRvbiBp
biBpb21tdSBwcm9iZSBwaGFzZSBkdXJpbmcgYm9vdC4KCm5vdCBzdXJlIGlmIGhvdHBsdWcgaXMg
dGhlIG9ubHkgZmFjdG9yLiBJcyBpdCBwb3NzaWJsZSB0aGF0IGFkbWluIG1vZGlmaWVzCnRoZSBB
Q1MgY29uZmlndXJhdGlvbiBvbiB0aGUgYnJpZGdlPwoKPj4KPj4+Cj4+PiBTdWdnZXN0ZWQtYnk6
IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+Cj4+PiBTdWdnZXN0ZWQtYnk6IEtldmlu
IFRpYW4gPGtldmluLnRpYW5AaW50ZWwuY29tPgo+Pj4gU2lnbmVkLW9mZi1ieTogTHUgQmFvbHUg
PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9pb21tdS9p
b21tdS5jIHwgNjcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQo+Pj4g
LS0tCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNTcgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25z
KC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYyBiL2RyaXZlcnMv
aW9tbXUvaW9tbXUuYwo+Pj4gaW5kZXggMGM0MmVjZTI1ODU0Li41NmZmYmY1ZmRjMTggMTAwNjQ0
Cj4+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2lvbW11LmMKPj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUv
aW9tbXUuYwo+Pj4gQEAgLTQ4LDYgKzQ4LDcgQEAgc3RydWN0IGlvbW11X2dyb3VwIHsKPj4+IMKg
wqDCoMKgwqAgc3RydWN0IGxpc3RfaGVhZCBlbnRyeTsKPj4+IMKgwqDCoMKgwqAgdW5zaWduZWQg
aW50IG93bmVyX2NudDsKPj4+IMKgwqDCoMKgwqAgdm9pZCAqb3duZXI7Cj4+PiArwqDCoMKgIGJv
b2wgaW1tdXRhYmxlX3NpbmdsZXRvbjsKPj4KPj4gSnVzdCBjYWxsIGl0ICdzaW5nbGV0b24nIHdp
dGggYSBjb21tZW50IHRvIGV4cGxhaW4gaXQgbXVzdCBiZSBpbW11dGFibGU/Cj4gCj4gSSB3YXMg
anVzdCB0cnlpbmcgdG8gZGlzdGluZ3Vpc2ggInNpbmdsZXRvbiIgYW5kICJpbW11dGFibGUgc2lu
Z2xldG9uIi4KPiBBIGdyb3VwIGlzIHNpbmdsZXRvbiBpZiBpdCBvbmx5IGNvbnRhaW5zIGEgc2lu
Z2xlIGRldmljZSBpbiB0aGUgZGV2aWNlCj4gbGlzdCwgd2hpbGUgYSBncm91cCBpcyBpbW11dGFi
bGUgc2luZ2xldG9uIG9ubHkgaWYgdGhlIGZhYnJpYyBkb2Vzbid0Cj4gYWxsb3cgdG8gY2hhbmdl
IHRoZSBzdGF0ZS4KPiAKPj4KPj4+IMKgIH07Cj4+Pgo+Pj4gwqAgc3RydWN0IGdyb3VwX2Rldmlj
ZSB7Cj4+PiBAQCAtNzQsNiArNzUsMTYgQEAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdAo+Pj4g
aW9tbXVfZ3JvdXBfcmVzdl90eXBlX3N0cmluZ1tdID0gewo+Pj4gwqAgI2RlZmluZSBJT01NVV9D
TURfTElORV9ETUFfQVBJwqDCoMKgwqDCoMKgwqAgQklUKDApCj4+PiDCoCAjZGVmaW5lIElPTU1V
X0NNRF9MSU5FX1NUUklDVMKgwqDCoMKgwqDCoMKgIEJJVCgxKQo+Pj4KPj4+ICsvKgo+Pj4gKyAq
IFRvIGNvbnNpZGVyIGEgUENJIGRldmljZSBpc29sYXRlZCwgd2UgcmVxdWlyZSBBQ1MgdG8gc3Vw
cG9ydCBTb3VyY2UKPj4+ICsgKiBWYWxpZGF0aW9uLCBSZXF1ZXN0IFJlZGlyZWN0aW9uLCBDb21w
bGV0ZXIgUmVkaXJlY3Rpb24sIGFuZCBVcHN0cmVhbQo+Pj4gKyAqIEZvcndhcmRpbmcuwqAgVGhp
cyBlZmZlY3RpdmVseSBtZWFucyB0aGF0IGRldmljZXMgY2Fubm90IHNwb29mIHRoZWlyCj4+PiAr
ICogcmVxdWVzdGVyIElELCByZXF1ZXN0cyBhbmQgY29tcGxldGlvbnMgY2Fubm90IGJlIHJlZGly
ZWN0ZWQsIGFuZCBhbGwKPj4+ICsgKiB0cmFuc2FjdGlvbnMgYXJlIGZvcndhcmRlZCB1cHN0cmVh
bSwgZXZlbiBhcyBpdCBwYXNzZXMgdGhyb3VnaCBhCj4+PiArICogYnJpZGdlIHdoZXJlIHRoZSB0
YXJnZXQgZGV2aWNlIGlzIGRvd25zdHJlYW0uCj4+PiArICovCj4+PiArI2RlZmluZSBSRVFfQUNT
X0ZMQUdTwqDCoCAoUENJX0FDU19TViB8IFBDSV9BQ1NfUlIgfCBQQ0lfQUNTX0NSIHwKPj4+IFBD
SV9BQ1NfVUYpCj4+PiArCj4+PiDCoCBzdGF0aWMgaW50IGlvbW11X2FsbG9jX2RlZmF1bHRfZG9t
YWluKHN0cnVjdCBpb21tdV9ncm91cCAqZ3JvdXAsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBkZXZpY2UgKmRldik7Cj4+PiDCoCBzdGF0
aWMgc3RydWN0IGlvbW11X2RvbWFpbiAqX19pb21tdV9kb21haW5fYWxsb2Moc3RydWN0IGJ1c190
eXBlICpidXMsCj4+PiBAQCAtODksNiArMTAwLDcgQEAgc3RhdGljIGludAo+Pj4gaW9tbXVfY3Jl
YXRlX2RldmljZV9kaXJlY3RfbWFwcGluZ3Moc3RydWN0IGlvbW11X2dyb3VwICpncm91cCwKPj4+
IMKgIHN0YXRpYyBzdHJ1Y3QgaW9tbXVfZ3JvdXAgKmlvbW11X2dyb3VwX2dldF9mb3JfZGV2KHN0
cnVjdCBkZXZpY2UgKmRldik7Cj4+PiDCoCBzdGF0aWMgc3NpemVfdCBpb21tdV9ncm91cF9zdG9y
ZV90eXBlKHN0cnVjdCBpb21tdV9ncm91cCAqZ3JvdXAsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50
KTsKPj4+ICtzdGF0aWMgaW50IGlvbW11X2dyb3VwX2RldmljZV9jb3VudChzdHJ1Y3QgaW9tbXVf
Z3JvdXAgKmdyb3VwKTsKPj4+Cj4+PiDCoCAjZGVmaW5lIElPTU1VX0dST1VQX0FUVFIoX25hbWUs
IF9tb2RlLCBfc2hvdywgX3N0b3JlKQo+Pj4gwqDCoMKgwqBcCj4+PiDCoCBzdHJ1Y3QgaW9tbXVf
Z3JvdXBfYXR0cmlidXRlIGlvbW11X2dyb3VwX2F0dHJfIyNfbmFtZSA9wqDCoMKgwqDCoMKgwqAg
XAo+Pj4gQEAgLTg0NCw2ICs4NTYsMzcgQEAgc3RhdGljIGJvb2wgaW9tbXVfaXNfYXR0YWNoX2Rl
ZmVycmVkKHN0cnVjdCBkZXZpY2UKPj4+ICpkZXYpCj4+PiDCoMKgwqDCoMKgIHJldHVybiBmYWxz
ZTsKPj4+IMKgIH0KPj4+Cj4+PiArc3RhdGljIGludCBoYXNfcGNpX2FsaWFzKHN0cnVjdCBwY2lf
ZGV2ICpwZGV2LCB1MTYgYWxpYXMsIHZvaWQgKm9wYXF1ZSkKPj4+ICt7Cj4+PiArwqDCoMKgIHJl
dHVybiAtRUVYSVNUOwo+Pj4gK30KPj4+ICsKPj4+ICtzdGF0aWMgYm9vbCBwY2lfaW1tdXRhYmx5
X2lzb2xhdGVkKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQo+Pj4gK3sKPj4+ICvCoMKgwqAgLyogU2tp
cCB0aGUgYnJpZGdlcy4gKi8KPj4+ICvCoMKgwqAgaWYgKHBjaV9pc19icmlkZ2UocGRldikpCj4+
PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+Pj4gKwo+Pj4gK8KgwqDCoCAvKgo+Pj4g
K8KgwqDCoMKgICogVGhlIGRldmljZSBjb3VsZCBiZSBjb25zaWRlcmVkIHRvIGJlIGZ1bGx5IGlz
b2xhdGVkIGlmCj4+PiArwqDCoMKgwqAgKiBhbGwgZGV2aWNlcyBvbiB0aGUgcGF0aCBmcm9tIHRo
ZSBwYXJlbnQgdG8gdGhlIGhvc3QtUENJCj4+PiArwqDCoMKgwqAgKiBicmlkZ2UgYXJlIHByb3Rl
Y3RlZCBmcm9tIHBlZXItdG8tcGVlciBETUEgYnkgQUNTLgo+Pj4gK8KgwqDCoMKgICovCj4+PiAr
wqDCoMKgIGlmICghcGNpX2lzX3Jvb3RfYnVzKHBkZXYtPmJ1cykgJiYKPj4+ICvCoMKgwqDCoMKg
wqDCoCAhcGNpX2Fjc19wYXRoX2VuYWJsZWQocGRldi0+YnVzLT5zZWxmLCBOVUxMLCBSRVFfQUNT
X0ZMQUdTKSkKPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7Cj4+PiArCj4+PiArwqDC
oMKgIC8qIE11bHRpLWZ1bmN0aW9uIGRldmljZXMgc2hvdWxkIGhhdmUgQUNTIGVuYWJsZWQuICov
Cj4+PiArwqDCoMKgIGlmIChwZGV2LT5tdWx0aWZ1bmN0aW9uICYmICFwY2lfYWNzX2VuYWJsZWQo
cGRldiwgUkVRX0FDU19GTEFHUykpCj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+
Pgo+PiBMb29rcyBteSBlYXJsaWVyIGNvbW1lbnQgd2FzIGxvc3QsIGkuZS4geW91IGNhbiBqdXN0
IHVzZQo+PiBwY2lfYWNzX3BhdGhfZW5hYmxlZChwZGV2KSB0byBjb3ZlciBhYm92ZSB0d28gY2hl
Y2tzLgo+IAo+IElmIGEgZGV2aWNlIGlzIGRpcmVjdGx5IGNvbm5lY3RlZCB0byB0aGUgcm9vdCBi
cmlkZ2UgYW5kIGl0IGlzIG5vdCBhbgo+IE1GRCwgZG8gd2Ugc3RpbGwgbmVlZCBBQ1Mgb24gaXQ/
IFRoZSBJbnRlbCBpZHhkIGRldmljZSBzZWVtcyB0byBiZSBzdWNoCj4gYSBkZXZpY2UuIEkgaGFk
IGEgcXVpY2sgY2hlY2sgd2l0aCBsc3BjaSwgaXQgaGFzIG5vIEFDUyBzdXBwb3J0Lgo+IAo+IEkg
cHJvYmFibHkgbWlzc2VkIGFueXRoaW5nLgoKc2VlbXMgbm90IG5lY2Vzc2FyeSBwZXIgbXkga25v
d2xlZGdlLgoKPiAKPj4KPj4+ICsKPj4+ICvCoMKgwqAgLyogRmlsdGVyIG91dCBkZXZpY2VzIHdo
aWNoIGhhcyBhbnkgYWxpYXMgZGV2aWNlLiAqLwo+Pj4gK8KgwqDCoCBpZiAocGNpX2Zvcl9lYWNo
X2RtYV9hbGlhcyhwZGV2LCBoYXNfcGNpX2FsaWFzLCBOVUxMKSkKPj4+ICvCoMKgwqDCoMKgwqDC
oCByZXR1cm4gZmFsc2U7Cj4+PiArCj4+PiArwqDCoMKgIHJldHVybiB0cnVlOwo+Pj4gK30KPj4+
ICsKPj4+IMKgIC8qKgo+Pj4gwqDCoCAqIGlvbW11X2dyb3VwX2FkZF9kZXZpY2UgLSBhZGQgYSBk
ZXZpY2UgdG8gYW4gaW9tbXUgZ3JvdXAKPj4+IMKgwqAgKiBAZ3JvdXA6IHRoZSBncm91cCBpbnRv
IHdoaWNoIHRvIGFkZCB0aGUgZGV2aWNlIChyZWZlcmVuY2Ugc2hvdWxkIGJlIAo+Pj4gaGVsZCkK
Pj4+IEBAIC04OTgsNiArOTQxLDIwIEBAIGludCBpb21tdV9ncm91cF9hZGRfZGV2aWNlKHN0cnVj
dCBpb21tdV9ncm91cAo+Pj4gKmdyb3VwLCBzdHJ1Y3QgZGV2aWNlICpkZXYpCj4+PiDCoMKgwqDC
oMKgIGxpc3RfYWRkX3RhaWwoJmRldmljZS0+bGlzdCwgJmdyb3VwLT5kZXZpY2VzKTsKPj4+IMKg
wqDCoMKgwqAgaWYgKGdyb3VwLT5kb21haW7CoCAmJiAhaW9tbXVfaXNfYXR0YWNoX2RlZmVycmVk
KGRldikpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gX19pb21tdV9hdHRhY2hfZGV2aWNl
KGdyb3VwLT5kb21haW4sIGRldik7Cj4+PiArCj4+PiArwqDCoMKgIC8qCj4+PiArwqDCoMKgwqAg
KiBVc2Ugc3RhbmRhcmQgUENJIGJ1cyB0b3BvbG9neSwgaXNvbGF0aW9uIGZlYXR1cmVzLCBhbmQg
RE1BCj4+PiArwqDCoMKgwqAgKiBhbGlhcyBxdWlya3MgdG8gc2V0IHRoZSBpbW11dGFibGUgc2lu
Z2xldG9uIGF0dHJpYnV0ZS4gSWYKPj4+ICvCoMKgwqDCoCAqIHRoZSBkZXZpY2UgY2FtZSBmcm9t
IERULCBhc3N1bWUgaXQgaXMgc3RhdGljIGFuZCB0aGVuCj4+PiArwqDCoMKgwqAgKiBzaW5nbGV0
b24gY2FuIGtub3cgZnJvbSB0aGUgZGV2aWNlIGNvdW50IGluIHRoZSBncm91cC4KPj4+ICvCoMKg
wqDCoCAqLwo+Pj4gK8KgwqDCoCBpZiAoZGV2X2lzX3BjaShkZXYpKQo+Pj4gK8KgwqDCoMKgwqDC
oMKgIGdyb3VwLT5pbW11dGFibGVfc2luZ2xldG9uID0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcGNpX2ltbXV0YWJseV9pc29sYXRlZCh0b19wY2lfZGV2KGRldikpOwo+Pj4g
K8KgwqDCoCBlbHNlIGlmIChpc19vZl9ub2RlKGRldl9md25vZGUoZGV2KSkpCj4+PiArwqDCoMKg
wqDCoMKgwqAgZ3JvdXAtPmltbXV0YWJsZV9zaW5nbGV0b24gPQo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAoaW9tbXVfZ3JvdXBfZGV2aWNlX2NvdW50KGdyb3VwKSA9PSAxKTsK
Pj4+ICsKPj4+IMKgwqDCoMKgwqAgbXV0ZXhfdW5sb2NrKCZncm91cC0+bXV0ZXgpOwo+Pj4gwqDC
oMKgwqDCoCBpZiAocmV0KQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyX3B1dF9ncm91
cDsKPj4+IEBAIC0xMjkwLDE2ICsxMzQ3LDYgQEAgRVhQT1JUX1NZTUJPTF9HUEwoaW9tbXVfZ3Jv
dXBfaWQpOwo+Pj4gwqAgc3RhdGljIHN0cnVjdCBpb21tdV9ncm91cCAqZ2V0X3BjaV9hbGlhc19n
cm91cChzdHJ1Y3QgcGNpX2RldiAqcGRldiwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgKmRldmZucyk7Cj4+
Pgo+Pj4gLS8qCj4+PiAtICogVG8gY29uc2lkZXIgYSBQQ0kgZGV2aWNlIGlzb2xhdGVkLCB3ZSBy
ZXF1aXJlIEFDUyB0byBzdXBwb3J0IFNvdXJjZQo+Pj4gLSAqIFZhbGlkYXRpb24sIFJlcXVlc3Qg
UmVkaXJlY3Rpb24sIENvbXBsZXRlciBSZWRpcmVjdGlvbiwgYW5kIFVwc3RyZWFtCj4+PiAtICog
Rm9yd2FyZGluZy7CoCBUaGlzIGVmZmVjdGl2ZWx5IG1lYW5zIHRoYXQgZGV2aWNlcyBjYW5ub3Qg
c3Bvb2YgdGhlaXIKPj4+IC0gKiByZXF1ZXN0ZXIgSUQsIHJlcXVlc3RzIGFuZCBjb21wbGV0aW9u
cyBjYW5ub3QgYmUgcmVkaXJlY3RlZCwgYW5kIGFsbAo+Pj4gLSAqIHRyYW5zYWN0aW9ucyBhcmUg
Zm9yd2FyZGVkIHVwc3RyZWFtLCBldmVuIGFzIGl0IHBhc3NlcyB0aHJvdWdoIGEKPj4+IC0gKiBi
cmlkZ2Ugd2hlcmUgdGhlIHRhcmdldCBkZXZpY2UgaXMgZG93bnN0cmVhbS4KPj4+IC0gKi8KPj4+
IC0jZGVmaW5lIFJFUV9BQ1NfRkxBR1PCoMKgIChQQ0lfQUNTX1NWIHwgUENJX0FDU19SUiB8IFBD
SV9BQ1NfQ1IgfAo+Pj4gUENJX0FDU19VRikKPj4+IC0KPj4+IMKgIC8qCj4+PiDCoMKgICogRm9y
IG11bHRpZnVuY3Rpb24gZGV2aWNlcyB3aGljaCBhcmUgbm90IGlzb2xhdGVkIGZyb20gZWFjaCBv
dGhlciwgZmluZAo+Pj4gwqDCoCAqIGFsbCB0aGUgb3RoZXIgbm9uLWlzb2xhdGVkIGZ1bmN0aW9u
cyBhbmQgbG9vayBmb3IgZXhpc3RpbmcgZ3JvdXBzLiAgCj4+PiBGb3IKPj4+IC0tIAo+Pj4gMi4y
NS4xCj4+Cj4gCj4gQmVzdCByZWdhcmRzLAo+IGJhb2x1CgotLSAKUmVnYXJkcywKWWkgTGl1Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
