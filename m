Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC93644839C
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905972; cv=none; b=n/47e7uxBSjDBJaNdesWaRsp1x5oG8HTPGR4M4bHz9dUgHlkitWJpXjgnIItlEbeyC7v7vJ+8RgnIRei2c3octIAhu1Z+pvTyj3igXbVyAmXgcJU0b8FnlPACghDa+12ZuGjBzvR3kbUjbQVp8tYE6QGU37g48mGoZ9rEinJt54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905972; c=relaxed/simple;
	bh=+h1W/a5ndgUqKHLQy8n5dx/yGKf1ifkru4UGSryMMwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W32eICFrSF0iWQ06GvZHWyhc5o29BceIe4hBAzn43bjtZEZ9rF1s6KOFqYQsrH+E9fZws8FJiZXTvEFA0QH5+YaU8oRwNtCb8qRTLah0zeLWm9uCht8EzQ66icyz+ieRcnEs2nsFsWA4Pyq/xK08cmP2SCcFJRfnVDnryXuuzZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fTH1Lz+7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IysduK2F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fTH1Lz+7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IysduK2F"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbZth2710974
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kd3ZmeKFVQf
	MB+J1dbJBOnqgJkp1xv19FPuz/kbKlx4=; b=fTH1Lz+7AXTedH2N/CCZhN5jmTw
	CqvLVCZqNhwI8Gw8lSxx2MWhSgBFzoXsNxI9QUnqfAOXzO3AyautnKpPLmB7lNCi
	WDXHXVqFwgCgdQwQtikw3iD6C5DieNI2LHtk4KVmb+IPTzg62pln+1br6YnKS5Zy
	cW3JO4MPqYL9LanzdsScS0s9FtPhjiT4B6rbs8VH0OHsN+FceXk1AR0xLkPP/o/T
	oZcYkqLbYnouMCBTzVpK2vYBVuoSNXJQAEMb/ORhm67TUO98ZBQ0xn3TOqKwN6dl
	s/fP7F33ECYFwCJIyNYzGcsg5qqQs5aRxrXzdbov6FV7JyRiUxl+bzfBnhg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm8cgghtk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c01ff996dso5476591cf.2
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784905966; x=1785510766; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kd3ZmeKFVQfMB+J1dbJBOnqgJkp1xv19FPuz/kbKlx4=;
        b=IysduK2FNfb4VfDHBUWGTNh5Ae6UgFxRDT8V+qVTXcJp/CvoYiAzmzesyS8H7O+uhH
         2ZYhdVenQaNAYnY0Eb6cT2KpgI+yXKRDitF/bpVNuX9pSzYfMqCpYFXmEG4WqekU6s0z
         9nR+Mncl2Fk2u+MSrC07mN6N3rhmJTbhCv1MKfQQNrRMVC/2WHY/EU2cK99EbgYbPKaM
         jqzKeuOld15KT/Ga5Raim9qf/aLz52snUUl+3Kmd9R98VXlFbI0Vd48AgxF37fDRpWR+
         gW536IcWJXYbiNofofnamxhgyhl4i1OMa7lwCQJLzFg8bV+4Ddfpbj5dWRtWUH6oByvI
         LBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905966; x=1785510766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kd3ZmeKFVQfMB+J1dbJBOnqgJkp1xv19FPuz/kbKlx4=;
        b=MQpEWBzVJLLhay5StGjolYxCduhg3EsaKBPWh+NQhc62PYze4fRAzXrc7JnpbWEeuf
         YcVyW6sdr60zYnshWzCzVZnBdCXpqd/RkK8nw5VPUsiAkz5nzX+um3VNZh33b8zDl9lk
         DUT/dBqI9HTpHToqtvMM4MGB2p7429lEWevdH4gYgbC8FyD+lanzuiKQNjXrANGBtPpb
         i5y/12gLxImnrtbCy/+XoCj5R2wzLRORDYKL0hHgPYAISYJtIvilx+Uk4JiV+wcS8TGX
         qPxARgwt3lIxx4hvwnRlVPdYhWxw5Z2wUvUEanldV9CG7Tr3g48ImU23zzvfFK+mz+CF
         RwIw==
X-Forwarded-Encrypted: i=1; AHgh+RoE6qyJf2Zr6Pj1a5oIR+ZD7C+JcEwYi5wLxhp7+bGAM1o8rO0NXxt3/S7T7NnFFFfknSu67A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyv7Q065bWrMyjXGa2q1UYQnqEdLhqp1Qqzdd8ozMeXEI+LMN/m
	V5QX4fWOr8wMcwUMsN/DJYpNy8I2Pf5ue0Wrr0N3tOMSHG4B56ElPfDmISJJHo13wmZ75QucrFB
	INMN6ltbiVlD/+t0FA/OITTKFiiyfQvlEW5Y7xVZlKOtc0bpQHpnMpzoyoA==
X-Gm-Gg: AR+sD12jZGjM4XGy+O0JsRKzgKFIQjGy04pCd6ChzRFWFsIqWAAOooDuWIznMim64SW
	lxMVmltkJh0EvLkZUUDP7HQdeAhY3vGbqhJfFO4mM3lnAIELZXcDNGuumx/Cmj7uWlWveALb0ql
	sd+TZbc/VoEG5K5mPdXkJUrrcefp3Qdsuu2TdMcHpnE4WvnDl17kKjKfmtXLgAhuHIUtmEqueO3
	yOuVAW1MSdiaAXKkCSedPlxfxfajuQOgniEo/PYX6ItSqxLKvYAQQiyfZwM+7Dveci0wEqveYEy
	UkfEfvBRxtLoKKvIbqFQHgd79BPJLY5xXtUNHQBUdbgcGMI5xyrdjSzKev+j6dP3O2XvROsMmYS
	4rQgM1d4+r9WQkXMT4y+54MCPPAJfpKoZxoz5
