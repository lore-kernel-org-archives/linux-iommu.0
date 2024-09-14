Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950142564
	for <iommu@lists.linux.dev>; Sat, 14 Sep 2024 00:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726274925; cv=fail; b=RsRNCnbSZBbpFl5N3ua4Oy/TTskNzPdDG3Kml1jTWlJdK5VL+cUGHuvvoAyC0qSnHlHvOs4OXwJvUHUKTmB94MC0+Y3MqfvyYLo3eIczA6QwEDh8qLyYMiyzI9aOqP6ptwV8ph9WtL4KMu40fX6F/ogZU/VowiFr/xd+nJuPNjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726274925; c=relaxed/simple;
	bh=ZfdBWyap0d2ItAeo2Z/NLy7va8M6rup3svYr6GGXZks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XQ32dUviV+PlDZEjReWE90IZ/ASfktaL2oa5c+9xKUASY04cU2xrI5aNeIP/68gfYt07ZhpCcDpRmU0Fu8wpVggKqXPAyyXePQ8/H2R6+ljULmDkZWxo3p10z9U4mDLNXlNmtm/z20t/sw/gpPP7w0ClQUPYs8rvFGBcRXIikpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFHfDkpq; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFHfDkpq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726274924; x=1757810924;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZfdBWyap0d2ItAeo2Z/NLy7va8M6rup3svYr6GGXZks=;
  b=JFHfDkpqNad+ykm7E5mQxGi2VBQlH+VGb/y0SH2Mt6k76rv6s8lTUOXf
   X9LDp3f5mmgmtopylAJoOVPsRPoQj2cIJCh/wo8CTkN4c5wGX/0Uq6q4B
   8XuLgyzQb8ombn+L37PfNUfV98CiFrFoZpEhPweWzJsZTGUC2DldDRiEt
   S6YzB1xFdy5Tw5FMD9GY9BBHCbkz8PbPJztuL/T9+Y+7gfHC/J0pDrRV4
   ifXb8h3Pjs64uSbjFqlAEOSgNk2E9ASKZmbF25tAKPY14zJ37Z5ip2wmp
   TwiYnwZ2ZN3rg4QT+bZZIF2VtEgOah0s1kziJp4vsT9fFgOufvEporgR3
   A==;
X-CSE-ConnectionGUID: lPp3HJ8PQiGcG0RysCvb7Q==
X-CSE-MsgGUID: XTpH0n6kQhS6w43lQiOqIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="36324860"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="36324860"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 17:48:43 -0700
X-CSE-ConnectionGUID: 5YfOdhBuTFqt8cF1EwAsrA==
X-CSE-MsgGUID: 6hODDHkUQ+aSOnab1d3etg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="99108305"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 17:48:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 17:48:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 17:48:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 17:48:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 17:48:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpHMgCwWYQ+rlVa15iCqdgPQhu4rnZdDCevKPiuT4LbMcCMqeUg2htCm2JrYQqY/Fu3pVbYY4zfMYVPUII11WDsVcKjDvc9lGkl9KMZksVoYs0Yqqr5FdVAdOWadotDHvILLwlGbZsxZIf7NLc2ZRXe6oDmogZnzLufOQfvXv54rhO5WxBR432I9n/V/RtgTgCh87H7k7xkJoJfWeWRPsqhuoZKongX9NgFVTtIXtOVbReVC7ivQ26nmy/YBXpuP04QuZevp/rBP/sJ0F/vxSSeQ31rhAJ9soWoOKjNvE0O+jSVz1hoFXUCTglcdHbRsRp9I6y5fwdItNNZyYXosUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfdBWyap0d2ItAeo2Z/NLy7va8M6rup3svYr6GGXZks=;
 b=HdqAwt3vb4jJB4GTv+JtdlLzppWvwpcmjXpJTYcohSmP2c53ZJQuyBicRgbJv+ZPVX2//sxPwq7ZKtrCXMrvkcPrSHXNRRNhM5ONytjtpulB+feNMH8I7zTPiROLJp1PLJKIrrgJ4JxNEvyunbNr9hIfQVSTspBBiOL492AdswPH6iqRU+DNt7YqyGmLdFkLo/aeVCMHxwmgJED63Q96N7j07dIpb8jomS/YWiRWZD0dJpiTJjQT3/CFCpOg+HDKShjFCzcOYS1vts+6cuyyqki51gDXeolsRW54g4A6vn+SfUpMwzNmL1zW48WRzC5q9hm6H6rtRNXQo22ruVix4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by DM3PR11MB8683.namprd11.prod.outlook.com (2603:10b6:8:1ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Sat, 14 Sep
 2024 00:48:32 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%2]) with mapi id 15.20.7962.018; Sat, 14 Sep 2024
 00:48:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "j.granados@samsung.com" <j.granados@samsung.com>, David Woodhouse
	<dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Klaus Jensen
	<its@irrelevant.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Klaus Jensen
	<k.jensen@samsung.com>
