Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4F5357CED
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 06:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783059713; cv=fail; b=aoczVPCXLuNalvAxwY5RRc+27DHxEL8HIMKICu1XJSfWYGPTUta+wdfH2A97gP8mxC+zanQS8i19h0tspr23lrhoJcdZaprhAomsey5fVCzC4ktu49IUVo/M1huxAj36epiWzghKDlEZzNFdLURa/8K0NHaeJLxnryA0TGMkqDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783059713; c=relaxed/simple;
	bh=btywKxpZcItyH5IO6FpHgsjMHt8QgIyM/7FdiRhyWBM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uWB2keXIBmpl+58nuGej55PRIK+u8H9SYJ65Xcn758vGz4UqR4Sknl7f1VNGq+NgJ/8BxXivgbE2k+0vM7evqx7Sz2b2omqN1fV0kAjdutB71KoqoJ5pNjCm4JG59LsSYKZoiZoec6VSFgsFxG5VYu1D6oJ+aX045CvZvXCXoso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g8odlIf8; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g8odlIf8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783059710; x=1814595710;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=btywKxpZcItyH5IO6FpHgsjMHt8QgIyM/7FdiRhyWBM=;
  b=g8odlIf8SH9t8/MzEiR5z7QOWlK1c84wDjqk0QtWr0cFs1995OkXFH1L
   PKZd3ja5nwc+3YDcNIZSxwEgZ5uaiyIZ1BTNukCpkUO+BcQiDNe7Vd69A
   VYPoRcva6Nybz1mniszSYHR82JHpmmaF0396zS9CbtYAmZwcaCpb4eVrK
   T8/4n0atcE6XnPEu3xoVr+b525le2pELoBN7uVmxRjnL3vRJWe6U5qvlz
   H2DqnMGiUbKnbjv2otTNR9eOp2SQYOFPcCTzUEeZnSJt3nS2RclIgKjgb
   HQqh1tiqx6lv0JTw57HhMFXGKTCiw+NqtokKUMnom93RcVEMbeNyLEcL+
   g==;
X-CSE-ConnectionGUID: 1eHvapF7T5OJHHyFgGU65A==
X-CSE-MsgGUID: YCqlFhdGRtuDx5LFafI/FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="94167300"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="94167300"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 23:21:50 -0700
X-CSE-ConnectionGUID: /YWywjWaTiOLUPhMr52MlA==
X-CSE-MsgGUID: dg48QvtAS7mi28lufYYuYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="291162702"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 23:21:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 23:21:49 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 23:21:49 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.32) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 23:21:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqfT6SASg2b72Wz6xYV3AfVYrKUdjumdQRfgMu4Xxu/PsEn9qDc7Yz3LH6EClesYf0+MQstGmHZbmF7CMmHAotswb8ZlqqUPP213dzRgLbQ4l1O/75MQGWrviiyKXChqnA+Sd8swjr60vfH8J88ojeUyoQ/LgjXNyZbI2n/5JsZhyr/CCNxIhO7pvEgo9LEaN6iL8UUPD7WCcwFZ2BB9e9rVkQLECJ0TXy0p4ZRmfAosxGOPA8RmQ4Im9GP+vKvJwQYl6uvVoI14avwum4BN2kZAtk7ds/YO92ymzh/FhSfZvuze52p0b9zJnVZ/lVco01YO1ft6KxtnG14Dfim+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qeKC35JQ+87d7SdfLokXilMiX+XXwIJBIk7FsiRASA=;
 b=SIdigj/0IRAuNQOdD6T2EFH+D09WKAFLUwqrPalAXsrb2gqLXJRG3mjEj+j7ajyRrxy0eFBgKMP6j3/jh0qAN8hARYcgzHUo+ecdpLBUqJQDotJ4Vp0l4SMd8ta7kYm53dLGZ+r8ppiX4heIqTDB4jKWv4tN9wmOLqL2smnPN1mEFycsDBaau03I0On1p47WF8oTX97IZeuSzB5NvYzwo2uXoTrlOSsMHnuyhz8JzE5I27hR7JGeX3/yf3qQ2DSFTNOfqHJ2d/nY8Od91/ULEysp1/dzlG2jc8nhRXc2eLidJCwX4tkB8FYcqQYAYS5vMnGQ6jokSpAPgChdl/kD2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by PH7PR11MB8570.namprd11.prod.outlook.com (2603:10b6:510:2ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 06:21:41 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%5]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 06:21:41 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/5] iommufd: Iterate the cache invalidation array in
 the core
