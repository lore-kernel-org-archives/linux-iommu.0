Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68823BFE26
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735408; cv=fail; b=aUhqRnEwIkOaD3q/e4eYBz5VVdehZ63edjCVsiUmLlradfhTNIH9IDVA1sM6zKPYs+HLZoP9NjqxOaCsQuSUZMKNrG9cOb4x7sWH+LZTAllsHzCOkm8YQuWbStPCeo+oassRQ78kZ3KBuukkyL5sX5I3yFe2VlesjA3JXSOd1vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735408; c=relaxed/simple;
	bh=jQS0jusc5H0KlWhxwZPIFAumX3X016OzD4KGiXQ1AAg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EEtApXTVsYb51LpTm78wMB6PaL1qwv8iII9YvAS/knw2ec475fEUXiJ+1Yr1umqbt/GcviyE6uqZ10Icpxl20dLSFUYcTJpOKelp+7YsuVtzrywaidRA8vJQK/1h/GihxSi6XC8oQ8RIt+rRvC+x3qzfmvo2vhZqCm/0N6s8IGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E19Q1NNd; arc=fail smtp.client-ip=40.107.200.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E19Q1NNd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWQxclUi4aQHWrxgd8YujWb5L/GuGZHffYeUBXdgDdUzAvNaV5oqioEw/oD072u3dSoyYIxowM/EQtuYDg2YiSGJ1biUnS3on9yc8KkMqybAyb2ETR+fDF0V9JVQhKZf7JVnBYFxLarL3v07yOCg+YC6R4MvBj5WHseKfLkgJ1Kzkq/g8bTzjyUpjNqOjon/Pxqxkb5IQuG9MjVPrtVysnpPDMMqTVAiyOihu3tN+rYDCc6T13egPNSti5Sye9im/GJJF5DyneLjOO5WI7y5bSrseg3RPsLC9bF9Gf+GUs2hfzrK1e1OIVYcvBUEJ2wVoI6/CPdNeo2yMJAsOfa/tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bm1QVkbfTrP7yEPLrN5/kvWs+gqDrHcnTkRW1AakAus=;
 b=ktmwGm6XoGd2N1w1PM6F/HFm7asNqKmqqDvbP55Yn5tB2IJ+qpUyhs6hU+Oq+16JNW4SW53hw4Ho5ZgEjPGiVF/j8Q/ve82s5ocd+qPi2eyLpqYafZTTnLbDfEVYjGNuQtNMnflHUJMM1LKWrxMCvVPklEdk5WbyEr9uOXNgzwjpt2FbFs+tCKpV3R1xA9KTppnYKzfGYNlaYiPMuqARAWTeAprlCq5l3vpMtlgK9k3yJCZK2QXuHnxVzMoqiVPjAUac9mrUsn5HRMVHQG/cce5iN5O52O7NH4GtHB0mZBD7dy280eTXBA+TeyE2VGxiba7Uhl532m0xH2tV1Gj+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bm1QVkbfTrP7yEPLrN5/kvWs+gqDrHcnTkRW1AakAus=;
 b=E19Q1NNdd0VmjXP1jk4JGgLTDGg5YRVfuBbyua/o9l6EOWGWaVBsIaULw5c10aq2uR+wSLW0F76u2CbPReiU3Q7MnrawSM59Gx6JyvgCvByU8n44d5YZldldJ8vM0klcAIFskr9K/NxM0FEki2gvGl9N4iNPWf5D6JTJA2ejQJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 11:50:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 11:50:03 +0000
Message-ID: <8975e6a9-89fe-4bb9-96ed-cb2522202b92@amd.com>
Date: Thu, 9 Apr 2026 13:49:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove obsolete file entry in DMA BUFFER
 SHARING FRAMEWORK
