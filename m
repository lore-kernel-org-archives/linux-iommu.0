Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309032;
	b=yPEoYGC4g2pYfaWezk3vYmGUU/66s+HpnpM5FOwGHQYH4bkF/5iltSb3j9god7tP9EFe
	 wiiDs+nLHd/9maKtzC/jpKEEiAPyWFHOoCANa007Yw4ex/HzFmznqrLqNsLw5RwUl0IBQ
	 WTsckLKS+7P/xDbWyW4wl/sGSSUF8LLwhgKJ/ubaFAEBFwj2dSISHPVvNZS6j5A2CNLn1
	 GPCj/XmYr2LD6oYdq3badUjQ06lF4O73SBtDiiuUT9CRNQXM8EWX3DXazWCjJxWPAxY97
	 dtwCgqU02htO69+uKwVBPrC2Nm8MssbWWuOwKGNEH2IWY2OoxyaSuuaOIO6fvzg88OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309032;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TzzXFuNiq+DOToFpekJQ4MBDEjsWCEdNN/aJK57pRJ4=;
	b=clGnyjZ7fFKC8JlKU/oXfIEmK5K7ERz/pl9RHBZM6xZLQ4t4CA/cSzvRlTqhPUvobPIK
	 uLj9OltI0u9r2ZDd4KJHX5Z0FJuZyrcR4gUzfND6WLldWHduaDpZ0OIiImez7OpCuaFGi
	 UrpbiEHoDzOGcU71H7e6lCVit+TvAliM36hfS4/t3dI6EWVmt9/jKlShhSt42u6ltyNAu
	 o3jHDinR+VAid3xH3Jl8mBEt+HMeOc8+VdaCvtUo+YseFjypVrB+0nCrSh5gzuz09MlFM
	 t807W24VY4sixX2rTujjH1lgOJtuTLRuARyfcq3soO6F94Oek5eyEHOOAear3RdbRhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TJCZg4Pz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jGoz+Chp;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3058606A322
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 21:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3058606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TJCZg4Pz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jGoz+Chp
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TJjfoA061373
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 21:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TzzXFuNiq+D
	OToFpekJQ4MBDEjsWCEdNN/aJK57pRJ4=; b=TJCZg4Pzwyuj+Fp2/ydS72faFti
	vP3k7bkoejYpzXKZpeGpYDqEV4YMyXzaaKVT86aBPvF35VGulkxcpcMEB5UwKxEg
	v87XtV9m78Vj2ruauEckOTuF4xWrSax0/sG43AyBEhSH6hdlW5xatfGpSnL15t4k
	51m7V5nt9RqDjGSRsoqXZLsFcXDSDgMOPN2JJHtUYK2mY2oy7WqWvjTbckkBcMaK
	sBdhNG7YJkszATsByXuaYbQdH67t1yrhnsyllTN/Rz+6X5TRUql/hUWHnNiNNDeT
	wyks8KMLfBOl8FsI+xy6A/+KVKmPpT2EwZ2XjraoQda5vDmT5469CjodvAA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmby38hvp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 21:23:50 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc7d2ff0087so17675a12.0
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 14:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793309030; x=1793913830; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TzzXFuNiq+DOToFpekJQ4MBDEjsWCEdNN/aJK57pRJ4=;
        b=jGoz+Chpdt5f/kEt4ZGp4eTrM/+Q9PP7uApcR9Nr9Wu4tGCGTfU3Mgwgy9iafGbGbS
         oGR3erncAUeJC7xWbSCK93thhCfolUqtJmu1lhzS45a2Oy0wCkeKeRdn+3xqg3uwK4FN
         zS3EHE2eViH3w4AyF8PPE7lgQ3hwHzSXfPL2hjh0UkHSnI7r43RMuGLQx+hHaI2PFmLU
         IjPS3qEQkJ/+aQHpxFaljNQFEhXFZeWSxjszwEi0bkCsDa8UK0Ynyn3t/zhCSzx4bZ7w
         stjk1MuJQrltIox/mAW0iqBVMB9NPVVryDsmNe5M3f1Ja3XXWBWJiwPgSONTPZcPiY72
         hIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793309030; x=1793913830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TzzXFuNiq+DOToFpekJQ4MBDEjsWCEdNN/aJK57pRJ4=;
        b=to3+qldcQjNz2SmncsqZncCjlfF1eBHToFhnjPSTMuf7Aqt3m1jLBO9swEfvVZYDg/
         RsMbL05rlWtXto9gaslwnO2xbRFwEXmW5kofr37kpXnSUDeYCeSgjeIPLvkTT+rPL5Wi
         ONkZ2rrudb/sS/f4g/y+iwGsn6fP2We+j6EckoJZnNPqg7Nb2PClhyibmPFkx5tLR4QW
         KMl+A7HhJeacCf0OMSvdW1wJCiCypt+kECQPuuf3X1/MkTxhLYFg+TvuL66OjU3YBCX2
         c9Y9UoeGlFVXsM6lmIjFXUGKZ01mg32K1oENj3yYz4TocbN5U0T2mCgMHG4C4UH8a2aM
         8wZg==
X-Gm-Message-State: AFq9FYJBlPPdv6uHZu77l7Z7YpnxsB43UMxqhcnTy4yxIoj136/Hy0dH
	1RNwmd4okpHmyDtzLLDFIQTVzlm94gkcarvJ6AsU85Wxt4HEQDFUmYDW7CDC09uIIerzNubw68x
	UjusCQ8km3US43ksKcMJ3oqmSQyOjT78SqrnB3CRmzR4D/qthYKYyMvA+1CU07XalFw==
