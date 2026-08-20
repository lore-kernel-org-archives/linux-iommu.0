Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424DB3DD866
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262120; cv=none; b=cAaU1+J9hXvSZ1BPhZWRIjAWv86jQhLcyY+Otpopx7W3xUKXjFBnbCaN5VDSAvvljmqKg9kxcOO0JoUmeTdNFr4r5nNG9aFzhW6ovoIvpaZQe1qaR6YAMjnvc0lx2GLY+kXuTrlI9O6quEAas0wAUB1EmWCZiMemMJRiW2r6mAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262120; c=relaxed/simple;
	bh=GKMcSeCiL0a3g2uOH9WSfrZlngJsKlX/8rmbuIPed8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YL1JJAjyhjxkJeKwX9eUCvSa8s+WTW7w4sqh/bC9QhzbXXaAtq/JSGHLMUL1X4/v05TmGqHQYjRndAAh0w5C7+/PO1NgOJoMZ/ky/O79JDbpeIyP2+L1alsE6wv0f6pPTaTPuO1pEy1hh4HHSsa6q53eK1DJQXNVb7+A/gFrRmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b2nvc7w/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UgXh4kG+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b2nvc7w/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UgXh4kG+"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK7pkA3941376
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=gu+JFGkyqPx
	/Q45IWTCbHOfkGmMO1gxqkNte7ZP70m0=; b=b2nvc7w/FnZzkiDM2hLfy1bSh0g
	j35Ze/etDBeZozYR10+jRRbwRyKESSUY0hTTgF7Q4IAxmwlcpfE+r5Ga1yVMeUC1
	X6+c6mjfZZDaxyUnb962DNPn2CqnKU+UwuyFFaLwCJhqETMyR450urlkC+472Zqc
	5ryBOQwZrUze4wrCDupHrOJlPPR7eS85wbjNCVFtqGC3XWOmpY12/44OxB7Iu+jb
	urEE+CFjMyv1m9sItfvHKhWEAag9bFXS8OQL7MXNwcNZXM+/R3H3xAs3AsZvPnJg
	EZ5aRezNc6vcMNfHU6gK07CCi08UK1amNJZdGHqnFbiQMuB2WfkSwVdnO8w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vh7uu8x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:41:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e52306621so31796485a.1
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787262117; x=1787866917; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gu+JFGkyqPx/Q45IWTCbHOfkGmMO1gxqkNte7ZP70m0=;
        b=UgXh4kG+/Q2cA7NAWo+ftUMY/IZuhBNCkFz47uZ+8nKTAfMAzO3afzjtT67rJXcOQ0
         RVS+CEI3dC+SP4gv5DoxQiusYc9FfW99YR7YxcRDtXztqJ+hGFeJSEB6u9SwT0W3b4sY
         2HsYTagE8NWpfnzTOPKEiMoS9tqn39zFGgqko7avCGCM9/bzLewaOAjicvGQOQFaDawV
         YVSqmQ6daIKuyW/uM+gG5dNbzK6YikWJEHbHykMlX8Elas7OUFitNBexVDkjMdvPVKt/
         e2D0Q5r5o5symObxzKEO3xR9FDUcU9vGhNqLEUSofw9rQ9y9Goq7PluCSXfF45dMkiM5
         bPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262117; x=1787866917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gu+JFGkyqPx/Q45IWTCbHOfkGmMO1gxqkNte7ZP70m0=;
        b=GaFgI36gG560L+EpNyF+bR1TEWrWR3PG4q/5faSiJDCvXheH91Cb73obU/e3X2itNG
         iJuZf2RKqMuFe8nEmMdMAlLp2m5va/Hf7aHBLgn8hoVOmWCijzmp54Cm6CW4j7jSN5/3
         U4Pu87ZLvzX1DtBkDRYMH8Ub+jpbXpvAH2RrCVHmy43/CddBjscVWjOouRXWkeQS0zYT
         Fv86OS6CY/cBNWFv091HdZC64tMhxrVsjxmMvSFpC7yTM/J419LNl4wE0z+HgEALKvPb
         ZXuojb0dq1UjFsc52vWKXuxHKbc9XGh5ULLHCffs/S8x9VrOQGMb820+jMh0LfbF9iPg
         AGJw==
X-Forwarded-Encrypted: i=1; AHgh+RrKEgZ/DwsF5oyajkJ3PwcKv0xqxIU92BQnUMmQnV1TubJxcl8Bkg9P6gPZVnnGZfjGqumS4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywq37gep6hFJmDJRqlrdTcn/N3V+fQcC4OVHdvPFA6lNHo7frEe
	NJK+4mjs4lO5HJVj7RIPqu6Z3TFubeAkS+Rmw4jbOxI7/EewIdytbqPiKPQgCtTRqf/FhOET5TB
	nkydoWf08KThXG5f4Ops5aFq020IR0fE8FQUlb27YgCFowXjk4wRR8dZ1rA==
