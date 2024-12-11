Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220471E9B2A
	for <iommu@lists.linux.dev>; Wed, 11 Dec 2024 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907555; cv=fail; b=Xqi8j4jeXLgqlpqgvH3/+D/iFsetAdSL/xO435HULP4VqsG3vegMYwWzl3y+3EbCQel/Q1kM+tgr9n4eNUxJvWzhlugYnXDmp8be0FI3hX2HbRciRqJNw+5vTdbHwfPbTv5NAVyJQZ1a2XCMxfYXhTycoMqOYftmKMH+LnWUmXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907555; c=relaxed/simple;
	bh=9AyAEPEE+1B0+zSm6N0NZ0zaMuW6D5mONzpy+APi77A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mCU6e5S+mhTcGdxdlqrxAnRUvyf21fkeK9hKN4V3FhtZS/YhU8K1/YM0E4zKnYRgoI4KzVffI9KZzS17t5fknrETn3msnYq4hJz49BxKLi/KMuF+LxApivZTtXKCg7LjsbdoEbwOeA5IHsDh4K6Oaa+ZD0wVBogcYnF9taTaV/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HHjIQJUR; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HHjIQJUR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733907553; x=1765443553;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9AyAEPEE+1B0+zSm6N0NZ0zaMuW6D5mONzpy+APi77A=;
  b=HHjIQJURQgQWqAWCOR1X9Vf16SVvlbVIfQCC1sKBvxHo0SU33qhxBY3+
   gXAXwobatOVMLyhO7va1+LCQJNzcPoCmWqJGXQIO60E96c0uo7bQ7Ty17
   XMprvZc4voZpM6GQFWw1QlbtI0X4TQedW1p0DtMIBAiktUxaMe2O+rKLv
   99h7Jx8W5orYFpObi7jIyWAum1ZBrXZjuSGw8QS6jyhVyRQz8VmTrskNw
   61Jsq7l2DFzuCqRC/UDA/po4AYYjOanlI051R+OwLyONBuRettsh1V3i+
   WPXVRvvVPQ8GEEp7ICPoXJMripi4al0KgGpSIGZR1T5xVfJfwygiKeeH/
   A==;
X-CSE-ConnectionGUID: mAARZGp2RrmLdq5HZeR2mw==
X-CSE-MsgGUID: ZK7Z8mgOR3WztZyD+DX0+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34009214"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="34009214"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 00:59:13 -0800
X-CSE-ConnectionGUID: joMQNrQIT9a819zOM1M/lw==
X-CSE-MsgGUID: SJqTGpuGTDapmSInCs1KJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96173172"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 00:59:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 00:59:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Dec 2024 00:59:12 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 00:59:11 -0800
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6492.namprd11.prod.outlook.com (2603:10b6:208:3a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 08:59:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 08:59:00 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH] iommufd: Deal with IOMMU_HWPT_FAULT_ID_VALID in iommufd
 core
Thread-Topic: [PATCH] iommufd: Deal with IOMMU_HWPT_FAULT_ID_VALID in iommufd
 core
