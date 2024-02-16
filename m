Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472ECD27A
	for <iommu@lists.linux.dev>; Fri, 16 Feb 2024 03:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708054133; cv=fail; b=YUBG9gLcDNyvif0tGNEfJEd9aZ4/COLITszBI1qzbsLy4mbclF/N1p2ltZlSqs1YzcuMdPGOTO0aPy1/3pn0kiQeY7Dyb4WpPdHglmjB8/ewzi0Cw6EGIvTFd/xCv45omuAz7S1voOn3T6G6ceSc0XgSJVkaRrxX/orv7JuYsfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708054133; c=relaxed/simple;
	bh=0v1gaee917z10iv02Vx7fcSXZZgRiOobZf0i0YMz9IM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bxAg+GtlDAbGl02eIBe3FJMmg+io3eS+Kb9aLa/VS8VXxroe4KCrnODNufyORhCN/lxNAgJ0Erjq/Qtejrz8i4TkrATLl1V/pITWJuaZwUsg3mxFfe0Xjk6qAKFiHPN5vh+lw1CgGBJMN0NuFrhb3o7pjLqfdsINJ8QGs3EA3qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O91AQFpT; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O91AQFpT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708054124; x=1739590124;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0v1gaee917z10iv02Vx7fcSXZZgRiOobZf0i0YMz9IM=;
  b=O91AQFpTN1Kaz5jTfAV9MmnO5UCYeRyWr/iuKsS5SBKfg0rYqdBv8KfT
   vGLMcbBN5jgPmNhd1xqB0vvyjzt54+6dg27/INJ3xZzRRSp++M+YYKjHq
   EoX03f8mCom1Aqd6zQvBoJ5VidoxYIP4kCE+XIO3z6fhI7VrgDfCpFVFD
   v54Wg+AR4f/RzH3cGcTBBbNWiTwNK5ksc0ZDSidTWVLUcqeKlw/0yU3L7
   5g62Sma6FjbYLnzpHkbcefRKYNEjHyNuuNThHB9xjhuwLzOWpb3I8IQUw
   NXTgxlCGhqlVp7KB7EU4rUQWOG3VOwU0m3CbpYWfUMpsPWit7y11GHEoB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="12893210"
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="12893210"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 19:28:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="8384504"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2024 19:28:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 19:28:37 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 19:28:37 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 19:28:37 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 19:28:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2QHiTRJxxiwgpz5rGykd/4q/pQn6b7HOZmoIdQ070zXlCyZ0HeJTbqK6StunnUXzxv5mb+toOfr5pbxx+7yTTMV7K0UZ/YklAzmaBndnFxXoKK5pvaNM+wOWPGOQPwmYHOkZEQbxaSPM3wriJecdfT54vkSQDbsHQ4bQ7gqKjbMP6bvc+hnqGwJwwQ6ysLPgcqwgHf30K8KE+VkqxfdHwvx8YP0WhZdyW80egKFbCYkFavveVLVvU0EKOemfS0E0Y/tGAPTqbEckPqBSNpxwJpm8J3JNHlzuyw8QIvI4sO+dcNBw3LPBfno+l6oex6bDi62vUqfZbeHPkIU1Wr0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0v1gaee917z10iv02Vx7fcSXZZgRiOobZf0i0YMz9IM=;
 b=I75xTFPX49TD8VHM9ticximw/e3OMOG5qoHIMMBIHAcVmIAIsc0zQAH8Pao818DV/cJJLs9Dt75EZhLqgQFbJ2qifbYyYyRwBh43ifADBm0tkdKMT0H5BiazM5yUblCUyWHeuixlWlxM1y3FtOm6fCipDUAmcXijG8NjqhSVTv91hVT3TidsT5/v3QD9RbHwvwgqiIviiPUqH2NcNQTeXINxJJQD+kZqbuEED/BtXPJn6HV7m3Rx4hmm3vZIALtuT0GpyUag93khGgx0sKjmmeZ0Jy0NFtcgR0wmrwEqehngyW+wnbFApRdt/lHww0R4LiZXA5RYAzLlbQvXgrVoLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by BL3PR11MB6529.namprd11.prod.outlook.com (2603:10b6:208:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 03:28:35 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::2e1e:4cf0:f8ea:a9c7]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::2e1e:4cf0:f8ea:a9c7%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 03:28:35 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: "Zhang, Tina" <tina.zhang@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [PATCH 04/11] iommu/vt-d: Retire struct intel_svm_dev
