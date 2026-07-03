Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC4B355803
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783110987; cv=none; b=l0tWNgGZp1bvDeFsJ06yFm5ruVSsX3MD45ynZHj1I9/zIi3EsYOBGJ4tGhEK8gr/6D73cRaGikB+mmHWYQdFioDOeBcXhuqoqZq5xQHIm3Tx6aGzMCwfVTACpEEaVw+aDDrcHgXmbChNuguz5ntuK2h8WaSwhOj3HLl6CPdauv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783110987; c=relaxed/simple;
	bh=t3B1LGfw1dSrLsUJhY30F7R7B49EhUVLYMXvZJRb//w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aEpyQsatzGzAhWrMeI1Q18KXgwk6Ypqz1DCMjDCN4tIze0WV2jyOJ7MtLF1vJaKinHvbVyL0XmJYMG5SMmv6aZm8B9018QKpFzYDixNPFEEJZoExmBVxP7ynCgQKr3BxJcH9E4hAxXKNS+J1GFL54RwcIWgFixC+l9yYKgEvouo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NJ8mtjsQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ko7u9wlS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NJ8mtjsQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ko7u9wlS"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663KPTC21019200
	for <iommu@lists.linux.dev>; Fri, 3 Jul 2026 20:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2dOV6SNjFzG9X2tjzVk0oMjUqNu3RuI4o/7x3sDqaJQ=; b=NJ8mtjsQ5uk3031c
	1sHML28nZjDSTULG5cmU9dYBC52+Up47/RZ8EGa74eXGgGXlHkX1mRPa8fKIcB9J
	kR8IoDLwnkQisdxw+Ong7g0TWTtOxA8GLTXhi2VEMpEr12KUPnC3fG43yrkiCaoo
	on7VFUEktt8FnhCPil5kln5tE8FFOKp9GOSLkjWwhz+ZDjrKGlk4VVw8W8o8b7yP
	bkxo/wD8LklfrJ04RgY1ktF8i5vEj7f4+BELFuXzWhc4cgJPdAdNiqeGhx1NgcYs
	1eusB7Up1EI1OmFDAnGb1h4rdFaiwZGIaVD4lrqak95amlcOwWoprQX+T4IKzTpb
	C8Gefw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj1nfs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 20:36:20 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c88cfe287e1so669287a12.1
        for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 13:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783110980; x=1783715780; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2dOV6SNjFzG9X2tjzVk0oMjUqNu3RuI4o/7x3sDqaJQ=;
        b=ko7u9wlSdQW0Xm560/BMgIyAU6X29eD+AVDsXO4l2UOfdVZDCxOL3ImcRBGwQUfIcc
         qkaCkStXgi0UPyUyKl9Xz+mm70ev0dtyEe9FqCHJng/1fjIXm568cWYEP5i+KZAjtU+1
         ycT536yi54vbCgzb5hEOCkfjhSKWlTEDTijsdSrYWbpJ2Fd6bGE10AUVI77JFwj9hBZN
         wSNZNU5PEFVkmrvE8VdNuxkQhtkYKTexYpEKGNlVMTvZBxHfSn/9WJJO1N4lyaQNmiUS
         eWQMh1pLq09JSJG3/F1gqWumqI0clWtF2WhCF8qpqn8lOUqJY790i4CNcrZwygFXGS0f
         u7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783110980; x=1783715780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2dOV6SNjFzG9X2tjzVk0oMjUqNu3RuI4o/7x3sDqaJQ=;
        b=l0aXECw4fiIKv6Uyf4EUalWCt3vlu+F5ZXoA23gqurqjSlBDtzD11hn6feLQRELCyp
         X/4J2reSgh0dujiPDxVGYEsHxwMSGgYz+dfaaIXRHI9vfY7CIzDeG5QPTjp4Tmq5i9Jr
         LZreEyQcnwSRskZ/MJm/DFVfhV/9NgJR0bdD6jfC920ufrNhORw85KYfgmhAG1EpZchC
         6fUNbfSdPgS4/5vEmA3P8wVI7buAcUV/n8bIh3BaLOHqUXGB+eseM3kagbwTitNkmP/n
         OEcx3ROcsUItmbRasXlrtiMGO5q2mekDrrKBVDnmh/7teQg2kXbGTWhLYenU1OSKVTIC
         vVlQ==
X-Forwarded-Encrypted: i=1; AFNElJ/MdHqov+x9QPA8cPEi56Ysg50H9AtEwyDHUBfd8nxImjR2B9Da+lEuQNLd0R2g9kmi2lWRDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXrIksKlvqvBOZrI70cN4V0IXCOVKXhuGAGRxPvh7tKwz4DF88
	8i6S0FIemQXaJhzhQH4QB6QG+wsB/yviNqP9TGBZfxYkRQw6JYMQE7l5rJkPGMdpkJkkj7JeSH1
	joV9csQma/ROrVn7AXqSbSEG3onZt7dS0hGjTzYWsMuaXnP78N777NyA3ug==
