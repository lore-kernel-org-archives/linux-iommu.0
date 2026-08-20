Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916AE485CCF
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262127; cv=none; b=pFjw/RnMiryGE7wCxP5VTR3cGQb7/15y97ghiCKOpRjsW5+AGL/5F48MHw72Hc0lENOmwPnyU7yzUWW8zcO6/bZe5vHMoqc+FIGUDOPh0lUFYNPyFsWArt9EzGucIXZ+kU+0+jGMMcEJ3OnX9oBwVPrVLi7lXQuMhb+EmfC3e+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262127; c=relaxed/simple;
	bh=x2hUaeyUI1ao+BRBfu/rrLeRLqd0v5R8H/5dEa5oGyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEspmhVGuT7n/LR+7NfPahrQDIbqsHfCGGWnKeN6ADHtmgUcB5F3CEi+KuHaMqjOxop0vJPr/r4Qp+cdAuX50X45j4s4ao1F9LV9I8nGj7JB/Z7ZL7oReq7Xco2cL5Egd3FzsxAp5gcBON2pft/gH/OeKeRDxDcn/idxAG1KEuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fdH77Ip/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SF02m5EO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fdH77Ip/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SF02m5EO"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK7xlY159124
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tRMIY00QWRw
	kXWT015GEhRk4eSzgHIEurYwgXmBTB+k=; b=fdH77Ip/tZe1FIoOQzJQSvIgque
	udbXZbz/pKIq3VgrVvC6LckgBhX8jrgDAYZtpgJeG9otk/078VQ+kbTN5GkIQkw4
	khoj0ufh4JUI40NOMA5rzxNIhp/eCG7WTysI0m7qcUtc31+X149bmQzFrC/UY/L8
	uQodUhURkuIW4PvNhmWdns7vYaj+Nygx160Wp3k7MaugBmSTvERiPY1AOTBb9o25
	Ayvd/wFKJVeLbV1782KOgEeJrzetkBiGTgA4SHoxdJHLJKXsZR+dS19P2bH8tFZ4
	gc1/shdsMYLc9ED6luyrlya/CvSogN2joklngyjpUoHGKv/Dd7qGcPkNI1w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xuk386d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e63df032bso163187985a.0
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787262124; x=1787866924; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tRMIY00QWRwkXWT015GEhRk4eSzgHIEurYwgXmBTB+k=;
        b=SF02m5EOqfc4KoSI/ag+y+LxeDpbUcucmR0MErZrcVLeDz86nkeb6uzQwr7YJMil0J
         ihV0oH2N8KaSj0VJcMP+o+jNFmVj5ZMld2X0H3JThVvz17gOJjS6TOWrVGxy3wkuWbys
         hqGrg40GePmV3mof3p1hW47rBovuOZKb3OqbumzFrsdQkUYmZSPN6o4WZDQElnFnhd56
         H7UXhouwU+OmWQuCos28xUiRuPEJ8vkSLl7fXNiYxwGeU/lRJS2KwTTh+yEPn9/JWfs2
         /vM9J5xQyapMsrc50NRMijsnpgcNnxZ7ntXuJDfmKKrT8T2EfxOlEPTFfipfntvKEOYx
         Olww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262124; x=1787866924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tRMIY00QWRwkXWT015GEhRk4eSzgHIEurYwgXmBTB+k=;
        b=ofbh5hKddsPCnyIo3w0eSc+YEVnhaMLWxW6XihLn3zsrkHlvJ8csqllp0NtU4DC0Jo
         rYpR9rcaPftiJdvAGBhWY+rly57Dl4bjxNJGYvzQkKoEr5JsF443CjYmW9mJyed4q+Ly
         0JtYDrMr9d+FmaxIVSMeVV2YzY4+9lLwzUQrH4ZwlpjFMyXuKB1FpSNS+GZR6s1KOc7f
         4nWMCEz7rAqWaLfE5WB6C9UuxaK8ZECnfW66qOGgV2cyziu/TBqeVddhdtGHXyShQDSj
         yFBFdcTtz6G3yABwXeiWK4C4isc4DV73/yWdATNOrzJ9WW0Hbor1RVY5q5JfGkvVK0TA
         KaHQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq7xI8GjBUC4/WOKdcVaZGuhkr2ZLFJKC/fu7G4qbuogzGh2IletBKk2ln3icYj+Yj5A6gBFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJusjpcY9uU2EW1/z1JTwEllCIBeFHP2lFv/gdQ7F9f95TVHDK
	AgZBe2sFy8ZL1/vJkap5IZ7GtnimONwfygGKPS/uGplGRUbr4VRTzeT3FdxQai2P5yfjRqcQftB
	6l/SDJcqFPNN5MJsbnz+NtBJTULsByd98w0YJTdShwXYQzfpdaHqubn8toA==
