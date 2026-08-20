Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142D525F988
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262143; cv=none; b=EsnwLtY1HklRQx/Uzub6sSP2HD5FqkJGpw1NGrbTt+1T1IxqnaC2ZiMMOa4d38eD9Wj53dtU33GKlUL6m3WUxyQUb/6Ya4mkedPlNTD/MzrGLlR/EMPww3uuPfQoe4i0S6GZ50IaD6QK5oHfYlfivh8tlLLYxb9X3TvsKjByPE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262143; c=relaxed/simple;
	bh=pdDqYz5gHOGjS0WLVPlhSJT2jZ2ccCYf4ChpxWFacyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UO7iwrGcsTFRk9WIFKdrDqaVb+luYWWrirF00iWLzxr90UmQQio5rTn0PmFJur4d6BNbVEus0ftB7AR/fyWlQ2/DmD2yvluCzjtCDxil8oN1wgdWDqKCBCur2MDwP4LarMNm1mvT9CNYjlE2GsY4/AiodWa0y2tOBPe1DWpxGCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VV/7LDgq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TZ4pNQNL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VV/7LDgq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TZ4pNQNL"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK7Ypn250320
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=l96Vk10BuNm
	2ABSC8yUkNdbBntXx71mGS/943tRJnsU=; b=VV/7LDgq0z+aQ+m4d8sPRE48Fns
	1psooAGT5co1Gfr3ogtiZf2RC73SE95+IR7NVUldbHbCOI3c0+foclE0xWettZ75
	4oP9NKQezLpUea+6eBS/q1q6XAsZ9j7QJnakdTeQSHJnqGx5Sr6y0EeV/7bKd+OI
	JQrFSex4+VyrJWkSMjVvVdTsww9Xd6Pe5Ib3IukVr8oVSDK18B2Fhxn9kc2n42AC
	bfnIWwbT8yI5GWE0WxUkwvpC6V8IiS6FivgHXBSjQAgJ87zn08P79tfAHhYDcj6Q
	YgBNSsoLARjhQzkqW+0+vKWt1W/xu0R7936GBzue44En2bRhI6+H+HeHnrQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5w49bqqx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1d7886cdso5670091cf.1
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787262140; x=1787866940; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l96Vk10BuNm2ABSC8yUkNdbBntXx71mGS/943tRJnsU=;
        b=TZ4pNQNLZ7WevAL7FSLbomMRKcPma1/ZOyc3VXTq8THX7ciHviehrRJFDFKOzeVTar
         2ktfgt3+aF3EUcEUr5ETIyqsiYihKSHwe4GVZUe51XtnXP6ksDinatzk8ohTbZkmP7A6
         mtxO3Jf2kOMQr0+zaPgxB5CzNwf23NJxBuJOPnm1bliFAszbkvo3075YLjRu7LsWMpqf
         e1iLZirsxrICuCltj5BYfBdXu8U9LDto1b6YsFjoP+mkym6M9qHOJjTvXVoGNIvd4Udi
         OtBO33oUbfkZ+UVoiW0iyMUs4IPAD/FftdWinkHxA6wj0MZsYX0JPao/fbT3QnGBwJUM
         bUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262140; x=1787866940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l96Vk10BuNm2ABSC8yUkNdbBntXx71mGS/943tRJnsU=;
        b=r0rPDpxS0DFDDbQkLDjsYmzAntpC0f2TLoNIf+JyulZs+cQjwzMLB43VDTZ0MahBx3
         iXpvP/R4nGvpE5T8pRivJrZYviUuNzEEDisMGUFPvtjbq9vHTOW7aPgk2GnoijVEmrz+
         AQTWztrcj+KRkvPTGXooiMa++9I49ziPEgmC5vBpTIdRZSiNpv353OsP6vanTyY6Xous
         /86l0h3BG2UFVo0XaMACoRMfYZq24oKaC1c8Mfi9oABW7bOoJzROXdtTxHO+/ezSM4Qi
         FUA00wqDV6ZJHIknXWZuUyHVzcE9P2tysQqHfEdyeaIWtuB3FM39rGV+U/i9W/L2YZsE
         D/Ow==
