Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDDA3515E2
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 04:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785124999; cv=fail; b=CBKa6VrB8Cq6luf69vyPfPLE1j4ONj8wCPdzToeSk8G0Q3YJUc4uEHekFQGiWBR7fCVQoa2hQqQB2XHBzJ54rUjXKcrn7CNsxH85iOtUGS8U0IJLQg/mZhI+tLgMWhr9++V5UY4khBnTuqsCQ1MAPufBdv4qEo5sBC75lI0MzQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785124999; c=relaxed/simple;
	bh=GlFTF29tuenuOEqjShmBteojDmgnjE+Fv7+YOXOe+Jo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KB2tjhH1K4mhbzuKfkTLbWooLpqnNqVTJFt+ztXD53e0c3bdQTCtm1gdIyg/BswPZIS7Ohgg8/oE+J6W4haE1W+Jipris/4PE3wlVdeibgisOGGRtjseSUwpZzQ7Ir+pE0Rm23S6ATGnOmQhsyrmsv3+yd1KP4Fl7FqAL2HWz+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCqLgFOF; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCqLgFOF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785124998; x=1816660998;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GlFTF29tuenuOEqjShmBteojDmgnjE+Fv7+YOXOe+Jo=;
  b=mCqLgFOFhnFC6rr8jg0NneUsDZ+FTTXB+12EHy/lEvMrSXLA4U8sPmGS
   3JXjICLb9x1ZpcrLw5+rlioNg0RS5FYr8YRPPS5RCkxNB95lmYNPn1sKy
   cRO+tezi96BHbF+AB0XNbcn6BGQZBWhTQRidrpX1oh5OUe5+Mjegx8PFB
   McuKd2mM61YPXY6DKNWciiAcgr3lpV8LPaayiINMbMGpCr5x2wUTb/02Z
   ykJA0mw4ed1w9fqzJSSPzYmob9kMyEPcz66Zqj81qlEWr8CEgZDwetiNy
   YY9T/lGAD/vccbJdvfnnpRE7v9awCn4yrE8sz0ciXGnGFe0Ffs6yerNsV
   Q==;
X-CSE-ConnectionGUID: 91YVjUa/QaeQ1JfUhN6FQg==
X-CSE-MsgGUID: kRR4brzDR1q2XIhuVQNlNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="85631272"
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="85631272"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 21:03:17 -0700
X-CSE-ConnectionGUID: lw2So9FDQxOodPvBlr0bww==
X-CSE-MsgGUID: pa7k7MWTTUmCL/cFJa40mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="263592553"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 21:03:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 26 Jul 2026 21:03:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 26 Jul 2026 21:03:16 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.11) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 26 Jul 2026 21:03:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=US58KNX2y3qBUCrRXd9sTnwlLE+eJK6didiYqBtWh/YIA9SGLYWBeg+MCu+PvShFWyMLggEW+JMgUNI4Ugpw3F20cgjLc2/h//58GRg6ngXbULlFIvjV47Wdj4biVYz6XbUikSbrz0z5r8ZmPEtoCviTukozTHwINpPS8U/GJvMKeYK5dymhN6nbyFOCwe2FyepuBN5YQVwy49CoeziJITpS2SumeuDMSpVfOfMK0GEIxrQaPueScZftN8LLfMOYEvubLvY8R6PBRrYazIgxBVlbAI6qqYU9gbKRSoi3hpOkyTbFnt5yLBvX6RGhEMzRtzr0aBNrR2gqNIpWqj2ZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlFTF29tuenuOEqjShmBteojDmgnjE+Fv7+YOXOe+Jo=;
 b=CaYfWOQK58FtrxQ629z+AM0BfUlR+WAO1JwYbo8EVk7wHYkHzQzeA/xpVUcPvXMJ2b4XV9tmxXFRX+41zGK8OQL3c4AWJj5L4491Avd2wBTenHZw/w/nFE79u60hEyvE6LjY57VHGB3m5cvbch4361M4cgTg6g/XvD1QtnZgd6dFs5FHh734pwnGZzy9sQnStrYGhpJS8mFalaKIRQGNqh1a2qldfO2LfRPwLOFS/U0SolliL2bij1fos5WNrsDjCjIDAw9id1wl/YpxUa41O96CcCq1fEkHRLq15YQ9VeMMEwh0lucE49cna3JVTTWg6wJTHINjQsD+asONqJtjIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by PH0PR11MB5159.namprd11.prod.outlook.com (2603:10b6:510:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 04:03:12 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%7]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 04:03:12 +0000
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
Thread-Index: AQHdCs4JfDSehXNb9ECNVV4qDvRlYLZqv7AAgAAJBwCAFfBgEIAAH3QAgAAJ9pA=
Date: Mon, 27 Jul 2026 04:03:12 +0000
Message-ID: <CO1PR11MB4835CB1B5633DD1E4F1011428CCC2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <b744ef83-6cab-4f4f-a22a-251e08b62656@linux.intel.com>
 <20260703092348.17583-1-oliver@liuxiaozhen.dev>
 <775d3d16-f43d-4a5f-9629-4912a4cabd91@linux.intel.com>
 <0c9256b0-19ad-4d1d-baea-0ccd3b827d0f@liuxiaozhen.dev>
 <CO1PR11MB48354FC225C295EFC745EEF48CCC2@CO1PR11MB4835.namprd11.prod.outlook.com>
 <19be3c19-9711-4cac-bc6e-c2b020588ec8@liuxiaozhen.dev>
