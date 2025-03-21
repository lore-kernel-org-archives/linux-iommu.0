Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9896D101C8
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 00:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742517384; cv=fail; b=hBAotI75yoKObN5C72hXPml3ZK3ux2UCtLGWVciEro3S1Pi5cFUhfRrmByhabTKA3aWwjFYD/+ELrmuzjBCvjjeDAVNp28vY8r4JT2R4xxbO6BbVwlZGDfZTbPKYbIrU+x1BNGGW+gh3vz+30RU+ZO5qj/9LZ9Z91746jgSPJrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742517384; c=relaxed/simple;
	bh=a1ErgSjcC+YBRCj1mmwbMexus1rbyzcLkhRc6x5Lwh8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jy5rXJUG7l63uzSSXtB5QVW9B/pCYD/g23dg89Vl/8TFrzzNT4y6WChUfXFkj1/90lTIzMNQpR7UhRVJbW+69PnOzwtXp6zuejhmgjf54Q0WgxBG+ZpsSp8DxVzuOC+ibi/vcC3Cpsq84aQl6Z4KZKsSC9UAPqwBhPEUvsvsKRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jdw9aU43; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jdw9aU43"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742517382; x=1774053382;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a1ErgSjcC+YBRCj1mmwbMexus1rbyzcLkhRc6x5Lwh8=;
  b=Jdw9aU43MEqp9oT934wt/jS6JyAKF0f9az08ytRt1FSdXN9PTQHoNgf8
   ucI+WBuwYRkvVtOqqC/DayYpoo28SoZ/YEu3I1l6beJ4EaztsexPSEm3O
   PtDVHiUNf7A+BNWmmmACzdE8i0sZ0JG8kIF1k6jsoQeIJHr+5m776j2+Q
   9S8L4JABZCwvxI5hnpf2O6yzc3g4JhM+DC3xzSpY037FHfnQyA8lPZ9BQ
   p71f2ylr3Kze+6qdm9fkmbq9ArVSUhptHBsuL2d/1Xp/K6dGIiXlhrxI0
   EwCL+gQuAwnQ6weRLx9dt2GaoVdsNleBio1kCD7QuGL7m0WV8Gqo1Lq+0
   g==;
