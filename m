Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C8C37755D
	for <iommu@lists.linux.dev>; Wed,  1 Jul 2026 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878470; cv=none; b=stt6lsEQGUoSr/6zPzAiq3uQPb9YZpGREfCRMoZz6VYvpF+vV0Cno09XViJ2aQH408hW0VbPc3VsO14eHK1f/snNokCkfbOh5lTcAX5arGXtSPJ1PFibKm2IL0yl7vv9FkOD+7YIrsr49ylyiRNxHGTKmYpFBvv2J3duoixFWE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878470; c=relaxed/simple;
	bh=1IOWge6MtXvrty9jqSCer2unjjBTrRLH8qMTiiCM4o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLbm0T5JLnYlPZ5wzCY9MHH/lz0l5JZQ+jateZG2ehE4/rViF8lOIHuO0kTKnzQzVdIHAfUZfzQAz/lzOF17Coc0ewgVykfVl/tf+XNrDYmGVCIzkw8GApGrnXo5UVhOAtzjMgWmMeGZBQ8XbJX4g/zXZfT5YZ7C9MCUF6fH4Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fDglEzgl; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fDglEzgl"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-13b30f3d1e5so728323c88.1
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 21:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782878464; x=1783483264; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1e3YXWFANhBpw4yjMWQhabBTa2QrRN36l2rv62U94S4=;
        b=fDglEzgl04+lsJ7N7E1jMDeGes/nQ25pwkQJVzCm3cBnjyJ4AEOn2hMm/2kA9qDtJ5
         FqKmCXvrlhc+k4ocYQlT7hdlNcY4icji1f+3BJu2UxhVS5cPOLl+h6nV1b4WwK/5GCQf
         bC4vJ+emnh5LsTh3rzppIg3ZDAcF+YkwgkwTrVVMWabDgzNWl8MTl7/b0uoKfDzGEiIM
         BI6PVU7w4wNha+bGmul/fe4hNd2ixzPyxv+yUZ9eRyO23MAiXS9nWPCeKbPRC5zYeIBz
         XhrN8JC+eh0MCMAxXBbZ6RXUsws1yHxdl3yAOCdbuwXkqAwDY3c3Bk7hIGKSdTpDzHv7
         QqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782878464; x=1783483264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1e3YXWFANhBpw4yjMWQhabBTa2QrRN36l2rv62U94S4=;
        b=ivFrduxp9UbsqZ1PUg3ijRWR5zf/LtpQEtLn4xPxbhWv0adxQMhWQ6q81v6o8YnLtE
         M9M6XtKarIHfEDQnApMcdvItGarrwHKFUPZxlOkJZ3mi+L3bR+g2CKjYUVH5gy/Z3tEr
         XOf2pnWPS1kw4RwyitEEgYfuarnuQ/vx2i8Jd+BAyFvbFWWspG8gZlO32jzJShYJO1mx
         R5/mWw/4H7w0QP97eN0s6zo19fyAzYCNX/GmpbJtouUd+EK29Dp1BTkyhVPO/+2xZn/J
         xw10wLiib0Fz9USJZDl2aT0xN3HaBRnWSciLqdNnZzmeiGWI4C09dz2jE4fkplMxoFRK
         fqYA==
X-Forwarded-Encrypted: i=1; AHgh+RoLyR7rhKVwKAvzE/GnBjOb9eovjyJKQBOfhfYIfw5tzrSjPzyx+YqdlDHg0fsYrU8RvvFTxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTu/YqcqdA6mvohGzVSi0q+jw41irq5VA2MllYD13JoBkNqlDO
	n2onlFBVAmPNO/iU6n2sEmCMwZZdvFSIXNcr+JUiLtY5gDVg/L/7PUUph0eV8jL8zhc=
X-Gm-Gg: AfdE7cm5i3VgGk14OPdt1prsVsr4aOVdsz5nD8WCV/kvmMYwgTgzxKEKrtjTYpj38Hc
	8b/MIRQ3MfbIfRUmvJid+f/Ei333dGUy7mnyToaaLy9jNl6pXBLhiS5aA2innVdU/yVUZNn5B4t
	o9Qg4A8y1NWVhJlHzGtCvnIY+RqcTfUWciuODcYcGJwxpJfLVKkMIqxBpQFHH4CZGtqDfEHgU39
	tirhyxYrJYaMjYeKXoddf2Wmfio0pmbslZAOz/y9kfNp0Kpy+fv3W0tEght/sB43XHQz5cedART
	kQZdTGnJpSoZDhDtOJ+AYt6MvZnN4en0D77YIBVRI4xN0Atxi9fc7jWxu8IZPOrONorXm7R7o3L
	c2VHHjxI0+/Nxgr5IS3uV2SROVGpwVp8yUZ6bOmAkUHAoaXmJzr8ykjFPNC2tcxfBh3I+VedQff
	K5lK1d22EA01mRxT2IT8e5d00X8kwOvZ17TlHwTQGktmgyCui0p1CgMFKjBkch+tjT
