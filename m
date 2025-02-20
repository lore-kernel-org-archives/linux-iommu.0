Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFA81A7264
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040121; cv=fail; b=fnxe9nY9TI57JCTW4ug2gjMiG1qBzaYuMJ4yp2Kf6ODReC76u+lXcmAaKKcX9hLEFL6/GMA5HGKHPGSBo5v+CaaB9Kw2mG4zxby/dJEhb+V2orzCo7TH3xcUI3T4sTxF9bXRVAxc6JFPTBB0Kx/5ybeJOu0HUp+lmMVplbYmDZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040121; c=relaxed/simple;
	bh=bvJIi0tDoS56D0etlKA98y0S1y6I0fO8Rvz0yrZGKpE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FAktccfFit/Vzz+G3DNCkL3eYFXAIs9Z6PshCX5q+NzoCQyLhPNwlFHBhs+kHr7eKLji8vsNxIdRkE8UCmMZFycpm0LDCeJSq6FFocrPeb6FOx0TwA8jyA4gngeDbkwLfaCwbfwknJllWepSbUDhPVqEVcHGp8VdOsAE7weVNXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BjtqrlOS; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BjtqrlOS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740040119; x=1771576119;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bvJIi0tDoS56D0etlKA98y0S1y6I0fO8Rvz0yrZGKpE=;
  b=BjtqrlOSG5Xg69Y6BPczBWc3tjzMfk6VhHzRUtnhTB/9IKWC1UZi6yLz
   4y/Ra4dG3eZ99+9IkK6nsksJocyLAHpWPcf+U0Im7yep06lAKgNv+z7UB
   2Y6+wCLv/jptDst420tDNZzsYuisPOHASq5kOYndLuzP/wQ0Ssx2nNcy6
   AkKXNr1SVKBktOe7HNlWLp8VA6g3sU5J569on2P1GktZppM+ZCPb5SoYP
   eBi3iapoUXcaBgyNr5s3F4iatqPIzb6bTTb/9f8oiUsZumMqZt6YpbiEw
   T+jiIWx5TueF2xkI+oT98temumM1MCLxaCLjNuJ1t7TtLRiWPcV4dwlEt
   Q==;
X-CSE-ConnectionGUID: E13YlOHBSMiEPF9LF9mDuw==
X-CSE-MsgGUID: DLvLcgHURa2MAjLT1T+QPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44457309"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="44457309"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 00:28:38 -0800
X-CSE-ConnectionGUID: D+Y0CprJRZatHVj7E2zkjg==
X-CSE-MsgGUID: YP4Blqm1RIqJJ1kTKsfzeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="119952024"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2025 00:28:38 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Feb 2025 00:28:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 00:28:38 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 00:28:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRl5EQUqrKBJkcgMHBUfWMxTM0MchncO/SzunPpocETnZB4McjVzc2PVzhoHRjqp1f0iYLXORJSKRS5Fcn2/SYduPeaUkpcrTx04ane+1E65G+fZCrir0/jFOGl1H9tLxgyHLyNg9b00QTPW8vk2BW473+27sW3MdRArMvebcBhMonqwFFnFMPqdCbfignO2ATLKIh3XCDKAslAWdzEppDIWje71+ZCiAVIyfAOC6IOgPINbBWRLj47hg1n7oOnwsxZ7shFtKOasJHWyjDcca46J/OXB22sp8DLQWb0IqJZezs2LZy8bvvYR00mC5A97UJIYC7XngC/8kSflcvLpTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqsWJa4JNA1XOmCnWM9dNrVkZNZ/hmfu2IrLLlHT6V4=;
 b=veWQBuhPKRec7iZ9fkr+3nu7fvVcRwGDGK43LQMY+6w0VXEKp7z8KwdHIEb81Wt+2X8q1KM8bVrrXd3Tf6UV7g/7LjDogsu1iOflA7gpbXj2ywy1pYnIyaAVF+/YPaf3ctLY02K8h4qXHAMjj+96RYZxU3K2QXyQfQ8Eai+WI5hxtbhvGGpStPfg/BE8R9d6eBxakEhVlD0+KnjQ0YhpuNijqZcAuC/4mHg2mcEncMyd+11wSpXVJ1lCGikokOYTj+TEl1oz28dtKjeaHtywP/fUcs2lkzGWTZZO6KlIzzlm3pTMnVBJwFEnN+z0rDLPl+WJsLbhf5Nw1oZFdKyIAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 08:28:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.016; Thu, 20 Feb 2025
 08:28:36 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH 3/5] iommu: Store either domain or handle in
 group->pasid_array
