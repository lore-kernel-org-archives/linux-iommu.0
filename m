Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD1C8DB
	for <iommu@lists.linux.dev>; Mon, 11 Sep 2023 12:14:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuQKyBzI241Lk6GjL6Goi1hMYIV/fHOUKrfqxY+jNavpXx25o2Dla86mfa5H3fcCOLuuvWY+9+LgE/ShGQKO1T8xPxfibBEbq+Tv3+jlDJesR15Un/Z6/8fJSangm3cUccc3jnqnzaynwfGkt1CSd47ffpJTqfTke+z/w/cvv70xC2ctgbIJRAdg12aG6/WgLEhpvDRWagp51RKrmPUDWmjMDSSlMF9wsGBzHX4SERSAl/GcbX9Lkv/uUQrGgeJ1jKjseP7IIgLgJ1P4pY3htRPL4pBDueNQ4NT0nbMkrf9MjxEBL2D6GeGxH3TzFg+OQdUi/I/I6KGnog8dtmaQlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huTeCCU8fwKAzXVHM8hAHUtC6htOZDLNZ+hv7qkINTs=;
 b=DoF163rc2OwGETQnKcgWwIRr8s8DIC7J+bgZfLVA4srYsFuald6BKAwCVhNnQRIZ9xkvVFs8uiPyntRDRhBnou+ou0p7zB5s6DdX1zy5NNWakI8tC14xwq1a8DLp381i1NJhyD2tHTKDNalJlfRBJdT92WajAAkODuzCEZRxZFq54HTZQLxXWlS03XMVJhlFXeuNMzV+YaGZIqkzYSPEVfEGWJjN2TkIHpR0GND8xavxLu2OfwgwPsWSgGbvCVM/Nc3c5gdIXATJzw2ZM54CY9rOJd2sx18MdkU6ozKNr4xkleQAnWMbI/uem4mPhl1tX7PknrwSeKrARX9zKbwo5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huTeCCU8fwKAzXVHM8hAHUtC6htOZDLNZ+hv7qkINTs=;
 b=kVOU865Ib61KPYv4xXwwqoYbwM/jUuOX0dZ5NFIidJyrg7e6QJWo2Mz3+OSeywsVQloqA8YBhkMXc4uC5iLYmVVNtboQrCCvrZsRLMlQ93JRQcXeSe/Iy1RoY6APskKzInOvHhdcD1Ze2van4bp3F2aRARMAyy+PmUAbqnm+NA0=
Received: from SN7PR04CA0114.namprd04.prod.outlook.com (2603:10b6:806:122::29)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 12:14:48 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:122:cafe::3c) by SN7PR04CA0114.outlook.office365.com
 (2603:10b6:806:122::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 12:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.16 via Frontend Transport; Mon, 11 Sep 2023 12:14:48 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 07:14:45 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 11/11] iommu/amd: Introduce logic to enable/disable IOPF
Date: Mon, 11 Sep 2023 12:10:46 +0000
Message-ID: <20230911121046.1025732-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911121046.1025732-1-vasant.hegde@amd.com>
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3dc544-10c9-419e-1c33-08dbb2c0b169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e+5C5ZtDTHxag7U+o7PAvJuWIkqIt7assLtD5anVgQ+LjAkaYXapPdcxhnsFaRz2HgOPR6hvVCCOLzlGfpQBDjzyAxEBcH3tqUF+y4x2qsTvKPUhDoIWwc9C0duv+xSA5Rr67FEynkmlkMbqwbcdQtYRsSP8oJtelBb0S0Aa9C3WrSSZ+Bqa5x4W+XT50OBZfgjdmCd+IpVoicSvNsz/KcCYDSBgXE93EiWC2EWfrDcI+5a/kplY3W9M65KlUKn18o1an9PiKJomqWJmpsLuBwm0CNlHtN9/97amSTQ9W3Y+o9XhtemL7V9AgifJW66PMTJwXu4Dc9Tvi3egPp336sMMvjwjx/nbvpyLM6RSU9sarl3WScm1mIENcEZEJSsThJgAkl8wB3cd7i4dcOn59SKql8y/pUfnemWFpMfKV9uBMXnyfLQyJkHIDVcC8eMwcnueGIM740GHLXqDHsAgaBcHuKWJcMzEBPju6UINJCQmz0PGUDsuOiPhbGHK6SZVQFSrr9YR5hS13423LWE4fm0JGmS8bVtp9o7ZrZa9+tGFVjFkcrChgcuXDsr6U7Ad1aBuowJRGeQBrff5Js7q/8sPOy50X7rYOyHviWkEOnCBI0hK4g3XQ+ZD7z0DZ8yunznvfpTPrY99tt3pX0XRwA+BuX18O8LYq9AtLpfH2R3gQnLdbk988gnOGIle2Bdob0hJXuCB5FeOaXAeFoT5SPzy9Pl9prMribvc4FXLoWvsHY/4gqC47uNgq77w9se7XRODdLeNAunJOka3z5hl4Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(186009)(82310400011)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(70586007)(110136005)(1076003)(26005)(2906002)(426003)(336012)(16526019)(86362001)(83380400001)(40480700001)(7696005)(2616005)(36860700001)(82740400003)(356005)(81166007)(47076005)(40460700003)(478600001)(36756003)(5660300002)(8676002)(8936002)(54906003)(4326008)(44832011)(316002)(70206006)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 12:14:48.2509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3dc544-10c9-419e-1c33-08dbb2c0b169
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Add support to enable/disable IOPF feature. So that PRI capable device
can make use of page fault handler in SVA mode.

