Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15129448391
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905976; cv=none; b=EKuXEQaA7SaGV34ZRlLiY+xAoWER6GUhuz5aMtTD1xZNHvSeOjUPSeOsidTp1NE2fHWa575nWUyvQrQxh1xT4LvSBq4Tj4pWXq+HhsAvX5wk/p81R1ndmK7E/Fz/zlZuBWwjLyxNuUpoTgGoh15lUyqQlPqWAFIXp+Wxb62dQvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905976; c=relaxed/simple;
	bh=+dimMxD44Qyn4ORXoc+ZX2A7CJ8ku3Twf2HRWXKfpHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XiR0wjomdrg8P3xrYuNS8hMi4eeRrRur87BIT8mH6kl4x1JwSnUkufTxAvTwLG49l7So0jxCHbLubbcqM2itXIPVyqisJlvV+2u2Nysdc89u9ggPusAwFLbV5H81TIBvj+L4tMQpe/xdnXWf0Gh7m00DyXk2G/yIqoDAiPvx424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PGrX0EUG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MXm2tuMM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PGrX0EUG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MXm2tuMM"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbKR43071677
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=L0vVPoas2sj
	x1vMsJ+n0Wy1u4ubbi9EINDgHVQ2L70Y=; b=PGrX0EUGc3phd1eH9Exr0z6uk6d
	AEZO3y4qR7gbIV7akUKcT5N2UZOWdc1mx2kvL7KIisAAO9MrFAhFOaKEfePdVAmH
	IaNSLq9MdNUwrNF66ihWDH4+ZTowbEYK0cwfg8j+gR/7KC7cC+McSuNPV/T1cT5X
	CtWH9IfJ5MFCgOlBziMouSjnCS0m5kk1dleOK6E9pne9CTq4zWYnfRYsX5XMQ5TC
	s/WxNcygUxozS9660zslpoABdHIXFFhJXWIaefInVFkihQq0IMONTA3sB+2MW/Ne
	SPil/n31sjC5W+lLWIs/La5O8GqYWgqrlklUW0XkQ/duHJAuNqzqq8dWP0g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm0pwac0p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:48 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8e934385db1so10338276d6.0
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784905968; x=1785510768; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L0vVPoas2sjx1vMsJ+n0Wy1u4ubbi9EINDgHVQ2L70Y=;
        b=MXm2tuMMipxYMQ/pOEBr2AchXHrQsrCUCybusQUNUxnKL4dZm5cpJJi43D3HfLxyIJ
         /VNXsmOiiGdAoUl9w4rxDobNzbllW5XsVZtAr50EL8ShgUGGPySb7Q3LNF8J3fiQmFM7
         pnhv0qDWfif2sHqWJYNtoOZVCa2PA6iUZ2AnmsJf89zxqlyeOsJjK8ePnxzJWlMWJBAZ
         MGsZGjrHts18lxoJl+aY37MlzSQeix36rFUuw4hLAjwc8advRCnkH63xAGd9uHSyqMMH
         hUV/SDCQ2sPcU8cFJknpMAKsCNCgbAVrPjxGRtSVQ65IMBfdlFqi0OFiIXwYE/jevF3I
         OdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905968; x=1785510768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L0vVPoas2sjx1vMsJ+n0Wy1u4ubbi9EINDgHVQ2L70Y=;
        b=LTfi/4ANTzh2P2pzvp1/YmLLFCy51gwMTxyBJSxIJcTfA117NUosSRnPRcPrbJW+QQ
         iIIEL5UXZnS1DErs9NXBIAdPl2KG4W93SdPNsVDX2WJU89lL7fGDeG0WOozzlAe9bBmy
         oT4h8qZ6GE54x7f4yLYXv98YCg1kp4aWeqkKi5NUZwNLKW9QmoSmIvVX5ewWQJhXA686
         JSbDfJRMKRnEIUQvxjqofQKiE51xHpu4inpS6j/iRHGFPfyMxwZqat2dd8PjviYBcuwc
         hK2LRC3/Ui+81Sb5qVv8nTh0U6omOcDZk97v6YJFJGjynylegk6oyUajYceY7+Oxw2vK
         l2Ow==
