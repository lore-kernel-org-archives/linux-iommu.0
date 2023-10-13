Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0019511CBC
	for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TEZ4jKt8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PP5zLwNzHA68BAr9V4dEc1Bl+lILYDY8oqXwQvMfMfNdE32TuO4xqQ/Y3JtU8IlrHEC5dgJ3pRh+NDZvT1dBOYiKlp1LQOk1i5Fg9YaYAi4MYtPlQPRcXXAPCSFsceF8exMSH9ubrgAisHAZ9Bf1reyVktiH0nSrooPFbKodDtaWiZ3tbo492igZDMnjRmCuKjW2FTjFsxB0GcevjvKqvB/vWCijmk7XQuRGZkq5Q8ad2xUdmYp+1PpFdwKzt1fknNokDZqIKL+6wXfko4mtPE1zS8DLBS54gbkv44PGZ+fiycQXOZJsZ6Wuzpz9cZ6yprHbfKoZ0uYs2DJ+F1qCyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEMnCzmBkgpiNfDO9Q8TVRDv1g3iUD8rf5SZGOg5ZWM=;
 b=dLsb8uu3x91Oivj8FysiRAkOiAfIIOFZ6tfVBKumfLJuQJm26EAbu5J5yDYquW6alKAI6nuhCRSEjLiDGDD4iO0cFz6iwGEPInWbTb8ZnKg4LpAMhiLkZT8xyieydwwvmKlnGf5ELzODxGuZLp2q99IfIqBSTQmm51FObjTy0X2vurbkPrJ+9LGH6WrM/sSReV2mqcUEN7e+H8jtRQH/pwPjlwgLsTYbGRHaQ9tYDwY8R4S+MWrEcatyxw1I0wr7+sd919gZgk6Jk2VKIp/ntVHZPGZlE1wtxP5iWDkO/3YCmmyHZAdMhv0L4abbUaf4WNkI7cJ0bWx/3JmDrk+5Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEMnCzmBkgpiNfDO9Q8TVRDv1g3iUD8rf5SZGOg5ZWM=;
 b=TEZ4jKt8SLqqiEGgI3/+kVbQtKiY60Lj125KSHdRISc+dBA/fPVL82qL4MPcoFzJlMhcV05mTAvfq1y6fqoJI0JAhK8UuHvqFCktz4ayDp3XM+IqbEKQlzUdwY+lmiZLiy63a6HWj+uRUzHIgkE0u/EH3zRsa2Jv4ILmsDKiFnU=
Received: from BL0PR01CA0034.prod.exchangelabs.com (2603:10b6:208:71::47) by
 SN7PR12MB8104.namprd12.prod.outlook.com (2603:10b6:806:35a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 13 Oct
 2023 15:19:00 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:71:cafe::d3) by BL0PR01CA0034.outlook.office365.com
 (2603:10b6:208:71::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Fri, 13 Oct 2023 15:19:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 15:19:00 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 10:18:57 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 05/13] iommu/amd: Use protection_domain.flags to check page table mode
Date: Fri, 13 Oct 2023 15:16:44 +0000
Message-ID: <20231013151652.6008-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013151652.6008-1-vasant.hegde@amd.com>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|SN7PR12MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a23111-846d-48b0-6cde-08dbcbffba18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yx1jK6C0XLq+R+q0Djn+y+cA3kETXglsxK3fnqBPlPE3Z9kNh9Vx1SWx6xsmjWse/KZyVgbha9cCU/OXfQc9m09kqbXpbUKn3PAD5cZSQXjWEbheU1SPB8lxXpkmL0WkDfm2CZkhCKJath4+qyU7m4GAaCuu7JGS90+MWZ8kEO//RvT0QAgyFcDwsTkmM5nJkztJSnvx0GoC1t8fcTwpsw3OGSFKiAMNcnr6E7B8cIlS1qhNHuTsQQyBYY7M2ynUECAMU/bCZ/ib5Bcn96sVxHUjams5kF3W5UQZH3S0NCE3NjezgkPpNJaw0UYmJSuJD4xOt0wzivpxbhTtU+0NyDoud4n35rMUKAjq1UDld6syJxAjB0p0yO4KBY/snw70WN6+fLfTyVf9oBCcHuKwFEcxxUfzm0M+82xA4thPI/EWVKg+KuKs6t/llFHMDYn75neJPZHpYAi3grE3/1uzjqc14EBYs8pYSDKz1XkYl7Q5TkpuhdGFeM5ajzvPnsLhUzLd9N3NbYWsc4NJ7W3XzEzq4EYu3l7/Ie/dC2WJHphxOhM7EpTG5fhQFIaotJl2E0HfoTQtY+0Vkr2BmNvuaSjSpunhuBC+V7Ly1dtWfw6PkRGDaEGGYlNDdMao/IrchOr+GSqmCsvwx+UxxQi1RWh98Ht0is0Qi3jseaqRZn9+OUZnaznY6ruwqzPH5b8jqkXGAzEQcccC9KSFjU2wAmwOKI5AVNOs7DE2CEl+BBhiaQD8voOiKQPwNOrkWauu5xghFwLd/VjOPnKRAyWGFg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(1800799009)(82310400011)(64100799003)(186009)(451199024)(36840700001)(46966006)(40470700004)(356005)(5660300002)(8936002)(47076005)(7696005)(2906002)(41300700001)(54906003)(70586007)(316002)(82740400003)(110136005)(44832011)(70206006)(2616005)(1076003)(478600001)(4326008)(8676002)(86362001)(36756003)(26005)(6666004)(16526019)(40460700003)(40480700001)(83380400001)(81166007)(336012)(426003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:19:00.1850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a23111-846d-48b0-6cde-08dbcbffba18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8104

Page table mode (v1, v2 or pt) is per domain property. Recently we have
enhanced protection_domain.pd_mode to track per domain page table mode.
Use that variable to check the page table mode instead of global
'amd_iommu_pgtable' in {map/unmap}_pages path.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ff52beb83b74..85d73555c1f9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2336,7 +2336,7 @@ static int amd_iommu_map_pages(struct iommu_domain *dom, unsigned long iova,
 	int prot = 0;
 	int ret = -EINVAL;
 
-	if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
+	if ((domain->pd_mode == PD_MODE_V1) &&
 	    (domain->iop.mode == PAGE_MODE_NONE))
 		return -EINVAL;
 
@@ -2382,7 +2382,7 @@ static size_t amd_iommu_unmap_pages(struct iommu_domain *dom, unsigned long iova
 	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
 	size_t r;
 
-	if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
+	if ((domain->pd_mode == PD_MODE_V1) &&
 	    (domain->iop.mode == PAGE_MODE_NONE))
 		return 0;
 
-- 
2.31.1

