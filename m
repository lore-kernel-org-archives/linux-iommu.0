Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274D832B133
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126649; cv=none; b=vF4BL/ZH/iqGrJjJYoydLwd0J12SaiWBLvbccpF3Jp37QaYrvyLCiQIsRPdFDgemcJW5fgKk3XG3dZmjSGZdAG8z2l/S2kvsUWEDa8NlNUALR2eqkZM84swMdVeq+9U7BjkrlkeDmU+BBLRM+RHXfUwsj2SMokxKXCm91jqYzHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126649; c=relaxed/simple;
	bh=UOi44Z63zP9Ydpo2hZ8/MzUY806viRKmsjIiasPzR+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiVEyzGq75LaRYQn9wqr3OcDBxdjyoQGzGyr5qacO5kD5UXuEOqOGZAzW1H7XOnseygLcge123KjNBK+SKQ5goFmcWmx4KKTiSr0LVaQsS1JYQ5jNiu4ZcMyxy4V/9qHh21bZfw0u1HpgOCBE5pj3bxoF/oThq2lLvcpBQumL8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hiz0b8bk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fGgpkSMr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hiz0b8bk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fGgpkSMr"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GbdlR1474903
	for <iommu@lists.linux.dev>; Fri, 7 Aug 2026 18:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YhX2nHzAOkI
	yGYt/XhkJLiFU6XfxZrwAHaxRl8HBkc8=; b=hiz0b8bkvnQctuy4Al3BkBz2Ofv
	Us9htKtvCbxmF/6OyfcFJWHSk00jVKZolgBn4dW1MUspXiU++G6eBtJBFJpzwJ+5
	6YtT39cd2eN4+slIqN0icqaYUxvDLLjhJqJHIh84gODU6iLpmygh2ZJecJlbCNHN
	L7kmTrPw8FkJTk5Hs7pfCQfXR5aXLlQogSTsizUcvn5V29/tB0kt1VRMGi1UXIdn
	/RTZfHPlNjTykKz8o5XA0Dp/0ZIaPthHFpo5H95qyGwSGd8P80VL3AAtoqVcCJSw
	nn4P95+y1eqfGB9fqB4xUP5sO7FPxjfjDyFl7MrC6KoDPE0UofWy+JdKU4Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwk228f6h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 18:17:25 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5283df62d68so41442721cf.0
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786126645; x=1786731445; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YhX2nHzAOkIyGYt/XhkJLiFU6XfxZrwAHaxRl8HBkc8=;
        b=fGgpkSMro6xwGGda10SDfoRVl5ncbilS2Y5iF0FG7O7bkydSeSBAV8RdIEU3VemE5C
         p/Et1/DOAHt1rIyMKpPXG5yO7wD0v7qb6+BKNDXb7dhQnv6hQ9zPVKuYW2oYK+fGTovc
         uPQNpZJtpAxMxHdXp6M7B51VbNz8iMypyBA6W6L1eswIQIQEh/B5JSKqJRhNol0COkVB
         gURF07dgKpBaJQnPFPLZKOJnklkKZMjtttttGa62j14L1d9Ocf6ZX+xQ4pV0eT8Gcdxk
         k564viq0weWFICCsGrZYyNVggRtvHLdvmcvHC7LZF59lFZlsbks9cdanI4tW8NcPduJj
         sn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126645; x=1786731445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YhX2nHzAOkIyGYt/XhkJLiFU6XfxZrwAHaxRl8HBkc8=;
        b=YQ7GGQIMEaCUv67M0kkhf+QAwEG6/MPIPJxiKYqV/tKOJZ4CxQlFFf1kbekAZgjw+F
         ezC7SbEGOImtLfwMuJ/33XRQO0bfdLBIgcBx76WEdjWpiYcu3NxOj6yNpxbBwjAjiQiU
         lJKyFC7VN5z6QwIRYSV1YtuGxNT5rYioH2XuFFfxezUf1gwINk78sepWSMUu9NxsI9IN
         UHJ3+Fxd/ehy52pGN6bAhFuWOXaBBeRb6CwVrgvADa/SF8iKDeNCM2uVHjN96XiJShT9
         OvhTtmg57Sov5F3AnnNmlUG8kylwF14LMz/RBvtTEBqhJx4ZWX/we03p7Oe+tJiO1KDj
         aRgw==
X-Forwarded-Encrypted: i=1; AHgh+RrOfcuMKeOtHu3B7jPkjHnSX08wc2noj8tntlv3hA1E9LrvqsBUgkCsE7PXDXx433G9FTJS7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwegCu/Ftxs97vIVMPXEZrtxP681xaB4rCaExRT4dfKO2EorgV
	PywlnWqwmLHUTnkC/WoJmoSLLXxoKSF6ZugOWDltJ+BQzyScczYSZqBizYsweX8SYfAgGn594Oz
	zaU4Lxuq3KcwliTZt5XmlrfDjEsdPLbs6oOPDSi+9q9+ICEMSHuMf1BAfNA==
