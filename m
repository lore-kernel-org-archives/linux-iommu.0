Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D713516D4E6
	for <iommu@lists.linux.dev>; Wed, 31 Jul 2024 07:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411954; cv=fail; b=Pd0caLZhW6+wh4mgwuuc2hAfEgPDp7LtGzbGUnv4tSnikeXUoBjTX4b/g+fTIOqCiK7oIcRlVE7yKIxLSjFErcxxH3nt+JllUQWDhMPfRS3RQT8QpgvB+yHf97r8bCrxlJGYA6DaDlcsCH0clEWuHm7UWsxxXHz8ysDhQJwDJyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411954; c=relaxed/simple;
	bh=KcQPwzKCJWoSithCjEhnN5wzylBAYyllFn8YuXKY8VU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=itlrnd3khibE45gUi6MC+OXTlXM91bPpKSWmtEHba5HJtm8JOFrtwm9MYMX/GzXKUtpD3XveZj/WxGeW5DBWwMIKa/+S1ZadWGL5WEk3zkSJOusufELsHIaf+vHQ7uYi31K9HUH0phJuycLEODKpEwx/Q9A5/GiKfS9tUX18EbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gkQ0vt56; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gkQ0vt56"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722411951; x=1753947951;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KcQPwzKCJWoSithCjEhnN5wzylBAYyllFn8YuXKY8VU=;
  b=gkQ0vt56PLXbNtc8rxFS8/Nts/O4HK8crzdASqWD5BicIcsegPrh2q+R
   QNp2lh1xXuz3sLrxKO5JEdWNRiW+LZpQJ0/kOObCF9/icOwKc9uwKmwfa
   +u0O+tPvYaMrk+LmIv5e4/YQ88+bylZhX8tbIoB7p4Q7dPL3DOegMwayv
   eMoMy0YV/GSwSvGfpBBwRhBzorO62HfNO0m9xIAxNdXv0wVb/np6iVQ21
   31Jt6fGudRsXF07FL9GzvJZDT7NVuOlnPO/Dy6/ZRt9PCE3Lib2DTIhuV
   s9j57n0227KcGEiZTvz8e5vl6eEzbDafZQpRufw3ruE0Z+wvGGNTp3zyP
   Q==;
