Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4001FAC37
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075205; cv=fail; b=QfY7u5efedaBUf6ZYC1heajWoc3i+qkW26+oPSXhsUC6P+Tn+LxPr2hdQFez3zEHJfFSwUxYLrn7tLGzU7qGtjbJ+Zaea3t6+CDHaqeBGD56glfNdrP/JGSBn9q14AxSGm6nk/MdnQ+oas+zTGQKebw1DANbI1sDEviBN8Q7q4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075205; c=relaxed/simple;
	bh=NwWTFBvEgs9MhKTfDoqjxl6oxU7fLhGFXiyyyQcUmN0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m5UNncg/NZjpjF0EHL7u2sQ3YemohCfvlmYVi2x2+f7tEQURgDkWYOjlFsjsUNFuKDg2fZmAG1uONWp7v26zCfhKziwnLnXsePRx47MMeiFpVFJNb+duae9OoRa0/R6pnrbwnTAyBiV+IqmCTsCceSFtBY7CrwtzZowwtSM2i5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPWaHbr+; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPWaHbr+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741075204; x=1772611204;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NwWTFBvEgs9MhKTfDoqjxl6oxU7fLhGFXiyyyQcUmN0=;
  b=GPWaHbr+9VTrkm7bJmiGHSAS2xz1ldilCQPuDjrxhBDgMw02z94OjyWl
   MnrQny3bTa95FcA6hh42v3niGtnNdJmIbje1XGCHVwfbfSVsKM6PSCDbQ
   BtmtfXOAupThvKga+icse5aN47ft8SpPdl7BH1nA12pP5aP7cuOAH8AaS
   +ZYDr2OCmpOwxoj85QoZznj7CqI6Ylik73dUdVHdZ95/bXKp7Dc09yg2T
   91XhbK2NhPilI1336j/MREC5HPrhjXKGdVLmzp4NMVfBtsfd9rKKhfL56
   BjPdABDtruBJ6KYSRLfrhREECdf6aiHehfUIKl2y+d9za+vUfNc+Sq5zN
   Q==;
