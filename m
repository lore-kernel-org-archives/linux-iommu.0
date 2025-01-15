Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26178481D1
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 04:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736916227; cv=fail; b=op0ZVlL972qhHWUoxrClq2XCdA/DC0xeeFHlIMkJ+KWjeMjtdMRZBqJGmzrxvqJ5rayDyKeZyHmTtBJfLzrtxumgibtKGSIIKgmNg0oiVZajTmNjUNoFHce3PKbPgYZura9TCrSmd6fLCE4yYEX0KUuFvZV6dG8wr/6on7rCnGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736916227; c=relaxed/simple;
	bh=mtF06EgkyaYm2D/tL6F3lsP02XXU+ejj02p5VAqwvso=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CAXn4KvA4uPajASHLYvqdmUHSZLRtUaZaSOlQplbyEdBUgwVBEMuYjt2fi4O1wcMGXhbF/FVF0+ooUVHOsbyVans8dSxlXuQovtt7zkJQy46zZzIHylJRC3TW3HYIyD1Dfa96W18nJQ18PbOtW+xZf4YxVAY/2894+sOc2a9BRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f7yN5yqa; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f7yN5yqa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736916226; x=1768452226;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mtF06EgkyaYm2D/tL6F3lsP02XXU+ejj02p5VAqwvso=;
  b=f7yN5yqaT5dDwnpzVWK/DFT+VB6HMqPya/cEbv1t0akhZypGUrLicccj
   PG2165Eyt+TyuRylvKB4soU2E7izJt4WFbQcORUPtWRFgi1onZTJdY+n1
   ppXzkZ94spJG8gv/RsCXrtMaV5sZIg02d2LKyWKtB4IwWApIJjWP6NKLW
   1O9YDbfToGcrnDihvaprGvZOcxad6kj6KmlrvYHt9tFp0x8S8vCHbZCEE
   aqHUxW6hXmm57b9sppZKsYwy/6g+Wf9aBHrMAYfPasIj6RdsiFKG1kL8J
   03U4vLfz5wEdtHXlNL/nYe663dTUAIpMG4MLIyRsxo9bquBMUBWhorxPE
   g==;
X-CSE-ConnectionGUID: IkGSHSgXTVCldSTWULHWjw==
X-CSE-MsgGUID: rHBt2qJlQxm1ViYDM0wY4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="59719046"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="59719046"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 20:43:45 -0800
X-CSE-ConnectionGUID: 5ou8DfhWSU+P0OKj6V7yog==
X-CSE-MsgGUID: rW2cqudZQomOkkFR7X3q2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="104984885"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 20:43:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 20:43:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 20:43:44 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 20:43:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vn+VbEG+qvZ8mZ8ecILJxCSrV+dMM5jVW5vLATB2ds6xKKNZFOg5c1eTHrhH9nK1g+aPuK+tWBfrAw3vUZa1yyhifrYSsW44eHbBVYrlWhOtVbp40y+bSOEikwnHi/MeFiTN6jXa8CGxYqFakwAi/eAVk6AMTRb798NgvdY3PxgZpNGFuQRHhsqU6x3X1Smktub6k0mM4/SQz/IqwU0qjsDPBxy73VrbpjbcBEJS2SwzVDSCd/NdnFSSJOQTze41kAx/d4x0Q8UkeOv+Tt6MnYBOUfCUoaicoVoaePi1YXImoabLfIbX6OHlWG+cwYTR+uEivAMxwxI5aDZZWv8fvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPehnAsfpvyS1EMIIHe0WUygDtm0n7VMTypVUDrC0kE=;
 b=GJpLLyExcj+DE0e2ai3hcXi4pb1zkQ3DewVTBUef4rASRh4tZv488eJ9QZzdMUf/vi8WAFjPlgbkN/aee4IlIxV3cSkY3YgTBpp4Oss9IOpgCWT3KRM93ubvveXRo31/vjVH1/G8T3CFmCNR5LXZGwGoE4+2hh5+snr7cZXTuaDHyZWcJJNiEcGfLWU7sI2TE/3l3/2nm1Y+Mxw4jMXobJmCz2ugWN5LB7UEC5En2/djG+YcM2kAy+CaV+QmeBrrFwTECNVqLZKgstq3TVwewnAWhZDDfNZ17fRwUfRuKwCNuUe2/K0up8TmssqykXvvdc2VoJwV3A2w0jMNsu5m/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5807.namprd11.prod.outlook.com (2603:10b6:510:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 04:43:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 04:43:41 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v6 01/14] iommu: Introduce a replace API for device pasid
