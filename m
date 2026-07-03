Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74D13D6461
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082330; cv=none; b=ee1qoxLzcHfm5Ih9Ov5UWLJ8TYuCfnljClbFIPVKWSGzByz9LKQ/QHqJJ+EJJQDp29a624bjYXS1wozKyVXP3Nx+/XAwANYgY+HzotOXIGGnD9wDglb9w7I4XWsxeFGHV66hlEQ/TSMo/C4ivjFu1xBbOadtnUwp3TBq60sQqSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082330; c=relaxed/simple;
	bh=7cqKQ9nuMZFC/0h39B8BTWb/IrgOChDNbyiwXPKmKNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hrix6sCuj0UMO6YlSP0eWclb5bqdkXf9YugJAXBcJvHZxCnLXQBvQdsX+s7HkYN41paJMk2DhNy51kbC2/Y1FONPydV1hdJaJWo/SOFnXegiIZfwM/ahXsAC4iDMxNURn8NklJnMk/ZTIAlFxbxkkYbZHuvLmySkunqGTVzSSoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lx/4tCcE; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lx/4tCcE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783082320; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=K8IESsN7IazgF4kkAKc3Bjn0YxF6z3ruog0n74pY0Hc=;
	b=lx/4tCcE3j9pBL/EYarlFvM2Z334PsbGudNQlhwSTQ1MfOSOgqGfWY6BpuQQmPbUFLPG20i/wgNi8vzxcVRScr4PpXWFLsmgEweCSV8DbzR75GV/IPbyh4BRfjAD2LiZZjaAlVs2I8L6bfNeptvZWuW+Z4jf2ZQJY//8tEQXa3U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0X6JE1Zq_1783082316;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X6JE1Zq_1783082316 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Jul 2026 20:38:38 +0800
From: fangyu.yu@linux.alibaba.com
To: zhangzhanpeng.jasper@bytedance.com
Cc: ajones@ventanamicro.com,
	andrew.jones@oss.qualcomm.com,
	alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	cuiyunhui@bytedance.com,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pbonzini@redhat.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	will@kernel.org,
	yuanzhu@bytedance.com
Subject: Re: [RFC PATCH 0/3] RISC-V: KVM/IOMMU: Fix MRIF irqfd notice handling 
Date: Fri,  3 Jul 2026 20:38:35 +0800
Message-Id: <20260703123835.41006-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260701040017.42707-1-zhangzhanpeng.jasper@bytedance.com>
References: <20260701040017.42707-1-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>Hi Fangyu,
>
>I put together a local test branch based on Andrew's RISC-V IOMMU
>irqbypass series [1] and your MRIF RFC series [2], then ran VFIO device
>assignment tests on hardware on top of that combined tree.
>
>One test case that exposed a problem was a VFIO guest started with QEMU's
>AIA emulation mode, e.g. `riscv-aia=emul`.  The guest could hang because
>a normal MSI injection was classified as a MRIF notice, so KVM skipped
>the software IMSIC EIP update and the interrupt was never made pending.
>
>The issue is that the current code identifies a MRIF notice by comparing
>the injected guest interrupt ID with cached host MSI data:
>
>    msg->data == iid
>
>That is a payload value comparison, not a source/provenance check.  A
>normal MSI injection can carry the same interrupt ID value as a cached
>host MSI message.  If the vCPU is currently using the software IMSIC file
>and this collision happens, KVM can misclassify the normal MSI as a MRIF
>notice, skip the software IMSIC EIP update, and leave the guest waiting
>for an interrupt that was never made pending.

Hi Zhanpeng,

Thanks for reviewing and testing my patches, and for pointing out
the race condition issues. Your analysis is very helpful.

A few notes on the current status:

My original patches were based on Andrew Jones's tree [1]. Andrew
has since published a v2 [2], and I have adapted my work on top of
that version with some additional fixes. However, Andrew's v2 still
needs further adjustments, so I plan to rebase onto his v3 once it
is available.

When I send out my v2, I will take your patchset into consideration.

Thanks again for your effort.

[1] https://github.com/jones-drew/linux/tree/riscv/
    iommu-irqbypass-rfc-v2-rc1
[2] https://lore.kernel.org/linux-riscv/
    20250920203851.2205115-20-ajones@ventanamicro.com/

Fangyu

>This series identifies MRIF notices by irqfd route provenance instead.
>irqfd_wakeup() already injects from a seqcount-protected copy of
>irqfd->irq_entry, so patch 2 keeps the architecture's MRIF notice metadata
>in that route snapshot.  Userspace MSI injection and normal guest MSI
>injection do not carry irqfd MRIF provenance and therefore follow the
>normal software IMSIC path.
>
>The generic KVM change is needed because the decision must be made from
>the same copied route that irqfd_wakeup() injects from; keeping the
>provenance in RISC-V side state would not be tied to that route snapshot.
>
>Feel free to fold any of these patches into previous commits if you think
>that is a better shape for the next version. I also have a few other local
>adaptation and improvement patches on top, but kept them out of this series
>to focus on the MRIF notice issue. Please let me know if you already have a
>plan for the next revision, I am happy to support your next version in
>whichever form is useful.
>
>Zhanpeng Zhang (3):
>  iommu/riscv: Complete MRIF MSI PTE setup
>  KVM: Move irqfd arch data into route snapshots
>  RISC-V: KVM: Identify MRIF notices from irqfd snapshots
>
>These patches are based on a combined tree, not a plain upstream tree.
>The combined tree is made up of the following pieces:
>In your series, patch 4/6 is already covered by the irqbypass series [1].
>I ported patches 1/6, 2/6, 3/6, the relevant MRIF MSI PTE part of 5/6,
>and the notice handler part of 6/6, with a few integration changes.
>
>Fangyu Yu's MRIF RFC series [2] (selected patches):
>  [1/6] RISC-V: Add more elements to irqbypass vcpu_info
>  [2/6] RISC-V: KVM: Transfer the physical address of MRIF to iommu-ir
>  [3/6] RISC-V: KVM: Add a xarray to record host irq msg
>  [5/6, adapted] iommu/riscv: Add MRIF mode support
>  [6/6, adapted] RISC-V: KVM: Check the MRIF in notice MSI irq handler
>
>Andrew Jones et al. [1] (irqbypass series, omitted):
>  [RFC PATCH v2 00/18] iommu/riscv: Add irqbypass support
>
>[1] https://lists.infradead.org/pipermail/kvm-riscv/2025-September/010148.html
>[2] https://lwn.net/ml/all/20250811061104.10326-1-fangyu.yu@linux.alibaba.com/
