Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C564D9F90
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606244; cv=none; b=tCuiRDV/Bsci6zcDhDVQaAf2MTpQUsJfo1MmkbZsAXSDKro30iTv3NYJ8zhFH/pBPsbxoeEIm+h29nCLtBl2Pcr4H6f49ZmoEZPSOuslwQ33PPCD66ILAHYaN37KGb3iArN9a+W5wWylS/UD/MPyUoKAYQjmPNirSsw+dnaZbos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606244; c=relaxed/simple;
	bh=1mRl07ST/iJhykaW3wF3eXHlnR3DTJeLAgQFLYXJDnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzPz1EPpmYvwo3ftLgCFaoZhXXQ3g0Cw95/K8k3mC8ZFLBWPmT+6o9rGyi1N9DJ1P3yR/2B1XP0k2JS+9jwoYQuB4ITyUaYte96xSescNiylM3B8nmrJDMmFYjHpgGI5YWqtvFJJkivDt9uTAEKVHrxErKpnwBcttfik/7+b4L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ninvScti; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=apT2xcuj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ninvScti";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="apT2xcuj"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAVXj1042603
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jvlI2T8w+64
	hQrpum98oA1DnDUfoowHi2+WuxN0638E=; b=ninvSctiq/nMCrPjojeVd+h7piV
	MkS2L0yVYz80LV5d/CefxgMB16lyAZhxotakiwoBSpDK+1NKDQLiDyBCcl6JhcL5
	0cVwUZ2Lgk7ZKuCNfd/Dp/nJAWjYmR7S2mmbcrUcZsprSqQM5fj+HuvbAOXn3x45
	ALQZ2QnrTVXvEtxkzgwL8rVJg/Y9I0Cbzb+LPsN6OrFjDBC8cbcVETgQa/t6y5wX
	wsF8RTOlSs7uYGLAvc3y8W4UF98GAfijitszPClypIQKEN0ib4RvALb9cZ0sxP1H
	/FygaS5wZHxSsf47sjUpIdUEtJEP/+158ZrYE6ERboIsnX1Nb8d6xOMa1wQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyk5msrrn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:37:06 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-14383177746so6414105c88.1
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 07:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790606226; x=1791211026; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jvlI2T8w+64hQrpum98oA1DnDUfoowHi2+WuxN0638E=;
        b=apT2xcuj4Wty0JrXaQJk1IfRKwd1tRK/59HXlAyWfKChaa0M4Au/rXQpRMqdb6ovUn
         6Zc1C5hcPLseuGXPdeKwTNH1Hk0gAZqldWt+eY4c7w9qkSkK5prN9kiyvlc8E9GUuwOQ
         O/k8gxejZmGig3aaYYT48jfDcwM1Y5l6qk24dQg3b+bMNQmkKsBpQFfM8NYIdPouHb8P
         zRczGtqMvA17HLbheiwTR8CQ15+PNqnbC/zLSOntyBbeMaHmeiGPEheb0paf0C21VBF7
         6ZrykaXxZPfn9ihdB9GVeCp99BOPr2yosdIOxIz3Fc/3gXtFTuCJmvr8R+wCJcrndieF
         NoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790606226; x=1791211026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jvlI2T8w+64hQrpum98oA1DnDUfoowHi2+WuxN0638E=;
        b=sXNYtNreYrY8fTUcGEOMO/POnwyp3pSEb8EUi/rar6WKe5U6l1BA3qj/xeLIruUVdY
         4uo36Vwd/Il2bv71b+TXTymCnIuuYPrnjmkRGLhHd/2UXjKBIY7/KoJpslJtmj8FkRL6
         pCZ0bvIuemqwW+PGFr80hwMesOK2K6DaPYdVBZ4V03g6ocjlLJU8vjaskduKJ11O+bPN
         6opQGXexwvPEHoNo2zTjIDzSzN3dIClYnv9NSYK/mYo/aIahKRGgRktRx+T9qd3OZiZu
         eERuZIEWaZGPZMTOy/o8ZbB829TqY5Iwm3s8uSR2xaN2VQro6vLNlIEf6ymrltXP3NhF
         PI1A==
X-Gm-Message-State: AFuF++mucIhsgpoxxVsbRoyF6IcX5k1c0aFOCf8Ye2OhiVdQrgqYXduy
	1hdUCZDSCLYpCsopRnFcYRIE9f3HW1xTodnl4OJhinesg6FKsIeQdpnkAY63/Jqzfg08/2uY0/m
	RHhTK/vb6ALED5liff6K05TPsmj07qwZenJvR1mcFUyxQQwxHgQzjKi64Lvqd+On85Q==
