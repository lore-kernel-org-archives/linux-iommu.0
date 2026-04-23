Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191493C4548
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979426; cv=none; b=rRHr7zAmGr1pP/l8SrFFgKeipy0X56y5RPeMs0TRL94Lfuvmp0q0JQmCNL48KN1lwhMsr4tjuosCfBYl6vuRS8G2PB9fgdi4JFddCz+4m8UZ68C3BfTcBGMxWPOQ+ixh7NNfjHIclqWtl8uff1zvMSJMY0Of3ceJYncMwW23NWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979426; c=relaxed/simple;
	bh=Oe8MwOihG5BzjH99EK3y2Iy4j4M/3j0maoUzCe5H9s8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UFE5jN+w73VSDQLzI3ChIzlScsoLVBa0z6VzDJPkauLbfF4gvVLhogOGvZeD0JhgnWKxQEa+k8OyBZb5u6UkF+z5trnXL5Xp3hmY9DAVKVHU64oTrKdMuK5PDNMIy7yD2EJhi6GNfIg/a9wVFAHT/o6/6k7fHzeKQPw2RWWA94k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F01pFuTv; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F01pFuTv"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b242b9359aso70728615ad.0
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 14:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979418; x=1777584218; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDSmr3KzvFf45fqXLLacm4Nig+LS/n/kl38OHtIvfGo=;
        b=F01pFuTv1OEeSGdkrMKXrkCosrDXOK6YRw2CiDlB/91LNFOa8FET8wDsxEqAhEKZyt
         gypSOrfdv1qP2k/MHruFkh2aNnoqQAHnzDIujBeNxt/0eRRKSQNJQuE5Yjx4b0HudDVG
         MUO0zZqWoA7yLzsc5zi4w++OF6Rr1bY8pYpCt8SrnLtxeXLBhvDhIyU51u8I3kOBNlKu
         ZmjJM/B8RBYzoZ5lQBL3yzosDOhMXM7TxZVG205F3d7MAE7gwWqLUzij9KpI5gD9Bv1k
         l+XTq1Ue31LHXjunDa9Jvxf2LcYSP4pxI6JzJkJFmBbxmO5GuQjIeDkGe8299HER59SG
         elow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979418; x=1777584218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDSmr3KzvFf45fqXLLacm4Nig+LS/n/kl38OHtIvfGo=;
        b=FG7EsbiiyEYFgooebEtO7XWTR1XpiJNmfylmsfFoWSK/rPChOQ43eIOE4VmONHtcAA
         NOOVTi7JLWi3XSZz8I0eA1PjUGKjgbhrIbx8vWd6TlOUZDepY8mV+n8fB7Nj9/4zBjJo
         +EVhZBXh9l/9l9fUGQT/yxfzX3mHSjrrmyDPfJmzem6JmwA2ETLpBWF/MI3gZTriz6hX
         XsPpjoV2F92EO/iyGdC3tkKYgGbsSI7CQMfdvvT/q1IvJQTs5UODMNXoc3G6fSb/N6Le
         jXdOrq69JvffXj4yJf+L+YN1WMuMrpQXidAgExGZawq2AvpGWdbG6ItVmpGR8Y89xzu7
         8scg==
X-Gm-Message-State: AOJu0YyRciqLL82hQGSSoieBgHzBu7Fgt2fMrNIjX19TYSq+XBziogyZ
	GC51gEG4+ZD5GgnQryWxM3rQyiP6btf+Y+0aWyIJlnFY/vzar55N93COzB+4lR+VPVl7lAaw/XQ
	TDFR/SOIhLdwWcf8iozZW9MawvR5vqwSGl/PY7AW8pHU/9OMMPUS5htcwnvmKGThwF+oAX3wtNj
	8PhMGoVKJAfiyUzp2YVjCe0qkZejlvld1VIAw5ec72ehAdyw==
X-Received: from plov1.prod.google.com ([2002:a17:902:8d81:b0:2ae:c54f:d5ad])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ba94:b0:2b4:5c0d:314b with SMTP id d9443c01a7336-2b5f9f83342mr210260195ad.38.1776979417788;
 Thu, 23 Apr 2026 14:23:37 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:14 +0000
In-Reply-To: <20260423212316.3431746-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-11-dmatlack@google.com>
Subject: [PATCH v4 10/11] PCI: liveupdate: Do not disable bus mastering on
 preserved devices during kexec
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

Do not disable bus mastering on outgoing preserved devices during
pci_device_shutdown() for kexec.

Preserved devices must be allowed to perform memory transactions during
a Live Update to minimize downtime and ensure continuous operation.
Clearing the bus mastering bit would prevent these devices from issuing
any memory requests while the new kernel boots.

Because bridges upstream of preserved endpoint devices are also
automatically preserved, this change also avoids clearing bus mastering
on them. This is critical because clearing bus mastering on an upstream
bridge prevents the bridge from forwarding memory requests upstream (i.e.
it would prevent the endpoint device from accessing system RAM and doing
peer-to-peer transactions with devices not downstream of the bridge).

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c |  4 ++++
 drivers/pci/pci-driver.c | 31 ++++++++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 25c86cd4c173..2a4a139623a6 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -132,6 +132,10 @@
  *  * The PCI core inherits ARI Forwarding Enable on all bridges with downstream
  *    preserved devices to ensure that all preserved devices on the bridge's
  *    secondary bus are addressable after the Live Update.
+ *
+ *  * The PCI core does not disable bus mastering on outoing preserved devices
+ *    during kexec. This allows preserved devices to issue memory transactions
+ *    throughout the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d10ece0889f0..05584bc76332 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -531,6 +531,27 @@ static void pci_device_remove(struct device *dev)
 	pci_dev_put(pci_dev);
 }
 
+/*
+ * Disable bus mastering on the device so that it does not perform memory
+ * transactions during kexec.
+ *
+ * Don't touch devices that are being preserved across kexec for Live
+ * Update or that are in D3cold or unknown states.
+ */
+static void pci_clear_master_for_shutdown(struct pci_dev *pci_dev)
+{
+	if (!kexec_in_progress)
+		return;
+
+	if (pci_liveupdate_outgoing(pci_dev))
+		return;
+
+	if (pci_dev->current_state > PCI_D3hot)
+		return;
+
+	pci_clear_master(pci_dev);
+}
+
 static void pci_device_shutdown(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -541,15 +562,7 @@ static void pci_device_shutdown(struct device *dev)
 	if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
 
-	/*
-	 * If this is a kexec reboot, turn off Bus Master bit on the
-	 * device to tell it to not continue to do DMA. Don't touch
-	 * devices in D3cold or unknown states.
-	 * If it is not a kexec reboot, firmware will hit the PCI
-	 * devices with big hammer and stop their DMA any way.
-	 */
-	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
-		pci_clear_master(pci_dev);
+	pci_clear_master_for_shutdown(pci_dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

