Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D972949CF5D
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 06:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047178; cv=none; b=Ux9GUfkrExSUnqKjrvQAWgai05WwziGWvI8NzIkTrK25QGBwf/gAF5yORppPS4SastZvhW+nxgQe25FTw11nKe0CG5mAp7i2XFpFRD2T60C7JfFqqIPJQ2+WQ1dQD3CIWJ5cg5L143z1FHf7Daz0Ns1zKfCXk7JLBtUTFH3jXQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047178; c=relaxed/simple;
	bh=NAZzbrZ0ghYjiDnLPJMUT2odWpqPsyRG3/eqddghz0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ssq3voPmOO/gfn0IkO7LDCtROLi1K/H73ILZVg4GiLw9ChXH+87MYSzodcyuJbFJqlAXliJy/ohdPOSde4c05EYKu2DaSKuZsuKTqIFrpTcbDD/KY8ZT2tU7XZ4O+G1VScGh3YK21BiI+P2EQ7HGIDKEnN2tGMg1uB1MQnyrdwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn; spf=pass smtp.mailfrom=sanechips.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j4zKb1TSJz4yh0n;
	Thu, 15 Oct 2026 14:52:51 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
	by mse-fl1.zte.com.cn with SMTP id 69F6qi6w013950;
	Thu, 15 Oct 2026 14:52:44 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 15 Oct 2026 14:52:46 +0800
X-Zmail-TransId: 3e816ad0783e024-555a1
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Tomasz Jeznach <tomasz.jeznach@linux.dev>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        Fangyu Yu <fangyu.yu@linux.alibaba.com>,
        Wu Fei <wu.fei9@sanechips.com.cn>,
        Zhao Qingye <zhao.qingye@sanechips.com.cn>,
        Gong Shuai <gong.shuai@sanechips.com.cn>,
        Gong Shuai <gsh517025@gmail.com>
Subject: [RFC PATCH 10/12] RISC-V: KVM: Accept auto-mode interrupt files for IMSIC IRQ bypass
Date: Thu, 15 Oct 2026 14:52:30 +0800
Message-ID: <20261015065232.604503-11-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015065232.604503-1-gong.shuai@sanechips.com.cn>
References: <20261015065232.604503-1-gong.shuai@sanechips.com.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl1.zte.com.cn 69F6qi6w013950
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 15 Oct 2026 14:52:51 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD07843.000/4j4zKb1TSJz4yh0n

The IRQ bypass required the AIA to be in HWACCEL mode, while the KVM
default is AUTO, which publishes an IMSIC VS-file whenever one is
available and only falls back to the SW-file when the host has none
left. Rejecting AUTO leaves every assigned device on host MSI delivery,
which cannot work for a device attached to a nested domain because its
stage-1 page tables belong to the guest, so the device keeps the host
MSI address composed at vector activation and its MSIs fault in the
guest stage-1.

Co-developed-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 arch/riscv/kvm/aia_imsic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index 37e27f28dc62..010f9a90f107 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -981,10 +981,13 @@ static int imsic_irqfd_forward(struct kvm_kernel_irqfd *irqfd,
 	 * MSI-X because pci_write_msi_msg() masks an MSI-X vector around the
 	 * update, which conventional MSI cannot provide.
 	 */
-	if (kvm->arch.aia.mode != KVM_DEV_RISCV_AIA_MODE_HWACCEL ||
-	    !imsic_irqfd_is_msix(irqfd))
+	if (!imsic_irqfd_is_msix(irqfd))
 		return -EOPNOTSUPP;
 
+	/*
+	 * The IOMMU writes MSIs straight into the VS-file, so bypass is
+	 * gated by the hardware backing checks below, not the AIA mode.
+	 */
 	if (!imsic_targets_valid(&kvm->arch.aia)) {
 		pr_debug("KVM: IMSIC IRQ bypass requires all VS-files\n");
 		return -EOPNOTSUPP;
-- 
2.53.0