X-Forwarded-Encrypted: i=1; AHgh+Rr83eLwbimYLF9eyvS4BE5EYcgXZGE2WQQFruPSPUz56y6QieWr+7t2TqrdaBWOZcjFVShhFg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3sAzge/swmz9QipVXJmv+4wntU/0bUCUG68gYSQLBvVcWKZTb
	wp6Pi8X73iLSoTPYhRfVlJYOvwjumrf+HfCbhjeiZbtWQ15PSKR/xYf34BWfizdtVGXeOWile5h
	+hoRKTa6Yq/pwgW0GCXtFN7OH4xtn09fpUShbIu9yWLUk1jPRo8uR1TAEIA==
X-Gm-Gg: AR+sD13EC3ySCQftsqXhlRLemZKV9uNUQ0CWMe/mct+c8kDUm7CXUnfPqeYNswtFIX8
	msp6CL6e7LfLm3N5o/f302hJIU1x466d2vP3vCf7bK+kiayyam5qZJYWNxNPtNImwIh25SrEbwK
	0p9ymbqrZPxNknnPhuHuz7w1g9tDQvqUtIjFfSrkeEs4WPRTBxPecMexa+fEs1YpbbRLoFgT4R6
	HHJQQKafs3rAKXVoko1OoTOJXfZfWPia2oemNeHKcEusZOH60st5Rpb/Z6c9wgzTi8uaLfUvkof
	e4OZMDTNaznjVrCkKLphsldMRLewqAsGFyPpjWwn3+p7l33k0UCMyBnNGpNpC0S6vNV00FjNRtm
	dze/pDxrP
X-Received: by 2002:a05:622a:111:b0:52d:6cf5:1c01 with SMTP id d75a77b69052e-52df5a73d25mr14681221cf.36.1787262140319;
        Thu, 20 Aug 2026 14:42:20 -0700 (PDT)
X-Received: by 2002:a05:622a:111:b0:52d:6cf5:1c01 with SMTP id d75a77b69052e-52df5a73d25mr14680831cf.36.1787262139865;
        Thu, 20 Aug 2026 14:42:19 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b90d6771sm6605765e9.1.2026.08.20.14.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:42:19 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v4 13/21] iommu/riscv: Preserve MSI IOVA state across domain replacement
Date: Thu, 20 Aug 2026 23:41:42 +0200
Message-ID: <20260820214150.545737-14-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX/JXQg8Tlip4w
 pCHp/cYSm5R3sskbpSedz8MGD23RnCAjCz4vdJ/wKNBQD8s4ACCAIH0xYiJi6hLnO8cwhTZ0rnd
 oVf9GvuinoGAXI6oakehDcPearEfFQw=
X-Authority-Analysis: v=2.4 cv=YP+vDxGx c=1 sm=1 tr=0 ts=6a8774bd cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=QTl87LO99xnYkKpNp58A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: VMqaEtblPeiqDY2Befh0NpJOdpoH6aAG
X-Proofpoint-GUID: VMqaEtblPeiqDY2Befh0NpJOdpoH6aAG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX13fiaSGkPHbs
 FpV2YVeDEZJhjxysOUZHyDO29mKgg+P0jHsYN3HQU+i/QhgXP/XAWbQ/op+GWGu24GkgaLxv86i
 mEIt7k3QFnoBazPuzr0bnZYb4j6PAuMfO395xvqpWsItPH83ibTuDU60Cf7OppQsgXtViGhAuBH
 E+Y3RRtksq1IvOwMXCWPOgSo06wW5eQMUQ0ik+zlPfp2fi5bpZIp6hJZJ1idbQMy495wWYLfdKz
 cg6j/26fflmqQN++S+fFOigG5bEVP/p1kS6JHnh2DNiVgkHi9TxTt/9QtB3Sp5hldgini61aejr
 A6YKzUGa3vCWE8EHb0lw9QT+5yhgfY/UwkFfmv5uB0mZYrmuzJfZ7qvaz21eVNP5tl3RXd6sROk
 0BxDfDm1V37hRGRPso6JOmB6tVAU7p9nMSHIfmiVFtX2EvcFgeRbsrROE6HLnid/ZO3FMxsehkN
 7opd4a6oxlcFUbKQi+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200162

