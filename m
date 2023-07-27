Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665C9107AD
	for <iommu@lists.linux.dev>; Thu, 27 Jul 2023 09:55:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFFs3IDItXKXwgcsL+dbIda0869Bj8EVI7C4fA4aatEfEL99RnDO8cVNWLjANLgbUccpSNjLvV2F0U+jGTUC8cxeqMN1yeh9WD9pC+SXCXDzgtSoL4OGl5lStVCv9UyLqkHafA+yi8IoveMyTJss4Ymxmn3ucezicE5bQKuRdVAjMU5qo51rCVCTS8qxqbUGg6Mw+zBGjoJz+bGIyxkVxK5j6v8Nn5hRQwgF69R56AJVYq6vY90xJ2uV+5+munBIyihC7DgfxcStr2VgpyujOfKsizk8h3QB1pbRZMaTxgfxUWdIhTsP7cndwgtQU5vDTihw3ahj26h8+0pIbCBnfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7JtpV76pq9nI9Fj+r5JOAqlkQKMVwH/ByatbSVDn/0=;
 b=Afz6WVwszYemQ+J7LPvIk1nIw4f6cR3nKYSBTM86pabf3WlCrDd9eyVH5gymPko94a4eFXql/+mrhnxF+SotJ8qyzWgu4Ld/g/Uddg505ZwVzNnhdLpNOnSTwKrTnncPpTBkxroAStwaWDfy1Wy9NoGUqNWLOzKHVtaq/vyAUq7CabT0g1+fzUYy7AR7IHCfnehDC8C0T+QkRT7lKae/fSn6NSx2s0IHJjlLZX+/VUXHUZ6l8mPdYQT8KLTnNd6uUqKGkvBzG8fWVS7rIJ44lRoLklmNDbeBSvajQ/IS2/Jj8VTTr/W90FvBuwC/Tdl1Os6kp4Qo1mRMPxzHbVawCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7JtpV76pq9nI9Fj+r5JOAqlkQKMVwH/ByatbSVDn/0=;
 b=UAqX8uYlbCFzc25cw3Y6jZq9MKNsRUgYmXO9Wal8pW+n9VPW6DoRTWlX3FOuuqTc7t9YFVCuru7/WW0SsOa8w0tLRy9E1dDuzeWWlxud+fH3gJUVvN/9MK7cQ9uLl1D8QHlQvPHkunuCkN9npdSITXELx43IMP40kFHVtcIgfO8=
Received: from BN9PR03CA0903.namprd03.prod.outlook.com (2603:10b6:408:107::8)
 by SN7PR12MB6813.namprd12.prod.outlook.com (2603:10b6:806:267::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 09:55:45 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::b3) by BN9PR03CA0903.outlook.office365.com
 (2603:10b6:408:107::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 09:55:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 09:55:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 04:55:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 04:55:43 -0500
Received: from dev-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 27 Jul 2023 04:55:36 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde
	<vasant.hegde@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Philip Yang <philip.yang@amd.com>
CC: <iommu@lists.linux.dev>, <amd-gfx@lists.freedesktop.org>, Jesse Zhang
	<jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] iommu/amd: fix the address translation issue  when do detach
