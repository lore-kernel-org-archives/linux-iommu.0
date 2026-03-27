Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3722E3D567E
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774600046; cv=fail; b=PHOm5lHXevP+xSD7zAxxbLwXNjTOwrXPhRTcJ6LYxDqbKL5/gLmDNgHDSVcbbpiulAMDEzpCHWo0RxGI+54sfkix2uTppv02GcHufDVv6Hd5NQw0QtT1mLzqk/gnlxqN9pPyHBwMg6ZQwR8KHHesOXMOot+XPB98hFZw39HUkqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774600046; c=relaxed/simple;
	bh=0PaVggWhHWIcYHGAO0/bR6g2KWenmX6CKGmLmAYMfuw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fP4yJhwYLEhzpwirLH6vIzyRZwKhY0stoeZyIh1J7rfB/6iILnwAVKiJQIDYfxtyMHm2tpA3lvh3dS7XryWfOBjsYg7WlGJZSNo9+Cy8I/XW5JPt3CsJjqZQAuVQu/tav7fPml6qvC7F5fu1ETbRFVDzvHsNM8CtLB6CJ1zOKKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ds4ymrFW; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ds4ymrFW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774600044; x=1806136044;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0PaVggWhHWIcYHGAO0/bR6g2KWenmX6CKGmLmAYMfuw=;
  b=Ds4ymrFWZvhiL3FRoniVv2gXt2ZIvaGYNl5/ho94hhuy5kFVbsoFbRqK
   CEZgkrfOXFpIHmJL1eOWeCuFVJtxxbAH8Q9VWCZz7XZ3emhg/NhR91SvO
   BdfsQkuvs67iw/y4dJTS6ywc6RRDluBgBsAEiSoV+IhL1r8Xuwa/q6LHw
   gFCRul8buZQyLIMAhfFi0AgEn5rM82DNs25aJZHfkMHvr568rC7FLgLoX
   hSQec0rgHKlFTBFim5rYW2NXlegiN/UUqMCpzlE6X4/78GRsRY7HhadQJ
   aNMUodnNmLYonSjUpF3UFmqbSRdX9LEsTQbcMWHN6u7P9A9x+ziMtDYNs
   g==;
X-CSE-ConnectionGUID: hzbxQd3vRYe4kudIz7epxw==
X-CSE-MsgGUID: OCoaXKs5Qva+3jrqWc7hFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75785321"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75785321"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 01:27:17 -0700
X-CSE-ConnectionGUID: BZ4T2edBTES/xKUeN62pIA==
X-CSE-MsgGUID: d0o5qqAcTTCWlJ5+jQ71gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="218632140"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 01:27:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 01:27:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 01:27:15 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 01:27:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oU7RWBIO6Bn0YK/hZkaXgYIYUOES0J1D+Gpl2DEfj9TqsVr/vdNC0ljQ1dcpby7EycJSzaXlW/KtAh/dUKI+1dSR1Iet6vR93KuqlxLS2XuVyMERSb7jvMg7caHZ8WP0ZoCU8uU+jTRmsJ7671G3aUumfbG0V8rqPbEziCkq5tTBMOGL8+BKd3URio2Bw/VDzta2H5Wc1/OReEBXcr94YeZUhH1Y8MyXt2OYNy6jB3FEl5ReFG9uLwXnr79RTXZt3dzeAMctvHXifOFHjfmA9oweIiTrmI+cjVy4PjjpnPtEIJSJ+QFr12e4YFhnswcQDpW6LvsT2BDQlYLBKONM0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PaVggWhHWIcYHGAO0/bR6g2KWenmX6CKGmLmAYMfuw=;
 b=eika9fu9LTJOhfaxEI4D7TEa78F/ngaaiwW5wOwyxVa2wzl8FBqZm+2ijm5mkfKptlZOB1BjGmdZWc1q6GTCFcTLdQc/3VgmcOA7lA8hvkUo1Z+/5bKwTTmEtIVJXtYzfpaSpfY4V4kd90R6pHkS+qB2TytmJjABMh6bMNbT69ZYxQ7dWBntlS4A5wxp2KBLnsqLOiXpbMfp4SzhksO9pbW0dbCFH2q9lhz238XuzK10rqcJs+1d5zs833UG61MBE42Svahh7IqyYpu2bQWnLPtdlLBnxoKBTkBReZswOMTvf+IWPwqdNujslQJvQYfFw1wRPMYYxyLkJg5tFSC/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB6828.namprd11.prod.outlook.com (2603:10b6:806:2a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 08:27:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 08:27:12 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Shuai Xue <xueshuai@linux.alibaba.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rc v2] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Thread-Topic: [PATCH rc v2] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Thread-Index: AQHct1nA8/bevmQlI06FieDQx+fC6rW1tF6AgACtTYCAC7R14A==
