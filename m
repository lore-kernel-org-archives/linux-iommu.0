Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D82267737
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871524; cv=fail; b=tqfnPIQm5IFSovfFsqBu3xrjgQj+h4/nuXbzyAWjl7Nnxi2jdwGruZ3G/AIHZU4wszPb+Jm6amTPOazPQIiN0Ex35qh/EC1x+jey4BVC+YX6yE8jOlQlVoKAT8bwCh5Jxr6FxK21bLckA++0ZaFPAYSQx9cGX9bdvleX4q4hwx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871524; c=relaxed/simple;
	bh=2WJxlz/VbycaxZSqKh+Z/gwXV3/H9vuomZHAd1BJzjg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sqDYpbHgRshAYfgxtkpReMBZoRZ4mx5wARcnAlhWiXwlEOTfj/IYnvlZ7O2WmX96+2fU4uZUIpNFmARB/7lrgs/9ek5UMDNZzgx1uuqfbDfG8QjmFZcR6O4ZdYcxF/rvgxaa3Iy6QaSKmQc/QV5SPE40wCHQvvKsxidgQkwSQsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EmdkPZZ3; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EmdkPZZ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741871522; x=1773407522;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2WJxlz/VbycaxZSqKh+Z/gwXV3/H9vuomZHAd1BJzjg=;
  b=EmdkPZZ3IbCWs5+Xqo7vH14moHizDNuwTmOMCnHky3Psja8Oy4ctY0Tc
   GOSsbS43JCO7rUfaDpNtHEGR0pPQklb80J45oOGVXfDDLK+sIYKQNiGF6
   OlLGEKR9E5VKfAmAl5yZLvBUCN6fg18E4Pcr//oTQZaMYdhlGel/CNNBX
   iN7guyO0Ruv5HuJNFpLcZLmLSl/lqIDu4As302REzTHnCdAGHyyX4L6fH
   RGdirDOZ69YoFxJWhoWOt/CSV2A0uohb+Yrs7k9+Z6lNShXL2Vlx7r7mU
   MSHq2Y5WzjWE1KNjr1AS5HpnLiEexo1m1UWZ9QMM8knulB+aZyvnvTXyJ
   g==;
X-CSE-ConnectionGUID: WcVrQ+GTRoeC+GF5OAG8CQ==
X-CSE-MsgGUID: 3V8X0b4rThuYYlfTsiRgDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42867059"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42867059"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 06:11:55 -0700
X-CSE-ConnectionGUID: AvGdN7iCQLmpWPLVfbR8+Q==
X-CSE-MsgGUID: wOnwrCfQS/6625TrOGxIZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="121876564"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 06:11:55 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 13 Mar 2025 06:11:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Mar 2025 06:11:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 06:11:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRPQY0s8QxKWGcS0dw7HbOndrOOlQ7SUhcC7Tud3ddv9atSiUy4sS+VxfEdn8lMHZ2+voWLyLK5Qh/2RcKR07+GaoQYjOR5xRMrh0+NvEYrZOduBvSqqTo2xrPoNKv/U3Rzm71Djx/unJtxYRMPcj4JKOf8HT2E8JN9eCGBAzexxqlu0BIZwvHz8bT2hoTkclrbmJW+ZCLVOQCyiFixk2KzwEPYIF/SQ5A722HkxO3Dn+M+Gh3CWN1/PrErSjKVqiinGRfWeONvDNXirovQAyTZrU99GrWgmyUdRib9c/rhG3LdYu3FwclMbBe4Ut9KRXO8/ea2W7zHK7Tw0SNU10Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kQYBn/ORKrWsV9Z9I5z+8T/fPWgJSlCUfxbhfsK6DE=;
 b=Bd6gZMBV3H6wiCS1g+s5X55GBUPx0Do0vi3uG7GR+78IJkfJXwno/3GeBpmPdF952EodNZ9L+GL9ht5WrJUeJ7lE1uuaBdpq7kCIkKDVPwhlrXp9UVKJRriKQPInwOAMt4wKJpiIMKM1pJQPmW/iInRsoXRWDBtFYqi0v1idO/5J+aq/E7eC8pUEP3ybDJFA2cpjB7yd6Sxz+X/OFzJasskfIau9/9qT0fwL4bgsii6VZSpRfYuDJOAkaGILVTeaecanO1PX54youmVAaORH65bWmBJWVECD+Us0OfdT2H9/n4xfJMdmbhN0jjjVdw007B4klOrX5Xn8aiQOqIpy4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW3PR11MB4650.namprd11.prod.outlook.com (2603:10b6:303:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 13:11:53 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 13:11:52 +0000
Message-ID: <962c985d-3d58-4ad0-9cc3-4ace9ca05481@intel.com>
Date: Thu, 13 Mar 2025 21:17:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/12] iommufd: Allow allocating PASID-compatible
 domain
