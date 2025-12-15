Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010042.outbound.protection.outlook.com [52.101.46.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF5C306B25
	for <iommu@lists.linux.dev>; Mon, 15 Dec 2025 06:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765778959; cv=fail; b=LMsFzs+S9y+6kNC/BA4lAlE0E+YssrEAC2hp67+ZcUONYZhgnVJDpDXNYkrlEOHJWxkppGtjxnOfmmZKJK/24r/5CmfnIWOxP56Dt2VN/uzl5h5tgAPQhV1QSvQiAm6v0Cxii7pN+FfPw2xAXcPhLDY/cYsLneeVIxWADyXzKEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765778959; c=relaxed/simple;
	bh=+gKHuAX8qMFNsCnnbbz07VMVRrCW536T0Z71mnJFHL8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S0wz1OGyvkvDoe9rwe8/xfJIiSmaWC2gE14bNGNRhsUI7AMW2vee3TE9flfEzgTQP3g3ezSr0CfDiDX++MhifHn2C7cnK8zmVq8ACYnOFe+6RSsTR2APJDLqV2hAXlv969ZcOfzu1r7nMG4BDCn+y5UZ6iKNglGttdbMkFE+gXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ODjxkau+; arc=fail smtp.client-ip=52.101.46.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ODjxkau+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJ9fy50/WmWl52d0/ZQNz6GKp+mExs961RK+Nc8U45GE6lzfeIr4i9q5IhA6uepqsPkKF6xBWbvX5z0ZkAtjUe29B3+GEoodZpHhOzkdEEa9uxvLhgqgqzQ2AYpjSrEUBDJrbI3Za7hLxCxb28Zs2D7MIUHEy76pxhQbThnLI0w5rkmFo/SkcAtiz2EB+JmqOY1SPaUrGMLRFDDRDWx6vZREAVqfJw9IZfYeOqPiWjJrcI4pNokRnN4tyIYftbGu+MRgcMq5RTXALOW4+f8Us1wuDXXW6m3b6dOi1t4HoEwK7BgqpGrfqnd4PekLZLl5xLMmjptcWtfr2ZSSgV1f3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNLWP4hfaMxiTNJa61md9epLlIVSptt//iYgoF1alJ4=;
 b=FD595T0QCsj01P+mMC7RuFrpxEBf/SDh7QMWQ7aF2fhKx5d7uF/Vh85xKE2aozGCuZ48icPkhQU8PsZhfVE5RnGBbNabzwty+zelNXnUuX4YV3ArTRxZA4nG40z6dL3HL4fWELnUW2e+7MpnilvRI1aCHWH6zehe6DmaZwHtBQC8vy9hfcl4RtpHeWCiJjMb0g12YaTD6ReIQAOHqnTyuUlYSwNJjeKMRJ+fdVnvfQrhZbmLmscOPaspZ0Zp1U06Zpyl1S8SP34L4jxiQjG6yBv/dkvi8nNzbkDJXag6TZzBi/f479mNaUdFPVO51NB7udIn43aDKfQV/cxVhzaMDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNLWP4hfaMxiTNJa61md9epLlIVSptt//iYgoF1alJ4=;
 b=ODjxkau+KYmOiOXKg32epr+YqjIl4xvHxaatSoNsZLLTtSGfOOV3AAcuH6aKpMVrLmZyOyUjazk7ivULi/HiXLSxvUiHOuAYDOKTV9j1WJaQTDAeOyO5emWPsEjsBRb/t09bzqMzW9PQoo5FNKJkzADa75EGGHmKBi4/69VbembEyecllf8tdkverHYQ/HEdHh1vK8RyfCfL0Xk/eZ5xgoxXkjfzE2qSlkFjAoxKxTZAltaGMJBGOxdOpueI1Qwx6PZIo4ElugsM2cYMO3hZ8sKXCZ3tZm65vuMu+a/ZP6Q4Ewht5/TrhILwzsXjxRWQk9S3k4hag8cEUdpvNgmEzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by DS7PR12MB5959.namprd12.prod.outlook.com (2603:10b6:8:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 06:09:15 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 06:09:15 +0000
Message-ID: <d4e942de-296c-409b-915a-cb7ad23c53e0@nvidia.com>
Date: Mon, 15 Dec 2025 11:39:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 1/4] iommu/tegra241-cmdqv: Decouple driver from ACPI
To: Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
 vdumpa@nvidia.com, jgg@ziepe.ca, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20251212060803.1712637-1-amhetre@nvidia.com>
 <20251212060803.1712637-2-amhetre@nvidia.com>
 <54fce1f8-7675-4351-b292-0009b2e8c599@arm.com> <aTxxBdcY4hODXcdu@nvidia.com>
 <104441bd-1284-4147-873a-f94c91788609@arm.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <104441bd-1284-4147-873a-f94c91788609@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:266::12) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|DS7PR12MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d851a67-25a3-489d-43c8-08de3ba07929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUZkMWpDbDVLcmhFYmlUbEgrcGdJVkhKdjBrV1pySGpTc1FDbnNsZFRsSVYw?=
 =?utf-8?B?V1FkbVIvU1d2c2ZTZjVQRGZ3WWhublovSXFtdEwvTm9WZXlDd0ZsYUtVRTl4?=
 =?utf-8?B?Si8yc0UwdlJsK011bzNLVy85YlZhMGFZUlhuZU5OcVJOQ1FKMlhWSjFyL1Nv?=
 =?utf-8?B?K2p0MTZrMEh0ZGxIblptYUFRTFdmeGl3bHlRaWR5eGhtY1FKL2U2M2RFZEN2?=
 =?utf-8?B?Zy9UY2dNN05wMVJ0bHo1QUxNN3VRRzFKaSs1eEdhV09rYWt1Y0FWRm9EV0hJ?=
 =?utf-8?B?V21qczhXd0VSQzlBZXZKS3lVSnN4SjY2L1pQTm11Nm5FMS9TQm01ZW9XNXNN?=
 =?utf-8?B?a1BZcU1YN3ZCZmxUMVJHU2lMamcxVHVKNzNwMlV6R1pGcHpESGY1MU4wazFD?=
 =?utf-8?B?aC8vQkJIMU95cnFKMkMwNHB4dkp3Rm1XYXF6bDI5Vm5ybUpaNFUwQnBUWDQ2?=
 =?utf-8?B?L21EaFdvNEEvUmdaUGdhSy9oTWY5SjFsODJTWmNSTzc1c09hYVZ3Y25STXBy?=
 =?utf-8?B?blR3OTdnR3ErQ1FQUFhMTzUrclZEUHhxWWo4K2pkcDY5SUJkODR3Ukpkdlpl?=
 =?utf-8?B?YVcyVVFMZXV5Z3RPdzFRY2hVdlpZckdDR1d2L1E5eGg5cVlIQ0xWbFE4N052?=
 =?utf-8?B?SVhFd01UWUdKV0RtaTNLZkVEWEt4UUcwMUtPaHBqa2R6Sm01THVYd1VpcHZY?=
 =?utf-8?B?TWRBYnpuSzBKWERjS1cyRU8zb3ZGYnJMUGdFZC82ME1vNUV5VkhjNFZmZ3VS?=
 =?utf-8?B?Q08zZXdMTXdjSGdtb2dCL1l1TmpZZUN3OTF4c0hUVmJ4NnRHNkk1cm8vd2tk?=
 =?utf-8?B?Q1hTbm9Ybmp0WlowRHRqZ21zZ2IrRGR6b0VqQnE5T1BwRWpxcCtDVFRkYzVp?=
 =?utf-8?B?ODcySmEzMU9OZzBpR0FDOW9ScnU4UEU2cUZ3MjcwSnlhUHFSMTAycnd1cVh3?=
 =?utf-8?B?eC9BUkt1ZlZWT252NkIxWEJqN2k2YU1lclhWa2ZreWNjSVphMFlrUmZUeWZk?=
 =?utf-8?B?NWxoQXorbFNDNzgwblZVMlhoUEZBNENSbkVlU1U2ZjBxK2hhWjZiU1JYZFkv?=
 =?utf-8?B?c0xYWHFuOWFtNDEvYVpWeWg4Y0NnY3ltc25Zdkd5TWxYNkhlYTJCbzdmV2dn?=
 =?utf-8?B?bHdFa1lSbVUyc21iODIyeEdCdk90RkFUVUtIR2lnbjB1K0Y0NCtkY1F5WEZr?=
 =?utf-8?B?YVhUL0RPaW5qSjQ2YjRiNGpCVjdITG1VOVVFRllDRDU4Qkd0VkxWVzViS1pz?=
 =?utf-8?B?MVRseHZxalpqR0R4VEt3MlFZOWhDa0lmaTlhd0p3ZDJvaXhiV0VwY0R2NGxp?=
 =?utf-8?B?QnlMTDZ0eW9RSWUzTVVYR1N3WUhheHZDY3ArbjJKaWNZdHRvenVyRmxvTVRp?=
 =?utf-8?B?MnVJQmZjWE9ZYWh2YkdBajNoelJRY0NPanRxLzE2d1UvQmlBWVRiUEpHcHZJ?=
 =?utf-8?B?TEFrc0Q2cWhsKzU4bm1NQUkvN0YzUUUyVUNLaEFzOHNUZVUrdHRHU2xNS2N5?=
 =?utf-8?B?QU84YWQycHM2QVpsQmpDaUp5cytSZmNKR0F5NEtDakNDdmZ6OUlXd3ZETzZG?=
 =?utf-8?B?ank3d0hldW42eXFWeHE5Skg5RDB4NUx4K0pDNXd1YmRIenU4TlpqZEtjclZz?=
 =?utf-8?B?UjhycVhVcml4RGtkS1ZCYXNVN2dYQ0sxcEREWDdPam45TzEybWI4eVRia1NR?=
 =?utf-8?B?dWNpTW4yem93ZGNvR1Zzb0ZzUDVyRXdrdEd6WXZDWTFVUjVnL3hsZmV3RXQr?=
 =?utf-8?B?Z2hWSHQ1UzRkMHZKZVRKOUZhSi81YkJjemM4Qm9OUXJHOHBrT2V1a1o0M2xu?=
 =?utf-8?B?Wm5QNzJhVDNhT1hmUHFOWGlCekgrK0ZrNU1jMFh0b3NnWUtheEEvV0VleU5y?=
 =?utf-8?B?MG1hbTM0ZEVVNVVYL1NjekhrKzYzMXoxNGZkbmUrYmV5WHp0WHFrc0NWYndD?=
 =?utf-8?Q?uhtZcGKMsbNl0ib6ocsUfuxarzhHvbsP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzNZQjUreVRGeUtSMWtHNUJlR3ZpU2FEcFJMeTArcEFxb0s2UlR6RG9xSko4?=
 =?utf-8?B?ZFhZWlRsS29ta2J1R0RHSjZoT1IxdHNuNGEwcUo5bCsrbW5lRi8zQkt6ZDV3?=
 =?utf-8?B?MzBzejVDZUtGeVg0SnJMWG9LSEl2Q2hnWmVYZDlLM2VNZFplakZpKzdIZ3VK?=
 =?utf-8?B?TFRaTFUrdVBzeU5XQjF4dnRFdHV1Yk81dmdlMjhuNmZYRnM0ck9mRTRubFJ0?=
 =?utf-8?B?bzJCRjdnNGd5Qmk4aERzUHQ3MFluQXdEbmc5Z3psOUNiY21mZkxITDRvSWk3?=
 =?utf-8?B?ckZXYjdqeFJ6b1I0RmhlYmRzZTM3TkJRRnM1bDdMcjZXVzN6NkJWZGYyTC93?=
 =?utf-8?B?cUwvZkJPV3RVTVR6WGFiMis0ZmRUWTIxYVBTWlZESjdkMGlTTXRVelN2OTAv?=
 =?utf-8?B?NmZONXorMkIycXZMVzgzRTZVYWdCbEVtclBSWWk1Z1UzWVpHNURKMWRFRVJM?=
 =?utf-8?B?aXZuWEgwT1ZDNzNQTXRaanczeS9ybHJTSDdpWCtacGxnYVFpeEN4aUNFdWll?=
 =?utf-8?B?c1ovdzlPelkvRUcyZVhDTkk1KzVlUERQM09DWW1mbitUbXpyZDV3N0RFZFJF?=
 =?utf-8?B?c3RMbDBFUFdiWG5xVUJ2bGVHTkpNVHJaNk5id005bGc2elJnQXB0QjZvaURV?=
 =?utf-8?B?VFBUaFBpL1Fsa1dNUnlJcTFhaGNwb2E3dSs2end1TWNWdDlLb3Vnbzh1NS95?=
 =?utf-8?B?NTZUR3RxY1pnY0h3OSswem50UzlFTFNrTmd2cVlGeXhVMUMwZ3VPSlNPcXBZ?=
 =?utf-8?B?U01CU0dZbCs2SXkrWGZ4T1M4OVlRMG5qZDBINmN1b21sN3hkQmhqUjVmdXNj?=
 =?utf-8?B?UEYvdXlnVFJnQ3RxRnhZR09LYlJIY1FPejl0K0FSMG9TNlBDaWZ1OWVkQlFt?=
 =?utf-8?B?US9OTnUrYi8rOEhyRkpHOElmdlJodEY5QUIvQVdEMFpBZ1Vkb2swQVBYWDBl?=
 =?utf-8?B?eXg1YXl0TXg3eG55N2hzRUtaam1IQTFnMndTUHBQbCs3ZXovRUs1TGtEYTRF?=
 =?utf-8?B?Tk5XRis2cVpUQkttQ2k5ZGpnajQ4ZmhkVlNmeStiWmpCK0xSMFRITTg3VXcw?=
 =?utf-8?B?aTJyZzg5bXc1QVBNZXZhN3JjZFJ1cGVjbTErWWttZW9Mb3F5TU9wQTBqQy8y?=
 =?utf-8?B?bHV6cnJWbGx6NTA5bFBpNWlMYzhweDY5djFPaFMwWHVEaDZ0RitMSWJmeEVD?=
 =?utf-8?B?T3NGOVJPNWhjbWZ1UkZ1UlJiODh3dGN5YmZqejdxWklXaDlkYkg5ZXd3WC94?=
 =?utf-8?B?Sjg4UGk5MGRLalZzNkZ1elNxL0hoR0hiVFd1SFhuVFNybFZPV2hLZzZjOGw3?=
 =?utf-8?B?ay9vYlNhVVRBU1FvT251a25jcGxKMWVCaC9sSWZkUEFsbnNaZzBVb28xYzE3?=
 =?utf-8?B?YmJmUHdvaWIvaVM5UXg4d2ZFZXJVZ2pYZEptS3VVK1loVUxVcm41T2l0M1dB?=
 =?utf-8?B?SUFGL2lQS2w2ZXZZRStUQnYzT2RtdlZtTkpyQW1GTkFiT1o5MXRiRWlJaXQ3?=
 =?utf-8?B?S2VmZEUwalpNU3VLYU5BUnV1UlNUTmFXYTZCcUFaMWNtVmdSNzYyVHhtVUk3?=
 =?utf-8?B?WUVTK3I0SzdXcmxHWnV5V3dicjR5ZXlKckhRSUdIVmVZU2RRSGJDRDMyZEls?=
 =?utf-8?B?SDFFUXlVL1VRK1plN1FhdHBkKy9iMzVCUVpYR2RRVUZIUi9lbmJuMFZGU2sz?=
 =?utf-8?B?UHFlc01paCtKVGcyZGhtQk9zRS91Y3lZSldJcDM5NlVVbFp3dmNOMjVUbEpR?=
 =?utf-8?B?eUF4ZlcyaE9YbXpPWFBmTmlvSExJWU0zcVNYK3lWMUhWUFFVcS94TVM2V2Nk?=
 =?utf-8?B?V3FsVmwvOXI5eUpnNHVxUmZSblRjcm11dFI1S3g1WmZvU0c5b0c4YUlIaGtW?=
 =?utf-8?B?UTdRdkR2c1JYcDN2ZzZqY1dFN3RVaVFiRkdRYUFGYVZXUkEzUE83YjExWnJy?=
 =?utf-8?B?YVZFbVdlWnRGOWxLeHVOZnFiSllYajM4QjZYamhQVnJxNTdvbXBLQXF3RnFL?=
 =?utf-8?B?bHZaRm5DR01nMGtYT1puQ3ZqclhucDdtSzh5cjBtZGF3SkpVd0ROSEFJdlIx?=
 =?utf-8?B?K3BuOC9jK3ZRRjROU0IzektKOEIyZ29YTjBVd2k2WFJFUnJYRGtyeGVWT0VX?=
 =?utf-8?Q?hg0rX4aWKSeisc1ZucmqDed8n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d851a67-25a3-489d-43c8-08de3ba07929
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 06:09:14.9799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Jnt6sh4wqHfAUzSQOMwENIrDm9Ffr8MdJ6kFo9Inoj6DsD9c8cP3CmHEspFBRlwrD6HufyWcUsNN8jFPvHGzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5959