X-Gm-Gg: AR+sD11shdvG6Z28/rs/TfKntalFzAL9h6PQpAvyzoEVHLu7ZOg64zaAu1ltLIQ47lP
	YZScLbzszoRvD6RT2J+lXMZMscoieNjUtLzGzB+0oxHD5h00KPF2R+zMecnJPF0T9ATQoihdyiD
	NPNLEcdsaBTD/PEUsHO0dy6vyyI5SPda14kJTGCVzoy2p9f7n2EEIh2N3ZF3XiEaQskSUhauVlA
	3uFTWa99ruzq1hcDrCFmSD9dOGUSruPCiox0hYtBEvpLcBklgfeVnHc8ot1jV44ZoYL7bLGbT3T
	6rLn7P1tDvR4MLyeUkS8iDW8CTth6F4kvNHN2DqhuY+UzxKC7Q8RHo8iUYjaKbVMkLOdiIHQibV
	ZEDdOEZDl
X-Received: by 2002:a05:620a:294d:b0:936:a184:3cf3 with SMTP id af79cd13be357-9372840f584mr1043402685a.10.1787262123674;
        Thu, 20 Aug 2026 14:42:03 -0700 (PDT)
X-Received: by 2002:a05:620a:294d:b0:936:a184:3cf3 with SMTP id af79cd13be357-9372840f584mr1043377785a.10.1787262121474;
        Thu, 20 Aug 2026 14:42:01 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b90f7e24sm5944115e9.8.2026.08.20.14.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:42:00 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v4 04/21] iommu/dma: Add iommu_dma_map_msi()
Date: Thu, 20 Aug 2026 23:41:33 +0200
Message-ID: <20260820214150.545737-5-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-GUID: w4CYoo5S4wGOTzhXIKmi6uiM_ZMtYbE7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX1ZE2NHu5xgmc
 5JCWscpbfTPQBryY44hcL52SKADEK1mo7ZXWZfHPHXXYUVKA0dFNUveXgEfiYCDI9hI+jMf5bp6
 g38u2vfmoVjg4jolKr7RSeE9CYIpLYM=
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a8774ac cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=nir-2xX3lSHJcyBuNR8A:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX4sltdPQ/z2T3
 cao1Nb9uSX+HqpKVXZG5ppfxCXe55w5E40v9Af/3MxkXi7U7T1qY61uRPVpIVNkesAGBDkg+goF
 Zz0774qK4UwDNWDtBc8CUmdkp7l7mEZN13Ryoiy8rR4T9FxVu1wWIZjzfboFtg2xbcre2eloJH/
 PS+X1KBCQLvWJKWRznmq2BnNlsIVbgDBd7TfiXpo2o+zojBLXVSCgEg1dVV/yav2STteShJdY2r
 O3ffOc9W6hTJ8DQYsyC72UkmfTljRkqNUIJ3ANcsCkgqj//iZ/E0F2wJ69RjIERtkqQ2dBEm/+O
 SbLgqNwNAYmTsWKjtFHjYgg+CIsjP8NujsY8G3p1mnzX/FSfBd5i1N51wm72Wnx0mPM4WkP3fkg
 TTr579Za7zqolM78NbfX33aAQnMT4nqEUZ0WLscX/hI5gTfocuKPd9A2ifo5Ma1woHDtKRbEVNF
 AU1R0vtRrbvcxmUTXXA==
X-Proofpoint-ORIG-GUID: w4CYoo5S4wGOTzhXIKmi6uiM_ZMtYbE7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200162