Subject: RE: [PATCH v2 0/5] iommu: Enable user space IOPFs in non-PASID and
 non-svm cases
Thread-Topic: [PATCH v2 0/5] iommu: Enable user space IOPFs in non-PASID and
 non-svm cases
Thread-Index: AQHbBdJ0Agy2Q3e1skGIPwlQ+VX2LbJWc4Ug
Date: Sat, 14 Sep 2024 00:48:31 +0000
Message-ID: <BL1PR11MB5271994848066586A098327F8C662@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
In-Reply-To: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|DM3PR11MB8683:EE_
x-ms-office365-filtering-correlation-id: 3114fc6e-6fe5-493d-fcf1-08dcd456f49e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YzAyL0Y2L21MOWcvNllMcFJzNkFUcnFLNmp6R2orRXFwMklOQWlBS1JhOEpt?=
 =?utf-8?B?WFBzakpienVtOTJacHc0U1NvLy9xakY5OVJ3MzdmRDVVYW9mTFhtTzZPTkVt?=
 =?utf-8?B?MVJhdUNxaEFQTzZHV3Z5YkIzTGVyRGNEdXZodnlxMk9UU2V3L2doZ2FpVUZJ?=
 =?utf-8?B?dFRwbktsM3NxVUFTSSszL2hJRlNRSGhFaXJQVmg5d2g2QkpMTnFLMnNqaVBJ?=
 =?utf-8?B?eFFKTEF4aFhPbExGaW0xUVJDd241QVVTVU1ZaDFCa3NJWWp0SFVHeDdGVmlO?=
 =?utf-8?B?cEZ1Sjd1VE5iTG81MU1XUHQwcXFkNjVjKzVYT3Z6YWNjQnFRNEd5UzVQTlFx?=
 =?utf-8?B?eEpuV0pkeUlLcHpLc2RUbCttYjdHZ013SzhPRVl3NDZScjgyZFpMd2lpY2xy?=
 =?utf-8?B?M2oxT2toVVdQRUthN3Z4WHAvMFBFaFY1eDdiWlVKemxzbHlWY2lxYVJCZ0RM?=
 =?utf-8?B?RExERVV6WUVxNGN5Y3JqZ0loWXIyc3I1SFprYXg5NHBVOTJhVjY1bXhzVXZM?=
 =?utf-8?B?VkI1UWdXNXVUem1HVkdjaWFUdXMyVGRNbC85MjVLNlRCbEFjbHFYNjI1elpt?=
 =?utf-8?B?MTRyTGtSVk9qYlZ2U3MxV25oQzUrcXptUEF0bURiWkJoaGlkVy9nbnBWUTI2?=
 =?utf-8?B?Qkp5V0JOUmlHWktEREtkUmFxWkZJUzNORGRzWXFBQmthOGJrRFJUaS9aT3l4?=
 =?utf-8?B?WnhMdlh6N041OXNKcWVvSlc2a1lydVp2VzBpOVJ2d2VXclVVZVRVYWdQUWt2?=
 =?utf-8?B?c1pOLzlhZHJxZkZxdE4wM0JYQ1pJbDEyakR3MnJSTStWTlJHemhvK0VkNklh?=
 =?utf-8?B?alhKQkRoR0JoOHMwMUFMWktKWTdoZzB6WG1KcElXNmZCMWdZdkphM1RQaUdv?=
 =?utf-8?B?MzA0aC9uajNud2ZvNVlKSVZHaU4vTS9qMGppTlBjRmppekx0NVNoT2hQbjlI?=
 =?utf-8?B?aTc3WjhqZ1NCVXlObGJJeDNNTEI1dnRYTVp2c1Vqem9IWHI1WXo3Q01zMTJV?=
 =?utf-8?B?akpLQUVpQldBaFZ5TnlvOVpsb28xb1pzTCtDbkIvVjF2aGFSL1NlemVzWUtu?=
 =?utf-8?B?THZXRmU2U2daMC9rWTRreDNSQkl6aUxQMEs2VVAwaHR5Qkp5dlV3QjF5UkZX?=
 =?utf-8?B?ZlptaEVIUHQ3b0tNd01CcVhMbVkwcnk2ejhrMmZLMEtTNWhmUmhDdzRrQzNR?=
 =?utf-8?B?eldzWU1SMUk1WWVwQ012dWlGaGxxQUg2eHVMT25sYThsL2l6NEk0Q2tUNU1G?=
 =?utf-8?B?UzMxcEE1ODJlU2ZUV0l0LzJFVkN1SWJHTnY0VmtMMUFPa2p2Rkh3Qyt6ZXJG?=
 =?utf-8?B?MVBGZVdiY2VsS1VjQy9PaUt3d3FnTUhBaDNBYkdQb2JubWhET3ZNb29wbkdG?=
 =?utf-8?B?ai9jOUFHelRyc240WTdEZjlKTTZ1N0JQaTBobmxpTzM5TWw2cDVLYWhodGw5?=
 =?utf-8?B?ZjNIZWVidllhRXRoUnB5enN3QUFrcG85dVdUU1RnT24yUXE1OGZoc1FQQlBM?=
 =?utf-8?B?T01XeEhXeVpjSWdVdEJTV09VQ1JkdzlKSHBxcEt0bXBsYmxsQklxSUJvTjI0?=
 =?utf-8?B?ay90cFRWV0hzMEszQWlTWWxlbXRBQ3lOQ3o0MFdOc2xXb1NENE5VQ3dSRjFz?=
 =?utf-8?B?Nm4zVzlqSEcwcWRTM0Jka2pGVzhOdElxbndIb04wRTRrUi9PbWVsSEUxM29V?=
 =?utf-8?B?Y0Y2SnlzNWYySEJzMzV6NnZkVWh0YitaeDFVOWY3RzMxVmV6eXdCalZSZWFs?=
 =?utf-8?B?MHhlUHVqQTY0c0dPcVJCTlNzRS9EMElTMERjeVhXV1BmRWk4QTd6YU5sdHdv?=
 =?utf-8?B?YldBWWlNamFTd0dqNitjVGNuNjB3akJON3dHcHJyUVh4RlpDaTgrcW9ScGdj?=
 =?utf-8?B?ZXhTbFA4STdQVjMvRVJWSG5vbEd4REVMUXV4SmErT0ltQ1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUZTbHd0YmQ0bkFKK2JKbTF0ZTdQNUhqSXB4dXBMUmJ6NHRDMFgzMEdCWXZn?=
 =?utf-8?B?anpveG1KbXhiMzd0eUFRbk5idlppQlBOYnRUTDQ5MGFuWSsyK3BKcGNHelpk?=
 =?utf-8?B?MzM2RWttaHRwMHBYbkFzMGY1R2Rod1NWVHplRS9oM21xT1Zad1d4Q2t5L2dS?=
 =?utf-8?B?ZnBncVNxaXJ0WGIvZnlIM3d0dUZ2cU1jdHIzZ0VndEZUSE5GS202SkxCZ21l?=
 =?utf-8?B?TWZGTk1iWERNZHhQeWVZVzUvM1JHekE1YmpmM2s0aHJQWlBVclJrRUxTQVR1?=
 =?utf-8?B?OTZ6bXNkWjVCb2VSYkN4SzNzTGhqMGFhdVZSOGF5Ti91bkdwSVlkSkxHYVFh?=
 =?utf-8?B?VDR6amV3S08xeE1JdHNvL2tPZUpHOVNManpEeUFYSjRORllGMXZBcE5jVW9T?=
 =?utf-8?B?d01TcldhTlZ3YTN5RjRlVld5MEIxWDRvRURCNnVvaWZSV1pJYnZHbk1PMjRY?=
 =?utf-8?B?OW41UVRtTHNTak1udzZxUnRBYTdZcDFXSkw5UldISkg0ckZyL0kyZURvODN3?=
 =?utf-8?B?R0crQ3RmTjZEMEthRStsS0lVVitMU1lPTUZkSUtZTGtqVGdGTjZ5VVFCUlBm?=
 =?utf-8?B?SUI5RmR6MDdzdmgwencwWEFvRjR3WHBZVVhwOWpvTzgwQWlDWmwyMzdCOW1o?=
 =?utf-8?B?SHFnT2UxQ3RnazVRZSt4RFo2MFh4Y0tmSWhnOTdFVnhTM08zdVN5cDFiandS?=
 =?utf-8?B?bkNIeE1tU05wL3drNlh0UjFaOHNuTTk2bDJKeHdkRG5uc3JCQ0VIM3lQSGRK?=
 =?utf-8?B?NC9WdVh3ZFVEeXg2OGxsMzIvT21lNXVlRXU4YjhtazY0anoxRkJHdW9RVVVJ?=
 =?utf-8?B?Sk5CSU9HMko2Q1NBTHRoWlRvUVpVNEtjRXpSYTRuRml3RUYrN1M2L2oxaWNH?=
 =?utf-8?B?WmtsMVhDdVgwcHYrV0hWWUs2aFIwb3cxMm9WbllXTkl6ZzhabVJzWjdJb1Jp?=
 =?utf-8?B?aVlhZmE2Tmk1MWlqN2xZeXl4SkdBK2RLdGsycUhmMitLSkk2LzNFUHV1ZzZ3?=
 =?utf-8?B?SmgvUHRLMG5CaWZBVEtwRWtWKzB2WU9lenVYTEd1cTQrTkdQaExlNzd3ZU93?=
 =?utf-8?B?NlV6OXg1TzdOOEk2ZGVhTFNTYko4blZoWFVyem9DUVFTbTJsblRBMXc2WjVJ?=
 =?utf-8?B?bHhUMlhVTDA4bDlmZzNwdWhKVUNMK0dLVEt1bFNGMUs4U0hpbFQrSDd2TDNG?=
 =?utf-8?B?RzNKQ2I5d1FDZUxZcXd2WVE1V3ZuUnV1d3lrLzVoNm9sRFVya0t1c1NQQzFr?=
 =?utf-8?B?NENBQXl3WHQ5VXM1SHJNeUU5Y09nZDN1QkpxQVlCTnVDdWc0Ukh2M01hemFr?=
 =?utf-8?B?MVhKeDVabDVjb1JtV3ZpYWpMUzdwNVlzbXNFRUtXRUtWTGRYS04yYzJ3SDJ6?=
 =?utf-8?B?bER0YzY5QlpuWGZsTUdyT2YxMTJtcDlZRUg4d1VVMkZ2REpObGlJWTB4TEMw?=
 =?utf-8?B?NGFyTkgxTmtMdEY3RUdBbzZVVUVQNW95VXo0dzArN2pHWHFoYzZjeHErNU1W?=
 =?utf-8?B?ckkvV2c1MHorbHBBbkV3Z2MrRngxMzNlUXg5eG1CUGkvR0MwbTJrbG1uSU96?=
 =?utf-8?B?VzZlcHBQSTN1L3VNZmNSUjQ3RkVuOTQ1dmZBNE5QaWFlR1lOYU9CTG9oN2V4?=
 =?utf-8?B?LzJXdWZBWGxvNTJXSEh5am85WHhnMGkzWGFNSHlUZWw5SkM0R2RXcldWcXpO?=
 =?utf-8?B?SjY5QXFIWnFrSlRxeXgrV0hwaWs1aXNZZ21LU250MnRndnB1VVVMVEgxSC9v?=
 =?utf-8?B?VFpBcWRaSTNZSVZtMGtrNGRtRTdIVWlERjhlMnhhRktKaFFXR0U0Ty92Y0ZC?=
 =?utf-8?B?c2ZJTTgxTElTQmxIMVQ4a2RaWkZCdHhQNW1reUEvd2VqOENwYVYwQkY1MTcy?=
 =?utf-8?B?Uklob1lDYVpWZ0w5QURSbnNlZ3B1N0RFQ3ZRcFVrblZKK2RWY3NiVG1vZUxV?=
 =?utf-8?B?Ri9yUEpQcmtLU1hZQnpiNjNaV1g4ZG9QSVo4R01ZdGxQaEE5SExSdldtZTJV?=
 =?utf-8?B?RVVhTy9KVlRwbjlHTTliRStMM21VYkdOV0Z6S3AxYWhlcU1zeFY0ZmI2aE1U?=
 =?utf-8?B?NEZjKzl6MkFTc2NpNDd5TjVHejVmM1d1b2h1Wng4NzJtbnNiNUNtWFdzcUVi?=
 =?utf-8?Q?KVjXe/R0Rgxtu8zr22jnhzypZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3114fc6e-6fe5-493d-fcf1-08dcd456f49e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2024 00:48:31.5508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zw7fhH9nvpZdRjnOjP04MGlray+9DpV3B4wPceZO0vH4XwZnjK2vQ0k4/0hDsVQZElOfHY/alFmzeIc96XHKBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8683
