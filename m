Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27152448D19
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755991; cv=none; b=d2Qlpf74+1GRFYqmc0UTQDPt5XkoikDOaOojkYAnFwx5CUaMmR+jBlieb1Zm99gGGJsLbj3VCwxaMIbHA+M4G0cH2A8WdTLToi3iEfJGBQ4TR0xJfps7eUFR1p6J+rTC+0zerpFOKIqY/sRN43WOl6j0/8dMx+stckzP4bGNVbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755991; c=relaxed/simple;
	bh=oZdcl+DcOpyx/BKBuDUugaTTS+5qNwFGceBtTaUP+qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnt8yTuSiYTCISMfrbzT0Hap0oeHMgnaXQNPrd6unYiqLCPl49R8rc5VXqZ1CfCssXrkhm2CPzFJRGxnGLGFIPB0vjl51jMZDuoWSdoUykKLUn+u3lEu84yDBpWNNjco0k9q0MU6DJJk+1/42GbIrYVKI2+bvrFucdWHnmVSxAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GFqbJTLX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UOz2NMku; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GFqbJTLX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UOz2NMku"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QDuxvt026301
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uRc0GuXWx07
	G3Ujbsxvy2twoM1JUOK8J6X/Sj4wclqI=; b=GFqbJTLXcJVmQsuheV+1rD9id76
	qb313CZZANCSNY5A3yWRaPQj1o2pbVaC9XABAr2/5XkAZpz4XeRwau0CnSiXjcSv
	kZTlEH4Z3ka7L86rSjG30a506WXuf8iXvEqUbW0Z7sUG2QjTvriXJnBqVP53Idiu
	4a8NWMlzvPz60QvnAtMahK5IRQiFEqtGYVsxj8mjav7Ewt8vdozyQ2fxqbKjWNij
	MwiJnZo+oIR9AaEThpNithYbpi/Ij694BPzdwRc/FI9HW/86zUj4IQTowpV8ZJ2c
	5ojtosufbCsHJrxjR40Ij0MfI43MzC//Y6NpP/boEbTArri7L+7fO5Bvz7Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9wmqs86g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:53:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c01ff996dso10177921cf.2
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 07:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787755987; x=1788360787; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uRc0GuXWx07G3Ujbsxvy2twoM1JUOK8J6X/Sj4wclqI=;
        b=UOz2NMkuhqKWkCy3ONT9egJ0cBF2P5C6cZ0X6sdFfJcUFQpVuqfMqH6D525WaGoHyY
         qnKYfGDq4rxFcnDL+ssszRctSuQ/eDrilar73ul0lFUJHuydVglCYQVfSCEXNvDXa9nc
         mX2jjiJ1+HBGIDUDP8pWoG0LEzBJVABzzmge0GfXvEua6UtUpef6Rs9WDnYkkOBf5U/6
         PcFaQOUe7golrmoXRkOXHoNwgZ8wuM4ROZX9JuI0o4mApoH68mvUIRNvLzO6L6Lu6Lrq
         iFm7XxmL4uAXhK9cnec4CQneHl8/HbRoiFik06jfBlv/WYy3tAyH4sZ5c+MI6AvgWYzS
         FJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787755987; x=1788360787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uRc0GuXWx07G3Ujbsxvy2twoM1JUOK8J6X/Sj4wclqI=;
        b=CSPvl6lCaXkLIqAa2kQ/wb5+YgfP5k2z04kLC8WDmsFKlw0JG3Z6LauFr7SVUDrabL
         fa+VDB6YXSLmctmL2ipPwJ8T833REczAuELWobBmyo2tFsiRaJlYCjJHFacLgV70/P08
         8XJqyaAk7ZU1GHEkI6/gBme5MjbFe0miFAannrf6dJATbG/OG5UJCAxvMWWjvwX79mw/
         vC8jd86hygjaa+0GcuSqlpOvjG8zFOPGxYHVJ2FhKrq5PY7msmYiTIyG1ln6DK0UuNOn
         CSJ6aif8NGSC2SCNVUVxA10WhFyjkmPmTVKlCNh4bmSunZS0kCLvh8jOyiCVxIH1oZho
         MX/A==
