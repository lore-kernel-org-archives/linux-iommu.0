Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448393209
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 05:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740633060; cv=fail; b=gHib/4XVFSDVwsVTKRE9GsnXcx3dZOKP9xovDGbtxiTnf/vxfnJocdDsLyOH1odgdEK5qQGpIGWw0RKJyj837sXOSTEoqFRkigrApktC7U5YBpvCviJB6EUG6ZEEbEDq9fXITelBOeeY7YqW+Q9qK6wGOiazki3mmClxgfXcDck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740633060; c=relaxed/simple;
	bh=lx9JbJkcUkCFBZW9gwDoO/kAoZIntRZTQcrM5r24wI4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bgTgLUW+/vyW4slqboIi1D2cgddbORdaGj8+s1rSSjk0pBShKlUXcbBDacj8g9t7eMwyWdhBWkeA0HPigu5eWLZABP98YU6pbp3mJXYZ8TM0vtCnAlW60u7YnBoi6y4iT9bzppH5ky+mnZIWifoT7a/UcUyT4uKWuwBxGQSJuXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ldbr202v; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ldbr202v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740633055; x=1772169055;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lx9JbJkcUkCFBZW9gwDoO/kAoZIntRZTQcrM5r24wI4=;
  b=Ldbr202vyu/4rQKPNwwtae9dtYNxtXYqHqxFzN+iGPRFxvsjJCQq60LP
   P5YrYagCraO3j80dWone7QFYnbgZ6oLnh+Ma9HNToxPxiCGTkUh3SoH9g
   FwpFVaYOHRvNjkcUcNQg4z8butFMAVXiDmm2FnBXEnzNHwGletduIvJ9w
   85c91q5HtTEkMP1RB2dENTSWUa9xJrW9Aqx6EGwReEmIkg0wzpRt93kGK
   hLNsznQfZNzIyArkWIuvLrcndGd5oUasXtpJuidvZCe74uWRo8jCiK6W6
   NhRp+h4lfOaPWZ7G0FWaD6wjEzT4rNGgD7RU/G+k1u24Tu+OTeS61xGi1
   A==;
X-CSE-ConnectionGUID: PAkY9ahqQRmqkTzOtGZA3A==
X-CSE-MsgGUID: /BfFnoLuRnSJZK76en8Eeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="40684823"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="40684823"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:10:45 -0800
X-CSE-ConnectionGUID: JDiuFmxETJSfoBgV1x/9fw==
X-CSE-MsgGUID: xYbo1l9eTued4EfPsSIkzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="116710952"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:10:45 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 21:10:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 21:10:44 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 21:10:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5WPM/1C/s8dw6shS3FXd1ztU6hQr0HyddQG6f+KWxkLEGau4a8IXJwP5D3NBRQPTZ1XL3m5j5tsLdYW3C1cHR8LG6yJkG41XNGUzrEOzRNjqZwVdS/KEPt7hmIEBRg5n6JvArfCfhYaqVJNlijgIUBqtdwrSar+AalnNPd4sbuvmIgjgVFaX6Zpj53kFVl7kwz5XjUN/gYHq3k2WXtynzv8BDxnQgzPeGpqCAnOdDu/Z9Apkjq+gm7mf+Q+rOECwCVJAse9JKpWOFVoTQWle1KdTcAfFjt7gtXg3U/v4V6EGtJXnWdSTViy8euHfzjizvfhMloImAj7g5K1anRlUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmFXEz4FG+A5fg+wcGcNlN6ayjANo8DKTbaWtYdXLYM=;
 b=pbKCSVMpnYk7jFjZb/QLtURt4BDrO9LtQt00fo+jJQk7ts+ZI8mformQHZskjdG7q9SjDwv+S60s4RxTrRgBOGDhkrEE8w1tiTYbHmfJlddAnzHRQ2JYmN+rCLr2/CHSTcHvSikswEVR8DB6/8SLYhEdu5IYAAbfrXk/vRrsx7Tu43DGFm5dmj3C0KqNIa3I2gnw4m1tyDP5srXgiNeJobGDf8PdyVN4vRv+TF9VsXZ1BcVovIk2FfY1sBOHllean0nZqjbUiMjhPbuzptsqgrUHeTqbIb1Zo/Vtwjd1GQrM5kNkNRRBBcwNWgDRMDJ+DxiuW83kgdb3htm8b7drTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 05:10:40 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 05:10:40 +0000
