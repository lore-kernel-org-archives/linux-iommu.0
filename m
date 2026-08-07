Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CA6353A8A
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126646; cv=none; b=B6zI1jadSnIc//l8uGnlDG/reOTChM/2EXHjWClJAIJIKkqwTTOsvfaeZuBDwfbrvfq3a8FqpfXh4DG1LUwScRjBEQrHW5usd9NAcZr0EmC982i1PZ9GcgL7iu1OWhbIQKgeXVh+L2uZOSulOmjxbdyiJlaMInoG5UPIGjH06Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126646; c=relaxed/simple;
	bh=9EGuLpu2rrLebak5AKTd1A8lZwUe/E1CF88M0FnXyiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUFXAoi858UjHRXCiDIoVR1e9uT3W6W6nVgnzyOq6q/D7hS5QxnAXF6qqKLmWfGNCiCVkd9xfnW2CxK4Rmfc83+H3mNPNm0vefvhC4bDthllR9ng8LZGRyJ1MpJA+CTA27cvypbElwjG5q6IHAPx6uTHiuy7D3VVIPsuavbygwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GyH/4Jug; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PgN4kN6c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GyH/4Jug";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PgN4kN6c"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GbdOT1474910
	for <iommu@lists.linux.dev>; Fri, 7 Aug 2026 18:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=KeYmM5yv2MK
	4UCiDBc1w2bwCqxx0z614RMMGa5CBgiI=; b=GyH/4JugRUtBo93g9QQZKnGW1pd
	WT7ukbymRVd4+4vjjM4yWbJ1jRE/fl8zd0wwxk3pyIe0tr9lp0bwnY2O8sxyO+xK
	Mxz0cz+NmCHlsZnr0A203T1oaQ6JgbJGgewry3QkbL7XFRGe8yQ7I1Qh29ACycs1
	szINdcy+vlUpcqKKd38aFGNjDyUzyzV51o3CcRdnSrmzxuhc16z0SIOFNEB6UyQr
	8KWyB+UoIQkxPjd7iyhmH/JXCHVREcBavrjdARnswPr91nzOtA3dSB2O/uwZMSvt
	x7UNixOBoDivfUQqo1vKf7vb9f8E9+scrTMLcw1y0bVGJDB+WB0DZLb8HtQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwk228f67-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 18:17:23 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-907a1e04111so40343166d6.2
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786126643; x=1786731443; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KeYmM5yv2MK4UCiDBc1w2bwCqxx0z614RMMGa5CBgiI=;
        b=PgN4kN6cFej86HnBJ4BNIofev63WaHNNiJO2k/U2zMWqXOluo7ErUcmMkGyhiWpsrg
         eKEKX0c79XDQqQ3+D++gMrCGf1s6lnL49W7mvvIteJWtqrErBQEmf7EY5db8bDHebB68
         XnH2vGntOLgaiAFD3ArBk772jA1SZDlHY6CtTX0A8unhcZ/cQJEauiRxDRZNNOOZzMd5
         GV42FJYyKPwxTRqeO1S2ZnC5AigjJzuvL0ldf7yQQvD/lBdJFVYt4UJ0wLo6XRgb+0Nz
         DeyTynuo/a+3rvyOXS1F2MUtebfD8mQlqFHdsP/QrcSMfeXz8uYyHF/uDlS+KyfrAxjA
         9blA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126643; x=1786731443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KeYmM5yv2MK4UCiDBc1w2bwCqxx0z614RMMGa5CBgiI=;
        b=kk+oJqIJK6RvloqaIfehZ+TVoDU7ixyT+T7S10A+j3k46Gw6Dd1UUSfEqzJJdb0DGq
         BP+0yNsxsaA62l9GDvvKxWkODOD1oJOjfJrCHtHghge5IbQwHnWrYGVfSAhNhtt2VMZX
         nFDbryBbFTZExw9/2IzamdSXemkQ/TfYPUrFcyw/1fNCQ79e68THysWEEZRb4uyySezQ
         KmyqYYOeqEC3AIFC3yJP1+sde8e7apowexas9J+C17KCK5H871FquKgnxhHyuDhEOgyl
         hyYBvGGI6iVsS1q3sRCwsatg9yr3IahK5TxiAIBlqV2CB7F6F1WK0YuHeUhgjThLpoPU
         gEhQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqo6POa436P3E5wDdSoDCFlinMgCF/x1PJYHGQRukA1HX1B9Ra4JANNz/yXtFWUO6Fi/jsDbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwowkXd0go7o7fQFgKNbIauNLfu90LGfzff9T9MS+Kqo1tmQPX+
	CShs13pNgC3GHxSucvpsyNu2VSAttT2xJNkAVD0nkUC/fFlF3FJjvj616c8I17vre/vIK+oUJxH
	vEhmhoKq4ZX8QcvefAJ6p59DVkKRCScFGMOn0GqgTH7HfhF0KcmKAMQEGSolIAdtmXQ==