X-Forwarded-Encrypted: i=1; AHgh+RrH6E5rFaUbByrrSYWAV006NiTP1gWTUu8tutEA9MGaGFV2B5LVgsSE6iM+NY9tViBifK/UtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhNQbEe8CHWe0zZjHEd2aW/jCe79KDoZN5J+1EqhH1LRa7Lgv3
	/VWS4wbO2Hq1g5MpWTctB3lt79ET7c0C2arORb3qkju8G/tUPBnSXGRbBpLFxfXNIQioaJTQFj4
	+4hROhF9LAAjQn3AsilzKV4f3PtKYBVhVqwdpeKSmmzL8FSl7oj1LZCFgXQ==
X-Gm-Gg: AR+sD10E6R6NZhDzPZFG/jqSEBqHpRcDp1cjMBK7lFxBoytjiiQLd3G1sniLxKUBvkH
	/922vKqofyUL8qU/oGADX0idK0BKvZ0WoEl28fTcwa9djTplG0kWHKdyo3/0XoKJy6HqXQkVg9L
	n4IeO/r3trIrigMHkyJRwGiKBdtQTw9LR5OhYEXdFR7z3cOPyalk4xhX10qFpRXbg6YnUPk1sN3
	dbK0FEpu2QL/Gu4qqmFoCgnB1MAiZXNPFgfH80lShbkBmFHgxkTGzGcEzgyasl8gTjsRDzR+CF1
	aKl4RjtiYPGAtUr96DUZOCK47LUJWXfDoJu3NlXQ5XdSUzXMHbU2yk7h3R4Bu15waLSVMB0AWMX
	huR84tiGkRdsUf3sieClXC5rMDzuHrTuAVtU8
X-Received: by 2002:ac8:5cd0:0:b0:51b:fcbc:84c6 with SMTP id d75a77b69052e-5283df9a8ffmr76108741cf.71.1784905967779;
        Fri, 24 Jul 2026 08:12:47 -0700 (PDT)
X-Received: by 2002:ac8:5cd0:0:b0:51b:fcbc:84c6 with SMTP id d75a77b69052e-5283df9a8ffmr76108301cf.71.1784905967312;
        Fri, 24 Jul 2026 08:12:47 -0700 (PDT)