MSI IOVAs belong to a paging domain, but iommufd may replace a device's
domain while its interrupts remain allocated. Waiting for another IRQ
allocation to populate the new table would leave existing interrupts
without valid MSI IOVAs.

Track live IRQ allocations so the attach path knows when the incoming
domain needs an MSI IOVA table. Rebuild the table through
iommu_dma_map_msi(), allowing each backend to preserve its own IOVA
allocation rules.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu-ir.c | 41 +++++++++++++++++++++++++++++++---
 drivers/iommu/riscv/iommu.h    |  2 ++
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index 4dc104c6d4b1..5718f90affd6 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -128,19 +128,27 @@ static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
 	 * quiesced, including MSI teardown, before switching away from or freeing
 	 * the domain. iommu_dma_map_msi() requires the group mutex to be held;
 	 * take it around the domain lookup too so info->domain can't change
-	 * out from under the build.
+	 * out from under the build. Bump info->nr_irqs here too, before
+	 * irq_domain_alloc_irqs_parent() runs unlocked below, so a concurrent
+	 * riscv_iommu_ir_attach_paging_domain() can never observe a count that
+	 * is lower than the number of IRQs actually in flight for this device.
 	 */
 	scoped_guard(iommu_group, info->dev) {
 		struct riscv_iommu_domain *domain = rcu_dereference_protected(info->domain, true);
 
 		ret = domain ? riscv_iommu_ir_build_msi_iova(domain, info->dev) : 0;
+		if (!ret)
+			info->nr_irqs += nr_irqs;
 	}
 	if (ret)
 		return ret;
 
 	ret = irq_domain_alloc_irqs_parent(irqdomain, irq_base, nr_irqs, arg);
-	if (ret)
+	if (ret) {
+		guard(iommu_group)(info->dev);
+		info->nr_irqs -= nr_irqs;
 		return ret;
+	}
 
 	for (unsigned int i = 0; i < nr_irqs; i++) {
 		struct irq_data *data = irq_domain_get_irq_data(irqdomain, irq_base + i);
@@ -151,9 +159,25 @@ static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
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
+	 * than the number of IRQs that are actually still live.
+	 */
+	scoped_guard(iommu_group, info->dev)
+		info->nr_irqs -= nr_irqs;
+}
+
 static const struct irq_domain_ops riscv_iommu_ir_irq_domain_ops = {
 	.alloc			= riscv_iommu_ir_irq_domain_alloc_irqs,
-	.free			= irq_domain_free_irqs_parent,
+	.free			= riscv_iommu_ir_irq_domain_free_irqs,
 };
 
 static const struct msi_parent_ops riscv_iommu_ir_msi_parent_ops = {
@@ -257,6 +281,17 @@ void riscv_iommu_ir_irq_domain_remove(struct device *dev, struct riscv_iommu_inf
 int riscv_iommu_ir_attach_paging_domain(struct iommu_domain *iommu_domain, struct device *dev,
 					struct iommu_domain *old)
 {
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+
+	/*
+	 * Build the table if this device has allocated MSIs, since those MSIs may
+	 * already be live and expecting riscv_iommu_ir_compose_msi_msg() to find
+	 * a populated table for whatever domain is now attached.
+	 */
+	if (info->nr_irqs)
+		return riscv_iommu_ir_build_msi_iova(domain, dev);
+
 	return 0;
 }
 
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 59779aa9d380..24006c1c1722 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -46,6 +46,8 @@ struct riscv_iommu_info {
 	struct riscv_iommu_domain __rcu *domain;
 	struct irq_domain *irqdomain;
 	struct device *dev;
+	/* Number of currently allocated IRQs; protected by the group mutex */
+	unsigned int nr_irqs;
 };
 
 struct riscv_iommu_device;
-- 
2.43.0

