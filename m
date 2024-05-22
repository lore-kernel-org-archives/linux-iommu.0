Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90737F470
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716368326; cv=fail; b=JeUipzi2PEuTSNTfiWZRT8+mkfvVvUYIbr0wydOhIaqSgUF8GLILrI7eHSRAjv6R1CG57nf7AjW2lThPybzQGNvU+WGlR6E+ZckGdVxBeuQl//vSvZ1JC694v++VfGJ5nApCNnOw4Zo3TT2G0lT0Quzt1VwlJ4KLAwSPCcaD4ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716368326; c=relaxed/simple;
	bh=DnvWNexRZZIX+lteaBGlDe2IB5R741hUvKl24B57e/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tKRTqBhrq75DHXN7Xwl1Dno1TggiaDZeK7DIitOe7hTyx+ffs4MZpDTFhnt7yD8KAVMkw2220mmJ4+ZyLdVJvNHWZXfofgo3gUC54QC4ykSkzySNgSDGdce14ub0zUhq/v7W8eBaxWK21FPwXTWoGYxcbXzGAvh4MZBq6NE+vQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjWpq6P8; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjWpq6P8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716368325; x=1747904325;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DnvWNexRZZIX+lteaBGlDe2IB5R741hUvKl24B57e/o=;
  b=fjWpq6P8mDlDYCqwAMiAfcjI7pi/ceqH1owTvdetXLe7xDFvEnp1wbV7
   pfFv54wbbKJ6OJGeGfnOSC7mmOFDZvuoVDRAejs166edK1HEq0ORsT08V
   U1WFa93G3qrSw+I7XP9+1YFdqtC+/3KgdF7atiYKn5yWSQHmksK2+dwzv
   qSZ7adDQ50EhNf1XKNg5VR38iCmXRnO7i0h9F9hgdDsvahSKlgH7rcd/8
   X+0XiD9Q96GwVyRP0ZuvUTY69y/nXlOG+2h1nEB+9mGY+EXenqc3hD5aR
   hZf9+rtIywXCir6Dn9gkvvNvn3kd7Q/07PyFRtVgUIG4cT+A3YkSy8C97
   Q==;
X-CSE-ConnectionGUID: GYGjr6SKSaiTPUotYpvV7w==
X-CSE-MsgGUID: xKNCXfv5Qk6yhWShDAayVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12389349"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="12389349"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 01:58:37 -0700
X-CSE-ConnectionGUID: 9mOC7TGSRtuHsd/KesZaeg==
X-CSE-MsgGUID: oNQDciJKRaWEIKh7fwG7Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="37699748"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 01:58:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 01:58:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 01:58:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 01:58:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 01:58:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQHO+wCGo6Nj4+pcATQT5KDJBiXGPUDyUdAznqojwI6IiAZfGMcbElFx6RvkoGFTs466DX5biWkVqQRInu+OtHi0YZLW1IslEdKSfPzhhIQM848xzKNUpFDs7L2jhFjdlgO5dvgewFc81wCLTgb638qOA55jbE5eygfEjbvaG+xAwMW7EoHxVYydWGKGHJLh+RXtEQqNuKwHFAtxsrxcRY16D2rGBNyT6LT57Z7vP61/kUjtwJQvUdQCqV77nXSjdoy+n+oQDtlh+r6a4juiF8NIgurrkiiTI9/GR2F7oeEbKmcVmK8Q7v4u8qveMrhYiyEy6y0G8qqI33WeYqN/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boIVMhXg74PG4BHj0GQvTIPc0pNGKHYVUCir/nSOPSM=;
 b=QCrNbdQAinEOe5Qz+5CRHTLDgv7kg7bdvOsII14RsDU5yJPGuIUSTx8z8Zb9nZU3N9ucKx1Ksk3meBt0LV1Y3HlBtOM75yWVEKScGYvgkk4BkL5Y2ptZZUb/gvVUt+HNv/Kfor9p84GuNb6AWM9c1Ccemn0MQ/NEUxJZt2gY06Ec67F7MDl9g/P2yqmo2S77mNYC79UU1yNgQyFfoVvu/ctHMlqwkMi/PNWtc6U+Z3kmSy1WS+dkoCxoCn/Iw5Vsmumal4bkbhuyJfBOeg86PvhPv47O9LUPnspSZA7UOMemGZ/CJwaEw1x87IKQdwxwJwIM8dLMY1BW2RppXVF1rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7849.namprd11.prod.outlook.com (2603:10b6:8:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 08:58:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 08:58:34 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH RFCv1 04/14] iommufd: Add struct iommufd_viommu and
 iommufd_viommu_ops
