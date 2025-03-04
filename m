Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6FFAD24
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741073691; cv=fail; b=QB3nX2GxsNpSiXVgiIewk953cVzDoymdWUla8MuIK6jhMT8axOsN/zWxd0xiZtOSgA23cJBZwELrxAunImV9volkOyEoyAwr5tkry9qOJZbruht5jyhT4A89RSLSaHKS83bIvfi7kb9p86gNlBEP2ZEle9d81VYmLgmPHkhwkBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741073691; c=relaxed/simple;
	bh=tW3nurWADITP2oZLaQxB5udpCzSWKZYcF+viTsHWnPc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kGG2m1SQFt0U+9eZDzi88qXHB2KirrXXirGcSJm7Wxj/yTVTThhE4DDtkFTAgGavbhBDGuLgHzzNrDaZbZ4WqeZVLMsWbWlwCtQRUc+B7ww+jxpoeA3wyg70TBVhTmKwc/HGycxF/4FIewgBCsFGwFfIBFe2711qhnsISCJD5As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=coPBVoyI; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="coPBVoyI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741073690; x=1772609690;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tW3nurWADITP2oZLaQxB5udpCzSWKZYcF+viTsHWnPc=;
  b=coPBVoyIv2v5Q8ykoIVpGJlsmyQLqCJrNMS/GuVqk0Kz3TYzeMxct7aZ
   PTIczhEe+6gbH8ateBYnM3//OP1OsHIfsxSEw904LVvRpYJ6ZFi9mQx4M
   Cm+H2iLgbn+d3tLtng/ydACiyLnljfxdfYLxelFwZ/ngBfWdS9CfkV6er
   XRnIj1lxlIqA8/gaTh4+Ca/lXrVpnGNHMdq/vQYxJzJ7KN9fUAfxCkNek
   Pxdg2PyLpqhi/L7PY5kiOgBaOVXK9Y0WG1IYrtnChSEwQfnJRTZcwhvI/
   w4UguC3LikEamoosb3W+GmGKao5nQW55GQ/+MGRnUFI/4HuugLKp6eq2q
   w==;
X-CSE-ConnectionGUID: 9uXBaEi8ShilpoBisjx0hA==
X-CSE-MsgGUID: LI4zf2/USzODXicjdQaH2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="59390369"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="59390369"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:34:49 -0800
X-CSE-ConnectionGUID: rdJ70IEuR/uK3r4AdhPvBQ==
X-CSE-MsgGUID: aotdvUhlQomT566vfgx7JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="155473922"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:34:49 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 3 Mar 2025 23:34:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 3 Mar 2025 23:34:48 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 23:34:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHkliy5Bdjuy6agTKQ1WGDEfCOJptkHpfbUNY7JEeruhxTIausZ3m84qw31hscIA53ZYWCtkV3J6lFZIH4kZSmbjH5ZeThwZICdByS2gwd1uVTMgGPdSFnh8lRTQexdPC/XJfAq0a+kxl+QT+cZ6khRMDJRr8KYZBXZ00PRXs3bN/QHOj2fQA1FwSiyocQyZfHOin5ekeR2ojWyRff2nVFnVefpzlvPFCzG16TWJvRlI3HiOFI2RQIq9k0UXufun1lmIFlkB4brA4a9oz02St/XdCxFpHJJdooQcCdU0JCrJbGi3wAxixKXFq2jtLMF9nl52B9TWMlM892XkKsxy/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tW3nurWADITP2oZLaQxB5udpCzSWKZYcF+viTsHWnPc=;
 b=tjuxH2v0PM7daetAEVozyIabgO1yXkndzECA1u0yKU+Fb+ZtKKlTBbOstZ3/ajTtujY2Acf+Ru8XLlKcEiE7m7D7bKnk2rxIjJ8OADbJ3OfSYrvUNcmYTr06bYbG+r3RWA2wRLZGltG7rShzIEAlQEWBfsn5gs4jn49WXaBrd1+zkk9aTQmQitGwm4zLh30s3nvrvUlYm0Hvr6SsIbGfhbct+Zbwbtkimzz6QB9PWi6JAEK0Q2bIXhjsg56cpvISuP52m2FEac3ZJFEqUZlpUkA1q4UZ2ZWjBjPY5sAlnR02xMS8z+VqW/XHcHayTn31lFxLcWafS+iETtZaiTxajA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by DM4PR11MB8160.namprd11.prod.outlook.com (2603:10b6:8:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 07:34:04 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%4]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 07:34:04 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>
