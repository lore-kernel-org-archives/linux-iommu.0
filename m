Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA28B1CDFA6
	for <iommu@lists.linux.dev>; Sat,  1 Mar 2025 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740829152; cv=fail; b=KQ8IRxWHI/SY5qMgGCGBzTzX1Qt9EEG/fQfxXr2mpRvoDwSqnMvbR2vgt8fiDx/j1Nzuya7l3xV417YF9ezjK5Tw3ih/t7vUXaK+oewIZ1qk4dfsRnTQ1Tsq5WD92n2SNemgYMVpTj82gbA7V4FEfoclQee+ozv5TymQcEeThMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740829152; c=relaxed/simple;
	bh=bDV/1AQhQlhl4M6c5Wc8qq2S/Gnj2xEjZZW3tmQbe0k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lDHa2fVeXhmS0xZkEry2msheq8uzHRzNcejuIqsg+Wg348aGy/H6HixclyZ2vxZJSlfUZisvb1W8VusKSlGMfO2uaghpiQZLEcupJq9/lRmTU0+97Y4X7rfgHl2HMQ3Jblp/iRMyomOnOAwZhTNAcQSyOFhkAOlHlAw6TJ6LnqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LWWP0M85; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LWWP0M85"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740829151; x=1772365151;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bDV/1AQhQlhl4M6c5Wc8qq2S/Gnj2xEjZZW3tmQbe0k=;
  b=LWWP0M85Zw8QtztvOo/a16bekL+eIcTM8Kd5JfkdOgb2eiu5uajPyadP
   uvwsnACJMJkeqri775zNraHH4M4l9NlP/GgvEwKdXdRSZ3jGYOkHs2BJz
   DzC99dG98b75nNMXbkTVUzi16iAR5aoPialp/UebUcLbYveJVktS8lksV
   mQVaTcK8aJ+eELyu88CPDOEoZYU2kInH1l1EnPyzusu5Sv0FricRBvrKu
   zhYtV09UxLyykANcEk7qukK8f4SheWZqg4CybPAzQbXGsHw7I1IHvsDf5
   uhWMXYvolFUIy8RkbvAsprIbGBU545ZeCjFfWQetp1Q0Naq9MSyWAPvME
   g==;
X-CSE-ConnectionGUID: ZTuJCSDzTYWRG4KEw6Y07A==
X-CSE-MsgGUID: CJtrNwoTQreb6dtBd5xpvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="59294056"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="59294056"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 03:39:10 -0800
X-CSE-ConnectionGUID: vdRCKbcdTTWNxxxyz3MA/g==
X-CSE-MsgGUID: lXknrMOtT5CaxQDyhsju8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="117584119"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 03:39:09 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sat, 1 Mar 2025 03:39:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sat, 1 Mar 2025 03:39:09 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 1 Mar 2025 03:39:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FW28yVRIUPpMXNPzu3mfjqkDsUw8EzDd1rMo5TepL/F3ubavVxQj7iEby59j+mYD3WVo11t1hxJP1kdYOgEulD/G0W50kUmypE6ePx8Ijy8kPUpSZcyvxhvmJdlu+xGDw2iQFmzSENAABMrpfuieZftN0X4zPabF4jOVk8HHjg30i0/rV0WkN05FTJq8Wfh42+RJEaaYQPpjoe/BzGdQf6sVcuN5NZ6LcISOsKbqHm0rfbRR+iC/HaLlEK93UNzQ7TDe/o04tEn+M+Fxt9AldtSHDqEIjwPmP1YALNcf3lAoNUWoGRxvHh147q8LZuve0oSoq6zVcJshocEO4enwPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sY/CO+JBumMnYC0IUg2Twy6H95cTUQU11A0LMIgIW/0=;
 b=mLdJBypNfGvMGQtj8iYzKfgMv4HkD1N+afJ2imaIZ8FhiJoDAYqAiFT9e8DKe9Opsc6vyXnyySOjD2Yh5xCOnwLcXq/s6ty4GDbkCBip5OkoS0FLsz9zcJ7tbVdIqLRN6YXp9vdfcj5uwVAIJjdwDAcsunTL70YPSmuQhyU7N0mtU/x8uCZyIpm//NqER19omLSz5FJzPo4ElQtRg/vlFHzrTkiyLgtj18abJuoamTs88HjVPb7DbkY5MpazXP+8Gog4r31SvBsEK0fEQY6306B7MChyLXsWVf5XqzPmBkdsdc+I5AdNzFmzUkkr7hUq+d49rbyFR2zxhk51s+IrtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB6067.namprd11.prod.outlook.com (2603:10b6:8:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Sat, 1 Mar
 2025 11:39:02 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.028; Sat, 1 Mar 2025
 11:39:02 +0000
