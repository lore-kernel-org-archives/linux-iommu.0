Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A2B16F0E8
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 05:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737352564; cv=fail; b=pmV+4Of6f2LLDCdYC61W5LohEn9FSDEZ2EEAlow+25r+PIMja+tcV7TWCen4VVvrs0Gw0Xc8wOq9ATycIicOfXafUpquDjV4/bRFttklIwMZJd42huO+HNPBd4B/NWdw1A7CljHJc8mqxwlfXO6aXivu3UBZc4tqiJkByypJEpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737352564; c=relaxed/simple;
	bh=yb9rBBIjOzDt3eGaipDONrw6opvIcRzzyrHFAyzUMBg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n0sZ9H8e9vOZtdeSrM00kVghYsTbyqGoMt4ISL61570KRGna0ikeCQWuCzh50ETEjK5Jv33h4PIDxAyq1VWTjSzUkz0HshrSV5c3TcWhhTMlbZxuHEHyf3nVqPTyH32eavnFDKPp1yHd2O74iOvQLTMUVzdxlNs79hQfsu72y6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7iQsNBc; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7iQsNBc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737352562; x=1768888562;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yb9rBBIjOzDt3eGaipDONrw6opvIcRzzyrHFAyzUMBg=;
  b=T7iQsNBcp4PfogKAX2TgFbfiHXvvdgR0TydYHu0ZR/rBCa4Wj4+LvIgk
   qbLD64BOogYdRXCBJORt2617DHQJgMA6em+J65IoEXizx8bj3jdbHlct+
   beWUylmP8vjsJNC52IUexu2ecXq6N77JDK4bUP1dA450pi+tRpE7NJNAm
   qbGEaJHVXESP4TeKHV5PfP/fTsKVq/7Ur97z7O0+aI0GWyTYeiGuNTjf2
   lATBYYiaZzbwvWLUPHsrjhJBIa7E98VDhsl2c6eK7vRM3prkJAUgMlvZE
   N3CZ+zAZZaCqnRxiwpNGniVtaVYG5l7FAUmIE7olTgZwseYugihNRjr9o
   w==;
X-CSE-ConnectionGUID: BpS1S73VQxOYK9POf7ve2Q==
X-CSE-MsgGUID: Tcq7Pmx8QCif9va46+axwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="55264281"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="55264281"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 21:56:01 -0800
X-CSE-ConnectionGUID: lr68kAgPQ9OiLeJzjKEcRg==
X-CSE-MsgGUID: 3ABRG14aR2ajE++de6GRnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="106227543"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2025 21:56:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 19 Jan 2025 21:56:00 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 19 Jan 2025 21:56:00 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 19 Jan 2025 21:56:00 -0800
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5861.namprd11.prod.outlook.com (2603:10b6:510:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 05:55:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 05:55:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH 1/2] iommu: Store either domain or handle in
 group->pasid_array
Thread-Topic: [PATCH 1/2] iommu: Store either domain or handle in
 group->pasid_array
Thread-Index: AQHbauin4USRH4zpcUaGcXVZvVb9xLMfKgSg
Date: Mon, 20 Jan 2025 05:55:56 +0000
Message-ID: <BN9PR11MB527626947109CC27BD059F898CE72@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250120030840.4171-1-yi.l.liu@intel.com>
 <20250120030840.4171-2-yi.l.liu@intel.com>
