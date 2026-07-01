Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F517736
	for <iommu@lists.linux.dev>; Wed,  1 Jul 2026 04:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878433; cv=none; b=iT3P1kDGs1Nixnm2QNAKcfm1KbiFytotHSDK7kK8b4bVkfG6e9/3IoE8bWHYBsaZ6UZmuigQBFUcw7+tuJarB4TZJty80c4aQ0w2TxMlH3g39AYT/6pT1KTCQoja2XTINKo8gtnk/xGXdqhd0sThXlNcReU70xN8JqxA7K6PptA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878433; c=relaxed/simple;
	bh=WCIcwrrTPMRmog2SUs+VIrCq0XbCEwlD78QOssRp5n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lS5LZucVBmwKOmiYyJ+yHETS84AShgqHrfQu3Hhvh/sBMqzX7V2KC4ADVj2jYpnFrAHAqWC/ZiXDH0+ORLtgCjBdWoCljNJxJtPA9BppKvM2oAJdkJ2BTYcfPnV3wybYPKn3mTa4JSVc5Ua//zELII1emY9uKSORIFSH4jQksGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=J/sNhYyH; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="J/sNhYyH"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30c591fb1cbso228784eec.1
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 21:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782878428; x=1783483228; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAjXq9Ej4fB7f7nIuAnBVBBySejxitzWJLxvllDtjcA=;
        b=J/sNhYyHyybhk5z6EqDHIZFWPbOcifhfss+C7KNm3RsuJbmgjnR3ww12aangCDtr6V
         xS8HDFqGyGgk73X2kO/W4C4NP/i+hWSfDKSyUXkduXqc1XDir3lQdMsG3OMJ3H3Fv24F
         NeeS0n6CaHPW9HnUZszfrnp5WOjA2HmKxs/0UqyNUM2q5Mz8DEWczbq1BTEJuckoU9rc
         ov8dxSSfXxmzOyC6NtLAY0YUlwLgfPBFvSuIKxKs4Ob8bXU0yr4ACHmPiC4hKaUjb6M7
         L/SRvp5GqIhlkg6A4KNLHiJXS+6XtUY127UdfwQyCB9X8VOamJ6Yh1S7MaTfIb0wXiF0
         H11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782878428; x=1783483228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bAjXq9Ej4fB7f7nIuAnBVBBySejxitzWJLxvllDtjcA=;
        b=GbZmE9aR+7hbk8/moE0GFglrblejwnKJnQeU/ZKTY75qq1fy5T+h+7Csz1M7HFTp3a
         je8Qm7lHKthMoiTaQ4q4jIk/rPhjqWHBbvGa0EdDWrFsBke6JfXje2E/0DM4O9SdE0QR
         cdWjhviaHYJQXKRVko/a0O7MzKnE6+8V4uk+DYsOi6SsfetZ8VUuoRftcwi/cJffNpQB
         Ch1bMhP2qAgxhtDx+aZNOcTDDLLiG+J327nEWTAw+B8Q+G1piVTGslF4DsCp8LeB/MlD
         aI+QSmj506n6IUedHd+/zHwL1L9fCjPHmh/CU3O2dKS6GjBBkjBITQYXR4ZQLd30PvhI
         pX2A==
X-Forwarded-Encrypted: i=1; AHgh+Ro/Tx+v9X+wbKYq0hTinwwA0J56gyT3xVh/hsrm/A6WHASh6LSkNxfSESxPOhhvJxfgCi29tw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNbYfMLFRncEtdEETpkXbWQvr0twCulEp9pyVap8q9S2og1Htq
	3/ffyiYRp6FoAdykh1DSwT7qKH0dUFELwW3EE7iuwX3X99ngEJEhIFIbKZpc0qcofGA=
X-Gm-Gg: AfdE7ck5u097dmY2yBWHLAIRJ9ZrZnCioMFMB09FnLIaspgjjmQtZUlW4G6rbJiOoTw
	ys4uLOOfobgZ5UWFVHWr7WMkwLMzklS5dR6ZQ0oITywCFMDg11gKpYF9TzHFZBUXicJx8PqxZZy
	vF2rPDBdv8tGvjQYw/+rAztggb4mwx23FwSXUemiJlwp2AhioA7dqjuJ+Gi1gFBAhUOXJ2Pv/4t
	uV8G9kY1BQfkcgTUJtQT98lKbo9UsB7W8ax4hi7NhqgcXUEYABBRb4+FaQV0fIyWvDE7HjFg9CT
	+VzqejwBPeoeId+otXO/9o3TruldVm2JvIoO7KN1UeikUDE2XeL5ye2l6Hwpzz9vpbyi5zGmX17
	h4q+6zIQaxYK0NC5exem+1BOCYjMBZ2Q1JQh7nYbSVbBhjxsudxfgvWrz5krikHaxOgQTIfqL9+
	AX9Q9PPJ5M5gt6qZFUlkQAfzKn9x7PSWC6gU6NLSiLMuSfzBWuuYTpNlag+q4Jcyc8
