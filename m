Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB68B10F9
	for <iommu@lists.linux.dev>; Tue, 20 Sep 2022 07:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663658676; x=1695194676;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2vW8KGO0QG9QeHoWxeKlYwup4js7OMhDUcwB/akMWzQ=;
  b=TjQtxKdDJDtYrJ41HampreTQ2SCrh0CJ473jDS0wjxPDH2Bhmj0bxxO/
   XOd9PWe3o+ucLpDM7C3NmrWjSnaCnM9M9Oevli8iXLvwSJSmxD66qXb+B
   g9xbXFaNPq9PyoPpxHOnvBX3aW5vuWWCV/y9uOAJ3nffvz0vrpGzxj8zN
   DMldttdiU3Vgect1q9iqAfZpQpqqAO66Kn9i6cvPvLYPZ6N1pLSSKCdCw
   mQEn2EFX0hKu5TB2olMU+X93ft9deCTmgLn05dZz1Njfyy1rp4nPW0kBD
   laPV3gS/0UP7cnoV8XWD4hh87DF5BIk6PCF/vgFycP5N/lJxZBZ+J74tP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="361360353"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="361360353"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 00:24:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="681182725"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 20 Sep 2022 00:24:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 00:24:35 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 00:24:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 20 Sep 2022 00:24:35 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 20 Sep 2022 00:24:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3EmhrzznQTM9VyD9OvC77p9pZpMM92ThwaLdnl73SRLwbgk5ciy15MlTZUjmFws8oa8QD+I/7XDCHgKde0Egr/pPfZ1YhHxjgWvHwmMtXiaVMDq3fyBphqPVvb9sBnc2OvgxsOJFnoz8LUTroKnSqF+S/GIaC9BQ1ScXzJutwcNfBcfJLtRFchvuaBM3Kz/gC1APtGeknK1mL86vRPTYz+1upP0bNGmBkzPhC8o1uNoNEGUg5PS4sSVqp1rCUPsP+cjFk9n0qBO1lLix4g3WrtKNVJFFzCOU9kzfb18BuXcRKAyMmM3nzapdwVxpxEaWh+Zzt8zf5v+tsuJquDdUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vW8KGO0QG9QeHoWxeKlYwup4js7OMhDUcwB/akMWzQ=;
 b=S9dyLb810aUZ5/DphMgc9H1su0KOjvEoxSa56b4O8xMpItmAoqoRpI9rmkcb7gCJEiEdkH2TsmmCp/8hgv/91nm2oBH0agxfdTK+vAEbGvwDlyMecgAgw+JFnvW1sNAvxLeCD6e4VZrXVQq2rDsncxU3a522Fc1TRxkvmCav22MQfEG9Z6RuXJu4U7clLblhf1bNMgbymOh3ciMsOHjacHWeuR+0X3pHbV4E2jyhst21QAOxR8VrYTud/tO4p+BLEaR/OK+PvM7FNb45UAd+WPvPNfZWz948lThojwK2wWsl0+7SdqUo/eVBnd+q4KEd870HAzqxInF58RlsOA9iqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4911.namprd11.prod.outlook.com (2603:10b6:a03:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 07:24:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5632.019; Tue, 20 Sep 2022
 07:24:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "Lu, Baolu" <baolu.lu@intel.com>, "Srinivasan, Raghunathan"
	<raghunathan.srinivasan@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH 2/2] iommu/vt-d: Rename cap_5lp_support to
 cap_fl5lp_support
Thread-Topic: [PATCH 2/2] iommu/vt-d: Rename cap_5lp_support to
 cap_fl5lp_support
