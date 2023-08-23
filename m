Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46698BA48
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 12:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTsv2mFeId7xRNFX+/GLGOU6fWXJ2aQrxGlE3mijDadmFPGTqpnNKdzafGwZgbNvNXqtk96HPY9fRh14HUr36hFKdLymFiYifdI3UfQjXvbRP/fgjQIY/bNSUtGjivdM4vRXnxRQV5INI+niDY6XeMQWFnHfGZoCdJghj8/nImB3Dpxxd9ZylEBTq4mfA4Fexc4YTQHDx8J62hYGUkhGLH6easJWfe8qEeFAPTgOw9N8vPbaf6iMoheYpKT6VT/ys5wkZANrH4npdC9NcHQi3E4Z+aplSiD+ShHczDRXIY2S5hYvN2A7Rkf+cAeM8yi/e9+cZdcExKN/2gJ1sNnlgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Q2/8KOtLuAs63TjxWT0kAHU6/J9UfB/keabss/MpOs=;
 b=iMIO5GDTFRv9DF9z85Y+ZMjpuAkIM1ddasoogLZRzYgiiOUnmpIPXT4FEFXFnIHa4VBbqeevZuxYZokm0nI90sySLM4GxubOZJjXiWQ8mYskm51yfZjiF/0B8ioB96T//uAcune/5bl6TvH9mySh4prOzTScBcOnYFPUqN4IrKgV31sC++K90OpJx5XcT25hrlcJ5HUctCK0iMNKaO4qK7+IMoZgt0wdZKuz8omMUY6R3y9DEQKGGz8J6l1Bw8Z8YxYKA8aQvFRA2cQjj9/qfFTm3fHIV9mWcINwCJXFtZEydZHUpsfiP0nBDPLNYwrRD/EB9VgcbMiNZGhJ54pR1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Q2/8KOtLuAs63TjxWT0kAHU6/J9UfB/keabss/MpOs=;
 b=RBNVG6qylc/Bzrk+lNByXmDnCw8YiSn38HdZrV4tfw3e1rXRd49BmivQ9HgJMRitT7i0zmENHHTLzcHvEs5l67YRX5E55imGs4qvk661V4eICn/lyXiwNGydQ/qfycVJbuJB9tJy9a79LlYQoS+CdZ3bOVhskaqh8tcDfGxAPpE=
