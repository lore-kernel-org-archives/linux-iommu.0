Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91462D7393
	for <iommu@lists.linux.dev>; Fri, 26 Jun 2026 03:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782443543; cv=fail; b=W+WmfNSZENYo940uLCB5goiuwC3K/UbC6bCPgi3IEPy2szY7aR1XW5w3X2fI4En2u+idGoX6Irx3xJoWWHhSsHc/GVT/V6Weepew+Mv5e+4rnf7E7k86Jcqoj74lJjve68gYVBJd1CPm8iGer27mIUfSF+KpSrpjkdrug/I/85w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782443543; c=relaxed/simple;
	bh=KXxD+4My/kR8tE6pngpUKbujNc8MVAAPVd5NVZZUjhs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mqcjmd5hSx9HFjL1HpwO4ZCA4X+7iCKOzWFOSwo1a7KHewBI11lQlkrin6JnXEnx7M/++GYwrRNRTzxxlIJuUY/0/SwLtrMm2LyDS+PtyCnpcRY6rfdRnsHrEII9eXnJB0uqiNQaSqAoWSTYX729vRjZbm0JLjSAPCXHZtR+WOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tp0IKUYZ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tp0IKUYZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782443542; x=1813979542;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KXxD+4My/kR8tE6pngpUKbujNc8MVAAPVd5NVZZUjhs=;
  b=Tp0IKUYZtMYEtGL+TLqfug0JXt4xgX4VQh7kMDUKGLqC211+xTot/KYu
   aR0Zjoe8EBhgNgtuNpWaIcuEsoVmOI3I6wECbkBxi2Lm6M8F/7xE/fyT0
   q3XjOBgjUWGnKHv2B9R7o1c/HwiYBT4bSZ846efAb3fWJQuLcMvtKHbYO
   2hxZcUVRp7arikbUdCa2fKmeRylz11cEe3p7Fxx/iv5Ve+k68Ouf6Z7u+
   utnBZOxfc63gB9Do2nPf37KZcoq6AJY8LY1bfl1ADKMWZEB0gbaG+C79f
   ZTWVEEFtjX8qfdkt+xVnYMY4BY2ecYFWdmQ3h4mNU5dzvqvdjboqLYP+x
   Q==;
