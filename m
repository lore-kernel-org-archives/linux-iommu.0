Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D660F7E1
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 01:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742519753; cv=fail; b=oumgBqLPTIoBV2JMbPLKXVhhTGsxucmK8kJqKK01NY4cbKTvi0TOjHOi9DFbFhUcGe5oZXZnJPWc1RROEynPPVuEqVC6Es7FlbHORNXxcz1q1WdOPP/Hk6xGLlvJkeVCvxuOK8qlRmpeMvIvYv8Y8Iu86mjKfjV6DXIioBmXQZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742519753; c=relaxed/simple;
	bh=OnLI7DhLPg8aT7b7TK6SdWa/jBibhfBCaCxrPPputMY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TRkxjQ7O+8ZDi69kWrIl61y6sfQf1GvXZXOb1R2RVnNdXPpAOPZ3J8wSBHC0b5/qw/itbnRsohxaqA4fNn2qa3lx8oR1G9+NPc11auDw4AeJFjBNFXsYWNEUYbgi+BiW66XUGH9GSPzGPpx310cJIo+oL3vtD/ft1c7m58vTwBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0KdNY+L; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0KdNY+L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742519750; x=1774055750;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OnLI7DhLPg8aT7b7TK6SdWa/jBibhfBCaCxrPPputMY=;
  b=J0KdNY+LpM0ijLxdKu8ybMnA1dhcGkW1AER+Veuz+9vlHre1XKSnnNTV
   em14SOkH7Jmf19pS8IqLtBcrXdLvSOjOEKLeLllLMnC1ZymxoxEQ73EAO
   U5XkSOPUCh5vWbYNnM4bKMyWO9Gu42BmStZ0eMU+It+rYE7KfaUnY4oJu
   0fR3XSAGqdUGMlAdMoSWB4FOfAHu/stYDpNEBR3PMfunRxxwpXrc89Rem
   bKNxAmPrW5R011hcGZ8+x/u/kxtLwu5Zv99jHw/GUnxlqKdaQNY8o9PFf
   G+Z7WEwu6UuRumhoMrW3MBf3q09wycjWBbv7jP5gydOYzQ+lBTWP84a/p
   g==;
