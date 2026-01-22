Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68D23C198D
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067418; cv=fail; b=a9IBNLxElXx8J8oD8goPNASa2gtjwuE5K+dd2sKt1DvLPvyB+XzqMTHL06Krvp2dy+csaYZ+zDjHe5oWVK8tVdBRHE9kaJ3WIBHxTSW3DhM72lxAj4UD+xBezvDQMz3FBvs2fV6Qwvex5xE4fmsbGxe+6CgwMOjfv3y/3MeJ5os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067418; c=relaxed/simple;
	bh=LDx9apCq53K4t6B+EihNSyiYHfepJFW3gMd1FEnyfNE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qhkWOvvyhEPLRz1LLHLxcAKGZ7L3awjgXAZpxU6xJmX2g5r7ZtA8ngbS0XpWNUl+jNHlS6J/uwp1sWxE/uzcxzSL/JSmU/6KCYKglys1n8+2qRvfd4mQQ8bKsLslN0BXAJOFIf/WyECEKHZsIKz60cW/iKuKNvKzv9KUEx9ZfaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKxRIbjw; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKxRIbjw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769067416; x=1800603416;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=LDx9apCq53K4t6B+EihNSyiYHfepJFW3gMd1FEnyfNE=;
  b=UKxRIbjwLMTgYG/iLPbhkEf7f559McH2kEHAhwHnshhkrCuhKNsceSck
   Tdpt+cxZnoCL1UYSaLMf2atZ41qX6+GmTqwN9ip4OLGexsEujwHlcOg6y
   R5Z5urbeFLTFuEByv+So82igge8RxtKmB9KAcQyiLecqD7Gphi90TyZjD
   W0rLGHiTKen4oFIQ39SXwJVVnE4CR5YICwhhFZir9CrWpuujLr7hPo0At
   6YkGrBgr1jKUpQHF34Fbc7onfE4FZKitJpPehwAdvDjr3J7I0frX6lN2d
   u/q78I5grJqE8F2rJTc+j/egA728lp+yDm9urn+auUiLc6RrCsBTtmC3i
   Q==;
X-CSE-ConnectionGUID: kNPWgb9AQgusZ2ol7jI23g==
X-CSE-MsgGUID: ApeEl4BmRMCRqHLn8+vWCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70354300"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="70354300"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 23:36:54 -0800
X-CSE-ConnectionGUID: JaON4FS0TSuIx70ESJOPjA==
X-CSE-MsgGUID: MX+862uOTbm2UGivdO9ENg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="206571929"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 23:36:53 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 23:36:52 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 23:36:52 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.13)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 23:36:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGH3IZm2/iKGYV69wS7GYp5kzeeGsBwFEjms2ZfpGiQoyaAJhs+AiV2JoWtD/ySlFzE6A9g+Dz21ppphaG3SrSm1K13sX4PYH41OmqaSHNW6c3yBWUTODD6UboMqZKnjTGMe1Cpuz+nLJOEubn+dsAyZBZxgzfuYsl6oJpnJVI8/aUdMDGo4ywROQie36S/9bjGhOg4g8iwd0EddBCToN0BVzHniaAHog+VGJcvgBW4PezwKhKacWn6lWk4EMLgYEYozCoo/k4fEgX+2kQNOCDY/6TdKLI135qk2BVNl9w3VUeQ1OJTBtLSA3OkLf0wWVM+yIJxCVjT7pcNJ2Q/s3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbEZTfKEV6BhyLcv3uzae4MbxF+bxIhsLlUXdkZK5Ms=;
 b=xlnzW5lnYGOx0SXA0e/Afm9ZMExHY7ZzLr+/Hev3QgMmpmx2fQNVi/DUFm9CIRyP88D/Gy/EyMCmqbjXrXaEr3ktLbNxIwakj+piaBlxmWhYF4jsXELEnB+ViMo1d5wxyZjFcWM7O7urcHhUUuZKd0zvGK+2hcnpV7/Ro2cnUYp+WCScTOhleKkl8rMDWqbKf+kcRPc0JeeU/myWlAY6Z0SJBKONoW9gJDz92XCd5XbDcTCtx+s2sSy6nJ40yROarikwRcMfkc7w0BOvn030A4pqpCKmVj5drt6nTQnb3sHzlzrp1yHFypfvRzgk0K3qSw/82HjA5TL48WcIO2VxNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA0PR11MB4573.namprd11.prod.outlook.com (2603:10b6:806:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 07:36:51 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%7]) with mapi id 15.20.9456.015; Thu, 22 Jan 2026
 07:36:51 +0000
