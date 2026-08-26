Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2F744E67B
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756007; cv=none; b=n7aHLwi80Texajh73qKQgATFQzR983y9YkXBJHx9rdFlLqB5oOj2mDBy/U9tW13TyvJ4b7Tz0vh564cJNHbKLv2GCvHy7EFTKoOcFi2gbgVMgj1zEGQrPkaOj2Brw5NcbxQ+TOQ5CNLdvw4ANEAcHEnZGLOvKsP3JsjPXw9tdt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756007; c=relaxed/simple;
	bh=V25ZoZOOM+iQnQ7s9sp/mqlUFiZqVTAGKqOxRxkmfpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5vMJWTB+RyPB/lJ9eg8baPKDNNlGJh/Pg5soJ1AxxG8JleUhstugoxQJYMBJ0FIe5u5V8AraX5AAdxajvMR5t3EcEow3mP1zJ83B6DMQ6lngRsrI7gKlzwbjqkGWKSaYBD9Ak31qRRsWdAgLrP/5YxLZd5k3NkoClZEx0ueXN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pw+0ih98; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=knPiV4rR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pw+0ih98";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="knPiV4rR"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QDudkC2148753
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7zF3yjH2A0V
	0IwLV0gGI/y8+83CFXTUxlEKRpvlE7xU=; b=pw+0ih98eFFhljQoza+hyeonXFh
	/Yh5VCT5glnCypReF26mMOoYJohvis+ELEc/0yqP2Bb5QhMmBWCBWxFNmIFGEXOE
	4ji/MHgqhUMKMtMyyRt8SCCGV1INWnRzQplom0lqoJ7yjY5gh/SEbnEBUn7iQIrE
	7hPyA0w1FixAUOp7sMhu9Q5wS5cA8SWS34LIWhNG1QP5WShP9GE0Q8pkSD9IxgAW
	t/xOiNhi+PT75irMSfFsBqyP8WZs9PwpjzwGuuErbGX5QPvmlx8B2dO3cxI/th15
	KnTy7ejr1zekkBoqLtgbnbg/9aL2e/HEcdFVdr2Q/CwME2wntA2f1PA950g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9uq1ssrr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:53:22 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c01ff996dso10180481cf.2
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 07:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787756002; x=1788360802; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7zF3yjH2A0V0IwLV0gGI/y8+83CFXTUxlEKRpvlE7xU=;
        b=knPiV4rRsVGxO1OiBVT6/8hObtxCMuzX6UFtdoU4Aac3LvRuEhApToZTpY3+ixkVOi
         G3PIY008bd5ExPITBmVS9zmOvuCywzJOJRryE9/F2ud6MExvO8/yRxJphBqpc9cak75A
         WbEOTD8Jd4Qf/4xm1zb7PM78ALG31ioYJFctLtI/z7i4ErefBA85rxB4twT6XA3aWE0u
         CmvIi4QKv2Kq5jCYBuoBs8fY73dUHNsMW1tnmr2RDm7x8Av0IvdOFJKDI+qmZY0C2wrm
         anBBocmQP/lzeE5B2tYOYEVTRCgGA+oPkuzI399lpqqFZ9AIZRh6nSCEH4oWugpQ6DRl
         k8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787756002; x=1788360802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7zF3yjH2A0V0IwLV0gGI/y8+83CFXTUxlEKRpvlE7xU=;
        b=hGOYlgLghB4Jwpk0TQZ+7ompW0yvIGMxOZmhttrT9Rn8QIdWizNiD/yi2AXE73jaGQ
         LqM2m6s4pyjBOTwvR2TwjjxtlSz3F64ib1Y8weDzmR0K45C44S/O0vx989fVGbusgFlf
         +XdR2qz35Tm+LTBzRjtY4l2xxOOC3NjlLKbDwM0E1uh7ZO+B27gFfL6GOvkutey6LyEE
         mzSqlEBHz1lyXMu5pVj3/uAquEMGr9aPP2uUHSQ27ly9/qLCUvfTjm/SJSJYiE0slov0
         MsEHEcaE1Qe+RSRrCFdc5LQ6engaulnPpw3pP9KhYVZ/DYuEliNJ/I8uGVanL5hxamjZ
         iRiw==
