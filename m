Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094885;
	b=PC1NEc/zJLiuKpvhgzLY9UDrCCVdL4ObsM6ziqJuy5z1gdXXsywZMwrrbgC1MiKz0ukO
	 hBVO926lXFfxPHJw0YLInjCId+F87/Jj2HCBX1jYKjnsCTx3UPn12gLTaCKZdf2uYtQKn
	 rz/IL730mmnXYowwZxn3D70zHbcIsGceAv/UN6Neei+j1N2PcotW3HnD2sSm7L4vApiQk
	 9oV+miqxilDpH+q4R3zv4ADKpC9NN7rHQ6uqHGOktL1GiZkI8v/aKV0+C+RkAnVuVHsBR
	 140hkpnGkQNwUy8NrR5zzRtADNpncCEri0jSkOgOGmLeuy0CHIaeIjC6fDXe6e6Xe8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094885;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=N7WurjAFhrGZqrc3woGQbsUMcIKJoBFDTIsgaOcvBks=;
	b=ONOsy2yogtUt6EHY0W0XYVSJTCVAyRyf6qflEY1PeLlAVravcS0UkMcCm7NYo7FvUhM8
	 PAkwDeapyLFPFmUoJusIJGWio+KC6XHe+sCIrbJlslJqPvJVx0f+vtlCiROSlTnOKe8Pj
	 9ldqTZIvk/Fg1JU+RJWBLYgU110PqiS9fjlhvsEjWblio3KoTHO8xMaQIVwBfD1hIwOAb
	 StdNfrXYH1dcLx9l2+Vzgyl8jhDEd+MP020FQ4xMQ7ffyO0wHAl1oveehB0YxDexKU5YX
	 /IQiqDug/VrxY94yyPSATcdMKz629aKy5pGiLtOulsX/pfaP/ybptlGy6l79TOteeIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8080D606A325
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 13:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8080D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jVfRH6RKlz4yjjL;
	Thu, 19 Nov 2026 21:27:55 +0800 (CST)
Received: from szxl2zmapp05.zte.com.cn ([10.1.32.37])
	by mse-fl1.zte.com.cn with SMTP id 6AJDRnNh086379;
	Thu, 19 Nov 2026 21:27:49 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 19 Nov 2026 21:27:53 +0800
X-Zmail-TransId: 3e816afef95802f-56482
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
Subject: [RFC PATCH v3 02/10] iommufd: Add RISC-V IOMMU hwpt and vIOMMU types
Date: Thu, 19 Nov 2026 21:27:36 +0800
Message-ID: <20261119132744.396426-3-gong.shuai@sanechips.com.cn>
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
X-MAIL:mse-fl1.zte.com.cn 6AJDRnNh086379
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 19 Nov 2026 21:27:55 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AFEF95B.001/4jVfRH6RKlz4yjjL

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
 include/uapi/linux/iommufd.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 010f47f7d3d2..809f4d44c0b0 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -506,18 +506,48 @@ struct iommu_hwpt_amd_guest {
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
+ *      - dc[2] (ta): PSCID is guest-owned. Within one vIOMMU the guest
+ *        must use a unique PSCID for each stage-1 address space. All
+ *        other fields are ignored and managed by the host.
+ *      - dc[3] (fsc): Carries iosatp when tc.PDTV=0, allowed fields
+ *        are MODE (Bare, Sv39, Sv48, Sv57) and PPN; Carries pdtp when
+ *        tc.PDTV=1, which not supported now.
+ *
+ *      The host-owned doubleword dc[1] (iohgatp) is ignored and installed
+ *      by the kernel from the nesting parent at attach time. The
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
@@ -1103,6 +1133,7 @@ struct iommu_fault_alloc {
  * @IOMMU_VIOMMU_TYPE_ARM_SMMUV3: ARM SMMUv3 driver specific type
  * @IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
  *                                    SMMUv3) enabled ARM SMMUv3 type
+ * @IOMMU_VIOMMU_TYPE_RISCV: RISC-V IOMMU driver specific type
  */
 enum iommu_viommu_type {
 	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
@@ -1113,6 +1144,7 @@ enum iommu_viommu_type {
 	 *   VMM must wire the HYP_OWN bit to 0 in guest VINTF_CONFIG register
 	 */
 	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV = 2,
+	IOMMU_VIOMMU_TYPE_RISCV = 3,
 };
 
 /**
-- 
2.53.0

