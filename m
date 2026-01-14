Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D652A2C0293
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404549; cv=fail; b=Qf27Tddk7mTYXXMReuyVkjAdvzc5xwWQdAO0p3GyfjHxLPF35L+btazg5aZ2NBQgQTe+P1lZDGVUDBqXF9L/wFLfRtzb5ENyi4RRW4HfQ3Dl/Gz2F+ZUiezOONaZuwULr0g1Pqxq0nm40I/fiFCXE/0mIqTlidv34MMu1WzWjBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404549; c=relaxed/simple;
	bh=bep3fni6xib+znbYVFyELyt9GV0NTlCsILy5gNtvf04=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BI9qB4cuR2kker69PEekxnaG7PR6QmFPdDBlS4bLNeqaRKXxPIznkdbJbcM+IdJFiRhMDrFoQYnPq3cBgxNfM4OITa2RBaF5gApbL71t9OjV3O4D2aBjgTX46wulBC0mNdbwUQsEdHs+iC+PIrkySK/OVOweAtyBVgF1nqPCooM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rUzNGPZU; arc=fail smtp.client-ip=52.101.46.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rUzNGPZU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RY8eDXfujHomUvPNL27hxJZ1kI6KbTpH9VkVci5+KzSatjNLJLnhVY7m2tch9k9GTugxf2+w+ScWbE14tV/iXmg9z7rcRMnXfrBiRuvsQUw9B/LOsqLi+bxQg3Mb25c4Y5cWUTkDyiOJLaozoHl+zZXqLlXk40u545UOkz5ifvAzCEyUL8Gps92r0NKPcyihoQV3emZtw7pRL4W7n7eWP6wQG0VyfBqwQ2482bjOYpQ7TdHbTBvqK4QiHixasZJ4rMxJQVOrf8JhzITEJq1Ima7HqyqZ2ffsN0axQ+9msEUXOaxKMTyrOXFq6MrRxUf6XK1djVaFXN3PzCZUbCs/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+DrL2n58XNkZlLF65nhDSlfLJ5Mk53rrtTpbOhf9Ko=;
 b=pHZNmPuDh200goqoyes0ZPutcAuP7gtFfh7iBABQNn16U32z1mGEwYmR8LYc1n5ej0o0/7jqnKhaWt6O6QKwwYa0YA6ebf5gVNQP8t1uCQWyzeU+P23tAQFOJpAz7mbSQtmYRHmh8gIdGEFSoxTZU8/TSK/ZMDPhb7s1k8XofHxkdvqgR86oLJgmcxOeeOM4ICHyVWO8PyqjHaMHuJbjFuJtJzc0TXqtJtOXp0egf8cr3FfPF1hAAGeLItci9WhSfSmJIyXgXVZKLBFMtXxKlQPJ1AZ44lAKeCsSPqcMwbIsY9M+9mgqcSQBof3qGGztuBQomIQ9qqrtRJvRW6KNVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+DrL2n58XNkZlLF65nhDSlfLJ5Mk53rrtTpbOhf9Ko=;
 b=rUzNGPZUqtRTvTmeDkZcc0q99NjvE02KcYfsaElNOyybpINevo6GRdui+Qt0r2lj0rKqyh8sD87OFMZrG6zB+Ka/hFGKqf2wxznTm93mrDWR23aWiXiSlAa4q3otvs4K/YIFu1YLecyX0kE95n1PVd2YyO0kRysvUKLMF5blAUvJcq0/SLMtqb77ksKzGU251TfVk48F1g6qbAgo5gUC7t48HfXkHocwK7vdWk/YurWMkVY+JtR9MXHLvqgRjXsVHa4rif+vWe1UMAQcF/Ts62vu+rWAUw7+QWtnp1rc9PNVsbAp2s9eRA6tFCcPq0HHK8lN1fsSHA0Lfqt/qf9XyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 15:29:03 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 15:29:03 +0000
