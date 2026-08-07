Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E8E371897
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126645; cv=none; b=WQYF1QE9Vc/5HBJhY7s2feygE7sHZy+ZmiP54krHIhkZjOwXN5b3vuCaHQj0hbUMj5A1KkEiXzqdMBPntoCOvcN1TTnox779cwbk1r4qsp0fzXMzNOFxc3H4ITaUPiNSCdeitmzpv3WOJrlih6EIOd+d1F50dgL77gKQbO0mIUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126645; c=relaxed/simple;
	bh=GKMcSeCiL0a3g2uOH9WSfrZlngJsKlX/8rmbuIPed8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqPtPNLG+BB2dnvE/Fui5pvAhgEQzuZVqkllA0gf+5jqs7kyEnl0uLpLDX4NEMShUgSx2ehYpAkdSAYosPNYVInJrHa+N8N7ppxi2eORI0obZQjihnF9sxJd7VFF07hkT8iS/KoMACIMIp6ZDt9Qsq2FeM2ztkASVOlrMYN05WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BprGYy8s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bxv1ULJj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BprGYy8s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bxv1ULJj"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GOEPc2661139
	for <iommu@lists.linux.dev>; Fri, 7 Aug 2026 18:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=gu+JFGkyqPx
	/Q45IWTCbHOfkGmMO1gxqkNte7ZP70m0=; b=BprGYy8sJoMdHwPO98njan+RnlC
	uPCMl5bUQJqeMlgIbgXN0AZv2X0M1UAmd0am6B7x/Rae4JI33SR/4dT6lw+mxBw3
	HTyjUr/8bx4GW2bhjQYD+3cdCwAHTe1cQfc+dEyOdSm0YwfXZpHrG3ePoRSGQrEr
	Hr57153VB8XrSWDZdUGaAneoNiCBBE8e2VPX3JGVyHRNWq6653e35NdWUWnAFm+0
	fyYMq372xKLBVzn2bueMEa9OdP/aT92H6nkG/CqyefKOE2WmoU47ojuu7V+nRcQl
	BtgpOHUtu2OQ5RCrVBnO+nhnx9wEq5y/ACS5HfQOMH5UnC/uUD88P5y/shA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwhpy8vyt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 18:17:22 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5283df62d68so41442021cf.0
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786126641; x=1786731441; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gu+JFGkyqPx/Q45IWTCbHOfkGmMO1gxqkNte7ZP70m0=;
        b=Bxv1ULJjaGSDQA8Nc8EEzMjMewqu5+5NPe/NzQSsQjKLl/sOifLdvYXJybHZyRoQmn
         HWJX43XPIros4c4LnwZL4Otkxzi1EMgaOQMRpHg1xzc69VKyzuVeYWJx4QC5vRpn2Fp+
         ORRsxM/qy/hMwEVPVBq8KAPttd3hzMnbnFjiR8IkOkluscm77xugD388KSkx4Je1+sUw
         rJ0gCGGCKjfP5rAB0w3cn07sO4OjtrW3AvzbtYNgjGNKuJtGlxvSC5oH6dN2dFRAmOU5
         /qYLLvtCOZlTo2ILNZOhypH/deIUxFabQIRW76n5bEkAaSLyQoTYqe+Bky6rRPYRn8fS
         LcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126641; x=1786731441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gu+JFGkyqPx/Q45IWTCbHOfkGmMO1gxqkNte7ZP70m0=;
        b=HyC134JwRxY/Ia/p6BNPVAx8Wl6HX/ffvOwmPM2s9tgeRSK3fVnDaZPiHHtuZMonxS
         amRMb24mOLyLweT9toup2DZLZRy8L24+cdrCnCZZHktTl8OU3hEDD9fGKfIjiat8hs43
         9DoMjZM2YWo6XuV9oRN4qXVQLjUBhlCpW+YvWxasXgNfwmetFR07OutkNubLfEZJgOEd
         4c3LTUkqt82Czz+4lNmU6gJllb/s769/IJmgoF7RKDB7mCBLxasxlqWfZd624ZnjPuHD
         toqbeLeIexz134hl5b9rAiOzUy9wRMgtg4eZdbIYL5KEcRrx5Sp2JebIvzIQHNNLkH70
         +6iw==
