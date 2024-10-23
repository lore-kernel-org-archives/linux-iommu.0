Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5803A8D0
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729668071; cv=fail; b=KMpHd8i+U0R30aXTsPPVAzoh/kTHJDAxyEBrUvnSH4EC08DvfiA7lGwPp6jE2Rucu650iU5PVEel6SoubdM3IwvYkgKRbT4cFGaH/9mkIfFrKqxUfqGsjcn2M6zW2iLfLC/eysrDSg8swzAqBUKpjmhjKvQhSN/DGSgRM2tHxak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729668071; c=relaxed/simple;
	bh=/s1YKSjRgi5hSk01jg0CR+76KD6SR2LBaoNd38/yJWE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IcniWBaKE1Vq/A74It7HxLgNGRhYw9/fCWQALgrDjDBBtZVVl5rsWEjyzpe4FP+Befg/ngrBAs0de+OFb0CkEZZiaG/FIPN1pmIwtYosY9fyPQXOTUjh5jj3yhVMaAWXQfWUVCmZDtXEIBz+nh93GWRXpNHYXlDk+9aBBjLF2rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hd2u/flE; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hd2u/flE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729668070; x=1761204070;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/s1YKSjRgi5hSk01jg0CR+76KD6SR2LBaoNd38/yJWE=;
  b=Hd2u/flEMg7tKWMkbRq54tqkYPbXFysPx/dPDGHl3zXyNZ5Ul0U2mF6D
   TtQSNYWkV2My4m1UxOcJppnzIRdNfiuRR/P/GlVepC9Cbx0jyIAtMRRTC
   /hrxom+Hg35Ip+FkmKioadVFPKVSA2Fczijr95DXxrt/qUfEZHts2y8WO
   hAoa2WUsM9m/4vQqx/OHstBcXnHKcQMBtbecoYtDU6+NnYeuKVJIm9YAc
   +RDlOHZHSQDxPSBTWdxhuIbU13AoVirv6IXNFtW9hIWv9D5x8Bx8zi+Vr
   wieUppVnH1LEGeH3IjoLKRmJXom80H4lRXc27Ysc+cnIwB3NrZlkfD+mB
   Q==;
X-CSE-ConnectionGUID: S2lhQ7SsTVeKUYdnkWIrog==
X-CSE-MsgGUID: JFHPR38XQpyNaBsdK6j1Qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40359095"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40359095"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 00:21:09 -0700
X-CSE-ConnectionGUID: n8h+PRCfQ9qEO3Y4h2b7Yg==
X-CSE-MsgGUID: OU9YqMJ7RD+76nZHhgwnXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="80183151"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 00:21:08 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 00:21:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 00:21:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 00:21:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAtKb9PRwnYUyMFakTueSbvWeN/U/IhIomrXxwzNysl1AODYCWX7FvFUU8GrdE140612GzX1L9AQ5B6fMaWVrRTJ4KV685Ih1mtYR2OnsXNMXIYhkG/KVSQ9loxPUyTa/THtXYhHME+WFLtLh8WEKbY763zPrp6bISTU46e4AjJjPz9vspumB4cLx/u9Hz30JDzUma790/wi602cafBtA1FGD+sepf3qh2cD8UQ17HHtqUfQEynmt3FjketUZ3heYkDfvOWwNJgmxIsrpRCB4MKwsSxCq7+DwgG6AKw4wy0Dwp7puavC3WdhZZo2LEisZqq1Nxf17yJ6xIcBlS++9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3wFWEgssE2AYFTUvB68uXZMQJpNCSS+To+D4/nwN+U=;
 b=TEkF36XHf411YM5udV87bWtF6oIO5ivk1lLCRoNqN3fqzExfdWtKVwbo2c6U3KALzBEFayBLvoZTH1D/XET0GNmxzmFY6pzQWt3MJ/U5UTNoj0KAAEDUdHJRFKUkK0nX9UB2dML9TMHFjBKz+ZQymgE2YiMXgzQz0pOhLqROrP7C4fpacO0du3NlQ7y4wj0NJ/6UiozulLJCselCMnThPlMwTupG5RjmIenkh8ZwTH3Bz8blQhRE1e3DB7RN2aRl+73Ck8haSDfFkg8me2mT9ZMwoK1KBZS09XgQl3E+bNMCaOig+LQP1MVZLn7xYkPREqF2KXyDEYfcjr4jzHfNWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV3PR11MB8696.namprd11.prod.outlook.com (2603:10b6:408:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 07:21:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 07:21:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH V5 5/9] iommufd: folio subroutines
