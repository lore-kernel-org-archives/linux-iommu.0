Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.162.73.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438331;
	b=GGe1eZZGtwbGvMbgfXEe7fnQTjJcrrEDSWp+PHACGVN9fEkluWAGtBBPMR+rCFi3I86m
	 0v6c7DwxShMs8RrVLR6Uikyh24G9FlG+HEr4dv0zngSsIZODULDxQpOvEKhGdYrFb12T5
	 SO930ha29ToOquSEf5dzT/Cp0+9Knbc0bmINR0PWF27JDDybcOgrV/o9tWB0Ta8NFXOdS
	 SsqnzTHGxPm1ajegPa18XguHgbWcfPxWXknyLQWFqvMaHttoGzraDOlbz2QV3wFCffp5x
	 zjlPz88agSkXM7xXe8w1OW2IAYY4A/9mGBVfjC5K/TzMivWN/YSRV19C5IfD9j8CedA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438331;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=WVsRJFejlalfnGx+DVuzjX9D+Tuo+9KGp3cwLygC1Hc=;
	b=pSFqxqabsSCCKZD5TWLzrizsrhGk1KgcLUs5iEE6R1SQ4C4bfZVu6PHqFaCzq/i071Pn
	 hdGY5qY1OOFzvWipwekACLJj8pTXZuoalJwgqfDTBEw0W4tcj3mpACsMfwKCLTZ7WLTJh
	 5JvVlaXFZqLxEB7MF+uXm+j8+vtTY1XlgwDv7HTsNFxys7/KeXBQEezk598FGLKuN1EmV
	 /mheQ/UdgFwar1yOFBMhdtv/G0T+umk7AV+s9bOM4p1pfoPEQTtL6R1yRJtu0RFEOHs3r
	 fdqnLa9FWB64sjuKT4aPWbO9Qxv3+4wYWXXSs7R6x+j1D6C+YBBvj2ECD7vgKyw7hZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=R4QuR9CM;
	arc=none smtp.remote-ip=35.162.73.231
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D53606A31C
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 23:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6D53606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=R4QuR9CM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794438330; x=1825974330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WVsRJFejlalfnGx+DVuzjX9D+Tuo+9KGp3cwLygC1Hc=;
  b=R4QuR9CMzbWMaZ88S3T+ERGbXrC2NLRa/GjRja2OclnyP2u8v8qC9qsj
   A9+AE6rgkXkKW1NwtjjokWROX3RyLf5XRiksMIr4J06z/dOx2bVn3ljzk
   c1sB7t3xe6fd0nOzOW1valUkyIMhW7/zL3I6TQoAjvaLJBLtSOq3zB5l3
   MTOsAaddbFWGc0qWjYYdHhW2XCiB09VRSMcDWAST40H5mB6K84CCgtlcq
   DoE8mJizARMISS8mw9zEIirFG4WoFkK4HY2ZhMKS/FHKxXjgnozdYjiH1
   dhIr16/isOdnu+TV+TeCBaqRW7FaesrDozk2lhEOayLtV4GMb/Bj+1Chs
   g==;
X-CSE-ConnectionGUID: RSrBKcr1SjCY4ASv0S8OpA==
X-CSE-MsgGUID: PmJMOBprTRy6hyVlxLuJDg==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33573525"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 23:05:30 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:25542]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.255:2525] with esmtp (Farcaster)
 id 829b92ef-b808-42f4-90f9-68ea19d9a49d; Wed, 11 Nov 2026 23:05:30 +0000 (UTC)
X-Farcaster-Flow-ID: 829b92ef-b808-42f4-90f9-68ea19d9a49d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:05:29 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:05:27 +0000
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
Subject: [PATCH 25/40] nitro_enclaves: Read the interrupt multiplexer geometry at probe
Date: Wed, 11 Nov 2026 22:59:29 +0000
Message-ID: <8937871aae7d02a883af18bd9a8b0f5f3c8d39c6.1794393490.git.graf@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

In preparation to support per-virtqueue events for Nitro Sandboxes, read
the geometry of the interrupt multiplexer at probe. The interrupt
multiplexer is built into the nitro_enclaves device. It is a pool of
MSI-X vectors that the device shares between the virtqueues of every
sandbox: it raises a pooled vector and records in a bitmap which queues
signalled. NE_MUX_NUM_VECTORS holds the size of the pool and
NE_MUX_VECTOR_BASE its first vector.

Read them only on a device with the PCI vendor-specific capability that
defines them. Leave the pool unused when it is larger than
NE_MUX_MAX_VECTORS or than the vectors of the device, or when it
overlaps the reply and event vectors.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virt/nitro_enclaves/ne_pci_dev.c | 60 ++++++++++++++++++++++--
 drivers/virt/nitro_enclaves/ne_pci_dev.h | 27 ++++++++++-
 2 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/drivers/virt/nitro_enclaves/ne_pci_dev.c b/drivers/virt/nitro_enclaves/ne_pci_dev.c
index 1aa4d5508dabf..05dd3040afbc3 100644
--- a/drivers/virt/nitro_enclaves/ne_pci_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_pci_dev.c
@@ -550,6 +550,55 @@ static void ne_teardown_msix(struct pci_dev *pdev)
 	pci_free_irq_vectors(pdev);
 }
 
