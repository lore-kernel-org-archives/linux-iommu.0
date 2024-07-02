Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ADE8BFA
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719882725; cv=fail; b=gxph7dYLmxmu9oEtOxsDQ9PZhFXNS/w7JxFJsfwz5pW56X3W8iDBbOmFD9b9grF5UL5UQ+VH2piyWgoKoaXuVISSHjePbkKusD938Ixeazb79tmdzhxGWikyZdufOFrlklIToQ8yJcH5YDWN7qAmPPotkEH5RNVF+jZgHp8qMKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719882725; c=relaxed/simple;
	bh=CtFhQgryHUo9wCVICuyGZl1WSsIBXgDumvH2fi5UJbk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aFj4gVwvNcVW8GOpa3fWRoAWdCX7dslyyz50z3WO9R854BD36E4aCIOtsbj/dQJebuuUk8miKJGI9BrPcbLf31qQ29sMPJKDgslkIQCN6AbHiJnwPFWxbsxLi20qljxUZXUh7VtnVMQNlR9SvKiCB5rce39nZY422upTRxyevlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVKmvo2R; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVKmvo2R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719882723; x=1751418723;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CtFhQgryHUo9wCVICuyGZl1WSsIBXgDumvH2fi5UJbk=;
  b=MVKmvo2RpHU9UnEde2nMqa18WdmKWGyY1t3ir1fb0pA0DO534g9dYNcJ
   rytocSseQoVA2WPTK8EuNKrDtSjSVeX/6dy2tUjz6HgmZJ7Agg97/xnTM
   gmG9N0vh9zdpNdZphx71ZdTzb5AFiTQGGue1+3Ou83/hPU6SpzbJy9HIu
   Fvhp7sS8AshttGUaDE3rT7PLBkHUBB3xRNPlO7FKOw4HcVjEmrUcz09lc
   sm97xaPWDMyXH+zAcUJlJjx+NbcIoyjgSCJQo3GYnBY7w0J0aNamNq3av
   uKIBPnKVD8U2nFUwdknA4JiBiLNXfqHazQ25nabTFmCydJpiExCaZw8pn
   w==;
X-CSE-ConnectionGUID: 72o98Yo9Qcyq+WIgQtcpTA==
X-CSE-MsgGUID: rnz6BS/KQAiCujeFCFnYlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="28168692"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="28168692"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 18:12:02 -0700
X-CSE-ConnectionGUID: 0gqI6l+8RPK7k97GBdellQ==
X-CSE-MsgGUID: uXoVc4VLQx6wE6j7NrzZ4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="45791735"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 18:12:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 18:12:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 18:12:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 18:12:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTg80Fi45xFJh9faN8OCIEPHV/kVEKtDFhJ9M1klxGMZBARFRxMX+mDJy1jfMtJOASf3d4Pg4RtRqFPOHX01dmxuck9ejI+sY1k3+wvxk4+U3ACR/FH2wZTuZvOuvsa0wSz8V2ZVxIs7iQqMmrb6LxinmTP6VB2yM85W0UY6q6/XYiXFGDuc+nmc8NAgpLDipzXoCzMUWO+kokm0D8vhDAQIBZr8x+zlcAwx+PPnOulcKjDgI6xlFG33y32rYsOjnmo1o9tNXb/sCzSHHW+vqtBwzeP3UaDVNB5X6pYiZdlKdLLd9+CbbN59cnBJhLvs6yxVRAqX8fU36WxfBRRyww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtFhQgryHUo9wCVICuyGZl1WSsIBXgDumvH2fi5UJbk=;
 b=LjADq364SF6mhj7JmkXIu6HEXZFY8r6G5msoYn5B9qAdoDOF9v2MWEiUFXpN0Aujh1VZD8bRlB/WX8pZ4dANeD7DjDAASfe+C0M4hkgR8gy7bcU0/kQZEV2UGfGjgB84Dbkw69OTNe89zmK9ptsO5hHnKy0U9LHu8VQICMA7pwPXwXLT87SkIbvI1mjyT2VkzARQqcxMeLbThctAmvJFlfRv3i6gG5MHm3SvumbolbmknhVWOV28qWkbDbsQb3Y6YixmQVrpC4R3+jNTYe4zLfiKiw3r1/v/Ytz575/xvXCOOezXwokLk2LMFR/EwsyvNRoWVpN9gcGv/E1uwxbmPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB6850.namprd11.prod.outlook.com (2603:10b6:806:2a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 01:11:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 01:11:59 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] iommu/vt-d: Refactor PCI PRI enabling/disabling
 callbacks
Thread-Topic: [PATCH v3 2/2] iommu/vt-d: Refactor PCI PRI enabling/disabling
 callbacks
Thread-Index: AQHay6l/CJ7B+An2bUCH6suVsAIiTLHioj6w
Date: Tue, 2 Jul 2024 01:11:59 +0000
Message-ID: <BN9PR11MB5276B2169CA10009DDB701898CDC2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240701112317.94022-1-baolu.lu@linux.intel.com>
 <20240701112317.94022-3-baolu.lu@linux.intel.com>
