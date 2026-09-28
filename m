Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD45E4DF4B9
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606313; cv=none; b=JYbisNh+3syH+IzthRq8n1eq/UmEMp3DHUAXbL9MY8ym9AyEfABbdhuZWqnYXLygxLkd7NQacHPIxkgkNgEJkthrw5d5zFJnxdOkeN2ZrTieTdMSrCvB8haRRSx/QDQADOnkUgQukrRe8W7qOHbgpylS886gxbrUFITOQEz3AOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606313; c=relaxed/simple;
	bh=YQoFb3ZkuKXV4i+LpNA+Q+uq0lwXN/olc8Rf9LCRXSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPJDEI+5oHXH7TDwHjSAR4z9u7eIHkC8bvctxowZAD2yza1Nens+V9SPgArNDU+aQTdTqmOAxl1Xqw0sE1/EikSZFOQKLfgbJzMNoOBfPQkYDkAMMVZDd87agMKxYOe7lBJR7EE+h2YLTE0Gr4bPOjFjb9C+aSRhLJ+qBatQapY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HIr3XliJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CFdCiP2L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HIr3XliJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CFdCiP2L"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAWoV558791
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=S7rnZZ0yovP
	SLbhPLQejN/m5WeyZsVkheepx4ZP4TkI=; b=HIr3XliJnfCJm0Mtc1BQqxH67pA
	Kth9aTJwGBFN9iO46A+puwz/haBzE2mHfG6X3eKpuwOvb4EVH/SsFM/PH8Ze6ESo
	V/LjHaOQfJUq4yH4cc7Zt7scQOogYZ6jy6hxUFMnxbkd2xxGg1cSS2RRw4Lh9o6W
	NSWw+RguNw9FrnoiqT7Xim3hR2/sDH9uGyiwvHldGyapB1gFu+LFGIIwob377uhu
	za9FfYrEaw5neMw/MvXCLR58qhlbSPZTds8fYHL5OQCgj0wTZUWOL7F4RPtWt8mm
	aJ9pfsVp7pEUf8I2RFafODuOnzxYaHLvna6tlEwgb/yj12PzVbeadQQtgUg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyebq2kxh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:38:20 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53323d5b9ffso31619851cf.2
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790606300; x=1791211100; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S7rnZZ0yovPSLbhPLQejN/m5WeyZsVkheepx4ZP4TkI=;
        b=CFdCiP2L3kVLx8B/wgjZ9U45bttKfZdM1d2Jv2VhIbOI5LT6LLTCW2Rvrhc08ipeqK
         YThyTFbCJXRo9gHkgXwreUwbx3YxDkYeO37MwpkTdnZkAmckwrJLal6EMmFjWiCn1oBG
         aYBTCwFkiZ76ugcIbTRyi4S4LRe5SV+Kf+MWJykzd0bklq+8C4D/v3Cvf8ZQ9gycacOZ
         MJ9E3SZsqb0816/ywmMdbABt7WXoADafNN15QOFRhrp8weDlJLFmFWeObMudTaADIWkk
         LLh5b6iST1zxY37W+dydfiQebNFUH1kM2NQcINrq8IuOaQIiEdW/ziOHniU4FXlrgr7z
         Te8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790606300; x=1791211100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S7rnZZ0yovPSLbhPLQejN/m5WeyZsVkheepx4ZP4TkI=;
        b=G1R0LjJHISC6PTjqNgHAZ79UWv6PP2XfoOYt8msnyZDR+GGMmytsof8FaNIx+A5rSd
         2BZE3UJZls4hKvo3MhTTks9DG9RAP3QARh7nJKZNrYY9VhHSyWIO6o1ZMeEg93BlalS1
         ILzzupcYlDzsiNKW4Y7CB1SzTr1kTn2DvPLvPhqc0q5ap6IqC5hSUXscE/7ajt7nv/E3
         6gv5faEmLSvNiaINHksi/eDBDQlnV47ApqOH0Oq31Hz7DlxfTDlq6I213cBhy680iMfv
         tUISSlLJgp9ohizF0CpUVhRro91u7mdILA7e0oHhC1LFfE0r0T1/o5FX7UlXx6LjT277
         He0g==
