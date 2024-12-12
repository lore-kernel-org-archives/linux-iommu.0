Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6729E176AB7
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733984329; cv=fail; b=iBvg/+osxKJLV0eZmcVbthxwQuV2jpFwPBHk176rHLCByegLIdTiuLfe0+r1AnADdLKyc5f2Q2w/B9XIG3A1TD0ZjxUmU79ftwqVTfrPs9pAHXjpT4zOrAtdVp18qG796+uaDqn+Q6sC6rTH+w+oyrLZQUlwyIHzAfk58Q8Gkv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733984329; c=relaxed/simple;
	bh=Yck9E8PLMTfXopEn2Z4ncL1lJvSRFqIFTvVrFvb0qOQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qrz0zITorwyN02xUFg9+rZ4WSWieok0uaEg5npwerkkf9+g5uikSNLYEyBT4daiWekTBdLKquW/JD0CaGA8bYqNCsebi5+abK3aRBOlhBv6kM+P62mbtxQSN9BxMxC+2Dwlh20ekfYvp8fvCO9qL9vZqvxggCAt8Dw3NENNNYYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUbfCypj; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUbfCypj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733984328; x=1765520328;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Yck9E8PLMTfXopEn2Z4ncL1lJvSRFqIFTvVrFvb0qOQ=;
  b=UUbfCypjH1W5YYV1ZXGXGg4qLKRsjP9PYBZ1jDlPOsy/YW7V07lDWcsY
   LfZrYcJ+jbmOpJ9He9mPRUDAwNC8sfTXl6JoQqdJPammARHH8n2Bn9ZnT
   AH2/Zk1hCBRH3aR+WjMaA5RsrZ8VhO2iVLuaG6kDtugs0j3rASelTwObf
   5bCTRBWgjorhrFL0lb6eBxbxKkyZsQEerWdBYil0Cp3pdSjJ6aH6900g/
   EuuKFlkRngiDAPrgXBepWzhoAeidZtPEuZ219KPhTemFM7YCoWMrE5rxk
   KxCYnKBdYDlGH2Lxf+YANBKW3IoJUv14xgTXEhSglvIxEEHsLV+evzoJl
   A==;
X-CSE-ConnectionGUID: qZyU3MTsTeKaJgy4zwKMsw==
X-CSE-MsgGUID: M8LAlkj0QY6FxYV/o2D5nQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="38170884"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="38170884"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:18:47 -0800
X-CSE-ConnectionGUID: 7gGonSTqS12Y6VI4lWYCZw==
X-CSE-MsgGUID: pCGNHjzcR9On6bCmePJpPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101078407"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 22:18:43 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 22:18:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 11 Dec 2024 22:18:39 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 22:18:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgyuYVjh9UPe+ItXRSY3dvuNKuAiX2ESPAlUFyAiQihS4x9nBvvIXlofG1QfwGhtRMRmPozPyFN4XtAJq2Hz5Sy2z+y2/upEnwAgz+sqoX3g1axRtDJqvprJoKwhuQm6ShxjK2bL5nHEGrbl/gzUM9FNEmq1R5eKcKHJZRzC0f/GfKEcOKqH4GoUvX4KNsGYYBa1eCggwodgLYJvAKSDmqYt+i9jeuO7vgzL1Z3q6VuxvcM63zWQpdT9gJW3gFe2Xo10MoZZnVGTKyMwMQZXyDOJzUCJHeSET1d5yntFRzQS9MmsNZGKQhgosFH/O1v6NiWzEcBvtr4aZD5NrlWvLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLj0y4vzFC15RwRo27JbWRmi0urOSJPISg1BpVyE76M=;
 b=WV5Zn32EwDZnuGlnkQ/7m+hpjOPfY2W+mHBDV30tTJ9X0FpZfeuB4Zhao22bXn5aCF4KCkPIXRTt4/PZFoCxyeJnyVujD4kLG1LXYnGTQveRSdO7UhV12/J6FO5qA7Ox4+SvRLkxkl3GltXDgDo9JRYOIYP1epzhjQXhuNfe5rnIGvnQ9Ul4C1ZO61lGkGDnymJwysi0W04v1eNME8s1aoXrNr7b9TylmL7fx9LLVATpFZ+3FE35EyFp5kQ3c4Uc5nYs3ybsTYzDlIpL9yc1k0CiAvxavbcSluM2C9m1EqOHl2KGlB4B74M6RNcRWtUU//CsoFMpHyDEI4IMGzbaaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5250.namprd11.prod.outlook.com (2603:10b6:610:e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 06:18:07 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 06:18:07 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Avoid draining PRQ in sva mm release path
