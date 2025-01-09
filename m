Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2D5214A61
	for <iommu@lists.linux.dev>; Thu,  9 Jan 2025 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736408708; cv=fail; b=iWnqBfCXZjKonSOlHaL1eEaTl3y1ll7KLhQy5zbJPLQpIrGluv1hpQlSFiKfRoAKRZ+16APvvV3zuSAHqh6KxSs4n5LGlKG8Xd9xsd/FfjqL8SfF1+2VBFHU/I/dCmVaKtW0wacsxtngXl2/Upr8i1oLgZQYHxQev/J9kMha39M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736408708; c=relaxed/simple;
	bh=2tt5YzUTmiR9Z5nqoCFCZyHdUwzsmgxiYiD+qsyBvio=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FO9Se/1F0hJZr1Z/Zmnm7gvptFtdL+VHUCpL7rR+2Nrq2tXbLjsosuW2mJ4OgmCJvPMFGsBWp9mlYTYptSngdU27ZAma/HsiNNyEzFClxd7Jy6d7p9Vao85zXSGgLQi0u28QPr23usapS6fn5wgJJB2kpY9vPFlAWgzz+Kxsj1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+pWdrVS; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+pWdrVS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736408707; x=1767944707;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2tt5YzUTmiR9Z5nqoCFCZyHdUwzsmgxiYiD+qsyBvio=;
  b=H+pWdrVSTbya6Pf34urX/az7MYIdjy7PSOBIEFj3uNJmgZmGtWULR5mi
   1jPIXFwfmBQQKNG8kAiHF/HmVzJhOmEvM8UFFPmEj2E6nKUZRV4pLXxN5
   24ICsYQBq58B4bvbmoLY2mkVY7Ns1Aklc9ujCkC4apPlPs0cL3fNUOVDl
   NBh3K67W5ZMSvzPhkilpoCSU2yUCIQe9vYWMh6jq3n9BIecCMLo/Z2pxL
   uH+D0fMW191mFLlCHirRaLBgSEsCAy79HDjDUDpmoQ6VQSpuRa9CBejWs
   s1Cqtcm2qCAsxd/5Uc/5gCrFMLO4QHeOMavRdczc00EK7sglmvIimSuYC
   A==;
X-CSE-ConnectionGUID: 5wPKChviQVyH2CV65U8cyQ==
X-CSE-MsgGUID: 3ZmFUzmQSkGa2u4yRYH80A==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="35943388"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="35943388"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 23:45:05 -0800
X-CSE-ConnectionGUID: BRKVUyAJTlSFhv2cijAa/A==
X-CSE-MsgGUID: YyZnwD2DTK2YVJbqSNWR6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107370921"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2025 23:45:05 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 8 Jan 2025 23:45:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 8 Jan 2025 23:45:04 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 8 Jan 2025 23:45:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKV02PuJsdxIJVwlW6Cghept9pm760YjPiIjWcWzERo3JshzuAqS02x3oUIOdEFzG3oh3awgCeANlego1LpOLF1oz630/6IbuImSDICVuTnjicM5k7TnAQClUaKnqpdV0Syh6Le4JF6Il6LcZI0OXk8/Gfqi8p+Bc3eY51FkCgOszmr+dUrryoOTQNKQZuIjmE73HE30YOJKaK2LQTzwav4rDg68aZw5F2s4lZK6d7PxFAFah022wNlqI+6+7nrYkRgetnQLRCmlearx9uneC9zJ986hr01hLUDySwJyG0F2JypXwOK7RI+I2Tcvi4DYoopT2RGYsZ1247fNbDEDtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8od8TMw1DTrZQ0aBs/VKfB+1F2VUF5QvRB9PKqLa5tw=;
 b=oiXH9nJU56IfXnyvb0/fYND9DACLEFa1CMw2I8G6ZyRWhMElWbm5VX3EQzInbJ380PH+PSpVx1GYBRSannKaSOWHaEFttHldsA1eE9cnX9TeE6ZFmsqvDEQ096Z+9Hswo7K0l0mLtASqlIZkhegRj3/SIRm/jMxM6euspejgq4EQrpw5uz9unSjCtQwXn0C97xFYasljrDoJuyU2DN/4LTWuLkhTylOJ/MCpci2xT6GzJT+WuW7eBS7RkykFCSGdl5RfSTgQ1TFD/YnB68e6oEPLjJy/VfVBwaWVGxeBRK8wP5D+M++WEjGR6QwGO03NU8sNM0RHj4duAxQIbehBiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV2PR11MB5974.namprd11.prod.outlook.com (2603:10b6:408:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Thu, 9 Jan
 2025 07:44:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 07:44:58 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v6 04/14] iommufd: Always pass iommu_attach_handle to
 iommu core
