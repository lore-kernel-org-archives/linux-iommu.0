Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8C5440635;
	Fri, 16 Oct 2026 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137581; cv=fail; b=KUiDqFl2e34XgjZGR/WjUYsEkicDW9s94HC5xgRFJ8nUJicdnnZQrd4/3K/VqkUdE/4vfkQux3p8cFT43lNM+41rbmELZe0Q9f4eIkuxSgF5Vb+o7Eci58vaa/ouwVJcNsm3+YBLycEeLfz9rCbwcl0+r/llS7zZouC6Huk7BUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137581; c=relaxed/simple;
	bh=96xepbCHSClTrLawsYF41uYVODBUgaoYjCV2AHPX04w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=maZ+rkG3ww6x0za6cEDTK6bycfSl1DUOlujTNvM3h5CnKQIMVEqhajraAIheu6dQYgv2A0IOwvxnFTbIbX50NwxMtKYwgztEOy9Y0WL/QKyWJNQrFP3dqpYSuWp6vefdP+9uQqwTqq/9bIuH1vb3srEKQ4V2E3fVI5k9+7FpxD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iASWEX4P; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iASWEX4P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792137579; x=1823673579;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=96xepbCHSClTrLawsYF41uYVODBUgaoYjCV2AHPX04w=;
  b=iASWEX4P2UiuHtf5sk3iuNYDlhUDYNlWHxPGFvT6VZCESt+6pC3v23Zx
   ZNPo+ZgPR4ybRkjTKtPeCw6H6V8zEox0KJ/sWSgEZMfs0NdWupCBFpGyN
   1O/EzFj9qo8F6/UiTvLQcd20L71kpKEHziRlGaVxATsVN8jEh6mRDhMKK
   OMKZmX/LiQBPHv15iXU97dEf7pFnGJe3FVlMjlROIiNgDgJ2cNOfF4LYY
   gcUv9+lEhVxWDKcD6Imutda8nEfVxIdS0q/t2hgxNCcucKAA2DEdpYIuK
   G9TqjJmd+sNWYbaD64GwE+2DX9BkGiPrrZvA/ilObAOt931ZJbkQ1LruS
   w==;
