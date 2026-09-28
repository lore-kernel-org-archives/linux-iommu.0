Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151BB4DEC0A
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605952; cv=none; b=gsBj6+rxavz3V//PmBOcGgYc4m+TfjeW9yyd6QP+t+f1gsthQ0kwGH0vcyWQkrthcP67bkIyccTsSolwDnION39EWPu6I/lwnHRllLA4pGEFuOffWJmkWodoAaUI2UYauxJMWKkQ3kKcVQIe6nUCjGEwyugVAFoblrPoZ9xOsRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605952; c=relaxed/simple;
	bh=OkQmDEYnyASIKXPi/oPrzOVrVCnezyFBIBwxR3DV+jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwxH6sx3rvdE+UYn5q1UlrFSUrt5WEwC+oiIogu5cFC+WhwGW7q8/Pmr8H9u10RZZwZSUZcb/nJwHkgZIuO/EDRepl5ojIgxa0fckFMos1/lacR6+8pQSuTq7cttTtfBiZACha+hj4N6XXH2Y451562Lt950pz/Z9gnp+J0/ltc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F1lvity3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iyF8LPTq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F1lvity3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iyF8LPTq"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAMPD1839663
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tebmqV7yCOW
	UuIVhUGJYMDQXIsJi15ImmfVHeeil9JY=; b=F1lvity3l1MF4Z9dAHH1Wo09WAW
	F+V4zrpfdEK8L+NQ/v2KtbxpP6z7/QGlpNWSdVGve3NMMt6EDHiQD7KULT0doEs6
	Df9TpuC1QZYvDO96q2ED4+nqH4GmEGvKxrIq9p7D+8P734Gq+NpN9/D/x60d+0Qy
	BPQUG4HQNqEW8z1PyFX21py9FnG9qMJeuLk2kvX0XExOUR4F5h1nVTkztwp7PnPN
	4VkkOCQ5hTEJpLMht0WJC6g37JMH9APOGcpM0qUPlHzr6oSTF6JEUYG44noD9Mu8
	9FztFj4iCJClY2PF57YIrz15FgHNKjHXVFVZf01u6ofHdoUb5bnbZky2qUQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynb6h6pa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:32:22 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7b3beb638e2so1695256137.0
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 07:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790605941; x=1791210741; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tebmqV7yCOWUuIVhUGJYMDQXIsJi15ImmfVHeeil9JY=;
        b=iyF8LPTq3UpFY2t6WmBdfpjd4lQDxiRqRmP1jeLzwU8021h2y05mC7hpPNYBx7D1mm
         381Z7tFmPcXXdJmNYoULEU0qHZ00frOvJ4DajFu0frhhRvv5WHZfDGrtud05KWPihrXo
         mHOi/3nP29Hk7NeLwtFSSR4MxZReFtu7izBC65PM/ZK1oIFEKJzEknV3kYbo4gwLXM7R
         u/IOYpW/7MA6Qeyuyfwc6rYxSypQDNeycBgW1qs+J6Ohfl7/LAQZ7d86u0t1+jEQxqo/
         BBKci2ENaItVA2l5fBs3aELQTpwRjTmslPVtTz/6bW0mE1m2CR/R0PfrQZ1V81Nfz8KG
         paRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605941; x=1791210741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tebmqV7yCOWUuIVhUGJYMDQXIsJi15ImmfVHeeil9JY=;
        b=WBduKHnC62jxUFGskloebT+4qmMf4bBKcWAPMJZI00LiwMRo4RwoQDhyzFU8in7vG6
         A1iY8rFl2cNxVF2BCfDNlGPz4lMkDUkvefTABJvKhQroQS5nIp19snjEYNObEUDouROX
         Uq7nHaeR58648gxKET3+OH8sPyKVo+sdDEZ1VE8Ka1XmJXvIShSSorlzr1hFGVEGPqk+
         rWAWw6xV41FeksGanIpCvm3dPKSTK0AmjyxiXDZJ/4kejkFCymhNJI1wy9MEKCC9q1Z/
         TxF3PBgzoU6vd3TRYL5R/KQUJ+xR4Uf5PE5fShV6uqKomtXAT1WwCSV+YAjjKZNKUM+0
         rEuQ==
