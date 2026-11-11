Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.13.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438367;
	b=LAoZsQOvMyRCJuTPGvebW7uPT0MkewZBOH7nE2ShK37UXn6161rPq48m9CphJe56P3Sr
	 AuY9Q94ybMirpjDbIV12zCO+jMfyoVXyqP9f3ErBsw+5MXuHLoMl6ua0gg+/RhoGCmgcF
	 6O4fcu7q5xBIg+tdvm8Ac3QatECZZCNOStnrTvt6z6T4u4F/I67tgc6v7Ixae6ArYCc7a
	 cCtbRt9/DC7t7iMg+vu9E9TGBM0kPxJhO4hKFYcF6mNiTHVzhnq8MXVn8JCShUbWh3nkH
	 +DcbQ26w8eBn/Df+1vZ1S2cpGuihKsJeDiPKx7UMRtVscCvlAYsA/yBsoQY7dwMj1SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438367;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=fCaLFa9CYkOFRFmXmg91FFIbm1J83UWVSYubqF58HyQ=;
	b=mwVJXVB305i3kJez6mGoplG6Ka0jLsh6yu2dGoCh1iclAteajNpSI8Lf0oGiGZfmvYpD
	 2+Dpc9bB808pVqwuQnlAznTxgdFItpq98+XFf+6BIDYV6thaZba91xlfiCybG2/V1FR++
	 vSJURLezFmVq+8H3/rFmgdgNrjcrkXUYR89I6X/ekwyohL/U6aqh1zdCTJbU9PdS5NkOJ
	 Y9OMK8nk9gFiDzBuXT/YKwVJMUATx4zfs3+ZCi5ZHaKCtuuHkdfrB898PtQctRycfqA6C
	 Bk25TBCcLzBX2p5IE7pjTBqiUifghD3sMkoM6cdd2v+w+Caf8MkN1En+aHUF8rnOGLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=WpFDdgqR;
	arc=none smtp.remote-ip=52.13.214.179
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F06606A324
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 23:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2F06606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=WpFDdgqR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794438366; x=1825974366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fCaLFa9CYkOFRFmXmg91FFIbm1J83UWVSYubqF58HyQ=;
  b=WpFDdgqRFFewnALReKa4fB1cfmd9RWgZELb0w+44fSa0EM/I56ShwNec
   h8ueFFzEJrHAyyJGmnSMTn7TadYBrbGE5c/5qLTMfanvrVlHd420Cvzg3
   1Uc9f65Jpe/YxT5Yl00WroH8Nu4nJj8sXWydA4apZiniuVVwS9fSMOzpf
   yue8IHkv9IuvdAzAGBwfc/Us1AY21YkqedSwAlOAumsimhgpo0pz1lQYC
   fJ4vefntJelPHBfxIxgCCjxwRw4qOfoQzaSDC8hQjSx3hioGzX0Ug8Kdw
   MARFV/I/DQ/e0hpw88Yp+sZO9J9E9RTm4z1uro5OguwBogSh98ciNcULz
   A==;
X-CSE-ConnectionGUID: 0TBGixifTAqA5XIk+1vZEA==
X-CSE-MsgGUID: b7/OhfvVRVuQVjUt6CjSDA==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33739341"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 23:06:04 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:29252]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.61:2525] with esmtp (Farcaster)
 id 6abf2343-3b58-41f0-98ab-3c293919f51b; Wed, 11 Nov 2026 23:06:04 +0000 (UTC)
X-Farcaster-Flow-ID: 6abf2343-3b58-41f0-98ab-3c293919f51b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:06:03 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:06:01 +0000
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
Subject: [PATCH 26/40] nitro_enclaves: Donate a bitmap page per multiplexed vector
Date: Wed, 11 Nov 2026 22:59:30 +0000
Message-ID: <7777b78690114ea0563ea42daaf930f15de8def8.1794393490.git.graf@amazon.com>
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

In preparation to support the interrupt multiplexer, give the device the
bitmaps it records events in. At probe, donate one zeroed page per
pooled vector by writing its address to the matching NE_MUX_DONATE_BASE
slot, and read the outcome from NE_MUX_DONATE_ERR. A page holds
NE_MUX_MAX_BITS queue bits. The device sets the bit of a queue and then
raises the vector even when other bits are set already, which the
dispatch code relies on.

On teardown, write NE_MUX_SHUTDOWN before the pages go back to the
allocator.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virt/nitro_enclaves/ne_pci_dev.c | 87 +++++++++++++++++++++++-
 drivers/virt/nitro_enclaves/ne_pci_dev.h | 50 ++++++++++++++
 2 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/nitro_enclaves/ne_pci_dev.c b/drivers/virt/nitro_enclaves/ne_pci_dev.c
