Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E51F13D896
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 07:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667383; cv=fail; b=rIT9ZqgPDX2hXymP2j5hKxSL28314lm96Wj+wUpNMK/2PZwD8qTF/RU42WGGrG7ZR/EX52gPnxH6nX4L61t1SsgKXuDaJcR6CozM7w0kF8KzOH/H16UZWGbK+si15gmXjHcSIV0ZnPCIZDZOXCJ1Oz45MNFogM/qYwNwnY7rfmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667383; c=relaxed/simple;
	bh=sQHpcWZDOQUq4Hv3en1iE2otrOdFlIt7la60iP4QZvg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zj/TCz6CGQGrjPz6WmfKHM3WpmuUTkfCvd/AosoIXbyD2iwS3NT8qoCbT09d579pmhsVAOSeqUFdm6KdUGoZnv2M6LLZ1ViaYZmW5zEfh/MC2e3TeycuTGC0yh/RXqlNcluJb43ZCTbpO/sucZjohJlobCmGnT+9/kHCsOl7RSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VmOSxl+6; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VmOSxl+6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729667382; x=1761203382;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sQHpcWZDOQUq4Hv3en1iE2otrOdFlIt7la60iP4QZvg=;
  b=VmOSxl+6F66zSYfHO3Gid7RW7e0/fWoO6TA6guSenwP5Jcn0pnsr0hBh
   KnZRtfJvL0p5i4oZgDZZkCLIdq0zqhJ5FpdQ//cMR063rrW9VXMYa2EGs
   mGfQkJF2endY0GAVm+H0pjZYcK2urHaOUDDbv+X+8m4CsPNGiP8MZcWrO
   bYIqCumsNqhFA535JCFeNKf0UYUKNu2jqlTzLcIrNySuYNmbK4HIYst4k
   0smWmxwlOIFUdR49NVXfPPsueGFxFqxcHNlwH/VAUgNROoBliQd6M1lOZ
   SlGqBOJr6kEIxxvRv3OjUKdVL6H5K5WvU9+Tj9/XhD11IjIuacWAnm36W
   A==;
X-CSE-ConnectionGUID: UeZUFp/VQKWDfhCBFpjQbg==
X-CSE-MsgGUID: 7zYFPboBTNWK8DhZxtwwjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29464165"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="29464165"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 00:09:41 -0700
X-CSE-ConnectionGUID: E3H/uHNATYiFdZCPQz1BoA==
X-CSE-MsgGUID: T20U9s+9QuihpBKJF23igw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="80912465"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 00:09:41 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 00:09:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 00:09:40 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 00:09:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPAyOupSEWjm1J37LA428569FgnTyAuI4ePrTtxpUaWW3+6I12tsFRgVms/Yo4qEkQUJA+b1I5oDdkwMUXKHb+IQA8PdI2vTJ3pFNc/IqFr5WeyVNFKo7Kv24ZEQw2cmXYNvNLGjSVHXFbxlvg/zOgAbqs7t1OUZmMTQzN1XEoevBG4Lke9QbZq0R9djxXs4ewo+OJ5vtQVt1KZyXaVLtoMFnSttnWW/VOizN8l46hEMTj8nqdw7TWnDPgEo+Ht4ONwsyPkTr7lvBKxZWNlXsz/IdQVIbJgG5OL9EZGGvCD0dG0m5+wW4juhuqmWfDNvW6edh32kQ9tlBGMNslZZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vnprm/a3aDAyvLYFPN6wxp0+sPgEP89sHuVYEnQWkaM=;
 b=yex5PqboLSxYUJrtrCfjBkxKamwJ6cwrxFtt8tATqGRS/juE53C5zUvyx/1KyfKY0tD374EZKkRyXinpyoyTHw5+WtAxIyZmrx4BRMhe1UVF6qGasH6wiWyOTgLYknKKZ4jZg3vLKIw45s9OROel9cCFJIkdiD1Ig06uVOFwJfwIS0fcHhyyf6vkq8hg1BCv48AHTaZQOYPwn9LNNoowf+DmLZiUKSrAJIYBpVGmF02iJCMoUWrQ+7EB370CsUneIyoyhlmR6ThSH8jp+M/gglOUcYTVl331jJ9syLcAX8ChCHUvu6Asovk4+gxlieJIzDAyqpRhyD4sRCyT1Ul7zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by IA1PR11MB8832.namprd11.prod.outlook.com (2603:10b6:208:59a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 07:09:38 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%4]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 07:09:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH V5 4/9] iommufd: pfn reader local variables
Thread-Topic: [PATCH V5 4/9] iommufd: pfn reader local variables
Thread-Index: AQHbJMWf7WiJeQch00WVdMi2s6OzHLKT62cA
Date: Wed, 23 Oct 2024 07:09:38 +0000
Message-ID: <BL1PR11MB5271679F5AF957A34A80A3038C4D2@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
 <1729630838-24586-5-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1729630838-24586-5-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|IA1PR11MB8832:EE_
