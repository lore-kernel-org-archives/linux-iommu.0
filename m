Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E1619ADB0
	for <iommu@lists.linux.dev>; Tue, 18 Jun 2024 02:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718679042; cv=fail; b=mCvNz48rrdXioDS1OV7Vbk6/5ySnnhJiT7kosAkB/6vC7ZOtmG6swUNWP53SOL59b9VLdmXqXXEuJlXfmx/FuNs+89TwUZU73e6Toa4KQwdkiC+Er1OiHvSGtSiaR59A1nnOds15iOomgLXLPWiC4Zqb1MAy6d4jCJLvKJz1QnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718679042; c=relaxed/simple;
	bh=NpG2GF80g6f2VPSHQ9NVm5vJMrA7TYYmNbmfKGkcoMg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XtI+4AkQCfH3LBuMMsC0iLWjybl8luA5diaPhOIwiyMUU3kI+DRRTOU1UJyhVWA/SsOP49ZfnUYQUqWe7E6Es16NLgPcHaKlJUoJ1c3pM1O0i748kcE6iT0BzkQrt04OLW21xcDc9sV/isNUFGRpIiglAe2GVxzkCj9QFapEZiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3hVI+Rz; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3hVI+Rz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718679040; x=1750215040;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NpG2GF80g6f2VPSHQ9NVm5vJMrA7TYYmNbmfKGkcoMg=;
  b=b3hVI+RzJrnqcyCL5YCYYWcOsQe2exesFc6f17Z+oP0K4kRqtWn3eI5e
   kI1l7B/7tZsCGNvGYYot5hjgVsQ1qB0XsEL4LuS93sh/A8AyxnuWklOJt
   EApiWBb1P4P9o1z6+VbesMUav+dQtSzLfrNqLPpjowHN9/044wDaoUGzb
   vFp85b41bHnGBtOJ3iPB/0xL7RVCjIjTwCl0zKZSQbSsH8v2UJHpS7guc
   FYo2NB2ePwgFutZz1zpg9KDUFub95cXkx55c3keukltIaDkcnlMpVwyz1
   yupEg2lxcmH8v93rbZIIJe9MlvTkxFUuFIMTAQL1NYtqvx2LQDOz3nais
   g==;
X-CSE-ConnectionGUID: cj9uylZLSaezeQtOTESP0g==
X-CSE-MsgGUID: uT3dz/TlRWaWltCOVy+G5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="33068331"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="33068331"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 19:50:39 -0700
X-CSE-ConnectionGUID: HiE4onTWQlWLud+ogX3MIQ==
X-CSE-MsgGUID: hNptdsN3SCK3sWgxcKF4BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="45764786"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 19:50:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 19:50:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 19:50:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 19:50:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 19:50:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yw0dJrhQhi20NLpN+1+aMzyls4tK3nsfodkT4gv81/p63mGi5GHQoV2i4wXuCYgJFLziMgpHkH4jBtSW8KsW9qBn8tkjwUdin8JnKhxZ7InW0TAwgHrbjzUi1LafIzt550/z1EyPik691vHu3wjOjzz7oUFyG9GkToOw7h36H5pBoa74sw1smva4/1jBQAf9KUj6KaN2hzs3fHY3iXgbMsq0Qed2babRHT+012p0vkA2FgnZ04SOvCpN1G73PwTo7tL3Mp5bfO/0aoOW7nN4703qGqWnAENlvCoa1yTN/jtkYFZHcMskTH7HDc0qGGkIwv1RkYLAaASjhw8l/CpM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cS4EwkDfNsJF0jg/vY3GBT1WxObggJQPg8alrF1dLCU=;
 b=Od1U0tAInx62Ow+U12pcPkni2a5C4CLfDdD8RY166ijDMLDAPIeWE5zDbOTLFBayk0ZfQKxc85QJumj8wiKczkWuOuMmADYRukVXF5BopPxxXw9olXoOQpm/ytlXdrwmCmDD6lkrjVWuC9LtPeRbzUzzkPLIGqHZRR8gkoT45ZCn9ItvUU0MAQqq1FR60LJuisNXeY+IWAkPmNVh4wxux0KJGIVjshWdI99jID+LDaBCTILofw38irxX2vt4bWm1UdoWk9TTOZyoXcuB/u9RwUuQfPH18PXL5y7R6a39jx87O76riob8OR3IC/QyTBodpiIWl4Hk5A2NNfFZY7zpsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 02:50:30 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 02:50:30 +0000
