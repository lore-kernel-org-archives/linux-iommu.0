Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C19E411F80
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606322; cv=none; b=CZsgicn9qDZuyfTry9nJJsfkcj35NblKbjrjDgTF1i8g0xESnFi3kpIe2BaV8FX8VJP/cAK2Gg+VuECk1fucrx95BgSdoYiwEIbrEMqfAhm8hEdviobFKvbvOCSBOqexuNxViSs3syu145fepcGnP4T5YnsvN+hRkytEl8yesW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606322; c=relaxed/simple;
	bh=NhHWvvnPrKHqhuhNVk7ZQTsH1c0AommYN33kTZIBFec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xxv9yF1PYlxlyNUUYsvAh/82/Ji7rsYeh/pPW1Dq60XMGry95sw+w5NY6nzqQGaLvZCmm0RLmjZLCKlIiHcZO7ehgzhbRfZsDvw/hiBHkGpD4xpjKlIuWmkaNVwgYvWpk3Z19wQL/IcBKm6Hsxz6RgUJyMNeX2PThzLhkVZBmUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DQh2DnuU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IU42GV+H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DQh2DnuU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IU42GV+H"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBARFm1450513
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=x8hihcxDh4v
	dXDXwpEyXNTTs8PuHmt2UDYR1utBPvS8=; b=DQh2DnuUabqm9/ORt7u8x6SNgJO
	S0gCMFqIFtppT9jcPG2Q6KRvgguxsg1JozzSSBSYi8titOZc7N9/gGHm9wQ3mLTJ
	hxxHYX6s9abAAp6b2yAx5XO2t7NvToQBApOkiqfPF7TRHts6Dr068OABC5A7fXdy
	4Rq22H/pscgK1b/9Jg+ccqKL7NJbKEBAprYPCbT3jFs4Y9uJfT2TKVjG+dr1Rf1U
	7L/CEsC94Liym0yKEG1ZbW28nJTLwJVKNxPEivUuPlZVLUDVNhxK94isvVcJbEro
	vzzM0sTIiJVQpHWx97vcuYjJBWN2MgcW54sAiuvW2EEoKviePxi24HmVJqg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjkxhwpa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:38:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5332e744789so42446191cf.0
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790606315; x=1791211115; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x8hihcxDh4vdXDXwpEyXNTTs8PuHmt2UDYR1utBPvS8=;
        b=IU42GV+HEsykHrk+MYLbd4tEN15f6LMCY2ZPNXc10/mhBuZL6BLbSBwgOP1mTXKvHg
         EXsUBPzV0CnNtWCA5VuOZqSUbJ30INTlVfUHH4aYdJs16eAu2BV89Yw2xoLfPlZw8DBU
         mVd2eQwKTaslDx0T4w9IkasCsxC5g6VEO91+tAUAe7XP959bbUF3fBxcXecBb9SUg1L/
         3l8HGW/NfcwCCNlNrNrKRqbDmIWCwvIiovveuS2ADaKScvBgXvxIhpbtOSE4jefI9NIF
         dkbOyd9Ij0M5CA+q9+5LKN/L35jI72FqIYk6Ln91q6elCccYSGFrASJvwwVg6MwWmHe1
         V9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790606315; x=1791211115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x8hihcxDh4vdXDXwpEyXNTTs8PuHmt2UDYR1utBPvS8=;
        b=bpiuzQEVQjWOZCVtrwj2RWxjZ4ZyF5dN55JMsRXRueg0qehgIN77pVz4gBAhoStpZ/
         TvMu9wxrBAY5Vbk7smIQZokHBu0VIUY2cYggvwSCjz/MywBASLOoHsh/WT7GC4zCL8hd
         ySDdKNOriYAFNsQg97cQ/1Wrl962+mXxJxeQK+6T4XU4L05f4q2KuZpTmq2GYadG/J11
         0Pr2Mcd/Md+GjoBmRDZ2LZ7lU/HQ/VOLr9eJw+K5/TX13vx6qrwFHoz4YmKfL/P5JTwy
         KUxTa+I/EQJJAPZzU5DpQLE40+rYt21nEXZGB1A3pJxGnfTAA/ofdT4P8LyNRwaWtaMc
         z8mA==
X-Gm-Message-State: AFuF++mBQPSVfkjWb6xMQ423zq4Y09R1G9UhwXYQNIweR51EKMHiDbJ4
	HJw5mEOLmuhj1UUsKKwqMdqtgvvitgd8xXPZuCBmlIxE20z+rZSyCWYrPdu81N+clvauTP2qBZu
	2Avb9b18+vtbaJ+PneJw8sWDeKp86bgeL3tRsrNQ/HE7x9G613nXVnp1eLW6I+zxk/A==
X-Gm-Gg: AYBFou14ZZVmWrbwaGp66yVsTnNQz0KgGiMoRAs5pwAvDuoqqUqj6K0L/24n/L/MpCe
	mhqTD8mQi9yULj7bOhufR1nTBB6QrEXd2YJUZC5ZgxA/Gu/POSbWRG/p4mQSkXgzLNv+Sj4fjIf
	8NdeoypVdybah+wrLIJ/LTjDNkx/PTeA3YPJrlHUq6GB9R3SCVMX6/NYWhP0DOf1JsBdApJTb0d
	9xCLBbeB//os7pK6/GVyp2ilj3gH4apKqWflKoU67WsQx9HXa+U5vxMIng1DbAB9DaqmxU9VCUq
	e2KbVGbI9qjXDj+voO8ETV32YpL0RgABtvG7LmlDdTdo5S6ktediNqb9JggMi/c46+PcKVa9qO7
	oIDvgrhc5URYxr4IAEyhXg1vslUPIAP4iUj3abQ==
