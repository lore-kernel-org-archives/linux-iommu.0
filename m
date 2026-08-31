Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003074F475A
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188403; cv=none; b=L2v0Bb7imYQDAGQiEA42cZE0bj9fOZl/ykpPVgAlCi0ALTzHt5znwDlH11KiktSLzlwqFkyqUABjY0+EmOi3sJH2N0a2fWZvWNj/h98V3/AED2l8CkYEDtHUTJWnvrk6KxCdwNcKDJEIAzTJMGbMc4hhyl6OpXs0i6uQ+0TYSqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188403; c=relaxed/simple;
	bh=d2kEh7HVzlBwHlg4wUlDQLP+gFBRPRjcYANIrX/vg2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWo5vqYMWi7yf2VJCRyCob1Q+c+e7BnSjvonrl55n3kdCWvZGcQjx/T6KobfBJO8prtqdXLFV89FVcWMa3tXD1vLpl5L+P610SWjBCaTO1Wg9uQE/S3Dh4Z7aYMG4/VjdFdSdQFNmTmM6UjkVT/AxaCjGcSWPj2e63+Acg6dGvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IPUQa0Pw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JqV6r4At; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IPUQa0Pw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JqV6r4At"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VETWoL3296759
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zpaaBsor5YI
	74G39irsbNb4XZr4VVwzRwDQMT7L/5rI=; b=IPUQa0PwLv4BhD+iOx+WUbO91c/
	rqVNB+19og2ZNQ01/n6ZCbmNO5sUy0nCyGIm+LoK1RaZD8TEDNZg41w0ITRVHoz4
	r5yUySpRfnRsHsuLTsqJmzbDv8Kxt7UbB/YoJRZrlbFPtc16Mnk2J87MDyQGdysc
	nNmm+ZTv0Dv6zYUkpRjYavgpIdbSsRUCPgzG3/AUOeQxJoJDCANP/2pS+GIc1hm3
	5ZHx/puvEYtZA2i70bupg3ToFPFqZre/TAjUGLePWlsx0OqYkpH0V6JR62oO9Hrb
	eH9J2s17CBpF9yn6uDVukCX4AehkOCH7Nh2Xyb4WX8usM7tznlKc4G1hmLg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6ayhhxt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 14:59:59 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90cc915d1d9so49625026d6.2
        for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 07:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788188399; x=1788793199; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zpaaBsor5YI74G39irsbNb4XZr4VVwzRwDQMT7L/5rI=;
        b=JqV6r4At+6KWTSQGiPj0Fr60i6lLlLrOtOd6s3bUxOVm2bgS7d5L/SoJHbW76CeMN2
         Fgq8SrsqbA2wXAF0lMxY7fs72t314btwKEwkYT1apuDZ7HPMxcDeMzyThOZYHlEURKfl
         X7D3PvNwVspj8I4JGCB5sSKbNWHgtMv4rHQax1g/l5LmjmLY/rQwtOmZoUJ7D05O7g5J
         Oiy1b+U5r+wT1eIvLsmHsszpT8ijFSSK9evCNy1bYbpTtHyY963S3Wpaor6xQRVz8UfC
         LolgUueGuzdIBfh/wumteRuYU1xPE2+S4wsupUdBFbFOLMpNaS4xBZBwgwOe3VL0u3qx
         2MDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188399; x=1788793199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zpaaBsor5YI74G39irsbNb4XZr4VVwzRwDQMT7L/5rI=;
        b=Luj6l0oxd7WH8wOGSemGRx9PPe0Md4MD0TyhM+bo57ngzYY9hLrjDf7uJX+XXdlfxk
         7KU8YFqh65jY6al4XB8ifjh9i+QhmICn/vhMPguMAt2ZjWWmSlbNzSPlP0NFBTEeRnK6
         9he+WjUKetgb4jE0DmDDmaj0hd6Ppq3L10SePF4bdJxmGfVx3IyBZhUOLMZopYI8dpal
         qd6zc20J2jEoxdOsOXmjCNhUSOkQP6LI6WV1HiAspHTQL1eZDuXacZ+vxvCDu71g7VMS
         mYw/UNtwE7TfxH+Vyn57U8SRBDAHlV+ouZDj8FBzgxzubhMIyXsLYw4ZlwICMzXHYMFU
         Oj/A==
