Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8D13546E8
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999844; cv=none; b=hC07LQ6cp73XUWhPymwH4uZHehQKj4YanxeiYFRIg/wHtGzSDrfYCSgUjcDxGbG8kNfRfzbMybTw818SfcU2Qy25Csyu3n93CKo+cA/qBJzAoTwidzrLFCLEpP/kEz1Na7tW0QEFozfPYgw9FgN5dVWGuYBLF6qVD5ssDpx8qnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999844; c=relaxed/simple;
	bh=EnNz1gQUCzAadvQoxG6N8mxuCZNBo1KHJ3OP2DBjMlY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KcC3NHeY4sNMaLhGLe5xYdp88987yasx3b0N7ENF2Y7kNi0PkqE2YHeSjNmTPl6GlAN06CPsuxigr3TtEONhA7BeLMnWSmN8JlBbWhaEFFOldbMuyTNwQiWlLYsN5ken8+LVhvRprNSl19letDvzrpMQ4FRC8XBuyaY3bvCOyIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=beGD9eoB; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="beGD9eoB"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2baedd2fd43so93058665ad.1
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 13:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779999842; x=1780604642; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xF2OaZLydlq8fssyfbqW+m3pz8p9r7jLJNQQhoc0Wjc=;
        b=beGD9eoBXza0qZ0oNHTW/0r0KKN9nWq8VxMesDdYvvkGgbewUvYqZ9inLbsbbP4UsY
         2ZUpRHRzA2Cp5uul9aTdix59euet6kyzRosV1w0My1oNRwOXtFZBx1fGNb15zuSjkOwg
         8IPeRP4mzCEaixIsZ5s/wHtZficrThEvLVsPVoJ+3t8adAep3u4Ejrm4ZAzp35UeBSbf
         3lx6XGLi+AL0R2jBK4ZtnlSgf4fc8LxxqN3HP/cJmIeOL79aDWcZRYkWFIfCiSLlDspI
         rLclVai+JPpGdkYK4PHLxXBBNuJOg/5eCluJskn7wEJPinzJC8BIdpsWyLDwEFpzYw7m
         53Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779999842; x=1780604642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xF2OaZLydlq8fssyfbqW+m3pz8p9r7jLJNQQhoc0Wjc=;
        b=qV32xxai//b50MM/2FmlcSR+nbBY2kTw1aMlbuIl4maWgEfNXjsobhyZqnR79IKxtu
         oFPAEDWL78axJbfTGwvwdtR59Wr4udWDE2iG9C3N+xYj1QC5QC1nr+VET5kiI54dgT7E
         rGis1GUXpQmBDIkEUMyLOfAav2yCvLFXKaIdrpzIsO0a1D8pY+5sGL9VqXjwP/alZ9vB
         9gRxxE6MNn+HzXhJQNpKuNCO/1MfCWgrgX+TLy3aRDOkNPMvNBR8f6g49OpkVc1eQOWk
         4T3U+Ki1kl3UZqvQ6fiSGgVfIladBfNR6dt6tsQ0WDpE0VPICZhhVWl77f9Gb5OSYu7w
         CTKw==
X-Gm-Message-State: AOJu0YxPa3otuR6U7sN+w+u1K4/948XSh+kItvN4tlKwJqQiUxn8kPku
	tR8BVKUZ4QcvjiKNxaakntAQcEMEZ0QvIb1NckYA0ipTCwsJMtSqaT2400nSSXn9hbWy6TS2i8Y
	l1F+ztAWMAqHPYUBu4CGZDi3b7dYk3bV+PWplrpWqQW3hFEufH8rPzS+/MWhJOmJfkCRH2frGuT
	9a2ZQS0zcuPbXgnWoeq53ZQeq4IPlRtQ==
X-Received: from plhe2.prod.google.com ([2002:a17:903:1c2:b0:2ae:5d79:a153])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f601:b0:2b4:696b:7bb7
 with SMTP id d9443c01a7336-2bf1eb7c31cmr3931325ad.15.1779999841997; Thu, 28
 May 2026 13:24:01 -0700 (PDT)
Date: Thu, 28 May 2026 20:23:49 +0000
In-Reply-To: <20260528202353.3422206-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260528202353.3422206-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528202353.3422206-4-praan@google.com>
Subject: [PATCH v5 3/7] PCI/ATS: Decouple pci_ats_supported() from pci_prepare_ats()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Nicolin Chen <nicolinc@nvidia.com>, David Matlack <dmatlack@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mostafa Saleh <smostafa@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, pci_prepare_ats() internally calls pci_ats_supported() and
returns -EINVAL if the device does not support ATS. While this provides
a safety check, it conflates support detection with configuration.

Update pci_prepare_ats() to remove the internal support check. This
decouples support verification from the configuration phase, ensuring
that drivers can distinguish between a device that does not support ATS
and one that has a true configuration error (e.g. STU mismatch).

Update the function documentation to mandate that callers must verify
ATS support (via pci_ats_supported()) before calling pci_prepare_ats().

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 8057c24b0469..92c2a6bc2dcc 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -56,7 +56,9 @@ EXPORT_SYMBOL_GPL(pci_ats_supported);
  * @ps: the IOMMU page shift
  *
  * This must be done by the IOMMU driver on the PF before any VFs are created to
- * ensure that the VF can have ATS enabled.
+ * ensure that the VF can have ATS enabled. Callers must verify that ATS is
+ * supported by the device (e.g. via pci_ats_supported()) before calling this
+ * function.
  *
  * Returns 0 on success, or negative on failure.
  */
@@ -64,9 +66,6 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
 {
 	u16 ctrl;
 
-	if (!pci_ats_supported(dev))
-		return -EINVAL;
-
 	if (WARN_ON(dev->ats_enabled))
 		return -EBUSY;
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