X-CSE-ConnectionGUID: We3MGMMRTtmBnlj9p11/AQ==
X-CSE-MsgGUID: rv6xzlnCTni3v20+VyvGMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43657660"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43657660"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 18:15:49 -0700
X-CSE-ConnectionGUID: QEjAz8VfRouBWbNdjPKyYA==
X-CSE-MsgGUID: KcUjVprcQjuPwWMaFJab9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="146486838"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2025 18:15:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Mar 2025 18:15:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 18:15:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 18:15:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMcYTrepnuInVLjJk/iOrsoGpX0PVS5TzSVG6nKYJsgs6tzDTRTMG1eA8L3RhB1DYG4ABmL5J1Wfn/sl8vJjR83LQsFK2EFu35wkM/j9WgaEWZye//R26hN5FwxxtsOUMueVJpMqSO08S2PP89Vz91fCFwPmVO0xEZtsyqwAo4MgeMRwPx+v9bV8fhVo1iVi4ZgbYjlAzfci+yVBy/NCavFS7OYsiknntb1nlZq5WDN4weS2NUnH+293v75nbodPhatw1DAYeAFU6TGxaxIU3cxDjKqm/731DxvmdZidiVsCgiyLtiQj26nQttN3GzF6LOzncnWD5VSVkuoRSNEe7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXNV+2IgLlwPGX7XvyFQDwFnFSbRPypeLyu5Hvv5C50=;
 b=H765D14tJLPllNUlXL5ZEiqy9ri4dXMz5tApR6SEk07H5zeL+sRKkjUNiOhkN7zDoL4YeUaXjnpcOr3df1rPoYAvzquUNoTYdATIrO3vQasaCpJluuMyOPX2USPdx1e3iQ0OeskREd/GO/25LvCoW8R9mVd3hsYKywu0gqvBPggBmt6B05UUH9cyFXnI7Xhh4Nt4kjXOtl6CSxqs5epximAvrMMqhCTeSpVPzxJ/aeN25XQ25sO2MEbcLm4nMq3xFdJRGH2O6dIKMdSS9NDrzoAls4VpIrCHe8dDnvZfo7hPvDTJgdf4jW/TALDmKuEIFCIN2qpdNMcbqfcxCGUcHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA0PR11MB8353.namprd11.prod.outlook.com (2603:10b6:208:489::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 01:15:26 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 01:15:26 +0000
Message-ID: <a5bd81ef-6231-445c-bc41-5a801cdf5b80@intel.com>
Date: Fri, 21 Mar 2025 09:20:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 17/18] iommufd/selftest: Add test ops to test pasid
 attach/detach
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-18-yi.l.liu@intel.com> <Z9yiwAQDeCkBZ/5i@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z9yiwAQDeCkBZ/5i@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::30) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA0PR11MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 53446fb6-c45a-4108-4d4d-08dd6815dca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eE9sNlhiTndPTWxXcU1vU2hpN2tGanFESzlhSU5hanFZNktJNk4zei9Oc2dT?=
 =?utf-8?B?cmVyQjlmbHhUNWZNcG1meTczM2N1R3ZZVHV6ZUhtOTBrdG9iMUtPQSsyZktG?=
 =?utf-8?B?cXZmbFN4QzhTNmhUYkczRldqWGRvV2syT3R2YnZMR1A1QzlVZnFQZ2V1QTVx?=
 =?utf-8?B?THZFdFYraUpHQjNtblRvTjluZkMwZWFwRExSZXluYVFPTDFOLzNQeFZCNENa?=
 =?utf-8?B?N05JbXo2aEw4OWtBWnVTMSswVkp5eHV3Vm05NjFZd2tkK1BwKzVEVzNLQzlk?=
 =?utf-8?B?TmhHQ25DNTczQVk2UE5TZkdEOVVvVURJZGNjNU02MG9EeGV2cnVmbFRpTGgz?=
 =?utf-8?B?T3hPOW4zd05VbzVoRUlBOTgrNnhZM2R1VGZZakpjTGJDTXlINGhTazBhS0hP?=
 =?utf-8?B?SjMwenFuYzl2OFdOMUFUcVdWTEt4bExUMSt2bzdIMDZhSFhlR2tneXFUZy9j?=
 =?utf-8?B?YWNKZUw3USsvZEVyckRmUlUxT012cFQrQTBER05ZQkFnbEtBelkvV3dYbnUz?=
 =?utf-8?B?cEtWclRCaXN6YzNJRGJQR0ZzZk51M1Q2d09SZ05KSjdDc2xaTW4zSEFtNTJn?=
 =?utf-8?B?aE5vL3ViNFRCTmNYU3g0TnRSeTVjckZMZE1kalVDZnFxNVdWTW1zVjNseTRo?=
 =?utf-8?B?QkgrT1JCeTd3Mk9hV1B5YmwrN25rZkFoZnJrWTJkMmNqUW1ZZWlVTWcwb3RR?=
 =?utf-8?B?L2loYWxJRlh3eHdXd2V3M3BhNE9HYlNLSlhiTW5TTHgrVVBLcmpDOThwMUNF?=
 =?utf-8?B?VTAvNjNPelNpNnRkVE5CVjVobUZiaWxjZkVLOE1VYjhpbDJra2FoRE5SdzZi?=
 =?utf-8?B?N3U0c1hvVkd4U1k2TkU3ZjJxYW4zcGNYNitYUUFZS0pQRkNGZnV6enVrckp3?=
 =?utf-8?B?TUxqb0xsaTVxZXpORVJPdkF2azEzTTdYM050M2E4VFZHTlB0OENzQVl3UURa?=
 =?utf-8?B?Mll2MTlsbU51QXEwbXdId0NGUnBlcWc3N1dza2IwN1RmSWdxUkNYV04xRWxi?=
 =?utf-8?B?SEhPQjFyemFwak5xS3dZWkwrVE4vTVRJUzJQVHlKb2lQeklXQWhxOWphR0k0?=
 =?utf-8?B?RkxieE1BelRDMzZ3MEJpVE1QK0xVOVN3cG5qVWVQN05NOUpGdzJENmU2Zm1M?=
 =?utf-8?B?VGlleStweVlTKzBNWndwMlFQaTcvd1VUd2tPRXFIaGdVSnhobU9oZXBxcjFQ?=
 =?utf-8?B?emk2emJlOHM3NlZ4TW9Ga1JEUGh5SjJRdGVRbmdLcEl4RmFNeGtDSHB5K3V2?=
 =?utf-8?B?QXh6eVpZd3JRajdWdXZyYlV4U3R4M1JSd3dFRG54UENGVmRyS28yUklRMkxS?=
 =?utf-8?B?UFNKMW9Fa1FjV3hIVUEwdkhibWFIMHVCNTZzenBCbnZoNFNBMTkzejlvSEds?=
 =?utf-8?B?M0xnMkhCMnVZQktCODZJSExSSE01TytlK21FemFhU0o1bVlpcHU1cG94bFFO?=
 =?utf-8?B?cGQ1S2ZFdkt5ekdFSmphUmErOE84ck5NZjdCYzN2cXVmdGlmSFJ3L0lWd2xk?=
 =?utf-8?B?UTdEUE9wcndMbzhpS1lrZ0JUWG9BMzNQalcyNWtjS0ZIbDVVMGcxdXNoYURF?=
 =?utf-8?B?WDF0L1lUa0syT3JoK3FESW03RFpTTTh2MGdKVkgyZnlvRVFsS0lRN1dzNWZM?=
 =?utf-8?B?KytKNDRha1ZpVzBwTjNnV0U4c2xMbGdlNE90VnczNmJFMlVxMElJa2dxT2ti?=
 =?utf-8?B?Q2dmM09SZGN2SFVFRkZzQWJwSTRoVUhsd3BvR1VqYmJ2Skp5akRnNjMzWFo2?=
 =?utf-8?B?Tlg3azYxRkVIdlBJYldSb0VSVm8xSGxoQnM3b3ljRnV3dll2S3ZraHo2Vnh0?=
 =?utf-8?B?WGFyWi9Nb1lOb0YvK1V1MnRIb2loQ1A1M3pqNDBmRGJKS0tJWXh5SGljYjNx?=
 =?utf-8?Q?ZgdvdkXYJtw6b?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3BaUU42aVJTeXpjTlpTcFFOTHNhMkVtL2xNRGp4a2RpR2RZOFd6S1NQL1Zx?=
 =?utf-8?B?dzFYTEtvRVlpdytMRTZTaE5UOW94cW9Tb0dkZ3NOUzlzM2ljcFBWWG12cmR4?=
 =?utf-8?B?U1Jad2piWDJWUnRkbUZNdzdDSXA5enI5UHU4YUpyQk90ZWVoWWhoVGE5VS96?=
 =?utf-8?B?b3g3dmJwSkR4eDZWWEhvNzloMFdvY2dEZjB3bFZHVy9FbGczY2xLa2pwcnR1?=
 =?utf-8?B?dGMrQTYyeDNWU1dWZU5teW92THliY2tza05wT2l2SnZ4aHU2YTFObWJWaVl4?=
 =?utf-8?B?SGpJbW14SHNWV05wNlU0Q2xyeFArYmFnMUxlWFZvaEZIQmVFSG10N1dCTGFw?=
 =?utf-8?B?Tk12RnRMQVJ5WVk5TWNWRmZHMTF2Mk10UEpJZWZabUFGMlNxN1F6QVVQNTUr?=
 =?utf-8?B?SU5MbHlmcFVzUm1MWlJSYjQ0V2JMUUFpNVAwRng3QXRSNUZGK01qOSsxb3Zv?=
 =?utf-8?B?YTVkZ3h6R0lSQ3F2WWdtTmFKcXJXeVRIY2xaZ1VGODB5dVAxU0JKNVZCVDFT?=
 =?utf-8?B?ZVdyQjZCbWw3Q01qTmpUaU1jTVpqemtNN0NreC9HaHZzdHhvbitvQmxOdFh2?=
 =?utf-8?B?eGpuWTY2ZVA0aE1UQ3QwRmZwZUpRdGF3S3lQNkthVnhvTVY0N0lvVkFTTXp6?=
 =?utf-8?B?ZTVxR21YL3RCM0RSNE41cmZlZGZSeVBOL2o0VHVWS2xtcmFzN21EYmxybjdF?=
 =?utf-8?B?K1VDUGwrdWpTRXgraXMxNHlHQzVDRGhneGozbU5VZXZIcTdkQU1UcU95L09j?=
 =?utf-8?B?U0tTUHBnWXdlRzU3TzhKazFLWldLZDEwY212NkFrQ2xkVE40WjN2UE5kOFRH?=
 =?utf-8?B?ZktSd3EyeUg2UGdQMmY1UEUrSkFwZksrVi9TT2tjNTM2T3VQa0FvVUNkd2FO?=
 =?utf-8?B?RFJMKzAraTZRSHBVNTltTmRaeFY5OVhYdkVTVkxiMUlHdTRXdXp0RW13WW85?=
 =?utf-8?B?N1RHVkk4ZHV0dUtWdVRsTk9WRG1oWUljU05MWExGVkNSUkxNcThITHBMckVQ?=
 =?utf-8?B?cTFDazNJY2J0cHc3NEFmM1loTk5POU9tVU9XL2MyT0ZpUTFPQ1RwV09YQmJh?=
 =?utf-8?B?am9iaTJ5QkpLUUxXWWk3cGVpMTA3K2JqWVFvRHdkR0hOSjJiRGorZGpWN0ph?=
 =?utf-8?B?b2dWRlQvblVyak1yV2NhOE9zSThHeWZlbFFJNklCNU80RFFFUktVRExUY3Vz?=
 =?utf-8?B?bU00N2ZERko5b25RVkZsV2VyeXJ5aFpsZGd0ampIVnIwYnNLMElPRlUxcEw0?=
 =?utf-8?B?RTl6UUxmT2gxOC9laWhGdHVRM1U2d1F0WkFieVFrNWZjL3F5QndqaWgrWnVo?=
 =?utf-8?B?OTc2aHluSldjNkU1UGNjSzRKL1M3QUhRblVUd3ZidEx1K3VwS2hvKzNnc0dl?=
 =?utf-8?B?S3pVbURuN2RIQU8vYXYvVkt1OGZkWTRnWXRkUkE2QjJ2RkdhYzhHY0pYaTFt?=
 =?utf-8?B?anprQmNZemEwTlB0UzBBUTJzeFFYVnY2cE0vNDUyR0E0SWZ6Tm9tdGZvVVVU?=
 =?utf-8?B?cnZ6bmowck1neTJVdTNwL1RzRm1PdE1NRElZeU5zeVhUTGFtOXZSRGZ0cHJZ?=
 =?utf-8?B?Z1JWUTJmZW42SG9NMFlQTjVVOVZvcFh2Tmo5ai9zU21sT0IvR0t0Q0lVQ1JK?=
 =?utf-8?B?bzJTZjlTZWxpOVFJVE9uMjdoZlRVUFF3TnRYb3dDN3dKOG1reUEwNWNPVnRo?=
 =?utf-8?B?SGROR3pDOCtrMnBMTnpPU3FUcDlJZEtKU0dzdlFqb1JOOWJNYlpUSWNXOXds?=
 =?utf-8?B?U1F4QnZMYnZtTi9uMUl1VHFGNEVnd0IwUXlSbnlpZDN0SndYamF6czVjTy9C?=
 =?utf-8?B?MXF3aFJnbHdIM1kvRDE5a2RGRS92RXQ0aDB3bktta2psSEpnTDZuQVJpWGh5?=
 =?utf-8?B?UEwreEg4RGhmUnJKNUlydEZpQmxmZFhMSkloeGFsOUt5bFlMTHBRZUtsajdT?=
 =?utf-8?B?K1ByRnNLanVsb2pDVkM0MlA0bkFnVExDM05zNGowb1UrRzNNRWZrRnk4NHNo?=
 =?utf-8?B?Q25tRjdaRzJJZWlOdGhnWXdnZ3dtbk5yZWxBdklsVFY4L3JOZEQ5bVRwc2Z3?=
 =?utf-8?B?aVhIc2hQTjBjaWp4UHB1UkgvYkVrNDEyMGdsMlZsWk05Mlkzcm4xcDQzdm1r?=
 =?utf-8?Q?ai/Wty1NzklSwMxbhDPNIF6OS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53446fb6-c45a-4108-4d4d-08dd6815dca3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 01:15:26.5068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWHbtVEh9eyMfmCcN7jiT3FZhUD9xdD/DAlNDJn53iZDeRqz3qglE1U/GR5LN+ZXxVJwi9O5HjUdYuhTHae9rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8353
