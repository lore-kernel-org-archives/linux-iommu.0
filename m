Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43E11E49F
	for <iommu@lists.linux.dev>; Sat,  1 Mar 2025 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740823436; cv=fail; b=aL4E23Sj/WMoF2ptIIJPoPN0LiWoJiZvfTLW/A7LmByp9xBsPTdSTAHPvICVppQhMQ9R5VSnbphiEJ5ZoWFPEQQgnACi5alTgzszbUiHx2mT9t29OtBS1wsmGqBjLOkjnl4Jt2NlGRuZMfa3vREcRoTvg9tQL0QKuHdgAqn86Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740823436; c=relaxed/simple;
	bh=ShaXhx4q+DUnvaEWZPob/WGYhDG5titCnmXDmdh2oWg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nFH1bTvi2vLJCvvONCTi8tr85hvXAZ9LueM+ZUWYirsnKLEzvuHDlyfqmUikToKjooYvRx/uxdgWLsjiFVC96lqHhwq0KtRfGy4DJJjgl2kn6tsKOCA+2BqxoMNEDJGChACymOWEFU668YYdkjfprfjau8iX9MKGryqAxdC5Pqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQvx3CRy; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQvx3CRy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740823435; x=1772359435;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ShaXhx4q+DUnvaEWZPob/WGYhDG5titCnmXDmdh2oWg=;
  b=hQvx3CRy5UdTlD6B1nCo0f77YvUZOOvj/EGBWQrED9y35K1SMTJLT4OQ
   mz2ijabFZ/DDzmA5DM65zfOSynvP8BwRjTvAZWiw4nr4prG13q7hg7MLn
   CN52idOHXvGCw8UjYM9qTFfJWstGTuuh+usfmuZZeL8qx+10oA2WXWKOd
   I3C+z7efYQduldZ9S3N3oVbHjOuDMlYK6wc0Ia2OWKKLCX0na6Oc9Rlph
   8GUV71JsljhgNb0qVUESAkg/G3F2rcBkV93yOQEfwmNcKPocLaVqhf2ZF
   e9ow5tuQcxnmLg8uF4icC0e6MC5dzJBnAQbHLBVmhDTD1l9M5mjgbl8vu
   g==;
