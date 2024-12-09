Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D6320ED
	for <iommu@lists.linux.dev>; Mon,  9 Dec 2024 03:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733713342; cv=fail; b=fbBwrNPpt21gxVzhPYvConZ2vvDvW/+glsYwKSVIzPnY7yBHFAeUFdSJcTuUGIPzoMS/W+1UvJNuqLKV79WCv1TJBCLh2/vF/oLAnisFnT795EdGRDqNrNrAOXuQR8HMphzQRRSup1afu/+x3+CR/9DUFpgz2MwX6HxL2QW/D+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733713342; c=relaxed/simple;
	bh=zA/UHCIROutcz2Igpkue8YARSW8MLRgmKDrRy4++Ayw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tTdkvO503l/zFE8bSNSCnXcUy0LNHl33uU6ReWSH9LUUmxXZ3LfffDO+rPCSkzhxspWy8K8ZQQm34NL5Oed0JZ6YR3qCcAn7y1fVkVzFhp8L6o7d425vs/0XN9dIyGQ0eE8Vz1v/YYPbTuALO7IDGLRjErIv14knmv46gran24c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJWhiNq5; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJWhiNq5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733713340; x=1765249340;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zA/UHCIROutcz2Igpkue8YARSW8MLRgmKDrRy4++Ayw=;
  b=mJWhiNq5cMVzpVWG7jetOMWfOG1jE9we1sDggyGrdCvQsWhm3lT5By9m
   JRqb3penAYtQIsWoZucCdFVM9voxF3xtcNOyWV552qW5UtHiFDE2ymonr
   6/hU5SYFeebtEmaYT7iuThPxFC2m1ELG8JOEBEodw9sTOADSsw2WnbjDs
   TZNGAm7SnNBeVezoLdEffX3Jz3TEYqPkfj6MtRVQJaI5t6Zp4XN8/5qb6
   kzPjNaMaYQkm3xMxHJa+ZMpLRgc4yYikZD4QdMHAnjG1zufXJG3AjQ2PX
   Gv5VMEHUt97mdGOK3yEKnkp4s5D8FIjtV6cU1Wog2HfFhrcpTo8yPD8hu
   w==;