X-Forwarded-Encrypted: i=1; AHgh+Rr5PyspnF5K49f6IxJ7GoRRPVIWMJqxHOvVjZSFPFTYTCvoO4DsD/YSMv/TXHktOTnKtPvpuw==@lists.linux.dev
X-Gm-Message-State: AFuF++maIwHwfvnWGrT+bzonPUrTLU9uOtXpx64ZVShSlOKUXmdOqCmc
	Yc1bVo3Vv3pcVv46IzAyncKVbC+HT6NmT46dyQpCORsK1P4SfQUj8DDWdgzdzLOJlp9VRGmFH//
	x5pfl2bKQH9PCiZeKex65nfx0kejJT5Je/2uhe4CD/E4rRYQLacutA2gwRg==
X-Gm-Gg: AR+sD11eb+z+Pb7dmTa0/pe+Gl2oBGJ2VsjRcDkTmzWTMgqeBp0ZHKrJEnODjYX7RCg
	i0ZSgnM+QMSjxGtHbP85G4t8aCs/FQ6I6La8x79fRHH3xiV49hKmxOZFhg1AKuNDPwHcawKxcr/
	qY/km+8zZBNwmTJ+encgS5CQebCz3E4dER+WAFRLEzsHQ5Z0DAE31mwJMGkmMrx3apsctSOfrNi
	5cTghRmVZa4Wk1YItw1aIBNkji2iwY2K5UdD2lyxsdI19PT3Nh7W4tmp6LG/5KKhV+JPoxiqSdL
	LJc9hZ0tLzI+JwpdkVrvgjAFsDI8rTxlqHfGchI6wzFFaqojjS4A0G8z4TgWlt5Gew1qGJSeog1
	eBg77LTZoCFaS/N6i6tll+dxYcIh3Zx4g8vI=
X-Received: by 2002:ae9:f70b:0:b0:932:ddff:123d with SMTP id af79cd13be357-93913940a19mr2492737985a.29.1788188399065;
        Mon, 31 Aug 2026 07:59:59 -0700 (PDT)
X-Received: by 2002:ae9:f70b:0:b0:932:ddff:123d with SMTP id af79cd13be357-93913940a19mr2492733185a.29.1788188398551;
        Mon, 31 Aug 2026 07:59:58 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ccea6b814sm180435205e9.0.2026.08.31.07.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 07:59:57 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v5 08/17] iommu/dma: Introduce iommu_dma_prepare_msi_list()
Date: Mon, 31 Aug 2026 16:59:34 +0200
Message-ID: <20260831145943.313726-9-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831145943.313726-1-andrew.jones@oss.qualcomm.com>
References: <20260831145943.313726-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfX6IyBDlCNxgKD
 prg2G8kf1yXxXlJ2C9nvLZ0wsdt34K9Tkn5z+J1gxcgW03SGEEW+mFA05dpA3KYzLzK6xF1mYjH
 nzq4QI0cja8/awU9M9g1K6Q/BwF+ppU=
X-Proofpoint-GUID: bPoIbYZTmhZsDnwg1nHIIEUi7kPfWBCA
X-Authority-Analysis: v=2.4 cv=CYE4Irrl c=1 sm=1 tr=0 ts=6a9596ef cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=2ceW4JgIosI8Fxwmn1gA:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: bPoIbYZTmhZsDnwg1nHIIEUi7kPfWBCA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfX3CKMgNCx5dNR
 zI45iCJw3SGgmXsiQQnbXeO48tlj/K+PRcMNYqGc090AaR/NaXDxCyV9W4gp+bzG80RUjgs0DU/
 KT+yywZFIak4LCi+LKNOsqR0pxw5WQWc/q/nDNchRTcglXRmh/MRswDc43ei4/wXWtu/iqcbysO
 O28wmVE900kqV5qb0owKpNgee4Jgz1YGFpM2Rywt8W3F1DINlK2K156lGl0irhCXidnb2DtAtUe
 zGiafdnL7NW9uahsLgfutHWTUNHW/fhQCgVfwjJ3gFxhWUSqJlOgqp8J+At8ocRGZBDjTfyMRTI
 pxBMuUxDLvP8pdOmEDCifjthhH12cBq8C8HNAfL2zy9+4OtEgJL4hyljyf37PVoB5ht8cWtdYx/
 APv4JtAS2bUUXL7KxYOLirdHWHWezoideuudu/h5LExLX0W1ZoAEPqLruI7KvNDaydQ1sQ6Utqq
 yLSb3l1ilK8a7oS1FZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310129

