Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3CC194A44
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 04:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740629646; cv=fail; b=McI7gbFwxNYIHQ0oC9z1iu+Q7N0MSEc8sZ7JAAuLtKdkDA1/iT8x1/bySa5tyxE8/tGko4vc2noFprQVGpDAfBBLZ0acl6HW+HUWD6eSjWojEm5fn6BYUhmQaqtIN1gt/Aty4gQ8kkAGiYHE511eolraAiwhiuU6tBiMXSdrmUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740629646; c=relaxed/simple;
	bh=x3IsjviJMY4a8rv/s5GUmRhOS1AnkJssuqqsrAyJ91k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=URTNibmvqef4u36GANiiClAjMPZoRmWp19afEbE4wiEQCaSrtOeNdC2pEXS1yVQX8K0ekhbTDnYwZdTUV4tFwfAXr8yidYqS2SnBntSi3b3R9R0VIxZ3eExFoRHmEwyA3AcATEaLQbitxjRBJdpLXXZDYAv5yQ1DhDcwMWE2uXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ib9z/My5; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ib9z/My5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740629645; x=1772165645;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x3IsjviJMY4a8rv/s5GUmRhOS1AnkJssuqqsrAyJ91k=;
  b=ib9z/My5pyLHu2W7UrCCHSPG8RruU4t3gvol6SnGfMG+32oRfgaB3VHp
   pm9J5cQlOQ1DHtyci5T0A0AYbS54EVxsFEBI+tZ+4NGLTdqf7UkFvHMqf
   35Up9ONYiAA0crXwEFG1amKiQR7xmQd4hKk8F0kbvrrmcgo3v2P9f2E1l
   PwJIcbK1YGNX1TNtdeXxif4eVE9dkfoh/OL23/PSzF4nbZ8XzV8wts/aL
   GGZbmjltm6f9DlSdPOsctwi5RmOq6RJ/Ywrk6y8uKFbAFqK9gMgnjKHeh
   Joh9ITMGah02LfhAHGNxFHSxGZny5lZ2JurOTRWBJnKWmZ+QMJcK0pyq3
   Q==;
X-CSE-ConnectionGUID: fyRi2DqvRN2aRRdgLehfiw==
X-CSE-MsgGUID: A+cXnQVGSeuWOFQkaZJqtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41633285"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41633285"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 20:14:04 -0800
X-CSE-ConnectionGUID: NgJq6/6+Q0G6d4zxLDidrA==
X-CSE-MsgGUID: ijaYeanVS9Ki1zUZWbh8uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154098688"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 20:14:05 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Feb 2025 20:14:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Feb 2025 20:14:03 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 20:14:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7Lg2SjLGjm2gyoQWredSojp9bQdDjaJAo+sYqXZojZBvFAMYNRRMm/pe+tWX9MpFrkmE7nsCM8Y4uJNFKyOlWvct22nVznG90iJCAv6Y1cv/6yN/Ep7JJLMgi2HeEUH4HnKLwdpb7+PHhJ5dzp/MYPgHRWSEktJRkZJsV3vrPUwFmTRMhtava/BxmiwHWz3suJOnZlnysW6QcKubOdIUtz3L2w0eTnQ8Q056ac6LbLTQU4/rWrcQ/VtGGPq+yyUOAbQ8faUGy3qLuq8v9zCIQaZAjRAcHQOesBy9deCBl3qGk6O3uANlzCn3DqkYqeMDyaChh3e+GDnjUAUMfEd/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfz565cRFaWb8nWJiBoaAtpywPwP7AvNXmpRSy8iCj8=;
 b=N0JZkpPi/IOaS7JPy4T8dQm0dh6h23EE1ypfW4IH4sPpRska9HpH6Dys5v7f0z7cdnDTV90jQ/8ohjNcQ4eLnT3BMrwN5UFTPNn1MKk63ptueT5nbzgIZUzcPLSZtusZ/FHCgi4SbMFPE9Lmg5CGyakirU9GvJOrbuwc7isOcGzJUQ/7D8oyLl+Ad+WmU6sgUEa74BgV/8QyCcu26kpMyRFB9i2S94cW/S4bHQdkQrywfHJXDjJSXJd1oLSslOzEzFsW0kTKxDe5l/xg7/cOakQzablxwrnDjmG1siNtIrhEbWX7C3GVMxNJ9PZ98bvHwAZuOGd5VuNGnCh9VDDdaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB4813.namprd11.prod.outlook.com (2603:10b6:a03:2df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Thu, 27 Feb
 2025 04:14:01 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 04:14:01 +0000
Message-ID: <124caf04-629c-4b5c-847f-1e965ea5721a@intel.com>
Date: Thu, 27 Feb 2025 12:19:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/12] iommufd: Support pasid attach/replace
To: Baolu Lu <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jgg@nvidia.com>
CC: <joro@8bytes.org>, <iommu@lists.linux.dev>, <nicolinc@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-7-yi.l.liu@intel.com>
 <8839ae2b-014d-40bd-93ee-89a5791f95ce@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <8839ae2b-014d-40bd-93ee-89a5791f95ce@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB4813:EE_
