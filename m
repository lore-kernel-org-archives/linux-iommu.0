Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793397925;
	b=dFmwl+pvIwpFoils9dR/wqaryx43Xifrsf53ImBoot8/OXS0DBF+QMPQpfzf7LJNWn7b
	 E06vzYU1Ph2Ec01Iwsqr9rSWUJ+cVl9TVYDrGjt/ZPKKKhViPAvRWD7K+qiLpVyFRxMm3
	 40CaMtTIiuxEmHLnPziqW7zuFtEwVQmp8Z2TA188jXliTtW2M2FJeSnclPF2rzWVGAC6T
	 1zD/BJI54oYRfVWCyPnyH3D+sTk4m+1gFIJkXVZbvWlk+fzHHe7VgANcxTMNsRRMCPtD7
	 SX0nZCNw3GFzncXfkKS+0mG/LTUNmgSKuJNPbyy0zObLzAh/H/Xg/6pQqx1qnHNuJkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793397925;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=An7OiTnlc5rBNDs1sp5uq2115ZCBsqObQUTQud4yMUo=;
	b=X8mEv3uYvzgYxFfKDpT4mZ98GlvewvhdSEgcv51+fSXXKS3h+EdLVTnqbowHZXLlWmIG
	 8R0NLLbGJKoj9lPOHyxlWNv0EcFuRRp/Z6fEQ+FZjFoETn4tr5T0ujPHf7NkV1+MqGRkS
	 ETSqVvl0fhm+C6ilO6KoeXPn6FUgectf/7TOhYyJcFQhuvhbMBPyula9c9fU4QbG5u9VK
	 JfIzEzKa3KGtBsH69olnHOTtws8Qlxgtls1kzV27D0uTUxCMjsDGIMlII8sm0Pr4tI8mr
	 2/36OmG3Mbq4Ok8rXbbLxo7rJyPh2pyFJAS/BPLBeiHPzCeF0Hnw+0TQjQN4GfAAqzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R57Jl92B;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="T/p2ijV9";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C283E60A260D
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 22:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C283E60A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R57Jl92B;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T/p2ijV9
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ULtd47336829
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 22:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	An7OiTnlc5rBNDs1sp5uq2115ZCBsqObQUTQud4yMUo=; b=R57Jl92B9rMbKq05
	z/298LSgaT9g4VoRCVs+DSDF6R7HUvAC62cd6WVRoVHbesIhBQQjBjA4F6DPY2xv
	MhYThqYSbgCS17mnuQXT+XokUrE4QL1/09vMDuL4ktLDfdawMlflCgkyHA/ywi8u
	nAql5LEF7E7AWoZPNlNadov1mQ+LtYBnrNIahKYg9f4/pwVe/SX0UCv/70uCQ4Xk
	YE3a3Ic/gOxd4eZU5qb3e7lMOBoBj3bdnakl/iC1cuqZN8ZsS2NN69MUPYqTL8ZU
	gbdZ5CLpXR0VZeGLMLyeNqaONFXKiTFeD7qKTnvTSTfJfPb31PJTRqF5Zd1CW5eD
	GMv1Qg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x007a9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 22:05:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93ecdc701a2so146609585a.3
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 15:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793397923; x=1794002723; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=An7OiTnlc5rBNDs1sp5uq2115ZCBsqObQUTQud4yMUo=;
        b=T/p2ijV97D2xB0988B+2GGKQh7N6ic7s3Q+pxGaLQqUr5NmeEqGZ9Y22Q7JJfaoX/P
         XRFA4YpdGXWJL+ouWJu/J3upJMUityp6e0YlJ1zteyAmJtFlV1P1182svZdLq8Jn0BJv
         iG1ZVX2ZCjpbSCvTWjeQB4ffjiBqgrKTk51EuiA0crYMAvuoH65EiRKn/dD+jfk43eo1
         jA92Zb8PSAwDtgHY+asAoKCgXFMkyHrIuj1V48VOQiNlBzTJxRKGHxsNbgcB1pBiG/JO
         9X+ipBsQoBuQmzz8AWuoONf5Oncjj3JvVZiuqmpBjX72H9vJrUwwv8Mt1DjT+GbYmayJ
         DHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793397923; x=1794002723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=An7OiTnlc5rBNDs1sp5uq2115ZCBsqObQUTQud4yMUo=;
        b=itdQrazk8tecmkImzS/peMa/beeli+x7z82c6ok7oG8r+IvhkH65yrtLmiuJKYvRq/
         7Je73/+M+IK0cqYDeBIabo8KVoEdydePNdAbHFudrcqzMF4lBU3KXsFlTBaOaf7BJugP
         Yb31K8dIBPhj9KzeFuxQs8nTKoNrz6HlAWdnk9Vaubu5SPvmf6wzgqkuM1zMvZAbfjtM
         Q9v+rtfTyMFqnFTVn1vcgLK3qFdG1EldBDYg6ZbN8cKMN03LTd1xGjicz2sK1uAekqpB
         ygGnFasIio09w7t2p7lhwmA9QWOnF1Azr7HWahCzTETXk5UuKFatmkmKwo/H8zKeHZbk
         5sPw==
