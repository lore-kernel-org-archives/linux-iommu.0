Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB05330646
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 06:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691970; cv=fail; b=UduLyC432kY1guqo+/cZyXSL6Q/QDTsVyd0ikd1as63D8sPwdJyykfk7WkVe3WsAUfthbcDBrAQrCwVi48AWoOy5OuqyBuQT/wiAoMz8eMfuVHJkpSyfAtuPpy8pN3tmjzspU1g80Y+vpB6e1u/D489FrryKe8GOpa6iEh6XuaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691970; c=relaxed/simple;
	bh=rnnLvXHvcAkDvZvrHbH/fO2wmxoTYT83/vqLNRw9xuE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vEFJ1iexLyC6T0RDOVorTm1Suaz3Bq4gXYu0CDuFncNX+ZLbhdXLq9nncyqGLWg4ajwXV9gcNrYgaQSgAsOhXpg3PNzAC3KYZz8LaPrjdrVjZs7dUQrnp/dxuIa+0an8qr1nSN63AzGG0y7rrciN9FOEl6dsWNUAHDRuhobQlmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TZZIEjcB; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZZIEjcB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779691967; x=1811227967;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rnnLvXHvcAkDvZvrHbH/fO2wmxoTYT83/vqLNRw9xuE=;
  b=TZZIEjcBKG9rZ1whm7Tqbg3ZtoYrQmnMhYQBToURdXtmkr8YiWPQc0TO
   B9MxWPnE2BwNqOLa2fbdmx0kknfDHIicAG3l8D6OB3EAIrviGvTll0Dm/
   T04Va8f1RLXBT1rpmUChFS+Xb7ztMNHpBPQ2xhE/QNNebJiPjNsxjqf97
   m+C4xtk5LWamJOAXpA1jwJ7uuI23QVj+Hemp8qmPtk6t6Fx66xpn8zqnW
   r5kPdBqjjHdt7UNPWunxzi2Cnp4BJPU6dSygsTl+jp8bU4W3bJIwXJzyd
   RgnfPOlBwPsjdFphBWVhoyUyLvGHOWGDpOSvm0sdvMyyQS26hsU08eth7
   g==;
X-CSE-ConnectionGUID: fut/5+yNSIaQo+W86WiZKQ==
X-CSE-MsgGUID: cCcejCbDTI2Vz9rcCqoskw==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="80627817"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="80627817"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 23:52:43 -0700
X-CSE-ConnectionGUID: MoETkZFjThiOLiGH2WV0UQ==
X-CSE-MsgGUID: tGkduGsrSCWSyEBG7klUBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="245796882"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 23:52:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 24 May 2026 23:52:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 24 May 2026 23:52:42 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 24 May 2026 23:52:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9Qooj4UAgnckV0EEB3sUaDY4qkLRY6gWoLzX2VRDYlS47dBok4ekRmoVsNz6bE7g578CT2HGvkZ6e22bFUhnw5wCqJtYHqe4XErO2oplxUCpTJ8TXHN04DvoVTBbu+Zf8+JU3A/gFX4vgR3H9/DB7J8IjqGfSiO70tSP29k5wb9rLx9zjvWWCtrYN6Bs/f20qG9GqEZ335H771miJDrRcffdH39+Tb6iFNLaywTCySS7jdnDxsEATNq2JP6Gxa3bLtcVMdS1NM+U1Io6MBB+DkV8cI0ITUdULG2LdNuLixPFPu5r6cPwZ9FNvN4VW5g4m/d2qskP6sx2B1Poy89cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnnLvXHvcAkDvZvrHbH/fO2wmxoTYT83/vqLNRw9xuE=;
 b=DjKOy1QLALbSDG8luZgH0e6iERXYoUZrdghDmqMS/o01wj08/CyJwe6xIrf0wVqs177XoJNRTSly8IXqVEh/G7U8iWCiH2z/u6cgMNb10sJvCTBgXvIVuMVePrpasl3ow8IHUz/3sB60KCAq5xuyqxIUBE5Y5Hal6rSs/07fZqBldKCHCfpC7vxPOyllwpKujtlhY0Zj/RBwCT+E2qrz4GfYOAjs2tvGSAyqIR2J8BwYAjEJBIyUkift6q8CP0TcCxO9vhg6IAj/fdyhsqgn5t8a+FWmqH8UCN96PjYGu3o5E8weT+TprZY6Z4YUgHK5JR800c/Lx9iDz7AQQtGZ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM3PR11MB8670.namprd11.prod.outlook.com (2603:10b6:0:3d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.19; Mon, 25 May 2026 06:52:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:52:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH rc v2 3/4] iommufd: Set veventq_depth upper bound
