Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091B28DC4
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776754919; cv=fail; b=aBoXYuKeLuAoat5DGPIngVmTn0aRFWm/EIyk2jfv1aN8G/kuBpdeJtgEgHITNmYGNiJuSjRBKV3NfVADPoVGGJ8d7ez4AmMtHIXd0R02+WvvBRMRJQnp3Ep97pK1v85dqkP1hslczascN+IMjKd7mIe4AJaU5PW5rBSB423+FKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776754919; c=relaxed/simple;
	bh=WPNF2gpIVamn+I4wsGFrgkF4xpvhb6ifyfbGHl+bJhY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=olgS8g3zm7mK0VVE8SU4qeBO9IhU5P5NXIbj4QmZClcflUtOGolve1eiq3skV2aS4eeFjePmX7y2i9eIFXEDvqtmegMmBWjdTO3OS6Lism35ah3cGGSM10PBCMdUhHAx66LuhrErMIJg+zeg0TSvFN5xCdWn4e0pj/5F0zUBl+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/mQWs3j; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/mQWs3j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776754918; x=1808290918;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WPNF2gpIVamn+I4wsGFrgkF4xpvhb6ifyfbGHl+bJhY=;
  b=l/mQWs3je08tgwlFEjy3XYfLM1v1ev+awC169E147kgtuvOxZRjqaMLn
   OxSLSDxAsoDEt/yrjn1hNm3s68hlSY05PCK1SzUEZ4ONpHwYHiSurqOuT
   51Gqmc//WoY/bvgbPsGJ7mgJ6M0Hn/0HDYQGiEnUexSnNCMg4qkRw5rMK
   smpsOpu9ZUHdyIuLfRbPr1tc/sJer3POgRgipPPA3lLsQtnIhmuADOhFs
   aEAHhTW9YppQo+8PoZvPyjUuOYKtXz6DYlGXXZa+X4/Y2wVumkMonhDrG
   ru+htVYVNWhNtTKwCBdi51oTEr74i38Vk+PX9Rwn02QaK6JYgg57Xjqls
   w==;
