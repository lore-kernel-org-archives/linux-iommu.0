Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE3C100AE
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 14:16:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hek9Zu6EmzIJ1zwc3YI3USEGxpogyQFuOKRhRfVwvwbLaBYaPaSPpIHKTwhODjr700OUnPidILcxZjfSyNaUL0aRhT4667RUSCtv0E9O3dhq+FD/OPCvrlDz2zTdklcecAeJTlPIdUSfmJsm4aJH2u9aouaRoPN0y1dPqrXNwwE+E2732SPGdDXildy23++aYub7MTNQOts3w7hzplNzQ6cdPH8kDaiExRLQzjgicyYYk7fSvxeRexX91BIu0o4difb30gl9dC2ySK9sZdaJa17x4czzaf9zCsy+47/DKRIkHl1Qg1tqZwTqoyfZ+yDLO2Ls3g3omwyumXFBqPGzxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LKqiLa1Il37z17fbgm+SlAnXOa1lrWhQjkGMLR8Dac=;
 b=SppKUe/TVWKP+AzYCCSBWqI/k6W75iMdZ3uj2cWTfqVLfW3chA4Ry9LFRNRK3LQ0E3QQXGaGuWhR8x/gx+y4mxHHlMkcB+Ba4k9wPYKiUGvb0EUKzbq1NU9vDRnQN8jRbNTTzIt2+IjDC0UDglCUrm4ncoSEsnAatNqp2OwdYvRAJw9z89RKWLshXeZZM5urd26Pl3BhjhxV7PQEZY3w87Oo/VCwAAs95X0DrPZ5ZfOlBd+HYUDiTEdGUy6ZHTu//xlS38AjQoh7jAsQLn7AUkHjAz60knshmbdTGOgHAntt9m4t1qqoIsEDmjS3tWrMNaxLzG5O8U51F5gr8orsbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LKqiLa1Il37z17fbgm+SlAnXOa1lrWhQjkGMLR8Dac=;
 b=J0BYnXQAD55OnoRWX2K8GtMa7xR1ly+24040quaugq6GmAy8qYRxlKouSWy4srckVTt50K3AIUQ6K1f2nbHWVilvCPSe5GNw0svxK8u1y85TP+fXdMcWUj+9y/B7Hw/UxENS49YttRJ61y7BkPBfxC57kZXVB09aX28fWgcz7hk=
Received: from DS7PR03CA0275.namprd03.prod.outlook.com (2603:10b6:5:3ad::10)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 14:16:08 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::a2) by DS7PR03CA0275.outlook.office365.com
 (2603:10b6:5:3ad::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 14:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 14:16:08 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 09:16:06 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 01/21] iommu/amd: Remove unused amd_io_pgtable.pt_root variable
Date: Wed, 12 Jul 2023 14:14:56 +0000
Message-ID: <20230712141516.154144-2-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|DM4PR12MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 8812a772-e422-4b20-c734-08db82e2896c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YOUE8cmZwJL2Z+mj/ptwH55UcknjOXKQt2SsVEcfxl8SSYV7f4q3kc29ThJ4d8UlZ31RvBK0PDZVogTKN9PyAazAcAB/kjc+17iN3DjZmP7LaQEhUQqheYMKYEU/jgJa/DsRhq4RyZmK+/M2F/tuiRpO0uaxcZNCZqFrsN4gx4djJ0QoXuwZQ9i4UwJOaZ9ITjI8Lw78YgzF/s0LvvweuIpdajMtz9xKUjREqhlBMKQJUc5a2PzKCJUt0SRF+086D1i9Wx8YflfEb30tOG6LceiN6HUpLWDFO8ElbMrHPG1K+6857n22YOZ6UL5flLcSjjQt3ATgxJYOXkyZBSMzJ7nh0cTVyz96ERzEbRJKWzPfaXmy+kr4gc8y9vomkMRFMKqXghEOu/+s1+dDPG5d7cV6PEqJHkcyxlRKOXTEpLDEIehIW55oV6j6CxrpnYwoPZU7Ju9ecFwoPzk9oDP3iJcBWCBPFreVUZecnukxL0o/+o4TaZZRbA/onbqZOSNSuFXka3FgbHN5bZphiXU0zHWpLBJ4QCvhqU9ljXIohDPFdqJJBEgy8yIu45MrCVj4QE84HX2O7pz1a1iyaW6+vr/H5FNjQhftrTjt8Zkwo5diR6KMP3B6KZO7KRW81l57sfaXd+YXX+Ej2TPzjbvCLHVsVH6xVLhPnTa0dVIjp9AVdBmulmmcR25cy/eKQRU28Hnvyp15Iqm0/i4igK7CRYHQ/tpIBWq5tnc/jAKHtPbKZgGe8uBFni+Igz8qoMf7OyrT6RdpyoqIbyqfjE9FAQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(4326008)(70586007)(70206006)(16526019)(82310400005)(356005)(81166007)(86362001)(186003)(336012)(26005)(1076003)(2616005)(36860700001)(47076005)(82740400003)(83380400001)(426003)(36756003)(478600001)(110136005)(7696005)(6666004)(54906003)(40480700001)(41300700001)(5660300002)(8676002)(8936002)(44832011)(316002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:16:08.2103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8812a772-e422-4b20-c734-08db82e2896c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

It has been no longer used since the commit 6eedb59c18a3 ("iommu/amd:
Remove amd_iommu_domain_get_pgtable").

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
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

