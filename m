Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC93E466B1A
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787592318; cv=fail; b=JDh9HGb1OaY42jM41zXWuZEAmD0UMwHTmWAB4qTjr3cL+IF4zV4x1BKYw24uxR1WnRUYOptezRX1iWANhmF7qqmz17laaUHrtnpGoKC2m7MBxNgx2A7bNWMysy9x4qhTEsHDTWF22PSbEQOz/D3fUmrEiy4I5Eul6hm/KRRcOm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787592318; c=relaxed/simple;
	bh=Xsrds/fzeeX8AVwDYbBPNevQsORmD+whDa24gdRrmzU=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=M/ksrbq1BO3SFrm6wJ6fjVdsSrPVbS/aCIRTr+k4bHPHu0R6vCe6r7/iH6b0ShZKi9O0vdlKnXksqbUClp8W3WStqmWgAAZ59pDK0WuMymIXnpHkx+T7cyRzRzMUfTw4Ejl8JLTFixsh4xeTuNi+lXIPMqVe+SqTktKqwsHVMWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HrL6Fvmv; arc=fail smtp.client-ip=52.101.53.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HrL6Fvmv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sd+5gF2mHsRn4fqObb5R/Lx/zu2oTAH5Fff/Jft8V1wLHD7jzvDEw2VlIm7C32iUQbvCNNOtN9AsApEZXL/tmUGkUy4lyLah3rJIK5V+8PpLxVzUIFsD8PHy+Ow0+KfaUQi3PweM3nVLBnNtfawCvIB1zcjZjQoWwlHJ4PUwop2OcYLSSDsixz1xuYSN5Z0BOlkMKnEnphc4Rp1QyBkI2NqNgNfMaEHyJQGPlmFDVnPqjT1rZZDITyrp/7hT2EgQTXrGL0NQ1XLEguD99Ry2AhTM6F1YBHBC11rCFj0s1r8+y7gSuYK0iEGT9iWDYMqnSN9AoDOXXpJlQe/ido2apA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkGya3ZDDK4z3zdnJS5wkQE0rkkKBHuyEE51U518qjc=;
 b=lzJh7sxqTFfqs/YvS5aSPnf080JojsS6bwVjLUOOCiY9sZ/HdQNX4lizKrvbrVPD/AAwOHGUxk2KmxKETCDTjctsoEuasfNm+nAA38ntR6h4VBMK2c+KpiWyzCYBfPRxGai2JIBOP9U9K+g5KurqJtUyXJK6oXzt7ymMwC7YwbbV52Za7Fbc7pVUI40JCdHik+y/bH34YW0wLyZ9etPM9kAH05pbROvEiZ5UU1a8powbUGb+ANcfo+l0tmReUFR1HIC/O9cn0vaiDmDWPJWmY34pkCbHmosAmOP8rvHFwPq9w/fPluXvHebmSPjCGMHasGylIEShDFA4myYNDHeFug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkGya3ZDDK4z3zdnJS5wkQE0rkkKBHuyEE51U518qjc=;
 b=HrL6FvmveYO2a3ijRK+dDJOjEyRDJ2s0wX6PJM339ZKQbt8SgqxoC+9ESg1vugm7ur0AJIuLxaCNrK8H5p/dI3d6JyrXArmsodoDYI7iuFMfru3J3wBZCbCnfb20AzX09FOmv2cGLkDkOWMe1rJUCAyK1V+OJzCP5Ms+NVKwi6aRPpF+yDoEvWcw+tu+5UpphwhTl3coMhEalTdgmeO0oqd4UKlKrVHRSFAavXosXr8mQN2GxQFL4IC8VhYo9VkSgXqefiZv0G0gEIt/tl3pX7Td+MgTzz0CY4aWwSGBduQZnaaLdzycotWt08IHGmM7sxm3CMOqEm4EPRSPShAM+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 17:25:07 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 17:25:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 00/24] iommu/amd: Introduce AMD Hardware-accelerated
 Virtualized IOMMU (vIOMMU) Support
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
 jgg@nvidia.com, yi.l.liu@intel.com, kevin.tian@intel.com, 
 nicolinc@nvidia.com, vasant.hegde@amd.com, jon.grimm@amd.com, 
 santosh.shukla@amd.com, Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, 
 wnliu@google.com, dantuluris@google.com, chriscli@google.com, 
 kpsingh@google.com, alejandro.j.jimenez@oracle.com, 
 joao.m.martins@oracle.com
