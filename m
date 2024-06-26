Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2532DC142
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 06:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719384789; cv=fail; b=JCdcBb7DdwMZAdld1B75UPzjcgGNCVGgbh5VHuGuxPq1qsM7XC06zsox0eDStc6pTAxuSzoh+WQmz3OimNZUi12KEfZFrp8EnqDiOsdQ5EEfqQ6gMQTFi/OmO07eEIKvrxVxWE+w6ES1S0BRXIT5pEa2ZlUcA0bWdXamxWjxP2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719384789; c=relaxed/simple;
	bh=iO7NOp++SE6qbLM6+Dsow6+HbMdK0xjqK3BKSK7VFLE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iRkDVCXsmmDUw4epXSCH6vMs7lVhlqFz25FR/DBOAhKwT24FgE7iK07ySgSZ/MTfFecB45Uxw9P1cVtNMQxG+Xz9dCCd2EwNDfON5YajFpzn/sozPfscdu2u5jurJzyVg7OFO+kwJhcEoqZ+KNQUof6TfAq6MmmWnUaAbY3mJD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJ/Bkyqc; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJ/Bkyqc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719384788; x=1750920788;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iO7NOp++SE6qbLM6+Dsow6+HbMdK0xjqK3BKSK7VFLE=;
  b=kJ/BkyqcD8vN9TlsBjvjCIjyfZQO2QyHQ7vgykkTS+lTQZmyMB7uN0cw
   EFkHFDNpbrqyfz4M5xlhp6OqHGgClqfgR+RyDlldJ0lfaJ8wUlYwSAu5m
   881sG4cN0wX0oMEmub4OlYqQg484WOoXLRnH2nxMK+bDkcvkN0W8gVs+u
   ZXqnmrtuV7snRntH3Ak6xw5okc5aZaEUSSBTEKC+7HAUGhXOHuQOdSvuI
   sFSM4wtLw7j9KcTAY1wOLSDHZIHI1IjkgZ9ijx0KEW2p6oEQGP6BD1bvJ
   eV8A4g1evCB93vpqYIzkTe/CWQTDnJmeYmx94vQkWHvPPVGqiD901D4UH
   Q==;
X-CSE-ConnectionGUID: lbzMDPT2RA+EVs4YF5VPug==
X-CSE-MsgGUID: b3AHhL/FTHGOaa2UpGGbOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16188136"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="16188136"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 23:53:07 -0700
X-CSE-ConnectionGUID: OZsK50gXRn6I5O5T5aifNw==
X-CSE-MsgGUID: /49UfkdgTyih5UtY5CqVkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="43874861"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 23:53:08 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 23:53:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 23:53:06 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 23:53:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpGDbB+joSEfNsDk5rWywvEc6CnJt1riRFNcTHzLpn/OajPOkGke6i5hohxZqjZXvN+GVmC1NLjTWA0Fz/4SJcrNwb1vSgj1hIjR+sAFUv8798DLgDRPHK/biQf+TDpa9roYkYdTtadv3MvVrV6lDQVbx4u4AjmDWgnI6LOZSXyYxKSwKkfj4/MgwG5y+EemqR/72gb7wmR8wiWWAcejDSjCA4RBIcip9gOu+eLzF73Jbzx75G3wjstPdThajQ9Qm1b9r7Rr9+wP45ygPF1IuptkR/6KVSUUx7xF175M+nnKjxr53r+2lO5draRHg1oGstNlEp9eZxsfrdZio00xTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6nJ0w5oepVRYUxM2OQbqFQktXo/0Sl8Xj0JJIP2Zkw=;
 b=hUrXG3FfBgZiwypvnqPLzg9oizpIz1RhG6Iky6A2rh1Nf//PLeDING4HYm+jeVphcYXXYscZPOMJyBdhfLqpkfJEfF4wTK5cvn2ysX0PFHE4AQ8V4UAPV9dqo7vAjPfzHrNdv+/bztyJMVEIE2MS+c7D7cGapFXk+ViViAUzqBWU+OuR5+5kttlM0OQ0pfQmmtebBZGkbMzAaEKxNZOhE/Iy2c+R0ZpJH/SogBenFRJjtf3YqmvcL52F1rJm2U34G+1OW6Y0HqsDxWbJdj2tcRLCdqlg+RkfGGdnBfR3lYBOJUTixH+jcyV1pvaUIR6h4MvusVAxAkyJUQVfP1np1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV8PR11MB8748.namprd11.prod.outlook.com (2603:10b6:408:200::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 06:53:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 06:53:04 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iommu/vt-d: Refactor PCI PRI enabling/disabling callbacks
