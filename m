Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB3425C821
	for <iommu@lists.linux.dev>; Fri, 12 Sep 2025 08:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757664304; cv=fail; b=WvnOcrqlO9nXhPsJY6KI4h6pgO1XNgHOXsT134jR0cw2XBZeVp8ofoNsLtn6CVpqvWCqunFvE8tEtZjknjIobOSogjNKZAXLsMP4xfxna5vbuLHCJB7qHJqXi8eamn6wF3RIZxIUCFhSGWNj0IioPdjOsGiqFQE8Cr+HH/DYXaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757664304; c=relaxed/simple;
	bh=BRB1yOUnqzPMDAjScIe7D5odTM1V+E0tnMaQ163tTlg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GB6gETCwMG9u/5Rojf5K7hOHf+Ht3WerthbFawIZAiHXKHgOuVqKmtYA9EZIH5+T0qtKrG+ymVowo35FE0PKJ2XGoEnQq3tbLXo1LaWELq3VzRl63CFT1+I/a8LzgQpggmPmGpOkoepkqs4iFe74idwoymQPthLU0VThid+CTkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PuacFyTT; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PuacFyTT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757664302; x=1789200302;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BRB1yOUnqzPMDAjScIe7D5odTM1V+E0tnMaQ163tTlg=;
  b=PuacFyTTM3OcwdmpEN+qgdoBSs+b0A0wc/0FS6Eo0fogpb+FWenwibIF
   npGcaLtpm3GpXQa+mHFbPDxZCf8YxlmJCDZShj4ftOu+xPmKwaLwoLAo7
   mJuHcYbthyQMEZGV839walDthFs5vA/IaLHLEXfmoWqyRYQJzEP+GzHaM
   U9yXKNg0/8PFTL+cLtRS2rPj3FmWFs5LeuX00F/T6wy0uKst8/NWwT1aL
   vvQejGay10IoJZa9tQCk4lL5DoIIxHtsGakRiCOeem40ieKl0EFP8PKYH
   GTNGCm1WGpPvax/FbKWjg59tOV/mj553CP2nDeKopjbVcP/dQzv22omgB
   Q==;
