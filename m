Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FB944C7B
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 02:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719282264; cv=fail; b=nNTsgozrflRvl1dtp+2oiGDivCV/52Hx3dU7O86uKdsOLgAB0wapfyJYGmVqplxRHHU+QG3IY6xNo98vy5a+9y2mU16zbxnUfa5sLO5aGPeqy7VeLtm028DDcQJJqmIRRhU4qGYqhZ7HUBQFOKZRW+cndAYe2xb8wo2V3539emU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719282264; c=relaxed/simple;
	bh=RpXU0tdfqPPaPDGBR2Ra7E9n9i8XAmfZWxMQi8TZKgE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gHtwGz/qyUmK82QKH9x9PWek2hzMU2MqCqHlsUNdfh8Z8eImF2oxt7ElMtrLZSYdPKyGvmWxF/9HWhq9SQbr790kzubsxNBQ0EbAomzCHLMJO7zXu1mknvF+Ko4G16HspFxDmEVwRQ2KH3QLs3zanHimOH5MdxOR6jQTJ21OVeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=faAeaaLE; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="faAeaaLE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719282263; x=1750818263;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RpXU0tdfqPPaPDGBR2Ra7E9n9i8XAmfZWxMQi8TZKgE=;
  b=faAeaaLEjyoKlJDpUqMDTPdpXgWiCi0Ykipv6i8QWB49FcUDoEJ2Y9mA
   1UKZhYQwhqRMFdFfUKfqpc1s21y0Qexnty3nq3aQzNWlubhWKSgyvl8NK
   1CJRrtDgWmuEIC27imIdwKUcuDi3tFhhYKHQjbM8twzGhdM0QS+hiLXG+
   6ICHxCiQZtRUmUJAj0BLQ4b0CQF3sPQJTiQDhw0Y3yqWi+88cDb7V674J
   IZqnzuhFNjAOJfiV3oqheRaY27qVIqFaYgRnARPFVnScepduvamUCnA2Q
   6RmmeiL0p+QG4YHB5QjG1BO2I9hIMvLHT6UGDOB2TtFMSvs3ApAcLJnRM
   g==;