X-Gm-Message-State: AFq9FYLKA7E4BwC5SWq21lM7m6jbbzOGkVjFv50kNzRJbNehnkB8Z6BM
	53i2kOgYagbe6YvTReQ1QMFsktIa4cSF7zNifx9fW0PT1RdLpOcVLe3gsEn08ZuXH0we9tXrk7Y
	3YrKuykjyuAo39YTniHMEGy2dX8/c4iYxsbQA7urr/E1+mrSh+oAk9xKgmg==
X-Gm-Gg: AYBFou1opEkgDfHRqXjbsKle/2Q1LANM32xE2UqxNp5RFhG9bSeN0oF0AFdDXXp71Nh
	ziDkRDNb4Ft3q0Wmy8fF2Sv2hZH1wh8vqG4MhgVMOueOsd/M2VKtkhQHKwiORy3J51DzCSvRygj
	uN9GmvJ4H+5OYmLi5+++XZBE8wcOjQojUsbx/xLCIYRlPfIvASiruk0WfFe8qKjBGW32j+R7eOi
	/fFmDDVvBRPSHIdRHMWYqQx101ZiIgZDZ7Z1IS1n3Ep5go0Sfnc97WqLidjX8PEbm3Zblf8gBkP
	B3h5ou2AmGpYYhhh6qNtlo1tjStiWOvPNpC1nZq3Wc0Kix9S04poem1xslINPZcJevb4PzgKMmj
	jRLVNw+w7Vs861GwLeUVe37tDDsVyfa9hbY5AG6t6yQbBIc9wWw2I4O6q5pBx+9HCoTPzgDx8fy
	jNjHKR+c36f5bar43ww3w4JJZ9CzbBnifJxqbY5kSpjqZ4x4XP4OOtXdyz37tOtg==
X-Received: by 2002:a05:620a:170a:b0:93c:62c4:e2e2 with SMTP id af79cd13be357-94421541cddmr602237285a.12.1793397923059;
        Fri, 30 Oct 2026 15:05:23 -0700 (PDT)
X-Received: by 2002:a05:620a:170a:b0:93c:62c4:e2e2 with SMTP id af79cd13be357-94421541cddmr602233685a.12.1793397922535;
        Fri, 30 Oct 2026 15:05:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe04edd7dsm243930e87.6.2026.10.30.15.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:05:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 00:04:58 +0200