X-Gm-Message-State: AFq9FYIl7qAcxDwKIgVYao4npAGtqNBSDYZqcpHOXz2Ac3wXfZjm//XN
	45zr8tmar+lrf37+paYsos0Q6q6nrZi4UfzyD4Fa2hCFI8wWkA+t1KY58Hrw0VWcHksmrvsrpvj
	2IviOFSnE20YYArbvECLA7qODlyHpjVmotkOglDywOSo3rFkvwW13rTx73rARb91Zgg==
X-Gm-Gg: AYBFou14uHu0mgL/t+TpbyiNM7K1XGfieOhW6iJpRHgysSWIRCRjI54hRzV10i5Um4r
	g1ELieaV+z3KK3lXnF+vTUoid8fFxi7lKzYMxMlcYdkU84/ZdV8PCA2LxkjwqpXI4EkGJLpMc3w
	wSxqUkBhH4vld0qHBwTt0bM2DbQyvnl4dPBPfr4iHg1Kjll1E4yzoRUv8X51XTRIDVblLtg6Bu7
	Jgz8A3UJez4uP3VS8umym2N0vUIbhsGkEamVDWAz4GfWb/eBWGiaRZS8AMEAEPTyowSZrPKa6A5
	5UKsYK64hm85SgR2nXeQxnaCk+RjkfrAGELbz6GgErglSdsnv86fWqz0ttjtsRw9GUdDWF/hL6j
	04Q7RJw+f80ZYMYzQNPQOM5RM/khtLTjarkfdYA==
X-Received: by 2002:a05:6102:6896:b0:7a4:a8c4:42bf with SMTP id ada2fe7eead31-7b3b92d1b94mr1507275137.17.1790605941406;
        Mon, 28 Sep 2026 07:32:21 -0700 (PDT)
X-Received: by 2002:a05:6102:6896:b0:7a4:a8c4:42bf with SMTP id ada2fe7eead31-7b3b92d1b94mr1507262137.17.1790605940898;
        Mon, 28 Sep 2026 07:32:20 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc8b71b4dsm255359866b.1.2026.09.28.07.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:32:20 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 13/14] iommu/riscv: Validate IRQ forwarding requests
Date: Mon, 28 Sep 2026 16:31:12 +0200
Message-ID: <20260928143113.49838-14-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NyBTYWx0ZWRfX4j6+zgTZt3xF
 FnoOfIwB5Jhd+L5nWo5NGwPwS6StR+p7FqZKrNAF5xkbaSbDcG9xd/Q6kBnReoik+YUVkDc6dIS
 51hV22iIz2O6u56CKNu/oqoFcbM54Rs+LW/URYj3hMxSXkbBBNuflhv4tAfWTwz+Mfdo6m4c9/Y
 F0ZUAiWNNUkayB18hDNo9aDn3fr0F/E6ZIK2P7T1BI7utz0EHQBPc7MKjG+c2yXJ431Uv3RVutI
 2hv7P+iyITnjFp3gQQdXBSPE88f4v2+7j2C7ZmpdmFRJCIwkvG0EOcYzm5jfbFXeXr4f7qdE6RG
 9+KstkgVuki8hQUxyeCESRYOdGkPsQTZk653izpI+xlGOwPouIAi1kXO6/vPuSC+e4birG73jtt
 1pPbeVy2t/jEIHo4+L9toFjrTP3f1cTYsvUSczy+3PGcN8pCddK6v6ao2zBxlTozOznb0R7cOXu
 Kf5veQKhYeSsMcPgWMA==
X-Authority-Analysis: v=2.4 cv=K+e3jCWI c=1 sm=1 tr=0 ts=6aba7a76 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=h2dR55gVlEbTIpH6insA:9 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NyBTYWx0ZWRfX0+2OjoO8+NYw
 toTRvAyJap2p2BKWG6xmH5uV1RXqLkeOTUNzG8/iRUvNxp44CqPK0KF2TbkeQEF+iyOTPJWTTiM
 8HUdeHsBQgLVIiIIPTONPVBg+b5tH2o=
