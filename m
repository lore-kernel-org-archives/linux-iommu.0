Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010069.outbound.protection.outlook.com [40.93.198.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD454968E1
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 21:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780522070; cv=fail; b=bKve1IBzvzY/XBNdwzY6e6U952p1Rj0XFEAR35JOludTJ0guPewC4sqnckyUB4vEqyvs4zbohaGFddr9atoFwJ8ofqHg8Xxgt5JB3aQSe5FL3o7IHIFQFOpbEDEn6o4N/mFQ0YBoHpVKvkV3MIo/nygxYlE71tilsElHfL+ntVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780522070; c=relaxed/simple;
	bh=4aJTRb/bXe+Klnpkv4QzXxEN4MrsqzL27y2TPU1PJoI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qw1HfnZCgzQ+4UAsE0afGnjWe4IUlzWOol+v4dJ1k24PczOW2SiG2/lB4Ky0UyOzqLoxs4YzrSmIyoa8UFThDHYlY6kz1LgDGa8y4lW5UF7ZBWkG/Q78ChsmCgqWn8caqEEhIShNBpCjexPs5671LMjmvn3lL8lFWTpGDRGqdYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LmvO8Qng; arc=fail smtp.client-ip=40.93.198.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LmvO8Qng"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4SQ6mE5IH7eKgodR3pW0UJU2+bwUhzDDCEoVnyn4GZsFJPbfeCRMyabn8jLJ0Yry3bOcmunhnKi4iPp6HgSpqtVSdJGAG2i6E/LhPpTiQvcQXTUlB3yK3//sc7fhlkUOj2472wz9tpPZr8so78fR0uWu7ThOTzwGtRz4bctlm3K0vG41Ir2a+9iFfh9BjMA+Bo49b4nXnP3EKZqgkm3xIoUG4r+56/Sbw6DEKDG5StyD8GL72GV210bSAN+ysq4NbpObr6+OHfx5HbJYJTLOSTszWXVbTDV1YQpkbeK99aBHXwZMUIZKFGYsjIHUWtDlL/cCNVfWAemsHQZMjmAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jro+oWb50BLSYPPGkHvb0B1CsoYVX5cPW7wYzIpozBM=;
 b=X16qz+iojTLbhI10TKJlaaIEt7EYXQ6e+iVjMJRrJimeOWZItiBIyWxwwcIpqijd4PJR8n1SEdIejGjBdowTeta5OMRY2IPURz/zroSE/k4dPrDZzHsrR93StZGpgs3rQanGUeFWXADwDLouxisQzqTyget++3idCCHrRLWMyfEqbteCQBJjNyNow326U36lL4hy7K5J62y6Q4od5Tf6m1Xlf9KNRWKr+2LjAdoX8LCQNzqTFwU2IBuFCj6OGU984pQX7+v8SGKXzw13460iHgPgxQHIKQdrWtb74HC7ky2DLrrdoR+BoX/HcfAlhETEWqqFk2KOGSvzOg4Pghk8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jro+oWb50BLSYPPGkHvb0B1CsoYVX5cPW7wYzIpozBM=;
 b=LmvO8QngPzRsn8NVxoT7hKfXTHmCI3FfSWx2rGcEe4eJFMZ9SYbJSIhuw40dPze2Yj7kfFvRy7osK19OTpPoG1LDQWCLRIuNpoCNTnW5lU9MHtgvuYzKBitGj5omrAbfSfiGipKl7C9dFCPTcsLdzQY3fAK3cUVlBw6xPhu3Q/DNY8WXPTLmObaSAE5edHDEBU2XCS8ezHdK1i+rWMtQveO1aaUMUv1cQVVlcEM7BDqfpd3TZgXIiR+L4cgViyGIWZaC8ZslFOihNThvR+QZ7tzocjB5SQEOs1E+hQgsgdaGOS0IY+Xx3ChIUXr7d2yG6XAF/NWEsyP0j5ZtaPLOSw==
Received: from DM6PR07CA0076.namprd07.prod.outlook.com (2603:10b6:5:337::9) by
 SJ0PR12MB8092.namprd12.prod.outlook.com (2603:10b6:a03:4ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 21:27:38 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::4d) by DM6PR07CA0076.outlook.office365.com
 (2603:10b6:5:337::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 21:27:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 21:27:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 14:27:22 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 14:27:21 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 3 Jun 2026 14:27:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	"Shuah Khan" <shuah@kernel.org>, Pranjal Shrivastava <praan@google.com>, Kees
 Cook <kees@kernel.org>, Yi Liu <yi.l.liu@intel.com>, Eric Auger
	<eric.auger@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 3/4] iommu: Avoid copying the user array twice in the full-array copy helper
Date: Wed, 3 Jun 2026 14:26:55 -0700
Message-ID: <6c9eca4ff584cb977661e97799ac6fe934e7f51c.1780521606.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780521606.git.nicolinc@nvidia.com>
References: <cover.1780521606.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|SJ0PR12MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a659e8b-d6e6-4928-1213-08dec1b6efae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|7416014|8126099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ZTo1Kx48EQCcCAqt6v4sB4+uHyC9C2sbwNDkORsImfnW+ZqNORrKmlsclQUEEjngoU1SXejvab8Maj/RkpcVHgE7MSBikFme7pP5+Sq2kan4mdtFM1t5FaPQRMbECkI1QHU02v9I0xmfZ8pceF8n527C4zHTUE7p5m2ul6c/963Raqp0iUrVN9b7Hxl31k9I1gfcxy22uoijoofF7uj2iygQOuRuejRL5piGuw0PvT5dtubT47+9Buhk2rdfcBUKg7jbEmk8NfpmnRFdFCwKuiX62tbkNLDaR+U/JFXMquZdNAkfYrRLIHeeKm/3AbKe4ImTrhoKq5my7WWAb7/wejBQKjTgxgTOmTtzyu99qP2haZXQl+R//iG8jLZ2kW/dJMGFJd44I61iIc6CMWUHuVYgNnOJ3mnmLJ9HAGp00PEmNXibwaYpCrT9QkoeQ4p8un2Gu/Hbfs42TAph7EP7r28KwoPIfWqbKiGANv61oJaM/aZMd0BhAvDMDx9MC0+Xl9HpYk97He4GlIeM8a6cDFGkZouZb34uL0PkUXaoDV5GbrMNgDc5XtWVzY6TjzvA/TyEQGhQUoTTPqxwYmOFM18SgWGZyqMNgQ1vVJ+H2X1eeuDXPHS3U14ESFXsOOPuR1JpoYj4GMlmFP4XkSk5BmybdV5km8tste205BR3VfpQ8tovjpWwJftaqp4m6NTJiHKZSPiIyhqTE0zrDyHVFUl0rZyUwZLbNDLez7ToXGc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(7416014)(8126099003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xXkQzksmkY2DTbuBnpfxm56+b2anyyAvhV7f0BdN6ubz98xqR2t7ZFuiTi+WIkT6DnQHyBcVltiq0QAkkzCPrLHHvuEY/yZs1zoHChwFML6WYjFgM671q9eqUiWRaEjb8RfWKXkfJ61CDvZwuX4QgLJzNyQXyNWJxcXGKWy4B+U9uHlE6CZLWVTLbYJYuJcXPkYhwDXMDNzyKyoH9bT4eI1dOVn5dmBP20/DRiZuXy6hkTd3UM5IcV2AxgwR0sS+7yYOmfPQc8Rd8wENnGfPUOmHS95TTtGNWiXmMCZyCNU7xxtqydm9QoErGXnkN3GbggwVnE1OAFe2kNepPvpQpOvhw+uJgRw+IM4gZjqz8w5v4zuxq38jgeOQqy8wIBiMBcgmj1yb1tqO2MoD7aJglAI0RXiSm02Gcj7Cp7vMT7yewcS62+Tlosy+PhS85rxs
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 21:27:38.1159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a659e8b-d6e6-4928-1213-08dec1b6efae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8092

iommu_copy_struct_from_full_user_array() copies a whole user array into a
kernel buffer. In the common case, where user entry_len equals destination
entry size, it takes a fast path and copies the whole array with a single
copy_from_user().

That fast path does not return, so it falls through into the item-by-item
copy_struct_from_user() loop and copies every entry a second time. For an
equal entry_len that loop is just a copy_from_user() of the same bytes, so
the whole array is copied twice for no benefit.

Return right after the bulk copy. The per-item loop then runs only on the
slow path, where entry_len differs and each entry needs size adaption.

Fixes: 4f2e59ccb698 ("iommu: Add iommu_copy_struct_from_full_user_array helper")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e587d4ac4d331..6957144263793 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -547,6 +547,7 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
 				   user_array->entry_num *
 					   user_array->entry_len))
 			return -EFAULT;
+		return 0;
 	}
 
 	/* Copy item by item */
-- 
2.43.0

