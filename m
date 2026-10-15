Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013042.outbound.protection.outlook.com [40.107.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902CC556BB4
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083841; cv=fail; b=PghsOm6fxkHXqU/Qybdhq2KVc4jCYCcmz35NtjRnFX23Lci8H9Xg0dF67X5FRWAj+S2oK8uW5IjU0/b75jscPpMtuW046eLyVZ6pCeGqwtywSfGgAB6/z1vatTGZwJAJI5VJ3itmXxZi4jBP2coSurOjBIFbUO96IiVc8notKqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083841; c=relaxed/simple;
	bh=sfywZyVTcHbGlemlN/YR+JhWsaNffmDbYyF2AKwuLhM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 Content-Type:MIME-Version; b=Kwr/UbsaAokVFWk8HwyZUTg5vLVPKt2EMWDC+aav4WiosF9slWrT860WxyllhpFZknK/VTeIaIkz+3Y9xvVrFSgJRuiBxzxKS+5kQpaBZGBqgCaSHcamtX8qmnVKoPDkia7j5L6HNXiVr48OAFGyUQFn6lju+OmPNHAEJ6Ckj1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uoYXh1i8; arc=fail smtp.client-ip=40.107.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uoYXh1i8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JU3NlcZOw51d0Hr3Y+nsPND93iP4sx4a7jbzaiKroltYr/t9mpqW9cj8B4w2hfLOLqefdfcIBA7Lln3DBl67KWnScZK/JVE9QzCzxh1o2qd+nBGxwPgpwwBIIRpRxhGHgFXKsKjIS4dut6q4SR5fBQlYJ94aU+YT47FoF7hSy42j4t+8jPYWZo3xOf+mS3WqUAIewOz22AZvPuiYJvHPRj2mYL0qyxlQiadXN0uLVUhYfqo7j0hQ0Mpf9l0j6mdI8Zw5IQEj+5T2uV3sf0pMu61MMhQteqJ9fUhWMiqUy+m8nt8MoO7vxSouff/ioPiikmzV1/XiO/pvb82sAt05LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYutc8W9mrLXj/Ah2q+7FdLHhHDjhtZFjXnExcG5res=;
 b=UkWfhVxbx42JH9pGWkK567OrhrUIIr10XDE4cyzkzcUyRoJPOuTowvJvn5Qu7fK9xxcqDAIAjMR6zlP7r/MqBkB4hCOvOk9eEr6tAtnks04HypPaBcUhfvfkjAcsWAGTUy1hgEkp1jfeIHMFupv7JrclQSFwSjl1euuvTtZ00iEFq1bV67tdxj2YaHSrjR9s30Y1tgPDUeQnhsaPRL6QmYg9buv/cswxkYqcbK61TJWD35YDzIHhzBxL8+pDCxwpnTo8h7LF+7Q+KAsyNcnhkqOkQacA6UyRFMuYRQPvRobSN9goN/NK3Lh4rRb5f4ycyKbV1+vMEhefVqQNxKnKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYutc8W9mrLXj/Ah2q+7FdLHhHDjhtZFjXnExcG5res=;
 b=uoYXh1i8U/2XY0v7PD/Qz1pxPLMMN29wzX8SHNP2Z92WHzFnMv7cq3BX7Ws3Lh1yNO9pzN6QIpRySTl4sqWDvcPPwtudgV3rkguJqmuT6m86FZTvk/+hlZWpHqAsPPPF/z5X6rCmdWsbbLPSowMgPdudP1P74qqgY5F47IHyaNFsT4QE6YBASW3qXxg4U+QtOPWr1YpRu724ElCchK+PKEQ61iPORftn2yfzjOAHdT+7OqirnRWWLrx81c962lapewj/tqZHB15b1p+SxHxak7Z+k0h5o0LrrvN3f1uLDTOdH6dgCazITVjPqibEBx7SyPmyvGhS7RYQP37A/hqFdg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DS7PR12MB6069.namprd12.prod.outlook.com
 (2603:10b6:8:9f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 15 Oct
 2026 17:03:37 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 17:03:37 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260929031402.1998253-1-donggeunyoo.kernel@gmail.com>
References: <20260929031402.1998253-1-donggeunyoo.kernel@gmail.com>
Subject: Re: [PATCH] iommufd: Keep reserved IOVA ranges when a replace
 within one IOAS fails
Message-Id: <179202507372.3602487.5888082994295005845.b4-ty@b4>
Date: Wed, 14 Oct 2026 21:44:33 -0300
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT1PR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::27) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 577fb22e-cdd3-4813-7294-08df2ade414a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|11063799006|18002099003|10067099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	ELNrYcCny2RwaTjtbW3dLlR/VGaB13fPRvGsEkuA7NOmJlqVJl49K5aVf5p+7skgYsK134phkZsbzntHa0Y9o0srI4gMjHGGDGIu1ijtRyzqP+E0Dzlrx6Ob4Mkv552T5tiYCjowWKYl1vzjr6dxTl4vj4dPPvLqZ9sHssiTfRbI0OsOZmYDO9uM2/PowRX9vGnR1eU1nsmqA9uxOqHoEMwHW/LkqayRLGwfaCctZVNTMcbXidO5Pm73yh9MAgHQLv2mX2g4j/VerHUK9Ol97ky6ubg5aoi+t+dygBFQorSFV7YNGXkQaxrRLpIVZiDXO5yA6nJ0OBLVTRezDbM9yPSODJBrHqGiHYSnYsfWgJZXE4HZoWcJ/A6tJs35iQLNsFQ1mPY+j0sHljSGxNSwUsYNcRsQnWHHr0EVDpbamjRV2k1K3+1xWr0kxcZEuhbkijlHRfb1UH2r2jrr9dZS4SM1Hi2klMbA8neZrf4J6puBSDU26NcbmYkGNWIgzHiXiW+DJ6bY9LK/i5kX/8jZa6TEnsftv3/VoiV/jGBP8j0baBr2gzBksivypSGk/EJUrVrn0LE8XRP3ayJebHfB7wIxxsVBqeyuAby1HdDIJykzkB3tqPR4XKS/c6ZZRlZuvAGTa1NlKXy57p0xEzw0QbhV5mu5ThUSwgbrH8m2vuE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(11063799006)(18002099003)(10067099003)(22082099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVZNOUVIK1BzT1FBclpLRkxNQjhWQ2VYZTZrTy9qNjZoS3EvRTFzUktQVGtX?=
 =?utf-8?B?V1lHRjdRcFY3YkU4dUFQNEhWOFN2b2RwNlNqTThsTWhPa2ZVTjNxMXhDdS9z?=
 =?utf-8?B?UTV4K2NZZHQwZmlieW1XZ1d4elB4U25BVEV1M1o4TWZ1eW9ob2NlTWlocjd6?=
 =?utf-8?B?bnZrUXdMaFBRd1NENlAyVEljZXFBYStSRDE5SjIzR0E3SWZqbVVreTg5Q1Nj?=
 =?utf-8?B?RitWaUJPcWxTU0ozUE5hUDd4R0lBK3JIaWVFeVhjZHp5UktCRG1kallqYWtq?=
 =?utf-8?B?UlRHMEJRYmxWQWRuSnBrQ0pVNHRBMzlUN2djeStQMU9vNkZwdENHb2ZyZjlq?=
 =?utf-8?B?ZFhvaDJwdXBjcXYvY2RlczNNRzBGYmlNRXpvR0JBWGRDMEpjY2s4MEtLL2pu?=
 =?utf-8?B?STFpcjlDR0Vic1JOZmZ6ZmZOQnV3aStycjV6UTRSVlpWNzllL2xvMGgyVXRF?=
 =?utf-8?B?WTZKVmFYT0pNc3l2dzVlMHUwR0NCdlVWN2pTaVZEMk9Vb0o3KzNnQjBCUm9m?=
 =?utf-8?B?YzJ4NHFFVXhIb0JrMEwzL2t0ai9IS0NVNjdEdHdzOTNiamFFd2pRKzhHL2pZ?=
 =?utf-8?B?WC9LN0ZQOHdVbGFEd0ZiWkoxeC9HSGZTN2xtajZwMlJmaVhxTk5GRXZ1VFVK?=
 =?utf-8?B?TmhxTUFMYzZRUGVFaHN5UHRaL0FtZnFvWHdwQjFOZ2VadE8vSVRhTUhHR0ti?=
 =?utf-8?B?ZWVWTHMrSnhnR1MxZTJSWTlVcjdtcVFyckNUMmpGRkFoMms1V3EwSmJHcHFQ?=
 =?utf-8?B?c2x2UmsycG5yQUY5WWZiNzczSFB6WFJuNXVsSHBPUFpIQmpqN2hwaUN0WUV3?=
 =?utf-8?B?dC9VL2lpQzJmOFBQREExaXd1b0ZybGhCUFQ0NkNMajVVSWFCeTFVVTR4Smo3?=
 =?utf-8?B?RlRsWm9wRTVud1pXNVZ1dEhiUjhOaUU1bVJBSDNDNmZQdDlPVDVEaE1vWmNH?=
 =?utf-8?B?K1BDNWpHcDF1ZkU1M0I3enhTdEM1Umlua3hCQmF4M2txdHVSMVRSYksrUzdU?=
 =?utf-8?B?SHUvNGlGS3Q2bHJaWXB4alNPOFZJSzhXSGpjeE5YWTBQd0RTWGQwckw3WlBU?=
 =?utf-8?B?UklFZDhXOUFQOHh4QTdkNm1xc3ZXQlhSV3E2OHRiVHV2YU9xakF4TnN0aFVC?=
 =?utf-8?B?Vk00ck0vZlVpOXEzWnNiNUQ5bjc5RDg0Z2JxZlh2VThYb1lTYTYvV2Vha0V2?=
 =?utf-8?B?Y1JiVGo1S1phT2JmSHVPc0krK0dYWDA1Qm5xWHdhdmNlWWxBZ2lxTG9NNlVy?=
 =?utf-8?B?RE44OUlRMzlhN0wzYVAyc3pDQ3JMekRPcjRURzA0YkI3SktQR1ZBaEtyNFJu?=
 =?utf-8?B?K0wwS2pETCsvN3FLQnQrQU1IU0FsWWszcHNRbG5YSUw5T0tWdHZ5OWw1T2lm?=
 =?utf-8?B?MmRVMnFDWURyYXdOWlEvNURBb0ozMUQ5Z0dGWUVBd1VFOWo4QUVnYVZoblZw?=
 =?utf-8?B?aVhNYnBVZzhFdW5WTitvbkhRRTMyMHhhN2t0UVFOTDhLdFNRSnpJc3ErbW9o?=
 =?utf-8?B?ZzM5WmlwM2tyOHJVNEVoNy9tMi80YmRpd3QyS0tFRzlJNDkzVU9Ic3ROc0dZ?=
 =?utf-8?B?RjRiRlE4K2R5S0M2S1JXNCs5WXcyNExBK2QreEVnVCtRUjF4cFViRWpXRzIv?=
 =?utf-8?B?amkrY0c2cUlYdG1yaERZcWt4Y1lkSHJlN25kRWs2Znd6M2p6QzRDcDVhM201?=
 =?utf-8?B?WUpqaUVyYUFvby9NVjU0cmZoMFRWc0p2V2toSzlGY1VTancrMHUxd3kxV0hF?=
 =?utf-8?B?bkhqMnRPeXQ2aGJadXNEZjVpL1l4cGtIY2xHbkNFdzIyK3RnT3UyNS9zQVNT?=
 =?utf-8?B?L0JBUCs4aEVPMGJwYzZzYk93bFhwamhsWmd2VWZPcFNpZEVxMHgrdmJwdE5K?=
 =?utf-8?B?aWh2SmlxWW9WTFVveElnMFNxWittY3dCcW50R1pUTTBVRG5zTlFzYXl5L2FL?=
 =?utf-8?B?SXEzajYwWnNTMnNiRjBXcjgzbnIrT2tZeUpNMGVDRzUxdUFGdDN4T3gwN29i?=
 =?utf-8?B?a0R5eThPakRvalFQN2cvRnBNTGh1cnArY01heU5hR3EzcTA3ei9QVFBXVXQv?=
 =?utf-8?B?ejQ3TUxRM1k2QUxLQWF3YVFmdlVxYkpNWnA3WExpbjVhRmlaNHlrWVFNeHEw?=
 =?utf-8?B?UU1qQ3lxazY0OFErSUlWM2hMalRzY3RpYnN5UFEyaWdGcEg5WDJjYlkwVWcr?=
 =?utf-8?B?MWV4cUJvYlVETm1MTFZibkhlWW9UbkZ3VWM2SUE0REhiZ0FrVGpyRWYwbnlo?=
 =?utf-8?B?SkRUNDVWWU9jNmpHMmZNdGEySitzejFWbDUwK21uUWI4ZmpFejlkaVpYYUIv?=
 =?utf-8?Q?4XGgfpcjYR6LUEJQMJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 577fb22e-cdd3-4813-7294-08df2ade414a
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 17:03:37.8249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXuHvVHVEJEn44skG8KxKW5j57fhkYjS7fbRFt6t9Xc6skYE5GmPYEe2sJz5jM/1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069


On Tue, 29 Sep 2026 12:14:02 +0900, Donggeun Yoo wrote:
> iommufd: Keep reserved IOVA ranges when a replace within one IOAS fails

Applied, thanks!

[1/1] iommufd: Keep reserved IOVA ranges when a replace within one IOAS fails
      https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?id=1e67cca28490f897788c128c650a6f2cbb565403

Best regards,
-- 
Jason

