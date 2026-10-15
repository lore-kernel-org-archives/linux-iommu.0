Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010053.outbound.protection.outlook.com [40.93.198.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F1151617F
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092938; cv=fail; b=q3MN6bbOBhw1oTJf0iU0pRbK8Yf3mb1cvoAlsBGwoWAfRAuW5iiBHUKIBY/PEelev72WAK9f/t2VQkWK8Fcjye4hL+r/qMNnSOsBPQp0By/bMcMaj1Dm41b0be6zUAibtd0/IinqHONLdN9Ak5QNccmn8qoORy8nMYpBhtAvHrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092938; c=relaxed/simple;
	bh=CU2O02XlwHEfyoE5R3U8gz/XBHUH617fqXoks7jJX8c=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=ULa76yVA/KKUkGeP1jFcsVVfJSJAr2vn2sN3Lq/0SEcP4loniiF/c/IsWK0ESqx9DxFAFijEAk3AxlRlQNsOuP5ge7GDutaBSw/EyOlFmzfjE0j61URE3/9W/oFHNf/ducI07kptwIDzlGo00yTXhGOQVfUrOodwRB5z2GMkqP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ryuwxISG; arc=fail smtp.client-ip=40.93.198.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ryuwxISG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2rSfZmZmPRMWL/2nD/7HDGBg3gzCmppK7Y1pkwmYvCRaBTc+S4mChmwldf+OaPxRzAZGUGEcRAMADFQB8DQeiX/rutUGAwSiJ78uxITKyeq20Blgacwq1KQ7cTuRThZs587tX5zY7Otl1NmtOtm7U7NIn5GQ31CBnT/nfu8Twt6uVY1ba15YWApsogprX4Ldcf+FdmSZW97xtjtcMAN2c5aX3vaJ2S2IhGCJZ4CBHkPnJbmYTQrzA89wactZ77KIGfvcnT3lNwnVj/BkX0w2nmDf5Xxhd5O69xnVAxo4boPoIpdJ37D8d3Imd4/IRwo46EPJXxR4z7Gar/D8NNu7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDN48RIvfo3b2kIkSMvlvzqAYo+sKxLFmXZDWE6fJ94=;
 b=EZRliMrYERV0YadqzgYZucA9fM9VjELK+7eV3bYV3I+UOxF6nOsAy/eK06sQezZkYzdgvGX5stwkHvDdGXLLkgfQxJq3NLuWb5RjsHcQRX16iYCSROuo3zDqCJGN19hmCTtYfg5cjY2joOes9EaIDspxPyI5AQzAIij3u1RLnjfetKgKiSKEFXwlyR0tJ8+fOyMJ6Qn6BC43nGxrGPIfHEVsAIbwFPm2fy7u62k2BMAr9OMxTCS/wCZAalxA4qfrPWNBhBTXPRzlsc3uBjNFaPK7VVDIIBD4adww8MJazwTgVyrwJjSbBFJryc7G8EhlFxkPF4Ae5Yf/luilm5NwTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDN48RIvfo3b2kIkSMvlvzqAYo+sKxLFmXZDWE6fJ94=;
 b=ryuwxISGoR64AdNxBiQC/iMonmE2jsYLf9/Y1+AjWEsrVKeLJiluKpcvHiY0ZkVLBnGLdyHsj75t+JRbAIcIg3Qgn30qaPTdiCl6AQqn3JahSCd1jU5Dg6VFC7aPnAtRkomkqowNR5hVh+2iGKg6gdkSgD3gOeBEI6WxKHC+cTV7AHUXHP7nN4RVinaUqRpLnkF7lLao161po7ZiuwmPH8yJ9fvGT78fiHA1HYi/jhzfkZ5O1PV8ykPqgFJfWhgghJzM7zaNJ8lTTiXJlU4vkAStaDJIWGfKMNGu8JQFnSoVOY+rpPPpQnA3us8D03gQhbx7bticyFg/lkV25lsCBQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DM6PR12MB4220.namprd12.prod.outlook.com
 (2603:10b6:5:21d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 19:35:30 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 19:35:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 00/16] iommu/riscv: Enable MSI remapping, IOMMU_DMA
 and VFIO
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev, 
 tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org, 
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
 anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com, 
 fangyu.yu@linux.alibaba.com
In-Reply-To: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 16:35:27 -0300
Message-Id: <179209292714.4133959.5997128071302263244.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT3PR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::35) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: e0454f29-1ae4-4a9c-3ab8-08df2af37867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1XDf4/qX5UYzOr44uKt9FzwULSOLKxT3FA9P0WTBFGeRVsSHtQifwPYZbOLLOIOCFHJBeFKwYF6W3yv998MJluSg6LB+yqmNM/I0mHtWLPYCnVxynrQQWFhZT9/eEsg1IIUhYFird214NidxGOwYz1SqQouUOCWc8v599bQPe8XGhRIiDGnZ56hKK4T/+DKBX7setnFvbqDxkkNtSHr6Ol/fAHPQNrBlbUKi/1PBIND2Wha5Zyu0yMVddpSiYOGDk4r78khIivDUghQfLxoybVg6XQAWDlmH8PFMZQ0ZTR66Av3GNazHzxRt3dGBrFraOPEl0lx/tPIm64agjH+tSriaHn+bhGxynYa6YqkfObkah+B1p/3W2g5Y5WLLp1OBl43Nrk/NeFbdP8ACqKjG4nfLpp9sMOx+cXFYUkWFnUO1TwY3fQIrTClp8zZOOYJL58Ji1EAfKdzUdA+APRDgOZS74r+mmbvq+wpC1/PMdSt6WMXii2Iv+LYmp2OXem/tqKHjeEDRzZiwRFdTvty7RMSrjzNSASBLuNYKIWWdQz2gqEQjhKsdTFGF/3Tfw72ctYByDA1BSy9QHPzU7tGqkVUB4Lsgo2l5I/uZ5Sdzdrz4ijp9Mm3j5nB8JFvJCBedHHNERMokKUGz9jGdg4ED/l3AdT3VaNeqy2XAUQQ0Kqo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTJTRWVGUkNWNGgvU3lMVFFEMjFZdVVJM0F0TEhtam5OR0lpKzAvcjdyY3BP?=
 =?utf-8?B?SDN1QVgzc0tiQ2pHNjBHTy9WZGlTUFhxR205MEIxYjlMb08vQ1JJTEVCZXJN?=
 =?utf-8?B?ak9hUnF4Zkh5R2RwMnhEQnkvSHBIUUpsWlJxVGt2MGcwdm53K3dEWWJnUHJz?=
 =?utf-8?B?M09iRUdjcDl5YVZMeE9UM2kzTmx6aFNYOTBObXhMSkdiR3dac2c5K3hYaGhL?=
 =?utf-8?B?RU5USFY0ZXFYREFQaU8zN3JiYU9MSUJCTkpweUo3ZW9FZ2dmSmdmUUVweE5y?=
 =?utf-8?B?bUU1d0VXaWR6QUZudGxhRk9BOXBOOXlidThFaGlZSGpQMDllWTk5TVBuQTI1?=
 =?utf-8?B?ZUJNN2dKLzBpdmsrOUV5L1FPNDFGREMyY0ptQWtBVFhtWWZrNmtydXY0YVg2?=
 =?utf-8?B?czQwcnFDTW9CTUh3djlOaWlkMTVONy9NUzl6MWtWaXJpSlphcHVBTlFBblpR?=
 =?utf-8?B?OWVpUisyV3F0L1JmU2FuT2hFd3hGNytZeEliNTd1RXdMUWc0UDlDUUYvT3JB?=
 =?utf-8?B?N29ybmtyRjFqQlZhNVJydElhU1VKRHpKNmdleTNnUVM5TlpYWklZMnpoQXBS?=
 =?utf-8?B?Rncxdm5TaGhLVmp0eC90N1c1aDNaUkRiWDV0Zks0Wjk1Y1gxbWNnRG1mZEo4?=
 =?utf-8?B?Q3pLWG9QaEZBNHNMNll6U24yRGp6VTBjdHlOV2xud0lxcXh3U1dnNDBhRW0v?=
 =?utf-8?B?ZzJESkFwdDJkQlZxZkJnaDNIbXlBVmF2SnBGdXRpQzNpeHUrQzZqSzlKbXhI?=
 =?utf-8?B?TW9hSXdEWTdkVml5aXNPM1dTaERoUnI1QzV0Yzc0SVE5c045c2RlK1d6RDV2?=
 =?utf-8?B?S0srUWNoQjJMdG1qV1JDeDZ6L21VMGZvemlKUnNncHBDZHBXUGVsdVcwU0lx?=
 =?utf-8?B?ekZQeW5YVkFoOGdDQWU0aVpEUXlLWUZzM1M2NlZnTE9rV3lna0F2RW9NU2I2?=
 =?utf-8?B?SFhtWnB6UEJuOE5hUXBYY0hQdG1QaE0vV2diUGtKbHdCV1I0MnZ0YTJxRHJY?=
 =?utf-8?B?Tm5DZnVwMUc5OWhoNmxCcFFNR2w5YkMvL28yb0hHUVNBbExPa29QRXVPQTlU?=
 =?utf-8?B?SSthSFgvSGJGMzk2ZHNEbGw2YVBWalhuc05iSXZzYWRzZ2cyb21FYUFtZkhh?=
 =?utf-8?B?L25NRVd3NmZ4NUZBekpNTDk5bTdKNUtjMVRIbWdsV2xsS01QelIzRWlqVFlB?=
 =?utf-8?B?R1FoYlJrQ2JTNnprNmtPVXhncEh4TmVHWkJJaHBVcTZoeW95am16WGRoais5?=
 =?utf-8?B?VlhFbk9Hb2NzeWlFYzZveFhNTW1rdU5oNW51eklsUTFYMVdUaEUyU1FSeEc5?=
 =?utf-8?B?MmQ4MTh4Qjd5ZmIwY3ZmbmZSRE9MYjUzYmd0RWFUSmRhdWJpUDlQbUREbzFM?=
 =?utf-8?B?V3BwUGZ0UUJoeldDL1NNU1pRaFJRaTJsdFRUQmU1VmN2aHNiNzR1bWwxZW9C?=
 =?utf-8?B?ZVpHSUdab1V1d0tsSGFvUmVMUEwxaHAyZnFydE5VM3Q2aFNDUDVIQ2l2L0w4?=
 =?utf-8?B?RE5zZ21vcDZUbUdIbHpLZitJSWNNbDZ1aitIOU9VZXFJRmJ0M243M2gvVkVM?=
 =?utf-8?B?MU9JRCtremx3VmNpVFB5bUduTFlXTnVSWlJneHV4eUpaL3U4a1NwMjVqT3BM?=
 =?utf-8?B?Nlk3bG5ZODlwNnNjWUxtSWxQVWNkRUN2d1lOQ3gxb2JrRmRzUUVtNlRmaUpG?=
 =?utf-8?B?c3poR2doL1ZTOE84Yk8xRndxUllWK1hjZ2RTblJ3VTdtaU54azJMR1VQZHcx?=
 =?utf-8?B?cG1jU3VTYWxDWHIvNHR5WFQ3c2VGbzcyajJKY1p4QVJTTlYyVjZ5enFtdjFj?=
 =?utf-8?B?dXBJTU50cCs3M2lGdjFvVzBpeFNraDVpRHB2NmV6aWJ4ZUIrR01GaGdHRVB4?=
 =?utf-8?B?akhhaUo2N2ZrV0tPRmNweENjdHExS09YMVQ4Qm10STRsNldwWDYrdWdNaWZj?=
 =?utf-8?B?YjRMWUFKbGpCdUt6ZUZuZ2JFejN5UWhpZElFazRDd0c1Wmx5MEJtbTZ3WlNJ?=
 =?utf-8?B?eGU3WnRyeXU0UFNtZXBReGdtczByUnZhSnU1VFBjMm52TnpHWjdKVk10MlFN?=
 =?utf-8?B?eWpQbm5DZU4wTnlnQkYvdGsvU1BScitIYXV1ZUZGTzVVYVpEU00xa3gxM2I0?=
 =?utf-8?B?TjljVkF1NnRkc1JtaFV3Qm5wUzNMK1FGck9maE9ZL2JhVzhrMHdpYlFuUHlG?=
 =?utf-8?B?RlAxcjR0RkZ6R3huYXJKMk1sM3hRWWlDOGVwNmRDTk9Mc2RLUmZlY04vNFNv?=
 =?utf-8?B?TjMxVjJRU2NlWnROZXRCOFNJdytMQldtK3BaZUxVaVJjQndCcjR2blJRaUlt?=
 =?utf-8?Q?cNP98Es8u+WQuoV7Qj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0454f29-1ae4-4a9c-3ab8-08df2af37867
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 19:35:29.6778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21jBlNL89oe5IKdl3rW8F2mk8DsJwG9pm7Mu+mwMN0WenjrBB8BgRQVOKoJ+hmxw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220

> This series adds MSI remapping for IMSIC so a device's MSI target gets
> translated the same way its DMA does, allowing RISC-V to enable IOMMU_DMA
> and paging domains by default.

I certainly like this much better than the earlier versions I saw. I
think with the noted changes it should be pretty close.

-- 
Jason
