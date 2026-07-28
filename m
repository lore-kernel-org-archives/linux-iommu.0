Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C813B1009
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785241999; cv=none; b=E7qDjHSjd6XCNfsbLEqqoceInM3LO5H7pa7b8W/aJ3ilXEZSqh3Lkn6oPl1TPYq6EX9VggXQ9Uw4H4QN4zrfDSYJpjlXj3ZsTeYeInYJHyVSeLJLu4NTH/gBRb+C6TxEYHLMnJhKNHopfaP7Y7E1WyB/h7MKzWBivqmLhKQ5v1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785241999; c=relaxed/simple;
	bh=4l8Tbmwul07cW1cP1nc9DSox0wkyJz5zWwH4wdKf4kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oCnbXlN82DyYYMqbbFSnG23FXUaTxkRdKywi5qknypdgnJszGHWe5ZhJHS6o4Kyc7pw3PUcg4XYcVfBeLClq1FezujbvDxF78+s/5EtpT+Pln3ny5P64+koKEPXpvdjwAzLC/muNUDosS6zhzjmoE3bNb1wW0C0BqYSKNEpbWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=juGmHZk5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Iv31/2IE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="juGmHZk5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iv31/2IE"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SBHstw2767246
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 12:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=NBs7h9fyGolaUbIrLXSfZELOeJJDur2xsFf
	UV3ea4hA=; b=juGmHZk5AqciaTKRHxzIBMv1q0GJA/M/q1FnDv2pVVPwmGdr2XM
	1HpGLz5m2mV8QxyVjgOvJWjgUkp1MLHQR2VlbK2PxTbzvK0HuGpasK/2sCg4AjQW
	jSGM+KqDjaulyiql/Z/3N634+lCAoL01KmIYjaEKxUy+2ylOjtsrK0oEvBQKyn4P
	Yr4pJqJSTEJ2sEAy/gOCrMOTc0ULHjqmlOikc07u+sM5ltnslvWib/VV0WYuvL7d
	5/CO8hFWNIK639i8VM/nTQh16G/wbNqMPkSaUaklzsnfTNl7HOK9OVoPmUbrneQq
	2Iia8LUepQz6b413dtu7Zzs4+N8NRkR9aXg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fphh7jre8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 12:33:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e62e3459fso408005185a.0
        for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 05:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785241996; x=1785846796; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NBs7h9fyGolaUbIrLXSfZELOeJJDur2xsFfUV3ea4hA=;
        b=Iv31/2IECwFxLnrxUCIxhnTL/zQ8xs6ge8cwLmq5RK9ZDHuYOxe1/aE2CgS1GQKyQS
         lNfRenNsXxBCM0VVsVIOmjjZ0fnOTclKM/AsccxCjo6RCUdUVJQdglUvPrdyhkuMcwYS
         YdbLd5SUgeZlGIoVCFFTGOuzkgfqq/AapEox/rE8bthJLYs6BiVt1lzl+nx++YTE2U1y
         Jx3LSbcYpbFXziBauM0onrNc0bz8VZjyCbQMgdc8sZgm70Kb5QutlA+1sHXtO4dbCP8l
         47EVMNpK2LxR/Dauu/3QkdQ5tPqvFV0S8sG1fjk2shVaKo6KL7QyXgOhcJzl9JC5xCZ1
         q/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785241996; x=1785846796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NBs7h9fyGolaUbIrLXSfZELOeJJDur2xsFfUV3ea4hA=;
        b=o8F0E+ERjeL1fjJiOZJc98gP7gnVyUqjbDMTDi6NokBsoC3NKVef4ZWPrqLS/pFcmE
         OM3aSBGOxM3s0o41AeL+YnlVy5uTef50wzQfVNGXvupV5dxvrqUXUHuY5nzyFL4QkVMh
         6pcH/1+/pJzB3OL87I04rADMVD7qx+vkGIuQB4zb6ijetZn3Cp9IRjvukvsSt3KBII2S
         mvUA9jQWS2+P10JgxGfhD43lv8Gc0m/SXdiYlJpTeuUNnPEFG6XqvOB0M4v/gpumcS+Q
         8wO+EgpN+tG4x09yWxXQzP52znQ011flce10vhSc6P2/sLBwlGR5/OESL1knYKEMwltj
         J/9w==
