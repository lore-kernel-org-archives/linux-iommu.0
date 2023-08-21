Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E11187B
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:43:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iW2c7rJyuOpVPiFC5QMbKDScCFpRs9IiOtHn7MeCbXMoQcBXHkWHrsFb7ky+vVkE3MlbZY4/i+8NNsJduEsQ6/ekrTihthAhYKxi/7bmQHuFXdszlwDC/5Dsz7j5vmKS9LxWc3v8uvuvBEK7dlRFWtzr3Ss2WBY7z34SF3werSUHeXJXtOzuiL3K7Qpc2gaiheHtax8A6fcF/IfWEcTHpHs74CHTT6J+hM35KofPFUVdZFtBkskdno+jczJNX2U2i655fX1gkCfzrsxqy72Dnbp4kwXC94ZPDXkvZLM5mMLTRGGucKHEYcaDyR7RgSPmFqQK8ZqXCTV+XY1yU8QqZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NdJbBZFOUteX7RLl3uR+kZ9b5bHClRDLcCjpmOZ0YE=;
 b=OkQQ4X1ju3QWuEnM6TTiANhThSYBpl7S/JL322Qgad+NUnIlmLECQCcjPQUfG9M+q+w/b4y2w/lTz9dmtu6h6HqX9ecZ95j16cS17gVReUwwX5oY48wbl6kF4HEbYqiQ9o/9dBe+M3JCrZ4SXX1Y8KrKXG6AkBFMBS32O0E8jLnAql1ZwcDoE0uUnkBfH/cjWPB60fcqD66hMw6dkD8LLVYeww6XVe43UxMZDZX0lmUpBgG2T0oDDk/rOyHbm3wlOjOxrANonO2v4POrlBS4n+KtYCFt+4COsvlEcObvSPkWNZZQb+csSqo6hPiv/r2WegBQaT/H6Ehiw+NwR26VGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NdJbBZFOUteX7RLl3uR+kZ9b5bHClRDLcCjpmOZ0YE=;
 b=gqnkBdKBflCMt4Q4MFYxSBmqdddc2zDXd3Z0CIH42xGXnWBmZUkwD962M7732tJoIMcV/P7/9Mo7Jdj+4R0B1YEdcVVtS3C7Ni0ppifzbqG0G0Sn9ZFudSS+kKty2EbOh5cLubldt9yBylx1TX/SyKnYLHXo+nrL4cGruTz0YTY=
Received: from SA0PR11CA0206.namprd11.prod.outlook.com (2603:10b6:806:1bc::31)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 10:43:23 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::fb) by SA0PR11CA0206.outlook.office365.com
 (2603:10b6:806:1bc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 10:43:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 10:43:23 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 05:43:19 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 01/14] iommu/amd: Remove unused amd_io_pgtable.pt_root variable
Date: Mon, 21 Aug 2023 10:42:14 +0000
Message-ID: <20230821104227.706997-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821104227.706997-1-vasant.hegde@amd.com>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a2d061-6833-49e2-6448-08dba233715e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EKMod5SC7LMlsGkewXYE8j5T0QWQUx0uNx1z45OY+iZqe/4t0l/8LeJX2fy4w8UNLlviRyfKAxzqe9Aw3GsFUeg3Cl7TflP66zv3Ml0apJ7UJi0EoqaSAuR0BhWAthbAJvkU0kAFIeIjEwF+r5CWmtR3zNnddi3GDxmWGQl2ZqlfAQlKm0edFra2vzrkWlZ4x5rlBTuq9V/QIad5z0a5mkq8ykM3hQZWv0HDwPcz/ty1BzxYcjvqm9wMOhqhjtIB0sq1Gq7E3Ia59364aiR6DRbKjYEsz13694IE989maWXbQqBv7W5hqKJ2qrSDPU+NhXwPKxxlq6m0K5UYFJRfU6h7NtJwXpOB3BOl+FHKslbm0tMYwJZZxcv5e1aofh/+RzoNiPNjnkrbz2+232JR1cye09yRrc1+azvkTicwpxY4ET+ia7/T7sevpRUtiVAYX9ChXI297q4/2Tw3MDn70XpH0HIaT4gH2wHNHnUm9LEzrF/Dm04h/t5HDXRR4oU8vyB6r/E+rjPLqwzo7tsvc/MwqddBTDa0SLeSk2gEoglhsyS26nEr5rTgTk9AYBqFzsNw2qw6JNmCOmnF/qROXk3nDs+6yWwv/1e4SGjkuJDuus8JPv4NCCWsXD8XwTRxks6d0iFzwPdSJX+MIvSOAE0c7uDykzBySvQUttdKN2tbo/uLa8CQ+l6Yo6qzLiwAu0r+M2rWexXdUMwXmUgJ1BqHVFHLTzvyQ4K08hwzDaMsFuyowh+7JRPHhyGmwPKNV47hITm8UfqEE7VvhGwmzw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(7696005)(40480700001)(5660300002)(44832011)(336012)(426003)(16526019)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(54906003)(70586007)(110136005)(478600001)(82740400003)(356005)(81166007)(6666004)(40460700003)(41300700001)(36756003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 10:43:23.1475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a2d061-6833-49e2-6448-08dba233715e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

It has been no longer used since the commit 6eedb59c18a3 ("iommu/amd:
Remove amd_iommu_domain_get_pgtable").

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd/amd_iommu.h       | 1 -
 drivers/iommu/amd/amd_iommu_types.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index f23ad6043f04..6bf55de9fbeb 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -108,7 +108,6 @@ static inline void *iommu_phys_to_virt(unsigned long paddr)
 static inline
 void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
 {
-	atomic64_set(&domain->iop.pt_root, root);
 	domain->iop.root = (u64 *)(root & PAGE_MASK);
 	domain->iop.mode = root & 7; /* lowest 3 bits encode pgtable mode */
 }
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 7dc30c2b56b3..081d8d0f29d5 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -544,7 +544,6 @@ struct amd_io_pgtable {
 	struct io_pgtable	iop;
 	int			mode;
 	u64			*root;
-	atomic64_t		pt_root;	/* pgtable root and pgtable mode */
 	u64			*pgd;		/* v2 pgtable pgd pointer */
 };
 
-- 
2.31.1

