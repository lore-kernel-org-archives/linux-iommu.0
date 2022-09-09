Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C812D65A
	for <iommu@lists.linux.dev>; Fri,  9 Sep 2022 07:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662709904; x=1694245904;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m/3e8LGy5HS9RFL0+TgTdpAFhmwBWWvPDDzHXGOb2ds=;
  b=Xc/3IVsfn+Pt+9ZCDoBq3McFPK5olYQILzuCH28+zXSYoIwemKHb1AEH
   NdmHzKshlqYH543GU8YpG5c9WUpjtKH+1j/Dbr2mzOnZbNYxHuLmYJg7O
   j+5SaAWEy6lkHK/zm8cqQw4lFZo17qXMfsxxSfzkvhxH950qVKfG69rx3
   KfaiFFuHXSKY3GwFT3lFTx6On7uj4Z9qhit3nHWjqlhVwwRTrUFpr1Wks
   VVsYD70hjRIq66oiJmszwcCSP0JXEdHVuR4qq/6/R0w368IOevZNYIUIQ
   9hnfh6bh8M4OnwE0J80Mbtp4lLHzchAmqBLe9zvImtfY4tBktA7Bfqwrv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="280446264"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="280446264"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 00:51:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="677064645"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2022 00:51:44 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 00:51:43 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 00:51:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 9 Sep 2022 00:51:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 9 Sep 2022 00:51:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lm0pNnipw4zxL1goQ3juj+dbmz2sU9QiVVBQZyzj076a+xlTcWPEm/AVPq3/UBHyc0Tx02awbAk6KER0q/z/J1hxT6tUjQ0stJvFhrJ4WC1RFNpVjnt3KIuNCycZaSMNlmjttfn55Mkg21KTlU578YkoDzTIUJ5HOhppG7p1w/Sa8LaDgTR1IwLbxvJXTXHEv/YU/OzLvWm4UyvBwUAZKReMxGtysFOkYEzaf/S0Gu4gOA4I3RZthbt8bnSu94Rea9AuqkSTOGP3dEAnQa81zY/omokgzUwzWq9z/ntfDQ4NdJKFOXIyalgeNYcNSUz8ITDVVJDBXljxit54Rknj/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/3e8LGy5HS9RFL0+TgTdpAFhmwBWWvPDDzHXGOb2ds=;
 b=KC5SWlKnAFRNc4CUhTV2z1Y60RZiZJ2rqWw1I/CzGeH/bEX9IuFyW7nukVbv6z2oOR9d5ZZZYpi27BOI9y/OivKTCOdEvFSkZL1CQD41iPQgHVWzhwn0+gFbFQZ1NaOXPC93qXJE0Co1jxd3Zh5cphNAg2G42ZxJ+IJDcuwyIITM2r2ntIJmL8g+X6zLq+I+0iCffHeNAg7o7IPPiEqdpSXCZz8O5NgPJbtOVNesc5UcYSCvJheO3+Stj2k3VeaLDscUVG6t7XO12AeCyDXfhN/iDv9mYnt4mztsKAeU1LtG7SPduvlgjHVf5TM5jiS8wNhX7CMoyZUvQz2RsoAVnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4899.namprd11.prod.outlook.com (2603:10b6:303:6e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 07:51:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%5]) with mapi id 15.20.5612.014; Fri, 9 Sep 2022
 07:51:41 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@nvidia.com>
CC: Joerg Roedel <joro@8bytes.org>, Vasant Hegde <vasant.hegde@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH v3 0/9] iommu/amd: Add Generic IO Page Table Framework
 Support for v2 Page Table
Thread-Topic: [PATCH v3 0/9] iommu/amd: Add Generic IO Page Table Framework
 Support for v2 Page Table