Thread-Topic: [PATCH] iommu/vt-d: Refactor PCI PRI enabling/disabling
 callbacks
Thread-Index: AQHat8ObQWY41YP24UCgm5nqr/HB3rHZuRFg
Date: Wed, 26 Jun 2024 06:53:04 +0000
Message-ID: <BN9PR11MB5276E8767AB63378C81130528CD62@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240606034019.42795-1-baolu.lu@linux.intel.com>
In-Reply-To: <20240606034019.42795-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV8PR11MB8748:EE_
x-ms-office365-filtering-correlation-id: c6680613-ccd7-40a4-eb3c-08dc95aca0bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|376012|1800799022|38070700016;
x-microsoft-antispam-message-info: =?us-ascii?Q?iS1Thq0QqcFixnOU/EmpXJyoTa4hn2e3/CcR2r3nBVeRp2/r1q9vnrtGcysp?=
 =?us-ascii?Q?hOfQge+3VuNxQOrWopepxCzTCqIZ08g3jg7nmv5HHyAUF2UmAs6SYsd6VKge?=
 =?us-ascii?Q?N4b0FfotzKclU+T6jACdE9FSL4aKWYu/VR0RPorMEWOHglb4d5U38vCCl9qQ?=
 =?us-ascii?Q?xYLQXO9TH+bIiGmPaCehw79Tv/LEmy9F9GFL8FtyZKkmELMmqDoiJh6N+8tR?=
 =?us-ascii?Q?NwdCkzFN9lf8EM3Kk3EtAdOV8o2ZS4i3QlTV+kaafJpTFw0uftIU9refxLJh?=
 =?us-ascii?Q?VhdV0JwNXNZ7whDMxULEAJ1EPD3hmOysYc5iDqUT1JsiJsQGnBtp44pXdHqH?=
 =?us-ascii?Q?csh17h/eqCXRANpxzbwi4g5peeb3WSrrJhVpVsT0jcC9E+lrUqiUJCY2iS+B?=
 =?us-ascii?Q?eU6IIC3OebsJaL8mpGMCUZ2Eg//t2yAijW69S4290XoCsAgEPpfDRPC9L5Lf?=
 =?us-ascii?Q?+lLIwmByl1g1yUAVJeYXeyl8g+coMRGCr2ArGZsM+BdbWBc82N5DLvXnFoPl?=
 =?us-ascii?Q?s7x8lpC+Gzwbj6HB1D00ERiUi85EXsaHtU2kkfjIQXVay7wndJFhQAdJ5b7F?=
 =?us-ascii?Q?mtYITOceCP1q3/TXew9Gk7vbRaU0+4mDhuu+KHe8WydPvXNTsIA3v5UA86AU?=
 =?us-ascii?Q?4kQRkwiCnXrnoP6WfKwa0UIIkgfJxG3WWSX6fn1S6iQACa8yhReUMsD3zIu5?=
 =?us-ascii?Q?dHg/Ae58a0t+JXSgBWW5SscqQapxZaAFE7vy1q91+3OnpbEmxEfvY7K3se5m?=
 =?us-ascii?Q?Wqy+qDgF4GYB9lDYjOtMmmLHvJfjFv0MPEHJKuda988qu/a9Vobve5+0DbHG?=
 =?us-ascii?Q?BxNuS66EapPWGW7dMAgs+qPPfr6ByAjkbzbrMD+95igJFowqTATe4HWKsoz7?=
 =?us-ascii?Q?JnNBzxb11O2fxY0PR8YKwvzMoWXHFVclMiwnHccxW1G3DtdKZaFCiRTcRvyJ?=
 =?us-ascii?Q?IU/3+j13U3KN/Ui5ASOXJm7VGRVhnT/QeLJX5Rix3AHUjc+wBdwhMrFp/Rs5?=
 =?us-ascii?Q?Svd/Q3/pEoM+md1RnZ6CWX60dKvWEqU4BPevGNtD3OOMlF0Ycr4W9ZW5UCS7?=
 =?us-ascii?Q?zZkHfxfPR81TNpXwDeZHRuDaerEk46n3uZwqKd6cHEGgDpeSDc8ljoh4rDPZ?=
 =?us-ascii?Q?xdAWd3MJBTAVP233Li0gc2VTymMvlJxvWUD6tG+lVuiuUn3+/2mP+Qgd4kQV?=
 =?us-ascii?Q?K+skAjc7kwsy314/XL+CW2ang1c0fcM6rn8kadG9/rkHyPsD3H4pqqJDkAZk?=
 =?us-ascii?Q?gZ3wTAII7TO96SLMuEGu9C48gnsTb44xASO1Zan44SQ5AFPV0qxMNOUlzSSK?=
 =?us-ascii?Q?nqVMC4Cw/oAAm4QZ9FpQ54pKinh/N09bVIPVCevE9eUqZl0XY+bPxFhyasZw?=
 =?us-ascii?Q?0n/DnJ4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XJhbG9ka8umOTFPM1JDTSJ2oWkjwe9yS88N9GJnnQ1KDrjzPfSu4ta4cBwS9?=
 =?us-ascii?Q?UIghX4cjvun4Z6CpUlFxVAerpCJk3BYDFtij39AJR5ZBP8sxrVT3ECHallAn?=
 =?us-ascii?Q?S7SGJd+f2DGUWy+vWmLCJrkZ3PWIBBC7gkySpgiue5mgI0/rJLUo9/cDlvvp?=
 =?us-ascii?Q?sQ8U2gkJB/lq76c9+PLXomwMKGTSYAqrIHQatOsAAaZajClkOOJRnf4lyKPt?=
 =?us-ascii?Q?HGFj9fMQaXZQWt1L3ZH32H4G5SFXI5v+FMoBEZfjlIh2cumsZh2rSuKCj30p?=
 =?us-ascii?Q?DLKpSwc86txSsrLBjL8rE44pe3wSAAWK1ZBmiSG3CZvDdlwqroWSWWMK9AaW?=
 =?us-ascii?Q?9xQ52XkODNTm5KMzqNvaMq3+w5DS0csuhV93355PP+WfRXJg+NfN+1/h/ZfK?=
 =?us-ascii?Q?ffxdqmY9AeaFysQcf184Y0XtMqN0Wafk2iMAcpqcqhf43DnBzLO3rfLQmtpT?=
 =?us-ascii?Q?pYs1dLQo2zhWb4YcErnwPkWBL70HubUPAR+xNGQc7kSm0Rh+3QxQ56EmkCGZ?=
 =?us-ascii?Q?34zGjN1fq+GsOmqLHWyeT3XP3z1VytDVCZD1Zbr34q+pjEK+WCG1Cg0n7VqF?=
 =?us-ascii?Q?JrteZ27fA8O355C3JVAAixdv6nd5GOumriVDtoKoTSvVdDP75fNqbbjg0+mo?=
 =?us-ascii?Q?l4AkEDJZC2CArJz8RtA/QsMibE5jaR088SA+uLCjKnMsTzamV31W9UlrvuhH?=
 =?us-ascii?Q?zhL0tq0CPf1ydly76VeANCz9Vp9M/FM+tma6KO8i8ynNg9wg1ep9AV96Hi09?=
 =?us-ascii?Q?egr1hFFBC4aHEzV3dA2sl++RPxSAHW/YvcA9nmowhjYkV4/rqwhaIIt2HfDE?=
 =?us-ascii?Q?Z827Yj0ff4BJp+WfOYBk+eYs1Ea3JAtQQeg/yjYyEc013Bfae/dufWEAZOwE?=
 =?us-ascii?Q?RDzT4GlHwCU6J9NH9ALveX46tX9VfU9TZellupfbvhwpOc8kbK89SGtRhz/p?=
 =?us-ascii?Q?H4arEJdEA4IYNXg/f9IJfVmMKClXWTnYecRtCfmx8+wM6bRCL7LjpGjp/Th/?=
 =?us-ascii?Q?tQZ0CpqNFJRW4+BJjXXMS5zAijo5JUqzHvpezAtpm4W9n25awQjM3pg2ZQ81?=
 =?us-ascii?Q?mW6SnhH96ErVkgSxoYYPzH+EkvM9oi/MFuWqElC06MxbIF5hbbkbzBZwJ+QB?=
 =?us-ascii?Q?S7OSNfh2cS7yA6r3YYl9pXELY0n0v8jQ1AMCQoRSkxytsowLI3IIDEC6u5SK?=
 =?us-ascii?Q?uD4SFQlW2Pp73jU0cFbLANoIdxcKiLMorb7WMkgRQHYflvgij0Fyk3ZZ8y/h?=
 =?us-ascii?Q?Gz3fvkmGEBlRe2IJGsULIfTX1leTQELGVfjTgOVENse2b4IrpQuZLxNR8PD2?=
 =?us-ascii?Q?vYyUvGwImRAphN+9K5OWBwSvMWCc9VM4StFoz/VOBp7nUXnPqQ2RsaFlI/i9?=
 =?us-ascii?Q?xBLE+S/SmFYLJLM9XfBmuiLQ8GpHFyUN8gxBnMRW0xSgNl4UjXXG3CsgBz1D?=
 =?us-ascii?Q?6yF3XEm38EE2/jvBHBEV6M3+/zMOl3DPSy7scqJLTqpa6i7THYWKNOhRUIBf?=
 =?us-ascii?Q?fyxcFtuZI169pnOdWCgoTSAYUjLRU3etrR0NBEFcnYL9a85jlg/8Ij1Wre7q?=
 =?us-ascii?Q?mzaD9gInCsmhzQg63hY2R1CdNZc9+Z72wDyElJpB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c6680613-ccd7-40a4-eb3c-08dc95aca0bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 06:53:04.3204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ndb6uM3yZ0tbhJe+zeYztTGMeM4gjsk10nAoAII+2HTKcoJQdKZPsUr784xoqdw5M3c4MkAtwQlO+sHd50kxUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8748
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, June 6, 2024 11:40 AM
>=20
> +/*
> + * Invalidate the caches for a present-to-present change in a context
> + * table entry according to the Spec 6.5.3.3 (Guidance to Software for
> + * Invalidations).
> + *
> + * Since context entry is not encoded by domain-id when operating in
> + * scalable-mode (refer Section 6.2.1), this performs coarser
> + * invalidation than the domain-selective granularity requested.
> + */
> +static void invalidate_present_context_change(struct device_domain_info
> *info)
> +{
> +	struct intel_iommu *iommu =3D info->iommu;
> +
> +	iommu->flush.flush_context(iommu, 0, 0, 0,
> DMA_CCMD_GLOBAL_INVL);
> +	if (sm_supported(iommu))
> +		qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
> +	iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
> +	__iommu_flush_dev_iotlb(info, 0, MAX_AGAW_PFN_WIDTH);
> +}
> +

this invalidates the entire cache/iotlb for all devices behind this
iommu just due to a PRI enable/disable operation on a single
device.

No that's way too much. If there is a burden to identify all active
DIDs used by this device then pay it and penalize only that device.

btw in concept PRI will not be enabled/disabled when there are
PASIDs of this device being actively attached. So at this point
there should only be RID with attached domain then we only
need to find that DID out and use it to invalidate related caches.
