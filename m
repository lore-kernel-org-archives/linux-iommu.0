Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651D749DBA3
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 06:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047179; cv=none; b=shgOkJcBL4TC1+06sjRN72HApxJ6H2TOzqse/s/+V8Xgb44pMbltUxvCMwr0dI+1zY7mefOQ9B/yNCAsmiKhAY4W/ytTr9+jh53axBKnWAndKm9SDz6ozr7V2G5YGtE90I85ITVLgSkOk81fu92Shz5GqvtKmQO8Q/zPrcEy1SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047179; c=relaxed/simple;
	bh=i8CWjC5rVdo92dxQJLn7ddk7ijxX4u2um0IGc6rgft4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuf81mq2XlVs9ZTxUJ7MP+NSYlUcMtq6ThhnQwgy2Yg1qT/DobKW/RdwN4DpKGiOIT9rcMFdMywoX/LHNgNjjtP9kJ1LT0UdAs+lPT2d5pRdhxuVKpHjhVxdS4MnH+snDXfYuzvT/YLx1zTrFG1xBByp5bYxuOWlIB+KVYPBQ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn; spf=pass smtp.mailfrom=sanechips.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j4zKb5VzQz8XrrX;
	Thu, 15 Oct 2026 14:52:51 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl2.zte.com.cn with SMTP id 69F6qgc6019110;
	Thu, 15 Oct 2026 14:52:42 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 15 Oct 2026 14:52:44 +0800
X-Zmail-TransId: 3e816ad0783b024-55553
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
Subject: [RFC PATCH 07/12] iommufd: Add RISC-V IOMMU hardware info type
Date: Thu, 15 Oct 2026 14:52:27 +0800
Message-ID: <20261015065232.604503-8-gong.shuai@sanechips.com.cn>
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
X-MAIL:mse-fl2.zte.com.cn 69F6qgc6019110
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 15 Oct 2026 14:52:51 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD07843.000/4j4zKb5VzQz8XrrX

From: Wu Fei <wu.fei9@sanechips.com.cn>

Add IOMMU_HW_INFO_TYPE_RISCV and struct iommu_hw_info_riscv, which
reports the RISC-V IOMMU Capabilities register through
IOMMU_GET_HW_INFO.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 include/uapi/linux/iommufd.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 36e6187bb34b..acfef0338cd1 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -716,6 +716,14 @@ struct iommu_hw_info_amd {
 	__aligned_u64 efr2;
 };
 
+/**
+ * struct iommu_hw_info_riscv - RISC-V IOMMU device info
+ * @capabilities: Value of RISC-V IOMMU Capabilities register
+ */
+struct iommu_hw_info_riscv {
+	__u64 capabilities;
+};
+
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
  * @IOMMU_HW_INFO_TYPE_NONE: Output by the drivers that do not report hardware
@@ -726,6 +734,7 @@ struct iommu_hw_info_amd {
  * @IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
  *                                     SMMUv3) info type
  * @IOMMU_HW_INFO_TYPE_AMD: AMD IOMMU info type
+ * @IOMMU_HW_INFO_TYPE_RISCV: RISC-V IOMMU info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE = 0,
@@ -734,6 +743,7 @@ enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_ARM_SMMUV3 = 2,
 	IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV = 3,
 	IOMMU_HW_INFO_TYPE_AMD = 4,
+	IOMMU_HW_INFO_TYPE_RISCV = 5,
 };
 
 /**
-- 
2.53.0

