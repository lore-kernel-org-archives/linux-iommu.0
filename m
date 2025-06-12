Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D4072617
	for <iommu@lists.linux.dev>; Thu, 12 Jun 2025 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749715546; cv=fail; b=cHkNjxDuha4mv6yjYeakSMvJsGcLxVFWGHOwwC90ekZ8ZDNy+8jqu1OakKZEYmqnQUmt+5DXOPhuOlhVFaXxQsF4OCcNw1WEAxNylTLR9JcvZTKkuMrYXxh9bdWbM9E6+AfGW3yC+luW1WnW6/DxPSrcDRDJWuFpMZ3VDVXZpcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749715546; c=relaxed/simple;
	bh=tCzk1ZMpkOLSZFvMVBGnPLw6C/J5JpumKHw4X+D0RoA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=otxjKCgtlr6kTGaYWzSZWN7sLPyy6j1OsqoEtZ+Yf2FmCgyYtd4pX3CUGZChfOR4DgnUJiqdF6Pb42DKecYZWjJQEg2DtvLftiycmKco67lfEvCQk1AwREkibGxDbaQt8S2oGVe1by7vIoibYhRaPSTDzStUr50bMm8TGKnX8rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZOw4e6QM; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZOw4e6QM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749715545; x=1781251545;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tCzk1ZMpkOLSZFvMVBGnPLw6C/J5JpumKHw4X+D0RoA=;
  b=ZOw4e6QM90vg/2WtWI19fVWp5HkBpqd+jz0n1nreFDQZq3Efuxt66v6O
   NCu0PJ+2Yl4FcGo0vf0MIYnm6yjWqTMGv7FG18ytehvQaxkRCnWOzNVtm
   m+s6nGeeBV9Z4iKTA3P8/PdS6x4+Hx7Moz1QCkkO3kkqZf7C7u/Jn0iah
   mf6vQVnpDfE1SxCr5PassbOiakeBCwKbOYMXOhdQqQileNi+GQ3nN4hcc
   oaJ7xevUMzDUw4rew75DU3mx6Eja6eDmMZvLJwVT9crHTXyTUui+LVToX
   FsbChj7xEqjE4d960DOOhSXhTS2UD7WSkKhaCz/vsv1isSSntY/wbkqkd
   w==;
X-CSE-ConnectionGUID: IBRYrVfzSVKH2axhY6xxWw==
X-CSE-MsgGUID: 0vaekRZdSIG/h5NUs85V6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="55683375"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="55683375"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 01:05:41 -0700
X-CSE-ConnectionGUID: dmD+cDkvRlWkfiyeYuRRRQ==
X-CSE-MsgGUID: zyCuV8KzR22jCm5FUtBWEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147991475"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 01:05:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 01:05:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 01:05:40 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.67)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 01:05:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CywO1a+wBumMNFRQ+BIn9BdFUOOQAyI6HPzGoCfZbTGGNTSxW0VAzj04mxWVvxJvgL7r6mEuNH+ClMrGfFgDCvhnbH0HgJAL03D88eTb7V7QdpsaG9K+78YRxAotNgPyct/RFUVVUGpF//fGuHt75j8uIkvrHhZOKASYn3CUT8Phwf2XXGy/qnGAngsO4EdYaAJj/0HEUHqMZ8KoBQUofSRZjfu9nB19pc9J/+Z2EinRx78cgaBTRUs1W3YRwEbZEQT7tBvzcYMJ5XDLSBCeleOLFhdruexpQYqb83Tr9PBJApXXk1/RQyuyX7cc58MqrYAanGD7QsxGLlXbX9qYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCzk1ZMpkOLSZFvMVBGnPLw6C/J5JpumKHw4X+D0RoA=;
 b=Q0DpkH44DKfsIll07Jiiy/HJcttVSS1APZnBeZV9bOh1KZAsKfo46LZcaHt3wriQxJMMUbvENbP1PYBRBxRD/DHkOv5WdtN5vTL/u7riEQx3p9Q555Gx+hX3SlgC8oFsYpF7UaxHCk5GJLQ3moJSGWJTLMvAkv9OHxS9IWVRg6LyK0DCNufBtgwQw6Z7cfRl0hLRTSJqAKJf9THimfrk2NkDyzsGHyiZsvQO2zLnTBNkOxCaoJuAC+DQdaSODQwtF/p66RBY79Z4Whd9gLAdIJt/cBdS6BRonpCE/AGhoQJikgDcV01SR2bkHqBUtU1sG5Pn/diL5VDLHh7P0TkoIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM3PPF17031675B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f09) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Thu, 12 Jun
 2025 08:05:37 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 08:05:37 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: RE: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Thread-Topic: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Thread-Index: AQHb2dRy0pZb6YCA9kCQvhSriVTQbbP/Kocw
