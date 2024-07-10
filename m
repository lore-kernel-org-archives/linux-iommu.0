Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D4F1B86DD
	for <iommu@lists.linux.dev>; Wed, 10 Jul 2024 00:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720572552; cv=fail; b=drnXQNeweTkOFJYyIdGi3pVmPH1lYk87Q47cNYkzKIvi+YZWkfXD2IsgHFgyfJhdNEHS3CamHRky5MrkC6y8TQpAXbxL8EkVKy9MD3J1Wd00For8iIrh4qRu3+9jUQyf99R+Uv7OhSO1EMF7/aGAWe7E1E9sXRDDOP2rAzKNCFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720572552; c=relaxed/simple;
	bh=CUQH1oThzBU+RDyozmW87z+aurxahbR6FQ4FXkKGFPQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iV9zXDcEclB+DTAwnJjMGQttsMDl5gu0DYGiCg2iXKqZaWmtJOG3DtBaroxTrigj2leAkRvLbn1aVyGgBFzib3fdrZvDiK9YiRCxk4BCIdj+O4lh+LHbNWX35/ayotEPUk4+U68xNIfpm8Ed48FLoCwd627xeb2y/IZ05HS4Z/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLD18zio; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLD18zio"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720572550; x=1752108550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CUQH1oThzBU+RDyozmW87z+aurxahbR6FQ4FXkKGFPQ=;
  b=RLD18zioo1zr6Oe5jfb90nD+4QLiEQ4Lc9AyS8oTR/akMca8RV/LDGYd
   Ttqn8an6V7tIikuIjLYzvUdhX24KHL7P16cRfA8vz6CVJSJbJRFxXnvnK
   guTyHvK9DBfV3dckUgKQ3GaUKTOtiy6HZO6mIXfmsVXbiKcLjnln9Pt3J
   I0q1PhWLZ5Qm3xJvk3VXPTvSDvGmUEjb4buLq2zP5BrDhH+mtck77bNMJ
   35xt0Rmrrs++4ARS5w7YqISgCNorpNe/LgnWQu7aPxnwo0asCGNuSZpB9
   rB++E9CP3BPQVINvFMz4ib4Y3Gv87uEd2Mvv4U+LfoH1t76y+sUQMrGiW
   w==;
