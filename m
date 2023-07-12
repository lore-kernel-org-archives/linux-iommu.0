Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DB5100AE
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 14:19:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XX128Y6pqrM+gbN+mtKRz0Nf+JyTBra2k53M1DHbfiNc6zP+dL21oXsoPYuJVZPZHRm4MndrskcY8SV9mrBqsmimrGzyAAxogI/7DL3AymBwKDwETwFq3w/l/MyX2fVOKpufML2ZG0zhUUMJ13jmRXc5j7DsIWEF10JzL7P3uniqCNzN0Wh8wvURWPy3PherY9OdzVo25+L+UvBagbo0lel/xsJd6GF1pn846jrCjBOa+aYXxLHdBWmHHmiqJevfdwz6vKCJxMfwoaHSFKJcaxhRH06ucn9WKRmr2kfg9cdhA25fKoIa/IrBz7aMKgO2PhSs5ln7zeuE6DKkT09A6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYMvNrZb0nAaRopFl1qqcQfARiIX67QEXMLTSiioBU8=;
 b=hTWgJGnHNDXz+QAgZ/2ugajNiLLdr7YqmbHe+uCkHTf85Uyq2q8tD4M1lm8//I70TM3LAbJmbb5N7q2u5FbhVOJA0lSJk3fhfzShwBUOyb+AomZFMVqlBS5QiFjTNGsuQSMbz/L2yYLPlBYf0k8ZOtVzs3rmcKmA5MdpzZ1jv55fg/W7y6SbDx6tRmwqR8FGre4m2CAlGQJdTp2KuswdA6jjYPJzJ4VbvDwyPdob0TzIGjsA+9Axm2I8ZFn78+Nz5oenCpC+UYCklQrgDSjDsTb3KDqeY7uogZjtWdTcIQJnOGjpNGSlQKE7ioFjHO9tYhj65I5UNSPJLYrdeYg6hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYMvNrZb0nAaRopFl1qqcQfARiIX67QEXMLTSiioBU8=;
 b=06q+lE7E0nG8GJW/+QLA8ONi2IRWvciUwgEklZpKXrCJm1XobjSye+SKeL/tGzOR/rKSa4LpMFlM4k9IKwcThNgfxH03ZwCSd4xU9jH7wH9tVO5vUikPChm5s1cqf7xyI1A3CAwGlsL6kHcPPb4idVSu2c66TbQ8Ce4AUELMDE8=
Received: from MW4PR03CA0125.namprd03.prod.outlook.com (2603:10b6:303:8c::10)
 by CO6PR12MB5492.namprd12.prod.outlook.com (2603:10b6:5:35d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 14:19:25 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::11) by MW4PR03CA0125.outlook.office365.com
 (2603:10b6:303:8c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 14:19:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 14:19:25 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 09:19:22 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 14/21] iommu/amd: Refactor domain allocation code for v2DMA mode
Date: Wed, 12 Jul 2023 14:15:09 +0000
Message-ID: <20230712141516.154144-15-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712141516.154144-1-vasant.hegde@amd.com>
References: <20230712141516.154144-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT106:EE_|CO6PR12MB5492:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6d3a41-51cd-4f70-cc11-08db82e2fef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LNVqcAEwyOeXmP0DHqk3uPox8HdLiUbiDmoeVT3kAWJ83UESV9cPNtxScc3AItckny+KBmTdEHdQdF7nCdBoAdepwTzAGCgOYYMm9+0kDsLAfBN3iyCNxwjqDZwwHA92u1vSHRlojhzgCVvFcHTW9sULgFqQotkuuEw+35ur+RZOlK5AW+/lDF/Qi+a9MqIJ5RVYrP8eaEDS2kTvSdBu0qTAb2EeYXMsGm74rQiFFfRyeTQYE4Um70/dg1MOqG8qd0XXzdPlBOPnngzv2468WnNgnvha1dillQxG2PYpU5Fv4kN66zmpcZTfI0nmBNf9rP+DE0+LQEPrYq0f172SAWqKHjR9omuxhxKhI9GToE5+9sx97iQ16EA2EI40Nbe6we418udHo0aL92S9WqTBKN4+CTJzLMLk+qRyTQCG/v0lfjejdVW8gUY2Pe0rQ2U/sI2pNldhBHBkEv+xooed5pZyEl2gnWqiNIl5bwYT/Pk+eC7O7DYX7qrIoLRW1mykz9uqsIalJt+VbL9buPlGLUY23p1KX6uvHvzMuUUZZcf//kYU73myab80XbkOALnYQ6/rwrKcB3nOAr2nPHTGovpf29LLFE/8wSZ2a1R3jVDjUXEYOTKzu4Ug8ix5buMOuMZJpB6shranjbh0TFvx+D9StH5pex9cVe2vBqS16hMtLp+mT27/U8Gxjpz65HEhygALe/lw/XcXvJyhr+zUg7prsT03sHgR1vfh12rfnDIQg83V3V5OY+PeYat1j3DuP4FH9IC+ChxXMK2ZSccwCg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(7696005)(40460700003)(6666004)(36860700001)(47076005)(186003)(1076003)(26005)(426003)(83380400001)(336012)(16526019)(36756003)(82310400005)(2616005)(86362001)(81166007)(356005)(82740400003)(40480700001)(70586007)(4326008)(70206006)(2906002)(41300700001)(316002)(44832011)(8676002)(8936002)(110136005)(54906003)(5660300002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:19:25.1386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6d3a41-51cd-4f70-cc11-08db82e2fef3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5492

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

The amd_iommu_v2_domain_init() configures a protection domain based on
the specified v2 mode. It has sanity checks to determine if the mode
can be enabled safely.

Therefore, refactor the v2DMA domain initialization code into the
amd_iommu_v2_domain_init() and use this function instead.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 22d5ac82efc1..3c9fd2adad33 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2109,7 +2109,7 @@ int amd_iommu_v2_domain_init(struct protection_domain *pdom,
 			     struct pci_dev *pdev, int pasids, u32 pd_flags)
 {
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	spin_lock_irqsave(&pdom->lock, flags);
 
@@ -2117,6 +2117,11 @@ int amd_iommu_v2_domain_init(struct protection_domain *pdom,
 	case PD_FLAG_V2API:
 		ret = v2api_domain_init(pdom);
 		break;
+	/* This gets called from domain allocation path */
+	case PD_FLAG_V2DMA:
+		pdom->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
+		pdom->flags |= PD_FLAG_GIOV;
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -2179,19 +2184,6 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 	return 0;
 }
 
-static int protection_domain_init_v2(struct protection_domain *domain)
-{
-	domain->flags |= PD_FLAG_GIOV;
-
-	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
-
-	if (setup_gcr3_table(domain, 1))
-		return -ENOMEM;
-
-	domain->flags |= PD_FLAG_V2DMA;
-	return 0;
-}
-
 static struct protection_domain *protection_domain_alloc(unsigned int type)
 {
 	struct io_pgtable_ops *pgtbl_ops;
@@ -2237,7 +2229,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 		ret = protection_domain_init_v1(domain, DEFAULT_PGTABLE_LEVEL);
 		break;
 	case AMD_IOMMU_V2:
-		ret = protection_domain_init_v2(domain);
+		ret = amd_iommu_v2_domain_init(domain, NULL, 1, PD_FLAG_V2DMA);
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.31.1

