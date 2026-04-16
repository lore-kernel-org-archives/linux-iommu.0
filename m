Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB58238CFF1
	for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776326223; cv=fail; b=tCjXvtMYLjcBBP7Aut3EOnG3zz8tWcBfOdxaFfBdgWrmzSUqyIPWacRV9Sx2kU7sVzugbV3GkuxFPg32yNZyKXLf5Kkey8LwsdUCSvS0Bd9zjdDQE9RHpTPhVc+GcmxiahivtGbA9B7MnXmM8TnpyttQjslpxZo3dhttI42ReIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776326223; c=relaxed/simple;
	bh=9XbTtQJtEhXWT5+HO5j40SP75SaLoFCJeSRV8AzyKuE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HpOHN4PprncNGZoWT8GgrJfiUYrgdB7Qf5c4TkOGMPBnRsE4aYxfP5n4Vr/lM8CSWDnGPygCNlC0cKRD1+nsgG5iF/+UAskNVAVzVOn+k7+0Sg0EPre20BnvTnXkkV4Ips8OyCOqowfMoI5dq3YuyV+oGaXKBA3psGs7YUFcApQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AyML7HzQ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AyML7HzQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776326220; x=1807862220;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9XbTtQJtEhXWT5+HO5j40SP75SaLoFCJeSRV8AzyKuE=;
  b=AyML7HzQ53wGR6rrSy45H3JAGT8of/Wn9xW/zBQcqh7T58H3eLNvysN3
   u7TIEcmUjOLQBiAix0eJTt8ARSxrApXC+zdTKbSJHh905HdUgJ4i71pss
   YYBOnz3iSLopgSQunEeqU/3m4yUdFo9O5At0TfGeofLQuKdHW9Oguxsdi
   lpic6as57RMPPLyis5OXdLJMJhd8/aMu/NaTcq+Z1SWI2ksZzBx++Wayy
   J+OW7+gHFa0SvR/y0NxkP5Jh/e5EatCXCq0eLgTnzFL6xdGuhzy3/WQV6
   Wl2p5OvXAAWq9d6DccUmRx0rJoANbg91BNyzDj4JMvUMoNTKa7fnjzgBR
   w==;
