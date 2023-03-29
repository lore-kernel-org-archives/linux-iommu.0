Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828521C32
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 13:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680097261; x=1711633261;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RDaX+UpDXjwO6KCJEDSk+WKOGXgm3lLuUaGG6hmgghI=;
  b=YgCSxoCYaD4q8wL2KKrMVCoqaqO4ksPeOaoLhnj4o1lxBsMP/jR66skD
   mymsYHLTS1tL4N8+qySvI5qgUhMysANPEWO0nGpxkmmXFI/cFLyz2yOtJ
   RARYxpXvmIZ9RMUM4I2AUUGHNqINSgzp6eF01tIueI9mHECjBKe0v3RQh
   zNUB2iTWCZEmTt+WVuRfi3MjkujXWv6F67RpPLDK4vdSZPvZCVCkW5thO
   wHdOYOWo+i9uXVDDsqBP89uADDUl+liJNrdhpzJHsF73ffXChmIGXn6bZ
   86P6OvSDa3S5BkMnnb/RpXMG/ICbdTJo11Nvj9Bzc0U263xGAUS/5TBmJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="405820933"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="405820933"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:41:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="634475602"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="634475602"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 29 Mar 2023 06:41:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 06:41:01 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 06:41:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 06:41:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 06:41:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IicpdaiMxRXbZL/Lc9M2nxjfiVrmGqUhnX/xBkSEoZfgzsU35jy9lGyrQQkda+m2NvYomfs7BKGu2HsQCoaKDfNI7c0DKYjYadYxdZXwMn7HnELmBMT5R6Op6PFmMu+CAlNKdPqnVXoSiIZKBJ7gqAsR6VL2qRwenyDkvSfe7afK+4g7/Cc3vRQVdA23GhrKqL/5RwPx5nQFb31Wx1/hy2deLVaIbGskr8pj4Q+neLWF7D8Cav5OTH/8knAMqqdFmNfu77K6VenhtEpdgB1SM218aCJVLmWDVoU2Sljrot3q/d7RwDkTwlrTlhygCluc4/XHxQbfhDOvT4AoygdiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDaX+UpDXjwO6KCJEDSk+WKOGXgm3lLuUaGG6hmgghI=;
 b=T7ZVNpowLjGldSnmrzW1zRbecHj2sZnm9WWgzaC/BlZdPelUh5LX03kh1m0tXF5gLA1tcYC44OHVnXCZgt6R+HTrnSopNr+ImuA6z4kTmeXLlCG3MOJ0IQvyVF/qREhXv+3Z/ZYSMGSPpp4ahJBcYDfVRED5uecQ2UBG8Zf9y8ZeS460zzOETvUve5eNGo4w6Kn2tjapC6HfY3JXm0cvFMmQ8HgoIFQbo2KGatCw0NzqpfM6VF7lhi3kqbAD/k9g+/O4u8PQ4yVYRjdQk95+BO1jSAf1ngxNOr0YQKuoqpjjzNi5ARVeSLXkmPJRAu5q9XyB1XoKr7tFL2HIys1VWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 13:40:59 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6e3:782b:3976:5005]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6e3:782b:3976:5005%4]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 13:40:58 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "Ma, Yongwei" <yongwei.ma@intel.com>
Subject: RE: [PATCH 1/4] iommu/vt-d: Fix null pointer access in
 invalidate_range callback
Thread-Topic: [PATCH 1/4] iommu/vt-d: Fix null pointer access in
 invalidate_range callback
Thread-Index: AQHZYkDuO11H/BSQAUaYiyEHuz2oJa8RwNeAgAAA7LA=
Date: Wed, 29 Mar 2023 13:40:58 +0000
Message-ID: <MW5PR11MB588152CDCD93B26592B7F99C89899@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20230329124654.2698853-1-tina.zhang@intel.com>
 <20230329124654.2698853-2-tina.zhang@intel.com>
 <534e6556-40e8-82f7-b3f6-0d0ad67616c0@linux.intel.com>
