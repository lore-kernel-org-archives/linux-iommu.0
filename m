Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247C5C433EF
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 23:32:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFB6A82FA2;
	Tue, 12 Apr 2022 23:32:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OSN7dZug7GdZ; Tue, 12 Apr 2022 23:32:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7312482E9C;
	Tue, 12 Apr 2022 23:32:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42870C002F;
	Tue, 12 Apr 2022 23:32:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4406C002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 23:32:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8DD4E60E8B
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 23:32:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ULtT2-jrxRHA for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 23:32:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 85EDE60E83
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 23:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649806336; x=1681342336;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=maHAIuNa2hxus6GAsaYzYDgj1HxvQjaza6a6BCRrmXU=;
 b=Q65My6JgjWNYWD7FMLGvhGdQSEPKf8ilgiByNbq/J8bmmtciyBxAGLoc
 2mnJTGX8bGeknVUKVJjwpdqxm+8km5Y7u0zPTTJ1cIUz/QLSytOte6Yqq
 nx4RQ4veDZn1ZthJja8H+AXjADZvEhC7Xzy9qFqVE0uTyogtjJjGinEDR
 A2eesJ7nun/3yyMqmL9pQhbBbkuf47PpCQe9l+6znNplvyHYNgp1YTYXK
 OMb01nzlqYHg8iTFynXTJ0B/xI3B27FbuKlmsPqgo0AQaPyY6hVEicCXA
 ChEJNdxhND96ZIuA2KRS8iEmRBkP8wuMVhpRmbhQ/6GZKLw0B3I146y3u Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="261378620"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; d="scan'208";a="261378620"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 16:32:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; d="scan'208";a="660706494"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga004.jf.intel.com with ESMTP; 12 Apr 2022 16:32:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 12 Apr 2022 16:32:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 12 Apr 2022 16:32:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 12 Apr 2022 16:32:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxRF+cFfiUWOjp54w+rZ8c4edtl0azOU6Ls8VPpwqc15apwp9Fdw3ZzJBOtozskQklUXBqreouecIErjoAZETMvStkF6n3fwFN/U5BTx/o7VvzqivPcqgMUeZAwrEjeO5L9IxuS7bGzLn0alrNBpa/+HhBuqIAoppq0+ljYc/6Wok05lucU1f25w+60ez8baqNBo95yv12/q/p4nq0jPz4qADdUf68APS/H5hcqVXctqdJSDRIF9N0uEgTWOU1+S+ZegiyBjf7Yx3ij/+L8Ol+z5FPbKSCpE/lq6NLrA2m0PmjZyoT+xVBpu6CemlW98CqGIrUQc7fke2X4HEnpuIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maHAIuNa2hxus6GAsaYzYDgj1HxvQjaza6a6BCRrmXU=;
 b=VAclUnO4dkcDDpcfkvBmO/y/bS53YEM8Lv2oQU7QD80TdKWncoMVif2HzQ36gdZYK9moLpX/PYLa4iBnS10GpTyEIwrZVAYevHOD8hLdVV6y4hdhjDR2tIXr0aO5/TJeA2cA/2Pmg7E5QTnpVxaxyhUffiyK1FUnKUVYcrq2FecyL8hLpQ0qrfnf/G7lkSZAUKz5n5/nxU70eA5q1xvZm0ufRScbMm0X88zKBqSShfk7FAzwHH6uCPqDyDw5dFKwhIJ82zFG+HoBH4aWTVCI+TfGPf2ZfpLC8okEYniz91Nzimx8SaXnQMD2HwgzmpLu5uNJyyO1uZ4wCtcHDT7fAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5482.namprd11.prod.outlook.com (2603:10b6:408:103::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 23:32:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%8]) with mapi id 15.20.5164.018; Tue, 12 Apr 2022
 23:32:13 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Jason
 Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>, "Robin Murphy"
 <robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: RE: [PATCH RFC v3 02/12] iommu: Add a flag to indicate immutable
 singleton group
Thread-Topic: [PATCH RFC v3 02/12] iommu: Add a flag to indicate immutable
 singleton group
