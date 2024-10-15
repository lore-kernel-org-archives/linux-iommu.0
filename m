Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE271B4F0A
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979830; cv=fail; b=Bh6Cc3KqHt1K/S9VGMuiwIQxUa1uyTbkdZUtW59elKvmjJXJka7bc4mpgiKME9hQvDIJB5toTa8h6L+z2jpsTBfX7punpAFiTb5bbtebWCP+59Lsjuw8BMkQUu1tNWwFX/JyXgEJzW9XfhujrwWZX4gUj6q1a32NcmadODhwluQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979830; c=relaxed/simple;
	bh=7YxklSSyeXBrC7spVKzcvrMdrdMXUkry6IJnBqulr5E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qmsNBaFg7XEiGDCl9ytrl77Nk+OHJZD/l2QjYXtFUb/lyQwIbXbDdFWJ1rZ38xT8Fy9mNKuaKPIFROihDrHxnXbPgZtxm2s6dWtkia0ZsVPoDq/ETnp/xBiPUMrYsL1EA1Zz8P/bgiNbp+09LyQ0CYSv3Bwuvu130Xds6trBcKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m8Xup6mw; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m8Xup6mw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728979829; x=1760515829;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7YxklSSyeXBrC7spVKzcvrMdrdMXUkry6IJnBqulr5E=;
  b=m8Xup6mwleeiVoNtZCjtUgPoWVp73Eoo44Eb1kdKvc622jRlxxr0zhWx
   NWoVdygT/PS1KRvbX8cVw46d3NcBcVsENihKsmqukoNw4Ffkpf9L0DQGE
   +fTaTYw4e8SGVRysaHbaIoH0BRGj4fZP3e09n//y2yN+EBEFd5eBDLaeS
   HksDcWlpvtW2Mk3m65vL7+JbHgXZSZ7GO9v/cnGyKIDHvYcH77aLUtVWx
   8y0hQwDNnFu3fV7zzYD2E7NKx1XxsOeAjJBo9mgnEalmCpf36nNhB14eN
   IHObxk3cEko2hjX1J+QtBXDCm4YqtkA3UUUgnmNj40+U8jlw9zkRBVpsY
   w==;
