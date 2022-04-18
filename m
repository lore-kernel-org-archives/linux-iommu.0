Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6CEC433F5
	for <iommu@archiver.kernel.org>; Mon, 18 Apr 2022 10:48:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2419940374;
	Mon, 18 Apr 2022 10:48:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9eS2aE89zp6c; Mon, 18 Apr 2022 10:48:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C085F400F8;
	Mon, 18 Apr 2022 10:48:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BF6EC0033;
	Mon, 18 Apr 2022 10:48:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD7CEC002C
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 10:48:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B3F88605A3
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 10:48:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RD-4zY5w07a8 for <iommu@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 10:48:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8968D6003C
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 10:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650278885; x=1681814885;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RQAO56PUB9HhMoykp+UWau/Sg0r9dEkuTEVKxABJgig=;
 b=R6KVqwHSI4kH1jPjyaImpWbJX2Xh0XNTGoLrI6EI15oBXQW/NBnd+K5X
 zgcrxKFeLHUCqeRQ6OI/CfjNINK7l3Jcll1lioGOqba7Hgbomudl61lKQ
 VPqfyGsogXSXcJKLylWnz+sCaQ/vkkEVikUlZxxx6a1Vuwt5mi44xbVe8
 AZu+vI74c04Wjzg9SAFQSEhsggp/Tho82dBQAIFWkdmqpOX8+fPkra1GS
 YroAKMqt+EAjND1JMKReXRwAAVsQRGGMMAc5w8rwywUdAFTBR2PErTz/q
 G93CupRt9z8aEDUx5SS+R3R0ga1+zsgedvstadXoQGEkdu+GRaJHbLQdL A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="326397249"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; d="scan'208";a="326397249"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2022 03:48:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; d="scan'208";a="509703077"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga003.jf.intel.com with ESMTP; 18 Apr 2022 03:48:04 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Apr 2022 03:48:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 18 Apr 2022 03:48:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 18 Apr 2022 03:48:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+Itt/G9wXN6J9/lwhPVRarWUZ598vSrYnsvl4E1NwRrKdkHGMEuatyoHfunpyGyoiUjBPsO+ecKdFXvS6CZjnVmnhUjJnc2eKeOcr/39cUY07qGM6SdjMpsa88582v4Kvnd27lFtC6vQJN7cehwYObaZV2/4WiLZxUEFrTBzzuztjLQxZkKvBGf6NovZt7eY5dIt+ey+v6heWHA9Vjpnl5+98GdBHw4WtHWlHJNVJVcyA5O3WM3ODfKW6rVMr5WwkJeeklo3EAdalFgM0M2X9hEp2GRCt821I7SBj/mPgkcuu54McX/lJmS/sPU2IHyRyC1MTi3ui9taiV1QNeZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAOdJuQEEhWh2PBt2KINcvBj7KABe06C8YYJnowliS0=;
 b=YqFn7Q+p9yLmjH0xcwMyDqKFI4Tr81rq+I60cUUA1qhzB2etHPBuHFeJEIr/MEPnCFLENNDJHydIbvWgb3JaRCtatNHtSL6tvOBdStaYRxCi+1vRxYuTdNJixhObJLdo4VjvlsxslQcOIJLN36iuSmEEtmGfHu3C+bYRI4mFB13j8OyvJnoaiElvLkw2aXwJeST11Ijke6I2ykvg0jnxebpMKjPTnfaSm1xDqi+hPaUqYw3APYQVBbRfGENDdO3wC9wZGpGjeAKqxtWR3GmsH/fscNyYMDhEfGWxP2B8Jlmz+TtJzA30Rgie5aQSs20z35OADsgpKxc+0ZT8Mc9VfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23)
 by BN6PR11MB1762.namprd11.prod.outlook.com (2603:10b6:404:100::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 10:47:56 +0000
Received: from PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::71d2:84f6:64e1:4024]) by PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::71d2:84f6:64e1:4024%8]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 10:47:56 +0000
Message-ID: <b5916063-5c16-b9d0-2825-7b6f858ee3fe@intel.com>
Date: Mon, 18 Apr 2022 18:47:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 07/12] iommufd: Data structure to provide IOVA to PFN
 mapping
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
References: <7-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <17c0e7f2-77ee-0837-4d81-ee6254455ab7@intel.com>
 <20220413143646.GQ2120790@nvidia.com>
 <42f6e2ac-8abf-8275-01fd-9b0c5dd53b4a@intel.com>
 <dea7b099-cc21-51f0-e674-50901a7a966b@intel.com>
