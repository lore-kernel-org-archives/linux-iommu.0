Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B968DC433F5
	for <iommu@archiver.kernel.org>; Wed, 15 Dec 2021 17:19:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4F065409E1;
	Wed, 15 Dec 2021 17:19:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nACn6Jg4X3ln; Wed, 15 Dec 2021 17:19:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DB792402D0;
	Wed, 15 Dec 2021 17:19:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94B09C001E;
	Wed, 15 Dec 2021 17:19:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F1B1C0012
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 17:19:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3764F60ECF
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 17:19:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="wYhmWV2t";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="lk+vW3OX"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xyyV5osCPRC3 for <iommu@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 17:19:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9191060E8E
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 17:19:53 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639588790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8dWZtEdF7LamMiNHDQtUJa+ux0BuM6MSUIqH9b+Hvyo=;
 b=wYhmWV2tAzCQfd9US7tK/sDWCnBbJEkh0toY9VDuwtDZ0a56PMo8BoccPtbLPELWo9I28H
 HKc2neisW5z7nVF58H33hQ6I3JpDjp7x8Kvp/cCgjUvnYD8QdYGH61A1BeXSEXOYr4fYH5
 DLBlYKQg7bDxik0O85eEeU6t0YgTJ460cdP5T6mA0DAEz4t2jvbnSoMRyHmCdRIsX+WU5+
 q/5iZYQod3bSNBGwjqvNjip+w8Kzgei0iFMPfqmZqeU25htKL5R6ykYiRwqQfnG6lFz+mQ
 r3FvWyI39vnZ4v4UgiVkKOdpkffYfcVyqNIiIF+3PGfZRf0ksOR9s1/A7ZSHGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639588790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8dWZtEdF7LamMiNHDQtUJa+ux0BuM6MSUIqH9b+Hvyo=;
 b=lk+vW3OXeYaf8seyWIaOrmuYBvQZ09fZDnlpC9df3JMNaqJ74ZUxSByXPFwmhYxR0MLbL9
 iLeRWTRdVJiovHBA==
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V4 09-02/35] PCI/MSI: Allocate MSI device data on first use
In-Reply-To: <87tuf9rdoj.ffs@tglx>
References: <20211210221642.869015045@linutronix.de>
 <20211210221813.740644351@linutronix.de> <87tuf9rdoj.ffs@tglx>
Date: Wed, 15 Dec 2021 18:19:49 +0100
Message-ID: <87r1adrdje.ffs@tglx>
MIME-Version: 1.0
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jassi Brar <jassisinghbrar@gmail.com>,
 Sinan Kaya <okaya@kernel.org>, iommu@lists.linux-foundation.org,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Megha Dey <megha.dey@intel.com>, Juergen Gross <jgross@suse.com>,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>,
 Marc Zygnier <maz@kernel.org>, dmaengine@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Allocate MSI device data on first use, i.e. when a PCI driver invokes one
of the PCI/MSI enablement functions.

Add a wrapper function to ensure that the ordering vs. pcim_msi_release()
is correct.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: Adopted to ensure devres ordering
---
 drivers/pci/msi/msi.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -366,6 +366,19 @@ static int pcim_setup_msi_release(struct
 	return ret;
 }
 
+/*
+ * Ordering vs. devres: msi device data has to be installed first so that
+ * pcim_msi_release() is invoked before it on device release.
+ */
+static int pci_setup_msi_context(struct pci_dev *dev)
+{
+	int ret = msi_setup_device_data(&dev->dev);
+
+	if (!ret)
+		ret = pcim_setup_msi_release(dev);
+	return ret;
+}
+
 static struct msi_desc *
 msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
 {
@@ -909,7 +922,7 @@ static int __pci_enable_msi_range(struct
 	if (nvec > maxvec)
 		nvec = maxvec;
 
-	rc = pcim_setup_msi_release(dev);
+	rc = pci_setup_msi_context(dev);
 	if (rc)
 		return rc;
 
@@ -956,7 +969,7 @@ static int __pci_enable_msix_range(struc
 	if (WARN_ON_ONCE(dev->msix_enabled))
 		return -EINVAL;
 
-	rc = pcim_setup_msi_release(dev);
+	rc = pci_setup_msi_context(dev);
 	if (rc)
 		return rc;
 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