X-Gm-Gg: AfdE7ckKdJUXQ6brR5VCAVyh8FYtfVJtnioq/xwnTAjTy9evL1FUlN6KbQTOo2CXj2U
	EdvOoF5PQdIPGpzh/7joU+CLvvjKKIFf6XTV3IqhI1ZStsB3PsRxs/qKQX3LfGU5Z41PskNXPHo
	eF4/aApSUHy3QT76eWNonlfuqnbu+hgiBJ6hYqADuhg1tvE88NipPacKzAqYbYF6DQG8s1k/itx
	+Pi9SlsnqD2EblSl/AHKWZVH3XkFoCPuCcaf2k4pisnuW3Kz+hMVMgL+jXRGiEqk0zhrmv/7koH
	DFaYK4Jcipynvn5/0hgi5hAaO7vzNO7H8d5IK1hazu8+J+72bCkaxlLLFDOv/jo5exhG5btUlXu
	QR/uyLAnIOgpDctdoog2VhnqmhkB7jtXsPUM=
X-Received: by 2002:a05:6a21:2983:b0:3bf:aa1a:d303 with SMTP id adf61e73a8af0-3c03e5941eemr781897637.49.1783110979710;
        Fri, 03 Jul 2026 13:36:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:2983:b0:3bf:aa1a:d303 with SMTP id adf61e73a8af0-3c03e5941eemr781871637.49.1783110979257;
        Fri, 03 Jul 2026 13:36:19 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7b9a8asm24815567eec.2.2026.07.03.13.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 13:36:18 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 04 Jul 2026 02:04:33 +0530
Subject: [PATCH v4 7/9] arm64: dts: qcom: shikra-cqm-evk: Enable A704 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-shikra-gpu-v4-7-90cf1a52e539@oss.qualcomm.com>
References: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
In-Reply-To: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Aditya Sherawat <asherawa@qti.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783110907; l=894;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=sXVW7HyYn+zboxV3uVHhdySY2TiXHDOOKyfpwcYtiUI=;
 b=wYeDLz1Q3es0EoxTF9BBwaEzt+JV7f7Dw9TzAL+RcikJnuzjboL+RivQ+2cjiKzDhlI1C6Fhp
 /ea/aVQfkA4BAyda+/hRZFvmLi52/KE7U9JGNJ4rGuOGiA+uglghbOd
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfXxWB546NEMX4S
 ySVMMFj3A/J5luLSznSvHk1+CPqC5rLws6k8nmDI8mBxF8u3xcLewEU2VoE3CNShTuExfBx42Ab
 9QxSNkOkhP2/hkGJNTVBBLOqTAV2jOo=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a481d44 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=JW4bpjJLMT2bmMDKeKQA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: 1XAk19rq2lpP7flXjZ3to2on9_eA76Ur
X-Proofpoint-GUID: 1XAk19rq2lpP7flXjZ3to2on9_eA76Ur
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfXwwv8pbzeRtIM
 TvjLkmx9F7WA5gz8/xXUYdDSzupCB8Yzgtn5RDglS3k8Sy/xUUiTj3vojpWVTpo8Kh4YSexK/in
 bCT87YJEHOPp34wVonJgfhVwjEXBAYpiwVlkZ0bgE+OF0AkmOJpmDPTvmWIZw0JEq4Lt417Qi0y
 p88WBuOAWTmb4Mankakqu1EUyA1Cu/7BvdMwF/QYV0p4DUOlru/G6ZQaA3ftSv8D1t8qzA/0/Dr
 377xLXSpwtXdsZsEfW6TLzVMt5sxTBR0lg1aLtOl8hiAv4cWTHgNmCce6RPsos0xice3bQ8WCkE
 kKuWdmSJqcOPGCl2O+lujWytxe+a2v17j0BqDt7pU6zOB+++i/DBC1UZE8C2v1RaAg1v4s7w0SR
 RJYFxjbINSGeJGAfBIEK02tkhyc+jpOjm7v9NlS7sLbwwb9GAY9C3GPdm5YkFXLH6DCWbPKvF8z
 nv9i7c28Pnuv1F5eVug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030208

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Enable the A704 GPU and configure its zap-shader firmware on the
Shikra CQM EVK board.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index 269e11bd44f6..8206dddcfc75 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
@@ -50,6 +50,14 @@ &remoteproc_mpss {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/shikra/a704_zap.mbn";
+};
+
 &sdhc_1 {
 	vmmc-supply = <&pm4125_l20>;
 	vqmmc-supply = <&pm4125_l14>;

-- 
2.54.0