In-Reply-To: <20250120030840.4171-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5861:EE_
x-ms-office365-filtering-correlation-id: f767b898-36d8-4933-ee22-08dd39171bbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?TF6dY/+KNP8BucWo4XHPZ12bxhR5lOMOOekOREVbKLeLDq+tgmd+IIAaqalj?=
 =?us-ascii?Q?DXoqSRRDajPaMlaD9tSjOIQX8Dc5VtGTFYJ4KsEaT5/V4RNYlgkd8rm8ja9o?=
 =?us-ascii?Q?AB7hu4oyB0r/ZcjpkzjRyd4VNRlaE0u1pGbBLHjM+kWSdJJKhajaidbScatG?=
 =?us-ascii?Q?tzafZJG+G2l8dNXPzAv7WCDzd+3JlC4ULcMVGSg5zdx0UbavS57aUy+cvuRY?=
 =?us-ascii?Q?17UkM/AAYRyHOrLEmrcxVG4mrG1elKRaAaTcskZplOxSOx9gq6Jj3Q5rwmsJ?=
 =?us-ascii?Q?phHYbaOMBReWW7XOVXcquYUlDMqNfyN8RXhMFp+hN+xk3SSKkT5hhTX290J3?=
 =?us-ascii?Q?h01GqcFlcgkBBeLN7o5S313mzrYnKYH1zvA2tiJ+U+buZVpzHiK52JlzA6xf?=
 =?us-ascii?Q?FzHiLJ3tXfiva49xYnCfnU9CbuvAHy/f4o302dKx/Zjq1h+KraB3TCTqPjhr?=
 =?us-ascii?Q?cKmwGg7DqBkqdA4U6jT14m3WLLcVhb+JYObUm7lQ84lTB2ncJXF/teqntQh/?=
 =?us-ascii?Q?aG5oHulHnTd9iebjjy/austm03W3nNv5e/hR6V5MY8XPlhXP54ddqj422UrN?=
 =?us-ascii?Q?AZkLeD73tHy6hQxS6Pq4E92K/w8XNGkco3p/PsNHqqvVntrQO/amICOsWOd/?=
 =?us-ascii?Q?HYvIKtWDOCCFagn4q490Rk1/CLUKnwWKgoVVr9sEr2AnjwVDUWPke/TObKU7?=
 =?us-ascii?Q?+7MhYC9FfU8Op8eGlOk+gYC7TBe2i1lwkuQmJCRFFKRLSdL3UpnFZEDslBg6?=
 =?us-ascii?Q?cL7CdQr9LMkifK5pdcOU5nK6hQygXZJboYRGLEhoCoqC5R5E0zsETi8MFigS?=
 =?us-ascii?Q?9I3Hbi2lc5XIzTPBKvGBRj8xo/W3KhowGtpgSCNpekwJnfNB02BZ416TzYgo?=
 =?us-ascii?Q?cliztcFLYlp3rQp2jAYIh3D1OwRMJeMwmgejekfhGb3n7iNxxUIAqWZagbLP?=
 =?us-ascii?Q?r2WEWtcdOxd0zw+hmyNxybjseTaTrzZx9TgXMT4I1KO0+YCiZ0Hv/v7DZj//?=
 =?us-ascii?Q?moI5FBIjCy3IoUf4UviC6JcqQlTkD8q5wLQzkEKIFH5UNC74vKiDgWDFgJpM?=
 =?us-ascii?Q?xxLL7OtoTqcqN3evCwRcfCv0OCCI62xG40YlWp1KfZLH8DJlRhHfDiVeVY65?=
 =?us-ascii?Q?K2mSuCG4vCeENZTX1gE0YfEftABB7g2V7xjyjZXDFpms8e20NyDhiu0WLUFe?=
 =?us-ascii?Q?6gcGve/EkBOTRbRwZxfOLNZdZdWyin310t1iVIGz3oenDSEUH8yI4knhlGxo?=
 =?us-ascii?Q?CcU/g0DDLxc8Mgw4xJWJ4Fx4RAz32tQDLe6tWjn/gGtAyzI060EVryjH5Ptd?=
 =?us-ascii?Q?W/2DqMpUYCPcQltOm0ovavOLsSqUD7XaWsb2ad/1vD8S7WJHCGbhPbjGI5SG?=
 =?us-ascii?Q?2a4zJH1LebAhjUOS75QG6i3x79NB5Zvu2saktVo2TCBAkdN2JWcjVsY0p61i?=
 =?us-ascii?Q?sq/JKFEolynnV4sOWn2EFUZeKCWNBmZs?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f66CH4lX93D5jDOsnRpcCK31T/5r+d5/oNxiIyo4MmYuG35NBme09EawWi6e?=
 =?us-ascii?Q?Xk/GAAFaFh8q7UQonHPB/DEAxMwWv1BcfKf+QXkvywrFI16kfHPnjBPIF0BJ?=
 =?us-ascii?Q?kZifHTkRX9mjmwopeEVHZh4tWa+riniwMOTE3StORVvrRUgUU/hFhXcX2VzC?=
 =?us-ascii?Q?yw/vM1By4GFML5YCvWFqKJFcxFoaKkNyF/3Tv1iTmSdKV8E5PJ7Emqu29To6?=
 =?us-ascii?Q?rkWbKA6II6AMU4cYLAXUcMwTbu7B5tJnmCfwYZLvwExM5Lzf/Rzfo9Gst4AL?=
 =?us-ascii?Q?7+lZ0Vwzwzawrt+8j/nEIlt/fYls74Tmo05YMk2Lk4rt1WHL4H9wrDoFWSZV?=
 =?us-ascii?Q?97EuJxVK0cDHOw/7N4G4yTGi9ZvhyRoiIJmMqlbNs+s34JL+oedpbntvh067?=
 =?us-ascii?Q?ZLE1aaDbU7w041S8Y1sypYzUJjTE6OfQdMaA9rvQAGHK5fORgMQGfF0/5GMO?=
 =?us-ascii?Q?zXwMqaQ/H2yQRK+Zf6tg1J2XOuuVncq4V2mRFihCWpLfUfsAMlamfEg/98L5?=
 =?us-ascii?Q?3zpXfqNWkfuPZPPDWbX4DXHyXp4HS/dMTah8QddbXBQWcFMtmfZU76zwD+Bt?=
 =?us-ascii?Q?zxwbSUAXIflPzCUB3KYf6uTXPmmSzUIzG4xw6gC17P8baAc3+d5iGEo0uuQ/?=
 =?us-ascii?Q?piuzESU+c3opaPeQ4BKsNBTR4o8jDGrNHmzbD10tltbKPhNNSdCP89vOmqYN?=
 =?us-ascii?Q?4fnZHh6FPGzKc75i5m8m5g0s06Sh3UJJ7rfEtXzT1lNqtYhdZ7M/barAL1Oq?=
 =?us-ascii?Q?jBLfGP9wpS8KtqcExF2/877A9zX6ZAgjMrtxLeTYQOn9cWDPylxFKQBwh5la?=
 =?us-ascii?Q?kcO0pe5AhbEs3mmsq7VnEKfO9cYH4bcukR+diYvoWRYNm0RrbIvwFSDAgf9b?=
 =?us-ascii?Q?v8baEYAk6qlSYsron9jnr4kKuG+B8u13jnmPxOYh6RYl96Ipo5qlrER3Q+bl?=
 =?us-ascii?Q?PHd+CbGJW9Zdbe6XCe/2YsBIL3JRnjTjy3zyvEY09vKKGFIo+kbAnDUR9q1/?=
 =?us-ascii?Q?mBf+U2NtiDi3X9SXMitcEdSXsqAne3mTK3J71r+oIwfVWf7gSWNIjHXNgRY/?=
 =?us-ascii?Q?bgPcNlj/qNBL/cyQnRYFfCWbX8I0C4gz3vuI6e6ScZjc2M5qNH886dd73nx0?=
 =?us-ascii?Q?6o9x8NZk96XzlOsj+tHVtrvAJPiXJl+4c38mKTBdyMDbuCEC0a+mL7fdkIzn?=
 =?us-ascii?Q?8wao1QhlB00tRt7aFIxMe8lMV55wHqlU1Fn/JiD7jnGlMGd3uaIQvkyYOunL?=
 =?us-ascii?Q?rcEmJQpFJ8IaI32S/Z90M2lN+/5mH3m6l6JXUuw0ZGgSwMxHchK6DQ7Bl5pi?=
 =?us-ascii?Q?5P8IcHY6C2CGIxX6bPIfNwEN4K81ksPgRbK7MPlqI78VyTlMjpannngVyTma?=
 =?us-ascii?Q?kg0X/H5wD/VoaAdqvB+zVf7l6GV0Yz5RKTgtGlOxPph3Xh0pxLzCnK79CGqQ?=
 =?us-ascii?Q?e+6nV9ofyZDLvV09z37zmyuWEUGctMxP5kKHZOwhmW5SHE6R+u2xkEeR9bah?=
 =?us-ascii?Q?fl9lbJFo6pz0QA1fTvzNqolaKPVlVojdWiynypl2MFobJ+KCPknu3FBDgCrg?=
 =?us-ascii?Q?LkhSOH1sr3dEpJYSdWWP36g0sspYUcu4QGwoMiRY?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2xRDY8dus1fxoikpS8FUnnZPSKFbZW7XS2pPxOTM/eLuHfs/iZKY1E7RYiaX04MGkzCmpZeBbXn0xc4WOCKIMB8IPSsIlV+7JfRcEWT77zjwmrhj9du0iDVyHoYy48ObI9v4TxqgmnQZ4E1rof3bPMC2dna/n5Oq2Cv8nRwjFFWVV55UZOIhLF4IcY2MfI5GeSTKtqAvcpk9dzIJOGNINhoSjawZUIIH0Xai9Vdw2aToiigPxVuhkQzOkakCd5VvrgG7kn0eQHVNmsBN2QtK5VvFGNPzNuHR4G/IS1hDqWEoK3WNe4rmkerLkt2S/ZVOPqFwgRQpwplk+P0PbRnwQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dk6/hBlSWnVOdzWii2pv2AWVFkTMwMGba9L9SPFL38g=;
 b=SvKGDxI6/NA7cf17lE7HRa5QNbMl2zy897HCCYrvm5pJPCnhXROl/C3F9xDB/WC+Iym/jzGSlGbjlhzzbbS1JvhrdTGamFz8WyvwSOcr9oUeUTXgTceCtFc8PHHaRNHEXfIeZfgFmb1NwXXxN/rUK0Z0kOghE5wcLe1OTpCm3g2HY3VzLFIPT97Ngj1ldWgsVc6ayySFiUmshRUBXkjSQSVbll8YBJjq2QxYJJmfbk5Wze2UnJ57xex+jQ1KGq0t2qloBhvRa/Gx0IFUROK1NmC2IBPb+3upeBZgDG9Ay+p/Qom8Gh47QRcHOGnrcr6XcV1uajj9ijM/L8RJr20AAw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BN9PR11MB5276.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: f767b898-36d8-4933-ee22-08dd39171bbf
x-ms-exchange-crosstenant-originalarrivaltime: 20 Jan 2025 05:55:56.8865 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: VRJ5VlIqqQron7ZFQ6B+7c6nj+CJ0v0lCDbQi11Rn404uduUyjf5XW0zBoYq3pbAMS2MWVirymqqawKY6I0iOg==
x-ms-exchange-transport-crosstenantheadersstamped: PH7PR11MB5861
x-originatororg: intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

> From: Yi Liu <yi.l.liu@intel.com>
> Sent: Monday, January 20, 2025 11:09 AM
>
> iommu_attach_device_pasid() only stores handle to group->pasid_array
> when there is a valid handle input. However, it makes the
> iommu_attach_device_pasid() unable to detect if the pasid has been
> attached or not. To be complete, let the iommu_attach_device_pasid()
> store the domain to group->pasid_array if no valid handle.
>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
