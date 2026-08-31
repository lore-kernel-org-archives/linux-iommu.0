Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B1A4A5C50
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188391; cv=none; b=L90UR0vew1u7Iw/fHQHt69hxyleBpvgrjrEF6TXufTkrpCHuzqBbeq4+NOX9evP4B5FDjKJks+DIW0V2QFJZJ1VFxmWFTgozlemvjmSLkvLt7i1hg6/pTYQdqbaDqcB9TCptGUqXNSnpwWpVTJy/++WEfvo8oJKzPZ5SoX08kCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188391; c=relaxed/simple;
	bh=/ijFACOXO4KJuqu0/jkjSkr/3WZZg+UEe0EN8Jrzfi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTzUOdiNrc55/LC3dmwpuo9sPH5iPrL+/8js3QqJAdLNJDx5+6GncGrCFfDZel/QQySr93YaEaYfkgDNQTJwX0jyR9gH3Ya5/WROFjCvU2LUwnUDs6dHMcjGLqiotyk7bvVAn8OL0Gt3/0/tJ1PVNmZtAiF/G0m1+fSRDS/+e7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SGDMOb2a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aJ6CrY95; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SGDMOb2a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aJ6CrY95"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VETRKn3703699
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 14:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6RkO5qSbU6o
	yY3PEkq3YPDDTYFB2jarHRGHy9kSvaIA=; b=SGDMOb2aqN+2Z5l+7Mzo8nMO/F4
	qcsJvwkuxeP633TU7o9U5eMNVJRTk/uew1loJ1ER2De3nnARJ0vQI4KGSZA+5ysm
	o0CzMILXUmEzYke2kxVaGu0eULx5k/SVrLz8rDjaAEUSPCne0bm/vx0UXEV46/RS
	FraYkLHIzdpJwYD7WC4uQQX/iIL1jcwbX4IyPW5LSfpsEN4/m1XCJ9lLD3l3ZvOD
	AqvY7jNYyNCXB2X86vXh+6NGCnEds+zsM1uG/Qha8BGqMjLfPyyCHdoCd3BhDUk2
	GHzOTVq0CRp13/fr6y5KQDX15soB9cueYiNU1Nx41n3LKQKa8j6Km1pXOmQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6yasc6g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 14:59:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-930b571432fso514107285a.0
        for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 07:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788188388; x=1788793188; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6RkO5qSbU6oyY3PEkq3YPDDTYFB2jarHRGHy9kSvaIA=;
        b=aJ6CrY9537kl2VMp08Egm3mI0WzY9R4sI1+bNj+YZ3qj1sSLO0QQGnnc+idQa7FN04
         yrjePLcF4C/Bfez1aSALydjSctN/Cc8PiAIJKRUopkmjLg7GIRSSUhmI+F6vrlfKPzr2
         aSveMMehwXTdvrXunee1WlbWNTN7wDOxMwbsyC3mwJunRiLppd6IvO7ff8U4q5mF+JH3
         atyHUFQB1Ob7Zsq01QP8b1N2707n2L4f71RW1VxQGm82E57CWEh6R3cbekHBiXqJJbuu
         VbE57QzRkuLAeMKhJAr/ve0NQSuo64dhPT5vUFTRePCyxJrJ7CbqP2ckBfrkhiyemlHN
         qmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188388; x=1788793188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6RkO5qSbU6oyY3PEkq3YPDDTYFB2jarHRGHy9kSvaIA=;
        b=UHEsEFnrl3vXPG1lZpQXK9DI43a+wnl0km/6xoGQ+aic7Zb4H58p5G9KhwlLgl0u5i
         GOk21EFKlVbSuFQb8MFh/yaWOlCUUBo/hxLb04EYphd0XLhtcYVZ8P/wkuteKXa9/uhZ
         Fec12joJmSxk6RMOIt+lvTpECAxXwGamq6z+if0x7ucIEK+3BvVkotuHZFrOfDlapP0o
         PRd0A0ygQnfFWAaf3KPVi0UBJi6ZeUe8wSjJQvEZPoj6Ou8IVscXMIgqrbJ9ociakaca
         aoH7dMQWSsJsIdyC6dvzLMkTuoa1Da3Qu1aDIodx+u5vWADX+ydzvjp8gjBe2MaAzX1h
         sfWA==
