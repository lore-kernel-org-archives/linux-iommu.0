Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573D4A944
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 04:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742529708; cv=fail; b=ligwjnQ4g3tfrASjB41LWLx7VCqmsFb5r+Ekd0kiML4RfqJe9Z4SQseas9F6YdvNxsFtHTank+XdoU0aByCvuJDnQKlAInweU+LW0t+WAyPiZjSESoK/EXvN/Ci4qucbHvkMER7QFxQuo/33sMoJ1/1180qbibRjK0czeshQMLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742529708; c=relaxed/simple;
	bh=cf7VoTC/APCxr+eFUZ+nlkshTaIJVjnIThzOqJExpmA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M2r+JhitJENmYYEQtn91a9tlOkfKz2RuTf9IbqYYajni4cs/pRrGj3SKiP8w5sWJg7RnfxATDZR/1jjo7Qd+XuLNWfDlQA9i241fjTD/cyVETHmjZxO7vX1QQ3oTo07MGZFx7Tk+nc0GVa5ci9ZjV9FNxLo3qwOA3oU9dn2aLaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fXgh2yVh; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fXgh2yVh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742529707; x=1774065707;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cf7VoTC/APCxr+eFUZ+nlkshTaIJVjnIThzOqJExpmA=;
  b=fXgh2yVhd/zSX1vbhgTxJuBeDi9RZJwPqGk2DUaW3+Qh22tYCBtLIrND
   86YQ2R3DoS+BjHxmgGMOOauOofrq79kyeT0tHqUiObvxelyUCKGrLbAMW
   7FMU/BtZIMnhVimdRVuGDRMO65syaW1ljd8eMvC1D8n0K+RVhidPU32g6
   DTj+jfy1IoKv/B9h96CTZnRZCknnALRJ4w+QqQPh2vVtA9zspnazAXSLe
   Y3ZfvTHTvzp5jL5cxIi4/sjJX8XVCE3eb1LHIRULLYTH4ilplIit52hyo
   sxjrMt2DwwmtrA1iW9Cr6v0GEQwT8hMldRrK84YdjaGDfWF+nE4dgF5Mc
   A==;
