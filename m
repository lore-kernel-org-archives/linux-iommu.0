Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3882750FE
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 06:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744698462; cv=fail; b=OZ2leSmMFrcWeH4izR19KP2A8j9ZfTqZk6M2Rt8z/BBqPDwDgxdmlQDnEL5SVNfgJhGUQysgRJiFH9kmCUSqmoGfh6Hr8+uDRGZpp0D6lCAhnyEzIk8W48LAPhbBZJFrOmVGDX1f8Pp1XE5wg/l5kJl00wD7o0kLK11o8Xiz7Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744698462; c=relaxed/simple;
	bh=j/msniMZOBclc4o86pTxBS/VtYkihVIK6Xqf5Ru2YWo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WW6oS2pLV0K1FyTKHGIbL1XO9llpGFQT9gzCltbSJATuzWonVvv9+hTHgJxVqJA+MCl53imjwe3lW/W16W2fUsrp5K2qRtZ81Ex6JTIqjyTDPGPIb0sa4/4Rf0JDZlw6sgtEtA/3pQ8uQwBonJwhxKkkSJuAmi7SF839q2XoXlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiQKWBp+; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiQKWBp+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744698461; x=1776234461;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j/msniMZOBclc4o86pTxBS/VtYkihVIK6Xqf5Ru2YWo=;
  b=RiQKWBp+3DtGGYOtp16OLU7nG+zrwrPi6/MY/y60hdXfzdvB9mouzWuU
   5+US8jCOnTdKOmA5BIeqtfg4ONW7lH+GNAm6UGVXn0mMEu1UXG4mimYtf
   7M6/1BQ4lqc2V7uR6QvRt3KloJvEqZbBkCaTmBMydKzwNpd65rD0HfFlg
   hp9e99v4VLreR7GGMZL3AM101eIcYnKjZVRSdV8BRWsna9nWJ0CR29bAY
   sHksONlWHz9a6O+j7zAtj1uJrL32+QLbe7/WaOSNy1+pnCDECWOcEePwT
   NNu4fnsWSl77WELCH++H95WKD0yh+LH5LsMOZEqfxia+oJK+RovPgsjYV
   Q==;
X-CSE-ConnectionGUID: LSlhvz/sRNiEzc2bcXuXlA==
X-CSE-MsgGUID: WV+0GAsjQd+PxOi/egI1Vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="63592542"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="63592542"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 23:27:40 -0700
X-CSE-ConnectionGUID: Zyg3KuSwSimVumh45fCYMw==
X-CSE-MsgGUID: OOhjoVsfRHyuCgPzzl+kjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="134125253"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 23:27:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Apr 2025 23:27:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 14 Apr 2025 23:27:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 14 Apr 2025 23:27:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETfpJDUhJAMaZBWP1MMwkIJafGv+2ReqpBhGw3MjqBb6+W3TUH6f3PmiE5u6RAoXp5DpVau8NcsQZcbS7pxG4iy+vMwhI2PetdoQawvcsVYamexBgxcTI+owMGoYUqyCij88jMRboKVuHH1EDyAt80aFtzRjZES/0tAJgRfftzGaJrwA8/Q8It8Ul/mpRhg1PK1qV4+ia7mdnlhTmVrojlhoZHJcw63uUMKTh6S8qkkkczzEAYrFqcAuf8YBkcuwEYroF+Pcyr8EFJVipMSM1bYYi3LiF6bWxfgqETvKXelPjPGoYqyiVpjqAZ51nTafXXEwCMoJKwQRrxLaRYqqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/msniMZOBclc4o86pTxBS/VtYkihVIK6Xqf5Ru2YWo=;
 b=pFtOI/s7H6jI38ypF5jUpHztB0vn+6NAZfGMwFiAdd4Xp+Dht3jm0yzUZQh3M10FOHRd5JtZJ12szVFRdRvqBkmAZ2J5w5gdwstXcpI+8zAbNm9J/66Yz6sgO9sDCVKeQSUKxrphVM6L2JCN2TGJ8hvC2gUipGraPSG3oQWrNsQqVwLsMVzeOh5r5jWYlcrKiOoFvglxSv2BFHBmOsnKZ3g7CZHAFZYxGOMqB/Sr01YwIRZ+CXfVjPDDJS1xxK0mhWJu2weezMI8cQI2DA1Y6oDsGZyx4nGKWx26l95JBoWK2LGRcnUX8PS2jH6DHp1tiGlOSHtnkOjLv2C0fyu2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SA3PR11MB8004.namprd11.prod.outlook.com (2603:10b6:806:2f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Tue, 15 Apr
 2025 06:27:35 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%3]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 06:27:34 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mochs@nvidia.com" <mochs@nvidia.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>
