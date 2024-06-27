Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5611CF92
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 06:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719468524; cv=fail; b=Ub9p4p0z5g7J9shgxHmCATCBm93FYW0/iol3m3NJI0pBtQpDjrMS1C/2ZxfUPBGGfL9zDcV1frcfUCWVDxm9nMGcZDbXfWDhVN1vbzlxBQAnGBlonCwaVJm2u04s9HE+VEZpcO5Pvxgg6RmT8CA84Et/ebrBT4wF40Cufp0JstU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719468524; c=relaxed/simple;
	bh=XcM9bGTcO1/FycLe3lJyxQjRLmm6RgMHTH9EyzbutjM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=blXRAba31/lXe0jdNkhp+hkGitxrgL1woG6IwBmNZOpIirJ3XdofrQfZQBHiGU/vguPgiiub7Z5i/9srx+nz9LmwoBz1pqIlCzyXxsEGHQAt/5v3l8dNPs1YnbKZ6VkhRRrz/CnEEZY5skD+iEGYFEayy+tCxC6vp8WZCgDU73c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/J11VSS; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/J11VSS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719468523; x=1751004523;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XcM9bGTcO1/FycLe3lJyxQjRLmm6RgMHTH9EyzbutjM=;
  b=i/J11VSSyjw8JOq5pID8BhbwGmoisiLrUbH8Mtn7zfunu24wohvjMGrR
   GCYRoMHdxHnSPZc6MxLLgwpJiUw/YsvabY2ExMGR2caOgPPOdzEzTV/lE
   3TkyjmOhEdn0jWJ5srEDBQjnWg1tMgVLuelNGsWYz1feMcj6CbI1mhw6t
   MG9gdAcgyj9ZpVfsPKtIJmovuuRsLNx8u8P+UqilAR+n5qebabkSB5xV/
   IiIn2nhcHr2WcRJ91uo94wYH9vHFLFbhSzeFFaGpfeGiFo9UFDsGkgNtq
   zE5aEp99MU0grVgfn3KiQIT7Ts2UCOCoZOTmjek8M147i8Ef5rs7PNWOH
   Q==;
X-CSE-ConnectionGUID: 7EjXNQsSTdaW+tgCMX4hPg==
X-CSE-MsgGUID: 3523DinTTVOCGwRWSVqenA==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16723420"
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="16723420"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 23:08:43 -0700
X-CSE-ConnectionGUID: CfpDM4GXSquex7wOrpkGXQ==
X-CSE-MsgGUID: iGz2kd6bS7KoicqEBgiozw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="44229757"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 23:08:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 23:08:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 23:08:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 23:08:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 23:08:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJ1a7QWKxdgVW4U2FGcocOqyua9LB/2gE+tFUA4U9eApmVr4eNc/YWTv1mwMzcd4KY5A+RXmPPHnHPJrPV+T79EIHJFcrijHntuQyMfSRZ2YJf3OiyN1x/3diDqnDkkV3r9fU/8UZo8gRYDSaXlFj3whV81SHoPKx2VdtM5v1CfmtGK7yq+I7WX9GdmyY0yByGlvG9Frsbn8faTiPndUsu6mKBn8BRQhZOQ/6mIbdAFk4aaIFWlRHGlD2Ia9mLoPOmqaXtGG1JlKvuje9zIEE/xX2qW3IZMdfQJK8i9jk/X2Ou9u4BLO8MQxuDTkpf2Rj0ZCg0K+4qxH3INqk+wC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5gej/LlqOLm212uwXG7cfDtBjil3gQl1oJRdR5mOiM=;
 b=Drdy4sKvfGXVeduOMUQNBXfMoO9IQT8wXd2UVeedEgL/FC5aokhBq995A3nhRM2hCUHuJbeB3d7ozdFzhk4PFkLXkAQVdaJZWItERGDJYt8EmZpOzXBIOx9HvVRA7w9YZiDX81Mye2DWSyNfnourPMp2PHj9sFVmpY/S+wD8ldphxFk5FN2WMfWPWbDfhmK/HHQ9lrouJDxEtmLoaV7ctvF7Q4msi3N+BPwGFepGfYevSka8fn/dWB+TEbtS7Lfu6ZQbOhpFCMHyg2NeuixQqcpeoULkLblOoWcoH+odQ2QwvQWxPH9UrzDmalLjon0iQJIqCTn2rxlFR4NRk4WFaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB7551.namprd11.prod.outlook.com (2603:10b6:510:27c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 06:08:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7698.032; Thu, 27 Jun 2024
 06:08:34 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] iommu/vt-d: Add helper to flush caches for context
 change
