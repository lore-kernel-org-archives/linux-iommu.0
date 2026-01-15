Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAA42D8773
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 06:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768457362; cv=fail; b=lLWysRrSgyGKwQ+Yo6PV987bwC+MX6jsfAFeQ5u9QMkj4iw1xU7SAhBm3wGuU7NjVI7zN3E8ikJsOqy+sRCzV5Qp/F91Rmt94XNKWAV7hGUp2SRRYTs3iHVcuJyrScPW1gQfZmn6L/lAU3I4AMlhcVgK+UgpyfIHOyXAO4qHg08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768457362; c=relaxed/simple;
	bh=vvVSLZ9ImZlYsqAZdzEiSbitcT7IzVZt0fdTi09B4Y8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KbvhrFswFLxgJD9j6tIhKU2fUI/7iz+E0mgTtS6nmo+sYkl8/W7cbQ8Nz8DPHO6+aGM0vHke1IjBPXLcaG4txMTofF/2dkBO52hhidAvyeiU8A2uccTg/QV0iaROOFVdR0U7EWVkhr9S9whLQRGWsQDPYRtK87FcT/GeyfSrrwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZiZ2Qu5v; arc=fail smtp.client-ip=52.101.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZiZ2Qu5v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQw6YjIJXM2tvrIpQ1weqJ2Vql//PkaH4+K5FM4z5YiYKM5r5EvM2iaKZvG7ERSPIhfQo+0cGgVNiiyTrxb/3d8yc9VAo4SOJImm9UPBMySv8GlDhxyxFjYCRpdU2s5dqIPxld/VfIX4tJUpTG6hUyMmw0ugYwmIekAeaPkz/GwWXppwSPsd3eoN7haQj1Qbc+w/aDDudRwRJKbT0mxVN/2pko3nvj6vYfJIJEqJ5jnSz2Zl09DOZY3wiPSMCfQuiDPPUluT/gmY32FXKzjcwr/W5oKq76MWaTHhuM8s6364Q9Z03dzfOTe7Nkq8HTUccJt2dxMs2dn7MSds+3SM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6wfwZHH41RL/zq7uyzKNqn6z7Urm4pJvs3R7I3hIA0=;
 b=R2rPSHsI4oxdzpmtOSQHx4/GZwVFoQqVKN1dwTdHQH6tAHe2horuc4lpNLr7RMA1fVu4byWefEm3PbTcQNLNrYqyndI1WPFgR3onFq8ajH5l35WXTUWC4DN/5EajRp2UYICwUfvDPQHosfwRov0VDItlle8bkLzohKWQSq6wPiTwQPvZeMVYmCmAwibG1xe1knYTYOxJKleRKNar8vJBKlVvLCsdJAWabSfQrK218q6R95bXZ0SFRP2eM5OuLuKkz3l1ZkquEjA/iEgXiBGMAkEW4ccW8LaaxB5KgX86EuuJuLZQ2csMqOE1aw23bgxMSde9dkTCsi9IfcQyWzyJxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6wfwZHH41RL/zq7uyzKNqn6z7Urm4pJvs3R7I3hIA0=;
 b=ZiZ2Qu5vJ3snyy9iFv3ehwcHs6Sf8NAiCjbp3Oz+o0dyKYrI6yYIUbtCEK6Gq/b93u3Fh9RRfgTKfn++P2Wv1gPuc3uhikImlJkYTBI0U2ZHZV7wmru2nXTLbbn+knX5JHUDdj0ZvldxHcY1YnZ+buEmISzeY76TSETgNfhAmGA=
Received: from SN1PR12CA0063.namprd12.prod.outlook.com (2603:10b6:802:20::34)
 by SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 06:09:16 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::8c) by SN1PR12CA0063.outlook.office365.com
 (2603:10b6:802:20::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Thu,
 15 Jan 2026 06:09:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 06:09:16 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 00:09:10 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 07/13] iommu/amd: Add support for nest parent domain allocation