In-Reply-To: <19be3c19-9711-4cac-bc6e-c2b020588ec8@liuxiaozhen.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|PH0PR11MB5159:EE_
x-ms-office365-filtering-correlation-id: 371d7fcf-8729-479a-eacc-08deeb93fa46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|11063799006|10067099003|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: c8eMwNqgcFjdI7i8cZhwGNbggbRwuPzgBN1g3kWeENYgkURqeHNtBo/Mhg42xSIBlVV8sVmEGJVYwl6Ud+6cJ7NFjXZR4IT5282Rn5EYD6Ow6XhkwaYVAqWYjGvi+UIOY8f+Fz/NZAl9LuS7OMcaOChzXf6BJ92rZ80c2A5ydsplX7ifqTLmXHMN13QNcGJJYXky6LdT0bNsw0uIFt7kzt4OHMD+TfFlnTxMcDZAcKHbYv3iiOLHA6TSIKqF+YklgK6oOCcd44+v8cqXkAsBcnmG+SAlJGYnFYKiN01SyC4NtI2UTYdlCmSnvEM+v0c1wNFFlkQI7UZQTCgJKg1DX+XyFKngJWZn+dHnxPro60lzTzFI/Pi1jrxAv7gG6HLY2u26KPHIUuN9MflAFOOU5bGh/Vld72yB+ZXooK9YlqV1bj3HLTkMPXT1poCzVGXs2/O3VS6ca8ytGFGJqLVxs6dudlHe7ueQoZQt59qmA26930jxxo82ff7+T3ZjvXdsWsuUcDUnMXXsku+kJqAt+clSQzDDVzJaygRZNNdZaK317Hbv2+V1StLse7xpidqCJFwbNU0oZsToJyh5+gP0AeLdBmJJAEJsX+FN8HEgAdJL6hWCgQmUNUZ/TfnWoM2ygG5hbtXN+uu6gwZlrAVCfZOiywKNdKPBSpYWf52EFfy6urHAmNG4OhR2DZy3mPmGk9s1sLGJY5LHO7zJg/VP9YL9OzVUig9W0wGMHSxnEv8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(11063799006)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHExWVMwczhES1BjeThhNW5ickhSTVYxdkkySUVlTUNVdk5HREdvZEJlcVBO?=
 =?utf-8?B?UlNJYmxJNXdWTmVPNHNsYlpJR01SL3lNWEV1NXNSYkcxRURSV3E5NHlPcmJx?=
 =?utf-8?B?TWZFelB6RUxLdXFCaXJJVkVTQmZDc25DWE9yanVrVXZCYnhaazhvVEZEcmhO?=
 =?utf-8?B?ZzM4WkJ5Uzc1a000SU1sbDY4OXZiVGY3NGthaW9TZEQydFR4VDRsOElqY3o1?=
 =?utf-8?B?MmlRWERLenhJU2VhTStrMlFML0FFZkN0RzY2WndlMFg5b21hZkFteS9NQ3Rr?=
 =?utf-8?B?MllxWk5hQ0owc1hZNG1Ma0ZVWGd4YjVaTEdPZkY5RUwzSE13NXhJR3IwKysr?=
 =?utf-8?B?ZzNPUUtQTW10NGszQWhTbXR1Tk14aGI5cSs5dG5NaHdhM3dYZmlmL3lqdXZ5?=
 =?utf-8?B?MjhQWnlKeE51N2lsM2VJTk9lR1V4c0xZMzgyV1RvZzFoUXAwdTJWUklZSk5v?=
 =?utf-8?B?Z3FXdEpWNG9kQnJ2OWxGNFJFSGRrTmF4bDJSSGUzQzd2dDE0Vm5hOU45MllR?=
 =?utf-8?B?TTgzajRlU2tVQis0eEVjc0FkQ2crMkxoRnZqOXJ1bHpvS3RHUERHaVBkRWxs?=
 =?utf-8?B?YlJOS2JwSGlKVDIydDh6U3RsQUZzd0RHN2NYOURCSUpac0lHdHdOZGNGSTRP?=
 =?utf-8?B?QmJKTS9IQnQ5N2xnUWtqbWlDY2lHQnlWRERuTHgwWU9PdnM2WnAvVmo3anF1?=
 =?utf-8?B?ZThlb3hMbEE1OWMzTXloMEJZY3c1ckRtRFhibjByTDYrYi9SaDVJZytqUEdN?=
 =?utf-8?B?c2gxaE5MR2thSEkxbER3ZC8vMWJnYzdDQnk0QmMvaUY5MnhTWXFBL2U0NUlV?=
 =?utf-8?B?MDZkNUl0bTl1YjZrNHF2RTY1OHJWQi9NVkhiaCtZYjlGU3VjOGEvc1AvUDJP?=
 =?utf-8?B?RHpkSmRtdkNhanZjeHo4b2lIMWVZMG5Rejh0UG1WSVBVdXZPN3VERjJlV3ZJ?=
 =?utf-8?B?SGY0djQ2d0ZWRnViWU8xK1ZsWUZna0lYZ21heTR2QVloUVRqTUlkaTdkYnJK?=
 =?utf-8?B?R2lidzFSVzQ5Y1o1UkdpNWE5VmRsbnhERFpPTll3OUc1RnR3MzM0YlkyVkR1?=
 =?utf-8?B?eTgyT0toR3ZxRGMyb2RIMGYwT2dEVzVtWnpZNndTSlB4OGg0ajF3MGtIV24y?=
 =?utf-8?B?NEZYSi9ZaVErcGxZNVZlYndDSFlKMjNGSVNWV2tBQVEyUUFpMmZOQ1JPV08w?=
 =?utf-8?B?bGppTnppdU56eGZFVi82SHJxaDhvVmFpbS9Ha2piZG5wWjZ4OHU0emZGMlFv?=
 =?utf-8?B?cGlCaHlTWWdWYU1yY3A5NmhTcGVxOW92UDBCSlpHOWs2VFQ1blErQW1kYllB?=
 =?utf-8?B?NStHUkorNTQydEI4akJVSW9lZm9uNGpHQ2NVT0VVN1RJQjZzUEZQaHRrV2dy?=
 =?utf-8?B?RERCN3NnZFh1YXZ6a3VCaG0vZmJkS25GUVM1TzBIVmgxOEh2TE11SVEwbGdM?=
 =?utf-8?B?dllKbUhuM2x3Ti94MGhOWjg2MW1FYzZMYi9PclpIWEs2SFRzdGwrSGZlTVNP?=
 =?utf-8?B?b2FYZDB2eTBCZStOMDJLRVdoSmZ6ODkrbVJwRSt2NTl4RzZmMlRPQjdlTm05?=
 =?utf-8?B?KzFiYUZjMll5N2l2K21ocDRDb1k5bWNYUHBucXlWZTdkYk9TaDNQanAyMHpQ?=
 =?utf-8?B?ZjRLdk5rWFNYY3FOMEpqQURoaUY2cSt5VHpJcUhHTWxFQnVIcHJNYUhYOGta?=
 =?utf-8?B?RmZKN0pUM245cWllam1pa216em1WQks5MjJGbkQ4OWgvUGJva2docmhiUUZo?=
 =?utf-8?B?QXpsTjlXV1RVODNpZ05NVDJYR3J4UCtQZWlvMk13cXV3emJkNldrQW9tRGlS?=
 =?utf-8?B?RzB2STdqcUt2cUVWa1lyeTh3TVpHMEwxZmJhWnZvbWQ2TGFUNm55Vm1zT2Ru?=
 =?utf-8?B?Zmo4dmJqeVdWZklRTWNJQ3lxV0U3Z1N1RFZjTm9CREtIMDlldkJMNVA5UEdX?=
 =?utf-8?B?Ri9VQ1Y5eGRwTHZOTDkzQzlIUk1SZFBvbFdiSzdlQXQ0ZFd6d2ZKQ0dneUJt?=
 =?utf-8?B?cVR3NGZTVzlIUnRwVVJBTW5BUjljMFpkcmIxbmZQam5LV0hnY1dFQmQ3dXpt?=
 =?utf-8?B?cnBYdGx5aFRvVWQ4OFNmT3lvNFh3c0x2Q1ZRSjFEYldHcUFZVTlNSlMxNHVa?=
 =?utf-8?B?bk00MkZRcFBaVEZpSlVabFdaRnp6bGxJa0NBQmZZcytaUnhISGR4bW15c2hN?=
 =?utf-8?B?ZEZsTTJpSkZPY1I3eG52WVVBamdMSVM2c0s0dEJRcXFDZzNBaUw1TlVFYUdU?=
 =?utf-8?B?NDQwMXFBTTRXaDlQSzBETnQvMHpGamI3T3crWXpTVXVLTnI1RWxaVTZaTXI3?=
 =?utf-8?Q?EaWMBo/7MUCsO6f50A?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZSgoUkEl4aRe8s48Fi4xHB1PEA1jnkEHdLuBNVcAnZ7L5iRywke3QXa1haZs3N1YNbYAzip2YB8wK/OZDaxQiZxwCWyFFp1bzTZrISEMb5bSAqv0Td5w1rYAhMySKsMmBX007JJS/HKarA5Hyow210WdYfuVIMMjE7WCY/1GNemia7rvnMdgStz3qIkUuSj0pazC55CFe7flOSZJzxr2nlMQchYc4jZXSaQ0DVUEsAuuefND/1GMxhQ9Hz7zLMAhrK+hh8W4Ov3P9CLSI1noCQENZk02+xdfc+AZ+VENOXx4o39JvVEc0qJXKbpR6ZDz0Zlg0xV0M8iazus1GSbxYw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371d7fcf-8729-479a-eacc-08deeb93fa46
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 04:03:12.4773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DJWD0cfBgs3sbMUNxEDINNkPtEe3MaRDr+Ej/qQebHGmZAEe8pAtUwIHNPk0dzVhwuGZv22FloP5IqlYLuw8QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5159
X-OriginatorOrg: intel.com

