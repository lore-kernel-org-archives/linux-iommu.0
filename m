Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C026AF3
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 04:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740371741; cv=fail; b=DPiYgBE6JDzSN11Mi9hhfmBri6hi5Vhb+oJseIINtNAmZ1oqPUeT8MXoUZaPBdRyXXbfX2vUIm0C+etLGxEnR9yCwIzn9XIE83/5y7Qnw/vu6DRcsCXP1Vij6L8jdhBdQSiYFPlDTUPUmkwzjeKK6TYO0cGpSVemsXfXMCyPj5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740371741; c=relaxed/simple;
	bh=NuswmjCeEP6pcN9jDlp5UA7y9BqMcihSRLpY4OkJMHo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=skr7SxkumUl9ExKAqaVbh8asrP7qtNo9ObVAAY9EtW57bg2Y9zj72LTiFq+T2FvhSikRnJ9eu7rLzxmuX50ZLP5IYr148mqoL6rNgxeKdyGoAAgixBSTRu2/SsE2YesIJvP8vg42TUS8ApeBUcxdzrqHun2XzOcIBFSBds8B2J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BAQ9nc+g; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BAQ9nc+g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740371740; x=1771907740;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NuswmjCeEP6pcN9jDlp5UA7y9BqMcihSRLpY4OkJMHo=;
  b=BAQ9nc+gGBHQ8PrsKz6Eg9VTrG0KlbPxXIvaext2gYVDOsqy5R3730YL
   7pqnrNFIoDEaqk4k8ffIJ174PjgTTMuY+noo0CYVWm2JlOO4dBgtoXtG8
   SYtZVP42bWEAf9Zjvk90ixg1Lg3VO7DAnoG1osK5AzHmFubdC/O761P8n
   GetMYxObCALLUUgnRiKxuUZyPBqP040Lw2DpLzFBn2oGwidniDZ39eJkl
   1ZyDBpzW1qR7JehKnlylE5COkPC7tn1nAPOkJIfTSfbq6EGrJRD9BsT01
   1fX9YRzc/Sg4GbL78XiDGKe9oqjy+IedpxJL9SqNiCtQEEpzDHLSvwZTM
   A==;
X-CSE-ConnectionGUID: xuRk6xrERZW+3bZQ6k8yhg==
X-CSE-MsgGUID: 9ujZu9ldTYmJmrV4adRjgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52541888"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52541888"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 20:35:39 -0800
X-CSE-ConnectionGUID: VaSB2Es+TySiYarCRwV1+A==
X-CSE-MsgGUID: lbGf/LVrTF2f3JkQo5Rhxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121211385"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 20:35:38 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 23 Feb 2025 20:35:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 23 Feb 2025 20:35:37 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 23 Feb 2025 20:35:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdWYH1OdCHd//w3AVj61Tv488qPWITkFyaVKKhKufTEoWN3Zck5r4d/O3hIuty012D92/Uzu6a6B+tv1SbUcYTG8N7QBgQeHCDFuiHjCiBLiRbVaIGTnzH1uV4ToojXHAoVkQWrXNBg/hi7rxcirQyo+wmyoeE6+g5YIJNYJw+0agd9NkPzwIDiMAQDO2+vvYcXo3Z8js5VlHCEH9pJI7Hd0q8XhIRFJRxvlrVWlcd+jc822tN3KH1yPtw8xb+IYpeMGqF1/2NBxSPT7A31Pm2rmWvZA0EYp61t0QL4/elHWTZpF0iqEv2qLu9uIqTfEEGkEOVqXpEsCn+3Yp2z+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gl2FQM3a9FYrBa0Sn0BS/IbvvExbIj4RKnbHYO3bwrc=;
 b=K1VJVtwhqPRGLxYasAjU/KlmuLplTwm1sAoD1/w+KsrHgvCoTYOyjraMCc/4pbDsxPGLwB2PbIUgAMZoJnY2Ypg61e8HNZOvPdO2pS3fQRkY33/Njy8Uf2pv2p/eYkikF7Gekroblr1fMfDXGoqAe/JclJU8JEdFm+da1rMO6Eej4vFTOM0kvZ0VtRZeQwWX/7mo4qy9dppYBrHFrE3iH0XLFbUx5Lmgq+vnAqkCUCZXQo2TnlNG3RPFykBCkqg9F8cJSfng9CJd5XjsS/RHvPz+SQYU3MlTzPw30woXk8jZYc+ZL0B6tMMrsdkFoSwnGTncuH1+ld1yMEMdSVBY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ1PR11MB6178.namprd11.prod.outlook.com (2603:10b6:a03:45b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Mon, 24 Feb
 2025 04:35:19 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 04:35:19 +0000
Message-ID: <2a5b8985-6372-46ee-995a-9d8e670a69d1@intel.com>
Date: Mon, 24 Feb 2025 12:40:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] iommu: Drop iommu_group_replace_domain()
To: Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <iommu@lists.linux.dev>, <robin.murphy@arm.com>,
	<nicolinc@nvidia.com>, <will@kernel.org>
