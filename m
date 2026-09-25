Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5884C14E9
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349460; cv=none; b=fF6zLHCYzR4hnhurVE9+QPf/Lx3Py6880pKNdEwhBAsLZZhmdJb7Ex68ZFTSZjoP64plVLL8arMCBZcZc02VsGv07CMM1hJsxrQEYQlJ8NFDHRwFsXsCRbhEpGb5g3aLO3hHQdDj+XrZUy+JflWajyC3VZRTIxfTF9T4vUZeht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349460; c=relaxed/simple;
	bh=i3LJkXJkMPMG/BZ2K11gluxnu+R1mXh9KW7oECd5B8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDLtakRRM3bKOn9avXeyO2Ij/RmT7ZS9MqSJXXajE9aVvM/b7g4EdQFgg5afqJm1sgQdmFN3duzHYbxrEyLJUFu0K4dw0DhfsmEp3Gzj8MMnHE5iQPCTiZVuBOSo0OnjyQvbvlzIC72nDidribi0xMQLMAIXeIRv087ukOfui0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RsFJCofP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G+VSbfqi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RsFJCofP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G+VSbfqi"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PDBXmu289534
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uT2Prej1vk3
	zX/S7OPlnxWtUB4o0ge4FHSI3+fpimn0=; b=RsFJCofP6D7YELjwGy6lL6vLqOr
	6OBWBvtxish1i0NL63QEjXLIGylTuxJ+dc3gKsZlgENKFQI5AMtQ9ecDBRTcSmsn
	U+txaH85MicWmrbbZwElQWD7qD+u7SQC3YrOrpcEdNSLKgCpohDnl8gzRFv9ddHa
	1ZuT8PIj/3T15h8jIbqJofjo2CLmJV5rDUO7jyriGf6xsc0WRNoWKUfsz/yQiBLJ
	ds2DZYtPgrc4kGO8Bbe1sgqZYf+orTGB+KqKr3MD3Q5r4pLRQNHJJZOp6OmGfyTb
	+ZdyYyanVOctpilJLKOyP5gUwYEL6abQD4neXLC9NM4grS0HcsIRkXTW82g==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw881v4ua-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:24 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-98527cdac1eso119006241.0
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 08:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790349444; x=1790954244; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uT2Prej1vk3zX/S7OPlnxWtUB4o0ge4FHSI3+fpimn0=;
        b=G+VSbfqi/FrSVDd0U/VCN9hPMwBPCqbAeLNDXmHqBj9gn0/4FPlRf1geHeBP4Dh4BK
         0dySuNRdXnpzQrl7fIubEu+prJG8p3qV32IMSzYOFWTNd31hDzWMBT3LvbifSzNozKG7
         nhyp5LwQw1VgtnzZgMAVUnXoFg18MjD9TyGD0+WWJaBXcuPYp66G/1V2bD0P/SwpGjVR
         htOuol2E8y+GyWle4ceL5uM+il/PGqlRyicdXGSx/rWbwN1ttDpEYTqOdXVRN58tMMK+
         CC175BaVE7Y8Jr1ke00h05cbKotHqY6H3OxrysMtod/g4JdsB5cw/eNKqBYrasjykBX7
         ES+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349444; x=1790954244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uT2Prej1vk3zX/S7OPlnxWtUB4o0ge4FHSI3+fpimn0=;
        b=nNQiWZ1seenUB0JfImkTxuaJupkZoOX4QYmMVNO3wyeqbNF/wigtYC71kiYbtuY5nf
         ER0hPTzPo/1ODfy1s8aGF9qW+2udp4UFJkDGxurGWYX2uYm6JQXj/kECYvGJ0mR/OCqG
         FX2afg0PiaztZjbbHY0u7Z7WXdR/PtRTrp/124H/KlOKqU0J1Tw3fPXQ3zM7M4k54Ljd
         Q6IZbXX4cYU4j2XEGbh3cywjF7UB92ZNwtyRy6p6S3SW9WoCIlsNq6kuSMUMAzZeNJpf
         BP7jq0YEmlvWVNsAeijgSqRzFZrSFXLCOe4Vr4EtT0gSb5Iskmx10aBgqyRhSYgkSJKg
         6M2A==
