Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C5D257429
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 07:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740468551; cv=fail; b=Srvlwf/dDWC6xRbUuzNnc0MM4epvRPhZBADu5KoGgcDbDiDC3ZmRhS8tHI+7jgZlvQgpj9irEaAZHiU51fjQ/U7kLxykwBPzpGP08NoUvN5d9vtWJ9csgvVKJzvJRpyetGiRD8TnDG0McEwNYY5aj3ZYbxdbJhvKbNGvxayszWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740468551; c=relaxed/simple;
	bh=VrhesURjDmmVmYs5aDzD4hcKfGQHYssPvW3S1LxTujE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZnTQ1Nxf/s1i2YH8FbVQNdrpbKyvFaYtaVd3iBNByL8F0JNfTlHUbMsvT5qsiertQRlZIlqTJl4AYC2dG+TuZdLh+di0tNVgZwE2PDmxtI0rPxKkmZ14Pc1VAkZ3CwUHKASEmtwIi7MBg0qO140cuPjWtQp/uACjQnoaJvvpI+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HeE8cySV; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HeE8cySV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740468549; x=1772004549;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VrhesURjDmmVmYs5aDzD4hcKfGQHYssPvW3S1LxTujE=;
  b=HeE8cySVH2DH0kvHLR5kHt6tfcnEf/YKSaQkxtFYNeFh5mXw3yvSwrvn
   LpdnCPe2xXIHTSDNBji0E+kbVyAjyV/kOms89dgnpm7fs2KyyvIbTQb28
   Qhole/+mIqCI8i7s1oVgSy8LsMFi3qzjx/aJj070WHPJzJFhNZ4ECpF6C
   ajhMU6/CvHY32x+j51laF+Nof7h2k10o4VGF88eF6/4k03VU25+6cSyfS
   XwvwHebvii6dQTHeEKlQUQ9aX4YRxFAnIHhsSbIjZ4mYfZpLtDlMb18xk
   72WVP5hALtHMK9s6ffIOg+RBBA9JHhF5JgTZlsvI3w3pxCmZTBX5L8tD2
   w==;
X-CSE-ConnectionGUID: bDeiytFwTriiJsOQCXElMA==
X-CSE-MsgGUID: j/qog9vASVeRdP8pCZuHdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="51475332"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="51475332"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 23:29:09 -0800
X-CSE-ConnectionGUID: UjT0yxCuSaywuFRS5dvqow==
X-CSE-MsgGUID: dchhJYj9S2e/nmBPupGaTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121551063"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 23:28:56 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Feb 2025 23:28:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 23:28:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 23:28:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=no5wVsXody4tOh7pl2weqMdk7mK7aZiPfWHHmQquO8kljP8+/W9A6AjuH/F3tQHTsUiuQ3iSIa5y3MNhJTvqfuuaY9b68zwYJ9Psu5IXWvDUUvR87v02+RqdPkjiA+VkqD54e6vypTTnNruppFMc6jb3bHknA6XyCAg3CD2N9K5wE7SOKGwBiHCMXESdVP+GisEuhPC5li+u4RCwdmb0jncCDYmPc4mAMWWpasWFXDD8BWHVGwDu8IzIL/WIJlZ4bK9t4QXXjSfp65LdAPlq9xrm/O/OybWLGqYFkkPwCFyM4+c+RR+gCxm6QAJaL06WzNZukdFg4z4ejrS0ICswiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJ4+TWWFjhnouMIBvp1elpWYCXPh3KudFNFjZMxr2AM=;
 b=zWd99+B0rdusBwMhK35LwwjlclFhjprjyXKdXEaSp6C2rygR6UNcE46ckF8up8ywE5LGzC5zgHMPaOq3KYcr8AY04K2C3YsZpqZgkKtZd+kMMyp4nCxhR82Pxyjws1aOklDSmFS8GaLgqXia8o/BIp+hnOgjNJ/sGskXWUgn+ZbYtt1oqdjK9FDmQIJGY0ilXKWEmbC32r/d5mlU//XLIbXo4bI2X/gRRULbvB5N9RV32wh6xvF1T8ctZv0b48A928w4GDdzscEx9gGfnPZuT45mP9jo9T4RvwC8RV3N/5Nuud1cgh/rSKaeKCVppONsE+C8420s2l0RLxOGEKbKLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7492.namprd11.prod.outlook.com (2603:10b6:806:347::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 07:28:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 07:28:53 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 04/12] iommu/vt-d: Move scalable mode ATS enablement to
 probe path
