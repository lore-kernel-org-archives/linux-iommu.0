Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D225429CD3
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062554; cv=fail; b=LuF5GMMdeQoDEVWmSmlsbZ0lMJihGLnUW4IkC0aLjxioBvC6KgRXqqSDIO8cT5I5KJEvjP3J16bkSeYfevHrermjWGjlk0BapFwLwpr7IfYtm5gHQc6ksz9GvuqyX01IGMOF/Z2O+9duacWQL+r3nRYHp/gTYAF8U/i+eTAIXY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062554; c=relaxed/simple;
	bh=PdtmrloiLyRf0K/mT2YIwur7T6STNA725iaBsEkqS28=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dr+j2lV8yWx/WHfZtMhnvIb/DBi+LQzN6z664EILHzWpoPh+lONOCpGMN0v7mq1nsA0lKz2WY/JR6WowYHxDEB+W3uBzczSrtppfP+HqsqC1MBq7BHPdByCtBW1IP6YSv/Z2O2T3kGtE1p2+3xBym3jAn9YNfGfuO19/ukTHj1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l06R8noI; arc=fail smtp.client-ip=40.107.208.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l06R8noI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+WiE4WiBf9dlOW78PQ5z5PyTsILQurgUw78fo7LKlkSm17Lzxygk1pk45uZ7OE1gV+8UKocyzyMAeXObYZMX6fZedF7li8js1zgg65ErnGtExGbCC1FOX2tMHlOC+U+ZR+hMrJknu+HAhcceOD2y42T+GR/sr+pw7cBHpZugna2EvrbMBljYHVMQMNsm5elj0yEazylX5kNhoiqU0j8wjsFiIN8mRLSRkQh77dkiqIvNFztgCCY3Qmh+BmqYzx5FxqkTiTZrHPvMJXAPB0ZFLrIl/Atm1oeT1611bvLy1Y2b2rPBw7lED4SUl19eQSuMSqankbVziOZHLx5ryh7lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQmuNW4CUqpnF8uEiYI7/H1+O1lG4iW0td8Y+cgWhzE=;
 b=VFFBZ8qJI8duQ7Ns1tJdahd4I1MBorb/EKF9iGhNVclOCMpTIRZdh551xIUvEQcjP6ZavLf+yNrSYbEz/6+mUAQPG3I66r1ruhPobfSXUN4uMTVcfaMLLOPH2quHlKwpeahyqY56Mfk07hDDxLP2fSlHLcDMIkZfZ/SDkvyxSgZYjqC8vmY5v68BA3uaNVBZHglIgZ1bsnJxdjS8E55vtd556eLbCpm1JPVaZDmZXo+LHX4tvBCKB+XVw+VvRethqDYWijWUG/9kbrYlySOKB4kee3L9yLszrv7punQtCHEkpQtNaU3Oo/n4kFHAdQ+PzZefefmlL1iC43oeMCIXFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQmuNW4CUqpnF8uEiYI7/H1+O1lG4iW0td8Y+cgWhzE=;
 b=l06R8noIY/2QOLaBo+aRCg62gcV5lQ1AMcNDi4p4YyBhcK3QusW2hz8pze95v1AkgnG7dXNTrMRZhCEB85SvZLLfWkySx1oHTvAlnlB8WF8EmmFzT8JjB86eEgNv8VOT58nZ6mVEfPnQ3x/jJWy08eGGyiVKB+1PPqsRHeZEBfBcZ9BZGHJ3WtaTQxZY37IsFX5OpIqeEga3j2XXr4dpSzWcOp/fVYe5e+TZutEamCFCZ045R0uzpfxMqwmDPWKh5GretLUUGvIPtGcI+IM9kcysjkSqsYKumv+L6k1OL5xi2r2dECQ+aoy0CdTw712Qqj+PHzbVJJ5SQAIUQYViFw==
Received: from SA0PR11CA0089.namprd11.prod.outlook.com (2603:10b6:806:d2::34)
 by IA0PPFC855560D7.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 20:55:38 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::58) by SA0PR11CA0089.outlook.office365.com
 (2603:10b6:806:d2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Tue, 14
 Jul 2026 20:55:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 20:55:37 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 14 Jul
 2026 13:55:17 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Jul 2026 13:55:16 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Jul 2026 13:55:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 08/11] iommu/tegra241-cmdqv: Require exactly one Stream ID for a vSID