Date: Thu, 27 Jul 2023 17:55:31 +0800
Message-ID: <20230727095531.333532-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT055:EE_|SN7PR12MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e99e078-70ba-49cc-11c9-08db8e87a565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QD11+seLTLNKkzjSSzHcpNlXBNTMNhoZJ0bA27Kq8ICR8befh2wqhn2ugBU/73bW4e9LRUg3dYffZyngQ6leQFC1ZRPEqPpJHwg6uQyeNnxwrULpaq/XN7DlYOwjloQE4f6VY/gZBSmVpvDUB6tAv+JBh4YNSeSrNdv6OC1+ackoX6U003Ap76jPVWm0gfNFb/xq5F1s/xhnvVwWVnCczcTsTnbblkb0xMD48n/cazQghsquOPMhGEwPkq2F+yWUNBYs9wTlOTjKPyRjAC/fHfKChmxPPjwIvjCRIA5+t9AMbpzZU1C4rfA+5Hv1WfyXV2Asa/tMGWYhyntssXlQ+3vc+W3tUptbQ04XthmXGsulQFah4w/l/bzfFu4PaGhF0MRleRZY4ks+S07LwYt8vmYsSAhCC5jqUCLZDwzSnRLvkqSaCBN/MYcL3IcNwkBr3pHZYeWEJQWIF2uRTU4TsrLmf+c7lAAtHTYxlEkQes0nOdEYweDZxv1PoaRGVTiExKjwQQ9t4OPQXevvpJvHbQ3Kldrzkc9+phOpcYODFIRQPkM+wC2k0UMbh5t47ZGXHMK7UPIUGJ6T+Zj9DcZQmVbI1uxEatD0ubaac/zVSxH2uU+99PSn0y4oEPhkklSvcmcs5nfwGkX1jDvUtdQ1rtJgm9npwHxIE80dWPwqA42m/P/26COimJv8APfISP+ahdVtKcFI27Kha7nMSyKIP4K+2BcMxm199Sa66EAZj0rP4FyOycsoCOZNTw62+ihB
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(6666004)(7696005)(356005)(82740400003)(478600001)(47076005)(83380400001)(26005)(1076003)(966005)(70586007)(70206006)(81166007)(110136005)(54906003)(4326008)(426003)(186003)(336012)(36860700001)(6636002)(2616005)(5660300002)(40460700003)(41300700001)(316002)(2906002)(8936002)(8676002)(86362001)(40480700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 09:55:44.9338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e99e078-70ba-49cc-11c9-08db8e87a565
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6813

From: Jesse Zhang <jesse.zhang@amd.com>

iGpu driver fail to read/write register by iommu when start X.
kernel: [  433.296634] audit: type=1400 audit(1690403823.130:64): apparmor="DENIED" operation="capable" class="cap"
profile="/snap/snapd/19457/usr/lib/snapd/snap-confine" pid=12344 comm="snap-confine" capability=38  capname="perfmon"
kernel: [  433.515795] amdgpu 0000:03:00.0: amdgpu: failed to write reg 28b4 wait reg 28c6
kernel: [  440.195492] amdgpu 0000:03:00.0: amdgpu: failed to write reg 28b4 wait reg 28c6
kernel: [  453.679611] amdgpu 0000:03:00.0: amdgpu: failed to write reg 1a6f4 wait reg 1a706
kernel: [  460.383490] amdgpu 0000:03:00.0: amdgpu: failed to write reg 1a6f4 wait reg 1a706

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2659

Disable address translation service, before detach device.
Do detach will clear the page table point or pasid table entries,
so all DMA requests from the device should be blocked before that.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/iommu/amd/iommu.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index dc1ec6849775..6a2237bfdcb9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1863,17 +1863,20 @@ static void detach_device(struct device *dev)
 	if (WARN_ON(!dev_data->domain))
 		goto out;
 
-	do_detach(dev_data);
-
-	if (!dev_is_pci(dev))
-		goto out;
+        /* Disable address translation service, before detach device.
+        *  Do detach will clear the page table point or pasid table entries,
+        *  so all DMA requests from the device should be blocked before that.
+        */
+	if (dev_is_pci(dev)) {
+		if (domain->flags & PD_IOMMUV2_MASK && dev_data->iommu_v2)
+			pdev_iommuv2_disable(to_pci_dev(dev));
+		else if (dev_data->ats.enabled)
+			pci_disable_ats(to_pci_dev(dev));
 
-	if (domain->flags & PD_IOMMUV2_MASK && dev_data->iommu_v2)
-		pdev_iommuv2_disable(to_pci_dev(dev));
-	else if (dev_data->ats.enabled)
-		pci_disable_ats(to_pci_dev(dev));
+		dev_data->ats.enabled = false;
+	}
 
-	dev_data->ats.enabled = false;
+	do_detach(dev_data);
 
 out:
 	spin_unlock(&dev_data->lock);
-- 
2.25.1

