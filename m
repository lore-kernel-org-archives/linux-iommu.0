Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46566BB54
	for <iommu@lists.linux.dev>; Thu, 21 Dec 2023 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3BJD3uhm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMdJBcW17KykknxYVM1vGjnj3C7wu43yE0TAXqxNZYu/CM2gQqtnnEQlJaezlP19BZxo+ODl9G+qSPAhyvsU/G/LXe+M8YEGcdzy0jFU3XMNHUIhdqmNJRLgr0AJPvPRRY4N2SGLEPN237fRJTzecOeuXreDYleNYzDVhVC+CvgWY70Z+Pa79mq9m3N8/+hzsqr5fueZVs3qU2XVk6eJ/dEQrbnVgI+Ojjqa77NFilz5RYUbbmG1UwoqvLM/P2yYZOfR5bVLHMq/2lwMpMocQyN54xPFN88t1LN8Zyhnrs1IjJQuGGlRhGC8SLy3HWvsDj7WOlt1Aghtaw9R/PK+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zej3cvCD7PqlL9M064N3ApuwnWA5bbLLzgVxCh/Gjg8=;
 b=VArvLWZ5Ra6j3HIVYPLk6zJudaMmtZUSvMnjpm5p/yvFknWS30a4gSIYNTojCCWVMqMqunfAgVrkl3IiRkM1e3KgKmyYoWDzcGGbd3Znmq0wx/jiSnyHcY9b+mGANtDZW/k7mfskYRfw2YmIQ9mjCYS+yDLX9fYuqZYNJ6WTFzVuJeBpnWXDJXcVuU+kVuHw0NEXAeQfWxxsx+nnRa8XZ022aFkkADsJpcnrnQL3zLOJacDlENPxjzHoAcz6OIlaXcMhCgXIJ/IPGIkYNUSPRPvTbVqkpYFcEf7tdoCTT1fk2UrQHfFfmrSHr9fOtyEQiM6Gsf7rodrXAPHHshREdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zej3cvCD7PqlL9M064N3ApuwnWA5bbLLzgVxCh/Gjg8=;
 b=3BJD3uhmuYA/jV3JBbMJ2MexUQwoRg/07N7FQveJp9GiOEeALtxMIowgOyUSEmdHYUPL5wLdxAmelaY+w59SLOX7xPFa09J2YuKuK+4oFVvz2Jr98zI8yfGCw+x4b8e/YCyQTc5Kg0UgPtsjt82EEYckmAx+UaNGmqsHqBPrcLc=
Received: from MW4PR04CA0374.namprd04.prod.outlook.com (2603:10b6:303:81::19)
 by PH7PR12MB5901.namprd12.prod.outlook.com (2603:10b6:510:1d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Thu, 21 Dec
 2023 11:19:20 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::5a) by MW4PR04CA0374.outlook.office365.com
 (2603:10b6:303:81::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Thu, 21 Dec 2023 11:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 11:19:20 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 05:19:17 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 10/14] iommu/amd: Introduce logic to enable/disable IOPF
Date: Thu, 21 Dec 2023 11:15:54 +0000
Message-ID: <20231221111558.64652-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221111558.64652-1-vasant.hegde@amd.com>
References: <20231221111558.64652-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|PH7PR12MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c21486-d57e-4e0f-42c4-08dc0216adb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WeRyBfOGLS/bl/8nrl/X8LCPnmj74AxHPpKAmrVen1h6SxC+f5C0FD50FkDLzOniLGUUCwLR7xSLyTWsLzqgoablUiAvCojI3D88HH22tVmYCFWtigyzs3cavmXUx6OcX+fKVe3EaRjoZ+K3AoD3tED7VFcmaoFnCkW2ZC6jhmm2cdw/pWrc1N/kBkAmgrLsn7EXZiVssv3Y1hh3DtUuB5lV+cngXHlnFEGFcg7IHCtQlq8vwGnDinxQHQOUabWkKRT7zjxgn4CFHcww77nSHmuFZBlYnPVE1LtkDel9vhLMJsgKKT7jkaUsdYkrnvZ7pUfOQ4zyM/NGW++WcF8KXzmsRKJfmXoxocJ4r9+bMwSkLmpj9x0kV2Ha6JJ0unDZQVKVfEvfk9bWpXDYYacAm2KKu8xQnmEcqyPRt/CvWyWuuaINuuD2bDygo7b2nuivnoVdlDUUFdoZWNKyJAnSH6h6Uv2fPecNLdApK8i0x93UHuLourgU3OEZhLwHTKg32HADS/EC25nvo1w1ppscggIphFqZGlAuitxl+ALe0jzT8IKDTZASjizRI5j5Vink3ywbSLHT7sUKR5D5GuXfdA+za63CTSZTvYUdqxGJjAKglEuUsVPmQUehsE4eKKbq0qeSXGCQDLejsCezvgf5G7CNlc7f46DqpFvK/EIARy4GRKk1sJDhg+9dLwnn03NX6Tcudceo4IZULXD8GruLt7Sy2hYFA9nkEBjjUTGeDTkaKtcpIrnT+TLB+rK/Yg5pES/IIRdzj63mBDN1Nrtn9g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(8676002)(8936002)(4326008)(26005)(2906002)(40480700001)(478600001)(316002)(6666004)(44832011)(40460700003)(110136005)(70206006)(54906003)(7696005)(5660300002)(70586007)(86362001)(2616005)(36860700001)(356005)(1076003)(83380400001)(81166007)(47076005)(82740400003)(36756003)(426003)(336012)(16526019)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 11:19:20.5144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c21486-d57e-4e0f-42c4-08dc0216adb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5901

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Add support to enable/disable IOPF feature. So that PRI capable device
can make use of page fault handler in SVA mode.