X-Gm-Message-State: AFuF++mkJceuKkVhn9oOjxEf3U7bidLJmKJkMluw8VOgC2ipjYBJoLFx
	VfwOdDLYSmSE+U+sgtFVIACGh/hGhlwC+DLJvDMEWTb0IkPa1CKChIKEGxwLuaci433DlE7x6qf
	mLMujcfBBQCM9+a7tty1+ZpEv6TVkk7Gb86hEl7Ua9MZoqXh0+4xXcAm2nnNCHqgxOw==
X-Gm-Gg: AR+sD116RLx7qKmSnrIWIwHLRpJ2+hbgOS2brjhgjPHy6eDyiKuDlnKAloLx/IK5QNU
	bajyTH1FTQs5TCuJWw5e0o61Zi7vjJLnV46VniIua7qAzUvjhbiWi1xDqvTi45bQKMhtWqCzLeW
	TIze+Q2J3HFKaCqAzg0N2HALEy0z1Piw0eLYXEFgj88Mb719tZ8i5HnlJ17gux6vdqy8UUnvq4N
	G+CsYa1MkRj86caYO8uqCBn/WE+kBrgH/6mXa2ZS42l1/9BBQL4uqNRhjkbEWLB1ybssMBx7+rU
	2DUy90BiwdXqite69s8E/r9QcMM9bjTYrDoJWlk7k0uMDPqCM0+JDqNMI9lDuU0lewcBgCoHYtm
	crS/Y0Kzp
X-Received: by 2002:a05:622a:50a:b0:52e:2d78:60ef with SMTP id d75a77b69052e-52e423221bemr73631181cf.23.1787756001574;
        Wed, 26 Aug 2026 07:53:21 -0700 (PDT)
X-Received: by 2002:a05:622a:50a:b0:52e:2d78:60ef with SMTP id d75a77b69052e-52e423221bemr73630001cf.23.1787756000839;
        Wed, 26 Aug 2026 07:53:20 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dd56dfb8sm17426825e9.3.2026.08.26.07.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 07:53:19 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: jgg@ziepe.ca, kevin.tian@intel.com, robin.murphy@arm.com, joro@8bytes.org,
        will@kernel.org
Subject: [RFC PATCH v1 8/8] iommu/dma: Introduce iommu_dma_prepare_msi_list()
Date: Wed, 26 Aug 2026 16:53:02 +0200
Message-ID: <20260826145302.449904-9-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-GUID: DjUT4Tkpm2gAaktj5v5U-fpcI7J8Clxg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNCBTYWx0ZWRfX6OS6IH5IK9Jl
 XL+ecf1LYmocN5HdnXsUlmK1aNrSOoLfQ8gcT7OEsw3H5fnR/rcg9Nd6l6hDfw4aykwkTb88qwC
 0XyzZHPB/k/FrrrBcKfiPXq+gXsRClleQ63ZGfZL/EGtX31fc/0i32b7481kyQQW9JlxdTvSqmv
 aDMskymXQl8Lpy3Ygj1mGo8EsfPuWdiTtEvlY6RGSzrSAcvXO5ru0D/IKZOXocMtB5CGLqUYK4F
 thQ51gl7Wm421fKPfy+lQi7le6u6BGH/IvAS8Dnuo6N0C3dj9G4+daCzcZQebLVpZtn+ZEEMbav
 E5ZKC75sfq9lXyH/yufLOHoGuGxPCxV6pyo5dGKNyQPezS2FziGsRGqRq1x/++lrglgjh8re/LS
 BEQ3ShrnBuKwaCbucu1tHBmCgNXXwWbSVQDWfdeDgKl65XkhLMHREAb+FIIq5XxjAxlXWKTSRkt
 FHCgYMCV45KC8f6EFcw==
X-Authority-Analysis: v=2.4 cv=Y77IdBeN c=1 sm=1 tr=0 ts=6a8efde2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=2ceW4JgIosI8Fxwmn1gA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: DjUT4Tkpm2gAaktj5v5U-fpcI7J8Clxg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNCBTYWx0ZWRfX7mjKG9AnWohO
 pxLr9SLXkiYBr7lF/O1ux2ZxdR3KXG1G79G/l0BpaSBFPd1G9SZk6OXg+w80qefTA1odoH7TpEt
 Zocz0cAxR4FBZdsDUwp3XmjGCp5b0HI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260124

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
index c256531ff19f..0699785adbfb 100644
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
@@ -2303,23 +2303,20 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
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

