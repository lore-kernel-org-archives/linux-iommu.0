Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010015.outbound.protection.outlook.com [52.101.193.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B3837757D
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 02:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779071358; cv=fail; b=uNR2dcGZN4FEFg6BK73OdRRgtdhX8tGXw7EhqaDKdooJE2vEzyYMmjO9lNgH7zcQacCW5MgC5/GxvEFLLY2FMxwMmVC7Fc0Ik+QYSuHq66BejCK1MiIgFio/sdoE6DuaJTa3tlBY+FJlLx7+I2gd/7j3ABIAj1NKDU8oTfS6qdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779071358; c=relaxed/simple;
	bh=x04UXNdEMEFjIz4waLAHW0sUpCPaSCDgXtvLtHShUF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8a2Q+NXKSNCHaFzTzpy3OLF8a1wAUw/hTG4jh3CahAC87FALIpqfb784OdoMfbYS4atwqGpyQ9MWwuhZqBy+16QWxkvE5mgm0EjDmHSWEqIhrd79Aob4Bnpp4wFe3dU27xFyy+tFUmaeLnY8/AqfS840fzTeu7ZGqKW6lO3hsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MTqaKTmV; arc=fail smtp.client-ip=52.101.193.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MTqaKTmV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAJkpOUQog6yngcxQYXqF7nUXPsjhjgwoIS3VnQVa293VjGCq1B1cHvr2r22E7JIZ/67PBGXPda/6ckwXshX/mMuVSg1+sifT5wruEGhZybdVoNrLbyHyvCZ4DcYJ+b5qKlCpqOlaJ3j2aOB7xAdM8PhCo3VZZJ86N2puH/rSRq20czRoOj5/sl4F0lpLZV+YjTylpBSunGIac3oQh+HezWjHzcHxzY4mOnmxl5ANN5pwEXOeUpx4SptYG3NZbDAsNVNRV9edku2O4J3uB2ft5kg0jKPJcltTHAgzL159jO6hehxUyQZbXH1ygtCtNfAsyhEoBdYcFnLuym+zCtBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipALqatYZl+YFok56NsOedrNBZ8LSZmH85WAPAy71Ug=;
 b=ZpkAF0fPi406bsN6oSRF+628EpFezk4mkM4wI4j1okivR5NxSzKCEsNDZdMvu01heuZtzMBxMqdIR7ZRxISvJZYttOHrrFbOIRLfwzAPCOKqDgoTRthWrnFEaT7BxjG8JcCdSBHWfT0ZU7FnCsooHc9YjI1owdprRtsds4Js6nYPGO0PkhFZ7c1MLBFU8rlN4eIVFgE9Z4Jaa0p6OrWCYvrYR7ImN1cIWRCv3+STXkHxoZaMsQcr+zVFLgPfcOixLjt7xhU/QTKCcNR8XyuJlSaqkq3NGbgJbzK/0emuESgtxjoHtlwV03VgRa1ScvWkA1AXxI/wW/22YKemvy8RRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipALqatYZl+YFok56NsOedrNBZ8LSZmH85WAPAy71Ug=;
 b=MTqaKTmV5y/2JFvStPBK320zKR2f8wVAR9CQHY/T0yHBPmb15yANMK5q2b4x6bEhl53/MgATQd3fOa0H+W7+DMhq/RPiZFzJspKeFZ7tRtneDHusu0MQqq7pFHMB7z0HHK/UWk/Qi0b+079y4aL3+QNNfa68bvoWejvx3aTjVuNcIoYnEeXP1nDtMEDBPULi8i+y2y5vqvOFnikNXQqnrnziDws9+a+5cJeHLYTv+qZQvqUo4yeRgX4CbDi5ryektekrSnEJdO7hV0mMwIDaFOf7kkPU4LhMypcGlGIVG2fpMLqPet+UFYGuLmRACfArv+ujpv3sQIdrGv/ENBTtEQ==
Received: from BN9PR03CA0909.namprd03.prod.outlook.com (2603:10b6:408:107::14)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 02:29:07 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::a4) by BN9PR03CA0909.outlook.office365.com
 (2603:10b6:408:107::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 02:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 02:29:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 17 May
 2026 19:28:59 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 17 May 2026 19:28:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 17 May 2026 19:28:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH rc v1 3/4] iommufd: Fix data_len byte-count vs element-count mismatch
