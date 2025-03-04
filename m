Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C49335BA
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075688; cv=fail; b=o/6K/QMdHIxqrW6CoO79TLjowmA0o2liRVIr/mbStxN1OaK6K9rG8NGuFRKLIiaTpgrNgeXwiHs7RGdpL1LG0Eed5WsrpxFujQ+CtLmzfH6gl+EpCoJVmmfjHm0alod86aYb5/TuYHL8qK+Tyyw8FoRA1Bqm5ZChg5NkRMXRAO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075688; c=relaxed/simple;
	bh=6TP6plSSvQHMmEk2h7mtUHqXo5y+z7CzG/wmcuUcPec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NreAbqm1In7c6gG6IrGS0gXe0QzxPQ4Z8umK3d/kxHAcy5BRMwB4IwuwA/6LHOWzQkSZZcfRDNnXcFiDGa99Tm3NkiXeuKMu1ewZ+5e6XKxbsAL5rkqcTcfzG5FLvlN+44Yh85ASthqyVIkwL3Chl22YM2/0B5Id6+fxicJvhww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nh8KFGBn; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nh8KFGBn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741075687; x=1772611687;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6TP6plSSvQHMmEk2h7mtUHqXo5y+z7CzG/wmcuUcPec=;
  b=Nh8KFGBnLta8mcvqMwJLus342cAd8ouItMDgwyOWHx3gAyERHiFOGkjQ
   ttV2XEnjnub9UcNaoe8OP4zLnlfwdWwkjoIzePM2z5FX2KIVqyWnARUvf
   E8R9eLuJcZt01m70fgL1k2CdlCV9BWIkk6yfdtBfD5yqnvbq8sT6PvcUf
   NreQTNRb4YVKLsWBSHKzzFuIFa/HqX4FiTbRBCJ/zElTq0C3dhfhNg0iw
   P+R1DlV/lYoBjqDsTSVXfjVpms9fy/oXyQnbMGyXE8DkX2Uff/GQDtphM
   eotBbzNA0ixqZbxA1dVX4y8fANRLV20v2Z/E5tlei3G7by1U1M27pbKO2
   Q==;
