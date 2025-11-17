Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14971E5734
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763363425; cv=fail; b=QpgErDAPnIA177sCWmEsJ+DlqmCtjrf4vt7Ply0rMr7RGYWNRloGVRAflYDGjQ8IYaam2dQ8/Pq/8rgFljS/M47Ts077lK76ACXhbaloXjgMgG71cXRHCqxiKgdT0nvjaMN0yyrnrWkB6NsQGJK7dw8uqNhfTjDEfYIfjecr1/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763363425; c=relaxed/simple;
	bh=do3GsZCsv9Rx7PGxeOqfeSurT2pVkwjv3ZSmXFXYuS4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cjv3F7reyGxBROVQspCmIh2a96eNg7V2ZDPy+m/fAeW8dEJU6PaA5Xw+uOfAEUfF8bDCtphogpw8vpde2bsqWvL2v9n9GH8C1DpShasCFDokO5+TISh9bByMh8jFB4zKQ8jEzmoUZ7FvOKzkQscPZfmHnN03jPMpKFzh7gHl6fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AKnYCYT7; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKnYCYT7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763363423; x=1794899423;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=do3GsZCsv9Rx7PGxeOqfeSurT2pVkwjv3ZSmXFXYuS4=;
  b=AKnYCYT7uK7cVgbdL+ZNFxOM9moMBdZ4yjmwKWjjfWaAL6g+2bvllkOD
   Dyvu4GK80m5lkzlnMwBA85Q6wPsoH7bTHgfzzFk3ZlkgOg1O0DxOrKdG0
   87NAkFE4iwONQ4GyznjfQ7dl7+LZhH7Cg4N2VvPc/3Smzf1wEw5SHVbNm
   zFjjtZ4PPl+R7OrYDQPF8+U2IGzNka+pf8cv3Q8NgSw8fPk7MfFjAv0lt
   lmah6OMDcKQiMFBfbfD7mq/YBwTi5fib3ld9nQlzZxTsVCw4osJhZ22Wi
   GQDKIucgmyJtCrejJUZUZnNZ3ig2kh6JubjWq55WFDQ7OwaseXwu5qYAg
   w==;
X-CSE-ConnectionGUID: lLmjqYX+Q4Ob1IQUFZey9Q==
X-CSE-MsgGUID: dSqnB0U1St+YdoLSh8qNbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="68975443"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="68975443"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 23:10:23 -0800
X-CSE-ConnectionGUID: 9peKa72xQ9uICQf1P4Kn3A==
X-CSE-MsgGUID: 3G7okxhVQnuseIL7pA+8ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="189672496"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 23:10:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 16 Nov 2025 23:10:22 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 16 Nov 2025 23:10:22 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.32) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 16 Nov 2025 23:10:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtn0LVZBRa5C+LNgmb9Het74W16bDqfxS2D8UfnxV5zlprrO3hZ2dWwxBc7Jq4kUahcv95wc9GX1AHm1G8FJ4icmoeGO67JFcxR8uv2mfasos9R3L19bKQHRhy8VDHUpl1ZrAUJbwPyiUDyWx1YEGQxOEA08BaBoZ1BiAQQ8SGUWFSaDkSluKcv6T5kPynugsfriMctrYLndx002C5yV615dVDo2Wcpa175nex4SIRsb3Vs+ujEFcfJpBbHbe1LdD7r9ohNFemm0alImx9ksmdA5tStrY6OS4cRjRmwceQAv+L0mR5mm62KopOoVn8DmwMbw5GOXbv/FGyXRnAvt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=do3GsZCsv9Rx7PGxeOqfeSurT2pVkwjv3ZSmXFXYuS4=;
 b=rYfYzJba8RIV7PLYTyXBAbGnBDKwfMgcvREYJcyo3YRK6gQ5dQIEMH2Sph3PDmJaU5y3I8luIa3gPn5abRFP0bJNieFbAQau8yoXtIs18hOzbE7xFGfRHWwrEp3baWs0gslc400vBTY/eqhcQm/V4k0NSDX5SYV313zqaHvRsblZHJa09OCNrA93DmMUQMt2SMisvk8UYmGs/fznIbpHZZ9PWAjtguvNdbMMWj4zDkPGXu36wvIJi9WZMX28rNT1V6K00etChXCGg9Y32ug7rMP7ZmMKq7io2Mk0olaRa2EGrv+ddCU1k1XzQS5BoAsbJGgUwu4hjrrxss0wreVqqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB8600.namprd11.prod.outlook.com (2603:10b6:510:30a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 07:10:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 07:10:20 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Jason Gunthorpe
	<jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Lu Baolu
	<baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] iommufd/driver: Fix counter initialization for counted_by
 annotation