Subject: RE: [PATCH v8 01/12] iommu: Add iommu_attach_device_pasid_handle()
Thread-Topic: [PATCH v8 01/12] iommu: Add iommu_attach_device_pasid_handle()
Thread-Index: AQHbiENEzpvayV4ON0Oih1J/GvHIBLNc11UAgAE8i4CABIjS4A==
Date: Tue, 4 Mar 2025 07:34:04 +0000
Message-ID: <BL1PR11MB52713F95379F378437639FBB8CC82@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-2-yi.l.liu@intel.com>
 <20250228151750.GU39591@nvidia.com>
 <a51a5480-b06c-4065-a3ed-49046121cae7@intel.com>
In-Reply-To: <a51a5480-b06c-4065-a3ed-49046121cae7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|DM4PR11MB8160:EE_
x-ms-office365-filtering-correlation-id: ed5ca1ab-add8-4834-32aa-08dd5aeef0ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YmRsMlU4TTE3cnpSeVh5OElmbStLbWlxZjJpcHl4b3ViWjdKMGY1RGV0U3Fm?=
 =?utf-8?B?Tkl2VlNTRXZ4Z1RYWnE1ZmNvbjdsU1V5NlFYc1paeGVQejlvbWtYenFRdEJ3?=
 =?utf-8?B?MGorZ05NdkZCZ0lUUElhWjJPbjNreTN4dlFiNk9tWThYTmNobkFKUjlTdE5t?=
 =?utf-8?B?YkloR2QxeGRGa0pGZkFMcElSSlFSWWo2NzBvRU1Ld2RJN0JYNkk2NG9MR2Fw?=
 =?utf-8?B?eTAyb3NMbXh2eWcycDllc2V0VmVVY3JJQ3I2MFlKeEt5WU9FNFU0cm9VUFVt?=
 =?utf-8?B?SmJqRjhxV1V5RitKMnh6ZEhRK0VJQ1dVSnMyK0Rob1JqWHc1RitxS2UzTVd2?=
 =?utf-8?B?eGlMSnNodWZ1ODVhc2ZBcDVVRzAvYjRXUDVKcjh3dGdxWUtlMm91dUp6NEZP?=
 =?utf-8?B?VVIrempGTzhHVmtEWjFaM2Y2M2pTTDlzQ3dXNzVjMFVqN1VQYVlFQ0VBZlRX?=
 =?utf-8?B?aC83U0J4dlFvcWwwdHZ1SmFyRUVLNGV5czlIczBaZ0RjeEVObTBrUWgrUVFH?=
 =?utf-8?B?eklJYjg5N2w3enJEQ21SbG0wRmlHZ212N1lkb2tCMWJySzZ2dVBzTG1LU0sz?=
 =?utf-8?B?ZzlKMDdmNjJMdlRsVXJ6eE1mVWVzaG5NR3d1d2pBazgra0NJSFpzZ1R1b3lm?=
 =?utf-8?B?aWdkYkpweUhzdFFSSm5NK1YxUW9EUS80NjMvVjRtcDFQTzBLZlBJbjhwUlpq?=
 =?utf-8?B?aFFuMmwrelBTTVRqYTRPVVM4aFBTeUtuRWVvSWEweDJDVVZiSWxBSThXQjl0?=
 =?utf-8?B?Y2Qva21vYjhnS3Z4K2phZE9VSVFSUmZZN2NtSDdIQWVqbDNMdkJYNlExMnhr?=
 =?utf-8?B?dHJZWG9lZ295UWFDZjhSeU14aTlCOXJjM29tTzVZZmVxeExNKzJmVTA2Tzlq?=
 =?utf-8?B?K1ZJZWp6N0d6Skt5V016ZDgySlRLOXNjdzYwUFdxMVpYcXFXNzVDY1h1R09y?=
 =?utf-8?B?YzJwMk15SUZjSDRBYU9hOUR5c2FnK1V1VGtNejZ2MFBUQzZ0NTNpNWVzYTkx?=
 =?utf-8?B?cGdyQkd2VmdSc2JBeEd4aWViRThRbGVadU1TV1RBSE1VQVhZc1d5MlM5ZlZG?=
 =?utf-8?B?cTh2NWNOZFJpYkhOUDExMUEvOHFsVnlaZnRNSHdjNm9OM1VkUHU3N2ZBSkUy?=
 =?utf-8?B?OW9FbVBQQU40dmhHZTVLY2tsVUJpeW5WbW5IbHBrUU1OQ0tLTEVaSTdja0d0?=
 =?utf-8?B?c0JkUU9SWXp2c2l4N3lYRHVmV3E3L0dibUp2dEZURnIzdEJaV2dkQnZyUXph?=
 =?utf-8?B?d3NuN1dDMGUvWXpzMnBkUEVpNHhLVFBqUDRrYjI0ODdHcXJUNElHTkYyd1hu?=
 =?utf-8?B?V0h0ekZUQlkxTXhuV2N3ZDkvSnI0VjBRK3hVV1E3ejlaZUdzd3JHUHYzZFNv?=
 =?utf-8?B?cGdQdjBnbm1ZZWZxbFI3Z1pVWHYwckVjZXZYbHJyMlU2ejlWdHRFcXVWdlBX?=
 =?utf-8?B?TDBJNmpveTNGaXhab3EzdHByd2drYTNYRTV1NDJTV1V4a09yNFgzOWlRUGNZ?=
 =?utf-8?B?TkFDRE1PbXhDdm9CajNsbWtwY3RmMzg1NTU3eDhxekZFREZ6YlBIczNHUXFa?=
 =?utf-8?B?YmlNNWUvSEFNYzM2Sks4WTJMMkRQb1lnclJSZkEzRnlyZGQzeUR3RFFMaXhV?=
 =?utf-8?B?dFgydzl4SnBGVmJ4SW9zZmZvNnFQYy9GWXlzejlGNFRuUDZPcHRlamI5N0pW?=
 =?utf-8?B?T3RybGR4VlQyRTdNY1FPY0NRbFJURkhrWEhlUmxZdHE4YmpvZnJzT1hZdE42?=
 =?utf-8?B?anZYamNCOU5leDBDUTBnZnRFOUJBZjhTeGFkbmc2dm5pUHlxckZnMnM4S3RB?=
 =?utf-8?B?OEtqU2dLMXMyTGVkL2hLMTdaUDFUSTBlYnBDbmhpMzlwQVZmbG8vd3AxN1Bv?=
 =?utf-8?B?blE5QngxMGJxakhJV2FOMW1rR3lGR1VQOUIySUx3anBDUlFtMWNuRTJ2Ulcx?=
 =?utf-8?Q?7L78k7qpx+hvI3/GJsmTUpou2biuhhZs?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzdrU3JpekhLeFNUcVhkOERoK0hxNzVEK0kzMmd2aVZFOU1JeC9jSENmWCtU?=
 =?utf-8?B?dnl5NElmSkRKd0FYSXYzL3Z6S1hzU3JNbE9MY1ZJc1BoN3hYb1FpUkRVRXZC?=
 =?utf-8?B?TUlIWENPcjFPOG5wWXdEVFAzVWZyVWUzNnpaMnM2ZEI5UFRzVStjSlArSGx3?=
 =?utf-8?B?SHIwVU50eFdXWjFwMDhpSkJMa0YwdWFXOWdZRk0yTjNKWElIYjlmTjVtQTZZ?=
 =?utf-8?B?R0ovV0d3VmcyS1drZ29SdVg4UzluYzZKd1ZhUTlyQnFkUkRJREFic0FnTUh4?=
 =?utf-8?B?bUgzWW9HaU4wVTNGRytaTHdPQ1gvRHR3R21zRFBlelhhYmVmTlgzT3lVamdS?=
 =?utf-8?B?RVJ3UHppUTN5ZnBZbS9uUk9SZVJvTnR3SmkwV25qMFl6eHJpc0VSNE1oM0lz?=
 =?utf-8?B?UVpUOGRoVjQ1OCs3UmV5SmFiUm1ObjNCQWUrc1JOeU82WnhvL0p2Q25uR0pE?=
 =?utf-8?B?S01IT0krYU1ySzdQZ0ZBNmdyeUNESDhPQm9rcnlRZDB0dW9qZmIxWVVOVVhG?=
 =?utf-8?B?UndCdUpkVnhkNkZrZVB0dW8rcmp6MG54S3lYbVFySEhCejRteG4rb3YvSlBE?=
 =?utf-8?B?bCswOWtaanBsb0x4TUJMYnVjL0dCM0JPTUNlOFBRSWJnL01RcUQ0TWRsczZD?=
 =?utf-8?B?Njg3cmFEZkxIL1dDMGJyMlJXcDJ1VlJkajZMQUpMUmdpbHhNYWswcW5adUJS?=
 =?utf-8?B?UE53akE5cE9TT0tyL3Z3bndxTGNmNEw5N1FBUkQxRmRPSFdKbklHL1pDMjlN?=
 =?utf-8?B?U1J4MytERFAyd0hxYnBWbng4a1BFYjc0WkxxQ2xTcGFVQ0Fyejg4ZFFOYy9s?=
 =?utf-8?B?ZGxOVlZoQ0M4M3lIWUR6aCs4TUZ5WHhzQXc0M1k4aUs1b0djNVlsck9GSnpY?=
 =?utf-8?B?RXBNK2FRTDRNait6NXFnK3VOc3dMM052VGpTaU4zUHVaNkNIYis5cnpiV3JN?=
 =?utf-8?B?dkJzc1BjekdUcnZqWFZRdCs3L21uYmRDSmhUM1MwZzd6YjZoNlJwUFN1Z2ZK?=
 =?utf-8?B?Y3dLQUhWaVNTNzFBMHdtU3IrdVhMS05JdkhxVzErYzRHZWxVVVlDYTh6U0ZO?=
 =?utf-8?B?M01DZ0xiVUc5cDVqSTZtR09MQWFEblU0OUxhSGRLdEJ0NjNLSm5ZYmF0N3Yy?=
 =?utf-8?B?MFNOektPVkszeFVaUWgzWUs1U3JmZGtITU8xU3BFTTNyZTV1d05vc1RXaHYz?=
 =?utf-8?B?OGdyTjdrY21oY3p6d0MrMWFoMnFlWkswN2xhb1dxL0psMmMxL3gxckRyVVli?=
 =?utf-8?B?WmFmUmRTTGk0VkdoUmZtcXVyTUxVZFZPMGJxRW9Ta1lXanlHWk9OZ1FoVEtq?=
 =?utf-8?B?c2ltcit6WWVWVlZwenFHZVExbG1LUkd0ZFJOTlZjbm5Wb1RZeUxvbmErVnVC?=
 =?utf-8?B?Tm9VZmxhS3h6bVp6bVRNeFh0R3VVTHFKaGJ5RTlkM1dseVMrZWIySDhkMVNj?=
 =?utf-8?B?ZlUrNjVsbGEvVy9OM25PTmJsOHpYWEREUGpTQ0htRmRFd3lhVnY1dlFBb1hQ?=
 =?utf-8?B?YktvM0dpN3NWQVdMNDR1WGE2ZGFFbTFnVlhINWNPSlpQMm10cWRMaVk4MEZI?=
 =?utf-8?B?RmhXaGZUS1N4ZVk0K01qMVNzTlZRK1VpcjlPcWxhVVBiUHh1blBYeGJJNWJF?=
 =?utf-8?B?YVlITlBjUnUwYStNT0djZGJudXFBaThQeG9mZlFYa0M3YnpveTN4YisrUVRn?=
 =?utf-8?B?NHZ3SkpKK0RxQjFSZU9odG1IUGVDQVlIKzF4TW55L000c1dKaEZ0K09zN3Iy?=
 =?utf-8?B?OTROYi9OTHhxbGlSbCtEdytTZ0RjZ25ua1NuTk0weGVsTUFseklseGdxSkVy?=
 =?utf-8?B?Y0FmcFM5Tk5uYzBaM1JsaWQrc2xmajZJM01UZUhVVnkvRmRIai9lQzBoRkVK?=
 =?utf-8?B?N0ptVkY4dmlCNmcvVHF6N2xYV3lFSHVmelplUmsyNXJ5R1RZNHBIUjVCQTR5?=
 =?utf-8?B?MW5mbXlrNFpiQmtmWEJReit5MW40U0ExS3AxSlBWUlZSbUpreE5YSEtDSUt6?=
 =?utf-8?B?SG5xZE5jM3haK2JlUkRIY0N5ZU0wYmpicTUzWEJtVVVsd2laaFdERGNSakE5?=
 =?utf-8?B?TWFUclBEaEViS2l6NHB0dlZ1emdIbGU1ZGZIRTlmOWhDcDhwU1RCdzRoWHBt?=
 =?utf-8?Q?AdddnbhkQ/P6NeR/td8orrVC1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5ca1ab-add8-4834-32aa-08dd5aeef0ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 07:34:04.5132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U9D3OvGf5uefU+WI6Z/D4ZpQt+gut/0s7KEroPtQB2O5p6UksM9Qo1nubw/VyEacGQfiM8NUzsT5cp/wzmXCxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8160
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogU2F0dXJkYXks
IE1hcmNoIDEsIDIwMjUgNjoxMSBQTQ0KPiANCj4gT24gMjAyNS8yLzI4IDIzOjE3LCBKYXNvbiBH
dW50aG9ycGUgd3JvdGU6DQo+ID4gT24gV2VkLCBGZWIgMjYsIDIwMjUgYXQgMDM6NDA6MjFBTSAt
MDgwMCwgWWkgTGl1IHdyb3RlOg0KPiA+DQo+ID4+ICtpbnQgX19pb21tdV9hdHRhY2hfZGV2aWNl
X3Bhc2lkKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwNCj4gPj4gKwkJCQlzdHJ1Y3QgZGV2
aWNlICpkZXYsIGlvYXNpZF90IHBhc2lkLA0KPiA+PiArCQkJCXN0cnVjdCBpb21tdV9hdHRhY2hf
aGFuZGxlICpoYW5kbGUpOw0KPiA+PiArDQo+ID4+ICtzdGF0aWMgaW5saW5lIGludCBpb21tdV9h
dHRhY2hfZGV2aWNlX3Bhc2lkKHN0cnVjdCBpb21tdV9kb21haW4NCj4gKmRvbWFpbiwNCj4gPj4g
KwkJCQkJICAgIHN0cnVjdCBkZXZpY2UgKmRldiwgaW9hc2lkX3QgcGFzaWQpDQo+ID4+ICt7DQo+
ID4+ICsJcmV0dXJuIF9faW9tbXVfYXR0YWNoX2RldmljZV9wYXNpZChkb21haW4sIGRldiwgcGFz
aWQsIE5VTEwpOw0KPiA+PiArfQ0KPiA+PiArDQo+ID4+ICtzdGF0aWMgaW5saW5lIGludA0KPiA+
PiAraW9tbXVfYXR0YWNoX2RldmljZV9wYXNpZF9oYW5kbGUoc3RydWN0IGlvbW11X2RvbWFpbiAq
ZG9tYWluLA0KPiA+PiArCQkJCSBzdHJ1Y3QgZGV2aWNlICpkZXYsIGlvYXNpZF90IHBhc2lkLA0K
PiA+PiArCQkJCSBzdHJ1Y3QgaW9tbXVfYXR0YWNoX2hhbmRsZSAqaGFuZGxlKQ0KPiA+PiArew0K
PiA+PiArCXJldHVybiBfX2lvbW11X2F0dGFjaF9kZXZpY2VfcGFzaWQoZG9tYWluLCBkZXYsIHBh
c2lkLCBoYW5kbGUpOw0KPiA+PiArfQ0KPiA+DQo+ID4gSSB0aGluayB0aGlzIGlzIHRoZSByaWdo
dCBwYXR0ZXJuLCB5b3UgbWlnaHQgYWRkIGENCj4gPg0KPiA+IGlmIChXQVJOX09OKCFoYW5kbGUp
KQ0KPiA+ICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPg0KPiA+IEJ1dCBpdCBhbHNvIGlzbid0IHJl
YWxseSBuZWNlc3Nhcnkgc2luY2UgdGhlIEFQSSB3b3JrcyB3aXRoIGEgTlVMTA0KPiA+IGhhbmRs
ZSBqdXN0IGZpbmUuIFdlIGRvbid0IGNoZWNrIGZvciAwIGZsYWdzIGluIHRoZSBhbGxvYyBwYXRo
IGZvcg0KPiA+IGluc3RhbmNlLg0KPiA+DQo+ID4gSG93ZXZlciwgSSBhZ3JlZSB3aXRoIE5pY29s
aW4sIHRoaXMgZG9lc24ndCBzZWVtIHdlbGwganVzdGZpZWQgYXMgSQ0KPiA+IHNlZSBvbmx5IG9u
ZSBjYWxsZXIgdGhhdCBwYXNzZXMgaW4gdGhlIE5VTEwgYW5kIHJlYWxseSB0aGUgb25seSB2YWx1
ZQ0KPiA+IGl0IGJyaW5ncyBpcyB0byBzYXZlIHRoYXQgYm9pbGVycGxhdGUNCj4gDQo+IG5vdCBz
dXJlIGlmIHRoZXJlIHdpbGwgYmUgbW9yZSBzdWNoIGNhbGxlcnMuIEkgdGhpbmsgaWR4ZCBkcml2
ZXIgY2FsbHMNCj4gaXQgYXMgaXQgd2FudHMgdG8gdXNlIERNQSBBUEkgZG9tYWluIHdpdGggcGFz
aWQuDQo+IA0KDQpUaGUgZXhpc3RlbmNlIG9mIHR3byBmbGF2b3JzIG9mIEFQSXMgKHcvbyBoYW5k
bGUgYW5kIHcvIGhhbmRsZSkgZm9yDQpSSUQgY29tZXMgZnJvbSB0aGUgcmVhbGl0eSB0aGF0IG1h
bnkgZHJpdmVycyBhcmUgdXNpbmcgdGhlIG9sZCBBUElzDQpoZW5jZSBpdCBtYWtlcyBzZW5zZSB0
byBpbnRyb2R1Y2UgbmV3IG9uZXMgc3BlY2lmaWMgZm9yIGxpbWl0ZWQgDQp1c2VycyB3aG8gcmVx
dWlyZXMgaGFuZGxlLg0KDQpCdXQgUEFTSUQtb3JpZW50ZWQgQVBJcyBhcmUgcmVsYXRpdmVseSBu
ZXcuIFdlIGRvbid0IG5lY2Vzc2FyaWx5DQpuZWVkIHRvIGNvcHkgdGhlIFJJRCBmbGF2b3JzLg0K
DQpBY3R1YWxseSBldmVuIGFmdGVyIHRoaXMgcGF0Y2ggaXQncyBzdGlsbCBub3Qgb24gcGFyIHdp
dGggdGhlIFJJRCBwYXJ0LA0KZS5nLiBmb3IgcmVwbGFjZSB3ZSBkb24ndCBoYXZlIG9uZSB3L28g
aGFuZGxlLg0KDQpTbyB3ZSBtYXkgZ28gYW5vdGhlciB3YXkgaS5lLiBsZWF2aW5nIHBhc2lkX2F0
dGFjaCgpIGFzIGlzIGFuZCB0aGVuDQptYWtlIHBhc2lkX3JlcGxhY2UoKSBhY2NlcHRpbmcgYSBo
YW5kbGUgcGFyYW1ldGVyIHdoaWNoIGNvdWxkDQpiZSBOVUxMIHRvby4gRG9pbmcgc28gbWFrZSBp
dCBjb25zaXN0ZW50IGJldHdlZW4gYXR0YWNoL3JlcGxhY2UNCmluc3RlYWQgb2YgZGlzYWxsb3dp
bmcgYSBjb3JuZXIgY2FzZSB3aGVyZSBvbmUgY2Fubm90IHJlcGxhY2UgDQpiZXR3ZWVuIGRvbWFp
bnMgYm90aCB3L28gaGFuZGxlIFsxXS4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC81MWViMjhlNy0wNjMxLTQ5NjUtODFjMS1jZjk2MzNlNDYwMTlAaW50ZWwuY29tLw0K
