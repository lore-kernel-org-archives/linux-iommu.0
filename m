Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309034;
	b=JE39vH+T6KgQjKq++l1/QSvlq+UvDIjwepLxguJv9TYrBmDqkYmREd/StL0vPh1Y/fBF
	 Dth3Orqje1xoAk7fYcPjWZOFNyoBDbiq7WMztTi1FQQw4h3AbNKZ/7ZZDNYH9Cc+dZKAo
	 9Zhjtg7mlgn/w41fvDjtp8rTUsyZlsr3ggwpZZR/chFKPXYx9r0oSVHEgHLRIwAPDKFBY
	 VeeXGqRkypw5M2x2jGrVwdC77/J5+fWZFQxAjgN1TSN4jsmkh7kz0Bsk0msPdJwjoEs2b
	 zzRXmmqmxYkFG38o75lgTfva9ymk+gdg13192xdx6BhiMqx0sl2fANCHZOEM/yR1iYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309034;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=k99yZnPO//ukQtkYAl64CwdQpomDxI0ACN/FhmeAnkU=;
	b=YP3jP8psJffuIECcx8XJcX0dGYMjI+zbAtKn/B9cjN9S785yMO7WjkXC9Y3VkZXZ0lqq
	 8WILiKVxk9Lg/ZURf6LiEPVM8mcsE0QNFLInYz84AmHSLQR/8mJzeQkBrsjxzlGCIaQsX
	 WgDGpmYujbcWG5Gd4dviIR4jiwlIv7LAsVFnsqY8l63AkAZStJLMnfbQW4Gclehp7t42r
	 Qfe67KXXfm34CWIvS+QoCIxhdf8vrPM9ToEgj4aTmzMSGE4Woa/x1Ypg7cAcv/6m5HD3p
	 amKRNuwpRsZhMhdVYPl1LFlQLQRln2cCmtdSjYH03duEbmn0BkiIPXT+fW2oQi/ZKtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ph7Tec2U;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hkmi0ALm;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49DF606A334
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 21:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D49DF606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ph7Tec2U;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hkmi0ALm
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TJk1bF3718143
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 21:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=k99yZnPO//u
	kQtkYAl64CwdQpomDxI0ACN/FhmeAnkU=; b=Ph7Tec2UImH0TA0hHZJxI9PY+gV
	4RgrfuGlj6cfSV3KRpT3h1tiZIc8syLaeQpZM+h2XLHL66cXuBkY3QO7u643dA0Z
	TGo2gCl4ynKB9v0b2M+uEta1c1qA3g3s3fF5RHYGtxoY4lR+zcLLABWpcVTT9zXt
	mCddJ47Zexo3Lke5hBHl/14zWyAuEvEfsAGBKFcxYNvn2e7XDwc+QHryNq27V0gr
	13AXaRadWKoHjQ/1cE3yMs+hv/Xan8eyHTQKqSVx9pAFstH/nlWyyT0+ZtOlY5fj
	rfqxGd4WzdlYtFw69ak3VCW98XohMaRpPVxQwAzAtWQFAD5Fdw5qwMuv8Bw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b372c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 21:23:51 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a05c820ecbso3496849b3a.0
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793309031; x=1793913831; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k99yZnPO//ukQtkYAl64CwdQpomDxI0ACN/FhmeAnkU=;
        b=hkmi0ALmpI2vCwEFno5AFTQyj+jmMYxk1NEgvTq3dXHutrOZMHcP59PNptWwFukzqX
         6e+ijt+JPlqQc9skW4HMq1tlbM8gh1YGSi5Z31XSWJMdnKF7NYc8FNMuV91JqFvBYsJf
         4woN4I33YbZ2NM60W3aoyOjFGnHunnGKmIB2OgsWG1rGen/BmkNlArMbC4zVnUepo4mz
         Q/2X96UegoWddILIcY7UsdfD4+tXkmsQnnV1M59FPlMsE7ubiXpesMYOSbg3bYyhfvUd
         PweuGV7sNOxumv+yRJwwXuvbY8TjP/KD0EAB7QpCpaYQafDUS0Asl2bnPZ/HO/IcQN4T
         tQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793309031; x=1793913831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k99yZnPO//ukQtkYAl64CwdQpomDxI0ACN/FhmeAnkU=;
        b=QbkqmekjedZlwKb3Mu7f6Wl2NPbX3xqWheKeTa7zBo0o23gOrdNHmmbUHg3eLIKIXv
         1f/O6vkYiQvfBxR9r1gtTfewAefm5eD1nn9WBJzheIoWi/KQ8+Xe2PIcP/TkOTT9TjjS
         rsU93xEMXnOk4ubM07woQYQYIjacgD8ayxwsWSOT8MTlIbV0Kl8O20UoEe6shtB6Gkl0
         zbhC+cAIqyn5WJCX00aPpOUeuSTutlhRUEMAMIieoVsqibRyBIIoeGkalG4S6tVxb/r2
         qT2yxoRrlnKO8i4vmAxVE4iavEtsd+54rMGu/gAcnm83+4i76eRsNmPw1tJf9gJfaHTC
         4Q1Q==
X-Gm-Message-State: AFq9FYKbsXxgvCAHUtctYBqV7ROQ73UJnCys0Hc/8WKw5g4Dh7EkKnv7
	d23EPNsTCpbmCfqa8G/BYLek9I61BA/fE+JC6QeZ9+cCmULvqPDaGjUwBIiMf2RYhznHu/x0Vtf
	lAgdRgzSkROI0MYW8NvQRUgSUeYU1RS5q2R+aprhTlQqldHk/sP8i/8L47LWhPw0OZQ==
