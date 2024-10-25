Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EF01C878B
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844620; cv=fail; b=KKqCnSBrenXOSY4aiVKLOgrKoz/eFMHuT1CmMd1qdTn+Ac7GbXiCCgzMM/qjLwjO5sZsPC+XlrG9nCxuL1Zl6Gjriiun+Ui8Ebj7xYEiUh71pQ4shrDA3KzNKJSG67oUQ9mp0cGNj7jQ48zc2LaULzVCzYZ8I0vvC4+CoQmbhpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844620; c=relaxed/simple;
	bh=/vncUAsiFeyQZpAHKIPkk76f+lwlqLOdPDE0ZQvMOCA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dvwc1LnDTfYOW7e/aJnEcLJvO0Xc0xCABS7RwNm2UKex0+gHrHhKpIQSbDjY/LErwLzg3GsFWjY/Fgik6pLcrBE2Oj2sOu490e29UA4vjEwat04Ard+YUqJQmW6IT3Odu1Ev+tHYwe2tG+F/V6hgju3ZY0wj1tcSMqa7dHWOqzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJcErQn+; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJcErQn+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729844619; x=1761380619;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/vncUAsiFeyQZpAHKIPkk76f+lwlqLOdPDE0ZQvMOCA=;
  b=SJcErQn+BkGVHQ305fN4aSLcEKfuw2rNxRi5axHpS/F05Y0CVRTBGa9K
   pQuFI2HTVwB1mUDzzVZl1TIsWhKTxghFbeezJwPjX+ICVVxUZOq1hlgHg
   SkeUnqunyjbBgT4FZXDZro3N0xxnMnhf9WIpxH18Nf669i9n1vqjlWdfd
   pqlIAvboC8V95vHrL5JqjX0SVuXml/4zBnS52Fb/mViP0bug1Yhry3nKx
   QjXtx08woyaSWS2FFf8/4Msf/Er2TgsN9mdOAqniUOV0Py9jslFFIz/Ea
   NPKDwGqAn5cV9VEzPnnLqB/krodbTc6/+MWtYF60rYkKM6ST3ufKsoGV/
   A==;
