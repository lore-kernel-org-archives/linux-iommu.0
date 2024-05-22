Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548347BAF4
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716361351; cv=fail; b=kfO1lQt2SDilUEmD1H0hmsalPKiVDmjxN+ylMUbQv+wK6kc8VG3gWIsFYFcf4PifaFNvNxnz/ZAcF0XuI2qlDpS+GvptIuDf/qAgjwAZjcsJtqGTB5QJxcmbYR+qx9cNaoE9PEB6wCl1MECUDBOFi7uWdjr8pOmGXuec+geCPVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716361351; c=relaxed/simple;
	bh=uY7Bbl54RXirDNw4S7FcrlKNRAwjBx28fsoU1j/Lti8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mfI/k6vLlaOiYQyvSrobvYKFV9jb6cecQI+4OYJJ4wByxxCWuJq81UZnjUXnyHWqkiPeL/W0vE5QJGDsz8qOCkDrWEDb0TsetL0ZGnK7/xzujHTeFSOCI/bdkbj42aXLicTQ3ZtsoY4pDDX4KRnxJPH7xlsDaD837+EA/BlNY08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLc4MIZZ; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLc4MIZZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716361349; x=1747897349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uY7Bbl54RXirDNw4S7FcrlKNRAwjBx28fsoU1j/Lti8=;
  b=nLc4MIZZjl3CULfDIGTsekhRx55wCm+rZhHf5DmoXWp8wlmzqewwypRZ
   UF851dQTeB7YXHnQ7ycR3nkCyKiIR4bIoVpjHg2pRkp0jkuaK+WbjyYun
   2azSoikNkpCXjFwWxX83JWfzoI4ZB7GzXZRvCofiKUwe6ePp3uc7/0aKq
   J4X5n6Dr9JMsoaB+HiHNmEwtog1TaDQqiFEMlTrlgCXPCEabT2op00NM9
   z3dXTUrCAPWwCoQW65ZbSpafQjjtObVpqF+7cNbjcjGepwrUfemVPGtNV
   x26rvKTwDJqKYkTGbHSeFg+Vtu829EYrTrmHR2PPTtWC/5Q5Fjpg91j9A
   Q==;
