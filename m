Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9840A933
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 03:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752203980; cv=fail; b=j666j1kPLP605mblGi2oChILHea+YWjaQEsfGHiIJI+1ENZ0sDixux396ilUUdxgd3xBFjkbNxPEkSXhVgVwD1dGXg6rice15nj6dP8XRQkDKHfzNt/OP1/3kM/Wu7tLUdAFZ3wwrw54PgQxW4vuJvYPEVL2ZQqs8pz/oQEK69I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752203980; c=relaxed/simple;
	bh=ax0Xf3RMS+YbPAgw9ITndohhOLPXsJ//Neu1q+oAF4A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MiQGE4NiEfii87n+gJwcYnJDM4vaSz+qesr8gZtc1cfKK7MV94XHXy2cQegmQc3SeufVnr7p4DElA0+iNnIIYvfpf0yhKnlPZ2TaB3GH0VzAoYVqHFpjtCZVkcxRizJTQ1oa8RXOozzHhjWlrkrrqewLD4IxeR1u78tcBWdJje4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7rbsbfQ; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7rbsbfQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752203979; x=1783739979;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ax0Xf3RMS+YbPAgw9ITndohhOLPXsJ//Neu1q+oAF4A=;
  b=c7rbsbfQUOmkLDNQJ+Y38pu9lX+psQiJRmwwIIuw5IPHKPzq7g6h5Klx
   Jgbe0lMvXJ8Zs9NVZHPqRM26+qTw5AjBb8VoyivRiSlxjzDxbuHqUwyYz
   BDUEtrZnHNbQizeLTvaoM2GGybjWYqw6K/alTvxhsdScEul2kSGS6W4Cq
   SaORi1pQsJzqhRVVi6uGFduK2+GkhxpCi/VxFXUqwxvT/k64dx94Ss5qf
   clocuZxvWJ0VwRyKu1SlDWuWoIfi2aWHV73D1jD2C2OjrYB7u/uwZbFhp
   tJHgn/wurcgkqWsNRfXWjTdGJiNQpaeDCnGZsvQOLtrnZ64T2g0h9JAOX
   w==;
