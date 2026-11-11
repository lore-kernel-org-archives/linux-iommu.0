Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.26.1.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438537;
	b=n1xp0KRbod7kjGrD6+PB+8o/gO9NfwAUS9sdlwCf5uxsBHkjjYpNHxokL/HgrMIb7j/L
	 6aWNbJPt+kIFIeUZzGlPb3WJ9VxnttXIx7QZzw+OKFoXjMREz5FLCS/FAtz4Kx+8lkP9i
	 XEOWHHcVnqNzEY7ZUh9OoXLRbdvzerBbu1HLG7Oa3iUATMT4Gu+0OiQnEHlludEjbrzAm
	 dGS2L8trsXUw7ix6MaN6DO5Bu9Ef09lDW9irtOnenNkDkg8Awuz4J9tMw8BcnEyT8TUcj
	 xrqQqKum3BMPWc8y1vrGRMfFrTLwcbWEKAeF3+e7tJX4GeP747JrIpa4C0wMzwnvfiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438537;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=VUp4hSPJVd2nb6nX2jrCTXpj2VQXaacU9dBBzQGocbM=;
	b=N/IeSt9Fx8nnDg8NhTBcrOrpJwpC7Mn8MOM9LyKspLH3B7tpzKH1Wg/QKiE1/FwIh0eF
	 X3rHxv1pw354TPqNqjGWkve5vZxtcfo14HiwdIjGEPRgQlnJeZoEuU7CsekSGFcFTvqzi
	 cH1Q9ZLgSqrBN+PV29HcVj2AAn2M9wKQ/9666vNFDYDg4vP/uLfOQ4H9BFRGQV3/6sZ1u
	 VKSPwjGGfb9BO+PMYWwv8PPOJtqb0rgcznz7cztOQbkhEHcFQW1d441zhKpcec0qXP581
	 bhKSMhrY1KTHVNQeOiue5L0xhLwbxXG36kWusybURjrzMuBTUWtQc7rQXRklWu0PWlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=svJoIJu4;
	arc=none smtp.remote-ip=52.26.1.71
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ADC606A321
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 23:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5ADC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=svJoIJu4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794438535; x=1825974535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VUp4hSPJVd2nb6nX2jrCTXpj2VQXaacU9dBBzQGocbM=;
  b=svJoIJu4g0JJDYDwKukknQbdgHD56efypn03yGLbrCQklaoCQzXpN4m5
   n5eLkYKqrT+7NipXGCkyF9gsLEQ3vGRDWbbHekMYx5yzuwgIVDA0EcUcf
   rSFxht+SObIve2u7GtA/FiKiggRL40yp3iWDB4RMy0SF9BAm/xw/bkz8Z
   YQmVi6dmORCdR7u99VwxPy+vJXrajm8TDTSv/8Qmp6/QN5Nxu85Dp1q3V
   0pzR1pU68E9enxotbRTWPtlkrcqr8arEWULdaa6TTxXz5qY0/nFicnr1R
   o2+6PqCjhdCN33ibpwZNbo0z/eZhXxU2WihyeBrpZOvrR5JuWwaiPlP3d
   g==;
X-CSE-ConnectionGUID: GmQR3KdLSIK2VGL9i1Vgww==
X-CSE-MsgGUID: Lv8CQC79SS26CvRd2fhFtw==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33789838"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 23:08:55 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:12889]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.231:2525] with esmtp (Farcaster)
 id 03263252-400d-47dd-9ab4-f24010c32c62; Wed, 11 Nov 2026 23:08:55 +0000 (UTC)
X-Farcaster-Flow-ID: 03263252-400d-47dd-9ab4-f24010c32c62
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:08:54 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:08:52 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
CC: The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, <linux-doc@vger.kernel.org>, <iommu@lists.linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	<nh-open-source@amazon.com>, <linux-mm@kvack.org>, Jonathan Corbet
	<corbet@lwn.net>
Subject: [PATCH 31/40] nitro_enclaves: Map the doorbell window at probe
Date: Wed, 11 Nov 2026 22:59:35 +0000
Message-ID: <8a8052b1943deb9139d1244e43d519fec83acf5f.1794393491.git.graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1794300002.git.graf@amazon.com>
References: <cover.1794300002.git.graf@amazon.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

In preparation to support notifying a sandbox virtqueue from the parent,
map the doorbell window of the NE PCI device. The doorbell window is a
second MMIO BAR of the device holding an array of two-byte doorbells; a
write to the doorbell of a virtqueue tells the device that the queue has
data waiting for the sandbox.