X-Gm-Message-State: AFuF++mHWS1d4Ef0qmz4DFKp3gq6jeVwfnAtkVt1iGwfk57zmPcQLeCb
	lWgrOc1qG3vRzL5EKO8UfXY4+QzPNIpX5liSNL1+i0TR0vDJnESwl3Cqn8puXm+MWZ8c0qp7oHk
	o8K30Pw0sf+tG1JFb1JHWQmPVsk12LWaIeHMco1C6YKF5MZcuHyFaOQwEV6WNNA7zCA==
X-Gm-Gg: AYBFou2rcd3SGP205c2LY0amoOvAFQS3dr7RmGSBSPH6eWZ3iUOeUcHH5uSQjooCZTW
	9638DHMlJvCUxPaNOzEK9d7qwbLhntGAMu0C2LWIFODFgQv2Z7JKNTuG/6tlRlMy2RHW9lcAryk
	howz/9npE/08yWy1+c0+EKbcmSzDP++cmGI+tdSStYG65lemV1v4Xu1qQF3AgNFI9j2nYnnKh9V
	p8sGAfGgmwTWyDgWTeJOf7d/rr3G4cdglmMKGpoVaCWp7w3mAC2cYBu0F7k5g/ZpTxazWvUkANw
	3PKUzLQoMo+MOfq66ANky5WTb75w64AblyJ0NYsCPvU5PS3VjZNvpDScKQZemQmJypTktUjlt+z
	cMWKMT6fJPAh9a6Jo14fMuZkj9gDLYoU3HlwHhg==
X-Received: by 2002:a05:620a:3713:b0:939:ff11:5338 with SMTP id af79cd13be357-93c43e0ea52mr2185208785a.40.1790606298653;
        Mon, 28 Sep 2026 07:38:18 -0700 (PDT)
X-Received: by 2002:a05:6102:3ec5:b0:7a7:198a:c2bd with SMTP id ada2fe7eead31-7af1e2f54d4mr5353036137.37.1790605943161;
        Mon, 28 Sep 2026 07:32:23 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae7358f29sm476948066b.20.2026.09.28.07.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:32:22 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 14/14] iommu/riscv: Implement IRQ forwarding
Date: Mon, 28 Sep 2026 16:31:13 +0200
Message-ID: <20260928143113.49838-15-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: X6bVRANaSnT4Ud2vKc6w6RjTDmF4L95N
X-Proofpoint-GUID: X6bVRANaSnT4Ud2vKc6w6RjTDmF4L95N
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfX79X1mvoLYgRi
 TVHzmfhP7K3fNCtSvVi5/BEz93izAgzdX+Iv7TvOYi8p+gC0/9PLp3KuakzGsid1tRMnFbIwauD
 nYvMl5/PLTkJnXw5ppgiONCJHQaAJ50=
X-Authority-Analysis: v=2.4 cv=EqRHPicA c=1 sm=1 tr=0 ts=6aba7bdd cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=_LgjKRu_PPdaeAXRpTIA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfXzHj22Ec1+ZUK
 sYb6+gn2DZGlGjL4NJA0lcP7HzWPjG9HHR+skk+PHmc+l1m/9+j0Q0Z2YF/Ys3Ziw8yDLHbk26q
 rpCDZlafKrZYKX/zqzaEtpOCNAAypV1iAbqmuWGWkukSlRNBccx/Hrvex/Gxqt3iVSn/VfFjkev
 JDfZPKZKc2Je1S4bAEUL7kgEgca+CPW5PVyM8j0OwkKYQktXgvI/cD8Dyawa+mT47trz99UcuSs
 JWrJWmATcBrJuBNITXOcLkSJ85XZIM4Tu/DI9tZEoQRiLakaZexcMbyIVu77yAd4qf3lJ+2kyzs
 7pv/TPdmvb+TuHpfxNGI+kr6iwvz6cz0J2equKQcayet3xKJVBr8G4d1YGKJlEbmevPG3zApkJQ
 Rglf9+gxU21FJp8P/MeFVh2Gg3Rnb/kylhnp/c4Q2sGzqCJC/rEt8uQBJ6DacdUo8jRBsKkzRtc
 vhLZPWdMi3t2B+DH1JQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280058

