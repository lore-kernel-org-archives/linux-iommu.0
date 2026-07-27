Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5874C41A92A
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159097; cv=fail; b=JIKiv0PnAungL1pQ1ZuWnLwd1ZwllG4FGHoDO1WgAha8fzSPKQgvRItueZINnRzE3F4ofbKEcVbGIa/KCkPZBN936IcUMCEVwVaYSnRRyBzDkU6Bpd4dusZSTl6f17DFXJBeVJy+EYmsxZn5W4U+ZPojpZioHlTL4IapeflcTQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159097; c=relaxed/simple;
	bh=JZCyRLO/60jt7gS2yWynYS8LLDQpw0eH0NJ2GXoVj4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jm5nfZiVixt4fvT7jao8OL7gC/4WdOIpwhbve/iRrLVwAJyvwKwCZFISlfLc2i6novfFERrWp8gry/KPu38bZvylolkfqIPWNCFPUAsyMP/7XnXFMUErfv6zZwIK3397kfpkNXmGK/7BoEDpXvdBb5vrMaCWT0DtauXUmzNo0tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qNnAh5Tr; arc=fail smtp.client-ip=52.101.57.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qNnAh5Tr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8QbYj9hy4L0lfRUPunQq5Jmt/a3AOsaTLkUIwK3FG6XEM2p3C//gtIepbv6I7uAR2ox1pWXzo19TmJSEiGkmhlvm1oNhlQi7FlgxCjvbejhlSBM7y5uNsFSaDehaTtz2WWN2znMyU0+aQbhBcp3QzDYC20cevB4EzEeJhWV+RYJg3wwGrN3gL9WitqN3KUpAJfFsCd9+23xtqpKFTeDPBDmNzBgxa+JhsFRplUZpDdRTZDygjWRENFGx4/jiPN0nj5cSOqtYWCdY7t61tUClFcQNz0OwFSrvHQVwAJZUHQJTfxn0w/SIhfQe5HeOuNV6+t++WBVOBp3egOW1AhUtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rF08QN9HTDAAbAMPJVkj8b6Of93E4yfvwNT8yR0elE0=;
 b=b8IJkAHit1qYhr0NMJtv/BXjcw7Vb84YuyCwaywFN5QYa/hLQ2GzHlbzFpm+4iiX6tXMoD4aj3l+RKMnJxNCH98RfKgRWo0iz6AZGMUPTcYP587L6HJR7S4bALTUKq7ApZVcsO1UNFgbihxnVyvHuTpfc8iUKpUJPpU0YO3HociPMkbzYx6ktNdL2e0SODUrci8Qb2WBU966XL+omx1fDL7vnItXBKzX2vah2g/SxCblrWTxfFeYeVyYZEN3Z54mTJan84aUFAl1utwC4d9Sn1MR3IJhbd/EQtGD/wGmhEYgdWxftKviH+9sL/p2Qi7sNnl+xT5MFhIL72CuR/I/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rF08QN9HTDAAbAMPJVkj8b6Of93E4yfvwNT8yR0elE0=;
 b=qNnAh5Tr8Xf61v7IUAHQGg2vc68hdSuLpOqvAPS/JoAEL1tX7gbXnUGW+Jm88A+ojS7l5OK8/Bmtn8HfljbgNEt0voNryd+0jo9XKrrzzI5nxasNJ6WJOsZmpqQlAHwBPxpoaQ/7qmkrTphn5z9+xCxugUVbcMAR/A/3YY+yRMo=
Received: from SA1P222CA0184.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::29)
 by SJ0PR12MB7474.namprd12.prod.outlook.com (2603:10b6:a03:48d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Mon, 27 Jul
 2026 13:31:29 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::33) by SA1P222CA0184.outlook.office365.com
 (2603:10b6:806:3c4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:31:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:31:28 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:31:10 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 13/24] iommu/amd: Assign IOMMU Private Address domain to IOMMU
