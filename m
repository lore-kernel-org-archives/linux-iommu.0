Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3583A7F8
	for <iommu@lists.linux.dev>; Sun, 23 Apr 2023 08:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682238215; x=1713774215;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qb2+DLrMj+yXOrdRRqEV8Twejg5bt4AMwQnvyFeOg0g=;
  b=LkwSSJ7XYQoZZ1bsG/45GPyCQjjB9xzmsSam6G8QVspmLohtmfjPTDhp
   vgWatyfy28QYGzgBsFFTlHCIFThQHOwbLKu6XulHIygyXTMDY4n2FLvZK
   Nv5pZkXkKIKWEIDI35gmRApAIyJS05UBjW3JGOneh9pe/s+D6UpSBS8yb
   ecAPlW+lAN1fvJEg/aVEbwhA9vHD2u6v5q7NkkqrbAYFa3WoDIy8Wv1mn
   puCrYr/WOpt8QK9a/aOQI8d1IM7PxVmNJHOG/VB2tpfKTsuneNoXLuga5
   /pnk0/BzQim23OvM5SNQaezUVNI/aFAv1MM4Xl565k9QDtck/hYUWweYr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="346281652"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="346281652"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 01:23:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="642983174"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="642983174"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 23 Apr 2023 01:23:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 23 Apr 2023 01:23:31 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 23 Apr 2023 01:23:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 23 Apr 2023 01:23:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 23 Apr 2023 01:23:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPKdX+wY52zc2LHm55gpOVbANE1d7349hHVMEuIxrSP4IpglFsVRk52kIT4EzflxfcPrOcfG0oJuQgN5uAadpEqB/wd/rBsW2/qJlQOZnbYiJFtGpDQDbHvQ5eYSY7mYZOxN0JBA/NJyYiP7p/+NeEjhIaCvQDoXIDeR4u1N4Ji43uI642LUPc32+lY8K/51/uGE9As+HwqcFaomTqtGCuntvT/jCMTBKhomW2yj1T3K+YP+vH5O5iO66L9nQ8BFXVZ9E/FahlDX393mLxuN+NXOnj088RDaSYdL2QwIdazGd0ZRxec6y7mluvLS4kTDeOu8s2XWNfTVC1pVPnCAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qb2+DLrMj+yXOrdRRqEV8Twejg5bt4AMwQnvyFeOg0g=;
 b=PL/MqV26k9CaBetodplcyGKyuvHube4vj80u16GOknEQmJlOzYLIg8h/V0cm5OnHZm3KDg9D0rXVYyg5cu+ok1d/6nvFOZUCGg9qHmkoqmQ9gcwhikryWPb/qZvYp/DxWqz3+gPoewu7hilHigbLGZhiebKs/l6hKdQLHbg6wvtQpe8uSOsS9aqDxnqy2P/Gp9n4ZivElxWt84fWueuFaUFmQQETMV3nnNZnuS6xSiOHg/CNCiY6979+BJbG5pPsQlvqW2mhN+OfYlrlU4M/lPJOnI11dYFGy2dBsXGQ7cG2D41TBDBPLqKeTTzbvo2pfyHw+C6MVX2ljlkJezQEfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB6797.namprd11.prod.outlook.com (2603:10b6:806:263::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.28; Sun, 23 Apr
 2023 08:23:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%6]) with mapi id 15.20.6319.022; Sun, 23 Apr 2023
 08:23:28 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Robin Murphy <robin.murphy@arm.com>, Alex Williamson
	<alex.williamson@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, "Lu, Baolu"
	<baolu.lu@intel.com>
