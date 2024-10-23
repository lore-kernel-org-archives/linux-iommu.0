Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF31C4C7C
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729669557; cv=fail; b=BIojt0DjHDgaySxw3xWFFgA7+09zkLpfqGNyFQ8QX4yV8nWJmBN6lyXKyO/r86fqfuWx/6iY4ON6b2CvizeB/z8gwnJa0nByAM+nVtQPHKxoWxTyow4xfHBLq2Z8cQoWVDReWsqamBtga68RUT0OUH+VK7b2p1TJ8yRRkYZzT9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729669557; c=relaxed/simple;
	bh=4NBWgSUbQgbEmv/8vk+Cy1g3Sxy29xpgRHvM0MM/PvE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G158ElZMTZIcKY+tJpc84K5a3oI6Smua2mVyLVMy7BMF1tHAxuGSCJu1MMOSUqE0Rg9SGKAtJpsdpX+5VzVxBWCqdIFy1IKZEWtFnWVUoaD7Si0wlP8PIQx1lXuaw3u+X4H4rugrO0zrdiMxdI1/TYs2PxWZrtwmC8+KZj2rK6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NSVrqPxm; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NSVrqPxm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729669556; x=1761205556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4NBWgSUbQgbEmv/8vk+Cy1g3Sxy29xpgRHvM0MM/PvE=;
  b=NSVrqPxmirsJqftnpgKWRrUh2mS7L/scoFLuX99gnqGxM/trNtBHNHPs
   JBc6xitvfSpxz9m2DdBHhmNcRDDzMTS65ART6VF0eb3AVZXC36Bnx3BQj
   rDB28UHBlRuextO0UQ8WnbaXfAsSv6RA+YRagGuUA2I/RzOJUExuGAPKl
   iUc+QdckoM2imNdPDFQoegEown4ckw8MdvuNzHzCR8VkcmvsqoszRWzo7
   AxKacpNaqtVAZ0ujtFZ6CFy859C9gwgQhVjXHcTrl5Hp5Wc9eJ9lGRkV2
   3IxqHoRwlDYL+MwbywRHa0WYl5MFYuST7r/8hHlZUaT+Iif42zB0QcZk6
   A==;
X-CSE-ConnectionGUID: jpBa3B1aSemY4gKmFDnZlw==
X-CSE-MsgGUID: Dabi2DbLRWaBN/Q7OLvaYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29354611"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29354611"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 00:45:55 -0700
X-CSE-ConnectionGUID: h8IAA8A2TCuWp6TaygFuBw==
X-CSE-MsgGUID: MfYeuwgUT4OGo4GtnGVmaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="80310055"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 00:45:55 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 00:45:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 00:45:54 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 00:45:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdEl63U1NoJN9sDtcjfmFjB8lOgXwj6Kjm7UqRxw4n4EVa7NYtTRK3s1n9PTv/pQZSxyPrjdvCLLBjeuWYPmhM2mvddrh6NEvxHL8bActv/oKoYV4bdCWs7ZNuTaLfRSCZ5arluOJH5RX//BDYV9HCR3Hy97NqAtER7gGJkUaHwAVIQBvQXAI3klcsUAO6IvB2Q6sdAq/HNmG0LAAiLdMZeF0iCxp1ZR2tzuO5YTKIje5bvD9dZQBCpGoxz+EWxE/r305g9kFsxIk8Q6faeMYl6GkjdFKVSBPSR+97H5J8/N70a0Sre+oK3CUTn/RT/HAQZ+gIgHB1F282GgRjxYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRnC//wtbaUetxedwY/H5dZuNv8xRkrm7wF/sI//LC8=;
 b=AfhXnzExcRnW5DwF7UcgIrbUNd5vkMzeAyNECZbZ5zHIwYvjS1DzGvgBFxTBhbgh6A/qYkWwK6BKirEV+O5iFVd6uZzaJwCmKgDFnW2dL9sCvMBHu3s3NkVE8ayCt4aCo5yvcfQ6ndNbGIKn1QP4KWLZ59kvc8dbmirLiCDynHl4uhQ6OnJ2rNzuYwXRheIdUcHhA+EpR5cyVOrSKecPtd4cddAcoVjHISOibkDyCfP8JrkoAxBp2x9E6yuu3DmftQL9YAA5+g/SYpaP2Jc6WzEF0CAdsTAQk+pUDKh0gXI+MIKoXesZvFdxNcNkCKviLaQ0YuabelGoGzeNsEx44w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB6815.namprd11.prod.outlook.com (2603:10b6:a03:484::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 07:45:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 07:45:47 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH V5 7/9] iommufd: IOMMU_IOAS_MAP_FILE