Date: Thu, 15 Jan 2026 06:08:08 +0000
Message-ID: <20260115060814.10692-8-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
References: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|SA0PR12MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ed659c-3f31-437d-8b59-08de53fc9d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A+MMDc3/cMEJ/+zbsGLJBRi6ANEQ3mGp3Au4KdyAF/SBmekRcpJ02CsjF+DH?=
 =?us-ascii?Q?aC9Oi9rSs1sIX9UPAjvQCB1aHBwG/PWVtcMk+fBfVDpq2TcqBl89d1Nt5t+n?=
 =?us-ascii?Q?px+5YoNH72k+SCZQdskBtNVB3PKWi4H+A38bMIvyJOQFL9yACp3v2FeBAAOA?=
 =?us-ascii?Q?2tCJytitXSdme5iMZKKaanCv9kp9UU1Jr+3Km44mIrLesAxdKDb9vrl/RQL+?=
 =?us-ascii?Q?/jZKgUE4pmWt1/XUFKXUNddHzVnQncy11XxEuFfzxXiCTbMPG2Agvmexp8bG?=
 =?us-ascii?Q?lfAUJyq6yhFLsq3qVE0Ae3RbuQZTGLKmyAA0+niLD9RUVhmxnTmLUnzJb6Ug?=
 =?us-ascii?Q?splZwsd3H3SwJK8qlUd5taox8FJwhwOrTL8S4sm4/zepjJ90l11uXunXN/cz?=
 =?us-ascii?Q?Bk5VuM87Got2N+IQ8j6rmZuk97JDwfBoHPmeymkld+UhF+CaniWZ8PkxkXMT?=
 =?us-ascii?Q?ZcUmCuPIuXgtWF2C82m1BKzh6IYymhXyzIX6PaJ0Eg544RfOxWW+rSFA0B5v?=
 =?us-ascii?Q?TlxkXxrXXn1ICPSAU3jtbNYfcLr4oxwQ9spNYFWe77V+/KC79HHD2WmnETDG?=
 =?us-ascii?Q?kjUGzcOrl56/UNlJsOeHut8Dmg+B9q72sexJv+ZXwYZ+dpJ4FU0MRAXL17wg?=
 =?us-ascii?Q?Nw/a131MDSjRbvXGTzPj0DL3LJmndQZjLyejrPAIKDFZnwBnqTWV81lThj7X?=
 =?us-ascii?Q?JWz07a2UsVVsXGru4vPaz54yakt62WVPoofPvELnnLyuh7ZDbeHSADAHCyBk?=
 =?us-ascii?Q?jFEeDsJb2B/zW3TPONxU1mnp1+AA0q/5beLJ9AISyx3yQ/0FlXnc0K10vrOq?=
 =?us-ascii?Q?hVVrYs3Ux7knfKwAUafhpEyaUTNYDLiMoWm0um+sVLK7AgVPy/LeExGfn1nb?=
 =?us-ascii?Q?0DZJFZEwYc+DcZNMB12qUoWJ9ugfLZ7sLHdiLF37Pi2QXQiIw1C/KUKguEic?=
 =?us-ascii?Q?YnB2aoEZH5SuYnuiumfxx2JZ4USw9Ae2oRCK1xfVGWJr2qfaFrKHgLjz0zvn?=
 =?us-ascii?Q?yQHT9L4AIhlNsdAnQ0/R77MTBQZY/l+uniXI7Sy9XK/So/Gq2Z7LQ6JDtxiR?=
 =?us-ascii?Q?QFsjzJ81D+zFQCUU81nxg78OwkAHYw+uLqUsN8LL35kb37Jty5FqH5KeLWDu?=
 =?us-ascii?Q?5RK/VdfKoFum4BOSC733hGOuAQi74JqdChc83ot3FPSSToy6mVwXI/48T/Tj?=
 =?us-ascii?Q?t1khNVEcp3FEHrIT2aKGnGp3z94cchoF7Qdcwa1wLXmvB+oxwPxjZc8fyGOq?=
 =?us-ascii?Q?ipSZ8iUply0sTipt67LNK7US63XPlW8n2lmdgE5ppKy/yht9QDKhZpqBKf2l?=
 =?us-ascii?Q?e24grOFz3vxwpJexXYbOOAFP+Lgh32ODAHIOPHcrBLFycm5d5w96jIPj3Rps?=
 =?us-ascii?Q?RHCp6VPzkYEVmIztLFMN0nAy6Sg7UexXb1b5xvyIbtxnNcPtQsiEc2U3BkVn?=
 =?us-ascii?Q?dSfF4+n/NatA0W36MKzJJXAt2d0c5cf/aqHcxfwqRY7+34awL47e7PY+ILMi?=
 =?us-ascii?Q?EcICpMRn/R0fdYGT1lS/qr364HNctDK6DbIuiiA9SL6Lxl1qz2uo599Z801w?=
 =?us-ascii?Q?QfTYGvoPXqfTBWguhLFLIBHkZJm0L9PGqwvD+FLlrC6jT8RDNENBFoEahgHL?=
 =?us-ascii?Q?NqCNk2iXWTDH+xqNe7YdhDk9R0uRJ9s7NzBy4QebBAXpdsEJVKoGFV9jC37P?=
 =?us-ascii?Q?XRZ3kg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 06:09:16.6892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ed659c-3f31-437d-8b59-08de53fc9d35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7462

To support nested translation, the nest parent domain is allocated with
IOMMU_HWPT_ALLOC_NEST_PARENT flag, and stores information of the v1 page
table for stage 2 (i.e. GPA->SPA).

Also, only support nest parent domain on AMD system, which can support
the Guest CR3 Table (GCR3TRPMode) feature. This feature is required in
order to program DTE[GCR3 Table Root Pointer] with the GPA.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6fea4ac97e3d..9b2fd852eb88 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2765,6 +2765,14 @@ static struct iommu_domain *amd_iommu_domain_alloc_paging_v2(struct device *dev,
 	return &domain->domain;
 }
 
+static inline bool is_nest_parent_supported(u32 flags)
+{
+	/* Only allow nest parent when these features are supported */
+	return check_feature(FEATURE_GT) &&
+	       check_feature(FEATURE_GIOSUP) &&
+	       check_feature2(FEATURE_GCR3TRPMODE);
+}
+
 static struct iommu_domain *
 amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 				    const struct iommu_user_data *user_data)
@@ -2772,16 +2780,28 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 {
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
 	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
-						IOMMU_HWPT_ALLOC_PASID;
+						IOMMU_HWPT_ALLOC_PASID |
+						IOMMU_HWPT_ALLOC_NEST_PARENT;
 
 	if ((flags & ~supported_flags) || user_data)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	switch (flags & supported_flags) {
 	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
-		/* Allocate domain with v1 page table for dirty tracking */
-		if (!amd_iommu_hd_support(iommu))
+	case IOMMU_HWPT_ALLOC_NEST_PARENT:
+	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT:
+		/*
+		 * Allocate domain with v1 page table for dirty tracking
+		 * and/or Nest parent.
+		 */
+		if ((flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) &&
+		    !amd_iommu_hd_support(iommu))
+			break;
+
+		if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) &&
+		    !is_nest_parent_supported(flags))
 			break;
+
 		return amd_iommu_domain_alloc_paging_v1(dev, flags);
 	case IOMMU_HWPT_ALLOC_PASID:
 		/* Allocate domain with v2 page table if IOMMU supports PASID. */
-- 
2.34.1

