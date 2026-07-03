Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8287013D539
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060837; cv=fail; b=QGjN86MAZAmpRMwoo4ZjpZBKO2OfoRUc1+3z3ZUhKBY8a6ofX47EsVk9TAINP2WSBpca6qIq4iV7yi6carqmZcYrKBHNzgwHcNPBx/nenT5nJSOKJ+wKquxFyin++ErdkJQowe+8KxvNiH+yfZP/jeOD3DnT99sjNEG2xSGBFL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060837; c=relaxed/simple;
	bh=hYC85Sc1wOVbrWB+ZzBaO/ww8jNiw8qbRAYVyp/UoG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vr4CEvij4puO/HphNrjqisVWnsE6EUs5bsHVnRFXIAf3FWKyhzRuehOStpyTzIpsP8tSsdWJC0SS2D5RN6QEsEzw2tXQHz0rBlxTm6rZNG1bznbrXw7tBdBlufLH7Iljt+jJOzSgjUY7d4gMl39qEXMmhc2nzHipkCuhcn4lOds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDRZAE4V; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDRZAE4V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783060835; x=1814596835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hYC85Sc1wOVbrWB+ZzBaO/ww8jNiw8qbRAYVyp/UoG4=;
  b=MDRZAE4VTn6BKf+dGTZq3534FrH9diKygzvoAY4cHW1DjBcoK+d7xjD1
   M496KkXcNIfqjeIu3SIN8mXW6ZorrNDN/heFi1TVIVSdqqUjGQgxyLT+Q
   J15DJhQqjhmBVwRljp0ws5eeWp2GpYkxqTianNNnseA0zcB9sKpes0xqU
   zVjUkOC0p4AH+JrAA0dwln4tuqkiHe6mEFC2s+ybI7cfGfar8+stVBnak
   tmbtwBqEtDBDVrkTp7uBTb62/0R+BVp0zj2dALoTluCrv0McoAr9tfERG
   rHtquSd7WhEVbczf2kyDLmTOvznDBGe8l5yHh/jTHeRN2g+NKl92qHTLR
   g==;
X-CSE-ConnectionGUID: HjrHmv/vQniU4TLWySPD1g==
X-CSE-MsgGUID: qQA6vvc5SnChqVDhg03KGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83676870"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83676870"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 23:40:33 -0700
X-CSE-ConnectionGUID: /gCVK5zRRCa24xuyGniU7Q==
X-CSE-MsgGUID: 6exu86C8Snm9lwJv7zDA1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="248586776"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 23:40:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 23:40:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 23:40:26 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.31) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 23:40:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGTxV2GTranF1TNEG3gYx0M0tBJz7H/5MCe4RfhTMWT1DuIytzZopiyKxwLxjVNf1Nx2jApYHglTqPGpMdkmOAFhiIrOQfm4a65SYGmZNQdyUNIWoS4f9MD0sVn14VJe+3LKsdiiETA523DGj/nxkxc0TNDsrXu0WBpaf2LUHmd1250rX8fCnqsLCMOH0H7QQ8JJ9J5mDnsVCSioKMAZ9a7mF6YHlmXdEAeuvNlzG1qWsbryD2qnK5iiZTGkiNibslLtiE2Y99E0LNQoveuo1jsvzytrG4eCAPJ8659CvdXrFWIxPbfn5SqniFmww/iCTBVw7USY+xfa5RsHC+PzAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1Wt4Rxeuykhfu7yYvYIXzSkWtHtnu57sySzkJrk8pQ=;
 b=PxRetSQ7YG5ujfKdMbRRauiPScfS5F+jS6tiAW2YtSg+5lnc7S7zfAuLrj/z/2BmTcuYbgTosvfJNcvOLov9lWvGRpGMiEcDCkCJZbOre/TlvJbL81etkfUwGiQrIEDQS3XQMm6IGMTO6tAdQJg0lfuUYFyFz1ujLkamc0Rkn/LlwXtL5a+9JYcW2KYJI36EgD0hUEa8s4GrzhWSt0MDFdAYU+Q2kSTSPrbA5JSpfVYNS1E14wRyx0//t7xNLfP5hVaBoESpOy48GOf+tPIU3lmZFDhmoJfel1MgsFwUCXG9Cp/rXRUeJWsxXLHd+yv5QDrwopPt/oiXb0nLJItJnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by MN2PR11MB4663.namprd11.prod.outlook.com (2603:10b6:208:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 06:40:23 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 06:40:22 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 3/3] iommu/arm-smmu-v3-iommufd: Require exactly one
 Stream ID for a vDEVICE
Thread-Topic: [PATCH v1 3/3] iommu/arm-smmu-v3-iommufd: Require exactly one
 Stream ID for a vDEVICE
