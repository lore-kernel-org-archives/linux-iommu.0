Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD5131D381
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 06:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468510; cv=fail; b=jIaZXCGssZ9mJMbx9Cvu/nDWfay7ts3BE4R0Mt4Fxus6kZutwIsSBg7wLWYfCmwFojI1Z6rDy/NAdTz1mUxdh9qYARE9O6U8J00kuvNTKqei+c53c5hyOJXU2WPI6u26lmF9Lb8yUSQmBHguygMI37jLhv7a5ED2rFxS36/2h1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468510; c=relaxed/simple;
	bh=Jqp8nPVjfF/QEaNWGemY7Jd4bQ+zgghHsOXTY4rjMcI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XQhx1au+IbiDkYj7YkOzAw9ODMzjg7Tke4hFJEW4n2Ahih6Ofm02uxfnwlQFkhBijxrM2MhiwKdOxFRDnthFgJzdk4LKGVJilFpofApTnrpm7cDhOy8SBom20m/PsSVVRMraA/gprpbOgrKl1v7ex3kE27sj+MYwGcc4R+ESQKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1+jMsXo; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1+jMsXo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780468508; x=1812004508;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jqp8nPVjfF/QEaNWGemY7Jd4bQ+zgghHsOXTY4rjMcI=;
  b=Q1+jMsXoMLpg8yJAFsd11ryG1t35oDxToKKW1fZCqf54UtTLKalyjSFB
   Vw+XbsmXzpeLDxdwO9l6x9jnXA6N9P4fdGfGUT7gfxDQNb43PZ5ApZOnh
   K7SF5WEEd1quPpQJzZI29lAv3wTgpdc/XVfhdKSBGUbADXWpk8C18A5Xs
   czsc+vp1YE+BfdNrcGhLqRxALbrOkbZA3lk0m3uw4U4mvgPQAJsT6CgKS
   6MGx5iXK9vX8vqzT3dYRy0lzjg9NBfbzXscfMnAEpY9NBC+ww08TtOFE6
   0xOHDQLNXsioRTF3gNrCq1BqP7pHJG7YbU5Jp+vlhKus6jyfNFzx7R4Rk
   g==;