Message-ID: <6ef4a71b-34b4-4f63-be18-310c31c89d53@intel.com>
Date: Tue, 18 Jun 2024 10:54:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Handle volatile descriptor status read
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Lu Baolu
	<baolu.lu@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: "Tian, Kevin" <kevin.tian@intel.com>, <sanjay.k.kumar@intel.com>
References: <20240607173817.3914600-1-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240607173817.3914600-1-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0097.apcprd02.prod.outlook.com
 (2603:1096:4:92::13) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CH0PR11MB5300:EE_
X-MS-Office365-Filtering-Correlation-Id: 16af20f3-8cd9-412f-4811-08dc8f416a28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHFsbllUeDlPdG5GUGJnNm5HYWdtNjEvU0s1eVEwODlhT2w3SHBZRm1OU0Fy?=
 =?utf-8?B?dGlzWGlvejNCMERNMmZaaStyTkVwRHI5TnI4aitMbjl0NjlhdHcyZ1dwc2JG?=
 =?utf-8?B?czZ0Sk96SWhVMmhzaTF4cG9hN1Fpc1lsTjV2Qmk1blQ5bUphcFpyT1FyYldz?=
 =?utf-8?B?QnNsZ2k1Z05jemFxeUN5ZXJsRXdtMEt1cEYwKzdDZU95VkN6S3NuNEVKMzVK?=
 =?utf-8?B?L2R5M2NkcEx2ZXFhZ1BPenREbnVZVW4zUWh4L3NHWlJaa3ltbk1keHVCVjhI?=
 =?utf-8?B?aHcweXZicjEzMWZkWlpHb2x3RFJOV3VUV3VrQ0U5RW13eTJqYUxieWJvUE42?=
 =?utf-8?B?VElHSG93cHo5bGxrSmJkMGlCcDlpMWoxZ0FoQzlwcWluVzBWcUg1NWVsQzFQ?=
 =?utf-8?B?dVBsKzNoeFlSQU80aEJPbmRpa2cyc3IxdGFFNmQ3N2NXdlN0RFpNNktRdlF2?=
 =?utf-8?B?NlpSYUNhUlpUeWxjViswRnNZUHBUSzFCSWZlSVJmc09JZS96U2Z3cGRhc2Vt?=
 =?utf-8?B?M1o1clVBVG1lYnkvMW1GbG9QMS9GWTVHSVQvaXpTMEZ4Q1dieHFEVFI0TG4w?=
 =?utf-8?B?a1I5UVhtNjNWNjJoSTU3NEh1WFNydCtsdjE0azNoY25ZWFJYYWFuSzVXb2No?=
 =?utf-8?B?L3ZOYnFJS3d3RkxFSDdzN092Y3lFczRoQ2lhWnBhU2g4VTBVYXkrS2N0Qm16?=
 =?utf-8?B?YmJ6dStPTHFienJKSkk0TlFuWk9qLzlGNDEzQlY3N0lOdHJwUFF1YXJaUllu?=
 =?utf-8?B?Vlg3aHpyby9DZW9CTEo1QU02eTNRZHB2WnBLS1FVcjdDaVRNdEk2andlZDZv?=
 =?utf-8?B?UHRFWFlQK2xaUTd6U29PRjJpV3pDMmlNeDRIbDRtblh1eVpGZlpyZUlVOTV5?=
 =?utf-8?B?cmhhWGhwcThkL3FNck90SzZKLy9FQzZQMEFVSTdaZ1hBbSs3aVJtY2JQVWZF?=
 =?utf-8?B?Q0R2ZzFtTXo0KzRtVXBEaFFtTTZobmV6cjBmYUdLdG9LdDhlR2VqeFlRNHUy?=
 =?utf-8?B?b1MzcjhLcHhDQ1JHQ1hSV2xFUTVOMHM1MDNlcG1jNTUzdnhsWGk3MVl5MWcx?=
 =?utf-8?B?RC84b2NkdnVkMU1ibklMdmYwVVdIMmhrVTVnSmdpM09sdWM4N0hrWW5BV05v?=
 =?utf-8?B?SURLbm8wcjlsNEhzMC9rSGg0eFVZYm9lUndiZlpFbllYdEpPdkxrNk9KWUNF?=
 =?utf-8?B?ZEpZT3lvNDBSMlhqMDU0VmlMdWJRY0s3QmF2ZG1YODhvWkEzWEMzTUNQNHpx?=
 =?utf-8?B?TC90VGtKUHhVVE4rQmoyQzhDUVEyakRQWTBXMEk4aXh0czJsWnZtUE9yRWhZ?=
 =?utf-8?B?VGdZNDI1aFA3ZDNiSnlxR1pRbEQ4UVN4bzRTZ2djd2V5b3JaYTRGc2VvODhZ?=
 =?utf-8?B?U09hMHFaOEs4cnRwYkltdUpZQWJibVNDc0JIS09HQWZjUng2bXFtc0RMeFho?=
 =?utf-8?B?T0VEOTRaQUIxemVDaUpNYStWejNKc3ljbjZzVVcxYzE1RzRpRzg3MEZmMloy?=
 =?utf-8?B?OThlOXFkVU1waUcrYzJaUXBLc3ZYMmp1SGRZdnZiWnlKZFE4cHF4RDVqTFd0?=
 =?utf-8?B?akdTWmQwd1dtVWJ2bGJoSHd2REVOdFl0UzdUMjM4cjltc201UlFKbTdBbmRS?=
 =?utf-8?B?aDdYQ0lQZE45bGVWcHhpcUUwajc4alZrdUlqVTFhd0EzbE9BRnRGejhHMU5V?=
 =?utf-8?B?QzA5M3ZKQ2RQVE41LzNFZVl6NUFzckpMWWhHWlFBdWNLa3VzQ1JKeHBvTk9W?=
 =?utf-8?Q?kPaUwKsktLTPTGSw4RWB+FM8oYbik3i+FX32FCR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTRPcUdGbTM3ME5oQllNQXhRQ0N4ai95M0VPQ0lvOXVzbUQ1eXBkMWlob1VQ?=
 =?utf-8?B?b3R4Q1FGQlV2RDhJSnZ3ZDRVZk1ScWtaakZ1bDdVSEV1cWtPcUU3enU3UDFa?=
 =?utf-8?B?OVkrcXdOVytMeGVlWWpZdkJ0dWRHczZXR3BKMTAwK3A3TG56eDVWNzN3ckor?=
 =?utf-8?B?ejEyOHNLVjF2bkJ3ZmlleVQ2dzltMHk4NjU5Qk5VcVFueFFHMVZHL3NCTWM5?=
 =?utf-8?B?eVFvYitxZjluUkNWTUI2dVl0R3lXMXhsZ0NFZUtBSzBHLzZvZ1RPRzNMd3RS?=
 =?utf-8?B?dEluUHVGNmpxU3p3czRUWVVFclhqeExjRnZyTk8wQTRRRWwvMm9qU216K1dO?=
 =?utf-8?B?M1orZEJaREdWWEJUMldEbnlnZUR3aENraytHdWRjc0xFOEpzcEQ5UWZ6Qmox?=
 =?utf-8?B?Q2VUMFIzS1NxRS93RitMMHZ1dWl3VGJ4cnh4anFPNk5ObzNnVFcvRUtlL2U5?=
 =?utf-8?B?M2pjQzZyMk8yQ0QvamxpaXJWT2ZMZTdkb0lSZ3hiNE83RVljQ2Q1ODFnTHd1?=
 =?utf-8?B?dHQ2R1ZWOFZzNG1wMkNScXRlYXVRYzQyZENGbDhrZXljNW1TdHc0U3k0eVMr?=
 =?utf-8?B?K2NNaERtRnB6TVpUUXBvY2dna0xjaFUwaVR4RE5kN3RnbjJ5SkNwR2w2aG16?=
 =?utf-8?B?dEhXMXpLOVk3UERvaitTMmYwQ2dnZGROVnpqUEtrYTdNUEhuNmNHMWRRMENL?=
 =?utf-8?B?NDBJMU5kWldBcmpyZnE0c0NRaEpzRjBmTkh5Wk9vVE11SkRrcHAxVjdtWDhv?=
 =?utf-8?B?a0x2MklYdE1ucXJSdExUV25FeG5rdVFJZTNrWGIxeStEWVhubU05Q1p4eDVX?=
 =?utf-8?B?UGJvV1JpVGVKdGhmY2M2ZUVQMDZ2c1hoUWdDQ1JoTlVNaldYUkdDNkJvbXp1?=
 =?utf-8?B?NlJJZmtCS1VobTlVNHVxU1daSmQyUVByWGROOW1pMmVLUTBLcVpZQzVLd0kx?=
 =?utf-8?B?WFQ2disxV29WakkzaE9HTmxraDFuY3dMTVFiTzlpL3M3NTlWSXRSUHloeE1O?=
 =?utf-8?B?QXVGZExjWUJERlpXSDZtbXoycHYrVDE4Y1pNZDF6b0lCVXNvb2FBZ2kyZVhm?=
 =?utf-8?B?SWdOb1UrNzAyY2lMWFdZU1lsZ0FFMCtBTmxwbTJKd3Q5YXVFN2l6UndxeFdC?=
 =?utf-8?B?QTBzamkzS2dTR0JsZktsL0tjWlp3OEhTaHZoMVo5ei9yaTh2YWF6ekdyZHJW?=
 =?utf-8?B?TGpQK1gzMk9XK0lsTWg4TVhiRG9VS0FRMURNZjRYaFlDa3FZVXpROGY2NzI2?=
 =?utf-8?B?eFF3dG9hQUp6NkFQU292bVRFMmN1RXBrZXZhQnd5QWwyVzNIS09FMEtnTlNV?=
 =?utf-8?B?TCsvZzAzL2pFdHo3aGFIOFloNUx1alhZTGVkSWxzS3U5dVh5YVdNODV3ZDlC?=
 =?utf-8?B?bThKSnRUSGI4ZTJodkdnWFA2N1NvcldVdklVVHAvb202TlZ2NkpsTGViNkRl?=
 =?utf-8?B?Q0loNXB1NG9LU3h3a1NtaUp4S1dCdXBGdXhXQ1JGUGoyV0pJR0pHazdlaFl2?=
 =?utf-8?B?UjkyaFpVek5PZ2gyelN0a1RmNHlJUlZpR2RiWTNTS2paNDl5WUtuZW1JUTkr?=
 =?utf-8?B?eHRmZk9qalkwRlhxYWphTnh2SklmOFc3cm1TWW5VWjROVUVUV2Rma1I1NUFU?=
 =?utf-8?B?L09TOUNST3hUZkZ1SlhsZ1lkQjZ2S0dzc0J2dkRDUlR4TWoxNFgvUHp5R1NU?=
 =?utf-8?B?MXAweHEzQVJMeXhtam9aOWI2NGZFOVZCSmFqaHBJb3NmU2h2c1ZWQnJhZ3lB?=
 =?utf-8?B?K3loWkRVRFMwemFyeDNWL2Iyb0ZNTGdheXR5aE9yRFNEYmdNN2RHWjZTUmcv?=
 =?utf-8?B?V0UwV0VxOXgrTDdwNythN3VMUU1qWVdacmJ1MC9zU1hDWjhnOEtOek9uT0hH?=
 =?utf-8?B?RFZ3LytoSVpVWmZHUXBqR2ZZYS8xU3Y2bU1wK0RubVVlb2tHV2NmN3h4b3J0?=
 =?utf-8?B?UXdpemdDNElvcEY0VEwrNWpDRjkvV0lQcFI3cHJtdFdYWWc2VHRUK0RpeDhD?=
 =?utf-8?B?V0M5RG9TTjN4RXpNZ2RJR0xWUi9aMjBOeUJWbEtkZFdLMDVZK2VQNEh2ci9D?=
 =?utf-8?B?TXB0QkhFQUt0WGNTYWliRjZaeTNHOElMN09lUyt2ZDd2WjZ3WFVsd2lRS1FB?=
 =?utf-8?Q?+kEE3Uz61i0XCwacoGqbOqFyG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16af20f3-8cd9-412f-4811-08dc8f416a28
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 02:50:29.9386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQtEToLpB6QFWkN/k1o4lvpqiMjwNAel7fDnhMhBiADnO8M3335uM8lKkpCrWfqyKwbzxgTiARaCGlq8judQ9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5300
X-OriginatorOrg: intel.com