Message-ID: <ee4bdb1a-66e1-4d27-b7d3-f5dc1bc4e12b@intel.com>
Date: Sat, 1 Mar 2025 19:44:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/12] iommufd: Support pasid attach/replace
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <joro@8bytes.org>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <nicolinc@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-7-yi.l.liu@intel.com>
 <20250228153252.GZ39591@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250228153252.GZ39591@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: 211350b9-f4d7-465e-8da6-08dd58b5a9b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzkzY0FndjlQSUEreGpFTWtZV0poQVNFaDNoV2hjMDgrVkFSdDJzQ2g0RjdD?=
 =?utf-8?B?R3NOR3FRaDFXaWxWRzYyOThldTdpVENzbnI2cnBjZ28xZkIxcUxJaW8vNGF5?=
 =?utf-8?B?R3RwbmloQXhIWHBOQTlZcGxIL0txQjhJVTV4eHJjbDJhNzRycDdkdFpDdUVw?=
 =?utf-8?B?UGlBdXBSK0U5MFBqT3VNdkdoUkVFMmhwMkRBdHNQaTlOazZmbnlEQ2NpZ09t?=
 =?utf-8?B?ZkNCSW5DNkRjSFlnV2pSdDhMdExVTWRJY1ltQytjTFF3VE1xaUpKbFZTYXJq?=
 =?utf-8?B?ODNrdERTUm1TcTlZMzhXdDlhZ2cxOXorZmpiYnZoR3czN2k0eHVkMWk3UUJk?=
 =?utf-8?B?alJiZ3pmenh0MWc4SmZ3QzRtOHBLM1J6TXY0OUdKek5HNjVrYXJjNWwwU2Ra?=
 =?utf-8?B?QnVQMFMxYkVsZ2dGTGcyNWRsdFNIZENqSk1YYTNqc3lYeDRHZ1MwOGtmOXhz?=
 =?utf-8?B?VGVwQXpTSDE4MzMzQXM1ODd3aHNoREZHY01yZXQ4b2wzbzE5WkFKVXdtbnpM?=
 =?utf-8?B?bk9wM29UeW1obGpucUZNTURYa3FjV0E4ckVMcDhBWnRhZlRsMDdaK0I4d3VE?=
 =?utf-8?B?dHBEajNUV2hiTE11WXI2MG5zVU8yZi9yZ1dQQUVtMWxwckxVenhYemRBS3p6?=
 =?utf-8?B?K2FwdlZzajlyWDlpR29CS2lkMlFEcUR2eDF4NjdvUW5QUnpRTzlVVHNKVWJ5?=
 =?utf-8?B?QWptcllSZVpxT0VjV1ljL3pVN2JJMjFUSDVKZWk2Wk9la3FqWG9lNWVIYmdo?=
 =?utf-8?B?MHE4R1gvRDF3bG5Ga0x5UG5Cc012RVFXQnM5cnNXT2JOb1dFYkdEM0JqVWF3?=
 =?utf-8?B?WDhoTUZqb2JZaVV6R2NRaDlkcGdBeE5VRFBvZmo4c1BaUXQ5NnV2bHMwU2JW?=
 =?utf-8?B?LzZWU0ltK3pPMmZyajNzWW95UE03d3dLRFBjbFhFT0RvOER1WC8wN2tpa010?=
 =?utf-8?B?YmdZblUwU0FSdFN6aVhaSmNHWWJNbU5paXZmaW1aZ3daaEhpcXhua2lNVUd0?=
 =?utf-8?B?QkZBb3BMQ3dERXVhRlBwRnNIRDBiTmR0Mkg1MmVna3NhVDc5UFI2RXR2THhN?=
 =?utf-8?B?cFRML0ZoQUhWK29SZTBnUnk0ZFJycFNZakFmWHBYSlhmQ0twc01Qd1NHYTh1?=
 =?utf-8?B?L0hBR0hrVSt1eWcxMEVoQlMxS2dhWmc0RUxMNGx3dVM1VHdUVVZSeFVvK2py?=
 =?utf-8?B?S3g0UDFSOFBJRGhTRnJ3REwySnhXZ3hqYTJ3VUtrVTJ1cFNCWFhFa1NpWXlO?=
 =?utf-8?B?bnMvQUZKWFRYeG01RkxuK3g4dndvRmU3dUZXeFVac0U5UjJxVGJRamJEVVJV?=
 =?utf-8?B?bEM4QXNodDkyMXJ2QVZDZVJPZC82RVlrTDljNlc5dm12ZyswS3Z5R0RjaTRX?=
 =?utf-8?B?d2w4NTJCUktweWF5M0ZjRXliR3dzRzBWc0VWZ1lWZWxvMnRKbUZkUkM4MFVB?=
 =?utf-8?B?b3lsVUszYSswWDJjRnZaZTI1OGdwVEZucU1aRzk0WDlLZ21jdklHTHFzZmRW?=
 =?utf-8?B?M28yM1hkdzhTZ2h6dXN0blk5MEhjWkcxQmkvRERXWWtQTXd4Nm5HYVdJTnN2?=
 =?utf-8?B?T2czdjdCVDdZUkdUeU5xUlNnNWJadkJBc2JJSHA0TDRyTTU3cDc5aVdxK25u?=
 =?utf-8?B?ckl6OUt6ZWVOakJkTWZySzFac1poTlNWemhVVXl5T1U2QjlDT01SQUpwSGl0?=
 =?utf-8?B?UlFaZURXV0RJUk1hS0tEWUNURkZEcnJDMnphL1dMb1BUMlZlNEtsdDlNR2pM?=
 =?utf-8?B?dE9HeWhtQWtUV3dIdk8zb0JkMXY5bkxNeFVMUHBKQU93R1hlQkcrVE80c2g0?=
 =?utf-8?B?VTQ1eVNKd2V1TklzdHlzWnovTGhtdHl4a3RyNEtPVXR2bTh4ckNLTnduSUFl?=
 =?utf-8?Q?sx+huM/Gh6Tb0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlQ0bjBGK0NvSFQ2dytoMk5MbGxZNkZyUGpXQjhVVEhlblB6OVYzbXdVSnhk?=
 =?utf-8?B?WWhTb2p5cnRIVXMwZGljUWNGRHFMWGZVeUUvc28vZU15dnROeDZTZWI4MWFS?=
 =?utf-8?B?VnJhQU1vQXRESG1nKzloTFZMTzJBQkVoY3dZbWJLMUZhbFU1V0d3WExjYm9U?=
 =?utf-8?B?TnhXdDgxQzlWZHRhREJNejdJUFRlNldpMjQ2U2Q0Y20raTd5SVFLUFR5VHlk?=
 =?utf-8?B?WjR2elF2c20wYlM0TXNtY2NnVjdjTWxaMms1R3RsOG4rOHVxalpweS9NcEht?=
 =?utf-8?B?VG5XZDlJQmc0YmQxU0s5SWdoRXBrRUxLenpVaUtpWE9mY2lzcnRDWGJ1NDly?=
 =?utf-8?B?RHROZWlTSHpqZnFzTUtjY0swSUx5dHVwQmlReGhIOW1YK25OSGxJeUFNVWZG?=
 =?utf-8?B?OEl2Qmgxd0RMWEZTMkI3SlBpNW9YaFMrZ2lsRjZXRTNkSWI5UENwRmtMYXVy?=
 =?utf-8?B?b0hyb3JaeVFYZkludzBPamxxd01uWWhidWRWaUo0NS96VExHODFtNjJZM0lZ?=
 =?utf-8?B?bVZOSGRFYklCdmZvSjBMRm9rb2tJSU9ObWNBcjk5V2xqb3hHOW05a25UNFpW?=
 =?utf-8?B?OTErbXF2b3Z3VUJ5OWM1V3JXcUpVSjd4OEVkTXN3Z05CZnhsWHN5QnBhcHVS?=
 =?utf-8?B?clZHaXU1enc3ZXlhM1M1YmJaeVJROVRGM2YxZmU0elNiYnY3WGgyWHc5dkgw?=
 =?utf-8?B?ekFmOXRTYVYvZ2RoNHIvTG45ak9NR1hJTC9GWWZvcGhJUGVabDF0THU4Z1Bk?=
 =?utf-8?B?aFUyVlA3ZU1Xa2Fma0pXUmxhc0NQV2RCR3I5NmpwM1FtaVJ5b0Q2ZnJPZ09p?=
 =?utf-8?B?UkpGZFJxVGdCVzNoRlEwMGVVUlRjMXVubDh3ellQYTQ5eXBhSWYvVGNtaGNU?=
 =?utf-8?B?Sk9tdE1UVTdCNGF0Z2RCQVJhaHJKVEhNNC9RVkRHeDBBb2hzWGRBY09NMnpW?=
 =?utf-8?B?RUJhY2tIZ1JyNEMzNVMxdVpQdGl6cUh0K2JrTE16V1NGdWVQSzM0MVJONTNm?=
 =?utf-8?B?TUFTaHZLSXA1TVNJK1NLeFJvRTBoRnZMQ0s1cURJYzVvZEM5WGZjK2hTWGMx?=
 =?utf-8?B?dVVIS2wyVEFTNGJaaVFOSFlKVFdBTkY1UG1YckZoS3JVcGM1cnNnZUMwallO?=
 =?utf-8?B?RXVIUlgxc3lxbWRRQ2hVdHJTTFgrV3JmMFBJWXZhd1JreG5iSklnc3FlVXpq?=
 =?utf-8?B?WlNwZE5BYXVFNVdYTTBpNUlJbzYzNVNmQlpNUjU3TXEyLzVDckMzZTRSOTFj?=
 =?utf-8?B?RGd3UkIvYi8wY1Z4emdiNjJuLzNBdzl1S0JCUmdKV1dDajQ4Y3R4ZkRTWnZB?=
 =?utf-8?B?bVRwcnRvcTN3QkhkbHkwaVlieUFLdjZNazJaL3RCeWIzdlgrbXJGMXJFcE9E?=
 =?utf-8?B?WmxLWFJreWt0dFhqdmszQUthT0VvcU9WTk9yemlDMzlla2QvQTlBWmVueGhC?=
 =?utf-8?B?ZG8ybHJtN1IzMGVzTUJ6Q21wODkyQjM2ejE3UVFKNmZsWks4eWZnY0p0MlNP?=
 =?utf-8?B?VmptWWtLNzBLdThqaWl3NnJIQlZ0ZFBzK29MdUVoUjU3L0x2Uy93YnN2N2FL?=
 =?utf-8?B?QXh1MWFFb1I5NTBrSlVVQ0htUjhtL1J0MmRLNG5hQjNhV08xeXVxbGtWS0gz?=
 =?utf-8?B?MHpJZGlSWkNaODRHV1FNeGtPK2FvSjgydjRaNXpNdG5wWit3dXFsMzFLalFW?=
 =?utf-8?B?WkpRanJYWnFyc1FRNzJ4QVZ4QlI4amFzUmJKdzkrck9OUGZNSDFCWmdSTVp3?=
 =?utf-8?B?akJRT2EwYzVlMWdlamxONitSajZnQTRsblhKSUplVGZLbXFZSXlpQ2FwNTI5?=
 =?utf-8?B?d1NuNFRHdVdVZGNMdDVkcGpqRExVYk1WdlBmZ2cxOEk0UXBTcFdPbjU2VGdn?=
 =?utf-8?B?K0pkd0FzcVBBMDg0V2E1dzdDNlBTUzJOZmhjbEU5djYyVDE5eVZXUFdydjRt?=
 =?utf-8?B?TU9CaDFHUWpmZ2tudC94ZmtsYWtiMDRreG5KSWYzS25wVnV6d1BKVVNkdUF0?=
 =?utf-8?B?KzlMT2thWTFHUVNzNnByTVVBd1o3dUEvSzZ2NFE1UnF0OUtzK1JLK2JyRUdS?=
 =?utf-8?B?c1U0RlFqNnQzQ0U4bXQ2VHhkTWVlOVVmdE1LclV5N3FXVFZQZ3BTZWkzZVNT?=
 =?utf-8?Q?tt8C1WFEjehRoh9RrYNTo1Lxm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 211350b9-f4d7-465e-8da6-08dd58b5a9b0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 11:39:01.9033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Eds5ItDQq8X5EjWkm9tXxhnO41nguul0pYukOfy6PoWDKj1OY6zp9jVkldq4PiNu6434eHUXVZqXzDBYeFtsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6067
