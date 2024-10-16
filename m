Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7558E433CB
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 02:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729046892; cv=fail; b=qSoFIrFm26mVrh+ntvaN2o5CYbS14q9S/G++sDYLmMHuqqODNzrTh07IeuXGWGdhPycXusn3AzmZ4+KqkoyTCAfP9XXlGAqu0wl8YpmIsHZjx/xMX+DUHbaj1Lp5Q42Utlth+C7tIMM5biAhhA9CTUQgBaBAYnCsAG4G197etFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729046892; c=relaxed/simple;
	bh=gwVE3DZygv+pRDtdUWrg+ZwT67HYl9MGvKZwL+WHjrg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cN5tqImZw/NX9GhPYsY5DMjlyTTj0wg8OqAUDoeemPRY5/ZlnQb801RGfnDdM+tEa1x4b1hm6UuFFKbwZ6VxtP2ESoW57nh60xu4bF6TjWje60YdjHQEw90UmYFwJzFy9arUtUd7Cliptow3PAtN/QY8423uOR799N2dhmnb0iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TnHR/NBN; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TnHR/NBN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729046890; x=1760582890;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gwVE3DZygv+pRDtdUWrg+ZwT67HYl9MGvKZwL+WHjrg=;
  b=TnHR/NBN3PwUh6bkyCcl6ba1RYS0j2K4jPziXxSTqY7Z8NtAoN8gT8iD
   NRM6OyN1FwWsHUd6g7fQTAqsml+UI0QsO7tqYuJbjKjfzxbPhd8vuY9kD
   k3tvxZ896o/tzeUUhC9cBbHYtcm92sq5b7HMm7iN5QWNImNVyBo4nFjIE
   43UmpjJI47k/bDp1NN/D3xKh0YVRARikeNTkWuSQeOigUN4cfRUCWepHL
   X0CrkxGItK1cAA9QEcdEFfPw1u85P+3qFMvQt0yF8fel/OsEvfyTycyk5
   1XwhZHlK2LwQKRck8WF8/0SakyEKp+ZVU1x/yYPIoIGfiByOTmF56T/do
   w==;