X-CSE-ConnectionGUID: lQZkcObZSEO26fq21AHoUg==
X-CSE-MsgGUID: EHZC4fbIQMOh2EFmHRIpJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="30935857"
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="30935857"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 00:45:51 -0700
X-CSE-ConnectionGUID: 69BxjWZCRjKBX56+b/a6ZA==
X-CSE-MsgGUID: kemKgVTVT4+FbQlQ3lfEew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="54598672"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jul 2024 00:45:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 00:45:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 31 Jul 2024 00:45:50 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 00:45:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/qGKrUIoH77upW3Ei3evnftMQER0Y+Azo9DJlYgh9CUlJK3s+Wyu/+o2fu4OKgs4I3UyUkIev8rDaonEjHBx0AShO0UBxNkw2GDmSgZfi3Oj067Gv01yAl6jtm0xmQjd3o8lZQrF800Ljad1aukn3BtVWb0pqLjA/QPs14iVbqFoP3hqea+XzWNPjqJrxduP6j9nECXzqHcEqgesyoOUj3q9Kz7cPC/UdN/QMyD0DSEfovPJhzIca800M/e8OoaaETsEPw+/nXRWaE+NURK9Erz9OuRhov1zdVuQX1Sw3bnt3bG1KBBsBOfTP06WtkXccc60TljL9ZL+z4hCRagug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iWyryHnpEyJRiXdQCTimesM994mbl7A96dTcsnE+wM=;
 b=jlEVFxzZ0Y1poCtk7XMOlmCsp1V8PU0sRnA73oMmEfNl/oarxjLLajyapFWtdioq+FMFa9rfHLthgBSRSHb7PD/4o6cxtxCMvRDllAEA8J3jHoYyn4Wm2Acu41M2w6any4gPCdh8w2spcr2VrFs/V7ceJWstQA9q5zXdPyELNiebWOzmE06+Q54rQ2M7Sos7m50jiEa5s6gtWOuznM9s14pFMhiSkkc7saCQpuPeDdFM/mjid+kdwr+iBqHcngvdwRcjfnutiXAQPZqfsYJvaxvVXulG5shbqciJgpkkhiNLiupSund+OgTyjZV6LJTvZYu+XeRIIkkW/veEDbiLEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6329.namprd11.prod.outlook.com (2603:10b6:510:1ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 07:45:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 07:45:46 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iommufd: Enforce IOMMU_RESV_SW_MSI upon hwpt_paging
 allocation
Thread-Topic: [PATCH] iommufd: Enforce IOMMU_RESV_SW_MSI upon hwpt_paging
 allocation
Thread-Index: AQHa4UkZdMuTQ3BgnUqTgvFTxUSDHrIQcNjw
Date: Wed, 31 Jul 2024 07:45:46 +0000
Message-ID: <BN9PR11MB5276497781C96415272E6FED8CB12@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240728235106.2435208-1-nicolinc@nvidia.com>
In-Reply-To: <20240728235106.2435208-1-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6329:EE_
x-ms-office365-filtering-correlation-id: f906ba04-327b-4564-997d-08dcb134c9e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/pCZmScHIajBMc7i3uqhdpnECyWptiZFuNkabTsrpCgi7wfGjlOjpuKbBDHA?=
 =?us-ascii?Q?oxC09oQbPrDhymBpfJ/h7ZGdumgIUU/kJ6q4BjcDCORbDozwX9l7z9jPLa8d?=
 =?us-ascii?Q?dbwCGhC4YivyB8evdwvM0kTfnqrptS3V7bQzhYoOZ2kgXJqC5gGRi5Ie7Nk5?=
 =?us-ascii?Q?DfBGLKkB6KL+KTif3KxftJpmxRAKJprXSgGjckxt3khJSsNJVYIe4ZieyGAg?=
 =?us-ascii?Q?fU6iOxLKqbj0wjsxUCFVM5uzWkO0dEENf2sEM5yBzs/gr0N0umCYpaXZ4PxX?=
 =?us-ascii?Q?rA86PoDp62AWQyf036STp//Bi2Obe+l6uHfVzgonDLXRZHubxv7YYt+guKST?=
 =?us-ascii?Q?AdEk1cHityDk5RZcV+QQ/TbMIj3aCPPi0wTUv3ou7/PYBmz4X2kJU5YNDiz+?=
 =?us-ascii?Q?d+jIM7JJ7D1fmtLskfkZu9aZ74xSI+NZrDEq5+lkdWPgSUeRT/UCdVslk5Jp?=
 =?us-ascii?Q?oPrU0PEBZ/4tz78bqvWj8HDKG1KKmwTy7BI1M1YDcrVdLzwhOFK/cRRnHfE+?=
 =?us-ascii?Q?ghUuGdcJ2pMx+rXGZ69x5KMyA2EoaSEjnDE4wElhwWxyn2g3ESbilXWqy2fu?=
 =?us-ascii?Q?+5Ozebe4B/OmTAQOrvgcIux5Fs2F1EjFHEhEIHSoRhRe41spZhU5/JnFXXm4?=
 =?us-ascii?Q?u8uuHPLN3jnRNZFWP9E65we1ulKvvEgNEvvVbbpWYZ8Jfp+9LiJaXfIbLEFu?=
 =?us-ascii?Q?xV8QSDCWg9bn2XJgqfU1qVKuNqeNyu0639AX08GlWQyCgY7g8OTUGL75dTv6?=
 =?us-ascii?Q?p9KCUjUPvq+YmWb4ib12e1gXiH6TV8uCv0mpbUS2fTh99c7HvUd1ptuCJQU1?=
 =?us-ascii?Q?rBQFT7OHZGnQ2qr+/YnkR7nlUGlGPJo/vLq73Z/voJHUG09j9lTM/JXl4jd2?=
 =?us-ascii?Q?pZqoyYnnRVu+f5K8ZFX5LGIsli62NZJuEXCxRWEtD9d8HVYVdJPPW8EB7g4C?=
 =?us-ascii?Q?B7fJX/qW+FI4dqs+VISZ3Uol5dBfs//nFhz/ao740ILWTs4aEcN4GFQo6iYa?=
 =?us-ascii?Q?VGBFqPM5zoeZZH1OVzjxO+4vH1fiPlfoSXZzpAPR1xPhM38Q5PXquiuAV6n2?=
 =?us-ascii?Q?nWHlY6SWBnaA1NnnZHf30fogzFDT1QmDChnNbfP11HFcF7htNO/zO6NT6arl?=
 =?us-ascii?Q?iag5zZaitlY9sE4wxjA5hF6Aoi5SO1IOK8BfMU6CCZdUBk8iP9VeymzKdsZJ?=
 =?us-ascii?Q?ThasuiqhWRDsFp1cnFVP8B5hTi51waTa0SIg/rFo6y90M2l6796oFL/IJazb?=
 =?us-ascii?Q?PNpxliGsGy9WP4vv5cjgzYGS+1hJaGDoY+hOa0n+cCP1PloamYkbWzgeDrny?=
 =?us-ascii?Q?9f4zlwdjSezN1l3q5i1l8emrRS5Mcb8Ogs+jv/pqrEqxVtaeN5oTBc+lZd/L?=
 =?us-ascii?Q?kbP8QDmSW//9w18z3FerC30XwvsuxqukdCzJ4drPOh18IAbHhA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RVyK6j2BE4X+KxhnNRv3JgLrwGMPG1YFfJgdpPiQWCHQsBU+SDWlkMWgstpQ?=
 =?us-ascii?Q?a/y4pROud90SXEoNv3ZXVBN5ivJ0qcDsIKGhnV4b+iMpx91SZLi1t8aQMbux?=
 =?us-ascii?Q?4niHO6Zn750fT0lfEnVV1u4l5gMcWB9lwrdYDQdlbHSCabG6K6gRwPnyc7jU?=
 =?us-ascii?Q?+vTUhc4B0yTACB/6EDb4bAdjPr2Gsq1mOmZKY9HuTdQvPgGHmdQJTaBCut2S?=
 =?us-ascii?Q?KzLUsTcqq+if1EGh2fJP/BVsJ8UYzgCjLqcipkPziGPKjdodMz1URGmdPhT7?=
 =?us-ascii?Q?KtEs3bsR/es+2B6kYIS79r+pwMDw6sJGFmj4l63Uxjqw6J07VR/syFlqEQas?=
 =?us-ascii?Q?jraM+dXS84fBimFBAXJ1v0uU3CSeIoCclO70BW99ydU0C4asssLHk2oKkeeF?=
 =?us-ascii?Q?YxNOQpYN665ffuQaFkSu0aTatAywvQ7EipWuIXd6vaZcpZJPH5o8b1i6pUNV?=
 =?us-ascii?Q?khlJsiGzr1YBbQC6xkEn3fJe2Lk/2gXo+Xsrp7ckIbCvhNsr2brNUL8ebvsc?=
 =?us-ascii?Q?/0FeQODW9SYWOeqA+TMjxALVB/3UmgmifqFov4ocvq/r3EjRf+jo6/0kcGYc?=
 =?us-ascii?Q?jRAPlszTm9XIXWQmNCPvA3QYYMLMaqOatTuZr9t4vXaDwLO5fKEpU0GManY6?=
 =?us-ascii?Q?xSL/3oEBbJCiXuURCECqWJwaiHeqiTqoU52FhKdR4IlyDFz7Q33nc566tSy8?=
 =?us-ascii?Q?to+SlD7ewVQuhrTE2BosMRC36B/NWFtlr+4A+f31FemPS5KlwRiaL6Zh6ZLI?=
 =?us-ascii?Q?eTn/bjJhS+lP53KgpiC9QRFdGbYt2McKRb/LysOAcOW5jw4ZiaDatNyjcehP?=
 =?us-ascii?Q?5AQCwj1VqacK/um9umS5GxqIdREVD2ZMOoWKaWPoDkCO+jXNX3LcPojI28+z?=
 =?us-ascii?Q?vkIgSFsk2Iqo2kxfO4mkPvK0xhNJ4ovav30YqW86DBbz/+jDcxjD8aVCiGFW?=
 =?us-ascii?Q?MPAp16Z7ng0fFd3gFUFbsy4dOzppAeTQHzACORLoxy4Xylhug6Lye1fzp1rR?=
 =?us-ascii?Q?KYECd1qr3tp8OXZ3w3zYcqOOrkdxBQVLH3Waq6HN2/JWkvv8Ov9g7bApmmxX?=
 =?us-ascii?Q?hcqWrT4ZUjvlEJiAjNNuwsOb4KXspQXocxqo3Xt0+miFgzWQE7yzro/NOskk?=
 =?us-ascii?Q?22l75I0eDfmfPkEUfTpdqHE6VyuIoXD3yjJVB75JwRPLd3357CXIXST/+iP6?=
 =?us-ascii?Q?qgjKXnqkOBBAYFr7D+4/TIsq62jRAq3gQCkb2SQz9O6CMoWX/Ve8Dc6AzBOY?=
 =?us-ascii?Q?erXd2ygXoKzwZC3ZYAixMRm6Zf5IytAd8NAqMFsN8nEhrPDUlEdtizoDIjqN?=
 =?us-ascii?Q?oLBgV67lj2Pp2jOd+LoKeHcC/WGpiTr0l1P3ddFW1dq4gWAfsf1RuifE44qH?=
 =?us-ascii?Q?ynTQYexalgCmYx0oT9GYcIHQs4THiaMBP0Ys+Bd8VNRzGnHzyppljL2bLTbu?=
 =?us-ascii?Q?ZEeLdB+LhqZfOt25IjvY0U7bBLnQxiAIXY4cEZtuhvzR6JfUxKz8rV4WpCST?=
 =?us-ascii?Q?eVYW30/schmJIeLap7+wBlEJ8a+x+zgrtroTLWDEhvCR7AELoe24S725kPS/?=
 =?us-ascii?Q?F0Ndtgs6R6HyWTMa+ONm0po0hoFaPaTiUZxuaym+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f906ba04-327b-4564-997d-08dcb134c9e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 07:45:46.2914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3nR32kl7lG26BQNjSA6bpLYlvWiSStvPZXooWvweQpSEhz22Pwk2gInY2lEHF8ikVKEer28ot6DqbqwAcZB4Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6329
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Monday, July 29, 2024 7:51 AM
>=20
> IOMMU_RESV_SW_MSI is a unique region defined by an IOMMU driver.
> Though it
> is eventually used by a device for address translation to an MSI location
> (including nested cases), practically it is a universal region across all
> domains allocated for the IOMMU that defines it.
>=20
> Currently IOMMUFD core fetches and reserves the region during an attach t=
o
> an hwpt_paging. It works with a hwpt_paging-only case, but might not work
> with a nested case where a device could directly attach to a hwpt_nested,
> bypassing the hwpt_paging attachment.

This probably needs a bit more context. IIUC it's the ARM-side choice
that instead of letting VMM emulate a vITS for S1 and then map it to
physical ITS range in S2 it relies on the kernel to continue the msi
cookie reservation in S2 and then expects the guest to identity map
it in S1.

With that context if a device is directly attached to a hwpt_nested,
hwpt_paging attachment is bypassed including the msi doorbell
setup on the parent S2 then it's broken.

> @@ -364,7 +305,8 @@ int iommufd_hw_pagetable_attach(struct
> iommufd_hw_pagetable *hwpt,
>  	}
>=20
>  	if (hwpt_is_paging(hwpt)) {
> -		rc =3D iommufd_hwpt_paging_attach(to_hwpt_paging(hwpt),
> idev);
> +		rc =3D iopt_table_enforce_dev_resv_regions(
> +				&to_hwpt_paging(hwpt)->ioas->iopt, idev-
> >dev);

Is it simpler to extend the original operation to the parent S2 when
it's hwpt_nested?

The name iommufd_hwpt_paging_attach() is a bit misleading. The
actual work there is all about reservations. It doesn't change any
tracking structure about attachment between device and hwpt.

The only downside is unnecessarily reserved regions of dev1
(attached to hwpt_nested) added to S2 which might be directly
attached only by dev2 so the available ranges for dev2 are
unnecessarily shrunk.

but I'm not sure that would be a real problem in practice, given
1) there is no usage using up closely the entire IOVA space yet,
2) guest may change the viommu mode to switch between nested
   and paging then VMM has to take all devices' reserved regions
   into consideration anyway, when composing the GPA space.

With that I think continuing this per-device reservation scheme is
easier than adding specific reservation for SW_MSI at hwpt creation
time and then further requiring check at attach time to verify=20
the attached device is allocated with the same address as the one
during allocation.
