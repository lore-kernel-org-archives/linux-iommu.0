Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C98C54B1C3
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181578; cv=fail; b=BDBUwZb4HCPBgAC3j0aR4/SIYxgsx5C5V5f2zZMTlWcMeSVEfmOOHaPxsQDJTBYpN9fX/YcX6KeAnvNNgsH2Fb30/uL26BlQA2YTKAgj8GfYtIj1I5B7+JBV/9rDP5uH6MAaWcDTCUP2k+HtuwI7HqtN6xAKnfltVATK1Sw/xrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181578; c=relaxed/simple;
	bh=RjaE7841moTHKPLZ+eFWjajWltyzDBo4AcnM74qNgOI=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=hQ9yUXcEB5AAdIALuEy3/MuKL92mODIpJef+Y5/DZwq9ezPnTqhtx4f4k0CuyCW4HeGVl9sXbAnt7ZNI9tlos4k5M/OuFfoNkNuug9CvwgmWq/R+Z55i9TkdeRFbFWNtK8BtM2cjLoC6psz4vHYGIn8zNigFe7rlYOdnLefGguM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tpcdQn/p; arc=fail smtp.client-ip=52.101.48.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tpcdQn/p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRjsmSeE7FyoJbatvAALYob5X+vlFGutzTLrKpaWCLnXaskrTYWuoRYYafEmVUOqjsM+wAGbeOsvWXu3ojo+Q3oeNhvLSyJ6ZrpJQJnWvKLhjps2Xw501gQsMFkvuobSwtCOeoAxksabmJR3Rfn3iqDYqlRSftLzrQEZairGFVQylhUTQjo4OJHErgdKN/B2TNMozY/ZqRYLEj6cHyWBC1bjIjquEtkVJHwssIxAUl2zyaCr13l073/0XHimYbMgCxxl76HB8jNDiFOhBf4RejiaK9qH3LA4DJl3bWGSSt2j4qTD+UAYyljgBeUhN3Sl3wNxrG44tfETS1gnxQsXJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRPz9TFtrzX344YNm+0128pl8GAEqUQ2BeDyRzDy3yk=;
 b=BzCNObKIcFiEaFrPrwU1klX9PQtd+UQl0S2xaXZq3WRRAryXVqiKgpg2ittOK+lZIrHLvZVzBvh1SO57IVxkXshwriLKtnnVl0tTkx2cJ37amkgZ6dzzn2McPmQmZhDRcR1C35pJdE/HqfeTIrIJlQy7eA1QrFWfSGPVMoe4UltlcE3ok5XUjxTcmFMpsit/1lMkKCVt7Zay91oUhOBSxBlfJPBg3JZTTp94AkMfZLRzgpzcuMx2tRLlGFznyQzd7qAntY6308J533OPq8riQB070mIovBQPfVI/3v/wY9w3/LdICWYm6OugxoU1N/FYCLGXRld0cgts8gfx8IMdPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRPz9TFtrzX344YNm+0128pl8GAEqUQ2BeDyRzDy3yk=;
 b=tpcdQn/pyVZr0CJLTIsZVRX/7bjn/KKYwt68OeVQm7whZ+BAk3U7jlvcsnQS1CZedKnBChkvMEZcLsKayf5JAbI0vxtEl7lVoKhBJ6H+wU1hnOFnVx3unAmE5RH8x+jULqA2ETK0emVi9Y30w0XarZ5q/rF0N3dah24W5H6+Q2LFkgCzNXZbt9KoPcpOnfEoh1xj8Uk7qybI3WcKKTMgbg3qgWNX8Kz81FCsWDt19MmpQ9/9AWwk42wW16o2onmN/f9yHYafm/YBBw2oKExIAnQ78aARMw7FFYOJ3YYbtJSyDCMKClq95t9CUOBSfrhVSHrH5S61AnaQcj4wVYwYmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by SN7PR12MB8170.namprd12.prod.outlook.com
 (2603:10b6:806:32c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 16:39:20 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:39:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 03/13] iommu/arm-smmu-v3: Add ARM_SMMU_FEAT_EVTQ
 for the event queue
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org, 
 praan@google.com, kevin.tian@intel.com, smostafa@google.com, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org
In-Reply-To: <b6493aeece86f44195e8afb6fb8b3497cc237dc2.1788130528.git.nicolinc@nvidia.com>
References: <cover.1788130528.git.nicolinc@nvidia.com>
 <b6493aeece86f44195e8afb6fb8b3497cc237dc2.1788130528.git.nicolinc@nvidia.com>