Date: Mon, 27 Jul 2026 13:29:02 +0000
Message-ID: <20260727132913.22475-14-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SJ0PR12MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6b02cd-9457-4dc7-8bba-08deebe35d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|7416014|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	JaL4gQaJ/K0a4i0kgDHjYKI4L3JS0VRzEArSqZaovITJleZAol94sR4nWkRydp1KB2LJOUiUvRJE+WNOqlc5W1YQ+LbA4iV55Fz49UOAceVmzPjVt/O4PglHjETCDdBSj2Qjaol7scRC4qzSAqy+6P/3ezzLJ2vFFp5zWmOV93snh6fwqMCtULe3mpkJOG08m2PNdYGr/iDi7UdsrHpbXl2PhUYtOPYgdL/r74p3l3QNS+a/+Tpul9QqF4UCN34uc2hcmFCAU2jtFHedLIe90Iyaz8WeXaC7aSCcvdBxGr923nFrtcXiQXRojfJRCRPRUk2BJlls87gyjd3coLg6P86yc1qecLiJ9cnu3I4rRqeChLkOcp3OWjmCppE1okwzNMB7fsiYPDy3Vdg2eB8iuVLERc/59YD1sSBar/GRjevmrAgRnurUAQA1u3auFwPaOgawqVPGoMIF2p1ShmkNOgYbyi5wnraMar7ybSJU2TbVeVRERnyx/wjBXByo1J7NtEZjaKStL3omj+m/O1Auz2wp8coKZh9vmO384FcUaXb33OgWAqA953EGonX4yB5j/8m+eKE9posumFML9FLawcADYk9P6BgQZIW2GLmmKPMti+gI7wEQ3qO3R61EDmHaqfHFb2p5lDOWD2EOr90Sc6eKyq2ihYLa5B6AAtLnDnBfvQRga0JQ3/lCIayCiJRj7Eb310O1kqyo6RZ0lIFc/w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(7416014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IBn3ah1hWF+1N+RB6AvypKaJ0/9Gjc102R+mSy1KsSFQxsVYYsRJM/4cpP+GgK8XLf6XDxgyQX09hhNxjB/Eutnax+wY0IzlJRPCjmPNTpGMlJfkt1XlX+0lOKEBjpH938G0Y8SmICjqoxcNHaJjfbJCoRkZKuFEJb9HD2CXYyhfGpnBopdNOGp8PGqFB9a+vek/Dl17rJ9w4638E9iY+DnQ+07h6PczMmnP18Jak6kY8chwSAitMSkTUfh+fKsIHXIhQC/Z5ENRtf7L3Lsv6HfgC1vR2f/rm9QmCVy+rRtnjxNELwBIReON1lVAdfM/NwXQwL3TL/mLLNZzqdffLF5BKJ1fW4fdQtJxM9lniVCX4ENQd1mtU/lafHzqEPSisDEFm+HO168lf2pTUsAqD62nqzsumdXCIUdtQSYdDxlZ4dAEy81joMLeVmW9jKF4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:31:28.5836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6b02cd-9457-4dc7-8bba-08deebe35d2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7474

By setting the domain ID, pagetable mode, and IOMMU v1 page table in the
IOMMU Device Table Entry (DTE) indexed using the device ID of the
AMD IOMMU.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  2 ++
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 23 +++++++++++++
 drivers/iommu/amd/viommu.c          | 51 +++++++++++++++++++++++++++--
 4 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index aecdfe6e9796..951757c2507f 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -57,6 +57,8 @@ extern unsigned long amd_iommu_pgsize_bitmap;
 extern bool amd_iommu_hatdis;
 
 struct iommu_dev_data *amd_iommu_alloc_dev_data(struct amd_iommu *iommu, u16 devid);
+void amd_iommu_free_dev_data(struct amd_iommu *iommu,
+			     struct iommu_dev_data *dev_data);
 
 /* Protection domain ops */
 void amd_iommu_init_identity_domain(void);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a5e2f32590d1..340929ae776a 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -823,6 +823,7 @@ struct amd_iommu {
 	bool gid_ida_inited;
 
 	/* HW vIOMMU support */
+	struct iommu_dev_data *viommu_dev_data;
 	struct protection_domain *viommu_pdom;
 	void *viommu_priv_region[VIOMMU_PRIV_SUBREGION_CNT];
 };
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d6e18a2df9c7..79698eec21dc 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -406,6 +406,29 @@ struct iommu_dev_data *amd_iommu_alloc_dev_data(struct amd_iommu *iommu, u16 dev
 	return dev_data;
 }
 
+void amd_iommu_free_dev_data(struct amd_iommu *iommu,
+			     struct iommu_dev_data *dev_data)
+{
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+	struct llist_node *prev = NULL, *node;
+
+	if (!dev_data)
+		return;
+
+	for (node = pci_seg->dev_data_list.first; node;
+	     prev = node, node = node->next) {
+		if (node == &dev_data->dev_data_list) {
+			if (prev)
+				prev->next = node->next;
+			else
+				pci_seg->dev_data_list.first = node->next;
+			break;
+		}
+	}
+
+	kfree(dev_data);
+}
+
 struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index d35125a721ef..d2782f9070ee 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -71,8 +71,27 @@ static void __init amd_viommu_vf_vfcntl_unmap(struct amd_iommu *iommu)
 		release_mem_region(iommu->vf_base_phys, VIOMMU_VF_MMIO_MAP_SIZE);
 }
 
