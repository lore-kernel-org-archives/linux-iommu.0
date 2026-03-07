Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D056616F288
	for <iommu@lists.linux.dev>; Sat,  7 Mar 2026 00:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772842708; cv=fail; b=rNuMuzPbbELrTyjfenlQEzsbcTMMEoGnfE2l5sZsLdL9G+7D/P5Aeb9aJeX2twXpzVv5pMWlXpZStYuHgGIhNRBfs7s0JvWIwgVhY4vmBla6wOeTpxn/t9wDPf5rr8MKSfkAyDWwdduMmEkSPjj4AgOMLCyi2cU7m943JL35PQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772842708; c=relaxed/simple;
	bh=0XresZpfQZaHJQ9pD/8OKEvd7RBplENscoiVAg1o3To=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PTXvb2YMB8sm271xnJkAEo/ZgG8ibrXXUbFLUi3OftSLm69PlbDTIS2Q6SHfQOaKyS3b4QF6ObPA1RvZURH+bNiQT5WTORSq2oCgapqDrnD5/om0juhJwPZVKzjUu/PNg/28auzioED3vnj6VRbTdqWoGq/dGLyg0mAlknRgmzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qws0/qV7; arc=fail smtp.client-ip=40.107.208.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qws0/qV7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJ7kQEAbOjw22DIaOwYwHZNCuyIMiP/+94AE/6xaRriA1yPxO6J46gvoqirUHslL9tx+VUwIw0RcOJwUmOe+TSca2OxpxqBl/EDKOHTCorprgvDuDAjfLVNg5L/fFpzE6VNgRMfE6gB8gfCC15Kuht1KbZWcY9ZgubBOBy7ljVii7Vyc/CsMsuko0zl1l6PrZgmCbRrcvxU1WefmyZaHvZ9RuQef3ffvJ9zlzKuIDQJ1hzmGF6UubsOj1qtLmPNmwZtWooyKwFPao1nDmqk3u/MUjnDkiKoO/n7jpNRxOQuThfrk7t8dDc3RriUrZRAklD6/R7YcUKboiBYeofwlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoCse67t9ZQYRxM/3ERn0+Yk7GU6FFs+s1CV/52QRpw=;
 b=NLrJot94OpahL9fXEYCdNiiuLCKR6u2/5Nh+m7Zprs7DYfMlQUj5UnFXpSMrj1T0lUY3d6OzdLjBtdmXiqK3IHmZGSPKordk59yCd+3WnkGjF5mG+4T/h0Ba4OWA2MkobOCXHybHso8XLZWhoUuYTf+lQZtiOqdopFo5Ir5ZT1Ul41clqZtwiefl/7o6IvV+2fn5pMFRBBV5qe6nJJRzNzVWUMJWOtuTGJGqW/Vu8DXA0BH6pkWy40sWLEVcYg9ysRay0X9bDS+kAZx6Tsh3cvoTpoVJj+KzFe8Rk/2jQ9xCiMN3cryP4A+LBROWnYluXat/l/jOrjoXcMr7jyuwXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoCse67t9ZQYRxM/3ERn0+Yk7GU6FFs+s1CV/52QRpw=;
 b=qws0/qV7GozBtXUthXveRPRjwLgzF68l3tSLrl2Pv9UgRJofBzmbOzMtDzur5g8T6CihKzRB+l/TIMRZwz2BIPGXJ/wISlrd8Am4UCWHdvQ5auFik+2/LW0rL0GjEbPBCbcLwA+0t7yxERXyhrwNRBM49AU9bRit0tMgtfFngL8bNfBrtobIUqA6FmohNJSTgCxu0M/Zk7buhY2VAjw/Ta4R22y30p5Qm8X2z9WmRpW1JNS9DE9avrin+kK+sYKwy+32k01VMrR38Xa1PgzEKDTtYHpc1fM+EwB8oP4ef/x5BihdBWa908EMwYE0ZsO0wKKcmMUNi7C6MSp/nnfDQQ==
