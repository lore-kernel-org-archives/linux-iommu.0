Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B685C478847
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382385; cv=none; b=BBsTNGFNSNG/g8iI2Hns6/hjq9FQ+V64LflPkAQlo53pK6PH8NtSDYOgS/nVRksSj0j7FtlxfAQiHlNkol18JE5ZvZRYic/oM3hpV5pihJfuPex5WOPLC1yc7enDiYxBRMc4omkBA+/6srewFXCEzCvhMkagsbu/2P9UoaRniVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382385; c=relaxed/simple;
	bh=TJtwwmOes+WMqZV10KyeFqw49c64kqL7395J+MxsNMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hq5JJa2vrezhvQqyz27PPwO/7E97IaHAI7EaobxlNhCKJ0/zstWn8cFMb7Jy7+nlrFs+ghpKwsta7/r/4fZAn7BqevhHCuG8PU32spoNzkjDAXvi18h0Xta7KyP9e66DqYzMuMV6qqcq9sf3KI9lFTQE+HDPnIZBRa0so1RWF0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NVrmmP4L; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NVrmmP4L"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777382381; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=RWu/puVJ24xC3wGWoddID7UrDVPs6J4eX8hoo+uZKZs=;
	b=NVrmmP4LLGn6iuN6K5C05HjCzdStpBQu7hBO0dFa4X1l6xFWCQwuPJFNl0xkxzSRr3KzVbWwmsWGGmwZVXGnSeVW68+oSkQ5gwOD98ooFtkNRUIRkP2ZrH49Ud4NfIGE9b+9TkP7opIrJA/Nvah3nQFV8rohhgBSH5gGk+v7gPQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X1ubIFW_1777382060;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X1ubIFW_1777382060 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 28 Apr 2026 21:14:21 +0800
From: fangyu.yu@linux.alibaba.com
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	tjeznach@rivosinc.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	vasant.hegde@amd.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	skhawaja@google.com,
	jgg@nvidia.com
Cc: guoren@kernel.org,
	kvm@vger.kernel.org,
	iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andrew Jones <ajones@ventanamicro.com>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [RFC PATCH 05/11] RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch
Date: Tue, 28 Apr 2026 21:13:53 +0800
Message-Id: <20260428131359.34872-6-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
References: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Enable KVM/VFIO support on RISC-V architecture.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/kvm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index ec2cee0a39e0..54ee90f010ef 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -30,8 +30,10 @@ config KVM
 	select KVM_GENERIC_HARDWARE_ENABLING
 	select KVM_MMIO
 	select VIRT_XFER_TO_GUEST_WORK
+	select KVM_VFIO
 	select SCHED_INFO
 	select GUEST_PERF_EVENTS if PERF_EVENTS
+	select SRCU
 	help
 	  Support hosting virtualized guest machines.
 
-- 
2.50.1

