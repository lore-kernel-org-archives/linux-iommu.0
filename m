Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795508022;
	b=NyisjjICPTd25QYMUIQ9HeXdLXuvxT4y6xhDE7v/k41Xr/jACKuiGjUsQY7ZLtQH9S8O
	 nALSg0twJ+AHD1bHuDkV9E/TBe+SLyAgogVBG8PhB0gp0/xgF5qHWusmVFgwkB1PnqwDa
	 chifzlR6v3TD+5/c3dqbZC3gyaAtyfyAv5G55UTfQjNufdsuY/0InuPH6ixXsrW4kJUOi
	 i3PorLtIBHIuXmbN53kcN6KxPOgbP2VeswBmmOU3gCsf8IWU7Sf3DNXFud3NLT16hnInW
	 QPempVNwQvOHlO5R8o7VGTH1aZ7B++UnYoN0YOfyiyCHqWBqjifZDSx4A9Ia7KAGCZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508022;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=sJgTUqp5k5LFDDHrKb9xDJVApK7hvaYddvYlX9zrx+M=;
	b=dn7A7CR3NbFQrsStOjUfei4uiU8j1knZ1PC1+6ELnNbv4XpKTkjH4DuUF34HAk0a7UIY
	 Lbtre5ZV+JDdko/NahonaHMi3aU6wgjr8xw9d2Dg/TcJvLNPT9jcnsR17OC8knM+EhVW/
	 Jib6l/J2kBmH4AKZe6j/30/H1oEHU5ZGUcKVANQS41BkArLYZXsb7lPDDlb3e+5uUXiFd
	 4dfFhwQBlC4WxU+x+Bj77TodtSKGq0qfCzzv1dzOEcSyWyuFhWcO+A9cV2X3TbCD0PLUB
	 ApiDH2fab36JLpGE8Uao41K02RnP2HoETAWbs2Gsr/sFy6uCUBGSLWMCgv2VbZBDk/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fm3uTcQR;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=W7obbILU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F18606A321;
	Tue, 24 Nov 2026 08:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4F18606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fm3uTcQR;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=W7obbILU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795508022; x=1827044022;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sJgTUqp5k5LFDDHrKb9xDJVApK7hvaYddvYlX9zrx+M=;
  b=fm3uTcQRmEOYISUhO8RvMTFMQofjsrDrTfMzYjMddGakysiKb+jF1+S+
   Iap6jlpxmBbfBKjD263LvFC3s771Du6oR6bFyKfyHcZggxtxtLXsFvjCf
   vJd+bCGsEyYpXVweuixk3QloJcbD/bTO+WmGOjInI+pl3tqt1nny+RLzl
   Xv3RKkohR3DHL6l5jhccNGQgzvR3yyjPHXJ03IlmPBjsCItgVMihEZ50D
   yGWYOJK4gsltqBoPrRvQXylWpD9Zm8ZlljxoHF/JO0h3LthlwfMgIz5C0
   OngmV84UwBeQFnbaA9jv2p0hcaHEmXi7n/8fQB/P53OCGELXlEEIn7PGD
   Q==;
