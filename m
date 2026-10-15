Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB5396585
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 06:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047168; cv=none; b=YvNtyPnXxGdarfCkoRTEeJtwAyzFZw5lHOWSlurukZHdsRSliTF1/0pXZMrBhlZxqpMMa/UIQL+dlXTHXzxl8G1bpjVMIjs3kiMlX0DB6nwOZocI2LpFpKZWPx8KAe4GU1pvcerjfnaWYo48Of0ECFK0zAInQQSmQ6CiNmlKka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047168; c=relaxed/simple;
	bh=uXg09woNzX+cXcVE/ldTGAgcPv6HnJ6DXIh1999YyTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ws3ZlelqAwzfasnFsYoTzhkRijhCgyZZ2z+MrSUjyJ9qaIq6fjnVuFBmdUljlGhBZ0GJEIJ+R+a+YzFnSd75p8uhcy4HTap/s9c9nooqSG7JgzQhUcVeICVzPx6FmIEwNrksEewezbYEuhijg6mQp5O6G3yGGBNsbcVx8DKtO60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn; spf=pass smtp.mailfrom=sanechips.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j4zKT0QFqz58fcG;
	Thu, 15 Oct 2026 14:52:45 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
	by mse-fl1.zte.com.cn with SMTP id 69F6qe0a013847;
	Thu, 15 Oct 2026 14:52:40 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 15 Oct 2026 14:52:42 +0800
X-Zmail-TransId: 3e816ad07839024-5551e
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
Subject: [RFC PATCH 05/12] iommu/riscv: Add nested domain allocation
Date: Thu, 15 Oct 2026 14:52:25 +0800
Message-ID: <20261015065232.604503-6-gong.shuai@sanechips.com.cn>
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
X-MAIL:mse-fl1.zte.com.cn 69F6qe0a013847
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 15 Oct 2026 14:52:45 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD0783D.000/4j4zKT0QFqz58fcG

From: Wu Fei <wu.fei9@sanechips.com.cn>

Implement alloc_domain_nested for the vIOMMU, which builds a nested
domain out of the stage-1 device context that the guest provides. The
context is sanitized before it is stored, since it is entirely user
controlled and bits this IOMMU or this host does not support would
otherwise be programmed into the hardware unchanged.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Co-developed-by: Gong Shuai <gong.shuai@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 drivers/iommu/riscv/iommu.c | 146 ++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index bf02cd984d86..8046cadefbd8 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1930,7 +1930,153 @@ struct riscv_viommu {
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
+	u64 mode;
+
+	if (!(arg->tc & RISCV_IOMMU_DC_TC_V)) {
+		arg->tc = 0;
+		arg->iosatp = 0;
+		return 0;
+	}
+
+	/*
+	 * Reject reserved/custom bits, the physical IOMMU may treat the
+	 * DC as misconfigured.
+	 */
+	if (arg->tc & ~RISCV_IOMMU_DC_TC_DEFINED)
+		return -EINVAL;
+	if (arg->iosatp & ~(RISCV_IOMMU_DC_FSC_PPN | RISCV_IOMMU_DC_FSC_MODE))
+		return -EINVAL;
+
+	/* Process directory tables are not supported now. */
+	if (arg->tc & RISCV_IOMMU_DC_TC_PDTV)
+		return -EOPNOTSUPP;
+
+	/* With PDTV=0 the DPE bit is reserved for future use. */
+	if (arg->tc & RISCV_IOMMU_DC_TC_DPE)
+		return -EINVAL;
+
+	/* Only 64-bit (SXL=0) stage-1 is supported. */
+	if (arg->tc & RISCV_IOMMU_DC_TC_SXL)
+		return -EOPNOTSUPP;
+
+	/* ATS/PRI/T2GPA/PRPR consistency. */
+	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_ATS) &&
+	    (arg->tc & (RISCV_IOMMU_DC_TC_EN_ATS | RISCV_IOMMU_DC_TC_EN_PRI |
+			RISCV_IOMMU_DC_TC_PRPR)))
+		return -EINVAL;
+	if ((arg->tc & RISCV_IOMMU_DC_TC_EN_PRI) &&
+	    !(arg->tc & RISCV_IOMMU_DC_TC_EN_ATS))
+		return -EINVAL;
+	if ((arg->tc & RISCV_IOMMU_DC_TC_PRPR) &&
+	    !(arg->tc & RISCV_IOMMU_DC_TC_EN_PRI))
+		return -EINVAL;
+	if ((arg->tc & RISCV_IOMMU_DC_TC_T2GPA) &&
+	    (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_T2GPA) ||
+	     !(arg->tc & RISCV_IOMMU_DC_TC_EN_ATS)))
+		return -EINVAL;
+
+	/*
+	 * A/D update behavior on stage-2 PTEs is owned by the host,
+	 * decide it's value from the AMO_HWAD capability.
+	 */
+	arg->tc &= ~RISCV_IOMMU_DC_TC_GADE;
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD)
+		arg->tc |= RISCV_IOMMU_DC_TC_GADE;
+
+	/*
+	 * A/D update behavior on stage-1 PTEs is owned by the guest but
+	 * needs AMO_HWAD support.
+	 */
+	if ((arg->tc & RISCV_IOMMU_DC_TC_SADE) &&
+	    !(iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD))
+		return -EOPNOTSUPP;
+
+	/* SBE must match the IOMMU byte order unless END is supported. */
+	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_END) &&
+	    (!!(arg->tc & RISCV_IOMMU_DC_TC_SBE) !=
+	     !!(iommu->fctl & RISCV_IOMMU_FCTL_BE)))
+		return -EINVAL;
+
+	/* Validate the stage-1 mode. */
+	mode = FIELD_GET(RISCV_IOMMU_DC_FSC_MODE, arg->iosatp);
+	if (mode == RISCV_IOMMU_DC_FSC_MODE_BARE) {
+		/* No stage-1 translation, root pointer is unused. */
+		arg->iosatp = 0;
+		return 0;
+	}
+	switch (mode) {
+	case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39:
+	case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48:
+	case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57:
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (!riscv_iommu_fsc_supported(iommu, mode))
+		return -EOPNOTSUPP;
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
+					  IOMMU_HWPT_DATA_RISCV_S1, iosatp);
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
+	nested_domain->tc = arg.tc;
+	nested_domain->iosatp = arg.iosatp;
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