X-Gm-Gg: AR+sD1060HcRN3HG8f7qRs1ahUfe7YOXUOX/NavIOuc1aZ9DUoccrn2eYkWqEDmQ/ws
	wEPkUUOpz5RmuRoIw17zmrH2k+teSWHDC07qArYx1Xg8bLeXCuCmAROEq+AFWjO0ndq4yEdbTgu
	8Ii50/0lZClNmwXZU9Au41lNfUWXj2fpB9Bnu4aVRJw3gn1fdNlsH2kw+N6GMJzfSF5z5bGNChh
	aAqoqcnbliNd9Qd/QjILfRxU0HNgD/jvmj2ujoJwSsqQRpmTBIY5zHrEEYbLjxqV9yhJxajQZsD
	PMSzPWT+cmvwda7Rx+mlSCwyREq0qvnoZ2la0EhsptbPWmxevIvdGOtnF9itUh5mHQFOlpbBM+j
	zHLqea3kWhC79S/vaGaER546uA17CiubcPeNa5VM=
X-Received: by 2002:a05:622a:58c4:b0:51c:1ff:2512 with SMTP id d75a77b69052e-52d20a50c50mr36798491cf.33.1786126642913;
        Fri, 07 Aug 2026 11:17:22 -0700 (PDT)
X-Received: by 2002:a05:622a:58c4:b0:51c:1ff:2512 with SMTP id d75a77b69052e-52d20a50c50mr36797611cf.33.1786126642443;
        Fri, 07 Aug 2026 11:17:22 -0700 (PDT)
Received: from localhost (ip-86-49-241-13.bb.vodafone.cz. [86.49.241.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080ab446bsm79425666b.27.2026.08.07.11.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:17:21 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v3 03/19] iommu/dma: Add iommu_dma_sw_map_msi()
Date: Fri,  7 Aug 2026 20:16:57 +0200
Message-ID: <20260807181713.228535-4-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 30REC5KaVqDIZXY28PdK0eVFOIBuziyZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfXz+Zf5Cgy3t+z
 DOo6H1v/RzLR1S83rd44AvzQgapvYaxifB/IrbrCK7O231hsPnCv7p1mOUXVG/L1D1H/z/0JhHJ
 E09lDHuK34Py4FZz8F5QQPHs7hFkDDXC8+I/VD2bJoM4En3F9bnqnZ3ZxAWvVea92v0OKjhglvC
 PfT3/S3HArNsugHv1+zGH8ufRjdq4+/x4GM5tEj9/ZbbnbSQQQd3+vITEdM9nzfJ4qd4uUHxFho
 SiqRpZEplnc9qRoGRy5SzkfvzAqOpgNuQEN9wlmMLZrV0urpM1TDvOnv603H1DrCPqviUFHtAcF
 P/fSNmSQHSVj5ECLpXWsPCLJpATd84sBUzyBwqfsAnK+LSitpaPfxOky3JfOMFlxDBQdDWKRp0W
 d4OUwaGOu8oMyGapVIMC0/f/artwGFyeNmFJFJfcV/uoPCCdGyK2f9TH5fknbO6ZNqixiTYu459
 euzUrBBzcIHHCAcTz4A==
X-Authority-Analysis: v=2.4 cv=bcBbluPB c=1 sm=1 tr=0 ts=6a762133 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=VPysOpcHbS0DNrM1Xqmyow==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=B9hF7e9JpKM1iJhnVVUA:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: 30REC5KaVqDIZXY28PdK0eVFOIBuziyZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX9tzY4WI6HLKN
 QX0qV4Fx+FOa7KVFu2C5SHismg7Ku4g0v1WcTEYLI6ycIWzJ141WV7h5Jbqc7riYPyMKdTmpCQ4
 Ao4rYSxNYxrfff2wLuUy5skAC5Qu0E8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070143

Add a descriptor-free counterpart to iommu_dma_sw_msi(). The existing
function is tied to a struct msi_desc and stores the result in the
descriptor. This variant returns the IOVA directly so callers can
pre-map MSI targets before any descriptor has been allocated.

Callers may pass a required mapping size so MSI doorbells that must
not share a larger IOMMU leaf, such as RISC-V IMSIC files, can fail
before a mapping is installed.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/dma-iommu.c | 48 ++++++++++++++++++++++++++++++++-------
 drivers/iommu/dma-iommu.h | 12 ++++++++++
 2 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9abaec0703ef..56a5072b4dde 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -2234,24 +2234,56 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	return NULL;
 }
 
