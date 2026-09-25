Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6074C150F
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349438; cv=none; b=WTben9zQ7c5HN3xUcG0mY/HPIrIf3ST5NnpdI3zZPxfysGIWA7fcpf0ntqsz/7Ok8ehBdYSgJPzKz1hQgofjOuYeD5o6Fvn96/tzaaq7TP7Rud6isPuJoEKG80TQefeQ/hmxogjycUWlvwKttSqpUXR2dreEbOblcH3LV4Stf8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349438; c=relaxed/simple;
	bh=Z4KbGGHbIopPmkQPTA+5W2fw8gEPO8v6yje46iBjdmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLrAXTgeAn8G4onUe3mnzZHkoNV46njXgbP160V38yZjDdMM1Hj2ipfWGc79G4MBgBUNMcaHTyveMzHXyiFAVrhG7VcWSY3JRJAhjOqkiwsgDn2qvgTqMoKYSBmB06XSuLIgxwB89QjYSon1hklKMFUMjfD7sVag2pda2iIKVpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dNMUMWhL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e3nHRQry; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dNMUMWhL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e3nHRQry"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PDF0ZM3532135
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hEPKavc8j9V
	N94Q3baQAu9FNMxrJyRmn7Q8gFTEEhzY=; b=dNMUMWhL9s2tbL/mWLkBj+9XARj
	HE+G1BO7uzXxS5tTiZqW2ouCNsR+6HxGjcDXfeSexVJIUOgEf7VmE6LLOUoncHka
	vVfzCq8s2diX4TIKA519jd9BMS6Gn9bPFn/ieiq05tMDYBHxAAti0h4J6XT0y2xC
	F3bJ7WU+2g9nOZ80MlnVA85seqJvYyHWE25sPaUp9VQUF/5bEZ2mdTP935j4Kmzg
	0euS4816jwBwes3EGkxEX9LKi1ubcnSPrGG/ChALgaMo0o6tT0mVopI9eDBwaz8A
	th7EQSgzln/+kOOb7s8JthYgupT0/1Iqn7R+aBZmf/LI8R1TcIVdFNz0kkw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw94kbs2j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:05 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c96bf59c31so240937e0c.3
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 08:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790349425; x=1790954225; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hEPKavc8j9VN94Q3baQAu9FNMxrJyRmn7Q8gFTEEhzY=;
        b=e3nHRQrymRmeXZVVNtEvclEuCFWmXDGBYbIz+rcpVHreZcfd49C6xAUp1tmcSj8vL+
         hfr4ie+NhMlMqRk++FHM99lEHeBA1YZYOpIP7jE9fcS/ZldtzM0ySIDYy0Bj8B/H2BYV
         KDBkejfv+GB/iNUW1Pb73RVpMkw8mpKRz8QzJy50JitmUX1CukINlbBFDyO3fm1uOZ0v
         B2phLxkLlDfpluNv6mMXnXHdxZpY0VsMd6i03ha/4Tan8LUUtZaRjDb20s95MDugBJmh
         gi3KwkTF0Ica58pYXd4zW009VFrQUWXhsbvfiQZz1GXNO3j4xhF0X+zKFKHjBILOBJuY
         BarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349425; x=1790954225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hEPKavc8j9VN94Q3baQAu9FNMxrJyRmn7Q8gFTEEhzY=;
        b=yFkY4OgVKgZumE1khHgrT+U9dph8/e22GSkZrrtUchUJJjr4VMdjfoKsCpsGU2NYnc
         shW7katHRuPCojbQX8Vy5qSXKDAbPko5sl1MLjP6CfJyDlo57qFEtEphlz6AUrQi/51T
         yErqhq+OWLunYOy2FJMHXPWefjRMF3Ledw67M0sVNcmm+l5VAMvMI+AOHfd0X9FKfwkl
         xx61jzXAHDIokPB8HAlrqxFbxK4GMvdVb3l1wkxDUBJVP5fw2lpNOTNGzE/fdtNpfeZK
         XbqL3btEFirBomoW5p/8GSATRcvYdmSdarnAhf3nUFU+ESRM/9UTGykA+QOxUEXC08O3
         rJKg==
X-Forwarded-Encrypted: i=1; AKwUvByjLK4PuRVMBxrA7wIL8NZ5YEMjDpkTi509EPyjdJ5sT7L446KLvc+v3IgcMJ0tiJoIu9NhIg==@lists.linux.dev
X-Gm-Message-State: AFuF++nwJHDvChghIaMJBV7neqR3aHzRGWA9GlrOAOCORwL6y/qYbzle
	Pd1RNCPDYfEvwv4SnremoI+1BDiYZs4/HmkTYCVrMTnFtt7WSv65BMNiDjUb1CBSK4bixa+3kbi
	gsR5BVKR/OklS9zUzLJsFaE50c4h3woCefIswE6uh+lsoadUl21B7ACJpXA==
