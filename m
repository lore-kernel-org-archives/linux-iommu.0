Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAF21F180C
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291606; cv=fail; b=f7Iy8JA9FPWMT9uO+/jBrpklO7W0iL7Sq7WLJMyIL74uw8FrTQWh4mTovXHp0HiKsmPSPirbG7Cilem8yOa9jGkt0a3GdN8CNpznp8SfLN+4liKxyhwpz9zRTeQbxgz8TkOpwtkmAGXPr0yxfnICHSlo8N+UsCR5ArCVsT00qT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291606; c=relaxed/simple;
	bh=JGVVDMzwh3BTNPA5nbGre1kaCFHdO/ExN35ibxouC4A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VLTpuFCBZPisnCXX/xH9JiEqK5Akv9YskE2CmjcQ4QxIb/DL9L87jCieXwbso7ozKhTxpGdlJp/pmKOmNirmWMGMMP3Xejoz8+eWzDwsv4iFsv2SSAZQIAUNtDHP8iSsT4sN3+eFbU4E6r7DwC2H1yLqIbZhQfXuKi+Ju+OqktI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CGDd8r61; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CGDd8r61"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742291604; x=1773827604;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JGVVDMzwh3BTNPA5nbGre1kaCFHdO/ExN35ibxouC4A=;
  b=CGDd8r61GXU0jRIuJELNXN3+iKVAvXDkm7LG4nqKe/3a+btSkwKLreLQ
   rwSNbkGY8pClmfcdqM7mCOqy38M7wfNs6GtSKHddkay6L7PZsdXIF5Oal
   OAv6DFvRbSuKCfDTeKuC4Ci3Iqi+wn8uZelZvgbJ78jmn8q8fGQ7tei0F
   ci1ZXxFio9i6EfVFfE2qK3UHHSql0QeExNGXZTy6ko+CmJKnVHV4n4n9B
   is9TDgVaQHb+oclBoUD4mkoZLxaiDCZyz/Kr6Vg5kHCO+JLxuobIOvbvH
   Cl24qMzemUrUIQlSjRYKhyS8extyYMHfQArio69zxTAOr/hId9MMcLxqh
   g==;