X-Received: by 2002:a05:7300:d516:b0:30e:c801:eace with SMTP id 5a478bee46e88-30eff05c70emr10195eec.5.1782878427991;
        Tue, 30 Jun 2026 21:00:27 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee32519aesm14024287eec.27.2026.06.30.21.00.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Jun 2026 21:00:27 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	cuiyunhui@bytedance.com,
	yuanzhu@bytedance.com,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] RISC-V: KVM/IOMMU: Fix MRIF irqfd notice handling
Date: Wed,  1 Jul 2026 12:00:13 +0800
Message-ID: <20260701040017.42707-1-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811061104.10326-1-fangyu.yu@linux.alibaba.com>
References: <20250811061104.10326-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Fangyu,

I put together a local test branch based on Andrew's RISC-V IOMMU
irqbypass series [1] and your MRIF RFC series [2], then ran VFIO device
assignment tests on hardware on top of that combined tree.

One test case that exposed a problem was a VFIO guest started with QEMU's
AIA emulation mode, e.g. `riscv-aia=emul`.  The guest could hang because
a normal MSI injection was classified as a MRIF notice, so KVM skipped
the software IMSIC EIP update and the interrupt was never made pending.

The issue is that the current code identifies a MRIF notice by comparing
the injected guest interrupt ID with cached host MSI data:

    msg->data == iid

That is a payload value comparison, not a source/provenance check.  A
normal MSI injection can carry the same interrupt ID value as a cached
host MSI message.  If the vCPU is currently using the software IMSIC file
and this collision happens, KVM can misclassify the normal MSI as a MRIF
notice, skip the software IMSIC EIP update, and leave the guest waiting
for an interrupt that was never made pending.

This series identifies MRIF notices by irqfd route provenance instead.
irqfd_wakeup() already injects from a seqcount-protected copy of
irqfd->irq_entry, so patch 2 keeps the architecture's MRIF notice metadata
in that route snapshot.  Userspace MSI injection and normal guest MSI
injection do not carry irqfd MRIF provenance and therefore follow the
normal software IMSIC path.

The generic KVM change is needed because the decision must be made from
the same copied route that irqfd_wakeup() injects from; keeping the
provenance in RISC-V side state would not be tied to that route snapshot.

Feel free to fold any of these patches into previous commits if you think
that is a better shape for the next version. I also have a few other local
adaptation and improvement patches on top, but kept them out of this series
to focus on the MRIF notice issue. Please let me know if you already have a
plan for the next revision, I am happy to support your next version in
whichever form is useful.

Zhanpeng Zhang (3):
  iommu/riscv: Complete MRIF MSI PTE setup
  KVM: Move irqfd arch data into route snapshots
  RISC-V: KVM: Identify MRIF notices from irqfd snapshots

These patches are based on a combined tree, not a plain upstream tree.
The combined tree is made up of the following pieces:
In your series, patch 4/6 is already covered by the irqbypass series [1].
I ported patches 1/6, 2/6, 3/6, the relevant MRIF MSI PTE part of 5/6,
and the notice handler part of 6/6, with a few integration changes.

Fangyu Yu's MRIF RFC series [2] (selected patches):
  [1/6] RISC-V: Add more elements to irqbypass vcpu_info
  [2/6] RISC-V: KVM: Transfer the physical address of MRIF to iommu-ir
  [3/6] RISC-V: KVM: Add a xarray to record host irq msg
  [5/6, adapted] iommu/riscv: Add MRIF mode support
  [6/6, adapted] RISC-V: KVM: Check the MRIF in notice MSI irq handler

Andrew Jones et al. [1] (irqbypass series, omitted):
  [RFC PATCH v2 00/18] iommu/riscv: Add irqbypass support

[1] https://lists.infradead.org/pipermail/kvm-riscv/2025-September/010148.html
[2] https://lwn.net/ml/all/20250811061104.10326-1-fangyu.yu@linux.alibaba.com/
