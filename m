Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2983644A6
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261130; cv=fail; b=MmE7PW4wGx785Pa7bQsSEzbSw2gcoUQb75RbSjPTnTSigs4Ix9jS7ODO6AtfCN3liteax+f611h1bEPR7FEiojM6NC0PbrSpEuyFw0heVD5BYvzkw6L1DwDVWnlNmV32ag22GhoMWHZhzoY18Wwhd0Snu+7qhM7OtDdGHVVH7IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261130; c=relaxed/simple;
	bh=JINTBJGpJ56haytxAK5Xx7ozmZEBHHxUiF/JrSW7ntA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UYxQ5UjZDDSY0M1iwWQcmtCmQS6GZ53hnrOIG2EetgCtkAsh6XkClFrKQiAfajhSdPrFnDP173NlQ1omwOkxY5cr2yz0QRiLh5hPUvS1ZwYoKvhQgzmYLRnjoFhoZtWWGyJzi2xNY+Olhd6kGEHAlrdn2YBk8RWJ8Y4ZNeltyIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkOydbjF; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkOydbjF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779261129; x=1810797129;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JINTBJGpJ56haytxAK5Xx7ozmZEBHHxUiF/JrSW7ntA=;
  b=MkOydbjFA/2f7mfe7CWb+rBi9GaJnb3urb6+LU6B4ry5bQfHswQ55UOC
   UxrHY7Po+1LaCe5aalkw0C7LlAZ8OKHP8kPpjEzoS5K0KzTWYKJddZq3h
   a4SAYkIZhOUp8xQESUZgtXw/YyyZb0DQ+e/feWDHNvBwnCqeA/6Eqau3x
   JVgv74VeagjE+Mqp9G6+CzSrkE5/zOqOYkLLUcTubvAzfbCre3EOOG0V+
   E9mICp76+pkoL1IUHJW6laMywwI6smIw9Yqwm5HwZWff3HWNad5q67WJK
   Qa47Ode1hbgJ3eiBV0ZQUwHcBNF6QfF0mJ9Gme8rc3fLqLLZRZVtRvasw
   Q==;
X-CSE-ConnectionGUID: pBoaB4VcQtKW26ZGKY32aw==
X-CSE-MsgGUID: IvXZc+W8TB+S3n2uAWERug==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80329176"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80329176"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 00:12:08 -0700
X-CSE-ConnectionGUID: rXMce/NjQIGzLFBce0JeGQ==
X-CSE-MsgGUID: nb4m79HKROy3b62BnGKKUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="241881881"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 00:12:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 00:12:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 00:12:07 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 00:12:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nzoa5OaHPIxPALVXadPCvB3Fhjt/C3B2B11xV8Mzo9UZr5lEJ5OJltEaP6ZVQg0OVEODKE7H3Bgo8iUpWcXm5Oxv05tu3pq/su+F/wwmiCsoZ30U4bb6t2tP6Q7OMmR1/28LI68qvoghy39prxhbD1i+iAcWfTm2xqOQmKIo7Qjikmh7nSoPWBOLV14b1y/8hJ8Fre7cpYmO6g7s3i5R0Can9sV/w+0f1/75f9jp+pems9C2vXMX0KtzjsNJ1of56R9b3oAQmlHYlBSkK+l7Bx9LFNX2FNK7TkvExPyuTjWISH4usFLjDPv0cH2a7iVTCkdIGsFakjtMhGxeka5Trg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vZqJBFCKghAWNHJPRCmrgN+02zRyUhOXo3bpEVwIDA=;
 b=PRSf17cpnCrjIrwZnNsIewfnOXg+PB8LxhkaOrjyIMizLbfXRawMizM3iFz8FK4hA9AAwrrbtMCzCMeja+XsZn+bzLsMHIlMCBTBCV1yWxZK0LLpla4vEZqdP2lCEvW1EFBMUYXB5fEGMS8jqGC3vCE3Euk+LMh4pBtPNuCQmLg3xQIfJ/PT9lUP9H0laJoe6B6tG/Y4QPwcCO1fVWpvAnkKYAE6mqvY8no1IRBg1PboOBDSnqWyImPLv4zRjdyx4YPeHqWDn8YDb0LGyD5UoxK1nTqLCr25HsZ3FwhYJQi/XgjgQKrekKy2/wAY0xTKY2gPUe98L8/Vkx/4wKj1FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SJ2PR11MB8424.namprd11.prod.outlook.com (2603:10b6:a03:53e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.14; Wed, 20 May
 2026 07:12:05 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 07:12:05 +0000
Message-ID: <a0e88436-3bcd-4808-8aa8-86b3ec0c197a@intel.com>
Date: Wed, 20 May 2026 15:20:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] iommufd: Add an ioctl to query PA from IOVA for
 noiommu mode