Received: from SA1P222CA0120.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::16)
 by DS0PR12MB7876.namprd12.prod.outlook.com (2603:10b6:8:148::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Sat, 7 Mar
 2026 00:18:19 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::56) by SA1P222CA0120.outlook.office365.com
 (2603:10b6:806:3c5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Sat,
 7 Mar 2026 00:18:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sat, 7 Mar 2026 00:18:19 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 16:18:01 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 16:18:01 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Mar 2026 16:18:00 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<praan@google.com>, <mmarrid@nvidia.com>, <kees@kernel.org>,
	<Alexander.Grest@microsoft.com>, <baolu.lu@linux.intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <bbiber@nvidia.com>,
	<skaestle@nvidia.com>
Subject: [PATCH rc] iommu/arm-smmu-v3: Drain in-flight fault handlers
Date: Fri, 6 Mar 2026 16:17:23 -0800
Message-ID: <20260307001723.964956-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|DS0PR12MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 85dc58f6-0aba-4d9c-a148-08de7bdf08f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	3wvd45/QvLhTQuiVrh+8yv7ctc3cYnknK8jqwBSKDJ0qLTY1q9DSn2t1G4ZRk8/09xJ5BBMB8vId8iliRpN8npX/AC6fyhjTYPmBbFMuM0X/KOWWgLYhgleyVbgU8Ng47usMJ4ITv73CtW+GXEdHuLb0PX0rbcRlLMzPtlN0E008sSdmS49jduF55yVZiOn+mdrhIN3tFX0GnI1KwWf1vsjeHA1kUNeWuw0B/1W9En4O+ADvz+h3hOrWmb9t6ggSUn9nTGLk2248hk3rlUqfhkGjfEBuyzSXOQrf2HpA03QupPIyVFgGqDfFlrdf+jSrXpCkLqk9ytmkJzs93JFw5T/D1iBEdrL+iZyw0+F+tTyGTYiWN1QvgUv04vPCvOgiWE7QH/WpHQvd0xEPgMatX9C//wrVfHUiBAiq11f31/gkVF38/9rVhlLZY+YlkEH9syNgYRKMlLwbOHJImTp21eGSGWQPi0+w8LRIRC8CAgWfcIxi5uv+ykrpvPY0yaY8vKpKalQjCmcEEK/TUhIGcxGC1KfpY5+TJijE3Iky1tNAUDr+bNg9290VG2qxxd+XYX3JggAjRQfZ1idrtT5si9l1up1jVcioK6Ud7EDZokC7ZzPTpR6EBFDSbnub7m6aS+LgHdT90fq9wWSo6LgRyR/OF/B0G9A/zRbytEgLY3ZQtrGEvEbtl+x8VMMgBF/b96Wv63gTVbBsguylP+92kvi6R5W3brHkiaWoaYT5VfyNGdsf17yAuf+LvGBfEWeJxsoEfr3J2J9O30mbRghyUw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LggFxkK3aAzEWY/V6OtWRgit1tqnRONJ28/d3YGVGsTHQxqA0XWgyye3eV8xMUerL88FMPg90dPGSdbHrhoQ8JJHGAgme0cSILLqcszYXrYymht6t1tbiSfab2wV83FPe2+yu5lMIakLY2YaKSpMDKCZMaBHUh7l85KeATEt6cdAGWhE9qQNGR1rKYFeBJ251a+Xy/TuPmTyy15GbzMU/up/WqUoNFwUOehdS3TBSO9BvG84uVc+o0syNRvKNbRO5YpD7H2rlA8BpUhi1rSMXoiTFTOVK2OUfyQUiudvHhciZXfMFE61B1Gvgull//pAf1N+AcEE090r+TW8TiarPwCBppZK3xxknhkXX1tmk9CdoIBoMikTpB6xd9PnmVh4mArpjapVz26qPY2Fo/Dmo8NssMlHoJWxKn6PDBUB3LLTFGMzQ4TCe+1cDHIYgzsw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 00:18:19.0239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85dc58f6-0aba-4d9c-a148-08de7bdf08f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7876

From: Malak Marrid <mmarrid@nvidia.com>

When a device is switching away from a domain, either through a detach or a
replace operation, it must drain its IOPF queue that only contains the page
requests for the old domain.

Currently, the IOPF infrastructure is used by master->stall_enabled. So the
stalled transaction for the old domain should be resumed/terminated. Fix it
properly.

Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
Cc: stable@vger.kernel.org
Co-developed-by: Barak Biber <bbiber@nvidia.com>
Signed-off-by: Barak Biber <bbiber@nvidia.com>
Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4d00d796f0783..2176ee8bec767 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2843,6 +2843,12 @@ static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
 	if (master->iopf_refcount) {
 		master->iopf_refcount++;
 		master_domain->using_iopf = true;
+		/*
+		 * If the device is already on the IOPF queue (domain replace),
+		 * drain in-flight fault handlers so nothing will hold the old
+		 * domain when the core switches the attach handle.
+		 */
+		iopf_queue_flush_dev(master->dev);
 		return 0;
 	}
 
@@ -2866,8 +2872,11 @@ static void arm_smmu_disable_iopf(struct arm_smmu_master *master,
 		return;
 
 	master->iopf_refcount--;
-	if (master->iopf_refcount == 0)
+	if (master->iopf_refcount == 0) {
+		/* Drain in-flight fault handlers before removing device */
+		iopf_queue_flush_dev(master->dev);
 		iopf_queue_remove_device(master->smmu->evtq.iopf, master->dev);
+	}
 }
 
 static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
-- 
2.43.0

