Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB8F1B4C3E
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926491; cv=fail; b=rhGMeK7oqFRdcawBUYs8NsEkzk0jd6xQe8CuUy4p7myp1GZL2/2FYxa2UWwcK6yv8/guLO8MaGImEzS+igVSwfjoTo6Hpng/bkPeIi9fvr2HlLe68jbmo3HpHy2e/w0gEwfF2No0PVknMoRzUm/O44MCE/UcYi3OVu0N7gS4Fnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926491; c=relaxed/simple;
	bh=Bor3Dk8i5sozNpwgWHCf88vARoa23jjdyekL6DkasoY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FgwU3PYmLgCzZ1SRkevYJuunRW2aNl3U0WiNiVlJqdUJGAr/enIm60JnMb6cR7lcIszWPOKVR5RkCe5UoOOdMmdyBetpNSiyzsBEcM+DD+fviraiMWg5oyob8ajf7yBLXN+cXKynUx9k2/la+G+UuE7EoUjm+jMSpr6MRtDF7Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U6W9oWqF; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U6W9oWqF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719926490; x=1751462490;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Bor3Dk8i5sozNpwgWHCf88vARoa23jjdyekL6DkasoY=;
  b=U6W9oWqFV3MghUagoLaZdgVVOJy1XnVuKwoyANQEOH0TOhZdVpK2wwyA
   V/j79TfL+cQqi1nAgCeoZv5CKolg5yyDEUwbkbuYm0s/LQ/T/fbHwUVhS
   27D0sJObU2zy9SgaPDcaHl92sAlK8KgY2TWxwBiwhJq5lJEllrp3aL80F
   9/ZqaSLW4QjL2bav/8vWrLmm08dSd9BhqhzEklQVyfiKZL52xJhwE1UBv
   k2mO3LHTyIMlxnIywComw3sBR+lPF6WOCXPSgZ33EYsNpWR9iNi7M2OWk
   9Qwnz4p1lkf1OFJI9iUnpP8kmTpqesXPRcr/kg+sL+mq3pKCG+nDXjS6u
   g==;