X-CSE-ConnectionGUID: KYTLLaPNSoGRGUI6Gb90RQ==
X-CSE-MsgGUID: Y2C51DZjTDG7TsLyOuVIoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="55158411"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="55158411"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 17:36:21 -0700
X-CSE-ConnectionGUID: omUCtVOwTAyD97MjaTSRvA==
X-CSE-MsgGUID: LKvu1bMsQpu0L1sdfOSBEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="154151539"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 17:36:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 17:36:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 17:36:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 17:36:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlhfF1nez23ntBumZxFXwWx1bqg+PWvj7pujQOy11+EqkiYWWBzcEaP2tNEgmjEZntv3oMjUIpzy1STGUcRK1L3ICmtyEHETETVq1GHn4AGepMTZcc8Z1SIuTDhOHmT8nP4gN7cuvzJDOsmM6autsvpEMMKxU2l1qHprYVKfdbsON97WvKcDd2MMvhjLjk40cAFx2ExRPAPF1N8HxBjaveeLLpRXy5rvyegsm7mFxxFwPt/JmhsYPJN3Ya+szLhL6Ij2/l26rMbJEnro+RNXUP6xBSUOe+8zYOQafTI31fFJnw7z+/MDhJ4t87kDqSTLjbpFTFdKfR53UHdBtwDH3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqpsJ13KWgQJWareaooKi7E0BipbDCriAfsc1AhfbGM=;
 b=EdUM0rubFg0kWLsSQOLF8cIoQhpwWnTNiEOPu81B2Ph/QzqYI3CiD0XrierZ7lr6aPj0pIyP1ysR1CcuD3z92LM+BaBQBAo4MFx1BIS4yBdhBSXRRpebd4eDWQEW3+yF+gVfbeXyC7HVNYavqml6eSb+gHi72qkr9Dl4ChS5vKBYdqHYZKw8WaHaanuHS54aGMtlE+hf5cJwpPQbefxb6lOCQySyNDbjGOwGVO6fN7GwV8/Qc1mRqcz+qKNLT6e9lW3OvHNAzbwcwJap1f0aNLV7HLnNxss0JWDVesYp0E89z3BTXK5nbWMgyhJFaKuzEvNGfYKk0kHnl4xRz0xuQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH8PR11MB6829.namprd11.prod.outlook.com (2603:10b6:510:22f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 00:36:11 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 00:36:11 +0000
Message-ID: <d2090e1e-74e9-487a-ad89-0b95763fde82@intel.com>
Date: Fri, 21 Mar 2025 08:41:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 12/18] iommufd: Enforce PASID-compatible domain for
 RID
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-13-yi.l.liu@intel.com> <Z9yVU0GSbl+b6C0y@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z9yVU0GSbl+b6C0y@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH8PR11MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: ee174412-a303-4cee-6d03-08dd68106100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bml0T2NxZUM1b2tWUTBYZkdFaUEvNkJraFZIRzJsMDBrK1lOdi9IdlpIUTEr?=
 =?utf-8?B?aldXQThlYmdpdk0xSTl3Rld5MjlGdU5La2pJZ0lETm1SMVBYUCtsaUY2V3NC?=
 =?utf-8?B?Z2pJN01ZdWlNazUvOEJkdGE2UGVLT05yWSszeW01NkhKMzEwM2d2YWlGUVlr?=
 =?utf-8?B?dVBKaGw5WWR3ZEhURjBRV3F5bTU0UnBvbmV4VU10WFN0cUt3OXVGN2lCSDhC?=
 =?utf-8?B?blFabDVvTWxuR01ya1NtcHFXYjJLcklhZTU5VzZSbFBXSytRa2RKTEt6d25w?=
 =?utf-8?B?cWdQbjRBeGR1K3BtV3d6bHkrc1pOZlNIanQ0d3pUeUpTSklONFRzZVdmY2dx?=
 =?utf-8?B?TFZqNnlFeDhOYjB0TFFob2lhVUFNSUtKRm9yM3dZZnBkR3Yyc29SenZ3OWkr?=
 =?utf-8?B?aDEzV3Vqc2M5NlVFQkRmSXErWUZ1T0hKdkpUYVVuakZHQUdNRmlWSjVHcitp?=
 =?utf-8?B?alFsRWdpWlZCTGVaekZqQTQ1VlE2dmkvSUI2YjhuRktuem5lYkZrL251UTJm?=
 =?utf-8?B?WTVwd2JZcitnSjhraDRxQjlhNkVsbCtYUE1Hbkl2bkpIajJFUDZYVzJzd1dC?=
 =?utf-8?B?bEdHMmxoMkhpQitoL3VaNnQzNC90QjZTWUUyWXNJTkUwUUQ4ckFlSXRPVUo4?=
 =?utf-8?B?RXhPV0YxWVZMWXhwV3Y3QmU3WEhPTVRaVGUzZnJuZ09DcERtZEF0UjBQaW1t?=
 =?utf-8?B?WHB1VUprY2dXTWVaS2JUWlJISGpLU2lkYVhvSVZZZGt1cWpwNGl0c1dsbTdQ?=
 =?utf-8?B?YmlXeXo1UXBDczkvTHlqYS82SVhVTS9OSm9yU2hUWFhySkd3ZE9Lc0lNMGJw?=
 =?utf-8?B?bS9DVTVsd3dwczR4eFpzcjlraDlhRW9xcnRiQ2dGcjhkS1JEaGhGMHdtdXZa?=
 =?utf-8?B?R010aExCQ3JGa0srV0ZxMlMzZWYwSUo3UWZkZ2tpWHlOelMyYi9BOHJxa0lK?=
 =?utf-8?B?M3FjUnltUHRzVzcxREZEUFlweUMwZTZQTlh1aWsraGNFa0hHc1phMmZCOVor?=
 =?utf-8?B?c1lDRC9adWtHVWM4Q0hCd2toZm5HK1drODBqUG1UZy9DSUwyVHh5bzJpQ3FG?=
 =?utf-8?B?czZHR2t3c2Y4QTNmREpEWHVUOCtoRTg1RGtHd0ZTSWl2ZnFFMCtIaEFkaWZN?=
 =?utf-8?B?b2ZyaG1vM21nUWZVMy9pWE5FejF3S2lTK01FamV1eWhxSE9PbCs5UzQrbUxO?=
 =?utf-8?B?VGd3czRjOU9oZFRPY2llRElIaFFab2JzNnhUTXptQ1FRNDZlcnZpZ3hYU2lD?=
 =?utf-8?B?NnBzZGlZcG9KWFdSNko5NEZPcVBWak1ERFRRQzBSOGFCSmlkQUN4QUZwRzJh?=
 =?utf-8?B?Z1lQZ0xtLzgrZWdnbkF5TzZ2bG90WUgzdG9TSVB2bmhaajBqY2V0ZzZSQmVy?=
 =?utf-8?B?V3F2QWd4SW9McEh6STBYMTl5VUZvZTRMK2Q3dUVVQ2ZlbXBuOWNGQ0R6VUFY?=
 =?utf-8?B?MU1Td3JzU0JNOUI4TmpRc2VVb2F2ZFNWN0IxeVdFZmp6YTNtSEtidDlnNE9M?=
 =?utf-8?B?WlQvdStoL2lMS2ZBaHhJUFMrVmVuWTF3ZE9zdGh6TWx0anhxNW0rWFFYdmVm?=
 =?utf-8?B?T0QrSTFLRy8xS2ovVHljb3NFcGJmbE5SWEw1TUxucUE0TTY5YUdBajlxYkZT?=
 =?utf-8?B?aXB1NGtPNy9mVnJjeWl0NDh5Vk1CZzN0aUxGb2w4T0laL2VMRDFlREZFMTJ6?=
 =?utf-8?B?UUhrODF5dXpjb2wvbmRLV3ZrTTJBenJ3cm9IdHl4VG51VDh3NldzcSsvTUlG?=
 =?utf-8?B?ckFBclFpK09Hbzh0aFZuSHFKZUZ6MUlZQ1BneTFEVjE4T0xkeVRPbEliVy9q?=
 =?utf-8?B?N0ZhWU9GelpINHNmQ3Irb3d1VGJJY3lLbk5aUlBPUDNpeE1hVzVkSTdQVmFW?=
 =?utf-8?Q?oyf9GKgPHhZZH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUdiZGJWSHVreHNJTFpZVUVuQTNqS1BzWWNFQ1JLWjhINnhmbWlVUm5KQ1p3?=
 =?utf-8?B?blZ5N1RhbmxGZFVsaEJYeVV6QW5OMG0zbW9xS2twNVNVcHQvZUhHekIwUjh4?=
 =?utf-8?B?bmdKUEUrczFPczAvaXhTNHJ4L2dZaUxudStGSjlRdGh4TWo3eUVTVUtxMGVp?=
 =?utf-8?B?SVdyRHVEV1g3a0dMbGY1ZEtndGpmcG9oVjcxN2p3SVBhaVlCZ3JOZmltdXF1?=
 =?utf-8?B?NStDT3dKcDF0UEt6bEU1ank3QlU5T0JiYnd6V3ZkU2czY0Q3bERXZGxZRFRk?=
 =?utf-8?B?ZFg2cnNIS1o4dkJmWDRBbXN1Q3Vpd2tnaU9Lb2Q2djBsZXNlelUvNEVPZnlO?=
 =?utf-8?B?dUpsZEZ4NWd3ZHF5QmlhUWt5UFJ5cWFTOWhpOVNiVlQwZks5T0FObWlMQjEz?=
 =?utf-8?B?OHd2cGhRcFRjRCszR2hvYkVwMVZQaUsvTzBJODUrT255SkNMZTVtczB3TUZi?=
 =?utf-8?B?SlRLUG9jSDhDb3Z3KzFPZmk2bGpQRjZKUkNkREdFcmdjZjVlRnZ0NVgxN25Y?=
 =?utf-8?B?WXRWdFQ4U01MbTZaQ3k1UjIxbTBvMlQ1K2VvM25LMWxWdW5LQVJNU3hTVlBU?=
 =?utf-8?B?TVBzdzltcDNSSnVRTVJxckhoMXpGWWk0TlV4TEJUNlk4ZzlUWURPa3I3TDZw?=
 =?utf-8?B?MGVJVUthV2N6YzROWXJ1TEJhN3dNRmREUDhURDVPL0NiazNNWmdjb0F0WExH?=
 =?utf-8?B?ajU2UkxJTzBXdGJhYnZDNlJZT0ZqNUJBalJ3cUFISWl4TEJSTkVZaHIzUmQ2?=
 =?utf-8?B?RlJGU1BSRUx1T1lWMXFVdEQrbFExeXM2UWR5Q24xblFFYWJNallVZ2FBY2dG?=
 =?utf-8?B?d3JEelp6VEdKbVJMZXg5VWFLMDVISnhHR2FHSDFtS09wWGE4UG1GQ0ZIVkZ5?=
 =?utf-8?B?UnNUTjZPN2xURng3d1FvUllQUnRmNmkzSCtRVFF1dlRRNDZzdFJUSHRKWTZJ?=
 =?utf-8?B?ajd5a1NlRHNJTm9seDR3OVF6UWdQL1dRYmJzN0hjVlJnN1RBL25abmJaU2Y0?=
 =?utf-8?B?MG1wb2FtSUZlV2dFZHJDQWNVd01vV1IzZXJyMzE3RkZpR2x3ZGR3emwwZU5i?=
 =?utf-8?B?U0toSDhEMFhBYnY0SHNMdVdTVS93a0kwRFphQ3hIZ0dONmxHWjYzMXBDaTk4?=
 =?utf-8?B?dVl1U2ZyaDJPdVlQZGxCZkZrWGt5OXc0eDVtMUNJUjIrb1FlbkxFUXBsTm5P?=
 =?utf-8?B?TXVuZFdTYyt3L2V4em00aTN5MXdZdTExRUdqSXErZG5aTEE2TWp5MTFZTmpT?=
 =?utf-8?B?U1laS1RCTHRPam5vQXJqK01DcFhid0FtMlBTL2I0WDBEMEg0Szl1K0NNM2dh?=
 =?utf-8?B?c2t1TkdUYlczTkl6RmxnOUQ5SFU4NDRzWmlYMklUQ3d2R09JMGJTQ0E3T2xG?=
 =?utf-8?B?RzMrVlVwYnY0RzFsQVFkcXVmbGNtRHNLeVZpN3VXaGUwRnZ5Q2NXS1Fudmpv?=
 =?utf-8?B?THkxM1B0T3BIeG9IazBHNFJrUmVjL0JLa0VTd3F0aC8wS2lXbWpQUFRGWWJ1?=
 =?utf-8?B?WVZ4Y29iK0wyL2pxeUpUUW5tMDVGc0tHa0RhRUU3ci9BWjBPRUNPM0xsNHlM?=
 =?utf-8?B?ckJxb1V5TldtVXg4TWs1MkFIaVZkWTlwNVM5NWVLNCsvS0dnK1I2TmpEK1lX?=
 =?utf-8?B?UEZCeWtvTGZVZ1FtSTZDbm5telVlbzBPMDBmYW5NajczUmo0RGxDU0N3bXJj?=
 =?utf-8?B?b0NmVlVqdDduVHlPckxZSFd6ZHBodlBkOTdVdXVRUjZ3b3ZJSjdLYmdIY3dD?=
 =?utf-8?B?VlFET0h5NEhHaC9PYTJPdXZCck5CRFNxVUJVVWRxc2VIT0VyNWpoZ0UwQy9l?=
 =?utf-8?B?S2FMLzc0dGI1TUt2U0tOTXJzZU5qT2p0M3FCWTlHTjAzVzdCbG9BYytab2Va?=
 =?utf-8?B?MDVGTWZQcm1SOVpjclpJc3YydVorUDM1QWlYRkdXa2JnYnErSWZDRDBFSFRG?=
 =?utf-8?B?MHNXTW91ZGpqdjhYa3luOGtSZkNmc0playtZUTFIeWRzRFpsbEs2b3R2SWlJ?=
 =?utf-8?B?S3pSK3RBb2J2WHEwZEFBYXVlb0RocTRuMndtZXN6WE9mWFh3WnZBRDZJRWlm?=
 =?utf-8?B?ck9lRTNYaTlHUHRkQ0xseFEyVjAyWElGYjJadDEweVEzTThUS0lnMVlXS2Y5?=
 =?utf-8?Q?RI3YaqsqSBe7GGRwKL2klXU/5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee174412-a303-4cee-6d03-08dd68106100
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 00:36:11.6125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqyuUJWTTjxo+h67roLIg7gOU/tNWl8YCCR51+nIWV3PF+e9Mq+KTY05tEsQdsjnmA79PkbJLsLpgQZqJIvc5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6829
X-OriginatorOrg: intel.com

