Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7492E54705D
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605908; cv=none; b=kFrORz8oXO/v3Jf+a/9+jMDl7fkIFtrodLvrVz15lWT4nKuruErRQ4MMY0n6apJ/Uc0+DRWe3+GNG32xW7nM+Kf0T6ZAwYGqbE8LIp7C75d6vOPgOQ8IlBZVWGBaLcjlFStaQGwArvOqLM9qfCCIAQz6Kp61/clm0lT41ZUbAtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605908; c=relaxed/simple;
	bh=yJwDlmn443Ax9kpKELDsQBpptC2XSPFpswbCdYGuVZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+TQAQB6CIoNhDpk91w66EVRCxNODC3cts8muW3rJkC1wOPzd623FuK7noshlTJFzNmuqUz12rmTfjXbFIYzhx1Z00OikGmoG1UORJEMtR+0bRlZyR8OklxDM3dS84P1UW0h4Yac5VR2b+/8qTYtD3QKsQ0Dj9ZwsjtedmJYYUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MOS1EdWx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PCVMtZL5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MOS1EdWx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PCVMtZL5"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBATBI782816
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fnEGeXO1CU+
	HZ91pW3NLrROTKl2nGT8dwWEHiiWpE0w=; b=MOS1EdWxOybfBOix7icqGEJix+o
	apWHm7pTzOj7QugvSyaGuoGVfeOc+UeR+lqpSg+tGWiMh2aMMz3XKdVPkzsqsDMk
	my9Sk4Vt0vEiWx7p6ETG8/4HXQ1zN1LsisG94fc2nS+DdIKYMKz5qMnImJ3ABxER
	4Xrb2rldPC+l/AhbGn+uNJxgvEsWv/3a6tV2pj1lssxRxQ1Hc3OS9XQrs5Q1W7aC
	LUhrt/O4BBXYOZJr+lF+KHBcYz7ZtnbX0RcHEsBYRFPWyntcFy4Jf/l8Sd6aVUql
	ykVBgI7Gc/Q3JsUYsqguq66kmDwoxJj89uY99wc7xzGjo0aLtkR/IqO8ljg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyav4axte-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:31:37 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c846dd12ccso991683e0c.2
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 07:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790605896; x=1791210696; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fnEGeXO1CU+HZ91pW3NLrROTKl2nGT8dwWEHiiWpE0w=;
        b=PCVMtZL54HT/Bul7W1eYHshjNNPfI3ogWJDbsvvx6ee2zcSUVM1GdsffhJaJSPRrmP
         IireQh0h4mwbFRe2+qE4pTMdiszo38F9VVhx3H7J1t/SL8fi/A0OqGj1FWfqTHUMk2Zo
         POvP1N1wNEam+mVPyFw9p5IkDmvdIoZzxfcBiNEMX+YVEpHDjFuSEV5VNt8FjGz0/Ipg
         fJi1O9cwKXryRM7tOHEnNAUsQYbK4uR1pEXmrKq9atwlyMBAFvq9PaqNq2XXsTWs2hK6
         GiPyF65KAcNlYbrRabUT+tgFOrwVSFbKlsH8CrrDWQMrCmV8GjP7GNcTLv/vUKyPhFjR
         ICnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605896; x=1791210696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fnEGeXO1CU+HZ91pW3NLrROTKl2nGT8dwWEHiiWpE0w=;
        b=W9aqoM4ufTUsthwlZuUqnrLwCXaTYfd0/Aln3e77JWwjhaiZDkPPnZvSe2t1ueRBT+
         iR9XjiZusTkr9GGcPsiHgU9zFpSNLHe209xG/Jl3yWGi+5k0PtdWu4L+lwB9zeWP9KL5
         RhwFAOeO4wfl4XKDhnz6IoYLDLcLQJm7ThUn2QpDO/TKIjBLoQtlar5FsTvNNTSXCm2L
         T2FjZxRfPQqJUfJ3WODH4uS1WauPXxXeS5XwgV+t6WH4QTUUjqzZA7PvAyOX8vbSGOC0
         wX5px2SPQXRORDCydrS2XDAfeCdU3hH3O2YtcM9OPYOZjegztHXdexx+HPKqhYZ2H4vh
         O7Hg==
X-Gm-Message-State: AFq9FYJlcWW20sM1DzWkoTwWnqPYfy3fKWfEndggXTyu4zoqLQUx62QL
	Us8iniGL+HmGRH3kE3SqbaZIl7C6hhxW4H33z71I7DGm732CFhNT9ts0MmF25lJ+Dfu4KwljYSA
	XOSLiFX+d2Ki3nS9YlyFGu3wCuwYZolEPanrTXoywftJ4gP9qvtT15EZjF+lozM2gDA==
