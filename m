Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C361A920
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 00:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742344984; cv=none; b=TcTawGa1ra+N0dbMrcnvn3Of+SVcnsyEykqA95OCcltxVpSi+AAQQ95SBzP2jvp7gx9bZnuO+cpO+LG/Jfr2NZD+uzkJ2by4hM48AGMEdjqTtoHWPntIDrrMNFA9hEZRrU0Tw1+acv0xqGAUgSK0h2SFY2tb9vHMXxRCnbxJ+fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742344984; c=relaxed/simple;
	bh=oEbgauRYVM2vil5AKnD+Pu4dpCKn4ly/vMEvXKWl6tk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T3W+EoXXHWYERrY0bZSgQHqR21ZutLdYBp+CHUtYbeYsmGJgYGUirIQPOYsGXC28m6Tfctdg+thwnpa146dfICbXXojAQQcpJ67by0RWulehKZ28nGJMLZ1M3M0H+IF92CuAvkIcVmFgr2WtdAf/6fS3KwoyAbD3TxFbtahIRHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fg7l95J9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fg7l95J9"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-225429696a9so173685765ad.1
        for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 17:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742344983; x=1742949783; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bpkVMltpOmPtfh1NuTvLphBSrA0C0isicdTDrxSDKYs=;
        b=Fg7l95J9c5re5a7E7w65y2sFIwlh0CCPNBwVHAgw7OY+Lr38oAJGPnX1voH2RZWpDI
         1ph7ABWfHWR+HT2BUhqUFik2H6clmjWnSEe8nlE4y9/elvJ40Hwzb8OPKp60kiHopHd4
         FU0H1xwkMd8TP+fvdtaIdHfbXuj7BkB2LJkzMYSmOPvLwWmzRA7YdF9I65c3INNFVRQO
         my3incppH/VX4UbDeM338cY6bMGlxOPZeA4sRcP5NqdSHIyKLlzXo/n887fG7+0Bt9sB
         Q6BWYyynk3vl6efpAeiM97JH//DAnY5Hl+J6ec9Wap00CCbpHv0g9x2KUtCo6l9hWeHy
         u7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742344983; x=1742949783;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bpkVMltpOmPtfh1NuTvLphBSrA0C0isicdTDrxSDKYs=;
        b=maNMxZzDKwYo7mSNmwoumZ0A6XcOdmPpNWPvkdFxmElzYtcg5uPiJuJ/NH6vuN9J9u
         t/JLwllKIMiBhX06EWCqKFHihPpgyCv9Pv2rmv37KzW0QZo83tsY+gPGkMEDv2P2JnwX
         LxnZWYeSE5vYy6+oYeD4Ur6QdxQw1mmjTCp4cq9R8jZ5Y/2i4kOpLWwXFOCsVl+qPvTa
         Fd08YUj0JS0afwQYzysd8uvYrdmQWsX5IkNHal+2FpY4uvD3Ym+9pgELQ7snWbrTCwMd
         koQfqeSa1d6NjRI8SJPQN93Yw+Up0a7yZrnG0ZgUY3emzoptJHOPnMnT/oX1zR3hqeHH
         6XlA==
X-Forwarded-Encrypted: i=1; AJvYcCXsqMSn7+8uQE8PWasssPkklec+sRtdl+j9qRAXmGr/LmQYDGzyI8+It135GLiIkGlJR3fIOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6koPJCjGZdNCIG20QIGXvoqWbxrvf1jnZf5+8QTIPJAtekv1Z
	5pQgwQI2pyFgEap0j1vWDo+1XwQaIfxx53miQXNU1AyxlKwEjB/6MmSUfOW2aJB4lONzNhDrSg=
	=
X-Google-Smtp-Source: AGHT+IFIxep13ZV9awdXgXkZ/APZIXzS8TmGAHIxBWR5q/nwFKxfnozdiyTw3009Qtg7y36fGmjTcfTG6g==
X-Received: from pfbff23.prod.google.com ([2002:a05:6a00:2f57:b0:736:af6b:e58d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a86:b0:736:5545:5b84
 with SMTP id d2e1a72fcca58-7376d5ea4ddmr1369035b3a.3.1742344982643; Tue, 18
 Mar 2025 17:43:02 -0700 (PDT)
Date: Wed, 19 Mar 2025 00:42:49 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250319004254.2547950-1-praan@google.com>
Subject: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System Sleep ops
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

As arm-smmu-v3 rapidly finds its way into SoCs designed for hand-held
devices, power management capabilities, similar to its predecessors, are
crucial for these applications. This series introduces power management
support for the arm-smmu-v3 driver.

Design
=======
The arm-smmu-v3 primarily operates with in-memory data structures
through HW registers pointing to these data structures in some fashion.
The proposed design tries to make use of this fact for implementing the
suspend and resume ops.

1. Suspend / Resume
An initial idea for the "suspend" op is to wait till the command queue
finishes all commands before disabling the SMMU through CR0. In order to
avoid mis-use / spurious transactions (b/w SMMU disable -> power-down),
the GBPA register is configured to abort all transactions.

The resume operation uses the `arm_smmu_device_reset` function which
re-initializes the HW using the SW-copies maintained by the driver. For
example, prod/cons for queues, base addresses for queues & tables. The
arm_smmu_device_reset also clears the TLBs.

2. Interrupt Re-config
a. Wired irqs: the series refactors the `arm_smmu_setup_irqs` to be
able to enable/disable irqs and install their handlers separately to
help with the re-initialization of the interrupts correctly.

b. MSIs: The thought was of 2 approaches to teardown & re-config MSIs:

 1. Free MSIs on suspend and re-alloc on resume (implemented in series)
 2. Meddle with the msi_desc and use get_cached_msi_msg to resume MSIs.

The first approach (implemented in this series) may be potentially
slower, whereas the second one could reduce the time taken to resume.
However, the second one feels hacky as it forces us to cache the msi_msg
in `arm_smmu_write_msg` or in the core code (`irq_chip_write_msi_msg`)
as suggested in [1].
  
3. Invoking runtime_pm_get/put
Given that most of the configuration done by arm-smmu-v3 is stored in
memory, the initial idea is to focus on areas where the driver accesses
the hw via exposed ops, like iommmu_ops, iommu_flush_ops, sva_ops etc.

Instead of wrapping every exposed op with an rpm_get/put, the idea is to
follow through till a logical common point (lowest common ancestor in
the call hierarchies) and wrap those with the rpm_get/put calls.

Future Work
===========
- Elide TLBIs when the SMMU is powered down

Call for Review
================
Any insights/comments on the proposed changes are appreciated,
especially in areas related to locking, atomic contexts, early resume
etc. or any potential optimization.

Note: The series isn't tested with MSIs as I couldn't find a platform
that supports MSIs. Any help in testing MSIs is appreciated.

References
===========
[1]
https://lore.kernel.org/lkml/20210721013350.17664-1-cuibixuan@huawei.com/T/#m06bf92e2306ba52c106f2d4d24765921d4e9781e

[2]
https://lore.kernel.org/all/20180830144541.17740-1-vivek.gautam@codeaurora.org/

Pranjal Shrivastava (5):
  iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
  iommu/arm-smmu-v3: Add a helper to wait till cmdq drains
  iommu/arm-smmu-v3: Implement pm_runtime & system sleep ops
  iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
  iommu/arm-smmu-v3: Invoke pm_runtime before hw access

 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  22 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  24 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 297 ++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   5 +
 4 files changed, 326 insertions(+), 22 deletions(-)

-- 
2.49.0.rc1.451.g8f38331e32-goog

