Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5790C2AE8D
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075258; cv=fail; b=O9+kWoPhxt0bc6Ncyx6xYRXmDM4CTINY0S1PjpNjAYv5yM1XyvN80HxNjimMpLKLFFsUmh0pmJ0GslAyfbfYoGj7BLUID8ihJgDO94LDjk6fVKn/yBA5MRV7wvsQAjLQskpwtdtfheMu4mrwTbzPp8Tn0Z1xK1SAE9jBrjdTiAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075258; c=relaxed/simple;
	bh=uOrz6zaSXG0QQuPcTxB0BgjgjQuZltsCfk22yjLTQoY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CdqgHvkcZbfCroObw9SVM3RVvocbx0TEW/K1vfpm5ubTsbxxk+nMzaTTCkAcW6akNT4+OP7G/7vGw3XewsHm9nt9eanfDeyik8s7SVx7GrzGHDiTXGP82GSDRhbG5Sw7/3zNAvdADkUja6Y1yMo8Mq4KfrmtELOfIZlLxjRH2JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAKRFeAd; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAKRFeAd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741075256; x=1772611256;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uOrz6zaSXG0QQuPcTxB0BgjgjQuZltsCfk22yjLTQoY=;
  b=AAKRFeAdOpaakVOKzzC95X7hKwe4vNAkTAx/VbFSsXYQ11RH/RmxX7zz
   V6kkntxQ41Mn68Qu8/2NFSUWexNHmNMbxXFSWkSWvahGZE8RUJU8KzZBe
   CQVaAWavS/hqV0RGHiP1WRlViZ2isahINamna+Zt0WtWSal7xnN22aJrc
   FTdxr+WDVVDu7UeSObwN/LuxM3MaPGYOfV30SAz5WoWypuZ2I98/SscJx
   zCDTlOabspkkIeGdo7CeOgrpGWmc3IXHY9TJcPkUABYcJ2ylMXjlFkOuE
   Zw/LjC4+k8t53ZjVm2yUZg7XP0nLO7lx5b+8wkk4Yd1dxV3sHaD924EC9
   A==;