X-MS-Office365-Filtering-Correlation-Id: 77962ddf-6a19-488d-ff84-08dd56e529bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czVOUm1OTEZycVVVT0FrQlowR1Y1UXZnMTV5ak9EU1BWbEF3NEhYbU9ta2RD?=
 =?utf-8?B?dkM0a1c1dUYreHpVU0JnQ1lVUjlGdnZmbDRBblB2N3U5anZXc1IrblVMZlBj?=
 =?utf-8?B?NGpCWDFEY0E5aWJzM3BIWnJabVp0dlY2S1JhR1BxTnhPMEc5RGkvRUVmTjRL?=
 =?utf-8?B?WEhiNW1aZkZsNDdEQi9DdHJWSjZnb1pYOGlhKytqMUwzakhtbHUwOHZ3ZjEy?=
 =?utf-8?B?SjVheGZKK1R2OTZtTWNsanBzRTNSbXk1TnhLNmVLaWx2aDQ2Q1JIRlZUK3RQ?=
 =?utf-8?B?RHFFYzNrQzRMK2cyT3RxaGJpUENwVWZOTWR3RWZPcnhzTGYzUWwvWGJNVUox?=
 =?utf-8?B?bFYxYlUyRXdleWkvVjZrOVM0V1NRcEpGNlh1eW1LOHVKQlM3WWJWSkNhZkts?=
 =?utf-8?B?dTc2SXRYT2tVbnF6S2Z2eUxydnRCa3h3MjkwVzR0dkFqNzhja0hBd3lpbXVI?=
 =?utf-8?B?MkI0MUMrL3dVMDdVdXJHYUh1ZWh5Ukc5RVlIUDZ4TG5OWm4zYUNhK2d3bjRa?=
 =?utf-8?B?U3Q5SlpsS1Z1M0M3bUVYelZuRTBZL3E1b0h4ekJZYlNmU0NOY3cwSGFrSXZP?=
 =?utf-8?B?U2VUaWpkR0hNdUl4SUNzL1F6czlLYjY1L2hObTYxaU94SlFHZXBXSTh0d1hr?=
 =?utf-8?B?OU1mSWEzSDV0UjZkVVozRCt6MVJ0YldDM0IwVUNxQVdJRFM0SEROUTNFU1R4?=
 =?utf-8?B?cEJUVEJUTCtiTmpFa0JFZlFkQ1dtYlpla0tKdHVqU1R3R1l1N1Fta1ZvL3Yw?=
 =?utf-8?B?aVZEbFdaL2tiUmJpMmlUZkZ4eElJNlVaYVU0OEdoL2hES244TGovcStGZlE0?=
 =?utf-8?B?UUszR0x1UFd1cnNoTEdjSTB3b1M2a2lGNVI5MFkxNTF5VFh6Uk1DVTQycVFn?=
 =?utf-8?B?c3FHVzlTb1dLeUlCK3A0aEZ3TXBRR1lsd215SjFPVGNzYUNNZWtpODNGUzVZ?=
 =?utf-8?B?Ujlwclc2MzZhaVg5dlNGZXNqbC96ekI5VmdaNTlvMmZ2Mks2VUhXOGo4d0E5?=
 =?utf-8?B?dXlQSVRpUjdQUkE3TkZEK3VMSnFFWjJhRy9Id1BNTjN3Q0NpU1BXcXBnM1pj?=
 =?utf-8?B?Qm4vSHdaQzlQR1A4RGFsRlh3RjduZHNpclQ4S1FvdnlJTnRBcnF3MkM3T2ZE?=
 =?utf-8?B?cTRMYTlrY011ZGpqM1g1SXJXcVNYRld0TDY0VGVaZm1oa2xWV2g1NGhaVTNX?=
 =?utf-8?B?aEVSNjdkaDQ2ZGhQcUJ6YUFoSzZlY1F4MmkxM0dGU2lhZzh6Q2JtODE5bCtI?=
 =?utf-8?B?MFBnVjdiUnBjVkw0MDVIQ2R3WnBkZU9WYnhqeDA3LzhQMTh4Zm9wb2NIa045?=
 =?utf-8?B?QmZpWkYxR3NYc2E3ZGlTek04UTlqMjAxdGpDZkFvdzNtNmUzc2FqckVsY0M5?=
 =?utf-8?B?bkFIUG0xRHF1VWZOUEpZRDhlR29WR05LbGRLK2JhVVBaZkdpRXNGQ09PL0g2?=
 =?utf-8?B?SjVyaUpnVzRqbW1CUU1yUUt2eW9RSWgzYjZzV2VyckRVb0dUcTVqdUhMYWMw?=
 =?utf-8?B?b2RQa2FRUTdXYjlMMmNOaDVaOEVidFgrdlpCdkhWbXM0NHM0VGlnUW1Ub21I?=
 =?utf-8?B?KzNJdW9WMmlvQ3VTenE5VFNJM1RzTHg1MkxZRHpnbFROK3hSMGp3VHNMMWhN?=
 =?utf-8?B?UE0xYkJaMFNCQUpwZ3hIdFpRRXltWnJCNUxWVVdiM2FLOVVlOWl2K1FDbDdN?=
 =?utf-8?B?dklVUjVqclhrYVUwUEszQlA1RDc0OFRod2F4N0ZXdkpuU3RVdk0vcEFHWHV6?=
 =?utf-8?B?VldUZ1V4KytjbVJLNVYrOFZZc0c1dElVL1RUNEYyNy9IcjQzckc0VTk2Tm9X?=
 =?utf-8?B?ME44RHNxckdOanJWVE9wYTJ2eUxSeElLV1JFUG83Umc3T25oNTlLRUo2RGZv?=
 =?utf-8?Q?RRMC/69A5WSk9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG5WVklaUGJqTzU5OWZEWE00QWJIa2dSeWlRdldxek9PTmgzd3RKMTJFeWlU?=
 =?utf-8?B?dHF4TmJMMjgxUHFRUXVpckFPVGx2RW04UzcyU2c5MWdHY3Y4b0Ewc2dnOW15?=
 =?utf-8?B?M05XZEpuY3JJRE4yN1JrOFR2VHAvZzRaM2RNb3Y2K3BQQW9LS1BkWGtjWkhY?=
 =?utf-8?B?MGhxd3pHNXFxYkttWEZNUzRkVmVSSDBaN2YzaStnd1FoaWFTeHFmWTliTWF6?=
 =?utf-8?B?N1BtNEdBVDlpbEZJUGNrQ2YycHZ4Q3JrSDBTNEtEUkUxUDFQOEVIT3NjNXdL?=
 =?utf-8?B?bFBJMTlaQUs1eGlJU1ByaGM5YzNTZTdCa3ZnV0dNUW1NcXFFaERXZ0dkT2t1?=
 =?utf-8?B?VmNIak5iVFNIWTFFV1NzdU9TMytSUCtvVFNvbE9RcVNNcmFnYm1uQi8yZElq?=
 =?utf-8?B?VG9zaWZNRFVLV0k4Rms4Q1dHTld0ajBRRWppc1hKb1BvcWd2aFZXYkdKa2lQ?=
 =?utf-8?B?aFdCa2RkbndEYjNaaHlvQnJ1dkptb2IyanpwbmRHWVovd3k3SlNGR2x0NXlF?=
 =?utf-8?B?SXYwcFlFTXJYanNDK21pUldVU2t5eHE3ci9YTEN2bFVqVnZoYzMrUWVFdzh1?=
 =?utf-8?B?bm82ZGRSVEtnQ041dTNvVVFPaVE2M0xoY0c5QUlOWVpTcFFucGdYQ2dQbytZ?=
 =?utf-8?B?UHpCY2wzWmJNa0ZqQWpBNFdXU2o0WUxVUFY4djY2TVN0RmtXNXJSL2RLUDFi?=
 =?utf-8?B?YVB4eGFwTy9oQm5nQmxTWFNQeEdLa1NzSEJISDh2TC9lUUtrRGpHMDd5dkFu?=
 =?utf-8?B?YVBMUTNKN253NVFQRGhYNTVzdkRNSkJUSnlTeEVkN09MSlRRRzV6NlI5dWtG?=
 =?utf-8?B?WllKRmo2Y0hab1J2RWo2M0hTU3lrNXYrd1B5cEd3ZmtOSTVhcnBPL2F6YWJo?=
 =?utf-8?B?dVdDZFk0T1ZiaSt1VlVZdWdvbE5udUZOeTF0WHhBcnZ6d2pWbEc0MFNxekxL?=
 =?utf-8?B?U0lsM2FVcVRSRSt4UFdtTzBlR3F5YUdZZlpZK3RZYmVzdkFSbVlVZHhWSEhP?=
 =?utf-8?B?cVEvQ0x2TW5ZS0x1akg3TFppSm00akxVRE1JWGljcTRKRmFtQ1JSSVU4dmd4?=
 =?utf-8?B?RUR0RDBwdEhnQW0wRlFpTVhuSjJ2bVZtVWtsdlZ4bTN3TnpuQmJjZUFabjRh?=
 =?utf-8?B?aFdudEhQaGVYMTh3RnN5N1dKQU56S3FuY2JTY1dUakJMbXJhdHp2VVljZzIw?=
 =?utf-8?B?NDRsdWRCamhzdy9OK0RnQVRRZFJWeWFwLzh3MlVoNDEwUmVYcEJEUE92SGNS?=
 =?utf-8?B?eFdCOVFLdnlBSDJCTjFUNlRveVBsbzVMNjRqR3RVOFB1QndYSlg5ZVgwaDVV?=
 =?utf-8?B?bU4zQ2o0QjlSbk5neUdlNVNJbVV4U29yemZVR2QzSHBwSzNyOUFBWTZ6eENN?=
 =?utf-8?B?eDlSWHMxSllUWmFuV2hVemRoWjR0TmNrRnhFYmpJeDVmZno5OW1BcG5yTCtK?=
 =?utf-8?B?Mkc2Mlp0NWZ1SGZJbUhzemJIN2NwN1BtcjBobFpna0RpbW1MbEJwbGUwQ1ov?=
 =?utf-8?B?V1A2V21YMVRxN2R5UXpKVHFuMU83a1FJdEhqUDJlb0U1Vk1SWWpyN0oxTW00?=
 =?utf-8?B?SG1EckswaTJjRHFiam1hd2NpWjVLV3gwdXk3RW5sM1hZY015MEZmWkF1cTVt?=
 =?utf-8?B?VHNzOFgrUFBrUVlZVzNTQTdXRlBlN3N3RHlQM1lmY0xOZXp6d0dWbXFpMVp5?=
 =?utf-8?B?dS8za1FMWW5TNDJUVFZ6andzN2FrWmlZZzdxd2xIdXJsWFU1U2ROclhoZHdV?=
 =?utf-8?B?MDRsT0U0YUtQdlMwakU0bDVYQ05uN1JzaldPUi9MbjBJR1NNRlZiaVRJK0dH?=
 =?utf-8?B?WWlLbVhNZ3lyWWhUQkFrN2tYbVllb1pYb1NvRUZCREQrTXJyck9tWXdqQVE4?=
 =?utf-8?B?bEdoZXNXQkhEelBDTXlEZzBJSGJTRVMxVS9tMUtOMVgzTDQ2NTM1Y0YvV05P?=
 =?utf-8?B?L1NLdjJCTDMyYzVLU1dCM1JXS2FGKzdXNy90and5MmErVk41S3FPbUx1Tlg0?=
 =?utf-8?B?cW56UlgxZzA2bWg3ZEVHdFFlU2wySmhhYTFYUTdERUwvY1N3Yko2eHhSbTVu?=
 =?utf-8?B?c1JWeVVZcmU1a3Vob1VPck4vOURBbGNTWG9HUWRDVDJvLzZMTkQ0RlBEUFN0?=
 =?utf-8?Q?5zJXTl/Hg33faPk8KO907zTWM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77962ddf-6a19-488d-ff84-08dd56e529bb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 04:14:00.9521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwxuVdduNttVXpVkiBB6J3FTm3Iwmy98B6ELe9t9qpqashOdgnxgbSVkppIKyKlf5BK9qa0G6YHVWoDgLY4h5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4813