X-Proofpoint-ORIG-GUID: uArBwLeqNZ0QcRCi_CjoA-FP40PcXpW8
X-Proofpoint-GUID: uArBwLeqNZ0QcRCi_CjoA-FP40PcXpW8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280057

irq_set_vcpu_affinity() receives an architecture-specific description
of a guest MSI topology. Invalid address layouts or targets could select
the wrong MSI PTE, while accepting a mode unsupported by one of the
IOMMUs serving a shared domain could make interrupt delivery fail only
for some devices.

Validate the request before the table can be activated or updated and
distinguish malformed input from a valid configuration that hardware
cannot support. Check capabilities across all IOMMUs bonded to the
domain, and retain the requirements of an active table so later target
updates and device attachments cannot weaken them.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu-ir.c | 127 ++++++++++++++++++++++++++++++++-
 drivers/iommu/riscv/iommu.c    |  31 ++++++++
 drivers/iommu/riscv/iommu.h    |   2 +
 3 files changed, 159 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index 22da76987c7c..12a5d0bc77f2 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -20,9 +20,120 @@ static int riscv_iommu_ir_irq_set_affinity(struct irq_data *data,
 	return irq_chip_set_affinity_parent(data, mask, force);
 }
 
+/* IOMMU extract (RISC-V IOMMU spec section 2.3.3) applied to the two-run IMSIC topology */
+static size_t riscv_iommu_ir_extract(u64 value, u64 mask)
+{
+	/* Separate the optional group index from the low guest and hart indices. */
+	u64 upper_mask = mask & (mask + 1);
+	u64 lower_mask = mask ^ upper_mask;
+	unsigned int shift;
+
+	if (!upper_mask)
+		return value & lower_mask;
+
+	shift = __ffs64(upper_mask) - fls64(lower_mask);
+	return (value & lower_mask) | ((value & upper_mask) >> shift);
+}
+
+static size_t riscv_iommu_ir_nr_ptes(const struct riscv_iommu_ir_vcpu_info *vcpu_info)
+{
+	return riscv_iommu_ir_extract(vcpu_info->msi_addr_mask, vcpu_info->msi_addr_mask) + 1;
+}
+
+static int riscv_iommu_ir_validate_target(const struct riscv_iommu_ir_vcpu_info *vcpu_info,
+					  const struct riscv_iommu_ir_target *target,
+					  u64 *required_caps)
+{
+	u64 addr = target->gpa >> IMSIC_MMIO_PAGE_SHIFT;
+
+	if (!IS_ALIGNED(target->gpa, IMSIC_MMIO_PAGE_SZ) ||
+	    (addr & ~vcpu_info->msi_addr_mask) != vcpu_info->msi_addr_pattern)
+		return -EINVAL;
+
+	switch (target->type) {
+	case RISCV_IOMMU_IR_TARGET_IMSIC:
+		if (!IS_ALIGNED(target->hpa, IMSIC_MMIO_PAGE_SZ) ||
+		    (target->hpa >> IMSIC_MMIO_PAGE_SHIFT) > FIELD_MAX(RISCV_IOMMU_MSIPTE_PPN))
+			return -EINVAL;
+		*required_caps |= RISCV_IOMMU_CAPABILITIES_MSI_FLAT;
+		break;
+	case RISCV_IOMMU_IR_TARGET_MRIF:
+		if (!IS_ALIGNED(target->mrif_hpa, SZ_512) ||
+		    (target->mrif_hpa >> 9) > FIELD_MAX(RISCV_IOMMU_MSIPTE_MRIF_ADDR) ||
+		    !IS_ALIGNED(target->notice_hpa, IMSIC_MMIO_PAGE_SZ) ||
+		    (target->notice_hpa >> IMSIC_MMIO_PAGE_SHIFT) >
+			FIELD_MAX(RISCV_IOMMU_MSIPTE_MRIF_NPPN) ||
+		    target->notice_id >= IMSIC_MAX_ID)
+			return -EINVAL;
+		*required_caps |= RISCV_IOMMU_CAPABILITIES_MSI_FLAT |
+				  RISCV_IOMMU_CAPABILITIES_MSI_MRIF;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int riscv_iommu_ir_validate_targets(const struct riscv_iommu_ir_vcpu_info *vcpu_info,
+					   size_t nr_ptes, u64 *required_caps)
+{
+	int ret;
+
+	if (!vcpu_info->targets || !vcpu_info->nr_targets || vcpu_info->nr_targets > nr_ptes)
+		return -EINVAL;
+
+	for (unsigned int i = 0; i < vcpu_info->nr_targets; i++) {
+		ret = riscv_iommu_ir_validate_target(vcpu_info, &vcpu_info->targets[i],
+						     required_caps);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int riscv_iommu_ir_activate(struct riscv_iommu_msi_table *msi_table,
+				   struct riscv_iommu_device *iommu,
 				   struct riscv_iommu_ir_vcpu_info *vcpu_info)
 {
+	u64 pattern = vcpu_info->msi_addr_pattern;
+	u64 mask = vcpu_info->msi_addr_mask;
+	u64 required_caps = 0;
+	size_t nr_ptes;
+	int ret;
+
+	if (!vcpu_info->owner || (pattern & mask) ||
+	    ((pattern | mask) & ~RISCV_IOMMU_DC_MSI_ADDR_MASK))
+		return -EINVAL;
+
+	/*
+	 * riscv_iommu_ir_extract() requires the mask to contain the low
+	 * guest/hart index run and at most one additional group index run.
+	 */
+	mask &= mask + 1;
+	if (mask) {
+		mask >>= __ffs64(mask);
+		if (mask & (mask + 1))
+			return -EINVAL;
+	}
+
+	nr_ptes = riscv_iommu_ir_nr_ptes(vcpu_info);
+
+	ret = riscv_iommu_ir_validate_targets(vcpu_info, nr_ptes, &required_caps);
+	if (ret)
+		return ret;
+
+	if (!riscv_iommu_msi_table_check_caps(msi_table, required_caps))
+		return -EOPNOTSUPP;
+
+	if (nr_ptes > msi_table->nr_ptes) {
+		dev_warn_once(iommu->dev,
+			      "guest MSI topology requires %zu PTEs, but the IOMMU domain only supports %u; using host IRQ delivery\n",
+			      nr_ptes, msi_table->nr_ptes);
+		return -EOPNOTSUPP;
+	}
+
 	return -EOPNOTSUPP;
 }
 
@@ -34,6 +145,18 @@ static int riscv_iommu_ir_deactivate(struct riscv_iommu_msi_table *msi_table)
 static int riscv_iommu_ir_update_target(struct riscv_iommu_msi_table *msi_table,
 					struct riscv_iommu_ir_vcpu_info *vcpu_info)
 {
+	const struct riscv_iommu_ir_target *target = &vcpu_info->target;
+	u64 required_caps = 0;
+	int ret;
+
+	ret = riscv_iommu_ir_validate_target(vcpu_info, target, &required_caps);
+	if (ret)
+		return ret;
+
+	required_caps |= msi_table->required_caps;
+	if (!riscv_iommu_msi_table_check_caps(msi_table, required_caps))
+		return -EOPNOTSUPP;
+
 	return -EOPNOTSUPP;
 }
 
@@ -42,6 +165,7 @@ static int riscv_iommu_ir_irq_set_vcpu_affinity_locked(struct irq_data *data,
 						       struct riscv_iommu_ir_vcpu_info *vcpu_info,
 						       struct riscv_iommu_msi_table *msi_table)
 {
+	struct riscv_iommu_device *iommu = data->domain->host_data;
 	int ret;
 
 	if (!vcpu_info) {
@@ -59,6 +183,7 @@ static int riscv_iommu_ir_irq_set_vcpu_affinity_locked(struct irq_data *data,
 		irqd_clr_forwarded_to_vcpu(data);
 
 		if (!msi_table->nr_forwarded_irqs) {
+			msi_table->required_caps = 0;
 			msi_table->owner = NULL;
 			msi_table->msi_addr_mask = 0;
 			msi_table->msi_addr_pattern = 0;
@@ -72,7 +197,7 @@ static int riscv_iommu_ir_irq_set_vcpu_affinity_locked(struct irq_data *data,
 		    irqd_is_forwarded_to_vcpu(data))
 			return -EINVAL;
 
-		ret = riscv_iommu_ir_activate(msi_table, vcpu_info);
+		ret = riscv_iommu_ir_activate(msi_table, iommu, vcpu_info);
 		if (ret)
 			return ret;
 
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 514470291fd9..55c167df2c2e 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1441,6 +1441,33 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 	kfree(domain);
 }
 
+bool riscv_iommu_msi_table_check_caps(struct riscv_iommu_msi_table *msi_table, u64 iommu_caps)
+{
+	struct riscv_iommu_domain *domain;
+	struct riscv_iommu_device *iommu, *prev = NULL;
+	struct riscv_iommu_bond *bond;
+	bool supported = true;
+
+	/* The MSI table lock excludes bond updates for this domain. */
+	lockdep_assert_held(&msi_table->lock);
+
+	domain = container_of(msi_table, struct riscv_iommu_domain, msi_table);
+
+	/* Bonds are grouped by IOMMU, so validate each IOMMU once. */
+	list_for_each_entry(bond, &domain->bonds, list) {
+		iommu = dev_to_iommu(bond->dev);
+		if (iommu == prev)
+			continue;
+		if ((iommu->caps & iommu_caps) != iommu_caps) {
+			supported = false;
+			break;
+		}
+		prev = iommu;
+	}
+
+	return supported;
+}
+
 static bool riscv_iommu_fsc_supported(struct riscv_iommu_device *iommu,
 				      int mode)
 {
@@ -1512,6 +1539,8 @@ static bool riscv_iommu_can_attach_paging_domain(struct iommu_domain *iommu_doma
 {
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	u64 required_caps = domain->msi_table.required_caps;
 	bool new_is_s2 = domain->gscid;
 	struct riscv_iommu_msi_table *new_msi_table, *old_msi_table;
 
@@ -1532,6 +1561,8 @@ static bool riscv_iommu_can_attach_paging_domain(struct iommu_domain *iommu_doma
 	 */
 	if (new_is_s2 && old_msi_table && info->nr_forwarded_irqs)
 		return false;
+	if (new_is_s2 && required_caps && (iommu->caps & required_caps) != required_caps)
+		return false;
 
 	return true;
 }
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index a42f0b6a88d4..9852962e245b 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -83,6 +83,7 @@ struct riscv_iommu_msi_table {
 	u64 msi_addr_mask;
 	u64 msi_addr_pattern;
 	const void *owner;
+	u64 required_caps; /* RISCV_IOMMU_CAPABILITIES_* required by active MSI PTEs */
 };
 
 /* Private IOMMU data for managed devices, dev_iommu_priv_* */
@@ -104,6 +105,7 @@ void riscv_iommu_disable(struct riscv_iommu_device *iommu);
 
 /* Caller must hold rcu_read_lock() while using the returned pointer. */
 struct riscv_iommu_msi_table *riscv_iommu_msi_table_rcu(struct riscv_iommu_info *info);
+bool riscv_iommu_msi_table_check_caps(struct riscv_iommu_msi_table *msi_table, u64 iommu_caps);
 void riscv_iommu_msi_table_inval(struct riscv_iommu_msi_table *msi_table, unsigned long addr);
 void riscv_iommu_msi_table_inval_all(struct riscv_iommu_msi_table *msi_table);
 void riscv_iommu_msi_table_update(struct riscv_iommu_msi_table *msi_table, bool activate);
-- 
2.43.0