Thread-Topic: [PATCH RFCv1 04/14] iommufd: Add struct iommufd_viommu and
 iommufd_viommu_ops
Thread-Index: AQHajVVjs28Dvjq/i0qw8WNB6ldTtbGTz8aAgADiWwCAAmGRAIAMGHog
Date: Wed, 22 May 2024 08:58:34 +0000
Message-ID: <BN9PR11MB5276423A0BFBDA8346E1ED3C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <8610498e3fc00000e78bb9cef6fac9f6a54978a4.1712978212.git.nicolinc@nvidia.com>
 <ZkDMSfd9BXmsFfb+@nvidia.com> <ZkGKKoHnykAdGJq6@nvidia.com>
 <ZkOJgvMNFaZZ06OO@nvidia.com>
In-Reply-To: <ZkOJgvMNFaZZ06OO@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7849:EE_
x-ms-office365-filtering-correlation-id: ea0ee4d9-a676-42b9-1d88-08dc7a3d5c89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?m8w92REFtooDgQzkXOGNZ+we4KzDIvEaN8++xSz7A0UUifNdd2sbAoRIFLiC?=
 =?us-ascii?Q?/KDdfGoly+D5f5rdahNUF1bC2KlXIybFtkV1bYrMDTS1Px5T7pjLtSSA4J6S?=
 =?us-ascii?Q?k0wN1Yo4JiISPcQoqLtOaOOV40Drv1Usrqsi51TWoX6MkIgWJebbaNoDHFlo?=
 =?us-ascii?Q?2AHboVf5NhBekckfn+2sSeaMTxB6MmNaVZA2DEf5ANL7g6jc/sKFHH8B/Bl7?=
 =?us-ascii?Q?/gt7R3rCcYu7Grv8//y1u7y9E0gmby6BQ1UdMHLTWuw7Non+NQ05x4beZVUL?=
 =?us-ascii?Q?rX50DCZca6u3esk5AFVJmYMgdZVKH9gb9A6bZlLFZs+HGUOQ1aS25tZQ3eNk?=
 =?us-ascii?Q?qi8vma6Y2WeHXMQ618YSosrri1oiiGiGs+zBmdkf2/i6b94DuQvULhd/EnCU?=
 =?us-ascii?Q?Rvu0rGUrpf0gyntYb/17raNKme21A90nleskGnzj+Y+jyQWHm8WyIjTzNzt9?=
 =?us-ascii?Q?ohy4wTr9/Ur/mqavQI+F1rr1jelDI1FcnN/eAZeYwo8j6w9iahK77CjrRtrW?=
 =?us-ascii?Q?9XFcmLLmKPr/W3hTC3LPPSdbbpm2i7dCUnP23yzXsBh394fvy+W7hIzKDjXf?=
 =?us-ascii?Q?z+Fd44wOuk07ln6XfiMGDCxGS/LSc4lDryHoNTuXgUUKq0BwJtd4Sp4cKR3O?=
 =?us-ascii?Q?1/H8ieAlTwAqLBgv41pfVWmtfWqXEqiaNdiSfgA/lc/xgTNd2Ji7nbk058yJ?=
 =?us-ascii?Q?q+FcdQGFdcg5mV4/bJ6joG89a6ounV6ecOVnSfoUJujQJ/mlyK85GbifVqFQ?=
 =?us-ascii?Q?1+VQNV/851CFQH2a4ZLznPhVtEPL0O/gRckacC8ILlvoBZzRVSsoGJCxcVyW?=
 =?us-ascii?Q?7tU++Xn2NTJoHTaUb+Kh6eWhJNLA+mduq4ZfLBV2l5t6/z7ydBA9x7MRfn4h?=
 =?us-ascii?Q?U9wF2QtMnUbMOMpFc/BkE8j7PG/oBOAhu4GGoHQQ4Q58wpm5CbX4cDHqMZeG?=
 =?us-ascii?Q?KAjJ2dBOY5qneBQdw/ZMM0gN17pFxsn8JEj7dpPD4Omc/sJBWZ1lclYBdzej?=
 =?us-ascii?Q?vrYgQtLPZaLqU/jlscZ+86oqDTayvYPXN5b5zM1hDsf1zg0UkIHorfSoZtYV?=
 =?us-ascii?Q?oaIeElWd/bfjqkdbYRCrG+Fgc8Dw8HUWBo4cH9nFtGcr2F51TficihVOfb56?=
 =?us-ascii?Q?l/SFd+4OKwtJ8I8SX330OgNKPgkfwPh3iM4REnKVVEItNyyi3Ur/tTapLzfz?=
 =?us-ascii?Q?5rWM5elVpbNsy/b8Gl0OEB+YBI7GNNqwi1iplHVfT150MlESHI3jK6KkXQdm?=
 =?us-ascii?Q?DwVhI+y2bqXQa1nftNJBRcHJjVRqTW49i16XhZPwqYjkaESbn1WTD6kV592K?=
 =?us-ascii?Q?SZPqAORLSARhOItu0PxAO8Qc6NkPb0MYk6OayEsUK2aJGA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iZrT61nwssRXoGHJgnouyDye66kSk31CF72VSAxkhS+MLyfCzgnTv3rcRFMS?=
 =?us-ascii?Q?s3ilrivrN6mzd15Pju/vBett4yt7WNMiGXbbUK7gBys3Kx5w1HLBB5lr0tcE?=
 =?us-ascii?Q?kq39WfbtTp7uMQu0pfcdEG4yYmIwTwqciwgxSQVBKPfFVYPwPvS8Y6wHeft/?=
 =?us-ascii?Q?QDVuE0qxSvE1uB/E4P7XORvH2cCcC2Sqy/2j/VPQDsewPB3YHBRO4ZhNTTQB?=
 =?us-ascii?Q?WLvy0sN+KKD9oynW9S7aswDgKPNQ3c/HQkOkLp9uG220KLuvugVXBTbV0FAT?=
 =?us-ascii?Q?zaZMYGNJmZLwS1OGoMDOSJdaTWxwzTn41XGUOTyXW9oskM/mueWXwU6P7Q4m?=
 =?us-ascii?Q?kgjaEWgHBcw9QwdHCx78ZRQi8zyXLobX/ONETRF1sOT6D9pSppPDZ/6mbZJR?=
 =?us-ascii?Q?CHsQ5g4GVtGCNVCnhiba/5mnR/9RLs8lDoR5I3y/qe2LaHj9GN1St5L9epd0?=
 =?us-ascii?Q?jnegLL5rdC8w+eulhjLow64TiJQXalZ0SV+aFJDJ1CE6/Je3u9BkNCKVEO94?=
 =?us-ascii?Q?J1KC/Ky1Hksvy9WE8caCjh471NrBLMGIVNMNHDIkjFxMHM7Gw78nLg2vlzZo?=
 =?us-ascii?Q?Gm15rx3oFswu/i1aw9k/C2BP7qTxJ/ABMWD9EmgUJIwHRuKbhrOhxAhCZzhL?=
 =?us-ascii?Q?FsKFd5YAMZxEk1NOg8k97z9g1UpGlcmsd3HqVtSiz3Ggifox/re5jGq4e8Sj?=
 =?us-ascii?Q?wMVSi7lQ96yKyu119lRi8D8HqyMWszrASt94rJgYFOWHhsv/5WsZcPX05oyJ?=
 =?us-ascii?Q?tA4B1VIch+bHmsw1KgUzjMzAdVmuMI2T3AIj8JaPTtMAHMXYcy7JOKuneNBy?=
 =?us-ascii?Q?V32Y7bWn6H1xmTm/hN8Qui0Qxd3kKSj77JmcTXCKWB6CuaGBNuPT+4vHmmfP?=
 =?us-ascii?Q?ZWSyaLlibeAbjtcv4KhlB04idsPXSlyVVJNdljJUVtCOnLkOYgKgsEOjohXU?=
 =?us-ascii?Q?zzlKlEORA3tLcGh16o4mr/Gmh8lwGYasOevSMF7khdzcHFyby9kwwmX33xGd?=
 =?us-ascii?Q?FK8u27yw2Tc/OsVe68awumWp3Xbo4ATzDMYAekm/pv1ON6czUBe//byebRc+?=
 =?us-ascii?Q?V1bOhuBiYx/NAWUy9VKGgXqHrf0UF3FEc/dw4rXsXb8IvYjzyVl8nHfw9h6X?=
 =?us-ascii?Q?pFNOA2R0FogeO4sFJPOVOmKXkY/7fmxwNKhzsCv4urSRpDL9WqkX3VTLrZPV?=
 =?us-ascii?Q?kkYiL8y7SMIUJv1Ni/02k6QM5xkFtK8v1cODl4/OJMH30t54+H7GES0JCCfJ?=
 =?us-ascii?Q?xu0BZxF7EQgI7S3Nur06luziMCkLk8hbGz3Odxekbs2gorR+CO+xJ2BYnWp4?=
 =?us-ascii?Q?zSipbbeGxqQ9slLBf/fqap6ari+uIRvL5kNndzmIdGe5f2LanbycAled+M0t?=
 =?us-ascii?Q?xmZtewp7gfTbN4Px4biUs+GmihE6vRLitFhQj8NAtQQ3U4GwumyRE5Ujk3Ob?=
 =?us-ascii?Q?nV3VBWkgoJqtwKo1h3EgALyu6dJHnlrlzXgqeyWAacr5VyzUPZEueZ8wLhgZ?=
 =?us-ascii?Q?NeYWWz0MFqXeSVxmriTj3fn79bUPxHyaJInLd60ASI/NZvPskj1vNhYTTNh/?=
 =?us-ascii?Q?YWk3Wj+C2neCeUXqDWP98AEs6rgUrxqitg3rFLnm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0ee4d9-a676-42b9-1d88-08dc7a3d5c89
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 08:58:34.3420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 87waCpnzHFjOig8p5hm/SuubPmRDxImrr6d71VEYzYMsJ8XS7ZI5OhhI9MRFuLGVLjvdr73YZKxfVAV9grCApw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7849
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, May 14, 2024 11:56 PM
>=20
> On Sun, May 12, 2024 at 08:34:02PM -0700, Nicolin Chen wrote:
> > On Sun, May 12, 2024 at 11:03:53AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Apr 12, 2024 at 08:47:01PM -0700, Nicolin Chen wrote:
> > > > Add a new iommufd_viommu core structure to represent a vIOMMU
> instance in
> > > > the user space, typically backed by a HW-accelerated feature of an
> IOMMU,
> > > > e.g. NVIDIA CMDQ-Virtualization (an ARM SMMUv3 extension) and
> AMD Hardware
> > > > Accelerated Virtualized IOMMU (vIOMMU).
> > >
> > > I expect this will also be the only way to pass in an associated KVM,
> > > userspace would supply the kvm when creating the viommu.
> > >
> > > The tricky bit of this flow is how to manage the S2. It is necessary
> > > that the S2 be linked to the viommu:
> > >
> > >  1) ARM BTM requires the VMID to be shared with KVM
> > >  2) AMD and others need the S2 translation because some of the HW
> > >     acceleration is done inside the guest address space
> > >
> > > I haven't looked closely at AMD but presumably the VIOMMU create will
> > > have to install the S2 into a DID or something?
> > >
> > > So we need the S2 to exist before the VIOMMU is created, but the
> > > drivers are going to need some more fixing before that will fully
> > > work.

