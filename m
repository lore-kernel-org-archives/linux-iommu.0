Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08802066EF
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293203; cv=fail; b=KcEssU5u0ahyh9jDaAKyY1YStpciOA+XKdVEH+VT2QKpB6+RisYX4Ys/UcDVlGDPlEATBC0FijokfM4HNuWp6P0RJEPQZoBpjSXEUQDe5HV223OCbbHW/2CCNmYSZOp25bHfCXlh6KzhG+TdGrgX1IyyxQtxwJB9w/YICIEBj9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293203; c=relaxed/simple;
	bh=tMdhDE6qI+UiYRzckWcZ3WRqPC87Md1PY7ewa97Lcng=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=taXCE6fFr5RF1t/Erz44WHYjW9zFPbFM6b4XGgSHGn0jbyYAtHqZ1pGuRkxTaD4KmgUrPT96vbQWECHKjAsg0qEkPyNEUoXXv6N2+rAB9qhqpoqosXk6O+uELTfPkCQduOczbZJz/M4yHLdvAv7Fgvdz6UdadZUlP9V8ks0lKSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LlkN1hXw; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LlkN1hXw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742293198; x=1773829198;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tMdhDE6qI+UiYRzckWcZ3WRqPC87Md1PY7ewa97Lcng=;
  b=LlkN1hXwmV8ecEQmfaq+1vZrEYnuKB6xZwLQy4NEEZ68dkE+5Txt1Rlr
   oyeVbeLyyQ0T4RnWa1p+xCMnnf6HXgMmXn5fZFQAiasFsgndiGSd442e5
   EEspJHx877UiuI+6JfJjpexkpabAd5MDXcfr6NGA6B2RuDkVQe72tRBO4
   y9PKVAWJGjRw/qc77J2LkE9jCacALp3YI7CKz83ddWfnTlHkHtoh213hw
   T/KIAINhdH3v8Vh76gjtGrORaHAdS0L5uvZU1Z7Et+dwmix0wZ26uUCXW
   GSfqNa7SeJRe7O4DpdsfOfJae2amH+xojN6jgWc+904zyzxR9Hq75mPnY
   w==;
