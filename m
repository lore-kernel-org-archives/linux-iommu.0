Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA1346FA7
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 03:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779333597; cv=fail; b=VVAysyJEuXusG1Vr87XFhzdwxjoCdrVAEuqKFLoFYrxnop3dgiq6TPztQ7rlZYvOShLUb6dA4siGHxYbAxcSPKdTgCmctYIIrwlWVFLpFDpFgnGENGJxQON5KwcQ5yZd0yA4xQjgmiFZm2YoTjP00IoVil+29bdPXVRu+SFQ7eY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779333597; c=relaxed/simple;
	bh=MHlxbp7rIh5xdd8fi30Z6UcSYXYcZ1wc0oZrXa5rL+k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rSJ4TYels2M0vbUDHBzrf5HSGeb+UkB/VOtrcrKQ6EMaOeeT1zpp3DhhNs0ZIvli7Iz/Pps8Q1xZkDNhjBU2kweIqxhHocC63tOktIRkVqsYlLAEojJAnwgTsmEvGCMr3bDQTJ8YuJDq2GHXXxSRmiMpUcWoWFp49IeGvoY+amo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bVCmODcL; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bVCmODcL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779333595; x=1810869595;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MHlxbp7rIh5xdd8fi30Z6UcSYXYcZ1wc0oZrXa5rL+k=;
  b=bVCmODcLgYwEg54qxcVWxZXwgSo6lphkGgG0Vdp30XX0ZyEA5WrKOKEu
   khAWrCpl+OZMG2sLhYklNmH/NGlNwxqxG68Q8qa3QP/m9zNWtsQ76++Le
   0NEAxuLc7JRdR4+cSRqIyDCzHgyN6jg3+U7ApMUhKeZxtoPIsmIwLIqC3
   i8pz4+D/80nTh/sDrgDnT1bu9GaoKLNvBhD6WLCaMOXyeWDtw92gl2Xvs
   xcM/ytzy4NKqENvh0T9ro+MhV5wretA+Pk2rk+TOiPsANgcG/TJ1lQIMj
   4WCTQkvRuqxWa2918Y+E9PwXSe2jrRon7M4HWEI3Afdf0LlcErVeEev7f
   w==;
