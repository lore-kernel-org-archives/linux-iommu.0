Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8485A3921C3
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979422; cv=none; b=YWl69ssE7x8qGzUExtvwKpL+ebZFqqYMcSZm0pqWkhfozfsOUUsdxeyuiBs76ChHz4rfr3XCBKqdXs72ifUq2Hn/95RfTD8DUB9GmLzVmjwcziZZYxj7hZ+jtmI20M7mH17L613/a9o3Q8c7bNckNEQ1k7TNXBncO+rONgEatpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979422; c=relaxed/simple;
	bh=GLaesJwUwri2XBQC98JUEA4yA/xfrELrLuoXDywngTA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nLn2DAyMDSbdQGXh6ht62GHVXtb4cPPiijh3Ketp8QhGkIjVKjy11RYSXBEwWqhsFRp9sNIOhpfN3J1EjNIRFM3MbdLQJeDaAppcJowC/TQBhAsTEvXjiOR4k8x/BeJsLcPOKIRdCwKpjjg4g/htb72U5F3JefOAT84tR4I/3hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=USPc3a12; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USPc3a12"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bce224720d8so4148506a12.1
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 14:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979414; x=1777584214; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xzr76OgKRSVyLlNPZ4BBmoEisHfu3frnnsSEc+2qgNA=;
        b=USPc3a12JfuJPjRRORr8gAGgbWyvIx2LXFyso/3dwyxaZ80G/lfSD/SGmYDpXmVOv7
         JAILRNs1zz/wD1OD4jHLpcKkArGtXtrJ/tqUnb3yPWQS/QCEdvAWaJYMD3YSSopS2Ld2
         qnze6raFP+M29Ag9dHkQwUOqR28Kc/3L1T1WoynR0OZJ+odc0Npc4G2QFl337jYQpfDL
         ndSPdd0biQMBt126eIfoL8lPQomJ+nEoAaZewWjimG3caLPz3X3Lu3+tGUtF5/W9suXX
         z/1fsfMxJipU3lndB5+0l6sjpQvtdx+imW/VSWTUyiP1p8Y9hAHNXt2SyrjhUszkKWlY
         Gpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979414; x=1777584214;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xzr76OgKRSVyLlNPZ4BBmoEisHfu3frnnsSEc+2qgNA=;
        b=XIwlpfYpxAsawGDDdDuSufAeB/BOW5UlIxBsDmHp//wrr8p2FaJ7Bz1yTinGDqhkM9
         OFgVLXNFvuoj+FdqXXzWrv8Sx+ztaJ+tnfsGarYUt/Hfu6enFFVEfC+3l+7fl2zQ5OlD
         vvqH4V2VOCo9UizBXNV5PKbFgmqZ44P72Kt005eMSt4v5Fu/qz22xMbe53ddVnWz2ogl
         NE+LR0eP2uxIjDcjbL2kTXPdfoSRw5x6NRrjg+SdwxIgNVSixGC9pDagXDqkZmX2muV1
         lJ+DLs31h4hhjaDA80zNCDxUQ5BWkub8Njoe49UOWovjXVnJVRD6cAI8cHl3p1dryXJG
         hoCg==
X-Gm-Message-State: AOJu0YydAxP8cNmAGz5b0eQrANZVtsbi1wnDLbEgQ8FcUeBpcGdu9JqV
	TzCPCmMVPB6fA9TXnZZYeBIqQkIVWQINsbDGmEcx4jUcyJifV7606SoIopnGOYb3Xmq9dWOYOso
	VfNBKbXtE7Zg61/E2ArIF7fH1Q/EecXCFx1sYBG0mpyKUxAvx1noQZze2p6GatdWIsgwh5BHJej
	Z3sXLS/F2Tg4hGIcaD+tShbTkF9GLlJUV+Q0MU1CVUTLwpJw==
X-Received: from pgbda7.prod.google.com ([2002:a05:6a02:2387:b0:c79:9058:b77e])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6da2:b0:3a0:b781:4c8b with SMTP id adf61e73a8af0-3a0b78155d5mr25116879637.2.1776979414052;
 Thu, 23 Apr 2026 14:23:34 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:12 +0000
In-Reply-To: <20260423212316.3431746-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-9-dmatlack@google.com>
Subject: [PATCH v4 08/11] PCI: liveupdate: Require preserved devices are in
 immutable singleton IOMMU groups
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

Restrict support for preserving PCI devices across Live Update to
devices in immutable singleton IOMMU groups. A device's group is
considered immutable if all bridges upstream from the device up to the
root port have the required ACS features enabled.

Since ACS flags are inherited across a Live Update for preserved devices
and all the way up to the root port, the preserved device should be in a
singleton IOMMU group after kexec in the new kernel.

This change should still permit all the current use-cases for PCI device
preservation across Live Update, since it is intended to be used in
Cloud enviroments which should have the required ACS features enabled
for virtualization purposes.

If a device is part of a multi-device IOMMU group, preserving it will
now fail with an error. This restriction may be lifted in the future if
support for preserving multi-device groups is desired.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/iommu/iommu.c    | 35 +++++++++++++++++++++++++++++++++++
 drivers/pci/liveupdate.c |  6 ++++++
 include/linux/iommu.h    |  7 +++++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 61c12ba78206..782e73a9d45f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1664,6 +1664,41 @@ struct iommu_group *pci_device_group(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pci_device_group);
 
+bool pci_device_group_immutable_singleton(struct pci_dev *dev)
+{
+	struct iommu_group *group;
+	struct group_device *d;
+	struct pci_bus *bus;
+	int nr_devices = 0;
+
+	group = iommu_group_get(&dev->dev);
+	if (!group)
+		return false;
+
+	mutex_lock(&group->mutex);
+
+	for_each_group_device(group, d)
+		nr_devices++;
+
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	if (nr_devices != 1)
+		return false;
+
+	for (bus = dev->bus; !pci_is_root_bus(bus); bus = bus->parent) {
+		if (!bus->self)
+			continue;
+
+		if (!pci_acs_path_enabled(bus->self, NULL, REQ_ACS_FLAGS))
+			return false;
+
+		break;
+	}
+
+	return true;
+}
+
 /* Get the IOMMU group for device on fsl-mc bus */
 struct iommu_group *fsl_mc_device_group(struct device *dev)
 {
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index a9a89f7bd3e5..54a90ff02bdd 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -133,6 +133,7 @@
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
 
 #include <linux/io.h>
+#include <linux/iommu.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/pci.h>
 #include <linux/liveupdate.h>
@@ -359,6 +360,11 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
 	if (dev->is_virtfn)
 		return -EINVAL;
 
+	if (!pci_device_group_immutable_singleton(dev)) {
+		pci_warn(dev, "Device preservation limited to immutable singleton iommu groups\n");
+		return -EINVAL;
+	}
+
 	if (dev->liveupdate_outgoing)
 		return -EBUSY;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e587d4ac4d33..6f5d1dec3f89 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1096,6 +1096,8 @@ extern struct iommu_group *generic_device_group(struct device *dev);
 struct iommu_group *fsl_mc_device_group(struct device *dev);
 extern struct iommu_group *generic_single_device_group(struct device *dev);
 
+bool pci_device_group_immutable_singleton(struct pci_dev *dev);
+
 /**
  * struct iommu_fwspec - per-device IOMMU instance data
  * @iommu_fwnode: firmware handle for this device's IOMMU
@@ -1528,6 +1530,11 @@ static inline int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 static inline void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 {
 }
+
+static inline bool pci_device_group_immutable_singleton(struct pci_dev *dev)
+{
+	return false;
+}
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IRQ_MSI_IOMMU
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

