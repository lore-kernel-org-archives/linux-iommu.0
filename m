Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2234A1531C8
	for <iommu@lists.linux.dev>; Fri, 20 Dec 2024 06:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734676568; cv=fail; b=Qdi+V4OADs8DJ82cs5HHX5DJXpjBn7fGnBIZ2Mx99nyWPyO7CdqSsmsEFw1U5RNy/euGwFgiO93gi+WteHbbpPSk5iQxNv70KYDWbeFfd9NwvkPdxaQVRFZB7jaSF++PnZkiVytdBBqXGByVHvrhNdiewTTSTesI/5iMjy7U8F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734676568; c=relaxed/simple;
	bh=Lz9uCahmvA4Pxu90XIcAU02KhsnT1krH/Pa7MteWJmM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t0mmm3WRzPThz7EhW7vq6rkJX6yGML0+BYjWjOOjWTYcX8zck/BYkCeJeD9iM7Jb/DGdc9Xoz2fUh4OxD+F7hMrt4zYdTBRsSzk79JOrYvjbzU4PpvH9Mlq4zpBqshFzoW1EljMvHkLomHWTM4VJxealiwFYzP1plKZxI1tQT58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JeYRX+Aa; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JeYRX+Aa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734676564; x=1766212564;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lz9uCahmvA4Pxu90XIcAU02KhsnT1krH/Pa7MteWJmM=;
  b=JeYRX+AakDpI/7Fer3vz6OWn1oijt/TqOSCiBCx4T5Yt3J0iOw6j4q1P
   5gfQb/SCZO0dk4ZX9XzVIife7SBeeso7/ibnKGcP2/0SSb96NhZt5CBuM
   TTVbWxOJHaFFo4Dmvr92sd3Bgu5U0Rl466MViXorfn4rripxscPBjfCW2
   pX3tcSVq6nrEA9Ldb6/r3gscQOy3Ey/33ZO9CpSZQ/qkAmg1HpXDd82qE
   PN6jec/qA8Z0PHw973X4NdJyuLQSzQmt9thpjN5CvLT9WJ0CKl3osoySc
   A+5HaEEomNhlThmXAgoWw85UC9I3cwrLC8mPqG79OcibwtwIfboHG5tCh
   w==;
X-CSE-ConnectionGUID: ylA6cJQASky/U5kt8rWHZQ==
X-CSE-MsgGUID: hM1WogoTR1KVEJpYorwrmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="35365856"
X-IronPort-AV: E=Sophos;i="6.12,249,1728975600"; 
   d="scan'208";a="35365856"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 22:36:02 -0800
X-CSE-ConnectionGUID: 2I0sE3D9SJ2QiRL5FHBR3g==
X-CSE-MsgGUID: dE1nMESqRgaetS6W270vxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,249,1728975600"; 
   d="scan'208";a="98825172"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2024 22:36:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Dec 2024 22:35:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 19 Dec 2024 22:35:59 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 19 Dec 2024 22:35:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2iu5inav+M82uyNzh21QB47Io5Y9AqHF5PmAMBW/1Q9M2k3KyVgzLfKc4D19CJ7mwRGILZ2effHWWJT0tAXTGy+difiVTC0zr1c5L1SAkZp6n94RnnfELnbY7hj5/1nKy+3/CRNN3NYovv31KMwo1NJcHqDWbsKooZ3yZosQAdyMkA1ZdPd1TVfYF/cTetTjWaRc11Lq9QLfhnMyOAmQD/tJDt60xkkUCdeIjsTlTdP4GgN7zQLeCyXHomdq107IRkLGDNh2VMRJFzFwzXMeBNeCSmBREqE4N8aIN8w+IQdIGoX6gNz87s1fTfSrkqZvHXSHZZ3T416H7q92sRirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCgAyQrQE383dZl7Py8Wa7qyFmKWNnnMSnxPtzTwCQ4=;
 b=F1bKQJsctGCQ7V4C6gsLF40cfG/OWcHdfMsiIaYeNge29vlNOVJTftKYx4FVEnBLQjTzaRIiWermuk2zMnR7vCeMON+qX8ukM0O/fRFEahVqyj8T1lY7YIDGJaaT1kj+OHC5g6gmO7H/7TK4zAP1JYd9CgxqZ1FlRvDz7bewzzZRKRrP9h2m0oVk67bkkTxczwIEFhcPKSHfItlv3/ceE5L2RTwQRCJfAy0yYAW2MQ+KK3GevUXVMhtPNqlQSZFTV8OlwbUnVRmpfnCr6f3aRXr6HRJiPbJ98d6WYPRBIE6TY2LJTO/liXQKvMUn4QNp3Gr4oZqmFDVhmZb7fzoreQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ2PR11MB8586.namprd11.prod.outlook.com (2603:10b6:a03:56e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 06:35:39 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%5]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 06:35:39 +0000
