Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B34C433EF
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 02:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 15B02405F2;
	Tue, 12 Apr 2022 02:51:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p3j2pPKbFDBZ; Tue, 12 Apr 2022 02:51:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EB03040122;
	Tue, 12 Apr 2022 02:51:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4808C0082;
	Tue, 12 Apr 2022 02:51:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68F3DC002F
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 02:51:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4690B60EE0
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 02:51:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8_5y1KDSN34o for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:51:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B714960EDA
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 02:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649731885; x=1681267885;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JTleEjuPned0N9yF8Af6YgWaFi9vecUC0Ri2sW4K4zk=;
 b=b+p/2hmXTsJsWq7geui/uQKudNwiSGIwE76xlml2AaM8Ykza8P3sRWP8
 PvA7CdKako1vGe5/P3UGkvgQSB8m3WreNdJgQZhabcVn3t3UvNmFzhPWx
 LOij9q8ZSklFnniADQuakgbOg4c2QMahNlNsIjKL7XxeZjfTmLq0oR9mW
 EmjVhSs++MK6CNPETAsXQEWgY1K+hYdtInDfJSWiaSApWw+hozIZUS7n2
 Z36/LVdYtlQsPmSMFVc+2U2JMNFbCB4XmtrVQIJ3cKi8rPkAPKPkrJ84N
 OAbPoTWGWoJwaVfEhsGIFzNHue+KCaTkdVuj6VjzBDDNd3Dc9z7QR2e+o Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="259858895"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; d="scan'208";a="259858895"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2022 19:51:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; d="scan'208";a="551497799"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga007.jf.intel.com with ESMTP; 11 Apr 2022 19:51:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Apr 2022 19:51:24 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Apr 2022 19:51:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 11 Apr 2022 19:51:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 11 Apr 2022 19:51:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNNLVvYlq4mNcn0KKkXGHnSyFDDWgzDhHhyew7ki/J1hRi6w3GWeuN8QvZaDF74k5syT9nyXRbcmgJ/Xk9+qZAf8vHxYy95PjBB1U4Gn6Yvh6GDo7XtqcA43UsJFPWkIU5nvfpzn90ARxxCT6mCCZ8aW1WnTaA2Y9RmEmsk8sqUByVpZm1gpGPj99SbIk3A8e5oxfIWcUaclK4d9fKDWmzpfjskLfM5Wx/Igu1U/HETmt+NDmnV2761Ut7R4kSue9rhBN6HUdH+qfbIx+macREdzdZFqTls6emSP8Z4sGfyHlsg6n9S0ng87BLO/Obuuru9SrxP8atxIYjRRgNyYYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTleEjuPned0N9yF8Af6YgWaFi9vecUC0Ri2sW4K4zk=;
 b=O5OTo8UbEQYxE1QeiRDijavMihUrFb2E4h+DI7sropOdFruZ6hAKPCvTrkzguxGGRfwGkKRs7qYM4BGFPCnx3p1t6Hg7ilmRQNB2oxm56thPm4pBz0cZ4tGothqOiisvUgr1rNv/ypnIPD/YmLU3mUHDFVtX6pYwsOb498hHeLxQy+W9zzFAZ8fk0uLviYaOlz+5j4tEgRDh5PfhKZ1gs+JCVDcb9zL7Zs9WJuRLBYp8mr7I6iLyLzdsEynmuI5ZZF77dTgUB8aCLpGiO5wokrTbu8Tl4Pe4IeFK38avFfJbBy4JMjZFlrZ5lDbL+KnKVJpK06beWo41m9B61X8hVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4537.namprd11.prod.outlook.com (2603:10b6:303:5d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 02:51:22 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%9]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 02:51:22 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v2 0/4] Make the iommu driver no-snoop block feature
 consistent
Thread-Topic: [PATCH v2 0/4] Make the iommu driver no-snoop block feature
 consistent
Thread-Index: AQHYSpOFxZ/QKUg0ZEGhoQEsmfFbSqzkrbGAgAALHwCAAAU0gIAAEooAgAAFOICAARqogIAADqUAgAAGxICAAEWjgIAFTylw
Date: Tue, 12 Apr 2022 02:51:22 +0000
Message-ID: <BN9PR11MB52765C5264BEDC889EAFE1708CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <f5acf507-b4ef-b393-159c-05ca04feb43d@arm.com>
 <20220407174326.GR2120790@nvidia.com>
 <77482321-2e39-fc7c-09b6-e929a851a80f@arm.com>
 <20220407190824.GS2120790@nvidia.com>
 <4cc084a5-7d25-8e81-bdc1-1501c3346a0c@arm.com>
 <20220408121845.GT2120790@nvidia.com>
 <4f93d16d-9606-bd1c-a82b-e4b00ae2364f@arm.com>
 <20220408133523.GX2120790@nvidia.com>
 <a8371724-2864-a316-439d-5aa7a8bb5739@arm.com>
