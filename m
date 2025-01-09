Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A7C20103A
	for <iommu@lists.linux.dev>; Thu,  9 Jan 2025 07:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736407221; cv=fail; b=EQ5H2v7UmGxJF7XPP9Pz9jX35zY1C0rhecUQ9UuOVBU2ulsPjx1AVHvuMa6amcNqiu41RSox1zba67oVRJCRM9NVd+aD+zrDXXRF3kc0/YN/dzuXhTb6Fo5HHnrt4hxdyJnz9MkMVWIjDZcnqGgyEI2e4383gPUDyXn/YpkEApY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736407221; c=relaxed/simple;
	bh=Z89snS+rUWnddlKy+mC0xX2tak3nwv8+vSPnq/PcAGE=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=bAacd2ct53Q18O1My+4H1mj5LWJqtIk4rgy0XuKT8sW/DO9EIK7BbIP3PRrUBSy2be86U7aHEdyDbPtxZBFV5EJ1NwUQNSYTRSv/1YjK+Pi6cqq/ycUID2W97ls4W7fhPTniJYf5ZR3rOSzA1wKcJavQc9AcAfsbqqiwAW+Mloo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QmFF0wK4; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QmFF0wK4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736407220; x=1767943220;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Z89snS+rUWnddlKy+mC0xX2tak3nwv8+vSPnq/PcAGE=;
  b=QmFF0wK4xdBPkHGCDo4Z9mPKMkmmgEyaWTICYc5BVRIMeuS/Z52B3w0n
   vJsffyuRoHLC4LKRGyzflfbMBAO2NXHx4hAzb55fTGUJcBEtAr7OO5Dp0
   MX3681DtDGq6RgA0iRVLngBdByYalJ8fGBEzvMsOjyyfAFMfN4reGUG+Z
   pmEpZzm7GWkqfxqSYcvPe7zHg+OYSPXXQvBw3ymkrI3r6OeOfWf+cV6TL
   EhnBUrlle5BJvtD82ngVH27r9SdcqVY+C4namsBnPktasiB/C/C1sDXdH
   0baeqa54X3Lut+qX1a5+GQgLKU6Q7uyk1tAARwViHBxB1EPVNVofPKi/L
   Q==;
X-CSE-ConnectionGUID: HZZkwEFwQpmO3kueInPnsA==
X-CSE-MsgGUID: BmwOsUNTRECzVPYJAQaCeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="47321605"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="47321605"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 23:20:18 -0800
X-CSE-ConnectionGUID: hqovpyHiRB6ESghk9cT6Hw==
X-CSE-MsgGUID: 0I5dUhjdQwaROyDUBFYv1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107366052"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2025 23:20:18 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 8 Jan 2025 23:20:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 8 Jan 2025 23:20:17 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 8 Jan 2025 23:20:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0hx6xfdG9eXrYJpa2lJJOBO1akn5OXNh1uUxVlA/5370MwF8+iPaQyaUQ9sXrbMhnENOzq4hZ8DNhy8RMqEsOD28bM17DwcUfnNE+QzS1TIESUuICgMwychw5EPHQUtzxRhDjkuwKo31D97lfWaZvz4dpRP5PCJM9eWBDVoSWNyRUzpm4Px+40WhOzHyS0cxqU/G+OHaNueYJtl+L2ICR7AiKAH/8vqEcFtC/dsKjhcKwRi/QtvwvViLkYl2z54u6Nzks3MpkWNow3mh9nBbKSaTsgFIxZQ+fB1gGtN67VbDCFXcqqP9RMOMiQ57cz4sCKQwIi/oXkM2QiT1GZGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4Ijs3/TVhmSg3SQyWNxhIm5UWR6C5v5gwf3jEUAeWI=;
 b=xCD98bX0loqEtugKBi7PNOStvRNFNlHR7Th72x2eta7FUHYbZnhDogYAoEeMuioWJoPQNTpst2ZnYzHM4edHrpjrKDOUCD0oioPYnOApo+WFM04P8bXhdlkaj4l3/nKxZuLb30WX2efOzlatrzDo8rTPCrIsxzMG9D93JY5brKe+zFW56oTsoiW/RJEe1JI775lCThUAXCXMVwToYkz11WYxBY8jmz64OuW/AFbohcdu9UoNML9RdKx7B7P8z+SsV2gI0HkbzWAClUTDFKDhhJ6w5Uziw25teUEs281glE0LtADnlViGF0cyjV/LmGrPjmhS3gRSzUQNp2K7gKEBJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6147.namprd11.prod.outlook.com (2603:10b6:208:3ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Thu, 9 Jan
 2025 07:20:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 07:20:01 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v6 01/14] iommu: Introduce a replace API for device pasid