In-Reply-To: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
Date: Mon, 24 Aug 2026 14:24:56 -0300
Message-Id: <178759229630.3131778.14271430837971332646.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BL1PR13CA0430.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: b46ac413-92f7-4e8c-ff8e-08df0204a35e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	u7jTtUDn/kd0M/D++drUMFnjLo3aHijBZ4CNkwM59THkWuRH2YhPGrYY0yJmgJNuYP7VGlciuDu+QQiSoQzqhDozjw4bYfhplKgWiFz0Cqn3Umq+7iNpxR8MLjy9xSdKdCN91svlxnkSF7pqF6nj0kAOYQvOoTLAchczVxJSZi/FFr8aU8iscLLkzcthKhwk3HXBZ7eLjW2uLj6lxTS6dpf6B/mF9BWJwCJZCkdwlJc1mu3jDQ0SAD6WG1sd4ocyB7OlRQi1ZZ6PrNV0mH2fh7zeKMzOwFYxWZxC3vHbwk/bzl3wTXPpZq+y/KMOXgq/Gr3jZmTcuurmbmi3fwnNDZT0/oRNnJGQMFbz+YHvyuY//uhTI5CamZ2ucwnqdH6Cm8XxT2sHixx9CT+OOP1VGdp1mcwyhcVKsaKBfHXwJmhigVosm2q2eqiEUxYBUWgGVCOYTFYiZuhSKeRvh0AEEZYcKGsQjCyITtMf6f9iGpvoCFV+UbonOH/jUv29SoZ0eMti1qezthgCxvbfjVziPlIaCzK1jS6k3sR1ryIDofdxzdvLRPU0q48PjpQAqoIpt81lrmfhMTjRqPLu49qSucUeSid02Btul9GcNma+5cyBxI4C9bmoOO1lIMOyy1/ApX3hRKU3CwSzV3NPfzEcFrjCPQcp4kC98jmTf0505/0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGdEcmFycE8rcXh0bmkxOGxUT3RrelNvdmhuWFZGMXNHd1FJLzA5b2p0dzVI?=
 =?utf-8?B?NUJrWDdxdjBHRE5CMG1EN1FDSXo2UkhLZGZzMkoyTFpJOC8rMWFHZ3JiT1dO?=
 =?utf-8?B?Z0tiMmRpbmlRNGZNOUl2ZXZHR1hFZzVVL2E3L3l4WDhwZ0tWbi92WFlPSlhy?=
 =?utf-8?B?LzhPNzZSRHM5cEY5MC8ybWR0SlE5cmhuU2Y5L1hoeXVzRnhlVUVTV29YZ1k4?=
 =?utf-8?B?cng0eUpoRWFhYXZSV2RwWkFiVVJ0QkFpb1EzL2hRdDhjbVI4L2dhYWx6Mm5y?=
 =?utf-8?B?TUdSQzdJVWRlNWpENEZxR1ZDRDlCcVpPUzQwb1MrWHRnajFDS3d5aFowZmdK?=
 =?utf-8?B?ZVlCYWJLS0xYQlFGMDlFUnRra01EOHpEeWpVUWRvOXpwVlo3bVRxNzBGU0Fu?=
 =?utf-8?B?YlRCeTNZb2JQNHZIcDRxQUVVV0p0Smt0R1ArNjh0TldXempIYUN6NXN5NkQr?=
 =?utf-8?B?VDRWSEhIN2daMFg1QzZHSkRUZVdoaWZ4SEI5Uy9CN0ZrdU1ldytvejNiQ0Nq?=
 =?utf-8?B?bDlubDVoV0hYSmJSUDExZEQ5RnhJektJS090WDNlbnpLK2xDRXdXeERPOTN2?=
 =?utf-8?B?Wk8zZm00RUc1bmVKbnhpVnVYVkpVcDVoQkxzRnJMR3YxeTQrSTkwRDZlenR6?=
 =?utf-8?B?bFh3TnpySXMrZmxuYkx0R3lSenowTnNiY3ZkbnJGamhnS2xmaXRXTXMwZGlS?=
 =?utf-8?B?cVdiYjVxb3FwakFCM3N5S0dEYzhySkNDcDN3NjVvSGJzcXV1L25ja0tEYm13?=
 =?utf-8?B?dUUwZktpZDdpSTF5Vm4xNjlsaGdiWS9YTkhCTHptS1FmVVZTdzFLWXk1OEt2?=
 =?utf-8?B?Q1orczVaUGpYS1p5T1hkM3JteHRJUmt2UEJ5V0duWGl2eVpqQ2IvdlBJK21Z?=
 =?utf-8?B?RUR5d05RRGhZR3hUUzdUVmlkRGdnaDNCUDhMQ21rTnkraEVMWWx0NEtISFJU?=
 =?utf-8?B?VGM1QzNiOC9mT3dGUDRVZnV3d1U4a0lpY2RYcXBpeWFXekg0bHdpc2dDVXRQ?=
 =?utf-8?B?VkExeUNLc2VEMTVMWkx5UmQ1bFBCa2pFQlYwekhkem1vSTUyWWlEMUYvM1V0?=
 =?utf-8?B?aWxsYjYxUUs0VWlNZGdUbG1wdzRtM2d4Rm1iMjJaN2QyY3FJOTdsTHZaTzlu?=
 =?utf-8?B?Y1ZGS1NXUVJYckwzcnAvNFZjcHZSY1lRVTNkMGlNK0k4ZkdjcmVCNUtwalJx?=
 =?utf-8?B?ZFdBVXFlU1BVeVkwSndIVEhNb2R2WUNJWUhGSGNOMHZKWTBNYU1sTSt1Wmtp?=
 =?utf-8?B?Y2p6OCtmaWJIVnM3RDRWVUU3RTlRa0RYMkMxc2kvcG4wblJKUUJLYlNtTFJk?=
 =?utf-8?B?aTlaMDdBVTlQcmNXeDMyWWNjaXlxai9JYVpFVk9XNkhDN2JlcUdjbDFoaUZU?=
 =?utf-8?B?WGlPbi9QWCtldkUzbDdJMHdIYVIxalZuSHVUN2trTmxPNmxZcWpWbmpKcmln?=
 =?utf-8?B?MWx5Y3dMTjdBRGtTVEMrV2VBaWpTaUNyem1QV1FSVDl0VVBySmFQTytXQTdo?=
 =?utf-8?B?ZGtrVXFzbkZHMHMwTlUxS3RDdkFwcHYvRTRRWWhEVkFTaUlIaVN6eXA3L3pq?=
 =?utf-8?B?NUk0RFJJRFBaWFZhU1BoTVJrdnNQdnZibHF0b0pOQnl6YlBiMzEzOGlHazNh?=
 =?utf-8?B?RmJ2Y2gweEJ4UHNEb0RlNFgzcEVpOWVyaEYyeGFMZ2RFMHR6UWV5SS84Tzcr?=
 =?utf-8?B?WVJBa2I1Y2NHRkVEd0FWdGRPNlhBTFc1YjlZK01JM3R1Q3FJVnRsK0l5UUh1?=
 =?utf-8?B?WEJuUVNaTG1SNzFWRmlsWmRLMSsyZmdhTlJJeHlnYkFrdXVGM1JXNVNWK2lH?=
 =?utf-8?B?Q1pzM0ZwWURQTm1ZQ3UrbFBoalorK1YwM1JiZnZETmdrditWaUtyWkxMOUw5?=
 =?utf-8?B?ZW41eVUzNEVoY2p5SzI3OHkrbFJzZHNzaWE2cmZib1BKNUQxZVp3M2NiZHBI?=
 =?utf-8?B?WlpKRHEwNVhxTUlTZHZUYWxNU1lHNmhpZWc4T3hPdytXdURvcmlFbmZ0TC9q?=
 =?utf-8?B?REVKbHZTSFlCOFZuLzlMdU93VXZHS3dtNmp4YUUwRGhsRUFwS1pMZFByNnNU?=
 =?utf-8?B?eUJmamF3YXRFT3ZVRWtsRmloclhMY2RpMDBYTWh0UWRrT05DcGwvT2hob1BK?=
 =?utf-8?B?REJnd042WmtGZWxSRnJOZ1NCbmhCclJsQmdPY0FkelE2MmhLckxZcEhpK2tD?=
 =?utf-8?B?VVI4TGE4eUx2dEltZEZrSFNKaXlhbUJaekpyV0JpNjNNQ01QekllNnlteWMr?=
 =?utf-8?B?WWlrUmhlcUhCSGhhNWlPL2Z6RE1IRERDQ3JtVmtpQk5tVjZtSlFxY1ZiOHVz?=
 =?utf-8?Q?wXRz2aHosiVCUY6M3n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b46ac413-92f7-4e8c-ff8e-08df0204a35e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 17:25:05.7178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqCkDHz5r6zKjkabD9lrQ47CHxqLHixgcplDfSn/MJho36/FDpXC0cNJO5G2PqTL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302

> [ ... 75 lines skipped ... ]
> Testing done:
>   * Single/Multiple vIOMMU instances
>   * Single/Multiple VFIO devices per vIOMMU instance.
> 
> [1] IOMMU Specification: https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB
> [2] Linux git tree: https://github.com/AMDESE/linux-iommu/tree/linux-7.1.0-rc4-amd-viommu_upstream_v4

It failed to apply for sashiko, you should resend it after rc1.

Best practice for sending patch is to have git include a base commit header
and base your series directly on some commit in linux-next. Then sashiko can
find it.

-- 
Jason
