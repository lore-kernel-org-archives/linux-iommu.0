Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA3128A3FA
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 01:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785115892; cv=fail; b=fGB2GvxxEFh3/PmDEtnzwauc1Ixa2PHyJubuaiDcAbvkZ6eqzltkrS8KINmkxVXzHXYe1tcceYldPuZO0S0ObJaEIjOWjKq1G810m4uOKsDZmimu9vNhVl50e+cF6W6bX/uxH01M9IBpr+DNeGDojyv49gBDfgUnVY2YjXU3XJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785115892; c=relaxed/simple;
	bh=1XUNUYWnFAnaqVomLXu3mCRBCr9J2tR9MP5kom2223c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iRYiCq0RI7mcQGB60dm42T55E4QY4rVy0dFqTCn4JjeXPghNnr6t5CGbu5hC0wZG52b5LZCsZBnLA5NQkDMmNm5vklq1VJwdZpLHm16L/yjsPTM3pyKhj1nIzjgnJ82IJOMngfM40jSqn6mSS7hBXCBRdzvm6Jkd313bTtHB5RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MxOyoFx4; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MxOyoFx4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785115890; x=1816651890;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1XUNUYWnFAnaqVomLXu3mCRBCr9J2tR9MP5kom2223c=;
  b=MxOyoFx4PwmfBjmiBEht8FIYEBj77JHOygkhpw8ocK3D3L6v7pkrfU7A
   a7Gc6BGhn9IPq7vqula1iZFvt51npBjT09T+YCXuipxLQ6E4c3uN2GUFb
   JZs5CL63+cRtpwhsq73DAMpnzFMYNP4y917tR9nTB7ihmJdqyc6JLf/Tx
   ciUYarnNCCHZgWZ0NDkQWK5iRPVwDdTPSVl0Z8ofTz3oubqSq6qO24kim
   ti4l5Vs6Q3Sy5nrIWgsL/9dqdsOuGkovW7SQyxayk32E27f8xJxOqjgNU
   2f663rlaxVchf6F0bw8Dv7OEIiVsye2HxXOGOxkQIvKpEK0Cq2XpOW7/5
   Q==;
X-CSE-ConnectionGUID: FJbNBf0WRm2AMw+IO30uTQ==
X-CSE-MsgGUID: 3fPUT4+OTDS10c8UsVvC+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="73221608"
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="73221608"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 18:31:30 -0700
X-CSE-ConnectionGUID: ucaP6YebTq6Gt38KMCWDog==
X-CSE-MsgGUID: xdgOisanTfa7otGCptPEmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="264271600"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 18:31:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 26 Jul 2026 18:31:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 26 Jul 2026 18:31:29 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.67) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 26 Jul 2026 18:31:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMQ9q/ja2G4gO29GyhgASNGsHXHvhPcak/rId8dR6vYkDTD3I8zZSEGjKDW2kyoRTNUY++CxLKLq9RRafYd4Wqic6K8C1v7DLI/py5x+y3CLGvNui9ZMnM4boWCepghaUDKLhTsqL0s32rxI4mGq/vWY/oPEjs2cBSLI8bRL+Zs9M1khtORV2OWt2oZ87QqJXr0BppdFH0Acaz/ekwpDzdPBFd28GI8we6GwYD1RAxfgPo6iHz7p5IIh7jXZQ0QwhKpGfbou83oxFiqlyWUAo+N7WZZ+C2BoeTE4t5/O8K9GfM1irOA502xnjy2FKEA8ytllj1c+uH0XQ1bz4D69qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XUNUYWnFAnaqVomLXu3mCRBCr9J2tR9MP5kom2223c=;
 b=xAVqQbm2D+M7LOIz33wXVA0AYOQpHNc7z9rczE8bJ3C8Q2P2k8ZXjZdQpRQC/f7wsmEosNiNX369MHCkfQd8ydP+9pqkxiuSg1ePoiaDCOwQDA8p+FSEooYK2E2lJuJ0g0/BoDxhtkfbKnLoPjbKNYuz1Nrp0sT0aKIqfFBv8w1VsRyBvr0S4PwlVvvYXHxEWUGRBEtU3BBvpnutGiwIZZH/3ev3X97nYiyEvjhsYT+6evHrnxmKJMhdFTW/9LkpgAWXrr/B5QiFub3pXQ8p3EbU09Nqkk3qwqvrKhwn2FmTNjTfpWT7k9FMLikjY0H0lf2e2+xuPBa1t41GoxwNdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by SA1PR11MB9635.namprd11.prod.outlook.com (2603:10b6:806:4dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 01:31:26 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%7]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 01:31:25 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Oliver Lin <oliver@liuxiaozhen.dev>, Baolu Lu <baolu.lu@linux.intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v3] iommu/vt-d: Disable IOMMU by default on Lenovo
 ThinkPad P50s