Thread-Topic: [PATCH v6 01/14] iommu: Introduce a replace API for device pasid
Thread-Index: AQHbUhnUNnXzHh2m/02CvPrIPwhbUrMVTUYAgADFh2CAAF4lAIAA+Eow
Date: Wed, 15 Jan 2025 04:43:41 +0000
Message-ID: <BN9PR11MB5276D2FD6D1006B1C14087BD8C192@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-2-yi.l.liu@intel.com>
 <20250113202134.GX5556@nvidia.com>
 <BN9PR11MB5276A7F34F2B4206AF4233228C182@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250114134530.GD5556@nvidia.com>
In-Reply-To: <20250114134530.GD5556@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5807:EE_
x-ms-office365-filtering-correlation-id: 0287963e-4e94-49c7-7be6-08dd351f2f9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+W/+fAPnMHaZAIz2zS6tb5t8SovlMVaeOL8q1bl/JI8pvXdIB5orhQbMXXtk?=
 =?us-ascii?Q?SlhFFkTnEVBJqUWlbe6DDQIO58KYDTw8lKvChkjm4jP1FSpVNMqSihYGnk2u?=
 =?us-ascii?Q?+JC+RdVym/1Z96LsYLFa7D+sFf5bokl8VCGFd3ctJ6FBGz53fStqSisgdouL?=
 =?us-ascii?Q?cB94/EHxzgV9tuk6wTUMuC5jMBwJaXzhrEEpmSkep1k8qZlHKD8WB30lAGFm?=
 =?us-ascii?Q?tKV/S5EHMiQBNEmKXMjLYZq0Ly6LTPGScnLtnwbvX7rsqkpDmgE6Tto6XvUu?=
 =?us-ascii?Q?khM0FyOlGosLwVoWcy8lvvfH+gCYQD984MewOfqHhs2Hy90jzGQgZYRogoKq?=
 =?us-ascii?Q?b4qsQEwZUoYZmFDadlK5Iql6SgAUQ1om5NkC4bbArjx6MeR0uoP+lBhYtbEO?=
 =?us-ascii?Q?Dj2cKbfz+SXU26IHORQSykAEqT+8z4dC1sxd5DkiP3QkTETLc5s6816tBGIu?=
 =?us-ascii?Q?T0PbiKc+DPI9lTWwsQnmKvuSIsZnDg0dTLkqc5SRtzkJiELUKMA96tkTAhCI?=
 =?us-ascii?Q?dnJhawfwBrqFjJbiWyoYN53//6NlaOOMqkeunjgWLyh5dFiiv965nJ+zPrnu?=
 =?us-ascii?Q?9iHu5wt8zs/ZgMjDsfpq6VBFRYJH2ujSe5PaWMyAi5dtGj9gSxYqA2PywJKh?=
 =?us-ascii?Q?5k0Yxdv8dqMFMtKFYIaVs5TJ79ObzdOeeK51yh0uI0kE8Zz7FCLTDx60+k53?=
 =?us-ascii?Q?tfcxXi3i4bTsvSdpUoaDYSbEl5HN/OyoxmHuk2CTf7l4I6SmBM6RUwGXv0Zq?=
 =?us-ascii?Q?hZvXvxhrhO+jhBskke4QvG+bowE/VVahdDzZN6Tal5czvm3qjLReB8BpTwld?=
 =?us-ascii?Q?F/a8er8SvnzrPrCVEV2kM+hL8toekH4wZbe6KDPb2FU0Qxbxw2nHiOljhDkX?=
 =?us-ascii?Q?pQLeu1fgGBr5FBDzajxZfYpkA61XLBRW/fKRtRyokjnIcjyRayJa3OIIOznP?=
 =?us-ascii?Q?jkzEAn+OWkuYSbLnLPzcEbqfSmuIed1jeYP+7jJjpdNJ31DvynNk93JV9Gtk?=
 =?us-ascii?Q?TkghXKoHlljnedXd0o8vn4BCTrV7aY7mmXtG0ES7aLIAkAOtYBW/kPVJ9YhC?=
 =?us-ascii?Q?xAjR/8uu3b0FYNC739ZoNIcp/HtxOxX9wz3mRlMDGKI4Re3EqoE4dH5xaJ1/?=
 =?us-ascii?Q?/gVV2bQ07Y6sx2OGJ6uHPKkA+6r4X1y9s8Mawe/QaHxEUcmlgE9dWXiumkQ/?=
 =?us-ascii?Q?RDUX82CNGIMh4un6ONQRwL+DhFYB8G+jR7UrBGxUiDFAHjoLf3BKeLmq9lQj?=
 =?us-ascii?Q?9gksNcVDIXQ8IufVD8Y1hrUOmd6j40zM+ddQh8epWIZTuPnAsw+Yui4ZHc00?=
 =?us-ascii?Q?h+QRI4eT+qezgetc04cJzaKxr940au8aVw7/Il4a6AYsX6EtaU0RIp62+QK3?=
 =?us-ascii?Q?EyOgNcG1C9d1bNvmUlPvo1j7k+1Rmmxa+OurRQ/RTZLQ6pJycu5QllJ9DaNq?=
 =?us-ascii?Q?D1dbrWtHGRcU/RdECLLmivYjZvcumzeL?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P60R6UHMie6S6kXK6fVR6slJ5m+NFTKifcKR3bGRSkgJr5BjQr6g7+IYYzXe?=
 =?us-ascii?Q?wwoub3wzc4jFL68Y7Xf19goDu4pYWxGq2c8hdXaGly9UrdfMBY1Q0FloWO0D?=
 =?us-ascii?Q?egnYJcfOVZK2+tB9aoEjr/9jvIFeFNfzDz25oqaEMEUAnBPhcrAOpcWA4zNw?=
 =?us-ascii?Q?qePARXrLoRiq6SevSt0B82+xogXAd65fXAZM0/WuQ2Xpl1rvkEoEH9/JghtU?=
 =?us-ascii?Q?085UU19uzhzjBkCzoyT6mJBzevHVvxL0vXqMyqNpAD/5jL85mLVWwlaNvdHr?=
 =?us-ascii?Q?6CLFri7TmICa1Z91k+R2pBLxhWIxq72pIMALAvI/Vq+x7HanB2/hS7Qfd5Tu?=
 =?us-ascii?Q?WTqn5hIz6hxqHa+51tNmnSFIp/HkqVUfj7iMahcqKr6DXdnQA8zq8smRlF1U?=
 =?us-ascii?Q?rriDkDzZEvpfnZQ9VdsRjIz65ptmTWFiWWpcU9C0K2ou7Tkv4skKHBvItRTG?=
 =?us-ascii?Q?xx6BI1hUnQJghAkXodBWKHi0z9U+f8Y65UldDDsKi8p45a14UaYFQOQ2u5WR?=
 =?us-ascii?Q?Vr9mzp6oH8SRnrsWq0fbiKULoXPTch+o7WNX5Q4gRIeUF8HMe8TBVsnZmm9B?=
 =?us-ascii?Q?5PCAhqMZaEt4wTl8RAH23faF7cn2qk17yLZLYldkw6Vicw0lBCSeC53OwOsb?=
 =?us-ascii?Q?oABXBGOYG8IDsBfKNuAyDtT3DWSMZ3KtLb+2qdEBP985P2MGwm/bQdnweoAG?=
 =?us-ascii?Q?Zn0mCyykrZTKXfJw4K08D81yFsXtn964mg7b232Sv8pexbnMOKzsDUyAEpWl?=
 =?us-ascii?Q?0WvaImxKqZFFva5ePuFz1UlzvqZL1rfwHnuFXngck3CkRy8P4afXQ4V/mQ9j?=
 =?us-ascii?Q?zpbNzfhgTWsIM7dsh7gVtpDC8aXUUfO7Nm6VV97CAdwcNhioVTYsg+PTnc/E?=
 =?us-ascii?Q?Wt8YmMCYv3MGP4Mi142uuLQEQjjJtgX/R09PNpKrqG2UWAEqxG9kfRp4KqoI?=
 =?us-ascii?Q?10MuBtmZhXdlfRsyhhVlFBztjSrxH91Rzh/ynSlOPyllZe3C5yyE935t428R?=
 =?us-ascii?Q?Ch+gWduSj4Adnh2F8mfMYp1zeOFo3Xi6wHSN9F98RmSTsOUq3eQf5AWMq4uV?=
 =?us-ascii?Q?QAaplOy9V2AtsjJ5HpF53cMpqVm9avP9Dciabs2eSGpiQ5jpPE74GvQlVEU5?=
 =?us-ascii?Q?jhSM9Kw01mXSBgR4WFRBgewYGGv0zlgWAZJKdQnzpYpeda2v61FfvzB2UiVe?=
 =?us-ascii?Q?tby9WQ+ClY209TQE60Sak/Kvfg1eu27Jg9nO0a+3Xc7B3EH1FUWHRh5Sm8UT?=
 =?us-ascii?Q?2Z5SK9nErK+FqLmIoaALxin84vnMV71BrSkNBsCFcvvtRweDKkeKFZ/HtNbG?=
 =?us-ascii?Q?g/4loBoBxfThRp9rpVG7ZdJvY4wX4zkNjzXk4TAEQ8ZtIGTu2LV77/5v1HmR?=
 =?us-ascii?Q?Eh0dLysnNX37TygVRSPcMLB7NJyqJGAejjI3KzlYqA761WDrpoNfGn7ASgXF?=
 =?us-ascii?Q?au+Mjan99bTanGT/QJjY4B2wNkOkb+mYl6av6SqdkdP7GlT7SGRKVp+qWeBa?=
 =?us-ascii?Q?TyDwdLA3pENbzw4WzXg+cV67jMjB9xqqYLBrUs9Aa9BW3J2RoIpYonYlTHmm?=
 =?us-ascii?Q?2KQB8MBoa1rpIM1Lo51pe+Mgkt+RPRlFQrn3hBrt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0287963e-4e94-49c7-7be6-08dd351f2f9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 04:43:41.5203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J1E2noaoBo1vadI1/35L4pjf5e7rkzZFFiXnOJYSTuLK6aYrPCOx3WpuTvFQobmtZy8EiLcXta636NX9E1rCdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5807
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, January 14, 2025 9:46 PM
>=20
> On Tue, Jan 14, 2025 at 08:10:41AM +0000, Tian, Kevin wrote:
>=20
> > > > +	ret =3D __iommu_set_group_pasid(domain, group, pasid, curr-
> > > >domain);
> > > > +	if (ret)
> > > > +		WARN_ON(handle !=3D xa_store(&group->pasid_array, pasid,
> > > > +					   curr, GFP_KERNEL));
> > >
> > > I wonder about the ordering here, is it OK to have PRIs being
> > > delivered to a domain that failed to attach? What cleans up that race
> > > condition with domain free?
> > >
> > > Should we replace the domain then set the xarray? (and same ordering
> > > question for normal attach)
> >
> > That makes sense to me.
> >
> > But I don't think there is a problem with attach. xa_insert() will
> > return error if an entry already exists. So there won't be any
> > PRI being delivered at __iommu_set_group_pasid(), no matter
> > it succeeds or not.
>=20
> It has the same issue:
>=20
> 	ret =3D xa_insert(&group->pasid_array, pasid, handle, GFP_KERNEL);
> 	if (ret)
> 		goto out_unlock;
>=20
> 	ret =3D __iommu_set_group_pasid(domain, group, pasid);
>         .. Concurrently a PRI event is pushed to the domain ..
> 	if (ret)
> 		xa_erase(&group->pasid_array, pasid);
>=20
>         .. Now what? Who fences the PRI event thread before the caller
> 	   frees the domain ..?
>=20
> We arranged things so that detatch would fence the PRI, if detach is
> not called then there is no fence..
>=20

Though I'm fine to change the order in attach too as it looks more
reasonable logically, I'm trying to understand the actual impact of
the original order (e.g. is the change worth of a Fix tag?)

If there is no detach happened before then it's the 1st attach to
a faultable domain and PRI will be enabled right before this function
hence no fence required.

Would a sane device trigger PRI in this window?

If it's a detach-then-attach flow, detach will do the fence anyway
before the attach.