X-Gm-Gg: AR+sD10R+n/cmf1BXbDwO1gBOFdv9/VcAEql8EvYThbS7iGZmN7WRmTNF/+hMCSR2bR
	NSuVKiMHOHnrj8aeZusSky5BbA/n5IDRETJorr4xUGV0CDzu+NgzgOHB5ApIYcYIsee8A//fIUe
	Gf2tvnPQnWFJXkE2/e6s7CnHytOAnmpiO9axvaMbH99k8ADyqrQkjsEIs3MkhlspbrETjMVKTzy
	uda0JkEq+VS96vRQqhaW34vJ+vtfAjFKGRDSEQwe0Qgws/WU8AhPcVyKpLN8Mk4rgiy6elxshgO
	lQVa3bHAHM0L32Hq6dIgiq3+PpVxIm6KSVAIUnGXHaSykHk2xo3vtRIjzSTcKxbWIi/IOZwlYqd
	RX6XdXjqr
X-Received: by 2002:a05:620a:222c:b0:937:2ec9:c98 with SMTP id af79cd13be357-9373942667bmr103111285a.5.1787262117418;
        Thu, 20 Aug 2026 14:41:57 -0700 (PDT)
X-Received: by 2002:a05:620a:222c:b0:937:2ec9:c98 with SMTP id af79cd13be357-9373942667bmr103108385a.5.1787262116964;
        Thu, 20 Aug 2026 14:41:56 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b91173c4sm5335855e9.2.2026.08.20.14.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:41:56 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Date: Thu, 20 Aug 2026 23:41:31 +0200
Message-ID: <20260820214150.545737-3-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX99GRW9Z+1KVE
 V5f7olpLE2w8RaV9yZ3sfM8Ai/pU/swA8kiDo738XS1DyW2Fm4q4j5aVgGexxqxPFSChRDofUpl
 sVUK50LajojOHHe3TFG92/znXLng3gfBltLYu+EoIAVDYACbsAODyTPzdrxSOdTnbqComorRhWf
 GzT7GRtFqkIW+7qnXVrdgkOIqi/1TXhCHLEk9Fjrpoa3DaGx2e4tJOzUe8po6dZqIu4ATURwPlR
 mWuFJsBP1HQR5rRkAK20gbMhciVNZzgPtjUEf17WjWqDVCV1luKQKJPezgUKPShfSlVoe2/KoVw
 rXWj/7Su65DT9cv/9EmK3AIuZeEsZtL/44jRnhEqMyTyYBYYjw9/YqlGIHnZaWDt6m5hFwLpWQ4
 RgsLp2/scl0PMJgo/lNZBaubVslwOa2SHdRQzMPlizVogr2UcQk4+tSMFMWsTyK2bg9Ht3+oj7v
 mV8MAJULXIDSUDv5dCQ==
X-Proofpoint-ORIG-GUID: rDyEIPKfV1ELZpFA6mLs4C102APmqjgn
X-Authority-Analysis: v=2.4 cv=Y7fIdBeN c=1 sm=1 tr=0 ts=6a8774a6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=5IMjXt7tboKol454yg4A:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX6NQpV4RLSvlT
 nt6UJuvmlijk41AhZLdKBr5Vv4fY6Ey3TpL55+i0tOP3OFXo+n7LIgLvn655sNiIwAZXnTyj/e7
 dku+TuaxtauC41kedxRb3JBvdL2U7EA=
X-Proofpoint-GUID: rDyEIPKfV1ELZpFA6mLs4C102APmqjgn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200162

Add a descriptor-free counterpart to iommufd_sw_msi(). The existing
function is tied to a struct msi_desc and stores the result in the
descriptor. This variant returns the IOVA directly so callers can
pre-map MSI targets before any descriptor has been allocated.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/iommu-priv.h     | 11 +++++++
 drivers/iommu/iommufd/driver.c | 60 +++++++++++++++++++++++++---------
 2 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index aaffad5854fc..f60373cd2f70 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -55,12 +55,23 @@ int iommu_replace_group_handle(struct iommu_group *group,
 #if IS_ENABLED(CONFIG_IOMMUFD_DRIVER_CORE) && IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
 int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 		   phys_addr_t msi_addr);
