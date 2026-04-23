Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275C82E7F2C
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776929215; cv=fail; b=Fv490zYBHtmDwOEb3cJCJ3J1rUGynxdxkHyac9A6i+7vWN3zT2jDQ+aRfbRpxDhhpuXa1UoIdCXZd59YhUcjpRCsFAFIeGj2PiKpy1YundWUFDkEmSdAJZYxJdGCZWnWEPHW/LoZUsfSdtFMDwOn8W5pzwgPNI+mE/HlrceyAtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776929215; c=relaxed/simple;
	bh=49/a37VFHYgG4E1RvnqZptv/uT8GxGw3jsmEpj2ho2U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lmzanOlHtDa60FcOT3k0ajStOJiyn5mecMM9j0f/FRuNHa74qHk9AEAil9ofROoDgHuab/2/Xzx8gD3NIOGEy/2VnSS8LVza6GzZJrdiYtpsHYgWclefRMsdDp4xtJMn1rnG85nZgSYwJmIi6D6fjMPgzI5OYSG6S1MgMi+xzeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UBZQ0xpN; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UBZQ0xpN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776929213; x=1808465213;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=49/a37VFHYgG4E1RvnqZptv/uT8GxGw3jsmEpj2ho2U=;
  b=UBZQ0xpNFnFi5a67FdEKMpXKLbEMy5zUI0ZX98mdW4djKHOobskADGzx
   bmnKIp22UZcXWbGPK4hwHCjHp4D8CKPxH1zUvp4AO4T2cGNtF/PbzpDpR
   ylrowcD5396PPk9Ano8Y5s7SdBE1DrQUIN4DMEffNbstkK4gQB9wp86qh
   S0OhfEz53EDpkKO7UjLhRlL/PbifCJqMg91ACrZKCxytNw5gmbzdGH/XA
   JwF1FS8UyGi94Ju3a2xMSFW5ne4po42B7j9bvWb0+TsOP3lQwntmZmp2H
   1clXUWvzT0Y1Ek6jNJ+V9oCrX3/WortvYM6OsdR639wvEz8lH1O4fRJLn
   Q==;