X-CSE-ConnectionGUID: wm6mxTB6RXKAZMoYFiFOnQ==
X-CSE-MsgGUID: j6O4UI9ASSucvTyT1/QT+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="18071714"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="18071714"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 17:49:09 -0700
X-CSE-ConnectionGUID: heVRpt1vS8C+BBNcYcaU3g==
X-CSE-MsgGUID: Zxci+/0BQgGVNFBfcGSwZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="48128868"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 17:49:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 17:49:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 17:49:07 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 17:49:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKwDTahhMjSbSx0XpMQGSLlG+TH9iG3ehTfnm0bDbyl6cxBi4xoVewqOYvu9chrteGcGhrUYQSK0YLtvwXjUWjgxao8T6YFiex+Fgx59djdGocPGkhc58MIVH6ouY99LrL2CuZ6zx+z256G1ivgCXBoji1xWHwozYfhdTKzOt0/ID3Om90Z7kNLCU7/M8/UHmZs/giOyjHadar9hS+95bPaDlL4tZWUJU6wS4XP/HvrpROV8u0OvnfN3vg7D7ZPtKz2mQZh4Da3JoXIAAviSzSBiuK6KBk5VQLW3V0e1H56LnLI80GoGou9z87ZgVPjOsEN3Z1SO0L4sBqoerCqH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUQH1oThzBU+RDyozmW87z+aurxahbR6FQ4FXkKGFPQ=;
 b=likTWafAtSpPlPQfKtGE1eQYiiFVdIkUseNoKhH9H3VRgX1YSnwjCl5cXPsJ6QSOrwE00ofqUJe5o7xOSLbBBqfL8xlfR7S0usMNjbfbI77Vi0sjq/vDwEw4ZwJ/1WDYYWBS3/z0o+19huavDv1mhIZugNK1CfMQ3fcY6wHlgpMJFgG8Whod+tXyWv8HqsEolzvIJCBU5FMOYlNUBFmsJ3j466RHYCFurYs2y1MF3P2S9HXv3/jYlqf+8/IYloJy8jQakOIQCuIFsjpefXoV/7QyNviO0gRoGj3fROjlCxfN8j4asaX3QfTESItfc44TXEDuAOM7xlSsS9/EY0A55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4567.namprd11.prod.outlook.com (2603:10b6:208:26d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 00:49:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 00:49:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jon Pan-Doh <pandoh@google.com>, David Woodhouse <dwmw2@infradead.org>, Lu
 Baolu <baolu.lu@linux.intel.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Tejun
 Heo <tj@kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sudheer
 Dantuluri" <dantuluris@google.com>, Gary Zibrat <gzibrat@google.com>
Subject: RE: [PATCH] iommu/vt-d: Fix identity map bounds in si_domain_init()
Thread-Topic: [PATCH] iommu/vt-d: Fix identity map bounds in si_domain_init()
Thread-Index: AQHa0lqjiv4OE3Sa00uKTzIlMgX44LHvIDLg
Date: Wed, 10 Jul 2024 00:49:05 +0000
Message-ID: <BN9PR11MB5276C05D3B3B8821420BBD6E8CA42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240709234913.2749386-1-pandoh@google.com>
In-Reply-To: <20240709234913.2749386-1-pandoh@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4567:EE_
x-ms-office365-filtering-correlation-id: 96b52a3a-bad1-43be-097d-08dca07a1973
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b3lxWVN1VFlRVGlJbHBMdzl1YkF0amVWTjNWVldnR3A3SlI3NURobmEvK2cr?=
 =?utf-8?B?dzZ1S1VVTkVZMC96ZnF2TVkvWlJNTE1oeXRMYXQyOEdqVDBLRU55bjZyU29z?=
 =?utf-8?B?N0dkY2JCcEQwMitRTTQ1WmRoWUZ4VXZVMktMbXNRMkFSMXl1T2crczVlVGoz?=
 =?utf-8?B?YkR2a1d2SjVSWUJ4bmRVQWIzKzFqcmcrUG5SQmJwWFpkUlgwTVlkQ0h6bDhG?=
 =?utf-8?B?Q3FZMEdjQ2w2aXJVTFpBdDNjUUllTjB2RXFYbGl3em95ZHAyYlNxVzlXc0Zh?=
 =?utf-8?B?cEhMRWFEWFh2S040VHgybDBld1dYYU0vTVRIaWxpYjZRM081OVVoS09hZ0FU?=
 =?utf-8?B?anRQLzdkMklCZVQ1cW4wMW9YMmZEbHRCNWRweStOdGdEQTZkWGlpWk1qWUJn?=
 =?utf-8?B?Q3FpcmM4U3pZb25WMDk1SkR6cEZDeUM0MDA2Z21kK0o4ZkhTMGdldms5WldN?=
 =?utf-8?B?OWZFSjJweEpyUzN2MG1oNklVU2hyNzZ4QkxpUUpCOUV6MmZYamplaUJnT2lE?=
 =?utf-8?B?ZzV2RFlSb2R6UnhGeEkvWHhKRWJpbDV4VnBqOURia2pKUzliT2t4ZDdISFQ1?=
 =?utf-8?B?aEZXaS9IVEZ4K1FRN2krMUI3SkdZSW9zbXg5STU5VGFjTzdKNTFiZ3BQcWJw?=
 =?utf-8?B?MHdRNE5XSEEvVUsrd1JvM0pScEgwZnBvaTY4Z0x6bVFoWGlHaW1Db2JWd0ZV?=
 =?utf-8?B?YlVDcDNpR25la3ZhdTJlOGlZY2ZVTm5ua1RDWjdJeThnS1ljeGgxNFJLbWU0?=
 =?utf-8?B?aG1RZ1JmQW15OHpTUUlkREU0Szh6TGt1QVdzN3ZaTHNEV2FiNlBZa1FrUkhJ?=
 =?utf-8?B?ZnZEVCt2RVd4YzVBZERWSUNucnhSK1d6RU5id3dvWDhicmErTDVOQm54bGVt?=
 =?utf-8?B?cmZiZm9BRjZjTzd1b3RTRVRGZVJSOUdiY1pSTGJRNm8vZktSQlo5V3U0c3dW?=
 =?utf-8?B?Ui9RQlRhbWsrSjBOdElXT2JFa1NMY2hKTFp1MGRES1lFMGdGVmlKVW9MdkEv?=
 =?utf-8?B?S2JGdTFVOFljR28rcFhTNUpSNE5JV3ZkV3h2Z21MRm80aXR6RGRCdXh0ZGY5?=
 =?utf-8?B?UEdNL2dPK0xMNUpoc2gyUmprYW9DV25QaFFDMCtIanpiUnRaMHNjdnU2MHVn?=
 =?utf-8?B?NDFybzhtd01pKzBwY0pwYjd5MjFQdnBXaWd0WFR3L3ZyMnlpYnpZelZWV29z?=
 =?utf-8?B?N05xUnlzK084b0R1OVBzSUE3d3pMQWJ5czZFYThCN2FhVHVsSUMzN25FOFJx?=
 =?utf-8?B?cndmdzJaWVNkUHVSa1NGV2RHbXdCM3lZUWlnYjJ3TTVrMUpxZlp1QXFKMTNq?=
 =?utf-8?B?cTR0dXhYbnJYc1J2TXRwSXFOd2tqVkFOUjdQOUg5OUplNDUzRFYybzA5cVlB?=
 =?utf-8?B?d2lTOC93dlhGS1B2eG02RHR0RGdwM0VuQzI0UWtONXBFYzdpU2oyeTd0Tzgy?=
 =?utf-8?B?MjZFVGF4dDQ4VUxTa0tQSjROc3ljRHdOdXZZM05JYUFKZEhyNjZlWTQxUGFk?=
 =?utf-8?B?UENXbzF2Y0VqaUg1c3FXanhZdEhkVUxEck5RZUpscGJzYzhka3ZVeVdsM1JY?=
 =?utf-8?B?a0EzM2h6Z0MxempDaWZuekllc3FpRGdvT3g4ejB4T2hvSUFpc0NNNjhOMUFB?=
 =?utf-8?B?dWdHaXB6aWIvblNxaWxSR3F2cEcycWtTRy8wSXBOVDF4b1VFUjF3UlZoVnRu?=
 =?utf-8?B?a2V3bDdoUjhYTzJVWm93MkRKUFVHL2dvR2QzeUx1RVB1R0MyVTBHSmhnRDJs?=
 =?utf-8?B?M3BEUExLVW02b0ppRjFQdHpheUJWZW1lQUhCQWk4SXgwY2xpdVdhclI1L0ti?=
 =?utf-8?B?b1ovUUEra0lLYjMvL21LVkVWWEwvbXkwWVpxc08rRDVwblk4QVhXT29FVkRX?=
 =?utf-8?B?K21jTmZPdjE4YnFPRW1mWnpJWnFhMXowWERjL1dWaTVqTXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUdoQ0NUNWpZRkRnb0JYWEtkNGxldlQ1akVLTVFvT0kyRFBHcUtoNEZ2SURG?=
 =?utf-8?B?RXFHREpVS2ZrRmdyUUFUeWh5SGVqSVl2REZnb3dwK0p4WE0wM2tCVHRJU0Zz?=
 =?utf-8?B?NStZU1lsTUxTRHYyVDM5SGE2aHNmVldleXBpRFpZcGdWd3hYVkFQd24zN0k1?=
 =?utf-8?B?ZlZxL1JkSjg2QS9Md00vZUEyMDdSZjRXL0M4U2lNc3l5SEMyTW1wTWJSSWpB?=
 =?utf-8?B?Q1N0NHMwV2JYbXVYaHVwZjI1K0JZQ0NtemRMOVlJbWg2TTVGUGdpNnViRm5z?=
 =?utf-8?B?NDZSbmo1UTN2c2ZxQzBzZEJ5M3FsSzZPdDd6a00rM2xjWmNiTnN4dk1rVnhi?=
 =?utf-8?B?a2VOYXB1RVkrOUdFQmFvV0tPa3R1STBidEcyaHpYWklZQXJwb1FaaXJwcU9v?=
 =?utf-8?B?UzVOYWNOUG1MeTRrOUZ6YXdnWUVxUk83a1djQXZQdXdIb2NGNENMcEYvUW13?=
 =?utf-8?B?SmV0L3doVHRTVDFyYSsrODdCbzd0ZHE4VC84dkVPQWhMc3ByeWl2TUZscDkx?=
 =?utf-8?B?REpsOU1oZlVvTFJVV3VTQ21pdlF3cUU0MVo4R0F1WXdEWllKNzh2NVhYa3hm?=
 =?utf-8?B?cWp2R1owcG9VZnUvNUEzdlNpcFpHQ1V4MjBVYnU3djcxSURWTnJmdkd5Zmps?=
 =?utf-8?B?R2hZT1Y0Y1ZFQmNxMmhYWm9JcGFSc1ltNFVaZlJXY2NnQ0QwUG92V1YxblRT?=
 =?utf-8?B?bmZpUkc2ZDdOMnE1Y2ZXUnNqZVdnRlZNM0Z3M2ltUmM1ZDlEN2pacFJKNUFn?=
 =?utf-8?B?aDVPUzlwTC9RKzQ3ME1NQXBBSnhnZ3FkUzU1NWtRT3phQ2Z1TFVkaGwzWDNk?=
 =?utf-8?B?VzVHL0tjYzN1WWdnNlVMOUpqcVBXMThyNENhSFhUcGdsVU9FZkJmcUIxR3Bm?=
 =?utf-8?B?Tk9XQnVIS1I2ME1DTlVWSENzV2RmcEEyV2I1OHJCRjJGTkc1L2FmVnErdTJ3?=
 =?utf-8?B?Sk1JSjU4SzlEcDFGUTZVMFcwcXNwMC9Dbi83MFFzTm8zMG9wMmdxTi9RV0J4?=
 =?utf-8?B?SkI1dTAzSVVJejF6UkFBQ2JqclhaU0xVUzVxSDBnRk1YdGt3bDJubno5bnVT?=
 =?utf-8?B?ai9UNjRBT3A2REQrK1FwODg4eUk3UVc1dkpZSm1wSTMzR0liUnc0N3JvdWpQ?=
 =?utf-8?B?anFoVkYxYUVXMTEzbDB6aXM5YU1HakNFbFFMcXpiZloyN3RlVXYrTC9YUnpU?=
 =?utf-8?B?a1ZMK29oZWN0bTNtZjdwK2VTaVdVOVRxdEZxc2JJS2hZa2tuNG93TlB6K1Mr?=
 =?utf-8?B?L1A1VkdlSzJHMXFWTXErSUkzbjRzckIydTBOS3BQS1VxQXRWQzFwV2tKSCtG?=
 =?utf-8?B?RDU3VUhiL09xeDBaajNtVlRWcDhqMzdZVGovMnZrZU04RU1XVWwzbUFUQXNX?=
 =?utf-8?B?TWRUTjdWRUNYTmQvSllyNUF3NHdvZUtNVFNMRFBUNStwWi9GN0c0ampvdjZV?=
 =?utf-8?B?cTIzRjh5S1YxSjVJeGxaWmVrajhuOTFhajlkdDRocEZ4WEYvSEM1blVjRWsy?=
 =?utf-8?B?K1pyNjYrQnVwSmovVlZmV3A4K3VkVGpyT3lJbnBxQXNDQVB0TkoxRTZnRTR2?=
 =?utf-8?B?SGxpVW1MNG1qb3pCUTJkNUc5bWEzVmlZUVU1STRsYktWZEFvcUtOQUo4WXVo?=
 =?utf-8?B?R0I4SGpYVTZ1ZmhaZkdNTzg4ZXlVNmtKSWE4NzRZT29RNFE2TUhjblY3TUNs?=
 =?utf-8?B?QXlmcHJnZmFEU2Frb1dWTFdHQ0NvM1prTE40TFgzL2JyMGt0enBKL3hnYkdl?=
 =?utf-8?B?K05XdGdUY2xkckt5cFJ1U1d3akJYbEhYN1NxeTNZbWt5VXAzQmJoVlFIUzlT?=
 =?utf-8?B?NzMwRllVNmozbWYxUXRnWVdMTktFRGV6K3cwdlJKUXNjRk9DVnU5RDEwV0E4?=
 =?utf-8?B?cHR3QlhnS2JoWGZjVTU2VUdIa0lTdHRtLzlVYVlnZ0NzUklDRnlBZFo5L1kw?=
 =?utf-8?B?aXJqR2tkaG4rOFl0dWJFSnNMUXByUjllRGFGZjdPK3dFeWg1WFViakp5anow?=
 =?utf-8?B?UXhkUFRWU2ZxZTRRSjFvMWlHUURwWk5ncHBPa3phMUtma3FUcjh0U0k0QUhn?=
 =?utf-8?B?S1NyRlVZWUdzUElDeXVwQjF5K3RRSXhlWUdHWlZER05TYVk0RkN0NEoyVnJZ?=
 =?utf-8?Q?ewgghoJKhYEy8RrV8G2+oQaR/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b52a3a-bad1-43be-097d-08dca07a1973
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 00:49:05.2959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7LF76NpAs357hpLrcGSLbe4QBvxPrk2dgiPKfQT1Pfi9bqUrgc2m8unH72EnKqEF8SJ1wbriuRieZXRWckR86Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4567
X-OriginatorOrg: intel.com

PiBGcm9tOiBKb24gUGFuLURvaCA8cGFuZG9oQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgSnVseSAxMCwgMjAyNCA3OjQ5IEFNDQo+IA0KPiBJbnRlbCBJT01NVSBvcGVyYXRlcyBvbiBp
bmNsdXNpdmUgYm91bmRzIChib3RoIGdlbmVyYWxseSBhYXMgd2VsbCBhcw0KDQpzL2Fhcy9hcy8N
Cg0KPiBpb21tdV9kb21haW5faWRlbnRpdHlfbWFwKCkpLiBNZWFud2hpbGUsIGZvcl9lYWNoX21l
bV9wZm5fcmFuZ2UoKQ0KPiB1c2VzDQo+IGV4Y2x1c2l2ZSBib3VuZHMgZm9yIGVuZF9wZm4uIFRo
aXMgY3JlYXRlcyBhbiBvZmYtYnktb25lIGVycm9yIHdoZW4NCj4gc3dpdGNoaW5nIGJldHdlZW4g
dGhlIHR3by4NCj4gDQo+IEZpeGVzOiA1ZGZlODY2MGEzZDcgKCJib290bWVtOiBSZXBsYWNlIHdv
cmtfd2l0aF9hY3RpdmVfcmVnaW9ucygpIHdpdGgNCj4gZm9yX2VhY2hfbWVtX3Bmbl9yYW5nZSgp
IikNCg0KdGhpcyBkb2Vzbid0IGFwcGVhciB0byBiZSB0aGUgb3JpZ2luYWwgY29tbWl0IGludHJv
ZHVjaW5nIHRoaXMgYnVnLg0KDQpFdmVuIHRoZSBvbGQgd29ya193aXRoX2FjdGl2ZV9yZWdpb25z
KCkgd2F5IHVzZWQgZXhjbHVzaXZlIGVuZF9wZm4NCndoaWxlIGl0J3Mgbm90IGFkanVzdGVkIHdo
ZW4gY2FsbGluZyBpb21tdV9kb21haW5faWRlbnRpdHlfbWFwKCkuDQoNCj4gU2lnbmVkLW9mZi1i
eTogSm9uIFBhbi1Eb2ggPHBhbmRvaEBnb29nbGUuY29tPg0KPiBUZXN0ZWQtYnk6IFN1ZGhlZXIg
RGFudHVsdXJpIDxkYW50dWx1cmlzQGdvb2dsZS5jb20+DQo+IFN1Z2dlc3RlZC1ieTogR2FyeSBa
aWJyYXQgPGd6aWJyYXRAZ29vZ2xlLmNvbT4NCg0Kb3RoZXJ3aXNlLA0KDQpSZXZpZXdlZC1ieTog
S2V2aW4gVGlhbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo=