Also add IOMMU_IOPF as dependency to AMD_IOMMU driver.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/Kconfig     |  1 +
 drivers/iommu/amd/amd_iommu.h |  2 ++
 drivers/iommu/amd/iommu.c     |  6 ++++
 drivers/iommu/amd/ppr.c       | 56 +++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index cabf4ccde1ed..22e33179c593 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -11,6 +11,7 @@ config AMD_IOMMU
 	select IOMMU_IOVA
 	select IOMMU_IO_PGTABLE
 	select IOMMU_SVA
+	select IOMMU_IOPF
 	depends on X86_64 && PCI && ACPI && HAVE_CMPXCHG_DOUBLE
 	help
 	  With this option you can enable support for AMD IOMMU hardware in
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 14198cade320..7dbd9e54f48f 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -62,6 +62,8 @@ int amd_iommu_iopf_remove_device(struct amd_iommu *iommu, struct device *dev);
 int amd_iommu_page_response(struct device *dev,
 			    struct iopf_fault *evt,
 			    struct iommu_page_response *resp);
+int amd_iommu_iopf_enable(struct device *dev);
+int amd_iommu_iopf_disable(struct device *dev);
 
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 35221deb848b..1be5fdab70d0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2574,6 +2574,9 @@ static int amd_iommu_dev_enable_feature(struct device *dev,
 	case IOMMU_DEV_FEAT_SVA:
 		ret = 0;
 		break;
+	case IOMMU_DEV_FEAT_IOPF:
+		ret = amd_iommu_iopf_enable(dev);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -2590,6 +2593,9 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 	case IOMMU_DEV_FEAT_SVA:
 		ret = 0;
 		break;
+	case IOMMU_DEV_FEAT_IOPF:
+		ret = amd_iommu_iopf_disable(dev);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 2891f67a6ca0..86c0cb836a71 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -9,6 +9,7 @@
 #include <linux/amd-iommu.h>
 #include <linux/delay.h>
 #include <linux/mmu_notifier.h>
+#include <linux/pci-ats.h>
 
 #include "amd_iommu.h"
 #include "amd_iommu_types.h"
@@ -306,3 +307,58 @@ int amd_iommu_iopf_remove_device(struct amd_iommu *iommu, struct device *dev)
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 	return ret;
 }
+
+static int amd_iommu_iopf_update(struct device *dev, bool enable)
+{
+	unsigned long flags;
+	int ret;
+	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	struct protection_domain *pdom = amd_iommu_get_pdomain(dev);
+
+	if (!pdev || !iommu || !dev_data)
+		return -EINVAL;
+
+	spin_lock_irqsave(&pdom->lock, flags);
+
+	if (enable) {
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
+	amd_iommu_domain_update(pdom);
+
+out:
+	spin_unlock_irqrestore(&pdom->lock, flags);
+	return ret;
+}
+
+int amd_iommu_iopf_enable(struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	if (!(dev_data->flags & AMD_IOMMU_DEVICE_FLAG_PRI_SUP))
+		return -ENODEV;
+
+	if (!dev_data->ats_enabled || !dev_data->pri_enabled)
+		return -EINVAL;
+
+	return amd_iommu_iopf_update(dev, true);
+}
+
+int amd_iommu_iopf_disable(struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	if (!dev_data->pri_enabled)
+		return -EINVAL;
+
+	return amd_iommu_iopf_update(dev, false);
+}
-- 
2.31.1

