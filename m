Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7A63603DB;
	Mon, 19 Oct 2026 07:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393441; cv=fail; b=ItMgqbHiJJP2Cpbu5DDUPSAj1DLlrpI2FWq13B9ovnkrc7i44LzI1KzZd2yxCJc46TCi8F4cXUGPru9RkW41TBZ2DSfpS9aUKtI2/2VPmkKc+YFMsFvZ/p/ksRZ+2mvkTgSObG9IWp8KvVMUCK1zjfYV/X98Zq1yiLmiGMN+31o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393441; c=relaxed/simple;
	bh=6okEMB3dbIhkhxWbAp97OxapkUd0QzqqKRZqwgiHXM4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lbAAfg+xMoLDNDRqr9kBH7Hx9QxnfshiffdOVHCq/eqQXl6rKCg5ItAOcNdpyF0acGzw4ifg/ZEfpBI1PNBhK5xs5ZPvLRIqyEvkmmZ/6epiXFSD5bsH0EYwmIkDlWEdwtMwLiczSGTE1rYU1KxcSO6u91Q2WEi1iKDM/IozrLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C53jxuag; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C53jxuag"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792393440; x=1823929440;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6okEMB3dbIhkhxWbAp97OxapkUd0QzqqKRZqwgiHXM4=;
  b=C53jxuagYlrqiJFrevwkqkbB4SPuvHURKfVWqBAH5gkVbCbWxAZg4uD5
   kNNyJ7g8NTcT3YDeaI1iFxiNHW/DaeyOIxOgLD+VyTyG0tY+5EmieCaT+
   4cMHGf/tw+9+BR8KtD3MpHl8IGBrRuDu+YzNvzpOWEGqBwthaQTYnx72H
   GVKcFqZr0uaUxVi/wJDOws6EuwSPkWz2q1iBlqNaj1XF929xhAzMdFOXO
   N5V5QI26hu2LE5OvLX/JAMD7pRV91cqny4qxFoQp1zERYMArp19JARhg4
   XboKpoUxSc8k0HAVg8B3xkz1YnHB2DRb9YkYiiG5xshlWDlaoX82vMZSR
   Q==;
