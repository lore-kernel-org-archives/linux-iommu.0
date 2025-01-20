Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456CA1AF0AF
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737364964; cv=fail; b=Sn7AcLWD4HVcRFZZUo3SU16H8fLHZXe2O8YqAd1VuS/UYeA7/09rd9ENPiRPqwEk4Cr6WyaFpKsHtV+ZCBbgNqpu+ZH1ipqukYTTHyX8nH046UvUg8P8IjY3gmPuYvW0lCMpdQqDEYKjlcx2aBSB+PlOzAYJwkZi0A+jXPT9BPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737364964; c=relaxed/simple;
	bh=KaDZXZQJCuDPG1FfCGJqg7LoIhQVxeNzr3oLnmN9F38=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AeGFO1hjTb13ewLZzGsIhzTA0rNvdvYIZAgNVm4mWilYNmMsnxez+viQunZxwHMZV4lHY041xflYsvFFlUsEHOZ3httQJwnNg6SDqAwVovu5c/V2UD1POutHs2W2Sg+cVFgJzUgGp6UveA7/FXSjwuLGzjOYEx5C6lQ/1R80skQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsojllC2; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsojllC2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737364962; x=1768900962;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KaDZXZQJCuDPG1FfCGJqg7LoIhQVxeNzr3oLnmN9F38=;
  b=TsojllC2m5GtH8pDJm01tZI4454IkU72trup0sHydsCj5/z9Z8sV3oQ8
   cH7zfXsT57vr9OibJ/2oUzxiMvP8k+Xvd925LifWuW/98a19kgesImp9d
   Ys9yAQMfETHqnqOtrkCHqxY2JIyp3CBHJsr8CWGd6bZpKeNdJFEv53fap
   lmc3+kEaZbnO41U1AiG8CRwIB1fpati53sOw3/1MrNyuePNlQ19WgsMAW
   WbgzHUZQjjC82u6S+rAl7sYYVdw1AZwVTnC0tR3QO6Xws2bxng1gJwHPQ
   1VV7KujICkzk8+b1RdB5sVgvj/1JP0jaT0xaAxHIlwwvx2OOrnKM7Jk6Q
   Q==;
X-CSE-ConnectionGUID: ewLaGy4ZTJ22PYFnckg/jA==
X-CSE-MsgGUID: uKvVBEDfS9G3lpzzcl4YOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="25338833"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="25338833"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 01:22:40 -0800
X-CSE-ConnectionGUID: IOgHU+3hRXWTpxFlxfYkEg==
X-CSE-MsgGUID: n1bJLXCUS/OanV8KNZTFmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106275805"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jan 2025 01:22:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 20 Jan 2025 01:22:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 20 Jan 2025 01:22:31 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 20 Jan 2025 01:22:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBxIaAwNepgbnjb0ZeSMyn/dxG7H02LQOQ0nrTCKnUwjV/iLw7JZdWgA9BVqImL+NBPbeatA8TNuZkh+/pPCPZm+Dh7qcSs8Lb3YNee5gHCImPid86A5q7SSHEZQsLnH8X6MfwGpiVcobRE1BQJf7zvETyEega6PMWidT+SYJvpmC/B3VaFhCrzEKGh+uQAiUN4vp+7sepF9Iw+VoRYKOfCNo0LCvbLTKCRcrRc3uc0WYvCHWSNCh2BHRaRju80tfh5n8+JM24HYuSWnuyWU72P9UbjrkQJhjHMwCQpq67et0N2297JIPSHRgPCoVeiL/7KrJhmAy3mddqhSTr1ZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sUDQRdlX9aJeQUM8vT/QIJSNFbGTq2a4oiLcVn5NBs=;
 b=aaqz91aEX8ihZtyNI45wk/vhxuVFwy0oxOzamfmEsyBQuwOfG1SJAwe6EFm8hhGSNu83FzNUvufBPqCNp8/E/6VGmjEmyPD+mylc67+eo7smSnoy5QxBjUrjyB5ss28GXeLok7IPMDzvQx7g5beF8NYSUmONj3+5DXDTmpSYJI7TOgVQG8I8QNBHCOQ6MrknXluaLVAvhKawmnV8PE5WFFcAh43+tFBB7VpOu9Hh5HrxT6mtiMs5ajiNl1lgjMXS75SVUDWY2m4ZKASb6ZOwwUYUKeOi1DTkA0RlD8r09hbbTkQJLC0JS6QlBc19OdSdAHmJq49n/DuiRA/2GtDeEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5818.namprd11.prod.outlook.com (2603:10b6:510:132::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 09:22:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 09:22:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rc v3] iommufd/fault: Use a separate spinlock to protect
 fault->deliver list
