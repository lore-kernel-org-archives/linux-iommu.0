Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011012.outbound.protection.outlook.com [52.101.57.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D35E2F5A1E
	for <iommu@lists.linux.dev>; Mon, 20 Oct 2025 23:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761002261; cv=fail; b=HNH7sQArv8IeQrsfJxEqsFYjPS5tTbie4S7PcnbeVPMagdSJi3rrHajmfkLbR7rddo0/3BI35wMlITKChgioaKkTj/a5VNlbP2pJmcwaXqGjsGv4D5CTxILXV5j5Bbuo53NbQj1DWSDYW70vuAxQJjn1DWKyuTep5z4HOtrfR20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761002261; c=relaxed/simple;
	bh=uPujyYAivtuO/VUuMrGbqFxgCKmUMW/vxDTEvIe1jKk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q+wKOjdd+uJfNRR6r11yQLYkXyDZoYQBdpp6jWaPj8956OOiPnpb7bctYNnd/h8e5ENtqUSdUYWzUOqVRnapI4B8giTSwA2vAcOKYPW/NTVAlDCndli1jj4b/zq10lCcNLmtle7jMBhKfeGfn6Z3lfSEGHNia7v2VFxVDGTKEq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AEOM2qGH; arc=fail smtp.client-ip=52.101.57.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AEOM2qGH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkrzWkxezFjU0ZMXOEQ79CQwF1NOuT75/cOzqFIIQAHJVtgfYszwNMiqHcTGO9Sc2iTFAyLgZJYYjJghb+qXRXdz4eUU+t6z+mP3Wv0zRlNuLqrgGHYYYhyyfT7Nk6mBd8k98hpadDZz/E6yi8LhW19NuvWrjKHVUfdIaBP+XZuT/YbF97mv4tv7tYfdQfamLwOVwrKpWAZtayEL6qLYw7y9wNuRGg+KCSWs9IdUNkfPsEbDFjZEhhfzD3Baz4i3Gz2adeZDkMXzZcbYq1FwDYbqAd+lOqQOPwSQHKVt8Rc02hBGJsSxv6Jf8z6VSvbdWEpqcT4G47t2Q7j2Kux0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sbg2qSZYRdjBLTeqJN+kdK+1Qb3r5qjGRIZe6rmjMW0=;
 b=dt6/YS+uSqJEPUd+N2yWY6BZlL762uLqO7ZCovN66L2rgmkGqXVRBGhdMhnHyVZdMHxuxnH19kViVscGpx3cfqHs1nUEyT5iKu7D/flmfjX+usNi5ICN8ZoLZm6fUmorDhHa8aocFRu6dPYOvxC0dGg3CynJfB559S8P4k0UDy0StPqlIWK7LjA0pzsEWvwtYk/S0kAU5Z0mBY+w4IhOdpH+MHKNm8rEVgYCJZ79nDOw/vKsMSFWSka7p/9vB2W3sugxd0rYB8DczdfK2zXSmSTzFsTYC1Ryy4sQVQDkdss4nqDC9H0WcPn53EqLhupsQJ7Xn1xFZUuY3uIBwFi7jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sbg2qSZYRdjBLTeqJN+kdK+1Qb3r5qjGRIZe6rmjMW0=;
 b=AEOM2qGHJgF2Y/AtGNKF4qO1APnuR3hz+kDnYxUBK71uk3VjUaq3GIlm+F6PnB0vmU8x4qANqzZMjneafKrVqJuAzYmyIfaHr46H5YVt4xw1ps27HzNt45I6dHnkSnKRUJa6VlbVbR7Z/m310U2tXHDHWpULvEdm2elvTeDNPB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.16; Mon, 20 Oct 2025 23:17:34 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%6]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 23:17:33 +0000