Thread-Index: AQHbSJ+9LtYPJ7zXa0Ch7XYZAnHxYLLgxH9g
Date: Wed, 11 Dec 2024 08:59:00 +0000
Message-ID: <BN9PR11MB5276ED922E3788ED09BFA9268C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241207120108.5640-1-yi.l.liu@intel.com>
In-Reply-To: <20241207120108.5640-1-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6492:EE_
x-ms-office365-filtering-correlation-id: f4136da7-18c2-494a-3c22-08dd19c20dc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JPRxgISUF9PMH+2tul4i0J71MOa6jJKtup45aZE9tovfDPkYgNBdyrA95eA8?=
 =?us-ascii?Q?HaLZ0kN2pcjHqxO5i5DkdF/VNSVgOZpRVcN+hS1lS65Mhgxc1XsO2umO9xjh?=
 =?us-ascii?Q?BZOX7xhdp1KQ523t/LZLG8G2GB4cMMrp3qZG597M7sFP7tUKOemhtsX8ODWv?=
 =?us-ascii?Q?iQrOxgP8mIDb20wrx/2+fGIgHXtm79kOcFfE1cOrEuuj00YkgNpCyCGwjhVi?=
 =?us-ascii?Q?PqCsNvi/48t/7cCr09FQBk6YMBKilq6usJNWK1m2/QpADLMeNQFfzmEIq6Z7?=
 =?us-ascii?Q?PG8uLC2PBoYIDrElpcd5aHEJI/NY0uPaf8W69RNEmIpRtPdu+CAdxThhxhIS?=
 =?us-ascii?Q?Bo0xv+YVqYVFFrDwMJo9YmjkJwGkXVeDYMZwiZCeh0OKZYpTwZakl2P5z7s7?=
 =?us-ascii?Q?qOImRj7gKHuOFPvxpvl1mQKAERMWz2Py95IXEVHrEiojM2GYdnIJ0wmQqg9U?=
 =?us-ascii?Q?UtwEmN7dJc+arS+uL5o0Ouqa7VgJdV58sJ1dCgG9AzkZNkuKnqS/cphv0+F1?=
 =?us-ascii?Q?jo+0VhzlZY5xnmSJKH38BHoqjF6C1rUbllgxgPSCqk+R8paMVlr8iKU5nk4i?=
 =?us-ascii?Q?C3VOtjBfvUamuXLlcS6odNCHRG0rpHGoWrgfyvtDLRUIhg0GPQyehDrDpd1D?=
 =?us-ascii?Q?snbfyyiY2HL9OWW+LiOXO4tRh+lK/wZ5Z6HoXuoV5bMeGYq6nm0Oxv+Qhc7k?=
 =?us-ascii?Q?BmAlgdTQXmmmbpNnzLfXpXOERSdExLkWsae60T+L2I7NDmkt1Lzw1njeZV0y?=
 =?us-ascii?Q?okDzdiofhoeRrxyqEZ0Hz1Xko0hr4ln5gO32Myhvf2G+VsQehiviah4KBVED?=
 =?us-ascii?Q?pgMkhkQaOnERILf22GI0UWK0YQzRyPXVe+XJdi6nPgCyg1W/mME006geCsCj?=
 =?us-ascii?Q?Ur2ivq7EGfu5Ce0BczaWJlFPToEQxuZe0MGtKA3+MsM/57w0JZW6fxdfOKOU?=
 =?us-ascii?Q?kXeO1aeu+5Z3xkV96BSG/9jNxp67ueCx4BstTzHUF/qXcN3ocFTKto3RHT0K?=
 =?us-ascii?Q?2Drmz32mKnmV5xubs2GYlEjyjOGIVP31kEpd9yoI8fXGvw2dQ/1rjfPANNu+?=
 =?us-ascii?Q?yLV/W3KxeGG+SoYpHXK+izaY0d+qZXeEFMhyneRgPcXlYtCNUrw1T7ulPzpv?=
 =?us-ascii?Q?5fp2ktQE9CAkWYK8O09uG03hr9XsDloeW2P9gSHoQNvI9HFVG8Kf/asd4hzu?=
 =?us-ascii?Q?G/NmNQudKuoQ8gQ58G90TsoPoVJSLJwTbtnwR+TMmWxRQiIWJdNrtgQY3n70?=
 =?us-ascii?Q?lFHCJ8jRWM2AAb5t616BDztn4elxIzUz42mQUX7G5xFRCI4MeFqctXgviFNx?=
 =?us-ascii?Q?xMtEvrKzGmTWhl7XNBzq9X6upMoU7YLnaBRPaGHwe59889yDT+zHDGJN4D0t?=
 =?us-ascii?Q?pkD/kzldu1O2lvf+l404vNcaKr6j0klH+tfrCpQ4Y6+2ojlkUw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nomLYsKLVxDxfA2Wcs+8qyizty2M6K4LKdneEKSLO1Da44SFKD1Ngk9SDCn+?=
 =?us-ascii?Q?/BO+yRc4uzoLWgtPwDalnFnNhgIUxftCkBVD7ysSj/qFk/l/NtA2REi72gFx?=
 =?us-ascii?Q?IfnCxtUMnI7q0w812K1UdHcCQdKV+PwvUrP/YoQ1jZ8CqyQdtwRHodUAimdG?=
 =?us-ascii?Q?XzcUgm4VI2b8ByakjAJXVwsLX78HU93BYRAhnB3IQoEnIoUkpr3OKsTJ89H1?=
 =?us-ascii?Q?hdSnifT7kX5fF4t8dRYsDVbRU7w0s4WyjP2Cv3ODdSjGvPRMlvW01Yma/SW/?=
 =?us-ascii?Q?zcUNf50V+LwiewZumWB1rhhC1dQNp9nVFsDc/BBh604nU7Pw2C/IAk58Vvfj?=
 =?us-ascii?Q?Wu1PICUt9c73DdVVvuqyIvcJSoCFbZXYL5olokoJjsKprfwvwI7vtK4gO3l5?=
 =?us-ascii?Q?f0JPdvh7pBb7t73cToM6jyeHWw5wcAAPtYMbBMs6Q/7gC/5xKz56QItpCZah?=
 =?us-ascii?Q?dRnxRmgNEujFHLXgbAgfymsp6NecSBqcycSDdVGUPgL7Zrj2s+5q9hOmKCRG?=
 =?us-ascii?Q?wHervDRNxYVi6AVbX6t0vQI8h6vhH8/dBdvGB7/BfzeDjHhROMSayeO9BBBs?=
 =?us-ascii?Q?Hu8Y5fQuuO2CyKtWc2QKh135pRQphjLa6dxRHIjV5meJg6ZdxXAQIBkluQxt?=
 =?us-ascii?Q?4f5ZlGsx99/shQ1LGy2Hw8czYebxoXzsozgoAZkhDLPKyBYwejGtea6XQ7Xz?=
 =?us-ascii?Q?EqdId7/NL4WcquyTOF66JUbzygTlcoMWzTQ56YnyoRZWG35iYISRaA6AVvKa?=
 =?us-ascii?Q?k/i2nfHrjlgVUT0OsYrCTaR4aIoR8kUbNvm0e9ARGDVexm4Y8OolNgy45Va7?=
 =?us-ascii?Q?3FCxwTZou3Owu0RuSu1zIxNURGzcsk0c7vJlxNX+lxUeUmE+uVxl+ITvqSFQ?=
 =?us-ascii?Q?vkHH3jKGkXoHy+Ls7p/ch1cLuf6FNlFBjbtdYBZWymW2c205df+HIpk0wVzX?=
 =?us-ascii?Q?IhEQFK7/HwMa0A19Hr6bBGEaSOckbaOuc3nLBCGP8TH7dybAbvBwFz+z7dlK?=
 =?us-ascii?Q?OepBZPll1f+fTTSR5SVMnsoNZyamj+Chodf1xfEYO3iVw4U9rEa7CqHIURFF?=
 =?us-ascii?Q?OY8xdOO3nGXFZxvO4YPjN16l7amHQWcEYzIewivrBo3yqwdbSvLHECVrodPu?=
 =?us-ascii?Q?R7LqE6fCjzwODr8FfkDnzxxVxZxYDTOGx/jtIlmo1KtcBnkt+4fXqcRbOYTu?=
 =?us-ascii?Q?gWBKMW0DdXm/CCX7BWym6f3js3D0EQAwIFuihS5k81qK7IZcigvTPyhVCx+R?=
 =?us-ascii?Q?jzOOuG2Uk0zWFciFerMSIkSHV3xMUwvthylitIqaIdZuystmGzS+g8CfMd60?=
 =?us-ascii?Q?r+8DVLwLDyNrjs0qMpVDvohI5HJY1xYNa54qh/F52Y/opwKsBfk8LDvJZRBQ?=
 =?us-ascii?Q?2dHmAx38x8bMuVtH2kIfEVuNfxQagCIsg/qTUr+YUIIVwwtczYvafLpf21No?=
 =?us-ascii?Q?MzsoXLkU8u1E6d2aLc+qB6m+ADQKDEwDUxumqmkLKm8qshuifygQpj2di+SL?=
 =?us-ascii?Q?5DI8oiFLX2500iUOHL1pmoII4iKRaM5RJpmj1YumVt/Bm64tZZEkXPOhJM2I?=
 =?us-ascii?Q?/XpSWT57hKpyKSmKWU3Rs9hMj4FK9BfqfoGOeYYm?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lX7H2uDVTDXQzxLpnSEg0BN5cCjI+Y4yv9yRaP6Ty+I58odTmCBM+6ngZ3C+hAZBUDu9RkzxzGTX37hDJSQVm42EexDl5haJ3glC85JoZj/HBr77X57N3NbczihQBbpmNyF6Y/VzvYc4OaTmCyA99KJXbcTtIBnYl21pScy3fJliCIy3+Grk17aNmB9cD7TdHksWFu7ZTVSpgNV/1ftAfAuPftma2wlnRJgNb78E5OJUAkfuSM0OnqNJszlGFhnm/YMG2EeEiYFIDnlB/GKmdnqBQEH5GQuyUxFo9F4ZNH3oeFVg9uGC2BVVU8f0VPH7OkBZeEI9ZfXz4Yv+yQKKyA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kNGuclYpvJpD+IwJuu/L0NIOvKvBugRaj9ph8h1SL8=;
 b=xoBVY5hm27K3zP6XPdtHfhQTEvWsQFx0CJruwSbxb7oMEX0jbLED1bGGPJNBUZp1VixISfRuW/L0oD1+lpS0tEIfm+8f/RzCDNWVqbb9/6Pv5OPjBFmBQHm55DWs5uFPspjL3Spown5/7NfZEr9//F6zN19UeBmiViMf7UW00/vGuHwXPiZ/WKxXYwBbksrN27iFlw5bfI0PT5zpyHubv8cSVO8/+48pnQP/9OIsmbgMGr2m+gbC1WuxsagMwwPK8vxzOvCpBnvtTOXQvOLl/Lhv+pJq6g6Zkrm2FxZcEnJI7osVCvPkmIpsqiKnQjALN3Bru6wBV3O3kkfamZMjpA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BN9PR11MB5276.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: f4136da7-18c2-494a-3c22-08dd19c20dc8
x-ms-exchange-crosstenant-originalarrivaltime: 11 Dec 2024 08:59:00.1970 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: oNvnU5fkr8eGocbDd3njBqghX3470JktDSdYHC0ChYqgnQshXdatAQFh+elFyGtDVRNa6DLlVxkUD/YBxt++dw==
x-ms-exchange-transport-crosstenantheadersstamped: IA1PR11MB6492
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
> Sent: Saturday, December 7, 2024 8:01 PM
>
> IOMMU_HWPT_FAULT_ID_VALID is used to mark if the fault_id field of
> iommu_hwp_alloc is valid or not. As the fault_id field is handled in
> the iommufd core, so it makes sense to sanitize the
> IOMMU_HWPT_FAULT_ID_VALID flag in the iommufd core, and mask it out
> before passing the user flags to the iommu drivers.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