Thread-Topic: [PATCH v2 04/12] iommu/vt-d: Move scalable mode ATS enablement
 to probe path
Thread-Index: AQHbhntLlKP/fBThT0erqkqYj5VRp7NXn9eA
Date: Tue, 25 Feb 2025 07:28:52 +0000
Message-ID: <BN9PR11MB5276066807236213BCFDD2538CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-5-baolu.lu@linux.intel.com>
In-Reply-To: <20250224051627.2956304-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7492:EE_
x-ms-office365-filtering-correlation-id: de129223-bce9-4426-f7b5-08dd556e0e3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?XTdDU3L6uckH5w/sHrmdowGVYIj4MsJDyEMy9W9mZNSLtm5eVaNbp6Yb/d9w?=
 =?us-ascii?Q?izFiI2KRVXPflAZ8lop7gxcyMk5vJvwwRbDDJ56scDHEnoJgonZQUirG8vHW?=
 =?us-ascii?Q?c4Liyn4VdYRVKjzhhXx7+CDPAPd6LF7nLHVvXvbuIDyg1TjKAIzf1TXrKnX2?=
 =?us-ascii?Q?4Y201POwYcued+t4gGi1IgRB2F7IK6QrLpwx1ECSLuS7v+cu1LEjr0axoOMd?=
 =?us-ascii?Q?CE1BoJsn9Dl/tywMR5fl2AWUhfgQHjsJwwYFBDLyBO01b4FZuuH+7K+dtD95?=
 =?us-ascii?Q?ZvsEU3LKdmSyWAaMjE0mFmBKaZXKb0H4Xgp6JR2Y1w2mnY+67fa6ioHD+FRX?=
 =?us-ascii?Q?UAJ5+VpCufGz0OzuULJ1bvEyyvxfhcCy15TVIMhw9iH81mIEVIC4xWVztBjH?=
 =?us-ascii?Q?snjPf7sYr0MwkMpwpbstxvRKERDXwPpJNOlf1V7yZkhzA/sj07E8t9qNRphF?=
 =?us-ascii?Q?8SbFp/wgMo713M1v7xGiu6tZgb1q/Xwla1JVUPe72sXZv6Ckdrd8AY43cYYK?=
 =?us-ascii?Q?oJcQ2Qp6dYaW1cgZTgMLnbCYF6Uj/NKHkzDaNkqNzu+WCedioNhuOewWhs8K?=
 =?us-ascii?Q?yRkkPRqErtrRKr+yz/RLAVIzw9zMTKM3TrTnGSY7HQIEo8krJKYtCp/YIixk?=
 =?us-ascii?Q?MhOcm/XcO27QtACnlVevAAyPWU8TmRW2RBDQ7H1UDO8I8BvjvfObBCROJ+Rb?=
 =?us-ascii?Q?KUCJN3rZ2T0Zy0BYAFsw2EiOXOdSTsXpY76olQlL9M1gCCy2+4AmnFepgH8f?=
 =?us-ascii?Q?CyiPyEkk61aCeeSN4jYXssSI1jHV6I5IdQVYZFXKL3xKEAbrwtTbcXGcCU5W?=
 =?us-ascii?Q?9UudllSXd8a7CRLjS8doKfOiaFFfAf5opvsAc9EP/XuntTGC81JBt84kQoic?=
 =?us-ascii?Q?3vHHPXMv135W+PEDR8x5H1SI+N61wAADZS3A+Sjks+1Pi2DkteXAeo65AsBv?=
 =?us-ascii?Q?ixjLDE3NoKkV5cf7oSt1M5J7TAGnen78zKXTHAg5ZD3gFRmU7IcI7LbdTsXn?=
 =?us-ascii?Q?auSuriJZwDT8f6iaJQS0BJOEUz2tFGYmfdyFU0dhr5FFct1Jv35ZBbbHVp4l?=
 =?us-ascii?Q?JwWpg8SeTI/v0QPUiqopwELILKW8wsK41Cj6uDC7yXcm5bwaySpvr7V3S5gG?=
 =?us-ascii?Q?TCGIeTBTh5odEjrNbA8+/dexi3IAJSprNZEgOd3193v/0zpzo6/MTaC3ozNI?=
 =?us-ascii?Q?DbPLB9E7V6pN5fCw082qcWQjQHU6wLyZDLOWknnPItBPL0/wWBQIh6qhd8/a?=
 =?us-ascii?Q?GpBlnXLL69KHWK+8oaL8yjXZXH/5nWIoYfSRgCa5iMALVNlYU6pJZvhTps+5?=
 =?us-ascii?Q?m6u2FQqj36+IxC8fHqH5nW3+25/XUJ/yBkXKRgjLivsJ6MU7WOg6aIlK8SOL?=
 =?us-ascii?Q?P8nBUeuBBAOEGJoZL1920PKY74wp1Cm7/KYcjUikWjKn8hXxzVLqoczeTw4d?=
 =?us-ascii?Q?S3HTk3q+OCvhU9yKqysSOTzkZw10tVRH?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t+o63B/Ds4mxX79rNYL2RmCd8fDubjWAnUtAqKJbhEgGCi/w9xXWSox17oVi?=
 =?us-ascii?Q?aTDiNzc1WrwCw+mDaAv5esL0+07ElYmwFfl3/obcczRuGXF/S6MuEjF8dDDU?=
 =?us-ascii?Q?67mdwxtdnVUUI9NoDwUH9U9EnjzoVdH46Pzsz2ZvlY9AixQ1LaouUFrWibmG?=
 =?us-ascii?Q?p10BZZKyjIYhGKHcEPfyokvnZKc7s/NLJoIvLHpz+gyUxO4Lppou8AK0GPte?=
 =?us-ascii?Q?NJhyywtclrkSYmuZhcKPtcnVCpuMhej3dK8Ib882SV4ScMN0y1eHYzdhgNuX?=
 =?us-ascii?Q?GGSgVYEwCkdNeh80rIxQzHYRAKaowUMphXmSzzLaWZOi4E36OPruYWb3uzPn?=
 =?us-ascii?Q?OdjEOWf9Wd2Poff8Xnftg4zQqxTtyv4QR0PL5qF7//XIGSqPlNffFAnwP/yJ?=
 =?us-ascii?Q?40gX8/17S82IIqWkyRBelRNofiBzGIZAG7F0BdaavMQSK478XvEXHguvV4To?=
 =?us-ascii?Q?SCdTioVT1JCOLnHK6BCt3ZwNY6qnW5d5bC5xUQlk+iKOYJSGVmtYyB6N1cjQ?=
 =?us-ascii?Q?vOPD5sPnN8PkIu49Jy9dPvFwyVs9ec98FlOUeInICBxHlunccjUXoYlAa7qB?=
 =?us-ascii?Q?CG3L47NHZcDhylrAy7qLn9TtGpYsmbU3iFKeLstG+VeeYFJ0tlWbTo4VrmSZ?=
 =?us-ascii?Q?EaArAXj8dNB9OBP+iAAhDSp7hdCIkWSvvkliI88Hy0kvWfeTWEYWB6aYWOtk?=
 =?us-ascii?Q?4fowHjn3yBVhgSn2i0qwiEvRyniV7Rv3rzOuoO4phej9zCBxI7NG2AMRYJXH?=
 =?us-ascii?Q?fJ2i+GMRYTEcVYBCbAA6DDrlDzF93kUxL74K8z8juNZ7g+k4VvsW8GAkbsZ2?=
 =?us-ascii?Q?XEFGphU+GEyigUm2uDTGZ3d7L9g8uxarbZYDMGy0ro5sxTYPVWL9q+b0tgB1?=
 =?us-ascii?Q?4SogmnApnIOWZcaIvsad9fzMW+V+a6c/aobFuigVC69JUeSjmoEJAG9YqsWm?=
 =?us-ascii?Q?8oLQi9HpC74eIA+1FxakGgu6ZQL5nOIZKepbt/F1bU5oZOAx95eq4yfEb8e9?=
 =?us-ascii?Q?Jlra91EdmhLN1tyw0k5sQHTKd6pTi1O+Z+IbTdfoboBGB2CVIjxHm1TvKoy6?=
 =?us-ascii?Q?M7cyds93Ypj0g78ygBCuOX34rDJXGU6PoCfoXH8qQgFSk7uqws7LOZ5N9G6V?=
 =?us-ascii?Q?qeV07SJjUoOBACge2K6nxeH4vhJhOEuRNzYLtV7mel0XMT9WB8OnaR+k9yC5?=
 =?us-ascii?Q?5xmFh5Tr9YUxH+UuSPYP3GKOtK20XTAVfqnLzN/BPgqqFSCWd/rWA5xO71Ew?=
 =?us-ascii?Q?PtjqAirKvEmEhABhpZZhy8rzJcbHs5BoQf8200NkfbXvicKpNKnYO99tEJzK?=
 =?us-ascii?Q?eA1wES3ADfJh0vnj0YPDUnst2TfZIh84H/TqPRqbNZlN9t5TFVra8AEjPN9U?=
 =?us-ascii?Q?Br1uHl473q4vzLEfSacwEviddEf1ch9uBePe/aasovTY9LqT7V67KStenWQD?=
 =?us-ascii?Q?GgYui7twgzheEVkZQP3pEciPU7GhbzpZa8Ubj/tDuagSP2Hnrj3aZJ2tEDJl?=
 =?us-ascii?Q?dEhDFEpSSB8emJqNxmd70EAuGTki38s2yZ3unfv6PfBBJzQxMFfmRI4f3CLj?=
 =?us-ascii?Q?nepyr0qJe7w+f3uGu8TgH4BR0BF6HcOm/idllR6y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de129223-bce9-4426-f7b5-08dd556e0e3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 07:28:53.0083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ftpwbU29VMgP7GHWMPXvHqKyGHyrXR+hIQgSA6PEoBUZufb788AeBQmsfzoe1G8HFiiAdutiDpMzcJnoz90rLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7492
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, February 24, 2025 1:16 PM
>=20
> Device ATS is currently enabled when a domain is attached to the device
> and disabled when the domain is detached. This creates a limitation:
> when the IOMMU is operating in scalable mode and IOPF is enabled, the
> device's domain cannot be changed.

