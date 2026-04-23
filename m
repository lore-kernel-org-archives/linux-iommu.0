Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1370137FF76
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 21:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979418; cv=none; b=q45cGQX7GMVS8VOoLmOOlfSzlA+1r2TWCOQG6QOqlly7aOUv5YYXDC2QpCR+y1Xm2+TKQatQx3+MCgPkNVDTd5p6DPwrqGvXZXwqZAtqd3rHR3hW/Kp3h1Qk2AUJVdcgIGAoLGSe/7sUoGSkYQFZD1BUOaM0RuX9gELQIRXSYyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979418; c=relaxed/simple;
	bh=t91HQYsvqO7GpxrInKPzJTXawhCo+mAVGsn6AWsa7oo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cUHiZb79zUxGTsY6yrnPo0xULeU7EA23grV03POnPFWFqcCURWt6KIwmuqumkmVd5SHwQGq5+9J4cg8HgAhMIG6Zpvzq3RNJOesSvh/x2wIfah1Rr/ToSX9BJcYyyrwtG4wUSdZXl52RIeL2tjAx69ALWFl01utlcVtIjc+k2rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CLIc8vky; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLIc8vky"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b465bf993cso73256095ad.1
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 14:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979411; x=1777584211; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eZtY+EWHg3/BRWz3H3Wx+cRr9MZM3880uCt4Dp7O+PI=;
        b=CLIc8vkyTNeEqG9jlP0V99VBTG+qxvr6nOPZmt5UzwTWwoDcXRUDcYgS/UX0NuyNE4
         iwolbveWz8A+0a6cYixjtfiGH/iEevSlBRzBkYPAD8l0At6sPXNSlGyIa2otcse62cBI
         8OjtaUWMdtkgsZFnsoBPzI/3grOyYp0AtucD6Q9qj1h4J3GP+O7Q8vUydxARXxA4ITWc
         fmLmnEqCIq+raVMXQlp+g4+WxGbbH9dYztG4unGXw9Kq3YRcnd1oea9mWlZfsziEir52
         QVk+nDw8QBU1/R8MBC24535H24MjB8u8NDWY54cAqgFXoTrOSH9BVpAbXL5pVP8lAS8C
         7trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979411; x=1777584211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZtY+EWHg3/BRWz3H3Wx+cRr9MZM3880uCt4Dp7O+PI=;
        b=TfHgE8BDh0MDmRXrUymiFPjbhuK9Kcg06ExinYFsTKJe3iJvOwAPUrrRMcZMUmZhQe
         sBV2nQ9hlAgZJK01Nzpq40o+zris2FSan5QjtnksIr0OFjNdxKvYLUWFzIxCjghY0GQj
         3wvUOq2fhhBPqrGO0NjIta8mI2NnkZotU5q/d3nAQawAK447L/HuIg+2RUShTXWtX5N4
         Q+Ie12qu7XoSZP/dVbuyfKrBXDysPEu10tzrfZCoUDcc76B7lmU1mHUwDnvW1Tho7xlF
         Vk7HjK5JqDJabgoYvj1ZC/zZa+N+BjU4XE4DRUhykCqLtoyEzUODVYvdUKn9pdd45bR2
         N09Q==
X-Gm-Message-State: AOJu0YzqLYvCJvzdvwHqivC6kI74aQ64exmwTYRxAxFcmMxlh1Uh/50o
	lWil9A3sJ0CDkOa57wdisKg9ms5AO1T0tzU40ka+Rn7BIlZcfA1w3srZOELBcEA9jJr2vn1H01r
	qUtLig+Sk0/7LZbNZmqLvqG89c1wCxePB1cj+fS1KBnVLqUd/28nyn5dstUewrm7xf9eNY4T9Oj
	UZRR/SORlk8qtOCnDheiZijJD3t6B5lvnpnUOXXAeEGqcODQ==
X-Received: from pghu17.prod.google.com ([2002:a63:ef11:0:b0:c74:321:201a])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3949:b0:39f:27ab:2438 with SMTP id adf61e73a8af0-3a08d90bdbamr33243244637.48.1776979410524;
 Thu, 23 Apr 2026 14:23:30 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:10 +0000
In-Reply-To: <20260423212316.3431746-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-7-dmatlack@google.com>
Subject: [PATCH v4 06/11] PCI: liveupdate: Auto-preserve upstream bridges
 across Live Update
From: David Matlack <dmatlack@google.com>
To: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

When a PCI device is preserved across a Live Update, all of its upstream
bridges up to the root port must also be preserved. This enables the PCI
core and any drivers bound to the bridges to manage bridges correctly
across a Live Update.

Notably, this will be used in subsequent commits to ensure that
preserved devices can continue performing memory transactions without a
disruption or change in routing.

To preserve bridges, the PCI core tracks the number of downstream
devices preserved under each bridge using a reference count in struct
pci_dev_ser. This allows a bridge to remain preserved until all its
downstream preserved devices are unpreserved or finish their
participation in the Live Update.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 149 +++++++++++++++++++++++++++++----------
 1 file changed, 111 insertions(+), 38 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index cf8cff134a75..88125f9a2c6b 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -106,6 +106,18 @@
  * If a misconfigured or unconfigured bridge is encountered during enumeration
  * while there are incoming preserved devices, it's secondary and subordinate
  * bus numbers will be cleared and devices below it will not be enumerated.