Thread-Topic: [PATCH v6 04/14] iommufd: Always pass iommu_attach_handle to
 iommu core
Thread-Index: AQHbUhnQzrskwt3h80u6mDvwGBt79bMOL4Rg
Date: Thu, 9 Jan 2025 07:44:58 +0000
Message-ID: <BN9PR11MB5276F2830324D346D180D3068C132@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-5-yi.l.liu@intel.com>
In-Reply-To: <20241219132746.16193-5-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV2PR11MB5974:EE_
x-ms-office365-filtering-correlation-id: 54241de7-700d-49b0-a265-08dd30818482
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ElEBbTOjw4BnUBVDGkO18wF6MTdLk1Y40aBourNpyRh6nVlFJCIkwborbDf6?=
 =?us-ascii?Q?FJ6vCeZBWR0BJyNtPKR7ycj7FfXz4EiUTP0g8CO0yD2fllx84Ee7Wqp0mv0N?=
 =?us-ascii?Q?zlBCNr3utJz7LvJ17AdZ8qjCgGCYyENEae2UuJS5u8f2e6I7xNychnAgcRmj?=
 =?us-ascii?Q?jAc8Eb4gwBRsHC3K6wnLzb11JyN80Akbsbfy8vqVIV/lvdUNdQTs1mX5s+aY?=
 =?us-ascii?Q?tPplEURGPYuSGyWVXxJphtDljXXhhsDmFrWO4jgEkUYGhj9XXmqQfkn87O6Y?=
 =?us-ascii?Q?irKrk9KiOlB7Z3suuslMECYK0knkau88TGd26oJAk6Sb3RjzaQ++PXaMT4Dy?=
 =?us-ascii?Q?xk1eezwWvCdiXbKdWmYVG/VRqGj8WTo1HcHL44lLPEsm1Lg7/zSm8rOCjhLe?=
 =?us-ascii?Q?S8zi5DmHCTblfMI5g0MQB0NnHC6RKGPUeZdlzj8aewkEGRfb9ZVY9G+5hjVk?=
 =?us-ascii?Q?pjorjtKXVI5mIaF2xkcxy4NRiwa0D2flgIcJOf7Ts67wrYxm6QuhcS09dag/?=
 =?us-ascii?Q?ONajrzc+Pk5NGV79KsPIgfeAIAug3FqshMGskP5Ud75lDBgyfF6s4TmxCQU7?=
 =?us-ascii?Q?2ejHVna5lHlGApwFl3Irynb8nUn39cMci5LF/hEJOUyLcjXpqXtRrqiWvqg9?=
 =?us-ascii?Q?+lO8FePR6vwxjsGsd9aE7oDqyCyM0RcGQX0ranCez7YAoTiu+x5E7EKwxWai?=
 =?us-ascii?Q?ZmBwdbw9DANa3edI2Ab1s8c14mX+zrS/CJokf1hHPGoToUQx9dvZOczDNg+4?=
 =?us-ascii?Q?66iiWIFnt9y0uTheP48b2WV675snHGtwbUX8d0gwaf38aUBdzH/BhtHCGoZ+?=
 =?us-ascii?Q?hF0x4X/rP+AC5z3eQcyi+OntX0Hf8YomicjkeyuF8eqTuWf+QbiENOYrj+r0?=
 =?us-ascii?Q?gEbqy2k0k0sn0PZ/8yhj5q7r2nuY3CYRneOo+cgGmSTRygeUnB+uH0YDreYI?=
 =?us-ascii?Q?tn8FIaveTglpMs9jA/GoHvSdsOL9rlf+mO9c4QjNk1ersxmSPG7gE+GXbv5z?=
 =?us-ascii?Q?P7HPEpsABYBvPm6wmbseMnzstE7U/FhOw67SrIyVF1yBpw5x41ZOD8JEF4gN?=
 =?us-ascii?Q?pFI83ws3vdN11wX9LRanhhg/57DTmf8N3GM04j6vZEDsQQ3pkgKAwRNbNg2A?=
 =?us-ascii?Q?mCt95zBri2UtG0dB+QTjPqPFKn5Gk+j+M6UXprHmWEFqzQezttK1ZvkrurgJ?=
 =?us-ascii?Q?a1POZMyB/10iRCJiX+CGu0MEAFJ6hyWzwY+vtVz84/DjLbyBNJ4+/NVCZxgL?=
 =?us-ascii?Q?ZH/XOTae6NHGeDFbxPE234VNjlAHZQZvBUfOqIzKMKz4lNfaMXFix1sqNRUr?=
 =?us-ascii?Q?AilVLzRzKyYA+BXw4Q2wtev+RFey38PgJb8KsLgidnFeDDZqPKTGOOsqkERh?=
 =?us-ascii?Q?aTrJPZnyNcm9NWcNRLGdXaxWXOSfTpA4VW+GMaPJymBoZqf3b51yVO4G4d6Y?=
 =?us-ascii?Q?BCTtLp7Cv9GMWYwjFiiNQ512vqb8Ew85?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lfwgxaSmVQ0ITm75tIBREQpsuXnkBpnoqqAa3Rp3L72ca5ytv+Lu2urFLZOe?=
 =?us-ascii?Q?2af56iozpKjI6wGThZZMznDEcyPrZTgRfrLVdENt2jzzW8JpjdjbrVCGRmKS?=
 =?us-ascii?Q?2OfeZ6Qt1DIYgmgSM8eAIjNnKCeCmOzGKxIj304HOlxmKSUWpqO5ufrz8faE?=
 =?us-ascii?Q?id8XrETtXESXIs+Rkc2awuIMZMZa3uP2d4vKsPYQTuvCwjNcFzjl2AmM83vl?=
 =?us-ascii?Q?uU5rCOTJVapErR+pXMyQEWpFCzkkXJmBCb+QVuQPmSSl93spSOTre/TNn84R?=
 =?us-ascii?Q?0BwE+QWAJRSriaZkHC/ZV5BHZq7r9n6qudDKRQ72haEUhdpvKLCZOFnnCZaa?=
 =?us-ascii?Q?Q3K4l5kZ+wJjnLzaMtoyYIGVE1ESKnc4oB9qP/7yA2xwygxMEh3ZAIRTaDEa?=
 =?us-ascii?Q?NifHzoERmB9jw7ujLc9Q+Pe2JqCMwLm6K1mI2+h5XZvsdl/tzZFH+L9WFIz2?=
 =?us-ascii?Q?KARGbVoXppPqFLMcg+8ix1CzWf4uSPqeyg6KYSOZgVuT1xFvTWyHMSXTq9qS?=
 =?us-ascii?Q?d+sMS3HXmuPyQSQuNDxPoJXBMqMPy2Dbng4WpNCgtH1dCMUtDyOSlvv7wngp?=
 =?us-ascii?Q?p/7UEVrDNsgT5teb/KOgN7hGkT66OXRVtUPtDnnW5DlnnRU28bZoc1okO4gO?=
 =?us-ascii?Q?lmBcRPWzI4HaqDIH6/GuHYNoS/xT3VdjzoU6OPiVS2v9Di7Ku45bm8bSYXwl?=
 =?us-ascii?Q?Lj1iKPGMTkGLB9c9prlMU7030xxtyl+bon6oum0djECzVIB6uyUWxVkApj2I?=
 =?us-ascii?Q?XjkBIjGShj4yU5AaC2qULCg64JqHnHIkCRBcqAoQ/1EOpFM5u4IusJ4javM/?=
 =?us-ascii?Q?MJOfm8kcoLjeX8yWyGFcQruWh9xu/Bvsw5E9+sSy8d8x/TuPDtbOnzcplrPh?=
 =?us-ascii?Q?aJVgzbkCMHd4xsoi6sY/3usMBbv99DeElbAQt72luI7SIFl4gVdssUNu32eX?=
 =?us-ascii?Q?HOboPyDg6S+E15YkMwrP15KscM9vAwHNHLQyfmR6RxJRhybGasK8sIp7y8AQ?=
 =?us-ascii?Q?XI4ml9ob0uJORrNBK76r0hET3gSy9Fox6zmLdfbYOeZgJJtRt34cqIBg9mFr?=
 =?us-ascii?Q?hN6P4Rx2P1XoPa9RHYCXz68QTfFhEcsVYWQjWc6zsekUsy2vxNlsy/B30yCM?=
 =?us-ascii?Q?MHBB32V+7dZrGeV+AWHwhaXJuY4EkXKmykEtWi8YZtb1kfixNAI58aIWhsWe?=
 =?us-ascii?Q?pUYsGRAFT/PH7cvmaVafTG8j9QzsHXG8XOPUjkNgp7gXWlj5YoULh3janztu?=
 =?us-ascii?Q?iuMcJZKoXyhfoe73yGexxdH0EhIanf9Mt3AHiBLyxev/KfgT1RSrL0bwT3Gg?=
 =?us-ascii?Q?Jg5ztBCWyQIDnapNmc3N6klaHqYSMMHE0v2gOpqcAJLmhu3tF9C9RSZGDk5R?=
 =?us-ascii?Q?JByQhujMKmgt/gYFzetTFqNZaxkoL27wNwrbOb36iyIa1sqxTSRN3t2TUAK3?=
 =?us-ascii?Q?DFho8/OHRO+MfdhouC8lt5ARUHGxywDgJzfsQXAGxVBQg5Nbi+BL5TfNsZaL?=
 =?us-ascii?Q?36oFmkJDeHnNucyQLrxDjLVrqniVIb5N+wgIFZmUQP4Ir7/cVsO7I+RZUU1d?=
 =?us-ascii?Q?FCJGMJ4OeiacezfNdwepkx2BFYydO/qttoHFMQuV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 54241de7-700d-49b0-a265-08dd30818482
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 07:44:58.8068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LLnm56d9+86IIa5QwYpamFvV8E+ar1BWnv+Bq1oemm935JOcNn68Qij+TqKC7da4janhJwLF1G2XkxptcSIMvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5974
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 19, 2024 9:28 PM
>=20
>  static inline int iommufd_hwpt_replace_device(struct iommufd_device *ide=
v,
>  					      struct iommufd_hw_pagetable
> *hwpt,
>  					      struct iommufd_hw_pagetable
> *old)
>  {
> +	struct iommufd_attach_handle *curr;
> +	int ret;
> +
>  	if (old->fault || hwpt->fault)
>  		return iommufd_fault_domain_replace_dev(idev, hwpt, old);
>=20
> -	return iommu_group_replace_domain(idev->igroup->group, hwpt-
> >domain);
> +	curr =3D iommufd_device_get_attach_handle(idev);
> +
> +	ret =3D iommufd_dev_replace_handle(idev, hwpt, old);
> +	if (ret)
> +		return ret;
> +
> +	kfree(curr);
> +	return 0;
>  }
>=20

It's not balanced to have handle freed in different locations (one in
Fault domain specific handler and the other here).

It sounds clearer to remove the fault domain specific helper and have
everything together in this function when you move it to a C file.
