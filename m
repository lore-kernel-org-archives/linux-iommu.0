Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F989443A86
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905968; cv=none; b=MHz/1xpnvgzV7w5LPa+C3klKK7rg/WpaATHYYLzjjWFLQxfG7rTNB2vXq0jeuivPW7EHnUJ8LfOxJYqe4t1+9eQiqsrfHytHP5Ca6uQd9zlnvL6YFRao10dhqES9y49+XgCNgSbEwOTYa3iE7Tsw8lUxViqKc7zJSn2dROEMKFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905968; c=relaxed/simple;
	bh=qGu4fWV0+KQ0OrOjmC2MruaThXv+chwRyHeAtwob9XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qg22mwsrYG+E0OLeWR2UtEMfEgiDpDCKByd9Pi3NBA955QfeqTvcp4DPoeJ2tqEAilhU8byUyVv2s8P/YaXQx691tEyOiYuhYtZYXurGH3vuyzhF8ds2sYgisj4PpKZL32ZILNIpL6xQqpeoopAxG61YGGkcNUw+XjKJ2veZUD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bvAiqVQp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q43rBCkI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bvAiqVQp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q43rBCkI"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbA1g2933480
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Kb1rc9qc+9I
	g+1s2Cbs39l2fJgnJC2UI3clybMIXgk8=; b=bvAiqVQp7grUisnCTHhD+A7eZZi
	Qc/4VEqNeBTp584Awjzc1wQKXrYPeZgJEBmUYmM7b4BQk6UzKELb2Zgqq2gmXk1Y
	UjJ1ZG46Uah4a3JG3OahfmS/T3GOEk0GJdycqmYmAYNcnmWW3j3oI8Iqu4LUCpWp
	9HhSEf+HAzfvZRNO5To9FSFzgTwbkXdtZN2wS8Izr0jYOq3ClUhl33NwF3UAIjS/
	OoxeOhhqblEl67J3nHTbg9ApsTJqel96UOXwh2ltyHNwk2z1gPADAYfQ0/hjHidM
	dUE/l4XNbT8K7BxcQoeMzImf1XTYVRbFror+cMQ33EhkhNpPejCYW57fvvw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm8cj8hcf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52769fc3f2eso8721491cf.0
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 08:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784905961; x=1785510761; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kb1rc9qc+9Ig+1s2Cbs39l2fJgnJC2UI3clybMIXgk8=;
        b=Q43rBCkIGnmaoV1fzZgfBsVJt1mXIcV25YKQ8SEwARZ9pxRpomGDFAptRoZX5vS/M8
         PQLIqkYy7tLcidBVhW1P03JLsV2a4ZvJlkkwFA3u9VKTJBVZM+DMt0wVcBfJISnUBW+A
         17g8l0wbbCPLPKLtBrmWNloRpP8w2Zv3aoHUz/7HCrdwNChrpiCBxkYEQ1aNwMwbBLf0
         QG/Dg1a4Kmi6nuGVZ5vHGfbfzuk8jD6n5cNAAcYKmW77lxukRJ7A/WBeEJsMJDN05xxs
         0TMqZev0N4ib/lHUepbN8UrgTi7J68HRrgqmbpqaUCmrBIaGiQdCTB6RuqMVeay50zzL
         peyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905961; x=1785510761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kb1rc9qc+9Ig+1s2Cbs39l2fJgnJC2UI3clybMIXgk8=;
        b=WT/Cju7Nwj9jWMKTn6wLFXnmmasov3YiDhvVwRvo9W37f9EacRRschtxpDmKb8z9DN
         Aeu4Pnw/aQZXVIMtKSQ0trusunPX+xZvzuMyZbLvWkziASrpe4vqDDhdtUpcj/b+0FXB
         +Ex6Oy/y3MNHcp0rez2Vh9HnxwTiZP1MLMNakJsVapOJoTVzY7iH1VBZCUMpKzacSL6C
         ThfB/tetBbYHleVdNyNtj0CX+CJJmMnQq4C2xOCoeVhZe1rNGbdC1Jag5DHfy7lMms4N
         NIQjh3WYyVY6/vXDu9J+dZsTe70xCQW6sXGtWxxiWF+rJu5Yw1hTSNvB6Qvjt0qPUiHn
         Yy8Q==
X-Forwarded-Encrypted: i=1; AHgh+RrIAbxZnIdRU2H7RHKjQ/bPx/2M2HykpVoNM+itHaCeZzd1WTOUANw34EbYo+3iCvHDns0Ysw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+hbK8VZTJeVAgUny5752RH2HK9E8Jl5FIMe+foQ84has5dwej
	vt8NFEj8iFay9+UXJ38jttI0u3qqOpQ6ton7gBNIL1w6sMXLMQhjIekqu0hdDS7NSpxZMoCFG20
	Y3CLjYrqmJUJ8Te7SeFaVQYyYr9Ipu/gxFDKRCfX4I2AxfC0XWUJHmvnoiA==
X-Gm-Gg: AR+sD10CclAINcF+ZTL+P9RQIK1GHezI9GH5d7/M67jyxJlfNSro3PYfveHoBFipucV
	asztHMOlnCC4L4X70DcQS5nXsoS0i0eLL7hX++BsnthBr1im+DDrT85m0gZcX5OI/y37HlWI28F
	9FqNR2t6jtfzJapmxDwlMvq00cEZMWudcPkFWk5lsPF+QRBEy1T9dCH3UCbvVgNThWlyiYL8yDB
	80hapkXIAeEsMsqUOdjgjw7TywEL9BTrRgAMg6Rzd3Flr9CjXR+5Ftr6TWOB8v36JWFemLD/JpA
	rjCCQKvN6Q4KhUEr6K0RXd1Bes17IEV/QIQJ+ji8CReLUBxTrnSxn7qst3Eu/1v0X5/fXlZzbe3
	Spcs1pO5WzIa5ewctjO+qyN/pmYAjWIQ6MWUp