X-Received: by 2002:a05:7300:148f:b0:30c:ab96:7305 with SMTP id 5a478bee46e88-30efe97a06bmr77957eec.21.1782878463972;
        Tue, 30 Jun 2026 21:01:03 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee32519aesm14024287eec.27.2026.06.30.21.00.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Jun 2026 21:01:03 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	cuiyunhui@bytedance.com,
	yuanzhu@bytedance.com,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Subject: [RFC PATCH 1/3] iommu/riscv: Complete MRIF MSI PTE setup
Date: Wed,  1 Jul 2026 12:00:14 +0800
Message-ID: <20260701040017.42707-2-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701040017.42707-1-zhangzhanpeng.jasper@bytedance.com>
References: <20250811061104.10326-1-fangyu.yu@linux.alibaba.com>
 <20260701040017.42707-1-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MRIF path can retarget an existing MSI table entry, but it does
not fully handle installing a new MRIF MSI table entry.  It also encodes
the MRIF target with the normal PPN helper even though a RISC-V IOMMU MSI
PTE uses MRIF_ADDR[53:7] in MRIF mode.

Add a dedicated MRIF PTE helper and use it for both the new-table and
retarget paths.  This keeps the normal MSI PTE encoding unchanged while
programming the MRIF address and information fields when vCPU affinity
requests MRIF delivery.

Publish MRIF entries so the notice information is visible before the
valid PTE word is installed.  When rewriting a live entry, clear the PTE
word first and order the mrif_info update before publishing the
replacement PTE, so a racing device MSI does not observe a valid MRIF PTE
with stale notice data.

Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 drivers/iommu/riscv/iommu-ir.c | 96 ++++++++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index ccbb7aa74a25..82fbb44d6df0 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -119,10 +119,11 @@ static void riscv_iommu_ir_set_pte(struct riscv_iommu_msipte *pte, u64 addr)
 
 static void riscv_iommu_ir_set_mrif_pte(struct riscv_iommu_msipte *pte, u64 addr, u64 mrif_info)
 {
+	pte->mrif_info = mrif_info;
+	dma_wmb();
 	pte->pte = FIELD_PREP(RISCV_IOMMU_MSIPTE_M, 1) |
-		   riscv_iommu_phys_to_ppn(addr) |
+		   riscv_iommu_phys_to_mrif(addr) |
 		   FIELD_PREP(RISCV_IOMMU_MSIPTE_V, 1);
-	pte->mrif_info = mrif_info;
 }
 
 static void riscv_iommu_ir_clear_pte(struct riscv_iommu_msipte *pte)
@@ -131,6 +132,17 @@ static void riscv_iommu_ir_clear_pte(struct riscv_iommu_msipte *pte)
 	pte->mrif_info = 0;
 }
 
