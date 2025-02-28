Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60A625F984
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751694; cv=fail; b=FO455B2qvC/A1OZYLfwAJP5Rvu3R5UoTW46zN/aKjapDTGlG4JO+GMuSeBEhmz3ArtOB6fBMX74lqFanyowo8vCZ8LDnt6tJptLTJszeETlh/D7x94d8zlmEZoJn9ZRXf42C7KC5ckDiSOUf/DrCNjdFun1lvW4gHXqigqyz8gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751694; c=relaxed/simple;
	bh=AvYhUmiNuL17WjVTiGiuZxAq7KOaxd//SbMOc3m3Fuk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sR2drpTPQB4Kg8S/vHiBttCMhl5IuSmBvOLYCnRJmYNkjmS0nLcyd9N2FCeAsI6rfEQT4HDWMHBofCQkuONwf6dLZkcCHgwX12s1Ta8lSFReiuaaKM+5geoRe++u5g5yAf3E3wnETxuOgW9fzPLQ9ag7XZ55nWC+ub8DMhmab1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lhFSJrma; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lhFSJrma"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740751692; x=1772287692;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AvYhUmiNuL17WjVTiGiuZxAq7KOaxd//SbMOc3m3Fuk=;
  b=lhFSJrmaTGwfrfeP6DjSsZfpXN/ikqvaEODkkcSFhUzHvnRWgY4LoQKT
   /CCvAoMUf7QjOsbAjO3lkW6LwW6ewx5B2LbFrKUgbt7qnvav7NJ0QICdF
   rFPJfJLk2uNEfeZnpa3bfknbNQ9cS8GcJH/ztGi1/DMhkv5ioiPeZArZy
   NlUKYOa31AF4xlLXopQryHNquZ0iL9tTCP0IuiCibB25z0Et9cjTi5gjs
   n0kZBYS6uXmtRNSXo0E05WHYYQA/twr4fEb5sqDT3Oczr8XqvxKdKbzRT
   tCg14CKo6imf1if+CoMvdGOh+699sCfEZR/++oA805nMnl3AzqsD4hZwy
   g==;