Received: from MW4PR03CA0256.namprd03.prod.outlook.com (2603:10b6:303:b4::21)
 by MW4PR12MB7381.namprd12.prod.outlook.com (2603:10b6:303:219::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 12:04:11 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::41) by MW4PR03CA0256.outlook.office365.com
 (2603:10b6:303:b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Wed, 23 Aug 2023 12:04:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 12:04:11 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 07:03:50 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>
Subject: [PATCH 02/10] dma/sdxi: Switch SDXI virtual address support from iommu_v2 to SVA
Date: Wed, 23 Aug 2023 12:02:13 +0000
Message-ID: <20230823120230.727935-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823120230.727935-1-vasant.hegde@amd.com>
References: <20230823120230.727935-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|MW4PR12MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 1411a9ea-a830-4043-7573-08dba3d11018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0Lz+qvcDTvHdP8LI8CzRavZxSmFdbNuxSFN12/ghxaFzrNDvIkdR+juYU1Hg0+d/CpYembYzCaAvyo3h85d273HOckU4MhVPvfZNr4A7TLMpxcXYQ3uJpN7M9y8obddSdSlGBfXIb7lDUpg0c/Y4L9ST5iipaZW1SYuUhTW7KH/vRj96F9QtMl+uUvh4MQohHmLWX7mU59kfS+3Wx6fP96nWGAtPlzUlEj4Jf38ZbRniodQdzpxI44CR0fI0XbQwqi+rV+IvdugaoFQendAPscU9PZMNYqPgNPnNYWnpXNd/pM+Suz9BByd8y8nygZ0jvnM/TrYizbEFaloxZoc4+mbZK/Nt+E88hu/GD7+xoBgJBvmS8he7qF0h3z969uFdXWxtpcdHtu0Adr7PKEnrCWV+QQPqhBdXduCP8v7tQMYForYEM4+qul7SHaiF2RlEszglFsRVOyO8uwT/mGR1UnaYpwmepVd79ejgkcDcBhzb1Efsepmz6ZU2Q0b2WGPME+FHPQewQdsp8m+k44vnWCl5XUR0s9LJdcKheIBnRiwu8eN/v/CVgvcac0zdo5MHFP4Dk3Zu+CetCVDstrceytjB3aVjbgnjtNXRk0emAijkVbfSLbIDK3j+OXkyH1eoDuCu2hN+SCZucVmW7vqSAkz2zfWy1zo4yjckb2d2hRaJPzP2+MYThvWWMQcBA4GlCBKDu6sQR7pJ3ch0gco5qnfPB57JQhMe/Mh1ht4sDYlPNIxcBWC6FcmPkjDujstEWzKeh0h5q/ZfkSbZ8PHD1Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(1800799009)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(54906003)(316002)(70586007)(70206006)(110136005)(8676002)(8936002)(2616005)(4326008)(36756003)(40460700003)(41300700001)(1076003)(356005)(81166007)(82740400003)(478600001)(6666004)(40480700001)(83380400001)(30864003)(2906002)(47076005)(7696005)(36860700001)(86362001)(426003)(336012)(44832011)(5660300002)(16526019)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 12:04:11.4087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1411a9ea-a830-4043-7573-08dba3d11018
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7381

From: Wei Huang <wei.huang2@amd.com>

Current SDXI uses iommu_v2 driver for user space's address support.
However this driver is AMD IOMMU specific. The upstream Linux creates
a new interface, called Shared Virtual Address (SVA). SVA has been
supported by different IOMMU devices. AMD is also adding support
for SVA in the IOMMU driver. This patch switches SDXI's virtual
address support from iommu_v2 to SVA.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/Makefile             |   2 +-
 drivers/dma/sdxi/core.c               |   2 +-
 drivers/dma/sdxi/ioctl.c              |   6 +-
 drivers/dma/sdxi/ioctl.h              |   2 +-
 drivers/dma/sdxi/pci.c                |   8 +-
 drivers/dma/sdxi/process.c            | 285 --------------------------
 drivers/dma/sdxi/sva.c                | 187 +++++++++++++++++
 drivers/dma/sdxi/{process.h => sva.h} |  47 +----
 8 files changed, 208 insertions(+), 331 deletions(-)
 delete mode 100644 drivers/dma/sdxi/process.c
 create mode 100644 drivers/dma/sdxi/sva.c
 rename drivers/dma/sdxi/{process.h => sva.h} (50%)

diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index dcb81f574a77..31c37e2357de 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_SDXI)	+= sdxi.o
 
-sdxi-objs := pci.o core.o sq.o dma.o ioctl.o process.o trace.o
+sdxi-objs := pci.o core.o sq.o dma.o ioctl.o trace.o sva.o
diff --git a/drivers/dma/sdxi/core.c b/drivers/dma/sdxi/core.c
index 187e2e0c660c..d3a2d984e1d9 100644
--- a/drivers/dma/sdxi/core.c
+++ b/drivers/dma/sdxi/core.c
@@ -18,7 +18,7 @@
 #include "sdxi.h"
 #include "pci.h"
 #include "sq.h"
-#include "process.h"
+#include "sva.h"
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
diff --git a/drivers/dma/sdxi/ioctl.c b/drivers/dma/sdxi/ioctl.c
index 6b926795dc03..4355099a9584 100644
--- a/drivers/dma/sdxi/ioctl.c
+++ b/drivers/dma/sdxi/ioctl.c
@@ -18,7 +18,7 @@
 #include <uapi/linux/sdxi.h>
 
 #include "ioctl.h"
-#include "process.h"
+#include "sva.h"
 #include "sdxi.h"
 #include "sq.h"
 