Interrupt-remapping drivers may need to map MSI targets before any MSI
descriptor exists and retain their own PA-to-IOVA lookup table. Add
iommu_dma_map_msi() to return the IOVA and mapping granule for both
DMA-IOMMU and iommufd domains.

Allow callers to require an exact mapping size. This prevents doorbells
such as RISC-V IMSIC files from sharing a larger IOMMU leaf.

Building a table requires the domain to remain stable across every
mapping. The IOMMU group mutex provides that serialization, but its
structure is private to the core. Expose lock helpers and a scoped guard
so external callers can hold it for the complete operation.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/dma-iommu.c      |  22 +------
 drivers/iommu/dma-iommu.h      |   8 ---
 drivers/iommu/iommu-priv.h     |   8 ---
 drivers/iommu/iommu.c          | 104 ++++++++++++++++++++++++++++-----
 drivers/iommu/iommufd/driver.c |  31 ++--------
 include/linux/iommu.h          |  31 ++++++++++
 6 files changed, 127 insertions(+), 77 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 3ce9f4878d92..39ee5f0b1da9 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -2248,9 +2248,9 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 }
 
 /*
- * Descriptor-free counterpart to iommu_dma_sw_msi(). Maps an MSI physical
- * page into the domain and returns the IOVA and mapping granule. Used for
- * pre-mapping MSI targets before any MSI descriptor has been set.
+ * Maps an MSI physical page into the domain and returns the IOVA and
+ * mapping granule. Used for pre-mapping MSI targets before any MSI
+ * descriptor has been set.
  *
  * The caller must pass a device attached to @domain and hold @dev's IOMMU
  * group mutex. If @required_size is non-zero then it must exactly match the
@@ -2284,22 +2284,6 @@ int iommu_dma_sw_map_msi(struct iommu_domain *domain,
 	return 0;
 }
 
-int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
-		     phys_addr_t msi_addr)
-{
-	struct device *dev = msi_desc_to_dev(desc);
-	dma_addr_t msi_iova;
-	unsigned int msi_shift;
-	int ret;
-
-	ret = iommu_dma_sw_map_msi(domain, dev, msi_addr, 0, &msi_iova, &msi_shift);
-	if (ret)
-		return ret;
-
-	msi_desc_set_iommu_msi_iova(desc, msi_iova, msi_shift);
-	return 0;
-}
-
 static int iommu_dma_init(void)
 {
 	if (is_kdump_kernel())
diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index 3e1adeafdcac..7d707157aebb 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -23,8 +23,6 @@ int iommu_dma_sw_map_msi(struct iommu_domain *domain,
 			 struct device *dev, phys_addr_t msi_addr,
 			 size_t required_size, dma_addr_t *msi_iova,
 			 unsigned int *msi_shift);
-int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
-		     phys_addr_t msi_addr);
 
 extern bool iommu_dma_forcedac;
 
@@ -65,11 +63,5 @@ static inline int iommu_dma_sw_map_msi(struct iommu_domain *domain,
 	return -ENODEV;
 }
 
-static inline int iommu_dma_sw_msi(struct iommu_domain *domain,
-				   struct msi_desc *desc, phys_addr_t msi_addr)
-{
-	return -ENODEV;
-}
-
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __DMA_IOMMU_H */
diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index f60373cd2f70..109aca07470b 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -53,18 +53,10 @@ int iommu_replace_group_handle(struct iommu_group *group,
 			       struct iommu_attach_handle *handle);
 
 #if IS_ENABLED(CONFIG_IOMMUFD_DRIVER_CORE) && IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
-int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
-		   phys_addr_t msi_addr);
 int iommufd_sw_map_msi(struct iommu_domain *domain, struct device *dev,
 		       phys_addr_t msi_addr, size_t required_size,
 		       dma_addr_t *msi_iova, unsigned int *msi_shift);
 #else /* !CONFIG_IOMMUFD_DRIVER_CORE || !CONFIG_IRQ_MSI_IOMMU */
