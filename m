Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD25441639
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905955; cv=none; b=iSWXR9wfM37GNgrJujAwI+oCjcZtz6+s4NSOa07CyzIjCzZj8na58ZxBR3bAoPNPPO6Mac1aS1guqfCwe3ZEO5FefrqZHfMEkPbKn2ZNAeXR0SktpxJVX2rW+Comshl1sARyYT+RcbiciAUrNnIOz23KgcpauV3JQDgfGTjKgfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905955; c=relaxed/simple;
	bh=wq9Trt97hXHorP0uRYc73Qz51T2ARO4daJeyj5QyHFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgiBOH1Jc9oJoM7yUdr6mHEKPle1e3ioeG+T/xzRqB4+9xnVTIqWqnjhln/4nYCa8pIZoPinbRU0kz49IxYKF5qcxQSTyurc5unYl/OtshdDSgqYmkjlSlXPUGiRbNScSDQGFbZLumYY7pNW+4Z9lAfXFXYVcc6qHbKRI/ZKCMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PKN8maRd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LtgyQ1Dd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PKN8maRd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LtgyQ1Dd"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbVvG3308733
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uJ2U10c08l7
	aGrL85yzaPlVtXbri90BVENteR8ldZ5k=; b=PKN8maRd1+bSa+vxXWN4mlVWyvb
	w1birrs7Yp0ohf5fepCW43kFCvfL8PrfIFJg/xGaoqUIv2vo4ZhETq5vkFgOyeR0
	SUDlScIfxtVDs/AdruQsY1EV0oPuL432bW9iPRvjPUbmBI54qHRA3KsCTJcWuwW6
	D0RSLkReewgwNHsz8B/SgKsgHk2Gjwoy35NAwAzWVQBJ9cj1+8bLo2NywT/h5GmK
	eLEU6WpBpbWYimzphhRDEesZzsfQetOt4hnnRkiFhyN++zAab8XJBi7FZP2VgzDA
	x5ZAkVmjxjA6YjcV/RSPvsFUilEJx5IvhGF43hMRBPy8GBkETGvFJ07HAtQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fktahujgk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:30 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ef8249f871so8393466d6.0
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 08:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784905949; x=1785510749; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJ2U10c08l7aGrL85yzaPlVtXbri90BVENteR8ldZ5k=;
        b=LtgyQ1DdC8IZw3ysIhIbhXtt3+kQhKD0sdxS9bJWCizB0pUIhKKWV4czz5o8Z95rFn
         sU0tYV8R30y6gNL5Rcv0YB6kumiwogca4zx0NqzSZvVNVOv61+hlkZrLd0wALrg3yxOX
         BXul1Or0/EsUhu/ns05Uw6mhKcAnT802nB2THo0w/VoERKJfnkOtV+7e8/yVa6F6fDRE
         O7FF1S51mjwNMNh6KWP/blGWMT0qczJ1Tip7kLHU9Ta3F59PdJsxP5uPIQz0sZQL8xDg
         LaSsRbb391cJPWTlAVNVdGw1uN8xrTwr6QKOU4UxXHjrSmzjbScOxibHNobVtwL3bW/P
         1EVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905949; x=1785510749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uJ2U10c08l7aGrL85yzaPlVtXbri90BVENteR8ldZ5k=;
        b=eOvkSXwJp0slPccys2fbw4ITk/yW7BGWMCydLUgiI0ysJidmqgKdlK3CROBPvUR8aP
         WML41EEIXiGdGOnFtCQ30P9PpronfF8bAeHbyV2h2Mg4McAnS6oFQf+IEd+z59mcRibN
         qhgdN6ZGiZb8gi69Nq4sRjKwsoq1UwYowSF6jhUoRix6WsDRsLhUDf1gaz5Jj7sTFiI0
         KC+LYm1u+wk0f92ZzYHJT1UIfzLAVpyHEkT22bWKkgYuHJYbnT/3gjyQ71Elk784MBkd
         EEZwMYfL6Oxn5ft7iBB0fNSZKdy5nOAngM3pFhqyI0ey/NMyNPWBn8esFd2I4gSO9f9C
         h5wQ==
