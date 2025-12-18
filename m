Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ADA2E8B94
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045077; cv=fail; b=J9R5Zwnlfs6f/x3sWXT6tk/phlKOg/FJ7SeH7nefjkQTviuntEmH8m4xUXLHSicqQ0ALtqu6yf5Q9MDxo1guZQY2z5Yei3WFzmilEzT7uIjr2/kIFUpb1vhRg3R4Ay7wiA0G78+FhGt0SsfcEiHkGhpcOofUr1NUPxFEPGUaEBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045077; c=relaxed/simple;
	bh=ksLz6jUy1hmdAtZy2++CghNuVCKulcVzm+RiBVtbZn8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ltnGIA7THtOzcuvfkbgvzzUyxeyz1eNlFM/lmbVbrALuFC1WAovmWh7iAioUCD/HyVIVWGQsb5KQ4zozCyfQosdBBcPn92sWnTjMLbrEKhIbC29LYsN1QKrY2KgUfJ1eCS8bZjyIVeEc7CMTP7BkMWh3oJrLSZBnO2KkTVS2PS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K+d8ZHM4; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+d8ZHM4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766045075; x=1797581075;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ksLz6jUy1hmdAtZy2++CghNuVCKulcVzm+RiBVtbZn8=;
  b=K+d8ZHM4KGI4jz3W85SSOaCBIfYbt1+riuihts0LXbyQojKkOP/XQ6IR
   Bt+9SFe7zddkekceC7sB0i3hREzG8dNG7Vv0fCveH9XDF2etQbC7uT5q6
   bUie6P5UhK/JgQuGZx9kD4vWnN02qcsdGn978Ms+MevNd62aS+5DFjQ3b
   MAykj+u/Ak11gAu83y6cHVFsnWBrhjZRIt8Vg3jKltNbz1LLn1aPLT3RE
   AJueNNZTHkfMFQtirPAcDjATzwGF8UqAFpelGrhgCCKUieCePyYv2zTTG
   rQwr7ILdIsv1BzJ8mXn3aHOMupE5c+aNhLutJ/suMtWwkNylhkurbY9Ca
   Q==;
X-CSE-ConnectionGUID: 5IR9B4QfSU+iNLjW7Ln21A==
X-CSE-MsgGUID: 9PSNwXmXRB2hy3Q3705FgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="68032904"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="68032904"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 00:04:34 -0800
X-CSE-ConnectionGUID: MBX3jTYhQTW7UR5UPIzhuQ==
X-CSE-MsgGUID: Ieg2IpEgSXq3hB6odOiTDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="202905493"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 00:04:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 00:04:33 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 18 Dec 2025 00:04:33 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 00:04:33 -0800
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7084.namprd11.prod.outlook.com (2603:10b6:930:50::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 08:04:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 08:04:20 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Guo, Jinhui" <guojinhui.liam@bytedance.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>
CC: "Guo, Jinhui" <guojinhui.liam@bytedance.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] iommu/vt-d: Flush dev-IOTLB only when PCIe device
 is accessible in scalable mode
Thread-Topic: [PATCH v2 2/2] iommu/vt-d: Flush dev-IOTLB only when PCIe device
 is accessible in scalable mode
Thread-Index: AQHcalLjYTc62byjOUyaz3iqPujJhLUnDxcQ
Date: Thu, 18 Dec 2025 08:04:20 +0000
Message-ID: <BN9PR11MB52763E38B4C8B59C9A9AD9E18CA8A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20251211035946.2071-1-guojinhui.liam@bytedance.com>
 <20251211035946.2071-3-guojinhui.liam@bytedance.com>