-int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
-		     phys_addr_t msi_addr)
+/*
+ * Descriptor-free counterpart to iommu_dma_sw_msi(). Maps an MSI physical
+ * page into the domain and returns the IOVA and mapping granule. Used for
+ * pre-mapping MSI targets before any MSI descriptor has been set.
+ *
+ * The caller must pass a device attached to @domain and hold @dev's IOMMU
+ * group mutex. If @required_size is non-zero then it must exactly match the
+ * domain's MSI mapping granule. @msi_iova and @msi_shift must be non-NULL.
+ */
+int iommu_dma_sw_map_msi(struct iommu_domain *domain,
+			 struct device *dev, phys_addr_t msi_addr,
+			 size_t required_size, dma_addr_t *msi_iova,
+			 unsigned int *msi_shift)
 {
-	struct device *dev = msi_desc_to_dev(desc);
 	const struct iommu_dma_msi_page *msi_page;
+	size_t size;
 
-	if (!has_msi_cookie(domain)) {
-		msi_desc_set_iommu_msi_iova(desc, 0, 0);
+	*msi_iova = 0;
+	*msi_shift = 0;
+
+	if (!has_msi_cookie(domain))
 		return 0;
-	}
+
+	size = cookie_msi_granule(domain);
+	if (required_size && size != required_size)
+		return -EOPNOTSUPP;
 
 	iommu_group_mutex_assert(dev);
 	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
 	if (!msi_page)
 		return -ENOMEM;
 
-	msi_desc_set_iommu_msi_iova(desc, msi_page->iova,
-				    ilog2(cookie_msi_granule(domain)));
+	*msi_iova = msi_page->iova;
+	*msi_shift = ilog2(size);
+	return 0;
+}
+
+int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+		     phys_addr_t msi_addr)
+{
+	struct device *dev = msi_desc_to_dev(desc);
+	dma_addr_t msi_iova;
+	unsigned int msi_shift;
+	int ret;
+
+	ret = iommu_dma_sw_map_msi(domain, dev, msi_addr, 0, &msi_iova, &msi_shift);
+	if (ret)
+		return ret;
+
+	msi_desc_set_iommu_msi_iova(desc, msi_iova, msi_shift);
 	return 0;
 }
 
diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index 040d00252563..3e1adeafdcac 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -19,6 +19,10 @@ int iommu_dma_init_fq(struct iommu_domain *domain);
 
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
+int iommu_dma_sw_map_msi(struct iommu_domain *domain,
+			 struct device *dev, phys_addr_t msi_addr,
+			 size_t required_size, dma_addr_t *msi_iova,
+			 unsigned int *msi_shift);
 int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 		     phys_addr_t msi_addr);
 
@@ -53,6 +57,14 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
 {
 }
 
+static inline int iommu_dma_sw_map_msi(struct iommu_domain *domain,
+				       struct device *dev, phys_addr_t msi_addr,
+				       size_t required_size, dma_addr_t *msi_iova,
+				       unsigned int *msi_shift)
+{
+	return -ENODEV;
+}
+
 static inline int iommu_dma_sw_msi(struct iommu_domain *domain,
 				   struct msi_desc *desc, phys_addr_t msi_addr)
 {
-- 
2.43.0