Date: Wed, 21 Jan 2026 23:36:47 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Jason Gunthorpe <jgg@nvidia.com>, Francois Dugast
	<francois.dugast@intel.com>, <iommu@lists.linux.dev>,
	<intel-xe@lists.freedesktop.org>, Joerg Roedel <joerg.roedel@amd.com>,
	"Calvin Owens" <calvin@wbinvd.org>, David Woodhouse <dwmw2@infradead.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Samiullah
 Khawaja <skhawaja@google.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, Tina Zhang <tina.zhang@intel.com>, "Lu
 Baolu" <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>
Subject: Re: Xe performance regression with recent IOMMU changes
Message-ID: <aXHTjz6SP5w/PTPa@lstrano-desk.jf.intel.com>
References: <20260121130233.257428-1-francois.dugast@intel.com>
 <20260121131135.GF1134360@nvidia.com>
 <20260121180449.GA1490142@nvidia.com>
 <aXHAcibp/4pUB8f0@lstrano-desk.jf.intel.com>
 <20260122072913.GJ13201@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260122072913.GJ13201@unreal>
X-ClientProxiedBy: MW4PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:303:b6::6) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA0PR11MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd17899-805c-4a9d-aa3b-08de598901c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eld5YjFZQ0pZZFR6NnUrcHpEQWw3REZEZldRZmpqaW02U1o2SWptWTE3dzFO?=
 =?utf-8?B?U3BXV0JkclpLc3B5MXE3aXNieDJaL2ZXMjQxakp5eWJxaFYrbElXZ3NHRFRY?=
 =?utf-8?B?ZlVHVGcrUUswSGtrbFdUdTJvY28yQkh0VEJJRndHMXlpZUFkMDhNZzVCUmlW?=
 =?utf-8?B?eXFIYjdUTXNjOHZNb1FqMjJ5anFKR3RuZHA4VTlEd3hTNmdzQnVEaEhUOWJt?=
 =?utf-8?B?VWRTZEZBRkF6V2RBMWtCZ2N4WGpoYWtWUTJjNTlIQlhkaDZNcWo5K3hIbVRn?=
 =?utf-8?B?eEFVTzBIWXUrRGorVFh0ckhDNjBhN1VFejZQUmRFYzlYUTNFK3ZrQ2o3SFpl?=
 =?utf-8?B?VFlWVlcxQVhxSmowNzNVM0VJM2lDQjlReHVYcjJlMWFlWXVVUmJwUXRyeFFp?=
 =?utf-8?B?ZWlQWW1tRkNPa29oOVZZd25PVGoxSU1sUTRLYjlZaEc1S2tRWGVkUFVBQVor?=
 =?utf-8?B?UlNNQWR0ckdndE5ZSXEwMDBFWFJSaDhIN2RteDBtY0JJdldpek9qVXlGa2Qv?=
 =?utf-8?B?c3NHVStaNkVuRjYxL2dLK2FnMGE0aEp4cGJYTkZaQjFOUUlQeXNuYWY2N3BN?=
 =?utf-8?B?MzNaVFB3NEtDUGhiaGt2M2l5UWpiMzZXRjF6VDhKWlhtQmJXVGhYazdIencz?=
 =?utf-8?B?U2Y4cE5hVC80R1R2cWJpSHJ2R3Y0cEdzSXl6cTA1N1hXM3c0SHZ5dlROekpy?=
 =?utf-8?B?YjNpd2lqcXdFTjFUMWFRMVBCQkhTNzJBb0Z0N1Z4VmhuamxmVFFrKzZ6S0JS?=
 =?utf-8?B?K3VTcEVFcG0zSnVVTVhuMlp2b3B6OW13T1M1OE9pVENqWDJiTldNUllNSlpN?=
 =?utf-8?B?MXd4cDFsd0hRaWdWQjVIcjZzdWZZcnJnNSswK2JOY1lGNFVSejJxZVpENlZP?=
 =?utf-8?B?UU03ODBxekgxUmpvMVZIQXhkRUlTZ25mZjBFbWVxaTR2cFFhSnFMWDREaFNU?=
 =?utf-8?B?aEw4UkxXa1cyV1N2RWcyb1Yyb3JIY3kvejJNUEJwcVZtYnhHWU01K1BBRXQv?=
 =?utf-8?B?Tncyakh1eUVXRnNZaGJXenY0N0xVT09xLzU1cjB4ZFh2ancwTkJ1bk1iTkNS?=
 =?utf-8?B?YVpqeE9JUVl0N2hWOVVvc1VQOXJKRXB6em9WZ0FYZ1V4Tm8zT3Z6Uzh6WlhM?=
 =?utf-8?B?MngvWThoek85MzRISDlHNlJEaklabHFGZ1ljVHVKNi9EMVdCQ2VvVGgyTWVI?=
 =?utf-8?B?TUUzanN5UnBCUTd6Vk1iUjUwcUU5aG5vTVljNFFXYUpHUmVBZEI4dGRjd1F1?=
 =?utf-8?B?MUhhcURxMXIrN1VCbWhFdlN5QVZpL2lsVldQN2tla1hjck0rVVVRWmNLTUdD?=
 =?utf-8?B?U0hlZlcyUXpDaWt6ZDluaUlFamoxODlDejBDYklXbENVRTQwbkIxR2tnUW1x?=
 =?utf-8?B?aU51TEY4K0JVZGtHYUZBaTFhM3VDOUhWRmQ0cEMrMnZKeFhUWkp6NlhpL0Jt?=
 =?utf-8?B?QnYzeTBGMzNqYlRVT2NEQ2tKU0dyaks3dG9FVnloZXlob0Y5MGhpeHZTRDI1?=
 =?utf-8?B?RUF6ZnRtNkwvVk9xRGNwRlR4SjhUUmJMYS8wRWFkTEtEWjVQOGEzSGRKK2FM?=
 =?utf-8?B?aHRRTFM4Wm50eXFNc00vaXoxR2dUS2tMWVEzdlozN0UrRHpmdVBGQmd6bE05?=
 =?utf-8?B?U01KRHJoOW1QUy81cFYzMnRhQStMa3BRRHllRjV2WWV5OGhycWJmS3lOVVQ3?=
 =?utf-8?B?ZE9aaXBPRjNpL3E5SUY2b3VRWnVISUdvN1V3bU9veVVKSFZZc2NYM21RQVpy?=
 =?utf-8?B?WmlzZmxiZmVvNUlTWXZoOTl2aXJqcWs4cjJSRmE3MkNuckkwdU5KSG5PQXB2?=
 =?utf-8?B?SWQ3MzVld0Z4d09CY2ZZNnZkMWVUTUx0YjAweUxlUXh0TDByTitFd0d6YWtN?=
 =?utf-8?B?d2g1cndzUXV3cmhyUWN5bWpiendGWGN1cmh3TDhZbEdlVTF3ak43R0ZNQk85?=
 =?utf-8?B?dlZ4cGJUcjFRanVwclNlTFAvRkh3TExxZ1ZSUVl2enBjNGNVK1lJYzFaMHJn?=
 =?utf-8?B?Qm9BSXMrbDVIcUJwR3phT2JETzFvOGI0YWxhNFhJOEl5ZHNQZ0tNT0Vvc24z?=
 =?utf-8?B?VDVwbyttVFN6UWQ5RHk5cm5VUldRbW10aHJFUGhFRFlIWU1GZWdoQnY5ME14?=
 =?utf-8?Q?s0qs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDhwMWFCeGhqREl1bzVnUGVFNTIrN1piNGZxWlNRMzBtSlRnNU1OZGpwNXJ6?=
 =?utf-8?B?d25WcFcrSkNxN2twYS9NK2FxOTkvWWdFMDQ4cTMyYlNwY3Y5Qi9VRUR6NmFN?=
 =?utf-8?B?TWxZRDhxajZHSWlTWXQyNUFnMXZEckJNWFNwY1FhNk1KWGtaditLUGRZWnBu?=
 =?utf-8?B?UXEzejlyclFoeHBGNWE1ZkRXRnM2eEdUK2RQY1VIYmhKWWZQQ0p2L3dlYlRC?=
 =?utf-8?B?SXd3ZTNOSW1MYlUzYXdOdVR1R1E1Y1NUcFhsb1EwRlNETmdqQ3lUcmxTdDRa?=
 =?utf-8?B?dlNnZlJuZ3FZaUxWYitDZUZxdHJZTFhMYWVKMEVZUmphK1NHcElXb2xTU2l4?=
 =?utf-8?B?VmN6NHJBU043dEgrT2RyZHVrWXl4OFFET3lEUmJHRGd3M3BTRXdYSER0NXJy?=
 =?utf-8?B?ZTA4aktzYlZwaW9EMUcyMGtQZEt5a0RVbDFCK3YyR1gyWVd1VksrZC84aUxN?=
 =?utf-8?B?R05hZTVQdms0QjM5YXdQeXJXTkUxUWM3c1VxWlpqUmFJQWZrSnhkWnJBYUZ6?=
 =?utf-8?B?czRWK3UzL2dvN2xnK2tyZWwyRGxQOGMzOXZFT0tZZG54aDc0WDNtdDZHTFhs?=
 =?utf-8?B?MnlONzIzeldrbXQ4ZEhiTmpZYVlLbnprS2pzbGJpK1ZqUzZoL1kzS3lRekdT?=
 =?utf-8?B?Y1RubUpZbWZDbncyUnhNT2k0UXMwL3l6NVExdm5zWjNrOTFyeEJsbnpobWpq?=
 =?utf-8?B?VGVSUkJhaE1PeU1uaVFnVEhnaEdZZU9tMERqdU5yZms5eUpFbGZHdDloZDhG?=
 =?utf-8?B?TkovT1QxeW9yTHpBdmxRV1lYZ1R5ZlJKbVBraE02d0NvMVNKSGc1czd5ZGti?=
 =?utf-8?B?Z0ErWHZYa2dTMnhUZ3NMTEJvaWhaOUtyYmdjV2dPbloyREpDRG50NU9wUkxo?=
 =?utf-8?B?Y2lkeCtkOEd3UDRpRUlnOTFZKzlNcENBWXg3OHdvcm1GVW1BdXRUWXM1M243?=
 =?utf-8?B?Z2hIYllTVkdzMlp4RE1tS2VmNkFsejBGc0VjK3BWK2t6bTFVU1JyaXRxMWVw?=
 =?utf-8?B?ZmVGMUNmUVRVTHVkK1docm1kSzZHSGNRM3l1V1dOU2hKbnhDcDJ3R24wTHpx?=
 =?utf-8?B?Zm1tL2JPSEVNcktWVnJOTEJWM1h5VmVrZ1A2V3N2TCtQcGxoSVhHZys4elVw?=
 =?utf-8?B?am9hQnZHeVBOajRSYmh5Q0FOaTdVYkRJd1h0azBGcE4zY1RCbDNsbXNVVmtu?=
 =?utf-8?B?NlFYdlhlQkFQa0FQYTdvMkd4V285WWdNY3JOUHJMWkFUcGV0R1VWQkhWM3dj?=
 =?utf-8?B?OENYMVJtWEpVWDZpZXFPMjE1Z3hFYXdwRGZjY0xCbW9xRFRLVy9FSVMvWkxE?=
 =?utf-8?B?MjZqVi92S0toQlN2bVBBMENHUEZjVFdWNDBvSGdKbkN2cERjYTMyUEVSQ01Z?=
 =?utf-8?B?RmZja2M3eE1xbDRmbGxrY1lwd2lCS3JCTVExekN4SzZyNCtrOUVyeVNpeDZq?=
 =?utf-8?B?a2ptZHFxNWVXVjNUNkduOHdRNCtOK3RCZHNUaE0ySit0QzQ2WGtLL2dpNlht?=
 =?utf-8?B?SERpUEl5REpnWXgrcUtmQVZBaE1TQ0ZoL2RTOGIxaHJ1UjhMbTZuK2ptRUpW?=
 =?utf-8?B?YXY4S3ZLSzQwYW8wVmozZE9XZ0ZGeDRuSVlvNjlFTURjT015UUUzSEJVb20w?=
 =?utf-8?B?dGQwVjRoYjZkTHlUM3o2MEtWS2ZjTGR3RWhxaHJMbzRiMXhmQXp5Mnl3T0V5?=
 =?utf-8?B?TlA5YWN5d2lZaHd3QjhXL2pUS1htWlRuMzNaWG9CNElMWkRJOWNOdW1QMmlN?=
 =?utf-8?B?SFRjSVh5SUNXdGZ0dG9tdGZka2phVWxGVkZueFFDNDRIZ0R2ZUVCTnhxVGVT?=
 =?utf-8?B?OHdPTGpDZU13U2E5YXpUTEdzV2xnRi8rTzBONlRFdDFoZkJUZFRIRTJLZXVz?=
 =?utf-8?B?cWtZK0RzOFZLTTc3RzRGUmY1TlVUaWxpVG9XY09HazlEUHRnM3BId3ovMllI?=
 =?utf-8?B?dS9XR0ppU1g1NU80SEhEZCtVU0RIZDBqWmR0ZXdZQ2dpczZUcTJtUzQwcGpk?=
 =?utf-8?B?VWVqVjFaakoxVkdqVlNEOHlXUkZlVklGTnpiYjJwaEc3Zkljd0QxcjNaMVVN?=
 =?utf-8?B?NTNMWWhhMDRFTGJUNDhjTld3c1loMUZOVzQ4VmRlbC9rSktSOThsZE1VY2Vx?=
 =?utf-8?B?MXN3WUIwVXRDZHpxYWFObm5sVlU3NEVhUG1uYXZTR0F3bFlzSmNhZ25jSGFu?=
 =?utf-8?B?UnpYdVhYenNFWGxsN2ZYY1dUVi9uQzlRdUNnZFhWelNiTzh0VXBRY3lvU2V4?=
 =?utf-8?B?b2pxdWFWeHZtNmVkQUdTcUticGFZQVp6bVhoU2Y4ZVdINTQrWVdiMEROcEdq?=
 =?utf-8?B?VnpZUG5sUjd4SFVoWDkyT2pIcXViV1A2ejRORHhta0UwNzJURkxWdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd17899-805c-4a9d-aa3b-08de598901c9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 07:36:50.9609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06ZDjhc+k9rSHJk540lS3Dk4VyO2ko6uy+45Gkgc7x3MM+SSgLw+Q1l/ENNtjcl2IYsIhJWxWkEdpc7mcaM/DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4573