X-CSE-ConnectionGUID: LPISM4j9QYm6tF83YNS/Mw==
X-CSE-MsgGUID: qHETgC2yTF6N+qM1YcG12A==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4348293"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4348293"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:13:41 -0800
X-CSE-ConnectionGUID: cL7dvEfZRqWx2mkC36nMZA==
X-CSE-MsgGUID: xDA7usFMQvCYInoT4Rlnhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11602599"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:13:41 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 00:13:40 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 00:13:40 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.25) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 00:13:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NE8S8yMDgXVEIOEB+3QbQmu97nAyMqRc82sFx4vZVtOUgo+1U1wdhvAJ4OV13p2geJuZz48uuacZcr08DGXL+wWtjw90xjAwpKe3XyioEfDkMeTkk/utvzcqwxPjjtRsEKD/0UfWaY/aUWSNxvUHedVWQOlxWOEFbRtKs55Qo/zVDB8m43sS+n79GmjZckOTdMByWIDhuagBw4u3WnCW98weoLCKcRxCcfbPJ4+Ezz/24IFjULql2+S2Gs0dG2fHeLHLBLzgTMUpbuH1xn4tAmuhEAs2t6nhb65T5P0Qxd+URXw7PFJfjJUDhXfHqJpRGLhtNnIJCdnWc17+ulNzqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJgTUqp5k5LFDDHrKb9xDJVApK7hvaYddvYlX9zrx+M=;
 b=PffmyWkw0e2x898VaCv7cJfPefs7q4ExEKqLMjO/rG2AXoIiqCBXyhh+fdbrAK/ANaBzhK4H3mi0v3Da1HyNJP+L6HXlHNt2LFTx24wiTtJ6pT9nr3G1yib/gsZS7yNIzymz8vrAdIz+YyFf02SeTa9H7gwkmbBNGW/e+QzKjX/q0XhZgmZvM3r2z2oACDAIZeM53I+NFCpe2DhK5/AfNbpCpmlDIlUZsEw6yF842Vb8ZZoXppcsyMYEAVVPCqWmjJ0F/35o+GVCobNhR1GoXd8Ie1VE2XxiRPTYHTc6RWcZStkePhS0BHMYu5chnQOfmLH8eGsXUEqOk9HJkv1tqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJgTUqp5k5LFDDHrKb9xDJVApK7hvaYddvYlX9zrx+M=;
 b=W7obbILUcgQMMOiHjpnsgHfMvf6406bdwVhOt38GSbZGZHODOIjoRAd20tlMGTIZMDteYWxouLUKlOdzY9febcTrNqaUI0Sym+t5lMyHCVlU3wgYPJKIbhiY7CsK+K2Hd+wz+cQFAEKlHTFEcYNBlBhBtp2rX85Adk4EKtYMVJk=
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by CH0PR11MB5219.namprd11.prod.outlook.com (2603:10b6:610:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 08:13:37 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 08:13:36 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "x86@kernel.org"
	<x86@kernel.org>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kiryl Shutsemau <kas@kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao"
	<chao.gao@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/9] x86/virt/tdx: Read global metadata for trusted
 IOMMU
Thread-Topic: [PATCH v3 2/9] x86/virt/tdx: Read global metadata for trusted
 IOMMU
Thread-Index: AQHdcmByisI8xFJ2zk2WNpBWdK5SS7cz36cAgAc8moCAAdUNwA==
Date: Tue, 24 Nov 2026 08:13:36 +0000
Message-ID: <CO1PR11MB4835BE5970A03254F7B0BE518C442@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-3-baolu.lu@linux.intel.com>
 <f2c46640-959d-4fb6-a313-0f907c127414@linux.intel.com>
 <158ce0a3-3bd7-4be6-89e7-ecac25027404@linux.intel.com>
