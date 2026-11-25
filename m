Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795576125;
	b=3ZHZ5fGUNqyqeCsyaUL5bs9lb7Pg0ndnTAywXZ7w/tomO6aGIuRBeqI1JUytQMfw1oSU
	 amqK22xRK/GLnRX3TMaVpKxJ2fDIUbS9h5i7fy2yshV+5IfYz6pl9RGIyJnOXpmQfnBKN
	 FhpO98/dlfp+b9SsnM41Zz3/lapOt2CATk8tE58q3cnx9wPWdeKRUHKocuOc4DeRGaixN
	 nt5lrbnDyP7kEAesvwqZ7nDDyTAQcg1wlHySR4UqVMqGU4hNNZG6wFNDU4+Gg8+Hexrve
	 1o3g54tbDED93qBVIASyIZTKScI2FN42FmMM9cD+Ye/k1vs2Uw8nsLdWMtlcjC8VdWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795576125;
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
	bh=9sW4IVmkUaUjQ8wnEuhkDCoRtyklE4KxXE10DG9BMII=;
	b=udiQcNYqk1M5VRARGfxalXWMzwdfhUueiksH7JqSEaTIHCj0wl3EYuFZ5v0Xx3bMIimn
	 11YjuMmLHayDvWHWJpNFpoIwCI4Cfwlx0vCkIsStT1pdCPlv5wLqfZAMgIJ5qDcGN+6EQ
	 m5+ggMh7Opo6SZOcnXGO9XNpRfqopjP4hymEhWyrnivNkR5bcjopuqOO0gjQw2/18zQSI
	 FSOBvthozh25fFwWTDTSq3cxhztScZvP9sAyMnkBMTwFVvguY6bYXWFlADmbNRm612phh
	 A2LkxoFrHO78h3d7EB7F9XoqfQHcJc2Ycl3OFNvOIG5xF4Yv5RlpfSyhcCuH/iYdt2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Iu2i4KC8;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=BQtDe6uS;
	arc=fail smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD460606A321;
	Wed, 25 Nov 2026 03:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD460606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Iu2i4KC8;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=BQtDe6uS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795576124; x=1827112124;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9sW4IVmkUaUjQ8wnEuhkDCoRtyklE4KxXE10DG9BMII=;
  b=Iu2i4KC8J7zmOLhC3gjGw3zYjGEjEzteplbFbBvVyZBw3TomfKrx3VWl
   vRg/I+m4iF23Z9SyXQR7f6sPGCSZgHfcBhxz217BAXL1h44AjeXcJjZQ2
   p5UowsCaKH818CHK4GK55ie9vl8Ax6qX6P4inzEzYKBZ5zvt0hrDx8cQL
   MlL7THthXnMR3vuu4QLHPnSEltRabtqRwck0Z2xF+BnNWuTAASzNNxNbW
   /BgaAYeO7kqbZFg6DFYDOmASnfRfBa4Tnos04vv6+lomwT5jW6p89aMTP
   Dn7l9gJMsujnnaDjVh2EMBEBRSFxe4eCvMKfrlwEJKJ8iHcH6C5pu4OMd
   g==;
