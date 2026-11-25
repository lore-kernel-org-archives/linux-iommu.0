Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795577376;
	b=NF7aEj++j2G53m9HLaiXlzI5/qYU4D04n0UNrP2c85D/sPp7zGzfn5LHbAwQazy6t5AI
	 ASlXzh9YimY/tTq37vtIEWEtlpUpZpk7lf/L7B1o/ydN4mnQzn7wcqJUDYd3LxatKRlqp
	 e0FHaXroKdFXXHhNkDPA40q4bj/4n35oNAQZ113xVl+j9XCh7FC0Qs88HyB9fxpEOFkFb
	 7704V+YSWwmJb7Vyheayc8xsyclI/6sVAtTnIHoSclj9H5eAg7pNrL44aon7aghsVQIOJ
	 /Y8Um5GLGhwOmG2mEGvg5ga8f5suL5lhr/SbZasBfzO27nGkQQQ3U1ooMZChyk9Nthw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577376;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=HvZfsRVT+tWZL3xGE6xva866rd+NWLcGxmRka+5LKZA=;
	b=Cg+i3IPvoOp3ai3Dyw5BrGCGeHrqKqBekQH15F74PYK182ZHV7YH0pWwSTL4C8lSiLBV
	 uV0xgTEBIh5y+usR8TrxcMJmOmQKumYLwAewVSYSn4Ifas1Fo7h3Fc3KyR2oH2EcPnPqw
	 ktHSZZEtNhkNHyzzGd9bBY4x2C/NzpJw1iAWogbuPQgnEDJDZ18RhA6NuZOzMZg/B/DRS
	 17kfG0pOvZl8QaUrE2MpabaRDG7G3O61ScKnkAMoLeSRLZPTDpVtbKcySAXx0dbLuOIil
	 BuDXCzcEEozUVFNIlxD05e72MQKazN12BfR7IXN6hjWrGWH0QR3m6X+fUQTkosiPr2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aodxDrgg;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=U8zxMlKa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C840A606A31E;
	Wed, 25 Nov 2026 03:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C840A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aodxDrgg;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=U8zxMlKa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795577375; x=1827113375;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gu5OgcSlCTv0a+E888dgWKN8ZlSTeSbmBX9urOukrD0=;
  b=aodxDrgg+XdfeFmnYZdd0kAYg95LK7q3yUxZM6tA4Gts+IjFCuVOh8La
   w7nXDIyByde2CoWHuv4Ydf73H7qUJOZO1NoudrzIFw5D+dWX8uN8Yp0PN
   TTC2CmvAZjRbNaX1jjk7lEv8zphO7IHN2qNzxUuZJcA3qVp8tEIwsxZ3f
   p4Sf9OW0yX1xk9SDPGIuHSPXT2yfK17miVJ0X+T2AIOgtD9Jk5EX/9l01
   bPXnRnTHfyEr5ydEGaq60zMluxLYG7cwiZUPqyUlQWpUVZzGQkk/oO6W9
   tx/ZzJJgRHHHG8EfBXoaaleYpWMioeAaP76TWr4e8oeCFrlC46/3a6Cw2
   Q==;