Subject: RE: [PATCH rc] iommu: Fix two issues in iommu_copy_struct_from_user()
Thread-Topic: [PATCH rc] iommu: Fix two issues in
 iommu_copy_struct_from_user()
Thread-Index: AQHbrXHOwgM3DmuaC0auwXnOWTVgDLOkQ/mQ
Date: Tue, 15 Apr 2025 06:27:34 +0000
Message-ID: <BL1PR11MB5271DA81EC809A7095BC99328CB22@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20250414191635.450472-1-nicolinc@nvidia.com>
In-Reply-To: <20250414191635.450472-1-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|SA3PR11MB8004:EE_
x-ms-office365-filtering-correlation-id: 941564c4-05e3-45b3-f87b-08dd7be69c1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?9FI1zQcg6YdGSruhrmnK7tPhsTODVKSBgA5oE4kdRVvD/7KjCsLMgHIB2hTb?=
 =?us-ascii?Q?BXTP/ZYnSyt88336s/45Egxi/s0v4MBhJY2BRZ8+ijBCmLeZ7Pntg6opYKkn?=
 =?us-ascii?Q?zCH7eJ7AHE9HLEYiDO7xmDnk9F+wslg3zO2Yi681iNTdTEhQlZm0mopUNr6U?=
 =?us-ascii?Q?jtXxIit75ucIKXqJUGE5o1OLsiJxpUFHz13+lKgaSti9UFDi+ZorVlix25VG?=
 =?us-ascii?Q?c/drm21Qi0R2xyvYtljxx92YbpXCfLTHVGHbIaS4Boj6p7ALrnqtC9udfGtn?=
 =?us-ascii?Q?iQIdYeIREZa2q2Lcyxu22L08ItXxjvmomIC7R7GnXQNa6JsulY684rdDGhg9?=
 =?us-ascii?Q?QRywRGhxnu4WcR0DV9mDDph4p1/GEJUenOvT2lAt3StTutzVLGoEi6v0yV3i?=
 =?us-ascii?Q?lQhDWtlyYEer//aPhPumpXnllHkSDHLbd+qWYp4HONONU7MxOl6g5ORxdKVk?=
 =?us-ascii?Q?5NJswQgaALy0PQPqHQviBnrGHBaAoKgffBdkRBsKrWOS78O5koA2yiM8a9So?=
 =?us-ascii?Q?9li7eBX7Os+njT421Hoo1DjZp1cSi0fhIRvKgoJbNN1bhP87RWb0dSi3cdca?=
 =?us-ascii?Q?6zcC1vAXa72+FJtb/eyNH43/s5E2WLOBhaVgQ/P7ai2IdvtHqoguLgqkrczy?=
 =?us-ascii?Q?FNyQlNWzGPf7nTOjuYOD+ofAImTjO9HL75+oa3qBT00iLQFCV2UG0pK/arYJ?=
 =?us-ascii?Q?CG1KtGA0jhE5m9Z3x3rYpkXkywEzaou9WL8RfJ4cqUtwLGVMLMI/MEq4fFLP?=
 =?us-ascii?Q?kx5VQpmcI7FzuYD91rOspAXz30Ir+rxhSlW3oHA8Mxa8/O07CWMkpGbsukA7?=
 =?us-ascii?Q?5MJbSnJSGa+cV7nAaZbNe6OBYG3cJ55OkWtUrNR4D8AiIOebZRlXZxALWPA/?=
 =?us-ascii?Q?4Fjq/dok/LBzpqtvT7tzrqqKH7y91K4V7Ce4PJaeY+3tQhrW/JxyRod6ye8d?=
 =?us-ascii?Q?yS29/aLrfPu3CG0faXbkKf8LGPLJPR+vxb1Qcdm3BK9Xt4AFriMaIrPn90T5?=
 =?us-ascii?Q?WfHY784Fyl/wWLpOA/kgzaEuIadpg25Mm8qR01sY6tBdBfc2P38/LbMZQIPs?=
 =?us-ascii?Q?J/EzjJRuYqWD99wIZIbJSGdH0d77RxZvYHQpqopaeqgkuOR/6UpgAqR57MWM?=
 =?us-ascii?Q?UAwmn5gjPE/YW8rNcjEgft3dVZk3Fx5fplW0txUHebqpMJsX6yo9YAOmk1Kp?=
 =?us-ascii?Q?P0AG7bhDvw+s7Fl6f6ypVz7mtNMDmsAQ55Vdo7M1rjc6svFKxoipz1bm7Nip?=
 =?us-ascii?Q?zSb3KTqeZMFWuzf74UEtxlqGX/KGgXzDUIBCglxgla33D64qnVwlOqzj8KDr?=
 =?us-ascii?Q?njeUt1QwBZo4ykix8GsEBZOOnb7wxKMg6CJwHVAgXgf85Km2Qt38d5TDdD2S?=
 =?us-ascii?Q?IFNqpZmVWSE3J9+6n884WHHubCl9q5yhhSM1SmsYuyCzkFOt6dU0inyXV1So?=
 =?us-ascii?Q?gl12/EXmjW2c77d/cSc4WYj7PwCCvHaXied6BxGvX58aUDPJ5HqzADSI4SM+?=
 =?us-ascii?Q?TeDnCrdyqxtXPTk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0dKxx81UySPV87akwhVJhaGyJlayzGRlUvRTTEFpNYnal/CwYySIgqFj30Au?=
 =?us-ascii?Q?EiytpnjWlrbshlvCJqT/SmEgFHzfegzunQXtM2r59QdqLtwIE5zmOMwm7YFU?=
 =?us-ascii?Q?LJuoKSAH5Wdzc3N1HxSePayESFuf0QdKjtWJXkcO75U5z8tXmrOhNvU52LYy?=
 =?us-ascii?Q?9dA24GsQ68uWQG7MCJHkE8szkfyVHFp8yk6kXXwfYD+Hv77MjAXCxNBKq5Jv?=
 =?us-ascii?Q?3NpCr78ZeLr+gUbLh7y0c7+Zp9qwt1822BZaKO8DOQfmZvLTTyoqR+hq6vvI?=
 =?us-ascii?Q?x3jpBF5lkCtrvTVqAszF8Uiv9AhLcxs63elAmL2tDbkh/wKKB8a/swxPlZH3?=
 =?us-ascii?Q?qSk+ynCAkGAMDAyZ3XPOqXwv9LcdQnWQtRrZ9PxjO1x/KlX65cBlNXORnP3/?=
 =?us-ascii?Q?q8iS52T0lXAJqPIgaclv5WX2/ZdTR/0fq3R/n4emuWkbHgmkw//wpDfbqpUL?=
 =?us-ascii?Q?26Fw/eod9Ca6UuA8OuLUsbdYqxkVu9v6QwVNg8Y1wNduW8snRLqYdpmpX9Od?=
 =?us-ascii?Q?vwKKkS6r36vLpZ9uT1iNHP8iwXg9EzaI9d2R2MaUwJsqCXOlsX6sd3norzwX?=
 =?us-ascii?Q?H48+JlWIeNvFaJO1WqjF9C7DkTOHZB9NCIIGSR0Hyk/+SPIuupEhTLma6shc?=
 =?us-ascii?Q?OUQ7fwh2PHJxLs630ApD6e8AXM1fFwZ86PbIY+iSc8x4+bFaX0Nov9qQx4l5?=
 =?us-ascii?Q?K/ziWMLBDjNDT3hzqfenutPhzyoHUU1IVJxF9y9OTd1Pqa2oGDycSh3oamfT?=
 =?us-ascii?Q?CaUAm7P1IrBpiQR7rNA5CzyytD1pcDOqrtR/XvEgDIP6fpwaQrp3Wu1VWbp0?=
 =?us-ascii?Q?TfE1wBvqrNDU7wvtjEZXwzs0NJmaCicJoGuYGgzM1eeIZ7Mid/MVskbFCrSb?=
 =?us-ascii?Q?3mW+k+loMwUQYv1pAWWiV997eF1vzfpt1svl+qNdd+1/Bodedx1voUrMXXV+?=
 =?us-ascii?Q?8ksnFacd62V1NiR7SU4r93gp1AAqBUvO9VQA+yyn4ugz3upJfAVdm6zUJOob?=
 =?us-ascii?Q?cMJN7zbJ1zXwxGM0eLwAW/KDoow9noO+lGsSRMUL4OPyfLY7L4qWsLNy6yVD?=
 =?us-ascii?Q?aL/ACT0ydQLdZX4eVKzNLHAnK4eHi16BLxE46F04cumNzzehaX9TJ8PZzdW1?=
 =?us-ascii?Q?RETJd32C/ohO/MwGffKTWRza2m7MW5NJfKnymnJTCdtDzCEUjFJtWUU0eRzp?=
 =?us-ascii?Q?5D35vX1eNwNwgcTSKG48+gVIVDdb+qUzezE68u9MQTPYFUeIX5TsiEKLwrk1?=
 =?us-ascii?Q?th9lUpq0BDcO87R+hd0gY9DNx18O5faWKL8vz8FD8AqglNGMkzlYw01LPOm8?=
 =?us-ascii?Q?NpdR9yhMBm72+dqAhTKRt9o4UtVN+OMYfFUeLS9hw07h7lt86osTH0ek8bM/?=
 =?us-ascii?Q?SHv1Jy08Sxv2O0CDcbuIyy/8xTqes0LQUgrwpe+UoF5vv8qJrYJ5KzGOh+PY?=
 =?us-ascii?Q?bhn6ZEdqbGCrU80N9BWmmhFu0CGJoGPlUWro0siILaoMm3vaN1K611iDL9HC?=
 =?us-ascii?Q?jruk7jeqmng4oZ9bRSeybJYwfjzP3hRCyMEwp9xcquMfF0PKUFLrbhaoAODV?=
 =?us-ascii?Q?mJjn8XtT1lFRJwd9YhmquhRr8qNBkS8rDokDYpt1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 941564c4-05e3-45b3-f87b-08dd7be69c1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 06:27:34.8095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KumHtJJfDyrN99hgHsIBvVD2bktncX6gZyraOO7kP+coQPZjZuF/GJYFRzZVIiAV5srA1GxswA71B9DMWAr8kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8004
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, April 15, 2025 3:17 AM
>=20
> In the review for iommu_copy_struct_to_user() helper, Matt pointed out
> that
> a NULL pointer should be rejected prior to dereferencing it:
> https://lore.kernel.org/all/86881827-8E2D-461C-BDA3-
> FA8FD14C343C@nvidia.com
>=20
> And Alok pointed out a typo at the same time:
> https://lore.kernel.org/all/480536af-6830-43ce-a327-
> adbd13dc3f1d@oracle.com
>=20
> Since both issues were copied from iommu_copy_struct_from_user(), fix
> them
> first in the current header.
>=20
> Fixes: e9d36c07bb78 ("iommu: Add iommu_copy_struct_from_user helper")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