PiBGcm9tOiBPbGl2ZXIgTGluIDxvbGl2ZXJAbGl1eGlhb3poZW4uZGV2Pg0KPiBTZW50OiBNb25k
YXksIEp1bHkgMjcsIDIwMjYgMTE6MjIgQU0NCj4gDQo+IE9uIDI3LzcvMjAyNiAwOTozMSwgVGlh
biwgS2V2aW4gd3JvdGU6DQo+ID4gVGhpcyBuZWVkcyBhbiBvZmZpY2lhbCBlcnJhdHVtIGRpc2Ns
b3N1cmUgZnJvbSB0aGUgdmVuZG9yLi4uDQo+IFRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24u
DQo+IA0KPiBDb3VsZCB5b3UgcGxlYXNlIGFkdmlzZSB3aGV0aGVyIHRoaXMgaXNzdWUgc2hvdWxk
IGJlIHRyZWF0ZWQgYXMgYW4gSW50ZWwNCj4gVlQtZCBlcnJhdHVtIG9yIGEgTGVub3ZvIGZpcm13
YXJlIGlzc3VlPw0KPiANCj4gVGhlIHN5bXB0b20gaXM6DQo+IC0gVGhpbmtQYWQgUDUwcyB3aXRo
IFZULWQgZW5hYmxlZCBjYW5ub3QgZnVsbHkgcG93ZXIgb2ZmLg0KPiAtIEFkZGluZyBpbnRlbF9p
b21tdT1vZmYgcmVzb2x2ZXMgdGhlIGlzc3VlLg0KPiAtIFRoZSBpc3N1ZSBpcyByZXByb2R1Y2li
bGUgb24gdGhpcyBwbGF0Zm9ybS4NCj4gDQo+IElmIEludGVsIGVycmF0dW0gaXMgbm90IGFwcGxp
Y2FibGUsIHdvdWxkIGEgTGVub3ZvIGZpcm13YXJlIGNvbmZpcm1hdGlvbg0KPiBiZSBzdWZmaWNp
ZW50IGZvciBhZGRpbmcgYSBwbGF0Zm9ybSBxdWlyaz8NCg0KSWYgaXQncyBjb25maXJtZWQgdG8g
YmUgYSBoYXJkd2FyZSBpc3N1ZSwgaXQgc2hvdWxkIGJlIChvciB3aWxsIGJlKSBkb2N1bWVudGVk
DQphcyBhbiBWVC1kIGVycmF0dW0uIFRoZW4gYSBxdWlyayBjb3VsZCBiZSBhZGRlZCBhY2NvcmRp
bmdseS4NCg0KSWYgTGVub3ZvIGNvbmZpcm1zIHRvIGJlIGEgZmlybXdhcmUgaXNzdWUsIHRoZW4g
dGhleSBzaG91bGQgcmVsZWFzZSBhIG5ldw0KZmlybXdhcmUgdmVyc2lvbiB0byBmaXggaXQuIEl0
IGRvZXNuJ3QganVzdGlmeSBhIHF1aXJrIGluIGlvbW11IGRyaXZlci4NCg0KYW5kIGl0IGlzIG5v
dCBhYm91dCBhIHBvbGljeSAid2hldGhlciB0aGlzIGlzc3VlIHNob3VsZCBiZSAqdHJlYXRlZCog
YXMuLi4iLg0KSXQgbmVlZHMgYSByb290IGNhdXNlIGZpcnN0Lg0K