X-CSE-ConnectionGUID: 1FRMPdMkTv24LqpYO2XuUg==
X-CSE-MsgGUID: Zs3D1BpaS7OVUGm9atMyNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4327887"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4327887"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 19:29:32 -0800
X-CSE-ConnectionGUID: IcqkxJIFR6yPYUXElCMkRg==
X-CSE-MsgGUID: p/ukaPGuQKGXRK40OIji/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11734506"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 19:29:32 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 19:29:31 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 19:29:31 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.44) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 19:29:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHp5fnuya7869G6XYFv5RDsAgrCP1jshFubzQsRhYOHM6snngxjaRwP06z4pBARPwsBO5VqFB2lvdfe4YK4mICZjT92TzvdXUIIlFkG2iKy+7DZ/WOf0c1pOsGmldiSN1MARGRBN+wvXTJgoqvGfLqVSenzTidgdJXcvREZjY7JttQDq2pDsQTpQFzMHdQyf152Z/RFEwrebnh6azJ8pJCU4rtsIhyuHjyz3l8USz4BvMG/T2xbH7qAikIRF2GnUhKQLtUTEgQHKDYGVZZ8qLlO4bV/egZeMYuXLmcIM1Gu5o0TCaYikwYPPPvvRmBVkHy9r9LUVCObyMitOjc4+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvZfsRVT+tWZL3xGE6xva866rd+NWLcGxmRka+5LKZA=;
 b=uPn2ppKgFO4TW15Bu/1bGQZlKAId6NP0vS2HgnvQ3uOwSvj+YjxlZSVMFE25GGAeq5t4UtgD8fryNmnRNVdkghUI3R/k9h/A6peURSisHd8gxtsf/fFwMHPm2CoGhnCl34DZb/JWhByCnmzdtnQAeHXr43Uu9cD81jPrh3PH9Yp/PI6Y8vtZ63UQPFhnJpFy2xFa51dAYdBWVwWFmgreweD2x5Teg/sQc2hwe9UPPZmWFpllImzu+ceWRQ9yQg9qUOiGFV8wSYDgWOB6Asvd7i3w9/uC63Qs7P+6UIGfSF+KQVcz9BlKeTWfhHv1Tqh25YMM3878sbF8uyP0n98hng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvZfsRVT+tWZL3xGE6xva866rd+NWLcGxmRka+5LKZA=;
 b=U8zxMlKab3r+8Vee3BcBgyZZu6TMyAoVV3/l5eWQ7/763R85ednYZWGRvhrzmyQH/DdsMkstvCSfsd/pk6OM34Jz3dz4N7Tj+ahviJ8I+Vr9P3jrb9sC21nH5MMglRTX7bgFwPKjq+qzGja1XHNtUwRgVckurtAZ0uj5ZTVV7pk=
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by LV1PR11MB8817.namprd11.prod.outlook.com (2603:10b6:408:2b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 03:29:28 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 03:29:24 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Kiryl Shutsemau <kas@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao"
	<chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/9] iommu/vt-d: Add interface for tdx-host when
 enabling trusted DMA
Thread-Topic: [PATCH v3 4/9] iommu/vt-d: Add interface for tdx-host when
 enabling trusted DMA