Thread-Topic: [PATCH v3] iommu/vt-d: Disable IOMMU by default on Lenovo
 ThinkPad P50s
Thread-Index: AQHdCs4JfDSehXNb9ECNVV4qDvRlYLZqv7AAgAAJBwCAFfBgEA==
Date: Mon, 27 Jul 2026 01:31:25 +0000
Message-ID: <CO1PR11MB48354FC225C295EFC745EEF48CCC2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <b744ef83-6cab-4f4f-a22a-251e08b62656@linux.intel.com>
 <20260703092348.17583-1-oliver@liuxiaozhen.dev>
 <775d3d16-f43d-4a5f-9629-4912a4cabd91@linux.intel.com>
 <0c9256b0-19ad-4d1d-baea-0ccd3b827d0f@liuxiaozhen.dev>
In-Reply-To: <0c9256b0-19ad-4d1d-baea-0ccd3b827d0f@liuxiaozhen.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|SA1PR11MB9635:EE_
x-ms-office365-filtering-correlation-id: 22e42b2e-0884-4fe1-037d-08deeb7ec647
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|38070700021|6133799003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: rF6AW9gNXZEtFX/4SJyi/pTaT4Xcy6/bztHn3sWb1Hu+YsdmCwoIzQDDSnn1U2jbI+PhBcL4GDPxfBZJDNo0DHYowkg4G+i/e4oRg0lZItMbN2WtbjhzZ/yuKNyYJdDcsYYmM3ODAcXsiQnrJJxCz4A/CYMjvZP7gCoU+Vxgs54oFE5U9wu7e+XsOsH6m1j6a7AzEW2xtdXwhYOGPxBKywY2Fw4KU/SShIWYjVO4PUWWUWbfnIY5GB5nw59H/aCTZYqdrZdcxrnZZzEhxIi8s8sTrkp3DjsIXTHfOelTOFT4+nwz2JO33DdLXcFHH3deuePpPWpbl+YfXUcJ/e8UIjt1NWplFLrO6IHPKKWNh/mI6hbSDYaK89/XfzL+5uJn6Vdqiqjjcwyco5x/Gor47Ur35mqJC9SM8Vfxm/iWgqo17SSMNqLs8cosn+4JBP+uc6ohZYkQy3VrGP/t3Yoy11+rPUBxCmuLrLiBVPJbvxFT9aRYEcfdXXzlB5nXbELmckNNAWTYLAVA3+4amHh2OTQVcELO2zhLhVJ6GfgFTnh4d0wWLxBWQWR5ML0Fc2OYzBujAtAZcZFhHHq0CGSISPekwCKzSzVNiJwGK3yPBi6i5Kl2XA10mdsJhzObuGBEhp8MQEtMlG+N/WCZKyPqgc0EYgEiEepG6+UcIdRzoWgDvTzvyiqo5xgIHbwPZYsXOBudaxNMs/RVDiX1DvkXhTflUUZ+q0SbLcNwB+AW6Vg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1NPRUVyV3pLMmJGWTRNd1Y4aEpVaTFJaCt1S2tGYkQyVVhwWkxUSTEzUXNW?=
 =?utf-8?B?Z3pETWppZ0U2NzVaY0tncVpYOTZRZ2tiZXhZVmZlTGlzWXBvbUNGbU5CMXRD?=
 =?utf-8?B?NjlVYS94MlJjcExJSXl4RFc4WllUbjZrcHNZcEUxOU9hTGdKdHcwUVJlQ2NT?=
 =?utf-8?B?REY1d1ZlVFB6MnJEUVNKcENkWkY1b2poMzhwbndqK2IweUNxWk5hU0k0RUZ3?=
 =?utf-8?B?cVFkTFI3OEpMQWw0aUF6R2ZvRXJ3cHNtZTh3cnpYUGVPd3BNSjMvOVNibHN6?=
 =?utf-8?B?Qll3SmRkK2hUbnJqZkZNa0E0a3Z2U21meWZsTjEzaTFsazBMSGNwOTlsTjRJ?=
 =?utf-8?B?bzVkVU55NE5uYnloUkRmK0RxT25BSVlwcGt3a2dDYWZ3aktNbkk4S01xb3RB?=
 =?utf-8?B?WVU0ZWxEd1hTbUNseGhzUUNncmVuck5acTloVzZVZ0ZSZU1mZ2QwaEQvTVZt?=
 =?utf-8?B?K3NzUWdUYi91dHpVdXVMb1RmcE9qL05hb255Q3lOaDk1OFo1YWp2VVBzNWVC?=
 =?utf-8?B?ZU9tS2c2SnNaMHducWdyQS9nOU83cGUzTDIvaGowREtmU2Zaeis3anhFaDlo?=
 =?utf-8?B?djgrS1JjTDJobHQydjdyVk93QW92VXgzcWxlVEN1SVgwTWFJQktrUVNkYnJB?=
 =?utf-8?B?ZktmdzJ1K2RHWVlWdkdETU5kT0JMVTlsQWFtMlByU1BTaXpXejM0WTFsemtD?=
 =?utf-8?B?eG8xb0M4S1dVMGovUkFhelV5aXZ4Yys3QXBOU1laTmdUZWtORkxUalN4bUMz?=
 =?utf-8?B?RWN4MDI0MGRQMWJqNTJaZjlJWjAzY1kycEptcnVmN2JMeFlETFJRQXBtYkRy?=
 =?utf-8?B?UWhybzhUWVA2azVybmEzN3c2YzFlZWtNVG9STWFmUEZjL0NaNGVqQXBZTWx1?=
 =?utf-8?B?QytNMEtkUXRTaTNJK1lDZzl5QUtNRFR3TXBCWjV1UXY3SHViQUQxQkxncXhm?=
 =?utf-8?B?bm9RVGtiR1ZlRHZnZk5Bdk5ubHFjOE5mMWZOR1IxL1RHNWFOUlRIZW1KY3p1?=
 =?utf-8?B?N0VyeDdiOFJxV3IrakpVU3Q0VXQvc21Bdm8zSzE4UWh5dVRZOWVmanFPc0pX?=
 =?utf-8?B?OERNdkZ2NHphbU9QZjNuUnVqeWtkVnFSUXJ3Um1XQW9LdXRWOHBUWE90OXZm?=
 =?utf-8?B?TVp0ZERycGpIcVEwZUZNSXRkelhLWm56di81UWhLZFNhWDRzTkN6eWlETElh?=
 =?utf-8?B?R0NnZzFoZnlVb0pWZzJ1WkNyMVQzR21waUxJSG9NVk43M1Vmd1dwaUljb1Vr?=
 =?utf-8?B?WU5XQTNzOWpreko0UlJXRzdENUttaHk4aGsvL1lUMElvS3lwTlNhdWVpcmlW?=
 =?utf-8?B?OERnZnRuMU9hSkFhTkd6ZFhzdkdLWHI1ZHZQTkFBbEx1RmdFbmRZQzZmbmhD?=
 =?utf-8?B?TEJzR0pZYkszcTR6Z21ZbUNuT1EwZnEzUnpaN0tPUmlOY2VzekN2azcrdnhB?=
 =?utf-8?B?Z2FqTVZ3ZUkweXI1SnFZZDgrd3pvRXh2NWduY1JVVEtpenBKVDNjeXB4WGx3?=
 =?utf-8?B?c2RpbFBLa2wxSG1XL0YrSXgybHR2WXFaekVuZmlTVHR3QWlNS3NWZW1rNEhv?=
 =?utf-8?B?RXpxekNkSmQxMThlcHV1VXlrTllmcUdraVFrYnBjR01Cd041K1NLY1IvaWRJ?=
 =?utf-8?B?NXZLL25VcUpUZE5ISkhPRnhkZFg4NmE2UHlQbTJUUjRYcUFSTWtSbzhyMzFX?=
 =?utf-8?B?RVg4b3JXcW5ESFJOWG5tN0toM2NmTytzKzh1ZkhMSTBIYmNXK2FqYUNHM2h3?=
 =?utf-8?B?Y1pNQXMrTVE1Z3g0L2JGV0NWME4vWG92NjhWcGR4aDY3aEY2OG5TV1pHRFM5?=
 =?utf-8?B?dzM2TE1kMm5pVjdmWHREbU1MZ1A5bzk4YW1Fd0FEYXFyRk9JOTRaTU5vMTdQ?=
 =?utf-8?B?RlZCNy9hUmt4T3VPOW5RSGpYQ0V0ZjJLeTZYRlJoZlUvVk9BTklpTWJUdm5V?=
 =?utf-8?B?S01ROTVQc1J2dFFTQnFnUnVTbkx3TnY4Q2o4Z3ZKaXgwQlFJMUdmeklXTm8z?=
 =?utf-8?B?NGd3ZlR2akQvSktYbks5dTZCMHJ3YWhDemhmWGx6azkxSEpKS0haMzlEOVFJ?=
 =?utf-8?B?dER2aitJNlN0M3k1bGlma1NWZFZGUDJqTzBEUi9QUDRlR2xxN0VRMy9PMEFh?=
 =?utf-8?B?enRXb01vdEI5aXdNY1gzczZabTRyU1ZXZ3U4aW5SR0xrbHcyZzdIMnFYaEFG?=
 =?utf-8?B?bUV2WHBJZHVmNVg4UTc2bXNUa1hzZk9Ua1ZRMWV3U0N2QjBBL29TVGlGcUxq?=
 =?utf-8?B?SDBDV1EyNVliSXd2SHFrQStCbitLdkt5cjZMT0ZoT1dxV1B1aStoOHlLREZs?=
 =?utf-8?Q?ZbUHnVUU8HtNPiX9kQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: I70hrBQWh1M9LyepquM74C9C3Zt7GaCZXrRgnsC1dxZdTo8wJ7p9biAM8nH6VuLcbmHNmQbDFAeN/lg4pF9yPaV6oPJXf7hjn4W2U72K3iL1AW/4+bEq4bfeW0VWWG4IzAJ3BaCcFi4QPPEFFHAo2Z4O8W2YzXb46hXGHMraYw+cy7hSFNyH4rXqQa7rJUCEaPc7zca+4rMQHkvbDQsKYjn+h7rdb4koSt9GpxRF4pR02RXmqtjP/2NbOkDoWh/lVVf5V8VZ+PnqPeKJm5pnu5/pFipAnrJpgy/KA8Nsvj+W4E6nOgMAwfO9ulrS2iXJrsci0GcaLobwd12YDcCHBQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e42b2e-0884-4fe1-037d-08deeb7ec647
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 01:31:25.7585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5V1Z4EH1ZGyHbO5j/PDbXhV1NMGs6ifQRD/sjka2201N9l7sFu9VTpQkKQSyscezHsysIeth0MFDdhwJj62GmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9635
X-OriginatorOrg: intel.com