X-Gm-Gg: AYBFou3miXFYwQXAHdNOD4B4Xd/QBi3F6oMDhWT6AQVCFN1mxvduFVxcRYSBqYWnldm
	ZMA4N2njF/GAyBABBFQIOyD7gO+jZWzf5lTx9By+qroS09P3HGw7KnwNVJTTa92ZjX10lUdY95C
	izI4wgK6RmTExr0VPCREaUFfhP1WXNYWvkJQbgtMSB/T5ZDcF2T7FBvMYA+lBIxCMIjpayvD0Cz
	WXs794Teo7VyUfSnt2q1SH1cBWzEFS4L7k3XVv8kn8dRaZOdACyEJKf+dV2Zin1iReMom+ugwP8
	sCUyYSqHxT4YqSUU3W1i9lslH+zhjkDGVGXtdNrCbYKmTf1VsAVdsfRIzOtNz3tV8dJdxC6M97q
	esNy8c3fjb5+MVC37vk9+DwXH/NCxDg1HODiBdw==
X-Received: by 2002:a05:6102:61ce:10b0:7b0:3c13:9f09 with SMTP id ada2fe7eead31-7b03c13a338mr986713137.27.1790349424627;
        Fri, 25 Sep 2026 08:17:04 -0700 (PDT)
X-Received: by 2002:a05:6102:61ce:10b0:7b0:3c13:9f09 with SMTP id ada2fe7eead31-7b03c13a338mr986689137.27.1790349424108;
        Fri, 25 Sep 2026 08:17:04 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff21d6209sm30158645e9.4.2026.09.25.08.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:17:02 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v6 01/16] iommu/dma: Prepare MSI physical address lists
Date: Fri, 25 Sep 2026 17:16:44 +0200
Message-ID: <20260925151659.419512-2-andrew.jones@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=aaj0Dhot c=1 sm=1 tr=0 ts=6ab69071 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=SRrdq9N9AAAA:8 a=kJPfLSheDWDr1nFXzE0A:9 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: -hPjMheNKByPVc4nDydNPZrhz8s6WqnA
X-Proofpoint-ORIG-GUID: -hPjMheNKByPVc4nDydNPZrhz8s6WqnA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfX1WE5bHSttpiF
 AZT0lb29+G/h2Kr/fZtBYUMAKgnsgWeYsV5yn8zr4tfdUQt2SjR08cmVHRCpNfdyHqDXmZtDTr8
 WuujOe8e3+zRS6HVY8gH3jHxBiLXP3gBEPlLDCD3pDWiJIbs57S7RoYCwCpyGB5asJrZXEhGiH/
 doYPGXjhnJc+i6DpkqAkKCAyXUanJeVNRhpfLshDB6KBH5suXsLLGB1xRX8Na8amZ7TO8Asp77s
 pt72zRxmLIVbBwQpQ86/9sZQI/AJe67jKc5pj/0cQVAETJAjayt++/CidITSdeGJYIQR/1KySml
 HHG2l3RCxNcAs2ADg2QqBNa/4QQJlKzbT5L7qi87AtIE909+/Z24ZyYl/N5rguZrxBzsijW4tYd
 p8uCkRF+YThAYLq5Mwv/mJZ+cZAh7HKfAcYfWmf5JZcbaD0dA2DXs4VYzsJAOg4ZjPwjkarZLT9
 gxeIuF5KsHMQVVPls2A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfX1M5RLCLIImqE
 x2Wb4pyexlPl3U8PHm1oo+qKYL5nN/hznRIxISTmZujj9MROVLtEivboo6qQ0sUWYlKHJI27rgE
 dNAAW+mG+MyN1XUMOF5wX2HFiutK5tg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250060

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
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/dma-iommu.c | 116 +++++++++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 58c624513cd4..0b4eb47d1a95 100644
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
 
@@ -2191,15 +2192,42 @@ static struct list_head *cookie_msi_pages(const struct iommu_domain *domain)
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
+		if (!IS_ALIGNED((size_t)offset, granule) ||
+		    msi_page->phys != phys_addrs[(size_t)offset / granule])
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
@@ -2213,32 +2241,60 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
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
 
@@ -2247,19 +2303,23 @@ int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
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

