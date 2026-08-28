Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A7B3806CD
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933733; cv=fail; b=BtDtu568xZ9zQ69Knvbw1FU9WNTQPSUWEpLLtvURiS2BgvfQQoya1evrGrmdUImgBZVoXGoAR3fRwLZe/lenKJsE1LXUSMStUKKpKUmx+6y2Uu8bdzNPvBf+M7wzDzVzGbZPyc0FS7m34YOMKTOe36MaMozrKUB6ekv9ksiZuuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933733; c=relaxed/simple;
	bh=OOEjbAS1MUINaMqWDR6sMV4VtoH2U97ujBYwTaPWfJs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rxh5/0YQ8baa3htfKlbJmsjGlx0tLrUJXxaHZIgFbEWos2CwFXXoafe1NptC0redwqiD7LdeTXTCnlkH2c9U0Uq0F/qpJGHou6MkoUMohucOVsZF3nPjh99gMQvS/ixb+LkXBfqegENrjMLJjEwnCtwC1oy6SE6uBMFAXIqRwXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GLiYHHpT; arc=fail smtp.client-ip=52.101.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GLiYHHpT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BM21jAW6GfyffkyKGi+Em3rhXt7gEBGnqqV9b1Ru1IgRPEYb5sfIZKoHzO/NW9ytaoAaNNcWq7mLhR29br3FP58AM5RKndilEfd6u0GEol4lehsyUdFO4TIVEol/JiJB6HTzHw8vt7ZpBa+D2x4czHkY3Qn0zodzcoaolhrr6ARYg/dHuFq2iDuGxLtslXkXTnc5WqahGCbvJvde8JyC8SDVSTnpFlSd/vLCe51pWyvU38xldjAbS6u1KH2ZtPwmuipIC3FoK/RxvioBaUeWKfGeSBKT9B5tdB604Gb9DQ9Zpgylf15Fiq8g01glMV3jadc2h2fC0IRdXFgyeA95Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N91F5h46GEsdVvPIGcLJmUY8syOiUXO23DUtpVzNeGA=;
 b=pu5jPp1s7Y/t6VghJlni1xYEeMzjpYQ1ATbXAl3YZA5mYwSJBSQXvP0aIWNrYi7LOq5EcN6aQ9sFORO/ZJUEUihZ+a/O1ycZB5tTDnJVO6CujV2jzXHiErRJg7y5JB93lfpxcyBbIeeoCwL4TX2B1qd8N7wD522ZhTdqBo4EnfK1AjbVO693bhZ+BTlrF7IxFHRYL+h51UDi9EUXfGU9Jo8hc4nFeg2GhpB5Ut+KZXzaTnZWb0/zBz9lNrIx+cZJ2tY7MmSNsRzibI2VSVYpQbs16bmNOAgBgwq53ni3yqBi42HNCGripi8+Byo71X9J3YQI9uN5ygoIhewSl91QAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N91F5h46GEsdVvPIGcLJmUY8syOiUXO23DUtpVzNeGA=;
 b=GLiYHHpTDJtCqiDZRj2LoUX9+WNqD1gM871kjpWOISpWJXBTlgRH7baOtM2lGSYfMINg2gRf3eSoZCv1uWN5G2H17ymfEk7z2ewafweMJ/9Yox2gTRSotshuQXWdd+JOQoZxLG4X4Q0nMQnY+DCy59jnUvUy011xvUuIQ4kJntsB7CVGtbX92wkD56IvB+03Q6uPumYswhqaZj39B6HWaDUaw+fSv0zjEGq/GAoEI2Y603Imuf1BhDk16Hgv0GJ3M5rAWKn4krtowVDn+xVuykQW+m364l9osXH8ZtHPY8Lr3KaxK5tLNmdJPDR3bYuQz/hcIoLEossdfxzep+IvgQ==
