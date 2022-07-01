Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38948C433EF
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 06:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCE7183FED;
	Fri,  1 Jul 2022 06:09:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCE7183FED
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QOfooJIV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KTDzeBhRgjIU; Fri,  1 Jul 2022 06:09:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9223683EFA;
	Fri,  1 Jul 2022 06:09:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9223683EFA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5814EC0035;
	Fri,  1 Jul 2022 06:09:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E054C002D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 06:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0250341610
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 06:09:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0250341610
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=QOfooJIV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fux6smZODt6K for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 06:09:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E8F5B414E7
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E8F5B414E7
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 06:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656655794; x=1688191794;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GYjCsU7pqRStUQVNQnL2WXfaZUcwk/PNNn8aHlRr7n8=;
 b=QOfooJIV9wzqbqTUKJ60L9ALWJjnJ9RSIUoGUnAclDHWqrrI2DAsY3s6
 4R0KAp/kJDGdg5k/Tp/p8xLKbvbHW/3RpEcB9wneQFKJUzPBoQIZxK+M9
 CJ2zssCDKUkdGEBXb0KJHxMZf1XE1JcKAjb3M4pu0BLMMfGHb0fKYM6Rd
 TFe4IA/DkC55kJILkpm9GGHC+fhxHWOaiFdytJ5WsZ09aaYW1McHXNleL
 wVgBd2BsSNyo2nAC81z14vP1Dyq1opUM4jmWU5URzk3afaOrF5WiTEBQT
 QEdSFtD/ey0MeQiSUWBYB+p2P3dk04lCiw1pHtLGQpIarcGIkn6ilDpVJ w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="265593941"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="265593941"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2022 23:09:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="618292809"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by orsmga008.jf.intel.com with ESMTP; 30 Jun 2022 23:09:54 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 23:09:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 30 Jun 2022 23:09:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 30 Jun 2022 23:09:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YT4hSroW9T5MII7Mi+FS9zkpYDQDlxhphdA7aSe6RL0SwvxY/SNjijerJ/sA4XczgmXinyvD1o7BFu3n3szh9ZrQc9U7MKCxvZqP2RVEptekZ22aLK9Efol61Pa0R1ppkFtV26eMMIxjK1VhH5Kunzob5Z1+ELwYdHlk+5sr90hJbcESEII/N+UU00IK36XbhA984f15laJs0ckQ2ty8lgfATZCoIydKYEYFASUV9duGlk6XekmnntEShu/9+An8alFFVKbIfKn5jUb6mKV6ncOvM7xk1GqcO3k91odcBMJCjFRMKTTggWqMCCGQJz7NjPJTUkoMAm2QT1Tq696S4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYjCsU7pqRStUQVNQnL2WXfaZUcwk/PNNn8aHlRr7n8=;
 b=UWTCoYqcOBaSb0C+cgwso41RYLNXqFXIaInp67YRTFU2Q669khXxBQ8ENq/pGWLcdq7ez3muyIM7s74WhyB/CFbNFyVQN8QCubcnYtfmLHPwnKH+ZnxYcepy5RReE2TYhi7Zbs2U9kD1JYOhEvcIfMaqiDF4vKYfZ5a6Conso6HjE1/KKXAMCwh4o+AegLtNSkKkINjJc1jPGH2MwQ44KyLNzdwBp6/KuwdMO0UZ1hocl6pmIqpRJHScwdJDk9JHK3c1o3Y6A2nlg2NIA82hlzIdvVCHShgAbHmKWDB84GHZtF8+XVJ2s5o/z0byxzwulQWpd/Fnu9i82gS5WgWM9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4626.namprd11.prod.outlook.com (2603:10b6:5:2a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 06:09:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 06:09:52 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Steve
 Wahl <steve.wahl@hpe.com>
Subject: RE: [PATCH v1 4/6] iommu/vt-d: Add VTD_FLAG_IOMMU_PROBED flag
Thread-Topic: [PATCH v1 4/6] iommu/vt-d: Add VTD_FLAG_IOMMU_PROBED flag
Thread-Index: AQHYiJMJkSfp+Ms7gkCsHugg52JWua1npWyggAE6ZoCAADE/gA==
Date: Fri, 1 Jul 2022 06:09:52 +0000
Message-ID: <BN9PR11MB5276E263D89459506396A84A8CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
 <20220625125204.2199437-5-baolu.lu@linux.intel.com>
 <BN9PR11MB5276F90888CE86824251E5FC8CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <239cfd97-b381-f523-f149-e127f44a0780@linux.intel.com>
In-Reply-To: <239cfd97-b381-f523-f149-e127f44a0780@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7f0a2f5-b170-4e98-7589-08da5b284ffb
x-ms-traffictypediagnostic: DM6PR11MB4626:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3vazzCRR3atfjDjBmgilRnTr2e5cfs6LhTIi83Xvc4OOnjQm4h1mfpSdIS1a/zB0VHnTve+gFECQj3kvOgo/qkDtvmdLvI5t52ytQPszKQQEnh+dTna4w0Rz4v3C5XCyStKZ1WRV3XM1xedIGeSWPcjC0qH6c6mTWUbIDWs5TJKIH7Uo3E9gXITkT+H8QZv5GAPz0yLspEg64rYOiZGCjKFDgbn951Y7Jbnq4TOYPvDwgTilBIcZSU6mt5x6D+ksvp70oJaoI9JZH3h3tiSmtD0eb+nz+kYYa61MTV+4iiNFJrUdOOx5LYvlA36Rzj/WrDVo2UvhQynt78uI2ZkWVDXvCgKLYpjtZV6wcPyOmKQ0cVbv+Nlq+lvUoqH2CN0aAdY+x/s6jYcV9CuSfFERcNNrfRzWByEf6rL/0sL+S1KuRtNMvqBK6fuTkLzZLKMSza35qX4irBDh2S5QBcY2C2y4KpAbj0hJDf3YRx98mpp8lL2QhOL7Ul3OSpWPODinq9Hl8MsqGmxSAPQItlQV80/DBv5+aRHZnWIeCsJMPk9qeo4Z49JagMPm6ik6kqaNQjHbbEvejQNRieyqZzltlA40EpAU/sqxn9suEK4dAqrD9ZjdSEuoyJHKc+uoK30sFxTqRrcGGZWX3HjLaYG+Q39isHhmAAvNeJEzfx1nd+dbmXCmkRUEnWIRkoiRRUhNnvFvf2hMTuTxr41Q22QeKf2c3wbkxl+brkMtCFhThVtPi/hBRFF1fCc2XBaddDqYEA+ilT2J0wOhk3EQ7pIFL5lu8+0ggq29cbOaaTJe1bReWG73TGxs3ZTwagkwerKL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(396003)(346002)(39860400002)(366004)(136003)(376002)(54906003)(316002)(76116006)(38100700002)(86362001)(41300700001)(64756008)(66476007)(66556008)(66946007)(66446008)(478600001)(33656002)(38070700005)(82960400001)(122000001)(186003)(55016003)(9686003)(6506007)(53546011)(26005)(7696005)(83380400001)(4326008)(2906002)(8676002)(71200400001)(7416002)(110136005)(52536014)(5660300002)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHJyVUJMbCtsRTBRUzcvcXV2RnVRVGxuZGdVUWpoTVpBQWFRbHBVTnRTTC9n?=
 =?utf-8?B?SXRVRlVlVjc2N0RBbkNzQzdXcDM0d3loUTNhdmp3QkhwQmxnUnVBKy80TXhn?=
 =?utf-8?B?czJWM0JtOGpndTl5OEhmRWNFVW9EcVBpTmpoQWgzZGFxelRISXVqc1NYNU1n?=
 =?utf-8?B?TUQ0UGlJNzBKRWRHMWZuN2RkY3lsQmV1MjV0am91cEhpQ0k0ZlRvdXc3R210?=
 =?utf-8?B?OVVNcUFjdDNsd3FUeFB0T0p1V29ELy9IOUVhWXpuVmVySENyOCtjeEVVN01s?=
 =?utf-8?B?a3ZhMnZWRTV0SXo2ZTNnUGo4RkFLYlFJcVBIbFRrNHBzbzdDWnk4TDJZSnkr?=
 =?utf-8?B?THVmR09GeU9FaHc5cmhYZ2tRWm50Vm1GblJCS050eUF3Q3UvRVlaTk43RWpX?=
 =?utf-8?B?RWEzQzFCYTdOTGJoVjZKejQ1aWh1UXMzaHlKbEo2dkFzTG5OSVhPYU04ZlNp?=
 =?utf-8?B?aUY1Y0tydVdpR3FBNDh0dnNaVHdDNEJQN3NIc2cxdnhOSTR0aHBMVXFDaER5?=
 =?utf-8?B?RTd4RWxwOWNoa05iRS9JMVpmeTJ1eVhWUGg1NDhwWFJZVnluN0lhSTlrM2NP?=
 =?utf-8?B?eUxRNzZOaDJMR0dQYlpFV3BWVjZjdWtud2NsL3lySjZRS0t5NHlEa3QxR0kw?=
 =?utf-8?B?cURCNysrbUREd3hwQThzRzhoYVgzSEJOUnZmQ3JZZU1xRXVvODBqVDlCNjIv?=
 =?utf-8?B?alBzdTUvSDM2dElVOFM3ektGT0htbzh5N0JQajdwRWl1ZDdCYVRiWDA3Unph?=
 =?utf-8?B?UkZVK3BTK3VqTDIzOExTVlhKMWxYc1AyM2I4UHVrYTEvMjhxa0RRamI2MWRS?=
 =?utf-8?B?M3F2Q1ExL29KSjF4alpud2J6anB2WlRMdlJjMnNtT2JuZVpmSWdzdzZRQWFS?=
 =?utf-8?B?cFdEbWNTVmhyZ0daUThqQ28xY3ZIeWxIandQeFludDVEWEszNmg1VG1LdGJH?=
 =?utf-8?B?VmV1R09BUnZJRFI0YzVJcGsxNVdPTzA1c3dsZnd0cTQ2Tk0zZEk5OEVDcFE4?=
 =?utf-8?B?WFNGWEJ3blh0bEE3TVFkN2dIV3p1a1FBM0RLcFFFaHY4dGk1aDdqZnJmMDRu?=
 =?utf-8?B?dXlZRjhKWTlIK2hreVlsdVl0VUZ6d3dGR3RaY1l3eDBpTjVUSWNTSUlGMGJx?=
 =?utf-8?B?YW0wTWFpVGQ5TnBYRzEraEpIbnZaYTU5d0RyUnl6OWdKalQyc2MxV0o1eUFZ?=
 =?utf-8?B?RUF2MkZyZ2FTeDM0cUEyay9EQmtHMEpnaS9sSVVMMjY5cXZXTVAvcy9kbzBl?=
 =?utf-8?B?bytsTzRTNERBRVViMmRCSlZhWTRqZUg5RXBDT0lYRTNXQmNFSFRKZEhpQWdR?=
 =?utf-8?B?SERWNm91YzFoRWRtbUdYL2hFaW9YUjJBV0dWOUIxeWlpcHRqYk4yU1ZhN3lN?=
 =?utf-8?B?MjVBM0pyblRoTWQ4THdqWHBuZ2FqY3YwWTJHVE9Qc1FvR3JtRnlXTWovMVd5?=
 =?utf-8?B?aWdmVEcvM09QRU5NZ2NWMVIvK2ZnN2lndVp2ZGM1MDlHQkpkZEQrdlczS05n?=
 =?utf-8?B?NUNvMWFaWVpBVXh6ak1tWm9vaVZhNVg1Uk1rWEFlMWV0S1hBbzdvbnlLUy9E?=
 =?utf-8?B?VUV4dU1rc0hTVHRuUjZRRUY4SFJkMGhZUTBtZXlXZ3JOSjdYc3JFbW5rRCtn?=
 =?utf-8?B?RjFpSi9iUk84OElXYml5bEVwU3BCNStvd0JKZWpVeE04K3FoNzNWd2IxQm56?=
 =?utf-8?B?Yis1YUMxVVU3a3FDN0pNd2M3SzdGYUlKblNBRHBaUnE1RFEvWFlZRnhVdjBV?=
 =?utf-8?B?OWU3RXVOQUdXZ3BnMW16cGdhdmY2Wk5aNjM4NWFMSkp2UjZhVmRYUStiRVpY?=
 =?utf-8?B?eW92cWJFeHZySkN5NDZGOUNudjNiNUxGZFpEbEdadkNCTGpvdmhZcUR4L0kr?=
 =?utf-8?B?b3E5ZWt4MkRhSHA4NStxaHJNM0FJcHl2RHJmZlErRnFuRFVUY3A0bVNRdDFE?=
 =?utf-8?B?dEhPVU02R0FpRmlGV3pFQ1F6UzRadS8xUjVsRkdhZEQxUjlVS3BQZjNmZ1da?=
 =?utf-8?B?UWJKREFnSDc5OW1Zckw0N2cwblF2cGhxNys5T2s2SFpkRlI0eHVKQlUzMTBJ?=
 =?utf-8?B?VXdiS2JweFk0MXBQY2Q3elI4bmRUS3VIYVVUWThiaC9BZEVOQmM3eTdBZ3FO?=
 =?utf-8?Q?FFKNOpacMCdjFYsesh9eFAYMs?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f0a2f5-b170-4e98-7589-08da5b284ffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 06:09:52.4576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6KinqvA6sPMRDFkg2n7lOGuMyfmKcyA1y0/xhyRJ4S1y/qfHVyvbyoW+AQdE8hqEGPQITZ7YPsBJCqHLhQtAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4626
X-OriginatorOrg: intel.com
Cc: Dimitri Sivanich <sivanich@hpe.com>, "Anderson,
 Russ" <russ.anderson@hpe.com>, Mike Travis <mike.travis@hpe.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> From: Baolu Lu <baolu.lu@linux.intel.com>
> Sent: Friday, July 1, 2022 11:13 AM
> 
> On 6/30/22 4:29 PM, Tian, Kevin wrote:
> >> From: Lu Baolu <baolu.lu@linux.intel.com>
> >> Sent: Saturday, June 25, 2022 8:52 PM
> >>
> >> In the IOMMU hot-add path, there's a need to check whether an IOMMU
> >> has been probed. Instead of checking the IOMMU pointer in the global
> >> list, it's better to allocate a flag bit in iommu->flags for this
> >> purpose.
> >
> > Sorry I didn't get the point of original check. This is the hotplug path
> > hence the caller of this function should already figure out it's a new
> > iommu before reaching this point?
> >
> 
> Either did I. It was added by below commit without any comments about
> this check.
> 
> commit ffebeb46dd34736c90ffbca1ccb0bef8f4827c44
> Author: Jiang Liu <jiang.liu@linux.intel.com>
> Date:   Sun Nov 9 22:48:02 2014 +0800
> 
>      iommu/vt-d: Enhance intel-iommu driver to support DMAR unit hotplug
> 
>      Implement required callback functions for intel-iommu driver
>      to support DMAR unit hotplug.
> 
>      Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>      Reviewed-by: Yijing Wang <wangyijing@huawei.com>
>      Signed-off-by: Joerg Roedel <jroedel@suse.de>
> 
> I went through the whole hot-add process and found this check seemed to
> be duplicate.
> 
> Hot-add process starts from dmar_device_hotplug(), it uses a rwlock to
> synchronize the hot-add paths.
> 
> 2386         down_write(&dmar_global_lock);
> 2387         if (insert)
> 2388                 ret = dmar_hotplug_insert(tmp);
> 2389         else
> 2390                 ret = dmar_hotplug_remove(tmp);
> 2391         up_write(&dmar_global_lock);
> 
> dmar_device_hotplug()
> ->dmar_hotplug_insert()
> -->dmar_parse_one_drhd()   /* the added intel_iommu is allocated here*/
> -->dmar_hp_add_drhd()	   /* the intel_iommu is about to bring up */
> --->intel_iommu_add()
> 
> The duplicate check here:
> 
>          if (g_iommus[iommu->seq_id])
>                  return 0;
> 
> All the iommu units are allocated and then initialized in the same
> synchronized path. There is no need to check a duplicate initialization.
> 
> I would like to remove this check if no objection.
> 

This matches my impression.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