On 2024/6/8 01:38, Jacob Pan wrote:
> Queued invalidation wait descriptor status is volatile in that IOMMU hardware
> writes the data upon completion.
> 
> Use READ_ONCE() to prevent compiler optimizations which ensures memory
> reads every time. As a side effect, READ_ONCE() also enforces strict types and
> may add an extra instruction. But it should not have negative
> performance impact since we use cpu_relax anyway and the extra time(by
> adding an instruction) may allow IOMMU HW request cacheline ownership easier.
> 
> e.g. gcc 12.3
> BEFORE:
> 	81 38 ad de 00 00       cmpl   $0x2,(%rax)
> 
> AFTER (with READ_ONCE())
>      772f:       8b 00                   mov    (%rax),%eax
>      7731:       3d ad de 00 00          cmp    $0x2,%eax //status data is 32 bit
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel/dmar.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 304e84949ca7..1c8d3141cb55 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1446,7 +1446,7 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
>   	 */
>   	writel(qi->free_head << shift, iommu->reg + DMAR_IQT_REG);
>   
> -	while (qi->desc_status[wait_index] != QI_DONE) {
> +	while (READ_ONCE(qi->desc_status[wait_index]) != QI_DONE) {
>   		/*
>   		 * We will leave the interrupts disabled, to prevent interrupt
>   		 * context to queue another cmd while a cmd is already submitted

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

-- 
Regards,
Yi Liu
