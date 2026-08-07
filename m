Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0994377A82
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126662; cv=none; b=KeRhGNHD7JInC3z5bMDJWBl2byI6/yFHaXJ/NnGKGhJy3JNGpJe0S6LRV2eiZJfTTKcWrO/irJvegOokV6D1YcdONE/VsqTLe/YmOeSInwuIx/lRoy3S9gv4kpUudsJPUcL7BgPr2FHl4/i+MhRc13mZdSk6L/sVWTLblOUtOUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126662; c=relaxed/simple;
	bh=GUJfb1dZH5eozewGcXpc6Sxm8HbaN4pR4TBhU3/Gzy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6PL/YzF1gmg9qv1u4RzEZYEkW8r7ZIXd/jEYdWsPlhPXXpPM8DMcdeGsP6vmJm+Ux4QrYDqwwBkIFXvN0jqoY7x8vXv0bjVU3sqKfVYNA9hyaJH9iiaQ9a+MeBATBoJU4XfvfwR9molmejLUBeRZVsaSSzs3bpHZNJkOivTYA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A/YJamef; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IqqpPENI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A/YJamef";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IqqpPENI"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GOQFh1496399
	for <iommu@lists.linux.dev>; Fri, 7 Aug 2026 18:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6/g900LeMuA
	9H91SWWyZJUr2BtZA/MVuA2CBGYpOYUk=; b=A/YJamefyWCCP/VUAE5x5QtbwKu
	5I72lFTZwcNVILZidWXJYo5m+T/UddpFyXBALhpFXo3WaLGYhLj2bRLcO4PCnZeN
	5Jalna6M+RS8xV0n2RUkJtUzHgf+fqkRQVisGCcsGjy/Njx11/BzOcmAA9GVIe55
	cUzwOnYseLMatAY9XgOwNM2AUyfMyaESaqYmAG5qTkh0w1LFfu3shPRv7KuHCmTC
	Jagfe2GIHFNNsW8igNru0Tc8eDNbPIlclYBwbE1Wce4qBOoZHsiqEs355lgnzRSl
	DX9ib2770l82OrLHKUkQ9oryr+ryJmK3to+5OtLqTcDfuGFaXontkBG0FLg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwctpa3py-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 18:17:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1d137a68so67168001cf.3
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786126658; x=1786731458; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6/g900LeMuA9H91SWWyZJUr2BtZA/MVuA2CBGYpOYUk=;
        b=IqqpPENISGE5P9ZjNObjVwjBmjKFdxQCWBbJ76xXKKSa2/2XIagk+Y5uTg4peytBXR
         SFuiz8BLZesIVt5Lra9lovTjyj87A5SkGOnckX1T8+7kfIKFYyuRB4DkLBSN6VmjoYkA
         rKHSU4lcs6QOA738pwDYesysIwpF5ElFNe52zR/9Y5NEo5h6dPjTlDTOxjc2uBmpgICU
         FjylqCM1wfw1nMOsZiyB/TB/Ebx3lZ6r64T5tjfSc/f0iKCGtACPGHd3DpuIxgcfJABs
         T1hoOpuWnwQtANlbesULvX2VylNhw3dozeHb6HjuzxZkeVIdzGLLjHygVpiTZ2DJ702A
         CPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126658; x=1786731458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6/g900LeMuA9H91SWWyZJUr2BtZA/MVuA2CBGYpOYUk=;
        b=BYorBR/BQnC/I+q/rhJOUvit3pOdUeRfcEXFn976CS3yOL2PT0qdN9cF4CdDSX4QQn
         5ccVSt+ze7J1jHY7oYS938IyS2Q8YATcrHbMYMU07fMegTm4OVxy4QYX2m9D3WuoUrbY
         KKNY5Sg205EzYyLN7eYC2dlkowlQOhQ2JTsOWTM6N2IXvMWOiW21grDL2m/9hT1p0sBm
         XlrjGOKDKfs2Vqn4fQJUFl4jRQmd5J4yGiqfCxisa9MA9GDrovoSezY9mEOIeDgexmZn
         yEDoHZdCUJoTSDR2sifllvlXYNU3cTQRnfYRRigeVha79bLHVMsVaw4SM/Lo2kxCv0ya
         FRsg==
X-Forwarded-Encrypted: i=1; AHgh+RpAgii5JZoQjEKwxkbzdquPRnYLjGKTeD0L8+Ex+ExfctJUm8wk1ccLAYuOqg6hF1Q1DD+VTw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yym3SrNsmEu/pLndBiCWvv5VZEn99o8laNNIB9MFUKZgk6E89UO
	0wZaA4U5t0Z4UCIflFLE2AczinA2k0bgSSw9NIsHuIzKcpzMLqkRYPFX6je4JFhoBNiSQwuGeN+
	oq+6jrfUec1na7mb584x1AkqrldgPw5pFg0watwEiM50P6//203/SQrZjgw==