X-CSE-ConnectionGUID: 14vjscBkQlGU6YWDMe/s1A==
X-CSE-MsgGUID: VCUPjQI7T4K3abpBJWNTGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="84131663"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="84131663"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 20:19:55 -0700
X-CSE-ConnectionGUID: DzDgRljsTMuCxe/9P7zxYg==
X-CSE-MsgGUID: XO+ejLkUR06SDxP80plqOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="244393765"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 20:19:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 20:19:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 20:19:54 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 20:19:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wd6yLDgZyxDHEZ4obi5CnqzMBh/YoHigMJQ/RMuMTC6XIxN/eKvvRcz+l3/XECbRsYlPIguW0VrhESd2oQUDc9vgAxkCzvfgB/usZ5H/Cq2mJ/ElP44cf32DKHb3GqAG3hfkS1nmSt9G17/0FxTvFwu84RbTzhdRjZNUaY+eXBMboI2SUMXFtPsFTdWUXQf2yIOpcNYs27cQjb+YlSc91gHQjI/8Iswj8Ot6QdBRFR8XlD/1Vmy7YRu2v3X1iHR5ZvQ6gf5rDGML3TQjpzzvnevzon1Yz0pv9sBjKxX5W3qBb4lARHWxV8+Z5X637XgHtXQAgRHCGjA9XXdLV0cpGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f76VfYE492IcM3lPFG1DlyOuhDZbU4y9hxut4N/jXWo=;
 b=gv8zJz7E2ye24yPXIFjun8xQWVt2EnU1rH8b8Qw4Ap50rZdoslJiHPE7d0CMr9WI4DMwh92kERRlYlx0k8MERn9lLzMIWK77N+Y5FJB3reKPNClTWkMX4M852kEzpHFTCqO2sRHthbdz00Ag0vIPTvgEQD1zK6yZ3yb699uw+5ELZ5hOERo19kdmH0lapQAe1Z4f1dw4JvL4GD1W5r0B7zhyYgaNfKpumKFtldNFBUcCvjOCEhoKlqkDzn88Ur/XyID5wI/Ai0ZoRIdE6wF1lyrXNUW+DJMSYevvbC/7tfG2nZdsHc4JsH+z7JVk7T1xSm515bghjGLaEOvOp07k5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by CY8PR11MB7876.namprd11.prod.outlook.com (2603:10b6:930:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 03:19:46 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0025.022; Thu, 21 May 2026
 03:19:46 +0000
Message-ID: <7d276cc9-8fd7-4d47-af90-82cef79a89c9@intel.com>
Date: Thu, 21 May 2026 11:27:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] iommufd: Allow binding to a noiommu device
To: Jacob Pan <jacob.pan@linux.microsoft.com>
CC: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
	<alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
	<smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
	<robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
	<kevin.tian@intel.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	<skhawaja@google.com>, <pasha.tatashin@soleen.com>, Will Deacon
	<will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
 <20260511184116.3687392-5-jacob.pan@linux.microsoft.com>
 <b9e3a3ef-086c-4284-94ce-8e7fafc22d85@intel.com>
 <20260520085459.000067ac@linux.microsoft.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260520085459.000067ac@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0089.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::29) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|CY8PR11MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a042e3-f6db-4c2b-906e-08deb6e7cecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|42112799006|5023799004|11063799006|4143699003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: vGbuie0IBPUUW37PbQ/nbfasABUfLQZ458Hdy1OtwkjclVloWWC1fU0epkINU4khypUgh/pcGFdzTgSBxLcBayQK74zyUYuulBHX3n88ZiPYxfoXkTRLstplxg62+ysB6xQVn5Hb08ykMO++KA4zP1PkR+3YNEem0yZK2mIElDL3wXGpYoMJJwP8ejH3zm9t+UiDACrkFLIxYQGM+pJ7E5ZNPk11Sss5SauuCV7aVqr3ktIeVUt5vbXxgWR4rhGVMYbBCZ8Dq5FSNIwltcC6sfOSYZLs1+7yKmH4ItfriniHiDo5uDndTXGAUsYefhGe+h6BylSTZRsW5gVFMwfUls+qCeIwtwlZ4euigAxCuhVu2nvOi9uK8B0znem1yApr9bHEeBYLrfB8tWPDC/i4CsIKpI4dHjSJMTR52shor9SBvzU4ZuzFAB8CYTZuFgvSMYMn56++04DZ4hXINRhRGwwZmuvAjZNgirfU/BIb0UY+pbbpLCGNJl9iheqLx1C3LWu4tidkzHrFnAc2FTUoSanxRFaLyxQmPQ/6Q+bCCQ7CxYWOpl/5fgotMZEXTEF7GscJZnAJktprfsa/6wFpTvg+SHF1PvKFDwlL9B/amm+Pg2ojJfN1m688R9vJnIt76qRYcR5k4IddZeLfyZIy1bz8Pn20ZGWSl/hCqnhLdNKHlNIJ+jzhviVWsRBkfw/U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(42112799006)(5023799004)(11063799006)(4143699003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnFEM0hlU3NSQ0hpTkRTQm1nOThUVFFTOW5pVndUcVZGTjV2dDFvdlIvYTQw?=
 =?utf-8?B?bCtHVGFtc0E5QkVnVWlHREx0YXFUSG9nNTNyU2NEQWNYL1FVcmxYZGNtbGdt?=
 =?utf-8?B?SHVhUktBU0RZazF0UkRiZGZDRjN4Umt4UnVUakJJbktBb1A4S00yT3VoNG1D?=
 =?utf-8?B?MTYwenlLb0s0b3AxZlZGT3c1M0ZIWXl1a0wyZ2dGazZNdWV5b1BLOU5vMFZJ?=
 =?utf-8?B?VndCUnF6VmVFc0k4YWxKZ09lSGFTcUtZaldGVHloUkJNbE5lUHRsQWVxSm1m?=
 =?utf-8?B?TllMcDJidEhwcWZyTjJ5M3FmTlE0Y05yUXZBTW1Jb1FrRnBUY3JYYi9iL0Rh?=
 =?utf-8?B?SEVEelQ4SUZ0OHRuWEJJR0ZZMGpRQm9XSzNnOCszNjduMVZRNUtGQmVENUkr?=
 =?utf-8?B?enRHYkpYVG5iYmw1U1JFY0JKU3NINjlzcTVYR2t4cTc1THVUcXJDRXVXRzY1?=
 =?utf-8?B?Tlp6NnphMEJpN2YzU1FTaWFQbUhDMkVLNStkOTJVQkhYNzdIQzlsa3paTkxl?=
 =?utf-8?B?R0loREVONHd6UStvdXZERHZVc2diL3dKMGZzRHJvU0plTXRQU0N1ZDdmOEww?=
 =?utf-8?B?U2xYOHJnZEg4TnpVaXRnNGFvV3J0bTBiS3JkZzdEbDdUdVkzcEY3Z0ZkY08z?=
 =?utf-8?B?clphY1NpUVRIcmRsRWI1WGVteEdIanV0WTdHMng3UFNkKytpWHhnZ0g3T0hU?=
 =?utf-8?B?akVYcCsxYWJOMXlTNGZZQitIL2lxVDFFWFA1NU5SU1ptTEZxckhMMnA4ZUYx?=
 =?utf-8?B?Q0UwK3pLV3lqbkNoLzl2MFY3SjdXOGhDMWxYL0g0Rkt4aGFFSjJpL3E1SU55?=
 =?utf-8?B?WWhQK1pLRzFBOUxTc0xIMTlVNjBFNjQ2MEZuZnRzL0wrV1ozc2l5YVBaRHJF?=
 =?utf-8?B?eERCQXJuK1VlTTVraFVITWpyL3lQWUdwZWovNmh3a2d5bnp4UE5yL0ZYSXBV?=
 =?utf-8?B?amgybTVRc1c5VFlNV0lVWGlmNkd3bVVaQ3ZDUFI5SldQQ1lVMHYraURsNXdn?=
 =?utf-8?B?Tld1UzYvcG5hMVcxVE1MYlRBTWVjVzhVS0p3QjdLSldyQWFkWmZSVFBHYUFt?=
 =?utf-8?B?SHoyV0FOQVU0bWxWSWpqaTZpUWYwZUd5bkl3N3llQmErYnRMRjk1NHBacjJt?=
 =?utf-8?B?YjZ4RTRnUHNXZlBkdVpuV0pDcjhXYnhKaHBkNFlPRi82NmJOeXRZUHhKazA2?=
 =?utf-8?B?Z2Q2SjYwbWtNQm04NWxyd1pmemQvamRHRWdubk1ZS1prWHlXZ2dRZ3ZiMGNk?=
 =?utf-8?B?bW0zNVdybGI0VUpMNGxEZGVqeWtybjh1bDdyVWxFc1FBMGpyK3A2K09IS3ZI?=
 =?utf-8?B?bi9NbmZWSkpLVmFJNjNiY1VZdEhrTFh3U21LTS9XWUtyd3F0eWo5MW5HUWli?=
 =?utf-8?B?TGNaNHY0WmV1aVdhMGZydU1Lb0NFSmp3WlRDUjg1REFsQ3crUHE3anJMYU44?=
 =?utf-8?B?dVNtczgwNzVLYXM3emhvejluK3MzYzYvdDlIVlZ4VnZCRzdXQ0FCM2JORWVU?=
 =?utf-8?B?NUYxVEVzdUZyVXB3SUNVZGIwTUZNMFNNOW1DS3k5WUFqVi9ZRnpXWXRGQWRO?=
 =?utf-8?B?N1ZqM28zUzJFZGFDL0dWdGxHdlRqb1U1dktNTVhabURiK3ZOQmdUZW13TEV3?=
 =?utf-8?B?ZDBwOWdyb2pIOExYWFRnMjVxOTEvZUk3UVZCNGdjbDNqdTZVclFEZFU0LzJx?=
 =?utf-8?B?ZGZRRkQ3TjZEQnZ6N3hwWVVGZ2Yvck1HdU4zR1dHZzhWa205NzdSRG4yems4?=
 =?utf-8?B?ZzFndGRVOHUyMnptek5yZ2NRSHMrbkxENjhlbkxmWFJmd0VibVUyRlVSampZ?=
 =?utf-8?B?cWRFOEhyKy90SFJaOVQxb2d5UzMzdUFxTlRnNmxVQ2svRncwTDJ4Y3IwVXVl?=
 =?utf-8?B?aTN0NUE1Y2l6WXdraVJSa3U1L3pyRWNOUVR0ekI1YkJMVUVNWThmQ3RlVGxp?=
 =?utf-8?B?YnZ0QjRVSnM2dmM2QU82cW05dHBXUkd3aDlkTlpaZERTYnZBa3NRa2JocXJQ?=
 =?utf-8?B?aDZxVUE5eDZSWFNWclZMcEVGNXI0SHJpYmdoZzB1VlJEL0srVEswRXRhU1JQ?=
 =?utf-8?B?SEV2eHhLM2FlR21JZDd3eGZSLzNXcG9jSG9sN0ZjaS9ranNManhWamk4c25D?=
 =?utf-8?B?dENSTTZVd1hvVTZQRWZHUGU0U0d4WWNWM0tnaGZNWFl1MXJtYStzRlNzaWdP?=
 =?utf-8?B?QXY2OVdyVE8yMWdsUVpIZ2hFcXcxdHJINUZBNlp3bm1WdkF2MEUyQUtHazBp?=
 =?utf-8?B?TE95WlQ3VVdKU0ovc1pURWhQaWk0dmJxNzZYS3p4ZEd2S1hvZFRZZ3hwRWt3?=
 =?utf-8?B?TnVNdThXdk5razNoRmp0Y01MZ3JRVWlqZ2x0eDNyQ0VqblpWSG8xQT09?=
X-Exchange-RoutingPolicyChecked: H68Nsnjjm0KmUTDDAJZdqTHi8+VAuJzs7qOhnre73Qj/yM1PlXu63d5ypvD0pQToBW+Lxyebxptxhkw1pMyRhqmWembcCxGivu71/gJ7G8zO5k4+gHizdi/JGV39hXPW7KaCpHQUzc+OxPDOZwxEbtjI3XyvUR1l54UaZpeacZ2NnLKQ5V/Tr5SU5bkS9yd6G1fTPHotfbcOiUQbKiPB48pHx21HW0gAZt7KJgK+l2H+9q8yZ/jeNFfhxv5cv+PCRIznIAzXj/LfX03NDwM7eNM65rA1zL4ggjgyO3AwL6vS1wLzjZPwS3OD6rMlYgEg1Mrho2XGM8+iAQ5y0ozQ0g==
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a042e3-f6db-4c2b-906e-08deb6e7cecf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 03:19:46.0058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSEBUO4AY1QkYTdW0obnR9SVpLdytlCetafXMoeuaqcweAGNutcbwzbJiSpwRu1U/V+M0tiZ8r/TlAwPOxDXxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7876
X-OriginatorOrg: intel.com

On 5/20/26 23:54, Jacob Pan wrote:
> Hi Yi,
> 
> On Wed, 20 May 2026 15:20:06 +0800
> Yi Liu <yi.l.liu@intel.com> wrote:
> 
>> On 5/12/26 02:41, Jacob Pan wrote:
>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>>
>>> Allow iommufd to bind devices without an IOMMU (noiommu mode) by
>>> creating a dummy IOMMU group for such devices and skipping hwpt
>>> operations.
>>>
>>> This enables noiommu devices to operate through the same iommufd
>>> API as IOMMU- capable devices.
>>>
>>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>>> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
>>> ---
>>> v5:
>>>      - simplify logic and rename iommufd_device_is_noiommu (Kevin,
>>> Yi)
>>>      - use a helper iommufd_bind_noiommu instead of open coding
>>> (Kevin)
>>>      - move IOMMU cap check under iommufd_bind_iommu() (Yi)
>>>      - reword comments for partial init (Yi)
>>>      - misc minor clean up
>>> v4:
>>>      - Update the description of the module parameter (Alex)
>>> v3:
>>>      - Consolidate into fewer patches
>>> ---
>>>    drivers/iommu/iommufd/device.c | 148
>>> ++++++++++++++++++++++++--------- 1 file changed, 109
>>> insertions(+), 39 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iommufd/device.c
>>> b/drivers/iommu/iommufd/device.c index d03076fcf3c2..4d75720432cc
>>> 100644 --- a/drivers/iommu/iommufd/device.c
>>> +++ b/drivers/iommu/iommufd/device.c
>>> @@ -23,6 +23,16 @@ struct iommufd_attach {
>>>    	struct xarray device_array;
>>>    };
>>>    
>>> +/*
>>> + * A noiommu device has no IOMMU driver attached regardless of
>>> whether it
>>> + * enters via the cdev path (no iommu_group) or the group path
>>> (fake
>>> + * noiommu iommu_group). In both cases dev->iommu is NULL.
>>
>> Are you trying to identify the case where both group and cdev
>> interfaces coexist? In such a scenario, the group path creates a fake
>> iommu group while the cdev path creates a dummy igroup. Both
>> operations need to be performed, but checking iommu_group might
>> interfere with the cdev noiommu path logic.
>>
>> Is that why you're checking idev->dev->iommu here instead? If so,
>> could you please make this rationale more explicit in the comment?
>>
>> At first glance, the comment is quite confusing. It's unclear why a
>> cdev-path-only helper function needs to reference the group path at
>> all. The last sentence in particular seems to suggest this helper
>> covers both paths, which adds to the confusion.
>>
> Yes, Baolu also commented on this asking why not use
> device_iommu_mapped. I will update the comment as follows:
>   /*
> - * A noiommu device has no IOMMU driver attached regardless of whether
> it
> - * enters via the cdev path (no iommu_group) or the group path (fake
> - * noiommu iommu_group). In both cases dev->iommu is NULL.
> + * Detect a noiommu device for the cdev path. We check dev->iommu
> rather than
> + * using device_iommu_mapped() (which checks dev->iommu_group) because
> when
> + * both group and cdev interfaces coexist, the group path assigns a
> fake
> + * noiommu iommu_group to the device. That would cause
> device_iommu_mapped()
> + * to return true and hide the noiommu case from the cdev path.
> dev->iommu is
> + * reliably NULL when no IOMMU driver is managing the device.
>    */
>   static bool iommufd_device_is_noiommu(struct iommufd_device *idev)
>   {
>

this is clear to me now. I was just confused by the comment. And then
realized what you really mean.