index 05dd3040afbc3..0fafd42162f3a 100644
--- a/drivers/virt/nitro_enclaves/ne_pci_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_pci_dev.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/iopoll.h>
 #include <linux/jiffies.h>
 #include <linux/kstrtox.h>
@@ -550,6 +551,32 @@ static void ne_teardown_msix(struct pci_dev *pdev)
 	pci_free_irq_vectors(pdev);
 }
 
+/**
+ * ne_mux_teardown() - Take the interrupt multiplexer bitmaps back from the
+ *		       device.
+ * @pdev:	PCI device to take the multiplexer bitmaps back from.
+ *
+ * Context: Process context.
+ */
+static void ne_mux_teardown(struct pci_dev *pdev)
+{
+	struct ne_pci_dev *ne_pci_dev = pci_get_drvdata(pdev);
+	u32 i = 0;
+
+	if (!ne_pci_dev->mux)
+		return;
+
+	iowrite32(NE_MUX_SHUTDOWN_ON, ne_pci_dev->iomem_base + NE_MUX_SHUTDOWN);
+
+	for (i = 0; i < ne_pci_dev->mux_nr_vecs; i++)
+		free_page((unsigned long)ne_pci_dev->mux[i].bitmap);
+
+	kfree(ne_pci_dev->mux);
+
+	ne_pci_dev->mux = NULL;
+	ne_pci_dev->mux_nr_vecs = 0;
+}
+
 /**
  * ne_mux_setup() - Read the interrupt multiplexer geometry from the device.
  * @pdev:	PCI device to read the multiplexer geometry of.
@@ -561,6 +588,7 @@ static void ne_teardown_msix(struct pci_dev *pdev)
  * Context: Process context.
  * Return:
  * * 0 on success.
+ * * Negative return value on failure.
  */
 static int ne_mux_setup(struct pci_dev *pdev)
 {
@@ -568,6 +596,8 @@ static int ne_mux_setup(struct pci_dev *pdev)
 	int msix_nr_vecs = 0;
 	u32 nr_vecs = 0;
 	u32 vec_base = 0;
+	int rc = -EINVAL;
+	u32 i = 0;
 
 	if (!ne_pci_dev->has_vendor_cap)
 		return 0;
@@ -593,10 +623,54 @@ static int ne_mux_setup(struct pci_dev *pdev)
 		return 0;
 	}
 
+	ne_pci_dev->mux = kcalloc(nr_vecs, sizeof(*ne_pci_dev->mux),
+				  GFP_KERNEL);
+	if (!ne_pci_dev->mux)
+		return -ENOMEM;
+
 	ne_pci_dev->mux_nr_vecs = nr_vecs;
 	ne_pci_dev->mux_vec_base = vec_base;
 
+	for (i = 0; i < nr_vecs; i++) {
+		u16 donate_err = 0;
+
+		ne_pci_dev->mux[i].bitmap = (u64 *)get_zeroed_page(GFP_KERNEL);
+		if (!ne_pci_dev->mux[i].bitmap) {
+			rc = -ENOMEM;
+
+			goto teardown_mux;
+		}
+
+		/*
+		 * On a kernel without a 64-bit MMIO accessor this write is two
+		 * 32-bit writes, low half first, so the device sees a complete
+		 * address only once the high half has arrived. The device is
+		 * expected to take the donation from the high half and not from
+		 * the low one, which is also what lets the outcome be read back
+		 * right after.
+		 */
+		writeq(virt_to_phys(ne_pci_dev->mux[i].bitmap),
+		       ne_pci_dev->iomem_base + NE_MUX_DONATE_BASE +
+		       i * sizeof(u64));
+
+		donate_err = ioread16(ne_pci_dev->iomem_base +
+				      NE_MUX_DONATE_ERR);
+		if (donate_err) {
+			dev_err(&pdev->dev, "Error in bitmap donate for vector %u [err=%u]\n",
+				i, donate_err);
+
+			rc = -EIO;
+
+			goto teardown_mux;
+		}
+	}
+
 	return 0;
