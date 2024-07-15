Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594644CDEC
	for <iommu@lists.linux.dev>; Mon, 15 Jul 2024 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032942; cv=fail; b=ZyhQ5S2voIQuZVJOnM7m9lVmim1FmdzqH2u9yavD719fL4L1JkbR0ZaUgg4ozEEd7H3fyPKVeBKB02qxh3BeIMslrr9x39xmnM2qjrXJF7SMrN6R6yZsfB9lY/sIhM3iHOgjIXAOIjibt5skflqe3+O1xPfn9hiAiP+p+lqRQRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032942; c=relaxed/simple;
	bh=7Es7GIQsu+2PTq865so903gXiJZHZAMF0+CO+/RhPEQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=czcY2md/sDuspkCyarzq6/ZlighkIZkYgXSFRi3ig/BkwG6CYZLUebyK5nbYIXGs4kD8hZb5ky4iyj+EEcECNwLcCNHwhH/Wg7IMLEeuv9td3iGeEAzHDkKVMhHDJYmB1QyWUjgXvEN6V+KjVJlKrisNI60lRjamP/VsR+mhbJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbdCUkeq; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbdCUkeq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721032941; x=1752568941;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7Es7GIQsu+2PTq865so903gXiJZHZAMF0+CO+/RhPEQ=;
  b=lbdCUkeqKc+1eQ7dnP3P+ueV6CWSPrlVmvJxlSGudna6WT5rJWMbXs43
   LegcTLC3fLlmtQaCo5z2GDYOopJAoOlKV12GvMOW+xaObtmFGwfS0XtqI
   ecz/0V/U3PSJ4+Tj6Wg8LiZaCh4GEd4EYLnf7R4Q7Vc4nGlr+O7B4Yy4m
   tE5zqhQdkF1JSlzrW4bwgvXPkjiRoshSPjPMgZYImhNORl6HBYunNgOVm
   lAnhYWq2SbXQUc1+l/xx8aCzZjqUyaBNnl4Ji5Xua0N+cT7RHu0s4J+oO
   fvCSpNOcWiDV7zXmSPZ4jqK7kd0W0VVu7jJX3SxZgOQK2JiWbUnzyhSVm
   w==;
X-CSE-ConnectionGUID: bdecwl8OTyWSt/RcIio2sA==
X-CSE-MsgGUID: gYaAg7/ITOaYtCmp01iUNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="22213366"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; 
   d="scan'208";a="22213366"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 01:42:20 -0700