Date: Wed, 23 Sep 2026 13:39:16 -0300
Message-Id: <179018155687.3334538.11821786319865196859.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: SJ2P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::7) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc950f2-1c3a-46fe-f88b-08df199137d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|10067099003|4143699003|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	9PiIqhpXRUoIgZNa/2ggH/eT8eXxmofD27tzFebONBFRCfz+u7iDR/SrcpLYmhyrINIH2UTJFwQIeIIzXV4UOJi1s8dBBE735bulAGdyPEjW1OXKQV9McmV/IlH6bRqVt6KBnd3CdLtxbSAOBIqESbhm1BPFGrcsUctYv+kMijUVXTnuZ8QTzS9X4ge3qFXkSeKU5BZf/AKdyVg67ZaK03b43Zq+Ued4e90rke1SnTiwkL0H0q5nyT/BWvCh9QNgxUJslzQEhquI8yv7pgcZTm0CkDLtsxRkqATKflLJitUJREk7TloI9yJsdxIkqzlxK6KFl929dQYlagCwhUFqFR958Y4xdgkSfKtrJjyLx+mvu/zL/KjVweAfSfcCw/VJZvUDOxs9WW5UqaOFx1lyrWXT3G+K1upKY8NBRJVkgUJO/JHjEujv7oA9fbk3xm86wcUndnKlc4XB+LcPb+k59Yr/xdZL30YtuHL3NseL75fFIyAGsP5yB/MDaS13gtWgBYgw4F+dXLvTHviMY0JHBbU+jw6lVuDstt/1MESHXSXraDdrQGSLDtRGeo5lNmsKai73BPwHdBfch5yFLHGfJTnJSca9j9b0IoTlXsrdK3yfPYMc1C1bRGzc8hBLjaK9HCCtHr/hNiw9anjuAU5rt2OAP01C/Uchl8gBp2+5BKA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(10067099003)(4143699003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEFrc09jQml4a2ZHUW0rdkhRVDhMMG1hU3hTM1hnenJGQTFJMUhIZE9YVTV6?=
 =?utf-8?B?dFhkTHRpVUpTTmc3QkZYUk1tUUJvLzBYaklqN2dLMTg0bkpYY01zeis4enE0?=
 =?utf-8?B?ajVBK1lGcE5RbmZqRnRCdU1Ba2ZNajBzNjZTWnZ4N3lpdUxZbFpMT0JNK0hl?=
 =?utf-8?B?bG9ONVQ0UlJOajNmWW9ha2lnOFhZMlVZbGlkUGdnaEVibFdyZExsSlR5RkRE?=
 =?utf-8?B?UG5VYUZuLzlVM0cvaUtLd2pwRFlRN3h6VHFzbExJbWF6MWlnNCtGZnJiZEM3?=
 =?utf-8?B?dUVUUnk5cUFZdUJmTUp1VGFRWUdETHFOOXFZd1hVUHZxQWs0T3BneEpkVmJL?=
 =?utf-8?B?WHF3NnpzN1JDL1JMRWxSVmloL01iOGxtTjlaWkNjZ1FuclA4NkMyQnNrVm9V?=
 =?utf-8?B?a0ZXVWdLZC8vTTFlelMxRDEvbDAxakVicWNWZS9GRGpONlNPVXZBUDJpc0RJ?=
 =?utf-8?B?eERCNlZUa0JyZzY5OVE1K29vTWJGb2VndERlRy9SbTdxai8zUWRZWHp3UE9O?=
 =?utf-8?B?WTlMVkN3OTNsN0ppZUFiODJhS3lQdTNQZElPa0lRRW92NXJnZGJaNkJuS1d3?=
 =?utf-8?B?QWRqVStiZzV1aXBEUGh1anN2MDVhUzl5QzJNNzdqNkkzbWJtZ1dGa3hhZ0Ix?=
 =?utf-8?B?aEFZWWdIN3lWRUcvc00xRkEvUkoxT3pVbVdxT2FNcm1hYWNxc2VCblhDUzg1?=
 =?utf-8?B?VlVYVktQRURHSHlFVWxVWjdZSVNLZFZSU2NQRm9ycTBYTWRla2pINWV4UmFQ?=
 =?utf-8?B?U25Db2N2alV0S2tMbDBnRGt3VGxMaDRHQURwRkljRTk1aWZKd1V3blNYRHpP?=
 =?utf-8?B?U0E2dVZjS2M5dzFTOS9ob1h0cWxwOXhJRHFGR0NXcGR1MWJJYnpaaitUNy9j?=
 =?utf-8?B?d0JOZWlNdnNZNWtZcEhKVDJoVVIrZmdGdFRJdkhWSDFtV1cxM2dqOGJJbDVr?=
 =?utf-8?B?V0NtSWZLRUhibGVjUk42MFNpbEw2cVJzRUE5NUx2Ri9WQWNzMTFqVHMvNCtY?=
 =?utf-8?B?dkE3b3RGK0Y5UUVyV21hSkg1NjRpS0wxNFk4Q2NYZk1BSnZIQkNPV0J3UjR0?=
 =?utf-8?B?dVpNUEhnK2wyeUxrQ01pTWtQbUtwT2RKMjR4K3QzMWN1azdWOElGZG90WnFM?=
 =?utf-8?B?dTZKNGJ4S3dXOE04NW55MVZFNWxLZUhPRys3bG5YaEtIVURFbnFJWFNlcElm?=
 =?utf-8?B?UzQwcjQ0SXUyVUxqWEl3dUY5TWxicFFoYWNPODFRVEhGcjk5R2R3aXB3dFRl?=
 =?utf-8?B?TW5FRi9yMjRKUTlUV1lpNVJzaHVhUVJvbTZoZ2tpN2ZIWi9STUpyVVZpcHNa?=
 =?utf-8?B?R3BFMWc1ZGhVMTdjbWhIcFE4UEFETlFHZUp4aloxTTBySGZUVlhCWDRJU3pM?=
 =?utf-8?B?YVA1R2tJZ1l6Y3N1MFFnYmVYbXNYSUsxOEtIQ25qVXZnbnM1K1ZNTlMxNlZs?=
 =?utf-8?B?WlJJVDh5UkJMNHlMS2o1aHZQZ1lkQmhZS1A1QklIZWVKMFRSVFVWOTFZTUtY?=
 =?utf-8?B?S1FwcXMyN1piUlE1Q29zQTdweWtDN05GS1ZZK0tLNnh1YjFTQWhlQ0ZvemZj?=
 =?utf-8?B?RUxzS3BiWmtjbS9wK1IyRDRWbjZFU0w4UEw3d2lxazlaZFkyOGlvY2N0a2hj?=
 =?utf-8?B?N1VaUkFLM1FCRCt6QURkVWo2SjdXaWpIeWduMTB1SzFzMU0wOEVuRkZCb2M0?=
 =?utf-8?B?dFZFc2ZOR013TzQ2Q0Q2MHlGdTBvNStUbzE4UDI3aG1wMGJWU09kc1k4bEJ1?=
 =?utf-8?B?MXpyVm85VG5IK2V5WTh5UTRmWE9kQzQ2KzBxK0M4NHgyb0lOY0MwZ05DWTNO?=
 =?utf-8?B?d3JRS1dzK0RQUHQ3Z1JFVFFaS2NvSHlDNTNheTJYQ2lTZ2M3akNwZnRrUlA2?=
 =?utf-8?B?V25KbGFScFJvbXRCYkVJbC92dzdNd28ydXJhY0lQZFhkUWhLU3FkRVVLT1dH?=
 =?utf-8?B?SFh5bHZDSnVXTG1rNXpOd1kvVm1iRzdtV1ZFRjNaME1NczJvR3dvRzYrOTFz?=
 =?utf-8?B?aEllYnJYU2tpSzJjQzNrT1F2OHd3TGhvMHhBdE9zS1hSb1RTV2xmN1NkRVdq?=
 =?utf-8?B?d0J2djdPZGt3UUZPeEROWDVHcEhub2pIREVvUDQvL21MQ05hWDhSVDM3djcx?=
 =?utf-8?B?ZUxXNHAzVUFqbkxvcDlRbTUxV0NiTkN6NU9mSDM0Vmo5N01XMTJZZzNnNzg1?=
 =?utf-8?B?R2pxZy9wOWlKdVNwblBUeEhxNW01eDliclVnMVZIOCs2UjFwTU1TTmpKMHA5?=
 =?utf-8?B?L0VSOW9Xc3k3TVkxalJ2M2JqTXlyeFNkZlZjRjFPVEE3SDNFVWVQTEZZZFRR?=
 =?utf-8?Q?iNuWqeNu2N3EDSkjPr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc950f2-1c3a-46fe-f88b-08df199137d1
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:39:20.8154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qyWA245r4/SiYOA3Y0QP+QZ0FZvMe0rVOLhZxUf1AYiOVCLc7CRW6v1+yBuIQaK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170

On Sun, 30 Aug 2026 16:18:04 -0700, Nicolin Chen <nicolinc@nvidia.com> wrote:
> The driver programs and enables the event queue unconditionally, while the
> PRI queue has an ARM_SMMU_FEAT_PRI gating each of its touch points. Yet a
> kdump kernel wants to leave both of the queues alone, which would take an
> is_kdump_kernel() test at every one of those places.
> 
> Add an ARM_SMMU_FEAT_EVTQ that the probe always sets, as the event queue is
> architecturally mandatory, and gate the queue's allocation, its interrupt
> and its CR0 and IRQ_CTRL enables on it, so that a later change can turn the
> queue off in a single place.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
