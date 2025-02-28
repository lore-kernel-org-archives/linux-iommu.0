Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927562B9A9
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 06:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740723385; cv=fail; b=laMeqOPPMX634YnnOHqB45SmTIW6AZCWDyp1EHoJxde8DRq6Jbh4gC5ryxAANxP9SgpaVaglQUpiWv2ajGwEAkulADqSuHbjNVBBq/bOEYqU1IH5tKLi9LxgJSFCDp6KvqknrnFGUdrHtJKODdqqoWcKM8YRCZsSUEtE4GY3HyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740723385; c=relaxed/simple;
	bh=jFLpE3TnsVQK6Tu44ds0BywolPcQ/HUbtMlSbUGUMn4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UinYYf4QT5jtBHQi+YBU5XLvlHnnSPgjQhkGvak8QWppdOaYHeG1CbP2/GGhqeExjr8MhwIG7e2Lv+WX+dlUG4RqoA7ptKlD4ELqdrv2ST7Au7DYtRrP1zX+kTdZ6h6i0lblWdhPCKgID4kmyqMKnExVwdpf4DhiWfiIpEfyKvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBu0/hQ8; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBu0/hQ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740723380; x=1772259380;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jFLpE3TnsVQK6Tu44ds0BywolPcQ/HUbtMlSbUGUMn4=;
  b=KBu0/hQ8HgxrF2AfvYz2EteemoApY0Mmpp3KKySVvn9D+xhOAZcup6gD
   so3Ejxr9eSjNXmWQUBvSliTfF7/pQTtCZmBnsoEmOtEIUqmdyf0WNeFmn
   xZ6hxIV3hs5vAi9SWckY3XRPr1IJHOp6M9seernlhqrrpCZGJPtc1FVFk
   Iz6QzD2dYb1Cp/llNKuSBAoT71tQSEtn37apUb1d0xRKCCVL6qs1sq2YK
   4dDZ2+l0KgPhPjTxRHw697J2CZUyoLoyO03r0VyLEuKD+goRDyc9q/Ssf
   hGcKAxjDNL7Lv5QT0jOJ3+X+c4kwSfS8XAi2qTcO7bs6WnfB8XOJiTrzy
   g==;
X-CSE-ConnectionGUID: NdQHybhwTHiLPgnOzFoypw==
X-CSE-MsgGUID: 5pHuAj5fQ5Keu1Fs90hnEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41836594"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41836594"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 22:16:19 -0800
X-CSE-ConnectionGUID: ZnH9YH1tTwuS+t0Lw0r/5A==
X-CSE-MsgGUID: hs6h/3ZkQEqKRqd+ewWUyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118177897"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 22:16:19 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Feb 2025 22:16:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Feb 2025 22:16:18 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 22:16:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIAnM8NZyR06bkVaK+54LJRgVtQwPj5pNlJPzAvpQISPMI1kMt/cy2OLCN5WSwPTJoKUVu4ioXda8yXknU8E3J4F00kEFySPFM2NR2TaeARScLooimCttsDiaHBID/UGoGVhVXlAZ8uLWNLvJgwjQ5XUs+qB85MyYnDYfkOwgCSUoa0aVu9nbY9MDEUkcmwo+380eUMJUbuMiwiwXYxSMGT+2QKn/fqubDX83glMstl5drSQM/mQJILGYxzA9icDYLVgYvVVqYgiue/I1do47a1k+1yJr9I7tOHgBOgcYgbFL3afCmPycXutd08639sFnDqW2MWQkGChLGegDLE+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83RD/uaNtx8SjDyYNkVBHSmRVDGbkqMlfY9kodhOiF8=;
 b=Qc5gchWLeCpUSlNOoIQRpPsgoEyhioDCUH/VFv7eiTFznSZwmmxR6CiK9iXRrttXqK/jT4N8qg9HHYDtq2p4com5t7IjhCSdLDcZny72p8TWZAukGZG5BAhSvBKnjfJRUK/+IQ/fDnuCFEiw9GVLhW5S5Vaquq5QKl/IIytEDGpI0Qhh7SreKL+aYLPmvAp1Hwxix81ywt3FNOMvfCWYABMgDMe6Kt5wedubmNa6trLANUgYWEIBuaOODK2iI2jSgGmX0pwni3Eyfvaec6zgn62tJkXkobZeGiRtV50BbNWUc2dNuVs1Bh02GKFjh1h07m8Srfy6m12EhwBpBg4UrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ1PR11MB6203.namprd11.prod.outlook.com (2603:10b6:a03:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 06:15:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 06:15:32 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH] iommu/amd: Add Secure ATS support
