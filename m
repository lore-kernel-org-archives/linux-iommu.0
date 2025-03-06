Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ED218C332
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 03:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741230699; cv=fail; b=TYKjLvJrIIcZgK5bW/MGXKfjhcTlUyLqXaA1n3A4pMAggaakOxe/BPXUo+vXlozNPLyBRgNVtWWPBlahgvukwYkJfbzcIij+xmZbRDX9EsQ910b2+IDChgFqCJUBytaKUWnUvR9QRCbsrHV66TPz8FzQv9jwkLRf6PxJ5qlZSow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741230699; c=relaxed/simple;
	bh=Je2vW9YUw0LYPKmZQF0B1fZKDnCKErspAdacL20f3NY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hvQZteBx6MPA9sqVW667o3ND5WuoVxFNjGhj9arrPAYcfX/292R+EMeBJ/pQoB02Ot9Nrn+2Rm94qaUotHs+50M24sk97IE/GlvCSTKzlhBsovW4RaEtukuvm1TnvJJZh7KXkqWYfxtbDuULIC7EpuvjZMZSdLA7RVOJRHJpfos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtQ9cCcF; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtQ9cCcF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741230696; x=1772766696;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Je2vW9YUw0LYPKmZQF0B1fZKDnCKErspAdacL20f3NY=;
  b=OtQ9cCcFyFrGItgxhjR+D7Z9KFw5Ph8jRymqvAx9WO/bO8pkGEgkN0v5
   qBNeP9Ynx3O9Xxcl6LUMiLX9+7VVp1N/QpDib4lvjy6bieysfDNPNKzeh
   cp1wN1qDcegvrL4dBmK/+emcdxZ13nsRODR1R4AV1/2/qvrqwu5uRGb38
   9yFyTKo4mQ0Wd0FsuPvxifNAkpOz8dGg08coQ7JfUW5MFmiW1ciD7uRe5
   weGcegsRJk0LyMySCV4kdqPtMHHP7zRceEWaRTPaM68uW7CrchyP5cEUS
   GSTrYQnSSjQ38wWm4NSVJbmKqhJukFBRZXzb095aBqgAyjlI9ueFreFfr
   g==;
