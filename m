Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094894;
	b=Kou0OPOhJHNjHAAlf4Exld40RRxOZP8BylRBmM71nPgbfJQSeF0ltZOV4Gp4vG8z7ygN
	 srCKMxxcziZAFsFjUXg0BWaSCLa7KAStrU7FaDVdp1nXgOsIRskGs6jMKilO60rGkDSlK
	 x6LxPN/a580OpWhFiISUNcG6Qm3unJ1xwID2ioLT2PERqHqDZFqa40yXYxa9bnr9+1hv8
	 wU7oZtInM3yLYCvtuLusFdCSRCU0PUhW9uVy5xokFeh/DeqDONeaVRQwamQy5pRGXhC+s
	 SPTyb2agQ3muRnWvMloa9l3r4j3T5oBb2FxkX5XOA8zfEf4Ea+LJG5lxcN3BcFfKiXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094894;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=pXs81zN/gtOWk9jcY6j4Vry1pu2j7Yic8GSrqZs0QNY=;
	b=4DgU+NMYi9NYVZ6ZiDEFX1faGUURCsDG5F7/ZKiLo4SOaA/0A9grBIma9+wRVSfyN+CC
	 9QjdbiuPXM4MeLVHi4JZVJFwDB0dkAQO+OiSAuI7oHxE8A69sAOwcbmejLW46UKZVDWlU
	 9duWOlqYiugG5e88rLoSMzkj9oaR7Uo36qLPmodf8ISzEYflu9YH9aBUoKS6Nl20+mNtv
	 +NaLq24uGOzM6WvZlaflaxxtdetE9jhI+q3hgrwT1Mkvf6AC5bmr5s2DsNqOgLYvG+gQT
	 CtH6c2rpXTilDs+39W5g0h4YckCJ/L9NBOSU0iIQ2NRPkkA2quM3g/36jNavvUGxA0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B967B60A2612
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 13:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B967B60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jVfRK1ktVz52SG3;
	Thu, 19 Nov 2026 21:27:57 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
	by mse-fl1.zte.com.cn with SMTP id 6AJDRsH9086413;
	Thu, 19 Nov 2026 21:27:54 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 19 Nov 2026 21:27:58 +0800
X-Zmail-TransId: 3e816afef95d02f-56508
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
Subject: [RFC PATCH v3 07/10] iommufd: Add RISC-V IOMMU hardware info type
Date: Thu, 19 Nov 2026 21:27:41 +0800
Message-ID: <20261119132744.396426-8-gong.shuai@sanechips.com.cn>
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
X-MAIL:mse-fl1.zte.com.cn 6AJDRsH9086413
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 19 Nov 2026 21:27:57 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AFEF95D.000/4jVfRK1ktVz52SG3

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
index fee63e6cbb7a..adc7f30b2b18 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -733,6 +733,28 @@ struct iommu_hw_info_amd {
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
@@ -743,6 +765,7 @@ struct iommu_hw_info_amd {
  * @IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
  *                                     SMMUv3) info type
  * @IOMMU_HW_INFO_TYPE_AMD: AMD IOMMU info type
+ * @IOMMU_HW_INFO_TYPE_RISCV: RISC-V IOMMU info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE = 0,
@@ -751,6 +774,7 @@ enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_ARM_SMMUV3 = 2,
 	IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV = 3,
 	IOMMU_HW_INFO_TYPE_AMD = 4,
+	IOMMU_HW_INFO_TYPE_RISCV = 5,
 };
 
 /**
-- 
2.53.0

