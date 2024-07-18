Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AAB1E515
	for <iommu@lists.linux.dev>; Thu, 18 Jul 2024 05:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721279624; cv=fail; b=g3CDiiJET9iombVERyE/q+0StA/IyAYGcRddSraxPXh2ycJl8xMJB5lM0VRiS+vl5CJajhFPZxVWK2aw/6oUKWKZWCYuEovo1kTkoNJG4GNXMog/LhG4o549i8lQxlXB6T4FcHe/mDM7qAy32Mm9go/e4VyxggUzMLKGMwrZKCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721279624; c=relaxed/simple;
	bh=6/Qiuj9nGU8uSyABgGtFeaZfBPaKexo2HMH8uf7IY2A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hp1UF/Hae6LvaWInoa7yyU1wuDfntR4coMD8oPbdBfb3iry3veqHrwt0qHWJ7GOQrCQfvcxvm2362fz+j2fd0WsHJGa16dB515o0gZXT/F6xQh49zRlFbsFZOwNG0zz3Yi0HowqolbgDYtdaPZK84QxxzFOCDSYL6fIbWz3qu30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cyUbn/tC; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyUbn/tC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721279623; x=1752815623;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6/Qiuj9nGU8uSyABgGtFeaZfBPaKexo2HMH8uf7IY2A=;
  b=cyUbn/tCIBkSW8PNglil4Mzs6ez0nwOFekbn5fZtwWKltpbPCCkCCgT8
   YQ3Kn5M1BrSfXPLbff985S60HIsBf7HQFTtbm3Fkufcnj+cZZixPliqaH
   PRvaYqa2BwS9ek+UDQO6MlLht+3e1vgJ42uUB4IWaK2bjVzjm3y7ZXHWt
   ljcW9NFtFrm7HF6nRH9wH9kVpVrjJVkFbBDIYj/IojJjnx4XxbEsgy3jR
   HDZS+bryLx8v8Lan4UTfumNo7OFBAA7Ddi5nAgU1VSjPAmR5Cyqj2TwMI
   SdW2HDEzT5kXKBxWJ0W8leD/KMKSjcngPRHxmuEoJHzjpnUdY5s0YXPwn
   Q==;