X-CSE-ConnectionGUID: Dth0Gc+vRhW6VCJN7Ug9oQ==
X-CSE-MsgGUID: nk00NWIXRzuab5Se4eAfMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="79902748"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="79902748"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 00:56:59 -0700
X-CSE-ConnectionGUID: 7N+5g/BdR2Gkz35v3nH5gg==
X-CSE-MsgGUID: aGRJ12u1Q96Jj6hN7QNTGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="230911224"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 00:57:00 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 00:56:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 00:56:58 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 00:56:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzVj5NPi6sddNyZYfO/hAp7Cl3b4guSM9bAOvGKLReMB87G9yUQ9kl27Y6XuBoggG0T4XOhlX2RlnQp5wLJD5SatW5mmj1kxJXUTrBIW4JjZoBTUsn45zkO0lMcbDSB7pHXlgQEyLm00SfGjrpv6YZc2XVdl6bZYqF8oPKkQcBnlwuoo7KTqt9cqC9BFwXZvlN8JTXpF1lFNvUlEvP2A4FbK3la5NP5tDyzprt87PB9PpCDcb+MtldwgFVQD882xoJcbpQJF6KwnHbAyyfMfaf5kOGJfl3QGmSUMsf4XPVqAJyOa1u/MI2bB0vck8k4NR7qGFsftYI3ghcAd3P2ArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O73t+AJK64UffyxtpGhAyQO6YIiG8WH6QI8D2/ldqm4=;
 b=C0URLRgdkLjHVl2EU8iHflJ/KOf3UaJhuVjNUZt7JJpxZyRmZ10ZICfyutzSvXJZYLdXueToktkhnQ58i9Teb7Clf+x/HF6o6rmvamCOIJnV37KtPHpA8xnahQ6y2e6JZonzjiwIgfW3LUFrqrPSVvQiNdHshIdRb1521iYEumJdmvaNUcmL11JaCGuXqPzzJ45jYTDNvuw6S0pbLYasHU79A1KVnnDHq8aSvO2lNu916lNIUQQCxIxJQXYXlxqWt1LfQEXfNuybBCEe4zXA/oxpuRxZmDerGPPu8Vsqa4CBHyrpXuUw7vEStXKYDJWCJZDoCHbOuuqVQpqvQeE9Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by CH3PR11MB7771.namprd11.prod.outlook.com (2603:10b6:610:125::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 07:56:55 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 07:56:55 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
	<alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
	<smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
	<robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
CC: "skhawaja@google.com" <skhawaja@google.com>, "pasha.tatashin@soleen.com"
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>, Baolu Lu
	<baolu.lu@linux.intel.com>
Subject: RE: [PATCH V4 03/10] iommufd: Allow binding to a noiommu device
Thread-Topic: [PATCH V4 03/10] iommufd: Allow binding to a noiommu device
Thread-Index: AQHczFOttn66sZMEgkeZrqhXZkXBT7XhUpaA
Date: Thu, 16 Apr 2026 07:56:55 +0000
Message-ID: <BL1PR11MB5271870197CCDF631EDD00DA8C232@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
 <20260414211412.2729-4-jacob.pan@linux.microsoft.com>
In-Reply-To: <20260414211412.2729-4-jacob.pan@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|CH3PR11MB7771:EE_
x-ms-office365-filtering-correlation-id: def96c81-0d22-4cd8-b5ec-08de9b8dba6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: oqlt/C33GL/8r5DJA1uxeMP2Lvu+sTOs9GVHHDy3po6G2CWkD6VcT3wminkFRFWd9s2GlueFfcBxJrEoxwGcuMhwprz1gw3lyYz60IReJiXagbmbkluoTWU/6GM+WmxnEFDxUHt0Onw5z58Ra97tptncTyvqgjQAsAFRw0ERktKALzDwoyMerev8DKgQzvT9J8eS7x1Zuc98n5/zS+PECT8b6QCHLQczXeopOvXIfdqeFjydCL7vKa/SBbDw5tYKr6ZQrxH/ihAs1Wjx3hk0HCN/nfWGz/6TuVybtCHG/ttiv/iVmfDQhJ9Lofj0bWTB4p7kxKXlcvmpp05qBayE+qeqfQtvZZEB2pCJ+XIvKCBi52U1gB5FanExvP8BVNgysr6mKMyEZOYS03O1cGIuIEQWKtCwbUSGeKMH9wAATB+q9Qox4CQwc25X5UKc7uf7aI5kLYJ1UR6AIer0I28CRLrC3NKABmDIcxGrKb3hBatnkp/Zi5PsnbbzZ2Nz/jPDXZhFLXBTQz+BrkK7pd4Q2JMttz0wxfDt/OWUVqNoU1mJHN2Qez7rBL/5Pd/I5aRAykAbmbkHO1o2+CXTrNROySiW2oPcVE2V71FuzIJiiveiF4DBHj/OAE2JNXg24ztaBUOrVr0AtUXWtieIdQeADtrvWmeUQa406rDCNwnrh/rZJmZW/3pLYuhivBYSAlPtosQzGV392KZY8WXaP2tSxQyr8STsRIknCjEtlfYet/5Rc+m8NJ/LWcNua1TsReg233EhHD4wB01iCMXNm7TP1t3dEwdMy+kB8aKpIWralV+Ba+J6xKcoHZ73E/OdYyCg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TdcTEud0Lw4/yhpiJ6P9RFgz+/SYbU/+Kcf6krricHGwunvuAAAU/X7rPUOM?=
 =?us-ascii?Q?9TZ6fAMgjcd68cSZwFA5HI0k+1HttkPkWNBM63AVSBSvywXhKFxt+QtZKj3c?=
 =?us-ascii?Q?CE6tzsvllvhFKDP6BzTGDN5s7fal9trmHM9Bn1NNXzrziv6FlWVBFx9y6G1R?=
 =?us-ascii?Q?u8gJcq5/f8BryxARWHJN7LWTjmUzE8Q99iTUnVETM8KnvAPtqxvChxO9lvxg?=
 =?us-ascii?Q?dgOgZ+JOVnUIhdw7F+EF4Zd4+N8PYFsoUAR9lZoXEk3p0z9Iu0wVon3jFLhc?=
 =?us-ascii?Q?3sli3jXuy0b5gFeY85edRpHcIF5/erEcgSsx2/UbciHVtbfwRHhLS6usy6P7?=
 =?us-ascii?Q?cEnB8Boxr9sU1CBYIMiWGbeHH2xyKaK7rfu40Yfng3NnwGYXNOzo9bUQlJje?=
 =?us-ascii?Q?wMeZBatrh+nczmaPmAgJwZ2sG8L3ufrDBhjRyXFd9aKzRx3yZQdfGB4RjcJN?=
 =?us-ascii?Q?xU+zOK59iP2tvP8FF9itiwHjq8J2MEpBnGW2YF1UARsHmkDajI3u/vtkhS5z?=
 =?us-ascii?Q?J3qLI/6yKxfEcEe8qCkU3vXyFvQXne+GZFfJ9ov98zhMZrVJ98I8AxM4T707?=
 =?us-ascii?Q?D/UVhEWp1z6MRFeWiuVSN+F7cfPUB1UD/O+21QS98PXUsw/XsJYoX24Z1XTZ?=
 =?us-ascii?Q?UMgeTckZ7T5pVlp9OLiDUvBJYyTzi08jmnlwxN01p6FnmjR8cCXPPWukq8Sr?=
 =?us-ascii?Q?Kc+kQZnkgihcrOMQEXyske2ZvqQAIViTDxbGkMzDwN6GbZLCNG7yPdwMoVp3?=
 =?us-ascii?Q?doEbb5oFt4SUhFtcghCfzb6R6L89TpkJm3/ThMGNoDbH1jMUH3d4RqLNs6Y0?=
 =?us-ascii?Q?4VGL5kV5fTHUNc2gDpXE2G5+0OOEwjWbQfXjVt30Oh2ieqvvW6hxstT4I281?=
 =?us-ascii?Q?J2akTl/SISd/9EDt1bMQhVP8f622BkNeBICfKlA7C8BAONq+FP3sihKZycFa?=
 =?us-ascii?Q?lDExgEghWPykNWzwh+AfHtbntrYfrZ3BJxRudVaa33ta0G5lg2qUzH8EcTG7?=
 =?us-ascii?Q?7abXK1Cd5N3lQZDDSkJQg1nPi0u/NjjfSICG6zRFF4gRf8rcp5vXPmCjJX6n?=
 =?us-ascii?Q?IOR/jGDMsPhujUeB900dYwps6nkdn7+FGyBMmWPRQSUdxRemvN4FCoYy+T/t?=
 =?us-ascii?Q?YfX2nN4EYC9aOu/EuxtVdvcgcXtf2YdIpjB92mvTzJ2nIq8yyqnOVlB2qEt7?=
 =?us-ascii?Q?4/QpW0hHEsR//wYPKLexhKlVSSEi0pevYqtoluZXkh0q/WgjcweVJyE050bk?=
 =?us-ascii?Q?GxtXQP40cor2R3Te/BrznBTO/175m4xEJkA9/caqM/gRnX0QTa3Y6JKk/IDt?=
 =?us-ascii?Q?QSavr7r2jbnmKuOD6OSGB4trQ/Z0/qH88xTIU3YSafMjQQpAyhVyRlm0jTlG?=
 =?us-ascii?Q?w6vKb0EBBycsvogifgz6R9YPZzcW2hp0Dx0df4UP5AVNqpuQZRm8Fv50ytN0?=
 =?us-ascii?Q?MBj2wZSTIiC+vJvt4/0MPBsCBl/fWL3g54+69qwdVrUqqQGG57KN/2kPGsfP?=
 =?us-ascii?Q?Z5tB8JostGLVh4Z8mmJj3LtZ1M5eoWrEJvBNkyUaa/LW7IYIMgBBQqcREr+6?=
 =?us-ascii?Q?q1JQ7nRZ2kxJr+AlIJE8XY3CUsuBPohlB5rf7/4f9Ol5/L6u5rdqjlELeMx5?=
 =?us-ascii?Q?MtKiJal1msv3oaZz3FZKFsvRaoX3quXBhzHiQsAgPPSttijbh32S73szqqYg?=
 =?us-ascii?Q?Lpl0ulCAUu6BpkM47EbiHg+JxAD6HMdqDeOsyuMXigeEWm/g?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Goo+GklklgiSnN2L4D1HbjQNzXZJRZgqyuU21CwRWt2xlLWrps/evJ6BGoGplPvx6iavjkaqdLVmI92tAfvZFAdeLIMWlAb1wHcIUfzZIFvoTXHB8Yt/sQcP2sXYEH39kYIaHLudm1wCi6YsCMn29BgoBspTmGoG485HBzCmFHa6OnZfVYcVshQwY5wxd0462gKtz4WGpdHp1/sJRrEjTh6Hsi3aRNgKJ6ad4WmAPzOZg0uMluORFeQrkdgP1V/Flx7lUelZEPVo6TAydFntcg+BwZJfWbE3FTbaqXoYbjea6gpP36jehl04co+grqqDViRZrlQN61aJfhCJRtR0cw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def96c81-0d22-4cd8-b5ec-08de9b8dba6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 07:56:55.3352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R/FLx3sToLtzI5AavP8pNzcREN0LN9s6lnuZh/yUx8W99+xBsdzaGE2X/WBc2cRTQ3L12fYpRO5HX1aMsxwaPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7771
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.pan@linux.microsoft.com>
> Sent: Wednesday, April 15, 2026 5:14 AM
>=20
> +static bool is_vfio_noiommu(struct iommufd_device *idev)
> +{
> +	return !device_iommu_mapped(idev->dev) || !idev->dev->iommu;
> +}
> +

could you add some words why both conditions are checked? It's not
obvious to me.

btw there is no need to add "_vfio_" in the name.=20

> @@ -238,11 +232,11 @@ struct iommufd_device
> *iommufd_device_bind(struct iommufd_ctx *ictx,
>  	 * to restore cache coherency.
>  	 */
>  	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>=20
> -	igroup =3D iommufd_get_group(ictx, dev);
> +	igroup =3D iommufd_get_group(idev->ictx, dev);

pointless change.

> +struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> +					   struct device *dev, u32 *id)
> +{
> +	struct iommufd_device *idev;
> +	int rc;
> +
>  	idev =3D iommufd_object_alloc(ictx, idev, IOMMUFD_OBJ_DEVICE);
> -	if (IS_ERR(idev)) {
> -		rc =3D PTR_ERR(idev);
> -		goto out_release_owner;
> -	}
> +	if (IS_ERR(idev))
> +		return idev;
> +
>  	idev->ictx =3D ictx;
> -	if (!iommufd_selftest_is_mock_dev(dev))
> -		iommufd_ctx_get(ictx);
>  	idev->dev =3D dev;
>  	idev->enforce_cache_coherency =3D
>  		device_iommu_capable(dev,
> IOMMU_CAP_ENFORCE_CACHE_COHERENCY);
> +
> +	if (!is_vfio_noiommu(idev)) {
> +		rc =3D iommufd_bind_iommu(idev);
> +		if (rc)
> +			goto err_out;
> +	} else {
> +		struct iommufd_group *igroup;
> +
> +		/*
> +		 * Create a dummy igroup, lots of stuff expects ths igroup to
> be
> +		 * present, but a NULL igroup->group is OK
> +		 */
> +		igroup =3D iommufd_alloc_group(ictx, NULL);
> +		if (IS_ERR(igroup)) {
> +			rc =3D PTR_ERR(igroup);
> +			goto err_out;
> +		}
> +		idev->igroup =3D igroup;

though simple it's slightly clearer to move them into a wrapper e.g.
iommufd_bind_dummy_iommu().

> +	}
> +
> +	if (!iommufd_selftest_is_mock_dev(dev))
> +		iommufd_ctx_get(ictx);

better add a comment for the ordering here - this must be done
here otherwise iommufd_device_destroy() will have a problem
to handle partial initialization.

>  	/* The calling driver is a user until iommufd_device_unbind() */
>  	refcount_inc(&idev->obj.users);
> -	/* igroup refcount moves into iommufd_device */
> -	idev->igroup =3D igroup;

this is common, why not leaving it here?