X-CSE-ConnectionGUID: 3VdTEZREQKexIPXHaDJhBg==
X-CSE-MsgGUID: WgKE9UKdTg+H3jxJfrlXzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29622930"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29622930"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 01:23:38 -0700
X-CSE-ConnectionGUID: WlPnjW9YTuGXOxFA2XRdYg==
X-CSE-MsgGUID: zxeuK8tWTNqh1XgPKa+0UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="111688933"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 01:23:38 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 01:23:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 01:23:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 01:23:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpOBK8Cr7rhBqT/XSgYuHtO6uBIzY+ZRiodoOlKVoxNjKy4pTXatfrcfCAKRtjsnYITSy2dXs1xn8kCFiYSd8RWEIVaVhdDo4Ki4fZM1TzrXVB3DMXh08exRtcroSRcmtl0nbotJ9hZCcHLjjDRpvaRE9xnl9OAelwAZoS+ysnxtbVaSb6ukIWoUDxangDEs0brle9zeCLYPh97JYxbcOS6z58ONTQ4w4rDIR44N+SvgQb3As95+z9fYB8X5SBaRHOnn6Xf3pYmBBFJsyA42+VYA0nQBtJ/UuoteY4Etm1tzb7JviLhNxmb/C5nuxHVywHW6HpOGPLajkRSiWEHG5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vncUAsiFeyQZpAHKIPkk76f+lwlqLOdPDE0ZQvMOCA=;
 b=M1fKsA3KUfz178476KnP4sJlDg25t9vnXTrpYPpjbM0Rdmv7j4fz46upJV+ZGU8XVbEu0cAZMpnTSKuOXwNv77oCar6VIx8YwwaJ7HFjNXPva9M/yE5HndM4sVgT1K8xGet7TXrZBDCahCvP7BnKAibLQdrcxOahskYSqccna6566XPhPdmPmcw5Io3IhWQ+FeG7oHLRQaDF4X54QcA7Y0SNKt3WMXBJT88m0qn4NMqdFU0hjhehZjSoLYfn19A+R/wr+Y1n6y6gA1CCjW4XaaIM3TbpxifLCturU5rLBbavFR2tS2XdYNF4wvueGhzbYU308yQXtwL7Kjh9UlBwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL3PR11MB6362.namprd11.prod.outlook.com (2603:10b6:208:3b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 08:23:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 08:23:34 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>
Subject: RE: [PATCH v4 04/12] iommu/arm-smmu-v3: Enhance domain_alloc_user()
 to allocate PASID capable domain
Thread-Topic: [PATCH v4 04/12] iommu/arm-smmu-v3: Enhance domain_alloc_user()
 to allocate PASID capable domain
Thread-Index: AQHbJThxeN0KP/f5SUaCJu6gy+fEIbKXI9fg
Date: Fri, 25 Oct 2024 08:23:34 +0000
Message-ID: <BN9PR11MB5276FD2328533C7447E2F6188C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241023104207.5894-1-vasant.hegde@amd.com>
 <20241023104207.5894-5-vasant.hegde@amd.com>
In-Reply-To: <20241023104207.5894-5-vasant.hegde@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL3PR11MB6362:EE_
x-ms-office365-filtering-correlation-id: 56fc9597-0c89-42c5-9c05-08dcf4ce517c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZeXKmeOLMISjchrXPe8dzcUGscANI2XTATjhZR22U/5a2dr6B438s8WYDv0e?=
 =?us-ascii?Q?r9HA/68GWAD5T8NdJ7n5jQAB3faMTHIBOvMp7t67fcGVOgLV0JfOkQymvg5D?=
 =?us-ascii?Q?PuQ3UxNl56+hn5hjnx/7LptYyQIU21V4EE5+3nS8SNUBwcWVPd66Do/nSxMJ?=
 =?us-ascii?Q?wfy05o61HngM0ptOw6KY2Gy/1BIGsRO7auNXsIKRBEP1FITa56ILOv80pknD?=
 =?us-ascii?Q?YhUkvRku5SE8FQJ2CSMNssNAryzY62jyQQN+qCEI5rxOVw2hoE7NZ9jWOJeq?=
 =?us-ascii?Q?Iw1DhdxJwlnAXq5EW7jUXuDLrOURa49FaqQaY99bDA7vYcfgdpoxmjYn8ttu?=
 =?us-ascii?Q?3X+fdYQo4mi0RPDy7pvh+067OZmjf2DUu4P4mGtFm2/QrPQ39UvkiaerFf4N?=
 =?us-ascii?Q?49D1gQxrU0j8fZTuOMqvIzB8jmLn3nA7f5cP/Sfg1Kt1Cs32MMdpf88C6WxP?=
 =?us-ascii?Q?Yx4vwN+07UCjjZmlgPvQ7t/qOVXJH8dy9IIN5r/pL8KS7OIrRWkkpOsACPSB?=
 =?us-ascii?Q?ro/WlX0Znccs597Bz6FfO+hp8Jy5MoR06p90YKjey7amL7hLyYZ+hRfKT6Jo?=
 =?us-ascii?Q?FuSUcpWtJnj7+GY6WseIUPegAQXAAJxa0i292FV4YeSO3k1E7Cp88TkqH2Qj?=
 =?us-ascii?Q?8pityf1jPhCnMNGM1IlvY0l7Uf0+KObqlCIedH77Dvo8/ENzyRdI2K6yIhBl?=
 =?us-ascii?Q?sUSiMbrtleE+zhvE4qVo/q7zoVDfW+YfQPcbqU+xg5ynupITxbVZDRwjKhxF?=
 =?us-ascii?Q?pw4SymLR+UNVG3gYTWu8I955CcR5PG9MOGiTKu2oAhjT93kDW3sH6Ni2pSWu?=
 =?us-ascii?Q?yld5CjRF1B1mG03TWC8G73cI+ubcn8hn9sTPrYuKi7DYV4hgGsU3AHuWeETu?=
 =?us-ascii?Q?Wj/ddghBP/ObcfI+rO0s0VOrftfUW6heDw4VCcicu2k/kAKQXbFq8NvtVCtE?=
 =?us-ascii?Q?i7lTkCqtSJ5OU3RudsEeve5mTFYf2ZowS16aCQPJnOigmKV+gHE5DLN0CNps?=
 =?us-ascii?Q?AUrYy8ooEgsB6+YsPjWSoa2CO89fF75OUCailzmF+y3UhLkMzpp/L5DnCx5d?=
 =?us-ascii?Q?txtgToBH217i31BEpFbIp2keWJ/uJpx5HaLFnIP9i+AkLwdw8jn++p1cPZye?=
 =?us-ascii?Q?AL2Kr3XWGEuWvCeVkgieRyt4mdZaME1mYuC5BCo7Lv0nJ8vmsGj6WivAiUPW?=
 =?us-ascii?Q?X4WtFV+gJVUGONmrzwWyk+aAd+vOl/ZQw3ZMF4Hw8yGvUDftcVtVmOeC65F9?=
 =?us-ascii?Q?cecHANIxdlZIXLbDIRKYdtITq+RFAD0J+0EUAdiXfW0e+fqC7rOMT+P28HOD?=
 =?us-ascii?Q?bM1dKKxN7Hs4EPjdQW8OJWa8+o7yl7EnGYqhqpTSQNb5j9wvOBebJ+8jUCDc?=
 =?us-ascii?Q?SXLCXo8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hqN6M/2gUGL5T4tiNxJfyvsAPj6c8loyoxqcWaZNaAtV8jI8bwhW6hay7WoV?=
 =?us-ascii?Q?9xTCvOa1jeSKpEEtuh6DyjtPOgm4AT9Y753mXxQBVch1RG3PtkjlVYEYaZDU?=
 =?us-ascii?Q?vOh+edhSrjuXIhyKtjlmk5irfkHEkGGcws8CAwGA8/NA+vDxrdv1d4j4W/Bl?=
 =?us-ascii?Q?23MzKvo43cDx8lIcUxkIXbVE7gAz+8vlmevgHt2Kdw4S+qlKnc288sVpKUG7?=
 =?us-ascii?Q?JtmBDQI11DuFdUJauag6hS8d/ZgtaZ9XGOp6F+deg7rHc4jG+2xdHvfwcxdi?=
 =?us-ascii?Q?H7GPFabyU7SyVP2xcevfBm2sQo8nWefqcPJlDgwL8lYgca060qZYzaG3q2AE?=
 =?us-ascii?Q?OgwD9C+Kqvmvd8DHiwCIoUwUEDdQPhb8+wtNZ0dWwV0n3hCVxNsE/5htAXyW?=
 =?us-ascii?Q?CzYGuIUa5c3wQcS5YJOeSy6azY0l5PpuFbW8pnMGtLUYAsOtfRDeB67trnce?=
 =?us-ascii?Q?yGCW3g5LaZYgCM6aouDXVbnzqWp18heD5vpJM5lLCyu0srIuY974BRYwDOp7?=
 =?us-ascii?Q?j1ptobuq+U4q8i2YZAv4+1H3GjzGxGbWc41RCCYve6t+/q3nGx58EEzAoLmu?=
 =?us-ascii?Q?LAPlMIkJ1jXx3hj49K7Aph9x+CZcuYIjKKnMD6ymaAqzICAuk9XeloA4Pv7E?=
 =?us-ascii?Q?qhGxe5Y4rv/5dGPf7lsC1aiyeeWMXgIiYWBvaMc6glBRi6S+9eN0XKIZtGWV?=
 =?us-ascii?Q?MLNtCxp8hmFFGEbwvpj9AJDOdi2VZ5RhXbiiUnzH9GvmF3waNPkdO8cztvlj?=
 =?us-ascii?Q?njDLABvlPmAVFF63q9nkruoQqSDFEf/ZKv4GGH6I/6edR/bKyRJapXKmWkAn?=
 =?us-ascii?Q?ghnjHur4/zhMhBjdY/54SEEcw0SRj7G8lvas+AKQkR/UTkrIgfIimc6w/fJt?=
 =?us-ascii?Q?EjzvusJ5HY4gznZgXkHxIThhLNfKgbqGnlKckKfvHF+Y6eLeNYFLH3vpZh3z?=
 =?us-ascii?Q?lRHJpG8hBmzTUl0H1sZpSjtKcz0iTk8kd87QTKae/gL7VbOQXF95IpxkTb1t?=
 =?us-ascii?Q?TnPq0xSttU7KfHEQZXYgPKiWQ4fCUtfPd2SqrOV7pziJO2094uBMzY38bLZD?=
 =?us-ascii?Q?DqwDJqYJsZOgW3JuD+UNMQdri+GhDIOYZFoo1WOSSMssExD9vzE9tAUl5fvg?=
 =?us-ascii?Q?JnVJfrvJ3Rvqxh1PfUStZrNtGBFzUFu/YmSmXureP3vKOdl+rdPDQFW1v9EI?=
 =?us-ascii?Q?yjd1bzFIYMsiIsOOdSwgrkwN6P1R0FNg2Yek+Bpm/tyYM1HF3OpyoaSFrCUE?=
 =?us-ascii?Q?S6cNrlKORkrmTvekZGd2qTwBN3mbj/5R+sEzpQF0PhoE00md+qLd/mGKopoi?=
 =?us-ascii?Q?z1uGVzkMPUfVPNsjis8YXPd+58Cmdrbsk/6DsBggdO/uWWL9wgY3iziBIdM4?=
 =?us-ascii?Q?kG1FOVlRD6t5CaKEeDZ1/TERPu0bmt773M9QwNNFiKz8t/rUZ7pjFbRhTXb8?=
 =?us-ascii?Q?wOHuu+hQsDl+3lRXIMcCXe+otnkuuEBg9DixHBySO1Bzdp55KX4G8ZYVtQgi?=
 =?us-ascii?Q?Uvn/nF/Noch1g1mWSEi1XquG42tf2O1fay+W4MBUDcZCmnKTGIvTlLXnsckr?=
 =?us-ascii?Q?+aVvHDyiA3YlwDA+G3iAwdvq0uQSLMOFLzXIQbc1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fc9597-0c89-42c5-9c05-08dcf4ce517c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 08:23:34.7012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gy+MchzyAozHdn+7CUoIdyk/QYrSlu+KLkr6DADJ4sLgU7XKTqTwy9vDU3I0cVA55lw3EtUyDvGSpgzi0OWifw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6362
X-OriginatorOrg: intel.com

> From: Vasant Hegde <vasant.hegde@amd.com>
> Sent: Wednesday, October 23, 2024 6:42 PM
>=20
> Core layer is modified to call domain_alloc_user() to allocate PASID
> capable domain. Enhance arm_smmu_domain_alloc_user() to allocate
> PASID capable domain based on the 'flags' parameter.
>=20
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