-static inline int iommufd_sw_msi(struct iommu_domain *domain,
-				 struct msi_desc *desc, phys_addr_t msi_addr)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline int iommufd_sw_map_msi(struct iommu_domain *domain,
 				     struct device *dev, phys_addr_t msi_addr,
 				     size_t required_size, dma_addr_t *msi_iova,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a3dea7353500..84b60d0f8c23 100644
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
@@ -4238,6 +4316,8 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 {
 	struct device *dev = msi_desc_to_dev(desc);
 	struct iommu_group *group = dev->iommu_group;
+	dma_addr_t msi_iova;
+	unsigned int msi_shift;
 	int ret = 0;
 
 	if (!group)
@@ -4246,18 +4326,10 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 	mutex_lock(&group->mutex);
 	/* An IDENTITY domain must pass through */
 	if (group->domain && group->domain->type != IOMMU_DOMAIN_IDENTITY) {
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
+		ret = iommu_dma_map_msi(group->domain, dev, msi_addr, 0,
+					&msi_iova, &msi_shift);
+		if (!ret)
+			msi_desc_set_iommu_msi_iova(desc, msi_iova, msi_shift);
 	}
 	mutex_unlock(&group->mutex);
 	return ret;
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 69b3dbcbee3b..b39796bc7251 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -249,11 +249,11 @@ int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
 EXPORT_SYMBOL_NS_GPL(iommufd_sw_msi_install, "IOMMUFD_INTERNAL");
 
 /*
- * Descriptor-free counterpart to iommufd_sw_msi(). Maps an MSI physical page
- * into the domain and returns the IOVA. Used for pre-mapping MSI targets before
- * any MSI descriptor has been set (e.g. IMSIC doorbell pages). The IOVA is
- * global to the iommufd file descriptor: every domain and device using the
- * same MSI parameters gets the same IOVA.
+ * Maps an MSI physical page into the domain and returns the IOVA. Used for
+ * pre-mapping MSI targets before any MSI descriptor has been set (e.g.
+ * IMSIC doorbell pages). The IOVA is global to the iommufd file
+ * descriptor: every domain and device using the same MSI parameters gets
+ * the same IOVA.
  *
  * msi_addr is the exact byte offset of the MSI doorbell; the caller must have
  * verified it is contained within an MMIO region safe to map at PAGE_SIZE. If
@@ -321,27 +321,6 @@ int iommufd_sw_map_msi(struct iommu_domain *domain, struct device *dev,
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_sw_map_msi, "IOMMUFD");
-
-/*
- * Called by the irq layer when the platform translates MSI addresses through
- * the IOMMU. Wraps iommufd_sw_map_msi() and stores the result in the descriptor.
- */
-int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
-		   phys_addr_t msi_addr)
-{
-	dma_addr_t msi_iova;
-	unsigned int msi_shift;
-	int rc;
-
-	rc = iommufd_sw_map_msi(domain, msi_desc_to_dev(desc), msi_addr,
-				0, &msi_iova, &msi_shift);
-	if (rc)
-		return rc;
-
-	msi_desc_set_iommu_msi_iova(desc, msi_iova, msi_shift);
-	return 0;
-}
-EXPORT_SYMBOL_NS_GPL(iommufd_sw_msi, "IOMMUFD");
 #endif
 
 MODULE_DESCRIPTION("iommufd code shared with builtin modules");
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ac43b8b93f14..868b14b63e77 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -8,6 +8,7 @@
 #define __LINUX_IOMMU_H
 
 #include <linux/scatterlist.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/types.h>
 #include <linux/errno.h>
@@ -1561,8 +1562,22 @@ static inline void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 
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
@@ -1571,6 +1586,22 @@ static inline int iommu_dma_prepare_msi(struct msi_desc *desc,
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
+/*
+ * scoped_guard(iommu_group, dev) { ... } locks dev's iommu group mutex for
+ * the scope of the block. See iommu_group_mutex_lock().
+ */
+DEFINE_LOCK_GUARD_1(iommu_group, struct device,
+		    iommu_group_mutex_lock(_T->lock),
+		    iommu_group_mutex_unlock(_T->lock))
+
 #if IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_IOMMU_API)
 void iommu_group_mutex_assert(struct device *dev);
 #else
-- 
2.43.0

