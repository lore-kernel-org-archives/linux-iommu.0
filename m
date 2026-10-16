Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D35282F15;
	Fri, 16 Oct 2026 07:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135062; cv=fail; b=aIQqEvsKsKkAGrdT0Q/LpUHomRqX4CEc8VyCXZ4HYQUyXFTeKVKLyl28eXqGRWKr4rUrM5OKvYjdtdIoggdOmPK++ABSpz9OeXx+QOezY48sT2uvDoW3uV2pwsU4/N3A+v+Cp11WaEAkDToro7IyOt888JiE2NIpwaNEe84v6/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135062; c=relaxed/simple;
	bh=E29HCdK/q+dGhqHPnhgPHcnmmz/fSzbrhzvLbtD0EpA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WVxOb7bvWTON3ls0SNtSbLTc6ArZrC9TR07jq5CpSdvo4oIrcLCbe3BLUzKRI4Plp+3FJdEVb5uTQFSU+B596J1tukpGSPCuE9GVhfn9Jz0Dl1dProty1JGIifhSmnRgLY+OfhNEO0nSKSh2mjZ18tIMtk3dcYSsgZjUbDLX81k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LiyheHaX; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LiyheHaX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792135058; x=1823671058;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E29HCdK/q+dGhqHPnhgPHcnmmz/fSzbrhzvLbtD0EpA=;
  b=LiyheHaXQbabQFbNgsqjK1DTb5T8Q80GYoDCUMk+7qE14zgbofnRbTUF
   YPxnFCezW0A/azlVlxJWtCn/lMe+ow941zaaFs3scpFuaPnU1L6hwJNis
   xyJyOKVu1zkWZBtbPyaPd5gtQ8YQ9XhPczcPxXvx0yeGjqkSIKXqM9O2s
   oeT1xVfiYu4u9e46wJyazG0v0wCVC//dOz4G7S5RKsQXZxhW2hed8mSln
   SNBc+/FNeyEutJ3tWkvWyx6CTBQ6gT1irq0fhSVewzs7NM+ofiMjdrfAW
   ZdVXluYe4YzSpweGjIzBBK0N2w+Puxg+4oQLPLQPFQ/cf+aPNsqta5Nmh
   g==;