Thread-Topic: [PATCH v2 1/2] iommu/vt-d: Add helper to flush caches for
 context change
Thread-Index: AQHayDqJlrXCDNkGs0SyJ8Dba7G6AbHbGrdA
Date: Thu, 27 Jun 2024 06:08:34 +0000
Message-ID: <BN9PR11MB527642AD41669FCF390297378CD72@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240627023121.50166-1-baolu.lu@linux.intel.com>
 <20240627023121.50166-2-baolu.lu@linux.intel.com>
In-Reply-To: <20240627023121.50166-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB7551:EE_
x-ms-office365-filtering-correlation-id: 671ba232-c610-42c3-081f-08dc966f93da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?eciycFRNbJUOBb8qrliRNZoGiEbLpVMCwkN6T/AR4haMkzW/o/XP2bdZksTG?=
 =?us-ascii?Q?8LBkSXCdkKT4jLhuBJQy87hnifCyGpbwNAR5+yPdg/TIdLzU16kUj5+luYEq?=
 =?us-ascii?Q?sf59XOl3vtmq5/8zJaAOwYRz0h/Vgo+hsiM3Gtc3qAa2Wbv26oIaEkeHTrrT?=
 =?us-ascii?Q?uta59bFLGNeruhWFf5zQbL6EKuGNZ1R6xCR0HFloO6aIspJZf5KlAem9QTtv?=
 =?us-ascii?Q?pFb7+EavqFgdDuGWXuJiNVEwpRqqcFW3msMlalgF94wqMxCANeIIxcH4AA+j?=
 =?us-ascii?Q?lDyGioj4WWDx4NSIFnJZTwk98wL0pDp0vzLKPokG7PuksXgMdcRozr2p9f6T?=
 =?us-ascii?Q?VmWa8m1iVI5P7BzhqxO8LbLK7LNoyKNn8OFlKV32+qiqgc+Ufs3FuuVUmGuX?=
 =?us-ascii?Q?zOXMYJjir+p/bPdLabe3NR4rw9uUJMqwIu27c1ihYfHep/vjDtLHvV4anftT?=
 =?us-ascii?Q?0TNKPpJvP957oX9iHxthUJrO0wgmYOf/soOlL9oS4+W6rjMe4SnMwxdxkJl1?=
 =?us-ascii?Q?7jl2iDSWtnYy9U4UgXFSSfzT0F79l7/OQ3uxbCVrXtgXWXJTSium+6Zjk6H6?=
 =?us-ascii?Q?qYDrvcvP1+xHQGUFgfZOYDcQi2vLgdpl7JJYGvOdPJZioeQSbifVz7z7n3jE?=
 =?us-ascii?Q?KmCVujEQeJiMIw9nlHbmn+wgWN8WXryTGz/ZQVKOJ+IbfcpxmqT+rZYeZ7MW?=
 =?us-ascii?Q?2HcboXEXFzpVdovykCu6ApSxntXiTJUuF6hyqWALWw0QKy3OmJhxzAKmjKoI?=
 =?us-ascii?Q?qNXYTvyBIpP7FZ8UzkLkUfjKSbWAewZfACyBwj8WyeBeMhIu7CWzuXJyxgRO?=
 =?us-ascii?Q?SokUOrMNfQ8crWRlOK4CAh55P3P7MXYf3d/SnPKOfHA46vfcb/TpAp692NFD?=
 =?us-ascii?Q?ELexjMMF+ud4lDFsDrD6nXvPfiPI81X6ABBxoh710tvXdB5J/Bub0e2I6Zuk?=
 =?us-ascii?Q?KwrbiV4JcoLD2wg6Lp7TAs4i6Nlgvjru3r/m22icnzsLQuPAHqkR5GuDQO51?=
 =?us-ascii?Q?f3oFAwo1iEoAtjCGnnEMJW2uJmC9RYiTGQpvpOcxzCyFVHvt5TkJRA91DaB6?=
 =?us-ascii?Q?vJ2GynxJrDPcoZi4Ak7NUiFh6SpeQ1iZ5wkDsvQLeyzrbAw7x+oAjdNTkyOO?=
 =?us-ascii?Q?kPbmamIHHVrxSO5Z7rEtggJ89RqXgwxCNVB5CEhcijU6rq7I0n2ROw2xGVkc?=
 =?us-ascii?Q?0BqFmd9FM+zmSqARArusYUNX0faT9Dvr7adJva6Lg9VKELH9iySEvJxD0cCT?=
 =?us-ascii?Q?GPTCComqwsqZc8WFBt7TBEglVhz4Hed+v1+MF2hH9WIpegKxLU1Pgw8pwr3g?=
 =?us-ascii?Q?PMT+NrlP2oxBP0AGSCF0sowlIh8xzm0fNsaScj5pMypc17yV2YGOiYeZBWnp?=
 =?us-ascii?Q?J77lzwrTy62R5n30DGw0hSunw3WnO10r4yC1ReoZdn94GpaOvg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f/ZFuOIjwmwSZ9Wl19853/cnGzEQJRqjUez5GNU0zSQ3ALcwsZKVyFvWfMm4?=
 =?us-ascii?Q?327KNvJg7a/btpjAUDj+Nnl5fGHprWU4toiBfUe1f9xZBx9hGg2pPx4EJ7/9?=
 =?us-ascii?Q?wX6K0G1V7gTmsPPqpPdSYgl6bXs9nT6Y+YuS88bvhXAEylV56Ql22qGUw3Oz?=
 =?us-ascii?Q?KRk4gS7e4Bw5NcuE6kXwo4Erf2myoxOWpoS6racwNdfIyKe/JcOAHGLeusW0?=
 =?us-ascii?Q?gPjB7qpz5Nn6d6HVYz5dMMytc8rCJ7pMftYqrqbn8gxxW9uIpNtCoU5p1JG1?=
 =?us-ascii?Q?+bd4kGDAmKN1vZPp79vYVG0mhbctCY+E006CKilHG/9U7yjdLqutGYOGb9Vy?=
 =?us-ascii?Q?6Y7Egy9ueZtkcorslew75uFA/DfO1WBRQ2kkkhjU/lZUihGBsT2omcWKLy7m?=
 =?us-ascii?Q?Ic4rQS1vY+lLbOcgr/yozRVbSNup0L84O/p9QlP9k0+VpwSB5SuYcU/yJSMc?=
 =?us-ascii?Q?q8K23auK5+KK69rbi0KwDdYSxqNnMYmby36WsIAExigZib5TlyqBXeLdLvX/?=
 =?us-ascii?Q?h8RHNpx0NIJ/Q+yCZbPf3oQD2QB6rxp+FKjwXylqOAl58eHARja5X/Pg59Dv?=
 =?us-ascii?Q?Wp58idwOFtG/PxQkjl0799I798VvBzPj6lbJ2RhJqYZGIfIg4n7/gz8LtLPt?=
 =?us-ascii?Q?iWQOjYbtqibijZjxgMbengVRo/2YiAu3gGVT+nineMlD3tnlZ1bnuWsziT3O?=
 =?us-ascii?Q?XGt6WEd4c1P7RdM/rrJUEUiOniIcN/SF9cMWdVDBwUew8zSPmsuiFgACCzLy?=
 =?us-ascii?Q?2GzWOWFmBvWwgfFZF6MIGT6D2zysvIxkx0bTbxp6FB71wXqs+x26GYSXvo6y?=
 =?us-ascii?Q?gwScLn5cCTUz8TDbkchf3cRvrAVscuYODjXpphiHZHIcv5V9D8bn8xA2Dzk9?=
 =?us-ascii?Q?Hjd3rvA5TIE8eS4IMiMTvHx/JTg8mHF51F6lsExyuSlLv/We6b8WiKdtB/5i?=
 =?us-ascii?Q?NYv/E2pp25blWwBgv0RQ4wLlHDkU/WyQQH3gv0XaIsUYEXClaRbKO0FhVayB?=
 =?us-ascii?Q?j48OTaphjXfsOs3nZVmASOcqt9kFPALHtP7TO/vN7vb824WIHLt1YgN6YAJJ?=
 =?us-ascii?Q?cF6Sk3vnWrjAyRuz8RJOrjHgGyQ9iLNSoOtPlAInakytR9d9508kiLVKugpe?=
 =?us-ascii?Q?rSAN5f0OEqzWtPZXF9KRbzQkt4sUhRjqOBS1vycDqgwFfpIjENokZBZ09wmb?=
 =?us-ascii?Q?5sRwhDopBAf8xfutW4hZBbvLSiKP1vZLifDfhk84wR5iYegILkYBwY/fS+w+?=
 =?us-ascii?Q?eMBNMXN1Z77DH713Q1pTZ92WtgtbnmKE7BzdtgSepZoePK8lyX94q9B0dWz3?=
 =?us-ascii?Q?B5QINJko73gF8xQjvjhbw4lFdb2XwwvHTIWkClhS4eQfBrejp20G6KR4pp/+?=
 =?us-ascii?Q?Zk5p8pe3htY1ajEnGU/As13G2qj7nnCNdoGDZ9rxYgaZ7+JiMUmJrVeLEI+i?=
 =?us-ascii?Q?2wd6V+PEIsgiPM5YFcZcGphcBZsgRTjPQf6zbu8i1MVxA8CWLV4DlOfnKj2C?=
 =?us-ascii?Q?MXAyOXQRQFvVtwnN3iJLTTaQGubBcsMeTtcwjjxfGIdUrboW3Ntqg0JlzSHt?=
 =?us-ascii?Q?lSAIFXqMQABmjzajLHIQ5q57KMeI4hxfKpRrEe1U?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 671ba232-c610-42c3-081f-08dc966f93da
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 06:08:34.5773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZeGTWJVesWvsi2WcTyWSYHceKCBL1lhqWscC5xpdxxDzEczlz5eDtpm1n8iZJ+2ULW0Hl6C4/0DhlzaDejJjkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7551
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, June 27, 2024 10:31 AM
>=20
> +/*
> + * Cache invalidations after change in a context table entry that was pr=
esent
> + * according to the Spec 6.5.3.3 (Guidance to Software for Invalidations=
). If
> + * IOMMU is in scalable mode and all PASID table entries of the device w=
ere
> + * non-present, set affect_domains to true. Otherwise, false.

if no PASID is present then the flag should be false.

s/affect_domains/flush_domains/

> + */
> +void intel_context_flush_present(struct device_domain_info *info,
> +				 struct context_entry *context,
> +				 bool affect_domains)
> +{
> +	struct intel_iommu *iommu =3D info->iommu;
> +	u16 did =3D context_domain_id(context);
> +	struct pasid_entry *pte;
> +	int i;
> +
> +	assert_spin_locked(&iommu->lock);
> +
> +	/*
> +	 * Device-selective context-cache invalidation. The Domain-ID field
> +	 * of the Context-cache Invalidate Descriptor is ignored by hardware
> +	 * when operating in scalable mode. Therefore the @did value
> doesn't
> +	 * matter in scalable mode.
> +	 */
> +	iommu->flush.flush_context(iommu, did, PCI_DEVID(info->bus, info-
> >devfn),
> +				   DMA_CCMD_MASK_NOBIT,
> DMA_CCMD_DEVICE_INVL);
> +
> +	/*
> +	 * For legacy mode:
> +	 * - Domain-selective IOTLB invalidation
> +	 * - Global Device-TLB invalidation to all affected functions
> +	 */
> +	if (!sm_supported(iommu)) {
> +		iommu->flush.flush_iotlb(iommu, did, 0, 0,
> DMA_TLB_DSI_FLUSH);
> +		__context_flush_dev_iotlb(info);
> +
> +		return;
> +	}
> +
> +	/*
> +	 * For scalable mode:
> +	 * - Domain-selective PASID-cache invalidation to affected domains
> +	 * - Domain-selective IOTLB invalidation to affected domains
> +	 * - Global Device-TLB invalidation to affected functions
> +	 */
> +	if (affect_domains) {
> +		for (i =3D 0; i < info->pasid_table->max_pasid; i++) {
> +			pte =3D intel_pasid_get_entry(info->dev, i);
> +			if (!pte || !pasid_pte_is_present(pte))
> +				continue;
> +
> +			did =3D pasid_get_domain_id(pte);
> +			qi_flush_pasid_cache(iommu, did,
> QI_PC_ALL_PASIDS, 0);
> +			iommu->flush.flush_iotlb(iommu, did, 0, 0,
> DMA_TLB_DSI_FLUSH);
> +		}
> +	}
> +
> +	__context_flush_dev_iotlb(info);
> +}
> --
> 2.34.1
>=20

this change moves the entire cache invalidation flow inside
iommu->lock. Though the directly-affected operations are not in
critical path the indirect impact applies to all other paths acquiring
iommu->lock given it'll be held unnecessarily longer after this
change.

If the only requirement of holding iommu->lock is to walk the pasid
table, probably we can collect a bitmap of DID's in the locked walk
and then invalidate each in a loop outside of iommu->lock. Here
we only care about DIDs associated with the old context entry at
this point. New pasid attach will hit new context entry. Concurrent
pasid detach then may just come with duplicated invalidations.