Received: from SJ0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:a03:33a::13)
 by DS5PPF7B9F1F8E0.namprd12.prod.outlook.com (2603:10b6:f:fc00::656) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Fri, 28 Aug
 2026 16:15:24 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::2b) by SJ0PR03CA0008.outlook.office365.com
 (2603:10b6:a03:33a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 16:15:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 16:15:23 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 28 Aug
 2026 09:14:52 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 09:14:52 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Fri, 28 Aug 2026 09:14:51 -0700
Date: Fri, 28 Aug 2026 09:14:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
CC: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@ziepe.ca>, <praan@google.com>
Subject: Re: [PATCH 7/7] iommu/arm-smmu-v3-test: Fix UBSAN error
Message-ID: <apGz+o0k+uz+UN5i@nvidia.com>
References: <20260828125409.1921538-1-smostafa@google.com>
 <20260828125409.1921538-8-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260828125409.1921538-8-smostafa@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|DS5PPF7B9F1F8E0:EE_
X-MS-Office365-Filtering-Correlation-Id: b9564684-d5d9-4928-1fe6-08df051f90ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|10067099003|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pZz3zL9CdqaWV7DQZWPYX0MMz8cLMky7HYXPYVYdi+7TNd4fETEXfnBYLKGVBiiXTvFJnHDFr/M9nQ3HazHN8fn99i5+Hwfw7E7lpOkgIFfUAQiv5QN2xoG31NwbRbf/Mwslc+RtpQPcLuKdZ16rPyi6CL/ixONnYY9vaotlFxo/QPg2gDKbiYfHEqmfRVnD5x+lmFPMKuLrt6Kd5fGJp28N7LHIVTqb9pZdXKcZ3SBTvntY0xIj2gHriL4n7Xix+9S0MEuea7+VXQouP1956n7E91J1nBRLYnRuimia1PYQMvaWdvOJT1nVOIdvGC+t+Fbb2C+OyeQ6sgQLjFEmw2B0E63zoc4QB3KapKeLcISGmX+6bLsi/Md58uXby3Ns5mNWiM0XyPmD0KMJmsB/OGrUIsVWtGcXrU1sGgpE0d4xScgNAAYGbn8KEA0/rzf3JxkY9hoVS5mmZCGfrIRRGKJ4U1LGoLSruQoTsfVR6+oAijldwDBIzj1jcR9+Cyfd74WQLe146QYG0O7bXLsVJ4FG07+ulDZ4zGbBaeVhuzbTQgJeu9YSZoi8l71O8xTRIDc+3VVjkGtmYQAsEvYl3Hby6EDDF4Ab+BVecxrKfNnuf0P0SO9qJ+riI6oHaIjr+oVTndMIHgj8tcz8oOz3Hy/PAs+L2mmBJfpR+GdbkMU6O+039gG5deSYX+vTaFnGrZQWoyCEW7AmJ/+CRjn4Hw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kKVfFKHb1UPiH4zJCbKFRSSyOOx4aFtbSz7DYoJgqLL5dskvOFdEk0kR0MMvf2YzIcVMwNGeEIUZ5pfpWDFnCDiqyX3H6m8Wzg/rltf71QTmKriKx3UqRTXZvKuz1BGdfKirsPstV9YDBElL9UR6K2l3UUlwHpqfHaWXx83jxrxkX0OqruOTTLJ/fkjJX/MKdiCanJGopIHV/zFnfqmOilMrKMIR9j1Z3vl4r4yAJlszDcxzX3tRSatydJcnZwyD2LzZ82Eude5sWkABPg8k21UQsrXRCKhqr24MKNkfpL/5R7rLMjydnC1XAyMgq4nT1ClunCaLvgWiFqsU/2rVjG8WAGb2hiPS095JBTMzVgJa0DF86NL3MEGt1N2zltUFDyYD+z3sEx1kHk4Sm2iy40Vg2D2EkPxSqgAoV/O1h2iKqxYPHZhYFAcoUj6ISjgt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 16:15:23.9090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9564684-d5d9-4928-1fe6-08df051f90ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7B9F1F8E0

On Fri, Aug 28, 2026 at 12:53:42PM +0000, Mostafa Saleh wrote:
> struct arm_smmu_invs marks its flexible array member inv[] with the
> __counted_by(max_invs).
> 
> arm_smmu_v3_invs_test() uses invs1 to invs5 which has num_invs = 3
> but omit max_invs.
> 
> This causes the following UBSAN error:
> [    2.333240] UBSAN: array-index-out-of-bounds in drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1116:21
> [    2.333604]     # arm_smmu_v3_invs_test: lib/ubsan.c:228: array-index-out-of-bounds in drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> [    2.334129] index 1 is out of range for type 'struct arm_smmu_inv[] __counted_by(max_invs)' (aka 'struct arm_smmu_inv[]')
> [    2.335375] CPU: 6 UID: 0 PID: 155 Comm: kunit_try_catch Tainted: G                 N  7.2.0-g8dcb331fbb72 #2 PREEMPT
> [    2.335759] Tainted: [N]=TEST
> [    2.335791] Hardware name: linux,dummy-virt (DT)
> [    2.336254] Call trace:
> [    2.336932]  show_stack+0x18/0x24 (C)
> [    2.338443]  __dump_stack+0x28/0x38
> [    2.338494]  dump_stack_lvl+0x54/0x6c
> [    2.338518]  dump_stack+0x18/0x24
> [    2.338541]  ubsan_epilogue+0x10/0x44
> [    2.338565]  __ubsan_handle_out_of_bounds+0xb8/0xbc
> [    2.338834]  arm_smmu_invs_merge+0x688/0x8ac
> [    2.338862]  arm_smmu_v3_invs_test+0xd4/0x598
> [    2.338890]  kunit_try_run_case+0x64/0x160
> [    2.338914]  kunit_generic_run_threadfn_adapter+0x28/0x4c
> [    2.338955]  kthread+0x10c/0x12c
> [    2.338984]  ret_from_fork+0x10/0x20
> [    2.339433] ---[ end trace ]---
> 
> Explicitly set max_invs = 3 on the test arrays to match the number of
> elements.
> 
> Fixes: 15a2a5645ad7 ("iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array")
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
