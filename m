Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA0054FAB
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436560; cv=fail; b=JgNZj0SWu43htP3ezymAY6dsDBaQ0IVd6x/YEATUbHgUhPTi1V7rnqgcYCsmQ5sd0Ljlp2ZHBx7T5DIExO1AjBL2Bq7jk7/PK9IvYlXgF1odTM2OVzNdLeeSDJTfKSLIruGUcG3l7OMwfrv/rf93T+Wv6Uf9YtYtgELMSKfGre8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436560; c=relaxed/simple;
	bh=b4FCz9ZPXkD+4DThWcT/TFaGJ17I6PoSX8y+AM5ck+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEAwwL0hY2yYqkQknH3u5OCsfRxejWSOYoPWki2eIZsnJeCIyUVBms5lEtv271V9R8WuCWUSyUaJd/I6svf2tgVd/wXNHrGG2jt+0z5+Cb7Uw9n75nZsJ6ijPG92Vb7z656JFB01U6WWrsky1juW82XJfl7GOJjSFepprIY9Tq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ro68Wg7a; arc=fail smtp.client-ip=40.107.102.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ro68Wg7a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B96NfmXza52yTtz25GEWUlbhJx81bdKiaJYjWmhdCBxIUkVIeMiit2llTYhtMvhFfet0Ocf3O9Kewssx8YhztSdbb4xQACbCEghNXL6QFIZOxTG0ujtlFQzskdn/6mLf6h8MIctOTjg5nsq5HHivDpNWJiuCe3tkPpO8Bp2oH1j6qjcYfjm7pomQHwjfK4DB9fwUZ0tRqZ44EOhiljnfBeZcEvNCodoQLcs3RpgrbLIoP02Y++roSf4j7OC6hHUMonDqXlInJtEWy+jrgnHuypbNEpJPCnP06InHBPpI0XYBk5nPbMS4okwVLyVHZ8upYN3aGacryKfCJXHgmypM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5mI6j7ufQuFA9MVos8wsG5JHCicNRjG47uHc/AyIlw=;
 b=VD8iZNBRD0vsAZtfB7XtWr6MeCfVO/4VK8O2KbKE7L+TOLcocupLDcQ+UVNSQJOkpxbeI9/1I6KteKFx3g1scbMVfthXzveqYEGD+KnospGmluG9gmiZ8Q4UPgF0qSAHijVUZeC2MWsquDUi3W+nZFboNFZjFFRBIuTATlDKtmAWFX4HFsGIwSAutb8l3umNxSpO9Ct9XF3PDLGzEovs6kTTqkm9y5KK5sIB2ZYIkEKcS5tVgvZY/VciINTgDXoOP6Sruyd3jKh3CV3+y3R34126kvGA/XZtWxv14HRFQEU/5E3EuTIET1TbIJV1+HehqHD4R4gH3RMEGRbxIDVvSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5mI6j7ufQuFA9MVos8wsG5JHCicNRjG47uHc/AyIlw=;
 b=ro68Wg7aMWNsvRNiH5boVdUhGBO5dP1bAQrmJ4KJ07akREU/l2fHOLapCa13LA/PfqKjUhdiQsuKwDJoqEVjGXMjDRBj5iLMB3cszViWQUwNCtmVSADwIS+nZT7+qwVJIQIpX2PhNF6TKadx0lqt+SjidHlDFDM8crJwY2RGvDA=
Received: from CH0PR03CA0324.namprd03.prod.outlook.com (2603:10b6:610:118::18)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 10:35:56 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::49) by CH0PR03CA0324.outlook.office365.com
 (2603:10b6:610:118::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.24 via Frontend
 Transport; Thu, 18 Apr 2024 10:35:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 10:35:56 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 05:35:53 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v8 06/15] iommu/amd: Introduce iommu_dev_data.max_pasids
Date: Thu, 18 Apr 2024 10:33:51 +0000
Message-ID: <20240418103400.6229-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418103400.6229-1-vasant.hegde@amd.com>
References: <20240418103400.6229-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 8410f39b-2a89-4d57-5228-08dc5f9354b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d9lAvwUX4BZducQ5FxOpyYzKqnfQtcKKluNrlJwEI8wrIz176rQUF71Se9Mo3Sgwr3EibH4JbqH7Oksp3F9JaTZAucNhmMWqLXExykT0MCjjVI/VFSup5jBTvrl4Z+GvxtWIYEQNSl7bf82N0TGJ43gNYSkCE1FSXALESusosx3juz6B/5UPx35auwaxmfaJzfeIeeUeyLQy8mJf2a5txwzJBBPJ9ErCwfDKVdqu1ZlrvwMQPVCk4M/uPeWqXDhPFIZe1IuTKrs/5cMASpujZKszh35pbcqBL/AEQ5UUjSqRBSTpwaqTXHclsXS4E35rXjnugqZaONSUSE5RNE9HwKVMQi4DGnnirTrPAPRceqULxaqVu1Q2Idyp0fE45lHzDR0rWnS+WTXWIpblIfUADjyU08SjBty2aYlib61Yx0Vt/Z5H551L5aX/WRQw92Vuv+UjGehzERoZKMPF02lARwvVa1vgcQLWrRa1Q/Cg+X0Rb+on3bFwvDDIkrbG4+vv4r3bokIWadQfJtWfETeir2abeuSPICKAvkcxLuib58vMZw/8USNkv3r5hVnhgsBt27gZJ9bUcspdzMzaTh9tPC/BuY0nouD/Qtf0ZrtGQEVH4XILY3wWEbG7FE1Vz/3imrbED2NIyn61vRYh5qXR287zbfNTw7J0huCcJmb1/2FS/miNRREMUcEXoCLv24jzBZqG40TsisbObs2YTM304l02LtGQM7ULNsLr0JvdH2ZE32N6Kr7N8QrnRaCrSvZv
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:35:56.4921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8410f39b-2a89-4d57-5228-08dc5f9354b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765

This variable will track the number of PASIDs supported by the device.
If IOMMU or device doesn't support PASID then it will be zero.

This will be used while allocating GCR3 table to decide required number
of PASID table levels. Also in PASID bind path it will use this variable
to check whether device supports PASID or not.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index d1fed5fc219b..03442e86ae44 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -813,6 +813,7 @@ struct iommu_dev_data {
 	struct device *dev;
 	u16 devid;			  /* PCI Device ID */
 
+	u32 max_pasids;			  /* Max supported PASIDs */
 	u32 flags;			  /* Holds AMD_IOMMU_DEVICE_FLAG_<*> */
 	int ats_qdep;
 	u8 ats_enabled  :1;		  /* ATS state */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0decab958106..7daf6d75d964 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2104,6 +2104,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 {
 	struct iommu_device *iommu_dev;
 	struct amd_iommu *iommu;
+	struct iommu_dev_data *dev_data;
 	int ret;
 
 	if (!check_device(dev))
@@ -2130,6 +2131,17 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		iommu_dev = &iommu->iommu;
 	}
 
+	/*
+	 * If IOMMU and device supports PASID then it will contain max
+	 * supported PASIDs, else it will be zero.
+	 */
+	dev_data = dev_iommu_priv_get(dev);
+	if (amd_iommu_pasid_supported() && dev_is_pci(dev) &&
+	    pdev_pasid_supported(dev_data)) {
+		dev_data->max_pasids = min_t(u32, iommu->iommu.max_pasids,
+					     pci_max_pasids(to_pci_dev(dev)));
+	}
+
 	iommu_completion_wait(iommu);
 
 	return iommu_dev;
-- 
2.31.1