X-OriginatorOrg: intel.com

PiBGcm9tOiBKb2VsIEdyYW5hZG9zIHZpYSBCNCBSZWxheQ0KPiA8ZGV2bnVsbCtqLmdyYW5hZG9z
LnNhbXN1bmcuY29tQGtlcm5lbC5vcmc+DQo+IA0KPiBUaGlzIHNlcmllcyBtYWtlcyB1c2Ugb2Yg
aW9tbXVmZF9od3B0X3JlcGxhY2VfZGV2aWNlIHRvIGV4ZWN1dGUNCj4gbm9uLXBhc2lkL25vbi1z
dm0gdXNlciBzcGFjZSBJT1BGcy4gT3VyIG1haW4gbW90aXZhdGlvbiBpcyB0byBlbmFibGUNCj4g
dXNlci1zcGFjZSBkcml2ZXIgZHJpdmVuIGRldmljZSB2ZXJpZmljYXRpb24gd2l0aG91dCBTVk0v
UEFTSUQuDQoNCmNhbiB5b3UgZWxhYm9yYXRlIHdoeSBJT1BGcyBhcmUgbmVjZXNzYXJ5IHRvIGhl
bHAgdmVyaWZ5IHN1Y2ggdXNhZ2U/DQoNCj4gDQo+IFdoYXQ/DQo+ICAgKiBFbmFibGUgSU8gcGFn
ZSBmYXVsdCBoYW5kbGluZyBpbiB1c2VyIHNwYWNlIGZvciBhIG5vbi1wYXNpZCwgbm9uLXN2bQ0K
PiAgICAgYW5kIG5vbi12aXJ0dWFsaXNlZCB1c2UgY2FzZS4NCj4gICAqIE1vdmUgSU9NTVVfSU9Q
RiBjb25maWd1cmF0aW9uIGZyb20gSU5URUxfSU9NTVVfU1ZNIGludG8NCj4gSU5URUxfSU9NTVUu
DQo+ICAgKiBNb3ZlIGFsbCBwYWdlIHJlcXVlc3QgcXVldWUgcmVsYXRlZCBsb2dpYyB0byBhIG5l
dyAocHJxLmMpIGZpbGUuDQo+ICAgKiBSZW1vdmUgUEFTSUQgY2hlY2tzIGZyb20gUFJRIGV2ZW50
IGhhbmRsaW5nIGFzIHdlbGwgYXMgUFJRDQo+ICAgICBpbml0aWFsaXphdGlvbi4NCj4gICAqIEFs
bG93IGV4ZWN1dGlvbiBvZiBJT01NVV9IV1BUX0FMTE9DIHdpdGggYSB2YWxpZCBmYXVsdCBpZA0K
PiAgICAgKElPTU1VX0hXUFRfRkFVTFRfSURfVkFMSUQpDQo+ICAgKiBJbnNlcnQgYSB6ZXJvIGhh
bmRsZSBpbnRvIHRoZSBQQVNJRCBhcnJheSBpbiBkZXYtPmlvbW11X2dyb3VwIHdoZW4NCj4gICAg
IHJlcGxhY2luZyB0aGUgb2xkIEhXUFQgd2l0aCBhbiBJT1BGIGVuYWJsZWQgSFdQVC4NCg0KdGhl
IGxhc3QgYnVsbGV0IGlzIHN0YWxlIG5vdy4NCg0KYnR3IGEgc2VsZnRlc3QgaXMgZXhwZWN0ZWQg
dG9vLg0K
