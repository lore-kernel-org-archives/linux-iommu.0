Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D41C82E6
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979930; cv=fail; b=PNmsUYtN4bIhseBU3DSebvMt7hJD5A7PNRJGcr0IaCeTttS8N5MlZ7EPYlAS4mxULFuS6wa+at8mo9N4Comu14EZ/K7CCmVK8jU6s6GvSkq3yh8wsRQ5f4aecAcxDLa+S1G+u+mlEiSzCbXEC2PCVHkhtqGtL8lXfYeoHkR4B+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979930; c=relaxed/simple;
	bh=Tq1OCFm/+bl6OZO2tWtmjPoU5phW7rxqY9ENjqm14Y0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rZ6RnzMHAPhKySxdA9PVDXJ1ZNsc3g4RKgyPOHASZJhxa84dJuUT3TkeeujhgjTLgTd8hDlQIk4gti82Z5FZABcoP8v4l0cdyIAM7Q4dO5KYzmPXzuaf8MdfU/3G77RF1CqwP2Xj583P0okEr13lWD1DG/DumE/6/rG+dlMUGF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RbsP8ru4; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RbsP8ru4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728979929; x=1760515929;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tq1OCFm/+bl6OZO2tWtmjPoU5phW7rxqY9ENjqm14Y0=;
  b=RbsP8ru48weWySsmy02jxB9/7IbGJHmh4ioDMMeMVeVYka9lJYxs9dO4
   PEWvbGmyNIhvfEEadpab9RgBrL5Eyv/vD++jNg+x+USs2xF2yZ1zanVgb
   4Vz9TPCqcL8Q8emqL68JuBc/1N1HXKW3kO+5F/jY+l7HtIVFztvlvP/Cc
   rD95x2LL4NlOnoC/qJgnxwuox1/eevOQCLduQBIEqxabTDnZ4gTULr8/h
   8h8tqs0cvp9xdOUXNibHP4OqGg0m9IW21eHOPnGBqXr9E9IoVyGlCnCH/
   Hk/Lw7WHxuyzpe9lrEXDTM9ObxjPfhgTYXLo3gIzXai92Fhc9dRizbPBh
   Q==;
