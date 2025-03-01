Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905DA1E49F
	for <iommu@lists.linux.dev>; Sat,  1 Mar 2025 10:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740823601; cv=fail; b=B0zJ3HV11K86q3AsYypwWbIY1GqWLFHrIiLtUEU0070e5xDRKRT01CjTqi3T8CzGwSko9j4hos60u0yF0Z0SAU9t93uZ5PKNt0UzCm/abdvo8MPOuJQlf0ZgZcGmAlW87r2F67IlI4YkhP+1qXRnmbg7j4/KovxoZx7crlp+Ums=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740823601; c=relaxed/simple;
	bh=A1sVXAr/RnZcm1jcXr+u0cWgXlpc1WGJC1D+uCie0uM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oICEungS+zQlxO58fvWA1wWeiuXEGzjmxQdqPpgcq5IvCdK5SK3C25j6p/dDjR13tZssNsahmtLGnaSw53ojd5b2Gm0mjQqD3zgkoLfoIZfUEuBBV3ZI8smgspEC4yLWLSL7wQPSoR7pSgpU2A0Z8xMMeIHPncsPc7Z2wFmaF+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7qcYYJv; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7qcYYJv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740823599; x=1772359599;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A1sVXAr/RnZcm1jcXr+u0cWgXlpc1WGJC1D+uCie0uM=;
  b=n7qcYYJvin+UPz0ly2LmsosoJ+yzr+NLKAo00OsEfr1L4F7MrE+k30hG
   rhKisPbsygORFn44UMsFU3Rt+ytGuxNY+rEMrm9Bk4xuK8Z8StS5UyI2l
   TzVRuoq1E9HuG40SKumabxqZUCWsWra4Bh7CIladZja7oFBTEXGWfyMqZ
   IQ8Yi6vOV7UQf9R1COBN0prGIuXG10DovFjlB34FnykapzBzg2u7NrxEd
   7FNACySnZ2IZykC7MHE9Vvpo0o+IzxyOkIHnZR+6K3+V0i0vp01wDsQSh
   lSTjRH1JGrhhK/OXxmCnYhojmdUnCtWWCa/EHBNCCv8JuSOs1FW+fcGeA
   g==;
