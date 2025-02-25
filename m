Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B8C25EFAE
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740471527; cv=fail; b=kvCp/L3fRgxJW+J64yC4xVHgZN7AVYhr0ckvUmQhQ6KPS9PBfaMbm++sSiQb+QuXtllXYKj/hrpbFhq2gUu8T6GRyTGpFPCDqxENliYn7Duy5QGT66rGrg8iLnrom5IoNmcO2xXhieTVo3IMuzpiYuH4C1QJINT5h3YOj3FX0rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740471527; c=relaxed/simple;
	bh=tUavN5il/ZfI9jCgXXFwMQhX/xjqlAJNmyRF/oFnaFE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uex5Ud1OFwwXrTm9EIi5GpZgGdL8p/63VWOP7o7EOKwD/gM0NeV+fYXMY0scH8uBJuWvCmdSF4F8Vqzlv5s4+kvt/N39jxEUvA5NFR8UZ6F5z82p59zqwwBapkg9xeG7OtYU1t0x/K4ImqLRqXr+74RIkEmcm1fVR08Ljb6US28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i9Mngr3+; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i9Mngr3+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740471526; x=1772007526;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tUavN5il/ZfI9jCgXXFwMQhX/xjqlAJNmyRF/oFnaFE=;
  b=i9Mngr3+cnhPRd61uBqMuHl86ZetlLLAM3sGHRIiw/OGsEIKQfUHbGuv
   6O1sUAeVwN6XSo/BOX2FcFDpC986zjRMi90grU+UiJYKT3vzhaqqUkTC5
   K7jh0oZDu51ZWT+/Q81e/bbYo2TzvJfVvFh9fTUyJzRBMUb9pK3j7+flr
   wBKl+NPhIBf6PhcjThFt8tpFmvSnL5ngKmfE60X52O1uRsbJ9PDAKXoxM
   H/IzgvUeJQAP25KiCoPOUkwrHcM4+Dbk4dNGuyraQOsO3UE5wmy7XVA38
   vqLKacCIxcKK+UbyiJBeQXvz6Aus61u8n3pYktww016L1j1y7X8nT6/ei
   g==;
X-CSE-ConnectionGUID: fp9fxAbjTQS8+Biu5xldfQ==
X-CSE-MsgGUID: 2IQGIYzzRj6FaNwWn+cSEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40451008"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="40451008"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 00:18:45 -0800
X-CSE-ConnectionGUID: +dtSOOAkS0aQkIXFgtTEPQ==
X-CSE-MsgGUID: JKvsXYxYRim+ApVJj069MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="121260401"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 00:18:45 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Feb 2025 00:18:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 00:18:44 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 00:18:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaqeT6DZNPhZEqrTJPszw2F2kC3JotR5A6jJarzpJdWiHcWH4htDzeLCPRTDuMGr8g3ivVL8ilopHt1pfeM0FfWaHOokKxdbQ+7dpWlmmkLomTfy54Ip+Y9y19vPdJjPn7RI4Q6ll3nV6BAxZ8Qo4YM+8UII7GXw0mGbR6kWtSr/Ve5hM7pmfDOg6jTbCql1L6IAHO8weLUgyGc+booNLcrGMXZIfpKa3+Z3c8u4qryR5zVv0ftdShZV5W77WdQ9UoGhJfm6mRGL8eSU4o9/dKNu+Cua55goqaAiAFxergoCjlnaMVNkb7jUlV/rlT0dvsbPdRfMv2zYEaV5tOLNAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUavN5il/ZfI9jCgXXFwMQhX/xjqlAJNmyRF/oFnaFE=;
 b=tIAoTntLAFp9rjLv2qWyK/R6AJjBYDTqxDgjbcN38eCNJD/gzFYJ8W/Ofqn1iIzxFCk1+T8hopotgZEVWwqVLbOBQ5ZAB5ab7xMRQ9PJOLX6pImx+eaEKa317Z4SUSBephujuxL1/KIQqvRXGxwcZXIUcjVvUp9Ljy+nfyU7TUOegQj4AYCh2yT5euWs3iMrK7avZ5hbOQJ+W5EsLfj7ha3sIz4iWUCUvkvkqlX0RIqabRKTKAIpbUHfE45cmZ0qni3e8Fy3KwyAA1gdOZjuMfdaDnotbwRKjh6T+ENTtaxNtn+zwSq83PGmvEcWqlzHHRNJUswaNVKJk6DeM11lQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 08:18:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 08:18:34 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v2 12/12] iommu: Remove iommu_dev_enable/disable_feature()
Thread-Topic: [PATCH v2 12/12] iommu: Remove
 iommu_dev_enable/disable_feature()
