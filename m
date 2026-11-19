Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094898;
	b=Sb9U0VngItUnnM7yxalDiqVKM5bEmySj793I6cm0F88AN6YAqe6iM4XgCHECYaLFtba4
	 2iYSRfPLI4BnesXKzhokfRdWiBGFirvC2TmFWQ2T3f63VZ0eaLweqOkqnwAjSHK5HfMkJ
	 TrOa9d8dnRHfl9Sli7Vs9tcGB3neLiVwvTWMKqA5Rl25Q3GFCH0S8bO+sRZ1ugzwQqsV6
	 0dsy1D51iW9gmVZ5sOG7mnAOKaE4KHoI0cwRNXJPVuwfMh4lnoUYkUf6zCZtjzCnlSInv
	 JAjCvA2xIxKeSWF4UgE0qI7709CGpn83BkXFeRz27+b+iv+TzlbZSQJUJQ1nKYmO7pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094898;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=T2SA+VjaAktf51GZmIL5ucd5Ml8ZCK9fgBWtfq5fj/o=;
	b=ta5hYRyR2/b/jQhPhuBfpeMCarTv3Y9/GGomiGCOEYOV0Bhts6ixkCLc83q2khqqHLS4
	 3GjeBAppQ9nZWDAMnehUAOdaJFUz0e658LRA6ACQJM3z9ldRWKCHha3zS7u2U2YZIm+8H
	 D9mhq31LAabWyxLdJaZnCR095635V1gXTbVdSIOeuWoy8Jtrur3WnHq22LdqeqiOHd5DR
	 ffnkC8rEKVIdompTqzUOQL4AglmUsG7rKSf0tjH1FBq7w9nmKH4fsin1TNW/T6WEwwOJ9
	 Nap3p+rzgZater1+7Fm0pcPxZQd/vzfiA3znDARoKjtRr//TOd1ROjxCWjCjfNbPRqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB46606B1D0
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 13:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EB46606B1D0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jVfRQ3Cr7z52SGK;
	Thu, 19 Nov 2026 21:28:02 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl2.zte.com.cn with SMTP id 6AJDRrRi070477;
	Thu, 19 Nov 2026 21:27:53 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 19 Nov 2026 21:27:56 +0800
X-Zmail-TransId: 3e816afef95b02f-564cc
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
Subject: [RFC PATCH v3 05/10] iommu/riscv: Add nested domain allocation
Date: Thu, 19 Nov 2026 21:27:39 +0800
Message-ID: <20261119132744.396426-6-gong.shuai@sanechips.com.cn>
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
X-MAIL:mse-fl2.zte.com.cn 6AJDRrRi070477
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 19 Nov 2026 21:28:02 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AFEF962.000/4jVfRQ3Cr7z52SGK

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
 drivers/iommu/riscv/iommu.c | 153 ++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index f2305b953f71..4f8ce579ef08 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1698,8 +1698,161 @@ static void riscv_viommu_destroy(struct iommufd_viommu *viommu)
 	ida_free(&riscv_iommu_gscids, rv_viommu->gscid);
 }
 
+struct riscv_iommu_nested_domain {
+	struct iommu_domain domain;
+	struct riscv_viommu *viommu;
+
+	u64 tc;
+	u64 ta;
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
+	nested_domain->ta = arg.dc[2] & RISCV_IOMMU_DC_TA_PSCID;
+	nested_domain->iosatp = arg.dc[3];
+
+	return &nested_domain->domain;
+}
+
 static const struct iommufd_viommu_ops riscv_viommu_ops = {
 	.destroy = riscv_viommu_destroy,
+	.alloc_domain_nested = riscv_viommu_alloc_domain_nested,
 };
 
 static size_t riscv_iommu_get_viommu_size(struct device *dev,
-- 
2.53.0

