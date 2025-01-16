Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0336E1CEAD3
	for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021316; cv=fail; b=e5IQQBlb0eQOmt8z9vc6kCBEcFyGmtN3j7mdEpAzE81CmuyCu07mw72Vc5E+naatHota9dqRqS/crouOg+9KZ7ksmUTB+581+G4eU68lu+OIGdtne9qK0WN/jgyX9ugrlwOeGyYnGd0p/A4RHtqBX52q/ek4ogIBVMTXX0nF3P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021316; c=relaxed/simple;
	bh=8R8l7MXn3dQwwQ6xnxxv0ULK/ImsK3SXWf9Oh2u7ctY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W4SydPFe/0VsfAWEd4uvmEfevoBsYnJpelvwIRolIh6yFntxOCv+uM7SPyzq9cPZ+draK+nhe7CEMU//T1Ra34BdOyyDJZVBGLOd8esRGR12Kv6kliaIWHiN5nPjbKiBXFhn0v02bNHwvGZXleEpSHVOymN5pAnbHn1y0Md1cTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IR2aMDgN; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IR2aMDgN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737021315; x=1768557315;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8R8l7MXn3dQwwQ6xnxxv0ULK/ImsK3SXWf9Oh2u7ctY=;
  b=IR2aMDgNsCw58EsU1SFdz/dIYMCSxNFPA3yGxndqw0LrHdIF4r7Sjcjg
   YmPJKtNPBTWsZSPooCEp/G7ablrxIfotgcQNCRKXLEi39lqYmxbGrXmDD
   KS9Nb7IbNjKr9zCcP8WbqNScN38KOKq3P1/zO+Jir2siko9ytgAkr9tsX
   xcCb2Oh7EMqJTmkcYlDPjRBjOZRzRvyvyB16jWRZn1kO9SWjcHMRBHduZ
   3l5To2fsonvVNFqMSp04q+7rbrXdrIVW6n/WJZYTDF8qQYiKWT0WFvov+
   nSx0YyiUxgoKHy6l5L6etaRTeeX9DXt2xltKKBn8NPrzVOeMoluXPceSs
   Q==;
