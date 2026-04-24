Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87D3246788
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777012274; cv=fail; b=hoB3yOliY5x4MwEKbAMMNVC1FAnpIESs5lBj+bIwag9/PH+I+gg6qI887OzlUgI8xElANY/LuN1qooflfjZsyfYAetXafxnBdyYIRWsHu8wUvpcypXI2IBuaWwH6TmSoSte2fddbOngx0Yj6/F/FxrJ22rRBRjEMzWxJzidE25s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777012274; c=relaxed/simple;
	bh=9q8xJKkVncBJp8ev7xKgaOuKxHjYaFW+BeYXD2HiX0s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WncGKPiFNSn1BQpQWLaR25eIZ4S0c+QG1oRbbc96DiMDBj80EoCejB3jKg46jzBxGWEvVQd5EpjVReu3RsdBqhCMDqxGxm7siv6TdDN5LLX2TLh1dXUyeFZMsI4CF7CVtaBeHuIJwmkO1PAeri1ddIiK8t2umYC5uwUCVgVOxiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UsTXweYQ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UsTXweYQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777012273; x=1808548273;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9q8xJKkVncBJp8ev7xKgaOuKxHjYaFW+BeYXD2HiX0s=;
  b=UsTXweYQ/aX5cJgt2vGqg3+qj2NYaGmNyusD/elC3EV5SSH6c2iFBMts
   daoFvI0LLjyvDyAMf+4Vrm2WDEVDZU2ObXeUKEhZyBcveqRxXn3UikfRA
   350PRciIN9ZYXLcou1sVkEZliTKpvwVeTD6+y5xZL591WT8gn9SkKwZFd
   z4EcaRmOZRFNpUgCg51eVyz/9OPcdGnpMQXfw3gQ8rV4n0R4wHvqKdwAT
   zUJyJd1orjltDkq8VEBWlw42TiJqQMhbFnNHBcWAXZZhN1mfh3lInRMox
   IV6jwDDDNo/HmQPlz+DRVHc7aRPE3ihanYONq37bVqB70QoDmPkm4OHyu
   w==;
