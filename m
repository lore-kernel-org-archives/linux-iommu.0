Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571522066C0
	for <iommu@lists.linux.dev>; Fri, 10 Jan 2025 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494478; cv=fail; b=eGbO/W+xihAmpMAvxNIg4QFemJlfsrghLknDfwDS1ZmiRQwXneCNmw4tVH4Tbxy78w7X2MZtfxgUtupR014MTX2nIAMKq9F0deuaq7LxDsubPXQjADglLwjZzzQ7QlcisTtaX/aXB0/xIS6GAaQQyPqaTWfGDMYjQbKcO5TvAhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494478; c=relaxed/simple;
	bh=+RkFzoaPC6YNfUPDNmGHWasLFDLiZAoRNFwxbH9LzWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GzZS3QgTnlK1qQrMG4r8DaYAyv7zsTxAYghyIHWUQXzwY9l0QxLKa9As9cSsPi7UDrZ+JfYSN6LDznxGo4+nO3eyZI9rEcpavOdRUQJHwJegiPmDu3v83Ft7fw/HBCOzO5cuN2/elCrvr2gcqrsB4sDT7bbIQ4QWKgK9vIkz+mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bcSp371q; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bcSp371q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736494476; x=1768030476;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+RkFzoaPC6YNfUPDNmGHWasLFDLiZAoRNFwxbH9LzWM=;
  b=bcSp371qVmXfWUkstr4AXoxORCadqOakPvrSWWWkq0s2gmfuJcvTtBtz
   xhTBsCJSvcpVNmMGsRoQnyZJ5rHv8A46b14/xugQ2FgDtXt1PdR68e9kM
   F3lrv9ZXThECaROSFxP1ZPgaFLEmyW8ZLGDm75olfCudErqq0xbiyq6p9
   ugMVDejK0FksYeBNu2SIEcShcnqtshSUa+rIG6e7J5cyqwNA/l1lHgpc/
   axShIGINI9QB0xvgJbE0UzcdaO3EINgMDKaWEdPDkFuGW3MWCrGsJo9oN
   cQ51L0Kc7Tuwx4suISe/uYYP2Og639UikBJNvdzyZn8uQhAmxl/SAMPSb
   w==;