X-CSE-ConnectionGUID: pmIf0FrnQiS5QeEqxY6Ajw==
X-CSE-MsgGUID: e34EZ1H9SBGeXlfPJKlSNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="41697326"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="41697326"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 19:24:21 -0700
X-CSE-ConnectionGUID: cW+iC7cgQv+XWuHHn3lvpQ==
X-CSE-MsgGUID: 4wPINWRMT96aTPjmrfXteQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="48662095"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 19:24:21 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 19:24:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 19:24:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 19:24:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lonhFYmaqiZeHY0U6sJ7wfR2cxGPvWK52DmEyGRBNegLJ39J6M8YCJCIEbRd1tb50GyYmyUZECXIQXslSXACR2cwStftoKT7SjknuZFTHPJaN7GstD67kRkRSbPocSP/2h4fB1IJv++C2kHTwiOnZq+Os1KN8zy5NIBgEDCDW6DGFBCmCFJgIUGK0a6Elc/fR35hcZKuPCU1eCwIvLcOea3XaZuTLVIw1oELYu2COC469vHBw3NTJqLfvIFQYCi5kO1TseH/nyHLC1PbgfYxtejFk7xT1GciXSBer2fjZZ51QlK7PpwBWFxNFMcFNayhUOOejA1ovGH4cJpeWFvT3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpXU0tdfqPPaPDGBR2Ra7E9n9i8XAmfZWxMQi8TZKgE=;
 b=Q3TioqeNbM9T3Okur6gZfYNdaTIDIMUT+MytRL1qgWcDVszm7/v1MHboVFCic5L8sPMwgsmlVEGF/IoxjBVqaqT229G1mo/tsI6l0k+bI91b5Wsp/RlSycTBE3NA9h59hPnGJ5Tp+h7PBGeQz6DwtqGcRovX+2QKruBGNK4gIXSQm54oYgnKtFsumpC+a8B4F4HKM95CHaBby8CC/AGk9yZ6ruwboq/tf8vuUtxGYnyGwsSo/x/ZTPdxl8QGqY49GxojtzBTe/ofw9DZ0LoMXWtQMNTOWD3fJaQh8yirwaKHhvpgiyQe13ogMLOvqY1tV0236ZcBsGFHx6a5u8EKlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7354.namprd11.prod.outlook.com (2603:10b6:208:434::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 02:24:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 02:24:18 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Remove comment for def_domain_type
Thread-Topic: [PATCH 1/1] iommu/vt-d: Remove comment for def_domain_type
Thread-Index: AQHaxeDYTpF1AYZrYUe+dbQrV0SFubHXwPBQ
Date: Tue, 25 Jun 2024 02:24:18 +0000
Message-ID: <BN9PR11MB5276CC976EAABB50757A48FD8CD52@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240624024327.234979-1-baolu.lu@linux.intel.com>
In-Reply-To: <20240624024327.234979-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7354:EE_
x-ms-office365-filtering-correlation-id: d1e99e27-67ee-4c9b-82e0-08dc94bdea9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?p7eqtY0xCjmI4qrOpSPAm7YpCpgmlULwUj2iJDf/bWdlDYjQ0LxnkWU31D/Z?=
 =?us-ascii?Q?a3gGqLHMnespXrZ0cIu8y6SGPTwqkwE1G2GImbioMOBHoUo+Yn+1VB5lBt+7?=
 =?us-ascii?Q?1+T4HeNA31o7NQSV7kxIk5y0dE+3e/RalwhpfEZODUQ3oBXLTtZJEXuWk7LA?=
 =?us-ascii?Q?lVum/ZCnOn/l6Y9Kgxh1EONwGKlZiQYb5bd40UePVgb1JZxNTckI9Ne0qt4p?=
 =?us-ascii?Q?Bk+gfWcCpt6vBS9SOM05syOLTFwiAvEfqaPL/fN7bIhWOTFKhKzBm2NMDaBO?=
 =?us-ascii?Q?pd4po6TRu5OADYcu5dMbJKZ3KotgqinS8b+G2Rwj4pm93sGJjVXj7S0K8mV/?=
 =?us-ascii?Q?MGzQbAdVfVlIGG7YHEq4qMoobiLYPGRZxDGUrESJGTRopzgmCjYAQ3Odd4qi?=
 =?us-ascii?Q?oX+/PEQZ2yxrPE6oudm3Pq6Qf9/CjcBBA66vpNedRliVinRIyMHaMS5/7DQ9?=
 =?us-ascii?Q?qASfNMlcFwKUV3ZNiribrzGaUz9hpWC3lFGUM/jq/5wUOxVNlbG9habh1onH?=
 =?us-ascii?Q?ivPm3xamGb6mE+0nHh1fXY0bj4UIbrJzsEWze8AeQF7rWl/NGRM59eZZp4/l?=
 =?us-ascii?Q?Hl0L9qQMkhjHXtsqTEMKkPaDsJZu95OPHCBGohTl8BAVjgCaY+zHS8ErHQE8?=
 =?us-ascii?Q?gjwAr1eV0lOynn+nbqr+hbvgDDKeFaeoF9M3o6SdheWJg/M2XmZE3ITyNCfe?=
 =?us-ascii?Q?c3J8NpUuIXN+f+C0/plNTr7C7dpk1OBzxtRdPnZQDQ2VRd2CntA2FEpW9SYK?=
 =?us-ascii?Q?QB7d51H0PMYU4ECey8VRjSc/Q1RtPV202Hqdh0WvCgoqEUskhkKm9asOd9GU?=
 =?us-ascii?Q?QjdIlpsZ0uOMyqzyzkWd51SBLhzhHiT9iOyq+eEgnBX/ct6FIRS7qIOmpe2n?=
 =?us-ascii?Q?wH5evo3iWxv8dd+H0A/45O/BN2aUytgjd7p9KJY/UFx5lcajHNou2YnYuAv6?=
 =?us-ascii?Q?QZg1XnO3PC2mv/8ZauKC4Ijk/qHEb4j34PH3ReDubiuaRhOGctpZ1Eu4zxMI?=
 =?us-ascii?Q?I1GM2VRHVR2kITbTevzn/m065DKT3oW/M8V4lYh5dTGaxVlwsPUtfCD0cqZe?=
 =?us-ascii?Q?agudP/lkhMsIP2bM77o9GQDG6RaG3m+xFRwQYnoCFUA60JzRW9ltCOwObJdz?=
 =?us-ascii?Q?+qH+/oTQSXdro0raDBNyZ1OPSm3Mf/bqyxkLlrQRYqpdXzEcM4ldm9qZjLLw?=
 =?us-ascii?Q?eXrqvoUPGQ+rcw0sD92hUxV0LhU1hwH/y5yy/IPSD3cxc7Y0qaAHBDDwogq+?=
 =?us-ascii?Q?A0XbbsQurhE0pzggkPWR76bPsgxcnEUx5m/7dX+/ySkrh4aadmXsui9djYyD?=
 =?us-ascii?Q?UhXnb4sHSO3okwo/hF93/spS2q7UXbGyGfphaJQeO8hOCEwtmeLZM/hXhw8t?=
 =?us-ascii?Q?DSgrNpA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/Hp2SYduIP8popP9GtYRfCWbtIJi0ofWgmtMZfNHdSgsWH1uE5226RPdH8cs?=
 =?us-ascii?Q?NGBZsIMtT25JHwa0nKhdBUfp9L4sbCegfnbAKeL09b3R07IZuuJpDgofq7g8?=
 =?us-ascii?Q?IC4f54KMoPMioNrjWL+pfJzWvySDtb1d57Pa5q665LYN6xAEkiHHZrVi1JPV?=
 =?us-ascii?Q?L4I95QsjlO4yIKrVSswvOeSJneVd40yw/E8kgKyIaG05hXVbsqkjSkW2wvZt?=
 =?us-ascii?Q?Ook5/rxHxzrJklReBgxt3eWtOYKTboqlBfZxcwzQ3oZePgZSY4XdkLCmnEVr?=
 =?us-ascii?Q?WTTyR7VrfE78iz1bffiyAPanvH3Trjnh3MAjnuFPILwpqPcQCT7qV4IdhSRt?=
 =?us-ascii?Q?HE3oekcSRmEMC4IbMqLvvKvomr1AYSl8PT97djgdSM7lAVPHSiTselKM16gO?=
 =?us-ascii?Q?SWiEy2MP9WLpmf12T77Gf4x6vuH6/JfJhSLgv+8ttjrBV3+RBHyLHQtDfoH2?=
 =?us-ascii?Q?dqH5DnFNc2g4SmEedouxYqtZBl4nRqDaXL3WxXVNx7PlMPPl/Dcd7w+yYO/o?=
 =?us-ascii?Q?aSCJSfuZeg3kFne7cMAwgmoSIcNNGlqxBRNT1qLZaMA1O0GADMrUHkR0GLDa?=
 =?us-ascii?Q?z6qt+aT6HzNLuedY/cfspPpgiBjxDhLQlk2W3+VfGFz16A4ENxha4SIljlup?=
 =?us-ascii?Q?O8NlncW8MjLMsWZAjEyRbshnSoo2gZJLtdb3mUuf18AsgC5g11+vHW1yhOCr?=
 =?us-ascii?Q?j/VT2L4LFdiWq5eNTR0kDjWElmMv/nngyEYDvmDa4+iANTYb1IBAWEWIbEow?=
 =?us-ascii?Q?AioTuBFdxR5l8AmUX5/juG4fAwHSAUosZLMY2y69z24ibSaizvBls5mNv2Vv?=
 =?us-ascii?Q?e7iQxUCIlvb1eQ5lwTmyItQdYgNnPAlP384E6IDycmQ0SeNZux25fIdxRSyx?=
 =?us-ascii?Q?UZhPPlRmhzIyRiCyc94leoC4fkzAmFrvQsKxl4sDVT7Ohv8iU8WyMsyf9byY?=
 =?us-ascii?Q?AZHc4Wvs7o6UsAtxwZFAECEvr130H+8R1l/1yT8Edsa4GTSUSYr3cq0caFPh?=
 =?us-ascii?Q?d3MANEOZ1Oxj6/nbCIon9Z771g5bxtMVNxa4n/CzOZawd6/kFZf9AB+3BmfC?=
 =?us-ascii?Q?d7XLH4s1fFltj6S61hmYWAxPYNHgYA9gzTryuv++Us3gS4WhNNuuX2YLlxO3?=
 =?us-ascii?Q?tjG3+PGjHKPLQ8DZLmK8VBs/7y1pAfH/2gyXCYX7XE1CYo7NnGmpyHyh204O?=
 =?us-ascii?Q?Ftk5+NNq5Fj1TNiNGGm9XYOgRop6718rSLqlDt6od4rt0tWb8FCpTQDhbbN4?=
 =?us-ascii?Q?2B8hLYWj8Ta0naWfl4lkA/oJePvkOaWkpILi+vU9M36QCddS+QpBzsVa2uNf?=
 =?us-ascii?Q?/uvHD4Zqs0ahOfXyUZ4SNBZ4AdpisJ+fFZ/CxhmNXeYU4g6FpTlIof1m2XzA?=
 =?us-ascii?Q?PB4EWNCXAkBmOgeW4qsbuApBLbaTXByYIl/2x++uqmpjQ1ond6akBOO4bsHs?=
 =?us-ascii?Q?vtDst8BoUlolefJXiO64tYUTFVkUILGVus9VOeYmpgJYAh+7tjj9XOviaQIH?=
 =?us-ascii?Q?jPuin0pqZ/QkZMeIpzbBCLkXP5wjSmBTBiD1u1oCngm4Ax3Xw8WEfd1R4PB5?=
 =?us-ascii?Q?ViZFllu7DJIxxMvS5rxjqNuRVpxTYzAionTpxVGc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e99e27-67ee-4c9b-82e0-08dc94bdea9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 02:24:18.5544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3TRBLyGaZbwaM2DAOStJRL82aH8xNUMu5uUWjxq4gMVW+KXvpZatB2TCc/Om09Xf6/RPMWQbfqLt7HNesWyNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7354
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, June 24, 2024 10:43 AM
>=20
> The comment for def_domain_type is outdated. Part of it is irrelevant.
> Furthermore, it could just be deleted since the
> iommu_ops::def_domain_type
> callback is properly documented in iommu.h, so individual implementations
> shouldn't need to repeat that. Remove it to avoid confusion.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