+ *
+ * PCI-to-PCI Bridges
+ * ==================
+ *
+ * Any PCI-to-PCI bridges upstream of a preserved device are automatically
+ * preserved when the device is preserved. The PCI core keeps track of the
+ * number of downstream devices that are preserved under a bridge so that the
+ * bridge is only unpreserved once all downstream devices are unpreserved.
+ *
+ * This enables the PCI core and any drivers bound to the bridge to participate
+ * in the Live Update so that preserved endpoints can continue issuing memory
+ * transactions during the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -233,25 +245,14 @@ static struct liveupdate_flb pci_liveupdate_flb = {
 	.compatible = PCI_LUO_FLB_COMPATIBLE,
 };
 
-int pci_liveupdate_preserve(struct pci_dev *dev)
+static int pci_liveupdate_preserve_device(struct pci_ser *ser, struct pci_dev *dev)
 {
-	struct pci_ser *ser;
-	int i, ret;
-
-	guard(mutex)(&pci_flb_outgoing_lock);
-
-	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
-	if (ret)
-		return ret;
+	int i;
 
-	if (!ser)
-		return -ENOENT;
-
-	if (dev->is_virtfn)
-		return -EINVAL;
-
-	if (dev->liveupdate_outgoing)
-		return -EBUSY;
+	if (dev->liveupdate_outgoing) {
+		dev->liveupdate_outgoing->refcount++;
+		return 0;
+	}
 
 	if (ser->nr_devices == ser->max_nr_devices)
 		return -ENOSPC;
@@ -281,11 +282,82 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
 
 	return -ENOSPC;
 }
+
+static void pci_liveupdate_unpreserve_path(struct pci_ser *ser, struct pci_dev *dev)
+{
+	struct pci_dev *upstream_bridge = dev->bus->self;
+	struct pci_dev_ser *dev_ser;
+
+	if (upstream_bridge)
+		pci_liveupdate_unpreserve_path(ser, upstream_bridge);
+
+	dev_ser = dev->liveupdate_outgoing;
+	if (!dev_ser) {
+		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
+		return;
+	}
+
+	if (--dev_ser->refcount == 0) {
+		pci_info(dev, "Device will no longer be preserved across next Live Update\n");
+		ser->nr_devices--;
+		memset(dev_ser, 0, sizeof(*dev_ser));
+		dev->liveupdate_outgoing = NULL;
+	}
+}
+
+static int pci_liveupdate_preserve_path(struct pci_ser *ser, struct pci_dev *dev)
+{
+	struct pci_dev *upstream_bridge = dev->bus->self;
+	int ret = 0;
+
+	if (upstream_bridge) {
+		ret = pci_liveupdate_preserve_path(ser, upstream_bridge);
+		if (ret)
+			return ret;
+	} else if (!pci_is_root_bus(dev->bus)) {
+		pci_err(dev, "Failed to preserve up to root port\n");
+		return -EINVAL;
+	}
+
+	ret = pci_liveupdate_preserve_device(ser, dev);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	if (upstream_bridge)
+		pci_liveupdate_unpreserve_path(ser, upstream_bridge);
+
+	return ret;
+}
+
+int pci_liveupdate_preserve(struct pci_dev *dev)
+{
+	struct pci_ser *ser;
+	int ret;
+
+	guard(mutex)(&pci_flb_outgoing_lock);
+
+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
+	if (ret)
+		return ret;
+
+	if (!ser)
+		return -ENOENT;
+
+	if (dev->is_virtfn)
+		return -EINVAL;
+
+	if (dev->liveupdate_outgoing)
+		return -EBUSY;
+
+	return pci_liveupdate_preserve_path(ser, dev);
+}
 EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
 
 void pci_liveupdate_unpreserve(struct pci_dev *dev)
 {
-	struct pci_dev_ser *dev_ser;
 	struct pci_ser *ser = NULL;
 	int ret;
 
@@ -296,19 +368,9 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
 	if (ret || !ser) {
 		pci_warn(dev, "Cannot unpreserve device without outgoing Live Update state\n");
 		return;
-
-	}
-
-	dev_ser = dev->liveupdate_outgoing;
-	if (!dev_ser) {
-		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
-		return;
 	}
 
-	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
-	ser->nr_devices--;
-	memset(dev_ser, 0, sizeof(*dev_ser));
-	dev->liveupdate_outgoing = NULL;
+	pci_liveupdate_unpreserve_path(ser, dev);
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
 
@@ -428,6 +490,25 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 		pci_liveupdate_flb_put_incoming();
 }
 
+static void pci_liveupdate_finish_path(struct pci_dev *dev)
+{
+	struct pci_dev *upstream_bridge = dev->bus->self;
+
+	if (upstream_bridge)
+		pci_liveupdate_finish_path(upstream_bridge);
+
+	/*
+	 * Decrement the refcount so this device does not get treated as an
+	 * incoming device again, e.g. in case pci_liveupdate_setup_device()
+	 * gets called again becase the device is hot-plugged.
+	 */
+	if (--dev->liveupdate_incoming->refcount)
+		return;
+
+	pci_info(dev, "Device is finished participating in Live Update\n");
+	dev->liveupdate_incoming = NULL;
+}
+
 void pci_liveupdate_finish(struct pci_dev *dev)
 {
 	if (!dev->liveupdate_incoming) {
@@ -435,15 +516,7 @@ void pci_liveupdate_finish(struct pci_dev *dev)
 		return;
 	}
 
-	pci_info(dev, "Device is finished participating in Live Update\n");
-
-	/*
-	 * Drop the refcount so this device does not get treated as an incoming
-	 * device again, e.g. in case pci_liveupdate_setup_device() gets called
-	 * again becase the device is hot-plugged.
-	 */
-	dev->liveupdate_incoming->refcount = 0;
-	dev->liveupdate_incoming = NULL;
+	pci_liveupdate_finish_path(dev);
 
 	/* Drop this device's reference on the incoming FLB. */
 	pci_liveupdate_flb_put_incoming();
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

