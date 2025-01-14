Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B3E2500B0
	for <iommu@lists.linux.dev>; Tue, 14 Jan 2025 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736842277; cv=fail; b=QkxhCquyoHDkdCpGnSyMZHvzgmyMBUzMsdC0MdeMoXH6YFCsUCc96R2YxkraLmILWXXINgmDHi2xhND0G2hz55U9oAYGPLJWLlrzMeMRetYC5nCIuX4XvTYYV19grEyl3G+hsT8KR01m4RHQnSiaGvyrIaq1O3j1OSAFZtNLrRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736842277; c=relaxed/simple;
	bh=r2YzDarCusBY/yZlvtqL7pJC4jMv90BTSkV569pAfsA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GCrX/Gm1OX1Pcwz9McS4aqIrn7xc5ImX3GHIr5LF4yRyJkdj3codM5c9zYQzlYLuXUHVEsTB7QjTMaYRQsY7i9boAml1c9o6DT6hLtUu9mSeRq/aOKRHF9wkmul9sx1C82RBsuodn0qjBCdM3oJBpumGli0uF5IsXurTcSOe/QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KKk/njMI; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KKk/njMI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736842276; x=1768378276;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r2YzDarCusBY/yZlvtqL7pJC4jMv90BTSkV569pAfsA=;
  b=KKk/njMIdpLPTVuqoNNQ4nM/KIvOEnZWJpWlNZpEbJguPp+7iXIHBfTl
   7SW4obc+01fiC8etvi/8uEUreuws4R7EyZn4nb/10aYESmQRC0EsM3DeC
   /Ix1CjqD7lBlBJBMBOKtiXYoytIS2yVgGx1RLKqV10K1TsdA2F9QT0KPh
   d9xOXvnHpO5F/L6oAzEw7zImiGoCvhH3F/CNRfP1q20dROxM+tRkT9NAV
   9E038CwTeltYRIJZGK6tep8scGOyGDlKlEHqR715ewMLb8y+NvV4pDpFH
   xQNgNWOPmal42lKwsUJGRRmr4R79cu+jPdINOs898AnIwea3rZ7SaueZC
   w==;
X-CSE-ConnectionGUID: BLRGCfHISkmSdeBgPnR2ug==
X-CSE-MsgGUID: YYREnR11T3Gf7Peb8LVC4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="36820348"
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="36820348"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 00:11:16 -0800
X-CSE-ConnectionGUID: Fp5c82axRM2vTaMQ/hCsTw==
X-CSE-MsgGUID: 0rGGbnDZQ5+QjXhD70bzVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="104681032"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 00:11:00 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 00:10:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 00:10:59 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 00:10:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueadPPWJChSsKKdXjqIZWdnu893QHgiOJ/YJj7mjCy+36b8uG9ZdprBvDlqDfxqR8k22cubOpdA00WAmSNbYJysbSOVoPacmfFZ6Zr8Wt1khFbv3a3cy06RxomnEDDGb/94mZdpxk3iEL5Vfu/fVi19z6cGp3M4YaGkCLdlF3sQIYhOTYClnzRsI+OHWcjgcqdsHMjBaAtRQWZbwgTaQLl8JYW9XmAZynAoiIIUX/WERx0u8Mdv8lyWAtdj0p82KhOY+4wzVnQ9j7W407Oa75VmjIu46uqcJSDERVeou/J7ksh1HErUWpuageAOMwhsY+8n3RM3NZglUbrPD4WCG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k34H0ZGUSTAggP0mTl8C5SgTJCounmIeNzSqjQL7/tQ=;
 b=tDUcc3ULPAidYpjrG928Me2qTVjQAmS+SF9PhzWo8lNOyVehiScNpTvv3aoDthX8zyxXzaz7s26MBrHdDKqvz1crhET82iUm0MUAUR8BHUNcPvbgM5d7ki4qTIur8ycSgMuyufX4OEYkxIPp48YvobcRPQN8OM86sWjz+/VHQcHWMYizuTtDpTRhyNKFu9h8RDxf7jeKEebsJu+2hBNItla5+AJ30MNgIm9Fbq1Jxd9aU7NZiJyVzvj7VqE2U9unT+lUlDn9kwMq1P81ShSMzd4mIAuscTP2xzCCOwkcYzBtuiPRINLj5DBtWZz/KuTBougpxeMO1w73VMdJPF34XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 08:10:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 08:10:42 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v6 01/14] iommu: Introduce a replace API for device pasid
