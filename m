Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2E21922F9
	for <iommu@lists.linux.dev>; Wed, 18 Dec 2024 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513193; cv=fail; b=WfIQfj1gYm2N3L84PfYY2sPHkb1FxEsKZPAL7Sq4O4QpNPXK3XmJw+Iwtl/MmQqHsWWmsQOMP5E7dYuo/jyWMTjs8maQ/56fjz7AQb++q/dBGhP4SeebDSA3Ir1cwprPStW/2fuB6VqCfmF/CcFAlGXJ0k0czDeERBqw5R3Df+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513193; c=relaxed/simple;
	bh=vpXdgCYsYIhgGf7QLricrWFmiS6NWpjxzJ/7TlCuMKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U+etNRjjjxP6i8Hbny8RSKt+B7n0FGXEt8vGTT9VyfAZqmrR3Qb6ChMRnXAWIDmtqG6V/b7HsP9xG9ffcn8k6p0Dl9Xd+Ur5Vd4KCEK8z9OMAbOf9Sj6th+rrsuJf96AaPsK8tZ5sFxRFi1RSniF4SD3VJHm4WCwMPM40wM54rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Igrufc8v; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Igrufc8v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734513191; x=1766049191;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vpXdgCYsYIhgGf7QLricrWFmiS6NWpjxzJ/7TlCuMKI=;
  b=Igrufc8vjDPfYhS3iBr5g0U/uSGI8NDQWAXwJVLX5xZZ+M73ZNElbCxX
   XxaB3WLI2Hw4kDwm7DH55rDW34LadhmRBRBt0jZ7FD2dAyjXpzMo1g7H1
   YEyt3q2pi8RCyO7UpPQdarHdXZBxfscuHb+u+NGK59/9GYKR8j4lzFAjG
   wmlfrtRVnkHFf1I7VE/rYz+CVG4CfE0GhUXYsjfn6f2qArjnlboB3npYB
   VyI1AScSSbVjqowe5rnVUfXIO2L7BBhULOVmFcpSL9TZMlJKq/zn8PKlS
   7t1ze0Vgbx3z/wtvXP222R7lJcDgpw/xS9Dk29te0jl6qM0QqIf90ZUBW
   g==;
X-CSE-ConnectionGUID: Jh9pype0QPuTpW6qwXitWg==
X-CSE-MsgGUID: /UazxweeQ5O05/4+PIfEVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="45578520"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="45578520"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 01:13:07 -0800
X-CSE-ConnectionGUID: aqSsez6rRhSEwJhEBGbTvw==
X-CSE-MsgGUID: e0EgxvrWTOOvIrzo7HwlTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98269343"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2024 01:13:06 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 01:13:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 01:13:05 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 01:13:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCUNG9a+yhcPC8l5+vC21w1glvq8zzcxeQq5NhZPfC707vyUY8oAE+yAydATfeukycgoICH2foxNPKhPyalo4hJTGN38NhXU4vl+J0baXTgGqaSenpGShc6ZdRuBB49tkSE5B1rKJ0W02Uf9KNWxVLCbgzEPf01EOxHk8jWysKLT7xZp+os+UeylCtSjcH62j7+YxOfjZunoPWjeGtN2sRFjwfLIs5hfmmuDZ+jF5ajjV45/CYJLzPWgqEwaxnQjbqhZSn8eym4TaiTFI9/0ran+LW+yiTznA7iSQ4pn4Rt4mNUEY7K6B7DuYUdDAtmwiYXEsajWYCfDEypreN6V6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpXdgCYsYIhgGf7QLricrWFmiS6NWpjxzJ/7TlCuMKI=;
 b=RU9M+oUZdlcT1c/TiEVf5NK/70OycZQbVbBLf0v0jDbksrskm0yReImIelE8gCwlLjLY8N/k/sUD9+SGNLjKG9urHmho9w0ZZtGMlDb1+o0hjhHjko9T2JdzkEpoeE85UDG/HwJcAJiJ0A68LZMc4DcOHFAQZBaXUR+gC8iNed661Sbvtgo7VmxJBMNUY4INcRCRKMfK7ZH0PUpwSHQt6MTfDJ9CVRjhgCjVepypz5U8XKd1pVo6n8oHigh5BlUccsM0qFLc5aoQJnEHMZUkmyXCUiJGPZAU6czR+avBqrcrxz7UxUfRjPnjxNLNFnbhfeWxGZfwKUJ607pRSOVJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 09:12:34 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 09:12:34 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH] iommu/vt-d: Link cache tags of same iommu unit together
