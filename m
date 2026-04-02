Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47393876CE
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115276; cv=fail; b=s7YftwqvlStAl+z8cF11X3teBKyNhwEuqKOfVkOciX+ued7TLkjuBYA5dwWFnDjzMOrzFzHZVuoLNvtvMvTbavxcHgvLzCta3K3cuqGLRp2zPkJGQhutTELOh0IezrPLR6hM2f9gr2QZVAmynoFp22KgcHjQmzOVGBJj7ftXqBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115276; c=relaxed/simple;
	bh=lEsoHoIrICyunQH1835qweoZOt5mbmHORCc3VnZWQgI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e/LWa4X6qWDSaByahIKiDbff5lYzqSiP/okZso6SsWGLgLNaZMqh+6qwetiMbgCdfLxx0Cosxg1/qvYcEvPwt9Vf2/SHx2XK+xZu5CRIyXjomRkStHljyS+EFJg6iFCHpYll272QOJ6qS/WLzAJyt5BJi8Vvp7tIpSgsjvv6BJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6/qxtpl; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6/qxtpl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775115275; x=1806651275;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lEsoHoIrICyunQH1835qweoZOt5mbmHORCc3VnZWQgI=;
  b=A6/qxtpluJKA3bAdHxoVBWq9gF4K8aP5HAUGS5cNLIbSPajHueJFR6PL
   3w40BvxRpW5HGPYVGnFq7oMQDuRSeAIH73lCs0WqKN18Ycr5qykiCPm8H
   gZK1jMp0ExXzMOKqmTIT4at/GubT6XX/S/VqrYB67OLcM2hG5ZKBIgYoO
   o7TZPrw7670WzpWHb6k7L8do0srDZ69V6P9r5GffOOX7IRz0i3Y5K91Bn
   Tc8sRWF487MwkASefinmo9YE8uSvcwmqKES2FGV8cFyg/6IAbd4yxy3PN
   0Qf7PDa5HFUgKMlcGFVwr16r/ErZbLxCnciRTTNfbKYscRb4qrHPY3iXj
   Q==;