X-CSE-ConnectionGUID: VXmNcYJmRviCxG9c6Q5IRg==
X-CSE-MsgGUID: zNSZSClRQIOT4myqdEcf6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="100544578"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="100544578"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 00:26:52 -0700
X-CSE-ConnectionGUID: w5tVu6l4SzaGnHZSYJG/pA==
X-CSE-MsgGUID: 0GrQ7GaeSUKW46C+uwS1tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="232429357"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 00:26:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 00:26:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 00:26:51 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 00:26:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVTAEX4jsZf8RnADCThIqA6WJOfyv4rSspaG9pHwbxm46xtb05C2CQng0iu7LAci+n+0AYuWgCOzW9i0WAXKYdm4Im8OWtivp5ql0q7UY7LzEnBc4QlDxq577Z1+6+pYmb+36QBoRaKbejWLwHgDxtJvAMpoyhG6frhVmkvvDl1T0QzAtJPLbtDy5okhS1w1MDButacutw/7tpfRrZ432GjvRdb37dd0CiQOrVxBjoXdCw6ynG1mM/assm+QI42dO9a8Bzz4qtVrOf+bhAAD9Y9w4rgRQGRQPQVhDdZEqHCuy1gcc4rT086oGN0hcyg/YKsdUKtlYudR6EJv1kCc+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZnhvmKjVKN2XsxWsv9hvMSxvvAycYtc5PUPCzgQh78=;
 b=V7Q4Ly7+dOCe1+NPFGP4qaXrcqqCcXNzFjt6kpsIwhXl1BGtmfLxM6lDUebFf6H0/HYASsMowd3SzLD8XxskGZzq6rMumymuy4LneapaeFmaYEXei+ZZPRpBTMHELH6UJk66C8i03im7Lcc2G8WVf+u8IjJ7m/U9YkjS2QnUrBhlSeld7T3av3CfKEMfEjX7mPRtztfjBiu9kDeXbcjo8pnrphalXfcgRfBsf2kGqh+Y0gftm5LAh4buAigW+r9bzrPhol6gXZGlQS16+9CJZuMNhM4xAC/mDhZ0XNJv9d6oSo35+rokdANWaCH57uDbpFpdHpt7VPu19vtx1tRsjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5107.namprd11.prod.outlook.com (2603:10b6:303:97::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 07:26:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 07:26:49 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jacob Pan <jacob.pan@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
	<joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
	<dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
	<nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"skhawaja@google.com" <skhawaja@google.com>, "pasha.tatashin@soleen.com"
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>, Baolu Lu
	<baolu.lu@linux.intel.com>
Subject: RE: [PATCH V4 01/10] iommufd: Support a HWPT without an iommu driver
 for noiommu
Thread-Topic: [PATCH V4 01/10] iommufd: Support a HWPT without an iommu driver
 for noiommu
Thread-Index: AQHczFOuuqfc0SHbYUui55qaSnKQFbXhSYCQgAKI2gCABvQEUIAAhAiAgAEBYDA=
Date: Thu, 23 Apr 2026 07:26:49 +0000
Message-ID: <BN9PR11MB5276317325A185589BB76F118C2A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
 <20260414211412.2729-2-jacob.pan@linux.microsoft.com>
 <BL1PR11MB52710F2441FB52E2D94D37868C232@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260417145946.00004418@linux.microsoft.com>
 <BN9PR11MB5276DB15491F949DA7D8F0A78C2D2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260422160315.GL3199414@nvidia.com>
In-Reply-To: <20260422160315.GL3199414@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5107:EE_
x-ms-office365-filtering-correlation-id: a0f69f69-ccf2-4829-05bf-08dea109aeb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|38070700021|56012099003;
x-microsoft-antispam-message-info: 9SkQt920BGB5hBNlmuQ6s1fRK/KfzEV+vZsy+3BXThNTzg1buyBymB8cbaRuXmAWtn3xMjeAAhIDJt16ddrE6cnsPbgSNiRPDKA2qAaXq3ReYN8mR3dnUAaO+lbtHCyGnhQociZnhZSWEVRyGg/39xi2nEOVx4ZQyfQmTsk2twwziy2Qic3cblO8JIA5DBw5jfbxLUNbawweLn143iAD8ScPQJvA6lPbNGQPrTDnjDwoaP2i1w9Eix3/Z4I7KwQtZtkEuYNZ+So30Ky5xuJrGvjGK/Fzt8APohmTBBu0fjcyo1Y68QZWyAOjZpE4OtDhd4dGXERtcOlaNQvO4yRnSID7Gz1uFNb79eMA3r1ha83KfAnwX0uldcw5xw36tCQtqlUgX2rDbf4FTfdDdP13X/pGi4VBNN1N96s4y5fwz26wY0YMF9wwCVc1YxvCrtJfyjbgcWlFLYPomFY7f6VoYpaKaW3UfDq+RqkQ4xRM9469M/UMCWAGQfDQCI5BGF7gfu3xq8nT1O+fp3XO3tYLCbyYgse33euNiV4M6o3MwFrKzl+isEe/zeKuekpy1AYfk0WXcIu5dZ6qyQXNdT5FWUsf0YpgUWHUekcDQflx4G4+mOvwE430PpckCsJmJgrZyT4fmKq8gIneFCd63HnUbI93TodKCBiqeEBMauuge3oL+E8Nb77SE4lf9Wgje6Qb8aHx6O/p/sC4d5zY0QuOIde/lZas6LeC8QpSqfdMNAF5qd0dSlf2u3xXr4ZHKbRzH9fD6zjAM+i2B0BokBJxfbOmqP6mb7/k08CR9fS0hbo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DMqVpo1nXRq8SUbbcaZKlLc3WKZgAt4hkmaxRgN4EhkGBPMKnovAPfTlsAtb?=
 =?us-ascii?Q?EUqDPhbNvkFI9Jy9hvLOdYoU96i2PoVgGDeWZs/J1Ek1229R4f2Fb129C9rK?=
 =?us-ascii?Q?z7Nonv2eVRQpIFhY2xI2nQp6v6Vo2uUKWSDyLLLqzQG7QFZwWGOzshEbvIna?=
 =?us-ascii?Q?Q7SLxGJEJTxnOlLFo2N0pIEGd5JQdgJqpB+/eOcINGlrQLa4hraGs38mMsqg?=
 =?us-ascii?Q?mRsrv1vM1+4KeoPUXv/jsmd+JOMrzhYXu08YbkAqR5HmS6YqI7xWmBiF2LLI?=
 =?us-ascii?Q?rRXEZdn1/+uLlW+lU2NKnTbjfaF/ew1w7rSEHLd4c8+cfZQxZBUcCdNUnPge?=
 =?us-ascii?Q?x4n4glqxt7GpGnuDEHd92jpTLvCcI4r/HWqQOgNSi71p37KJDzij9Fq7ph2A?=
 =?us-ascii?Q?6iIal9jyrKFxF2psbeV6Vpi1tngqiJzMOhHxCrbK1n5/yMh4oDAMCrYArR/C?=
 =?us-ascii?Q?hGXdfXK98O/qzHK3uw7HIf2Y0na/s9+dzw1RbDgfzib4SxS2Ri8JkU6yoKC+?=
 =?us-ascii?Q?fl/EYJM/svZ+obFNEStTBMjUBuluVbRRYm1XLeeUR1cpEjdad0GVgFesaMfV?=
 =?us-ascii?Q?VVWnqL4uSm32EPbUaE/43I7wkJdkBKG32S4qicYngiSM/sPcr80dkP2E+ziQ?=
 =?us-ascii?Q?+VL8VzuqFe3ljYXJpL74S9PFjqC0d9rrTx9hYWmQdu2ey9v8KNkWLl20OCYB?=
 =?us-ascii?Q?hbsZg3jj8WSjLyE7COPtnfTFvPA4cRebS2vX1+gmJOMjqIL1Hdy2T+t+6AJ0?=
 =?us-ascii?Q?bBQ+0+UwxBCBn9DTDxJ7Uf00RmEpiZpVIKOArwhmyHQvPLlNI/nEifNBfjcs?=
 =?us-ascii?Q?QWr2gpcvhR2NW3VG09SvIfCe0daTGKoTDP6FcdffJ/h+VQDOFLEpIxg3/pZF?=
 =?us-ascii?Q?RSfBuU4x8xA7MfZbuB7SVbhwXsbC6ftxVR2jN284KwUwPMZRw3GsZm/1OPkX?=
 =?us-ascii?Q?bfcUj+PBVjvp7kA2Vmr+etAmpHXkS6s3TAQJMBVSxdSvL+LUVO5LUw5QMPeN?=
 =?us-ascii?Q?u1FRfdCSHuSuPCA/Njf4qCqwmkGpwC557Fp7G15ZW3tyPVSelcECaU2dYY9I?=
 =?us-ascii?Q?gE/Pu47BQc0crTfnSkUrToc1zj+dUcUdXBJ220WYHbPQZrB10rOCzibYaJ9k?=
 =?us-ascii?Q?+YHVbGqqMJ6LnIW1rf9HkwI+OPi8CYI2kf+pj7LewpmAd7qxMOjmi5OoQNj6?=
 =?us-ascii?Q?V++wbUvIxE1OROZGVugGni6GJvkJNiIgEDuFd04ey0B9W8N2TeNb6SJZTXnW?=
 =?us-ascii?Q?DpHNO730GMW0/1JXkjS+vwGPCNGTAYVEPiEttkzXe6cUqTLwvjNMgoh9PqPc?=
 =?us-ascii?Q?svGEPc1wDjfDerKW/5gAbjDHiyBF6/tedmbfRI706LioD9Jp4br7gvWoyAks?=
 =?us-ascii?Q?2xVx5ovcYT9QQKQ0z7D2/aVmMgFlwqT0uqGJudtI+YpelrF60szAZgfCVlbr?=
 =?us-ascii?Q?Lam1grrnp+p1uxABG2AJAiTH5bTyOi8aF4g4ruBZq5gCNHDBdl6ZMPiQHsQV?=
 =?us-ascii?Q?JhwxpUW5yg4azYr8ENH81LO9mGkafMuz0Jumo8QhdwT9An5NKHSmJS6VMppF?=
 =?us-ascii?Q?QXvbPNoIqJ4qRCOi3LXyRZsapeRsYoIOnszh6W8f0O54c0X9IBEVJY2XExVx?=
 =?us-ascii?Q?oI0hn3sbOUni5RMGdLg7AvkbSrKLNJgLyibQWAiVTaZ++jcXvLxiUztkP7Et?=
 =?us-ascii?Q?epTOzyhFvukXFlQhGeGC16tv2WH1tn5B9D/x1geWxqgWeLfT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: btklmcCF7xQ6xh3FdQwjLTxUQIbriq0OFt9QRGRT3vtPvjsdKCWXOsdr5g6jSedxxbtHrTsKT8taT6dFfN61eAh7bib3BQxl9m5V89tCjS3cD23H32OcQGpJ+U8tf1Q5v4C9q++eYgr1d/81BMQU5m2l7/aTDuDxyDooKjZTB8LQQu3Abv4mwo9ETTHexsUXJoqR1MLwKrj/qF5GYhJmoX0/87g061GdNEg1Nz7K24cwLzPC6pGBU7rIN0jZRG+eV/+RD/L5YvwoG0jo7RbODgcrE2NjwHH9ab0zBJq0wp3P/kZ/qGZs7/xjjIjd/Bp++v9FPhYMk/UJY2lbOfVm4Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f69f69-ccf2-4829-05bf-08dea109aeb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 07:26:49.0666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qEI4YQXveG4cOe5y986MU74hx6eSoN74xI/yC9bZTfLHfXVXOXkKICuqOy9wh8aHh5/QUlddudgsG8/53GiThA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5107
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, April 23, 2026 12:03 AM
>=20
> On Wed, Apr 22, 2026 at 08:12:43AM +0000, Tian, Kevin wrote:
> > > Technically yes but we need this flag to match forced features since =
we
> > > are sharing with the real AMDv1. Otherwise, this will fail with
> > > EOPNOTSUPP.
> > > static int pt_init_common(struct pt_common *common)
> > > {
> > > ...
> > > 	/* Requested features must match features compiled into this
> > > format */
> > > 	if ((common->features & ~(unsigned int)PT_SUPPORTED_FEATURES)
> > > ||
> > > 	    (!IS_ENABLED(CONFIG_DEBUG_GENERIC_PT) &&
> > > 	     (common->features & PT_FORCE_ENABLED_FEATURES) !=3D
> > > 		     PT_FORCE_ENABLED_FEATURES))
> > > 		return -EOPNOTSUPP;
> > >
> > > where in iommu_amdv1.c:
> > > #define PT_FORCE_ENABLED_FEATURES
> > > \ (BIT(PT_FEAT_DYNAMIC_TOP) | BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES)
> |
> > > \
> > > 	 BIT(PT_FEAT_AMDV1_FORCE_COHERENCE))
> >
> > Okay, make sense.
> >
> > btw iommufd selftest just removed the amdv1 format (will be in 7.1). th=
en
> > let's not mention it in this series.
>=20
> Why? The selftest was removed because it wasn't used by the userspace
> selftest, the format is still there
>=20
> I wanted to use amdv1 for this because it has the best multi-page size
> options of all the formats.
>=20

I meant to avoid mentioning selftest like below:

+ * AMDV1 is used as a dummy page table for no-IOMMU mode, similar to the
+ * iommufd selftest mock page table.

"similar to" is not helpful here, and is now not the fact any more.
