Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BBFC131
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 14:07:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVmhmdspz55BRivLLa3AhBNXYS3lDnZVSxEHA1jrtvMQY5oGXoPPJhAnVzmbAAy+mNCA5btc2pta73P3DD1nU07pIzC6fl8L9spV1rOAdAgPppWb2Gyy8JiIRAltE354OKvSn9oo7srtg5G+TYQ3YuCA6nX3O2EMvt6QEfGOdijHSgd1QSGX6lKkIyU0iApsojdc1R2bqRrs24oQf/cCCZosqNr9fiH10R5plDaS8FPyfjLujVVJjYTkYW0PHL5CPCUwn20yKVK2hXG6pxczL2K4Gr4PKzJjrrfNAmQ0lOPLAhBrN9s1kDXw/zrLXzMrdkcu6i0TIKRPVOINxCi1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtWksWB/E516cljUkNd1uEt9SCHl6pw7D4LCkl4eZ50=;
 b=GQYPAazrCQ5o4DDnT15qw2JAxQN5idd5WOpduTSgYxT+TknMnEJvCLsHvE8qw3BbBe6NVxpFbbwcJRqD8H243UIr/imHR0BFIq0lgLPtCofVWuATnklTp0QXUGVdC0aFrTdCZ6zhvkOhx5oSbGGRO+tCl3QutL/VoaA3y//QSmIBNZdlf3Wg0SnsNOrU1lCqE8ICiF9T1cGDX8TfLHZ1++M4j064Ip2EpQy4mTKwfrhZIqYT37uMv9EM4K0q+0RlzGbp87l5VLKaTOpL0UCSlAyMXZgakvZ2NeR0SgCdYJR5GJmTKBUMmo10IwO29OB9iUi85rO7iiLfXzq+gi6h9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtWksWB/E516cljUkNd1uEt9SCHl6pw7D4LCkl4eZ50=;
 b=2vWLMOBTUusnth3ANxLFpXGHF7IF1s3l+uk9AAAJVPfPWzI7QcGC8lXk3NFMTnDRxr8LRsMTYKRdyUPKXUT2BvQrk50EmuKW8Bg5ck7R3WCwO6GV4HZEdtsKwmgi0ZplAP7afu+ulpQmV5iFmkv0nZVFxVH5XM5/5C84Xa7aHDI=
Received: from MW4PR03CA0355.namprd03.prod.outlook.com (2603:10b6:303:dc::30)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 14:06:59 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::8f) by MW4PR03CA0355.outlook.office365.com
 (2603:10b6:303:dc::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 14:06:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 14:06:58 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 09:06:55 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH RESEND 08/10] iommu/amd: Add support for add/remove device for IOPF
Date: Wed, 23 Aug 2023 14:04:13 +0000
Message-ID: <20230823140415.729050-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823140415.729050-1-vasant.hegde@amd.com>
References: <20230823140415.729050-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: bead9e45-4aa5-40bf-2145-08dba3e23762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2EduZzDY3NgnA7Gw9JZLAdILPCyOYFfGDG+dyxVNszFwUxNpvSp/PS8YnQsP3nZhBPIRkgBiq3cmwal7PjUzriKyNeItOhrTHkBg4ugupXZ8/4MrlCeS+FVcRC4QkR7zaFf/iCbwh8ovFeTsPxV3qWNTsA+UWIsU58Yw8UA25iAIa4mz34Jlr0ZezrqXFtsM/uLey0U1+gDbM2VE3cFvMK7p/+HWJdCrmxr8XfFkyUts7MCLJ1O0WRZpdEkWrC5ofJQb3GuRWoXy4JvluTiFt6JiTiqUo929aRdp162Q19RPdCw/oYneOxeRPuoVJEm15e0FdbjSLkvzc0fUqAUl0q3U2RIILNIqqoN0vAwhiJwvMsCVDc3Smz2NyHMztyJvcf6onK/wDIjTaTy3akX8DFChQPtPJXQjNUV/lapy6YGXXrru2mWEe3DU+qlk1XHmzsYLproI6YL9wBt9kzBC8kNuE60rqYKOo6gFOvxBUuZl9GB6V/90NGNVstsN1yYqxRZK5z2J5d/9kHDnzkvuHak1eljnPpsk4YMXohXYnFZq+FueAuP0Iy3oiByg/T7fn2gWRLe96gy7hbkD/HXpQU1NG0b0K+vezOBoFp/l/M8eoZukWSXuGYQxIawT4zoXFshIpDYXdtd7Njjfl0lfFxXWFH1DS+X07RIsiovqVzVdfh6Qh26Gwqc52iHF1Ksxbm8nYWF9ON7DLgVG/5M680BiuuBhCTRTUdBPr6DwbBmcznKuujCcSzPH7oK1QtrmsEbHZQM/mYHF1oWEgYY2jw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(70586007)(70206006)(54906003)(110136005)(44832011)(5660300002)(2616005)(41300700001)(316002)(2906002)(478600001)(86362001)(8676002)(4326008)(8936002)(81166007)(6666004)(40460700003)(82740400003)(356005)(7696005)(336012)(426003)(1076003)(36756003)(83380400001)(36860700001)(16526019)(26005)(40480700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:06:58.8608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bead9e45-4aa5-40bf-2145-08dba3e23762
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452

From: Wei Huang <wei.huang2@amd.com>

Which adds/removes the device to the corresponding per-IOMMU iopf_queue.
It also registers device fault handler. These interfaces are called
from IOPF feature enable/disable path.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  2 ++
 drivers/iommu/amd/ppr.c       | 50 +++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 167541bdcf1d..85b9ed9b350a 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -60,6 +60,8 @@ int amd_iommu_sva_gcr3_uninit(struct iommu_dev_data *dev_data);
 /* IOPF */
 int amd_iommu_iopf_init(struct amd_iommu *iommu);
 void amd_iommu_iopf_uninit(struct amd_iommu *iommu);
+int amd_iommu_iopf_add_device(struct amd_iommu *iommu, struct device *dev);
+int amd_iommu_iopf_remove_device(struct amd_iommu *iommu, struct device *dev);
 int amd_iommu_page_response(struct device *dev,
 			    struct iommu_fault_event *event,
 			    struct iommu_page_response *resp);
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 8cbcdb9c1669..2e5ca4847eda 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -168,3 +168,53 @@ int amd_iommu_page_response(struct device *dev,
 	return amd_iommu_complete_ppr(pdev, resp->pasid, resp->code,
 				      resp->grpid);
 }
+
+int amd_iommu_iopf_add_device(struct amd_iommu *iommu, struct device *dev)
+{
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	raw_spin_lock_irqsave(&iommu->lock, flags);
+
+	if (!iommu->iopf_queue)
+		goto out;
+
+	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
+	if (ret)
+		goto out;
+
+	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
+	if (ret)
+		iopf_queue_remove_device(iommu->iopf_queue, dev);
+
+out:
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+	return ret;
+}
+
+int amd_iommu_iopf_remove_device(struct amd_iommu *iommu, struct device *dev)
+{
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	raw_spin_lock_irqsave(&iommu->lock, flags);
+
+	if (!iommu->iopf_queue)
+		goto out;
+
+	ret = iommu_unregister_device_fault_handler(dev);
+	if (ret) {
+		pr_warn("Failed to unregister device (0x%x) fault handler\n",
+			dev->id);
+	}
+
+	ret = iopf_queue_remove_device(iommu->iopf_queue, dev);
+	if (ret) {
+		pr_warn("Failed to remove device (0x%x) from iopf queue\n",
+			dev->id);
+	}
+
+out:
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+	return ret;
+}
-- 
2.31.1