X-CSE-ConnectionGUID: wDqOFy89SsW04BKmgGIIwg==
X-CSE-MsgGUID: S2ifGFKWQ6+kioJeoccbNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4439776"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4439776"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 19:08:38 -0800
X-CSE-ConnectionGUID: Mq/23qQ/Sy2KJUUUaY2DVQ==
X-CSE-MsgGUID: 59KJlGLmQ9KWY7n7lytyuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="12329821"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 19:08:38 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 19:08:37 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 19:08:37 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.64)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 19:08:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfkC055YYe6DT61rvbUPqMHV0yMP1Ld48wsMRVa84kUqkFKfFKIi++hveQ7rkNrAZax4AoWmgRtJFcXMA7GVxP0188ejfiUWNLxQ3SQogNvkrqH35TGTjyqOyJTIZLnZr+6rOAOHBVciiQFJEC/d63jwDY3usue41SeYYZ7m67OeLpp/RauZKUBS+OCtkTqbMNfmhWz0QOLtS0yjpN8zcLwdJhyN4VJFD4aUA2t9wjX4CMAcxZC9/gfrxHqrCBfumTGqHSyevnaz2Py1/4CCZlA9cvHW/dT4yZIosZNnFmphYy7LeKDZi+Qfsk/4Rj4taY0kwOnHb4SOEY0BamQgjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sW4IVmkUaUjQ8wnEuhkDCoRtyklE4KxXE10DG9BMII=;
 b=Z9owQvz8Dnv8nl5Ul/T1zcr6pSpzzNog6T7Fvy1vfa3oGfZ7vmML+Mms7AxoCd5sNvXthDuNFi8BaWjyEJ3oj56R587q80xy09ddKsd2WFK90bIy8wSgaaSpIFZKsgQgd+mo2Tesi4Ze0UKl5SlLuaZKqAhEfWk3i2FYm4m0oZEq5Fy5IvwduwkAjrthBHDdRJP60UF+BoM75tgNUjfDcXjOxGYXJNDR13PpfZ3e0fIRicjksjH0txTg4NUyGaVGxXYtYccD4vGok9VLuQ7Wr8y9RBzLzzBGACXlMGyUlsplnZkjgCL79Nfv8QPyzZLhGFpfa0As1XL9GIDFr54abg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sW4IVmkUaUjQ8wnEuhkDCoRtyklE4KxXE10DG9BMII=;
 b=BQtDe6uS+XJCG3PBfvsZYDfDHZXkEFp2TK13cphy9BSZ1TsvUoO8ce4BE7Py4l6s48aPh7vky3/ptWmGQ55mi5DnZ2DqDb0tYTE71bHvaz7H8Z/p7TCEVcm8vYWqV2vXNpn357iCEmQsQaqiBaNa/6WSfpmbRcrPH+cFMIONNGU=
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by CH3PR11MB8591.namprd11.prod.outlook.com (2603:10b6:610:1af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 03:08:28 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 03:08:28 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Kiryl Shutsemau <kas@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao"
	<chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/9] x86/virt/tdx: Add SEAMCALL wrappers for IOMMU
 setup/clear
Thread-Topic: [PATCH v3 1/9] x86/virt/tdx: Add SEAMCALL wrappers for IOMMU
 setup/clear
Thread-Index: AQHdcmBxwINOrwn4hUKPFyjx+DVgBrc878jwgAE5/oCAAAT+cA==
Date: Wed, 25 Nov 2026 03:08:28 +0000
Message-ID: <CO1PR11MB4835DE6974C89C303A8C2B658C432@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-2-baolu.lu@linux.intel.com>
 <CO1PR11MB4835FD5EB44EB94467A82E5F8C442@CO1PR11MB4835.namprd11.prod.outlook.com>
 <8ef35412-44a1-4fca-8ba2-06bbad367b22@linux.intel.com>
