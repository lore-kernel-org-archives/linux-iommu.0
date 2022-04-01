Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149B9C433F5
	for <iommu@archiver.kernel.org>; Fri,  1 Apr 2022 06:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9705742556;
	Fri,  1 Apr 2022 06:20:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RqeyZZFxdwkH; Fri,  1 Apr 2022 06:20:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4965942553;
	Fri,  1 Apr 2022 06:20:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B6E9C002C;
	Fri,  1 Apr 2022 06:20:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BE35C0012
 for <iommu@lists.linux-foundation.org>; Fri,  1 Apr 2022 06:20:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B59942555
 for <iommu@lists.linux-foundation.org>; Fri,  1 Apr 2022 06:20:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DcN7l32jvzto for <iommu@lists.linux-foundation.org>;
 Fri,  1 Apr 2022 06:20:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D1E6342554
 for <iommu@lists.linux-foundation.org>; Fri,  1 Apr 2022 06:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648794052; x=1680330052;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=N2HlaecY0jvHr+YPkCbG/e2PYAQnIZgCLo5hsRiDhv4=;
 b=aqa3HNyT1w9QumNIkAwv9jIwFaun9SgOyoBNKF/kGeiPTiIcqn4KEs3E
 DdS7q/1wT+OnKIp6vr2t4cu7C2UmfORS/B+vnpCFWxk5/lgxNMtCGLmqU
 elZ3plp5lkc7t4J7YKRy6l6ZGYwRuu8RddigePRzJjMpjVICNKJl/2rnA
 rlGULvRLHG32bUpmuv8omfhxa/xA5wN/QxuwvSrOch9rQu52/9nNN2Yxq
 ZSFcaGX8gUo2bsQ22j7PN8Mqnb5CueiDfuHf+4Zztb6lxaQTaSd0i3KU4
 uv/kow2Ndv70hXQvp1EtR8xMgZeNbvwtg/zKpa7S0cnqVZmrbTAkUWI2H w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="247560138"
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; d="scan'208";a="247560138"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2022 23:20:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; d="scan'208";a="504050287"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by orsmga003.jf.intel.com with ESMTP; 31 Mar 2022 23:20:51 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 31 Mar 2022 23:20:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 31 Mar 2022 23:20:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 31 Mar 2022 23:20:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0OyS8Ouzy2kgkQHxrbVJ69HCoPIOLfNjex+IJth8ip7bXP30JMrbwmTOC94ybwd29Tyl69z4+I/EotJEyuzEKZ1px63SrS7Zse5qe6eVJNzqvFGHMPP5PlTinRoWyq1J4TU1LOsLusdUlycQtZ8vJTxe1FG2R6eCtYrCAJP99cxAGjnuSHPMUyVKVPeOxBRfKquILpgyiL8GJyrcRO8VMVGGktrbnK+y98/lj3tvy3e53YGZ1t6OgEOUuhQyqMpqWZxcDxl6rQ9yxivoRYs5zPbRm50bGsCpX0Tc+yMYiqGTK5W7fEsncJ6SBTSwdUPYEVe1qhOnejqQyNULQBKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaKr1B8k/2Ym3lXTEa77h+m+fWMDwEPHLG83bf196as=;
 b=KrbFHQ7IvHlW/hQTQU/HBJro0SQnteqW3i4Fuu5jNG8hDFvJ7ZEuIeq5Ir725vm9/MEum4lwWYOIpGPYKAzyrlqlOE6A2zfUWqbDR7Dc8jHtxIMv8IrBG50tJh4T06tYMk227VrbvzYsr6id9LmLH+sQSpvEwncq9g3RTSAlyfkuIQZhDwSXxZYGFmzO92l28e0sLcwYpk8TG+Eyf88uqgdxKdz1jhd2M/1UgyEHU6MpyjHsBXuv6V79laEgczHsNIBEGJIUR8cb/qGbg/ggaKUIUcRFssU/7cDNAubFUzJ8OFZhocwbFb/9D8hcE4iJifzV1Q9GM26J+gKmB6fmIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23)
 by SN6PR11MB3294.namprd11.prod.outlook.com (2603:10b6:805:c4::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 06:20:49 +0000
Received: from PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::bc9d:6f72:8bb1:ca36]) by PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::bc9d:6f72:8bb1:ca36%8]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 06:20:48 +0000
Message-ID: <81ea9536-ba36-deef-b849-6b407b5409e0@intel.com>
Date: Fri, 1 Apr 2022 14:20:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20220329114259.GB1716663@nvidia.com>
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To PH0PR11MB5658.namprd11.prod.outlook.com
 (2603:10b6:510:e2::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b37f50f8-331d-47cf-9e0e-08da13a7c34d
X-MS-TrafficTypeDiagnostic: SN6PR11MB3294:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB3294E6B25C5F4F75CBF3DE47C3E09@SN6PR11MB3294.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ui2jEIggmjf2lgPlp+3By0LxvlQx2o7zXkzUgax/43wnNveS724lG7TJNn0sD7llex12DGVbtAO2cSdhcHIJ6f8PSqAXrugPlyj7Iuq52RtaimCYzgk0C4onhZTC6PwZNg0IFFfxGpAYZ/CZmD8IsJmkWpP1PNp86XcFBOeL7TpouPgLXWXmPK3givxm1XrRyQ02J1xnt3NeOS78ZbAOy5/YhF56jc8zH1XaQumnaXlPO8Ov5lW+LHkhfC68DBGG9eLX0hMxccuYY+5SWeZrmax35mlJHlBFDTWewoWWN5YDRwhr/IInf6RXJ6SzawHERaFErcFpy5xBWg0asBGhj/awfqaGPofLpL1K/9NY76HEU4J0JIY/rU9kCSroVf5n19TWQW+8wgxdB7rxGS3GthCaGFMGC3l3IHEgTuXbtP7u4IPjEWWSW8fvjiuUR2AEV3cES1xzngFf3OBxervjW7R62+/xAo9ahu+HXRA5b45zwAL/p3NOK5tWPLwoR9lrx3zR6yY+a/npMBuWCewKVpMSiVrHZ6C2tdip79nXqpt6Sz9MsROF9xTnN1Bmfky2kEsY8RfI7BmxooZhatntdK9m8Tre9DNzOzwEQS7PFFMc9EYGB4THtgJyGKJTjtDMKhzH31q1Suu1P7zZ3r4qEzrDoz4uLwLVss3ob9gBOO2M6uBNyEm7iyv3tw7MGGHzTInKMTaXKsVM0w4eDlmOTIU60uB2jkFR/oVmxsHipQIw8stjgkbXeZ6lPGn3orht
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5658.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(82960400001)(5660300002)(508600001)(86362001)(38100700002)(31686004)(6666004)(31696002)(8936002)(7416002)(6486002)(66946007)(53546011)(6506007)(6512007)(8676002)(4326008)(54906003)(66476007)(110136005)(66556008)(6636002)(26005)(186003)(316002)(2616005)(2906002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlgyVjVod20yeTRDaEt4a29yaDA2MXYwUk5JVklzMFlSaW9ZUVBJY25WOG9B?=
 =?utf-8?B?ejU0bW9peUVZekhneUljaGtwOENZcmNwSzc1UUxpdVZvYVpydWxnNzhiNWNz?=
 =?utf-8?B?ZzVjRGNnaXJvTDFRZ08zb3I3VWxNSDM4YXhPcXgxWGdtZDJ2OWxVdFgvYTBk?=
 =?utf-8?B?SXcwVHl3M1AyRXFabkVxQUVCcFNJVkx3UG1ZclhyQ1REYzdTdlB0bURuNlVK?=
 =?utf-8?B?d1M0VVIvWnV6alBJTVBYV1BNMXAxampOejVYdzUxaGphY3RQK0dkY0N3MlN2?=
 =?utf-8?B?L1YyUkNXa1hvbmRhNEp2Vlp5N2xmYjNSMithUHZsc1J5dEx5YVFKYk9OaGNz?=
 =?utf-8?B?dW1DUzR6K2cxZFZrR1NWWEN6cUg2YnUwekNQR2dNdCs2RGdHSGNaMGd5QWly?=
 =?utf-8?B?dkRxdVc2VVBiRlVTaFBSZE1WR1VwV3MyWG41T0w2cy92RkltVlJMNzdtVnVH?=
 =?utf-8?B?aHlLR2dta2xUKzdNekNYclF5aHE0ZDYvOU5ENG1IVXM3YmZNNHFKcDNwcWZS?=
 =?utf-8?B?T3NPKys3MDFPSW95ODA3Ry9uZnNxdTBtNnkrb29qcFpCbGRFa1lEazJFM0lR?=
 =?utf-8?B?azU2OW9UeUs3ZVN3d3NmbFlJaW5MS1hOZGNWdTlSVCtENVB0QmY0cXFFdnBq?=
 =?utf-8?B?RkQ2bHFoR2ZUN0JXUVUxS25jWml2SFdBNlRvSHJuMExDNjdMR2RpZG1NdjNB?=
 =?utf-8?B?K3JzTUlJNGJkR2cxbStOY3B4VVdWMFRzZnk4KzRNRUs0YUdoZ21ucjFTV296?=
 =?utf-8?B?dDdaZnQxQnpNb3Rqc1hkM0doVVNJZWRMd2xJTUY4ajJMSlFRYVM4YVV2MXVh?=
 =?utf-8?B?TDY4cUwwUHpyNTRRWjhsTWtGOWdFVFlERjNVM3ZYc28rM1MwckIwdkZwM1FK?=
 =?utf-8?B?QXl2NjhqSC9OQ3NHdnBldjd1UTBtZGxmVk5iWTlFZVBEWDZ6WW9Jc1hocTVD?=
 =?utf-8?B?UGNiMnBoZldkUzI5ZVNPb3p0YVBLUmlzVDVIb0hSTStHL2pMQkVmOG9BU1Qv?=
 =?utf-8?B?cEZqbDBnanJ1SWt3cFZZV0FzOFFWVU5LSFNMRm1RNjdCTGpvRTlESUNFSGxQ?=
 =?utf-8?B?SVF2NDYzOEF3UzVFV3RiTWpFTVVYTHd4cllSVzhjMnYrOS9rSG56YXJHZzBX?=
 =?utf-8?B?TUdkZlNiRzBhME52THI3dTdHNFFqRU5QYk9WTW5CeUJlZ2szRjlnYi9veElD?=
 =?utf-8?B?dzdLbVhnRkMvL3Q0VTlPcGVZdGpFVndqQWsvbEpjME5uQnlDTjFldEt3N2VV?=
 =?utf-8?B?alNSMFg5MncxQ01hWW5EWVZ6ZFE4Slc2azNMdEZzYzArcEY5SWtnbjFYM2xp?=
 =?utf-8?B?MXZJT1djaGZYRXJzM212MThVMFZFOE1OV2VNcG43YWYxaWVjanJReTlHTk9K?=
 =?utf-8?B?NzJ1dnBBdVFZSnhidmtZc2YxdENqRnJZdGJwc1JXWVUvdis3SG5HeFJ1YkdN?=
 =?utf-8?B?cklmYzR6dUdiY1R4SUJwcUk3MDNsSTV0bU0wMnBXQlhaUjFLeVNQT0crUncy?=
 =?utf-8?B?WmdIZkFENEFpWmFKV2d0VWFlTk55a1BmVmVkMndtUnNKU0NIaHI0ek5RTEJW?=
 =?utf-8?B?am12aXN2NWZVUS9JRjY2VHNMRWEyS2YvbjFjdU81MzMzWW0rUWp6MnZNcmg3?=
 =?utf-8?B?MG96aE0yK21SaXlDdmNTcHVmVFdIM1F5R0t3N3VXYWxJZUE0RG9pVm5XM1d4?=
 =?utf-8?B?TXdSNmlNVi9JYXhLSXRZSVllOGFrWmFPb0RvanNPODNMOGV6K1BtOFZxZXho?=
 =?utf-8?B?cWVTTEdPRGFQRTdwTTk0bkVvTkQxaDZyaGlWS0R0TlM4Nk96bVRKMStKa3c5?=
 =?utf-8?B?OCtFUWVqMElKaU9qVFA4a2lKVy8vOWVDWWxXNHFhcE9wYnp6Q3JuMzBYd1V1?=
 =?utf-8?B?STUrVHRnZXoreTJtemhqZDVEUkJxVEZkN1dienZkVzdBa1dZN0t3OTc0QUJL?=
 =?utf-8?B?YTZwdVdHZXM0YStsRmE2VFluUHZkWFlLNDN4VlAvUXRCbjJVU0l5NzRRYW5W?=
 =?utf-8?B?c2h3dTRMNDlPcXhMR1RLOGFlSU1qWU9WVHhJSEdZa3hocWpFZDFBeEp3YURO?=
 =?utf-8?B?c2dKajlJR3dONmhMQlZRTHlnVm5TQmdDMXlZU1lmWjZ4cGhLMlJ5Tm1xNWhr?=
 =?utf-8?B?aGR2S3d5dTByS2Y2dk5LZEtGajhsSWJrMFcvSFlESitGUzlrYWhGSVZ2d1U3?=
 =?utf-8?B?bWxqbnBuOGdiUGtsTmVRNzl5TlFqZTlMalZud3JnTlg1bXpsM20ySU1nbmdq?=
 =?utf-8?B?M1hjQVhQdGtLR1JKeVkyaS8vL0lwMStHZ2ZObVA3QWhhUGN2MzYrUnlKdDNm?=
 =?utf-8?B?ZmErbktQQnJsVEJUMTVqb2xCc08zbFI2YWkvVVBNZHAwcURIRFJLVWwvZVps?=
 =?utf-8?Q?zPxYd6stY1yhQcHo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b37f50f8-331d-47cf-9e0e-08da13a7c34d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 06:20:48.8155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VK1TJ3t+AlgvWMkhQirhrNuAEzVhTNIWkAE1EXbpUeWY6nbn1+YDa2q5G3Nzta8aj5F41wdSpy8p45AqJvKxSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3294
X-OriginatorOrg: intel.com
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 2022/3/29 19:42, Jason Gunthorpe wrote:
> On Tue, Mar 29, 2022 at 08:42:13AM +0000, Tian, Kevin wrote:
> 
>> btw I'm not sure whether this is what SVA requires. IIRC the problem with
>> SVA is because PASID TLP prefix is not counted in PCI packet routing thus
>> a DMA target address with PASID might be treated as P2P if the address
>> falls into the MMIO BAR of other devices in the group. This is why the
>> original code needs to strictly apply SVA in a group containing a single
>> device, instead of a group attached by a single driver, unless we want to
>> reserve those MMIO ranges in CPU VA space.
> 
> I think it is not such a good idea to mix up group with this test
> 
> Here you want to say that all TLPs from the RID route to the host
> bridge - ie ACS is on/etc. This is subtly different from a group with
> a single device. Specifically it is an immutable property of the
> fabric and doesn't change after hot plug events.

so the group size can be immutable for specific topology. right? I think 
for non-multi-function devices plugged behind an PCIE bridge which has 
enabled ACS, such devices should have their own groups. Under such topology 
the group size should be 1 constantly. May just enable SVA for such devices.

> ie if we have a singleton group that doesn't have ACS and someone
> hotplugs in another device on a bridge, then our SVA is completely
> broken and we get data corruption.

I think this may be a device plugged in a PCIE-to-PCI bridge, and then 
hotplug a device to this bridge. The group size is variable. right? Per my 
understanding, maybe such a bridge cannot support PASID Prefix at all, 
hence no SVA support for such devices.

-- 
Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
