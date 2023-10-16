Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26D11F60F
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oUEvCBJ4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lz/RFP6D96Xci9BCZMpMHlHu/AsGUXWpyYJR42HczZ9+BrUUJl51zloZotysZPETamb3W3fYSgJ6AUxl3MKCJAIPNLAO4tQiNyljNgh/BJtx8V7WSiVJyYutt8sLYHWmpOcdkvkPOYf+CD9zwTPQm/dCVCqd6+PnpOqb+x1d557KVWlVPAjkWc8zLc+cNxpYNuTheWb3Pdz9WwZ/o4KLiPc0HetzbqOxMohrbl/J7NXOX+UK9CtjawJtfmig04tuvC0xZDKEVzipRQPM7t0wt/kmQoD1w99KMz4Je04kuzTJkRhINNxYa+RukdckFnw5FjU2WXCgINh0E9FJcxacVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFyMancOLkdDJ+JSc2XzT5YZoljw3Bqfp1+i4xg+ECY=;
 b=Vi/Xv1Usy4ReEOWl86Y5rvDz+o2VbMCQrylpox2yicH1sxr3RgNI9OuWO2drGf12K9OA8lbdJKmwVSCRsbRkLV1PBK7/hRpH8Obi5o7hxm0d+TRBvbEYweqcTPKv5MgfeBjz1DIwGs2aBTIc5Zmtfwr/6SY5sihAD+CFX9+9UOLuEZYM24G7eWveAN8YhEYMEGeijIf8epQP3DQMo47GqfWzxUKQqMn0ar5fPVIlh9XLeuyO5Bbiolsf2WVUODegtQFW+B47DaB+j8Yu+RrC7gJLhCI+nlD4HJ2X7eJ/JCheMyeYMLlL7DJS5t/qCmUQTWqWyvXzcbeA324hIzAnfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFyMancOLkdDJ+JSc2XzT5YZoljw3Bqfp1+i4xg+ECY=;
 b=oUEvCBJ4wXY0cc+kX5zjGr8OZ2+VPevspxHJRUaPvSjCiM09+kyIBBvd6gZd+rrXPig5wnX1Wla4ecQ92XbLNjvy4kWR0i5hx0XDDuHDGeD5ftq/gSCGIMtxC079KODQ+T1jaKc1Jxosaurnk3yjQfe9BTolZBCwJHpr0RLCBXo=
Received: from MN2PR15CA0058.namprd15.prod.outlook.com (2603:10b6:208:237::27)
 by SA3PR12MB9091.namprd12.prod.outlook.com (2603:10b6:806:395::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Mon, 16 Oct
 2023 10:47:16 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::79) by MN2PR15CA0058.outlook.office365.com
 (2603:10b6:208:237::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 10:47:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:47:16 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 05:47:13 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 06/12] iommu/amd: Add support to enable/disable PASID feature
Date: Mon, 16 Oct 2023 10:43:45 +0000
Message-ID: <20231016104351.5749-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016104351.5749-1-vasant.hegde@amd.com>
References: <20231016104351.5749-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SA3PR12MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: 418b0ceb-f582-4f04-d722-08dbce354354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j1Pz/Yb2TNgT9Nll9VryXzPDz5GgodiNHEUIOYn6kg4wbP6gHEoYu5GkRAsZcxTgSsIse3N8Q4f9iOZOgJSjczupwXO9mOUuSqguD+2CvYrAWwnTDNOC2IXH2ZyVkdDN2xoqwxYyZJttEnsSs69zOCpQ6MjHVRTPR9G/6eVLRoN4Dx/wWBI7zlPeEoTHUGTOiEuNjAME+/hk8NttWvo653Ex4crYSNA3MJwphtd2zWK6oLBbNR8x1zUbctwNMYu9g+VXnpB5ILtOYvN8KkVSd0RN3L/njmER93XNNy0lLWP5+iBDjoUBMbJ6Bq8QgrQvvnfj/JkX0uHdgHfaeqEezUxyfpxyN6idO7IZiMWOUIRRynXmyhT+8dNn2ym4yNB8mhEV8Y6KcJwmTGb2ebjI3yUbt9GdjGdX7zPAWjjSQpGeBD8HNRFxwP2siUdQVEDhxQxnEo4B+zuecDCrz94SdFIHNY4lPIzdzFnnGUEIGewFoddDbNwbx5Qdutr4NqNwxZhqOVjFjdnPerGYOYyfp1jk/K4Ept3PHwjX52YFsucHL9EHRKGlut/WdBxWyTeBAn9mA2bbkh1/ZY+hRsvbCV5cWaO3uRcrsjUxCGfOZ6Rl5wrwMZVYdp7qh6QnE/brNXFk2WdK5/LZKi6Za4dr6YridEAagIBHBAVDs/Xy8qxYz6xS1D140MUjIdtxvdHwht+T7u2CP+xdaBJ6kx0wBfZXJXUrdsw+3P/kzyMK7GTqOUAwmk+SSVT0p2/R/vCaILQWyJ67yay8RmXtP1PHZQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(1800799009)(64100799003)(82310400011)(451199024)(186009)(36840700001)(46966006)(40470700004)(316002)(478600001)(16526019)(82740400003)(70206006)(6666004)(7696005)(110136005)(70586007)(54906003)(4326008)(41300700001)(44832011)(8676002)(8936002)(356005)(36860700001)(1076003)(40480700001)(26005)(2616005)(426003)(336012)(81166007)(2906002)(83380400001)(5660300002)(40460700003)(47076005)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:47:16.0810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 418b0ceb-f582-4f04-d722-08dbce354354
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9091

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

