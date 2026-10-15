Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B208249C4D8
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 06:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047172; cv=none; b=khaqi7Kh7hO8yJA0G67w2s69HtM9WjlI45Y1JY+4/36c+pjMxsR2T/y/pVzawmaU9SUaaMk4idBeFc3uwkWozWzqfrmO41z08vpJxBnhp+n3qSwOTpPpih9Qpsjfxy+EhoSwus01buf05jTiYwQhfj0mgxUZd3D9yS5Za2l5Chs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047172; c=relaxed/simple;
	bh=GPphEfc+yty3jIvBg+vQZmUO9cfyKQDM9MeEhPKl/qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ufk3nD2+Tyu61vE99CohwIuT8gZ62xkhumuo9JOG6xSDO6h58/fQhq3x1ppVPyY4Mq5x7QD6nIy/MyTXWC8oeumHHXK2/trcGEdJ05FSBuB/Vzkr2bFtZfwDiG18F4xFeKS5nLst05Xi+aN5xtBUqAiwsWXTfsJEuZlEcFdRzoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn; spf=pass smtp.mailfrom=sanechips.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4j4zKV156Wz5B14q;
	Thu, 15 Oct 2026 14:52:46 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
	by mse-fl2.zte.com.cn with SMTP id 69F6qduG019086;
	Thu, 15 Oct 2026 14:52:39 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 15 Oct 2026 14:52:41 +0800
X-Zmail-TransId: 3e816ad07838024-55505
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
Subject: [RFC PATCH 04/12] iommu/riscv: Add vIOMMU object support
Date: Thu, 15 Oct 2026 14:52:24 +0800
Message-ID: <20261015065232.604503-5-gong.shuai@sanechips.com.cn>
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
X-MAIL:mse-fl2.zte.com.cn 69F6qduG019086
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 15 Oct 2026 14:52:46 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD0783E.000/4j4zKV156Wz5B14q

From: Wu Fei <wu.fei9@sanechips.com.cn>

Implement the vIOMMU ops so user space can allocate a RISC-V IOMMU
vIOMMU on a stage-2 parent domain and query the size to allocate for
it. The object keeps the parent domain and the GSCID the parent was
allocated, which the nested domain and cache invalidation support added
on top of it will need.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 drivers/iommu/riscv/iommu.c | 60 +++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index dd97c2731d95..bf02cd984d86 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -19,6 +19,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/init.h>
 #include <linux/iommu.h>
+#include <linux/iommufd.h>
 #include <linux/iopoll.h>
 #include <linux/irqchip/riscv-imsic.h>
 #include <linux/kernel.h>
@@ -862,6 +863,7 @@ struct riscv_iommu_domain {
 	struct mutex mutex;		/* serialize domain state updates */
 	int pscid;
 	int gscid;
+	bool nest_parent;
 	struct riscv_iommu_msi_table msi_table;
 };
 PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
@@ -1497,6 +1499,20 @@ static bool riscv_iommu_iohgatp_supported(struct riscv_iommu_device *iommu,
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
 static int riscv_iommu_msi_table_alloc(struct riscv_iommu_domain *domain,
 				       struct riscv_iommu_device *iommu,
 				       struct riscv_iommu_info *info)
@@ -1734,6 +1750,7 @@ riscv_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 			ret = -ENOMEM;
 			goto err_free;
 		}
+		domain->nest_parent = !!(flags & IOMMU_HWPT_ALLOC_NEST_PARENT);
 
 		/*
 		 * Capture the current number of MSI PTEs now since it must remain
@@ -1906,6 +1923,47 @@ static void riscv_iommu_release_device(struct device *dev)
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
 static void riscv_iommu_get_resv_regions(struct device *dev, struct list_head *head)
 {
 	struct iommu_resv_region *region;
@@ -1930,6 +1988,8 @@ static const struct iommu_ops riscv_iommu_ops = {
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