X-CSE-ConnectionGUID: +uLiZV30RK+OdWrEzWTTaA==
X-CSE-MsgGUID: zUDMP2+GTGioswzOax+Rvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="12357425"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="12357425"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 06:21:29 -0700
X-CSE-ConnectionGUID: T8FbgESnT9622M1eL6tdRA==
X-CSE-MsgGUID: 7YzqY/foSHSg3hcdXt/nVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="76628004"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 06:21:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 06:21:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 06:21:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 06:21:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 06:21:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctc763zUFnEa4om4tIFhJSlXZXcQ9n9au5QEapboN6AwaBqaymPG0Xzf4H0xL4ttcgUaJCYT2wQl1wP8k0q+Oh0ke4f9HGU7KSrXLMBoAx+RyfQzuG5koNMT0OMbS/UduuSgWOp4g62P/K9ldYuC60uWkR76XfQAgJ/R3glth476dKsOBaosz5NVRjeglJE/NA34eNJGfjG80FgY9ieM+C/4TTWFNpCENQkTE9kiGAz7H5sqCysZKUhTlzjaEvzJvrsQjo0NGpg2fTR2OlU4CdS9zFwsFe4c1bf2PEem2IigeUJO6oTZ348dxLGlhQlKIMUzQFwN6nnV68eo9nFuOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cz4bdVftIeQZUHS/GyAi2myNuOxJ0nnZ2FIX5Ly8hD8=;
 b=Us6V3s7FWpSRxxlWDE1FXquPHKySaofBAKATHne7sJko1t/g7pS2JLBX9peeL8Jw0/DVhjObVINTkmag8krruV+SinJq8HOsj6QSc+erc0AL+jJUDkBvXM+XENyiiNx79kKBzFRaHTQtTnVcL5xc7K3DcPKF8IjheSq+C7db6Z3sKyJwVa+jy0ylfQdrLz0spxWCFAtMdIUChwQ6C92EpzdWGhVLVQvUnjFE6IPmFLxrbWRvecZf3yZf3gdMAvGVn4SBiPqB6iaXi0IcnIarm88mpECbUVVsgkbOtOCAByuqwDcEa24utRhJiEy6KvsrcTyt+KYKP1355ZDSXXDRBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CYXPR11MB8711.namprd11.prod.outlook.com (2603:10b6:930:d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 13:21:26 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7719.022; Tue, 2 Jul 2024
 13:21:26 +0000
Message-ID: <d6e0ce90-a188-41f4-aaaa-ccbbeb605666@intel.com>
Date: Tue, 2 Jul 2024 21:25:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] iommu/vt-d: Add helper to allocate paging domain
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>
CC: Jacob Pan <jacob.jun.pan@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20240702130839.108139-1-baolu.lu@linux.intel.com>
 <20240702130839.108139-6-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240702130839.108139-6-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CYXPR11MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: 5349d084-b5c0-43b5-68e5-08dc9a99e006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGc2S1RPVlBQNE1MUzZRWXlRUmhiZGV3SzdCSHRLdkgzVkUrdVFINEoza1RG?=
 =?utf-8?B?QmZIcUZFQWppOGJRK0VudkIwdzdabXUwaWpIUkFvU3kya290QlpxdmU3d3Vv?=
 =?utf-8?B?R0VLOWdNK2JuRkRST2VQZ3B4WmJiYlZNQ0NBSXFyT2NkelgxendqZFU1cUQx?=
 =?utf-8?B?OE1FZGdQUGxjcXRKaS9XVERZVmcrN3NYR3BQZVZvNlM0NEpwQkkzT0gxek5S?=
 =?utf-8?B?ZmxIbHp1eWZ2UHJzSVkxb1VzWjhBN240Y1FUTEZ1WTB1ZWthbXNPa09GZVRa?=
 =?utf-8?B?VndTK1hRYjU5dlc0NXphNEFOSUJEUm5CYTlOWnFEOWlZbVpZUC9FdzlIWUds?=
 =?utf-8?B?REFqbW96Z3JGcGYzMmVkMmU4d1ZnUkhFMjN5dkUzbEg1Ym1qU1J3c3doU3JE?=
 =?utf-8?B?UUo2UEhqczIyZ3BuK3lnRS83OGxRVGV0ZWZmNExzUFBMSXJPTXU4QUppRzho?=
 =?utf-8?B?bFhpLzZZcDRBTVdwejVYdWsrM0hOdEN1WGVYalhnRE9GSVN2VklVWkp3T1hl?=
 =?utf-8?B?aU02ZXEwUlBONHVzS1FRcTdKL0grcVg5OHIrU1JhNGJLeFdUMFNmYjF1Z1JT?=
 =?utf-8?B?TlIrL0trVEZqTkhmVXRzNWF2UVNhV1VjNDB6Tm9NeDN5dFJKQXZ5dktaMkdS?=
 =?utf-8?B?bm14WlZJNVF1OVVkT1QwNDFZMFBKS25yOG0yWEt1UXhEVUZaOG5GUWtLUDBD?=
 =?utf-8?B?djh4elk2WXE4d1hRRElNbjFlL0d5MWpiMkZyWWpIblkzR0srTGRzLzR4YTlU?=
 =?utf-8?B?YktpQVAyUzg1Vk9Pd3NjTjRRVEV6YmFNRFA3eWNmVVUrdDBmVVppSS9YcFM4?=
 =?utf-8?B?SVI4cVMyZDVCc2RlSlpIL0JoQU45ckpZRTdYbmw0Y1lNdzVtS3U0dzBMRXJp?=
 =?utf-8?B?bmFObHhzeHpoWGlOMk1wR21PRWkzN1p2emZwc2w0U1c4Ny8yQVc0WnRDS0ti?=
 =?utf-8?B?Zm4zVTRpRDJ6YTF4VmpoT3k4MGNOa3ltOGJrVjNPcUZaNlFBN29VcEtvUHF6?=
 =?utf-8?B?RzdGTWRnRFFYS1NkNXpPV09yNVUzTlViR0xPdUV4M3BYUWs2cjJXemorNTkv?=
 =?utf-8?B?TVhLV1A0NXNHR2QwcnBzMzFWQ2tnVGFIdW1MVGhEbklTVlM0QjAyOHNPWGVn?=
 =?utf-8?B?MGdGRUdwbVkrS2N1Uml6M0RXTFFaSjd6bHgvLytQTnlyS3l1UVI0OUZzcGNR?=
 =?utf-8?B?NjhseEZ1SkhOK01JdjBpWjkvNk9aRVlyUE1OVGMySDBrNHplTzNkQ2ZyZ1lD?=
 =?utf-8?B?UHptVjRrNmxkUVZIUndWYTgxMjU5S2ZxcFh4L3N2K1Y4bzUrYlpjd2lxVmtC?=
 =?utf-8?B?Zkp0dmlEZW5Fa3dhOXhEa0xYUzhJdDR3MUpLbTdZT3pKajdrcDZqVjJIU0tv?=
 =?utf-8?B?TzJ2MEN2Ukg2NGRBY0lZNW5sL0U0TDVONGdoMTlPdEJUM2MwR0ZVVDJ4MjQr?=
 =?utf-8?B?VFJOZVlpbDRlaGZJRmwwLzZFVFlaT2lXZGpSTlZVSS94N1cvc2g0ckNKSmYw?=
 =?utf-8?B?VGQwc0pIMGlhWU9IaUZMUzZVUCtnaEl0Q2UxTjYyd0piTUE3WDBUcVZZekQv?=
 =?utf-8?B?bmNJaGNMYnFyTit5ZVF5SWw5L3BQeTc0MWtGbjQzVERaUTJ0S0doMm5EOTZR?=
 =?utf-8?B?a0VuSjhKcDdyWFZzUXVxVnNOSVpRb2VWclpCVmtadUlvMS9jTC9SL0hYODFY?=
 =?utf-8?B?bzFZYVBqUnpVbGpXcVNGUTJLa1pYdk12UjJUa1Q1bkpRSVQ2MEt0MkVweTRZ?=
 =?utf-8?Q?m7TNnnGELUphhi8MrE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUtLQkhQMkxSbnZhbjZmTGU4TDFKOXdRSmRObS9GZHpFbWFheFJsR1NaWmdV?=
 =?utf-8?B?Q3BtNklZQktQMUtHTk9pTnRIMHROSjR2d0lTdlNFdHgwc3UwQjhhY0thU084?=
 =?utf-8?B?RFFMdjd1M0RFRzE3eCtCUkh0Qm4xZklkWXlqVytDOVE4YmIrZThQanZEQ1RU?=
 =?utf-8?B?ejFqZld4SThpSVNzUCtZU3B3WDBGdWZ4cEk0TnUzdkN2ZWRydGJLQmFQWGh4?=
 =?utf-8?B?eWQ4RVlmUlBQMFdVVzJXMGpaemduWXdRM0I1Z2MyazR0RnFwV3VmMEVBeHRV?=
 =?utf-8?B?ajFkNUVhMjI3WEZMTGxsR2hub3lsa2RyYVk4dDBVVzJRekdXdUh0b1J1WWtY?=
 =?utf-8?B?WGdFYStnZmZUamdiYzNOSjdnRHg2Y0ZObG5zTTBIazJBUWJ3T1c2ZU5qejRU?=
 =?utf-8?B?YWlwako5ekJEUUV1d0pQdmVkL3p0aWxocVNNNnM3cDV0Vk1ha1loeWZhZ3Fj?=
 =?utf-8?B?dnhzYXZmS1dXRWE3YU1SekJWQUNLS0lCcVI1TzUxaG4veDdXdngyZWpOMmhS?=
 =?utf-8?B?ZTZlbktBUy9VVTN5ckpXN0htTkp0WllmKzlxTlJJUE9nbmtndnBmMVpiVkdv?=
 =?utf-8?B?ejhDekJGbzA1TkptaWdkR2NIQmRWa3RZdnFQbjR3bGI1MkU2NGt2eVRHK0NR?=
 =?utf-8?B?dEJMRzVZT0JKMzlnaXRvNjNqam5PYys2SmF3Z2JreUdFRlJXckp4SmFXTW9B?=
 =?utf-8?B?MUc4N3pvUXFpYzQvQ3RWSmp3ZGpMcGhJN0F5M0RvanljMzMrVGVabU1HaDBH?=
 =?utf-8?B?ZHd3UURFK0UrT01tckU3N3Q1YnNwbW5rVk5aeXg2MDNOSTdIenBMckpjMlZU?=
 =?utf-8?B?ZUU4eGYzVTVnbkFCTVExWm5mTFE4bnlzVHFMaHhvL1lWREwwaGFwblhvY3Bi?=
 =?utf-8?B?NlQ5VW9tSEdlOVlFTUYrYWkxNXowWjlrVzhock5IZDdGbGNscW1ERHFkVlVh?=
 =?utf-8?B?bTFydmVQMUFZNTZhTVhORjJML0RseTR4SyswUG9hUk54bXJpR3Q5bWtENEYv?=
 =?utf-8?B?U0ZJdEg4MHBUYlViQmRaYkpwU2hsRkE3OUg1c3J5bzQvbFpkd1ZVZkxQWEor?=
 =?utf-8?B?UjBWbm1NYkZTSldmWVluMStqdk94OEVXQUs1TnpBK0dTdGhyQUw5MXpSRmhn?=
 =?utf-8?B?cVN4QUpRRmx1OXBnb21yQzlEaFJuMzlMZVhFeWErdWhBckVsSGp4WHo3VjVm?=
 =?utf-8?B?L0JLNmR0bzdHNFBNcWxYYysrTFdVR0Z2VE1jM3p5K3FlODhFb1daVDlYS1Zo?=
 =?utf-8?B?WWxEVlFYZEY0MnVaZzJjMmkyNHhXTXFtaHFjSFpjWDdLc1BJd3cvYW05Sldp?=
 =?utf-8?B?MWhjb0NvbmZyeUNjbktXeUJZU1U3UEE3RUlVelkvQ0ozbUlWZUIrMEI1dkIw?=
 =?utf-8?B?MXY2NHJ5NWsvV1UzM0lpekFMcVdUb2VwU2NMbXhsZWhZUjVzaytnWGpCMjAz?=
 =?utf-8?B?Nko2Q2NNZWxOekcvNkF3a0czQUVHeGZHbEpGL1FtcTNRYW96QnBnSWdLTXpU?=
 =?utf-8?B?aHBaRXFQaWZLRmZKek9LVDZ2R1dnZHdUTFpLa2Z6RTlrSzNuTkFqbXBZc21D?=
 =?utf-8?B?OWJ6L2xncENyay91eHJzY0xuc1FKRzU5ZzdGNDcyQ3g3aE5xNHNCaHFDQXIr?=
 =?utf-8?B?clQzQk9IcnkrUkFMV1ZqMzI2ampOL3EvL2k1ZEF6bHFicEN2VUYxYThHQzBv?=
 =?utf-8?B?dEx0aFZ5Rjlkclpyd0JnT01jZ05sMUdJM1ZDMWhLZnliM1ZQbHhsZlhDRy80?=
 =?utf-8?B?VmFVTVN3aHhFQ1c2eG04SkVvcWlLS09WWGdQMjcrT25FTTM0MGtVbE4zYldD?=
 =?utf-8?B?UWlGRE5RUEt6a2pjaEFEc0poNXpkUGtZL1ZLQkRtM1JrbmlnSFdhRDJqbkZZ?=
 =?utf-8?B?djR6WXRPQ0d4WlVCYkNUQ0Z3bFFLN0F3OTIzMUs2WWJlS25CdTVuRHdBMTJZ?=
 =?utf-8?B?eVVncWlqdkN6eFlnU01JT1JPSmpIZ0lJUkhIdERnR3ZVQjgvZWJxQWk1bndD?=
 =?utf-8?B?dU5EZVNqandGT1Q2NlZlUXBaZTJpcUtSTFFPKzBCKy9vMHRBVjdTVVVUQThP?=
 =?utf-8?B?ZVpTQVB5TW1uV042ZlliZjJidFhFOXlLNW12ZHAvZ3gvR0pPMmc0aUpHVnMz?=
 =?utf-8?Q?oSrmX4TgGxZzTQHjhtjDLjZti?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5349d084-b5c0-43b5-68e5-08dc9a99e006
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 13:21:25.9618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+s7N61PS4mtetWwq+s5ElDbIT7kXMeWS0/C3nm2mVxbvYNpKlPo6W2WuCiArBfQgZdAB6EWDBPymJ5Sw6IocA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8711
X-OriginatorOrg: intel.com