Like DMA translation tables, MSI remapping tables are owned by the IOMMU
domain. A single table therefore governs every device attached to the
guest domain, which also requires those devices to share the same guest
interrupt-file address layout. The table must become visible before the
first IRQ is forwarded and remain active until the last forwarded IRQ
returns to host delivery.

Populate and publish the table on that first transition, and remove it
on the last. Keep domain-wide and per-device forwarding counts so domain
attachment can preserve the table lifetime without unnecessarily
blocking unrelated devices in the same IOMMU group.

A vCPU migration may also change a live target without changing the
forwarding state. Update MSI PTEs with the ordering required when moving
between basic and MRIF modes, including break-before-make when both live
MRIF words must change.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu-bits.h |  27 ++++++++
 drivers/iommu/riscv/iommu-ir.c   | 114 ++++++++++++++++++++++++++++---
 2 files changed, 131 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
index 65d1f2250011..51a2e660b06a 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -702,6 +702,8 @@ struct riscv_iommu_msipte {
 /* Fields on pte */
 #define RISCV_IOMMU_MSIPTE_V		BIT_ULL(0)
 #define RISCV_IOMMU_MSIPTE_M		GENMASK_ULL(2, 1)
+#define RISCV_IOMMU_MSIPTE_M_MRIF	1
+#define RISCV_IOMMU_MSIPTE_M_BASIC	3
 #define RISCV_IOMMU_MSIPTE_MRIF_ADDR	GENMASK_ULL(53, 7)	/* When M == 1 (MRIF mode) */
 #define RISCV_IOMMU_MSIPTE_PPN		RISCV_IOMMU_PPN_FIELD	/* When M == 3 (basic mode) */
 #define RISCV_IOMMU_MSIPTE_C		BIT_ULL(63)
@@ -711,6 +713,31 @@ struct riscv_iommu_msipte {
 #define RISCV_IOMMU_MSIPTE_MRIF_NPPN	RISCV_IOMMU_PPN_FIELD
 #define RISCV_IOMMU_MSIPTE_MRIF_NID_MSB	BIT_ULL(60)
 
+static inline void riscv_iommu_msipte_set_basic(struct riscv_iommu_msipte *msipte, u64 addr)
+{
+	msipte->pte = FIELD_PREP(RISCV_IOMMU_MSIPTE_M, RISCV_IOMMU_MSIPTE_M_BASIC) |
+		      FIELD_PREP(RISCV_IOMMU_MSIPTE_PPN, addr >> 12) |
+		      RISCV_IOMMU_MSIPTE_V;
+	msipte->mrif_info = 0;
+}
+
+static inline void riscv_iommu_msipte_set_mrif(struct riscv_iommu_msipte *msipte,
+					       u64 mrif_addr, u64 notice_addr, u32 notice_id)
+{
+	msipte->pte = FIELD_PREP(RISCV_IOMMU_MSIPTE_M, RISCV_IOMMU_MSIPTE_M_MRIF) |
+		      FIELD_PREP(RISCV_IOMMU_MSIPTE_MRIF_ADDR, mrif_addr >> 9) |
+		      RISCV_IOMMU_MSIPTE_V;
+	msipte->mrif_info = FIELD_PREP(RISCV_IOMMU_MSIPTE_MRIF_NPPN, notice_addr >> 12) |
+			    FIELD_PREP(RISCV_IOMMU_MSIPTE_MRIF_NID, notice_id) |
+			    FIELD_PREP(RISCV_IOMMU_MSIPTE_MRIF_NID_MSB, notice_id >> 10);
+}
+
+static inline void riscv_iommu_msipte_clear(struct riscv_iommu_msipte *msipte)
+{
+	msipte->pte = 0;
+	msipte->mrif_info = 0;
+}
+
 /* Helper functions: command structure builders. */
 
 static inline void riscv_iommu_cmd_inval_vma(struct riscv_iommu_command *cmd)
diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index 12a5d0bc77f2..b3f0a56475ed 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -93,6 +93,17 @@ static int riscv_iommu_ir_validate_targets(const struct riscv_iommu_ir_vcpu_info
 	return 0;
 }
 
+static void riscv_iommu_ir_set_target(struct riscv_iommu_msipte *msipte,
+				      const struct riscv_iommu_ir_target *target)
+{
+	if (target->type == RISCV_IOMMU_IR_TARGET_IMSIC) {
+		riscv_iommu_msipte_set_basic(msipte, target->hpa);
+	} else {
+		riscv_iommu_msipte_set_mrif(msipte, target->mrif_hpa,
+					    target->notice_hpa, target->notice_id);
+	}
+}
+
 static int riscv_iommu_ir_activate(struct riscv_iommu_msi_table *msi_table,
 				   struct riscv_iommu_device *iommu,
 				   struct riscv_iommu_ir_vcpu_info *vcpu_info)
@@ -134,19 +145,101 @@ static int riscv_iommu_ir_activate(struct riscv_iommu_msi_table *msi_table,
 		return -EOPNOTSUPP;
 	}
 
-	return -EOPNOTSUPP;
+	for (unsigned int i = 0; i < vcpu_info->nr_targets; i++) {
+		const struct riscv_iommu_ir_target *target = &vcpu_info->targets[i];
+		size_t idx = riscv_iommu_ir_extract(target->gpa >> IMSIC_MMIO_PAGE_SHIFT,
+						    vcpu_info->msi_addr_mask);
+		struct riscv_iommu_msipte *msipte = &msi_table->root[idx];
+
+		/* A populated entry in the initially clear table indicates duplicate targets. */
+		if (msipte->pte || msipte->mrif_info) {
+			memset(msi_table->root, 0, array_size(nr_ptes, sizeof(*msi_table->root)));
+			return -EINVAL;
+		}
+
+		riscv_iommu_ir_set_target(msipte, target);
+	}
+
+	msi_table->required_caps = required_caps;
+	msi_table->owner = vcpu_info->owner;
+	msi_table->msi_addr_mask = vcpu_info->msi_addr_mask;
+	msi_table->msi_addr_pattern = vcpu_info->msi_addr_pattern;
+
+	riscv_iommu_msi_table_inval_all(msi_table);
+	riscv_iommu_msi_table_update(msi_table, true);
+
+	return 0;
 }
 
 static int riscv_iommu_ir_deactivate(struct riscv_iommu_msi_table *msi_table)
 {
-	return -EOPNOTSUPP;
+	riscv_iommu_msi_table_update(msi_table, false);
+
+	memset(msi_table->root, 0, array_size(msi_table->nr_ptes, sizeof(*msi_table->root)));
+	msi_table->required_caps = 0;
+	msi_table->owner = NULL;
+	msi_table->msi_addr_mask = 0;
+	msi_table->msi_addr_pattern = 0;
+
+	return 0;
+}
+
+static void riscv_iommu_ir_update_msipte(struct riscv_iommu_msi_table *msi_table,
+					 struct riscv_iommu_msipte *msipte,
+					 const struct riscv_iommu_ir_target *target)
+{
+	u64 pte = READ_ONCE(msipte->pte);
+	u64 mrif_info = READ_ONCE(msipte->mrif_info);
+	bool old_mrif = FIELD_GET(RISCV_IOMMU_MSIPTE_M, pte) == RISCV_IOMMU_MSIPTE_M_MRIF;
+	bool new_mrif = target->type == RISCV_IOMMU_IR_TARGET_MRIF;
+	struct riscv_iommu_msipte new = { 0 };
+
+	riscv_iommu_ir_set_target(&new, target);
+
+	if (pte == new.pte && mrif_info == new.mrif_info)
+		return;
+
+	if (!old_mrif && new_mrif) {
+		/* Basic mode ignores mrif_info, so prepare it before switching modes. */
+		WRITE_ONCE(msipte->mrif_info, new.mrif_info);
+		dma_wmb();
+		WRITE_ONCE(msipte->pte, new.pte);
+	} else if (old_mrif && !new_mrif) {
+		/* Basic mode ignores mrif_info, so switch modes before clearing it. */
+		WRITE_ONCE(msipte->pte, new.pte);
+		dma_wmb();
+		riscv_iommu_msi_table_inval(msi_table, target->gpa);
+		WRITE_ONCE(msipte->mrif_info, 0);
+		return;
+	} else if (pte == new.pte) {
+		WRITE_ONCE(msipte->mrif_info, new.mrif_info);
+	} else if (mrif_info == new.mrif_info) {
+		WRITE_ONCE(msipte->pte, new.pte);
+	} else {
+		/*
+		 * Both words are active in MRIF mode, so use break-before-make.
+		 * The UPDATE_TARGET contract requires producers to be quiesced.
+		 */
+		WRITE_ONCE(msipte->pte, 0);
+		dma_wmb();
+		riscv_iommu_msi_table_inval(msi_table, target->gpa);
+		WRITE_ONCE(msipte->mrif_info, new.mrif_info);
+		dma_wmb();
+		WRITE_ONCE(msipte->pte, new.pte);
+		return;
+	}
+
+	dma_wmb();
+	riscv_iommu_msi_table_inval(msi_table, target->gpa);
 }
 
 static int riscv_iommu_ir_update_target(struct riscv_iommu_msi_table *msi_table,
 					struct riscv_iommu_ir_vcpu_info *vcpu_info)
 {
 	const struct riscv_iommu_ir_target *target = &vcpu_info->target;
+	struct riscv_iommu_msipte *msipte;
 	u64 required_caps = 0;
+	size_t idx;
 	int ret;
 
 	ret = riscv_iommu_ir_validate_target(vcpu_info, target, &required_caps);
@@ -157,7 +250,15 @@ static int riscv_iommu_ir_update_target(struct riscv_iommu_msi_table *msi_table,
 	if (!riscv_iommu_msi_table_check_caps(msi_table, required_caps))
 		return -EOPNOTSUPP;
 
-	return -EOPNOTSUPP;
+	idx = riscv_iommu_ir_extract(target->gpa >> IMSIC_MMIO_PAGE_SHIFT,
+				     msi_table->msi_addr_mask);
+	msipte = &msi_table->root[idx];
+	if (!(READ_ONCE(msipte->pte) & RISCV_IOMMU_MSIPTE_V))
+		return -EINVAL;
+
+	riscv_iommu_ir_update_msipte(msi_table, msipte, target);
+	msi_table->required_caps = required_caps;
+	return 0;
 }
 
 static int riscv_iommu_ir_irq_set_vcpu_affinity_locked(struct irq_data *data,
@@ -182,13 +283,6 @@ static int riscv_iommu_ir_irq_set_vcpu_affinity_locked(struct irq_data *data,
 		info->nr_forwarded_irqs--;
 		irqd_clr_forwarded_to_vcpu(data);
 
-		if (!msi_table->nr_forwarded_irqs) {
-			msi_table->required_caps = 0;
-			msi_table->owner = NULL;
-			msi_table->msi_addr_mask = 0;
-			msi_table->msi_addr_pattern = 0;
-		}
-
 		return 0;
 	}
 
-- 
2.43.0

