Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793677951;
	b=SOtLmmnt9bQdkfdBNfet+StHzLvCKfmUSbj3SHZZimEGTx+17Z+zbvA7MWVSt+ORKOtn
	 YrBbvi4PyC1UoqvszA3vAaTd/bK8wUAsm2u45DSpp+m6NBmm/jMBSU87HMfPHaNjCbCZ7
	 R3kC1PUi7mne9ezD9fYFLok2CsrQZWBWLpkBxmC3MI3giFz0LxQRoYNV6w6/wxGfMhPc+
	 yfyt1QzYTfjILCkzC7+f4F7aSBTJ1p0nKWQW4pXmasyZ4SkrDOE9GQ0Vcp9LR9Riha9an
	 sVRjergyhs2ivQ+Apr4htGnY0Fidcj2wZapBzuPLgBrymh6b3cIJprj0AgRXPPGzo9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677951;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=9KhrP3SD9o/Z/JZgXQAsLwSuP5qLyGrbx+j+21xGshg=;
	b=cJUQZSUir3u29soAwUjje9lPa0QAKED8gsjzKsmNlzCvRq0NFQPbslWMkGJvDayxIWCV
	 xkK6LFbIsUd9CVie8a+6GOKHOqgomc3wMgC9mUOvKrAvM1d0NDeffFbwKjGrXDBhMkQOW
	 ATM9GxRgrlh29jCnvopnA4x3LEWFLXzdFh0VWcDK5lgtQfpZyhqNwq8azHdkgqS52fGgk
	 Fowu+c3I4B2a+pqYJUQkZEz6qE9TQtO/LJmJERfa38/uJz6OU2NQNrr5wcJ99byMghff6
	 jPQxFq1Vtr6H0h3CtodiXdg8fwV4qut108alwj8iyn0rr6ldfAr6z64enekan6tZYdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jjwsZCYO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.13
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012013.outbound.protection.outlook.com [40.107.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB5D606A32F;
	Tue,  3 Nov 2026 03:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DB5D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jjwsZCYO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLoCNRZ8W/fmTEKHxlkHBFmFqlr10tPytrs9AE10ie1E9NEy19i4rNelY6cuCLyBVwZ/MhqHUzOwT0Bn03mjrkzWdO+dtzJgfa6DDnTDY8KgUntXIzPtBdM2GigOrZkP3NWxNCVN3WR4M1zhw7hZwoZBqHEiNoi2unqnT1+18C6kQXM10YwhmBUhiRlCZJfIX02owbfNz/HQil0f/wyxmAv6Ij5AqJXm274m8ngCNmhJljQckG3An2Syf53M01SDP8LxritA2MkG3356t6cQLMMd8bQwb8eQiPQepjOih9sq73KBDaY83n0RnzeMLXquXiIoQavB+p8PgrF5Qe4Cfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KhrP3SD9o/Z/JZgXQAsLwSuP5qLyGrbx+j+21xGshg=;
 b=fhWlkSn84G4UTU59LRoPjBmRxuUhti1xkJE0OCOn29QK1UGuvwL9JUT6kGUcOKxYjcplYTLiT8Le8rgWhexPSSt/5fXXG0AEA/J7EtP459kOrZrs17UY9D3/1P3AhmG21xwas3aq6SnQIRS0QmDzh1xTCVkM//f+XAwCRiazBJqkca2AexucXPSDgfDdLiCkToUShQtRpOIM8j/zrKBFSvo/uC3eb2086fV4mRWKe3minixylYqt4CzqLk3n7H8Z42uemkRK4jxtPjzFTGC4+dG+u4GevY+U3nWCSvqNk2Te6zhKx7/dXhd7XXxHUGHKgqV5jzcLvpCBR+yef/xJRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KhrP3SD9o/Z/JZgXQAsLwSuP5qLyGrbx+j+21xGshg=;
 b=jjwsZCYOrswCTRpQCiwEcpcWKldLXCWlHXE0f3du4rWtF2ROSgPcPtl5HwE0t1WpxlbUhwJaj/HPBvs3YtFA5astdnWWyEKuhcfQ7YwffZtCBJ0Ab5mLD/KinvuVp5+UhPxMrxLQiih/X1MY1ycv4theN/B83t/xMLTwItWVoNZ686Qu4ct4kdow/3/LRnoDNQ5f3tmQCYXGUv8UwOUEsMgh9FFNyvATEVs07eItDeqAQJeK8sLrOlcd2roeJf2t3pLDkASY7NNQ7fRolXurT+/BOxVN88cBBZsHu++QDiyN8FD8m/5XqPUyyIGzsflkTRmfFojZpqgOY2P+aR3Xbg==
Received: from BN0PR04CA0092.namprd04.prod.outlook.com (2603:10b6:408:ec::7)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 03:50:22 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:ec:cafe::5e) by BN0PR04CA0092.outlook.office365.com
 (2603:10b6:408:ec::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Tue, 3
 Nov 2026 03:50:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Tue, 3 Nov 2026 03:50:20 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 19:50:06 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 19:50:06 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Mon, 2 Nov 2026 19:50:05 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>, Johan Hovold <johan@kernel.org>, Marek Szyprowski
	<m.szyprowski@samsung.com>
CC: Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Pranjal Shrivastava <praan@google.com>,
	"Mostafa Saleh" <smostafa@google.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <driver-core@lists.linux.dev>, Sonang Patel
	<sonangp@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 6/7] iommu: Park TDISP T=0 devices in the blocking domain
