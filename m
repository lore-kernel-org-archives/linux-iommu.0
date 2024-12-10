Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012A8A94D
	for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 05:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733809654; cv=fail; b=o8hxwHhQqdd1+Naj8nhGI5mmckSpn10V23qInGStZV8GNy32/616esxA3jsz3QTE2af43CNbMPQnPkFcfMebiF9r7f81+A6VuT4w61/MsjdXoYeh0/OJBm7qhA/6c/MueMlLnRkEKOfxqYwTd1m0KwbJQG+GQKWdR5O1gvfdBQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733809654; c=relaxed/simple;
	bh=blLLY1BuL998yf6xVO2p5XeYViYbaltJ0Om9ZRP8I1c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rPdvYpeU4XwStYRefogC95cA8LBYsyWBl3rk6uEJRNqxcGtggLs2ChsbHnhWetfNWnyMSwzoDioHMkV7nkC/i7n09RQG3jicjWLVUd8IZpv3d5IwoxUHwBm7ZiN/6LASqJah3MRoVbCS0R+/sdGXaaBB7BXB4Wh8/hv4JMm1uaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3tCi4Gl; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3tCi4Gl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733809653; x=1765345653;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=blLLY1BuL998yf6xVO2p5XeYViYbaltJ0Om9ZRP8I1c=;
  b=T3tCi4GlXIrF9dOQCvjcDdtMEGKxsYINClYl3+7NIWISsl8nRYgq8oT8
   rIJDYnRMeTOWGb7perG8/TkI13Vs4XyUl3dFQZUXteTZVL9EG9RqWA9Ng
   i9kTrGap0JZ1RdxA1cAlAgw3A93MXqsth0SjAR4yye5dNGVZghAfCP3Hx
   VV6j3ZWY5roUS/aIXoLD/C2LZG3+sU7rOCW/2CW7yK1I71YfwG6qGmp4w
   eTHPh3WUzuSMU/QvYMmOV2ZD5kd37Rga08k0sd7/odeF9+SDnXD7pSDL3
   XsEf7eFJrz5zqz3Iclt6IwJKaEhJvUciEfnxwrs9pFkfBbSkW9F8wu+MM
   A==;
X-CSE-ConnectionGUID: e3KwMqieQPKl09YAkdlEtA==
X-CSE-MsgGUID: rgAO0IExQqKtjEjCbNiYAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="45534123"
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="45534123"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 21:47:32 -0800
X-CSE-ConnectionGUID: Cr90XoPqS+yA857rARvgoA==
X-CSE-MsgGUID: AkRjEL5WQuGpsSN2yuJaJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="96096819"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2024 21:47:31 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 21:47:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 21:47:31 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 21:47:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzQXTKHLWyI7QCQ/3+JznPw7+q8688bnmZoUgTlfhJM5+E7HYOWqeaiLud9eg4XT46SU0Fj5N2zXbIUxWIISD+21L6cGNSRsaxQ9eTWPkHZTLUyS/Wf1iw0H2UKeRSReJO+rZEug0icL9YyeCctMfN81NUwL6QEFm9KLZn3l6jUk1IBcga3apK1JTS3ly8Nx368TG0zgCWv3Mp18FpwqZ7fHV/UmGil/BYx3iB3TeN3e/sm0/LfdKXIWVenF6fypYWMKxIulrEyZ2tXUBRKXTYHLi7ZdXytpN4aUvjN9BYtCgbhlG9m+5l3T/sTTkviCYLgwJ7He6A2GfxXCgOkbdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itc+XZUJoPFhjhXpPuTU8+OXNzE3J6owNUiSSYdZjgo=;
 b=NyV5lkUoDSmjkBiHTGk6myBY8FyjkMKAZNbuVothp9Y/cliMDe9KOlzIFThMQDPBocFTvM8u5oheHwjsff2uxJO16xs5y7w2JN8CkDpcJdfEFTfPvxpTTjoB5jVhxnqjv0v11/PGt8IT3OwriPvlzemGksIq+gTtuXwoEgH7I2TbcP1Dka4T54Q8mH/iI+Wp0j7ja6y1shBSVlZHjgkdr86/uVF9awxag8D+ZT8FNDcssVcTt+T891qA7Y1cfFXHcuH33/QHJKLeRFyOrgI8gJOhJkaGB353hKx2ji5E9ykQyPC1nL0YvgdL0humc68NJS2ZJHMJw+JiBoq0bxKnxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by BL1PR11MB5237.namprd11.prod.outlook.com (2603:10b6:208:310::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Tue, 10 Dec
 2024 05:47:29 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%5]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 05:47:29 +0000
