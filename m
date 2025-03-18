Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E149820DD64
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306942; cv=fail; b=AZxZm+RKQyMKXanjmxAiY01O4a5yoXbr+XZLi7PpCULkHrAAxiVnJutz/yoHOvnHYJgH3jej2l36FGXkmHgbzXklasg5lF+JaNdtxcfzBTkzNnwlIVCnKdaIgOb06IVz+2A2NmRjH60IaBGxtdDySt+b8KcePJKbpqKzC6Y9pVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306942; c=relaxed/simple;
	bh=j8ReeqRqms9CrzUhEYPkNpMfFxVgZkiWpjfL9CQfytw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mbv0Ux9GhPEkQ+FN661Bg9m+AynId4jA9Mv2iJOOhPPZm2R0zPi4GwkBjSvMIW78Kru5w688xK89D7rJCf8u3DzjWN0+9wznxknGGH/W8quFiOOZFasNMniKLZ8sSvrrzh/552xM41P/Y170NuyDTLqV75SGzYKIJC3S2vGlF8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nSGsfY1r; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSGsfY1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742306941; x=1773842941;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j8ReeqRqms9CrzUhEYPkNpMfFxVgZkiWpjfL9CQfytw=;
  b=nSGsfY1rYYAkC9qOADLXZ8hRxYqgZigmR/VNxo4Xlm9HJ3s+s+kDb4ia
   PSRboTStvR3i38Xrsya08mwuxmgkwhIRRK/tDaaUrB+a+Fx/CPYdZA48O
   nlwP3RUOH7b/9qIpdubPJkB9OIzh0I5GXr4MF4SOL51RZ07bumwBtKfaC
   CO7C7zxJDrrJhAfannfERc7+dFotAK4mrWARAjzxmAeMCyRWVM+wJnLkk
   YfAWoWKV6ilEvNjzeYpOwcNInNaYcdhCnSD55uCFM+O78QonbV0PxPzoO
   kcHJxjTVZnWqPOcend6Ly6wEjQNNtS46D11hf0jK8PsLAV2uoAQD9k6zy
   g==;
X-CSE-ConnectionGUID: LJhxb0yMQQObPcWaDag4mA==
X-CSE-MsgGUID: w3xq3nkYQq2LVqo3WvQnow==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="68799536"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="68799536"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 07:09:00 -0700
X-CSE-ConnectionGUID: 53AQTbuYQf6xNQZgUvQyng==
X-CSE-MsgGUID: bp/MM42iS96AhTiwWPoNsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="122100059"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2025 07:09:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Mar 2025 07:08:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 07:08:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 07:08:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cdz6WyyzvLBuL8hU5IYDjdGM38rVcRxiFokY7aEf4AK/vx28gutT5KgrtMPWdRXVIRaLprgljRWf0ft5K50odG9up7sKSYKmw+kZp8ptp/sv1K76ExPUON1lgsDc+kp1L9Cas0cQ2Hlk5K/cH4+7F+WU6MxtiqbJlccBjF1rG4CgqsOyblv0i28eV7+m9zdlFI47H+6ewD4NJOfpFA3Gi4urM2atlMglTWEiFJU9wscCD0FQsUvUsvAdUpSGDHUadq6L5mtw/+gp930gvepX3RWsxJWwcMcsXFXMsHw5M25+tx5M5QDxkJRjgeTBNezsHJ0+gj3UpIlSqTuAW76v3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6C2LylCr/QToXRwOQol1XLix2Zujx0Obr/ZxDKvZdw=;
 b=kqF9JZDsSWVeJCjUgJxvki4TGMeg4azmnZFgbhNhNYHc09BBfEd5WJXuEHZmA7hgpRCbDrKlNCTSSfj6esYVxo6XlRJZVvF51yZfV/4Sl9aDQR4ksCRSxB+9dNf9j/PACEXNTatIsZNhmLx3L0PcIr4+cmzVntKpH2zsJwXd7nlSwoXhG2ARFEue2PM/SvJBDrEa3Y5I+VaAjgOju2hvcLmMLbfaNrTkwJ7nidQf3A2cQCQnkjH957SoutvqKZbqSAjPOtJ3+3Muxr+BvPZmfMD32dbteqY2+c7cm/mF/Xm3xUYa5mrUFXhQgQKliQ3sOmnjAnnl/bf1oHB5FvSRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CO1PR11MB4836.namprd11.prod.outlook.com (2603:10b6:303:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 14:08:13 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 14:08:13 +0000
Message-ID: <04b75a34-04cd-40ec-854a-c1a3f0a153c9@intel.com>
Date: Tue, 18 Mar 2025 22:13:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/21] iommufd/device: Move attached device tracking to
 handle
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <joro@8bytes.org>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <nicolinc@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-12-yi.l.liu@intel.com>
 <20250318123406.GJ9311@nvidia.com>
 <bafc2cdb-fea5-445b-a7a0-5a1fb390e3f3@intel.com>
 <20250318132652.GS9311@nvidia.com>
 <86c4cba9-5e50-4886-8253-0829e7620a85@intel.com>
 <20250318135609.GU9311@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250318135609.GU9311@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CO1PR11MB4836:EE_
