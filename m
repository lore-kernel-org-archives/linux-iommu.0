Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6209E3D093F
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 11:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053138; cv=none; b=Mgtim6EP6ig4NoOYztw1pGVPy5RSHb8pLhDGBNsHLv4FUoA+ypjoSaADCQLLSrO4bGUX7T9HiGX7IgwnkzvLjmkwxZslX8bVoXFBUYn3HA+karWTmAK4G24wkb2Ol0nUe/4Q2Qz3MkvQYsa5ltgbQa6fn566a62yfim2VYi7ht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053138; c=relaxed/simple;
	bh=zLhKJQfxvv+d9aNsqJrU4irOe5OKs7/A2799Tf2JNWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QgXCtcmtSb2PME2nLOYcwo3+R4JBGVpOHSlbrnehUEOXGQF1ibnjGyaCrJPDh1JDY7l9WuSGk6nj3zqwCdfwhZxSaTqf7XNZtvRUJ1eGVBquLyttu3Wsp+LO+AdA7zmlDmq4MKYV9yfIUmUYHtASJkBVNUh/qQddhY4oI1G/yuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SnMKV2kH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SnMKV2kH"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf004bf8beso25954395ad.3
        for <iommu@lists.linux.dev>; Fri, 29 May 2026 04:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780053135; x=1780657935; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H1WHbQ1I/exyopX3p7b75ehhnkD9ODb3Bve7jByn9iQ=;
        b=SnMKV2kHXMhehpTctW8YgNeOZ1wZIsQXt49KaN6KwLPD9UiBS913I7BPBpCuUd9YD4
         b84n5r4IgPhEaiQfnfnIWUzGP9kYH148xjYNoc5vwot5UThJf45GcAVQdZyAhcN7uNPQ
         nHYVct0u0IEEbnKd95pt547eksQJl8gGbu80RHsCDthQQi2IN58ue6PQzBwTSZJ346NC
         jomeM8apctul2OkGE3rntM86ekE5shcKfZO5PipOru6LSp06oREGfT2CDEhYJTafYuPS
         CJl37XrKHHukWTUOMnnGGJA6q6WzePkxfl3qtItzRRXP3HwNqMufTMyoOJ4omhxHL3Sr
         hOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053135; x=1780657935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1WHbQ1I/exyopX3p7b75ehhnkD9ODb3Bve7jByn9iQ=;
        b=SU3ynLUo0yLWySkjPpYNal79pPT6wOQUfaYf8d+CqyIxDiHDyOFKgUfVmUkn8hWl/I
         8+NmD4KniMbnAaX35K2ZDXrA85cNYu3Wxl+wdnHlAEa8GI2WWV/Xa+MlTo+iqwgn4RGQ
         wqyI36Ge2TtDomZsn+kg+lSSv8n/e9JomT63L04yoZonZ4fvO8OR3/TgmU+p6dNLVOMW
         wgj995ZMpd9a8c2W1zJfqYBcpDGJz9hN3LxUjh0ULsA19hg9dHgu9GXW6CYcKXpeL4N0
         L5+9U7PveNqVExJuZYLjGs1iV49POk/TaL+V/xc5pRGuj79HADOxf5NoUa8vDlPiVRcp
         U9Sg==
X-Gm-Message-State: AOJu0YwMnTgL6U7eIekEPq7lJSUwzsf87D8jiQsiC6hZ9fAUyIyAkalw
	KqbehmkikaFO+kIPK7yF+yUJRK+qwqfah26/hcdVaOpdZjpk+ATKhnl/VKOxF3+0XhuiJLAtx3e
	QHxu8VoaEdLM4yxinjYSM7BxCyLLKto+1yIJnCpE4ecx49SzNOD12sQkd8QLg8nwacKk7O/yos9
	a1fGC1ox/J6WP9FKis9yEW0GLkBpWrjw==
X-Received: from pln12.prod.google.com ([2002:a17:903:360c:b0:2bd:5ced:c1c0])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ced0:b0:2bc:7d1d:b677
 with SMTP id d9443c01a7336-2bf20ce01c6mr32213585ad.36.1780053134160; Fri, 29
 May 2026 04:12:14 -0700 (PDT)
Date: Fri, 29 May 2026 11:12:03 +0000
In-Reply-To: <20260529111208.387412-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529111208.387412-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529111208.387412-2-praan@google.com>
Subject: [PATCH v6 1/6] PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
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
	Pranjal Shrivastava <praan@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Update pci_ats_supported() to additionally check the associated PF's
status when called on a VF. This ensures that PF-level quirks and
untrusted status are correctly propagated to VFs, providing a robust
support check that aligns with the kernel's PF-centric ATS configuration
model and is immune to the timing of VF-specific fixups.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 96efa00d9743..679a3c3c1d54 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -40,10 +40,13 @@ void pci_ats_init(struct pci_dev *dev)
  */
 bool pci_ats_supported(struct pci_dev *dev)
 {
-	if (!dev->ats_cap)
+	if (!dev->ats_cap || dev->untrusted)
 		return false;
 
-	return (dev->untrusted == 0);
+	if (dev->is_virtfn)
+		return pci_ats_supported(pci_physfn(dev));
+
+	return true;
 }
 EXPORT_SYMBOL_GPL(pci_ats_supported);
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