X-CSE-ConnectionGUID: EvcurRKWRWid4Hdn+bEHVg==
X-CSE-MsgGUID: +QSMJDecQ5qkBkZCuwKtqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28352994"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="28352994"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 19:48:10 -0700
X-CSE-ConnectionGUID: t8m3KoLUQwaLdC4D4WIeIQ==
X-CSE-MsgGUID: BoWwfzplRV2gFV/Xx3AhkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="82868068"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 19:48:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 19:48:09 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 19:48:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 19:48:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 19:48:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOjTavW0GrxRGwdQaXDKtzfeQ/Abubm2p71IbDfoWD0DWGBcWnuWoYEt0XcggAHx1+S2IowHYgqVhq8Bv7AE+Qvg/CzNG5wQ5NeQX0UtQiOV3G3ApwYusQfPbw/8bQOo2bq/iOsuU2Ymaaut6i1x1AvBOUNU6NpC8ZWN4d74h3O9aQikGxTan1QL7/ezSfr+AtZAdLah8AND6pV/1SnBlmcltpqe/kzRRCV06lmjUczwCuzDOgIgqCYRLn1txnRSSNYREMZl2ibkz5/jrTRW7Od1dZr/Z/bw969oZbtDKp20I4pAvtlPq3LTqJdQOqFlYwJr1E865AcVm72zguz3Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k03VZMqhBtRd4b3NYp/YZx96+lWwrbUt9PBlqHqPBoU=;
 b=he8XosWW44ZKIG1Wi/Zyagg/nwdrd8Q512Ysi5y+icg/PA9xQGhSysOPqfdaLzsf6v4jeZ3cYqAdZXHmW/kDOO+/isNxoPe3icWAqb7o0axGgZx0CFNXtr3IknVyCO3x/g0QvVeFtfIErDE9G+qeo1NZKsVk7gOfaPH6KcCurB2vJE39rJLkfiTwq8Q94nDrQMrULblvEixEi6b6dZKwrbsOg5xN8QR1qj5WJnmf0N02nf7ddVv6KqIagYkWt7/sA9sDiWaWr3H7UK/ENMMyCl9bjmIWaXzBvH0OdSey90Q8T+msyAIDQFx0IVshaYk3PBx+rMPrMQr2BForx7JcCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ1PR11MB6202.namprd11.prod.outlook.com (2603:10b6:a03:45b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 02:48:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 02:48:04 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Vasant Hegde <vasant.hegde@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>
Subject: RE: [PATCH v2 6/8] iommu/amd: Enhance domain_alloc_user() to allocate
 PASID capable domain
Thread-Topic: [PATCH v2 6/8] iommu/amd: Enhance domain_alloc_user() to
 allocate PASID capable domain
Thread-Index: AQHbBDRtoHcOryrM5kW9RdA/OpHZ/rKHsUPwgABFHACAAOvccA==
Date: Wed, 16 Oct 2024 02:48:04 +0000
Message-ID: <BN9PR11MB52769DE1B3AED678713550D18C462@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-7-vasant.hegde@amd.com>
 <BN9PR11MB5276124F430867613D7117E88C452@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20241015124018.GG1825128@ziepe.ca>
In-Reply-To: <20241015124018.GG1825128@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ1PR11MB6202:EE_
x-ms-office365-filtering-correlation-id: b99bc4eb-e34e-4cdf-160b-08dced8cf573
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?0mf6oPYiFiF+pyhhiaa8vdnwArb1Wtibtg97sPPVOqFGfpVCqKHOJdmqAo+x?=
 =?us-ascii?Q?GUhQF7BeOYriQf7yz37zmdTV/FHOg2GK7t3RhSEN7/ubcXIvBLw/u0z5HuFc?=
 =?us-ascii?Q?srdO+cHAwAPWFcJYyFV8ysoA4bwPPkMsVVECnNHWyokMenTG+XDvvA6Y4QIO?=
 =?us-ascii?Q?zwUW2OtQze/XAqRban/UIU37jXgwR+fuSUoiaJnyONRl5+X3x2hNF7hAjr77?=
 =?us-ascii?Q?+M5okSzfk/RAz7ujvKJ0w+++m+iPRviu5BUz2kBozeBOTM3kxJJVwT+vwT9N?=
 =?us-ascii?Q?U/IJPHnu4hcX2TuxrGEEf6E+V5NJ1+Vw0ZsTD2nfcesJi95TRr0MFjyy9KDy?=
 =?us-ascii?Q?3B+OEQWpg3/HrCwZxjPM/A2si0FqudpPnY/LPGzloCqRb8pfBFcJ2AATQKzA?=
 =?us-ascii?Q?kK6BkNW0i5oYecb9ivlIABuQFN3OuSNHkCmwOuXqmmPPXgl9MAINNtrEIze6?=
 =?us-ascii?Q?6ELh3SQMlq0Y7IqsRxP98fpRK70YzK68A/PMZeXQzggzqAQyxto5W8tzUEl3?=
 =?us-ascii?Q?uzyjoWv8VDn0N39hvsXbm2YgoblmtUrQ056aM6H9pLOcR8ZGoDojj2Hrefn8?=
 =?us-ascii?Q?TkWkobs5C490hoEUJm6b/rKBB7ROnQpO0Cb/eir7gTOsL0z3d3jXyOSeT08l?=
 =?us-ascii?Q?hj0m8yuFWw8aHm/3FtxBtkU1z3P/OUZX2HVj/TwEo0TChp7jUViYwnfI8z/g?=
 =?us-ascii?Q?KYwTjvyInAvIzwIoDLZKTquPzAjWmuyaW+Orx8IXI/8ucH1tap+XG9i+cbC4?=
 =?us-ascii?Q?Y4wNrJ8QVmu798HwgUDjmEGcVrf36D47hpy2WxRBYUjnGWlLClMrgg9fN44M?=
 =?us-ascii?Q?ouqlBju8y3r8lEJrh3ab9tWkhpMteFG7xDy8FcEK3JwkQhBznxbV4Vq2qlyO?=
 =?us-ascii?Q?MIVFN377KkwXsoA4EVxLl4KiA+Iic29HRpwESCOEfkXDKGEqRz0o1xAGWHUT?=
 =?us-ascii?Q?WmyyXzDFvT5/MA2N+nh8ht1iGaSiIi5Wx9HYtz4cnEkNF7+P5a1IhOLXL5W5?=
 =?us-ascii?Q?7c/gTZED7gvofd1Ph/tTaW1TmyBpuFA4CLMPWcMOGtXuJ84/mMq838pkrDVh?=
 =?us-ascii?Q?kuFLqWvoMwilffzXTKAxVWvpX/7pdWtSWgqtO/I5kzplJhp0OAbM7raMip5f?=
 =?us-ascii?Q?1jLJTTH9f7hqsGF+LuU64NvlfSlvh9CpcsnvaJ5DLMOOmQiyOzvNpxtaQ+ei?=
 =?us-ascii?Q?iErU1A4J7auoWalifpH9R9ANVsIxpzM/kY4nxd70TqJtSwaGbLZSxFFr10aB?=
 =?us-ascii?Q?/8/gFsNeqVAwifcVeAOBsL7UiwyE18BnJsoNQr5Z+qNS+4781Fk62sEL9MBt?=
 =?us-ascii?Q?nnz26xpaN1JG7L6nmUaAMAxODDEz7QbwYzi6GJbuYiTWiw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OYnQMSEBDBk1aPoiyX+MaDv8kAdF/WNxR8JegfgsADMikyeSQS0Y8Qriv/81?=
 =?us-ascii?Q?0qIoI3I435lNRuEx08b9spnPRrHiBDWGrCWhqX1CsgBKJmYR5FYDQo0uEyCr?=
 =?us-ascii?Q?dUntULsbc4/2jXcsFZ06L31x7KlrjC7iu/fhOJ1+wUigLpIFSpeTQbURHW3C?=
 =?us-ascii?Q?d/TPwdskmYHCDpKi9xPxyKV0IFKtisn9zx5ZY5hLPwI2WeMo3gIdK39quB1B?=
 =?us-ascii?Q?spt+BvA3nBcvpylWBWsVYXkrEIoGDxLPhNGMWPJSfdamcbqg/8v7TUNhUJeM?=
 =?us-ascii?Q?3LIEZaI6+uktLfEikpKDPOBIGsnfBCEZyjKOHx8Bb1AUiuwbZWKXrcHZfQk2?=
 =?us-ascii?Q?bff9SU2rdVVUOHzizayqy7Pf2vfd/N6B2RFax1bstt0d4dJVGBwUyHC89gic?=
 =?us-ascii?Q?D+kj1RENsaRAVEHf9xNOeswqPt9H4OMaviDImeAQib5wpkClFwSsSYSMKsAp?=
 =?us-ascii?Q?MyjG8JzZchIhvxVO6glZ/GCgZjZisLNoHl0gXq7FxUtpgFVOIpmdfQFg9xGI?=
 =?us-ascii?Q?AY87pR0bFyuEEbD3ngA8Vf3GgG+M/sg/PTMzwIP1ArereV4sMZLwld8xjzsY?=
 =?us-ascii?Q?negiMCnp+v13YOHsvPu6xGF97O3RQ/7T6vJBOjuw4Oju4/I3iw+5UeSjFYvd?=
 =?us-ascii?Q?C8rj3/P6A5fypflHTIqS7U1oGcMCbTaz8GlFbuKYOv6PaJMfsMo38OM1de7b?=
 =?us-ascii?Q?pLw6Q9mqg3o4c/oy2/IvSmx9tswxtoFhsB+lJIIOvQGPjq++FqXIbjCjwG8a?=
 =?us-ascii?Q?mcZje0M521eIFLK3MCiDzIdY/hZQ7e1jBFCsqcUcSc9/eGTHFvFGqyNQINEn?=
 =?us-ascii?Q?iVvRuHU29qZJkOBNyuRivKrYILqFTSbzOC2iKNsmVyIuQBV22lJ0rdCWQTzO?=
 =?us-ascii?Q?z6j9wFQpqD4haPjUR1lVH4NsCNk0KG18hc934BQzBpQlwH9scjMm0Twcz+sb?=
 =?us-ascii?Q?+xBbVPEJbMyKv+lRmBmbDxybq/Uv36mjYtwudhRCf7s0aXVtrcnjzD0Yv1JT?=
 =?us-ascii?Q?4k2sNAp1CJvv4Qt2408cdqMXg0ssrI06L6CRmKWvEtPMHCWdBQI3uIdaO55s?=
 =?us-ascii?Q?RNbYOnJUvrzOFqVHlC8YW+N8KomcSOYfdZdwk45uBqRa2DENk7r1fle33TIg?=
 =?us-ascii?Q?5+Y0NTDUcwPFaE2tUdrRmCPd60DqaLBgZk/0znvwNjZvGaxYtfMLoawLT+VK?=
 =?us-ascii?Q?JIS1yfXwJSCBLCJykvm0FlYm7T7WlS+hf3zKaYO9Gu0XBr1iMxQRiFmaSlsj?=
 =?us-ascii?Q?DYLG4tqejrtyMyShrmXRH6Xb/DbjWB/udIKuAQOpMTlN1gTBHmiAzu0tPVnS?=
 =?us-ascii?Q?Jzahqp1oYvvx+Vcrq8C6h616dlen12tUubVg7T/QMTwYUuw7Hyg30Cd98Z1T?=
 =?us-ascii?Q?h3hP9MLDvqFjYNaOaN81hbGHpKta38diy6qrfZP8Cq5qAWEU9GqKVLWuiER6?=
 =?us-ascii?Q?Lc3Ng1FxGXfgVUVQAWY6s8S0eEjBrGfdSB1lBfVZO4BKCTMT/+kzUuEULF9t?=
 =?us-ascii?Q?jfR8u1uYJDm291KvKj1COvusE+FJC9mEgMHj1rsaF2Wf0nd0j9ugpF3cl8id?=
 =?us-ascii?Q?ZczLjTGUmhxRJjdUYrXUXy2caBL/WaA8+KYGSyeR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b99bc4eb-e34e-4cdf-160b-08dced8cf573
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 02:48:04.8470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zdYEAPUrKZHWyuQQ8q3mapMNIl8IQ9fxMo0H+Vuq4xPybqTuhTtVV/gN0ZK1g5G1syVlqc2+akR7qLmyOz6G4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6202
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Tuesday, October 15, 2024 8:40 PM
>=20
> On Tue, Oct 15, 2024 at 08:41:48AM +0000, Tian, Kevin wrote:
>=20
> > > -	return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V1);
> > > +	/* Allocate v2 page table if IOMMU and device supports PASID. */
> > > +	if (flags & IOMMU_HWPT_ALLOC_PASID) {
> > > +		if (!amd_iommu_pasid_supported() ||
> > > +		    !pdev_pasid_supported(dev_data))
> > > +			return ERR_PTR(-EINVAL);
> >
> > Just check the iommu capability here? IMHO it's a sane case to first
> > create a PASID-compatible domain for a device which doesn't support
> > PASID and then attach the domain to a PASID-capable device later.
>=20
> The point of this series is to allow AMD to select the v1 format as
> often as possible because v1 has better performance than v2
>=20

If the user wants better performance then it should not set the flag.

Not sure the kernel driver should enforce a policy preferring=20
performance over an user opt which is compatible to any RID...