Date: Fri, 27 Mar 2026 08:27:12 +0000
Message-ID: <BN9PR11MB5276A9067B8D8FE3CB899B2F8C57A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260319043135.1153534-1-nicolinc@nvidia.com>
 <dd72f3be-16d9-4386-82ac-1b8e06186e3d@linux.alibaba.com>
 <abxr7XrsK1WSmr7T@Asurada-Nvidia>
In-Reply-To: <abxr7XrsK1WSmr7T@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB6828:EE_
x-ms-office365-filtering-correlation-id: 2d59ed27-9d2e-4fc9-e382-08de8bdaa51c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: c2cHcsT4Kesum/t9WvHnPOClN4U8J3X+yi2eypu23uCE1fXP1lSa3bOetKmJu7i/iGPe7YGIEmU7i6FNOgN/s+VZKuZrno14Npbv3YS9K+kQ8rWQvoTGpI6NOOBCi9BFQmQTyFD+xZ7LBbzrRIidVKiSo0u5fXXgnQZEFPJNUAusPGrCSn/dlRE+fgTQ2wUcCMusBhdImNxqSPAGGnyGgvbR2QYUg5MaNWxwA2mKh1lF1pbfOqNbmMhA8+FtootgZ7pYOJ/4Elm1l2BeedzierYgTKpOZw6/L+HS7VHvshOaMaS/R1/iFR3FCREPIizuoFFr1/lPD7j/iV3d6HCu5AWQy9UHs3BFaXichNxaGHA5jRJdeuVrJ873LCuPx1tLf1F+Yg9sImxtjy2hMjn/EMyPbLbX8Y48jeZ2H7bpQzOKSZJLM1MIetTriyTWlk4V9nuRFQD1Gn2cbIE18qXBa/70JpXQhjwr45ls5E87AvGjU2/Wq9opOBDBkkpHi19MHuBfpXXyWRyGPyt6FTLwjM/StC53GAeadByYHAQN6f3aZenbpVcr3mmwhSzUtozpNMf46a9q1Sv/sZcMbshGBALucc/KdWmgkk19EjcJAeHzcTOnj4auQRaQPihsDkqvvFSeXsPz3Rkh3ZgXwWTlSEs1HFX+alrjosQ6TBklmVhz6VL6s7FwMGphvOiXzhSA6ggWgCr5SUtYyT7o2Pl4aP+gfab9QyG+IRdLkEH512FEcSQMKGg/NELzdu7YFqLYpUqpWtIFPnlYGsHAsMWM2kPQMmCJLR77kZc7zwG5hDY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDNaTzRRMlRxUHBMVlpUYzFsQWVQOVQvL3FETTVsTzZyOS9GOXd6V0k5dy9C?=
 =?utf-8?B?ZmJOSUlSUnlhS1JHZFBoanQrMkNSa3lqakZEKy9ITjRoV0lnYWRMQVlHbzFX?=
 =?utf-8?B?TVk2VVhINFBCUDAxQUo3Q3Z6cFp1K1VWcU5rTTB2Y25wMWliQUhmbXZCS2Rk?=
 =?utf-8?B?eGU3SWFwMUd2VmtEQ3NlV2tmSTZPTXRmZFFBdUs3S2hOZlpQNUpqNHFTMmhT?=
 =?utf-8?B?bE9WTDg3VktLTGRWdlFNMDRQNlFzUFFaTzFtbFljczRhZ21rbzJsa0Z0V3J6?=
 =?utf-8?B?ZlFUQ08yRy9tOFN1U0hyelJTaHZBSENReGRmRFBhMXBvTzJQZmh2R2tCaDQr?=
 =?utf-8?B?ZVRUTHU2MnljRTl3Vkk2WHpYdXZIRDBZeFVpWUJaSkpTVWpBd0lqVEY4KzdQ?=
 =?utf-8?B?WEhhb0wvaGJTdGVDWk1FWG8wdnRybGNCNjN4U1RNOHdKMm5ldkZ3TG1oL21F?=
 =?utf-8?B?REhidGFaK21zbHJmcW1oL1VVWGpJVWdDTlhDbFhpRkp2Sjc5THViU0oxSkY0?=
 =?utf-8?B?K2tmT0J4YVV3dGp2UHBobzJmbzQzb2dsRjVlZlJVeEJSVHh1YWZPclFPN0hL?=
 =?utf-8?B?YVU5Ri8rQ2JhRDF3dU9tek5jcFZOOU5DaUQxOG15UHhRWk9Wc1l5ejU5MEsy?=
 =?utf-8?B?cXJWT0NJQTZ2WUV5aVBuekYyZi9XS2dhYzQ1N0YybDU3dlVlekxsaWFNUGdj?=
 =?utf-8?B?R3hHd1ZiUHJJeXc0SFJhV25ROHRKVTUrNEZBWjRSSzdMbjVVYWVhRW5lN2Zu?=
 =?utf-8?B?RVRxZGZGSWhlOUFvTml3YVpKTEdCd1lUMEtZYnk3b0JBZlA5U3VzUDRJNVZC?=
 =?utf-8?B?VUhpeUg3SzZxZk10U2kyTTQ3Lzg1c1R5YkI2YmJJTEs1bzU3UDViSzF4M2tt?=
 =?utf-8?B?d3Q2L0xCc21ocDlreGpGUWVabDVpSlB6elRIalZhNFU0c3RMZmFjYS95azRj?=
 =?utf-8?B?dlhOTExIcnRnckI5Tlc2SjdsSERWZ0RWQ1M5cksveHBVNlR5YlJQVGpDMjNO?=
 =?utf-8?B?OXJSYWw5bWlYbWMvb3JOTW5kQTVTVURwN1ZHYnF3THpzSEltL3FXV0FTSTdN?=
 =?utf-8?B?OVAvcU5aOE56eksrbncvdUxoMXpPZ1NPZ2VjeE8xdTZZRmR2T3FYVU9pNW9u?=
 =?utf-8?B?djVEZ0VPOEFnMktCZU85b2VKWUF2S0R6YXlZUXVBWk9XVVUyVlVPSWlnNVMz?=
 =?utf-8?B?VGF6dmRERERza1hnWEsva2tmTjk5OW1qWmxoeGp3eWN4djZUVms1S2dGd3p1?=
 =?utf-8?B?d2pySzNYajB3MWw0WitDMzVPM3pQbW1Odys1QlorWVdZR2w2TjA0bG9MUDdw?=
 =?utf-8?B?bkhlbnhJQVNCaWZrMzFLZnl4T3JHN0VtckFGZ2pMdlBpY1BTcnZMeWtBbUtC?=
 =?utf-8?B?bmczQ3ZySDJjZjV6WlJ0NW01cUlWSHJIcExBSnBleGkwZFo2VHJNNEZBMUdn?=
 =?utf-8?B?b25zeDN6a3lGbDh4SzRSYmZFYWhWWFFYSEQvMEZzSkdUWVI1RytubHdpeFR2?=
 =?utf-8?B?Y0ZhQmYzNHd2U2ZFL0dzdTZYR3V6ZUNKU1NtaTZYYnpZM3pXT3lnbGNiRE1k?=
 =?utf-8?B?dCtvREtmOUM4eVMzY2llWEdneVdmTnppdzZwYnFZdEJ1MW9xN3FZdW56bzBp?=
 =?utf-8?B?NnVqa2Rla2NhNVFBQVJMLys2Y3VKN2VvSkVTYm5vUFZ0emJIZndZMkYwWmNU?=
 =?utf-8?B?S2hrQWZ5ZGtaY2xtVTdRMGpRYkFXQXg4KzlWa1VwWG11TC92YWJRMmUzSWFp?=
 =?utf-8?B?YnJiODBNSFJiZThNMUdiQmhDb3VwOTh1bHhWTU5GcUdUS3FtV21ZYUpGMXls?=
 =?utf-8?B?dkpZUTU2Qjh1b1o5V0h4OFlmV1hUZEE0UlRJZjlFejZNOTRQVWloMG40MEhD?=
 =?utf-8?B?R3p1OFN1U0xLUWVWRElWQkJrcVZudHJZdWZVSUFjcmdXUzEwdjdRQVI1MW5M?=
 =?utf-8?B?czNreXlnZzhGN3NvT2ZjZlRybUZMUXVLWGlDbmdCWnNYTDFEWitjVlBuQWFI?=
 =?utf-8?B?SC9kQlJnN05sUWsxSktzeVdMcmtEWHNkdGpKdGhaNHdza2hIMGw0RFF3WTNu?=
 =?utf-8?B?aTZNQzZ5cHpNazQ0RFNURi9uOGQ2cTc2cS9GNnltMmUrWGVlL1dKOHlRVkli?=
 =?utf-8?B?UTJMRk9xZzJGQmdVcElQQVRVb0RMTmNzS3JONEtnOGdEb0FaVnV0aFBpVlFt?=
 =?utf-8?B?bDBwMkdycmFVMnZkZzM4TnVTaitnNVNJTjB2bHJtRmIvQ2c0TWpSRG9GdEFP?=
 =?utf-8?B?Q093LzNZQkZibXR1MFk3L2JLaWRtNnhHTnZ5MkFzeVNGNEErckhPU2tGY0xU?=
 =?utf-8?Q?klG7lWphY/mIgY12PE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pD7sFDb64uAC1DWtFUYHDzq8jqBnBhzPbiEYaseyw6YqMQuv3gLvR1rv9fV+P4H6ntg7Ng7WDYZ00zbHeLRvSae4EHvHIbGi+zFkosJeBuqqzHkNr6TsE86NiZ/Jus1DH2bvXlYopC3ftIEdyP+KY66duI57yiSR0W/OJ0KODLp2JX9w0gUMm5lX4MoRq2erQcSOVvKnvl5RoR4+A21eZkaM6OklVkkPyf7sRpsMC2SBj3Po4COW+0n5OqxLmOmOLndwtjh7pbc1KjHdsd02seVA3z/jA6R2hilkQUGobOdCbcMFMsz9n5Di/M+h2FvWirGGe6oQe4Zj4n842r5drA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d59ed27-9d2e-4fc9-e382-08de8bdaa51c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 08:27:12.2357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6nkAGCGGgpTZe+5dqpgZiUrHuSu1E2R4K6GGDf1BcYKL3SIBZzOdR1RnlQleDNh3mlCtz0pZvq5eaJThV4yITA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6828