Thread-Topic: [PATCH v6 01/14] iommu: Introduce a replace API for device pasid
Thread-Index: AQHbUhnUNnXzHh2m/02CvPrIPwhbUrMOJdsggAAC+4A=
Date: Thu, 9 Jan 2025 07:20:01 +0000
Message-ID: <BN9PR11MB527699DB033F2B192DC120EE8C132@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-2-yi.l.liu@intel.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6147:EE_
x-ms-office365-filtering-correlation-id: befa6be7-9646-412a-8ab8-08dd307e080e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?wk5IOgMlOFxfQt8F0hUx17Pbr225x+Vra6fdvylIwmjsE9HfSSws8odmuYs/?=
 =?us-ascii?Q?0QDrqV+MWYciRZYKMe4f98TbFOK8jBKh2sZxPZI91HNKqJJmPvprlk9qwQKr?=
 =?us-ascii?Q?VlfxKbkopI6173JPLo2FMjzs/JVjemjmIH/2OsC4kRIZKipFfU0sQ7I23Vp9?=
 =?us-ascii?Q?l6rw9sZT/vujVsGtuzhl8QlE4vw/q47caJpZ19iSZ3sbne66Tgt5idjHNCWM?=
 =?us-ascii?Q?dlr1wR4KvnHKFqbGQaOSjv89Ae30SURwDm/6oIKXaut97fmJhQVnjniUNRD5?=
 =?us-ascii?Q?GQskoLydkCmMc89Z2VsoIMK6tEEK3PniOteIDX0nthkItP16naeeVPtlwLPu?=
 =?us-ascii?Q?hasV7QD26xvcjhgf0u3/dkkP2iloVKPqp2Fb+KjEXk0x9L/HD2Uw4Mg8OA4K?=
 =?us-ascii?Q?29CvVfnyq3gAy9vA8HU9c4GIjtFqmA4Mv9zZ5ooCBma/YUyAp/boO32NfimG?=
 =?us-ascii?Q?fMSZOf9Ja745+tgXb/n/n1z5r5/2cj/S4muJlvtXjLkHSDncmmICMkWnjE60?=
 =?us-ascii?Q?+vIZPQzrc6bMr9JCLTPz/Ap3s/zjqBBSDtquOSskNqrtti7kgtVSMTs3uUrq?=
 =?us-ascii?Q?uSwkx6O83s2XT4lBq/Oh5AfAvLxdaXwbGBq+zoFxaoSILtS6vch6s/3WUGe0?=
 =?us-ascii?Q?YW12v9BwqGqAniiWJwcKjBLTKSWVqmH+gZ6tf4vEULk4I/eP5nr24A6k5jwA?=
 =?us-ascii?Q?fJ8GEHAPk3tG030tuU+sX+CMiFKeaHrxlNRYQ0CuNfJAI6826IEi8DyGjl0h?=
 =?us-ascii?Q?f8YQ6gPDb05z2g4iueAwzmNXgKFypSKKKyB0OQEeKjOxyZuBXsd/o0xyHXIU?=
 =?us-ascii?Q?DJmY94h+1DeQs9E8oUWRX1GUpwU0b5VyI8ohEd0JeAYiGlJphnYq3QFsEOrw?=
 =?us-ascii?Q?xXg2pdxKSwhw7w+SL9jKw6qi3IcUR8oVghbYakQZuWGMCiEpChh+k7r/AFKr?=
 =?us-ascii?Q?CmPe+E0ySCtU6cc0n7cV51d89JauC1fLZ9zdm6nRhN2WIFYoW6s7ZwAUUTdz?=
 =?us-ascii?Q?a/4yPUmnZv93BzGqPSBjqskzcoimvMuQ6JQW2oktQGFl4WNvc1l+erD+6vgS?=
 =?us-ascii?Q?0E1duOH+92tSpgBZxr8tXANyzTpApyamk2TEABwQ9DJOZqv/YtpsvHh9RpoL?=
 =?us-ascii?Q?D8G8zRy1Fldcq3dgN8kxY3E9q84O1pI7c+Vc6tDrIjOwa/5FbAhu+o5/0H1Z?=
 =?us-ascii?Q?CdTWdkg1WqSS7piWnZn0juQmxk8fZI78K2cECAmyPfYxHBAiDHIIy+B5MeFg?=
 =?us-ascii?Q?eOiz9/Kwb2KG4YtmUlg1G3LBKE7+q6rsUtEmWm+aBUPGPg3vuue7nkyR8Mx0?=
 =?us-ascii?Q?lXK0IkFsg76Xs0vJWOubSYuzSnQiPqYojXjpubEgYE8hKueZEboo84vFUwCI?=
 =?us-ascii?Q?QAN1paJE/JqWU29r8Pj6V/ZMx43QOqJoWhbEO/OTLCZ+zngICsosWzTduvJq?=
 =?us-ascii?Q?4Y37qgp5MMv5EQn/GBQiLm0RAv+5P++u?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vV0/HKdmf4s5fQGu8b0l9/sqH2QeEfNmmM78P4i20RhwE0lIZP5Qq45C/VbT?=
 =?us-ascii?Q?ch33jgBxBgNf3P3Ih7R0GPOCpk8OwGoa9doIQINxaajxfquLI12xoq+e4Im3?=
 =?us-ascii?Q?EUd+Nhw77m5U0r6HMBKMM15V2Z6Uu1sDpr2Sel18gfZPAEIJN+/60TEebx8t?=
 =?us-ascii?Q?SFCkbVCbxFQrBv5CGobNhr4pd4yBmW+t6Xc+3A4p/6P5t6VknI9LLaxk+ThM?=
 =?us-ascii?Q?T+AR+YAG2DmiIisud4m/xZ7ImG9etlN8+6esvphy6+9l/z9wp4h0b4/ZoETp?=
 =?us-ascii?Q?+tMbg311GXElgCl3XmJEctyzKwKzyD4I0DFvCFbvYda6xcnl2rR7QmBl2Q5t?=
 =?us-ascii?Q?IOdlmQmIgn6yRLk+gh/xFKrR5QkEJAtM82pF1JY0OA4sWrFTqIj9mouDWjp9?=
 =?us-ascii?Q?pIfFVycIe6WaSAGvd/thj0uriui01DdhW8MY+kq9QmQZgrPj3x/ObCEQ2un3?=
 =?us-ascii?Q?K6m7RboZAYz5QcPYwBnF8eZWMcRaHUDxAblzlTETg1YuJoEI8F5f+8EdWgQr?=
 =?us-ascii?Q?0DmIoxCwXeHwuLvNZOq1A+9TDpq/oqdo3bITd/sho0Ltf489/XaNQk9bY/7u?=
 =?us-ascii?Q?9153yEJ0YWap9udQltJMOwB7sFELvGHV/GmDyaZ4N3FgKU8K07ZTCRWze+qd?=
 =?us-ascii?Q?9sUuCvetguB2/quNMNLbfKDv5aNufm0JJx5kpfo/q5NhhswtMs36atFCEb91?=
 =?us-ascii?Q?WP1vJRzZqOZXI3USMuf8JYyO1NE8iITlC6C2zidcnLcl9cfoqOJjCb6cdDD4?=
 =?us-ascii?Q?z2HLYVQyV//4iKUmecE+yihMAvfN5QWtZaV7S5Qm8/RMDnKK0hGZSqvv+/TD?=
 =?us-ascii?Q?qF2najPOIHlHNqPihNLeoM9lKmRTYnwrrS2q8AiOSLHwE7YnjEeTY+Bgk+uS?=
 =?us-ascii?Q?FVapJSuq+G79Ne0ICkE5Pw7UyxAyRNpD4t1HHi4L8JA0KM4qiMrYrdDk7B9T?=
 =?us-ascii?Q?uzd+fG7In0mDSTcZEW2br700EIkoYNJkpUtqgIkAwqXBmRRH+r61817XbkI2?=
 =?us-ascii?Q?P9qDwUpe/HuQuzsijB5hzCfIIdxxnb5gU0nfBXa116UQvaNHFti9JmCPiMRE?=
 =?us-ascii?Q?z0K9rhJIk4ZdwVWFvk1V8+T05hoIB8eJId/hbEPYNXuYDh3D/k+AOMhAR5Cx?=
 =?us-ascii?Q?BGRO5ZflOz/wejF/wMGY3+6VnsoCOmQuwWsZgdhFFM1UqIuv7yHGKGmk7zQ5?=
 =?us-ascii?Q?IUHprUk6FAuDc2g9OSO8QrlzQ8W3j6fvqDQ75W/yTaX3FuXqD1xPB6X95tRi?=
 =?us-ascii?Q?gG/RYuCuG7zB/W+BeJb75Do450+NTEaoc6yZfTLszefwaBewXXDAOQcb7n98?=
 =?us-ascii?Q?OHPX76GIinqdU3NDKX8YUrbtzkbNVya66PNSQLNpA5HSadcncjS7Z4oLsNp7?=
 =?us-ascii?Q?it1QuTtTvmVyzPdTsuknc/RHCotC7DgQ9wlI4XjWwtBtqB1mq3TLZ0jSJDi1?=
 =?us-ascii?Q?iJELxOannS7H1ROEin01Ss5MQTJyixQv68A9rY7oS41zKo3UdvDnp6zQdfKt?=
 =?us-ascii?Q?tncUUmEma5hjvK+/hIXL3ubT/gyqqT8TK3omtrdpKnzf/EwausI8uyaycqj4?=
 =?us-ascii?Q?sRnoKusfpNU3TkX8m78EK0S8iQ3E0AEpd8XxKM0f?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: befa6be7-9646-412a-8ab8-08dd307e080e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 07:20:01.5082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kY5WXbjgXZyTJMs1EZnwOMt1LHm87FTSiW3BI/WTeSd/351sHbhogTpz/FKm+9ONPaufGWvDDAwh/snubtL7Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6147