X-Forwarded-Encrypted: i=1; AHgh+RrJndo5H1zNkrwE47xLBYPBHI6yGs3bZu7JR1XZE2AA/sE7Bwhvq5iRhmvnBREwyHxDVAdkBw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxfPLws4Lij6RqyEsZQJRdefAWjCzcqu5NWgnVxQtFJjC7ck/a
	nB6v6LmrZvY2ahqQ+ci1fXMGj1e4l0AJCfPIZonhZxVE1jS8+5DmaZxm/AtERoBJX15x27MEc2i
	DQDA2oiCggVDGs+S/DrmkbSGJjKr4tgkaFheQLlc0Q6uvo1+ewjW/j8gmYpLy/T2T4A==
X-Gm-Gg: AR+sD11UAqWs+cvq0jUAuBGY5MBxL+xbLxfv2rWXAJBIost7FobXlGXTTZ0qqKdJWlQ
	tAf7HpOVcIoJGFCaM0IxT5rR0IJtdSCnELSFOf6LJ3SkYwvCOJnKCspuIGRouRFi8mJwt7hITTy
	G9AuTOfBFeKiV7HJpHGxe5mtortRrYLda7SlbQ5YgRNoREul8LPWQ967lS7s1c+/SUxRIMhqxzX
	NNFgcWyQ4RV/8wvyQzxNqJ5K8eUcXEje0Brh/DS+cr+ggTvOh7efNy5nHlOtz7CsP+qqjhRP7N6
	SOUxgwDcjLlGkisCMYu3JbeUQcuNGsKmMxNDEOpkT7m6dl6IcGkIAIXq9nBFNW+3QViJ6axoL0z
	6T7dOTT+Iv6+nuysNXS7rNbHv1MxHUqHNFR+C
X-Received: by 2002:ac8:5a4b:0:b0:527:69dd:5413 with SMTP id d75a77b69052e-5283dda9badmr76424351cf.5.1784905949435;
        Fri, 24 Jul 2026 08:12:29 -0700 (PDT)
X-Received: by 2002:ac8:5a4b:0:b0:527:69dd:5413 with SMTP id d75a77b69052e-5283dda9badmr76423711cf.5.1784905948908;
        Fri, 24 Jul 2026 08:12:28 -0700 (PDT)