Subject: RE: RMRR device on non-Intel platform
Thread-Topic: RMRR device on non-Intel platform
Thread-Index: AdlzU1l2SINtdgKASzuG/OHqnI4zdAAPzvCAAAAmJYAAAQTsAAAEaOkAAApGNYAADQGI8AAPzteAAF3ZuoA=
Date: Sun, 23 Apr 2023 08:23:27 +0000
Message-ID: <BN9PR11MB52765B59D194EDFAF6AD03988C669@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <BN9PR11MB5276E84229B5BD952D78E9598C639@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20230420081539.6bf301ad.alex.williamson@redhat.com>
 <6cce1c5d-ab50-41c4-6e62-661bc369d860@arm.com>
 <20230420084906.2e4cce42.alex.williamson@redhat.com>
 <fd324213-8d77-cb67-1c52-01cd0997a92c@arm.com>
 <20230420154933.1a79de4e.alex.williamson@redhat.com>
 <BN9PR11MB52760FCB2D35D08723BE3F2A8C609@BN9PR11MB5276.namprd11.prod.outlook.com>
 <b2725362-aede-44dd-76ce-39482511ec94@arm.com>
In-Reply-To: <b2725362-aede-44dd-76ce-39482511ec94@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB6797:EE_
x-ms-office365-filtering-correlation-id: 5177a358-81de-43c4-d6f0-08db43d403a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VqRnInFr3Y4u2C6czmDuiTlL+4unWWBl8qDbzPxnfNBDHbHEc+l06ZN1y0DYY11xaAqtEi/hByq6EHLZoDxCiAkVkdSjjR3QEapJK5VodDo417kV0lCshBWKYfZncTaZC/OJ1FTD0x7Dma2jOxIrLmkGxENB+3+RUc+L89+b2ZgsgzK2zMeik4bT5r1i9U/Vq8Yqan/4NSQE5vnk0auSJXFKeZSQKqmltFVv11gKGTldUU1hVre2idGAYt4ruq+CgdJTRIVi2nqDWQ60F8zUHhG1g/4HPTk1czJ+s6WP03ljt1ma9/y9O5tpgag64Kl2v0VvQsExDr4c65HPWqPJ4az2S4Wf6/q/gCNdXr7wyUiKbxZHuXZCr4KHQkMLOoEFoN55aFXpjIJ9Z0BnKEOU8tsV2n/XllS1tuZYciEn0rZGpm4xrPHondJheXnwS0cTyPRz6kSp/w1M+sUWC61PpNXGF05JIuC1GGGUkOHK3VTwTAj93V87QCzzYSVpzbTffBf0yt/5A4x8n0g8ClSAUIK1bgllprBVtG3SljgQ/WMzIevpU57IIuDnF0638In5yQmqRCEXoR+Q6JER4KEGTCkGTZ0vpumqzhmAzCFc1NWzizgkP5gHQjMDK7qFn2qi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199021)(110136005)(54906003)(4326008)(64756008)(316002)(76116006)(66946007)(66556008)(66476007)(66446008)(478600001)(7696005)(71200400001)(8936002)(55016003)(5660300002)(8676002)(41300700001)(52536014)(2906002)(4744005)(82960400001)(38070700005)(86362001)(122000001)(38100700002)(33656002)(9686003)(6506007)(107886003)(186003)(26005)(66899021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzBhQzEyWE5hWTdPQmFRUDhzbWZ0a2hub2VjV05VSFNKZTU3ejgrakdJSXlJ?=
 =?utf-8?B?WHpKUEZzNXpTMWo0N29BOERTV05NQmI2NENJTFhxS0NhY1hndjhZMEV1elB5?=
 =?utf-8?B?NW1QcWV4aVZUWnBST09oSmNPS0dveVNvUmg1UHVOZTVKNDQvcFRWNjJqZEZ2?=
 =?utf-8?B?blhudHRnQmE3WkVGV3pidFBnSi9YTEVOaUhzMEpOaENHYlFWQXZaMW1neTlk?=
 =?utf-8?B?NmUxak5UOXRHd3lNWWdWU2pTK29wbkpCNGpLTEZDdWhsUE9WRmZsODJWMVpP?=
 =?utf-8?B?N0UzOW92YklGQXJrZ25Sb3BHQ09tanZndWVWZk81blRacTNOTWhVZkh1OTNt?=
 =?utf-8?B?SFdjbkZsMEZ5ZkE0bnlEMWlDQkpDTWNWRDNnaUVJY0tybVM4YkE5cE1XanZu?=
 =?utf-8?B?b1F6cHVod0QyejhtZ29UUXQ3WFAxd3YrNFBuQjNNdjBWVEdjL3haSWxpMEpE?=
 =?utf-8?B?UUVoekNES0RVMFowZXIvZGJBL08zbHdLY1lMekx5QXh0TlNQWWx3ZzdTWVBH?=
 =?utf-8?B?eTFaWDAxZXdRbGkzUDNBVzE1a3NCZktIWEpDRy85R0hEbVd1NHdvZWJjNzRo?=
 =?utf-8?B?azFSc001Z1Q0WnYwYW1VNSs0aHJMUDk1Ylplck9wYjZFYXdtY3lKTEdUU2NZ?=
 =?utf-8?B?Sk01OUtpZGY2cHIxOTFxZkZ4NWJmcEd5WkI2V3BUMldwOXIxY0RrNjA1M1ZQ?=
 =?utf-8?B?clNRNk4ybkJURHdRL2xXV0RkRStIam9BSEQ2c3BNSk9vTlB6SDlGaGU2M3Bu?=
 =?utf-8?B?a00zMzdaK0htMXg3bkRFTVhiUW1sL21FaldDRzgzVitHa1p4TkxTSWxoNERj?=
 =?utf-8?B?djNqUkRCd0pDREhhWDRWUzVGL0JCNGFWelVWZlZPU01kQlYwazdnSVJuM2Vw?=
 =?utf-8?B?UVo0ell6MlNTVGxvY0lCV01jaisrWjlXNmNuR3VWT0RnSTRrbmd0dWdVN0ZW?=
 =?utf-8?B?L01QOENJQ0dqNG94U2FrWFUrRGxick83R1d0Q24wYTM4aW1yb3I4cVVJOS90?=
 =?utf-8?B?elVKamF5bUlucFFuRzl4bThaS3BrZWdrZSswZWNNeDV3VjlNaUQyRDBMZTcx?=
 =?utf-8?B?dnJUVkJENnFTbUVxbUFCNGRKbndhaVdEYjJyZjdCMXJzRmtJZjMxdE56UEMv?=
 =?utf-8?B?R2UwQ1d5T1dFcHp2WE1wYStZQzVNbE9pTndMRkNUMUloSWh0ekZsTWdRYmJ4?=
 =?utf-8?B?cU5KYkEzYTFoVFZFRzF0L3Awa1YzNU1wVmFKMlBSVEZLRjQvRTdaOUtDWFRp?=
 =?utf-8?B?UXlCQUhFVmlWdG9QR0NwZml3bFNIaFY4NTVyZW5uR0psQUJnTU1BdDVLdm9H?=
 =?utf-8?B?TzVNK05CYUNabUdMcWYwTHlkbmJLRUhwMWtLVjZ0QWh1K21JVHRIME9sUEhq?=
 =?utf-8?B?WTRpcEV1Zmh2RWExRFE2MElHK0dGV1cxS0ZQdEg2L2RyQU5qQ25MazVza2Vw?=
 =?utf-8?B?K1UvdkYwNnFmcWdFVHNXSXFIMUpINDE0bXN5OTNya2Zsa0E1Z1QzSjBaaE9D?=
 =?utf-8?B?SWJmaHZ2bEpScHFSZm9JWCtZZ0haRFlMK09STEJqeXRqdktrQVMveGpEbFd6?=
 =?utf-8?B?TWtmRzlPUjJCSXhOKzhhdDl4WHkxaUtBdVZxV2VEdEQ4TG00Tjg1bkc5cnlI?=
 =?utf-8?B?Mkp5LzgyeklVaEE0TXRQMW5rekVRNytOajBpR2w3OHVmbzlRMzRZMjlkU3ha?=
 =?utf-8?B?MVNqMDJ6a3JHMG5CRXZocWhOZHBOOUFtRFhzdVNHUTh5TWNOb3MrQVR5Y3l3?=
 =?utf-8?B?MTJxVTg0bGxwSURNYVB4WjBoY3VjaFVLVUhycUtiK3RJRm1TNm9DNDVwSm1P?=
 =?utf-8?B?cjJPM2g1Q0VmNnlMdFQ0dUNsanFOdWRNWlZqSWxzbTRpNHhVS2dQU2R5cFhQ?=
 =?utf-8?B?QzFxVUZBUEhZdlVUUWZzQ2thVmVmZko1VzZ6RFYzMnQ3aGFQZkNFeUk5Ujhm?=
 =?utf-8?B?YVpnTHo4UjRabkQ4TnJRTkg0TzllaGxVakV6aGQ4QXJaQ3NRYVpvbitoNDZF?=
 =?utf-8?B?SnJMVWhmZTV2ZVhsajZGRldtT1l4WjF1VzYxZzlqdlBibGFzTC9hZU5lNzBi?=
 =?utf-8?B?SnRXNXVIS3NBU256UmEwRUNlUHJJQjZObG9UUEkyZ1BoOGdERjM0a0pqWGVz?=
 =?utf-8?Q?lQDe1gC6Gnpb22J/3SfDNqQTh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5177a358-81de-43c4-d6f0-08db43d403a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2023 08:23:27.5787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EZ58FCxwrO+Cyhqr8rCDyDLGXq74VXCCF7x1QZ9uF9cYmuEy0P/CoBnI7kAf/WLbG/e0DqJmORYhFkW++HMliA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6797
X-OriginatorOrg: intel.com

PiBGcm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiBTZW50OiBGcmlk
YXksIEFwcmlsIDIxLCAyMDIzIDc6MzUgUE0NCj4gDQo+ID4gaW50ZWwtaW9tbXUgc2V0cyBSRUxB
WEFCTEUgZm9yIFVTQiBhbmQgR1BVIGFzc3VtaW5nIHRoZWlyIFJNUlIgcmVnaW9uDQo+ID4gaXMg
bm90IHVzZWQgcG9zdCBib290Lg0KPiA+DQo+ID4gUHJlc3VtYWJseSBzYW1lIHBvbGljeSBjYW4g
YmUgYXBwbGllZCB0byBBTUQgdG9vLg0KPiA+DQo+ID4gQVJNIFJNUiByZXBvcnRzIGFuIGV4cGxp
Y2l0IGZsYWcgKEFDUElfSU9SVF9STVJfUkVNQVBfUEVSTUlUVEVEKSB0bw0KPiA+IG1hcmsgb3V0
IHdoZXRoZXIgYSBSTVIgcmVnaW9uIGlzIHJlbGF4YWJsZS4gSSdtIG5vdCBzdXJlIHdoZXRoZXIN
Cj4gVVNCL0dQVQ0KPiA+IGlzIGFscmVhZHkgY292ZXJlZC4NCj4gDQo+IEFybSBzeXN0ZW1zIGhh
dmUgbm8gbGVnYWN5IG9mIG5lZWRpbmcgdG8gb2ZmZXIgY29tcGF0aWJpbGl0eSB3aXRoIGEgUEMN
Cj4gQklPUyBmcm9tIHRoZSAxOTkwcywgc28gUFMvMiBvciBWR0EgZW11bGF0aW9uIGlzIGEgbm9u
LWlzc3VlIGZvciB1cyA7KQ0KPiANCg0KTWFrZSBzZW5zZS4gT24gdGhlIG90aGVyIGhhbmQgaWYg
QU1EIHdhbnRzIHRoZSBzaW1pbGFyIGV4ZW1wdCBvbg0KVVNCL0dQVSB0aGV5IGNhbiBkbyBpdCBh
cyBpbnRlbC1pb21tdSBkb2VzLg0K