Date: Mon, 2 Nov 2026 19:49:49 -0800
Message-ID: <15b26699e34afa00ac27bd626c8c42c3144e1cfe.1793676742.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793676742.git.nicolinc@nvidia.com>
References: <cover.1793676742.git.nicolinc@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|MN6PR12MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d176b7-ee63-47b6-9ebc-08df395d955c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|7416014|1800799024|376014|10067099003|22082099003|18002099003|261102123227099003|56012099006|11063799006|261022105027099003|261026121527099003|261026140227099003|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261021135927099003;
X-Microsoft-Antispam-Message-Info:
	MFOpn74Y+hQuxtpMtCm87OpHiAWrfMtBFmx6dYcVATJd2nvY8gwJjaTHMBc6iKqwqQNKZXh7Z/4AKM0gJc/Z9yLhkgSNbPkUm0o2psTQANuZZsMAmfW0Omcl3tusfpIEhSC+QkMhWQeVrT0t4h3O8m8b72tSNNA0vncXT4TfZfkz3bZqVyqbHYzbCdonOw7LOcTdqqPIjczfS78mLm/r9DP9KX1ndJiEeZZRmKI9dN0Nj8zRjIZqnwZczFPmHbLa4Bjdn5UJjy9a1cwzBIcTeLA4FOj9FEZCGi9n85qwnMwaHYsKLJsWRj5hiWpmc0gRgWjCiqMEQRTr/NLWNLsiob8HaKB0Pp2aKl7sUc/NNXKnMQMXfsoFB1PUbA1BtxQFODCWqDdmDo/gJUphITsy8iP8JgM7dg2QZjWS4Q+KQDRZ3tsqEAEzZHbZncrgrNRJlBd9g8yEO5RkOxU03/LVSOSePnc6/A3cd082Hr9AREFGuZ+MgU/Am7/uYqsKBkV9BLhwK8dv2kUuTrM+hHTrfE6CpnWyKJlmR1JF9sbehw0KhJr4kEJ9SPTSF0Lpbxs6/SMXfFKmbJdvgIS66UVgUZBw8p5XXsrRKaNXnizKbOZmei/vmYxTEXp/f9ei02f4oR2UD2ADSxlFNP6wdLO9ppSsxmlvOfZDSXjyDlGbQ6Z98uNQKID1LyOXfbgXUKSS26ynS6JaVAQVZ62VreqLLw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(7416014)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(261102123227099003)(56012099006)(11063799006)(261022105027099003)(261026121527099003)(261026140227099003)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QDqN9xRhf3G7CsBe3LwALeANuIGtaX4v6U8iotxq8K9449BQ3ThnGV069YQVeFJBitNdyulRA47EiNEuIRLnFga6dWW6vxTxxWf/RB7wzVjlJ1kARZ+QrncOhafRfFcKsQoqga7A7rdHNI6apRGoPcfMxh92x73/fD6dUlW3cFjkX33yaKexao0DEH9Wp3MLjSf59DSvBaR4nIY5WQlQnH+mVAXP3TOCq42RHH8fWkQs4oX7WK62bjM6rnPwAwJJZpz/IH/exqm5dyVGKjprQgkwZkTdEceWzdZ6EQID3Wk/fkHo5zxi8wfKkS9MgbBfVMaRXIdxIDciOapT81IfE0NMj72iBRaQCdJSCnXAgBRgH/LFuX8rDPzSYC4MD/0xGwlumXQbu/D/7ZuPhk+WI7MwGBiH06O6QkhAlxplPWXSmkavmbmuBAWk1fDC+d9B
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 03:50:20.8889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d176b7-ee63-47b6-9ebc-08df395d955c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516

A TDISP T=0 device stays associated with its guest T=1 vIOMMU, yet doesn't
use that IOMMU for DMA translation. Instead, park its guest-visible stream
in the driver's blocking domain.