X-Gm-Message-State: AOJu0YyvS/zGiNoiL8QcjcNQgB273wRQLniVPKZ0p74IE1jNN2WoC9Un
	4wJpQQd73PZsrwkrNKmxgyrnVOAW+SU9RsYWOsvyu/a1yDhDPHaHefP4f7DoHJfpcQhQ5K5yJBk
	7WweLjgHgHYdQyju40/exiT92t/0xCcxjZu1LJ3WMAXZETFfz2OcpAR07DrUQgI5GPg==
X-Gm-Gg: AR+sD10ivKDdKvOoe19s0ifwGHydofRhhCNVq81vyCwRBoaM0deby4PUWD/Z2Hkumxa
	FWk026s3gOpyEipj4eOLDno34sx+VVabfx4yccXbx4kWHq+zLwZEyQq3jeqyj8Pj3x5/rCZl8Cj
	hXZfBJGcpzszyaNSU0IRQsNG7Byzr+UxrwfpBjn8A49jAUfgxXJJsyIHd22tIj9kWSHxQVABjT7
	BGVq6pG/HpzPgezO74AkK6Xnq250z/aEkZlCDNrXrN/E7vgpYq2USymFcVua6UgJOzUtiWaAnXM
	kWxyal/oWWo0SmCZoHNduzX7BxQo4sqaUqpXZNoZceKAAD6VC770Q0DBXPnKlTJsIj0PohZGtnr
	IgSJoyAvM1QEzF1aQbcSok0HtEEAnD1bGndcK
X-Received: by 2002:a05:622a:1c0e:b0:526:75fb:73ad with SMTP id d75a77b69052e-529d7175506mr16369021cf.79.1785241995929;
        Tue, 28 Jul 2026 05:33:15 -0700 (PDT)
X-Received: by 2002:a05:622a:1c0e:b0:526:75fb:73ad with SMTP id d75a77b69052e-529d7175506mr16368751cf.79.1785241995477;
        Tue, 28 Jul 2026 05:33:15 -0700 (PDT)
