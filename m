Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010027.outbound.protection.outlook.com [40.93.198.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142372DA76C
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 06:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780380246; cv=fail; b=BGcwSSpXQ5/nGO0+cyNzYXYFmNmzogk9aJu11PnJvV/DdKIIEqvJCDwryGVo2qX4S18OT4r7azIloSeKM/HKsKvjrl2qIXlFUV3czpzENq9MR5biMXYsGKRd1WvxZeqsXW4ulgOkNO3uihkwzXb6k6XBvX3EsUXtm5bzs2O6eFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780380246; c=relaxed/simple;
	bh=gf3S4T02EuAwiz/sjcezheQyzLQwF1EqZWu1rmGSiBs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiEkAbMAGPBrGtUcMuFEF26tdcURIEW/O/JX6PcnllYrKnHnmIKEFf/A9jSqmrIiEU9n3OgkE+wJ6KfBFfk6rwSVtt9cqBye/0fd0VHOmOvOGxGKvgSbIMnZ1sQT4FVCzccP9gQIAjIAYIKX0B3bKRJAMNsuS7a9pkbrYOvnunY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MMkkPqTd; arc=fail smtp.client-ip=40.93.198.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MMkkPqTd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceiIx4MpYHg50Hj6JTayXNzn+mKbby3xauPgj1ny14RBPia3dLUGiTTNrgJz5DM+vGclKYQRuRUU2shdUVIqMLiUT8hFIJ0iJNdseI6+n5QlLYh8GvqnsTmnqbyJp4wDPUycsDYp9bREXcgOHoA2muA/2szQEW4pPuURUjHLOw+aPY8kvmCF9yEEqJCElF+YFaj1rJJMdz4Pe+yfTbeSKD89bK61rhNgqZ9pWcnH9Igzn5y2fZ3hJYv9kC1PlhEn8O7Lh4VTP31ncOHV5MoCx8DrHQiFdSchewnaYQSZAWU00SC/OfEcSz/8cYLGi2xmkOVwl8cTggR1+ckmFoBBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7sm8HNC1m7cxWSRUAZSUX7WOootqwWJRpN6whIhDb0=;
 b=bIzUwiHu9VhXSzziGcD53DwYuleut5k/lY9xj7G0Tz/paajoqZRqVKnMuI9J6t1xSN9YJ/IXOL82jvkrZW+yMN4Zx4br1VE6vr2PfORprSuQBwCq6xSYxeUvWtE1Ao4h4jrciNqxYOT5JeButJjuXpYQ+EZ6fqTdvGQoMsT7T530kLvojBpV8CCPdR8qlhgVkhKhKpoHxrTn2ukXuYHGgixnVkSiuJ11qyREO/cRV5pwE3i+8GVp/jZFz4BO1uA8GxV31hSmUYAg5SGSk5RAZ5LzQ02A8Vf+m8egdOi0WY0hjqiPUHyIAz49yghd/3KyWxwYtDDNg+CfQ/oZ4daCkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7sm8HNC1m7cxWSRUAZSUX7WOootqwWJRpN6whIhDb0=;
 b=MMkkPqTdEFH0u3mfAmzPsF+0fuwmhNMbeKDdPQvZ2lx9wP1wsiIUSe92q3cTn01F7wtrAhjYKMkKHzsRsfn/lFphe1CS999XcH+tKSvv8zPHTx4FQGshyBKFUvEoksCgQJdYE+8heWGTOc5s6ihF+RToAc5YEwH89M2J+a4fECSKqmlxk2OAC4KUyY/EO+kmyuH183ZKr5uBFUFhAy9HcyFzT4XPNy3B7GhRwxPqXA1U7GvBptunclGQovlQYgDck+o/6BTniUe4EV5OkWecx2FYtnGJ28BSzrvsNP7H94q4Ed5kWs9QkmDQ3Sl4tdqTVkPuZVebhrNW2fi0c/nmdg==
Received: from SJ0PR05CA0057.namprd05.prod.outlook.com (2603:10b6:a03:33f::32)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Tue, 2 Jun 2026
 06:04:00 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:33f:cafe::1d) by SJ0PR05CA0057.outlook.office365.com
 (2603:10b6:a03:33f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Tue, 2
 Jun 2026 06:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 06:03:57 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 23:03:44 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 23:03:43 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Jun 2026 23:03:43 -0700
Date: Mon, 1 Jun 2026 23:03:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Daniel Mentz
	<danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 00/10] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <ah5yPciJTVTjkMfJ@Asurada-Nvidia>