+/**
+ * ne_mux_setup() - Read the interrupt multiplexer geometry from the device.
+ * @pdev:	PCI device to read the multiplexer geometry of.
+ *
+ * The multiplexer registers only exist on a device that publishes a
+ * vendor-specific capability, so a device without one leaves the pool unused
+ * and reads no multiplexer register at all.
+ *
+ * Context: Process context.
+ * Return:
+ * * 0 on success.
+ */
+static int ne_mux_setup(struct pci_dev *pdev)
+{
+	struct ne_pci_dev *ne_pci_dev = pci_get_drvdata(pdev);
+	int msix_nr_vecs = 0;
+	u32 nr_vecs = 0;
+	u32 vec_base = 0;
+
+	if (!ne_pci_dev->has_vendor_cap)
+		return 0;
+
+	nr_vecs = ioread16(ne_pci_dev->iomem_base + NE_MUX_NUM_VECTORS);
+	if (!nr_vecs)
+		return 0;
+
+	vec_base = ioread16(ne_pci_dev->iomem_base + NE_MUX_VECTOR_BASE);
+	msix_nr_vecs = pci_msix_vec_count(pdev);
+
+	/*
+	 * An enclave whose queues cannot reach the pool binds them to the
+	 * reply and event vectors instead, which costs interrupt throughput
+	 * and no functionality. Refusing to probe would take Nitro Enclaves
+	 * away from the parent altogether.
+	 */
+	if (nr_vecs > NE_MUX_MAX_VECTORS || vec_base <= NE_VEC_EVENT ||
+	    msix_nr_vecs < 0 || vec_base + nr_vecs > (u32)msix_nr_vecs) {
+		dev_dbg(&pdev->dev, "Unusable multiplexer pool of %u vectors at vector %u\n",
+			nr_vecs, vec_base);
+
+		return 0;
+	}
+
+	ne_pci_dev->mux_nr_vecs = nr_vecs;
+	ne_pci_dev->mux_vec_base = vec_base;
+
+	return 0;
+}
+
 /**
  * ne_pci_dev_enable() - Select the PCI device version and enable it.
  * @pdev:	PCI device to select version for and then enable.
@@ -1574,10 +1623,11 @@ static int ne_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ne_pci_dev->pdev = pdev;
 
 	/*
-	 * The registers past the command interface only exist on a device that
-	 * publishes a vendor-specific capability, and a read of a register the
-	 * device does not implement has no defined value. The answer holds for
-	 * the life of the device, so look it up once here.
+	 * Launch flags, the multiplexer and the slot pool registers are
+	 * implemented by a device that publishes a vendor-specific capability,
+	 * and a read of a register the device does not implement has no defined
+	 * value. The answer holds
+	 * for the life of the device, so look it up once here.
 	 */
 	ne_pci_dev->has_vendor_cap =
 		pci_find_capability(pdev, PCI_CAP_ID_VNDR) != 0;
@@ -1598,6 +1648,8 @@ static int ne_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto teardown_msix;
 	}
 
+	ne_mux_setup(pdev);
+
 	down_write(&ne_devs.lock);
 
 	/*
diff --git a/drivers/virt/nitro_enclaves/ne_pci_dev.h b/drivers/virt/nitro_enclaves/ne_pci_dev.h
index a0bca5863e2a1..aee22b4ed8b6e 100644
--- a/drivers/virt/nitro_enclaves/ne_pci_dev.h
+++ b/drivers/virt/nitro_enclaves/ne_pci_dev.h
@@ -54,6 +54,12 @@
  */
 #define NE_COMMAND		(0x0004)
 
+/**
+ * NE_MUX_VECTOR_BASE - (2 bytes) Register holding the first MSI-X vector of
+ *			the interrupt multiplexer pool (Read-Only).
+ */
+#define NE_MUX_VECTOR_BASE	(0x0008)
+
 /**
  * NE_EVTCNT - (4 bytes) Register to notify the driver that a reply or a device
  *	       event is available (Read-Only):
@@ -82,6 +88,12 @@
  */
 #define NE_RECV_DATA		(0x0100)
 
+/**
+ * NE_MUX_NUM_VECTORS - (2 bytes) Register holding the number of MSI-X vectors
+ *			in the interrupt multiplexer pool (Read-Only).
+ */
+#define NE_MUX_NUM_VECTORS	(0x01f0)
+
 /**
  * DOC: Device MMIO buffer sizes
  */
@@ -146,6 +158,11 @@
  */
 #define NE_VEC_EVENT		(1)
 
+/**
+ * NE_MUX_MAX_VECTORS - Largest interrupt multiplexer pool the driver accepts.
+ */
+#define NE_MUX_MAX_VECTORS	(256)
+
 /**
  * enum ne_pci_dev_cmd_type - Device command types.
  * @INVALID_CMD:		Invalid command.
@@ -604,9 +621,13 @@ struct ne_slot_pool_run {
  *				enclave state scanning and propagation to the
  *				enclave process.
  * @has_vendor_cap:		Whether the PCI device publishes a vendor-specific
- *				capability, and with it the registers past the
- *				command interface.
+ *				capability, and with it the multiplexer and slot
+ *				pool registers.
  * @iomem_base :		MMIO region of the PCI device.
+ * @mux_nr_vecs:		Number of MSI-X vectors in the interrupt
+ *				multiplexer pool.
+ * @mux_vec_base:		First MSI-X vector of the interrupt multiplexer
+ *				pool.
  * @notify_work:		Work item for every received out-of-band event.
  * @pci_dev_mutex:		Mutex for accessing the PCI device MMIO space.
  * @pdev:			PCI device data structure.
@@ -636,6 +657,8 @@ struct ne_pci_dev {
 	struct workqueue_struct	*event_wq;
 	bool			has_vendor_cap;
 	void __iomem		*iomem_base;
+	u32			mux_nr_vecs;
+	u32			mux_vec_base;
 	struct work_struct	notify_work;
 	struct mutex		pci_dev_mutex;
 	struct pci_dev		*pdev;
-- 
2.47.1