In-Reply-To: <534e6556-40e8-82f7-b3f6-0d0ad67616c0@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|DM4PR11MB6479:EE_
x-ms-office365-filtering-correlation-id: b12cf906-96eb-466e-8945-08db305b3ab6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uu0U59LF6JFPXcUeEn1t0iYkDSSsGlV7YOoigNzq+X+V5wlhKrnzBH53Hwo3TnA2JlyXw9FrsGP51sMDiOLM824/VcVLQuI3M86+yVVbpycY/xHtgSvwTrja6OhigEnH0MHFjJrVDpMgDVy09wAlyV0zjBbb3b9el9csbbTGz1pnTUBuKOg0xZVDYRzfmCOuU9FHv3+e8o680+t85xCDJN+RlC6p3dB7LSrd+s0Yb11zSNnQ8WyOs4vgukBh7nrIDPHU5JdlkRa/4cAWaMUQWdJ6aMVi94QKspJ4uUbz+J8MP0gJJbVrXUeivRu2WZOMDkiEtIz0Bo1fg+HI04FPzkM7uDAtjeMf2oP6+LEnHxpEyHRqX289DRQmwKzng3aJ1OyqaGCS6cYXLsMmYDM6s0FGuC1eGMJ+TurWrkmkm4tfB0zgausEgtYxgKcAgZUObI5E6CT8kNRBtN7tirwmj2U6nzzXuLgCyeLEbD5JjxQaTyUwbY7PkB34XBcTKFA6Ly9sssjGV5kN+dhe16uF3qKVbb5V8MPL/30lCR08ok8eP6QUgj2ddrr/TX4o6Cl3HTXXlm8Ke6/cGYJIzBtVQbdlYogKjgwxMLY0GXlymoK2/987DF56ZDGGpVcEkYR4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(38100700002)(38070700005)(41300700001)(8936002)(122000001)(4326008)(5660300002)(2906002)(52536014)(55016003)(86362001)(33656002)(82960400001)(316002)(478600001)(110136005)(71200400001)(7696005)(53546011)(6506007)(26005)(64756008)(83380400001)(66946007)(66446008)(8676002)(66556008)(66476007)(186003)(9686003)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWFYcDB4bnA4amgwbU10ZzBTZ1phTUIxMExNYm1Kbk1mek1zNEtmeEdwelhi?=
 =?utf-8?B?ektuSndNYjRXckU1dm1NLzU0UUxxNFFEdnBwQzFkU04vdTMxLzBhUGJuakRz?=
 =?utf-8?B?dFBaOXpVUWZFc1FLUTlxNU42cEFVTmpMZ01oNGRnRDZxUVNEL2lyVzM3dnUz?=
 =?utf-8?B?bWZsUGxtZjJlZkxQaFUranU1ekFxbW9MazA5blZmNlVnWmN6SEhKNWFaV29G?=
 =?utf-8?B?Z1dqYmlURGxzb2ladndkRmEyUEhyZ2ljdlEwTXJoMEgvSFQ4cE5zRlZtcFhE?=
 =?utf-8?B?aGptNHV0RFdHVk9GWUxRR2xvaWJCejdGRCtUdmhEeGlmeUtnWEMvRE1qOW5Y?=
 =?utf-8?B?Um1XdnVpdDkraDZwZWpKUXV4Y3lvL3pRRkNSdEZmNkcySm54QUxwZ3dFM21M?=
 =?utf-8?B?U0M3WnJoTW1ZUHdwVUMyamsvUUJ6TGpvUUxqcGhpY1hvUlEybUp6eGhoZkli?=
 =?utf-8?B?dkZRcDU1RHIveHg4alJqRGJaRWNXRlNmSE1wYmZTOU4xYXpWOVAvbUNMZFNH?=
 =?utf-8?B?NHN5OTJpVFd4U0thaUdMTWIvUWNXeVJEbXJOa0tLNFp6aUJER3hZRkljK1Vx?=
 =?utf-8?B?U0Y5eXVnQ2pIMHRCZE9KQ3d3cExwN1paNWVQWjBQd3ZWKzEwZ1BFYXlyUnM2?=
 =?utf-8?B?UFppK0ZScnp5cGZmeWZFL3JOZm81K2YreVRqbU5xaTRrRzZ3Zk55T0Vyelli?=
 =?utf-8?B?ODh5YUNSZVRZRWlqbnNHQklaOXJxZXQ2czlNUnhvYzRDdm9aMHB4ZmpUQ0ZG?=
 =?utf-8?B?NlhrcWZwekNjaERJQit1VTFCTEg5RFFvWVBNSS9VTmxUUjhoUzJOVEhiZkYz?=
 =?utf-8?B?SG9WNndEZ1J2QytuaXJJLzQ0SzhoVXpqY0Y4L2JvR1ZxSUd1dndMbkhsdjRM?=
 =?utf-8?B?LzFWMWswQmhXdk9XYkZXYzNwV1ZxMy9pb3RWcVJEd2hvWWE1ZU9DUzZuVWpK?=
 =?utf-8?B?MHVpK2dQWjZFL0ZBMzFPOTlaQVNyNSs1N1d5bzcrbU1VdFRrNzNLQXlhUTNZ?=
 =?utf-8?B?T2JqMmxzTUxTdm1tcENKL1dDdEFWSU15ZWZTbXM5RFRhZy9BeHJQU3ZmbjZB?=
 =?utf-8?B?VkhXODIvam5MaVFTcFNRTTMyMDZFckhyUDQ5eWNDVG9PdG15dENXVmZ4ZXRm?=
 =?utf-8?B?aFBBYVBRVUY5SFpIMU5IbWg2d0VlNXdEd2VFM2UzZTZQSDllY28rc0wyOElh?=
 =?utf-8?B?elp1L09VSHNWYVVpWG5ZMWhyNWxHOHAvRis3ckQwN0hnSUlxcS9XQURzRVN4?=
 =?utf-8?B?cHBUUkR2UDJjWmlwbWk2ZGh6M29EbEVMZ3pCMXZPalZnOFY4Lzd4M3M3ZmVU?=
 =?utf-8?B?cGwyUUMyejB5UU5yL0orbStib2IzU0FHS1JjRFVDaUlzMXFGbDYyK085UlQw?=
 =?utf-8?B?eHZJZXJqbEJYTEx2aktNcjFBbDJld1NrdlhaL1NzcmpTcjZwMTBiRkRqdW9I?=
 =?utf-8?B?dmtvazVlTjh1Wnc4ZUlNaDlJU2E1WldFWDl0ZGM4bVFja09jUUUrQ09paUtY?=
 =?utf-8?B?VlBrK1VXb3I0aVh1a3lQMlVkaVA3SVpHOWwraHM5UkhwQVBJRHRuRUk5WitT?=
 =?utf-8?B?bktnN2cvYkNmeTkxQzVFbGIvM1R4clo0NElUREgzaFlkb1ZHTlNON0JZNnNW?=
 =?utf-8?B?VzJMaEw1NllualBtb0ZGZ1hoRnNxTDlBNVpVRGw2ZUhGczRGUWsyVWtacUhT?=
 =?utf-8?B?MzNDTS9JWVlUYkMvQlpzUjkyRnZGRjZMZVk4a1BtN1RQM3FoaHhTeDdYZ2FQ?=
 =?utf-8?B?TTVudXN3THJFS2ZId0dLNi9aY3R4aEpBQ21pZGRKT2ZITVBYd2M1MC9MamR6?=
 =?utf-8?B?VGpqU1QxT3Nxc2EyYjExV29Fck5zeC9OODRpL1VlNlJVUXkyN3VlRjVwT0Jh?=
 =?utf-8?B?clhqRjJQRzJ4blE4VmdHdDVWUFUyU2F3RCtQa1g2bkF5VkYwL2ZsbWppaXQw?=
 =?utf-8?B?SnZQaVBOdmwxUGJRKzhjSUZPNHRFdGZTblMzYkZLNUsySDNTU2YzNWhJaXVj?=
 =?utf-8?B?aWFlaWp6WEtJd1VjbVdwcVd0eDVjSXYwUWxpeG1CVW5wNndrelV1UFljdDZK?=
 =?utf-8?B?OWhVNE8wbTNoZXhPeU9DVGFZOUp0VU8yQjFIalhwTjBDTWhuQVQzNERvS3BW?=
 =?utf-8?Q?aSe4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b12cf906-96eb-466e-8945-08db305b3ab6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 13:40:58.7374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4/0n4k1C9HYE69soBw1FwJm7NGchkSW6p2rLhNTokj5qxpMmCru0mvxTieKSSCiWmwBA84G5Mvzyuww6c3CQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6479
