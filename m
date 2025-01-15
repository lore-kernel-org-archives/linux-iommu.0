Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AC54C6C
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 05:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736918732; cv=fail; b=OoxEqbheGGFUAND9av44h1Y610u06l+Hn6PgsdpI8xMd8gmE91r2lqD/tH02gziX8YHJxuzhsFrsd78XWxnO7YVdJORdfDDfGsG0QiYXL09jSvyleJHm6jatjgC84EOgT4SCqVxOkHRf3rU0iMvaFIP33TQttIopP/obt4GSQvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736918732; c=relaxed/simple;
	bh=+MueGyr5AkSgBt1cHgSB1WRyLEmq7hS/wJDzCwloO4U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rehc2sOJnMlMQKRzxg/kQ9LkKsmN86xXgkjoQ/Aw6W0xHUvrUjSUcD+Jy51IwFK0AESLZ3RLK+PELtMI2eudIlUoThbJqsLp3zwZwQzEaFRc6djZGytRSDXMVyoee1YJRZpUyV4ix/N78f3efclTKDbmrmxHqWmoYnEfQv52cjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a71ppX9y; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a71ppX9y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736918730; x=1768454730;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+MueGyr5AkSgBt1cHgSB1WRyLEmq7hS/wJDzCwloO4U=;
  b=a71ppX9yHy4148XwRNPVwKZS4MjZvU6BQdxhZVxCwkBTLrrF+0PtnP8V
   Ao8eFzua/8AdOa8otJhcaq/ttCibSqIXCBmm/WAQTRsH62fzVhRSDjqxj
   wvINQUO2Ebn5fsVQFPpFUujSzGBaqECovPo9shn7n/WwCzXCsGW5VyXdp
   zUTIEzgZXZqJM+D2ANJQCHoCiFju9KT23ikXuRAS73a5B991Zem3+Qr0D
   MtMCBz5drytG8Nsoyq8DLEHTkVKaxPFSrGXSveniXV1c7GjpQ69n0sBsG
   lTJ/x8ZFP03+PdAUidF7qGP2nWmQTn42SeCHzIC00DrMyTYOJdkfeovQd
   Q==;