In-Reply-To: <8ef35412-44a1-4fca-8ba2-06bbad367b22@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|CH3PR11MB8591:EE_
x-ms-office365-filtering-correlation-id: a425c153-8b9b-4c22-c80e-08df4aa160b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|22082099003|18002099003|4143699003|56012099006|261026140227099003|11063799006|10067099003|261028144727099003|261102123227099003|261026121527099003|261022105027099003|261022075727099003|38070700021|261021121427099003;
x-microsoft-antispam-message-info: pEr3D4rQa4y18U3BjhixgO9f8egLR1DH6jklpfn7yrV2KTn1ptrXBUB51tD2gUaWBmXiei7kpM20k1disVxonakb4xMtr7iXfnkhcfsbSULNRCl1PU/TydI3V91Myd7D1VncxtbOzpvBy1ultZiI2fDCCy0r6BEJPS8rhSQiQtkjJE71TRZByjntRf0864MK/BIejVxU2c92BKbnNACyo0hdAeo6F3CW5OM0L/N18NsShlGePA6p6kiAK7XKEM4PkVTNkhQgzbwETj51NWbi50e1WPxj+f2cMTOvDHj7SajzcsmP0Hizd9jTYWfJZEKBHn5e3on7WbVeFzOR22BpFlZ5F1HEvK8QBkqZQBjM7mnsEU2sE2/Elgd6yRK1uuuTysfxpWyP8OMdiXEdMuqNLTSedQn1XWrLC66uZAZlPAFVd+fpKvxAcAGZ1OVV4NJy3ezNkU6FPxBoMV8P8rJGzc9DrgqPI/1sye1WTNvSn4tgZyBYgRKGprigpyOA2JqSmKaPWn8NCWKLeIMTRXeIrlvpXbdb0eyKZJhQFHqFzbQtJ/6/XK4n3uQuapIioKomNLga6QYwf5R7leGSXT+rVSBkybve/bZBulHlnjO4qzxpR5pIuXW0aWuz/yFCX2O9ShBg0p7VxPcI3fNBhej4emk1rbOu/HoPPSEOWfoxOX3utZSZfu3gpu8pdfYYTbxwvVf0FV7/PaoaunoI3wnMcc4kqPp6WHQKMrL2cqdz724=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(261026140227099003)(11063799006)(10067099003)(261028144727099003)(261102123227099003)(261026121527099003)(261022105027099003)(261022075727099003)(38070700021)(261021121427099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yld4MjN4VVVPTlhGQTNiR21Cd2t3R2FVcG43ZGNnYkFGbmtoT1RJZFRjeCth?=
 =?utf-8?B?dHJwZjhMM0FLVjUwMmovZmVMemhMMUJhbW51RzR0d3dMMzRnYUxPQ0hrbi9o?=
 =?utf-8?B?RGNLUVlWckwxSkRIR0lhYlgyWnpBTTJpQ3RNYUI4MXpFbUd4S2o3Sk10QXVJ?=
 =?utf-8?B?NTV5S0NuU2prSjFyTTJmeWJGaTBLUGhxQnFoRndCNVBzRHdCaG9iMEVVbktS?=
 =?utf-8?B?Q0t4aWJsTHhERjdUU1JwcHVqRU1lblRWd2t6amRHVzRYeERKQ2pSUnd5TEc4?=
 =?utf-8?B?U1dsMmx3dURFSlZvWTZ5dGdYNVB6Wlc0VC94SGR6MnRZSU1WNDZaU21JaXpo?=
 =?utf-8?B?TmY3OW5naWJvN0w5dVlzZkZHa00yb1psTjZmZlZHNDVmQVJRaEk1ZmNTMjZv?=
 =?utf-8?B?OWQxTytuckcrWG81N2NhRUNkVnk2ZDJuR29zdUNnZXRRNUZoTTI4akV5b1pQ?=
 =?utf-8?B?TEE0U0JSVG01d3I3UnVTV000VE9RVE1ncEZkMmdxYXNKZFlPaEJIYk9tUEhn?=
 =?utf-8?B?SGluaDVBRnJEcVJPdmttUmU0d2xZM1JWSDVjWFMvb0cwMHNxY1I0NzZTTUF6?=
 =?utf-8?B?cDhUSVYrTGYrYTlzMXFJeXNEM0ozODZvV2ZqRnNlWDcwNVY4MzNGN09BNzEw?=
 =?utf-8?B?TU56THFrZWhJbm9aMW5HNElONkI3K2p4TzhvcHpJVHg5ZzBaMXpoekhzS2Rl?=
 =?utf-8?B?T0hGditlekd1R0ZJbXRlYmZpQUxEcDNQOTdWMmFnQXNEdnFaYnViZkxlcU82?=
 =?utf-8?B?SVFjWVBBcWJvM2x4SDF3OFh1Q2xGYy9tTlZ1b2hVVUJoSkZ5Zy9hbkNubDBZ?=
 =?utf-8?B?SlR0RFBEYytNNlAvNFpJQkNOdFcyNmUvM25KSGdJOG9SbTlTaHRyQS9QazR2?=
 =?utf-8?B?R0hJeU9yWGRNOUZzRnUvL3gzbGVoVGFjOVVwSDJVQVdpbGEwVE5GMVBFbThP?=
 =?utf-8?B?YmhJdnVmVHZOWElsQ0lWQkl6cG1JaUtBbTZEQitFaHlTdkhVYVIzKzRuUDNG?=
 =?utf-8?B?QVVOcGx1ckwxVWlPSFovSnlFNXhwWU9zSllHZllpZUhpb2lyaVBtUy9KRzY4?=
 =?utf-8?B?RWEwY2RERmdQblJUVHZNZEF0TlVJRXVqL0hhT0dvVGdqdHEwS0xJek52R3B5?=
 =?utf-8?B?MEFQbVlpYmw3R0FDWFFqRHQwaEtRRnRNRGZxL3N0VUEwS0tXQkM3MmlIeVpT?=
 =?utf-8?B?VUFBYXl0L2hsbm0ySWQ5SVdoak9YN2RlNmsvSTZySitZWDFDZUVCZld6U2Jo?=
 =?utf-8?B?UUVERUxyN3Z0WVRjcXg1bjVueFZRdUhUS1BrZXBURWgvdnlKa2Q1bFc5N3ZK?=
 =?utf-8?B?cGxPOC9LR1V1b2k1ZTRQeEpIMStObUhuK0JTZG0xRUdqUDd4L0ZTdmFyUkpp?=
 =?utf-8?B?aWFxR2JoQjlER1M4Ym9iZDVYR3NZS05pU0oyNnU3dktvdStlWmRGOHlyWmZP?=
 =?utf-8?B?SzBTRkkyUENMcEpJdEc1VlVYODZkOEZXUGdNeXFZdzhZNkQyL1BnM290Tk1R?=
 =?utf-8?B?dzNWeVF1NWhCUENIbGZ1cHYyZ1BMR082b1dPVEtqMmJwMFVQSDFJcFRNRHRN?=
 =?utf-8?B?QlhCL0pDSEl1dy9BLzFUZzduSEwva0UrLzBKOG41Y0xjZU1BeEhpVFNnTzNY?=
 =?utf-8?B?b1ZOM2tRZXN3K012NjJmNDhpYkpobnJZVjRKZENRWlFPZG03UTVsSzFKWnNo?=
 =?utf-8?B?MFQyc2RBaXQ1ZWhXZDBTaUtJSnY0cVVMbll0WHIreGg3YWpSQWlXYnYvY2t4?=
 =?utf-8?B?am9HeXhsU0NjcUtuWjQyckhaTjdRcjEvK3BTTkNIRHZ0Z3A0MG15SmtXcjRQ?=
 =?utf-8?B?ek4waTd3RS9DY050T1JHa2Z4dnFCUk1pdFFPSmE4am4rcUthUjV1dnZ4Tmdq?=
 =?utf-8?B?dEdmdisrVE5SYlZpUFJ6T3Zjbmw4WmhIRHF6dm9jZVZVV2pTQ0x2Z09IdEdL?=
 =?utf-8?B?eHB0cTh0c0lONWdMWE12R0VSQTBYakY1SjFvb0p3elhqdk5zTXQ5TGZRSEFP?=
 =?utf-8?B?dWtFQnZFZVg3MlB2OWY2bVhnY0hyUFY1N08wZXVTRThFSlBTVmFGTm1sRHdL?=
 =?utf-8?B?MDRjeXEwdzdoemVveVVJNWY3SjNUY3dic0hybTlmL0JzbnlRRXpTekxmSXhC?=
 =?utf-8?B?bHRHVlp6eHdOVHVEZjViWW9MeW9kdkNiVVNXeHZZT0RLZUZROG91NVpiTTEw?=
 =?utf-8?B?eFl3aU12SDNhRTU1Y2RSTExkbHBsV2huWVB5cWY3bzZpSm55ME0rYjdLdFN5?=
 =?utf-8?B?bDNqM0xRb1NSU0RGTHZJb0JhL001T0ZyeWJ3Y1hEd3A5UTdGUjBNRk1aTjFS?=
 =?utf-8?B?RzBpNDJtN3FROStjR2VTRGFhdDhWWHBaOHFNY0FldldwV21Qa3l0dz09?=
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
X-Exchange-RoutingPolicyChecked: AzKm8LkmSg64/KGoyFRb4C8HDidmBkydz60gRCMdYlX9N0uhO1q3lZqEYGd6ew2jAHnshsbdwMo3fWO3oRrYMAKTy8tVVNxI970owbQ5IXwaLyXtjZ57RSMOx6ePA11qCUFK9bqTEkBF2zksENO/4FtPCuIE4Lyr/obWrt4cft9rl0vdg321weEe2Eo5x2eoyQuAer4BYkW+cmTFsOSaQOWOS/DbxuU9o4aLJZNj5/QX7EVPpJFgauEfbQOd11GNrzpTuojuqyFmfLfjoBThqWfg2f1ZI2W6lxrxInNYmX4dN+14aXipM77TAu3aP1ejzs+ldCKGol+uVr9E7WWB0g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a425c153-8b9b-4c22-c80e-08df4aa160b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 03:08:28.2408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8z6iQz6cfEC7O7d1E7IYOcZjzqWlb4GMnTVbW62Ceb0UP3dBP6KfbDEWyi4YM7BAg1PoSJ1vj+0B3puNZIugSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8591
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIE5vdmVtYmVyIDI1LCAyMDI2IDEwOjQ3IEFNDQo+IA0KPiBPbiAxMS8yNC8yMDI2IDQ6
MDcgUE0sIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVA
bGludXguaW50ZWwuY29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMTIsIDIwMjYg
MTI6MzEgUE0NCj4gPj4NCj4gPj4gSW50ZWwgVlQtZCBoYXJkd2FyZSBnYWlucyBhIHNlY29uZCBz
ZXQgb2YgRE1BIHRyYW5zbGF0aW9uIHN0cnVjdHVyZXMsDQo+ID4+IG1hbmFnZWQgYnkgdGhlIFRE
WCBtb2R1bGUgYW5kIHVzZWQgb25seSBmb3IgZGV2aWNlcyBhc3NpZ25lZCB0byBURHMuDQo+ID4+
IEVhY2ggSU9NTVUgaGFzIGEgdHJ1c3RlZCByb290LXRhYmxlIGFkZHJlc3MgcmVnaXN0ZXIgYW5k
IGEgdHJ1c3RlZA0KPiA+PiBpbnZhbGlkYXRpb24gcXVldWUsIGJvdGggYWNjZXNzaWJsZSBvbmx5
IGZyb20gU0VBTS4gVGhlIGV4aXN0aW5nDQo+ID4+IHVudHJ1c3RlZCBETUEgdHJhbnNsYXRpb24g
cGF0aCBvZiB0aGUgSU9NTVUgc3RheXMgdW5kZXIgaG9zdCBjb250cm9sLg0KPiA+Pg0KPiA+PiBC
ZWZvcmUgdHJ1c3RlZCBETUEgY2FuIGJlIHVzZWQgdGhyb3VnaCBhbiBJT01NVSwgdGhlIFREWCBt
b2R1bGUNCj4gbXVzdA0KPiA+PiBpbml0aWFsaXplIHRoZXNlIHJlc291cmNlcy4gVERILklPTU1V
LlNFVFVQIGRvZXMgdGhpczogaXQgcHV0cyB0aGUNCj4gPj4gSU9NTVUgaW50byBTZWN1cmUgVERY
IE1vZGUsIHByb2dyYW1zIHRoZSB0cnVzdGVkIHJvb3QgdGFibGUgYW5kIHRoZQ0KPiA+DQo+ID4g
cy9TZWN1cmUgVERYIE1vZGUvVERYIG1vZGUvLCBhY3Jvc3MgdGhlIHNlcmllcw0KPiANCj4gU2Vj
dXJlIFREWCBNb2RlIGlzIHRoZSB0ZXJtIHVzZWQgaW4gVERYIENvbm5lY3QgQUJJIHNwZWNpZmlj
YXRpb24uDQo+IA0KDQpDYW4geW91IGRvdWJsZSBjb25maXJtIGl0PyBJIGNhbiBzZWUgdHdvICJT
ZWN1cmUgVERYIE1vZGUicyBhbmQgb25lDQoiVERYIE1vZGUiIGluIHRoZSBwdWJsaWMgc3BlYy4g
c28gaXQncyBpbmNvbnNpc3RlbnQuDQoNClRoZW4gZnJvbSB0aGUgaW50ZXJuYWwgQUJJIHNwZWMs
IHN0aWxsIHR3byAiU2VjdXJlIFREWCBNb2RlInMgYnV0IGEgbG90DQpvZiBtb3JlICJURFggbW9k
ZSJzLi4uDQo=