X-CSE-ConnectionGUID: ceBqy5aJSfKFwgOQsP4cWQ==
X-CSE-MsgGUID: MA8jj5+wS5y2fgEQMNFS2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="45331407"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="45331407"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 06:07:11 -0800
X-CSE-ConnectionGUID: 0o3yL0MOQ6SewDIRuL31/Q==
X-CSE-MsgGUID: WuxlHayIRJK9MUPfvh65Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="122353698"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 06:07:12 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 28 Feb 2025 06:07:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 28 Feb 2025 06:07:10 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 06:07:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6hLeFXoiiVUs5MRT/Ob8HBii3FPEYXh5k1SimD6YK2t5TZYFNC0Su2wPlHtYMN8VbNH74kWWMCU4qRyBg3b7vyf8uH7YPxJQQaM+Evwvbtjlpv6vROitl3+7ZOkEDa0XgUXTcaJ7cN4CwdfFxr0odU1FFXcdvAbW0mf2tJ+Fyd+ZKaBFmGXyc0y2AWyjDxq0aOQ2bCuWAqUGmaGft0Qe+KAwWi44ZVBnGPIk0RheDwnJ+qnQRNSZAw7IFy76RKofpyZNa5WTVowRU+IIYeKSS1mhaMIdBIVjXdq9TLxTl41W4f65KA1Buvk6qdP1jpVhh2q2l1/6Q32K5j4ZQBYLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRoByI3H1niOUhoRUsDH1NHFQgGffCoGOeVgC8/8XZY=;
 b=W5zPrxlWGyvU+q7DsbMaTBbmBrR0qUBYS60SpVfAqH3jIpHAgqAU7BktSzFwcqp+l/kjYbJdeqPQJBisWzEUTjUS9WFnjMMabqoRt9RAveYDyagaa+KV4dBcYbHD7hJhto7lN0TJko7Rg1KyRn/q55GT2iXoJDTjx0ffJNj4+y9hIGYAQwXaJ8vdOO9UsU1UaVcmOsnpat4tlBxXWkeL/QIg2G4pwKME3U2IG2FW4GzXYvTnKTmq/zcd2MwvjEsxz+8yX8AkEdMuy9j+CWIoevMIQVfbyKkwSYcMHRJjXU5wyYGoW1kYV3z454J8OdB7VwLxuSwaxJHFNMd3LehB1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA3PR11MB7464.namprd11.prod.outlook.com (2603:10b6:806:31b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 14:07:08 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Fri, 28 Feb 2025
 14:07:07 +0000
Message-ID: <51eb28e7-0631-4965-81c1-cf9633e46019@intel.com>
Date: Fri, 28 Feb 2025 22:12:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/12] iommu: Introduce a replace API for device pasid
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-3-yi.l.liu@intel.com> <Z7+fmawdDhATfOX0@Asurada-Nvidia>
 <d6b97c8e-f126-49b3-b752-92fe3069af51@intel.com>
 <Z8CNEDwUCZuNUv7C@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z8CNEDwUCZuNUv7C@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA3PR11MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc71dd8-6606-4110-eae2-08dd58012fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTRBL2xtLzU1eEFFMlVndk4vTGt6NmtiN2tiQXhOWlAzTG5waElwYUJscEI1?=
 =?utf-8?B?ekFJclY4MVY1c2hBdXkwd2tORUFkd00wUUdOUVV6bmNhbDJYTHJIMENrZHZt?=
 =?utf-8?B?Q1FmYy9SK2wzeGFGS1FpelI4bXR6anM5NmtxR1dKVmR5RTFtRzYyWUNsanYr?=
 =?utf-8?B?VEo0cmd1VFZsMVpwY1BLV21TejU2Y0hrSGZMeGNjalFvRGozU1Y0SnViVUsv?=
 =?utf-8?B?ejRRaTFrdHFMME4wMTgwM2IvUGRLY0d5WTZhSXNMcUhEVnVpZEVPVDlLVFdt?=
 =?utf-8?B?VUl2eTg2VlhETlpYb1ZLZy8vU1VIaEZQNG44UGVwY3dJTGtldVJwMDVReW11?=
 =?utf-8?B?OWtzUUlkZ01xckk5TUlXN3hZK1VGWDZSVjFQY0c3TmVCaDlXS3U3ZHVrVjFw?=
 =?utf-8?B?Y0RsbHNzdmhaZ0s3MnJaRXVNaG1Eamlma1dwRFJpLzFnamg2aDBWT2xtbTZs?=
 =?utf-8?B?TmYzMlhOWUdqV0Y5VzE4NEtVUXMybFhVRmtYSElDRzVJd2tobFFVbW90NTl1?=
 =?utf-8?B?aDhoZm4zbUlTOUlpZTF5K1dLMkxLOTRHejhTclZpZUhsUVlIV1BtWWZSSE1K?=
 =?utf-8?B?c0ZGSmIrTGdlWFpnaitMdW5YRmhjZGlvRVljTWIxbFA4VXVaT1diK3A1eTZU?=
 =?utf-8?B?dXpvN2V5L3FwYU5YRC9yVEdRUzJ6alRhWHM0THYycEpHS2paYmk4WHBrdk1o?=
 =?utf-8?B?YWtIQ0czdGRjZlRxZkpsOUttc2RSMi9KY2pGcWsyMTJIZjFkVmxrc2RDa0V5?=
 =?utf-8?B?TFVGRHcvY3p1WFdoTXVmekJIL2NZNUs5ZGZsWHNUeVI3bG5EMWZPeG1XeldU?=
 =?utf-8?B?TGV1WXNmWkc0dHBSWExtU2pVd1YydDZUNXROYmZnczB6cnlmN1B2YjJ0dVMx?=
 =?utf-8?B?T2cwRlZ4bXV3MWdnZ01DRzhKUmZBaGxjWEI1a3RuM3o4dndXSk1adXdSb1lI?=
 =?utf-8?B?OWlwcW1jSVZGMCtLQS81Zm5YOUlnOE1VV2xjODVvVkt3NHBaV1lZR0dQWUs3?=
 =?utf-8?B?UGpJeHdXZ21YdThvNUdsRVlIRWpBNW9WR3hEdmp4bncrVk5JM1FBdC9PbHFC?=
 =?utf-8?B?NDVteXB3QkZxYldIb0lEZUVldmozQWQzOFJOUk5ydlY1b2VGVzQwQ1pOaWJS?=
 =?utf-8?B?bi9BOEdOS28rbFI0MzlWa2lEWEhpMjRhanZ2M2pGZU1JeENpY0c4aXh4NUNk?=
 =?utf-8?B?KzdkaXQvVFp4MTNkam56Tm5COTB2ZHZQOWNiTmdLYktlZm05N2dOcnF4MGZL?=
 =?utf-8?B?aktLUUJXNWR4SkxCOXNKWjRieXo1WXh1Y0t1MHZJNGVoUTJFYmw1bUJNM3pz?=
 =?utf-8?B?RzBIaEVTMGs5YTZ2bFVwV0pTR0JJT01YTElENGdKUFRrUU9UM3RJNUdzc3ZU?=
 =?utf-8?B?S0NNMnY5WDFpY3kzN3lFNGhMcUd0MTkybmwwdGZHclJ3a0hxNmQ0bXFoaVc5?=
 =?utf-8?B?cnRHenl4YzZMd1FtbW5OOWZBVUhWUWxDS2ZNNDdPWjRjNTdKV3Z6NXUvZ3li?=
 =?utf-8?B?OUhGcHIxejJNWW5UZjRpTVJrWFBsWHRtcmk0cFNISDRXMm91NmZBeUdoc3o0?=
 =?utf-8?B?TXRHeXNnWWxqS0prbzkwQlNoU2lsUWliMXMxdkV2azZBMmhVUFc3bkloS3VZ?=
 =?utf-8?B?amFTWFhKWmxibW9ENEpGdUM2UHppcnVVaFA3elJMcHRDNTJaMG1GdDVPZU4v?=
 =?utf-8?B?ajlnT1A3Z3IwNHhWZ3BHMHdZYXUwcU85d0JZZmJPc0Yvamd0RWM4MllVMkZJ?=
 =?utf-8?B?TzFmcG55bkp2cnA3SGowNGVxd2xTVmc3aGxWRDFESmo0RHY0dW9Sa0k1TFFj?=
 =?utf-8?B?TUFZOUJ1V2xEekNNb0RnTlJFZ1RpVU5pKzBiSU5ieVVBb3pzNUhQdGJsOG5h?=
 =?utf-8?Q?7uG2PQlfxApQK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnlGU1dsSTBhc2dHaFlhUEp2Y05vVkJ3QlhIallJTmFZYTFpQ1BINk9KK1ZR?=
 =?utf-8?B?dWg1WEV1TXVJVTgrRFBaWHMzcnBwd3Z2NWFKL0RKZUtJRUtLdXVZOFkzMHNh?=
 =?utf-8?B?ZytpS3JqeHlST21aYmE0N2x2Snp6d0VVeFpmUHd5b3JqeUNUMXIrTEx2UHRY?=
 =?utf-8?B?NmVsT3RhTlhJMEphUENISXNydTMwdHBJTHhuaGlRaU5CS3lvei9NMy9sNGRD?=
 =?utf-8?B?WGtHVmFWeG5PUGVEUG9TUy9paUFGWkdPK0FOaWFuNlZzTFFOMmphYmVpRVk2?=
 =?utf-8?B?cG4xZm1pd0Q1eEVCamhBTUpyZFNTb2RQbmdQNWhLUVYrTVVjQjQ1WmpGWXNl?=
 =?utf-8?B?SVJxcThSVml0UzhyMDlqRVdFd3dwMkVVaExkTXV4bTRxZkxhY0NYMlIvMXJ3?=
 =?utf-8?B?L0F5MmZQeG9mb20yVE5kNFpidmpmTVVtS2VCVXk5a0tqdHNFRzF2dGVGL0FQ?=
 =?utf-8?B?aVBuNERwamhQRzJtOTY5WlRQeWxvM2wwVHZzR3A1STFtb0oxd1JPNysrSmxD?=
 =?utf-8?B?b2h6YUdUUGZsY0VoNWVmcDR5cEF6K1o5SjRYekVTMEI2WTZLdDZ2VTlJdGto?=
 =?utf-8?B?VjJZSG9QMTh4bnl6TkIzNU4zU2Q1MXArMkd0Ri9mK2pxb2dOblN1ZVJxTS9l?=
 =?utf-8?B?ZGNWQVQzVnJOeWtSSFh1ZHJMQmVEUWV5YkFMREhySTVGTmRtOFlXTGVDWGpI?=
 =?utf-8?B?dEpZcDVKUDZrZDdYMUJySnY3NzdHRjZwcG1Rb0ZpOVRjQ29oanNJMHA4Tkdj?=
 =?utf-8?B?MXhLbGR3VGVidzljMCtCYjV4bThrWC95TDRNQTZvS25BVnRHYXdhMitmY0RT?=
 =?utf-8?B?b2hOcDBycS9QZXFmRXpMT1hMT2pSNUJwMUtIR0lPU2ZzUGs2VVpLUDVZWW4x?=
 =?utf-8?B?RkU3WDJKa3ZBT2JERWpya1Y3N1VMYU84c0FBTm4veC9UQzJ4R3N6ZFlNODhl?=
 =?utf-8?B?S3ludzVvd0dhc3ZhVjF5UFB1MUxkYkNwRXpocS9xb24yT0NKZmxTaDZOem5L?=
 =?utf-8?B?eHgzeVJwUjRQR0k5SEt6WmQrUkVMTGZsNHczcmVwQzlMR3FKb3Rvc3NKZ1BH?=
 =?utf-8?B?NVdTSCtYZnVGQ3hFemhlN2NiYytoZlU5ajJEMkM4YkgrK1FLSFQwcEtRUVlI?=
 =?utf-8?B?dUNPNjNmZ3B1VnJWT0xzVXRFNEFhS3Y2c0lybUxWVGk1T0wyUTYrOGZhSXhS?=
 =?utf-8?B?dm5tVGQvU1YvV2JwRmhzNzBGOEdYUjZIdmdpMFZwdkx0a1JFckxBb2VBT0Fr?=
 =?utf-8?B?Y0lZTE5Nc2NaaWlvWlFvMVVNVGQxb2VDeUNoMEF1ZWNmOGE1eTNHSUJXcHZV?=
 =?utf-8?B?OGZaN3o1V3lsZW1PWnluc2F4TnFuRDQwZWJmaEM2cVVDT0NmWWJyYzRhVVIz?=
 =?utf-8?B?cGljTW80SnQzTk5sU1pMRzcvRXdzbmVtcTNUZ3k1dGhaemhsYkF2L3Vwb0Z6?=
 =?utf-8?B?NGh1K0JDUDZsNURmb0xvdS9QbHRiM1JmUE8rVnlnbC9pcFpzUk11ZzFlbTBK?=
 =?utf-8?B?NzFSR1pUcHZ4OFJzazlRRzdwZ2lXbmNQanJlSzl4MDh2VEdtOVRQMXZWU2pp?=
 =?utf-8?B?SXVOV2JCd2VseGNWTm5xS0syQzhYdWJ1VDFoOTIrSVZ2cUgreituZ05uM0Zh?=
 =?utf-8?B?RmdUZWRiN0owRUpHSHdkaGJXQkVtMnU2ZzFYOExYUEZjMlFuRS9XUGx4Mm1D?=
 =?utf-8?B?eTNQMS9uNEtjY1J1ZEozMklRMElvaVYxZmhUdnJJU0k0Y0xFZW5KSmNUZWxw?=
 =?utf-8?B?NU90d0tSdVBIVnNEWG0wbWxna1NXbk5oK3JKVDdnSXZOZWlwc3ZxS2xTRG1r?=
 =?utf-8?B?dXA1d2FQTEN1L3Y1YUJkbVRWUHFjRlNlZ2dFTWZtVU9VRzg5akQ1S2RCTHQr?=
 =?utf-8?B?TEh0a3lVbFJobWNtcThBQllGdGlOYnA4SEptRURBNDcxcVJOUUFLVVBQeHI3?=
 =?utf-8?B?WlhkeEhyNFhacUdiZy9USjY2UDg3MXdUd2pWZWVldWphOXVyWW14YVQ1dnZP?=
 =?utf-8?B?SGJIL3NIeGNNVS9PNDIwYWhkS3JmZlN6YkZFV1RFa0Q1M3hBc0JrMktxMmtJ?=
 =?utf-8?B?ZEVMVGVDRnFiRW5acENVYVRKZnA1eXhtRjlzT1l3MGZndlEyZ0xBVVl2YkZN?=
 =?utf-8?Q?jMxK5F9doYOwuGnl+ZXhTwJaq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc71dd8-6606-4110-eae2-08dd58012fb5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 14:07:07.8627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPSd8vRX4Wjh8oUMoFPabaLDB9Eb8Exsn3z/AbqMzgF9wwGAawwkxrMYyEUUZePxos0XAxomuo8xXlFPil/ezg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7464