X-Gm-Gg: AR+sD12ILpHJcSnGEzGkMmr36f40Yj/PDx4xcra8rvbFZ9cxl8+xeTxjqz8JJY5lYS9
	Ok+tIHbgThNn+evaDMspunGaSTceHGwFRbaVg3Gz6L/K9i6grz/7m0CuGSdmUGwYql61lOMNjvR
	N3fGtzsLZpgYBnFDbw3Dl8JshSjhb58ypsc5q0yCu98nNDf6RSTcdd7vLSu1iaClHQbK18DYGpS
	q9dpmTeA6H8u2EmljcnFEx4Q1m60XKKvUZQj4LWqS35t290g2uw0TYiI/5icDuFE8i0uRaa3/PQ
	I616XzGLzXbfhg+Gcs/7ordkoWXnInQlcQPuZsuimWbgYmW4YJsVrn2HYweUJaxaFg8rFWUk0FP
	3Bd5X1zdL31Eb72l9Ag30+NunWP6fdVgy6Z9zh/I=
X-Received: by 2002:a05:622a:400d:b0:527:8651:7f7a with SMTP id d75a77b69052e-52d20a10f25mr38176981cf.26.1786126657966;
        Fri, 07 Aug 2026 11:17:37 -0700 (PDT)
X-Received: by 2002:a05:622a:400d:b0:527:8651:7f7a with SMTP id d75a77b69052e-52d20a10f25mr38176331cf.26.1786126657521;
        Fri, 07 Aug 2026 11:17:37 -0700 (PDT)