Thread-Topic: [PATCH 04/11] iommu/vt-d: Retire struct intel_svm_dev
Thread-Index: AQHaSBkoMQFixBdvFkK59puPCgq3ebDdmzwAgBQd8TCAGrqAoA==
Date: Fri, 16 Feb 2024 03:28:34 +0000
Message-ID: <MW5PR11MB5881FAE61F0911A714C8590E894C2@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20240116011146.18645-1-tina.zhang@intel.com>
 <20240116011146.18645-5-tina.zhang@intel.com>
 <e0bd9c46-f4c8-4082-b0f3-3f841d04b7df@linux.intel.com>
 <MW5PR11MB58814990778EE5643C329A7A897D2@MW5PR11MB5881.namprd11.prod.outlook.com>
In-Reply-To: <MW5PR11MB58814990778EE5643C329A7A897D2@MW5PR11MB5881.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|BL3PR11MB6529:EE_
x-ms-office365-filtering-correlation-id: 166647ca-db77-4f77-4234-08dc2e9f5b8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t2FEBcnMNzlDQkP+VqEiE2s5eZs6IRtpInyV7Suyk/vW2TkqcFqwYG7c3WSyy6wADQRsv9oo9JpeS6bbOx/unFHl+Dhd0n4J2NaSwf4+45FKNWGznF8qNaoHkW8iySD8D/1IqJuuQ/gmN5yo170Lmp4I1QTZD5yw/Ki2nOd38t4cia17zKT/kVLhJ+OLYnGzEtWlC9H0RA4OMfkwcDBnqe9E4XWZ08MaWqKaQbM2HYl5c1kVdAbYi6r4QL0JP1DwKZcMBhGj+D5fCr8i8PBZ2tFG1J94u4bV7hSI7vv/fAjAgyIESvCAh96h2+pUVQx2RBeVUhIhKu6+68gb7j0UCsd9o1OthWoRLbORb/1jBmfwvZQYZpFkmnD92ldjQGecTpn4arUuRrZ60t27Tx8n/YWXZfCZIyME92ACJEH8ZMbR2mNPCQofSmSE8k7qM3Pm1EMZf5DoElY5WNqUbR1mCqx7jbC6iQHn9AYMDoMti1pvYJHvzv3pXQTa9IRAIbT5IMbCSuVlHVk3AQYFpJp33AKBnAXe8t24lrgvpER7wGEuMKHQET1luJbFLdHMZ5N+2/a9IqBa4RWQGkCxBlCUEjn85pIYex2ALLWEXFb1UymQ6drKAk8boazAwyUOquTk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38070700009)(66556008)(4326008)(26005)(83380400001)(8676002)(41300700001)(316002)(64756008)(76116006)(8936002)(52536014)(66946007)(478600001)(66476007)(66446008)(53546011)(71200400001)(7696005)(9686003)(6506007)(110136005)(38100700002)(33656002)(122000001)(86362001)(82960400001)(55016003)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDdWOGhCZ1k4VlBIc1JxWStBT2lOaDlBNEpRcGpQZVNyOVJwZ0s2c0g3Y2l2?=
 =?utf-8?B?VW5MbTRMZUI0bXV3bFpqRzFwWTkrQkpFMjNLVUtwcWJVOFlybDB2a3FwRGtC?=
 =?utf-8?B?UUIyNVdaaEQvTFdlTFhSSFBmaS9UL1RPYWl3TTBESFlncUNYK0UwN21rY3k0?=
 =?utf-8?B?WEw3bS82b0hoYjEzMk5UTEVDTjZFQ0x3WHJmWHgrQ2ZuajB2QndBbzJGMGhn?=
 =?utf-8?B?a0NNeG9XRXVVUlBpcU1qSGJEbmNFdXhabjQ1NHF5eGZvUjhsb3pPZDY3Q1Bw?=
 =?utf-8?B?UERwMFFwRk0xL2ZtVTJnczl3VHNZelpabVNpWTFiZVp4U2h5M0dlK0hUYTZI?=
 =?utf-8?B?U1daNEdLNVZuY1Rqa1NrRTZndC9rdGRsOENnRGcrWFZBVXRSTXEyNXNuYXBo?=
 =?utf-8?B?T1h5dmU1cFROWnMvWCtGeUw2SzdTMy8ya1F4YjVGRWp6dXJnbkZHOG9aWllD?=
 =?utf-8?B?bWRIU2pxeDZxM0pyeWxWSWUwZ1hSSnB2eEg4eEYwdFRzd2M3VytCdlF6SEFi?=
 =?utf-8?B?TFdnMjhBUkRCeXN6blBVYUlOeWhFSHFNOVhQVngzSGgxNGg2cDhFcktSdS9m?=
 =?utf-8?B?RFAranR4dFRkMzlCWjNSb2NKZVFQYnhqSHZwZEFPMnZvMk1BYXIxTllqbzJJ?=
 =?utf-8?B?d0lvQnpRSWsrcy8zaFg4dFBvY0RiRTJNUllMZVgwWFJCNXJCUmh5b3ZINGly?=
 =?utf-8?B?aStpQjZKaFBYSko3NC9KNS9uOVR1NGdnYkZxTXkxYUJKZFNmdkhJWU9QbWZi?=
 =?utf-8?B?aDNmT1JoV2Judm1WRXBnL0xIN2o3YmJkUUtzbnlnTDBQdHFBT1ZnZEx6ZDNM?=
 =?utf-8?B?LzRwaE9tM0Rod0dIVXR2S0xhcnhkL2Zpd0cwODFHeEhSVytoYjNNNUVFYWo0?=
 =?utf-8?B?R1RyTnAzOGJqZHdSYUIyM1lmTGk2bDhIRTJaYlNaY3Y3bE9tSGhGdmVNWXNT?=
 =?utf-8?B?c3NvRVYrQkcrTXE2TVFCaW0zd2hSUC9maTdZL3hJajh5NzZ2eWRaOXluY0Uw?=
 =?utf-8?B?ZlQ4SHFPMlIyZTNsYndEbmhrZDRybTF3U25WNlAwejRmdHZoMFZibEdoQ1Nk?=
 =?utf-8?B?NTU4V0xCZFFoU0dhOUJ5bVdseTQvZUJCc3EvK0RCN29yZTU0aGVYTDAvZWYy?=
 =?utf-8?B?aks2SVdGci9WR3JCNC9YWFV6UHJTSGJtZHFhZUhtYW1MY3pxUlJ1cWpUQzBF?=
 =?utf-8?B?aFNUcVhsNVN5WkVXRFl5ZGFHeGRMZyt4dlhUVVZyYUNkNjZTSGRFdTZxUFll?=
 =?utf-8?B?VXRFQWtLbWhpV0p2V1AzQmgveGNtSFQ0eVRpRk93R0FRWG9jbEN3ZVlSQnhL?=
 =?utf-8?B?dHAreUtoNm5xNU9lT3NLYVpMcUtsTU5aTzE4MFVyMldaYnQwaGNOR1NhbWNR?=
 =?utf-8?B?cjVIazhpNmk2VzhONlVsOWcwcXhpbVlqSUkrdE9tZWdqbTlPbVNEV3JOZlhn?=
 =?utf-8?B?QXNkVmtYUy90enBDYlpjTXRGLzZrYWxPR201TmlMb1E3MlBDY3R1UVg4OHdy?=
 =?utf-8?B?SzZZWlRVQndyMHpXRCtwc2s0TktPYTNqU1ppSytnVUhUU3pmZU9tZUVncFdD?=
 =?utf-8?B?dVlGOS95QWN2NmM5M2paY1FIdGdEYWZ2T3FmZ2RQS0p0VnZhYVV3dFdFUldX?=
 =?utf-8?B?YnFwM2VsKzA3ekQ0dnpSSll1VkJHWXFUNm4zMkxWc2Jsc3dDc2V6TStaakVo?=
 =?utf-8?B?T3Y2WGxyd1piY0VJelFvTHBTZTBzMUcybk43cHAwcnppNG9RRmpqTUY3RnBP?=
 =?utf-8?B?WUZWVllzb29pQXhhZ3A1SVIyMjVtT0RZbkRUVjN0dXZnU0FZRkVVaGZmcUQ3?=
 =?utf-8?B?SDRQMEhjUnU0SitxcWJiOWFPaExmUmN3SlhGNUtld0E0UklSSnlkOVhuZ0hq?=
 =?utf-8?B?bTVzU09Gbmp4UkZFdVlFcUt6NFpTaVN2aXdqM0I0Y2pIclVVU1ZKMlFHam1y?=
 =?utf-8?B?bFd1U3BOWWYyZXl0VEZhTjI2WWR6NWJYcFc2aFc2Q2p2MktwQ2p1WlJIYmFM?=
 =?utf-8?B?ekU4SGs5WitsYW4zYXJuRGZSMWp2cGIwQjlHZ3N3eVhObmhnTUVZajExSVB0?=
 =?utf-8?B?QlJjWUNMUlc0VHB0aTN4SHVjcHVvWktvVkVSbVJLV1NLbnNKK01aakJSaExJ?=
 =?utf-8?Q?oZV4/a0ctBxUKexueezSZlDMK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 166647ca-db77-4f77-4234-08dc2e9f5b8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 03:28:35.0154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S82jHpJbR/v+tuUiPytwijHXC/EG74YylMoitDGOWMu0KAEXxRvH3OdJDLXtp+A3FfzNFyw9bZ3w01od7zjfDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6529