X-CSE-ConnectionGUID: KLUO1UcCRaWyaEa9pVep9A==
X-CSE-MsgGUID: YKhTQEQmRZGvQYiIasM4DA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42362416"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="42362416"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 19:11:35 -0800
X-CSE-ConnectionGUID: hzqQJ7hwRASpmZG5z6yeAA==
X-CSE-MsgGUID: m44gsSqDTQSiwqbKfFN6Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="123467178"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 19:11:12 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 5 Mar 2025 19:11:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Mar 2025 19:11:11 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 19:11:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9sev8N4JbqYvZP7eTeFpoa2x6HjqwrlesWj+MuH2EQaVl12kF7Oj/njQwt3oklirUoih98e5x/TQXrHYkI5VAkEKwuMbvlixJf9HBbOTZ743RkGP9LsLr+gtrhphTLYA7lMv/WyXOLWe03MPIjq7PGcwihlvnlEsZn/0GhRm/voeZQfdDO0vZa3rUeY/X2gmKL6RuvcWNokL5pPlc/OXteAzYye2gwRGojlGXiaqils3Xx/6jx1AWUSJQXSFFwlgwSCl9RHps9GGu92hJbmPeBto3zcfR7pzlLmAijRTRFjQk3twsLjLm1V9KJelwlhU+jUIHqjg4rmukwFv/VIUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvjtvWhMSa962qdoJookjoIUMcjvV1hTzb7IwzDM0dQ=;
 b=XpObuQl7AlJ76FYNwncGYCHUZ4pGcalZUak6f5Z+QzRkDxEpqkftgVwfvboO45IJVpJ+7D9xrV/0IVT/ey8Irg3LP2vzYMZOQQE/sCaXyLxQDIrdJVveKoZ1lOkz1y+4n1698NWvJstZHsLlb+3XHxToIc7B83i+7OzzUYgaCam8lrJUqjk5r8mXDSg2B4cKTms2uJdeqJUXUrplg0ygNYL3PHSMIuytce9t7A40nPhdLX1X0/7Zot3nGJY2hcP9DL+IO503xk1nGufsNy5OE7fL+MS1OXxZCVxoYm0XM5ge7ZWVjeio8MMNaX1Xx/djBrJkUjXTrGkeZJIAoBdfJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB8136.namprd11.prod.outlook.com (2603:10b6:8:159::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 03:10:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 03:10:55 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [RFC] iommufd: Use accurate dev_id in the PRI forwarding path
Thread-Topic: [RFC] iommufd: Use accurate dev_id in the PRI forwarding path
Thread-Index: AQHbjc8TuaqI9dW2VEO8xtB9FKkZhbNkyaYAgACkT+A=
Date: Thu, 6 Mar 2025 03:10:55 +0000
Message-ID: <BN9PR11MB5276771968FF57AC0FE74BCB8CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250305130356.126424-1-yi.l.liu@intel.com>
 <20250305171838.GC133783@nvidia.com>
In-Reply-To: <20250305171838.GC133783@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB8136:EE_
x-ms-office365-filtering-correlation-id: bb130475-4218-4b11-b4de-08dd5c5c8289
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?LaX/HFwB9R3lii3NE+cNP95FLOsd9l4CyIuhvpW+vhETIqk1uUnzw9h6GeGk?=
 =?us-ascii?Q?c1Uo9PXcu3MuGTSwVdQN5jMeDfLpq9WDUSTSMwkyewiEOqIsrLFypZ1nq9eA?=
 =?us-ascii?Q?cITPnC+kiCIAakoJTx6VZ+jd1R+FYjVUcPqZsT+PTkY07tAviNMw8s7DLBIV?=
 =?us-ascii?Q?mPgj7/gyz92FTp6m44xHET+Peh8fhixVNb6gUD9IJG6EMuLTRZfnNTzY3Icz?=
 =?us-ascii?Q?LDNPzjAQH80V1Y1Tg+AwqWsksj8wImnyuj0bsw/CmvnzxiXMnZac1cY4pug8?=
 =?us-ascii?Q?JfmdIR5A0FQbuObk/6kJMKW59TRq5g+X+9CVSZfrI00d8UD4Vh5aXvIe+YLU?=
 =?us-ascii?Q?BtLRPYQFCUg++x5RlA2VP5kJOJvE6LmlGeHPF96sJuHSnrZvcjTo4kKx0zU8?=
 =?us-ascii?Q?5mSKQBPzos8rWqPkg+AKcpgO8XIOSZIyFZJdNBF1xwSBEL3bGk26Sa/JOYjH?=
 =?us-ascii?Q?vojZ1CppHiRJj/kzkhoBVq1JGgi5N8FN6d5zH69Up1QHM7XuEjrxW+GoIqLT?=
 =?us-ascii?Q?gR8/ecG0Q0xeRsVEePy1460jjLxGenjwoLO2G9aLBIVWElhCoEQIMmnRSWdM?=
 =?us-ascii?Q?3AmjSmHWuUS4pbmucfMXE8TQ7zPJt0vip7pCZ7r0nnrIYVTcpwIX3ZrKa+63?=
 =?us-ascii?Q?3jBnHgwecxu+w+ZoBkaxlkTIprqYsmTGjmF0zpkdqMxUNGPDLMK16xqahqXp?=
 =?us-ascii?Q?3M/1N8+fM02nw331RfiRyKJHxEaFwgkQ8v+qGH7x0uqKpw3iwOawgra8vugD?=
 =?us-ascii?Q?Yn4fRA52euB2UwuncyKgCZo58o78xAz2IxmbFDCHvJIH6IgWwj0rLANeCJwl?=
 =?us-ascii?Q?Nu5Mgbavkx87qO5xcr0h183XxR1tRMmnDWbKptP45l1BUws3sDCfl+sR+y+c?=
 =?us-ascii?Q?1D6lqvYJsZKOLcmhDhIPy3sVbJTR+b+TbfFkTy+DEFWYY+M3CUxp3tV/IBWo?=
 =?us-ascii?Q?2/MolS/LMoJjREBqhM0KcvoyFijf0DBnZefibRKO7mArHPXoimh/4HZQ6MyS?=
 =?us-ascii?Q?6xzAfXJkHNWcmfWLyGvkw0kId5CJfZFo3cf4OkiaNcZAEsGlJPj0RZSjGZlq?=
 =?us-ascii?Q?zKNvlq/5kZ2yBM4HtlnA6GUHVKOkFLrr604/PdmaFX4PTLKBOlufoTcEcf8l?=
 =?us-ascii?Q?ET2oPsL84fUDzAZ+IF7/xFtHQrZxzzvevftYueZCAcduIVWyXjl7yX8JyJNP?=
 =?us-ascii?Q?WNiYAOv+vF86Co/YY4HNTyTL4KaFfX8jO4fgu88QY+BMrd50QmyI+J0c8l3G?=
 =?us-ascii?Q?0LNpXm9xHuq3bcx5lfoDwRgM2gXLOvUMcqM3kdOiT2DI90cOpBCvGMRfKIVP?=
 =?us-ascii?Q?ZIvIM1e6cSErGhfPkEEZXkRgrN/xqBLCYeyai4uhN3MBlQaovaZcpvMhZ3cZ?=
 =?us-ascii?Q?uBngQVVuAzXhZCKhf1iYV1JqKpR6owu5NIG/p2BNt+n5+K+Xhs4pd+4xCsmN?=
 =?us-ascii?Q?IB3JRm/dN3y3EgvFGIO81gYR9G48a0ht?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BirAbKVTIB2spOp8J8mNOIK799NhCk2jvfEnGbcY/uWho/vpEp5rLFWlargO?=
 =?us-ascii?Q?qxJNwokj+d36WLy6xw6dl2voaIaYS1FuxrxWd6cS8W1aiut509mucIzILt2u?=
 =?us-ascii?Q?S0DwecSIloOuIuVzpNqMQy6To4FBW+OnacbScJJQDN+KzzrdULM/f52aJ1T4?=
 =?us-ascii?Q?tYG2w7g2H4/zBwAXgZf89yU8TfoySV1cGbS3Wt26bUO6dHRT6T667cKuGgc7?=
 =?us-ascii?Q?DLSIK22QRWHz/SnQZwYkdH27WwlQlTYVH3DX/zv1hhZghb5vIe0nKciOxISw?=
 =?us-ascii?Q?HXBsgNhB25ZGyKvezRyF4DROMFslxkUW3p6e2Ce1l7satcA21nUwN4wj4pyr?=
 =?us-ascii?Q?tyXwSzI32ScfXGIOzNcgnTj0+/QIHuD+MdzGjAXU52GPIvoqhXL1slD4jRx6?=
 =?us-ascii?Q?O77jK9g7aBzSSqmIrc8bgT+NjTkmO5Qkl/D3uxkgHGh88mza72Nv6lHvzg6r?=
 =?us-ascii?Q?AkCF5leZDbSJ238z6lmS93iypxVVKP2DZbnueIwEOyfLXMIg81l73TKUFOLU?=
 =?us-ascii?Q?bJKiuvWg5mjxXmj9tRSFJdBnRZT1ER39WMlvZ/eIiTE1n3BbmUKmuBT+GTao?=
 =?us-ascii?Q?gCoChXaefRyUpbh5t0J6eKMoz4yD4qzSGlDVNVLfqyZhJ8eTlgTaQ/02EpzY?=
 =?us-ascii?Q?BixNxVAcXMF9g3Jjb1SM/QYrbj05SAf+EBTp44Gmhsb3SIY5XrezCLWSh7vk?=
 =?us-ascii?Q?GaT7mveq/pj+xq3n0JQdMiHLw6BNzffmDTePcThrZ09kc8GPW0zQhUmA6Las?=
 =?us-ascii?Q?6iRt7p4KswQTLE03v1y4X0GEyLJnpJs29/Pd0BmOZd7ldDQUCKaCkPv6jPDe?=
 =?us-ascii?Q?f9NSjINt/xiMcvpexUn+CBRLqy8Co/r2X0rv/r6udvYMJt3WKYHHV+YwQLkw?=
 =?us-ascii?Q?ZDFZBiYyOIy0M7yplKVd8v8nNezs1vQhS7NY11bqt3ie8yH6oiUq/p0jPPmW?=
 =?us-ascii?Q?3U9LGZD/ATMnZHiTI+ti8bKqiY/uJOvNPs8j0G89TDFM0vlhZAv+Jdnypxhd?=
 =?us-ascii?Q?f1cP3vsxzwOi/1V16p2QCDre9a31/onoJjr7c/uy5lBtOyAYuCDOM4GUj4P4?=
 =?us-ascii?Q?yN6vji326BrgxIomoC3C9EwAdMDGwre8X7ixNq6Z3oqEb67U3/LJeLFzQ/vD?=
 =?us-ascii?Q?4S3VS1m3z0YmCm8wX4wFCTaOli5UhRFyh/8AyYYw06s1guY+2r6R1s/Z5eSE?=
 =?us-ascii?Q?SxvOquWa00ZsJLjZYZjhySr10nHX2/szEl0G/zIs1uhcyEYzNuaS+2p1vixk?=
 =?us-ascii?Q?rC3t+Kb3a/GCbIMrwmFrYl8/t25QV+x6pKh3DS/AZYOvvpjXuGZsO+5JsWme?=
 =?us-ascii?Q?kC3NjzeaK98b7GgiojivYETLgPXSuwpUhpIN3wljm+U3zfb0JVC7fV+OYt55?=
 =?us-ascii?Q?ireXY8F62bglbBlxtLvmoqB8Ptu/KWI089KVSaHb9KEx427v/lSzzqC8qrw8?=
 =?us-ascii?Q?qfLd6goWmFcTpoueL+30o1vRmv/Zpp3O3wllhjKBqO9Ob8OsgYXCyvhn8dcu?=
 =?us-ascii?Q?g5Cll2ArwpphwE5TNFwnkqCqbb3YFuMHzMNCxd8BepYSrRspETrqOr4KXaNd?=
 =?us-ascii?Q?T5DWdyBMhu/iAx1Sa1IcJYhp6Fljt2OW6kOp9vw3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb130475-4218-4b11-b4de-08dd5c5c8289
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 03:10:55.2987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDIDN0DVDvGwkYxM6nuaGaStPJsJCOVVhVAHcK8PX3qqqVDvD/byFwkfOJA9BhKI7y8eEAa6RBB/mSsjYzEUCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8136
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, March 6, 2025 1:19 AM
>=20
> On Wed, Mar 05, 2025 at 05:03:56AM -0800, Yi Liu wrote:
> > Hi Jason, Kevin, Baolu,
> >
> > This is more a query, the patch here does not really work as there
> > is locking issue. So I'd like to hear from you if any good idea.
> >
> > Detail as below:
> >
> > Existing code has a problem when the PRI happens on a device that has
> > alias. The PRI reporting path uses the idev stored in the handle. While
> > this idev is the first idev that attachs to the domain.  If the PRI
> > happens on devices other than the first attached device, then the idev
> > stored in handle does not match.
>=20
> Do you actually care about this? Can we say that devices that have
> aliases do not allow PRI?
>=20
> I'm confused about how that can even work if the RID is erased in the
> fabric, how do we deliver the PRI response to the correct entity?
>=20

Another tricky thing is when some devices in the group support PRI
but others don't...

I'm inclined to agree that it's simpler to disable PRI on non-singleton
group, than trying to fix and eanble it.
