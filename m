Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F81815A9
	for <iommu@lists.linux.dev>; Wed, 13 Jul 2022 05:32:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LROpw6YF+c6oXxcfldOLit3MAQEgNclOGPA8oFeVgJTfaxWjpM0JsRTnUHVYBS0i4B2CEdK/7q+V0GlTVgLtSUOV1iDptQEVLC/g4jfTanXrm6xCjFG4NZmCdg5mgjpeIu3kUD4UD6+ZcQwDd9Ladhp/vIG1e9j87NUceMpuAuO5B4yYeAMHJv2tlKVK5vqdbj1RmHHH0pdPaczLd4kjRqzYm4cdBbNmCznX4EQVSIwuPeWArdPP1TZgDf50GuaPcYmXeKMWtWGpFFnDzo6uJXmJ251TcyA17t9NllJfBi+q5jeXWUP11Byr/tv1pv2Y9z3IBqE7HddII3qKmRgiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ln+LFyZIInMyOHJgtyCmGiLSy9TgOjuFZTjpGXmjSJA=;
 b=aqreoq14eRNkZntCmza280fm3QMUlepImX4i1YAzuzGJ4YT/LF5VJUczatOO/A/0EJN55oYVyMiRN6vb8gxguWxO+CdwMHhvBxCf/m4V0Js5OrbrlzvDIkB4gYKG4NGaT8aH2zsvnt83RjSG4dRAg0BphkZsmO6BrH1On1Z/cT2ZVos1UXsMSOkap2cySoI+jAFrQvQbZyONDYEstmf1b1rZtQUcyyeykAy1rxp/Fc1gafJxDL7TZMJBGD2GX3nCJfMkaFxyMDqQapnFwm4ntVw+hFP9YAZhyvxmJH50kRUh7YfmpSgKp6zjSpGhJHvWWllmpafOJoGJb8gsWV7Gng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ln+LFyZIInMyOHJgtyCmGiLSy9TgOjuFZTjpGXmjSJA=;
 b=u7+l7eX3TWFYy2thG2hwqmVFan0xdx+DEgOuHTSCKIHeusXjZSLDz+GPddRMhWjvmbb2Hm2jeTdzq6uincMGX8yR1L7bF4FV7QO3N1QqyWd194zJK8sZw5OFi1hAdCa272DMyr0MrX9EjAUe7iqHz62Dc3wdHK0AI4ni4ubI99Q=
Received: from BN0PR08CA0013.namprd08.prod.outlook.com (2603:10b6:408:142::21)
 by BN7PR12MB2692.namprd12.prod.outlook.com (2603:10b6:408:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Wed, 13 Jul
 2022 05:32:54 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::a0) by BN0PR08CA0013.outlook.office365.com
 (2603:10b6:408:142::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Wed, 13 Jul 2022 05:32:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 05:32:54 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 13 Jul
 2022 00:32:51 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 5/6] iommu/amd: Add support for using AMD IOMMU v2 page table for DMA-API
Date: Wed, 13 Jul 2022 11:00:33 +0530
Message-ID: <20220713053034.12061-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713053034.12061-1-vasant.hegde@amd.com>
References: <20220713053034.12061-1-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 61240e33-3ece-4bb8-46ee-08da649122e8
X-MS-TrafficTypeDiagnostic: BN7PR12MB2692:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r0/jSFo9W3k/T+R3sgo95krgMXQ7pMyIAcZOGkRGfMGJYBlTb/zcSSe7K1gXCcmzJd8yZM1WZUn984EsjTOo9KhVh7axoyv3lOIBWAd+hny9DqfZMe58g4bPI7k+5qDGNPkVSFhw0VR+BfNFbXpkpQSDNC4eqSIzfIMyphha5RxOdNio8B7H3wGWCQIMugu+TKPsfMlHg2rC7hCuewrjMnjgKTofpV+whiafG13TRQbUjN8cTpxsa5Sn93xxz48XWLOtjPrgyESwNHQcR/mfNbGUwNkXew0ltDO1+yRDknR+uZ9WUOhPhyUbLLu6f+9boa7+0ThfGpHG0sOpDajq2+dvCzwkDPmXcjgHjxiwUxLw4PpCoMHmPIB/Ifwvbp8V26YYOox/XSAsWXTflTZoUL7uN/dwRKnf6MzhPqM912l0+slN7sffnZ0irKzja+VqVihIopxEWK2AFzj00+jD8DfOUI7l1lDniOPLuDQQSatkSK+KOmluqUCgdIvymEw0CuasFU86dghNiEUCjcjmHD1X5Tj18blsZnq1ID5kz4JieaW7nmNoFT0TNoi9htqjiVl11CBE1LqkRax9d5KkG53HJyRVucv8qwqxtqGjMPEzd4ruV5mvMG92rzJdqdUMapMR+uJxF+7CcVxWbshrSm0T6MCB8MJ1WjXzorDiG3US2Rj4wIf/saT6ifBJz9qWhLGNVCNX+editnmWdwAo0NMv450xKF2K4p6PCmUnaUJjUJdRCO8wekF49934DRsftgCcU7614ysZQ8AkvPvDT+02gmpQsfNSrL/3vMu3+8barMgmK7eFOD3Z/PYnaDSpLbBfkCjfWhD2NziAsElSypFL9EH0WLYcwVIHpAc3B2s=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(346002)(36840700001)(46966006)(40470700004)(83380400001)(426003)(70206006)(70586007)(1076003)(478600001)(336012)(41300700001)(8936002)(2616005)(2906002)(47076005)(16526019)(356005)(40460700003)(36756003)(36860700001)(316002)(186003)(6666004)(5660300002)(4326008)(54906003)(110136005)(44832011)(26005)(8676002)(81166007)(82310400005)(40480700001)(86362001)(82740400003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 05:32:54.4404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61240e33-3ece-4bb8-46ee-08da649122e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2692

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Introduce init function for setting up DMA domain for DMA-API with
the IOMMU v2 page table.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
Changes in v2:
  - Added support to change supported page sizes dynamically based on domain type.

 drivers/iommu/amd/iommu.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2e67e6eecc31..372621dfc526 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1642,6 +1642,10 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;
 
+	/* Override supported page sizes */
+	if (domain->flags & PD_GIOV_MASK)
+		domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
+
 	/* Update device table */
 	set_dte_entry(iommu, dev_data->devid, domain,
 		      ats, dev_data->iommu_v2);
@@ -2021,6 +2025,24 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 	return 0;
 }
 
+static int protection_domain_init_v2(struct protection_domain *domain)
+{
+	spin_lock_init(&domain->lock);
+	domain->id = domain_id_alloc();
+	if (!domain->id)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&domain->dev_list);
+
+	domain->flags |= PD_GIOV_MASK;
+
+	if (domain_enable_v2(domain, 1)) {
+		domain_id_free(domain->id);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static struct protection_domain *protection_domain_alloc(unsigned int type)
 {
 	struct io_pgtable_ops *pgtbl_ops;
@@ -2048,6 +2070,9 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	case AMD_IOMMU_V1:
 		ret = protection_domain_init_v1(domain, mode);
 		break;
+	case AMD_IOMMU_V2:
+		ret = protection_domain_init_v2(domain);
+		break;
 	default:
 		ret = -EINVAL;
 	}
-- 
2.31.1

