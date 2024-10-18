Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FDC8472
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274438; cv=none; b=sAzH8dArzIYFDLWfoJlg67WW0w0Kbb6C7IrKyzl9+ohot1LqCL8fVQdzt2onSeR5I/ZyibBqNf+vPZPWBUFhuOXRrv8kJTL4FnFT1qJ9eNSo2M2uP5cdATwfzHCfLu+VjsbbdGV6Wl5AkcaDedDKscDkcYfpx+7dFT0FNHnunbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274438; c=relaxed/simple;
	bh=a/L5fdQR3fEzFRwpbKesW1iOC3yEFk1QCGp0aVKpOfo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=j+DkiTINySTAmoEflaEt6zaN9TaSJ96jsc0kj31D4BPCWdoKrZeP+tMreKdoX9MZQrte8LRwmzJGFGruIHhcLPM27p9a+Fk0dfYDetDqznJmGVRGYXI/I9i9T53DhMDv0Tq41QGCHSy/QA65jqBlrpE9omeTaK792siG/phpFtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WjCE+f02; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WjCE+f02"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3529d80e5so41676717b3.0
        for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 11:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729274435; x=1729879235; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fR2sf32m9kDFEdWAXHYli8WnFKl2I2tscMKweSqFIL8=;
        b=WjCE+f02HwSRfUXX1rHZDjPquDPWUkXR85pMuiN6oSNLq/UJKrptIIbWX8Giw2iFuk
         AcxCD55alKpXyyPW1mx/48Z993nuJztQg9nc0o2H/b/9/HMAmxXL3LGjU5Y5tbaRI2em
         2MVCdlRciQjtXd4XaoRTHktdfk8/W8PPg4nm0Kqr7xnxIAt+Y8eOPCL5IyDI1eGmY+IY
         t13PlC20+Tr4nb0sNiNsjF03hlplisIqDfvIA5+oV8uPUdDarfXQ350ao4+evkhHeqDB
         17T9iHRwe9kkGHaKVnmYqXStW3nONLsJ7cseyOG3do5Q5yIGx15X8E2mQrzMsoo9xtf6
         Ybcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729274435; x=1729879235;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fR2sf32m9kDFEdWAXHYli8WnFKl2I2tscMKweSqFIL8=;
        b=C57bYLxieHuUlHQCB45w0oEhy0+0IuFaIVRs0lxuyinHxiyS09IP6DctjLbO48cQ8o
         gdnMbSKrIK34Qm61CH9J7lj5pNXZgKrtoqVBwU6MR+TliCWF+MXRVxD0YGQ2ZiqTbCqr
         ZmH//sgarohtSeOXL4Qukcz2eeLlCQkyBQqTiOfhO4P85Vk0rEJ5YndIp9m/4D/HnrAU
         KGqoaSED3d2kqDQyskNSH5LEA40MLFGuo1L3ndr42EzkrjRYg3PbCFtgdcf0fWROJLmS
         n9SqVMCQ/8zO86Wr/PJdc4zIxKSKv1FtkUPHsSq/kCmA2gpW5IQe3gP+EWtAupV70rJ5
         aPKw==
X-Forwarded-Encrypted: i=1; AJvYcCXI9qe3T3rqNGv0UwHwl0e4FseHyLfweOpFaZuLMYV0zIURVV/FbNrVvX3rZhibNmfVTH+j+g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx79xdMRtpDX+3CSdRB77V9jAsYv//uxor3+emQZLhQIT4NQJx5
	TZgaLSnPHo5sO8ixc9DfHKZS12Dr1Y9HXZPnQZGNEajuGagDDWEHeWM9RzGeI2hF3eJH4mQZdA=
	=
X-Google-Smtp-Source: AGHT+IHXHkJwVHgtSBl8Jl2JjQoHYiPHT+SS9mXwnwDBb1Cy8YZ4yG5s6rF3oOqZY7q1zwe3Yu02H0YH1A==
X-Received: from praan.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3e89])
 (user=praan job=sendgmr) by 2002:a05:690c:4b05:b0:64a:e220:bfb5 with SMTP id
 00721157ae682-6e5bfbe52c9mr575367b3.1.1729274435563; Fri, 18 Oct 2024
 11:00:35 -0700 (PDT)
Date: Fri, 18 Oct 2024 18:00:19 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241018180022.807928-1-praan@google.com>
Subject: [PATCH v4 0/3] iommu/arm-smmu-v3: Parse out event records
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Enhance the arm-smmu-v3 driver to parse out useful information from
event records into a structure for better event handling & logging.

As requested by Nicolin, some sample logs powered by QEMU:

[   85.410290] arm-smmu-v3 arm-smmu-v3.0.auto: Unexpected event received: F_PERMISSION
[   85.410290]  master: 0000:00:01.0 sid: 0x00000008.0x00000
[   85.410290]  iova = 0xffffc0d0 ipa = 0x0
[   85.410290]  Unpriv | Data | Write | S1 | Input address caused fault
[   85.410290]  STAG = 0x0 Stall = 0x0
[   85.411681] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x13 received: master 0000:00:01.0:
[   85.412045] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000800000013
[   85.412347] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000020000000000
[   85.412630] arm-smmu-v3 arm-smmu-v3.0.auto:  0x00000000ffffc0d0
[   85.412921] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000

..and a sample log for devices with a good name:

[   43.405187] arm-smmu-v3 arm-smmu-v3.0.auto: Unexpected event received: F_TRANSLATION
[   43.405187]  master: igb sid: 0x00000008.0x00000
[   43.405187]  iova = 0xfffff040 ipa = 0x0
[   43.405187]  Unpriv | Data | Write | S1 | CD fetch
[   43.405187]  STAG = 0x0 Stall = 0x0
[   43.406302] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x10 received: master igb:
[   43.406622] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000800000010
[   43.406875] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
[   43.407131] arm-smmu-v3 arm-smmu-v3.0.auto:  0x00000000fffff040
[   43.407397] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000

v4
 * Re-arranged the series to first introduce struct arm_smmu_event
 * Improved the complex ternary expression that prints TTRnW info
 * Added consistent spacing to the logs & resized log strings
 * Moved ratelimiting within `arm_smmu_dump_event`
 * Refactored master_name printing by getting a ref to the device
 * Refactored `arm_smmu_handle_evt` to avoid redundant master lookup

v3
 https://lore.kernel.org/all/20240928005143.2378938-1-praan@google.com/
 * Fixed a potential race and null pointer deref for arm_smmu_master
 * Improved the logging approach by using multiple strings
 * Added logs for STAG & STALL fields for relevant events
 * Invoked the log function within `arm_smmu_handle_evt` routine
 * Rebased the changes

v2
 https://lore.kernel.org/linux-iommu/20240827193026.3993039-1-praan@google.com/
 * Addressed review comments
 * Introduced `struct arm_smmu_event` to hold relevant event fields
 * Broke out helper functions to populate & dump event info
 * Modified the event handler routines to use `struct arm_smmu_event`

v1
 https://lore.kernel.org/linux-iommu/20240816211722.1404070-1-praan@google.com/


Pranjal Shrivastava (3):
  iommu/arm-smmu-v3: Introduce struct arm_smmu_event
  iommu/arm-smmu-v3: Log better event records
  iommu/arm-smmu-v3: Avoid redundant master lookup in events

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 174 ++++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  33 ++++
 2 files changed, 172 insertions(+), 35 deletions(-)

-- 
2.47.0.rc1.288.g06298d1525-goog