Add iommu_dma_prepare_msi_list() to map an ordered physical address list
through the current domain backend. Validate that the requested granule
is a power of two no smaller than PAGE_SIZE and that every address is
aligned to it.

Refactor iommu_dma_prepare_msi() to obtain the backend granule and align
its single address before using the same list dispatcher. Convert the
DMA-IOMMU and iommufd backend entry points to consume address lists
directly.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/dma-iommu.c      |  13 ++--
 drivers/iommu/dma-iommu.h      |  13 +++-
 drivers/iommu/iommu-priv.h     |   7 ++-
 drivers/iommu/iommu.c          | 109 +++++++++++++++++++++++++++------
 drivers/iommu/iommufd/driver.c |  24 +++-----
 include/linux/iommu.h          |   8 +++
 6 files changed, 126 insertions(+), 48 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 38a0c4e244d6..c9fdc792416c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -2173,7 +2173,7 @@ static bool has_msi_cookie(const struct iommu_domain *domain)
 			  domain->cookie_type == IOMMU_COOKIE_DMA_MSI);
 }
 
-static size_t cookie_msi_granule(const struct iommu_domain *domain)
+size_t iommu_dma_msi_granule(const struct iommu_domain *domain)
 {
 	switch (domain->cookie_type) {
 	case IOMMU_COOKIE_DMA_IOVA:
@@ -2304,23 +2304,20 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 }
 
 int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
-		     phys_addr_t msi_addr)
+		     const phys_addr_t *phys_addrs, unsigned int nr_addrs, size_t granule)
 {
 	struct device *dev = msi_desc_to_dev(desc);
 	const struct iommu_dma_msi_page *msi_page;
-	phys_addr_t phys_addr;
-	size_t granule;
 
 	if (!has_msi_cookie(domain)) {
 		msi_desc_set_iommu_msi_iova(desc, 0, 0);
 		return 0;
 	}
-
-	granule = cookie_msi_granule(domain);
-	phys_addr = ALIGN_DOWN(msi_addr, granule);
+	if (granule != iommu_dma_msi_granule(domain))
+		return -EOPNOTSUPP;
 
 	iommu_group_mutex_assert(dev);
-	msi_page = iommu_dma_get_msi_page(dev, &phys_addr, 1, granule, domain);
+	msi_page = iommu_dma_get_msi_page(dev, phys_addrs, nr_addrs, granule, domain);
 	if (!msi_page)
 		return -ENOMEM;
 
diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index 040d00252563..bf9cd4102d35 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -19,8 +19,9 @@ int iommu_dma_init_fq(struct iommu_domain *domain);
 
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
+size_t iommu_dma_msi_granule(const struct iommu_domain *domain);
 int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
-		     phys_addr_t msi_addr);
+		     const phys_addr_t *phys_addrs, unsigned int nr_addrs, size_t granule);
 
 extern bool iommu_dma_forcedac;
 
@@ -53,8 +54,14 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
 {
 }
 
-static inline int iommu_dma_sw_msi(struct iommu_domain *domain,
-				   struct msi_desc *desc, phys_addr_t msi_addr)
+static inline size_t iommu_dma_msi_granule(const struct iommu_domain *domain)
+{
+	return 0;
+}
+
+static inline int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+				   const phys_addr_t *phys_addrs, unsigned int nr_addrs,
+				   size_t granule)
 {
 	return -ENODEV;
 }
diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index aaffad5854fc..1122c99566d5 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -54,10 +54,11 @@ int iommu_replace_group_handle(struct iommu_group *group,
 
 #if IS_ENABLED(CONFIG_IOMMUFD_DRIVER_CORE) && IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
 int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
-		   phys_addr_t msi_addr);
+		   const phys_addr_t *phys_addrs, unsigned int nr_addrs, size_t granule);
 #else /* !CONFIG_IOMMUFD_DRIVER_CORE || !CONFIG_IRQ_MSI_IOMMU */
-static inline int iommufd_sw_msi(struct iommu_domain *domain,
-				 struct msi_desc *desc, phys_addr_t msi_addr)
+static inline int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+				 const phys_addr_t *phys_addrs, unsigned int nr_addrs,
+				 size_t granule)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a3dea7353500..692e793c624e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -4223,42 +4223,115 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_done);
 
 #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
+static int __iommu_dma_prepare_msi_list(struct iommu_group *group, struct msi_desc *desc,
+					const phys_addr_t *phys_addrs, unsigned int nr_addrs,
+					size_t granule)
+{
+	if (!group->domain || group->domain->type == IOMMU_DOMAIN_IDENTITY)
+		return 0;
+
+	switch (group->domain->cookie_type) {
+	case IOMMU_COOKIE_DMA_MSI:
+	case IOMMU_COOKIE_DMA_IOVA:
+		return iommu_dma_sw_msi(group->domain, desc, phys_addrs, nr_addrs, granule);
+	case IOMMU_COOKIE_IOMMUFD:
+		return iommufd_sw_msi(group->domain, desc, phys_addrs, nr_addrs, granule);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int iommu_dma_validate_msi_list(const phys_addr_t *phys_addrs, unsigned int nr_addrs,
+				       size_t granule)
+{
+	unsigned int i;
+
+	if (!nr_addrs || granule < PAGE_SIZE || !is_power_of_2(granule) ||
+	    nr_addrs > SIZE_MAX / granule)
+		return -EINVAL;
+
+	for (i = 0; i < nr_addrs; i++)
+		if (!IS_ALIGNED(phys_addrs[i], granule))
+			return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * iommu_dma_prepare_msi_list() - Map MSI pages in the IOMMU domain
+ * @desc: MSI descriptor to update with the base IOVA
+ * @phys_addrs: Ordered MSI target physical addresses
+ * @nr_addrs: Number of addresses in @phys_addrs
+ * @granule: Mapping granule for every address
+ *
+ * @nr_addrs must be nonzero and @granule must be a power of two no smaller than
+ * PAGE_SIZE. Every address must be aligned to @granule. The addresses are mapped
+ * in order to one contiguous IOVA range and may repeat. The list is consumed
+ * synchronously and is not retained.
+ *
+ * When a software MSI mapping is required, the backend records the base IOVA
+ * and granule shift in @desc. Otherwise, @desc is left unchanged.
+ *
+ * Return: 0 on success, -EINVAL if the parameters are invalid, -EOPNOTSUPP if
+ * the domain backend cannot provide the mapping, or another negative error
+ * code from the backend.
+ */
+int iommu_dma_prepare_msi_list(struct msi_desc *desc, const phys_addr_t *phys_addrs,
+			       unsigned int nr_addrs, size_t granule)
+{
+	struct device *dev = msi_desc_to_dev(desc);
+	struct iommu_group *group = dev->iommu_group;
+	int ret;
+
+	ret = iommu_dma_validate_msi_list(phys_addrs, nr_addrs, granule);
+	if (ret || !group)
+		return ret;
+
+	mutex_lock(&group->mutex);
+	ret = __iommu_dma_prepare_msi_list(group, desc, phys_addrs, nr_addrs, granule);
+	mutex_unlock(&group->mutex);
+	return ret;
+}
+
 /**
  * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
  * @desc: MSI descriptor, will store the MSI page
  * @msi_addr: MSI target address to be mapped
  *
- * The implementation of sw_msi() should take msi_addr and map it to
- * an IOVA in the domain and call msi_desc_set_iommu_msi_iova() with the
- * mapping information.
- *
  * Return: 0 on success or negative error code if the mapping failed.
  */
 int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 {
 	struct device *dev = msi_desc_to_dev(desc);
 	struct iommu_group *group = dev->iommu_group;
+	phys_addr_t phys_addr;
+	size_t granule;
 	int ret = 0;
 
 	if (!group)
 		return 0;
 
 	mutex_lock(&group->mutex);
-	/* An IDENTITY domain must pass through */
-	if (group->domain && group->domain->type != IOMMU_DOMAIN_IDENTITY) {
-		switch (group->domain->cookie_type) {
-		case IOMMU_COOKIE_DMA_MSI:
-		case IOMMU_COOKIE_DMA_IOVA:
-			ret = iommu_dma_sw_msi(group->domain, desc, msi_addr);
-			break;
-		case IOMMU_COOKIE_IOMMUFD:
-			ret = iommufd_sw_msi(group->domain, desc, msi_addr);
-			break;
-		default:
-			ret = -EOPNOTSUPP;
-			break;
-		}
+	if (!group->domain || group->domain->type == IOMMU_DOMAIN_IDENTITY)
+		goto out_unlock;
+
+	switch (group->domain->cookie_type) {
+	case IOMMU_COOKIE_DMA_MSI:
+	case IOMMU_COOKIE_DMA_IOVA:
+		granule = iommu_dma_msi_granule(group->domain);
+		break;
+	case IOMMU_COOKIE_IOMMUFD:
+		granule = PAGE_SIZE;
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
 	}
+
+	phys_addr = ALIGN_DOWN(msi_addr, granule);
+	ret = __iommu_dma_prepare_msi_list(group, desc, &phys_addr, 1, granule);
+
+out_unlock:
 	mutex_unlock(&group->mutex);
 	return ret;
 }
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 45278c11c688..72e9ce63a5ee 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -419,9 +419,14 @@ static void iommufd_sw_msi_set_required(struct iommufd_group *igroup,
 	}
 }
 
-static int iommufd_sw_msi_list(struct iommu_domain *domain, struct msi_desc *desc,
-			       const phys_addr_t *phys_addrs, unsigned int nr_addrs,
-			       size_t granule)
+/*
+ * Called by the irq code if the platform translates the MSI addresses through the
+ * IOMMU. phys_addrs are the physical addresses of the MSI pages. iommufd will
+ * allocate contiguous fd global iovas for the physical pages that are the same on
+ * all domains and devices.
+ */
+int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+		   const phys_addr_t *phys_addrs, unsigned int nr_addrs, size_t granule)
 {
 	struct device *dev = msi_desc_to_dev(desc);
 	struct iommufd_hwpt_paging *hwpt_paging;
@@ -505,19 +510,6 @@ static int iommufd_sw_msi_list(struct iommu_domain *domain, struct msi_desc *des
 	return rc;
 }
 
-/*
- * Called by the irq code if the platform translates the MSI address through the
- * IOMMU. msi_addr is the physical address of the MSI page. iommufd will
- * allocate a fd global iova for the physical page that is the same on all
- * domains and devices.
- */
-int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
-		   phys_addr_t msi_addr)
-{
-	phys_addr_t phys_addr = msi_addr & PAGE_MASK;
-
-	return iommufd_sw_msi_list(domain, desc, &phys_addr, 1, PAGE_SIZE);
-}
 EXPORT_SYMBOL_NS_GPL(iommufd_sw_msi, "IOMMUFD");
 #endif
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ac43b8b93f14..bf08be172e40 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1561,8 +1561,16 @@ static inline void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 
 #ifdef CONFIG_IRQ_MSI_IOMMU
 #ifdef CONFIG_IOMMU_API
+int iommu_dma_prepare_msi_list(struct msi_desc *desc, const phys_addr_t *phys_addrs,
+			       unsigned int nr_addrs, size_t granule);
 int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
 #else
+static inline int iommu_dma_prepare_msi_list(struct msi_desc *desc, const phys_addr_t *phys_addrs,
+					     unsigned int nr_addrs, size_t granule)
+{
+	return 0;
+}
+
 static inline int iommu_dma_prepare_msi(struct msi_desc *desc,
 					phys_addr_t msi_addr)
 {
-- 
2.43.0