Thread-Topic: [PATCH V5 7/9] iommufd: IOMMU_IOAS_MAP_FILE
Thread-Index: AQHbJMWpujUROnRX/kmlsz7Y0i1ALrKT9EYA
Date: Wed, 23 Oct 2024 07:45:47 +0000
Message-ID: <BN9PR11MB5276B76CD645ECBCF60A8A158C4D2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
 <1729630838-24586-8-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1729630838-24586-8-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB6815:EE_
x-ms-office365-filtering-correlation-id: 06ec1ee7-1760-45bf-7a90-08dcf336b53d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?cPqJ99ZyrEj6OOftbgrhg0jzXOSrC8Ow+lSG3XGmniLNOgwR3Nbr+23xRHoX?=
 =?us-ascii?Q?gLsZWVRWQyDeNKzAKFgV7wotEpFyfS/PlLVovlKxdbjEVYVAXMn+ThM0U5wx?=
 =?us-ascii?Q?uG2RkP307igtYukyd2Vul43y25DKfRV94wxMdrorGUlXw578zVdmaDQ7hVIs?=
 =?us-ascii?Q?WuhvHRCoyA2UAoF/9/B4cbWV9E4yaZh3lXCCBH3Q6iUEv8sFx4hKTJUimOJd?=
 =?us-ascii?Q?t01pK4vZGO8+J2X7x+TwgY+br/gIb0TBaoJnWZFbfC2wOlcW9cSSZUP0cXF7?=
 =?us-ascii?Q?zJTNuZCcj0tEDCo/3qdmZJFsCptn4ZNJN5AbFHMsPCl57gvuwD+ZIIWlmLwY?=
 =?us-ascii?Q?1I8RXEnb1pLSnpO62V81XLqMQZUbk4Bq2R7eAD0+G7OZhbUt5Jrp/BuEO4yw?=
 =?us-ascii?Q?eCXD5MKZ0UVVs1nyQ+mGobXBa+RBJ+X3ykZ1m746TtB/yNkjYkt/RXDp10J0?=
 =?us-ascii?Q?5SpNiAsQlTfTl8mMtqPhbPAesyLrW22LCCjNrYqAAHeFCgit5ivVzxjyOQWv?=
 =?us-ascii?Q?JjLutC8K/rUd9qCqXCbPhQCGmjFvVIIuxivTR5fvVWd49sS8BgIodINGKJj+?=
 =?us-ascii?Q?rVFRk3rWgrtEYdaIHKHRT+vsivEJz5j0/xNAxiZwPnpY/53TdCu+1Wc4hyDa?=
 =?us-ascii?Q?8w+ujo1u4OnzPs5o0IU3I9QbOMG3JIsEtuXf883GG2hsXLp/SlmC3K9cTAfv?=
 =?us-ascii?Q?xa5ure+H+tH8Zx+gJfg+VkRxjBWO/BvWIdeQtmysQYV49FNVPFfo8zSpHkgl?=
 =?us-ascii?Q?8f2aa5hR0JCPFpC8/Wr3geVq27R9XDYSo3Fqxf6uIMfDgWKp7vZnZcNWeGb2?=
 =?us-ascii?Q?J2qrq5Ux/aoWWf9ble3RL32C2MoW+5uUIRSVqGC0oBgra/DQ8bgCHSFkBGi/?=
 =?us-ascii?Q?B6cecvL9PWBHZmx3Ce/BZVMP3wFnjW/1htzomPkT2kYVdbPT584Wkkjz3D7u?=
 =?us-ascii?Q?botUS9uITS4jL75ycIn4B+zm0NO9kDEd3NrO2u58/llYD+PUBQUztkKKYrIt?=
 =?us-ascii?Q?Ibv5zwl8QuMiXiA3eUkoaodUXKzAL3swftsdMUMdyZhy2mNiyot77zUnib0p?=
 =?us-ascii?Q?fKgoG+4RgLnBdy/X2jRajp6Tgw5nnwiicdeisg8L6It6IsWFtjPuVjs+hjae?=
 =?us-ascii?Q?6BKNgtNlyBALfQD2ff1dPhOXc6aYWbZiOpQZf1gVWrZtNlTw1m6d7U/Lh8XR?=
 =?us-ascii?Q?oyOQUR9AxcZ9AGodTNsgfyFkFAOy6lmNuVX420pXBDVReTINWObl16KQq2f9?=
 =?us-ascii?Q?vYDvZGYe+YpYXjQaTDCRp46o/cwf8Bd4fWZyP1ACjgRkv0zP7fg82U5e4iX5?=
 =?us-ascii?Q?6vi+Ke23CrPp+8JxpBrEu9Ky07bSvbzJsVVa6iuvZ3U1jRrxHUW/0Uh8Mid5?=
 =?us-ascii?Q?skl/GxQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J7o8nw/DZF0Wj9uJCxupz+L9eNJv8eM8DhsU4YA+cxYtv51NgNFRTv3Jag0d?=
 =?us-ascii?Q?f2QJ5bl63qVtwZxR+Vh7t5KbqHsL0hZnkckkBWQwLNZa4jb1yHXg3Vt0hHS+?=
 =?us-ascii?Q?wSTPqt/Me1x9Huk95+4D2KvH7Ja9DdcSWEl2qqjOrd3oq/fDTIlZDPTsR0/0?=
 =?us-ascii?Q?HPGRQ1zpzkDtTq7za2IApA50Ht5/fC6mniEfovzrmf39ymSPXSU781n/ndcz?=
 =?us-ascii?Q?jzrkdFthq+YpjgssT+LnrGsdC5obmWZxZAweSg/GYU4GqcPgRGGdSARpAqO6?=
 =?us-ascii?Q?QAAZ++RyPq8qz64PFmb3CDEMj35OlnLzV+55B6qsIgZ37SjOzGmBeIwSEOuW?=
 =?us-ascii?Q?04h9swNMRgv0JclH5sP7o3DFHGJzBGRlKA+POor58ZIfk6rHx92Dm5uRQOy1?=
 =?us-ascii?Q?gtFgi6uqPiHUnNq31NKxRR1r0q9eRBWCzpJ4eWz27Yl0Fq8xPwdB56ayijF6?=
 =?us-ascii?Q?p99Bi9ZiaJP5/M/qwOjyt6yOECKMfus+pAA2lMogVeVRQ69wgJwEkI7/bR2G?=
 =?us-ascii?Q?BJwtiOTON9HkfpQLhjBunKMN1un6VNXk5lFR3zWEfoFzr3/P9KPutbf301JA?=
 =?us-ascii?Q?NpgGw7WzDABryR97eli/5t+tk+gxzSwfis1VB/RT1NbD4W80DWhSbF86iM96?=
 =?us-ascii?Q?An0i3g8XY876oSzB+aKvmA75OzJmHYAjjgx1iUyLCHTkBOCrMGMPZCaZRlNz?=
 =?us-ascii?Q?UrrkjyzEoLilYtuTYTNXTPhVUfJKYtuR9cHJvuBXkFuNO6Nqf2ZmuhuTtcwu?=
 =?us-ascii?Q?QgA8fyoTXw5mZHs8tNoTcYGViS0fggoCFQwkXSS/3hq3OT0P17sXrm46LO5Z?=
 =?us-ascii?Q?mnnE9vFNjR00WvMT3LiDtdfgPG+c7FKMUwwLHtwadeJVFaJZ5GnPzU6kkOmW?=
 =?us-ascii?Q?2c+W/0ReNj1GAzG4+Eqe0YMVN2kIvwHlnY9f31ppBEEaWqPOfcbqyhgU1p+m?=
 =?us-ascii?Q?DCLKt72g9v32meIN7+CAo3yR08SV2A8f35Ugft2NRqUb0Lt8o7NJg4jfBSBi?=
 =?us-ascii?Q?SKNB6aHNe3Rl/JpwCa6srH09g32BE4lH2ndxTy5eOCdUzSdE0vkWlug6iWmR?=
 =?us-ascii?Q?rs7xG3saC3dcz/RufKUbijLIZ2isjRlwKxZve1c3gIIRY5SVU6H+FYxHebnp?=
 =?us-ascii?Q?rYUedGlBRzXMTf7Avkg99LG7PH8lbEvmctQCpzJS32wSadglrHbp2Squucus?=
 =?us-ascii?Q?zSm0SY/Cr4XG6jc7v2EB4B5Ns7k8P/FuOJVuxeJJWmFTGsOYwXSM0fj4nyIB?=
 =?us-ascii?Q?eetP53mp8xDn/Xoj5m2anVVw2BFJHWCYG9Hgu+0KaUi3cMNsouZ6+T377ynm?=
 =?us-ascii?Q?zDmNflPJGoE5U1sZBqyi6nhYQXP2xyEf18zeZrbE93u5h3JAZU6Nqmx4v9wX?=
 =?us-ascii?Q?iM71GgQ1KTgLcnwu2npkKeIgEwR4XUf4TrClpumlNNGl1V2cIgakiRYOF6+K?=
 =?us-ascii?Q?bQPsNzBHQZ7jtXJCMxex9YzYYiiAecZkYojB8ooYZKBaMKlAa9FHzoLamfqv?=
 =?us-ascii?Q?9MSgm/C9nsS1cf56SpRbj6mRe3eGEXum5QLi1B3XrnaPwpFEq6bdEpY75gPc?=
 =?us-ascii?Q?3rFZG06niVIZKrA8WGOW58Xkf2eM6zee6VBfhITj?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ec1ee7-1760-45bf-7a90-08dcf336b53d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 07:45:47.4206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M1nTEMLsioLY16vq8VlBtRA5W4EhQ4bgKW8BUjLhCLyErM27pnM07Wo0limPYhNPQNnN/XC2rnZdZ9a6qKLMUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6815