Thread-Topic: [PATCH 1/1] iommu/vt-d: Avoid draining PRQ in sva mm release
 path
Thread-Index: AQHbTDv3EGBJfd9NiU2L1xV26EC/BLLiIMKw
Date: Thu, 12 Dec 2024 06:18:07 +0000
Message-ID: <BN9PR11MB5276682CEF64D6D21658893D8C3F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241212021529.1104745-1-baolu.lu@linux.intel.com>
In-Reply-To: <20241212021529.1104745-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5250:EE_
x-ms-office365-filtering-correlation-id: 15d921d4-df65-4b9b-4533-08dd1a74beb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?PYU8nDuc06NyCngYaDoEkH6AwafRoG/GSbWYGQoRW03WSxygR7tQ4WwM11xY?=
 =?us-ascii?Q?Qg8/KKtv1x6XxDkKqk0l0i4Kmih/oJ7lem91AC225DkU/sl67Jh3lU47tbhI?=
 =?us-ascii?Q?nhdcjCg+btIC1NvwK/B5iUw+tIzb5LmZ4Z7wXvuuK3HM02kFSxRteoxjTnKb?=
 =?us-ascii?Q?szmLZKGBMdU/KIHS9Y0N4Nx33+r6krt0MIHWx+lOgxX8/1u9fXCfAkekH0Gw?=
 =?us-ascii?Q?qYUR7FKrKzUOyaeVAVjgmMM2bRKdqoFrmqaVOtnf82iz2Kh3YeFs6BJOIZWA?=
 =?us-ascii?Q?/UMyM/ucrm/mUrw6DE81hHfDtilTDxQ++bv935QstxZSmIcsl6AS5J6moxzD?=
 =?us-ascii?Q?lTh4CR4gV8kgrK/7SMeWT5C6rpOskMDo38nd7blZFTxASr0RCYa6DWxCoo3Y?=
 =?us-ascii?Q?5EuP2SqQY3J83nD50/Wo4iWHng4T9exO6pYupHZ//4y0V26jWbGX4VFa+EnG?=
 =?us-ascii?Q?zTgVPNBqgg+yoWr+S1QPgoPYire5wO1rOCUlm2cbIXXPxJpy8i5wD4a8yXJZ?=
 =?us-ascii?Q?LoPPLeoq1E2v+gD5bxp6sQoXyG3cV3skCUx43kXJD7whgN2uUGu1vTn7/+YD?=
 =?us-ascii?Q?iWJbmtrgSfh6sIWHDAiL6T7Nxgibzpi0xgrQm2oiHRN5a57SizCcGe79iEdm?=
 =?us-ascii?Q?WX3rIcDKtuwEkNymW6FnYerxKLpVPb7N9/j6+QB4438UzMKpTD0KdsB8qTDM?=
 =?us-ascii?Q?GgNY3Bq2TQ3U4+BgGALT0t9zLC/YoqNFGuC3JpLIGlbKT/0cYeCb/W+Yh6pO?=
 =?us-ascii?Q?QFmcdnWi0GcrsjUKt6YaIbmYw13Bb3SIzeYEV5hd9MjA1caG7HGlF+7pHsyn?=
 =?us-ascii?Q?Q69DPnmgjhSESe+xn+THJpWGnqQNSSSQ6ma9CTc5EIKj0+iWljzdWNwnI6Yn?=
 =?us-ascii?Q?X8ctPFBXEF7cMxdPFCl5mXIsHpf/alyj0EHYY8W/usHKdU6ic10AKgK7+lzd?=
 =?us-ascii?Q?HZnbXvJXCz/XDx2EbuvTV7S8fL1pECSvctVon+jutDWCMVBYnNjHqRm7ingc?=
 =?us-ascii?Q?qLSEZrZbirAUC32l2jp6MnecrReTupm9a5CyPwLvm+klGtO2Xlri7OdTBovn?=
 =?us-ascii?Q?WrAadUV3mu7wMmquQtMJpWypU+Y47Xb+UA3sp4qBimOGjTNpitcp0FiBgGJM?=
 =?us-ascii?Q?Q3s7hVxH70UP028jacipQ68bbBdp+9XbKjBdqv1I/+fBKJwVe4vtMvZGMHo9?=
 =?us-ascii?Q?pezGDRqkZiBOH3sfoo1x+TSA3fFWk8YswbLqXU2POZXcbp6CWfLyH+eNP+lQ?=
 =?us-ascii?Q?zdFlhiliBmVI+MB+V/go2WUYh7xhLYfumWTdwIrXgUzJXqcOJGgSfi4V3uG3?=
 =?us-ascii?Q?prwKM21sO//dYB3vYrhq7RfkG3oWnSMWOB+uV7vgOhzm2MkbMN/oUhIV/lXw?=
 =?us-ascii?Q?/zdBwXegVXxw662WsiIDFyPWXM6sk/KPscxNlN02zmus4T1REg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iUQDuRgZd9jMZrYx7S+L6r06+xvf80rNvQmIDRBCWqy/TkZ/zr0jIkBU97ks?=
 =?us-ascii?Q?9pg2mA5/AUmXx1KNqzhRq+RpKiIoTxStK2bHyw2IHusyoBf/sixYr6DZhG4w?=
 =?us-ascii?Q?Fauh/ua2wLThnMXKv5ve7wb6LhQN6SfeR5nrfVNXW+EvD3Bfok8CDzChByHK?=
 =?us-ascii?Q?4QOAFSAwK2/nrSTB/eM8uY48QciEp3nilIknIQ73OngV9gAe1HJlD1TuWH0r?=
 =?us-ascii?Q?00s6LKQTgLxoHZwLDcJVun+vriYBl7waiUvB20YH/Rq3EI8ukvGwOi6qjH+y?=
 =?us-ascii?Q?K55ESQMVpNu5gI1h9fSgmjOfMmyD/4Yr4N3uvHJz63l3zp3vGwdz3YPRBSEN?=
 =?us-ascii?Q?ZtjfXcqeI5RG96y2hK3TkWsOMmga6yYqUkDUvnco3Vbw3TRaDXSMoPWTtsYR?=
 =?us-ascii?Q?yiFk/V7v/vO3PipJwoxX6WqAqrdklNJAwapdHpTreW913v5om6gGE6yd9yFx?=
 =?us-ascii?Q?1yeDxboiYMVAjqLpktxGRhzTESgykrD24G20e1luSXbbYZFSrBg4PTUDjNw5?=
 =?us-ascii?Q?5VcyFxYhcxHmHsh6Dn7KaS78SumSoUOd+8QvpeXbNr/CaZ8Pua1BBMqCJgcp?=
 =?us-ascii?Q?OC9xCSko/dwRPr4PJLy3TotBKD15+k2rFoc+mu3W1yuRCmqsGvcb8J49IrNG?=
 =?us-ascii?Q?EgbECbiqTuw0Q81+ejqy7CZUcJ8vNKjHB7BkaGUvimDHJtoW/o2Lh3efTMCn?=
 =?us-ascii?Q?jtId+meRea+e5nJy/xh//syL+xmHsxlG3nsNKB6pGWHHGBvTm+aOeSx+IpC5?=
 =?us-ascii?Q?ZwEpiBoRN5bnTzEwFscZ1bE2EiwR4n9mdlsGDlStAa25iJjCHNji96DtFvGq?=
 =?us-ascii?Q?YOpRaCAKSRoYeT6HzbHSmUwmWia4bhylePIfL2NB5oCGhSV2YPE9u+RZO4bW?=
 =?us-ascii?Q?5T5MxNMb772h3ap+IzE3orz0BQYTwr+k7DDqFEdhtOQh6+jd/O1R7Xs6WeFV?=
 =?us-ascii?Q?yqjSm8gOLLmhAFRsIhfH32cz1PRg6TvnPrwllYsT23qXYQytrkOP7+O47QHl?=
 =?us-ascii?Q?6TEyUS3TJHB0ibMf9RkB1tI5bQgQSMIop/B0GqKD9FvbVGBwXp2wdOoLttda?=
 =?us-ascii?Q?INrlQrMhvWK9/XsHB9vV5B80/GPJ4icctm4xQuYOnS8EmMtvkwhLdfG5QXLE?=
 =?us-ascii?Q?1mtmOnwdOI6OB/6Cd99Vpw20Ly0POH/ahsMPj3TWCJkMmJ8ZANdSR+wOjPPY?=
 =?us-ascii?Q?E39814hx7aam7V4Tp1Xe+TZdxJ6UQQPknL88LbE5HBV0XV5W7VmJoutenANY?=
 =?us-ascii?Q?DM0TPt9+xEKWbWiJ2fbNPip19uZ8Tbs4oJww8yoqJnfvt8C+rRg/SvSwLE0t?=
 =?us-ascii?Q?8Kr5szwPwvhemwIA6cifrG/ghwGrVOsNaWXROw3E6F3e7Htii6JBjAnjSC3i?=
 =?us-ascii?Q?NGJztKpQWJTqibUfgYp05Ol6MAlPbBdbXPK9G/8tYI9ilDe0J6pI6Hbw4a7v?=
 =?us-ascii?Q?F2qWWORE2beQOAV94bZfZp8JkPvt6SAFMYwkimmy81OiJIvYD2vSAM4+NiVO?=
 =?us-ascii?Q?gp4E7TUstjmxJK3n0dK6qbrZNL0ANUEHcE+5y/v9Frn3/q2+EmKnFVhVneT6?=
 =?us-ascii?Q?i7rXKAjlyHYnWrfqJwLpQfMoRir4Re/Mu721An/4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d921d4-df65-4b9b-4533-08dd1a74beb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 06:18:07.4229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GIPHBXMoC+EQXqr/bXoCztFmhVU4JVOP21YdlpWWkJeGjP1lie7KWiZaMSy2jHxdawMM+oSNMfEHJPWoZluc1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5250
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, December 12, 2024 10:15 AM
>=20
> When a PASID is used for SVA by a device, it's possible that the PASID
> entry is cleared before the device flushes all ongoing DMA requests and
> removes the SVA domain. This can occur when an exception happens and
> the
> process terminates before the device driver stops DMA and calls the
> iommu driver to unbind the PASID.
>=20
> There's no need to drain the PRQ in the mm release path. Instead, the PRQ
> will be drained in the SVA unbind path.
>=20
> Unfortunately, commit c43e1ccdebf2 ("iommu/vt-d: Drain PRQs when
> domain
> removed from RID") changed this behavior by unconditionally draining the
> PRQ in intel_pasid_tear_down_entry(). This can lead to a potential
> sleeping-in-atomic-context issue.
>=20
> Smatch static checker warning:
>=20
> 	drivers/iommu/intel/prq.c:95 intel_iommu_drain_pasid_prq()
> 	warn: sleeping in atomic context
>=20
> To avoid this issue, prevent draining the PRQ in the SVA mm release path
> and restore the previous behavior.
>=20
> Fixes: c43e1ccdebf2 ("iommu/vt-d: Drain PRQs when domain removed from
> RID")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-iommu/c5187676-2fa2-4e29-94e0-
> 4a279dc88b49@stanley.mountain/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/pasid.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 0f2a926d3bd5..5b7d85f1e143 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -265,7 +265,8 @@ void intel_pasid_tear_down_entry(struct
> intel_iommu *iommu, struct device *dev,
>  		iommu->flush.flush_iotlb(iommu, did, 0, 0,
> DMA_TLB_DSI_FLUSH);
>=20
>  	devtlb_invalidation_with_pasid(iommu, dev, pasid);
> -	intel_iommu_drain_pasid_prq(dev, pasid);
> +	if (!fault_ignore)
> +		intel_iommu_drain_pasid_prq(dev, pasid);
>  }
>=20

As a regression fix:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

But I doubt whether it's working as expected. According to the
description and code, intel_pasid_tear_down_entry() is called
twice: the 1st in the mm release path and the 2nd in the unbind
path. PRQ draining is skipped in the former.

But intel_pasid_tear_down_entry() has a check at the beginning:

	pte =3D intel_pasid_get_entry(dev, pasid);
	if (WARN_ON(!pte) || !pasid_pte_is_present(pte)) {
		spin_unlock(&iommu->lock);
		return;
	}

The 1st invocation already clears the pasid entry with FPD set.

Then the 2nd invocation will return early instead of moving to
the point of PRQ draining.

Did I overlook anything?