X-CSE-ConnectionGUID: yONnbsW9Qfiu9b2cWjiLcg==
X-CSE-MsgGUID: V8oyxEV4SGyzCoLTPPK1sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52618857"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="52618857"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:08:06 -0800
X-CSE-ConnectionGUID: I7ASb1oARoCRYYMAhW5LBA==
X-CSE-MsgGUID: tqB9pX4USq2/ONCOIjcrKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118314212"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:08:06 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 00:08:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 00:08:05 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 00:08:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0BDW+bL1SjbDHrcAKUkTl2tP7WI/+FLsOvWW7e/LGvH2+eRfGnyH2pobnTDgkgjRJp3nE67999Y4ORBSqPa9lqmAn2AEi1pZsrnN8gy6FpWDga4h/a1JGh9EPaILyTd0tQAlrEV+55GCa6o6zSgUsF0uFHEaCTfT7AxRy4P/lkA5VNCg5PxQ7nrndO2dOoeMLqcb7pISPeLRQpCovku5HnzGCvYdXBMImDSfFt6ryUQulMkIDrOkrnYo+JXCEeAkDvc/cXDzFWB90boSdaC6gPVANlRJ+95V/MpEGeLrYjIOTLDPBlYd8Ob7GFeE+kAYSJlkAurtwEE940UITBkbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71UbmR717IH7gMw5q2pNwEUMrP7XaElaUhwI8jlZuXE=;
 b=HqC/vLZMNcnijgxXj5q9vB93A2SuVkgwMbksXNad8LBi/XUo+iR+aK17LqDFZeEpnZ5BpeIQhMPhKiHVtQ1srVlJm8ZC+opvnE5SHZsMsVOH67E8orpUORWvP0VElxqH9D7blQzpOC3DbJ1yVKuxCUwKmrQXdG2TKMMw5f+uTcVvhr7k6hXvLqr/mRdI0nxNrBRu1cL4Uk1t7KDXtkIIh68VKWSh7hUoTktRPxwOs60+MktiefUt+77qCMRpGSGUeaz4AXcPzhLHBs8Sk8VF50dggu3gZ6QXfrDPGxHmw9HbenQ2WSxxNv/U1KFMiqkRU5MkxNjxaRrwRLDJTl+kBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB7952.namprd11.prod.outlook.com (2603:10b6:8:eb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.29; Tue, 4 Mar 2025 08:08:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 08:08:01 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>
Subject: RE: [PATCH v8 09/12] iommufd: Allow allocating PASID-compatible
 domain
Thread-Topic: [PATCH v8 09/12] iommufd: Allow allocating PASID-compatible
 domain
Thread-Index: AQHbiENELkm4am5+RUqgCVJ/UkvmpbNipqgw
Date: Tue, 4 Mar 2025 08:08:00 +0000
Message-ID: <BN9PR11MB52766783E53A987FA872ED918CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-10-yi.l.liu@intel.com>
In-Reply-To: <20250226114032.4591-10-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB7952:EE_
x-ms-office365-filtering-correlation-id: 48ce1c55-8502-4e81-89d6-08dd5af3aeab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Un0dhBC4T82xYRayC29809k8s/k9tUgpMTPoEtEnrgMsfhUwVfxY226Sx5c+?=
 =?us-ascii?Q?nNsJXIcDavevQYjCpSBjyv2W/TDi/KtbpG73Emp1ZL/wsvjdl30hiwjASVnB?=
 =?us-ascii?Q?dQ06bknRxfLE/01zqwlMK8c8DBlFCA/FUjFAOt3uaar4KTvV1nHQLtSjk6x2?=
 =?us-ascii?Q?/YBz64lTE3Y/ykfqLW0wJFH+ecaHIryPns1s3LogkhXJhftFvQIqE1XCSZkF?=
 =?us-ascii?Q?FCMl/8MnTRX/RjFbDTq51ycDn0CKPDRi0jscV5VqmZgb04n4rr/USUVWlJ/H?=
 =?us-ascii?Q?FW5ON6/t06pMAOoTRLaRETtfdYpn6gpReqW+t0qgFtR9j3pAzwaH1Q4B+6Ow?=
 =?us-ascii?Q?nMj03VvQuKr7R5ZsvMIRnd/TGIjlfB9cqEYn/ICcAkv35Oee7chhAixFpMqm?=
 =?us-ascii?Q?MWGuI2+YGO7vgZwmpoCZBqJ7XQIjB/+ZiXoIICUsP7GdD1xV1t025AJk3rKX?=
 =?us-ascii?Q?k7Y5EZ1AwUBkpEsQ045qjJ4AQZdyi/KEoRycMZLLTNEd4lIjaC8+8B1HWPZa?=
 =?us-ascii?Q?GPlpSLJ91+S2sTnWnYDnglKpu4KsSMmxs5kOK7OyPkkTwYmUahmqXKa1/PES?=
 =?us-ascii?Q?39rlAaAE+us8P6QzpHsmpv2PtRE+kLDr8P1vZve3BBX2l8UlunjLK8v+YMir?=
 =?us-ascii?Q?/JcopwG0DbLGV+1c4ZvOzien2FhshyFCU1Xw9QDmFEnUVt+Yy/GAXwfN409c?=
 =?us-ascii?Q?ENtLu3l9+Ooh4+5Z7OC7ui/SFJ103ybF9Uvcprl1EgwSPmgOk+G+Ys5ufpOA?=
 =?us-ascii?Q?/iIoSQWTIAQr0Ox6yokcawtBSacQcxORP6ArrU3UzthzVIY1a0N55jRp7G/Q?=
 =?us-ascii?Q?JZi7vi65uX98qm32ViRMlp+Q41yA9mMNzQKtfTD+knO18hSz7jQaGZFY2ZjU?=
 =?us-ascii?Q?JVtQKNlP7sfNnB/9U+YoHd65Z+airLNZqVr/SL6LjN3DiY6YsXox1vBsWvhE?=
 =?us-ascii?Q?sjoBcLL5cPP4dz0GkBsOX/oWPu/0OcM0ujoQRY6hMPhSaDg7aU9KlF6bpSSK?=
 =?us-ascii?Q?I/VaYZm9JNDvALchrPD6QR8BFaH7mkrwsLijZK5aS2jgPwrpin8+T2aEUCAL?=
 =?us-ascii?Q?PAG3pkjxE443/ItlQCsT15Qbd5B3vvy/yboCLduFEqz1GZZGh8FuHhDQwUCm?=
 =?us-ascii?Q?tvYgFUP8lb+ks+csFPgL2WwDZGU/hmjfHDoW/BaRnKzbuIvyAjuqucJoKYQ/?=
 =?us-ascii?Q?TZdwJA9wQOKIjl0KZG6qmdFgU0JDmVz0SNfTysaIzim+qfVTogDLEeP+qXui?=
 =?us-ascii?Q?s3qxF8OiPwOSR6iOw2CJ2CBqNamwmggMe8Kgin1FGDz5gjULmCccGMcrjBKF?=
 =?us-ascii?Q?m7kHY1LM5I9VjKl96zM7ohcA1lOJwC7+5sGKAos7mb0Fa9lG4zi6g5u3hv7M?=
 =?us-ascii?Q?fUrbx57rEBOd9CEMBDf5HILlAo+jKaRteoFEGYd14QqU4f1vbUVatIwSXY53?=
 =?us-ascii?Q?A2txWxYN6sy/45Dvfv9sUqR11E8QVwu7?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LrOCh/brUXUltp9K7/i/fjEboeAeLPRaraj4U781eLxzm1qFg0UQN1YdoezT?=
 =?us-ascii?Q?v523Wg64Jjsb5uBZSDZZa55DRc5rCKXWT67aNntawtFrkH73hxfKkVXJZZ93?=
 =?us-ascii?Q?Y7+a7Qg4G2bCHgAPjkA6AD7EMkTbDvUJR6sgGNgoqhSISuWVlcaM69cL5bb0?=
 =?us-ascii?Q?CoCpqjNQ4P9TqkpXSZuv52pL/1jYT5y1z70quQKlrgEoCwdIohERxPZazngg?=
 =?us-ascii?Q?JAwtgWFJZMXMx6WKeUXpuA7AElf/E7r++Du6svN8Rr1rM7vzl0GbECTGR7lA?=
 =?us-ascii?Q?fb9wUVrvpgvQPAUBDDsKegzJjZ/n5KvI42TxYjOhwybinKGZZ58Ue5ezPY2N?=
 =?us-ascii?Q?a3KXEkvoDBqwwZA0KvquaRNfY7Ur9udBq1w9Hc3Ax2SRA4VTnBgL/PO7UGyN?=
 =?us-ascii?Q?7AWppSJASIj5OxbwuHoCYCA/dIjXOfYiR4rewuLlaa5M/YFFx9LpstktszZB?=
 =?us-ascii?Q?fLRCmXP2R35g/w8zuTMaXR8ZqS6AnvvncwltL91mMWfCI7HGVSPg6/5j1t0O?=
 =?us-ascii?Q?yLyx2xjMAm3PFx69E6F5X4Ukk9X0uUpGpkdkeBqEH+OiJAF0jXq45MPSgSvo?=
 =?us-ascii?Q?w925zu2OjE39dxzew2LzdJtQ9CXzvcNYmUolyIZbFYzzWgKQvqPufFE/ksOg?=
 =?us-ascii?Q?Iqudr9qEgpqc7VaZZTsW6T20mCUCNmv/QoV49kzC3KV8u3dK+lroVfi4J40d?=
 =?us-ascii?Q?gOLGve4JOmoRqtc5h5F66sdAo9wPA+cIYJWoBKnBXkpWxDM2Wf6ATOXcN1vj?=
 =?us-ascii?Q?LliKjREgJ0e/S+Lkare/QDK0H5NCxy2PjsbXLo8UNYJy8yp9iJWQgNFIRvEM?=
 =?us-ascii?Q?jReNJC5ovHAGp8mLUdpuNF1ysiLBvlCgBe8JrzWg4jGtTznv860+QgA8mDUi?=
 =?us-ascii?Q?CNJa3BEz/1hTtl83K+LyXkDN3QwDpd1oSp4nk5LPvDXbVYLa2NnCRizs1ibK?=
 =?us-ascii?Q?8v95NpvvMYtL+JjJdv5bh0IXPqGyArgiH5tfW3WgYKUr5exdVPa7RlkLc+cT?=
 =?us-ascii?Q?5A+6nGMS2GtRqh4ce3av63fhUIsIF5aUPYQdEwrSBxMQRFVN1ykU8cAfFT8x?=
 =?us-ascii?Q?sKmcRXd3G21rfO17ZU72u7HWwZxDnVGb1P7R1P/EcFs5eXypOb/7GxB+rctZ?=
 =?us-ascii?Q?czqWvk0W6BQ9MRkZM/8mpBw2KToHBe/MZNIKvkBQcFo801ghuB32IwwN85TO?=
 =?us-ascii?Q?Aerp+dPpMX19b7NIV1+6wThgEB9cerEimmVYHyhJerqEFX3x4sJGcIpSo2Yf?=
 =?us-ascii?Q?2ftcpTyDEhmfcSuly1gmriLAsxO1Wp2QVHSsCiAVF23EOuh+WE0Ar17VDbOi?=
 =?us-ascii?Q?DRLlwx8gLcR1z/eKG2KdUP0xkKtpy1DHyK7b7oDCOAT7y7IVKjcmx4S+Ij1A?=
 =?us-ascii?Q?hxBg18jkLFRvXqwhFjEwuK/qIUiO/yhnvFHMmxohkMUdrCT1o/J0WyIKWOLr?=
 =?us-ascii?Q?VIUeSw+vpipYXbSnKRq559KhyT+ouEoCLgxn6YNsPnlFRMkLEWd+9iZs/hov?=
 =?us-ascii?Q?6vqEWeuHvYuOQHWH3lqkF6t5Q4BtaMI/Bqb1TK8g52egzxpQrP0/SGZQ/EE2?=
 =?us-ascii?Q?cjjRVP2mChMQnSenuQxn4kt+lrZtN45vrIRxfCb1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ce1c55-8502-4e81-89d6-08dd5af3aeab
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 08:08:01.0026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6jGjFayq+yyVuXb0ipsYiYwf53VogJwbE5g+KplihauSifb14IDuA9tyYUBB2fs4ZI76rLAmdbG80Q4++A+RuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7952
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Wednesday, February 26, 2025 7:40 PM
>
> @@ -735,7 +735,9 @@ iommufd_device_auto_get_domain(struct
> iommufd_device *idev, ioasid_t pasid,
>  		goto out_unlock;
>  	}
>=20
> -	hwpt_paging =3D iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev, 0,
> +	hwpt_paging =3D iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev,
> +						pasid !=3D IOMMU_NO_PASID ?
> +
> 	IOMMU_HWPT_ALLOC_PASID : 0,
>  						immediate_attach, NULL);

According to patch7 we require same ALLOC_PASID setting cross RID
and PASID's on a device. But above change attempts to break the
rule. Once RID has been attached to a pasid-incompatible hwpt, attaching
any PASID to a pasid-compatible auto domain always fails.

That essentially means that PASID cannot be attached to an auto domain.