X-CSE-ConnectionGUID: KPI1Voz3TmyI5nApeeZdgA==
X-CSE-MsgGUID: 5t0j8UyZQ2+3b1OBPjjMIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="796574"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="796574"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 00:59:39 -0700
X-CSE-ConnectionGUID: HUAGD/JWSgOXKLjijfiF7A==
X-CSE-MsgGUID: trGy8nlWSwqyuuLcXoDl/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1958296"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 00:59:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 00:59:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 00:59:38 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 00:59:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQr+9iY4CaGIEnndUxmM9TGooh6RQ3TTd+mBxhnjxoH43ZjiNTxmOvDF9xg6VOHYhS7tDSvCfaqNeJcsqIu124EhiWsC+1uF7SihSMc+a/hh/8SUg/3OEKIYlNYpta0EfbmuRnS81IEHyJyi4tHUiQ0GXwDKDi7hZe6WU7dCZAE/gmCCfsG1qAzKhZ+j+Gx0aua394t8FBo6xEqKa6IMUxCRGJlVRCCxheAYG2uw4y2B9tzMEG28Vk7UuM5kzZGeimcZcj7Xqt3RBtm947GqeR/zwuBXxo62DpzwOkhBkAfZacYu+Lf9UkTVqBsVg9xfFrkfQL5ALd1kR96gUxCAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96xepbCHSClTrLawsYF41uYVODBUgaoYjCV2AHPX04w=;
 b=ymjo4Lp6fqUGl3hxfLqNqleHUc7kmKGy1IFUwc5rZNzJ990nD/2eH1dWqTED0n8nxti7mzHZwkKOb7ivsiB1+kVYvOZHIfi3E7f5dmzShlF+4/vSYCIVNLRo/SDtpXaYG1M9vrzdnimwvzKq8jWb9zH6HPUbE0CFf1jsTLJqiLgP4OlSQlhKJBzgsWl8X1ZrojuzsXRr6fOy9+jntCwi8gaPUh9ADTfv12/upl34NLJ2WlG/4jn8hkzuOtFmYDiP9aGx/13Fn2HNikp8mUM2JygNm8jqk+Ec29fep0GSnQ2o9DPLw7hBC4jYIyZSn+q7BDH/sL2sBwXAYpNMb4/ehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4836.namprd11.prod.outlook.com (2603:10b6:303:9d::22)
 by SA2PR11MB5097.namprd11.prod.outlook.com (2603:10b6:806:11a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 07:59:30 +0000
Received: from CO1PR11MB4836.namprd11.prod.outlook.com
 ([fe80::c8d0:9419:e0a7:5188]) by CO1PR11MB4836.namprd11.prod.outlook.com
 ([fe80::c8d0:9419:e0a7:5188%3]) with mapi id 15.21.0522.011; Fri, 16 Oct 2026
 07:59:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "x86@kernel.org"
	<x86@kernel.org>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kiryl Shutsemau <kas@kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Gao,
 Chao" <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] x86/virt/tdx: Read global metadata for trusted
 IOMMU
Thread-Topic: [PATCH v2 2/4] x86/virt/tdx: Read global metadata for trusted
 IOMMU
Thread-Index: AQHdXENKU45Dvx+hCUirLvU6t8/et7b+KaAAgAGkipA=
Date: Fri, 16 Oct 2026 07:59:29 +0000
Message-ID: <CO1PR11MB48369D5931BAB99D9C11D7198C9B2@CO1PR11MB4836.namprd11.prod.outlook.com>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-3-baolu.lu@linux.intel.com>
 <atB3DiLtGTlilVTN@yilunxu-OptiPlex-7050>
In-Reply-To: <atB3DiLtGTlilVTN@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4836:EE_|SA2PR11MB5097:EE_
x-ms-office365-filtering-correlation-id: b3791efb-70eb-4bd1-2819-08df2b5b681c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|38070700021|56012099006|11063799006|4143699003|22082099003|10067099003|18002099003|3023799007;
x-microsoft-antispam-message-info: Wg+baSzxfWRe0lj6MID2hByHxgsTIMIV1sL6JD9mXC/gjJErWsxg6f8VshZwB8VcNHku3w1zYzq2QO6lsBqw4zvddPZaeY4mq/QA22iQMzqcacesfmdhjVi3bmelzdJvCqON6Z9PTmiY003ouNRX3MbPUmmYKYLNzYwhox0pyscHdHQWfAnE6wSm8d4ntEVQ2amMm0dosy0j0zAdPoe+KA/Du47yaEkGL9/voIcHEmbBwfx0yIGs0DSB3Rt7gHeNwpFWxGbFQUgKuPdkR7Y7AwF5A7a0/SXInLY5XnGYVZ780wk3z13WoppCbpAcELN9dklIVRY9q69Hh4a+pgbrbxP2qcNPHl502nuth0A/LTHGXHeE0+cDD4roF0bGs/1QfVK6uipzno0R7T//W876KI5E5nVBe9PBSS/GGF32YWYILzXXOkz1jtGCLZlDgu0MOBb9IayYSskWOTXUFkS5ePNSk1wNliZUqnAJQR77uP44H7Fqo+ZLkUqGy5qCQkXWjzeo35zjfNOVXBYnd/s/AGI99dr6RsPmU4xdMTUx9pY3p8eEo5e85qAg8c0HLwIfU7YIrafP4atgrwc5hoyxp/A8JgRFt3eR2HJ1wWHnIdg5Ox9YenyLhaluzLEpYnL8UR0kqYcIvHoIbNP/2xMzfrHbpbChGo2RIeWo55kB+5W5CAptZmL6R+X9dAkP2s+EDPswTqY5o8Ocfkhk1e3pnJnbNngFkoHMUf2cfYQOgRM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VHBzmIlDN5AG6QYZKPtC5lJyAfpjeGS5k18oFohKx8T1vlUq+cTS5uG5kpBW?=
 =?us-ascii?Q?g9POQ0oI0Z4jPII0vZWnlN9P+5t8dHO569VzWm6kJoYR9ADMQfSSFPh9FHzf?=
 =?us-ascii?Q?D1fFfpGinQ1K1Sy1/oOEpfyAPjFE4tEIklTRJScf3BnAQpHiPcf5w/XMWX7g?=
 =?us-ascii?Q?NQ5eab/wCllria0BlTHAbbJiYrvicn4ftZCAYTm9fOxyL6iftgKmuegFiHGl?=
 =?us-ascii?Q?Pn2TOr9Fn7w6MpMw5Bbyotd+go31xTEfoRkeIZO1zbaGckEvlzpPWchncXOe?=
 =?us-ascii?Q?PBibYe7yNHOPB3wkAGVyZA1l7r/+mLYSp5shKqZYdIbqRw/5/skD3MC+pLgb?=
 =?us-ascii?Q?KSuGfiGD4hFgsM6oKW15wBXoBp9hr+Rxv5oGXXSgmQPxI2pPF70Jg8eb+uxS?=
 =?us-ascii?Q?EKtWpybzVBfTvnz1bkti9sFVdIrIhp73vhv6L17HlJlr9PCTs/Hzk5vULB/1?=
 =?us-ascii?Q?0GlqZWKZ26tnJPxFAUR5EmZZXbsQvInl1zm8o7rXX37Z10quidIHXBSE9WXM?=
 =?us-ascii?Q?bKIh91hSHr73nmb6xGU4lEawXiU3NIWBOVPBmbGRH1glKUe4toIIzlGPSDv4?=
 =?us-ascii?Q?Kl02JtkPWmekmmYGmriyYZvYeDsA3srQUY0GUh45CEjeMjNVSc9frhNgIXy/?=
 =?us-ascii?Q?OFAoHNBj2ELYpeaXyEYQW7ZfPo7xKKuSgbLGyl/pysGliabIzB6mniosvNNa?=
 =?us-ascii?Q?Bd2+FFCHKrLc9MTiM319gi8uNtvkAPucrwBH7zTRsOZnXI/TJjHh6iq90Xhr?=
 =?us-ascii?Q?Q2WuVY/LiFphft6rAg8dqmNYJPOC0T0d58Yl9ya0YDQ8k5ZQZmFEu3elwUmV?=
 =?us-ascii?Q?Omo5FbJ0Kh1/ILLutipQ/i4S57ciAR0CC7q/bswEfTlIPRAYMEQmL/T/qJrq?=
 =?us-ascii?Q?/xuv1freRPj0xbhQR3YSoVdSu0DpJbKoQWkpWbYvvtwPIPujxbqM4eCHZE1s?=
 =?us-ascii?Q?XZ0QDtDKyewo0iFP+W5PtnlhopwCFfVR1Op5HF0JTOqjpOLp+HW1YaJJqlnZ?=
 =?us-ascii?Q?AMLbOdZz8Kn/jhQ3X7oinPzKdC3DHnDKCCjqbXGifTqfIpjX4H2su/1UDw9J?=
 =?us-ascii?Q?FuqrCecjwjEa8AvO3KxckJjuoinPNN1GKrRciLvDIAuhzw7lJtiHMuBu+WOj?=
 =?us-ascii?Q?tg8kFrSma66Br2Xa5NXWODs9En5bp43lUmCpL/yV3JBCEkBbQZ4tiJuJjw7l?=
 =?us-ascii?Q?a1ZZdU7GukR0OdF78r5CJn25CJUYXWOgUrsAuWiIxf1iLSXDBK7sy1KYAukK?=
 =?us-ascii?Q?z0ZDqvplY6q70ZRDe0UVx0oxVJhtfPTBWxC/wQzjbX9jnsW0Kl3mESuxfS5T?=
 =?us-ascii?Q?sLZTL8NPi7mLaShDpK0+gRw6WNr7PwQTv/+47sF2e60I0Etqb5gm8I0jcUWu?=
 =?us-ascii?Q?S3yz/JY7VXebUAL271btR6Qc74LDMRMm1ifxO7cyRAg1kWb5Yvua6E6/Ialn?=
 =?us-ascii?Q?2OPRgRi8cQPPmpN22pAYhGiOfiserLc/Ru2HKIn5Lx6xFHbRHzVIyhSFUAMz?=
 =?us-ascii?Q?3GX+OVBP4DI0flkpyv25XzhqOVfkUKisra7W2cgPxDuodxxKDgJ5Y6dZrYAJ?=
 =?us-ascii?Q?JtJqzyEd4i3LBtenzec0iMTUdgw7utHqm2J2lXL4B4GYCjCFEmCHUOJ9LZz5?=
 =?us-ascii?Q?OAYWGrMw62fPKo3pRyc+HIABkwNkRTZp8iAgDaJKVd3AzZcsdOt5OpH/sfxl?=
 =?us-ascii?Q?QtEWbzpYY6Of+jEeY0avcvFncVSvLAlfYG7o9Orf+c5UIDY5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ih/gmvSEohfzH6r9b6N6lYtI4OyUcAgPy+l3L5IBGXO+PjvZEtvIFIVpHLQY1o8GFBOL3wEob+n9ASAgaRKwIxjcX12HQiaTc6eCkhy6Dl6qvHDHA4D2puL9idwBoUUIkjhLWjGVcviteByWOw3NaHeI9tnX75+W+NEwYY8aQs5AVOughubwGXLpTUG9ncIxguqG5msBxOW4tUIUTprhczgDgS6WP+iy8aa7Key9U/FZLd1ETPVHr1ISJkRMqTJ8htibnfQRN8MRhJyf/2pRSXsGqufjCnTJFh3htso16sbHaw7tLIYscsgWNWqftAHBpvhCXw1IcAAuy6eCMGuP/g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3791efb-70eb-4bd1-2819-08df2b5b681c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 07:59:29.8125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JvCYnPvuxOW17q4ps3LiQ0crljAmux3l9en9oSlx1wBPn/yOK1XjnQm/vBJFoPqXdgSSwq9qfOuHgPJ6q9JuvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5097
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Thursday, October 15, 2026 2:48 PM
>=20
> On Thu, Oct 15, 2026 at 09:07:03AM +0800, Lu Baolu wrote:
> > Add support for reading the global metadata of the trusted IOMMU.
> >
> > The trusted IOMMU feature is optionally enumerated via TDX_FEATURES0.
>=20
> The feature name is not trusted IOMMU, the name in the spec is
> TDX_CONNECT, but I believe people want a name with technical meaning,
> maybe TDX TDISP? Open question for all reviewers.
>=20

According to the TDX Connect spec:

" This document outlines the system architecture specifications for Intel(r=
)
TDX Connect, a TDX extension technology for secure and efficient=20
integration with trusted I/O devices. "

So "trusted I/O" sounds a good fit here.

Or "TEE-I/O" is also clear, based on the TDISP spec:

"Trusted Execution Environments (TEEs) that include a composition of
resources from one or more devices and the host require mechanisms
to establish and manage trust relationships. Here we will use the term
TEE-I/O to refer to a conceptual framework for performing such operations."
