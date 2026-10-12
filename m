Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14EA374E5A
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791837449; cv=fail; b=PR2yxa2UMCNMiHqmHk+zl1nNWZOkYilnObpFF0vADEYmPJ4pVtV7/1lY5K7+jHaFhQ5vf3RK8xh5bdZ3Zi3u1Ctu2k4l5dr+JdZf5E96/gip4ln9OBDmgZ/IpazaBN429guDYruE+jvmZb1c/v8gTx17SpNnQO/m9x1LlhlChgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791837449; c=relaxed/simple;
	bh=lMZ1x4G4it+CMwFwhK905qNI+FwXHRpJ5AMqWeh1c6E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwOF9QRUhgrke76Oi0vYwh9xA6NaBVfNHa/d81Nlu9+LhaclGeQOwMeSNLCOZR19Uz+2j/yzBiTBGh6bstYJyvD5CxwrxD1YELX59fsGx8gouKP9g8QGaSwbWxN8EEHJzUnFMJwAFwba0VQGShzlekAUDALiNEz/412XHAThdr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pBYdJVaJ; arc=fail smtp.client-ip=40.107.208.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pBYdJVaJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CStAggHYQrtr6l9SGQx7j7uv1DTGi3N4xzcCnEqWcxq0ENtDCb5AE/waHu2Y1q8ouQpga25D1I6+QMNVW9Hs/11FXm4dngvxtrvDxVt9gw9m+leqpM2X7xHtaDl7A4cIiY0YybKt0JwCdc+a1RyDyYoZRbE1drI+BABR+7bkRSfz/UaMA7nOokBlNogtFoFHiMmO/ABUR9T5qaYgL9rUBpiotYgOABP/cbqTEiU94EBtt48q/RcTmjs0RVV9rCxOOf/rnUgSY5dulHNpmByFeT+mc4pVV/1Cb1o37tOqnXE6/h0MtcuytDvPvTv3RxVe7skhFVLb8a715VIZ1mWMug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXAypmjkzsPsccnpYZ+pz+KKsjx6A3pa0OCFGNmIXX8=;
 b=lD3aVGBrpF/L5vL/VqqQ1MQ2wvOwB/dl/VhDMBtE+/R2xZBtnhVnRGsoRxDUhgx4gunWhKG6MWpEX9vCMhVM8/Vn4r3LC00nQzNtUC3MGuL8bxy5TxQ1vUCIGocUsnJGgelCIFMY63SzWrUSbM/yZ48F9iCB3G2VkIuQ2nakPfQ8Yffi4/h9GF98Xn3ufuTKU8COgpWeFJzCohbTTE7Ae9JO5eY9po48G8YpiHVjh/SCFpGSFZOQAsuiDETC1h5TMlSZlDOlIKWNoIXIEEoz2fGG+Hqu1IPUUMimBwR+b0BVJjqtF2jGiMjNsjAQh0n/X2aoed43MTTjkjqwgtazng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXAypmjkzsPsccnpYZ+pz+KKsjx6A3pa0OCFGNmIXX8=;
 b=pBYdJVaJWDxtXZGjsXSAaDa475Pwy6m+k67R27FbTUy3HrB8TPZxl8vQCGMLh9/yHDSUzHxE6PFOiIvcZaiqHzK6hckfJgG2w+LIkQs13OCEI1mIyWB3I752qUqIxdxvJ6WbRUif133ERIKOXJZlOTabJgvqfsqj2fF6X+vbitustDiomFAGnAyybUGC2Q8Buz12xMG0c2l7Wa1FcUBsMqBkC8vfLR3O1jegGvvOobGOea+Q78WmfE5f+ow8yMkWJ0PMX89w6fRfuwWe5WqtQfhkdZapyrpu1wSqiVv57lTA4P/lvz7W1J0clGlLHq4wI/UfF5oZxaKs6GS/PnHYEQ==
