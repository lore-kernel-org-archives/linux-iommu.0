Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFD1125B3
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2+vmXkV/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PD7ht4uEUbc0QNmzbsCX51rSP5A/lDCBzQ6SftcAvCyPjk1xFFlp81CPvVfDDCZraU+AINLv7pOz8VCrIWNpiukdA47cE9IKs3ZwkIZSGDc95Z9++e+nYRmMGsRs0j8kb3Mwu8JUGP21lS5290YUyPGEpTjoAf+Oc+C9ZhiH/m5Vcsab+YTJMBGydIFyjDAZFafspqW/PtIMJLCuSksRv4ZQ9de7BfOG9foFZGRnEl3F43Xdq2GcBqJEryTGx6ySyI1pS1skcrcBakV31FlWd6HDeQVq3UpYyWPV7+USHCyc+9wWfcvtC7IeJ/P2BA2mJ9yQq4ZUBdWfrlrYGyetjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9t5tbtSmQQt44/QmYrnFFxTggIJiDbxIUYt8Zq2/To=;
 b=TQU/6ETN2VSEzdr6vHFMxYOvPOCdtgHpgMUdPwW9gNHhufSMuOl84iP82h6fx9F+b5AyP435xnpmXtbbJ64lOrfPavGRf2exekUjMEDxmG5VnkUtWUVbkEg2Q46ASP9+VnQrPaBB3l+EDuVjlFXUqUK3vA7GCvSKRi2NBmk+Uvpp523AzfDiG1GNsmtWpyZe3OMKp5sp4BUnOStyEABrpbHk+2BhTpfDBcH2KvwV83y9FF73RVPm8L4KBOOH2VIjIbRbSVDtTyW51A13oSvc2NJSYeGdTeE61P9i46ORovgggOtecgCRyJox6kYi89Bif+3KlAN1rdbyiqGxIf6dFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9t5tbtSmQQt44/QmYrnFFxTggIJiDbxIUYt8Zq2/To=;
 b=2+vmXkV/EzZWYE8usJnJfYi640erXeSaoExdH8pkjZm+erKSBhrSacHxBcWVVlPjCENKdCMLrZX2zmsHszULQjoncW/BK5eTRKNF7KHAnJPnsvPh16uQnBj/AXobEHCU0b5NP2SHDAuNcwoahAlICFP1KmQpFF0yBPH6r15hI0A=
Received: from CH2PR10CA0016.namprd10.prod.outlook.com (2603:10b6:610:4c::26)
 by SA1PR12MB7441.namprd12.prod.outlook.com (2603:10b6:806:2b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Fri, 6 Oct
 2023 09:58:58 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::5b) by CH2PR10CA0016.outlook.office365.com
 (2603:10b6:610:4c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34 via Frontend
 Transport; Fri, 6 Oct 2023 09:58:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 09:58:58 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 04:58:54 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Robin Murphy <robin.murphy@arm.com>, Takashi Iwai <tiwai@suse.de>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v4 5/5] Revert "iommu: Fix false ownership failure on AMD systems with PASID activated"
Date: Fri, 6 Oct 2023 09:57:06 +0000
Message-ID: <20231006095706.5694-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006095706.5694-1-vasant.hegde@amd.com>
References: <20231006095706.5694-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SA1PR12MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 62c272e8-e093-4deb-7c29-08dbc652dc00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d+mZHvbwwUS6QEPMl4CRHznZAFrE4xOWKMG5Ad366vbeQAJ8Pr+6DQlUha9b45XckGhpwSVsFQT9FSgjdRS0mH2kcwhnnsrQ5o63Qdwt6uJtXVeFr52GQHOWeVhNwAPtw4pnaeEX2QLixeNRFKN/OkjaX3EwBQcRaWIg8cx+O9N28C4i+y0Ge8EgIL039qXD1gn0/6+1qTode9wqLdg64rsMRT8mnNX5G/JIj0ogPzlohbsBF/kmMw6LMTk7vVWp40HLzXvh3i6Os9ox2Ebt+xJ6dTfQpagV2QklLHS9emcv7vRgaxesr0zDipnp6dvZani1AYi7LIQ3yME+B68Wohz7XUvUZNL5rp9ACI4dUFZWWP/4Moxin3oI/15eMCD+08DWpbBOz/2YsHTY9TQKN4L+ebVPV5fKzmQzh0QMa/DS+vuxB86mck9sLm3TBd3To7e7pUv/1gMkZt/TN+kG3uWrU+1sh99iL+N3IBTWWpB2Oi1+plxXBSnO/hLvpkXJ1g720qCqwJWkXnEOFlMVRF1ap3FmBvTsoVVX8z9W0tpohjI6i/Hg5g7X+cRiIEZIQSa3o3LnSCZNJ0UD/iTjYSE7fnkXJTtMoUU5AukP6Ge6/OW+qLEoEMT7uc9FTjSiJMkldRVeWeic/V4Hx44/LeJDVAifCmPmh391gR8wpAYQYRdm998p/pfJFF+0kMkF5OA96CVi08IimjvynJRbot+5yWnJA6TBDO+FmUi+VaaDQkubcE2HYb4yWURYMrWnh95TH7QAedHtnJL5+P8Azg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(2616005)(7696005)(83380400001)(1076003)(6666004)(47076005)(336012)(426003)(110136005)(5660300002)(54906003)(26005)(70206006)(44832011)(2906002)(8676002)(41300700001)(16526019)(70586007)(4326008)(8936002)(478600001)(40460700003)(316002)(36860700001)(82740400003)(356005)(81166007)(40480700001)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 09:58:58.2913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c272e8-e093-4deb-7c29-08dbc652dc00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7441

This reverts commit 2380f1e8195ef612deea1dc7a3d611c5d2b9b56a.

Previous patch removed AMD iommu_v2 module. Hence its safe to revert this
workaround.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/iommu.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1daa5e7e2b9b..6e88397c3c7e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2957,24 +2957,6 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	return ret ?: count;
 }
 
-static bool iommu_is_default_domain(struct iommu_group *group)
-{
-	if (group->domain == group->default_domain)
-		return true;
-
-	/*
-	 * If the default domain was set to identity and it is still an identity
-	 * domain then we consider this a pass. This happens because of
-	 * amd_iommu_init_device() replacing the default idenytity domain with an
-	 * identity domain that has a different configuration for AMDGPU.
-	 */
-	if (group->default_domain &&
-	    group->default_domain->type == IOMMU_DOMAIN_IDENTITY &&
-	    group->domain && group->domain->type == IOMMU_DOMAIN_IDENTITY)
-		return true;
-	return false;
-}
-
 /**
  * iommu_device_use_default_domain() - Device driver wants to handle device
  *                                     DMA through the kernel DMA API.
@@ -2994,7 +2976,7 @@ int iommu_device_use_default_domain(struct device *dev)
 
 	mutex_lock(&group->mutex);
 	if (group->owner_cnt) {
-		if (group->owner || !iommu_is_default_domain(group) ||
+		if (group->domain != group->default_domain || group->owner ||
 		    !xa_empty(&group->pasid_array)) {
 			ret = -EBUSY;
 			goto unlock_out;
-- 
2.31.1