Thread-Topic: [PATCH v1 2/5] iommufd: Iterate the cache invalidation array in
 the core
Thread-Index: AQHdCAyeGSVss8ZEnkGo/g2PJ4tN07ZbWBcA
Date: Fri, 3 Jul 2026 06:21:41 +0000
Message-ID: <CO1PR11MB483517B53ED516ACF324B2F68CF42@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <cover.1782767398.git.nicolinc@nvidia.com>
 <dc0c92e0688db085e12e0b6931c49384489da887.1782767398.git.nicolinc@nvidia.com>
In-Reply-To: <dc0c92e0688db085e12e0b6931c49384489da887.1782767398.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|PH7PR11MB8570:EE_
x-ms-office365-filtering-correlation-id: d07621c6-fad3-4c3e-2b28-08ded8cb58bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|38070700021|56012099006|18002099003|22082099003|11063799006|4143699003;
x-microsoft-antispam-message-info: 7FN1KF+AeErsY5UL7qSNKrxaMbPO3NrNgui663JpCtfT0Ca7xYe/+HuMcOu9zrgK+sFUecIIivteP5wZs84Xq0X5vqKWLzCK0m2bYVU3w9PK5Icw6W3wPSy813kT/XotfJqzNVF5NHGIpeCvAAxEXaA531Z1hu9Vr8cUAUf8bCUDipzp6MQFVgfErVBeFPO+Gywu3r+cP4Rntb5+tGtCX9khXAYmmeNIQYbofDKEHaPBRfjMZyNT0gWzKZLVTaqJX7f8IJzkJgpew7DzZBB6UJkmbC8sMyzAeiZ0NU36thkPhdex0XQHtmTMAQ3A9g3zvSNzwEr3o4T5+h7nap1bbVTpTpgZeT61Kfwcj39q7YHCr+/HDuqNLNya5TsfSqiPJOQffA39mkcgzGWX6uHagD7Z3aF+4GnLqdggJ4h1jRZ356b4qOEq4aY62X65pgeA2RjjTt3NMoZy/Z3TFye5Y3EE/Xb5U+trYLvRsGEIZ1bPU4Q7Iqswj5YS/xtQxTXIc3SEsM3nNC6UdBxTk45Zf45FG6aeFi2xH9yQADs1fDIdMOv0sbPa0L+qDGwQpeiOw+x9n2bBZiwFYvZ9qiyFLhYztGKd7eDwM6lnOkGbbcIXbYloe7SGUP32i/diAkH5C6fT3MruK3r7xh3v3BARF8g53zyzxXmLBMDwBlscFBvhxTmJJ3MCZ1zuKXd/nhNC0A5RKixJ93edh66M6PKdUsCZSocZ1Nu7QMUUzLAuX3k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(38070700021)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/2fFaVlamP6/Yot8jVjCyuza33vExSnYeKncXuoGKqh7ceTOfi+3BTv0Orrm?=
 =?us-ascii?Q?mb/GIVGx12o5q5N8GZNZ6231+bqo1Szg5D4O6WwdC0kxWPR4UfyUwbQKniT1?=
 =?us-ascii?Q?gl3MXPigzeBpDaTzY09uPos1VdKpVl4321Ja66jQA4cxZctrr3G8eKlAQvvO?=
 =?us-ascii?Q?fyQ8R3SCzKbJx9RUfjMsCpK7Sn1URKxm0RIvD1x1CZv73+LIgRbggHxjXeNP?=
 =?us-ascii?Q?rOGHf9yIVxrM7UkGWb6hzePrAloZhbbtv633dkrAT1awYsKL11b6AnvrlBR/?=
 =?us-ascii?Q?ajAfE9YxAlhdITYKwy+Lk38U+N5BYSH62P7CgZ2Ky3LKcGkghjBimlhtigLQ?=
 =?us-ascii?Q?a3Qe46soPFLEHMKsVszgaVl3WrMmr9L5OSTDdeOyvdnuVfnlUn5GhPsRa3ri?=
 =?us-ascii?Q?X8uPIkh6iXRkmKsPf7P0b9ieR59B1NxEnM60qAUiwCYII5pAdq/e5urU71Iz?=
 =?us-ascii?Q?+LNlzVpuwWAoc69KDpKGeVIx1WWfqr7T63iD2HE4I8ZasTdte+9EOaAwo0Mh?=
 =?us-ascii?Q?NOSkJ07ek5p6qo8dlIM3iULY+jE24flz6W6A9l54bjmCsku2LWaVoQawVEUW?=
 =?us-ascii?Q?o1477M7OSp55ihjGFGh8Uk1yowJTgB8osBcewgwEhNrgYtv01ICAxOkYcnDD?=
 =?us-ascii?Q?inY75UEwIN+5X+jeY2uevxq2nUFH7UTGOjA3SAD58Oj8uTxYGeTOqzRHpxVt?=
 =?us-ascii?Q?Oc3NQJMwCnsg8dXQd5svzIoaxQyVP9f6FIPWHVlOeunfZYlr10lXv0gm1ftp?=
 =?us-ascii?Q?TC3JRdOEaEpnfQhFH7SZSDlDP7vZU8w4kdl5mY5gY+u1rfMm5tn7tAlsWcMm?=
 =?us-ascii?Q?W23xuAhcgHKrjeucUwQcR6MiMUO6d5vhWH+oZkfbZOHwQKXHFE2PDfHzYuwH?=
 =?us-ascii?Q?pgKx6q7YlPVOLi4fnoXBF5MQaOAPsFOpRRPb7oU2JMUloS+ADfLHVQvmpiCo?=
 =?us-ascii?Q?MNyCAs0r4lb9G89jPM9HIjmFkK664c1yoB8+WSr+fWRIU0tiBT7FM0n2fx76?=
 =?us-ascii?Q?xqJYbM+nvKoQV2Zx7D8GQ5Kx/K+2KYG/Qt0MiDO1svHgVnCUjmzisNpWULsu?=
 =?us-ascii?Q?gJWsxQkF7bh+qsMV+10A/vDufvtJzuUuATRRAA1YGrpYEy17uFMmhHMtwW7+?=
 =?us-ascii?Q?qF1iI+RtMX76da0g5yQv3pqKuccOg/6Ygt5W9BlAQf+Ff32jdYhfec4kvkmN?=
 =?us-ascii?Q?k0p+PTHSqNzMsCbw+ZNUfqvM0ZrZ9ZKM1d06JfVNLYE5UrvlDMoyqNJqEc1A?=
 =?us-ascii?Q?J1O0youqDVLCPf/P6/NYSBqsJRCgey78WS+yCbt288zFDuyYNL1lco1JnagQ?=
 =?us-ascii?Q?uonxvVHZxS8z/YYmvsTNvUbeVd2sx/CQtMWxkPP5a9cbQf3I88wqA5Pzwdj4?=
 =?us-ascii?Q?hhcP6ZYBhN6kr0P/g1aGBrFK3SwTsb4HeFF63II3z1218ZJs6iiiqnnpeJm8?=
 =?us-ascii?Q?6IOdJ6+0MJl6epTvEau+2HXRXeH61OMyRpGobzFcrl1H51+TK1V7EsbguCSj?=
 =?us-ascii?Q?JBhuEo8UXp0xYBAdGFE3q7pXNveKfvfCZapByO+XMHtCvvo+lVS+PHk8YccR?=
 =?us-ascii?Q?EfRtkg3ODpriTAuwWMZST4ISH5N8vOli4eaKdNKaHCp3w6BXfN9VT5AptwH8?=
 =?us-ascii?Q?9qJ2529hDJKWp7vUwwMgbTNoeEUafStZRrQVzkis4nRxK+OOCvstkP1vfMUd?=
 =?us-ascii?Q?CzBtSoklvynrnAIRZIcLsMIPV7/I0wn/SABqDd7eu8So8VSF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kaDQoPu1Uj2JjQyYHs/sVK0YrGZhWMBS0Lq5uPa/DDjkLSvgDTTubrvF8xSqXIxrNUeBxpA+OgxaprpsribRX6Jb9AIGOIHncXb7h3Z315xC7WTNNeTgaKBflsnxvP7o9vA9otK2czUJas8xVsjZC18QJchDtyAVFiAW6K8psq3b6d0hnnXREcIjBjRdTzD4EfN7Z49h8STNNYvsuFUtYeBhfMhiXKdO4eFpB6hOFfy5PYASM+3elQ2AUE7aFHJCrVeD/Q+z5OQlAkowU3g4oRlV7j9tg+acasOzivgicxaJUuF6blZWSRROTV4eNIV1vC4oAntH+GDcl0TaXhVnig==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07621c6-fad3-4c3e-2b28-08ded8cb58bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 06:21:41.1587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: faVp1BlvYff5nOZx79iHPSqEOXdGOgjLU6UCOaV+Svik0/2b2/dEgTv8+HbdEq26BQATMRKfAnq9oQlA8esXOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8570
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, June 30, 2026 5:16 AM
>=20
> @@ -535,8 +535,15 @@ int iommufd_hwpt_invalidate(struct
> iommufd_ucmd *ucmd)
>  			rc =3D -EOPNOTSUPP;
>  			goto out_put_pt;
>  		}
> -		rc =3D hwpt->domain->ops->cache_invalidate_user(hwpt-
> >domain,
> -							      &data_array);
> +		do {
> +			rc =3D hwpt->domain->ops->cache_invalidate_user(
> +				hwpt->domain, &data_array);
> +
> +			done_num +=3D data_array.entry_num;
> +			data_array.uptr +=3D
> +				data_array.entry_num * cmd->entry_len;
> +			data_array.entry_num =3D cmd->entry_num -
> done_num;
> +		} while (!rc && done_num !=3D cmd->entry_num);
>  	} else if (pt_obj->type =3D=3D IOMMUFD_OBJ_VIOMMU) {
>  		struct iommufd_viommu *viommu =3D
>  			container_of(pt_obj, struct iommufd_viommu, obj);
> @@ -545,14 +552,19 @@ int iommufd_hwpt_invalidate(struct
> iommufd_ucmd *ucmd)
>  			rc =3D -EOPNOTSUPP;
>  			goto out_put_pt;
>  		}
> -		rc =3D viommu->ops->cache_invalidate(viommu, &data_array);
> +		do {
> +			rc =3D viommu->ops->cache_invalidate(viommu,
> &data_array);
> +
> +			done_num +=3D data_array.entry_num;
> +			data_array.uptr +=3D
> +				data_array.entry_num * cmd->entry_len;
> +			data_array.entry_num =3D cmd->entry_num -
> done_num;
> +		} while (!rc && done_num !=3D cmd->entry_num);
>  	} else {
>  		rc =3D -EINVAL;
>  		goto out_put_pt;
>  	}
>=20

the two loops above can be consolidated into one after the ops is
selected.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