References: <20250221143335.49874-1-yi.l.liu@intel.com>
 <20250221143335.49874-3-yi.l.liu@intel.com>
 <0998ec60-9b91-4d81-b45f-1d0a5db02bee@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <0998ec60-9b91-4d81-b45f-1d0a5db02bee@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ1PR11MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f8d80f-e21d-4915-4406-08dd548ca4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFAwRDYveEoyRjBHRmlPWE51TURKS2djcm9xMHJMWThhUHZMMWRLbFg5Rm85?=
 =?utf-8?B?STQrbkZka09UMmk0bXNzVG44S0dqYnFxTHVYTmkxR2M2SVR1UGM0amZmWFV0?=
 =?utf-8?B?bTBqMXFXUW9seGxzTVlsR3FGTEV0VmhwdkNyamlMdzQ5V1JGSlY5cXBvaTVZ?=
 =?utf-8?B?REwza2JMN0FrQmVUdEdmd3o0SUVDNkh4Y2dUU2NYNUZEOFVteml6QnBJb3Ra?=
 =?utf-8?B?N3E1T1k1QmRDZ1lhNmZTbXdNVXBQTHk2R2NxRG9FMUNYQW45MHpGV0czVjN1?=
 =?utf-8?B?WTZMdlJOQ28rVDBrWWxvbVNnWG5JZWU3SGQ5bCtFRjFXamYvNEs4VkVtd3NQ?=
 =?utf-8?B?UUxUL2pmTHNyUDROYmcwWnhSRW9rcDN3WEZ2MUpPbEF2ZytCSGVXY09iV1F2?=
 =?utf-8?B?Si8xVjNWUXhqRDlCMWIzTk1qQWNFL1NQSWZoSGtSa0ZsZ2lUc2UyOWF0UDgy?=
 =?utf-8?B?b1I3ZWg4Z1ZZZlZWcThhMEdUSnlibThkbU8vNHBNbG53ZzRGb2NPWWVxeE5M?=
 =?utf-8?B?c296SkpNNHNvcDBwcUVGQ0N1bWhyYVF3TVBGSkdRVThXSnRIVnBVSUtjcTFm?=
 =?utf-8?B?V1VOd3ltWEdOelM2ZXcxSHFQa3Z2U0psMFlGbmRGWjJKWlBERS9oYXV3S1Zq?=
 =?utf-8?B?UUNJaVlzeDBDRFZFbkxhdzRwUGFGUjRRRG9OUGJYaDFNNFUwa2dBaWdObFFI?=
 =?utf-8?B?WTBYK2h6SnJOZ2Q2T3JCMGhIWVh0enY3eFoyQW1WbmEvQmV1ME1EakQxbXh3?=
 =?utf-8?B?WjBFYUR2RTlMNEY1VnlHS0VoZzNTdmQzQlNVMWJUMTRQYVJrMG9oalk0YXpo?=
 =?utf-8?B?SWZSOHJoRUZmd284SnVCbHU5a3VKZUpFT1ZIZUljMG80N01seUU0ZmpaRGtR?=
 =?utf-8?B?blc1bXpWV2hORXNiM2VNNmpuNlk3cVRuVVJuRHpoVG9jQTN3YkFFR0NLb25D?=
 =?utf-8?B?aERkRUJGS0FFcUhBNktUU1ZhTTZtd0RhL0srUjI5OVhyZ3BZZlF1d0VlWDVT?=
 =?utf-8?B?ZGFick9tdXF6M3g3MlRjL3FHdTc1Rkl3UHBEU2dobS9oSVBOYXBwQzNocXhC?=
 =?utf-8?B?NXV5YkJLT1BLcGVTYzYzR0ZaeTltMDlEK3dmakNZcXNVa0xlbnVwU21DWTkz?=
 =?utf-8?B?d3J4OTlWcGFVQjhoUkd4THEwSFU0M3FZemxwM0hweUdFTXdHL1J2K3MwSHQw?=
 =?utf-8?B?KzJpcjNqTXRsMlBObXVxM2tlbnZuY1JVWGNMNjZGVUtsNVpKYkN0QUlPTE9R?=
 =?utf-8?B?UGVkQlhYYldkS0YvcVR2dXZKSTF3UG9aZGdzWnZHbUtnMnc5R3dTbkh6RWdJ?=
 =?utf-8?B?S0IySFovdEQ2RVVWVEpJbjl4Zm84VWdQUTRzTWVGQWZNVHhDUmVBc2hjamJj?=
 =?utf-8?B?ekJ0RC91ckt0OGNraE8vQkpvalpFUnVMUFh0TUtNQmZxNy9GdTNPbEhMdmhq?=
 =?utf-8?B?Q3VMS2dONHRia1I2cy9YVUxhM0J1VXErM05XMEhhZ3FubHdXbGIwN1NwL2JN?=
 =?utf-8?B?QWdtV2lrTVU5K3I5Mld1bmRSRjFsa0JlOHdwWjk1UFdhZzJTZXU3YUl5TTdD?=
 =?utf-8?B?d2F0S2NZdXh4NjNLMUZyUUtaRzFxMzRBVzU5ZnBOejhwR29QaWUyNEoraHdF?=
 =?utf-8?B?Z3RhNWt6cmV6T0tlR3JWMEl1STVNZDl4SWJKYW5udkF1a1dkQS8xNUFLb1Yw?=
 =?utf-8?B?enJBa24yenorWnNURlVnR2dhTTJ0QlhWeUo3UjVSbTlXYU03d095N1FMazQy?=
 =?utf-8?B?OEcyeStpR2hSWW5ZNS9Pa0lmWUtrZTlmQWgrS2J2LytIRFptTk12d0FEdTYr?=
 =?utf-8?B?bXB5YTBZbHVBOHRGb0dQd0lBQk5aaE5SbHVneWhKSnhvVVdjTHQwYUVhWUJY?=
 =?utf-8?Q?ov0phUI1atj9R?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czNuSWtDUDZUa1lsQm9GOVlzamQ0cWwrb01mK0pTRnZmRmdCcEVzSGcwU21q?=
 =?utf-8?B?YXZNZWN2VnZSc29HMDdJNzNHaXZtM0NiMlpQWkdqQnBvdkYyWCtxRHlFdEsw?=
 =?utf-8?B?K2NlUndXWEt6YTVrenRXYUFsaHNwcW8xL1I1dVF4RzRseWdET0pqa3JORHZE?=
 =?utf-8?B?RUNsZGY2UjlBbjRMazgwU3NsYVBGdFNGbnc1VGYzWTh4YVRTZ3lOSUFLOCta?=
 =?utf-8?B?anI5SWtKQytSalljcGdTdWJVUmRwL0R2c1RqSHFCbmJySWUvOTBxWGR3K2Ns?=
 =?utf-8?B?M2t4SlJPUUc0WDVLdStSSEhxc2hpZFJ0K01JMS9Mdy9lcTU1MWgxdktWV1BB?=
 =?utf-8?B?YTFFaWVNT1RJdzNaTHRLZmZWOGpsR1B2S1REMTlROTFEODFSMjJHVEZDNzJT?=
 =?utf-8?B?dHdNWXpHanZ3Q3BKT3lzR0htYjFUejFrNjNhRVpOb2hOd0FSNmtLTUNGcFBC?=
 =?utf-8?B?RFJrK09iUTkwN2NhNHptUGVuZzFnb0RYcEhDcDZ3V1RXZHd6ZzUwQnB6WFU0?=
 =?utf-8?B?NFlDblRCTkhvMndVRWswNURQNndhSkVySkNnL1hnS0l2UXR6K1RPRi9iSEpF?=
 =?utf-8?B?bm5adzh0b3BwcUdDQ0c0TGw3SHZpOXdzMWpkbWYrK09UTDlJR0gvK0ZLZzZj?=
 =?utf-8?B?NGVjalZkY1N5R0tzaWVMNTBhaWRzQkw1MkpkaUl6UUhnYXYxS3RrcFdXVmVX?=
 =?utf-8?B?REZSVkhvTTZtbDFLbUFHYStZdWx2bll6a2VLVk1MYm1mTDFFbWpIcGhNZW12?=
 =?utf-8?B?aTV2NG9UMENzeGxHSjUyQ0wzajM4ZmtWWHlYT0tQMW9EUVBLaFJxWUI0RDZl?=
 =?utf-8?B?bFZRaVV5RXZYbmdKdVpiL085bDFyY1FzZldCM0NwcGpXc0UwN1RYVVRZbHdD?=
 =?utf-8?B?WVhKVjlwcUNUSmovYWFETXBWekhjVmd2Sm1qbmlXU2FEelVNS0h0ZG5hSita?=
 =?utf-8?B?VDMvWW83L3BBU0VlRmR3TDdJNEdjRll6VzJSSVUzMHh1V014NDhiQkhIeHh2?=
 =?utf-8?B?QlZtSkUvNW10dmVoUCszUVppMjJVWG9hcHVrMTdPc3ZaU1dicXR3NHdqUmsv?=
 =?utf-8?B?bTg1WkdhakpQSXh0QzdMZGcxek53UDVQWDFLdXJ5MUQwaWsxTkhaWnNrV1k2?=
 =?utf-8?B?SGI5YzBuY3d3Mk5kbm4xaXBuOWU5aURvZFpEZ3VxOW1sOE9WNnIrQmVoQkZY?=
 =?utf-8?B?a3VFQkpPdEhnYXNERzN2T2hpamE3TmszUk52YjhTSndSdEo2eFRhNU96YTcx?=
 =?utf-8?B?czlibHN3bVJidVIvcngxdWNFaWk0VEVUaFVkcnBibEltVzk4eU9hWGVGUnht?=
 =?utf-8?B?ZHh0R3hoM0FBQVYxaElJU3pVcW8vVlQvRFhmVVB4dE9raVR3VWJtdkNIdkho?=
 =?utf-8?B?WUpxekViVDJidEViYWt2RVR1QjM3azhKTVAxbHFPVFYvcUJmdXdpLzBjNnMw?=
 =?utf-8?B?Yk5PemkxQ1Vjamd0RENQeE9JdEo3dGtsNkFPNFNPVU8yajhWb0dySkRJUzI3?=
 =?utf-8?B?TzNHMzZYcjV2ZWR3NTJnUGZtNGo3NG1pTTE1YWNKYk5zaXBNb01IUFJ4UDRs?=
 =?utf-8?B?ekd3RUVnbWExKzZMU09TcGxrMENBcElDSys1NXMzVUdCR1lmWnZjNm9HVVBB?=
 =?utf-8?B?Nk9qSllkTUNGZWduOFgrSFlEL3JSZVRLYWhWdlF0VlRNdi9FWGJJZWZPZDhU?=
 =?utf-8?B?MHpDeG9LZG92cFJteTA2cHpHRnZxNHF5TXRUdkZrZXFCS0pmelZZcmVrNWo0?=
 =?utf-8?B?RE1oWjhGL1d0TlZhWmh4SnJqZ2ZhbitaYnhJUG9BVldDeUtsbWJGRmZKS2RB?=
 =?utf-8?B?TWpFOHhLRmtZdGNQOE1JYkFCQU04Q3gxT3JXODhmaXUrSTI2RTAxK1dIcmtu?=
 =?utf-8?B?eXlzbWQvaWRVWnRuTTZVSU81R2U1blF2MTFLbjBwTUE4cm9RTlJ1a3R1SEIz?=
 =?utf-8?B?ZU1Pb2gxeTFiVndESHRLUDdBSi9jZHE0dlQzOW14b2VCeTBwU0cxOWljUU44?=
 =?utf-8?B?NEZkdDdDK0RCdi9VRldValMzREVhcCs3bFlCNjJ2Z25KS1NNY0xsNUp0dDRx?=
 =?utf-8?B?R1JHdlcrM3FxdEhQQjF1b3NqK205U0E4UDFLMnV6WldNM3h3R2E3M1A5T0FC?=
 =?utf-8?Q?3Og5fmoosnR3Q9dXFXb0aoEG2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f8d80f-e21d-4915-4406-08dd548ca4e3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 04:35:19.7890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7vQKGhC9c9rAaDX3NbQr/FHRRdbkjwUPXSYQApwrNyvZ81kbMica2BBB6uDhkvLCkMLynZOQzlwdCY6slpoRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6178