X-CSE-ConnectionGUID: 5G+9s8SRSv6+OUd73md2Qw==
X-CSE-MsgGUID: cnLHB6dNRfy+HaJ8HT7gyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="67121823"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="67121823"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 02:03:54 -0800
X-CSE-ConnectionGUID: krLQ9tq8TLOrLo1uH5ayDQ==
X-CSE-MsgGUID: 6HMp/NDtRFKFDxeUBuaurw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="122512364"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 02:03:54 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sat, 1 Mar 2025 02:03:53 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sat, 1 Mar 2025 02:03:53 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 1 Mar 2025 02:03:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6HAvz+b3b5b5Uw4iMyMjkdC31HtWYAdfMM9O+aed6X3jIkf+64UT3GurAw+FcJe4pCrgmTncGIqZHWWJwyTFad3CYOK53kk6HliWDU0TKk8SW8PXGhKSNhUy0vrqebcEJ3xVDax/MzoeuqC+uleMdVZrFGocGMLDuw3N4bEQYN2baiVnD5y2H/j3hKuT7d3iE2DwY39i0gEatIZrwL123gzc1fVWYXdx8p+iU3Y/XZrT3J+EkubmjgYOyYY2wjQjFSkLlZBjIYxJxWHRxZqdGR8cFx8ewviRRYhT21GwDQ/PASnhKtcAvuc5s7PhQGmXwBIvScW2VOS9jVRKHIYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AG53oT0bSIxXXLXk4nCCHYT2CMdGiWwXd3w0cVHFWMo=;
 b=N7wK65KwqZTLomngr5AytNFUd0ZB8xEDf3uXNqTrQTbkEa5sTEcpQEavJ/QsnNfaQwM4kgpGuQSxOHUUwNjHp+xJ9nJmIXheemRqYtSZqp7ZPcd5al137vs+B8mo+Bli+7WXorzYFpmfzAapXjl+Li4UBlDFAiQzZzN9hI1E10knNZ1PJ3SGhZ0WcLiRKoAUBEOnB3fZPmogkbWnpklXLtjQrVGfPZPxaNdMjug9kDLpJ1BwpC4KQLz/+Oh3rcivDS36i1p4E/dneXFXwLeoSqNh/xIBD2aRtjVvdmVa+uLqimrtnKWp8oHlRy+WyKWRXTnx1cYZCPVEJxSXOlO+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA2PR11MB5179.namprd11.prod.outlook.com (2603:10b6:806:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sat, 1 Mar
 2025 10:03:50 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.028; Sat, 1 Mar 2025
 10:03:50 +0000
Message-ID: <4c9573a2-f725-4d27-b7f1-0d458be606b5@intel.com>
Date: Sat, 1 Mar 2025 18:09:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/12] iommu: Add iommu_attach_device_pasid_handle()
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, <kevin.tian@intel.com>,
	<joro@8bytes.org>, <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-2-yi.l.liu@intel.com> <Z7+SrQFXdheJQzuK@Asurada-Nvidia>
 <db3df4f2-445a-49e5-9362-70cdaf363420@intel.com>
 <Z8CSKOpsl0eDh9sC@Asurada-Nvidia>
 <b153d62d-1d8b-46e1-a7ab-527073a80368@intel.com>
 <20250228151250.GT39591@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250228151250.GT39591@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA2PR11MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a57f48-07f1-4593-9f14-08dd58a85d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wk9WZTNQc2xkM3JocitWclVZNWNMUi9kUkV1VTZpenZ6em9FNHA5aVUxWkZu?=
 =?utf-8?B?dkxVQm4vVklnc0dWdTZiejh4eGxsNFk5d2N1RUlCWFR5K0c5QWdxMkh5azBa?=
 =?utf-8?B?UER5cWVIZXVWZE93eFZ6S0FJZG92em1VT1lMQldJb0Q2MGZIOGQ2WXQ3eHpn?=
 =?utf-8?B?YXNJYnBhWWdDbVpsakt4emVWa09pdzFYeHVDYlRxZ0pMUkIzRThkbHNMamQ0?=
 =?utf-8?B?RUZJL21oR1haN1dYVVB5dnhjSUxWcng5Z1FROFc4RklGRFoyQ1ZRTlo5QVB0?=
 =?utf-8?B?UkIxLzVPcHJRaVgzYUR4YzJFS3l4WXhtanh4WUJrQWRZb3pjQTdlaUNOdkE5?=
 =?utf-8?B?WU9kOHNrRm1aMTZ0UUllcjMyNm9QcTVLaThtVDdoRmIrRUE1RVVwcmhoZFly?=
 =?utf-8?B?QzU1TVIvTDMwMkxjSDNndTNacDYxbEQ5V0pwRUEyaUZpZkFUZHB1YlE1di9V?=
 =?utf-8?B?Umg3N0JkMStzNTgzVDVUclZYekIrN2dFNDdGL0lxd2FtM0VpZ0NPTGxBemJj?=
 =?utf-8?B?aHJiWjkxQkdmWmtzci82Q0Fhd2tjUnBsOVR6dUllVkRsSU40U1BFSEd3OUZi?=
 =?utf-8?B?NjZVNXh1V05hRXRNMzF1TU0weGp5WDdkbTR4R3psaFE5Z2JWYkxqdmtCcVBo?=
 =?utf-8?B?RDkyMGQxRlgwRWpSZWxuckREUVVydFlMaXYwcGhBNlU0QXpJZVBDeWJ4WVgw?=
 =?utf-8?B?NU1IZkNMdFc3RHFCTmRKdUdaaUFPa1NFR0ZaZ1BKY1pxejRJSWVNbzF0Ui8z?=
 =?utf-8?B?S1B4UXpmbjdtbEZGRFZ0Y01sZFE3eWxxR256SXFCaGVBNnNDTXNlSk1zM3Ju?=
 =?utf-8?B?ZWpTVzRSL29HK0JLMmsvdjBoNitqakVOQ3luVnhvOG9OQTFZQVJ1Wm5SL1Fn?=
 =?utf-8?B?R3JzTkF5U1owSXJPL1ZDMml6bmFHZ2VKZTVZQW9ZK0FuUTljK3BaRG4xR1FT?=
 =?utf-8?B?YkF6SFNPUWwyUmpsZUxMYUJSbnNRNlBGdm1XVHAwNU4yK29ud2MvSG9hN2tk?=
 =?utf-8?B?QVJrQVNmTUNjVlM3SG5CaEp6aElmaHZ5a0tCbzJtdDFWOE53TWowSDFYYlkw?=
 =?utf-8?B?WWJ1YUdGN3dxMVVZa0VQRkZFSmg5Y2hTMVZTVGtUKzNKclBMNElMVnZvei9E?=
 =?utf-8?B?cUpqWjJtbDF5TkxDZno1cHV5OHhweHc4Z0E0Rks5N3laNGF0T1VIS1BrOUth?=
 =?utf-8?B?b1BPNWNiY0tIRExralFTVnhhZkdRbnJNT3YxbmdHeExJV0VaOHhucGJoWVhZ?=
 =?utf-8?B?dWNyMkFJUmJSR1o1NXh0NEEzMGxJNVppRnNqazFtN29EYXdoNTJPZlg3NGNt?=
 =?utf-8?B?bEdNNXJPSTVwL2VXaHZVWVpRSXVOWG51a290TEhpMGduOWlkbXA2UkZMdCtx?=
 =?utf-8?B?WFQ4aFY3cUMwRlBReVFFSDVtZTdrYWsxV0ltNlkyQ3U3ZzhBdnFEZy8ydnhZ?=
 =?utf-8?B?RE5EeURMTkpSUE9CSENxYUxsajhkc2JCcm5KbUtYK2dFSi8veW1tNzhLYW5R?=
 =?utf-8?B?czl3MmZ2NDdma1BJOEx5SDE0Y0N1eXJjWU5qT3pwdFFDcDZMOXhtUHFZRkJs?=
 =?utf-8?B?WjF5c0oxYUxBdDl5OFlJRW5uSVJDVHVSejFvL2JNTDFuQXNONVVpbWFIODZq?=
 =?utf-8?B?dXpENk1WMTU0QWJESHRhK3ZtTzVTR21tbEdWdXNWSFZ5VEhaZ3k3QjZXMUR0?=
 =?utf-8?B?U1NIVG40YUF2bWtpU0NmM1NkNG5HZktnMTc4QnNYeDY2dm05ZmxlTTA0Ky92?=
 =?utf-8?B?UEJ5ZmZhVmdZTHFWMkRMaHYyWFNCZE1ybGRJRXkwZnBvL0V2WGpvMWFOZHlF?=
 =?utf-8?B?SVdDY2NqMm92eG9MdlNXLzFQTkZBMUsrVDBqS1BheWZDcDNhNXM1Mk5EUC93?=
 =?utf-8?Q?sv8pUEZBGzl6o?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEFMT0hLOEs4QzdlMzRVb2xJNUFjakt3Y3VWckRTK0t6QjdsTkE2UlErd0JC?=
 =?utf-8?B?cG93OWlwcDY4dnF6cU80bTM0SDRCM3Y2SUlpOG1rR2E3eHJNMHhZY3ZvTXFO?=
 =?utf-8?B?QVF1SFVjbkF0VVh5NDVjQjZaVmo4b1JOTVhOdWtJTzcwTzN3bjZ2K2R0eWVx?=
 =?utf-8?B?ak0xdjdjKzVjbGtiRXBKWEQxQ3NRS0pGMDhlcFJrekY3TGxsZXVQNUJ2Q2hv?=
 =?utf-8?B?K0dDTCtFSnJlNlRVc0RXcmxtbHZHQnc2bFZYSHc5Y1NsVldjWlY0bStEVGxn?=
 =?utf-8?B?eU9NODBjNXZKWHpIckloOGdDU1RyS1lzTlVINDhCdCtBRExLSDFvbjZrWkp5?=
 =?utf-8?B?eE01L0haWTN6NnBUalcwdUJ2cVJZemljQ3FRTndyUUJqR2VQMnZlQ1hrWk82?=
 =?utf-8?B?TlA5RExuWHFUMUZZc203K3pIcWhkNDNRMW81cDM1azlPdXFLQXJFMkNBL0xN?=
 =?utf-8?B?OEI2b3RYQnNFV2VWWE5UR2J5VHcyd2ZPV1hYS2VEWC9oVm1JUzliK0hvZFMz?=
 =?utf-8?B?WDNyOEVBOWNRcHdmcUErdGhNTnVDS2w1cWh3RGhZdUN0UDhYWVN2cXZKcUVF?=
 =?utf-8?B?WUVCNmt6SUdvUHRXaVRlZFdrZWUxRklhZFh5eDczOUx3Vk01anl2RFBKWThS?=
 =?utf-8?B?WnRyRHYxb0RWd3JsVW4wakNLMnVHL2tsb2F6cExyUzBoL3hqQm8vRVMxWnAy?=
 =?utf-8?B?R2VkSnU3ZHdsYnFhTSt2Z3Z5S2dLM0h5dGU2Z2Q5YWhDa3o4SWJ4SGZZV2Ns?=
 =?utf-8?B?NjFTNGdUNlhnbkVJT3YwQkFucGFMcXVHV2xEd3g0N3pzZTB3R2UyUDRrT2py?=
 =?utf-8?B?RG52MkQ2YW9Vekk2Sm4rWEV0RGJMa2JCb3dmNjhzVUFRNGVQUGN5SGx0NjFZ?=
 =?utf-8?B?YWRDLzBJTURiYllmZEV1WUxJNXdsRU50QlFGbTFwVFhKNFk4UkUzeXNPTm95?=
 =?utf-8?B?ZWR0VGIwemt0MnFRRTUvOEQxTTBIU0FndVpqdzliaUZjUWdXRjJ0a1BMK0N1?=
 =?utf-8?B?YWdxN3IxZ3pWZDRuUnBLWkYyODBod3U4bEtpVG51RVpRREpTZmhaM1VYa053?=
 =?utf-8?B?aEZPZGJOS1ZtekQ3eXFtT296S1o0WEh2b0xINzhpbGNBYXgxQVpwNGh2TlBG?=
 =?utf-8?B?WG9oTmIrSUEveEZ5ejNOaXI5Q1MvWEJtQnUxOGdqM0RzdUFmRnZlSyt6WEVi?=
 =?utf-8?B?MUlkV0xoKy8xTEdjMHBmSkluVzZGZnViandmbE0xYWtZZkY4R1hhQ25ObGE1?=
 =?utf-8?B?bkRMUHZVZkx4MDFKbHlYYW0rbTlBdFBMcU5VU1ozTE1IL2hYR1ZhZm91SHU3?=
 =?utf-8?B?NmtKMExBMWROdlhTaERZVVM4RmV0SE84Sm1XTmE0RW0yTW56Zkt2Q1FtZm1N?=
 =?utf-8?B?RktpSzB6anNLanY4VjVST2JQS012VkQvL2I1TU11cnZWWk85d3EvMjQrSHhI?=
 =?utf-8?B?YWlHTk93TVM1cWtwWXdLaFBtelphMEUvemNzOUUzRGdLVEFSTFlGUkhUdXkx?=
 =?utf-8?B?dVdKcFNhVnRZdEhOVnV2Q0FnR0U3Z0F6dDlIWXVpNHc4Y3BGbE5BL2p3RDds?=
 =?utf-8?B?U1JVTmVPYml2dktDc0x3blY0S0lOSzR3SURhOVNDSEhHKzJlN204bEd4Kzlv?=
 =?utf-8?B?TXF0a2I4RE9BbEduYm1ZeE81cElGOTVDWGZOYXZ2S2U2SitkYWh6RjJVcGc4?=
 =?utf-8?B?MUhIVzllVG1KOGdrZmhBNWtUWjlSNXNVT0dkMDRJaXJXSXNuU0FuQktoRmEx?=
 =?utf-8?B?RUlGQXV2cGRESGlsQ0JRK1NjR1g1OHZYWVRLMzFpbERub0ZSYm1QWm1mT2kv?=
 =?utf-8?B?QUM4SjBaSTE0ZlhnSEh6dmp0WUdUT0RWS0FhWklEWnZuMnZ0NDNjNFdRZ29j?=
 =?utf-8?B?WmF6VG5CS3hHc0lWZjNvUFQ1d0tNNWdpNysxWk9QSzRLYjlwYkhyQzV1bHg4?=
 =?utf-8?B?MElOc0Z4VmJlNnkzbjJyaFVPc0xkR2d2UFRINndZc1pHQWFsbS95NmxjamhY?=
 =?utf-8?B?czJRQUFidnFDL2RneHovWHFrajBzdzVBNUtOOUpheEdsUVY5WStNWkZBRVZk?=
 =?utf-8?B?ZU96YnJwbjZOamhUNS9GTjdIVTczMCtQYU90T0Zac3VLYVpPM0VkNUJhZVBZ?=
 =?utf-8?Q?NQz1CvqiDpE5c5ZvuZ/QeS7qi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a57f48-07f1-4593-9f14-08dd58a85d38
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 10:03:50.1899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7uyVoxiJOWSNizoKjEds0igBjRXx83ucA6/AghJgMogAeyi49IAULD45mYtS86AXmcxf0PIEVfsQuiXXlwJAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5179
X-OriginatorOrg: intel.com