Message-ID: <9792396a-ba1d-4d69-a24b-472609e08d1d@amd.com>
Date: Mon, 20 Oct 2025 18:17:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/15] iommu/amd: Add support for nested domain
 attach/detach
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
 will@kernel.org, joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jon.grimm@amd.com, prashanthpra@google.com,
 wvw@google.com, wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
 <20251009235755.4497-16-suravee.suthikulpanit@amd.com>
 <20251010232024.GP3901471@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20251010232024.GP3901471@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::28) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6db3fa-ebb4-45d0-ad00-08de102ed93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEZTTDR4b2F2dUZ2WmNLZGVDZlk2UHlFcHp1T2k4K00zRG1OR3BmTHN3b3F3?=
 =?utf-8?B?ZjJ4WnJ6U2Q5b1N5WU9sd20rYWRCRC9jZy83VVU5ZjlnV2NPb0tMYjhheFRT?=
 =?utf-8?B?eVBsWUhFUk9jMXRZRkVHbStnZks5ME1SNTBkaEgxL1l2c3dMVkZxUFZHblFp?=
 =?utf-8?B?Z3N4aXRMREJrd1FmR2lRQjVNMTFkdVkxR0EyNnIxenQrcEJoRitrV1JyU2pL?=
 =?utf-8?B?VEl6UjVHRFA2TmhNbC9IdytLZ3R3U1Z4UmpiRGlnTXN3UmdXUWxCYnlyb0Z6?=
 =?utf-8?B?NFU1a292cEtUdWsyYkJzdlFQeEZHblZlbmJJN3J4NGhBbE5xaUVlUThOWlha?=
 =?utf-8?B?ZldXZFNselRYeUtNZ01XL3kwdXRoY2I4SFBrZ09mYWpxUjROYVFlR0VRWkU4?=
 =?utf-8?B?Znp3VU1yYTdWRU5kTUd3OGFGdzA0Z0NmcnV0Nzk4NTBvN2JmWUNhM2hMbGJp?=
 =?utf-8?B?WUEzbE5hTTBycTd1TjhoekhPb1Y5SGI5RDNqN1VJaDFNeFpSb29UVi81UytU?=
 =?utf-8?B?R0NQNGZWd3c4NGEzdVhMcVZpODlKNlJlcVM2UWc5KzRCOW4wdS9uQWIxcEoy?=
 =?utf-8?B?dmcyQm93WWFZUjN2dW15bGF2dnFjSFZlZG1zekU5SXZPTis0NE5Ec1dBcFg2?=
 =?utf-8?B?TzVBWUtyTUVKNUpyWENkajk0N0VTRUpTMGlINzlWSW9yWHJHdHJxdEFjS2wz?=
 =?utf-8?B?MHA2OThmRkpJM3k5cmlFQVlQd0lNcGZXTVJjcFhwL094SUdIeHF3SVI2dmNs?=
 =?utf-8?B?MDl0YTFzZktzb01nQlpvYWVtY1RDOWljQndrN2dhZXpFcGMyUld3elNmOGtw?=
 =?utf-8?B?N0Z4T3Vud2x1bk4wRXpBSmg1WnlZSm5rT2RRbVduUlBubXNLNEdFZFRCbW9C?=
 =?utf-8?B?ZnQ1NUxZQmJlRllZNlRiMWJDVnh3ZHkxUWZMbHZ2QUNKdDN4eTl2TmRVR21D?=
 =?utf-8?B?anZHKy9zN285KzU1MnNiQkdlNzgwSmx3cW1KOGlWMzdTa29IZFl0S1AyelJv?=
 =?utf-8?B?cDhCYkYxbUp6TENQNDdFdHhYRGJVNTJPQWg0RlR3YWo3WmMvakRKQzN2VkVD?=
 =?utf-8?B?RVJPM1JPcENRcXR0Rm5PekQzbGdSaHRVQzJrMVRWaDdhR0Y1T0szSTdGQVZJ?=
 =?utf-8?B?TlpWQ3JjZU5ySzdxOEgyYnBFSmpoazBqZGpCTDRGMlZ6b3N3cDExdldLN3k1?=
 =?utf-8?B?UlRpZEJGM25ZTGczR3I1YVhTQklVNTJPbXRBbGJSSkQ0RmorM0xpTzdGNkxw?=
 =?utf-8?B?TjlZYW5IZGVtaEU5TEFZd2p6OHRIM3gyMUxuTS9PQTIxV2RPc3paTmR6ZEdo?=
 =?utf-8?B?Y0RNY0l2eUo0OEZZbVlwMERxN2hBKzJxbzlEaElZTkhaM1Q5U0lUK3hEcDVC?=
 =?utf-8?B?R0FaTGw2OS80eGJpNlQwbEFUdXRjamN4SlFGZEwrYjgwYnExTHZ5akVUQlRJ?=
 =?utf-8?B?V3doM3NrN05CZFNacmdibVZucVBUZ3RZSEVRYUlON2lzVVNIU3JUMHZWaURo?=
 =?utf-8?B?clFrMytoUUFJZjUyYjZoQ0gzT2wyRFlmMEtDR1VPQndIL1U4M0VSQmxiejhp?=
 =?utf-8?B?L0xvd3pSZlRHdGRVTGo1aXAxSVRrWGZHSXNRZVR5Mm0zakNqQ0RvSjNIaDBK?=
 =?utf-8?B?WWRrMWlwSTZYRFB5Ly9tUmRoYlZyOHppQ2czWk5SOTQwMGU3ekJxeXQ1bm9i?=
 =?utf-8?B?Z0YycU5IRjdKYWp1YXJPVFVtNENEdmlLSERnaE5KZjhLOEMwcnlwN1JpZVRF?=
 =?utf-8?B?dVQzMm9CSDR6N05zVXhHTUFZNlJwSWp1ZEdRaTY3K2p0WVhNeWF1QU1SeG9q?=
 =?utf-8?B?bko4VFNpUmlqbFdyOGk5Tm5VNDg3cXhqdEZRZGxMQm9JbkxnOEZiU3BQZWll?=
 =?utf-8?B?dW5qQWUwUkF4NTdjNkRPK0FlS2lNUFZoaDcvejlUbktCNS83LzFYR0JwTUJX?=
 =?utf-8?Q?h40ETcV2rEcVDzgm1SSh5/T3B6natHQE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU9QT3JFanJGdDdhb1dkeWVTMTI4aDh5WG13aHdYOEkxZHlOTlUrSFhiclBS?=
 =?utf-8?B?ZmJNZzRHWTBZVWxJV2NDYkV2QjNBZ1VpOW1QT1gveDgwZHhsTzNaeHYrYVBs?=
 =?utf-8?B?d3VVTHVTbjlLZTZpdkRrcGZmZmhHMExLcXJOLzFDRUJDSURIdzg2LzZUNGdQ?=
 =?utf-8?B?VTJYUUtlYVdNOUczWW9RbzQ4dDFxbDR5RHNvZ0VOc1lLWFhaUXNJRzJWN2FT?=
 =?utf-8?B?TjB2NitHWUxEN2ZmR0cwb0hHYWd3NFZCT3NlbnRJUENaRTFpekkxdTJrZUNo?=
 =?utf-8?B?b3EyalpZb1R0dzZ0YVljOW01N3hWNnM0WDVnYTMyMFpIMmpHRlF2a2ZKbGRz?=
 =?utf-8?B?RDV2R0tMYjh4STI2QnVRcDFBZmYyMmkrUnNoUmc4eE5aRmVpdVpxK0toRHEr?=
 =?utf-8?B?ZE4zL2RZS2hlSTFIMTNhNzVLbWFLb1ZaZmpILzRyaHpUcktLa215TnA1R3BM?=
 =?utf-8?B?NU5yTEEzKy80ZWVCRUNWUE1PMkJVU0JYcWN3V2JJTVIrU2lTVXhlR3IwZTE2?=
 =?utf-8?B?WExYNDA0Qk1QdXlrbysrNUo1NGpyYmdUOThYTDRqWEIvS1FucFQ4bldUMEUr?=
 =?utf-8?B?VXgxb3V3SHJ5N2xSVkJ6WW1uVWp1YzgzbnF2RUNLcWswNHpUN2U3WVdZSUd1?=
 =?utf-8?B?TFVIaVFpQ3kvRGNuL2lzclFhS1hDVnptbDM2QlpnUEJuaWNRR21iL0xUTklk?=
 =?utf-8?B?WVh4VW0xcm1EbkJtZGZqc3ZTSHhmVkFVdWV4Q1NqS0NCdlRmR3Zyb3BINERZ?=
 =?utf-8?B?V1RzaHM5dzh2bHViSmw2d0ErZWdDdTNJRGlPcTlUdGMvUDBrOGo2SzlZWXRa?=
 =?utf-8?B?SGdUcXdZM3ZrZXJzUWNXYzJiNkFMZkFFNitKSGRBaDA3ZksyWmZNTlJ0bUt6?=
 =?utf-8?B?c2VaUG42S0s5N0x3MElhdEtINzNEUjFyVWNnQlAwS3RVVDRWV2JIQWdYMWx6?=
 =?utf-8?B?ZkU5aVo2MWtRZXFYa0t2V0VWR1RyTTJKZ1NXWFl1MUg1ZVBTWDZPME1zekZP?=
 =?utf-8?B?SXp5Qmc2aFpOR0kzZC9Nc1Ywdzh1QWJXU3pIR21na1ZKT2VGYndGU01iNkZS?=
 =?utf-8?B?N2hHQkQyN3BrblA2K0l0S1ZJdk40ZUdMbnpYczhQMHozelNvM25ZVmpoRXJD?=
 =?utf-8?B?c2hnWjJvQ2lPVTJQSW1tbzRSZ2E4c0NjQzVWLzh3OFFpTURnMVZ1bCtpR3BI?=
 =?utf-8?B?ZjVQT1dhTGxXaXZabkZhMjNXK0c0TGh4TmFoOUliNGQvNFUvM2U3RSt5ckV4?=
 =?utf-8?B?TnBDdGdPcVZ1M2tscjlmVzduZ2J3azRPOG1veDlyVlA1cDl2SUNLaXVpREdH?=
 =?utf-8?B?bkllNldJNEJlQ1R1bEc1NXgrSXFKNThDY3lIaDZjaFFrcVM1YXdzSGpNK044?=
 =?utf-8?B?RzQ3cnZleXByeUx4OU9sTmFPanZKNlNuK2VIN1NSY25UUS94dmplVHNOTjlt?=
 =?utf-8?B?RHlXNTIvU3VpUU5UcnljUkdHZ1YxK25ZWkM5WjZwYm5aU1pZV0JFZnVkQXNS?=
 =?utf-8?B?c0tFWVI2ZTlqeWwvU1p6bTcvUlJFa1ZnOVR3cERMTzN1bUx4OVJtM2ZzbVkz?=
 =?utf-8?B?c1FsZHdZSW9mY2dVQUk2S0xDb0tDZHhtbUZHa2UrNXQ4ZHk2RzdIVGk4Vy8v?=
 =?utf-8?B?WlNXOUpnRG9XeEJCY0JjVzMvR1RDbnQ0ZGhrQWlJWHMwcy94L2VLcm9WSFk0?=
 =?utf-8?B?eVNybS94QjFJMnIwVSs1MVE3NUxpREp0OFhzeHR1YnY1TzM5Wnd3T0ZhSFhq?=
 =?utf-8?B?UjVHaE40ZU5xWklCM1lSaWFCL1NoeVk2Nm1SS2hDU2RJMTR2MzdxalNDQUY2?=
 =?utf-8?B?MUEwbHl1REpWcS9nUWc3NHRRU0diSnhST0hPNzRDY1hjRFFRL3pUL2RLbVUy?=
 =?utf-8?B?VXZIWWx2SW9uYXZJTXF2QXNMaEZkOXhoclJ0aTErMFU2SlBlZiszaUc0K21B?=
 =?utf-8?B?UDNsQWRvRS82NnozNnovdmdSVFJtZ0sxNzI0V0Q5dGJwUkZhZWwxRVVkT2t1?=
 =?utf-8?B?L1ZHRnRWa2kxbW5wRGNJNmNwTjBWNk1ML2F0NzJ6eHA4MFJkM1VOWTBQNHRw?=
 =?utf-8?B?TWQyaHA2cWtnMDhVNEVmOEpjSWp2YnJxOVpsUnFtVFlBQlVhSEp5SllrK2da?=
 =?utf-8?Q?7VBhqVPVFHbNXzLliVZsPeB0Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6db3fa-ebb4-45d0-ad00-08de102ed93b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 23:17:33.7076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjM19qa8znJxqIMRoaNbSxYfOevTWbMquTHftNtYS6/ZcpGgyq05wdsDqRySVt57bsirjn6Yg2yHbVZ6/2NHNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007



