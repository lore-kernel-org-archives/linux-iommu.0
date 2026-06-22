Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012047.outbound.protection.outlook.com [40.93.195.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250C4360EC7
	for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 06:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782111266; cv=fail; b=n1dsUBy0iNAqtZaoaSxESihlXeH23xI1j4z/Di+QHFmfdK9YT+ezdG2YdC/b2ZAUpuVPc6B3Y7Evzc9/wNt+ASY0pF/MrEhEVKRyiZ1NtapKcgL5XZaucC3QwKZ0EGyqjZW3VAe9s/qWb0WGul1YNyHpjVSLY337uHFKgz9wwL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782111266; c=relaxed/simple;
	bh=gwQKpUBQCgE4NVI3ks15xFKf2U98zzOKj0PWjkOpvj0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DQtXrsm+4rrx0Z8MBPXP6FRDwbSCVQmxKdW51qlDsRWrt6e1A0tFRgf35bYgJTxZthhvC0+taSffnNApSntveA4hQQtN8q0LbwHjrYsydHFbjasBQ7HLF8KWybmi3YJrJF8XXYHcwdfpaCSQdMcL9+vvdilFVNejIWVJ5Tous+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ORsDhWhF; arc=fail smtp.client-ip=40.93.195.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ORsDhWhF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nc9//igiYYVEMvI4dKyMAuCXaBSyKzhKox+3Hw+lqYVM8OECAsbVaOdJnc2sxpYocv4+8kguYp8pYB7chf8hnkWgVlfJdPx2QoKyOUxl8SbjxBZSryh09yb8sZbbr0ewCeZMgpdI+8lJCK1XJ0sQCmRF26FrO+1i16XjD9paIlA6qz36lQd1h1N9v6mT1LYHt5f5kr6L9v+KddqI2aMa8Etr/IXkwhoSvFcw+shmkesjz/bIxWdUeDLDO59zZHzXMPpA/2Gjt3uF3++7GRL7ZDPJvQkzvDRoye2qW69c37r8lwciXUIIq5/AeJfP3D1iuur+j/VjsA1Kipuc9e8+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezEvqroFnLyI4FoJVDMQyFl6mKA82BZs5JLN1n2nMtQ=;
 b=WAuRMgEwV469hUe9Qbti7VrMVR0eEpek0fShT5sSeXzikp1/TcZZyu+D7tPtQjHI1M7zw3FgDr1dwCZoShD/z6jyVSX6E6bW12cW3B6ZWwi4DcqFHE7rZCiljoRtFcA/BFa95UOPqP7WFoCpocsLVCkZSsgd+fOj38enEH5BOHi8N3sKMuxwxohfOjFLzqDt2IXBYAlDSenXy+MnD1KOoyo1p5xWpGIRLTXuhLD1GPeggauhsGwYZZARvEIj1iSOCP7e1j+2RrjmBIlWADA7pRSyhDhJvV1kBynyP6FI5GSfQ2BLhEHmDnOjcwlKhjn7mRwmSCB9aGQlQifP8lY+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezEvqroFnLyI4FoJVDMQyFl6mKA82BZs5JLN1n2nMtQ=;
 b=ORsDhWhFkT4mrKhmtvryd4V5rNoq/I8esY1mv8tZcymmiI4xiKt+nyDaz55nCapf/AUKc0P8r1Pho5IdGiNv5jA81WtuMStWnnGZsx8aZ6VLtO6ns4my6419jVjlIsz6Odd27KFvHPJXvun2RrBLABK2i7Ag91CPhavckd+u8To3EbsRqhDn6NXqAG60vpu2f3fRTirpxwZHA8Myx4o6yjqe0PQVFZUg4FgO1ayeTu6KSupOXKJVxIGpXbo2KeN52xltiNHnxv+eglowaN0/0IpFjStBNLybZ4LJI5Yz64V5t28ovJ0c9P0w8K4kpmOWSBSgBF/kJuT+1UxI5Mi7cw==
Received: from BY3PR10CA0010.namprd10.prod.outlook.com (2603:10b6:a03:255::15)
 by SAVPR12MB999121.namprd12.prod.outlook.com (2603:10b6:806:4e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 06:54:21 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::88) by BY3PR10CA0010.outlook.office365.com
 (2603:10b6:a03:255::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 06:54:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 06:54:20 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 21 Jun
 2026 23:54:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 21 Jun 2026 23:54:12 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Sun, 21 Jun 2026 23:54:12 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<jonathanh@nvidia.com>, <thierry.reding@kernel.org>, <nicolinc@nvidia.com>
CC: <iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH 1/2] dt-bindings: iommu: Fix interrupt type in example
Date: Mon, 22 Jun 2026 06:54:09 +0000
Message-ID: <20260622065410.2780215-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|SAVPR12MB999121:EE_
X-MS-Office365-Filtering-Correlation-Id: 447befb5-9e9f-4c1b-2409-08ded02b162e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|7416014|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ETAFzxkCmQfLwNnULajQ/SNdPWK7205e0D9JYvvu0PjqRnTO0UIuSbOWEQrzu+ciXii+09JcKZjv0Dj0NDMJUOCrapzswipJexnvElEXY/CmDb8IX+PM+6ehqepitVur/fJMqlI8n+9uIo1E6QyNufg0i1m4OvG0WcGdRv6a8285XyTf65hhGZt19jgCFShBsMl7jr4nnLqqaeSdSsv1cqXs3gPqJSryAAGi5dK1e3Z7aB+0f9tW2D7aqM9emCt3IebXs6auliMPVskH2xM2tvjG1/3NkE0Cs4dTpkgFxhLZjvCfYB/jCDSkqXQw5sfd8n7Istp9wPxykSoxUjTDTV74rOutbA8oC2nCxBUwzkY4nxqz7EdItswLwgsrLk35CzoUu3ery099ge2jC/Rg1/VoTHffwb0UQF2/j/CktPZG5rPSzq/N3M5kafQnC4YeIddcSrFzwFskjLbRFUQyNDdX09SVTtJmrpSI42mI5PRh/WMvLfWtvQIuPc4gSxmDO4tBGVSzmxnPH9GfqXFyWAiArvqup9wv6vuB826V7Lu9CV/Fn1X+RP0sW7j1f8/qagaj2qEkwMtamodmbYIFODpbgegR8FkpvK6aXiKDSBzwLm83qQki/z5ZkCumWN4mvSJ4CXXQGhTYJrqdpCc3smvtUJ3tbex0rOAt3EBkCpFsb1aGcP7kYNgEBcp1NfnINeoyjdlSH8V2C8zlDLhWew==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(7416014)(6133799003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YmR13IK9rb5bsal/MQ/z7PtSghRrAJ8j8Gp3SEKCqFSvd67P5k8e4a5DOMjnuMwcRTuUOLOOVhi7zdz9E6CaBWqzGEGei1hpqkb+8c9U81BUrdCwjhHEOGkPg8gqhbbEg2p+8uN2NS4IkISmEClAdeTm3Ah1pI6++Oxvyzb2Sw5DDD/DFHupNeJ1opVc6wV4pDnN6M29DvgkuFnUFfu2y9UMNj9k8oGzYozgVq9rX+T+JQV1mcQEu2i6g+DvFvk6KBNLTRmnB7tOLV7Eg0vBHumYSdN/Gkem8mXN+WAe2CSldMnB8fPf1/OSUk27LjzYklCi3tg4zu9Tiqb9nu1ctDGDgWaUSml2+yGebg6nFHN38x6RNfJneaWqqxJW3/oAqiE22I59JIisHDYh80g82jBrwhrURuY63gg1j8WSitZymBIaV685LZyHh1m14lCA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:54:20.7130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 447befb5-9e9f-4c1b-2409-08ded02b162e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999121

The CMDQV interrupt on Tegra264 is edge-triggered per the hardware
interrupt documentation, but the binding example describes it as
level-triggered. Correct the example to use IRQ_TYPE_EDGE_RISING so
that it does not propagate the wrong trigger type.

Fixes: 8a59954192eb ("dt-bindings: iommu: Add NVIDIA Tegra CMDQV support")
Reported-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 .../devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml b/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
index 3f5006a59805..76ef34fe5c72 100644
--- a/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
+++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
@@ -38,5 +38,5 @@ examples:
     cmdqv@5200000 {
             compatible = "nvidia,tegra264-cmdqv";
             reg = <0x5200000 0x830000>;
-            interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+            interrupts = <GIC_SPI 19 IRQ_TYPE_EDGE_RISING>;
     };
-- 
2.50.1