Thread-Index: AQHYyZvVLKnmV5BAyU2OwgCg3VeH8q3n8MCQ
Date: Tue, 20 Sep 2022 07:24:31 +0000
Message-ID: <BN9PR11MB5276F062B5C0C08F10EFB49F8C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220916071326.2223901-1-yi.l.liu@intel.com>
In-Reply-To: <20220916071326.2223901-1-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB4911:EE_
x-ms-office365-filtering-correlation-id: 250b8d85-5489-40f5-7b13-08da9ad9295c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8qWG0nW4fST3mFtlKLhpN3JcQCAeTfhsisg5hJ+Z4pTGxSrXxAQ4yWiRZqaclXow/EIxgZB2I5GgKghLH20XJabRwnwaTtRpif+8dFGRe8NWycTHF09UX1cJk9EYcu3zoe96NMt1oc9TxZ7KK/Tays+k7anTRsL9Y8x8rv6rpxyrxBJCZhsJTmU0iKH3meYmKofFqZU02ZdIx19bURNoZOktbnVcPUJ+M8uqVJBXxFmauXNThixsntt7LRnZi1HWTMdYu5fCa1xR+Qk7jFy74pu/l988MAPrg0L9A/a6aM+GiQBgkksQHF/ojtSONu53OVmMHT9iAAUuGcjsm5CoGxNTpipSZ/cnoFxhHpcEcIuoy0KxBPTzCRm1HusFU4Jo/fN+jSgPqyzrLCd3hn/voGRjsZMLsiVcHUov4m12A8NuR5clXPn9zbJcduiRE30K1bd8krfPgurywykbM1sGG2tHyRRH0joDV+rw+377kEpQTpmlwIeobLd0A6oP+TBzgdu1oxuRsozD92PtB0SZ+jtTQm0A9AIbiKz/wDvt53sV9LC151GHaqYe0IOO1FTIi+JqTHQyBJtTksqjO6PW4BW0cMvGlO6kQhrb4BZbm8nZC8HMGw3DaW1G7PACywK/6qRFverisSnVa7eJMkjmYGE6lUpAVyIpF4a89EodsTQigS1pno44NCusews8wT0JRcoAyQD9ibW4RQHeCOU4bGRazZa3syc9K1w5HXa7hf9LDKg21sMYCGx62BKCvtFl4GbpfTnjsn/lp+D2Tok9ZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199015)(38100700002)(110136005)(38070700005)(54906003)(86362001)(2906002)(316002)(478600001)(9686003)(26005)(55016003)(7696005)(558084003)(41300700001)(6506007)(71200400001)(33656002)(186003)(122000001)(82960400001)(66446008)(76116006)(8676002)(4326008)(5660300002)(8936002)(66946007)(52536014)(64756008)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3WZKC17eMPzNoDJIBz2xbNqeEAk+XxeakBbmmA6d7bIqHZHI6O6X7d3lM3VT?=
 =?us-ascii?Q?rle5azh4CeBHw2cICQx4j54SlTeyWok/9DHfwk8jV444pNmVJfVrJ7mGJ2gr?=
 =?us-ascii?Q?JvGr4joJScT6ph5ehppW6ThtrO2tebnhKXq5hir7yuK+nwWWNDZN+1JERHYu?=
 =?us-ascii?Q?6IQWsooYZDYnALSyklOJ/PzGw5V2ZCXlAfM6/QOMlak8X/eTMP3WqJycp6tE?=
 =?us-ascii?Q?mm5xok4pw3ASdya4GgCYoVNaB/mcjFZfUdJdsffSIm4576eH3XaXSMUHK9F0?=
 =?us-ascii?Q?EUhNFQ+8qpjWWKy9If777mvJE4rqX6ptpduEFqvUOE1O8LanF6t9nsWV2TVK?=
 =?us-ascii?Q?DKwAnzCJb+/rIKmylS65O5NWDN/VstXywIa7XYFvaONNDrVdTuisW2oNC3G0?=
 =?us-ascii?Q?ucRgy7MfVjbZ4mACCIwDkPDV+oJFciJERQb16Jb4lvO9JAw6vuKtSRBOo2Pi?=
 =?us-ascii?Q?UWVBglfNRHCBbL+7LD+6AHCzzW2US+9OHLIv5eWQ4SmodSf+UmY7aCtqLuww?=
 =?us-ascii?Q?DJmAYVuYAYxzyzYxA5yxHm2SRDJ54cs8CJoZ79rZ36PFKa0V+/3dpxkANoV5?=
 =?us-ascii?Q?LfKD0bFAVD3VNdJksktyd1sr004lmcOnogyJExtMQaKRPH5H8Pehk4qitWG1?=
 =?us-ascii?Q?jy63WKdd4kGP+7DUK0e0YckX1p7chgPCgQvoVblInKXWB+yfju5VAI3cCkrQ?=
 =?us-ascii?Q?14ixQ+18PYivg/r+wTz8So3HKr8CBNUP/hBrOxJwKLo9eQAR5XiQg10V8IfL?=
 =?us-ascii?Q?VtCdgDV+wBV9WH8bkdJJEHVmL2Ul7p3nsGcbtHT7DTlLIHS9PHZpwd118znK?=
 =?us-ascii?Q?eNyjqIKkyTpqvnWXqOv+rJzKVJCvVCB3HARajLQRR1l4J8gU/57V6EGs4lDf?=
 =?us-ascii?Q?7NeYsQHTpqjuRCJ44I4+653SKf09KwimfQKLOmVCDiPtjRKbqgXqc7pvnhld?=
 =?us-ascii?Q?cnpAdOqMLSHEbcMj49thITVgt2nw79Xu3O/AbGGvSE7sR1211LIAWuPPAen+?=
 =?us-ascii?Q?D9mDp6Lu63B03NWXYOwgQaya+u0or3ShlWDpI3zw22pP853iJdFH7ne0l48M?=
 =?us-ascii?Q?sm2qH4qnbmu5xvwlZGnE72BE6+S1GjJ3guVmWI700KGPg4oOosnGm4O3VzKA?=
 =?us-ascii?Q?+HzhjdGFAnWC7OlIQ8FRegGf21og2bDIbimzF6oFjXKQTF6ZlEQWsBX1MWxy?=
 =?us-ascii?Q?TwgIPg1+CQ6snDUvGx3ngPv3FPQH76nmq5Ue+iiC364d3BjOQ0UHXPMJBeSd?=
 =?us-ascii?Q?J8fORKHVNhPSswJkxeDEa/+TGCKNe7iySXnNr45e7AwbGYvFg5oGJVuI/TBi?=
 =?us-ascii?Q?hoBI8BwsW73CGKjLY1sLnUiUPXDm7ukRngEZSQz1dRelWecfWsHqAmLqcX9j?=
 =?us-ascii?Q?VIfcBJo4ktE2Q930K0QFVDafswlx/KUdJ9VFjzu+E/W6jOHUqmr7G4+XOMsH?=
 =?us-ascii?Q?euqNfT/Bja9SmY8ig7Guv9V3ldwD7xmoR3q7S4sx0Wkd6/iywQf7PtIhquoy?=
 =?us-ascii?Q?CFNZLyOLf8UCIjulfQ7glsHHQ53xnNUfXBWNwkn2e1hl0co6yTdyCU44DiaA?=
 =?us-ascii?Q?X5mZgjGBRiYOmrecppOMIMtk5PfzKU3Xu9I/0Pdj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250b8d85-5489-40f5-7b13-08da9ad9295c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 07:24:31.8385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lpwqGX+9mjwSMOCfPV3UBfWUCU+/4W9+vTepz3T/3TO+ZhsPxyNlRy24nC1UByzzWjhgUgweTmm0PDBz6Baacw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4911
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Friday, September 16, 2022 3:13 PM
>=20
> This renaming better describes it is for first level page table (a.k.a
> first stage page table since VT-d spec 3.4).
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