Thread-Topic: [PATCH] iommu/amd: Add Secure ATS support
Thread-Index: AQHbh3UOCMVRgdan70yjYJFDyKuOHbNX8z2AgAANboCAABr8AIAA6H6AgAAmfHCAAijjgIAAoxWAgABE8HA=
Date: Fri, 28 Feb 2025 06:15:32 +0000
Message-ID: <BN9PR11MB5276D09A00E44AE7D220D7C18CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <b630b6c0-a25c-4230-8abd-a48b7dc27216@amd.com>
 <BN9PR11MB5276B090C61D1F059538AF7B8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <cc4cf4ae-2d29-4747-b655-df841661b82a@amd.com>
 <26fa08c1-4a3c-44a6-aba6-a35a0f308bc8@linux.intel.com>
In-Reply-To: <26fa08c1-4a3c-44a6-aba6-a35a0f308bc8@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ1PR11MB6203:EE_
x-ms-office365-filtering-correlation-id: 4e634723-a7ee-4406-5bbf-08dd57bf4ea3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?XRlQDuLC1Tm4Dt7jK5G8l+wbJhIVRADHcKT1kOZUQCaZJFoCRhzM32K5LfHR?=
 =?us-ascii?Q?LhrBvDpQ7uQh3jpgTeuez8tL1NMxpDLbs1ofnEzi+qWi1PuYxwMb505fLWsJ?=
 =?us-ascii?Q?MFd1EHzk/m01OFWal8Qvvu7pL53SZc+gTC0YNnXZYKtqkj8x885B2Qq6linx?=
 =?us-ascii?Q?AwUO+rzDnupr+7u6I+UGo2EpV+fvliuMYANFpnwqn1UxxrT08kqzUEUtxmZD?=
 =?us-ascii?Q?eLFUu+nh9tKDP8TN/x6JAx7xW+EePfVElvFVG47i85PFiY/oAt5Rhz4XL69A?=
 =?us-ascii?Q?YTlk7GMWmIcE5F2J2uwLAKQjOKE9M3DYsYiA3E7D9aYzu1oh1YL1uAhtkmQp?=
 =?us-ascii?Q?37t25WZEaLM1iL61WEbsKdmCqeZ8pw3W7lDlomCIT6LHsRNcm6E0L+EqYOrm?=
 =?us-ascii?Q?5KOWeCt/lNyqUDcK+9daPIeA3BfwCVO9Jjb/mJ6/47v+KT8d5NEhhBhL5xwD?=
 =?us-ascii?Q?ZgPSTtW2snrHC2A61mudGoDkujaVAkPh5ySXSTUzuDq+eeZX2GS83OVGBhXM?=
 =?us-ascii?Q?teah1BK2xPJEsdG5JZUSmfCyu5F3s8N7cO7semWdzb9ss80U8PCVVCc7TLzH?=
 =?us-ascii?Q?tQrq0rBMDjdy3TkjGJtdeR5UvWhU4YASEUOw9U+3UP2cCJRqPWY0Y63xR71G?=
 =?us-ascii?Q?thxplvCInbXpimnT0/NvsIEmxWJG62oNnxgz4lLsZwyJeuIzFMhzkmK3O6tp?=
 =?us-ascii?Q?kUP09nSwcaYgGwIMLcdT3zQoy7+Hdx3GUwzv1kxswoxh4VvmPC20v2YDAk6p?=
 =?us-ascii?Q?7XSnuQ2120zQ8MpZ+Xx+zEQYdCUjHHBx4uqyER53fM6wn/T6vzWvgB4aRBlQ?=
 =?us-ascii?Q?7VL27GKRDOHGuexq3qu6UJ6ocSexIxtwy19qTreU45EVfyMes+pS4n0MyFGu?=
 =?us-ascii?Q?zzJvasLaRsVBtASE22tynna050z1BOW3FErMYl3S8BjmR6pN2ly7V2HP9nTK?=
 =?us-ascii?Q?PBrWiaNPMCOi+yT4ftwYqbOqrlTWcqEdOJmKFk7DmnrJ0KLKhd+ttYiogF69?=
 =?us-ascii?Q?0Pr061FXMHA70m0L1cFweivMLuNv2IqUFpAbcPh/0/5/gAN26JAnf2gT3i0S?=
 =?us-ascii?Q?5LD3PChpI0mzN7Vu/4bl4cR5J/ps4j9NOmIApU17/3YGDJ7tdDJUDo+Cq/z8?=
 =?us-ascii?Q?fkO+lw14pvvhgMsGAA4AmPlI8HkFigO8kXb/Ym3p2X2decd5lkCXYPEhqCnV?=
 =?us-ascii?Q?HPXxBhYyVRy0RdpWXXXt8gSONNCNaaTj/jvC4qYv5T11SH648Mx3HrIqJHiw?=
 =?us-ascii?Q?aGItDBGwcDNyQ2Swyz+vB/CuK5nVaF0SAUbf+GaJHq6McKZJhR8erLSZBc6P?=
 =?us-ascii?Q?fkxYvTgfOCP8i/83p5na5oYLKocB97DUh07g/ysnH2UJ6E0gTkXOWWmOAZR1?=
 =?us-ascii?Q?d9V1ac0VYqNV2x2WjCIhj1L7mwjSPzNlT5BU17hOIub9eiZmPQs0WXduPRzd?=
 =?us-ascii?Q?yl+OBxU3Wvwr4DMQfVROFil29rjKlyou?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3CmKVO0mVmctVEEEuihQEvhsFJLlfuM2J8q9ItVqMMWhmhJKIU9zYQQJKMeR?=
 =?us-ascii?Q?1OvbrOReas6+LR+aa0KXjfUTJtXQQCK++wvy7XjrPLQ/l2vWdnR3T5asx6sN?=
 =?us-ascii?Q?vC2XyFb3zr/KXsOAtIgZpAiYgRe0Hke/tghwaUXrS1oYdUPOg9r6pAG5pPxL?=
 =?us-ascii?Q?LKwHFHUH6YNUsvjPDwAYWzpr9UfFAhrl+xDCT9z1xcE5atlIsDVK0fCykwDW?=
 =?us-ascii?Q?WCeydfwuG3XrOSX/U6zl+mqHYOCG4+HZsHI6mHHNp6RU8w+XoNn0yCuCovaX?=
 =?us-ascii?Q?AGdWHeJh2TONQwleDpzW4ed0zlCpazAIWr8aN6r0LIwuAVwNeLVE0YCEbax9?=
 =?us-ascii?Q?mqE6eE9xjKK0yMf8TzEBzmzot78cD8glFFm/nNonhBRK0d5nG6HWkES1jeAa?=
 =?us-ascii?Q?cEaCEv3h0uEvay+Hxn/kQXx0WceIrEepRV+j7pBFG4H+CuNPVgv4maMOzZ5/?=
 =?us-ascii?Q?9MGWqEWWC0JO1UYRjgCu5yfoK3LcZWxADtFioLGigYlSJeAc4DgB7NDhX4yn?=
 =?us-ascii?Q?8Heyrws6hF+Uj3fytCz+Wpm3rHX5kczV7OBc7O2gs/duZlgCI4dAdTqfOgIY?=
 =?us-ascii?Q?iC3udmM4Xk0JOmC0OFR9stVbE7D4jy+xKoQ5QeSueW8B0bZbkJrHP7TMIrsS?=
 =?us-ascii?Q?vA5TnS5i7ydMUlkE2vx18groqe8vIPgN95Jk1HUAmRSzG2todRU2PE8XcW77?=
 =?us-ascii?Q?oD+Us7jOtsgra4eQL+FT9FnQ1Nqmkj6qvDdH4t1QFP5f8RSRYmaxiYT4fTbA?=
 =?us-ascii?Q?q+xfvaHk4vj2lPXjRXF34629g0w+U5z6O1wOJausKOiOmKGJDauAAWmjv7Nq?=
 =?us-ascii?Q?lnzlGimRWMhRCaCcWOsfFQLX0JPzxbf+uzeaZnLhNUDa+Yy7Zk1mDu1B63FL?=
 =?us-ascii?Q?jDq/HBIE9k9Z1q6Ectr2KmqU6F6Bq26dfcGRqGOeABTqgnvegzH4nyHl6QwT?=
 =?us-ascii?Q?gQ++v7CL/dCsGuCd0V9ZE7khXwo2r/85jEvR/4wq/11B0xwUD1EVGJE4Dr1c?=
 =?us-ascii?Q?VyYfGrfOKmyLs0DNnc1BQEwojah/eZzQuVlbtd+k1IyOrpp5ldui57uEIzfn?=
 =?us-ascii?Q?R3BTO8bUcVRwnxIwmXStPU4HqlXHLO1Cp63tMY0ZCW3dJ+OrkG7npy8fbd4N?=
 =?us-ascii?Q?aFFGhy8gdyQ0Lk0fsPGcA0WLNXYjs5YA+1s4GkzB42ANP7cQbOVKo5qjcujY?=
 =?us-ascii?Q?/6yp3Gdvnk4PIRzjmHxErKAnJWsttX8fqVDYBsi4kjcx9Cm6khcZRxSLWKgJ?=
 =?us-ascii?Q?/7DE/Zs8w4Fycu/Tcm1pi6ojqGQP6zJxTpEDjMCAcQ5iegEktB9jUcTDjDL8?=
 =?us-ascii?Q?b8NzI1tiB1xRuEE1bYoc1x0K6VxGFty1kihtoQz0LmNbsqtQBxyZjTVTEuKd?=
 =?us-ascii?Q?42GSR5JY1x8NwzXiZ/xaiqC6688o2Xewh3Ep3A2U6s4S0i8o+xyO+kZUJbi0?=
 =?us-ascii?Q?9KvBOyVkkIUenI0dU7NYWyhQw3ZHNyHQ8rLOimSkc3V4Rv8c5+4Vve8jYZjs?=
 =?us-ascii?Q?Ply1qZRj1Q/haafnHQHEoMF/NyCaxJ31unlPfH984O98+uorRyqT+x/9apW6?=
 =?us-ascii?Q?Jt1dqF45CJshR8EiKjfmCju3u0bDb/vLv+oaTjqp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e634723-a7ee-4406-5bbf-08dd57bf4ea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 06:15:32.5752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QuJvRSfVMbx2wREzmiv5U6NC6ZIe1VvvFdTt2hWTPl6NHIN2XAzD1YXUEBOlbg33qyhyzvM4KR+zaeWGdETZ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6203
