Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BA45684
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 00:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742516696; cv=fail; b=Y/kxTfQxgxAbRy38OZtg2WB9U6HXWMdGRrCrarxnIGkJMOLvpfKQq4ixc4/6RqPtV8exdVIsVhMxV/658CDpz3Bu7yNd0Jy84Qjepkax7GN6uAdBkeqwjeQPtMw05yBWEfFzNqJmMXsTfkWOQ1NKzAhA1txpEgYUvPGpPbzlsOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742516696; c=relaxed/simple;
	bh=6tAfJiExJNzJXQuvZ4KCa3ai5x98k65IC4HyEH00Jdc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xoe04apUt2cNnF10nlkTXvS43fx20+Fd18QqdV0axJ5JVowUbYmADxQMMKYELEb+rnaRqdksil3OJ4wZpih7ub5D7xpuy/8KEZEtWzQ9mrPGAZTdvAFfc/9zPwlz+sKOgUfQB30FSaXnc/lv+5YR8rCIwnuM8FOMg9inHKzzfZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rr7t7TxR; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rr7t7TxR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742516693; x=1774052693;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6tAfJiExJNzJXQuvZ4KCa3ai5x98k65IC4HyEH00Jdc=;
  b=Rr7t7TxRDR6WIjCA2Vi+ZicGVBknrfsSP3IrZexJPAqbHDh0rth/omX8
   L0XCFy9cxPZbvMY31A7eN8BurOzuftsz8QaFeS+yHLIVLb+wedeNC+r8z
   hsoa4d3G2rxskY+lfmmT9GfzpbMz1+rovufTTB3GTs0g3goOb4QOGWfwl
   IlhZschQ/ii9h6gzBjv6hlwKbzWMqcIpkWwWcEWduDehXjsws55aY+6Z0
   i1EAlNkqzFcSLbrnyVq/NIXWVt6zQK98+vpxLWR1XA95xskL7p/hlI0hk
   WOfSfK9aB0HMzg7K883vnAaz8ot+Ja0YsbxZmgnw8qCEm+Z7M24BmI0lT
   w==;
X-CSE-ConnectionGUID: lyUEc1JUTJ2ENtsFFT3O6A==
X-CSE-MsgGUID: 6xlYpiq6T/+kXtJoxTGrcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="42938095"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="42938095"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 17:24:52 -0700
X-CSE-ConnectionGUID: rF7LDALCQf+DyXUnjEhw1A==
X-CSE-MsgGUID: BI9iuY1eR7KqvBN4n3U77w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123061527"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2025 17:24:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Mar 2025 17:24:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 17:24:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 17:24:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlBqD8DCMYk+b+ZDN04lJ4Ag7EgMmbZfyZd8gSoWY4DAwmAvtZN5BYawPbert6pbnkstcMVSuVqFYWuT9N2ZKo4F0RuTz5BAkXibR/e4VCtzKtJtxByV1VMWRulV4mi1erEXii3eboD5mWMvv6xnBL0fKjulWNyZQeFMMLwDOipictUghqm8g3r9QM+usiSRRO010PhdQQv11y27UUXde3cbCn3krI+bo+dqWLbxO/0qIOLeM2QOpzzJhOm4m/XPlQ2B6nmiEPWKDWwOWMeLOeLwGSHfZSsr/FjUolyKc8FXNKYy0E52USBlK6gy2jEUDNL2kDYvtimjZajzv9Fk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYx3BR7UM8ZwcCzLX3Mv0zEtGITGueDqrNjurZjARXA=;
 b=y5k8RN+RR/RppcrkNX5FnP0rg2jkr9NJ5bqY82lRc/74nqxgSQihhvcgFMLRo35Q3BCsL7g8j0MY7YVPQE1QVUDzmlcTrKfUAAP1Py4VQ+6PYPA5D4WMxKcaMTelienlOpgqYsNFSmnCIizabmO4/fxzvvVu1Zs8KKA+y2UE53iOF//3DD34XP6o2juV44djFgoiBu2Y2cQzzvOcOOPyX6GN2Q7+Y8HCs/O02QGyQsNFm02MPDwI7zEyPWRjDW1ep+yJfrlJshdgWtDK6q59jBbySoxAxrDTXI0yPGrVTOLOEHSYMEciAkGpXIpOEfsmY4/C/y9AK/MsFp6vWJdEHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB7147.namprd11.prod.outlook.com (2603:10b6:510:1ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 00:24:42 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 00:24:42 +0000