In-Reply-To: <158ce0a3-3bd7-4be6-89e7-ecac25027404@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|CH0PR11MB5219:EE_
x-ms-office365-filtering-correlation-id: 8d21beb1-d225-4876-9e99-08df4a02d6dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|6133799003|22082099003|18002099003|3023799007|4143699003|56012099006|11063799006|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261021121427099003|38070700021|10067099003;
x-microsoft-antispam-message-info: ogwTuhtnZQcFplGrIzUsGyHbJrpUKY8RNX3cTy/GBm8v+/+mfZWD7pfYH/wlERnFlUXtl4FdlG05OwRs/8ghYhDgGRqdfnOp3sp/nPsqituXsjgbXx0I+fhyrm9hhvw/zQMITYrbumcAro8EJezzdbFPmsfGOnSQai4HILKiV++rLBUaTgVbaZblxNf/49uvF/EZcItEH5Xuetbg3lkgcosdrfukOWNM8Uh0XAGXAQhWByDQ2Qk1kazkei/1sNnvPl7tWOQYkUAxDyg+HUk9jXH04dtUgpglwMQpghXod0SBwGaT97nRPstlJND74MFjZPgjVn3wnh3SbKibWy16Ht1TxfHEU7+4CxSO+axAS18F2wqEZsxuzbrGtgjrgHhGphc+anhqFEvfAJP3uHEEc6heqrFl+GFqIxU6W6UP2vEyZ/sjJihnexb6tLXnFlqHOjRc4QFXBtQar8mtU/OSakiPSfqdlNNKHid7JGJ37mrA3KAcmzz0wsO1nzeRK4Z01LskIkFy/wd3uW8N8wLnZN2iEwiMxJLoiGFobcLITn912GsqSpdYd5/wUdEsPMavvIYnpQJMyqbpmDShFcN4E5ifTM5RTMgy+yX8q0ZrFJ+qI0ssMVAS8U3zqtjDMheRXGPAq09WcodGb63ywM5xDBQ9ucqtgpgs9x4DfU9Ox/19B3Sv9vZLkoNVgYMrNFqvanA8yBg6tVG1bwmbpZ50lZJzvG3a39PIYvQE3pvfZKM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(4143699003)(56012099006)(11063799006)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021121427099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0RUUEhMZlV6Q04xNE83VHZQaGc5OG9wOVV5cmcwYUdCV2d2aWNzNUNCWjhl?=
 =?utf-8?B?OVNUcVZ5aTQ2NW5jOUFLejArbUJEQ21LV1hGWHFWUUlQM3JVUTJOa2k2Y2xR?=
 =?utf-8?B?VW43bGRWaG5TNTNvQmYveFJnRFZaMnNEQS9OeXNSVjBGM1pQZWFpNHVjRmFm?=
 =?utf-8?B?ZDRBOGU1ajJYSk16SG1ScDlzNEVmUko4T0FaSkFSZUtkRlhsU3R6VDlCQWE2?=
 =?utf-8?B?c2dOU0kybjB3SnNUOVo2S2dFcHBkWDJLSkpxWk0zUStIcVp2QWt6REUyaDNU?=
 =?utf-8?B?dVhEc1Z2NUY2TFRJYmVpbVM3WHF6azZRbXkzOFcwQ1QrMkFya2pSNXI0VEVH?=
 =?utf-8?B?eUZPVDNDdTB5dUJvQ3VqVTFuYzlHTEdTckVFa2xUK1RqWS9SY2E1YlVZSGZj?=
 =?utf-8?B?Q1Fyc2laN2p6OTAyRithdHNVWkJKNlJGVHliaFB4UmNzZjRCd2tDN2xJY2Qw?=
 =?utf-8?B?bzllVkFvQWM0eG5hN3pLY1NIczdJVFRaTklkMVR2bVJITzB6NlplaVNLcjdy?=
 =?utf-8?B?R250UWtMNTNjSStqY3ZDdzR5V2R4QzhXbjJmWllkQ3ROTXdUc3dFZVdpMXA1?=
 =?utf-8?B?cHZkSitDd21FL0lhUWJtMkVHNjBOZERrcGpKV1dyWVZqUUhSeHg0NlZOWXNn?=
 =?utf-8?B?aDhCZzdMbDlZTmFmd1luU1RnOXltc0ppTTBKTlJjQm5BM09XSHQzbm5taSti?=
 =?utf-8?B?SkRvSjZFSnVreE15Z1RJR09XMmY1VkppQm9VbVR3MFRmZTVwQjlzcWVSUmwr?=
 =?utf-8?B?M3cwSjZrN3dGdnhna011YS9FYTIwSU1Zd0FJQlk2b0QxMlEzNFFrQ0ZXWEJN?=
 =?utf-8?B?WEg3a0JlZ2VLSk5HLzBwTlczbWplQ3FOOUFUMEFuVUZoVkJMUmhxMUNyVjh3?=
 =?utf-8?B?SFlUKzNIZDA1NkJaSHEyOXlMY25MS1VPVDRNWW1KeHJZSk5PRXdMaGhSdjJy?=
 =?utf-8?B?Mm80WjlISnhYT25hcXBlMTVjSWNNZDUwa01DZ3Z1UENtSWdzOFZXMU9MYm1a?=
 =?utf-8?B?cFRhQzNZZkx6Nkc2NkI2MURwVXUwZGszUjJ1RlFnMWZNZ3YxSlZLZ01GbjBE?=
 =?utf-8?B?NFphTWREazNOems0TlRnYmhZMHBLRkRtZnZQaVZqdS8rVVZQWTdraXVmMnJH?=
 =?utf-8?B?MUorc1RjRHJvVEtMTFMxd1FzQ1ByaWM3SlE3QUdVeUtlSWEydC8xU3BPNkFE?=
 =?utf-8?B?dm9lTndlT2NLQ0VsUlQ0YnRvb1Jyb2R2T0w1M3BINmdvMlVFb0w2QTQ5MVRP?=
 =?utf-8?B?RkF4aG9lVXg1cXVpalFDemg4czE2WVpYREhHV3p0NTR1MFBaYUtsa3UyajM1?=
 =?utf-8?B?bmwwZzY3bzlYb0pMRGFsRWJpbCs4bm5RRHFCK3g1OHovQkMrclZMNGk5QmFt?=
 =?utf-8?B?WXlkbWN4OUFxVXlJUXZmZlBabmQ1c1hwWTF1NmtIWE1FK29BTExiU3BCa0tM?=
 =?utf-8?B?a3JTSlRVMjNuT3ErRGsvWGJ5eDRXbWc2VXZrUVExbDlIcXNaZytQc0ZiVGhY?=
 =?utf-8?B?SWlhcEhGeFV6LzE4QzljZGRKNURQSGpJUEpDUmJxaFhvQS9WYzFBS2U2cUFz?=
 =?utf-8?B?T1d3WlByeGlYNVF1cXdOaHREc0JxVlZWWS9nWDBITm9lYUZxSmt1Q3hmOWJs?=
 =?utf-8?B?RXFrWXg4N3FscDhGN1dydGRoLytHaURacGcwcWphVkxXMFVuVXg3OXkzRy9Q?=
 =?utf-8?B?M3owVUZhSjhUU1RMeC9OaTBqMkdQcnp6MTdKRlorK01aRS96NmZwZE5FVTNH?=
 =?utf-8?B?STBKa1hHR3YzNTllcU0wZVJxcGdOYWZnaG42V2JYWXRBem9ZMEk1QUdqT09i?=
 =?utf-8?B?RGorc2dKdVRNWkl2aG5adXRTNTRPbnlrRUtEVVhLcFloZUNIZDdsU3VOaEV1?=
 =?utf-8?B?OFFyTjR4THZOUC9zM1pnM25mb3pjYUdkd2kweVZpU3Q0SEVZOWpaSmpWTU50?=
 =?utf-8?B?ZGhiMkxrWCtXMXVaNWhtalh0enhUUHNSSzlOckNWUmQ0dXBHcGRlQllhMExh?=
 =?utf-8?B?SVlKSHBjd0xoOTBiVmwyNWc3SFpQMDBuZjRwZFlacFlPZ2dzM2NBWDBlVVFQ?=
 =?utf-8?B?YUNJVllaODNoaGdESVJpYVQzVk44bHpKc0E4VlVaazlKVGczYkpNS1pjOWVV?=
 =?utf-8?B?N0d6VkJNVjRKdGJyNUxyL3h1VFpNeGJ4Y3ZBcFhrTlJmdWtlVGxVR0Uwc0Vz?=
 =?utf-8?B?WU1Kemw2TW41OFhWR24vRDdCUjZldHpjV3Exak56a3RiaGdsUHhTT1lsQ1Fa?=
 =?utf-8?B?NUt0aGlnWVFnekMxTzhqMi96WE9kdXY0RTZ3dlBEeGdWMUFFdGlxcmhmeEd3?=
 =?utf-8?Q?CEzJaQkmn0yn1EIqSp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WozKOHdnaqeaMpX2vTvx8f06sYAFnZyieFVd25aM6LfcvV7Oxyz6avkBAHOiqtxrQm5AbN6f73tpB4bullhAjtook6Eo9Cl+Z5E6YcO31LLuWSPTUwciqjIBSRoTgPPF4587G0/MeQZtMg4A89jLEJrc7Rf9NSKsWNsplg/jxHnxmGjm4RTjnWmY10kPNctvmJWh7A5+YtUiA79HY/2MTRfVhHhgl+sqJUmtoPlBhBfmTS8dMNMDulKitW6URdXXxBDuxrF4udNOE31TaTlX9gP0lsRYnpLBukr3elVnnuZDU4Gcwnos6D98qSEWmJVDk12n1I7yorsTRKSMRRudsA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d21beb1-d225-4876-9e99-08df4a02d6dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 08:13:36.4615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 28H6CoI9ONEPZ4a5hkgVqocXtpL7BQMzHyHsAmDHKL34TxzHyfYd3xlAxN2+9cmyI32Cla1Bk4iDqGOsREzvVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5219
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIE5vdmVtYmVyIDIzLCAyMDI2IDEyOjEwIFBNDQo+IA0KPiBPbiAxMS8xOC8yMDI2IDk6Mzkg
UE0sIEJpbmJpbiBXdSB3cm90ZToNCj4gPiBPbiAxMS8xMi8yMDI2IDEyOjMwIFBNLCBMdSBCYW9s
dSB3cm90ZToNCj4gPj4gQWRkIHN1cHBvcnQgZm9yIHJlYWRpbmcgdGhlIGdsb2JhbCBtZXRhZGF0
YSBvZiB0aGUgdHJ1c3RlZCBJT01NVS4NCj4gPj4NCj4gPj4gVGhlIHRydXN0ZWQgSU9NTVUgZmVh
dHVyZSBpcyBvcHRpb25hbGx5IGVudW1lcmF0ZWQgdmlhIFREWF9GRUFUVVJFUzAuDQo+ID4gTml0
Og0KPiA+IFRoZSBmZWF0dXJlIGVudW1lcmF0ZWQgaXMgVERYIENvbm5lY3QsIEkgZG9uJ3QgdGhp
bmsgdGhleSBhcmUNCj4gaW50ZXJjaGFuZ2VhYmxlLg0KPiA+IFRydXN0ZWQgSU9NTVUgaXMgcGFy
dCBvZiBURFggQ29ubmVjdCwgcmlnaHQ/DQo+IA0KPiBZZXMuIEkgd2lsbCB1cGRhdGUgaXQgbGlr
ZSB0aGlzOg0KPiANCj4gQWRkIHN1cHBvcnQgZm9yIHJlYWRpbmcgdGhlIGdsb2JhbCBtZXRhZGF0
YSBvZiB0aGUgdHJ1c3RlZCBJT01NVSwgd2hpY2gNCj4gaXMgcGFydCBvZiBURFggQ29ubmVjdC4N
Cj4gDQo+IFREWCBDb25uZWN0IHN1cHBvcnQgaXMgb3B0aW9uYWxseSBlbnVtZXJhdGVkIHZpYSBU
RFhfRkVBVFVSRVMwLiBDaGVjaw0KPiB0aGlzIGZlYXR1cmUgYml0IGJlZm9yZSByZWFkaW5nIHRo
ZSBtZXRhZGF0YSB0byBhdm9pZCBjYXVzaW5nIHRoZSBlbnRpcmUNCj4gVERYIGluaXRpYWxpemF0
aW9uIHRvIGZhaWwgb24gcGxhdGZvcm1zIHRoYXQgZG8gbm90IHN1cHBvcnQgaXQuDQo+IA0KDQps
ZXQncyBub3QgaW50cm9kdWNlIG5ldyB0ZXJtcyBoZXJlLiBURFggQ29ubmVjdCBpcyBJbnRlbCdz
IGJyYW5kaW5nIG5hbWUNCmZvciB0cnVzdGVkIEkvTy4gSW50ZWwgSU9NTVUgaW50cm9kdWNlcyBh
IG5ldyBURFggbW9kZSB0byBzdXBwb3J0DQp0cnVzdGVkIERNQSBmb3IgdHJ1c3RlZCBJL08uDQoN
CnNvIGhlcmUgd2UganVzdCByZWFkIG1ldGFkYXRhIG9mIHRoZSBURFggQ29ubmVjdCBmZWF0dXJl
LCB3aGljaCBpbmNsdWRlcw0KaW5mb3JtYXRpb24gdG8gZW5hYmxlIHRoZSBURFggbW9kZSBpbiBJ
bnRlbCBJT01NVSwgYmxhaCBibGFoLi4uDQo=
