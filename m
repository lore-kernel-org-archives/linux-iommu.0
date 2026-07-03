Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011067.outbound.protection.outlook.com [40.93.194.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A3A334C1F
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 05:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056730; cv=fail; b=UMd+wLUqkg/4RwGUGRJLTA2TZ3oxaWYAfYhh2G+7WZ2ryL+OacTwxiby9djdK0PMycpIcesqIE0ZyPHMO1le/Lq2eqiQV8ulANupfHthjWeY/XEdRrAN6tuVA3uNfnX3FLfHIiaTv3nBW7MqnNzisWv4ECN867ep048UPPCMWbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056730; c=relaxed/simple;
	bh=XXjBO3fCtJ8pV/FjkM4tmLF3aG4NBkBa+vYv6T6qw0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DtZQqfQc8caliCplWQsm7PvRkOv3DjCQ/XimIhesYa6XryCIpCR0F2GGoq56RDEyAP2fE0sYYWR/P5nRq976qsrGd2iitTTvq9+y9Bp+LZdP0IsyR5lPbWaYh+jJN6MsB2CwBc6eEWTdxOi/vi7zNJLGdCftfmcYBs1tis9XgbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oVyCeYom; arc=fail smtp.client-ip=40.93.194.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oVyCeYom"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNEJUcUyUVfqFZPpk5W61/rcPTFXbpptNMEIreuOgGwFeCQRCJDQbK2xVB15GaUFHiGwrqymj8KxMrWNiUBBOu8Qb1ELo/wviBOZg+DWGKmrGPdvjxhCtT49jQByIZ2XH1wK0rn338bqFQHaca0VtzvOFJWbG2X6Ed6Gu+tzw+9mSE//8WT4PMbn1fvpbRrkEHCVGDkiqe53VigJQVJt0Vi0B2IkM3RYGc9kdkPPNw9E8nZH4CZmuEfPorzAdKK/Nyrm5TXAPc//Bien1/W1Vie9oKAj1VfqILBhrUnPdRucqQXIi+FpQ09P7mKixaYlpdlXnIr0lAFaux7cavdP4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gb2OczpIKYaIK1PP5Qu02iBDQ0Tamghwba5pckLeWic=;
 b=FSg310CPIN91abmnWTteuShKaEXm7Hq3dxU5DSUzxS4yUewLjg9qr3rg6BGEOh4Tl8qeuvyE4ji9+BN1W5evtLIsI/eNqP2GMdOkedvrksZtxSH7svoIfF3SP0YE0px6QHUBtjGInzygSufGWPlUx5kZ849RIVosh4YY68cM/ntE7Khy0f4uL1PQLkwVj2Q+7vi2Dob6yjKdR9oykMMShFWzNM8c5WtxgS41o0ly5lv5eZi50nG/6R3LQGXpzoiyq8Wwz4GYI8oElIQ7049Yu3o1DRqEuDhUvNOOn136rwO9fouVWqbGngApDqKtVlm0PwsKZW8Gkgoc0BHZl6d5QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gb2OczpIKYaIK1PP5Qu02iBDQ0Tamghwba5pckLeWic=;
 b=oVyCeYomdlIsYY4WO5yat7NJY5I2AuCbDYbnW9BcTpeWNqZBvlYVU9JAtd6QstO7UlGsbwRmOsK7NW2duy2gUxcOBapxRB9vZo+QrLLJY5isJlZXYjdd8AAnhY97MMmUVNssbi9R/dhB/g2U4H0D2/n7p8w1IfOcRTiOH9X/iwqBjxHC1cqBk/mdNE8UDgKSaVf0I/PwnE7A1Ns6M27W5VF+VXXREYDY+eW1bZ6c3cbu3yP/7hgezmFSZjieggKfoKtV15sRL+REegdrG6EXDgcy7lgn9QQWn/Eel5ohmA+PWj5/G5rHkkUzxJFbjRENB71+fYwG1FzVXDLhTxdbtw==
Received: from SJ0PR05CA0021.namprd05.prod.outlook.com (2603:10b6:a03:33b::26)
 by CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 05:32:01 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::9f) by SJ0PR05CA0021.outlook.office365.com
 (2603:10b6:a03:33b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Fri, 3
 Jul 2026 05:32:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 05:32:01 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 22:31:49 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 22:31:49 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 22:31:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 07/11] iommu/tegra241-cmdqv: Reject a vSID wider than the SID_MATCH field