X-CSE-ConnectionGUID: xRoYhmSLTwSzxB4Gq+OMtw==
X-CSE-MsgGUID: olVhDmQDT1SSD/+D5xVJ9g==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12821901"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="12821901"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 00:02:23 -0700
X-CSE-ConnectionGUID: kdQNt6+9Smyy+j/Jt88/aw==
X-CSE-MsgGUID: E5+0Hg5GSvmrGdJLRHOutA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="38141155"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 00:02:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 00:02:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 00:02:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 00:02:22 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 00:02:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=it0hnsAPsXkIVe6NJ28P8jh4Rj2qll5sAPJiHrKUkm5tZ/8wG8JTGkUeyBIxHStzvGSIouJvA5po7XwHIfhH/gYsp/2cU7aTk7XIHDgjbIFGQASsWPKVs4/DX8M+kiCu5OdxZxDNi+gfumuOh0EEiKPVA7Cr0dBiK2YSM/nc1RCigSCPjc5MH27qWcOYVeCKWr9rF5zp5tKstV5AcpbjnAS6MTxKBkWQIwnK7ICKo/15+15QwkLvyFmyYW94E22BlOMYxZbM61BH75GdZOD5lNBWFl4xvzra25e0zAX7iYmwbckVH8CB+Ln0IuYtEjzreQT/wLaGHoH/XnJJU4GLNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xe3m+l5fryXoYKWEG9ZI0sDBim0nWzKYt+x4ed9eLNY=;
 b=b7ej4GK6CSqXnzBn/UwTUF50JuBlUxdkhdOp+4SQA/yws03KavGNI8uiwbtXZraLg7sJg7LXIA5A0h6+88hd/zPZr/ioOFmaVCXKrHxqPMIozyEjjAm5A5n3LFA63D658aHkeAlHH86A4kMBNm6BwmXeEL7rCoIanLnRViCdFhtQjuup/ncmyN5/3FzX+5HfXy64mQsVOm/aEOVhAebZ6hhxFoZoh6K5JxkGzvlsIitlLVJ/XIXe33JsS25A9GyMpftMlPowJqz8AaRWBPVK9AcI9E5iC8L7YzCn7grPqbG2WwnFgvXPyDPDZuZEI9G84LuUKFcGHq5E8thKgX+B8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8327.namprd11.prod.outlook.com (2603:10b6:806:378::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 07:02:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 07:02:20 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "will@kernel.org"
	<will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "mshavit@google.com"
	<mshavit@google.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, "zhukeqian1@huawei.com"
	<zhukeqian1@huawei.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: RE: [PATCH v3 1/4] iommu/arm-smmu-v3: Add feature detection for HTTU
Thread-Topic: [PATCH v3 1/4] iommu/arm-smmu-v3: Add feature detection for HTTU
Thread-Index: AQHamwSthUlNpYKKVUOCzWRzJOAT97Gi9bxA
Date: Wed, 22 May 2024 07:02:20 +0000
Message-ID: <BN9PR11MB5276551DB77BF73F0AAEFDCD8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-2-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20240430134308.1604-2-shameerali.kolothum.thodi@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8327:EE_
x-ms-office365-filtering-correlation-id: 19dd1919-2906-4cb4-7880-08dc7a2d1fb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?6pwyQhZnV743oJwm8RCRD0mHE6+cuLOyYCGP3Jkctcoy8c1+4Ys1G4l3BS/I?=
 =?us-ascii?Q?XhBl2VBTd75FfKV0/PBoLj5/nFEFieVz0UBeLBsnLQ2uEjY58Z/4dwNGRioA?=
 =?us-ascii?Q?TK+wn1BO6J0Di0f6hfBrxgG5aToGVcR8l9N+uNWAeqOdjjA16uXmV6PLwBcP?=
 =?us-ascii?Q?BDkmzTkSHqIS16iKzj6iDk0sLuMCuNengOiFVJU5Nd0vY8rmI01wMI2Ij9aW?=
 =?us-ascii?Q?2pwtNKJIv2Go4ZEv1+bBgqW6Z8bNYUCJSGhW5k8Etrqvx6nQCKM1Gs7R2TgD?=
 =?us-ascii?Q?9yBj8KdQncLj0lz0/B3u4ztsdxCLxfVLmv0Rd1oglAUgTIMRf3tdgCf1+Fl/?=
 =?us-ascii?Q?oSH51Xwk/uMpoF+/B/CsVDMeXWnHI1ZOtSfCmlR+t6BkTdhAj4cJpvEzBb5A?=
 =?us-ascii?Q?JvDH7SxENq/iF03pkQCKQOAwZzfomkmGEuG1uKsxRI9NnDRkyuyAe5gUTwJx?=
 =?us-ascii?Q?Vjp1ILNbGqknuqMk97gC/7yiqREhidHu5pRu5Pzpe/7x60ZbjzIgTcZmuQv1?=
 =?us-ascii?Q?2iNV2frRA2+IRskGX8S0Tash2+hTEVCWvUWh7ZxlGN4Tgcvzc0jFzi8D6Dty?=
 =?us-ascii?Q?A9zaMPAX14pnd0nuGpjFhWxiJDYJ4gKFqrjMGhYKrQCD3Aw6j3NBQJMnIdK0?=
 =?us-ascii?Q?bxm8aHySW+UZqcizJQtsL6Yvt18cNdU9/j58dat0CZz7PlsTn04OEfPCfdnv?=
 =?us-ascii?Q?t3tqsa+NSBeQysLWp9qbuK/t0HJTSzkmvkYF/IBtdHLRVTYzSGrPkURImxPs?=
 =?us-ascii?Q?CGdMcYQRAmJKYBCUUMl3uIqB5iQEk/zEltIb2KVXvSPkpX34IzTmjBN8OFYF?=
 =?us-ascii?Q?ngxpIHDIv5ZQFSX4h0c0Kp7PLFhs3/KuUqkkdMOI6FkNBajnNRSQ4BxwTFdG?=
 =?us-ascii?Q?rtDKmF1D0Yqeft8xJ1qWr5SJZ2T8jK6azMvOOA7iigKqbILaQ4B/2DdlYFbD?=
 =?us-ascii?Q?82G1OQ+GP8yC1/+itG01sn0dtbLwyXh5ArY5V/j4FgAb8Bx6TBgJtvzXs4U9?=
 =?us-ascii?Q?ZdL8teuLC922oXby7Zs+UporaOVSjCGrK0yKLlUdprwJPD3jrEqqJCvWWgqF?=
 =?us-ascii?Q?cWbFIHyvHDyN/ntdEtJW4pZVbGjZ1KAalLNor6kwFgvjpMY0t47VhU5XaoXu?=
 =?us-ascii?Q?+1n/ZVq+Hr4VvMPeLYZcIp+mUEslh6Ru0/oyS/vyxZwc9gYzNdIX+mDLGDRa?=
 =?us-ascii?Q?3E4jEn0SyAK5TkW4iVp1fy0/83Oc3RFCCYKusUH1O4M5ATNQg48MK4vdLewP?=
 =?us-ascii?Q?29Hu9N+0gv00uZ14+wu+vlTbC1IOhIGkjv2g1DlKH+jpmFg9Kz09prHlOBNg?=
 =?us-ascii?Q?cNw0qCA8rm7ZpzZddx4Vg/MZntEi613wtmhYeLdiqYlyRg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4kldVaahZyWsMKcWK9NAFYNgAKIwq2wDgtYuHo3jke0t9BWSxa6Pw87+Ach4?=
 =?us-ascii?Q?LDqMPXzhbJaBgvYU+NAwGZ/FhJm8xNALmBzfLM4mWrwM6gypI37PYrJcNjCL?=
 =?us-ascii?Q?/K3fz593o9TJUlpEPj8eXBo/y1ilRh7EzTOO4Q7fbWr5QqhGGKWRofm+4KYb?=
 =?us-ascii?Q?5/kKzBrYfv27G/Jdq4DSjYqz+Yicvz2ZpYZWMYiC2NmZanLaYmqQ24xXgrTB?=
 =?us-ascii?Q?jpGZQ1iYNaCCgKVRZIp+erJUbPvOpRpWuR79i0rwAy/rBjPglQIt0RExgEz5?=
 =?us-ascii?Q?wcxlEGMK8JRGYliFnlzUv/D1cg1teaiKezMJyy7r05ZNqtGuXwFhVWny2s/L?=
 =?us-ascii?Q?bsmEOq8wdLPMuH3N7SImVhfecJCAwRKoKHlV5s9VHV+QDIoaFqDtJsvQbGM6?=
 =?us-ascii?Q?kFfQojD862FuAamtprsdO0V8q4Rz6EECzLppSmjIipS9FIV3vUSz9uBPoFsJ?=
 =?us-ascii?Q?NrZLkvLHe+QLXqYPM9N/oprRhdUtn4pOZA8FSPmVlUMvMQBqnlmR1CY2X3Zn?=
 =?us-ascii?Q?SjqiUeN77fBwlB5vIhDxz+3lcJZniUHBoYKHH2ZTzQZGK2nY6dRH76rvK6UB?=
 =?us-ascii?Q?g6t+hTJDmT76uZdE1pzstbfDBmSr8qCaahVY79zKb3HrxGZYjKD76s2/mAhV?=
 =?us-ascii?Q?kmViE8bx6ZYmkVxmu14yyro3266Mo83HEhvxZPcHih7Tv+NLjbFMEbNHCGZd?=
 =?us-ascii?Q?wPJfDOhfURz0P0JpsPTAnkiNND1dC61TUqikEFyvxUde3jCbcjI9pkprMrZY?=
 =?us-ascii?Q?i0U4EYVpZgXNQTItkUEPwxx8Glh+baCBKrqcFF2kH6QGftyhtz5Fwa8lR8xW?=
 =?us-ascii?Q?E//+8bWZduGJLcucTbAYGDL/ae8awp+tvdeECjkIScGbOIEzo4lLo6xbahF9?=
 =?us-ascii?Q?hkooxdw8OmQiCLQDH+0w4fFWihNC/nOjnv2q137J/Ppmr/jjpoaNaqsmuDum?=
 =?us-ascii?Q?RUvmtYnIqWe114020fX8UAAJMexOJMXsC6zkvcGOUpMVapUhuGC4xeE/hSMm?=
 =?us-ascii?Q?JvgwxvAHfMN8zXuT33xpKR6+DiTaWC7EBcAJ2KXen1cD+zmqY0AZW/bONFO/?=
 =?us-ascii?Q?x+wPH6Q+HdjCidUzPrgLrdgmp8WJr+A+kc6KQfRvatr7QFS98h5Mxg8uPAKA?=
 =?us-ascii?Q?rLGqMwTBVg2Hvm4eMugINGnb+Laqh8k7M0n7UHhFc53CsuJrOYfL0Nyizt6e?=
 =?us-ascii?Q?TP3jMUHec3rubD1p3w8q69BssjfqgZvW1lvMQ84QIXx5tyME1ST2tUqU1VWR?=
 =?us-ascii?Q?3fxCOvXt6RH+q+Hh+tTt51inalXZ3eVsDytSVYhi7741fqzq0GheuGi0xk4D?=
 =?us-ascii?Q?1BiijiZEgHuzOLZhrOzo8ut+pAY+88tiK6npFdctDmA9CjJQU+wxHMPvypEF?=
 =?us-ascii?Q?70D6zijyZ4UiaxeC3Ni2C8gu4T3PU/dTQR6MEDyLKb4G8iY+yKkOhQxaNZLd?=
 =?us-ascii?Q?OXN+C3mLT7jk+osLSnEhMrth8S9g6nLLGluGM5p3R/6dxp7l8Ea1di1CzYP9?=
 =?us-ascii?Q?jXhAU2HCnia7dvyLkop1Ph3KlISHBzlq5Bt9duApehSVB0UBDINRWBazC/hp?=
 =?us-ascii?Q?ejZIlu0c1JvVSwyAmvviqmJ6S6GkNjwrcVv1+SpL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 19dd1919-2906-4cb4-7880-08dc7a2d1fb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 07:02:20.3861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQQZxwj2Q7UL/cfJvXwg70FoiDH145iGVa+Lf+m7QH76I5s4PuEs1OvCUf6gTh40kOWftznydsHcKbx4MAWwaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8327
X-OriginatorOrg: intel.com

> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Sent: Tuesday, April 30, 2024 9:43 PM
>=20
> +
> +	if (smmu->dev->of_node)
> +		smmu->features |=3D features;
> +	else if (features !=3D fw_features)
> +		/* ACPI IORT sets the HTTU bits */
> +		dev_warn(smmu->dev,
> +			 "IDR0.HTTU overridden by FW configuration
> (0x%x)\n",
> +			 fw_features);
> +}

it's probably good to print out the IDR0.HTTU value.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
