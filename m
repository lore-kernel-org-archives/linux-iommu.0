Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7A01C878E
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741956619; cv=fail; b=BKZlu8HTz7TTMQiHE7EYYcjRjlzpiOE7z4kl6pg3w6q+rzrohrtVBJou1RYn6FjV0B/zfGz+mVS5fQ+LatP09mJG2wMV7koL+h0nLVj8MM7XSM1i+J7XG+jyR5NPmOUUCVqwpsgt7VvNcwS0Imit22DMoLItAflN2Burj62/m4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741956619; c=relaxed/simple;
	bh=IRrk7pSGy+XV2CK/DPja2iez+f/yOSNQZrD8tk90Gt0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZcS9Qgxa7bVa2hrB+b4TRgjABn/1nlA5ybOgiIIDcGu8ohhtOOYGduIg3UrK2De0DwPTClUbM+lgv9DtEsX6jpKbZsSdG2+2/1eR72LLIXhDafs9c8HLhLU97vU/7xAg855thQwMq15pS1IKPT1XzPMOuz9zx0XB4YqnVDSXg6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YykFFlDT; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YykFFlDT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741956618; x=1773492618;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IRrk7pSGy+XV2CK/DPja2iez+f/yOSNQZrD8tk90Gt0=;
  b=YykFFlDTxruQA+x0GoyTKIYe8QQv2qXEjSuwqE+v6N+Vaxm/6Yn0vOD8
   EKuIIAyWxebe6kxZj2xqN15JjOA2m34QdS8tS6qYWaZZCKZyIai1oOzaL
   Y6Pokss4l18TdJN880XSLIGM1U38VduoemAbCxNCl6QjgOxF25L+T2lr5
   po0IHmedXB7CgDKZ2MW+Ky4N+IEdCVmHx+v26XIwPpNpLVJGsgb3R3Gnw
   IuHspcUwLgPWjgsV7EhE6VFEAEM2vGz0aj9WAgJATamePjD+TJ2WGI22x
   K7XHAGqeVP1sqsduS/R1kVHYUBwbPsyVzfNke7A3CijkTS/0s62VW+rpy
   w==;
