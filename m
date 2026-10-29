Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254309;
	b=GSbVo9omj7oVBuWrFqGmmTLKc0Ky8se4WcruBDMIQoK1hpDgG9vjsNiuRByMkxK9j81q
	 6Q0fWBTqDFfHLSgnaJoE4MghyUbYf6ejz/1J+xg2yxvjIRY5BwuOlFhNB434fV/aoy+q2
	 fBvd2wk2PlIvbwSHKFN6DlRDrw5Q5v05xEbxpMd+s9ACVqF+c4Jh8opXKaQNGj8CxBiA3
	 uG3gMPtIRXOm/7X2N64jAR2KdkVPpx3tEI62mhfNTFCBtA/IU+JDB+Q0jJABNaU92LtiC
	 gWFXwg4ShqIqlL2AS3YIEJtSSpK0QrjdJ+SibeG1RuO4C34KDRbhaM1+RcZclXYZ+KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254309;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=MStteIkcMwwxtnZ8UipMZgex+tlZTUU7ReE3Mj/L6Pk=;
	b=dTRhT2vHcmgYsoGUhpXmvRmHCqEv6IxBlUjkePFjBxA5+NK/FocBV+BNnrWDuApj+AX4
	 1+yuatRvPxcS/aokrJMN+m9BCZmUAK9sqKJlillVDNRObYwC8KzbDkDvlfAZlZz+kiK5a
	 3EWmn1DYnYiWD7c9Rm7Ft6SbTLt6FWSPplQVMfXjViCq19leyu7obsJyo7KetWSSYmz2m
	 o80uPH4ZoAoMB3yIsIu94VGwoj8rF7YIet1BagnNytLUN/eq3tgCtuQ/mQowpKo89vrHK
	 1Nz/GBJM37ajeIajKKC9IxW/nBHLXhQU1VNkkGT5c/MN9pLr9HYiuJC+dZ+RbkxbaYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E75B606A32D
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 06:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E75B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jFYlc191wz5PkGt;
	Thu, 29 Oct 2026 14:11:40 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
	by mse-fl1.zte.com.cn with SMTP id 69T6BXfO003125;
	Thu, 29 Oct 2026 14:11:33 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 29 Oct 2026 14:11:35 +0800
X-Zmail-TransId: 3e816ae2e396027-e7ce4
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
Subject: [RFC PATCH v2 3/9] iommufd: Add RISC-V IOMMU cache invalidation data type
Date: Thu, 29 Oct 2026 14:11:25 +0800
Message-ID: <20261029061131.584453-4-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029061131.584453-1-gong.shuai@sanechips.com.cn>
References: <20261029061131.584453-1-gong.shuai@sanechips.com.cn>
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
X-MAIL:mse-fl1.zte.com.cn 69T6BXfO003125
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 29 Oct 2026 14:11:40 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE2E39C.000/4jFYlc191wz5PkGt

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
 include/uapi/linux/iommufd.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 5b5ca6e41063..aa65d494b992 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -918,10 +918,12 @@ struct iommu_hwpt_get_dirty_bitmap {
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
@@ -982,6 +984,31 @@ struct iommu_viommu_arm_smmuv3_invalidate {
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
+ * The isolation operands are owned by the kernel, which overwrites them
+ * before the command is issued:
+ *     GV = 1 and GSCID = the GSCID assigned to the vIOMMU
+ *     PSCV = 1 and PSCID = 0
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