A device that does not offer the window serves every enclave operation
that does not involve a virtqueue, so keep the mapping optional and let
probe carry on without it. Record the length of the window so that a
doorbell offset can be bounded against it.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virt/nitro_enclaves/ne_pci_dev.c | 17 +++++++++++++++++
 drivers/virt/nitro_enclaves/ne_pci_dev.h |  9 +++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/virt/nitro_enclaves/ne_pci_dev.c b/drivers/virt/nitro_enclaves/ne_pci_dev.c
index 4678799998f4a..b5a7ecfffb4b6 100644
--- a/drivers/virt/nitro_enclaves/ne_pci_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_pci_dev.c
@@ -1968,6 +1968,15 @@ static int ne_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto release_pci_regions;
 	}
 
+	/*
+	 * A device without a doorbell window serves every enclave operation
+	 * that does not involve a virtqueue, so carry on without one.
+	 */
+	ne_pci_dev->doorbell_base = pci_iomap(pdev, PCI_BAR_NE_DOORBELL, 0);
+	if (ne_pci_dev->doorbell_base)
+		ne_pci_dev->doorbell_len =
+			pci_resource_len(pdev, PCI_BAR_NE_DOORBELL);
+
 	pci_set_drvdata(pdev, ne_pci_dev);
 
 	atomic_set(&ne_pci_dev->cmd_reply_avail, 0);
@@ -2086,6 +2095,8 @@ static int ne_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ne_teardown_msix(pdev);
 iounmap_pci_bar:
 	pci_set_drvdata(pdev, NULL);
+	if (ne_pci_dev->doorbell_base)
+		pci_iounmap(pdev, ne_pci_dev->doorbell_base);
 	pci_iounmap(pdev, ne_pci_dev->iomem_base);
 release_pci_regions:
 	pci_release_regions(pdev);
@@ -2127,6 +2138,9 @@ static void ne_pci_remove(struct pci_dev *pdev)
 
 	pci_set_drvdata(pdev, NULL);
 
+	if (ne_pci_dev->doorbell_base)
+		pci_iounmap(pdev, ne_pci_dev->doorbell_base);
+
 	pci_iounmap(pdev, ne_pci_dev->iomem_base);
 
 	pci_release_regions(pdev);
@@ -2171,6 +2185,9 @@ static void ne_pci_shutdown(struct pci_dev *pdev)
 
 	pci_set_drvdata(pdev, NULL);
 
+	if (ne_pci_dev->doorbell_base)
+		pci_iounmap(pdev, ne_pci_dev->doorbell_base);
+
 	pci_iounmap(pdev, ne_pci_dev->iomem_base);
 
 	pci_release_regions(pdev);
diff --git a/drivers/virt/nitro_enclaves/ne_pci_dev.h b/drivers/virt/nitro_enclaves/ne_pci_dev.h
index 71aaa8f557679..5a92e0c565ba0 100644
--- a/drivers/virt/nitro_enclaves/ne_pci_dev.h
+++ b/drivers/virt/nitro_enclaves/ne_pci_dev.h
@@ -31,6 +31,10 @@
  * PCI_BAR_NE - Nitro Enclaves PCI device MMIO BAR.
  */
 #define PCI_BAR_NE		(0x03)
+/**
+ * PCI_BAR_NE_DOORBELL - Nitro Enclaves PCI device virtqueue doorbell BAR.
+ */
+#define PCI_BAR_NE_DOORBELL	(0x04)
 
 /**
  * DOC: Device registers in the NE PCI device MMIO BAR
@@ -724,6 +728,9 @@ struct ne_mux_binding {
  *				could not be made, and the calls that take it
  *				turn such a pointer down themselves, so it is
  *				kept as it came.
+ * @doorbell_base:		Virtqueue doorbell window of the PCI device, NULL
+ *				on a device that does not offer one.
+ * @doorbell_len:		Length of the virtqueue doorbell window.
  * @enclaves_list:		List of the enclaves managed by the PCI device.
  * @enclaves_list_mutex:	Mutex for accessing the list of enclaves.
  * @event_wq:			Work queue for handling out-of-band events
@@ -766,6 +773,8 @@ struct ne_pci_dev {
 	bool			failed;
 	wait_queue_head_t	cmd_reply_wait_q;
 	struct dentry		*debugfs_dir;
+	void __iomem		*doorbell_base;
+	resource_size_t		doorbell_len;
 	struct list_head	enclaves_list;
 	struct mutex		enclaves_list_mutex;
 	struct workqueue_struct	*event_wq;
-- 
2.47.1