PiBGcm9tOiBPbGl2ZXIgTGluIDxvbGl2ZXJAbGl1eGlhb3poZW4uZGV2Pg0KPiBTZW50OiBNb25k
YXksIEp1bHkgMTMsIDIwMjYgMTA6MjggQU0NCj4gDQpbLi4uXQ0KPiBUaGF0IHNhaWQsIEkgdW5k
ZXJzdGFuZCB0aGUgY29uY2VybiBhYm91dCBkaXNhYmxpbmcgSU9NTVUgZnVuY3Rpb25hbGl0eQ0K
PiBiYXNlZCBvbiBhIHNpbmdsZSBwbGF0Zm9ybSByZXBvcnQuIEF0IHRoZSBtb21lbnQsIG15IHRl
c3RpbmcgaXMgbGltaXRlZA0KPiB0byBvbmUgVGhpbmtQYWQgUDUwcy4gSSBjYW4gcHJvdmlkZSB0
aGUgZnVsbCBETUFSLCBUUE0sIHNodXRkb3duLCBhbmQNCj4gcmVzdW1lIGxvZ3MgZm9yIGJvdGgg
Y29uZmlndXJhdGlvbnMsIGFuZCBJIGNhbiBhbHNvIGxvb2sgZm9yIHJlcG9ydHMgb3INCj4gdGVz
dGluZyBmcm9tIGFkZGl0aW9uYWwgUDUwcyBzeXN0ZW1zIGJlZm9yZSBwdXJzdWluZyB0aGUgcXVp
cmsgZnVydGhlci4NCj4gDQo+IFdvdWxkIGFkZGl0aW9uYWwgcmVwcm9kdWN0aW9ucyBmcm9tIG90
aGVyIFA1MHMgbWFjaGluZXMgYmUgcmVxdWlyZWQNCj4gYmVmb3JlIGEgRE1JIHF1aXJrIGNvdWxk
IGJlIGNvbnNpZGVyZWQsIG9yIHdvdWxkIHlvdSBwcmVmZXIgdGhhdCB0aGlzDQo+IHJlbWFpbiBh
IGRvY3VtZW50ZWQgY29tbWFuZC1saW5lIHdvcmthcm91bmQ/DQo+IA0KDQpUaGlzIG5lZWRzIGFu
IG9mZmljaWFsIGVycmF0dW0gZGlzY2xvc3VyZSBmcm9tIHRoZSB2ZW5kb3IuLi4NCg==