X-OriginatorOrg: intel.com

> From: Steve Sistare <steven.sistare@oracle.com>
> Sent: Wednesday, October 23, 2024 5:01 AM
>=20
> +int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_ioas_map_file *cmd =3D ucmd->cmd;
> +	unsigned long iova =3D cmd->iova;
> +	struct iommufd_ioas *ioas;
> +	unsigned int flags =3D 0;
> +	int rc;
> +	struct file *file;
> +
> +	if (cmd->iova >=3D ULONG_MAX || cmd->length >=3D ULONG_MAX)
> +		return -EOVERFLOW;
> +
> +	ioas =3D iommufd_get_ioas(ucmd->ictx, cmd->ioas_id);
> +	if (IS_ERR(ioas))
> +		return PTR_ERR(ioas);
> +
> +	if (!(cmd->flags & IOMMU_IOAS_MAP_FIXED_IOVA))
> +		flags =3D IOPT_ALLOC_IOVA;

any reason skipping other checks in iommufd_ioas_map()?

	if ((cmd->flags &
	      ~(IOMMU_IOAS_MAP_FIXED_IOVA | IOMMU_IOAS_MAP_WRITEABLE |
	       IOMMU_IOAS_MAP_READABLE)) ||
	    cmd->__reserved)
		return -EOPNOTSUPP;

	if (!(cmd->flags &
	      (IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE)))
		return -EINVAL;

