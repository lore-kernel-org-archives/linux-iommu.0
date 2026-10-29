Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254311;
	b=GaGREWda9cARVxf2q+WzEyb6WzZ3vE3SxzCAGPtFthERxOAdAsD+hn7EnZ1+ii3o6NCG
	 4CJMt4MdJnM8uoa4U1tP2UoCLkc84ChAU0w6YLsIqWgyTWTGGF9qk17oHgYnkX8WWTtaf
	 L9UgQCR0WizRKQUmDfZWgkCiZyzEGzePbx23qTYBZ3fCiXsJ1FtA+5yrm6+8oZHCwm7na
	 VfQikcnbnwHwPLmfkgIY2CMmZ5brrNNNuDBRYpl1Hl7SGcgPvm6GEdKEigVA8nqeggZI6
	 C/dQP/7spdC4WE9JzNXqTgLYuzyJaH0YSYaIcOkMk+4bEps98FT5InpJrrsu1FpixgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254311;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=AdgwYMj0LV4KVSZGpI901tCl0Sw9NPDJo9HNw0CYpIw=;
	b=JahHlLCF7mlZdsy/43XehZx9mJ0MshPAcP6Q1iYT36IlFn9xl1buBSFOhFj/YngYOIYp
	 5yWfozYlfhiSlRl1Bl4ubHPiCbBb5RMHTJatkyAzqZrt38p0po4dWHRHwJo3PqLm74DLL
	 v3rvCmtQXFGyuhk+EYMq07OKXddnFP+1zdYc8iDUYcDjKvgra3mJA2DG1YQaU2neIGKyY
	 2kSF0+hXo5XlxxvH3Wob6jLJ412XzEHmXGvw2aY8YO/nHUo+L/fbB4OcsEVn1WmJcm5G6
	 BstNsSepl6TOvGAgW4/p8L0CxaOVoyR2OgQX+aMYvKyB1bZ8maNImAPxXQ+DEnRdMDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65F9606A33E
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 06:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D65F9606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jFYln3DRKz5PkGh;
	Thu, 29 Oct 2026 14:11:49 +0800 (CST)
Received: from szxl2zmapp05.zte.com.cn ([10.1.32.37])
	by mse-fl1.zte.com.cn with SMTP id 69T6BbLX003152;
	Thu, 29 Oct 2026 14:11:37 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 29 Oct 2026 14:11:39 +0800
X-Zmail-TransId: 3e816ae2e39a027-e7d5a
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
Subject: [RFC PATCH v2 7/9] iommufd: Add RISC-V IOMMU hardware info type
Date: Thu, 29 Oct 2026 14:11:29 +0800
Message-ID: <20261029061131.584453-8-gong.shuai@sanechips.com.cn>
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
X-MAIL:mse-fl1.zte.com.cn 69T6BbLX003152
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 29 Oct 2026 14:11:49 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE2E3A5.000/4jFYln3DRKz5PkGh

From: Wu Fei <wu.fei9@sanechips.com.cn>

A VMM needs the physical IOMMU capabilities to decide which features
it can expose to a guest. Define IOMMU_HW_INFO_TYPE_RISCV and struct
iommu_hw_info_riscv so IOMMU_GET_HW_INFO can return the RISC-V
capabilities register.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 include/uapi/linux/iommufd.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index aa65d494b992..bdabc8e64323 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -731,6 +731,28 @@ struct iommu_hw_info_amd {
 	__aligned_u64 efr2;
 };
 
+/**
+ * struct iommu_hw_info_riscv - RISC-V IOMMU device info
+ *                              (IOMMU_HW_INFO_TYPE_RISCV)
+ *
+ * @capabilities: Value of the RISC-V IOMMU capabilities register, defined
+ *                in "IOMMU capabilities (capabilities)" of the RISC-V
+ *                IOMMU Architecture Specification. The value is reported
+ *                raw by the hardware.
+ *
+ * The VMM is responsible to determine the appropriate fields to be
+ * exposed to the VM since certain features are not currently supported
+ * by the kernel for nested domains. Current list of supported fields:
+ * - capabilities[Sv39, Sv48, Sv57, END, AMO_HWAD]
+ *
+ * This list may expand in the future. It is important that VMMs do not
+ * expose bits outside the list to the VM, to allow for compatibility
+ * with future kernels.
+ */
+struct iommu_hw_info_riscv {
+	__aligned_u64 capabilities;
+};
+
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
  * @IOMMU_HW_INFO_TYPE_NONE: Output by the drivers that do not report hardware
@@ -741,6 +763,7 @@ struct iommu_hw_info_amd {
  * @IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
  *                                     SMMUv3) info type
  * @IOMMU_HW_INFO_TYPE_AMD: AMD IOMMU info type
+ * @IOMMU_HW_INFO_TYPE_RISCV: RISC-V IOMMU info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE = 0,
@@ -749,6 +772,7 @@ enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_ARM_SMMUV3 = 2,
 	IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV = 3,
 	IOMMU_HW_INFO_TYPE_AMD = 4,
+	IOMMU_HW_INFO_TYPE_RISCV = 5,
 };
 
 /**
-- 
2.53.0