X-Gm-Gg: AR+sD11K2DcscD4QhW0en0hO3UG6IrC+ewEL3Oiy1/JgzZXLa0R7CuXICLuxWcQVrqB
	1mUZke1lceQHwFZM56fhy2lCgVVLSVIVeDo3jG3818cRhet0rb14wYIdvoqO4agVRMwstqxWU3W
	Oceuf52ANk+mjeWrPdCAJyX8OBsOLjCvhIJNC/xbac4G/aEdQzN5pFzzgxf3Mo10/HuDfeIl9hc
	d5+eMfI6t7YL7S051ANI+k1cT6qOZ8VGGLNlT6Rw0XgniTpe4qAmvzzvTU7GK8DBV85JzoJO0sM
	FkVSihoh0Av2zKnn/a81tkkQKd8WwBdDb7wPGrXHPhd1HCyfHYuSGkHB9aItz0gkC1ieGIArstA
	2PGEBAGuPhyjv7nw0nEO1bE5aYS62WGwK/3XHnfw=
X-Received: by 2002:a05:622a:1f8b:b0:51c:2135:b00a with SMTP id d75a77b69052e-52ce621ad2cmr288738851cf.40.1786126645080;
        Fri, 07 Aug 2026 11:17:25 -0700 (PDT)
X-Received: by 2002:a05:622a:1f8b:b0:51c:2135:b00a with SMTP id d75a77b69052e-52ce621ad2cmr288737691cf.40.1786126644455;
        Fri, 07 Aug 2026 11:17:24 -0700 (PDT)
Received: from localhost (ip-86-49-241-13.bb.vodafone.cz. [86.49.241.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a2b1f1sm82039066b.12.2026.08.07.11.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:17:23 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v3 04/19] iommu/dma: Add iommu_dma_map_msi()
Date: Fri,  7 Aug 2026 20:16:58 +0200
Message-ID: <20260807181713.228535-5-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: S-KEoxezJmi1izBKc3IOiRyh0qgZ7wzx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX0EALnjRQhQsU
 OGK4GyVsW9vfAVboWD7XpZRnwuYrgp3AmPeQbr2IW6n62HJaFPRAnGhf+J+8TkL7xGPjOi9D0op
 EX8OewExXjv9OqP8bWuaa89AbxuXFr8wMWWhXcypRiihIrRnd0dQmW4wVKWBisiH15Ugy4wY+gJ
 W9FpbW/LUzoxfukFlE1wqy1JUd4cfFPv58SBXfcqcwMy4MSHbPDowyI604+5/9ZXGWNtcOkiBkh
 b0vA1j3SYiic/q2dL2UtBNGURZHVA5BeCwt91KLRoi1cCq6J3Z2T/6X1RHRB7MWrl4uGs0ofKJY
 k3A3GtEWceBnrqGZsmF4EaZ4JGAQA+ZNourfkcA7/TcdqZEq8qRcvoO9B1gQwF7sN0Tzle/fUnH
 X71zcS+Yxxihxyf3g9y9nPF/2ZsZ6MjnTSQCMt9Rao3H67tus+WR8S1kXAElyc70DeP+KzZNWGc
 0ACYwYOE/dGm9tWPA/g==
X-Authority-Analysis: v=2.4 cv=bcBbluPB c=1 sm=1 tr=0 ts=6a762135 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=VPysOpcHbS0DNrM1Xqmyow==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=nir-2xX3lSHJcyBuNR8A:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: S-KEoxezJmi1izBKc3IOiRyh0qgZ7wzx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX4HYh9k7KSIvC
 Mm0PK3eevL3mnpdPGmWXJyy8V7Q9x0xdV1qN+C+wSV2w+W3fW9vJs7Mbzx26d6ACDPf3hX5++io
 LdgaCsQcyjKvk5qvpscrxvobf3iskEw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070143

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
 drivers/iommu/dma-iommu.c      |  22 +------
 drivers/iommu/dma-iommu.h      |   8 ---
 drivers/iommu/iommu-priv.h     |   8 ---
 drivers/iommu/iommu.c          | 104 ++++++++++++++++++++++++++++-----
 drivers/iommu/iommufd/driver.c |  31 ++--------
 include/linux/iommu.h          |  31 ++++++++++
 6 files changed, 127 insertions(+), 77 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 56a5072b4dde..bcd3eb94bee5 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -2235,9 +2235,9 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
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
@@ -2271,22 +2271,6 @@ int iommu_dma_sw_map_msi(struct iommu_domain *domain,
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
index e8f13dcebbde..15adaf55666f 100644
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
index d20aa6f6863a..1745ef1525da 100644
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

