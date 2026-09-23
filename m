Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E15454DAE6
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181585; cv=fail; b=axPXsxCKpaKsadQBwPgd2OrAsuwLBosR9FIxqis35W3f6DdXJ+DTlsmLYAFg2YFE8dOeSKVViu9W+W0hrvAQmomBYfpIfsjI0dyRrYwwbVGvTx3dyWc9lBonm0Kb1eHV5+NLh1uA/Zx7GgZ7VSU4QQP2C8nuBo9tJUP79pGYGdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181585; c=relaxed/simple;
	bh=X4UTdZkCU7MXc/1w5eEPzh/O1cnI1xyrLx09xHDE0Qc=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=GXJnmaKyNjmbygAUQtajmtWT2rgx7FysoPu2dWgIYGWU3OKwOltWKO9/0Czi1YBSiLt40LHZXCNTy1UFSfnjzaGU21HzxG92Vow+amhgZSUsL06UbU6mC8ok7VSMKSIg8VQe1cHxL06xPvwh5NULn7IR+4NB6640XPHe/6DF5bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gzPAiaoY; arc=fail smtp.client-ip=52.101.48.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gzPAiaoY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USwgrB0bWTMX7lU7q2ZbDP5DuCdXIlHoYN8T4WiPDoya7UJUcurWQrmMHAFhqcMF8Bo66ZZ3xk8iPptvu98Lh9lCExwp2BqWdmT52rHOLK4HBev22cWC+NPemeqXE/BISq/0r9hpUD0PC1D1ib3BV04v5lZ1HabF+5AmrvnOKvEaGLptA30V2re7amGNBysBk+wrm0UCb3rUZBD5d+Izx+vq9mKoBQps7Dt5VxBY0g/Fs0yquSDlXLZ9T4ZOS+ONAO1X0IJA0MpPTLXEX4TQLLRvOODRQSPA6E1FkowS0t1dMwqTpAyETT6S9sMArBhV7Rrp//eeHMJH8iA0fI1Q4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npkhdgm1P/xxGCpxGpX1SM90EfkqO2lrYm0tag/thFQ=;
 b=IzomqoGFF1kZlHOKUYWrnrZJxKNgYyPefRN7L57OdlfYGK4eLoMT183G+R+yOCt6Y85bTAVhydiy7YglSvYessbH0rDvQOKeYmJZu9eQz1pxZJm618BzcTnezl6uSyVMuvDfZ/HPASufz8mZwp8ZbR7gFI2ptOmwgMkeHyNsDKhYonT9RotWFng3hzg6TNOST1Rz0QOz6rBM8uvQNrckTuaqBrxa5Qyv0fn94XM8nGh4Jb8xTp5QAucdU65StnkhUkTNQKBBYfD98ajfiueIYKNGbZMvXtQsXVn16Cmj/AoSqoad+RnxMYm4uiKQgkCl9wZfg+ax5N+O01BwS12ung==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npkhdgm1P/xxGCpxGpX1SM90EfkqO2lrYm0tag/thFQ=;
 b=gzPAiaoY8vhOJyh3xVauye8K2bU0E5JFVjBoIVzFPZUKjGqY4H9v7Y+TOtnw8IJUA+9ss0YZ9Klud8Gug9ymKfGlfKq8/6btd7XyfZQ31w1stjmb3fffdN93tbNnkha0vPSwDHzagEMMU9yHbuBzUkHadT51r6XPXMprGEtdkkde9sYPO0gGTk0eGdAtSoLuNr8mpO2hFzTwMeSO6ByG0UOh2eD8+caP2dR2q4lIpnP97FNU1rYh8RaPw+qgYz9nsiLOoeJPNNXtR13MSnuz8BE1SidcAYwS6rOhBMw3G0c5i2RCzcPXzJC92HSV+LEQekgOu/DC2RjL/FJ9vliVHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by SN7PR12MB8170.namprd12.prod.outlook.com
 (2603:10b6:806:32c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 16:39:22 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:39:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 02/13] iommu/arm-smmu-v3: Make the ASID space per
 SMMU instance
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org, 
 praan@google.com, kevin.tian@intel.com, smostafa@google.com, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org
In-Reply-To: <782e24224c916ad0f48de1a49c139e71c8db0ef2.1788130528.git.nicolinc@nvidia.com>
References: <cover.1788130528.git.nicolinc@nvidia.com>
 <782e24224c916ad0f48de1a49c139e71c8db0ef2.1788130528.git.nicolinc@nvidia.com>