X-Forwarded-Encrypted: i=1; AKwUvBwtt9RMydpLUASqgGsXg2mSQZZBYBl5k6UWthMh6VIshQm0E4hiOVf2TqgegP6LfDUPWhYM7Q==@lists.linux.dev
X-Gm-Message-State: AFuF++naSVjPrHImQgouVLdLwzTlaaRmsYm5nXQrki/5ac02Vp7a1mVB
	fcCJgvPRLTNd39X8NlBI+YRgJ7IFwQ783BLC01QBXNJvF5rWk17x3v+nxvuExLBhqyzLlCbZ5B2
	hnTUSidWTei9P5fK+gI1SAGNaPUUAGfsBV5rUlaHzlQ0Lln2U/7ns6LP2Fg==
X-Gm-Gg: AYBFou27DjDrs+1ridYUqGUFfRaKTSmYvOoCpXrHJif9te73JvYOknsqduoxY8PUtvY
	D5R8GDzXE2jBsDYf2hI/F+6uTqCTQ8hBNYeS2rVIOeeSzJeza7kfwLurX++W5uVQtSAIJJibgS1
	lvHflrKvE8aP+v3KG6n4KFPg9iHLbOY93DXUumOBrUbDHvNrUhXYYKvlJymsGgMq06Q5lTPiQpn
	3hD1JS8poODmpK1LxNDNNTvC25FiLaIhfKDw0EnGUSuyeZuVbQnkxJpmgJaBjeL0qLmz/opO6HM
	EbyK7y6w+3LfvBpTBHBKiIhucM7Gr0dBIc7m2A1x3CLlriFs7PQMhLT6g0lCWkjrlRiiM+Ggvrh
	JQ6Zvt3ZGKvD7GRkNzAZ02+LLu/L9e4ECE+6WUw==
X-Received: by 2002:a05:6102:4b14:b0:79c:99ea:2c9a with SMTP id ada2fe7eead31-7af1cba3036mr2420131137.11.1790349444051;
        Fri, 25 Sep 2026 08:17:24 -0700 (PDT)
X-Received: by 2002:a05:6102:4b14:b0:79c:99ea:2c9a with SMTP id ada2fe7eead31-7af1cba3036mr2420112137.11.1790349443361;
        Fri, 25 Sep 2026 08:17:23 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff43ad975sm63738805e9.13.2026.09.25.08.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:17:22 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v6 11/16] irqchip/riscv-imsic: Support IOMMU MSI address lists
Date: Fri, 25 Sep 2026 17:16:54 +0200
Message-ID: <20260925151659.419512-12-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6ab69084 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=SRrdq9N9AAAA:8 a=jAyyop91dzRkNHH0oPsA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfX3xWMiB6hjxkN
 un0XTn0Mos4TfYtjPd4SP2DzhfQcvHf2qNAheJzK33S5peWCAmbdns1d3nxFEDN2V+pN5ktmhIt
 F09zR5NrlF/YnyZG34UEM++BIMlIbKgHhEPo73IsckOmIgzzpnj+kMgNtcKBhtUi0HbqvBFp9Es
 D9cS6wYv89hZ+yob7nDEgIUAoLmAkFjU0x2hY+r27Yox7yO3P1phQi+eFR38crh5VXbVxYYcyjA
 Uy9VAkjIiVilsIp6iKbzMSwHrKEzetc74yQG4ZwaS7p9E2AU8KdjoIgLU/mRNIByh1tqNN64r9Z
 s0sB5lIFaNKZqfCw1ZfEbW63cNXgACg3KAvHzawImaOtmDUbXTAs6CSlRgrgSFDDIHWv3ho7PaL
 rhS+/M30SHyvQDrbG2rme6Kp0BLMpRQrCWL3UfmZ2hMHQAd0V8AzNcP9DxVQosXcAUb9ug3UsbA
 la8Zuj3RG/fxVPWyuWA==
X-Proofpoint-ORIG-GUID: kusuQp5-PHZFClcBHfDigcWwQc_1VsUT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfX2HAphI7jApnj
 tVLKcDZmlHoMHtX2cCN7jprXbV9iHBaGqtog30aZNHttrmVnEjhYvmaCrbPfkWGLSfy4k8AHmVi
 mrTtS2UBt2sUHLSfF+X00c+VaU/vgGE=
X-Proofpoint-GUID: kusuQp5-PHZFClcBHfDigcWwQc_1VsUT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250060