X-CSE-ConnectionGUID: L/bGsvtATsWAmwg6hBPgdQ==
X-CSE-MsgGUID: p0XaXnJ7QTiQLQOD3U+8Vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="34232481"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="34232481"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 19:02:19 -0800
X-CSE-ConnectionGUID: JMvggAkDSKefSrkErtUdmA==
X-CSE-MsgGUID: NHHjtk+cRcWM+MvmvEjzUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="99386432"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2024 19:02:18 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 8 Dec 2024 19:02:18 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 8 Dec 2024 19:02:18 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 8 Dec 2024 19:02:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1HwLL3KNBTkKV/XBg9G/WENrujIIxiqOyzv0sIsKYrzf09yG1vfbYLFHFoZ1aQllBHKXiJ1b37pRRxJhGNuvkkkh+scuTEVNZY6/W8qPri8InlMyvKwULV/rQvrFF4WUbekp8/e4odDKrWYUbuk4BTngr4HNifrXe5pR5hK/tlNVXxXBT6k1UeUwqC3PtBwVE4ut+nsMCPf9FArVl5GeuOsPooNsRHda/x+coi+JWgUW7bxtyPqRdYfDGNbjQaqF5wF+zNzeqU9P49r1XxzxHSCfLf26N7nrS9ytwNeIjUpuSCGA7kfSsYKV+2gB3SbHZKxvFMzsYbnBK+aCk5KyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTBu1gYAX9INZBfSJ8MaWmh7/S1APKwEHv9K3vB6ag0=;
 b=KR1ulahjn0Peo1ss4psXCePjoeeDQY8CW0S/w6/dw3GCnoQOajNU99rQDdeeLwqIvCaWzNeCEgADC+G3P63eNojPnKe0ih++67/WNr0a7rkucekaQ+MArJ56skza1iYrw6HFur9h/ccix0ZKMoflbFfunvegpRjYkA4+71/u7h+MvxG6izyxYxp8wmIucTQPD/+tUegtzlzs/9/T1mLkqRU9J0E+RT0fCvO7S7D8l6Ilcf/fStgsZxL1jhg2GYhW2Ve6epAs8GSnlPLR3yEGI4T8OlqntJmbQMRsIbaNHw6vuc8PIfu1Mgca7S+3XoHhXCG/skwnCeE9C3x1W5vXNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CYXPR11MB8690.namprd11.prod.outlook.com (2603:10b6:930:e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 03:02:16 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 03:02:16 +0000
Message-ID: <b25901cf-6483-4434-804e-62bda4385796@intel.com>
Date: Mon, 9 Dec 2024 11:07:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Fix qi_batch NULL pointer with nested parent
 domain
To: Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
	<kevin.tian@intel.com>
CC: <chao.p.peng@linux.intel.com>, <iommu@lists.linux.dev>
References: <20241207120304.5710-1-yi.l.liu@intel.com>
 <ce413d97-ec46-4cd9-932a-af804cd531cf@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ce413d97-ec46-4cd9-932a-af804cd531cf@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0234.apcprd06.prod.outlook.com
 (2603:1096:4:ac::18) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CYXPR11MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e12a8b5-aad1-489a-f6d3-08dd17fde2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEkwYWtxYjROSkVWQmQ4VXdyOHl6QXowWndaV3Q0K003Nm9XZGZXSHdJZ2d2?=
 =?utf-8?B?VjZ2Q1p6RHBHRzRoLzd1WmRLZ1k1SzViMnBMUUFPRzJZT21UcTRpbURaaGlS?=
 =?utf-8?B?VWxCRWtnZVhpbWtDUHRUb1VLUEdOMFp0UXFKMnYxZC93dUR5VWRkTUhmRFU4?=
 =?utf-8?B?R3pJWXA4YTRkQ2FDNHJjUm44c3RtZTNhNzYrK0Fuem5ZTHVWZERSc1h6Qjdu?=
 =?utf-8?B?SGlPSFZiajdMQUZ0LzJtSTlwTlJXL3J5eCtLYUMzNys3VHZxOXI5dURGNWdX?=
 =?utf-8?B?d1h0Z1RyM2ROZWgvNUNudElyVmI4YzNvdVhyd2Z4NUJIcDFnZVdUZHlPRXE0?=
 =?utf-8?B?TDJwdkdZUWVSZU45WmxRck40OUx5cFlEcHRMalhrMVZ0Nm5FZStXSXprdU13?=
 =?utf-8?B?aWpZdWdXeHlGaS9HNUlMcm5FbzBaR1hRWFEyQ0pVMkJoVktXekwvL3VUM0Fn?=
 =?utf-8?B?Y1hJMEVnQnQyYllZN3hUOG1UemNaTm5DclkvSmhIM2FzU1lZcFJLdjl5MjE3?=
 =?utf-8?B?YlU3QTNON3ZxNTh2V1dscmVURHN4U3h3a1Q0eno0OGhIUjdycVRNSFY4aGZj?=
 =?utf-8?B?bzZ4MUdTL2RkTGxMN0dFWHMvTDFEM1lEVzlZOWF1ajRQc1NwOEY0dlkrRkFs?=
 =?utf-8?B?YUdZQXBCd0FxRmdCaXZTODRqSE0vTUREYmpqdXc2VjVhZW10d01lUjU4R1dE?=
 =?utf-8?B?cjdpWm11NGhZa2tyOWZIUjRrTTQ3T0xvMHNBYnVtaVVSVEEzNEt2TTFDRTlX?=
 =?utf-8?B?Qjg4TkFSa094azF3bEczbDFOU1c0Q2xCOVNxY0hvaVkwV1daMXR6NS9ob3pV?=
 =?utf-8?B?bVNlVVdEVGNnbXBlY0s1VFpWMmZTdVErc3ByeFFnNzhPQkJoRnMvVXhaOVlP?=
 =?utf-8?B?d1VwU2Qrem4wY3M2Ym11S0haR3JhdTNoT1M1MnZVMDJZbUI5MnRKbU1USXZO?=
 =?utf-8?B?L2JhRnphUVV5dVZSYUJoUkNnTXc3RDR0QlEwcmFsM3hkMTJRcEZ2UmFVZWI4?=
 =?utf-8?B?WUFXcVQxTTlwQlF4YUlkWE9JZHlBbTVQS1BsVzdsLzh3OGZPNXNVSi9tM1VD?=
 =?utf-8?B?WkxGdlVtZFhLTWVlMUV5amo0emFwbDNGMTZzaGNGYkFrU3U5ZmxuMng5SUNk?=
 =?utf-8?B?TkZ0V2E2VktQWldMalhFcFgxMEp6MEN5cmlZU3Nwc21OQzlVdlBCb0c2YUhh?=
 =?utf-8?B?cWpMM3hHbmJIcmpnbVJFZTdiN243a3Y4bmhGazNCTkpTTkRVdFFoTS9VYlJV?=
 =?utf-8?B?bVRXSWVwNnJINW5kcTBlcHlUajdtVndoaWI2Ui9qZjIwSURFamFudTFUcExm?=
 =?utf-8?B?R0ZrRFRtaDVFekdQWmpIR3A5c3FMNTU3ekc5cjhBdkZpY1ZaTXdrOG5OY2JP?=
 =?utf-8?B?ZDFBZXVySUsyUE5QNVAxbWROczUrRFd5STY2TFpOejVzd1FyYllJMi9QMnBM?=
 =?utf-8?B?ek44ZDkxc1NQREUzMzZsanpLNVRTWU1NMVFLdndsNnpVWmZxS2hRdWkyYTZ4?=
 =?utf-8?B?c0Q5NjBITWd2QTR6VWJDT1QwREZhdXE4TzNHSnoxOCtKN3FSODY3bkV0aGdz?=
 =?utf-8?B?VjdycTl2bStZbm5WR2xIUDV1QzAySkw2aG9saFREak53SC92U0I1ZTRvYWJZ?=
 =?utf-8?B?TmJqVHdBcFc2S2tqWlNlelQ0M1dIN1p5N0xLTzJWQmJ3VmcwNy8ybExqeC9n?=
 =?utf-8?B?UVZtcHc5cGdpTk83bS94MmM2N29SZFEwbUV2dFBnUk1VbjlqUFFJS2xtNERQ?=
 =?utf-8?B?Ri9ScGRMaXVPUWgraldPQ2Zlbk9LbmFuRGFpVHdyTjRuYXJ5WFI5QndjbU5V?=
 =?utf-8?B?eEx6ZDNIMmpXYVZ3bEJFUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG1wQTdOelYwSmhlclh5WmNIR29KQU9GSjU5dU1GWDhnZEs5T0ZNNDJ3ZHh1?=
 =?utf-8?B?VU56OWhxVE93THVocUU4QnFLTC94ZndZWW80MlZSczRsWFRHRG1LR2hDbHkz?=
 =?utf-8?B?UFdYREFGNytmWFNEUzdMUGRHNkpoaW40Z0xJR3BYMDI3MVRBVG5Ya1JwUlFG?=
 =?utf-8?B?a1F3ZVN3STh0Ymp2VGhlNmgrQUVDc0J4dTJ5RGdvdDh1MU9lRldmWm9jUGpi?=
 =?utf-8?B?akJsNTdNWTBBS3BuNlZ2M2F2MmpZMCsxYlVsMS95ZHo3NTEzL2M5WXRjQzl5?=
 =?utf-8?B?WDEzNGd0cFNqekdwNFZSczNEdzA3S0c1ZVE1a1VSeG9nclo0TVVoQkY2Unpp?=
 =?utf-8?B?SDBWdmR5WUZ6NEQwNk14c2hxaE5leEt3d0tablNnU3BJa0l1QnVFcjNuTm9K?=
 =?utf-8?B?WFNzV2N6QWRSYU0zQ3doclBoTURsMEtZM0pRWXRlNUx5NU5DcDF6bnBSQ3Q4?=
 =?utf-8?B?cDJDWk9vL2N4ZEdUUS9rL0ZRb1BYOFVBNmp5cG1ETTN4VUZZc1ZyaUpTZ1ls?=
 =?utf-8?B?L2NVL0xPUU1oUThsZ3h0UDF4Uk5aV0lDQzdaci9Lb0VhbXBxZ2ZENmY1eGlP?=
 =?utf-8?B?ZGk1ZmpERnhjT1dFWEpSZU9iQ1l5azVtVHVzazA1eVlyb3lHUHNJYzhoSWRy?=
 =?utf-8?B?bFdTdVNLSzRRM21BZTZqK3FUTEFlcVVzc3RXOFVaOUNvMVBQcTBaL0h4ZEVr?=
 =?utf-8?B?ekRsc1JGZkl1TkhlZlozWWxod2o4V3d3UXhtbjRrWjd3OHBxZkFRYmx5bzll?=
 =?utf-8?B?eFVRTU1pK0o3L1BPcHcvNnRuejRQMUltR1dLb3hudUhKUHovTGsrbGg5d2Z1?=
 =?utf-8?B?ays3QjJmWjRWUzFPSE1UU0NXUjFzRUVQOTkyNjBXUWtuODhTR25PMWlFRklB?=
 =?utf-8?B?dXluQkZEVWgwSHpLc056cVpIZURjWFZFdUFPZG1ZanNudmxtVUFJengxamdt?=
 =?utf-8?B?QmpPbjlNbk53UFM2ZGpnVzNHNVZnSTd3VHpmZ3JBZ3lBTjMzaVNGc2IyeUYv?=
 =?utf-8?B?WThkTUYvb2dRUHBuYmx3a09kOFdJTzBidmwyMlJGRERxQS9kaUl2ZVRRVi9v?=
 =?utf-8?B?eDdlbkNxWFdVeVZrdGp6NjJuWjUxZnNnUG1UbTN1WkdJWWFyRXFWcnRURzZE?=
 =?utf-8?B?QjJiNU5uNUMxbzVqcmlpdGpkWEFlTVZYbGZSdFBqWEpFUFkrLzBDdGZIMjY4?=
 =?utf-8?B?eVFCenVhUzZxa21YUlZFekNwOFRRbk1WQVFuTnJqN3VkSm1qQVZ3WnBDVWFI?=
 =?utf-8?B?TDhOQS80ZnUvTk55OTlIcU5ETEQyOXQvSjFWMFl0Q1BTSG5DM3ZucjlEMUtk?=
 =?utf-8?B?QTRhaGlHWnB6dkxnQTNoSFY1U0Jiem9vY1VDMGx3WmxxdnhTSUlpV2RkN2V5?=
 =?utf-8?B?RkREK2pzdWRMY2xNa21CdVNGejVubzQ1cHMxZVpqWm9Lb0t0bmFhWlVGdTdW?=
 =?utf-8?B?UWZ6SXdPUFZjbkg5ekhNRWdqZXErTmVuczV6R2g3Q1U0REZmNStSd0NGdW8y?=
 =?utf-8?B?UHFQOTYwRFJSRTJTbWFOZzV0TmlZckxiZGd4bEN4RGt4bHdNODFMMkJReFlF?=
 =?utf-8?B?c2lLYmt2V0ZwVE5zVW83Sm9ZbEFmV252N1BaM0thVC80aTd2WGE1bkQxeU96?=
 =?utf-8?B?SkdXSjNqN1hQa2syMmJMVXZRVXFtcjZ6TE1BeXBaamgrck8xbXZySURXbHBN?=
 =?utf-8?B?ekwyTFhyTXc5cVRYVmVvdlFaNlUwM0MwQnFEb0JVWWdEc2YydjkxRGd1Tk1X?=
 =?utf-8?B?NmtEWE9QS0xuN0lNZjNZVGR6UmFxSlR3aEZMYkozSnAzUHMvdDNScFR0ZG1p?=
 =?utf-8?B?Yy9hRXptV0pIOXRGK044UFF1TmhxNUZMZ0c4QUxUVVMwUERKZE1sWExBRlhu?=
 =?utf-8?B?NjlRWEozUTEraVRQc3gzY2VMZ1NVWldWbHVWQVJreDhaMEZ3bk5SNEk3aXU4?=
 =?utf-8?B?OHR0QW9LV203UEFuNS80ZkYyNU0vRlNVNWwzNEhETGZXTzgrQVhTeVhveVJt?=
 =?utf-8?B?SEd2V1Fick4vNXBScy91cGJCekplbkt4aTN4SGNhMXFaampRenpSYThpN1c0?=
 =?utf-8?B?cUdtR0NHU05zVGREMURja0dZYkhMK3JET3pQU0hjbENmWkVtRndXWFZVSFFm?=
 =?utf-8?Q?ZpnnC4A27rk8/0s/NEPPOinnd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e12a8b5-aad1-489a-f6d3-08dd17fde2cb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 03:02:15.8698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9R6aipGXpY8aoWieQoC/x8av3tImcw5oNgieYUM1r0ErfGvKi2bQa+OsQOGCyqKHQMaJ9LZhY3V7hhBhULlZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8690
X-OriginatorOrg: intel.com

On 2024/12/9 09:39, Baolu Lu wrote:
> On 12/7/24 20:03, Yi Liu wrote:
>> The qi_batch is allocated when assigning cache tag for a domain. While
>> for nested parent domain, it is missed. Hence, when trying to map pages
>> to the nested parent, NULL dereference occurred.
> 
> Yes. Good catch!
> 
>> To solve it, allocate qi_batch for the nested parent domain when assigning
>> cache tag for the nested domain is enough. However, it seems not quite
>> reliable to allocate qi_batch in cache tag as a domain may be used by
>> multiple devices, and there is no lock around the domain->qi_batch check.
>> As all the domains (except blocking domain and identity domain) are supposed
>> to have qi_batch, this fix just allocates the qi_batch in the domain
>> allocation.
> 
> So there appears to be two problems, the domain->qi_batch is not
> allocated for all paths and it's allocated without lock protection that
> creates a race case and possibly result in memory leak.

yes, it is although we haven't encountered it for now.

> But I don't think there is a need to move the domain->qi_batch
> allocation to the domain allocation path. That's a kind of refactoring
> and there is no need to mess it with a fix patch like this.

aha, yes. I felt the qi_batch eventually would be allocating it in domain
allocation, hence make the fix like this.

> Perhaps add a helper to handle the domain->qi_batch allocation? And then
> call it in the necessary paths? Something like this:
> 
> --- a/drivers/iommu/intel/cache.c
> +++ b/drivers/iommu/intel/cache.c
> @@ -105,12 +105,35 @@ static void cache_tag_unassign(struct dmar_domain 
> *domain, u16 did,
>       spin_unlock_irqrestore(&domain->cache_lock, flags);
>   }
> 
> +/* domain->qi_batch will be freed in iommu_free_domain() path. */
> +static int domain_qi_batch_alloc(struct dmar_domain *domain)
> +{
> +    unsigned long flags;
> +    int ret = 0;
> +
> +    spin_lock_irqsave(&domain->cache_lock, flags);

I'm wondering if there is any difference using the domain->lock v.s. using
the domain->cache_lock. The RID attach path acquires/releases the
domain->lock first, and then the domain->cache_lock. While the PASID path
does the reverse order. Although neither of the two paths hold the locks
for a long duration (no A-B-B-A locking issue), it still means when a
domain is shared between RID and PASID path, the domain->qi_batch check is
not in the same phase of the two paths.

> +    if (domain->qi_batch)
> +        goto out_unlock;
> +
> +    domain->qi_batch = kzalloc(sizeof(*domain->qi_batch), GFP_ATOMIC);
> +    if (!domain->qi_batch)
> +        ret = -ENOMEM;
> +out_unlock:
> +    spin_unlock_irqrestore(&domain->cache_lock, flags);
> +
> +    return ret;
> +}
> +
>   static int __cache_tag_assign_domain(struct dmar_domain *domain, u16 did,
>                        struct device *dev, ioasid_t pasid)
>   {
>       struct device_domain_info *info = dev_iommu_priv_get(dev);
>       int ret;
> 
> +    ret = domain_qi_batch_alloc(domain);
> +    if (ret)
> +        return ret;
> +

also need to call it in __cache_tag_assign_parent_domain(). BTW. Is the
domain->qi_batch required if there is no ATS?

-- 
Regards,
Yi Liu