Date: Wed, 23 Sep 2026 13:39:16 -0300
Message-Id: <179018155685.3334538.3461769880303246427.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: SJ2P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::15) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be013cc-cf0f-456f-e5a8-08df199137de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|10067099003|4143699003|22082099003|18002099003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	o+Fo3iVXltn3der0+5NxGG6qkK3d544jFBRAiVI3J1SQWFugRKCo+46CEcuoa7sSnxKnEJ/b2btkfZi72wEk059PlyATJHjlG66fu3TZ/IUF9HX02KjHjgqwo6mfTn1FWz4Lzeyl1O2MFjKQzYBcJ0ZzDdm4E6Nwm1kc342eXgqbtMBG2BCA40MyFeY2uqT+pWqYzR3zRaUlMK85PiV13aVss73fZZNyNFfAv4JkOJg8h8nLCoonWOC2dBmdJWODNjCiSrH/cIMjzX9zCthUIRbE/ZFISjPSQ6uE/vOcWv2GxjmcwIsJAAi/VJd1skWmSE7jOtImPOkXNmRyAVFOxSRyV/Kub5xSe0DkS84LHdW9Kyp5vnpKuC8AoHUUm7UvWUfkjK5Ffa3Fw8k7gXi7Jc/f19GsOWGIHLBrZrprWcMpAdbUe/UuLXGM000qpyFOj1IfqpDpHQFxdvvdG25OCdd5sEcWUsJoTp02ap9BFa36HJ3B3GEsZ0H/JtSqyP6FsObP5by5LchNh0NBcKqcN0uv29+qp11X6WUcTq7Io7HOChdHdkxsInrym7Uqsu54F3I7ZN4exJKvIVE5EDRsEh/7+H1m2kp3ohTWQbEJCCeKlIYb6uFHo0sHrFYWw29I2HSO90W9PgFpNGYb9qi5JMGdReAZcctG8x+rVUANXQo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(10067099003)(4143699003)(22082099003)(18002099003)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REJBdHNOMHdJcHNWNEpMbnNiNnJ3bzkyTFJFdEJqd3doTkxzMW1UWi9tRVAz?=
 =?utf-8?B?NGFKYnJLSUdMZDA5UC9BaGNJcEZ5cEJQbDRURnFLTnRGUlgrbHh5NU03RStP?=
 =?utf-8?B?TXhrZlgzT1RwUU1taEczZ1RYbVlmOGJoN2xmbUdjK2VuU09HdXVXL3lMWXI2?=
 =?utf-8?B?MzdvK0VmekxlRitKRzZkQzM1NHQ1MHFWRDl0ZUdEN240VXN6YU5ISXBnZ2Vm?=
 =?utf-8?B?TDJ0a0M2QTdhc3pLcDl0NnpYSXd6d0JRNXRCa0NxRWY0U1JJZVl5eUpGNDFu?=
 =?utf-8?B?ZW4wcVNHMjZLbEFEdllNY2lUWG0wYzVaNlhJSk9mS3pUNWowVVZFVVQxUmlG?=
 =?utf-8?B?OUlzN3QrK3BqaEZvYUN5Z2syYkYxMWZpSW5iaG1Ld3pJRzZxVlJKbWFVTCsr?=
 =?utf-8?B?eGJkN3Axb05VaVFVa21TaU9rMC9xdVc3T2hBc21ta2R3VnlxNDlxUkNuS2Jr?=
 =?utf-8?B?cnBrQmlVYW54Ky80aU9VNXpPMWttT2x5VW9LdE5TaHFDcDdSY29hU21Ldk1n?=
 =?utf-8?B?RWVPNmRhTW5KelAzVmUzaDlVTGlVN0I2WFVpT1owZSt0WmVUM2g4YXBBcW4z?=
 =?utf-8?B?SGltUHpYUE8zM0x4UU83dFJNQ2pMZHdid0QrNFNyUTRUMXpibEpHL2xKeUVq?=
 =?utf-8?B?UWtPamRhNjhyRjNKdFc2aG5CY1JrS1lISmNWZkhNTmFya3ZhaE5nNlRIUzQ5?=
 =?utf-8?B?dEtFU04zL0p3TW9Od1ZHWFN1NHVtNWRwWmpYeDlyaXRwS3JXMnZIaEtsaHlY?=
 =?utf-8?B?QjNvRkp1Vjg1NU9pSW1VQTN2VUdINmd2Rk1udVdrREtkS2NvNzJkVGZHQUkr?=
 =?utf-8?B?NElzbTYrUFlOTURMNkdTK0dXL0tJTzVncVB5SGQrUEMwNyt0NmZvN1JkYS9h?=
 =?utf-8?B?ekdzY0hqMXgwUldCS1B1ck8vNGUrcEJjZWVSb05XVThwOHdpblozR2Z3NFM1?=
 =?utf-8?B?WTZtZW1paFpCdjNWMUx3U0RlRjBlaCtJTE9CaFdHM2d6ZFlrQjhtcHpVck96?=
 =?utf-8?B?TUJDQ3h0ZGZXTjhtd2RldjdPV3hUT1FBSHk2a1IvMkpBWHZGdndPRjdHcHpS?=
 =?utf-8?B?dXFpZXJvWktWWnVNMjM2MkZUaUpTSjMrSjUweTlLVzQ2NVIvbTlIK244OXJB?=
 =?utf-8?B?dEhMS2RDS3RIaExMQ21tbjZQWGcwYlArZVJUMnZleUJhSFhOSllPTGZsQ2RP?=
 =?utf-8?B?aHpoUUREVnlLbWQvd2ZZVVRWa3R4OUpnWGg4cHFFNS9ReTg3U1Aza2pPUWZL?=
 =?utf-8?B?OWNlNW5XNVMyWWlrSEJJcFFob3FiREgzKzI2Q3ZuQ2FBNlBWU0c0NDdBZmV3?=
 =?utf-8?B?Y2Q2YlZjSktBRFA4Z1FBUmd3YmdoQW9CdGNCVkRWYTFqcGdZL0ZMankzOXdj?=
 =?utf-8?B?bHBGSDNEb24wUzViSHZUU1hUMDJobVVTY3owVVVnR0lpVERKTTROYzZDNU9X?=
 =?utf-8?B?MnpHVitLbjRLMStGcE5JTnAyaVVwR1IwanAvWTVXU3FSdjlpdDRXVFh5eWJF?=
 =?utf-8?B?STdTSlFSMGNrNWFVcGE0T3c3cHVwWU5NZUpqYjFRL2VORG5nanZNbTdPL2JY?=
 =?utf-8?B?bWFhTWE0SXRiWC9PeW43V3lrYVFXUjEyWUYyTnQ2RThXTGJ0VFkyUFkyOEx6?=
 =?utf-8?B?QXZ6aUo4bGR3enJ5TGRXNzEwMGpMWFhaOElyeVlrdUxiK0txeTBMNlYxQXdm?=
 =?utf-8?B?MHQxRm43VWJnWEVkSm0rcFZyL25Xbm5MZHoyc1Q4UW9TZlFDZVdncXBHVjhu?=
 =?utf-8?B?R3J6MStvMlZRZGVvZVRXQzJYOXhvTS9tdjZXV015YkErWFlUUm91djQxeWtu?=
 =?utf-8?B?V25yanhXc2REa2ZvVXFnR0I0eXN6cmhGU2xUTGlwc0F6bElRVzlud2hsamhh?=
 =?utf-8?B?U0RmbTZ6cEJQRURrV1QxMjkwUE43UXF1TXNwNVM2SVZnWE5XbGlYYTdpN3VB?=
 =?utf-8?B?TzBjSXhWNU1jYlc2MVpJTUZCdkVNVkg1bTdLaHlnZWtYcmkzMzZEYUhZT1p0?=
 =?utf-8?B?QWJPMS9YYUVBNStIZ3M4YVVDVXhRZHpSemhmL21HbU5wYVZmZFU0RXBFaWta?=
 =?utf-8?B?dEo2SjR5aGZ4dVZNNXNSdFc2UWRSeGhGRHdPK2VTNTlVbEtGMGNsRTFjZ2dR?=
 =?utf-8?B?Wm91UkxYVHNvNy8wREw1QS9Yd1FvM1A4TmllRlJVSmZDcjQxalhJczZZOC9Y?=
 =?utf-8?B?cUsybjVmQjJSYkdESTRraDcrUXl1R2pvMmFIYko3bVhmTitHSTdTd0xpdmNi?=
 =?utf-8?B?NnBES2xxOU1ka1o4SVRTN1hFd2RGeW5vbVVJVjZzTWtXQ3d4Ulg1MnVRMG1X?=
 =?utf-8?Q?nk0ZrdgBFo8CXZ+PdB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be013cc-cf0f-456f-e5a8-08df199137de
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:39:20.8894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEKViiG+3T/UCYwD1Jk9dSFj5128WWCwbG7Ghmcf0yeRAIdTVvsvKK3/+2biDk9I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170

On Sun, 30 Aug 2026 16:18:03 -0700, Nicolin Chen <nicolinc@nvidia.com> wrote:
> An ASID tags the TLB entries within one SMMU, so two instances can use the
> same ASID without ever aliasing each other. Yet the driver allocates them
> out of a single global xarray, which makes the instances share a space that
> the hardware keeps apart, and lets one instance exhaust the IDs of another.
> 
> That global space is a leftover from the BTM support that shared ASIDs with
> the CPU. Now ARM_SMMU_FEAT_BTM is never set, nothing looks a domain up by
> its ASID, and a domain is pinned to one SMMU at the attach.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