Received: from localhost (ip-86-49-241-13.bb.vodafone.cz. [86.49.241.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080c90494sm80217466b.36.2026.08.07.11.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:17:36 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v3 11/19] iommu/riscv: Copy MSI IOVA table when replacing an iommufd domain
Date: Fri,  7 Aug 2026 20:17:05 +0200
Message-ID: <20260807181713.228535-12-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
References: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Fp01OWrq c=1 sm=1 tr=0 ts=6a762142 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=VPysOpcHbS0DNrM1Xqmyow==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=advkBHUnGrKv1w340x8A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: Yykin3wZmdyGc-UhvZ6xv67gEJx730D8
X-Proofpoint-ORIG-GUID: Yykin3wZmdyGc-UhvZ6xv67gEJx730D8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX3EheIWPCoSMY
 9qTbXuFc0PskJnPLPBcCwJh73dves2qPL2yz1fE7aPcCXQigTbajjampupKhaRZsZR6ddSS9fh+
 M1evUUJReX5dif1km2rF8uddqTinUJ+lHPS+G5r82RN2uDT4YcS4Q/YvWV2xBQH1K/JZNlHwlem
 +ZHY7LubCy3ukIwaUhNQbsSPmH7dcaQigLqWAlyoEZuq4R7jpbdvGnoAp0sRJHrDwPaA8lHTHIk
 7waAzUhubqI++vuKUliy/zmVDffjsoj+WoKDeuhsBmGtW8sWmIKuSbrMdDr0ku7WCcB9ZfrgWqB
 tz5lOfCh8ng75Vs+ChnoGxGS9ApRxH/BokG2gtX2Rk2x9bHgbGOD5ZTc4JpkTcgSPrRG7+SFfmF
 ZP2hrvX2QGKzr+4jwxVpP9GDZM0YRq+vABfnIJOTAcGEuhAJtY83bwLMIgRJjKS1/b3ACsNiTEi
 VaLQrn/Qd4hYao02w5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfXy/Q30yWopoFZ
 A+7b+tnPAG94nUBzHqMB5GHcLXjsshF+WOLdbY+JQhd7J3HQBSEufxK1VLUkwsKd3c4w6dm16Jj
 cwWPb0x5dzag2x6oyPQTDUf7KDrkg1g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070143

iommufd may replace one paging domain with another on a device while
leaving the device otherwise operational, e.g. when converting a
device's HWPT. If the old domain already had a populated MSI IOVA
table then the new domain must inherit that table rather than wait
to build its own, since the MSI IOVAs are only built on the next
irq_domain_alloc_irqs(), which does not happen on a domain
replacement.

Only copy from an old domain that is a genuine RISC-V paging domain;
iommu.c already has riscv_iommu_paging_domain_ops in scope to check
this, so do the check there and pass NULL down on a mismatch. This
keeps riscv_iommu_ir_attach_paging_domain() simple: a non-NULL old is
always safe to cast with iommu_domain_to_riscv().

Only iommufd cookie domains are copied from and to, since VFIO type1
and DMA API domains build their own tables from irq_domain_alloc_irqs()
before any device is attached, and are never replaced while a device is
live.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu-ir.c | 78 ++++++++++++++++++++++++++++++++--
 drivers/iommu/riscv/iommu.h    |  2 +
 2 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index 0dff74aa9b18..7d9a1eaca92e 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -118,18 +118,26 @@ static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
 	 * quiesced, including MSI teardown, before switching away from or freeing
 	 * the domain. iommu_dma_map_msi() requires the group mutex to be held;
 	 * take it around the domain lookup too so info->domain can't change
-	 * out from under the build.
+	 * out from under the build. Bump info->nr_msis here too, before
+	 * irq_domain_alloc_irqs_parent() runs unlocked below, so a concurrent
+	 * riscv_iommu_ir_attach_paging_domain() can never observe a count that
+	 * is lower than the number of MSIs actually in flight for this device.
 	 */
 	scoped_guard(iommu_group, info->dev) {
 		domain = rcu_dereference_protected(info->domain, true);
 		ret = domain ? riscv_iommu_ir_build_msi_iova(domain, info->dev) : 0;
+		if (!ret)
+			info->nr_msis += nr_irqs;
 	}
 	if (ret)
 		return ret;
 
 	ret = irq_domain_alloc_irqs_parent(irqdomain, irq_base, nr_irqs, arg);
-	if (ret)
+	if (ret) {
+		guard(iommu_group)(info->dev);
+		info->nr_msis -= nr_irqs;
 		return ret;
+	}
 
 	for (i = 0; i < nr_irqs; i++) {
 		data = irq_domain_get_irq_data(irqdomain, irq_base + i);
@@ -139,9 +147,25 @@ static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
 	return 0;
 }
 
+static void riscv_iommu_ir_irq_domain_free_irqs(struct irq_domain *irqdomain,
+						unsigned int irq_base, unsigned int nr_irqs)
+{
+	struct riscv_iommu_info *info = irqdomain->host_data;
+
+	irq_domain_free_irqs_parent(irqdomain, irq_base, nr_irqs);
+
+	/*
+	 * Decrement only after the parent free completes, so a concurrent
+	 * riscv_iommu_ir_attach_paging_domain() never observes a count lower
+	 * than the number of MSIs that are actually still live.
+	 */
+	scoped_guard(iommu_group, info->dev)
+		info->nr_msis -= nr_irqs;
+}
+
 static const struct irq_domain_ops riscv_iommu_ir_irq_domain_ops = {
 	.alloc = riscv_iommu_ir_irq_domain_alloc_irqs,
-	.free = irq_domain_free_irqs_parent,
+	.free = riscv_iommu_ir_irq_domain_free_irqs,
 };
 
 static const struct msi_parent_ops riscv_iommu_ir_msi_parent_ops = {
@@ -213,6 +237,54 @@ void riscv_iommu_ir_irq_domain_remove(struct device *dev, struct riscv_iommu_inf
 int riscv_iommu_ir_attach_paging_domain(struct iommu_domain *iommu_domain, struct device *dev,
 					struct iommu_domain *old)
 {
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	struct riscv_iommu_domain *old_domain = NULL;
+	dma_addr_t *msi_iova = NULL;
+
+	if (old && (old->type & __IOMMU_DOMAIN_PAGING))
+		old_domain = iommu_domain_to_riscv(old);
+
+	/*
+	 * Copying is only correct between two IOMMUFD domains: their MSI IOVAs
+	 * come from the fd-wide SW_MSI reservation, so they match across
+	 * domain instances. Every other cookie type derives its MSI IOVAs from
+	 * domain-local allocator state.
+	 */
+	if (old_domain && old_domain->domain.cookie_type == IOMMU_COOKIE_IOMMUFD &&
+	    iommu_domain->cookie_type == IOMMU_COOKIE_IOMMUFD) {
+		scoped_guard(mutex, &old_domain->mutex) {
+			if (old_domain->msi_iova) {
+				msi_iova = kmemdup(old_domain->msi_iova,
+						   riscv_iommu_ir_msi_iova_count() *
+						   sizeof(*msi_iova),
+						   GFP_KERNEL);
+				if (!msi_iova)
+					return -ENOMEM;
+			}
+		}
+
+		if (msi_iova) {
+			guard(mutex)(&domain->mutex);
+
+			if (domain->msi_iova)
+				kfree(msi_iova);
+			else
+				domain->msi_iova = msi_iova;
+
+			return 0;
+		}
+	}
+
+	/*
+	 * No table to copy: build one from scratch if this device has ever
+	 * allocated MSIs, since those MSIs may already be live and expecting
+	 * riscv_iommu_ir_compose_msi_msg() to find a populated table for
+	 * whatever domain is now attached.
+	 */
+	if (info->nr_msis)
+		return riscv_iommu_ir_build_msi_iova(domain, dev);
+
 	return 0;
 }
 
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 8bd41dd63f0e..77328282a236 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -46,6 +46,8 @@ struct riscv_iommu_info {
 	struct riscv_iommu_domain __rcu *domain;
 	struct irq_domain *irqdomain;
 	struct device *dev;
+	/* Number of currently allocated MSIs; protected by the group mutex */
+	unsigned int nr_msis;
 };
 
 struct riscv_iommu_device;
-- 
2.43.0