X-CSE-ConnectionGUID: kLj+ym0mQLuzhuHELWjrhQ==
X-CSE-MsgGUID: yQL7hlJlTqycgZuz2BGJ1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="52385413"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="52385413"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 02:06:39 -0800
X-CSE-ConnectionGUID: yATBeV0YR1eaEMoVQo+CEg==
X-CSE-MsgGUID: e25VA1FZTNmh1O1AB9noHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="117741885"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 02:06:38 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sat, 1 Mar 2025 02:06:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sat, 1 Mar 2025 02:06:38 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 1 Mar 2025 02:06:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DX5h9i4uYRddaZlxLUrSGT96VugtTvObkdRqKpV/cDqNWBRT9DKza3zQCsoHPkaX/MR7NpoIusL9SykozR3XhxIGX/OLJ2PpKo1nHkHyDCnYf/5dPoOovvpi4YuUgBJOdLOii1NBk0uoItJuEYI/cNtZnFQubbhYqc665e/qkAir7QRIYfpTJzmD4lqpGiX1i6PS7gz24QiBiask5KdpNH7KAtaczgw3cODOnz/x5ur9jJDrazTHvbamkNd50P4y9DOCjFScje/aqC6YOSDCnwiFmGcdTE0JhI2AnbTFUCBo1B9Jj6JrF5kgmj3iFRRD96bSbp0M5lVJxThVVJ0jOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84c6bMBQuq87LkN+3B4w/zCknaPdcNpJGDZSxaS9JGY=;
 b=eq4AfaW3M52ZiH/vrs0WMoPsTWYYOwlKzGySWXqvBxz7e8qKSj2azoQpaTUbtndjcKAJc3mE2cWAFy9mA4BQwKFwK/CWU4jpTWKX87y83guuS0psLBmKnYE9RLp/OEj9kI5p/3T4bfHbapvVy0OAWBEj8C0uD3ZxoW3pZ8AO7mv1fFijwJX7cmtZHP1qVlOpyNmlBOkOferzjlf2uHobG3PkY3QVE/I/KzHL54peo5Gr+PMWRfp0JlR9CvffvL4/1D/1vrstSX7e4zWPgTJZLy6ntLlTk0EWgicNVpXBgRgCyWBcjvZ+O5u60rW9vcwFCe1XcYu9Nx1uJ6qsqWXhkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA2PR11MB5179.namprd11.prod.outlook.com (2603:10b6:806:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sat, 1 Mar
 2025 10:06:36 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.028; Sat, 1 Mar 2025
 10:06:36 +0000
Message-ID: <f71f7125-514c-4ef1-8614-3680c4821ace@intel.com>
Date: Sat, 1 Mar 2025 18:12:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/12] iommu: Introduce a replace API for device pasid
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-3-yi.l.liu@intel.com> <Z7+fmawdDhATfOX0@Asurada-Nvidia>
 <d6b97c8e-f126-49b3-b752-92fe3069af51@intel.com>
 <Z8CNEDwUCZuNUv7C@Asurada-Nvidia>
 <51eb28e7-0631-4965-81c1-cf9633e46019@intel.com>
 <Z8KRQMxcOSn9Lytc@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z8KRQMxcOSn9Lytc@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA2PR11MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: e4951b24-e26e-4c2d-9bb9-08dd58a8c05c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVFJaWhQVmRGdlorWm5veGlFZXJyYXk0SjdFMzd4bXAyQzRCQmNTLzV6SmZy?=
 =?utf-8?B?R0J3MTkyYW5wVnEzaURKYitxa1J5V0JBb25OdmhzVGVvcUZqK2w0ZHVoVWZD?=
 =?utf-8?B?RnpoZFZVN2VwNlAzMUFxT0tLMC8vNjZKR2lHUjZqOFJVeTdEdUZwd050bDJJ?=
 =?utf-8?B?VHNIRFZ1a1U3akRtNjI1d3NsR2FHVDZld2hReG9QUmx4K2pId1FnQ1ZrWVll?=
 =?utf-8?B?bUpQMExhY01oQ2JVR0lWQkcrcHNUMlViTFRTYXRwQWVIVk5PdDFtVnFnMkF2?=
 =?utf-8?B?Q2U0MHQzVGlFeDlEUzhwUFA4ZFZrNC9JVVBTdjJaTm40d2owUnhRL3JNNDdZ?=
 =?utf-8?B?L0MxUzRsN2JQWDl1ZzJQeDRsdzFwYWsrYVA1Sk1VQzNPYVV6LzNXNStuTld6?=
 =?utf-8?B?TWtGSFBXam5qYVV0anpMQTdvN0lQaDA1WnBlT1ZDQVFMalFJekZ5OVVuUGt3?=
 =?utf-8?B?Q2YxVlVYKzdQUGVRcXg3OWFKVWRzZ3dtRjAzM0hNdDJmc0lJZ2JzNDNsbk5T?=
 =?utf-8?B?TWVmWG9vUHlTWkRKNDhLNEZlWXg5Q0t6c1BXS1dwY2Z3UHhTaUlhNm1oZDJs?=
 =?utf-8?B?d1NRN0MvdFJJYkYrSUx5YlZ1QWxQZlc4MzBCd1VmZU01MHpLcjMvbjVCa3cy?=
 =?utf-8?B?bzRJNU8rSnhISDFrd2VscytkQlFUS2cvSytOb2ZYcFZtZFZZOVQ0dHBNMW9X?=
 =?utf-8?B?U1RSSTRyZWRuNnJ6N015cWw3ajFHanBrd1U3S0xmR002OCtLMlE1cXFYQmpG?=
 =?utf-8?B?b0hKTHlwcVYzQW84clkyeGlKUE5hdW9mSytSQndYajVRbFZ0aU5uV1VuYUhm?=
 =?utf-8?B?OHVtTHVDMGtvYUNVUlNubmJES0piNDQ4UzVvZTVzT0czeUhndGJIUmxzU0tY?=
 =?utf-8?B?d1FrSkdFSWNFaEo0aUkyRFhVb0hkSDhUSkptcVNPbzh4dlpyRjBJMDRtTnlZ?=
 =?utf-8?B?QTdLMld1dktzWTBJb09Yd0lXdmxXK3BrdXZDNVVja21EdE8zM1ROUDF0cmZt?=
 =?utf-8?B?TThrdUl4SkxBbkJXZDl6cFltUGt6RERGTnczNGlOdDFrOC8yYVJ0U3hCUHVj?=
 =?utf-8?B?UXU1aFpvZGNZSDZkVnp6Y0R3MTBxQ0MvLzNkbTgvWU1HK05xcGdveXl0UVhG?=
 =?utf-8?B?OWJ2QWZLaG9HRG5CNktVdDJuckhaRXZ6RUpZRjlIbFloRkZsM3d4Q1BFNE9h?=
 =?utf-8?B?SExaMS9ka2FIazZ6dWJkTG9ZUkpBVk5kVWQ4ZEdlelZoY3psazhPK01jbEZG?=
 =?utf-8?B?anlpTTRtdGRyTEdmVzJJNC92RG45dEwrei9QL0pVU1Z5RXU3cDF5V3dpOXlv?=
 =?utf-8?B?d05xdS9RZVE3WDVqTTBHZmhqTGZhWTFmOGthUDdSSWsxRERCTWQ2Uk5zRmpo?=
 =?utf-8?B?UVhpYzRpb3MzYXZwcFVoQlpiaWdudGlBdTREbndSNHhRRDhvQU9tbWhXRjA3?=
 =?utf-8?B?RllYTHpqNENjS2RHa1lJMTJ4N3VXWHhTZU5HRDNyTG1IeVAyTlJ4MnU1dmRh?=
 =?utf-8?B?VDA1SGRjWFcxb3pzYnVMejVta1owdyt0Y0hLbVd5QmdvWmdOUGJLaTVPaGli?=
 =?utf-8?B?cWdnYmRJenZIOFVYTmZ2cUJJSDJNVHZjcnhNSktIZHFTQ1J4am9naGdiK2hi?=
 =?utf-8?B?YUdLcERTdTdaMEVuODMzbVpxNzBneVFrSWV1UnZGYUhmblcrK3o2clNRZUY0?=
 =?utf-8?B?QlJKL29VTUwrSWxmcUVzbTQ0K2V3M3VPOFdYamlJQzhNZmhqYjZXNEpOT3lC?=
 =?utf-8?B?ZHR6WTk5RlFkVnhveXo5TExvMnlNdUtnbzVxNlBkWG4xWkFWcUxCOXJKTVhp?=
 =?utf-8?B?bHI4MVJpZVNndHJDcTdDaXpsNERFZzJOYzRTR1JjaWc0VWRHQTVlZ0FlV1FJ?=
 =?utf-8?Q?/9SfLo6uyqf0y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGpDd1kySjZPc1NXNXh4MmMxSzNGckZ1bnNrcDQ5dUVwOUxjWEZVSDdydUdp?=
 =?utf-8?B?YnJMOVM0NTZuYjVNUWU4MXJPdy81L0VNZjVma3JNK05vZkgzeFZ5bTFpd0pL?=
 =?utf-8?B?YnlmWmhybzUrR0hoZkF2aFZBWnRsTmJpdTJDZDFCZTFXSllaczFkV3dkNHZk?=
 =?utf-8?B?d05nb1N1NWlvWXozRE5zaWVjRVVnMXUxWUVDN21iL2J2YlN2ZUZRYzhuUHZw?=
 =?utf-8?B?UGlYZHIrQXNKUktlSDRVWjVacHFaY1hMN2lsc2JuQ3oxLzVqaTBxZGU2OC92?=
 =?utf-8?B?ZnNTRjR1YzJXNDk1VkxIdWJIeURzdXNzTUVkYU1CdWRScWdlaUQzOG9naUNo?=
 =?utf-8?B?SHZBWlprTUorNzE3ck1WRGh1WURTdVhuYXN0Q21zc0JxMFppQ3RiYkRDNW1P?=
 =?utf-8?B?YTNYaUc2cHRnNlptUXFxaTRCTXpKK01xTFJJK1NKZnlKSGNod1piMnl5dThD?=
 =?utf-8?B?c3Y3Y3VzQ0w4TmZpMnBLK1hyMUpJekxHVkwzMG5NZGpjczZ6M0plTTBVRUY0?=
 =?utf-8?B?QWZqcU5wYk52VGswR2xadXlKYUxsb1pBTzF3TVRZUmt1QXJkVDM5SGtRa1Fa?=
 =?utf-8?B?OXo1blFyeXlFdy9Mb3k2ekJHSW0wdXZWM3RKNTZGdXVWUkpJNEcwY0dWQjVV?=
 =?utf-8?B?WW5NaTVreG5sQnEzT09TaXNxYnhabnNqcTYwRUFtcHlkTzNmNTg3SDhMVmt5?=
 =?utf-8?B?R3ZNYnMzZlpzdUc0RnloWHg5WGRJZkM1dWdtaDlvZ0lQcUowaStzT1pGcXNj?=
 =?utf-8?B?MmJ5a082aVFNcm9PS003eEluek12YTNoL1lWZXVmNmozL2ErNm4yblVUT1Nr?=
 =?utf-8?B?ZnhnQ3NMbllOU0F3cHdBc21ReXZnNWZFRzE2djNOM1FhYTlPYlZRNDYrMFd5?=
 =?utf-8?B?N0liZ1BqTklqakNaTXpVWVRoNThhZDdVV0lpQTlaV0dQc1lxR0VYKzkzSjh2?=
 =?utf-8?B?ZWx2aFpyZEJTeERlWmJTZ0hTTFNXdzlwaEJiYjVKTTRHR3d6Q3c1U0tkZGti?=
 =?utf-8?B?aUgrUlpDbmlwTVJ4VnFJNURpbzhJT3l1Nkh5UnFkRm9OVUd4Z2x5SnpZQzNz?=
 =?utf-8?B?aEJTeW9TUFEyMDNHTTNNcll1aTFJVzdFczBZMkhmZjh2eDZpTmNGVFN4alFZ?=
 =?utf-8?B?MXdkVVNtQlBZR2hFUG40K2Vzc3RDRDZHN1c0c0lrd3VIcFhLQmhRY3diOHor?=
 =?utf-8?B?Tmg5YWlpYmh6YUZTVjM3cGV5M1NOMjBJSXlkNC9JSkFuZHNlb3VBQTA3QWlI?=
 =?utf-8?B?UHRLOHo2OGpzekFSZHB1UU1tMFJGUmR1UFdBTTF0SVV2VzVzalZPVU50aVB1?=
 =?utf-8?B?bEhCSzU4RVIxUzg2d3h0cFJwVUl2SUozQjlRVnJIdWxYYmJuZE5GcEZHSUdw?=
 =?utf-8?B?NG1aTWZHRzkyOEhaVWR5cnNIenUrc0RuQlBCcmhBNG53OE5iRzlMYlFNN1Ix?=
 =?utf-8?B?VmJQdkRVMFh0VmdEbGl6anZlTlEvU2RSdm8rb1hjNkFIU0pWQ015ZFY0eFNN?=
 =?utf-8?B?QkpqZDRjTnVrU0lqVXdtUkdpN0pkdlhsS3F3cFhxRWZITnVybHA0eGpic01T?=
 =?utf-8?B?Um1mcGFUMldoYkdBbDNCbTBtU1FFdnhnNEdTbllNZE1naXpTVVpuUlMycjNj?=
 =?utf-8?B?Vk5mQWxvaXR5MGU0OGFITGkrVnNTVU9vcDM5UTNTeFkvcUpjWWN3QmZtQXpK?=
 =?utf-8?B?NEw4WmtIY3lnV1NlaCs0cDhEUEdHNzVRSk5wenhReFlVcjRRc29HZkhyVUNw?=
 =?utf-8?B?MWdKNmk1U3N3QmZvMVpBdWQ3ckZ6bnJSdWZOK1NDdTQwMTk5d1RBbUFYSzk2?=
 =?utf-8?B?OUdocmVBeTZ5ZExia1pGWTI0UzZxVnBFcC83TVNtMlFiQndpaTVTYy9BMmY1?=
 =?utf-8?B?bFpxczlMcWNCZTJPUG9XQ2FOTGk4Q1d6ZkQySk9PK0tFT0hNbTJBOUJka0Rt?=
 =?utf-8?B?OTc5OS9MNURkbURVM01yZVNiQ1NXY3NLVTdmeTJscStrM1NyYXUya2xKWHp2?=
 =?utf-8?B?ZUhqUnNIcm9FTFlWSEh1dE5WM3R0OGxCYUxmNVlKSGhrRVpDMkdQaEdZdyt6?=
 =?utf-8?B?RGZEQ0VkRnJuNnkvUjlPeHR2UWZrZEFaLzZvU25BbDlES3dlbTdwK1Jybjhz?=
 =?utf-8?Q?zutGptvEOhMvpdmkzDqKzrdFf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4951b24-e26e-4c2d-9bb9-08dd58a8c05c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 10:06:36.4863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: leR2V+r72U88cqlciTInGnFzm3UrtL07WGoLnNUNmI2RM4n59Gx5aoOQvT+X3zrN2uJtOy9v04d+x6mpTMt1TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5179
