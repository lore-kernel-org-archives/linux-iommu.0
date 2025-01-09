Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC111474A9
	for <iommu@lists.linux.dev>; Thu,  9 Jan 2025 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411110; cv=fail; b=ia0qExSQW3g3UnQGv+YUcp6e8/JbAXf+1q6O8QrNRvN1yjRPhiVVMOxOO7G/9x+flq4nZE+3z3a5fosxVaGiLgTQJ0fqUZFOy880Sn6W8Zyz7iHtyngh4mdLXZVr3bnflN+F3QhYCq7aV+RnI6YCsgSfb4PQ2oPgpmZTKXrDiL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411110; c=relaxed/simple;
	bh=Le9bRaedZ7VB+j8MUdPAUmWM/9FT0AdGv42Sc/wddS0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gfryirON36QFCMN+Y0sGHQ5k5ZatOK87wCY3nX/+St8RVJ/+1u/wsPy+pBDlgvik1wo+n10ZdpIBnxLfqxPcbp/5TmvKhxU67nNBn1W8LoJU9KzTrehICQtWPmwxm9Kbg8iLF/aOcgGqPjWae0iBaLt0krGHOFBy5Odv0dQURyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpgH3rPk; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpgH3rPk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736411108; x=1767947108;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Le9bRaedZ7VB+j8MUdPAUmWM/9FT0AdGv42Sc/wddS0=;
  b=mpgH3rPkTfcmlRKGoIjQKNoSE+OvdBk+5Cjb06Xqu6g3ylyp4rDcCZjk
   Mr2tPEPYsEipWdkDF6jkYT3fMqtVANBgrVksf38+AILWMVzC6eYK+QK3Q
   /1wjnwM0S5R28+AC5slbDa27ZYrj8Rl5yhHHM1BhVghcNNlhluvffbuNJ
   JQVxcXzWNkO2DkU2KJBEnSbYo8V+8i2Z4Yv97KG0HYGNNG37PJSmJ20TF
   Y9GeXikmvjCIdXnRyjsIQdmWT4WA9WBpuAualRc0TKzzz7luFLMHCXYHf
   ziDCz22yRsA5LyBkdnOMEW/Vtim0O9YMhSgQN5cN8RnoNv3YgM8pzVbTk
   Q==;
X-CSE-ConnectionGUID: jdmuyEzFQruL0cKNFuUpdA==
X-CSE-MsgGUID: pcbQ0h8TR+WIRtr6f9VKrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="40604712"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="40604712"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 00:25:06 -0800
X-CSE-ConnectionGUID: Q5I2XhriRqia7f6SlL9FFg==
X-CSE-MsgGUID: gOp2DBeHQtmFVCZNtiyl1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="140654845"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 00:25:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 00:25:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 00:25:06 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 00:25:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6iN1P21EoU6s6gKdgCmvqUZJxFL5myWFuxaFdB/1kU9IPiZ7ozUWY3posmMN5aS8bLC/vKesH7ybfk9lFI2tSuumlqKOTBwM4Gbz9AN4y7z6AlCFdRp16Bh1Jr4AtU74MsmUTmwrz4uMhrlzACTq7glWeU/cd10Mcz5T418+m9qkDxUOZLfGDV8OQScOZfYEn5Oate/GxJNknA8C3thnqXLXTsfj9BI9qn8MOsaRtl/5jM1su9CuVyecrumS2R6/ZByLkNeZkbkh2bECQE0DHY0ygouSRGwtDICcyxXAczuJ2QpUbd3K5/FhKvhsMhtkPAh4g3vBiYP5vwKmEbikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCp2Cq6JN8iwoUcksiezHH/4ZIuaKYj+6sUovFzJNeA=;
 b=wtaLLQ8uyJ7i6UPPbRHBMlVx5QIOCqgslG2Rewcltje2rXIDKyA7J4iEJdbe6EBFXGRYAFUn57MOgBQJ8EFrbCYiz6PmIegTjk9JpmSb9G2C3x2er8ng7vFxRa517YpYWFocfTuza2D9M247wfqO2ET4UvvxHhlvZJrIHRBvlasbe0G46HfD3LBCb4235gZ4pdz86Gf2OVTF02262CLn3d/ZpRyBlPfHoypN6YCkfBsOzBcdxd8+PhfOtC80xj6iSGYlcf4ci6IvVIrhxLHlk4HEfZlnFsFQcI1ZnOLDlyr94mpJwcqDo1HnmKpM8YWU1ptrO+V/D4WhVXQyg6NPMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5056.namprd11.prod.outlook.com (2603:10b6:a03:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 08:25:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 08:25:02 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v6 07/14] iommufd: Support pasid attach/replace
