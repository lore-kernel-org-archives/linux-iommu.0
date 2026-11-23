Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795451692;
	b=rt6WG+Wkl6C6HDGqGt9AEx1D4kJFwjwdfJbEAW3LRK/XCtjBBto1zEbLx4XDBRQGGgtc
	 LdV43BP7Zub7OVAP9uWDvXAlv8wfjgt4zwITJ1TmCgB2BHF8F5giKqYnMfESJklPR/PZI
	 hhVLwCC/66Rz/0FN+OKUwiFvpKdvnf52G8z8ie50plscMWTfx4gWC1k4aYAAsRUZBn6co
	 hMsLa6WKOWzK9cS7gqBuFebXvaNtnZMiz8hV6FfX0yLdKZ/nf6V9nhJhbyAcAXXVM2/ar
	 zy6RebAAzE9JybyxjxC/qrmCifKmmSfT/EvR0EnieSIUTsCPk9B53WQqMME/4S/QP2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451692;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=CUuXTP/4gZjkYMTRc0uBLRyhgtLxFJHwCv/pmR+9UaU=;
	b=5qLzWwO95MT2j9Ko5q5Vk1rWms/FNZP2QbeFN0X6XVC5fndJk2U3Y5bCErSRSLixYmG4
	 XhyD9QgvyqoyAO+MoDebcZc7cTYfMilcCmErgQ3fGj1yIEXsKCRWaFFwpRBGXDmGC2Ctj
	 7IfYKuUIvsNirO+spiZVDXe6bQbLpIfWz8vc6AoMeqKtgsbn2JfJqW5Ysdf2vxMMIc/+H
	 N/EyUJI1k2WYFwPxBPlihcq4cnoYWWmNJSCwd4iD+d2jUNKJr2f/Q3cCfErIgYFDTfHiK
	 ytHuQeL82Q8/ajeno9G8+tS6P0DPywtWwvXm2jvopJ0wvET0FCY7rsi97l8URNHzqvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kOubcE5g;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=BESGiBi6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2236606A31E;
	Mon, 23 Nov 2026 16:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2236606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kOubcE5g;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=BESGiBi6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795451692; x=1826987692;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CUuXTP/4gZjkYMTRc0uBLRyhgtLxFJHwCv/pmR+9UaU=;
  b=kOubcE5gp36Z2Sc+BLhRn8V0GuC10dRuWIazGbZjS8e7DwQdZ5UGA8Yp
   SF3ffubPRGrUEAmD9PkEGZezNsXQP7PX7TtI1pm78Qu6EbjSV1mGxC5rl
   WTBXE6GPEY9heMYvOnoalYCbdMi4sOTXkB5d256QbGR74Yn4IXfnax5EE
   xe60RV0Qu4nCzjr6YtwtgR4FpqbBibWp5MuOLUPh1DoAxV86DQvMIWRO/
   La8freDHFFju9arrOfJjECoVzqVOpTMD0Zt8YLFAGvQ2we7uJiQFhXu7c
   2S1P+POvzwBvo2b/EV2Sj/Ep6Ow7URCgSm78PnOJPsKdVdyV72nKbuqlg
   w==;