X-CSE-ConnectionGUID: EwVlisOaRuyTfODp9LkQew==
X-CSE-MsgGUID: AjQhB/JLR5egCHtjwNKLRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81005999"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81005999"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:35:07 -0700
X-CSE-ConnectionGUID: vN5XBb3uTd2jSZWPteac6w==
X-CSE-MsgGUID: UDxL6BwlRVWA48/EVVXT9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="249203970"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:35:06 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 23:35:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 23:35:05 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.1) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 23:35:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVK0bY4eG6j9Nj1n7xO0+btnN4+MGWIRUGm4Zcrp0i+4KgwfpcIB9fX4uQljCQS4a0IP/CmWJRppeLG6I2yPrxPTVrzSW4o0aeeJmNzxuFQ57mHh+lNQmkJ9U7bRxB/xRRolu9vVDjYhrYjKNvcqxtYNyTSn8NcaTTg4PZISsZ9mG2dvaxkuN6GQkTMYunVH9gjb+pzWb4MZPKhaEbAJGTX3h60IZpMWfisywMAkUe72x40vQwlcVgtY5P365QnsQBnfSua4srnBmNjN3izD77knMKZ66PD+Dy4NvH54NzHcTzKQZG6nGnrX0iWBudR5enWd+wc6ThXmCZZnmleS/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRJNpfttT8JzsfbPQ+fzLPebnSGb1Uowb56y2Pd24m8=;
 b=hwYKgBUyKqQCdZlkNvzdNkfQDbJoOiYU7ENS2vuZbPNStisTKQir/c1N0ae4Mmyduf/6icGzQ2DYHPRL5gFtIDH5TrfHCizILt7kPE09Xo1p2ejHYxQhKUvzhfhokCoZNRyZ7mFJcv3h7bRlHSo4kUEhzOXSmaSYr42FVtWaDRO4Toe3qHoOzbdQ5Aer6Caq5e60wT2aT3H93J4BiMQgPTqcm7yWEuW4mlzGRbH61VLF4XESrMfv1TXMD/YjDxLH57OyxIuqOKKI3P+JaRQmW8V00fy6HYzH5X1OUDrRPkZsp8uHJAbEotDyvMgXfnyiKZyNtwk21bxPzjK8LYJ0Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by IA0PR11MB7308.namprd11.prod.outlook.com (2603:10b6:208:436::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:34:56 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 06:34:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
	<alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
	<smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
	<robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>
CC: Saurabh Sengar <ssengar@linux.microsoft.com>, "skhawaja@google.com"
	<skhawaja@google.com>, "pasha.tatashin@soleen.com"
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>
Subject: RE: [PATCH v7 4/6] iommufd: Add an ioctl to query PA from IOVA for
 noiommu mode
Thread-Topic: [PATCH v7 4/6] iommufd: Add an ioctl to query PA from IOVA for
 noiommu mode
Thread-Index: AQHc8xwboV6h2k4/Z06BRMQniotO17YsX5cw
Date: Wed, 3 Jun 2026 06:34:56 +0000
Message-ID: <DM6PR11MB3690D86B4E7600ACE0EEB67F8C132@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260603054438.2450130-1-jacob.pan@linux.microsoft.com>
 <20260603054438.2450130-5-jacob.pan@linux.microsoft.com>
In-Reply-To: <20260603054438.2450130-5-jacob.pan@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3690:EE_|IA0PR11MB7308:EE_
x-ms-office365-filtering-correlation-id: 44daf49f-6749-4a2f-9d74-08dec13a3a37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|18002099003|22082099003|921020|56012099006|11063799006|4143699003|3023799007;
x-microsoft-antispam-message-info: py2ISyzEcH9y7+X9lVH0mTyNHc/enc9MVGl6zedngCbS2+ZtFQeMYVJzq5AYPfM0+yXPn05Zz6B1om3tjpCpEyXyRcqLuFmEHJJY8enupMhwXDWQCKhpxbIUfyw/B37Fn/YRIPebyAulOI7spB+ECjNxAFSzOymzyu67eEv4TDR4tDsuGq7PRgbF7lx7ae0oQfEEPwDJuTrbcazfoT+ks3SoS6fAhWsK2ZfJpS/joTjJ6uJTViPn/3NS/4pvAYMLrrmf/8VGH9z++hag3Nt/HdSC8XJx+sazWxfE3IQL/OOzS7TPB1D3k6WJt6wrxhd4829CNmjIti7HOryePVkj0N93XiEMLJlKnUTPpXUbkjH/awBqVkrlC6yW6+brqoLzaGF6buLsk5K4gO91NJtVHcb3+n/hakH45kOWJzlIUSRLIQJBfkbYADgNQ8nWpjf3hvUFOREG7s+pBGO7ftvtSTOLl4SMNVR1b5jbCvcJ6pZMVOn0xRvGepBolizhVRzSJz5A3JgUMStbKhITUc5FyiOSIEHjsqb3yemf73VzbU1fqfMiLvpewgyPwLvS1lFiHjXtFMRnAXvoyfO1TjlBbpzaFGnb44+G/YBYVcSjpBGpT0vjLpVkoExkzNLdNzWq2nu3idk51waTnAvkaf3g4YlD2a9YczVwktzneL1Usoie3wAUWKSKa/+UI6JswufivBC9PHBcE3SkHyF24aSqO00E6mhjbTZBumPelDcLZKVhUgRIiikyQTG97dqM4FeMQqSCFiTpNL52f/h1rZq28A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(4143699003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A1oewC3Mwu+FsG6y62iLsOIWRAtsTPBfYaA0lrJ3nmTH0BlGJpjdl87rrLAJ?=
 =?us-ascii?Q?DEfLzdmcwfuYU73Sm4Uu2ULxu/YSAKYQo5B5dqqGFdW9IzepZGMN5SouCaFi?=
 =?us-ascii?Q?pDOvIgu0MtyPF6Je/BMsWpc322kmpPZbsiq6NgFp1MhDsDElOufURpPdHuWo?=
 =?us-ascii?Q?jnp+zDs/9LCMn0tM6oCx6SKNyinAL9533f8zImFaVnX7aQ8fN+fVgc3kuCSV?=
 =?us-ascii?Q?BKVz/F5jq/DqvERpbCqlakYX6+W3/lVujjpEf6jpYgnytaVYCjNEweYPlqm/?=
 =?us-ascii?Q?lBNjtOtcA+Ml+GjhLqnXZmFspvNoufgvrq4UQ1kLaBS5ky2V0Q9zDY1eJ6lI?=
 =?us-ascii?Q?on0TiTxIXTdPRB9EROPgpWYoZB5uOk5WvwHTNKoezbo+WlK3u1UBALKB7KLm?=
 =?us-ascii?Q?cskPTi21eXGZIPEVj2KpBTfAvj0HfvVd7sy6tRBa36aGBcFw3+V4xXslyUsL?=
 =?us-ascii?Q?KxEaggJIqE0uzsDAuBroCbJUVH44acOxdq204gd1DZXF+7CGlDYf/3GD9eyK?=
 =?us-ascii?Q?GH/J+h11t4XPSrlaETRN9KhPVxw/0I+S9FBFn/NrIeF6T5aRfA4FLX4coOWZ?=
 =?us-ascii?Q?+Zfdtla3cCBRzy6Ir+fP+lflk82hKQe+2Yf7HcjIlSU2DY/ZzeIcBEnsYIqR?=
 =?us-ascii?Q?MHxEgDzvqY9Y1yI87PHijBpE7vIw3/S9ymesnnWtBjKOJ6r3VLO3riZUdf8O?=
 =?us-ascii?Q?QTpCY1AE8X5/pGfhtCZyezfZQ5cJ6Fh0qjmV4DawsEfOL5N/L9xij1Vu4EGQ?=
 =?us-ascii?Q?kD8y1DpQIQqX5yf8dgiRcPyjOvMwWYt7Cjtfov81lSVXsa22wlPrigq0kABy?=
 =?us-ascii?Q?HP8CKxZDVzfSECdnEGcbXdUA8G3wbCpyPXgwzHOQN0Tlsf++odB9BpJFq2Eq?=
 =?us-ascii?Q?IgAM46i/EaneDqOkQp/jBnYF/dBK6Xrd0ijv868tLpy517ZgguWbuqxvm21t?=
 =?us-ascii?Q?0N7Ob9i8x6MVGmGkudBqfWj8BSReEpg04DZIHq6eVzc1JO+/Kc53cPsg8wRy?=
 =?us-ascii?Q?lOAQA1FnlLV49yGTyhh9ZP0bvWOIGvpM82chl3+WNda8DkCPb1winD+EKzYu?=
 =?us-ascii?Q?41/RZr3bYrO3qj4I28kN7UyXmkD2RZJMZwfU3y2OtaSCkgdn3cHeL1fjCLkP?=
 =?us-ascii?Q?aRHMfnyF5vYp+m3bF0a7OZDHTMLeWavA4hG7zgDHCwiglQ+KYkhkgGYPv0T5?=
 =?us-ascii?Q?tl8qvkIhRI2d1kvig0TED8gTfHr3rgPerLenfpt5LOVzLMkTObRyNay+COcp?=
 =?us-ascii?Q?SoiZBT1BKQB7NXISsTUmQxqrkCnf3EOHfsC1+uL0srYertkwdHRy2nUW61kg?=
 =?us-ascii?Q?v4TlXA0ZX9p77s83GdxhF+iPuyq3m2RRivv6eKAYTpWBTPgEYQV+uSpevjV/?=
 =?us-ascii?Q?gMNidafWOyKbD5QDuazwtyQ2jbwzxYhrn4IIlIHrOovcU8FTRX+Bg9qwMflZ?=
 =?us-ascii?Q?F+v8bKOB+d4HUke+pWOeNm3LBVsUuoQ5MzW1z0v0XkskNihQK446+cewAxkk?=
 =?us-ascii?Q?Hz3s23nZCK83ZEet0QTUQrrbTHJj9aYzk17cc66NrnEg4z5BNBVKW/kqUX79?=
 =?us-ascii?Q?/zYLIUWmEuqKwvKiClvWp4Ee/gY0mguy488jtNfky0UuwCdHbWjJzGpZVtyX?=
 =?us-ascii?Q?6RdKGJIk3iEDvT9cGbFs9w1VLOdJ0DUKjIQzZ4rUhL6JsyEhtMlWdV8wRYQM?=
 =?us-ascii?Q?JAuWD9HHIlaZPT6aYvMr4NijjBZAAykFDcTpkVsdvo17tlgE7HN/Jlx6qdsq?=
 =?us-ascii?Q?7KYiG/DPuQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JQkQq+XmY7VMnfIyyN03tGBxyoCCPcQRF5097MjZ2gIwvrh5kn5A2yttIdF2Yjfb0dbKsfKp7vI3tVcs3pRV8DE2cnUnYnA8fVgwMX/1LrzQNYMT57TTZOyVVR5rWzONFMdiAX6HEtScxVtSnDtg2klBmAp1ykxGEMuL6SczM3iHAPiJAJwcTxX/u1LQsiv0eRUPa5ft5On9Bkj9NDPT0hyYIkjZ6oSxmMxj7A9ZJ0+XwCA9pWMak7OD9QU1e6sLULLvLJjLwnB/8DYStCLIZv7agGB1TjhUoG//qos4Mn21I6CXbp0WBpTFJS9yCR3gLFQ0EqQdqh7K7mGesc4SCQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44daf49f-6749-4a2f-9d74-08dec13a3a37
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 06:34:56.2028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJ+NkgTgz9+XME+MfnnwXphSg87/KmEroYC7N7vsCV/hlum25MxOB/5VR1z/+zjPjdeTNw7inP7ejUuOClmOUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7308
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.pan@linux.microsoft.com>
> Sent: Wednesday, June 3, 2026 1:45 PM
>=20
> To support no-IOMMU mode where userspace drivers perform unsafe DMA
> using physical addresses, introduce a new API to retrieve the
> physical address of a user-allocated DMA buffer that has been mapped to
> an IOVA via IOMMU_IOAS_MAP. The mapping is backed by SW-only I/O page
> tables maintained by the generic IOMMUPT framework.

s/generic IOMMUPT/GENERIC_PT/

> +/**
> + * struct iommu_ioas_noiommu_get_pa -
> ioctl(IOMMU_IOAS_NOIOMMU_GET_PA)
> + * @size: sizeof(struct iommu_ioas_noiommu_get_pa)
> + * @flags: Reserved, must be 0 for now
> + * @ioas_id: IOAS ID to query IOVA to PA mapping from
> + * @__reserved: Must be 0
> + * @iova: IOVA to query
> + * @length: On input, maximum number of bytes to scan for contiguity (0
> means
> + *          no limit). On output, actual number of contiguous bytes star=
ting
> + *          from out_phys.
> + * @out_phys: Output physical address the IOVA maps to
> + *
> + * Query the physical address backing an IOVA range. The entire range mu=
st
> be
> + * mapped already. For noiommu devices doing unsafe DMA only.
> + */

only the starting IOVA must be mapped in the range.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
