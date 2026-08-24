Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A03D3FCB11
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787592316; cv=fail; b=cAMsC+9NM8Jw8h/w6DUAHtsXAqcG7hLOcXOSVITkB24ck0DxfBb+U1cXXjiuC8tqSrizpzhZhCnLZe3zL4qZ+2BYYuJ/PXQo6JKG7lFDkHGSpFghC9PTozaukwHa7ymki2kKgduUcdcIin2oMAV8G4pdCJW94I7JNvYDkSEPpf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787592316; c=relaxed/simple;
	bh=rbhPaT5blCZWirKTUOXHaM6jowB0kH2Jr/OXk41P21Q=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=HgDlkf2LSqM39xZzg6i61P2A9rByYEKlOmM0JL7oyAJoZ8e9/b2eTkz8RCQKmQXNaw2fpm4vSglFuE5tGz/HqsL5ULjeZlMnkXT6m56sUjrFsDf55TE/qWawPRGdbpkwjsAmhOXQfjH/Ohznprlus8qk9A5QU2MQlNGRVa1VrAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=frkDzUfR; arc=fail smtp.client-ip=52.101.53.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="frkDzUfR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpwuWnLGEgysS/LiB4oGeClBxEKBhMlKrZXXt3SyKM/1jVM97TH1A188UsZxvQJxjTXEivy7pqntpYsQSIIzwr+WUcXeXxXPTD1GcV8jR7fF1sKOXBgVyDlVfYtqxQo72r33dz4cXRiTDUPr70ONP79dBnYpKU57cUE/aCCya0SthyGJeDqJgchH7PjcfMRwpY6oNp2+DrKv5281g63ty2IVYv2Jr6Xmi+xTsoOM7Vb2sRQLdEbxxU2aZhEzhspPuIr1nuUE3R/cctDP8TU77KTi6nAZ5wLYFYcCuRsHmGo+D+3NtLGYSZQke+OiH5Y2wQQYkrLV7Fk74zhOKQdLOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzVauBE/yYOYcQX56mYcP0jrcU78Szgr4V41X8k1va8=;
 b=nRy635ugxY/GHl7RZc4bv+7diQ8DbWk+kPN7bS3PFEFJxFpggeZlTlMosE07lGqipinj3lL2oWWfKV1GNCQFblCy/BvuUJ/tHf2eYW+yDBw9F/I9Idkra7guobegwm9+uxVOPCuyV7QwSRZCYjQXOG+PRH5WCHIHC5o0fxkztTq0sgTb3/pV+c+auaEYUFN1ac8quL3NtD/KTSu/2DybTc5huMdcA92ekrGhool0djHCzDiwmtbXEGd5wrDoPIC7qCAVMof85FuywY3vg53JHwzfDRcTifjjjzgQbmd3EzCcQy2kcQRmM27783U9kzP38RZJsq0NCl08PdGpnXFRcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzVauBE/yYOYcQX56mYcP0jrcU78Szgr4V41X8k1va8=;
 b=frkDzUfRGz8qqiNSr/iSWA7KUZho89yPHQhMTue6t0qln8E/kMXk3oq26uAjEzmpY/+Q1fHogqRNM8ZjikegZsVFI91UWEpHazptfsV3gXkDbbPEhZgv32hPjxrLKo9pRqp32hH/wIvbmmBWNfq7A0EQ/zJC0x+aGJHAPEygapWpu0hQXM6USk/Xo+jHlOeXq4MFMrihBtmnAxTDsxwcGwIhSxKegcaHe1ewIl8mAXbv3xU09kl9CPchpbOYx8gCj79ejqcujIpHPWCNFr3jSRJgJ3xlJgdACmGZhFTL+VmOZ1aUvpfkSfiPQkCVyoOrlARewBuF3ykVQa3BDYaC6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 17:25:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 17:25:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 04/24] iommu/amd: Introduce IOMMUFD vIOMMU support for
 AMD
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
 jgg@nvidia.com, yi.l.liu@intel.com, kevin.tian@intel.com, 
 nicolinc@nvidia.com, vasant.hegde@amd.com, jon.grimm@amd.com, 
 santosh.shukla@amd.com, Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, 
 wnliu@google.com, dantuluris@google.com, chriscli@google.com, 
 kpsingh@google.com, alejandro.j.jimenez@oracle.com, 
 joao.m.martins@oracle.com
