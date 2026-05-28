Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819E2F39B4
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999840; cv=none; b=OkP5yjXa3xkBukpZlvKb6qzYpeDKx4lh2hBK2JgyTyHYXHWk+ODC/RplTTXU6el4h2/m6HDjQwpKZz1A2T3x0KKTUPsK9n3GzCQqIO8xZfT8DSvBmmeclWH/uRbqYId22t1AagQW4d+oPiaJHIQK7zdEpJ8f7/7tqd5PnZGraPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999840; c=relaxed/simple;
	bh=6JPZRBT6suYUThuvCh6y+NiY5DV75TOqoNSPL+EfItk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aAr/8vPfuMQyhpV4jaIWedfLiotxgcBgIQ8LVayvTVpgBWZ4AdQg6+XxXNLlM4R6+7vNLfYv8APJ+imIUAnxtOpHC8CNZVE7iyWSYP+gruST8KWYm3j5t4RBV5PANxYfrGf0yCgUdchaTffMkMiq6RzN2jEuJaKs5oisFxu+wCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZIYr8lKB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZIYr8lKB"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36781927b4dso7312509a91.0
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 13:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779999838; x=1780604638; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xwbylVdF+O+8AihJparLUGU02SRqGSrn4Cd3mbYF5r4=;
        b=ZIYr8lKB/5WHfhV7DpTznZGyjEluv6LvuyLGYhMTKeeOVsY7coKo6nQeJmsB3nwnpc
         VgRPOR9ICjIDIoYwFrTnRXp/HrHIbHO9dAhlnlMJCBgky0poU4KfRrDFiBanP470J4AL
         +vPzo2n8nIhMXa7GmpXeVjrVhztBg/j+GvyrfjihTC3sFqjs0sYX4m76DZaVJDzHmIy6
         iaSGi8QPXrwjNLvro0GgJhReluPD22rGHZyIhnYsqqLUDpO+/TqTTrzYAI6EAZlYqC2B
         stnTRMtVHOKTSFWHU24n9G76cSY//BZCLxVlPgy3mAdwG53wbIzxkVCxEoMC3dV/f/U9
         kyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779999838; x=1780604638;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwbylVdF+O+8AihJparLUGU02SRqGSrn4Cd3mbYF5r4=;
        b=Bz9+4YVtzV5ENtCx9wAKbxo/Vb7JWOo+dlMB5hiSzU25kfIG51rmpTHjUSorou8EOz
         y4DvulokF/XuEhO82EgdJCJ4OHKw3W6tiZbgg65bletvEH6KqyFtDUYkr3ev/xthoM6s
         xw1gMAyGT5eS/cSuSX94hsMnpM55UrmV8lF7a2Iht1WWAsvafd/BlQzK3cmian8a7CGQ
         j1zcY86WbSKLf/f2tt7RKiiTfPjwxueZz+AT42r+chuM4GHuQEOc5qUY9SFul/PIH1r+
         oFTPhJ+hK07JNAzMn0sPxrKLeYqa3Cvi+/V+BZpYGeFsMLqOyCyrIh8XF4hBKU5WF/JK
         fYdg==
X-Gm-Message-State: AOJu0Yy9KsM3tw48xIDWZAOebbSfe8qfMZSrap3gIsAFH2KIfOr8vRA+
	Sin3PPqEt1xRzVQAj/v4f1BR41vZ72CGWBa7AV4FHiQ590rE/xAR5miyO1jZi9Y943xP9ebt5jj
	EKpCBx4lIEcao6q4Uif4KUf+Zfh9FpE2gZSwSVhkCEdyBB/Ic5Lw/i+X+vk6p9GU57H6Qup+ZwQ
	i4GQcxUa8eueXrZj5Afm2LzuLr0Jr+Lw==
X-Received: from pjbcu14.prod.google.com ([2002:a17:90a:fa8e:b0:369:9cde:eaa0])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7c9:b0:368:1088:bb1d
 with SMTP id 98e67ed59e1d1-36bbcfd9807mr90130a91.15.1779999837989; Thu, 28
 May 2026 13:23:57 -0700 (PDT)
Date: Thu, 28 May 2026 20:23:47 +0000
In-Reply-To: <20260528202353.3422206-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260528202353.3422206-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528202353.3422206-2-praan@google.com>
Subject: [PATCH v5 1/7] PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
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