Received: from localhost (ip-86-49-247-5.bb.vodafone.cz. [86.49.247.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb50bd30fsm159683a12.5.2026.07.24.08.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:12:27 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v2 04/14] iommu/dma: Add iommu_dma_map_msi()
Date: Fri, 24 Jul 2026 17:12:08 +0200
Message-ID: <20260724151218.965929-5-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfXyRvoLd2sMIPd
 p4h0QkTNdcd4Sul5XIEbs2Y+22MHWhbUtI+l/sIhtPgu6mNAfDWj1leZGN45IQIUYK0JsaXcTRm
 WFhYuN5UIaTer5CENk5H7Dq5odhPucA=
X-Authority-Analysis: v=2.4 cv=TvrWQjXh c=1 sm=1 tr=0 ts=6a6380de cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=aYZ+cQcEYoLAp2L633VOig==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=vjeZBn8P1qzF27HCuS4A:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: 4dEsb5EFdugZZNtxSJkm-VBI_-WDb1dK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX4vrPbdXWl/3D
 kMU8qkgH4EqW/kBfG+H09PRrKRVphMVC06an+LrecwCdTWT9O3EALy+PuCllNAIjUvVwk/dXLhB
 i6CDtVoyd9k3ZaEXvAYj8gRsrr3cecYMS2cqLZk+H+SwZacRlpRFkW1gMFd9D1aV4fmjxTJDvL8
 vgqqBjEBWQhTdDElYrcq7f92OsgZffu80OlS2VzJKkB0nrYXD3w8V9ah+mSNc4YNCEJJapJq79d
 7WVfhWEdDtscU6tuTdPNswcHlB4zj+9bq2cGN+gw1ImtarBB9mVDECLEHQRicIy60hkRkSSO9HZ
 F21rVTzzNVrsmRUNACdxw6THPC9Tw5hEnwy4lVZyaM5mr5T9xAIxXSnXc4MT89ffrFfskWtx+ZL
 2v0rGvpGOdNG8ezeURiNQTCz86MkywyZyhmFLyYoPRHCDCxi3sBB1gv1xrmij99v/yIDGjG+F7D
 4+v0bV6imMDr7aBmbaA==
X-Proofpoint-ORIG-GUID: 4dEsb5EFdugZZNtxSJkm-VBI_-WDb1dK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240137

Add iommu_dma_map_msi() to map an MSI doorbell and return the IOVA
and granule shift to callers that need their own PA->IOVA lookup,
dispatching to the DMA-IOMMU or iommufd cookie implementation as
appropriate.

Callers may pass a required mapping size so MSI doorbells that must
not share a larger IOMMU leaf, such as RISC-V IMSIC files, can fail
before a mapping is installed.

iommu_dma_map_msi() requires the caller to hold @dev's iommu group
mutex, but struct iommu_group is private to drivers/iommu/iommu.c, so
a caller outside the core (e.g. an interrupt-remapping driver building
a table of mappings ahead of any MSI descriptor existing) has no way
to take it. Add iommu_group_mutex_lock()/iommu_group_mutex_unlock() to
bridge that gap, next to the existing iommu_group_mutex_assert().

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/iommu.c | 86 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/iommu.h | 22 +++++++++++
 2 files changed, 104 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e8f13dcebbde..b980c11dcfe8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1364,15 +1364,46 @@ void iommu_group_remove_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
 
-#if IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_IOMMU_API)
+#if IS_ENABLED(CONFIG_IOMMU_API)
+/*
+ * iommu_group_mutex_lock(), iommu_group_mutex_unlock(), and
+ * iommu_group_mutex_assert() must be called after device group param is
+ * set.
+ */
+
+/**
+ * iommu_group_mutex_lock - Lock the iommu group mutex for a device
+ * @dev: the device whose group mutex should be locked
+ *
+ * Callers that need to invoke a function documented as requiring the
+ * device's iommu group mutex (e.g. iommu_dma_map_msi()) from outside
+ * drivers/iommu/ use this instead of reaching into struct iommu_group,
+ * which is private to the core. Must be paired with
+ * iommu_group_mutex_unlock().
+ */
+void iommu_group_mutex_lock(struct device *dev)
+{
+	mutex_lock(&dev->iommu_group->mutex);
+}
+EXPORT_SYMBOL_GPL(iommu_group_mutex_lock);
+
+/**
+ * iommu_group_mutex_unlock - Unlock the iommu group mutex for a device
+ * @dev: the device whose group mutex should be unlocked
+ */
+void iommu_group_mutex_unlock(struct device *dev)
+{
+	mutex_unlock(&dev->iommu_group->mutex);
+}
+EXPORT_SYMBOL_GPL(iommu_group_mutex_unlock);
+
+#if IS_ENABLED(CONFIG_LOCKDEP)
 /**
  * iommu_group_mutex_assert - Check device group mutex lock
  * @dev: the device that has group param set
  *
  * This function is called by an iommu driver to check whether it holds
  * group mutex lock for the given device or not.
- *
- * Note that this function must be called after device group param is set.
  */
 void iommu_group_mutex_assert(struct device *dev)
 {
@@ -1381,7 +1412,8 @@ void iommu_group_mutex_assert(struct device *dev)
 	lockdep_assert_held(&group->mutex);
 }
 EXPORT_SYMBOL_GPL(iommu_group_mutex_assert);
-#endif
+#endif /* CONFIG_LOCKDEP */
+#endif /* CONFIG_IOMMU_API */
 
 static struct device *iommu_group_first_dev(struct iommu_group *group)
 {
@@ -4223,6 +4255,52 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_done);
 
 #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
+/**
+ * iommu_dma_map_msi() - Map an MSI page in an IOMMU domain
+ * @domain: IOMMU domain to map into
+ * @dev: Device used to allocate the IOVA
+ * @msi_addr: MSI target address to be mapped
+ * @required_size: Required mapping size, or 0 to accept any size
+ * @msi_iova: IOVA for @msi_addr, or 0 for passthrough
+ * @msi_shift: Mapping granule shift, or 0 for passthrough
+ *
+ * The caller must hold @dev's iommu group mutex, e.g. via
+ * iommu_group_mutex_lock()/iommu_group_mutex_unlock(). This function does
+ * not take the mutex itself because callers building a table of mappings
+ * (e.g. one IOVA per possible CPU's IMSIC page) call it in a loop; locking
+ * inside would mean re-acquiring the mutex on every iteration and would not
+ * stop the domain from changing between iterations, leaving the table
+ * inconsistent. The caller locks once around the whole loop instead.
+ *
+ * Return: 0 on success or negative error code if the mapping failed.
+ */
+int iommu_dma_map_msi(struct iommu_domain *domain,
+		      struct device *dev, phys_addr_t msi_addr,
+		      size_t required_size, dma_addr_t *msi_iova,
+		      unsigned int *msi_shift)
+{
+	*msi_iova = 0;
+	*msi_shift = 0;
+
+	if (!domain)
+		return -EINVAL;
+
+	if (domain->type == IOMMU_DOMAIN_IDENTITY)
+		return 0;
+
+	switch (domain->cookie_type) {
+	case IOMMU_COOKIE_DMA_MSI:
+	case IOMMU_COOKIE_DMA_IOVA:
+		return iommu_dma_sw_map_msi(domain, dev, msi_addr,
+					    required_size, msi_iova, msi_shift);
+	case IOMMU_COOKIE_IOMMUFD:
+		return iommufd_sw_map_msi(domain, dev, msi_addr,
+					  required_size, msi_iova, msi_shift);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 /**
  * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
  * @desc: MSI descriptor, will store the MSI page
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d20aa6f6863a..c36540b75072 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1561,8 +1561,22 @@ static inline void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 
 #ifdef CONFIG_IRQ_MSI_IOMMU
 #ifdef CONFIG_IOMMU_API
+int iommu_dma_map_msi(struct iommu_domain *domain,
+		      struct device *dev, phys_addr_t msi_addr,
+		      size_t required_size, dma_addr_t *msi_iova,
+		      unsigned int *msi_shift);
 int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
 #else
+static inline int iommu_dma_map_msi(struct iommu_domain *domain,
+				    struct device *dev, phys_addr_t msi_addr,
+				    size_t required_size, dma_addr_t *msi_iova,
+				    unsigned int *msi_shift)
+{
+	*msi_iova = 0;
+	*msi_shift = 0;
+	return 0;
+}
+
 static inline int iommu_dma_prepare_msi(struct msi_desc *desc,
 					phys_addr_t msi_addr)
 {
@@ -1571,6 +1585,14 @@ static inline int iommu_dma_prepare_msi(struct msi_desc *desc,
 #endif /* CONFIG_IOMMU_API */
 #endif /* CONFIG_IRQ_MSI_IOMMU */
 
+#if IS_ENABLED(CONFIG_IOMMU_API)
+void iommu_group_mutex_lock(struct device *dev);
+void iommu_group_mutex_unlock(struct device *dev);
+#else
+static inline void iommu_group_mutex_lock(struct device *dev) { }
+static inline void iommu_group_mutex_unlock(struct device *dev) { }
+#endif
+
 #if IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_IOMMU_API)
 void iommu_group_mutex_assert(struct device *dev);
 #else
-- 
2.43.0