To: "Tian, Kevin" <kevin.tian@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-10-yi.l.liu@intel.com>
 <BN9PR11MB52766783E53A987FA872ED918CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
 <a05fe92b-b36f-4240-a20a-07d186cdc4d1@intel.com>
 <BN9PR11MB527619BA7FBF947201ED68F28CCB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB527619BA7FBF947201ED68F28CCB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:820::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW3PR11MB4650:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3ca9fd-60c5-43a9-0cd0-08dd62309f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXczdmxnTytaZ2lkM2VQdWR2Mk01Y2hjc3YwbUdWVFMrOTJhS1pzRko5Tmhh?=
 =?utf-8?B?NkxJT0VHM3gvbGc1S2pIMjhKYmd1Mm1GRUMvSXR3NlgvRXJTZG80TTF3NGwr?=
 =?utf-8?B?VGt3elR1TjNyTGJXaEVjQlZDQTl4S1Y3MDJESmpqckNXQmd6QVBrcjFMQkg2?=
 =?utf-8?B?YTdNdmxER2liVWhzN2wxTTN1UzNRUGtwVnVNRGZScFZxY1ZqTHlmQUFvdzBn?=
 =?utf-8?B?Y3VaTTQrQjgxem1sc0FmZnZPSTdJaVR4UlhSSlBBSGdjVFVpRkFuYjg1Q2kz?=
 =?utf-8?B?WTdjNjBBaTFSSGRFY284NHVFYXdtUFh4M0V0Mlc3WlZVU1pUN3U2aHBhTzNm?=
 =?utf-8?B?cHF6Wk5ScEtCK2pveFlWbkpJbzRSUERkWm82c0RqTERCZGlsS1gwM0Jsa0l3?=
 =?utf-8?B?RGg4TWx1S2R1Q3lUbmJHYllIMkRwU0daVFp4b1BpNnNFYmJQTzVmbHQ3b2c5?=
 =?utf-8?B?Y3ZERFpwM3RGaEpIejhFU0lTcWwxSFlvOFBzczVPQ0hUZE1qeS9rNW9XTnJ5?=
 =?utf-8?B?WHpnR1VMc09kTUdsVG9ZL1A2UzFhSXNSS0w0TllUOXVpSGlURVJWOG8rMDdH?=
 =?utf-8?B?WnVIYzJIQUFiV2VLVnVTT0l6Rk15aE1uVEtIcW83YjV0d0M4NlQzTTIwR0Rk?=
 =?utf-8?B?OG4rSkRzTzY0VHAzYzhocml0bnRDMXdmTjA5MUxuZUsxTW9EdTEzMUp1RStK?=
 =?utf-8?B?NEtTYXJieENhU01GUzNYYjVyTm1CUGNMUDJTOWd5eWhwb3RPdCtndzR1SFJS?=
 =?utf-8?B?ZnVwdUNrUHBnOWtJMit5a0FnaVlkRS83TU1hYUdadURlV0EycU1GQ0E0Q1hC?=
 =?utf-8?B?eitONlIwb1VxZ1pqNkFTL3dOSTRQNGh6aHZxanlVdGQ2QkNVdVlQazhXVDBW?=
 =?utf-8?B?U3V5Q1NjZmYya0ZxbmJvU1JRaWM1bE05VVgrUmRZSmQySDMyMmp3N0dSU1dl?=
 =?utf-8?B?Nkx2cERnSTQyT0JobTQ5ZzFIUVZTelNmeGpoMlhwOWltSlgrbTNEd0tNSXZ5?=
 =?utf-8?B?elBsVFRsZDdXSWJpdW1tWCt0a0tVL3MxNVNBVmZCK1M4cGwwaEw3ckNHVk1B?=
 =?utf-8?B?cnd6OHExSUVjZnk1b09HL1FIL3NCb3lVU01WamZJZEx0NkZtdVlxanQyT2NH?=
 =?utf-8?B?NTZXckRUd2JPNnFONXdLUUZsQnU1VVVPZ2FRd0c3KzhSbkJWdWMxVDc3ZmVN?=
 =?utf-8?B?SDEwRGZOTzc0VjU2WFdPWDI4N1JVNzllZ1NSVmVlWlVYMktic0JtdUVXSHZW?=
 =?utf-8?B?dzYrRlZjdzhyOHNPWVl2QkkyOWpPdnJrU0JsMFpkUTlrcE04d2h1N1ZUaXcz?=
 =?utf-8?B?TWExcklZZm5md082Z0M2RVBwRmpKL01wVTdWTThhcWI0cnZJSENVMHJHcTJl?=
 =?utf-8?B?akU2ODZHOERaemt2eElBUFdMRERtOVlBSTdsVzIvOEptVnI0K3BhZjVPaC85?=
 =?utf-8?B?MkFJMlBOY2NMQW9VNkFEUnFqY3NXdEE0eThoVVdIMDVDMlVDWHF4cmJNeWZU?=
 =?utf-8?B?OURncnFMMEVRRE5jLzJUWUtaVHdjMGlxblJxcGM0dTRIYS9mZ1R0b3RpTGNS?=
 =?utf-8?B?TC9yVHh0NGtOSXB6eTkraXdJMkY2aVluYkwvak9nT2dlSlFCZENKVG9HOW9P?=
 =?utf-8?B?Q2dlWmpINTZyK045RGVLZ0k4c3UyMTBzUGpoZER5UERzc25vc1ZocGhud3VV?=
 =?utf-8?B?ZVhJdjR3SzNtRTFPZ2RlMitmYTk4RnRubVdndE5mMUVlMm05dkNSWnZwWUln?=
 =?utf-8?B?THNpTDR0THFvVGJHWnZzb3VESE9mR0FPWkgwYm5pUWZhL1BpeFlnNGc4bjVQ?=
 =?utf-8?B?Z2dJVVUxYTgwSkhsYm5nK2Y4TE94bnZKMXNOK2kxS0RsTTJrL2dSNVI3c0g3?=
 =?utf-8?Q?OBeHKJdVbpVWX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlVRam5xWG4zNE1NcjNPL1ZTNythYW5NQkpDcDI4ZlNJTm4yYmtrMWJIVXpY?=
 =?utf-8?B?Q2JTc1pjalhrVmMyQVFXcGI3MTFaejJucUdDU0lSNVhYNTNXYzV0UXgrTU8z?=
 =?utf-8?B?WXpYMVZrSUZsZ1pLQ29QcHNid2M1Vms5bWZPVnJkSUE2VlcyQWJZam9LWVhh?=
 =?utf-8?B?K0JUNTJCR3djRG1jbVF3YjBFVWVCRDVwNVo4VXFLbFg1UVVJMUpKV0piOXBx?=
 =?utf-8?B?RTlJSlVvT2tZbHc1dll4R0J3Skg2TDhsRmhGemFxeFRjdlpVNE4yV0lTUHc2?=
 =?utf-8?B?RmlBMU5HcVhOdEZKSUp1d25NTi9HU3h6aFd4dzBRRVNlajdCYWV6dG81MUhy?=
 =?utf-8?B?OEpERWR4dHZqL3lJNkMwajkyRE14VUdndWhyMWIweVhDdTI2RU51ZDc0RW9K?=
 =?utf-8?B?NnNnN25JUDIwOUJUVWg3djIxN2p3b3hxamZmNUs3SHozVHMyeWdBS3RwdXhl?=
 =?utf-8?B?M21YZ1U0Z2Nyc01WT0dQekVWaGtVREdzemx3c0V1enBteUFvcHFzbll5eEVB?=
 =?utf-8?B?SnlDWlE5cEF5TVVWaStPRzR6MEk0UjlkMGsvUGxHUS8zTjhzQzBZSHNaTWVu?=
 =?utf-8?B?NDNuTkIrQURZaHk5Uk1weUFUTE1wNENUOVpTQzA3RVdkS0VVN250WlhldFRi?=
 =?utf-8?B?QTM0SmVwOTRqL1RMbjU3eUZqU2xHMXN4LzJ4dkY0VllVbXROL0ZsenJvZXZP?=
 =?utf-8?B?aFpNSTRjV2xYd2M4Um5tSU93dkhKSkYwNnFEMm1DQ3hYZ0dMWUtTRHVMbyt3?=
 =?utf-8?B?S0p2RGg2cHZlaFZIeVFtcGsvWmRTZi8yRHl0a2w2T0M3M2ErYlRNeGJjVDRN?=
 =?utf-8?B?TDQwTVR3TlBYNHRmNzBad2Q2VmJhaXorV1QzYUZTeDJER2YwSHR6TlZCQXFs?=
 =?utf-8?B?M0JUdUV6aWZ1SmJtZUpjQkVCZm1UZ3BBVERTK09hci9RaGd2RkswQWo0a2Fv?=
 =?utf-8?B?VUh1aWwycTkrTW5TZlU3TUtINVgwb0tzNHJ3UEdhTW5yNHhMaFJEa0VHSEtW?=
 =?utf-8?B?WU9lMVVEcmpVai92L0RrR3B5TEdLa3FWSHdoemdQb054WTB4ME5DSlk0eDdD?=
 =?utf-8?B?bSttcHZ6NU9tbmNGSCtqbUZCWTQ1d0J2N3EvU0JGRmxVQmVXUUF4RXFGTXlu?=
 =?utf-8?B?cktqVkg3YTZTT0djK0syQW1TWS92YlBuNmFKQkJvM21HWjVoUWM5S3JOOFBK?=
 =?utf-8?B?N3VSWnh5ZWFIazUzdUdRd3p5TnBiekp6azZQNWZUMmUvcHM3b1Y5NDQ1NkZG?=
 =?utf-8?B?Qm9jY0tRODlnZG5EbGQyVXVnUkF0ZzZ5dkNSaHpFMGlKUDhHeEhYd085MnA2?=
 =?utf-8?B?ck1aZFk1Vlg3YUlod1dCV21WOFhZaTU5b3FjMHJweGRrMXQ3V1NBczFrRVll?=
 =?utf-8?B?b2JFS3RFL1lWUUNqUlpySG43K3I4YmIvcCtrVUE3dXJSdm9VZ1RYLzl3TDdl?=
 =?utf-8?B?SC9yM2VDek1uS0JacjAxeERtb0E4bVFvajZRcTVJajJyY2kyd3pRbkhrOGpM?=
 =?utf-8?B?RWdicWFLQ1IzNEljZ0lLNW9kb1RWTXZLMWZSOW1jRDhtVzcvS2NGb2d6cExo?=
 =?utf-8?B?eVA2Q1BhQUpQbVZ3d2FoaTlKNHJkTWIxQkMvTEk3Wk9NOEhuRmFvcGd1b0hz?=
 =?utf-8?B?T1VEMHRrNTZZYVkrM2xnTVNSNUl5aGlXNU5sL3Boc1Z1Q0xERE11d1pETE8r?=
 =?utf-8?B?b0lsdlJuZVU1QURGejJYTngwdzhNOFVxWnFKck0vTU1SSnVKYjI2T3pFSTBW?=
 =?utf-8?B?cVFNR2I4ZkVxc1BUcElxbXVHNWg4MEl4U3NWd2FHNDNjc0xTbkFQMjU4T05E?=
 =?utf-8?B?QVlsemZOczgrZXNYMVpuNjZNUVBsTTJvTFBYdVoxdSs0WTJkZTVVOTZWZHZZ?=
 =?utf-8?B?bXA1OTlQV2hGMmpUS2FycStLakUvU3F0RjE4L09hd0ZjSjFBTUxIbXJoSVps?=
 =?utf-8?B?cmlQYjJEM3RpUGVnVUN1cG43U3BMZ0UrVHI0Z0k0M1lBR0hDOWZ4c2RadFNr?=
 =?utf-8?B?K1pST1NGUmU2UHFkN1grZ3V2SHlNWTJLaEV1dW02anpsQ0xGWm5tOUoyQ1l0?=
 =?utf-8?B?S3gzdnkzUDZBSFJ3b1VCbVB3MStoSzhNcWV3Y0RFTkVoMU40MnJlelRMWTJ1?=
 =?utf-8?Q?yrXo5toepL4pbTr636T8RxXU0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3ca9fd-60c5-43a9-0cd0-08dd62309f19
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 13:11:52.8298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/pMs4MQZs6P3tU1vgAQA4Y0oDTkldA+7jnNXrf8Hm1VuvxBFRj/VrRzz4X0dfMBEvrLSHTGoLlzmbAiq/2pJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4650
X-OriginatorOrg: intel.com

On 2025/3/5 10:38, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Tuesday, March 4, 2025 7:49 PM
>>
>> how about making this part as the below? We may assume that a pasid
>> capable device have high chance to have pasid usage, hence use compatible
>> domain for rid path in advance. If user does not want it, user could
>> allocate an in-compatible domain and replace it. might doc it in uapi.
>>
>> 	flags = 0;
>> 	if (pasid != IOMMU_NO_PASID || idev->dev->iommu->max_pasids)
>> 		flags |= IOMMU_HWPT_ALLOC_PASID;
>> 	hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev,
>> 						flags, immediate_attach,
>> NULL);
>>
> 
> yes that sounds better.

after a second thinking, the original code should be better. It means
we keep the old users as they are. Old users might be using normal domains.
If we make it use the pasid-compat domain, it might potentially meet some
performance deduction? I think it's better to avoid it. While, we can add
a kdoc to mark that user that wants to attach PASID should first attach its
RID to pasid-compat domain. I think this should be a reasonable ask since
such users need to add extra code. I've made it in v9. Let me know if you
think it differently.

-- 
Regards,
Yi Liu