X-CSE-ConnectionGUID: /r/bMilyRAGTNmQY4W/4CA==
X-CSE-MsgGUID: 7Cy6ucNzRSiXaaNmnSk7/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4277977"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4277977"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 08:31:42 -0800
X-CSE-ConnectionGUID: yocczTEhSauoPtowbEQYZw==
X-CSE-MsgGUID: h0uHb6vcRyKHpktE5B5N8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11423554"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 08:31:33 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 08:31:33 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 08:31:33 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.61) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 08:31:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqxiFAPovGyXG2Um89kS9gVBeQMdgnxKlhnkYimNJGEZpFmJaJBKRX15bsSZyqOi1JorAkEdP5tubVmTWkqsXy/e4ZsiINNHgyRJIuk4h0AeVKAu/+7FbqcfS/9x/pcFlOmxcKxvUFFJDgbsln82Ru/JPU+P+n/pXUDHa9QkV+TrO50iy8hzTh7zAaGy62bUeU6olaotEwpxQA2mQYRoCKLMwXHQGR6rRLuQPZi5VP7VI2c2zxoKjyP2o/LXVeySFHrwrL9izDj3rgRlFqr28zHHrLLSaGiL5Xk+CV/ym/9xrTtMlI2RkYtmyqDn1DxdKuT8jDU5io15sF0cyvZwqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUuXTP/4gZjkYMTRc0uBLRyhgtLxFJHwCv/pmR+9UaU=;
 b=U1jQNj6MUrBJRwuGwNhwMfarfXMbM5ODM/dzxdBQkppQbwXkEMowtjIq3RRrFofPV0OVAxDgNVx4nAbM5xFsFDICbEsl4Ug+W6RAA6ACqE0RlO6ZrlFp5vyhaD376H+oojtae5Od/2LlXoSEENNmJnpUtTkuwXSvI5BwGA3aFfzaA+ZrB0ZSVHlglcY1un+2TImkCpr2Xj/GRbbAZWtIcowsiC+11eCndbedYnJb9uISzRzf5/XrvzMYBmJstwoq8n4uTFUWm0UW33QzDw8HxyWGtEG234WsrQeqH4U3uILBk682UTNkUpeYWDdEfDe2f0o+29j7SR8zMp3408g77A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUuXTP/4gZjkYMTRc0uBLRyhgtLxFJHwCv/pmR+9UaU=;
 b=BESGiBi6mUAmfquXNtNOyGQaCdGyyKnhLARNZTyCX7G+0CPdRcBH2mBTrLyQstURrG9I4gZ5NKIlkSsUArT/jk5CNO36tMDbQPbwNeVqetozp0HZd2HHROEZX+cIceDtox2rso8CE4Fw2c0F+p1LrTjWCYvpMesmY/U8E30RZcw=
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by MN2PR11MB4663.namprd11.prod.outlook.com
 (2603:10b6:208:26f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 16:28:49 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 16:28:49 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Tian, Kevin" <kevin.tian@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH v3 3/9] x86/virt/tdx: Export Dynamic PAMT helpers to
 tdx-host
Thread-Topic: [PATCH v3 3/9] x86/virt/tdx: Export Dynamic PAMT helpers to
 tdx-host
Thread-Index: AQHdcmBzfnNNBOsssEO5eV+hlKk1K7c7hUkAgABlZAA=
Date: Mon, 23 Nov 2026 16:28:49 +0000
Message-ID: <305d702ec6b5ef383115d3da9767df1ea6860da8.camel@intel.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
	 <20261112043054.2664857-4-baolu.lu@linux.intel.com>
	 <awQUsufmV3NipqGX@yilunxu-OptiPlex-7050>
In-Reply-To: <awQUsufmV3NipqGX@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|MN2PR11MB4663:EE_
x-ms-office365-filtering-correlation-id: 808d710e-d846-4cb4-9ae1-08df497edaa9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|38070700021|10067099003|56012099006|11063799006|4143699003|261026121527099003|261022075727099003|261102130727099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: KTae0Gmjwvjh/IGQ9/qjGIUbkt7gANNH3uJPKWwJN6Ph1y2cLLP0761WigK99uX157FBji0s6zMbFyTt7Uiw5TLyDZvnsYEtNHdOMe6PbIcENsLhf8GkhhgxBWefX6QRBWOPf5nylspNypguwNkw6mkbeohwb07km0Wiqz86pvESmWKo6/VyNbRRooY8NCOvjRLp9kbmcI+VquMqn9NGbSM9HhrMoEsH2zMJtwzbAI0Ulg8w1/2OsraiGOcNJTWT4T7oXjiWfN4HBvS0OVZGQiEQLzho3geX3aHo2XMjOIU6zEH/17aPfImDSzVamQ+Rz1X1K6z/pIzv4APazmGqdqR8PEsM3KpAFMxPPlyOshxe2W6MFWfjDnaWl89T9bU7ePA/hM6C1ACOE0DnW4QLx7ztjLMevjFKNliODwONmgcIeCw6OBIAvWLXjyXBMpKQH4aGkBL96HFsPTip2JEN8v6TawmPefyKraITY+saVEeLVTBDMhUrbrkL4+dmVr2vopC0tVhZAWOSNT0pyi2jdbOWL1rhjRAhGzaQPA8EuOQKhnQ3wq8n/8RT2FgFRomcTPdWlXMMadTwGAwtle5pA/K7EcPYnpLYJwVo3clbDR4ugR1WjxHh53rI3RcsPhWikE9h+xqEr7ZslYsj2lGLTVWoFx5anGTS7fU6QKrZT4UwKlGzySQFtwkFIaymgMdBL2F4WuuqOabVocUCSVgfT+bX8JDUIZlZ+iKub5DK7xs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261022075727099003)(261102130727099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFBlV1pSZUh0SnVWdHoreVRoTlg4SzB4SmJxWEIzYzIxcHd0Q01yL3hHNkJG?=
 =?utf-8?B?clB1NGc5UDhjejdPSVc4ZmVGdmlDWE40S0l0SXFTSlBobkZpa3NUQ3lpc0J5?=
 =?utf-8?B?cEhJbDRPcWFWT01lbnVWOHBtQVRrMVU3YkZlenl0aW1oRFB5ZDgwL2hDaWp0?=
 =?utf-8?B?UHRnVnM1TVBpc0JUUHd5R01yYTdHSXZXM1F5UkpESWZxMHRqSXYrcU1ERU5U?=
 =?utf-8?B?cHZRRU42ZWdYNzdLMkc1ci8weWU3bEJ2cjJmUEhNK1h5eFlpMTJZWmNwa2pv?=
 =?utf-8?B?dzZLa3l4eGNneE5OanNuNVkxRWFlKzl0allnbzZRWnIxRzFPbnVrU2NZWEJm?=
 =?utf-8?B?UGJxTnhmbXZOS0pHdGh4NFFSMjMrL3ZLMVJsTnJzNldUUnhBNXhmY1gyeko1?=
 =?utf-8?B?QWVHbGxEeFRESlBpYm5udEh3YlJueG5aYUtBRjlQWmRRQ01JRUxSaVJGMENB?=
 =?utf-8?B?UlA2NU1UTjIwdGRrZHNzS28rcnN1blBNSEdZRG1rcXZvTHppZlRMY2F4THRM?=
 =?utf-8?B?dWR4MnZDemgySkNhM2FNSzBMSHBoUEEzQnE3Zld4U3BjS1RXWCtBcktsU05G?=
 =?utf-8?B?R2lSOXZDNXZmN1VtMHZHVUxSWEx4b2ZNYURWNi9wVklKZXBVb3dFSjQxZWVt?=
 =?utf-8?B?dzJzaXpXVmpobUI4Qi9CcG41M0pZeHdNTytJcUx3Sm4yWUFWVE9Xd3g5ZVlM?=
 =?utf-8?B?NDFqeVZyOWVVSmRyRE9ydWVKdU85dlZRaG5WLy9TTGZOUklMNml2eEoxdzNu?=
 =?utf-8?B?d3dJUEgybS9PVDJNemltUU8wWXRhdS9lUis0RXVZM3ZnVmVnbXAwS0ZENS84?=
 =?utf-8?B?R1ZlWmJ0ZFdCWlhPK2JKOFRjVmV3ZFBFV3ZEbXZlRGFldHNRTkp1L2xXTnV1?=
 =?utf-8?B?VnV4bTlSQXZ1VU9LdnZETFI0TG9QWWJ2VFFZMEdTS0VmK2V3bVU5bzYvcVRW?=
 =?utf-8?B?RWJ1cEV1MGpVMjZzUmYzRDgwRDdPZWtaSUJoc24wQzNxd1Foc3ZNMjRTY0U5?=
 =?utf-8?B?VzVhdzMwNkttckhFa1J4THhkVTdRSkpnTk1QYWxUaDc4a2U2VEZBZGl3d2RW?=
 =?utf-8?B?TXJlVTYzc0gvTUJiQ2k4TDVldFI0TytuRFZzbWo5YUJ4WVpsdFdkcysySEJ3?=
 =?utf-8?B?NzB3TlhPczErSk1aUm5SazBmczZLSE43bkc2TWdpL0g1QVJHemM5a2hSck03?=
 =?utf-8?B?L3B5Qlk4LzB3dW5vWDVXdEFoTXQ0VDRkQytaVkZlQXJLWXo5YmF2RXpFSU8r?=
 =?utf-8?B?WlhVMjIyQXRrWFhTSFVBR0cybWg4V2ZSZXNtYzlTcXRoNVhIUExzLzFWUjVq?=
 =?utf-8?B?UVdPY0hrellwV1JZZzM4NURKZEt1d0FTb2t1TWpPUFFjeEVXZXNqbndvQlM2?=
 =?utf-8?B?VlZldUg3UVE5ZkJQeFFGdVM1ZWY4TEZGSDUrUTU5eUtrbE12aVJJTEFmOXhz?=
 =?utf-8?B?M2s4UExnQ3RTTWlmUzRXVDdLckx4b0pDanNFR2dGa21YL2VXVldHVDhkaUtv?=
 =?utf-8?B?VW0yV3o4Z2E5cEhTQ1Q1NGkwWGlwOVB0Zm1idVdHNUZMWjYwMWNiemQ0dkxa?=
 =?utf-8?B?eDN5TWxVbzMzL2tOcmFCN2NXMk1PN29tWVhIcHNWc1p5MVVFMWlVK2hQQ2Vr?=
 =?utf-8?B?aVlsVVYySUFYZjEzODZxQ2E3bjl0QzlKRm5nNHh2OTNyZUJISXZlQ2ZKQXBZ?=
 =?utf-8?B?WG5GLzNzaUNBU3paRmtkdjVHOVVQWndUOFB0WlQwY2ZvYWZQa29FcDgwb1dh?=
 =?utf-8?B?K3FrWUFZTVJFa0RMcEhIWllLQTlLWE12QTVxU1BoVThIUC95SkltSncrOEhn?=
 =?utf-8?B?ZGJGZE51L2pyOXpZbk91MmxoTmRvbHVyUUMweUVwNFl6UG5hZkIyN0RyRFdw?=
 =?utf-8?B?L3N3Yi9YSC90Z0xzZEtWdHhDdnhBbmFMeGZkZ281TTJKZFlVY1oxdFJpdUQx?=
 =?utf-8?B?aGMvdFd0Q0EzM2VpaVJZYXFEK2RGTHFqNm50U3Z5RE16VXdCTzZWVEVPVW1V?=
 =?utf-8?B?aWRYdHNyVFh3VzNVbnJvUldKL1h3bUVLK25vLy9VdzAySDFxeU5yU3Zrakg3?=
 =?utf-8?B?YzdpUnliMm9nZjFZYzhvYmhpUjduL2xVNEd5NEg2UC9VbktyNkltMEwwR2Nq?=
 =?utf-8?B?T2VOVHg2aWl5R3ZzN3BGeTdEalBEMy9tMEsyc1NEdmtLLzFKTHAxbTRkZXRt?=
 =?utf-8?B?ZitERlVkaHh6RU9YRGZtQktGNk9vc2xjb3JpMmlFYnpTeEpIOGR3S3U0N3l4?=
 =?utf-8?B?NmoyODlGb0ZjOGhjUzdyWGRHSjhObG5PQmhTTXVzZWVSTjYraWIrY29nWHlO?=
 =?utf-8?B?Q3ROaDFRZng3YThmV2c0TjFmQ3h6OXIzU1F5V1p2TktmZ2Ftby9zOEVPdjRH?=
 =?utf-8?Q?z6qn5uSegkd9SChw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DA72550B820E345B1A72854EF073FF4@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: HQlnJxMhnyQOOUW6TgFdr/OqoEnH+u4Ytbwhkq2ruHNK0QBvy5vRTtmU4M0q4bmj4EuznM3v2/E7IA9T3mTzttLKaqjj7DR2UbqW2Pd/akTbmqmsxyHYzjK8oOfsEUs5CTCx+GMrn45DSSRfKO4trQfYdkE1zAtm/RgA4E7/FvdFB8u2fZQv71Y9BLIFvzp+jBeorqKQ5Zl4SJ8wgRUqQze1YLFSrPugkMMaNq5+nsYow4wIGSJqeD0Y3wJAWVmiJpcy3N10tInlgn/Mw5Xjgy+R6MSsyn9mB0WW7zgCAsJJHFC6Xlw9mZe95Ik3UNDJKy4p4GQhiUEjzIZ0ci/dCw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 808d710e-d846-4cb4-9ae1-08df497edaa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 16:28:49.2092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FQIIJbIK9xpmM6so7iL8oMRcm9ZYkaAkUKOLI7ZhYg8cYAtRaQcXU4H1bzVL7UZWjq1jFIiExHaiitQSGRuysXwmPx8DGUE/RVh21qQL6eI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4663
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTExLTIzIGF0IDE4OjI1ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
VGh1LCBOb3YgMTIsIDIwMjYgYXQgMTI6MzA6NDhQTSArMDgwMCwgTHUgQmFvbHUgd3JvdGU6DQo+
ID4gV2l0aCBEeW5hbWljIFBBTVQsIGFueSBwYWdlIGhhbmRlZCB0byB0aGUgVERYIG1vZHVsZSBu
ZWVkcyBQQU1UIGJhY2tpbmcNCj4gPiBmaXJzdCwgdmlhIHRkeF9wYW10X2dldCgpLCBhbmQgbXVz
dCBkcm9wIGl0IHdpdGggdGR4X3BhbXRfcHV0KCkgb25jZSB0aGUNCj4gPiBURFggbW9kdWxlIGdp
dmVzIHRoZSBwYWdlIGJhY2suIEJlc2lkZXMgS1ZNLCB0aGUgdGR4LWhvc3QgZHJpdmVyIG5vdw0K
PiA+IGhhbmRzIHBhZ2VzIHRvIHRoZSBURFggbW9kdWxlOiB0aGUgSU9NTVVfTVQgcGFnZXMgZm9y
IFRESC5JT01NVS5TRVRVUC4NCj4gPiANCj4gPiBFeHBvcnQgdGhlIHR3byBoZWxwZXJzIHRvIHRk
eC1ob3N0IGFzIHdlbGwuIEEgc3ltYm9sIGNhbiBvbmx5IGJlDQo+ID4gZXhwb3J0ZWQgb25jZSwg
c28gcmVwbGFjZSBFWFBPUlRfU1lNQk9MX0ZPUl9LVk0oKSB3aXRoIGFuIGV4cGxpY2l0IGxpc3Qu
DQo+ID4gT25seSBrdm0taW50ZWwgY2FsbHMgdGhlc2UgaGVscGVycyBpbiBLVk0uDQo+IA0KPiBX
ZSBhcmUgc2Vla2luZyBmb3Igc29tZSBzaW1wbGlmaWVkIGludGlhbCBpbXBsZW1lbnRhdGlvbiB3
aXRob3V0IERQQU1UDQo+IGZvciBURFggaHVnZSBwYWdlIGZlYXR1cmUuIFNvIHdlIGNvdWxkIGFs
c28gZHJvcCBEUEFNVCBzdXBwb3J0IGZvciBURFgNCj4gVHJ1c3RlZCBJL08gY3VycmVudGx5Lg0K
PiANCj4gQXMgYW4gdGVtcG9yYXJ5IHNvbHV0aW9uLCB3ZSBjYW4gZGlzYWJsZSBURFggVHJ1c3Rl
ZCBJL08gaWYgRFBBTVQgaXMgb24uDQo+IA0KPiBmb3IgZXhhbXBsZToNCj4gDQo+IHN0YXRpYyBp
bmxpbmUgYm9vbCB0ZHhfc3VwcG9ydHNfdHJ1c3RlZF9pbyhjb25zdCBzdHJ1Y3QgdGR4X3N5c19p
bmZvICpzeXNpbmZvKQ0KPiB7DQo+IAlpZiAodGR4X3N1cHBvcnRzX2R5bmFtaWNfcGFtdChzeXNp
bmZvKSkNCj4gCQlyZXR1cm4gZmFsc2U7DQo+IA0KPiAJLi4uDQo+IH0NCg0KWWVzLCBsZXQncyB0
cnkgdG8gbWFrZSBEUEFNVCBzdXBwb3J0IG9wdGlvbmFsIGZvciB0aGUgaW5pdGlhbCB1cHN0cmVh
bSBURFgNCmNvbm5lY3QgdGFyZ2V0LiBXZSBjYW4gYWRkIHN1cHBvcnQgZm9yIGl0IGluIGZvbGxv
dyBvbiBwYXRjaGVzIGFuZCBrZWVwIHRoZQ0KaW5pdGlhbCBjb2RlIHNldHMgc21hbGxlci4gSW4g
b3JkZXIgdG8gZmFjaWxpdGF0ZSB0aGlzLCB3ZSBuZWVkIHRvIGFkZCBhIGtlcm5lbA0KcGFyYW0g
dG8gY29udHJvbCBlbmFibGluZyBEUEFNVC4gSSB3aWxsIHNlbmQgYSBwYXRjaCBzb29uLg0K