Thread-Topic: [PATCH 3/5] iommu: Store either domain or handle in
 group->pasid_array
Thread-Index: AQHbfRQttFYattjKSUa6dqsT5v4GAbNO6baAgAD+13A=
Date: Thu, 20 Feb 2025 08:28:36 +0000
Message-ID: <BN9PR11MB5276B02B2B02E6861D7B34928CC42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-4-yi.l.liu@intel.com>
 <Z7YRy+mM54cg8CXV@Asurada-Nvidia>
In-Reply-To: <Z7YRy+mM54cg8CXV@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7802:EE_
x-ms-office365-filtering-correlation-id: 5fc5ceda-23ec-48db-c44a-08dd51889209
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?kEhzfGZEH+XXz1VeU6BIIR95fSQBF+L2UuHe17CyaKYVWND/pf/UEcksIYnH?=
 =?us-ascii?Q?yvA9CDRcTHPv19FpPImElaiCfAKg8Mogl8KJ0RThL3DneispLDJR+Bx2mJqP?=
 =?us-ascii?Q?IsRUHBr0Mu5+7AqTkKtxtBogrm8IvPjMuVefoz+rtN2lXRBqbTgIHshKMU++?=
 =?us-ascii?Q?bVL6yQ/DyZou3l28B01GeoUCXojzQ7iJMkChtWnnEyxOLwOY+PmipzyPvvcB?=
 =?us-ascii?Q?LHpdgIQQFIvqTn2Hcgu6sFmfWADmzQFVh5QETcbzSfG3+rJ9NK+fnjHxlXYg?=
 =?us-ascii?Q?+HpbD3qhVTykmbiHJq0wVhDrS2wN2Bff5kmDHijSq9dr8U6UOHOhNEJpFY4d?=
 =?us-ascii?Q?Jqfvvoz1D+1IplMRWdeEShS2T9/9hlpvSXcVgrTEtyp5E5AVTvWSeSJQRIqV?=
 =?us-ascii?Q?tMmIQ1D1wCzaI/mobrySdJ8UQgyvSjX0yl8BTD/RomB3BeiBrH939UVIU4XO?=
 =?us-ascii?Q?ptj7GiVBWD1Hb3NooD0AwALAQyoY1YGeIM8oSdJuVlw/noU/O2NafhNYRbGt?=
 =?us-ascii?Q?VIajT0F4KjpRhVfdGgj6xGXo6mysJJFowvI9rg1CuKUJzxBnaRxjee35VJXF?=
 =?us-ascii?Q?P0gmZXByXKQXxEbTKQyfoiob3OCzMHm9u2LMa5RLMuYLRN+M52qB2n4UuKiB?=
 =?us-ascii?Q?JjDrysN0iFRbOwi2jfxGD0ODG1Oerq5QI7VWCzpJ51mR4uvLmtQr8unOyQGd?=
 =?us-ascii?Q?5kr5HR4qG0Uu6SVweMQKWJyiUlnZsfbBUtKOvqcGySHxd7t25kbhaVffFHoQ?=
 =?us-ascii?Q?a+xrGl7bbiDoNXdXWdSDgB8EUPzG9DRReouYrL932FNTYzK+4qRXt30qgJ0t?=
 =?us-ascii?Q?NOQocygJmZ7imTpJooQpw2ZoI0SQoNKVOADePYu1iH4WYukGxJodDSya2piM?=
 =?us-ascii?Q?BtmNTvHhtj+Xc8XuPR8JQEHaC5VkADE0l/EnqR/9ibWQG2N1Act3r4yCLTSv?=
 =?us-ascii?Q?VXN9AqQv/X/j7JznPRA18nHqzmoTmLhzIulPVVZ85s7xjg/hgY9pGUpnFbXa?=
 =?us-ascii?Q?90Dxbkxqy9F6/1ZhHbs/GIoQb/aJ+ibMKLgCkRstCfaCwVmPOli7JYPIY77I?=
 =?us-ascii?Q?q/ZG0nkgETFXI5rnGYHPlr/h5AlrFYX83H68+hM/JcDJkY2DKvPbhUJ3SJyH?=
 =?us-ascii?Q?9C2u7wrHbh/x1iTpZfMeS3+wkthA/5vmF7CdIVjF9Y6JOyyOcXp9TckfOw8w?=
 =?us-ascii?Q?8TPqEJyIxaYJ045a8DYhZ10CFKxQ7XroDD0lL9Vk+Zm1EhP/G0qhgOwFV/nE?=
 =?us-ascii?Q?yvhY6g3YGeEITXxqU2chPJKrhwLhzNt1IYUktXlEocYvjxiY/lTw0ur5TS+x?=
 =?us-ascii?Q?cJFzKyiBbu2PV/ng0LeUpQvW36lu/d/MIhBywMOxqp1UorFyF/hAwKpOK7AY?=
 =?us-ascii?Q?xcE7icZN78wc4oFhYPyZaseDiitBKRINW9dO5tUlfK4syCqbjTizvJZwwv0J?=
 =?us-ascii?Q?QOUholF7Cxsb2zbreAOwAOdDv/Vdthx7?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8E8kX7cq90zXz5vXlbAs04fj1bDGi9D//oyCUu0lpNkS+5Nwl3eWBYjuGuM2?=
 =?us-ascii?Q?XsETucArFlRGUVAQPT7hGBHMmloN9hTB90f9H2w/WYvC9s86yzbPfoADp5fa?=
 =?us-ascii?Q?1wiINDpFArdTydKeV9tDO4ky54/8OEHlGZ7JsgJy573Vm7tO+f/qjDCyr1gD?=
 =?us-ascii?Q?/XpXYTdy/kX5RZ4fHmkbaVg0ugBZ4F3cihuY5rilrLBh+D0EbMZC9Fx8f9Gw?=
 =?us-ascii?Q?AjENDjhwBj7RaQgLIRqiBQgjgoNc1Ji1FTOZdLiFSb2GY039TosCQvqQXauI?=
 =?us-ascii?Q?X+KoHwnXtbU+iVetAxixx1Lpt01oalAQy/wxRPIUiFO6Um31VgrH8gse2kZl?=
 =?us-ascii?Q?ZejnP9txng5rDOlAdhB1pWQkciJMT5rMElCOKLAsP4SWk+roktbe12sk8aOz?=
 =?us-ascii?Q?bsa9E29KOQp5wrBJ6AzKamu4Rr16+2MGnjGwL9qCdZJMQVHC4fJvgQXdYIuH?=
 =?us-ascii?Q?9FOCqWRSf5rXB1tdobDmYcW5uXekmBg2rEGSkkvLpOBQqlezshtb+tCtfycH?=
 =?us-ascii?Q?TUl2moShOVv8jzyY9c3y7niXtZD1hGG8y+UiE1vX1xkKlRKKzHNxFEyD6ZOE?=
 =?us-ascii?Q?19/Zs+Pt42oBkB33Lo2seA6KdaAuxdv5XNpqPHRfTBwgnBr+yTX1TSDTzK5M?=
 =?us-ascii?Q?SDqW3fksvIyDKvI0uoli8Gbv5BajsStTbPMmlRoid9l+mn8cxrqXgsKCNSGb?=
 =?us-ascii?Q?7BSyXHhj6zGONKmftuW+JJCa7BdGwIlxYXgY50ZnWho2AfomkWBfGCyqoIlr?=
 =?us-ascii?Q?0YVm1yyO+i9bXIkP3NMKFeWsq63i1ikmpQ199b+T0vKtEtMoe0D8zX9q6D3N?=
 =?us-ascii?Q?MmZxjLeZUZipGDzTfDYvgb7WuWDd6wB9ROSBeYMBSDOFUv4r4nXQfcBuNBw4?=
 =?us-ascii?Q?cy0kBtuNnzwSCeJBk4ZUDQ36dHTk57Ro+up3BlheoYy2WaWsSOUIYtQBMP9M?=
 =?us-ascii?Q?xispH28QkZXUVnnaIRSCr3DFOdvnjkoLKDQXd5V15d9EfB71F9+J3YNjC9XI?=
 =?us-ascii?Q?/UInCMtcsrTHhZXADt+jtfXOuiWp95Dv+LE8k3F5hN94F60dn9AdeDNsvQoz?=
 =?us-ascii?Q?Qw/u0OwpF6HkKDCX6Mgt544A/79DlZK4eWUL+4APOYMTmZ6A69xI7gQGusIm?=
 =?us-ascii?Q?sMqlb6tydIbvOXFPs2QIJp8rnTZN93ByhSo35Ic9AvX8v4zLOTNfEaXu05Xu?=
 =?us-ascii?Q?S5MCIoHJ8yTMacqcD95ry4E6jl6A+wDOr5Oxjufn0jYfaAy5F5lkqItfd0hb?=
 =?us-ascii?Q?iDSMZc/FAu79YQsZn2NiB3d6y9NSgPTJOJQD9CSxm93poyJM7cI9tRCpo/8P?=
 =?us-ascii?Q?Rlh1d04WTtl+mPOsPgEzSHNSWUKUTn7R30jJglskzaviAJLFlE2+FBqAjrz9?=
 =?us-ascii?Q?/yId0Zfh3s7tP6msS5bbg5zqqvWcE8RotfH4zgp0odPvdY+joM5I3K78mvvg?=
 =?us-ascii?Q?WakIf0l/7LZNpP7uanwlSEFNxDpzNtbbnANYMXMiXSyAbPPT4F/GLo2apgBE?=
 =?us-ascii?Q?+0ABcmQskF/6IGIPlqLsSuPItE6Sl1EY4LTag4XjV8zuyuHCOdIjldnvnFhX?=
 =?us-ascii?Q?U5qWetoOEnrUMtZu9Jx5jc/wfxmlf4N3ahwa/PNz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc5ceda-23ec-48db-c44a-08dd51889209
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 08:28:36.3568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EjhPbxzTUlgcxbWFWokliKHdaUbg2CRoMU9pdA9YYFsbKB/X/G7IJRsIIK39cSWnf+s6RckZ4BcBnniazIDJvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, February 20, 2025 1:16 AM
>=20
> On Tue, Feb 11, 2025 at 10:05:38PM -0800, Yi Liu wrote:
> > iommu_attach_device_pasid() only stores handle to group->pasid_array
> > when there is a valid handle input. However, it makes the
> > iommu_attach_device_pasid() unable to detect if the pasid has been
> > attached or not previously.
> >
> > To be complete, let the iommu_attach_device_pasid() store the domain
> > to group->pasid_array if no valid handle. The other users of the
> > group->pasid_array should be updated to be consistent. e.g. the
> > iommu_attach_group_handle() and iommu_replace_group_handle().
> >
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>=20
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>=20
> A nit:
>=20
> > @@ -3483,15 +3501,17 @@ int iommu_attach_group_handle(struct
> iommu_domain *domain,
> >  			      struct iommu_group *group,
> >  			      struct iommu_attach_handle *handle)
> >  {
> > +	void *pasid_entry;
> >  	int ret;
> >
> >  	if (!handle)
> >  		return -EINVAL;
> >
> > -	handle->domain =3D domain;
> > +	pasid_entry =3D iommu_make_pasid_entry(domain, handle);
> >
> >  	mutex_lock(&group->mutex);
> > -	ret =3D xa_insert(&group->pasid_array, IOMMU_NO_PASID, handle,
> GFP_KERNEL);
> > +	ret =3D xa_insert(&group->pasid_array,
> > +			IOMMU_NO_PASID, pasid_entry, GFP_KERNEL);
> [..]
> > @@ -3561,7 +3581,8 @@ int iommu_replace_group_handle(struct
> iommu_group *group,
> >  	if (ret)
> >  		goto err_release;
> >
> > -	curr =3D xa_store(&group->pasid_array, IOMMU_NO_PASID, handle,
> GFP_KERNEL);
> > +	curr =3D xa_store(&group->pasid_array,
> > +			IOMMU_NO_PASID, pasid_entry, GFP_KERNEL);
>=20
> It's actually an entry for the group->pasid_array.
>=20
> So, perhaps:
>  - s/iommu_make_pasid_entry/iommu_make_pasid_array_entry/
>  - s/pasid_entry/entry/
>=20
> This feels a bit clearer and can avoid the two line breaks above.
>=20

or iommu_tag_pasid_pointer()