>=20
>  /**
> + * struct iommu_ioas_map_file - ioctl(IOMMU_IOAS_MAP_FILE)
> + * @size: sizeof(struct iommu_ioas_map_file)
> + * @fd: the memfd to map
> + * @start: byte offset from start of file to map from
> + * @flags: same as for iommu_ioas_map
> + * @ios_id: ditto

s/ios_id/ioas_id/

> + * @length: ditto
> + * @iova: ditto

prefer to duplicating "same as for iommu_ioas_map"

also adjust above lines in the same order as following fields.

> + *
> + * Set an IOVA mapping from a memfd file.  All other arguments and
> semantics
> + * match those of IOMMU_IOAS_MAP.
> + */
> +struct iommu_ioas_map_file {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 ioas_id;
> +	__s32 fd;
> +	__aligned_u64 start;
> +	__aligned_u64 length;
> +	__aligned_u64 iova;
> +};
> +#define IOMMU_IOAS_MAP_FILE _IO(IOMMUFD_TYPE,
> IOMMUFD_CMD_IOAS_MAP_FILE)
> +
> +/**
>   * struct iommu_ioas_copy - ioctl(IOMMU_IOAS_COPY)
>   * @size: sizeof(struct iommu_ioas_copy)
>   * @flags: Combination of enum iommufd_ioas_map_flags
> --
> 1.8.3.1

