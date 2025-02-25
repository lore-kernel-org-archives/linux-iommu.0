Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F70267708
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480879; cv=fail; b=GunW0yNMjxM6fnVKDaCoj6t+qOHEmdN90uhaHVFpyTIUZZjvRdJB+U4dNfuUf2GkGTZj2yLFB8wNNr4vWXHbsP5Re5z9uyqF/QWgIZ9+luLuUTWE3DfkTHSmlgD/AGT8mrf/VvO9iyMxfLnO02B8hC1J4wIgWupBmQrdpj7Bbl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480879; c=relaxed/simple;
	bh=QPjuNlSfa6iKPSKzC4tcFo+e/pn4ZTP89zFZvarkly4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bd5HyluJw3BI3heEhIniu8LyLXYBV0JtEJVQYD1j2uN9fxcOwI8IGkFLQcUE3K2yz6S52Ve2D4qe4HOc6px23F5l/wjnIdVlLLFXPlbFZ6YfJc9L3QCTOzoZvlpT/zUD2WL3WMcX6rRIJpiNdGdAdvU0AHVwTiqWxw0v8A1tIYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RUjN00KM; arc=fail smtp.client-ip=40.107.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RUjN00KM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRStZJJX7iYANy0ffuT+Zo2tV43SVt33zN2Y8K2I0PwAxb/12latxC/de8PP/gCxZgYXVQCC6mn7ZjbT5J0reiNzBnJ693i1jq53xRyH6K5k3bYOnGZMGY4oO5UDpSeFwJhsLyeVArc4FYKZD1kl5wCeXr9zVFZhm6rf7LZcnwfq87MyZ032yt4MxvnPPkmam6psS++61WA5ntST/RZ3U5o1HOIUsCMwUjBXcuvN6jNtWmN4QwTJF3qttet9ORwu8TIt8wAxp4Nl20XpPi2ogJzUwFRpb8Go3tdpPwwCLf/E4NCoA6VfAFMqqbRG5bViT6FRFlL7qZN7ld7muOe3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R69ESSeuxBXzSlqwP4MV5oICU1svwXk+0jEY9U7CX7M=;
 b=HqdjDUP+N+wLWTjLX/ku3E0eBGoP80kiyXau29YIEzOXciNS0/3lsGxuZh1iFdHD/q4jDRUBT7LEE9D8sFTQlkmm6WeO9CRnKcuuJOvAAoU5VCMii+p/+tiLhNHzOTlYjb/kNnYlaJTOoTV9L2l2D5dVTkf8dBw3OBIRgNOG9txXhnuFLFvzpvbN2qbMO8FvEUE75lLni7dnjWelIQiImO2B/Hubs+WRNXhDCVWGZwFaMxWhEO0FClAwnm3oQx5x/7hMXZ3Kjp1DZk0+bvPFh/TBdFkPk6nsPRvSSDfFhOmLPuVLAHfOcI5eH5lqsQScMWtZn8Lf6hyqYloeJOyUHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R69ESSeuxBXzSlqwP4MV5oICU1svwXk+0jEY9U7CX7M=;
 b=RUjN00KMRYuEoeti3qDP+hNHpOOddsxOuBhUuvtRspclgmJ3C7whWwks2cNHtd9RgSl3GhNI3/ChRXD5uklL6INiRWntWP1gVKStd+p+WBBv72SBNUob4CNercZ65cbz1e6/wod3BzzRdmttplmNRYt2Tn/EfkHkBUMXaVYHGvg=
Received: from SA1P222CA0159.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::7)
 by DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 10:54:35 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::2e) by SA1P222CA0159.outlook.office365.com
 (2603:10b6:806:3c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Tue,
 25 Feb 2025 10:54:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 10:54:34 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 04:54:32 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 2/7] iommu/amd: Remove unused variable