RISC-V IOMMU host interrupt remapping maps every possible host IMSIC
target into one contiguous IOVA range. MSI message composition therefore
needs each target's position within that range.

Prepare the complete IMSIC address list while allocating an IRQ. The
list is guaranteed to exist after IMSIC state initialization. The IOMMU
backend maps the pages and caches the contiguous base IOVA in the MSI
descriptor when translation is needed.

When the descriptor has an IOMMU MSI mapping, use the selected logical
CPU directly as the page index within the IOVA range. Use the same path
for initial composition and affinity updates. A zero iommu_msi_shift
means no MSI address translation is required, so keep physical messages.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/irqchip/Kconfig                    |  1 +
 drivers/irqchip/irq-riscv-imsic-platform.c | 24 +++++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 20b77fbc51ee..a038e1121be3 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -651,6 +651,7 @@ config RISCV_IMSIC
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_MATRIX_ALLOCATOR
 	select GENERIC_MSI_IRQ
+	select IRQ_MSI_IOMMU
 	select IRQ_MSI_LIB
 
 config RISCV_RPMI_SYSMSI
diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 643c8e459611..ddb2bb570cdc 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -10,6 +10,7 @@
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iommu.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
@@ -69,8 +70,10 @@ static void imsic_irq_ack(struct irq_data *d)
 	irq_move_irq(d);
 }
 
-static void imsic_irq_compose_vector_msg(struct imsic_vector *vec, struct msi_msg *msg)
+static void imsic_irq_compose_vector_msg(struct irq_data *d, struct imsic_vector *vec,
+					 struct msi_msg *msg)
 {
+	struct msi_desc *desc = irq_data_get_msi_desc(d);
 	phys_addr_t msi_addr;
 
 	if (WARN_ON(!vec))
@@ -79,6 +82,12 @@ static void imsic_irq_compose_vector_msg(struct imsic_vector *vec, struct msi_ms
 	if (WARN_ON(!imsic_cpu_page_phys(vec->cpu, 0, &msi_addr)))
 		return;
 
+	/* A zero shift means no IOMMU MSI mapping is needed. */
+	if (desc->iommu_msi_shift) {
+		msi_addr = (desc->iommu_msi_iova << desc->iommu_msi_shift) +
+			   vec->cpu * IMSIC_MMIO_PAGE_SZ;
+	}
+
 	msg->address_hi = upper_32_bits(msi_addr);
 	msg->address_lo = lower_32_bits(msi_addr);
 	msg->data = vec->local_id;
@@ -86,7 +95,7 @@ static void imsic_irq_compose_vector_msg(struct imsic_vector *vec, struct msi_ms
 
 static void imsic_irq_compose_msg(struct irq_data *d, struct msi_msg *msg)
 {
-	imsic_irq_compose_vector_msg(irq_data_get_irq_chip_data(d), msg);
+	imsic_irq_compose_vector_msg(d, irq_data_get_irq_chip_data(d), msg);
 }
 
 #ifdef CONFIG_SMP
@@ -94,7 +103,7 @@ static void imsic_msi_update_msg(struct irq_data *d, struct imsic_vector *vec)
 {
 	struct msi_msg msg = { };
 
-	imsic_irq_compose_vector_msg(vec, &msg);
+	imsic_irq_compose_vector_msg(d, vec, &msg);
 	irq_data_get_irq_chip(d)->irq_write_msi_msg(d, &msg);
 }
 
@@ -225,7 +234,9 @@ static struct irq_chip imsic_irq_base_chip = {
 static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				  unsigned int nr_irqs, void *args)
 {
+	msi_alloc_info_t *info = args;
 	struct imsic_vector *vec;
+	int ret;
 
 	/* Multi-MSI is not supported yet. */
 	if (nr_irqs > 1)
@@ -235,6 +246,13 @@ static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	if (!vec)
 		return -ENOSPC;
 
+	ret = iommu_dma_prepare_msi_list(info->desc, imsic->msi_pa_list,
+					 num_possible_cpus(), IMSIC_MMIO_PAGE_SZ);
+	if (ret) {
+		imsic_vector_free(vec);
+		return ret;
+	}
+
 	irq_domain_set_info(domain, virq, virq, &imsic_irq_base_chip, vec,
 			    handle_edge_irq, NULL, NULL);
 	irq_set_noprobe(virq);
-- 
2.43.0