On 2025/3/21 06:23, Nicolin Chen wrote:
> On Thu, Mar 20, 2025 at 06:47:38AM -0700, Yi Liu wrote:
>> Per the definition of IOMMU_HWPT_ALLOC_PASID, iommufd needs to enforce
>> the RID to use PASID-compatible domain if PASID has been attached, and
>> vice versa. The PASID path has already enforced it. This adds the
>> enforcement in the RID path.
>>
>> This enforcement requires a lock across the RID and PASID attach path,
>> the idev->igroup->lock is used as both the RID and the PASID path holds
>> it.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> A question:
> 
> this isn't about pasid_compat, yet...
> 
>> @@ -514,8 +514,28 @@ static int iommufd_hwpt_pasid_compat(struct iommufd_hw_pagetable *hwpt,
>>   				     struct iommufd_device *idev,
>>   				     ioasid_t pasid)
>>   {
>> -	if (pasid != IOMMU_NO_PASID && !hwpt->pasid_compat)
>> -		return -EINVAL;
>> +	struct iommufd_group *igroup = idev->igroup;
>> +
>> +	lockdep_assert_held(&igroup->lock);
>> +
>> +	if (pasid == IOMMU_NO_PASID) {
>> +		unsigned long start = IOMMU_NO_PASID;
>> +
>> +		if (!hwpt->pasid_compat &&
>> +		    xa_find_after(&igroup->pasid_attach,
>> +				  &start, UINT_MAX, XA_PRESENT))
>> +			return -EINVAL;
>> +	} else {
>> +		struct iommufd_attach *attach;
>> +
>> +		if (!hwpt->pasid_compat)
>> +			return -EINVAL;
>> +
>> +		attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
>> +		if (attach && attach->hwpt && !attach->hwpt->pasid_compat)
>> +			return -EINVAL;
> 
> Should we also make sure that RID hwpt is attached before storing
> any PASID hwpt to a !IOMMU_NO_PASID slot in igroup->pasid_attach?

I doubt if it is required conceptually. At least on VT-d scalable mode, it
is allowed to use PASID before the RID is attached although it does not
exist in reality.

For VM usages, I think the RID is always attached before PASIDs since the
PASID usage is invoked by guest. Not sure about userspace drivers, it might
attach PASID before attaching RID if it only uses PASID. In such scenarios,
the RID is blocked.

-- 
Regards,
Yi Liu