In-Reply-To: <20251211035946.2071-3-guojinhui.liam@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7084:EE_
x-ms-office365-filtering-correlation-id: afbafd89-b34f-426d-83ae-08de3e0c0c81
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?U2M0elRvMjJNZzkxUFVGN0pVY2VSVG1JK2JuSDQ4akoyMG4rTlNoOEpmS0E0?=
 =?utf-8?B?Uk1sNUFjejI4MUZVbzU0dnIyQjhDS0NzQzlrWGdweGhZTG1xdzhxK3JENzgv?=
 =?utf-8?B?d3FhMTN6dWo3N2tCQWVFdzFSOFRJRGJhcFNacEdKcHFTOUhSeTR0L3FMNnJi?=
 =?utf-8?B?RSs3SGxvNXFyQlk3Y09KNnJ6ZEZoelNVd3RKc1dXZGtqaUF6bWJRNDNkU0Rw?=
 =?utf-8?B?YndZTmhzcnZ6V0Rnb1dDKzkxN3dUVllqR3I2a3ExcjZzb1R6b1RDaVVXQUto?=
 =?utf-8?B?NHczVy9jZE5SUTM4clNmY3dlVzlsTTR6V3pyNTQ5c1c2a0c5V1pRVSsraUN4?=
 =?utf-8?B?aENoN1pGd05Jc2pZTmtVckFUSEp0b3doc0UrdmllQk5yd2JzL3ZtQVowNHBq?=
 =?utf-8?B?R2J0OUI5aUtsOHFqRUgwMjFhSDlKMytjQVI5dUltdG9kUklvdzBFbUViTGo4?=
 =?utf-8?B?RG53eGVrb3dqZ2NBL3BnSkw5a0lsUHFYU3dHcGZJNGZTNUVJR2lCRGNFYlhs?=
 =?utf-8?B?bkRkRGQ1WEk2TXBIOFh3M1FXZDhpczBoeXdOYUVOc2xnV1RSdUcvT2ZNOG94?=
 =?utf-8?B?eVBhYzFxdEgzOGw3VXBNNDFqMEpySzB3SmVLb3d6ZE5SMFdzMDd2b1N1UXVn?=
 =?utf-8?B?Uk81RDFkMlVPUWJsYTBxS2VkT2U2VVl0YnVMMnJYeUFpN1RUcnUwaXd4TzIv?=
 =?utf-8?B?dndueTFMcHZPUVA3STE4MVEwbTZWcVRSd3JDR2pKRGZBWnFkYVJwd0xITDRX?=
 =?utf-8?B?cEg1dFRMK0hKNUNrOEp1YkZtQkUxVFBoNFU4T0ZHWmVzZXd4SmQ4TGQwS1VG?=
 =?utf-8?B?RHFxd3JsN1RmanRlRjRmVTJsbXl4U3Y4M2V0d0ptdktVODkrVzBkMXlJMndw?=
 =?utf-8?B?SjMrcGpPbjRSeWMzbUlZR0hVT2NSUE5XNjJMa1dndHdMZDBUaDRPbGMva21S?=
 =?utf-8?B?TXlCdlFOUiswZUlnaHBGREtSVkZodGluWWw4RjNMSElVT1RCNDhKSzVSZmhG?=
 =?utf-8?B?aTZURmhxdmpVOEVVRy9mVkJvcmV5MkIwdE9jMUtla0J4OCtNSjVxVzNKMlhL?=
 =?utf-8?B?YjV1NEdLVGNOUEY2L3ZtcUY4Q3NLQzRtUllHVEdpUERFMUhIdUhoa2J6ejNV?=
 =?utf-8?B?Y0xDa2VjZUI4L001UU1XL0FnSFozTkFNMW85WVJsTjdOT1M5QmdvNWJuZWwx?=
 =?utf-8?B?d09GM2cyUFBCNWliUlBhSndKZUxVUjZ5NUMxQk9NYTluZjY3YStrcllUQmFD?=
 =?utf-8?B?emxwTUVyUWp4SEYySng1U2VNSFJmRENueGZCWWR3TmUycCt1eHhNVXlCNzdx?=
 =?utf-8?B?MXRIcEZacVJRd09PejhBaGk4U2JEWEFXM3VVQXBSRmNmMWpGcXVlMklpT1dI?=
 =?utf-8?B?NmxGWUxxRVpUMjBEVVNNVXh5T1FSRlBpRVdVWDdxNlMzUU9lYUNzS0VZRnMv?=
 =?utf-8?B?TWI2aWdzdlpkT2RMeVBpKzVkY0VWeFRKN2hUbDVBb2laTnk1ZmJzYUFoUzQw?=
 =?utf-8?B?ODJvOWgxeVREbkJzYUI1OXpvckgyekMvaUk2NHJyOEtvMkkvYTRLQ1NobmVr?=
 =?utf-8?B?ZE5oRElKTjF4U2pxSUNpWGtraitXM3FoLzB5QUUwV041eFJxd1FLYk5mVEFn?=
 =?utf-8?B?T004OUlSY1o0UVAydklPWm8rVGxaRnk2QVR2OEptMDRjRmoyT2FlekUxSUE2?=
 =?utf-8?B?Znd2eUJMRGJMS21aSjhxTElGL2xIWkxPM2h5QjFNb0w5cFh1WTA0RnF3OVhP?=
 =?utf-8?B?K3JsZCtEdlEwL2hZc0Z4YWwrbkZ0M3ZsSGdGVnlCUitUMUFEaGtucWJjb0l0?=
 =?utf-8?B?a1ZObjhwS1E3bzg1V2pUaFpGN2ZrZXBjM3lUUkc2aUhrWStrbk5ud3JQcVFZ?=
 =?utf-8?B?cVgvSWQxRzl4SGtIckFmSG90UFZjZ1FhVHFJQ2VzQW5idWRuVXExbTJSVVRB?=
 =?utf-8?B?Zi9VZWJNd3lGRjNXZmZXdEJldUsxbWx0YjU2TDdick5WdkdYemtOaGYzUzJ3?=
 =?utf-8?B?T29XZzZ4b3RNNHRyY3BQZFlML1RrWUtVS1YwV3d2UmQyOE55M0p2N3VrWnIr?=
 =?utf-8?Q?7WoakP?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SklXVWYxTDBwNXVwV2d3NldiOHREK2pxMGFWSnJJQ3pmaGhuQWIxK01Rc2hL?=
 =?utf-8?B?ajhJR1VMdzNyNkVrT3A2VVhwSG02N2VOYTE1Tk9NNGEzYmRhZkttYlV5Wkxy?=
 =?utf-8?B?NWF6WHhxTnUrZXl5Skc2SUZTQ1hJb0FVWjgxRmdFT2pUUWRMQXFVQlcrM1B6?=
 =?utf-8?B?Q3JiRDdZenYwZHFYYW9QRzlTaXhQTThCSXV3czV4U2FEWkJDcnlXSmVFNU1O?=
 =?utf-8?B?RWNrK2ZDeTJXbWMzeXpmYTlNTTdNVmpFRFgyQVF5YW8zWHNZbytCeEoyK3Yw?=
 =?utf-8?B?cnBmVEZqOGRQaXRncHI5SHY1YytidjRKRFNjRHQ2MVZJVDlBUnVoMFlZVUM3?=
 =?utf-8?B?aVk4WndncVRvYTdvaUFZaTdZN2RqalQzdjllVmhqckhuS05jZVovdGVSaHo2?=
 =?utf-8?B?N2VaUDhHL0hQaHBxT1JOclFZT0tqNGozNkZqRVpHZHQ3NzJnQ3N4VTlHL3E0?=
 =?utf-8?B?Sk5hcy9GTU10NTlFYVdEVWYwaFM4WG9OdUhnUVd6b0psZ1laSk00bVVOT1FB?=
 =?utf-8?B?NjRVbkdwbjV6aVdEZFpPaEJjUmUzMXFtc0lnL2lCMzNyTEdBZTdtcVIwU3JI?=
 =?utf-8?B?cUxwTFFHUk9jWWVGdlpmZnUxZWxyblNZM0lId1ZEc3Rib0FDeSsyd1laVzZU?=
 =?utf-8?B?TUMyYkxSYmlqL3g0S2xJNUprQllYdVRCOU40OHgzVndjYisvbWtWMXdKemo2?=
 =?utf-8?B?citCVncvd3NvU0txVC81Zlp5cGJ6WUlxOXp0RGZmVlBPbzNXNEFrdko2Q0JC?=
 =?utf-8?B?VUE5d3U4ZGlQd2k3ZGpHdXZZNHN5Nit1aVpINWJEYnZ6RFJhUkRMMG5zTFB2?=
 =?utf-8?B?ZWdFajFiMFRWa0VmRS9PTFovNFZ4QkdPd25OYUNBaGI1OGFQL253UGFDQnZx?=
 =?utf-8?B?OHkwSm1SK3NxNDgvVmxiSVJtaGJkZm85aXFUT1Uwa3NhMDgzUVg0TnEvZFBy?=
 =?utf-8?B?S0oyUXRud1NZeEZpOWdRYUp3MFZpbGNYOVE0L3o5aDNNWHVVZjIxL3ppZzBE?=
 =?utf-8?B?VmRJL0c5K3dQQ0hBMEVQdXhsb3hoVHdibEVHeTJ1T0lUbldrMlFCOUUreWZq?=
 =?utf-8?B?RjRjTGZRZW1uNXlmcDdlcnAzNWpWTXc5UWQ4QzJxOXA2N2lKWHJ5c3U3cER3?=
 =?utf-8?B?bHJVVXFRSGNtRUFTcW8rVHdqK21yMGFMeXFJZTRaMis0cTljVCtkMDZ3MTdL?=
 =?utf-8?B?bzM4eXpSeER4QlJ1Y2U5Zk5XNERyQ1hLbFVsTlpualN6ZmdIRk4xdWcxYWNK?=
 =?utf-8?B?Qmk5ZGpxVkQ4MU0xZ1RBd3g2MStRbHJrRXk5UDlwY0xvTGFveENBWlBWZlM3?=
 =?utf-8?B?azZ4MkhtZk83YVdQaHhOMmpFanZFVVZadEl1TTBaNUViRGd5TFFhcjF0OWoz?=
 =?utf-8?B?NkdRa1lsS0lndjBkdWR5bUNsMVpaa1NTUjFhRUVxYlhxRzhySWRPRmcyc01X?=
 =?utf-8?B?ZCtMWmo5cUFzSlVOZStsYTh4WEc5WDltLzBXQ2JvUUFDMTBmd0c4OHFsMHcx?=
 =?utf-8?B?YWExTG9vbDJaODMvSXMvcDNDUms1TWwzQUp1RHV1TEIrZkh1MXN4OVI1aFU3?=
 =?utf-8?B?R0VNYWdnb2laK3ZnN0xjbE4zb1JNWVBMZ2lSMlhsUlFLcnBoVWJ5Z1R1SElW?=
 =?utf-8?B?NWdKemVWN2xqdnhuWmp2aW1KK2IzTDkyRmxRbng5SGlxU05QbnhTbVVSL3pJ?=
 =?utf-8?B?TnlVN0FpNlJFODJBdnRkdm9GVGlxbE1MRWNQblg2YURDZU1rc01HT2d3bGJm?=
 =?utf-8?B?T0RscEsrbTArS2d5YjBWUkxleFYwV0RSQkdDbVhxeGswcnp1YzIwdTI2bzJw?=
 =?utf-8?B?TDBPcncyY2dVNEE3N3FHc3JyUzZ0RC85TnluQi9ocWVqTzFmYy9uRkV4MjJB?=
 =?utf-8?B?UWFuUGJWMjdlRjlqNEdUYnRWUTNYU3NSZmYrTHQrNk1WQzVJZGtidVdXeGRk?=
 =?utf-8?B?M3BUcXJTdnpqcUVXeVdQRnRTK2tOQ3FSZDFmcDErSkN5UFBYM1ZNUEtPV2Ft?=
 =?utf-8?B?Sk9ONS84cWlIMUJLZHNJQWNGTllOY0toSlRhOFQ3K3V6TDRDVlBkR0RiWXJV?=
 =?utf-8?B?TDZKMlpJWkpJczVCOUU4ODd5cmptbHJrek8xcjIydkN4M1NtUE9PSkdSMjR4?=
 =?utf-8?Q?f1W7jaySmGaGmAxU0PvqtDlIn?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJmFu4rV4ZogoDDsJrh7RmM2pJGunLY5yRaIyzRG3aBdmg3cXuNYrP7jnISjU37Z4m7XWaaK0UvMyenqyPIWbQMpE8Ui4+7J8fFcxPUx8J/SMxeY725VG1svnCCWpl33B/E8k6ZhF3HyKhbqKFQVb3/3S1t5bRWLkjZvNrPDK0pXSJMjI+v2WLzsDEpXfJpn4InJrTs71rt8hPWKoAbMYcg8D1GMD4Vfj9fBM+oyfDSYS7SN4rfJxxmbWLvgFfqdTUTkgQKMUhrD+kRENT1812k5MCufIN5pMPyH90i5UJ90w7NIYeHKd5hhPUde6sz7tVm16YzgkeUSngV04TGmXw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6kulxBR+jt6yFzJcwni0vPIootXSs+SZiqxdL18EjM=;
 b=L7Zko0nsqHF1Vycy375eF1b/hISSFt106DqB3Pwns6nDgDE+Vm/MDX5YPPFp+5Xmxv+2+veUM3CmAX0spO5RfVgdv3g3ycKKbl4B75WIhsClZ6VSBZOFiKXoEeIDUH+RHpuSJ6ww/cS0wB1D7/xP4ccWgOlpwUyUJTKP5P8eZ/Ur2WdUqiZDxr7z13FGgZXxX6gmqoU6NnA5FV73Wb2s919jQa3Suf5kXkxjFeoJR6LWjw+MXWWefA+IdhDMP9FRFRyUixNup1qbECuebUJX/w9sbtTqVi1OC7dpXa2CXkgMO4vMc/GPzSY7stYHU/w0wYIDKotutrdnCwaHFmzEbg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BN9PR11MB5276.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: afbafd89-b34f-426d-83ae-08de3e0c0c81
