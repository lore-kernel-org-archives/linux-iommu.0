Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013038.outbound.protection.outlook.com [40.93.196.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499E8238C1B
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 00:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362236; cv=fail; b=bvwMlqNpzuFr2l48uSDQqF0IyvQpJB9KawAvEWK81AQNeJU9tqKFxNM2qvBqf8UYCwfOAJ7T45TwD3MjpCKNSlj2bSwV9UMmS8dEO9GbfDIqGYBAavSwf+5lSWi2vyYvtuAcc8Xv8Td3A6pXtuq9IcFku3a97HsR3wvghQN1caI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362236; c=relaxed/simple;
	bh=mx3mnQX8mDXwVMTpNNa5/Q2Nn/YJTHPEeuJT6RhUbB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vCZ0pkLNl8N6/E0uLuyR0tLc1LmGHfc9ijAlNKjiN1j0Zk/wwYyMfjbZFcNfilh8hZTrtx6vmGGAmhLTGrSRZFXlhucLzqNP9O5elllIOhFpCOJ09fqmqZf8oMBxCB4QvlUSWcTRrsw9y1E9OfXaj6muaurV20ZJfUD4wR2b8MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fhRcf6zT; arc=fail smtp.client-ip=40.93.196.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fhRcf6zT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yi73da0NL6I//mwbNKHAXo2C1FAZk3YFIrtUvrxCVu+rqnaIgp7++wQpSKcwzeRDbIv6Uckw05XSPimf4Q+5sZVepUqECRpOh7THHUqhLaTizmmD55qHKkiHd7D+tTQnBGRlA204mgA8vuBKMqKEvArfj/+Ea93FkJKSqUArgthWXqSFOQ7Jk0C5hJBH8J33/CYGICruxserVX2SAQOj5eHMixUO7Sx7MSYI0veEPMl3tN0l+GxihTs2pISdv0Pf9krhUsJgKGwlt+t5cRUbl+s5YMOXKtPQEyr7KRY0XavHVlwXoqv3FtEhFTDFviyoAuwxeJHIZRVCchZUnZ976Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmejBqbIJtC+UqNVD1d4E4u2Dufyy/RF3x5334S8FfU=;
 b=icALlW/G+YIlNPvejttY6ol2qKaN7JPVNYRYJ3LVbkHsV2aOVy98DFTC51Z6j7BF1HOwZsuUp1q0WgrpKCmrUPN8vO7PxP7z2f4otuMHPwK186ep+bdqmRB+sFA4i4Xw75eHhMY/q5OhvMmhvYSokpNvGFuX2seaQNZjO3DiiMQF6744TIpTrNA6aHbLuUthGMTcmyCif/I3WJYCAp4Ril/5FkLdJ88FmCoebZC6SGTD8CjIxGhmZrs20xZU7y+DjWWYxJaFbrpsqL0Cys8Q5dQEnNjWrliOwCUPCLWHX0AEVVJIkcMvR5/cZyVOsCbyrT0uKygE5jbmU102uXLJLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmejBqbIJtC+UqNVD1d4E4u2Dufyy/RF3x5334S8FfU=;
 b=fhRcf6zTg1ptrzyC0mziCijO/x8GXjQh6Ym5Hg7e1DeNAygIgIwia30VeMgHC4MpKErW9jY06oSdlUzsCp/jNhGy9g07fmmnIKQLmUCMLneJKWadW+wJS7QNOnLzdt5QKUIaijFYF0aUG+N/nmQpRB6FzJBeUIuOPInijjKIJA1UpJ1jvyJ+/JUQ+bSzYZDhbNRC9NwWbAZLGVwXoX3AYWr4n+r0ST3ZI4JFYCe9NMFV/iYJUxKr1n2WfPCribd4L6OpEdzWrGRu9/mnscZlUo98GDrj8fTOC2w+lMMbgAQfAavrjsqEKVZx6lTPYuFrYq0af+OaNZfl65diqVlchQ==
Received: from PH7P220CA0173.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::6)
 by IA4PR12MB9833.namprd12.prod.outlook.com (2603:10b6:208:55b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Fri, 13 Mar
 2026 00:37:11 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::64) by PH7P220CA0173.outlook.office365.com
 (2603:10b6:510:33b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Fri,
 13 Mar 2026 00:37:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 00:37:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 17:36:54 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 12 Mar 2026 17:36:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Mar 2026 17:36:53 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <linux-tegra@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <eric.auger@redhat.com>,
	<skolothumtho@nvidia.com>
Subject: [PATCH 2/2] iommu/tegra241-cmdqv: Update uAPI to clarify HYP_OWN requirement
Date: Thu, 12 Mar 2026 17:36:35 -0700
Message-ID: <9ef47d0db2d7b8207fef1ef4437de6efa08565b6.1773361875.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773361875.git.nicolinc@nvidia.com>
References: <cover.1773361875.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|IA4PR12MB9833:EE_
X-MS-Office365-Filtering-Correlation-Id: eabb2f01-c484-4c3c-2abc-08de8098aa17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	COlKqKhEWKRj3mnalEOiCYIx3rDiEZgc7Jp3gEm9csBfQ3mE/SCD3PPD9tg2aG6Dl8OiZRtcVCVIyUGPsQ0YeLfkYaXbKpaoeHSFn0K8nI9CFnCbfBUgsGT0hNyox/LyVnJhdMkHDunVSmpE7utIHoLeshT51K3ZmlNTJ0mUSbmezr3UeZvKGljG1wSn+A2q+nOqrJRZHCMmSpb2POseucqdWtSmYpc23TjQwtZPXiRBIlOIrEHmHJ9zH8i663oJVvgTtKw18fmrtCb3xNU4wSBhu2khM4i6EqDWHtwa3oTKew7gHtXLyFOcSwayljeufKEd1YZxVkp/f6urFSQ1WYvV7T2iPpP5BdCi5o07+9DMXeOSt4bLRiylxo1+cI85W+mOZKbEY/NZOtF3EUEy3Jw+pNKWbjzCSY9E+I1D3twrbKC4s0C4qgygXIiPoUHrrMIzvuKLdUV7To1MX7MKGfr8PnY+3Or+c+SYrMQA+XvvOEY/brpjGGUb9tdvxpUU7kmRW8NM4u9zIgGU3E6XmoeTsv3fvxDhnCnj4+BcXrsmYKZywTxs7gVdpYjIYEOg0wTy5hZoA/ZX5mtJq70P2tyfaqcFYXeMZ5ajQ8Yy1ygO7w7/8+V2dmcdoAXZ3O6DtJOKUJE2TvwekqS9zw6wM0DpblUVNBRMa6khcNpCCfCUFK9dBxDrjNfOoxQEK1xiGZ0D/u6Oi3VLTu+kH4cmTNvw6kmaruaxiTEAx/jqRB4f9MRKa6lIj3PneNbb4UGY5KhBiTcpxECO9eVf16/jhw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JHEHRS0sPtm1/LlPws9Yc0qmidzmgk+8xYb64Wh4SVSPx9AURSfbiezAvLVcN49iLHQ/dbX2mr2aJUy/k0rRGz++JQNqM2UFrsy5KlnSs15RS9s8HKFW8mcZQe67UOM6qQU7q3xqMVKO3bvq8h7U5czvd19qwYdqZtnhfodv3swvBuIPHxPlYZqz4e+/QPPgGxBPURULvN/RU+MWsewthhVVM8u1Q56HNg6rvGy0gKKBcxO4dV6GsOce/rdJCtt9fHIF/1CWWUN2Fj1AGYT9k8I856kghv066h46OKiEyGU9hjeEpUzY+gM5eINCguPj3lcjwT5FvxZGOfzwNdn5/QeRaJTQJze7QRea7hV9AZnNCQC+Pp7MzO8dQVuyqrcRHAfqgP0PwZK39vjiosMx/si2DZMF9uPXHm6Ht9Ih69eKwTN8PuzkPsaxNz89atQT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 00:37:10.8935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eabb2f01-c484-4c3c-2abc-08de8098aa17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9833

From hardware implementation perspective, a guest tegra241-cmdqv hardware
is different than the host hardware:
 - Host HW is backed by a VINTF (HYP_OWN=1)
 - Guest HW is backed by a VINTF (HYP_OWN=0)

The kernel driver has an implementation requirement of the HYP_OWN bit in
the VM. So, VMM must follow that to allow the same copy of Linux to work.

Add this requirement to the uAPI, which is currently missing.

Fixes: 4dc0d12474f9 ("iommu/tegra241-cmdqv: Add user-space use support")
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 1dafbc552d37d..f63edbe71d542 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1052,6 +1052,11 @@ struct iommu_fault_alloc {
 enum iommu_viommu_type {
 	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
 	IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
+	/*
+	 * TEGRA241_CMDQV requirements (otherwise, VCMDQs will not work)
+	 * - Kernel will allocate a VINTF (HYP_OWN=0) to back this VIOMMU. So,
+	 *   VMM must wire the HYP_OWN bit to 0 in guest VINTF_CONFIG register
+	 */
 	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV = 2,
 };
 
-- 
2.43.0