On 12/13/2025 2:06 AM, Robin Murphy wrote:
> External email: Use caution opening links or attachments
>
>
> On 12/12/2025 7:46 pm, Nicolin Chen wrote:
>> On Fri, Dec 12, 2025 at 12:01:41PM +0000, Robin Murphy wrote:
>>>> @@ -4542,7 +4542,7 @@ static void 
>>>> acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
>>>>     adev = acpi_dev_get_first_match_dev("NVDA200C", uid, -1);
>>>>     if (adev) {
>>>>             /* Tegra241 CMDQV driver is responsible for 
>>>> put_device() */
>>>
>>> Don't we need to bring the put_device(adev) out to this level, since
>>> impl_dev is now something else that AFAICS we are *not* taking a new
>>> reference on (and thus should not be putting either)?
>>
>> Ah, right! We are using the platform device now.
>>
>>>> -           smmu->impl_dev = &adev->dev;
>>>> +           smmu->impl_dev = acpi_get_first_physical_node(adev);
>>>>             smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
>>>>             dev_info(smmu->dev, "found companion CMDQV device: %s\n",
>>>>                      dev_name(smmu->impl_dev));
>>
>> I think we should squash this:
>
> Ack, it occurred to me shortly after sending that in fact it's good to
> still hold our own reference on impl_dev itself, as we're not relying on
> a bound driver to hold one for us.
>
> Cheers,
> Robin.
>

Ack, thanks Nic and Robin. I will include this and send
new version.

>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 0c98be3135c63..88625e3c27a65 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -5280,10 +5280,11 @@ static void 
>> acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
>>       adev = acpi_dev_get_first_match_dev("NVDA200C", uid, -1);
>>       if (adev) {
>>               /* Tegra241 CMDQV driver is responsible for 
>> put_device() */
>> -             smmu->impl_dev = acpi_get_first_physical_node(adev);
>> +             smmu->impl_dev = 
>> get_device(acpi_get_first_physical_node(adev));
>>               smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
>>               dev_info(smmu->dev, "found companion CMDQV device: %s\n",
>>                        dev_name(smmu->impl_dev));
>> +             acpi_dev_put(adev);
>>       }
>>       kfree(uid);
>>   }
>>
>> Thanks
>> Nicolin
>