X-CSE-ConnectionGUID: D+QNEiHXQN+Swh0I7U+kgA==
X-CSE-MsgGUID: AHUwHCgLRbWs+xj5tXrlKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88299414"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="88299414"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 00:01:45 -0700
X-CSE-ConnectionGUID: 8hCWdn1pS0aQZa9p2qhoPw==
X-CSE-MsgGUID: beVYGsKlTuyROLuE35pmvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="228793936"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 00:01:45 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 00:01:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 00:01:43 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.12) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 00:01:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lo4AEX/9tGPDXtGs7ZkNBPOfhLttE2qq4oW9Rof/5E6xuOZ70qcdPh2kdWSmkkE2rDgIO0etqWXvIt8rNFEYDfHOi1As8D/BXzZM5EKXgJk7mSgme9gyu3g8vT1g+optIwLBNbx/SXY+ZNP+qSG7us+5+W7PHI6fVzhEELMfpFJaO9YYXohW6QD7EE/lfLPz8/xVEIhvuJdC629sbHYG+1BGXqQKc8+zKR7VaNCCfAlen0bCSXbVAMlx2nbqnsWz93UnTZqu1BD+j9BNAmUWE/B2KznRO9zQSVk5f4tJkPaQwnfKyo84zuS1/VUbmbPZUf88KRTrQWoddQHLEmDVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKjZdT4nMUXzO1TPH4Xcx7hKQXH/6LY8t7WYUdysU1A=;
 b=i2DZWc15hTn3THP+rbHJn/RK5HdX7UcSMghrYj8LYrkh7JIzNbxlLGCDHCT7BqVd0f59l38JxJ0NPEun8Lun+uid6LI9gWDsTe9iEUykeFB/3Wz0qxCyoR7Q+kaX39N6qnMTDeaFhMtcrXn3bWJust2AMlig28cYJgQA9m1LJTaAeh7ecukE+7mWUDLjKqtyQ0TJSe6+djBz4bmWjVRPOpgdwqhe5g6jhsAiUGp+GSiJ7PB+fVt6QIj52O0OgoOdJeJTtVe36PofK2cRXh+dcIAEUz7udi2eATlC8cMadoFXvMiRgkKxw1wISDcIRb8KKg+hHT9Z0kZwC1hgy47Rbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5957.namprd11.prod.outlook.com (2603:10b6:510:1e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.14; Tue, 21 Apr
 2026 07:01:22 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:01:22 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>
Subject: RE: [PATCH rc v6] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Thread-Topic: [PATCH rc v6] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Thread-Index: AQHcxsd+fSZdlW/fuEiEW20N2tsP4rXi8owQgADmqQCAAHi7AIAE2Tow
Date: Tue, 21 Apr 2026 07:01:22 +0000
Message-ID: <BN9PR11MB52769FE4DAB38B80D73AE6258C2C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260407194644.171304-1-nicolinc@nvidia.com>
 <BN9PR11MB5276D60096EBF15C5753C4BB8C202@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aeKpxLiykT8O4k1X@Asurada-Nvidia> <aeMO0whi7pPKE7FH@nvidia.com>
In-Reply-To: <aeMO0whi7pPKE7FH@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5957:EE_
x-ms-office365-filtering-correlation-id: de41cc97-10ef-4698-da9f-08de9f73cbf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info: 6ULeI3/+XI32j1+QmH4LQ0eyEE5DFpQB41xMt7X+f3KJAxKDqMlkNcqmE7ueZCO5hCnD1/dDGoVIQwa79ESdtjPHdV9zhs5S2FphlEYnSs8BA3RnJJuZoqOklmGAYuYveubbfVaDIzRGW3VrNq1p7xV9FoBjzSizPRkhb8EZBFStzQ/hzoHxhX2bRq/yaQpy9Ji7f2OagP3KxUnZEeO/asPi/mT0I+FtnyNKbNi7d/Vh8+MH2yu3hK5/W9uQo9xc8//4FLZL+CS88Pe6aoivVHiZFAOa61OrI9Y9SepEX4b/wQA64pIVcJvY/YF8ZLcw7ecnmJysDh/3Ew+Dqqzc50wLqLOQBHA62JL1OpfJaFHCEreUYvgKhclf822iv/f+tUsBgg5KYMpVlJ21jn2DgATCxDSW3OEjr5iJtZ7B4Zr/+Wyn7HMwnyaGb8IkEyBR/0tXaP7knNH99PhyqAeYeAECpvQU6SF5SAo1EA1aGjH82yPW5mD4HCiO+MmBz1uWaiGwke7IRDEhXAydnn+QNgPTR2/EHYEfnB0SQyX9lbfi6WURQ5VzEu1fdb7fvRF2qyu9Li6N9kVV5OE4CcUdlDsBwaUB1kkK1qCKLYyYvrVjiEmzLHOvCyHDtxj8h9LIsd7flSHb3kRiiB6/1wrs/EUKmdDqCX+r9Zqm4jfhgP4g8HgMWbXq0aEEHm4UoL1Bob5Y1/81NDb569AZvDaM1MsN5qO7A/qEGxLe+q8pf/7NCTDm5KYwh3+rhOFKX7DJVE8uUFe/XCZMv5NsthabZA4kpSmpANdeod7U3wSj65E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(38070700021)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fluVTpVJ/BKLvkXj2KcYrVVXWdY0Lyjvpr3oxGGfAVpTr47SxZ1OZeAtbUwP?=
 =?us-ascii?Q?xVqXmwBS1n4hzOCllrD+UbsRABvwRW4tnq4VjmUG9ZRdoYbfzhulJV7hlG3R?=
 =?us-ascii?Q?a7cLnu/744mRXH/jg1JjTS7EgCpSpiudvx88Y0UTLExERF13nrYCoCnbzXe5?=
 =?us-ascii?Q?xr1qpB/Em11B2BCHkgNx0p3MfIgxxNWIYtBI9YCkLUVT8a0EHvJkXRAQdwIe?=
 =?us-ascii?Q?zScM9jOkw2+k3mIzj5U6qcIy3hCIkMp/7ulSHrwrzBUQzT2G6881fLznwFdi?=
 =?us-ascii?Q?oiyJTYBJ/dHBVQS/mvCx+sUq4WAWLsmXIB9ZkEZm1jT89sV1LRUCTOX1bJ7e?=
 =?us-ascii?Q?vNLEeMsnbuIkevQ4JpJ0c+zYydhtDUGRoEiyRLZpjf517hjXrUP1JcgXSXFM?=
 =?us-ascii?Q?XkrDEJFkVAqdXJ1hgFQjIs4Ub/eFad458n/VY/iem5+gL2bKjbLUiUQeLxAc?=
 =?us-ascii?Q?Sv6gqxAl1JzrMaXNFNGj6zor4Sfmi29iyo43Mllb3Fj8fKZd1sJgHi5BStMz?=
 =?us-ascii?Q?c1hWuAi3b0talD6gEIgup7ViVAYGC6cakUu/DP7h4NVwmqh88d0AMuWjz5Wn?=
 =?us-ascii?Q?eQpHaDupr8i1xM8ujfFdCVmswMnJn4hNWs1Ff4eVjDBJsN0jMKlxtErQXOCc?=
 =?us-ascii?Q?FMRbogD4NxYtLouYbW3LVJVbU05/pna9Yq0xmBg1H2yKt93tcmsmgWaoVd45?=
 =?us-ascii?Q?+ozdguB9lP8Bvd1RC3QgZM2QgEoI2g53a+Rd+CTS26MAbqpXWEjAQaNDrSCJ?=
 =?us-ascii?Q?TuZRiF1mhMV1t4k7ikHVvIeRmLU0FJBTxXgu6XyoUAovicFpqWzt3f4QfMWg?=
 =?us-ascii?Q?pSegXk3dW+5ai/lS+DaBBNRzy5HZtkyzevZxF+2tUCf3zoM7LVdurjZd42cX?=
 =?us-ascii?Q?xisEj2xG2mFrsFx39z9UsRXudrSWOxs3e/nOFWnr9OZ31K1vRg/nRGc7QpqO?=
 =?us-ascii?Q?MrfD35HRkiG2YDxpAuCe2QgPpjAxjv/3DSse+yCmjChdhXRBeKKwWnPhLUMq?=
 =?us-ascii?Q?F+nW5tZF98xEUg08vSUaEfVy0CS7wB4uDJLnA11sCD36ZJzdqSrusz8SJUFr?=
 =?us-ascii?Q?LtFA4GEj1fRsVyCYzYx8yG+16jOipVpt+1nl3uLhK0JPRfY0fdjJwPLp/+km?=
 =?us-ascii?Q?bKPTE/a8va25fAcWovLR9GzqmjTapheQUvxUUHwmxvHoYNObS9RsZweXgaSP?=
 =?us-ascii?Q?oTFaqKhWZj/V2ggAofF7Y1NxGKwDKpMUMwYus4hQao08Coi24tmgF9Q9Ylur?=
 =?us-ascii?Q?1vBCFcpUQsQ77vC5ZJozOfVMD7JglHp25LFzgA+dZGR/TDx3QTqaeQ++rFs0?=
 =?us-ascii?Q?XAs4JgT8qK2ZhEDjLFzgDLiwjvJoHDnuMt4QHTmYnc3Cqi2NWBd5sc9BuHtl?=
 =?us-ascii?Q?dz+Jdwt06nD/+Nx0mlM13OxGV3rsFnIt+z4xRbLeZViLiAzR5JOfUdf9SQNf?=
 =?us-ascii?Q?4jlWURz4CuW50CHlyCzkufUR+CVUhvMk3LxFO2aSd79EtXKvKAZRWGGNpr+5?=
 =?us-ascii?Q?0J0lYMf0RvfXlBxAsIBARgLbaMBjCjEVSdtxZnuSw4CuStpzf7tu+Da1DZwp?=
 =?us-ascii?Q?ZaTJ9dBsYOaq2gYovlyGVCih9+NofWcfaf22cOrDEUybW8q8Fkd7L8Dpak+9?=
 =?us-ascii?Q?86ye2XBOezlkHReLc9nUbAfdfOAGcnfAVP3fHWwBi7JHj/+XabE30MFzOdjA?=
 =?us-ascii?Q?bGGEwJL4k9bcNSU8fFnoiyMxCR5H9M42CNRbGTmlgkgpwr6q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: COPEoyECre9Nmw1R26MVADDVcwPvb/gs0KHqthlkwV4iomxKe7oaWRBVfVaQx8i5zZIZYwfOPFMxhtlK0POf3BV756liOhg0AYAVnsERUt9xOw1qs4OLOE/nU81UMHAsJq2mLIhEMoWHuIroA5SSP8ux4RfNAl+J9WJREyle6ZesI+WXRtq23QFR0mnkDLTFDocHkLVKYh1v7nb5yHEuGcl2Ay/G+96LZ4gh8rNPzdHSjMqa0pgZ2yv2i+uYD2W/AK9LbCejDvGtCB1VYBVcv2JfevLfPxwUBfTK3uZvn6rYw8y/LUZ07S2xt8i6DOt8m0g5rqqKbMlyqh2Tmd5pWw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de41cc97-10ef-4698-da9f-08de9f73cbf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 07:01:22.3983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4g+ibkvWDLcOgIkt7i+g+AX8xMjRDcGFSSx9EQJVVNNxXdHZYuCklEij1mP26abf/wYE5erww9rjv7xY0OJYFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5957
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, April 18, 2026 12:57 PM
>=20
> On Fri, Apr 17, 2026 at 02:44:41PM -0700, Nicolin Chen wrote:
> > @@ -2469,9 +2469,2 @@ static int
> __iommu_group_set_domain_internal(struct iommu_group *group,
> >
> > -       /*
> > -        * This is a concurrent attach during device recovery. Reject i=
t until
> > -        * pci_dev_reset_iommu_done() attaches the device to group->dom=
ain.
> > -        */
> > -       if (group->recovery_cnt)
> > -               return -EBUSY;
> > -
>=20
> On a second thought, we may not simply drop this -- IIRC, we added
> it particularly to fence a case where gdevs share the same RID or
> some corner case like that?
>=20

this is by design according to the original commit:

"
    Note that there are two corner cases:
     1. Devices in the same iommu_group
        Since an attachment is always per iommu_group, this means that any
        sibling devices in the iommu_group cannot change domain, to prevent
        race conditions.
    ...
"