Thread-Index: AQHdcmB4VMJqqNYilEu6w0/Ho7paB7c+MBUw
Date: Wed, 25 Nov 2026 03:29:24 +0000
Message-ID: <CO1PR11MB4835EB7D858CC6C8A20F0E148C432@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-5-baolu.lu@linux.intel.com>
In-Reply-To: <20261112043054.2664857-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|LV1PR11MB8817:EE_
x-ms-office365-filtering-correlation-id: f750d577-27ff-4725-d4e6-08df4aa44dbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|11063799006|56012099006|5023799004|261026121527099003|261028144727099003|261022075727099003|4143699003|261022105027099003|261009223027099003|261021121427099003|261102130727099003|261102123227099003|261026140227099003|38070700021|10067099003;
x-microsoft-antispam-message-info: 6zpp0BxQVzOkT5vbkqYA/2M/XLrR01kUYjQuD8tEjGRX/zlYAk0nCsKEgWculSx6fnZHTKociJgT62+9kkcyt8KN/w31PSZOiPSeVdUskroZmt09J2cAm+AoVe4LJvflRdDvI5XVM8cUEd/bESvkkh6qVh9zNdQtVVmrRwCyUKZ8z8YO4IIlERmtR5+BzlcwP7hSbMTs7VRrBbBvVmjw5A7Z9jvDPaNzAk7epPsh+17JqhYjuhuoOJKDYK8BcZvVzlxBfcV8Ugik7voYnuZiGGoAI09tT+TCqU80ieEADmNnFibMbjUPYv+ueMnEvU2QXTYuYCGE4dhTcZYhK+tLkhK9bn8uuaqCBR5+cY7XMhzkpPyYnTIdnHH01znUKHeVnEpkh6FeZLHa2IRFZJwb7NP8vcPtacQdrMndlZ/6/7l2FOtFV/iOqevX6SX6K0GN3AQyC8pHq3EUlmimGMSGyjXfqKXH+zZCLkeuSk1YNva/+U4VPfmD27IAgPvYPf9+o/5cHRo/3TKlbU59Fpyb8tBkEfXPGv4Mj3xZw9Iihncoc7G8NDSUPbM2P7pbePMM/yuznrR2yh+dzfFBln+OsoWSL7P7/C2bRx+qSgNrfwQTysmNUG4y4p+OzqF9vBQPQjv6bmEGbSvDzKBOmaSHri+IMR79furE1QL+FucymfkwGrjNnxk//gyv15L7GLJZgtrQj8uOOkjQCp7m4nSXd/WVLw3x2XUYy7l/Rf9ptGU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(5023799004)(261026121527099003)(261028144727099003)(261022075727099003)(4143699003)(261022105027099003)(261009223027099003)(261021121427099003)(261102130727099003)(261102123227099003)(261026140227099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U6JyClKJd6aQ0s2xPkPEomzhGceEMv0MBhTBI5RLWo+a/zpxvv17byl3IuVR?=
 =?us-ascii?Q?mvhboTibXh9wxJAfQY17hVpST69x/5T9fSsx8jvLI1sqo7minm2jsX0AofEx?=
 =?us-ascii?Q?YuHCssa9Bh/lHOGfSBHFYIAUjui+afFx09+DSZT5dAGHc7PBkDrBFZpuev/+?=
 =?us-ascii?Q?/EQxokbPuXvWo2I1Dp21UFHfjw7quNwo6OR2bay6e/W1WmyBXypgSc7vJk3R?=
 =?us-ascii?Q?SbSXWhoVX2nxX42+VNo66EYm5SSzeUb4U+qMWA1CLujDiuAcbOmRprXz3B7O?=
 =?us-ascii?Q?uMxpbPg/WIOT8OFbjNBgA49vkByviL439ILGRkVXcky46roopjkOWOlF4nBH?=
 =?us-ascii?Q?r9Y4vMYUXQ+eNzRX9k0pV78+VE3XWznti/evkJ4//Vk8LX547om2bP2OV/kO?=
 =?us-ascii?Q?ksVlk5+iqnqI4kTkunbQzvDe3VqqJ5rGCX60Sa+MJ6rT6JVAvjR4JW0Y26Zv?=
 =?us-ascii?Q?u9H76kantY2NLeq1uqkRjey42hIDHLbSnEFUjlmaxrmGc1nSBW/fTmMZnPrs?=
 =?us-ascii?Q?5PhY2Gzqn0MRenIU6CDxK3fhFaJmV42D4uIQ2e/AgjvSypgqYSAVB/gRfh1e?=
 =?us-ascii?Q?7zLZWcCp6abjpboNDOCt5aI74x1Mpk2XnLuxbFD9JT7oN9Yqg7Fe341LHFwO?=
 =?us-ascii?Q?ZX+7yakAUwFJn7QiP4ao+iqXszzs83THzcCHnMn8ExBsQxYr9f39gw926FoV?=
 =?us-ascii?Q?jKqVUDzGh7WlyoOsUue5r+MBXAeWi0mz8QS1fwNZ+WUjLjatYf9mmbJ1p+Qw?=
 =?us-ascii?Q?tAMaADICsdBTFR/PuX4k7E5P5uwLnfEv5cyaeuoT8AbTbsUVS/jSTcx0pDFX?=
 =?us-ascii?Q?IiyUuzby+E4kmpq1vLMpiQ99BdxeE0EXjGK6sPDshbLd5IRgB9hiSVE4wV24?=
 =?us-ascii?Q?FYzfzbsM/3sQ5YjiV0ZBZWB3ay8fzGEED5hvIeASiEGBCC4oMn7NvgAk5gIY?=
 =?us-ascii?Q?wjE3Hve2Ypr7q++NbLWFoebfUBnOMkXuTrAW9kDm7eHq120rUemWcq7AXZPD?=
 =?us-ascii?Q?3EEG1FtMIiMfGsWvGTeIc3q9TVLglKcrdhQgmGEC2rLE1/tNcpENyOvPoNMy?=
 =?us-ascii?Q?6ZlWQTmqYkeVtVlGIV8y3yfMcrBwnv7gOeKo3goGftPMvoPY9j4d+L96jBmi?=
 =?us-ascii?Q?REBo8qgxYObSSvS5V/VzLLgGf1Bdw5JcsMCsJGcKP/11X7vNVZHOAZGR7Co9?=
 =?us-ascii?Q?LUc1kc7eTBhbWKO/NtkiyBllmoN3DZuIJx3BLYs49Ms3QsJJV3X7V/ZpsBWd?=
 =?us-ascii?Q?8tH3mN8T1kgJqZ2PjTgIuugVsAjyCLbYr93jgMc4abJHVsAeNHI+0AmfL2mz?=
 =?us-ascii?Q?63aJ0VtVP6OebA3hF6vOPGgdkOevH7gEzjUZ4WtheZeuXVHNbrc9Y8FxCn4O?=
 =?us-ascii?Q?z1sZng+mXqhk11KO1nvPl0D/tanlIFsSQY3zLvgwtz5OxF+vNXKffGjDh+QY?=
 =?us-ascii?Q?XMgHHzbURAFbygUPKcOMrolBckLji3K6l/LMz29fNPB8Ni5/F5JYqiRS9IcP?=
 =?us-ascii?Q?W1el34Wp+Rq4kyiywfxnrytmMct3Kgr0uWIz4pGXYu0oRE8Tl+/m1LyqGgIC?=
 =?us-ascii?Q?Mi1D/STsHMX4xXcWy5B1RF6K7I8b948GPI1X2I8ePXkBuK+Bvp59opwwjYqt?=
 =?us-ascii?Q?X2h+/6qkD3qHqzDdThqqp5t+taKhI+dyv0eTLFqdZaqgZgNxo+gRZy6csRxz?=
 =?us-ascii?Q?7CcD1eM+71E5Vzdk23f/wHTbnCiFtRz70D3m7MB55jgAqAOh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: m6wz1kyViiXdQf+YieYuB2XxiscTZajjZ5r2j8PN02f2FkFr4TOT7SZqEYTxtSNGxIaqlS+VKemv4bVD5xyAmngCZMaJm40ZCH720m1p2gA9FORhABvuoAsmjNVhl+9co6FvqRnW2gBLZi/uXlcxF+X6ULqylg61W8vKkVgtxhkl5Z+bF6ch5p9wzy/np/cZT82TtElfpKoWb/wnFBDTSifaFfVbRF28K//IqM4WN0PK+mpYZThkdzuTkhYIs6p9aEHhFgb5WK8rmhIMskAIvNcthn1jbEKxrH56AEi2T/t7IQ4POrOAoQOlMEfLzE5IXc4FbfHg40vh4hf+/JJMhQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f750d577-27ff-4725-d4e6-08df4aa44dbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 03:29:24.8731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bUZKohBVR9olblr/bIHMlsVE/T+EqG/51tRmmCkHlsvLl1uMoEgxEIUy84+jUgyVnR9/gPIkHa03mFs9osecuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8817
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, November 12, 2026 12:31 PM
>=20
> An Intel IOMMU that supports trusted DMA (ECAP.TDXCS) provides a second
> set of DMA translation resources, managed by the TDX module and used
> only for devices assigned to TDs. Before they can be used, the tdx-host
> driver issues TDH.IOMMU.SETUP to put the IOMMU into Secure TDX Mode,
> and
> issues TDH.IOMMU.CLEAR to take it out again.
>=20
> The VT-d driver owns the hardware state these SEAMCALLs depend on, so
> it checks that state and keeps its own use of the IOMMU out of the TDX
> module's way. This is cooperation, not enforcement: the TDX module
> protects trusted DMA regardless, and a misbehaving host can only cause
> failures.
>=20
> Add a per-device interface so that an IOMMU is put into Secure TDX Mode
> only when a device behind it needs trusted DMA. tdx-host tracks how many
> devices use each IOMMU and calls into the VT-d driver only for the first
> and the last of them:
>=20
> - dmar_tdxc_get_params() looks up the DMAR unit translating the device
>   and returns its register base address, which is how the TDX module
>   identifies an IOMMU, and its NUMA node, so that tdx-host can allocate
>   the TDX module's metadata pages local to that IOMMU.
>=20
> - dmar_tdxc_acquire() is called right before TDH.IOMMU.SETUP. It checks
>   the preconditions TDH.IOMMU.SETUP requires (DMA translation, queued
>   invalidation and scalable mode enabled) and confines the host to the
>   lower half of the domain ID space, since the TDX module owns the half
>   with the MSB set.
>=20
> - dmar_tdxc_release() undoes acquire(). tdx-host calls it if
>   TDH.IOMMU.SETUP fails, or after TDH.IOMMU.CLEAR succeeds for the last
>   user. If TDH.IOMMU.CLEAR fails, tdx-host doesn't call it, so the upper
>   half of the domain ID space stays reserved for the TDX module.
>=20
> DMAR units advertising ECAP.TDXCS are excluded from DMAR hotplug. No
> platform currently supports both trusted DMA and DMAR hotplug, so that
> flow can't be validated on hardware. Hot-removing such a unit is also
> unsafe, because tdx-host may hold a reference to it and the TDX module
> may own its trusted DMA resources. This also keeps the unit handle
> returned by dmar_tdxc_get_params() valid for the lifetime of the system.