In-Reply-To: <a8371724-2864-a316-439d-5aa7a8bb5739@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d280c7b-3279-4d0a-8b65-08da1c2f53f0
x-ms-traffictypediagnostic: MW3PR11MB4537:EE_
x-microsoft-antispam-prvs: <MW3PR11MB4537E21C269A19D1EA17E7BE8CED9@MW3PR11MB4537.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gafj/Ckdi2ZvpIwBnD7DD4CYMAkdufaS8EXY67NXBem7hGQPM8TCSgX0dZgAAtYTrcGaOWX2TQNBzUDBWXgYSXsFVKAoGEZTfHFZCJG5warcZ1hm71BE/DoNfg175mmqH94437/TYHJJdQl4tUqEnAo2XUwhMucTWbMgYN2hweI4PpQ68VXhxmzeMIKbs3cXd/cWE2hUrIAGH3VISZtjDgJQ56IP62HnarcRTrrwTEqAUPCbtTnwb3uO54vpeHQYtL0plZamFYOLWVNhUqYrDC1b1T0EjQ7+u322YQq9zpFYXpowkpa1W6eGcDWj0ZWVnzIRYvGbfFS16uAao2YibypnIcqQcUil6jqgVq+vWHo8O6c7dIMP3G62JjC+Hh87LSBm15uz5qfGMw32JyJPzMxvtZM2TiFC7p9D03IO3G1Zf4q3qwUowLGwJkTBedPdRWMF392vjGjhu2s6E7uAKwtVLf6K8LIwMjtE29FYcBfwtnr0S/ztZ+pTsNZjWTb8HIOEH61QSjadD12Fnt2iOcBAll4GPSZsLH6Ls+bSNGS0zFbqD79HO+BKwhEDjO4w9E/ucs/7m8NW9d0fIQVJXuHBVm7qF6AUnEKxRDyPQGfkqL3DQJmo90ikxbyg+gsuxfgcxn5ZrKjvmc+WMjXzH/QjBX24I7Giw5tjIu6l4tH/sF7AkgGJAonpFe+iwkP5xl3IeQ8Ujk9+0RNjuzqkmA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(9686003)(52536014)(38100700002)(38070700005)(8676002)(66556008)(66446008)(64756008)(66946007)(4326008)(66476007)(122000001)(8936002)(7696005)(6506007)(5660300002)(76116006)(7416002)(82960400001)(86362001)(4744005)(54906003)(55016003)(110136005)(316002)(186003)(26005)(33656002)(2906002)(71200400001)(508600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q252N2xCT0xlRXpMODdDazJDSEwyL1BCZlJYOHBaY2JkMTFOY0c4dU5lckRq?=
 =?utf-8?B?Z1ZiejhFUHhOdEJYY3pzVHkxNDNyQXBwT2t3T0gvL0wxWElxY2VXbTA5U01P?=
 =?utf-8?B?ZTQ1L3F1cEJMdndLQ2pVQm1Da25iemxycllFdURaZWl3R0lidTNhV2FaeXlO?=
 =?utf-8?B?OGFwOVA0WkhicG9wVkY2VzYyWDBYMjJERFliTk03WTRuZnJwaUFzVWNRQXZl?=
 =?utf-8?B?K2F5aHlCWHgvNjZKa252RExzTmM0dHZkcXpTaUVCT1dpbWh1L3VxajRVSVVD?=
 =?utf-8?B?MGIrMUoyV1M0VEdYMkdVVWtXS2c3WG1kVlV0QjJaVVp4MG0wS0VlNW5PclFl?=
 =?utf-8?B?ZWNtMWF1THF2MnMxVEg3SWRMWlZhRUJMNlN2Mk9YRnFLK2NuaHBpN3dmUjR4?=
 =?utf-8?B?a1VZWVJSenBZUEd2bTkxdGFJOGQyY0xZcGFQd1F1bXNpcVF1NXhzMnhDdzhT?=
 =?utf-8?B?cUtuMkM1cnREbUFDa0lMM1V1K01OYXlOU2x5SWJvbnNJMFZWcWF0MjFFZGNI?=
 =?utf-8?B?bnlXWHFHSGVKT1FjaWpGZjlMQWFCNGpjQm1qUmlONHZBbzJPRk9abzVWK3Nu?=
 =?utf-8?B?MWk1cm0vWkduK0k4dE9oVFNFd0YraVRFUWp2WlZjSVdPZjdiTzJSa0VCN1Rv?=
 =?utf-8?B?MmRuOHJhUFFobWVXZVFQTDNyRHFrdHBhUzgzdTZpMG04TStFSSt0dVNYOWRq?=
 =?utf-8?B?emVZQUJyc1BwZ29TK2JISUlRZkQvTTZ4SStsUWtHWHRHTWtacERLdlhrdE5T?=
 =?utf-8?B?enNGdGpHTHlTYkc3ZG1OajRueUxRcmRPVlNhZktiRDlUZXowaEt5SExkV005?=
 =?utf-8?B?YkljcHBuNTVkU0JScDFQMUpVZHFwZ1p5Nis5TzNPdDV6Y2U4L0piQmtKNjc1?=
 =?utf-8?B?RUh3YzJydjVMTmxPa0RQaGFWUHZUWGdHV2pKOXhVQzZ4MG1FODBRMkNrYjdB?=
 =?utf-8?B?NmllM0VRSmVGN2ZkbzFEQXJHVnBRQTJJb1NpYjI0T3Y1OXBLakRiWmhMUmxD?=
 =?utf-8?B?TlZYZTdjU0krbTZHUXBxUFYzd0tHQ0hGZjZkUU91OGFXbFBSakYxR25Manli?=
 =?utf-8?B?cjVNeGR3ZXFkWlZQamhKcllZc2Q3S3NYOG9TaTErQmtEN3plRkVObHVxczZs?=
 =?utf-8?B?bkMyVGVpRVNWT1hKU3M3ZmpQWkVQV01wZC9va0VUcDJUdXVUM1I2bHY4RjJD?=
 =?utf-8?B?VE11NFdhczRPQ0N0dUVPYm5BMmxvelRHc2ZEd2lGOWUxMldXYkJ1SVZSUkx0?=
 =?utf-8?B?TmdIcUtsVGRSY1ZyMElpK2ZxUHIxZDRxMlI2Vms2MTdHQ0hQc2Y2dFQyVTZV?=
 =?utf-8?B?SlhxcE4wSUFhWnFyU1E0T2NPanoxWDJLZjlQY20zZkgvWklrZnJKeHptb2Jm?=
 =?utf-8?B?Y3dCanBKalZvazBlZ0pReFRBRFlrVUVUVWF6OTFFVXdZRVBQR0w4U3pGcFVa?=
 =?utf-8?B?WDU0SzBZc3hsRU0wKytOeENRWlNBcjBhS3BJYWFaVFY1eUlOMFJkWllOQUpC?=
 =?utf-8?B?aTZwbmY5aHJ6NnJSZXFMYUFIYWE0Z2lnbWJCMVBIbmVmbVpKbGtSZkQ4YmhR?=
 =?utf-8?B?ejBZWEg4eXJoclFwd3JGYXh5ek1KY1kvOGdJb0t4WUtrS1ljV20rbnI0b2VU?=
 =?utf-8?B?cFZJU05ra1FxU3FxYmFQSGhzZFhuL0NMenM4RTlxNlVsS01tNjB4VFhEYXdH?=
 =?utf-8?B?WUNISWhkalM5eFZNQllmdW5mVDlCZjhpc1NNWDd2dW1udGJXbEFuVEZlVFh6?=
 =?utf-8?B?K1FkWUFCK2pORE43TW9XeXAzOE5hSnQrZEprbkxMeS9QWVNzOVFqdXdIN2x3?=
 =?utf-8?B?Z2kzUEhqOS85VFRtZzR6ZzlXUlRKMEU3bzUzT05ZR0d0MjJxLzhtNy94VEhT?=
 =?utf-8?B?UGZQYWloMGw3czhPbk41YXRXS1Q4d0t2aUNLeUVkVEMwUHpoVEQyTmhaVlBs?=
 =?utf-8?B?aVNJU213VUR1cm5DM2ZKMEJKcUM2QTIxYmxXSlFORGFtSlhaWVBNdFRYdzYr?=
 =?utf-8?B?U3psQmQrZExFcGtVek9JNno1RUN6TTM3RERFbzc2YVgvdFVsUTJPRjZMeno5?=
 =?utf-8?B?czRDTi9neXRHZjVmTUR4TjlpOWJjRitxck92a3pyd2ZtTW4wY1crM1BtZmlx?=
 =?utf-8?B?NTRvS3cyLzNLWC85K0ZQWFJWdGlhVmdnYmRiUytXaG5DY0h2dGY4eWtrczYw?=
 =?utf-8?B?ZzNxTDgvNVpaYkdqK2FueUVhZU5Hd1o0dXIrUE54b0F0cnF0TDZpT3Q3T3ZY?=
 =?utf-8?B?dUdLd2Q2RXlzVVVzN0V4amVJckhydjg0VWdYRFRhdkhUVjJFV1J3RFFIWmFN?=
 =?utf-8?B?KzdqOThZSmtNQWgrMVc5S0dmYWVjanFkcDJZOGppNG92RDRndkl1Zz09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d280c7b-3279-4d0a-8b65-08da1c2f53f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 02:51:22.2566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X0QIPX0ocCi9LeIUL0jIskIILb5+iKFfi+nhtxmJfTkeN7Wdt9KyGVaWJhkNeNwLrhB5Auf+bDAPhGwdAroNFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4537
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>, David
 Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
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

> From: Robin Murphy <robin.murphy@arm.com>
> Sent: Saturday, April 9, 2022 1:45 AM
> 
> >
> > So, I suppose VFIO would want to attach/detatch on every vfio_device
> > individually and it would iterate over the group instead of doing a
> > list_first_entry() like above. This would not be hard to do in VFIO.
> 
> It feels like we've already beaten that discussion to death in other
> threads; regardless of what exact argument the iommu_attach/detach
> operations end up taking, they have to operate on the whole (explicit or
> implicit) iommu_group at once, because doing anything else would defeat
> the point of isolation groups, and be impossible for alias groups.
> 

Could you add a few words about what is 'alias group'?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