X-CSE-ConnectionGUID: lq6FwkeWSL2SC2XDsJ0Lbw==
X-CSE-MsgGUID: nB+3F6PoSny/wezKm1XLlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76047925"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="76047925"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 00:34:35 -0700
X-CSE-ConnectionGUID: o0hkga8CR2Gbir8zEMpSJg==
X-CSE-MsgGUID: SD5RBCwlTOGT+qPiw5UPZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="250114066"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 00:34:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 00:34:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 00:34:32 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 00:34:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSC6w3tVJa0g31wOmaHKj/5L/58ciIEBnOwBLNRxzU9aeYbZYAS90rNVMXMEwhe+ij7TOBsM01i3CnpuMgsniAhH4ds4y04aEtt+iy0GIvA/JorhQ2I7YFg1UFBtB1McUEy3wOGk8eevra0XuUSC1ABFwBc7hBB6Q7GdShJgKo/VQ1vJTdCMr2jFK4xiF6GZ5xmruq5hkXfpwGGyYZrIwM3gX70SwORR4FKob20PU9p7XHjYKZeFuHq5/JUTOKNv9qQPl+1KC3QWD7Bs/mFqBh41PrR6733T3HiiLo0O0yROC7RTtvc+MzPgu7dHit2dRjtIXfyE07BeGQR8Fhn9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WDgiAYVjXdH3Z3EjFn4cUyqYCdzOTFODtNsazrklTQ=;
 b=mQLvSHuBi31iEYpsYYdyv3UJ0Uxmin0TexPbycvzk0/c/82Ro3wpiVXkxdgCfSYw0O0ox88YM1qL/JQIxv9Ox2lBXZv8mBdz1xCo7rD6FCrQ7HbPCYmmNvxoe8PEhk/PyadayN3WXNBxMYXtG2r/2PcFGzlq01J5YFs2EC/c08ndrWqOj7xrD05SVmjl1HeJZPQ6EBp5CeHphKrPh/hOOFWhoERdN1H6c/UeEJfQ+turGnhfEoUJ6qgUVxqS+NzI1kcebNVjDkX6SL4gmVpui4zzUHZpZ2u2ik4+CaQZVK4AwY0v2X2WDLqVVMVbJ6SQaWfeMjR11LEVgDKMMHaHSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB7324.namprd11.prod.outlook.com (2603:10b6:610:14f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 07:34:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.020; Thu, 2 Apr 2026
 07:34:24 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>
Subject: RE: [PATCH rc v4] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Thread-Topic: [PATCH rc v4] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Thread-Index: AQHcuy9V5wm/djU4hkew0hX1w5i11rXLYjAg
Date: Thu, 2 Apr 2026 07:34:24 +0000
Message-ID: <BN9PR11MB5276EBE613B081DEFFF6456D8C51A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260324014056.36103-1-nicolinc@nvidia.com>
In-Reply-To: <20260324014056.36103-1-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB7324:EE_
x-ms-office365-filtering-correlation-id: 6f6c8854-99ad-4388-3fed-08de908a434c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: wadxFO9TCTWwDCHbHVaLviQ+f3WaQjyvIBQClUshrITFFjdT90MYJZtMXiiiRoRwJflfEPtf6WgOu7gnLuGmgBljr96AS3j9E5bSOkV9nBTik4OAkNejz4ExC2Hu2wwk+99ic7x9q81zs9vXFhacmkkGoCSWKpWZaZJHdCDGcpJCHOfbF8/YEDAuJ+lg4oD7rKvwwE3qjczw8T7jSX2DLr5W/T0W0JmtjrYyh4kt1HGJBmkSeCA+kWsZqgciNAt8CUi6Y9svrJU3Nepbx+efuGBvV1i2kGbwKD5pvE8eFAizSdy5rWvRf74MibnzvnG5MPgINH1EpywGPEdgqV6YWT54c9xpqysOXdwYOpbJs0+Y63EmOtI2zCmV1BdwQ5QtU750LM4YaVn5SFdr+RtT8G1E3I5Oq2Mlm/x7FF8sksQtpaFq5DjuwaE9sAgopziRXzUitCOAhzZY+3DwhPQK06W59v5G6L8nLsRdUViwtMAfdJCvvzRZCUNH2U3jPYSwAsLSXqyYVI9XW4/qEJdElZZlEA5zb6VhHqSEtzuGObtEGNlmfEdenDnl0MAAon+XD6q/Pq2qkm1mByXbzGPGEN4tTnxGK9c1qiExkDHASrUIyIhrnu1X8HFMquEkB0HeZ1x0IgU5NgcIaaFTGE4YLCtPBN0w2dgZ8QcbtySOI8g57ScHodSdaKv/K0r9UBuzTfVnrv9twYEm134/khKwNe8iqp3X9fA+dN8FG+K/t0c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rrGSDux1jOZajMJpxxrRXJJdZAllhGpT6okR1Z0Eg8hhzOUNqJR2LjFXJGuB?=
 =?us-ascii?Q?Bb9jEpTy0Pz+3JwvyB8XTG8ON3yhqFJqu2mGGoV577enbafury3RkstWanFQ?=
 =?us-ascii?Q?Y3s9HGMFCw6nQFOBYMwH+vxpVC8ICUpaJOiM6cvl5KLjhu0brIJMyWuS7q9I?=
 =?us-ascii?Q?dUeySUnq6hZGFd6qWrzyMNBPp/5IhoAFiDQ1Llu066dk/YrGe8iLCEvqYRXE?=
 =?us-ascii?Q?gWAlluhkzWdqaGmud6QdZgMxbyya9YOgGnLmECaY4rKDlZmFBLhMcRuw5BFv?=
 =?us-ascii?Q?hLVsvqTl0l3siJvPlsSexi8cJ8p5xskvoDAgDsN9CNgjDYwwFw25CBPZ3IZ6?=
 =?us-ascii?Q?QEK8fv3XsvdYNIyN5+ZItqwDXfhjDK63yIJ4OZX7XwrA2GT5lA5Gck9X0p0p?=
 =?us-ascii?Q?RRg1P2iPeEgX90Qi8xdvrnN7Dli0C1PJzc1A02RRz2z2dYrq4nXOfNmx16Ls?=
 =?us-ascii?Q?yx9Gs0ITCK84Dd1f1N6OXp82t/I3lb5B5qCqf6vN/rFVyqXPL8T6OobgFDEt?=
 =?us-ascii?Q?5WoaD253FmRq5iX5Bq4tUhpUZbARDdCY2LEXSITcDLWP+uB9+DMy5tgtp71K?=
 =?us-ascii?Q?38FPd+/OIYyxmVO7xyOdugiD35e+2owrdr4rY6hmdaohL63G68EPx6Ne04GV?=
 =?us-ascii?Q?P13W6furxaR1AN3Vmr3FGx6halfT+H9wROEfmnGxFpdpOVLa2SOQS+1uMCqB?=
 =?us-ascii?Q?DgjjCpF3La9M4ZyUK+nwESnp4G2Qsjc29DhZRlTEqCsX7dd1sdN3K7E2l717?=
 =?us-ascii?Q?Xz921WS09S8JrG3Yl7ec4ooEBWKV+g3xAbwCNthNp+tb1TWISfe8GM7iaSBq?=
 =?us-ascii?Q?U71JJUdx1p9s1PgOC6DkXZPx2oGVcweo/js/q1x/Plpmte1b5agix1g5kynf?=
 =?us-ascii?Q?U2yKC9jTWAeRTx2bixWo2p6If7d/2lnKt/LsRxxSaJ1BJuEJaC9DduLpm2RO?=
 =?us-ascii?Q?xPdD6GyLEuUQhUcPJinzKnzO6PQXsZt1lp5WgQCA7xPmqSEyuTR/uOFq+jCh?=
 =?us-ascii?Q?wbKjGp5+7xn18utArqX4dwtGccgbn9PqbauYe1yTlOYHYUPy158v3TRDvFZw?=
 =?us-ascii?Q?EtTqYLa1G4RDTcrHfFz27pNKpzTUvuMqaWfBoLeBbMaB/uhdIa9IA7yedtiR?=
 =?us-ascii?Q?of06Ek+vevaHjgegkEsjs7x+kiTuiORa+ykaAR/liyAKxv1dO0wAfbeEvNKA?=
 =?us-ascii?Q?xNnWi1LXz82MZJ4CvoSkbgluvYVpbbiugFXMPu36YpKq4gDZDsy6PLYv35Jp?=
 =?us-ascii?Q?8hbK+meXSe3/UdjaQGlkpYi+OgftdNJE4C8gzyZxnH2s+59uiamJux03rvmt?=
 =?us-ascii?Q?M5UaStsD+sV+snbloQD2SwiZswuGVsvF/rr4koLBHx3dQhPy/NdHLAM2OZyd?=
 =?us-ascii?Q?Hlwe3OPctVjaSLXcDZZ0D3mQLtFsGRiV/asHtJhCVNx72kCDgnFHHP2zT21U?=
 =?us-ascii?Q?yVuXsg9PdmPCuUsbZv15j3nbfDMV+UznpIObU22rLwzx79In91aZyzotILD6?=
 =?us-ascii?Q?rMeAS3n4LLj3OhaXniiajMZomSACMKKExJA843A7X2Aqw6U+c83Z6Fp6F8uh?=
 =?us-ascii?Q?EjsZFquvAZlZ05uiVXpBG8+IreIF0/fidV8jgVjpmuI1t4KJSQa3rTevhMla?=
 =?us-ascii?Q?3J5BNgjcZi7LBC6EHKH4RnQxHLWrCkIebrYa6uvGTOuyOQkBXY0O9loCFuzQ?=
 =?us-ascii?Q?Z+VbNVZbPph/LV92VdYpTOifHnT3oCy7yG02/ABxBiLFg7qf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: POfKHXza58kJ8SnhxhPogYMmo5e1f5NwpB+eY5oPMSGOKNsOE2i6kBwa9cPezyskLfO7Xdzzb/m24eop3F6+I94HQzPeH6uHfcyRsGFIKP+G5LEquWQJD690Z+isI6jyvnEecCgl+cV2qpobZkj55+wWo5Ur/ZqONtJVfm2yQYsMqeAqTAuRWWAkRXIy1pMjLbTcOFjrspk8KMUu+yEzw8RqZ+OcjLqIWUpbKvwV8oxBS1ZtKnlrrz+zGF/qm+n8qfhPgxHuIXgHZZaBbCqE5MrfugH5H7O3R8wqawmadlhmcLrDKrhXDxm8gmx9qFII1xX6XyVpp+9EuPE0v7w4fQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6c8854-99ad-4388-3fed-08de908a434c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 07:34:24.0961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wTv09lFg9r4qoaANW7YZzdKYOl9z7mxc+TAHKvjK+ffRtMvKU6Z/CD99/QyEzWJUZvr44w+sza8zOkKGkp9nlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7324
X-OriginatorOrg: intel.com

Hi, Nicolin,

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, March 24, 2026 9:41 AM
>=20
> @@ -3961,20 +3986,23 @@ int pci_dev_reset_iommu_prepare(struct
> pci_dev *pdev)
>=20
>  	guard(mutex)(&group->mutex);
>=20
> -	/* Re-entry is not allowed */
> -	if (WARN_ON(group->resetting_domain))
> -		return -EBUSY;
> +	gdev =3D __dev_to_gdev(&pdev->dev);
> +	if (WARN_ON(!gdev))
> +		return -ENODEV;
> +
> +	if (gdev->reset_depth++)
> +		return 0;
>=20
>  	ret =3D __iommu_group_alloc_blocking_domain(group);
>  	if (ret)
> -		return ret;
> +		goto err_depth;
>=20
>  	/* Stage RID domain at blocking_domain while retaining group-
> >domain */
>  	if (group->domain !=3D group->blocking_domain) {
>  		ret =3D __iommu_attach_device(group->blocking_domain,
> &pdev->dev,
>  					    group->domain);
>  		if (ret)
> -			return ret;
> +			goto err_depth;
>  	}
>=20
>  	/*
> @@ -3987,7 +4015,11 @@ int pci_dev_reset_iommu_prepare(struct pci_dev
> *pdev)
>  		iommu_remove_dev_pasid(&pdev->dev, pasid,
>  				       pasid_array_entry_to_domain(entry));
>=20
> -	group->resetting_domain =3D group->blocking_domain;
> +	group->recovery_cnt++;
> +	return ret;
> +
> +err_depth:
> +	gdev->reset_depth--;
>  	return ret;
>  }

I tried to understand how this change interacts with the use of
iommu_driver_get_domain_for_dev() in arm smmu driver, but in the
end got confusing. Better having Jason take a look.

so far there are only two uses:

1) in arm_smmu_set_pasid():

    - if cd is not enabled and sid_domain is not identity or blocked, disal=
low
      set_pasid() probably due to the fact that enabling cd in ste could
      break in-fly DMAs if they are remapped

    - otherwise, enable cd in ste dynamically and set S1DSS according to=20
      identity or blocked

2) in arm_smmu_blocking_set_dev_pasid():

    - if the last user of cd table goes away and sid_domain is identity or
      blocked, ste is downgraded to a non-cd format by re-attaching to=20
      the sid_domain

Now a device is being reset. No parallel attach_device or set_dev_pasid
requests are allowed outside of iommu core itself. so the only invocation
exists in pci_dev_reset_iommu_prepare() and pci_dev_reset_iommu_done().

let's assume the device being reset has pasid usage, i.e. ste is in cd form=
at.

In pci_dev_reset_iommu_prepare():

	if (gdev->reset_depth++)
		return 0;

	// now iommu_driver_get_domain_for_dev() returns blocking domain

	xa_for_each_start(&group->pasid_array, pasid, entry, 1)
		iommu_remove_dev_pasid(&pdev->dev, pasid,
					pasid_array_entry_to_domain(entry));

arm_smmu_blocking_set_dev_pasid() sees that sid_domain is blocking then
the last iommu_remove_dev_pasid() leads to cd-format ste downgraded to
a non-cd one.

In pci_dev_reset_iommu_done():

	if (gdev->reset_depth > 1) {
		gdev->reset_depth--;
		return;
	}

	// restore valid pasid domains

	gdev->reset_depth =3D 0;

Upon the first pasid, arm_smmu_set_pasid() sees that cd is not enabled and
sid_domain is blocking then upgrade the non-cd ste to a cd ste.

this is fine.

but then I wonder what is the real value of iommu_driver_get_domain_for_dev=
().
w/o it, above flow just skips cd downgrade/upgrade in case group->domain is
blocked or identity. No correctness issue.

But with it there might be corner cases to pay attention in case iommu
driver calls it in other places. e.g. Sashiko [1] pointed out one potential=
 issue:

"
Incrementing gdev->reset_depth at the beginning of the function prematurely
exposes the blocking_domain to the driver. When __iommu_attach_device() is
called above, if the driver's attach_dev callback uses
iommu_driver_get_domain_for_dev() to query its current domain, it will obse=
rve
reset_depth =3D=3D 1 and receive the blocking_domain even though it is not =
yet
attached to it.
Could reset_depth be set to 1 only after a successful attachment, while nes=
ted
calls still check for gdev->reset_depth > 0 at the beginning?
"

and the code comment in iommu_driver_get_domain_for_dev() says:

        /*
         * Driver handles the low-level __iommu_attach_device(), including =
the
         * one invoked by pci_dev_reset_iommu_done() re-attaching the devic=
e to
         * the cached group->domain. In this case, the driver must get the =
old
         * domain from group->resetting_domain rather than group->domain. T=
his
         * prevents it from re-attaching the device from group->domain (old=
) to
         * group->domain (new).
         */

It is not related to set_dev_pasid() at all. Likely I missed the real reaso=
n
of adding it?

[1] https://sashiko.dev/#/patchset/20260324014056.36103-1-nicolinc%40nvidia=
.com