+static void viommu_free_self_dev_data(struct amd_iommu *iommu, bool clear_dte)
+{
+	struct iommu_dev_data *dev_data = iommu->viommu_dev_data;
+
+	if (!dev_data)
+		return;
+
+	if (clear_dte) {
+		struct dev_table_entry new = {};
+
+		amd_iommu_make_clear_dte(iommu, dev_data->devid, &new);
+		amd_iommu_update_dte(iommu, dev_data, &new);
+	}
+
+	amd_iommu_free_dev_data(iommu, dev_data);
+	iommu->viommu_dev_data = NULL;
+}
+
 void __init amd_viommu_uninit(struct amd_iommu *iommu)
 {
+	viommu_free_self_dev_data(iommu, true);
 	amd_viommu_gid_ida_fini(iommu);
 	amd_viommu_vf_vfcntl_unmap(iommu);
 }
@@ -296,21 +315,39 @@ u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid)
 	return iommu->vf_base_phys + gid * VIOMMU_VF_MMIO_ENTRY_SIZE;
 }
 
+static void set_dte_ipa(struct amd_iommu *iommu, struct dev_table_entry *new)
+{
+	struct pt_iommu_amdv1_hw_info pt_info;
+	struct protection_domain *pdom = iommu->viommu_pdom;
+
+	pt_iommu_amdv1_hw_info(&pdom->amdv1, &pt_info);
+	amd_iommu_set_dte_v1(iommu->viommu_dev_data, pdom, pdom->id, &pt_info, new);
+}
+
 int __init amd_viommu_init(struct amd_iommu *iommu)
 {
 	int ret;
+	bool dte_set = false;
+	struct dev_table_entry new = {};
 
 	if (!amd_iommu_viommu ||
 	    !check_feature(FEATURE_VIOMMU))
 		return 0;
 
+	iommu->viommu_dev_data = amd_iommu_alloc_dev_data(iommu, iommu->devid);
+	if (!iommu->viommu_dev_data) {
+		pr_err("%s: Failed to allocate dev_data\n", __func__);
+		return -ENOMEM;
+	}
+	iommu->viommu_dev_data->dev = &iommu->dev->dev;
+
 	ret = viommu_init_pci_vsc(iommu);
 	if (ret)
-		return ret;
+		goto err_dev_data;
 
 	ret = viommu_vf_vfcntl_init(iommu);
 	if (ret)
-		return ret;
+		goto err_dev_data;
 
 	amd_viommu_gid_ida_init(iommu);
 
@@ -318,5 +355,15 @@ int __init amd_viommu_init(struct amd_iommu *iommu)
 	if (ret)
 		return ret;
 
+	/* Set DTE for IOMMU device */
+	amd_iommu_make_clear_dte(iommu, iommu->devid, &new);
+	set_dte_ipa(iommu, &new);
+	amd_iommu_update_dte(iommu, iommu->viommu_dev_data, &new);
+	dte_set = true;
+
 	return 0;
+
+err_dev_data:
+	viommu_free_self_dev_data(iommu, dte_set);
+	return ret;
 }
-- 
2.34.1