X-CSE-ConnectionGUID: Tk6xqyJlTvqDP84+jH4dqg==
X-CSE-MsgGUID: 3wxYfJICQN2P0juw02ptRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="898209"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="898209"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 00:17:37 -0700
X-CSE-ConnectionGUID: DGv0nArkQ1+SanGLbni5vQ==
X-CSE-MsgGUID: KUv6FbBkRP23H4rKfnr5gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1950560"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 00:17:37 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 00:17:36 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 00:17:36 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.25) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 00:17:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/WiqcuI/r9sgxKPr6RNdMTWLxFZGOWxFVyc48+BDTFkUyWNn2sD0Ohv7nqFJfLlhEbwiJg2kkUyrfYbvTqEbnPALiLSw6ARqJjPNqAJkVM3v3Aqu90404SviDVKUV0kAjd6rKvxvG6lVt3w/nfJz2xo72cSZfFfLDrwyo75m68TJNllArondFbYod6G90LcanwrVUlHQ1R3E5F/ag2oAbss84IpFfhngTXprYQ5VGcSPrPYkdr/PhkmGTo09Lw3vyVtef9pnAxrB7/LSA3WlL9j+lT4hjo8DHVUR5YkiN3VM5qr5gjEGclve7T1ATGtgA+KVxJ1tW5el9qM7JFhsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E29HCdK/q+dGhqHPnhgPHcnmmz/fSzbrhzvLbtD0EpA=;
 b=aLzBNMEE5x3lQioYw9UrsahahsX7alaLjczICMnJbud+/REpIj1lGaOoXjimYSUsT8tg+G3JBStNznhqofQFxmUBDZQTthy/L+2KYpC1N7+vFf9n0yADy3RunLDq6Npku40S7XHogiWZ+NvEe8CWDb/FhDEsFFYfFhi9N35gjOz9PM3dnyA1D5ruyYXm3esygkdb4KsRbKEtl3TCxbrwi83X6pfn7msaj4tY8Mxiq8J5mVqH3Mmd/J6LSzTzJjDRtmCplMhm1U5jA7aPP2WAgG9yeI6M14GpAyCtN3JvtR4j9HYYVurP7032tEuSg87wtE4H6HjuNkir+LVr15dWxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4836.namprd11.prod.outlook.com (2603:10b6:303:9d::22)
 by CY8PR11MB7746.namprd11.prod.outlook.com (2603:10b6:930:86::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 07:17:31 +0000
Received: from CO1PR11MB4836.namprd11.prod.outlook.com
 ([fe80::c8d0:9419:e0a7:5188]) by CO1PR11MB4836.namprd11.prod.outlook.com
 ([fe80::c8d0:9419:e0a7:5188%3]) with mapi id 15.21.0522.011; Fri, 16 Oct 2026
 07:17:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Xu
 Yilun" <yilun.xu@linux.intel.com>, "Aneesh Kumar K . V"
	<aneesh.kumar@kernel.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "x86@kernel.org"
	<x86@kernel.org>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Kiryl Shutsemau
	<kas@kernel.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao" <chao.gao@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
Thread-Topic: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
Thread-Index: AQHdXENN2nUblT22Z0KkGwSJ4t8pVbb+RqKAgACYcICAAOFFgIAAASOg
Date: Fri, 16 Oct 2026 07:17:31 +0000
Message-ID: <CO1PR11MB4836E2CB05E1448BB42047458C9B2@CO1PR11MB4836.namprd11.prod.outlook.com>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-5-baolu.lu@linux.intel.com>
 <atCPY6LzHd4y0Ywh@yilunxu-OptiPlex-7050> <20261015173707.GV14213@ziepe.ca>
 <5ca5f1c4-4c3c-47f1-b79c-c1fe06b20ee4@linux.intel.com>
In-Reply-To: <5ca5f1c4-4c3c-47f1-b79c-c1fe06b20ee4@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4836:EE_|CY8PR11MB7746:EE_
x-ms-office365-filtering-correlation-id: 2795a51d-eb7c-45cf-c0bb-08df2b558b1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|261009223027099003|10067099003|11063799006|56012099006|38070700021|6133799003|22082099003|18002099003|4143699003;
x-microsoft-antispam-message-info: T3fCIkR4K/+FT1YJyJHwgZVqc2Wl8i+9YyPtCEtdb5V8Topt9KsC01HZVi4+Egp/eqP0jHeZuXrZnU3C1OHx5tBeh0BhrgPJOkdLZPGVJS5gySAzCSp2A80xXdvz6X20rvgGuR+koZUPBFDpgadNXGgxAf9/qN7AE8LJLoxyC+LgjPVjWCMmSc6x+cCaJ02DYDH15ThLePrwle3JYXrn5dO2AWU/j+W+iLcQED8lDcOKv18/z6SwnzH3LfWgcOxd99GRkDPrMLuXdkBCxrdd7RiHrgwEn8lm347IZ68TIPs3yURGJ8B5YuFENoNejb0gWJcxwrizfH3hXRzCMSZyLo5gRqFS8THakyKodiWOfrqxSRYoQl5RoJ6OaNxV87Jik7vJmbenJNMZbImA3ELYWQ1HhGt0dJydKCNFaDIBvlhgRy2WackPC+BFoynf5pOgucbH+a40Pb0GIyCc3lnHTUeo9YEMbcx3lnr6ZQBGMOEFqZikmXWFo7DjSkwqbbI8KQWn0E+sCoUATLcEwLjD2X/RcBc2juV2Q2lF4bOeRqdSw1RM265vvQFhg/k/u+8QxByaU4Q0g0qjbn1idYnvA8uhJFGrTEUgjnl0DpZ5spzkX6Nb0bDFjM4YUKU/4ji/Sl7htno5aT4zBRKHTwlfSSUL1XxmmvYdt5eY95bdvcEm2glEQAjMCdZyYUg5qJdrC5/pvBURG4jwLPn9fUdAg67zqm4WJPK84q/FH/tS/40=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(261009223027099003)(10067099003)(11063799006)(56012099006)(38070700021)(6133799003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGNkb0JyaWduZ3cveG03ZU5hOFpDZ1RhZnZIbVNsaWFuRlU5WHFnU2pQN0VX?=
 =?utf-8?B?b3VWaExMZUwveGE3emo2SUx6K2RoSjhwV21xdHMxUktid2NwQ1p6M3B5ZVp6?=
 =?utf-8?B?NEdwZlU3Q0lCLzBGYkE1UG5RSUdmN2VoY09sK1d2V2lTWWc5QWE1TG5YL1FN?=
 =?utf-8?B?UmU1c2d0bW5DZGRoUk1zL2RjdXVING45MVFCeVUzRkNTbVJsWmtFRDNWcTNY?=
 =?utf-8?B?UHhhZ2tVUlRZRHJLU28vQ0c4RXlmUDdFQnEremxSUTQ5bS9jc2VzSUtsejAy?=
 =?utf-8?B?V0Q0eWpXalJxU3hMV3FHV3hzMTlhang3bDlRT2U2U2NlZGdGZ0NLQnM5MkNO?=
 =?utf-8?B?a2VEcFFVOFVXZTlZSzh5cjBSTE9RdS91bHUvcU9DeC8xZDA1UUNWeDdQZ0oz?=
 =?utf-8?B?bHJERk1yYmZ6elFoQ3grYnhvZzZyK0JrNlhXb1liY2VobndTWGFLN1N4cm1x?=
 =?utf-8?B?bE10cit1N2RrTlpBVUxYREdzM2ExdWRjdHBrajU3Rkh4RCtnRjFELzZEWjRJ?=
 =?utf-8?B?MElyVmRTUFgybzA1elVRL25HaDk5VmhZVGNLTFBDMC9yQUlKenJTenpubS90?=
 =?utf-8?B?RHJXODlhcmc5Rk1vWTJJQW51NDdZWkJEaWorZmY1SHhYZlgvWVMyS25sSVpk?=
 =?utf-8?B?UDd3UERVa25zMXVDeXBEZHNCOUdVKzg1ZHE2YkRKK3ZzS0djbENacEpoTU9J?=
 =?utf-8?B?aXpkQS9iRFcwUmVYVFhYL3lkcDAxTXMwZXhLdmt4d2xNbEVRRzlUU0NCTEdy?=
 =?utf-8?B?czBWVzhzYUE1NzQ0cXF5eHdJQVBvYncybkVXOUJyNzZXT05XWnJMaitvYXJ4?=
 =?utf-8?B?SFJ3ZkJPMUJpOTRNTkVNaFdGWGNFM3c0cDg3R2pZL0hoL3htYzV4bkxMNGIw?=
 =?utf-8?B?ZDV2TjJUZGZOMFoxREpFb2llUjZ4dnRoc2FsWDJtYlB2YzcvRFY0d3hYNkd0?=
 =?utf-8?B?RW1kZWsrTlJ5NE1aSDZXTHhNbk1Od2tMSko2anFFaGEwbzhsV0hxeEtnei94?=
 =?utf-8?B?dmlKcERNV0hPZTBlL0xvZW5UeVcyaXdBOEllOXI4YWNjMExxYnVpTzhBSXNo?=
 =?utf-8?B?Tm8zNEE1NDhvSzNyZG1mN2ZSd2VwQzNkclBRWERUdk9hY1ZrcDlwbTJCWnV3?=
 =?utf-8?B?eVFpeHR6WStGVC85NGlyejRBSVBHUkZJMmN6blFjTjBXaWJGWE4xYU16U0Er?=
 =?utf-8?B?L1Z1Z0NmZXgzMEtHbFJwUndWU2cxVzV2SE9haCsyem9JR2U1VTNjODBJQ3VN?=
 =?utf-8?B?SkIrQlA5NzBnUng0bkxIQzhHdUh2WkMyNXc3NmtETXRGRXNSM2NuOHU5TkFu?=
 =?utf-8?B?VDJYT3NMZ2ppcFVDWVFhOVZ3ZW02NndEU1RCU2tnNFFISG5jM25XSDdpTzNE?=
 =?utf-8?B?VG1kSVlJdERaaFd6YWFvSS9Md0dDV1ZXNjFsajRIN3NIWDVrSDlwdms3WnI4?=
 =?utf-8?B?RVd6MEVsTmFFOUhDZUhMT20rRldVbXcxbEo1RU5HRDNpQWZNNERtU0grZFpO?=
 =?utf-8?B?S2dGcUhEZmhsQ05xbmJVdi9jRWRpSkN4SkE3OUxmVGxyakhXTG5MN0ZBelRh?=
 =?utf-8?B?elhmRzZrZjA2OTh3dkpkR2paeFllZkdQQW1yeVpmc0poTkJXa051TlZ2M3JS?=
 =?utf-8?B?QXdlYVh4ejYrNE9pWWM2Ni9IY1ZZYkJoNVhFUVg5azhSTnlTVnFlSEZYVXE5?=
 =?utf-8?B?WWdyUjE5YzdVUjk4N0d1TXRGN0ZPRXpEY0x4aW1YN0N5THRCRHlnZSszeU9X?=
 =?utf-8?B?T0h2SGRWTVVlWTF4VXAwbkhMSlUvVXBEY1g1ZGR0UERkRjBDeTkxSHNCUFZH?=
 =?utf-8?B?bHdxSm1PMzZjNU56OXprdENKbkVmM3FYWHhDck05akZIL0ZrNHJYazhqUHhQ?=
 =?utf-8?B?WkNYOHBJMFVBY0R1T3FDdmJjRDJqTitXcjIzSHBCS0c5SHB1bXlJcm1XclFs?=
 =?utf-8?B?U2ZBZjdUYU1Rdks5UWxLMWtTTDZGb2tzM1hZVTh6cEYxVEVIcy9RSWVxTmdI?=
 =?utf-8?B?RDdyaWkrejdBOWZHeHplRndnb2tObnJEM1BuWFM3cFZTNndidHVNVFdjS0hN?=
 =?utf-8?B?ekU4cXZYN0RqVXdCQmhHbEVraUNHMEdFc0p1akUrWnNyUk4wZk5BWW1OdWFH?=
 =?utf-8?B?VHRzRVE0dXBnNEVvSFJTMFJGdHZ4QUhBUGs4N1lXalZPRm16dlZWOWxTQ1Bx?=
 =?utf-8?B?YUsyWGFnUFBVZE9aTDJ4cFBFZ1pvMjR0NEV5UVEzUWt6ZU5QOE1IRTNRbVlo?=
 =?utf-8?B?UGYzS0d2KzIrQkMzZDJiREJUdzlzbFI1TXlkOGIyOFNDdGJyT1FMelppeEor?=
 =?utf-8?Q?Jsvm7bd77Hf/Tl8odp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HEgV465Qf8OtEfnVenZRlgdWVMAsswBTzo2eZ9qRrQbis+UEn+VK3RoWxrlP0FIaY3zdMNAuloPlRB/RImM+l3rJe8UF/nox7EPTcwrhqwt2YFaOF9UbYT5JkXYjnBIAFT98vg9RAiKnuljmaClJEikqU8XnnGmWCruJeHo1i/69lCQT3/CT9QdP347ubltih+R0Rq1rYyvpSoyi/sxE33Sih9jqstg/rPiGzVi7Z13CTBS+OPP7dLVRe0k3TSYJs0zGpigdGxP8KAFhoMYaMpHlY7AUnBVhpHA+46Ox+9dW+ilNQAJ2FYxXxTys3lYBsv9nHwB7xDDd0a4pYqme/g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2795a51d-eb7c-45cf-c0bb-08df2b558b1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 07:17:31.5750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x15EcWbpGEovFz/jKH9JV+t5uFVQvEc/t4dOSL697mkf3YxGotjePpU/xkWyjlRzjqy7dCxHTDXNfx870UVSMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7746
X-OriginatorOrg: intel.com

K0FuZWVzaC4NCg0KPiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0K
PiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMTYsIDIwMjYgMzowMyBQTQ0KPiANCj4gT24gMTAvMTYv
MjAyNiAxOjM3IEFNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gVGh1LCBPY3QgMTUs
IDIwMjYgYXQgMDQ6MzE6MzFQTSArMDgwMCwgWHUgWWlsdW4gd3JvdGU6DQo+ID4NCj4gPj4gQW4g
YWx0ZXJuYXRpdmUgY291bGQgYmUsIGJyaW5naW5nIHVwIG9uZSBJT01NVSB3aGVuIGFuIGFzc29j
aWF0ZWQNCj4gPj4gZGV2aWNlIHJlcXVlc3RzIGxpbmsgZW5jcnlwdGlvbi4gVGhlbiBhIG5vLXRk
eC1zdXBwb3J0IGlvbW11IGZhaWxzIHRoZQ0KPiA+PiBlbmNyeXB0aW9uIHJlcXVlc3QgbmF0dXJh
bGx5Lg0KPiA+IFRoYXQgaXMgd2hhdCBBUk0gaXMgcGxhbm5pbmcgdG8gZG8uIEkgdGhpbmsgaXQg
aXMgcmVhc29uYWJsZSB0bw0KPiA+IHRyaWdnZXIgY3JlYXRpb24gb2YgdGhlIHNlY3VyZSBpb21t
dSB3aGVuIHRoZSBUU00gaXMgY29ubmVjdGVkIHRvIFREWC4NCj4gPg0KPiA+IEZhaWwgY29ubmVj
dCBpZiB0aGUgaW9tbXUgY291bGQgbm90IGJlIGNyZWF0ZWQuDQo+IA0KPiBZZXMsIGFncmVlZC4g
VGhlIEludGVsIGlvbW11IGRyaXZlciBjb3VsZCB1c2UgcGVyLWRldmljZSBpbnRlcmZhY2VzLA0K
PiBqdXN0IGFzIEFSTSBpcyBwbGFubmluZy4gVGhlcmUgYXJlIHNvbWUgZGlmZmVyZW5jZXMsIHRo
b3VnaC4NCj4gDQo+IEFSTSdzIGludGVyYWN0aW9uIHdpdGggdGhlIGlvbW11IGRyaXZlciBpbiB2
aW9tbXVfaW5pdCgpIGFwcGVhcnMgdG8NCj4gY29uc2lzdCBvZiB0d28gc3RlcHM6DQo+IA0KPiAg
IC0gYXJtX3NtbXVfZ2V0X3JlYWxtX3BhcmFtcyhkZXYsICZwYXJhbXMpOiBnZXQgYW5kIHZhbGlk
YXRlIHRoZQ0KPiAgICAgcGh5c2ljYWwgaW9tbXUgaW5mb3JtYXRpb24gZnJvbSB0aGUgYXJtLXNt
bXUtdjMgZHJpdmVyOw0KPiAgIC0gY2NhX3BzbW11X2dldCgmcGFyYW1zKTogYWN0aXZhdGUgdGhl
IHBoeXNpY2FsIHNtbXUgZm9yIFJlYWxtIHVzZS4NCj4gDQo+IEludGVsIGRpZmZlcnMgaW4gdHdv
IHdheXM6DQo+IA0KPiAgIC0gQVJNIHF1ZXJpZXMgdGhlIHBoeXNpY2FsIGlvbW11IGluZm9ybWF0
aW9uIGZyb20gdGhlIGlvbW11IGRyaXZlcg0KPiAgICAgaW4gdGhlIHZpb21tdV9pbml0KCkgcGF0
aC4gT24gSW50ZWwsIHRoZSBzZWN1cmUgaW9tbXUgbXVzdCBiZSBzZXQNCj4gICAgIHVwIGR1cmlu
ZyBUU00gY29ubmVjdCwgYmVjYXVzZSBpdCBpcyBwYXJ0IG9mIGVzdGFibGlzaGluZyBQQ0llDQo+
ICAgICBsaW5rIGVuY3J5cHRpb24uDQoNCk15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0aGUgcHNt
bXUgaXMgcmVxdWlyZWQgZm9yIGxpbmsgZW5jcnlwdGlvbiwgc28NCml0J3Mgc2ltaWxhciBvcmRl
cmluZyBoZXJlIGkuZS4gYWN0aXZhdGVkIGJlZm9yZSB0c20gY29ubmVjdD8NCg0KPiANCj4gICAt
IFRoZSBURFggQ29ubmVjdCBhcmNoaXRlY3R1cmUgcGxhY2VzIHJlcXVpcmVtZW50cyBvbiB0aGUg
aG9zdA0KPiAgICAgaW9tbXUgZHJpdmVyIHdoaWxlIHRoZSBzZWN1cmUgSU9NTVUgaXMgYmVpbmcg
c2V0IHVwLiBGb3IgZXhhbXBsZSwNCj4gICAgIHRoZSBob3N0IGlvbW11IGRyaXZlciBtdXN0IGJs
b2NrIHRoZSBlbmhhbmNlZCBjb21tYW5kIChFQ01EKQ0KPiAgICAgaW50ZXJmYWNlIHdoaWxlIHRo
ZSBUREguSU9NTVUuU0VUVVAgU0VBTUNBTEwgcnVucywgYW5kIGl0IG11c3QNCj4gICAgIHJlc2Vy
dmUgdGhlIHVwcGVyIGhhbGYgb2YgdGhlIGRvbWFpbiBJRCBzcGFjZS4gVGhlc2Ugc3RlcHMgaGF2
ZQ0KPiAgICAgdG8gaGFwcGVuIGF0b21pY2FsbHkgdW5kZXIgdGhlIGlvbW11IGRyaXZlcidzIG93
biBsb2Nrcy4gQXMgYQ0KPiAgICAgcmVzdWx0LCB0aGUgSW50ZWwgaW9tbXUgZHJpdmVyIG5lZWRz
IHRvIG1lcmdlIHRoZSB0d28gc3RlcHMgYWJvdmUNCj4gICAgIGludG8gb25lLg0KDQpEaWRuJ3Qg
Z2V0IHRoaXMuIEJvdGggRUNNRCBhbmQgRElEIHJlc2VydmF0aW9uIGFyZSBURFggc3BlY2lmaWMg
dGhpbmdzLg0KSG93IGFyZSB0aGV5IHJlbGF0ZWQgdG8gdGhlIHR3byBzdGVwcyBpbiB0aGUgQVJN
IHNpZGVzIGFuZCB3aHkgY2FsbHMNCmZvciBtZXJnaW5nPw0KDQphbmQgd2h5IGFyZSB0aGV5IG11
c3QgYmUgZG9uZSBhdG9taWNhbGx5PyB0aGV5IGFyZSBjb25kaXRpb25zIHRvDQpleGVjdXRlIFRE
SC5JT01NVS5TRVRVUCwgYnV0IGl0IGlzIHBlcmZlY3RseSBmaW5lIHRvIHJlc2VydmUgRElEDQph
dCBhbiBlYXJseSBwb2ludCB0aGVuIGJsb2NrIEVDTUQgbGF0ZXIuLi4NCg0KPiANCj4gU28gdGhl
IEludGVsIGlvbW11IGRyaXZlciB3aWxsIHByb2JhYmx5IGVuZCB1cCB3aXRoIGludGVyZmFjZXMg
bGlrZToNCj4gDQo+ICAgLSBkbWFyX3RkeGNzX2lvbW11X2luaXQoc3RydWN0IGRldmljZSAqZGV2
LCAuLi4pOw0KPiAgIC0gZG1hcl90ZHhjc19pb21tdV9yZWxlYXNlKHN0cnVjdCBkZXZpY2UgKmRl
diwgLi4uKTsNCj4gDQo+IFRoZXNlIHdvdWxkIGJlIGNhbGxlZCBmcm9tIHRoZSBjb25uZWN0IGFu
ZCBkaXNjb25uZWN0IGNhbGxiYWNrcyBvZg0KPiB0aGUgVERYIGxpbmsgb3BzOg0KPiANCj4gc3Rh
dGljIHN0cnVjdCBwY2lfdHNtX29wcyB0ZHhfdHNtX2xpbmtfb3BzID0gew0KPiAgICAgICAgICAu
b3duZXIgPSBUSElTX01PRFVMRSwNCj4gICAgICAgICAgLnByb2JlID0gdGR4X3RzbV9saW5rX3By
b2JlLA0KPiAgICAgICAgICAucmVtb3ZlID0gdGR4X3RzbV9saW5rX3JlbW92ZSwNCj4gICAgICAg
ICAgLmNvbm5lY3QgPSB0ZHhfdHNtX2xpbmtfY29ubmVjdCwNCj4gICAgICAgICAgLmRpc2Nvbm5l
Y3QgPSB0ZHhfdHNtX2xpbmtfZGlzY29ubmVjdCwNCj4gLi4uDQo+IH07DQo+IA0KPiBBbnkgdGhv
dWdodHM/DQo+IA0KPiBUaGFua3MsDQo+IGJhb2x1DQo=