Date: Thu, 12 Jun 2025 08:05:37 +0000
Message-ID: <BN9PR11MB527606182417BB7A35349F598C74A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250610065146.1321816-1-aneesh.kumar@kernel.org>
In-Reply-To: <20250610065146.1321816-1-aneesh.kumar@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM3PPF17031675B:EE_
x-ms-office365-filtering-correlation-id: 62dbee14-5278-45e1-7e6f-08dda987ea88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SGhQS081K1pySURHRkhkL0RXSGdTRCtlbjVQZ2VxRFkrQTBNSEhzVWtGTlFN?=
 =?utf-8?B?b3IyaVl2emFjbllNTUlRUzlnT0R3T29PelE1TmhxdHVhRGNoRTlzWDE3WTBt?=
 =?utf-8?B?cnE5SkI0N2NvaS9lZC9ITEtaUmtyc2tQZTkvaTMyNDZkTXBnaE5ZL0xnOGph?=
 =?utf-8?B?OXc3QXM5MUxDL2xFVE9MVkl4RGIrR2trNmhNZWVtNGh6ZUNQV0kwQU5lT0pu?=
 =?utf-8?B?ZGxNNjduTzRiYkF1T1NoVmJUcmV0TXJLbTVqdW9Ya3pyWE9uUjVBa21jaUZx?=
 =?utf-8?B?OE5CU2tZYU5YTGQ4RHhYbTZpV25OMGhXMVM2U0VzeHZwZytDc2JucU1ZWWs2?=
 =?utf-8?B?aytWRGFNbnppeUZOenU5OVFTOEJubXU4dDdzeHlvWlIvTEN2TE43SVR4Z2lq?=
 =?utf-8?B?RUs2ZzdmYmxxY1l0ZVFMWW1pSXlZM2NzYUFaWXdYTTdqL1U3YXBYMHFMWktU?=
 =?utf-8?B?ZVlTa2JtcUk5NXREbHY1ZktuVE9jOHdDOFU2UGNtQWZMZ3ZlRFdidlRkejEv?=
 =?utf-8?B?Z3puWHZGekY2b3h6WVhWQ2VDZ3ZoNmxZbGtodjE0YXY2QWFPcGdoY0R3dzl4?=
 =?utf-8?B?WUoyRjFnM0tzRDlhZjk4WEJSc2NiT2hlUmt6T0pZaTdiZTIrV01zSmVJUDho?=
 =?utf-8?B?ZXRVbHNzMDJFbVNuNDJ6RnlyNnV4dmFKSWxFeUVVUnpPNFV5ZVRQdm5uU0JK?=
 =?utf-8?B?d0F1ZWdaQWtVY1V1N1cvZnJ2bS9EOXJiLzdJZEZrSmFqNTkxR3BWSFNzZ3ZZ?=
 =?utf-8?B?MTErUkNPeGcxOURNaGp4REYxd3NKMDdhUndXSVJ3UVlDalJiKzRmWTVLZzV3?=
 =?utf-8?B?L1JTSEpBcnU3QWxhV1lrQ1Z2a1RVTVZTMlo2M3FKUjdobm4vOEpNcVd4NGFG?=
 =?utf-8?B?MnFZQmhXNk5peFR6NnVWUGIzRi9ocVh0MldQY1JWWWpYaVB1bzV4SlZ5Z2d1?=
 =?utf-8?B?V0dNU3lHUDVLWlBXUlRFbzNOTk0vYVhEak9ZcnhwK2gzeGtvQy9iT1ppT1BX?=
 =?utf-8?B?TGZQRjZ6VXo1dUdUaDNZTmo3c0RqQ1Nudm54Mi9XY2t6MnZVYWY1NlBBeVps?=
 =?utf-8?B?TUw0K1FzMUFJY2l3Z28xbFBnR1dlOGk0dkNMRHJzNzNCUWprU1lPNHdTbXM0?=
 =?utf-8?B?aEZRYzhpaVlqa0tTUDRGWE11V1JVbHFZNTlTcmloalZHSy9vZjl5VUFWdXdC?=
 =?utf-8?B?V1Y0c1FHU2t2UXl1alRYcU9mM3FDS3haQU1jUmRjek1GUlVPLy9KT1poc2Q3?=
 =?utf-8?B?MzNLZ0ZSMTI1TWl2UHFlc1hBUFpMUkJYOFl4endvalE0WmRhdWJGKzl4RTNE?=
 =?utf-8?B?M0NWVXRpUUVmVkhhRG1iM3NjU3hMRVhKdzY4MFE4T2UxRzRkaDM0UUpWbVZp?=
 =?utf-8?B?cHpBOWtHWjZLY2krYUNXc0VKaEhod2M1UTdwVk40eEl5S0U2YmJ1VUo5dEs0?=
 =?utf-8?B?eGhWV3o2c2hSRjEwYVBLckZFczlsUVNvN2JYVm12cllXY0l5SGkzY2hhamxS?=
 =?utf-8?B?dmVYTGxWVDYxMjY4V0l5a0Jac1J1QXZJbmlwbTRrNWdDb0V4L2haWEM5czhh?=
 =?utf-8?B?VXEzY25zSnMvU3JjRFZTYXZpb2xPeDZNTW1RWjB6WFVmR0IrZUM4S1FLVVZH?=
 =?utf-8?B?bWtDZDFsMkV3NWVXYVp3VXZrRHhGeVNWcFhvcGtNZDZMd2xxeFgxeWhUSllE?=
 =?utf-8?B?NVMvdktpT292WGtYZHgrYmNSRnhhSWRxS0FKT3lKMmVHMGtLS1owVnVKQXZv?=
 =?utf-8?B?a3JoMkVnNFZMVDZ6WjF5eVo3NkVmbVlFTGc3bXdKL2tDanU5UzhqSHpCWkl0?=
 =?utf-8?B?STdlbEorV2FrUzdyaCtIVlQwVElrUkJLV0hzeDlBdDZ0ZEt0VWVwcXIwVmRx?=
 =?utf-8?B?czN5eVBHaVhyVnZXUWhJdmxZcXlZSUNnZTVreFV5dFYwdE1IazE0MHB3R2pP?=
 =?utf-8?Q?eDMnIbOx4ytVDmJfdgE4GkIUzVdbU4Ih?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2FLeXJHTUF1S0wrdGdxVkVkWGUrYjhxS0JQRC9KRDdDTmFPMlNiRytUbnd5?=
 =?utf-8?B?d0pKWHhCWEd1VUwrUVM5YXh2QndKYmVabjJpTjIySjk3UUVmNXpyRlFQTGVi?=
 =?utf-8?B?bEJLaUYwalcybVJkc1ZjaDRvVUN6cGJrQzErTVB6UmdnNys4Z0IwOHRTWVM0?=
 =?utf-8?B?ZEZWN3U2UUYzb3N2clEvQnRUWEwwRE5lTDNkcFJxNzBqTjRiNFJ5QWpyNUhQ?=
 =?utf-8?B?dVZ4YTVUakc2Z0dRVWZLNXVha3pna0hvSWlwSEgzMUs4TjZPY3Y0OTZoelYz?=
 =?utf-8?B?WkV1U0dyZVRTdXRIL3FIcVVhWTc0WVQzUWtTN1JCa2s2ODJRb3FlQThCOHp3?=
 =?utf-8?B?TEVQU2h6LzdCcnZjdzM4ekR1VTV4NnVkZHJKc0FVNmcrdlVnMFVQWmtVV1Rp?=
 =?utf-8?B?bHErL0Z2T3dhcXBaQi9XYTlZZlpFK2xOSitNRUMremJnd0VTTmpiek9CZ1h2?=
 =?utf-8?B?d3pSYlluWFlSMnB5OWJWQUlHb0UvZ2taOFFZMXAvL1dNWW9PWGhBSm5nWVAy?=
 =?utf-8?B?OFJLS3ltaVl0NnJjTCtpelJ1Ky9tUXJ2cFJYOHJQVHRjeHh2NlZlMUkycnJz?=
 =?utf-8?B?YXlhZFJMRjJMQUhNRWs4alhsUUNNdzdtMmp0ZlZZdU5RdlozYU5NOTFWYmxp?=
 =?utf-8?B?MkJtM2FYUG40dm5sNVhnS1E5eVcwQU5FZFVhckpWTWpBQWRMVU9hQnVCQTYz?=
 =?utf-8?B?YXpReWlWTktmcmVKRXBLZDh0YkRQYysycDgrYktBK0VaOWFLK2poZ3ZuNk1x?=
 =?utf-8?B?UnJOamtla0ZwbUlQQnFvYWZ3cGNaVTdzWmpUMjlHTHM2MlQzeWNBVXRkWHo5?=
 =?utf-8?B?Zk9ZdldRSXlVamR3cCt1TTVFdmZ2RkZaSUdJamovT3ZzdUpvZ2daZUp2WmJs?=
 =?utf-8?B?MGJIQzl0LzIxNTlmWWxoYXhzMWFWdkVOdzZVdmp0NjUyRUI0TjVzOHNPV0lV?=
 =?utf-8?B?Q1lKY2JyclN6dElad0tXZEVwS2ZrQS9BcEFhSVlzalcxeG1sZG1hcWkrR2Vz?=
 =?utf-8?B?YVZvbnNNdzN1NzNxb0JLdHp3ZVg4SzFmK1NKZlhqbk5ENUF1dFhrbEhxeFk5?=
 =?utf-8?B?TmxHRFE0bmFZYzBvOCtsMHFnRTJQM3BERFJzMVNwUWpSS1FGQTVsN3FacUlp?=
 =?utf-8?B?bFZoL2RlZW55ZkdhenFob3Zxa0ZiZzVVdEJmZ1lHc0RzUmFrUFh1d0Y2eG1D?=
 =?utf-8?B?MHg0cXFzWG5DWW0xditDaWlNaHhtMHZWVk1LZllZMTJERXozQ3lYTUxTZEFO?=
 =?utf-8?B?NlBTYjh3b1JhVTllMTNNeEhmcWFnNllEcDJRZUFmMWw2L1l6ZUhkMEMvTHhG?=
 =?utf-8?B?Y2c0bG4zTk8zSFJVcWdYeHZXZUdHTGVpU2NOQUpYTGZsaEJmMWxTd0ZpRmlH?=
 =?utf-8?B?Wk1hNnlsS0xlSDcvZ1kyS3liTDlTQU5KR3BlTDBDMjVHQXVHSmc0SDF3cFFW?=
 =?utf-8?B?VHdWOXFabExkRlR0dVZCYmNOV3dBSDFNOHMrZWY2QytsOXF0VjN3VDdRaHo1?=
 =?utf-8?B?TnhuTEhzazRVM1QrK2tZWDhTMzFoYk1ZMGdhRHcyZzhpeVNPQXExNzhxUFEr?=
 =?utf-8?B?Y01xTzRhYUk2UzZkNTltdVY2N1pEeExLdHpKaUJXUGdqbEZuWWRaeTU3eW9p?=
 =?utf-8?B?VVpFT282N1U1Y3JBdmE0S243V1pyVG84L2MxUjYyQit0U2Z3b0pkVmtuelJh?=
 =?utf-8?B?SXY0b29RWVRSZmF0OEcyenYwR082U1JvdVN3dVZCUU5tUGhhTy9ESzVyc2xk?=
 =?utf-8?B?Rnczb2JaZHg4NWhNZmFLTktreDlaMmN4MUVscmh3d0JUbXljMUoxenlHcEpI?=
 =?utf-8?B?bUxsUVNwRmdDaG5yYmpwM3NxanUyS0ljejFEUlJiUkZyc0dzNzFOTFV2L3Bl?=
 =?utf-8?B?TWN0RXo5ZkZ1TzVKem82dk05T2pjbXZGYldCZEYvRTBocEU0TUpkWWVoVkha?=
 =?utf-8?B?Wk90dWUrMUFnT25WSkhoWVhRNWxSdHN6N2NvUXRQbnBkSVVEZ1FKaCtpZnpp?=
 =?utf-8?B?UUtxVkYySjliTjFxNHVlVnRlMHczUy9Od1ZMR01DeW92STIvU09ELzlFNDU0?=
 =?utf-8?B?NHRpVDJ5ZDh2ZldIeng3ZFQyM2Jwbm5UWXFDcXFsc2lFVTRuOS9sVVNKYUF6?=
 =?utf-8?Q?cJtoTPUGIDtzKW5h7AngQVjIh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 62dbee14-5278-45e1-7e6f-08dda987ea88
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 08:05:37.6788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wb9F+yoYtt08ED0zx9PNgHHPX80OEZS7r6wHUbCaCG2UgUwSP5JLeKnMBq1qOELt5rkv5WcgyFUeEPOAz79nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF17031675B
X-OriginatorOrg: intel.com