X-Gm-Gg: AYBFou1YKeDRGDL7LXcxrUje+qTrQbcVS2wgWzvdufSfhIp64u4cgsfws9lPesaUYw5
	Nkzag0hNUWaK0ahkciDeSokkidGee2fd3a6CnQ05bsQ/Jee7s+ONHnyPgj6kAceBdj2N0fmNx56
	oU8EdHSkTUQ17wAn+CTMaTmsgGAh/7pK5MvhCewPDVMdfuUH1ic24Hpk7GIlp5LCGogZ0nX0WWY
	Ov4EhDGM35ynZjhA9jF93KuU5NLDScA6vdumXdXMOedT7eKF9dasJtDqmRlQJFFc1ixJQpESzSY
	ayY9N2PFRNHRT+ES+jqkN8y7Ns3uyrRceW7puVDOm9593JWy9YNHnRkXRosrQ8QzhIY7wz67yEA
	egtYZ2+U4GedQxDwDCMZ1wtOOCLl27bGjyi2J5TIWXebmmeyXRS6PgcGaoElk+nRtjJYqMbsXDa
	xwfChMx+9MFUBbIsLCy3R6FA==
X-Received: by 2002:a05:6a00:3a1c:b0:8a0:3ed7:93a3 with SMTP id d2e1a72fcca58-8a9be7790c6mr302326b3a.29.1793309031392;
        Thu, 29 Oct 2026 14:23:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:3a1c:b0:8a0:3ed7:93a3 with SMTP id d2e1a72fcca58-8a9be7790c6mr302306b3a.29.1793309030908;
        Thu, 29 Oct 2026 14:23:50 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net. [67.168.198.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a98893d1f4sm294090b3a.12.2026.10.29.14.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:23:50 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: iommu@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] iommu/msm: Use identity domain for GPU and display
Date: Thu, 29 Oct 2026 14:23:43 -0700
Message-ID: <20261029212344.346069-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029212344.346069-1-robin.clark@oss.qualcomm.com>
References: <20261029212344.346069-1-robin.clark@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4NCBTYWx0ZWRfX4E/58tZV7KME
 /b+861QbJU04XClTbFG4Yeocv50+kTWqTKFJ1i0kOX+V8e9vVTm+Yh/o/zkmNNX4iFGfP+wNP3K
 XaTeunmBWeusIs/JkiGblMpc5EkLV8o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4NCBTYWx0ZWRfXxivaijwBS4J7
 9910jZ7lf4ieBERCb+tSY7uWYzEvKWO+L07oMfAKSMAcdzrMZXCXQ/gROfCPDv5/SHE3vBdyzOy
 myYrMLMd0M5EYxe0vTJnHRM6/ejAtof9gZk/MJDudnYAJHuL7m6Qivfcag3Sou7eb/4Y4xiTIoz
 e/VumzUgKcIoaqrocqTf6LAu4epyEMgm4r2wZmRbE2B+RlMUxRpzi1OkoGliLTgZ4YRgpj/cenW
 v/aNZyweEJB/xxbqQsw7l9AKJ5Ytv9V2IV+3wSHnFAU+Z7tCrwgqyefjaGOeLhZ06eITwI9YbrF
 mmkY/Db/2vr2kq1wAgPAJ5M2bz/EcXnvhoCdag9ESmX76YCKZ1J9RJQ0pPmD05n0h+iJBcqzAmI
 bGX7RqgY6ncESUGT5rVj3XGS+zfUvoDuaGwBLNDZQHiR15vLSZLk6Qpqp5yf4i2nS8E1O2srib5
 6XMo0oBvgdi8YAHk4rA==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae3b968 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=554yuftmPdPD4gaTNL8A:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: X0JIBwFGGcqYDv-fsK0CLVjdmEfrfoNm
X-Proofpoint-ORIG-GUID: X0JIBwFGGcqYDv-fsK0CLVjdmEfrfoNm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290084

Similar to commit 0e764a01015d ("iommu/arm-smmu: Allow client devices to
select direct mapping") for arm-smmu-qcom, match GPU and display compat
strings to pick identity domain time.

The drm/msm driver attaches it's own domain, which it manages directly,
so we don't want an iommu managed domain interfering.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/iommu/msm_iommu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 4ef1e8c8244b..1c5011432628 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/io-pgtable.h>
 #include <linux/interrupt.h>
+#include <linux/of_device.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -691,12 +692,27 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
 	return 0;
 }
 
+static const struct of_device_id msm_iommu_client_of_match[] = {
+	{ .compatible = "qcom,adreno" },
+	{ .compatible = "qcom,mdp4" },
+	{ }
+};
+
+static int msm_iommu_def_domain_type(struct device *dev)
+{
+	const struct of_device_id *match =
+		of_match_device(msm_iommu_client_of_match, dev);
+
+	return match ? IOMMU_DOMAIN_IDENTITY : 0;
+}
+
 static struct iommu_ops msm_iommu_ops = {
 	.identity_domain = &msm_iommu_identity_domain,
 	.domain_alloc_paging = msm_iommu_domain_alloc_paging,
 	.probe_device = msm_iommu_probe_device,
 	.device_group = generic_device_group,
 	.of_xlate = qcom_iommu_of_xlate,
+	.def_domain_type = msm_iommu_def_domain_type,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= msm_iommu_attach_dev,
 		.map_pages	= msm_iommu_map,
-- 
2.56.0