X-Gm-Message-State: AFuF++lqwiLhImRbbthgYEVV5XEp6stED7dTvg+9LzgnLM5fvBtMZe2e
	L2qfvHQnK5u/KIla7zjIthpioi8qL7bRDfas44HB/q4dYpSAS/8O9kaTytaWu9A48/tPfX2iWx3
	MOCALjCuQdBJT7j5EQkicVoKM2CsJ4YEvxktvIS5a25DJ785KbxIdJP5MRdcfZyPxGw==
X-Gm-Gg: AR+sD12AR+eO4cFbn5xmWrfLCcfweZ7zRFHGmx9J9AhQfi7oyEGIuNCANkO6E+BQx8K
	g3G+fjY8rts7RmyIbXPMG4EDXzpMEtJcuH23re4l5h31llfh5mVA/jTm9cOXgHIjctK1GpopNku
	rfSCujALtvwZ9I/s7juk+t/6CaIrnugBg9lxW2r69ZWLNimJQCfsVvvffY3KBk+jemJVEepthcU
	bgD4nXh0yKZDal06t0woagkyoaxlrzM/SqQ5Cqs0xcZlA9wL4KlaYmKHHJpExnPS8SOa/kye9ie
	xBHwvR0Bznbvd5X74nXwikx65LVj1ybA7w9xPa/DckWQnoloWs58PqpjFLFfT0iUBzL4W4k6rgy
	T9iUN0miK
X-Received: by 2002:a05:622a:53c7:b0:52d:ea18:a9c with SMTP id d75a77b69052e-52e42379a61mr86020831cf.34.1787755986885;
        Wed, 26 Aug 2026 07:53:06 -0700 (PDT)
X-Received: by 2002:a05:622a:53c7:b0:52d:ea18:a9c with SMTP id d75a77b69052e-52e42379a61mr86020181cf.34.1787755986444;
        Wed, 26 Aug 2026 07:53:06 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e279ecaesm3060145f8f.6.2026.08.26.07.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 07:53:05 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: jgg@ziepe.ca, kevin.tian@intel.com, robin.murphy@arm.com, joro@8bytes.org,
        will@kernel.org
Subject: [RFC PATCH v1 1/8] iommu/dma: Prepare MSI physical address lists
Date: Wed, 26 Aug 2026 16:52:55 +0200
Message-ID: <20260826145302.449904-2-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826145302.449904-1-andrew.jones@oss.qualcomm.com>
References: <20260826145302.449904-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNCBTYWx0ZWRfX3KSJ1wGbyGpv
 F+VjrOIHppaCToGGCCRual/HbVL2ln9Tj7X67m0g+j/zDgk2MEsoHka4LPYqYM3XQ4+pmmb678h
 3FHhkcTOl2MXwP3a6CsvK3fhP9uHNQs=
X-Proofpoint-ORIG-GUID: pvKPwvHl0SYn1FZAQ5VpyuXzWXf1w6yf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNCBTYWx0ZWRfX/xGKugcz2XoG
 5/OmDawOcV3e3zWO6O8qtpOWbVMIDtTWsPwvWhMrSkFm8XEt+jsoaYp3HwFdcOQrSL32XdUp3Rn
 N381MfUbcoNcuyyh8YB11YYwcjIUKAUJVYELGhEp0OBn+bGgPjna5AyFHZ6jB5jdToIhm3jX2+5
 GJoU/NVkVnMPQ8E6Snz/MAeGIlRYC/EgnULnt9IkKtbMMDMcdlqQ+JgVCE/Sf7miiH9uv+t5Vqd
 EsZpCGrVIOy4u8Zt5J4vGpqmTe9dYaWAz64iEoS4n0xFmZwP5MmLYnRyJWZkSGd6LVM/BIAChTo
 u02oeq9c43aKdyJjLP+3XACiuscSnZprjLmvUWa5L1XgBu1ScSFNWXPvV0tEwo7FWVuPgcyB0Uu
 fN0nNidpGpf8Pw+zhsHQEXv2YuBQ+SZoSVFcl6LV+KsrlZdsNl9ytJsFQ4xep8lyeiJwgl5Wymy
 P3xrXOpEF2Qrm5dQ+nA==