X-Received: by 2002:a05:622a:1353:b0:51c:12bf:d4a6 with SMTP id d75a77b69052e-5283decd098mr75364061cf.48.1784905965551;
        Fri, 24 Jul 2026 08:12:45 -0700 (PDT)
X-Received: by 2002:a05:622a:1353:b0:51c:12bf:d4a6 with SMTP id d75a77b69052e-5283decd098mr75363521cf.48.1784905964963;
        Fri, 24 Jul 2026 08:12:44 -0700 (PDT)
Received: from localhost (ip-86-49-247-5.bb.vodafone.cz. [86.49.247.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32a7ad1esm362480066b.3.2026.07.24.08.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:12:43 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v2 11/14] iommu/riscv: Copy MSI IOVA table when replacing an iommufd domain
Date: Fri, 24 Jul 2026 17:12:15 +0200
Message-ID: <20260724151218.965929-12-andrew.jones@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=JOMLdcKb c=1 sm=1 tr=0 ts=6a6380ee cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=aYZ+cQcEYoLAp2L633VOig==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=6pi3hbU58VXC-MSegPwA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 65GjMeGeKqXhcAsnWkJZVQahDEU_N6p-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX3/gKe7t98sqt
 VOenyHKEvlKMx2eJ+bHhehoLnrNuT6ALQyCWgON7FtjT6OxZ8PQzpP5SNO4BelYNFwd609BFV0n
 iIpqLScgds5iP0AGAxA07yabM2Gf8Tw=
X-Proofpoint-GUID: 65GjMeGeKqXhcAsnWkJZVQahDEU_N6p-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX7coznTiuvZxw
 ir0OpJPzRYCyfJQOGkLkSkC+v+5GE154kXHiejZJbImvR8F89okLaD5qXsIPFtZGPNR/8obts0C
 Tl2UelAGW04nSanIR5wIve28ISXMkvwwQtq9VHvObTo+5WRYujP+IaDixeDhC6fefkXtQiKVKEU
 Ngbr9MnzFR1TBg+xeZdvnECGppWB0hthboG8rSU9OyHYnQMZ7aWToNMczTAmrbDbB/QcoYphWTI
 IOrPC1X0fx9/JXIWAa/DQ5+lBQmy3RC2rwrAes1KBNwwbvVmNcgQAmaAm7ng0CiFxFZzpmE/oSx
 drHKMBEKnvYGj3Y2y4YQ2Jl2Cmb7duCSZ7pzHjuAFGXnHt+IQG7avsJj24df7L4IhLjwlIwo+5D
 FOPpKQtMiB8IDHNUsfeoxvR0hiBIsiVu0MY2ktQwuDeYxNHv/XOdmZfgCvGLQNW4/LuOGK8V6hQ
 e6dOAnC5BSjnjLZGxdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240137

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
 drivers/iommu/riscv/iommu-ir.c | 29 +++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.c    |  5 ++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index 39ca4c89a2a3..bb1bc4c2bcec 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -216,6 +216,35 @@ void riscv_iommu_ir_irq_domain_remove(struct device *dev, struct riscv_iommu_inf
 int riscv_iommu_ir_attach_paging_domain(struct iommu_domain *iommu_domain, struct device *dev,
 					struct iommu_domain *old)
 {
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	struct riscv_iommu_domain *old_domain = old ? iommu_domain_to_riscv(old) : NULL;
+	dma_addr_t *msi_iova;
+
+	if (!old_domain)
+		return 0;
+
+	if (old_domain->domain.cookie_type != IOMMU_COOKIE_IOMMUFD ||
+	    iommu_domain->cookie_type != IOMMU_COOKIE_IOMMUFD)
+		return 0;
+
+	scoped_guard(mutex, &old_domain->mutex) {
+		if (!old_domain->msi_iova)
+			return 0;
+
+		msi_iova = kmemdup(old_domain->msi_iova,
+				   riscv_iommu_ir_msi_iova_count() * sizeof(*msi_iova),
+				   GFP_KERNEL);
+		if (!msi_iova)
+			return -ENOMEM;
+	}
+
+	guard(mutex)(&domain->mutex);
+
+	if (domain->msi_iova)
+		kfree(msi_iova);
+	else
+		domain->msi_iova = msi_iova;
+
 	return 0;
 }
 
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 5631af2c9ab1..d3b5d985887e 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1264,11 +1264,14 @@ static bool riscv_iommu_pt_supported(struct riscv_iommu_device *iommu, int pgd_m
 	return false;
 }
 
+static const struct iommu_domain_ops riscv_iommu_paging_domain_ops;
+
 static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 					    struct device *dev,
 					    struct iommu_domain *old)
 {
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	bool old_is_paging = old && old->ops == &riscv_iommu_paging_domain_ops;
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 	struct pt_iommu_riscv_64_hw_info pt_info;
@@ -1288,7 +1291,7 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	if (riscv_iommu_bond_link(domain, dev))
 		return -ENOMEM;
 
-	ret = riscv_iommu_ir_attach_paging_domain(iommu_domain, dev, old);
+	ret = riscv_iommu_ir_attach_paging_domain(iommu_domain, dev, old_is_paging ? old : NULL);
 	if (ret) {
 		riscv_iommu_bond_unlink(domain, dev);
 		return ret;
-- 
2.43.0