X-MS-Office365-Filtering-Correlation-Id: 20eff24e-babb-4b54-fc7d-08dd66265260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUJoS0Y5N2hkTDU1cDZRT3d4MEUyRWF4VjNBbmlZbkZaNEZuOE5FbW01TFJJ?=
 =?utf-8?B?N0ErUXYxbUZiZDV3VDh3WnAyZUhpRHAvRDNmOVlvSkdtUWhiVXBkOWZQWVZw?=
 =?utf-8?B?YS9PVjIvRUNNWG85d1FsRFg0a0dqOEoya3VwblR2ZmV5MFc0TUdDdlVJSkZV?=
 =?utf-8?B?enprcGVZb1dKSCtuVWNPQlhTeE5hUS9rTW9IdHVVWC9jMDBEdjVVQkh2MlNN?=
 =?utf-8?B?cGdOWi80eUZYT2s3ZnBSeXZFc2x6WXBXT0RGS0ppZExMMExsNTR1djZpQTJo?=
 =?utf-8?B?VTdqbnQwVnQrUHlKRTA0cElXZWlObW1UWjdWSmRIZFpSa3hkbUFMc05mbzQr?=
 =?utf-8?B?OWxVL0UwYmV1NENzMDRjN3ordmFRZUtTbGRXcDA2TWhySURidVRMbmJqeEhS?=
 =?utf-8?B?RnpQcTc2Y2J2c00xcDdhelMybDhLOWFSU3c1OE1kZWY1byt1QzdhSW1uUDJq?=
 =?utf-8?B?czJVSE5NRTAwdFkyV24vQnRaS0Jyd2NTeUV3V2VuelJVQlBLcXV4Zmk2dGJk?=
 =?utf-8?B?RUhzVFdVcHZkNGN3OXozN1RSSitTTE9ucEVxQU9raUNybng3RmdwMUJ4bnF2?=
 =?utf-8?B?UHlmdG1qbWpKam9pK2MxTnZFVTJtUTVMdWhYbmtseUxrSW5HdCtTWStUOGww?=
 =?utf-8?B?RlhzaVJueHJjK2YvVHBWSCtHRytqa05YUWU1YTNhRWtubHFtUmR0SEJiT0sv?=
 =?utf-8?B?aERLRUs3TGJVOXg3YVRiZDVuS0dkRWcwYzh0b0N2aFF1NnpIWnR1eWhwbG8v?=
 =?utf-8?B?YWFyTUt2YXBmTHQ1Sm9BSFFEUCtXTno1dk1qZVRNcHZ2SEgvMzZBdHk3b05a?=
 =?utf-8?B?WWlUdFN1SzQxT0VuNDdvSXpZMmhMSCtQSTFFaXNDUGh0NWRaUTVNWXlzTTVM?=
 =?utf-8?B?YUcvK0gyOVZSWllwUDdBSkFybG82ODBZZEFyOGZQVmNqckdxUmg5ZDNvRXZh?=
 =?utf-8?B?MmErbmlXU1IzMk5ubkE3UWF3cWswcWQxbWRPTVlSN0ZtcjZIaFRTUSs1STNB?=
 =?utf-8?B?SmRrV0NOR3BMLzY0ZGpaV0JXRk1mT2R4Y1JMQmVuTTd6S1EwTWMyVXJKZW9O?=
 =?utf-8?B?SkoyYnBJbjgreUdOYUJMT1M5UGpKVW9HR1JDbVFGVnhEVXdUUXpRRWR1eFZB?=
 =?utf-8?B?c0RCUWZINWVMT29FSGNWaHBXd3ZUb3BNSm5IVlFHUkZjVUowZW9jdDVGZkgw?=
 =?utf-8?B?cFBuWDdvOWVzeDA5eU1MUkpPaXprcDVXaFFuczVCeU5DM3RJczk1OTdZSW91?=
 =?utf-8?B?MUpVQXJ3ck5lTTI3Mjl2cUw3VlpFUEp3Z3VQem02cWJTSzQvSk5NMld3VkJL?=
 =?utf-8?B?OUZnZ1VxaUNTVkhqT1BiZVVrdkk1dU9tL3VDdTlBYmJEcW5tb3F5YitIa2J6?=
 =?utf-8?B?RVprMVVUeE03a09DTHd1WUdjS2JJTEcyMlpISkRjZ3hLQ0hCOVdsbHMzclJW?=
 =?utf-8?B?a0hlcTQrTXQ1WWhsQ2VIRXpQMHJHV29ldVlIeHFoc3R3VDJTYkZLakR0WDZj?=
 =?utf-8?B?V3lqcGlRNkhHY0liL0p6Ym9TS0h4REZoLzh1OGVNd0YvTStnS1F3c29wanVV?=
 =?utf-8?B?N0RDSnpQU2xhMis1TDBOWGRyU0lrNDZ5Um1MQUJpbS9Cd3VwalI2a0VTM0xB?=
 =?utf-8?B?ZnRZNHY2anNqbXVvbWhBOWxQM2JDYkVBS2M1YkpQem0vSEtNUlJneFNGd21B?=
 =?utf-8?B?NDI4cHR4S0t1YnZKWGZMSkdyaEtzM04yakh0VnB4OTZpZzdxK1N6YzVhNlEz?=
 =?utf-8?B?NnQ0cisyTTFsL0ZmWmZMUXZUZlZDRE15Qyt0ckx3OWQ0NkZ2c3F4S09ISG5S?=
 =?utf-8?B?eExza2NtZkhuaFdxSEUyMTJHampCSEYrbVhXNVFmVXozeXVIdzlSUkJyWWx5?=
 =?utf-8?Q?BuZU2HMtvJTLO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG5mMGZsQThUbnIrZWc4YWFXS3dLVjlkZ3ptNmYyenZrTmFrY1NHMDd4anow?=
 =?utf-8?B?NEpWcnE4T1dyRlYrMWoxZzNqcG5ON092OGFjTVYvS1pZSmx4RE1LUXFmMDQv?=
 =?utf-8?B?T2NLTEtSQWdwWE9tTXYxK1pTWlQ5VDRkaUlyeUhZYUVGQWs4aE9OYTExNHd4?=
 =?utf-8?B?Snl4NGQ5ZXViWnNVdVYwd2xMUVNUMDdmTjFaYnphMXpxdnNCa0VDd08vRUc2?=
 =?utf-8?B?Y2prclZzTG0xQ0xwd012RWlyVy9wQk1ZVERrZm5uaEhjdnBCc0JYVm5XbUIw?=
 =?utf-8?B?T20wdGZjdjdjc3d6cXBmcVQ4eWptOElYNVF4WGJCUHZ4aHFKZ0hlN2xmYWlk?=
 =?utf-8?B?QkVCWDdRTmhwVFBYUkordmJNdUpwbW9mQ2JrdjdQc2FlbzJhWUFxVkVsWldS?=
 =?utf-8?B?UXhXaEt2VmZLTmI4ZTRpUTkrb1FOcDhnaG43eW84LzBOcFlXRGRDK1NOZk9V?=
 =?utf-8?B?cWRCbnFYRmU2aE5DZ09VeTVUdW16Wk03UEdNZk9SZG0ra3RHUk9SR0lvOWs4?=
 =?utf-8?B?ZlROc211R2tsekdka0VCMHNEUzRSMGJ5UUpDckE5KzFiTkdNbzY1OW84aURO?=
 =?utf-8?B?dGdKQ0pQMHdmQkMrQjNDdEdSVVFZZXN2SXZaSW1tNlNQbzR4Ums3cmFTWWNv?=
 =?utf-8?B?dC9qVHR1bTljd240MEdSOER5UDVCeVFwQk1FWUNxRTJWU3I2U2VKam0zcW1m?=
 =?utf-8?B?OVFDbFZPanRWcVdReXJXNmhibmVXaXhtNGFvYmt4QS9oNjVFQUZNUkJCaTRk?=
 =?utf-8?B?UElKa2dqMTdaV3d1TG9MSXFIWXNaQk5sZjB5TkRLL0JZTVNMdVU0UmNiMTZk?=
 =?utf-8?B?cElxM0dtUkVQbzMwMDJaV3pwT09yUzBKd2grQzBjeVg2L1pRT3plU1RsTFNq?=
 =?utf-8?B?SWwzdDZBbTlQUVlQcTc0UWhHQkVzVyt3anZCYnpFc3BWVDhLR2dnWndTZ3lI?=
 =?utf-8?B?YldMenZIa0E1SmxIL3RFa2hwa3ZzM1FUb251SlhIb1dobG15SmZiN0JzbVQr?=
 =?utf-8?B?ZWNET21VK2s1OVlNY2RFUGR0c2FYb2VMRlA2aVF2anhkbVduc2kxSitCeXhl?=
 =?utf-8?B?VzZOclJoaW9Tak84bkJGeVQrRURua21NMDl2UHozVDdDME5rMkk1dy8vMGd3?=
 =?utf-8?B?dU10eFkyNkxGV2pjckwvQ3VDelBGdEk2dkJiZE81ZU5JUHloL05DcGMxaU1y?=
 =?utf-8?B?QVdTYnA0UnRILy9PZUZjU1QweVVkK3N2aWNBbm5DZDk1N0ltWDNqYStJZU9J?=
 =?utf-8?B?NlBoUzFYMVE0TDBDM0JJRWMwSjdnbEZ6WDNNeWRoOVFRajlyZHcyUzZmNmxl?=
 =?utf-8?B?c2duN01GUXlDV0p6UFlGWHlNWGFrK0d3cXUzbncrZHRMQjVwb1R3K09CRnJ1?=
 =?utf-8?B?VWYxR2t6Q2VuOC96bmhOcGQxcS9wVENYVEUvelV4aVBTWWJITEhMRnVqdWV2?=
 =?utf-8?B?c241aVBqSHVTL09VUi9uL0Z4UTRyVlN3TjBTUnJJZ3RyUnovSTZpSlVEc0pQ?=
 =?utf-8?B?cld4QSt2S0xrQjFpdVFlaWpPb0EwU0ZPbUd2bDdFS005ekNqZlE1ckZYQzV2?=
 =?utf-8?B?aUFIb0NqaXZRTWhZdjUrTUt0VVF3WEMwb0EyMXlJUWtyY1VrVWxpcHF6cHpk?=
 =?utf-8?B?M3RwcWlPT3N6cmN2NE41Q2tWYy9EMWlYdlduRTJnZVhIT212TVZrVnNYRVN4?=
 =?utf-8?B?YTFrVjdhd3UzcVpXVUJBRzlBRGxwRjUvOVRldWRmVGl0d0ZIMnlwR0tacTR0?=
 =?utf-8?B?NzhVdmNnWXhiM1FzeEtPcVkxNmYzVXV0QWlRYzZObm5jdFBpVm1LSXpUdWUv?=
 =?utf-8?B?WTN3ZTR6V0tRbWhlYi9jandCVi9ROWc2Nk9IQ1V6SE8rMWRDTGlsbWlxdGR6?=
 =?utf-8?B?aVExcGpzQlFWTEI1NmthRllqcVdXK0Y2MVF0clpjMHJPVVpjRCswME5MR3Vr?=
 =?utf-8?B?WHlsL0ttdkVhUmxXMlI2MU5FdjQ4amtxclFwLzlGT0VrMFV5aEw4UUNSOGdF?=
 =?utf-8?B?ZUVLOUdCcnpaMStjZEs2V1VYNzNIWjBCYm9KeFFoWjRNNGJpczNtejdtV0tl?=
 =?utf-8?B?d0c3emREd3RucHJBR0x4aURMQnN6WHF3aWFFa0c1NlRCZ09JVHRvdVA3WnVh?=
 =?utf-8?Q?kM1qqWxmh3oD6VUSdgkN6cHpK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20eff24e-babb-4b54-fc7d-08dd66265260
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 14:08:13.6581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEhTUMBx3TU8xskFQVVwaIY0wH3714kSLwTH49oKP7a9rVL7QUCd5fPphHwizGh0nUKDfGdLMgXr8Hz2vU3aTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4836
X-OriginatorOrg: intel.com

