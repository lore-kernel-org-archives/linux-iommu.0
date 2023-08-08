Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45A6DDBF
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 10:08:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QH/9sXLaPf7/1wH3sJXlda1t9/aExqo6OqOTePVElJtMwcGFr/p00Htc58VZTNzPkmnyp7uUlV+JNRAVsnVDjbqT7CsbAGzbd2ey8Hu3s3vDNv6ES+JF7L9yukbPMSE8d9D/NmBtpOWum2JmStjgbJL/n966Iph3z9wtRMmOCzs7deB2wx6eXxsUhHP/oHXndTcgMIBgLI7ih5qi20D/FSAu9YhIuQZtXFXqe2nKeI7aXA6HfjVutEy3aHEP8N5gKGeq4WINrWf7fzGOI3xpBwhcXAWcIr0j/XlN3asebzd2JQFd6HJ9yT7wSC1eRP8oX4zEWz22/SK8VMHJChUT/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5HDGB2NeL8IoAYlc64/5aFDEl6M5CgkTRcn1ZJJVQI=;
 b=Y7A5ScCBKdudzi1EqQstS/2jMUyrsvL8GcqH27haWSL/Z8pHop0+b33KC5+odmIqQ4em1RYohJtqwEXDrV6k9IKIVBr3AZs7Yw4dvoueSrTSnLCs4SEmZjprw4uYJ0M3IezqfJrVSnpK0NGzWK82YGMlZZDWXSwolXiuN4A8ckuLLARTAYh78w0dTK+yQ5AwAWVZct1m5Trufxkipg0jkpo2Um4nw5LbmsBzL1ClbkslawNZkVYF6F1+62kLqHKuTo+SHfCQoAgaHb1yDiQ8PDiEow+QE/ABRfrIm3q0veyNyN99fMBGEDwTlNAjyCYbCHFqLJrwHquPbjuFKXCeZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5HDGB2NeL8IoAYlc64/5aFDEl6M5CgkTRcn1ZJJVQI=;
 b=Tv3aFBBBWNTUF+jVc7tBiSL1s+DZRig85SwOMTizWZPkwZkHu92AmEb4cDV/CEDvdMfMI7RsdOwJ28Ti3IW8gfrbywipaeTOB2E8g0dDRsd7jHI4X9vGl4+mTU6UxETBRJeh0d5ljGrvJdPLO1grgZkyeF60C68aJCiKxa2qqVI=
Received: from SA1P222CA0036.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::21)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 10:08:26 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::49) by SA1P222CA0036.outlook.office365.com
 (2603:10b6:806:2d0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 10:08:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 10:08:25 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 05:08:23 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 09/11] iommu/amd: Introduce helper functions for AMD IOMMU v2 driver
Date: Tue, 8 Aug 2023 10:02:30 +0000
Message-ID: <20230808100232.5977-10-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9eb0de-db89-4d3c-bdf9-08db97f767f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xDljlsMlly+LvYyljX0lERcgf3LrtgYyWLGcJzCiEMrSOl2XsCiaYQ0lL7o9yfQMzIuJvuM/5Lb3OZlzDWocbZrQrP3lXG6PFWfhyUE/kAgmKhf0g7EADl7O131p7IpQw5WF/Xo/Wok/I4qrhyqij+3uZFQLX0hTRELFyx7RhSFsJiLSudRWlfB4i5ESuY/tWFqMScIiYF7lvPO3Uxh0B2yZusTWNfNY3hrwM7xhd4E633IruCY4Rf/pD9fijW9nvEUswDtjF/oHTKOaqPrdqiBFlJMTXbRbjpOQHjHn/iqPLhL4wxON70yEXHRvBEIG2DAW7JbQB3HBeHe72Y8EzuhZFlHLcro0JxwiX5pLNALDAh+GFRRLJv2OVHT/4xM6THfQN7NXYu63p1H0S3+8um0SN+sVRG5s51J8+ozrWpQo90/v1EywRQOYIKZ5nVSD9/+SKdWO3SpmNbyeS2WXdyRBH/GnfbbzELzc/NHxTgfGyxl9+8l6SVIQTcaNwlrba8wgsC88RbpNZXnGgCqrKgO2yTON1rEXImQaNhz7RlMomnqjng0WZrkMLfxNHwGwU7hnT0fgr94lYa8C00TV6aw7ntnnag1XUbuY1H7DfoolVr7dMeBLHLp1gzVAtAUf5JWoGYvII6mZlE2VfjgMSYKUN6j30jpKqOdai1noSpa+ovGKLX/2CmtOwRBVso7HVrDb0vGiX3+9j5rAlad9g1A8BvIUHDvLbQ6e+Fmu4i9gny2GmICgCIpKCmuIinjggw4b2bn5SZl6gvuxfp2vtg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(82310400008)(186006)(1800799003)(451199021)(36840700001)(40470700004)(46966006)(7696005)(2616005)(26005)(1076003)(36756003)(16526019)(336012)(6666004)(82740400003)(478600001)(81166007)(356005)(110136005)(54906003)(70206006)(70586007)(4326008)(426003)(316002)(41300700001)(8936002)(8676002)(5660300002)(44832011)(40460700003)(2906002)(36860700001)(83380400001)(47076005)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:08:25.9593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9eb0de-db89-4d3c-bdf9-08db97f767f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Introducing new functions to init and uninit v2 domain. Also setup /
clear GCR3 table. These functions will make necessary changes to
existing domain to switch to SVA mode. iommu_v2 module will call these
new functions instead of setting up new domain to enable SVA mode.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  6 +++
 drivers/iommu/amd/iommu.c     | 95 +++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index c9a35b6e2a87..f5a9697488f8 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -64,6 +64,12 @@ int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
 		       u32 pasid, unsigned long gcr3);
 int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, u32 pasid);
 
