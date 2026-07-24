Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A8E3DB335
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905953; cv=none; b=jVb5BJvq9kF4RWZqyqNWiwBQJN5W5+TgV5P/9g3livuWIvLawt9F+qfnqTwd+N4bF/uK4qHdfLcD0g9BbUZH2SP8uSs4YOP7pxEJvVXi4t5ex5wX4WIptUPa+2K2ekk3bm1lpctu1gd8JHew96xXRFAjq6VT64HUAMzld8mVKLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905953; c=relaxed/simple;
	bh=n78M4a7JJYGHZH5DIfq9JA/9D8KkY3eL2vELRtMl31E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJOp2woWM2w0vshIJJ4GoEx2AIuzCg2eXl3YFIwkZr1blhTj7RhVKtBRsX/Cs1I3mm61CiMGk192Alvx+XJoDXWT4Ju8prkPIbKlQO+VuxQbnlmuMlNxs9YB2ivjYaMGYFD6bN6bSk6KJHPtRC9V/GqGWNR05TvSmbVe4TGMt00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M0/umBr4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MSZkAHwS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M0/umBr4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MSZkAHwS"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbNwh3196412
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=eAh9a7Wj9Iv
	1rj7/bqx43VqNRAg9bHo23nmovr6/atI=; b=M0/umBr4Lh9U0ZgCved7lsconRx
	3WeyhuIWA47ojp+HKdfbumBW2f/SQ2sq0D9PsVv3lamRRpVEcSjPMATTW1v0lywB
	s+rf+5H2WrR9TwK/lZHITu9NoSWMvwxwf/n51tmYsgsoXaUwkjiGaM35AxOR91sn
	/F2060KSn4y/JnIBnRB9gxYlNhfOfGWkRBY0mcvwnM5BeadXvdO8+AxlU/vK6Dtk
	OOC0BWykh0Xc8MtCGznphkCIwHYQE2pdFIKU8lk+qZZu6JvNqJH2VjDYkFQC6SKI
	43KL6clRZearYsSB8PRkbQpaPAskHpU2oSk1DHYg1gmQyyyKHBtlYqmskdQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm0p52bqd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1a97644aso10056021cf.2
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 08:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784905947; x=1785510747; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eAh9a7Wj9Iv1rj7/bqx43VqNRAg9bHo23nmovr6/atI=;
        b=MSZkAHwSkyAaMbcYQR3Xad5ySi8u9K3kD0YQLcfzCNFef23VBKsivnX5bizpYFZwKX
         LHdVUGgXFeqPQxqnlKcpjtLR8Pcmam0OFy8VRHeZgcY52LwmlPhs67KT6XkFmwkshINw
         zIBfKJsbTcwoF4zdbbIYrFQ4pvJc0eaRxlTMxisunJflZSoVQeNsGn7obONjA+77W3bI
         1WEH2+gXyCqQCM6ejhe11gck2/RHMjq8UUpT4+CLmSVV1d7oKC95KcFN5TQbJ9l1xaRg
         rsJr3gCUDevDy4qFtYE2SSFByUdg8DrnLumPB76TB4ukgBMntrZ9nRIKxEpIjGnpIGFt
         QG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905947; x=1785510747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eAh9a7Wj9Iv1rj7/bqx43VqNRAg9bHo23nmovr6/atI=;
        b=eV0jB8YjZi2FMANJ8ClSN9sW138NZnbptsQxiT8peOZlOCYunAbNsQJQsaHnhvJCph
         9OyiSkV6B97kBZ8j80PLqai1spGPxxI94hLDpXouwveltSS+qkpHSnMTDJlu+C0TEf5C
         oLvVuBom6kYsPTgfRHn0nL7kFHwogDLDgD7ox52cbcVRlhz9s9MoXC/1S4UDf4sO1ky3
         /2KNUcltN7swIKyco4F3hzsdBsCvm/dAgMELYjKznGI4nDzLigtdo/F47+WIwSJcAB1O
         /lY4JRRRvudH0RAF1unFdQUi9U226ij1pEcZFh589w4Jpn7Xzb4o9BpR3F6lJ62pQmTr
         zIxg==
X-Forwarded-Encrypted: i=1; AHgh+Roe4dusZ3X5EE+EpAYwug6R4ooSBK3we4R+AEQHf97M5Wxnla/KNQbsJluRKikctMsD05DEjw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyru6gWJKyDqk145HSRUT6VnKLfkgySFYdB3jJGZuuEIquQLbGj
	OA5OIPBJHgD6PdWfoa4kcZ/8VdwiX96g7XgBPH7UKCUjG+9rhlxDFCo0L+xejC1C663K8cN9D18
	iNiKSpnqsTCWxmWzltcymJyGrOdw7wabJAm52tIbtieLEVWFGZGFbafNH7g==
