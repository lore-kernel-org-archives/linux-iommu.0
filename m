Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254311;
	b=pFM5RqKh3m7JlqDPME3dcMHEFW/7iivceDRG/g18FxOH0n8Ky53ogjb+jL+eqFq1Kgs1
	 G8wadAqlQYFd4dwMQnTq2YP6UByI3apeNQyuJgDTDai9MyrUym101bBiC4+r4og0M0nuO
	 6SLESlS52ED55b8ZGNi5W4oqHetqhL2QahLiFwT30ynKhyF/HU454FVNqbIl0ywTqSQZ8
	 42caC7PJJouZ8+N4cNTe61gJpffSbYBAr+iOfDRb/011KjNVEzpX4+93h/KLrLgP66c5+
	 egiRU5lbYOaVKwq7oNveEg9dPHwnfhSMfoLLJnRK/BJbXebgttgLlyOxXLLH48woong==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254311;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=Kx306uyHmiJgSKeBFoNw3du52UTMIMjVqIo5VITN2ys=;
	b=mmOAkWMnQ4/PM5ss5P8U7D0oTP15Z5YiQBRI33lBFHUeV47J8lSoC4n8CKOR7cUfWyPI
	 F73I2VO3ESzvrLQoXuBt5lbw9ScP/YPGBIwrAPE5vFHzW/KqyE+bEr2k8LYa+Rqle809L
	 BbqQVfvwkuYbd/91HPNK1RPW39DZn3lufbI/7aTUQJYpHBdxfLDx8pRjuAXrcKK5B+S2J
	 tQ414L4XZZfbYwIbfw9gDQONmFsMJ/AShw4fCb0y9p6fi8sZOIPFQW9aAbupJHuboJKM0
	 RnEXNB4+6gwavbsEJTBNUrRqTrQEi2NuZ+pkshw+c1R1dqNHGIWdTRrSyy2jJliqmaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57B960A2600
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 06:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E57B960A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jFYlh4gw6z8Xrrj;
	Thu, 29 Oct 2026 14:11:44 +0800 (CST)
Received: from szxl2zmapp05.zte.com.cn ([10.1.32.37])
	by mse-fl1.zte.com.cn with SMTP id 69T6BYqQ003127;
	Thu, 29 Oct 2026 14:11:34 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 29 Oct 2026 14:11:36 +0800
X-Zmail-TransId: 3e816ae2e397027-e7d00
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
Subject: [RFC PATCH v2 4/9] iommu/riscv: Add vIOMMU object support
Date: Thu, 29 Oct 2026 14:11:26 +0800
Message-ID: <20261029061131.584453-5-gong.shuai@sanechips.com.cn>
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
X-MAIL:mse-fl1.zte.com.cn 69T6BYqQ003127
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 29 Oct 2026 14:11:44 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE2E3A0.001/4jFYlh4gw6z8Xrrj

From: Wu Fei <wu.fei9@sanechips.com.cn>

Allow iommufd to allocate a RISC-V vIOMMU when the physical IOMMU
supports both translation stages.

Nested translation needs to associate guest-owned stage 1 contexts
with a host-owned stage 2 parent domain. A vIOMMU provides this
association and retains the parent GSCID needed to program device
contexts and target IOTINVAL commands at the correct guest.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 drivers/iommu/riscv/iommu.c | 60 +++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 554361dd3159..a8c19c9e45d4 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -19,6 +19,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/init.h>
 #include <linux/iommu.h>
+#include <linux/iommufd.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -856,6 +857,7 @@ struct riscv_iommu_domain {
 	spinlock_t lock;		/* protect bonds list updates. */
 	int pscid;
 	int gscid;
+	bool nest_parent;
 };
 PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
 
@@ -1342,6 +1344,20 @@ static bool riscv_iommu_iohgatp_supported(struct riscv_iommu_device *iommu,
 	return false;
 }
 
+static bool riscv_iommu_supports_s1(struct riscv_iommu_device *iommu)
+{
+	return (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57) ||
+		(iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48) ||
+		(iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39);
+}
+
+static bool riscv_iommu_supports_s2(struct riscv_iommu_device *iommu)
+{
+	return (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57X4) ||
+		(iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48X4) ||
+		(iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39X4);
+}
+
 static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 					    struct device *dev,
 					    struct iommu_domain *old)
@@ -1488,6 +1504,7 @@ riscv_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 			ret = -ENOMEM;
 			goto err_free;
 		}
+		domain->nest_parent = !!(flags & IOMMU_HWPT_ALLOC_NEST_PARENT);
 		cfg.common.features |= BIT(PT_FEAT_RISCV_S2);
 		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD)
 			domain->domain.dirty_ops = &riscv_iommu_dirty_ops;
@@ -1638,6 +1655,47 @@ static void riscv_iommu_release_device(struct device *dev)
 	kfree_rcu_mightsleep(info);
 }
 
+struct riscv_viommu {
+	struct iommufd_viommu core;
+	struct riscv_iommu_device *iommu;
+	struct riscv_iommu_domain *s2_parent;
+	int gscid;
+};
+
+static const struct iommufd_viommu_ops riscv_viommu_ops = {
+};
+
+static size_t riscv_iommu_get_viommu_size(struct device *dev,
+					  enum iommu_viommu_type viommu_type)
+{
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+
+	if (viommu_type != IOMMU_VIOMMU_TYPE_RISCV)
+		return 0;
+
+	if (!riscv_iommu_supports_s1(iommu) || !riscv_iommu_supports_s2(iommu))
+		return 0;
+
+	return VIOMMU_STRUCT_SIZE(struct riscv_viommu, core);
+}
+
+static int riscv_viommu_init(struct iommufd_viommu *viommu,
+			     struct iommu_domain *parent_domain,
+			     const struct iommu_user_data *user_data)
+{
+	struct riscv_viommu *rv_viommu = container_of(viommu, struct riscv_viommu, core);
+	struct riscv_iommu_device *iommu =
+		container_of(viommu->iommu_dev, struct riscv_iommu_device, iommu);
+	struct riscv_iommu_domain *s2_parent = iommu_domain_to_riscv(parent_domain);
+
+	rv_viommu->iommu = iommu;
+	rv_viommu->s2_parent = s2_parent;
+	rv_viommu->gscid = s2_parent->gscid;
+	viommu->ops = &riscv_viommu_ops;
+
+	return 0;
+}
+
 static const struct iommu_ops riscv_iommu_ops = {
 	.of_xlate = riscv_iommu_of_xlate,
 	.capable = riscv_iommu_capable,
@@ -1645,6 +1703,8 @@ static const struct iommu_ops riscv_iommu_ops = {
 	.blocked_domain = &riscv_iommu_blocking_domain,
 	.release_domain = &riscv_iommu_blocking_domain,
 	.domain_alloc_paging_flags = riscv_iommu_domain_alloc_paging_flags,
+	.get_viommu_size = riscv_iommu_get_viommu_size,
+	.viommu_init = riscv_viommu_init,
 	.device_group = riscv_iommu_device_group,
 	.probe_device = riscv_iommu_probe_device,
 	.release_device	= riscv_iommu_release_device,
-- 
2.53.0