In-Reply-To: <dea7b099-cc21-51f0-e674-50901a7a966b@intel.com>
X-ClientProxiedBy: HK2PR04CA0075.apcprd04.prod.outlook.com
 (2603:1096:202:15::19) To PH0PR11MB5658.namprd11.prod.outlook.com
 (2603:10b6:510:e2::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5703645b-76ef-4195-ef53-08da2128e562
X-MS-TrafficTypeDiagnostic: BN6PR11MB1762:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB1762FB918309924D800EFDB7C3F39@BN6PR11MB1762.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+8Eh8DVxjTcaFHbwVsVrxW/NbKwRtbjJ7l9otl0lEOXF0Dt/NKE8yuH++pxIkHu8LHzrLuwGKknwJkTpentvdTpzGSwWZKzIDpcSdui8ksUdt7raWsilTpK+nNK+L9Ou6s4+zdLjitMavyBJFzxZTIwE4TDzI5/EB/NPSEnFmkS63T5S9WdbPcoUdpwDWl9CUwrID4L7wuXRhnf93LSL0HW5A/0JeTKS+vhtgdfcs7yScBI91Vi90eDNcoIVWgvDNDJBzxjwpa4SwrWdhWRGmTv1IGFJGqzE1FY72n7hYjRQvWCS7oaLCuzsHK3LsrXqzpA8zi8RrJti8EzVSKvozTagYQAx6yUvugTTZepx6MVHNKMC7JBNmbDeqqohP1vs4xnNehBgN4v8YAEUQq9VEU1TkteRjretv6yArA2vw2AEsPbpvyJx8vcbvUA9cv0OUU4Kx6KCRx/VT+lgHV1IKrUWyAR02S4Y0PHTNoODGNUkQnbhxD4VYcsRnVUg8q7ETwsoz0P0sSWnGh978BqGZLYzS4d4G+d2x9h5Pq0Xrdxz8Ic/XtvTULFlzcaC8kDqei5PtTRz5cHy0seZBYnfnb/kcB6GG1WOnQh/6tqqVn8M9H24vqtk+oPtsdWOdzfzN6TLI1QzCBUy81O37lEf1ZTfMbBq8zgPSy3CpDiiu5k16frfGvdj5GUHisMICTeWkSzuFq5GbhKwPpOtSUt7kI6xFH5g/QKezP1aCeVcPuYkIYbDbkDuJl4X9TE3wVMAjaKNwfJic9L0zNGsqT58c8crsDby5r/RXGFC0GgurparbG9hETxR+oa1MwX3hAV+W9YO9YhmsNL1N1lBwZjWlmTSCJE1jkzKYLOICu24z0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5658.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(4326008)(66476007)(66556008)(66946007)(36756003)(53546011)(7416002)(8936002)(5660300002)(508600001)(31696002)(2616005)(186003)(6486002)(966005)(86362001)(2906002)(8676002)(82960400001)(54906003)(6916009)(316002)(31686004)(6666004)(6512007)(26005)(38100700002)(83380400001)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3RCcXFnUEM2L1ByNTBHOU55cUpZTVo3dlFYVEZlNDlDSXFlS0lyVEFzWVFs?=
 =?utf-8?B?TGo4TzAveGE2VFViYjVkdk1HdXpFb0NldmxhVlM4cVFLUnRuK0ZMemlpd0cw?=
 =?utf-8?B?bEVWY2xtVjMwRkdSQWhsTGJsYjNSTHJwT3dXcDgvemJ2MERlR3JjTkJOQTNQ?=
 =?utf-8?B?UGxQYTZMS2xCOGZMK1ZtY3AyTVdFcjM0MEpSQXR5R2ttMXMwZUJHancwL2Rj?=
 =?utf-8?B?ZHZLTWZ1QjNSSTM0c041c3JJZFVBOU9FcldlbTB2dFlxdGVxeUlJL0hyN0hP?=
 =?utf-8?B?VmlxZlhsMG1odW9QMlVEZ0J1bEpFa0tXY1QwaFArQjhQNTNBd2hHL0prMzVn?=
 =?utf-8?B?dWI5SjlmdTBVMjhrQk1sOG9JRzM1dHFjTHpQbWo3VjN0MzA0MGM1QmtxYzRS?=
 =?utf-8?B?ZEtOc0V0a1VUNkQ3bHQxU2dGbDUzVUc4ZGpON2RhVHJwL0toV3piY0JQaDgx?=
 =?utf-8?B?RHFMVGtObVlVQzBkbno1MnNMR1FCZWl0VHFzalNkM2Z1Y21nRVdncFlSWUhD?=
 =?utf-8?B?K3NJekVHSGprRUpFcEZGUSt6eERXZmx6WjhhRFR4Vk5Hb1BacUpnUmtkYlUz?=
 =?utf-8?B?c1VKMVpRdTZLOXdCUjhrWlVBS3R5VWpCekxwMU1UYjZOM0pZektwUDBXYmFT?=
 =?utf-8?B?UUpsMGYrMzA5T3ZuY1JIVThPcXBkNU12QVAweS9DRzE1SXJkYU83LzMrUkhB?=
 =?utf-8?B?MVpwMzNNenlmclhyaXhKMW5xTW5nRlBEcDNCQnppOXVtU1pSQ2Fnc1Ntb0hh?=
 =?utf-8?B?OWhwUHJDMEorelZ5d3FZSS9Rcm1TaHlqaHdqdnhESEhuZTJ0d3pGRml3ZXBF?=
 =?utf-8?B?WTA3QVJXQVZGV3JDZjRQMDBydXpMaTZMdU9QaDBLYU43NW1QNFBaU2NmWkY5?=
 =?utf-8?B?cmZYREk1TFJid044c3RRcHloUFE2QWRaVFJ2cTlxQ3VpRzhIWHJiM2FUSmpo?=
 =?utf-8?B?Ym5GQzI0RVA0d2l5SlVjSEo0V291SFQ5TGRjc1dBN0xyWENMUng5aTNpbDBw?=
 =?utf-8?B?S1hPZDVZTFY1ejNSdDU1c0piVjhRb002anJkK3F4WFR5TVVBaEFWWTJpWVJZ?=
 =?utf-8?B?QzZSZVF2YkRnS00xN2REWWp5dmFrNmpNckZKNlRWdlBTaVEzcExQRXR5YTZG?=
 =?utf-8?B?RVpqTXlCWDJEWlRsem4rdm93b2gxSkxXbStWa1lFNzc5Vmo0aURQU0Nyb3dH?=
 =?utf-8?B?amRXZ2RYTEg4OVpuaE0rYUE3N08xWFE1OGpIVS9RaWZlZmVxTVp4L2FwWkxy?=
 =?utf-8?B?MGZUZ1JKZTdLVTlUN3lvMHExWldSeUF5ZGsvMGhCL0RlRGtTRmMvZUhOd0pJ?=
 =?utf-8?B?NG5tSGlHaEpSTzJBQWZvR2tOWlVpU3F3cnhZY1gwbkUxTndpbUpmWUNZVm16?=
 =?utf-8?B?L0NEQy9ZN2dSQzJINFJBVytuQW1nSVJtSWpHa0ZiY1VHTmk4b1lqc2tRWjQw?=
 =?utf-8?B?Y2JVVXFhYkRjY3ZpN2U2NWhuV0RpUHB3ZmtseWMyUmgrMTMrbnRkc0w1UkV4?=
 =?utf-8?B?YkRxaGRhaTZ6TC9yRGF0VW5WRHdYa080cHRaZjk4NWltSWFFQ2RkZk5iVW1v?=
 =?utf-8?B?bFF1MlZjcVg0dEhHU2g1dk9PNTJscTVQWGpvSVkydUNUaHhIbGVTYjJ1NllJ?=
 =?utf-8?B?d0gvdGorUUp3MVlYWkV1UkpXOVllcmVxUDdZMTB1Vng4cHNtSjFlK0x0dXR0?=
 =?utf-8?B?ZjZRYUUzS0s5ZWl3REZEOWxQd05oVE9kb1k1bEZWcVZIOG4zdFE5WVY2c0lx?=
 =?utf-8?B?WENFeUZENVc4NmV0QUpmOXNwMndFbjFMdGU0b2tnczJ0cnNOakpUSG51RzY4?=
 =?utf-8?B?d0lVdXcydk5RaGRPaWZCazdDN1hpR09ZdjZRdUhpM2FOQzBWUXY0MU9EOEdG?=
 =?utf-8?B?SXV6VmNqbytXRGN4NWZaSG9iRXFoZE1VeWI3TE56UWMwS1UvVDdFdzZWSTlC?=
 =?utf-8?B?NVR4elFPcHcyVDM5MTFVUlRmTit1bk9QMm43NGtYMngwWjdaSEJmSFYvNU1O?=
 =?utf-8?B?Q1RuM3QrMGFqOTRHZlFkWExDSzJkWWwvallQMnFSWmZUdm5yNnZkbUx0a1pC?=
 =?utf-8?B?ZXNVYWgrNE0wejQyZmxhaFVwSi82NXJKMm5DajRMbUpDOE9aZWZZZjJwalRQ?=
 =?utf-8?B?bkl0MlBlMFdHeTR2ZkhvcU5RM1I0NHJQM3pmK3BKaWtVS2V4eHcxbEVFdS9r?=
 =?utf-8?B?QnNuZzRSSHdLbkNYUVZocnU5U2YxS2xYS1YxeXFUZkFQU2lEMFQwbzVOYlV6?=
 =?utf-8?B?VnJodTdNVXdPUXJ0bE8rbnlPNlJjYUVaNnk4b1pzL2JyaDNGV2ROZzJKOEdl?=
 =?utf-8?B?MFlQM05Uc3czUW9EL1lwY2ZRbVdQbm03TzdNK3hac0I1NlFmanVDQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5703645b-76ef-4195-ef53-08da2128e562
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 10:47:56.0638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSEY8XgCMdnPvelJfZ1l257nmNzzyoyQjd2JU1Zo1MPA6P7+nrIkJm+AIgb8r2d4qKxt5/++2Y4SfaB91HCgZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1762
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 iommu@lists.linux-foundation.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

SGkgSmFzb24sCgpPbiAyMDIyLzQvMTcgMjI6NTYsIFlpIExpdSB3cm90ZToKPiBPbiAyMDIyLzQv
MTMgMjI6NDksIFlpIExpdSB3cm90ZToKPj4gT24gMjAyMi80LzEzIDIyOjM2LCBKYXNvbiBHdW50
aG9ycGUgd3JvdGU6Cj4+PiBPbiBXZWQsIEFwciAxMywgMjAyMiBhdCAxMDowMjo1OFBNICswODAw
LCBZaSBMaXUgd3JvdGU6Cj4+Pj4+ICsvKioKPj4+Pj4gKyAqIGlvcHRfdW5tYXBfaW92YSgpIC0g
UmVtb3ZlIGEgcmFuZ2Ugb2YgaW92YQo+Pj4+PiArICogQGlvcHQ6IGlvX3BhZ2V0YWJsZSB0byBh
Y3Qgb24KPj4+Pj4gKyAqIEBpb3ZhOiBTdGFydGluZyBpb3ZhIHRvIHVubWFwCj4+Pj4+ICsgKiBA
bGVuZ3RoOiBOdW1iZXIgb2YgYnl0ZXMgdG8gdW5tYXAKPj4+Pj4gKyAqCj4+Pj4+ICsgKiBUaGUg
cmVxdWVzdGVkIHJhbmdlIG11c3QgZXhhY3RseSBtYXRjaCBhbiBleGlzdGluZyByYW5nZS4KPj4+
Pj4gKyAqIFNwbGl0dGluZy90cnVuY2F0aW5nIElPVkEgbWFwcGluZ3MgaXMgbm90IGFsbG93ZWQu
Cj4+Pj4+ICsgKi8KPj4+Pj4gK2ludCBpb3B0X3VubWFwX2lvdmEoc3RydWN0IGlvX3BhZ2V0YWJs
ZSAqaW9wdCwgdW5zaWduZWQgbG9uZyBpb3ZhLAo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB1bnNpZ25lZCBsb25nIGxlbmd0aCkKPj4+Pj4gK3sKPj4+Pj4gK8KgwqDCoCBzdHJ1Y3QgaW9w
dF9wYWdlcyAqcGFnZXM7Cj4+Pj4+ICvCoMKgwqAgc3RydWN0IGlvcHRfYXJlYSAqYXJlYTsKPj4+
Pj4gK8KgwqDCoCB1bnNpZ25lZCBsb25nIGlvdmFfZW5kOwo+Pj4+PiArwqDCoMKgIGludCByYzsK
Pj4+Pj4gKwo+Pj4+PiArwqDCoMKgIGlmICghbGVuZ3RoKQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIC1FSU5WQUw7Cj4+Pj4+ICsKPj4+Pj4gK8KgwqDCoCBpZiAoY2hlY2tfYWRkX292ZXJm
bG93KGlvdmEsIGxlbmd0aCAtIDEsICZpb3ZhX2VuZCkpCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gLUVPVkVSRkxPVzsKPj4+Pj4gKwo+Pj4+PiArwqDCoMKgIGRvd25fcmVhZCgmaW9wdC0+
ZG9tYWluc19yd3NlbSk7Cj4+Pj4+ICvCoMKgwqAgZG93bl93cml0ZSgmaW9wdC0+aW92YV9yd3Nl
bSk7Cj4+Pj4+ICvCoMKgwqAgYXJlYSA9IGlvcHRfZmluZF9leGFjdF9hcmVhKGlvcHQsIGlvdmEs
IGlvdmFfZW5kKTsKPj4+Pgo+Pj4+IHdoZW4gdGVzdGluZyB2SU9NTVUgd2l0aCBRZW11IHVzaW5n
IGlvbW11ZmQsIEkgaGl0IGEgcHJvYmxlbSBhcyBsb2cgIzMKPj4+PiBzaG93cy4gUWVtdSBmYWls
ZWQgd2hlbiB0cnlpbmcgdG8gZG8gbWFwIGR1ZSB0byBhbiBJT1ZBIHN0aWxsIGluIHVzZS4KPj4+
PiBBZnRlciBkZWJ1Z2dpbmcsIHRoZSAweGZmZmZmMDAwIElPVkEgaXMgbWFwcGVkIGJ1dCBub3Qg
dW5tYXBwZWQuIEJ1dCAKPj4+PiBwZXIgbG9nCj4+Pj4gIzIsIFFlbXUgaGFzIGlzc3VlZCB1bm1h
cCB3aXRoIGEgbGFyZ2VyIHJhbmdlICgweGZmMDAwMDAwIC0KPj4+PiAweDEwMDAwMDAwMCkgd2hp
Y2ggaW5jbHVkZXMgdGhlIDB4ZmZmZmYwMDAuIEJ1dCBpb3B0X2ZpbmRfZXhhY3RfYXJlYSgpCj4+
Pj4gZG9lc24ndCBmaW5kIGFueSBhcmVhLiBTbyAweGZmZmZmMDAwIGlzIG5vdCB1bm1hcHBlZC4g
SXMgdGhpcyBjb3JyZWN0PyAKPj4+PiBTYW1lCj4+Pj4gdGVzdCBwYXNzZWQgd2l0aCB2ZmlvIGlv
bW11IHR5cGUxIGRyaXZlci4gYW55IGlkZWE/Cj4+Pgo+Pj4gVGhlcmUgYXJlIGEgY291cGxlIG9m
IGdvb2QgcmVhc29ucyB3aHkgdGhlIGlvcHRfdW5tYXBfaW92YSgpIHNob3VsZAo+Pj4gcHJvY2Nl
c3MgYW55IGNvbnRpZ3VvdXMgcmFuZ2Ugb2YgZnVsbHkgY29udGFpbmVkIGFyZWFzLCBzbyBJIHdv
dWxkCj4+PiBjb25zaWRlciB0aGlzIHNvbWV0aGluZyB3b3J0aCBmaXhpbmcuIGNhbiB5b3Ugc2Vu
ZCBhIHNtYWxsIHBhdGNoIGFuZAo+Pj4gdGVzdCBjYXNlIGFuZCBJJ2xsIGZvbGQgaXQgaW4/Cj4+
Cj4+IHN1cmUuIGp1c3Qgc3BvdHRlZCBpdCwgc28gaGF2ZW4ndCBnb3QgZml4IHBhdGNoIHlldC4g
SSBtYXkgd29yayBvbgo+PiBpdCB0b21vcnJvdy4KPiAKPiBIaSBKYXNvbiwKPiAKPiBHb3QgYmVs
b3cgcGF0Y2ggZm9yIGl0LiBBbHNvIHB1c2hlZCB0byB0aGUgZXhwbG9yYXRpb24gYnJhbmNoLgo+
IAo+IGh0dHBzOi8vZ2l0aHViLmNvbS9sdXhpczE5OTkvaW9tbXVmZC9jb21taXQvZDc2NGYzMjg4
ZGUwZmQ1MmM1Nzg2ODQ3ODhhNDM3NzAxZWMzMWIyZCAKCjAtZGF5IHJlcG9ydHMgYSB1c2Ugd2l0
aG91dCBpbml0aWFsaXphdGlvbiB0byBtZS4gU28gdXBkYXRlZCBpdC4gUGxlYXNlIGdldAp0aGUg
Y2hhbmdlIGluIGJlbG93IGNvbW1pdC4gU29ycnkgZm9yIHRoZSBub2lzZS4KCmh0dHBzOi8vZ2l0
aHViLmNvbS9sdXhpczE5OTkvaW9tbXVmZC9jb21taXQvMTA2NzQ0MTdjMjM1Y2I0YTRjYWYyMjAy
ZmZmYjA3ODYxMTQ0MWRhMgoKLS0gClJlZ2FyZHMsCllpIExpdQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