Thread-Index: AQHYTMWQdMRj1LtW7ESP7xJUKRpqwqzrmnCQgAAi0gCAACVF0IAAXxIAgACvRyA=
Date: Tue, 12 Apr 2022 23:32:12 +0000
Message-ID: <BN9PR11MB52762F5C339737F6E75755CB8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
 <20220410102443.294128-3-baolu.lu@linux.intel.com>
 <BN9PR11MB527679E5CE0516B2786F57518CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7c70a136-6871-b48c-8e46-852bb1b62958@linux.intel.com>
 <BN9PR11MB5276246A53447854DDA8920D8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <6e9bac88-e544-aebe-81ec-d1171239fec3@linux.intel.com>
In-Reply-To: <6e9bac88-e544-aebe-81ec-d1171239fec3@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16db2bbc-b431-408a-90c5-08da1cdcabff
x-ms-traffictypediagnostic: BN9PR11MB5482:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN9PR11MB54824FAD05D35EA7919EAEC08CED9@BN9PR11MB5482.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WZcOLpafCXvEjXSEqZNuaTrB6sjp1VfsZa1q9C5EdOBV+nz6s2GWZV6ncQ7qS5lkdeBEu7XFNioXQG9lfdFBDAqfZ1uNUXn1uUl1A2Zjb/Zr8YVQciaeScXod/SW0lyBsvX1WxhOWqQndjL5d0uPIO31JU0MjwC1Fkhn8hgeN4YIIaanSCag3eM6Hr9IUsWQwk5vXx0XuGVNuWXtGR+vOf1kbsJ1TFRPVcXwatflWJJsYM7oRxi9OT2C+o+in/OkEjfBMS/ZO3N/MEq4Tv8Iy3t8Iejl8uxzxJqYciHhQR3UFH7ZL7tIvab6MYNeIzYL8gCY5hksnhNS2GsjNiLoaAIJOwPdufwECEgtinanqBWIJMJ4EN2IAVukrBk8nHBsPvCiBQoTCIa3apldEBcofHEHptmGbLJ3ufwTlRbRuIBgpb/FcANYdje8K2jMj7ifa3eN/fGHBMxo1HHpa/b3guyJekHuh4o3pUl1zZWO0DuJpg8MzvT6k+OdYjv6+5/td6Tpfl/RXBK2P/TKaGL98zU9qEk39yjQdiZ5c353mZSJz13hVuo8uMPzpKmRVa84/vcvzHXR6JcoU+DwnYFW/Hp05ghVuY8XjN+zg4zBNyYky9SYe7JEGYYcXLdVdLLADkvpCxASfawogGZnPXnU7eyo0jfNrkM+XFK6zLCal7XLavAW7PXTcr+dgx7AIE2DFt9XxSLGccTsy4+awFzshA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(4326008)(55016003)(64756008)(8676002)(66476007)(66446008)(76116006)(66946007)(66556008)(33656002)(186003)(9686003)(53546011)(7696005)(8936002)(508600001)(2906002)(122000001)(82960400001)(86362001)(5660300002)(110136005)(6506007)(316002)(38100700002)(38070700005)(26005)(7416002)(54906003)(52536014)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U29HOGY0NkRFL0pLY1o5YmxmdlhLQ0pNSW4vdjN3eDg5Tmthdm9GMjRudVFY?=
 =?utf-8?B?dzRJZUJ0NXhZZERjTGpVQW5rTWxyWFRsdklGSkRkK21lY1pyREJIK2ZnejJ2?=
 =?utf-8?B?TWUzUWpwR1dRUjVKU2Njd3JuYm1zZlZRaXpiZk53VHNBVUxwNDR0dzN2ODNY?=
 =?utf-8?B?S2tUc1E0ckYvemFneWEzcEI1YTQ5UWMxblY0TElqQStQUzlhSzlhWktyYjJp?=
 =?utf-8?B?UDM4V3ZsRklleE9ROVNUSTNFOERmS3U1L0JkdGkxODZVQXFRT0s5VWRwM2Fw?=
 =?utf-8?B?aWR0UURTN1c5MTJvRFkzcDB2RmdPMlNTVU1CM1Z3NnVKeE5SK2tnRmxRS3R4?=
 =?utf-8?B?VUw0bEZkcE40cXgvOHBiclp1dStXVVVWS1lON0dFdmlJM0VieDNST1owTmxV?=
 =?utf-8?B?ZWZUbmt5b3QxNzRHVkIrTFhwbkl3bHA0VFplTDROT2VneGRFeDFUMjVhaE5U?=
 =?utf-8?B?d0JHd09lMXlhenJGYTdzSHlVOFpzQ2lSUWQ0Ujh6MTRtSDJYOThwRXlsTUZp?=
 =?utf-8?B?N0NKbU9xMStXWkw4MXRMZG1FNVlkZTBBQnF0UC9Zd1VCTkxaNmkrQTV3U0tR?=
 =?utf-8?B?Mi9tRm1QRFBXWk9qaUF5a2FrelhvZ3RNczQwLzZGZXdJM01OMncrWlJ2ZDF5?=
 =?utf-8?B?RlcvdElTOVFNdERpb3RUMjBSUVNSZmdoYkJLbDMxQW9LbHFtdy85UGJZVVJB?=
 =?utf-8?B?NVg4UGVweUdld3ZubGFEUnZpY3RLRTFDaUhnTU12dVV2YktGNEdOWlU1M2JM?=
 =?utf-8?B?Sjl3THNtV3llam1mS2J2eWdGWEYrakl6MFB0UzNXSkxrNnJhZHl3N05wOE96?=
 =?utf-8?B?MVdmeXRyaUZzZVZXZmQ5L1FMSndYd1RVY3E1VFllZU05VDcvSEdkR2xjenlJ?=
 =?utf-8?B?TlVPVE56UnJHOXZPT0FVdDQ1aW9BaEowZCsrY2huT1VEK1lRSWRvSVcvZWND?=
 =?utf-8?B?cUZyWmlXYlhVdmp4WVhieTBDOXRGWlQyWUhqa3RNcWlTR3pTUVVUK3E0SUdP?=
 =?utf-8?B?Qlh5Q1ZQN1V3amtGanFwcjVsalJPWWNBNEVJdGRBclNCK01sRzJ5TlpQOXNX?=
 =?utf-8?B?dE9CSGZNT0RpdzEzb2tWaUdkd0FDa09MVlZIYyttWlE1T05iRGQ2UzNIOWhL?=
 =?utf-8?B?cUhWUUFJc3BjV1ZYRElhT01HSTd5WGZGaFZaTTRlVlMxdk5teXlhdTV3VVlX?=
 =?utf-8?B?aE5ld2VRT09BcHl5bml3SEZ4KzE5ZjBodEd6N3ZTTWtEOUIxZ0ZweS9Ca0FB?=
 =?utf-8?B?Y1FscXdGdjRDMTYwbTlyYlF4RlRIdHNjd3FhZ0FSRHBzNFdYSkNVcG9jK1hX?=
 =?utf-8?B?eVhNQ2wvcFd2MTZuTUptVTNDaGpKRU9zNG13TStUdUwzRlFWZFNtYlE2OXJP?=
 =?utf-8?B?dEdKNko1ZGh2MkRrZW1XSmtTdU5FU1ZGWEo2QVgrTU5SZ1FWS3RoK0wvVE1L?=
 =?utf-8?B?ell5U21OQ0FMbHBsRHFFWVVoQmc2R2t6R1J1ay93UHowaEZFMDQ1UE5LWGJL?=
 =?utf-8?B?M1YzWU9jVFVjSmpMaHhUNlBPb0NGRTBVVFZVK0Z2WWRLRGxSRXcrd09sLzR3?=
 =?utf-8?B?TkxPRHUva2wwcXdVK1V4ZG1qVWVGazFycXBDekdWaVZFNkh4YzRNZ0N5Nkcz?=
 =?utf-8?B?QWcvRnFoK0h0bVZDemhOQkJrRXB0RXJwcWVkamhKWDYyMFdEeUlHdkg0Qndj?=
 =?utf-8?B?aWRxV0g1K3BZbzJBNmVZQnZqMHJrald1c1E1NUZTc3djK3RFMnlCNUdRT24y?=
 =?utf-8?B?andyYStLTXZKSlB1b1h6NEhFUVdaWEczMG4vTytLcjZER3J0VVRwM2xLdkE1?=
 =?utf-8?B?NVRqU0doeE5nQ0o0cDQrOXhtU05pYkxHNFptWEx1WFlUVzA5LzAzYmtBOWRF?=
 =?utf-8?B?RUJ2ZGEyMTJJU2lLTFcxcTQ4bG5aSWJha2ROeE5TMW5TSVp5ampYOTdRbjBF?=
 =?utf-8?B?TjRMRkRVdThBY1JUdVM5akxoa1pTdUpCMWp4NlV4SHpydjZKU2pNb1JOcnBX?=
 =?utf-8?B?TUJLclIvemRZaUZuK2doMm43dlZxQldFK25jcm94RVZ4UjdNZTk3MVFlY0I5?=
 =?utf-8?B?WnlJdGZOMXcybm9pMHp3cVFDZ2dTYTVYZHF1aWVYTXF6UjduK2hLbjZOQVlM?=
 =?utf-8?B?ak9na0JVelQxUVlwZFRsc2srTU1IUWp1VXhDT3pSZmJqeUpuemdQT3l4Nmgw?=
 =?utf-8?B?TFc2Vm5BTTlNY0lMcWwzYkpka0pjQWFiQ0tmVHF2MXZBZGFOMmJNRitRV2Jy?=
 =?utf-8?B?QnpVSlJHYlBMcTBGdGc1UWplU2RtOFUvTXdnaG04NmhuV3c2a2ppeVFRd0dE?=
 =?utf-8?B?SlhieWs1VXNVazkvTWUxdkxxRVYvTHhyMjh5YW45QWdTODhoNi9LUT09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16db2bbc-b431-408a-90c5-08da1cdcabff
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 23:32:12.9132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZ4ZTvxnGnd6yVTf0KaC4Wbk6NzeSSkhOMqYnAMPcGfVJq6U8VHOskXfXb8doLckuu6NUNJi4u+zNRDNQ9/ujA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5482
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, April 12, 2022 9:03 PM
> 
> On 2022/4/12 15:37, Tian, Kevin wrote:
> >> From: Lu Baolu <baolu.lu@linux.intel.com>
> >> Sent: Tuesday, April 12, 2022 1:09 PM
> >> On 2022/4/12 11:15, Tian, Kevin wrote:
> >>>> From: Lu Baolu <baolu.lu@linux.intel.com>
> >>>> Sent: Sunday, April 10, 2022 6:25 PM
> >>>
> >>>>
> >>>> This adds a flag in the iommu_group struct to indicate an immutable
> >>>> singleton group, and uses standard PCI bus topology, isolation features,
> >>>> and DMA alias quirks to set the flag. If the device came from DT,
> assume
> >>>> it is static and then the singleton attribute can know from the device
> >>>> count in the group.
> >>>
> >>> where does the assumption come from?
> >>
> >> Hotplug is the only factor that can dynamically affect the
> >> characteristics of IOMMU group singleton as far as I can see. If a
> >> device node was created from the DT, it could be treated as static,
> >> hence we can judge the singleton in iommu probe phase during boot.
> >
> > I didn't get this. Let's look at your code in iommu_group_add_device():
> >
> >   +	else if (is_of_node(dev_fwnode(dev)))
> >   +		group->immutable_singleton =
> >   +				(iommu_group_device_count(group) == 1);
> >
> > Even if there is a multi-devices group above logic will set the flag when
> > the first device in the group is added since at that time there is only
> > one device in the group. We need other concrete information  to tell
> > it similar to how you walk PCI hierarchy to find out the fact...
> 
> This is a small trick to make things simpler. Once more devices are
> added to the group, the flag will be flipped. All iommu_group's should
> be settled down before any drivers start to consume this flag.
> 

As an immutable flag it cannot be flipped. What about SVA has been
enabled on the 1st device before the 2nd one is added to the group?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