Thread-Topic: [PATCH] iommu/vt-d: Link cache tags of same iommu unit together
Thread-Index: AQHbT2xqZZ8n3WRerEuUJDS85GVzRLLrVXWAgAAj+TCAAD/egIAAAYPw
Date: Wed, 18 Dec 2024 09:12:34 +0000
Message-ID: <SJ0PR11MB6744B797F0607503FC00E03192052@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241216033809.170366-1-zhenzhong.duan@intel.com>
 <897738ba-5c1f-4d42-bf10-402d59e3f430@linux.intel.com>
 <SJ0PR11MB6744DB1AE24115FD44B390B492052@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <494d6b30-acde-4538-8f0f-e669812c3a00@linux.intel.com>
In-Reply-To: <494d6b30-acde-4538-8f0f-e669812c3a00@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA0PR11MB8335:EE_
x-ms-office365-filtering-correlation-id: 424e12a0-a053-4c33-a9c9-08dd1f441bf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WDIrSHVFWlp5dTY4L25oUUU1b2paZmZnclkxUENmQ2tmM05WbXhmTXJGajBV?=
 =?utf-8?B?WU5XbzVodnFzc1I1Zk5MN0VEVGlNYXZJQ1J4Vm9zL2hRd0RtM2E2ajRsUXFl?=
 =?utf-8?B?YUpVWFVuK1BtQ0I2R2dRemhYTHFaaXpGeEg5NGRBYWM4eWV6Zk9kSm9xdlRI?=
 =?utf-8?B?emxSVFFYaDZTdGYweWo5TGdIOEZ5OHlkUDZaMzg5UmVhRy9qeFVqMVVEY1B2?=
 =?utf-8?B?QnhUZ2duL3dmMVhyWlJSTnlsOUFYekNaQ2VwRUxEbk55eVBUdHo0MStFRU52?=
 =?utf-8?B?bXdzM21jNU4raVVTaEQ3UEN4bjBrSzBmc2E4V0JVZGt3a000eUorOFJpaVRy?=
 =?utf-8?B?ai9BemlJTHBXakIwRE1WYjQ5Y1plczV0YndadGJENnRyNjhLeFBkMkZZTXVE?=
 =?utf-8?B?NW83eksybFJ1VmpIMitiUHVDSlFGMW16UVZUanRGNXpvdXVVZzVLb05hdy9u?=
 =?utf-8?B?cVRBTGZGT1JMMHRrdmZHdkM1QmpVazRFMmJiWkF4TWFKTWhIQ3pCc1hIY0ZD?=
 =?utf-8?B?YTZ5TlJidXhXZCs5Z3hQT0hkZmhEOFl0bE5TcHFDREhuOG8xUUdmcEJDcW9v?=
 =?utf-8?B?UnRJdnV1THJKQXk1eFcrVTl4eGVsaVdrMmFQWUx5TlR0U2luUmNZd0VpV0ly?=
 =?utf-8?B?RTZOMHFyRGR0d1Y4eGRJb3NZZUI0aFNzcUtXTGF4ZVRkM0I3ejVJTjJSZWlY?=
 =?utf-8?B?bUVpUGtyZ25xbmorR0Z2ckViMWcyRkVaS0VpZGdlZWhlWUgyM0drS01WVER1?=
 =?utf-8?B?ai9FN3hlcHB3a09wZnEwbkNJMUQrTnhrU3ByVDNyNjlGQkRyVm9uaXRYcTJW?=
 =?utf-8?B?eVBaMktFTmsrTmswUlI1MUxYRkdsaDhjVHJBZ0dPRW04WjhHby9pRWRFQ1BZ?=
 =?utf-8?B?Q3JIOWJBd2xGTzQ2emtvb2ZVeHg2NWlzZDhRa0E5MlVUK1p4aW5xMk1qTXV4?=
 =?utf-8?B?UHUxS0JoMEcrRUVINiszSjRJS2ZDT2kreXkwZExKb0RYMXNUODhFdS95VEtS?=
 =?utf-8?B?c2FVV09IaUI1Z29SQWlNRlRFR3lqb0ZqYkplLytFVDdhdnpFeGtrQUdjU2k3?=
 =?utf-8?B?U2hvZkdKS09tMndoeGkyemhvQ1BVYS9hYVpBVmIwYi9iMHVxTEFpR2kvQUhw?=
 =?utf-8?B?Vk9sUjlEQjJYcDVjU3ViYWduK1RzYlhvQVQwQWVJRjdoZFhBR2dwelFwU1FY?=
 =?utf-8?B?QS80UHh0ZUxGU3Q3aXZYa2NnYnVkdldIZm93cVYwQ1g2M3QwVDNPWEdFcFR5?=
 =?utf-8?B?R0FMak0yTVNyRkE5SGhJNXNjcWdFdnphNWg4dytUbzhPTHQyQTRhektsYkxE?=
 =?utf-8?B?ajBIeVdlT0xVRzYvYStnT29rUTJOQXpHckRIdHV3cG1wQjJ3aTZFNWJhZFJH?=
 =?utf-8?B?anhNeUZKcnJmTGtEYmZnNG1DaXJLZXg2Y2k3bXY4TzYxcUZjQ1NxQVJuWWdG?=
 =?utf-8?B?c1BDR0NwNEdWZGgrQjBuQ0tYSmtyYitGcVZIcDFJalRhZmtIeTlOS2d2Snhv?=
 =?utf-8?B?Mm1wU0hzMFBLcnlJNCt4WG1ubWxkUmkrNDNPay83WHo5Znd3cHhEdTRIMW92?=
 =?utf-8?B?VFRUcm5uMWY4Rk55YWdkQ0JmSXU5V0ZuV29NMmV2bWNseWNySEJoTGZqeEdG?=
 =?utf-8?B?ODgyMXZKejVtZ0RPai96V1lqdHNHeFNBNW05MlZHQ1ByYzJCejFtWUNTQkU2?=
 =?utf-8?B?bFk0L2tQM2w2dFdGRDRVMmhRZGtrYnNZNTJRTTVHV3VnbWlYRHJNVkt3cXMx?=
 =?utf-8?B?NURJMGRxZlQ2VTA4czRSM3lNSGUxRUdNZUg0djFadDhocXQxRXJRWHpPNXNk?=
 =?utf-8?B?Uno0UnhYOHh2V21oYmdTQXJkamJ1T281UmEveTUrcnJWdm5xVnBZSDNydU9z?=
 =?utf-8?B?djdCTS9UOExwU0FSQzdIUTR0enk0WFJaRkNIdURCcS94QUtmTVVjTmt3eFRP?=
 =?utf-8?Q?bwhEzV4yA0Mj2gDxx8Y/ju0vx1SBjzuf?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2wyTzVmVm5lMWplUlB1d0R3Y1p3MzRRUmFSQjUwSG4wWVQ1WVJ2VW00YWJN?=
 =?utf-8?B?blp0ZXJUOWNkQ2JlbUhtbzUvbGN5OVZvV0c5TmlZSnROdHUweGNGQ2tkRm04?=
 =?utf-8?B?aW9zdEhEY1M5enZ5OUptUVdhRUFOQ3dxekpHSS9YcTFheWN6RlMrbXpjZHl4?=
 =?utf-8?B?RWZPNlFPMktFUDcwUTFGU2VBeXZFcXpwT0NOK3A5TUVKRmpYQWsxRjZXclpD?=
 =?utf-8?B?aTl5ZWRqdUwvelBGYkZXbGc3dWNmVGF0YXdmKzd4MHcxUkQxMERMYkFxYldi?=
 =?utf-8?B?Uys5K2RYTVRHVXhxdVVhbVh4MEZiZmx1WVZQM2hJMGNWLzFwUWJIeXJKZk9a?=
 =?utf-8?B?SjI4K3Z4YTkxZXA5U09ncDlwVHl3cUZOSWpzSGw1eG41YmlnYTIrUXVzVU5R?=
 =?utf-8?B?VVNYNC9lTlA3eGxaS1lxUXE4WDdmTnNVenJOdkI1cWpaUTFETk56SUIxbFFt?=
 =?utf-8?B?dkl3K3pIbWdnMmdWc1V1U1ZEeElBRVBxOVRRdmxxOHc3YW1FUk9vWk55emo1?=
 =?utf-8?B?TWlFZ0FuZUVtbVdzR0E0bkFiNUQwQVJQY3J5R1JLMFZ3aU9EN21HSWJ3TTZM?=
 =?utf-8?B?SUh3MXI3QlpEQjVxV1dZRkp1MEh0SitJTk9XK3dyOXNmdmp2VjlnSkNsYWND?=
 =?utf-8?B?ZnZaRUluSWRFY2pTMHRXUnZVR0d3SFgyeHVXS0F6RVpPRUtsOGxmN09PK2ts?=
 =?utf-8?B?WTRiNEpkaHBiRkxMdlJWdVUvOFJLbmN1SDh0WGN3SG1TQms1TGdVZWorUmND?=
 =?utf-8?B?c1NHbXpWa2dEOFk1Y0dOdk16SGIrSmV2QkZTTm1ocVRqRG9OR1FpRXpMRVlC?=
 =?utf-8?B?blVLR0pnZ0NndDl2cnNYWVVrenp4ZHdMMUxQUG5ZT29ranptSUI1bkJWT2ln?=
 =?utf-8?B?WTZ3alF5VFd4RnFBcnZDY1VLNlkvSXpsLzB0S1RNcHhZN21RTWVFVlArQnBG?=
 =?utf-8?B?cDVFZFpodjA0VTBYTnhGUWFGNVFPS3diejZ5TUVuZkJVeHJvYy84bE5uNFc4?=
 =?utf-8?B?T1liYnYxbmdUUFJBWTUvWWZkeHplTFFNTjRES2FSMDF2VU5vOXE2OExoSUdI?=
 =?utf-8?B?WVZkeno3R1R3OFp2MjlWNmp2NUc5ZlVEV2pad09jNnU5OVFJWUV2YWEvU284?=
 =?utf-8?B?UEZ4MUVpZjY1dzBxb011THhJbWJiaUsvTTk2QWM3ZmlMeXo1aktBeHdOOXQ5?=
 =?utf-8?B?NmI2YjloOWxnSWR0TGNleFd2Z0JHNHBSZEpVYVJuSk91QTkvMURBRzlJcW5D?=
 =?utf-8?B?bXBxRkJNaGxCZVYyYXpHZDFVWTVlUUp4ZjhYbXBBcURoMEF2Rm03ME8vWDFz?=
 =?utf-8?B?ZmJtMXZVMDB3RTVxS2xEK1VtbUdENkdRNTFvQ2E3Y29YRmJoZVBCamd1dHlR?=
 =?utf-8?B?VW1XNDhJSmFGbFl6Tjd1eDRKWkUyeEVLSXg1MnVtU2Zud3o4U0FkSkc1amk1?=
 =?utf-8?B?Y1JGVmx6eTZ1dW9zMkVLcDFoc0M3QjdxbU0ycWE4RzR6T3I1c3Jzb1FOLytT?=
 =?utf-8?B?bjZ0TFRlWG5rOWZjbFVoUC9DNTF3M1Rhb0dhMmMzUUJSZlRUYjNFMWlwUTZw?=
 =?utf-8?B?L1orMFE2SlFKNDBNamJiN21wbUF6THc5Mm1QSG9QcWo2K1RMNWgrcTJMendi?=
 =?utf-8?B?NmNPYm1TN1hhcWU2ZEVQbmVzZ09HZ1VMa1FBOCsxYzFtWFkwSzJQU21kTXBm?=
 =?utf-8?B?T090ZFpUem1yM082ZFdiMXdhZ0VjUDVPRnZSRlErMlFQWmJ2TDhoZDIvME1X?=
 =?utf-8?B?SDBJTTFjS2VGTGpYZWpScWJzeEliekQzQVEwKzFvTGpWZk5KdVhzZU13U0dy?=
 =?utf-8?B?V291Ri9Iazc0clBtSjZBazNpaThIUlM1UVhSWk9rdlgrcU5CR1FWWDEwUUNs?=
 =?utf-8?B?L0FCVC9IaThTQXlsV1VENnpJam9VVzF3NVljbWU4K3N4elcrSTgrT0lnaVJV?=
 =?utf-8?B?QUlqZVhvR1EvUllqZkN6cUFqV3p2K3F5QXhXcWxjM3lFQ2J2Z2FzU1lUNFpm?=
 =?utf-8?B?aFF1SE95aUl2dTUxeDFGRFR2b290SVE1WFk4aDN1SXJ2ZklkbVgxd1hwUUF3?=
 =?utf-8?B?eG1wejhtaUVuelJ4dWk1d3BpMmJTMk9qTkxNN3NkZjB5ZEVDbUV6eXVMNDFP?=
 =?utf-8?Q?KJ1PiCRr7Ffg2MNznNbx2n2Rq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424e12a0-a053-4c33-a9c9-08dd1f441bf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 09:12:34.3914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5HfsF+cjFAu81vsJwxAJnvWU6tFZEbWw3EjGI46IUqh2M78c8HrEGoxvWyzPiWd1hjBm5NjyVm4GpY7HGr19KuDJupSRFks96GB/hR7PF/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEJhb2x1IEx1IDxiYW9sdS5s
