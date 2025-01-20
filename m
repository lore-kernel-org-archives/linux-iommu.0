Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648EE149C4F
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 05:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737351886; cv=fail; b=clVvie3l+9H7kgvuvO9bNij9xwkk1uU9fESHFkT7pg5dEqIZFqHqlN0+pFIKShtOINzwGhpkuoZgiMcunVXceXJEmFVhtWj/Ecc2k8zBDrkn/5w2r6hSCCP8BM7ZUcnYW5NYWl92qIFZ/+RlZDy7aSeyuePeBc2ou0l8bi3L7Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737351886; c=relaxed/simple;
	bh=u91lmwDN+k3qXDd/ugnJyYI2AqCiFvBsaTglImnWlH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KwmRtvie5sPhg/ZiHYKiOp8dRyY6hKMbRgNcPv3DohHw3kUtVtzO91OANHviC57r8tSsBcl3vflU5klnQgGBNCJlIaIq6h5hiTlfdYDtyos03paggdhJrFXtIWAwQmewyV6+RCAetUyPtspaqkmESHk0YMZAZH7BladUNGOX5X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XDxxrViZ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XDxxrViZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737351885; x=1768887885;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u91lmwDN+k3qXDd/ugnJyYI2AqCiFvBsaTglImnWlH0=;
  b=XDxxrViZmPLevTTMaheJwZNbJ1DtIGJUNgiWXxON9ap2buRmYO6EwfyM
   2YehtHVdPeVrUN3cACoZxXJU+PGnHCMvqePCQaufgVlYSc299sy3lJvl4
   O9YcYSuvXgYuTS4fbreOserr2311Xz4YcVu3oAKvpDAcGOeqSKKLB2UMg
   R2fh4lz7sv1md8ix9taxTV4LuWBGsTetmjr6T5kcJq2BOgaZEjO5tmLk9
   2ieCWBsVBNyD4kkRy0TWufQ/pL7d4x9sDcDxkpt7vIUyVaJTLLQNBIu1/
   lXyYR4sD7v5FGwV5y7sU8Lvq8hUMn5vxsubqFrqKpj/N135xYBTZtBNYm
   g==;
X-CSE-ConnectionGUID: wbDBThgRTHesyU0itLACNA==
X-CSE-MsgGUID: cL+Z8+L0T86uWBL8FQBOkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="40519717"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="40519717"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 21:44:44 -0800
X-CSE-ConnectionGUID: rxjpyGSAT0af1GEemN2KWg==
X-CSE-MsgGUID: ydmdIOe7Q26ws+swCX6gvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="106195468"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2025 21:44:45 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 19 Jan 2025 21:44:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 19 Jan 2025 21:44:43 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 19 Jan 2025 21:44:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPOBL+yD+r73vQp+RwNOS1jqQ9CJLmri8UoyS9l6DhbxhclUe0uLAlJobZqV197qEBero1F+ftxxois0k4mBDoYcLEP/JARf5OLDAO5ZKc571rCfiq2RmtSj18BrG47a1p9UqnFVhZo48KiFR5MXWJr54ygRn4P9LBwuowccvUEmJ025kgS12yWNskmTO0UJLMix12TTvqHJzwTzJmftbddErlqMB3xKxlkj8vI8Z5lGAOC0NqdIi6BwSGZ8KnyHQ/kpQjLj9Q4rs1zHrZ8mSj7+OxhnrNkfDF01v/rvaOLKIpapfCAT0Ivom/ej/F64ph9BxD+N8qrkOEVrthWfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoaJOnGIfzYj1iVkkngWpIv9Y+J7AhImL7SIIhphq3A=;
 b=wmnysMoDWPoin0SaD9aDVXCnckARliPwAsuF9JC53r0G93ds1JFJetfSy1j4H0xkmwtkA7AG1kD+eBirhxDL2c3FaU4Ejsio+5RVRE1U1lxgtOGIZxS5hJ1q7qK5+9S6IT2KMdanmrQ+a5CvjrC2FKd3VlTdc+fFLl9xjzokuMmRjy/Lx7zVFDZKMXY1NhRE423Gk1lt6SdG383PFvV+6/mEInxUs1tlet1ukMxGHFyDOnUUshHei1oxiHc++PUlmnb6ZN3+Gyz1SdecoxeczacqYhVdeUI0cZ5UlNYoYdDR9fPjCI230LSzttWn8bUlAD8H3yHG+hRy7veAkmYiXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5075.namprd11.prod.outlook.com (2603:10b6:303:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 05:44:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 05:44:27 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rc] iommufd: Explicitize struct iommu_hwpt_pgfault padding
Thread-Topic: [PATCH rc] iommufd: Explicitize struct iommu_hwpt_pgfault
 padding
