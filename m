Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7780F49F137
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050420; cv=none; b=J5KCTIx+hw/0/34RF6yVBSh0TcJ9lVbGYpb2MqwKn8wbnhJo3FNz8AbxSQ0UCsbfYcxyQI32SFJFDE9WZo5qxv1k9A56EbHK2pUounqZS0P7ozHTKuvXDpw9mK9tvqbFw6z1QHRWmFMLP1V3a9oh2iYQXk8vN8obTd80lr09Ovs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050420; c=relaxed/simple;
	bh=J0Hc4q1Go6YI0ET8ibt8BHU2+llLW9yLplGEKFVytrI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZwMVH1yKFF24ikRlMf0Ak4ejIo8EVWM52A2rGsY3tJ3giDGHgYOlD1wMjZfCvZvoPpB94vtShMMpSr4Y5NZqq5Va3U65zP3RYtjajv9B2zNzOQEwiql+exhCKCHLYABg86lwSHARsUs+9PUkPOuNqLd9JKQGVHWxNZABaCpV6F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gkgiRGSb; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gkgiRGSb"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-396638f9a18so7701879a91.2
        for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789050418; x=1789655218; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RBJ7ZQ97TaoaWnA5M7weW3ELiXVtmItecO6telkSzYE=;
        b=gkgiRGSbFovM45sNc8raV9Vp534/sSGJFQcSDI96DbO1YFy2gJVrFjDWrrhpzQDi+6
         0cCsFGzRgGUyxOYiW/O7hD4IoHZ2ASBRpmfML3wZ5QocZgrBCayYgmFOqc9lURSU6wCE
         m2eZW/FDT8fbJW+zb5pk/48xmd6jXvpCUMpEbxIUAl3F27acjjOg/T/6O8JqcnifaDNH
         cb8KJGqKtzmgcf4c+uNGCHhVBmedGRoDQZY655p5DMnYrgTi64+gK2VvwVJd9/2TOkmn
         0zZQoubYbq20l0RNaTL/hqjy9+2PNGieda76bLyclPoZUuIxI+G2PgYqyCG/++vJ5d8x
         wByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050418; x=1789655218;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RBJ7ZQ97TaoaWnA5M7weW3ELiXVtmItecO6telkSzYE=;
        b=hwAfFIfnpipfGo/HAGd3gg7FaajLQO7ajqm42gqr/F3rNQK0HWX6t4TXIiiTCkFhy9
         YgzecKQrOuF8bQhtBvw+AtoE4wdARo88YW8aBYdFUFU/Fke4ijgorTBlSZ9Tnn6PuPmS
         zz7tlKo8axDoFQXLnj1EIAxXfLf5Uj7KPtWXnjHib5Zumn4WDFwvceez4GT8N/0xhj2s
         AnnAq9bs3QiHCgudU01vLKZvQ3/ZiDirxrLVeqpET1eseRMfjuJv2XJwC+bzqaHHAUW1
         WW3RIE8bOlaJsFDTDYRqdXESL5x9tGJuky00rfGYgPHXTroUOYSW/at0zn/RIvCseJwD
         bqJQ==
X-Gm-Message-State: AFuF++mN8ENXhw9r6O3rg2yeAQEEzx6fva5B3u72nnKi0X/3LShBici7
	351/TpmDaJdvrd5r3VJNTJUNxyLIwYbR7aLvvOhvStnUqOfO7jRD/MCovMxtx+V+uguu5mG882C
	jnK9TKvvzKvgKzqshm/KZ+1/N9WEAqaIc2tuFbAGBzD1bwMm6I/1RRLM3BhZfb/Cq6JMSEMbZJe
	m1/db2X2HzjgrkJztC1DFksmEeyETt8A==
X-Received: from plao19.prod.google.com ([2002:a17:903:3013:b0:2db:1fc8:4e2e])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2781:b0:398:9c00:29ee
 with SMTP id 98e67ed59e1d1-39b26289136mr66346991a91.22.1789050417446; Thu, 10
 Sep 2026 07:26:57 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:26:51 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260910142655.3281464-1-praan@google.com>
Subject: [PATCH v4 0/4] iommu/amd: Refactors for ATS robustness
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

This series forms the second half of the subsystem-wide ATS robustness
updates. The first part (focusing on the core subsystem, Intel, and ARM
SMMUv3) has already been merged upstream [1]. This half addresses the
AMD IOMMU driver and standardizes the PCI ATS API.

In v2, the series has been significantly restructured based on feedback
on v1. 

[v4]
 - https://lore.kernel.org/all/20260824122347.1588592-1-praan@google.com/
 - Dropped iommu_ignore_device() and dropped patch 3 per discussion with
   Jason and Vasant.
 - Renamed iommu_lookup_device() to lookup_device().
 - Cleaned up amd_iommu_probe_device() to return error pointers directly.
 - Collected Reviewed-by tags from Jason, Vasant and Sami.

[v3]
 - Collected Reviewed-by tags from Vasant.
 - Added a comment explaining why devices without DMA translation support
   are not ignored (to preserve interrupt remapping) per Vasant's feedback.
 - Renamed iommu_disable_device_dma() to iommu_disable_device() to
   accurately reflect that it disables both DMA and interrupt remapping.

[v2]
 - https://lore.kernel.org/all/20260814015647.3370124-1-praan@google.com/
 - Patch 1 Refctors the probe path, isolating capabilities into 
   iommu_init_device_caps().
 - Patch 2 renames iommu_ignore_device() to iommu_disable_device_dma().
   Following Jason's suggestion, it invalidates the hardware DTE by
   clearing the Valid bit (lower 128 bits) followed by the upper
   128 bits.  
 - Patch 3 splits the probe error paths to ensure that devices with
   config failures (like PD_MODE_NONE or ATS mismatches) can preserve
   their rlookup_table entries, successfully keeping IRQ remapping 
   functional for bypassed devices.
 - Patch 4 implements the "Fail Hard" pattern for ATS in the AMD driver,
   failing the probe and throwing a WARN_ON() upon ATS configuration or
   enablement failures.
 - Patch 5 enforces the checking of pci_ats_supported() prior to calling
   pci_prepare_ats() across the entire kernel PCI subsystem.

[v1]
 - https://lore.kernel.org/all/20260601134204.2150602-1-praan@google.com/

Thanks,
Praan

[1] https://lore.kernel.org/all/20260615235037.259909-1-praan@google.com/

Pranjal Shrivastava (4):
  iommu/amd: Refactor device probe and capability initialization
  iommu/amd: Remove iommu_ignore_device()
  iommu/amd: Fail probe on ATS configuration failure
  PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()

 drivers/iommu/amd/iommu.c | 164 +++++++++++++++++++-------------------
 drivers/pci/ats.c         |   6 +-
 2 files changed, 86 insertions(+), 84 deletions(-)

-- 
2.55.0.1003.g10538fe699-goog