References: <20260601215909.3958732-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260601215909.3958732-1-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|MN2PR12MB4424:EE_
X-MS-Office365-Filtering-Correlation-Id: e7798af5-8b04-462d-b614-08dec06cbc21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|6133799003|18002099003|22082099003|3023799007|11063799006|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	K25crhW4juqEPBy7SiC7zxLQiwc0mJA1H5QkCH4YrbklNyym+UoUtVYCvesthxPY8vbSs6hdoYZ6IA8gsfv7P7KHXPBwq/tCIHeZp6z6iKBZ0hkgE5iILec3BQb1TlHbzRac7ROoxFbQ7k0oMfp1qM4nMh8hpHExtVFCQGuzIvUyAdujBBFqfNG614CCqfw29/+n67IuwlpqQTL/qPDyECLlY9TD5z60RWfvhKgmv1HEVccKg7P8HDMeq1XmRbRxoIzLF0jZBKRJF3lGrxkPiUEN8nTj9DSWb/HpFJjz5YR9K60/R9kEk/aqumQcX0BaOwzK6TYR9jtCCEM0zccgvni79qZznInnVwkJhHWTw19GNVdwwhmPEqpvjaZlglZE/6l0zx+cpVbhNchpLfNleObWy5Hr4WfhPt0ndDh5rORLnak8ugt51slhQThJXP/O8f52I2f1nnisDpYpbzKfy08LZZ8EtOLvkNoN1IBV6R1yrA9KWGmBZ9aF1Q6Myx7sdZ4VXXuHYzg7QveS5wgTOgPrWEvdaP37oPQ55dXGhPUfM62VNqDqw3ZKdc8pihN9hhVCWNyrttrXFpa1jeWKlIdEPCH0A4tZXWxjTY7WBaqdlensHkr7spo4KLVpJ2H8IuM/MsIuXR5r3xRx9o9osPSD3vap+09lTFRyGSVtEL0vvvjl5Vi40XTuX2XKg6aqQtu97+sNqWj/tIWpVy2lB6hlqmCbgEKzdy8+GDZJirA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(6133799003)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F34nU4zEmkacgWr/YPV5Q8WmTslrS9G+JeyWzic9zHlSGozf71eDM1WWP3j95rVl3p8W1CdOCiqk3DgXdqi6RRLlInfKUP+14w5OOghl+EiEu3R5TvpXCpo3Y0s0YTsL/UGMbngO5v8sTmTYvUK/VRmUTnadWeumGPWNbvtSEG7miwZFUV4mQsFLpwnx6LpHmuGOQUnBW+PhAPO+sms9I/sL9lhxn43re051Jq15ZzAZWlMC8lf5fo3qTsjptOcO9hEQwh+CVWLE7Dn4LxC+aIdF2BW7mwo4g6WRq0P7rfidgKQX38B1LOrXSBQUVroSwjT/KTIYRuyqQ+0IZjiwncDpLFjiQHQJm976+QX031Qjsf0/TjWXqP+FqE/gNvFPLVTLMYwuXCmUbzFbmyIKtOH/vRNB/A3k8Xm3wh9Zks209xgrb+Jk5L7+IZXBWFdk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 06:03:57.8168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7798af5-8b04-462d-b614-08dec06cbc21
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424

On Mon, Jun 01, 2026 at 09:58:57PM +0000, Pranjal Shrivastava wrote:
> [v8]
>  - Centralized elision logic: dropped redundant checks from invalidation
>    call-sites; elision is now authoritative within the CMDQ layer.
>  - Renamed elision helper to arm_smmu_cmdq_can_elide() and preserved it
>    only for diagnostic/safety paths (ATC, GERROR, Page Response).
>  - Consolidated implementation-specific gating and draining into a 
>    unified quiesce_and_drain_queues callback.
>  - Updated tegra241-cmdqv to gate virtual queues before draining,
>    addressing non-deterministic timeouts from guest-side submissions.
>  - Re-ordered probe sequence to enable pm_runtime only at the end, 
>    aligning with SMMUv2 and simplifying error paths.
>  - Refactored KUnit tests for better, addressed Nicolin's comments & added
>    a multi-threaded kthread race test.
>  - Refactored RPM helpers to use early-return patterns for improved clarity.
>  - Collected R-bs from Nicolin.

FWIW, v8 is still missing a base-commit and Sashiko fails to review:
https://sashiko.dev/#/patchset/20260601215909.3958732-1-praan%40google.com

Please make sure v9 patches are formatted with "--base=" and a public
commit.

Nicolin
