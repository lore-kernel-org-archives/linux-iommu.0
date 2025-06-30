Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9E41D516F
	for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 06:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264927; cv=fail; b=PUniJElh8Z5l+ZQt/3zsWm8OfIkuYqqYIfESzkThFr7DuMZu6bJo87y8ZbPhFnSVkx1ODIIGOJuqzk52ZZB46BrdCdkgb0ZnDq3NzzSCDCbuoE2jRFQTX2uqFjJxYxUqzDK+rW1k85XMwPijwEPmaonwjb3tfSzAvYv6YB3oFYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264927; c=relaxed/simple;
	bh=pyZhiaCJHX591Sqy1VJIXF1qS4Kgz7g1dr66yjNn0nE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YyqyxdK24PeNGWpsHg9lXsnT6kLTaHmVLaxMMlza54I0Ws2MxPms15PXzL6GnGic/OJL9KdFJF7Jc/ignWAFUBYam3qybZFxpBq8iv6Di9gDBnMNcEPUgbucBnr5SD4vQ2JUn15nB1s4bhJhvmuC/zns7v90/ia/QPlm5VehRUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=It32wB+g; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="It32wB+g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751264926; x=1782800926;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pyZhiaCJHX591Sqy1VJIXF1qS4Kgz7g1dr66yjNn0nE=;
  b=It32wB+g4MFGs/173WfrrNt0grZqo9bkA2ViRvK8aikfvinab//R5dZH
   Z9gE7A3WOKWehpnprZ8a0aTTAqWf7s3g2PEcbp3OYWxpc1MkpvX+3g1aH
   jVjOPOt7KkzkSDIhkKlfmI+0rQODZWlOX90TYBrRwzv7zZYNOGccpwUj6
   6u3gMKk7LUFbEU7P6gLV/MUgDHZyZ+aVv5hv88WrzpW5XOiMbhJUQ8UJ8
   sDs1BxlvE4rrN4gJnNqdIg/OIjcdk0I9paQtOd+E/2LlxwtqaQGyqnXSo
   zPF+em/LVxTBsutcGaPg2go5ngRbnLmNHLwvTCM+gihJBiS8sfoXv4Iy2
   Q==;
X-CSE-ConnectionGUID: 7WojuWJWR5Ga5I+1KKBacw==
X-CSE-MsgGUID: DjOi6vRpQiezU+3LspQyNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="64830725"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="64830725"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 23:28:45 -0700
X-CSE-ConnectionGUID: psKL18faT9GdrNL5Ve9khw==
X-CSE-MsgGUID: eVJm6V0ZS52Ng/YqhtlBiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="190545274"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 23:28:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Jun 2025 23:28:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 29 Jun 2025 23:28:36 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.40)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Jun 2025 23:28:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keVvdGH4PeWYCVBzLcOXdK5LxuJAShEhu1QxmPzq/x53Wpb32uYN/R1Vz510Lrf2+St4i0/BVyedYM/e9ho5yTPgDdh/9vCIU3ZmHnQ6g9Zpul41EyrQ4g1215FZhsf3YAt+83Abf5yNQD3L6YXpzAHf03MIlSSHfoz5IgPvS7vr9sNEBpTHGbva6e7QHbxr1vJQVJd9JA0SjGO+7NGsjVVxhWjx9p32e5X3ybWkFkjvmDblC0YjVS/cEJTYtR7oMxMzrQW60AV9oP4EooXocyCSwR9M+SfzTQY9NnF2lwX32RIxlkrMIiSVhvv2XvRhu/fdmSAkH5+dT4Z8aFpiZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmRjDDK3bH5208FS3hkkt0We3U+JgumjaCbYA2aYfwo=;
 b=XYDuwUAKeNdDOB6OUuu6T8b6Nmj9hgvlE0com07PaJEJ9SuWv2une9zeLX/mjZK3R3hsgUAN2c7o4bG7GGthliSXh3kq9iZSYq95jWEFhRCgRdqR8aiGj5EvXmrFpkQaNjvLV2UIabo6dwfS+XmwCtY0bvx7G9tQrKXxeoWaHww5Qrl5W7NQi2Nz98AaKJIIjL1uHFf+iW6ideexk7VR+lb1dOEe4H740zKwk6M7rYCKIJxENqy4+CLi1ubAKhMIbLFKm/AWPWwZPkTMQ7x5+RGX5PM8T8IkfhvXvdfX62vUviv16wp7+FwNdAb3KhLv9mYBDv1VTlsPZJMY4PTxzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by DS7PR11MB7887.namprd11.prod.outlook.com (2603:10b6:8:e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Mon, 30 Jun
 2025 06:27:51 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%7]) with mapi id 15.20.8880.030; Mon, 30 Jun 2025
 06:27:51 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "will@kernel.org" <will@kernel.org>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "aik@amd.com" <aik@amd.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
