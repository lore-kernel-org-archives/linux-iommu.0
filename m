Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A03926289
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737355938; cv=fail; b=aydWihd403aX2tgYQOYcT4Hnk0uDkr2MB/xL3U1nqvZ+CzStEnKCxTU4Lew8LBAPG7w0eBT+18NgiC6bKu9VoBZitoYpAt5mdcsiPRBUYD6EltH2IVxaltlW1/puB/hm+QmeZbXciKuoEM4oZ6CMvl7jpcDaPe5nwwHVDwjLw5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737355938; c=relaxed/simple;
	bh=hGw1lly5IflPcwg4IVOz+WSDAI3CuJXG1xhphd5XfO8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z6xfIHqkGNRpYMb0ln/xKObf9ogLiJFMhIazcB2BrWLRwe4rYlc1ionTFk9RdorcRQRaOF6kYEoJt4wFZuAuqiVZ1PabisgVSqDkQcUc40AWa08XXkNEsld+lJRG/3ppOaaYSgkjv2OOpi3NUXDkDZfQRxdGCmsA/8ZpCZhX0J0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NBqHaqQW; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NBqHaqQW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737355936; x=1768891936;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hGw1lly5IflPcwg4IVOz+WSDAI3CuJXG1xhphd5XfO8=;
  b=NBqHaqQWytKNYXqzbZhdIXmkl4lkCpYZN3a9H0lTp6dMeDRFHPs2ied4
   wTjNBKpz2M5rd0150/tJLjHNome0+/nhmitk11w37HiWKfJc7UHeoiMxK
   QrTY9WJ5jpHy8lnvnenWrwYorHNv8wfcuDaZtKyccgAqLV1CKzZrMHccy
   jbwsC0Mzb94s0/zHAXP+CoU/M6k7jpUhuVGsDfIgIUlLXhJeMqTQdVgiQ
   a8oUxOdJoZtOS9ClL9QOx3R3GA/gYRYhnLMy5lmrex+cLjpH1E5gUKZjV
   5MJQ0nrUJcL3B+5s67dviNxuaoJpKmQe7zyRVOH593Kc3vMRj8A31r33g
   A==;
