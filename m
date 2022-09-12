Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF8A7F
	for <iommu@lists.linux.dev>; Mon, 12 Sep 2022 06:34:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNRuEHxi3TpbWkPkhoW6XB6UepZhrOZl+2xiTPD5CVQFhsT9wAeLx6h0YeK5jyTmboQPBp5hOsC5+g2a0wsaLrcVpsGgoHwHq4oSQO6IakhN4JVlvlSHGwuaxkFUgbJNoOCFBe9ZkjUgy6gM/D9CCQilj+PVuZObtE+T97NHXaSib9QdRBYi5h3HMmTbgwNOtUQ1eQO6eILTNnPFtNEVbP+tjhjiOK9I+D3s11KXC04nNNX3q0ZGOHjByRNt8woqG3mSwxLlBNf1188WU/mET6IxHjigQMaWqbo+oCnJ7Xcj+3fbq5O1rgVd+++Z2XqsSTLLgHN1hA9481ngdg9FRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fOAZfOCVwwx5fX51Ds4eQjJR4POnCLmqoSIQ4KEChU=;
 b=bFJVSmyUlyb964nwsmmYcY0xMppCMsa9qafBoVS1YoQVIrdqsduMZZ84RCGStzJpVZEujBlFBpkm1bhbtvSqeCk1B8kcrKQC8Pv3Je3WBS3smr7EFryX56efP18SVM0TUMTeJACc4963S2lW9GFabrBNNjLqb8VBhEd4I2vXgicWXWKbdS87Va20jlLKl1qQ/LOptnbXXJMCXSKdEOwwgdpKHAJi9i6ebbsvKw2TCzi9FKJ9lKZJwr56tYTePKfu7uH2GOauN+AzQAd+s6+fV9Suplm+Y99Q7piOsPOjFVWK6mvaWBVNVjHec5Y3AColcSDwqIlrcu/lg/k6JLyoUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fOAZfOCVwwx5fX51Ds4eQjJR4POnCLmqoSIQ4KEChU=;
 b=1RNNgh1t/PBmCV430uvoSuEGggYhTi9V+7LJTABXlYUN/GR8uGxfYLdBLjVIiljrrCiOC3tNjRG/MhIk7kDi0w2dRBFqNlsRPd1Lz+1H48PrV2A1QfwL2T0QI+dQMNqKIoBrGWdVHjsWBczFq0Tuwrva1RUeXUSIaqDDJnsSB/s=
Received: from MW4PR04CA0302.namprd04.prod.outlook.com (2603:10b6:303:82::7)
 by PH7PR12MB6694.namprd12.prod.outlook.com (2603:10b6:510:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 06:33:57 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::ec) by MW4PR04CA0302.outlook.office365.com
 (2603:10b6:303:82::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Mon, 12 Sep 2022 06:33:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Mon, 12 Sep 2022 06:33:56 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 01:33:54 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <robin.murphy@arm.com>, <suravee.suthikulpanit@amd.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 3/5] iommu/amd: Free domain ID after domain_flush_pages
Date: Mon, 12 Sep 2022 06:32:46 +0000
Message-ID: <20220912063248.7909-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220912063248.7909-1-vasant.hegde@amd.com>
References: <20220912063248.7909-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT038:EE_|PH7PR12MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: cab2ca74-7c0d-44ad-973b-08da9488c521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CJ9JvSFgjocnZcBakqSl47FkVrse3XWgifFso+6ni5Om3D/jA7Dgsw1UKV3ND3d2l8nH5KNGelGd0CoNn1Uht6gV+j338vW2uef7dNWQ2iTpAkZab9470tBUZfnBbu045srlItWo4sYJJyLB8gNbrJNU8fLNaHVXgFIeYKiiGJB5aZQVU0Emi5qDnr471ZlhM8C2d3y6D1H7QymPEadNVMJnT2BglwTBA+tD2UlvwA8CAyGWDSh7Y1jWd4pw05+NWqUTHTH1KN+tMSSM0RqUtkarV9lljcfVcFZZ1ydWFp7OiridgRbVgaiQ7kynAeLwGM9UGXokSA84CE+A6vWXhaB59o0ceX0AVnYNXT31D4Bx7GsT7kI3j7pDQ/077IJ/n9kzTmjwz5nsdJjDghDdd2dIUMIXJVbGiU3gzFTvK6ngpUuJbmsR2Q07r1DZxFLayyPIZInk7/+y0T+Q1q4ZLBmYwsApT1jZEXpZy8YgmnezMnWQzHlXCZLMbMKN7tBSflWAEGuJXF9VfUMvR1S7FJm83Qfm8RWHMVQMaoZMMcUiR27+8mL7EQpWMvyl/U3xxsceb11CglPASkwgsy8+sS/gcx7cweoMl6d/P+P+J42UQz0xGuED4la8976wTAHOiwRa09dGUPEdnsslHzPmxwarkxRU+85iUpzj9fFcQWEVWbUM4dN8KUZOpll0PMgpnDFh+cKlpY54MO3RpzPJJaruGY4EhKuDhZovTKZzYLA+AbYC+jkx++DHy+XNS8rTNniannNqHfZZnN/JoTE7xH23IKQGIrXnKuDmOndOm+vjWEhrz7Qdy2qg/GaJM9Yd
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(346002)(39860400002)(40470700004)(46966006)(36840700001)(110136005)(316002)(54906003)(478600001)(4326008)(8676002)(6666004)(4744005)(5660300002)(44832011)(2906002)(26005)(7696005)(426003)(2616005)(47076005)(83380400001)(336012)(16526019)(70586007)(36756003)(186003)(1076003)(70206006)(40480700001)(82310400005)(81166007)(356005)(36860700001)(8936002)(41300700001)(40460700003)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 06:33:56.8091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cab2ca74-7c0d-44ad-973b-08da9488c521
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6694

free_io_pgtable_ops() path uses domain ID to flush pages. Hence
free domain ID after flushing everything.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f49980956220..4509c9c4ee20 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2006,9 +2006,6 @@ static void protection_domain_free(struct protection_domain *domain)
 	if (!domain)
 		return;
 
-	if (domain->id)
-		domain_id_free(domain->id);
-
 	spin_lock_irqsave(&domain->lock, flags);
 
 	if (domain->iop.pgtbl_cfg.tlb)
@@ -2016,6 +2013,9 @@ static void protection_domain_free(struct protection_domain *domain)
 
 	spin_unlock_irqrestore(&domain->lock, flags);
 
+	if (domain->id)
+		domain_id_free(domain->id);
+
 	kfree(domain);
 }
 
-- 
2.31.1