X-CSE-ConnectionGUID: 6sovpsF0Qt+mEr2fSDiuEQ==
X-CSE-MsgGUID: lidj/DshSJKlQIGWFb0kbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="48057065"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="48057065"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 01:55:14 -0800
X-CSE-ConnectionGUID: 0BtYWPJZQPm5kQLNv4m+2A==
X-CSE-MsgGUID: vVTKpm7HT2qEiwXANUGUOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="110410692"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2025 01:55:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 16 Jan 2025 01:55:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 16 Jan 2025 01:55:13 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 16 Jan 2025 01:55:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEMSHU+jEijnhuXLZVgq3dnuWiYxhFuPDo+mYG0ppXAOvgnIumibU958tLpU0AYUrfYwrzgsFjZ3+uOOfD9s3Oj0a48Kq4QDWJQdMD06451tCcUALPLc+YCuGDuB763YCrO0QqY0ovajRc7vAByDvQ47vLUxqDpHFIAYtDmjNKWmFV11Vq2ZAOIRyC4T2UoCSjgx8bOJQ2u+93BoOqudXHwcUwcWzBca6z1ZZTjvaxch2WpcjJ7RSpG6qo81RSm9CDkhf8CsnmKeisPxpNrLkIwNs/Xqn8aHDtVEffCfgTZVU0ymekoTpequPyjMGbm/UlqyH0U6faUxP6rIX+LjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeeORkj5XPAqIgXiDJlWvTi75AW+S3qaSF69fytDYno=;
 b=ujyioNw09FY6TgoyhMjVM0YZMBJA5IDBwklyaHMv7bW7Q1LNEiTjZHasxqJidYjtc/D/TWEVugchwSZR/UTAqVmYVRkkeXrDx1x/FZQ0MMxDdj9/0POwg3DgCDAUa6FGQZv9BrzdrIfWgAJYfe9Lv3fKJgHUjehl7RnkCylWKWdU7MRx+p6ISkjvvyUW7HfzeCnWJs5hwcSCEoBbhR7qkuspe1c66ZCHcdXQ4YSscVjozrp/bmuKD8hsCzrSzqT7DYArv0AZCnW11ULj02ughkf031cVn4IJwf73Du004ehOZ7Al8Y+mjzU60jeEcQWUSKGBqFR9fkil8QK3J4K9WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA0PR11MB4718.namprd11.prod.outlook.com (2603:10b6:806:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Thu, 16 Jan
 2025 09:55:06 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8335.011; Thu, 16 Jan 2025
 09:55:06 +0000
Message-ID: <dc46744d-d09b-4318-a169-38907f284128@intel.com>
Date: Thu, 16 Jan 2025 18:00:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/14] iommu: Introduce a replace API for device pasid
To: "Tian, Kevin" <kevin.tian@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "will@kernel.org" <will@kernel.org>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-2-yi.l.liu@intel.com>
 <BN9PR11MB527699DB033F2B192DC120EE8C132@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250109144315.GY5556@nvidia.com>
 <2ab7fb0e-0351-4b2d-861a-da6f72138778@linux.intel.com>
 <BN9PR11MB5276B732FCEFCB6254A9745E8C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276B732FCEFCB6254A9745E8C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA0PR11MB4718:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a3c867-a3b0-47a2-89c3-08dd3613dab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bit2RVVBSkpFYU5xRVVjU2xlaExKWEcxRmFtSWtnMzZVWTUwVnhYZjY5dUxt?=
 =?utf-8?B?eGhidVE3b0pZZ1pRT0FzVGF4Z2N5eTFDSHVTSEdvQVpGbytXdCtVQkVpQ1BC?=
 =?utf-8?B?b1hVOCsrNkpJWHBSOWdTU0hiQnVXREhCRFljSS9lVHNpZEk3TUV2b3FwSUc2?=
 =?utf-8?B?a2ZCR1g0WnRoVU1yclAwTnFzeENKUDVzUy9wQmVVcGpUUGhJWHlYSGNsVmZy?=
 =?utf-8?B?WjhVY2NZR3dEemhyQkw1dlpwVE9GcTgyTXdKR2tWOXV3NjBzRXFEMk8vTmow?=
 =?utf-8?B?YU9OS2ZCbTBZejVkYjYvUGJ6WWtiUEVkSkhnTDZpaEhvTXhIT3JGWnNtd1pV?=
 =?utf-8?B?UXdmc2lGeXJPOXVyNURtU1crck5Bc3VpdlVNTk1WR3VldlFNaWRaYjVrYTh1?=
 =?utf-8?B?cExLRHh4b1lidUNPSWM5Y0FOTEJTRlB0MDNaMjRkM3FBOFlMNnVhM3VsRDVt?=
 =?utf-8?B?ZkVETzk1WXlXdnZWeW1Vb25DSEJ0a3dIZWRjWEZuRUpsWUNoZW51ZHpvK1g1?=
 =?utf-8?B?ZjNlOUY1MjZGVEpLOW03SEtJOHd0SDd5TEIzQ1B1RnVJamI3S2NGeGhkalRi?=
 =?utf-8?B?RFo2ekFhUlNjZEZsV3pUVXFRNkJ0d0tpS0xrNHpBZmN4TWEzYlVxeWZFRHJ5?=
 =?utf-8?B?dlZCanVETVE0dkIrbHA4dmJ2OGZQNC9sVk1yN2RZSWYwVFlBQm05UjZSSDdq?=
 =?utf-8?B?SysvdkpLRTA0N0liUEdiZmZYaGFvUGNRWjhsTTh2Y1JzdC8yb1FOamNKRUtv?=
 =?utf-8?B?S2ZjQlJZdEludUpOZzNSb1pjNVJuWEc4K3BaTmVhbUhUVlFDdkJ2em5qUFgr?=
 =?utf-8?B?TWNET1pGM1NNMURrR1k4RlFaVjl0SDlYbDE5YVZqNVBtM2lJMUlHcmhzckc4?=
 =?utf-8?B?Y0JBZHdtTmk2eDdpNVFhWEZRbDB5bmszcTZhRHU2SmRVOFBqczVQRzVocW1H?=
 =?utf-8?B?TDE3TnpZNWhKdVFnUzFvMHMra3NSaG9lSVZqTUQxTWVOQzJ3SnZ3bEpvU0F6?=
 =?utf-8?B?cXNGbFNtUjVPRno1Yi9LQWFrMWs1WUZ2QUNmbHdVeFNvUWpodEh1bG5nT0xP?=
 =?utf-8?B?dWlvQXU1c0ZJalpwZTJkczBSc2ZRbGx3d3NjZUZtVjJWQU84SG1wWHBWb1RY?=
 =?utf-8?B?amVTYVNBYUpKTEJQNlF4RHMwU0V2T2IvWWxyMElxT2NxdHNNZ1ZQbmtVQmxq?=
 =?utf-8?B?L0hEM3ZaaURvL1dJb2ZRYmlZYWJKT0s5V08zRk45eVlnUExNU3NOajZDK05D?=
 =?utf-8?B?THBoOXFqYUpVUG1OL3NSeGRscTU0dk5mdExCSC9sYnB4ZDlBektBNVVrQmxW?=
 =?utf-8?B?R0lpL3BkSVZCNGVFVEFYNmVMZWFpV2JCVFRGLzNXTVVnVzB5alhDdE03S1VP?=
 =?utf-8?B?T0FqQUJ5RlpNbW5OYWF1d3ZJV1ptcUVweEVIR3lQd3JReEJDY0NKVmxCTG9j?=
 =?utf-8?B?eTNsR25tNWFReENGWFh0YzNTNmFOWnVncGxiN1YxSmIycTJ1Q3B1aVVTcmQ4?=
 =?utf-8?B?NVc4STVlYUNsaWxxTjVKTEpPS2ZIc2pRRUkzWGxpN1UrY2hXazZGMlhneVJC?=
 =?utf-8?B?YUt5NStqUjhYWUdzdjV4enMybnZ1Kzh4SlIzcHBGUWhjOSsrOCtOczhyenJN?=
 =?utf-8?B?ck1sNXdSbnpzMm94UDlabExIK3BYTE1sWjFLZ2EwWnZYdHN3YW1pWXNDUG95?=
 =?utf-8?B?OWJ0MlMyNEhYaGxoVFo4OGJZZlQvR3NGdUVkOERLMkFiSUNJQkVHd3VielFS?=
 =?utf-8?B?NmgyRGNkdVJoWVBTREJad3d0OHdyQlhhbk1zS3daQzIyajgyTWtUN241NU0z?=
 =?utf-8?B?M1pDRmR0ZUNZRzZUMk14bVRDdVFwdDNiUjB0ZUlmOVFMUHBPVnlXUlQ0dlV4?=
 =?utf-8?Q?bQqHhOKHv+D6z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REFDN2tJVkh1QnZJWEdiZ3RRQXA5NnhPenBPSUJCSEZkb3RUYjJ4a2NtT1RX?=
 =?utf-8?B?TDBuZDFlSVRtUkZ4bVNnbkdsWXNsQnpVUmR5dzMvNkFQS3Q0WHlnM1pWZTRP?=
 =?utf-8?B?MlMva3JFTFZkeXBzRmYzbElHbUgyTFFNVy9tU1lHSzNRSkVpYmVaMGp2dFV3?=
 =?utf-8?B?Uk5CVkxqNkN0aGw2Nm9xbTRadU9oSlVGMmVyUHJUTTduaWJ1ZEwrMDN4MlZj?=
 =?utf-8?B?elRTTWZFN3hEM2tjblRzMDJxQXk2S0FuRmk0ZGN2aXVZVlFSTnQ0YVh6ekM1?=
 =?utf-8?B?SFROYnNYeFhaOUk4M2FlemtQR2ZRSFhnT0FYeGtxUzZDQmdxRVpieGtmUUxs?=
 =?utf-8?B?YUg3cTZXMEhBQWN3ZlF6YkNuR0d2aDkwTDE2aEEyanFHZXBZNnR0NnZJdjZG?=
 =?utf-8?B?OFFpMWkyRzVObXJMWlhsajYyNnhsTVM2blZFMmxSbXpXalJpWnRlNDR4YXNp?=
 =?utf-8?B?V1JLZW9STmdRRXhQZEZJWmhJcTlQVTM2Q3ZkZGlqdnZTanhJUFBzTkhINHpW?=
 =?utf-8?B?K21YTmYxSWRvTmFXZjlITnZDWEpYQTRyUnpnMXV4d2NvOVN4UWhDMzh5OGtK?=
 =?utf-8?B?K2UxUm1HVkJZV1FJOUNrUmcwOUFjblROVjM4UklrcXZBazA0aFd3QndocC9p?=
 =?utf-8?B?QmlwUTNUN1BtRDI5QjE3OXBuUjRUSlRRYThDMUtZbDNoUmgvRFA2enI0bkgx?=
 =?utf-8?B?ODVoREhOTkMwdGpvNHNkUGVvdjd3N2dmR29VUTFyVHMwTVMvQm5aRVVwNjNJ?=
 =?utf-8?B?bTVRZWFXWmlqT1llT09ORXhtc3cvRHF6TzhNUERZeFhidk5BcGpGeVZxRlVa?=
 =?utf-8?B?c2dNMXc1ZGt5ZENUSlF3QWhIRFYweXJOVi9HVlVoNENmZ1h4M1A3Mk56MTJh?=
 =?utf-8?B?QnB6WEdYbHlDVHhyQ0tXTjV5dXZRY1RialM4YUFWcy8ybGZTZ21HZ1Z6OWZp?=
 =?utf-8?B?YlJ4QzV6cVBqOXJ4SjdlZlBydndwS1o3cE1JNmhmTzFFZWtTKzZHaS9iZU85?=
 =?utf-8?B?dWwwcWlXQVRMWlNReEtVa0pWYTNJYm0yd25MNmxKZjNKRlhwNk9IL1lHSVhO?=
 =?utf-8?B?KzhobUJVN0k1dkE1VXRKaytiZGhYT0tVSXcrRC9Qd2NaS2dncTgwd2FZSGVE?=
 =?utf-8?B?a1pyZTN3QkNkdUM5RXdFOG4zVkxyTU5qN1N6TW8wVk9KQjNlRmo0WThjcG1V?=
 =?utf-8?B?M05QSDdGbGtILzJ6TDJiV3VJL3NvNDJsTm5RcUliN3VwZG9MaTNtT1NsUXRB?=
 =?utf-8?B?QmJmRWR4MWJQU0U5UGwrbGY3SVMxWmRNTTRaSktSTUMzNktISzVJUnlHdldD?=
 =?utf-8?B?YVJvRHNJWkZKZlM4Tmx0ZGJlWklJOW5SR3Fpa29MMW9vM2c1c3JGT01sRHpX?=
 =?utf-8?B?Y3pjdHhKQzMvYjBlRldCSjZyZTM4YVU0REloLzdLMFUyaGMrV1BZV01Ud0JN?=
 =?utf-8?B?YzhoOEVXSWN4ZnBpNmpHWGJaOFRkejllNU0xbXAvUklpd1lkNmI4enl4MXg4?=
 =?utf-8?B?V0F2MDdOY0NtTFJaT0U4VTBXVnJUdEpTWjMzVWM2Mi9OUHptaVFHQWF4d3Z4?=
 =?utf-8?B?akZKSDJFK2FLUGwrSHZWeklBemtUbVI1MVMrT296VVVraDlZaTVyM3grcmVo?=
 =?utf-8?B?KzgydENWM3hCOHMzZmhES1hRbEp1MmN6L1JSejlQWlU4V0ZXcDFZSFFVaGRa?=
 =?utf-8?B?Rk1oQVg5SE43TmJTNzlqdzRDRWduR1cvQ0lRb21TVFZzb1pUcitCN0s1azhz?=
 =?utf-8?B?Z0dKZ1BOTHNmT3d5MzEwN1hNaUplM2FYbnJ4b3FnWlg3Yis2U3JhM0kzOFRP?=
 =?utf-8?B?T3h4SG4xOXc5Sy9MVDErRmh2NkgyTy9aQllKZkNqQ2l6aTFyYUNCNkdtTDNR?=
 =?utf-8?B?R1lDNEV6VnhNZGU5NjUxYzg0cExDRWFsUWk1NDlIYXlwSjJHZ0I3b3p1NFhx?=
 =?utf-8?B?VDRsQThYeHlMV2M0Vk9OMzFvZXZoSlFBV2VnaEhTenJMMmJRUm9FYXFaU1ZG?=
 =?utf-8?B?UkJlNlZpNEg1eDc3TWEvOGkwRk8zQVZENi8zOS9QNXFKZEMxUkFRM0FZeVE1?=
 =?utf-8?B?VE14dGpxMUY4RU1SNS8wWmJmeFNRYjREUmVTU1BHeTlra1oydWFxSDBmVitt?=
 =?utf-8?Q?eBSLjVkEEGTCve1PhwKJtDOBt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a3c867-a3b0-47a2-89c3-08dd3613dab5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 09:55:06.1057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4Ya/2/OUCMAH5qu/wBnfmg9PdDTBhUyiW+orN41yNH8ELF8s5pqfCMzuOIKijSqYz/3JGzWFGrlqyJzBfzXSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4718