Message-ID: <cdc6911f-bd81-4a24-ad5a-03a619832681@intel.com>
Date: Fri, 21 Mar 2025 08:30:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 08/18] iommufd/device: Replace device_list with
 device_array
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-9-yi.l.liu@intel.com> <Z9xglleodSomdLPf@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z9xglleodSomdLPf@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:820::33) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: 38719aac-833a-4694-e489-08dd680ec64a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEhwZ00wWUEwcWxuWmRwRWwzR0svTGVNVDd1bWRpeFZVVEEzbEE1N1BSU1Vz?=
 =?utf-8?B?d2JYckJ1bnpvMGpQMC8vSVJyNVlONStEOTZ1SmtlS2N2SEJJVHpIbHhWTlY5?=
 =?utf-8?B?ckxpOFdIZWNtcTJzVlYxY01zRWJza3piSkFQaHFpeWxSREpJTFVGVjRUU0lr?=
 =?utf-8?B?dmZ2eW5lUWRnMUQrbWtvSlVGZjF0dW9LYnlDU3NBVkxWa1lCYjRFZ21xMU9v?=
 =?utf-8?B?bWlEK2hFWEF6bm81UExRaklFL1dnY2Nra1lVYUxMRUFNdnNqNVhqd3RUS25j?=
 =?utf-8?B?MENVT0FZeHZOaDlxTE94YjJPME8yeDNXejVDY0xuMWJGM2JqU0RLTnNicGVK?=
 =?utf-8?B?R3VLN1ZRVjJqVlBCK1BJc2VoZit4V3VIbXgxVlZ4YUJtSWJOZ2dPbkt5RFFx?=
 =?utf-8?B?eWI1cHpSMEdJcGcwd210ZW45SU82ZkphMUNYZ090bndJT0xCNGJiRzJnRjlu?=
 =?utf-8?B?d2Uvbm82TStjbFhZQ3lyQ2NTTGVpMys2NGVpaGxFeTc0Qjd1YzI5VHdRZTRY?=
 =?utf-8?B?d1NkdjdWRU5GUVI5d01QejE1Mmp5bGRwQWRTZURmaXNETlRGeERyRUNneFcz?=
 =?utf-8?B?MjFCdXRJSVVNc3JXUWFpcFBtRGVXT215Y1JRbHdHb1dreFh5cFA1bUxVRnIw?=
 =?utf-8?B?QTNZdTkwSTMrR3laNU9tZEF4QlRIY0JZakY1MGtZVE5ab1ozekp1Y3M4ZGNR?=
 =?utf-8?B?alkxaEJjUUJiVHVKRlFrV1BRVkJWMkVuanNvUWI1V1RyN2tHM0diaUY5U3g5?=
 =?utf-8?B?SWNCdEtJTHEwVFlKaSs0eklDb0hGYUV0YUY3VGhJR0Y3bDNmZGhndDFBdWpO?=
 =?utf-8?B?dDdEaTRiK05nL3dQRGxSZ3NWS2ptemJURWZsL2kya3VOZkIyVVlBYlAwZjUx?=
 =?utf-8?B?RENjN2pBNHI5bmcwOU5mbWt0VEw2RldTRDNkKzlKNkUvZGVTeVVlU2xHeHI3?=
 =?utf-8?B?aVZzeWFyTXpKU1NtNDZpbSt2Q0R0NGZXVGVmUzhSVUttaW9XK2QyVFB5RUJs?=
 =?utf-8?B?V2o4VHNsZ3MrbkhpUTM2eElPb05zVjE1U0FaakN0Z0UrUDZiWGgrejQ2ekNE?=
 =?utf-8?B?cVNGNGFLVWZON2dsRHVLYUhXOUdYV29SRGhzalBkbEpRcUs2bzllY3hVOS9O?=
 =?utf-8?B?MjZ3aWpXM05qc1hwbjY5Q0czem9iRCtOeXB5bGpDTUFvcGVwenFRbUlIOFZB?=
 =?utf-8?B?VnNxWUk1dW4yTXB1Q1JMcEtaWTNqL3lZYUFuTk0yUHQ3QkVrRitDTGl0d1dh?=
 =?utf-8?B?SytFNllobDVNRXdOTHV0MkYwZG4xbmFFU05CdmZKWS8xN0paMDZhOElMVnl5?=
 =?utf-8?B?NXE0MVgzN1RQc2pCeVpMNlpWSTZOL0xRdXJxWDVvSUpwZmJJSVp6SnArcTJH?=
 =?utf-8?B?S3R3U28zNzdCTFVpS2V1KzlDc21xeXVHclU0QVdYaEFqK0QrakhKaGRBRGR5?=
 =?utf-8?B?V1JUT253ZGRocm5vbEk5T2wwa2VnU2p6U2gzNGpFOG5IblcvWWdENGlRbmNP?=
 =?utf-8?B?VEkwblJOeVlVR1RnSUlFV2FkNGFSM3FFRWE5Kzg3V2gzdUlTeFpCblhmWHBp?=
 =?utf-8?B?QWsxQ1BYdEFmNHlpYTFxYm5CQ0dmNTAvY2c1YVhGbHBPT1lWVmVLZUk0Ukho?=
 =?utf-8?B?MDYvdHpnUDJHdHo0TG1LNmsyOEFreXdKY3A5cWEvcXo3eWtrb3VBQmNpalJG?=
 =?utf-8?B?a3EwM0wwVjI0YXR5c1NHVndIRzJwdjFUejl5K1gzRzkzZFlvR3FVRUx0WktE?=
 =?utf-8?B?ZUhuU0FPRmVOK3NvRldGWlh5Q3REeUF1M2RmMFpMWm50SVhYS2tMRnA4YWF2?=
 =?utf-8?B?VkpMUy91QmdKZlRIemhYQzN3MWRJTENxZVFXNU54MjMyUkVXRStqTXpzU1Nv?=
 =?utf-8?Q?DA22x9Eri1M8u?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1RTY2pOSmcyTVk3aGIzelVwZTlmY3BMcWFyb0FrZzdMTTlJZ2pROU1lT3VK?=
 =?utf-8?B?ZDJUbDRjTGt0b05ROFRLTExJUFprZXZ0WVBUdklhekhrS1M3RU1HdUhzSTls?=
 =?utf-8?B?UTQwMGY1T3V4VHUzbjdvMTI4ekh4YlViaHFlbDdUQzZCT1lxaHg2QVhSS3N4?=
 =?utf-8?B?TFgvZW56Q0I5V2ZDUXVsNU5jZ0hkdmsvc2hQYnZZbE1TZ1hVL0FtRHFLdUFB?=
 =?utf-8?B?WituKzFNOVo5ZFNqQVRqU1ZuRy8yTGlCVGhUWXZHR3BqUnhDTmx0ejJZMVAr?=
 =?utf-8?B?R2ZTdVdXdmZxOC9vWHRTOVlLb3pmdU9mQ2R2K0dUQTh2cXVTUUkyRUliVmUv?=
 =?utf-8?B?ZXNQdGRDeWZZU3lrUW1Hd0RKNmRsZTlEUWJwWEtVOFRWNW10VjB2eEJUMEQy?=
 =?utf-8?B?d25yTzVmSTR5bTl6UHZvazlRb3RWNzJsQTBLaWhhbzBKMitHWU13OVJKL3FU?=
 =?utf-8?B?NTNsY1k2djRmd1c2VGZvUGduVnBKSCtPWGtxaGUrK0JLSTdSTG5IL2c0VlBO?=
 =?utf-8?B?aStkVlpKM3lScnlwRlM4Y2JVamVYeFhUY2JJbEhsejFPd1pBV3d1MXJkUGVi?=
 =?utf-8?B?K1BhQTNWUzlKczJNb1RPeHp5OW1LTnBrTjh4Nmh4ZnBheExSY1BpY0hsNEhs?=
 =?utf-8?B?TnB3Z1FaWTZFZ1p0YkxZYklVNENZTkxyTnJNbk9qeWRSMzlTR0hud1VLK0Nj?=
 =?utf-8?B?bWgrKzBwZm1ienFTYVE0QnFrNmc2aHJQT1krUzBvcFArTlNxdk42Tkc4S1BL?=
 =?utf-8?B?VnpTaEVESDZCRU9kb25pSTQwd2w0QkhNTDd3UnhaUUJtdW52U2x3OHc5dDN2?=
 =?utf-8?B?YUMzTGQ0RHJpM2VLdC9vc1lJOUdzOHNFR0dQb2ZTdWVSOEgxZEptOUYxdGxx?=
 =?utf-8?B?ZEZ2RzZSUVl5d1huY1NLdEp5aWNnZmN6cmQ4M2kyYmZIVHM2cUNHaU0wem4w?=
 =?utf-8?B?YSs5bTY0c2p6TUMrVWpLWXphVmRxZWJ5Mk9LRk4rRlR0ODFXQkRpSmpXbms2?=
 =?utf-8?B?TWg0RGcyY3JqcGJXNlhGNStDaVljcWtCdFpVVjJBZ3ZlUWg3ZkNlNFdPQjhD?=
 =?utf-8?B?b0oxN0ZnTkRMWU50YTEzWjI1OHg5QWM3ek5nSGhsZUJyUUY2WUYvcERUTThW?=
 =?utf-8?B?OGNrcEsxemJZdEMxRXQ0YTA2ai9uc0ZsY3VTV2J6T2c0OXBPeC8vZjBkdmFO?=
 =?utf-8?B?Rm90dWxhcUZ1NEVBcm5TNzJoVTRmNVp2WnRrYUp5WVBFK3Q4YTcwK2dReVJp?=
 =?utf-8?B?dVNCYksxdHpnYXdZU25SOGFTKzB4VmEyOFdVRmQvY0daclNrWFA2ZmNXU011?=
 =?utf-8?B?cWZRNXFpQW03T2JkT01ZSWhYckRCUDhTTFV5L0c4cmVuaGU2WmVhczlGd3lU?=
 =?utf-8?B?azFHQVc5THdHZG9BUmFsWTh6amhhNmNBSUJqNTBRTGJPYW9CN1ZucWdjYVFD?=
 =?utf-8?B?Mkt4bm81YnpFQ1FPZmJXME9aZkxqczFmbm5ReUVGcHZ3bnkweXVlKzF0bmgv?=
 =?utf-8?B?Y001QmN6VHRBZVZUeGNac3YwSFBUbllpZ2E5dlQ0bE5LZ1VpcTh0QzN1SnZZ?=
 =?utf-8?B?anpRWWoxN0dBRmVQeXRwbnZrbGErVlY3Tm9nSFZLc2ROMVJabHB2QmRNSG50?=
 =?utf-8?B?ZFY0bXgwVTVqR2QwbVhmWmFHM01MemFLZ0pydDJ0Nmt3S0FCRzJnTzYwNy9Y?=
 =?utf-8?B?TndpVWlTTkxPamxUYnh5dGs0NkN0L1NqQkk4c1V6NXpWSGYrcVJwNUpxNEgw?=
 =?utf-8?B?VGxDY2czb1NEdHNQRExISGF0ZHE1bzQ3dDRPMy81eEREZmh0YzZCS3ZackdH?=
 =?utf-8?B?SDFZS3ppa2ZPQUgybURrS3RPZ1U1bWpidWlUNys3VzB1V2FxYXlURnkyci9P?=
 =?utf-8?B?Rjl1WTFiaDdBR1I0K1IxVTZMMVBRcVV5c0srMWhVNnN0MEVSVjR6VVhkdDZG?=
 =?utf-8?B?T0xvTlhubndSOHk2NzV0MGVkMXlUMkFVTVpRay9OaVhMaERRZWg0VVBCTnhM?=
 =?utf-8?B?L0J3bUt1WU9FaHJINWh1SU5ZZ0M0R0JCUElVZkxQSTdPNEFWODFVUjNjSnV3?=
 =?utf-8?B?cWJWczRERFhMN3pXNGVPYXFuRHQrZlQ3Z21VcGlQMUg1OCt6S1NSajJGczNo?=
 =?utf-8?Q?F5qwT3HyswvhniFxjd/7zqr30?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38719aac-833a-4694-e489-08dd680ec64a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 00:24:42.5882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZAQNwuZTF6ddnu43ks0EjhRw1tbVrDHRS4yyEXWgqLTBmadtsokNZdbE4ARzXZySfCebAsoCMcB9GZ1wx4yGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7147