X-OriginatorOrg: intel.com

On 2025/3/1 12:46, Nicolin Chen wrote:
> On Fri, Feb 28, 2025 at 10:12:32PM +0800, Yi Liu wrote:
>> On 2025/2/28 00:04, Nicolin Chen wrote:
>>> On Thu, Feb 27, 2025 at 09:43:01AM +0800, Yi Liu wrote:
>>>> On 2025/2/27 07:11, Nicolin Chen wrote:
>>>>>> +	/* Not a replace case */
>>>>>> +	if (!curr) {
>>>>>
>>>>> Mind elaborating this?
>>>>
>>>> If curr is null, this is more an attach op.
>>>
>>> Does it mean that this function doesn't allow to replace a domain
>>> that has no handle? But how can that be an attach op? I mean there
>>> still could be a use case of replacing a domain (no handle) with
>>> another domain (no handle or has handle)?
>>
>> I think you misunderstood me here. The core stores either domain or handle
>> now after the handle series. So curr==NULL means no prior attached
>> domain(either with or w/o handle). That's why I said it is more like an
>> attach and should use attach op.
>>
>> replace a domain w/o handle to another domain with handle is supported.
>> vice versa.
>>
>> But replace a domain w/o handle to another domain w/o handle is not
>> supported as I didn't add it. But it can be supported if there is
>> use case.
> 
> OK. Do you mind sparing a few more words in the comment line,
> to clarify that !curr means the domain has not been attached
> to anything so it shouldn't be a replace case?

sure.

-- 
Regards,
Yi Liu
