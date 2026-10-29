Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254310;
	b=soERqlhwMTIBdExyrnXRZ2FkNJTWVqRXAFOYVCqFNk5YEVXwwxFkgZHAUJQu5gJpBfaL
	 f27MDo4FUE+60MRcCA6P+RQgp1oF/ykseu2cRLV9xJAGkQGa8X0l9+hL1IHBTdz9eh6cT
	 MbSygsnN0jzCfTULl+aA2J0SsFJUh0a7WYUqzN0YkQrSinFlTft+oT18NdBkVlti4pBE1
	 n+kqxqiWsrPFgpug5nO7XBH4X5xEinlBUFLWJOr7hlBdoVtJIOYrz9Ep2NQkL2VfAqyn6
	 MQZ4pIY8R4/47QA+936tMiU7R8EsblOLQdpZJNxMUhBS1YngCm6NeNfftfvzUKLA/Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254310;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=LQ1Dc1AEtemooe5ez0qeFSkjkwnLGLVYy6ElxNTY92k=;
	b=VugSKqmdWR+Js1DJQ7wWZLFzyV0BNBXv5ym9oojq3f4AoTnk1DU+DeiKLuQ5vD38vnPD
	 QPowwndeCIIY/XGMxdVzNfkLucjyxnDG5YP2SNCsw0W+xgzy0zjN/oiNW0QQ8JhTd5KQk
	 ujy7hAGWWza7Pg0Cpg9Vji1YiRRm9B9Qc26X0Or17LHWh9NdIwk+Lzdvmkdnd+DedQsJX
	 UvlHlA3BT71MCZDl2PboZQtNb1J60b05wtbRSXQQCjZI05Oyi7KWB8MZTY8WRi3r0ZKdV
	 +TJFpYEwRdC7CJyfpvhNtWT0pNVVXwE/nCifPHSdt6TdtWkzZ8AB4Ri+aj3M8PqjfCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A8606A333
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 06:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F19A8606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jFYlf6SKKz5PkGv;
	Thu, 29 Oct 2026 14:11:42 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl2.zte.com.cn with SMTP id 69T6BZTU044449;
	Thu, 29 Oct 2026 14:11:35 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 29 Oct 2026 14:11:37 +0800
X-Zmail-TransId: 3e816ae2e398027-e7d19
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
Subject: [RFC PATCH v2 5/9] iommu/riscv: Add nested domain allocation
Date: Thu, 29 Oct 2026 14:11:27 +0800
Message-ID: <20261029061131.584453-6-gong.shuai@sanechips.com.cn>
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
X-MAIL:mse-fl2.zte.com.cn 69T6BZTU044449
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 29 Oct 2026 14:11:42 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE2E39E.001/4jFYlf6SKKz5PkGv

From: Wu Fei <wu.fei9@sanechips.com.cn>

A nested domain describes two-stage translation through guest and
host page tables. Iommufd exposes this domain as a nested hwpt.

User space needs to provide the guest stage 1 configuration when
allocating a nested hwpt. Validate the configuration before storing
it for use in a physical device context.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Co-developed-by: Gong Shuai <gong.shuai@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 drivers/iommu/riscv/iommu.c | 151 ++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index a8c19c9e45d4..371d60902eaa 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1662,7 +1662,158 @@ struct riscv_viommu {
 	int gscid;
 };
 