X-CSE-ConnectionGUID: JnO6t52YSACtnIYlsYePdg==
X-CSE-MsgGUID: ayfHnVdFST2e4DF6hIPvTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41888944"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41888944"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:00:56 -0800
X-CSE-ConnectionGUID: c1lqWORJT9a28rtcbqrRew==
X-CSE-MsgGUID: NJd9KTB8QKeg9eNoOy/uig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118088492"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:00:55 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 00:00:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 00:00:55 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 00:00:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKpm89GCHqO1V7xhbPosbu+zP9ZKWUGwHdniZ10s7Q5zOUhFbAsHyKG62TjVq+WKqjtVqwvXynMVuXcOdxeWDZ1PBfbPsnNUuGlPW7L5OsFaT8M1siTY3cH+Ja9tc1TrczKGPriR9dyvEdgzMdKr4bOkptRVXDyURuZn9PvEOoZmDcXLAHxQp9qHsiTblbWRNYuF8eRY7afuQkh3xPSGvcdfmXzM/SEWIzYl0fekmXpGVgfCWJsUxiN1F57A9xzNb3tTO4KjneJ/IgkeHZoTFmY5JcppytrmrIY3D36tPbgJRa0I55RsjIZjH39RFOACK0jziE6lBdJ0bqY+WFWJcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOrz6zaSXG0QQuPcTxB0BgjgjQuZltsCfk22yjLTQoY=;
 b=mhoWqi+vsPC16jccHIf51KCmGx0CfmEuGvDyV3rwlqx4UpsNmuUc3CVR3ZO6OvCLRwQDgAv+nWujbUMla8hoRv7bL3my2l3GUoOopsBxcMoDs6/mQHEsCFaBiys4G3mP0QiSiodmWhDPaTJnOtNQpX0UIEohpLvPHFBj7EoLjKyn96nuB8XQiGUrYA8Q2HpER0st7+Bl+YhcnJ87oIUH65zBqhNs5y5t4wiXvY+M5beYQjZ9GjsT5gzO3GjWypY2KiHWGEvAgL7mBUbGWSxhM3NXN0cxvpAmhFojOFyfdfkVf8fCHZ0Db6/uVl9GmWc0vSz4q0RCmLnXdejMT56LkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5297.namprd11.prod.outlook.com (2603:10b6:610:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 08:00:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 08:00:36 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>
Subject: RE: [PATCH v8 07/12] iommufd: Enforce PASID-compatible domain for RID
Thread-Topic: [PATCH v8 07/12] iommufd: Enforce PASID-compatible domain for
 RID
Thread-Index: AQHbiENIJSqGaHIu3UGhOZOpzePEorNipmkA
Date: Tue, 4 Mar 2025 08:00:36 +0000
Message-ID: <BN9PR11MB5276F8BE14636D9E6DCC81D28CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-8-yi.l.liu@intel.com>
In-Reply-To: <20250226114032.4591-8-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5297:EE_
x-ms-office365-filtering-correlation-id: f5a40956-9b03-4516-1432-08dd5af2a5ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?fIg1QqFenxwH5FHgXt0JEk5ta7gw3+XgklRzJ2DiRLTmjUQWTgdkQ3HaQk9j?=
 =?us-ascii?Q?P1L7HHVsa3Bjc6rRwg27ISZPqH13bMDY0Gpab9mOKPg43XjgTbkf3Z9Uo/qd?=
 =?us-ascii?Q?cS+AMFaLaxoZhR83kvFQ8D8zcwg1S4GzNS2PoZfbJddBe9dKh9vu3rdveN9l?=
 =?us-ascii?Q?I+KZaEOMiGYi4FdDXsFKSF3DTnFRc8pdVfznw24y1rzKVGgAuFOyI+y+5Km5?=
 =?us-ascii?Q?OjV6KOgBRWGvKROrzt6X13iv5Z1SWkKUTX7gtLgDlCG+RyiZGDT6K2aWJMLH?=
 =?us-ascii?Q?kUw+vaTJ0SST5MWP+xWYokX/KyIEK5NeW0pUabpHyXf5lY6LXh9A3o/jJwvG?=
 =?us-ascii?Q?Ibn943eFWlo+Lq881PAs7m+HWmjpwkj1TyJI48jwfSE0lE+wrXnEVkcTqz2W?=
 =?us-ascii?Q?XzkbRIlL96XAtpQQRQ89UWOR4HNsbZ640nUTpsJKESOir1nm2+glP18jP8WJ?=
 =?us-ascii?Q?uv9ac2RefLwh3j7cE5NARx+zLdnR+aBCky66gNSMJ9uaXzVqrmCZPTp7b7tO?=
 =?us-ascii?Q?EiSrQHFKC39slAzBgTHrEyeS7P5pL7e1C5GSciJ/JdZnYpifXx8Ul3qCt4GF?=
 =?us-ascii?Q?9wxZgOw6HgYh0N+b+oN7plJlBCYpSjDMcxkJNfEfp6MnOrqXlb7Zr+qIER6R?=
 =?us-ascii?Q?UcKQuITTWhrk8B3qccm8Q2XvGQCa/FpgzWhRgsyZfVszhNv09ypGH2b0VDk5?=
 =?us-ascii?Q?XdfTEfbqXFuCViBKcosmMsUHms/wEWNPdVDTHElIY/aGTLXAkUm4l5BMlaGM?=
 =?us-ascii?Q?0/6WHWq93JIr/jwAJUCgEYIkw6hcjkOd94ZkwxbvJ8DCdIMhck0aE9olx6B7?=
 =?us-ascii?Q?WjYZR8jVYi7VXCpsCXgMa17BZrPu0dA7DzZSZPc7C3tDMEeg+YPIYnxnjyww?=
 =?us-ascii?Q?AzXAoqHbeGYlY73ScyTP3BcFYgbAshwnlRivMvMD+ASuUdVblXmvVczqD9fE?=
 =?us-ascii?Q?/uXwswOGIfOE17oI4gV5colutLMMjXPKwzFos9RbDDIurgyHKJjZSOeYYOZQ?=
 =?us-ascii?Q?bwxMwOiVHZPQ6BLVzJbgXXU5nsbf4GbVrTiZtCOfDqR56CneNwu6mPs3THUb?=
 =?us-ascii?Q?fK/E1cl6HjKBGHrQjEzCnAmM+xINuhno80D+62OLV6WAckjuzw1NLqyjK24s?=
 =?us-ascii?Q?VfMicWiAkS+tc/h16Mn2dnz3wUultvpxNJmxn2H/5zIV9wGBCLnUDlwZlGXN?=
 =?us-ascii?Q?nqQ4OaIZ/LQYatGnpd1nEB32qcpMMEiaC/MyldJjy12YcCfOeitI9xgNxyA+?=
 =?us-ascii?Q?c9GhJp8TB+NJp6T8VD9/gcmcLD0alUnL+NMwybaKN2zdn0jEMY1JmG/iRy+9?=
 =?us-ascii?Q?Di/I5iw5hhS5bqXMaCyrewErJ6TI24pIVcKHuVCcxq/Wi4+/qjtiHqOYzDOl?=
 =?us-ascii?Q?6+y2EVipwVzl0MuMqobIcN3uiFMjjSEhlevYnL171z0/bJL6b647B0Up8+RJ?=
 =?us-ascii?Q?lpFOUZUbIkSqO/2ltTgDFKFmJDYrH+0S?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C3dlDZ9fzuxZ+U9tXXmp7cvnKopOMVauAXIxkys68+YklkvQ5Q0qacy4EvAj?=
 =?us-ascii?Q?fTbVkL1NqJujaWL95af8aUIBKUMommMo4EH3bqUzCAHTkEQtwhe541t70yWV?=
 =?us-ascii?Q?dIC/kQulKF9Iu0yKXgCcA+yI0uyGACUuFJid5KMIuen8Xwml+icVBoP+qD/C?=
 =?us-ascii?Q?h7oum06BrCeTW/pZrUEvNHMFv+yEVkJdbDy17pm0m8eQmD5Es1Xxt8lYT5R2?=
 =?us-ascii?Q?BWDAbiVNpwOvJIxkGV/lV+j6NK0bb7DHnBzQXQrSdUtziZtuj6HIeaXexZf7?=
 =?us-ascii?Q?0CVSJZ4RXhTcnOJ5UFbbukWO27+YWWDfZpfmUC37+WOu8l5G5C1icOMuFADS?=
 =?us-ascii?Q?ZfaXMj1uEluJxqN+90/Jx6YACIMwu7UwX1kBrTkDP7MM6vKTLy7Go2K3aLQF?=
 =?us-ascii?Q?EvDpRW/lGphoNuh+cSsCvILm1alqhqdS5rfX8vcFJc7t/+JOI8467F1uT51H?=
 =?us-ascii?Q?EUp2MSjCtyWFF5/AXF7n5KJobU3hE61no9THW493aD2Mx5tY2GFkPS/7JXTk?=
 =?us-ascii?Q?mYLYSPQ/dUjzTys9xZa1Ue296vuCwmGEuuH1iWszT2LrWdz4cCczFRfdmAl+?=
 =?us-ascii?Q?i3beXNElLlvmVtWiwQ4hZ8RSoyMfz4FOQN0qRNbt+Ze7Q3Waz+z9NmqBdRq3?=
 =?us-ascii?Q?VchlJJ9vSkyKsFOBAV7QRQ/DGsbcZNypukHwQYZ+7oE3bIV12H67myhN4PYy?=
 =?us-ascii?Q?S89l4XwO6yc2dZRfZ2Y/1+MqvdLWxYpKMBGe9/N+7hzYixPFHmsf6ZbuprH+?=
 =?us-ascii?Q?tN1o3WdEvKLOCqi2V2qN+yVMgyB8yJauEhdfmE4pltGaC/7swFEGEEEsEAMI?=
 =?us-ascii?Q?h0ayF1WJ21y1I2L34zW3YN2o9jI0w4SdFi1zt+uYoqM5P2ytgh2VyJzNdKTA?=
 =?us-ascii?Q?zaXMNlzOY0dr80UdhG1CGHXRYpNW+MJF6CzX3Mvs0wb2Vrbig0Q2KwLKs6RD?=
 =?us-ascii?Q?Q0sXSO3229uZSeaX+RZ1TQWeDeXIxq7RLrAZBUg/pRD9yNGLYIt8FjpNWZBi?=
 =?us-ascii?Q?M1y0qVCEruUlcav7K4pMqgE3U84Sjy6b/LAfzriht2Cap1m3xkG3kfl5sEcx?=
 =?us-ascii?Q?MHjSvhj3RiRKbeuZAApQGBLr6PrjZEtMoHLMjVNEfQpkvjqdaATrcZIkruFT?=
 =?us-ascii?Q?qwYIMSOPHEWlhhmz/YIRqzSV/vY4K7WTTtAmR62DpIIfTeJ0az+4bnPCbtta?=
 =?us-ascii?Q?K5hj3GNb8X3ur2GhyRcQAw69NYALas4PiG8IfhPJdGvk4obK1fTwrghEgSD3?=
 =?us-ascii?Q?/COt1OK1zxltCyWC2zyXssXfOySHGD6AtDz1R4nT4x0siGX8bkzoSXcR+ofq?=
 =?us-ascii?Q?AiyS4iLEQtKJByeoSd7zcXIXJZF2BIZHce+Uqi0SsnN78yY627j3uPy6AW+U?=
 =?us-ascii?Q?R07D3F3oDZo3hVpB8z8vXDlrr4HUbWUwlu+ANuWoZwiP/SWVOB/P964xiMTv?=
 =?us-ascii?Q?h8eldEp6jLWSg0RQz75FTAAZXrIxvmiroC/rMhRnd+43JV25lFkSbpNvcROu?=
 =?us-ascii?Q?9GhO9sm+xvbzFgFV0PD7bHHdF6DFH5IputOUM88SPCha+S1klhzIMZdeD1v0?=
 =?us-ascii?Q?brTXeU+rCksHf6oSqVWke33r9OPgwyVEKq5I1smc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a40956-9b03-4516-1432-08dd5af2a5ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 08:00:36.3955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QR14R1J9umCFmfraVNcMhHfCnY09By0TPOdgoZiFs1mjZSvkS6oulmZ4kSILzZmMJAUKKw6jdY1mqtaxTJ+xXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5297
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Wednesday, February 26, 2025 7:40 PM
>=20
> Per the definition of IOMMU_HWPT_ALLOC_PASID, iommufd needs to
> enforce
> the RID to use PASID-compatible domain if PASID has been attached, and
> vice versa. The PASID path has already enforced it. This adds the
> enforcement in the RID path.
>=20
> This enforcement requires a lock across the RID and PASID attach path,
> the idev->igroup->lock is used as both the RID and the PASID path holds
> it.
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
