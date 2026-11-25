Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795579305;
	b=MJyV6eR6e8vxuW1ueE/jafxMoiti2GXnP3xL++ujO/esXbGTvZLxncZJvkMobBqVIooe
	 OaRAe8J2Ri09OxsT/5JwkNY5QcVWmBmzsc02snm1be4rH05j5ecNX5n866CnQfmW3M0iK
	 6hFm+w3VLrxLL9reMR7aXG3iwY61ks7z4WAU4gcJzry3Cn59tatXHC4brAvX+wAE/Mbjm
	 JNNK7+1GCTVO5O35eMnrXHADpTl7qtfXpLHtZNd/km9k5RoX6WOHZf+6afnQnPvqt3tl3
	 EA9JkGfF5K024eh1tIcqiLFFdOBHoyz1PJ4QTfQPWif8HtUe8yC+iYrz014nvxDNMdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579305;
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
	bh=+l/flSkWaldQI4z/QLTegtEs1NnLM3MDX7p+Q2JtfxI=;
	b=W9v0mMct2BganGk9MMWSXzm1SbIDZnBejoyDsgHozJPXyAAquq9mwD9DjZg0BM6eOzDV
	 d2I9B62M1FHSjbFfGUBb60Ua/ZxRTAGGu0sqm6mSEv5VMwULiYmINlZMcOIfkTKGClljE
	 seKQP2kABEyOEKcVupZHG8DN9w3ZdqHYumEaJSjhAq1YUo+t0YBiRBJMkrBw31lYpT2zw
	 Ef9omSmd9NzAvfsZGt7ZUzL2ypYiGTykBPTpH6gjqjnE2cV8dhSr3Vif0PRK+OpYQJNTt
	 63l576VsrEoYwXbbUr7jmzFyW5lVd7gMi2DTP8/dUio0y2yXRSNX7sZVGQJPTR96PzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FwzHCEpt;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=IP7Q2nt1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEC5606A31E;
	Wed, 25 Nov 2026 04:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EEC5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FwzHCEpt;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=IP7Q2nt1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795579305; x=1827115305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fz13xFCFwMuH76jo2VwMg7tYb4CxZkdlpF1UiJhWZ0U=;
  b=FwzHCEptG8+sNNJTgBUdK/TyJggHzqu62NxBnT+QngmV6YHlJP2g5QH+
   9whEXlrBAO09KVq6abgC4BE5J6qTW7k0IkMGUpRhPFFIGioYXC8pGyvGd
   dekQQlTscnEn99TKflERDTnOjTQM9rs3UZrUGf/wFPu/VebT0rChbarGu
   2ZUa0XkSQwpN8qkfD1hIFDZYsaRdvfQXLex0pBST2jKiaddCa9Luqha2w
   OrasMbD+E9y6COOCSvJXSkpOAviyiOEZwr4F32tbRA7zHa2ijHHuDmwHF
   9up16RiIRgpkl/kobx3Womf2SzfZgofIVWYVWLY61oHXdrP3GW3kGW5WY
   w==;