X-OriginatorOrg: intel.com

DQpIaSwNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFvbHUgTHUgPGJh
b2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAyOSwgMjAy
MyA5OjMxIFBNDQo+IFRvOiBaaGFuZywgVGluYSA8dGluYS56aGFuZ0BpbnRlbC5jb20+OyBpb21t
dUBsaXN0cy5saW51eC5kZXYNCj4gQ2M6IGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbTsgTWEsIFlv
bmd3ZWkgPHlvbmd3ZWkubWFAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNF0g
aW9tbXUvdnQtZDogRml4IG51bGwgcG9pbnRlciBhY2Nlc3MgaW4gaW52YWxpZGF0ZV9yYW5nZQ0K
PiBjYWxsYmFjaw0KPiANCj4gT24gMjAyMy8zLzI5IDIwOjQ2LCBUaW5hIFpoYW5nIHdyb3RlOg0K
PiA+IEFkZCB0aGUgbWlzc2luZyBjaGVjayB0byBhdm9pZCBudWxsIHBvaW50ZXIgZGVyZWZlcmVu
Y2UuDQo+ID4NCj4gPiBUaGUgcGF0Y2ggZml4ZXMgYmVsb3cgaXNzdWUgcmVwb3J0ZWQgYnkga2xv
Y3dvcmsgdG9vbDoNCj4gPiBQb2ludGVyICdpbmZvJyByZXR1cm5lZCBmcm9tIGNhbGwgdG8gZnVu
Y3Rpb24gJ2Rldl9pb21tdV9wcml2X2dldCcNCj4gPiBhdCBsaW5lIDE4MCBtYXkgYmUgTlVMTCBh
bmQgbWF5IGJlIGRlcmVmZXJlbmNlZCBhdCBsaW5lIDE4Ni4NCj4gPg0KPiA+IFRoaXMgcGF0Y2gg
Y2FuIGZpeCBhIHBvdGVudGlhbCBudWxsIHBvaW50ZXIgZGVyZWZlcmVuY2UgaXNzdWUgb2YNCj4g
PiByZWxlYXNpbmcgYSBkZXZpY2Ugd29ya2luZyBpbiBzdm0gbW9kZS4NCj4gDQo+IFRoZSBzdm0g
bG9naWMgZ3VhcmFudGVlcyB0aGF0IF9fZmx1c2hfc3ZtX3JhbmdlX2RldigpIG9ubHkgYmUgY2Fs
bGVkIGFmdGVyDQo+IGlvbW11X3N2YV9iaW5kX2RldmljZSgpIGFuZCBiZWZvcmUgaW9tbXVfc3Zh
X3VuYmluZF9kZXZpY2UoKS4gVGh1cyBAaW5mbw0KPiBzaG91bGQgbmV2ZXIgYmUgTlVMTC4gVGhl
cmUncyBubyBuZWVkIHRvIGFkZCB0aGlzIGNoZWNrLg0KWWVzLCBpZiB0aGUgb3JkZXIgY2FuIGJl
IGVuc3VyZWQsIG5vIG5lZWQgdG8gd29ycnkgYWJvdXQgdGhlIG51bGwgcG9pbnRlci4gSG93IGFi
b3V0IGhvdC1wbHVnZ2luZyBkZXZpY2VzPyBDYW4gd2Uga2VlcCB0aGUgb3JkZXIgYWxsIHRoZSB0
aW1lPyBPdGhlcndpc2UsIGl0IHNlZW1zIGFkZGluZyBhIG51bGwgY2hlY2sgbWFrZXMgc2Vuc2Uu
DQoNClJlZ2FyZHMsDQotVGluYQ0KDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gYmFvbHUNCj4g
DQo+ID4NCj4gPiBSZXBvcnRlZC1ieTogWW9uZ3dlaSBNYSA8eW9uZ3dlaS5tYUBpbnRlbC5jb20+
DQo+ID4gU2lnbmVkLW9mZi1ieTogVGluYSBaaGFuZyA8dGluYS56aGFuZ0BpbnRlbC5jb20+DQo+
ID4gLS0tDQo+ID4gICBkcml2ZXJzL2lvbW11L2ludGVsL3N2bS5jIHwgMiArLQ0KPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9zdm0uYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwv
c3ZtLmMNCj4gPiBpbmRleCA3MzY3ZjU2YzNiYWQuLjgzN2MxYTQ2NDJlNyAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL3N2bS5jDQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9p
bnRlbC9zdm0uYw0KPiA+IEBAIC0xNzksNyArMTc5LDcgQEAgc3RhdGljIHZvaWQgX19mbHVzaF9z
dm1fcmFuZ2VfZGV2KHN0cnVjdCBpbnRlbF9zdm0NCj4gKnN2bSwNCj4gPiAgIHsNCj4gPiAgIAlz
dHJ1Y3QgZGV2aWNlX2RvbWFpbl9pbmZvICppbmZvID0gZGV2X2lvbW11X3ByaXZfZ2V0KHNkZXYt
PmRldik7DQo+ID4NCj4gPiAtCWlmIChXQVJOX09OKCFwYWdlcykpDQo+ID4gKwlpZiAoV0FSTl9P
TighaW5mbyB8fCAhcGFnZXMpKQ0KPiA+ICAgCQlyZXR1cm47DQo+ID4NCj4gPiAgIAlxaV9mbHVz
aF9waW90bGIoc2Rldi0+aW9tbXUsIHNkZXYtPmRpZCwgc3ZtLT5wYXNpZCwgYWRkcmVzcywgcGFn
ZXMsDQo+ID4gaWgpOw0KDQo=
