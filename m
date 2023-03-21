Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52DB79C7
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 09:24:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cww4ySW887vkwnqb0rvZq9kmvoun0uz66cqPUB4/LSgZ9ozUJL6Q96FSMZSaMAX+qm8CqYb/5YaTUM44jpz5Lza5PYmjGWscNbx1LjCF/gllRSITwAUYhVA192r0X1cyV5aiR+Ab4++LU7j8+LQcEl1XY6KFt0jml/iDFue7GlNpj2a7JBvcQWxEyPCvQUUxV3g92WIsN5Eg5qwk8i3vu4LvF1E1Y7boL5CjHSVY0FDxrBXlGIuegJhn21xTF5U5KdN+H8CpNPkRr7Rl7f3tKZyg1uDGQqD6OdNzL2LPeFvIG78KbJHvexesSvaxFRCqBrziOV5k3iDpX6Ypx/bsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8ZqdL253UuqVgjClJUzeHvSlN3NWaEpuO6Kfui0GTM=;
 b=gHCC++YJZ55bqUYhEAg9u11RanDDKpXgjZgdIB8QD9jReCKJzdHvUHGRvdONXHdyZYQb9khaivzkP20lbmycWfyB5aQ9ZRPutp6kCSbT2OIX6bpMvP6Dhh/lEDhrnX5jjphS9YsUSSNFmkYH4nHFEuaxbsv+lrS/GjdYHmPTjSvey02Tv9+HcLbVu0BYysw1IOk9LubKNz9tn2CslhOd+pEZ+wQieEnat5zCn/Wa2RCuGD7p7XghHn+hPIOu4Bjlzg71Hwx63lMkodoM/R3dQVNFoF9byEB0Wg/AcKOF/8wEn15p4xtFQfYw4PVOm2mk3RMFlu4VMXnvJG97RTGk9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8ZqdL253UuqVgjClJUzeHvSlN3NWaEpuO6Kfui0GTM=;
 b=XkBgbeJIK5iclLsuv0v3jRFXm5IhQFY+Pe1XSCxxIMs1gBD2ihpQ2yRYMEY7c3oLAy7nf4vgEJFeiEzVVncqh+mdndH8JrKnC0Ak6gClGnTU+vzc/k54I04th63EqmvLFFxWotk9mWmv6x8jSN/olUic1PoCY2uoGvpIr565s6E=
Received: from BN9PR03CA0569.namprd03.prod.outlook.com (2603:10b6:408:138::34)
 by MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 09:24:36 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::2d) by BN9PR03CA0569.outlook.office365.com
 (2603:10b6:408:138::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 09:24:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 09:24:35 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 04:24:33 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <aik@amd.com>,
	<baolu.lu@linux.intel.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 2/2] iommu/amd: Allocate IOMMU irqs using numa locality info
Date: Tue, 21 Mar 2023 09:23:48 +0000
Message-ID: <20230321092348.6127-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321092348.6127-1-vasant.hegde@amd.com>
References: <20230321092348.6127-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT055:EE_|MW5PR12MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0a2fa7-31d5-494b-9559-08db29ee1675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/ifL0JDzr399pyYTJxTGvDhZIfPWHjQq0tKtPk+LNZs5c6cOigV9tuX8AztoGF8Kwbmjvia2WGJFe3j/GOUK9TH7gGNpZUg3iX8iVpYrHNO+Ork9fIEp0Cvqu6Kg7RmVYYgJJMh9TRDM5EMmqjhEEXiN2RK4PPPXTIs5ktI/pvWJIdZEM02cEqbvdckzUqMgOPWBReLDE68xUzOMd0vxyuORvTuqlS6r4P7YAPFRL6UcTO/7qpkf8y+dIaHSpYt7AWrITYVsxVoF8GXr5lyhrepNfLUdITGoViQ/ZXY6CZIPTENzIXexA0XTrNBSw9by/8v4nKstC0K4fhTR4mz4Uf7MeCtC0Uaynt8iXWoHnlLXOrtJ6poTDWMrvMoD8/dOmC/7C5Q63EXfs8jwtabVDd8J4HhTlZtq+qS8f+901ZH9YhN21my4WQmRjQe3BFxQWPvSLDXNLWOYHR3GKwHZ6CLIndyE2o2wq6BicgBH3G23KaV46saMgbjuSu+rjv37VlyJvtXrdDjbRJHr4GBsJQKTN9aSMSj/dpwzuEpSx241M1AxcwWyeSVWr3jxHseehn4fyfe3I0o+G5L8QE5sbRiNi2GKheYfhc20z7cy9HZmuzCEXcgp49beFAGmvWnXnCSgdE7J6+E2xSTYmpZRBZenzvKhin3jyVj+uDd2kmmagTHdd94vFsQzPi3LuTfxSO9oK7bBprFczEPedtSJ/lFJoPHbsJvVapc7sbjlr50=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(41300700001)(40460700003)(5660300002)(8676002)(40480700001)(2906002)(44832011)(36860700001)(82740400003)(36756003)(86362001)(356005)(81166007)(6666004)(478600001)(316002)(70586007)(70206006)(7696005)(54906003)(4326008)(82310400005)(8936002)(1076003)(426003)(47076005)(26005)(83380400001)(110136005)(2616005)(336012)(186003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 09:24:35.8348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0a2fa7-31d5-494b-9559-08db29ee1675
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598

Use numa information to allocate irq resources and also to set
irq affinity. This optimizes the IOMMU interrupt handling.

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 19a46b9f7357..141eca29c951 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2383,6 +2383,7 @@ static int iommu_setup_intcapxt(struct amd_iommu *iommu)
 	struct irq_domain *domain;
 	struct irq_alloc_info info;
 	int irq, ret;
+	int node = dev_to_node(&iommu->dev->dev);
 
 	domain = iommu_get_irqdomain();
 	if (!domain)
@@ -2392,7 +2393,7 @@ static int iommu_setup_intcapxt(struct amd_iommu *iommu)
 	info.type = X86_IRQ_ALLOC_TYPE_AMDVI;
 	info.data = iommu;
 
-	irq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info);
+	irq = irq_domain_alloc_irqs(domain, 1, node, &info);
 	if (irq < 0) {
 		irq_domain_remove(domain);
 		return irq;
-- 
2.31.1