+struct riscv_iommu_nested_domain {
+	struct iommu_domain domain;
+	struct riscv_viommu *viommu;
+
+	u64 tc;
+	u64 iosatp;
+};
+
+#define to_riscv_iommu_nested_domain(domain) \
+	container_of(domain, struct riscv_iommu_nested_domain, domain)
+
+static void riscv_iommu_domain_nested_free(struct iommu_domain *domain)
+{
+	kfree(to_riscv_iommu_nested_domain(domain));
+}
+
+static const struct iommu_domain_ops riscv_iommu_nested_ops = {
+	.free = riscv_iommu_domain_nested_free,
+};
+
+static int riscv_iommu_validate_vdc(struct riscv_iommu_device *iommu,
+				    struct iommu_hwpt_riscv *arg)
+{
+	u64 tc = arg->dc[0];
+	u64 fsc = arg->dc[3];
+	u64 mode;
+
+	if (!(tc & RISCV_IOMMU_DC_TC_V)) {
+		arg->dc[0] = 0;
+		arg->dc[3] = 0;
+		return 0;
+	}
+
+	/*
+	 * Reject reserved/custom bits, the physical IOMMU may treat the
+	 * DC as misconfigured.
+	 */
+	if (tc & ~RISCV_IOMMU_DC_TC_DEFINED)
+		return -EINVAL;
+	if (fsc & ~(RISCV_IOMMU_DC_FSC_PPN | RISCV_IOMMU_DC_FSC_MODE))
+		return -EINVAL;
+
+	/* Process directory tables are not supported now. */
+	if (tc & RISCV_IOMMU_DC_TC_PDTV)
+		return -EOPNOTSUPP;
+
+	/* With PDTV=0 the DPE bit is reserved for future use. */
+	if (tc & RISCV_IOMMU_DC_TC_DPE)
+		return -EINVAL;
+
+	/* Only 64-bit (SXL=0) stage-1 is supported. */
+	if (tc & RISCV_IOMMU_DC_TC_SXL)
+		return -EOPNOTSUPP;
+
+	/* ATS/PRI/T2GPA/PRPR consistency. */
+	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_ATS) &&
+	    (tc & (RISCV_IOMMU_DC_TC_EN_ATS | RISCV_IOMMU_DC_TC_EN_PRI |
+		   RISCV_IOMMU_DC_TC_PRPR)))
+		return -EINVAL;
+	if ((tc & RISCV_IOMMU_DC_TC_EN_PRI) &&
+	    !(tc & RISCV_IOMMU_DC_TC_EN_ATS))
+		return -EINVAL;
+	if ((tc & RISCV_IOMMU_DC_TC_PRPR) &&
+	    !(tc & RISCV_IOMMU_DC_TC_EN_PRI))
+		return -EINVAL;
+	if ((tc & RISCV_IOMMU_DC_TC_T2GPA) &&
+	    (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_T2GPA) ||
+	     !(tc & RISCV_IOMMU_DC_TC_EN_ATS)))
+		return -EINVAL;
+
+	/*
+	 * A/D update behavior on stage-2 PTEs is owned by the host,
+	 * decide it's value from the AMO_HWAD capability.
+	 */
+	tc &= ~RISCV_IOMMU_DC_TC_GADE;
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD)
+		tc |= RISCV_IOMMU_DC_TC_GADE;
+
+	/*
+	 * A/D update behavior on stage-1 PTEs is owned by the guest but
+	 * needs AMO_HWAD support.
+	 */
+	if ((tc & RISCV_IOMMU_DC_TC_SADE) &&
+	    !(iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD))
+		return -EOPNOTSUPP;
+
+	/* SBE must match the IOMMU byte order unless END is supported. */
+	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_END) &&
+	    (!!(tc & RISCV_IOMMU_DC_TC_SBE) !=
+	     !!(iommu->fctl & RISCV_IOMMU_FCTL_BE)))
+		return -EINVAL;
+
+	/* Validate the stage-1 mode. */
+	mode = FIELD_GET(RISCV_IOMMU_DC_FSC_MODE, fsc);
+	if (mode == RISCV_IOMMU_DC_FSC_MODE_BARE) {
+		/* No stage-1 translation, root pointer is unused. */
+		fsc = 0;
+	} else {
+		switch (mode) {
+		case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39:
+		case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48:
+		case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57:
+			break;
+		default:
+			return -EINVAL;
+		}
+		if (!riscv_iommu_fsc_supported(iommu, mode))
+			return -EOPNOTSUPP;
+	}
+
+	arg->dc[0] = tc;
+	arg->dc[3] = fsc;
+
+	return 0;
+}
+
+static struct iommu_domain *
+riscv_viommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
+				 const struct iommu_user_data *user_data)
+{
+	struct riscv_viommu *rv_viommu = container_of(viommu, struct riscv_viommu, core);
+	struct riscv_iommu_nested_domain *nested_domain;
+	struct iommu_hwpt_riscv arg;
+	int ret;
+
+	if (flags)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	ret = iommu_copy_struct_from_user(&arg, user_data,
+					  IOMMU_HWPT_DATA_RISCV_S1, dc);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = riscv_iommu_validate_vdc(rv_viommu->iommu, &arg);
+	if (ret)
+		return ERR_PTR(ret);
+
+	nested_domain = kzalloc_obj(*nested_domain, GFP_KERNEL_ACCOUNT);
+	if (!nested_domain)
+		return ERR_PTR(-ENOMEM);
+
+	nested_domain->domain.type = IOMMU_DOMAIN_NESTED;
+	nested_domain->domain.ops = &riscv_iommu_nested_ops;
+	nested_domain->viommu = rv_viommu;
+	nested_domain->tc = arg.dc[0];
+	nested_domain->iosatp = arg.dc[3];
+
+	return &nested_domain->domain;
+}
+
 static const struct iommufd_viommu_ops riscv_viommu_ops = {
+	.alloc_domain_nested = riscv_viommu_alloc_domain_nested,
 };
 
 static size_t riscv_iommu_get_viommu_size(struct device *dev,
-- 
2.53.0

