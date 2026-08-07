Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E83377ECC
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126672; cv=none; b=JQQgKPZqzM10eOchcBNg5bvCJU+iXlohgotnF+oaHtqIVpo/AQ8RHE1tDxjyUDnORX2WuGvCDCAiRGtef/MxPpFdtPbwQR0vvHLDmvmzu3xl68xOypBsTbqDuk7aYVUbhzR9kYJOJ/fLZyPOLjdIL44rWROdaZ/X4ApwUt+cCZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126672; c=relaxed/simple;
	bh=gsf8JEbkvB/TRYijGEGb/e3RPgHjvn3H871K16Sgj/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VS0esvQQOPN3rjZsu7VAvlRRVIEsKF8CNRuHBnh/JkkJ/Lor9Nn66ftn5pHZ49BNxQ3YIQd/vMNwSbvg71cmhTV0Dd67HPVbN55TfJENTy0eApKuFkqsQnr0DIfsTVpr0HMiiKGujD4pHtX4W1ck69ZQ+LfV29g+JbKaaMP+OSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kzP8lwA/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BrPPFjsd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kzP8lwA/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BrPPFjsd"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GOj6b1808770
	for <iommu@lists.linux.dev>; Fri, 7 Aug 2026 18:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=91EdTe7wdQy
	VgDuqjCKqHnMdN338lsJK+XEVtKp9Mu4=; b=kzP8lwA/Gw/oEBcVxluYfjcfcc6
	OGsjyKH2Dt30xgBOJkM5G1yNud+kkKpicenZab/syO71l21TjFvlePYS1WaQpAL7
	rP2hSewNAkADHfCeKUbFWMjeTqwOK+ANCZM06KKFPEioLGgwTB4LuVPxUnTF/QMb
	afZymtlAndAVS9fDm15lAFnfjYRXG8QspZ302YojV3pw4AU22X98gMJKDjQLeUts
	yeT+CTvETFslvPg+D+RcEIIcfEe/TC52cFTgXREunmEW4gmfzajtmckJYSExMiOp
	r+YXUVDSU3c9SSQqERMElE3W3dzdJ+OoVNzOD4yowklwnA4DD6SI++eDLWA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwgewh745-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 18:17:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bfe3fa93bso38327051cf.2
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786126668; x=1786731468; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=91EdTe7wdQyVgDuqjCKqHnMdN338lsJK+XEVtKp9Mu4=;
        b=BrPPFjsdMs/JCfeCOujdUI9KmnaHuD8hjlkY9DrhQ1LcqhH3iMQgTjXZC0HAlJYQ91
         keL9/132mZun0Ll6eNAV3c2S5dPAvAbUXlB1Zqe03dug/up9mWpqpmQsL5LXAIfA8ZjE
         YZiF8HOFMj3PSRSBpLvgN56nzr2Ltcnctfek30ps/si/LSuX2bJSnDY9mHM/ufZGB9Th
         5YuxBxA0lr9Xk/scNdx6J6bf19ljwWjUtH0N4T1BgEqhR21WRvYFlhRZhF3FSRxh/h1r
         qpdUWXgXKVNhMpKkWjCQMss0sq2unhnuIggeN+CLxfqBra+ti3zb4UrPuSk9e2zIJJfi
         fwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126668; x=1786731468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=91EdTe7wdQyVgDuqjCKqHnMdN338lsJK+XEVtKp9Mu4=;
        b=KWG+XEd6TE6uyNKSyvFFacAp3FL+mzfr1Me/T6ACmHtBFWFCJJ4YbTEo/2lZXN4hUO
         5UvZgZ4KQ/4ECCRsQc1B2eu8iMJR7sNm+Wv4S6nko/OGePKxt924acHRWR2UMUbcYUwR
         jdGuW91G7gexcbuMHR+XoIRzUOE7FAxroPJxLdEMc95qr1HIBAMQkQFwns62oojpJ//z
         dDzVbEEcHNwMfTUi84YdmRd+HS2daoG9xigEPS+rCoLFYhsURRviqLcAyi7EirvKQzYL
         2flObBfmE7Boa3AZLanfcTgnjts/6N6V8RALoOmP4kxJpEjJSY5lHOTb/sR2eT7qO5S2
         WsXw==
X-Forwarded-Encrypted: i=1; AHgh+RqnyQ/rn0BkLe74D7J3Fqq/zYRYoiDNdEJ4nzCVqK6TOZr7lUTshgsE8wfH/4XSEhy09Ny+Mg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuAOqWmuBHlaK9EYvWL/1rmBE6/WoRuhFZZPWkQJlW/R+C9kVK
	xyfk4OdVYxOFD/4pJX9Vcj402MwKYG602GPCihgOrLOj+5EsB27A0Gb7Z/vsDm9gTAHYS5LyvjD
	ETW08cJWV4bx6cVJ67V8YIV0Q62+KFhFXZntBBiQHpe7ceLcNZrfYS6tfgg==