Message-ID: <95a85b9b-a17b-4df5-a1ac-7a0880950960@intel.com>
Date: Tue, 10 Dec 2024 13:52:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommufd: Deal with IOMMU_HWPT_FAULT_ID_VALID in iommufd
 core
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
	<kevin.tian@intel.com>, <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
	<chao.p.peng@linux.intel.com>, <iommu@lists.linux.dev>,
	<vasant.hegde@amd.com>, <will@kernel.org>
References: <20241207120108.5640-1-yi.l.liu@intel.com>
 <b1e8ad5e-e149-4502-8242-b971ac1d4eff@linux.intel.com>
 <3f9e3172-dffb-449d-8bd5-23f9cb2de73a@intel.com>
 <20241209150514.GD2347147@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20241209150514.GD2347147@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|BL1PR11MB5237:EE_
X-MS-Office365-Filtering-Correlation-Id: a5eb5b59-bdce-41d7-cae3-08dd18de21e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3NPMHFpNW9nWmhmcWpOR0dWdUc4MEQ5Z1pScWozbXdWTGxTTm5HYmQxeDZt?=
 =?utf-8?B?b1RBOGNmK0xqRmV0dEZGWmxobXhEN1p6U0lTZ1Q1Z0Z6QTZ1dzlLVTZKc1Vp?=
 =?utf-8?B?VkdSWmxlN3pJempyVDJIOWIyMG5qVUZGNitzUjJzVXQ0OCs2YmZrUVVVbzYx?=
 =?utf-8?B?MnR5K3ZjOVhNamVFbzRDRENXZXZGK2VKOTNaeEpIRU1TQkZFQnc3YUcxdHd0?=
 =?utf-8?B?RzBJbXdobGg3ZVZrYmFVbEkrZjFTRnVuK2lwaFZsYUJ0dXBpWm54Wjl3eGZk?=
 =?utf-8?B?RkxRTC9La0dNZUpvMGM1YmR2MFFROUdZVzRhK2d4RzZOZHUyc05yU2oycC91?=
 =?utf-8?B?a0J1eFY4U3lqUGxwdXQwQ0g4NzJnaHQyWXRQSTFXMC83TXQ4UjdqOG5JT3BY?=
 =?utf-8?B?NG14VklyTE9MS3ZpbitQdy91RFRyQXhRdVI4c1picnZHekFhWlFDZENVUlZK?=
 =?utf-8?B?Q2dwMU5GUjY1RnRGai9EcG4xL3VyNGJKR0hRcHdvOGJ3RlVJZUROTkdjNysr?=
 =?utf-8?B?WGMxcEU4YXluNk00NnB2cm93bm16ME0rRjc5NmRSTjlKaEdWVDQram5vZ2lk?=
 =?utf-8?B?YVQra1R2SGpMZXQya2U1cWFxbDJEYWRsalI4STE2bkQrUlRVRTNBVW1lSmdD?=
 =?utf-8?B?MGpkTW40ZmdzNnlCOEIvWFJwTXVkVm4rKzF2U3FWVWI2ek5UeGZmUEFsdjNJ?=
 =?utf-8?B?TGtyUjVUU2FDc0c1VlJMV2R0ZnByOUZZY2JzYmQ2U25FbmtZRWhWVC91K0VB?=
 =?utf-8?B?S1M2Vm5abGkyZ1NVRDdrSXpPYzZqK0JxNWROSXBmM3h4Q3dud05CemdOS1VW?=
 =?utf-8?B?M1B3MmJ6ZEFUSXZaamEvaGNKYUVBbFNDdEpLeVFvem0xUWMvQnhhOXpOOFRw?=
 =?utf-8?B?Qml4UFdxL29PTHFlazV1cjI2TWk0NWNIUXNOTWUxbnJ2NjV5eG1kR1RoTUxN?=
 =?utf-8?B?dUd1T2hhc3FjNXFpbWd5TVJSeWppdWcycXNYaU4xVTFCWGQ1aDlPOXhLbGd5?=
 =?utf-8?B?TGxFU2ZzRFhTMVhCTW5OeFVPbVJ4SjhoaUhldnZtVndzZWRTZUVIVVBZNzM5?=
 =?utf-8?B?ZHZNanZ6aTg1UFNSOTY5bDE4b3Z3RStWZmx4Y1VNZzZxSGNGR0UzVUZIaU5s?=
 =?utf-8?B?Z3ZsK0hMTElPbzJqYWRUd2cxYlFCWlVTVXVya3hFUmRjOWMwREZURVhoc1pE?=
 =?utf-8?B?NDR4dkR1NGZEQm4wQUJZcGNxVTYwRmdzaEh5YXZHQ25XVDk5QmdaRW5UQ3JZ?=
 =?utf-8?B?RzlUMkxUSjVHOTdLY2lCbHdSWStielhoL2tMV1JRQ0RFTEx3c2JpSVVYSlNq?=
 =?utf-8?B?MTlNK3Yvbk5hanFvVE5Dc3U3K3lUSzAzWEszQ25WU2FZRFhWdGxiRVRMQUxk?=
 =?utf-8?B?ekRkTHR6bWY1SVBZSk5ncHhDZGk5UEFsajRUckEyMHAyUXovd3NJSUVuaE0w?=
 =?utf-8?B?WFJ5QlFvakpRU2dsRXU0bU5zRHZUZ0pUT08rN2JjOTN3VjhQZG5BMnpKSmdO?=
 =?utf-8?B?cUhhcFFOME9KMzNxWHJnc1RzTkRwVFc5R2lIblgzRG1nbjMxKytwSHFxRXBO?=
 =?utf-8?B?aC9kNmluTEdKcGRHQlo0L0xQcFV4dWpiNUFnWklJZ2YvU3J4TGdwakphY1pY?=
 =?utf-8?B?SWh6YkhxRm1OVUUwWXVJRTM2amViYlpRVFB1NnlOdEt1dFZ5WjVIMnhCaGx0?=
 =?utf-8?B?VzZsbC90a2xEbElXeVZzTHo2ZHBKc0kvRlFXRUpsdElsOE1LVkpnbHFsU3ls?=
 =?utf-8?B?UUFMZklDbTJJeHFlT3lNbXZJejZXR0Fzalp1NFRpeEY2OStwYkM3MWlMWlFm?=
 =?utf-8?B?MHUyVzhkNHNHTkEvckorZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anBjL0NpR3l1ZVBvWEgrd205YTc1ZDRpVDVvU1lFTjVPWDhhWFp6d3VYcFh5?=
 =?utf-8?B?NDgvTDFwZkV4MjliNnREUmozUjZmeXgyNGxYdy9XOThRQVYxMXUvU1VUUVJy?=
 =?utf-8?B?QXMzQ29Ja0RjOHZsbEM1KzZhTzMxa29ScXZKVmZ1S3NPNTJRQWtBZkM2WmNL?=
 =?utf-8?B?bnZpbUU0cVVzU0hKQ0V0T3hFZlpaOTl6c2VHN0ZTVFNNbitxeU9vaGlIVUNq?=
 =?utf-8?B?MW51MjJxUUdCcDlqWGtwMFRDQkdDL3NWRnJTVm9BUlhwYWlOaVN1OHhYSGZq?=
 =?utf-8?B?TWpPbmw3Y0prSmk0UkJrM2NMSy8vSU5hbk5OR3lBY2p1MkxKVm9kRFZnem95?=
 =?utf-8?B?Y291clNJbVNUZjd2UHB6eU04b1gxMy90MXdGdkNpV1JPZWI5eEwwa2NXZ0hP?=
 =?utf-8?B?YVNwME9VOU5YejhvcmN6YXdKM0FYL0dHaXU3QWRnU0dacmVZWGtMZjFDV2F5?=
 =?utf-8?B?MTNqRERkZ3FGaTFtV1VPRGJUbS9aNXN4cXVhZHVvaTVxOU1EOVFISFJKY3Nm?=
 =?utf-8?B?YlFHeUlENW9GKytXZjlrdGFNYS9USjIrdGFtR2ozTmFUT2ZVMDNLVC9VWEVG?=
 =?utf-8?B?YzFGRTd5ZUxWZVRwSlk3WnpJV01ycWtrRkNrdGhQN3dENzZxZzJZVnRFMi9l?=
 =?utf-8?B?U2I0Z3IvQ1U5N0Vna2VUaHQrQnBNUDc0d3NsR3c0WXFpSGVjNG0zeXBzMTZo?=
 =?utf-8?B?SmNOeFVDZU0xRGplOHM0aldxRkFtV1dDUlUzMlpPRklYbG9nQkNHT1BrOVZv?=
 =?utf-8?B?Z1JOM2VLZmd3M1pqSXp0OG5WNk9kcGN1OWFNaUxnQWVDc09QUW4rdmZQcUtW?=
 =?utf-8?B?S082bVVEc0luYW9ueVRVTUNDU1Jhekc3M2VxbnZFRW5XSTBZNE0xc2FFbUJF?=
 =?utf-8?B?UytnVmdOR1JyR2wvdWIvbi9veGtBdHd4UFNROVRWUnpSb1J0aVpLS3JicEpq?=
 =?utf-8?B?cmU5Ymt1OG13emtpYWhKYzcxcEZENFhhSVVWVUgyWExJU2E5K3BGVnRWUWor?=
 =?utf-8?B?ZFY4SVpxOHZRSCtBam9aZmpBRFE0L1J4bDFXUXBvZlpyeXc2YS9RRkJVLytl?=
 =?utf-8?B?T1BwU0VZQlYwK093VzN3YXY3bGdqaGM3RWo2cUs4M3pKRVdrekozR0RQZFJC?=
 =?utf-8?B?c0VPdnp0cCs0eTFpZ2tSbVkrWXQrTVJsU1hKQUJYR1lWMys2VndLbXBxc2My?=
 =?utf-8?B?cGovRGFYaHlWTkJ4TWpoZTZweHBqS3pNQi82amgzSHRkNk5mclhYODRWaUdE?=
 =?utf-8?B?VzB0N0hKVGJVSHdzMjBhYXhlcWQxQzhjb0V0MmpxdFcvaFlQYzdUbFgwKzQ3?=
 =?utf-8?B?WWVTV09BUy80SXE5SVg5ZlpvODNxcnZETG9JNGl1WEd6TkdVOUNSN09wYStW?=
 =?utf-8?B?VzBqNGxJWFpRZnJ2QXVpRkFvOEI2M3o4N3BvOVg2TjF0RWJETlN1Sk1MUlNX?=
 =?utf-8?B?R1FaMWZ4b1NkUHFLVDhaeUs0UlpQN1J0VkRKRWNNSjRzbS9xdWlyRHVtMTlQ?=
 =?utf-8?B?Qkkzc2lQYzl6VHVuQy9MKzBvWk1mcUJ1T09uNjdNM3VBbTJQVy9jY21HN1Zz?=
 =?utf-8?B?NXo3dlhGa3dHRVc3QjBXT0NFamdDcXZQRUhObE54WUlrYzR2WHkwRUtkK0po?=
 =?utf-8?B?bnR2d3lrWm02VTk3bmVYOGZTSStuTjBIeGJraFlvUHhxaFZScW51MnJ0SGFx?=
 =?utf-8?B?dEhLV3pXZGVrTjFPeFpMVDdZK250WXRzZFlNZG1sK3QxcTN6VmlTdXQreGpV?=
 =?utf-8?B?Ukk4V1hLdHg4aG9YQzN3RzNRMk0xaVVYSUlwUEE2SHN5cXdtbHpudUM5dXRV?=
 =?utf-8?B?aGgxblVMMkRaNUxTbWQxd0tVWGhONU5jbVIyR1JGWVBkTThIeTB2djBJZi9F?=
 =?utf-8?B?VUtaai9ndGd6d082Z1k3OEtjaXdnalk3SzVOOVQzQnBXVTZxKzFtT3p2MFp5?=
 =?utf-8?B?OU40WExuM294VUc5L0FxZWhQYlRlbnA2emdxOXBEZWZkTGpDWnhZRXNiZDhZ?=
 =?utf-8?B?SUVuYWl5SUVpKzM1TGljeDdlZE9FTE9DdENHTi96dWd6S001Skk0SHhmK0h3?=
 =?utf-8?B?bjFuNjFHamk4QnhjZVpPTzdiWHVudHphK2NTRmwvSUpOZ3c2Y2g2MTdlVjQ2?=
 =?utf-8?Q?fij9g8sEpzRcrpcBO+GpUDEig?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5eb5b59-bdce-41d7-cae3-08dd18de21e5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 05:47:29.0294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXIUcCjqOkFfj2aIMnVpMpo9mS6XP86rLBhTekF56ysQWGLis032k/aECru7J3CxCa6JMTnlfQml6GSWEuxtUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5237
