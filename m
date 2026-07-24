Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B31433BC1
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905952; cv=none; b=QmNOtpIUWDzWE6yS+oqsnyZ4xZ4iZJh3YAzYgZCn6sYI6VuhZYQmSk7DHiOEMcRyG40W0KxAcdMfsLMU4XzmBvyUkzgiumDbjHujgrsXcDe6qNk1U+NHp4h9nn0JZGpBPeLf/Sqf94VeL8p8v1kbWMaI5/2XdM41CKhpQxnPtVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905952; c=relaxed/simple;
	bh=HUS8kyNKlSLqeOll0RzRcc1Ia96vnKFDGEXE3UuLoco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXJnDzTz3gyVe3lLYlHJK6fZL+Do4hAGse8q6HVCbgmKxCcj+6vjrYP47wJu3wi2DKe9ykR1UpmRxZuEsykkYyadQdktLxNnbwpWSrK9Z57JEY7sZ2kDIQ9UNQVfFixkhTSiSFLVueOKF78/cZrLDJBi3kn8zVKMYjnm+ndKHU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VDqmctcG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XjEe1Mly; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VDqmctcG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XjEe1Mly"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbNB13308098
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8mou5jvBrPN
	eVlfrTJOWH/Ft8cQ0Na/otKYhZJRU3yw=; b=VDqmctcG1YLVI2xKoOaHWL9UV4t
	Qej/HcfCBVQJfpdK3rUpwunlKDlsIJxTYP4a8e3mBjqvD3xCmIKnJHDcv+jaA6yb
	gA1e5yXAA9Gyb/VDzNSF/J3qMdDoDISRclJBInk8sd+OMPQn06rsJWq4Kwh5vlB/
	pllnZ9nMGzereMxmpe8T029uEl5rEcuURLK6L7zAxygvLGkuYJkLIPmLevdvvO4B
	qHcRyrYgFDRRgSC4Z85x7sKBc2224paYMGWi9jYfKDI4b3+OiD1MGDN9FhlAYqOj
	l68muHCwOzh7YbABFBbk9RnElKuD/sLAq7pDkz4/rZCgyPfyuRrtWcjIzmg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fktahujg5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:25 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c21c01cf3so8412891cf.2
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 08:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784905945; x=1785510745; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8mou5jvBrPNeVlfrTJOWH/Ft8cQ0Na/otKYhZJRU3yw=;
        b=XjEe1MlyOPn4sStojIebd8kG0kMbDgSGDWVMJZ6KzXIJHBGjvTBIIXDuSNeqDEKZon
         paQFry2baMYqYhwhgqDD8mzU3xUGJqKQExBawjdq4TlwjHgP67WK8vUWzKgqj6/U1NaA
         e/JHQf0uZSmkEcsmsAkacVkw76bWPixDMqNGXUTkAe2OcL2QpNFHVbau6V4vP4u6xAoG
         hgmgZd17lrPTFA5frNy/ve/1ZTuA3TEuSaCZH/02cvBF9AWzxNGQTS08d5hIpf+adx0a
         IzjexBcnyQC3C87G/puAK7usOorN53iJDtcRzeNNd+9DEr8psXdolFUd7NqxOvsecaJL
         CncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905945; x=1785510745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8mou5jvBrPNeVlfrTJOWH/Ft8cQ0Na/otKYhZJRU3yw=;
        b=cehWZ2SFBqevcMsO9Br3FwLR9GimPfbP4BB2fTzfPk1N42Lr+6fLdTz4h5YrpOKmIH
         Hb4GnfMLU3LhCDWJIN7IuiOGBV/8APby/dhwWZxbj4/r2CKF+ANefZeZvDQVM4MdRi3a
         FMcTWF46Ff65ocxvBQ/bTes/X60p25aqwK2O0y64xjVtPq/ejaxTcHLhXrIxGWCCjlRZ
         AM4M6U/QjRHh4Ro1FcVlhko+kvCzQ9DsTFIdRB/uSPv3sR0UXNV9hEytPwpAUx2kc06e
         AKsSnJ3SnkMqF6gBFr10LQFUKJwfFV5wInYx1KEZ0pdm9X+xoiLc3J6F0opvMqsUJRFG
         nrgQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQS2Mtl9kny69RQ5jDkLH2MEWE4AwNwwuQHYT0k/wjDS3MJBjRW5Fuypkr+Z5gfE8kGnxKog==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDdYA5Brr7u0opeNwK9d+zWuaI7RW15D1L9OoAEww0g7SW8LrU
	rnqSJ0xDzCGDsj4d7pctSUIvpQ7r3BdD9i8awzlZI3LXD+0HxuFTd1L6Xp/fM8Mlb5ErHL7xYP2
	llja6whI6ENxstiG5NVzxoZnb10DEtXO7f1ZjhSBefk0woGzL6NRrVpxmQg==