Can you elaborate on this point? VIOMMU is a dummy container when
it's created and the association to S2 comes relevant only until when
VQUEUE is created inside and linked to a device? then there should be
a window in between allowing the userspace to configure S2.

Not saying against setting S2 up before vIOMMU creation. Just want
to better understand the rationale here.

> > >
> > > Does the nesting domain create need the viommu as well (in place of
> > > the S2 hwpt)? That feels sort of natural.
> >
> > Yes, I had a similar thought initially: each viommu is backed by
> > a nested IOMMU HW, and a special HW accelerator like VCMDQ could
> > be treated as an extension on top of that. It might not be very
> > straightforward like the current design having vintf<->viommu and
> > vcmdq <-> vqueue though...
>=20
> vqueue should be considered a sub object of the viommu and hold a
> refcount on the viommu object for its lifetime.
>=20
> > In that case, we can then support viommu_cache_invalidate, which
> > is quite natural for SMMUv3. Yet, I recall Kevin said that VT-d
> > doesn't want or need that.
>=20
> Right, Intel currently doesn't need it, but I feel like everyone will
> need this eventually as the fast invalidation path is quite important.
>=20

yes, there is no need but I don't see any harm of preparing for such
extension on VT-d. Logically it's clearer, e.g. if we decide to move
device TLB invalidation to a separate uAPI then vIOMMU is certainly
a clearer object to carry it. and hardware extensions really looks like
optimization on software implementations.

and we do need make a decision now, given if we make vIOMMU as
a generic object for all vendors it may have potential impact on
the user page fault support which Baolu is working on. the so-called
fault object will be contained in vIOMMU, which is software managed
on VT-d/SMMU but passed through on AMD. And probably we don't
need another handle mechanism in the attach path, suppose the
vIOMMU object already contains necessary information to find out
iommufd_object for a reported fault.

Baolu, your thoughts?