X-OriginatorOrg: intel.com

On Thu, Jan 22, 2026 at 09:29:13AM +0200, Leon Romanovsky wrote:
> On Wed, Jan 21, 2026 at 10:15:14PM -0800, Matthew Brost wrote:
> > On Wed, Jan 21, 2026 at 02:04:49PM -0400, Jason Gunthorpe wrote:
> > > On Wed, Jan 21, 2026 at 09:11:35AM -0400, Jason Gunthorpe wrote:
> > > > On Wed, Jan 21, 2026 at 02:02:16PM +0100, Francois Dugast wrote:
> > > > > I am reporting a slowdown in Xe caused by a couple of IOMMU changes. It
> > > > > can be observed during DMA mappings/unmappings required to issue copies
> > > > > between system memory and the device, when handling GPU faults. Not sure
> > > > > how other use cases or vendors are affected but below is the impact on
> > > > > execution times for BMG:
> > > > > 
> > > > > Before changes:
> > > > >   4KB
> > > > >     drm_pagemap_migrate_map_pages: 0.4 us
> > > > >     drm_pagemap_migrate_unmap_pages: 0.4 us
> > > > >   64KB
> > > > >     drm_pagemap_migrate_map_pages: 2.5 us
> > > > >     drm_pagemap_migrate_unmap_pages: 3.5 us
> > > > >   2MB
> > > > >     drm_pagemap_migrate_map_pages: 88 us
> > > > >     drm_pagemap_migrate_unmap_pages: 108 us
> > > > > 
> > > > > After changes:
> > > > >   4KB
> > > > >     drm_pagemap_migrate_map_pages: 0.7 us
> > > > >     drm_pagemap_migrate_unmap_pages: 0.7 us
> > > > >   64KB
> > > > >     drm_pagemap_migrate_map_pages: 3.5 us
> > > > >     drm_pagemap_migrate_unmap_pages: 10.5 us
> > > > >   2MB
> > > > >     drm_pagemap_migrate_map_pages: 102 us
> > > > >     drm_pagemap_migrate_unmap_pages: 330 us
> > > > 
> > > > I posted some more optimizations for these cases, it should reduce the
> > > > numbers.
> > > > 
> > 
> > We can try those — link? I believe I know the series, but just to make
> > sure we’re on the same page.
> > 
> > > > This is the opposite of the benchmark numbers I ran which showed
> > > > significant gains as the page count and sizes increased.
> > > > 
> > > > But something weird is going on to see a 3x increase in unmap, that
> > > > shouldn't be just algorithm overhead. That almost seems like
> > > > additional IOTLB invalidation overhead or something else going wrong.
> > > > 
> > > > Is this from a system with the VT-d cache flushing requirement? That
> > > > logic changed around too and could have this kind of big impact.
> > > 
> > > Oh looking at the code a bit you've got pretty much the slowest
> > > possible thing you can do here:
> > 
> > This was a fairly common pattern prior to Leon’s series, I believe. The
> > cross-references show this pattern appearing frequently in the kernel
> > [1]. I do agree with the point below that, with Leon’s changes applied,
> > this could be refactored into an IOVA alloc/link/unlink/free flow, which
> > would work better (also 2M device pages reduces the common 2M case to a
> > mute point).
> > 
> > But that’s not what we’re discussing here. We’re talking about a
> > regression introduced in the dma-mapping API for x86, which in my view
> > is unacceptable for a kernel release. So IMO we should revert those
> > changes [2].
> > 
> > [1] https://elixir.bootlin.com/linux/v6.18.6/A/ident/dma_unmap_page
> 
> I think this comparison is unfair. The previous behavior was bad for
> everyone, while the current issue affects only the specific
> drm_pagemap_migrate_unmap_pages() flow. Cases where the performance of
> dma_unmap_page() in non-direct mode matters are extremely rare.
> 