Message-ID: <1de0eca2-2fa4-4625-88ae-58107621e021@nvidia.com>
Date: Wed, 14 Jan 2026 15:28:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 4/4] arm64: dts: nvidia: Add nodes for CMDQV
To: Ashish Mhetre <amhetre@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolinc@nvidia.com
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20260113054935.1945785-1-amhetre@nvidia.com>
 <20260113054935.1945785-5-amhetre@nvidia.com>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20260113054935.1945785-5-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:610:e5::21) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: b10647d5-b630-4987-00fc-08de5381a625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGZtL1FESGpaVVRFSU9xVW1ERnFMbzNaL0FTUS94cjZGTVZKbzNuaFlaeExm?=
 =?utf-8?B?V3A0U0YzM0JBdGExRXNEQnlmTU5PeW4yMTZoUmoxVi9lS01OcDU5eWhqd0xW?=
 =?utf-8?B?dU5qZ2V4K1h4RkNPS3Q2NFNIYkhtMmZ1UDNOZDB0TTdsMThCRDFCVEdXdHRT?=
 =?utf-8?B?QU5lUUNGNHpHSVIzY0lycTJYb0lVMjR5L09DMnp2SXRWTTFmTGd3UXZYZ2c4?=
 =?utf-8?B?RGV5ZnBJanVGdkQzZG11N3BBNk5USEZnUVpIOHVtKzJxNkdxS3NBenN2RWFZ?=
 =?utf-8?B?K2JhL1BoajVZQWhVS0hoSnlpa1FuY3JLMDF4ZGw5djhiMEFGNHc1UElMVW9l?=
 =?utf-8?B?MGlzejhZKzI3KzBJb1lwbUR0MlRVU1JQUjROVnhHaWovZTZWVFYrUXFXeGUy?=
 =?utf-8?B?TmhjSXE3d0VsWXZVd3JyT215MzE3M0JQSUZ4dE83R1NnbjA5Wm1yaGg0UktZ?=
 =?utf-8?B?Wi9MOVgyNWtjTWt6OUl0RmE5ZWYxK3BxRUJOQS9YZmxaOXhqZkxCVnI1RkZB?=
 =?utf-8?B?WW00NG0vWm9JY2FXbURqWGIwNnhBeGh3MU1OYmpxQzZ0d3ZkZlA4YTE0bUxj?=
 =?utf-8?B?ZFRaN2twOXNKYUtLeXpsZHBabUt0Z01ZczJESDNYUk5wdlJOVkVsT0NOREs1?=
 =?utf-8?B?QXRZMS96U1RsMzRkaFZmRTZNRitPekhKTWR3L3hTeUJOR3RHYjFKZXM2VW5W?=
 =?utf-8?B?L2NYSzRFUE03UzdMTHlTaGxQUVlWQ3hER0xRZHlPWWd6VlBQS3VjV1B3NVl2?=
 =?utf-8?B?aDQ2S0dHRW9MbmVjZnVPL292Q1N1MWNES1ZETWJNdGU3dzdFN1JJc1oyTkpY?=
 =?utf-8?B?blhFZ3MzUVhkRi9aRDJCR3BmTGVBcGhwY1ZFbTJOa1U4NGt6cm9GSEs4MXF3?=
 =?utf-8?B?dlhmV3FLTDJwMkxzK1JwV2VWR1crQVY4ZmRWRmcvUW5UTDNiakNyakpTOEEx?=
 =?utf-8?B?TjYrYVRRdkoxYWxybEpnVWpKSEFsMmU4TldCc3JpUEw3NG5XY1l2R2s5bHVu?=
 =?utf-8?B?ZGZzVlpwWW0yMEtkRFlPU1JSTTlFaFplQUJaNk02UEdNZWdUdEdzdG1uVits?=
 =?utf-8?B?MHFsWEpTcERvb2Mxb1BOOElNdmlWS0xYdTNRU1VSdVpGd3lXQUgyRHdTWjUr?=
 =?utf-8?B?M3MwYXc4akw5MnYrUU1jbFJ1OXZBYmZKMmJHaVRvTU1SYWVZWUNWa0RETC9M?=
 =?utf-8?B?VVhVYlhWSU4xMzNlSFlkYWlvVGk0Nkp3am9WV3ZFaTdScVY1dmJiVUxadFRl?=
 =?utf-8?B?RnRnQW4yS0M5Wk1NL3ZHNktPdmYxUUgwaU1PVWpJTlhwT0FhK1lrS2p1RXlO?=
 =?utf-8?B?aUU2U1NUeXYwYkVlUVBXNEx3QXhSclN0SWdmS0pYc3lTbjgydTVHZFAvSm9U?=
 =?utf-8?B?ZEJlOUFoeGF4WVpsUEdBREt6Tk1WaHI1cWM3OThvWFgrbW0zb251T2g2OWFj?=
 =?utf-8?B?UzhoZGV0UG5sMGpkcjBFbmY3Vm5aVTM3bHpaYU5udFpiY3VlNGozMmFhMTVy?=
 =?utf-8?B?NU1sRGhTM0JhSW1GSjhKdERYWjR6ZGl1UTBFVGVOUk04U0xHbFA5T1lxMzdB?=
 =?utf-8?B?UEl0bWF5YWRwTjR6cGhRaWFidmI5cWcwTldnMjBrUWw4eTZSTlZiRTV1ZVEv?=
 =?utf-8?B?WmN3M0Y2K1ZIZ3dLNzJJallZVktQMkxLbGNVbnR6WVVPdGF3SXo1Wm13UmtZ?=
 =?utf-8?B?ZWtjUHFiRXNJcWFNaXVNYnBVbzMzV0Q5YzU5T0M2NmNKTi9OYnh6Vk1QTi91?=
 =?utf-8?B?czlCdlU2ZEVUbjMyaDlTWTNpNE45TStaaEtteE9ZYzFhTlNpdXliRUJHRXY2?=
 =?utf-8?B?c3Vva1hzY0FxQ21wcDdlZkszYmxBWDVxRHhiQmkzTGxMRVpmRE9EVzZWU2wv?=
 =?utf-8?B?MWt2S0VIS29sU2dwbU5lRGkvYkNHUVQ5YjFJdEN5YlNuLzZOVlFEbmphWW9k?=
 =?utf-8?B?WGxCbXpqenoySDlzRlNrQkdGUWFXWktNVmdVNEhDTnJUK3JTV0k2UytLd1ZL?=
 =?utf-8?B?bDBEWHZkVkdZSGlaUWVhVStCZHNKOWo4ckwvV0RjMlFxaVQ4RjgxYTJWcGtD?=
 =?utf-8?B?QkxQM1RxWnR4SG4rMXBkQXE4OG9FODJpMm5raUkyaW5IRnJEZjhRcUI4S0dN?=
 =?utf-8?Q?dBZ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHZIQUVTMTRySkhjbFFmVWRlZVZ3ejhIU1NRYTIwRVZ1V21CcTJ4YWZvelNw?=
 =?utf-8?B?Z2NaQi8wbGdEdTNEUWI1OUZWSE5CSnV6dGozWGZTUjFpbVhXb2tDd3g0REl0?=
 =?utf-8?B?TUFqOCtscmdVQTVEd2Y5RXVDazJ0WWMwSWpWTkxrZkJEVDdnRGRIaXVvaDgv?=
 =?utf-8?B?ZnpRMWw0ZWVPdVVZMFVEVmlDSVM5ZVU3VG5hSWJubFBxYnhoQWtuQ2VpWnUw?=
 =?utf-8?B?T1l5Yk96bk5LeUlmNGh0ejNJVG5WUEZHVkt3eGtIdEhNRjk5eERZM0Zmam5Q?=
 =?utf-8?B?T25tZm1KVCtKVFA4ZXcxbG1qeEZpb0NhTkJQVVkvZmJYeEZ0dW15SXZkLzI2?=
 =?utf-8?B?YVc0TlUyOW5sZ1RZZDFobzhWR2xGRjRMeXlwZW1PRHo3QUU3dC9wQU1NQ2R3?=
 =?utf-8?B?QXBIRkZvTkcxbXBXYVNTNlFldzlURE52YXI5ZVBWTEhyYkZBVWFzcEtpajdJ?=
 =?utf-8?B?YndKUjVEZDhocGkrbFgveXRrWk9BM0Z0MkozN1UzaVkxY3BvblNacDduR0Fs?=
 =?utf-8?B?b2V2QWVHUEtZZnZaa3NEbnFLRjhXd01peXh0M0JteWw5NFdqZDR5UzRhcGJ6?=
 =?utf-8?B?S1VJYmpUZ2FGSjJhSTNTbWZMQURrRmVDSlZSNzBvYSthazUwS3Z5bTEyZDIv?=
 =?utf-8?B?cjNMOVB5dytUZTBTdDVlSFNjS1cxNVI0ZnlDcU9JemNxVHo4dkZrZG81NkZr?=
 =?utf-8?B?Rmo3dXBJdldhNE80eGhYTGdTRHN5cVVKbUU0cCtFdGFQTFIxa0ZtSjNoV2ZG?=
 =?utf-8?B?eWZ6TllJbUwyVkw3cFRpV1JpMkNnYS8rV2ZlL0MwUDQxZ2RkTi9DZEFTNjdJ?=
 =?utf-8?B?Sld4eHAwbm9Vc016Y1lGVWhzc0xyVW5haURGYlVYeTF6OFpYUk0rT1pYVFQ5?=
 =?utf-8?B?MW95NzFvenBPVmRuNVJNcVJWc0JjeWQxT2VGYVNQUHVNcW1qeHRzcTVPbml6?=
 =?utf-8?B?R1VsMWdhS3BlOVZBTnBwenkrbHo4VHJFSjZ0Vm9xU2ptUFZ3Y1pzM1pqZFB3?=
 =?utf-8?B?bGpnNWtsVTlvSHBmMmtZRzVQSWIxN3g2WVM4T21ucEY2SXlzUTVjV3k0cVBi?=
 =?utf-8?B?K1MwZlNDMWhRL1RXWWVZM0ZGMFBuUldwZHpPV28zRmk2WC9LZ1pCa01NNkFD?=
 =?utf-8?B?Z2VwRVZGRGpaVmlYKzZNMkZxTzBSdVlYaC9JU29tS3ZGU3Z1ZWI5ZlFja0FK?=
 =?utf-8?B?eWNweDhJbGhUeG05QXBMSGtEcWJ4enVXaXh1SDB6NzRPSDN4NE1XU3U3Qm05?=
 =?utf-8?B?ZWloOEp1NGU2N25sMlhlS0tFR0JBcENyOFNlT1hFbG9icXJZT0JjYWYzaW5B?=
 =?utf-8?B?ZDVEbE42S2pRRDdoUnBteUpIMW5QWXJXbEJPTkJWbTdnWGVBa2N6b1BqdUxn?=
 =?utf-8?B?dHJnTW00OVVTQzBNZEVlelZYUmJZVDJTUUtJNHFKamZkUnE1VUlGZTY5Z1Fm?=
 =?utf-8?B?TEhCb3lROFZlRkpZNnJteGIyNHZjdnI3SXdlVFQrVTJ1b09oTXA5dEFvczVr?=
 =?utf-8?B?Wk1mZjBkQThIdmxCUExGNEFYSVNtQjNWMnFFNCswNkh2b0ppdGM1S2kvWmlq?=
 =?utf-8?B?QW9EbmhFQU5iQkN3YlV6a2doZ2RNeHhGUHJ2TVZYRHNYK1RkUDltZ2IvSUpF?=
 =?utf-8?B?NzlHb2FYR0VFd1ZQcDdhNjdOTEhDR1JweTRIMnNSendlOEZrQ2tJTXNQa21a?=
 =?utf-8?B?R1NNcTFWa3BldUZ6VURGNFFOTHJKd1l5eVZnMDZNTU91VGdSU0pnT1pzMkxK?=
 =?utf-8?B?QlJuUWlCN0RHWXMxVHJDY1gvSlkrdERWRjBHVEtKcDd3WVIyUzBtcVNoUDZu?=
 =?utf-8?B?enFyTFNxNzNET1B2MkNBU0p2aHFGYW9PcTRXMGpEMkNOdkFsUG9HeTdGN2ln?=
 =?utf-8?B?S0tJVXhJWSs0RmpTMWlCcmNVQjFYZG9mVUJ2N2JyNEJlLzBmQmgycFBlSW54?=
 =?utf-8?B?VndYZWRpYnhEUEZ0MkNkeWlsbWRXUUR5WXhBWWE3NU1Qc0cwU2Y4QStzK1R2?=
 =?utf-8?B?ZCtFOGdDa0JNOFlOeHc2RHpVWm43blZ2cVV1YlBBWjF4Wnd6dEJKY3BZOGRt?=
 =?utf-8?B?SkZiMDZZVWJWd3hFamRaN1UvYm1TYjAzaXUzUFYwMVdPeDZBOTFxNjFXZzV4?=
 =?utf-8?B?UHdWRU41Wmo1d0dYZi9VQnM2dUlrVXVqT0VxSUZhZ2htcGdrMFRzRHNoRCtH?=
 =?utf-8?B?T2RUeWRuSUNjeEtFekR6MTdYMjQ2S2ZTa3lpRWZjd0U2Z0s5ZXk5V2QrN1Jz?=
 =?utf-8?B?NWZuZ1J1bDBGQmd0dXBDeVdWSExWWHhpOWNLRWdtQUJodjVKaVlYMVMyU0Uv?=
 =?utf-8?B?NCszeXpzOWxNYkdUYytrTlB5RGdYeXl2MnhJb1ZqaUVoZjlPYzVtbk9rU3Fz?=
 =?utf-8?Q?MoNIEGSFkDEN/GaB27ImPUZaKVnww6vUmA2AeXFM+yUYu?=
X-MS-Exchange-AntiSpam-MessageData-1: 1ZgFryuIBYTwRQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10647d5-b630-4987-00fc-08de5381a625
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:29:03.7568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fB7wzIeaMwL9h+xxT9vnaITktzKaaGRxXPvV4bc2jYbwlYj4LqR7cWE4A6XfsMtm9qPCEC4KoG3YVD0Cy6XBgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367


On 13/01/2026 05:49, Ashish Mhetre wrote:

The subject prefix should be "arm64: tegra:". See git log. So may be ...

"arm64: tegra: Add CMDQV nodes for Tegra264"


> The Command Queue Virtualization (CMDQV) hardware is part of the
> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
> virtualizing the command queue for the SMMU.
> 
> Update SMMU compatible strings to use nvidia,tegra264-smmu to enable
> CMDQV support. Add device tree nodes for the CMDQV hardware and enable
> them on the tegra264-p3834 platform where SMMUs are enabled. Each SMMU
> instance is paired with its corresponding CMDQV instance via the
> nvidia,cmdqv property.
> 
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Acked-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>

My reviewed-by should come after your s-o-b.

Thierry may be able to fix these when applying so don't resend unless 
Thierry wants you to.

Jon

-- 
nvpublic