X-CSE-ConnectionGUID: 6tS6f6X3Q2e+996V8WKzmQ==
X-CSE-MsgGUID: JWDxDTFRRziyzMfo9ZUikQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29976567"
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="29976567"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 22:13:42 -0700
X-CSE-ConnectionGUID: xtuQlDhcQIyqKPAFj+5ORQ==
X-CSE-MsgGUID: TBIVteBLTWGi7qT4nD1QTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="55144794"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jul 2024 22:13:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 22:13:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 22:13:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 17 Jul 2024 22:13:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 22:13:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQo5NdFlUZ8EgZVKdHabROS0AuwwkRsIdUI0v/asz07X2anUKUcpwJf14hdmZaD7FQCXCj85C0jqvjiVvd19c89cuH2trwUbHuzRicZwO5DcbnwPVII/Y91o53n3MSyyyX7+n+6Ss6ukBPijFZNJObG6DfgYYECgSN9ZlrGh/Wd9jYwY05xzrCp5eLL83YIYfOsN5V2jyR7TFYHDs+DMSZrS035fy24Xu518JB4XTLW3Io+FkRInFHiHzGcVwjM01RPgkxMboWc6EYvEVl2JwcqHPZR/I/vB3HV/Iai2+5Vqcg9XbphMzaWJCbpUnNeUDAAZKhWSA1PLH4O3yqFkTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/Qiuj9nGU8uSyABgGtFeaZfBPaKexo2HMH8uf7IY2A=;
 b=VOQsZ7WZs0RF5aFFxf4OoXyFxf43uXiJwKzOlABQybqTZ/3IhGLqs/jZ2tg9lK4lP+sftRUnzXVE7MjvHimTOhfAUODGUuVGRiXVtP/BtIoUuQU9yPJG6CKwa452k8DkTGXsa466RWRpeGQiGSMBOu+Qixo1/9bwMFEKr8mGd1EkwbTMw4l0wM/xBRnf0hsnDJtOXRkpRZcxIr+cZxRIXHpXthmcRNbq8Dxwh8U/fbU4a9tGxxgbfzcx+tMIUnjBTsZZHLp3RRhTQE9FZY6ewMDDqgsGOAaywl7HI3l1s7smq60i34qjoR2bSGZe0gbYJWLYXh4Og68udb8dZZlEKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6974.namprd11.prod.outlook.com (2603:10b6:510:225::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 18 Jul
 2024 05:13:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 05:13:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iommufd/device: Fix hwpt at err_unresv in
 iommufd_device_do_replace()
Thread-Topic: [PATCH] iommufd/device: Fix hwpt at err_unresv in
 iommufd_device_do_replace()
Thread-Index: AQHa2M+miUCIdCHdc0WGrkCySv5zdrH78MTQ
Date: Thu, 18 Jul 2024 05:13:38 +0000
Message-ID: <BN9PR11MB5276718A6C5A02FC53D7E9C38CAC2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240718050130.1956804-1-nicolinc@nvidia.com>
In-Reply-To: <20240718050130.1956804-1-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6974:EE_
x-ms-office365-filtering-correlation-id: 3986791a-7a0d-41ca-6678-08dca6e861d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Cekz97MJaB0szWhRDV4vd7NOJVXA27/ny4ylDrOx5La9VftqtLGntPh3E3m0?=
 =?us-ascii?Q?TrT1skPn+6SYxwXX526uBeOQvm3ruw50i0dGNHRgk6RK/ye+MOjK1sQsYnDY?=
 =?us-ascii?Q?UFI3Ax8cn1vLR9ixUvMaLxk8sUbfIKORpQ9LuLsKyHJ221IzVVAVWyxC6zup?=
 =?us-ascii?Q?14H3SOrz4k8GRRoT3zCrAyQfYiahG2dN2fmqu4enB/9++cwGUZg05v6a/4eE?=
 =?us-ascii?Q?PXXS7XqqGXor2d1vx7UpswudDHv+q78kFPSbsv2EqHqyyo10YEeQpaCJVCDF?=
 =?us-ascii?Q?d5+wTrFPcmAG1dHpMqEW+OHR0PE+9km3kMOP1/vdODtYdVsX12PoHgvRS9Oh?=
 =?us-ascii?Q?kUz6xDpHYUc74UfegTtKmgD0j3e+acZ85TdeUXMWCSqTLw8JFJG1WNFCl8eO?=
 =?us-ascii?Q?bCckC5B7NBQAVVtiKDwRpOBkQ1p3O8MjgPLNc3tbL87/6t43EfhVs2PSzNt4?=
 =?us-ascii?Q?AwFIusoPaE6tziBZ0G3Au2anp/3NhWXhoYutCDsI4wi3jEC4IvQcB0DBQIDS?=
 =?us-ascii?Q?02RZMvN4Qloi+uHfZsRVJlC+6h2mLset2QCiCjSrVgXe06PHCMG5pvIsCec0?=
 =?us-ascii?Q?L8Y9WrYguy9UTVVEsj6S1hLM7kRvKE50mQEtrelqKw5Yjby0DeMWqfbtu++p?=
 =?us-ascii?Q?eWJ8sxHEOrnCkvDRBBXhlyvlVyQURWWjz91NEVWZzY7rVE4G3VugWxeROsVu?=
 =?us-ascii?Q?8INl+UA2uz82I+9SFMFd7RrvJLOJmynvQ8xrbZFWvOS6kFHaU/HgI1Rb0daM?=
 =?us-ascii?Q?v1VKgBvzpsEaVNY2ZvrekBVUCcrF4KkA+bHSFaM9DKxmS0XigkK/Sf298eYv?=
 =?us-ascii?Q?cAs8byo02d6c60kKAA+Ojdoeurtm/fL46Z8jy7bWWIOF390nImLHU0VBbUqP?=
 =?us-ascii?Q?YNm8cQbVRGk2VLctnIaunI3jpHEhEKhuqMGuWiiH/pEOOAa0PHpFMFrWVi/+?=
 =?us-ascii?Q?jV0azLBBn54PfyOa94imHHXnd2RO5Z/nnjlzv0DRlzZhZ26SQns+jpwPf3Dn?=
 =?us-ascii?Q?yMv9hG/aVb3GUSgrQEEdD3pYkPQ3jJ8zKX0g3Z/1hloYc6BZ1kmr1N7L0dGu?=
 =?us-ascii?Q?81yYtF53L93l3UEUrhVi35v0Hpvh/UFkNcf3SvLO0MuggfNnaYYghIrkhuRM?=
 =?us-ascii?Q?/ePQShMa3wozg0IEfHHIEsAjQK3NJXhP0Gto946DzgoVs/RqF1qblluy+a82?=
 =?us-ascii?Q?45ZGY98bHemFfAYe8gaQFQngJ8ooR+rFJq5h2VsaB//6U5oDpybXWp7fV59M?=
 =?us-ascii?Q?QC6MLjKpDakvm891KfemdES7nEWuMoKFKuuZPd8MvkHdUePgjfcYjwaGxtju?=
 =?us-ascii?Q?gtb5iAkPMpEW2+7eJsrpU8X/fPs53vWeSTnn78XypuhfyLxpfYAUrHfthbUv?=
 =?us-ascii?Q?YS8zXcmAXWjHb/tfm4HbqgBoiDF+uWWrXRb3HRiDKI77hkrXEQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N84V++UayD0TYdgZWYQyWNys2/fHfyFsBVE/0ChPZueYmF4+veGRsogJy56M?=
 =?us-ascii?Q?jKYT1gMGOy+Mqus6XaVqfC6gGmA7j7M8tqIKLC2jFpjl4h9j+ZEdhhK6KWSL?=
 =?us-ascii?Q?sLfd1w5Unb7yMBK7ldEUVJRjSuFdtMvNb5iU6MuwBWHKbCxmiky8nzVaXdUV?=
 =?us-ascii?Q?o/ZBNlVsQfYHoofPCy90oYCqU+Gh/feigt9qcafIqJTOeqxsumGgoCOxSY3W?=
 =?us-ascii?Q?eQwRO24KF+ZyTf0fWWZoRO8vh6xRrRJjYyRPE98JqtOrw/V1MS8toXxTNG4/?=
 =?us-ascii?Q?cyao7yRIOXsu1QevmT4abgTSR066XyB4OjDPkZgf+wDbFbWV4Uuhr6X6Ou7/?=
 =?us-ascii?Q?62E+JA2JwlI2x48GHmblFDiLlu8Ww6tAHeLPgDAFhA+3Hb3mKQREiL2Gc6dr?=
 =?us-ascii?Q?BilWDLAAHI2oGWemWOefWV7fObHwLo5Rl9M6/Z5AhN8vevv1nr0KLM85FpUn?=
 =?us-ascii?Q?2fuH97VPwB3mPByDBKvhngX8iqKKLRXAkC53uzZIwCgodycbUIURBmsU/qLh?=
 =?us-ascii?Q?D/sJ1vEzMm+e72HqfJ3ioNbPOid5slwsxp2i452CYLKa/pMmsp8j5bKRuuuB?=
 =?us-ascii?Q?5/B/H+Md8tc8bOR+Lh000iYZJqFkZVQAJZB0TLEggS7uyxSGiL0abxdUUbtp?=
 =?us-ascii?Q?gg3udyGVQobk/BFmlfjF/O6JNatgmNm1HIu9Sz8P0F4ssMIvyAvik4If0v4x?=
 =?us-ascii?Q?s+mV6bVnF8L6fAigyHujbs5OlX9lb4X0PtPywzVSZ4GQrcKDZFcp+nQhDTm1?=
 =?us-ascii?Q?j7s/bo0PWiX4ndFzriTxHJ7RyknRXHVioH4owQYKY7ziHrlIgFZhJstgk0to?=
 =?us-ascii?Q?26eyOyZxn2VclDVi+65X13CWcZK3Ia/6XcXJoKB20Au7w8w6s0QIM4GfZInB?=
 =?us-ascii?Q?S/Ry035hqX5tvWVAlpdOIumwefRFa6ab9qrg7Y+/T/6eemQX4bKCqnL0yn4x?=
 =?us-ascii?Q?5nK1LDKaqm/yWQfsm5w6o/9/22kTqujDgeKUo+C+auxh/tgRQsuJ8z9FS8/L?=
 =?us-ascii?Q?pTT+buuLX4ffr+ICS33vwaMSVz46vN6GOW/NcoEhAncF20ip1jFE+b3uZcC9?=
 =?us-ascii?Q?sdLbODWfEAhfJK6pMm0qF50ARi6TmYCZ6JkYXIbPp7H9EBq3MIyA24oyG0Ln?=
 =?us-ascii?Q?HWz0w10bvz9GLky8C6LQvHy/nBsmv5GYYhxCHpKMp21PkXVwox1/ioGFPYog?=
 =?us-ascii?Q?6vUK+UOh39fWL0CvBbS9ylO9MMOcSq3I+mFVDgPVFEN2XrAMjyQ7fpzxcYIb?=
 =?us-ascii?Q?36EUyZ4hC4MF5IoCcfVfrp84il2rYAKIbZLGuNg7XL8XedMlZUoPjhNkMXgI?=
 =?us-ascii?Q?JQCH7fSI2BA1tC2MGmH2GTCsE/IOlnuzFivtdxD3lXk3McEsUiDscAMFg06S?=
 =?us-ascii?Q?6BRLtX32liVmAya/xfS7MeoD4I05P4vo/re2SbJrgnAK9EOcrgBG1MBSNBvH?=
 =?us-ascii?Q?P8o2yN4veD2ID9CSe03iR0swzSbgZpjJoQctGF6V5fVw4nkyg1vBthDa698f?=
 =?us-ascii?Q?w/KH+oHakJfCLgCM6Yq86FA0CU8P6iy+vVp2WHNw389tz34KqnhXaVrC5Rif?=
 =?us-ascii?Q?uI2bTpLdMHwmfTQIty8Z+LIVCctFUqpkPcIs+TAQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3986791a-7a0d-41ca-6678-08dca6e861d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 05:13:38.3432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CAsSZMcBwNoubyaA1IP9QogC4gf5xy9IXC31+UMiS1QTUnH7nPkkpXVpFPNjSWHfTwks6JSjsOmHPbydJFE+7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6974
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, July 18, 2024 1:02 PM
>=20
> The rewind routine should remove the reserved iovas added to the new
> hwpt.
>=20
> Fixes: 89db31635c87 ("iommufd: Derive iommufd_hwpt_paging from
> iommufd_hw_pagetable")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