X-Gm-Gg: AR+sD12kYM40E8EnI+CHdDSbMoj+cg0DBJSfFudN3QsSIBUDsGs5SAp62Udy81tm34U
	jFsyiZnzvaEy03Ez+iF7Z5WEjq/8H501i3jVN3SD/+dyRUO/ae1102xGKjdqvZ+5/DwIRAKSilE
	u7SGmlUJfws06ISmwAoZUNwEXwZoMbkDEgNK29vq5jHpGwTcD5+ZgcEBrZ2dv3YpfRT97+j6R0N
	WtV93nYUDNBIQwMYqWjn5qpT8K86XMgHSuTJ16Z06ui0n+zQPTFX0Vgg/d3wvL5rGJKbjI2QEte
	DyRfVvNoYClUzKOdOzxC3Ep7UXrtqzZveLoGhLFSa6Msy6ogzrJw0mSe3EVfdckzw81co5rTH0j
	cmPYMNwhtx487dZ0PltFve0bkFS/OubRfZZVB
X-Received: by 2002:ac8:7f41:0:b0:528:320b:305e with SMTP id d75a77b69052e-5283de316f9mr72395201cf.35.1784905947323;
        Fri, 24 Jul 2026 08:12:27 -0700 (PDT)
X-Received: by 2002:ac8:7f41:0:b0:528:320b:305e with SMTP id d75a77b69052e-5283de316f9mr72394751cf.35.1784905946785;
        Fri, 24 Jul 2026 08:12:26 -0700 (PDT)
Received: from localhost (ip-86-49-247-5.bb.vodafone.cz. [86.49.247.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb5958ea0sm88142a12.31.2026.07.24.08.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:12:25 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v2 03/14] iommu/dma: Add iommu_dma_sw_map_msi()
Date: Fri, 24 Jul 2026 17:12:07 +0200
Message-ID: <20260724151218.965929-4-andrew.jones@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Pq6jqQM3 c=1 sm=1 tr=0 ts=6a6380dc cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=aYZ+cQcEYoLAp2L633VOig==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=B9hF7e9JpKM1iJhnVVUA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: QJw1i6nors3smRZbaPihBDtpfzZr8ZLN
X-Proofpoint-ORIG-GUID: QJw1i6nors3smRZbaPihBDtpfzZr8ZLN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX2cm/8DZ8HBZ4
 Nuvinlbr8SomFdnd+TF8QXhhc4N15APQLE3/M/7crmnmZ6ewfDcr2usEdxovcqaCb9obcnSlCir
 dow8M0ZzE/OWg+seAgyZOOpFih1a1EE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfXxuvN6Zno3Inl
 XAmq4W6PU1qDhgm7t+PejbXxyI+8YqiplvHuAVvSfMZAQjtm6y5zF/fTuaSV8tx1rynas6Gio7k
 eFN21E5ajH3BIGXM2EvDeKbfEgfIzBU1tmKS94D2jA89n+Y6AbqGn9SUCAVC3geTX6M8LseGBlN
 U5QtDEV6Jkdser17e6tZRb5acTX6JblwNhgOd2FKhsbpHQMZ+zFrWHNMM0gvVcTTfhLKDDqov3h
 rxy81taB03oaNkrgQGwU08AdPwEUkXbuNXx3NFQIEiUrgNarM6BMEnVCYNjPakcDCtGUNXGhzSH
 Rr/ymT6TF985dy/mDjWszpfwC7HEYcvWlgEaV/VHtEZbLTmUtpE1Cor5DR5GkbtIoq+0ClUBLme
 gnY71MkkTy1ZfA74bmLPpjMvhBR8I1phCFP2UjYymrXcNUEEzSjPLsV0igBCqkl9K0iLWge79cd
 0wKuKKenI1Yo3puyv5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 clxscore=1011 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240137

Add a descriptor-free counterpart to iommu_dma_sw_msi(). The existing
function is tied to a struct msi_desc and stores the result in the
descriptor. This variant returns the IOVA directly so callers can
pre-map MSI targets before any descriptor has been allocated.

Callers may pass a required mapping size so MSI doorbells that must
not share a larger IOMMU leaf, such as RISC-V IMSIC files, can fail
before a mapping is installed.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/dma-iommu.c | 39 +++++++++++++++++++++++++++++++--------
 drivers/iommu/dma-iommu.h | 12 ++++++++++++
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9abaec0703ef..c26b071d744a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -2234,24 +2234,47 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	return NULL;
 }
 
-int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
-		     phys_addr_t msi_addr)
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