X-Gm-Gg: AYBFou2agiMUgXhgxDamX0HPqtzH8ImsDIBX+zxZSsxsJydEhMEPo+bZUC/vGe++N0Z
	GEYcQJqLFxgdazPaD/sEtGSnZxi7FLludigijjFy3AaVlgJcAazqONn5tYyfKFiRwZCnr1WEr05
	Uh5C21ammmPqRN+cRFjQxfdz4zxdZ/I5mxigW736SVqB0GlNYWW1dnbkaqdcMo7NV+mtCQLpeOH
	MsKdFdSWzjImzPdt2nOG/L6v+3cbjzYDNj0TuTeQIl03qml4jnfxhl2Iv6xl9weM/RScv0mwcBY
	I6YmuGAGXowBkPI6O0D0nviROvxPvnscMTdWGuDLuIj7wCDIV3BJeTw0wNwY//UGE02YdNwN+kx
	5k1bu3F0VXGyNfMUlrUnm1ST4a9Mp7Cq3jZJ/rQ==
X-Received: by 2002:a05:701b:230b:b0:14b:2ef:9829 with SMTP id a92af1059eb24-14b02ef9b6cmr101498c88.6.1790606225691;
        Mon, 28 Sep 2026 07:37:05 -0700 (PDT)
X-Received: by 2002:a05:6102:869c:10b0:7af:81dd:a9d3 with SMTP id ada2fe7eead31-7af81ddbe26mr2436839137.29.1790605898562;
        Mon, 28 Sep 2026 07:31:38 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae76ad030sm484086466b.36.2026.09.28.07.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:31:37 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 03/14] iommu/riscv: Serialize MSI table publication with domain attachment
Date: Mon, 28 Sep 2026 16:31:02 +0200
Message-ID: <20260928143113.49838-4-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: bxn93Q8grz3ArcGSZ238Av6yTSWz8G2r
X-Proofpoint-GUID: bxn93Q8grz3ArcGSZ238Av6yTSWz8G2r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfX+rynLkRu2Q6l
 QwDxQdA/9EMjBWRRKvYyyrrqNmd9EQ9HQbe2UUFrQHBjOUQUxTcu9HWEN3ErOvESM8M9lztWxQC
 ++A4mSXWL2wUklRDP2ThhduI1qZHGMF0Xeg9tuuy8A8m/io6P3f/9a+n/p1dgqBsBk+vH3Xg8Es
 hJ8BH5bQ0NKyDnyd2d5S4qaFXTmQ1XLH6xyrfj2pElrNWw0kpZcuicNR/aFh5j/Kf0o51XUhN2m
 b/bSqJ3G28EmoYh3j8LdL5QnaEg4JHY77OPp7/k3LdeYUG+iDZAU1m7Ud2xIR3rTAPhfRSXfU6r
 TROC9E3halzlE5R10zljW7LN0sq/xifrzN6iz2AfQqbB/S7nB8M/gs5vdoLeer/srbZ8i5UPMrA
 H3YBhN0SE8d1voZrxGSSiOixFZM+jpxykmmCdsc1e1iRs/w/7+270R0jSuLRy2fFLhyXzG4UvR+
 s2e1oyGS1WHWPiiBNbw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfXwpyL4gCyE3i2
 Ni0qIZkvr8O9ywTCioJZXEpzr7MGzn4on5iLsfbinT/tL2WxjRcvceV3sGOdx67ObW8i2+Mj+D2
 ePLDfqg5ossNJOCSgrBEZHYgCYilGeo=
X-Authority-Analysis: v=2.4 cv=asYnmiZV c=1 sm=1 tr=0 ts=6aba7b92 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=BJuWs42claz3fuW2R7YA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280058

DMA mappings update entries behind the page-table root installed in each
attached device context. The existing bond and barrier protocol ensures
that attachment either observes a completed page-table update or is
included in its IOTLB invalidation.

MSI forwarding also changes whether the MSI page-table configuration is
installed in each device context. The first forwarded interrupt
publishes the configuration to all devices bonded to the domain, while
the last removes it. These domain-wide updates can run concurrently with
attachment because devices in different IOMMU groups have different
group mutexes.

Serialize attachment to domains with MSI tables against forwarding state
and device-context updates. During domain replacement, lock both old and
new MSI tables because either domain may process forwarding changes for
other attached devices while this device moves. This also prevents an
old-domain RCU walk from overwriting the newly installed device context.

Order the locks by address to prevent opposite-direction replacements
from deadlocking. Domains without MSI tables continue to use only the
bond lock for list updates.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c | 64 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.h |  2 ++
 2 files changed, 66 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 09ec8c3e4a72..57f2884dec42 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -874,6 +874,60 @@ struct riscv_iommu_info {
 	struct riscv_iommu_domain *domain;
 };
 