X-OriginatorOrg: intel.com

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IEZyaWRh
eSwgTWFyY2ggMjAsIDIwMjYgNTozNSBBTQ0KPiANCj4gT24gVGh1LCBNYXIgMTksIDIwMjYgYXQg
MDc6MTQ6MjFQTSArMDgwMCwgU2h1YWkgWHVlIHdyb3RlOg0KPiA+IE9uIDMvMTkvMjYgMTI6MzEg
UE0sIE5pY29saW4gQ2hlbiB3cm90ZToNCj4gPiA+IEBAIC0zOTYxLDkgKzM5NjIsMTAgQEAgaW50
IHBjaV9kZXZfcmVzZXRfaW9tbXVfcHJlcGFyZShzdHJ1Y3QNCj4gcGNpX2RldiAqcGRldikNCj4g
PiA+ICAgCWd1YXJkKG11dGV4KSgmZ3JvdXAtPm11dGV4KTsNCj4gPiA+IC0JLyogUmUtZW50cnkg
aXMgbm90IGFsbG93ZWQgKi8NCj4gPiA+IC0JaWYgKFdBUk5fT04oZ3JvdXAtPnJlc2V0dGluZ19k
b21haW4pKQ0KPiA+ID4gLQkJcmV0dXJuIC1FQlVTWTsNCj4gPiA+ICsJaWYgKGdyb3VwLT5yZXNl
dHRpbmdfZG9tYWluKSB7DQo+ID4gPiArCQlncm91cC0+cmVzZXRfY250Kys7DQo+ID4gPiArCQly
ZXR1cm4gMDsNCj4gPiA+ICsJfQ0KPiA+ID4gICAJcmV0ID0gX19pb21tdV9ncm91cF9hbGxvY19i
bG9ja2luZ19kb21haW4oZ3JvdXApOw0KPiA+DQo+ID4gcGNpX2Rldl9yZXNldF9pb21tdV9wcmVw
YXJlL2RvbmUoKSBoYXZlIE5PIHNpbmdsZXRvbiBncm91cCBjaGVjay4NCj4gPiBUaGV5IG9wZXJh
dGUgb24gdGhlIHNwZWNpZmljIHBkZXYgcGFzc2VkIGluLCBidXQgdXNlIGdyb3VwLXdpZGUNCj4g
PiBzdGF0ZSAocmVzZXR0aW5nX2RvbWFpbiwgcmVzZXRfY250KSB0byB0cmFjayB0aGUgcmVzZXQg
bGlmZWN5Y2xlLg0KPiA+DQo+ID4gSW50ZXJlc3RpbmdseSwgdGhlIGJyb2tlbl93b3JrZXIgaW4g
cGF0Y2ggMyBvZiB0aGUgQVRDIHRpbWVvdXQNCj4gPiBzZXJpZXMgRE9FUyBoYXZlIGFuIGV4cGxp
Y2l0IHNpbmdsZXRvbiBjaGVjazoNCj4gPg0KPiA+ICAgaWYgKGxpc3RfaXNfc2luZ3VsYXIoJmdy
b3VwLT5kZXZpY2VzKSkgew0KPiA+ICAgICAgIC8qIE5vdGU6IG9ubHkgc3VwcG9ydCBncm91cCB3
aXRoIGEgc2luZ2xlIGRldmljZSAqLw0KPiA+DQo+ID4gVGhpcyByZXZlYWxzIGFuIGltcGxpY2l0
IGFzc3VtcHRpb246IHRoZSBlbnRpcmUgcHJlcGFyZS9kb25lDQo+ID4gbWVjaGFuaXNtIHdvcmtz
IGNvcnJlY3RseSBvbmx5IGZvciBzaW5nbGV0b24gZ3JvdXBzLiBGb3INCj4gPiBtdWx0aS1kZXZp
Y2UgZ3JvdXBzOg0KPiA+DQo+ID4gICAtIHByZXBhcmUoKSBvbmx5IGRldGFjaGVzIHRoZSBzcGVj
aWZpYyBwZGV2LCBsZWF2aW5nIG90aGVyDQo+ID4gICAgIGRldmljZXMgaW4gdGhlIGdyb3VwIHN0
aWxsIGF0dGFjaGVkIHRvIHRoZSBvcmlnaW5hbCBkb21haW4NCg0Kbm8sIGF0dGFjaCBpcyBwZXIt
Z3JvdXAuIGFsbCBkZXZpY2VzIGFyZSBjaGFuZ2VkIHRvZ2V0aGVyLg0KDQo+ID4gICAtIFRoZSBn
cm91cC13aWRlIHJlc2V0dGluZ19kb21haW4vcmVzZXRfY250IHN0YXRlIGNhbiBiZQ0KPiA+ICAg
ICBjb3JydXB0ZWQgYnkgY29uY3VycmVudCByZXNldHMgb24gZGlmZmVyZW50IGRldmljZXMgKGFz
DQo+ID4gICAgIGRpc2N1c3NlZCBhYm92ZSkNCj4gDQo+IFRoYXQncyBhIHBoZW5vbWVuYWwgY2F0
Y2ghDQo+IA0KPiBJIHRoaW5rIHdlIHNoYWxsIGhhdmUgYSByZXNldF9uZGV2cyBpbiB0aGUgZ3Jv
dXAgYW5kIGEgcmVzZXRfZGVwdGgNCj4gaW4gdGhlIGdkZXYuDQo+IA0KDQpJIGRpZG4ndCBnZXQg
aG93IHRoZSBzdGF0ZSBtaWdodCBiZSBjb3JydXB0ZWQuDQoNCklmIHRoZXJlIGFyZSB0d28gZGV2
aWNlcyBpbiBhIGdyb3VwIGJvdGggYmVpbmcgcmVzZXQsIHlvdSBvbmx5DQp3YW50IHRvIHN3aXRj
aCBiYWNrIHRvIHRoZSBvcmlnaW5hbCBkb21haW4gYWZ0ZXIgYm90aCBkZXZpY2VzDQpoYXZlIGZp
bmlzaGVkIHJlc2V0Lg0KDQpzbyBhIHJlc2V0X2NudCBpcyBzdWZmaWNpZW50IHRvIGNvdmVyIGJv
dGggc2NlbmFyaW9zOg0KDQotIG5lc3RlZCBwcmVwYXJlL2RvbmUgaW4gYSBzaW5nbGUgZGV2aWNl
IHJlc2V0dGluZyBwYXRoDQotIGNvbmN1cnJlbnQgcHJlcGFyZS9kb25lIGluIG11bHRpcGxlIGRl
dmljZXMgcmVzZXR0aW5nIHBhdGhzDQoNCnY0IGlzIHdheSB0b28gY29tcGxleC4gUHJvYmFibHkg
aXQncyByZXF1aXJlZCBpbiB0aGUgZm9sbG93aW5nDQpBVFMgdGltZW91dCBzZXJpZXMgKHdoaWNo
IEkgaGF2ZW4ndCB0aG91Z2h0IGFib3V0IGNhcmVmdWxseSkuDQpidXQgZm9yIHRoZSBmaXggaGVy
ZSBzZWVtcyBhIHNpbXBsZSBsb2dpYyBsaWtlIHYyIGRvZXMgaXMgb2s/DQo=