X-Gm-Gg: AYBFou0F0ROXpNr77YYNFCxf+5OJ7YKFevM8KlqRmY14gjQA7mCtDjCVfw+GiYsU7Dy
	yKsW5iEiCAKaPp4duEmxWbfgcOMvdh/jAVzhOU7PIjPxArI9g9GYtIiQ2btqrB6m7tnEeU/M4qU
	HOBKvq3ekT2SJoavVzdAU44omOFfaNuwMk9KmI93YiKIbqZRvCBD8P4kg4RtywEdSVozLFiuSVo
	FDyo21EJG6zrzrlkSzz3U2NHxQ9mFeYi6hJRaXrI8fFplqd2FrO/TsGny8RQ08HNHdr9x3ydyyT
	e+n2StThW1nW0BMNiTDWxDP+AAiMmOYUthyRk+Y3iGpK8xJf17jffO4m0kFLS/pqjEmru4GQTe5
	rw/eKCnB904Rg045wehJ8DPGs/1spnKcE61GReg==
X-Received: by 2002:a05:6102:3914:b0:7b3:b84b:ec61 with SMTP id ada2fe7eead31-7b3b84c1495mr1397627137.34.1790605895883;
        Mon, 28 Sep 2026 07:31:35 -0700 (PDT)
X-Received: by 2002:a05:6102:3914:b0:7b3:b84b:ec61 with SMTP id ada2fe7eead31-7b3b84c1495mr1397528137.34.1790605892520;
        Mon, 28 Sep 2026 07:31:32 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbd3bca9dsm292277066b.71.2026.09.28.07.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:31:31 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 01/14] iommu/riscv: Allocate MSI tables for second-stage domains
Date: Mon, 28 Sep 2026 16:31:00 +0200
Message-ID: <20260928143113.49838-2-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
References: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4jP0oHIFfT_iVcEFXEjZe9Qs-N2As8Ym
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NyBTYWx0ZWRfX3A2PIoArVKjv
 kg0NYnUMlIeF0WMHcPyCxBK9qxLQJhQ4+s8aQntQrU0+VffLPn7p840Hy6VwvrgW+M7pUEgfrol
 +KM1XjhnGP/VNj14FJcTWULmKbR4NyFhaO6WMLa7FNnHlzxx72hUkdmFi3hGc8J6RXRz+cLVy28
 qHDNqHw/3iF7hCg5YlAMOh+8RYN5ie9EV3FrdfCnPmHA50G+PDvFaqJALxtKgOczywldJMSjA53
 B9quLzA6aLlyd3gzJGZt8XWKKwKhMDED/i2swnJdpGVvCWWKMksuMDSpqayg23zOkmb20IENyDQ
 gIQ9oIsMRwrsg3i6r65hELI0D2B4+R02AqKhoSwm5Js2WC5AUClwm8J7xQD/Upi6GxBasK2NAFt
 uuq+1rLdPNnZ9nKhMGvqElZp4Hc8UV2vdkrZ4RWIiC7Xe5rmJ3VSsZnZ+u9cPeWdhKvJppHK0Ve
 RQXS9+Gq/Lh4gWZyDqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NyBTYWx0ZWRfX11tHzaEW9wum
 oY0bb1dWhKZVwz3fuv6t5tKwDXF/DdDx4RLz1LNIAkX+Ij9IghLCOKoHZjIlW1AMBRiOW/aVUCm
 dDWFDhSZeuGH7ENPuJn3QAUu+rwvgFo=
X-Proofpoint-ORIG-GUID: 4jP0oHIFfT_iVcEFXEjZe9Qs-N2As8Ym
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aba7a49 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=9ujTGIzx3EpO3AdiBq4A:9 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280057

IRQ bypass maps guest IMSIC addresses through a flat-mode MSI page
table owned by the second-stage domain. Allocate the table lazily
during device attachment when the attaching IOMMU supports MSI_FLAT,
and free it when the domain is destroyed.

The required capacity depends on hypervisor support and VMM policy.
Expose the runtime-writable riscv_iommu.nr_msi_ptes parameter to set the
MSI table capacity of new second-stage domains. It defaults to 512
entries (8 KiB), and zero disables MSI table allocation for new domains.
Existing domains retain the capacity selected when they were created.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c | 61 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.h |  7 +++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 0953aaf594cb..3bbb4d0d0a85 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -22,6 +22,8 @@
 #include <linux/iopoll.h>
 #include <linux/irqchip/riscv-imsic.h>
 #include <linux/kernel.h>
+#include <linux/moduleparam.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/generic_pt/iommu.h>
 
