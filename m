Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCCEB671
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 07:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563531; cv=fail; b=SoJOmgmo/v+I+eXNUNZ1OeBYwFZQNxmkW4hpphjYkDPDy+5pXUCbeSyoEOcqqfm3ZqRtUA+JlFKxLJ/G2O8G3Oirq5Td+KoMI0QM1RVxRk3OEEnXzbZvhPdYjGD9zBxYiwi+EUKFURdcHcdP722lqwOo4YhC9lAYAysj/HTU/9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563531; c=relaxed/simple;
	bh=kOJEwUJ+RrcV7KwKDc5nao3EqLtkUq8fn4/OHhIuYX4=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=K5AcNTr1UT++YQmOOURXCC6xXNGQdZ8du0k7s1Z6dRcGNcSYxIRetjK+B+wrb8rU293niyW5/z4gytcvO1vtWy6Mqt4VoPybv0YjcmETKPwHuQI6HsCCqW7Ys/InLZGrP+pUajgQ6pagPSve3Dw3MvijTCebpwPl7nSQ60nT100=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L4ogVy4a; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L4ogVy4a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKtIf4Y678OJlaPdgA6fKtwfjlw5TDqoqOJ9jhXKX+EC/6DhzRPTjPJDn5GVY+gUuT8TvlUEObsD2huJEb+O/fn2ZcpOBuwntF5sNSrJsU7pGII8Wves4OoMllWzoDbF1i/CauYqZTxMDZY/Qd+z7SRXb6xGg8ygiSHQIn0ChYsrn+6BKj8HhVbTHJC2kyTSxs7SNMDYCSZMSEP3v9kmOmvBb78qV8QN7bGkiF9glJge199Oi0W0OeQjCEamm9l/C6PG4PixMcsMMW34MZO2M7AvujCUvatDJTZSkznX7aOf/GGAVpRPGOdW7MQyf1Dcl5PLPwnRSUP+cU+r+6zmpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dYPc/XvShpBmg/OaPopvrZ4R9MwQ5MzTxc45q2S1v4=;
 b=i3pUQy2gmPqq+bsXgvx7T3F0aEzbnuKTvkzfCpnFAVC1/latpFeAO5M3H9+tFVZWzU7VIXM7RhzkNwqOlPMM7/uvfc7rFENAEebTC47EfoXlr9mejzFVfBelusV0Tlc4yZ90hsOiNr1O8cOax/5+VkXetpxTlNTgrYbUvWwInpG1CLsz8vyPNEgRW+hFGigpzX8NIq3qxqAhezIsJoveUH/x5WGbhl80ER1eTQnAqej6Bhl+mqvqzkxba0yGIpGUyACuOyeHYyiD+7FAc1f91LacIMVAuSw1YWADmZJCEsyQ45vDf1eKRIzHyj8mg3+uLWAfoR7UY9nzo5ASIsWtTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dYPc/XvShpBmg/OaPopvrZ4R9MwQ5MzTxc45q2S1v4=;
 b=L4ogVy4a0z3S/RVD4/5sy8h9IMNaq7By3CezeSWMcaVy6fPZzleoHUk1EfJiATv/vBG5cuo0GqsvOOuhzY5V6taX/bFaAhvFvHBA5j4W3Zk1xha4hiuBQt3S+15d537H9OOu8USwDP1J43kixDTtxclMQmeAF6ZWLh9dXEXRxYM=
Received: from CH2PR14CA0018.namprd14.prod.outlook.com (2603:10b6:610:60::28)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 07:38:47 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::32) by CH2PR14CA0018.outlook.office365.com
 (2603:10b6:610:60::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 07:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:38:47 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:38:44 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 11/14] iommu/amd: Add GCR3 [un]initialization function