Thread-Topic: [PATCH rc v3] iommufd/fault: Use a separate spinlock to protect
 fault->deliver list
Thread-Index: AQHbaISKXN9gcKW17ESIiQqTgzwiWbMaffrAgACMDwCAAEXaAIAEEn6A
Date: Mon, 20 Jan 2025 09:22:28 +0000
Message-ID: <BN9PR11MB527693E6217946E1386B72038CE72@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250117020449.40598-1-nicolinc@nvidia.com>
 <BN9PR11MB52763118C04E83C14683CBC98C1B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250117143856.GD5556@nvidia.com> <Z4qmGLQ1oB+aS9h1@nvidia.com>
In-Reply-To: <Z4qmGLQ1oB+aS9h1@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5818:EE_
x-ms-office365-filtering-correlation-id: a54a48c6-64dc-4946-ea24-08dd3933f601
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?x9NmBRE67WiZ7ISEF1DJ7aKL16/iPr0fWZgp81lLaBFWwiCqf8CyamgWIV7n?=
 =?us-ascii?Q?YkmUynaY3igcGTDPQSSJQqBY1s4ClQdh2CJa7f6vxn4NghI67tdYNC2ioQKk?=
 =?us-ascii?Q?4IGj7yBHRwOuh/yXY11s/tt6DS/ENB4RzEeEZrtsx98NxZS6imMrzPrvNNpB?=
 =?us-ascii?Q?PH//S4DZPiRZCf+O/IgWSbv/Kxch4OsZAWnYVFegsv+5UJUx3HnUi/l/R42O?=
 =?us-ascii?Q?BwQw6pVeqOA3syhLPhKuOOp54elk2yMbYTDp2sYzYbB1Wamnm7EtJuBAEB+J?=
 =?us-ascii?Q?CL3ehCCrLeoAcmzBdnz+ZKppkQga0iCqV+qZ97pZcn43WoMuNHYjrs9iDcFC?=
 =?us-ascii?Q?twwKQWusO6q+CilMmP8qaa1HcQrOcTr9uE8o9icj9PWONDrJSCISV0gHOkvK?=
 =?us-ascii?Q?PLw3C+Jh7s6G1PyFcGes02ssRBF1DiDlHNfXiE5bx/uQFH818Boqcc3fAsGJ?=
 =?us-ascii?Q?J9SWwv3NfEliJzlgxV62bCatYR85+uHxP7OsTm/stNsCJtl/DOiQp4LPuKbx?=
 =?us-ascii?Q?RyLHf5qDwCdsjHyyM2r8qiZ6ni15dXjswW/ynxkRq9GxBYRYSvYO10d8/8rS?=
 =?us-ascii?Q?2An6sKriYNfOMKbkjVMZQUrXVwRGEhXLIqfU6T/90J3bCZaz60yZsL+ZEe4a?=
 =?us-ascii?Q?kXTQMyXgtXx3+NlSBtIZnzyeRQVu1wuEB8tsnt1qy37gMwi6Zroq0xdN7vLf?=
 =?us-ascii?Q?4tEQZcH37i5GmUafh3MQpqt4r+iFuZ5x/Po7XN75tjQoqykUfeJtuPgb6hsi?=
 =?us-ascii?Q?8ilRqJunhElsz0AR4i3PXv5xjmrTL2LlrD7rFIIsIgFl2/KRMIU8/71uSj5+?=
 =?us-ascii?Q?kyoTcfbUKHbQmZgBRygSeqb+1auG0UOQhQgBeih1bstb+2zdNCQLklGJuYx3?=
 =?us-ascii?Q?0nbMR1D1nkYFANEYwwE7mEJbSjAJEe/bgGjKGITUmzBo5eyu+Y1qnO9QS72c?=
 =?us-ascii?Q?dTqH/yLBBBO3cXoSf3xZg7uCbub3nWMu5izKMQ4vTHCjwhSZ8u5oCq3QSA7Q?=
 =?us-ascii?Q?4lm5f/Wc5ceXe5tWJ8+BzodeTfpjXGhSlbw6NF7mZ9mUB2lliKOJbLZJD0vm?=
 =?us-ascii?Q?/d9F7i7+5UssbIHd8JFqaFQPTRsicG+PC05O/o5wBbw7SMkDkvlnYX+lG1fc?=
 =?us-ascii?Q?YnJdGpSwnbBidkcIUrGgBfzCM/coCTDOV2jueFEyO6Yjub6wouEOolpLXzMY?=
 =?us-ascii?Q?Y0iAzM6MpnzLSVq6qra54qD6No/ILBEieZ2D0Rb/r1LlzwIrPiKUcaGAo07T?=
 =?us-ascii?Q?4d24Mrj/kJQ0dNKt5zonz4WLzrrZ4CQ2xQLdxe1t8LZl6LpJZju5BtYGUULc?=
 =?us-ascii?Q?3N17P+lWib5Z/2U7quVYULHtcb4sHWCbka3huqZ7DgvHrGfl/5xBR7vtWgcI?=
 =?us-ascii?Q?hM51TtwCEUhajTqPQ/q9ePgODzav36Vf8xCZGw8MGZtEUSpSog=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bfe0DDenAS+MGro92PY4URSgGkHhcOLrWVCQyk0CKWYQ2wgD08IdMZGofyZ9?=
 =?us-ascii?Q?mwtuImLRkVs8vbrBahHGruNIFxEf3jQNUl5kYH7xb0cNpiSFPuE4QY3TPXJg?=
 =?us-ascii?Q?5TeqjcwnJMou3o8EfL8BsDz96vjP1v6qPiJ/1ERFQ6ezhl9RU5t6tBZc3UOa?=
 =?us-ascii?Q?wOyMwTWvD/RIJ8b/LXMZ3IcRQjfPRAfkGJd6NQdELsmJQ0XY2aJaDwXXSx6F?=
 =?us-ascii?Q?fzjF5OtXKdxdyKt4OyJQ4nnsA933POw3jTgvigARiQVPpHSu196EOzz4ehc0?=
 =?us-ascii?Q?NWO2HCZiKA4IuJKNHsVq72uk1Tee8bO3o2Gw3nkyfUwvsGE7FJC+ER4Cvq02?=
 =?us-ascii?Q?e/bPnp+84r3jPTqN3l1hIMy55UNY+8/T55pKQEXZAtAQhW3BKCDE27R4ihcn?=
 =?us-ascii?Q?shYOi/+fum5a4Em3N4Q6riQiEyShDsU6VoGtaJQBK3YyWt9EFzReuZa+mzz+?=
 =?us-ascii?Q?bQghYY0Ximk7dAw+pSgTy7ZPth+SmrzbNDJBiRrAun7LTaXIEv0wBvPqbNmH?=
 =?us-ascii?Q?lhmVxK8iLg+oA9AvcxsKHrKXFqSt6BSkxhFc9TvVbTIbWgmA9OfLmyTtEebg?=
 =?us-ascii?Q?lpDVzmFpY2Tjy6G6zgsc79WS0+kwt34HIG8gqM8ch8s0F0PrWyHPZHMwwpUU?=
 =?us-ascii?Q?mlwrzM7/ElWQk/bWxOU1sa/xZyi/8KSAF5K2AEiXeJ2KT38gUozFbNa/eXO4?=
 =?us-ascii?Q?OMBRheHsqMskWpeCkfByp3ghAIwybBuojiKOJQ6SvSfzai8S6ULGAjzCUPwI?=
 =?us-ascii?Q?mLzuU0+QZAenqyw45Ks/dvTRBrwOiT+b0/MvCxxGMqohtKC80M2EwBRo3M0n?=
 =?us-ascii?Q?THSHnTEJxl0xDXbE4IpyybUWyEDUONXydgRteMkk2uQOhxlPctMvaZHlZCKK?=
 =?us-ascii?Q?wCgIZr+YFe+WM/ue1YNdpvbsBvuyOg5Oip108OvZwBU0ZLxlmlm4y+t8Jl7b?=
 =?us-ascii?Q?6L4vVCGXEQyFQAsejV7BRxbVFuEA6g6IoQg4jADDLuBlZ90Kisx3lQeDelQh?=
 =?us-ascii?Q?0J2WNST9C135kJKocHYUUeBdyqVAMNiJ5xtygiKZOUh1jy8rfLK/GyJO17wh?=
 =?us-ascii?Q?iEI47V6MyMHM6tk9cZOQOMDOdkzd3w4ECP161jkEj2hfD1ABB14C4nMGo1cE?=
 =?us-ascii?Q?YoUaLUmpybWWXoQxYAvM+QjqaaDQvgI3JU0BecxKmRE2BawpPxebYfLvPwmC?=
 =?us-ascii?Q?Fg8+3dhKzmPNYIrGTFTd3uejVQo5/MN+lHaqyQyodzs0GI5T/Ew/ktIciVRE?=
 =?us-ascii?Q?DbGGebOTsEOtCqU483JX/whzHU1ZIa8xDPRtoHVWl0xgfgb83ED7ZDQi+2Da?=
 =?us-ascii?Q?wSAl+gvmZybiVuupENrJfUMtiMLEm0JxIJmdvocwOHMU+D7OS88cEALE9TgH?=
 =?us-ascii?Q?0+CRE3zVVaVVpQvxEWYwyq3JUrg+GfGZV753Igt8NdmuT2inUshXO0gtkm33?=
 =?us-ascii?Q?8gkOIzJUMPBELG4olAOFu8KdsO6/U+9Zkb36OisNKe5gM2ASjUzDnlxIUIu5?=
 =?us-ascii?Q?kKlUCMtH1Lb7m7ieD/QkykaLAmvYtSudJtcx6PGTeBg4SMu1OqxiwbQ1KVQO?=
 =?us-ascii?Q?F8TnKNDN6TmcsenHpeMoLrUVrjw+e5z/KnjU31Wy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a54a48c6-64dc-4946-ea24-08dd3933f601
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 09:22:28.9355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2oGDnEZdQwWNOpFGGnE/Qj3KNE20xf+9dWVtEX+wfKi0co1fKceKxf0Ay/W40rGcbC0KWf6ZPZqOnH4910HeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5818
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, January 18, 2025 2:49 AM
>=20
> On Fri, Jan 17, 2025 at 10:38:56AM -0400, Jason Gunthorpe wrote:
> > On Fri, Jan 17, 2025 at 06:20:15AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Friday, January 17, 2025 10:05 AM
> > > >
> > > >  	mutex_lock(&fault->mutex);
> > >
> > > Nit. The scope of above can be reduced too, by guarding only the
> > > lines for fault->response.
> >
> > Hmm, I think you have found a flaw unfortunately..
> >
> > iommufd_auto_response_faults() is called async to all of this if a
> > device is removed. It should clean out that device from all the fault
> > machinery.
> >
> > With the new locking we don't hold the mutex across the list
> > manipulation in read so there is a window where a fault can be on the
> > stack in iommufd_fault_fops_read() but not in the fault->response or
> > the deliver list.
> >
> > Thus it will be missed during cleanup.
> >
> > I think because of the cleanup we have to continue to hold the mutex
> > across all of fops_read and this patch is just adding an additional
> > spinlock around the deliver list to isolate it from the
> > copy_to_user().
> >
> > Is that right Nicolin?
>=20
> Yes. I've missed that too..
>=20
> A group can be read out of the deliver list in fops_read() prior
> to auto_response_faults() taking the mutex, then its following
> xa_alloc() will add to the response list that fetched group, and
> it will stay in the xarray until iommufd_fault_destroy() flushes
> everything away.
>=20
> It might not be a bug to the existing flow (?), but doesn't seem
> to worth touching the mutex in this patch.
>=20
> Let me send a v4 changing that mutex back.
>=20

While looking at the related logic I wonder whether there is another
potential issue in smmu side.

Based on discussion with Baolu currently iommu_detach_group_handle()
plays the role of quiescing fault reporting from iommu core. Once it's
completed there won't be any new event queued to fault->deliver then
it's safe to call iommufd_auto_response_faults() to handle those already
queued events in iommufd.

Intel-iommu driver calls intel_iommu_drain_pasid_prq() as the last step
in detach which scans the prq queue and waits for all pending requests
related to the device to be delivered (by comparing head/tail pointer).=20
There is a bug (just fixed by Baolu [1]) but the logic is there.

But I didn't see the similar logic in arm_smmu_attach_dev_blocked().
And arm_smmu_evtq_thread() just removes an entry from the cmd
queue and calls arm_smmu_handle_evt() to report. Seems no track of
when those events are delivered.

Detach may happen after iommu_report_device_fault() acquires old
domain/handle/handler/etc. but before iommufd_fault_iopf_handler()
actually queues an event to fault->deliver. Then UAF.

Did I overlook anything here?

Thanks
Kevin

[1] https://lore.kernel.org/all/20250120080144.810455-1-baolu.lu@linux.inte=
l.com/