In-Reply-To: <20260727132913.22475-5-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-5-suravee.suthikulpanit@amd.com>
Date: Mon, 24 Aug 2026 14:24:56 -0300
Message-Id: <178759229631.3131778.16283056585832752106.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BL1PR13CA0447.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: a4afdac3-759a-44d3-ce1b-08df0204a2c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	d9jgtOMwOjiCZudXQGd0SNvXDWzimTJHNzuGVvWZ4gvPPqiaW57H6TXwCZ0snwra23/V5KOo1tR8WOMDKjgXGLVnMulhkUdeFlZsWck+Yxy2DkvAEANVhzeKm5Qj+odneXWW0pj4UuYkuiysdjw8E9R2QBMThUw/A/rj4wIOQYqO6OFvGuoA1xlWuztS+vTzWOPWNYp+qhXw/rs4GhYs7svcdmXMMS7k3CgzcO1a7kLNS23FHL9MpRth2X11ngwdiWV60eGzEDUNheijiZXSoSq0GN4HEOHwzB5J8GsQCpKtTUbPS829XXXMfWc/dsrONR2vvMtn8YK2T4GuU+oTpYMTmaf/6/uNcIB+u94llqLRNEa+egz1YGMZO7E+0AuXHu/A7CtiE6SiSCfp4CaTo0wUz1RgRvFOOAcTzGr2/GzWgZxGEyBueQFtWCO4eHhNJs1KdCiUEoagkuXDUQJvzk8R1/UoMyQlQ/djk1lwRUrWo/bF9TyUVHGxdd8uVCwKoJDwcPnUjU7wnL6cHfMQ5MWDEDlphYyFCx+mSVgovYHRnIsdNxXNMeaP5zi1agKAiypAw5Hv5a+1uVx25NwxZWsBYg6PpjHstYwM50/bPJFV1SGgquYeh4NkOdbcOIJ7MNyaipru9w6bpdVvS9yI2ij5IzMXFyXoMPdncONNG7E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjB6dEZGWGtNTzg4Tlh5VzI1cnRHUEpQVW0xdFlHUStPdzZUZng5MzdyOU4z?=
 =?utf-8?B?NE13ZEtMRm1WMEUwaGNQbTJYTkFXa3B2b2NCZUdPeDBrYWtHL2NXRWhreWdH?=
 =?utf-8?B?SlEzckhLcENqWDNtakREb1B1V0x6RGd3SE5PdHB2VW5QNWFYZDZURlh1SlRp?=
 =?utf-8?B?cUpjUEIweG9YZ3J4Um1WaVRzUlBkUkZqNjhnSnd3TlFHK3VkaHhEK1hFakhi?=
 =?utf-8?B?VGR3SnVRbUIyMURPc3A4ck9LRnpMeDNzeWRrMG5rczFWck1oU2E1a0ZVMUh5?=
 =?utf-8?B?Y1o0cCt5NU0wMW9ZNnl2Y2NSRFJRY3h3SWpXN0VmNFAzbXFWdXdtT1QyVVlD?=
 =?utf-8?B?elFMOFFpN3lPbFhmRkRCdHFwZW1ia0tIcWFsSTdKNGRtVWloK3NZMnZNZGtP?=
 =?utf-8?B?NG5LQzA0TnU1TngzWTRTU3FYRWdkYXI4TlZQbmwyUjlFaGcxeGlXbnRsOVVj?=
 =?utf-8?B?V3k2d0ZIMmtGby9CeVN5eFBnYXlTcXJMNG9rSWxYTXFyZWRuSjVrdTE0Vm1o?=
 =?utf-8?B?VFVlZ1NEOS9hNWtqZGk0K3NoS3RNVTV4TW40MDVYNVdaRU9TWFIrTzZTaVJB?=
 =?utf-8?B?MUdUaDhmWFIxSEFiWGpicGt0QmRTbnB6WGlNWWJFZnJDQUVpbzdldG5OalZP?=
 =?utf-8?B?bmxnUzEyYnJ2UWg1YmFqcm1yS1V2RnZUMDFVNHdCb1ZESm9IeUduQUl2VjhH?=
 =?utf-8?B?K3ptWEFJRlpYUlJwL3lKNDFocHZJS1p4VEZad2EreDVSYkswK2l1UGV5VWhT?=
 =?utf-8?B?S1lVaW8xdEowVS8vTzRFYzErQ0pLeitnTm1DZTlxOFAwWXRLLzRMQUs2S05I?=
 =?utf-8?B?VnBScXAyOHRJdENjTFMydlVOcjZaMTJhaVdtYzNuSGxxREtKTW5sTHlTaGpj?=
 =?utf-8?B?NWNVWlcwdUdPMHBodEZHUHlmWUpyeVp3U2JFdWhOaG5lMFFhSTFrZnUrdlFl?=
 =?utf-8?B?ci9OM1RiVjRNcHJLN0F3UGVDZ29jQXNJM3RLYVJTekQ0Z0RXSEZVL0FoZlJa?=
 =?utf-8?B?U1JaN1ovQmRkUlJSNTlDWjBNRmgvdkFmRHB4bjl1SXplOUFxMkhCZkxMdU45?=
 =?utf-8?B?amVZTTBYQkpWd2REV1dJMVErK01MNFpYVG9aZm5ZU0craTdETTV5SDFkZjlu?=
 =?utf-8?B?eGVPYzM2UWRjZk9oOGNPWk9ZTm9CMXRXVTBPTFhXWXFnRzBCbTRnQlZ0SWRq?=
 =?utf-8?B?a0RRTWcvMHpwMGg3anUwUFdyaFZOWTh0bFRBUGlCaHJvdTRLdVlhclVFTkNk?=
 =?utf-8?B?TDIzQmpxYnprczRmdFd6bFFhaXZlSnRyVTRZV3BLM2RKQktWRkF6MEx1ZXdH?=
 =?utf-8?B?Q0JIRGtVZlNWTFpPeTgvWkc2VklvVlYyZG10RXNPRHVUYmVPdmRRY3phdzZo?=
 =?utf-8?B?N2lHWS9kaERWQkJHQTBMVjJmS3FwWElEcXZwaWZGK3NSelYxemJIZnAxbWRF?=
 =?utf-8?B?dDgzcVJXck9DNCtVajBCU1pDSFFWNUdmdG5ybnBOWnhNdmk0amMwTkM1R25y?=
 =?utf-8?B?eDUwZmNLdnBuUHJEZHVrS2ZKYlVEQW92TWF2Y0diQi9IV0dyOGxYTTZVVlFP?=
 =?utf-8?B?RG1HRDZjOVZKY1RoOXN2V1o0bVdRbzd6ZGxKbzBEWkdsUjR0MXF1VW5ZV0ph?=
 =?utf-8?B?VmRRUHkyeHhwbUhRcnE3K0l2Uy9aTi9lSFQ0Sng0UjBiOWJvZWFML2lORWNx?=
 =?utf-8?B?ZlV4VFN3VmNQYyt6RGRielYyT1lJcE5jVGVKcFJmMytpd1BFWXF5UStvbmE4?=
 =?utf-8?B?M1hoL1pYYVU5STNUQ3BZcE9KTW90M0psQktJbXFIaHZLK0FZSjJhczV2dmlM?=
 =?utf-8?B?MnY2M1orck9qcmRYMktraDR6eUxTWFVEb1FPMldWR0g4VUptRmV1b0Z4OHcz?=
 =?utf-8?B?ZlF4WFlKWTZ6UHNZdWRNQUl3L2h1SWhGYXgyN0wzdXRxY29YbXluSG1QUmIw?=
 =?utf-8?B?TVc5enlpbWEwYVRLUE1lZ3p1US9qUlhNcjNLb2FqWkluald5cWVPbUJhQm1x?=
 =?utf-8?B?b25EVzBvOFFNNEthQ3A2YUlUS1I3SkFyNnJ1Q0VRakxRbnJ6dHdnS2Y1NkIz?=
 =?utf-8?B?dFQ4T0ZkTG00ZVVoaU0zcXNXZjdqT2dURXg3Wm1aa3pKOHRSalJQdzBNTFpM?=
 =?utf-8?B?ZC9sMXo4dFVNd1FtWHVCWUk3N0M3N01OQWI1ellsVjRNVDRhYnR2cnBkUnd0?=
 =?utf-8?B?OUZBbzBLdTluRzBiTVB6SDVZNHIwZ2pqc1NtaHRxekhqY2F1aCsyeTRJTjRR?=
 =?utf-8?B?WktPQXhyeTFIdE1rMlVOUmcrbnRHa3dLZEUvcWs3VEx2T3EyTEZlV1EzaGxO?=
 =?utf-8?Q?8ZlMcGT8nMVujMoCkv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4afdac3-759a-44d3-ce1b-08df0204a2c1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 17:25:04.6252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzEe80IlvZxVtBNTyljz1pqZ2cQg9NHc9yoiAWsEOc4Yqaa6AIQNTacIvRLq+CHt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302

On Mon, 27 Jul 2026 13:28:53 +0000, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:
> Introduce a new enum iommu_viommu_type (IOMMU_VIOMMU_TYPE_AMD) for AMD
> vIOMMU along with the struct iommu_viommu_amd, which is used to initialize
> IOMMUFD vIOMMU instance when calling struct iommu_ops.viommu_init().
> 
> Also, hook up struct iomufd_viomu_ops.alloc_domain_nested to connect
> nested domain allocation with AMD vIOMMU implementation.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