On 2025/2/28 23:12, Jason Gunthorpe wrote:
> On Fri, Feb 28, 2025 at 02:48:22PM +0800, Yi Liu wrote:
>> But you indeed reminds me. It's improper to have the
>> __iommu_attach_device_pasid() in header.
> 
> If you do it would be wrapped in an inline for users.
> 
> Ie you'd have  iommu_attach_device_pasid() &
> iommu_attach_device_pasid_handle() with the !NULL validation just call
> out to __iommu_attach_device_pasid()

oops,. yes. At first, I'd want iommu_attach_device_pasid() call
iommu_attach_device_pasid_handle(). However, it is not possible to add
the !NULL check in iommu_attach_device_pasid_handle(). Although I forget
to add the !NULL check in this version.

> 
>>> So, overall it doesn't feel very necessary to me...
>>>
>>> The iommu_attach_group/iommu_attach_group_handle() case, on the
>>> other hand, does take care of some underlying difference. Thus,
>>> having two separate functions could make things clear.
>>
>> actually, they can share code as well. The below patch actually has started
>> it. Though dropped to not blocking the pasid series.
> 
> Yeah, I think we can get to the point where all domain attach,
> handle/nohandle/pasid/nopasid just calls one function that manipulates
> the xarray. You got pretty close in that series
> 
> The PASID0 special cases can be handled with flags.

yeah, this might be possible.

-- 
Regards,
Yi Liu