Thread-Topic: [PATCH] iommufd/driver: Fix counter initialization for
 counted_by annotation
Thread-Index: AQHcUunO6xae9Vri7EiznGH8QmRq3bT2fJBQ
Date: Mon, 17 Nov 2025 07:10:20 +0000
Message-ID: <BN9PR11MB5276BD6ACDFA20F09354DCAB8CC9A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <aRL7ZFFqM5bRTd2D@kspp>
In-Reply-To: <aRL7ZFFqM5bRTd2D@kspp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB8600:EE_
x-ms-office365-filtering-correlation-id: ecde24f8-8d2e-4fd9-f9a9-08de25a85e88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?KQnTTnRQcPXHWheTPSFhrad4TJWfe/k/IOV75cjrh8Ja0uAcf5zVNDTuCUQ4?=
 =?us-ascii?Q?o21gb9y7fVN35BksHs9I/4u/M9UHbs5rFC9UQxKEAMobSbNR9L7vIZtBhszb?=
 =?us-ascii?Q?Wydqsq7Yk8xPSmISjGmMxo5tNJ0IZ/EUDu3aL1ii0osKCWi3mea2wiQ5IaMi?=
 =?us-ascii?Q?hMKqg5nWER64TFLM17GynY+oxo5Cvm8gZYmnusB9x7YtsF7KfxVhOit+aq5S?=
 =?us-ascii?Q?+YPh3gK7wv+689ZLqAPv/GnDi5Jjb8gdHJGkHx2AeTnk9xAPwsF8mQLDrVR8?=
 =?us-ascii?Q?5ASfJwZZE6f54C2oCvYFKuidmfX3sM4h2vXExPFU7DfIZfieJItrnyrC8mhI?=
 =?us-ascii?Q?qRta2F3OBCJ5NNGTQwGl4Z4MCZDKypXcq2c7OXRRc9urqAtmNC5nr5kdcx0y?=
 =?us-ascii?Q?O2cwx33mU7KzfzGGUPgumZi+tt/O3HRqduspOC0dDSNj1wANOMrELnBHlCNM?=
 =?us-ascii?Q?+ruSBfkjOXnbC7gqFDoWEIKcHtSTxt4B588ZgAxBzqcy2tjlG9N71J3cplG3?=
 =?us-ascii?Q?E7ourcjGuDFUq+sBbVzEWt7KY4fxsPr6XzJv/0bVlyhOpo/kPSJXFxG0JVxH?=
 =?us-ascii?Q?mWx2D7kmHcZcmba6LhQjDR1Wb/pRrD8HF8y7K0i4TSRhvhvrBldeLFhGsZqG?=
 =?us-ascii?Q?BPcFCCFQu4jHNqjemt4avb/0BRZ9kpI+HBEJJ5r2/imnclL5uJ6YZKcv//zg?=
 =?us-ascii?Q?OcNoOJ0S4u2xz5O+u1TAXehV6DVapkuFUptoYFOLcUwGmXlq/riv5hnFgp+o?=
 =?us-ascii?Q?vZ2pquqFcDV+lAYVX6Xt3cuaSWSAbK+tWUWXy/g4+K3K3BuYHHtkdfsXU3t6?=
 =?us-ascii?Q?DT98RXpqjSc9MNBpeLku83uhjEWonedQ2Gi1Br/DBLYdcjWH7++xLD+XUSSy?=
 =?us-ascii?Q?TBkAxhK3PTekiBkydCi+fiD7NauXArWwqLz9nYZUvQutjrMr6SfQAvkTMYFF?=
 =?us-ascii?Q?aw2pdk7PMeFSt99l2zD1fd/SwzTU1XMcmUufAZwrhb+yDX4PvGEQZttAWj3u?=
 =?us-ascii?Q?90rxccjtmoTq5zzCUGdyi49mY1Vx3k2BSKObXFA2xSKZA5+LpY//BbkKDIwn?=
 =?us-ascii?Q?W2+C8QgGquB2YRxx1rT77bvqj+YVB4JeLcnpoeXMwL8kAd0KdTVUXHXkDEq5?=
 =?us-ascii?Q?cmb+82eQl7IDcocReDSktLjOZXqruCsYk3Vq3ledca3TOCL3kDvHCbu3d+s4?=
 =?us-ascii?Q?cBFFw+F7XFw9wa7fbwZGXthoBF69jhyDw/GsyCMp7sFcydbgr5fOjiknxFmC?=
 =?us-ascii?Q?kwngKT030bp1Rg2iwuUHz3lxbAprGeKt13bGXecKD0lRZKZ6zwX13DKwjzAG?=
 =?us-ascii?Q?D3oIzdJ7FUa1af5rGQMLS3cSynUYfB2VCvzW0I/Qjp+LMh0p1ShjqTcJ6CVP?=
 =?us-ascii?Q?5Bx3Go7tLQt3YXD4eAcAcr8HUQz/g9qO3IqxaypmMH0UuhnxWEo22vvIcVRH?=
 =?us-ascii?Q?J4b22r68hnOXOuzs/botxALZmffUt1QClx5an0fH9ons+yZLaJ3HftCxXYUg?=
 =?us-ascii?Q?RMcCtjhnWcPTLVWG54Y2NbC7UYSH0w0m8FiB?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3FA5oXe5/MH6/8YpjclzMc0irdVhHkwciunI9XDep63xuD5oFLBFegTXDoEu?=
 =?us-ascii?Q?3CVy8FSWEn9BpCNjoscBBO+Z80cBmivNOg+0T3XcNiQ+OTXJt0BPhLcaBMvC?=
 =?us-ascii?Q?qoENbvtfCQc4E4M+0JY0kr54S2s78r7UvbDZ81U1sgZliFSiBdK6EAGDPZ66?=
 =?us-ascii?Q?hN+ziJCmUm7ycdVpS4hR4pe1Fv7YXtAxb5b7kVts1k6GHFnjyzivXXplMoAX?=
 =?us-ascii?Q?N/ivk4OxRvGTp2gXzH7dO3j+yoqd6bRddbN2apgEo0jwjZJgbEsp4ahvy9LV?=
 =?us-ascii?Q?K4pc0OytfZ+Enu6j/vCctcYmv+5iJ0X4UmOm9jMoXahITj3K2dcOt60jhxuv?=
 =?us-ascii?Q?rtG4WZDctMlTckzAuJeyYIte2FeGyas38Yr5rAPaaS3QWpkgTL7UcH2bfzR9?=
 =?us-ascii?Q?C7yG3PSOFxjcgVZ8afXg4u9Vt3dITnlbZNAwcrRbFolvqQafFgXiCVb2w/sA?=
 =?us-ascii?Q?Rgs2a9m1cDaGCLpQ5PyyLOPkvCBb7tNUN9xT9uLoqOPlgiIpuVE6l0t0PB8k?=
 =?us-ascii?Q?Ig6OWj4tzvaVfDf7WE+6JxIBDhPm0m4l5ij73CUAcOvb/WM4V7rk0m4EJ3kq?=
 =?us-ascii?Q?GQCEPJHhLbx21GChs7DwTriKydtuj6lmZT2/Pe9vh9XGoKAUIOjlIVRSunsM?=
 =?us-ascii?Q?pTgPiDGIGfV9j/KJRM75MmVfoyVwzQtYIcf7iVguuR4WRv3JUdEWrly2kGNF?=
 =?us-ascii?Q?ky9VYJ7rP0Sp/PTVRl68Gujll3khB0NUfGgCFYGUG5aXEgsEBOPZkiZ5FbKp?=
 =?us-ascii?Q?ZDQJ8Hbrgp3VZRlby/M8zjpCFMVQhdmOjzkmbb2odSMEkkrPJK4qR01Vd8z0?=
 =?us-ascii?Q?P1RCvyRbu6+5sgmkW2IE+jLvK4iwfs+zdwlMPu4vSRwnAAhJGI1qyoM1Kx3c?=
 =?us-ascii?Q?V0oFhwHVcJLHYH9ZHVqpC4UGH0vaIYXNW5Mma7SUlRMbIa08QWwQFxROil/M?=
 =?us-ascii?Q?wIV2CAvupEYW6/hMerndyWVT9E7k/2QZ3FxRnkfTqllZs7OfG9CYXpv68Os0?=
 =?us-ascii?Q?KoyyKFhsAzedo11XFbwQgfzjQElesxAdxUQsgDHh5xKaMQ/RtLNUo7yqB0Wl?=
 =?us-ascii?Q?zvdhANXkS8qBKxXJhJmEgZuIDms6WAxBXYEoLURdk4Xs65ABnJABfkiXzMDr?=
 =?us-ascii?Q?+0KdgU2Ad8f6+AvVv7AXNkzK/aGkfvL94eM6AiiJ1fcF/wZUpUIfQ08NARb7?=
 =?us-ascii?Q?Jvsfc/5Wjl8Qq0i5BLseMkkpO5hWnddT1ilgXMOWgn19znCWS+0/pRBF36+p?=
 =?us-ascii?Q?gONB5R8lHu03MGQsHhQtf+4/d07Lhia0KkuY8hpnqjj7tPgGyvjRxe0obaa5?=
 =?us-ascii?Q?mQUayVpCC9jIMa5EXJ/gzyv64TOrpv4yBQvvUOp6vtve2xnIazRxhAGKSaZa?=
 =?us-ascii?Q?b2ruapee5FoAePRcFz66vhD3Up7E9TuwcGm+nXkJdADzfQdbwQztyytMEB61?=
 =?us-ascii?Q?1TP6+PDbMmLTjP9YlqcBJSkKkXEp25alRkMPuV+BDxdNJ4YqPreNDZMKKchN?=
 =?us-ascii?Q?00qs0RyBkceuQs32qw0JrL1vpHaiWWmImacfpm4zRPFBqjABgi02/A8Y8qP4?=
 =?us-ascii?Q?XVkoxRkcOGQtqQA1CR9gBCAaSTm37pAO7NXrz0NT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ecde24f8-8d2e-4fd9-f9a9-08de25a85e88
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 07:10:20.3834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bbkyAaB11KuoQHRIAhP+HtzXJZsLmL+W8h0otS/DEHaZYI5BAFu4YFNHjCezXcmJ2o3tB0L8oEKGlua7kaBnqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8600
X-OriginatorOrg: intel.com

> From: Gustavo A. R. Silva <gustavoars@kernel.org>
> Sent: Tuesday, November 11, 2025 5:01 PM
>=20
> One of the requirements for counted_by annotations is that the counter
> member must be initialized before the first reference to the
> flexible-array member.
>=20
> Move the vevent->data_len =3D data_len; initialization to before the
> first access to flexible array vevent->event_data.
>=20
> Cc: stable@vger.kernel.org
> Fixes: e8e1ef9b77a7 ("iommufd/viommu: Add
> iommufd_viommu_report_event helper")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