X-OriginatorOrg: intel.com

On 2025/2/27 11:27, Baolu Lu wrote:
> On 2/26/25 19:40, Yi Liu wrote:
>> This introduces three APIs for device drivers to manage pasid attach/
>> replace/detach.
>>
>>      int iommufd_device_pasid_attach(struct iommufd_device *idev,
>>                     ioasid_t pasid, u32 *pt_id);
>>      int iommufd_device_pasid_replace(struct iommufd_device *idev,
>>                      ioasid_t pasid, u32 *pt_id);
>>      void iommufd_device_pasid_detach(struct iommufd_device *idev,
>>                      ioasid_t pasid);
>>
>> The pasid operations share underlying attach/replace/detach infrastructure
>> with the device operations, but still have some different implications:
>>
>>   - no reserved region per pasid otherwise SVA architecture is already
>>     broken (CPU address space doesn't count device reserved regions);
>>
>>   - accordingly no sw_msi trick;
>>
>> Cache coherency enforcement is still applied to pasid operations since
>> it is about memory accesses post page table walking (no matter the walk
>> is per RID or per PASID).
>>
>> Since the attach is per PASID, this introduces a pasid_hwpts xarray to
>> track the per-pasid attach data.
> 
> I feel that this is somewhat redundant with the pasid xarray in
> iommu_group. If iommu_replace_device_pasid_handle() were modified to
> include the old domain that was assigned to the PASID, the following
> patch would be unnecessary?
> 
> https://lore.kernel.org/linux-iommu/20250226011849.5102-4-yi.l.liu@intel.com/

yes, I've considered it as well. The array in core should be necessary.
Otherwise, the PRI forwarding path will have problem to support pasid.
So the question is if the pasid_hwpts is necessary in iommufd. I kept it as
below considerations.

The usages of the pasid_hwpts here are:
1) check if any prior attachment in the attach path
2) retrieve the attached hwpt in attach/replace/detach path.

The first usage can possibly be done by querying the pasid_array of the
core.

However, the second one seems not trivial. iommu core stores domain/handle,
while the iommufd needs hwpt to check if curr_hwpt is the same with new
hwpt and the detach path needs hwpt as well. I've considered the
possibility of a reverse mapping from domain to hwpt. This might be
possible since iommufd does not share domain across hwpts. But it appears
to me this is more complicated than adding pasid_hwpts array.

@Jason, your thoughts?

>>
>> AMD requires using PASID-compatible domains for PASIDs, hence the hwpts
>> directing the PASID path requires to flagged with IOMMU_HWPT_ALLOC_PASID.
>>
>> Signed-off-by: Kevin Tian<kevin.tian@intel.com>
>> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> 
> Either way,
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

-- 
Regards,
Yi Liu