PiBGcm9tOiBBbmVlc2ggS3VtYXIgSy5WIChBcm0pIDxhbmVlc2gua3VtYXJAa2VybmVsLm9yZz4N
Cj4gU2VudDogVHVlc2RheSwgSnVuZSAxMCwgMjAyNSAyOjUyIFBNDQo+IA0KPiBUaGUgaW9tbXVm
ZCBzdWJzeXN0ZW0gdXNlcyB0aGUgVkZJTyBjaGFyYWN0ZXIgZGV2aWNlIGRlc2NyaXB0b3IgdG8g
YmluZA0KDQppdCdzIHRoZSAndXNlcicgb3IgJ3ZtbScgaW5pdGlhdGluZyB0aGF0IG9wZXJhdGlv
biwgbm90IHRoZSBzdWJzeXN0ZW0gaXRzZWxmLg0KDQo+IGEgZGV2aWNlIGZpbGUgdG8gYW4gaW9t
bXVmZCBjb250ZXh0IHZpYSB0aGUgVkZJT19ERVZJQ0VfQklORF9JT01NVUZEDQo+IGlvY3RsLiBU
aGlzIGJpbmRpbmcgcmV0dXJucyBhIGJpbmRfaWQsIHdoaWNoIGlzIHRoZW4gdXNlZCBpbiBzdWJz
ZXF1ZW50DQoNCnRoZXJlIGlzIG5vICdiaW5kX2lkJyBpbiBhbnkgdUFQSS4gbGV0J3Mgc3RpY2sg
dG8gJ2RldmlkJy4NCg0KPiBpb21tdWZkIGlvY3RscyBzdWNoIGFzIElPTU1VX0hXUFRfQUxMT0Ms
IElPTU1VX1ZJT01NVV9BTExPQywNCj4gYW5kDQo+IElPTU1VX1ZERVZJQ0VfQUxMT0MuDQo+IA0K
PiBBbW9uZyB0aGVzZSwgSU9NTVVfVkRFVklDRV9BTExPQyBpcyBzcGVjaWFs4oCUdGhlIGxpZmV0
aW1lIG9mIGEgdmlydHVhbA0KPiBkZXZpY2UgKHZkZXZpY2UpIHNob3VsZCBiZSB0aWVkIHRvIHRo
ZSBib3VuZCBzdGF0ZSBvZiBpdHMgcGh5c2ljYWwNCj4gZGV2aWNlLg0KPiANCj4gSW4gdGhlIGN1
cnJlbnQga2VybmVsLCB0aGVyZSBpcyBubyBlbmZvcmNlZCBkZXBlbmRlbmN5IGJldHdlZW4NCj4g
aW9tbXVmZF9kZXZpY2UgYW5kIGlvbW11ZmRfdmRldmljZS4gVGhpcyBwYXRjaCBpbnRyb2R1Y2Vz
IHN1Y2ggYQ0KPiBkZXBlbmRlbmN5OiB3aGVuIHRoZSBkZXZpY2UgaXMgdW5ib3VuZCwgdGhlIGFz
c29jaWF0ZWQgdmRldmljZSBpcyBub3cNCj4gYXV0b21hdGljYWxseSBkZXN0cm95ZWQuDQoNClRo
aXMgd2VudCBiYWNrd2FyZC4NCg0KVGhlIGluaXRpYWwgdjUgcGF0Y2ggWzFdIGZyb20gTmljb2xp
biB3YXMgc2ltaWxhciB0byB3aGF0IHRoaXMNCnBhdGNoIGRvZXMuIEphc29uIGV4cGxhaW5lZCBb
Ml0gd2h5IGl0J3MgdW5zYWZlIHRvIGRlc3Ryb3kgInVzZXJzcGFjZQ0KY3JlYXRlZCIgb2JqZWN0
cyBiZWhpbmQgdGhlIHNjZW5lLiBBbmQgYSBnZW5lcmFsIHJ1bGUgaW4gaW9tbXVmZCBpcw0KdG8g
bm90IHRha2UgbG9uZyB0ZXJtIHJlZmVyZW5jZXMgb24ga2VybmVsIG93bmVkIG9iamVjdHMuDQoN
ClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvNTMwMjVjODI3YzQ0ZDY4ZWRiNjQ2OWJm
ZDk0MGE4ZThiYzYxNDdhNS4xNzI5ODk3Mjc4LmdpdC5uaWNvbGluY0BudmlkaWEuY29tLw0KWzJd
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MTAyOTE4NDgwMS5HVzY5NTZAbnZpZGlh
LmNvbS8NCg0KPiANCj4gQWx0aG91Z2ggdGhlcmUgaXMgYWxyZWFkeSBhbiBpbXBsaWNpdCBkZXBl
bmRlbmN54oCUdmRldmljZXMgY2FuIG9ubHkgYmUNCj4gZGVzdHJveWVkIGFmdGVyIHRoZSBpb21t
dWZkX2RldmljZSBpcyB1bmJvdW5kIGR1ZSB0byB0aGUgVkZJTyBjZGV2IGZpbGUNCj4gZGVzY3Jp
cHRvciBob2xkaW5nIGEgcmVmZXJlbmNlIHRvIHRoZSBpb21tdSBmaWxlIGRlc2NyaXB0b3LigJR0
aGlzIHBhdGNoDQoNCkkgZGlkbid0IGdldCB0aGlzIHBhcnQuIFRoZSB1c2VyIG93bnMgdGhlIGxp
ZmUgY3ljbGUgb2YgaXRzIGNyZWF0ZWQgb2JqZWN0cy4NCldlIGRvbid0IGhhdmUgc3VjaCByZXN0
cmljdGlvbiB0aGF0IGEgdmRldmljZSBvYmplY3QgY2FuIGJlIGRlc3Ryb3llZA0Kb25seSBhZnRl
ciBkZXZpY2UgaXMgdW5ib3VuZC4uLg0K