Here we used multiple terms (Intel IOMMU, VT-d, DMAR) to talk about
a same thing. Intel IOMMU and VT-d are interchangeable, commonly used
in many places. But DMAR is more a term in ACPI structure. Better avoid
it in description, especially in exported interface names.

> @@ -689,6 +690,8 @@ struct intel_iommu {
>  	u64		ecmdcap[DMA_MAX_NUM_ECMDCAP];
>  	u32		gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF
> */
>  	raw_spinlock_t	register_lock; /* protect register handling */
> +	/* Acquired for the TDX module. Protected by register_lock. */
> +	bool		tdxc_acquired;

"for the TDX module" or "for the TDX mode"?

s/tdxc_acquired/tdx_acquired/

> @@ -47,9 +47,32 @@ struct dmar_drhd_unit {
>  	u8	ignored:1; 		/* ignore drhd		*/
>  	u8	include_all:1;
>  	u8	gfx_dedicated:1;	/* graphic dedicated	*/
> +	struct mutex tdxc_lock;		/* serializes acquire/release */

s/tdxc_lock/tdx_lock/

>  	struct intel_iommu *iommu;
>  };
>=20
> +/*
> + * struct dmar_tdxc_params - IOMMU information for driving
> TDH.IOMMU.*
> + * @reg_base_addr: Register base address of the IOMMU. The TDX module
> + *		   identifies an IOMMU by it.
> + * @node: NUMA node of the IOMMU, for allocating the TDX module's
> + *	  metadata pages local to it.
> + * @drhd: VT-d internal handle; the caller must not dereference it. It
> + *	  stays valid for the lifetime of the system because TDX
> + *	  Connect-capable units are never hot-removed.

what will happen if the caller deferences it?

> @@ -2518,3 +2548,158 @@ bool dmar_platform_optin(void)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dmar_platform_optin);

code starting here better fits in iommu.c?

> +
> +static void dmar_tdxc_fill_params(struct dmar_drhd_unit *drhd,
> +				  struct dmar_tdxc_params *params)
> +{
> +	params->reg_base_addr =3D drhd->reg_base_addr;
> +	params->node =3D drhd->iommu->node;
> +	/*
> +	 * params->drhd stays valid because trusted DMA-capable units are
> +	 * never hot-removed.

hmm now the 4th term for IOMMU...

> +/*
> + * dmar_tdxc_acquire() - Acquire an IOMMU for TDH.IOMMU.SETUP
> + * @dev: PCI device that will use trusted DMA
> + * @params: Returned by dmar_tdxc_get_params() for @dev
> + *
> + * Call this right before issuing TDH.IOMMU.SETUP for the first user of
> + * the IOMMU. On success, the caller must issue TDH.IOMMU.SETUP and
> call

why defining the caller behavior here? what would happen if the caller
just calls acquire()/release() w/o doing any SEAMCALL in between?

> + * dmar_tdxc_release() if it fails. The caller owns the per-IOMMU refcou=
nt
> + * and must serialize all calls for the same IOMMU.

this function already serializes internally. What is the rationale asking f=
or
extra serialization in the caller?

> + *
> + * Return: 0 on success and error code on failure.
> + */
> +int dmar_tdxc_acquire(struct pci_dev *pdev,
> +		      const struct dmar_tdxc_params *params)
> +{
> +	struct dmar_drhd_unit *drhd =3D params->drhd;
> +	struct intel_iommu *iommu =3D drhd->iommu;
> +	int ret;
> +
> +	if (WARN_ON(dmar_tdxc_find_drhd(pdev) !=3D drhd))
> +		return -EINVAL;
> +
> +	guard(mutex)(&drhd->tdxc_lock);
> +	/* Still set if TDH.IOMMU.CLEAR failed and tdx-host was reloaded. */
> +	if (iommu->tdxc_acquired)
> +		return -EBUSY;

what does "tdx-host was reloaded" actually mean?

> +
> +	/*
> +	 * TDH.IOMMU.SETUP requires DMA translation, queued invalidation
> and
> +	 * scalable mode to be enabled. Catch these here so the error is

Remove the 1st sentence as it is explained by the code.

> +	 * -EINVAL rather than an opaque TDX_IOMMU_INVALID_STATE.
> +	 */
> +	if (!(iommu->gcmd & DMA_GCMD_TE) || !iommu->qi
> || !sm_supported(iommu))
> +		return -EINVAL;
> +