Received: from localhost (ip-86-49-247-5.bb.vodafone.cz. [86.49.247.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb51c9eb1sm3944003a12.10.2026.07.28.05.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 05:33:14 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
        nicolinc@nvidia.com, jgg@ziepe.ca
Subject: [PATCH] iommu/dma: Restore locking around msi_page_list
Date: Tue, 28 Jul 2026 14:33:13 +0200
Message-ID: <20260728123313.1284782-1-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDExMSBTYWx0ZWRfX2TBLGbWZNvpo
 jI3YqbkbtRFi7YRHYJOnl45BBg1A4vqAg/Xyhfr9iZdszsVPMPG+4/SEogu9Y7E/TsjxLK0vb4A
 7P5H7vAwkM4XnAM0974QhkmMsmsAebc1r0hVUrYK++zOmAAwTQekcc/OsJhdnRJojymRmPmw7Hk
 U/ozUJRANEZEcqmbA8iPB/LfWSPmOEhIbajQx7kwj2XlR+SYGTk51Wk8A3weM8xRVHT/F/J0iPg
 ho4yoFaYYzTtQufLaBtbpODrmCJV5JfLnlrKpwKPyoaouh/P0EZIvvRNGD9UNZq3Z6OJIvk58mZ
 zJ4syOyKVdmsEuhcqoGotGQNnyzWmDugQcYVGumchwu4236ZeYyLPdkvURAnBLVQ/6wfwBsZU0/
 54IeqtRzAPMpFsyR1W1yrVSp5cjrRMrKA5FTIEKVLMQ/q6HC+s4Wq2T56Si/DrIR/4Q0WAr1ibe
 XAE5KmGm1vkjZ+QKYyQ==
X-Proofpoint-ORIG-GUID: QG8DbLr3_U8aoF3ftaIVpBnFf3eMYXhN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDExMSBTYWx0ZWRfX9LiktN4q4Q14
 fM4fp+J5aSShxPfTvMnclCMBdVWNKVAf4VA5efLyPV7OV2rn6xA3olWY/0N7PQWJG9XEcj1vyBw
 PpvgdZuF/sUGELA153dRWPAiyG9QE1A=
X-Proofpoint-GUID: QG8DbLr3_U8aoF3ftaIVpBnFf3eMYXhN
X-Authority-Analysis: v=2.4 cv=b+6CJNGx c=1 sm=1 tr=0 ts=6a68a18c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=aYZ+cQcEYoLAp2L633VOig==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=JUEW66voKHXcHtqHPfAA:9 a=NFOGd7dJGGMPyQGDc5-O:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280111

Unlike a group's default domain, which is always freshly allocated
and privately owned (iommu_group_alloc_default_domain()), VFIO type1's
legacy container merges any newly attached group into an existing
domain whenever their iommu_ops and cache-coherency enforcement match.

iommu_dma_get_msi_page() only asserts the caller's own group mutex is
held (iommu_group_mutex_assert()). On an IOMMU that publishes
IOMMU_RESV_SW_MSI, e.g. ARM SMMU, a VM with two such devices assigned
through the legacy container can have their guest drivers probe and
allocate MSIs in parallel; each host-side VFIO_DEVICE_SET_IRQS lands
on a different device fd and group mutex, but both devices' domains
are the same merged domain, so both can enter
iommu_dma_get_msi_page() concurrently and corrupt msi_page_list.

commit 288683c92b1a ("iommu: Make iommu_dma_prepare_msi() into a
generic operation") dropped the prior msi_prepare_lock on the
reasoning that "each iommu_domain is unique to a group," which holds
for default domains but not this VFIO type1 case. iommufd already
handles its analogous list correctly: iommufd_sw_msi_get_map()'s
sw_msi_list is explicitly ctx-wide and protected by ctx->sw_msi_lock,
not a per-group lock. Give dma-iommu's cookie the same treatment: a
mutex scoped to the domain, held around the lookup-or-insert in
iommu_dma_get_msi_page().

Fixes: 288683c92b1a ("iommu: Make iommu_dma_prepare_msi() into a generic operation")
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---

Sashiko reported this issue while reviewing a riscv iommu series[1].
I've only compile-tested this fix.

[1] https://sashiko.dev/#/patchset/20260724151218.965929-1-andrew.jones@oss.qualcomm.com


 drivers/iommu/dma-iommu.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9abaec0703ef..0b5da4579aaf 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -58,6 +58,7 @@ struct iommu_dma_options {
 struct iommu_dma_cookie {
 	struct iova_domain iovad;
 	struct list_head msi_page_list;
+	struct mutex msi_lock;
 	/* Flush queue */
 	union {
 		struct iova_fq *single_fq;
@@ -80,6 +81,7 @@ struct iommu_dma_cookie {
 struct iommu_dma_msi_cookie {
 	dma_addr_t msi_iova;
 	struct list_head msi_page_list;
+	struct mutex msi_lock;
 };
 
 static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
@@ -378,6 +380,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&cookie->msi_page_list);
+	mutex_init(&cookie->msi_lock);
 	domain->cookie_type = IOMMU_COOKIE_DMA_IOVA;
 	domain->iova_cookie = cookie;
 	return 0;
@@ -411,6 +414,7 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 
 	cookie->msi_iova = base;
 	INIT_LIST_HEAD(&cookie->msi_page_list);
+	mutex_init(&cookie->msi_lock);
 	domain->cookie_type = IOMMU_COOKIE_DMA_MSI;
 	domain->msi_cookie = cookie;
 	return 0;
@@ -2196,6 +2200,18 @@ static struct list_head *cookie_msi_pages(const struct iommu_domain *domain)
 	}
 }
 
+static struct mutex *cookie_msi_lock(const struct iommu_domain *domain)
+{
+	switch (domain->cookie_type) {
+	case IOMMU_COOKIE_DMA_IOVA:
+		return &domain->iova_cookie->msi_lock;
+	case IOMMU_COOKIE_DMA_MSI:
+		return &domain->msi_cookie->msi_lock;
+	default:
+		BUG();
+	}
+}
+
 static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 		phys_addr_t msi_addr, struct iommu_domain *domain)
 {
@@ -2205,6 +2221,16 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 	size_t size = cookie_msi_granule(domain);
 
+	/*
+	 * A VFIO type1 container can attach the same domain to devices in
+	 * different iommu groups, each serialised by its own group mutex, so
+	 * the group mutex held by iommu_dma_sw_msi()'s caller isn't enough to
+	 * serialise msi_page_list lookups and insertions against each other
+	 * here; take the cookie's own lock instead, scoped to just this
+	 * domain.
+	 */
+	guard(mutex)(cookie_msi_lock(domain));
+
 	msi_addr &= ~(phys_addr_t)(size - 1);
 	list_for_each_entry(msi_page, msi_page_list, list)
 		if (msi_page->phys == msi_addr)
-- 
2.43.0