+static struct riscv_iommu_msi_table *riscv_iommu_domain_msi_table(struct iommu_domain *iommu_domain)
+{
+	struct riscv_iommu_domain *domain;
+
+	if (!iommu_domain || !(iommu_domain->type & __IOMMU_DOMAIN_PAGING))
+		return NULL;
+
+	domain = iommu_domain_to_riscv(iommu_domain);
+	if (!domain->msi_table.nr_ptes)
+		return NULL;
+
+	return &domain->msi_table;
+}
+
+static unsigned long riscv_iommu_msi_tables_lock(struct iommu_domain *domain1,
+						 struct iommu_domain *domain2)
+{
+	struct riscv_iommu_msi_table *first = riscv_iommu_domain_msi_table(domain1);
+	struct riscv_iommu_msi_table *second = riscv_iommu_domain_msi_table(domain2);
+	unsigned long flags = 0;
+
+	/* Address order is stable when the domains reverse roles. */
+	if (!first || (second && first > second))
+		swap(first, second);
+
+	if (!first)
+		return flags;
+
+	raw_spin_lock_irqsave(&first->lock, flags);
+	if (second && second != first)
+		raw_spin_lock_nested(&second->lock, SINGLE_DEPTH_NESTING);
+
+	return flags;
+}
+
+static void riscv_iommu_msi_tables_unlock(struct iommu_domain *domain1,
+					  struct iommu_domain *domain2,
+					  unsigned long flags)
+{
+	struct riscv_iommu_msi_table *first = riscv_iommu_domain_msi_table(domain1);
+	struct riscv_iommu_msi_table *second = riscv_iommu_domain_msi_table(domain2);
+
+	/* Recreate the lock order and release the pair in reverse. */
+	if (!first || (second && first > second))
+		swap(first, second);
+
+	if (!first)
+		return;
+
+	if (second && second != first)
+		raw_spin_unlock(&second->lock);
+	raw_spin_unlock_irqrestore(&first->lock, flags);
+}
+
 /*
  * Linkage between an iommu_domain and attached devices.
  *
@@ -1388,6 +1442,7 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_bond *bond;
 	struct pt_iommu_riscv_64_hw_info pt_info;
 	struct riscv_iommu_dc dc = {0};
+	unsigned long flags;
 	int ret;
 
 	pt_iommu_riscv_64_hw_info(&domain->riscvpt, &pt_info);
@@ -1421,10 +1476,12 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 		return -ENOMEM;
 	bond->dev = dev;
 
+	flags = riscv_iommu_msi_tables_lock(old, iommu_domain);
 	riscv_iommu_bond_link(domain, bond);
 	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = domain;
+	riscv_iommu_msi_tables_unlock(old, iommu_domain, flags);
 
 	return 0;
 }
@@ -1474,6 +1531,7 @@ riscv_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 
 	INIT_LIST_HEAD_RCU(&domain->bonds);
 	raw_spin_lock_init(&domain->lock);
+	raw_spin_lock_init(&domain->msi_table.lock);
 	mutex_init(&domain->mutex);
 	iommu = dev_to_iommu(dev);
 	cfg.common.hw_max_oasz_lg2 = 56;
@@ -1569,13 +1627,16 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 	struct riscv_iommu_dc dc = {0};
+	unsigned long flags;
 
 	dc.fsc = RISCV_IOMMU_FSC_BARE;
 
 	/* Make device context invalid, translation requests will fault w/ #258 */
+	flags = riscv_iommu_msi_tables_lock(old, NULL);
 	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
+	riscv_iommu_msi_tables_unlock(old, NULL, flags);
 
 	return 0;
 }
@@ -1594,13 +1655,16 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 	struct riscv_iommu_dc dc = {0};
+	unsigned long flags;
 
 	dc.fsc = RISCV_IOMMU_FSC_BARE;
 	dc.ta = RISCV_IOMMU_PC_TA_V;
 
+	flags = riscv_iommu_msi_tables_lock(old, NULL);
 	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
+	riscv_iommu_msi_tables_unlock(old, NULL, flags);
 
 	return 0;
 }
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 6bea9da71ff3..2876703a6698 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -69,6 +69,8 @@ struct riscv_iommu_device {
 };
 
 struct riscv_iommu_msi_table {
+	/* Protects attachment, interrupt forwarding state, and MSI PTE updates. */
+	raw_spinlock_t lock;
 	unsigned int nr_ptes;
 	struct riscv_iommu_msipte *root;
 	u64 msi_addr_mask;
-- 
2.43.0