X-CSE-ConnectionGUID: vmc9R1/CTy+y4lWQZElZVw==
X-CSE-MsgGUID: R+PzPb2LQtiVfnNZuT5TqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="42601358"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="42601358"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 03:19:58 -0700
X-CSE-ConnectionGUID: ENlA1ZbkT7yxM4JqgepoRA==
X-CSE-MsgGUID: JmFOP+0FROOL5pqS6S31tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="127316485"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2025 03:19:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Mar 2025 03:19:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 03:19:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 03:19:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDdLgdp5RqTFdw3aJeMSYRf1kUP0VjOhKK5goLdMZD/aQTvz57ImHOXg9sI9Ylra2/WhIdgWo4Y+sDE+1GmNBB5K1NWgmeZrDe+KMK0C7+0d55gdgS4p8T+1rlM2KoQ4T93e+Hrcw1TI3dNiVGNU2aZvRan3C5LtvxgXaglO2Pkz/uubMaK52et+k7wOcFhPCeUBxunBbMRQIeOAz+KPfu3izmsHEUm+zJWsS+NRyWEN6Om4Auj8klddFKG949buoxRxqu9N1HAGTgZc0WuEj8WkfoQb8an9UpSBvcX/0z2BzQLibnTmNXy2xdctJaUv7lGyQdkDwORvaKHAL7HTKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tauw6pPoEBT2Dimw/np0FQdsYgJM5yccTv24ACXmTIM=;
 b=XBImhjBBlf6m5Y3sKPJmq/z+FgCJriM+aFzaBbbo1uxOgEUjgfQHWVpPnaaRvnN+gClOdc1LbmuqOirexUohUCyT9PB/v19rQo6MESE5Y2lJMLegXG9d9mRwUCgekov9pm1lB204zUUkoF2/d7wRO3FpAxxXvC2A5Lfl7M8vDPKVNooT5hhUtQITAD17MDjjkGlELpOiOvajh3+UezkvjylVXZWRJTwVLs9u9zowrwb36iq4jTwTbInLqD+0xjBOFJSrNYWqRPT/6hqRxJ5MM/KvqourmlvJ8ri3M+jPyT6Cq0KyMyd5uIis0CPBK08JMk1O172T2UR2bGwLmiVGLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA1PR11MB6896.namprd11.prod.outlook.com (2603:10b6:806:2bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 10:19:49 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 10:19:49 +0000
Message-ID: <04f59a31-f81c-4915-9558-0e3abc647d64@intel.com>
Date: Tue, 18 Mar 2025 18:25:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] iommufd/selftest: Put iopf enablement in domain
 attach path
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, "Fenghua
 Yu" <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, Zhou Wang
	<wangzhou1@hisilicon.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
 <20250313051953.4064532-5-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250313051953.4064532-5-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR0401CA0009.apcprd04.prod.outlook.com
 (2603:1096:820:f::14) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA1PR11MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: c1468483-f59f-4349-d0ed-08dd660669f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzdpcHAwRitlY0VhR1VGRkJ2WVhQVXRoTjVZRWxFNEdHcmlreDN4dk40MTNI?=
 =?utf-8?B?WlJxRHp3ZVh2Z2daazFCUHZxN1NjNXN6QmlnYjlEcWlnQ0wvOU42a251L1Ux?=
 =?utf-8?B?Tm5xYXVwMzJEZWNGQysxeXoyMmJDVllwRDNGMGZ5em9DdVk5UlFSMlVoSVp2?=
 =?utf-8?B?b2RHSW5aM21LM0VyV2VRUTZXaHVKUGxVSzdmTzhNRE5saTJBQ2ZvTGgxdmVO?=
 =?utf-8?B?L3dxZzdWWGs3V08rTVZaeFhuYU1UaW5SYk1vL242RGU2dEI0REVTazFUak1i?=
 =?utf-8?B?ZTRFa2RWZlEzUEk4UW43TUVuZTd0Y1VlOFhZVnRsdHlQMTJxRUYxbENqU1BS?=
 =?utf-8?B?TStoQ2RWZVJLZ0VwQnVmanBjc1BwN2dlVXY0UDJoRGozNTFnQjQvQjI2RkNj?=
 =?utf-8?B?d1cwZEVBeHlnRy8xTzR5eDZaVk9GRkl1UTlCajQ2WSs2dFVRcFVyNHM4dWhw?=
 =?utf-8?B?ZGczWnNNUzRnZVJZYUtNSnNnM1RsQXNFaVZ4QXpxYk51dDN6NENYOVJmMlJx?=
 =?utf-8?B?T2ZkYkx0YjdVZm5lTFU5NGtNZkpsMzVaZmEzZVJvM0FaN3gvc0M4UE1sYmlj?=
 =?utf-8?B?MmN5Q0tReEFTc29MN2FmQkRtaXRGc0tjcEw5WHVTRGc2OEhnL2lqVTF2UVJO?=
 =?utf-8?B?V0RscDZsRnJ5QWZDU1pIZzVBc0ZseW1neUZmQURaTEZ0MzhRMGx3cXhmM1Bu?=
 =?utf-8?B?T3E3SW5VY0dMRktPdENyVTFCSE03cFFReVpibGZjNU93TGR0QkppRS9sSGFG?=
 =?utf-8?B?MHdEK0twT1dQdmVzRzRIVnRMNDBmWXYxVmp5YnNia2dFanBZL0VnMmNJUkVT?=
 =?utf-8?B?TXRlL2hkaG1ucHAvSE05QjhSdTZiMHJTY1B1WVdPaVN5NWFIV044a0ZiY1l1?=
 =?utf-8?B?TnRKdlhGNkZQb252QmkzTEthWnpQMmdDaHJFRHhwdi9tQ2p6WWRvYW0wTnF6?=
 =?utf-8?B?Qm9UN20rMkhqUWZTaURWRFpKTU8vMXl4SnlKZ2hSMUNpcGYwUVhSQVNhSEJ4?=
 =?utf-8?B?bFBVaWFXdXJncWhGNUt4MHMvSXYySmtudjJpUm9NMXNUWWF0dDY4U0hoWGRU?=
 =?utf-8?B?UGZLdG5na0hWMkdlbCtYMGxjODlrRFJDUzhxVlpkSEg4OVhubWtXTnhrYmRq?=
 =?utf-8?B?V1Q1MnBVLzFIWU00NjRUWGtRaW9yZUtBSndHdFFhSVpidnJPUWFRUXRUa3pw?=
 =?utf-8?B?RzJzclhPUGwvOXU3TUNSTDVBakRjU09ZWU1mTFVLL1FCMVUwYjlsdVJya3Vi?=
 =?utf-8?B?VG04WWVVSE94VEEvZmxZYUV1YlNSc0RadnRBbEhPSHFZb1NGUDFmKzhHS0dI?=
 =?utf-8?B?RUM5WUFNei9taUJtUWtOWEFsbzV1dXJXL0RlOWFWUnlGMkw1MzE4V2lBaFNK?=
 =?utf-8?B?SEt3M1k2MTBOVUtrSGJHWUNGWi8za0hXMWVYSVBqR0JQVXJ5Z0hBa3ExcE50?=
 =?utf-8?B?S21ESDZ4RVllckVGa0xCc3lxeDYyMFYvWFNnUFgybnJWbzVQb3FGdFUvOXZC?=
 =?utf-8?B?NnZ2Q0ZMRVcrcjlZSnR2K3FSQWthWkMrWG53VU4zK0d0amFYVGlXMU9ONHNV?=
 =?utf-8?B?WG9ab2xyTmtlcitMdTE2UkxETy95K2l6ZXVqSEdmelVIWDc5S2kyeE1QbDhk?=
 =?utf-8?B?dld0YytoVzRHenBrWGZHSXFzT3MrbUd6T3VFY0VRVkxkRlNyU2I2WlJyeWtx?=
 =?utf-8?B?ZExJTjQxSEkxWUlza3ZGeXJlV2ExeE1EcGIvOTRjTG9KWWtvV3lMNGg3cDF2?=
 =?utf-8?B?ejlPeVY1RkhPaWx1NDNqbWdZTTNvQmxQekw2aXRiT0xRb2FRZHcwKzRZUVpv?=
 =?utf-8?B?V1pDSGdOTGJpTHcvTHZ0anFTUUtOYTZLazFtYURBOGZ1NEdkY2tNNlp3S2lC?=
 =?utf-8?Q?wUSAaLJ1TLYt0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVJ1Z01XMDlsQW5HNU9WbUNzaFBGVnhaNXVJTjdjNlRrSTFxaVlLS2VvYkRY?=
 =?utf-8?B?Ky9yWG5IVi9UQjZxd1MwVVNwZkZSekhkcFZwQWtuOVdpQmxUbndvNDhxNDE0?=
 =?utf-8?B?eDBWc013dk12SjJQd3RkREhFRWF3YVc2OVF5eDRiZE5La1d2VkFESjgyN0Jh?=
 =?utf-8?B?WFVkeEZ5NlFUQ29EcTdSU1cxQUhqOWtKajI1N1FnUmN5a3VqWmNTQ3BGOHJ0?=
 =?utf-8?B?TUkwY042T3B6UDNJSW1lak42ZDRuNWhBSWxNQk1ydWxaSlR1TDlsczhtK2F2?=
 =?utf-8?B?d2N4eFptR1hxelM0MFZ5OHBuYmxsR1phbGF1a0R2WTlNeHN6emxGVFFybHNi?=
 =?utf-8?B?Z0s5U3VSZ291UlFjYVlIREdzSS93Rm5xa1VhZExVcnRxaGU1QitEZ0FBRzF1?=
 =?utf-8?B?amVuV2x2amt5NFNzS2JSSmEycVJFK3JRdGVMRUxWVlBzbVZ5MXRWUGM4QjZI?=
 =?utf-8?B?ZXRMZkpXelJYSC9SN05FVWErY0RYRTZnQklNUUdlVWtidWV0aVNVRlRNaFM2?=
 =?utf-8?B?VXBqMlF1ZFJHcXY0L0xsNEFQamtUOU5PY0U5VzQzRXpha05WbEdrajNXcktE?=
 =?utf-8?B?T2FIOFRCYzZhNFVJWmc4aU1TK1Q4RjNuOEJzUnhJbHM5dnlPb05iTXlsclpF?=
 =?utf-8?B?ZkhrVEYrdUlYdXNPMmVNcXhkbTh5NXFncXRrUWtYV0xvTmdFd0NheXZIeDhB?=
 =?utf-8?B?QTlMK0NLT0R6RWNCT2ZTSDBiUVJLWkRSN2t0WTBNU2xBV0VCekhLdkNmMUdS?=
 =?utf-8?B?TmJ5eis2QlZSbFdHYi9SZFhSWEErdWVsOG0xZWt6VWpnR3hzOU9icnhZN1U5?=
 =?utf-8?B?MEVzOWthaEh6eFRMd2dPTVhzeENqMzY5d3BIbXpBT0EwaHdpY3Y4VTZlc2V1?=
 =?utf-8?B?T3BHZmpzWCtTRGhQeld6VTdCZkFLKzRpMUpWREFKVVk4WHRTMGVGWFV1NjNH?=
 =?utf-8?B?eFVrZ0c0THVYNWNEZms0VXNJdFdqeTZYYVhtQ044YmxES2xJSEZuci9TamdF?=
 =?utf-8?B?UHhmRXVuLzk4Z2o2TUg2VkFkZ3ZucE5ERkpmQlBjeUQ2b1A0MDBCZGQ3ZmpL?=
 =?utf-8?B?L2ZrNkxoeVFtRXNERUpzQmtRQ2ZvQ2VzcUVHZ1VLZE04dlF1RFpsUjlOUXd4?=
 =?utf-8?B?WGFqa1RkeFNaQTZMK2c4YlRGMzVpdEVyMmtNWVJNUWgrb0lSUURWUVl1TjBt?=
 =?utf-8?B?RkhmcWxZUU41dUJOTFZBakwvbnJqeVZUUE1WRU5zUDdpTHd3N2dOcm1wRG5G?=
 =?utf-8?B?WjdsTm9JN1dFUnZQYUVxczNGampSNHFSNGdnNnZOejZ0Q1MvcU54R1NUd1R2?=
 =?utf-8?B?QTlDZExMRGVhOWpIazg3SDZSRU1mRDNienY4bU1hOWs5RnFpd2JhcThVcXBL?=
 =?utf-8?B?Z2JWSWpNTlY2eTZydjVsNllQbk8vTk9iaHVKN05RUnZwYmRHT2Y4VkY2WEtH?=
 =?utf-8?B?RWRTNU93aTRkOUJzOWx6ZDJNaXZvWWRCMXlKZitMajZ6aUFGY2FQWlIwOEJu?=
 =?utf-8?B?dkxBaDQydnlENUh6dnlralBIdnRnYUJSSzFlT2g1V1JvR0ExVVcxSFdhK0tk?=
 =?utf-8?B?ajJ6dzg3L3NJb0QzOHRhcGg1N2Zsc3c0UXpZbnduaEV3ZEFUYzhmazdSL0oy?=
 =?utf-8?B?Ukd2V0FNd21BTGM0N1ExRzVwbjltTHBURGJpMWRQZVdzb01tT3FML25oL2dt?=
 =?utf-8?B?Skd1cDcwZ2NpdnR2UGl5cVB0ZlkvMDQzd0JNNzFnQWRnRTk2cGFVMnFXalVk?=
 =?utf-8?B?ZFF5NUdYZmpHaEVLM1h2QlpNWkt4SzJReEllQTV3UHk0UCtoSWVyM0lZTi9K?=
 =?utf-8?B?UGFBZmtzc0tRRGtlVGxSaVpwSzVnaTdXWG5wTTI2cEJRd3dYOW1md2FTWXJO?=
 =?utf-8?B?V29jek0zbm84dGNqRHFwbXI3RTZKRFN5M1lZY1FrdWlreFZmK0ZRd3p2YlFq?=
 =?utf-8?B?Szk2cG1RTzBQL0lISStnTWxPRHRpaEZndlo5T214c0o2d2J1Zmw3cDdmbmpq?=
 =?utf-8?B?aE9mVkthakxWS2xhRlE0V3YvWlZYN1NUekxmbFdmdnRhTFlLeEc4UUNrRFBj?=
 =?utf-8?B?OFJnNktDVFB0Y00rU3RGTnc3SXZ3ZVBTcXduVklQb2JHVXdOS0pDSlpSQThV?=
 =?utf-8?Q?AwNZsgRcVI3Ri0UZR7nk5hqKj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1468483-f59f-4349-d0ed-08dd660669f2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 10:19:49.3342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emC3++t0zZhVlnwyZ6r7VRGgMb73QSpg2GShY5RXFirvMur2B7E4Zga0DExTbiyhS6EkWBSwDmwcnL6ZkJmEOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6896
X-OriginatorOrg: intel.com

On 2025/3/13 13:19, Lu Baolu wrote:
> Update iopf enablement in the iommufd mock device driver to use the new
> method, similar to the arm-smmu-v3 driver. Enable iopf support when any
> domain with an iopf_handler is attached, and disable it when the domain
> is removed.
> 
> Add a refcount in the mock device state structure to keep track of the
> number of domains set to the device and PASIDs that require iopf.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>   drivers/iommu/iommufd/selftest.c | 64 ++++++++++++++++++++++++++------
>   1 file changed, 53 insertions(+), 11 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

Regards,
Yi Liu
