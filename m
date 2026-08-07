Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC9E379991
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126668; cv=none; b=XVFyYZO84/gGPKA6g81oo79wgPSU9Pwed/vpRdCZhkxurr0biduJMDbGmZfkuPE0M781K2yUGaqVBjpk8ZI9TVNr+xkshPVYIGztsLDaH93KwHMH2wV7Sjjwi015qcjhQEWubcz1PSr0QhKCOwlkTrALzi6zvyQy23bvp+8jfZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126668; c=relaxed/simple;
	bh=ynx70m11ovVGxbG/L6NDlW27pqI2flR4wiUs3zbBV2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqO8w0dTRKyVESISjv6S6ohZiubCTBOswKU4WiVuW74WjjWh+DedI35+Zo4WCwqN76aP4bw3MTW/fPmer2SOhwWZUPolcSqDA2TpTnDIHAkvnDUfs8wWJgmIE7pu72PS2GRQqgXzF8wsKy2ZfKZlyrvB4qzBMTzXKyfmt9B6Sxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nJRbChcE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P41ea2+x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nJRbChcE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P41ea2+x"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GO5l11149639
	for <iommu@lists.linux.dev>; Fri, 7 Aug 2026 18:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ACxCicvvxB0
	MpVhxvmmDcRleLgdrlgEwy/npKeaMKFw=; b=nJRbChcE2ebiNrz6hnEcTGiBpRd
	DMaDxnwuNfCAOBADQn6GC5QlO5mhnPXrhNSmkLQD3cwssHzVVlUonihO13Eqs/pb
	+rAtxi936cg1f4/hZvh1cP0tkaCSKh4B7UErAbJBDK66oqUGmN6LfWk2z8gJvrkg
	ZgX5lQhpqHOvt2D9gmMgUQakYkOqStvOTM+kk1BSLYjGk/lTQzkqk6s6isihfBtj
	G/h/fWCrQgGOHusgn4FxPBm5N5iDdwPMITYC1XQtGVAnk3FsV3PCLOZwtnIrOKa+
	4Y45gMLR3WLDnqLKDC/yzXT3f0t7s7RnKvdWxS8XWl9WrQRjrPgUgv6XHFg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwhk3gwqk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 18:17:45 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8f1e4e0eac1so26353266d6.1
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786126665; x=1786731465; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ACxCicvvxB0MpVhxvmmDcRleLgdrlgEwy/npKeaMKFw=;
        b=P41ea2+x184bqPmUFHFl14T6wXbg3X0hb/oPwRf0/7G3aXXzXHyFsFZhpTGQ3+OlKf
         OtOERz+qgkXnxj1B0dbHU3FZ8HtkT9yFtISPlyu6hwduKOPA4u4JaAArspLjwdzX7G/w
         U0WcEtlGj5HXt+8YnILR5UZzunhrpxGawcW0unWOvZwmQKvUr1FEMQJplYg1t1nAefe4
         jeI9dxDWn17cQIQdB7kbB/OHRbRRRtP3EBjUB7j/m/nQZDfIXy/FwYWuJvizfRM5q30S
         jccmxOYH7MW1MwxQA1YZvVTlTNKDfqVJsrDvGhnNl1HJeNiPADf1S4e9PrxXoUN1u12h
         NCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126665; x=1786731465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ACxCicvvxB0MpVhxvmmDcRleLgdrlgEwy/npKeaMKFw=;
        b=a4RVism2KTC5xF+f6YN1622bUKuTYBYu5SQ46amSqnt8RbDSOl6JQFm8Ua1dm/GW1m
         GiT8gvHtZTUAg7YYTraR/CNfpv2R4jyslN8M+jd5HDBULdzV/1v2xDCqftt5Ay4PP9n3
         RVTTTPLsx77YB0t+/Sjvg+x1QuauMcw9Or71oRaiNTazvhkp00qwKxSti7qzUMXywlfr
         KXz+Ta3HShXNfpwr6Rrs7qYlbNCkI7xdTU+FRviVsIye97ProyqLOPFWD8FwCbo0VAMg
         Yh0x8f0z5yB50CjGsdoIKFwwXWm/TsY7sIQjgoCWbyricORiiGvbkNyF4znyXawC+Q0q
         a8ag==
X-Forwarded-Encrypted: i=1; AHgh+RpEDW9D8kP8hkIctmOAlhfuKZt3tMlwNrNwz/nX3Ppw8bowN60lQo4XSFrIGgIyj0qbOLfeiw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyT2umwW3kG4nV457rotzzcuPP5z3+FY548IKRr1mn6eGURDUd+
	07VvpEdngSotpeAvDkB5tv8XxOJJpQwigvmegKVeTjkltWzRRW8anCLIAPAtChQkJPriYY1TXgX
	FteRq0p71jrk7q/W+kgzJ+2QPDpd7ACt2vDmhg05BA607N4Ry3+SaRwQgUQ==
