Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436C24657FD
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262122; cv=none; b=ElDNtrt70sQe6XMkOQCNIMtHFtIui4WlQokrG/RNVq9mi+2vhq6sAU2WET1aH6d2hIVB3zS4MPEJFqljkv0BHMq+MMpN8Z5tSW3f8hOlX5OURlYtZQEbw2DRxY2uetDc1unWbkZ08EF41T1xRbgAYxwKizuk4e/1e26Yqp453DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262122; c=relaxed/simple;
	bh=20/oMPU96Nis5oh5Xnu9M/9yRMdjxw1341Lef5oF/DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qjny3UE1oZ25Ev4QNxyDL4EXjkc53RMWnYGfSBuoQevv6zkiisQvP9RmqH2UfeNJNYCWtHKGZT+7fJJdR7t+ygeM0QySNaOXw+vYFPIbeSg32P8tGwsCtVdu6ejLWd+bS/Z/bHJNhu9AVFPQ/Xa+zMXnCBYYOG7te2B/iwyVscM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bndIb7HQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hRH7FnVb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bndIb7HQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hRH7FnVb"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK7XQk250308
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+m1BHDhHK9T
	Y2fxWAkv5d/udjXarPp2DOE+7KtvToDU=; b=bndIb7HQYHDGpUUyyq6mwwz72Iv
	6cu2le0Sl7jvB7UpNryAj3+yX5zOjE2C9CdA4tjAcPhFpg+UulXaLI8x9G3ue7Wu
	lUwf5y8uxtvs6iIquyS9+9ik557SfXj5sX9e8ynTwjxgx00xlQfJil1mDF3hpenr
	Swnd4zNBAj1gY7jX/T9qV51e6Tet6uH/2zmXQGAmT4uTig3fVdwAFPvh0xByv7+i
	hA+Ue2kQ3sF0xUVsmsB76GwMZJpuh1A2ib8o2kCSLvlbYljQBr1WBhIWiApiVa8b
	Qi6CKYogIfsBUnfJoXRGVPr8MVEWbCO/LIPeXzDduzBz7zi0iRiEiuEp5jA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5w49bqpb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e82060977so30193985a.1
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787262119; x=1787866919; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+m1BHDhHK9TY2fxWAkv5d/udjXarPp2DOE+7KtvToDU=;
        b=hRH7FnVbrUGlnzrrlQkRXzQghOPTc9srMY/9VGlRoTyttrySRUbzSVGpd8CZ56SNB8
         T5HxpC3k57uB4HCWw5vnTUx7uopidbJMpvi3VV43fjhn/1JM2DxfwmdCpQpIy0jQF2Hq
         CkdM4dHZF9o5IO7yOn/jjTLQOm0SBZP3qbvWHJxf1Kprl5RZ58u/hbGelAQwgOmC6AAO
         BOyyXP9zGnnXXgk9E3d2diGiCll7w2YR/CGWlzqxUATdtUtJirtLGkdmT6WTzzof+GSb
         5m6otE6/cwpgrd/rN6sNNoWFeG+TjUX4D24yRbeQpl6Aor8nsryXQRPQs0u2k4bk0mz3
         zBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262119; x=1787866919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+m1BHDhHK9TY2fxWAkv5d/udjXarPp2DOE+7KtvToDU=;
        b=hJk9mfoPF1BFIedwyRyNC936vvX0+zJ3n2EglwpC1Q2skCYRM5hfxf8zHe7aJH8DBQ
         4+Ej7PbPLmQAIWfZGa+90HLkCGiSReiynAqvDgi7d0m1JrC5Tcvuw9zTGTVh+OqJVhcp
         7XINLoyVcgDiDMMTN19+8dg2Og0xUtju18aMJL+XOIL8sMjV/Vxlm4FdeI4AmgQ+OHL+
         JmxtEN7M0+rBM96kZQy5wKYhK/fsujbP1UVLq9qFgPOSA5RKDn53F0EZyZGvoui7t00a
         UAaqquz/3/mWwMHLu0c56MWcCoTZhHwhLhS3zFv58xAnvCIH7nsf5MqMONcYnvWS7LNI
         wEmw==