Subject: RE: [PATCH v3 2/5] iommufd: Destroy vdevice on idevice destroy
Thread-Topic: [PATCH v3 2/5] iommufd: Destroy vdevice on idevice destroy
Thread-Index: AQHb5xYEfELQkUiNkEe0HWCoTdGXH7QbQMYw
Date: Mon, 30 Jun 2025 06:27:51 +0000
Message-ID: <BL1PR11MB52712CE938B57E41C34580908C46A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
 <20250627033809.1730752-3-yilun.xu@linux.intel.com>
In-Reply-To: <20250627033809.1730752-3-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|DS7PR11MB7887:EE_
x-ms-office365-filtering-correlation-id: 0da133f1-2a9d-41dc-ff56-08ddb79f3d5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?tLqFx2lM3j7dfjyOTHqqzeCFq+5bLODUuUPBvwSOS9MmlRgCJ0cQxWwVjjm2?=
 =?us-ascii?Q?IHFnYRPL4SYps7VwNkgSnkVCXegCzYo9hjryGiBbuPQoWtlszSE3A0hlxRZp?=
 =?us-ascii?Q?u0FAZPmBi9C6Dbx9/s3s1mp9O3Dh9cuzB2hXjV99TFiprN3Ng8cmNgBqzIu0?=
 =?us-ascii?Q?eiCESe2WkunUiSVz8KmKhChaN6jziUfTLMNuYl3LLZ7oKMLAtrHaWo2QUzKo?=
 =?us-ascii?Q?+yBC6OQv+dsm3+zvC27q2+f9KJexnxOZSYO1X2706cpF/Cy41ZD71tnGGxjE?=
 =?us-ascii?Q?rY6HeHN9dwSKO2EZTk36VZ2DOcRGHsOVp7+j3DWkipEYhXTjVWJfrDfo5FF5?=
 =?us-ascii?Q?rflrVuBdsVc7dL0ne2crq/RTQKF5HjTwUPMLRzf7Qj4Zlqvhxl75mTviS6Yu?=
 =?us-ascii?Q?Hemn587lG9KVxB38RVHoFZmBW2yvknpsdbY+GslbqO/yUESzHxnl0zushus1?=
 =?us-ascii?Q?/yF/XoIGnTbw6fnCotoz6BQQRhEf0QwXdtYj4eCPxnZqSwDiefYPa0lY7F2Y?=
 =?us-ascii?Q?rQldNmt7k+IgRm574SMU6PK5OIRvfLADhFq75kkGTbO/o436Fgd1H6+lqoWS?=
 =?us-ascii?Q?sAdggl4O8u0flMSjLvUjHL/9moFrpJM9o5ZucELGGEJ4I7Ug7K7AD9MfZfyt?=
 =?us-ascii?Q?SL33kqB1+fP5jGfUHbl6MlabCJSELrLBtT/4OoNvncr1WccIxpFg9Qm41BtI?=
 =?us-ascii?Q?nCgACEmvov+xgcItWXcu/k0Ir5Sfjws5gK6VpHe8jn8jJj9Jbpbe+HAT2oao?=
 =?us-ascii?Q?kF/zkHf51W6cDZqhEjXJY/L8gX7UOkJ+q4XJhtt9FoNIuGgOGfA8lTJZM64p?=
 =?us-ascii?Q?yuQnTkIhqN1qf/Vk3gpHHWgbNRqN9rU/U0TbXPKJMaiYtXY/frhPk8SF9INI?=
 =?us-ascii?Q?ipOI+saCx7pBXSzsaOJKCVmZQ9SIODT1RDfoiDOegwGdXT2ScK1wdttvnX3L?=
 =?us-ascii?Q?P8Vf/o1njcPNm2vUkdsxhSNFAvWzdE0zI+Ghev8e6uhf1mv4sYBkBi0gxie8?=
 =?us-ascii?Q?v9skYJq0p6g1Ied+5Wgw4p8JCf5hTCwG+4SoM/1m7OP6EzHKNb0OsgLWyNL6?=
 =?us-ascii?Q?jPUR4svK83BFPi/swo1DkpptyS5YpVUnGgnPBZeDYaryTIVbDptEGM9MzPf3?=
 =?us-ascii?Q?77tzcCILlmPybBi9HRlN2xRaRq3agYLcfOUd00ry8KQ/rM9LhfDaw8Ikm2wy?=
 =?us-ascii?Q?EMUmyyFuzYyNdqPHMEEcsJhBcCWBIuyh02e2F4s2MyMsLQxPfAfTfgRVntT1?=
 =?us-ascii?Q?f1gC4NTV6UAw3dltuYbhJv5vqbRdiPFEwjFCN9RyT+ArEI9uIrX2FA+6AYFy?=
 =?us-ascii?Q?fSXeqXyhdOCJ/7oVjB33jaV7Gp1+8kgpLUHDbEQAx6+SYZZErg7nbJUwArjs?=
 =?us-ascii?Q?pHib1kvPYBbhwFBVOUdAgKEVfC/iQGawW7Yvdeb7NUT/7hwYQ+dlOCcI4LEG?=
 =?us-ascii?Q?TqCb5E3NDAI1ovj6jUch2Tna6H9oOVcyd85FIM6vEI2t5PloLAlHfzYTPg4d?=
 =?us-ascii?Q?WRtg65WtWW+5r4w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m3pmQD96+Zrtw/B9Tyi1pORii4lIIq44NX6XuyWjVVL+EUxOzx4TIp7/UxyN?=
 =?us-ascii?Q?7SxjWLtv+XTEF0lYRz8fRQMkij1Fmg9itunNOD2ewe9JT/JMo92OY9/k+fkA?=
 =?us-ascii?Q?sk+8mh2qz8vasnNl28VHOTrxkqvZc7Fcr59K5Drsm+M6/1vdJjTaJU6f1PBb?=
 =?us-ascii?Q?dKNbchw9slTIcY38wTBQ0mqO9LaSK9kGmZuB513lgze0zeqanKGMBwqX6RyI?=
 =?us-ascii?Q?9vqnzF8lzlqiTYFxzlrbJgUW2SCN3lFvd7shy6hMDkz+uOmq8EP+TorSLS+E?=
 =?us-ascii?Q?pf/RT6DzoxH+KBCbAEvtqmS3bnBVxEVWDkIr47+vAD7PKADLiO2nlpXt2hak?=
 =?us-ascii?Q?c0gjCMRWOkgJShEb6e0dKK6Ruv9cEGlTKFgs6nFlgDNSLr/kKMDKNg675qOO?=
 =?us-ascii?Q?0wl//vE0ipNip9+/UelbxihLXGUFM7/1UFLaUQ7Wwp0f759OTQlxiQqjxcE4?=
 =?us-ascii?Q?A47qk0m4Nu9US4xi3bWcUbdWMWZ+Fc8edFPxjgQXY+giIy9owZOpH9awsWJ6?=
 =?us-ascii?Q?xiv5yq9lbZxcwtpUYnyUw08ABTAPmy3GUCL8Mu7l8KoLWYqVYldGZ8UtfiBC?=
 =?us-ascii?Q?PHNdjfJNNHERk86NnfsnV98IFzR2MPWr6tjvQYZ+tmV6H9K/zBHBMf43kdGT?=
 =?us-ascii?Q?sBuqCDZzrpcuhTh9VSMnRQBsAcPSkza8A52letEOhfYVDOA1ACkPjSHpslCX?=
 =?us-ascii?Q?gQNp6thpvoqKwf7bi60KW1OEq3Cf+fxIg4mJ8UWyO+mYCVmPCa4lUaXs5Gm5?=
 =?us-ascii?Q?LgTXiyDEWHDCiCtCjbc1Ej0JVcMp4p41P8++NQyugzvqqEZRv5SEckaeyLHV?=
 =?us-ascii?Q?bsMewTp/jn/9GHYwGTQmRbz8NeUqw63n1By8c4Jz6jmQcxzZrS/cblE/6Cj/?=
 =?us-ascii?Q?39VWjmFc4Ayx7kSbm23V5vhBhcAPiFsiq/U2umKUZ23FEOrwd2N+Pd/4gOfV?=
 =?us-ascii?Q?xCYkTks+7hnh0sr9eZ5m8gj8y962UYCxzHlOIrCtZ6JsPMlgkEeSG/4YSkg9?=
 =?us-ascii?Q?uNyeGnyccBITEO3NePv90XXeQxxMlnmlY8nFBY54dsslne1cZbj/E9ccbvSC?=
 =?us-ascii?Q?Jn+R+oAvb5ADmbYkEcelQv0DNU50E7Ru6GUyeGXsUqf9TNIhLb9EMAMeSui8?=
 =?us-ascii?Q?QZAGX1s0wMUzyEZ1dVadYsQwwn5NUkS+/Mh70HFKfzMmwx3LOtw7tLuIB2Gr?=
 =?us-ascii?Q?3uKL0TPhgdo3uM0C+CBxz9czpHibUpmTYps37eUd8dfaGp6IcfXla4tJkl+D?=
 =?us-ascii?Q?gYZA2nsHLvfMJCw2xVXoIIeLhAkUZAwL4zR4VFzGAgSHxutq1nXvq2LIv/UV?=
 =?us-ascii?Q?Vi4hl7q/r77t9fEeP+8uafm0TjqIFA/MqOjS7fZLL+9U2WyGOvWDD2Yekaed?=
 =?us-ascii?Q?lJf95qTuDZD9LoaIjflMTs9jgz2Yp1xUeBUsubeDIZw5Yf3T1fvpH2WlFhwp?=
 =?us-ascii?Q?CrlnY0p/WJhm4yGUWmrgict+lsOwg02ZkL3OMXv+rdgFJiGaj3W9CXX0cUNO?=
 =?us-ascii?Q?CDM9E6JHdBb4eqDPyGSw+VfQFjhYzxQXOVmyB4WW/AfumTPQoQ9mPvqJfMU1?=
 =?us-ascii?Q?j0LgR2NCOtwmRNI2TF6aNJSPOR+yXPR7frt7OyHK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da133f1-2a9d-41dc-ff56-08ddb79f3d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 06:27:51.2981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/RqEcR4f/imjVqSjaSISaLXmf8P8Of6aEcFD2KZLYJNRd4IfQEYm5+scIdcrsVB7R32c25LDQrY19KorJE7ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7887
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Friday, June 27, 2025 11:38 AM
>=20
> +static void iommufd_device_remove_vdev(struct iommufd_device *idev)
> +{
> +	struct iommufd_vdevice *vdev;
> +
> +	mutex_lock(&idev->igroup->lock);
> +	/* vdev has been completely destroyed by userspace */
> +	if (!idev->vdev)
> +		goto out_unlock;
> +
> +	vdev =3D iommufd_get_vdevice(idev->ictx, idev->vdev->obj.id);
> +	if (IS_ERR(vdev)) {
> +		/*
> +		 * vdev is removed from xarray by userspace, but is not
> +		 * destroyed/freed. Since iommufd_vdevice_abort() is
> reentrant,
> +		 * safe to destroy vdev here.
> +		 */
> +		iommufd_vdevice_abort(&idev->vdev->obj);
> +		goto out_unlock;
> +	}

let's add a comment that vdev is still freed in iommufd_destroy()
in this situation.

> -void iommufd_vdevice_destroy(struct iommufd_object *obj)
> +void iommufd_vdevice_abort(struct iommufd_object *obj)
>  {
>  	struct iommufd_vdevice *vdev =3D
>  		container_of(obj, struct iommufd_vdevice, obj);
>  	struct iommufd_viommu *viommu =3D vdev->viommu;
> +	struct iommufd_device *idev =3D vdev->idev;
> +
> +	lockdep_assert_held(&idev->igroup->lock);
> +
> +	/*
> +	 * iommufd_vdevice_abort() could be reentrant, by
> +	 * iommufd_device_unbind() or by iommufd_destroy(). Cleanup only
> once.
> +	 */
> +	if (!viommu)
> +		return;

Just check idev->vdev, to be consistent with the other path.