X-CSE-ConnectionGUID: dBKmY34XTBa1SR9M0WgIPQ==
X-CSE-MsgGUID: o9xeVLS5T/C/N6y1+MlYSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="60081329"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="60081329"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 01:05:02 -0700
X-CSE-ConnectionGUID: b9i2zNESQWKrBlUU+aUiAg==
X-CSE-MsgGUID: 5t94B5ynTxefbdAv2sNOJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="177943598"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 01:04:59 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 01:05:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 01:05:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.75)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 01:05:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWRkGpJffz7hFmt+oRyo1Z7MVzdazwKqzQNGAnTZv5gQp3GofSYMh4amETd2NmSvHyagpS3xbQTzTllZhrWEUcwlkuCZuz4hfas+OUAlyKenrRgqUZyN7hjjyEcAu72KZfTl70laGbIBn1TPUisvE7Wc1vqid5UTWFvUe3JA42J8ePMSk5xBKGJTS3gEZ5be6C3TDhuAOSyZ/S/o5nnjOxelfGbZwqausrs3UP+T0kTWD1yCTwF5LDE+RAjUgJDJjO6oUIOVl5/mOnL3WWjxcBZBmPc/AYxPr3ZikHFSgjSUV1eB9oVJFjWo/HydQO06EdGzTmOEH3P7nK1O/O1NKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRB1yOUnqzPMDAjScIe7D5odTM1V+E0tnMaQ163tTlg=;
 b=ny6sq45043YjcpLueaF51HZtHrhCpwcEfMfbbDVCXzTJsJ2ArbJtUqZYzWuWompKyWgNE9DUGU11OEvuWs+a7TSMNgFr2mCRP6mdniUM87ffwkn7O4ixjOQFefD5Ohy+ME1JjQ7GeBBj2M5I7NBSetXn/nAEuQmtWW0TBhnYd4cAcHoOltMwVPb9d1k2/OG+vWF7g4L4KMlT9uqmSNKKA+4FJeNHxzWJFHrTM6P0UXHzRU/3QAWQw779zjhCIX5ZB3Cxw3XkhiWSeQw2642nmer2ObfYY82HKuZRPbAeQpvTvw252MGaFNPF2NoZGq5iRLqta9GMLT3d/MAmaNpYXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by MW4PR11MB8268.namprd11.prod.outlook.com (2603:10b6:303:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 08:04:57 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 08:04:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Jann Horn <jannh@google.com>, Vasant Hegde
	<vasant.hegde@amd.com>, "Hansen, Dave" <dave.hansen@intel.com>, "Alistair
 Popple" <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Andy Lutomirski <luto@kernel.org>, "Lai, Yi1"
	<yi1.lai@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "security@kernel.org"
	<security@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: RE: [PATCH v4 4/8] mm: Introduce pure page table freeing function
Thread-Topic: [PATCH v4 4/8] mm: Introduce pure page table freeing function
Thread-Index: AQHcHiluyltNj4vuKEahrhRhkIxffrSPO0bQ
Date: Fri, 12 Sep 2025 08:04:57 +0000
Message-ID: <BL1PR11MB52711F2AB685638DE999369D8C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
 <20250905055103.3821518-5-baolu.lu@linux.intel.com>
In-Reply-To: <20250905055103.3821518-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|MW4PR11MB8268:EE_
x-ms-office365-filtering-correlation-id: 2684a9d2-2ccc-43b3-9e3c-08ddf1d310be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?enZSsT9BdytXyhRObERSE2BmDr61T+vNaGAOcdtiODuMd0BoLDHA/CWZDG+C?=
 =?us-ascii?Q?2x21MVOnjAox8ZzW856cCLJdjLl6YXijhqrEr27tMXuJoQ4AW65/whxCaF+t?=
 =?us-ascii?Q?Ed7SiSH++pnPB5ahfQPt1oqf8p8TQPKebJzyDf+iITz2I1Db+lxLUoZzWKtz?=
 =?us-ascii?Q?aUacFaVHfPvTVh9wWS+mrqiBxufTAg8KD8Xp3qgqSzGLZkfxxPD2jDykW41E?=
 =?us-ascii?Q?45DkFap5ZcPQEXUA9h631BCkkoAh4cEyY2GP/VedJwfcP5i17Vuiv42GQq2c?=
 =?us-ascii?Q?CvwuOYnGy8S2LiJr5EN7Zfh9xvfLYwkXmafuOkOjGPtecyAvstsp8jQOnUs6?=
 =?us-ascii?Q?ppgu9WO4sWQFLQwL2ulMh++S4/WgDSCSLl9hZ3+cnorStwgj5E9ue/duzkFJ?=
 =?us-ascii?Q?1Mcgr2fafL1rHQ9d6UsunPLQgjJs0G57USZ8T9waXzEvp90hqxNCD6mdsFpf?=
 =?us-ascii?Q?HCYpmmOeTvBH1qXlIFA8D/4kdOit0BjIa49iAJ4NMWl+9AN41o/uXLartSmp?=
 =?us-ascii?Q?xiW9QTcATfEFiopZ80qMF5zzzafrD3hJg16y40gKKrHJZlZyYzUiVee9jk2U?=
 =?us-ascii?Q?2dtfCuxVIvz5EWf04/Dr4vEzBU6jV7VFFK2rvJFBk37ql4tkJiKr4fzb/jNi?=
 =?us-ascii?Q?rQ37kps+WSCMSTHRs7yx7ENjH/5JZSBdSZbKzM7ZzEVCFHWTCEhZtN72qroV?=
 =?us-ascii?Q?kjWel23Dc/pKYmp4BlBTtGevK7DfbKRalncbP+TTSYzirqX1DwCGLbOQGbDE?=
 =?us-ascii?Q?Itbe1T2/p7Z4803kBxYhkh+ZQw6QLOxBaqEPPlXYom4HSrWhKQMCHmkiD3vz?=
 =?us-ascii?Q?kfnhETeBRSP6hS/l15CWC3UxGha8JynvJZUS4lR4VNiksY0qx2trX9+3M7bb?=
 =?us-ascii?Q?3FjML0DSYe/eFDWxZH14v+uUnyb4M5DqoYuWu5vGzUawU+74Pelwwqe1GqiO?=
 =?us-ascii?Q?wsOSS042NUb7cJWEbu43VT4Xy1TY4MwLjRmbhd3e0sSGcJ2rJ2kBgikB7kQ4?=
 =?us-ascii?Q?HFkCZ+LYYNbHyacC5f0SHLuRwjOkD5QQu6bU/4eOiuLDL+TRTp63Zf9uIh05?=
 =?us-ascii?Q?1FLi9gAmFbonRPl+CGP5wVPWYIaDAMzMP8JZOXyK7KJS6LO8xPzi/K1iBmpp?=
 =?us-ascii?Q?hosQiECwYxsb5FrClS0hac+zNkyMR6Nif0WOjG+/JVPgucP3+xd8rpxerH3/?=
 =?us-ascii?Q?mi2YkYlm4Y9aQjAOapSW0H1QiPbIMqn+Z//IaUKPYsoi8cwxU2ThjUGLUF7/?=
 =?us-ascii?Q?JGXx0ORFq87Sw4Sfgm2zK2AbiXZUBocJgjRx+HvQ7Torbo9Nrb6KpjFEViB7?=
 =?us-ascii?Q?74a0uniDOLTBoTwBfjBxf5QAwlIRb2JkzlBmvGIzTye7aSb+MsZtu9kgNkf2?=
 =?us-ascii?Q?pKfH6NhQB7EVtGVqAL4cAeoqNXQjW9bmdqAyXi/JExJ0Vv+odaL8RdCRBzir?=
 =?us-ascii?Q?wj3uGpW+gCWDEsrkZa1cVcqitX+PnKdeEXBUNM6MpglSTMlpMjR22NA9YwFj?=
 =?us-ascii?Q?UmUIvKrms032g34=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/T2+N+uwv6CJXlNYlMWjUtSbJ+iwOhsV3YmwFXXTOo3j31rj7ewbWPo4usET?=
 =?us-ascii?Q?Rf5dJDIyDWmiqCWBB/s440Hvik55hJGXx8AuH3GVkDPdkXWs0vmVRZG4fNEM?=
 =?us-ascii?Q?dndaf6zmshGnosudJbCRzZQA4fB7HGN9rFXFmkdMN8wIRZXnev5Ti+wYeBkY?=
 =?us-ascii?Q?tBUYMIHiwVJj9v5Fbj/r19jFEFyT09jw1jAcUIaVOylqUgMSDmnBIBVcLbi/?=
 =?us-ascii?Q?fmBZTEs1MFNP/5jqYpaHLREZrQi4dMjRTtlHUKuwIFqHNhH6855XW88AZyvu?=
 =?us-ascii?Q?yHgjLPGHZV7EYh6k8HhoPXRL0RBvmNQ6jAZkjQMKJCfjOKuj3WOnGtNgz6VU?=
 =?us-ascii?Q?bvOYNBm6z6eE+PL+jHSGisDC+kb59O78XuDfnziL7nXPiaK6pqbSET4o342Q?=
 =?us-ascii?Q?N6ORYrNKAHXqR1pltzefUWHXnPIjLpSjH4CalhoHfnZ40jIFlIqkjcMtKIh6?=
 =?us-ascii?Q?w7+UrxIGgyOIfQh+9N6taBzxi3lnpILKxj/1kVjp0D9251tsjTQ8DyEVabRm?=
 =?us-ascii?Q?4ZeFheF5SrXmxwL9a8vIafIVlI+KVf4B2xL6+zZE8zFho9leGRlWNwKOlrXw?=
 =?us-ascii?Q?qQdVo1t4RuygcqJjCkZ7Yi0kVFx/wZRPFj808xJOELqoxr2PR0e+NFNNNPgQ?=
 =?us-ascii?Q?gmgvF0+myVQuMlfpHQmV1/cg1Dajt/vjoHhtd7uMHMYTabY9o2ED+r+kcWEv?=
 =?us-ascii?Q?Bbm9s31Q2JpnrMu31xjkN4rl717RF7j37Jm4LZeNfJcm3m5Vgq3BYI5wLUqd?=
 =?us-ascii?Q?9RvlVOSWJPGeVZH23LQcLRfFvyn41j5g0V/T144ufR1YtupM75NBvg2KDz4G?=
 =?us-ascii?Q?/rFgH7B5Tz177jqhwVPIn/i/k6NNe1YAKSrKdvRUiOvlaOi/VBM33M72hdJ+?=
 =?us-ascii?Q?ABsHw1aFYnOtoiND/c64wumaSwhiHri5nQreD81E1E5LQ/6yIyvymcw6GkHK?=
 =?us-ascii?Q?VL3fCE1qUOOx8z7Pho4Bu0GxX24leXF53eA0bSn//7Mic7go7NxBUgmvCDx0?=
 =?us-ascii?Q?6xm9BX6rQPYsmM8xEW0rLZFKZmURZYJr35aF6kuM07uSj9TmQY0ZBWlNLUGG?=
 =?us-ascii?Q?+c/0Cz1maxIkJg1wqnm8Md96Y0TV4ArG9KIv11Sm6nbmYkzERq8FanlgTNLN?=
 =?us-ascii?Q?Bd99UkbbnhyWVsEFpsEnR77xme6qBH37us3Uu7acrqAPSlOTnEqNlmUfNx3h?=
 =?us-ascii?Q?y6aH+Q1RztuMobbDzHsUEKINKsYUPnG4uKnBGcbO3ftH++rcfCL+zm9YZIi+?=
 =?us-ascii?Q?Am/SyClkJT7YkNcdzJNC3dysjwWFUbMhtOGEo+EMcAIi/Es/HylB0BvzYgWu?=
 =?us-ascii?Q?F6Pd/fib40YCNVahYH9QXMqKQZwe1CdEaAh/ILAbkBv4rFQcu8WL/nafOuT5?=
 =?us-ascii?Q?JnPSqieHr8R8mX8AsFb5R35HJRu5dEq1Lhwp6VDvhhLojvfxFYm3KsSNskw9?=
 =?us-ascii?Q?iixqKt4F/kgQxJQBrFckvmIhbFJYK2lHH1fDozD+bOork5LdJO/z+87j2eLZ?=
 =?us-ascii?Q?rPIambqRijdcygVskHFSI3zdeJ4X+3oB7Hn7VWa23obt5/wib4zkWhwFNOon?=
 =?us-ascii?Q?HM9oLL066VIPL4fpt9s38o4cF1zmsMyfLsAbB3NG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2684a9d2-2ccc-43b3-9e3c-08ddf1d310be
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 08:04:57.7455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e4dBtLuiDoGmHoY2o3y6ydFlR6GrJ1GTNv7YenIovDPItsdpCn8MtDGTGF5hcltflQZWo69kBhoiyW9oYfckfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8268
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, September 5, 2025 1:51 PM
>=20
> From: Dave Hansen <dave.hansen@linux.intel.com>
>=20
> The pages used for ptdescs are currently freed back to the allocator
> in a single location. They will shortly be freed from a second
> location.
>=20
> Create a simple helper that just frees them back to the allocator.
>=20
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