Thread-Index: AQHYuE2c1FFl8GVCa0GaSJG1ZeYWaa3Qx8SAgAHk54CAAWuHAIAAK5MAgAFGgoCAAAkzAIAABx0AgAADCICAAATDgIAAA0mAgAAXhQCAAKfkAIAAY6FA
Date: Fri, 9 Sep 2022 07:51:41 +0000
Message-ID: <BN9PR11MB5276F888443EBABE26A0519F8C439@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220825063939.8360-1-vasant.hegde@amd.com>
 <77d2ea43-9752-b5f3-78ef-8cdae944eee4@amd.com>
 <05f9784b-15b6-2a9b-2d9e-19e1430f74e2@arm.com> <YxintMDEmzSXJUl5@8bytes.org>
 <YxjMQpGYaHfsiuL+@nvidia.com> <YxneJ2RqaatKmoYT@8bytes.org>
 <c11bd109-65cd-39b3-6d7e-2b29208ca2ca@arm.com> <Yxnr1gBIGwdinIkr@nvidia.com>
 <YxnuYTrkC5yoHH84@8bytes.org> <c48211fe-00b1-e679-21b8-00a85bba599a@arm.com>
 <Yxn1IcWk+61ddiCn@nvidia.com> <7b30a064-754e-0528-5142-8446ab5bdc95@arm.com>
 <0d70e245-e360-ddc1-eb03-67ffbc6c1a47@linux.intel.com>