X-CSE-ConnectionGUID: 3rsU7IfcQUW6Qzl2732kPQ==
X-CSE-MsgGUID: Pp4efJdzQlG6C/YB0/R5nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="38910794"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="38910794"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 01:10:25 -0700
X-CSE-ConnectionGUID: SN/NyL25R6uBtiseUmeJhg==
X-CSE-MsgGUID: /dYfp6NxTP+iJVfJ6og8aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="78638762"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 01:10:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 01:10:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 01:10:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 01:10:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouZWsYp2OU6zXanTti7YQcQNQjbPID6L0o9iaDon8XhXIyf4Ok3ikV0Bpi3yv2vF4GAmkf7Zky2eoCynWyUt+y4psDMBy8Mw3s0OmrZbn1sBUgAmuJKPITDC57jTgRIkxbsrLEV1XONeK3lk90A38RtAbRP/NiL9rCNS/hg3pivAk1aRD2vcn/AXakK4RjWracxzR+fEH0ooa808HbGdDVKYphMAZPiDx3s/lGCpTLATU+EEFx2yeu40CqjMmutSu1fdJcWpm7JyZRtDykaaLPCLYSIkpECgXMaijG/eUERxvus9eSqr0uh37w6hu64r9AzA2DmW6MU8a5L/Wj73JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YxklSSyeXBrC7spVKzcvrMdrdMXUkry6IJnBqulr5E=;
 b=IloIs758FwLTXGSu+4Fi3foGbWgvjQW/+gthRdf7BeQxTqe2f1wd29/YEtTi9zRiLB2OBXXm62pmDhiy3BBU6J8Us92agsD2gJjy+DAgDqWiNCXbSBgYDb0GdM7bB6CpPDhIERb2unFEbi8gVz/2ofpysZGHGijlIp2YaWj+E5OFFKr8vFWQLYtfY4zz9N5U0h2lOb6dD1v8y20slwRhTqgu7Q0I6CYp7N3TAhZpM8DeS+fUG7SrWj4DGCcBwLWs9bHTSX0N8g35oouQIu9MYCWahGMSxB9zxHkt6sa/J09N/zJO1odZZzYAtAgcdyny8WeU7amuDvJ7cUdxKldfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB7117.namprd11.prod.outlook.com (2603:10b6:510:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Tue, 15 Oct
 2024 08:10:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 08:10:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Vasant Hegde <vasant.hegde@amd.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>
Subject: RE: [PATCH v2 0/8] iommu: Domain allocation enhancements
Thread-Topic: [PATCH v2 0/8] iommu: Domain allocation enhancements
Thread-Index: AQHbBDQqs9HEBqpHkUq9bG42EKBwfrJzD/0AgArSsgCAAHcIAIAAJ9MAgAKrhMCAAG7egIAGDd+Q
Date: Tue, 15 Oct 2024 08:10:17 +0000
Message-ID: <BN9PR11MB527664BCC1637D2524673CE88C452@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <970c6058-9e02-4cf6-bcb9-cfb8afb4eac1@amd.com>
 <71d20ff3-0a85-4670-8559-70ca5e6543c0@linux.intel.com>
 <9d0101b4-af13-4bf6-94a5-43a79f4d9989@amd.com>
 <20241009121548.GE762027@ziepe.ca>
 <BN9PR11MB52765C7FB8A106FCC7E944E98C792@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20241011113901.GI762027@ziepe.ca>
In-Reply-To: <20241011113901.GI762027@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB7117:EE_
x-ms-office365-filtering-correlation-id: a1e5cbab-c919-4157-d501-08dcecf0ce6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?543y8RlIEZODPoo+YB5yPeR8fLbNeG3PWKxsSpbyd4QUvWpgyFwZZo3tbUu0?=
 =?us-ascii?Q?5ABTKf0jT4YXHDy4r5g2iQ9PG8RnKGOWYenB+1sPNLtp2bifvMR5aF5uN3mR?=
 =?us-ascii?Q?V+QHy2ZJOfdq0nZn91TY2ORzhswMgHDQPzN8TlAJWV645cfYrLPWLpV0zjbm?=
 =?us-ascii?Q?azceCvxsw6WbuqbOknfsXnjxqweN309is9OWUznc4tOwOFPg6BFmig60vusj?=
 =?us-ascii?Q?Vclou6cQLB6K4q/C2yqWSrf+FpZVKfJr6b0N2LG616uZaBakQkihu77Lg0NQ?=
 =?us-ascii?Q?SrJmBwibJcxu8VmpYQgkLvTk9KugWZ6Pu676rb8velIWPm8bq0xEw6KAVZL4?=
 =?us-ascii?Q?2oq5zzITNRSriygon7K3xo+diAYpF501pLfE2VT3NG6iPxYGMl2OZjJUZ3YN?=
 =?us-ascii?Q?XN8V5dTGFW7GJkpF+N5WBzZLyK7jF2H+IWJ/BN4tUF47e5CA4jOjw5dwfup9?=
 =?us-ascii?Q?QVSjJPAuvCc58WqGb7zAEn9Sz1U+IieK4snfFuYGmzznPMQpmiHicSucD3Yv?=
 =?us-ascii?Q?kxYBGo+m/35G/p5j/S5jLGFcBCSFU1ymV37EtVtTMeNIS0RiH6Q+SRsGyXVP?=
 =?us-ascii?Q?D1P9mBpxkP/S7NPwo3FWb7z1jaC8MkTmm+RAiToGXaKWdazil5w7p/r7OQlR?=
 =?us-ascii?Q?K0vOIwrX+y0YTWUVEmlhwVVNOhY2eVHRZpTrvJWNXTRLnhyELIdm6u2QCQbS?=
 =?us-ascii?Q?LDE+7gQa1iOV4ANbKAzzAxJoKbsZRjDCBu/qMQfIKWrmuNpMuI7iZslZSH7R?=
 =?us-ascii?Q?NwvbPIyG5xJka7Rc5iu52EGoL4mXQBdjo0VVuDdgPwqQXuUUP+ixYUcreYI/?=
 =?us-ascii?Q?oqRYBHqluXeG2+PoZQfSUwvw/AzNwR28yztltwIGwUGrYkc4Ly71wTM3rjGe?=
 =?us-ascii?Q?M2nYaUYEgCHZJ6gz4lL00duc5DhLgK6TO2UP+sIIAu45qNi7rIYaa+XwdI5j?=
 =?us-ascii?Q?7zSv0nrQnBJ75nzgeChsJT4IzDj1O9ghIooLKiuwLYvppXUVMJLvgRHMXfHM?=
 =?us-ascii?Q?K03mMM2Nfm3l8pZ/QPI9uyiIBkD9oL/rmFKP3fEWnL7pBzt7JStZ3L2uXyL0?=
 =?us-ascii?Q?OiRMUUGbFXSh2r2IFLH6ckg7R7ZJgnzIQ8n+ic+LDGfRWjhhdhcG4t/QdR24?=
 =?us-ascii?Q?DgQsei4b2pR9WcBhCAUvhExq7FNW0LkHHDD2ur1HROCtF6Kc4xM4BoMpkilh?=
 =?us-ascii?Q?LtykjTQP+kFwox1IZDsbgOSuKGy03nze6z+CewRBf2Vg3ki3vuCNSTSOU5Hd?=
 =?us-ascii?Q?3IgjBkIXGDbY9SE4qjL4dMaWFRAc3yRrQSjK9TfH+bEjsogneUzfdfn38Kf5?=
 =?us-ascii?Q?U1E9gNZmmbgBw1ScxaT+VIKAq17MHjWkHwkUiDSkNcmlGg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c8T0y8fzV0cKjC+t55ciXlkbmTyiHfKz40YXZinItOezNBTGwfCPt9uGiru5?=
 =?us-ascii?Q?OdrFPs4n0XZfWbE4+Gns5Xh0d72unas5zqNK1yI3xaOrR3yrXrkvRWcFw7FM?=
 =?us-ascii?Q?gIVJag3Nn4RWBnmGgJkuGVBsA4BPv04ednkgwdWGjwk4ngYsF8vHhtTeQ/qc?=
 =?us-ascii?Q?tz2pfgp6K2AdzwFXiN14lZj4oYb1WxmV78CQxxAIppVuj3yhTZ+483xpnz85?=
 =?us-ascii?Q?haYr5KDrOL+fxbp8Cswn6TN256oNi1DzK5//Kvd689GIlBwH8iqsCXDLOgIw?=
 =?us-ascii?Q?5aW62M1a2mnlP5nBRsWLX9234FR75kSLa4hBg0CmaQBmRUvlnbbysEFbTTn6?=
 =?us-ascii?Q?GSq765slwXW/IB6AgBk7/Z7120zBOowSHFY4AYwOaP1PJERQSvt8L8j/CQ2z?=
 =?us-ascii?Q?go7xxEQwSut9BTEjTnllt4B4s571vh6Q3kFhwlFPYkeNp7rKGOYswRkmbRR2?=
 =?us-ascii?Q?VjIDWl9EWEvwkKd4m6iSyBm73frMjZ562nrt5v7zVeHJ+hESliv4mnNfPGr5?=
 =?us-ascii?Q?tmMwj1DTpD36uNTASesG9XCoIOexTwdzdQr68Mkia/avGW2YJS6vMXAi9WdN?=
 =?us-ascii?Q?ud4iXoBrugMV0UWvI04ay34XPUbzMuS4CUR1IVtv4GcJ/CANNFe1+oqICi51?=
 =?us-ascii?Q?R2y+wGDdNo1k7QTXWt9XdkIl16hQSy90a8lsEIwCaVsup6+pOGKDbULaqwNq?=
 =?us-ascii?Q?nthnGmRU1NHe5RpaLuQcYAiL6AkHEJS9pUn+v08wAC5juMTps3xXcZlMgQ62?=
 =?us-ascii?Q?grUjhVbFt49oiIEYEqgq5X+G3Qm+E1A76xGZ6nOObK5vXU2Va9M/bQnXUY3+?=
 =?us-ascii?Q?4q3wBF6nVC5hWCumQRMHvOWoDYjau5Wl0xkdsdQyF9lx3CKEhrutXDWz5KV4?=
 =?us-ascii?Q?6IRd2J6C/IitBxkKZq8Qqlkme/kGXfCU3eHetpQe1P6jCtsuKe55y+1TAFEj?=
 =?us-ascii?Q?3TMKm3IvQah/0HVYhGAXoLh6CDR18ZqK49EjSdEps6jEHUNQcxvchrRixeyb?=
 =?us-ascii?Q?kvGucr4TL3iK2BRSIbKDDw9vzfaidkO3dSr6Lf+TNHvI0OCVOhH09JhDYhJb?=
 =?us-ascii?Q?Z4PcKkYqtTtay/zzRCdYvlXchzA8dTlnL4P/RlbY51GBqt6Xcd9vL/F8zH3F?=
 =?us-ascii?Q?CAE3yLqEUph6jZRtKGaiLwWiK74BDCujTFm4ICz1r/f/SkFMB15eCHbIg7G6?=
 =?us-ascii?Q?gGjXb5A15SScoKwagXNoOFWyvZeP+/84zqNvfAGcvN1wmzyuCpUE/r18iY88?=
 =?us-ascii?Q?kKHiIcRqnbEy4VflcAS2Nva08b2JpalAS7/uz/EUw3A+RVWD95tOrLEftWoO?=
 =?us-ascii?Q?A5triCGrc/jUwakRnz3HXFGHiHw3JgZtr0akyXaQz6hFcph1Ti8LA2vqHWW/?=
 =?us-ascii?Q?dsg+VdxoNbLxUXeaJou5+zje7gOPELDEFKM478FuDNI7Tu2ClwGkgxmfdZLr?=
 =?us-ascii?Q?wMPYyw5EPwntt0UGgSzxZW7jq7MLxEAjJKVNYltHs+TaY0yd5Oyj5KBibc/6?=
 =?us-ascii?Q?9s1A6Vl77NBBmYI74S8aQcgLZ0eatZoY0Q0ZElEziyeXhU2cjO8omMW4KVqc?=
 =?us-ascii?Q?3wZeAO4wifVtrj4D4Z8QXlMMzJmcq2nBfyJ0cT2c?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e5cbab-c919-4157-d501-08dcecf0ce6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 08:10:17.9031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rj6AWRBMXtbVvZGk4ebBwrC+0c8Iqb0rC5/z/XHNr+MBlFKiDrHbB9bxUsHl64Uom6saAELZ8Rl1PHKvuZQiag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7117
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Friday, October 11, 2024 7:39 PM
>=20
> On Fri, Oct 11, 2024 at 05:06:29AM +0000, Tian, Kevin wrote:
>=20
> > > It is a bug in the implementation in the intel driver.
> > >
> > > intel_iommu_domain_alloc_user() should always allocate a page table
> > > that works, if you are in a guest context it must allocate a first
> > > level/guest page table otherwise nested VFIO will be broken.
> >
> > I don't think it's a bug. If nested is broken then VMM can fall back
> > to the shadowing approach. If the VMM only supports nested
> > then the only way to guarantee it is to not advertise 2nd-level
> > capability on the vIOMMU.
>=20
> Right, which is the bug, the alloc function isn't checking the
> capabilities of the HW before going ahead to allocate a table format.
>=20
> So it can choose a table format the HW doesn't advertise support
> for. Whoops.
>=20

That's certainly a bug.

My comment was about " if you are in a guest context it must
allocate a first level/guest page table otherwise nested VFIO will
be broken ", which is a policy thing in supported caps.