Date: Thu, 2 Jul 2026 22:31:33 -0700
Message-ID: <3cf17b4f317a6b9dff6dc2cffed24b069d310f1f.1783054570.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783054570.git.nicolinc@nvidia.com>
References: <cover.1783054570.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|CY8PR12MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: eee8d41d-fdba-40ae-02ba-08ded8c46897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|11063799006|18002099003|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	QGRxMEXHZ24aUmCjl88qVRofh3jd31vThw9YFDt5lyeNrAYnNtyEvqQ8bwVh9Vu5Su0IcgBrnLpwKfF2yS+C4H37JChKNHK27ItyB9otpJVtppMf2GGgVtF2rqsziceTVbKEffFKDBrtwztyItBvNYFQ55raWm5qeFHJuQjSMohKwQiLZ7779r+x70caZZA2V7nRlwpkry5755Cr1KhyLneXQ6ubwpQue/lTFTMgNJ0ieLEQjXf32OY6x+sqiqLhhBQV8zb97OYKiqHxmVyc9uBoy9xHyky5LyaJZMGtK9ZY7HL3FXQzJbPT6CGMKAjnBjE/+54dKVWu+PT4KyYoLA5D/otY2KybAIWmbGKVqQzcDKzuQcMMcEIgbvxJMnvcUnFJu3jfEc2IG9i1q4vCGwuugSm0o3DWWliO8ejbfPJDtlIUH8a/mqbR2PtyWTF/13x9gZmUPhK+ougAX/0tR12Rt4hetc0eWeth1rDT+d8GlPJb+GnEtESy+fSszDG0oR1myuW1iHaratozkCXvqut+J+nn/0Q6LL0GF7PptbFpP1UgLHamxGPLm5u1YuQuaq9AFUIaOtehHciS0WN9M3mDsTZgJ8+Marl799IMHaZ5esKVa6/wGkbANsUgdkxuFvgPcAw20WnBRVMbYDpWaGQB3dxgGEPmX8fj5QyYdbqLmOGBASBwG+lpYGMuGb2sjnAqUGgKMVABzleDxzTmCQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(11063799006)(18002099003)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+hWpzrxjYD4UznOLcOYqXhyrt2bIZfYifxhpkwI9WfoXyMau0wX8+dlJnp5wwY6kFzvztrvQLdZIqLmJT7jK7O/ENhYSana+tIEh1cQRm0Nrz6Fth1YXV/13N8K1BryG3PVyv7u4napOLQ5SVWi10zQqO1An2xRqf6nomm+RFjPMfKQzUDwTikFLIIL7OTvmnPJ2NrJWvriuE4XBdnGwbs7CaLmxmjKpphV52TtiLKSx4fJw6rerCi/L40Kve3o1aR+K2rDdoI5VF6mSJj4bwEMPqfCuueTR7K5CPTkbVmdoRM077GLUAGEgvxJMu/wkJu3Xu78jOQKCJu9FS7ZVpEA/3D46MSWZIk3f4lOGvlAcyQ9uXPqRSdfnO/qE2DF6P+XnshyMFT72o/g/r2l5cqa6Ken8aN8gavGKwdLQ6S2o1XAxYNPGX1gFj20tB0FD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 05:32:01.2450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eee8d41d-fdba-40ae-02ba-08ded8c46897
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7289

tegra241_vintf_init_vsid() programs the guest-provided vSID into SID_MATCH,
whose VIRT_SID field spans bits [20:1] with bit 0 as the match-enable flag.
The HW therefore matches only a 20-bit Stream ID.

The bound check rejects only virt_sid > UINT_MAX, which admits a value far
wider than the field. The write "virt_sid << 1 | 0x1" then drops every bit
above 20: a virt_sid of 0x80000000 lands as SID_MATCH = 0x1, a valid match
on vSID 0, so the entry aliases the wrong Stream ID. Because vdev->virt_id
is guest-controlled, a VMM can trigger it.

Validate virt_sid against the field width with FIELD_MAX(), and program the
register with FIELD_PREP() so the value and the field stay consistent.

Fixes: 4dc0d12474f9 ("iommu/tegra241-cmdqv: Add user-space use support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index fbf7ecf043a8c..812cc500b4a1e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -56,6 +56,8 @@
 #define  VINTF_ENABLED			BIT(0)
 
 #define TEGRA241_VINTF_SID_MATCH(s)	(0x0040 + 0x4*(s))
+#define  VINTF_SID_MATCH_VIRT_SID	GENMASK(20, 1)
+#define  VINTF_SID_MATCH_ENABLE		BIT(0)
 #define TEGRA241_VINTF_SID_REPLACE(s)	(0x0080 + 0x4*(s))
 
 #define TEGRA241_VINTF_LVCMDQ_ERR_MAP_64(m) \
@@ -1244,7 +1246,7 @@ static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
 	u64 virt_sid = vdev->virt_id;
 	int sidx;
 
-	if (virt_sid > UINT_MAX)
+	if (virt_sid > FIELD_MAX(VINTF_SID_MATCH_VIRT_SID))
 		return -EINVAL;
 
 	WARN_ON_ONCE(master->num_streams != 1);
@@ -1256,7 +1258,9 @@ static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
 		return sidx;
 
 	writel(stream->id, REG_VINTF(vintf, SID_REPLACE(sidx)));
-	writel(virt_sid << 1 | 0x1, REG_VINTF(vintf, SID_MATCH(sidx)));
+	writel(FIELD_PREP(VINTF_SID_MATCH_VIRT_SID, virt_sid) |
+		       VINTF_SID_MATCH_ENABLE,
+	       REG_VINTF(vintf, SID_MATCH(sidx)));
 	dev_dbg(vintf->cmdqv->dev,
 		"VINTF%u: allocated SID_REPLACE%d for pSID=%x, vSID=%x\n",
 		vintf->idx, sidx, stream->id, (u32)virt_sid);
-- 
2.43.0