x-ms-exchange-crosstenant-originalarrivaltime: 18 Dec 2025 08:04:20.3391 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: lCvuUkqD7aq9/jIRRxjZVzd9pDLae16bUPcccqQucM3AqwwTI7aI1rnrYb+r6mQAUoG8qCL8Xx5eIcW0yprnFQ==
x-ms-exchange-transport-crosstenantheadersstamped: CY8PR11MB7084
x-originatororg: intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

PiBGcm9tOiBKaW5odWkgR3VvIDxndW9qaW5odWkubGlhbUBieXRlZGFuY2UuY29tPg0KPiBTZW50
OiBUaHVyc2RheSwgRGVjZW1iZXIgMTEsIDIwMjUgMTI6MDAgUE0NCj4NCj4gQ29tbWl0IDRmYzgy
Y2Q5MDdhYyAoImlvbW11L3Z0LWQ6IERvbid0IGlzc3VlIEFUUyBJbnZhbGlkYXRpb24NCj4gcmVx
dWVzdCB3aGVuIGRldmljZSBpcyBkaXNjb25uZWN0ZWQiKSByZWxpZXMgb24NCj4gcGNpX2Rldl9p
c19kaXNjb25uZWN0ZWQoKSB0byBza2lwIEFUUyBpbnZhbGlkYXRpb24gZm9yDQo+IHNhZmVseS1y
ZW1vdmVkIGRldmljZXMsIGJ1dCBpdCBkb2VzIG5vdCBjb3ZlciBsaW5rLWRvd24gY2F1c2VkDQo+
IGJ5IGZhdWx0cywgd2hpY2ggY2FuIHN0aWxsIGhhcmQtbG9jayB0aGUgc3lzdGVtLg0KDQpBY2Nv
cmRpbmcgdG8gdGhlIGNvbW1pdCBtc2cgaXQgYWN0dWFsbHkgdHJpZXMgdG8gZml4IHRoZSBoYXJk
IGxvY2t1cA0Kd2l0aCBzdXJwcmlzZSByZW1vdmFsLiBGb3Igc2FmZSByZW1vdmFsIHRoZSBkZXZp
Y2UgaXMgbm90IHJlbW92ZWQNCmJlZm9yZSBpbnZhbGlkYXRpb24gaXMgZG9uZToNCg0KIg0KICAg
IEZvciBzYWZlIHJlbW92YWwsIGRldmljZSB3b3VsZG4ndCBiZSByZW1vdmVkIHVudGlsIHRoZSB3
aG9sZSBzb2Z0d2FyZQ0KICAgIGhhbmRsaW5nIHByb2Nlc3MgaXMgZG9uZSwgaXQgd291bGRuJ3Qg
dHJpZ2dlciB0aGUgaGFyZCBsb2NrIHVwIGlzc3VlDQogICAgY2F1c2VkIGJ5IHRvbyBsb25nIEFU
UyBJbnZhbGlkYXRpb24gdGltZW91dCB3YWl0Lg0KIg0KDQpDYW4geW91IGhlbHAgYXJ0aWN1bGF0
ZSB0aGUgcHJvYmxlbSBlc3BlY2lhbGx5IGFib3V0IHRoZSBwYXJ0DQonbGluay1kb3duIGNhdXNl
ZCBieSBmYXVsdHMiPyBXaGF0IGFyZSB0aG9zZSBmYXVsdHM/IEhvdyBhcmUNCnRoZXkgZGlmZmVy
ZW50IGZyb20gdGhlIHNhaWQgc3VycHJpc2UgcmVtb3ZhbCBpbiB0aGUgY29tbWl0DQptc2cgdG8g
bm90IHNldCBwY2lfZGV2X2lzX2Rpc2Nvbm5lY3RlZCgpPw0KDQo+DQo+IEZvciBleGFtcGxlLCBp
ZiBhIFZNIGZhaWxzIHRvIGNvbm5lY3QgdG8gdGhlIFBDSWUgZGV2aWNlLA0KDQonZmFpbGVkJyBm
b3Igd2hhdCByZWFzb24/DQoNCj4gInZpcnNoIGRlc3Ryb3kiIGlzIGV4ZWN1dGVkIHRvIHJlbGVh
c2UgcmVzb3VyY2VzIGFuZCBpc29sYXRlDQo+IHRoZSBmYXVsdCwgYnV0IGEgaGFyZC1sb2NrdXAg
b2NjdXJzIHdoaWxlIHJlbGVhc2luZyB0aGUgZ3JvdXAgZmQuDQo+DQo+IENhbGwgVHJhY2U6DQo+
ICBxaV9zdWJtaXRfc3luYw0KPiAgcWlfZmx1c2hfZGV2X2lvdGxiDQo+ICBpbnRlbF9wYXNpZF90
ZWFyX2Rvd25fZW50cnkNCj4gIGRldmljZV9ibG9ja190cmFuc2xhdGlvbg0KPiAgYmxvY2tpbmdf
ZG9tYWluX2F0dGFjaF9kZXYNCj4gIF9faW9tbXVfYXR0YWNoX2RldmljZQ0KPiAgX19pb21tdV9k
ZXZpY2Vfc2V0X2RvbWFpbg0KPiAgX19pb21tdV9ncm91cF9zZXRfZG9tYWluX2ludGVybmFsDQo+
ICBpb21tdV9kZXRhY2hfZ3JvdXANCj4gIHZmaW9faW9tbXVfdHlwZTFfZGV0YWNoX2dyb3VwDQo+
ICB2ZmlvX2dyb3VwX2RldGFjaF9jb250YWluZXINCj4gIHZmaW9fZ3JvdXBfZm9wc19yZWxlYXNl
DQo+ICBfX2ZwdXQNCj4NCj4gQWx0aG91Z2ggcGNpX2RldmljZV9pc19wcmVzZW50KCkgaXMgc2xv
d2VyIHRoYW4NCj4gcGNpX2Rldl9pc19kaXNjb25uZWN0ZWQoKSwgaXQgc3RpbGwgdGFrZXMgb25s
eSB+NzAgwrVzIG9uIGENCj4gQ29ubmVjdFgtNSAoOCBHVC9zLCB4MikgYW5kIGJlY29tZXMgZXZl
biBmYXN0ZXIgYXMgUENJZSBzcGVlZA0KPiBhbmQgd2lkdGggaW5jcmVhc2UuDQo+DQo+IEJlc2lk
ZXMsIGRldnRsYl9pbnZhbGlkYXRpb25fd2l0aF9wYXNpZCgpIGlzIGNhbGxlZCBvbmx5IGluIHRo
ZQ0KPiBwYXRocyBiZWxvdywgd2hpY2ggYXJlIGZhciBsZXNzIGZyZXF1ZW50IHRoYW4gbWVtb3J5
IG1hcC91bm1hcC4NCj4NCj4gMS4gbW0tc3RydWN0IHJlbGVhc2UNCj4gMi4ge2F0dGFjaCxyZWxl
YXNlfV9kZXYNCj4gMy4gc2V0L3JlbW92ZSBQQVNJRA0KPiA0LiBkaXJ0eS10cmFja2luZyBzZXR1
cA0KPg0KDQpzdXJwcmlzZSByZW1vdmFsIGNhbiBoYXBwZW4gYXQgYW55IHRpbWUsIGUuZy4gYWZ0
ZXIgdGhlIGNoZWNrIG9mDQpwY2lfZGV2aWNlX2lzX3ByZXNlbnQoKS4gSW4gdGhlIGVuZCB3ZSBu
ZWVkIHRoZSBsb2dpYyBpbg0KcWlfY2hlY2tfZmF1bHQoKSB0byBjaGVjayB0aGUgcHJlc2VuY2Ug
dXBvbiBJVEUgdGltZW91dCBlcnJvcg0KcmVjZWl2ZWQgdG8gYnJlYWsgdGhlIGluZmluaXRlIGxv
b3AuIFNvIGluIHlvdXIgY2FzZSBldmVuIHdpdGgNCnRoYXQgbG9naWNpIGluIHBsYWNlIHlvdSBz
dGlsbCBvYnNlcnZlIGxvY2t1cCAocHJvYmFibHkgZHVlIHRvDQpoYXJkd2FyZSBJVEUgdGltZW91
dCBpcyBsb25nZXIgdGhhbiB0aGUgbG9ja3VwIGRldGVjdGlvbiBvbg0KdGhlIENQVT8NCg0KSW4g
YW55IGNhc2UgdGhpcyBjaGFuZ2UgY2Fubm90IDEwMCUgZml4IHRoZSBsb2NrdXAuIEl0IGp1c3QN
CnJlZHVjZXMgdGhlIHBvc3NpYmlsaXR5IHdoaWNoIHNob3VsZCBiZSBtYWRlIGNsZWFyLg0K