dUBsaW51eC5pbnRlbC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gaW9tbXUvdnQtZDogTGlu
ayBjYWNoZSB0YWdzIG9mIHNhbWUgaW9tbXUgdW5pdCB0b2dldGhlcg0KPg0KPk9uIDIwMjQvMTIv
MTggMTM6MjIsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPj4+IEZyb206IEJhb2x1IEx1PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4+
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBpb21tdS92dC1kOiBMaW5rIGNhY2hlIHRhZ3Mgb2Ygc2Ft
ZSBpb21tdSB1bml0DQo+dG9nZXRoZXINCj4+Pg0KPj4+IE9uIDEyLzE2LzI0IDExOjM4LCBaaGVu
emhvbmcgRHVhbiB3cm90ZToNCj4+Pj4gQ2FjaGUgdGFnIGludmFsaWRhdGlvbiByZXF1ZXN0cyBm
b3IgYSBkb21haW4gYXJlIGFjY3VtdWxhdGVkIHVudGlsIGENCj4+Pj4gZGlmZmVyZW50IGlvbW11
IHVuaXQgaXMgZm91bmQgd2hlbiB0cmF2ZXJzaW5nIHRoZSBjYWNoZV90YWdzIGxpbmtlZCBsaXN0
Lg0KPj4+PiBCdXQgY2FjaGUgdGFncyBvZiBzYW1lIGlvbW11IHVuaXQgY2FuIGJlIGRpc3RyaWJ1
dGVkIGluIHRoZSBsaW5rZWQgbGlzdCwNCj4+Pj4gdGhpcyBtYWtlIGJhdGNoZWQgZmx1c2ggbGVz
cyBlZmZpY2llbnQuIEUuZy4sIG9uZSBkZXZpY2UgYmFja2VkIGJ5IGlvbW11MA0KPj4+PiBpcyBh
dHRhY2hlZCB0byBhIGRvbWFpbiBpbiBiZXR3ZWVuIHR3byBkZXZpY2VzIGF0dGFjaGluZyBiYWNr
ZWQgYnkgaW9tbXUxLg0KPj4+Pg0KPj4+PiBHcm91cCBjYWNoZSB0YWdzIHRvZ2V0aGVyIGZvciBz
YW1lIGlvbW11IHVuaXQgaW4gY2FjaGVfdGFnX2Fzc2lnbigpIHRvDQo+Pj4+IG1heGltaXplIHRo
ZSBwZXJmb3JtYW5jZSBvZiBiYXRjaGVkIGZsdXNoLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5
OiBaaGVuemhvbmcgRHVhbjx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4+IC0tLQ0KPj4+
PiAgICBkcml2ZXJzL2lvbW11L2ludGVsL2NhY2hlLmMgfCAxMSArKysrKysrKysrLQ0KPj4+PiAg
ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+Pg0K
Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9jYWNoZS5jIGIvZHJpdmVycy9p
b21tdS9pbnRlbC9jYWNoZS5jDQo+Pj4+IGluZGV4IGU1Yjg5ZjcyOGFkMy4uNzI2MDUyYTg0MWUw
IDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2NhY2hlLmMNCj4+Pj4gKysr
IGIvZHJpdmVycy9pb21tdS9pbnRlbC9jYWNoZS5jDQo+Pj4+IEBAIC00OCw2ICs0OCw4IEBAIHN0
YXRpYyBpbnQgY2FjaGVfdGFnX2Fzc2lnbihzdHJ1Y3QgZG1hcl9kb21haW4NCj4qZG9tYWluLA0K
Pj4+IHUxNiBkaWQsDQo+Pj4+ICAgIAlzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlvbW11ID0gaW5mby0+
aW9tbXU7DQo+Pj4+ICAgIAlzdHJ1Y3QgY2FjaGVfdGFnICp0YWcsICp0ZW1wOw0KPj4+PiAgICAJ
dW5zaWduZWQgbG9uZyBmbGFnczsNCj4+Pj4gKwlzdHJ1Y3QgY2FjaGVfdGFnICp0ZW1wMiA9IGxp
c3RfZW50cnkoJmRvbWFpbi0+Y2FjaGVfdGFncywNCj4+Pj4gKwkJCQkJICAgICBzdHJ1Y3QgY2Fj
aGVfdGFnLCBub2RlKTsNCj4+PiBJcyB0aGlzIHZhbGlkIGZvciBhIGxpc3QgaGVhZD8NCj4+IFll
cywgaXQncyBub3QgdmFsaWQgZm9yIGxpc3QgaGVhZCBidXQgaXQncyBpbnRlbnRpb25hbCwganVz
dCB3YW50IHRvDQo+PiBhdm9pZCB1bm5lY2Vzc2FyeSB0ZW1wMiBjaGVjay4gSWYgSSBkb24ndCBk
byB0aGF0IHdheSwgcGF0Y2ggd2lsbCBiZToNCj4+DQo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2lu
dGVsL2NhY2hlLmMNCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvY2FjaGUuYw0KPj4gQEAg
LTQ4LDYgKzQ4LDcgQEAgc3RhdGljIGludCBjYWNoZV90YWdfYXNzaWduKHN0cnVjdCBkbWFyX2Rv
bWFpbiAqZG9tYWluLA0KPnUxNiBkaWQsDQo+PiAgICAgICAgICBzdHJ1Y3QgaW50ZWxfaW9tbXUg
KmlvbW11ID0gaW5mby0+aW9tbXU7DQo+PiAgICAgICAgICBzdHJ1Y3QgY2FjaGVfdGFnICp0YWcs
ICp0ZW1wOw0KPj4gICAgICAgICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4+ICsgICAgICAgc3Ry
dWN0IGNhY2hlX3RhZyAqdGVtcDIgPSBOVUxMOw0KPj4NCj4+ICAgICAgICAgIHRhZyA9IGt6YWxs
b2Moc2l6ZW9mKCp0YWcpLCBHRlBfS0VSTkVMKTsNCj4+ICAgICAgICAgIGlmICghdGFnKQ0KPj4g
QEAgLTczLDggKzc0LDE4IEBAIHN0YXRpYyBpbnQgY2FjaGVfdGFnX2Fzc2lnbihzdHJ1Y3QgZG1h
cl9kb21haW4NCj4qZG9tYWluLCB1MTYgZGlkLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAg
IHRyYWNlX2NhY2hlX3RhZ19hc3NpZ24odGVtcCk7DQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIDA7DQo+PiAgICAgICAgICAgICAgICAgIH0NCj4+ICsgICAgICAgICAgICAgICBp
ZiAodGVtcC0+aW9tbXUgPT0gaW9tbXUpDQo+PiArICAgICAgICAgICAgICAgICAgICAgICB0ZW1w
MiA9IHRlbXA7DQo+PiAgICAgICAgICB9DQo+PiAtICAgICAgIGxpc3RfYWRkX3RhaWwoJnRhZy0+
bm9kZSwgJmRvbWFpbi0+Y2FjaGVfdGFncyk7DQo+PiArICAgICAgIC8qDQo+PiArICAgICAgICAq
IExpbmsgY2FjaGUgdGFncyBvZiBzYW1lIGlvbW11IHVuaXQgdG9nZXRoZXIsIHNvIGNvbnNwb25k
aW5nDQo+PiArICAgICAgICAqIGZsdXNoIG9wcyBjYW4gYmUgYmF0Y2hlZCBmb3IgaW9tbXUgdW5p
dC4NCj4+ICsgICAgICAgICovDQo+PiArICAgICAgIGlmICh0ZW1wMikNCj4+ICsgICAgICAgICAg
ICAgICBsaXN0X2FkZCgmdGFnLT5ub2RlLCAmdGVtcDItPm5vZGUpOw0KPj4gKyAgICAgICBlbHNl
DQo+PiArICAgICAgICAgICAgICAgbGlzdF9hZGRfdGFpbCgoJnRhZy0+bm9kZSwgJmRvbWFpbi0+
Y2FjaGVfdGFncyk7DQo+PiArDQo+PiAgICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZk
b21haW4tPmNhY2hlX2xvY2ssIGZsYWdzKTsNCj4+ICAgICAgICAgIHRyYWNlX2NhY2hlX3RhZ19h
c3NpZ24odGFnKTsNCj4NCj5QZXJoYXBzIHdlIGNhbiBtYWtlIGl0IGxpa2UgdGhpcz8NCg0KR29v
ZCBzdWdnZXN0aW9uISBXaWxsIGRvLg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+ZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvY2FjaGUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwv
Y2FjaGUuYw0KPmluZGV4IDA5Njk0Y2NhODc1Mi4uY2YwY2NhOTRkMTY1IDEwMDY0NA0KPi0tLSBh
L2RyaXZlcnMvaW9tbXUvaW50ZWwvY2FjaGUuYw0KPisrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwv
Y2FjaGUuYw0KPkBAIC00Nyw2ICs0Nyw3IEBAIHN0YXRpYyBpbnQgY2FjaGVfdGFnX2Fzc2lnbihz
dHJ1Y3QgZG1hcl9kb21haW4NCj4qZG9tYWluLCB1MTYgZGlkLA0KPiAgICAgICAgIHN0cnVjdCBk
ZXZpY2VfZG9tYWluX2luZm8gKmluZm8gPSBkZXZfaW9tbXVfcHJpdl9nZXQoZGV2KTsNCj4gICAg
ICAgICBzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlvbW11ID0gaW5mby0+aW9tbXU7DQo+ICAgICAgICAg
c3RydWN0IGNhY2hlX3RhZyAqdGFnLCAqdGVtcDsNCj4rICAgICAgIHN0cnVjdCBsaXN0X2hlYWQg
KnByZXY7DQo+ICAgICAgICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4NCj4gICAgICAgICB0YWcg
PSBremFsbG9jKHNpemVvZigqdGFnKSwgR0ZQX0tFUk5FTCk7DQo+QEAgLTY1LDYgKzY2LDcgQEAg
c3RhdGljIGludCBjYWNoZV90YWdfYXNzaWduKHN0cnVjdCBkbWFyX2RvbWFpbg0KPipkb21haW4s
IHUxNiBkaWQsDQo+ICAgICAgICAgICAgICAgICB0YWctPmRldiA9IGlvbW11LT5pb21tdS5kZXY7
DQo+DQo+ICAgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJmRvbWFpbi0+Y2FjaGVfbG9jaywgZmxh
Z3MpOw0KPisgICAgICAgcHJldiA9ICZkb21haW4tPmNhY2hlX3RhZ3M7DQo+ICAgICAgICAgbGlz
dF9mb3JfZWFjaF9lbnRyeSh0ZW1wLCAmZG9tYWluLT5jYWNoZV90YWdzLCBub2RlKSB7DQo+ICAg
ICAgICAgICAgICAgICBpZiAoY2FjaGVfdGFnZV9tYXRjaCh0ZW1wLCBkaWQsIGlvbW11LCBkZXYs
IHBhc2lkLCB0eXBlKSkgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICB0ZW1wLT51c2Vycysr
Ow0KPkBAIC03Myw4ICs3NSwxNSBAQCBzdGF0aWMgaW50IGNhY2hlX3RhZ19hc3NpZ24oc3RydWN0
IGRtYXJfZG9tYWluDQo+KmRvbWFpbiwgdTE2IGRpZCwNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgdHJhY2VfY2FjaGVfdGFnX2Fzc2lnbih0ZW1wKTsNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIDA7DQo+ICAgICAgICAgICAgICAgICB9DQo+KyAgICAgICAgICAgICAgIGlmICh0
ZW1wLT5pb21tdSA9PSBpb21tdSkNCj4rICAgICAgICAgICAgICAgICAgICAgICBwcmV2ID0gJnRl
bXAtPm5vZGU7DQo+ICAgICAgICAgfQ0KPi0gICAgICAgbGlzdF9hZGRfdGFpbCgmdGFnLT5ub2Rl
LCAmZG9tYWluLT5jYWNoZV90YWdzKTsNCj4rICAgICAgIC8qDQo+KyAgICAgICAgKiBMaW5rIGNh
Y2hlIHRhZ3Mgb2Ygc2FtZSBpb21tdSB1bml0IHRvZ2V0aGVyLCBzbyBjb25zcG9uZGluZw0KPisg
ICAgICAgICogZmx1c2ggb3BzIGNhbiBiZSBiYXRjaGVkIGZvciBpb21tdSB1bml0Lg0KPisgICAg
ICAgICovDQo+KyAgICAgICBsaXN0X2FkZCgmdGFnLT5ub2RlLCBwcmV2KTsNCj4rDQo+ICAgICAg
ICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZG9tYWluLT5jYWNoZV9sb2NrLCBmbGFncyk7DQo+
ICAgICAgICAgdHJhY2VfY2FjaGVfdGFnX2Fzc2lnbih0YWcpOw0KPg0KPlRoYW5rcywNCj5iYW9s
dQ0K