Thread-Topic: [PATCH V5 5/9] iommufd: folio subroutines
Thread-Index: AQHbJMWJ2Ao8SRUSfkq0gkDLwqJNfLKT7ZDw
Date: Wed, 23 Oct 2024 07:21:05 +0000
Message-ID: <BN9PR11MB52763A8B95B982399E62EE108C4D2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
 <1729630838-24586-6-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1729630838-24586-6-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV3PR11MB8696:EE_
x-ms-office365-filtering-correlation-id: 98f899f1-8736-47c1-011b-08dcf3334221
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?D5QWhUIMUEFtL18dsBjinS+QoPDrozUhh7SUdkDyZ2XgqFO83vFopk97gbgb?=
 =?us-ascii?Q?Of1OtaD0hlNnBif7sU9UkzqgoezKxlkQzgzEvi+bII5oeIOYZbCzr3/2NOhk?=
 =?us-ascii?Q?ZCtEzOTUl7oueVZts2y47kv6LyZZLi8H/Wyxwq3n2K+74oJg8EgtxqPrJsyw?=
 =?us-ascii?Q?+CZCJsnpyRTbdUKIxWnoTwTSpqSpGgcWFVxR/4RwpgFyJQrj4gDlKL6EItJ3?=
 =?us-ascii?Q?n1pdltsCSKbOkGGzvwaNKJE7bVnZxC4VxXsYco9Bye+TtiVFHJENmStPxXpY?=
 =?us-ascii?Q?DNQqIVvWW15l04tP3vaZj973O4i/kh799ASghNofjQou05NccDbdb9cd7lto?=
 =?us-ascii?Q?SW5S1om1hT1Yw6dh+Jjm7JSXeB5QykPCalT2h8Z8WDyTU6E5vaDv6jU2oUgN?=
 =?us-ascii?Q?9d/mHmOAgSvUNuhhMAoRinQYTxZRhAbGrFDgJSkMRHBhxhVebvCf2IQ1tMz7?=
 =?us-ascii?Q?Ms2MWgsbju8Co4KNijS79TwYxT9GWwSBkUUMe3yEZ3//o6gRSpTrGdcyiDUZ?=
 =?us-ascii?Q?mgvD7D/c3fznXLA7gDkFimBKKniNF+5ky3K8R/rEcSEkEF9A106rKI5rsHQf?=
 =?us-ascii?Q?fIOGYp4Wc2AdKu5xnImXuGzd0Sz15UKeLpMMf9Z9HwXakCDeIl88j6AxMlAG?=
 =?us-ascii?Q?bnqIHiMfGx+rKIEruCXsQEhFlJAlEchbi6HdAw72SZ521u/qaXMFYfyRh2K5?=
 =?us-ascii?Q?OZi0crT26PWiTxZaBwTi0oICbuiMcvmlE3i2u1nVwd6o7R/OwoML1qk98zs8?=
 =?us-ascii?Q?tKpnY6o1uRWiJwaeLhMfqNmwi1QlQmIb8re+9gt7c/uCVs54PTwsPYmz59SX?=
 =?us-ascii?Q?KuA/YCPrcq7GHnjVgi7dd+rrKF8kgDH25kCX+2HGcOI7/aUayVdSFDIN2tss?=
 =?us-ascii?Q?LaVc0oSkcfJj+UGZxYyV/H6kOXK6LYT1mioXGdPYupR/gq+n2PBtHaLiizUR?=
 =?us-ascii?Q?fy0SBVqvjST76/n2BVdU/D/kI3PaPyggjxPT837OyQgWbbQtkm/zEq7lIpKN?=
 =?us-ascii?Q?TobhLWiCBz02vrEVgAO314tfugM2OBbh2Uq9+0JGeKp8NaNHWBI7uzjcARih?=
 =?us-ascii?Q?oQq+rOcI/2GRAqs+AfuCCbEBvJlq2A6G0/OrrFpmTYlXVjHSHrdLaVL4riZt?=
 =?us-ascii?Q?ghJmCkXRT9GNToCLzWDEizsa5bSChsYYMh8zzFLb9pEDmj/oCPbjLDuExoSS?=
 =?us-ascii?Q?ncCJgieYtYa9tCGNrmAt3JYGoHsEmb8A5NPndQmYu7jqMCqQLbvvPe6mXc+d?=
 =?us-ascii?Q?cET9ecJJ3GtuFm76UMZ6ZNbl6OFuwZF7Mn/Ot6WrNIit9dALYMlKcMFMycjB?=
 =?us-ascii?Q?XVHKcIcjUPM5D336UwpG5JLq13toKS5FShn04KZubbaSFr55tWlTdXObrpOV?=
 =?us-ascii?Q?YC9YdbA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rESteYU7cmRuQMSr9RZaI9eyz/xt0aglbn4Bzsxm0mR+KFN3WTvhBDd8WzD/?=
 =?us-ascii?Q?qnDrnXRY0S47loJQKmNVGA97yjq2/9gIoVPhwKYlCPAFL2hYPV7e2BvWWgxQ?=
 =?us-ascii?Q?vnTM7MHHRPGAwevTgiww42SYMmrbszNqurbtM5t9z7+3Prlr8aJ4fhcB7yXF?=
 =?us-ascii?Q?zYEN63coxPJW9PCaqI9COlYoQe4ERJ6hAw3BUHKi2f/eKCqooZRiYfhOxVHu?=
 =?us-ascii?Q?hVtVolBfg+6x2nOUTmuOptAXXpfLGvPT1ofUVxSlBzdfHRiyeQqYuuSugugG?=
 =?us-ascii?Q?LMUqGjt3IMCwQZW14bDx9xPm/LRWzBhfjR/X3oBTdjxpKSAlLdkEy7go4nGV?=
 =?us-ascii?Q?fXZulnApF8ZIlBiwsQ4HAlVDIADtahhtHBxwANrPJrO0VQr27WXTRDI/mff8?=
 =?us-ascii?Q?NTXfnbmCcXa+0YzdLweRAKlHWAqAGkVtLdSWuHsnRi/7REB2+2e1Q8Po/xco?=
 =?us-ascii?Q?LE/vbm8rU7szvImcbK4wM2e18CoC34sOYN1TR7LL9WAixJ4CltWen9mCsxrV?=
 =?us-ascii?Q?AaWoCOwDZSfQcw1iJryU71kJgA9UE9VuviOnZ4tcSduLoTbmTj0mHzqu+GBp?=
 =?us-ascii?Q?XVT46IK65RcXZOLylY5iQX81/sAUG0tNzGija9pDvGU2P2QJUUGdCp1FEGYb?=
 =?us-ascii?Q?/wKKyO43pz7rIf6lDAKNxZl4NFqRPc8tRPkdDISVf6DGsY+V+y5wMMwdi8WK?=
 =?us-ascii?Q?KP5Zi7aKOlTsO4XYuAEwTLK68WwTiTQsDPWdZ3fqAv9KSSxcSmEFvQZRKR9j?=
 =?us-ascii?Q?Z8nvEwo7jxAdwmtMd0W/lFsHfk9VWFsV+4kizGVr37eZVBwinBkQcu8lqP/q?=
 =?us-ascii?Q?9NnEQ3ci+upG8lCa1nAjBFHeYoyyaiVXpUqiyW8hWIKwiZ4bGpGl60435xEy?=
 =?us-ascii?Q?mQmMSgum6OOGy0a8FuwJ5FQuJn6yxbzYjLdtrnis5Q7xRGzIoOmrExdayfCC?=
 =?us-ascii?Q?RKzl5sSYUJ84zcXg+hsTrI640iJFaYI2zmFTjVqiZB4mZqtaVuO9/PqR+4ef?=
 =?us-ascii?Q?8TIJPekcNCysCjyswcT3XMBmn4b4deAgZqQdW1Pr5KYw1krq1nmgrUA7JEY/?=
 =?us-ascii?Q?hlZPQfPlOHF1VEhR96J3JDeMFLK05zSrr/PuW3avrn4+HXgLWf65xMr12b2m?=
 =?us-ascii?Q?+pXCMksreoQJoYQ8MJ/sw3b9UKh+/ZU9jzwldw5koQp1Xtqxfe1srVzhPN4U?=
 =?us-ascii?Q?7VLHZFQQ52hEiqF/it78WtdHWgcT6xwVQ2Jq8P1GtLwgj0cQyrqn6z9ufB0F?=
 =?us-ascii?Q?vWQV9BKlRseIqZQsE7PSscUVHiCzF+/JVBhv9PDmmlmPVcg6XJp0CspEvTLT?=
 =?us-ascii?Q?nvskSCWwKpBu1r6FEzFIdvBJ5TMdpGQAPup6wmA+I9XONQo8RHk+OKz4FWQW?=
 =?us-ascii?Q?CXYnpaHAxuyy3vvBl7xXnIBaWzFaDrqW9ojkgoBVntah4g5qw5hq/r7jRlpt?=
 =?us-ascii?Q?NZOT5VFQfvIgGtxp4dF+5nezIMqUCVlV0YwQZtkVc+8LPsTk+l8w5emKD8yJ?=
 =?us-ascii?Q?sq8fRv8rlvZIuJSp2UUu3DOKba1LugKF4YNnjz+RGECSBzZSfmnzyWAl2+rW?=
 =?us-ascii?Q?o4ng/mneyTlCRGRZSDor3wRvF9aMngQrfsbJMObR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f899f1-8736-47c1-011b-08dcf3334221
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 07:21:05.7951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ntsDyZ5h2DowJJXDF4It/lt10Ajbsz2/j4xFXdge8D9qFuvRF2dD9uBgp6qXmB0wwYZ7jDPux7X5772APuSVhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8696
X-OriginatorOrg: intel.com

