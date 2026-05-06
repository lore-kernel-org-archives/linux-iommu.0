Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BCF48034A
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080042; cv=none; b=qa4KFHTv/56lQTORGRbhX9HT8mU6vsZ3G3GMfV4tTOveuSuvl0udasoiApYxSD3h+TOLNxgif3Ke4rqYRtPuOWi0QnaVCX7HtjwdTi+owl3KVS8wO+VAkqwA6cVRNGUz9LF4UJd+j5xfvu1ikYQPBbZI2/nREeKGStx9cQq4VkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080042; c=relaxed/simple;
	bh=5QSrG8uyFlqtqP6YUioyrpIsxIJXtCSxXPzrOlmhMLQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBh2FWVO4um5MITAh9YZrS/TcE1Sde997I3D61QLICCWQTd6vNRkpexB031MqgLUvbieWdLsP34m7yYCrFOYZflkfZid5Vlmg9XVLgsAS4rta2oVmyCAMZvFd2s+kzgkzQZABtRhGIxPLXJaJnXkwhRrFUInYL0uZK+yfmrqDHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=H8ulOjQg; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="H8ulOjQg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1778080040; x=1809616040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=THA4cidGFiIxVnQs3sUzA501TDzMqX6r3pw4Amnlb4E=;
  b=H8ulOjQg4AJ+j66Yp2/dytOuufOyRqw5jWIg57LKNj2DlXd5dfHCTzyZ
   hcgP4W9QeR3sFyV7ig4AXKQOAv4delM/HIaVfKeAsCa8SqxlPGrTyHFoV
   88aIXpKaP8Y9fV6V68G1LVRaargD3Qn3dALrCsOW9jFNoi55nmabv8Sps
   aAwZGcgE76LVo6GQVBDLmhLNu/6R7TzIBl2lcUPbkC4FtciavclgD+kRa
   6uM0e0WnLnsRR9rmHjo+X4MGbjDtDjn3uuC884dyVEGbP4Abl5qeM9Gkg
   2V5yFJVLTaMJO73ZKegDXa/88eoKJTLbB/Q7LXP8VFxSVqjfaTwWbza89
   g==;
X-CSE-ConnectionGUID: 1aD+bz8tRSeOnHRS7jphcg==
X-CSE-MsgGUID: LvsHZRMPQ/6b7BI5j8mj1A==
X-IronPort-AV: E=Sophos;i="6.23,219,1770595200"; 
   d="scan'208";a="19005100"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 15:07:20 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:21127]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.92:2525] with esmtp (Farcaster)
 id a6f9a331-9067-463f-b4e5-231c90965ce5; Wed, 6 May 2026 15:07:20 +0000 (UTC)
X-Farcaster-Flow-ID: a6f9a331-9067-463f-b4e5-231c90965ce5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 6 May 2026 15:07:19 +0000
Received: from dev-dsk-yigitogu-1a-d17f6574.eu-west-1.amazon.com
 (172.19.100.7) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Wed, 6 May 2026
 15:07:17 +0000
From: Yigit Oguz <yigitogu@amazon.de>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
	<suravee.suthikulpanit@amd.com>
CC: <jgg@ziepe.ca>, <nicolinc@nvidia.com>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Yigit Oguz" <yigitogu@amazon.de>, Lilit Janpoladyan <lilitj@amazon.com>
Subject: [PATCH 3/3] iommu/amd: Add vendor:device ID to AMD IOMMU event logs
Date: Wed, 6 May 2026 15:05:39 +0000
Message-ID: <20260506150541.60467-4-yigitogu@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506150541.60467-1-yigitogu@amazon.de>
References: <20260506150541.60467-1-yigitogu@amazon.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add amd_iommu_devid_str() helper that formats PCI device identity as
SSSS:BB:DD.F VVVV:DDDD by looking up the pci_dev via
pci_get_domain_bus_and_slot. Falls back to SSSS:BB:DD.F when the
device is not found.

Before:
  AMD-Vi: Event logged [IO_PAGE_FAULT device=0000:41:00.0 domain=0x000a
  	address=0xe0000000 flags=0x0020]

After:
  AMD-Vi: Event logged [IO_PAGE_FAULT device=0000:41:00.0 8086:1533 domain=0x000a
  	address=0xe0000000 flags=0x0020]

Signed-off-by: Yigit Oguz <yigitogu@amazon.de>
Signed-off-by: Lilit Janpoladyan <lilitj@amazon.com>
Assisted-by: Claude:claude-4.6-opus
---
 drivers/iommu/amd/iommu.c | 94 ++++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 01171361f9bc..441b4a7e85d5 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -779,11 +779,34 @@ static void dump_command(unsigned long phys_addr)
 		pr_err("CMD[%d]: %08x\n", i, cmd->data[i]);
 }
 