Message-ID: <3b65cf74-cb4d-4c60-bb50-509123223710@intel.com>
Date: Thu, 27 Feb 2025 13:16:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/12] iommufd: Enforce PASID-compatible domain for RID
To: Baolu Lu <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jgg@nvidia.com>
CC: <joro@8bytes.org>, <iommu@lists.linux.dev>, <nicolinc@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-8-yi.l.liu@intel.com>
 <428e2657-6427-4aca-8e33-9d87dd9554c2@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <428e2657-6427-4aca-8e33-9d87dd9554c2@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM6PR11MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f74a7ad-bc27-4462-570e-08dd56ed1428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFE2eHRQb3ZnaUNGUTRyVGd2aVJwaXhNYzhxWFhpZzFxWXZNUmdSUTdVRlVH?=
 =?utf-8?B?a2lFVG96dnpwQ0RRMWZxNDY0UEhKT1hlK0dVeGc3MVFJN1c5bDlkdS9VSFlG?=
 =?utf-8?B?WTF2L0V3U0UxSnZmQllUMk1USWVtK1g3UnJmdlJDNjFFWUM5ODlkMFlBMzA1?=
 =?utf-8?B?NG5FN0sxZ2FBdW0vV3ZvejBucHZIMEFhcVFCZVBqVUNGb1dzWUd0OW13RUhs?=
 =?utf-8?B?bktjU2F5NVJzWGszbVlPUW9iZG5ZRHBUNmtEVDMveTdlOUhUY2RsT3B2WE9y?=
 =?utf-8?B?aTIveXRzdWNneDVBVGYvRDRNa0daRkRGb2xmaDgwN0kvR1VIcjk0cHprTlJG?=
 =?utf-8?B?ZTE5QXF3NGtLbFZCUWpKbVpKU1lwRUFhMjl4Sy8ya3hTWmhURVByNnVXVjBO?=
 =?utf-8?B?RHJiN25XRTF0eThSekVPOUJpVi9scUFTa1RkZzFja1hRZXEvSWZ1MDhmbVl0?=
 =?utf-8?B?WHlud0JkVm9KWFlxdHNyeUNSaGVqWkcraDhqN056dDhkMm0xTS8yVytoNTFv?=
 =?utf-8?B?R2tUeE12YjJEU0gxcHhxaEJmODhmelBJY1g1YmFVVkJKbURDcWFPVk1jQ0VP?=
 =?utf-8?B?Ym1WbWJrVy90TjRxSGVOZXU1UWR5V25IWmcvd1ovTlhpRXozdThHVTltdHky?=
 =?utf-8?B?Y0U1d25SSDYyc25YRmJxRVd1K3hkVWhpRjdDWFBFZ0RTT0swV29IUWdhQjVC?=
 =?utf-8?B?ODJ3Rk9Yb0NMcDRpOFhodGx5c0RqTEg0S3pPeUVkZHZVUlNXaUFleEZVaTVz?=
 =?utf-8?B?WncrZElySlV2YlQ4WEhacURzWG13NVUzMDMwQUNKTHZmc0cxOTZoTHdmMkpD?=
 =?utf-8?B?YXNvcDhaTy9RaE9MZ0p4cWxrQ0tVMlV0QXhtbDhZQ1FjdUlUYm5zQUNXd1V3?=
 =?utf-8?B?SDEvdnl0a0NsODBOb1dRQkVpSXcwMHFtb3hHQXJocjJha0Vjc1EvOWNiTzJj?=
 =?utf-8?B?cjk3MHlPZ3FCTG5rV3NvTEJZMGxJVDgzY1RmU3ByUUE2N3IzUUxTcHBjSDFk?=
 =?utf-8?B?YS9UbnIvenFZanJEcDNYQWJZNVBZQTE3TFJaWkUwYzZ1ckRuUSs2OGIvcm41?=
 =?utf-8?B?RUxETGxIREJIQm93M2d0VGlNZmI2bmFRdVZ4WmRTZjJuL05CVzBCZi9iZXlk?=
 =?utf-8?B?cW1qTld0Rm9oYmZkZysyTENsWDczWmtGSFprS3U1cUcvUEtoU0dMVTNybDNt?=
 =?utf-8?B?L3lhU1hiczhnbGdjeTBTbnovS0VFeHJ0S1B2cTJGK0s1ZEoxdWJMdFErQXhD?=
 =?utf-8?B?cXhwZHc3ZUEva3BHWjlrcS9LQ2dPNHpScWowS3pQUDdtZk5LNitpbmdtNEJG?=
 =?utf-8?B?M2txZG41MCtPR1dEQm13UFQzR25vaXgzN3JVMitTOTVscFFiU21XODhUSFgr?=
 =?utf-8?B?Qm9GT3QzVWJzR0lZL25KM0pvekJncVNnWWFxTkF4NCtjREdNL25hR2FUSXMr?=
 =?utf-8?B?MFg3SjNCTEdwS0VBNTR1RTZHNG9IdkUwTXlrWUhZOWdSOGhYU01SazVVY0oy?=
 =?utf-8?B?QzRkRExCc0NYT2V4N0NUZW8rc0lzcDEzWk5naVl0eDBvYWNlRTNrd2lUM1Bq?=
 =?utf-8?B?RDNnY2pTL3l3SDVNOTZlYTdSblpOZUpJQktZSXFMZUV2S3hwYVNMVUdvbGhG?=
 =?utf-8?B?M1IyTDhZQXhxWlVDcEFweWNtcmJoNU9ZcmdrODdHeWZSVmt5QndrYUpicGlD?=
 =?utf-8?B?ekducEJCNkdiTXgvWU1zLzJua0g4Sm96NXFTN1FyZ3dXbHArS0tEQTY0Vzdx?=
 =?utf-8?B?TUZMYWVMNUxQcCttN1o2VjlLb1BTUzdOM09hQU1OL3FDcWF3YXpTSkh3R1hK?=
 =?utf-8?B?NkU1ZWNoLzIvL051dnVUZG1ib3FGSThhb0p0WThaYVlYbHljVFBEaU5tdXJt?=
 =?utf-8?Q?PxQbsxbnhBA2n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzI0YmMyM0xnVWx3TFZRNDNJenVLY3FZdUxiSUsrQ3ptd3BFaUQ3enpaSmRk?=
 =?utf-8?B?NFpYY3NHQ003a1BUM2xVRE93OWx4UWVRajlXems0bVhEUDVHV2NJeDNsK2pV?=
 =?utf-8?B?Q0prZTRMYkQrSmUxRlRVK2dzUTl1a1grQjI1eTltejVuMXl1OTR4RjVBeGNB?=
 =?utf-8?B?VXovOUlCUkJYbm9leDB1OE80RkJPNjJPQ2FyZTExYWpIUEUvcUtaYU5MNWJJ?=
 =?utf-8?B?N081bXZtSnlOV05KNHd6VEp1TEdrQ0lHQ2F0cStxdVFhS0JMRzlRYmR5Nng1?=
 =?utf-8?B?cWtmaU1GVERrS2JKLzFoTmlmdlUyb25VVG9PaUU0WTBkLzhMalYzN2w1Y2tz?=
 =?utf-8?B?OG5ZTGUzeHE3aVJCMmZMTTBMQStHeGI0UFV6Y2V6QmJ4cloyQWNMVXFZRnU3?=
 =?utf-8?B?ODRvdktqbXdpbTc3N2tmczNJTDAyKzFrNGtaZTZ3cXBBT05TWnIvREsrbmNw?=
 =?utf-8?B?MHFsQlF3MUUrVzRiekNWS0t2VnAwRHlPSERZRE1ZOVpGQWpDaWRvd0dBZjVO?=
 =?utf-8?B?RllsY3NxZ3c0L1pieVlrWFlrcGxzaThReStqZUVIUmNId0VCaDNHbDcwajVV?=
 =?utf-8?B?NVNRczlWeFppMVFKTklUajM0NlMreWE0bFBET3RTODFPRDJ6QWtrR3hWbjNz?=
 =?utf-8?B?WmtkaXIwUXBFN1UzZTRsRm5mZEkwdy9DbldGazR4YTU3cTFiN1NONmFGY3Q3?=
 =?utf-8?B?RFJMOWQ5Znp1MzNCeEJFUDNZLzJlU3NHTWhGU3dNNnpMUnEzY0duTjIwaDVS?=
 =?utf-8?B?ZEtRZHJpMVBvRXhWMkhWS09FcGovZUJNcjlKckhnZUQ5aksrclJWL1c2UC9L?=
 =?utf-8?B?QW0wM1hPbkozUklNZExhc09DdXZVdTFkNFJBMlJtUFh6L09IbENvbnVIeHRU?=
 =?utf-8?B?aVZGcG9ubEVZTnl5czFNbGxYVkRTem5YbUxMcmwydHBwRlpYREVCa3kzM21u?=
 =?utf-8?B?Q0w3d0dZNndvN1l2ak0yUDNENXh1UDhIdEM2N2krcHJ4OVBTUjlzY1dRUU10?=
 =?utf-8?B?VXB2MzJ6NjZ3Z29GNlJLOVRPRnFFMUI0U1lIS3FaaGxNeFhWY1pRdGJGVlhV?=
 =?utf-8?B?a1hqbXg1K25wU0ZkRkFSQ1VSa3lld0ZRa1ZPL3VCQTltNzl4ODNzdVN5OWov?=
 =?utf-8?B?V0pmc3JPR0JlRzFRbHJudnRlY1lweWF0K0U3Vnhpa2JpM2h5Rm8wQWpHSXVj?=
 =?utf-8?B?dzg0QloxVVQzWkViaStwYTFHZEZlTHg0MGdRcVMrWHB6aml4dXVTaGdwd1ZZ?=
 =?utf-8?B?UitkdXpVQkFkRFRMZmMvRGRCeDNDYUZlYnRCa0x3OVc2UU5ZUlpOWUlIN2VB?=
 =?utf-8?B?bE9PdXVFMkkzYXRaUGI3VlpMTVFBSkVYb044dEhXeCtOYk53azZUNTI2V25G?=
 =?utf-8?B?bjlxdGwxd3F5dzZ2bW5iQU52K29EbGUxV2kvWHA5bGlGWUoyVUROelRvRmE1?=
 =?utf-8?B?QUlucjQwK2taaGpSanAyTjBsRFI5ZXpkWHRGb2RXd2tCbU93VFpUS0NZd2J1?=
 =?utf-8?B?aXNmY0lia2E4alpnMDJodUdHSm1lRnQwd1lLQ2o4TU1YNkNlMDFXckFFTUxz?=
 =?utf-8?B?UlJuTHp5VnBEd05OSHBHRnZrNHBJWWVEMVJrU3lQTVhWUHV3anJZdnk3Tlov?=
 =?utf-8?B?VGxlb1JxelBYOXdHQ1VPYTd3Rk1wcmlOVk96aGdIUDdnZnpDSUxwSTFQTWVw?=
 =?utf-8?B?L1E4bC9lSmJnanI0Nm5Bak9mNE92bE44OHRrK0JleC9qR1dpQTF4UDJVeTh3?=
 =?utf-8?B?bEZzTUNSSjEzWFF1RjNib21VWUlFT3NPRVp0S1RvM1VZalN6TGJSc0VMSjlB?=
 =?utf-8?B?K01BTnJWYUZNQ2FGQk96S1Q2cnNlV01vc3ZydGl4YlMzeHFxdXczZEh0M3Ra?=
 =?utf-8?B?cU5jNjMyWDhjUE9uTmRab1Y2d0xwUXhqMDB1c0twd1RHaGllamg1L0s1U1E3?=
 =?utf-8?B?TWYrWkFETklaMWhMajhiRUtIWWlmVDFaRm9XOXZHU1dnUkNPdFJrZ0lOME4v?=
 =?utf-8?B?ZjhMbUp5ZjlaanRtOTJ5SlhaVkJ0cmZRN1p6SkRtL1pQSURGdVJnYTRxWjk5?=
 =?utf-8?B?cWJzSjNtR2c2MG9nbU9nNjFFdnpVRkorNUxveUFMVGlxSm9JYm1lZ0NoZGlZ?=
 =?utf-8?Q?Hyxpq1bpcotPtHujFmNSQuFFq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f74a7ad-bc27-4462-570e-08dd56ed1428
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 05:10:40.5684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27ww4UKpf8QpDuRKWHxsPliFItxIFjHNz6QSonGTWM9OR46RUHnqLxbUqi1+NjWwenopSzosPq8SgMdOa2gn3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4545
X-OriginatorOrg: intel.com