X-Forwarded-Encrypted: i=1; AHgh+Rpo76xfVxTPl1z7eMYYHlgxSuC8he6DI+Y1j7hFYQXsC/fgZ4FSMTHYkHaCXoZ//GAwLAZarw==@lists.linux.dev
X-Gm-Message-State: AFuF++kIscALX3MQTh/HBhp2Wzw4wi8oaen0/qbzJCjV7gauSNz7mvg3
	tC37KI0anPNq1v/VroHoTPoqsw6hxE7sPxnWyFkjSJF7vp3F9D1p7i1B49NWF73lTeObiKaElai
	wegXw1FxVCKeZeX7QNOWmUyCGzQetU3EAgxKtz1Du+hvLTqRvrkxC1LGmCg==
X-Gm-Gg: AR+sD11lrcbOex67KfTpbB+hUPuUnWJBE1xr2G3liExHnYOG2PignVvcT+ABro3OB40
	Z6AGAgJJdEOU+X5meUGp8D5gITVtPkwSQdtXdHS7TsFdA1t0eDaCuyfw9+7yxw6FbI1Lh/DR+Vt
	gESNw3awzqE/cRO1uyup4OtodyKDHNqTbXZLVn/dGBCRPPSVTAfm9dmv/pCsIwtSVdlK4cE5NOs
	4OmGrtHpo41YpSJSth6KpJQIh0FHBoNqhTguszOEukbRGrrY2B5jfPl9cUljS8um02SeFraeQdh
	ZrHzBbFc3etplvoE8tONr2kPtU4Yaj/fU9+NCpeFMumIOXa+ZBUZDEHJgl9emYCxXL/khbf+ElE
	LR+beJMtMlz1eeCHduZqB3qLaBPRSL0gkXkc=
X-Received: by 2002:a05:620a:1b9a:b0:939:cb6:997c with SMTP id af79cd13be357-93936cbe952mr224772985a.13.1788188387519;
        Mon, 31 Aug 2026 07:59:47 -0700 (PDT)
X-Received: by 2002:a05:620a:1b9a:b0:939:cb6:997c with SMTP id af79cd13be357-93936cbe952mr224765385a.13.1788188387028;
        Mon, 31 Aug 2026 07:59:47 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4843ce8b015sm6235156f8f.13.2026.08.31.07.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 07:59:46 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v5 01/17] iommu/dma: Prepare MSI physical address lists
Date: Mon, 31 Aug 2026 16:59:27 +0200
Message-ID: <20260831145943.313726-2-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfX/zLVU/0x2E3L
 uGGL6tl39dGT3rcbP7Za0ZlM2kblRP6XDyqj/RELXAgCAIThseNXyOvrcylXeLAu0Ld6PUKDV9g
 oXG0aPYrJex9GzkitY3REMcYjKZ7yX0=
X-Authority-Analysis: v=2.4 cv=CpaPtH4D c=1 sm=1 tr=0 ts=6a9596e4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=kJPfLSheDWDr1nFXzE0A:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfX8HN3FOsH49BY
 lSa+xvgJbpUO8CmJusZPb5jopn8geedlXd3N2pudgDsRiZnSko2w4GPuGpdPFmgzEB0DTAkoLlR
 rJQY+FEqbOQt+vt32Zz/is2A+g5/MBOCJBDo8IFtNpIq/U5IhsRRXSySugQuiQ8P+HnaG6/jqFs
 p5e/ZvBFgQ5cQ3oJ9ZifgKZMKW8VumBlP3MfC9V0CkVmQYjuhVGOFR3w36qOTs+4imr2ts3gSPE
 M8xy/9p4Spdh1512ZtoQOvthqvH9XAeVcfVbx6U2Y8lCxPEoXLPiGJN1U9r82nUfshX2bxidegb
 Pk1HxvslQslPZ6r9JPIZeGnSHvwpS5lARk/tRvOaZMeSyg0Phsvtp6WZWTIPbHb47RFA4LT7KJl
 DtSMhi7rjbqs0Jo6OKVTXGT7ULC20Tafb5tfAfogQFScOOuv/fltT2xSKQTrINW7Qil23sUqHpd
 To3yS3CExRvVmit63EA==
X-Proofpoint-ORIG-GUID: 5l9PLfZYONQUp3S05wrqd64-E1rA6xa5
X-Proofpoint-GUID: 5l9PLfZYONQUp3S05wrqd64-E1rA6xa5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310129

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
 drivers/iommu/dma-iommu.c | 116 +++++++++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9a07eb39336e..38a0c4e244d6 100644
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
 
@@ -2196,15 +2197,42 @@ static struct list_head *cookie_msi_pages(const struct iommu_domain *domain)
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
@@ -2218,32 +2246,60 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
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
 
@@ -2252,19 +2308,23 @@ int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
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