+#define AMD_IOMMU_DEVID_SIZE	48
+
+static void amd_iommu_devid_str(struct amd_iommu *iommu, u16 devid, char *buf,
+				size_t size)
+{
+	struct pci_dev *pdev;
+
+	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id,
+					   PCI_BUS_NUM(devid), devid & 0xff);
+	if (pdev) {
+		snprintf(buf, size, "%04x:%02x:%02x.%x %04x:%04x",
+			 iommu->pci_seg->id, PCI_BUS_NUM(devid),
+			 PCI_SLOT(devid), PCI_FUNC(devid),
+			 pdev->vendor, pdev->device);
+		pci_dev_put(pdev);
+	} else {
+		snprintf(buf, size, "%04x:%02x:%02x.%x",
+			 iommu->pci_seg->id, PCI_BUS_NUM(devid),
+			 PCI_SLOT(devid), PCI_FUNC(devid));
+	}
+}
+
 static void amd_iommu_report_rmp_hw_error(struct amd_iommu *iommu, volatile u32 *event)
 {
 	struct iommu_dev_data *dev_data = NULL;
 	int devid, vmg_tag, flags;
 	struct pci_dev *pdev;
+	char devid_str[AMD_IOMMU_DEVID_SIZE];
 	u64 spa;
 
 	devid   = (event[0] >> EVENT_DEVID_SHIFT) & EVENT_DEVID_MASK;
@@ -796,15 +819,16 @@ static void amd_iommu_report_rmp_hw_error(struct amd_iommu *iommu, volatile u32
 	if (pdev)
 		dev_data = dev_iommu_priv_get(&pdev->dev);
 
+	amd_iommu_devid_str(iommu, devid, devid_str, sizeof(devid_str));
+
 	if (dev_data) {
 		if (__ratelimit(&dev_data->rs)) {
-			pci_err(pdev, "Event logged [RMP_HW_ERROR vmg_tag=0x%04x, spa=0x%llx, flags=0x%04x]\n",
-				vmg_tag, spa, flags);
+			pci_err(pdev, "Event logged [RMP_HW_ERROR device=%s vmg_tag=0x%04x, spa=0x%llx, flags=0x%04x]\n",
+				devid_str, vmg_tag, spa, flags);
 		}
 	} else {
-		pr_err_ratelimited("Event logged [RMP_HW_ERROR device=%04x:%02x:%02x.%x, vmg_tag=0x%04x, spa=0x%llx, flags=0x%04x]\n",
-			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			vmg_tag, spa, flags);
+		pr_err_ratelimited("Event logged [RMP_HW_ERROR device=%s vmg_tag=0x%04x, spa=0x%llx, flags=0x%04x]\n",
+			devid_str, vmg_tag, spa, flags);
 	}
 
 	if (pdev)
@@ -816,6 +840,7 @@ static void amd_iommu_report_rmp_fault(struct amd_iommu *iommu, volatile u32 *ev
 	struct iommu_dev_data *dev_data = NULL;
 	int devid, flags_rmp, vmg_tag, flags;
 	struct pci_dev *pdev;
+	char devid_str[AMD_IOMMU_DEVID_SIZE];
 	u64 gpa;
 
 	devid     = (event[0] >> EVENT_DEVID_SHIFT) & EVENT_DEVID_MASK;
@@ -831,13 +856,12 @@ static void amd_iommu_report_rmp_fault(struct amd_iommu *iommu, volatile u32 *ev
 
 	if (dev_data) {
 		if (__ratelimit(&dev_data->rs)) {
-			pci_err(pdev, "Event logged [RMP_PAGE_FAULT vmg_tag=0x%04x, gpa=0x%llx, flags_rmp=0x%04x, flags=0x%04x]\n",
-				vmg_tag, gpa, flags_rmp, flags);
+			pci_err(pdev, "Event logged [RMP_PAGE_FAULT device=%s vmg_tag=0x%04x, gpa=0x%llx, flags_rmp=0x%04x, flags=0x%04x]\n",
+				devid_str, vmg_tag, gpa, flags_rmp, flags);
 		}
 	} else {
-		pr_err_ratelimited("Event logged [RMP_PAGE_FAULT device=%04x:%02x:%02x.%x, vmg_tag=0x%04x, gpa=0x%llx, flags_rmp=0x%04x, flags=0x%04x]\n",
-			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			vmg_tag, gpa, flags_rmp, flags);
+		pr_err_ratelimited("Event logged [RMP_PAGE_FAULT device=%s vmg_tag=0x%04x, gpa=0x%llx, flags_rmp=0x%04x, flags=0x%04x]\n",
+			devid_str, vmg_tag, gpa, flags_rmp, flags);
 	}
 
 	if (pdev)
@@ -856,12 +880,15 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 {
 	struct iommu_dev_data *dev_data = NULL;
 	struct pci_dev *pdev;
+	char devid_str[AMD_IOMMU_DEVID_SIZE];
 
 	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id, PCI_BUS_NUM(devid),
 					   devid & 0xff);
 	if (pdev)
 		dev_data = dev_iommu_priv_get(&pdev->dev);
 
+	amd_iommu_devid_str(iommu, devid, devid_str, sizeof(devid_str));
+
 	if (dev_data) {
 		/*
 		 * If this is a DMA fault (for which the I(nterrupt)
@@ -872,9 +899,8 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 			/* Device not attached to domain properly */
 			if (dev_data->domain == NULL) {
 				pr_err_ratelimited("Event logged [Device not attached to domain properly]\n");
-				pr_err_ratelimited("  device=%04x:%02x:%02x.%x domain=0x%04x\n",
-						   iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid),
-						   PCI_FUNC(devid), domain_id);
+				pr_err_ratelimited("  device=%s domain=0x%04x\n",
+						   devid_str, domain_id);
 				goto out;
 			}
 
@@ -887,13 +913,12 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 		}
 
 		if (__ratelimit(&dev_data->rs)) {
-			pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
-				domain_id, address, flags);
+			pci_err(pdev, "Event logged [IO_PAGE_FAULT device=%s domain=0x%04x address=0x%llx flags=0x%04x]\n",
+				devid_str, domain_id, address, flags);
 		}
 	} else {
-		pr_err_ratelimited("Event logged [IO_PAGE_FAULT device=%04x:%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x]\n",
-			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			domain_id, address, flags);
+		pr_err_ratelimited("Event logged [IO_PAGE_FAULT device=%s domain=0x%04x address=0x%llx flags=0x%04x]\n",
+			devid_str, domain_id, address, flags);
 	}
 
 out:
@@ -909,6 +934,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	int count = 0;
 	u64 address, ctrl;
 	u32 pasid;
+	char devid_str[AMD_IOMMU_DEVID_SIZE];
 
 retry:
 	type    = (event[1] >> EVENT_TYPE_SHIFT)  & EVENT_TYPE_MASK;
@@ -934,24 +960,22 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 		return;
 	}
 