Date: Tue, 14 Jul 2026 13:55:05 -0700
Message-ID: <d0933c20a709821faf80dca905c9194b08303431.1784059577.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784059577.git.nicolinc@nvidia.com>
References: <cover.1784059577.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|IA0PPFC855560D7:EE_
X-MS-Office365-Filtering-Correlation-Id: ba85819b-fa6d-462b-7996-08dee1ea41c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TEpQXEyBomDBuFs8Uky6Y+XXdT2DWTWpZ/1aLkDCRdx7XivXdSqTDfqJuBnROhZ07lhWVM7PUq6rVMNKyVVqtlxaj4aApDR/T0K0K9r0FaKvU3AI/Lqf1/bp5URrI2Xm91h11gj8/lKdK5W09+4Yuw9sAXIdEXONOP6MEHeyJCUoSK0LHnopBd6pj3koHatf/Q1monNkJhQKyZHbxPZlbirUx9uEfDRNUZevQG4+IooleGivLC6SE2HnZSlsvPp9v92iM5Ygarto2bI8Yz7aPiLUaViowPGBehDhr+itIkRPaNrg44CB9DR+M6HVz3SZaJLiYF/WoKGKwC3yCtjR4WBm1C9sOnc4hsSW4L87YJrtZVplkwp4srrOVOqgyvqlBAmK7Fve3fDJbQeyByfcPisalQUoCybaLrKX4q0Mrc37DPunZKS2PWfC6QrKeDZJJY6XEX3oGdB3FuojchBX5jDQzX1pdHwoqeq30Hkby/5Wqmiyc/s1oJNp2TN1eNOlPAymkXULRClnOZvz9Fc4fdme/WkK6GLX8C74MSE4uvvOtYaYPC6akqvuBuzhd7hldpNOHtrtFZ7YkEglOvB+i0d5HeF4j6NfDg5jIWPzQYEBU8G0lLDn9z21U2lhojpaFCvDOmIGdwKkmEN643YfEUC4ANOY/0A7eWWsWzDyPSc9kDRNa5QVKyYW+o4XWv4KcIBVOm3Xaj4fMch3ymykJA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8fYELi/H7W3Gej2iFrmn9mxjPyqc5VAVjmAE0iVLxY68zG6FSy22DGyFwMPF5ijUHhtNyaSKy8YgSv53ubkvVYYHTObqo1tpr9dN6Nly3axiE+mOix5E8QKQK9VZEx2Wqio3NZEt8YneNCb32tYFs6mdMojxVISB9xojvLDwhsMcbB3if7UXs/Ho/3hirVVPmbBAkUCJyOkKfyAXX4l2kQFh9GqVYY8GSlADrnJYQEP9wF+82S5xzt5QV4bjEqb/S69Vt1hIB76LRtNn+oHyD9yCL1zvdxyIqWGmaseV/YuZQz3QuaAqdjSdSdEFd9wabh+bTvXJXwthnyH287wD4GUQ/FEG/zjFGhVCodsnrcw4cwrzTHrIeelocotWfxCLuEB2rLKn+IWQyqXTXbGCitVwsXAb0F51yFrvcVqMR2EQkFNXZqezxvm59Fwqumr7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 20:55:37.3867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba85819b-fa6d-462b-7996-08dee1ea41c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFC855560D7

tegra241_vintf_init_vsid() maps a guest vSID to a single physical Stream ID
taken from master->streams[0], and only warns when the device does not have
exactly one stream. A device with several streams gets only its first one
mapped, so a guest vSID invalidation cannot reach the others' ATC and IOTLB
entries; a device with none makes master->streams a ZERO_SIZE_PTR, read out
of bounds.

Reject the mapping with -EOPNOTSUPP if master->num_streams is not one.

Fixes: 4dc0d12474f9 ("iommu/tegra241-cmdqv: Add user-space use support")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 812cc500b4a1e..e3603cddde018 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -1249,7 +1249,8 @@ static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
 	if (virt_sid > FIELD_MAX(VINTF_SID_MATCH_VIRT_SID))
 		return -EINVAL;
 
-	WARN_ON_ONCE(master->num_streams != 1);
+	if (master->num_streams != 1)
+		return -EOPNOTSUPP;
 
 	/* Find an empty pair of SID_REPLACE and SID_MATCH */
 	sidx = ida_alloc_max(&vintf->sids, vintf->cmdqv->num_sids_per_vintf - 1,
-- 
2.43.0