Subject: [PATCH 2/3] iommu/qcom: Use identity default domains for the MSM
 GPU and display
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-msm-smmu-identity-v1-2-a2a70580eebd@oss.qualcomm.com>
References: <20261031-msm-smmu-identity-v1-0-a2a70580eebd@oss.qualcomm.com>
In-Reply-To: <20261031-msm-smmu-identity-v1-0-a2a70580eebd@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2040;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=hIUS4OCCIduN5c9WA/I6hlxnzxJqYrD6RjEBkMJ6o8s=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq5RSYzsCzXM1EEMZVjFupenR1Egu10IvqTfPn3
 5AyWZ2VVEqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCauUUmAAKCRCLPIo+Aiko
 1RapCACKPnyD1GJeL8YSN6rJSnnQyuOTq1+5XOsKmmvnSGcAS/w/BfGCNi6I7J0TFUvkzTOFkJw
 Ss8qVwVjoHb+cBnAlRT+18w3DWvrfUEA9kZkdZjYbXfwFREvR0iN1kLqj5OOlQUCNQmtp95Wcf8
 nLwfJz/gg4KEDKueKS9zV/aL5weYMgDq3mYZf9iu+n9hOWVBpBpR9AhPV4uUXhWYWOERaAuT1qV
 SkBFbC4AJJ2pWCZdMVVXgHlFRkItKZ66MTePBiU7foVnOnoCdfwKlVOfkZMNBLS4cYRlVK2q76v
 Qd2ff3PfoZTdZEIK4BXm5Xkb3zQld3i/b2hspp4U2STey+xc
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfX/xS4GOsa8iO3
 TU7a1Z7XE93EDrQ8aYSFQdVq3C0xoMmtCPpHIUMi7JK0agw61ueh6S+WUa5DSnBuNXkV/q6g0cd
 4zUuSU+G/UMTZmZPr/MTonp7sKptIKsUzASUkTZqh7pFUApAfAXxh7UJTR3/JHSlEMfvvbCg8Qx
 ZRu6SAlv2k97o3nzM6TT2xxE7UCukqWN5jjAHmC1rjXL8RSlx3OsZXrV79lrRsT2H59kBLGR1Cr
 +fGwe05g44wyTXPktSf2JJGxjknMXVmmU1bZa3i8mnoVzbiz3zZJzUPvxKYO602E7cwgbK3R7w0
 H/HsTGur9owDE7I9HxzlxpiyENSYPB7W2XCtMBsLl7kVeqvA8Xc1posfhVE/sqqUBpDk6hMGQGc
 A97GkweEbwDeDfAAKPXWVV6socbqy45F0hAIiykFFbPg/hKsuEpoDBH3YFtutbLpCsxWYxs0xqY
 4ujSkKEUvhAMg9mCabA==
X-Proofpoint-GUID: UXmFdUcFgTjWWJqxBwYvanl3qN0qBHeR
X-Authority-Analysis: v=2.4 cv=FcSiV5+6 c=1 sm=1 tr=0 ts=6ae514a3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=9k9QU7PkdAG4pGQKEAsA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: UXmFdUcFgTjWWJqxBwYvanl3qN0qBHeR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfX1GuE6Usc0h0R
 mtIdDw+m5ybxBfU6dV/Fxt/AcsdIjRZnf7CkxDmTlvFCNurdTdkPRV76nxyet3QXAwOFZJrzjx2
 4iM8Pawnvrg+5jjj6iYXknGFwu6llf8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300088

drm/msm writes the addresses dma_map_sgtable() returns for the DRM
device into its own page tables, so they have to be physical addresses,
i.e. the device must not use iommu-dma. qcom_iommu has no
def_domain_type, so the MDP5 and Adreno devices do get iommu-dma, the
buffers end up mapped at IOVAs of the unused default domain and the
db410c GPU fails to start.

Use identity default domains for these devices, as arm-smmu-qcom does.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 54130c32056a..4a9c4cf63724 100644
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
@@ -531,6 +532,18 @@ static bool qcom_iommu_capable(struct device *dev, enum iommu_cap cap)
 	}
 }
 
+static const struct of_device_id qcom_iommu_client_of_match[] = {
+	{ .compatible = "qcom,adreno" },
+	{ .compatible = "qcom,mdp5" },
+	{ }
+};
+
+static int qcom_iommu_def_domain_type(struct device *dev)
+{
+	return of_match_device(qcom_iommu_client_of_match, dev) ?
+		IOMMU_DOMAIN_IDENTITY : 0;
+}
+
 static struct iommu_device *qcom_iommu_probe_device(struct device *dev)
 {
 	struct qcom_iommu_dev *qcom_iommu = dev_iommu_priv_get(dev);
@@ -602,6 +615,7 @@ static const struct iommu_ops qcom_iommu_ops = {
 	.capable	= qcom_iommu_capable,
 	.domain_alloc_paging = qcom_iommu_domain_alloc_paging,
 	.probe_device	= qcom_iommu_probe_device,
+	.def_domain_type = qcom_iommu_def_domain_type,
 	.device_group	= generic_device_group,
 	.of_xlate	= qcom_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {

-- 
2.47.3