X-Forwarded-Encrypted: i=1; AHgh+Rq71wJrwKTMw6fVBQRXNaIKzJ/Uw5Nc03cVhFKRZ2SczUaFM7MK2zPtnKZh+pQE3x3vQGWp1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGaNjjBKyrqwDV6r7n0LhYXlD3xEH+VLRy+Cdm9YEP+kQqo/kB
	ZhSPia/FAv0WnnnvgDGNXicL0pvJptv1Zf5mMl76KFvMRfnygbExpSXOuS4PPjfGVllMY/uU2dD
	Ayr9krh9YZiU6mhxcfu+YJGsm/dqUQXEW0aKj2M5uIV9eC0d0ni9aCKxi5A==
X-Gm-Gg: AR+sD10ktJLkqLhuKp8T7isQdFf6Sh83oONlUrq7CQP0LoKKyud4F545OPWn/lWw8Xq
	xPDh9GX6o73dVGhfmQ7Tts7gV5PhvtHOYeqP6j3tc1R24cibsNG+3Btstx7CUuiIQla7ayJe4np
	VR0Xu3UcF5cdkoFl9uax6/Qvm4oJ405JtaM0pLNckhQzMXNFbo3J6OO6yjaihjS9JaS5oPi3nI5
	Md10FWfAoamJday2RlrHIUHs4onVUJ4Kql4W7rGuGjgZtK0Yi2t7+rE23cnCz+dVJtZp2rwB1Jq
	dpfIPch1DcVO8koETK77VUpO86ZDaqO0/tz+6a6nQFywdyUBdtkC9Zqrk4q+PoyB/1WK4wqVoJ8
	5COWhasac
X-Received: by 2002:a05:620a:63c8:b0:937:17f9:da2 with SMTP id af79cd13be357-937283b5de9mr979111685a.6.1787262119607;
        Thu, 20 Aug 2026 14:41:59 -0700 (PDT)
X-Received: by 2002:a05:620a:63c8:b0:937:17f9:da2 with SMTP id af79cd13be357-937283b5de9mr979108785a.6.1787262119202;
        Thu, 20 Aug 2026 14:41:59 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c3775sm13092981f8f.26.2026.08.20.14.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:41:57 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v4 03/21] iommu/dma: Add iommu_dma_sw_map_msi()
Date: Thu, 20 Aug 2026 23:41:32 +0200
Message-ID: <20260820214150.545737-4-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfXzz/K9a3FXad0
 SWF9H/Ti92uMQNRMH/diGUVrHbop0GHIeKkwgXVo5d569WCfOrxnaXTkbouCtTgJXbM2eFnGYy0
 CwM8jEUhm+/AjfGvqDaWJcw2F+YqEjY=
X-Authority-Analysis: v=2.4 cv=YP+vDxGx c=1 sm=1 tr=0 ts=6a8774a8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=B9hF7e9JpKM1iJhnVVUA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: UwZmSGRmhCD9gLgEGBOui3lACCarII4j
X-Proofpoint-GUID: UwZmSGRmhCD9gLgEGBOui3lACCarII4j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX+6uX+4JPCwJQ
 GPAsslBGc2EAfNzIWJvTlQqOqn9PoHziZLX6EPq6ib81fs8afP4NQKNuIYXEMpfnMbhppU6whiW
 FFPJcxoM92jMfTalAQDxsN+IpyVFNfwsGeDEwUZhxDiaMXuKsQX3ijtG2rWzLYEyzpxU4rRKxG4
 ApHIUam2u1B0Tl9iqC4vm4cb7HffMZ8Gx+Dz7wheY+lWLZje6yV1QEvYCrXhc/SefnUYnUmk7c5
 GxQ4gvt51XKR0UZcF4qvmh4NAZv19GH+Z6WBjmpA0jMM3QNJM0X9CbmgZ3CvVDLP/ClJTG37jJt
 emURAngh2jKO65aFn8EtbY7AjnxRfoZpNSpnAuKR8ZvPNT+GV4rE0WG4wBHNyF8KKb5vReCSQJZ
 1Pt+ySxj1RQ9mfVFOZvoWeyZhXhMdEzSIC2oclqRB/ZmFa2MAN0KNkZ+xORJTC465tZsq6hupEu
 YHW8aILX/0lzXWAHrIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200162

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
index 9a07eb39336e..3ce9f4878d92 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -2247,24 +2247,56 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
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