X-CSE-ConnectionGUID: /Uy0dLZQQRuJNRwm7V8omg==
X-CSE-MsgGUID: ZNFoap4VSqGQHNftjZNOxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="49113729"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="49113729"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 22:52:14 -0800
X-CSE-ConnectionGUID: tXHkK6RuT+muWhHuu72yUA==
X-CSE-MsgGUID: IgvhHhJER52sHc3XawZcpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="106937179"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2025 22:52:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 19 Jan 2025 22:52:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 19 Jan 2025 22:52:13 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 19 Jan 2025 22:52:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3DqlPjE+0cTLAkovCXAbu0K9KNR0zGXNckDLeMjBp5UGRFZMAR6bg2nNSQ1rHuDsBcZv+J0th6TvrAc/tvap134Hx23Wc56pEHUVTniK02oOWelfvFNxnznG3lalXodwsJwm1DpBjGKKdscp4J0GnMfK4UGZvuDROglZdCmaIjtZp7OF0wNsdxVO8KlCtaZtpiOEAvlEAdMPY2vAPsrr6nbrWSZA2O/CObXCQCy2lJ8Z3oKnJSoLTunU4dUHX0PEK3OuOceAiB8xx225fHbJuTqvVvqEnJy9hHBW21+41HfY8mY4elcGJzXZARJ3HTd5Nt7QU447mQnyV/VuR7jlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zX3fWQDinNeh181WwsY0hMfGJZzUcHPKnLBguAxV3WQ=;
 b=Ro+5BXYus/1DOXrNOEdC+Spx+P+UQtLtWqmjrQkJT58+Hd2r6Fnz2FP60mZh4oUjSj3BUuj4O/V/HSti7cwMFUNsnIeGSwwtUZVc7BXDYVQpMam7BqTrjtM/ccIBMVs7tP18KpNpfroaRPFobDQleWp8kn0PB71HMgkpTzqyTdhtJO7jB+ef0i0go+1cl8F+99fJRs7u/ziLrxYwg55ad3X5I2JHItUHqmeE4eEnTdTEPf5Sz19gBK40+4f7jNcI3+o9q50prohakJDK8WAzzGzKCGEsLgibOxp5kSp9MyHgUfN+DuzXmdyy2k/N7wbb49wv6BMFXgw1yybvdGObNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB6376.namprd11.prod.outlook.com (2603:10b6:8:c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 06:52:11 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 06:52:11 +0000
Message-ID: <ceb12e1f-c052-44e4-a700-c9154109dc83@intel.com>
Date: Mon, 20 Jan 2025 14:57:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu: Swap the order of setting group->pasid_array
 and __iommu_set_group_pasid()
To: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>
References: <20250120030840.4171-1-yi.l.liu@intel.com>
 <20250120030840.4171-3-yi.l.liu@intel.com>
 <BN9PR11MB5276B907CFD594D7A49349938CE72@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276B907CFD594D7A49349938CE72@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: eefd17d3-acf7-42a0-285c-08dd391ef6ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDN3SjJGV1ZVOTNJbiswRmJDU21ESFcyd2lQb3JEdDFMbkNTc25kT0JPLytQ?=
 =?utf-8?B?QzUxRnZPNjNlL0J2QTRhQWM0VWx2M0dHTnpWWkZIek5DQk5ZQmY1V3NpM2M1?=
 =?utf-8?B?ZTErdVJIZEZ5NFhRaDZWYTBtU2xZYlo1ZFpUU3JsSmRkU1d4WmdQcG5ia1dE?=
 =?utf-8?B?cTBSR3dkSWFuSVdLR0JDQk5UNC9EUXhXMkY2M0RrUnRvZzBPMlJtQUhKZ0pV?=
 =?utf-8?B?elZnTGNNcXRLSGJDN3VCUGZkNld4L3JhVVU3dkFCTU9LakcxY08vN3lCNTd0?=
 =?utf-8?B?NnBXazR3U094bWptODJtUUthanovMEpaZ09zMklyZ0lYUnFMK29rV1V1ekFn?=
 =?utf-8?B?WHc3ZVE0KzdWWVFTeS9BRlFHVytWWGN4Q0dpR1FUOVpxcXovdDJPT2NMV09u?=
 =?utf-8?B?RGVOK0NNczJZaGJvMGdYMkxQNHI3ZkVBcmhiWHRLeTY2L01qNGQrbGl5andq?=
 =?utf-8?B?NlVvVm1iRVFmc0VYcS9HUkZ2a3cxUnljaDFQeS9hWmQxOW5NRkJDNVNrNktm?=
 =?utf-8?B?N1BXYlNBMFFzUzlmTVU5bHNXMU5NWkRzK2RJbmR5cllYRmFoOGJVcDErc1ZJ?=
 =?utf-8?B?bkFGb0xYVUROMVMzZndDcmN6aFVmRERXRzd6dE15UklxdUp6VEpaTTN0cU0r?=
 =?utf-8?B?T0hzY1o3WDlYNDZ0Vy9wdGNRNTJLYU5MM2F5ejlTNGprNXVOeDFqM0g3QzdX?=
 =?utf-8?B?UnNZUnc3RzlMc2JOUkNJcWpDd2dYZndoUTc4ZldJdENJL0MvWHlZTGs0L2hp?=
 =?utf-8?B?ZHJnVFJTSEV0N1Q3K0E2YVRXRHRSWHMreVdtYVRETlJ0Nk5pdWpzOE8rcFBr?=
 =?utf-8?B?QmhVKzlGOFkvcDByMThueWh1ZVlMZUFlQkQ1RFNWMVd2K2t2NmdLZm1Vbk5x?=
 =?utf-8?B?UWQxbDJhVTROeERMU3hXQkEzcEwxa0d0WUNHbitkM2tucE5pQ2ljUWpXdHN1?=
 =?utf-8?B?UnhqNkRBcVY5TXhXNUx4YlNGWWVLOWFPa2xMaSt2S1VaYlRsaVpqZkI0c2ho?=
 =?utf-8?B?a0xpSTNvR1BPR0JaY0l0eE5xNHd2YWVsVklvb1JrNUk4TFZPZmhiK3VkWkh1?=
 =?utf-8?B?ZGxEMU1xU05xMlRzb1ZJa1JWenRDcmdRRCtvSEsvRGlZVFpSNTlDTVR6eDlU?=
 =?utf-8?B?S0lNbS91MktMYmxMZENqVk0zeWI2OWtBRE1abGJ6VmdIN052dXpJa2REcDEv?=
 =?utf-8?B?L0tkVExiZVpQWnNYVnFrTTc4aU9wZHMzTnFDNEF4MnUzNjJ1SnFrTFVCc3ZF?=
 =?utf-8?B?ekxuSDk4MTkxMk92WFZ1NXlaVk9KeHEwS3BaeStUc1JCUkJHbFJYbXAxTlBZ?=
 =?utf-8?B?ZTlTWnBYWm9FMk5KUFVuOHgxT2tiYjFnejBXRDVuK0VUblp4MU9OYjhSNUlm?=
 =?utf-8?B?NjJRNnhiZ21NWEFiOUhlVDhreG9PRXlzRXhaengzendZUDFSWVZFaG03V0V5?=
 =?utf-8?B?N2lRb1B0dEVOUkFjMlRUVWJBeUpua1Y1WmlaT1hEWmpacDN5L0NuUmRFVFpG?=
 =?utf-8?B?MkVWUzVtVmJYVzYvVHJJZlZwZnNlNFNMLyt5NXhqZktIZGpwK1lHK2M1TFBv?=
 =?utf-8?B?eFY5eC9ESUs5RzVKTEthQTg5Y3NxVVp0ODd3dC9oTHo4MjllUmFwMEkxdFVL?=
 =?utf-8?B?WmNUY1Y2aEpoOHgwSE4ycldDa0IrcGlYeEdPSGIzVUZNTEgvN3hCbDVjZ1hK?=
 =?utf-8?B?SitHNHNINkdNWDN4cmMwV0w5MU5DS0lJSW93eWw4di9HQ2FnY2ZPdUs3M3pp?=
 =?utf-8?B?OGh1SzJZclBhVWFoK3JJNFhuWGQ0MHdkSU5YYzBQVU9DYUtIRXdPU0dSRVpQ?=
 =?utf-8?B?Vk5nZmRPcm1vMHREYTBXdmw0SVBmRW1ZNmV5VnAvK1ZWRjdVdG5XMmQybkp4?=
 =?utf-8?Q?sCbe5jUFl6A97?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjMyR094Qm1sWXNyZm5rekMybkp0VEI0b2pUVWdhbktESkRzcng5bTQ3K0hF?=
 =?utf-8?B?SjFVbmM3UWFuTGx0a21RMEdjd2sxZHdBTlZWRWs5bHl4M0FHdE0zMlN6YUJU?=
 =?utf-8?B?Q0RNWlZycExnZDFhdWk2RkhwT3JpVkFVSmZNMThSak1jUUVSUHd0YlRraS95?=
 =?utf-8?B?SHhhWUh6YXR4WmN6MkJWLzBBMjR3bXlPQ3dyd3Q0RVhzSllZSXpQMHlXWm43?=
 =?utf-8?B?SlJBbjFkVHRvcVZUT0p2d1JvWEVNRG5IWFplSDNSTkdqaUNWOU9ERDE0d1NF?=
 =?utf-8?B?eG85dnVsbndqL2Z5eUpIZklBb2pFSFJoam9pczRUQkdqaW9JM2RDNHdRRHpn?=
 =?utf-8?B?MENCSlVmeXRrVHFpZ3U0MUkrV0E2L1Y3UWQ1RGFVWmNtRlZWOWhZNVZpR3or?=
 =?utf-8?B?dzZzMHZid2s1MEdjUTVJNUl2MmxIMXBVeFk1TTFRbk4zMXNHUFM3YTNYMUtL?=
 =?utf-8?B?SGZlSi9abVNCbk1RM1B6NUV5T3lDR2V0SWQ2NkRxeEhhdjdzT2crd0J5V1kr?=
 =?utf-8?B?UlkxR2VaOU1KVUVmS0lxYmR6NmZDcEhMVmdONTRmYzhuNjZ1d2hLNzZSYnFY?=
 =?utf-8?B?cVBkcFNuRnQ3aTZNTDh6WWkrVDgwdUFPc3hQSytKM2VTNkdoSE52UVZKd3U5?=
 =?utf-8?B?MGlHR2xvVDdkeFhyNFBnVk5WbnQxSDNveDZsNHNvWjl4VjErSjV5ZFcySnVt?=
 =?utf-8?B?WjZnMnphUzVFTmtwdExFTXVxRFlzWXBhcElYY2MyTmxBcmhHK3o5ekRNY293?=
 =?utf-8?B?Vm1qQjFvRmd3cnRJaU1zNUtvSG5XVi9IbGVwUVBHUXlQaTA1RWxhM3hpUWhh?=
 =?utf-8?B?bXBuRU9ZZ0RoTVI5R25JNXE1Q0dDaTBoM0dKWnFjODR1ZG1ZRVFlZmVEVEho?=
 =?utf-8?B?U1hGVU53ZGVaaUJHZlRuMjUybitXSUtqUlhGcHdTZXBLcXd6WTdTUTJ2MFA5?=
 =?utf-8?B?OTJMbGJvcmZ5Z1pycTloNEF5cnJoUlYxc2RXZU5ISHI4bkY0c2I2eVV3aWN5?=
 =?utf-8?B?MmtHd09MY2RENkkxcXEzUkZST3lsS2xtRzFTK0J2M3pJUjZXVUNua2VaZVdI?=
 =?utf-8?B?KzFHUCtVMDBBTjA2bTJHR2NRZSsvMFZ0NTB2VlkzZXNCeTcwVDJReHgrSnhI?=
 =?utf-8?B?cUxyK0lCYzJHU3BuTGV1T1JZa05oSWNTdlNPVHBhQVdIOVNyMGo5NVJ4RzlC?=
 =?utf-8?B?SUxiTFJwbVdncmNweGorbFhjQk9jOVBJdHZqMTBjSjA5S1U2RTlUSVhLcG5Q?=
 =?utf-8?B?YXd3N0JkZTl5N0draDVGMU5VMmFoeFZUR1QreFQxdUVEUjNyMDVhNEpScUtl?=
 =?utf-8?B?bWprRFREYmwxM3dVb2c4QXJkclY1R01sbWYrR0VydjhwODBBdVQwWHgyVFE5?=
 =?utf-8?B?bHh4S1RRbVVRcnEvV1BITldVSlZKNGVQRG9YeGlOVEM5eU11K2t0eTQzOU9K?=
 =?utf-8?B?eUUzNUp1ZElDaFM3UHkwSzAvS0Fyc1lkN2JHTENoSDhpWU5FYnpDSVEwdElh?=
 =?utf-8?B?dTM3NTRpS0hBc2crUWRqKzR6QUd4dDk4VktMNi9YVjlmQ1d6ZEpnZVlqRzZF?=
 =?utf-8?B?aDh2MHRRU213YU1IdU5aR3FnR1V5M3dqendGMUNKWUVIalVaSTFYblJsU1RO?=
 =?utf-8?B?VUVPWXg3Z0xhUUJpUktpRWE5TjQ1WUpqeDlHejhsYlhYVDdXRXZSditmRlBi?=
 =?utf-8?B?cmtIVlFJRlhWQ0FOWHpreHFqeFlRMk53WW05UVd6dzBtczVTbXZJSlQvR0x4?=
 =?utf-8?B?YkowenJwa3lKYlZ2NDBlWHNSKzBiVXVSbFpzWVZwRWxkbTB6N0ZFY2drbWxX?=
 =?utf-8?B?MFhKSzVEQnBZMzJib3ZuaCtCZ2JaRVVZQXU1bnpPc0l2M0Z0UDBUL2hsSnc5?=
 =?utf-8?B?NDE0WnVxR0daVVdZakIyaGtkV1pVcjAxOHZRUUhNSm5lNmVtSmY0Umd1TzRY?=
 =?utf-8?B?Y2srL2gyNnUyY0YvTUt1VEJEamU5dkVEN3JuTVBxaTFmcjJsakdwbmxTdkJx?=
 =?utf-8?B?MG01N0dIVzc1Nmc1V2hBWU9YN0R0emlSRkZSMERXc01IaTJlMWN0ZjB3R21q?=
 =?utf-8?B?WWl6d21XdEVYalBWV0N1MXdIWFFWL2E2WmlHaHQ4WkM5QVpnQ3NmTTZLQUw3?=
 =?utf-8?Q?2Zd6u+3DnsZ2eyAQwR5ve2r/P?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eefd17d3-acf7-42a0-285c-08dd391ef6ca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 06:52:11.1845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rH3qOl5dJ51PTZan18WDanAOZthBsTASmCBuB/0zAAz/Q7g1p6hCkcSx+KuqYdUYeeUFtO90PRXkjpEPhb7bHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6376
X-OriginatorOrg: intel.com

On 2025/1/20 13:58, Tian, Kevin wrote:
>> From: Yi Liu <yi.l.liu@intel.com>
>> Sent: Monday, January 20, 2025 11:09 AM
>>
>> -	ret = xa_insert(&group->pasid_array, pasid, xa_entry, GFP_KERNEL);
>> -	if (ret)
>> -		goto out_unlock;
>> +	curr = xa_store(&group->pasid_array, pasid, handle, GFP_KERNEL);
>> +	if (curr) {
>> +		__iommu_remove_group_pasid(group, pasid, domain);
>> +		ret = xa_err(curr);
>> +	}
>>
> 
> s/handle/xa_entry/

oops. will fix it.

> btw you may continue to use xa_insert() to save one line for xa_err()

got it.

-- 
Regards,
Yi Liu