To: Lukas Bulwahn <lbulwahn@redhat.com>, Maxime Ripard <mripard@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Cc: Sumit Semwal <sumit.semwal@linaro.org>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
References: <20260408100819.458347-1-lukas.bulwahn@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260408100819.458347-1-lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0882.namprd03.prod.outlook.com
 (2603:10b6:408:13c::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: d9fca96b-f511-41a6-94b6-08de962e22bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hBe/g/nbQMe9zLVvjVwJvESJu98Fl5iCbvhQHghxa89+KrA88JagC6nrrclGZ03MEpGdM1oaIVz7AtGd8/da2UKOr3xxMjpUSg9Hd2hDL6SAzSCJq7oVw4Dr7SNe+gK2RmlFvcvKq9c9E3npCGTzlIip6oN6OBhHG/NmfHF9yy+vHE+95lTE/PD/rphjPo2TV8r06xy4vIZrCJQNikzVNay13pu6YHeqi7m7A1JPaZNZXtDQk43uZ42aJ8AXx6F9lgyszXRRanUpWt8n1WhLOTLqsAnoE5RojwNTdlxSTmOorj0BX3u3WMslLmN+rUXFF1Bp1EiSeivkYrglJfx/UVs3Czaj7iEtyygjlV7MuAk+9Z7Vkv3VgL01fRNrg0zDi3XaT6dcM86omAYyckI5penlrtWJgXs/VECX9nJ0x/RZhzjdQ8FSr6qptTPjBL8Stkeb/IKT6TuWS+GxokDdR6HWcX+ktv6yfzYEEQ1LNHIum9Nt5LWt6JrhMsKvPqg5wWbsSzANE4deN/40A81JZpHAhR1v7MlJnQXD8JQvFuD4DWthifu1Quvm5VcvYzGdpJ4E29BaNIOQiCVaFBz1POpO8ctGN+U+rqKuCzeYhBBejfHxExjPdvKsaj2eFwDuT+OtX8XP01PtNd00bjrkkqwVett2UwaumKeG/SxjjDTpijv+0GwT0LUePUpkT3m4XwMoNwmv6VXB8AVpF09kujoot+hYYS+CQlgBXoDlLHw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVFTdHI5d1EvWkdmTUs1b016YjhtWk42VXFpKzdBcExSbm8xUGxJMFVkcTJT?=
 =?utf-8?B?eno2UWgvNllTT2lDVFIwK1lZQUlPV21FaDRqcmhIcEZrdjdXMFJ5VHJuL0xw?=
 =?utf-8?B?MHVuemZ4MURyTXdyVzFkRzVqWS85NldDeStDL2VCYnRteE1BSk56Uk12ZFN2?=
 =?utf-8?B?TGlsYjVJQUFHY3FhdFFTQ2tlamtHV0ZBTHBtanF0bTl5eGNuc0FjS0pJMVNP?=
 =?utf-8?B?d2hFZVkvbTNDNW9rUDJzSXdEUXJzblNTd0pYbUE1MVI4UkVDbWU2TFlyTGlV?=
 =?utf-8?B?SkNtUllOYjVudm5qQmJaeFM1VnFybHJpUHB1dzkzTHBGUVhuVHRlZHFCMUw2?=
 =?utf-8?B?MXR3b1c2WXVZSHFTRU44bXQ1WVpWUlFOUTJtY2VVbkMraE92dEM4VmFKZm1s?=
 =?utf-8?B?ZHhsUW5QRW1aVG01a1RBY2t2bC9kRVhVUnVUSERNTUNWYzdaNXo0OFNlQlpE?=
 =?utf-8?B?ZlBrbjNrN2ZIZGwrNWdzWExQY3BKNitka2RsUHZSNURwTTdBOHRHRmRXV2FF?=
 =?utf-8?B?N0pReEVjd3dLZjMxQlU2MXNxMFM1NjV3Qm8ybDhvN1plR3dkdFI4UlV1QXdX?=
 =?utf-8?B?L0IyblZVemFmT1VpbUM3UVZ4ZncxMEI1NVFEam5PRTcrYjZ1bS9CM3dOM1No?=
 =?utf-8?B?WUhST1IrVGhIbHpXQXNJSmFTNlpVL0RtbHYxQ3UvWWFHc3l4NEIwRXF4QXBJ?=
 =?utf-8?B?WjRTRmdqcDhtVlUvdmJLQkhNb0tHVmRSVk1zY0RlOTdVdUVxdDFzRGR5R2sy?=
 =?utf-8?B?NjZLaEhEa2U4dTYvN1RkOHZZQ09nZk5aQzI4ZE9HWmpUWllXZkphcU5nL3JN?=
 =?utf-8?B?SVltR1d1aUUyUi9IYlV2R05aaTRCOGcyRmdmQ0xVOEVYZ0l6Mzh4bm1QeEpo?=
 =?utf-8?B?U1k3ZVdFalpvNmtlaytXbzdZSVVPZ0tONmFtRXBVb0U2cTNTSXBtSFc4dVZY?=
 =?utf-8?B?bkJIVU5CYWNsM01kTGlCZzFISGJYVGhLNENnaGVUY3R5MVJoSlJxZWpuVFhn?=
 =?utf-8?B?RTFINDJCU1FpUW9JWHl6eTI3RVpGSG01SU1wNWkydld0eXBCY0pJRkdqc25C?=
 =?utf-8?B?dVhRZFpIT1M1Z3ZYbTByeStKWmt1OEFCUVlHa0xVbUlCNG1yU1ladysvcEpH?=
 =?utf-8?B?dG9PN3EyOERJbko0MUh6WkdYR1pTSE1sNjJWMEY3bVY0dGZNYi9RczRsR3lG?=
 =?utf-8?B?Z1JWQXBEVTF2eW5oWGtET0FpdTFCOENMdHdIdit0R1ZHOHlJWklPUUFHSDhJ?=
 =?utf-8?B?YzZsRzFoUWxoZkltRGV6QnhualVDYXUzQWxnckszSncxcXJBY3VMcDhnWGVh?=
 =?utf-8?B?VS9sSzRMK1pYc3lDeE5xaG9rUVcvcm1QMFlsRmhLVGthK0lYbSswdi9hencz?=
 =?utf-8?B?dXFMeCtrQ3pUQ2Z6ZGJDWUNEMFdsVlJCdy95OWVSVGZTRnB3K3lvaURnVXZF?=
 =?utf-8?B?WkJDVm5seHVPNUhKRzNZZ0VOZFBCZmlWSUdZd2EvcWloWHZqcDdTa1NzdVhi?=
 =?utf-8?B?VXRQRWNhM2VibjA4WDF4d1lQYUlNWmxURjJsamlhOWllNDRUUm9ldzVnRmlx?=
 =?utf-8?B?b1ZCZXRuQjM0dFZ5MUJLR1Qrb3NqWDJ6VXZXWUNWRmFYM1JsWERzby9PcHZi?=
 =?utf-8?B?eWdOOTFLT0xwRnZSc3FwZm44V0xMRTl4d1cwQmdTTG1GQmVZSGpRV05INGVP?=
 =?utf-8?B?OWNEQjNSempUWWFvZ25LNXBQMzRqY3FsbVNZMWM5NU1jNjJ0RFlUZE9CaVFa?=
 =?utf-8?B?VmZtTHhQR1ZmL2JqMzVXRllWZi9KcXhUbElEYWhLN3dzV0NPZmJwUlZtdWNQ?=
 =?utf-8?B?K0g0eDl5V0pjOUc4Y2l4SSs1UUZDUVAzV2x5NGkrMHNsaWE4c1l1VnBjS25n?=
 =?utf-8?B?WmdFNXJCOSsvLzhiUjRNSEV2U0FUaEQ3V1A0MTJkUm83dVIxbXB2MjBHaDRx?=
 =?utf-8?B?eU1DVVRwenpNUW9ONHE3dmEvdUpIOEVETExEMlgxV1lDcVg5c2pnQmFtcStM?=
 =?utf-8?B?Z0pMelZaRms2aTNvMzlqMW5GbllBbHBEYXlIY25EbVRiYkdFZy9mSm1qUnY1?=
 =?utf-8?B?RElURWwzRjl2cW1WUlE2YzNHSmRzWnFqNzhZZGdsZmpFVDVNbkJlUjdMZll1?=
 =?utf-8?B?TW9kdHgwM3pnNDNab085UUVGZlNqYS84QldhWnc4YzliSXUrOUUzTUFrR3Qx?=
 =?utf-8?B?cUlIMS8xMmF5cVlHdlAvbEtVcld1M0tkY3VRUVd3Y0pFSUV3UE4wazd3OHdD?=
 =?utf-8?B?dGhBMHVhN0pDbm93dUUrVDY0b1lLN1ltUGcvdkprcVdGOElaTHNNV0FZS2Ix?=
 =?utf-8?Q?Fps2wHCysVZYauOoYo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fca96b-f511-41a6-94b6-08de962e22bd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 11:50:03.1462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xRi/dygSsiLdMVSJPMRtL6fq62D6CHRkh54Z/uohhAjmqD8lFDQo+y4RN1cze1v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912

On 4/8/26 12:08, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 25bd73562941 ("dma: contiguous: Turn heap registration logic
> around") removes the file include/linux/dma-buf/heaps/cma.h, which is the
> only file in include/linux/dma-buf/.
> 
> Hence, there is no file matching the file entry include/linux/dma-buf/ in
> the MAINTAINERS section DMA BUFFER SHARING FRAMEWORK.
> 
> Remove this obsolete file entry in DMA BUFFER SHARING FRAMEWORK.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 10d12b51b1f6..77c0fc7ede03 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7561,7 +7561,6 @@ F:        Documentation/userspace-api/dma-buf-alloc-exchange.rst
>  F:     drivers/dma-buf/
>  F:     include/linux/*fence.h
>  F:     include/linux/dma-buf.h
> -F:     include/linux/dma-buf/
>  F:     include/linux/dma-resv.h
>  F:     rust/helpers/dma-resv.c
>  K:     \bdma_(?:buf|fence|resv)\b
> --
> 2.53.0
> 