On 2025/2/27 11:43, Baolu Lu wrote:
> On 2/26/25 19:40, Yi Liu wrote:
>> Per the definition of IOMMU_HWPT_ALLOC_PASID, iommufd needs to enforce
>> the RID to use PASID-compatible domain if PASID has been attached, and
>> vice versa. The PASID path has already enforced it. This adds the
>> enforcement in the RID path.
>>
>> This enforcement requires a lock across the RID and PASID attach path,
>> the idev->igroup->lock is used as both the RID and the PASID path holds
>> it.
>>
>> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/iommufd/device.c | 28 ++++++++++++++++++++++------
>>   1 file changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
>> index 30dd2f79491a..e0f097b04467 100644
>> --- a/drivers/iommu/iommufd/device.c
>> +++ b/drivers/iommu/iommufd/device.c
>> @@ -357,6 +357,22 @@ iommufd_device_attach_reserved_iova(struct 
>> iommufd_device *idev,
>>   /* The device attach/detach/replace helpers for attach_handle */
>> +static int iommufd_hwpt_pasid_compat(struct iommufd_hw_pagetable *hwpt,
>> +                     struct iommufd_device *idev,
>> +                     ioasid_t pasid)
>> +{
>> +    lockdep_assert_held(&idev->igroup->lock);
>> +
>> +    if (pasid == IOMMU_NO_PASID &&
>> +        !xa_empty(&idev->pasid_hwpts) && !hwpt->pasid_compat)
>> +        return -EINVAL;
>> +
>> +    if (pasid != IOMMU_NO_PASID &&
>> +        (!idev->igroup->hwpt->pasid_compat || !hwpt->pasid_compat))
>> +        return -EINVAL;
>> +    return 0;
>> +}
> 
> I'm not following this. Patch 05/12, which introduced the concept of
> PASID-compatible domain, states, "AMD IOMMU requires attaching PASID-
> compatible domains to PASID-capable devices." My understanding was that
> if PASID is enabled on a device, the RID or PASID of that device should
> only be configured with PASID-compatible domains.

that word may need a bit refine. If we do fail the attachment if the pasid
is enabled, the old userspace that does not aware of this enforcement but
do not use pasid will be failed. Such old userspaces do not use pasid at
all, so they shall still be workable. And it is allowed. Let me enhance
that commit message in patch 05.

> However, the logic here differs. It seems that even if a device is
> PASID-capable, it's allowed to attach a non-PASID-compatible domain to
> the RID, if no domain is currently attached to the device's PASID. This
> doesn't seem like a generic property.

this shall be allowed. The key point is if pasid is ever used or going to
be used, the rid path should have been or should been attached to pasid
compat domain.

-- 
Regards,
Yi Liu