Thread-Topic: [PATCH v6 07/14] iommufd: Support pasid attach/replace
Thread-Index: AQHbUhnQGg9GHsddsk+KmRq0L3oRiLMONJHQ
Date: Thu, 9 Jan 2025 08:25:02 +0000
Message-ID: <BN9PR11MB5276F19C181FDCAC4347311E8C132@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-8-yi.l.liu@intel.com>
In-Reply-To: <20241219132746.16193-8-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5056:EE_
x-ms-office365-filtering-correlation-id: 299d886d-ea2c-446d-6489-08dd30871d57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?U+rGRaoALW2tZl340oOpaN6cLi9P4YaAaiUhYPNN3urtS6yQ5nTdB9g1Ysl0?=
 =?us-ascii?Q?tJmmB+erlxrGpuvbQ46YzcSb4kWBNZ3iCvX8jloGvCh942JuRBPivc+A5/LR?=
 =?us-ascii?Q?je/cbrlUROgmgBI7PW9wRYUdduk0MxIH/npuPmKG62gUL39dWGO3U4pU4kC9?=
 =?us-ascii?Q?0A6Yi2XCSV0znYi3NQoujMl4+Qi1//Nrd6B2J5VMcqb4AaSfurgTUo1H58Nd?=
 =?us-ascii?Q?UWduGTcY2tOfBsoUIWjncCoH9+RT9100dokx1wPiGQdewOYOIQWBmcmpqfgR?=
 =?us-ascii?Q?lVp2tCxpAZns7dE+JgKXoWhDLSIECFyUY3Rxze7jQRgIb8rsTFBqDZiVarf1?=
 =?us-ascii?Q?PpAO6LFShu0N96Ely5GsMMJ1ms5xjH2pR/xZGGZgmUZPXhXkOyn2choY3vcX?=
 =?us-ascii?Q?iTwAH5RKHymtNxKkvvPOKpnEfhwGQU/HQpHCybzffLVclFDBiDv9inGQzH9T?=
 =?us-ascii?Q?/uhFyH7Nz9qC1vNSbjsNlXU9/X+rrz9NLoxWli9LRmQtQcMSVyTl7Ed0kibN?=
 =?us-ascii?Q?8p+y1dwI101+2mjO6Km6ISvzAMQO3tmH7tVUheWFuno2TZfeQPVxfTGbKl0I?=
 =?us-ascii?Q?0JAo20VUcFnl4hPvXU6fSbkK8Akj6d51zzwDcUCe209G5tLppbLCvLOTdoW1?=
 =?us-ascii?Q?8igcxwGNUFHDO9mM5MqbJOQGuESxVgM5NlaepwwRyYu5rKJIKabvWwPd6m+9?=
 =?us-ascii?Q?HBHiD9YgE4fLHL7hnXkydzG0rFYEbTEd9OiXs/dPveH1QqeiNPPqOtUJPFf8?=
 =?us-ascii?Q?S9mkbvuIAm1iUPFN8JshX6SQoYjBc8zqjNJy3LaLw8UR5eA7rfOt8rY0GHo5?=
 =?us-ascii?Q?woUhkLTVuZqCKUw31OBVZRbYkBoZU0Myt/POVWwbZsvs3fWukcZPddxl0XUX?=
 =?us-ascii?Q?eIF8IQYSMc07hrjTfWBMt3n9IvsOuvsgXqZ5aZZPzFUxiH0RbWsKiUBrEofp?=
 =?us-ascii?Q?Oz/1Ef6ogytnSZJJmxriwev/kZ18+zB1no/YdW3FJpWLAhrvNFANCXAAYz7X?=
 =?us-ascii?Q?Zf14gt01vFR8TEvh3ulWIZ9rE42Ttuqc8OMf2jzCwtvlxU55IdXHG1gK+LMa?=
 =?us-ascii?Q?YqdDEy03r5meiIMVOcmbSOWyp3Ybt6iYnNM+QxAvY3aQe4kfbmi078hIDmvZ?=
 =?us-ascii?Q?JPVZ+7Tjxoelo9KvOUwuWyNqbhp5MM7vK23Zpjdp3zdKQ0G0q/BdM3vH15vt?=
 =?us-ascii?Q?LpAe8PEglANg8v+oXWm26aHwSA87xrnP1y6UiRVzmH7NHA1oNgSA+sW7zDrq?=
 =?us-ascii?Q?fjgDPdoionNN6M1m9S3oF2/+cabBttTsmq89uBYe2WKCoCR3f25yYPC00cKS?=
 =?us-ascii?Q?fVXy6110eYL+aUVbgi8K3qzuVsKBzN13m9P6u8ttIXpiOOMiLbocUQPgviji?=
 =?us-ascii?Q?ta8LyTAFqjLZc3LEgqzp7X3irG3KTphmpnGjXEWXXEdWDkN3KmTSD5VVQD38?=
 =?us-ascii?Q?+z0g9gQO4n8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cro+ejv3m8gLwAX+yVExoOZLrmP66aM9s/h9VugEuzmqLxivgcVw1nHlfur0?=
 =?us-ascii?Q?+nQoOL3BixUmi9lQtZwlFPcObPk37/rqSnufoBwKW91YMpynhQY9KwXQl3iL?=
 =?us-ascii?Q?Br9/A7E+/gPKm8mfL1/sq+7XKmvcb3/I8iV6D+epToVTyyThDSZeBajtlmN1?=
 =?us-ascii?Q?B6suqyK2OwRASkObXnAOAFrkRziyn8T6be87r2gjnSbyxz07VHwlFXV5Wf/W?=
 =?us-ascii?Q?xKYuiNCwuoA2rfcckl+Twf5iaZtYjB4nY45Tm+CiopNEuAz5G6HBVlx9Ox6A?=
 =?us-ascii?Q?7cu1JJerlNlPNXILmtDnIYk5wREbzVIdocFWs4m9TS8nHCaGedit+w0jAbLE?=
 =?us-ascii?Q?Wtxt889M4/2cHydnVL0v3JaqPXiQ6UsfXX4hBTQf1zNKmqNLrjBUqgMA2Qpj?=
 =?us-ascii?Q?WuCuGnlOlD7+p5yvJ026ZRogLqrxf64Mx0FOnUJ8CG/Neb5u0OajhaaYKEFY?=
 =?us-ascii?Q?X+thtAd1ei9Tt+nAfulwaKrUzIo8yWnNaGi3VuQ+Y1q9EXL478wdFgVdQbAZ?=
 =?us-ascii?Q?vpIbEy6RzkdphTsaCDW8+Ttg2gtlaRxZPjoSNORUgNLSkoJJBe8ScTjYVWXm?=
 =?us-ascii?Q?imouF/X0/DJoSXd+QxN21E+WQiv9mwGtxaXdCp/r68lf0cIGeqKlO1EdWBzo?=
 =?us-ascii?Q?ARMktdY6GGsKg4B/zJvs7t+eL9LOyZgqUoA1LJx267SMhRQEFHa0fap0ho0U?=
 =?us-ascii?Q?mPK3zCOiJciqefZ8k7TaafITHZXuBn7xfADheOD+W9VBOyFE4a0jJgwKkZ6r?=
 =?us-ascii?Q?M6DVf7aIwkh3Yg5fgCmNUJCB//eciaMFbmUqWa0lvC8JKF1cUVtkbDpBisiB?=
 =?us-ascii?Q?DLiUSp9TBXd0SyvmWnhWqS0/oHk6dgvC7APQJGf8ykxJlC1+OW40yo6+Nwzg?=
 =?us-ascii?Q?aA8jTI06R36Obmo0h+OtXIHL0mxrYKUxc7o6P5x3NCMtWpLNXP727E2Rk8LP?=
 =?us-ascii?Q?CV1Tmi8R7IADdWBtqKNgpY8iUgzYcFLyDusOG35PQoeKFKqtggVrurUCgUIi?=
 =?us-ascii?Q?7D8pUxO90eKihz220IU+mxBosWZ/YHa0LeOHabubG5btNSwKTM32K52V2xjD?=
 =?us-ascii?Q?AkgWv6cNvu7RnUSI8gtaqfJAtljkf9yIeXbGzqZeceGlET4w/IjoOPdqQpCm?=
 =?us-ascii?Q?bdI1sWkl9/Z0yW+TmebZOqW+F36SrovlWs8cLbAAEN1jTm7UYTknhQ+4VLWr?=
 =?us-ascii?Q?l1z6cjiyHPWoY/79/CMeF2sEFp6CPANjY3SWPPKJ8mIYkIcwtpnJQ5ER6fF3?=
 =?us-ascii?Q?pu3eJigjslJdOLGlPa65O3hPp0+zJ0G6tL3luPSlhSpIj7dHq3EAh9p6jeE6?=
 =?us-ascii?Q?OqAN41HTcsSxbAPRvxLTaEGkEu8A+xcSGBY94mJbL7jU0efVcmJvLLWBcYR1?=
 =?us-ascii?Q?0V9TEjxD7eyIN7LKa6okVFLl24BfiEXdKsxmxg1wps0bSPHopsBGrCMpbBeG?=
 =?us-ascii?Q?xL+2EPq5erlBs4qNNEn60LKMqxcS0hB6dlcMbciLcPsOiefklTFPrL5q2fGw?=
 =?us-ascii?Q?37qCqeNSmdHt5TexWeS4sgMD93XoljjvnFcmYoRBobBN+KbslRCglm1sU0qH?=
 =?us-ascii?Q?dk2efugncacJxo9Kwht6M/5onRSC6iEzzUMH9Lk2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 299d886d-ea2c-446d-6489-08dd30871d57
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 08:25:02.7112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cOuo7ST6SW4QO5XREPr7/obhZlbOF6t59xLcEIhxL8LO+Ju6j+TrDrh/pD1GF/FLqd87+1A+4MYb/KsRW8cCgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5056
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 19, 2024 9:28 PM
>
> +struct iommufd_hw_pagetable *
> +iommufd_device_pasid_do_attach(struct iommufd_device *idev, ioasid_t
> pasid,
> +			       struct iommufd_hw_pagetable *hwpt)
> +{
> +	void *curr;
> +	int rc;
> +
> +	refcount_inc(&hwpt->obj.users);
> +	curr =3D xa_cmpxchg(&idev->pasid_hwpts, pasid, NULL, hwpt,
> GFP_KERNEL);
> +	if (curr) {
> +		if (curr =3D=3D hwpt)
> +			rc =3D 0;
> +		else
> +			rc =3D xa_err(curr) ? : -EINVAL;
> +		goto err_put_hwpt;
> +	}

Refcount can be incremented at the end when the operation succeeds
then no need to recover it in the err unwind and here direct returns.