In-Reply-To: <20240701112317.94022-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB6850:EE_
x-ms-office365-filtering-correlation-id: 4bdd8429-6890-4472-d684-08dc9a33f915
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?r2phoQcLtClUxNJh7DsnNJ4dFsNfecK3V4wQhM3MRDNUj8BEtu6yeEJbTrRt?=
 =?us-ascii?Q?dMau3zobP7F7X9LmloNlZwoyTLiZNAHVsQ/SWJhPyOqLYcOuZHi7lSI2cHQo?=
 =?us-ascii?Q?YtBwFh4F2/MmD+AxOqg1WEty2siqIIe07bEQMsAGW9vPAgi+2cO4+AnJMwim?=
 =?us-ascii?Q?nhVNjou0+BTy2VDzuxyuvWQlNtULcbxdnqmFtIbpPkcZVWimqS6P23CEyr9z?=
 =?us-ascii?Q?TnPXsdBCzNMINKPefj24OZY23Ahv9DRrv4WRcctUGkpHd4T8HgNFOCpOox52?=
 =?us-ascii?Q?tNfA+z9z6GowWpaBbm1M1RkhSdSMoGQf/PP5bq+sluqyKigav2Xzmj1HORcl?=
 =?us-ascii?Q?SD+a5MtboIFpsaQuGbu++1Mg4I4VUmhY/8DRH/rUyh7ZNuhL1ySeGxJT34rU?=
 =?us-ascii?Q?VOUWg4uzkIMWWqx5v6fSn6C/vF5cM+cemf3WQDiQqx7I4aF/CUtRnkhTiVVC?=
 =?us-ascii?Q?nWw/Uoe42hEVDtSrIg673Vzk2wU2S0IPTl0dNJNT/ld66d88AJs78BGTmHvg?=
 =?us-ascii?Q?L02PRhq96TeqrBD3VtY1I53VMvAtHVWw7YWC48PdO8WR3zn98NKFilvYMLgm?=
 =?us-ascii?Q?4rF00IKlqa/vXF+/SxwmAkmRONb1+sJSAoMQrLNyXrpL/DO15goE21MrDESe?=
 =?us-ascii?Q?pAqyDbjtkS0j110M+NN2cyKvpAYCk7eTS871SJNAucZmyc8dfQORpZBQ/nPj?=
 =?us-ascii?Q?t4o0M5j4YASdwcEVkqBNL66iMwsdAZuqUJy5jhi/OmqgBN9EI5db2PUbI2oi?=
 =?us-ascii?Q?pnt0+NejIk2oRcoq9CynJ8RE2RZ8Vyyy+DQk64RjPigTguD1/v6DfLyhDp/x?=
 =?us-ascii?Q?qnLa5LiCwostVrpgdSyCXZdvV3yVPBTIKMrko+aIjjVd6SQ4VF2lAmAT5Yo8?=
 =?us-ascii?Q?G/0jUWdQJfSFkeV2xOg5Dpp6+Ca1ZKjWWhmEn5Shh8Fdl4f8gHZKmtwWlE7t?=
 =?us-ascii?Q?Cazsw0G5TXOjG8RYbvBTza+ZMgKeGo4W5pRqg6Bv1e86ymb4d9uVH/hiG/7m?=
 =?us-ascii?Q?k8cP6jkzs3Z62z2O5+8NxNjucFZmwkALha0Dr8XHec2zOGOz1zWnvpKMtHAg?=
 =?us-ascii?Q?QKqmH64RwE/KpJjspVTHWO5jfgaqSR9XXMPwW5GcsOEkMyRw2ZBdCKLafqoB?=
 =?us-ascii?Q?ODKgH3SQuUT7oEU3+64kdu0K+Vm/jfIHyYsqB2e+wIKgHbQAhz/KjKwfuZTd?=
 =?us-ascii?Q?b5ZIG1bk2E/HzpvDx4HQeUCPKUrViz8I2mQ9TNsulmEbsgzS1tBc0TkKfX3s?=
 =?us-ascii?Q?LxTmd9hSxrSQcX4op1qnkgRG8FbDoelnfVMBN+G05g4PXRxjB4Fk1rhe7z1U?=
 =?us-ascii?Q?QzC0cC4SJzISF61+IrYMyv2qsHU/HyxCeM4tY8oElYccPZDwXaUvsow1bnNS?=
 =?us-ascii?Q?0ExvIgi/bRQ8goy7ucVPaQjG9mxkJ0Q1hF3siny/O8Va1lR75A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NPJrV5L78wTuOYCaR7qTWIKWFhQMMfryzxYMF8Bq4eoWXVTQaaljsaUz7Lh4?=
 =?us-ascii?Q?XXIDmlFcL8X2yR7JUfbv38rJXhRZUepi1vGFLwmEaOyPi0T+zbEdBbJq5HWs?=
 =?us-ascii?Q?XqTHIoOyeEU5JTgcJ4/NuDU3/A/f0/aI6ZDBVQNJuaevOIu/OompuDqx7k2K?=
 =?us-ascii?Q?F2nK1KIMx/HAr0o+xPmLzT9SvpuYOGUSJn7M4Fg//+4Bkb6S5QS948Jc9nYe?=
 =?us-ascii?Q?SkEs2639tem6uganFOBGIG76+KJcO+jcDNYUHzSQdYbJ6FKDsJKDr4CrtnlQ?=
 =?us-ascii?Q?l8gjueSc6pNkFg4h/SE+qx99gFgd3O3HJPFPxOIPzoDiJvD2GgiP28qd60EU?=
 =?us-ascii?Q?LXbkghv1coaPDaw4giW+1c5Vo4m2UJcdb73P+NnzVWq/xrufQ5F5U/e0yntO?=
 =?us-ascii?Q?++Eyus7ybK8xn3IfVYnlWeM5GYEhHHW13dvu16Ksa/YTf54gSmT9TKy0B8BG?=
 =?us-ascii?Q?+VTQtNkEg6JPjDV8l9dgG/3PtqGjEiJvlVyRPtKH/ltIrkKUL01ApvkDIFLY?=
 =?us-ascii?Q?5OzebmZWzWQrjL6sjvAoDrQLIRPTESFXdld199PnEAfETOLruSBD1Q5YypOV?=
 =?us-ascii?Q?md6Dd0R5g+sqQndZy3txiqm/meV45sU8pJOa4WQwVbw9P+PO+V2TOknNhYz2?=
 =?us-ascii?Q?jiwtRYGltsfTzMYEC+Bm56daSIjE6dWsM1sbp1UOkPvjdYndoAZzmbVbYERd?=
 =?us-ascii?Q?TIzNeUdlYSBuTzfDWQOVm/OAbV/uG1lUGwYig49P4LmYyhq0t60tpLGt6mIh?=
 =?us-ascii?Q?zo58Zb/ksUQ9dyYk2wsmdt6N8q+sxlE/IdZYTfEX/Z/UmD8sK15Rgn8DIyHr?=
 =?us-ascii?Q?gqFNJfj6MpkQhZbGRsfQm2q6H+Ro2iMpOp7rrD/CSszeZXEjoyugYw39obhH?=
 =?us-ascii?Q?XBEWgGV6b3hfX9bllhZD4NLvTa2BvjzfCTd0kg/cau7aiQqFw+gPcXo0DA7E?=
 =?us-ascii?Q?8nKff+Q/xrHLJvJLZUl+W2StzsD72hmqQeBzCvEIA68ILHM85vfjC5gNeLpA?=
 =?us-ascii?Q?jx/CxrCAmF/K90YMQhv8Rq/MpSF46Lw8EkBLg9UZskLu6P1NONIjbwPSmDL5?=
 =?us-ascii?Q?uAIvPkKUxnxX1VlMQvGIc0IIdhApHbh723ZWTiNM+/Hhm52VHheoe2KZtbFo?=
 =?us-ascii?Q?7bJAzRsy+rPKBekwRCvZjYFGwPdxEzKdFjCOc/Tcup7n1I39Zzw1AnVdbYqo?=
 =?us-ascii?Q?YX0T9Q9Msqx/JgPjs1Onu/HCZn4qJ5FoCspHnDTA2dmqXYtN6s/HRjO4Pwxs?=
 =?us-ascii?Q?9pDTbhSx1hpzfOy2SOc91kg34kt2jNkplUPcfqLRk2owfY3kfw924bi5+WOJ?=
 =?us-ascii?Q?V38UD9M2k+DxipcOd6aEtrNpJPLybUOLDGFp06yiKqATLlmyW4U4tILCSnTs?=
 =?us-ascii?Q?lm721l2LOjnzK7op6dozkpPh//R6U3+Ixo5A6n0gXoWr8CznHk/eYmR3hOws?=
 =?us-ascii?Q?dY8/oxE2zE9QlP7+eSH/iMo8fiD0So9BCpl0bAA/Vf1W24oTtZZkbrKYaKdD?=
 =?us-ascii?Q?NJZ2zVK9FZVLuPQWcAf6msDKmT5y3MP3JVXaGK/Qfrj5Yx3pMnK+34C61hBF?=
 =?us-ascii?Q?RI57frcIk5ub8/6ksINYNr3uMHiODR+tCMetnELc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdd8429-6890-4472-d684-08dc9a33f915
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 01:11:59.2555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N6yMPXMQA69hCdM4CJU/f81D6SaAG13FYScsA8rlPyPS+5MdKXAcnwQ0gO+IZa+Z3xUxyjPXYh5ceXrwB2cLhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6850
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, July 1, 2024 7:23 PM
>=20
> Commit 0095bf83554f8 ("iommu: Improve iopf_queue_remove_device()")
> specified the flow for disabling the PRI on a device. Refactor the
> PRI callbacks in the intel iommu driver to better manage PRI
> enabling and disabling and align it with the device queue interfaces
> in the iommu core.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