X-OriginatorOrg: intel.com

On 2025/3/21 02:38, Nicolin Chen wrote:
> On Thu, Mar 20, 2025 at 06:47:34AM -0700, Yi Liu wrote:
>> igroup->attach->device_list is used to track attached device of a group
>> in the RID path. Such tracking is also needed in the PASID path in order
>> to share path with the RID path.
>>
>> While there is only one list_head in the iommufd_device. It cannot work
>> if the device has been attached in both RID path and PASID path. To solve
>> it, replacing the device_list with an xarray. The attached iommufd_device
>> is stored in the entry indexed by the idev->obj.id.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> Nit:
> 
>>   static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
>> @@ -625,20 +634,27 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>>   			rc = -ENOMEM;
>>   			goto err_unlock;
>>   		}
>> -		INIT_LIST_HEAD(&attach->device_list);
>> +		xa_init(&attach->device_array);
>>   	}
>>   
>>   	old_hwpt = attach->hwpt;
>>   
>> +	rc = xa_insert(&igroup->attach->device_array, idev->obj.id, XA_ZERO_ENTRY,
>> +		       GFP_KERNEL);
>> +	if (rc) {
>> +		WARN_ON(rc == -EBUSY && !old_hwpt);
>> +		goto err_free_attach;
>> +	}
>> +
>>   	if (old_hwpt && old_hwpt != hwpt) {
>>   		rc = -EINVAL;
>> -		goto err_free_attach;
>> +		goto err_release_devid;
>>   	}
> 
> Could we reject old_hwpt != hwpt (replace case) before xa_insert?

reject it after xa_insert() has an extra benefit. It can detect duplicated
attach on the same device and hwpt. This is supposed to be -EBUSY error.
This is aligned with __iommu_attach_group(). I think this was missed in the
before.

-- 
Regards,
Yi Liu