On 2025/3/18 21:56, Jason Gunthorpe wrote:
> On Tue, Mar 18, 2025 at 09:50:12PM +0800, Yi Liu wrote:
>> On 2025/3/18 21:26, Jason Gunthorpe wrote:
>>> On Tue, Mar 18, 2025 at 09:25:56PM +0800, Yi Liu wrote:
>>>>>      	struct iommufd_attach_handle *handle;
>>>>> 	struct xarray device_array;
>>>>> };
>>>>>
>>>>> ?
>>>>>
>>>>> I think I'd just accept the additional allocation and not try to make
>>>>> handle re-usable. Every unique attach gets a unique handle allocation.
>>>>
>>>> If so, we also need to loop the device_array and add the attached devices
>>>> to the new device_array of the new handle.
>>>
>>> Why? Just don't use the handle for that, as above, the handle is still
>>> a pointer that you allocate, and this pasid_enty is another pointer
>>> that is allocated once.
>>
>> I see. How about making a new structure dedicate for tracking attached hwpt
>> and device_array? Like the below. Reusing iommufd_attach_handle structure
>> is not mandatory.
>>
>> struct iommufd_attach {
>>   	struct iommufd_hw_pagetable *hwpt;
>> 	struct xarray device_array;
>> };
> 
> Yeah, something like that would make sense. Then the handle is
> allocated uniquely for every attach.

yes, just keep it as it is today.

> I'd also add info to the kdoc's that handle should not be reused as
> part of the API requirement.

yes. Maybe we can check the stored handle and new handle to fail the same
handle case. I suppose the attach path is fine if reusing handle since
the detach path should fence it.
Regards,
Yi Liu