X-CSE-ConnectionGUID: krXcajJ1QhCbzY0P/5jB0A==
X-CSE-MsgGUID: /Xi+9kQ4RTO/OO0XO2AC6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="43142671"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43142671"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 05:50:17 -0700
X-CSE-ConnectionGUID: +++X/o8lT8+vdlgafVF2DA==
X-CSE-MsgGUID: l6fidIBVQ9e4fdADbLv3Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="158421245"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 05:50:17 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 14 Mar 2025 05:50:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 14 Mar 2025 05:50:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 05:50:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeQFyDE47ACkYJom88habY7Gg0SywWmztyzgtMQmLc2+Umq0twvBHiGEvqHjbMF69nbL0ZvvAHcAZsBuur3Iep5OO6xwHCDPXuydhWkDWUH+ZKpd6eOLleCTk9uhbsG3bRXyX9mEG3y8zVgdMeOi7niTE2Q3XN5iMifvSFnwiRRnzRj2QqrnaGfY52GVT6DtPdOTUrm8ZmZZ00jK1FiK2Q17AG2sMidUo0op4KMnYSKsvoL57LPTno1zhS7Bq42lrewjh4wCEOPUIwWmEHYfjjmdPCuXRhlKh4oovlzlPqfKH75MQkdTzDL6ThNwgYidoHAdakfJxaab4iqwYiaIbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfatKwLVeZEvSdOLsTYWko32w7oWSRxK5nEv+eyWcrc=;
 b=RYVVZWa8dWpeksSjCl2jH9XNbffG8+HV+rxnjIhG/gXZ8ar5WlbHYeYTL67y9Y5pTKrDhybv9Rk98Sj2xPCP3ihfsmiDJjieVmlcsfBGGcbXg7drILyRTgfzvejcP3raOTPDA30EkxURGCXxE4Tv892o6PZvNoszZB9wrUJQT7GENDg8XMklw37xYm+qkD17mVhjHU0QcpE08C/rzwuHlTB/NiUP2nGL7HSCAsINbmpYDAyuQZPIbU7aaRKqht80QAgXFS4qwXhnJq9NQnrDNuln0siFJdIUPgIxj7fn9XFTI0ddML+3XMDEgA+wE9kZ5Hm0xcRXzoqq7EzSi4dzJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB8478.namprd11.prod.outlook.com (2603:10b6:510:308::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 12:49:32 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 12:49:31 +0000
Message-ID: <0800c54f-e5c7-420a-84a2-a52bf2ea707e@intel.com>
Date: Fri, 14 Mar 2025 20:54:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Vasant Hegde <vasant.hegde@amd.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>
References: <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
 <20250303183801.GW5011@ziepe.ca>
 <2c9ef073-fee5-43c6-8932-a8cae677970e@intel.com>
 <20250304142030.GA5011@ziepe.ca>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250304142030.GA5011@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: 15fc669c-38c2-48c9-cae2-08dd62f6aa40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QklWY0QyVnJTVXUwcW5BTW1vZDcxUUowMnVjRFdqTTZqWWViQ2Qra0huLzhM?=
 =?utf-8?B?QnZSL0V3ZUI0cXJZSG9hWkNGU0lzaG5Jd2YrSUhtTEFUMjdhUEJpMzZRSzk3?=
 =?utf-8?B?YWFKTUpCcnk0RHNiUExQK1ZmS0JKK1J0Uzk5SEJpYVhRaXU2T1lNcWtWYWlI?=
 =?utf-8?B?ckxGcWJLajFWaCtCQ2hsSFBYaDR4RGhPbmZsZFBiSVNEQWNXaFl4THUxZGhj?=
 =?utf-8?B?YTB6dHMyWjczUW9RVk5TcWVFZUZwQS9yOSsyNFNHMkNkSUJYSlVhc0w3L1dr?=
 =?utf-8?B?S0xIR05xL25aWDNxb0NtOHFmdHFNZXJIRHpHUzhpYTNpMXN6WGEyajVDUUFi?=
 =?utf-8?B?bkNQRUh3WTRSckdURlM1SmhhYUQya0t1R2daUjJ5T3VrV2wwTXA5a0dyNkF2?=
 =?utf-8?B?cllsSDZpR2NEdEs1ZGNzZDIxMG9lZStYZzRuTnlBeWxuQjdURWZPUzk4Wk1o?=
 =?utf-8?B?a3B0b3RxOTJacEhjYmJiUHl5Vm1kT3hkTmQ3ZUZjMHU5YURUKzQ2V0pwQ1pZ?=
 =?utf-8?B?ZjJ5ell1ejhGVmtpSjNjU1VGSEFZYWdPc2R2ZzZmZ2c5cytIWFZvUi9DdWF6?=
 =?utf-8?B?b2kySGt0TkNMYXhrWk9FQzRPVi9yWm1CdUd3Y3l4MWcwdlZqbnVBa0krZHNm?=
 =?utf-8?B?M2hPZUd0bExXK0d2bWY4TjV5a1d5ZThPcWE2YkxJTXZsN1lBNFc0aVMrVHZL?=
 =?utf-8?B?VmFBVVdMejQwekV3ZGZLY3BZcy9pKzladHJUdlE1VlZLNTdGZ3l1bHQ0TThW?=
 =?utf-8?B?M1dDVWdnOVhldjlvd2VLczh0clpaKzUwamxhQmNWSHJ6enVncmpyMndaQkRP?=
 =?utf-8?B?K3RYa0lSUHBKeUMxeE9Ud2hWN3NFTmE0NmpWWVJBdkEydTJhdkNIRFRNQ1Iy?=
 =?utf-8?B?dFRKeE1WL1JsR1N1ZjdYYTVJdGdaakdQWVk5bkV6OUMwRHh3UWFONmd0Z0Iv?=
 =?utf-8?B?Tm5ycVd6OFhMQ2EyNURuWlpaUEFLaVhRNGR2QlU0TEdGNnF4RnhpUDJZaThD?=
 =?utf-8?B?c2tUQ1RCejUxdlV5VTdzYURrQWJGdzUvUUpWSmJoc1NBNVRHemVZUXdFZjdX?=
 =?utf-8?B?dHROSFdYY2hvT0JZSUxZWlZkMlB2RURWYVVIQ1dyalQ2TlJibVd2dS84a3Nr?=
 =?utf-8?B?VWpCdnlzUkk1QTdWT29OK0pWRDBDMDFjaTN3MmdiMllnT0RSVVo4dS9mN3VB?=
 =?utf-8?B?RENCNldydFNRYzJVUGJNcENKTkF5ektzbk9ZUGNWcmNDUHpiZEgvV2lsRWlZ?=
 =?utf-8?B?NjdsY0UrRGRlMWlXL3IvR2hJdTYyMTh6WElNOEoyaGhWK0h3TUNlYTliVExu?=
 =?utf-8?B?ZHZROWM1WVBOcWRUWWEyTlorZ0tNcnUwaHJRV3JLY3hwOFZsbzZiMjkzRzkv?=
 =?utf-8?B?V24zQ013Z2drZHVVU0kvSitEUVA2ZDZ0ajM1ckFZNGV5M2pYQm15M2Qwai9U?=
 =?utf-8?B?OWlJYTdSamFGOFl2YmtxVEVtY3ozV3VHOWN3MlNmZzNnbjMyN290OVFnMGps?=
 =?utf-8?B?RkxoWi9ONkptQjU1dDVtdGZmdEt2UzVGNWRjbktSRHVIMGZDcE51UlRKemZt?=
 =?utf-8?B?Z3VtZVlDeWtHOHBxdG9HNGNUWUM3c29ZQ0VIbnZpNjZ4R3kwVDh2SWpReDlW?=
 =?utf-8?B?ek5mbGF6eWRaZGV0QjVmQkxxWHpuS3F1OTkwclV4ZEN2RG9XTlBObm8vRlBV?=
 =?utf-8?B?dXFXZ2pkVWJsZFBYa2g0UG5yODh2dmw2anBHNXZvTVl3ZUZXbHhpdVN4TnZX?=
 =?utf-8?B?WkpEWC9GM1g0RmVhSEs5NG8ybk5yb0ZKQkg1NktkYm5yL251bE92Mm5NbWMy?=
 =?utf-8?B?clhtTjEwb0d6N2VnMEpvM0U5VG0xWW1LdFBtakg5OG5sc1FkR05ROFF1S2d0?=
 =?utf-8?Q?XjwxtlaYG8Q14?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmt2RHd6NGNhcjM5OVB6dG9YRnJ3T2Z3ZE5CdTdNYUo0U3liTmhyRjJpTFlI?=
 =?utf-8?B?SlYvbCtSempmWjFzaTRPYmlkczBqRUtERWZtT1RTcDZPcXRPbjhkZURic25O?=
 =?utf-8?B?WDZZYzhkdXJMVFVmZTdXajZwcTY4M2NNb3NUU3lGZVBocGJaYzdBMGhKNjdr?=
 =?utf-8?B?bVgrM1VMeFFLb0NKVThxSERLNFIzeWxmSnZwbFhqMmZ5SXNnK3MwRHFpN3c0?=
 =?utf-8?B?SGtQWTN3UlZiNnVyL1pQSEVJZGJNdGF1dWl5T3RncEJ4YjF4VGw4RldWbGtm?=
 =?utf-8?B?V2dIc2FGREllNi9abDhvOTkxZ2VicFNYaGRTZ1puWlpHNmE5bUZMQlhnZmpM?=
 =?utf-8?B?ZE9rLzB6RlhyZXhLS2hmM0lrSkt4WitPOFAvUHU0UENVazludWlPQ2dEREJ6?=
 =?utf-8?B?V0JxMkRiZHdHbGRGRElvM29nd25aODNHeEhmVzM3QXc4VDFJdUxlclhCeFFJ?=
 =?utf-8?B?UUhJaW5lYnlmeEQ0TXRzejl0ZktKRGpmeTc2c0RpRjNzY1RqVWMzNy90dGha?=
 =?utf-8?B?YnYrdHB4bjFLb2xGMGp3K1hXNkNvUnZOR25jRGxzeCt4SlM0MlNsbnE5dG1F?=
 =?utf-8?B?cEdZcWNSOGhmQWFZZFZFVWhKeWtqUDBsNzJaQjV5Q1BmMFNJbTA3MEg4T3Vn?=
 =?utf-8?B?N2xjckNsY0FYclBBMVVhMHhuSHVjVXBOUUgyK3RqV3JvQVNRTnVUVU1ZcDVB?=
 =?utf-8?B?S2VhcFRBQnhUU2lXcUFaR3hqamdnTFpCazBBdmhoSVhlZGFNcUl0bkRBbDNE?=
 =?utf-8?B?RzkzV25PdUZCMlZnSVViSjFJd3FJSU9SV1lhaVJEZXBWb0NYbURneFhEWkRr?=
 =?utf-8?B?eENqQzVTcm8wNmxRUURDb0M1REh6TFlVek1tOEFEN0ZrVHUzQ3FQNnA0Z2NH?=
 =?utf-8?B?Wk9qM2t3d2pINFJ3My9qSVZjS1FmOUJQNmRiejR3RURRYkxjTjF0RXJnNDZO?=
 =?utf-8?B?c2xhWmFVb3doQk93eCtkRzNOTXc2b2F4aENkYXQwbUYrVm1xNEN1QlBka2M0?=
 =?utf-8?B?c3NtVXBqNDAzTDh4Y09NTERzUXBLdEhsWm9SWmJ4aXhWbnEySmx6VVhFdUth?=
 =?utf-8?B?dHpkYVFvTnVXT1YvRXY3QUxwV0EycjN0QkN3eFNOblpQRmo5SlArRCtmU1JF?=
 =?utf-8?B?OUJrN1R1TlNoUUlKbjJBYmRmVFNHMjROY1RWdXRoRXMzdnIvUHpEYUIxTkxH?=
 =?utf-8?B?eUdMSWtuemdCd2lmdmFXM3RFTDBYWlJWSXlZREVzVy9RTS9YVVpwd0pNM3ZI?=
 =?utf-8?B?S2RJMGdkd25YR0R6T2dxWitua2Q5a3M2MFhOZDM0UWExUGM2UVNCNW5RKzR5?=
 =?utf-8?B?WTBwRXBKYkY3VDR2RTBPdHFETHF4UXRrTzlrZHF2c29kbXlxdS9qYmpyc3hS?=
 =?utf-8?B?a0NIZ3RFUlg3a0E1SVR5Y0lZSDBFZ3RYRVN1aEIvdDdMeFVYZVpGTWwyakZP?=
 =?utf-8?B?NHh6MUJoOGxwTFB2ZWRlTGduNWF0NWFiUlhmblhFSFFlMUwwQlQrcWxlaFA2?=
 =?utf-8?B?NnRuSDJxMzI5UmViaFo4UEVZQkkxNjdVWk8zWDUzMUtvc25DUzJsb2lTUnhW?=
 =?utf-8?B?Ulk1WGQ1ME9iMnN3YkNqWFlrRTdCMjE5eFlVdXhXYXl5aXE4UlVDRFhIZ1A3?=
 =?utf-8?B?K2JtbEhMUVhmdEVHSDhDVElPN2h6K2FmS0Z0cHR6MWFCbjdCbGZmakN0Vlly?=
 =?utf-8?B?WVUwT2VuMWRlbmFXQ2FpeHIvdGVucjF1SmZwMGg1bytTdzlCUUJKc29ZWWk4?=
 =?utf-8?B?eEZDNzRFaEc2MzNwODBRa2pBRUpwNlFKNjhFOEg1L1ZCUjRSamdZc2tGencz?=
 =?utf-8?B?THl1WE1Uc1dTTm1uNEVmNTFFcHFVL1JmUTBBS3lqT1E2dndKT29LVGhlbGt4?=
 =?utf-8?B?WDlvNEFxUFZxZ0orT09DQWJJVjkwa08zdUJiQXJ1Lzd0VENqeU1oYW5Jbmwz?=
 =?utf-8?B?UFFFUlN3RmhoUmJMc0lYbFZ4cVN4ODhvYStUMkZpbkEzR25wbFVmYjcrbUhM?=
 =?utf-8?B?VjBTbkhYQVRhUkd6V3JkeXhnMWxaVmVmSDV5dHFOY3hCNTNndWlMY0ZxTTNl?=
 =?utf-8?B?VXAwanlpS1RzRTJLcWlzNEtqQkNjc1BacVpCY3I3NEZpYituUDhpenZqYkdN?=
 =?utf-8?Q?xH0BVglVA/XRNys7DxzZkl52w?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fc669c-38c2-48c9-cae2-08dd62f6aa40
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 12:49:31.7432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qApiOpUWA3XsjJPQFrKcXIsCAIlQrM51EAoV1Fc24DxQe2bBdw/vRy/VgqCzvJJy2iGpPt7AlT0nmeiogsVjYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8478
X-OriginatorOrg: intel.com

On 2025/3/4 22:20, Jason Gunthorpe wrote:
> On Tue, Mar 04, 2025 at 02:50:19PM +0800, Yi Liu wrote:
> 
>>> ARM enables ATS when a PAGING translation is set on the RID or any
>>> PASID is used. Otherwise it is off, eg for RID = IDENTITY
>>>
>>> This seems like a reasonable thing to do to me..
>>
>> will it affect Baolu's above refactoring [1]? :(
> 
> I think no, but when we get some conclusion how ATS should work I'd
> expect all IOMMU drivers to align
> 
>>>    never
>>>    always
>>>    paging-only
>>
>> this can be considered policy to the existing ATS. curious, why paging
>> domain is special here?
> 
> Using ATS with an IDENTITY translation is not a performance win, so
> you'd probably want to turn it off in that case.

got it. I see no value as well. :)

-- 
Regards,
Yi Liu