Date: Sun, 17 May 2026 19:28:48 -0700
Message-ID: <688327824893c46256c01e5e841d847f4b8dd940.1779070992.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779070992.git.nicolinc@nvidia.com>
References: <cover.1779070992.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|DM4PR12MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: a0608df4-771a-4500-9cfb-08deb4853c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	haIYOytgGPmbgT7qeRJyJhLiV1qev5YApEFyTXR74/MqBMQlhRJveW7w82w7rcW/E3hLlpfaK0V77gOkIdwbNNRdHhtqPy0/0KhJHlm0hi06hmJc+2yLF5yH+P1U1394+PFapYEQeROP9mk6MHt8AzyPbkC045aFULb3qejkcx23oOelqrLxLN9NMHT/EgdHgdp8hVUjiaGS3r9jyUBg+zlh/oT/PC4CHc8jVLedsIdfkzXKyS/PtQI40yZka7lZY8B2zZ/079J/CUC7ba8bYYkeOq5tlis2zC5e6tF6fRYWXRFsJ2nDeHK7JV563AC49RyKx0Wb9qPvtpLKySw+zoXl+OMXu8r3Kd/CdlSdMdyB/QRcTqYMfTWSLB4MaHD6bPyoEamTwUiqIwQlxDhUcAmMBn21TeFFG1PaEZLxcNnjTf+J/O/SrkbEBJZuCekITcMXPmnULe20L5mhqug6W7K7Hz4jLmsEk1bB0w9+xnROxsm4DJW9h4oIDEHdMKbVmD1PFeZE1nu8gYvKOMr5L1rMXO0pgmFGqSaJCPNEarmVbc3Rtzbfg+7M4NYmf5Rc8mPtHHwqwXZhasADNz6pFmpNvnnX1ibo/j7j7wT52lElLv6g2GuHjUzccmiKCsyaUvQnTi38p9LBClt8zFlysYArdyEuPVDa/VwJ/yMrGuYoKu1kfv46a+B+uL+iLgWGbRZyr6hqaes51cQmek73/lMIWUM/UQRLBCPK1cMYaJk=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(11063799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mf6AWXCeT8oIh1a4kdO3dz1IN6A/QdIloJDoMeC/UZgsSfR8iJ5VljcjXg3hFKG2TlueRFhpz74j+56VngiLS2bHsnh+TyuCzIvLxRNhZjGK7iuJy1nllub9MDuAo7tDdbX03JzJok+6PVydcuNIbs237HxLWHmRi4baUulQ3DVOTysneJAyOHmYl0ZX7cVOiMTyhKW/wwRjx73LafrkFwGtxTjXpw+gzUPmKmVlF7SgTbKqn5zRhF/iTGsqhSDHxbHYIH+6PqDDWi4+hikmfPlWn+T4TW9AQQ519G46i1nQuX7l3wZhhJ+dBWaiIHy+wCi9K4ayBuqcQF533fYwvWaOZyrnwzrwilBVhnkPVEepKkQAU6NT6viiPlbFBkMLkI/DL397cQ8kr2eyhWxIrP4nWpF7/Qkx7NI9FDQeEke8OcGNB2Cq3wryiEquYh5O
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 02:29:06.9842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0608df4-771a-4500-9cfb-08deb4853c81
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890

kzalloc_flex() computes the allocation size. With event_data typed as u64,
data_len is interpreted as a u64 element count. Yet, every caller and the
read path treat data_len as a byte count. The current code over-allocates
by sizeof(u64) and the __counted_by() annotation overstates the length by
the same factor.

Re-type event_data as u8. No functional change in user-visible behavior.

Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 6ac1965199e9a..43fbc5bed8de3 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -602,7 +602,7 @@ struct iommufd_vevent {
 	struct iommufd_vevent_header header;
 	struct list_head node; /* for iommufd_eventq::deliver */
 	ssize_t data_len;
-	u64 event_data[] __counted_by(data_len);
+	u8 event_data[] __counted_by(data_len);
 };
 
 #define vevent_for_lost_events_header(vevent) \
-- 
2.43.0