Received: from PH8PR07CA0048.namprd07.prod.outlook.com (2603:10b6:510:2cf::19)
 by DS3PR12MB524383.namprd12.prod.outlook.com (2603:10b6:8:608::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 20:37:23 +0000
Received: from CY8PEPF00000058.namprd21.prod.outlook.com
 (2603:10b6:510:2cf:cafe::a3) by PH8PR07CA0048.outlook.office365.com
 (2603:10b6:510:2cf::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 12 Oct 2026 20:37:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY8PEPF00000058.mail.protection.outlook.com (10.167.247.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Mon, 12 Oct 2026 20:37:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 13:36:55 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 13:36:55 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 12 Oct 2026 13:36:54 -0700
Date: Mon, 12 Oct 2026 13:36:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>, Jean-Philippe Brucker <jpb@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Peng Fan
	<peng.fan@nxp.com>
Subject: Re: [PATCH RFC v6 2/5] iommu/arm-smmu-v3: Delay stream allocation to
 inside the mutex
Message-ID: <as1E40DCc+u8I66P@nvidia.com>
References: <20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com>
 <20261011-smmu-shared-sid-v6-2-cb76b89dc612@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261011-smmu-shared-sid-v6-2-cb76b89dc612@nxp.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000058:EE_|DS3PR12MB524383:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4b6ec2-d7e1-48f0-a06d-08df28a09e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	a/HacVqqyur3i3cWUw3FWP2dnSAQqNQDbgLr2zQ44aBWbDi+PwhySEZlfgHXOwuOwwlFUWzN4b72NmVU7ox1GILAatnjWYLONHb1a4I2bOo3cOaWxnErqAD8Ojtww9PxNmlBZYoM37Dk/ddRY8nBPlY7dYo+PlAlx3vlbs0EgSOKwZoVqwo1Z/0aY99nRBIMep/76dHnn3EutAqbO8enifwK94sEErxzIRhrK7hS16yXeCFsYctnjw2nGUP2rqrjKiMneek77NpdBxynij1uUX+voLI0DTCefeK77atqkMnzLmdBWi2tUmimhJ1rjza/mo/0zLXqiBRYWZLtYON8vEOdloWLt9DosPgy34Z90GuNdxjqjJ8GEIXFRMLvpaeSvyozPZ01HAz71eagCfJ7c+sB7QLsshKuqhK2WWnZp8QBg+VRqzdBQyLjTW58c/hw8xkAZ8lSq3odrKhnClT+IAbaJOlYx1xP8i7E8w8t8QQuHdxl1P5i9XLpeLuDKTU0ZiMgfZBrALt3ecxIPVjb4N9Zod7nwqz1AQ+JHebXLifDf6N4/fr7B9KW/8wKZ7iAKhaQhW3T2Vpnu+FCC47ntqq9/b1ruYL9U+TejVuswc39ZanqYDZ2t9xxWL1E24IOWSCYDYyd99qtYRzC7PcBIhK3cieGDnel/g6SC4iVEYalT179x9o2VlPePRcktMLpNQ7D4uR/jNThQPkj4+J6kA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ahXq5IutnJPmT3Y+Gc4An9gl1Q74q1c+5VVCbQ88Mf87xXyU0YHfr9p5Yq75MEYihe13EvooPROx2MBTDsLB+MhKPKOUWnm9/70nXnynZgW083meIEEgyb0/AMqgMVzMnmCPMoen/5A+o7d831CEsXTj6NsUq+MM7TJ3xFdm5ZKY8wtQR8v5xu16d9Vp6tulkD2cEsxopIXs64Mu0spL8j0XJIerIaGrfwawF4tc4TmnDF7zDlIQS6RpHyiuP1XP86st6OcA6SzCLbENligvrAYTuqBEQqAELREVhPzSqXDtJoI/KEb8MOoJs8InKhd7R3cw56supleFoJfsAW/CgqHnqd6p+JEI3F43iOOWlCm1JUdzWkJeBLWu0BLYr8KYGeeV0KDEr/revzxS3SQH18YaBaHbMyAqG7qyppItc0V7jXAWeyQEAGjY8vPXhwFF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 20:37:21.9383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4b6ec2-d7e1-48f0-a06d-08df28a09e04
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF00000058.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB524383

On Sun, Oct 11, 2026 at 07:31:26PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Move arm_smmu_stream allocation from upfront (before the mutex) into
> the mutex-protected loop in arm_smmu_insert_master(). Instead of
> pre-allocating all stream objects and then inserting them into the RB
> tree, first look up whether the SID already exists in the tree via the
> new arm_smmu_find_stream() helper. Only allocate and insert a new
> stream when no existing entry is found.
> 
> Duplicated Stream IDs from bridged PCI devices are now actively
> skipped rather than stored as duplicate pointers. A separate write
> index (n) tracks only unique entries, and master->num_streams is set
> to the deduplicated count. This eliminates the need for duplicate-
> pointer tracking in all cleanup paths.
> 
> Extract arm_smmu_find_stream() from arm_smmu_find_master() to provide
> stream-level lookup, which will also be used by subsequent shared-SID
> patches.
> 
> Extract arm_smmu_free_master_streams() to share the stream cleanup
> logic between the error rollback in arm_smmu_insert_master() and
> arm_smmu_remove_master().
> 
> The sort is moved after the mutex section, since streams are now
> populated inside the loop rather than beforehand.
> 
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Assisted-by: LLM
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
