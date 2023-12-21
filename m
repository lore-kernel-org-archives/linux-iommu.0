Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF466ABAB
	for <iommu@lists.linux.dev>; Thu, 21 Dec 2023 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L/HT0/Mi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V82GGjCnSkpepAvmcQhKsAf5GHKaNqNe9wSgUcTusAQW37NBpBBT+/Lu19SjSL4qMJZ8XPsmuHtYcJjQ7jl4o/wnDLUmOqOy+7IBPtfyP0hlFFF4IG4K5meVXgvcxnG3jpnjbTHqyxXJgKA8E3m/1kjVV2fd/4SW0c8+xw97NuXWAOHC2/fiwG/8gMBpU44HheX+GiPlz197C5UQvj80hfWp+8MrFhjeBQN4Ur6Hah8ka5gbjPB2hGskBVIiU+9c2rSpNW/7ecYPX61vaCmSPn0XBB0w/p1U0eIXaYmYiFqr+zMmyxJ5PebS4J97HTGx9FMeQEg8I6VU08zS7KIYYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWlHdtPprQlURAb0aA3oWt1x2RZO2Ao8teBy1R7G13E=;
 b=W4gJTeJGxaGa7ofCg5EW1x3YPY/YPUmpRHe4djtzU+KOJIfws5Q7j92by3EDp0ZUq6QNypHIBH7b+N86Y4XE3hBRX5m5FP9ieaHUJXZC40fVdwoi1DVyPeU+jghUo+1TfbBhvO7jV/hjUKzJpPWAIStt+Az08MJ/JkooxPA9ZRYpfbugmz0sRBKsJgNGw4mdEA+m6Yz1qTr5rot4dYv9sXroxQNhd5Rpd76sFQ3bTIy6CZPaH9BlToMHbjyhcyKAd+GQdwdmG/f+dxkfw7jPza0RpvFox+LaqZ4ls+JY/DHOXkrUHj+b4ogZ3ay35EwWyWSV5d0imOkqBKwEvy4dPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWlHdtPprQlURAb0aA3oWt1x2RZO2Ao8teBy1R7G13E=;
 b=L/HT0/MiqgZRa+1VyRujlbciIUmY5jZdqPKnvFAV5V1fTEdoP7UEBG5h0+dPVsN4u8XHZ/79CtJpVqQmPblvUkfKPyMtG9NJJO2SuSw/pyBFo0wb4AUpc2fvpI7hc+bE65JSDoyoYBcWygyd9qZtSFnoebGeSePNtqzsDRHa8sE=
Received: from MW4PR03CA0358.namprd03.prod.outlook.com (2603:10b6:303:dc::33)
 by MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 11:16:54 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::46) by MW4PR03CA0358.outlook.office365.com
 (2603:10b6:303:dc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Thu, 21 Dec 2023 11:16:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 11:16:54 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 05:16:51 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 02/14] iommu/amd: Introduce per device DTE update function
Date: Thu, 21 Dec 2023 11:15:46 +0000
Message-ID: <20231221111558.64652-3-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: e055a0f7-2d33-449e-24a0-08dc021656a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xXMszIP9eyL1U9D939Fz0G3kJZGYTy1VinirWmyfl8EYcBSMaQmoiePHDmRSimOdxBVoOIK/Ic/j9lcQkXYBMZu9eEOd9jVgIsc0BNMFrrKxaTdA216OC0vX5OS2SMohnvqNFNV44KiM8HlOtUQroh5zFG5dD0R0y92Z9c6xkTcLvnv9g3zbE5QNsbT+9zj5TWcSuoNMvn+2RzfmJImY56VzZwckR79TaOeP1HadkusrULe/hD5ZhcxXN1QspYxx6ouYFLzg3v4oAPQQAObrBqIcJfsGvoz8nHCCfykP+AgMukuagtKNiKXEWVRUl5vH/YSVHQcdV58A3TP0/3kAqWbSE9yEI8zhiVJe35LwQpOgz0/ryMRBDhx7aDn5jNSV90GbE+3+60hl6E0IBLjh39Os8UuWvWRLrBgBdPRUYQvQyzHEAY67xkg54Sf2W4qA4Fke/vMzP6UttTQ2hQpVLd2WfwdY1hf9JhZ0ckjrdGn4s7meG/DXWXEK1wNIjeewS1Olm/ITixjn3Rj66wwqCj5O2zRG9LaVRGt6c6Qg2ks/349dC5+WiNF/GQVYp+kAM2gMyETbQSVzXZXtCxb+ykHiQbjJay+UszjO5i3pQjQk8dUlok8BDm9R9XfbT5cSJm1+BHc8E7zh5Q6Z+qrpabk3d62VG2Mrzo1JL+eV8FJ/zBpd/oxCp5P6wdeYEvSptopOakbOpor8rHxKyFGm+9CImn3m1xXj3K1Wsfmd1W8b8gBCM4aaN2nqMcabZSyLd++HIQqGHNw/CkfL9uzWnA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(36840700001)(40470700004)(46966006)(8936002)(8676002)(47076005)(4326008)(15650500001)(82740400003)(36756003)(81166007)(356005)(41300700001)(86362001)(2906002)(44832011)(36860700001)(5660300002)(26005)(16526019)(2616005)(40480700001)(1076003)(6666004)(70586007)(110136005)(478600001)(40460700003)(7696005)(70206006)(54906003)(83380400001)(316002)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 11:16:54.4182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e055a0f7-2d33-449e-24a0-08dc021656a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368

Consolidate per device update and flush logic into separate function.
Also make it as global function as it will be used in subsequent series
to update the DTE.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/iommu.c     | 26 ++++++++++++++++++--------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 2f6fba75e0ee..e8ac7826a14c 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -64,6 +64,7 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid);
 void amd_iommu_flush_all_caches(struct amd_iommu *iommu);
 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_update(struct protection_domain *domain);
+void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, bool set);
 void amd_iommu_domain_flush_complete(struct protection_domain *domain);
 void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 				  u64 address, size_t size);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d9050855496a..fe08b4cf446f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2025,6 +2025,21 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 	amd_iommu_apply_erratum_63(iommu, devid);
 }
 
+/* Update and flush DTE for the given device */
+void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, bool set)
+{
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
+
+	if (set)
+		set_dte_entry(iommu, dev_data);
+	else
+		clear_dte_entry(iommu, dev_data->devid);
+
+	clone_aliases(iommu, dev_data->dev);
+
+	device_flush_dte(dev_data);
+}
+
 static int do_attach(struct iommu_dev_data *dev_data,
 		     struct protection_domain *domain)
 {
@@ -2068,10 +2083,7 @@ static int do_attach(struct iommu_dev_data *dev_data,
 	}
 
 	/* Update device table */
-	set_dte_entry(iommu, dev_data);
-	clone_aliases(iommu, dev_data->dev);
-
-	device_flush_dte(dev_data);
+	amd_iommu_dev_update_dte(dev_data, true);
 
 	return ret;
 }
@@ -2092,11 +2104,9 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	/* Update data structures */
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
-	clear_dte_entry(iommu, dev_data->devid);
-	clone_aliases(iommu, dev_data->dev);
 
-	/* Flush the DTE entry */
-	device_flush_dte(dev_data);
+	/* Clear DTE and flush the entry */
+	amd_iommu_dev_update_dte(dev_data, false);
 
 	/* Flush IOTLB and wait for the flushes to finish */
 	amd_iommu_domain_flush_all(domain);
-- 
2.31.1