X-CSE-ConnectionGUID: 0tJ5/hUtQGSzF67Qa1Suzg==
X-CSE-MsgGUID: yLGumvGQSfKbPL8Ew8voAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37266524"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="37266524"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 21:25:29 -0800
X-CSE-ConnectionGUID: v2fAEm27Sm2wkF5lwzMaqw==
X-CSE-MsgGUID: ZD7co82CSLyjqvRr8dEvTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="105208571"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 21:25:28 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 21:25:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 21:25:27 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 21:25:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hY3HDjiVs7U3pWRgf90hefwlB9t5EN9dtVfeyKhZd2/rI256vJ1363+cCojc/hv9ZEqsiUxWay9yxcqhbH0Bmt7kmNonzJ0sZLo2UMdpwMqqibxP3AqGnYD74Ornko1o88Z+rN88BzHL73eHF3DzMX7+t5sKHMYWs+jghs3wON+eDIFstSx4+AUKue4/fIXM4NfsLVLUaTDF8xNhF9Pg/yuNg+6NjVqH3uEceJNykv80GZVnoOJx1Ez+FTNWx1TwDBV87FZzIJC4h2zGYMwfIIpUMaRNu677eMzhXcvUgTLbCYAYCZxF7ZdCCbtwFQGX/25QQmpK6jX2aeJECf9BfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sv+rel7NzjvBKtMahyQRfU0vBZIOZS9/CO957xE5ALo=;
 b=my+F6k9xsL8/NHkNkeGecoius5FNKW5VLmJvMmhJXl2m7AOSJSaSvDAfaMq0vzUKGbl6uSURZ1nXnN72rSfBxRON5VTUwnRdJlvcdv/zNkzPpIxS72s4Dz9MfyoRNkz1HhuYkDS6cTTZSO7f9VJeVmFGJMiAankz8Lw5OrgYgDPIEQFRNNPIcGD6sIpy63PO9vmlDGHeNJ4EOpv05JHD5o6ld7tuRuDe/79e1AaF2gYD5m2hgU81M+yqvpf75tlYLx5OdP4h2APOpCYDESLmS2X1WWbT+VS0IRe/raUuZdPBr/wIbsqOmcXP7p3zsMrsmQFd6EYF/4sfn2pzs64blA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB8372.namprd11.prod.outlook.com (2603:10b6:a03:539::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 05:24:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 05:24:44 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: RE: [PATCH rc 2/2] iommufd/fault: Use a separate spinlock to protect
 fault->deliver list
Thread-Topic: [PATCH rc 2/2] iommufd/fault: Use a separate spinlock to protect
 fault->deliver list
Thread-Index: AQHbZtwly3bivbYuAkGwJr/VUWth0bMXS9nA
Date: Wed, 15 Jan 2025 05:24:44 +0000
Message-ID: <BN9PR11MB52769D7C88B3DBBB4DF3A0028C192@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1736894696.git.nicolinc@nvidia.com>
 <56c73c27b572e9c677182e99b5244184bdef7541.1736894696.git.nicolinc@nvidia.com>
In-Reply-To: <56c73c27b572e9c677182e99b5244184bdef7541.1736894696.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB8372:EE_
x-ms-office365-filtering-correlation-id: 763bc7d1-7eb5-4565-cf43-08dd3524ebb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JDUbQOZgicP03utD9oauiKa0tZ7Ik/60L70ebGGrCssXhC13xmlynpv+HET+?=
 =?us-ascii?Q?+LPmN28SwNr3hiXD1qIUwvXNPryi9uZ0gg4ls5n+te9PdJgicGoM+jsUEcDJ?=
 =?us-ascii?Q?8gFKsueKnjrTZgic/y46QpEJ8X2DMmti0SfwwSLtkSAmCGdpsAA10QWQrDSB?=
 =?us-ascii?Q?khJf4bL3NlnkxFm+PVz5/JAFou2TWfcpIZC76UbQ/Y7iRBDJiG6uJDNoo1Iw?=
 =?us-ascii?Q?2NPHo9EBhn4NAOYqumK7iP39DdSVyCrXw7vaiXPXaahMXzDYPzzYGJLFPjZQ?=
 =?us-ascii?Q?aWGEbDcaoL6EsVrOYaSdE48wfin1Vccit0qZXmX8m5MzZaaQjTSlpTERJ1lL?=
 =?us-ascii?Q?+PfB28qDPVicZT4C4cGRSxbHkwgPn8+OQNKBLJ+LdTsN168WNCTX9BK0cJx5?=
 =?us-ascii?Q?LoAo9AXiqtVzkFHOUxNDQxR5EZWsRwpuRczxXwu4dSEdv+P31+xlwvktBIiW?=
 =?us-ascii?Q?uHo0vWFXHYGg2VOg0hqmDi2tP+send8L5th447zPZ+l5k4mSwoTjxCb4YKDG?=
 =?us-ascii?Q?ZOrR+cWN5tcYJJIlvrmrpfPoP+3eWeGETTjfY/ymlLq2VK8S6IhMfKDCOw4G?=
 =?us-ascii?Q?0TJHlfrFXFjzFCGrKJHg7vxI3lmoD+n4hkmELax24XIvLAG/68AfmdV2wHFy?=
 =?us-ascii?Q?kbLkqOiTkDNj1/XxsHnuvRRuEMiMS/XG83m+vsqIA9wb+sGiBJ1agORP7DjY?=
 =?us-ascii?Q?7hQHAcNSuGQnRY/FnJwbi9QixsTrlx+obsJZJ+TajuF3KUpmPwpE0431uOdz?=
 =?us-ascii?Q?8KxBlYuzkaqS6i1RFhPrwWrGfCzQ8vGXENea1+eQocTPRw8GSHqFLGy+bw0z?=
 =?us-ascii?Q?Egtz9ceS5rT1Pfs/GKzR7DnJHAgiH1gNWa6jMX1kd2CHmRwAiUCHIiyYtqaZ?=
 =?us-ascii?Q?g5ikjKAEt8HKtkSXuutBHY20flKRyUn3hKXNVH/8l+cpPJbMkoV7DEAUaqRE?=
 =?us-ascii?Q?8VEZ4CsjlQQeuIvJIT2V0ejdXAyNwoL7WikltdwGeRV/D43UXWAWdnwatTDP?=
 =?us-ascii?Q?N60x12CEj+cYNMB3YOU4KRWbJHyW1BBaIwQpRUrN8y+3+278LcFozPzvMEG6?=
 =?us-ascii?Q?02xPp40gL3V6AlY29Qi/E8mZ9BNJUuJxAoSZSG9Rremq7z27HGRAp8rpzdL6?=
 =?us-ascii?Q?0jdHEGSrp5LhxsfiLb4hlkvmdUupBNFUlPjUrwtN3dgj8RtYzRk5Ec+O+wkX?=
 =?us-ascii?Q?RZy1LwdLlCtuXD7m6QaJPlDVsQfhf6p4d3vpeMJYLp43CEWSJmEQcAsji6VJ?=
 =?us-ascii?Q?j37e8jK4BGMXEl9QUFGzlZXL5unrDaZVWa4b/pE9tlh0B9q7cRmpZ4OoxaGR?=
 =?us-ascii?Q?48Jw8izTqmCtF34yrvVhjRep/2Qx+T3IAcAOP6aUxKHKVYorVlHeDtk8qxDq?=
 =?us-ascii?Q?/V58crG3BtpJWzeT13rujRwZR+WMNobU0LQ8f6kn3cO7og/3RwjwGe/Yz9lN?=
 =?us-ascii?Q?2jd7uk4Hzqe+d8mQ1INf0B+oyTIQd+Ji?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gbDH5qi3KfCwjMAD23tnSFi2Ubn0PMwa2PBoM8UBjjPgqOt1rdY8glaTxF6C?=
 =?us-ascii?Q?8U+BOQ1spSDaMnlz88h4SAgkW3pfoZcUI4ZhiqTgTf67mEcWz55voxqGr4ic?=
 =?us-ascii?Q?Fr4LfqkDC7Ev8K9jkSdKA1G0tq33hbv5uFn/zkrdrCwAJP5HaxDIUIiHwXwh?=
 =?us-ascii?Q?bggBLEpSUcCB4zdatRYPX1rcfoc39O+q8CNYYiUylYlsxWaRLWu8XAr+ym6J?=
 =?us-ascii?Q?xHcbFC25rWd3wMoyFh8ZsdLBr9xeNigso4TxLpus7Vag4G+mmazlpB3CW5Zn?=
 =?us-ascii?Q?OnYeFgaWjJDaatC/KrbGQ9OoXunswyxoD87U8XJZUXLZTXr7Fu7NVQr+iaH2?=
 =?us-ascii?Q?b37QcxrsPUNTVjBLL+Jn92/EfGN8EEtRgsbXmJWdOJBr0kLLcI/YBcAVtq9D?=
 =?us-ascii?Q?iVt4/Jg9YtUqLedsWp9vzBLdvhUUs2EB3uQgXY5KQ+6F4xRHLM2NSVPQXeYg?=
 =?us-ascii?Q?641xPF3bJBltzhpsApGrWMA6dV6iTKd1gRy7AuDbb0EV8BubPCHus9aaceEJ?=
 =?us-ascii?Q?glwgi3WxDSOWT02OujzE+vGZrmrwcRoYaj3L7MhX3C9TF9tAfCscDqPJ0yO+?=
 =?us-ascii?Q?zJ9hu5ifajB/P+hbSgGhsu91/jhPFPhyeMJH1cZfkJDuiK8jyZJEGcPD8Gi0?=
 =?us-ascii?Q?0fmkKJ1Q4Fi6KLgilmohc8cCPBv9/j/DzeWQj9c/w4ySzewu9w2/rYph//Hc?=
 =?us-ascii?Q?wKQTlrCZxLgac/W3VPWOZgKZH3FVkiQt4tuzrnuWZPAw2GJcy3929gQLee/M?=
 =?us-ascii?Q?C+QmCt2AwC8Yq7wDnhJW5t953+ao7Ib5n5XEJJR4UBWyUgFECWUlq0Ou6C+P?=
 =?us-ascii?Q?lf+iN9EjVB4c6TeqAvuwOVwWCgt/ePHYElG7rgmabxyH1CksI0wqdBBpqhwl?=
 =?us-ascii?Q?TzOxXjUViiF1cMSePeifogYeqPFMGyT6V7/ygKWtIj1RH4HHR91ld1w5+GQy?=
 =?us-ascii?Q?QMJRd/keCImblz8maYmqRSkcDdc7eDB3nOF5qWEo5tAnK2bX4iyDlJYNJElZ?=
 =?us-ascii?Q?CTU2KKAbtP2V9U/Pji7PybI2oB67CtahNNp/tn3/tnNpRECWRFouplMPBOT+?=
 =?us-ascii?Q?z2T8vGCsCrlfzJWwdAo3cyXk9L7MaVW9kBBAH1dsVU+CVo9Ii19epwzxGI4s?=
 =?us-ascii?Q?Y2k3RG+aXhtQXJ8T2NEya/+JPTwKCFt3W4C+nK4wIxHcj0ycqYR8q1w42Vv2?=
 =?us-ascii?Q?A7+nrZMLXICksvzqsNzUVOc1nHMLr+Wd8LCEZeAWRufvO9UrfkI+xQ6Fl8C0?=
 =?us-ascii?Q?KdfQMoauMvTvVWqH4rNwoNt892kXHfX3oz7lVs2F57tNpTU0cHmAEM76iRi6?=
 =?us-ascii?Q?r23kewG4heY+g/RouAQ4d4x5F8OaSuMnVqkWZ5gtRlC6CHIVCpOynqSyK01/?=
 =?us-ascii?Q?lo2KK/TlDCBEptY1bLEeyC9UVdLuGPL0rNQ81hTYDkgtT3DuEzW1zARfq04m?=
 =?us-ascii?Q?GJP6t/tKhPjXhFH2jhsU2G55CmE4iMSqc7P8bra/b3UFpI4PFCQiR5aIxB6O?=
 =?us-ascii?Q?v8DxazQEKxj3OKOIJk7bctpsB6fROKeoYHctfWIp3xEdyW9XBG5z5Ed8Qh2u?=
 =?us-ascii?Q?nOvG6QqGiNtoCUpZgnUkDt3IPhPv0CBwt1WaTc7Z?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 763bc7d1-7eb5-4565-cf43-08dd3524ebb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 05:24:44.5867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Q4n/YnSBXOy7FsLUMHDr/4tZa5YzaycclmE0a/VqGWYdN/2sLn+zYgNEggAN9VsdGgdzfvkIkVsnmTONl7VNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8372
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, January 15, 2025 7:29 AM
>=20
> @@ -445,12 +445,38 @@ struct iommufd_fault {
>=20
>  	/* The lists of outstanding faults protected by below mutex. */
>  	struct mutex mutex;
> +	spinlock_t lock; /* protects the deliver list */
>  	struct list_head deliver;
>  	struct xarray response;

Move 'mutex' together with response then?

>=20
> +/* Extract the first node out of the fault->deliver list */
> +static inline struct iopf_group *
> +iommufd_fault_deliver_extract(struct iommufd_fault *fault)

Probably simpler be iommufd_fault_fetch()

> @@ -102,17 +102,19 @@ static void iommufd_auto_response_faults(struct
> iommufd_hw_pagetable *hwpt,
>  					 struct iommufd_attach_handle
> *handle)
>  {
>  	struct iommufd_fault *fault =3D hwpt->fault;
> -	struct iopf_group *group, *next;
> +	struct iopf_group *group;
>  	unsigned long index;
>=20
>  	if (!fault)
>  		return;
>=20
>  	mutex_lock(&fault->mutex);
> -	list_for_each_entry_safe(group, next, &fault->deliver, node) {
> -		if (group->attach_handle !=3D &handle->handle)
> +	for (group =3D iommufd_fault_deliver_extract(fault); group;
> +	     group =3D iommufd_fault_deliver_extract(fault)) {

	while (group =3D iommufd_fault_fetch(fault)) {
		...
	}

> @@ -266,17 +268,20 @@ static ssize_t iommufd_fault_fops_read(struct file
> *filep, char __user *buf,
>  		return -ESPIPE;
>=20
>  	mutex_lock(&fault->mutex);
> -	while (!list_empty(&fault->deliver) && count > done) {
> -		group =3D list_first_entry(&fault->deliver,
> -					 struct iopf_group, node);
> -
> -		if (group->fault_count * fault_size > count - done)
> +	for (group =3D iommufd_fault_deliver_extract(fault); group;
> +	     group =3D iommufd_fault_deliver_extract(fault)) {
> +		if (done >=3D count ||
> +		    group->fault_count * fault_size > count - done) {
> +			iommufd_fault_deliver_restore(fault, group);
>  			break;
> +		}
>=20
>  		rc =3D xa_alloc(&fault->response, &group->cookie, group,
>  			      xa_limit_32b, GFP_KERNEL);
> -		if (rc)
> +		if (rc) {
> +			iommufd_fault_deliver_restore(fault, group);
>  			break;
> +		}

The scope of mutex can be reduced to just protect the smaller trunk
touching fault->response.

Otherwise looks good:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