X-OriginatorOrg: intel.com

On 2025/2/28 00:04, Nicolin Chen wrote:
> On Thu, Feb 27, 2025 at 09:43:01AM +0800, Yi Liu wrote:
>> On 2025/2/27 07:11, Nicolin Chen wrote:
>>>> +/**
>>>> + * iommu_replace_device_pasid_handle - Replace the domain that a pasid
>>>> + *                                     is attached to
>>>> + * @domain: the new iommu domain
>>>> + * @dev: the attached device.
>>>> + * @pasid: the pasid of the device.
>>>> + * @handle: the attach handle.
>>>> + *
>>>> + * This API allows the pasid to switch domains. The @pasid should have been
>>>> + * attached. Otherwise, this fails.
>>>> + * The pasid will keep the old configuration if replacement failed.
>>>> + * Return 0 on success, or an error.
>>>> + */
>>>> +int iommu_replace_device_pasid_handle(struct iommu_domain *domain,
>>>> +				      struct device *dev, ioasid_t pasid,
>>>> +				      struct iommu_attach_handle *handle)
>>>> +{
>>>> +	/* Caller must be a probed driver on dev */
>>>> +	struct iommu_group *group = dev->iommu_group;
>>>> +	struct iommu_attach_handle *entry;
>>>> +	struct iommu_domain *curr_domain;
>>>> +	void *curr;
>>>> +	int ret;
>>>> +
>>>> +	if (!group)
>>>> +		return -ENODEV;
>>>> +
>>>> +	if (!domain->ops->set_dev_pasid)
>>>> +		return -EOPNOTSUPP;
>>>> +
>>>> +	if (dev_iommu_ops(dev) != domain->owner ||
>>>> +	    pasid == IOMMU_NO_PASID || !handle)
>>>> +		return -EINVAL;
>>>> +
>>>> +	mutex_lock(&group->mutex);
>>>> +	entry = iommu_make_pasid_array_entry(domain, handle);
>>>> +	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
>>>> +			  XA_ZERO_ENTRY, GFP_KERNEL);
>>>> +	if (xa_is_err(curr)) {
>>>> +		ret = xa_err(curr);
>>>> +		goto out_unlock;
>>>> +	}
>>>> +
>>>> +	/* Not a replace case */
>>>> +	if (!curr) {
>>>
>>> Mind elaborating this?
>>
>> If curr is null, this is more an attach op.
> 
> Does it mean that this function doesn't allow to replace a domain
> that has no handle? But how can that be an attach op? I mean there
> still could be a use case of replacing a domain (no handle) with
> another domain (no handle or has handle)?

I think you misunderstood me here. The core stores either domain or handle
now after the handle series. So curr==NULL means no prior attached
domain(either with or w/o handle). That's why I said it is more like an 
attach and should use attach op.

replace a domain w/o handle to another domain with handle is supported.
vice versa.

But replace a domain w/o handle to another domain w/o handle is not
supported as I didn't add it. But it can be supported if there is
use case.

-- 
Regards,
Yi Liu