X-OriginatorOrg: intel.com

On 2025/2/23 21:18, Baolu Lu wrote:
> On 2025/2/21 22:33, Yi Liu wrote:
>> iommufd does not use it now, so drop it.
> 
> iommufd still uses iommu_group_replace_domain() in Joerg's tree. This
> could cause compiling issues if this series goes through the iommu tree.

you are right. This series is based on Jason's next tree which has included
Nic's patch that drops the iommu_group_replace_domain. Jason said he will
help to get a branch for Joerg.

https://lore.kernel.org/linux-iommu/20250213150836.GC3754072@nvidia.com/

> $ git grep  iommu_group_replace_domain
> drivers/iommu/iommu-priv.h:int iommu_group_replace_domain(struct 
> iommu_group *group,
> drivers/iommu/iommu.c: * iommu_group_replace_domain - replace the domain 
> that a group is attached to
> drivers/iommu/iommu.c:int iommu_group_replace_domain(struct iommu_group 
> *group,
> drivers/iommu/iommu.c:EXPORT_SYMBOL_NS_GPL(iommu_group_replace_domain, 
> "IOMMUFD_INTERNAL");
> drivers/iommu/iommu.c: * This is a variant of iommu_group_replace_domain(). 
> It allows the caller to
> drivers/iommu/iommufd/iommufd_private.h:        return 
> iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
> 
>> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
>> Reviewed-by: Nicolin Chen<nicolinc@nvidia.com>
>> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
>> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/iommu-priv.h |  3 ---
>>   drivers/iommu/iommu.c      | 35 ++++++-----------------------------
>>   2 files changed, 6 insertions(+), 32 deletions(-)
> 

-- 
Regards,
Yi Liu