Thread-Index: AQHbaVHmmtfYnrXIOEa0ulGpTwODU7MfKKMQ
Date: Mon, 20 Jan 2025 05:44:27 +0000
Message-ID: <BN9PR11MB5276F3057E4F8DFA3F22E3C48CE72@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250118023657.142517-1-nicolinc@nvidia.com>
In-Reply-To: <20250118023657.142517-1-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5075:EE_
x-ms-office365-filtering-correlation-id: d0f48e04-a164-4396-5688-08dd39158110
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?yYLg5rw+JU35v4IQZrVVFGFWWz/flsGpTZadF3qEsGQGJhEFGEOjSfnoa5XH?=
 =?us-ascii?Q?LTCgA6g8KSiwweZrbhOTpnjMrL5CkVpuVhIP/sdK/dQI0d2LmhKn6KFmKgpL?=
 =?us-ascii?Q?rJ/AEp7w7O5nsAA5gH6zDBsPwHD/fr0IaTzqmGOOdystcezhdn+gThDNf7xo?=
 =?us-ascii?Q?G0F0pRBU+6Yp8zKxOkM3I6nio7jFcJbOXUOZs2T+qFXmb5zyh00pfJ1JGsf0?=
 =?us-ascii?Q?0pRu/pYlk2yiJyzRjk/ZMf0wWXMJ5WaXW5DxAMipyA0tIFXZ/6MvYaR2EZR2?=
 =?us-ascii?Q?NnN3WXXFFxI/GiI8fq8vfYXKTT4JCFYbjYDJ/F/lwFCbYW1kSEyj0noTDJIi?=
 =?us-ascii?Q?NZCVVHG/7FoM2SKfb3fa7OV0PZT/UKSkjVLufYlSxJF0csL9SqUKvzBNQjJO?=
 =?us-ascii?Q?P5q6+ib8sj+nbxtk49m1aDc5CjLiGVXcdw28aAut4KtYMrZPLCi5z3spq95g?=
 =?us-ascii?Q?sh7ta71rqyt3oUYnKnFVsQcNRLox0t16KJ8y3/pw5Fk7YjyuC3ErfgLw2l/5?=
 =?us-ascii?Q?SWR7YYXPIhPEgydQNak8GpV2KW55vm+FfDWBFvNhCioj5G8vKTxPGKDOj0Kr?=
 =?us-ascii?Q?xzxNj7clpsD36epluJCdka9UJ8tHb+YCO0Gcl+UHFeJ4DOg2gmEGxD5zfD9i?=
 =?us-ascii?Q?JT7wsmWwFqa8vnfPsUtg8oaekSSxkHhe/JhIOlBwUx3LRR3OFRNBEOO7odSt?=
 =?us-ascii?Q?J+r+6ephI8+Ralj9VHoPrCZHGwa7FdY8XDCQ4gdLYveh2Izzt1dY1CsSOAzp?=
 =?us-ascii?Q?8KfOlLLgKon1/mLzTocWHdF0tkgBvZP9w20GHp2s6l2vQAvnmQn/4Q+MGsa/?=
 =?us-ascii?Q?QbPVSp3E1g65CnWiOQT+b0Cak7DvWQySgdkhALyeySVKcod8sepdk8y+dxxE?=
 =?us-ascii?Q?sWQgH0fzEzBq2mtnhACGFMf4T+GyttN0RQUykW4OwTS8vw0HJDDgnHVZSZF5?=
 =?us-ascii?Q?aaPnHoOK6tWn0zmtAfklu0X3VKqSW1vgz8wxZBzSdDkDIvo/kH6elNaUDUew?=
 =?us-ascii?Q?KAshU01s817gbevCoc3RKiYGm5Man/I2Ss8qp8CwqA1FnTHZyfZH7EWgSW4r?=
 =?us-ascii?Q?qVpEJb00XD+48nohvWa8YmGSADOPluzdD2B3DkcwFWKSn8dOqmzvxpt/W3eQ?=
 =?us-ascii?Q?bDtlG2UCcRHkOqtEIBE1SvxHE2jj/n2rQF19o8acZZKQYYDkRP48MZtNjxrs?=
 =?us-ascii?Q?w8Bun2Z9BK3BSlmR1DO0WdtBJPymx5Gfl8oHB/YMMsgYJcPddzVTA+eEfmKm?=
 =?us-ascii?Q?Hy2+TIqYi8dnGcEWLz4TtupdeFNVwgMLGoaSxCkMVjoKXKa+SqxdOr+92V80?=
 =?us-ascii?Q?BEYVjCDrD66rk1557ykHFZrs7NJ8sIOf9zdNVIEo03mKDUeogt/x2xW49/1+?=
 =?us-ascii?Q?8NNV/TeRjfbpuWOIZMDlAAFeGV0+zlw0dnU5J+6ztq4JsyJoM/Y1GD/5suz7?=
 =?us-ascii?Q?EqHDFFQ7pQBVk8XG6O5t/7v35WyruQuZ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BzPkbnjsiwalJCEihGDi5HDnhnP5wEiGtKsuwMqCF+hoIXzlRcJKfcMKj7rJ?=
 =?us-ascii?Q?PKveIBHFlnMfehs5kBvRbXWrrlh4Rmrihwa5tmUomA4NKrKrH3fF3vIOReak?=
 =?us-ascii?Q?0x4e6iCoXp/Zo36+bSbGm+8qr8naf7Yv3YP87Vf65W0CcmGBDXU3dCYyGeEq?=
 =?us-ascii?Q?HztftRGX5XfRNpyQDqND6MQhQawmHeY6RGIGKZ9YjKTwI49uIBCLY+GwX/AA?=
 =?us-ascii?Q?AA/8ZnY3V6kwSOYipW4uc0ruB2DYRpLDNKvbzoDUxrVRbb/1YK6qfu5FAf1n?=
 =?us-ascii?Q?bp2viu3zgw+1p5dCKbgUMIlDZUnMyNbkp42sKZwm8L7a+fDQNqX+YVkKCvWI?=
 =?us-ascii?Q?7ltc/hpllBwTrnyU1b6/lSxYoRBPqbtyuwGumx0XOcRSIc7aJWs+7odTZqJq?=
 =?us-ascii?Q?esigxQX0d0Sew3rAXnMv83LVG7noyafqrhBJ9OH53BR87hzd8AVUH98kjcME?=
 =?us-ascii?Q?VG8lfRiGrdXbCj4Ya0wLRXoMxzKnp77s+fn6g3/gkfaDHlk41Lp/G1qSLfQa?=
 =?us-ascii?Q?tiU9lClWyOcXByudRa2mzfUofvAPfJ44US287Bgaoa63aDrD/Xe/kqZPo38i?=
 =?us-ascii?Q?IjINm8MqILiabC881Docz3BGtJzOjg5HVNjXR7ZDBcB7JPv2zTQMFYcPLlWb?=
 =?us-ascii?Q?4k0Ajb5OMW5bGWqAFZ3EfJNsNdJaObh36d8J4oL4GLoVnCKCwx5NYQ4/oEK3?=
 =?us-ascii?Q?iTWqgBWs935snPz2Lnl90J7XXoMZON6Jv0Vj7XekR1hO7zkaWgEuBzeMO799?=
 =?us-ascii?Q?RvC7ZX/zuyg3vTqCvNVFtkdbtkAer96LX69wKiVU+9va+2DiQ+V1BCWP+v3i?=
 =?us-ascii?Q?P9V0ypMECjUPrYc7c8mhUC+reNj68+n60j1YDg7K7agqNmya52njDNcqmahk?=
 =?us-ascii?Q?uC80I/Iu6if4zPe/Y7TdXMa62mGIk1tzJEBBY+1YyVErFeYAury3/J6vspUx?=
 =?us-ascii?Q?Umt3thzpOSWcLWjVD3Zz8aIZ+yPjU6tAgG+BXMgzK5RbtU3Z9VgfqBlLxcCa?=
 =?us-ascii?Q?jJ03+qSfqWkrr7rFJB5llfU5kEY35AK1RocCEXYK3zlXXyaQcuytLFLKy0S4?=
 =?us-ascii?Q?Zrx7OBSzsaqIKKxLwPzJRmH6o5cdxp8GWOEcgw0KXGUbpZUnklCd2OCodOyi?=
 =?us-ascii?Q?SsBH/Byr2jMTJyagcoeAAf9FIc1esEzsrbyIFQIo1W9fQHtVYZF9hOms1Qoi?=
 =?us-ascii?Q?azlTC04qcm12GRT1jNWjasUBKKVzCwgZ3etMiE5LGTfSEzbRnfl9TFB8Qdvw?=
 =?us-ascii?Q?ztab9fZ0axfXBvQ0hLERBHld8O6iBw5mAQGl2leN1sIbKAnDoG5UAt6+bSpR?=
 =?us-ascii?Q?Vg4a28WoWQpYoIK4Hnhlsvgnq/6pHjC0RLdTB3b0TQM0geisTCt4jyd38S96?=
 =?us-ascii?Q?dxQQ2cAd7taMInivNSFXZ1kJYJMOk6cLF6dSyRI+PeqsgUkJDF/uyd5hN8Em?=
 =?us-ascii?Q?RoLSNaMUMVlhyIG7Cuw/rGrxuD4K+CCptEKhsRkbD4PgVcedrzGzv78nazap?=
 =?us-ascii?Q?JxsDASV/fSA3A6RNzBZHTgbvZc01YQadHZ/4kecyW4F/i58JTw6tXYGcYq44?=
 =?us-ascii?Q?Iu05z95mqCzoSx7euVUL35yHHvZqHhIKKvmbHn7t?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f48e04-a164-4396-5688-08dd39158110
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 05:44:27.8702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWUQ3R+7r3ahDN56qI0w7NcdFHH3Ct/UvzEvE7vnq5vb2NbUTekTkD5WVT9/St6+uH6wbzMdS6Ctr9NF5mNykw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5075
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, January 18, 2025 10:37 AM
>=20
> @@ -868,6 +868,7 @@ enum iommu_hwpt_pgfault_perm {
>   * @pasid: Process Address Space ID
>   * @grpid: Page Request Group Index
>   * @perm: Combination of enum iommu_hwpt_pgfault_perm
> + * @__reserved: Must be 0.

iommufd_fault_fops_read() doesn't follow this statement as
hwpt_fault is on stack with that field uninitialized.