X-CSE-ConnectionGUID: tnks4goWQNKP/nzPl1Hp7A==
X-CSE-MsgGUID: 9zO8QJj0TJOv2dMjEmM7Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4482358"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4482358"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 20:01:44 -0800
X-CSE-ConnectionGUID: 3MY+Re3vSlqzz1X3q5LomQ==
X-CSE-MsgGUID: 9Kyyrmk4QVWOhrIWr6NrVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11538418"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 20:01:43 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 20:01:42 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 20:01:42 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 20:01:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAXon1mrON9/r9Ot9AmWInQNbY0ZHgwg8srIou//ca+1yrngWSNh1sI0hA015ezf0PxLj+woJ4RLYdpdJHOTRUrSyc1fsXqdQZPbV81gJyKk9sG24pMaQPwCIacb1s8BlTuDa7x3AJLhijnP/g4LBSFDMjHnYsPIQB7+dCKCwHVReoyNOw7PHno8y4DXrPqYFL9TR0AhHsMUhSVqrhkS110EbuOosB2S7a4xsema+vZ8tNYF9Rph2nEjZ1K5rlIR2TUV1KxsneUjYR7k8UEpdVUIpc8l7NqGfxZuU4fZkQSm7yWit7nyY6LO7IGtKhAZUGus5b9nP79L5rRKuwzKCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+l/flSkWaldQI4z/QLTegtEs1NnLM3MDX7p+Q2JtfxI=;
 b=jeCDtzzhxkB72eIF5HW0qVSXEu2bzIKJGk/xOU378NL9FkC2sc2hLrp8bq8PxPgMcPKvOZLjZiSZajA/Bi5mOjby4ytQm1Up/wxCSJrQuU90a/HS7YsDFAVVHr9+ziTxnpXbg2SLWNtNY1X6SKjviNcFU3gHgHfwLtJ4AU6aA/mMIlBWgiU9UDt7Aj/xT+n+w84lQi/sXyTAmg1pF5blZHvU7W9PFyjfMNk6dc22byDyiJegUoyWzodGOh/GaQXhkP8mKdhxevTuiRzAcS2bLnWbeGrmVUPelr7D8NGOpW0eTChP0mec6gn1NM3K2cZcF53FagxAhF4QFEOhLaC5Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+l/flSkWaldQI4z/QLTegtEs1NnLM3MDX7p+Q2JtfxI=;
 b=IP7Q2nt1XdYDuOOVFN7bxS3sTBa3tJzz8gXRSTZaLxYfF+i5cCWOj/tcw+C/kfNJPOEewcSYKZOC2EabV3cjiwruqOuCLWmBTpel5pGmBUZaVnqGJeMDLzEzYO8wHoOe1StUQWQ4HjbqAmaZRuQqEINuDcAFyykL3VyBO6CQeHI=
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by SA3PR11MB7436.namprd11.prod.outlook.com (2603:10b6:806:307::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 04:01:34 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 04:01:34 +0000
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
Subject: RE: [PATCH v3 6/9] iommu/vt-d: Refuse system suspend while acquired
 by the TDX module
Thread-Topic: [PATCH v3 6/9] iommu/vt-d: Refuse system suspend while acquired
 by the TDX module
Thread-Index: AQHdcmB+9WhU1vTrQEm6wNOGEiGnrLc+O2vg
Date: Wed, 25 Nov 2026 04:01:34 +0000
Message-ID: <CO1PR11MB4835B7CA0A21EB68A2034C108C432@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-7-baolu.lu@linux.intel.com>
In-Reply-To: <20261112043054.2664857-7-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|SA3PR11MB7436:EE_
x-ms-office365-filtering-correlation-id: 5b445331-9fe0-43a0-e4b7-08df4aa8cbb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006|261022105027099003|261009223027099003|4143699003|261028144727099003|261026140227099003|38070700021|261022075727099003|10067099003;
x-microsoft-antispam-message-info: yMyMdA1o9+HYKtt91KR6KWgSYvHbYasYSRX05nLV4SxzthITjjH26UoCmhU5QG4HDSZa3jwmi2LECkGxkvNIBCYUq9ylX4kcnkpXK60Wk9IF7S+85xCmEgCVzfquqL3BW0+wcuzA50bxTp52G1m8boPZNOiVG+gatNOMdxBUesESlazikhDAaFIkH6c8rkrjpTQLi4QoyxOLaApsFtmBBugEvLza93tk1mq7QpvFwT8KffNvDYYy2Az3ie6BbEH+HZ2PW2NoRsGSkzZSBDFg3fCNtNrtqBnvuuB2xda8rXvGEG/ERNfcqgNRwHF2m6ZJwiAGcAVuUBdC+ntoZmqe7XZXFIwj7REuTEVnsrhRGBf+Ag8uQBbI+3u3RaFpZMZdTX1WF/KXzIfS09ETrRMJwz4E3GBGBVhZ0tEO1SFiKkgrf0aAYrX5q+q55D3E/byr00zjqfULikwnhulZjKqZHNPwDNianF2aOFfHItBLILOY0sdUDcM7ufCQiX1riqafAmdwIh2lkTVhwjuQdqunHHlJV5NpJlF/xOcUFba5kaN0qZrYbtZRLwIDFkvibU243fTALQXP3ucTrnM+kN0p0WP6bRUfhtXRC4X6LNyXIQSIzTirPjGIBbaIykecQWAUW+NKT+Njj0smDsYGyiMbaL5zEk4bshQOmbazc+sRNb8epJOtC1Sf9VYX3vt16n0/8cUcwIl/sGDUlJ8ruaW3MUPdi/5PUktGEo1e8zOaUiA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(4143699003)(261028144727099003)(261026140227099003)(38070700021)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jROekSqyRcgNPIKokX2rFlTVrPUvB0Xbk2DcCB6g0wbJis4BMlI14hU8HEfU?=
 =?us-ascii?Q?3vMSCFduqPkXUXhO5oh6NKurouJtTRdraSTAEfn+k2hWpAKsTUUIPhLACwdb?=
 =?us-ascii?Q?FhSHyyXWJXXcx/ac4Nfb949/+O5i909CMbnEoE0yYdgKUa4jMLgSfoWbJgso?=
 =?us-ascii?Q?kJH/GiPiuen4Wk46pikkrF07lMVGl91JfFKXmECdUHWOKjnGZcX66f1LoyVl?=
 =?us-ascii?Q?gI85pn2Qdge0mYXnjeaYftGN+wuLeO5Cw/YtQCQjkKlJgrsYrW8CTG7pyswl?=
 =?us-ascii?Q?Y/0xbjtEWkYsPBMnum3heytsBqp4XdQdYTWyVHMReZsMtLL9LCbjoRIm82TQ?=
 =?us-ascii?Q?sppG9O/arVCdHnslZZv2L2cOlUtE3E8x//TAv1SAE9lRfMjCqKBKzN+H6xVZ?=
 =?us-ascii?Q?iVlJbpBGF/UTqw2wN9RoMebivWHRdrRmWbLe8A3xkyEtsUJ5Dup2WLwsSio2?=
 =?us-ascii?Q?KrZRSFi1WLxLZOXCU4ccZj8rNKn3iAFYXWqI//wMFdlpkAScv+Ntn/LwMInQ?=
 =?us-ascii?Q?oREYsyo3Lw38ARSt0mfIuek4L1sNzuTEJeOcxD2wG5kzVw6b7gnhUkYkWktS?=
 =?us-ascii?Q?yejXg3G5eCDHn2SYVgBCfkENToazcAjqM+ZZlovc4QOuleN2kiTMErb11N5F?=
 =?us-ascii?Q?BiA0O8yjGcojGnfvh0xoi2s0BrI1vdhAeCbxsT9PZCH/pMowjhR30UfwqrgY?=
 =?us-ascii?Q?TkLsBBnZoJZbQ2JnArnn165Eo1eCDiscFyjxHbH53VhpWR7DGQyFA6mzgAPh?=
 =?us-ascii?Q?mSAYAM7hmi05P+u4+EDfd/ixnGHLyCdrkvrifZ5zzWMH8KTrB2/dQvmJloCh?=
 =?us-ascii?Q?NTbUFzeaUPYQgVmDXeP3N9BYOceKgD/QMfe/muTYjltuOLr+PkIzipuZ3ZXd?=
 =?us-ascii?Q?U8V0Vf0Pu516S2dFGGAcDbudCVdDbnRRtrYoq9TMDTXNLJuZSrhRaiMjXa1b?=
 =?us-ascii?Q?dCk1BUZnGKvQxNrQFIGagQ03Fcu3soH4H+6/3RJVFRcx5H7lMhSH/4UsE3gx?=
 =?us-ascii?Q?4QurJSwZTnsPNDSHs3ipITmQoTg/Iw8H6fDcJSv+s0TZrIIEhQ3YhJtrZwLf?=
 =?us-ascii?Q?xtIUy77gvyOYjbzV59AW5raB/B5YVI0SFiODxb2Lcxc3FXjxYM8qTSyPDl1H?=
 =?us-ascii?Q?n50k6S58VfJkxlIfHPRK/54HzRi9iAkYif5usC29GqruiWqf12ZC0PqT4E+w?=
 =?us-ascii?Q?AoP+YePJkT7skakyKVps8gIuQyxBFnbaUxKnvcpEmsVKSR9PYbDRTc3sRRuA?=
 =?us-ascii?Q?pyw+y+3/iuwVQ8oFc84dFTKoI00t5s5yKAD5xGFsSNj3/6S0nNaFk56oXbEG?=
 =?us-ascii?Q?3kH1+7R2AsX36G7Ii/j/WKiu9Nd8IFguPKan7Z2OPOTTi2PpV8dewcxX+P34?=
 =?us-ascii?Q?CMajyzzWUB1+fU9QMpyYlm61Vq7epCyPKZhSsLl+2ikicuHKzEgsIluXUfta?=
 =?us-ascii?Q?zK2mUrRWymXW5QN2BO616YjcKTKu5eYihrk/8HToReCN6NMmtWHSRYWdtSPS?=
 =?us-ascii?Q?kFv72moD4etW+2QEgamtXt3JYRySKl1Igzivdnt3FzrzMCjom330CC5l3MhU?=
 =?us-ascii?Q?IayoPjxKmLvXs2G9btQcf+Vkk0ttdgxizIERMt555DqS1I8CJ3u+jTsnuEA9?=
 =?us-ascii?Q?w0QXJ2ngULnAH+lcG9t8foifIPnB5q+KiCwAA/Diu5UkR/jIicE5dy3BoUu3?=
 =?us-ascii?Q?JqDKQAFYYipoM1A+3zIcI7nejC2nLHlrva9A390AUFWZABjQ?=
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
X-Exchange-RoutingPolicyChecked: RPSWAGbkuKgY0yvFwGQZkOjfhhpxGU1ubaAL1RMXgSgnWBjk5ymaZSZbgZxqlBcnqL6DKlM+oZTaqrRqOAFh65L2eY54JQHuw8Nin/kWUGDDiyvG1HK1QVFwFea0KTYOKfecU4HQUkpI+oLOah7XGB7oTmGlcIHAybFnF6kJyh/v2ulmFT6iCIudd/h92YhqjWyyR8GQZy2pGgDzlZ2pAcQwNUqqQWo8N0davIMeWXvAqCx1qMtByVsXpJfiGAJB/ur01DRwtwEFGng/JJM94FRSVPcHg6SEg7ES13DW+tBZi2I0Cm2OnEN2ulQ6S81Zbs3GZ+pIazglXWZ90kv+Xw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b445331-9fe0-43a0-e4b7-08df4aa8cbb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 04:01:34.1634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /bsy29RxRws0FQi1zeZDfeAodSdhjO6EE2Ihxj8DRQE7H/pyUyT0uviYurIuijcQf3x6mOBsPBen2goWq0EtrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7436
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, November 12, 2026 12:31 PM
>=20
> While tdx-host has acquired an IOMMU, the VT-d driver blocks its GCMD
> writes. TDX disables S3 by clearing acpi_suspend_lowlevel, but that is
> only checked after the syscore suspend callbacks have run, so an S3
> request, e.g. "echo mem > /sys/power/state", still runs iommu_suspend()
> and then iommu_resume():
>=20
>   suspend_enter()
>     syscore_suspend()
>       iommu_suspend()                  <- runs on the acquired IOMMU
>     suspend_ops->enter() =3D acpi_suspend_enter()
>       if (!acpi_suspend_lowlevel)      <- TDX's "S3 disabled" check
>           return -ENOSYS
>     syscore_resume()
>       iommu_resume()                   <- runs on the acquired IOMMU
>=20
> Register a PM notifier for each DMAR unit that supports trusted DMA and
> refuse PM_SUSPEND_PREPARE with -EBUSY while the unit is acquired. The
> suspend then fails before tasks are frozen and before syscore callbacks
> run.
>=20

what about directly returning error in iommu_suspend() if any acquired
IOMMU exists? at this point all other processes are frozen so no contention
exists at this point.

or introduce a new flag or counter (intel_iommu_suspend_disabled) which
is set/cleared or incremented/decremented along with acquire/release,
then just check this flag/counter in iommu_suspend().