Thread-Topic: [PATCH v6 01/14] iommu: Introduce a replace API for device pasid
Thread-Index: AQHbUhnUNnXzHh2m/02CvPrIPwhbUrMVTUYAgADFh2A=
Date: Tue, 14 Jan 2025 08:10:41 +0000
Message-ID: <BN9PR11MB5276A7F34F2B4206AF4233228C182@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-2-yi.l.liu@intel.com>
 <20250113202134.GX5556@nvidia.com>
In-Reply-To: <20250113202134.GX5556@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB6397:EE_
x-ms-office365-filtering-correlation-id: 8bc2557d-e261-4e5d-5177-08dd3472f069
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?PrmduawO5qhICm9bGV7f/hRfM+Llk+iJyASn0Fbldp6oR0sttJYXAtDNGb8N?=
 =?us-ascii?Q?9AWIdJQ1bpo2BUNC2GSXQF7eZkiV4D9vl0Y92lQtz/57wxowj94p5h/J9vCS?=
 =?us-ascii?Q?2/tI4OY0rwbaENXG2Jo8Q+g4YwOSS1LyI1emjJHk9lp7FtYT/GY/jCZYYSyJ?=
 =?us-ascii?Q?GeCoC2nu/mKwlWhnCqbgTPETYfq01HdHMBQddTPSLIp+8j+5q20LMeTSySD0?=
 =?us-ascii?Q?Fn1uDhgTr986CYZsc9Dcps/GAb9M6GNWuicu2rFTosuT3W7VhvowM8D1TUcR?=
 =?us-ascii?Q?nMIkZCgE9xotYpH1XmGf3JAlm7GNw0OEQLsnF7HjIMbF8RCxd2NGLoeD0FtW?=
 =?us-ascii?Q?M7dsURC4tygfU2QfvlIYz0TR2jI6bC8KwQSkJVAQm2OrQVIH47FBFkKKiVjD?=
 =?us-ascii?Q?vL8ut0gAIgIY/sbO9oNCxOTaLrS/cLNfcCNw4Y0tMqJzaWFmLYIV0vosPlBk?=
 =?us-ascii?Q?5AJ2q1icZOaPyM02YqVmwIzJLMYdFIdS/iSTyrOMsfqebANa3WnlF/zLRPt8?=
 =?us-ascii?Q?fDHxvH+ie68ya0egHCeCcxwcdVMS/OvOWvQfL4q9ymQLEyfxbDAJu3ynR4wi?=
 =?us-ascii?Q?n4gzwzIJsi+pwTF1h9/3DeASu7YzO6D0LCVG/s7EpLfZmCkYyxWvT1w4khR7?=
 =?us-ascii?Q?MHE0T7mLlkr/+ZeCrWtRFEq4PxFjXrKSYY59Tz3VR6qXiWOrlpwOOkpXkQH3?=
 =?us-ascii?Q?Pdx3amP6G0XtYU3nBLkWdj/RB1tyQmJXFPZph/KI4sQmgZjoeKsWBGCoPlVU?=
 =?us-ascii?Q?lg8ZnuwnfpFwYSZMdWVv2pwbJ+mhhXlt1GT2XPG8vZAs8cuhtHt4ZRDosYy3?=
 =?us-ascii?Q?cUZbhQhDo/FDXCmTcs+UOCo5mmgQCoCJeOpcFA1cYESN589+7nLhdZ794e4Z?=
 =?us-ascii?Q?6Vq5XhNUEEphGP44Ui1K0NAZPK2ezHNfh7zemvv1bcUiqnwEtPcXMolAna4z?=
 =?us-ascii?Q?hGQNvS+RqiWWnobGT3hzbAhH9+q1/SfHUyC8p1GWKqlFQWUKkPAGVShbyvgz?=
 =?us-ascii?Q?cJHlK0t2ze5j+TuDayykJkCAiWy8kQo76N2G7QzwTj1qJ6VxLiqKNw03OgtQ?=
 =?us-ascii?Q?n3BBYGx25EszHPQmR7nS/g0h7oYrxMJbWmGAXcUZTLZg0c9zD2yHOtVJbmXY?=
 =?us-ascii?Q?NJgKaOCyxJZAYDrOgn8eDs40xexWYUTuLtAJ5orttvlgvj1yoOPwPyZfpYXD?=
 =?us-ascii?Q?UpnfgqTxNLuDh5n2W0mvixLCQ+jUeD2XncmIEqBuBxlomxV/SAs2KlD/rDxX?=
 =?us-ascii?Q?azTsIga6Zi7ZD7sPY3yk8NhQPX4ner/GmJXA7L4mIxN6tAgCmJw1ZVOMyXME?=
 =?us-ascii?Q?/gbEROVShx3k4jj7AXj61bbvqxdpbCQd+18PGEskxi+bRuS8Esnn/v2BiSq1?=
 =?us-ascii?Q?FZQQwcehvEto+HX/8lWqe79jFBzvxk/yYLzWReKAAGnbVG6erqdU/k2dX7kD?=
 =?us-ascii?Q?cQFQs5aOi0eeDYBA2Wd9dY49pVZ0LufC?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PDP+kLWkFATmsQX4Cc0MwGb+kTfBx5KrkseT3FhGFmqbBcSpWU/vPjeLWddj?=
 =?us-ascii?Q?qhCxPFSxy+TnL7GZxabbi2GggKWZipn0Jx8Wceq8uu8+sijrgHNNKEcfViyi?=
 =?us-ascii?Q?hWgD9CYQpDh31CARzbrnRu9bCF7Pajs/gBZJ8f1Nch7tlEXrFDbHhsHRS15P?=
 =?us-ascii?Q?M4PcLdMV6gdFRWeJN4meZWBW6S88zlLvR717PPYeIsfsSvIu7JSOLI2lK0eD?=
 =?us-ascii?Q?aF3ogusqVcVapYh2iQKBcTjLKdqf4WbPPTMF8oVlNRNYn3ZI4sv8v3uFcyil?=
 =?us-ascii?Q?S9PRdwfk8amL6SL2VZGbb2/o/hXtYRLm3pYI/jMg/13VM6FULRA+W+zTFSPX?=
 =?us-ascii?Q?agBpMb3PT8JibRnMJfLWNgIXH8Oli/GoRcIy6lN4/cXDc4FD/FeX0IiH+af2?=
 =?us-ascii?Q?uuuV4g9k7qbycYYC+RZ06SmTz5c5513JlmD5zrIppOICgsQngsDB21V7FzCh?=
 =?us-ascii?Q?9FsvnL6e1PKr6Pzne7iZuWkDRIjHsoQzPdnv2QReoxqzUnWReYUce0IWnCAe?=
 =?us-ascii?Q?M+t/7QBERR5zloRI3+7J9QWgf5ODgARFKjMnnRmy+AbEkSC1D61nCWl9EZQN?=
 =?us-ascii?Q?9UDoBy61ik2xQXxctD7/4AA2KWvhUaZQQFWC4zlfEaHYkg135H20NzyYTizI?=
 =?us-ascii?Q?7+7QE4QLaCHF+fhrVKqhad6oNz7DWXGehj/1ImeQylI1QTsjhFCEaIKT2BYn?=
 =?us-ascii?Q?LTshKRxcicf8Ciz4lORis8UfcTdGX8bO8j2itS8BACQFMAEGVZF7RfE7GAmW?=
 =?us-ascii?Q?UfGIZd+pF7zM8gn42zvxUX9nFvALmMk5EUgx9PSbu9RflbcwdcwlPJjYoc3S?=
 =?us-ascii?Q?PHGOGlz1M3YGITY1dYjF0UVZruBwxuRKL8XsvS5PN+EDJQukXQ1L/U66CZZI?=
 =?us-ascii?Q?4IC/AeEjN9VF/k0OE9KXM3qf4ytfeNeFtDAWMcPQr/c9HXbPL68xaYpeZJFh?=
 =?us-ascii?Q?Tw8mnukoTdXP2wtzOKFdOwyYbqNoiKH6cCPLPzfe63dIQenmjtfNhvOKAA7S?=
 =?us-ascii?Q?oXlgYWBSx3l60kEADIpLUOsf+HmudTVbW+D9kx+IDdF/P0Vpmpgv2HbLh26w?=
 =?us-ascii?Q?eponE3EXADW4eL/YP4kDK6hQxTKF6SXnMsY+E71abao5PB6BR+Yn7CrQ/LoY?=
 =?us-ascii?Q?BlE+z4u4Z+TDOVz7TUOSjAznD2j56ZRjB0Oe0r3MN1L7JCpKU4CMk9DGXzl8?=
 =?us-ascii?Q?HbuMFu4smQ/0SM53Aum3oYcCYj/nKkK3SY+vjISCAB+0n0l/yQ7SrSFAqfli?=
 =?us-ascii?Q?BTZ/4Dgx16vBNwSarGud5WhSo5T7UW6+LaY9ITEE7gJfT2v7tN4BuGXYyCK4?=
 =?us-ascii?Q?CXkgNmFId50OLTHhT9vs19sngBHa6EjajOj/jWhkkS5AZyKxq+Surq03YJ+I?=
 =?us-ascii?Q?skui9aEHS2YKsLcDFCDnYMsfg7lLeFPEmqE7JP1comhR5LUz+MYB76L2QRvM?=
 =?us-ascii?Q?f7cvec0MgiEKBUb0e2pRcKeLZQ5Ob3fzlvpZkfRQBOKtH5Rqs3QzdX9EVHHe?=
 =?us-ascii?Q?ynffq0OXZ3O0nce+BTzsSCbnS4/gmGj9VFHrUZw8LbM+iVKk9sfw5C2tnFRG?=
 =?us-ascii?Q?q/Q/FgonAhwfH14lVGdBLCWCEwXnsUiLqsz0Uf2Z?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc2557d-e261-4e5d-5177-08dd3472f069
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 08:10:42.0228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Igwe+GrKDStL9OagyYdNhCvTGaWq1At44LoFAHV0XwqsQUdHO2S1E9h0MAVcAWb0WmXU7Zaz1zMl6i9qWS00aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6397
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, January 14, 2025 4:22 AM
>=20
> On Thu, Dec 19, 2024 at 05:27:33AM -0800, Yi Liu wrote:
> > +	mutex_lock(&group->mutex);
> > +	/*
> > +	 * The iommu_attach_handle of the pasid becomes inconsistent with
> the
> > +	 * actual handle per the below operation. The concurrent PRI path
> will
> > +	 * deliver the PRQs per the new handle, this does not have a
> functional
> > +	 * impact. The PRI path would eventually become consistent when
> the
> > +	 * replacement is done.
> > +	 */
> > +	curr =3D (struct iommu_attach_handle *)xa_store(&group->pasid_array,
> > +						      pasid, handle,
> > +						      GFP_KERNEL);
>=20
> The cast is not necessary..
>=20
> > +
> > +	ret =3D __iommu_set_group_pasid(domain, group, pasid, curr-
> >domain);
> > +	if (ret)
> > +		WARN_ON(handle !=3D xa_store(&group->pasid_array, pasid,
> > +					   curr, GFP_KERNEL));
>=20
> I wonder about the ordering here, is it OK to have PRIs being
> delivered to a domain that failed to attach? What cleans up that race
> condition with domain free?
>=20
> Should we replace the domain then set the xarray? (and same ordering
> question for normal attach)
>=20

That makes sense to me.

But I don't think there is a problem with attach. xa_insert() will
return error if an entry already exists. So there won't be any
PRI being delivered at __iommu_set_group_pasid(), no matter
it succeeds or not.