Date: Tue, 25 Feb 2025 10:53:40 +0000
Message-ID: <20250225105345.52143-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225105345.52143-1-vasant.hegde@amd.com>
References: <20250225105345.52143-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e69873-e137-4c35-c18d-08dd558aca8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0dDnt+tHqO4939a8mSgPgXfvVQBHVTLcwQT3Y7foXmF44MpeINEp6bJuOMo5?=
 =?us-ascii?Q?bobQW/iBD3INaedMIIYmhedIXsiTB72UzYVs9jgPvBD9EgVLPejNG18QtM8e?=
 =?us-ascii?Q?lP5RS/IBC4axATtML3YZ3NrAt/y3lXaNuPajHMVSenRflKtRwi1e2oOeIEdD?=
 =?us-ascii?Q?msdD5CmckVqQt8+L9hMGiUEOdPFYRffSdJ+uN7JrJxTGkJY2a7mCYsBuIMg0?=
 =?us-ascii?Q?2kJnjsMK1zBc+yk+4VsZd82xkkn6ltR7UbsOHflpedWvV5Ji7MvV7pycgDuo?=
 =?us-ascii?Q?lTj0TntrgTb/Eu0MYpnx/d1AIZjJKdOff1jNwkzXHvrN+l00TPKyv+rIcj+A?=
 =?us-ascii?Q?505B1RwD6O3s8cssz7a5d1FJR7rqPk9o81oaDHmp8nzdmyf4aKOidZMoo1Dr?=
 =?us-ascii?Q?eWxLMKqbmBhYldzZ8bP4JBS0C2nPXkPoPXjvq9v1LdoP7nnbCMpaJJtVOw84?=
 =?us-ascii?Q?JrYY2GpOnQq4GAu9OKe3PtbmZpoTQaO81s8WpqsPlVGNQUCOMuKha1qk/PI/?=
 =?us-ascii?Q?1a5RvAbEo+lmux5mF2D1JOFNVtb/m5dwpSz+3NBPke34ytiqsPSDsP/D/GZg?=
 =?us-ascii?Q?ofESrGTdQv/X4l/G66pVk8qEa8h5tpbIRPjsOEctblfCzbQzi5OQOI2dpCX8?=
 =?us-ascii?Q?pJAMRTbcBPVbvHtkTkG8zsIulLNsU3vguzkhQ5LpNwXU77F+d/g3OIQv05Hz?=
 =?us-ascii?Q?dHwRa/3tuSPbKDFoYpy+eRRd4HjyVRmOBX4ed4xd61B1YNjlEkKNa/lVeW2U?=
 =?us-ascii?Q?rcdxzKOmpAiV+SuiJx84+rJ6cog0Y/VX+KnxJAoGk16DWF/DjaNxEUFxpoiA?=
 =?us-ascii?Q?DTM34Ehv4KDmOuMfZ4LNF41Af2XQR2HCPCBZzEvd0WbgSNYno1lcg4u0WsMz?=
 =?us-ascii?Q?PAfMSFuhlaajYXp6AEaukdFDws5iMAQ+meV6BuWT4BqM8dcscHBxUnIJdLdI?=
 =?us-ascii?Q?ou1DbW92Z1MrB2n3oAmW7/TcflvJtDYylTd752jvGf3WcxBPxPe0MzbprhFP?=
 =?us-ascii?Q?0o36d1uJkmHRNShkLhJPCoOgaahBDcfOmoeUxsEFvzLnHPpkgji1TAMcWlk9?=
 =?us-ascii?Q?FWLW+V07h6dt8mpzvX3v2r6fdQ9+0uxnvndU7pC2DLKx0T24JrewwhCLxQD8?=
 =?us-ascii?Q?ymhsgmEeMu+bs7mBeo39VeXYVp+mNP7pKOfW5cKGzc4XkW+cVu5UDbBQJvcc?=
 =?us-ascii?Q?RyoB6RCAEkgtzgIFchcPT75f9T4AmyjfavhaTyK1MDjaF19UY3t4NZS2Oa/m?=
 =?us-ascii?Q?pgf+e6snJX4BmkEhOKhqxnRdx+TGOSxhHenSZbFmZ0PowMu0mGVegdf0Gemf?=
 =?us-ascii?Q?KdXS+ORKb4nhpevTFwHyanu1arbHcDpYxIooA6+A2MwhutEfwfOUVEPNRMos?=
 =?us-ascii?Q?wk5bxgmtvP2SgG7LqJ2+fW2JruMAbRI343dA6TI3ck4a1TkjVpQkCeqmRSP4?=
 =?us-ascii?Q?fmHijSNxH/xj/wMQ+yyK29Yj8MEsvkQSu2gWgvlcFFGrVX9xsXRWnr9wlqAX?=
 =?us-ascii?Q?mcbEwA5Ip9eFBxQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 10:54:34.7610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e69873-e137-4c35-c18d-08dd558aca8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456

Remove 'amd_iommu_aperture_order' as its not used since commit d9cfed925448.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 23caea22f8dc..3f57bdd0a659 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -928,9 +928,6 @@ struct unity_map_entry {
  * Data structures for device handling
  */
 
-/* size of the dma_ops aperture as power of 2 */
-extern unsigned amd_iommu_aperture_order;
-
 extern bool amd_iommu_force_isolation;
 
 /* Max levels of glxval supported */
-- 
2.31.1