> From: Steve Sistare <steven.sistare@oracle.com>
> Sent: Wednesday, October 23, 2024 5:01 AM
>=20
> +static int batch_from_folios(struct pfn_batch *batch, struct folio ***fo=
lios_p,
> +			     unsigned long *offset_p, unsigned long npages)
> +{
> +	int rc =3D 0;
> +	struct folio **folios =3D *folios_p;
> +	unsigned long offset =3D *offset_p;
> +
> +	while (npages) {
> +		struct folio *folio =3D *folios;
> +		unsigned long nr =3D folio_nr_pages(folio) - offset;
> +		unsigned long pfn =3D page_to_pfn(folio_page(folio, offset));
> +
> +		nr =3D min(nr, npages);
> +		npages -=3D nr;
> +
> +		if (!batch_add_pfn_num(batch, pfn, nr))
> +			break;
> +		if (nr > 1) {
> +			rc =3D folio_add_pins(folio, nr - 1);
> +			if (rc) {
> +				batch_remove_pfn_num(batch, nr);
> +				goto out;
> +			}
> +		}

forgot to ask one thing here. Could you add a comment here why
additional pins is required only when batching more than 1 page?

it's not clear to a person w/o a lot of mm background. e.g. in patch1
folio_add_pins() is introduced for partial pin/unpin within an
already-pinned folio, but it's not mentioned to exclude such
operation on a single page...

> +
> +		folios++;
> +		offset =3D 0;
> +	}
> +
> +out:
> +	*folios_p =3D folios;
> +	*offset_p =3D offset;
> +	return rc;
> +}
> +
>  static void batch_unpin(struct pfn_batch *batch, struct iopt_pages *page=
s,
>  			unsigned int first_page_off, size_t npages)
>  {
> --
> 1.8.3.1
>=20