X-CSE-ConnectionGUID: fgPUewVmRJehRMyb9XdIMw==
X-CSE-MsgGUID: CZChuIyLSNeyRO2VMzZoNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32050701"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32050701"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 01:12:08 -0700
X-CSE-ConnectionGUID: 2JFcmn7ISMKiSs4JFEBxtQ==
X-CSE-MsgGUID: TdDvqBpyRHCzM6pmOBxCAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="78253874"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 01:12:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 01:12:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 01:12:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 01:12:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 01:12:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9vnI24A3VRKrYqomS0wwoUoPDsN85d2c5c1sIUlmNYslTP1syJ0q97GDfOvZFNaHcB07lTwQo2ssQSLzEF2XHIWC0CtyJUW0A9ufuKmKgmasPiyM6XtWWgZ4OcYR5nElhYP/J1zYoKfjLK4J1o9ave+Y0aAhNOssCv6AKqCiTMPBZZ329PbVVi/UWM+mHLlAvIgpnZ1/2bTRuUE0bWcFe2P4Wrkxr6hUd4tPtFm0ANFkC9PAPup3gekDrM49KF2Mk9Mhko/gWb9EPc0VyWim969APHaZDmDbpKq6ogdlkhlPNepFdpoNK0dK5Rant4u3TtzBY7dI6WpIr0+jyNwiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tq1OCFm/+bl6OZO2tWtmjPoU5phW7rxqY9ENjqm14Y0=;
 b=siRaz6GNinlSju+7CRncAbQxguz2kUY/A5iCRn1EvEgrpXDX3IuB03ynihJABTFFS3z/+8yy7/NhLKpZP5t8m741LEjBJ4BVENnDeJD39NZiiXdgAxJOfIQyrm+yfmGzYw8VlSWrOHIifdB6hDyjPG2Gni9NWy5D5FQWHlPWNLm/6SlaVokbUIpyELiSqygSMBXsPRRN04SNXUHKq6n++HE8WpSfgfsYwT09HiUr7n7Fr/yGhmZwjyz2aly6ceTQ1xBsTk2KG89Y118PvTOpSLaATEXRqOwVeAuxSlzv2pJbr9MPLiDJ/AJzBEzDoZW/8JUNKJ8nn1n/c3fwucSSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB7117.namprd11.prod.outlook.com (2603:10b6:510:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Tue, 15 Oct
 2024 08:12:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 08:12:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>
Subject: RE: [PATCH v2 1/8] iommu: Refactor __iommu_domain_alloc()
Thread-Topic: [PATCH v2 1/8] iommu: Refactor __iommu_domain_alloc()
Thread-Index: AQHbBDQylM6nIOpIWEyj2ZY/IYoWTbKHq0IQ
Date: Tue, 15 Oct 2024 08:12:05 +0000
Message-ID: <BN9PR11MB52762AC7C4E94759120721CA8C452@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-2-vasant.hegde@amd.com>
In-Reply-To: <20240911101911.6269-2-vasant.hegde@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB7117:EE_
x-ms-office365-filtering-correlation-id: 8104e338-6b15-4c58-982e-08dcecf10e57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?i4+bqgPhKKrubSg2iE0MSSZ64gYHw20jDasuyTmMvvqn5tBKqfWsJq87zlcD?=
 =?us-ascii?Q?6/RO3aJsaV7WgZTiE6W00LH641gZI6MpLnGiFozVBE2vhBycd/sWjQvj5Urv?=
 =?us-ascii?Q?ci5EFN2TsfARyEAOUB4GtckFO6k36rChRYbac9Xsf+hv3nSTvCVhKa3rGfuq?=
 =?us-ascii?Q?zCGtFu+mnm+rS8cyF85pIKzsSKmYoi/vehiNLaHtYVLZVEbDK2jdcDS0d+WS?=
 =?us-ascii?Q?fSKpfxe94PpXLMqj/9tXqjgUwW6xRr/tQg9MBkc8nl3rlYy3/rF0Zc+nET/Q?=
 =?us-ascii?Q?xbTGz89rTVjh1Ga3QCvIJX8IyVV0lW08xjj1iO6iZHtBo4MqPeREG3Duiv1r?=
 =?us-ascii?Q?73R/rKMxX/GaPTO6kRJGOUwlr6xMxgBTz50R38ozCQdMAycKSiVlfs1mCe62?=
 =?us-ascii?Q?5nwImOS8Cj/LK/+Mr927hYzqToSIfvKYxHhK1KxIUioxhKwg+L8Lv2slnQw+?=
 =?us-ascii?Q?I/d3inVmrKHdU4evJrMiU3iyXfO+64ot64JrO0xy9Un4Jip3GDkhNqeS6aF+?=
 =?us-ascii?Q?0daBCiKhhNGz8m2+EqaHkpnS+HIBhqjuKwtaa5nzrZRSpeXGn3beyWVV6a0a?=
 =?us-ascii?Q?5ciLVk9qP+PMy8wTA2z2Wn47WmmtyVMtVP0SSkrJKyGwn0pY/nnSKmzDuCSi?=
 =?us-ascii?Q?Ma/khIaTSFvRi/qd+uOg6qNQjtPONzjuKw+7OHLbPTHtE/AG2fMig9f63yib?=
 =?us-ascii?Q?iSI03C8XuEQeZTZKJtJ9UgUP3B4Fv6irjkx63FUlnMNnc0gD9/658p+jdkrD?=
 =?us-ascii?Q?tcmjHqZSLMIUdDOHjnHezkbXiyWOFhcOxtgU1OZfgbxzor10/ZaoH+FMuz20?=
 =?us-ascii?Q?9nT2ShwAWmDI7gy7asbKIoNBHhQwxT3bhPL3eylE9lZk7/dM6L3lbHupAB1W?=
 =?us-ascii?Q?MIcujQl7YMp2Wgst4/9c7YupzfO6NTatdJjg2M8/RnqNr+OqDlkJH5U63H72?=
 =?us-ascii?Q?meP8ozvLgb+BPVZLbEAByoBuda3PHNDdMjskJ459o2YySOUczpcGB13ZEkyc?=
 =?us-ascii?Q?DM4V4eZH5++m2cFIggY8RHUQhIz50jD7dTFnI13WR6T9iB/J6mpXupuDS38G?=
 =?us-ascii?Q?K9gjKLLWfU1Vm7sbGk2Ua6/EDfWHENj8/Nw9Fo4wU5P1wJE2Iio/EhT3rlEd?=
 =?us-ascii?Q?KsmoYHfNgzlWBtgFsme2RZsaXho3dA8Uq6BkucIwdwi9JR+o++nS+5mhHih3?=
 =?us-ascii?Q?rdau6tKA2ZRiCoZ32ZqoP7wJUWF5IKBQHUI8GSGNjp/8jzHJpEMeVIW6piHe?=
 =?us-ascii?Q?Z18HLSYNXAbbnGDljKUmINrJdrSLjnnQqs8VNwLYz+QBznCsDiFdsHpJit7L?=
 =?us-ascii?Q?GlJlfDAlYsZ+ibtOaWsfAiKSwdQL7eHMdWjaQ9LkuCDFQg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nIJuovBQnpB50R8JY2y9NK5IYb9jgK8SKE01G+9VqmMxq4jiAft12dapVu9t?=
 =?us-ascii?Q?Nf5zQcLDnzlh7DBWnfBS74iPsxzIib2fqaJb7s3tMnSUCTfqbA0Ew0z++JM7?=
 =?us-ascii?Q?6EK12oZn6875zlBb3bEt/sBJykhs/u8+A6E3I3XzC3I06PGN81827KkeNg9b?=
 =?us-ascii?Q?TosDSWOTfWlvhQi3ybGlIhgFl7d5XRHUQZodsxG9b3heOSse8Z75KAHOHZ/Q?=
 =?us-ascii?Q?GkBfsZ1cVR8Pj21CwuWkKHCmQfz4dwpZMLr+rd71ESJ1VHXdzR/HaKFhTwP9?=
 =?us-ascii?Q?rHravC2XPTBPzJrO0pqpHEpUHsp4Ft55ScLaUnv+xnyt6EZ+4BBscwTjd9c5?=
 =?us-ascii?Q?KY+yOtGprH9DVeW08WTL/EzlGQCe66Rj+Cg2xk2YWZRLyRr2CLr9rixiWsKD?=
 =?us-ascii?Q?s4elEbk1fzIHYNbnZMlr8YACnbfPUkHujJza2/NbzKheSoHy7n+7IRTvfd3c?=
 =?us-ascii?Q?s0eOse8jRZM+JWT51Ow/HoK02mlIAvkJvTdUls8VpQI6VgrTTQXKJ7NdlWbI?=
 =?us-ascii?Q?/4yXLUNEEc4y52pIuQbPENyIygDfF7UMwHwfO8XdwZfVb3lpL/ibw+UIJAGC?=
 =?us-ascii?Q?qv678NWVvN/gxWANPuL0safqiUnOi/2SKJSEA83ix9fpjU3Jqdm9m3O24sYA?=
 =?us-ascii?Q?Gn9OCKEnGoJQThpPULuOXXhY1FS8gQC+90KuXLdhZ7oVB3D1MNIZlL2RthwR?=
 =?us-ascii?Q?ZheOv3WrJ5Ky+ORReh1YX6jDvCm5EOC9DkayB2Ejmy79bLNLI64rus/9Gh2b?=
 =?us-ascii?Q?OwR8wYWJU+ELAlCMoqLkRn3mRc16GEk6X/6eMaCDpzkj4/xhmrvTHd35//d+?=
 =?us-ascii?Q?qQRF6BiZjS1EjYixfFIw8AfbZJTbpClmDWHUf8N4s6IM/pXAZAR4SgwABnpy?=
 =?us-ascii?Q?T0IBoY8fkqq12LJshMfnAhrEG8bnfLOZTJLzQw4H5UHcajf3zcoQU2oiLcct?=
 =?us-ascii?Q?EaxEWauXNPu+dxPu1B6zsnBP3RlFh2IRRlTB7OA6WBJCesES0sHZpVA2z6F+?=
 =?us-ascii?Q?fbWBoNutxwUyMtItkZBfmDhHhDbVTkliL7n1cksC23QaLI5vlkhjaHMrbSJ/?=
 =?us-ascii?Q?8awSb4A0HaySot6b/MuxVtmclb4/NzthQyoaqrT8Y2/rTvwy1oi7y9lP25xf?=
 =?us-ascii?Q?YE4HBR9nDdcJI9vuObi8tBbqPh8REu2D935xBmi4iMMwUPc4clwf93UKvJ8J?=
 =?us-ascii?Q?arzdOjTNPvJkYvnjLK8pSBtUdIF1ajTnSEP2lfl3OBQYqECc7OjAbWE5WQCl?=
 =?us-ascii?Q?9l4Ju4oiqbFzBPfLKavIGBlepdgNIEFiZ7u4N0T7eFZIRqcDFcFYZ5QpT3NR?=
 =?us-ascii?Q?g9Kk/xd0PV9kBGbn3YHXa1a97Hcpc4wQJ8UH0iDz/p6E2t6fJI6r7P2c33Tx?=
 =?us-ascii?Q?1pIE5bmJCxQUW0zd0kqVKqjuVRzAxqALdTNw+vScqOOQSDhA6/f3eMVSVA5F?=
 =?us-ascii?Q?nM2C4Hlpreei+4Me3RwNpBxCFa61zKesCzLvdkYRFm0vfav0ddVui4vLgThX?=
 =?us-ascii?Q?eLZU1NVmXq4UEnPPWwvAYyVbWMvHQfxIfoGIvzTDU7TyQuEzAxOhohn0iBTQ?=
 =?us-ascii?Q?UJGIijpU72x1U9SL3RBJhuI/2DtbN8KYFppyedht?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8104e338-6b15-4c58-982e-08dcecf10e57
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 08:12:05.1496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OsWoVmF7/HIOu+jIEydqZCIF04WoqSwof7NIUwCssQty7VybARotJ8JIVX4xdgQgyBtR6OovcEPD908HJ0Xv0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7117
X-OriginatorOrg: intel.com

> From: Vasant Hegde <vasant.hegde@amd.com>
> Sent: Wednesday, September 11, 2024 6:19 PM
>=20
> From: Jason Gunthorpe <jgg@ziepe.ca>
>=20
> Following patch will introduce iommu_paging_domain_alloc_flags() API.
> Hence move domain init code to separate function so that it can be
> resued.
>=20
> Also move iommu_get_dma_cookie() setup iommu_setup_default_domain()

s/setup/to/

> as
> its required in DMA API mode only.

s/its/it's/

>=20
> Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
> [Split the patch and added description - Vasant]
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