X-OriginatorOrg: intel.com

On 2025/1/10 15:21, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Friday, January 10, 2025 10:32 AM
>>
>> On 1/9/25 22:43, Jason Gunthorpe wrote:
>>> On Thu, Jan 09, 2025 at 07:20:01AM +0000, Tian, Kevin wrote:
>>>>> From: Tian, Kevin
>>>>> Sent: Thursday, January 9, 2025 3:08 PM
>>>>>
>>>>>> From: Liu, Yi L<yi.l.liu@intel.com>
>>>>>> Sent: Thursday, December 19, 2024 9:28 PM
>>>>>>
>>>>>> +/**
>>>>>> + * iommu_replace_device_pasid - Replace the domain that a pasid is
>>>>>> attached to
>>>>>> + * @domain: the new iommu domain
>>>>>> + * @dev: the attached device.
>>>>>> + * @pasid: the pasid of the device.
>>>>>> + * @handle: the attach handle.
>>>>>> + *
>>>>>> + * This API allows the pasid to switch domains. Return 0 on success, or
>> an
>>>>>> + * error. The pasid will keep the old configuration if replacement failed.
>>>>>> + * This is supposed to be used by iommufd, and iommufd can
>> guarantee
>>>>>> that
>>>>>> + * both iommu_attach_device_pasid() and
>> iommu_replace_device_pasid()
>>>>>> would
>>>>>> + * pass in a valid @handle.
>>>>>> + */
>>>>> Better explain why a valid handle is required here.
>>>> Okay, it's because __iommu_set_group_pasid() requires the old domain
>> now
>>>> and the only way to retrieve it at this point is via a handle. It's probably
>> also
>>>> ok to directly store a domain pointer to the xarray when the handle is
>> missing
>>>> but that sounds more confusing.
>>> I had shared a xarray approach to do that at one point, it apparently
>>> was scary enough nobody picked it up 🙂
>>>
>>> https://lore.kernel.org/linux-iommu/20240322165927.GG66976@ziepe.ca/
>>
>> I evaluated it at that time and ultimately decided not using it. At that
>> time, there was no requirement for pasid replacement, so the 'old
>> domain' was not yet an issue. This is why I chose to allocate on demand
>> at that stage. :-)
>>
> 
> Not that scary when reading it again. 😊
> 
> Somehow less restrictions on the kAPI is worthy of a bit more work
> Inside the helpers. I won't be the last one to think about the difference
> why the pasid variants impose such restriction while it's not applied
> to RID.
> 
> Yi, could you take a look and think about any oversight of adopting it?

It sounds like the encoding scheme Jason once mentioned when I first asked
this. Then we would have the iommu_attach_device_pasid() and
iommu_attach_device_pasid_handle() pair just like the RID path.

I think it should be ok. iommufd pasid code will use the _handle() version
for the RID and PASID path. While other drivers in kernel will only use
the normal version. And I don't think we would add
iommu_replace_device_pasid() since no known drivers need it.

Regards,
Yi Liu
