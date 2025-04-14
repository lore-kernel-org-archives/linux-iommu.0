Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0446227EC89
	for <iommu@lists.linux.dev>; Mon, 14 Apr 2025 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630621; cv=fail; b=elJVA8yObbSpruq1t4jn194BCYtuiV92eYr0PiKWEej3wi8rpVrUAbUgVyrXo/RzgpFA7+kdUzjtYJI3FAXBQkiZE9f4PzwoArkf/hBcRpkDOdwSGyd9dxAuEO2ha3YNFLfJa6PaJD68JNR9Xkdd7TnkuKcx0+bl1ZrMSWx7iOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630621; c=relaxed/simple;
	bh=ijF7VYrvX4WiNVG+XgHcfh+rof9BhsHX3ByO1gAWZSQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ItynsVSY4mfAapl6DrcPGrQ3gsvfFJuq6Lky+n/SU6viM9QEzYUqHjvYqcTBbmvyUu5WVjoMRlzZFqZPNo0uuqTLjKwabruqDUnL85wAaPx76OWkoPqZK2CBFoo43GYUoaBer+xZKMA9B+76nwCWw9K7s18tEz3if27jXHmAUgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZVYD3eQs; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZVYD3eQs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EfPAamtKqYbd9Qg7eEJbhAnWGduY48btdI2RMONscuUhUIohugTJC7OwhIZDGaWnD0BaNte1GVqYNYf9vYfPGGEjZvOBglo3sHl3fpmTWR5cIiGv0vdI4FaBfwgpf4UjuL8yPkF+VADbi60dFHxOtrg1DaA4Nyy0kRrM7UHvRstfsxERUgtCIcdV1ide4KHPzNnGUjFx8OH93S3MKKtvrynvkePv+rI/jsr2J/qXRLAUE8Q5Vsg7fKqv/gmIMZezqvt3ZrwoIWwYuidN5GJ8cSl1ivmtHcqMQxxQR0K002UsQZFql60yz7LwYjd1vrLkmK03jNR+tnvrdnuz4xSYyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Acr7a4lcVvnWFkVGbN/LKrYiUcRCwY50oFjYQ4PCc3U=;
 b=GuwZmO3XlDlo8xV4e+wZDsBEraP/601RsSN3ZMb/AHaeOg84S5TMA3EylGTa5wfr2QjnH2np9dHWYQL8+HLK5L8CTVH0nIdhx0d2Y+659LEl9V3+W+GHa03lYB9IZr79fX9GChoSUaZZPiWphWka3vrUDMjOKqhWx/0WnmDOR4za3CZIuhAz+bsmGIpjr02vhZwTJjMvNq9LF1Z/HlGzG4Nyw7Jiqk7PebDYaFvx6jHYqu7tu2mMV6nlGuGJUqYKbeQBulXOz2WVt/tTM9N3J7Qcn6WKKqXhtPTYMTPTQfilEI8oECt7KI3AiHAaPaasYd7LVbg1zaBp/jDVsqnR9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Acr7a4lcVvnWFkVGbN/LKrYiUcRCwY50oFjYQ4PCc3U=;
 b=ZVYD3eQs7rtqYY/1kk4jLy2Um60VyRYfu/nAyNagPMq5HDraoDC8MKafPi43nzhS2rimhYaOpxhUhfMHH+soTU3PE5ct+lQzFVh52S986gXlZnTzjAdftabLYgch7lo2rzVoUMkx5qqgdTXAj591RF4v6vp54HvlDWKe/xEcAurPmDJ9QDG2e+lQVjXbx7scOxGda/Q7/Uwa6yWSmA5ZyOxovEzTUy3yEgZZ0QErCJoxo2Ni5MZ1P2ro6uh8LvKVhCjEmFXnypyuvQd3K6n9a5WAiDs/WkSjkuurHKOjUVqFgbgm3BUB3UkpDW/BhwfRTRFiNZfYXxnEY2BZj2eZIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 11:36:56 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%6]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 11:36:56 +0000
