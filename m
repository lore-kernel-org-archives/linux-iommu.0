Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094887;
	b=IFBz7t2MZnvVkFUuWkp3ZiLtjzMeiswj0/uXW7m0sxbRRLB4iPQKv/RLoqXXo7dfW1ht
	 E1eit4Xs3RL/7SMGZ2qqWGWTA51wnqUp4ml3OuaKtV/H81VtCVVSZeF/fY4gPQhRxQ9EL
	 TrD1g87UHLtuEm6DaZDxyTut6fZI8h81GAUPvNb11sNFJVVa21gH49CvK1eks/XG1AYwE
	 Zr34c76T6E3PwptM+joHDkRJ63QcUo3Jd/6C8q0gFiOdzMQoHaA/r2aeN7pu0x0Amkn5F
	 qVT9VTi9ds0pEcFgNAEYqqN8/DiyrRx/9KAYUuyz0j9wMW6WUmIQ0zpg+v9dg57Uu1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094887;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=6DpinBGst6OfRU+Sci9rwMfyIExP4zydaXJmwKfWdOE=;
	b=42fFw6VzWwuImb6OBLCPA02O75ngOWJdse0cU6LQsAbQzaFb/VB8Rdo86bWIey4612e0
	 4AFZ9iaSg2X0174yGsVOrvrV8FuZRqmmvLlJvQOqXxoWB4hJCemn+d0ipksCFtRbayaUe
	 7u4w+atj0o/aLiDvI9N4hgDoNOz2BTNhp6ZCMr6Tt5CTwpY6s2cUBxXYrFohsQ0+lugtH
	 HX0CwvwTwRAG5MUXwqsGv5RDhICooQ/n4kCnlS2BbF1exfPKhMl4nCiBays2D2BPV/Dq/
	 vjyIeoKR46ljbLkgp0JTb7q3+xDNEptyalWrqdzz7wm/RxEbc3bgUAZj3gyzivvuJaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC95760A2629
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 13:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC95760A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jVfRN2K35z8Xrrb;
	Thu, 19 Nov 2026 21:28:00 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
	by mse-fl1.zte.com.cn with SMTP id 6AJDRqkO086401;
	Thu, 19 Nov 2026 21:27:52 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 19 Nov 2026 21:27:55 +0800
X-Zmail-TransId: 3e816afef95a02f-564b4
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
Subject: [RFC PATCH v3 04/10] iommu/riscv: Add vIOMMU object support
Date: Thu, 19 Nov 2026 21:27:38 +0800
Message-ID: <20261119132744.396426-5-gong.shuai@sanechips.com.cn>
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
X-MAIL:mse-fl1.zte.com.cn 6AJDRqkO086401
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 19 Nov 2026 21:28:00 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AFEF960.000/4jVfRN2K35z8Xrrb

From: Wu Fei <wu.fei9@sanechips.com.cn>

Allow iommufd to allocate a RISC-V vIOMMU when the physical IOMMU
supports both translation stages.

Nested translation needs to associate guest-owned stage 1 contexts
with a host-owned stage 2 parent domain. A vIOMMU provides this
association and owns a dedicated GSCID so that guest PSCIDs cannot
alias address spaces belonging to another vIOMMU.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Co-developed-by: Gong Shuai <gong.shuai@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 drivers/iommu/riscv/iommu.c | 77 +++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index f6e92b086c12..f2305b953f71 100644
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
@@ -1466,6 +1482,8 @@ static int riscv_iommu_init_domain_s2(struct device *dev,
 	if (domain->gscid < 0)
 		return -ENOMEM;
 
+	domain->nest_parent = !!(flags & IOMMU_HWPT_ALLOC_NEST_PARENT);
+
 	/* AMO_HWAD is checked by iommufd via IOMMU_CAP_DIRTY_TRACKING */
 	if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
 		domain->domain.dirty_ops = &riscv_iommu_dirty_ops;
@@ -1662,6 +1680,63 @@ static void riscv_iommu_release_device(struct device *dev)
 	kfree_rcu_mightsleep(info);
 }
 
+struct riscv_viommu {
+	struct iommufd_viommu core;
+	struct riscv_iommu_device *iommu;
+	struct riscv_iommu_domain *s2_parent;
+	int gscid;
+};
+
+static void riscv_viommu_destroy(struct iommufd_viommu *viommu)
+{
+	struct riscv_viommu *rv_viommu =
+		container_of(viommu, struct riscv_viommu, core);
+	/*
+	 * All devices are detached and iodir_update() has flushed this
+	 * GSCID, so the ID can be recycled here.
+	 */
+	ida_free(&riscv_iommu_gscids, rv_viommu->gscid);
+}
+
+static const struct iommufd_viommu_ops riscv_viommu_ops = {
+	.destroy = riscv_viommu_destroy,
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
+	rv_viommu->gscid = ida_alloc_range(&riscv_iommu_gscids, 1,
+					   RISCV_IOMMU_MAX_GSCID, GFP_KERNEL);
+	if (rv_viommu->gscid < 0)
+		return rv_viommu->gscid;
+
+	rv_viommu->iommu = iommu;
+	rv_viommu->s2_parent = s2_parent;
+	viommu->ops = &riscv_viommu_ops;
+
+	return 0;
+}
+
 static const struct iommu_ops riscv_iommu_ops = {
 	.of_xlate = riscv_iommu_of_xlate,
 	.capable = riscv_iommu_capable,
@@ -1669,6 +1744,8 @@ static const struct iommu_ops riscv_iommu_ops = {
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