+static void riscv_iommu_ir_update_pte(struct riscv_iommu_msipte *pte,
+				      const struct riscv_iommu_msipte *pteval)
+{
+	/* Rewrite live entries without exposing stale MRIF notice data. */
+	pte->pte = 0;
+	dma_wmb();
+	pte->mrif_info = pteval->mrif_info;
+	dma_wmb();
+	pte->pte = pteval->pte;
+}
+
 static void riscv_iommu_ir_msitbl_inval(struct riscv_iommu_domain *domain)
 {
 	struct riscv_iommu_bond *bond;
@@ -337,14 +349,65 @@ static bool riscv_iommu_ir_vcpu_check_config(struct riscv_iommu_domain *domain,
 	       domain->group_index_shift == vcpu_info->group_index_shift;
 }
 
+static int riscv_iommu_ir_get_mrif_info(struct irq_data *data,
+					struct riscv_iommu_ir_vcpu_info *vcpu_info,
+					u64 *mrif_info)
+{
+	struct device *dev;
+	struct riscv_iommu_device *iommu;
+	struct msi_desc *desc;
+	struct irq_data *irqdata;
+	struct irq_chip *chip;
+
+	*mrif_info = 0;
+	if (!vcpu_info->mrif)
+		return 0;
+
+	if (!vcpu_info->host_msg)
+		return -EINVAL;
+
+	desc = irq_data_get_msi_desc(data);
+	if (!desc)
+		return -EINVAL;
+
+	dev = msi_desc_to_dev(desc);
+	if (!dev)
+		return -EINVAL;
+
+	iommu = dev_to_iommu(dev);
+	if (!iommu)
+		return -ENODEV;
+
+	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_MSI_MRIF)) {
+		irqdata = irq_get_irq_data(vcpu_info->host_irq);
+		chip = irqdata ? irq_data_get_irq_chip(irqdata) : NULL;
+		if (!chip || !chip->irq_write_msi_msg)
+			return -EOPNOTSUPP;
+
+		chip->irq_write_msi_msg(irqdata, vcpu_info->host_msg);
+		return -ENODEV;
+	}
+
+	*mrif_info = riscv_iommu_data_to_nid(vcpu_info->host_msg->data) |
+		     riscv_iommu_phys_to_nppn((u64)vcpu_info->host_msg->address_hi << 32 |
+					      vcpu_info->host_msg->address_lo);
+
+	return 0;
+}
+
 static int riscv_iommu_ir_vcpu_new_config(struct riscv_iommu_domain *domain,
 					  struct irq_data *data,
 					  struct riscv_iommu_ir_vcpu_info *vcpu_info)
 {
 	struct riscv_iommu_msipte *pte;
+	u64 mrif_info;
 	size_t idx;
 	int ret;
 
+	ret = riscv_iommu_ir_get_mrif_info(data, vcpu_info, &mrif_info);
+	if (ret)
+		return ret;
+
 	if (domain->pgd_mode)
 		riscv_iommu_ir_unmap_imsics(domain);
 
@@ -378,8 +441,10 @@ static int riscv_iommu_ir_vcpu_new_config(struct riscv_iommu_domain *domain,
 	idx = riscv_iommu_ir_compute_msipte_idx(domain, vcpu_info->gpa);
 	pte = &domain->msi_root[idx];
 	riscv_iommu_ir_irq_set_msitbl_info(data, idx, domain->msitbl_config);
-	BUG_ON(vcpu_info->mrif);
-	riscv_iommu_ir_set_pte(pte, vcpu_info->hpa);
+	if (vcpu_info->mrif)
+		riscv_iommu_ir_set_mrif_pte(pte, vcpu_info->hpa, mrif_info);
+	else
+		riscv_iommu_ir_set_pte(pte, vcpu_info->hpa);
 	riscv_iommu_ir_msitbl_inval(domain);
 	refcount_set(&domain->msi_pte_counts[idx], 1);
 
@@ -393,15 +458,13 @@ static int riscv_iommu_ir_irq_set_vcpu_affinity(struct irq_data *data, void *arg
 	struct riscv_iommu_info *info = data->domain->host_data;
 	struct riscv_iommu_domain *domain = info->domain;
 	struct riscv_iommu_ir_vcpu_info *vcpu_info = arg;
-	struct device *dev = msi_desc_to_dev(irq_data_get_msi_desc(data));
-	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_msipte pteval;
 	struct riscv_iommu_msipte *pte;
 	bool inc = false, dec = false;
 	size_t old_idx, new_idx;
 	u32 old_config;
 	u64 mrif_info = 0;
-	bool mrif_support = (iommu->caps & RISCV_IOMMU_CAPABILITIES_MSI_MRIF);
+	int ret;
 
 	if (!domain->msi_root)
 		return -EOPNOTSUPP;
@@ -422,18 +485,9 @@ static int riscv_iommu_ir_irq_set_vcpu_affinity(struct irq_data *data, void *arg
 	if (!riscv_iommu_ir_vcpu_check_config(domain, vcpu_info))
 		return riscv_iommu_ir_vcpu_new_config(domain, data, vcpu_info);
 
-	if (vcpu_info->mrif) {
-		if (!mrif_support) {
-			struct irq_data *irqdata = irq_get_irq_data(vcpu_info->host_irq);
-			irq_data_get_irq_chip(irqdata)->irq_write_msi_msg(irqdata,
-					vcpu_info->host_msg);
-			return -ENODEV;
-		}
-		mrif_info = riscv_iommu_data_to_nid(vcpu_info->host_msg->data) |
-				riscv_iommu_phys_to_nppn(
-					(u64)vcpu_info->host_msg->address_hi << 32 |
-					vcpu_info->host_msg->address_lo);
-	}
+	ret = riscv_iommu_ir_get_mrif_info(data, vcpu_info, &mrif_info);
+	if (ret)
+		return ret;
 
 	new_idx = riscv_iommu_ir_compute_msipte_idx(domain, vcpu_info->gpa);
 	riscv_iommu_ir_irq_set_msitbl_info(data, new_idx, domain->msitbl_config);
@@ -444,8 +498,8 @@ static int riscv_iommu_ir_irq_set_vcpu_affinity(struct irq_data *data, void *arg
 	else
 		riscv_iommu_ir_set_pte(&pteval, vcpu_info->hpa);
 
-	if (pteval.pte != pte->pte) {
-		*pte = pteval;
+	if (pteval.pte != pte->pte || pteval.mrif_info != pte->mrif_info) {
+		riscv_iommu_ir_update_pte(pte, &pteval);
 		riscv_iommu_ir_msitbl_inval(domain);
 	}
 
-- 
2.50.1 (Apple Git-155)