X-Authority-Analysis: v=2.4 cv=T9S8ifKQ c=1 sm=1 tr=0 ts=6a8efdd3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=kJPfLSheDWDr1nFXzE0A:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: pvKPwvHl0SYn1FZAQ5VpyuXzWXf1w6yf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260124

Software MSI mappings may cover an ordered list of physical addresses
which must be mapped into one contiguous IOVA range. Extend the internal
DMA-IOMMU mapping helpers to accept an address array, address count, and
required mapping granule.

Teach iommu_dma_get_msi_page() to map the list into one contiguous IOVA
allocation. Keep the existing per-page cache entries and mark the first
entry with the size of the allocation so an identical list can reuse the
mapping without changing the existing cache representation.

This prepares for the forthcoming iommu_dma_prepare_msi_list() API.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/dma-iommu.c | 115 ++++++++++++++++++++++++++++----------
 1 file changed, 87 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9a07eb39336e..c256531ff19f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -42,6 +42,7 @@ struct iommu_dma_msi_page {
 	struct list_head	list;
 	dma_addr_t		iova;
 	phys_addr_t		phys;
+	size_t			range_size; /* IOVA range size, or 0 if not the first map */
 };
 
 enum iommu_dma_queue_type {
@@ -481,7 +482,7 @@ static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
 	num_pages = iova_align(iovad, end - start) >> iova_shift(iovad);
 
 	for (i = 0; i < num_pages; i++) {
-		msi_page = kmalloc_obj(*msi_page);
+		msi_page = kzalloc_obj(*msi_page);
 		if (!msi_page)
 			return -ENOMEM;
 
@@ -2196,15 +2197,41 @@ static struct list_head *cookie_msi_pages(const struct iommu_domain *domain)
 	}
 }
 
+static bool iommu_dma_msi_range_matches(struct list_head *msi_page_list,
+					const struct iommu_dma_msi_page *base_page,
+					const phys_addr_t *phys_addrs,
+					unsigned int nr_addrs, size_t granule)
+{
+	const struct iommu_dma_msi_page *msi_page;
+	unsigned int nr_found = 0;
+	dma_addr_t offset;
+
+	list_for_each_entry(msi_page, msi_page_list, list) {
+		if (msi_page->iova < base_page->iova)
+			continue;
+		offset = msi_page->iova - base_page->iova;
+		if (offset >= base_page->range_size)
+			continue;
+		if (!IS_ALIGNED(offset, granule) || msi_page->phys != phys_addrs[offset / granule])
+			return false;
+		nr_found++;
+	}
+
+	return nr_found == nr_addrs;
+}
+
 static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