X-OriginatorOrg: intel.com

On 2025/2/28 23:32, Jason Gunthorpe wrote:
> On Wed, Feb 26, 2025 at 03:40:26AM -0800, Yi Liu wrote:
>> This introduces three APIs for device drivers to manage pasid attach/
>> replace/detach.
>>
>>      int iommufd_device_pasid_attach(struct iommufd_device *idev,
>> 				    ioasid_t pasid, u32 *pt_id);
>>      int iommufd_device_pasid_replace(struct iommufd_device *idev,
>> 				     ioasid_t pasid, u32 *pt_id);
>>      void iommufd_device_pasid_detach(struct iommufd_device *idev,
>> 				     ioasid_t pasid);
>>
>> The pasid operations share underlying attach/replace/detach infrastructure
>> with the device operations, but still have some different implications:
> 
> You don't want to just add a PASID to the existing APIs and keep with
> PASID=0 means no pasid?

do you mean extending the iommufd_device_attach/detach/replace() APIs to
support a @pasid? Sounds ok to me. VFIO side reuses ioctl for rid attach
and pasid attach as well.

>> @@ -136,6 +136,7 @@ void iommufd_device_destroy(struct iommufd_object *obj)
>>   	struct iommufd_device *idev =
>>   		container_of(obj, struct iommufd_device, obj);
>>   
>> +	WARN_ON(!xa_empty(&idev->pasid_hwpts));
> 
> Should this be in the igroup? That's what the core code does, so some
> of the protections you have here won't match the core's version if we
> ever see a multi-device pasid capable group.