X-CSE-ConnectionGUID: EmRNWtK7Q0G3TDAYFMINMg==
X-CSE-MsgGUID: zKalYoltQv6M2kjKvrl1ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36806075"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="36806075"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 23:34:36 -0800
X-CSE-ConnectionGUID: m7AUhT9HTSuwt2ULE5YJ9A==
X-CSE-MsgGUID: +fnmveL9SEWWmix+85Is+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="103712335"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 23:34:35 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 23:34:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 23:34:35 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 23:34:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9jMSKcnHB0nfDApl6GlqdzXjM6vBihGyIQM/agOPHCxTUaauwDjX7tpVKUUSwzT8rQqnHLeOHB7/vTY5PtU252rLQWvNt99e1QDYgr3XUsLbPNIoruZHwTd8qh4O06YND7cUMvzonC42fXq4q5vqU68Lhcr3NlgLzAnDOty6Ws214IPTKS4JjBeM+ZgULuueFrkpJ38RaD7e75ikfB3tr89EWgCo6frc88Q4FNtKe0Oaw59KDToJor2BK1KdwDmP1EsYDOBK1Cgy3x4H1YB907gXsCqjM6cXCA0mDo8dk3wslj+qRKiLcyZoZkiuR/0HFZTudDIFPqP8dO1hTYL3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RkFzoaPC6YNfUPDNmGHWasLFDLiZAoRNFwxbH9LzWM=;
 b=O7o4d4uxITINkjGlhm8D9BA1s4WANEFhooM4LY4AbVlp+F/NX7CpaHq27rJeIV54QA8ebq2BQOrx0WTI1DdVDgnSJKzjHmPvcSdcKJy3eSBInbP57WLZjXhvcOHS7EGNGzietP8yE4e2gf0lWpe4EQoqfzDaddMgsi7ZVn8QaGOAIekv+CA29SgC8P5z4RTSG0WxG7Q2OdgcUFqqv+MhfTpvX2nJ1DUTAIAGoUlHZ8umiCwEPEikgnt+w+Im2X8f1E6bV9dFnf5bO9DbAAUfHi8/8mh/My/zSK07Bzu5/DXGdhzHXU0qBHo7s5p9mF+BCR/cQGK6/dD7dC3e/IIP0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB6621.namprd11.prod.outlook.com (2603:10b6:a03:477::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 07:34:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 07:34:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Thread-Topic: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Thread-Index: AQHbUhnPTImkeHGAuE6mCT9lTVfS6LLzJwYAgBuKsICAALxGgIAAUXEA
Date: Fri, 10 Jan 2025 07:34:05 +0000
Message-ID: <BN9PR11MB5276257158B2BABB90CE4AF78C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
 <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
 <20250109152713.GB5556@nvidia.com>
 <c907f620-6f83-4c01-ad50-cc369763b8cc@linux.intel.com>
In-Reply-To: <c907f620-6f83-4c01-ad50-cc369763b8cc@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB6621:EE_
x-ms-office365-filtering-correlation-id: 8a59832c-7579-41b9-94d3-08dd3149294f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T1pwUjlaU1htbi8yTmZ6amlsU1VDajdCbEt4dHd3ME0rNTFYa0p5ZXNDNnoy?=
 =?utf-8?B?YlNTTFMxY3k1b1hIRXpJUmt2Zlg1VDZta1ZzNngxT1YrNlBzWk92OGMzeWNG?=
 =?utf-8?B?WmIrRXNZR0JIT1psN2xNbFBkUmxVRkVCUm5oaDl6Y2lzM09UMjI2SXBvQmdv?=
 =?utf-8?B?aUN0Qk9XcEFmSnhrRUN5em5YUTB0MkRkM2w3TzMyNUJXbWtLamlDZnRuaW5T?=
 =?utf-8?B?UUNCenVWTmpwODhZU0VJNnNnc2NSemJDMElBUlpTcDJnSXlEQWh4aUdrUUdY?=
 =?utf-8?B?RHZ5NDh4MEVqdlJSbFBUcDl2ZEZkR3NRVlR1QTVvSVVRUDVXTXhZR0xNNXZP?=
 =?utf-8?B?b2tWRnIzU09JcUI1bkhNajVXTEE4N0JGM2JNS3R2MDY5bktjb0g3ZWtqZXVx?=
 =?utf-8?B?bDNBbzNhb1UreCt3b0daUTNwN25pMHdLcVJCV2paRUZKS1hxK25ZblpCZmhX?=
 =?utf-8?B?WENvbkhFaHF3eEdOdXJGempPMWlsNm1iWXlzbTZHTEpKa2MzM3B1ejlQNldC?=
 =?utf-8?B?bDFtRHAwQWM0ZDZFRWhWV2cyNWlTTXUrZERKdUdCYlVNa2I3ajlabTE0YmRF?=
 =?utf-8?B?OUNhWGZFODExWHdmTGdZckxDa01rdE1TYnV6ZDhjSlB4SmRScHlDMUdmRXBk?=
 =?utf-8?B?L0pENDNEK3J1T2Z4TThnUk5vejRENVE0dzdNbU40Y2sza2JEUTV4Tk5ndEJK?=
 =?utf-8?B?MHpPNTFTeXMxTVFzMDVHS25ZWW1lYnQ0TlAyU3NpcVRmZ3VPV3A4NnV6S3Ev?=
 =?utf-8?B?MWx2eEVQRDlEYUwyVWcxRnhISWRubG5wNk1Objg2TjI3UDdLUWZNS0treUFx?=
 =?utf-8?B?U3NSZEpSSlkzNjliUC9uTUtVbk1RcS9KZVVoVER3QjJ1VmZIelBVc0V0eG8x?=
 =?utf-8?B?Vk9TaG8vMFBjUjVYWEVTTVZPUGFIakhpbzlWVDRSTjE3SHR1SFlhV2NLZHZ5?=
 =?utf-8?B?Z1hrVzlWZk1QUFpSSk41RXAzUzZhWnR2cFNPMUZ6SzlsNkg3bzZkT2dneEZs?=
 =?utf-8?B?Z2E4OWt2UUFuWEZnaFJaRmNaUThtN1JWZGN3UWpQYklQMEIzN2JqSnVCMWk0?=
 =?utf-8?B?RHBxTnlnck1XajMyR0g2UTJIckptT3N6R25STmtOZmdEZXFFUXJuKzB1NDU0?=
 =?utf-8?B?U2YzdFhkYjdqaEt3Zmw5WXcwZGw0WnA3bkc5RkYvZk54RWdNazkvcy83dHZl?=
 =?utf-8?B?ai80SFlQY2FQOGIvRUszVm5PNTVIZU13SDFNSFFJUGtCeEVnRjhVTnhQWWFz?=
 =?utf-8?B?NFBiY0NLNzZudTlWelZJQlhHVXRadjZ4RzFqbi9PMVlPN2tmU1l1U2Q4RE5V?=
 =?utf-8?B?RmtELzFzajByaDFtQ0k2Kyt3Y2FGS3k3ckIyb281RlFxTkdYbVByRnRJc3oy?=
 =?utf-8?B?TFNYR2RqNXdrSFcyUjB5b0FFVXUxTC9jQjlZUlhIaGVmdjczc0k1a0hUY3BZ?=
 =?utf-8?B?QUwwLzR2d2RKeEJydnhQeTRxS3BvZnZvdHMyZ0JJQzRPY3lyamxaM2hRNWtC?=
 =?utf-8?B?YlhuRU8rcjUwTWkwTzUxS2pJQXkyM0NRSlZibWE1dzU0TG5hWUpiUEhFWm1R?=
 =?utf-8?B?d3JHK3QwWnc5bTdtNWRoK2kvT3VUQmJwT0FRMVl2Vmw3WDFMMnJxNlVQK1Fu?=
 =?utf-8?B?OVFZaWNBUmFIamY4S0tSTVRhcHUwTkkzU2hTSFFNeGFtTmR3MGxLdkY1WldB?=
 =?utf-8?B?UUc3cnRDZWN4dFVBNDRVN0daNjBsNmo5VmN2R09aKy9MVlk4L0FiZG5KT0Uz?=
 =?utf-8?B?WTlsSDZBMCs0T0VqZ1VCaEJZTGxId2dxMVdBWnNGcDdRTE11dk9IV2M2SGNX?=
 =?utf-8?B?U2Ewb2d1QUtIZlF3bGJiTDhxNmFXcW1UYW5ocTZ5RVg0TjhkZU1BU1VEb2pz?=
 =?utf-8?B?bzFVWHBEbGZ0NGYwdnJNNVI5S2lPM3IvbzJYUDFyOU0wY3RvQlcxN0VEampp?=
 =?utf-8?Q?pX7Qc3Q5ptOjn+KSaTljEnItISXL1JiX?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDFVbkVMMURaNUZKYkFRTFpzSTZuZXdBeDczNzNpWldLZGVaWm1nSmdqVTI1?=
 =?utf-8?B?VXZlK0VqK2ZqSUs1OS83d1VBNWlqSEZIeitzZTV4S1JLY1V4QVlhQ0lzckR3?=
 =?utf-8?B?NXdEdHdSd0hEdjlTZm5XS3YxMVVSRDYzbHFvN3dkNlJJUk1MMThDWVY4R0hK?=
 =?utf-8?B?NUdCUUNiWSttRE9ub1R2QktGRlpGRU5WamFWUll1NFRtcEdwUXF0R1dnNW1Y?=
 =?utf-8?B?TzZFT2IzT0NuZmIwY0d5N1I2aVNEQkh3QzROUU94VDBrZFlVcU53Z29xaVQ2?=
 =?utf-8?B?YndDeHpZOFNKdFY2SzByRXVlQXFORnhPOStYcWEyQy91RE5Rdm5tYXFnelc4?=
 =?utf-8?B?RmxWelp2T0NPdVE4NENPcmlhcnFpaXhvNm84RXNOeE02Y2Q2aDFaQkxWQkVv?=
 =?utf-8?B?eVFwc0kxaE94cW5VbkpvdTJxYy8zTDkrMEdudmlnTE4rRmlOSFpnSFJNUnFN?=
 =?utf-8?B?MTJaSFE1dFBzb2VuT21yR0l6VTVyNkVYTGVoYjVudk83dGdiU0p6TUhCQ3Jl?=
 =?utf-8?B?OXFydUxYS0dXTk1RV3UzY3dWOEN3dld2UjYwRnE1U0M1OGhrR21IbGhwL0pV?=
 =?utf-8?B?amVVUkpQeU1TblJuMnp3blhWUys5RjFUMWZkSkloUW1KKytxZGtXelFZTzh0?=
 =?utf-8?B?M2U0bTZtNW8wL2J4ejNIYkg3UUFxU1ZnVGp2UmYxRmRRVEVWNC9RT29aMk9h?=
 =?utf-8?B?ZDMvTUxXMkFTeGpGSS96V1REc2J4MGJ4TWRQblNRUzRnS09qcEZFV0NwbDBX?=
 =?utf-8?B?UU41WXAvVmFZRTQ1NWtaa3gvdm5vRER2WjcvcjhyVVFpNEZ2UFpNWWlrK2Nj?=
 =?utf-8?B?UFZJOFZQVW43cVRSak00ZjVGUnN5Vm4vY3F0UUNQVllnV3d1b252UWpPWUZw?=
 =?utf-8?B?NzlNd1lMQjlwL1JtQmE5a1Y0RmZ3b2FnSkxsUFM0ekdCRlBBK25pYjlQL2Iw?=
 =?utf-8?B?L2F3TTZ5aXJxcitOcC9kOVRvNkNHWjZobTFTUEh1K2FGdm1QRGJUUGRYalRx?=
 =?utf-8?B?M3JWM0dqOWJRM0VkUVQxTkMzUFFLamZDWHpoOTFEa2hKM3I3YWdOb3RUVHZN?=
 =?utf-8?B?UnF0UjkyVlBnQ1AxOEJHWmVJMVpoNzRwbGhGUStuR2NoTTQ3UFRKbTRvUlRD?=
 =?utf-8?B?cEdMMFZpOFFMSXpuZGMzbUp0S1lCaXo4MHREZHVqSXR4dHE5elIzdCtKbWtJ?=
 =?utf-8?B?TE93SFlESlgrV3QyM2dzcHJ1eVBXaUhxbUJCSnRReFM5anZWSVR3TytJUi9y?=
 =?utf-8?B?RDdOc2hTWnowQWVyaGpBclJjR0ljTzI5UDNFMHlNZlh3dERheGhRbVdkZWFs?=
 =?utf-8?B?VTIrZHhwdU1HVmplUE4vQUNmUzdKVGkwTFhIQ2pablJBOHRyeHIyR0NYb2ti?=
 =?utf-8?B?TElteVZQWHc4MFMvbTkzSEUvQnZZaWVTWjZFa2ZRZjZYbUFTalNQaGdjODFJ?=
 =?utf-8?B?M0VJQ044c0N2RjAvQmxlaHNFeVVVbkliUjFJeS9DYW53NTZKOUNpTklxUS9w?=
 =?utf-8?B?eXBFY3I5UGUwbXo2YWhrM3lOOCtQaWtQWWFEZjdIVTBQL3RPZnZkYzBBcHcw?=
 =?utf-8?B?YzZESzM3RCtmd2xWUDB2c0w1SzErekNDV2JDQXE4TjFJSGJrczRhbGV6VnY5?=
 =?utf-8?B?WXZmRUpkNUd3S2FkOW5oMlRxYjllTS9jUlNpamZEQ3RLamsxMllaclc3WHUz?=
 =?utf-8?B?OVM5TnRVYm15bDZjamVTS1dNbkU2amdSVEYxOEpCVUJ3WU9YdWJUY2x2K09T?=
 =?utf-8?B?aGlqTWgrZC91TktpZHBuTnpBRHNSczU4ZUU2QnVMS1RVYzBVRFVEMHRDd1V3?=
 =?utf-8?B?RXh4RnhqeEUyOC9MNzBpa3ZoQzhMTnlCZ0ZvSUF4dnVsQnNjLzJDdjRuR1M2?=
 =?utf-8?B?Vkh1NG41Ni9xc0NvaUJqck1kYk1pL0xJUEFXejR5RXBJZzhiVElMejR4M2JX?=
 =?utf-8?B?WEZrV05FV2hVZHFEYWVEK3B4d09XOUF6ckRic3BodHY2dUxKeWpnY3NocHNk?=
 =?utf-8?B?UXpvcjB2RFFDTVZOUkExeHdsWUtSbGRabnBRV3p5ZWJocE1DSVFvREZzS1hL?=
 =?utf-8?B?RFE3ZnZSZFhyaXF3NXU2SkRKMmhtVXB1bmNpazdJaVVzRFBBcW5IQ2ZFSFY0?=
 =?utf-8?Q?JkuU0Z6FRngL27uks0XsBaqh6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a59832c-7579-41b9-94d3-08dd3149294f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 07:34:05.1783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5td3XKGuqOlcILxvzuKn5qxTaOCr2Cp/nZLPP4DcnvUW3rh7HmX+1kt5nkvSXKVVZDLwjtVrmKx4HIGm70fLMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6621
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEphbnVhcnkgMTAsIDIwMjUgMTA6NDEgQU0NCj4gDQo+IE9uIDEvOS8yNSAyMzoyNywgSmFz
b24gR3VudGhvcnBlIHdyb3RlOg0KPiA+IE9uIE1vbiwgRGVjIDIzLCAyMDI0IGF0IDEwOjUxOjUw
QU0gKzA4MDAsIEJhb2x1IEx1IHdyb3RlOg0KPiA+Pj4gQEAgLTE5OCw3ICsxOTgsNyBAQCBpbnRl
bF9pb21tdV9kb21haW5fYWxsb2NfbmVzdGVkKHN0cnVjdCBkZXZpY2UNCj4gKmRldiwgc3RydWN0
IGlvbW11X2RvbWFpbiAqcGFyZW50LA0KPiA+Pj4gICAgCXN0cnVjdCBkbWFyX2RvbWFpbiAqZG9t
YWluOw0KPiA+Pj4gICAgCWludCByZXQ7DQo+ID4+PiAtCWlmICghbmVzdGVkX3N1cHBvcnRlZChp
b21tdSkgfHwgZmxhZ3MpDQo+ID4+PiArCWlmICghbmVzdGVkX3N1cHBvcnRlZChpb21tdSkgfHwg
ZmxhZ3MgJg0KPiB+SU9NTVVfSFdQVF9BTExPQ19QQVNJRCkNCj4gPj4+ICAgIAkJcmV0dXJuIEVS
Ul9QVFIoLUVPUE5PVFNVUFApOw0KPiA+Pj4gICAgCS8qIE11c3QgYmUgbmVzdGVkIGRvbWFpbiAq
Lw0KPiA+PiBJdCdzIGJldHRlciB0byBhYm9ydCBhbmQgZmFpbCBhIGRvbWFpbiBhbGxvY2F0aW9u
IHdoZW4NCj4gPj4gSU9NTVVfSFdQVF9BTExPQ19QQVNJRCBpcyBzZXQgYnV0IHRoZSBpb21tdSBs
YWNrcyBwYXNpZCBzdXBwb3J0Pw0KPiA+IFdpdGggbXVsdGktaW5zdGFuY2VzIG9mIGlvbW11cyBp
biB0aGUgc3lzdGVtIHlvdSBzdGlsbCB3YW50IHRvIHN1Y2NlZWQNCj4gPiBjcmVhdGluZyBhIFBB
U0lEIGNhcGFibGUgZG9tYWluIGV2ZW4gb24gaW5zdGFuY2VzIHRoYXQgZG9uJ3Qgc3VwcG9ydA0K
PiA+IFBBU0lEIHNpbmNlIGl0IG1heSBlbmQgdXAgYmVpbmcgdXNlZCBvbiBhbiBvdGhlciBpbnN0
YW5jZXMgdG9vLg0KPiANCj4gT2theSwgc28gdGhpcyBmbGFnIGlzIGp1c3QgYSBoaW50IHRoYXQg
InRoaXMgZG9tYWluIHdpbGwgcHJvYmFibHkgYmUNCj4gYXR0YWNoZWQgdG8gYSBwYXNpZCBvZiBh
IGRldmljZSIsIE5PVCBhIHJlcXVpcmVtZW50IG9mICJ0aGlzIGRvbWFpbg0KPiBuZWNlc3NpdGF0
ZXMgaGFyZHdhcmUgc3VwcG9ydCBmb3IgdGhlIFBBU0lEIGZlYXR1cmUiLg0KPiANCg0KQW5kIG5v
dGUgdGhhdCBwYXNpZCBjYXBhYmlsaXR5IGluIFZULWQganVzdCBkZWNpZGVzIHdoZXRoZXIgdG8g
c2VydmUNCkRNQSByZXF1ZXN0IHdpdGggUEFTSUQuIEl0IGRvZXNuJ3QgY2hhbmdlIHRoZSBmb3Jt
YXQuIEl0J3MgbGVnYWN5DQpNb2RlIHZzLiBzY2FsYWJsZSBtb2RlIGZvciBkZWNpZGluZyB0aGUg
Zm9ybWF0LCB3aGljaCBpcyBhbHdheXMNCnBhc2lkIGNvbXBhdGlibGUgb25jZSBzY2FsYWJsZSBt
b2RlIGlzIHNlbGVjdGVkLg0K
