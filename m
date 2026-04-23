Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E74B3C0608
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979421; cv=none; b=EmzN+RuFTbFctwK+76eprDwYAQdEe+k8jvIU2YqAJ2IWNYMASdG+7IlzqrSv0HDAJuWcv96+ZmFq48fsKql14mrxOhw4xR1dalubMWt4MWncdx661XRROO07GOJzqmxhMJeoQLDSq6NxVPrhhb7SWJ9xCHhli7gIbAFD5e0JPRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979421; c=relaxed/simple;
	bh=k0MqtokF5x5FrnuJGyuULJNyUYCZIUvKCsZhPGRTT5M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ID7i7k28e4U/jPl0jXZ2Z65MwmMw4r8rzus61e7Ph1GphB1K2JCua5+Vy53JR1WkXye3Ay3cncRB/ao1Buz5z6b9iWEeBGlZLFkj9MYpBCVzRpBoiVWdS127H7wtwNmkVMZS/xsJB3eWpX1eOokuRqsdGWDL+c/woKV9+OL2OKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aygECDv+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aygECDv+"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35fbb5779e8so8012737a91.3
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 14:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979413; x=1777584213; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ys4uatxpJYM7Kl1KgUYRndxIbkLNusGMab4h1bmL7Us=;
        b=aygECDv+/II7/wcaeGNGugQPuM8tNnE3wOa8Y2fyGiDL3rfxfy7Q4HT6iaf+sEDyYl
         qGJaEx9wGOzx+OHestzFJ7SoDNkzLTpbU8D7ctTP8ha68fL9UaUrftMF+YkXVw6c4OA6
         MZux3wh1G/UbQl9URikSBVmiMpCWYWevNtAD75DUXLe6dLE27nSKBS46dksj0753ZXjP
         VxAuo0f9ExNQhSIxo7R/ro638Gk7HZQj4IUoZKXNba3IykEmX5NA8rUrUMs6SbLREduy
         5EJRw8DZrsDWaxy9ezG/cvwN0OnpMVfLZLCePT2HyXH4qBq1hdhhtDFp3Za0/5pg8U+V
         4J5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979413; x=1777584213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ys4uatxpJYM7Kl1KgUYRndxIbkLNusGMab4h1bmL7Us=;
        b=hcmmSKzoR0SdVmbyKUIXinuzzo6aSogRhrCZKTmraA/b9txq4lALbtUhlkW3e1zU3v
         CNGl2/PYAdIHRgUrONZ5Rmpcv3/jNM4noiD2R5JSqgc6ZHSVhRDvyg1AQJLmVxWeqao8
         pfKlmsTfavhyMr7HY9xYHvNUSpssPZksl64mIkZL7Wu/qZ555+4Knd1fRv+gkBe84y1i
         GqfyM8y3NtkE2+5CpTXWC/cuhzBKDAwxJbiQAbwJHu7+65HpJjcYvxDMHif6TgRjvUmk
         WhKoed8TpCk5Lv6trFJztWWD41Qi3btcbCfI76+TPx2UzkFJfFUX6u4zrCTJLta/vq5o
         h9vw==
X-Gm-Message-State: AOJu0YzrMnt5GF+Pdawbxps8DFQY2NeAGcrkcnJbaqxfBJfCK1p7yv9r
	mQFymYUlR7m2JykoIFKQsE3lyXtUlvcGfYR2MYGPHlv6H1jlMHwyKFEXFGm+Q+h31jXpT1Cesnv
	4JPq9aKcAKUZvxnHox7Ue6Jr5T14IJDbPQUIbXdUI0uQrz49wvhZo2gRc2WkkuZTHwd+8qlS6K8
	2OdhXnfbeu6hQq5Hgu7t7dqQzH5lh2aiz96FCYEN4Br5NiFw==
X-Received: from pjbbj17.prod.google.com ([2002:a17:90b:891:b0:362:b5ab:9cd3])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:51a3:b0:362:bb93:f25e with SMTP id 98e67ed59e1d1-362bb93f462mr8872524a91.23.1776979412273;
 Thu, 23 Apr 2026 14:23:32 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:11 +0000
In-Reply-To: <20260423212316.3431746-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-8-dmatlack@google.com>
Subject: [PATCH v4 07/11] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
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

Inherit Access Control Services (ACS) flags on all incoming preserved
devices (endpoints and upstream bridges) during a Live Update.

Inheriting ACS flags avoids changing routing rules while memory
transactions are in flight from preserved devices. This is also strictly
necessary to ensure that IOMMU group assignments do not change across
a Live Update for preserved devices, as changing ACS configurations can
split or merge IOMMU groups.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 10 ++++++++++
 drivers/pci/pci.c        | 10 +++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 88125f9a2c6b..a9a89f7bd3e5 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -118,6 +118,16 @@
  * This enables the PCI core and any drivers bound to the bridge to participate
  * in the Live Update so that preserved endpoints can continue issuing memory
  * transactions during the Live Update.
+ *
+ * Handling Preserved Devices
+ * ==========================
+ *
+ * The PCI core treats preserved devices differently than non-preserved devices.
+ * This section enumerates those differences.
+ *
+ *  * The PCI core inherits all ACS flags enabled on incoming preserved devices
+ *    rather than assigning new ones. This ensures that TLPs are routed the same
+ *    way after Live Update and ensures that IOMMU groups do not change.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8f7cfcc00090..e615b7c3e430 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1017,6 +1017,15 @@ void pci_enable_acs(struct pci_dev *dev)
 	bool enable_acs = false;
 	int pos;
 
+	/*
+	 * ACS flags must be inherited from the previous kernel during a Live
+	 * Update for preserved devices (which includes endpoints and any
+	 * upstream bridges) to avoid changing routing while memory transactions
+	 * are in flight.
+	 */
+	if (pci_liveupdate_incoming(dev))
+		return;
+
 	/* If an iommu is present we start with kernel default caps */
 	if (pci_acs_enable) {
 		if (pci_dev_specific_enable_acs(dev))
@@ -1041,7 +1050,6 @@ void pci_enable_acs(struct pci_dev *dev)
 			 PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC,
 			 ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC));
 	__pci_config_acs(dev, &caps, config_acs_param, 0, 0);
-
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);
 }
 
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