X-Gm-Gg: AR+sD10TBpwxYmW8nlXlya46Y5Q5q5j1fug95mV6sqRUtI9RBdHIBl+1Et5kGHKFWPy
	JfClK/Fc4DD8xEtWKzxoELjb4SLXOx/+fgqOsO8wxomkD+nQsfi5ATGVIad4mnuETWnBqV2+L4v
	4B1OAZcmI4V0jol//JC9IJXYrzV8iAdkxXPrEQhYtANiR6ZRsBxBGuPrjzmWL8eLDbsA8TaCda6
	BbZ6POEGPLtz5IFWOr3b/CE5vHfBeuqEyp7/D6ZX4WHge8+qdlr0ymNpksfKalc8275rHUq8itT
	6CHPLoIuDihoTBeX5uyAMdDkwDVw3sk2NsQmFHp+td0FiyYUO9FzhCZLMUZwaVhdZ9EGfgel9El
	1s8Iw+Zys7S0VXdF9aois8J2n
X-Received: by 2002:a05:622a:4111:b0:51c:92a0:b2cb with SMTP id d75a77b69052e-52ce60d5ea6mr304279171cf.26.1786126668225;
        Fri, 07 Aug 2026 11:17:48 -0700 (PDT)
X-Received: by 2002:a05:622a:4111:b0:51c:92a0:b2cb with SMTP id d75a77b69052e-52ce60d5ea6mr304278271cf.26.1786126667803;
        Fri, 07 Aug 2026 11:17:47 -0700 (PDT)
Received: from localhost (ip-86-49-241-13.bb.vodafone.cz. [86.49.241.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080c90d21sm83079366b.39.2026.08.07.11.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:17:47 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com,
        Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v3 15/19] iommu/riscv: report iommu capabilities
Date: Fri,  7 Aug 2026 20:17:09 +0200
Message-ID: <20260807181713.228535-16-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfXycx43dZSaz3l
 MoVRGgqAJsNbksAOm6w5+W49eXPgRVSG6g2/Uej0+QEgv1yXxoYJrDxp0un4xnhLRDW4jFj5ynJ
 ktPWO1SuVkZlre9qCX2wYTCQzf8WXxo=
X-Authority-Analysis: v=2.4 cv=N5cZ0W9B c=1 sm=1 tr=0 ts=6a76214c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=VPysOpcHbS0DNrM1Xqmyow==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=h0uksLzaAAAA:8
 a=EUspDBNiAAAA:8 a=69EAbJreAAAA:8 a=eWAdAM1PFmNr0JmOMJYA:9
 a=kacYvNCVWA4VmyqE58fU:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-GUID: 5gF4IFrFQtGp3iVtIrX-PLGiQlpCbbL8
X-Proofpoint-ORIG-GUID: 5gF4IFrFQtGp3iVtIrX-PLGiQlpCbbL8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX30sz2Ygur5CF
 +5e7NY3BQh9uy+bm0HJ/1Xpid52w2GbevuT/1Z9M59RAZjXmJIxkwNn8Qncsg3JTF4dF9J3KaY3
 xbvacKuiiF0HBb3fFIcgluFLBgPQMiUTe9nVMxIYZWjAoxqLXaXxTLfhc+OJmYB+GVK+T0s2tfM
 M6CDViqKPIeTaXV8R9jxxfPtDJJWG+6RbGn7HYU/e0YFfCYCn2ZKhsfnzT3nMPMEog5l8aCzi74
 57lezA4t2ulNSEQsrFrTYNJ6TFgmedvDVOl+wjPGb/8zJofUqSAE0CY7LWarsVU3d1vRqZh/TB4
 3Rg+3T98wolzF3ppWtYsDWiYEGz8rlS4E7sZrWtsMSFBVA1d21zqbSFOgC1fd3RDLRKbMIlcmY2
 LV2TsY5dJ9b9rJc7qZ6bgbfdhOL+Cs6zBFeoT9ooJBpSCw5wtMTGS7+LZeq7NMvp21LKuVjJi+5
 efX/Yc6JmznjhR3LIgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070143

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Report RISC-V IOMMU capability required by the VFIO subsystem
to enable PCIe device assignment.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 drivers/iommu/riscv/iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index f40db2cda417..a286f5a24c16 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1424,6 +1424,17 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
 	return generic_device_group(dev);
 }
 
+static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
+{
+	switch (cap) {
+	case IOMMU_CAP_CACHE_COHERENCY:
+		/* The RISC-V IOMMU is always DMA cache coherent. */
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int riscv_iommu_of_xlate(struct device *dev, const struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -1516,6 +1527,7 @@ static void riscv_iommu_get_resv_regions(struct device *dev, struct list_head *h
 
 static const struct iommu_ops riscv_iommu_ops = {
 	.of_xlate = riscv_iommu_of_xlate,
+	.capable = riscv_iommu_capable,
 	.identity_domain = &riscv_iommu_identity_domain,
 	.blocked_domain = &riscv_iommu_blocking_domain,
 	.release_domain = &riscv_iommu_blocking_domain,
-- 
2.43.0

