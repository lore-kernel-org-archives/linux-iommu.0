Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E995B3716D
	for <iommu@lists.linux.dev>; Tue, 30 Jan 2024 03:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583886; cv=fail; b=SaAfgfSY8Jetv3br0UnHP37+3ZO0677qfpt+Cnx82vLU7pk0w8fC/Unvv9JbthJItpWVWspuFS3QaEVxPdZznMeG2wSaDM97zCKH673V5saO30qxMnw6o1VlsOUGa65MNXpeKAgJxoDzPex7BdZHi/hIBS5/zWTty5eosm8duuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583886; c=relaxed/simple;
	bh=nOG7WTuhYCpzMmk51hTWG59bPkw6KVztSJKb4Nh+MC8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KuOWqohh0DzM1+66rSWYmhC+WCeILDIdxddH3y5LvvWd3t4I6u2Lktuk4XQHRAXiPbFYa5S6E4VvIWSzx3bmmiC5RSu/kXPMxkf5PjJwPD1oQ3wULQJEbgkOidbDligvxHDrQ3oyApD5xr/i3XSj8HTQsQoiWFdGPw84s2v1Ngo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLRIHHxg; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLRIHHxg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706583885; x=1738119885;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nOG7WTuhYCpzMmk51hTWG59bPkw6KVztSJKb4Nh+MC8=;
  b=bLRIHHxgHt4qEtaRczgd4VZyY5Db/zCN54DKdZyo7nWVc+fDfW8CUBM+
   ViIcTbfvaXJGMIxHek/+110fqb/sMZdjM5crfT5y8RoKhhDR2ochIlip1
   5QdkAl2+sSq5oBZYIjRCM5bIR+XHjYy5M2aA7xa2yjDK2z+RTI1Pjaqhd
   DMMMg0gyXvtaLjgZkP/CtX72OzMC1u8pEC53KOq2bfz6oLAu5jwr5buH3
   KyH/RSDkBhRA08Zr/T7lG5RS//lJAZxluSPfOhp7dVUf8FH7Z+Gv/IoSN
   9kqCBHyxKZjST5p0rNNeHln5OYEGcDOJ2fxWZiOEoWoLkvQqx8dSud1bW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2985999"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="2985999"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 19:04:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="1119117447"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="1119117447"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 19:04:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 19:04:43 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 19:04:43 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 19:04:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Frhnawdo/0Xs+QYBYAjrxgs2O4QDKnykJFEFeEFfVEp2YOHvKwdh1hsWzCMA+0l0a7PQdV6RNNlFX76YdyJ8YTxziG52Vqxh4sEuOSvOkyYT9Mf4yjWj3TwQM0Atqvcoa0f67X0ecUzGNesJpKW7FGoC4l4gnpn7s6ICP1S90JdjaKyY8bA74rN2loU0Cr9O0XYGTMu9oLnf5wFSxVtX3pzdpLENNIgw1CV4WwnEhvgwDukBzZAw6OGnLDUuufHvD9OVWnJMCq23n93OiCGz5F1xqLgZwUO3dAS2w0MlJWc82/8wuL7WIJWv/hsemxrl76cdzyoWCwitLzw66eVAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOG7WTuhYCpzMmk51hTWG59bPkw6KVztSJKb4Nh+MC8=;
 b=nuaiEML/U2HoU2Om5nr7PONwoaOO/FiFhF+KgGAHBGZITFPVN5sSP8xa75W9pBHt7gzyx/m7HgN/f8haiyTFyBbMI458VthVi0m64TVIOC5+wsGYHvfaWt8y8JGALQdfETX9zHyXMI0IH/FRB3S32UvBpCQP2YyfK9cQHEttkNXxpwocr60hJrFXsNyUgZsi2ytEsKM4Wl7qR9ru2A+sjFsU0iEicoB1pS3eVP0/8S5fg3Zte3oO/MOxlAPLX2+5dD7xjerQT8cijjh+AHzsdDEUKJUXAz/S9NhsIubmDQ+kAf0sQXj0ZWn/Sq29fnKDFGXpcyjKOa7zFTd8PSa6rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by MN2PR11MB4694.namprd11.prod.outlook.com (2603:10b6:208:266::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 03:04:40 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::575a:4bc8:9e9:2e53]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::575a:4bc8:9e9:2e53%6]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 03:04:40 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [PATCH 04/11] iommu/vt-d: Retire struct intel_svm_dev
Thread-Topic: [PATCH 04/11] iommu/vt-d: Retire struct intel_svm_dev
Thread-Index: AQHaSBkoMQFixBdvFkK59puPCgq3ebDdmzwAgBQd8TA=
Date: Tue, 30 Jan 2024 03:04:40 +0000
Message-ID: <MW5PR11MB58814990778EE5643C329A7A897D2@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20240116011146.18645-1-tina.zhang@intel.com>
 <20240116011146.18645-5-tina.zhang@intel.com>
 <e0bd9c46-f4c8-4082-b0f3-3f841d04b7df@linux.intel.com>