X-CSE-ConnectionGUID: OpPyuJoqQayn8cK0qAQarw==
X-CSE-MsgGUID: Fvk6p5kBSCayVRvkT9J+2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41888779"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41888779"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:00:03 -0800
X-CSE-ConnectionGUID: tJZt4HcgT+2z3AVPUDLq2Q==
X-CSE-MsgGUID: AnKU8bkhRCi8ZUMLIeXyUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118087501"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:00:02 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 00:00:01 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 00:00:01 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 00:00:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFWqMC/l4Dyzktq+hT9vcy/HITdUAMXa6gDklQuu/XX6ubJsjh/CuvNdPuwD6bExFcjzFYA2VvDL5TM9yKxOrakSK3mKXgIyU7zzax59Ki1rWFhx2S3IFkB6Xo/yP+7Am0yN1kZn4uOThQ5cP7RfFdIkEpPAxAH752JeXprXaTUdvLqwYTfXEMFK/5y9l/oNVRiXQqucekUu/UWeIkluBm9EHYj7xJeY+rQaF+ufa4o/Qk2Xe6yDwBhmqwywVJA+E/SGPAxlkNDI2EIt7JQR5cbYKb7SyvS05sFyjQFjij/Zmh8ceg4/y7sEvIbzsX0rV5EiZbtrCx+u8vQRPi1mNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qnfZeaZHqBD2cymHEVZHAnsbV5iPDL/c9SOHgqbDkU=;
 b=nXdyh4myltH4ojKvts4bhYy4eqtGJ6G32+tcmx0R1ZvaecBnyZAGKlgRP9QioV+WwkuxQba8SZg5LamIuCiuPmfvVeKhcHVSwo4WaaB7tuevzZMRIobxxqL1vyOHcCO6d9CyVXNJmcnfUCiDDQhyslXOBU6zfed797O2EgKdrMHiZPnC1vcULVyTkP/xtUOrbKwSs689dh9SI3Rv8GoWEPLS9xV2EfObeNIp+EFUN13gG/0d6rDiMjtLd57eA5JldIj++fGXm6lfIW0lRHB8NGroCKEkS/h+ji45t08TyzPyfnKWvuOtrSQaJj25iRwFWN35QQVyxpL35TvGydCp0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5297.namprd11.prod.outlook.com (2603:10b6:610:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 07:59:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 07:59:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>
Subject: RE: [PATCH v8 06/12] iommufd: Support pasid attach/replace
Thread-Topic: [PATCH v8 06/12] iommufd: Support pasid attach/replace
Thread-Index: AQHbiENE53aJ3NizfkuB+bKgwiG4abNc24gAgAFSggCAA4p0gIAA7K6g
Date: Tue, 4 Mar 2025 07:59:57 +0000
Message-ID: <BN9PR11MB52766D61EC2F79A30B16DAF98CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-7-yi.l.liu@intel.com>
 <20250228153252.GZ39591@nvidia.com>
 <ee4bdb1a-66e1-4d27-b7d3-f5dc1bc4e12b@intel.com>
 <20250303174845.GD133783@nvidia.com>
In-Reply-To: <20250303174845.GD133783@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5297:EE_
x-ms-office365-filtering-correlation-id: cddcc780-cf30-4883-60d6-08dd5af28e87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JbfHwAbWeQBYvGwZKRJkFnbTIeSluIbcCsrqFk3YJevjLcpevwvA74Ibtt7y?=
 =?us-ascii?Q?CeRfTogiqvsuEKyDY+yFEbHSUIfLwRyxkX/j7foE86p1QuE+9c2D+VHi+DOv?=
 =?us-ascii?Q?2HowwJW2VszpvRm4TtJGrfdPo9lgfYiVxZAOoxUpcPY6k3Y6JKPxZauwwmuD?=
 =?us-ascii?Q?LkEuTn75wJeCCIpMl1nOKnpSQp/j6hy0MeWfaKWMDFh3DAcnL2ZawTXAmiPC?=
 =?us-ascii?Q?OePoHWfvryGGyFkSzdsSZ69ZAnHhrQYXawzRXZfOkDqvf5NghMom7UQcfyu9?=
 =?us-ascii?Q?reU4qQDxcUmxQiI5CYTM+WkAH8O27CWV8AzvI2NbsBunwPPT0Oo3/IRLsZpJ?=
 =?us-ascii?Q?bnHlf90LJtv88PUQIbnL5Vx+D3zJcJSQtfiYR0yJ9K6INJtKaDs4mheQbf20?=
 =?us-ascii?Q?HpMkcZsJVNHcgKG7DIqWFbTtmFYvBO4q6NIJ2rZGiahT+9KnugkFTtGH19gn?=
 =?us-ascii?Q?dOaGJx0ajy9enFKyvSy/ls2mk7r/l0m90Q4BD2kCfKpUVLgKpDxO29uc8a++?=
 =?us-ascii?Q?dPlfl8XwGqVjvc9d/MoZG1P2xVdReqKAY9NrseCogPPtB9nnfBI2LJV+arzw?=
 =?us-ascii?Q?mopKMyNZxFdqDinSgaG3q+IKmw22j58jgBsI45u4Ncsena8pj8mR9A7n/Q0e?=
 =?us-ascii?Q?dvnetjNW4JvikrlxgtOORPiS102vjUj8q8uXfSxyEcsmt6XYy0XJBV79WK7x?=
 =?us-ascii?Q?vUxy3iJQaVsUS3B9se74L5yUKiSP3WYLmoIZDjHXe6aM9r9sMrh4xGlqu281?=
 =?us-ascii?Q?/0wN/JAd7+mgXkHV0RL5u8Q1h0kQ0plT3Xne7VjOvNsi5sCT+2dArOtme+lY?=
 =?us-ascii?Q?1VaIGNKcV7mjScC3zMvo1pzerS44PKY9NkgwyymKUt0ktTnrgp9/g058sMED?=
 =?us-ascii?Q?VcjPqvZt65zge8vbeOGNzofe4qQuF4z19NQ/ZhMhrOGByfvnbjb4Wz7T8ANP?=
 =?us-ascii?Q?3YIUfvnvkBZo58NlH3Cbuxi8OxFqgM8QR4acBDgzC5+ySu2IzSywIBaaZBnY?=
 =?us-ascii?Q?iSK3JV+VpjZxgn5MW+ICh+F60bnBOx2u++zPO9UUkqMtCE45BEXucqg+Deu0?=
 =?us-ascii?Q?f4JIalUY3k2efo43fsBvxdZqFXrTtCpYBr6BE7J4cyIbQ9Ns9qfdq7Xx6JWP?=
 =?us-ascii?Q?qWifyyi02cl603Jtcw+2zGg92duITGhfk32gZXpW0a59tJnATkTWNnGoyzAW?=
 =?us-ascii?Q?Y3KMIvk/i3QjaSQHgEXpbsEH60KBntoQL6Iw6x76+3J5ZZANLwO8//SLBqww?=
 =?us-ascii?Q?C+ClWkFC9fCT9II0/mdIKCuukl6HNplfDR1ftst4l7Ux2gMtBOowdOBpZHMg?=
 =?us-ascii?Q?qWkaOiJc7eVzEAS4cx17i/6sB9CsHn5jWeKJo5Sl7FURoJtqh+dCGJb+wNDv?=
 =?us-ascii?Q?PMznO9uq+Lv5/Qwn5lG8ylOkORzbKjHocTKYQfCJ78GVNex6dfVpUdeRMl02?=
 =?us-ascii?Q?1n4e45W/miiPJygHZKdXJpXhi0x7x2+X?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NaX/ZcF3DiS4pfMuV0Gw1GmKXzJT0hsot/afyZ+hLv9RGA5xW21HEUnMP0Hf?=
 =?us-ascii?Q?YNd+tTC2dMbqSxxcTnEjhVD9B0vfdrw/znpzy0ly08tAdhDd3hrQ0ItomdnF?=
 =?us-ascii?Q?j/RaPIxG46BE+gfjBol2O4SasNuxV81RA7GZw4aHWDYJQCPEPw9UwmMPYZkn?=
 =?us-ascii?Q?JqNFrs4GiE8TetIgZ8vNgitx89YJO356fHPUI9a9ffZc5wNKhn/5N1eSw4f7?=
 =?us-ascii?Q?zsr28wv+8uRy3tjo2IZeI7NmYX2L6teFC7O8Gz5JF/1rRYGhKvjUrAEVf0F9?=
 =?us-ascii?Q?EexQo6TdA5cFIKKuHQdoWWpgdVSu8axeLb2J8hDesARuJJNvS2JrsTNwBtm6?=
 =?us-ascii?Q?IlndAmf23zmT6ipeAAQRUt7gelFqWNFZvZOcjDCU74+nJpB6E0A5JGZntzj9?=
 =?us-ascii?Q?2ruhFSkzAGF9DGOP3v5Ew9NQPCC/4u5qLOaFL6rpmItXP9mp3p131lFYWlOw?=
 =?us-ascii?Q?lDWjEmWbfA0dllpea3yLh/VF47aNXFnBQSpdMO1VE6YX5noh2yo0byr8bq4L?=
 =?us-ascii?Q?Vo9XKp0khgrP3I/lfYiWX39we4WAc2cQD/Bgvh8foa27dMI4SWVH1PpnT8lk?=
 =?us-ascii?Q?c+Vmgc+jh1H2WM2Xj+Gba4hvcowascyVCz1whdAe06xC7yjY7QplNdPVem2E?=
 =?us-ascii?Q?r2h6/RpHKevK0DMlYx9mCdEiLe3mtqBA4F3RVd5tdsretXIJgHvlPEkviH5k?=
 =?us-ascii?Q?4K2scgc4PE6aEyDlDwf6VL+yyWBJP7q35kC6ggFYvQ6fu8zhqxdZTy63FZAw?=
 =?us-ascii?Q?rffpjp+mV6lqi9JFtFmCuSc1iVRJeR/9QYEuJDdgmInaD1xwNvGpxNa4DTCG?=
 =?us-ascii?Q?yHVW8xVy0tfndWpJrehwu97v3QOw3OOtiP2Lphp+JvvZyTAHEumMibmZdrQc?=
 =?us-ascii?Q?ygP7NvIAz6eilYTEtLJ/HvHm0oVVoDNcx1QAFSuFC0Ju15x6BSccwuv1w8oq?=
 =?us-ascii?Q?IVFs4WdrnWukkkUJAny4fN7xtyEREyGO/ALlKr22E7TuJI/HCE359qcd6cAJ?=
 =?us-ascii?Q?DjbNdmZj5Fwup9BuGOP8KROvgxp9WEiXPYgHtoEmyg6CJjVeVK1EUXO1S+M+?=
 =?us-ascii?Q?aCoFVjBR+uYrjCI46uh6l5vDdZx+BftGz3K1CkbMcSuuawIrwUGj7ylcbjM2?=
 =?us-ascii?Q?Ji7dmht1O1DnogLWoNM4m+8OBG+N3SerL4jhoQpddmd+tQVQwC6aX5cTSIfo?=
 =?us-ascii?Q?53Z6JPiLgYqpCa+UhsmWYN6RDNBzqmSu7xuZU69Dyt7IS5E7gijdFCG+CZGz?=
 =?us-ascii?Q?fj6zq2ES2BK0p22nQYLmUYPJC9robc106z+ishQzy3/Vul/fTcK925/TBJJE?=
 =?us-ascii?Q?s6cxUhxhklyZntLPipYdCXJOYDi8ZpJiMOP+eyPr5Jvq+aiN9epUJ1sJFTzv?=
 =?us-ascii?Q?ouSs3Wsld/RZ9hx8wdXTpnMp9Nj2jtOY6Z7iusVMO4fF9dXU5hphcbI5L4g8?=
 =?us-ascii?Q?Rv6TRr7PazQHz+0yf17xxOKCsruKv6GBs7bXLXAXZLsqmcBFISg66WjEgnVn?=
 =?us-ascii?Q?PZUVbY6ysK1Y4GYt/S0PJahUrUiICYRfg+PipBtKN6PW1jokZWw2z04o0oz6?=
 =?us-ascii?Q?eXfExmDb2uGBqHq58HYqMFfe8rPoEvHBD7uiScoa?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cddcc780-cf30-4883-60d6-08dd5af28e87
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 07:59:57.6230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70NgEKfKuxpWcrqpkdPFNrmfofYlUs/NJw69rrWtqsd7P8wgXEBsBxpxEzo0iPMjttJi0uo2Ywl2S1XSbg/hWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5297
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 4, 2025 1:49 AM
>=20
> On Sat, Mar 01, 2025 at 07:44:26PM +0800, Yi Liu wrote:
> > On 2025/2/28 23:32, Jason Gunthorpe wrote:
> > > On Wed, Feb 26, 2025 at 03:40:26AM -0800, Yi Liu wrote:
> > > > @@ -136,6 +136,7 @@ void iommufd_device_destroy(struct
> iommufd_object *obj)
> > > >   	struct iommufd_device *idev =3D
> > > >   		container_of(obj, struct iommufd_device, obj);
> > > > +	WARN_ON(!xa_empty(&idev->pasid_hwpts));
> > >
> > > Should this be in the igroup? That's what the core code does, so some
> > > of the protections you have here won't match the core's version if we
> > > ever see a multi-device pasid capable group.
> >
> > conceptually, yes. But I had an impression that pasid is only supported=
 on
> > singleton groups. Seems this does not stand since the SVA path dropped
> the
> > device count in below commit. If so, indeed iommufd should add
> pasid_array
> > per igroup.
>=20
> I would keep it per igroup to match the code, even though we do expect
> singleton groups.
>=20
> > https://lore.kernel.org/linux-iommu/20221031005917.45690-10-
> baolu.lu@linux.intel.com/
>=20
> PASID support is limited to single device groups directly currently,
> so the SVA stuff was duplicate.
>=20

We may easily add an explicit check in iommufd given the existence
of igroup, so violation of singleton group can be detected in case
the iommu core starts to support non-singleton group for pasid
w/o notifying iommufd.