Message-ID: <02e60436-e93d-4452-9446-b0fc6e4c4192@intel.com>
Date: Fri, 20 Dec 2024 14:40:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/14] iommufd: Always pass iommu_attach_handle to
 iommu core
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<chao.p.peng@linux.intel.com>, <iommu@lists.linux.dev>,
	<vasant.hegde@amd.com>, <will@kernel.org>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-5-yi.l.liu@intel.com> <Z2T0K5BXSCVgxwkA@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z2T0K5BXSCVgxwkA@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ2PR11MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: 87009aa9-9d37-4f0e-9ccf-08dd20c084cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVVFN2w2U0Nyb1BOaFNTaHUvU1E5UW1TckhJSmdnSG42MTk0Qm1PNUx5aVZZ?=
 =?utf-8?B?ckVDdjVIUjlZZFBSdUt4V1JFWkllMTBKK2Jua3V6bEwvM0NWSXhQZkR6SzR2?=
 =?utf-8?B?T0RrU1IweWEvV3FsTzgwYmRoOExnbUhrQVR2Sk5ycE1LMDJCUzNpZEpxZ2ZG?=
 =?utf-8?B?a2ZldGc2SzMyTVBNeTZhWlBOTzlRSlAxZTVBaHUyeDdvY0RBVGFPZktDVWdT?=
 =?utf-8?B?N1ZFUnVxc3lBZjV1R1MxWDdEZ1laQi9aQlFGR0RUTi9MQ2ZBOTJCbUV1Y1Nw?=
 =?utf-8?B?ZTdzMk95ampzdlBUeFZKdE05M3RkQmtWNng4NlVJU3NTSmhYL1JLeUpudFZ0?=
 =?utf-8?B?SVZlMGRidzI5TmhZWWx6Y25ueHhqUDF2cWFzM0lyWFB2OFhGZXV5ZmlSRGxl?=
 =?utf-8?B?bE9JVExtQS9QMTE2bHJNL0cvQmxuYi9MZlpBc0RoWk1ScFF1Mk9GU3ZaY2xJ?=
 =?utf-8?B?VFEvc29OSzlOVUxsdklieUF6TG4wS3QxekhvRkFwRThHViszTDBaVTFrMEtp?=
 =?utf-8?B?aklGWnZGcVlGTmtKTWtJUnIzT1dmSWZ3dGN1VVNXOFZxaXJ6KzdIdG9QbVFs?=
 =?utf-8?B?cGxMbU9Db0w2aURhZ2Y0akJyYm1lTVNsLzd5NnNkWnBsSXA1TkZFUEc2S2FY?=
 =?utf-8?B?SVV2dDhUZXpPMUpBTkVBbWgvb0hQZ05YeWwreUNGQ2M0NERTYUNvQWVHTkhI?=
 =?utf-8?B?SHFEVXpTcUVtN3FhQjBIUnkydC82WVhIUE40N2pWVEtBNnZuVUU1SVh5ZVZi?=
 =?utf-8?B?RUMwL3h5NlExQVpWek9nOStrSVJjNEJKeXhJN0hPYTd3a3orc1pPclJUS00r?=
 =?utf-8?B?YmFKUjI5Ly9lSUYzMS9LeXF1YjEydkFUaGducy9IQkZHNFh2V2dnZUFrc2pn?=
 =?utf-8?B?aGp4VFVvRGlheFE3VXo1SzlJUnpVdUhGcGwyR3hMeVpVZlRlY1VHMjEwZ0py?=
 =?utf-8?B?K0pRN24ySFc4K2VlRmlQRSt0RUU0MUFQVGIzT2p5aHpXN1RXblgwSXE3MTFV?=
 =?utf-8?B?WXpNSDBCcXdGRzB0OE9zcWpkc04zMmdlTDhtVExOLzY0dVN4M3JvOURtdDBT?=
 =?utf-8?B?dWxlbmZFNytLMlhTQUREdm0xa2dyWFIwdEtkM1JPSWhsRG5vZiswWWttNG1P?=
 =?utf-8?B?dFhKTzNIUUNKL2NtVVowNkJ1L3BUQnp3eS9pYndxL3M0dGpHSWdXSCs3SjdQ?=
 =?utf-8?B?c0wzUmdrR3pERzQ2MmFZNlZERzRpRjdabmwxS1A0UGhoUFZybXd6WXNKczBE?=
 =?utf-8?B?QTRaYjNPYTZEeGtXL1gxVTUxNWN6aVJaWDdvTjNWSE5XdHBpWHZlV0lNZTVZ?=
 =?utf-8?B?S0xQQ1dUeDIyeXBOQkc3MVg5dnpydk93bEFRUEtlZGs5SCtWbzFHRDIrVUdO?=
 =?utf-8?B?OCs4VW8zdEgwUlNhRGV1ZjU5K1h4aFBGMjN0clV0MDBZVDBNSDdZZlBIcThX?=
 =?utf-8?B?VUIwY2hoRXEvNDJUdERkd0dCY3B2dFB3Y0FKU0dyK1MwaVZJWkRFenhlWmlP?=
 =?utf-8?B?TlNsbmlrNzVwUzVYQ2lkVStMa01rUDhNK09vdWdHMndERXUrL1dDRDhvVjR0?=
 =?utf-8?B?bDhJZnBsdU9YNjZhWmpzM3lEUU45YXM5S0QyUmQ5OVE5MmJ0K3NGY2hFUXlB?=
 =?utf-8?B?STZOOXdNVmdrUlVDWHh0a3FMWjQwVDJyajI2WkU5TGtZSDI2Mzk1dDhRdXpN?=
 =?utf-8?B?dzhOMStjK1g4Q2d4bWFJOWVaVjFVeGpScFpRNnIvZDhxbk5qREZ6USt2ZElp?=
 =?utf-8?B?R2pPVExtWW5LOVBKY3I5QUtUNEIrM1ByZGVJOVlxQTltSXQyazRITno2SlAy?=
 =?utf-8?B?ejdtZTM1ZU42TVJqTTlyRWtpRmEwZGd4eW9BWkdnM3c5cEVpdloxeEI1VFlk?=
 =?utf-8?Q?RJpdZG/rYaCxk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFYxbGRkNGsvQTZ1WThyOWkvVVZqU0I1R3FmcXZiUzdwTm5kcThQY3ZlaHhL?=
 =?utf-8?B?MitLdndYYXlIeDcxWkRTd3BGeGdKci85KzA4ZWdtU0JSYTNwVGo2WmhtMGpZ?=
 =?utf-8?B?WW1IMmdFMDZWbkJmWHVPTlY3ekRTMmtwZHA2MEtQZjhjQ2x4djZmZG03ZGRG?=
 =?utf-8?B?V3hzTzF4R3VrSXA1NmNkNWFGSTI5eTVZaTJzUW1uWjNlb01PL2dELzJkWE96?=
 =?utf-8?B?dUNLZ0tYMkR1VnpMZXNjWG1oUk5DcDZPS3NTOUJCN2pFQWxxemdvdENKcGpV?=
 =?utf-8?B?OGxrdlczeGswck5XYnkwRE54Njdhc1NKaGEyWS9GWVIwTFdqdHNaTWhXYjQ2?=
 =?utf-8?B?TGxUcUFYd3pxemlFU2Z4Q3JDSjFpU1NwSVFkMHRlMU1GQlhSUEM1Wm5Vanlr?=
 =?utf-8?B?anBoRHVjeEtrRG9oTW8weEkrWDI5UmJLZFpTa1NJTlRueWJVVnM5cXZTTnl1?=
 =?utf-8?B?UTRSRjZSaGVPN3pITFdjR0ZtK1pnWlJpT05xSkY1b1d0YzFsbWJCdTV0aUR5?=
 =?utf-8?B?ekZXMUNNeWJUVExEeGFZekNYSGZmTUpoeFJUZFUwWEpGZ2VERkdoWDdUZDZF?=
 =?utf-8?B?b0Q1aC8wUExkZ2tueFR1YjR2Z3hsNHR0RDZDMXZ2T3lja0x5SFE3Q2N5QTR6?=
 =?utf-8?B?NnUxM2ZRNHpmaFFCZXAzMXNGS3dXZnArNW4zT1JvYXJzQ0RVQU4wY0xNa2ZE?=
 =?utf-8?B?UzVSK2dmOHFSb3dQYlduajZldWhyeFcwM09PVE5iQS9DdHJJSWEwRUg1c3F2?=
 =?utf-8?B?TjIzRHRrWUN0dGI3VEp5anRPV0o3SGo0RTF5WWVkVXJGSWhTcnprWU8xdmVH?=
 =?utf-8?B?cHJKT1AyNFNKcHJJZi82U2d4WXkzTTFIcE1iZE9SRHZDMnFGVWNwNFI2ZlF4?=
 =?utf-8?B?K0lSOU5aT3F0SHhOQUhKZUdoa1pwRDJpaldKRGJadXN0N2FZUnhpYmpMRzVF?=
 =?utf-8?B?ZjdNM2ZCZlRiOVNZK25JRHhFR0wrMXJ1Tk4wWUZiU3FRM1Fyd3R1R2svVy84?=
 =?utf-8?B?bVBxWGphcnkzU1FEL1dXRE01dG1OZFlDRzBiMUFlQW0rVUJnN2ZEVmVsVGNQ?=
 =?utf-8?B?aitXZjJuQlVUNWY0OWFaYXhXdlNjM1VUNnJ1K2J6SEZFeHp4c1FXdE5HbVN1?=
 =?utf-8?B?RXMxM0diOExyaXZJbDhFcW54dDdmdDZydXY0Tkw1VjI0cGtCNjF3RGdNcTFk?=
 =?utf-8?B?NUJCbDErdXdDNlNnSUtVaGZGb21Sd2RMYXpSUzU5RkhpZVFweVVoMm5UL05l?=
 =?utf-8?B?bGdwYVNidGJaUnk4YXpNQmYwZnZaMHdlaGNnOHV2L0tiR2Z4VjVHWDZjbFI2?=
 =?utf-8?B?R0YvRVc3clBxamJ2QU44R0NEOEYwOEY4dnhVRGE5ZjZ0b1F1K04xUFJGV3Uv?=
 =?utf-8?B?ZDdJWkk1S0dBeHl4ZWZwS0RDVGN2dHBXaUM1QTJnM3B5VzFFQmp3MSs3UjJC?=
 =?utf-8?B?Q1RWUzZwTWpEOVc3MkNFNXc5ajlVV0pHVHJaWFZKNTNQTzRpNFRaUmh3MFBl?=
 =?utf-8?B?TVZpVUJMLzRiYTQ5UFhSZFdJUEZLRkhnckdFNldiUTY4K09nMXhoUnZ2ZnB1?=
 =?utf-8?B?ZFF6dnNjM1cvSE1HL3VPZ3BqcTNOSnpaV3VuOUw3MDZpQkkzeUJlR21BOHh1?=
 =?utf-8?B?bHFvVzJmRkkzOGRBakZKYU9OTklGSk9LUmFSK0RSa3FTaHBkUmdoM1NhcWdW?=
 =?utf-8?B?NUxRNXVCZENWcWRiVWRBSjduUVVXdDhjUm9zd0pHelJIQ2NpQ05kVEpsMlJQ?=
 =?utf-8?B?U2ZoWFIveFA2Nkl1Vi9IR3pzQyttd05YdFZkbXJudXBpZUMram16TzhqVzM3?=
 =?utf-8?B?R2pIUnIrREk5bTljM3F2OXpEZDFTMDk5dGNVbnNaQXMrV3Brc3Jva2tHSWdP?=
 =?utf-8?B?N3NlQjFISEhUSHNsVGd4MWthb1JIUlFmbnNHaG1DTkxaeDVsZkQwci9tVU15?=
 =?utf-8?B?UW8yK1pUWXI5MkFjLzQ0VWJqVnd6SlU1VVczRWx0QnZxOGlXVVhqREh2WWlT?=
 =?utf-8?B?eVJweklnK1A2Uk1kcEE5T2Q1b04rQjUxc3BCL2dHbHZ3aFBlSllJK3NZeW53?=
 =?utf-8?B?cnJNN0sxRWpKQlB6WmcrLzZpU3Y0U2g5Tll2QWRnQy93SHdYYWx2ai9NQ211?=
 =?utf-8?Q?dammRqQjZjNBZ8XI7JULeY7ed?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87009aa9-9d37-4f0e-9ccf-08dd20c084cd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 06:35:39.3670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRPjDSSBgfn0uAdbvIy38v9Fcsr7FRbBleH+c4dWBOsvo/n6V74RU1NtjV26aU9FWRl7BAvW5DGlg9ZJ0eQ0Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8586