X-OriginatorOrg: intel.com

> From: Tian, Kevin
> Sent: Thursday, January 9, 2025 3:08 PM
>=20
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Thursday, December 19, 2024 9:28 PM
> >
> > +/**
> > + * iommu_replace_device_pasid - Replace the domain that a pasid is
> > attached to
> > + * @domain: the new iommu domain
> > + * @dev: the attached device.
> > + * @pasid: the pasid of the device.
> > + * @handle: the attach handle.
> > + *
> > + * This API allows the pasid to switch domains. Return 0 on success, o=
r an
> > + * error. The pasid will keep the old configuration if replacement fai=
led.
> > + * This is supposed to be used by iommufd, and iommufd can guarantee
> > that
> > + * both iommu_attach_device_pasid() and iommu_replace_device_pasid()
> > would
> > + * pass in a valid @handle.
> > + */
>=20
> Better explain why a valid handle is required here.

Okay, it's because __iommu_set_group_pasid() requires the old domain now
and the only way to retrieve it at this point is via a handle. It's probabl=
y also
ok to directly store a domain pointer to the xarray when the handle is miss=
ing
but that sounds more confusing.

>=20
> Also iommu_attach_device_pasid() allows NULL handle:
>=20
> 	if (handle)
> 		handle->domain =3D domain;

With that it sounds more consistent to make attach requiring a valid
handle too.