To: Jacob Pan <jacob.pan@linux.microsoft.com>, <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
	<joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
	<dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
	<nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: Saurabh Sengar <ssengar@linux.microsoft.com>, <skhawaja@google.com>,
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>, Baolu Lu
	<baolu.lu@linux.intel.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
 <20260511184116.3687392-6-jacob.pan@linux.microsoft.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260511184116.3687392-6-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::19) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SJ2PR11MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 90419134-cee8-434f-71f4-08deb63f188e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|42112799006|366016|376014|7416014|3023799007|921020|22082099003|11063799006|18002099003|56012099003|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info: RhXUBrOqZiv5sEdv3SKDC/VtoIe3WnauKfhVMvJDO9pRlolpOTeS3/zbU9YXPd9jjX5vkjVy5Y8IqGdUFHeAZnM6pKvq34KE+gbHEPDQetBpg8OvDN9z/hx986e10TH5MmR1zz9TSidtJBzjRWrpqqjZT2xDYiOo2fmrk9Qx7cSx0Y8ZByy/KM8bmC1axsoB6dkj6z/NlaH48XoXUhq6DURNtBh13BCDaVijWtoftf4xkZOow0C1vgJvvW2LtpKnJL4GJ+mW6EXukDz98g73Lz+xtZgBPSfv24Hpt9EMol2Rbi+PXZ3ZGr+kUpVLX+e8GrZ98rpxM/9Ol3l12jTU5z1E6hH18A0IUMnd3O+p3k+QYYdvrEffzRm2fvWWKDHJXJljl8ZF94gxt08z/2pKTpkye96HGWW45isau5NbXK+UKc58TcZgeQ3VeZl9nHIR37bwP3WcEUvqZYuvbM8aS3cOclWl5V1BckR4H8uXy/zKEqHRqHgMjO2pq8Anvn8yWwoV1Nf7IHWkfYBoR77SjHImZOxy9ZwKtbdh9EbYPDL8wyWr9U9p7VGUdmGkSLgWIVKv9d9FBN+yLQNfb/RAjJ/VQBxYlqpDlkzhO9kl71PY8u9E7wtI6fn5diZkt465y2itUN58vZWEIa0AaNI/yV1orV3b58Kzakis7ze2BKz0LKCvGpcdl2bHac6TK5VfeifdMDoj1ECd4WMGfyokE3gOZmnk+Avb7OgpESjdRew=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(42112799006)(366016)(376014)(7416014)(3023799007)(921020)(22082099003)(11063799006)(18002099003)(56012099003)(4143699003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2k0QmxIVW55eFRoU3BTbTZYZGdzdXJzdUJvK0ZpN1E3RFduc1VTM2tDdXNw?=
 =?utf-8?B?UGtlaDViWldtQTFQR0JkdWxtTUthaFhPTkFIaEI4d1Nsekp1Um93RmZGMDVC?=
 =?utf-8?B?aHNRbVJIOEJ2Q0pONkI2K0k3TGUwK2FyREJ3T1pMWm5HdlNzTjFzUm1PYkhR?=
 =?utf-8?B?QmNSS08rZEdCUzB4bTgyZk0vOG5rNk5KODk2SkF4YkFwandmN2VST1hza2p4?=
 =?utf-8?B?REhkK2F4QnRtZ2k2SWpISFN6cFVYK3EvV1M3b0hCSG1Hd090dmxmNk9JN1pN?=
 =?utf-8?B?WWlRVGdrYlFaa0VodHpwc21raTc2T1RWbVdKTnY2bURtc1FqUUN5cVc1eG51?=
 =?utf-8?B?b20yd3BWVkVMd1BVd2dOU0V2U1daekQ4QXVkY3crSitVd1gydkNSbjhXeDl2?=
 =?utf-8?B?eEhZOUVwNHpPM0RleHFHL1g3TjcvRzRDR2hjSHZ6ZmpsV1Z0dHJFc2U5QjRV?=
 =?utf-8?B?czN6RlcxOEh3OXZmNWhKTWpwa25wYkJBc3hnU2EvWlpUai9BQmxEVXFaRzRw?=
 =?utf-8?B?WWRLS0N5OHFGanJEVTJyUDVLZ0FWSm9mbTVzaTJ1Q3lHYW1UQmU4dlc1QS9n?=
 =?utf-8?B?dCtBNGl6RDhFVTlSL0JkVGZHZU9nUFhpOWRsckRodjFoRUM0YTZDOHJaeGYz?=
 =?utf-8?B?VFNRV25CVnp5NFRHR2twSVh5S242eUgwcC96eExhVlhKanpLWGlBUERuWmFP?=
 =?utf-8?B?dE1nUFF6SmkrNlVKckpReEtERmRaeEJSV3lnNmMzK3U3MXlRMXFoakYrQzhD?=
 =?utf-8?B?WjNiWEtNMmwrWmdLb0NPb2hZMTdiWGJWQXdEZUp4c2hwSmhiSDlUWWNSNWpt?=
 =?utf-8?B?cnEyZzlUZ0VjcjBBb1NsOUd4aVRWMWZXeHM4cUk4SEhpVUFTYTNwVGNudWRO?=
 =?utf-8?B?WXN5SHU3amIwZktHM0RKTXpKYmlXOVQxRmR4N0FFeThGR0djb281NFhSZmlr?=
 =?utf-8?B?U29YeEltT2xqY2l5bEJ3bm9FMWRFTlpROTZMZEN0WjFvaVpmemtlb2xGd1BM?=
 =?utf-8?B?OTNJTlIvVGtvYmJySWRoQy9HSUMvdzRmSlFhOHZ4WWR4R1BOSkhOalZVM0wx?=
 =?utf-8?B?Rnhncmh4aXVEZTZVaEg3SG5RdS9mYTgrakZ1NnZNRkZPRG4vVmVnRUlZU2w1?=
 =?utf-8?B?elVEV2hWU2NkdlQxendPTGJvNWdjNUsyVFdYTW9XaHhvYzFqbUVab3VOSnFW?=
 =?utf-8?B?ODFqTVBjUU90cmNqQlMzS3B5SGdqVGVGS2t3c29HOGxWT2t3NjgvNUVkRTFy?=
 =?utf-8?B?b2NlNWpTREwvRTk2MWNPeWZRTlhiRjl3NG0yTnl6UXZvZ2NrOHJRdXoxTGU3?=
 =?utf-8?B?SFIwZDYvdkY0NHl3RW8xQlVpT2RGU0dudVRXYWFON0NnK1FSd3VDa1FpMEV5?=
 =?utf-8?B?a0c2VS9SbVpRVzNWWGJ1TnpKU2NLRUhOWE9HbWE5K3NkODhFSDFPbUYwRlZs?=
 =?utf-8?B?RDNJZmVpTzBUaGVWZFh0d1dQTnQ1OFlTOXV4UlQ3b3N1YlBoVkVrYThHbWxV?=
 =?utf-8?B?ZUpORzZ4TVd5aVhmTGVPa2kyZHd6MGlqK2x5QjdWK05KSDNqTlZwcnpsUUp3?=
 =?utf-8?B?emhjWitIL1hGSFI5MjBvSXgzQ3p3RDg0NWNEWlJtRDU4TUF0a0puRVd2T0xy?=
 =?utf-8?B?aHlKUW5LcWFvVHpiWDNPeldSY1BiSFNiR0RVeEV6d3ZLS0R6WTVjcGk3S203?=
 =?utf-8?B?T0xBb0syN1ltWlZYam5VbVJIdjkwVC9Jb2hrRm1kdG4rQVRjRk44RjVhODUy?=
 =?utf-8?B?a1l3MG44TG5QSC9FWVlJajI2angxdTBBMk41UE9wRENpcWVRYUxheUdib3B0?=
 =?utf-8?B?UERIRDdkd0lremx5a0Q5TE9ZQTFlWU1tRElIRitaME1mZTB1V0NHQ1R6Z0tR?=
 =?utf-8?B?aG83azlzVE5QRTFobUJaK1dvVE43ZGUveEpwWUdVL3dyZUpDZzRDMFZXZEtn?=
 =?utf-8?B?eXhSY2FVc2xISlVKTFYxck1IdW1YWTJJTFZKM2xRWDZYTkdJbDRGWVhBOXov?=
 =?utf-8?B?MjkrSk54ZmhYbzB3VmFpaG1BNlhhRm5Mcm80cUVBSHAxU1NNUWtTT2NtbFlr?=
 =?utf-8?B?K1dTUW1vRWMzZjk5dUVxYnowY2dTaGtBclhVWHZhSlpkSkxPZ1lEZVFBZG5W?=
 =?utf-8?B?L05VcCthSnZmOWNRTHYwVkhYUVNOV0JoWmhTT0QzUWZ4aGc4VFFXVWlIMVgy?=
 =?utf-8?B?THFIVVI1bUpVM1Zzb1BYM00yZnRmRmpDWGZ6TFoxRmdNY0c1cVl4YXIyVzAv?=
 =?utf-8?B?VDlpTmJ4QWZQdXVzVUUxbXBHb29QajMyVWdaZlBwZDBCUUlxaDhHaFhUT21t?=
 =?utf-8?B?UU9CcVFSenhyeWpFSWsxdlJzUHZhSFNnMGFjQzFGOXpHZVQ5RnRyQT09?=
X-Exchange-RoutingPolicyChecked: MC+6CrAF73bSVZyIZuH4+DZ9TSiX6keAr+70O6Z44vz8L3Fh172EL4lDYQmUrK0rBdIUZw5K3WP8RngeUQCZGNuozHFp8ZPOHJtPKOfUsbO//EaCjkTvZ5z+MnVImnqR0RkpZC/PM/7NYAkSpE3nBNRpSMjVYCi9zijk2d3Qw1KTWQutV6dLS+Zoo9kOwW9GJAc2Ina0OWnK11RpD5joXkyCLPakbMCUB4u8c9U8/U/HeRP1QPn8hy2+JxGYGa2fahwahmt2VqZRyQxzUhDsMhkqKG/dncm5ZjgCBcahNyXSJ4NuMdZVd5OvQurI5/ZVb0IjFAkcGVdrJDgHHYoI1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 90419134-cee8-434f-71f4-08deb63f188e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 07:12:04.7535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fz+taG4Lubwdicqu6hC+dvettnCBbVKRKqPVmlgoKbxOIcCRQCWrtgj5iFQsTczBTdpW/EoOvnYk0yh0PYbd/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8424
X-OriginatorOrg: intel.com

On 5/12/26 02:41, Jacob Pan wrote:
> To support no-IOMMU mode where userspace drivers perform unsafe DMA
> using physical addresses, introduce a new API to retrieve the
> physical address of a user-allocated DMA buffer that has been mapped to
> an IOVA via IOAS. The mapping is backed by SW-only I/O page tables
> maintained by the generic IOMMUPT framework.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

since this patch is under your ahtuorship, maybe Jason's s-o-b should be 
prefixed with a c-d-b tag.

> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
> v5:
>     - Add header stubs for iopt_get_phys() and
>       iommufd_ioas_noiommu_get_pa() to avoid ifdef at call sites (Kevin)
> v4:
>     - Fix ioctl return type (Yi Liu)
> v2:
>     - New patch
> ---
>   drivers/iommu/iommufd/io_pagetable.c    | 62 +++++++++++++++++++++++++
>   drivers/iommu/iommufd/ioas.c            | 30 ++++++++++++
>   drivers/iommu/iommufd/iommufd_private.h | 18 +++++++
>   drivers/iommu/iommufd/main.c            |  3 ++
>   include/uapi/linux/iommufd.h            | 25 ++++++++++
>   5 files changed, 138 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
> index 24d4917105d9..1ee7c8e6408c 100644
> --- a/drivers/iommu/iommufd/io_pagetable.c
> +++ b/drivers/iommu/iommufd/io_pagetable.c
> @@ -859,6 +859,68 @@ int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
>   	return iopt_unmap_iova_range(iopt, iova, iova_last, unmapped);
>   }
>   
> +#ifdef CONFIG_IOMMUFD_NOIOMMU
> +int iopt_get_phys(struct io_pagetable *iopt, unsigned long iova, u64 *paddr,
> +		  u64 *length)
> +{
> +	struct iopt_area *area;
> +	u64 tmp_length = 0;
> +	u64 tmp_paddr = 0;
> +	int rc = 0;
> +
> +	down_read(&iopt->iova_rwsem);
> +	area = iopt_area_iter_first(iopt, iova, iova);
> +	if (!area || !area->pages) {
> +		rc = -ENOENT;
> +		goto unlock_exit;
> +	}
> +
> +	if (!area->storage_domain ||
> +	    area->storage_domain->owner != &iommufd_noiommu_ops) {
> +		rc = -EOPNOTSUPP;
> +		goto unlock_exit;
> +	}
> +
> +	*paddr = iommu_iova_to_phys(area->storage_domain, iova);
> +	if (!*paddr) {
> +		rc = -EINVAL;
> +		goto unlock_exit;
> +	}
> +
> +	tmp_length = PAGE_SIZE - offset_in_page(iova);
> +	tmp_paddr = *paddr;
> +	/*
> +	 * Scan the domain for the contiguous physical address length so that
> +	 * userspace search can be optimized for fewer ioctls.
> +	 */
> +	while (iova < iopt_area_last_iova(area)) {
> +		unsigned long next_iova;
> +		u64 next_paddr;
> +
> +		if (check_add_overflow(iova, PAGE_SIZE, &next_iova))
> +			break;
> +
> +		if (next_iova > iopt_area_last_iova(area))
> +			break;
> +
> +		next_paddr = iommu_iova_to_phys(area->storage_domain, next_iova);
> +
> +		if (!next_paddr || next_paddr != tmp_paddr + PAGE_SIZE)
> +			break;
> +
> +		iova = next_iova;
> +		tmp_paddr += PAGE_SIZE;
> +		tmp_length += PAGE_SIZE;
> +	}
> +	*length = tmp_length;
> +
> +unlock_exit:
> +	up_read(&iopt->iova_rwsem);
> +
> +	return rc;
> +}
> +#endif
> +
>   int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped)
>   {
>   	/* If the IOVAs are empty then unmap all succeeds */
> diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
> index fed06c2b728e..666440e32c9e 100644
> --- a/drivers/iommu/iommufd/ioas.c
> +++ b/drivers/iommu/iommufd/ioas.c
> @@ -375,6 +375,36 @@ int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd)
>   	return rc;
>   }
>   
> +#ifdef CONFIG_IOMMUFD_NOIOMMU
> +int iommufd_ioas_noiommu_get_pa(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_ioas_noiommu_get_pa *cmd = ucmd->cmd;
> +	struct iommufd_ioas *ioas;
> +	int rc;
> +
> +	if (!capable(CAP_SYS_RAWIO))
> +		return -EPERM;
> +
> +	if (cmd->flags || cmd->__reserved)
> +		return -EOPNOTSUPP;
> +
> +	ioas = iommufd_get_ioas(ucmd->ictx, cmd->ioas_id);
> +	if (IS_ERR(ioas))
> +		return PTR_ERR(ioas);
> +
> +	rc = iopt_get_phys(&ioas->iopt, cmd->iova, &cmd->out_phys,
> +			   &cmd->out_length);
> +	if (rc)
> +		goto out_put;
> +
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +out_put:
> +	iommufd_put_object(ucmd->ictx, &ioas->obj);
> +
> +	return rc;
> +}
> +#endif
> +
>   static void iommufd_release_all_iova_rwsem(struct iommufd_ctx *ictx,
>   					   struct xarray *ioas_list)
>   {
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 2682b5baa6e9..13f1506d8066 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -118,6 +118,16 @@ int iopt_map_pages(struct io_pagetable *iopt, struct list_head *pages_list,
>   int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
>   		    unsigned long length, unsigned long *unmapped);
>   int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped);
> +#ifdef CONFIG_IOMMUFD_NOIOMMU
> +int iopt_get_phys(struct io_pagetable *iopt, unsigned long iova, u64 *paddr,
> +		  u64 *length);
> +#else
> +static inline int iopt_get_phys(struct io_pagetable *iopt, unsigned long iova,
> +				u64 *paddr, u64 *length)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
>   
>   int iopt_read_and_clear_dirty_data(struct io_pagetable *iopt,
>   				   struct iommu_domain *domain,
> @@ -346,6 +356,14 @@ int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd);
>   int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd);
>   int iommufd_ioas_copy(struct iommufd_ucmd *ucmd);
>   int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd);
> +#ifdef CONFIG_IOMMUFD_NOIOMMU
> +int iommufd_ioas_noiommu_get_pa(struct iommufd_ucmd *ucmd);
> +#else
> +static inline int iommufd_ioas_noiommu_get_pa(struct iommufd_ucmd *ucmd)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
>   int iommufd_ioas_option(struct iommufd_ucmd *ucmd);
>   int iommufd_option_rlimit_mode(struct iommu_option *cmd,
>   			       struct iommufd_ctx *ictx);
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 8c6d43601afb..3b4192d70570 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -424,6 +424,7 @@ union ucmd_buffer {
>   	struct iommu_ioas_alloc alloc;
>   	struct iommu_ioas_allow_iovas allow_iovas;
>   	struct iommu_ioas_copy ioas_copy;
> +	struct iommu_ioas_noiommu_get_pa noiommu_get_pa;
>   	struct iommu_ioas_iova_ranges iova_ranges;
>   	struct iommu_ioas_map map;
>   	struct iommu_ioas_unmap unmap;
> @@ -482,6 +483,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>   	IOCTL_OP(IOMMU_IOAS_MAP, iommufd_ioas_map, struct iommu_ioas_map, iova),
>   	IOCTL_OP(IOMMU_IOAS_MAP_FILE, iommufd_ioas_map_file,
>   		 struct iommu_ioas_map_file, iova),
> +	IOCTL_OP(IOMMU_IOAS_NOIOMMU_GET_PA, iommufd_ioas_noiommu_get_pa, struct iommu_ioas_noiommu_get_pa,
> +		 out_phys),
>   	IOCTL_OP(IOMMU_IOAS_UNMAP, iommufd_ioas_unmap, struct iommu_ioas_unmap,
>   		 length),
>   	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option, val64),
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index e998dfbd6960..7df366d161f1 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -57,6 +57,7 @@ enum {
>   	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
>   	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
>   	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
> +	IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA = 0x95,
>   };
>   
>   /**
> @@ -219,6 +220,30 @@ struct iommu_ioas_map {
>   };
>   #define IOMMU_IOAS_MAP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_MAP)
>   
> +/**
> + * struct iommu_ioas_noiommu_get_pa - ioctl(IOMMU_IOAS_NOIOMMU_GET_PA)
> + * @size: sizeof(struct iommu_ioas_noiommu_get_pa)
> + * @flags: Reserved, must be 0 for now
> + * @ioas_id: IOAS ID to query IOVA to PA mapping from
> + * @__reserved: Must be 0
> + * @iova: IOVA to query
> + * @out_length: Number of bytes contiguous physical address starting from phys
> + * @out_phys: Output physical address the IOVA maps to
> + *
> + * Query the physical address backing an IOVA range. The entire range must be
> + * mapped already. For noiommu devices doing unsafe DMA only.
> + */
> +struct iommu_ioas_noiommu_get_pa {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 ioas_id;
> +	__u32 __reserved;
> +	__aligned_u64 iova;
> +	__aligned_u64 out_length;
> +	__aligned_u64 out_phys;
> +};
> +#define IOMMU_IOAS_NOIOMMU_GET_PA _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA)

can this work for normal vfio usage as well? e.g. vfio usages that open
devices that have iommu procetction.

My concern is kernel does not prevent normal vfio usage from invoking
this ioctl. If it works for normal vfio usage as well, may just remove
the noiommu term from thie name. If not, may be

> +
>   /**
>    * struct iommu_ioas_map_file - ioctl(IOMMU_IOAS_MAP_FILE)
>    * @size: sizeof(struct iommu_ioas_map_file)

