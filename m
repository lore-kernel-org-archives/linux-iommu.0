Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A4E3BED66
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979426; cv=none; b=p77plrCeh0EEorn0fd6jtRdWTri0NJYm/UJjVWN7GkLSOrWfsyvrkq5Mi0t5zyeVkJkB51+WdsYe9r0xKNh+THqaUNdgD271A9Kjx3OHt9uNKJb9lrQ1LBwzhgw6HxmCFo+IEwJQwf4qdBoJYiMoQyYeDU5gCzyz+W9A/MEeYHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979426; c=relaxed/simple;
	bh=85D2Ac3hBoG1dFzFVA37bHIGBGx9gipkQcKVvZXkhV0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dprtYtTFcfT9yz2jOkQADF1y4rV/SlY1qAaBgPFTGcS4tiOdA26YgiPc+YJdP+41Swor51a4XcDgHYqb/Jd3ZZ3MeqUhZ/e3Z+JUbSuOb9SnSW8VPjAk3WiJGutC8dJH8M3l7x7j/IJSccl9KJCVPTAQvjJM16P37iVYuj+vC80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kQqs8y4f; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kQqs8y4f"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b24af7ca99so96472755ad.1
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 14:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979416; x=1777584216; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/PZfm0ILlaeTWExhdrHJ+nS/9VkLe0d8hpRsDexX1A=;
        b=kQqs8y4fvXekPMPZvvaK7CT2XT6ivbvlY+jM0O9GQ04/SafqPAfqGShw6Ly+1Depkv
         OU95UgxfJiYJ5xEECSe3mPUKRf1DF0YuLpc/9uytvTq1OQ/rYZMoLmW9MHy2/SMD/RUt
         MWlSl51vtM+VDktv1U6kuxYKXrhoDb3Opj4Y57RJp/L7OkoGbA8meOBqmYmqh36AqEkI
         sTjE8DmRAgyY/OfE5/+JXNSI2w1H5Y7WVzIwYaKGvHgFjZjclBdCJHMVY+RdY7IzSszX
         RYWPshsuOOzoBtEGvq62NKgVyJR9F+EWaCzorXrdYIv4IYFGSH89fmpUQBUxWh/Op1DC
         1diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979416; x=1777584216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/PZfm0ILlaeTWExhdrHJ+nS/9VkLe0d8hpRsDexX1A=;
        b=kqLoM6G5sOTf/yf0IEUXo7AkoDY6T/TVjGK7fBy3mqWP5+8xzq741vSQlZS8OL9lW7
         mlE5ga1k6Vp4VOcRWprcfvc4aVrLN+3U+P8W65XXd+vVWByf2iqCSXtHOXdCUJL2hlnG
         ixwC1h0sKLXPm0C9LfIgcRrxr53RXPYqecUajNVIsU06fvjH6OavTwCEx6fpHRvdugwT
         3OjPBWW/45qXscrxepS/Yg8jHXYR6zith7bIFAdxPOqPU6xIvacXhwGH9tnCUOM2c4Lc
         fDV4iyInb+ppUbBsvkKWvHgAfQ40/EA5khq1+onGvQte7mUPm70bzo0GLFHquct21yDo
         MTZA==
X-Gm-Message-State: AOJu0YwM+27HnfUQEDY5tG+UPg7qQ839/vLZaKD8vde0IKWTPKTQgHpr
	g05jOGTSlz+laHmr1xVw8FGR3vGKmMVg4d0rnsuZe9kYinjFx94nVG/EJqvOa2Ayx+sfsE4Xu1b
	fOowCib5XiCYKwfq2/4WOFBGtqgfFgTg8HTakMARx17XvltU0bGODu4MaepSM++O7NAIxAZGbkB
	5jTyjim6/b77420jKM6WuY63n2yzLduUEP3dy4MwQmznTsxg==
X-Received: from plav22.prod.google.com ([2002:a17:902:f0d6:b0:2b0:5380:49f1])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1a88:b0:2b2:5ec6:dcf6 with SMTP id d9443c01a7336-2b5f9e85f20mr294713095ad.8.1776979415642;
 Thu, 23 Apr 2026 14:23:35 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:13 +0000
In-Reply-To: <20260423212316.3431746-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-10-dmatlack@google.com>
Subject: [PATCH v4 09/11] PCI: liveupdate: Inherit ARI Forwarding Enable on
 preserved bridges
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

Inherit the ARI Forwarding Enable on preserved bridges and update
pci_dev->ari_enabled accordingly during a Live Update. This ensures that
the preserved devices on the bridge's secondary bus can be identified
with the same expanded 8-bit function number after a Live Update.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c |  4 ++++
 drivers/pci/pci.c        | 12 +++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 54a90ff02bdd..25c86cd4c173 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -128,6 +128,10 @@
  *  * The PCI core inherits all ACS flags enabled on incoming preserved devices
  *    rather than assigning new ones. This ensures that TLPs are routed the same
  *    way after Live Update and ensures that IOMMU groups do not change.
+ *
+ *  * The PCI core inherits ARI Forwarding Enable on all bridges with downstream
+ *    preserved devices to ensure that all preserved devices on the bridge's
+ *    secondary bus are addressable after the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e615b7c3e430..b45539c55c7d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3498,8 +3498,9 @@ void pci_configure_ari(struct pci_dev *dev)
 {
 	u32 cap;
 	struct pci_dev *bridge;
+	u16 val = 0;
 
-	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
+	if (!pci_is_pcie(dev) || dev->devfn)
 		return;
 
 	bridge = dev->bus->self;
@@ -3510,6 +3511,15 @@ void pci_configure_ari(struct pci_dev *dev)
 	if (!(cap & PCI_EXP_DEVCAP2_ARI))
 		return;
 
+	if (pci_liveupdate_incoming(bridge)) {
+		pcie_capability_read_word(bridge, PCI_EXP_DEVCTL2, &val);
+		bridge->ari_enabled = !!(val & PCI_EXP_DEVCTL2_ARI);
+		return;
+	}
+
+	if (pcie_ari_disabled)
+		return;
+
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
 		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
 					 PCI_EXP_DEVCTL2_ARI);
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