x-ms-office365-filtering-correlation-id: ca6f5f4d-98a3-44a2-ce52-08dcf331a86f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?UWo0mjKXoHcr9fQ+/uhoCpZLIpIm6wkN2nZ7DIL72OBHZ1ekBPrXRdZehDTN?=
 =?us-ascii?Q?3Uv9pZ1TMxql1+12TJ6/tamUY7wopPBJ0N2G+htX+NyHIqm6KTRnkMu9wCsI?=
 =?us-ascii?Q?bC8mLFqNhf6Rf34bYUwR6vXkk49FRE4M7a6UcwX1sD6gDIceVCPiaffWvUlP?=
 =?us-ascii?Q?mocmq5PuNOOe6QSuxeLyAVCaNXdsi9Eg16Fkql2oNi+74p2cYwdO2H4bFvB5?=
 =?us-ascii?Q?dvSsmy9LDVyylddl7YnfYck9xPxXMce4JsKVY+VdXGOFFcIxWwPRWtZpRhh5?=
 =?us-ascii?Q?vy4VSJfOCu03f6Aqoq0BEGm4JFzZ5cICIytlYgY5zhrkWWSdHCEGM1g3+ndr?=
 =?us-ascii?Q?/bO1tqR3sHeUmjalf3CCXUngYORThWWEFm1PyQw8CrDEFkYOitVoNeVpKKcW?=
 =?us-ascii?Q?D4xffi2y17JcT0wOjbuaPiv1f8BSZqy8d9D6RSkoKBNWLlogNGLXoPxVh6J5?=
 =?us-ascii?Q?Y8UtIZMgCISagMMviOnNfexBKqPCjWAC8ktfQXMSV4Vs+ScHQgVx8mqikiun?=
 =?us-ascii?Q?75aiv58t+r1txdFnBuI7MPhxaXlpnlXfGHIwFImbrp3TzpOowj4CcMzK4yHU?=
 =?us-ascii?Q?yIUPIGbLCogOczBAQA5+XIMMrj0BOEuiR+l+CPskYbd3I1cSV2QAIOEz+tQT?=
 =?us-ascii?Q?FNeZnVzbniogBcmsxfRr+tXUsUQy5yhuZfNN2s/zmV4Zcyhy7lcFwlOrF+sh?=
 =?us-ascii?Q?ZBQuPeTKb1okCePH4dEoiqkiYGbyzUHSjcIAH0ge5+pK1ni9mbCGbAxP/4Ts?=
 =?us-ascii?Q?7VK2xhBdSP3QBVY5woJOqq3K+rZo7Y/28yTdoS6sxZXvbJR/T+JM9MbERxE4?=
 =?us-ascii?Q?EpqsHjp4cdVamXWPaiFtr6xc1VBmfyyZLKjW+HSOU5Mf7G2hKuQtQ8kJSL5Z?=
 =?us-ascii?Q?Wme3aaIvhHEjMEb+FAZB/UJRqLV5gBB6OBsd5Whw8+oY4JV4S1F7ykomTaHk?=
 =?us-ascii?Q?VwI+c6ecVWDmTpRbrkp6fEGWGLnQbbTj8MPeQcURs2MXxZQbBRLJVAhtI2P/?=
 =?us-ascii?Q?HKOungGyV3xf8OD1xnklJ996+BymvTcCMKI+Naac52GJSzRSYB+hXN+Oz4Uz?=
 =?us-ascii?Q?bg/4vrVaggz6lk8JkxzI4U4YXKGejqe1JYPEsQYbf9No5zUAw9uXbAJMEa8Z?=
 =?us-ascii?Q?YXDxH4gTOAgpXz6hK57OrpybcB5seukYvfTu/7smlyNNTOEhKaQsxN9qDG7t?=
 =?us-ascii?Q?rPpTdv6O0QYMrRJ7TJzMaFC4LtGd26kYYSk+t110kf3u38vu1j4x2pEOdDR4?=
 =?us-ascii?Q?1k8ReY5mQXlKiTvn4wKgz7AvjKSAsRwLlYd59WTu8XKwWPJflaoDNDOGh3Ly?=
 =?us-ascii?Q?IVB8FGN8lO/ecAV+t0UzJDORSwC3Sho1dTZUawrEZ6/xBDDWO9DveMqa/Uc3?=
 =?us-ascii?Q?hCS6dz4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bvX5wK6Ifz7ylttWZ5WtER9lbeztn9/69ZipezPvUBAUIGwJePEmDX8d1586?=
 =?us-ascii?Q?vDC/DBD8vG2sylcm0IoFonbQZsN5aEFHus9jD+SVBJgPzMoyHD+0hOe/Rijr?=
 =?us-ascii?Q?VE6ePSe4QHEeEqAR9ADlsk6uAupTPzGlO6YNM1obNcSDanbRgGhie20yVR7Z?=
 =?us-ascii?Q?ogZscMaSm0AfR5Dtf7LpYxy5h5PmFKXgprkxuwQuT4s6WlozIYSxiLvFVctz?=
 =?us-ascii?Q?4WemQG+8UJariXZ0GqLnO4TDQ7r6x+rE94pgStGH+S2p3nNu3h4qLfEBbGOm?=
 =?us-ascii?Q?dN8XTHkabo0osuwThd2o1K9Rj5VCWiKh0wmmZh/F0F61624su0FjYqYit1q7?=
 =?us-ascii?Q?XZOEXqyfyKX5y/0uMxr/HxysBCeRRi6HJBS1UIB9JTcVjMcSkKhtPbNMvgf1?=
 =?us-ascii?Q?ldRTevAdK+w5ExOLPqWnvWT6rgyqLZwaNTiBMCAeHXyIz9bUHPG661bXpi0h?=
 =?us-ascii?Q?RbURwFTTI47042I2zp3ehcT3t0y8pabbsDePEQ5QybW9mDXTyhvFmf9pF6ZS?=
 =?us-ascii?Q?2zSD7k7YIPfRm3Mfmy+dfYQq0H9uEkiYn6ck/T8jTOt5beAuLXdvsdjfT0bN?=
 =?us-ascii?Q?6qixQC0aw50lyjJsyJWFK0Uaq6R52roihb+G87XejyZXwoaUPSLUW6ZpPCFj?=
 =?us-ascii?Q?bfV4X2VOUuAF0f/vkSqFca4gIF/EFfUZfrOAzFuwpx3tFTpTtcYuoxsFrIKZ?=
 =?us-ascii?Q?l6y4nLt4Ffew69HpsXBH1vorlQHRm7lIYrco+Z53aqLYXju2y7mAB3vnApJc?=
 =?us-ascii?Q?DXH9N2ObBYswF7eqDdnAEvmBF5gDDJdF/EIfpT8+wWWl01CpO9redob69Dn2?=
 =?us-ascii?Q?yciVj0Cs4iZEFw2bb+Kt5+qzrK3GtlzwwB6zFvEfYpnKgi3uVRVfFCSg1BiX?=
 =?us-ascii?Q?D9xib1rdqQbBf3GMbHmXPUbT3HW22an/EKGitPOBcpKN4tbg6lE81tsdyl2Z?=
 =?us-ascii?Q?DOKTyPzu/90ldZcIhCRjIsJi2vPEjQyp+sqO4Ve8rGRHLjOVW//JVk4FBIyW?=
 =?us-ascii?Q?oKV8rLa74GuHLgdi2EY1ZnkoXnlHv6gzk3E6UZKG4lgA715rQxUbVxAJMW0S?=
 =?us-ascii?Q?fkp7Z7ocFc5Ue0BYdgKCxNl0xJmH0DXkDAftdFOyGFaGMibu6LyMwhETfI/r?=
 =?us-ascii?Q?P5sYuyWiw55F/iM3pTkbuqyWZh8kAsBmB5qOa8D7ANKDlOSCWNQgHlBz6S5A?=
 =?us-ascii?Q?ZQdi3RmFUm0jttLwbmolSouyD8ClE44ObvYnV7jlZ4wPizP5ZEKr4xLwZL76?=
 =?us-ascii?Q?Qt+C6+iUmfTyUaX0Ros8jE0kiVnMD6Eoaa0uNkSeIVH7SkLF4/qqXtQkURvf?=
 =?us-ascii?Q?29ZzdvrfxZI0Asusgy7Z2HkZl4LcrWtBpLkwRLBgEVVicy0Y72gveEWlznsh?=
 =?us-ascii?Q?6xiNzWZO3VTC3m4lf/vr9cm2jk0EjdBkHMJ10aH4AJ2YhqKP/KfaCVxf6K1e?=
 =?us-ascii?Q?GEx2hKPt+Zc0oQIAsiLvsyR79DKj/g7vorF3S4M2bYJQSdKyZ8PLdrrVSO/m?=
 =?us-ascii?Q?4tv4ov0y7sBrGcV4DAcMpR7IAVi2RLbY8MPoo1UuyGTkIRL4LSptG2q/pNLr?=
 =?us-ascii?Q?dXc+zzgFVkBA7tSR1pYPhFAx9dfDCSJXcsrdSL8j?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6f5f4d-98a3-44a2-ce52-08dcf331a86f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 07:09:38.4223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dWUZT/PgtqGId/T9jxeCRwGcpNZf3i8ls/39fsaECpuSE7+opyYyFU0u8FVbfnRg01vN+8xGR+3Gp0xLsu9Wxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8832
X-OriginatorOrg: intel.com

> From: Steve Sistare <steven.sistare@oracle.com>
> Sent: Wednesday, October 23, 2024 5:01 AM
>=20
> Add local variables for common sub-expressions needed by a subsequent
> patch.  No functional change.
>=20
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