On 2024/7/2 21:08, Lu Baolu wrote:
> The domain_alloc_user operation is currently implemented by allocating a
> paging domain using iommu_domain_alloc(). This is because it needs to fully
> initialize the domain before return. Add a helper to do this to avoid using
> iommu_domain_alloc().
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Link: https://lore.kernel.org/r/20240610085555.88197-16-baolu.lu@linux.intel.com
> ---
>   drivers/iommu/intel/iommu.c | 90 +++++++++++++++++++++++++++++++++----
>   1 file changed, 81 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 1b5519dfa085..1f0d6892a0b6 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3622,6 +3622,79 @@ static struct iommu_domain blocking_domain = {
>   	}
>   };
>   
> +static int iommu_superpage_capability(struct intel_iommu *iommu, bool first_stage)
> +{
> +	if (!intel_iommu_superpage)
> +		return 0;
> +
> +	if (first_stage)
> +		return cap_fl1gp_support(iommu->cap) ? 2 : 1;
> +
> +	return fls(cap_super_page_val(iommu->cap));
> +}
> +
> +static struct dmar_domain *paging_domain_alloc(struct device *dev, bool first_stage)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct intel_iommu *iommu = info->iommu;
> +	struct dmar_domain *domain;
> +	int addr_width;
> +
> +	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> +	if (!domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	INIT_LIST_HEAD(&domain->devices);
> +	INIT_LIST_HEAD(&domain->dev_pasids);
> +	INIT_LIST_HEAD(&domain->cache_tags);
> +	spin_lock_init(&domain->lock);
> +	spin_lock_init(&domain->cache_lock);
> +	xa_init(&domain->iommu_array);
> +
> +	domain->nid = dev_to_node(dev);
> +	domain->has_iotlb_device = info->ats_enabled;
> +	domain->use_first_level = first_stage;
> +
> +	/* calculate the address width */
> +	addr_width = agaw_to_width(iommu->agaw);
> +	if (addr_width > cap_mgaw(iommu->cap))
> +		addr_width = cap_mgaw(iommu->cap);
> +	domain->gaw = addr_width;
> +	domain->agaw = iommu->agaw;
> +	domain->max_addr = __DOMAIN_MAX_ADDR(addr_width);
> +
> +	/* iommu memory access coherency */
> +	domain->iommu_coherency = iommu_paging_structure_coherency(iommu);
> +
> +	/* pagesize bitmap */
> +	domain->domain.pgsize_bitmap = SZ_4K;
> +	domain->iommu_superpage = iommu_superpage_capability(iommu, first_stage);
> +	domain->domain.pgsize_bitmap |= domain_super_pgsize_bitmap(domain);
> +
> +	/*
> +	 * IOVA aperture: First-level translation restricts the input-address
> +	 * to a canonical address (i.e., address bits 63:N have the same value
> +	 * as address bit [N-1], where N is 48-bits with 4-level paging and
> +	 * 57-bits with 5-level paging). Hence, skip bit [N-1].
> +	 */
> +	domain->domain.geometry.force_aperture = true;
> +	domain->domain.geometry.aperture_start = 0;
> +	if (first_stage)
> +		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw - 1);
> +	else
> +		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw);
> +
> +	/* always allocate the top pgd */
> +	domain->pgd = iommu_alloc_page_node(domain->nid, GFP_KERNEL);
> +	if (!domain->pgd) {
> +		kfree(domain);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
> +
> +	return domain;
> +}
> +
>   static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
>   {
>   	struct dmar_domain *dmar_domain;
> @@ -3684,15 +3757,14 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
>   	if (user_data || (dirty_tracking && !ssads_supported(iommu)))
>   		return ERR_PTR(-EOPNOTSUPP);
>   
> -	/*
> -	 * domain_alloc_user op needs to fully initialize a domain before
> -	 * return, so uses iommu_domain_alloc() here for simple.

I think it is still valuable to note the requirement of full initialize
a domain. is it? Otherwise, looks good to me.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> -	 */
> -	domain = iommu_domain_alloc(dev->bus);
> -	if (!domain)
> -		return ERR_PTR(-ENOMEM);
> -
> -	dmar_domain = to_dmar_domain(domain);
> +	/* Do not use first stage for user domain translation. */
> +	dmar_domain = paging_domain_alloc(dev, false);
> +	if (IS_ERR(dmar_domain))
> +		return ERR_CAST(dmar_domain);
> +	domain = &dmar_domain->domain;
> +	domain->type = IOMMU_DOMAIN_UNMANAGED;
> +	domain->owner = &intel_iommu_ops;
> +	domain->ops = intel_iommu_ops.default_domain_ops;
>   
>   	if (nested_parent) {
>   		dmar_domain->nested_parent = true;

-- 
Regards,
Yi Liu