X-Forwarded-Encrypted: i=1; AHgh+RovDBfTKxGwknHt5oZIiJQjI+Vpd3IWFYz9Q1H2AU0r8tlOjvLVgN3ra7F/EHwXik/JgFx7LA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrCOhfFpbJi6ZI/fJwKr8dcNExKRkA9YSNluJusL4SkdR0VsFX
	SvR/WDhgJ66FZpIDxPhdzjzKcEsw97O5U5EoezMUVyjzo3yr/CMyRY4cBgjhZrFXngoHKDyYqPx
	b38s2Lo/R/pYDRQLDUWfpt/b4CoKoLtiocmWMyFhWKwY9VgqDHwLQGUp71g==
X-Gm-Gg: AR+sD12aWA0yEKgHveGcYdgRxph8lTTf4iKqFEnqZM9H6Ma2SG2JqsQHKUBckZlMUKY
	7JskeAf3WzsdT8tTYOQnsTbwjKMrivYISP0GXJDGvH54ivdRSJjKPocBCTqvghESfF3y2eb/qS8
	CpcxnWUYfNSkg9IXfumIsBZQGMPbn1BL0vSgZlW2IIh+W1uIn3gDtkF4CREIgYxbMR2XilE314A
	jfMbl0o3kfL4vVipUoarYTYfF7heY3hdXJEWI5XRTsIbW9WBjcRZeORWSEiHU+MpDpOg/bQfIig
	epXXNiP2GiwPrn4p1pFtkWyvlBTWNTM7+KC8KrZtVZKpNzUx045a5ZDBvc8pkD7awQrWy3b+G5k
	OGc5Wrk60IlWr6cHyLZWk4ZV7w9M2c6i8LBrqvVo=
X-Received: by 2002:a05:622a:591:b0:519:ef86:127d with SMTP id d75a77b69052e-52ce604898fmr257025531cf.18.1786126641221;
        Fri, 07 Aug 2026 11:17:21 -0700 (PDT)
X-Received: by 2002:a05:622a:591:b0:519:ef86:127d with SMTP id d75a77b69052e-52ce604898fmr257024991cf.18.1786126640675;
        Fri, 07 Aug 2026 11:17:20 -0700 (PDT)
Received: from localhost (ip-86-49-241-13.bb.vodafone.cz. [86.49.241.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1e7d7648dsm828368a12.30.2026.08.07.11.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:17:19 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v3 02/19] iommufd: Add iommufd_sw_map_msi()
Date: Fri,  7 Aug 2026 20:16:56 +0200
Message-ID: <20260807181713.228535-3-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
References: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Cb44Irrl c=1 sm=1 tr=0 ts=6a762132 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=VPysOpcHbS0DNrM1Xqmyow==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=5IMjXt7tboKol454yg4A:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: Hy557-nmBFUzjl0GgeyLbsgMLt5OtOxA
X-Proofpoint-ORIG-GUID: Hy557-nmBFUzjl0GgeyLbsgMLt5OtOxA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfXxXyyeDSPEDT/
 gvsd1F5J4YK5K4p+32i6lz38jCeV/PNfmfT6wge7KlkldWyot5fYtkG8TFuv8GsWrlu07dUMVMt
 BIZR4x51ByiryzKvVHKn4YVqb0fCUWvCM4B6PXS6Ozo/FfP5bCaXvH3kHbcf5cT9tsgSYQ+jXoi
 T1ET+sV2rn98WBN5k+Mf4jKcqW7KaWyz5AacYtfbVbro1AGN94JEvUD7AmVtpXcB9CFt2HIELKC
 dMFn5+/iQDESXIJwxYRw5dySHaOrwUGYTCzB2bdmLWLwUI/AlPIxhu8srN6tR06BB/zFQZ78j0p
 Vzgc3niIvbqubN/I7yEeADdnhn9fX/XPZAX3/94/hDCCW6S7APE7jJpaPgcPocYJ65jsBtvMZ/k
 Ebx06dvKdNk6V8YpHPst87bxEBXvF2R7W0hhSTZfVXK6LTFFez+UEhhqOZO2SOn/4IsgHSYf1y3
 b4hHnmOtMtapNOSUsyQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX/vEnRpcZhY1R
 DovXl3daHNO/Ld2URGQEArMi4f5/CcMGPl6p16zTpeWihjzga+UeJ/yOXX32178GTytkb95lApG
 BjtM+imzoNfjAK4xcri82ClK7JcOc74=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070143

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

