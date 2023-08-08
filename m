Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F9BDDBF
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 10:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6wePgbx0EI7EF+wgdJjcPA3t0gaCDaB67uc2aeshAurOll/ziKZrJ8HHb+jKhLLY1PM9k3fIkM2/qkFF6rwJdVQAmrTqqeT4RZzxnWp17RAsnSWXQjKsiKW7XabN14N5aL0ok/ZJK6OeEiEBW58wsa255q9qgKE+G+o7eNOFnUSj+FfV+MrwfIKpUiyL4w8ayUzy83S0tppC7rzvqH6DUJwEvxV6zNdcwJTn2UkFfXgPr/+ZzJZJI9a6FyUCNaa7ZjI3DnzFA1OaUBfvhVWtgULhh9ghJA2H14Q0QRksXHW8ZgaGc/9ohsCUo43R8wjrHz3l4Z+Y3gKNoxE6SzavQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9a2RaAO2WCEf+vEocBf3jLGKMzJivkLnebnQCem7/k=;
 b=T2/JoFkS4VpLQeqERVi4PL7DYyUy9yF8uMdUUhPDzWE0FWPYbVZQXtqsec+/EVODrCuhGl2I0vdjlNbWd+YyRCalVoe6068OiQZmU7SJ1Sgis/8qENQbtv08b8UNl51946GQUGNrXgAU+XfZ5/mntFaUdgJOaW9s5Et04qgJ1ewpNm28Sc0kZGpxri8kWuJReZCVSRxM+ml/1ufxHAVotXJ/M1eT6KgIIpUfnOtBqSn+bNUAlejA/HWn4Zfut8yzDRXd0olCdQj0DKgVgS7qfFz6tLWfCEnRYTvxsNOQ2KpE5V3BzKjhTkzqalnTJlZ/JZp4J7Lubx8EkfPqL3BV/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9a2RaAO2WCEf+vEocBf3jLGKMzJivkLnebnQCem7/k=;
 b=wuxTtwlZsBF8VX/GcDt5O6xvALzhMYH6GURJrfbpFJvxbf3cQnZ0ifJm+zA2SfM8FH39u8yY+5Jv08MyxxrgpjvJj1Xhju39BZuOEDawJ2ujZMICvwB8FxLQi544t6C0JporOqL4k1CKrnMiu3/B8xpH0O/g1HFmqcG4MYelkaI=
Received: from DM6PR02CA0073.namprd02.prod.outlook.com (2603:10b6:5:1f4::14)
 by CH3PR12MB9172.namprd12.prod.outlook.com (2603:10b6:610:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 10:04:36 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::c8) by DM6PR02CA0073.outlook.office365.com
 (2603:10b6:5:1f4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 10:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 10:04:36 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 05:04:30 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 02/11] iommu/amd: Introduce struct protection_domain.pd_mode
Date: Tue, 8 Aug 2023 10:02:23 +0000
Message-ID: <20230808100232.5977-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808100232.5977-1-vasant.hegde@amd.com>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|CH3PR12MB9172:EE_
X-MS-Office365-Filtering-Correlation-Id: fd6602ea-2ac3-4ae7-bcb0-08db97f6df07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NsS7Y4f/MusIQikB2bS+jh02wwW4QgohbSVc0zWBeX7mx7RJrMywaa/nm55IO3yDwvOGeiYmYoLao6QBpokG87zzwJGeORKOYMLdqJOfPcFAKYOJgfaGgcqToMlYvegAwDKgwTf42/lMyM6D8SJyYl6YvAITC69Xzb5JOKpPTTYvoiYv+WIpEZtBOva4XwZaczMGle2+hJvSZ3QRbziL0BJTDxL3eScBZ1ysxs7m4KQouAmEgC++SxAruHG0sgI8F9LJQV+69uXhLROnbWzZ11tvW7fv/2GHdnAvt0Nn/OjVOnpqq1uF9VmhgfZ24JdbzbU4lNwgjFzBKlh2CHHGmxPm/esgZJh2Ra6Sltbk5ybdfBDNRbJ/Pd1rPSx8OlYXaIW3sGUYIZxPmCJs9BJ+AFRxlOzFnr5059EweEfE3VBQztioOtXx4kx8HXfvEJO9q+QlOZKlgumiIWzrr/xM9iTt/KF+Z4ILt2h4rz5t5iL+5JmS8dUG02vujnf1hSz4ZAw4vujXwIfilRB89aNUtIau/3hAbLkp8mX2whja0s+1tVvul/LRgRgIhUVJmUTMBLmVmJyCm/RvEd1S2r44xBb+DoUl5VaIDyUGnTTB2Uvyr5U9nx9fz8+ZDxk8LXko+IjbE6ma799VvMS8gGMdyEMRJmxP6Dw1RoMYCvplHooPH1nt8g5ZHPYgApz1xE/pH20LlxiAlY7HGOI1C+hhWXBW3S1v0iYjVZIMX1q/z978RtCiV8ohpKomkb3VTh74b32NajH/bSTD6/6oD1WLSw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(82310400008)(451199021)(1800799003)(186006)(40470700004)(36840700001)(46966006)(426003)(44832011)(8676002)(8936002)(5660300002)(4326008)(41300700001)(316002)(47076005)(40480700001)(86362001)(36860700001)(2906002)(40460700003)(6666004)(7696005)(2616005)(1076003)(26005)(336012)(16526019)(70586007)(70206006)(356005)(478600001)(81166007)(36756003)(110136005)(82740400003)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:04:36.2007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6602ea-2ac3-4ae7-bcb0-08db97f6df07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9172

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

This enum variable is used to track the type of page table used by the
protection domain. It will replace the protection_domain.flags in
subsequent series.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 7 +++++++
 drivers/iommu/amd/iommu.c           | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 0d339e022572..5e89032b3dee 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -555,6 +555,12 @@ struct amd_io_pgtable {
 	u64			*pgd;		/* v2 pgtable pgd pointer */
 };
 
+enum protection_domain_mode {
+	PD_MODE_PT = 0,
+	PD_MODE_V1,
+	PD_MODE_V2,
+};
+
 /*
  * This structure contains generic data for  IOMMU protection domains
  * independent of their use.
@@ -570,6 +576,7 @@ struct protection_domain {
 	int nid;		/* Node ID */
 	u64 *gcr3_tbl;		/* Guest CR3 table */
 	unsigned long flags;	/* flags to find out type of domain */
+	enum protection_domain_mode pd_mode; /* Track page table type */
 	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
 };
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 77b913211c35..28b2e93926b5 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2119,6 +2119,7 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 			return -ENOMEM;
 	}
 
+	domain->pd_mode = PD_MODE_V1;
 	amd_iommu_domain_set_pgtable(domain, pt_root, mode);
 
 	return 0;
@@ -2127,6 +2128,7 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 static int protection_domain_init_v2(struct protection_domain *domain)
 {
 	domain->flags |= PD_GIOV_MASK;
+	domain->pd_mode = PD_MODE_V2;
 
 	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
 
@@ -2158,6 +2160,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	switch (type) {
 	/* No need to allocate io pgtable ops in passthrough mode */
 	case IOMMU_DOMAIN_IDENTITY:
+		domain->pd_mode = PD_MODE_PT;
 		return domain;
 	case IOMMU_DOMAIN_DMA:
 	case IOMMU_DOMAIN_DMA_FQ:
-- 
2.31.1