X-CSE-ConnectionGUID: cMy5vKpKTLSYPtNes1+N/Q==
X-CSE-MsgGUID: vAHZFl4pT/mm41VDl2vLgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="89073068"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="89073068"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 23:31:07 -0700
X-CSE-ConnectionGUID: 94HHUbxSSqm77H2iiEJERg==
X-CSE-MsgGUID: lpDPjhCVS6iOukix+kgWMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="230206030"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 23:31:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 23:31:05 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 23:31:05 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 23:31:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yq/U/wfFtf3Bhrc2NnKzQdPSfowFYA5K58j1f18jTIG2sNhTGsJvt0+Oy6PqNhEdgDAs3iJ5J5BmesBuKQxoLkdBHINMYM73iln4W23iyoCK3Kl6wxDsXuGznOeJnRwLA1fKRG8ydSV47Q9729IfK/qR0f+xEVtVRWWVifUo3oZOk2Qz0jWqEdglx7OICGOojngvkVFNgcdF44h4J7StWufthn7H6w1oeBzN9m3vrvpIER4euF8I9coRg09xJ2fvFyLWaOg2oCSvAhqKnaY6IzsPWviRJ7y9QAQVljrThgA4sNvpEB4vkGD+1clrmCoaVBbxcH8DO2nKD7nLaqdhfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9q8xJKkVncBJp8ev7xKgaOuKxHjYaFW+BeYXD2HiX0s=;
 b=AeMgfbLGeTxoF4kdApl3LWn4jFTZt6ledo4bbvDjhLGn+afawgHZ+0TzwVoqadUa3uPWaLg8X1vg/qEH5jBFhvaIvzOkSzY+OsioCz2nOzQl4hasAqr7AHuxtJnDRDb83WtCi194s/nAl3TMj87CkEJ+xFMAR6OtrUo7cfzTYJrC+bOMGcaCMGAn68QGVsNbEyLXIWEvCRqW0S/IhFP+32NwPqIpTSC+h4ddEjQvNvIzs+2hqJmLN+U0XzaFf0QVKewQfLaiWKp4MB1qnRHLTvefJG/uh9Z9BPD933SidMlJV+gSsBusX4k8DwfhG0Vvoyh47E/PGqeA/VDhI2FH9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4755.namprd11.prod.outlook.com (2603:10b6:5:2ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 06:31:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9846.016; Fri, 24 Apr 2026
 06:31:01 +0000
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
Thread-Index: AQHczFOuuqfc0SHbYUui55qaSnKQFbXhSYCQgAKI2gCABvQEUIAAhAiAgAEBYDCAAHzPAIABBoaw
Date: Fri, 24 Apr 2026 06:31:01 +0000
Message-ID: <BN9PR11MB5276324C5D7CA8297A8E83378C2B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
 <20260414211412.2729-2-jacob.pan@linux.microsoft.com>
 <BL1PR11MB52710F2441FB52E2D94D37868C232@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260417145946.00004418@linux.microsoft.com>
 <BN9PR11MB5276DB15491F949DA7D8F0A78C2D2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260422160315.GL3199414@nvidia.com>
 <BN9PR11MB5276317325A185589BB76F118C2A2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260423145108.GM3199414@nvidia.com>
In-Reply-To: <20260423145108.GM3199414@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4755:EE_
x-ms-office365-filtering-correlation-id: 1bbfb85b-0811-4b00-857f-08dea1cb0deb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: a7UwwsHH/yMk96uw6D8Tc4EM0PVHZeCbb7kxWq+QK5ecV6lgjt0bJUjuC3JOJkEq/Px/mEmRkZSsM1JEDxKs03mDHYpqmHpl9RUuXZ273M55zeiNodi707D1fIUDaC47KNg8h7Rpn2xEeuV760ogNhBX2/4ig+TWOoRzFKPwjtkU5zexIlYbLrzWW9fepDCWS2aU0yhBHXAD+BONP6FZlUjeuWQ/YgjjN56VenbPpQzJV5+7H7AEEao6vDXVq4jy4LpadXKNOzqf+N7WdR07n+L5trM85YYtnblMnd1gjtHUqFPQWrcXpfyooyMqGJ7Ogrq+vc4CqmTuzqOI3jPnGveBVGcBr1XZnxKAEAjwaAyr1w6qfCIO1tz3CygYRm5GDeBioCt1qYVQP+Iegi+7xzdEoy6DVinRn3GWR7lTLnMVywFFwT1Bri8g+drJNCwTGNZrxgKHFIwUpeTj6e8CuzRI5cFNE6FsT9zItnrPVyBb8m2YiAwHK0Q4laSAuMefVGYQEBkhfmSwLmsqm7sUVzBun4CMnhjv04accrdEcFrV+1EebAzAysWQO7UzT2cXKFt+CHGMr8wkYMNU+Kcy2ORzhPuFlouliQ0d9qF06XTsAz/rdJQkwycybZu7KKzrBmDhInMPPWHa6bQ/0pvVQQe3CPvy6j66Y1RjTORwXG5ty8aAE80sR/2wpsA+iXvBVA+aryMEn8GrC3zcdxFu1+rWeHRs5wMKVpCq0NCS5HnjgFerGSgZpKL/+2fjaXp5M065r664nzSeavRSJrwLrGzCzy1/PvLCJsRPqCjufTo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LkBOyQCljWeZ4G5b864ExppmVg/Au+R8Gbd6hyTmhttZiRnthqo6E62tWLZj?=
 =?us-ascii?Q?qTNuLlTZOG6X22d00YPx9VA/YArUnYgJ3ERusuKBGv/NgTGVW0Ee+XA4qvRs?=
 =?us-ascii?Q?jjBzUlRZ/heL/UNzsHhZz54vyRY/qut730w23Hpti/W5y28YrzsO6nW/xvjL?=
 =?us-ascii?Q?+TgtGFhbWdGKkAAcXJ1gREWvL5q0fmAnb18mZkJ8LMSi56LBGt3UBR3V7JjO?=
 =?us-ascii?Q?gHKMy41HimxLS1fVtl+opahOPLy299+teqhersFlfZKqrEdmKsRSH2hxqtDR?=
 =?us-ascii?Q?RnTVNRDgd72WFqzm4+946TP6CVY62e0gj6vrWh1R9auTh21X6gSDP+QeJwJO?=
 =?us-ascii?Q?KrjtZBUNqkJbh5K+85vRW67LYFkqvZf9qQlHjZ5UWMTC0OlJW5GybVkz5LfV?=
 =?us-ascii?Q?DD8C7G1MQV+Pbe4La085/YyzyeI9/JI0wkAxGHo9D5pH+nCC+9mxcz+naMMp?=
 =?us-ascii?Q?sMyMeDOZdE25gZDEO/CJ+RUOs7kcshHLwPfhkq8vd8XYQfroW+1ul0B0RdId?=
 =?us-ascii?Q?f6i95gqwLkJUapJ9F7QiYKcP/r9dmhFWipn//rKitUyCOS7A0dTGOQYGI0O1?=
 =?us-ascii?Q?+EyBJCsfGlHh7x6iOtKlAbqSGiiAJWMpyOdYAaUkOsD0sB9+Ku4S8vxoeu37?=
 =?us-ascii?Q?BbSlJgZAYXJyD6Rv9UFbN2i5xJkMwtXhlfw2cgtnDMZRjolMes/kZwTVBuGQ?=
 =?us-ascii?Q?6QdcRJemDSvOXabCguGBXUjVvJPzdpYbH/CuqivE81UcJ9fLIxIyWMo2IGUN?=
 =?us-ascii?Q?jidZ6AEarMgRwvfdpXa1sHNpixN3xrNrSkwE1oLV4+NEE2D6HcE0i6KxmX1u?=
 =?us-ascii?Q?7zm95TPU9Px2akKfFim/AmiQv1iEHzGcyQCCzUZLQ36Q5zYMjTCq7KthJkUw?=
 =?us-ascii?Q?Q9ySFStYH8VHTgzOaIwlyof4MgC0L2GSVNZDTupfYO5hWqSEfn3ljakoGZ1U?=
 =?us-ascii?Q?unKSOET087YaBPSTCxWqYF0JSLayhUr1LRV2kIAo+o7LF/7rbDB7KBM1gwfi?=
 =?us-ascii?Q?jwMh4Dan445sShdHFR9K1s21LlZuUGqSTFzEt0UJNLO+BZts+rety57gzXAS?=
 =?us-ascii?Q?4fTOGkgTXvDJ1Ru5AmR06esE/yg2K4RMlgf22CKnqUXI27mlN3chqDE1u193?=
 =?us-ascii?Q?ZGVyCz+SfLXO8dukKIxtOJSc7YNOdQ2ul5RQ6ZpjMTcpvztiKLtnIFjGMczR?=
 =?us-ascii?Q?m+1S7/PGwvp9sbPZ4n8oazmKWdAIrq/45PofgwoAtvqAU28WcaKY42sWeeek?=
 =?us-ascii?Q?isJluWUHhrIsz4Gd/NIc3aLsCbDq/YtXPYvbunSNW14E2ZgFszETc71DvT1X?=
 =?us-ascii?Q?y7tUy6itGIA1uGKPSGqxkW/tnS7JstOL8SyxL5Rmvy8TYLM+gBBbbvN/p96z?=
 =?us-ascii?Q?TZYdPBWUCkznj+BglG8C8yWECuYdjRNdqFNCWMY+9kcBpENzyfULgRJD2J9y?=
 =?us-ascii?Q?zUvU/rx1qJoJJ0zkeQ+qtYGpABsrb+yXTcpMI7pWo3t6Cuz0Lz/owbQTsezW?=
 =?us-ascii?Q?wSjoy4JW1fK9sIcfLDO1OHzj9Ipunfkuwqan4FQiHfG+orhl5E0thITE3FhI?=
 =?us-ascii?Q?AnUdMu5mmO+zxiXCOzdOUYsta5dc8/Vj2OArv2qk0f6M10metz48RAjyQDqi?=
 =?us-ascii?Q?QVNsbFBuFzcxtvaWwkgoy4eRqvbGdBaXuBDY0GyeSwjGDTaI5VXWMnyX20i6?=
 =?us-ascii?Q?BbJnx33t7U0OU1qswjgTTpDHr1w8Ly309igcBn/kVRKGJRhV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: L2Mxh+VKkdsEejzdOYLApqQWV85qRzI8jNFqH8LlcoP/lhDp5s03oAv7N/8HHKeZxjEBNDNBSdW42xkThRBb6F4e3EeHnNkiHBh8tGNLEPH2gaLrqzs60BA/cP0+6RDAU+WmjJxsJZmrZaG2aws46m9ZR+IBIKmMwD2woXr0q8OOfdoK1ULjbHXxDw+Hcu1CaBJjeEQClOhrz8/21yh7vbd4g83o3fKRS0bUgEuaBv23oCNgRKCks+9P3/N8fHqtsASGG8rtgqffi1ctzZ7B5igcoBzrD82NUeAmxhznW6jLOImiQ9/I4KBgiVuvbJr6ttow12dys7GvuyW3IewueQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbfb85b-0811-4b00-857f-08dea1cb0deb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 06:31:01.6753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 50sBIClbyRUxz0DFinEwBsuAjH6ASaj/eeg45FzsJGFG6/h14s0svAJ1tdR6QfgQl3RTkuJJ0XG9Q6ybbVJ6bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4755
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, April 23, 2026 10:51 PM
>=20
> On Thu, Apr 23, 2026 at 07:26:49AM +0000, Tian, Kevin wrote:
>=20
> > I meant to avoid mentioning selftest like below:
> >
> > + * AMDV1 is used as a dummy page table for no-IOMMU mode, similar to
> the
> > + * iommufd selftest mock page table.
> >
> > "similar to" is not helpful here, and is now not the fact any more.
>=20
> The mock page table is still amdv1, just a little different flavour of
> it :)
>=20

ah, you are right.