+/* v2 API init */
+int amd_iommu_v2api_domain_init(struct protection_domain *pdom);
+void amd_iommu_v2api_domain_uninit(struct protection_domain *pdom);
+int amd_iommu_v2api_gcr3_init(struct pci_dev *pdev, int pasids);
+int amd_iommu_v2api_gcr3_uninit(struct pci_dev *pdev);
+
 int amd_iommu_register_ppr_notifier(struct notifier_block *nb);
 int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb);
 void amd_iommu_domain_direct_map(struct iommu_domain *dom);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index bba2034a28f6..b56d1e624cf6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2179,6 +2179,101 @@ static void protection_domain_free(struct protection_domain *domain)
 	kfree(domain);
 }
 
+/*******************************
+ * V2API-related helper functions
+ * Note: Separate these out for now. It will be removed when
+ *       deprecate the AMD IOMMU v2 API support.
+ */
+int amd_iommu_v2api_domain_init(struct protection_domain *pdom)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&pdom->lock, flags);
+
+	/* Only allow v2API support on pass-through domain. */
+	if (pdom->pd_mode != PD_MODE_PT) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	pdom->pd_mode = PD_MODE_V2;
+
+out:
+	spin_unlock_irqrestore(&pdom->lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(amd_iommu_v2api_domain_init);
+
+void amd_iommu_v2api_domain_uninit(struct protection_domain *pdom)
+{
+	unsigned long flags;
+
+	if (!pdom)
+		return;
+
+	spin_lock_irqsave(&pdom->lock, flags);
+	/* Switch back to pass-through mode */
+	pdom->pd_mode = PD_MODE_PT;
+	spin_unlock_irqrestore(&pdom->lock, flags);
+}
+EXPORT_SYMBOL(amd_iommu_v2api_domain_uninit);
+
+int amd_iommu_v2api_gcr3_init(struct pci_dev *pdev, int pasids)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&dev_data->lock, flags);
+
+	/* V2API mode needs ATS, PASID and PRI support */
+	if (!dev_data->ats_enabled || !dev_data->pri_enabled ||
+	    !dev_data->pasid_enabled) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * V2API is supported on passthrough domain only.
+	 * Hence we cannot support GIOV for V2API.
+	 */
+	gcr3_info->giov = false;
+	gcr3_info->pasid_cnt = 0;
+
+	/* Allocate GCR3 table */
+	ret = setup_gcr3_table(dev_data, pasids);
+
+out:
+	spin_unlock_irqrestore(&dev_data->lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(amd_iommu_v2api_gcr3_init);
+
+int amd_iommu_v2api_gcr3_uninit(struct pci_dev *pdev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&dev_data->lock, flags);
+
+	if (gcr3_info->pasid_cnt) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	free_gcr3_table(dev_data);
+
+out:
+	spin_unlock_irqrestore(&dev_data->lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(amd_iommu_v2api_gcr3_uninit);
+
+
 static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 {
 	u64 *pt_root = NULL;
-- 
2.31.1

