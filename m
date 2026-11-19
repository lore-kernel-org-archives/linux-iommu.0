Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094885;
	b=Jat01iLg6TyuIrBMzHS2hhFo22kyR+2XJ2aBv/PMbTWsOPEwGzdpiIsTmIgZM5r9CWq5
	 NuqlRIwVGLkcla+hQoEtDKFW+X8Dp277RTDml1pQrepojeSAClzUGTuBptV143nS5THys
	 jrjDEB+FZu5yowIdH2qIfijrvNlOwxwcEhrEEbMA1gbJ3oxxelndXUEvb3zHq8u8ByNHf
	 AzkcNlAqRIpGp4e3kuCcDA8kuMsbRlrqv1EdEUTdsIXB+FX32BSZEhlkHCEMhHKxp31wT
	 PZ+/BQ5Ap4FFXzJfFCMpSSfYj9yZkNotUkzfsFDR398h4sa2szdxP+U6G9ME68PXyWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094885;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=s+NqJz7bOMzl+5xVCztdeYo/ZvQpc6lYgldrh4wCzKg=;
	b=TwG+lsMlf3g4eTrVngg5ZRDBV0YT5Hbt/2MPV2pqnt/9dbmdXP4X9273UJBAA9CQaOWh
	 vE2CUBxbL/tHreMANMcNZfkpOFf/Z5XFPerGl+wGf8hcUwAYDGjtZTtX6DAhycQpYQvIu
	 bD3gX0LLD2jYf7/DkeKwXtYsSOcYR55eHJ8gfn41sT89LQViPLzvlcJXuv94Tuns4Inu4
	 B1rUHkFKUX1149em0mCyjZkmuzgWuJRXtgzReUAZyaCvHHh9OoKn0CBwQFtX5YrlfdMwU
	 PF77D31tUpsMcoBxpzIBzEAJ8qXC/vjAdzgad/moiJgU9QgBYUHeaNLAAyf1FkVXMIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27573606A32F
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 13:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27573606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jVfRJ41Mwz4yjjD;
	Thu, 19 Nov 2026 21:27:56 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl1.zte.com.cn with SMTP id 6AJDRoIs086380;
	Thu, 19 Nov 2026 21:27:50 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 19 Nov 2026 21:27:54 +0800
X-Zmail-TransId: 3e816afef95902f-5649a
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
        Tan Chi <tanchi25@mails.ucas.ac.cn>, Wu Fei <wu.fei9@sanechips.com.cn>,
        Zhao Qingye <zhao.qingye@sanechips.com.cn>,
        Gong Shuai <gong.shuai@sanechips.com.cn>
Subject: [RFC PATCH v3 03/10] iommufd: Add RISC-V IOMMU cache invalidation data type
Date: Thu, 19 Nov 2026 21:27:37 +0800
Message-ID: <20261119132744.396426-4-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119132744.396426-1-gong.shuai@sanechips.com.cn>
References: <20261119132744.396426-1-gong.shuai@sanechips.com.cn>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl1.zte.com.cn 6AJDRoIs086380
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 19 Nov 2026 21:27:56 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AFEF95C.001/4jVfRJ41Mwz4yjjD

From: Wu Fei <wu.fei9@sanechips.com.cn>

Add IOMMU_VIOMMU_INVALIDATE_DATA_RISCV and
struct iommu_viommu_riscv_invalidate to carry RISC-V IOTINVAL
commands from user space. Define the command payload in the uAPI
instead of relying on the driver internal struct
riscv_iommu_command.

The vIOMMU cache invalidation support added later uses this format
to forward guest IOTINVAL commands to the physical IOMMU.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Co-developed-by: Gong Shuai <gong.shuai@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 include/uapi/linux/iommufd.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 809f4d44c0b0..fee63e6cbb7a 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -926,10 +926,12 @@ struct iommu_hwpt_get_dirty_bitmap {
  *                                        Data Type
  * @IOMMU_HWPT_INVALIDATE_DATA_VTD_S1: Invalidation data for VTD_S1
  * @IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3: Invalidation data for ARM SMMUv3
+ * @IOMMU_VIOMMU_INVALIDATE_DATA_RISCV: Invalidation data for RISC-V IOMMU
  */
 enum iommu_hwpt_invalidate_data_type {
 	IOMMU_HWPT_INVALIDATE_DATA_VTD_S1 = 0,
 	IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3 = 1,
+	IOMMU_VIOMMU_INVALIDATE_DATA_RISCV = 2,
 };
 
 /**
@@ -992,6 +994,32 @@ struct iommu_viommu_arm_smmuv3_invalidate {
 	__aligned_le64 cmd[2];
 };
 
+/**
+ * struct iommu_viommu_riscv_invalidate - RISC-V IOMMU cache invalidation
+ *         (IOMMU_VIOMMU_INVALIDATE_DATA_RISCV)
+ * @cmd: 128-bit cache invalidation command that runs in the IOMMU command
+ *       queue, in the format defined by the "IOMMU Page-table cache
+ *       invalidation" section of the RISC-V IOMMU specification. Must be
+ *       little-endian.
+ *
+ * Supported command list only when passing in a vIOMMU via @hwpt_id:
+ *     IOTINVAL.VMA
+ *
+ * The kernel overwrites GV and GSCID before issuing the command:
+ *     GV = 1 and GSCID = the GSCID assigned to the vIOMMU
+ *     PSCV and PSCID are taken unchanged from @cmd; When PSCV=1, PSCID
+ *     must identify a stage-1 address space of this vIOMMU and match the
+ *     PSCID installed in its vDC. When PSCV=0, PSCID is ignored.
+ *
+ * All other reserved bits must be 0.
+ *
+ * -EIO will be returned if the command is not supported, -EINVAL if it is
+ * malformed.
+ */
+struct iommu_viommu_riscv_invalidate {
+	__aligned_le64 cmd[2];
+};
+
 /**
  * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
  * @size: sizeof(struct iommu_hwpt_invalidate)
-- 
2.53.0