Received: from localhost (ip-86-49-247-5.bb.vodafone.cz. [86.49.247.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32eb8036sm351216966b.45.2026.07.24.08.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:12:46 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v2 12/14] iommu/riscv: Implement irq_compose_msi_msg for IMSIC remapping
Date: Fri, 24 Jul 2026 17:12:16 +0200
Message-ID: <20260724151218.965929-13-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724151218.965929-1-andrew.jones@oss.qualcomm.com>
References: <20260724151218.965929-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX6oQYFfv8YN+/
 56LRt8kkxKQFemtJhFIkk7zKbuHBUX2h3WIVJagsFlJliTuYib7TRsuJ8BtTOvgQTsHPmnuRbKK
 T7tIS2j+wKQ4NuCXlwCf4ynINqJtmKpQ5/U0Zn4YvYLg7BEAFdAykot/cA/aIU8Xv1U/8li9z8k
 FeQu+87QBjsFBzj56daaBVoBUqHMKWZFUD/VqanlYRbKLzIuFkHeimqT3NCHNiPb+jkuD7n4/7J
 UUpOewWCPhbDFDrxcNJQCBg+dAsE3Aa20cZX6EZD2IsNRjWR7lJI9g4jSSwbmmhmpy8P4ugiMD5
 9TwludyBTQwf0gIAC8jSjXHAHjgJ8v6DKxfJq5FvdAGKO1rZSLjpV/MbG+R+7OqhphWsKDSBSX4
 2lML3CHSYqVhJjpstIiKgdxgvNOG5dhbdAoTQF68pWEtEKz6qAuiyK9vrBG1+Bh4paGpZgfoscm
 gdInOYFWT8dE7wtOeBg==
X-Authority-Analysis: v=2.4 cv=RJeD2Yi+ c=1 sm=1 tr=0 ts=6a6380f0 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=aYZ+cQcEYoLAp2L633VOig==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=wDfzXBFmrApTGnkBQMcA:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: NdFEwLtu2U5znEt-XecB5WSfPvxL2ZrJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfXw/l0HbNQxLDk
 BuSkPyIQPIv+TmU681mGziz+lr03jNQdjGbiaSg/1+PO0fqDxGXlsLwnrqlZCdVIypomYys/HQW
 TKs3MW984M74m0zc9fq5swYLbHETe5I=
X-Proofpoint-GUID: NdFEwLtu2U5znEt-XecB5WSfPvxL2ZrJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240137

Wire up irq_compose_msi_msg() on the IOMMU-IR irq chip to look up the
pre-mapped IOVA for the target IMSIC page and rewrite the composed
message to use it, redirecting MSI writes through the IOMMU instead
of landing at the raw IMSIC physical address.

The lookup is O(1), since the "extract" function used to build the
table's index is also used here, which is necessary since the number
of IMSICs may eventually be in the hundreds and irq_compose_msi_msg()
may run in atomic context.

domain->msi_iova is read here without domain->mutex, since compose can
run in atomic context, and RCU only protects info->domain itself. Pair
smp_store_release()/smp_load_acquire() on domain->msi_iova to ensure
it's observably filled before publishing its pointer. That guarantees
a non-NULL domain->msi_iova observed here is safe to use.

The WARN_ON_ONCE(!msi_iova) is defensive: a live paging domain should
not reach compose without a populated table.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu-ir.c | 50 +++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index bb1bc4c2bcec..eb2b7953055e 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -91,7 +91,9 @@ static int riscv_iommu_ir_build_msi_iova(struct riscv_iommu_domain *domain, stru
 			goto err_free;
 	}
 
-	domain->msi_iova = msi_iova;
+	/* Pair with the smp_load_acquire() in riscv_iommu_ir_compose_msi_msg() */
+	smp_store_release(&domain->msi_iova, msi_iova);
+
 	return 0;
 
 err_free:
@@ -99,12 +101,50 @@ static int riscv_iommu_ir_build_msi_iova(struct riscv_iommu_domain *domain, stru
 	return ret;
 }
 
+static void riscv_iommu_ir_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct riscv_iommu_info *info = data->domain->host_data;
+	struct riscv_iommu_domain *domain;
+	dma_addr_t *msi_iova;
+	struct msi_desc *desc;
+	phys_addr_t pa;
+	size_t idx;
+
+	BUG_ON(irq_chip_compose_msi_msg(data->parent_data, msg));
+
+	desc = irq_data_get_msi_desc(data);
+	if (WARN_ON_ONCE(!desc))
+		return;
+
+	guard(rcu)();
+
+	domain = rcu_dereference(info->domain);
+	if (!domain) {
+		msi_desc_set_iommu_msi_iova(desc, 0, 0);
+		return;
+	}
+
+	/* Pair with the smp_store_release() in riscv_iommu_ir_build_msi_iova() */
+	msi_iova = smp_load_acquire(&domain->msi_iova);
+	if (WARN_ON_ONCE(!msi_iova)) {
+		msi_desc_set_iommu_msi_iova(desc, 0, 0);
+		return;
+	}
+
+	pa = ((u64)msg->address_hi << 32) | msg->address_lo;
+	idx = riscv_iommu_ir_msi_iova_idx(pa);
+
+	msi_desc_set_iommu_msi_iova(desc, msi_iova[idx], IMSIC_MMIO_PAGE_SHIFT);
+	msi_msg_set_addr(desc, msg, pa);
+}
+
 static struct irq_chip riscv_iommu_ir_irq_chip = {
 	.name			= "IOMMU-IR",
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_mask		= irq_chip_mask_parent,
 	.irq_unmask		= irq_chip_unmask_parent,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_compose_msi_msg	= riscv_iommu_ir_compose_msi_msg,
 };
 
 static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
@@ -240,10 +280,12 @@ int riscv_iommu_ir_attach_paging_domain(struct iommu_domain *iommu_domain, struc
 
 	guard(mutex)(&domain->mutex);
 
-	if (domain->msi_iova)
+	if (domain->msi_iova) {
 		kfree(msi_iova);
-	else
-		domain->msi_iova = msi_iova;
+	} else {
+		/* Pair with the smp_load_acquire() in riscv_iommu_ir_compose_msi_msg() */
+		smp_store_release(&domain->msi_iova, msi_iova);
+	}
 
 	return 0;
 }
-- 
2.43.0