X-Gm-Gg: AR+sD13esayupZzcX8bnaVJkQxKW6USrTDTsR//xvLG3C6WDUOCruz2wYAyX9kP+75E
	r3nYOxT41S/TrEnszjrF7mQV4UPc+/B4CkTaestmjVRC+SzYM9nspoAMSgFwAZgf+UcSn+VDsMg
	/AbC7z8lwCnf339jGd8yoPNwvDbqoDuEXQvxO7ogsTD4uX5gz9ac1IIvBd2LpwfjHKq78SIPvIR
	4gXByn/Nyeb2UAOPg6CTM00dNea5zvYA1p5XI3irRaGzXiDigcf3zSg84fuMd75aevn2MpAsgf6
	QEshBxN3RTv5Um4qyo4DIPHeyFwD+oSpaq7l6T8VeuVqvjR6aNUA8hWcoLwo4iDR39NPGX7LlPT
	FwRU3vhMQvPuWc4EEni9RgdnRLkqxPD2EqRHB
X-Received: by 2002:a05:622a:1a8e:b0:51c:1641:e73a with SMTP id d75a77b69052e-5283df4fe59mr78778451cf.44.1784905945307;
        Fri, 24 Jul 2026 08:12:25 -0700 (PDT)
X-Received: by 2002:a05:622a:1a8e:b0:51c:1641:e73a with SMTP id d75a77b69052e-5283df4fe59mr78777941cf.44.1784905944771;
        Fri, 24 Jul 2026 08:12:24 -0700 (PDT)
Received: from localhost (ip-86-49-247-5.bb.vodafone.cz. [86.49.247.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb51c98c5sm150836a12.11.2026.07.24.08.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:12:23 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v2 02/14] iommufd: Add iommufd_sw_map_msi()
Date: Fri, 24 Jul 2026 17:12:06 +0200
Message-ID: <20260724151218.965929-3-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX5PBr+tSnxDE2
 ts0WZyeODMJBWtCCkcK6zM5cw3qGOCstjHUj+cFnWR/XPkXf+VB91BpmM/UeCUvGPMzCalHv3Vf
 Uf+ORKm5WTWDbUo/lrQxukH1LxsHv08=
X-Authority-Analysis: v=2.4 cv=TvrWQjXh c=1 sm=1 tr=0 ts=6a6380d9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=aYZ+cQcEYoLAp2L633VOig==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=5IMjXt7tboKol454yg4A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: -ujVbugMSBSDONLkqUVqnRriTyIj2dlr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX0JgszmwgIK8d
 eT545jY/7BnmR4cFW30gGmAPg2nGmvy4LBy4FU7EPdBuQpv4WbVsgtwmuAPQSGXrUUlQw6hF7PN
 cgrqmJQAV72cv0FFS0n+a4N9edGuj81HXuAlo0uS3eeDVEPEdy+dqRcp8quIA0W/tPcLAIsJa/1
 n4UpNlkPHhKOUmWIigX9UP9dgTFRytRFY7L4NwxzH+C8oIMZNS7YmpS+Kw7UOGKDirRFlLaWAjE
 BFN5uIw8YZHDBQkz1iftFoKjecZF7cV5nct7zTIFu1rSf3Ihwy3gYYp8+tfkXNwQg6gDFadD+q6
 V+Dfwm9S5G/LK1ZAGuYIDMlsR/s2/fVK8lC4tUDxY9G3KtBEqUkISseDsCwHxiK3wmLwK5LmWQR
 cOlmi6OcGUynEQ6USofrnM9DHcfVc9CqNF+oF6twomw0AiLOinvNjTcpj8cDP0jHKJK91pmDPlW
 3kK//5/zdLCiG/Y1q4A==
X-Proofpoint-ORIG-GUID: -ujVbugMSBSDONLkqUVqnRriTyIj2dlr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240137

Add a descriptor-free counterpart to iommufd_sw_msi(). The existing
function is tied to a struct msi_desc and stores the result in the
descriptor. This variant returns the IOVA directly so callers can
pre-map MSI targets before any descriptor has been allocated.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/iommu-priv.h     | 11 +++++++
 drivers/iommu/iommufd/driver.c | 59 +++++++++++++++++++++++++---------
 2 files changed, 55 insertions(+), 15 deletions(-)

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
index 3cd617dfc351..9aad5c69d4ac 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -249,15 +249,22 @@ int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
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
+ * required_size is non-zero it must equal PAGE_SIZE.
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
@@ -266,6 +273,12 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
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
@@ -286,13 +299,7 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 
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
@@ -308,7 +315,29 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
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