X-OriginatorOrg: intel.com

SGkgQmFvbHUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmhhbmcs
IFRpbmEgPHRpbmEuemhhbmdAaW50ZWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDMw
LCAyMDI0IDExOjA1IEFNDQo+IFRvOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29t
PjsgaW9tbXVAbGlzdHMubGludXguZGV2DQo+IENjOiBUaWFuLCBLZXZpbiA8a2V2aW4udGlhbkBp
bnRlbC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMDQvMTFdIGlvbW11L3Z0LWQ6IFJldGly
ZSBzdHJ1Y3QgaW50ZWxfc3ZtX2Rldg0KPiANCj4gSGkgQmFvbHUsDQo+IA0KPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogQmFvbHUgTHUgPGJhb2x1Lmx1QGxpbnV4Lmlu
dGVsLmNvbT4NCj4gPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMTcsIDIwMjQgMzoyMSBQTQ0K
PiA+IFRvOiBaaGFuZywgVGluYSA8dGluYS56aGFuZ0BpbnRlbC5jb20+OyBpb21tdUBsaXN0cy5s
aW51eC5kZXYNCj4gPiBDYzogYmFvbHUubHVAbGludXguaW50ZWwuY29tOyBUaWFuLCBLZXZpbiA8
a2V2aW4udGlhbkBpbnRlbC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAwNC8xMV0gaW9t
bXUvdnQtZDogUmV0aXJlIHN0cnVjdCBpbnRlbF9zdm1fZGV2DQo+ID4NCj4gPiBPbiAyMDI0LzEv
MTYgOToxMSwgVGluYSBaaGFuZyB3cm90ZToNCj4gPiA+IFRoZSBzdHJ1Y3QgZGV2X3Bhc2lkX2lu
Zm8gaXMgdXNlZCBieSBJT01NVSBkb21haW4gdG8ga2VlcCBwYXNpZCBpbmZvDQo+ID4gPiBvZiBh
dHRhY2hlZCBkZXZpY2UuIEZvciBzdmEgZG9tYWluLCB0aGVyZSBpcyBhbm90aGVyIHN0cnVjdHVy
ZSB3aGljaA0KPiA+ID4ga2VlcHMgaW5mbyBvZiBhdHRhY2hlZCBkZXZpY2UsIG5hbWVkIGludGVs
X3N2bV9kZXYuIEluc3RlYWQgb2YgdXNpbmcNCj4gPiA+IHR3byBzdHJ1Y3RzIGZvciB0aGUgc2Ft
ZSBwdXJwb3NlLCB0aGUgc3RydWN0IGRldl9wYXNpZF9pbmZvIGNhbiB3b3JrDQo+ID4gPiBmb3Ig
Ym90aCBzdmEgZG9tYWluIGFuZCBJT01NVSBkb21haW4uIEFzIGEgcmVzdWx0LCBzdHJ1Y3QNCj4g
PiA+IGludGVsX3N2bV9kZXYNCj4gPiBnZXRzIHJldGlyZWQuDQo+ID4gPg0KPiA+ID4gVGhlIHJj
dS9kaWQvc2lkL3FkZXAgZmllbGRzIG9mIHN0cnVjdCBpbnRlbF9zdm1fZGV2IGFyZSBtb3ZlZCBm
cm9tDQo+ID4gPiBzdHJ1Y3QgaW50ZWxfc3ZtX2RldiBpbnRvIHN0cnVjdCBkZXZfcGFzaWRfaW5m
by4gQmVzaWRlcywgdGhlIG5hbWVzDQo+ID4gPiBvZiBmdW5jdGlvbnMgd2hpY2ggYXJlIHJlbGF0
ZWQgdG8gc3RydWN0IGludGVsX3N2bV9kZXYgZ2V0IGNoYW5nZWQNCj4gPiA+IHRvDQo+ID4gZGV2
X3Bhc2lkX2luZm8uDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogVGluYSBaaGFuZzx0aW5h
LnpoYW5nQGludGVsLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gICBkcml2ZXJzL2lvbW11L2ludGVs
L2lvbW11LmggfCAgMTEgKy0tLQ0KPiA+ID4gICBkcml2ZXJzL2lvbW11L2ludGVsL3N2bS5jICAg
fCAxMTAgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiAgIDIgZmls
ZXMgY2hhbmdlZCwgNTcgaW5zZXJ0aW9ucygrKSwgNjQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBJ
IGxpa2UgdGhlIGRpcmVjdGlvbiB0aGF0IHRoaXMgcGF0Y2ggaXMgdGFraW5nLiBJIGFncmVlIHRo
YXQNCj4gPiBpbnRlbF9zdm1fZGV2IHNob3VsZCBiZSByZXBsYWNlZCB3aXRoIGRldl9wYXNpZF9p
bmZvLiBIb3dldmVyLCBzaW5jZQ0KPiA+IGRldl9wYXNpZF9pbmZvIGlzIHByb3RlY3RlZCBieQ0K
PiA+IGRvbWFpbi0+bG9jayBhbmQgaW50ZWxfc3ZtX2RldiBpcyBwcm90ZWN0ZWQgYnkgUkNVLCBJ
IHJlY29tbWVuZA0KPiA+IGRvbWFpbi0+c3BsaXR0aW5nIHRoaXMNCj4gPiBjaGFuZ2UgaW50byB0
d28gcGF0Y2hlczoNCj4gPg0KPiA+IC0gVGhlIGZpcnN0IHBhdGNoIHdvdWxkIG1vZGlmeSB0aGUg
Y29kZSB0byB1c2UgZG9tYWluLT5sb2NrIHRvIHByb3RlY3QNCj4gPiAgICBpbnRlbF9zdm1fZGV2
Lg0KPiA+IC0gVGhlIHNlY29uZCBwYXRjaCB3b3VsZCB0aGVuIHBlcmZvcm0gdGhlIGFjdHVhbCBy
ZXBsYWNlbWVudCBvZg0KPiA+ICAgIGludGVsX3N2bV9kZXYgd2l0aCBkZXZfcGFzaWRfaW5mby4N
Cj4gVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4gU291bmRzIGxpa2UgcmVwbGFjaW5nIFJDVSB3
aXRoIGRvbWFpbi0+bG9jayBpcyBhDQo+IGdvb2QgaWRlYS4gSSdsbCBpbmNsdWRlIGl0IGluIHRo
ZSBuZXh0IHZlcnNpb24gb2YgdGhpcyBwYXRjaC4NCkFmdGVyIHJldGhpbmtpbmcgYWJvdXQgdGhl
IGlkZWEgb2YgdXNpbmcgZG9tYWluLT5sb2NrIGZvciBzdmEgZG9tYWluIGluc3RlYWQgb2YgUkNV
LCBJIGhhdmUgYSBjb25jZXJuIHRoYXQgd2UgbWF5IGVuZCB1cCB3aXRoIHNhY3JpZmljaW5nIHBl
cmZvcm1hbmNlLCBhcyBzcGluX2xvY2soKS9zcGluX3VubG9jaygpIGlzIGhlYXZpZXIgdGhhbiBy
Y3VfcmVhZF9sb2NrKCkvcmN1X3JlYWRfdW5sb2NrKCkuDQoNClRoZSBhcmNoX2ludmFsaWRhdGVf
c2Vjb25kYXJ5X3RsYnMoKSBjYWxsYmFjaywgd2hpY2ggaXMgdGhlIHJlYWRlciBvZiBkZXZfcGFz
aWRfaW5mbyBsaXN0LCBjb3VsZCBiZSBpbnZva2VkIG9uIGEgaG90IHBhdGguICBJZiB0aGlzIGlz
IHRoZSBjYXNlLCB3ZSBtYXkgZXhwZWN0IHRoZSBkZXZfcGFzaWRfaW5mbyBsaXN0IGl0c2VsZiBh
cyB3ZWxsIGFzIHRoZSBkYXRhIGVsZW1lbnQgbGlzdGVkIGluIHRoZSBsaXN0IGNvdWxkIGJlIGFj
Y2Vzc2VkIGNvbmN1cnJlbnRseSB3aXRoIGFuIHVwZGF0ZXIgZm9yIGJldHRlciBwZXJmb3JtYW5j
ZS4gVGhhdCdzIHRoZSBwbGFjZSBSQ1UgY2FuIGhlbHAuIEJlc2lkZXMsIHdlIGFsc28gbmVlZCB0
byB1c2Ugc3BpbiBsb2NrIGJldHdlZW4gdGhlIHVwZGF0ZXJzIHRvIGVuc3VyZSB0aGVyZSBpcyBv
bmx5IG9uZSB1cGRhdGVyIGVhY2ggdGltZS4NCg0KUmVnYXJkcywNCi1UaW5hDQoNCj4gDQo+IFJl
Z2FyZHMsDQo+IC1UaW5hDQo+IA0KPiA+DQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+IGJhb2x1DQo=
