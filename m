Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794343861;
	b=plTNvnJBEn/arLypthDEoEuX3DLQIvlFAKgCo7CQdE+bqnI8RP9aEzSPEMITNKF+zWLF
	 2jDkI4MG7ceHRxqibLp8120+uiKVqnaAlqz4npHn9HtHNSwgN5pdyb6HHnrynsCG+y1hn
	 AkiwMgLwxh6k7xAPGlaW/i0rBidTChEHn1ViqWl12t+IaxCxH/hRaVqcouBitYR9FbC7v
	 R9gTyOwV806I0It76mM08Bun6A0VMDIleVQ45Xbu7aeeQLcqaHdF3OnL7YJ8AYE8ob3GL
	 +6E/auRNZSXbRHEmkdVJNQ5zHUhd4ThXsH7RKcfpNtZ0ruvmxRfCTEipSSjPegxIiAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343861;
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
	bh=scItakQm3yepmIn47zTuOCWQZ5Y0fi9/NW8TRndwjgM=;
	b=w9y4IeznWLTKiwh9/1zfJSSkSFA9TQdyg2VoX6Y1u6qzClIPl+jngsJkbhQz3Ap8u9xL
	 tbI3869pMFgHtbHs3SV5t+kbRVNqdAi03PT7BL5LV35+g+Hb1E8jJX8aNpSiXIYQsGfQW
	 MezO3ZJIpZeQ5xY00yYYEaqg8B4h2HqZC6szUaXq2WIsTwqTVRxMrb2Kc43/Fd7IW9U7r
	 k3AIm8Jh3eNkYiLsiCPCFjBANH5wjxug/sht9cy+czmDKtafTGAXU04+pCiEL9cupHagd
	 W3WXI3xzNjRyNjeV4bHPVrr7a+wGIEjIwUmjWlx+4sOfkHgkyeGmISVVqQoXGTEM3+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=n4eqWG9S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.25
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013025.outbound.protection.outlook.com [40.93.201.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B22660A2628;
	Tue, 10 Nov 2026 20:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B22660A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=n4eqWG9S
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5g5IskTcYDsWzAsL0gd1BqjSy8gjvwB/lsBjyALJmiQBQ+8lF4dNUQkyuV8GiryGvymAPZFsIn0PPU2/OirrHbOJ+qOC2eslP8nNLFwR3HCV1drS+mHT9afQoOk+AlUPlpBienDL1wGEmWhhaBMQ/mNy+Zk+qX/Y9TsTmg2ZOq4na/gwLCLYjh6U+CBq8Qxg/AvMBaDAx45es9LZuz904eJYfTk8yjdG6AB0UVwQG8wMf4k1VWNtI+O5TlZ2lEAz3iyUQGi6RQU9PFQeu3p9hrJcs7T8Bte6ynDQ6Bc/GdSGBNQdcjw2ouMWmxdBB4X2CD28tbo3WiFAolRvJ1Qsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scItakQm3yepmIn47zTuOCWQZ5Y0fi9/NW8TRndwjgM=;
 b=BHuioM6KeoTC4TUrGrhKtJi5Pp5oO5/guQLWHvjys5EamvtydoU7AqV7uTvslQuVhye4N9nuBPphGnNUWIgTlkASmO/1CO2A1NE2F6HfKT2jjeiGMn4AIz5lQTx6nZ2RKxoW+eZXuqrNy6vUAVeUbDQJiH6wlG13tvelyTDhA57oTHAxvg1efufXKVWAn/i2Qpx+L+XLpnoTzDtf2LOAI9/ORuY7aLdbnA2e7e2t6ixFv1DiuvYPjtYUiJ/b5xlv1k8pdZQNvrfQh4Y/iOHhgWFJtvcwtWQOp/zq6RSDjIwiQTNE37g1q3QekpQrdrPw4v++kZsDc4a8FQyc4PUuvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scItakQm3yepmIn47zTuOCWQZ5Y0fi9/NW8TRndwjgM=;
 b=n4eqWG9SlzHwj+abVZynRZIiOBG0qQQ2VN1wctm0g4eaEHXVxN7yiBnrJzDUFnuMa2oynevNCZn3fa2Xx5HDlFRzMPnxaf6sWnDQf3nW6PyRIHB3tfaF1mNpDgk3/FgZNUOWjMY4Omp/OiC4VKBGEkGBcyEsPMaoBR3k2y7runb21wUXZE51Nx/BG4TCctssNbOydHgzmIqUWVDOKSbu0muJf32K+P7j9dL2stMJkgWq/DhH/ktYGAGZFpS61PyXvuGSdANnQ84ZTFGlcl3FTXU4YcN1MYyP86QsEpGqH4wWAe77+zL096a+ykJpLm4Bi/Kc9FlgYhvLjGHWyBXVLA==
Received: from BY5PR04CA0019.namprd04.prod.outlook.com (2603:10b6:a03:1d0::29)
 by PH9PR12MB145095.namprd12.prod.outlook.com (2603:10b6:510:415::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 20:50:56 +0000
Received: from PH4PEPF0000B60E.namprd21.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::6a) by BY5PR04CA0019.outlook.office365.com
 (2603:10b6:a03:1d0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 20:50:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH4PEPF0000B60E.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Tue, 10 Nov 2026 20:50:55 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 12:50:35 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 12:50:34 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 10 Nov 2026 12:50:33 -0800
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
Subject: [PATCH v3 6/7] iommu: Park TDISP T=0 devices in the blocking domain
Date: Tue, 10 Nov 2026 12:50:11 -0800
Message-ID: <6620f49a3bb96837034aba24b5131a9d8c7eec8c.1794343501.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794343501.git.nicolinc@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B60E:EE_|PH9PR12MB145095:EE_
X-MS-Office365-Filtering-Correlation-Id: 65aba2c8-ebc7-47ee-6008-08df3f6c5107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|7416014|1800799024|18002099003|22082099003|10067099003|11063799006|261026121527099003|261021121427099003|261021135927099003|261102123227099003|261021123027099003|261026140227099003|56012099006|261022105027099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	tfcPGKds1aIIKy4KAovgXSFah3KKZ9yAwDJ9iWcDiCLZdO/CTRnp2b7BoD2IGP5RaSiJNMOecs5cxLg5jJO+XI1B1OXNLG3K0xgwML0jx+vhM62ayqjNm4MG3m2zL2w0io9Y//Sh0B+zzmsi2PuIorc8T12qYlm/FnJ5ZFiGlEOgLROIOzbDk25sIk0HqXJXQhQ9ub3MhubkiFGSOzs5gJgNKukNR6y2tRQjOgIQR1UrErqhsK44tX34RPdMXxuBfaNC8pNQH1p4aKmzvYrmguBaCB7QsktYVpJNkIybxI+ZYJ6MLarB55NSurrubWFigCW+vR9b8JXOOqw2+LRBNb54k/PpQEYNnHD9S4JvuGUBddXGIOq9iK+m1POZaWz5ub0oayH0A3ZYlJHwhVNuNB0DiuofKjLwyfsD3iq5XrpPup/3gfsw8kKGA5higv08EGOl0ZOHdSg+UTdEN0M9jjq7XIjlo5iNcGzGNA368NEvyV+qBOTfjZcf874pz+TOhw8YerNWZ7txwix5SuOLIXk4vti2SctAbWOY7e7TTJQEuu3J85I2oS0tSxcWywjDbm+IXqpbuNOCGHhcYqlK1mvkaiBQpJM01R3PVoAtEngZGEkiXxgVZzcqXuTI0O64Pd8HA+yCZMFP4i5Ejt8HtfejAoLimgd10SxDhtM8nU4YCo1PlI3Qey1U+K8PVTp/wk2C2JjhY7svkGdMD6MzBQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(7416014)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(261026121527099003)(261021121427099003)(261021135927099003)(261102123227099003)(261021123027099003)(261026140227099003)(56012099006)(261022105027099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DfHYXfNKJHYfF5F2OS6jxFhhfMzIfUWqMc25S8zRwvq+AU99omB2u4FvD/iCFu7RnvIVWqPWnadyWHv2UN/rIkKRUlIOnEMBjnKU0A6oOVUJW3npwCX/OZnQRgYviTGQe8e/+q5k3/JJde8q+QXrVSc1RRUR4hD16A4Wt0gSN/QKKrLQvxbg1Sc4VEqKZ+awqBOsOrnwyacRs9/gqnU8OwYPnhVxH106EXfNpFYTieHzXVut7eytByaloZviAsFqUHZC+Bib7K8uT3K2Kzrqf7s+85uQIojSahY6S/x5pr30/cUxJ7jlY1LFEbHk6PxA9okD8gHSIO4hNIim1A2YYnAvExGHdI45Ho9Rw2eUqS4aYLdNmvLJ65Ha7BX12sxPGsvpQxNnImYcqkRup0RY9gBnMKnBYl3rr7LkGv4kEdOIu6CAf+OKSLHFQduqEKZT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 20:50:55.7506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65aba2c8-ebc7-47ee-6008-08df3f6c5107
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH4PEPF0000B60E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB145095

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
index a7464e155e55a..992aeee8f9294 100644
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
@@ -4294,8 +4341,9 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
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