X-OriginatorOrg: intel.com

> From: Baolu Lu <baolu.lu@linux.intel.com>
> Sent: Friday, February 28, 2025 9:48 AM
>=20
> On 2/28/25 00:04, Vasant Hegde wrote:
> > On 2/26/2025 12:40 PM, Tian, Kevin wrote:
> >>> From: Vasant Hegde<vasant.hegde@amd.com>
> >>> Sent: Wednesday, February 26, 2025 12:47 PM
> >>>
> >>>>   3) TA is an IOVA and the IOMMU runs it through the full translatio=
n
> >>>>      to validate it. ATS is just used to signal non-present
> >>> Yes. AMD does this when Host page table is configured.
> >> Here 'signal non-present' implies to support PRI.
> >>
> >> But...
> >>
> >>> We need to consider various scenarios. For AMD:
> >>>    - Currently on baremetal, we cannot enable SVA and Secure ATS
> >> ... here it says SVA/SATS are incompatible. Any more background?
> > Sorry. I should have explained it better.
> >
> > To support SVA (PASID/PRI), we have to configure domain with AMD Guest
> (v2) Page
> > table and host page table will not be set (DTE[Mode]=3D0).
> >
> >    GVA -> GPA contains translation and GPA =3D SPA.
> >
> > On ATS request it will send GPA back to device (which is actually a SPA=
). We
> can
> > support secure ATS, but ATS response will contain the SPA.
>=20
> So, the hardware is configured to work in secure ATS mode, but the ATS
> is not actually secure here, right? AMD's secure ATS relies on checking
> GPA to SPA translation; however, GPA is always equal to SPA in the SVA
> case.
>=20
> Am I understanding this correctly?
>=20

Looks so.

To support secure ATS, the IOMMU needs a structure to manage the
permission per the translated address (TA).

For #2 it reuses the S2 page table for permission track hence requires
nesting and TA =3D S2 IOVA. It cannot support bare metal SVA given
S2 is absent.

AMD is clearly this flavor. also supported by ARM.

For #3 it reuses the full translation (s1, s2, or nested) with TA =3D
untranslated IOVA. This supposes to work with all existing ATS
scenarios. Probably good for prototype development but no
real value given it loses all perf benefit from ATS or even worse
perf compared to no ats due to double walking.

Both #2/#3 have PCI topology restrictions e.g. CXL.

ARM probably supports #3 as a special case of #2.

For #4, it introduces a separate permission structure per real
physical address, hence TA =3D physical address. It's supposed
to work for all ATS scenarios and CXL, with some burden e.g.
sync with IO page table plus more invalidations, etc.

Intel/ARM supports it.