@@ -30,6 +32,16 @@
 #include "iommu-bits.h"
 #include "iommu.h"
 
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "riscv_iommu."
+
+#define RISCV_IOMMU_DEFAULT_NR_MSI_PTES	512
+
+/* A zero value disables guest MSI table allocation. */
+static unsigned int riscv_iommu_nr_msi_ptes = RISCV_IOMMU_DEFAULT_NR_MSI_PTES;
+module_param_named(nr_msi_ptes, riscv_iommu_nr_msi_ptes, uint, 0644);
+MODULE_PARM_DESC(nr_msi_ptes, "Number of PTEs for new second-stage domains (default: 512)");
+
 /* Timeouts in [us] */
 #define RISCV_IOMMU_QCSR_TIMEOUT	150000
 #define RISCV_IOMMU_QUEUE_TIMEOUT	150000
@@ -847,8 +859,10 @@ struct riscv_iommu_domain {
 	};
 	struct list_head bonds;
 	spinlock_t lock;		/* protect bonds list updates. */
+	struct mutex mutex;		/* serialize domain state updates */
 	int pscid;
 	int gscid;
+	struct riscv_iommu_msi_table msi_table;
 };
 PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
 
@@ -1303,6 +1317,7 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 		ida_free(&riscv_iommu_gscids, domain->gscid);
 
 	pt_iommu_deinit(&domain->riscvpt.iommu);
+	iommu_free_pages(domain->msi_table.root);
 	kfree(domain);
 }
 
@@ -1338,6 +1353,37 @@ static bool riscv_iommu_iohgatp_supported(struct riscv_iommu_device *iommu,
 	return false;
 }
 
+static int riscv_iommu_msi_table_alloc(struct riscv_iommu_domain *domain,
+				       struct riscv_iommu_device *iommu)
+{
+	struct riscv_iommu_msi_table *msi_table = &domain->msi_table;
+	struct riscv_iommu_msipte *root;
+	size_t size;
+
+	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_MSI_FLAT))
+		return 0;
+
+	guard(mutex)(&domain->mutex);
+
+	if (msi_table->root)
+		return 0;
+
+	if (!msi_table->nr_ptes)
+		return 0;
+
+	size = array_size(msi_table->nr_ptes, sizeof(*msi_table->root));
+	if (size == SIZE_MAX)
+		return -EOVERFLOW;
+
+	root = iommu_alloc_pages_node_sz(NUMA_NO_NODE, GFP_KERNEL_ACCOUNT, size);
+	if (!root)
+		return -ENOMEM;
+
+	msi_table->root = root;
+
+	return 0;
+}
+
 static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 					    struct device *dev,
 					    struct iommu_domain *old)
@@ -1347,6 +1393,7 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 	struct pt_iommu_riscv_64_hw_info pt_info;
 	struct riscv_iommu_dc dc = {0};
+	int ret;
 
 	pt_iommu_riscv_64_hw_info(&domain->riscvpt, &pt_info);
 
@@ -1354,6 +1401,10 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 		if (!riscv_iommu_iohgatp_supported(iommu, pt_info.iohgatp_mode))
 			return -ENODEV;
 
+		ret = riscv_iommu_msi_table_alloc(domain, iommu);
+		if (ret)
+			return ret;
+
 		dc.iohgatp =
 			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, pt_info.iohgatp_mode) |
 			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain->gscid) |
@@ -1425,6 +1476,7 @@ riscv_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 
 	INIT_LIST_HEAD_RCU(&domain->bonds);
 	spin_lock_init(&domain->lock);
+	mutex_init(&domain->mutex);
 	iommu = dev_to_iommu(dev);
 	cfg.common.hw_max_oasz_lg2 = 56;
 	/*
@@ -1484,6 +1536,15 @@ riscv_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 			ret = -ENOMEM;
 			goto err_free;
 		}
+
+		/*
+		 * Capture the current number of MSI PTEs now since it must remain
+		 * stable for the lifetime of the domain.
+		 */
+		kernel_param_lock(THIS_MODULE);
+		domain->msi_table.nr_ptes = riscv_iommu_nr_msi_ptes;
+		kernel_param_unlock(THIS_MODULE);
+
 		cfg.common.features |= BIT(PT_FEAT_RISCV_S2);
 		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD)
 			domain->domain.dirty_ops = &riscv_iommu_dirty_ops;
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 6d5c70e9ac6d..6bea9da71ff3 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -68,6 +68,13 @@ struct riscv_iommu_device {
 	u64 *ddt_root;
 };
 
+struct riscv_iommu_msi_table {
+	unsigned int nr_ptes;
+	struct riscv_iommu_msipte *root;
+	u64 msi_addr_mask;
+	u64 msi_addr_pattern;
+};
+
 int riscv_iommu_init(struct riscv_iommu_device *iommu);
 void riscv_iommu_remove(struct riscv_iommu_device *iommu);
 void riscv_iommu_disable(struct riscv_iommu_device *iommu);
-- 
2.43.0