Thread-Topic: [PATCH rc v2 3/4] iommufd: Set veventq_depth upper bound
Thread-Index: AQHc6YMnjmLn+HAB70Sneq2KEg4TNbYeUm+Q
Date: Mon, 25 May 2026 06:52:38 +0000
Message-ID: <BN9PR11MB5276B7CEF4820392B53BD4308C0A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1779408671.git.nicolinc@nvidia.com>
 <8426cbaa5e8294472ec7f076ef427cc473be5985.1779408671.git.nicolinc@nvidia.com>
In-Reply-To: <8426cbaa5e8294472ec7f076ef427cc473be5985.1779408671.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM3PR11MB8670:EE_
x-ms-office365-filtering-correlation-id: 13febf73-aef3-479f-5783-08deba2a3594
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|11063799006|4143699003|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: cJpUujBFXYpYnodDJZawn50HlHJ1za2XMBn7oMHEgUfvX+dJyCvvx/LGH7eBL1m0mmeYIV1OyY/IC4j/WVY7/JlJ3WhHvq2AUz9UhgF0uIU51sOD+igW8hf+0LDT/xLAj/8c0VVcBuxVXsB+FepJ+ih/WiKAYBMl+BLyDCJBowyeLxnDf/esccWDrDpj0iMwxGDfLxlSCY69d5vXFbAIMprGfmOgtpb7n2swAhp8yMaIqHo/kWbJodW5ALTpNbgSnUdFFXzsEzyPpPv944SNZUizQQUnuqRqOBkin3L96RBZwRquL3xKE21YQvQOc25p0QVN/e8EdNLr9h/I4LA131EhronlcRpa+2nxsew13VrOxYpp4bo7iIiTe38CoBD3jtbrXOJaFhokmySyYFwfp4Zzol4nmwFFws+3OMWP0nqAcgmDbo2IxIimWpkwCfD1YbA2pOMGGoUeCH0Mu/SEdNUX0urq8ZZpDaNnM9MRB9fN5OGIBMxpo2IuVM2Gsgbi9ec8UlQssWyV0TfcVs7Ht0G5keSS7hmSkzLnizza2Bk0DsRHwy9B8PNDV4iV5VxQqfz702fwnIwq4kfW/xaclK4RSZq8ChTEBKH0qDDIyNbAUdGU/jhUhIBPuD9HcOEzTTxZ6G7C218ziQ6SEARwe/GnMO+yVVa15qPCxXBpXFXpZRyrbvGvVrqwLnEPdHZbK+l/hM5ey1+BxST7cPWoFWUD6mCntdmjD1liS+oO0PejPnjh6juLGFJ1IiGmQzT2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(11063799006)(4143699003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2aXcCgNpSvDpMLvQssVanA8pTLIFh3/fygbhCDz23JXVz9IOu5x3dZh1j06t?=
 =?us-ascii?Q?r+5l9UitttZ8dQ3oLAj9HBfbZmJxwG7RVBB003nRl+86Pia7NGNP8ZSXbNlz?=
 =?us-ascii?Q?8fdudYVbFaT/FtFrwEm7Lbhf+/dw2CRB32NuqrbUeYKufAJC8NOAdOsV/JCU?=
 =?us-ascii?Q?DSklY9aIRBpljgDziZpVnJWPtRKM7blXhSmVaJHFnsI10oLdU4AQnwXzGW+2?=
 =?us-ascii?Q?aVh7/ZJDIOv2qpctpXYPu2WF78Iwt6DfYa8HPq+wn4CcKkumLJh18hqI1JwR?=
 =?us-ascii?Q?47KnhsbANy0RWQZSfEn3LrkjodI+nUIE+wIKWD88/OzaQxl01+eGKay+4O1d?=
 =?us-ascii?Q?oNxbyUzNF3WcCcAFZbZu6Hher6k/PnUi1HBRUoF+3q0ktq3kZY9dYURnnep1?=
 =?us-ascii?Q?ccbaP0sIoGa66FB2LTl01ayvkun9Y5PI/5jjMEdNP4lXD6bzNvB6ETkfCgV9?=
 =?us-ascii?Q?yhnJYUksdg+1eiiX+dp2hzgb0987MQjpcNJQA1Ell2nB7t7MWzF5FyLsdoHE?=
 =?us-ascii?Q?uKU7WgKLBrLSWD/heDyRrTQaSMYLfdHWDtACAVpQDY+YKHTBJN6dVExqUSXc?=
 =?us-ascii?Q?EDmYF/kxEyKsulKyXFsHxJBHA2J9kOkVP04xGPtxITeEXB7FzmfG7Zruas10?=
 =?us-ascii?Q?AN0MqTTd1LX0MhgKQDiIHQzQCJNfr2t0GaS7aPfxWJxZD5I050pO7qNm9P8O?=
 =?us-ascii?Q?8CcW+a+wloeUDuGfUV0adPWhM6gEAg4Npz99HcKS6HPU4Qyk9s8Eq3I/YfUx?=
 =?us-ascii?Q?3q+67DOMMfh85L9TG+k8K8XUKvXTb81kplt9EfG5p9Sq6Hz4/yjTa5clupEs?=
 =?us-ascii?Q?1Iu9wn0/JGddGck+Y1KcIykl7ekLcPUr66NGwky7IDN2RrUEjWYUKkE1zIGo?=
 =?us-ascii?Q?rv/tqQaaD76guWVT2K7LCl5XXLKJGGrf/0EibOK10RzTOS1LwJ5lE+2sJroJ?=
 =?us-ascii?Q?vbDYpZBsIDmUq7er3N5myG8Xf9UD/YCD0VNznGRZNA/VWNH2+23Rjyi7O+O/?=
 =?us-ascii?Q?jmatxjz804b1zMlWcmg1y1krObMwlL6dS8KBTC/HukU0+NruX9JQo6xv3eaq?=
 =?us-ascii?Q?zc8Q+5i/U58lBA+CEzt1XhDjoUyrFAyalgIxuUDChV4VQguCmIwLoNU+wyZ/?=
 =?us-ascii?Q?Z+rk62Lq37w43oZ34XksKJ7k0Mw05+ZT/c4v/ewiTe5OsREOZTQAOPBP1yjM?=
 =?us-ascii?Q?2uxavZaRglA2Lw0k2bmPb79py7avLB6x/EJfifJGC5sMjDVLCXVGcSB2Pe7M?=
 =?us-ascii?Q?tASsxfPoxvdzMwAeiuTKCAG5SPVAd1nL9bK5/jzJvU0P1eF4wKewzdaduxUB?=
 =?us-ascii?Q?OZanB0syEjq0JcEYffKYbXORPwCPmOuKAvGXVkfxImQCjwgV+aRnXrLD9Pd2?=
 =?us-ascii?Q?iyuXWv6uzrfHIJrZdPKQbCeyP1I7/5CbdPMLMFoKmxpdPuJncBynxuEvNClc?=
 =?us-ascii?Q?EvXLIXiFwyt+I0AYEM/VWfF8fTxekzSn16Lop0Ig/p+ub7cE1X+yyDJp9pxi?=
 =?us-ascii?Q?DAqR14nXHLUdvUaueSeJcn8+QFtWXGYzj62S0fxUJh0w8AmlA6rVqD6twIk6?=
 =?us-ascii?Q?JaOMThtkDhxXPqYzMm0veo4wGvSH8olOn2lDdXtXP02v5U9owTBDgyHhl5JH?=
 =?us-ascii?Q?X05IPq3vkkzuRdQGXlEjutCqOWybJWjLkT2BtCbeGJ7UEts+NarssO6lIsbb?=
 =?us-ascii?Q?OR0MRlRwiZiqJO7aQLclOOAAgCE05IwoyBgQ/FrLdR68Hd+uz7Vtbxyc+Jb4?=
 =?us-ascii?Q?DSuX/iH/Hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Xl595Rk32EFP4165xG2bEuqytnPQdguHjgrH7tX0cGLX1tjRfRNW/CqACRapMxiC23PxBPmu4Hv2h4JWlC/qOiYAvIqo6gVFfO8kFRGdgPqATlJRHgjPgQFZrjpF5jDcxInNr62vxSEsHT4phjfhur05PLqZRNGomjGs9Lzb1mikohiLKRV5rQQRvXHpgMfNsTIoGQUsRd9vk0Vi+3CHclg+wNQvwue+G4SJv43FPTr0eJfZcz/Z5+OYoDLyQbI8OyShA1N4HHOS3dQ18SBP0MnaA5SfDxlw3wNK+C0Iog40FiEoqa3I70hxjNflXPUJXl8mbp4WHN856zsFSD79LQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13febf73-aef3-479f-5783-08deba2a3594
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 06:52:38.3102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iVNg7vedD+tUv65tdTOoSwSkcVNDS7u8VimB9QJ20uwqwJVcnNfqut5iW65xh6JD1Lj/YMRI+eUYe6sClrwPeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8670
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, May 22, 2026 8:37 AM
>=20
> iommufd_veventq_alloc() accepts any !0 veventq_depth from userspace,
> with
> an upper bound at U32_MAX.
>=20
> This leaves a vulnerability where userspace can allocate excessively larg=
e
> queues to exhaust kernel memory reserves.
>=20
> Cap the veventq_depth (maximum number of entries) to 1 << 19, matching
> the
> maximum number of entries in the SMMUv3 EVTQ (the largest use case
> today).

probably add a comment to uapi header that the maximum number of
supported veventq depth is implementation specific hence user may
expect -EINVAL returned if the specified value is too large?

>=20
> Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and
> IOMMUFD_CMD_VEVENTQ_ALLOC")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