Note that enable_feature(IOPF) just returns success, as this interface
is going away. IOPF handler will be setup in PASID bind path. Following
patch will add this support.

Also add IOMMU_IOPF as dependency to AMD_IOMMU driver.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/Kconfig     |  1 +
 drivers/iommu/amd/amd_iommu.h |  2 ++
 drivers/iommu/amd/iommu.c     |  8 +++--
 drivers/iommu/amd/ppr.c       | 61 +++++++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index 443b2c13c37b..d563f6d496ca 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -10,6 +10,7 @@ config AMD_IOMMU
 	select IOMMU_API
 	select IOMMU_IOVA
 	select IOMMU_IO_PGTABLE
+	select IOMMU_IOPF
 	select IOMMUFD_DRIVER if IOMMUFD
 	depends on X86_64 && PCI && ACPI && HAVE_CMPXCHG_DOUBLE
 	help
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index e4c2618e7539..aed512c10052 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -54,6 +54,8 @@ int amd_iommu_iopf_remove_device(struct amd_iommu *iommu, struct device *dev);
 int amd_iommu_page_response(struct device *dev,
 			    struct iopf_fault *evt,
 			    struct iommu_page_response *resp);
+int amd_iommu_iopf_enable_device(struct device *dev);
+int amd_iommu_iopf_disable_device(struct device *dev);
 
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2913b7e701cb..ec30cee33f3b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2780,9 +2780,11 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
 static int amd_iommu_dev_enable_feature(struct device *dev,
 					enum iommu_dev_features feat)
 {
-	int ret;
+	int ret = 0;
 
 	switch (feat) {
+	case IOMMU_DEV_FEAT_IOPF:
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -2793,9 +2795,11 @@ static int amd_iommu_dev_enable_feature(struct device *dev,
 static int amd_iommu_dev_disable_feature(struct device *dev,
 					 enum iommu_dev_features feat)
 {
-	int ret;
+	int ret = 0;
 
 	switch (feat) {
+	case IOMMU_DEV_FEAT_IOPF:
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index c5f2a2b4128d..d7d98b3364be 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -299,3 +299,64 @@ int amd_iommu_iopf_remove_device(struct amd_iommu *iommu, struct device *dev)
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 	return ret;
 }
+
+static int iopf_update_device(struct device *dev, bool enable)
+{
+	struct protection_domain *pdom;
+	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	int ret = 0;
+
+	if (!pdev || !dev_data)
+		return -EINVAL;
+
+	pdom = dev_data->domain;
+	if (!dev_data->domain)
+		return -EINVAL;
+
+	spin_lock(&dev_data->lock);
+
+	if (enable) {
+		if (dev_data->ppr)
+			goto out;
+
+		ret = amd_iommu_iopf_add_device(iommu, dev);
+		if (ret)
+			goto out;
+
+		dev_data->ppr = true;
+	} else {
+		ret = amd_iommu_iopf_remove_device(iommu, dev);
+		dev_data->ppr = false;
+	}
+
+	amd_iommu_dev_update_dte(dev_data, true);
+
+out:
+	spin_unlock(&dev_data->lock);
+	return ret;
+}
+
+int amd_iommu_iopf_enable_device(struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	if (!dev_data)
+		return -EINVAL;
+
+	if (!dev_data->ats_enabled || !dev_data->pri_enabled)
+		return -EINVAL;
+
+	return iopf_update_device(dev, true);
+}
+
+int amd_iommu_iopf_disable_device(struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	if (!dev_data || !dev_data->pri_enabled)
+		return -EINVAL;
+
+	return iopf_update_device(dev, false);
+}
-- 
2.31.1