On 10/10/2025 6:20 PM, Jason Gunthorpe wrote:
> On Thu, Oct 09, 2025 at 11:57:55PM +0000, Suravee Suthikulpanit wrote:
>> Introduce set_dte_nested() to program guest translation settings in
>> the host DTE when attaches the nested domain to a device.
>> .....
>>
>> +static int nested_attach_device(struct iommu_domain *dom, struct device *dev)
>> +{
>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>> +	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
>> +	int ret = 0;
>> +
>> +	if (WARN_ON(dom->type != IOMMU_DOMAIN_NESTED))
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&dev_data->mutex);
>> +
>> +	/* Update device table entry */
>> +	set_dte_nested(iommu, dom, dev_data);
>> +	amd_iommu_device_flush_dte(dev_data);
>> +	amd_iommu_completion_wait(iommu);
>> +
>> +	mutex_unlock(&dev_data->mutex);
> 
> Where does the code record the ndom->id to push invalidates when the
> S2 is changed? Seems like an important thing to be missing!
> 
> Shouldn't all this attach related stuff be in here too??
> 
>          ret = pdom_attach_iommu(iommu, domain);
>          dev_data->domain = domain;
> 
>          spin_lock_irqsave(&domain->lock, flags);
>          list_add(&dev_data->list, &domain->dev_list);
>          spin_unlock_irqrestore(&domain->lock, flags);
> 
> At a bare minimum if the series is going to stop here then it must
> also do correct invalidation for any S2 changes.
> 
> Given that, I'd suggest to also fix the domain id's with the xarray so
> you don't have to redo the invalidation logic.
> 
> Jason

I am reworking this series to include S2 flushing, and will be sending 
out v4.

Thanks,
Suravee