+int iommufd_sw_map_msi(struct iommu_domain *domain, struct device *dev,
+		       phys_addr_t msi_addr, size_t required_size,
+		       dma_addr_t *msi_iova, unsigned int *msi_shift);
 #else /* !CONFIG_IOMMUFD_DRIVER_CORE || !CONFIG_IRQ_MSI_IOMMU */
 static inline int iommufd_sw_msi(struct iommu_domain *domain,
 				 struct msi_desc *desc, phys_addr_t msi_addr)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int iommufd_sw_map_msi(struct iommu_domain *domain,
+				     struct device *dev, phys_addr_t msi_addr,
+				     size_t required_size, dma_addr_t *msi_iova,
+				     unsigned int *msi_shift)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_IOMMUFD_DRIVER_CORE && CONFIG_IRQ_MSI_IOMMU */
 
 int iommu_replace_device_pasid(struct iommu_domain *domain,
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 9b9316ae4266..69b3dbcbee3b 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -249,15 +249,23 @@ int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
 EXPORT_SYMBOL_NS_GPL(iommufd_sw_msi_install, "IOMMUFD_INTERNAL");
 
 /*
- * Called by the irq code if the platform translates the MSI address through the
- * IOMMU. msi_addr is the physical address of the MSI page. iommufd will
- * allocate a fd global iova for the physical page that is the same on all
- * domains and devices.
+ * Descriptor-free counterpart to iommufd_sw_msi(). Maps an MSI physical page
+ * into the domain and returns the IOVA. Used for pre-mapping MSI targets before
+ * any MSI descriptor has been set (e.g. IMSIC doorbell pages). The IOVA is
+ * global to the iommufd file descriptor: every domain and device using the
+ * same MSI parameters gets the same IOVA.
+ *
+ * msi_addr is the exact byte offset of the MSI doorbell; the caller must have
+ * verified it is contained within an MMIO region safe to map at PAGE_SIZE. If
+ * required_size is non-zero it must equal PAGE_SIZE. @msi_iova and @msi_shift
+ * must be non-NULL.
+ *
+ * The caller must hold @dev's iommu group mutex.
  */
-int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
-		   phys_addr_t msi_addr)
+int iommufd_sw_map_msi(struct iommu_domain *domain, struct device *dev,
+		       phys_addr_t msi_addr, size_t required_size,
+		       dma_addr_t *msi_iova, unsigned int *msi_shift)
 {
-	struct device *dev = msi_desc_to_dev(desc);
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommu_attach_handle *raw_handle;
 	struct iommufd_attach_handle *handle;
@@ -266,6 +274,12 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 	unsigned long iova;
 	int rc;
 
+	*msi_iova = 0;
+	*msi_shift = 0;
+
+	if (required_size && required_size != PAGE_SIZE)
+		return -EOPNOTSUPP;
+
 	/*
 	 * It is safe to call iommu_attach_handle_get() here because the iommu
 	 * core code invokes this under the group mutex which also prevents any
@@ -286,13 +300,7 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 
 	ictx = handle->idev->ictx;
 	guard(mutex)(&ictx->sw_msi_lock);
-	/*
-	 * The input msi_addr is the exact byte offset of the MSI doorbell, we
-	 * assume the caller has checked that it is contained with a MMIO region
-	 * that is secure to map at PAGE_SIZE.
-	 */
-	msi_map = iommufd_sw_msi_get_map(handle->idev->ictx,
-					 msi_addr & PAGE_MASK,
+	msi_map = iommufd_sw_msi_get_map(ictx, msi_addr & PAGE_MASK,
 					 handle->idev->igroup->sw_msi_start);
 	if (IS_ERR(msi_map))
 		return PTR_ERR(msi_map);
@@ -308,7 +316,29 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 	__set_bit(msi_map->id, handle->idev->igroup->required_sw_msi.bitmap);
 
 	iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
-	msi_desc_set_iommu_msi_iova(desc, iova, PAGE_SHIFT);
+	*msi_iova = iova;
+	*msi_shift = PAGE_SHIFT;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_sw_map_msi, "IOMMUFD");
+
+/*
+ * Called by the irq layer when the platform translates MSI addresses through
+ * the IOMMU. Wraps iommufd_sw_map_msi() and stores the result in the descriptor.
+ */
+int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+		   phys_addr_t msi_addr)
+{
+	dma_addr_t msi_iova;
+	unsigned int msi_shift;
+	int rc;
+
+	rc = iommufd_sw_map_msi(domain, msi_desc_to_dev(desc), msi_addr,
+				0, &msi_iova, &msi_shift);
+	if (rc)
+		return rc;
+
+	msi_desc_set_iommu_msi_iova(desc, msi_iova, msi_shift);
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_sw_msi, "IOMMUFD");
-- 
2.43.0

