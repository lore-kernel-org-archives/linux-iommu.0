Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254310;
	b=ulf+W3Pc/Y0IzZsnPGBW5MnGXNHpiKCNLpLl0g9vJWXrz3l1g/TyYx4k3m+73S+KnWDi
	 Pfvk8WlPaB6Eix1uaOSvUjwRb64+xNg2Rq+uy80v+lI3OX+UP1DzUvORFSqFTbXkw4wu/
	 Uqskdrfpbc1hiiHEvep5nEJ66tCO2uuTjQ88gYmLCV76RKmSS9TGDwB7ngrmOksNdSMX4
	 PvPqX+vuJSq9UhEzTl8iW+8mqC3mniM79kj+fNn88WqEq0ZLYDTy87zQnt6rVqg+kz5DN
	 DkO4XWfNaQavbzN3grQLnNNLOgA/WlnLI58NEBMwJQ2WfM7ZM2COZXSumHC8y3m0dKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254310;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=P7Wu3rOP9LphW6cm/vIzJYhQZk4eNUAdnspIkK20EHU=;
	b=HkhmmChrno1QsPMf3ZMuM1ugDMNk786+lEDmpE+I+e+kLj1QL1NY2dWu43NnVFM84DP4
	 f303XctRGkDkZRFAFV+HdxPUyHOPyDMfj7dzUnv327coCsvZ0XZAVE9l1Ty4hKlcgOAsB
	 2zStA3FMun/Gi8UZ2e/G0X2Zpti0ShTPlCq2mKZUw3FyelSuVmk+TFJ+K4YD+5DbuB5Qh
	 DMD1CIvNdrOkJp5jYa5OD5uFG7NuvLaWC21mSn03oix78yON3nzQhx1UcX+FFVINcy/un
	 5YHTmfAdtr0JEPMuhbWYgfIKlN431WE7ARe3wdOJyXxl7j3+sEHsJTMTASdVmINrAcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7742F606A331
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 06:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7742F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jFYlf0Tzjz8Xrrl;
	Thu, 29 Oct 2026 14:11:42 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
	by mse-fl2.zte.com.cn with SMTP id 69T6BXnL044398;
	Thu, 29 Oct 2026 14:11:33 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 29 Oct 2026 14:11:34 +0800
X-Zmail-TransId: 3e816ae2e396027-e7cc2
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
Subject: [RFC PATCH v2 2/9] iommufd: Add RISC-V IOMMU hwpt and vIOMMU types
Date: Thu, 29 Oct 2026 14:11:24 +0800
Message-ID: <20261029061131.584453-3-gong.shuai@sanechips.com.cn>
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
X-MAIL:mse-fl2.zte.com.cn 69T6BXnL044398
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 29 Oct 2026 14:11:42 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE2E39E.000/4jFYlf0Tzjz8Xrrl

From: Wu Fei <wu.fei9@sanechips.com.cn>

Add IOMMU_HWPT_DATA_RISCV_S1 and struct iommu_hwpt_riscv to carry
the guest device context in base format for nested hwpt allocation.
Add IOMMU_VIOMMU_TYPE_RISCV so user space can request a RISC-V
vIOMMU.

The RISC-V nested translation support added later needs these types.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Co-developed-by: Gong Shuai <gong.shuai@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 include/uapi/linux/iommufd.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 206fa667c782..5b5ca6e41063 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -506,18 +506,46 @@ struct iommu_hwpt_amd_guest {
 	__aligned_u64 dte[4];
 };
 
+/**
+ * struct iommu_hwpt_riscv - RISC-V IOMMU stage-1 page table data
+ *			     (IOMMU_HWPT_DATA_RISCV_S1)
+ *
+ * @dc: The guest device-context (DC) in the base format defined in
+ *      "Leaf DDT entry" of the RISC-V IOMMU Architecture Specification,
+ *      refer to "Device-context fields" for the meaning of each
+ *      doubleword. Only the guest-owned doublewords are validated:
+ *      - dc[0] (tc): Allowed bits are V, EN_ATS, EN_PRI, T2GPA, DTF,
+ *        PRPR, SADE and SBE. GADE is owned by the host and the value
+ *        here is ignored. PDTV, DPE and SXL are not supported and must
+ *        be 0.
+ *      - dc[3] (fsc): Carries iosatp when tc.PDTV=0, allowed fields
+ *        are MODE (Bare, Sv39, Sv48, Sv57) and PPN; Carries pdtp when
+ *        tc.PDTV=1, which not supported now.
+ *
+ *      The host-owned doublewords dc[1] (iohgatp) and dc[2] (ta) are
+ *      ignored. iohgatp is installed by the kernel from the nesting
+ *      parent at attach time and ta is managed by the host. The
+ *      extended-format MSI doublewords are configured by the host for
+ *      interrupt remapping and are not passed via this structure.
+ */
+struct iommu_hwpt_riscv {
+	__aligned_u64 dc[4];
+};
+
 /**
  * enum iommu_hwpt_data_type - IOMMU HWPT Data Type
  * @IOMMU_HWPT_DATA_NONE: no data
  * @IOMMU_HWPT_DATA_VTD_S1: Intel VT-d stage-1 page table
  * @IOMMU_HWPT_DATA_ARM_SMMUV3: ARM SMMUv3 Context Descriptor Table
  * @IOMMU_HWPT_DATA_AMD_GUEST: AMD IOMMU guest page table
+ * @IOMMU_HWPT_DATA_RISCV_S1: RISC-V IOMMU stage-1 page table
  */
 enum iommu_hwpt_data_type {
 	IOMMU_HWPT_DATA_NONE = 0,
 	IOMMU_HWPT_DATA_VTD_S1 = 1,
 	IOMMU_HWPT_DATA_ARM_SMMUV3 = 2,
 	IOMMU_HWPT_DATA_AMD_GUEST = 3,
+	IOMMU_HWPT_DATA_RISCV_S1 = 4,
 };
 
 /**
@@ -1095,6 +1123,7 @@ struct iommu_fault_alloc {
  * @IOMMU_VIOMMU_TYPE_ARM_SMMUV3: ARM SMMUv3 driver specific type
  * @IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
  *                                    SMMUv3) enabled ARM SMMUv3 type
+ * @IOMMU_VIOMMU_TYPE_RISCV: RISC-V IOMMU driver specific type
  */
 enum iommu_viommu_type {
 	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
@@ -1105,6 +1134,7 @@ enum iommu_viommu_type {
 	 *   VMM must wire the HYP_OWN bit to 0 in guest VINTF_CONFIG register
 	 */
 	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV = 2,
+	IOMMU_VIOMMU_TYPE_RISCV = 3,
 };
 
 /**
-- 
2.53.0