X-CSE-ConnectionGUID: r8rIQTY5SFyV6lYulbAp/A==
X-CSE-MsgGUID: mafO8pZJS1ezToYO+OPq1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; 
   d="scan'208";a="49435817"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 01:42:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 01:42:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 01:42:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 01:42:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w55fC+WgF2gOFOmGqufzDh9/OpTJiE/NjABjqg5P/MDDqRblc3G0Tc8vTybZ0oimyU6jhjhE8m4aFSQni94Y+OXUln/YW4ZTm/4CDn/scbYErniPCzBFwm2SLfGLt3pdJ42h4Y5tYzv/KhP9flEuTaC6qYC0fdcUOcdxAcWR/2jTBQ4yyZk1fw/A+ChZnGCIJ1bdGLby909bdEkcjkZuJHG02thrmNJGSQmCfI1Q7hbmFyUpogqHwwXcNpOookrH+N37ISzdhcJKriDIBwdDe/CFXgCcwRiNU3ALqky2O03+C7od0QyZVXCb3H65p8poSl7WS/Lq5Cwn2GdxGK3Bng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xu+AYhaTQVFI2uBQ7MBgTtMqVME/U24o6p93B5byJg0=;
 b=mc13m2xlrARAPMjaK9sU4Jhfsb6nJTbkK6Y+MkYEQgNR7K9yUV/bLJO0Rz96SX3YLQsdT5ocJgcKcUvCRjFl7A9r6DipNw/qssoD3+hSmmOUmY0hg4D1GHqhnc0neuMm2bmlY6Jqi13n/YZVbzrzgDjOW3VQfXfepQgan/+lpw8q5oN4vkNJ3aSL70+erKimzU9ioe1T2oqS2S3GzUhtvtfczO+GPGdo4Lyau/4MEnXwqq0DVN6p+36UVegnOMuBpZcMo79Xro2JS6L/aLoVqVSg9seNFw50NWY4TFe+G645hmrMUk7Nlnz6faEBIaJTWPXpfMCvOmqMRyM+FqzyWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA0PR11MB4637.namprd11.prod.outlook.com (2603:10b6:806:97::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 08:42:17 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 08:42:17 +0000
Message-ID: <d883b222-4468-47e5-a370-19a9ef517c58@intel.com>
Date: Mon, 15 Jul 2024 16:46:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support AMD
 IOMMU driver
To: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <joro@8bytes.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Baolu Lu
	<baolu.lu@linux.intel.com>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <20240628130330.GY791043@ziepe.ca>
 <26524622-971f-47f5-936e-d0173d342288@amd.com> <Zn77FbsQWmByf16t@ziepe.ca>
 <1f8f04e5-3b70-45de-bd93-e3c96fb0a555@amd.com> <ZoLmyOzOVYGLKjmn@ziepe.ca>
 <68d300af-4d3d-497e-9338-d99dbf88dd21@amd.com>
 <8bfc6cb7-d2d7-4d4c-9970-f4f207fb54b4@intel.com>
 <20240709182303.GK14050@ziepe.ca>
 <3eff5c86-8b5d-491a-955e-794198350ec3@intel.com>
 <20240711234917.GW14050@ziepe.ca>
 <35ff9f32-ae60-4124-9ced-42f82c2b4f93@arm.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <35ff9f32-ae60-4124-9ced-42f82c2b4f93@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA0PR11MB4637:EE_
X-MS-Office365-Filtering-Correlation-Id: 671190eb-3145-4aba-22ee-08dca4aa083c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHVGaVU3RXRqSUpHQmdoN3JGNTVmYnpkT1VEcjRWY0szV0RpUlpLTlNrdU02?=
 =?utf-8?B?TjlnVTRTMUpqMFlDSDRIZzFFTE1DQnBKcTNNS0Z1c1dib2YyRmZJczUzSkk0?=
 =?utf-8?B?dWk2eWRaMVlVTGowMk1tcHcxUFI4enJ5S3dMY3B0dXdhdDJ6Sm1XaVplT0Ny?=
 =?utf-8?B?cXZuWldEbUlRQW1vUHUrNW5kK3kwdzJKUUJmT3hob0tmR2h6Wm0vTzNIN1FO?=
 =?utf-8?B?WHhTOWJPSVN5TWxrSDM4VTVoZ01MTWo2MnQwT3o2aVM0d1hNUnM3NXVHazU3?=
 =?utf-8?B?QkkvUWlzT2cvbmtTa0ZsLzNjVjVSZnQyNnJLN2VVNE90MlVBdVliQkd0WnlB?=
 =?utf-8?B?ZGRBaDBXVEN2ZzFBRkZmRVU1TVJ4Mm11d0ozMDdkdFIvRnVZbVV2NjBsM3cx?=
 =?utf-8?B?cWJSblBBREJmMFRxc3RUOGpwWTE0K00wdGN0WmFrb3JTaFlGRjFzYXZYVjJq?=
 =?utf-8?B?UHdRSjgrRndscENCR0lOU2pBVzl1WkR3Q0VGb3pEUHNiMG0zUVl6eTY5TEdx?=
 =?utf-8?B?WnN2RWZ5Sy9QdVJOSmRldHFiMmFPREVHTzNIdlVsUFFoREVZTEd2SXZnVnZ0?=
 =?utf-8?B?QVZETlIxMG9kUnRtN1hIbjVXWTEvYlg1OXUvZWt3cnh6amlrS3NEbXJxTHZr?=
 =?utf-8?B?Rm1RcWc1eTJMT1FQV3laa1N1N0MydkRHQmg2QWVEQ1RiN2VzK2ZKU0dzOGJE?=
 =?utf-8?B?V1RvS2tqbzVuLzdzNmtLc0k2c0p3aHd1dm01V3ZVTndNL29BNG9YdGl4QkJp?=
 =?utf-8?B?OXR0Nkc4bVhDL0srUHVlQjNqdnpIeURHVzVTUzJjSzQvQ1F1UmMrMkd1U3ZE?=
 =?utf-8?B?dUFFU3p6VXpLVlo0QWlaWkF0NG1adHpwNUlkSVp3U1NkaXVZTkhiNXkyTW8w?=
 =?utf-8?B?SlFkenJxWW56NU1WY3RISVRHcGtXWGU3VEF0MW91ak9DZVl1VjNYK2dvRUNy?=
 =?utf-8?B?ejFwdHhBOFBRRXF4ajVMdXIweGVsazNtYzU0VU5kVDNPc0Z6dEZSeFVNaWFM?=
 =?utf-8?B?Ym1OaDBZc2E3TkxyWVNEZnBkU21SQWpOWHR5aEdkdEVhTVhTMWU4TjducW51?=
 =?utf-8?B?TlJCL2N4cnBmanhubmRoTmVKSzJnOWZzS3VKdVN0MldTU2h0S2Q2V0tnNWl0?=
 =?utf-8?B?aDZTczlBeDRYZmVWK0M5MVZNSCs5QU5ZZWhIbmtEbC9mcDlNK2FjclpFQjhC?=
 =?utf-8?B?YjhwanpOU2VlOS9nUkszODRhK1FpL296Sld4V2ZIUCtlaGxLSXdJZzJuTGV4?=
 =?utf-8?B?SThhUUxKTjVPZHQvck1McXQwMkk2RFlUQnIwNmVHR0dUWHRjSlZadm1kdjNh?=
 =?utf-8?B?ekx1QnlocERxamtIWnlZczllUlVSbjJnTmFXL3lhMm9hdUo4dzZEOWxsc1E3?=
 =?utf-8?B?aVYxNzdISDM4U3NnQmZ2TFIxN2NoaUhCN0xwdHAwQkNpd1MxeXhGWVN6TmJX?=
 =?utf-8?B?Wmc2VmdWd2tDUC9SSzJSbXFkdEJPTXZYWDB1VVNmYjdUNGxrSVVhRzRhaFpD?=
 =?utf-8?B?QUNzVk04QjNZb0FqYmd6eGVDWFc1SmlCR0c0bzA1MExsMHA3RTFzdHk1YmxT?=
 =?utf-8?B?V00xVThRWmIzdmx1SjdwcXF6Rk5BbG8wZ2t5V1ExcWRzbHZLZmRJSDQ5TGRY?=
 =?utf-8?B?L0ZkWkZwL1c5ZUF1N1FMSVdXRWppaG83QjlzandKenl2QkM4N1dQMlpWeDRz?=
 =?utf-8?B?N1RDU1huczJmZ3BEWkh5WmlyalpKOG9pVi96TXhWVnkrLzR0dXJSR1p2dnZr?=
 =?utf-8?B?TWJEOXRneFlPTFFUeXpaMDUwL2FidHBPa3ZxZDE3cVlJQUFkeTdxNEExY1or?=
 =?utf-8?B?c2hFR1dVMVM3UjdhZmE4QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUNvNnM2ektNbm1XMFAyVVprSHpHVURBRHJISTE3aE9jclF2cmdjT0pKZXVs?=
 =?utf-8?B?ZitvMWtxSkNIc1JrWGVPQzJSQmFVdTgwVytHMlhKM2RUMWVVcmJSRzcvMWlm?=
 =?utf-8?B?ZVZWTzZvNmk0Q1RSR2RNcEp6UmVubUR3anZ3QlRRTURGRmRCek9KWlJVYWdG?=
 =?utf-8?B?MUhOU0Z6ZUNpYUFFdEd0N2ppUTBxT2VZc003NFBuRXk3ZlFYdXhtZWJQY0NL?=
 =?utf-8?B?dXFNb1crVndQQSszclVZUUxnbXdWM0tDbjRKU3JHZ1N0MkkyRm5IMk5xMHhZ?=
 =?utf-8?B?b2htaGJDYmdiS3NwbTVBbGp3ZXMzdEp4Y0p1TUtURGtDYzRDM0MyVk9qTnRz?=
 =?utf-8?B?Q1NYRUpVK3g2dStpdy9HNExhYVljYys0b2pjTUFsd0tHVlAxcUpQb0t6VnNO?=
 =?utf-8?B?bk9WZ1lxc2Z0Z0NQdkRZRTdLNldvQVg5aXBTcUxLZDhlNlpwUGttK052eDUw?=
 =?utf-8?B?aWV1Q2RReWw4VTN0cEhwZlFDOElVcWRneThJWmlLOHdRSEV4TEZldkdWeVNO?=
 =?utf-8?B?TmVaOGN0N1N5eFVSdytoQ2x2MGsydlFCRk16S1ErZlBsTVhMaHNkb3N6RUpr?=
 =?utf-8?B?aElqUkZWdTIwdTVWcUxTOFV1T2tSZVE5cU5sb3VTbms2M2oxcmRqc3dYYnpl?=
 =?utf-8?B?aUZkZHlkbXZJRHFwREYvMFZHcXdJVm95RUJHaTh5R2dWbldNVzY4Wk9jaVJT?=
 =?utf-8?B?c1JCTTFJTVF2Q1VBSE5XbkxFTDBydmJhaE1RTHJpd3F0R3p6Vmp2RnNKazdq?=
 =?utf-8?B?QXh0dU1DS0p6YnlTdWlUTlBxM3V5OUtUcTB2a3VrenFrUk9kNUZ6TTFFS0xv?=
 =?utf-8?B?a2tIbDIvUHVuN21FdmJncHl2NDNLRDdMdGVUbDJCRzFZMEFmZUxuMC9zQisy?=
 =?utf-8?B?TTloZ0JMNnNjMHF1dk9NQ0FpYXpTbEVQK0FHRXVWQXBkbXBzT29rV3JYVk9I?=
 =?utf-8?B?SWtlSnBRSUQzK053K3ZXNG5BZXRJaWExaHlIVFVLUlNYUEo0WmtZQjMrN3Vt?=
 =?utf-8?B?ejl5dlJxU29zVlAwYXdSQTgzd0lLbU1OcFRMdGpKcnJBaUtsQ1V6WHRwaEhr?=
 =?utf-8?B?ZmEwdXhDV2xvRjhKa2ErM1FaUlBxbW8zN1JDbzFlUUw1SXZscWcySzV6dWpB?=
 =?utf-8?B?TVBaRjJUcmF0YkRIem1tUkNaMTl0QjJ4d1Y2T0s0UE1QdWVMZnZnNnh6OU9j?=
 =?utf-8?B?QVFkVU1lSXZSZFZpUDB6YnJVWlRvZDlLVEd5WUNQK2FEZTNTd2tva2tydFdn?=
 =?utf-8?B?dXhYUEZEYWs2cElsR2JyV1BXbkhaNlMxVGpnNVgrdEdMZzRUWXZuVldBQ0pC?=
 =?utf-8?B?VjM4bXQ4SjJuZGIzc0RWSm5RNk5yaC9qd2Q5RnczdUVacFBZYUt4V1ZORzVl?=
 =?utf-8?B?TnBEM2VGOTQyVmJkRGlkOFhCZnVzSGVoY1lHSVNvUHJ6b0FsZWhOeFFOcmxC?=
 =?utf-8?B?OE9pemI0QlBIbWpJdDVFa2NXc1p3YW4xM0p3eXBsSGREVFQ1QmZvL1FMUHJX?=
 =?utf-8?B?NThFeXJYT3lqUmFGYmMrWVB5WUNCTFF0TGhYUWl4NmJ0K0FhUGNHNDluTkI4?=
 =?utf-8?B?OEVZeldUZk9sdmxpRDJLM0ZseldSMTg2SVdmUDRFVHJYd0I5N1o3WCtINVE1?=
 =?utf-8?B?Mm1ZUk01eG13OEJFUXJMVkp6N1FoSG4ySUpnaXpsOG9hb0NmZzRhYjRVd1FC?=
 =?utf-8?B?eTFXbE1SNGt4S0cwV0Y0RjZRcituMzRyM25Eb0Z2bGxZcDFYbm1yMFBXT3VP?=
 =?utf-8?B?VDdUSVk1bS8yWWtnZzZZVmlVZUZSUDlGM2paK3BLUHM0ZXVSb1hVM1FySGhz?=
 =?utf-8?B?eEpMQWRhSExBQ2lFT2p3ektoL20rZUVVTE1RWWlBdldFcnpldnppeTc0dGM1?=
 =?utf-8?B?RHBzT3RUSiswMXR2SUFseW1FOVg2V2NZMXlXSGxpZ2d0WHMyR2k5c0g4Rmxa?=
 =?utf-8?B?MWZqODdzU1E2MFF0Mkc0d0lJUDcvWHc3Z3AvQ3Exd1Y1L2JUUWd5R3FYQklL?=
 =?utf-8?B?K0ZGcWhpWklDTjJjUit2WmhlbzdpVTZqRWx5Nlg2TWMrelZnTUhVc3pQaDhx?=
 =?utf-8?B?bHlSV3ZhdllmZGtQbHhGRU1ZMTdUSnNnS2VLNGswdEtTY1FrK0JHdkoxVTRG?=
 =?utf-8?Q?e3HLzAlNRS4yyi42eF5ZSEYKq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 671190eb-3145-4aba-22ee-08dca4aa083c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 08:42:17.0191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FDC57FXW+fMWI70MI4hE2L5KWPgSoc9KX4WEW+5Bhblc1Fms7ir8yQoTFyAOylmVhhBR6T2Us6eo7zX+0hplQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4637
X-OriginatorOrg: intel.com

On 2024/7/12 21:40, Robin Murphy wrote:
> On 12/07/2024 12:49 am, Jason Gunthorpe wrote:
>> On Wed, Jul 10, 2024 at 12:17:17PM +0800, Yi Liu wrote:
>>> On 2024/7/10 02:23, Jason Gunthorpe wrote:
>>>> On Wed, Jul 03, 2024 at 02:57:51PM +0800, Yi Liu wrote:
>>>>
>>>>> BTW. For AMD, can a single device be attached to multiple V1 page table?
>>>>> IIRC. looks like AMD has only one V1 page table pointer per BDF. But 
>>>>> there
>>>>> is a PASID table which has multiple cr3 page table pointers.
>>>>
>>>> Yes, ARM and AMD both have kinds of iommu_domains that cannot be
>>>> attached to a PASID.
>>>
>>> I see. VT-d does not have such a limitation AFAIK.
>>
>> Yeah, it is nice for software that VT-d put the right bits in to let
>> all paths select either format.
>>
>>> BTW. SVA domain shall not be attached to RID I suppose. This should
>>> be a common restriction across vendors. Do you think it is valuable
>>> to let iommu core block such an attempt?
>>
>> Yeah, maybe.
> 
> There's no functional reason to disallow it for Arm SMMUs, at least, so 
> it's something that could potentially want relaxing back to per-driver in 
> future. I've heard murmurings over the years about potential use-cases for 
> SVA with platform and/or non-PASID PCI devices, but never anything concrete 
> for existing hardware. I imagine we can expect to see more SVA-interested 
> on-chip accelerators in future, but whether they'll all be nice and support 
> Substreams (i.e. "platform PASIDs") is the question...

I see. Then let's keep the core as it is now.

-- 
Regards,
Yi Liu