X-Received: by 2002:a05:622a:5c10:b0:532:cc84:beca with SMTP id d75a77b69052e-5330b6ba69amr204034971cf.41.1790606315003;
        Mon, 28 Sep 2026 07:38:35 -0700 (PDT)
X-Received: by 2002:a05:6102:36d4:b0:7b1:6028:5475 with SMTP id ada2fe7eead31-7b1602862b3mr1832613137.12.1790605901953;
        Mon, 28 Sep 2026 07:31:41 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae6069145sm488812866b.0.2026.09.28.07.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:31:41 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 05/14] iommu/riscv: Derive the IOMMU from the device in IODIR updates
Date: Mon, 28 Sep 2026 16:31:04 +0200
Message-ID: <20260928143113.49838-6-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
References: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vwdhnU9IhShYXY6L2iaRizP3rHfOtf8m
X-Proofpoint-ORIG-GUID: vwdhnU9IhShYXY6L2iaRizP3rHfOtf8m
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfXyt96Hi0p8CWl
 WnZJTc4hXgAJFgp7dIvHbx0uALP60P0VZfC5O0A4pnVuw6VlRxdGv3cb8f4jmGVhSQ+ZKrjX4hd
 rZuYV867mIJozBxHE/HL0wKWu7h48kI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfXxaORpc4GWYsC
 mcXlhLLKdvu1tlhV0S0Xb27JcLVMEVD8b+dwPW+u/nqX6QTdyM/QZ4itu8C5fPgaBliXLLT1tHW
 mOnRThxZCaSMHyrr3tS7QZA3xyBFTr0LeKq/Hl6YiPmswnwvV8E3aoaotb7JmKYuZOzQPBZYKlw
 C4B4SF7SFB/va07Va4zyS8h5/6KTMK3COw+bJwIF/1lGi9mrgxSmFRgsSQrwPGdPn0i7u5zp9H+
 Qc4/JpkQVvgQlJ2z3ei7Gc7eLh1Xbu6FDF5+kTdFMVM+Nsme9665WAB7Tm0mmFME47j/2I39fbq
 W9lMKWHBjbowsFKhQQojkk6bNAVfarhdXmw9ygugGwezsL2/itKLVejk/x8tTMpHHWe5Yan0Dki
 YqXlOXw7+GCDChVbnEEVc0v4N0GWRF9JT5X0gOz/qGWZKgSTZSFR2G+7CuXgHlXPdNA/bigB7w2
 2Us7MngCVm23chUII3g==
X-Authority-Analysis: v=2.4 cv=QZfzLcbv c=1 sm=1 tr=0 ts=6aba7beb cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=5LAesA1oWso2HGznwIcA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280058

All callers of riscv_iommu_iodir_update() already pass the managed
device. Derive the IOMMU instance from that device instead of requiring
callers to pass both objects.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index d48667112cd9..2cee87ffc122 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1265,10 +1265,10 @@ static void riscv_iommu_iodir_iotinval(struct riscv_iommu_device *iommu,
  * device is not quiesced might be disruptive, potentially causing
  * interim translation faults.
  */
-static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
-				     struct device *dev, struct riscv_iommu_dc *new_dc)
+static void riscv_iommu_iodir_update(struct device *dev, struct riscv_iommu_dc *new_dc)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_dc *dc;
 	struct riscv_iommu_command cmd;
 	bool sync_required = false;
@@ -1514,7 +1514,7 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 		return -EBUSY;
 	}
 	riscv_iommu_bond_link(domain, bond);
-	riscv_iommu_iodir_update(iommu, dev, &dc);
+	riscv_iommu_iodir_update(dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = domain;
 	riscv_iommu_msi_tables_unlock(old, iommu_domain, flags);
@@ -1660,7 +1660,6 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 					      struct device *dev,
 					      struct iommu_domain *old)
 {
-	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 	struct riscv_iommu_dc dc = {0};
 	unsigned long flags;
@@ -1669,7 +1668,7 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 
 	/* Make device context invalid, translation requests will fault w/ #258 */
 	flags = riscv_iommu_msi_tables_lock(old, NULL);
-	riscv_iommu_iodir_update(iommu, dev, &dc);
+	riscv_iommu_iodir_update(dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
 	riscv_iommu_msi_tables_unlock(old, NULL, flags);
@@ -1688,7 +1687,6 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 					      struct device *dev,
 					      struct iommu_domain *old)
 {
-	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 	struct riscv_iommu_dc dc = {0};
 	unsigned long flags;
@@ -1697,7 +1695,7 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 	dc.ta = RISCV_IOMMU_PC_TA_V;
 
 	flags = riscv_iommu_msi_tables_lock(old, NULL);
-	riscv_iommu_iodir_update(iommu, dev, &dc);
+	riscv_iommu_iodir_update(dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
 	riscv_iommu_msi_tables_unlock(old, NULL, flags);
-- 
2.43.0