X-OriginatorOrg: intel.com

On 2025/3/21 07:20, Nicolin Chen wrote:
> On Thu, Mar 20, 2025 at 06:47:43AM -0700, Yi Liu wrote:
>> This adds 5 test ops for pasid attach/replace/detach testing. There are
>> ops to attach/detach pasid, and also op to check the attached domain of
>> a pasid.
>>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/iommufd/iommufd_test.h |  31 ++++++
>>   drivers/iommu/iommufd/selftest.c     | 151 +++++++++++++++++++++++++++
>>   2 files changed, 182 insertions(+)
>>
>> diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
>> index 1a066feb8697..efcb509f7d56 100644
>> --- a/drivers/iommu/iommufd/iommufd_test.h
>> +++ b/drivers/iommu/iommufd/iommufd_test.h
>> @@ -25,6 +25,11 @@ enum {
>>   	IOMMU_TEST_OP_TRIGGER_IOPF,
>>   	IOMMU_TEST_OP_DEV_CHECK_CACHE,
>>   	IOMMU_TEST_OP_TRIGGER_VEVENT,
>> +	IOMMU_TEST_OP_PASID_ATTACH,
>> +	IOMMU_TEST_OP_PASID_REPLACE,
>> +	IOMMU_TEST_OP_PASID_MIX_REPLACE_HANDLE,
> 
> And we ould drop IOMMU_TEST_OP_PASID_MIX_REPLACE_HANDLE?
> 
> And totally 4 test ops instead of "5" in the commit log.

yes!!this should be dropped.

-- 
Regards,
Yi Liu