X-CSE-ConnectionGUID: kdQxK8AFQFStqC8DNx3z3g==
X-CSE-MsgGUID: +wQEFBSRQ2Wt0wjF146ZYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83248562"
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="83248562"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 20:12:22 -0700
X-CSE-ConnectionGUID: +LdcMf8iREuRavHchhNnyQ==
X-CSE-MsgGUID: cbmvY/jLT5yXp/hMAtXRnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="289320161"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 20:12:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 20:12:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 20:12:20 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 20:12:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5I4vRJ+HbQbMFr528cHZoPikZgpuRo9tG/FhclfckcccOtM/uBqIXrts1bvjKNc+WUNSnWikMM/e4ZSIA/0fQVshn4dyQAyR3WJKyjnPuvsCjaFqMUZF9BdOwkHcDqIAGzgPRKAOdxbKz82BmJZcTc6QWbCsgy/CK8q/yW1maziXiJJF94fPh7P157fB7Pqp6kIX6kOEgmQue58F3zn3c4RELldAg/+FDVw4S5EdkosGDbRRMYjhwaTaUS6XMUR84Q7l6uKbLWHLRmPZSq8Wyeri1yiz7cZRtH/mCtDUeUlcAFh+XR7JzaLJBbRiI23NvEJNLUyCOBz/wkgLARZ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQ3tcmC+C/A7q5I/OJdxpMJIZaD1+D0y6tfN5xHRQZg=;
 b=aBODlAcXtBHGvg0IaUa4whrxkVdw16J1L0gxm/V/uCgm52VTKsWn/luoCapLI9zJa94NLAFYxf1TBwW1yJOBVVxG9p9RspAPkzuJdJTZYg3D5O2E0XzChRQlS2qeO3bRLJMkB/CkguCVPuILg57HclxCvDBhQVwfQwudjOiWHKvxPW5vMQQqtF8ZVCbs53Nd8EblIEAB9PSrJvj6glVW23eyysCX/PByoHLMjorXpEHiQY62UzXtEBJqc3ChKutpNYQD5Rjraz7KMRCIMGpyZSKLekQDEg7I+EEl/FQSupfHq/8xC6neO34gH5NvJu9JaPKIv0HtY+p0wZo+l6UK6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8498.namprd11.prod.outlook.com (2603:10b6:a03:56f::12)
 by DS7PR11MB7888.namprd11.prod.outlook.com (2603:10b6:8:e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 03:12:13 +0000
Received: from SJ2PR11MB8498.namprd11.prod.outlook.com
 ([fe80::8db6:d449:e492:308f]) by SJ2PR11MB8498.namprd11.prod.outlook.com
 ([fe80::8db6:d449:e492:308f%6]) with mapi id 15.21.0159.015; Fri, 26 Jun 2026
 03:12:13 +0000
From: "Du, Fan" <fan.du@intel.com>
To: Michael Kelley <mhklinux@outlook.com>, "Miao, Jun" <jun.miao@intel.com>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "chenhgs@chinatelecom.cn"
	<chenhgs@chinatelecom.cn>, LKML <linux-kernel@vger.kernel.org>, "Du, Fan"
	<fan.du@intel.com>
Subject: RE: [PATCH] swiotlb: eliminate per-map atomic contention on
 used/hiwater tracking
Thread-Topic: [PATCH] swiotlb: eliminate per-map atomic contention on
 used/hiwater tracking
Thread-Index: AQHdAkGVG27dVNXNe0yyBQUhGJEOBrZLbVMAgANqNeCAAJmZgIAAr8Iw
Date: Fri, 26 Jun 2026 03:12:13 +0000
Message-ID: <SJ2PR11MB8498300801245B279182EDE799EB2@SJ2PR11MB8498.namprd11.prod.outlook.com>
References: <20260622122114.2563254-1-jun.miao@intel.com>
 <SN6PR02MB415757A3F56268BE3AF01D35D4EE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SJ2PR11MB8498277BE45D32A81ED07D9D99EC2@SJ2PR11MB8498.namprd11.prod.outlook.com>
 <SN6PR02MB4157761C37193172603E6AFDD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157761C37193172603E6AFDD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8498:EE_|DS7PR11MB7888:EE_
x-ms-office365-filtering-correlation-id: d7becde3-8e81-4f95-ad4d-08ded330b810
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: +6zPddnJczWK7Z592B2iSRIuJhf07yXWT/s/Bjd16TTddk+URih3MWOGgu+L8FlDnlQqkAPYvNIa1NOikBCsHEDapr29HWrgtnZcB5RvJrBps1/bg2ptCxe0Suiaxr5KmGWDLjA4OMYfkPgQrHPzeLY60NpA/i6ZKeUbFxiaZXQYwJ1QII47HFebpso+0VqDdn4JJEHdFczJ4iWRXc9DZgjj6Hfl7Hw3XK+q6LVC2A8lCM7yYZJrVHlpvBUbKKoLawKtPUheBGo5Hu0+Suj+Jh/7jVre7Uf47SaaAdrGbj+ocRIPDize3eMiMEmNL4WjiV0tG2ROHK7bksMjt0JoCzA6TzeFh3FL9BL0ACErsKCpZn9z2gHY4ll7Rj3nGLKb63Bdw3lihcqLdw3/z4PpoA0xjgFHxn+tBJvNv5pCtx5ILmUHo3bZQc8/BLbHM/PMK5zWSUWevmbcHXvP/Cy+tIa7WgXwMdON2+qFy4cvVvy5LDbrYnWduFuiWGPBTmOKS3Raz3YJB/Umc2A5S7TxcQpWVnRuNv9Vap0Vo9Ice38H1pyyN2Jl4humUmZTZp+SIgxldXCmcG0Bhvbd0diIxKLfhn6kiYitf77iMYFjnTBIMFsJYcAABk/Ptpme28XfzaPCNzAqMSlq83oepLkZfhH+00kJVl88Z23o5tjfA8dBKoAI/z8VBtPfyHP632SJ0KV+SbS0crgX5VLBOLlEzfcoS7MmXlffCY4hJrkhhUo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8498.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3S2rH2o8ka6Fm4sMCXDyvRwBUV0M1qFT30s8ls+rGt0tCdVVdE+7IVIDpRXk?=
 =?us-ascii?Q?yfkDz7ZfCKsAvE+FXJSVRbasH9dCEu3836nlLG7TmyWUinHsdrqQEYRVN0yg?=
 =?us-ascii?Q?k6Oq6rw8YN4JexZSQNZrzPOmv3pfVG8lCIWe0GNdINTejI6H4GEHHqMnEZ+Z?=
 =?us-ascii?Q?naFWPCiJJAPlOj8T0xWL/h0pce9RdbvutGzM4EYma4uxIxN5Jxx0KgGL5VIB?=
 =?us-ascii?Q?NKWzfsfVbLLZ+eYYVRldcLBQMcVsO020/7qYBO/fZHJ7SK0CRuwxiwOR2BWn?=
 =?us-ascii?Q?DvSE0K+bTHiNF6NBZRTnu9iAmt3GdFJiIS5mAoy/ViKQLQsI1VSkXYdyXK0g?=
 =?us-ascii?Q?1RiuAk5YnCHCG/mFT2H2PxJL21eTokdlkgBpgBcVm5Sec7BnT+Z0OgF+1UC8?=
 =?us-ascii?Q?I2qlcSv5w3a84b7VHv7mnAESvPH2OfUtfXhSxwbz75RYejZUmiuG3aOlMyjB?=
 =?us-ascii?Q?AHphCZjnpXIQDf6f355zMFL9DDM+VXCkwHTjSDrpGH2qVYBo+BP3MfxdJMad?=
 =?us-ascii?Q?E0UGbRqezwq3aTHfLbyvmGErwy+Pj+cFo7Q1nbmN6Vg46bZ8rU369hnzBOKq?=
 =?us-ascii?Q?OMNm8AGUZa6bIyan8lB4LSM+SmNr5SYhi6byJL63oHGxUBUZKs9ppQO3XAsX?=
 =?us-ascii?Q?6dBYCI4Uuj5UupLuUJYxwY+yWy+v8ivQsaM0YEl6O+pBXxlqVxtdlI+bsEP0?=
 =?us-ascii?Q?AAQa6HOANgOb1xLhM9PJnUe9kkJPnRaIB/W+sPJNbePlXHVOD79RWWklEOHe?=
 =?us-ascii?Q?u8kNCXuXgIpZwXAMrdO0RqHXhaucDoytLh2Psh4ObUvpaEaQcncFEENx7r9P?=
 =?us-ascii?Q?r1Gj3gFfhH6rDjySx1of3lQ2ty6p73PCtquigNbrkHSJDAvYB1i0N28+uT8/?=
 =?us-ascii?Q?zKxwWfjEStuFrBVjFGR8C3gFmgP0NRWIoMwaP1hfzx/KIv65vNoNRHcxcnh1?=
 =?us-ascii?Q?/BW1BHy0LRkFa8TrYnvT7JGvhEX5PbFsEJOMM24E/o0l8MKVCtC2SE7FLCj1?=
 =?us-ascii?Q?gX3kC/Stq4cWSimsSU84x073dyN2gcPP5VQFOpLdSMW8DiGBYM+v3j4Nt6ZJ?=
 =?us-ascii?Q?2fe9SowdYUHhjncTyiY5GIKUoLz5qDRgmKjgiFVj+/KRjPLh59RBroOdhzPr?=
 =?us-ascii?Q?eH8Z5kZeXefiODiDgVC+ys6Q6VfdFy0G4wfsCc7EuPbvBuJDIN9Ft6myd3RX?=
 =?us-ascii?Q?op4EySl2MFTagsooV52NdgVbDPwmsvOh+iEg3eQOSUJK1zEHzf4U+je9GExM?=
 =?us-ascii?Q?1z1OGDi4p2jUvptdZcBuHgr+jJvtfY3ZP43lmShzrRMcIpa2wjOBlJTDtnwT?=
 =?us-ascii?Q?kNDNlHq5BKPj8bgqas1+vmHqbR5epRmVAJH7elU1HS7wKCAy0fEz94p9kLsf?=
 =?us-ascii?Q?XBOxjGEDdFpGK5okbmuFAs2LJi8nh8EXUaPo+kVrn3b2P8fKgV+k5lyuCZpJ?=
 =?us-ascii?Q?9+tPG9ULZGpgZy9uWdCw8XOsb1E/L8HhNWdypwEkIRVKLZP7OyRDlWbaMGep?=
 =?us-ascii?Q?1jrhqFu74BXze1TBibpJrgSay5q2dvyCmqIDSupgE70wqF8cjMwNoY2viP5D?=
 =?us-ascii?Q?1hdwes6Q1c6UW/vVCS/OBs0XcUfY2PKOI4KF3O/8e73xNdssKCZHGg41eFRx?=
 =?us-ascii?Q?L0OFVQAk5fO+IiXZJVpUp5VZ6eVcqUUunAe56aMk8Kkou5iC+jRoar46TPJb?=
 =?us-ascii?Q?XxMfK01tu4FonWx256uY1RKF93Zg2aKZg7YBm/Wj/wk98EFi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: l6Nwlyr3cNBPTzXYsPKrKuIukbEMScm0viG1M6J1gdn9b1SInxK35cCq2YY4cdKn5yGi2G0TYOwX2ZbRNsXMgJFe45dYQjIll6jriO2UOVP70CHw86/g/f85/Sr88l7FFuz6E60zjQqikJ7k6myYx1lcv6YgWN7CcTV64YRppafIwbiZG/xbApAmChbcBSvBMj6LyBHsLsVUR1wq5tErKU5DBRYz2SihKiMUnaNI/L6UWT15x2VfM3TSOsZEkWwF0StLNdU3SW2Jv6m7CvsE4xoDXlVSPjyLkOGMZnKqZDLGv508sPzIiJmCzOnExBLvFvubTXm1Z5m5ZFxbKf/4fA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7becde3-8e81-4f95-ad4d-08ded330b810
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 03:12:13.2700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ffvHftuYXnaayRqdVr+s2FHF1tVSvvnTWwROlR9lkKMGG3mROF7pf/9WxmqKY0Br/ETSJ9WMHKSvAe6tBGk0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7888
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Thursday, June 25, 2026 11:54 PM
> To: Du, Fan <fan.du@intel.com>; Michael Kelley <mhklinux@outlook.com>;
> Miao, Jun <jun.miao@intel.com>; m.szyprowski@samsung.com;
> robin.murphy@arm.com
> Cc: iommu@lists.linux.dev; chenhgs@chinatelecom.cn; LKML <linux-
> kernel@vger.kernel.org>
> Subject: RE: [PATCH] swiotlb: eliminate per-map atomic contention on
> used/hiwater tracking
>=20
> From: Du, Fan <fan.du@intel.com> Sent: Thursday, June 25, 2026 12:30 AM
> >
> > > -----Original Message-----
> > > From: Michael Kelley <mhklinux@outlook.com>
> > > Sent: Tuesday, June 23, 2026 10:35 AM
> > > To: Miao, Jun <jun.miao@intel.com>; m.szyprowski@samsung.com;
> > > robin.murphy@arm.com
> > > Cc: iommu@lists.linux.dev; chenhgs@chinatelecom.cn; Du, Fan
> > > <fan.du@intel.com>; LKML <linux-kernel@vger.kernel.org>
> > > Subject: RE: [PATCH] swiotlb: eliminate per-map atomic contention on
> > > used/hiwater tracking
> > >
>=20
> [snip]
>=20
> > > > +	pool =3D &mem->defpool;
> > > > +	for (i =3D 0; i < pool->nareas; i++)
> > > > +		hiwater +=3D READ_ONCE(pool->areas[i].used_hiwater);
> > >
> > > Let's ignore the SWIOTLB_DYNAMIC case for simplicity. The approach
> > > of calculating a separate hiwater mark for each area, and then summin=
g
> > > those per-area hiwater marks, can produce very wrong results.
> > >
> > > Consider a 64MiB swiotlb in a system with 8 CPUs. There will be 8 are=
as,
> > > each with 8 MiB of space. Suppose the workload putters along with
> mostly
> > > smallish I/Os, say between 4 KiB and 32 KiB. If each area has 16 I/Os=
 in
> > > progress, the area hiwater mark might be 256 KiB (16 I/Os averaging 1=
6 KiB
> > > each). Summing across areas produces a hiwater mark of 8 * 256 KiB =
=3D 2
> MiB.
> > > But then suppose a 2 MiB I/O comes in. The hiwater mark for the area
> that
> > > handles that I/O will grow to 2+ MiB. After the first big I/O finishe=
s,
> > >  another 2 MiB I/O comes in that is handled by a different area, whos=
e
> > > hiwater mark also goes to 2+ MiB. Pretty soon all 8 areas have a hiwa=
ter
> > > mark of 2+ MiB, and the total hiwater mark is reported as 16+ MiB. Th=
e
> > > old algorithm would have reported 4+ MiB, which is accurate. With
> > > higher CPU counts and more areas, the discrepancy can get much worse.
> > > This is a somewhat contrived example, but the problem is real enough
> > > to make the reported hiwater mark be unreliable.
> >
> > You are correct here, I like your way of thinking.
> >
> > > I'm sure the contention for the total hiwater mark in the current cod=
e is
> > > real, but it's in the context of a lot of other CPU work that is bein=
g because
> > > of the bounce buffering, including copying lots of data to/from the b=
ounce
> > > buffers. Is that atomic increment operation a bottleneck even in the
> > > end-to-end context of doing DMA through swiotlb bounce buffers?
> >
> > Practical benchmark show case the highest IO performance for each TVM
> spec.
> > even if a few iperf (4)workers would cause the contention here.
> > My guts feelings, yes, the real workload probably hit the bottleneck he=
re.
>=20
> Just curious -- what is the NIC in the TDX VM? I'm most familiar with the
> Hyper-V case, where the NIC is the Hyper-V synthetic NIC. That driver
> uses dedicated send and receive buffers that are allocated and decrypted
> when the NIC is configured. Most NIC traffic goes through those buffers
> instead of the swiotlb, so I probably haven't seen cases where the swiotl=
b
> is the bottleneck for NIC traffic. I do see the swiotlb as the bottleneck=
 for
> disk I/O traffic, but the data copying tends to be the gate rather than t=
he
> allocation and freeing of swiotlb buffers.
>=20
> >
> > > Another approach to the contention problem would be to have a separat=
e
> > > CONFIG option that is narrower than CONFIG_DEBUG_FS, so that the
> > > computation of the hiwater mark can be dropped entirely in production
> > > environments. Or the setting could be dynamic at runtime via a
> > > static_call, defaulting to not computing the hiwater mark while still
> > > allowing a sysadmin to turn it on to see workload usage of the swiotl=
b.
> >
> > That's counter-intuitive from my perspective.
> > With global counters, the observation, which itself impacts the
> performance,
> > wouldn't be able to tell the practical characterization, that's commonl=
y
> lower than
> > max performance, in turn breaks the semantics of what's it for.
>=20
> Agreed. If the global counters affect the performance and throughput
> significantly, having an accurate hiwater mark loses some of its value.
>=20
> >
> > Even without those global counters, if user wants to know the hiwater v=
alue,
> > snapshotting used value(sum of each area as current behavior) periodica=
lly
> would
> > produce meaningful value for workload evaluation.
>=20
> I'm a little skeptical of the value of just summing current usage. Doing =
so
> tends to miss any spikes, and the spikes are the problem. If swiotlb capa=
city

That's current design when CONFIG_DEBUG_FS is off, and used as swiotlb
shortage indicator for user.

Statistically that sampled value is approximate to the true value as always=
.

> is exceeded even for a short spike, you don't just get a performance blip=
.
> You get I/O failures, which at least on the disk side tends to be fatal t=
o the
> application doing the I/O. Maybe the networking stack recovers well enoug=
h
> and retries, resulting in just a performance reduction. But I've always t=
hought
> of swiotlb exhaustion as a fairly serious problem to be avoided at all co=
sts.
> That's why CoCo VMs allocate so much swiotlb space, even though most of
> it is never used for typical workloads (at least in my experience).

That's dynamic SWIOTLB is designed for.
Only when the IO is so intensive, transient buffer/DMA pool is exhausted qu=
ickly
before new shared memory pool is created.

> Michael