X-CSE-ConnectionGUID: i5vTKFB9RM6SCL+tSepwZQ==
X-CSE-MsgGUID: kcAvh5FSQcCR6MyAaZRT7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="66253565"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="66253565"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 21:00:56 -0700
X-CSE-ConnectionGUID: scZzFUAiST6DT71y++sOrg==
X-CSE-MsgGUID: x+7Wl0WqTbOUUS+hXf4Qog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="127443810"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 21:00:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 21:00:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 21:00:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 21:00:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIzXUXuAHEJzxEWluLURsgq7dM17aMtmNkEPLx0gjsQF/c5nHtKQrYS+pgbMUgleLv/7knwAwpji7hfyol6YXkOKqa+qbgdq+6THA7Z0rTLf6j5d4SSAh95Ql8mwK+WJWjmdYOa/KaQR5qRxlzXt0epdJ/ktfO7O+BxwqSadHRmXkp5UJl7p3gEXNtz4QgGn75Iqiv9pShaWbCNEW8+65faqQVDlphe/Rq/QAhlwhZUqCD612zqoc48rUj6QV+ZnwB/kSiKztahEOW4ukd+KGaGpzWcbhNaBpGLaukbswACT4wnhrYMG6fIADK3N50gSxA2/DS5zN0nF3hFhCtTEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaNiNq0JvP5TG9DdbmyY3obxI1QGcZGY/y+ZA8nfSS4=;
 b=PnWtcJficMwRRNAx4Dl4rVaugovX3bd+t9kXm01a4yZnQceTQ1xGMrsBH28Xmt15jjKkF1hstBgXWVaVUqJGHO3rQFMHVIVOaVPdYOwwGD9DSgaY2qvAftqwYU0yvJaEYQfIwEWKOEJQ/0k2stac8xwWV6PdUfBQ5cinL6yMt4Ef9lVd9CU1nx4rPR76UGWFRwwVWq61Y0FsM8juM6CArnV8ZsWHZ/j1BBe1ARKVun33cQsX2jAhOfGg6dAG/UkF6aUyYuOgC8dmIQBzz1sCzzpodHYGAj6JlCUQyZQIn8ZTHao8RhyK9dDj4M+tR/UPAU8GGISxp6h0RfmdOeOdRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA3PR11MB8048.namprd11.prod.outlook.com (2603:10b6:806:2fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 04:00:52 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 04:00:52 +0000
Message-ID: <db40a3c0-b73f-4869-a164-34c84112a424@intel.com>
Date: Fri, 21 Mar 2025 12:06:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/18] iommu: Introduce a replace API for device pasid
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-3-yi.l.liu@intel.com> <Z9xPaGV8f7Nr1HGd@Asurada-Nvidia>
 <86dfbb2d-18d1-4f72-876a-edc131a8f47a@intel.com>
 <Z9zbS8u5XDTgefOr@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z9zbS8u5XDTgefOr@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA3PR11MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: a4368022-3270-48ad-aff3-08dd682cf8f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUV2V0ZwM0VETmRGVFBZWTBEQXRqMXdWTTl4YmUrdkVJMzhVWjk2dndxL1hC?=
 =?utf-8?B?eGhtWmM5ZkFaWEtmc3pZS3BCUzdXeGdtUDlobnV3QkxwMFJnMFFlc1VrWXJh?=
 =?utf-8?B?MFhTVERFbmJyMFRaWFFGNTNEK0NveTBFcExWcWJkVEZYanlFcVJrZmwrbTNX?=
 =?utf-8?B?SUhTRHFhUTBNVktHaHYvWWE5ZW1yWVVMZnViR05sTXVhMTRTV0o1TDBCcmxh?=
 =?utf-8?B?SmI0Vy9CYjUyMlFGVERPNjJrVzJldXVoOXJwMEg0Q29uUkFOWVZzeEpsejdQ?=
 =?utf-8?B?SEg3SXE3VVNnQkpuZDcxRUxCSXB6UnEyMkFRRjYzbzBHSkQ1UGVBQmZtazk1?=
 =?utf-8?B?UVlhclB0TGVKMjRYemVZZTRnaVp4SUpINVhMeCszWUNtV2x2MWUraFFoeENy?=
 =?utf-8?B?TFdva1IvVnR0WXBQcUE3UzVrTFQ0ang0MGh2UTFvbTI5TkVqYjZkUFVsbFBS?=
 =?utf-8?B?ZmRHTHhFQ2svbDI4WWVxTEdVMUp3eXNhdU1BT3dVc2IzMkJ0OWhhU0dRZTZS?=
 =?utf-8?B?VFgzZit3UnMvTHVXTFNTcXBIanFwdGdneGwzOE5WTjg5K08yUDYzRWhyRkRB?=
 =?utf-8?B?RWZTVUsvK0JwVWNBbEZ1TFJHR1FMK3Q5enNJMU9VQ0dUTEIxeTF3eHUxbFp4?=
 =?utf-8?B?NVptS3dXOEx5a2RTVnUxY29LSkJEQkplem1MZ2hrNmVvMEU1RnhCUFp3bkFF?=
 =?utf-8?B?amdpSnlHZUJjVHQ2aEhDQmRXUk9kZ2JmblNpUGNOQnN6Tkoya09LcnEyMTJ4?=
 =?utf-8?B?SmtvdVZjdmh4MVhKVG04ZGtmS0gwZE1xK0t2Mnp1R002ZHR3Z0NJb0pIN0VJ?=
 =?utf-8?B?VzUxSU9IcEVQRFgrRDkwU0R5SE1mRHUrYnJSYUxaeE9rUjllREdhaU9uSldP?=
 =?utf-8?B?SGRUMTJGcmJrOHRZZDRjREZjM2ZYVU05QlBwaUZWREdBaHJqdy9kWkZKQW1m?=
 =?utf-8?B?U1ZHS3FGQlRRSWsycmhydVBLRzRPUTYxaVNHQ1dlSEIwR3JuZHhLdGRPVW9a?=
 =?utf-8?B?UjVXQ0lCMU40c2ZXWkUrVEhsRkp5N1FIUExTNEFlU1FMUGxsdFA1T2NCVS9s?=
 =?utf-8?B?K010UFd0enB1eTRkK0FhYTRtTlpBTFBNMkxZKzVtSUQ1aWhuL3RWdlgwdkpE?=
 =?utf-8?B?d3cycWQyYURSR3dqdzBSVlIzWG12QWlGWmhOQWRORk95MVBBdzE1SFlOMjZG?=
 =?utf-8?B?Y2dzVkhkWTFabUFIV2FmS05GR1VxT002MUxQQkNKbk9RekY1SURlVk9DaVpS?=
 =?utf-8?B?Q0V2cFpUTkhkVHBYRGwzWGk0T1h5TFNaQU1zcEIyK0NyQUJyTnE4SXVIbnRY?=
 =?utf-8?B?bDl1dTVUdS9ub2FJZnA4anRNVUk5NDFZd3NpU0NKU3hPem9rSERzckQxcUVQ?=
 =?utf-8?B?L25FUUhkMXZ2aTQzOFlSbUt5UUFxaHYybW9ZdXEzenEwTGNxRWlVeTZMU0JX?=
 =?utf-8?B?RnJLQyt1ektVck9KZE8ybytYVVhDcjYyNjVLcEQyQ1p5YVJMUTJ0RHZ6OGll?=
 =?utf-8?B?YTgrL0taOVNaSnBpT2p5VThCbUxiaDM5dS9ZZVI2ZUdJNXJCWEg0SkVvUzcx?=
 =?utf-8?B?UG9vVlRLTXdIb25aYjdsTDM0c0NGRm1KQVJrNEJjZm11R1k5aFB1WGxkZDJm?=
 =?utf-8?B?TTIrcHhOM1M2alQyajZPWjI0eEdPSWdyRCs4ejFMWklHSDhOOUlRaC9iUUdW?=
 =?utf-8?B?bGFpU25QaEoyV1lodnBQWnRtTGNHbXpPNGhxVkZtS3htYXdzNEx3VU5md25J?=
 =?utf-8?B?bUxNNGxOcUFmbG5RU3RuODhrc0oxeWEvY1kvZDNUdDMxWnh1ak1kRTgyTzdr?=
 =?utf-8?B?dzJhZFV5ZDZTZWpkanl5bkVXbEUrQ29rZFg5NHo5aGNiemVBTjV4amNOZEtl?=
 =?utf-8?Q?YN0ws9AnmX7t6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlAwdkZDV3FzYlMwKzRoTWdSZUxmOUNteUJRVnVRZUNkS2gxdzRrc0RoSkFK?=
 =?utf-8?B?VE5yY1M0dGMyRXZrcFpxUVVWQklVZGpvZWlwUi9LUWx2NjRLRVIwTHVBSnda?=
 =?utf-8?B?b3lGSWFCMHpKVXR3NStEWXg5Rjk1NjdxVEhhd0pHUG1mUVV2UXV5b1F4ZUNZ?=
 =?utf-8?B?c3hTbkZENjBqQ2RZcXFNVjAwNEl5U0xPUEVUbDVFUWp0aDBBRnhKRlMrdW10?=
 =?utf-8?B?QURIRDZFMFhBcVE0ZkRyOTVxZ2JVMXcwNTlBM1ZZa1dRd3pSNnJJbGtPZ2Qy?=
 =?utf-8?B?QjBmdUZnWWhGMTRhNllUM2kwSlpScFpId1Q0RnluWmJkaG1UZ3pCZjZuaVVF?=
 =?utf-8?B?cVRJZG5oQjE5RlhDLzhpVytPZU0rZFgyUU5Vd29XU2ozNEZyczh3SmJvQUdP?=
 =?utf-8?B?NGhqa2tyNks1RlRHU1Rib0drV29kY0J2QUk2YnhLUVpJNkVraFM4cGh3QVpL?=
 =?utf-8?B?OHQ4ZHYzOFMzZGhSSngxa3cwUWZSUXVQTkNSMU8wbm54NVR3N2ZMZ0M5bHY0?=
 =?utf-8?B?RENiMlVZeHA3bDRSVzNNMVBMNDl3OWpsOW91RzdlbFZoMkV3TERlMGtQRlJX?=
 =?utf-8?B?c3ZtODlSNzR3WG0vUk1vQTNtOTl6NTBKcGlyR0FwQVVPMDdIUTVTZkczYm5O?=
 =?utf-8?B?d3EvdDBhUW4vSU9rQ3JteHlYWkV3bUJTalllVHJpS0wzOElSR2NIS2RBTFhj?=
 =?utf-8?B?Si9rQ2dvZk0yQ2JCZkxnb3NhUGFxcWx5ZXlmZjZURUZIUnJzbkUvTkxsOGZX?=
 =?utf-8?B?ZExCQzdaZUxxN1pweWdQb3NncWM3cGFGTkdmVlBtQ01zb2RNdE5mM05JSkxx?=
 =?utf-8?B?V0RDK3RwcENweUhuTVFxOHFKUXRWQmxmN2dmNmt6K1pyMVhiUGhIL1dQK1BD?=
 =?utf-8?B?MXYwVFYzUDkwSFdrS25PMHNjVFBZU255Ui9xNlgzNjBzOXlnZk5tUk03RDl6?=
 =?utf-8?B?VkRxYzVXQ2RnZTg0S3pUR3Y1YkY2eTI4MWVJWjJtMk16bWExRC9GU0MveDU2?=
 =?utf-8?B?Zm5xeXAyRUdyazNIVmljZ2J5dEJzQ3QrQXlQVkJ0MFpkM2oxL08vK1hzSEJr?=
 =?utf-8?B?cE5mS0FDWTlvdHIzVkJXZ0JCV3llLzlqZ1Z1MHM4YmI2OEt5aVFtbXdjeThF?=
 =?utf-8?B?eUtYNjBUYlBUNWtjRkVRa2FyVDB5anRiMG8rR1BWUUczTCtIWVIxZVZ0K2Qr?=
 =?utf-8?B?ZGFLTWc5TXh4V3RJMHZrYUZBMkE5djI2dnRrYitweWNQVHhRajgwdzQzOVg5?=
 =?utf-8?B?RC9IUElrOHZqazFqVjJxaStWbkkwMHN3T2VRazFTdDlUcDlSazlYQU9JR1ov?=
 =?utf-8?B?YmE0YU5VdEhZNEJVM0szbTdEeDRwMlpoTFdSMUM1TCtreERGY0U2TnNndTM5?=
 =?utf-8?B?R2JKZHVTemFsNUFDNGZNaEdiYllod09nNkNqZWdqN0Z5UDlDdVpoSWpnQmh4?=
 =?utf-8?B?L1BJR3ZNcy8yN2lvU0ViTUV6MFY3djk3VnNUODFGM2I1M0FJdzBHK253WFN3?=
 =?utf-8?B?bW1OSitWam9Bd3kydHhleUdQeUJEbGtYbEdhbXd3VmxZUWEwbWdkZGJFQ1A1?=
 =?utf-8?B?elU5Ty8wTmdrejduQllKbWpyQ3BTYVMrQWdoUlNvR09Jamp5WlBCWitpWkxK?=
 =?utf-8?B?bEZiNElGemh3cXk2MEFsU1BRa0hHV28rbU5GYkNnQ0d1enhqUWRoc3hzZ1hx?=
 =?utf-8?B?S3RRZGVwOFU3SjBtME50SHJIMkFvNzRyNmF0QjBEYkRNMnA5UWUzaXZRdXJR?=
 =?utf-8?B?OTZPbDZGRkpuWUJtWnVyV3cycEdnbnlFaDVSdVJkSkIvQjNMTXRsSDU0eXBK?=
 =?utf-8?B?dHNKMEEydkVUaDh3a0Z3T3RRN2lrL3JLdktvbFdVN2taOXcydWpzQ3J5b0tT?=
 =?utf-8?B?OE9MWVBpSXQ0a0NHQ255U3lEZzdydUxyU2VueTFQU01rK2l0VklIS0dGVnRu?=
 =?utf-8?B?MVlTaEpEbVpmOUlYWWp2V3FqVlJZYWNMcDVldzRHUEM5dXV6Z3ZJSlZUamlI?=
 =?utf-8?B?K1FteWc2SWloVVA1dy9SRUljRis2YUE1VW9QUFBSWXVwSlRPblBCMlE0d0Qv?=
 =?utf-8?B?QXJ3RzNHdVB4cjFDTGptZVBjUUpxQnlHSW9kUnE4VHd6b3MwOVVNci9rSnF5?=
 =?utf-8?Q?nJr49R/yIas3LGP6hywQd2Uwl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4368022-3270-48ad-aff3-08dd682cf8f5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 04:00:52.4422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKHSwqFhhdy5WeAGgHgrLXRbAczuRP+Piu1kjJvRyaygqQjNkueer5T2TC5FEmB5GYrD6cbDVaiN64k8hGCwTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8048