Message-ID: <f909b34f-784c-4439-928a-fe00ac34fb35@nvidia.com>
Date: Mon, 14 Apr 2025 21:36:51 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma/mapping.c: dev_dbg support for dma_addressing_limited
To: Christoph Hellwig <hch@infradead.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Bert Karwatzki <spasswolf@web.de>
References: <20250414110647.3294017-1-balbirs@nvidia.com>
 <Z_zuL6tIjeTLTNKK@infradead.org>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <Z_zuL6tIjeTLTNKK@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:a03:114::19) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ab504f-ab77-4ce5-ee56-08dd7b48a917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amt4Z2NRRk5ZU2dodExRRmJmNk5YZ0VqL1IvcTlBb2FpamFBQUt3ZCt2YTFW?=
 =?utf-8?B?SnVOclZFN3hxYThOMGpybWFvcDJTSWNTamJJUnJNOE80Z2lYKy9zOTE4c0Jr?=
 =?utf-8?B?Y0FxcVlrRUtLaGtweEFMRUNveEVObDhQNEJFU1c0aU42QjRqdnZ0UDFwek5o?=
 =?utf-8?B?OE1lenhZS1JSQ05sVDY2eGcvZXJubnIzVFNkbWF3blVOSUthcWlONzIxZ2x0?=
 =?utf-8?B?dFhCUlp1NmJrbXU3UzMyeDYwa0F1WWxLQXZyYXozaTdnUXV4cE5SeVBZZ2Mx?=
 =?utf-8?B?blB1R2g1UjQyS3pjQlVTbVpaNmdvQjZRQzNOT1JKeDUxalZFdVA0V25UL1pZ?=
 =?utf-8?B?SEhGRzRGOUF4NXpkMVRJQ3JqVzNRTG1EYVFkTnpxUW9YNE1rUjVLL0dacC9Z?=
 =?utf-8?B?YWx4dTJVbUlmcitOVUtzTllOd2VRYVZMMGtTUVhZOU53cGdsOWU3T2lFRjFn?=
 =?utf-8?B?K0t2YTk2QjZoZERNS2h5OUpUR2pCR3B2YnpJTmxNdlhMMUt6V2xjcDdCRGdi?=
 =?utf-8?B?Z2NyMWYwR1BHUXgzejNuVlVvRzNvbHJjdHUvTUZMUzNva0RMSTFYWDUxUHNG?=
 =?utf-8?B?RVVXSlVQRG4xR1U0TmxVRlBqTDhLU3FGK2hGUjIweUpNanVITm0zVXpRdUFR?=
 =?utf-8?B?czFBRHpCTFRzSHhmTkN6RUdJMHh6WHFFSG1yOGRsMGJMTU1SNUp1c09WZ3h1?=
 =?utf-8?B?MlNwWjRYaWJIU3R3clVYTVpHMUJ2aG5QYUwwR1hLMlZTbFJLZDRoNmZMNnhU?=
 =?utf-8?B?NURhczYzTHdOUDhDck1MenV1VE9sV1BuLzR6ekZMeWIyd2I2OXdWQlVOT1BQ?=
 =?utf-8?B?aWZYNG9tVGpzNFVBVFZjM3htK1RLNkZQTmVpVVN5K0FzR2N0QlJYUm8zZnF4?=
 =?utf-8?B?ZUdmTlhjbm8vOXh6R20xaGxVd0pvSFdDMTNCcHFjTll2REpBWkR2ZkpXdXdh?=
 =?utf-8?B?cG40SnlQRVp0MCtvSTFmRHZGZ3IvZU1NdS9NWXZCZXZxcEtQRFc5bXcyNHh3?=
 =?utf-8?B?MlpnLzNWZ2dLSXFJTEJFSEZqSTBTRzBsdmdRWkdkNVBLUFI0b0xhZjRJM0FC?=
 =?utf-8?B?NThvVE9tUHlXOTZUTFlpSG45WHFmeldtSWEyeXNTcDlWYW1VOFIycFZNeUZP?=
 =?utf-8?B?eEh5dHFralBxTWRPUXJEaVZLVXFrY3RCQWNTRlFyUy9wWkxKTkNZUGNqVjJO?=
 =?utf-8?B?VDNDS1liTEM5ZmJtQWxVOWJvak84RnIraHpsWDN3RjFuSDVNMlVaZmNUNUtx?=
 =?utf-8?B?ZC9OMXlrSExvN3JOSW9kWHB6SEUwY0RUVncvTnhGdUFvWks2MmFvQk5yaWZO?=
 =?utf-8?B?K0tPcjJKNldxeFVFOVRaaGw5UGhZakUvQURjT0pyZ3VvT2xlTW1COUFrNng4?=
 =?utf-8?B?VVpKREFSUG9weWxGV1Rud2VaaTZvcDhUalVEbllnQlEraS94ZG4xYlJzZm1n?=
 =?utf-8?B?c1JBWGU2NmFJZDBScXB4QW1FVWJka3JSTkF1Tlk5MDVJalB5QnBsNHVVVjFo?=
 =?utf-8?B?R2k5Y0ZjcG5WMXFXNXRGbnZIZmJlelFBbWY4UFNrb3Ztb1NTOEZWR1NHYWpE?=
 =?utf-8?B?YkhEaFF4R3hLcTZGM0tiM0tpN0FuQmZibTMzRmZIR2V6WHJ4ZnV2UEUvdjJx?=
 =?utf-8?B?VS90N1dlQUNlRjREOVo1dGpsYTdBcVhMRGdWT2V3VndUd3B6ZncrWTFhcy9u?=
 =?utf-8?B?Nm41WkhpdTh2NUxyNFNwMWE1bGd2MW1aWGJMRWxzM0pYd2dvdThCVFY4blpL?=
 =?utf-8?B?L3RQZlhlbXp6OFBBVnhuNnRLTURydjdEQ3gzelFvVVdNWE5yOEJxYVZqT05F?=
 =?utf-8?B?cGM1K0hobU1zVmR0S1I0QldFQ2lsMkpIMTkyMm9wUlRhc1pXOVdQMDRQN1Fm?=
 =?utf-8?B?QUhWUUZ6THBydlB0ZXlBSUFvYjJibUN6Zks3Y0FwbHF3SDFiN1lQVGlDbUpF?=
 =?utf-8?Q?A/krd/QOLgk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWcyTDh1NXl4eVlmdkVZUXFSbVRRUGFKS3JLVkxxOG5XNDJ5ZmlpVGhWTWxR?=
 =?utf-8?B?MGgzQ2s5TlIxMFRmcDFreVRsRXI5YVJ1MDBUNjhDSHNQbFh5dUFQUkZyQW91?=
 =?utf-8?B?UHF4QUNLTUE0QWxiWElZMVN4czNUQlVXWlcwempqRHlqY21QNmpueXN4L1J2?=
 =?utf-8?B?UlpESEpPcG8zWllzR1FWTk1FV1U0QThPTGJMY25qNFhsTHhjaVhZVmdxQVNH?=
 =?utf-8?B?Mnp6NVZmcC9LcmZZcVBhSzlMa3Z6RER5SXhCMEtRSCsvdUlBN2Z0MG4zRXZ0?=
 =?utf-8?B?SCt4UCtaRnE5TGtaeVY1ZTZSakNPa2ZiNEJaMitFeVBHd1JRbXp4Zm1sUndS?=
 =?utf-8?B?WnZybk5BZlgrMlVwOHdSYUNYellQR1FIcng4MFBYckFTMGFUSGp6RElHYkVH?=
 =?utf-8?B?SENYSWZ1TEZrbmNKbGp0QUx4UlR6ZVdtSWh6YmRUSUNlMENzZUZPSUYvWDY3?=
 =?utf-8?B?ZEhMZkJpQktrd1d6WEx0VGhXUzNKbnBhOUtndWVVUXJ6VGZvR0xyQnBhUWtl?=
 =?utf-8?B?KzR3Y200NEpDdzRmd2JBQWdMd1lGWlVTdkpvT3VnbktBdkpzRDhNVzJJYVRw?=
 =?utf-8?B?Y2JRUjJLNGJEL09oMmdXR3dPK1dRZExJRHF1Y3RUQ2hRdS9MVmhILzJJdS8y?=
 =?utf-8?B?UHp6blZndFE4M0x4YUlFWStRM0pqVnNHMjFBWmp3bWdhTzhocFMreXpRa3A4?=
 =?utf-8?B?MGo5d0EvbE0vRWpLVENHT2NsWHhTeU83bUd4c1kweVp6R2ZSbWZWY29RUkYz?=
 =?utf-8?B?VGdmdVhKaEcxQk9scElxRy82OW1aWHZoS3NVakZud3cxSlNKQUZTbjVQc2Uw?=
 =?utf-8?B?RWx4eEpIazdpRmRDdkpzdzJEOTNnMUZ2N3AwRjl6dzEzWW92YXlFWVhsZjhV?=
 =?utf-8?B?UHlNV0dCL1B5VXYwNGNMSHlxRnFVek9MV1hqQ0gwbmJ2bVg2L2laQk8vM1ZY?=
 =?utf-8?B?QjJsZGJIaHkwK2FGQXhmNW1FaS95ZFB3QWNtZWgvK1BHY29taGFvN3duaVE4?=
 =?utf-8?B?UDM4a3phcmtFNnd0cThGVG1Ca0JURWpHU1NBSHZpWlIrTFAxbE9mTTNDTmU3?=
 =?utf-8?B?ZUpmSGhpZXJEZTJNTERmRGxaRmg0SjhvUGZYNWZMT3hQb1NzTzBDMmVyL0ll?=
 =?utf-8?B?Z1E4SDlDYUZqLzVrMHQ3V1Y3MzVCY3JNUXp5WUp0c2N1OXNoVE9yRGJlRmVI?=
 =?utf-8?B?QVVORXd1blJiVFlWVVl5YUF2VnA3bGpHYW1LMlphNDg0OGo0Ym91QjFNbFQv?=
 =?utf-8?B?b3czS3dHNk4xRVVhSDJrQU84RVZvSjJ6bGlBVklDOXBRL3k2eWNJQWhKdVF2?=
 =?utf-8?B?bDZVbDh0emt1L3J0U0VvaWRPNGhjUFJkYklEQ0szSWduNTZseHJUNDBCSjcx?=
 =?utf-8?B?VUJneGNjcGx1b0dzKzdsbFIyalFkYTkwM05kbG0wOXNJVXBISi9wK0RLRVo5?=
 =?utf-8?B?MDd6Ukd1MzQvS29EM2FPZU5VSTJRcS83WFo4ZkdJRzNjTVZzcnRHUkdqaXcr?=
 =?utf-8?B?Y0tOUUxGamZ6cWF6OTRhbXh1Z3VjYWR0YzNBWlZmS1ZhcGdMczdpSmc0a2ty?=
 =?utf-8?B?YTh2QWtsaU9CYmQwbTZYeDJMeXZqUGNzekRhbWFTYUtQcU1XRXFhTTluWjhy?=
 =?utf-8?B?VnFMNUNnRnJuTTdPOXZyNE5rYUZVZm9MVjhVNDByWXVtRTZKM3JRQS8yeU5T?=
 =?utf-8?B?Uzk0MldhRlB4czhabUxuYm1SR3RzTVJVTVM0VW1QYXlvZXJGd1VUQlFxVjJ6?=
 =?utf-8?B?K21BVUlVTldDU3Y0NkF3K0lGdVFQWmRoQkN0Y25IZmw5ck5IRWVycEZodzJl?=
 =?utf-8?B?cStObVp0bVI4cDRkbklRMWxWZm0ydDZnZ0Vyam5qQ20zNUQ3bHp4Q0FEY2pH?=
 =?utf-8?B?eUVPVFJBYUgzb3Z6LzU4Y3I5RkRNUERCUGZ0ZFhvRXpwYTA2TzdubHpQRDcw?=
 =?utf-8?B?QmJkMVR3djQ0YUYvVGZBMmhFR0Y5ZUJuK3BndFR6YzE4a1d4M1BhY252UXpJ?=
 =?utf-8?B?WTVSMEJKdDFIcklwOFpsT3ZQdTEvOWJ6WXNKUzRCemJUdllSRTFheFJwbjlj?=
 =?utf-8?B?UjJ1aitEYUNDYVpMa041eUw1TjY0Vko2MjdadkJmOFkzWEJRTlZoOXhYb3JN?=
 =?utf-8?Q?6Z5jaIAjiPw1f7xTXijvnKcbv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ab504f-ab77-4ce5-ee56-08dd7b48a917
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 11:36:56.2959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pn82LeTJhg1BTtR2fMrI5UyGkuExSkVyzvvieA7WZTvxpqwb5KlRJTiL6ybImGbaoDVnHbCzVHfqNeEp6h7qGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949

On 4/14/25 21:14, Christoph Hellwig wrote:
> On Mon, Apr 14, 2025 at 09:06:46PM +1000, Balbir Singh wrote:
>> +	dev_dbg(dev, "might have lower perf due to bounce buffering\n");
> 
> I don't think that's a good message.  Report the actual observation,
> i.e. "device is DMA addressing limited" and not a guessed conclusion.
> 

The bounce buffering remark came from the rest of the mention in code
and I agree the perf is based on my experience and may not be true
in all cases.

I'll respin

Balbir