Thread-Index: AQHbhntaq4RXSFQx1ECnVeEyboPgkLNXrqww
Date: Tue, 25 Feb 2025 08:18:34 +0000
Message-ID: <BN9PR11MB5276196E69A4D53C0EA3D0368CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-13-baolu.lu@linux.intel.com>
In-Reply-To: <20250224051627.2956304-13-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW3PR11MB4620:EE_
x-ms-office365-filtering-correlation-id: 7ac1e146-c9c8-49a1-09aa-08dd5574ffa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?PzJkG1HJ7cYadIvD/cOthjzBVOE46UZ8EwPoeAMl356Lhxr8VM7SEA9UTcNI?=
 =?us-ascii?Q?ujYQN76YbGZpOeoHEB1Ds9XaW0BV0WIQpX4jjnJ238c77ZaQ8XgNHnwjgXEG?=
 =?us-ascii?Q?ngie8bv3CnBmqzKWBP79/Y5+1d2irBp9dTLmt1mbgI9KSdKrwcSmud4dPllW?=
 =?us-ascii?Q?F1dTlQ/ZciMwo+F4x8eMZOKp15X7cnAe/J7Hw6XZ5Av20/fMqLlw5JtsdqCR?=
 =?us-ascii?Q?greWzkYpm9uIReGC9GmEFpsX4cyyTpLgS22BX5UwombtWvfFCmSokMValmQP?=
 =?us-ascii?Q?T8v0MR0AUH3EGWeB1zey7ZXu86qS/ouc/UaZQ8tBYCNbpWEM+6fNS61pXegO?=
 =?us-ascii?Q?c1wu+vztSSoNgkBTZidcwR0QCxvGMLB1ubq2Qm1XbsCXWFLBq9VcYYU+6EKk?=
 =?us-ascii?Q?sI2vYIQSt7GRO2nZ8GuDvzP4gNDIde9XVjcDtzmRduoHPsuNGeYBO/OR/6TN?=
 =?us-ascii?Q?CgIn50EUACHepnpS5ZlaHxn2vNrBteqhBrxABx4N4XWYeWCcY5HwLz0ExET1?=
 =?us-ascii?Q?vb3Ti7DusjkVE8r4RMRVuL/4atZdfAmynz9mnp8LcOWoM88qJDT8pDXR0kvO?=
 =?us-ascii?Q?myuRP3myjjJe1YbZGaMxbOpJv0dN1ZoXxT58Biy+9Opz0/CqLzREgQ/i4rzi?=
 =?us-ascii?Q?oV6ROdCOCiojnUQxQby4Jan+tEnMteKOhyPwuNslxorV0mNxzsfwjd2wnTOH?=
 =?us-ascii?Q?FHBY3AU3rfu3gzaxyx1n0WZt17fSOfrWfLrJg+wWV/z4NMuHuHhD2ws2QR10?=
 =?us-ascii?Q?UzCbIezmsQILP5TfScXJkbnn/8SlLL71qkTE8CZG0KVANAzcFdZAwqPWS55X?=
 =?us-ascii?Q?bctqhyty5xzqsfil0D96awKRIBIvXFRyxNKGiNvvu3EFp1jUHfL3gq6LeNCw?=
 =?us-ascii?Q?riCk7+GzxHu1QgVubTPYjuQe6+WjZmTSdKKtF5WCz1VPBrE52CmNBpO9V9tG?=
 =?us-ascii?Q?0d4azruGjWVixwJOyTIDWwtOStFJ/1lxvbxJ73rpWmQGY18m2FHNuznBk8/n?=
 =?us-ascii?Q?0xOKPTqSKqkvovfvxPTep6QGRf55FhGwW7KawazvAyxOI2Xv4ZdXgn/8ByEo?=
 =?us-ascii?Q?zhTiS1kONnloJ3rkdB5NPBLaHAhPvxJ10+YJc/RcuQq0nPzHK/ljpfsHpKxc?=
 =?us-ascii?Q?VzHPSmY3t48DL8GvDt8fdshkQf5CKtc8Ny4gUXj9t9c+l6yGVHH83v09pAer?=
 =?us-ascii?Q?sE+ZiOzVdSm91dvl6Td/UxFfhTCGqx5/sHfoMUq9r8lz7akW3VrbHg5FyIJt?=
 =?us-ascii?Q?DLitscOsE9BtBEAku2G7puf7EZGn7q9jDr9HoG7ae7aIeAmDQjRXuhEiZsKQ?=
 =?us-ascii?Q?tJwncqmjqvg0MoHQb/D31FdcrEBxdxkZewZWvaMgi5A+5mL5zfsi38p1JYMT?=
 =?us-ascii?Q?syK4HOCMygnxErhtyGXMmAK1uTIccB9+YvXluRTx8yEFrkAhUEtJ02HBG/0A?=
 =?us-ascii?Q?PyARdRZipHrdD485fn6xbdojJOFYWYWM?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aI60m9xX0VhkSG4d6xFPgCXdvvpECtiJb2g0+NgRxzpGTWPWJk936cmdlgGU?=
 =?us-ascii?Q?JIroLuA6nYgu9Ok0HenlEnVjldufa5r4euxd9hC/Gb5w3E+Yx1ESS9wIwNUJ?=
 =?us-ascii?Q?fsV8sIlXohAD8+gC+11rHuXlm97spV1r6gRoJ/a+477wdtSRmftiDaU/LtiT?=
 =?us-ascii?Q?9MQtLiC6xKGeJnGBfzQyl9hFf6GXyXKZaLn/oiEXAjMiW000ng96+UFvHfhu?=
 =?us-ascii?Q?x3WfZQqL3188VzAkLKec2lLrr8henQXjwwVyvQIpj+Gb/pRmc9bPvOOXZfOC?=
 =?us-ascii?Q?uaTrjwfk2cBLFRBXWIot6jE1ZFBlUMP7Cpg07qcCDLT/8NOREMBNrKYTtNI8?=
 =?us-ascii?Q?B+ELnNbggPRFsuYIlG2ll1pieKy8TDECnm0KJVi/5fRRy3+QuAPtAYYItQqM?=
 =?us-ascii?Q?Sb+dBa1f3NJvwbdy6PL+ZySATaFeGXRyHKj+CGKLNxW302P1WyYN57R9UjYF?=
 =?us-ascii?Q?UADwr2RbU7uyENhM5JJ0lYO1lcSff59ZNYmtvCMYQx3teXt0kqaQ9vrf6tPy?=
 =?us-ascii?Q?lQ7waoXoWwMwgaT8INBm5ORzDRgML2CaIIwe07VjXTnFUUhvt+xMIO1NTSTD?=
 =?us-ascii?Q?9j8MPqYdz7CNhGh0D8nLQAKfIO/uV6Xu/PpldGS3k7S7h1TNOzJhLa0V/k7/?=
 =?us-ascii?Q?rxZWuzQwGQ6fmJU0uTlrklMve9FKX9fdHRy9vbiiEKLlCBM7WPJBQYg7NA82?=
 =?us-ascii?Q?rtlmxFUJ7SC18hAYLlj158tZTfJQpotNabAqhz5PXmCI77Y3CbvBcCYrcxXt?=
 =?us-ascii?Q?nBp++xMT/V8FTHY6cLSCibWmPlpvNbnkjjXUwrcE21FRWDNrurNyemnFaoy1?=
 =?us-ascii?Q?wyb0dLX22BOcNLPD6kHUH+wVsOJ92c2KtYQhsqB2VNv31eq9YtoDjjr1roxq?=
 =?us-ascii?Q?sNDLNUf+1VF/DkosbAIB6+oAxoqY9eRfSFgRXblIjDjLG8BfpYAkKQNKCwCz?=
 =?us-ascii?Q?EFtfgZBHDkO/ZM88gDIZ7SnOQ1W1TF7/Quw8yAbIv2BreO0rkqi9QZAIwmkJ?=
 =?us-ascii?Q?Zfrhwiy+TcA8fD90mmW9rfZ5gTfLVV0jUNFtXHKjZ8WiaofnBLs8BQv1M620?=
 =?us-ascii?Q?dIBG+qqsvdI9bh3Wh/aNFsDOxqTu8DDeb0UPwkOxF1Jrv0SRUviqdPNuwA71?=
 =?us-ascii?Q?NG14xi176FXUwt6y7okQkKxkewojSI2SIiLg6EUtlkyfwkTEhqCKyl4VB7pN?=
 =?us-ascii?Q?Kbe9RdYn44VNwFuflTnUZycqPWhV7IbqHmfyw4jR8AUIXV1AkIdjSeUuz97s?=
 =?us-ascii?Q?vPdM73oyTQcA8D8Bp/cBRGcA5D95msN2OsISoeLrjuMXX3mesZ62GDa2CwIt?=
 =?us-ascii?Q?d71egFTSfQJpVNDOoyT1yb1z3FQ1tXiUiDrUESKuks099n2sSUDekEzp0vRV?=
 =?us-ascii?Q?Fti+0OOe+eJtVtp4jzjF7FT55NorQWhihtQDk43tEP+EKrC3pjzWW327++K/?=
 =?us-ascii?Q?NWuQALY6bO0LRiFrrlZSNYeZap1DyjrmR2PNNxs+03MDHjTT5WVjjinbyt+B?=
 =?us-ascii?Q?RW/5aZeAeW8PVEqJTH/4FvxprQWfERHCpG/a351LXsxEcbCCMwz/Yu3/Wo4a?=
 =?us-ascii?Q?+QiKF9dY7rpJMLzCVxUprGsbj5J4Bx58LpJ/Ecag?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac1e146-c9c8-49a1-09aa-08dd5574ffa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 08:18:34.9431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1xVFkVTPTML34E79a52Qbg8VzYLDH7DEeMS6lHBdQ/GQ7DUvD2u6L96X7Wibd87SqexcTOpjOjXJGFTRrlTdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, February 24, 2025 1:16 PM
>=20
> No external drivers use these interfaces anymore. Furthermore, no existin=
g
> iommu drivers implement anything in the callbacks. Remove them to avoid
> dead code.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