X-CSE-ConnectionGUID: Z3D4LikMQrm95ke22gNQJw==
X-CSE-MsgGUID: Sa7o47g/RdSeIlUqfAHdkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65848657"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="65848657"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 20:18:57 -0700
X-CSE-ConnectionGUID: v8HSYQBrRfSbf/wUklZWJQ==
X-CSE-MsgGUID: ahEWHxt9R6ylVg0P3dtjvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="156816012"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 20:18:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 20:18:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 20:18:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.60)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 20:18:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkvJj30PcbnFgtmY9zSqwRTn0BqfU0lSeQ6lIOug4J8sBObnNp/eg1SC998mVH9rnZOrLOawnZtTUkky3QqtRWyGYJR38UnxaWfI/iErcenXVJ+CzGinsNpyElBP69CTuPsd2euAgTJDAboQjaJVh4M9FRsLPtB4n3h5gSDhOfjYiFoKFnEa9ZaJq4v/m1l0fknhYj7s7juuLSUBA5DImeRAd4W+p9Oa735kvuc0wjrxoILjn5TWY9NJFZ7/nL6rAn5iS6OIrC1UYCiK1rRQfteBWBh/sbNEAR3M7kzp/7MBDpPq13reP8cQq38TVoTxcP+2drH9kMWkw6p2C9FZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ax0Xf3RMS+YbPAgw9ITndohhOLPXsJ//Neu1q+oAF4A=;
 b=IrwHdE3LxhQB0NgTF9393UVR+7z0SUKusL5WIh+A6rLKwAK7eMKWe878oLxzzZqlBv3u9T4q0ikLNYm1JqmxUISwzeifF5zDmRJtnnkZ5b0MdThIKUZdRE4V0Lo29+WXknV7FVYHKtjsnCmIV/ewX0gvXtoY2YGVWv4/QQhTLDDruigw1RYEgeTtnPJK0qp4PVqDqp+SKaXH3MCuTae/F+pLDBg3EVzZC+jrMoeGnM3UtRyQjjiWDB3qzcW6EnetSyVYlIbPyDKU5SerIvpktEHM3M2e34eqewMEo8b1yMIqYVYJkSRtj8+IfcHuTzdSE0V7eXJmjeOn5crRF0OXRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB7715.namprd11.prod.outlook.com (2603:10b6:a03:4f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 03:18:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 03:18:53 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iommufd: Do not allow _iommufd_object_alloc_ucmd if abort
 op is set
Thread-Topic: [PATCH] iommufd: Do not allow _iommufd_object_alloc_ucmd if
 abort op is set
Thread-Index: AQHb8dimlP4bZVa3DUmznjBx6AnD5bQsQTqQ
Date: Fri, 11 Jul 2025 03:18:53 +0000
Message-ID: <BN9PR11MB5276E1CE6E46DFC61B982D3F8C4BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250710202354.1658511-1-nicolinc@nvidia.com>
In-Reply-To: <20250710202354.1658511-1-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB7715:EE_
x-ms-office365-filtering-correlation-id: c1c159ec-7a0e-4d37-3497-08ddc029aa4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?BhFgAfdLuiK/aWv1bArMzAGngSEBwBNUrBvdGNvSnkMaDn5X9UWd6q1g0+xv?=
 =?us-ascii?Q?Z90nF0srZ9j7CewxXBZNuyr99cN7Q6/wTsPLg4syiAJwuyeRiSWyMeEDZzhK?=
 =?us-ascii?Q?3y4AVVTFxeTKpg6SP6Xuq3RGgXCd6s5cUZhbhMMgnqcHfGgB0CX5420dwkSh?=
 =?us-ascii?Q?rIQRa9oZcSUT/kBxFIpLfValjaZdhzub3oOljTXs/FO+RMnfQdtOl5Enapm5?=
 =?us-ascii?Q?ZLcidw/yJRcWrLZVJyDzAxD2jOdCvqyok9hDUiTwgEPkB4sniodJRPYm6DKy?=
 =?us-ascii?Q?PJg9GgkRhmgciWlyNGWcw0LaANK25VIMALT62leyaSkHuzEOZBOGiKj4N8sz?=
 =?us-ascii?Q?Hy+SXHjjQbN7S54okeHMXSu7+7jXDW2+GaiU9XN6u5T8bufWj93fsyUVl6bh?=
 =?us-ascii?Q?S7J3ovQxICsu/ycPlD96LsG8lH9P+aZMvwbdcMbYNE1947IyaGv81EEDJ7Ig?=
 =?us-ascii?Q?4CpV1CSPSVh2uxrEdop0nzp6kSnqlJ9kbYt3UYCMG3Uln/IjOonKEhPfMAUn?=
 =?us-ascii?Q?dmw1ev2PyqUB7H6yypLC8KzP3WWvormyalLygxJ72E4kEhjAFKhUPs0DLi0P?=
 =?us-ascii?Q?EJwLSvSjmzTqdCNhZ3yN0NWaIN0J+Jt8LFljB7Ap6dHaFrL+FJ6+amgysW57?=
 =?us-ascii?Q?IvcE1SZ9Yba/Z8UKj3LSvy13pyQPdqi1OnTHZ+r3lTFia8cuwxVTs11T/gDP?=
 =?us-ascii?Q?TYX54wQAcdxLNBknP7U/GeYCjU4bJSBUDbGUJgO1UrZoL2+UTzDbP2VzBsyD?=
 =?us-ascii?Q?vhVcfWBPUruU7WKjU95O59culwpWGE/HUKCY9k2u6h7D3WWwFLsMEipw4/vY?=
 =?us-ascii?Q?iYPebLMGV1VWIbWgEpziSGcllkQLTxIT8JSbeIBtz252lsJWk5bl6hbxdIaM?=
 =?us-ascii?Q?8DC1jVmtNz/I3931RBQJTL42Yvzx8tQctqfCy2zTNXdM1xVB4J0yD8e8pTkd?=
 =?us-ascii?Q?BiF+bNgtkqX2c4xM2eihevM9So9SE5yTYaoxhYzCgSBqAXAJMolWxBzQnuMf?=
 =?us-ascii?Q?Ze0+er4/XBKVcr50vem5+metmfYBQMl2UkNa+26ZGisz8KflHwfXrm2qAAY1?=
 =?us-ascii?Q?Hmu3renoAbwvab0Hw8sP5Ibx7dHTZWFQistrBpYGs7Y2AWAHe9KwLFiYOJLL?=
 =?us-ascii?Q?xqf3C5N+vvzGgNcQVKWCFP6CB0vccQGvmFfyAYEwf7lzsmeIEL9fM6kRdJro?=
 =?us-ascii?Q?oAH8SjkjNb03dV0aZALeSLhg3PUxlLdK70teFBZ9RRmGpsekdL+vjwS9gvpq?=
 =?us-ascii?Q?9c1lAQ0R4uWmcQWnE4mhw8reCDAPUw+HYJ7Hglvj0GF27orgaBOszZFLane+?=
 =?us-ascii?Q?oEdKNY57GaqU+7jz2SAB8auBMSPLv8EHp+Q51DJ4MHuHbvLRP3ySGvf3BUoX?=
 =?us-ascii?Q?44KzJy8EjeTxIRibU0BFji3jbd4xDgMIt08wlV7BMhPhhZ/ZQrezB1FpXcG7?=
 =?us-ascii?Q?VZbM+CjOLt81CUcV+4aWFq/NWNCXS27ageBxeYisi6gydD5UJPk6g8OF11ir?=
 =?us-ascii?Q?xk7JISptPF3sz70=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vFgTFz90T+cclWIIwA5ZILMdDqDO8xWZuuldhhSCijmIfhtBmUeag+knM9u5?=
 =?us-ascii?Q?0+afhagk9NEDRS8DTDSh4KpfD6o6/67cF19KNFfFSp5y6+GKBahK0RAJABp9?=
 =?us-ascii?Q?wS7rXqx93+JtUoj8adhxT2ZDcHJ2zW/YlT51R6nZserUUA6N1JuYbpn5AsaZ?=
 =?us-ascii?Q?Kht5iP2oYhhkqm0LXycHM43iWfJ5psaWqz9JBAEeopDXyIKrZFXz+56+AJjI?=
 =?us-ascii?Q?VCd9uqI3BvAs1/gJUDHreNF79PFAl1N3Nxm+MwEWvbL2CXlHeP9/ZeSYW5j3?=
 =?us-ascii?Q?D02fB1edG+35k2ZedDEsr9uNQzG9DpNfgcQp9BbYr0+rZUCZJ6fn1EANnrtq?=
 =?us-ascii?Q?AF6Ar7If7PLxc9k6Nq4NCu6HPkE62WW95A8KI1MBacrhfcv6oEcndVu8LYCO?=
 =?us-ascii?Q?vD+WwRPMsdw9aEd7dxz4Ul+uTdCW8vy3t4+6S3qEdW647T+x7hlziAYsIxXS?=
 =?us-ascii?Q?EtPFVVNap24AecpHQV7R1g2eI5izf9T0asTUMRbSEbgEdZuanhA6Th33euQA?=
 =?us-ascii?Q?DFI9GbLdoi10gmS4+vi9bjnjoX1v/dK9JTLgpCuIbCcBMCUxkU9cDH+tdBeq?=
 =?us-ascii?Q?UnDajiDtEmio3FnCQrUHGaWNqtmT7ZE7yHvsMTysjjA4VZEZ5xOt+Gi4GXi8?=
 =?us-ascii?Q?hKUuXL+alxncx0DX4BQ/jt80QAeEiSnIlz/HQzklDhn2kBxIICTTTrfB1gOn?=
 =?us-ascii?Q?5/M41FNIhIPKo70bkK4XgGAZET2cJUyFnNbqJpxiHZ2AkJZkIqoEz3rGD4U0?=
 =?us-ascii?Q?W3nYhIB42u38lg8LyLI+ExMJncdz0ZcyNM5XhyECtfGVlJe5hibyXoI07uR1?=
 =?us-ascii?Q?2mzdHdQMc4b471AHN9Gb5spExfqN1a0tKYYmRPgSFyK9ii4f4JeWQ3fcUzNO?=
 =?us-ascii?Q?1+J61ELp4pjYwaO57dB8UtO/poOve+aKy8jRWA9ssb+UPV5QkYFjmK5MgwLj?=
 =?us-ascii?Q?UoEqx5W2rkH1t5lJigqvppHbfuvICDXEQF2l8jTQUQDdjjFaW4lqaJjEVQqm?=
 =?us-ascii?Q?wfxR6oizW3zuwpkZuDNJEJMSgIEv4klV1TfIt+gf1KhVSNFcxqwaW9HtQKIn?=
 =?us-ascii?Q?bCehy+PFJBOQPH+s+4TUS1WF7oQJAqH5hULW6L5GrzScNhWwj+97Q3Z7l6TN?=
 =?us-ascii?Q?dIHUld14vRcAYPUqdtmyM9Lf0YTmMvbMuXoLUPrmHfdBbqqUT3BIz5BSRSlU?=
 =?us-ascii?Q?VJAv2g8m0vmVXGr/JCvmUibF9HjvH3q8PNAsuRML7Ict1P1zbSwW1GBZDwrW?=
 =?us-ascii?Q?CppK29giAC6p7YMTg141H3Aja8Ov5aLy+GIN+MAIphD3kx/H4tAoylWwjSn6?=
 =?us-ascii?Q?VinjJ3EeRZRYk+4hkDG18fBp9cvQkPN6u3tdWMEzalggUMp9bCuuMJfuDD92?=
 =?us-ascii?Q?gWEHQE+4lntbzQbRMiro5KDG7GRHBMT28HlcoXcIayLhfUqY9/hFHJAERr0T?=
 =?us-ascii?Q?3DdZv434j359JnRQ+gE2vh4RQU2vFcejKFef9jGsI7NFk94ttKvdaWbdx8I/?=
 =?us-ascii?Q?Mg+Q7ogmXCm8RvXxc0/klFAFDRSztfgHxjn8juU1JEmdIrm6llOJ+9HdfxKs?=
 =?us-ascii?Q?8qgVeymKVZ9xF3ZEz6V6xBEZHgXU0TaVUvUu7S3U?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c159ec-7a0e-4d37-3497-08ddc029aa4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 03:18:53.9482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q5eR82xad2Ur9MYbRzFS4GggR/4DfRae0Ox+TGvcjRNGZXCtgG2rtAkyCCt1VO3VuX3suSHnTaoLDBx5cbvHHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7715
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, July 11, 2025 4:24 AM
>=20
> An abort op was introduced to allow its caller to invoke it within a lock
> in the caller's function. On the other hand, _iommufd_object_alloc_ucmd()
> would invoke the abort op in iommufd_object_abort_and_destroy() that
> must
> be outside the caller's lock. So, these two cannot work together.
>=20
> Add a validation in the _iommufd_object_alloc_ucmd(). Pick -EOPNOTSUPP
> to
> reject the function call, indicating that the object allocator is buggy.
>=20
> Suggested-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