X-OriginatorOrg: intel.com

On 2024/12/20 12:35, Nicolin Chen wrote:
> Hi Yi,
> 
> On Thu, Dec 19, 2024 at 05:27:36AM -0800, Yi Liu wrote:
>> The iommu_attach_handle is optional in the RID attach/replace API and the
>> PASID attach APIs. But it is a mandatory argument for the PASID replace API.
>> Without it, the PASID replace path cannot get the old domain. Hence, the
>> PASID path (attach/replace) requires the attach handle. As iommufd is the
>> major user of the RID attach/replace with iommu_attach_handle, this also
>> makes the iommufd always pass the attach handle for the RID path as well.
>> This keeps the RID and PASID path much aligned.
> 
>> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
>> index d5c83f10d83e..6cf9c1f10e85 100644
>> --- a/drivers/iommu/iommufd/iommufd_private.h
>> +++ b/drivers/iommu/iommufd/iommufd_private.h
>> @@ -493,28 +493,42 @@ static inline int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
>>   	if (hwpt->fault)
>>   		return iommufd_fault_domain_attach_dev(hwpt, idev);
>>   
>> -	return iommu_attach_group(hwpt->domain, idev->igroup->group);
>> +	return iommufd_dev_attach_handle(hwpt, idev);
>>   }
>>   
>>   static inline void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
>>   					      struct iommufd_device *idev)
>>   {
>> +	struct iommufd_attach_handle *handle;
>> +
>>   	if (hwpt->fault) {
>>   		iommufd_fault_domain_detach_dev(hwpt, idev);
>>   		return;
>>   	}
>>   
>> -	iommu_detach_group(hwpt->domain, idev->igroup->group);
>> +	handle = iommufd_device_get_attach_handle(idev);
>> +	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
>> +	kfree(handle);
>>   }
>>   
>>   static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
>>   					      struct iommufd_hw_pagetable *hwpt,
>>   					      struct iommufd_hw_pagetable *old)
>>   {
>> +	struct iommufd_attach_handle *curr;
>> +	int ret;
>> +
>>   	if (old->fault || hwpt->fault)
>>   		return iommufd_fault_domain_replace_dev(idev, hwpt, old);
>>   
>> -	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
>> +	curr = iommufd_device_get_attach_handle(idev);
>> +
>> +	ret = iommufd_dev_replace_handle(idev, hwpt, old);
>> +	if (ret)
>> +		return ret;
> 
> These inline functions feel heavier after this rework..
> 
> I actually have the same patch for a different reason, yet haven't
> sent yet:
> https://github.com/nicolinc/iommufd/commits/wip/iommufd_msi_p1-v1
>     iommu: Turn fault_data to iommufd private pointer
>   =>iommufd: Make attach_handle generic
> 
> I think we can align with each other on these functions with one
> common patch: my series requires the fault_data and attach_handle
> are common to all HWPTs, v.s. exclusive to an hwpt->fault.

yeah, I'm ok to move the helpers to be in device.c to avoid inline.
I've three remark on your patch [1]. I'm now also considering to do
the work in one patch, hence it might be better for review w.r.t the
comment from Baolu [2].

[1] 
https://github.com/nicolinc/iommufd/commit/26f9a2a4a5e28574295ecfe057e949dcc9a58c7e#diff-c251419ce7f13e1e22e8fe08864a50d8541d6c9addaee27f806bf9786b4a4886R374
[2] 
https://lore.kernel.org/linux-iommu/a2f363e7-88e4-46ef-8755-8a5e0cc47ecc@linux.intel.com/

-- 
Regards,
Yi Liu