It seems iommu_dev_enable_feature(SVA) will be deprecated soon. Hence in
this path we just return success.

Instead we add necessary check during pasid bind to device. In this path
it checks whether device GCR3 table is setup or not. If not it will
setup GCR3 table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  2 +
 drivers/iommu/amd/iommu.c     | 44 +++++++++++++++++++++
 drivers/iommu/amd/pasid.c     | 72 +++++++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index efcbec84d096..216792006891 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -46,6 +46,8 @@ void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid);
 
 /* SVA/PASID */
 bool amd_iommu_pasid_supported(void);
+int amd_iommu_gcr3_init(struct iommu_dev_data *dev_data, ioasid_t pasids);
+void amd_iommu_gcr3_uninit(struct iommu_dev_data *dev_data);
 
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0974c88e39ce..a34998bbb779 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -87,6 +87,11 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid);
  *
  ****************************************************************************/
 
+static inline bool pdom_is_pt_mode(struct protection_domain *pdom)
+{
+	return (pdom->domain.type == IOMMU_DOMAIN_IDENTITY);
+}
+
 /*
  * For invalidation request without PASID, get the pasid based on
  * domain page table mode.
@@ -1977,6 +1982,39 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
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
+	if (pdom->pd_mode == PD_MODE_V1)
+		return -EOPNOTSUPP;
+
+	/* Allocate GCR3 table */
+	if (pdom_is_pt_mode(dev_data->domain) &&
+	    dev_data->gcr3_info.gcr3_tbl == NULL) {
+		ret = setup_gcr3_table(dev_data, pasids);
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
+	if (pdom_is_pt_mode(dev_data->domain))
+		free_gcr3_table(dev_data);
+}
+
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data)
 {
@@ -2778,6 +2816,9 @@ static int amd_iommu_dev_enable_feature(struct device *dev,
 	int ret;
 
 	switch (feat) {
+	case IOMMU_DEV_FEAT_SVA:
+		ret = 0;
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -2791,6 +2832,9 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 	int ret;
 
 	switch (feat) {
+	case IOMMU_DEV_FEAT_SVA:
+		ret = 0;
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index c251b274eda0..f064d0ed1138 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -11,6 +11,66 @@
 
 #include "amd_iommu.h"
 
+
+static inline bool is_gcr3_table_empty(struct iommu_dev_data *dev_data)
+{
+	return (dev_data->gcr3_info.pasid_cnt == 0);
+}
+
+static inline bool is_pasid_enabled(struct iommu_dev_data *dev_data)
+{
+	if (dev_data->gcr3_info.gcr3_tbl != NULL &&
+	    !is_gcr3_table_empty(dev_data)) {
+		return true;
+	}
+
+	return false;
+}
+
+static int iommu_pasid_enable(struct iommu_dev_data *dev_data)
+{
+	struct device *dev = dev_data->dev;
+	int ret = 0;
+
+	spin_lock(&dev_data->lock);
+
+	if (is_pasid_enabled(dev_data))
+		goto out;
+
+	if (!amd_iommu_pasid_supported()) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	/* attach_device path enables device PASID feature */
+	if (!dev_data->pasid_enabled) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = amd_iommu_gcr3_init(dev_data, dev->iommu->max_pasids);
+
+out:
+	spin_unlock(&dev_data->lock);
+	return ret;
+}
+
+static void iommu_pasid_disable(struct iommu_dev_data *dev_data)
+{
+	spin_lock(&dev_data->lock);
+
+	if (!is_gcr3_table_empty(dev_data))
+		goto out;
+
+	if (dev_data->gcr3_info.gcr3_tbl == NULL)
+		goto out;
+
+	amd_iommu_gcr3_uninit(dev_data);
+
+out:
+	spin_unlock(&dev_data->lock);
+}
+
 static void dev_pasid_remove(struct pdom_pasid_data *pasid_data)
 {
 	/* make it visible */
@@ -103,6 +163,13 @@ static int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
 	/* Use SVA protection domain lock */
 	spin_lock_irqsave(&sva_pdom->lock, flags);
 
+	/* Make sure PASID is enabled */
+	if (!is_pasid_enabled(dev_data)) {
+		ret = iommu_pasid_enable(dev_data);
+		if (ret)
+			goto out;
+	}
+
 	/* Add PASID to protection domain pasid list */
 	pasid_data = kzalloc(sizeof(*pasid_data), GFP_KERNEL);
 	if (pasid_data == NULL) {
@@ -150,6 +217,7 @@ void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	struct pdom_pasid_data *pasid_data;
 	struct protection_domain *sva_pdom;
 	struct iommu_domain *domain;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	unsigned long flags;
 
 	if (pasid == 0 || pasid >= dev->iommu->max_pasids)
@@ -174,6 +242,10 @@ void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 
 	dev_pasid_remove(pasid_data);
 
+	/* Remove GCR3 table */
+	if (is_gcr3_table_empty(dev_data))
+		iommu_pasid_disable(dev_data);
+
 	spin_unlock_irqrestore(&sva_pdom->lock, flags);
 }
 
-- 
2.31.1