Linux's model requires a device to either use T=0 or T=1. Aside from MSI,
it cannot use T=0 for normal DMA once moved into T=1 mode, since the device
will have IOVA's that are not valid in T=0.

Select the blocking domain before normal default-domain policy is applied.

Direct-map reserved regions are still fine, because the T=0 stream always
goes to an identity mapping. Skip them here, as recording the request would
only refuse the device its blocking domain.

Reject sysfs domain changes, driver-managed group attachment, and any PASID
attachments that would install a translating domain. The state is uniform
across each group because all devices on a confidential IOMMU start in T=0.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 54 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 38d0158045f57..6414c4d8828d3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1238,6 +1238,14 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 	unsigned long pg_size;
 	int ret = 0;
 
+	/*
+	 * The direct-map reserved regions are still fine because the T=0 stream
+	 * always goes to an identity mapping. Skip them: recording the request
+	 * would only refuse the device its blocking domain.
+	 */
+	if (iommu_using_t0_stream(dev))
+		return 0;
+
 	pg_size = domain->pgsize_bitmap ? 1UL << __ffs(domain->pgsize_bitmap) : 0;
 
 	if (WARN_ON_ONCE(iommu_is_dma_domain(domain) && !pg_size))
@@ -1790,11 +1798,22 @@ __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 static struct iommu_domain *
 iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 {
-	const struct iommu_ops *ops = dev_iommu_ops(iommu_group_first_dev(group));
+	struct device *first = iommu_group_first_dev(group);
+	const struct iommu_ops *ops = dev_iommu_ops(first);
 	struct iommu_domain *dom;
 
 	lockdep_assert_held(&group->mutex);
 
+	/*
+	 * When in T=0 mode the T=1 vIOMMU must always be set to BLOCKED to
+	 * release control of ATS.
+	 */
+	if (iommu_using_t0_stream(first)) {
+		if (!ops->blocked_domain)
+			return ERR_PTR(-EINVAL);
+		return ops->blocked_domain;
+	}
+
 	/*
 	 * Allow legacy drivers to specify the domain that will be the default
 	 * domain. This should always be either an IDENTITY/BLOCKED/PLATFORM
@@ -2399,6 +2418,10 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 	    !domain_iommu_ops_compatible(dev_iommu_ops(dev), domain))
 		return -EINVAL;
 
+	/* A domain cannot be attached while using the T=0 stream. */
+	if (iommu_using_t0_stream(dev))
+		return -EINVAL;
+
 	return __iommu_group_set_domain(group, domain);
 }
 
@@ -3325,6 +3348,12 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 		goto out_unlock;
 	}
 
+	/* Default domain changes are not allowed while using the T=0 stream. */
+	if (iommu_using_t0_stream(iommu_group_first_dev(group))) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	ret = iommu_setup_default_domain(group, req_type);
 	if (ret)
 		goto out_unlock;
@@ -3690,6 +3719,12 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 		goto out_unlock;
 	}
 
+	/* PASID cannot be used on the T=0 stream. */
+	if (iommu_using_t0_stream(dev)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	for_each_group_device(group, device) {
 		/*
 		 * Skip PASID validation for devices without PASID support
@@ -3783,6 +3818,12 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
 		goto out_unlock;
 	}
 
+	/* PASID cannot be used on the T=0 stream. */
+	if (iommu_using_t0_stream(dev)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	entry = iommu_make_pasid_array_entry(domain, handle);
 	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
 			  XA_ZERO_ENTRY, GFP_KERNEL);
@@ -4017,6 +4058,12 @@ int iommu_replace_group_handle(struct iommu_group *group,
 		return -EINVAL;
 
 	mutex_lock(&group->mutex);
+	/* Like attach, replacement is not allowed when using the T=0 stream. */
+	if (iommu_using_t0_stream(iommu_group_first_dev(group))) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+
 	entry = iommu_make_pasid_array_entry(new_domain, handle);
 	ret = xa_reserve(&group->pasid_array, IOMMU_NO_PASID, GFP_KERNEL);
 	if (ret)
@@ -4281,8 +4328,9 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 		return ret;
 
 	mutex_lock(&group->mutex);
-	/* An IDENTITY domain must pass through */
-	if (group->domain && group->domain->type != IOMMU_DOMAIN_IDENTITY) {
+	/* An IDENTITY domain or a T=0 device must pass through */
+	if (group->domain && group->domain->type != IOMMU_DOMAIN_IDENTITY &&
+	    !iommu_using_t0_stream(dev)) {
 		switch (group->domain->cookie_type) {
 		case IOMMU_COOKIE_DMA_MSI:
 		case IOMMU_COOKIE_DMA_IOVA:
-- 
2.43.0