Thread-Index: AQHdCAypOzvdzZc+kECbXJYujdPJNLZbXMLQ
Date: Fri, 3 Jul 2026 06:40:22 +0000
Message-ID: <SA2PR11MB4844DD8A0367D8E909123F868CF42@SA2PR11MB4844.namprd11.prod.outlook.com>
References: <cover.1782767110.git.nicolinc@nvidia.com>
 <b98248fb8a7ba39beeb684d27f064897e6ec8ef6.1782767110.git.nicolinc@nvidia.com>
In-Reply-To: <b98248fb8a7ba39beeb684d27f064897e6ec8ef6.1782767110.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB4844:EE_|MN2PR11MB4663:EE_
x-ms-office365-filtering-correlation-id: d6351e48-1a30-41c7-e7cb-08ded8cdf4d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|4143699003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: sq10XQRvGJX8t/z3WlkQYg9lMGN8cB8RVK6GwQTwkzbgB/83AeBce0C4EZw6vBe0XHZdZiC1aurZeGGogckQgARvaF8ljC06izagRzMuXQglHCi5dbuEpxDntIZocYWOhAUzvPo3nEfK7bjk8cdro20oh0+UBD7pp/CZuGOZlAfCjOJ/qrUBCMJVz6tb7BjEmQ0eWcSxY+TIW17NKbGu+W9aMXZMzX7QntWO3omq55GOTgKyPNypjXmaDClQ4X2nBoC6En0tUyUPc5UUOox0lrSWkeLGT+jIz1QGbIr6Dab/wrElxPkJxN/aQ+ihe5ay6iFLJfV6JEA3lkYuzkMz58389pqy4sqdOGIG0QNVL8/CU9SygCRuJaP60K2y5uyKsAA69jdKRlaOg3D9GzNg18ytmaJohOtMIJlZDsi83gIhT5v8xUNfUW7lOgm+WjZG8QhM0+VT3fDbyLKjfcnhAiiJT/86ugzpVqe4xfbhHvS9XuO7Gynbwx2fxsbRbujweSkbHJ7nmTsaflM8Oa+b/CR4LjD4OyFjtpZD533GfLWkrfNhdeyqDvLj47o5GDFCh0cI5j6ID341/efbYhpPNNurJFW54Obnmy2xXhUKqq582GH0rPGnjWn/zxRb/pfvYsMdsn6I4XGAlREJpcj+nhm7FJ6zYP5LtqX+ManZzDQ5+6aAbcxJSxTRTTxVxnGBN8oidAPIXaNn55Fqho+EgKrALhvrU+z2Rr8sOxOUdiE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TUoFLww0tHisJZiWH+f3KYhh0tmG3+C5ExteNg5N3kpMMU7Z1ZocEhcb517Q?=
 =?us-ascii?Q?kfGqSPL/+DL5IS6ZA8XZZVvldWA8PIBYceBPSP9JUBMwYyj2kcSE9UAdepJS?=
 =?us-ascii?Q?N/ImUWun+TK3iJVn/UuzYOp/UQlW1dpPEzf+a+YhIX4GA4QwlHKedIGe5aZy?=
 =?us-ascii?Q?V4HMNN+1djkFejroP00GvdDJEmvuG7R35JoEIbJqtGWg60qWEl34RBZJmbX0?=
 =?us-ascii?Q?itMPutfIXNQnvoyc25GbEXuA7GlKJ8t8PfPRoW64Oo7qADNidwthrKtCz+Dl?=
 =?us-ascii?Q?u4ngY0vikG27sLfYPqH1YJrkgdf4N9U5TVklfjKCGC/JvI2boqx6dyxCZrhp?=
 =?us-ascii?Q?VpVhHn/hQcjMcwKxSxztLJRNd3Z0eqzfZWG7xGR1JzEgQpOG0MHIaHb5E/zJ?=
 =?us-ascii?Q?1/eK+1ZtOZYJedBxUXA3XBwfkpMyBaAGlxNynUqdLkKrQXwiNYoaGoSF1sFM?=
 =?us-ascii?Q?ZyIDAzHBIkx9gl6hHUhAVZUci6e4lXuPDbJvLZj9L1tY5b+hs4HZintc7/gx?=
 =?us-ascii?Q?yyLcaAany0DRI/SctYX7im8iNJDS+7pc2hDSFFTgc+lT2u8iyl4IbiJz1GMi?=
 =?us-ascii?Q?H3bU2egj+qu8/JFvT0nvjPaoRw21gXYvDHAu2JeORE0k6Lz0nuw50/wA9Xvf?=
 =?us-ascii?Q?Kzjnh1VP50XaWVkKmq/KKZahORrs0puEYubzOq06qWB6ylqHPGiHA6nQ9ynS?=
 =?us-ascii?Q?RwRao82821S30yw/q1NcfX4J3rGJSckRKQAhIqu63Hbee7A0VmEDhXAF8u7T?=
 =?us-ascii?Q?SsE1jblbzWljenWp4vXmK922WE+RnFKvzNVhRpRlKjcRhRdopo4pMjQ8qhie?=
 =?us-ascii?Q?DcA7kvPTyN728B4mUAI6BYhSqPD+8bhAky/Vqi1rsp7b6mHGvrJt2zD8CoQL?=
 =?us-ascii?Q?EPaRuf+K2R4HatkB7o24BwWHU2LqCRabftb7Kfxxasvy1KXfDbui8srL3X09?=
 =?us-ascii?Q?Fqg16WlkPlQ43rRoJufIjKNH12MLfxon3IirvPMuFSf4mv37aVHsjc8kTzb7?=
 =?us-ascii?Q?pVx3i1pLeqDxWvI/i/yOWb3wGbWz+d2XiIo9TJEnpwo1sAHpiPyaoI4zDFLx?=
 =?us-ascii?Q?QZu4SviKCYGW+Gump0uMTh6vTHOy7qXZNuUAZFCFkL14ywJY1gtKdzSfCgf7?=
 =?us-ascii?Q?s808Z+o9cYshxg9r/DyTz1s1/C7SUDsVeRzK/Y0wYpUq1TAVMNfo29Iticu4?=
 =?us-ascii?Q?N4TAZI+NFOtfP7Cip7ozzRJD10LXgLGUajM1vlMSdT/c4m8/5O6BOjgJsN+Z?=
 =?us-ascii?Q?WmWHl5MEOlggtj5hB6Lg0ouI9AXaceXcz5UjFe6kIVMl+UfOn3Z/OCWbaT9K?=
 =?us-ascii?Q?PO7yLLIdyvoMHs7kPaco4YLTVfcoPCQIrEeUini/NHVtkFoD81BANtNW1pkq?=
 =?us-ascii?Q?Lj5iIB5NXCCAbSSgT7H+skYMZt37eeC8FU0PmNMDWTm6NTjdRhDF9NJatZng?=
 =?us-ascii?Q?MJONadhkmcAzOpZuG37prrMUVgsJux/+ffQgd0gaQpC/Wczo/KcEdJK23zrL?=
 =?us-ascii?Q?2/iAZDtX7a1B2yOsg6/BHr50SkaiNahf1Bl5N6J05VVJkoD/Oya8+ESfPzpK?=
 =?us-ascii?Q?BKHELyzYcu2DEAL7nj0paxxOSyAXcS4t9WdM13kvuTB3f2T4poVuFrRQHJlV?=
 =?us-ascii?Q?lUqAUCRQP6o1qLkfkBLKmd5s82CG3YqhD0M4nRB39STA6cMuUIe65gIPZYQG?=
 =?us-ascii?Q?WWzjIhiGtLxzBrKk3/V9Jw733qH8pW3unlpPEbTAJKffeSEC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AUx0nd9R9ERlXByF5QjHLM5A/1Z8NCy3Dc88/+Pb2s7uCRyqaAHc9a81gTmZ2JIfNYtoXXP/GErbzuEpJmWFq9jkXE/4zRz40w6ZkBqYZidFOYOq2fL+Xv28Aa2qpl4S3y/t5DD1snGcZF4Ax6HV0kSUBBt8k9+N1ftu8JjlPvbmujzH5R4SxxEicnkN2P5ias8+xfmuWn/MvvZxVqN/NDH+hpDgSw80ozCnFRfpJba1HUKv3B9zFJFomcts15giNOmMFTxvA+1dmGhlObd3PbBktaJf8eG4vkQuiTFvT1Fa3yyF5/5XTEpAKScBCyESPyRRjZR5FDIF3vFVwGRMOQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6351e48-1a30-41c7-e7cb-08ded8cdf4d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 06:40:22.0299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N5RFGJacyXyI1bAtTnCmP3UYijVv9G98F4OEVxXFr9HO6taYjyxIW7VQz3+LlTePD7XeO+mN4Ax932qR59kUQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4663
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, June 30, 2026 5:16 AM
>  }
>=20
> +static int arm_vsmmu_vdevice_init(struct iommufd_vdevice *vdev)
> +{
> +	struct device *dev =3D iommufd_vdevice_to_device(vdev);
> +	struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
> +
> +	/*
> +	 * arm_vsmmu_vsid_to_sid() maps a vSID to master->streams[0]
> alone, so
> +	 * more streams would leave the rest stale and none reads out of
> bounds.
> +	 */
> +	if (master->num_streams !=3D 1)
> +		return -EINVAL;
> +	return 0;
> +}

- EOPNOTSUPP, given the comment seems to indicate it as a current
limitation hence may be removed in future? otherwise with -EINVAL
this may be documented somewhere to get attention from userspace.

arm_vsmmu_vsid_to_sid()

	/* At this moment, iommufd only supports PCI device that has one SID */
	if (sid)
		*sid =3D master->streams[0].id;

otherwise,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