X-Gm-Gg: AYBFou21X0sP7JUqzggoIj92iNCVf0sWBsxCuDJ+rfXmm6PWWSbCg4B/e1aWEZNAgDz
	O0LalgG9NQ8xA/4DUVofOY8cZR7iUdaJbn4UPvJnsqgN87vXh1g0Oktb3V1ki2QnW7UjpxlRiHo
	yvwcaVgmoqnEsavXmSqThxYmu6+xW4/FXn8s2UlMsjVwkeTGSQKA1N14/knjxQ7yfQwCqFEGQVb
	kmf3zGiir+Hw64e583rqm7j+1mGTF/cV4zinwqwIRUTAYnsWpDPOhfdLQBaugyyfhJE5HMDfQi5
	lL7zNfQsZVx4oi/z/aX7z3W4pK+8HHcc5tAyZsJcVuv52nNoZw4A7oPjmCZo8SJkBGxvYzdJ0Ul
	HgOVhx6D4jr/wHmzL4yQzXtrXp4nmAJv+EhtopPxWFLNUuRhguQelE6rqrqiOwBPmtEdndsjOF5
	HEHH/OWqIH0BFMsZukxC3oWQ==
X-Received: by 2002:a17:90b:57cb:b0:3a8:c0cd:57f9 with SMTP id 98e67ed59e1d1-3ae89744ca2mr193137a91.25.1793309029981;
        Thu, 29 Oct 2026 14:23:49 -0700 (PDT)
X-Received: by 2002:a17:90b:57cb:b0:3a8:c0cd:57f9 with SMTP id 98e67ed59e1d1-3ae89744ca2mr193115a91.25.1793309029488;
        Thu, 29 Oct 2026 14:23:49 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net. [67.168.198.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845aa27esm1054544a91.11.2026.10.29.14.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:23:49 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: iommu@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] iommu/qcom: Use identity domain for GPU and display
Date: Thu, 29 Oct 2026 14:23:42 -0700
Message-ID: <20261029212344.346069-2-robin.clark@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4NCBTYWx0ZWRfX0dUWDBGWOQF1
 /hAYQZAuUdepRvQeUwliuyDfDnZGtTSGUYeOBHbz0rUggl8J96Kq8EDLH1GHZpVNaLEOUzjMn+N
 bFnDT6E+cpyumGheaWmBUtNHpUcBLU8=
X-Authority-Analysis: v=2.4 cv=ZvN4uN7G c=1 sm=1 tr=0 ts=6ae3b966 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=554yuftmPdPD4gaTNL8A:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4NCBTYWx0ZWRfX1jpeC4O0VvTt
 /ciWTUlzNecIOtGvVtFkwKxvYz4Mfs6HTDgn/Pb5ZERWC1MKledYxpX91N3Kv6ytbI9F06aGcWy
 lwvEpRfkyl/v1061LTD7Ie04KEO/0f9g/TPgeEn7e8cYkxsPDuLw7BApZdrxKPxkn2+FYu97cM8
 rYtVZGuqv7UTedLkshKqpm629JjPciTl2CQp5zkvh8t5hf1FRhdjNEIYrPVVmJw8p5vrAFo+5hG
 whoMrPw6PCH2WdMft6Tc7SQ1brvDN9YoZmRapM9SBUNIxp5EVH7PHEo90aNmd0Lwu5ZNR1Oe30x
 x3aFtGR1NQSAnF/tNRtvgm8E9/qqd/3ZVDqPAKu7e1c6ywoSK/B07xWKEhuBj2iJwYKUUvxtNz6
 4RvyLdWDyXRqQeQ2Vx1VMGlADS5i6GciKYDyA2aMUpkwHeynOfSF/kzL1lL/IRBDPii73Vp7fOx
 sVJr1kCCQjbsdHaQAiA==
X-Proofpoint-ORIG-GUID: vetHa8pgCo-2vieNnWK_p9Dbm5z9OGXo
X-Proofpoint-GUID: vetHa8pgCo-2vieNnWK_p9Dbm5z9OGXo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290084

Similar to commit 0e764a01015d ("iommu/arm-smmu: Allow client devices to
select direct mapping") for arm-smmu-qcom, match GPU and display compat
strings to pick identity domain time.

The drm/msm driver attaches it's own domain, which it manages directly,
so we don't want an iommu managed domain interfering.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 21d18ce67b98..5b10feb419d8 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
@@ -589,6 +590,22 @@ static int qcom_iommu_of_xlate(struct device *dev,
 	return iommu_fwspec_add_ids(dev, &asid, 1);
 }
 
+static const struct of_device_id qcom_iommu_client_of_match[] = {
+	{ .compatible = "qcom,adreno" },
+	{ .compatible = "qcom,mdp4" },
+	{ .compatible = "qcom,mdp5" },
+	{ .compatible = "qcom,mdss" },
+	{ }
+};
+
+static int qcom_iommu_def_domain_type(struct device *dev)
+{
+	const struct of_device_id *match =
+		of_match_device(qcom_iommu_client_of_match, dev);
+
+	return match ? IOMMU_DOMAIN_IDENTITY : 0;
+}
+
 static const struct iommu_ops qcom_iommu_ops = {
 	.identity_domain = &qcom_iommu_identity_domain,
 	.capable	= qcom_iommu_capable,
@@ -596,6 +613,7 @@ static const struct iommu_ops qcom_iommu_ops = {
 	.probe_device	= qcom_iommu_probe_device,
 	.device_group	= generic_device_group,
 	.of_xlate	= qcom_iommu_of_xlate,
+	.def_domain_type = qcom_iommu_def_domain_type,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= qcom_iommu_attach_dev,
 		.map_pages	= qcom_iommu_map,
-- 
2.56.0