+	amd_iommu_devid_str(iommu, devid, devid_str, sizeof(devid_str));
+
 	switch (type) {
 	case EVENT_TYPE_ILL_DEV:
-		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x]\n",
-			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			pasid, address, flags);
+		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY device=%s pasid=0x%05x address=0x%llx flags=0x%04x]\n",
+			devid_str, pasid, address, flags);
 		dev_err(dev, "Control Reg : 0x%llx\n", ctrl);
 		dump_dte_entry(iommu, devid);
 		break;
 	case EVENT_TYPE_DEV_TAB_ERR:
-		dev_err(dev, "Event logged [DEV_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x "
-			"address=0x%llx flags=0x%04x]\n",
-			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			address, flags);
+		dev_err(dev, "Event logged [DEV_TAB_HARDWARE_ERROR device=%s address=0x%llx flags=0x%04x]\n",
+			devid_str, address, flags);
 		break;
 	case EVENT_TYPE_PAGE_TAB_ERR:
-		dev_err(dev, "Event logged [PAGE_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x pasid=0x%04x address=0x%llx flags=0x%04x]\n",
-			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			pasid, address, flags);
+		dev_err(dev, "Event logged [PAGE_TAB_HARDWARE_ERROR device=%s pasid=0x%04x address=0x%llx flags=0x%04x]\n",
+			devid_str, pasid, address, flags);
 		break;
 	case EVENT_TYPE_ILL_CMD:
 		dev_err(dev, "Event logged [ILLEGAL_COMMAND_ERROR address=0x%llx]\n", address);
@@ -962,14 +986,12 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 			address, flags);
 		break;
 	case EVENT_TYPE_IOTLB_INV_TO:
-		dev_err(dev, "Event logged [IOTLB_INV_TIMEOUT device=%04x:%02x:%02x.%x address=0x%llx]\n",
-			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			address);
+		dev_err(dev, "Event logged [IOTLB_INV_TIMEOUT device=%s address=0x%llx]\n",
+			devid_str, address);
 		break;
 	case EVENT_TYPE_INV_DEV_REQ:
-		dev_err(dev, "Event logged [INVALID_DEVICE_REQUEST device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x]\n",
-			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			pasid, address, flags);
+		dev_err(dev, "Event logged [INVALID_DEVICE_REQUEST device=%s pasid=0x%05x address=0x%llx flags=0x%04x]\n",
+			devid_str, pasid, address, flags);
 		break;
 	case EVENT_TYPE_RMP_FAULT:
 		amd_iommu_report_rmp_fault(iommu, event);
@@ -980,8 +1002,8 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	case EVENT_TYPE_INV_PPR_REQ:
 		pasid = PPR_PASID(*((u64 *)__evt));
 		tag = event[1] & 0x03FF;
-		dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x tag=0x%03x]\n",
-			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+		dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=%s pasid=0x%05x address=0x%llx flags=0x%04x tag=0x%03x]\n",
+			devid_str,
 			pasid, address, flags, tag);
 		break;
 	default:
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