X-Received: by 2002:ac8:5c83:0:b0:528:15e:d1d4 with SMTP id d75a77b69052e-5283ddc7afemr77628901cf.4.1784905961023;
        Fri, 24 Jul 2026 08:12:41 -0700 (PDT)
X-Received: by 2002:ac8:5c83:0:b0:528:15e:d1d4 with SMTP id d75a77b69052e-5283ddc7afemr77628281cf.4.1784905960493;
        Fri, 24 Jul 2026 08:12:40 -0700 (PDT)
Received: from localhost (ip-86-49-247-5.bb.vodafone.cz. [86.49.247.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32a76fcdsm364218566b.4.2026.07.24.08.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:12:39 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v2 09/14] iommu/riscv: Publish IOMMU_RESV_SW_MSI region for iommufd MSI remapping
Date: Fri, 24 Jul 2026 17:12:13 +0200
Message-ID: <20260724151218.965929-10-andrew.jones@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=GJE41ONK c=1 sm=1 tr=0 ts=6a6380e9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=aYZ+cQcEYoLAp2L633VOig==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=2xh-_RnL3qr1f2O9miIA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX+Nz+FnQwb8Av
 /RekGHakXtbtddCOmdqiWMaqbpLvLn3FvZoMig8Ug7XotMuiSO8xgKQrC1948rOR8oPZFf9pi9y
 mG+oMzZOFRZCdGUdvfBErpVBaBx6zZk0sTLbvgzi2o4B6aky7bn/4PJatd6T3auLk6ovpZoQPYW
 PZ1XVX9BYrKvXHSro3/cpiPMybIvy6JBSujYfbr9sdev+/hHlF5DF20x5KcafvhZcuj4lRI+N0k
 BXL/5WyT2HrWJlWbvqpHQTQNXC2Lsi0xexmgMv7cvAtoomGLZYC+nnM9+e3X2YY35tTxVucwDt5
 o8T455OhtjhXf9OhXDxHSJxqWrsz5qYgaj0L66UvNOesGmeBqR7ab41g2fWVNcpIo6N0OdKnf2X
 FRKQ/1jDOhDctHQyGyf4ekBSmMbWsgFpGM9RAvZffIsOJCqMFPb5tKxMA4qZeZP87FXPD8XA+q9
 MTgI8poVqDNfAklAiWA==
X-Proofpoint-ORIG-GUID: GliGIbs1sNEr1YWViQEniEMbllGfZx_X
X-Proofpoint-GUID: GliGIbs1sNEr1YWViQEniEMbllGfZx_X
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfXwbUbv0VYnD3f
 yY37g4rSilmoQLQRD6C+pwYwQWWs666N2o3WiuMWJYIrgVJf2GruwCFW0omritv8Gb7kIBHOh62
 YkWcbX+kFTKuXE0wzPvh14qNX7vMX4U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240137

iommufd's SW MSI path (iommufd_sw_map_msi) requires an IOMMU_RESV_SW_MSI
reservation region to know the IOVA base (sw_msi_start) for MSI page
mappings. Without it, sw_msi_start stays at PHYS_ADDR_MAX and
iommufd_sw_map_msi silently returns passthrough.

Add a get_resv_regions callback that, when IMSIC-based MSI is in use,
reserves an IOVA range of num_possible_cpus() pages starting at
RISCV_IOMMU_MSI_IOVA_BASE. This is large enough to hold one 4 KiB
IMSIC supervisor page per hart.

RISCV_IOMMU_MSI_IOVA_BASE is set to 128 MiB, matching the ARM SMMU
convention. That value is arbitrary for ARM too; its introducing commit
(f3ebee80b313) calls it an "arbitrary MSI IOVA window", so there is
nothing riscv-specific lost by reusing it here.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c | 16 ++++++++++++++++
 drivers/iommu/riscv/iommu.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 27dfd60834ac..98ce9ec50e65 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1493,6 +1493,21 @@ static void riscv_iommu_release_device(struct device *dev)
 	kfree_rcu_mightsleep(info);
 }
 
+static void riscv_iommu_get_resv_regions(struct device *dev, struct list_head *head)
+{
+	struct iommu_resv_region *region;
+
+	if (!imsic_enabled())
+		return;
+
+	region = iommu_alloc_resv_region(RISCV_IOMMU_MSI_IOVA_BASE,
+					 (size_t)num_possible_cpus() * PAGE_SIZE,
+					 IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO,
+					 IOMMU_RESV_SW_MSI, GFP_KERNEL);
+	if (region)
+		list_add_tail(&region->list, head);
+}
+
 static const struct iommu_ops riscv_iommu_ops = {
 	.of_xlate = riscv_iommu_of_xlate,
 	.identity_domain = &riscv_iommu_identity_domain,
@@ -1502,6 +1517,7 @@ static const struct iommu_ops riscv_iommu_ops = {
 	.device_group = riscv_iommu_device_group,
 	.probe_device = riscv_iommu_probe_device,
 	.release_device	= riscv_iommu_release_device,
+	.get_resv_regions = riscv_iommu_get_resv_regions,
 };
 
 static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index ded18aec8010..9a8fd5300675 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -20,6 +20,9 @@
 
 #include "iommu-bits.h"
 
+/* IOVA base for the SW MSI reservation; same convention as ARM SMMU. */
+#define RISCV_IOMMU_MSI_IOVA_BASE	SZ_128M
+
 /* This struct contains protection domain specific IOMMU driver data. */
 struct riscv_iommu_domain {
 	union {
-- 
2.43.0