In-Reply-To: <e0bd9c46-f4c8-4082-b0f3-3f841d04b7df@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|MN2PR11MB4694:EE_
x-ms-office365-filtering-correlation-id: a113c755-a8be-4578-2250-08dc21403396
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1gpTuBTrY66MdEOi8/GIhOeol1GFhXxthibElYJAkV15/MhIhLO/WurVFBg0SbkDfBZ9aigh7S6Mwiatl05DCzYbK0s97fAEaRKKuQsZo1wKnsi4AObhvuavh0ywTe5+30yleGB/QrP/qh3R5Zf2Bt9/sLHPHZ+xXpobKO056KO1P5HAJUNDiT7GTeXQD0dNtLEcmUfskoZVDYNRDOhco9PlB0Rp9hHt0nRAbLFYCMpTQxaRWTUJrqbdqH6OkfN7/LL2opSh1pPjvDO8i79OdHDN3FfBcHtXWqpHmAyZFLX7x+0RFvwK7pM8syGr0D9E/Nwvv3sntzHBBziNowMIG4PSbtYROnMK0+rYum8zX+wQQfTXhCrKysGzBDpXA1//M9pT5i+7q2kPgd8gXwooDSWQoIW+FQxz2Z3CYZThtsK4mikUDLU9Czn0fOxfk4I2HIpcCVt2F7XH12miMutKcz9uTZyFOGzSj+BDv26T7ffdk3HYDAfKiCkI+hCQoOX89wD88Cns8bxcFvhe375+NaFglPRqH7O4f6ww0eePvdL+lYZIaIqu7824QqFE5Eyn76+heY62ruQdDiEARsPcmFOrv4wK2WoEv9ItQazvtoVL4AkH8c5JBp8p5ZZtkuzV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(376002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(55016003)(6506007)(53546011)(7696005)(26005)(83380400001)(33656002)(86362001)(38070700009)(82960400001)(66946007)(5660300002)(4326008)(8676002)(41300700001)(478600001)(122000001)(8936002)(9686003)(38100700002)(76116006)(64756008)(66446008)(110136005)(66476007)(316002)(71200400001)(2906002)(66556008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TURkM1ZkQjdFV216dDJReCtNRWRMQ203M2MyOFFJZVZmVVphZmVvelNwc3l4?=
 =?utf-8?B?Lzg2Q09pczYybnBPcm1RVDNjNFVaWnJ2SHRhOHpCT3U5cHBpVk42MkkzbjQy?=
 =?utf-8?B?YWY4UWoyYStIaGFIdkJJZ05WZEFSWEp4RVRJZGM1WHVSY0FZUnZJMXl5eTZs?=
 =?utf-8?B?ZEhncEtzSGIrdEdWbzI5clo5QW9rdENibTRtZ0I1cXVwUjllRnpjeUh4K1Fn?=
 =?utf-8?B?QTlTWDZuS1BWT0ZSUFZpVW50czBldHlKQ2pmYzRxSVBwVGdkZGtwMDdyalZN?=
 =?utf-8?B?ZFRXRDlZbksxY25WekZ0a1lvUTJiTWkxbUZPV3dZRUwveXpReWJZQUdoeUl2?=
 =?utf-8?B?RVJjZElRN0h2UERRSU1QL0RyRi82d2VTVzZmWlN5TmY1TG5Md0J2UUdTZDk2?=
 =?utf-8?B?ZTJKV1ZlR3kxeHQxMkNrL0tyR1dnU2U3a3d2eURMeDVuR2JnSE55MW83T09Q?=
 =?utf-8?B?cU94dU1vZWtQRDFHbDZqNTkzd0VJeXByVmNuaitiNTBpc2NvclQwTWtyd1h4?=
 =?utf-8?B?U0lkRDdNV3MzTXFianBUL0JPbzRSRDlqSGI4STFPWmRWL0pwRkNtTUhNVm9w?=
 =?utf-8?B?bTFPd25lQStGU25BOUJLZmYrc1BCcEY5OFNjak81VW9PQk9ENmprUUJmWUJC?=
 =?utf-8?B?dVBKUGZmS0thSzQzdnR3b1hoa3k4dFN1UXBrWEJSQWJCejAxMWdleFBmVno1?=
 =?utf-8?B?RkFHUHdpUTZja0FnRGVOTmhqQTBGQjFtZnB5Z2tDbFYrbGpzQVpKVDE2eUcr?=
 =?utf-8?B?akhxYUhBclQ5ei85ZXdnajFmT0pIbFU5eE9oczFvU0NQS09iUnVyV0xkWm1N?=
 =?utf-8?B?aU5LeStLK3NvWnJRZjR6NXprT256Z1MyWXBPL3YxQ2FiWXU2Zjd1N2JXbTI1?=
 =?utf-8?B?NUFCR1dPVG52RER2N0J1S0RGNHRVUmRGUHpxUzhtR09hZlBQR1FCd0psMmJn?=
 =?utf-8?B?aGtyOS82QkJ0SXFxbDJoS1puUlU1K2laRHRTR3FyR09YSmpvQUdaVE5QV0wy?=
 =?utf-8?B?OEtBKzBFMXh6VEpacGFSbGhvam1sa3lLSkpvbTRFME0yZ0h0TW9Gek9ITTlP?=
 =?utf-8?B?UEhWUEcwMWovUmxZYjNXSU0wdDUxcDZ1MWZudGlUZ0Rsd2dlZkVNN1hoMDEr?=
 =?utf-8?B?TXdUTXFMazJpT0taMDhsT0dvNmdRUS9sRU9BRkVpd3BDV2paamQrcnlQTkFZ?=
 =?utf-8?B?WDVoV25zVy9RVk44dlByczNiYXZDdUh3Z2Z4UzBFV1RXTzhLNGhNcjhCUVpk?=
 =?utf-8?B?L0JaaWZIVks1U3ZvbzFVSUJpYmxhbFZ4NkFhQmQzMGNmYnF3R2Nmelk2VlRX?=
 =?utf-8?B?VUYya2hsVWp5VmNUbFRsbmZ4U1IzSVIxd3FTdUlvV2QyellKVjZVNFV0anpr?=
 =?utf-8?B?eWVScnpSaHd5NGJ1RTVLU3ZKVVYwbzBrTjRYcUcwMnFuV085WlBuZlptZFN3?=
 =?utf-8?B?T2dGMmoyNVFqRU5GanVDQ29hcmZ4alY2WTFPZU15OFdVYzhnaUdzL2M1bEdK?=
 =?utf-8?B?Z2RjV0dUMzR2eFJycUdETDZYcC82VnZWZU14OHFsZUxzNDN6SFUxWDZEOFpQ?=
 =?utf-8?B?TkRtazFSQ0o2dkZlVWpxOTl2QVV4UFdibEVKM2Z2bUZWdHI2eWxXRnp5WWhE?=
 =?utf-8?B?eE9WUGhERlBFSnViSzJxbmhmWE51TkRPRkcyc2czQzhqY04vWnZvMC9JZlM3?=
 =?utf-8?B?elFzbDhuOG1wMVFVb0JTQ1YyM1JvNWE5NjZlZU11QWNGZUhNUWw3ZGhlVS9t?=
 =?utf-8?B?Mk5BdW42VTl4cjh5VmpuTWZhYXZ1bWFGVk1Iakw1NlBDNTRPek41ZXNzTDdK?=
 =?utf-8?B?R2laTklZT29GTnhGblh0MlBKNEQwU3JoVXdtZC9iaytsbTloUGxxdjRUY242?=
 =?utf-8?B?RERjQkNKR1pHc0ozRlg3dDE1MExjSm9ZVnVSMFRsaDNPYzhuNFVlVDczVGpm?=
 =?utf-8?B?N3RkMktUNnRNdjVHdmZwNytURmFmYmFTVDkvejJ5QXBIM2F5L1d1ZTJrRURu?=
 =?utf-8?B?UVk4L1dpdzFsb1Y4bC83cTdrc3lCdnpvNHZOVGJVN0Iydi80b0VYWENOQVlu?=
 =?utf-8?B?ZXp3NUN3Zi9SK2czaDZWOG5FaWZ0TWllK3pVU3ZCNnRGY1pWODdiamRoM0E3?=
 =?utf-8?Q?K7fyhDU5vh8FGqU2KYK5Z1HHu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a113c755-a8be-4578-2250-08dc21403396
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 03:04:40.6661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tPBnU6x+s5s7f45zZ+5sEwEYcdJah+Qo/KfDLUOShOA67EumuaBJe4yjQm7X1mh+8sdxIF6jflyE3pworbdKZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4694
X-OriginatorOrg: intel.com

SGkgQmFvbHUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFvbHUg
THUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5
IDE3LCAyMDI0IDM6MjEgUE0NCj4gVG86IFpoYW5nLCBUaW5hIDx0aW5hLnpoYW5nQGludGVsLmNv
bT47IGlvbW11QGxpc3RzLmxpbnV4LmRldg0KPiBDYzogYmFvbHUubHVAbGludXguaW50ZWwuY29t
OyBUaWFuLCBLZXZpbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggMDQvMTFdIGlvbW11L3Z0LWQ6IFJldGlyZSBzdHJ1Y3QgaW50ZWxfc3ZtX2Rldg0KPiANCj4g
T24gMjAyNC8xLzE2IDk6MTEsIFRpbmEgWmhhbmcgd3JvdGU6DQo+ID4gVGhlIHN0cnVjdCBkZXZf
cGFzaWRfaW5mbyBpcyB1c2VkIGJ5IElPTU1VIGRvbWFpbiB0byBrZWVwIHBhc2lkIGluZm8NCj4g
PiBvZiBhdHRhY2hlZCBkZXZpY2UuIEZvciBzdmEgZG9tYWluLCB0aGVyZSBpcyBhbm90aGVyIHN0
cnVjdHVyZSB3aGljaA0KPiA+IGtlZXBzIGluZm8gb2YgYXR0YWNoZWQgZGV2aWNlLCBuYW1lZCBp
bnRlbF9zdm1fZGV2LiBJbnN0ZWFkIG9mIHVzaW5nDQo+ID4gdHdvIHN0cnVjdHMgZm9yIHRoZSBz
YW1lIHB1cnBvc2UsIHRoZSBzdHJ1Y3QgZGV2X3Bhc2lkX2luZm8gY2FuIHdvcmsNCj4gPiBmb3Ig
Ym90aCBzdmEgZG9tYWluIGFuZCBJT01NVSBkb21haW4uIEFzIGEgcmVzdWx0LCBzdHJ1Y3QgaW50
ZWxfc3ZtX2Rldg0KPiBnZXRzIHJldGlyZWQuDQo+ID4NCj4gPiBUaGUgcmN1L2RpZC9zaWQvcWRl
cCBmaWVsZHMgb2Ygc3RydWN0IGludGVsX3N2bV9kZXYgYXJlIG1vdmVkIGZyb20NCj4gPiBzdHJ1
Y3QgaW50ZWxfc3ZtX2RldiBpbnRvIHN0cnVjdCBkZXZfcGFzaWRfaW5mby4gQmVzaWRlcywgdGhl
IG5hbWVzIG9mDQo+ID4gZnVuY3Rpb25zIHdoaWNoIGFyZSByZWxhdGVkIHRvIHN0cnVjdCBpbnRl
bF9zdm1fZGV2IGdldCBjaGFuZ2VkIHRvDQo+IGRldl9wYXNpZF9pbmZvLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogVGluYSBaaGFuZzx0aW5hLnpoYW5nQGludGVsLmNvbT4NCj4gPiAtLS0NCj4g
PiAgIGRyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuaCB8ICAxMSArLS0tDQo+ID4gICBkcml2ZXJz
L2lvbW11L2ludGVsL3N2bS5jICAgfCAxMTAgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKyksIDY0IGRlbGV0
aW9ucygtKQ0KPiANCj4gSSBsaWtlIHRoZSBkaXJlY3Rpb24gdGhhdCB0aGlzIHBhdGNoIGlzIHRh
a2luZy4gSSBhZ3JlZSB0aGF0IGludGVsX3N2bV9kZXYgc2hvdWxkIGJlDQo+IHJlcGxhY2VkIHdp
dGggZGV2X3Bhc2lkX2luZm8uIEhvd2V2ZXIsIHNpbmNlIGRldl9wYXNpZF9pbmZvIGlzIHByb3Rl
Y3RlZCBieQ0KPiBkb21haW4tPmxvY2sgYW5kIGludGVsX3N2bV9kZXYgaXMgcHJvdGVjdGVkIGJ5
IFJDVSwgSSByZWNvbW1lbmQgc3BsaXR0aW5nIHRoaXMNCj4gY2hhbmdlIGludG8gdHdvIHBhdGNo
ZXM6DQo+IA0KPiAtIFRoZSBmaXJzdCBwYXRjaCB3b3VsZCBtb2RpZnkgdGhlIGNvZGUgdG8gdXNl
IGRvbWFpbi0+bG9jayB0byBwcm90ZWN0DQo+ICAgIGludGVsX3N2bV9kZXYuDQo+IC0gVGhlIHNl
Y29uZCBwYXRjaCB3b3VsZCB0aGVuIHBlcmZvcm0gdGhlIGFjdHVhbCByZXBsYWNlbWVudCBvZg0K
PiAgICBpbnRlbF9zdm1fZGV2IHdpdGggZGV2X3Bhc2lkX2luZm8uDQpUaGFua3MgZm9yIHRoZSBz
dWdnZXN0aW9uLiBTb3VuZHMgbGlrZSByZXBsYWNpbmcgUkNVIHdpdGggZG9tYWluLT5sb2NrIGlz
IGEgZ29vZCBpZGVhLiBJJ2xsIGluY2x1ZGUgaXQgaW4gdGhlIG5leHQgdmVyc2lvbiBvZiB0aGlz
IHBhdGNoLg0KDQpSZWdhcmRzLA0KLVRpbmENCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBiYW9s
dQ0K