Date: Thu, 18 Jan 2024 07:33:36 +0000
Message-ID: <20240118073339.6978-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118073339.6978-1-vasant.hegde@amd.com>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|MN2PR12MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a184276-2d5a-4992-a62e-08dc17f881b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	puUePTjGoRiTuoeMQnysAzjBuEDP5fId33i2klY7oBMEgTM/1jLL5+hEFesQDghzByJ2DUy11ylpXq1bRGLdagFPFqsQurI1n5+KD2l0yX6Bu4iJbBwxYNd3Q0HuSqLOdGCbtPHkeGvKsS8pzrAWHyCedeJLd2sf8s3+hXCTtdtoAzgchMwnrJC4kSDBvG0zgQ9t5LXGEXiV2+TIvfJCNnoEjru4f0SU+QrHggRK5t+lur2wKNOjSvjwlnOKsyFYDWhMchMWqrTkHHun4nJMUZ1FWTSqeF+TbkHaXF8TxCrjCCXx00hdNesM0bQ32cmZo3J5TPmzzxKXENfqVtERNSQLkh42Slg8QE3xARH2iPTHG/HKFvm4+d1zX15zdMAF/r2vFnew9EtQtdopIjUxHtVoEy17TVkGJZ71h9ChfyfoTiFd8NEx8lYMytL1mCAOsk7fwxbKB0uaAWrFENZH/+isSFEkkIWW/n+kdaMTbSd0m91lKHz901W52AtA52oBYGEG9MyDF8ZS8I69amxLrNWCbDF3GPfgiBW3J/lZ0AwrzFeIpbM7KV3kdRV++TIuuMTtdx7c1to2OcFBWPEc2ZdQQnRLfoMb+vRLtnsDRTUPOTUCPhms4c04LGaAirK6Rh0jEY4BnaOEmHZa+q5gfK21OYSp4xd3xwEVuJu7EdFlQi4ZVRCJHmLyigsVeQiJiOLW2oyKO6qs7klWqE5SpQYp977bY2Oe3PkXiNJtfiTKoQl+12Au2vDk/MaOO8A8lUiwxDBVAJTmjmohO2OKtQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(36756003)(26005)(16526019)(86362001)(356005)(81166007)(478600001)(40460700003)(2616005)(316002)(41300700001)(336012)(426003)(40480700001)(2906002)(1076003)(6666004)(7696005)(70206006)(5660300002)(70586007)(54906003)(83380400001)(110136005)(82740400003)(47076005)(66899024)(8676002)(4326008)(8936002)(36860700001)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:38:47.4480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a184276-2d5a-4992-a62e-08dc17f881b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

These functions are used in PASID to device bind path. In this path
it checks whether device GCR3 table is setup or not. If not it will
setup GCR3 table.

Also in attach device path change default GCR3 table to use MAX
supported PASIDs. Ideally it should use 1 level PASID table as its
using PASID zero only. But we don't have support to extend PASID table
yet. We will fix this later.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  3 ++
 drivers/iommu/amd/iommu.c     | 52 +++++++++++++++++++++++++++++++++--
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index d5e6315ef9dd..2d099c54b941 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -44,7 +44,10 @@ extern int amd_iommu_guest_ir;
 extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 
+/* SVA/PASID */
 bool amd_iommu_pasid_supported(void);
+int amd_iommu_gcr3_init(struct iommu_dev_data *dev_data, ioasid_t pasids);
+void amd_iommu_gcr3_uninit(struct iommu_dev_data *dev_data);
 
 /* IOPF */
 int amd_iommu_iopf_init(struct amd_iommu *iommu);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 36a5458a7946..6f5900333946 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -93,6 +93,11 @@ static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
 	return (pdom && (pdom->pd_mode == PD_MODE_V2));
 }
 
+static inline bool pdom_is_in_pt_mode(struct protection_domain *pdom)
+{
+	return (pdom->domain.type == IOMMU_DOMAIN_IDENTITY);
+}
+
 /*
  * Allocate per device domain ID when using V2 page table
  */
@@ -1837,6 +1842,46 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 	return ret;
 }
 
+int amd_iommu_gcr3_init(struct iommu_dev_data *dev_data, ioasid_t pasids)
+{
+	struct protection_domain *pdom = dev_data->domain;
+	int ret = 0;
+
+	lockdep_assert_held(&dev_data->lock);
+
+	/*
+	 * We cannot support PASID w/ existing v1 page table in the same domain
+	 * since it will be nested. However, existing domain w/ v2 page table
+	 * can be used for PASID.
+	 */
+	if (!pdom_is_v2_pgtbl_mode(pdom) && !pdom_is_in_pt_mode(pdom))
+		return -EOPNOTSUPP;
+
+	/* Allocate GCR3 table */
+	if (pdom_is_in_pt_mode(pdom) && dev_data->gcr3_info.gcr3_tbl == NULL) {
+		ret = setup_gcr3_table(&dev_data->gcr3_info,
+				       dev_to_node(dev_data->dev), pasids);
+
+		/* Update device table */
+		amd_iommu_dev_update_dte(dev_data, true);
+	}
+
+	return ret;
+}
+
+void amd_iommu_gcr3_uninit(struct iommu_dev_data *dev_data)
+{
+	lockdep_assert_held(&dev_data->lock);
+
+	/* Free GCR3 table */
+	if (pdom_is_in_pt_mode(dev_data->domain)) {
+		free_gcr3_table(&dev_data->gcr3_info);
+
+		/* Update device table */
+		amd_iommu_dev_update_dte(dev_data, true);
+	}
+}
+
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data)
 {
@@ -1986,9 +2031,12 @@ static int do_attach(struct iommu_dev_data *dev_data,
 
 	/* Init GCR3 table and update device table */
 	if (domain->pd_mode == PD_MODE_V2) {
-		/* By default, setup GCR3 table to support single PASID */
+		/*
+		 * By default, setup GCR3 table to support MAX PASIDs
+		 * supported by the IOMMU HW.
+		 */
 		ret = setup_gcr3_table(&dev_data->gcr3_info,
-				       dev_to_node(dev_data->dev), 1);
+				       dev_to_node(dev_data->dev), -1);
 		if (ret)
 			return ret;
 
-- 
2.31.1