@@ -166,7 +166,7 @@ static int sdxi_ioctl_create_ctxt(struct file *filep, struct sdxi_process *p,
 	mutex_lock(&p->mutex);
 
 	p->ctxt = ctxt;
-	err = sdxi_bind_process_to_device(p);
+	err = sdxi_sva_bind_process(p);
 	if (err) {
 		err = -ESRCH;
 		goto err_bind_process;
@@ -203,7 +203,7 @@ static int sdxi_ioctl_close_ctxt(struct file *filep, struct sdxi_process *p,
 	mutex_lock(&p->mutex);
 
 	if (args->ctxt_id == p->ctxt->id) {
-		sdxi_unbind_process_to_device(p);
+		sdxi_sva_unbind_process(p);
 		//sdxi_working_ctxt_exit(p->ctxt);
 	}
 
diff --git a/drivers/dma/sdxi/ioctl.h b/drivers/dma/sdxi/ioctl.h
index dedafec37673..3f84f7a498fa 100644
--- a/drivers/dma/sdxi/ioctl.h
+++ b/drivers/dma/sdxi/ioctl.h
@@ -17,7 +17,7 @@
 #include <linux/workqueue.h>
 
 #include "sdxi.h"
-#include "process.h"
+#include "sva.h"
 
 #define SDXI_IOCTL_MAJOR_VER 0
 #define SDXI_IOCTL_MINOR_VER 2
diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
index db0ba908e4ea..d51c190a3cb7 100644
--- a/drivers/dma/sdxi/pci.c
+++ b/drivers/dma/sdxi/pci.c
@@ -15,7 +15,7 @@
 
 #include "sdxi.h"
 #include "pci.h"
-#include "process.h"
+#include "sva.h"
 
 LIST_HEAD(sdxi_device_list);
 
@@ -435,7 +435,7 @@ static int sdxi_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_dev_init;
 
-	ret = sdxi_iommu_device_init(sdxi);
+	ret = sdxi_sva_device_init(sdxi);
 	if (ret)
 		goto err_iommu_init;
 
@@ -446,7 +446,7 @@ static int sdxi_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 err_pci_enable:
-	sdxi_iommu_device_exit(sdxi);
+	sdxi_sva_device_exit(sdxi);
 err_iommu_init:
 	sdxi_device_exit(sdxi);
 err_dev_init:
@@ -461,7 +461,7 @@ static void sdxi_pci_remove(struct pci_dev *pdev)
 	struct sdxi_dev *sdxi = pci_get_drvdata(pdev);
 
 	sdxi_pci_disable(sdxi);
-	sdxi_iommu_device_exit(sdxi);
+	sdxi_sva_device_exit(sdxi);
 	sdxi_device_exit(sdxi);
 	sdxi_pci_exit(sdxi);
 	sdxi_device_free(sdxi);
diff --git a/drivers/dma/sdxi/process.c b/drivers/dma/sdxi/process.c
deleted file mode 100644
index e75c9af0a336..000000000000
--- a/drivers/dma/sdxi/process.c
+++ /dev/null
@@ -1,285 +0,0 @@
-/*
- * User space process management (IOMMU, PASID, etc.)
- *
- * Copyright (C) 2022 AMD, Inc. All rights reserved.
- *
- * Author: Wei Huang <wei.huang2@amd.com>
- */
-
-#include <linux/device.h>
-#include <linux/slab.h>
-#include <linux/pci.h>
-#include <linux/idr.h>
-#include <linux/dma-fence-array.h>
-#include <linux/amd-iommu.h>
-#include <linux/hashtable.h>
-#include <asm/mmu.h>
-
-#include "process.h"
-
-#define SDXI_PROCESS_LIST_SIZE	16
-static DEFINE_MUTEX(process_list_mutex);
-static DEFINE_HASHTABLE(process_list, SDXI_PROCESS_LIST_SIZE);
-static DEFINE_SRCU(process_list_srcu);
-
-/**********************/
-/* PROCESS MANAGEMENT */
-/**********************/
-static struct sdxi_process *find_process_by_mm(const struct mm_struct *mm)
-{
-	struct sdxi_process *process;
-
-	hash_for_each_possible_rcu(process_list, process, list,
-				   (uintptr_t)mm) {
-		if (process->mm == mm)
-			return process;
-	}
-
-	return NULL;
-}
-
-static struct sdxi_process *find_process(const struct task_struct *thread)
-{
-	struct sdxi_process *p;
-	int idx;
-
-	idx = srcu_read_lock(&process_list_srcu);
-	p = find_process_by_mm(thread->mm);
-	srcu_read_unlock(&process_list_srcu, idx);
-
-	return p;
-}
-
-/****************************/
-/* PROCESS PASID MANAGEMENT */
-/****************************/
-static u32 pasid_alloc(struct sdxi_dev *sdxi)
-{
-	u32 ret = 0;
-
-	ret = ida_simple_get(&sdxi->pasid_ida, 1, sdxi->pasid_limit,
-			     GFP_KERNEL);
-
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static void pasid_free(struct sdxi_dev *sdxi, u32 pasid)
-{
-	if (pasid)
-		ida_simple_remove(&sdxi->pasid_ida, pasid);
-}
-
-void sdxi_unref_process(struct sdxi_process *p)
-{
-	/* NB: more checking to be done here based on kref count */
-}
-
-struct sdxi_process *sdxi_get_process(struct task_struct *thread)
-{
-	struct sdxi_process *process;
-
-	if (!thread->mm)
-		return ERR_PTR(-EINVAL);
-
-	process = find_process(thread);
-	if (!process)
-		return ERR_PTR(-EINVAL);
-
-	return process;
-}
-
-int sdxi_bind_process_to_device(struct sdxi_process *process)
-{
-	struct sdxi_ctxt *ctxt = process->ctxt;
-	struct sdxi_dev *sdxi;
-	int err;
-
-	if (!ctxt)
-		return -EINVAL;
-
-	sdxi = ctxt->sdxi;
-	/* alloc pasid */
-	process->pasid = pasid_alloc(sdxi);
-	if (process->pasid == 0)
-		return -EBUSY;
-
-	/* NB: more code to be added such as power management */
-	err = amd_iommu_bind_pasid(sdxi->pdev, process->pasid,
-				   process->lead_thread);
-
-	if (err) {
-		pasid_free(sdxi, process->pasid);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-void sdxi_unbind_process_to_device(struct sdxi_process *process)
-{
-	struct sdxi_ctxt *ctxt = process->ctxt;
-
-	if (!ctxt)
-		return;
-	amd_iommu_unbind_pasid(ctxt->sdxi->pdev, process->pasid);
-	pasid_free(ctxt->sdxi, process->pasid);
-}
-
-struct sdxi_process *sdxi_create_process(struct file *filep)
-{
-	struct task_struct *thread = current;
-	struct sdxi_process *process;
-	int err = -ENOMEM;
-
-	mutex_lock(&process_list_mutex);
-
-	process = kzalloc(sizeof(*process), GFP_KERNEL);
-	if (!process)
-		return ERR_PTR(err);
-
-	mutex_init(&process->mutex);
-	process->mm = thread->mm;
-	process->lead_thread = thread->group_leader;
-	hash_add_rcu(process_list, &process->list, (uintptr_t)process->mm);
-	get_task_struct(process->lead_thread);
-	mutex_unlock(&process_list_mutex);
-
-	return process;
-}
-
-void sdxi_destroy_process(struct sdxi_process *process)
-{
-	if (!process)
-		return;
-
-	mutex_lock(&process_list_mutex);
-
-	put_task_struct(process->lead_thread);
-	hash_del_rcu(&process->list);
-	mutex_destroy(&process->mutex);
-	kfree(process);
-
-	mutex_unlock(&process_list_mutex);
-}
-
-/***************************/
-/* DEVICE IOMMU MANAGEMENT */
-/***************************/
-#if IS_REACHABLE(CONFIG_AMD_IOMMU_V2)
-static const u32 required_flags = AMD_IOMMU_DEVICE_FLAG_ATS_SUP |
-				  AMD_IOMMU_DEVICE_FLAG_PRI_SUP |
-				  AMD_IOMMU_DEVICE_FLAG_PASID_SUP;
-
-static void iommu_pasid_shutdown_cb(struct pci_dev *pdev, u32 pasid)
-{
-	pr_info("PASID shutdown called: device=%s, pasid=%d\n",
-		dev_name(&pdev->dev), pasid);
-}
-
-static int iommu_invalid_ppr_cb(struct pci_dev *pdev, u32 pasid,
-				unsigned long address, u16 flags)
-{
-	pr_info("Invalid ppr called: device=%s, pasid=%d\n",
-		dev_name(&pdev->dev), pasid);
-	return AMD_IOMMU_INV_PRI_RSP_INVALID;
-}
-
-/* Bind all processes of SDXI from IOMMU */
-static int iommu_bind_processes(struct sdxi_dev *sdxi)
-{
-	return 0;
-}
-
-/* Unbind all processes of SDXI from IOMMU */
-static void iommu_unbind_processes(struct sdxi_dev *sdxi)
-{
-}
-
-int sdxi_iommu_device_init(struct sdxi_dev *sdxi)
-{
-	struct pci_dev *pdev = sdxi->pdev;
-	struct amd_iommu_device_info info;
-	int err;
-
-	info.flags = 0;
-	err = amd_iommu_device_info(pdev, &info);
-	if (err < 0) {
-		pr_err("No IOMMU device info found\n");
-		return -ENODEV;
-	}
-
-	if ((info.flags & required_flags) != required_flags) {
-		pr_err_once("Require IOMMU flags ATS %i, PRI %i, PASID %i\n",
-			    (info.flags & AMD_IOMMU_DEVICE_FLAG_ATS_SUP) != 0,
-			    (info.flags & AMD_IOMMU_DEVICE_FLAG_PRI_SUP) != 0,
-			    (info.flags & AMD_IOMMU_DEVICE_FLAG_PASID_SUP) != 0);
-
-		return -ENODEV;
-	}
-
-	sdxi->pasid_limit = min_t(u32, sdxi->max_pasids, info.max_pasids);
-	/* According to design, IOMMU v2 will be picked automatically if device
-	 * supports PRI/ATS/PASID. Since SDXI device current doesn't declare
-	 * PRI/ATS/PASID, we have to force pasid_limit to IOMMU max_pasids.
-	 */
-	//sdxi->pasid_limit = sdxi->max_pasids;
-	err = amd_iommu_init_device(pdev, sdxi->pasid_limit);
-	if (err < 0) {
-		pr_err("Failed to init IOMMU for %s\n", dev_name(&pdev->dev));
-		return -ENXIO;
-	}
-
-	ida_init(&sdxi->pasid_ida);
-	sdxi->use_iommu_v2 = true;
-
-	return 0;
-}
-
-void sdxi_iommu_device_exit(struct sdxi_dev *sdxi)
-{
-	iommu_unbind_processes(sdxi);
-	amd_iommu_free_device(sdxi->pdev);
-}
-
-void sdxi_iommu_suspend(struct sdxi_dev *sdxi)
-{
-	if (!sdxi || !sdxi->use_iommu_v2)
-		return;
-
-	iommu_unbind_processes(sdxi);
-
-	amd_iommu_set_invalidate_ctx_cb(sdxi->pdev, NULL);
-	amd_iommu_set_invalid_ppr_cb(sdxi->pdev, NULL);
-	amd_iommu_free_device(sdxi->pdev);
-}
-
-int sdxi_iommu_resume(struct sdxi_dev *sdxi)
-{
-	int err;
-
-	if (!sdxi || !sdxi->use_iommu_v2)
-		return 0;
-
-	err = amd_iommu_init_device(sdxi->pdev, sdxi->pasid_limit);
-	if (err)
-		return -ENXIO;
-
-	amd_iommu_set_invalidate_ctx_cb(sdxi->pdev,
-					iommu_pasid_shutdown_cb);
-	amd_iommu_set_invalid_ppr_cb(sdxi->pdev,
-				     iommu_invalid_ppr_cb);
-
-	err = iommu_bind_processes(sdxi);
-	if (err) {
-		amd_iommu_set_invalidate_ctx_cb(sdxi->pdev, NULL);
-		amd_iommu_set_invalid_ppr_cb(sdxi->pdev, NULL);
-		amd_iommu_free_device(sdxi->pdev);
-		return err;
-	}
-
-	return 0;
-}
-#endif /* CONFIG_AMD_IOMMU_V2 */
diff --git a/drivers/dma/sdxi/sva.c b/drivers/dma/sdxi/sva.c
new file mode 100644
index 000000000000..76f677734d4a
--- /dev/null
+++ b/drivers/dma/sdxi/sva.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * User space process management (IOMMU, PASID, etc.)
+ *
+ * Copyright (C) 2022 AMD, Inc. All rights reserved.
+ *
+ * Author: Wei Huang <wei.huang2@amd.com>
+ */
+
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/idr.h>
+#include <linux/dma-fence-array.h>
+#include <linux/iommu.h>
+#include <linux/hashtable.h>
+#include <asm/mmu.h>
+
+#include "sva.h"
+
+#define SDXI_PROCESS_LIST_SIZE	16
+static DEFINE_MUTEX(process_list_mutex);
+static DEFINE_HASHTABLE(process_list, SDXI_PROCESS_LIST_SIZE);
+static DEFINE_SRCU(process_list_srcu);
+
+static struct sdxi_process *find_process_by_mm(const struct mm_struct *mm)
+{
+	struct sdxi_process *process;
+
+	hash_for_each_possible_rcu(process_list, process, list,
+				   (uintptr_t)mm) {
+		if (process->mm == mm)
+			return process;
+	}
+
+	return NULL;
+}
+
+static struct sdxi_process *find_process(const struct task_struct *thread)
+{
+	struct sdxi_process *p;
+	int idx;
+
+	idx = srcu_read_lock(&process_list_srcu);
+	p = find_process_by_mm(thread->mm);
+	srcu_read_unlock(&process_list_srcu, idx);
+
+	return p;
+}
+
+int sdxi_iommu_resume(struct sdxi_dev *sdxi)
+{
+	return 0;
+}
+
+void sdxi_iommu_suspend(struct sdxi_dev *sdxi)
+{
+}
+
+struct sdxi_process *sdxi_get_process(struct task_struct *thread)
+{
+	struct sdxi_process *process;
+
+	if (!thread->mm)
+		return ERR_PTR(-EINVAL);
+
+	process = find_process(thread);
+	if (!process)
+		return ERR_PTR(-EINVAL);
+
+	return process;
+}
+
+void sdxi_sva_unbind_process(struct sdxi_process *process)
+{
+	struct sdxi_ctxt *ctxt = process->ctxt;
+
+	if (!ctxt)
+		return;
+
+	if (!process->handle)
+		return;
+
+	iommu_sva_unbind_device(process->handle);
+	process->handle = NULL;
+}
+
+int sdxi_sva_bind_process(struct sdxi_process *process)
+{
+	struct sdxi_ctxt *ctxt = process->ctxt;
+	struct sdxi_dev *sdxi;
+	struct device *dev;
+	struct iommu_sva *handle;
+	u32 pasid;
+
+	if (!ctxt)
+		return -EINVAL;
+
+	sdxi = ctxt->sdxi;
+	dev = &sdxi->pdev->dev;
+
+	handle = iommu_sva_bind_device(dev, process->mm);
+	if (IS_ERR(handle))
+		return -EINVAL;
+
+	pasid = iommu_sva_get_pasid(handle);
+	if (pasid == IOMMU_PASID_INVALID) {
+		iommu_sva_unbind_device(handle);
+		return -ENODEV;
+	}
+
+	process->pasid = pasid;
+	process->handle = handle;
+
+	pr_info("bind process (pasid=0x%x) to dev=%s\n", process->pasid,
+	       dev_name(&sdxi->pdev->dev));
+
+	return 0;
+}
+
+struct sdxi_process *sdxi_create_process(struct file *filep)
+{
+	struct task_struct *thread = current;
+	struct sdxi_process *process;
+	int err = -ENOMEM;
+
+	mutex_lock(&process_list_mutex);
+
+	process = kzalloc(sizeof(*process), GFP_KERNEL);
+	if (!process)
+		return ERR_PTR(err);
+
+	mutex_init(&process->mutex);
+	process->mm = thread->mm;
+	process->lead_thread = thread->group_leader;
+	hash_add_rcu(process_list, &process->list, (uintptr_t)process->mm);
+	get_task_struct(process->lead_thread);
+	mutex_unlock(&process_list_mutex);
+
+	return process;
+}
+
+void sdxi_destroy_process(struct sdxi_process *process)
+{
+	if (!process)
+		return;
+
+	mutex_lock(&process_list_mutex);
+
+	put_task_struct(process->lead_thread);
+	hash_del_rcu(&process->list);
+	mutex_destroy(&process->mutex);
+	kfree(process);
+
+	mutex_unlock(&process_list_mutex);
+}
+
+int sdxi_sva_device_init(struct sdxi_dev *sdxi)
+{
+	struct pci_dev *pdev = sdxi->pdev;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_IOPF);
+	if (ret) {
+		dev_err(dev, "Failed to enable IOPF feature!\n");
+		return -EINVAL;
+	}
+
+	ret = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA);
+	if (ret) {
+		dev_err(dev, "Failed to enable SVA feature!\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void sdxi_sva_device_exit(struct sdxi_dev *sdxi)
+{
+	struct pci_dev *pdev = sdxi->pdev;
+	struct device *dev = &pdev->dev;
+
+	iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
+	iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_IOPF);
+}
+
diff --git a/drivers/dma/sdxi/process.h b/drivers/dma/sdxi/sva.h
similarity index 50%
rename from drivers/dma/sdxi/process.h
rename to drivers/dma/sdxi/sva.h
index 6e50719c7de8..af35f99ac1a2 100644
--- a/drivers/dma/sdxi/process.h
+++ b/drivers/dma/sdxi/sva.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * User space process management
  *
@@ -7,8 +8,8 @@
  *
  */
 
-#ifndef __SDXI_PROCESS_H
-#define __SDXI_PROCESS_H
+#ifndef __SDXI_SVA_H
+#define __SDXI_SVA_H
 
 #include <linux/mmu_notifier.h>
 #include <linux/mutex.h>
@@ -26,46 +27,20 @@ struct sdxi_process {
 	struct task_struct *lead_thread;
 	void *mm;				/* pointer to mm_struct */
 	struct mmu_notifier mmu_notifier;	/* mm_struct notifier */
+	struct iommu_sva *handle;
 
 	struct sdxi_ctxt *ctxt;
 	u32 pasid;				/* no meaning if !ctxt */
 };
 
-/* SDXI Device IOMMU Management */
-#if IS_REACHABLE(CONFIG_AMD_IOMMU_V2)
-int sdxi_iommu_device_init(struct sdxi_dev *sdxi);
-void sdxi_iommu_device_exit(struct sdxi_dev *sdxi);
-void sdxi_iommu_suspend(struct sdxi_dev *sdxi);
-int sdxi_iommu_resume(struct sdxi_dev *sdxi);
-#else
-static inline int sdxi_iommu_device_init(struct sdxi_dev *sdxi)
-{
-#if IS_MODULE(CONFIG_AMD_IOMMU_V2)
-	WARN_ONCE(1, "iommu_v2 module is not usable by SDXI");
-#endif
-	return 0;
-}
-
-static inline void sdxi_iommu_device_exit(struct sdxi_dev *sdxi)
-{
-}
-
-static inline void sdxi_iommu_suspend(struct sdxi_dev *sdxi)
-{
-}
-
-static inline int sdxi_iommu_resume(struct sdxi_dev *sdxi)
-{
-	return 0;
-}
-#endif /* CONFIG_AMD_IOMMU_V2 */
-
-/* User Process Management */
+int sdxi_sva_device_init(struct sdxi_dev *sdxi);
+void sdxi_sva_device_exit(struct sdxi_dev *sdxi);
 struct sdxi_process *sdxi_create_process(struct file *filep);
 void sdxi_destroy_process(struct sdxi_process *p);
-int sdxi_bind_process_to_device(struct sdxi_process *p);
-void sdxi_unbind_process_to_device(struct sdxi_process *p);
-void sdxi_unref_process(struct sdxi_process *p);
+int sdxi_sva_bind_process(struct sdxi_process *p);
+void sdxi_sva_unbind_process(struct sdxi_process *p);
 struct sdxi_process *sdxi_get_process(struct task_struct *thread);
+void sdxi_iommu_suspend(struct sdxi_dev *sdxi);
+int sdxi_iommu_resume(struct sdxi_dev *sdxi);
 
-#endif /* __SDXI_PROCESS_H */
+#endif /* __SDXI_SVA_H */
-- 
2.31.1