I don’t think you can reason about this without extensive testing across
multiple platforms. Nor is it fair to say - sorry we slowed down your
existing code, good luck.

> It should be relatively straightforward to add a link/unlink path to the
> drm_pagemap_*() helpers and achieve decent performance.
> 

I agree. Happy to work with you on this going *forward*.

Matt

> Thanks
> 
> > [2]
> > e6fbd544619c50b4a4d96ccb4676cac03cb iommupt/vtd: Support mgaw's less than a 4 level walk for first stage
> > d856f9d27885c499d96ab7fe506083346ccf145d iommupt/vtd: Allow VT-d to have a larger table top than the vasz requires
> > 6cbc09b7719ec7fd9f650f18b3828b7f60c17881 iommu/vt-d: Restore previous domain::aperture_end calculation
> > a97fbc3ee3e2a536fafaff04f21f45472db71769 syscore: Pass context data to callbacks
> > 101a2854110fa8787226dae1202892071ff2c369 iommu/vt-d: Follow PT_FEAT_DMA_INCOHERENT into the PASID entry
> > d373449d8e97891434db0c64afca79d903c1194e iommu/vt-d: Use the generic iommu page table
> > 
> > > 
> > > 	for (i = 0; i < npages;) {
> > > 		if (!pagemap_addr[i].addr || dma_mapping_error(dev, pagemap_addr[i].addr))
> > > 			goto next;
> > > 
> > > 		dma_unmap_page(dev, pagemap_addr[i].addr, PAGE_SIZE << pagemap_addr[i].order, dir);
> > > 
> > > It is weird though:
> > > 
> > > 0.7 us * 512 = 358us so it is about the reported speed.
> > > 
> > > But the old one is 0.4 us * 512 = 204 us which is twice as
> > > slow as reported?? It got 2x faster the more times you loop it? Huh?
> > > 
> > > The real way to fix this up is to use the new DMA API so this can be
> > > collapsed into a single unmap. Then it will take < 1us for all those cases.
> > > 
> > > Look at the patches Leon made for the RDMA ODP stuff, it has a similar
> > > looking workflow.
> > > 
> > 
> > See above. I agree this is the right direction, but we can’t simply
> > regress kernels from existing performance.
> > 
> > > The optimizations I posted will help this noticably.
> > > 
> > 
> > I think we need to start with a revert and then discuss whether your
> > subsequent changes actually fix the problem.
> > 
> > Matt
> > 
> > > Jason
> > 