X-CSE-ConnectionGUID: 1fff9PaqT4u0Ig45fy11kA==
X-CSE-MsgGUID: WqyvMjx8Sv6wKzdxRgGXqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1175911"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1175911"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 00:03:59 -0700
X-CSE-ConnectionGUID: qU59e1SHRYalEoYOIzIVnA==
X-CSE-MsgGUID: kX53vz4gQPSs8xrm5KXHXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2465985"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 00:03:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 00:03:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 00:03:57 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 00:03:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIUMXs1JGSJ5IoX9vKzOWDp62ivj/JjSk/snf7uejSzBHtIwS9vGX0tzbleeWpsE8zm/aR6SnKhFDj57UQyz0z93iRRTCuSJL2r2wLfqBoHKWwOrfyoty6D25eHgkUIU5pkkfHhsBGHENzEB8cfF0v8fR/pwwQ//UgvxT5Pfhv+eeFd+hOQ0e3NuebVWTFCCf1EPlMXkcDCE72GL8nqMW2F02YpT9YJJ0ARSlSj0uPjPq5p+/2AsiCz5l/crWHswfNRP60leCKwfB54YmLMqjtlJK4TnFJt770velkTGRzlpao9PlWeP6iJWE3QtuVdmASfZfDpUIF4w6DGx3Arcow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKK//Y007Z1goE31W+aEpm20D0p5AR4RSGldsFGEVco=;
 b=HEkd4g4rcjp5aKXM8EwmPWISt7jxikdLf6nbN+sVwLnYkGlKtWu4FWKiM7irPbyG2Abk8g6JPU1weblSdmVNo5nF/JChCeR3bPFeZr4myJ/AHQkd6++kRPHVfuJ0Sxg4gRUsK0k8C7K6bFPHSud/2O921I2oEZfiGSGTmLWxCjny003CuiAby3GgkFegPjY2t6y4L06AGVrYBj1fniuTXyoW3U9z7wFQLiIphu9R8aq5CSAiDxisko3Ygzme6+CU9LSrOa8Z0MoDuNJes3iluYVOL0UO5n+Ug4I8V1lqgL79Vl4WkFLwBnHVzuTfdcnsRt/y7gEszQE6eJEz0SOrIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by SJ0PR11MB8271.namprd11.prod.outlook.com (2603:10b6:a03:47a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 07:03:46 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 07:03:46 +0000
Date: Mon, 19 Oct 2026 15:03:35 +0800
From: Chao Gao <chao.gao@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
CC: <iommu@lists.linux.dev>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
	<kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
Message-ID: <atXAxzxYdDo6RbHM@intel.com>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-5-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261015010705.1973284-5-baolu.lu@linux.intel.com>
X-ClientProxiedBy: PSBPR02CA0010.apcprd02.prod.outlook.com (2603:1096:301::20)
 To IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|SJ0PR11MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 921a281d-698b-4d18-efc9-08df2daf1e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: HKCpVTubiSZXWVKF5ZKStWqSHH9scRXPW+kdMPFrh2pKIEP2Dg79ajjxhBEbwEyvTT8Jn0ChLJSCiZW9Y+xHp3XLNl0VtmysE9gNTfq5oG+I2xVWXD5l9nFUJYZKYsrSzHECj+/7zu8Za4DniLJqgLQElfcfzeQjKYynob5djAytFyFChoQ9Re09/DCLiTs/qMq+DT1UZ01oeaq9odtotVjw/7STv/wXL6GJb+SJHJfXqTVUhWmhxav+Cw//YdtRoWOGa8iy5L+7Abq9y6Iw71zNaouWa35qPTO0s5CatRNohwHOy4l7Ojqq1JvnLo7evoNC1TXagty55A+14slUaFTplkbPuxwXsdNFmFiw3f3J84rxIwZvq/awAUrwrPPstNOd868qwwXrxfk+/4AtWFkBuXACyJ+9ciC4dP7E/e/0o8VkvIyMkEADoZWrjQf355zkbKjyxHSJU1dNfCtqMQgz5Sdd+hv07EjMgClcX2HpRVrlgKRAQm9vtx/KLLdI6yIKwQxJZprtwMqgL1VNkW5f14/3v6FXWbMfcPdan011zSzzZJH1UobA214IImqVSpdFuR4jVdynTSTjQFYV3/Xj/C8BPU9UEFs99IK2C2YAGhW2jsm6E0aYQyDjCnXnhCKzxhGPilWgU7yB5mSezaLsRDM7pW1bd7dFub5pBsY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sgnMeQpwBsoJ8KJcEXpmIxVNc+iduzJZQlUpbNPLes4esB182/lFX2xY5YLm?=
 =?us-ascii?Q?2mLs7HmOcs3p4V2Bzc13bvEsexmXvHG9IYgjmQnTtNe7pP0SmVxYflgA3MJA?=
 =?us-ascii?Q?JxQbALig4ahmWqYNUnJ5HC9StJnzSv2q6W0sCRggeRONUJU4XsiDyd0hfsya?=
 =?us-ascii?Q?W2PgPWeoL4I07DKqwK1/m0FJwAqi3Tj7D/Mmc6HvtV8j7bDkZJ+/PfxeV7q8?=
 =?us-ascii?Q?khlffG7xcIkIvalI6VhYzOmEQRP/GpPETWho9zPFOdjw7hnJ3o8dnVv+0UC5?=
 =?us-ascii?Q?ZBnDheDB57QLW8Zm54lQcqVy+43VQfFMyA48XB0VLrxZDyznzUmvqQwjwg+E?=
 =?us-ascii?Q?HAPkasq7d2Czb1sZWiwAawHLbfkJUvYzMzrRihEZ3XPlMv6TJDpN5Nb8AD8p?=
 =?us-ascii?Q?rOBQIDJ8NrmvzXgVJCRArbYLn4j9+P+t8ZFeAoHOqd+SN15vXxbHSzAX/lvd?=
 =?us-ascii?Q?orJH8iloZrGa7g4ChvWa9TjHRVviB0lEe3FMgbbudLMuHKMuOu50RQs22xRi?=
 =?us-ascii?Q?uJZ4BBJYz95pE5cVDB8UIZwFDOJbF/4Q4yS26l3AGazWax74H6I1adeZF03u?=
 =?us-ascii?Q?ZJ9MmbO34U4/LqEUEF2KWoSBnpPm/oQ+fnrvzdbREc5nxzxR2TX9T5zxDBVt?=
 =?us-ascii?Q?Qiwa85WiziFLo1dG5aURNNpFGhhaSLffFFdmYnfFQJ/qPsHQek34xczaACBH?=
 =?us-ascii?Q?GT9ok5UKauilPLLRvRyQF95pEpEJbMpYZ/b88nQ/IjRfys5vZYkSC9WbWvtz?=
 =?us-ascii?Q?crsfrg4fTZVtPDJG+mGv4GFrc8wDUSC/05/Tf/giv1i14w8t+v5dRNzNpG92?=
 =?us-ascii?Q?x20eKcUnAQvpX7ydfOaWfbMRTFv4dvSPoJLx0tspRILFENYwRolCIbXiyFZ6?=
 =?us-ascii?Q?zNTxsag9+y9aXc85x3vj8yghElM+jL/pCMBbqPp9VErxg4vxUb+2gb6VUflK?=
 =?us-ascii?Q?UTDCe+bzIcJjOONXdY1ts1+R19P7lHcCTsbFAPpq8X/mMePSwcF6jBGRIW8s?=
 =?us-ascii?Q?S8Sv8Den6mGIdd+1OpDyjVM89WRGrTi1bCPqB0TrgPnpCYhhXTmgC+MR8iPz?=
 =?us-ascii?Q?HQWiDn2F/8cZ6Uw3+OzNt9zAIjTJtv4ctwmzm4HeXJ9BKFx0dmWzuvOaMrVV?=
 =?us-ascii?Q?IBquFtN20P0ly1uiCA9GzhpKLLCsC8PWoTmNXqEh9Rl/nyduEo1nUqwHBOuV?=
 =?us-ascii?Q?02MRDmSEYkn07Q7bLfXOa9OWLC7aZHRYKd0oQR9245poIv/yerERCFaKtDeN?=
 =?us-ascii?Q?uc4zf7RG5l25/yX0Daoz9UkYI0x8V/vulfIBoofw+R8QLg65p4QTBYpgi5G0?=
 =?us-ascii?Q?hfwbm65BxBKfutkn0jlZ8DKeox5X5u4xuQOT6U3deUPr1T7oBBRxlzsANECY?=
 =?us-ascii?Q?KLl931I6RBo1yNOP13LKhNQhRMeGEQ42GWuZ8RrRcrf5Fq+YtZIp9VL8vy+h?=
 =?us-ascii?Q?OiGgWO0OyiepNtnWfSaox1GZFnqEA4lIUFmA48jYXRk+NMxmho8zM7ENLZFP?=
 =?us-ascii?Q?VczJUomBYoHmaICTiwX7WUFaIzX+HQJVUFkZ/IiY5u/nk9Hj38gtfRw7nagJ?=
 =?us-ascii?Q?sp10qLLoGn2DzFtBAiGQCT/HUNtTOQOkFShXi+XS022rCIT2h6FIqsD8Cu1w?=
 =?us-ascii?Q?nTBSUJ+dNsD2/RRgA7nIOIxy1sjl0f7qWrcgJsjyWYLdK9hM2mpaHu5hDys9?=
 =?us-ascii?Q?kuC6nd+qhSmIM2flS8mJx01yeWoiyYa11NROcmOmaiUgg50pS+DAaazKbfhw?=
 =?us-ascii?Q?I2LLQbe0cg=3D=3D?=
X-Exchange-RoutingPolicyChecked: zfriOKhTBEF8Ko2aVcoav55F1LP45uoLnrbsuesvhEzMi0WZpr620KBoQIdie45sZd7oT2ob0/5km0CURCMTpwstsO0ajkTaHxyMq/2qjZUGUYvKOgvyGqeYohz1CLqPwMwI6tnZ72kMHmzi8T81FCC0GiutB+9XY8Wik204ZEdvbu9Se8Hi8ubvX+qzhqQHrGUhrlaJoGtpKuTJ+n6Yc2DXVCQVc3zz3kzumCm/RA6B0nddM/HAj4JoljvznWOcuY/p5pC2yCWg0Bg5NfjNqbz29PxGgWeDiB5LOErTP6koD3sFLuTvqDgjzDQDY7R9Cff3gMsDXtcJn/N8iiGWgg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 921a281d-698b-4d18-efc9-08df2daf1e03
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 07:03:46.0200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afxq7FE196wbXWKVQMopY+wrEHs2tBTLKJx8ODzsBMz3XvYjGVPcSdJfgFLUb3v3fLfpddHp7JaG4lrWl0SkZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8271
X-OriginatorOrg: intel.com

>+static int tdx_iommu_setup(struct dmar_drhd_unit *drhd)
>+{
>+	const struct tdx_sys_info *tdx_sysinfo = tdx_get_sysinfo();
>+	unsigned int mt_page_count = tdx_sysinfo->tdx_connect.iommu_mt_page_count;
>+	struct tdx_iommu_state *state;
>+	u64 r, tdx_iommu_id;
>+	int ret;
>+
>+	struct tdx_iommu_state *iommu_state __free(kfree) = kzalloc_obj(*iommu_state);
>+	if (!iommu_state)
>+		return -ENOMEM;
>+
>+	struct tdx_iommu_pages *iommu_mt __free(free_mt_pages) =
>+			tdx_iommu_alloc_mt_pages(drhd, mt_page_count);
>+	if (!iommu_mt)
>+		return -ENOMEM;
>+
>+	r = tdh_iommu_setup(drhd->reg_base_addr, iommu_mt->root, &tdx_iommu_id);

Dynamic PAMT was merged in 7.3. With it enabled, the PAMT for 4K pages
is no longer allocated up front, and the kernel must add PAMT backing
before giving a page to the TDX module. So, the IQ buffers and the metadata
pages need tdx_pamt_get() before TDH.IOMMU.SETUP and tdx_pamt_put() after
TDH.IOMMU.CLEAR hands them back.