X-OriginatorOrg: intel.com

On 2025/3/21 11:21, Nicolin Chen wrote:
> On Fri, Mar 21, 2025 at 07:58:51AM +0800, Yi Liu wrote:
>>>> +	entry = iommu_make_pasid_array_entry(domain, handle);
>>>> +	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
>>>> +			  XA_ZERO_ENTRY, GFP_KERNEL);
>>>> +	if (xa_is_err(curr)) {
>>>> +		ret = xa_err(curr);
>>>> +		goto out_unlock;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * No domain (with or without handle) attached, hence not
>>>> +	 * a replace case.
>>>> +	 */
>>>> +	if (!curr) {
>>>> +		xa_release(&group->pasid_array, pasid);
>>>> +		ret = -EINVAL;
>>>> +		goto out_unlock;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * Reusing handle is problematic as there are paths that refers
>>>> +	 * the handle without lock. To avoid race, reject the callers that
>>>> +	 * attempt it.
>>>> +	 */
>>>> +	if (handle && curr == entry) {
>>>> +		WARN_ON(1);
>>>> +		ret = -EINVAL;
>>>> +		goto out_unlock;
>>>> +	}
>>>
>>> We rejected !handle and !curr cases. So it should be enough with:
>>> 	if (curr == entry) {
>>> ?

hmmm. yes. I'm a bit struggled if we should allow null handle in this
API. There is really no caller doing it. To be aligned with the
attach API, it looks better to allow it then drop the !handle check

>> we only want to reject the case in which handle is valid and it is
>> the same with old handle. If handle is null, I think it is ok to have the
>> same domain.
> 
> But !handle is already rejected in the 3rd if validation:
> +	if (dev_iommu_ops(dev) != domain->owner ||
> +	    pasid == IOMMU_NO_PASID || !handle)
> +		return -EINVAL;
> 
> So, it can't be NULL at this line, right?

yes. depends on if we want to allow null handle for this API. My
gut feeling is to not allow it, then yes I can simplify the handle
reuse check.

-- 
Regards,
Yi Liu