-		phys_addr_t msi_addr, struct iommu_domain *domain)
+		const phys_addr_t *phys_addrs, unsigned int nr_addrs, size_t granule,
+		struct iommu_domain *domain)
 {
 	struct list_head *msi_page_list = cookie_msi_pages(domain);
-	struct iommu_dma_msi_page *msi_page;
-	dma_addr_t iova;
+	struct iommu_dma_msi_page *msi_page, *first_page = NULL;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
-	size_t size = cookie_msi_granule(domain);
 	static DEFINE_MUTEX(msi_prepare_lock);
+	LIST_HEAD(new_msi_pages);
+	dma_addr_t base_iova;
+	unsigned int i;
+	size_t size;
 
 	/*
 	 * Normally a device's default domain is only ever attached to that
@@ -2218,32 +2245,60 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	 */
 	guard(mutex)(&msi_prepare_lock);
 
-	msi_addr &= ~(phys_addr_t)(size - 1);
-	list_for_each_entry(msi_page, msi_page_list, list)
-		if (msi_page->phys == msi_addr)
+	if (!nr_addrs || nr_addrs > SIZE_MAX / granule)
+		return NULL;
+	size = nr_addrs * granule;
+
+	list_for_each_entry(msi_page, msi_page_list, list) {
+		if (msi_page->phys != phys_addrs[0])
+			continue;
+		if (nr_addrs == 1)
+			return msi_page;
+		if (msi_page->range_size == size &&
+		    iommu_dma_msi_range_matches(msi_page_list, msi_page, phys_addrs,
+						nr_addrs, granule))
 			return msi_page;
+	}
 
-	msi_page = kzalloc_obj(*msi_page);
-	if (!msi_page)
-		return NULL;
+	for (i = 0; i < nr_addrs; i++) {
+		msi_page = kzalloc_obj(*msi_page);
+		if (!msi_page)
+			goto out_free_pages;
+		list_add_tail(&msi_page->list, &new_msi_pages);
+	}
 
-	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
-	if (!iova)
-		goto out_free_page;
+	base_iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
+	if (!base_iova)
+		goto out_free_pages;
 
-	if (iommu_map(domain, iova, msi_addr, size, prot, GFP_KERNEL))
-		goto out_free_iova;
+	i = 0;
+	list_for_each_entry(msi_page, &new_msi_pages, list) {
+		msi_page->phys = phys_addrs[i];
+		msi_page->iova = base_iova + i * granule;
+		if (!i)
+			first_page = msi_page;
+		if (iommu_map(domain, msi_page->iova, msi_page->phys, granule, prot, GFP_KERNEL))
+			goto out_unmap;
+		i++;
+	}
 
-	INIT_LIST_HEAD(&msi_page->list);
-	msi_page->phys = msi_addr;
-	msi_page->iova = iova;
-	list_add(&msi_page->list, msi_page_list);
-	return msi_page;
+	first_page->range_size = size;
+	list_splice(&new_msi_pages, msi_page_list);
+	return first_page;
 
-out_free_iova:
-	iommu_dma_free_iova(domain, iova, size, NULL);
-out_free_page:
-	kfree(msi_page);
+out_unmap:
+	if (i) {
+		size_t unmap = iommu_unmap(domain, base_iova, i * granule);
+
+		WARN_ON_ONCE(unmap != i * granule);
+	}
+	iommu_dma_free_iova(domain, base_iova, size, NULL);
+out_free_pages:
+	while (!list_empty(&new_msi_pages)) {
+		msi_page = list_first_entry(&new_msi_pages, typeof(*msi_page), list);
+		list_del(&msi_page->list);
+		kfree(msi_page);
+	}
 	return NULL;
 }
 
@@ -2252,19 +2307,23 @@ int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 {
 	struct device *dev = msi_desc_to_dev(desc);
 	const struct iommu_dma_msi_page *msi_page;
+	phys_addr_t phys_addr;
+	size_t granule;
 
 	if (!has_msi_cookie(domain)) {
 		msi_desc_set_iommu_msi_iova(desc, 0, 0);
 		return 0;
 	}
 
+	granule = cookie_msi_granule(domain);
+	phys_addr = ALIGN_DOWN(msi_addr, granule);
+
 	iommu_group_mutex_assert(dev);
-	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
+	msi_page = iommu_dma_get_msi_page(dev, &phys_addr, 1, granule, domain);
 	if (!msi_page)
 		return -ENOMEM;
 
-	msi_desc_set_iommu_msi_iova(desc, msi_page->iova,
-				    ilog2(cookie_msi_granule(domain)));
+	msi_desc_set_iommu_msi_iova(desc, msi_page->iova, ilog2(granule));
 	return 0;
 }
 
-- 
2.43.0