X-OriginatorOrg: intel.com

On 2024/12/9 23:05, Jason Gunthorpe wrote:
> On Mon, Dec 09, 2024 at 10:51:51AM +0800, Yi Liu wrote:
>> On 2024/12/9 09:08, Baolu Lu wrote:
>>> On 12/7/24 20:01, Yi Liu wrote:
>>>> IOMMU_HWPT_FAULT_ID_VALID is used to mark if the fault_id field of
>>>> iommu_hwp_alloc is valid or not. As the fault_id field is handled in
>>>> the iommufd core, so it makes sense to sanitize the
>>>> IOMMU_HWPT_FAULT_ID_VALID flag in the iommufd core, and mask it out
>>>> before passing the user flags to the iommu drivers.
>>>
>>> Is it a valid use case for an iommu driver to intercept the
>>> IOMMU_HWPT_FAULT_ID_VALID flag as an indication that user space requests
>>> an iopf-capable domain?
> 
> For now we have no use case, so we can drop it from drivers, I think.
> 
> PRI support or not is decided when the domain is attached based on the
> fault_handler in the struct iommu_domain.

hmmm. It sounds reasonable. But I failed to see such checks in iommu
drivers. So attaching a non-fault capable domain to a device that has
enabled PRI can succeed. But the PRQs from this device will be responded
as bad PRQ. Might need a patch to fix this gap. is it?

> As a general rule drivers should not know the *userspace* is doing
> something as much as we can manage.
> 
>>> If the device and its associated iommu do not support PRI, the domain
>>> allocation should be aborted and a failure returned?
>   
>> Agreed, it is better to fail the hwpt allocation. BTW. We may also check it
>> by reading the enable bit in PCI config space of the device. Which one
>> would be better?
> 
> We should not be reading pci config space in iommufd. iommufd is
> generic and not tied to PCI.

I see. :)

> It would be nice if domain allocation fails, but also I wouldn't
> contort things to achieve that. Failing attach is also OK and must
> also be supported as a fault capable domain allocated on a fault
> capable device can still fail to be attached to a non fault capable
> device.

yes, iommu driver should be able to fail such attempts in attach phase.
So I may keep this patch as it is since IOMMU_HWPT_FAULT_ID_VALID is not
supposed to be used by iommu drivers.

Regards,
Yi Liu