I got what this patch does, but not this description. Can you elaborate
about the limitation?

> @@ -1556,12 +1528,22 @@ domain_context_mapping(struct dmar_domain
> *domain, struct device *dev)
>  	struct device_domain_info *info =3D dev_iommu_priv_get(dev);
>  	struct intel_iommu *iommu =3D info->iommu;
>  	u8 bus =3D info->bus, devfn =3D info->devfn;
> +	struct pci_dev *pdev;
> +	int ret;
>=20
>  	if (!dev_is_pci(dev))
>  		return domain_context_mapping_one(domain, iommu, bus,
> devfn);
>=20
> -	return pci_for_each_dma_alias(to_pci_dev(dev),
> -				      domain_context_mapping_cb, domain);
> +	pdev =3D to_pci_dev(dev);
> +	ret =3D pci_for_each_dma_alias(pdev, domain_context_mapping_cb,
> domain);
> +	if (ret)
> +		return ret;
> +
> +	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
> +	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT))
> +		info->ats_enabled =3D 1;
> +
> +	return 0;
>  }

It'd be good to add a note here for why legacy mode still requires
dynamic toggle at attach/detach time. It's not obvious w/o knowing
the story about legacy + identity.

btw the same enabling logic occurs in multiple places. Probably
you can still make a helper for that.

Otherwise,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