conceptually, yes. But I had an impression that pasid is only supported on
singleton groups. Seems this does not stand since the SVA path dropped the
device count in below commit. If so, indeed iommufd should add pasid_array
per igroup.

https://lore.kernel.org/linux-iommu/20221031005917.45690-10-baolu.lu@linux.intel.com/

> 
>> +	if (pasid != IOMMU_NO_PASID && !hwpt->pasid_compat)
>> +		return -EINVAL;
> 
> This hunks could safely go in the prior patch adding the pasid_compat?

yes. And that patch can be renamed to be domains directing to pasid path
should be compat.

> 
>> @@ -417,6 +418,31 @@ iommufd_get_device(struct iommufd_ucmd *ucmd, u32 id)
>>   void iommufd_device_destroy(struct iommufd_object *obj);
>>   int iommufd_get_hw_info(struct iommufd_ucmd *ucmd);
>>   
>> +typedef struct iommufd_hw_pagetable *(*attach_fn)(
>> +			struct iommufd_device *idev, ioasid_t pasid,
>> +			struct iommufd_hw_pagetable *hwpt);
>> +
>> +int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
>> +			       struct iommufd_device *idev,
>> +			       ioasid_t pasid);
>> +void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
>> +				struct iommufd_device *idev,
>> +				ioasid_t pasid);
>> +int iommufd_hwpt_replace_device(struct iommufd_device *idev,
>> +				ioasid_t pasid,
>> +				struct iommufd_hw_pagetable *hwpt,
>> +				struct iommufd_hw_pagetable *old);
>> +
>> +int iommufd_device_change_pt(struct iommufd_device *idev, ioasid_t pasid,
>> +			     u32 *pt_id, attach_fn do_attach);
>> +
>> +struct iommufd_hw_pagetable *
>> +iommufd_device_pasid_do_attach(struct iommufd_device *idev, ioasid_t pasid,
>> +			       struct iommufd_hw_pagetable *hwpt);
>> +struct iommufd_hw_pagetable *
>> +iommufd_device_pasid_do_replace(struct iommufd_device *idev, ioasid_t pasid,
>> +				struct iommufd_hw_pagetable *hwpt);
> 
> Ugh is there going to be alot of stuf fin the pasid.c? Maybe it is
> easier to just leave the new functions in device.

If your suggestion is to add @pasid to existing attach/detach/replace APIs,
put the new functions in device.c sounds good.

> 
>> +struct iommufd_hw_pagetable *
>> +iommufd_device_pasid_do_attach(struct iommufd_device *idev, ioasid_t pasid,
>> +			       struct iommufd_hw_pagetable *hwpt)
>> +{
>> +	void *curr;
>> +	int rc;
>> +
>> +	mutex_lock(&idev->igroup->lock);
>> +	curr = xa_cmpxchg(&idev->pasid_hwpts, pasid, NULL, hwpt, GFP_KERNEL);
>> +	if (curr) {
> 
> I guess you could do the same trick you wanted in the core where the
> xarray in the group stores the normal domain too, then I think these
> special functions just go away since the xa tests are folded into the
> normal functions in place of their normal domain tests?

do you mean storing the igroup->hwpt in the xarray?

-- 
Regards,
Yi Liu