X-CSE-ConnectionGUID: 6znWxSlKTjCoNDvTYZ+DBA==
X-CSE-MsgGUID: /Fym6vmmTu6jl8jA1jshJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43439625"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="43439625"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 02:53:23 -0700
X-CSE-ConnectionGUID: 5BuFjtTfQwGi7ZK+dZZd3g==
X-CSE-MsgGUID: DA/MtbJ6Q1+/KgXzHFbANg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="127386666"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 02:53:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 02:53:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 02:53:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 02:53:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVyi2fnklk6Tr3vKv1FtbcpG2y7AuU+Y9407xjvtqzBEExeblkPuzXn619DVt1prvyJUoEGO3LTeMu8yH7oyi3vXpNV4m24rTJSuic+UgVe1SDovN+AJIqfO/3bDXCy1O/At+Vc4QatxorhmWNVhcc6ia+bLAe+KkG0jHPMhUlm+RfjQRXKM517sbtqRiUxOtEbA0q3O/Hbhizr8v+w1vztAkbK6f+NYvpi2tUOOP9uf0m5XRIehj/ZQKMTy1FqLj7yV4wZSw+NE43wPN356DYGOWUcWiQyji0LuoLn0yxcgy3IFnKYIWRXdu1SM/+kAGZc6qoa9+VLIY8EvtyGmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVmBKQb7hg6AuzITN0X0agfLR9x+x2pJXxoCa54fYDE=;
 b=AKhH2QqALnbSlcsk0hSG5sRKc0yOr4/FRfgO032NQ+XmJAF9dXOKHAZHeCC6CxWKQNdHP0Pm/SOybmoAjtt5we3v/a8dXLfaUivM1nxOkkRCh4Ii3sUVkYMDypy1galWrekYsNW9uwT5USe22oSqpiQqQLKJ/YJoMTpJaJm2s8acCmw83D04aSLXQorPyffM2G0N0oH1Lmf/aj7ES4KIhNxUOQ+d4b6RFdW1uMChZgFcsYgdlo7FFDAHzUBhKPy7tC3pb4hTbGwrnQ6agYbpeVc3iWgtvCx6ON/9yDI1h3b3/DmeDjnHqgVsuQ0K4He5TMmmqA94djdeuhPySsvkWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH3PR11MB7346.namprd11.prod.outlook.com (2603:10b6:610:152::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 09:53:21 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 09:53:21 +0000
Message-ID: <010af39d-6158-4aa8-90ad-0084d5767e2d@intel.com>
Date: Tue, 18 Mar 2025 17:58:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] iommu/vt-d: Put iopf enablement in domain attach
 path
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, "Fenghua
 Yu" <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, Zhou Wang
	<wangzhou1@hisilicon.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
 <20250313051953.4064532-4-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250313051953.4064532-4-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0189.apcprd04.prod.outlook.com
 (2603:1096:4:14::27) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CH3PR11MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 93736682-6084-4323-89db-08dd6602b775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEt3ZHRFYmtIY3VWeEVEWXp5UXhRc3picE9qb2Nhd1FtbXZ5cC9KZFVTdE84?=
 =?utf-8?B?UWZxQUliQnN2YUQ3OVhhNFpSeUlPakVSbDNkZ0ZmWFpFa0MxQkdZaVRCejN0?=
 =?utf-8?B?U3dBSmNtVDMrL2JXS3VPZjVSYXA3OERpNm5EZFpTUldXbzJxN2xldkx2ZnEx?=
 =?utf-8?B?UmhSNTd4RE5qUlFEWWlZVXhyM0dMeVZpejNKWXc0TjlPZ0l6cldhWVZTdW1M?=
 =?utf-8?B?c2xPUy9EQUVsOGJHUUFrQk5yL1FxaHVybFVwdTVjV0JkTXJqYUtiZlRDV051?=
 =?utf-8?B?NE5uak5zU2dpMzhrZkdPa2JVV0t3UG1KODQ0WXFsbmh5V0RlSnRSYW80WEk5?=
 =?utf-8?B?Q0RFanpoSUtxajFjVFBoOHZJSkpJb2srdmZibXdlZjNEdWxpdlNoY3ZRbjJ1?=
 =?utf-8?B?NStXblFTS1NMRzM0NFAwejVLUmNya0lCeW1tL25jWnBtNnN3Zlc0Ri9VS0V4?=
 =?utf-8?B?V1pRZUROQW1wcXR3RW1PelN4bUVMZjl6N1YrZWRqMUsxaUVrVzVleXZ0c1NG?=
 =?utf-8?B?K2F2OWljaDU4bEUvSllOSGNNK3pZOFlwVzhlbXpuaVA5ZFVKU3Rob1N0Smcz?=
 =?utf-8?B?NkFud29hTWttbFUxampodTc1S0lEOUwrQlVITjJhUmxCdTFKclNpL3ZCUzVM?=
 =?utf-8?B?Mk83dC9mY2FzZ3BLQ20vUzVpQVZiZWtMMXZGdU5nVjFOTmVOQzJNa3FXQ1E1?=
 =?utf-8?B?VDlwUXg3dlBuSmpqeGJnMWJveURleXJrNGxrRW83TjFVdnhuWlVxaVlnYmlq?=
 =?utf-8?B?OHFIYStQa2JhalBaaFFhZkFWL0dFaXBUUTVNZHJiRUtaOTllTUJCQzZWQStx?=
 =?utf-8?B?SU8ySnBRTFh6N2NYamIvUnFtSmJTb21ZVHBlSUVPR2VvbC9Fbi9oR0o1b1V2?=
 =?utf-8?B?ZjlpNDJTYjEyTitIMHJPUkIrWGUyaUdJZjZUbEFFaHhpOS9LWTJaRVgvcTUz?=
 =?utf-8?B?b1JFUGtyaDBrR1lyeTdwdDBLTHVCR01UZTZzd0pYWDF5VW5ybFJLVkwyMXhw?=
 =?utf-8?B?eWxrSmRFZERSeStuemxENUR4S2t1YlAwdFViYjUrbko4aStIaHdQRFFjdXp2?=
 =?utf-8?B?TkV1S0FsTWhvMzJsQXhzV3hHSndpelRCQTVCZUlISzBLdFlJNldZMWNWU1hG?=
 =?utf-8?B?RllGMHB5TCtvK0VvZWpTWjlmMUdrY3B2SmlxVHpvblUrS1dVcE16VGdHelk4?=
 =?utf-8?B?VVI0dEYxbjRNVVFYbzZrcWZ4cHZGdkY5NWFDeHJaSmRWa0JPeUM3NXRUT3NW?=
 =?utf-8?B?WE5GK0FZYzlFbXhBQ2VpVi9mUzh5TXVMdnlmRjl6STNzejlqQzR1SW8vZnJu?=
 =?utf-8?B?T0Z3Lzc4VE1wMGZlempOZk52aVdFaEZrOXdDbTRJTktuVjhkOVJ6WHQrUzlT?=
 =?utf-8?B?cCswaWlISEVIanFhUm44ckNSUnJpVE53SmxnNEQveUx5WFd2ZTdqWlpGcEVM?=
 =?utf-8?B?akpQSG5VQVJWWkRwcDlXaE1oTkwwUTNQeUVKeDZEU0l5SlRIeEw5Q2pZTW9U?=
 =?utf-8?B?cGtvTDRVdU1VTDUySkZlVmdQeWJwNVl2Qm1mUkJJUVRIK1ZVZng2aHh5ZnZt?=
 =?utf-8?B?SGVnSTdRU3VFOW1McmxlNUpDakNFSlVsMzNLajU5b3NSQ3ZoVzVDbGF6azBB?=
 =?utf-8?B?SWdkWmwyQlFYWStKY3NqSUdMeU9HRTZBRGJqbGEzNFNKUUY0T1NkYmFOUm10?=
 =?utf-8?B?aGF5MDFrRjZIQjRndE40UlB6ejB1cTVUOXFCY3BiSTkwbVBWZHNGMUk5UWt3?=
 =?utf-8?B?TE9OMERoM2FqdSs3VlZMTWZUb3lxWTEwR3ZROVRmTXo2SVhla01panBjRXky?=
 =?utf-8?B?OW0vNWNrS3pMUWhIbmZWWU8zcHUvRjhMMHRnQzlFZnZOMkYzZndJTGxGZGdn?=
 =?utf-8?Q?MOamtP/4nONcF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHd5Z2VpaGFhQUZ5UnRqSHV0cERkeC83b3VBWGUwNmNxS3RKRnhIZTdQdFhT?=
 =?utf-8?B?YlZ3RElTT2FCT2xaN2o2ZzNvaXdyTThjM1ZvZDZEWVhidDcxcTIyTU1mNzR3?=
 =?utf-8?B?ZlEzYSthbzFiakczdk5xdjkrT3JKczNLcGFyanhFZDMyZXUxUUE5MHpMNlRN?=
 =?utf-8?B?UXIrZytDK0hVUVZ3MVcyVDFVZ2NpYWdEYktEZGpjL3JWSDhjZlNBMDQvT0hu?=
 =?utf-8?B?MDlPTDVtczhoQ3RJNW5IMU9QQmYxZ2x4L3lOQXBpandyWmlFbDR5a0VUbzcw?=
 =?utf-8?B?OVhuVEN3SUlleTVvbWhJSk9pTy9hUEpubExRbjYxaEFsbHVvOExIMzVhZjFU?=
 =?utf-8?B?eE8veUNxemplSGh1MDZEZ280RHJQT0Q5R3IwNnR6MjZIM01FU3NuQ2RBeTUr?=
 =?utf-8?B?bEhndDUwV1l4Zm90bE9EMzJhZmVoK0lySmhrbmg5ZFJTSGd5SWY1YjNyVHVm?=
 =?utf-8?B?cHg0KzZWa3diUWp5MGw2VHBRcFQ5aFRHODhiU3IwSkZnb2RZNHVZRHAveUQ5?=
 =?utf-8?B?Wmk4TmpienlwVlpxK01qMEpZT256ZFBSai9pemg3cEhJaGtsYlJaSE5vR0xZ?=
 =?utf-8?B?M0RteXNxTHZKbGFSYllEWUVaNkRQRGtza05zSlFTTHJneC83V0U4akhNUzhp?=
 =?utf-8?B?c0xPSHhDWUcrbXZaQ2RwZWlyRTBPZGUxTllsZlJHQWhKeWc1UUxnMkJTT1NU?=
 =?utf-8?B?c0tpTjJxYnU5K3VrZ0Mrb0h6eVIvT2M3TG11QjJZTnJmekhOWVVkQzVob0Jk?=
 =?utf-8?B?L2NSdTR1eGk2dENxbHBNNEhBYWdBdG9tZVlTNnFwUDFDcmZZbFBKYmtGWE5O?=
 =?utf-8?B?anNCYXVHbHk4ZnN1bUFySVo3RGRzOG1IU21vZENCZGJ5eTlxWjQxL24vVlJt?=
 =?utf-8?B?endiSndRYzJXT2dlVm00ZjlFSlR0U0t3WUFhUTV4SmFOTWd0VDhhTmhxajdU?=
 =?utf-8?B?ZEdlM0d3aEo0eFFTZmc3TVlMRTc2MFB2WElrRXBUbU5iRVFUY1hoamtmK3Ew?=
 =?utf-8?B?UGFvODZJMVZrTjNRV1RwNjJGUXdtOG96WmdSK2I2RWJDb3VWQ0ZFd2NOTEFE?=
 =?utf-8?B?SEREeDlHckZvV3RrZktRYlZuQ2dXUnRSeU9WVnRNREttdjVHWElva3lLblIx?=
 =?utf-8?B?TlJoRnpHRVRZRmJjYzVOM2ZLTjVhMVVBalRYTmlJSHk3M095cVRBcmNINkIr?=
 =?utf-8?B?WkxwbzlRZXZKYThLZEdyTHR6bWczRXVZcllvREZYS05qNmpnRlkwUHpxWkVZ?=
 =?utf-8?B?V0pQdEYwL3ZqdEtTeEdvL2JMNGNmV1E1WjIrdEJoSmZRdDdtSkNNT093YVd3?=
 =?utf-8?B?Yk5PSWViSUp0NDF2K1c3SmxYbk1sTEptN2hQc1Yxb3JUK05zalVURytQbTZr?=
 =?utf-8?B?RmV6K0xNVW84NU9JT21TMzk3VTVkSk9rd2pVaWhDejJjQUU4Rm5KamhKdzBy?=
 =?utf-8?B?QlBudSttWUJNbzZEQWdNVFR3UC9nc2dmY1ZQUjVDT1MrNVMrZnA4bnFXSWpP?=
 =?utf-8?B?NDRYZE1QczdtWUpUbktadUpYaitvcHFZM0trM05xbC9rNGJ5MmxCckx2OE1h?=
 =?utf-8?B?c2R4SUw4UTl2U3BnaGNqODFyRnRKclcxOW5XVENvTzRrY2hOaFc4MEx1L1h5?=
 =?utf-8?B?WW9KVUJad3FZQW1mSmdnM0tVbUJCQXA2Yy9WRG9yNXNkL2Z3dUlTd1Zlcm1T?=
 =?utf-8?B?L1ErRmpIVWkzRXBhUm5SWWVUMFRHTGhQQ2xvSElxazVCTmNmTTgwTlUzcFNK?=
 =?utf-8?B?Y2xWb1pjY2EzZXA3WVBoK01MS2F2UC9lUUw5dmEyNGxTUUMza2x2WVV0cmpx?=
 =?utf-8?B?REcrQkhtWVBEM3luZWdDaU4xWW9jTElqSE1IMUNUSGhuZDI0ZCtvaTUzVmFM?=
 =?utf-8?B?STkzUzMxUTVicDZUN1RCVzlKbXVhU1lvMnBYcU9FVjRlTStGRG5pVStxOUFI?=
 =?utf-8?B?RXBiakNaYkpjRFpJUEJOMXdMcTVtVVdSWGJHeWJYTEdEMFEwajBCcnBKTXAx?=
 =?utf-8?B?aXFzdEJGY3F4TFJWT05haXUvTE5FT25xWFA1Q3F0eGpyZ2phS0VUWUFkQVUz?=
 =?utf-8?B?blNSeUVtbThLZTdNODJ5dFpSSEhPNXZOZWlsSXFpNkVDQXB3aExpdlVwR2NY?=
 =?utf-8?Q?tHTJr2EZaJBb0Ma5FoODSUJE2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93736682-6084-4323-89db-08dd6602b775
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 09:53:21.3674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PP3UDOTaI7qXYAjJO7YSpvidLdW4hnF11vhw/nb9N853Smdl4wFJoz5aKPj/0DxG3eIrbZ/DbOOpeyUFWqJ2NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7346
X-OriginatorOrg: intel.com

On 2025/3/13 13:19, Lu Baolu wrote:
> Update iopf enablement in the driver to use the new method, similar to
> the arm-smmu-v3 driver. Enable iopf support when any domain with an
> iopf_handler is attached, and disable it when the domain is removed.
> 
> Place all the logic for controlling the PRI and iopf queue in the domain
> set/remove/replace paths. Keep track of the number of domains set to the
> device and PASIDs that require iopf. When the first domain requiring iopf
> is attached, add the device to the iopf queue and enable PRI. When the
> last domain is removed, remove it from the iopf queue and disable PRI.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

a nit. It appears to me the PRI cap and IOMMU PRI enable bit is set in the
probe_device() now after the below patch. This commit now is more dealing
with iopf_refcount and adding the device to the iopf queue.

https://lore.kernel.org/linux-iommu/20250228092631.3425464-6-baolu.lu@linux.intel.com/

Regards,
Yi Liu