X-Gm-Gg: AR+sD13NqH6Y3Y6KeOKOAwcPKLg5urWHkjNy5NtSOPF7yA099k4lwPLi2FpXaF0l2lt
	XKSsAyfzslGrqh0x4Zyermlyjhf7GOhitv79qjUrZpXYYHyuqxBYKg4rNF2K6top6gJN1mmKKoc
	CMaV6r5D4JpKMJbITHeBdp3IgaKE0UWCI/A/YbnlG8jqhbrOTBQ4GjIaKB2nnVfReHSBJLwBmND
	DWnAGuAX8krwuuFUNPt/OAUGDCtK6MVARyKdaybQ1r9HYcWIfCK4SeHEYCnYttQ6ANn/brqbEWy
	+GikuUV30z/Oen3bi02pTaOOIixUKbYDTJUDMP9HuMnz0BgQGp5rVaapZiIT/QKcoMt/FCnWVAc
	748Ri+L4ubpgAcXQPgQfOZcVIGbtXa4kN6o1EVxo=
X-Received: by 2002:a05:622a:228d:b0:516:d699:a99b with SMTP id d75a77b69052e-52ce61f545cmr276789001cf.40.1786126664720;
        Fri, 07 Aug 2026 11:17:44 -0700 (PDT)
X-Received: by 2002:a05:622a:228d:b0:516:d699:a99b with SMTP id d75a77b69052e-52ce61f545cmr276788231cf.40.1786126664267;
        Fri, 07 Aug 2026 11:17:44 -0700 (PDT)
Received: from localhost (ip-86-49-241-13.bb.vodafone.cz. [86.49.241.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1e7d7648dsm828651a12.30.2026.08.07.11.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:17:42 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v3 13/19] iommu/riscv: Implement irq_compose_msi_msg for IMSIC remapping
Date: Fri,  7 Aug 2026 20:17:07 +0200
Message-ID: <20260807181713.228535-14-andrew.jones@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=RKaD2Yi+ c=1 sm=1 tr=0 ts=6a762149 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=VPysOpcHbS0DNrM1Xqmyow==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=wDfzXBFmrApTGnkBQMcA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX7vEtdlBXMpx9
 bQd8ryxt3jzr4dwkoGlrJVH9Efe16Gro6cZY5p2+ytYvFGMtrPGVWxG8+iATq6uAAVAT6rWbnmu
 HxSoouBYkp34rwEmpoJMnGXKe36U9L0=
X-Proofpoint-ORIG-GUID: 5LcOTJfnnDi7z7kqLmDypW_nqh4caLyL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX57eTCsz+Fd6O
 ZNC+uCdA3IvzOkyFpeaB1gFNffWtLVB6OUZoR+lVK4ftMdDGzgcLjLkyJo3GlfcNRrsEL1m8nQC
 /ks4/wKhVCqvf92fEH4IVLGDjzRCbM7iq+hwN7jt6hS4BfFz2SbyhKorWLevf9b+uUJ1SMWchLh
 ZzIvz9OU7lJ1eTebmM2ab33v4sXElGLmbPYrbWPJdVcmlwzfmJesfFfih0M/GnUV4Bcs+l8eg5l
 gW8bkxI4N01SUvbUsCaPJCMO/ofrLJL4fxX4gZ+ibSeDiZffjjJ+xEyO66qrEP7T6TBjwXPxG7o
 x/FDi8sdwXTCMgbIBzlzgvKGjmqjNkjpnj1KQ3AZ2J26WrMAZBqKTCInjUHzmPtAKe5+Np0hmlb
 wTrxo6d2XQKvR9yL7C0SUAZp21dve/n8HebmezG+Jzfg2KXPbvD9DC4tDvphpkH1vQ7W3rXkH6F
 pBH87xQkpWQFMtphg3w==
X-Proofpoint-GUID: 5LcOTJfnnDi7z7kqLmDypW_nqh4caLyL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070143

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

A NULL domain->msi_iova falls back to the raw IMSIC physical address,
same as when info->domain itself is NULL, since a live paging domain
should not normally reach compose without a populated table.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu-ir.c | 49 +++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index 7d9a1eaca92e..98be3e3fddad 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -91,17 +91,56 @@ static int riscv_iommu_ir_build_msi_iova(struct riscv_iommu_domain *domain, stru
 			return ret;
 	}
 
-	domain->msi_iova = no_free_ptr(msi_iova);
+	/* Pair with smp_load_acquire() in riscv_iommu_ir_compose_msi_msg() */
+	smp_store_release(&domain->msi_iova, no_free_ptr(msi_iova));
 
 	return 0;
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
+	/* Pair with smp_store_release() in riscv_iommu_ir_build_msi_iova() */
+	msi_iova = smp_load_acquire(&domain->msi_iova);
+	if (!msi_iova) {
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
@@ -267,10 +306,12 @@ int riscv_iommu_ir_attach_paging_domain(struct iommu_domain *iommu_domain, struc
 		if (msi_iova) {
 			guard(mutex)(&domain->mutex);
 
-			if (domain->msi_iova)
+			if (domain->msi_iova) {
 				kfree(msi_iova);
-			else
-				domain->msi_iova = msi_iova;
+			} else {
+				/* Pair with smp_load_acquire() in riscv_iommu_ir_compose_msi_msg() */
+				smp_store_release(&domain->msi_iova, msi_iova);
+			}
 
 			return 0;
 		}
-- 
2.43.0

