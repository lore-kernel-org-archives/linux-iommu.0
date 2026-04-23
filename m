Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013020.outbound.protection.outlook.com [40.107.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D37A2EA172;
	Thu, 23 Apr 2026 19:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971712; cv=fail; b=XH0Cq7WjDbO/4hDqm3KCwPtE2TVWtKxoB071E/ss4M2aroQaCdf8xLjBbNotz39vhNKtp36qicZ401B8PMajfVkWL9DMBkQcWoz1o7GsIphvqu2s6gPVVUs9ycPBerq6/uT6OIp0ZKCTDcrG3HTLPbmZdf2uzwpi8hAsZBUkXEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971712; c=relaxed/simple;
	bh=RGbbQ81BeEWgSMv8j/jmchPeUwC7Rub5qrWB37JYzf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u74je40nUzgeV8oqWeOo8xrr13EVkUiASLO6/fW/CNp4kP8vL3CmV4Y2ep0Vse6bAvPvygOSWDnaDOPN5ZHtwuzCqPyNd8w4cBf38VmcUTxFEGM/eQqmqbWY1qGO5tBmM3/j8UIGN2rjL378VOCOh2shDxN/nEmComrZZO/HqQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tyBK8bzu; arc=fail smtp.client-ip=40.107.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tyBK8bzu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D++nPvGolaA+Q0nlMKsOFsdnp3DL1lg1amVfVBSJwk7xya1FCG3bUrq4Nz34Z0ZA2o6F27nLkVeUY5eUvM9Rz589niLjvuJqY250w+GlZY3ZvBkH6AWNRXIOdADv3wxkA115MUfWYxmjK7YQhRdaCblITGnEnnSs08ULN6b2RPGTnpDSx0n+GnnMJS2EHV9erKvf0tpLFay85ayL/sgNb6Tx96wQ9/GLzxEp//M56NcQKdQWP3AWg37zgtDU1Vt6PB5Tb/HjaJACKG57hgDf6l9Rh4VqHZod5iY/45OAaAMsI02dyTX9Q/L22LLrT2wKAKZ1XRrA6m+walE+3cszVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uxs9rvqbnJ+yTDeUOOYgT17ijmWT6zWI7v9OjR7J568=;
 b=n4QDciFiMXloZNBgowB3ZuHaZshCcmzS1nAxhf66AXPXgom4UHxfYIMCSlPXw8NSIEz1jnZPS0nfzAm/rn7Z7AGfoOHCK9yltAvI7g6pVPgHxe/F3FMXwcJNNyIObhkTQlkWeFn3od5pt3NtXVVVbiqKzOhqokAHjpjMU9kwaWmJedb9dlBmmo5ybfRRfbRJsvh3PrEK5+BBJ8YGtNuj+2JZlSRonA1tRiifDCR1ZdWhe5lNXuVrHdB6vDpa8gls/Ia21jb1OS4hEUTq9gRduLnJAUCzc8+13DWOF9MXUic9pYd+XCRSrRAMes53mKlfExq6hO91WmqYX1R1blmslg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uxs9rvqbnJ+yTDeUOOYgT17ijmWT6zWI7v9OjR7J568=;
 b=tyBK8bzu3fBk8S6YIgGRM0SXpjseZxFY6Ah5x8m0ik9x621WZiQTijaZIu78lv7Wu6mT3Hfc/mYpFWeL9ZTo8Q0wuxE9MklU3yiBVojqENHWF9F1CR+IPzfRnxxAPXGPNPsJvx2IXjyw13SDNXHNr2oKbyguTTfEzqPemuhI+U5F4WGtkrYOU7fFzBcebmIZ3ES3foNvsdukzXcegZNyMf4Ao5WrLz0CRL66RPkxzaOx0+zDUoN/lR0UREP9YxQ1NaUw3n78XiH3W6pgMC7taeQ9B/aXkbMXMCvI4uGizmvgrgSw9TKQPPTZWttevBb9FE8sG/lvxJwsriwjcMenUQ==
Received: from MN2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:208:234::9)
 by DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.22; Thu, 23 Apr 2026 19:15:03 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:208:234:cafe::b9) by MN2PR16CA0040.outlook.office365.com
 (2603:10b6:208:234::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Thu,
 23 Apr 2026 19:15:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 19:15:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Apr
 2026 12:14:49 -0700
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 23 Apr 2026 12:14:43 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <saket.dumbre@intel.com>,
	<lpieralisi@kernel.org>, <guohanjun@huawei.com>, <sudeep.holla@kernel.org>,
	<will@kernel.org>, <catalin.marinas@arm.com>, <joro@8bytes.org>,
	<robin.murphy@arm.com>, <jgg@ziepe.ca>, <nicolinc@nvidia.com>,
	<praan@google.com>
CC: <vsethi@nvidia.com>, <sdonthineni@nvidia.com>, <kthota@nvidia.com>,
	<sagar.tv@gmail.com>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <acpica-devel@lists.linux.dev>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>
Subject: [PATCH V1 1/3] ACPICA: IORT: Add Root Complex PASID Flags field
Date: Fri, 24 Apr 2026 00:44:15 +0530
Message-ID: <20260423191417.2031652-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260423191417.2031652-1-vidyas@nvidia.com>
References: <20260423191417.2031652-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|DM4PR12MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: b1480b27-6133-4c08-184e-08dea16c9f1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lakKIExVxzzigTJ9dbAieYHM6dDRBTKfikbxiOYQm5yRsVDyVo2+w2juPmc5er/QqvqUi1o94ovmbEFWTjUCGvx7T9dBX+0DJAuKf7xOJzJfhmZaiHc01oP+zeHjVWIDwnMWfY8GrTcEcXZfOFwDwjTHnMsFJ2m0xbVStly7JN/x81BCHQm4LIh6Rym4jbt6lKDsoGzYg9g/SduG/hUYT7HxtpiCx13qKPOCv/du8ONO1asx5ZnOEqSsRUXEmQiC1myVC1rTnWD2WY2KipB6/HeRRkcdgzJvHZCf6kFjHECZIOptcsmgXUN7xG4AsuB4CVE+hNBm3tqfldDlDpAYjp7f39A6M/OVwWWPt5e53U6OKSzonpsP/kFcFxjX6HhWI0wmy+mqKL/mcte5ufegYT0CKvz+gqFtvTc01r8LT1wV14It6LNCFfj1np4TXDVm6Ne8Tdm/Ayh70YZOeeF/ni3XE0H32853ewC0QzfwnhVto8wdq1Dyk+gtTtgHB+iEirYIL7OudYiLQJ2CnOmnwfKyR2CiAbieGRyvPZoKBSNMazYV/y1ke1q525jVjtF/XdpaPF7f+FhqJ9WFODrOEJbxwcXBVRfEYJzlwzJp4FLRXQLrUjNo1USzwdgw+/nlC+9te8Ypp+9FRAGZL8wrUB42+/muZnA6UHO6QaZIMVYzZ3WA+crEiaCPWMkoHtW7KZb5KP98ceUVeH91zACFP//Mb2UdPbo3eg+c5tLDYqs0iIjwJegU5UAqwdJ9W1gzmzgbrO9yC2d1BgdFqxS/a2sFM1lh4r0wz9Vhhz3BSfi+wuxS/iLaNW/sJxA/juN+
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Zp7ZWN8ncQmla/Y+TlS83z+Xt9uReXjG/olVKngTmlJU4y77IykRVViLSZM2tGlf+vPV5BqguX7qIwBu6rTgU6aCSKRHU6JXxvDjv4e5SyBimX37jWi2Mrkf4dwhN3fgBbTA6FnULgG4fUaDiFW6XBPm9tKro9TuahuCUWKp8F1BVlBJmh/WPBF/Km6HVjEVPJyoHKvWg8a7n64FPc4BaQkGXPA9U5qerfzGKt1dxEvldCys/QYXrdIEgi8Gc0T5iU1BZChje+amQ0L0IWDuSAfJKoQ+Lo2CbKsQSaAiYDc8E8GE2Afg4WIK0iukP5GnBrzh2ptV5MfklcT1QnQrpGtetlMOxDZV7N60Q6UNgsomsXnVbunIhx329ydEBgV0ykr1RSCmcIw20TLhzxI+QSw3LBs5iuylneL5KlFI+3SO7zwbFiLA5i1N0LrmP5hC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 19:15:02.9241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1480b27-6133-4c08-184e-08dea16c9f1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745

The IORT spec, Issue E.c (ARM DEN 0049E.c, January 2022), bumps the
Root Complex Node to revision 4 and adds two PASID descriptors:

  - PASID Capabilities at byte offset 33 (2 bytes), bits[4:0] of which
    report the Max PASID Width supported by the Root Complex.
  - Flags at byte offset 36 (4 bytes), bit 0 of which reports whether
    the Root Complex itself supports PASID. This is distinct from the
    existing ATS Attribute bit 2 (at offset 24) that only reports
    whether the RC forwards PASID information on translated
    transactions.

The ACPICA struct in include/acpi/actbl2.h was updated for the E.c
PASID Capabilities descriptor (offset 33) but stops short with a
trailing 'u8 reserved[]' flexible array, so the new Flags field at
offset 36 is unreachable and the existing ACPI_IORT_PASID_*
definitions have no consumer.

Replace the trailing flexible array with a fixed 'u8 reserved[1]'
followed by 'u32 flags' so the struct fully covers RC node revision 4,
and add the ACPI_IORT_RC_PASID_SUPPORTED mask for bit 0 of the new
field. With #pragma pack(1) in effect for actbl2.h, this lands the new
field at the spec-mandated absolute offset 36.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 include/acpi/actbl2.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 5c0b55e7b3e4..5a4450e66358 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -748,7 +748,8 @@ struct acpi_iort_root_complex {
 	u32 pci_segment_number;
 	u8 memory_address_limit;	/* Memory address size limit */
 	u16 pasid_capabilities;	/* PASID Capabilities */
-	u8 reserved[];		/* Reserved, must be zero */
+	u8 reserved[1];		/* Reserved, must be zero */
+	u32 flags;		/* Flags (IORT E.c, RC node revision >= 4) */
 };
 
 /* Masks for ats_attribute field above */
@@ -760,6 +761,9 @@ struct acpi_iort_root_complex {
 /* Masks for pasid_capabilities field above */
 #define ACPI_IORT_PASID_MAX_WIDTH       (0x1F)	/* Bits 0-4 */
 
+/* Masks for flags field above */
+#define ACPI_IORT_RC_PASID_SUPPORTED    (1)	/* The root complex PASID support */
+
 struct acpi_iort_smmu {
 	u64 base_address;	/* SMMU base address */
 	u64 span;		/* Length of memory range */
-- 
2.25.1