+
+teardown_mux:
+	ne_mux_teardown(pdev);
+
+	return rc;
 }
 
 /**
@@ -1648,7 +1722,12 @@ static int ne_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto teardown_msix;
 	}
 
-	ne_mux_setup(pdev);
+	rc = ne_mux_setup(pdev);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "Error in mux setup [rc=%d]\n", rc);
+
+		goto pci_dev_disable;
+	}
 
 	down_write(&ne_devs.lock);
 
@@ -1717,6 +1796,8 @@ static int ne_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ne_devs.ne_pci_dev = NULL;
 unlock_ne_devs:
 	up_write(&ne_devs.lock);
+pci_dev_disable:
+	ne_mux_teardown(pdev);
 	ne_pci_dev_disable(pdev);
 teardown_msix:
 	ne_teardown_msix(pdev);
@@ -1755,6 +1836,8 @@ static void ne_pci_remove(struct pci_dev *pdev)
 
 	ne_devs.ne_pci_dev = NULL;
 
+	ne_mux_teardown(pdev);
+
 	ne_pci_dev_disable(pdev);
 
 	ne_teardown_msix(pdev);
@@ -1797,6 +1880,8 @@ static void ne_pci_shutdown(struct pci_dev *pdev)
 
 	ne_devs.ne_pci_dev = NULL;
 
+	ne_mux_teardown(pdev);
+
 	ne_pci_dev_disable(pdev);
 
 	ne_teardown_msix(pdev);
diff --git a/drivers/virt/nitro_enclaves/ne_pci_dev.h b/drivers/virt/nitro_enclaves/ne_pci_dev.h
index aee22b4ed8b6e..2cef40c627f9f 100644
--- a/drivers/virt/nitro_enclaves/ne_pci_dev.h
+++ b/drivers/virt/nitro_enclaves/ne_pci_dev.h
@@ -94,6 +94,30 @@
  */
 #define NE_MUX_NUM_VECTORS	(0x01f0)
 
+/**
+ * NE_MUX_DONATE_ERR - (2 bytes) Register holding the outcome of the last
+ *		       interrupt multiplexer bitmap donation (Read-Only).
+ */
+#define NE_MUX_DONATE_ERR	(0x01f4)
+
+/**
+ * NE_MUX_SHUTDOWN - (4 bytes) Register to tell the device to stop using every
+ *		     donated interrupt multiplexer bitmap (Write-Only).
+ */
+#define NE_MUX_SHUTDOWN		(0x01f8)
+#define NE_MUX_SHUTDOWN_ON	(0x01)
+
+/**
+ * NE_MUX_DONATE_BASE - (8 bytes per pooled vector) Array of registers to hand
+ *			the device the bitmap of one pooled vector (Read/Write).
+ *
+ * The device sets the bit of an enclave queue in the bitmap of the vector that
+ * queue shares, and then raises that vector's interrupt. It raises for every
+ * bit it sets, whatever the bitmap holds at the time, so bits a driver leaves
+ * in a bitmap never keep a later kick from arriving.
+ */
+#define NE_MUX_DONATE_BASE	(0x0800)
+
 /**
  * DOC: Device MMIO buffer sizes
  */
@@ -163,6 +187,20 @@
  */
 #define NE_MUX_MAX_VECTORS	(256)
 
+/**
+ * NE_MUX_MAX_BITS - Largest number of enclave queues one pooled vector
+ *		     multiplexes, which is how many bits the page donated as its
+ *		     bitmap holds.
+ */
+#define NE_MUX_MAX_BITS		(PAGE_SIZE * BITS_PER_BYTE)
+
+/*
+ * A bitmap is read in u64 words, so the words that span NE_MUX_MAX_BITS bits
+ * have to stay inside the one page donated for it.
+ */
+static_assert(NE_MUX_MAX_BITS / BITS_PER_TYPE(u64) * sizeof(u64) <= PAGE_SIZE,
+	      "the bitmap of a pooled vector has to fit its donated page");
+
 /**
  * enum ne_pci_dev_cmd_type - Device command types.
  * @INVALID_CMD:		Invalid command.
@@ -605,6 +643,16 @@ struct ne_slot_pool_run {
 	unsigned long		nr_pages;
 };
 
+/**
+ * struct ne_mux_vec - Interrupt multiplexer state of one pooled MSI-X vector.
+ * @bitmap:			Page-sized bitmap in which the device sets a bit
+ *				for every enclave queue that signalled through
+ *				this vector.
+ */
+struct ne_mux_vec {
+	u64			*bitmap;
+};
+
 /**
  * struct ne_pci_dev - Nitro Enclaves (NE) PCI device.
  * @cmd_reply_avail:		Variable set if a reply has been sent by the
@@ -624,6 +672,7 @@ struct ne_slot_pool_run {
  *				capability, and with it the multiplexer and slot
  *				pool registers.
  * @iomem_base :		MMIO region of the PCI device.
+ * @mux:			Per-pooled-vector interrupt multiplexer state.
  * @mux_nr_vecs:		Number of MSI-X vectors in the interrupt
  *				multiplexer pool.
  * @mux_vec_base:		First MSI-X vector of the interrupt multiplexer
@@ -657,6 +706,7 @@ struct ne_pci_dev {
 	struct workqueue_struct	*event_wq;
 	bool			has_vendor_cap;
 	void __iomem		*iomem_base;
+	struct ne_mux_vec	*mux;
 	u32			mux_nr_vecs;
 	u32			mux_vec_base;
 	struct work_struct	notify_work;
-- 
2.47.1