In-Reply-To: <0d70e245-e360-ddc1-eb03-67ffbc6c1a47@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB4899:EE_
x-ms-office365-filtering-correlation-id: 12632fe0-2388-459f-85c3-08da923821ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EFlx4rgSdBNpT3U32GdK8b0aOZ1w47Whgr/ARQrVZI3zTVP7c+pYLjiNLAvqknZgG3VaE1u+iiMk/pjB4gqRE0DA4OAMibXdfSTEzg+wE/tcE5GlUBfljjynK/ez6XcnylAcQnmKmO54qaz90TZnrSHtZwtIWgQeEpMA2j2tR38DNgrsSHNGXkH/sJofh34B8GvTziznRQ9m92QaRASfKgVFiZTyM2blqo4gjRzVBuKDMVHzXtv8RxXNtKAe/mFKNh/hdAwORBAg1uckugPteNSMqXzMj3+lMx/hS6jk5rUQvAjwL/ZrllK/VYAXIDLUUrjYjHyOG52xUrdCOn0vfuqaSo4qcvO8u94W6wfk7aA2i7dVb/+iADh/cYBxHCcyfhkpcXYb8/NTDRKegox4y24x3jAjR3bfYOlweWJPUZL9rlpp4Q9JR5SXK1tbleRHgP5qZU0V4/P6tRrkvTz7cQPeJ0siYt32TFuag4zIUeuD06f0u/Oau5sHRgHANaoFKBEZnuh0Sdf1pFVyGlIVR7fsaTSAVW2Bz8nAVcRoOy7V4wU6H1r3DNTFvJdkc2/oIFqditdfBgAiFVINOdj0m+o4qXI3T3bmvpunyC5Eiv5GV4wEgiQYuBV+o2sZcUqZSGnHl6Gzf8FbGEjCkLQsQVKiSweVu6X2pznuqtKza3sCEHfNgORewvbmsKJSDp1VxM/VByLX5+ZqOHbWVPC+VVTmPX7TwwmykhzHi7lbxZxbJhaearFDS3M9Wi+JXd8WltDmbseSVWRJmCBMnshnHqM/HlxecfH2TnhBpO1ntA4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(136003)(376002)(346002)(6506007)(7696005)(26005)(2906002)(53546011)(9686003)(5660300002)(122000001)(86362001)(33656002)(71200400001)(186003)(55016003)(76116006)(66446008)(8676002)(66556008)(478600001)(316002)(66946007)(64756008)(54906003)(110136005)(4326008)(66476007)(52536014)(8936002)(82960400001)(38070700005)(38100700002)(41300700001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFBjVmxjTHRZQkk3M0c0dnlxeUhkS0NjZmRwKzVSUVB4NHlwZkRRWWswWTAv?=
 =?utf-8?B?SUwxY0ZLcmFEM2Nqa3V5dStMV0hvOU84U2l4SngzOUVFYWhWT214d0N3S3F6?=
 =?utf-8?B?cFdTeHdlWlhsanYvbVBqZlkyT2VmVHJVUWFudzFZeXFHTmx0RWNIN3JmRHFQ?=
 =?utf-8?B?MFdxSGRvdERRUlFQMkxaUmVsVGxmaEVVcGxYVzFXbVhaWjVIT2FKZVRydlpD?=
 =?utf-8?B?RElHSlNIL2h1TWRwQWtEa1JZU3dMblBSb21jOWdRZmovT3B5U1h1SDA3NXFV?=
 =?utf-8?B?L09OMTk1VGhBbkgySFlKMGs0WXVMemE5aDRuSmVWbWNmakh2WG5aK1Frdk9I?=
 =?utf-8?B?V0YrNFJNVlpOVitQRkVzMUhpT1djdVp1WGFIb0xJN1lyNVJFZXBkdEZnZjd5?=
 =?utf-8?B?cVJuSXNLOUxjV1hxNzAzUzF4YnpXc2hqaDI4bkt3czFkR3NUMElSR3ZpWDNz?=
 =?utf-8?B?TlREQzROeEpzUFgxQlJjT3A1QTRGUE1Ea29jRXNnWHZqOXRUeEpYZkNQdnNI?=
 =?utf-8?B?N3VhMzE4Si90YnkwM3lVZmR5cm5QS0Q5WWhGUUNWTFQxN0FvMVVqMTFtdUhy?=
 =?utf-8?B?QXlNOC9PSjZiakNJMGwvWGh1d0xtSXRteVRTeUdWMzJaVER3di9CcTJLNTJG?=
 =?utf-8?B?TmVTZ29WbDJuYjFXbGlWL0hubmxObVVoZlkwV2VmamI2NUdyUkkzcmZGOVor?=
 =?utf-8?B?NjNBVDJCVnpWNGxndWZxK0FSS21PQlUreXF1T05pWWY3akVXWXExZG5ZalI2?=
 =?utf-8?B?TVE4VWRsRDZuSk5JejdYaGhHd2IvQmJXVnBQaFBXTk5EUW5lR3ZSZS9PWFhx?=
 =?utf-8?B?ZC9WUTlBTTYwd2JybWtZMWFZVWF4NU5DbVowcVc5ci9VU21kRENRZUpFcDFp?=
 =?utf-8?B?ZXprY0ZhdzVndVh1Z0dtMzJUWklqUjRxVDBPRS9mWVFmZ01nTHJtOTIxdmtB?=
 =?utf-8?B?OUtJV243dGZKcm9RcVUxNmtwNDdOcGdBS2pvTlRlaEVkSjI5VC9ZNnB2Vi9M?=
 =?utf-8?B?RnRFYVRDSnZRWVA3SHVnclVXTVdtcldRZFBxaHQvSTN0YitNTlpJdFlaZG42?=
 =?utf-8?B?TGJqeTlpT1pTam9aaEh4Z09TcWZ1OHgrKzRKcFdUWWR0WHl6YUVUOWxCQ3g4?=
 =?utf-8?B?TkUzZTF5UUlwbm1sdTRlTTUvb3EyUk05dGR1aTdFTjVWNHlMb0l3KzR3bjJL?=
 =?utf-8?B?L3I2d3hHVWRRYVJqWk9DZmdEb1cwZ3pQM3RLQU9OcVFmUzNOVUlwWmhVenZO?=
 =?utf-8?B?QnYxSGZiYzdmRHl4U1hLcGcyRzlsbUFMZ2FySCtaekVvd3BFT1hJZjFPYUxU?=
 =?utf-8?B?Zkk5emV0b1VCdUViU2pPZ20xR3dYRnRxTEVWN1ZMcW9MblpTK1RxN0M0Ujc3?=
 =?utf-8?B?UXJ5NUNFUlY2cUVNZ3p6dGRXWUtvdStnQjIzNlFDOUpBZ3h6VTZIZ2xUclpM?=
 =?utf-8?B?NzhjQWJ5Q1VFMGZzdkVxOUxxdFdzRU8xZ0F3SFB3b3NaR3ArNXJiY1JpVEcv?=
 =?utf-8?B?cG5PRnVkMWJ6U3dWYkcwMlFKWGlzWDNFN1ZDQzR3d05DS2xiY2hjZUg2L1Y1?=
 =?utf-8?B?RUxwc2xKRkVzSmhBRlBFSTduOFM5Nm5hUENMeXVjY29wMGVyVjdpYkgxb0k4?=
 =?utf-8?B?Z3BRVUUyeWpWTFVTNWxub0xxTU91M2s5alJyNFBlcko2VndjVnlCdm54UjVL?=
 =?utf-8?B?dzcwYk8zeDYwS2p6WkRSdmlwTTQ5QlFaRE5Ldk9vSVlSTEEvbC9kMEp5d1hJ?=
 =?utf-8?B?SnljUGhQV3MrcXFXakNRb2ZmcW4wNzdicTZ5TXM4aTErc2hqWnMrc3ZhYm9n?=
 =?utf-8?B?eHE3UWlWaEY1b2ZoOUlRRC9ya05lb1ZGRkRiRS9RWkVSWmVUaXA0Y3hhcG9k?=
 =?utf-8?B?U3I4ZjZHT01JQitOMXJaUnUwdkU2SDNHUkQzejhZY2JseFJaMHB5NDVJcDlh?=
 =?utf-8?B?QVVXZVJTZVYwV29COEU3VEdyM0pvSnhXZGIxc0p2NGNSZ0lmTTNKWHpoRkYv?=
 =?utf-8?B?ZTlMVnBERWErVEtIbGhrMlhiVkhSUnhiN2ZyejJIREhKT0xLWkk2S1U2YWZs?=
 =?utf-8?B?c1dXU3dySFd1Qm04ZGpQU3V5ZG5hcE9MemtLWjEwdTViajFsQWJBSXpmUTdZ?=
 =?utf-8?Q?qodGhWC8sE3oNUZGQqMzfl3iA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12632fe0-2388-459f-85c3-08da923821ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 07:51:41.1047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tmX1h3BYt/ib7l6kI9b7hW0vrJlGuYLAUYOHFywLB6Ara6muyracmO2x8MteSjEh4Js1unBz6FIpi4PcK9quQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4899
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIFNlcHRlbWJlciA5LCAyMDIyIDk6MjQgQU0NCj4gDQo+IE9uIDIwMjIvOS84IDIzOjIzLCBS
b2JpbiBNdXJwaHkgd3JvdGU6DQo+ID4NCj4gPj4gSSBjYW4ndCB0aGluayBvZiBhIHVzZSBjYXNl
IGZvciBuZXN0aW5nIHRoZSBQQVNJRCB1bmRlciB0aGUgUklELCBpbg0KPiA+PiBldmVyeSBzY2Vu
YXJpbyB0aGlzIHNlZW1zIHRvIGJlIHByb2JsZW1hdGljLiBHbGFkIHRvIHNlZSBpdCBpcyB1bmRv
bmUNCj4gPj4gd2l0aCB0aGUgbmV3IEhXLg0KPiA+DQo+ID4gSSBhc3N1bWUgeW91IG1lYW4geW91
IGNhbid0IHRoaW5rIG9mIGEgdXNlLWNhc2UgZm9yIGhhdmluZyB0aGUgUklEDQo+ID4gYnlwYXNz
IHN0YWdlIDEvZ3Vlc3QgdHJhbnNsYXRpb24sIHNpbmNlICJuZXN0aW5nIHRoZSBQQVNJRCB1bmRl
ciB0aGUNCj4gPiBSSUQiIGlzIGJhc2ljYWxseSBqdXN0IGhvdyBQQVNJRHMgd29yay4gQU1EIHBo
cmFzZXMgaXQgYXMgIkFuIHVwc3RyZWFtDQo+ID4gcGFja2V0IHdpdGggYSB2YWxpZCBQQVNJRCBp
biB0aGUgUEFTSUQgVExQIHByZWZpeCBjb250YWlucyBhIGNhbm9uaWNhbA0KPiA+IEdWQTsgYW4g
dXBzdHJlYW0gcGFja2V0IHdpdGhvdXQgYSB2YWxpZCBQQVNJRCBpbiB0aGUgUEFTSUQgVExQIHBy
ZWZpeCBvcg0KPiA+IHdpdGggbm8gUEFTSUQgVExQIHByZWZpeCBhbmQgYW4gdW50cmFuc2xhdGVk
IGFkZHJlc3MgY29udGFpbnMgYSBHUEEiLiBTbw0KPiA+IEdWQS0+R1BBIGlzIHBlci1QQVNJRCwg
dGhlbiBHUEEtPlBBIGlzIGZvciB0aGUgZW50aXJlIFJJRCwgd2hpY2ggaXMNCj4gPiBleGFjdGx5
IGhvdyBTTU1VIHN0YWdlIDEvMiB3b3JrIGFzIHdlbGwuIEFzIGZhciBhcyBJJ20gYXdhcmUgdGhh
dCdzDQo+ID4gc3RhbmRhcmQgZm9yIEludGVsIHRvbywgdW50aWwgU0lPViB3aGVyZSB0aGV5IGNh
biBjYXJyeSB0aGUgUEFTSUQNCj4gPiB0aHJvdWdoIHRvIHRoZSBzZWNvbmQgbGV2ZWwgYWxzby4N
Cj4gDQo+IFllcy4gVGhhdCdzIHNvbWV0aGluZyBjYWxsZWQgRUNTIG1vZGUgaW4gVlQtZCAyLngg
c3BlYy4gVGhlbiBTY2FsYWJsZQ0KPiBNb2RlIGJlZ2FuIHRvIGFwcGVhciBpbiAzLnggYW5kIHJl
cGxhY2VkIHRoZSBwcmV2aW91cyBFQ1MuIEludGVsIGhhcyBubw0KPiByZWFsIEVDUyBoYXJkd2Fy
ZSBpbXBsZW1lbnRhdGlvbiBpbiB0aGUgc2hpcHBpbmcgcHJvZHVjdHMuDQo+IA0KDQpUaGV5IGFy
ZSBzbGlnaHRseSBkaWZmZXJlbnQuDQoNCkZyb20gQU1EIHNwZWMgIGl0IHN1cHBvcnRzIHRocmVl
IGNvbmZpZ3VyYXRpb25zOiANCg0KICAxKSBzdGFnZS0yIG9ubHk7DQogIDIpIG5lc3RlZCB3aXRo
IHN0YWdlLTIgaWRlbnRpdHkgbWFwcGVkIHNvIHN0YWdlLTEgY2FuIGJlIGhvc3QgcGFnZSB0YWJs
ZXM7DQogIDMpIG5lc3RlZCB3aXRoIHN0YWdlLTIgaW4gdHJhbnNsYXRpb24gc28gc3RhZ2UtMSBw
b2ludHMgdG8gZ3Vlc3QgcGFnZSB0YWJsZXM7DQoNCncvbyB0aGUgcGFzaWQwIHRyaWNrICh0cmVh
dGluZyBSSUQgYXMgcGFzaWQjMCkgaXQgbWVhbnMgRE1BIGRvbWFpbiBhbmQNClNWQSBjYW5ub3Qg
YmUgZW5hYmxlZCBzaW11bHRhbmVvdXNseSAoYm90aCBpbiBob3N0IGFuZCBndWVzdCkuDQoNClRo
ZSBvbGQgRUNTIG1vZGUgaW4gVlQtZCBzdXBwb3J0cyBmb3VyIGNvbmZpZ3VyYXRpb25zOg0KDQog
IDEpIHN0YWdlLTIgb25seTsNCiAgMikgc3RhZ2UtMSBvbmx5Ow0KICAzKSBzdGFnZS0xICsgc3Rh
Z2UtMiAody9vIG5lc3RpbmcpOw0KICA0KSBzdGFnZS0xIG5lc3RlZCBvbiBzdGFnZS0yOw0KDQpU
aGlzIGFsbG93cyB0aGUgaG9zdCB0byBzdXBwb3J0IERNQSBkb21haW4gYW5kIFNWQSBhdCB0aGUg
c2FtZSB0aW1lLiBCdXQNCml0IGRvZXNuJ3Qgc3VwcG9ydCB0aGUgcGFzaWQwIHRyaWNrIHNvIHRo
ZSByZXN0cmljdGlvbiBpbiB0aGUgZ3Vlc3Qgc3RpbGwgcmVtYWlucy4NCg0KSW4gdGhlIGVuZCB0
aGUgc2NhbGFibGUgbW9kZSBzdXBwb3J0cyBSSUQyUEFTSUQgKHNpbWlsYXIgdG8gcGFzaWQwKSBh
bmQNCnByb3ZpZGVzIGZ1bGwgdHJhbnNsYXRpb24gY29uZmlndXJhYmlsaXR5IHBlciBwYXNpZC4N
Cg0KVGhhbmtzDQpLZXZpbg0K
